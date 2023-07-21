Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDEE75CABE
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGUO4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGUO4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 10:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389330E3;
        Fri, 21 Jul 2023 07:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F15161CB7;
        Fri, 21 Jul 2023 14:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9D1C433C7;
        Fri, 21 Jul 2023 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689951377;
        bh=GbEdKOfppLFqOiQbkW2R1KhTapJ4FFcPNoaoNaBCLKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NXlKWpLuPeKFqxlrQAj4ALgNKRqep1DB4i8zp75V7Cvk8c/efHwVnko4stlpjU4/i
         90qJ6XaOrO/Q0iWCqzCKbSXeO6sa2SO8PtbYKhoqUEWtwhsbZNFjOGVPxUj9cQ1ONL
         ea6ISpEAjOP6gaPvwe/PUjlGBh22NxI2o7vYtxmgTFkSWT1OlhLe0BLR1a4Np62JRc
         WqwybNdxjwXcxp6R6p8oFhYpuRHyGsHIIyyOGgCnFxqCBiA6Kd8/VJqDZDqoNRCI9g
         K+ABmjUwR9H1QO1ejIRI9WI99NrytMs340M2ScQtOwONLs/z+3O+SClu0JjxYM/nic
         /bxbxhWrBks3A==
Date:   Fri, 21 Jul 2023 07:56:15 -0700
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
Message-ID: <20230721075615.118acad4@kernel.org>
In-Reply-To: <f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
        <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
        <7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
        <20230720092247.279d65f3@kernel.org>
        <f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
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

On Fri, 21 Jul 2023 19:12:25 +0800 Yunsheng Lin wrote:
> Just to be clear, include/net/page_pool.h is still there, we are not
> putting page_pool.h in include/net/page_pool/ and renaming it to
> something else, right? As there is no that kind of uniformity in
> include/net/* as far as I can see.

Like many things the uniformity is a plan which mostly exists in my head
at this stage :) But it is somewhat inspired by include/linux/sched.*

> More specificly, yon means the below, right?
> include/net/page_pool.h
> include/net/page_pool/types.h

Yes.
