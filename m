Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F366A74F5A6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjGKQhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjGKQhn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 12:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6F1720;
        Tue, 11 Jul 2023 09:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3BB6155E;
        Tue, 11 Jul 2023 16:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5455DC433C7;
        Tue, 11 Jul 2023 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093427;
        bh=aHT875jqb7GCXnWc2Ry1gRBSKWwPBNo+nPkkwZHSA7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XZcDX6MuV+y8LxjpADtuxJN9kkfLBsqNkhqyXEa3psF4oOdOqc7RnUlVqRXrzujQx
         U7z6hXEp3i1p7PnWWUws8u7XMruc5KZg+optBKJZs4J5sNj8goDRJpdSN+Z8iuVOOJ
         QniYqPd7vbqZMUv4lnKK4zCM5yIDha1JSBvNLBWiwT2fZCTFpAW67TyYK8KWH5iF5H
         qI6F9kT+t5g2omPrQcCHlRiBXiGKNucyuEDNHjmprkwPf13Zi+RUiU2PE1jLMRUVDd
         Srz3L511P+Go6bRM1JShlUd6lZ9ESMqe3iOvNXbIP7bnTf3acQ4E5x+yUxgasMGKva
         gfOsNkBSXpwbw==
Date:   Tue, 11 Jul 2023 09:37:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yunsheng Lin <yunshenglin0825@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230711093705.45454e41@kernel.org>
In-Reply-To: <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
        <20230707170157.12727e44@kernel.org>
        <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
        <20230710113841.482cbeac@kernel.org>
        <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 11 Jul 2023 12:59:00 +0200 Alexander Lobakin wrote:
> I'm fine with that, although ain't really able to work on this myself
> now :s (BTW I almost finished Netlink bigints, just some more libie/IAVF
> crap).

FWIW I was thinking about the bigints recently, and from ynl
perspective I think we may want two flavors :( One which is at
most the length of platform's long long, and another which is
always a bigint. The latter will be more work for user space
to handle, so given 99% of use cases don't need more than 64b
we should make its life easier?

> It just needs to be carefully designed, because if we want move ALL the
> inlines to a new header, we may end up including 2 PP's headers in each
> file. That's why I'd prefer "core/driver" separation. Let's say skbuff.c
> doesn't need page_pool_create(), page_pool_alloc(), and so on, while
> drivers don't need some of its internal functions.
> OTOH after my patch it's included in only around 20-30 files on
> allmodconfig. That is literally nothing comparing to e.g. kernel.h
> (w/includes) :D

Well, once you have to rebuilding 100+ files it gets pretty hard to
clean things up ;) 

I think I described the preferred setup, previously:

$path/page_pool.h:

#include <$path/page_pool/types.h>
#include <$path/page_pool/helpers.h>

$path/page_pool/types.h - has types
$path/page_pool/helpers.h - has all the inlines

C sources can include $path/page_pool.h, headers should generally only
include $path/page_pool/types.h.
