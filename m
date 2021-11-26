Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2B45EE0B
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377531AbhKZMiq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbhKZMgq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:36:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D30AC08EA71;
        Fri, 26 Nov 2021 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sK7cYKiS0ZeDgTJQcBOYJUCVPKi7GjzADEXG7w+vkFA=; b=jpj9W9dva4hbxt1LE7FoGKeilD
        nKJf93/e408eCDoxSMPX4YuQpBaKtKuhDledbgkJVAeeHTOlzFBnuaW0WA36QlF2NwwBct8Fpu3pW
        vFbhCCdaxrmxMBLIxcDqZdJ7CwBncvJ2K1JO/xWGMTBDggfAaVltos/1wlEwQVTrJ7DgJgNoSQHhX
        pCgSe7CBVr3lpxKcVoAUjwKyQvyEnoeKeJe3fAq6fbrvad5BDDCLAbQBGpaU4J+StTxK6NLfDsXUw
        NNz94o/a8eMqlgR13H6R82ee5DdAW1eeQRg2GumuvohapvQGZlsePyncmqPxrPXhlO1zl4iwxHnmu
        ENoTpK4w==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs0-00ASIN-Gx; Fri, 26 Nov 2021 11:58:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 04/14] bfq: use bfq_bic_lookup in bfq_limit_depth
Date:   Fri, 26 Nov 2021 12:58:07 +0100
Message-Id: <20211126115817.2087431-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No need to create a new I/O context if there is none present yet in
->limit_depth.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c990c6409c119..ecc2e57e68630 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -663,7 +663,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
-	struct bfq_io_cq *bic = icq_to_bic(blk_mq_sched_get_icq(data->q));
+	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
 	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(op)) : NULL;
 	int depth;
 	unsigned limit = data->q->nr_requests;
-- 
2.30.2

