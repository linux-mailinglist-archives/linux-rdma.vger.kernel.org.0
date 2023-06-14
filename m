Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24772F34D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 05:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjFNDz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 23:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjFNDzY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 23:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F82C2;
        Tue, 13 Jun 2023 20:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CB4F630DF;
        Wed, 14 Jun 2023 03:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFFBC433C0;
        Wed, 14 Jun 2023 03:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686714919;
        bh=PAwp8P6P+bo9ED/GohZphvO5u0BbH5QkU+e6HYEe9V8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h1pkU99e7ldbnbGhCLIzgn4hvR9OkW0h9xABQQwEqSkKgKDwkimLQz01NWRBFGQKg
         CA0mSiOEPJ1x0s2NsRL+Jd2Y4xcyGeHEKrYIohTwVUjz40zuUasrd5HFbuh/tdRV8H
         kYn9lTKWs0kOY6g2+Pr6aoxdGlR8+gRQUnqwpCXzitqvn0yM6yI9DEyQs2ejFHYUYY
         M35Alj7TaVuQkYuscsiGwDlcIxwchQfGyyFRAIchghxfvk53VztjwBs/qHPCUpWdtw
         t9ZLh17rOtCPF4HN8qFevTf/D8KWmcgbO7DOqH0KvsghbfXpLWC2C7FGRMH1//Gyu6
         Ja8A+5PiUJUTw==
Date:   Tue, 13 Jun 2023 20:55:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/5] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Message-ID: <20230613205518.56c61170@kernel.org>
In-Reply-To: <6db097ba-c3fe-6e45-3c39-c21b4d9e16ef@huawei.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-2-linyunsheng@huawei.com>
        <483d7a70-3377-a241-4554-212662ee3930@intel.com>
        <6db097ba-c3fe-6e45-3c39-c21b4d9e16ef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 14 Jun 2023 11:36:28 +0800 Yunsheng Lin wrote:
> > As Jakub previously mentioned, this involves including dma-mapping.h,
> > which is relatively heavy, to each source file which includes skbuff.h,
> > i.e. almost the whole kernel :D  
> 
> I am not sure I understand the part about 'includes skbuff.h' yet, it seems
> 'skbuff.h' does not have anything related to this patch?

$ git grep net/page_pool.h -- include/linux/skbuff.h
include/linux/skbuff.h:#include <net/page_pool.h>

> > I addressed this in my series, which I hope will land soon after yours
> > (sending new revision in 24-48 hours), so you can leave it as it is. Or
> > otherwise you can pick my solution (or come up with your own :D).  
> 
> Do you mean by removing "#include <linux/dma-direction.h>" as dma-mapping.h
> has included dma-direction.h?
> But I am not sure if there is any hard rule about not explicitly including
> a .h which is implicitly included. What if the dma-mapping.h is changed to not
> include dma-direction.h anymore?
> 
> Anyway, it seems it is unlikely to not include dma-direction.h in dma-mapping.h,
> Will remove the "#include <linux/dma-direction.h>" if there is another version
> needed for this patchset:)

The point is that we don't want commonly included headers to pull
in huge dependencies. Please run the preprocessor on
linux/dma-direction.h, you'll see how enormous it is.
