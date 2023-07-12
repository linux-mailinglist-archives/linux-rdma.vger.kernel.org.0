Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46029750FA6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjGLR0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjGLR0I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 13:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF121BD;
        Wed, 12 Jul 2023 10:26:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F19461888;
        Wed, 12 Jul 2023 17:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FBC433A9;
        Wed, 12 Jul 2023 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689182765;
        bh=pG6AfeQoMQzPU4mvPY+9mXce5KZBxglpwtexIBwtYiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XRowKNSn1KVUX3wG5wtCbshtxTkV3qoGx60izDxqap1T6aBFZjWbARoKikKbawfAb
         b/4/XBiDgUsoGDJl/kH+PMYI7Ocq+m34rE1cf9Cft4bZFJDYlXHDH3x4d2KfC61ds1
         z83EIvQyIKHcXHo7zh6EhnvADi9C6SoKrC93g2uuHe1Gv1BrjCNNTYRU2tQvgBXEt8
         omR7EjZhMLN0Mq22Zb/ynOdZMHqTfoswFU+rt3uuIDrkvdEsxdfRAv3gXYb6LWoCWb
         UlQe5CYSXwHee90E0pe6Q5+XCpF/jslF29tTY9JyZh5xOsgVKOc7v3OKMT0ZfBNrEt
         NyAN+iJqLP3Kw==
Date:   Wed, 12 Jul 2023 10:26:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <yunshenglin0825@gmail.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230712102603.5038980e@kernel.org>
In-Reply-To: <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
        <20230707170157.12727e44@kernel.org>
        <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
        <20230710113841.482cbeac@kernel.org>
        <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
        <20230711093705.45454e41@kernel.org>
        <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
        <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
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

On Wed, 12 Jul 2023 20:34:12 +0800 Yunsheng Lin wrote:
> >> C sources can include $path/page_pool.h, headers should generally only
> >> include $path/page_pool/types.h.  
> 
> Does spliting the page_pool.h as above fix the problem about including
> a ton of static inline functions from "linux/dma-mapping.h" in skbuff.c?
> 
> As the $path/page_pool/helpers.h which uses dma_get_cache_alignment()
> must include the "linux/dma-mapping.h" which has dma_get_cache_alignment()
> defining as a static inline function.
> and if skbuff.c include $path/page_pool.h or $path/page_pool/helpers.h,
> doesn't we still have the same problem? Or do I misunderstand something
> here?

I should have clarified that "types.h" should also include pure
function declarations (and possibly static line wrappers like
pure get/set functions which only need locally defined types).

The skbuff.h only needs to include $path/page_pool/types.h, right?

I know that Olek has a plan to remove the skbuff dependency completely
but functionally / for any future dependencies - this should work?
