Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0E6F65B7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEDH3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 03:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEDH3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 03:29:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8230D6
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 00:29:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so18643f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 04 May 2023 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683185348; x=1685777348;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qroDqr8+1ZO4SWyPnGlKjsFT9t3yKrQnixXRr9k3bmI=;
        b=HO07YCpr+2ULJuyDZrj5G6eAQc2qAe9lOLytLSEsO7HrmFNDPKsBjW3Mlh6rTx25l7
         Bb6mn1r/e+6H7dI6fpyDDbLPARrn/e3+/N0CQGzoXyiuKbtfF7RCeVsm20xJNeHYmV8f
         wWxxPSZsGibZqSsn/wY8WhHQVrf70/++RbdSSUlgf5uJNJgdM/R+C8qEhtVaIKINL8mL
         n/vOa7MYB+zKPq8YjOPstBNEnQb4dFjfSSTBYJGFYq2KfCiv912fYm9T/cfa09NoM5UE
         WIvXpUt3KAXCwuq3jYvxsUT7zWSkgZGEbv4/4Tgvc6x3kWQUDBOwScETD4g73a27FJZZ
         3OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683185348; x=1685777348;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qroDqr8+1ZO4SWyPnGlKjsFT9t3yKrQnixXRr9k3bmI=;
        b=E9yfQM9GbYT7irN5miY+jhYavlIF48bfrYy8sbMO1EfHzbfxJS5PceXhT0d3in1mKU
         NUb+0ny5IcmTbBSEQiKTEzFYfas3YQSv9hBVowSo9npzabN+bCmfq+Qiv5EFU+ARKxFp
         jHpOy6RhXE2DFEUGmj6qWStys1XZ5MNaUIqvSzLYkgco6DUTArFoCuRrxEyZfZsVMdua
         28U1iZ3GXGlDtbdixKArHkpaoeZejZBjsDyjJKuKqreM9QzuuLoXbyl+fCX3J9Z+bUCz
         Tfwuk2CAA3W0heUrvZOU7fIq3ZmbZNAwCEolD+pdR2jxm3y5UPvx128aTREEwDr3rmxU
         pk2A==
X-Gm-Message-State: AC+VfDyb7P4rrY12b3FC3gMKwMrER4YGBGPvuvMgCJWzkLqAYGLM2fPn
        L5b77gmPCPgRFFbPa6oAdnQaug==
X-Google-Smtp-Source: ACHHUZ5kVV9u21BYcWLVC6lBr6ZjqH70MwPxMHi8G3euxOaHj+HGcylb3jU0bHu1M/m9+f9pfw+00g==
X-Received: by 2002:a5d:4cd0:0:b0:306:2b0f:5d48 with SMTP id c16-20020a5d4cd0000000b003062b0f5d48mr1685723wrt.26.1683185348269;
        Thu, 04 May 2023 00:29:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e4-20020adffc44000000b0030632110586sm8613489wrs.3.2023.05.04.00.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:29:05 -0700 (PDT)
Date:   Thu, 4 May 2023 10:28:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/rxe: Protect QP state with qp->state_lock
Message-ID: <27773078-40ce-414f-8b97-781954da9f25@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bob Pearson,

The patch f605f26ea196: "RDMA/rxe: Protect QP state with
qp->state_lock" from Apr 4, 2023, leads to the following Smatch
static checker warning:

	drivers/infiniband/sw/rxe/rxe_qp.c:716 rxe_qp_to_attr()
	error: double unlocked '&qp->state_lock' (orig line 713)

drivers/infiniband/sw/rxe/rxe_qp.c
    705         rxe_av_to_attr(&qp->pri_av, &attr->ah_attr);
    706         rxe_av_to_attr(&qp->alt_av, &attr->alt_ah_attr);
    707 
    708         /* Applications that get this state typically spin on it.
    709          * Yield the processor
    710          */
    711         spin_lock_bh(&qp->state_lock);
    712         if (qp->attr.sq_draining) {
    713                 spin_unlock_bh(&qp->state_lock);
                             ^^^^^^
Unlock

    714                 cond_resched();
    715         }
--> 716         spin_unlock_bh(&qp->state_lock);
                     ^^^^^^
Double unlock

    717 
    718         return 0;
    719 }

regards,
dan carpenter
