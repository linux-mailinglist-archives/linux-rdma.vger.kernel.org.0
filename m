Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57485AF806
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIFWdM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Sep 2022 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIFWdK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Sep 2022 18:33:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A938B2C7
        for <linux-rdma@vger.kernel.org>; Tue,  6 Sep 2022 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662503590; x=1694039590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJDLgcZTSXWsaEUxD/QOt8U3DY/BmsHnKmBxRKVeOgQ=;
  b=PeoaKhgpDDk/jn8w501dHQb9YCp3HR/lBWYzvxhZh8prVukNeIp77h4K
   ZLFcveXQNO8iqFDdG5W34MpVaO7t0r73I2jhMCYVyPofb+fW6HC15FA0Z
   ywpmy/HGibr//RVJ4AZC6K/53yUr9Vw9iA+bLZyqxwPjJwO0Qcino6rbi
   EzcetmEG+YieEQuz0VbhPVh/mfIR1XNiVzFYeglIlAuLzhsTSreyRMFaI
   XhWoxe8T+HLC40OHERjvfCR+0dQWe3EAQVWXcQ1mjWIasZ6aNs6mxxgI/
   jU9ReSWrtbOa++P7xY0eTZT7D7qJxlvoqbgeldJrp40iIO3WPAvLXNjCs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296724581"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296724581"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675898246"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 15:33:09 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu-Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 4/5] RDMA/irdma: Use s/g array in post send only when its valid
Date:   Tue,  6 Sep 2022 17:32:43 -0500
Message-Id: <20220906223244.1119-5-shiraz.saleem@intel.com>
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

Send with invalidate verb call can pass in an
uninitialized s/g array with 0 sge's which is
filled into irdma WQE and causes a HW asynchronous
event.

Fix this by using the s/g array in irdma post send
only when its valid.

Fixes: 551c46e ("RDMA/irdma: Add user/kernel shared libraries")
Signed-off-by: Sindhu-Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index d003ad8..a6e5d35 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -497,7 +497,8 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 			      FIELD_PREP(IRDMAQPSQ_IMMDATA, info->imm_data));
 		i = 0;
 	} else {
-		qp->wqe_ops.iw_set_fragment(wqe, 0, op_info->sg_list,
+		qp->wqe_ops.iw_set_fragment(wqe, 0,
+					    frag_cnt ? op_info->sg_list : NULL,
 					    qp->swqe_polarity);
 		i = 1;
 	}
-- 
1.8.3.1

