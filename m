Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4A2C9758
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 06:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLAF4w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 00:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgLAF4w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 00:56:52 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0202087D;
        Tue,  1 Dec 2020 05:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606802172;
        bh=B1K67qgGNMzxx+UEV/labWZCkLIUIDIFTYBgle2z888=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frMCmnziNUTN/w9Xl2M/pzOxJbB+pTzqZoVeErfgvDIM1+Ynuy5iLijRU4LGZ2fFv
         V+HYRwJCBZN+SzOFGuVc/ZnFu4s46Dj9b0AQ2e7P/MMnxMKHKN5ChhCNUbE6Qck44+
         gSBqwBUStbaqa143YDuXELklTa6I54ytWvZ75QSE=
Date:   Tue, 1 Dec 2020 07:56:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/3] RDMA/hns: Fix 0-length sge calculation error
Message-ID: <20201201055607.GD3286@unreal>
References: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
 <1606558959-48510-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606558959-48510-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 28, 2020 at 06:22:37PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> One RC SQ WQE can store 2 sges but UD can't, so ignore 2 valid sges of
> wr.sglist for RC which have been filled in WQE before setting extended sge.
> Either of RC and UD can not contain 0-length sges, so these 0-length
> sges should be skipped.
>
> Fixes: 54d6638765b0 ("RDMA/hns: Optimize WQE buffer size calculating process")
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
