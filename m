Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59C77E729
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 19:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbjHPRCl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345053AbjHPRCh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 13:02:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722626A4
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 10:02:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe55d70973so71962e87.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692205354; x=1692810154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XvtaCAZpWBCbX7owOsA0570OIhxpXllLFEya1k96P1s=;
        b=jukU8b7GbHaHTWnc5zZf4mcxlI/r2Ly0TwruGfWV09BR05hSCM5U0Ek0YDapgd6Pgx
         NsGeMbSDmaz2hGAObqVZYc3GIBKkNsKGI5iA0uBTJ0zdpgEMR2iCfLClYFWSR0FaRSX4
         1O6bC0LdGSEIpvAcBal/kLizeilleUrCAp0dLvg3DtZ2VyKJ7Q2prbeoLIyjCvNfLguN
         /D5D2eXbvp1FJBzq6tLbVrvijWDqfp6VtyA85isk0LqDdRGPcgyjKRwhbiDnhLKNjkM0
         fX8GpUivLDfqWfaAg4iyR7Ty6H9XHfi8JfWBhI7FN6dkmtIc6uYaOfhfupreLoSCa3ZU
         NOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205354; x=1692810154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvtaCAZpWBCbX7owOsA0570OIhxpXllLFEya1k96P1s=;
        b=cEDb/tg1bETYy53J6IVWpkIcpL19dxJOqs6UI0a5+92i3pVKmazGjOqXaqfYw0Dlg0
         mLdKyxmnLWIRu4vkq6bs5jfPP7vwTALIEsYcf3+pirKpU1GQ6cVbv28M57+coxT0bz8S
         F0xVlap7Y43PxDvTmOQbMcYTK3QYV/HWUqpzeiQcgSm8x0K7B0Kk/8rhUkkwCFhGnegZ
         ctgD2ir8WyF4Q/lfvZLlFntU1trdiPMxmb/spg+BzZBatl3ryjL2jvyQ80oLcyD3kcca
         1KOiJqqn/IZYSTtJcjZeqFFWfUXdkCsrsnBUlnnKs64yYFRuCNzZI9BOsfFyoG8beJjC
         ugSw==
X-Gm-Message-State: AOJu0Yw+qR6mPPBPJN1kPLdAHU5Ic5UDp+eKQREPNz9RWveNrtB7q3kx
        xidt47r13DQqwWrbAnXMNmi27EPqKHfLCWl8vy0N7q/xX6VE2WPKs8m9fA==
X-Google-Smtp-Source: AGHT+IE9bpUVq8gnNZwAlGp+qrG+Dexf0/F5+dY2V4YioQVhEA9o+MBKco54FpLsQCYAVxY6FLAiZzohj1xYM5PhdwQ=
X-Received: by 2002:a05:6512:a87:b0:4fb:7d09:ec75 with SMTP id
 m7-20020a0565120a8700b004fb7d09ec75mr124704lfu.4.1692205353687; Wed, 16 Aug
 2023 10:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-2-linyunsheng@huawei.com> <CAC_iWjKMLoUu4bctrWtK46mpyhQ7LoKe4Nm2t8jZVMM0L9O2xA@mail.gmail.com>
 <06e89203-9eaf-99eb-99de-e5209819b8b3@huawei.com>
In-Reply-To: <06e89203-9eaf-99eb-99de-e5209819b8b3@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 16 Aug 2023 20:01:57 +0300
Message-ID: <CAC_iWjJ4Pi7Pj9Rm13y4aXBB3RsP9pTsfRf_A-OraXKwaO_xGA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 16 Aug 2023 at 15:49, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2023/8/16 19:26, Ilias Apalodimas wrote:
> > Hi Yunsheng
> >
> > On Mon, 14 Aug 2023 at 15:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> Currently page_pool_alloc_frag() is not supported in 32-bit
> >> arch with 64-bit DMA because of the overlap issue between
> >> pp_frag_count and dma_addr_upper in 'struct page' for those
> >> arches, which seems to be quite common, see [1], which means
> >> driver may need to handle it when using frag API.
> >
> > That wasn't so common. IIRC it was a single TI platform that was breaking?
>
> I am not so sure about that as grepping 'ARM_LPAE' has a long
> list for that.

Shouldn't we be grepping for CONFIG_ARCH_DMA_ADDR_T_64BIT and
PHYS_ADDR_T_64BIT to find the affected platforms?  Why LPAE?

>
> >
> >>
> >> In order to simplify the driver's work when using frag API
> >> this patch allows page_pool_alloc_frag() to call
> >> page_pool_alloc_pages() to return pages for those arches.
> >
> > Do we have any use cases of people needing this?  Those architectures
> > should be long dead and although we have to support them in the
> > kernel,  I don't personally see the advantage of adjusting the API to
> > do that.  Right now we have a very clear separation between allocating
> > pages or fragments.   Why should we hide a page allocation under a
> > frag allocation?  A driver writer can simply allocate pages for those
> > boards.  Am I the only one not seeing a clean win here?
>
> It is also a part of removing the per page_pool PP_FLAG_PAGE_FRAG flag
> in this patchset.

Yes, that happens *because* of this patchset.  I am not against the
change.  In fact, I'll have a closer look tomorrow.  I am just trying
to figure out if we really need it.  When the recycling patches were
introduced into page pool we had a very specific reason.  Due to the
XDP verifier we *had* to allocate a packet per page.  That was
expensive so we added the recycling capabilities to compensate and get
some performance back. Eventually we added page fragments and had a
very clear separation on the API.

Regards
/Ilias
>
> >
> > Thanks
> > /Ilias
> >
