Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0F74F8C0
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 22:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGKUJH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGKUJG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 16:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA7139;
        Tue, 11 Jul 2023 13:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A84A61566;
        Tue, 11 Jul 2023 20:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5A5C433C8;
        Tue, 11 Jul 2023 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689106144;
        bh=wk7VELBrn/wBoMAIT6EmbBSd/EdsoGglWydsGe0Fzns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=anzmEXzmRgeCPp6Qh3t9tE3C7pdprZE1CwU0MRqgfvbT27tru+k4O8YTUI0Fiwz82
         y8DEEOcYoQxuVjlFWNgLIfImiodY3KEmY4I5GPH2Ig/dUP0YaW1mDGCj2w8epifs5Q
         +3Hw2EB5AdooqhZG/DJ0FmTutld7DHw9Ia/xT02TMjfzkilnRYRtJ4hCE1O3pI6PlP
         cDn8vSvmeEOtrc/HcJiHVi0NkFOtyzk7WOPSCBI0gSj1y7AmHGYbe2Q6spx+69eY/I
         huGaVLSPSaw1HDvV43v9T32uygt5dRYBRtnw3El5hJ8WDViV+katflTokrBwejeQvL
         DU262nhnKPCgA==
Date:   Tue, 11 Jul 2023 13:09:03 -0700
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
Message-ID: <20230711130903.2961a804@kernel.org>
In-Reply-To: <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
        <20230707170157.12727e44@kernel.org>
        <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
        <20230710113841.482cbeac@kernel.org>
        <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
        <20230711093705.45454e41@kernel.org>
        <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
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

On Tue, 11 Jul 2023 18:59:51 +0200 Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 11 Jul 2023 09:37:05 -0700
> 
> > On Tue, 11 Jul 2023 12:59:00 +0200 Alexander Lobakin wrote:  
> >> I'm fine with that, although ain't really able to work on this myself
> >> now :s (BTW I almost finished Netlink bigints, just some more libie/IAVF
> >> crap).  
> > 
> > FWIW I was thinking about the bigints recently, and from ynl
> > perspective I think we may want two flavors :( One which is at
> > most the length of platform's long long, and another which is  
> 
> `long long` or `long`? `long long` is always 64-bit unless I'm missing
> something. On my 32-bit MIPS they were :D
> If `long long`, what's the point then if we have %NLA_U64 and would
> still have to add dumb padding attrs? :D I thought the idea was to carry
> 64+ bits encapsulated in 32-bit primitives.

Sorry I confused things. Keep in mind we're only talking about what 
the generated YNL code ends up looking like, not the "wire" format.
So we still "transport" things as multiple 32b chunks at netlink level.
No padding.

The question is how to render the C / C++ code on the YNL side (or 
any practical library). Are we storing all those values as bigints and
require users to coerce them to a more natural type on each access?
That'd defeat the goal of the new int type becoming the default /
"don't overthink the sizing" type.

If we have a subtype with a max size of 64b, it can be 32b or 64b on
the wire, as needed, but user space can feel assured that u64 will
always be able to store the result.

The long long is my misguided attempt to be platform dependent.
I think a better way of putting it would actually be 2 * sizeof(long).
That way we can use u128 as max, which seems to only be defined on 64b
platforms. But that's just a random thought, I'm not sure how useful 
it would be.

Perhaps we need two types, one "basic" which tops out at 64b and one
"really bigint" which can be used as bitmaps as well?
