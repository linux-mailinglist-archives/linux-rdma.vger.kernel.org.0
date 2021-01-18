Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAD2FAD66
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbhARWl0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbhARWlW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE1C0617A9
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y17so17908197wrr.10
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GzQUCY9gltxfn7wTWc0ySyU4Wa3SIVVQ4lvu3auZsiw=;
        b=ohaQkkPE5BgucSaroC8gEHqCxwBRDcrdwe4Cyh7fq924EvWjlTswVIVGtLhbkXgpsz
         ulUELXQeoxytr+p7G+zPjYmHGafVu3hjH56YiLJ2RpROKnP+GLir5xo25TO5zEaFdlcI
         MK5/3gqGS/gQyil6c1nGMndBqM6F7NgA+/ZvxeDi+hQizAXYIZj0XMY6qdx0ar6FTgPK
         Ewgd99Que7Bozg6S33+/gHuWP+TbuVB3MkfcpNrnDweVUSMTe9qo1ezj0t6wlWGDUj2L
         xkjaBTM1cqVVv4R7OMmQcXjgAwEFt0HGNHyoz4ijZ3hGjhH2enqCefN4ZjtvM8+zfKvU
         /BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GzQUCY9gltxfn7wTWc0ySyU4Wa3SIVVQ4lvu3auZsiw=;
        b=TxoYuV7XxqeT0JZn5AJmo26daaWgablOemse0mRS7kPw66sGlgTlcGF9ECQd6sjENM
         iTpRs3wTf2AL/VaNFD+ZQf+BUFvzfw7X1AbLgyNMD6IjmHaW1vw6tY1+yd0hQQplB3Fk
         uyiMPso7yfWWYmohNJWk925RmvNb2o/CyW0LTgHmkX+yuuDYtJQOn4SuQT3Lj70wXBXS
         CQeVfVNkNXOfk+Oqeuber9QgPYCW+rhFSnvb/nF1ZelaxSFgleP8Ar+EYS0XKL5A7cGM
         WUsH53lR13bJNHKaV++JKV8SSC4hA5Cl3IQvDmtiiyI7T9Goa8JiyiT389oNoZESLydE
         K+tA==
X-Gm-Message-State: AOAM532ErVhvhthzEQNof6a9deg4Q+4k+yGfwbn5WnkfdkG1z7uTrMHv
        61DAEjkRTDnNx5F8qs03NnGG3Q==
X-Google-Smtp-Source: ABdhPJx7Wy4kfxuvLtUzePjNlo6w8TVwAo44JXWCI23N5aeZOa8LhTrUBFImsyKhcczcOrnPyjQYAQ==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr1417506wrl.85.1611009588581;
        Mon, 18 Jan 2021 14:39:48 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 14/20] RDMA/hw/i40iw/i40iw_virtchnl: Fix a bunch of kernel-doc issues
Date:   Mon, 18 Jan 2021 22:39:23 +0000
Message-Id: <20210118223929.512175-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:132: warning: Function parameter or member 'rsrc_type' not described in 'vchnl_vf_send_add_hmc_objs_req'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:132: warning: Function parameter or member 'start_index' not described in 'vchnl_vf_send_add_hmc_objs_req'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:132: warning: Function parameter or member 'rsrc_count' not described in 'vchnl_vf_send_add_hmc_objs_req'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:170: warning: Function parameter or member 'rsrc_type' not described in 'vchnl_vf_send_del_hmc_objs_req'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:170: warning: Function parameter or member 'start_index' not described in 'vchnl_vf_send_del_hmc_objs_req'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:170: warning: Function parameter or member 'rsrc_count' not described in 'vchnl_vf_send_del_hmc_objs_req'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:230: warning: Function parameter or member 'hmc_fcn' not described in 'vchnl_pf_send_get_hmc_fcn_resp'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:283: warning: Function parameter or member 'op_ret_code' not described in 'vchnl_pf_send_error_resp'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:305: warning: Function parameter or member 'dev' not described in 'pf_cqp_get_hmc_fcn_callback'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:305: warning: Function parameter or member 'callback_param' not described in 'pf_cqp_get_hmc_fcn_callback'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:305: warning: Function parameter or member 'cqe_info' not described in 'pf_cqp_get_hmc_fcn_callback'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:305: warning: Excess function parameter 'cqp_req_param' description in 'pf_cqp_get_hmc_fcn_callback'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:305: warning: Excess function parameter 'not_used' description in 'pf_cqp_get_hmc_fcn_callback'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:337: warning: Function parameter or member 'work_vf_dev' not described in 'pf_add_hmc_obj_callback'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:337: warning: Excess function parameter 'vf_dev' description in 'pf_add_hmc_obj_callback'
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c:412: warning: Function parameter or member 'dev' not described in 'i40iw_vf_init_pestat'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c b/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c
index 48fd327f876b0..aca9061688ae0 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_virtchnl.c
@@ -119,7 +119,7 @@ static enum i40iw_status_code vchnl_vf_send_get_pe_stats_req(struct i40iw_sc_dev
 	return ret_code;
 }
 
-/**
+/*
  * vchnl_vf_send_add_hmc_objs_req - Add HMC objects
  * @dev: IWARP device pointer
  * @vchnl_req: Virtual channel message request pointer
@@ -158,9 +158,9 @@ static enum i40iw_status_code vchnl_vf_send_add_hmc_objs_req(struct i40iw_sc_dev
  * vchnl_vf_send_del_hmc_objs_req - del HMC objects
  * @dev: IWARP device pointer
  * @vchnl_req: Virtual channel message request pointer
- * @ rsrc_type - resource type to delete
- * @ start_index - starting index for resource
- * @ rsrc_count - number of resource type to delete
+ * @rsrc_type: resource type to delete
+ * @start_index: starting index for resource
+ * @rsrc_count: number of resource type to delete
  */
 static enum i40iw_status_code vchnl_vf_send_del_hmc_objs_req(struct i40iw_sc_dev *dev,
 							     struct i40iw_virtchnl_req *vchnl_req,
@@ -222,6 +222,7 @@ static void vchnl_pf_send_get_ver_resp(struct i40iw_sc_dev *dev,
  * @dev: IWARP device pointer
  * @vf_id: Virtual function ID associated with the message
  * @vchnl_msg: Virtual channel message buffer pointer
+ * @hmc_fcn: HMC function index pointer
  */
 static void vchnl_pf_send_get_hmc_fcn_resp(struct i40iw_sc_dev *dev,
 					   u32 vf_id,
@@ -276,6 +277,7 @@ static void vchnl_pf_send_get_pe_stats_resp(struct i40iw_sc_dev *dev,
  * @dev: IWARP device pointer
  * @vf_id: Virtual function ID associated with the message
  * @vchnl_msg: Virtual channel message buffer pointer
+ * @op_ret_code: I40IW_ERR_* status code
  */
 static void vchnl_pf_send_error_resp(struct i40iw_sc_dev *dev, u32 vf_id,
 				     struct i40iw_virtchnl_op_buf *vchnl_msg,
@@ -297,8 +299,9 @@ static void vchnl_pf_send_error_resp(struct i40iw_sc_dev *dev, u32 vf_id,
 
 /**
  * pf_cqp_get_hmc_fcn_callback - Callback for Get HMC Fcn
- * @cqp_req_param: CQP Request param value
- * @not_used: unused CQP callback parameter
+ * @dev: IWARP device pointer
+ * @callback_param: unused CQP callback parameter
+ * @cqe_info: CQE information pointer
  */
 static void pf_cqp_get_hmc_fcn_callback(struct i40iw_sc_dev *dev, void *callback_param,
 					struct i40iw_ccq_cqe_info *cqe_info)
@@ -331,7 +334,7 @@ static void pf_cqp_get_hmc_fcn_callback(struct i40iw_sc_dev *dev, void *callback
 
 /**
  * pf_add_hmc_obj - Callback for Add HMC Object
- * @vf_dev: pointer to the VF Device
+ * @work_vf_dev: pointer to the VF Device
  */
 static void pf_add_hmc_obj_callback(void *work_vf_dev)
 {
@@ -404,7 +407,7 @@ static void pf_del_hmc_obj_callback(void *work_vf_dev)
 
 /**
  * i40iw_vf_init_pestat - Initialize stats for VF
- * @devL pointer to the VF Device
+ * @dev: pointer to the VF Device
  * @stats: Statistics structure pointer
  * @index: Stats index
  */
-- 
2.25.1

