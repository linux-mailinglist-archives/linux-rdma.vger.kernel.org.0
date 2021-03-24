Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641CA3473C2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCXIgd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 04:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhCXIgA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 04:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01DDC619D5;
        Wed, 24 Mar 2021 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616574945;
        bh=lRmBJLKLgpWqx7EpuYhmgA/mUpFez+T3e0jlpCeydbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXWWL8L+EFc8v7CX+65jEwgmKP4YJh58uf/s44aGkfqgl9Bq/QOPr7bvfhEzVQcy7
         uiTaa7tZkQM/U8SrBfkhxrS+VpyYUJRZ1NK5zMC/xF3NLIXCiUEpGrNl2knB3vAHFO
         qacBtpESZsiWpTgJ4WbkBDsdSx4l5L0y4EB70yO/E3ykvGsQfSEdGQeWUqKezeYdQ3
         k314ICjacxip4tgQkJggCQudI+P9/basDZtStPPInSJKI+8BXp2T0OARiiuMtehdxK
         TPP0nDcXCQOwBVhaPV7SDI4cPEDsUgFAQkAG18UHhWKTqB+5YD564SaqyvdkbeCW8J
         PjZQDc3a01DYw==
Date:   Wed, 24 Mar 2021 10:35:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 for-rc] RDMA/cxgb4: Fix adapter LE hash errors while
 destroying ipv6 listening server
Message-ID: <YFr53WGz5VO+4soI@unreal>
References: <20210322162210.21964-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322162210.21964-1-bharat@chelsio.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 09:52:09PM +0530, Potnuri Bharat Teja wrote:
> Not setting ipv6 bit while destroying ipv6 listening servers may result in
> potential fatal adapter errors due to lookup engine memory hash errors.
> Therefore always set ipv6 field while destroying ipv6 listening servers.
> 
> Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> Changes since v0:
> - modified commit description to inform the severity of patch.
> ---
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index 8769e7aa097f..76faba892f00 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -3599,8 +3599,9 @@ int c4iw_create_listen(struct iw_cm_id *cm_id, int backlog)
>  
>  int c4iw_destroy_listen(struct iw_cm_id *cm_id)
>  {
> -	int err;
>  	struct c4iw_listen_ep *ep = to_listen_ep(cm_id);
> +	bool ipv6 = false;

You don't need extra variable, simply pass true/false.

Thanks
