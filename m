Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4647305EF
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjFNRUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 13:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbjFNRT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 13:19:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8961A1;
        Wed, 14 Jun 2023 10:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0420D63C50;
        Wed, 14 Jun 2023 17:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C177C433C8;
        Wed, 14 Jun 2023 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686763196;
        bh=FBPLlXJTl5oVPIOPzrt5kTOhHK/0WZZMZVMLcsH1ZH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bqiLkMyQonScWxAcXtXXhd1qcoUafJ6eL0nHPu3TUwujOOG4LpGv2rjcQ/FMv593s
         EsSCAoScxOeGSMMHD3r0PDfR9+anVV1dNoxh9twPpXpF11DtXyva8n7FLHbbnkpJy5
         QObKzf/hPoHPr+rEdTZVFyCcilZhx5BniQehCirpuKcBm5kjgQ/aBk1vh18vJ01Z0G
         gfXyH8HKchL6NXt/5SJLcdaSpj6YHufR1kHDx6K1F/34lxFLKfcPksvz46/UEELH4z
         DWZGAVdOk7aWP3+lyo/0d/5ENzEBG5/ig3VIIIGIQZk1XPUsZ+RN+er8ucNVV2HRM2
         xBlvXCCDubMZA==
Date:   Wed, 14 Jun 2023 10:19:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v4 4/5] page_pool: remove PP_FLAG_PAGE_FRAG
 flag
Message-ID: <20230614101954.30112d6e@kernel.org>
In-Reply-To: <20230612130256.4572-5-linyunsheng@huawei.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-5-linyunsheng@huawei.com>
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

On Mon, 12 Jun 2023 21:02:55 +0800 Yunsheng Lin wrote:
>  	struct page_pool_params pp_params = {
> -		.flags = PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
> -				PP_FLAG_DMA_SYNC_DEV,
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  		.order = hns3_page_order(ring),

Does hns3_page_order() set a good example for the users?

static inline unsigned int hns3_page_order(struct hns3_enet_ring *ring)
{
#if (PAGE_SIZE < 8192)
	if (ring->buf_size > (PAGE_SIZE / 2))
		return 1;
#endif
	return 0;
}

Why allocate order 1 pages for buffers which would fit in a single page?
I feel like this soft of heuristic should be built into the API itself.
