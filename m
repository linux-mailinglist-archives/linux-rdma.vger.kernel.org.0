Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE174F5BD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjGKQmw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 12:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGKQmw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 12:42:52 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D27E69
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 09:42:50 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7679ea01e16so552072585a.2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689093769; x=1691685769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu6KIyFq5ICxck51tOZTlrhfx/dAZN9zejRdcXCeDIQ=;
        b=hutFTkWd80/JWvtlN74IkzBT25OF7LVT1vr1QbOtoLia7gCMDN/IthFasmJc6qiQay
         3tVmOsZw93jMQD1ismCSE3/TO08LFEoKmWO4bSv0VW+Fcc+nXAGs1l4AEEucg2NIWTfz
         qtsg3PHnJJ+65RVJUeDP0+OnLtSMLDGe8uG31BIeuyVQUZmFXwqtQpoxmzPe0CWl2vF+
         PVSnB774tyoY7PSisg55xASa4YKGevTLCboavkgbiFWYJv3oSZ8GGZIln/OlViAGZJQ0
         1osG2kQZAkLmJs3+qeezOegAZ4lq6SI4eQiiwkKS9Ht/DJCtY3YykcRdmrRaLS2HudM/
         80kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689093769; x=1691685769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu6KIyFq5ICxck51tOZTlrhfx/dAZN9zejRdcXCeDIQ=;
        b=LacGYiOlna2Vg2RGA7WqYRHiVU9StKGO4prdVm8AaGwz9zn8sjkT1Jxkc0xt9xlqwY
         5MPZysFYlJStW2g4QTe4fw62Qy4UZ91FJpDmNMUwrwDCOS+Lhu43JnspRHFDz1l8bfS3
         c/BsruYvv4qhqvwUcZ4B/y6fPEm/GOQEx2ssB7GrsSs8sC+zK2TLAYrv3r6+A/LuDM1R
         Zd6LYi1o+VFtskrsXBLFAQ/be6ayXyRPC1N+OZK5jVJIAnYl0Qp9xZUcqdott1tdDiWr
         /Sfrvp+CTCLLDQn5v04KXQoNOsaj2gDBakkz3oqfbDuJq8qANmMvh0iPaj/ZE24JihoM
         Lv1A==
X-Gm-Message-State: ABy/qLZkhmpEJLceRTjRTOgsTxwIT1XnRpNokETc+QL+AyOyEW9NVw7/
        uu64Cw8jPqy+VlXnSU0E8XAIbg==
X-Google-Smtp-Source: APBJJlHrfEpx0F5ZCb1qXKIKZ/LjogbATKeqxd6U5nNdJ3jhzMUvs4D3C+kS3MbzveBt3oiLYSo3MA==
X-Received: by 2002:a37:f70f:0:b0:767:5689:bc7a with SMTP id q15-20020a37f70f000000b007675689bc7amr15355662qkj.25.1689093769195;
        Tue, 11 Jul 2023 09:42:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id k2-20020a05620a138200b00767d6427339sm1165653qki.69.2023.07.11.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:42:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qJGRr-000IQx-QI;
        Tue, 11 Jul 2023 13:42:47 -0300
Date:   Tue, 11 Jul 2023 13:42:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Ahern <dsahern@kernel.org>,
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
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <ZK2Gh2qGxlpZexCM@ziepe.ca>
References: <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca>
 <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711090047.37d7fe06@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 11, 2023 at 09:00:47AM -0700, Jakub Kicinski wrote:

> > So is Infiniband, Jakub has a unique definition of "proprietary".
> 
> For IB AFAIU there's only one practically usable vendor, such an
> impressive ecosystem!!

IB has roce (RDMA Over Converged Ethernet, better thought of as IB
over Ethernet) under it's standization umbrella and every major
commodity NIC vendor (mellanox, broadcom, intel) now implements
roce. We also have the roce support in the switch from all major
switch vendors.

IB as a link layer "failed" with most implementors leaving the
ecosystem broadly because Ethernet link layer always wins in
networking - this is more of an economic outcome than a
standardization outcome in my mind.

Due to roce, IB as a transport and software protocol has a solid
multi-vendor ecosystem.

Jason
