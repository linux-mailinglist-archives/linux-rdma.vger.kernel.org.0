Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55D45EE22
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377259AbhKZMjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhKZMh3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BAC08EAE8;
        Fri, 26 Nov 2021 03:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H7FEXl9MZgmEtU6V92VxqIMPFtemYzuFK5Tr4nLAwe0=; b=M8P09Stm7lyegv9a5lskPOwcUt
        /efI18zri/4O2JqAV5riXD4mDWJqBgKF9c6u4n8fqEkUG21ZwxA2GvI8AJeShtLlYZyCHIy+dA5PI
        RIRnprLmY+64vwfgEq6VDJU9Oqjga/FLxzTGBFv3UH6QpYb4MI6WKdBY7BCYNPykfigdm/V3iAtEj
        IsVjtssWq71vAhNAvFC+X6B49NJ72/ugV8dIox973SZgxS2VGALOVeKtaHT0MEtudisraJuFWGOkI
        FMU7VWLNanRqAzC4Znb4tH5b4IpZfOib++EpQt0g2x65vLt4Kmp6jnn9+C+d0xpls2MuIKi1APhAV
        38gerq/Q==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZsC-00ASMQ-4e; Fri, 26 Nov 2021 11:58:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 13/14] block: simplify ioc_create_icq
Date:   Fri, 26 Nov 2021 12:58:16 +0100
Message-Id: <20211126115817.2087431-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the ioc and gfp_mask argument, which are hard coded by the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 5bfe810496fca..c56648f7cad47 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -389,9 +389,7 @@ EXPORT_SYMBOL(ioc_lookup_icq);
 
 /**
  * ioc_create_icq - create and link io_cq
- * @ioc: io_context of interest
  * @q: request_queue of interest
- * @gfp_mask: allocation mask
  *
  * Make sure io_cq linking @ioc and @q exists.  If icq doesn't exist, they
  * will be created using @gfp_mask.
@@ -399,19 +397,19 @@ EXPORT_SYMBOL(ioc_lookup_icq);
  * The caller is responsible for ensuring @ioc won't go away and @q is
  * alive and will stay alive until this function returns.
  */
-static struct io_cq *ioc_create_icq(struct io_context *ioc,
-		struct request_queue *q, gfp_t gfp_mask)
+static struct io_cq *ioc_create_icq(struct request_queue *q)
 {
+	struct io_context *ioc = current->io_context;
 	struct elevator_type *et = q->elevator->type;
 	struct io_cq *icq;
 
 	/* allocate stuff */
-	icq = kmem_cache_alloc_node(et->icq_cache, gfp_mask | __GFP_ZERO,
+	icq = kmem_cache_alloc_node(et->icq_cache, GFP_ATOMIC | __GFP_ZERO,
 				    q->node);
 	if (!icq)
 		return NULL;
 
-	if (radix_tree_maybe_preload(gfp_mask) < 0) {
+	if (radix_tree_maybe_preload(GFP_ATOMIC) < 0) {
 		kmem_cache_free(et->icq_cache, icq);
 		return NULL;
 	}
@@ -461,7 +459,7 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
 	}
 
 	if (!icq) {
-		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
+		icq = ioc_create_icq(q);
 		if (!icq) {
 			put_io_context(ioc);
 			return NULL;
-- 
2.30.2

