Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13C762431
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjGYVMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGYVMb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 17:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE062116;
        Tue, 25 Jul 2023 14:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C08461909;
        Tue, 25 Jul 2023 21:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48769C433C9;
        Tue, 25 Jul 2023 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690319545;
        bh=+wjx3PSEq0K5+Aw7/+zFEoqif9hytq8mg416yZy/nHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oDwGVunkHA4n7n03Gl8jk70U5ZjAYv48eGM6EMyCNpK27QgccD7LYKF9E3dH97YFT
         cqvhh48Z9nPUtchSJ/KbUX3zg0yMj4pX5j5/0Xn/ZvzJ6HIn4FMUmu7H3wKLHN0PXK
         zXoixoE1xRJinOW8sELWeoVoJKBphIpInvne8i+89HCy9OGrw636tFTmEixYbzEqkP
         yLrrITncMcu6w3VjQYDrfxrpNKUJwxhHRYgfv6WcW5N3LhGttkAyegjJfYv0C61xul
         pibX3ENru+yDIDv+zRTFwZbHQNBe0UH7lTDvydbQSgYvKj+dw/O78BZVL3tdK2a5aO
         65imaNtu1zwLw==
Date:   Tue, 25 Jul 2023 14:12:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
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
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations
 from page_pool.h
Message-ID: <20230725141223.19c1c34c@kernel.org>
In-Reply-To: <ZL/fVF7WetuLgB0l@hera>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
        <ZL/fVF7WetuLgB0l@hera>
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

On Tue, 25 Jul 2023 17:42:28 +0300 Ilias Apalodimas wrote:
> Apologies for the very late replies, I was on long vacation with limited
> internet access.
> Yunsheng, since there's been a few mails and I lost track, this is instead of
> [0] right? If so, I prefer this approach.  It looks ok on a first quick pass,
> I'll have a closer look later.
> 
> [0] https://lore.kernel.org/netdev/20230714170853.866018-2-aleksander.lobakin@intel.com/


I prefer the more systematic approach of creating a separate types.h
file, so I don't have to keep chasing people or cleaning up the include
hell myself. I think it should be adopted more widely going forward,
it's not just about the page pool.
