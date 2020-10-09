Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE76288A51
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbgJIOJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgJIOJk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 10:09:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE9CC0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 07:09:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id y198so10705050qka.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sv98vTK/X8lAT5XjH5xa6U3fAmdH6Wc8Bl/zGlLIaYY=;
        b=Pyzf088d+qQdGBadO1z2RpbXuzqbEm43cRJaOGhneJoZc5A5MwsIG9VKOKpMowq72i
         TRJ1wbgu8QUb71rc9emDn3aSequvhA0G73tHs9XKQho6uy88Nx72rkRUoWz7UhEaAoOO
         GBt9iX6MxXhihgcN1A8Vhj2kVY06JJM6j8HcahZ4r79pXwII0KaXFaSssjBHSMqS6sG+
         M37Nst6hd1G+h9t6YTCCxFeXPvRzwJxUsXbSKXr0lend+46tEq18YVsRw2i8IaqXrLt4
         aPgxh0+Ar6oMq6U0W5zldzAJ9LbYMHTZOYgizPEY1s5JqysfF4HXFoY+dlV9iKhR1VYh
         MUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sv98vTK/X8lAT5XjH5xa6U3fAmdH6Wc8Bl/zGlLIaYY=;
        b=a0fl+vOZbHt2pqnRvRnOYTedMAjRybHzwIOxE2RgfAHaokF6l/iHoPKcDzOa2akFu4
         L1Jyk0PacWZ/vqBPupVCb8dJsDNUt37KKORoHDIO8VkGsRqYl/Or+OTivKfD1unYm2CO
         DB/aDHz+h1pdZ/zjoqcDpwTHG19NAmPKYJjtImpMX3pIKdycKx37Mwhx9L866zM5jpiD
         2yyf3zTKSVHsnPntw0QnHyS8EjWwMUVykf85aggEqJI0/WZhF2UNZoP4+1RzzFSmpghO
         jM7Ij29GhZsz07UVMm+Px3af4OVJIhIEDHXxONKLrHAXd/aAv1RFeVjqZ1ZarguWXS60
         +N9A==
X-Gm-Message-State: AOAM53279iFEtWTuvBEJZbY2N5yKYxe+9KEnh/EFbpOo+teVSHHqZzsy
        v21D73rC423n05Y4A2UV16irgw==
X-Google-Smtp-Source: ABdhPJzOWgAWIPi0Ln4/LrHyZIjdYiR7BXOr8WqyrYlfYhK/UnzWSnlC9OiVQWw2rJ+7XxTvOPrFAw==
X-Received: by 2002:ae9:e509:: with SMTP id w9mr13148846qkf.311.1602252579630;
        Fri, 09 Oct 2020 07:09:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t140sm6147852qke.100.2020.10.09.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:09:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQt5W-001zUV-ET; Fri, 09 Oct 2020 11:09:38 -0300
Date:   Fri, 9 Oct 2020 11:09:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/4] RDMA: Convert sysfs kobject * show functions to use
 sysfs_emit()
Message-ID: <20201009140938.GR5177@ziepe.ca>
References: <cover.1602122879.git.joe@perches.com>
 <7761c1efaebb96c432c85171d58405c25a824ccd.1602122880.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7761c1efaebb96c432c85171d58405c25a824ccd.1602122880.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:25PM -0700, Joe Perches wrote:
> Done with cocci script:
> 
> @@
> identifier k_show;
> identifier arg1, arg2, arg3;
> @@
> ssize_t k_show(struct kobject *
> -	arg1
> +	kobj
> 	, struct kobj_attribute *
> -	arg2
> +	attr
> 	, char *
> -	arg3
> +	buf
> 	)
> {
> 	...
> (
> -	arg1
> +	kobj
> |
> -	arg2
> +	attr
> |
> -	arg3
> +	buf
> )
> 	...
> }

This is nice

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 26 ++++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 14 +++++------
>  2 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
