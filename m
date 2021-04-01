Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310A2351AE1
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhDASDZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236535AbhDAR57 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 13:57:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C004611CD;
        Thu,  1 Apr 2021 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617282490;
        bh=t2ugAO/Kdxgael7F2cUdb+2cMpZpMNW1DV6ZE+IWeas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Su8tWzEWYvWSDvMHJmmwtDkrsZ7QI+zhxMuNp6hQQLWLsyOn6w1o5YvHs1Cv8ve3X
         i6hWhUcd0MW4wfCN5xqsvcnP28QTdmVYnihuf1gVno4NoicX27L6Yr95zStgy/NzuM
         egbGnhGeKNLCM5QQbZbgUo+/ZmW6aXhaihrWoqUdnT/DHJ/YzBcdH4YYfYtOh80Apm
         xbXfIyjR5StdyVyQo9TzY/g2DWpg2viXUnrH788sEpWZILQWFi3leE22XTkmLhMNoZ
         XryKBLJ4ufuEu6dhGhxevr3Guj2SP5MHoJ/XiQ1nzVgCv6Ur1NJP8jjog7D2kv59Zd
         T0YduYFP9loMw==
Date:   Thu, 1 Apr 2021 16:08:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/3] RDMA/hns: Enable all CMDQ context
Message-ID: <YGXFtqbcVGLiKfXD@unreal>
References: <1617262341-37571-1-git-send-email-liweihang@huawei.com>
 <1617262341-37571-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617262341-37571-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 03:32:19PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Fix error of cmd's context number calculation algorithm to enable all of
> 32 cmd entries and support 32 concurrent accesses.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    | 62 ++++++++++++-----------------
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
>  2 files changed, 27 insertions(+), 41 deletions(-)

<...>

> -	WARN_ON(cmd->free_head < 0);
> -	context = &cmd->context[cmd->free_head];
> -	context->token += cmd->token_mask + 1;
> -	cmd->free_head = context->next;
> +
> +	do {
> +		context = &cmd->context[cmd->free_head];
> +		cmd->free_head = context->next;
> +	} while (context->busy);
> +
> +	context->busy = 1;

This "busy" flag after do-while together with release in __hns_roce_cmd_mbox_wait()
is interesting thing. Are you sure that it won't loop forever here?

Thanks
