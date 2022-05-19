Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3C52CA6D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 05:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiESDii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 23:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiESDie (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 23:38:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F38694AE
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 20:38:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u23so6914611lfc.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3lzFHIE7Kl5eHUF6TTlskrZSl+ex8+xccNX2/COSfk=;
        b=X1QmMOItaplTmpQP1/xIrAY+4Bu8YK/AXPe1O3N+P8iX8/aK+vzXavmx6vUPZR4pdW
         uI/NNTZA9H3xAVHBsQw3AOl8KlmFGcmzC7WAzt3HKV2VvBjRtzDLU+NK1mwUH4gZvvl1
         OEhrhRR+youIaXv9BBxTNfD5fnMDWwfdifkjsf4GVQjUPqesI0A3V39w5eF7Sn1PGStv
         nyBI2vwWFkq9MUtFxrgw+oGD8GGaAe0dDRyKqAPoeD/xDFmV0hZt/Pqte7En7wI4Fjeh
         oXDb4bROo33zxxZACxOxCrsHLssogZrCn5g8nDiKQZM+PjlP/C4OYTDZPO4FX3hIfUkd
         U5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3lzFHIE7Kl5eHUF6TTlskrZSl+ex8+xccNX2/COSfk=;
        b=aXHjtIJcHuj0SOxYHWvUZaTznyZQHYoSCXu6/evU6/i6KGDsNryIS17EapffsxZao0
         b90o5OnFNdlxhq2afwc2PpYe24QH9VUzH0aopFxYQZxkmZrgNuTsRjPwhbEw1LtUPdJ2
         wcnhbxIyMnS8ogssYZcivcuGF/GrZXps8rN4PWnzSeZ09hlMqUzUBZyqBe/QNGQS80C4
         yAG9gmRReTERiKXyQj4w3NBnafnUpkh3PyXTY+wQDmHBnyhsylBmW4pJT8YKGee/ZlSa
         xTUNf1gKeg+mbNNW165f2qrAJ4WVxredW86ec3tRGimfY5ZPMyr9mMCh6omOuGxCEPyJ
         nEhw==
X-Gm-Message-State: AOAM532DMrO8raoCce4fg+OwhywbPFkjkH8z8MCxEKKXXzhLU3N12kVC
        CF7Wpv0MvnB3tEvtp06OgYnairqg9AFTU6timks=
X-Google-Smtp-Source: ABdhPJwps7TnqYG0uEKAe+Yf86Hdg2AfFVnv+jRQ9q5rrvWYt/KjjVq7FQiqzWCXBs+p50QPANQVzwui6xdx6be2xjE=
X-Received: by 2002:a05:6512:b1a:b0:474:356:41ca with SMTP id
 w26-20020a0565120b1a00b00474035641camr1794707lfu.571.1652931512191; Wed, 18
 May 2022 20:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220518152310.20866-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220518152310.20866-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 19 May 2022 11:38:20 +0800
Message-ID: <CAD=hENdeUN4D7LTyk2JaXNRKS-o-rR1yCqPXZjC4TdTEMLVJBw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix wrong rkey in test_qp_ex_rc_bind_mw
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Edward Srouji <edwards@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 18, 2022 at 11:23 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> The current test_qp_ex_rc_bind_mw in tests/test_qpex.py uses an incorrect
> value for the new_rkey based on the old mr.rkey. This patch fixes that
> behavior by basing the new rkey on the old mw.rkey instead.
>
> Before this patch the test will fail for the rxe driver about 1 in 256
> tries since randomly that is the freguency of new_rkeys which have the
> same 8 bit key portion as the current mw which is not allowed. With
> this patch those errors do not occur.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

This is for rdma-core? It had better add "for rdma core" in the subject line.

Zhu Yanjun

> ---
>  tests/test_qpex.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
> index 8f3f338e..a4c99910 100644
> --- a/tests/test_qpex.py
> +++ b/tests/test_qpex.py
> @@ -300,7 +300,7 @@ class QpExTestCase(RDMATestCase):
>              if ex.error_code == errno.EOPNOTSUPP:
>                  raise unittest.SkipTest('Memory Window allocation is not supported')
>              raise ex
> -        new_key = inc_rkey(server.mr.rkey)
> +        new_key = inc_rkey(mw.rkey)
>          server.qp.wr_bind_mw(mw, new_key, bind_info)
>          server.qp.wr_complete()
>          u.poll_cq(server.cq)
> --
> 2.34.1
>
