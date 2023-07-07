Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384374BA43
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jul 2023 01:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGGX7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jul 2023 19:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGGX7Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jul 2023 19:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0452114;
        Fri,  7 Jul 2023 16:59:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65CEB61A8A;
        Fri,  7 Jul 2023 23:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C342C433C7;
        Fri,  7 Jul 2023 23:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688774362;
        bh=WTd56ApkF2fKz1PpSSnKiKBr0pj8GEdOUW1JlxQoa/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j2DETU06+q5ZvHqx28PK3xLWmURczDOHwZEvX3m3J7ML63Ryrv6z6fGVNpGjaPIOQ
         wy4but5fBtDcnJvVj6cNlrVxFWdbxZEzCiqp4tGLWod1OntLH8dF+MevIUnWxGbzm4
         4FD7KJaFlpL/NhlgoXLQxT0lYfmGPxLFvCXlzf8LwEAESEymBUsaSd+fUymVkZsaPt
         9KqOaZRV60dmYf6Y/MaQF5XoeFGkbeFzxFuKIdKKKcRD++j3sDU+a5ZdP/b2810Qwb
         OaM9uOTIH06UAZ+lPf47zIVYpXZM7qyLK8duxAIe4QlLXdwuOVkzOgc2t+uw1Ihvl2
         68WGjdEaPM4hg==
Date:   Fri, 7 Jul 2023 16:59:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230707165921.565b1228@kernel.org>
In-Reply-To: <20230629120226.14854-2-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
        <20230629120226.14854-2-linyunsheng@huawei.com>
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

On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:
> +		/* Return error here to avoid mlx5e_page_release_fragmented()
> +		 * calling page_pool_defrag_page() to write to pp_frag_count
> +		 * which is overlapped with dma_addr_upper in 'struct page' for
> +		 * arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
> +		 */
> +		if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> +			err = -EINVAL;
> +			goto err_free_by_rq_type;
> +		}

I told you not to do this in a comment on v4.
Keep the flag in page pool params and let the creation fail.
