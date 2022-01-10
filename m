Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0D4892AA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbiAJHqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 02:46:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48570 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbiAJHoS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 02:44:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1677B60A5F;
        Mon, 10 Jan 2022 07:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F77BC36AED;
        Mon, 10 Jan 2022 07:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641800657;
        bh=7sa5GcmcwMUjfHEcecE3nDaOPYCjABab1XgRTC3CTTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqR+Fb9OyopZbMr2KGdU4cmeLDEdegAaOhRXPA4/vW5Uv28HkOdtBsmhg8XEDpnEZ
         FwHKFa06bZNLSrn5O2qtWxPEiRUninbKFMhUeIof5Fq/ASi4klPPkDA1OrVa1/VGjw
         BD4Kann7ku6E6mWX/+bnMI7z4s+h/LIH0priUYygyCaGOFTHtiSGEwrfIxpoWQzSZd
         ADl0jm2FqtufociqWJ6bitLx0wiyHB1jmxS9NImLWgbGWjBCz6sEe7Hc/xLWTEOqYk
         bvvk5Y+znwc8FRd/+ne4EMtBiMnMZaZL6N5+YuhRDewxVrdRF97erKRPwUns/dHmR5
         OYHFxMfwrQ+Xw==
Date:   Mon, 10 Jan 2022 09:44:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix missing put_device call in hns_roce_get_cfg
Message-ID: <YdvjzJuSHTQfSONA@unreal>
References: <20220110061234.28006-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110061234.28006-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 10, 2022 at 06:12:34AM +0000, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore. And hns_roce_find_pdev() calls
> bus_find_device_by_fwnode(), which calls bus_find_device().
> We also need to drop the reference taken by bus_find_device.
> 
> Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 +
>  1 file changed, 1 insertion(+)

This file was removed in the commit 38d220882426 ("RDMA/hns: Remove
support for HIP06").

BTW, please recheck your patch submission flow, the received emails have
broken "To ..." field that makes reply do not work.

Thanks
