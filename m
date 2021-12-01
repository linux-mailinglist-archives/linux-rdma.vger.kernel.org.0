Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353A0464A48
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Dec 2021 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbhLAJEh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Dec 2021 04:04:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54440 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbhLAJEg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Dec 2021 04:04:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48D4ACE1D91
        for <linux-rdma@vger.kernel.org>; Wed,  1 Dec 2021 09:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF37C53FCC;
        Wed,  1 Dec 2021 09:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638349273;
        bh=9XRWr1KMtGyszMt13eiTjw0olk2vtEnh9JJwtT3j2jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VluJT+78BdtHvF1cL+GFxj6IXVwc40IGR2/U8KI8BaNM/FNFkfr3ebVdqk9/769sM
         ZBHfD0XFAgrbEDKVIzlsVFCzPuj9LvT6rxbLOSxXLN77vmLNomxmaA5UM4ArsUPYe9
         HWEa8YpDCcUlOP9WXcXHDPWFY537G0KAlcR4bT0kMmOec2UAVd0P1zM1j8qvS/PuOs
         XCmOnlriMkcpXgRSyYysbAgQMUgLYU5rr66Qnnho05zsVSEOB/LErXdH4fT2kxpwEx
         WRylx4XyqcTKTj/jsbsfKT5QFSb5aCTAjAKbPUR6CsHx0f+2QfYAD6oSFJd7KOccvw
         tvv/P/JvgCz8Q==
Date:   Wed, 1 Dec 2021 11:01:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v5 for-next 1/1] RDMA/hns: Support direct wqe of userspace
Message-ID: <Yac51K7JGND00Awg@unreal>
References: <20211130135740.4559-1-liangwenpeng@huawei.com>
 <20211130135740.4559-2-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130135740.4559-2-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 30, 2021 at 09:57:40PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> Add direct wqe enable switch and address mapping.
> 
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 42 +++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
>  include/uapi/rdma/hns-abi.h                 |  2 +
>  5 files changed, 98 insertions(+), 11 deletions(-)
> 

The description of pgprot_device() is still unsatisfactory,
but everything else looks ok.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
