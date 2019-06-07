Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C338264
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 03:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfFGB3Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 21:29:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGB3Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 21:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Tnu2w88r2Wsr1gVBC/+k0Ht7BIugEAnn7bgyFEtnAg=; b=ZVtw/07ZzaKlmoUzquUHsG+ya
        mby8lrKhzLOoVVChsTcvhe0Cy2KlRRMJ/rBvTslG1BxSLV5lj353ajSUF9B7sxZPb8WQSNwXzByrS
        G8fAccflUpr8ur6ftP382GaVVsr59SysBTtzjLs6x6YIUpdmJ8hIGaTJei18NaVryxudxHvLuAuND
        uSCjcdA8nUTQBrN3lS8gjhfs/WLpS6ZgIGXmYl0iPsywMLKu5DX9+XVsroeBdndEKZveiQbaQGkr7
        i84PRLZ1EOxLbLh3j8PEIA6IwHfCkKtwt1ZzFWMBD4M1k63+cvf2XpPR1He9pGEAXHlCEFDSNpANR
        kaO0pCXEg==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZ3gx-0006Zg-EH; Fri, 07 Jun 2019 01:29:15 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] iser: explicitly set shost max_segment_size if non virtual boundary devices
Date:   Thu,  6 Jun 2019 18:29:14 -0700
Message-Id: <20190607012914.2328-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

if the rdma device supports sg gaps, we don't need to set a virtual
boundary but we then need to explicitly set the max_segment_size, otherwise
scsi takes BLK_MAX_SEGMENT_SIZE and sets it using dma_set_max_seg_size()
and this affects all the rdma device consumers.

Fix it by setting shost max_segment_size according to the device
capability if SG_GAPS are not supported.

Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- set max_segment_size only for non virtual boundary devices

 drivers/infiniband/ulp/iser/iscsi_iser.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 841b66397a57..a3a4b956bbb9 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -653,7 +653,9 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
 						   SHOST_DIX_GUARD_CRC);
 		}
 
-		if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
+		if (ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
+			shost->max_segment_size = ib_dma_max_seg_size(ib_dev);
+		else
 			shost->virt_boundary_mask = ~MASK_4K;
 
 		if (iscsi_host_add(shost, ib_dev->dev.parent)) {
-- 
2.17.1

