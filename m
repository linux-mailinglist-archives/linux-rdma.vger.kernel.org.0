Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445F274F501
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGKQVd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjGKQVS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 12:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB1E19A3;
        Tue, 11 Jul 2023 09:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7179C61556;
        Tue, 11 Jul 2023 16:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481CAC433C7;
        Tue, 11 Jul 2023 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689092460;
        bh=NnvGyeFdqT1PJXerhGhkw4nha+gp/hm34hmEQZehQBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q41kwYFyr8xOB61pvc5FELxseCH+442Dfz/DDdwc4nm0O7JlQxfOdE8eTyj4F38un
         9SVnab643Xy9DHecsJiimbYR73eH+hWG966vCNGvww2Wot57F6wrGsNXk/uZEJpnhq
         WuoWb78NXvY0FHvB/7RBe3L5/HzqtGNiLFQ0wz2Yzzm/nj1M7Y90DL73GXVj2KU6PN
         vLfRRu6T5KbDARbYtXLhJO6oYV11t6WP55vDJMJ3Eu7KazqQXS7E5Rkyp9BO1P4C8k
         D20Bh6Lu9Nc+aO6pLS89qrGOhZa786q5r+/cU9U0a0eclcSTY1Cyvi1DqYKmSEO4jv
         QFjLXRx3oQvqg==
Message-ID: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
Date:   Tue, 11 Jul 2023 10:20:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@lst.de>
Cc:     Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
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
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca> <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org> <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca> <20230711090047.37d7fe06@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230711090047.37d7fe06@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/11/23 10:00 AM, Jakub Kicinski wrote:
>> RDMA works with the AMD and Intel intree drivers using DMABUF without
>> requiring struct pages using the DRM hacky scatterlist approach.
> I see, thanks. We need pages primarily for refcounting. Avoiding all
> the infamous problems with memory pins. Oh well.

io_uring for example already manages the page pinning. An skb flag was
added for ZC Tx API to avoid refcounting in the core networking layer.
Any reason not to allow an alternative representation for skb frags than
struct page?
