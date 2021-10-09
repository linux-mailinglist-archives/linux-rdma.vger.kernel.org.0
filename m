Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D600142790F
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Oct 2021 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhJIKok (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Oct 2021 06:44:40 -0400
Received: from mx24.baidu.com ([111.206.215.185]:35264 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232564AbhJIKoj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 9 Oct 2021 06:44:39 -0400
Received: from BC-Mail-EX08.internal.baidu.com (unknown [172.31.51.48])
        by Forcepoint Email with ESMTPS id 8F164A796E2FAAF1384F;
        Sat,  9 Oct 2021 18:42:40 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX08.internal.baidu.com (172.31.51.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 9 Oct 2021 18:42:40 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 9
 Oct 2021 18:42:40 +0800
Date:   Sat, 9 Oct 2021 18:42:46 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Lijun Ou <oulijun@huawei.com>,
        "Weihang Li" <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
Message-ID: <20211009104246.GA1205@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210926061116.282-1-caihuoqing@baidu.com>
 <20210927115913.GA3544071@ziepe.ca>
 <20211004195224.GA2576309@nvidia.com>
 <07922740-2d3d-50dc-7239-421e39c42142@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07922740-2d3d-50dc-7239-421e39c42142@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex21.internal.baidu.com (172.31.51.15) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09 10月 21 17:50:50, Wenpeng Liang wrote:
> 
> 
> On 2021/10/5 3:52, Jason Gunthorpe wrote:
> > On Mon, Sep 27, 2021 at 08:59:13AM -0300, Jason Gunthorpe wrote:
> >> On Sun, Sep 26, 2021 at 02:11:15PM +0800, Cai Huoqing wrote:
> >>> Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
> >>> with dma_alloc_coherent/dma_free_coherent() helps to reduce
> >>> code size, and simplify the code, and coherent DMA will not
> >>> clear the cache every time.
> >>>
> >>> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> >>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 20 +++++---------------
> >>>  1 file changed, 5 insertions(+), 15 deletions(-)
> >>
> >> Given I don't see any dma_sync_single calls for this mapping, isn't
> >> this a correctness fix too?
> > 
> > HNS folks?
> > 
> > Jason
> > .
> > 
> 
> Our SoC can keep cache coherent, so there is no exception even if
> dma_sync_single* is not called, but the driver should not make
> assumptions about SoC.
> 
> So using dma_alloc_coherent() instead of kmalloc/dma_map_single()
> can simplify the code and achieve the same purpose.
> 
> Wenpeng Liang


Hi Liang

Thanks for your feedback.

If you think my patch is correct, you can give a Reviewed-by: to it.
You can also give a Tested-by: to it, if the test on hardware was made.

Thanks
Cai
