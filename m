Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B6D354ED7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhDFInz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhDFInz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 04:43:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2594613C0;
        Tue,  6 Apr 2021 08:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617698627;
        bh=n55AKm7NKZdW4zVc4V9RUVKC0QGEF0q6ngCuGlXsuEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRjDtQ2hetRDrmsP46QFkemcDWGxZK2kgUUC0y1cWYhIoPQBUQJo/t7XE8Tz6jjNe
         Q2mYJ2dTMmXla6FfmK8c9CrbPkrNU8PwAjlme+MSb/9RtTVM2dreic0mTE0ehq0fA4
         ECDJB9Zpn+3RKf/BkdDW2gKDe3lXQh6dFCnkFXLUm0LwdZcHy93zN7QxFM2ELvr9ps
         Nc521MyFAIqJbJBkb0nv2zuXxAmqzRHCwmHb/w6NXwQVWLRmaIyLBG5D1oHurv24va
         odQJ1emOaI1NbWFvnnMIaeh3pfsp3cxvSfXfizJu2Vu+EAne0gvnZHTpc3mpj6Vlzk
         66qq0GVjjA5rg==
Date:   Tue, 6 Apr 2021 11:43:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 4/6] RDMA/core: Remove redundant spaces
Message-ID: <YGwfP0qEDMybR4iZ@unreal>
References: <1617697184-48683-1-git-send-email-liweihang@huawei.com>
 <1617697184-48683-5-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617697184-48683-5-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 04:19:42PM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
> 
> Space is not required between function name and '(', after '(', before ')',
> before ',' and between '*' and symbol name of a definition.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/cache.c       | 10 +++---
>  drivers/infiniband/core/cm.c          | 31 ++++++++---------
>  drivers/infiniband/core/cma.c         | 10 +++---
>  drivers/infiniband/core/device.c      | 64 +++++++++++++++++------------------
>  drivers/infiniband/core/mad.c         | 20 +++++------
>  drivers/infiniband/core/mad_rmpp.c    | 10 +++---
>  drivers/infiniband/core/nldev.c       |  2 +-
>  drivers/infiniband/core/security.c    | 12 +++----
>  drivers/infiniband/core/sysfs.c       |  8 ++---
>  drivers/infiniband/core/user_mad.c    |  6 ++--
>  drivers/infiniband/core/uverbs_cmd.c  | 20 +++++------
>  drivers/infiniband/core/uverbs_main.c |  3 +-
>  drivers/infiniband/core/uverbs_uapi.c | 16 ++++-----
>  13 files changed, 105 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index d779590..0b8c410 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -886,7 +886,7 @@ static void gid_table_release_one(struct ib_device *ib_dev)
>  {
>  	u32 p;
>  
> -	rdma_for_each_port (ib_dev, p) {
> +	rdma_for_each_port(ib_dev, p) {

This space is an outcome of clang formatter. I would say that we are
fine that submitted patches will be with and without space.

Thanks
