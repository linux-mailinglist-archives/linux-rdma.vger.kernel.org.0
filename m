Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054ED23E0F1
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgHFSZ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgHFSUP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Aug 2020 14:20:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45654C061575
        for <linux-rdma@vger.kernel.org>; Thu,  6 Aug 2020 11:13:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p25so5327789qkp.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Aug 2020 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9yZTfDkEtZAucfZS+LTKDBeUjM1A4AsheL4Ns5qz48o=;
        b=Vob4VjLjMjw8QEx0srRb6AStJuBSKw/7ZQZwPKrnmlnCGqMxVTxZEruxzDoGbBq+oo
         34460532lj1Mias3E2IM+yOnk74kzfgVpu4hFTILa0bUAR9G5kEBewt/yGZazzNnmta8
         h9Op2kMGvdZULV7cFw42FdshN1A/hATDSF+eHb6zhZA1Kpjv1VPIwGHxsJHzqIVtIxSy
         UXTBsj7xAJ2EZ82yLgBLinYDXjsFfO0K4UPLvsHfTBeOmpTzk16tMUoa4Ta8CmQ3YlB3
         k+zkqZuSRdtlFcczLK/V+rjxqMngCs27DEXZvi0g8f2TLF4ektFkTh4IRu4K4fWr+cl5
         QRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9yZTfDkEtZAucfZS+LTKDBeUjM1A4AsheL4Ns5qz48o=;
        b=c2BlnFqo9QaxbldUOf/uALFtFHgXvCWmq38I4fewv4tMqo63C651CetxdR78f/PES0
         tDRGZsWA3RDK9gqmsbZ2ZV6iPzep5qED4qSS0mCWPcfRqE4javSI0HBdinr0+uAaHs82
         FHlX59ZsLZ02Xmvg+GcPBFILOwDeafmIRDHuCfkirIjlM1tdlhtEJH+HBdvfE7/vVxN9
         +YeNp38bYPf3oVd78Yjefdirxx3b5W62HMgtdMJo6nA2Tq1XrHzJcFPslBaziiuXC0f7
         IhfZtHPNrOAqruWe21eQf/z+rowY9tIpN1chrtB6rfaeIlbN3LB0vKCRsuqcCBiUwGFX
         PIAQ==
X-Gm-Message-State: AOAM531IMRhhv0/zldbh49dI2sGYnVpRw7WTKKXAW+r5Y8FwIAkgv9RI
        EltG0Uy5tmCJUgI33LZLYdUcZg==
X-Google-Smtp-Source: ABdhPJzgOFc2hANTgnQ6sTf92pAcoW8/J6OWFg3g19UAoi6XQ6dxEWZ+rDTYkzs7Xut3xIrM8qEStw==
X-Received: by 2002:a37:d83:: with SMTP id 125mr10036498qkn.430.1596737614950;
        Thu, 06 Aug 2020 11:13:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d143sm4643471qkc.59.2020.08.06.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:13:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k3kOT-004SGh-0u; Thu, 06 Aug 2020 15:13:33 -0300
Date:   Thu, 6 Aug 2020 15:13:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        maorg@mellanox.com, maxg@mellanox.com, monis@mellanox.com,
        chuck.lever@oracle.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: Re: [PATCH] IB/core: Fix wrong return value in _ib_modify_qp()
Message-ID: <20200806181333.GT24045@ziepe.ca>
References: <20200802111542.5475-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802111542.5475-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 02, 2020 at 07:15:42PM +0800, Tianjia Zhang wrote:
> On an error exit path, a negative error code should be returned
> instead of a positive return value.
> 
> Fixes: 7a5c938b9ed09 ("IB/core: Check for rdma_protocol_ib only after validating port_num")
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  drivers/infiniband/core/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 53d6505c0c7b..f369f0a19e85 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1712,7 +1712,7 @@ static int _ib_modify_qp(struct ib_qp *qp, struct ib_qp_attr *attr,
>  		if (!(rdma_protocol_ib(qp->device,
>  				       attr->alt_ah_attr.port_num) &&
>  		      rdma_protocol_ib(qp->device, port))) {
> -			ret = EINVAL;
> +			ret = -EINVAL;
>  			goto out;
>  		}
>  	}

This was already fixed here:

commit 47fda651d5af2506deac57d54887cf55ce26e244
Author: Li Heng <liheng40@huawei.com>
Date:   Sat Jul 25 10:56:27 2020 +0800

    RDMA/core: Fix return error value in _ib_modify_qp() to negative
    
    The error codes in _ib_modify_qp() are supposed to be negative errno.
    
    Fixes: 7a5c938b9ed0 ("IB/core: Check for rdma_protocol_ib only after validating port_num")
    Link: https://lore.kernel.org/r/1595645787-20375-1-git-send-email-liheng40@huawei.com
    Reported-by: Hulk Robot <hulkci@huawei.com>
    Signed-off-by: Li Heng <liheng40@huawei.com>
    Reviewed-by: Parav Pandit <parav@mellanox.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
