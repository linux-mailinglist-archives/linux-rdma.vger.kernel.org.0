Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1177A567A85
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiGEXI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiGEXI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C53BB0
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062505; x=1688598505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5uyoWXeZav+Uzlnbhnn+RbzKUufhV7T8lCW28/W/o0=;
  b=YJP7EEnZ0seAAL+5++Aqb9gYgWf1Fuspv4f+kaAahRfnotWNwvqKsaH3
   kLqpzOc5qXZfdwUVJVOE5IokAYqEkia+fq0SBGDrGlHLp3CCBcKm6Ofv0
   J2au7JfxGw9PqKyndPu8LIIF74hoNAhiW3nLYQA0QQHkemzMk0Da7WPh/
   WR6M97hkwmwcsFhhENJePAkpuWIE9HLnrGgHwfOn74pTpIxjgzliQnNdX
   EQVrkMq6Z5x9vyWy+cEkaPAL5tLtmjwYe5zHDrCRc7dGW5DIQnqvQ5cgo
   014BASDGNM6xC6BO218RHiQNV9hDrjSY76daBgq6/HZwU+0kdrpNshPUB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588415"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047529"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:24 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 3/7] RDMA/irdma: Make CQP invalid state error non-critical
Date:   Tue,  5 Jul 2022 18:08:11 -0500
Message-Id: <20220705230815.265-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220705230815.265-1-shiraz.saleem@intel.com>
References: <20220705230815.265-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

The invalid state error returned by the Control Queue-Pair (CQP) is not a
critical error.

Add it to the irdma_noncrit_err_list and drop reporting it as device error
message.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index ab3c520..fdf4cc8 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -652,6 +652,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 };
 
 static const struct irdma_cqp_err_info irdma_noncrit_err_list[] = {
+	{0xffff, 0x8002, "Invalid State"},
 	{0xffff, 0x8006, "Flush No Wqe Pending"},
 	{0xffff, 0x8007, "Modify QP Bad Close"},
 	{0xffff, 0x8009, "LLP Closed"},
-- 
1.8.3.1

