Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8A75B407
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jul 2023 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGTQWy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jul 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGTQWw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jul 2023 12:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847CA1722;
        Thu, 20 Jul 2023 09:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D349761B5F;
        Thu, 20 Jul 2023 16:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E0FC433C8;
        Thu, 20 Jul 2023 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689870169;
        bh=Ga7vIpJBGNUMApUSoun4tXfXEl7VbVUv4I6DCjjfbAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rDHLNXGwIvMHpNywshRgUPi+IXDPlOs5NO3euDhmRsGbXh0CscyAmfQpeQo/knivh
         HR3UFzU5wkh0Mn273qVxXTfkibGeI10vuHAggrxFD7TPMkpXk1g3pxtEevHmB4lkaM
         EttnT6/+FzHGmzbku9kikGP0MlFqFfXuG8vM2FXH3upqc1SoxuGxWjpJ/JbG0Ub2pO
         4KW93kC4qEHEKKMVIFqEr9A/jChPzqTzc1PD/PTqgoF6rvuBd61iPbZBwqedCv+LIN
         XDKa6i1hfxCGL4PaLA58iGFombeHuRO0dgM92lvfvmAVeBFO2yLlASlPYCivOgC8Pm
         gpmfJGqETEZ7Q==
Date:   Thu, 20 Jul 2023 09:22:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Message-ID: <20230720092247.279d65f3@kernel.org>
In-Reply-To: <7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
        <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
        <7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
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

On Thu, 20 Jul 2023 19:07:31 +0800 Yunsheng Lin wrote:
> > BTW, what do you think: is it better to have those two includes in the
> > root include/net/ folder or do something like
> > 
> > include/net/page_pool/
> >   * types.h
> >   * <some meaningful name>.h (let's say driver.h)
> > 
> > like it's done e.g. for GPIO (see include/linux/gpio/)?  
> 
> It make more sense to add a new dir for page pool if there are
> more new headers added. As we are still keeping the page_pool.h
> mirroring include/linux/gpio.h, adding a new dir for only one
> header file only add another level of dir without abvious benefit.
> We can add a new dir for it if we turn out to be needing more header
> file for page pool in the future, does it make sense?

It doesn't matter all that much so I think to have some uniformity 
in networking please go with Olek's suggestion which is also my
preference.
