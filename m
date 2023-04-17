Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92D86E40DA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDQH1z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Apr 2023 03:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjDQH1e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Apr 2023 03:27:34 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FB4C1A
        for <linux-rdma@vger.kernel.org>; Mon, 17 Apr 2023 00:27:14 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y16so9670547ybb.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Apr 2023 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716433; x=1684308433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi3iwpMsvzvdJPVxJRsZX5LOWRJ4M81CJC3Hd6q6mYg=;
        b=Z6py82BkPgoupnGz06XKqmOjCmApC1m1rnmnvvBQmIieUaXek15ZiA0TuWpMJYAR6v
         CdiKYFwZvgUfxXjxIaNC38IpXSs4k8Q8mSYyjLuS/LME03qBEvJwbycs/BETsX1BQ9UX
         17QIu0jEGJWevYOvFFQMQXu6VeHX3pKuMsGzS3Hwpqg6M7bq9Wqvpevyxjw6zYk0xllg
         RS0tXWQ0GXQwHmWcv89YVhfBgTZEP2nH86rl+FmGdypB7w1poFUw9WgGh8FJg196MzGd
         O56v1UTDSXBlKnORlq15umgK38gx9l+hdooYD4gLdM/itn4ktdUsF9DbdW70NjoLVVLR
         TYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716433; x=1684308433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi3iwpMsvzvdJPVxJRsZX5LOWRJ4M81CJC3Hd6q6mYg=;
        b=esdbgt5sQMihKOSv/9pGXICRtlgi5RSQSBQGTqvuJl+tEjgn6fB1kHzsb9OOXeip0m
         JJkPx106MEMQuRFfovZWjaxdN2IGbNdPe+P1HmHlPy0j8YP3Oj9BnON/aVEt8+CcXunh
         TQB0q4UtNebhpj3k23Wooj/ibum6V/kMTe6anHybR49/l1iQi/ZFU1fbEdVpd3+QfDz8
         wcxTN9q3fLBxRT/8U6F0dZ0CP8Fi0oWGkblgwBJo/xZgIHvglMeTErv2rUqh74ubXdM/
         MhJ6fT68z9vIHDbdHSCcCsdT6B9idGmkI/qyGVWljBkAnqYvtZFDuu85YDN43VFP+X2+
         asOg==
X-Gm-Message-State: AAQBX9cJIIgybV1XZ8WezvPqQR41XX0oCMVM08X2Ik3FuQkdfEvANc+N
        DDFcPibfHxWuiFE49xL96MxrbVhDD1VEJ9Ewh57N5CcknQYG7Jic
X-Google-Smtp-Source: AKy350bj3mwCxv2OqUhHbaOXKGZr+/aQbhaM8Pm1C9JebR+Sg4kVjgZTqbgIU4Pa1Y9twfZhQWbyspzERmi5Z6E01To=
X-Received: by 2002:a25:d708:0:b0:b8f:448e:2f9a with SMTP id
 o8-20020a25d708000000b00b8f448e2f9amr8961284ybg.4.1681716433061; Mon, 17 Apr
 2023 00:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <0-v2-05ea785520ed+10-ib_virt_page_jgg@nvidia.com>
In-Reply-To: <0-v2-05ea785520ed+10-ib_virt_page_jgg@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:27:01 +0200
Message-ID: <CACRpkdapvx33QGSb1i+m_exGXnfKO4QjByurV=RQDbPY+NkdRg@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA: Add ib_virt_dma_to_page()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 14, 2023 at 3:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:

> Make it clearer what is going on by adding a function to go back from the
> "virtual" dma_addr to a kva and another to a struct page. This is used in=
 the
> ib_uses_virt_dma() style drivers (siw, rxe, hfi, qib).
>
> Call them instead of a naked casting and  virt_to_page() when working wit=
h dma_addr
> values encoded by the various ib_map functions.
>
> This also fixes the virt_to_page() casting problem Linus Walleij has been
> chasing.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Too late but FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this up so meticulously Jason!

Yours,
Linus Walleij
