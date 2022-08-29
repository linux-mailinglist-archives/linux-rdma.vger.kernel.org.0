Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFCE5A4647
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 11:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiH2JlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiH2Jk7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 05:40:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0174DB3A
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 02:40:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy31so14127365ejc.6
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cxuF/ium3scKvYnBUMW/FtsmInIOSdhuZXM02yUsCjg=;
        b=QXAoVw/zfOdmoFPJaZK/+4ItQKmIAcafmuOKpDk5xgbVxVHMGbUGsREiDwk9gLbJvp
         +76cyZ9vxN308IRTBm40Pnmq5tH2cIuG54qJhRi/aUSbV5sRoIYxvu4FfQZnP5gHqxof
         /C81T/946nQ6YkgMXc66eCDwlVFqpK+HIEp8Kv+LDvju2z4tv4+b/Y/+IBiNp4Nuecqb
         zNARr8vXqc8MKfNWwOgsWA7uqyXdVClP7Iz+jDh0B0ST81EvbmPOoxoiRuUPT5smnXtx
         0i9KRrg/16oa154kuErN80838lWTkm+N1FhhehluAl3iYtETP9I34wmsPsg3tfHuDG/H
         dmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cxuF/ium3scKvYnBUMW/FtsmInIOSdhuZXM02yUsCjg=;
        b=yLwqztwHY9fEp1XreAxlsFWBBTrUVOuAXIY2MNUsMc+W2rhLlSOODLBDVB2ab59mqg
         iZzBem8P138i7G5DTCoQLACFGb1Gvw8+YvHcQi9xBxcpZqDEIxJSY3rJU85+lYmQ7XOh
         Fhe7hb5v/k0rUkEI8nbOVFu1fqafn0CLZOZezAMf3ESDh8+Qol+mkYDVkVcyPZ4/dBJS
         cTydpb5AYOCPEWD6Bgs3MwpQbMV620WhRGaHGiUQzkHiPpe6/uVw+XglbFFEaOrocBKt
         x8Fxr26z9HPuNpQ31DP8dfj0qyaPG6MQvJnfiQBT+UekKBIhMUzTpl1aF3j+5e+3a5r6
         LBEA==
X-Gm-Message-State: ACgBeo0fH1vhQICH60v4BpNkd3uqm32/NFBaOvkBeuEk2ixOzsuiZ/Yo
        RRTvn/CgtNa9j9fSqgnScnYvCK2MC8kKnlX1g9wbDA==
X-Google-Smtp-Source: AA6agR7ylu3hD2hyA9Uv8Qh9utjTfaLfySCnAmTi/0o12556IHchh9nERJx9RuwbQJJB0FpGMXAqNilDzey2p0JsHK0=
X-Received: by 2002:a17:907:6e21:b0:741:73f1:d19b with SMTP id
 sd33-20020a1709076e2100b0074173f1d19bmr3952539ejc.435.1661766050936; Mon, 29
 Aug 2022 02:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220826095615.74328-1-jinpu.wang@ionos.com> <20220826095615.74328-3-jinpu.wang@ionos.com>
 <YwtM+/nB1F6p1Ey3@unreal>
In-Reply-To: <YwtM+/nB1F6p1Ey3@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 29 Aug 2022 11:40:40 +0200
Message-ID: <CAMGffEmffkW0fHrjx84gQ6FnWuwriRUg=HSdwzU4W_sZLdiT7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from ib_dma_map_sg{,_attrs}
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 28, 2022 at 1:09 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Aug 26, 2022 at 11:56:15AM +0200, Jack Wang wrote:
> > Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
> > change the return value of ib_dma_map_sg{,attrs} to unsigned int.
> >
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: linux-rdma@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >  drivers/infiniband/core/device.c | 2 +-
> >  include/rdma/ib_verbs.h          | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> You forgot to change ib_dma_map_sgtable_attrs() and various
> ib_dma_map_sg*() callers.
No, they are different.
ib_dma_map_sgtable_attrs and dma_map_sgtable return negative on errors.
>
> Thanks
Thanks!
