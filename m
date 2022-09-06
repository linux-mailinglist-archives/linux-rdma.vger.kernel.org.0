Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7055AF805
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIFWdL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIFWdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 18:33:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A48B2C7
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662503589; x=1694039589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h7MNDRjLxA8BoH9opd68f06ZtxWZYdxDXPrqtqDfDsE=;
  b=oFssC+lhfsUYnCvi4HgvgZ4sIjkFxJ6tgUc3D8jwuDy5gcHS053grtG3
   zhOkLTTjgAqqMyXgJYVzgASYhCd3R3mFAOdL0pMzSQCyUmBblIo1tEmyv
   T7NCSaxF2tsvM0nod4vResOwAhZLhuy3OXrF4OXrbnaEfpK5aneiWzgUn
   KiwHHbtHY4E2CgTVdR54K9nYhOqS7jCfHb/nQbAp1Q+Qd+Rdqb6SFcXXu
   +KCRIszbXpi3r1wggk6amT8h9qX+mtC5RBJVweBG9J4MbnN6gTcirX9Yj
   2hmoCokPA7AXM8DSAGu+qK3l+c+Mcdg+i3SfwA2RA0FtBVudQYROKUrRc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296724575"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296724575"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675898233"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:08 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu-Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 3/5] RDMA/irdma: Return correct WC error for bind operation failure
Date:   Tue,  6 Sep 2022 17:32:42 -0500
Message-Id: <20220906223244.1119-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220906223244.1119-1-shiraz.saleem@intel.com>
References: <20220906223244.1119-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu-Devale <sindhu.devale@intel.com>

When a QP and a MR on a local host are in different PDs, the HW generates
an asynchronous event (AE). The same AE is generated when a QP and a MW
are in different PDs during a bind operation. Return the more appropriate
IBV_WC_MW_BIND_ERR for the latter case by checking the OP type from the
CQE in error.

Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
Signed-off-by: Sindhu-Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index daeab5d..d003ad8 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1005,6 +1005,7 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	int ret_code;
 	bool move_cq_head = true;
 	u8 polarity;
+	u8 op_type;
 	bool ext_valid;
 	__le64 *ext_cqe;
 
@@ -1187,7 +1188,6 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 			do {
 				__le64 *sw_wqe;
 				u64 wqe_qword;
-				u8 op_type;
 				u32 tail;
 
 				tail = qp->sq_ring.tail;
@@ -1204,6 +1204,8 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 					break;
 				}
 			} while (1);
+			if (op_type == IRDMA_OP_TYPE_BIND_MW && info->minor_err == FLUSH_PROT_ERR)
+				info->minor_err = FLUSH_MW_BIND_ERR;
 			qp->sq_flush_seen = true;
 			if (!IRDMA_RING_MORE_WORK(qp->sq_ring))
 				qp->sq_flush_complete = true;
-- 
1.8.3.1

