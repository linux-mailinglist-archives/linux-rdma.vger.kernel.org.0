Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2D45EDF9
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377477AbhKZMiY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhKZMgW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:36:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E70C08EA6C;
        Fri, 26 Nov 2021 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aQAe4eMPPySy8vIxEl+CCv5r89gANpG908vFhfZszbA=; b=VQNzi5UtQVnrpXA9UEc4INe4KD
        AAh2zjPtaV4I822UPkJASwWGs6cQPcf1zwQ0oL8jSIPfss9a6x/fvToSNMOtXkfpUCFiaVgKSOwlB
        oqmg/zHGffHLFR6LXLlEtcWmfqTpeI15SQiJl9NMHkAEVLdi9UP4rH4iqx9qwtxRtFCDUTGP6Kqwx
        X7Ol1zUjxCXp5ZQVhL0Gtqg7bzCU9bwXP9kBJH8tNsglUsTNICCvK9MA5xQSZnhX+YrHC5NxJdMw2
        Sik2wl0GNGfKHxauPrFTwdby9Si5pHquq8zhs6kYcrgm228Xg5uUp5M4fJQ0+IdqLR8lcy12ge1nZ
        vtq0cSew==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZrw-00ASHH-IG; Fri, 26 Nov 2021 11:58:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 01/14] RDMA/qib: rename copy_io to qib_copy_io
Date:   Fri, 26 Nov 2021 12:58:04 +0100
Message-Id: <20211126115817.2087431-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the proper module prefix to avoid conflicts with a function
in the scheduler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/hw/qib/qib_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index ef91bff5c23ca..0080f0be72fef 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -425,7 +425,7 @@ static inline u32 clear_upper_bytes(u32 data, u32 n, u32 off)
 }
 #endif
 
-static void copy_io(u32 __iomem *piobuf, struct rvt_sge_state *ss,
+static void qib_copy_io(u32 __iomem *piobuf, struct rvt_sge_state *ss,
 		    u32 length, unsigned flush_wc)
 {
 	u32 extra = 0;
@@ -975,7 +975,7 @@ static int qib_verbs_send_pio(struct rvt_qp *qp, struct ib_header *ibhdr,
 			qib_pio_copy(piobuf, addr, dwords);
 		goto done;
 	}
-	copy_io(piobuf, ss, len, flush_wc);
+	qib_copy_io(piobuf, ss, len, flush_wc);
 done:
 	if (dd->flags & QIB_USE_SPCL_TRIG) {
 		u32 spcl_off = (pbufn >= dd->piobcnt2k) ? 2047 : 1023;
-- 
2.30.2

