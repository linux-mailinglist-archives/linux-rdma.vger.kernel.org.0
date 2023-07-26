Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4A763B86
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjGZPrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjGZPrq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 11:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F63193;
        Wed, 26 Jul 2023 08:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D579161B91;
        Wed, 26 Jul 2023 15:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1C6C433C8;
        Wed, 26 Jul 2023 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690386464;
        bh=ntzUm32RuTuI9DzAzwAs39wscUDZsYJF5RGGxmCI+/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RzpKJzruvMIC6e+h2wdEZ8qON1ieukXJk9w17kGJCOFFhOSuDkuhkgAjiLEpp9ifj
         mrc1myf+Y48t+Jb4jFaAz85JzvoY2huic7EW0fpoQguPpDQPFtrTSV1ghUlipQMaQq
         9RNJiikJiqwV0/LpAsTq0sQhSAAZlQseAlot147AlZ0Onm8a8NFL6ujdtNciaRzOBa
         z3TtnqnGYqS+7OBw1t5LYs2F7ztrg3Fs1v1aujCnJwNfYUL8UG1sEEOx+vGHlbGl1d
         xNFWTAZVcXM9GzsKbiYWh31EUWCa5tm1DlUx4shA55XFcYDXHbwZorPr1TRaJ9tFpb
         Nc5fstcERHKZw==
Date:   Wed, 26 Jul 2023 08:47:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya Sundeep" <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        "Saeed Mahameed" <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Sean Wang" <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations
 from page_pool.h
Message-ID: <20230726084742.7dc67c79@kernel.org>
In-Reply-To: <a5d91458-d494-6000-7607-0f17c4461b6e@intel.com>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
        <ZL/fVF7WetuLgB0l@hera>
        <20230725141223.19c1c34c@kernel.org>
        <a5d91458-d494-6000-7607-0f17c4461b6e@intel.com>
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

On Wed, 26 Jul 2023 12:48:05 +0200 Alexander Lobakin wrote:
> > I prefer the more systematic approach of creating a separate types.h
> > file, so I don't have to keep chasing people or cleaning up the include
> > hell myself. I think it should be adopted more widely going forward,
> > it's not just about the page pool.  
> 
> I have this patch reworked to introduce
> include/net/page_pool/{types,helpers}.h in my tree, maybe someone could
> take a quick look[0] and say if this works while I'm preparing the next
> version for sending? Not the most MLish way, I know :s
> 
> [0]
> https://github.com/alobakin/linux/commit/19741ee072c32eb1d30033cd4fcb236d1c00bfbf

LGTM!
