Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464E87EB54B
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjKNRER (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Nov 2023 12:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjKNREQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Nov 2023 12:04:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B029DCB
        for <linux-rdma@vger.kernel.org>; Tue, 14 Nov 2023 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699981453; x=1731517453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IWDhZTTxuPlZHbBlirc64sknTpMUYk0X9GWf9FKtFNw=;
  b=BX07cNWa7nU6fgDDhU5wv1GiIq1kjfa0Yews7ogxwRo0r3Z+rwm4Gqa2
   UFOFhX/WL7b66JKiIsy57qXVI1Zu3uD9H8sQS3NsYUOmuGG3nwdG1k+ZP
   CnC+6thLjJd7/iLvQQDAwNcMLbbhp9VgTkeoAVd9ZPQfW5AWjf+RAtlhC
   ztn/N5Ca8MAsaSoKE6WrwWoU/NbLVK2Tm7u2vPp2SREKioPCwDKvA0LmV
   ntbllm1vCZOeZ9iR2GShnQylkCVK5uVXEkOYSj0H245tiFeaJpoDp4583
   HD9JxowFEjmcrW9HtIKKfR6fzsrD8aE/tdVzfj/556Jrm4eqIQtnCLoH6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394614912"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="394614912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 09:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908450230"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="908450230"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.179])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 09:03:15 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 1/2] RDMA/irdma: Do not modify to SQD on error
Date:   Tue, 14 Nov 2023 11:02:45 -0600
Message-Id: <20231114170246.238-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231114170246.238-1-shiraz.saleem@intel.com>
References: <20231114170246.238-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Remove the modify to SQD before going to ERROR state. It is not needed.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7c31d2d606bb..77a4a12a6493 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1426,13 +1426,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		case IB_QPS_SQE:
 		case IB_QPS_ERR:
 		case IB_QPS_RESET:
-			if (iwqp->iwarp_state == IRDMA_QP_STATE_RTS) {
-				spin_unlock_irqrestore(&iwqp->lock, flags);
-				info.next_iwarp_state = IRDMA_QP_STATE_SQD;
-				irdma_hw_modify_qp(iwdev, iwqp, &info, true);
-				spin_lock_irqsave(&iwqp->lock, flags);
-			}
-
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata && udata->inlen) {
-- 
1.8.3.1

