Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505F045EE0F
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKZMi5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhKZMg5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:36:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC152C08EA73;
        Fri, 26 Nov 2021 03:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jYRVhHW2gVb5d5i1xf3+2qqpIhLx3KXODjLr4PtmDyE=; b=eCapykDDNWjfyVTdMYXtBOYKLv
        prgYEG325JO21OUPvNXInsoHWxwlwDFRS20CKdcVoNwJY7Wn70QOJ+1r6y9MEap/CPiTCutMV9TZA
        CG0XXhQwyub/VWp3SkEqZ/OAYA06KkJ2Nz4QfkUh0PBSIZmLK5sM5bpMx2L11/zk7eeIwhZfu4ZSJ
        jtv4jDGnPnxH/jGKpmDt1YTRibVqr3rBY/dl9A1sS36Iu6nXz3XO0m+uca/M5AtTqea7lbu4xhRp3
        wL/MW/0Qz7xH+7C/dUwxCKSOBkDNesfbsw9deu3xBC2vwldONP9n0QYz4dQcEqz8UAsohoGikjO/q
        I4uRiaGA==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs3-00ASJM-2j; Fri, 26 Nov 2021 11:58:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 06/14] block: mark put_io_context_active static
Date:   Fri, 26 Nov 2021 12:58:09 +0100
Message-Id: <20211126115817.2087431-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c           | 2 +-
 include/linux/iocontext.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 3b31cfad4b75b..f3ff495756cb4 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -175,7 +175,7 @@ void put_io_context(struct io_context *ioc)
  * Undo get_io_context_active().  If active reference reaches zero after
  * put, @ioc can never issue further IOs and ioscheds are notified.
  */
-void put_io_context_active(struct io_context *ioc)
+static void put_io_context_active(struct io_context *ioc)
 {
 	struct io_cq *icq;
 
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index bcd47d104d8e6..3ba45953d5228 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -132,7 +132,6 @@ static inline void get_io_context_active(struct io_context *ioc)
 struct task_struct;
 #ifdef CONFIG_BLOCK
 void put_io_context(struct io_context *ioc);
-void put_io_context_active(struct io_context *ioc);
 void exit_io_context(struct task_struct *task);
 struct io_context *get_task_io_context(struct task_struct *task,
 				       gfp_t gfp_flags, int node);
-- 
2.30.2

