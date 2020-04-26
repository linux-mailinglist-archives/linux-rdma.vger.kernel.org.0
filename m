Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7921B90A0
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDZNaF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 09:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNaF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Apr 2020 09:30:05 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78A2C061A0F
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2020 06:30:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k12so12046178qtm.4
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2020 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/u1EA6SrjuL0MU3eCyqoc90mxNG9AZ+yYzgvpbs2G8=;
        b=Ll0+WYhlQN7O3v5Xhfa55yiaUGvDaONbVCmhjwBggzHqEsGxbOH3qngPEfyMBBrCnE
         CbMgyqFIKH48jJQqOnsNrG+7bG/PbzpS4MgeCfWQUhhX/a7b2mfPf6kyRYWL3kYq65B9
         cN1e5Auoi7FU+mizjgl86VcuAfQWcPo0i/x+slHtMNg14YqFBWSXQ6ncFTJ8qCmGNd9b
         QxIg19Odxsvi4SQ8rZq0mh28+2pbqUWrgorBMjtRFH10Yd8dQzxMRtRtmgRAQHdzgZ3Q
         /H8WxDo6T4A90ImC9Ym547pjJBdR+ijMByv1BxvS//8vGV12X+5AmOKoL1CFVOQi8Q4g
         PZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/u1EA6SrjuL0MU3eCyqoc90mxNG9AZ+yYzgvpbs2G8=;
        b=C8bc2Z+YfLijCwIcCc9VcWNmTiutUvkp9ZjO7ARANAxsakIoFHtmREyxFoVYAt+Dyp
         h4qzAC/ddDH6bjwl69b9fVNu6rFJMHvQyyCtRDZ9FGM1k8wnFFicIGC7qyeO9yLba/Ks
         yhEsPs1xosLDGU/1daUEc2nGWrVBIAGNbzUE7Zym0DASqpq3CDDRiG45vfVU1q0m03m9
         8n4Nrz8g/D9b9LwwZtS8x24KC9J++5L62+nB+jmyK7FXOhmTDVEs5jRegtPa0SiCRSVb
         5QiuJ2TGLOux2vWCSMWgBuX3tju7WMocnz2M8sTALWlb2D1k9TFir8ZWFDuPgz9EF9KM
         u/7A==
X-Gm-Message-State: AGi0PuZo0dUDj3D8rln6pRPLuq3BI+WY0Lrd9I79K1RUV0jrABZL16Y4
        d1Yfe+FbXCfkJbR8FRuiy3pNJw==
X-Google-Smtp-Source: APiQypKqBIo5YIi4WxCZZZchfjR5e4byWXS5Kj5y4S88SJc7Alqoao4MTvwMLNNfMdUAO87j9NK49A==
X-Received: by 2002:aed:2f44:: with SMTP id l62mr19022935qtd.390.1587907802643;
        Sun, 26 Apr 2020 06:30:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r128sm7656038qke.95.2020.04.26.06.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 06:30:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jShM8-0007My-LE; Sun, 26 Apr 2020 10:30:00 -0300
Date:   Sun, 26 Apr 2020 10:30:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 2/3] RDMA/efa: Count mmap failures
Message-ID: <20200426133000.GL26002@ziepe.ca>
References: <20200420062213.44577-1-galpress@amazon.com>
 <20200420062213.44577-3-galpress@amazon.com>
 <20200424145923.GH26002@ziepe.ca>
 <e0ce4fa2-f802-a17c-2b13-666d086029c0@amazon.com>
 <20200424182612.GJ26002@ziepe.ca>
 <523c9dee-cedf-b762-8a68-cd1232e87e48@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523c9dee-cedf-b762-8a68-cd1232e87e48@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 26, 2020 at 09:42:27AM +0300, Gal Pressman wrote:
> On 24/04/2020 21:26, Jason Gunthorpe wrote:
> > On Fri, Apr 24, 2020 at 06:25:54PM +0300, Gal Pressman wrote:
> >> On 24/04/2020 17:59, Jason Gunthorpe wrote:
> >>> On Mon, Apr 20, 2020 at 09:22:12AM +0300, Gal Pressman wrote:
> >>>> Add a new stat that counts mmap failures, which might help when
> >>>> debugging different issues.
> >>>>
> >>>> Reviewed-by: Firas JahJah <firasj@amazon.com>
> >>>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>>>  drivers/infiniband/hw/efa/efa.h       | 3 ++-
> >>>>  drivers/infiniband/hw/efa/efa_verbs.c | 9 +++++++--
> >>>>  2 files changed, 9 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> >>>> index aa7396a1588a..77c9ff798117 100644
> >>>> +++ b/drivers/infiniband/hw/efa/efa.h
> >>>> @@ -1,6 +1,6 @@
> >>>>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> >>>>  /*
> >>>> - * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> >>>> + * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
> >>>>   */
> >>>>  
> >>>>  #ifndef _EFA_H_
> >>>> @@ -40,6 +40,7 @@ struct efa_sw_stats {
> >>>>  	atomic64_t reg_mr_err;
> >>>>  	atomic64_t alloc_ucontext_err;
> >>>>  	atomic64_t create_ah_err;
> >>>> +	atomic64_t mmap_err;
> >>>>  };
> >>>>  
> >>>>  /* Don't use anything other than atomic64 */
> >>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >>>> index b555845d6c14..75eef1ec2474 100644
> >>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >>>> @@ -44,7 +44,8 @@ struct efa_user_mmap_entry {
> >>>>  	op(EFA_CREATE_CQ_ERR, "create_cq_err") \
> >>>>  	op(EFA_REG_MR_ERR, "reg_mr_err") \
> >>>>  	op(EFA_ALLOC_UCONTEXT_ERR, "alloc_ucontext_err") \
> >>>> -	op(EFA_CREATE_AH_ERR, "create_ah_err")
> >>>> +	op(EFA_CREATE_AH_ERR, "create_ah_err") \
> >>>> +	op(EFA_MMAP_ERR, "mmap_err")
> >>>>  
> >>>>  #define EFA_STATS_ENUM(ename, name) ename,
> >>>>  #define EFA_STATS_STR(ename, name) [ename] = name,
> >>>> @@ -1569,6 +1570,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> >>>>  		ibdev_dbg(&dev->ibdev,
> >>>>  			  "pgoff[%#lx] does not have valid entry\n",
> >>>>  			  vma->vm_pgoff);
> >>>> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);
> >>>>  		return -EINVAL;
> >>>>  	}
> >>>>  	entry = to_emmap(rdma_entry);
> >>>> @@ -1604,12 +1606,14 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> >>>>  		err = -EINVAL;
> >>>>  	}
> >>>>  
> >>>> -	if (err)
> >>>> +	if (err) {
> >>>>  		ibdev_dbg(
> >>>>  			&dev->ibdev,
> >>>>  			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
> >>>>  			entry->address, rdma_entry->npages * PAGE_SIZE,
> >>>>  			entry->mmap_flag, err);
> >>>> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);
> >>>
> >>> Really? Isn't this something that is only possible with a buggy
> >>> rdma-core provider? Why count it?
> >>
> >> Though unlikely, it could happen, otherwise this error flow wouldn't exist in
> >> the first place.
> >>
> >> If for some reason a customer app steps on a bug we're not aware of, this
> >> counter could serve as a red flag.
> > 
> > But there are lots of cases where a buggy provider can cause error
> > exits, why choose this one to count against all the others?
> 
> It's not one against all others, most if not all of our userspace facing API
> error flows have a similar counter.

Hurm, seems a bit strange, but OK

> And TBH, I think that the mmap flow is quite convoluted with the cookie response
> from the crate verb, so it deserves a counter IMO.

How so? Userspace takes the u64 from the command and pass it to mmap,
what is convoluted?

Jason
