Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3685B4836DB
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 19:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiACSce (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 13:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiACSce (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 13:32:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9AC061761;
        Mon,  3 Jan 2022 10:32:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9AF611AD;
        Mon,  3 Jan 2022 18:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10505C36AEE;
        Mon,  3 Jan 2022 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641234752;
        bh=iOerCCVgPw7m3xgVqLwgPBv7xJjiu5YEWqCR/KhkxgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obPe3x5mBL/pHmSdhLcGn3So9YjfZUO+jukZ6k+hdNN/7glTDa3qoI+5QRQ/5VFwQ
         UbKcq2NWcVFEm9/Zp9g/yVlyOkOpvH1v+LYyenpZrv7u5h1cCv50euRHk9Ot+m7a1c
         nKQUWnB1LBhgy1O6fifvbB1gIE2CMZsNhUCnrgM9Bv+bDOZ7iyl5eU16vT2e1Yzu5G
         zisis5QdxCdEHPmqvDmphKgtxobhK1HJfg0wmOrZXLUwBgaQXteghHNZSEPNOlNTzP
         +gk6HpHS1nx9flvXJb2I1FvrLhNzv/QYDMptu/h7ps8A2tsgwX/aCdOfbAhiJ0IP2I
         Qi+ww3wCHZhBg==
Date:   Mon, 3 Jan 2022 20:32:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Weihang Li <liweihang@huawei.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA: use default_groups in kobj_type
Message-ID: <YdNBPITFRX+Yolba@unreal>
References: <20220103152259.531034-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103152259.531034-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 03, 2022 at 04:22:59PM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the IB code to use default_groups field which has been the
> preferred way since aa30f47cf666 ("kobject: Add support for default
> attribute groups to kobj_type") so that we can soon get rid of the
> obsolete default_attrs field.
> 
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Christian Benvenuti <benve@cisco.com>
> Cc: Nelson Escobar <neescoba@cisco.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Wenpeng Liang <liangwenpeng@huawei.com>
> Cc: Mark Zhang <markzhang@nvidia.com>
> Cc: Weihang Li <liweihang@huawei.com>
> Cc: Aharon Landau <aharonl@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/core/sysfs.c              | 3 ++-
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
