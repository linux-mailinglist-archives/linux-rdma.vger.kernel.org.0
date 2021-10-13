Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A0A42C722
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhJMRCC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 13:02:02 -0400
Received: from ale.deltatee.com ([204.191.154.188]:44928 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhJMRCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 13:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=tbPvbDzsZtbOGJDbhM8sXn4yknGSvZ1Pz9705wkhiMo=; b=Gg9q5h0QFSZKRXndWPZYqcqoMz
        QHOSMHc3c5gwvsl9T0cBPKYQSRYHlOj6y39lhIxvG7SChy1KLAXbCSw4rUdfaAoSRsAOP6aIw4rZn
        uC1gaWMuFHbxWs+tP8EzEMBanLfiRTd8xdlVT+ePyLRq2Sz1CNTILOOrqeE3pET7V8ogd9NwGv4mu
        MA0uzD585kqpnPBK2iFv3BRAerpaOHeRFmjD411IOZiFa7R+Udg42SgDcfTdg4/YSYeUNgSaZHjuY
        oTljd/5gsGG/5IeA8JBBLWY+rVOoC6TqjlzKo3RX7VOTFvngoPBt/cTFCGHUuOyFhmvWqY7hvpNZ1
        RX89G+WA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mahbg-0000yP-Uu; Wed, 13 Oct 2021 10:59:57 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mahbf-000NNH-VT; Wed, 13 Oct 2021 10:59:56 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bart Van Assche <bvanassche@acm.org>
Date:   Wed, 13 Oct 2021 10:59:42 -0600
Message-Id: <20211013165942.89806-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, dledford@redhat.com, logang@deltatee.com, bvanassche@acm.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH] RDMA/core: Set sgtable nents when using ib_dma_virt_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_dma_map_sgtable_attrs() should be mapping the sgls and setting nents
but the ib_uses_virt_dma() path falls back to ib_dma_virt_map_sg()
which will not set the nents in the sgtable.

Check the return value (per the map_sg calling convention) and set
sgt->nents appropriately on success.

Link: https://lore.kernel.org/all/996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org/T/#u
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Bart Van Assche <bvanassche@acm.org>
---
 include/rdma/ib_verbs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4b50d9a3018a..4ba642fc8a19 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4097,8 +4097,13 @@ static inline int ib_dma_map_sgtable_attrs(struct ib_device *dev,
 					   enum dma_data_direction direction,
 					   unsigned long dma_attrs)
 {
+	int nents;
+
 	if (ib_uses_virt_dma(dev)) {
-		ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+		nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+		if (!nents)
+			return -EIO;
+		sgt->nents = nents;
 		return 0;
 	}
 	return dma_map_sgtable(dev->dma_device, sgt, direction, dma_attrs);

base-commit: 2a152512a155aaf27c3e67834ffafaed9525a7b5
-- 
2.30.2

