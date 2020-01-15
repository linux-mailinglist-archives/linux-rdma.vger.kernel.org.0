Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A513CCA0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 19:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAOSyx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 13:54:53 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42747 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAOSyx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 13:54:53 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so7846303qvb.9
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 10:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aeumuASkju7BfxW17O6djQegoG34syXLIe8MTerSZtY=;
        b=D6opquw1A1KRbGnOxpwBirQSHUR+scyqS1BcPVw/4fRenz+XIqRQ0iC14rzafAGQZt
         gW9LLXDbBUDNmfJrEDkbCFGwkvoLl6z3BRh1jgXpqyGWsVdSi3jTQ03mPVdW08XYyPeZ
         Jg7mtmknv9kslEH8yePh+Sypz0NpkFfhjxkKUqwxE2NxftPRD9d1S7oD8VCecMy23lyW
         7yORNLMaOWCMMMvtRWL83CMtcwWTi8tJja8NLkyani704ss5npvyQS53p/QuOyLkc6/e
         ZH+fdn9f/BIdviPcAl3TYV59794FftB87rJUhy5vdBL0XV4OsjtvekVXeOh+rtdEPzPa
         CJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aeumuASkju7BfxW17O6djQegoG34syXLIe8MTerSZtY=;
        b=tg7Bf1rydq7EchMs8NLP4xXqAbBsHqEEXPYDuw0kamc90fhrNukrM0l6dlirZ8a/gT
         ykAcS8hUCohWhYdeU6g4GZGNvJ8IXqjKe5qJ0aDlNr6Z4Ra5pjJ+6Q+OuMiPoyZ56sn3
         7qnl89Mqd6LpBT1zVRuFxsn4mM9TmAhMgOG+fz65LEpq+m+nrbrZ1QSZLxAJBfDgrF99
         ECaYCEza0IfVuKZ+eRpO9CSRz/L+n9EUndE7A1UBkn1foSsmX8Qec0dg/ey9avOe9wNk
         LPUr09dZF8944YfMuCz7WZhju/XI2HiaWB4CuZ6amE2GiqFO88CWvlyB+0laCoaQu1uw
         Y1nQ==
X-Gm-Message-State: APjAAAUj/DYeLpZfAFn87qiIIxTA66g3pirowJb3AWf7SPLSDGjmUxdZ
        768URO3pWtTGru80V0AF0Kvm7w==
X-Google-Smtp-Source: APXvYqz1rYZxVfHO7jWp7x4WNlVUC0ZTNd6jTB5fd1kRo+9Zx1f7e5PysHpRa6C+tPb3sJkGTClCYw==
X-Received: by 2002:a05:6214:1348:: with SMTP id b8mr23435054qvw.137.1579114492684;
        Wed, 15 Jan 2020 10:54:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q126sm8866806qkd.21.2020.01.15.10.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 10:54:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irnoZ-0002tP-EW; Wed, 15 Jan 2020 14:54:51 -0400
Date:   Wed, 15 Jan 2020 14:54:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next V2] RDMA/core: Fix storing node description
Message-ID: <20200115185451.GA10660@ziepe.ca>
References: <20200114081455.1240-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114081455.1240-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 14, 2020 at 10:14:55AM +0200, Kamal Heib wrote:
> Make sure to return -EINVAL when the supplied string is bigger then
> the node_desc array.
> 
> Fixes: c5bcbbb9fe00 ("IB: Allow userspace to set node description")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/core/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index 087682e6969e..aa90a42d6565 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1268,7 +1268,9 @@ static ssize_t node_desc_store(struct device *device,
>  	if (!dev->ops.modify_device)
>  		return -EOPNOTSUPP;
>  
> -	memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));
> +	if (strscpy(desc.node_desc, buf, sizeof(desc.node_desc)) == -E2BIG)
> +		return -EINVAL;
> +

So, while this is the preferred code, when I checked on how this all
works what I found was madness.

The desc.node_desc is not a string. It is an array of 64 bytes, where
all 64 bits can be valid without a null termination.

Code that accesses the array like:

drivers/infiniband/core/sysfs.c:        return sprintf(buf, "%.64s\n", dev->node_desc);

Is 'correct', while code like this:

drivers/infiniband/hw/bnxt_re/main.c:   return scnprintf(buf, PAGE_SIZE, "%s\n", rdev->ibdev.node_desc);

Is wrong, it could run past the end of the character array.

Obviously this is all insane. If I apply your patch then userspace
looses the ability to have a 64 character node description.

If you want to persue this then please fix the underlying issue - make
node_desc into an always null terminated string:
 - Increase the width to 65
 - Never use memcpy to manipulate it
 - Devices should set it from the mad/device array using
    scnprintf(dev->node_desc, sizeof(dev->node_desc), "%.64s\n", mad_desc)
   Perhaps this should be a helper function
 - Devices should read it into a MAD format using some approach
   zero fills
 - Get rid of all the .64 format strings

Thanks,
Jason
