Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0935B6344BE
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 20:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiKVTkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 14:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiKVTkN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 14:40:13 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895FA13D1
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 11:40:12 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id x21so11066048qkj.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p05Pm9V0Mbht1NXh4GFh6hq6X+/ZvdYWx/YnfPZmXOo=;
        b=cnA/FSA3SCv5MMzemuJ1J2OirGai/CHUZz7+qqtpZEYsz02fKe2JKcxDZ9Fn5z9Xhh
         ohrfbsja3DlGsc1lmCkLos9e8S9aEtjNzBe7w+Sy+90LHmIBa0ENhrQkPoNRyekP+DPA
         NcJSf+ueg2R8HsYaBbp9TpZ0BOW0JmTUM2vfJ2HzDl6VQ4Sj8DML3RRi/uJ2oHct8wCF
         1Kp5H1Q96Fe6M0Th1xljDbEs51ICuwrG4WlRH1TS2zPR6x1RkgXFy4yPbcFFF9pDA5Sr
         mHwiSAZjJ9HlvMmbopyajLniFtYMnTnuwXhqtSDgwd5JW6DPruffsyWP2GuN0LTuWs/i
         Xivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p05Pm9V0Mbht1NXh4GFh6hq6X+/ZvdYWx/YnfPZmXOo=;
        b=63uJywao8d8tq5iFbE9hn2h/bS7k871B4+n9uxEFIq4BsBaPRrc2oVAi+Pgbye0Yun
         CWWlKTFw8dkzbF2W40S6AEteDHIsADqICBNaUmT00CanNP90vAD+w/fjSLJXQFlmwmXq
         sAxeCsNSCmNUne2dqnPTeyOx/NwpzvwzjN0HrnrKhRCYSEmaFSUVCsh/932dABmKFLYT
         kA84kZfQmUUg+mLDqjVqLwD38MbR0AXRN4NzuqBzwjzHeEhCXfsplF1LED322GnXkF2s
         osh9EALZWS4EAAD8ENSNGC/Lv5Aovb77zM5rjxrAriINyj6jUIljej30QX0rjgAhNgV/
         SFiA==
X-Gm-Message-State: ANoB5plyqvt841kcJzQB1SYwNEUGCx7h4k86mc6WAPnVBLmIzAsy/bkO
        AHFhsNDDHjXYMVxxdiIm+qMKEQ==
X-Google-Smtp-Source: AA0mqf41ghrnWtTl2UrPLsHJgzvDtMCbh9bFQ4rrvSCNyJC2rBmyGL88T7Q/Nlb80ETVN5L8CQQGeA==
X-Received: by 2002:a05:620a:1353:b0:6fa:470:7ee4 with SMTP id c19-20020a05620a135300b006fa04707ee4mr22236540qkl.153.1669146011383;
        Tue, 22 Nov 2022 11:40:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id n10-20020a05620a294a00b006b640efe6dasm10724328qkp.132.2022.11.22.11.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:40:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxZ7q-009z8h-6p;
        Tue, 22 Nov 2022 15:40:10 -0400
Date:   Tue, 22 Nov 2022 15:40:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <error27@gmail.com>
Cc:     rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mr.c
Message-ID: <Y30lmg47StqtJYPL@ziepe.ca>
References: <Y3eeJW0AdyJYhYyQ@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3eeJW0AdyJYhYyQ@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 18, 2022 at 06:00:53PM +0300, Dan Carpenter wrote:
> Hello Bob Pearson,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 2778b72b1df0: "RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in 
> rxe_mr.c" from Nov 3, 2022, leads to the following Smatch complaint:
> 
>     drivers/infiniband/sw/rxe/rxe_mr.c:527 rxe_invalidate_mr()
>     error: we previously assumed 'mr' could be null (see line 526)
> 
> drivers/infiniband/sw/rxe/rxe_mr.c
>    525		mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
>    526		if (!mr) {
>                     ^^^
> "mr" is NULL.
> 
>    527			rxe_dbg_mr(mr, "No MR for key %#x\n", key);
>                                    ^^
> Dereference.
> 
>    528			ret = -EINVAL;
>    529			goto err;

I fixed it with this:

From 70c06ea1b57344599230e63d8fe5892f41c94116 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Tue, 22 Nov 2022 15:37:39 -0400
Subject: [PATCH] RDMA/rxe: Do not NULL deref on debugging failure path

Correct the mistake, mr is obviously NULL in this code path.

Fixes: 2778b72b1df0 ("RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mr.c")
Link: https://lore.kernel.org/r/Y3eeJW0AdyJYhYyQ@kili
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b1423000e4bcda..b7c9ff1ddf0e14 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -519,7 +519,7 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 
 	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
 	if (!mr) {
-		rxe_dbg_mr(mr, "No MR for key %#x\n", key);
+		rxe_dbg_qp(qp, "No MR for key %#x\n", key);
 		ret = -EINVAL;
 		goto err;
 	}
-- 
2.38.1

