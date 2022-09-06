Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A411A5AF803
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIFWdJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIFWdI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 18:33:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3313A8B2C7
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662503588; x=1694039588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fsnPFcfjS+nj5CH4sTubBqoPvoeJN6V38BsBGsi3dzI=;
  b=Bihbc+MyotvpPPMEbG3yfanKkEB4zdIG1DEbBn7AG1Cj9/I4zqHOJPY4
   7w9KYL7F59RSfBZIYMjUvJ0mLD19y50y2WVFhGQtINN7RZuZmrPzXM9sY
   ef16zKYIIVRqLuubIDpSEqXW19D/iCfqi9f6WvPLFt9CkQXuY06V6Fz1J
   7j4lmdULPl5gEXWMZI7+sr1pgIdJ+yAlyJaZDepKqvusm+LFJwMwGbxfH
   uyYSgs/N5bRaKPTzd/h1hyRmGVT21IWT2o/fXgFXH3oJti3sgyzCMZy7N
   Nh+sR7kdhCFNhfD+ivZuf5uNsIZ9cbhk2TcgPOzvixhJArqxvr5VAjI/K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296724563"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296724563"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675898219"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:07 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu-Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 1/5] RDMA/irdma: Report the correct max cqes from query device
Date:   Tue,  6 Sep 2022 17:32:40 -0500
Message-Id: <20220906223244.1119-2-shiraz.saleem@intel.com>
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

Report the correct max cqes available to an application taking
into account a reserved entry to detect overflow.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Sindhu-Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9b07b8a..f272a32 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -39,7 +39,7 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->max_send_sge = hw_attrs->uk_attrs.max_hw_wq_frags;
 	props->max_recv_sge = hw_attrs->uk_attrs.max_hw_wq_frags;
 	props->max_cq = rf->max_cq - rf->used_cqs;
-	props->max_cqe = rf->max_cqe;
+	props->max_cqe = rf->max_cqe - 1;
 	props->max_mr = rf->max_mr - rf->used_mrs;
 	props->max_mw = props->max_mr;
 	props->max_pd = rf->max_pd - rf->used_pds;
-- 
1.8.3.1

