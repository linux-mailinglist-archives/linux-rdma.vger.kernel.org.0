Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02409383ACC
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhEQRNM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 13:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235732AbhEQRNL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 13:13:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F5C160FEF;
        Mon, 17 May 2021 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621271514;
        bh=nwAzkSZpeGznhq0PWWLHgzXJ5tl5F2AnCka9p482VKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3mzb5+x0uaHEoWQgv61lYPFmU1ZUzubPzPv7rKCOt4qWXwK1uMD7Ok35v94SXzYP
         le/w2MR9UcLuIHbT2GAs2MI0gF9A0i7r6zYqJETYge072xHCskuSlwPILUj0D0xQ50
         AJzxP9oy64nBOX7+jSw1NlD15Nf+eN5MeoFxll08=
Date:   Mon, 17 May 2021 19:11:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 11/13] RDMA/qib: Use attributes for the port sysfs
Message-ID: <YKKj2Fx+9t0KnoGr@kroah.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <11-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 01:47:39PM -0300, Jason Gunthorpe wrote:
> qib should not be creating a mess of kobjects to attach to the port
> kobject - this is all attributes. The proper API is to create an
> attribute_group list and create it against the port's kobject.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/qib/qib.h       |   5 +-
>  drivers/infiniband/hw/qib/qib_sysfs.c | 596 +++++++++++---------------
>  2 files changed, 248 insertions(+), 353 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
> index 88497739029e02..3decd6d0843172 100644
> --- a/drivers/infiniband/hw/qib/qib.h
> +++ b/drivers/infiniband/hw/qib/qib.h
> @@ -521,10 +521,7 @@ struct qib_pportdata {
>  
>  	struct qib_devdata *dd;
>  	struct qib_chippport_specific *cpspec; /* chip-specific per-port */
> -	struct kobject pport_kobj;
> -	struct kobject pport_cc_kobj;
> -	struct kobject sl2vl_kobj;
> -	struct kobject diagc_kobj;
> +	const struct attribute_group *groups[5];

As you initialize these all at once, why not just make this:
	struct attribute_group **groups;

and then set the groups up at build time instead of runtime as part of a
larger structure like the ATTRIBUTE_GROUPS() macro does for "simple"
drivers?  That way you aren't fixed at the array size here and someone
has to go and check to verify you really have properly 0 terminated the
list and set up the pointers properly.

thanks,

greg k-h
