Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79C7339CC
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFPTZ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 15:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346138AbjFPTYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 15:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1FB4222;
        Fri, 16 Jun 2023 12:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA93362E38;
        Fri, 16 Jun 2023 19:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D73FC433C0;
        Fri, 16 Jun 2023 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943302;
        bh=hUURytXlMcDfitAbduozrB5DyB72nWHC+HvK485KkJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ad6swJdWo1IwISr5c/t9icf18UMj2lCExyhlgLv+O+KgaYu/qZg8ZZ19ks7CRln5E
         th4SmFbPGuTwMIGWdBPmtnkEM1h2OX6Nib1afv4AR2f2DybEiJNrBhoHPj7vetKS+D
         RcEols5/yqQmNho1ySddtpAimBACwAUt7LSdNXjRvv3zf2+ztH5QxDP7FrFynityCd
         WEcYDgO2xfbntUyjU4vDS/KZxH/Y5WpDdFnzn7ZNIBTuOYk7HBxSz12lldH6KT9VV4
         FIMWxf5Rxd7oFaVbCxDughxs/4yROiz12DdTIU7tVLWKYHhXtEt8eESRjH8vAEURe4
         nw+TGWsF+9gZg==
Date:   Fri, 16 Jun 2023 12:21:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, brouer@redhat.com,
        davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
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
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 4/5] page_pool: remove PP_FLAG_PAGE_FRAG
 flag
Message-ID: <20230616122140.6e889357@kernel.org>
In-Reply-To: <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
        <20230612130256.4572-5-linyunsheng@huawei.com>
        <20230614101954.30112d6e@kernel.org>
        <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
        <20230615095100.35c5eb10@kernel.org>
        <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
        <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com>
        <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
        <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
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

On Fri, 16 Jun 2023 20:59:12 +0200 Jesper Dangaard Brouer wrote:
> +       if (mem_type == MEM_TYPE_PP_NETMEM)
> +               pp_netmem_put_page(pp, page, allow_direct);
> +       else
> +               page_pool_put_full_page(pp, page, allow_direct);

Interesting, what is the netmem type? I was thinking about extending
page pool for other mem providers and what came to mind was either
optionally replacing the free / alloc with a function pointer:

https://github.com/torvalds/linux/commit/578ebda5607781c0abb26c1feae7ec8b83840768

or wrapping the PP calls with static inlines which can direct to 
a different implementation completely (like zctap / io_uring zc).

Former is better for huge pages, latter is better for IO mem
(peer-to-peer DMA). I wonder if you have different use case which
requires a different model :(
