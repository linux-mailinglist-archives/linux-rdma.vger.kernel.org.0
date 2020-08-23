Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4824ED15
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Aug 2020 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHWL1s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Aug 2020 07:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgHWL1p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Aug 2020 07:27:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B4CC061573
        for <linux-rdma@vger.kernel.org>; Sun, 23 Aug 2020 04:27:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp2so3056812ejc.4
        for <linux-rdma@vger.kernel.org>; Sun, 23 Aug 2020 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QSEsH4yuMkFRoouuUuNWcLcOZpyeaZ3mC4mLu7dgYJo=;
        b=JP5JU2jcMiyVgTY5YV+2GO/OEQdAhqMRo2H7Y2LZr2DMMaOJNxdj0G7Te4QHWaB1FN
         dozHFkjszg5acAtNW1cr309tc/QHLYjBjNiGOanh5sfjAGghyelS7fdzyRo+A2AkXt71
         51t23llKeTahDKj+dKmzXviAwg5v8EamAj2NUcl7y00gj5R7AN+sU6B+tOmI/wLpoVHt
         kCiSTCF/jtaKigW7ENmxiug4AiUX3s7n96Kem0FdWUTytUqY8AunfsvqDV/dWD71PyTi
         jM6YXIIMkjFo9x1NdsxhXc45rZh77Ym5R2F1QUlt2UbD669Z2H66eDJdVxuc9f7yMknz
         Ao7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QSEsH4yuMkFRoouuUuNWcLcOZpyeaZ3mC4mLu7dgYJo=;
        b=miLDTGXs45uwJrgGb9trP7VM+yvLQXFfyDtRtTOTjI+qxKpFiAQ9y5SKE5Vltu20mZ
         /Wn+9NxCt06PN5ultCP6LMZfOSnjEwXrpGXidgbzgGWtOQjWNa7nsnGiVS6vJyxxV+id
         dhx/1ahtM3LmredTIMtRZ5/GHt2b4gdPJtukkw0F2nxI/2uMXnjKpzPdqcxs2faGW9ZM
         lwSa/8bvTx0u9PNN4qjFvoHWwPf3WrvNnUjyWAIW2vyt1mhD4esQ6i4Nyob3qEFEQdae
         bMZGL/X79PMm1HUNOycfa7J5xEAkfksIlo8FCejq8vWlHxDYze5NPEWQinR0aifO+sgC
         3QVQ==
X-Gm-Message-State: AOAM530vrTB7EMGS6ZyzEkIz34PUnGvtybscInfH0OkF1g47u8r967TT
        dknEKNQjip1Lnb5Q/NypqUiqmg==
X-Google-Smtp-Source: ABdhPJxShNOKAPbSRuWbo1tMdDr6vPdfrA4idZaZgFYn/5o7FJCvDs0feXlSwP7scTVCttOq92J2mw==
X-Received: by 2002:a17:906:b082:: with SMTP id x2mr1150051ejy.349.1598182063088;
        Sun, 23 Aug 2020 04:27:43 -0700 (PDT)
Received: from localhost ([5.102.238.126])
        by smtp.gmail.com with ESMTPSA id yh29sm4876698ejb.0.2020.08.23.04.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 04:27:42 -0700 (PDT)
Date:   Sun, 23 Aug 2020 14:27:39 +0300
From:   jackm <jackm@dev.mellanox.co.il>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>,
        Eli Cohen <eli@mellanox.co.il>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx4: Read pkey table length instead of
 hardcoded value
Message-ID: <20200823142739.0000447e@dev.mellanox.co.il>
In-Reply-To: <20200823061754.573919-1-leon@kernel.org>
References: <20200823061754.573919-1-leon@kernel.org>
Organization: Mellanox
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 23 Aug 2020 09:17:54 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Mark Bloch <markb@mellanox.com>
> 
> The driver shouldn't assume that a pkey table is available, this
> can happen if RoCE isn't supported by the device.
> 
> Use the pkey table length reported by the device. This together with
> the cited commit from Jack caused a regression where mlx4 devices
> without RoCE aren't created.

I don't understand. Do you mean that WITH this patch there is a
regression, or do you mean that this patch FIXES the regression?

If this patch fixes the regression, I suggest the following replacement
text for the last paragraph:

If the pkey_table is not available (which is the case when RoCE is not
supported), the cited commit caused a regression where mlx4_devices
without RoCE are not created.

Fix this by returning a pkey table length of zero in procedure
eth_link_query_port() if the pkey-table length reported by the device
is zero.

> 
> Cc: <stable@vger.kernel.org>
> Cc: Long Li <longli@microsoft.com>
> Fixes: 1901b91f9982 ("IB/core: Fix potential NULL pointer dereference
> in pkey cache") Fixes: fa417f7b520e ("IB/mlx4: Add support for IBoE")
> Signed-off-by: Mark Bloch <markb@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/main.c
> b/drivers/infiniband/hw/mlx4/main.c index 5e7910a517da..bd4f975e7f9a
> 100644 --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -784,7 +784,8 @@ static int eth_link_query_port(struct ib_device
> *ibdev, u8 port, props->ip_gids = true;
>  	props->gid_tbl_len	=
> mdev->dev->caps.gid_table_len[port]; props->max_msg_sz	=
> mdev->dev->caps.max_msg_sz;
> -	props->pkey_tbl_len	= 1;

I don't like depending on the caller to provide a zeroed-out props
structure.
I think it is better to do:
   props->pkey_tbl_len = mdev->dev->caps.pkey_table_len[port] ? 1 : 0 ;
so that the pkey_table_len value is set no matter what.

> +	if (mdev->dev->caps.pkey_table_len[port])
> +		props->pkey_tbl_len = 1;
>  	props->max_mtu		= IB_MTU_4096;
>  	props->max_vl_num	= 2;
>  	props->state		= IB_PORT_DOWN;

-Jack

