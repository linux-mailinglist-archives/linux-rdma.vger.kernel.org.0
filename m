Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A68459EF8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKWJPC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 04:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232770AbhKWJPC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Nov 2021 04:15:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CB0860FC3;
        Tue, 23 Nov 2021 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637658714;
        bh=bLePhzGBOEh5+8TovzayeofStVxdBUMNIEuWBELqOF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a938Tk05EMMJ45QxBmV+NtpwMrQwvDrAMEXUI8JGFObfQZL4l1A/fhXY46sQyGPRE
         Kqpx3ErODYCLroS45LVV2mpZY/eCpZpz1mHy3roIpkAjW3yhdYlvBdNPKVvuvQ29LE
         LZjBk37CStWFr72p9/tRMGm6Tz9wTWzO3JkfVhnq3REepsR6FdSOZGAHwmss8QAdz4
         5Ic4l8UdhAw69IWJhuv+ECqXMRDvSJdIHB/cpqGPMy/+En3p4+nwufGS9oaRZpFQvd
         HqC958MLE4eLZKXEz29NbpdrkyUzv0D86TbfIwvWfXUy4yksSrSn8y7UV/dgSuqY20
         fpnPgTfSKXmgQ==
Date:   Tue, 23 Nov 2021 11:11:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/cma: Remove open coding for overflow in
 cma_connect_ib
Message-ID: <YZywV4lRV7g4Bj87@unreal>
References: <1637599733-11096-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1637599733-11096-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 05:48:53PM +0100, Håkon Bugge wrote:
> The existing test is a little hard to comprehend. Use
> check_add_overflow() instead.
> 
> Fixes: 04ded1672402 ("RDMA/cma: Verify private data length")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 835ac54..0435768 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4093,8 +4093,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
>  
>  	memset(&req, 0, sizeof req);
>  	offset = cma_user_data_offset(id_priv);
> -	req.private_data_len = offset + conn_param->private_data_len;
> -	if (req.private_data_len < conn_param->private_data_len)
> +	if (check_add_overflow(offset, conn_param->private_data_len, &req.private_data_len))
>  		return -EINVAL;

The same check exists in cma_resolve_ib_udp too.

Thanks

>  
>  	if (req.private_data_len) {
> -- 
> 1.8.3.1
> 
