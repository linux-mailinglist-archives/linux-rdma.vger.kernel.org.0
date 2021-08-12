Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3303EA614
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Aug 2021 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhHLN4z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Aug 2021 09:56:55 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:44709 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhHLN4y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Aug 2021 09:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1628776590; x=1660312590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O5iDVRTgvh7MRMr1l1GvMKUtxhsk9zh4Kb0NR2Qyx9k=;
  b=i4ele6zYSTZjgEyTVjHRKrhReiuQTxdn5+4uN517WJ4oc7AbEx+1pv7p
   zItpv4IW/HjURmpu/llWBy2gn/ePgiJP3xXbPq9DasNZ+cx5WAlMul5/f
   6DTM+W3eK6RHmVEkYEv9I9B4r5ca+QV9iTpx98XeJM67XY8HLwBX8lWwi
   A=;
X-IronPort-AV: E=Sophos;i="5.84,316,1620691200"; 
   d="scan'208";a="141415987"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 12 Aug 2021 13:56:23 +0000
Received: from EX13D19EUA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id D639AA25BF;
        Thu, 12 Aug 2021 13:56:19 +0000 (UTC)
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D19EUA002.ant.amazon.com (10.43.165.247) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 12 Aug 2021 13:56:18 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.212.15) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Thu, 12 Aug 2021 13:56:15 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc] RDMA/uverbs: Track dmabuf memory regions
Date:   Thu, 12 Aug 2021 16:56:06 +0300
Message-ID: <20210812135607.6228-1-galpress@amazon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The dmabuf memory registrations are missing the restrack handling and
hence do not appear in rdma tool.

Fixes: bfe0cc6eb249 ("RDMA/uverbs: Add uverbs command for dma-buf based MR registration")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/uverbs_std_types_mr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index f782d5e1aa25..03e1db5d1e8c 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -249,6 +249,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_REG_DMABUF_MR)(
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
 
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
+	rdma_restrack_set_name(&mr->res, NULL);
+	rdma_restrack_add(&mr->res);
 	uobj->object = mr;
 
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DMABUF_MR_HANDLE);
-- 
2.32.0

