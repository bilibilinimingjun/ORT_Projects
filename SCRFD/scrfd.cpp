#include "lite/lite.h"

static void test_lite()
{
    std::string onnx_path = "../scrfd_2.5g_bnkps_shape640x640.onnx";
    std::string test_img_path = "../test_lite_face_detector_2.jpg";
    std::string save_img_path = "../test_lite_scrfd.jpg";
    
    auto *scrfd = new lite::cv::face::detect::SCRFD(onnx_path);
		  
    std::vector<lite::types::BoxfWithLandmarks> detected_boxes;
    cv::Mat img_bgr = cv::imread(test_img_path);
    scrfd->detect(img_bgr, detected_boxes);
		        
    lite::utils::draw_boxes_with_landmarks_inplace(img_bgr, detected_boxes);
    cv::imwrite(save_img_path, img_bgr);
			    
    std::cout << "Default Version Done! Detected Face Num: " << detected_boxes.size() <<std::endl;
			      
    delete scrfd;
}

int main(__unused int argc, __unused char *argv[])
{
    test_lite();
    return 0;
}