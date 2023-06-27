Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1973F569
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jun 2023 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjF0HVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jun 2023 03:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjF0HVD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jun 2023 03:21:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99681FCD
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jun 2023 00:20:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3112f256941so3784589f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jun 2023 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687850419; x=1690442419;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpbFc/BG+CyKKaozDuevuxgUbDl+e9HPujVRRvG5228=;
        b=x0vflAkExT6kQ+CHgqC4F+Cd1ksDkwW/Jqk35VWMhUVVSlPqVX+kxR+L8IpzT41Olu
         UXzT9Hj2pWma8u/AGnRzUSSX9xcILk+xR5/Jp46W/Cv1iRIhJQZmVZ5316YgNEPelUHd
         HfYIK+/Xilhy+cgIPrMvzK983tOOnORvoUaxgwtjt1Izrlg5b5fMgCSz6UuHrkDAR+8M
         LAOj4PPIM0iHDlnD+qd4melKdEKX+RX/5qUZatH1UYL6sZZerTy0EYuAHefNdf+G+l0O
         KHqi4YWuPDl3GMCxpBXuak+W40VC8zlDR0TRUOEv0WgXoLAGr2APplfV1W1+fGFjpv3W
         h7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687850419; x=1690442419;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpbFc/BG+CyKKaozDuevuxgUbDl+e9HPujVRRvG5228=;
        b=i6m2EH7hoeaAxRCcmq2A5GvB/3ab4IKDHOQRM9UQur6KZt2JdBrERBZTfndrcKKBpY
         fOv31Pjg7Fvkh/tsvyyDRyxlhUwXSV8hfgiWylsy/AR/iUznQD8Ck82jo4MSa+FNxhNA
         qVxArfVz1rBQUtg3wiOoEJwfRXZN8hBngExOFsljiorKShIc8MY4nnqjONlLkB/YJquq
         uWOheVGCPCOI7tUwx86QZeFnbhRa3Fi+sI6HtwiTZXlZ+r/H/YB4iE4ijiXcfKAffjpU
         URjV5U3ZU9crdBvGihyQarxi1FbW0Qm9uBt3uL/LTF06UmCta+yUKRpqcyDcskHnwdZo
         Yvpg==
X-Gm-Message-State: AC+VfDx3rk2DI430joljA1Z8c+R1OU594fLIN40FB1jWruY5ptLr6YHO
        u4KnTsq6YjAzowPeE3brURC4rw==
X-Google-Smtp-Source: ACHHUZ4u606RPk25TsyQLfD7mfoHwhD0dDnafKBqsLaXUPihPoisAYBNdtXFMpWXtggefGDzkY3zHA==
X-Received: by 2002:adf:f650:0:b0:2d1:3eb9:c3c2 with SMTP id x16-20020adff650000000b002d13eb9c3c2mr10056101wrp.54.1687850418913;
        Tue, 27 Jun 2023 00:20:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r3-20020adfda43000000b0030ae3a6be4asm9502791wrl.72.2023.06.27.00.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:20:17 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:20:13 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/bnxt_re: Fix an IS_ERR() vs NULL check
Message-ID: <8d92e85f-626b-4eca-8501-ca7024cfc0ee@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The bnxt_re_mmap_entry_insert() function returns NULL, not error pointers.
Update the check for errors accordingly.

Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index df757da95ac2..abef0b8baa7c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4213,8 +4213,8 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 	}
 
 	entry = bnxt_re_mmap_entry_insert(uctx, dbr, mmap_flag, &mmap_offset);
-	if (IS_ERR(entry))
-		return PTR_ERR(entry);
+	if (!entry)
+		return -ENOMEM;
 
 	uobj->object = entry;
 	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
-- 
2.39.2

