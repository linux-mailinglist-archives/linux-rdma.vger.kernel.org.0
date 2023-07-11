Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF174ED8C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 14:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGKMFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGKMFH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 08:05:07 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B48DE5C
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 05:05:05 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7679ea01e16so524900785a.2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689077104; x=1691669104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sDj/nUPhv/hb6kVZTAGV+ec/xse6Mtcau18exq4wFfg=;
        b=mJnWqKwDMLasfvZIgnnLjeZubYFEXhgQUriyniboKusYls6+C/mL95Tb4P3ahgb2ly
         UfehINYtKiyzWMJO7IBeL7aNkUVN35SC7VJSVhsw9KFV+q6daoC6BFGPiFkn9FxJajzq
         DGaYAQI13Yu06T7GpFqdzzv2PTbbTGLptVEHwLsBhHqorONeJqwlaEcsfs34Zcq3U9NW
         XheotZD5oo/pIyPuubqGr9ReOeVNnM5310WYJjx2KhOphWoCWgsJm7SEkfyGIZEM39en
         /F4Qgy6k5T17Cq8QWsHYSMwY4649dC6Iii0F1d1VtBiEHgup1B7AOz6IJUhmKOxeJZFa
         AZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077104; x=1691669104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDj/nUPhv/hb6kVZTAGV+ec/xse6Mtcau18exq4wFfg=;
        b=LHf5pt1WXqDFwLTqFEHrBRB8CfjrSvH/o6CFtXA8Z4FXGKLmuke28yzWUGUUMA9h0c
         jBmrivcF+gyeVdWn502hlIPTKF8QfW89db/TJDgYm6Y2sAPxccORN/VHEsnqwuZoc4vw
         kft6uMkBB8BLwXzSfEviRGctXKN2q0yG9jtvGG8JU6aOuNvpRQvZXvZpjt542PAeynfX
         8NhiKSoNEKAoJlbyaKpaE3SUDjy+av4p3zYevpID29/5nNt2X1AcEs9esUSTmOG3aB/U
         yVqZ831aAsO1+I3o5ZkbyFoGVzKUknN/sI96s+dpCzIgAXeWijtsScYJ4+3b68Fw96CW
         tCMQ==
X-Gm-Message-State: ABy/qLYpoZbPB5A9eYb9/QtQ1Dox8P+bZYAPo5tY4ppzTHVTY/euwNKW
        kYauefuLHV6Ji/iSm5yJVNWCyw==
X-Google-Smtp-Source: APBJJlHlMSiZUq+WY356by/kwiQKIEq734XHbryNHy9OPRb10YQGqsssS7qFeOD/eSjn/EPBX8tRnQ==
X-Received: by 2002:a0c:a98d:0:b0:635:e209:178c with SMTP id a13-20020a0ca98d000000b00635e209178cmr12615604qvb.10.1689077104237;
        Tue, 11 Jul 2023 05:05:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id q17-20020a0ce211000000b006362d4eeb6esm956869qvl.144.2023.07.11.05.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:05:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qJC74-0008zp-Q7;
        Tue, 11 Jul 2023 09:05:02 -0300
Date:   Tue, 11 Jul 2023 09:05:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZK1FbjG+VP/zxfO1@ziepe.ca>
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca>
 <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711050445.GA19323@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 11, 2023 at 07:04:45AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 09:59:06PM -0700, Jakub Kicinski wrote:
> > On Tue, 11 Jul 2023 06:27:08 +0200 Christoph Hellwig wrote:
> > > Not going to comment on the rest of this as it seems bat shit crazy
> > > hacks for out of tree junk.  Why is anyone even wasting time on this?
> > 
> > Noob question - how does RDMA integrate with the out of tree junk?
> > AFAIU it's possible to run the "in-tree" RDMA stack and get "GPU
> > direct".
> 
> I don't care and it has absolutel no business being discussed here.
> 
> FYI at leat iWarp is a totally open standard.

So is Infiniband, Jakub has a unique definition of "proprietary".

RDMA works with the AMD and Intel intree drivers using DMABUF without
requiring struct pages using the DRM hacky scatterlist approach.

Jason
