Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB14032C251
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 01:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCCX7o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Mar 2021 18:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239419AbhCCMwR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Mar 2021 07:52:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D94DA64E58;
        Wed,  3 Mar 2021 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614775271;
        bh=ZSe/j5/WA5UiIMC7T0QZMRw6rr+csg/HuA4cNNciTHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayokwzirasaoCkwQKWdCridG/Qlw1pSksDJnJJ8IzQ82yxHBsAYfTZThxEGHGuDoP
         nYQCej/vbnv5kuM4HW2cfbR/ojhckU3arNQVGqF7/7+UPSADt9Ba9oDLtb21VnzQuK
         GHKHoOViKqM0hlh9Yef3SwFbnjXo7j/s711XeIqbLbDAdWJjkv7VXgvQRG1hLSnFWS
         gXB5zicSQA8gEKPB9MFEwqEiULGqEspwb6Fd2tcq5yn5YuzwdCnX/qww+37v5orE3L
         8sOWGSG86F5pVketxFL0LOoI0wVq/hD7/mL1HtCEzOkuPF0xsSyKdIg5uhIxR2DvSt
         Up+xt+8Kjx3/Q==
Date:   Wed, 3 Mar 2021 14:41:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next] RDMA/hns: Add support for XRC on HIP09
Message-ID: <YD+D4zjc1GzHL0bb@unreal>
References: <1614689298-13601-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614689298-13601-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 02, 2021 at 08:48:18PM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
>
> The HIP09 supports XRC transport service, it greatly saves the number of
> QPs required to connect all processes in a large cluster.
>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   3 +
>  drivers/infiniband/hw/hns/hns_roce_device.h |  25 +++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 147 +++++++++++++++++++---------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  32 +++++-
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  51 ++++++++++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  63 ++++++++----
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |   3 +
>  include/uapi/rdma/hns-abi.h                 |   2 +
>  9 files changed, 258 insertions(+), 70 deletions(-)

<...>

> +	u32			xrcdn;

<...>

> +	unsigned long		xrcdn;

Can you use the same type (u32) in all structs, please?

Thanks
