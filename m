Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D067F2FAD61
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbhARWlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388883AbhARWk4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:40:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A48C0613D3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v184so10832080wma.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03PX32GpkZFeqKLT+BSfdocA6g5Zox/rBREnRYBnkyU=;
        b=nOYfyKBkyVqRw+ngdr49tGYEqowAqRUTVdMJ5ZlgJkf09UuaDzKcbYbfpwOPRtQvCR
         0N3WFMeU/HrAk4ThBZFiWWyfj+cuTcHVBfwpNX7ixpPs6mjN4rgWjP3vD+XmXq+Aex3F
         eiYSgNxZNQnbXcVdwDCXU/Eue6MGibK2r2o0WMBwEhOPYuE9Sb4vMDvbtfaF48QF6oru
         M3KHJY/3RfINSrJxmT+aguCuImG8lGPuV5E9LUG8OiteJ3l/vA0IHNyrpG+UTOYQ7nTE
         rRCwI1/5TiZaLk/PTVzBCDHAdqTP4UW2pZuLYrk6FbgVLHdE7fL9Y7Bqpr63IhxLZX4s
         LTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03PX32GpkZFeqKLT+BSfdocA6g5Zox/rBREnRYBnkyU=;
        b=liqpszjZ9WPErvoewT7D6sBeyLCMQq7XkoP+MyQwggbrKdRI6KnzngotkX9fDIPLbv
         OIF4oJik99R4ucrGljAP+FfWytyO12JbLQX2mZrXJiNDjf64PasXN/r5aMikrAtpeaxa
         pyIc1I0lKwXJzM/AI2fqMMbyfOe548x+Ziqgr9oI2uzLAsi3wZ1U2LU5vXnQ6A2hvpbh
         5vTh3wBgSujewhndpOnciWYlMs8SNjEmgqdmi8mDvLvR+kNMrXjc6g4Js7uGAg9cP+On
         VVlLdZYgO0TK3/h9kTLb8ssdHQGCNOqcEwNUkjfrQOGEXOwwEfW/+aejiKsMfdqbUx28
         Ne5A==
X-Gm-Message-State: AOAM531udoB/uhFiZ8fEv6Xtm7xdIBGfQgsOmrcaaPHD/qaFexEOGEBF
        688GTykYxgCA3wOABePM7X2PXw==
X-Google-Smtp-Source: ABdhPJzLSKJxF9qwsXu0/mp+lIyn4CFH2RNvpTazov2Py95UJ+sRH0dWdXWCKm88qErZ4h6Gmw0m0A==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr1225842wmj.17.1611009576534;
        Mon, 18 Jan 2021 14:39:36 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 03/20] RDMA/hw/i40iw/i40iw_ctrl: Fix a bunch of misspellings and formatting issues
Date:   Mon, 18 Jan 2021 22:39:12 +0000
Message-Id: <20210118223929.512175-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:193: warning: Function parameter or member 'obj_info' not described in 'i40iw_sc_decode_fpm_query'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:193: warning: Excess function parameter 'info' description in 'i40iw_sc_decode_fpm_query'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:218: warning: Function parameter or member 'hmc_info' not described in 'i40iw_sc_parse_fpm_query_buf'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:218: warning: Excess function parameter 'info' description in 'i40iw_sc_parse_fpm_query_buf'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:784: warning: Function parameter or member 'compl_info' not described in 'i40iw_sc_poll_for_cqp_op_done'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:784: warning: Excess function parameter 'info' description in 'i40iw_sc_poll_for_cqp_op_done'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:947: warning: Function parameter or member 'commit_fpm_mem' not described in 'i40iw_sc_commit_fpm_values'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:1032: warning: Function parameter or member 'dev' not described in 'i40iw_get_rdma_features'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:1468: warning: Function parameter or member 'ignore_ref_count' not described in 'i40iw_sc_del_local_mac_ipaddr_entry'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:2314: warning: Function parameter or member 'scratch' not described in 'i40iw_sc_cq_modify'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:3682: warning: Function parameter or member 'info' not described in 'cqp_sds_wqe_fill'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:4894: warning: Function parameter or member 'stats' not described in 'i40iw_hw_stats_read_32'
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c:4894: warning: Excess function parameter 'stat' description in 'i40iw_hw_stats_read_32'

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index c943d491b72bd..eaea5d545eb8c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -181,7 +181,7 @@ static enum i40iw_status_code i40iw_sc_parse_fpm_commit_buf(
  * i40iw_sc_decode_fpm_query() - Decode a 64 bit value into max count and size
  * @buf: ptr to fpm query buffer
  * @buf_idx: index into buf
- * @info: ptr to i40iw_hmc_obj_info struct
+ * @obj_info: ptr to i40iw_hmc_obj_info struct
  * @rsrc_idx: resource index into info
  *
  * Decode a 64 bit value from fpm query buffer into max count and size
@@ -205,7 +205,7 @@ static u64 i40iw_sc_decode_fpm_query(u64 *buf,
 /**
  * i40iw_sc_parse_fpm_query_buf() - parses fpm query buffer
  * @buf: ptr to fpm query buffer
- * @info: ptr to i40iw_hmc_obj_info struct
+ * @hmc_info: ptr to i40iw_hmc_obj_info struct
  * @hmc_fpm_misc: ptr to fpm data
  *
  * parses fpm query buffer and copy max_cnt and
@@ -775,7 +775,7 @@ static enum i40iw_status_code i40iw_sc_ccq_get_cqe_info(
  * i40iw_sc_poll_for_cqp_op_done - Waits for last write to complete in CQP SQ
  * @cqp: struct for cqp hw
  * @op_code: cqp opcode for completion
- * @info: completion q entry to return
+ * @compl_info: completion q entry to return
  */
 static enum i40iw_status_code i40iw_sc_poll_for_cqp_op_done(
 					struct i40iw_sc_cqp *cqp,
@@ -933,7 +933,7 @@ static enum i40iw_status_code i40iw_sc_commit_fpm_values_done(struct i40iw_sc_cq
  * @cqp: struct for cqp hw
  * @scratch: u64 saved to be used during cqp completion
  * @hmc_fn_id: hmc function id
- * @commit_fpm_mem; Memory for fpm values
+ * @commit_fpm_mem: Memory for fpm values
  * @post_sq: flag for cqp db to ring
  * @wait_type: poll ccq or cqp registers for cqp completion
  */
@@ -1026,7 +1026,7 @@ i40iw_sc_query_rdma_features(struct i40iw_sc_cqp *cqp,
 
 /**
  * i40iw_get_rdma_features - get RDMA features
- * @dev - sc device struct
+ * @dev: sc device struct
  */
 enum i40iw_status_code i40iw_get_rdma_features(struct i40iw_sc_dev *dev)
 {
@@ -1456,7 +1456,7 @@ static enum i40iw_status_code i40iw_sc_add_local_mac_ipaddr_entry(
  * @cqp: struct for cqp hw
  * @scratch: u64 saved to be used during cqp completion
  * @entry_idx: index of mac entry
- * @ ignore_ref_count: to force mac adde delete
+ * @ignore_ref_count: to force mac adde delete
  * @post_sq: flag for cqp db to ring
  */
 static enum i40iw_status_code i40iw_sc_del_local_mac_ipaddr_entry(
@@ -2304,7 +2304,7 @@ static enum i40iw_status_code i40iw_sc_cq_destroy(struct i40iw_sc_cq *cq,
  * i40iw_sc_cq_modify - modify a Completion Queue
  * @cq: cq struct
  * @info: modification info struct
- * @scratch:
+ * @scratch: u64 saved to be used during cqp completion
  * @post_sq: flag to post to sq
  */
 static enum i40iw_status_code i40iw_sc_cq_modify(struct i40iw_sc_cq *cq,
@@ -3673,7 +3673,7 @@ static enum i40iw_status_code i40iw_sc_configure_iw_fpm(struct i40iw_sc_dev *dev
 /**
  * cqp_sds_wqe_fill - fill cqp wqe doe sd
  * @cqp: struct for cqp hw
- * @info; sd info for wqe
+ * @info: sd info for wqe
  * @scratch: u64 saved to be used during cqp completion
  */
 static enum i40iw_status_code cqp_sds_wqe_fill(struct i40iw_sc_cqp *cqp,
@@ -4884,7 +4884,7 @@ void i40iw_hw_stats_init(struct i40iw_vsi_pestat *stats, u8 fcn_idx, bool is_pf)
 
 /**
  * i40iw_hw_stats_read_32 - Read 32-bit HW stats counters and accommodates for roll-overs.
- * @stat: pestat struct
+ * @stats: pestat struct
  * @index: index in HW stats table which contains offset reg-addr
  * @value: hw stats value
  */
-- 
2.25.1

