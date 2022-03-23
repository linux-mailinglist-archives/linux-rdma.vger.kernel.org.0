Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D74E4CCA
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Mar 2022 07:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiCWGhN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Mar 2022 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCWGhM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Mar 2022 02:37:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD83071A29
        for <linux-rdma@vger.kernel.org>; Tue, 22 Mar 2022 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648017343; x=1679553343;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OeNxDCwzaBkQBpK4BlaLyr6IE871Yk4zkb3tlMqMnKo=;
  b=lTuw6ujuaiX/m+0y6CpodWCqYuh7LKfPy3uLlPBRy64JvLhdg8hbqobQ
   X84B7a9BreuT0TyU3xsenCM/JEVk4EXvxeAJlQFDXPoCNJJ6qqxbaF60V
   75uUrsrV/WlJ506qUb/Ap6UWC69K5hgUop3gn2frhxJhV34i4pakc/Rhx
   KVW6lc3049f/oXVlfRPBz0tO0ON9rJnx942okacP+Wk6rV6V4V39tD4Oc
   JhJVQV3U8tSbJo8CybfciXT+Pwg6uvpCG0E74K8OqZq3CSUBBtEhqi+pR
   2SnKc7wf0RRhj/x5w2s6VtyC7rqJqolyrAS0mpZuWduuATh1Mf2dtsbc8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="257749981"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="257749981"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 23:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="649315290"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2022 23:35:41 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/irdma: Remove the redundant variable
Date:   Wed, 23 Mar 2022 19:01:35 -0400
Message-Id: <20220323230135.291813-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the function irdma_puda_get_next_send_wqe, the variable wqe
is not necessary. So remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/puda.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 58e7d875643b..91aea3198edb 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -193,7 +193,6 @@ static void irdma_puda_dele_buf(struct irdma_sc_dev *dev,
 static __le64 *irdma_puda_get_next_send_wqe(struct irdma_qp_uk *qp,
 					    u32 *wqe_idx)
 {
-	__le64 *wqe = NULL;
 	enum irdma_status_code ret_code = 0;
 
 	*wqe_idx = IRDMA_RING_CURRENT_HEAD(qp->sq_ring);
@@ -201,11 +200,9 @@ static __le64 *irdma_puda_get_next_send_wqe(struct irdma_qp_uk *qp,
 		qp->swqe_polarity = !qp->swqe_polarity;
 	IRDMA_RING_MOVE_HEAD(qp->sq_ring, ret_code);
 	if (ret_code)
-		return wqe;
-
-	wqe = qp->sq_base[*wqe_idx].elem;
+		return NULL;
 
-	return wqe;
+	return qp->sq_base[*wqe_idx].elem;
 }
 
 /**
-- 
2.27.0

