Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA374F928
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 22:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGKUeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 16:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGKUeY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 16:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729ECB7;
        Tue, 11 Jul 2023 13:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07195615F6;
        Tue, 11 Jul 2023 20:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AAEC433C7;
        Tue, 11 Jul 2023 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689107662;
        bh=Tvmu/JdqsFHoqwxn8e5DiBMwjsswLbqpvPrbdWqX3mU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KT2GetEFtYlkaoWB9SkIWERR/pM6252wtR3+uYa5U8hU6Z72yd0jGdfKEHGRCUPDg
         cV6CxM61kiS9aR8QbLm1lVOKFqo7tiDLKsmIyqsbhxa0VksU16jxRrop0XkHgITqSP
         EFW3qqHEOocqEyXqP1oLbP2Pw7wZbnpXltb/judIGIutmoF5JzbncOkM51LN3SO7bm
         E6tbNJFPipV38BWXPsj0vvodOwB6lnCc+5okEl9j4wKGIrXJaVLbiLW7Ru/TvHo4J8
         Gr9Nye/bZVAOskwP2AUf4LN5Tsox+cB+wfVMSPjU9nO5urg3uBLRwuMcGC+sSUCrVw
         seVSCxPh1GKNg==
Date:   Tue, 11 Jul 2023 13:34:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20230711133420.5df88f02@kernel.org>
In-Reply-To: <ZK2k9YQiXTtcGhp0@ziepe.ca>
References: <ZKxDZfVAbVHgNgIM@ziepe.ca>
        <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
        <ZKyZBbKEpmkFkpWV@ziepe.ca>
        <20230711042708.GA18658@lst.de>
        <20230710215906.49514550@kernel.org>
        <20230711050445.GA19323@lst.de>
        <ZK1FbjG+VP/zxfO1@ziepe.ca>
        <20230711090047.37d7fe06@kernel.org>
        <ZK2Gh2qGxlpZexCM@ziepe.ca>
        <20230711100636.63b0a88a@kernel.org>
        <ZK2k9YQiXTtcGhp0@ziepe.ca>
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

On Tue, 11 Jul 2023 15:52:37 -0300 Jason Gunthorpe wrote:
> > Now we're getting into our favorite argument and completely
> > sidetracking the conversation, aren't we? :) And as usual 
> > our ability to present facts is limited by various NDAs..  
> 
> Yes, well, maybe I should stop taking the bait everytime you write
> "proprietary" :)
> 
> > > We also have the roce support in the switch from all major
> > > switch vendors.  
> > 
> > By which you mean all major switch vendors should support basic RoCE
> > requirements. But most vendors will try to put special features into
> > their switches trying to make the full NIC + switch solution as sticky
> > as possible.  
> 
> Yep. At the high end open standards based ethernet has also notably
> "failed" as well. Every switch vendor now offers their own proprietary
> ecosystem on a whole bunch of different axis. They all present
> "ethernet" toward the host but the host often needs to work in a
> special way to really take full advantage of the proprietary fabric
> behaviors.

I'm not familiar with "high end open standards based on ethernet", would
those be some RDMA / storage things? For TCP/IP networks pretty much
the only things that matter in a switch are bandwidth, size of buffers,
power... Implementation stuff.

> > Last I checked every generation of HW from even a single vendor came out
> > with a new congestion control algorithm and add-ons.   
> 
> Probably, but I don't really view this as an IB or roce issue.
> 
> Back in the day, there was "data center ethernet" which was a
> standardization effort to try and tame some of these problems. roce
> was imagined as an important workload over DCE, but the effort was
> ethernet focused and generic. Sadly DCE and successor standard based
> congestion mangement approaches did not work, or were "standardized"
> in a way that had a big hole that needed to be filled with proprietary
> algorithms. Eventualy the interest in standardization seems to have
> waned and several of the big network operators seem to be valuing
> their unique congestion management as a proprietary element. From a
> vendor perspective this is has turned into an interop train
> wreck. Sigh.
> 
> roce is just highly sensitive to loss - which is managed in ethernet
> through congestion management. This is why you see roce and congestion
> management so tightly linked, and perhaps in some deployments becomes
> the motivating reason to look at congestion management.

A lot of "standardization" efforts are just attempts to prove to 
a buyers that an ecosystem exists.

Open source the firmware. Let people actually hack on it and when
the users bring their own algorithms de facto standardization will
happen. Short of that it's all smoke and mirrors.
