Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3023688D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 02:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFFACM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 20:02:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFACL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 20:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KtOdE5W3k8irgjJmxe4ijQ18pv8Z3Oex89AgrEYcHNw=; b=gcqpsYBtsgDMG6m0ykFodd0rS
        O65c+iGFY3AG12PYWNUdcV4NHgr7u2kMQut16jf0S5aKVz/JDE4bv2+M11pLVnZfjTF/hzCtVe8LS
        upJhCW4SHVfkW/m7dYQ5bv8cavuTfO3G58cJpQ9rRp2DePdfNLTLN3OfcvuBP6PH7R4j13TOGEIrM
        lHoZduhHNFQbjyoFkF90eT9yekGKYR8rutwPpTU2b4byzmO0OTDCEFuIUjUf+yjnuSmq7wZ/d7BuR
        1kO3yDDEsSfVivK2mdP6aZeGUqrySaEnDTGu6X/SnH2VC14VuQvRjEzxg3nQBbBsSveJhNVCcFRAy
        KGo8nnA1w==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYfr9-0001n2-BH; Thu, 06 Jun 2019 00:02:11 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] IB/iser: explicitly set shost max_segment_size
Date:   Wed,  5 Jun 2019 17:02:09 -0700
Message-Id: <20190606000209.26086-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

if the lld does not explicitly sets this, scsi takes BLK_MAX_SEGMENT_SIZE
and sets it using dma_set_max_seg_size(). In our case, this will affect
all the rdma device consumers.

Fix it by setting shost max_segment_size according to the device
capability.

Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
This goes on top of hch patchset:
"properly communicate queue limits to the DMA layer"

Normally this should go through the rdma tree, so we can
either get it through jens with hch patchset. Alternatively
this is a fix that should go to rc anyways?

 drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 56848232eb81..2984a366dd7d 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -653,6 +653,7 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
 						   SHOST_DIX_GUARD_CRC);
 		}
 
+		shost->max_segment_size = ib_dma_max_seg_size(ib_dev);
 		if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
 			shost->virt_boundary_mask = ~MASK_4K;
 
-- 
2.17.1

