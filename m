Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E221B7DD6
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 20:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgDXS0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 14:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXS0P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 14:26:15 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0FC09B048
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:26:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s30so8746797qth.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HyQvYAHjwJLyVidH0iTt5hL0jlsvXQr4bOoVWFxjsmo=;
        b=OqKRDHmxGhrh3eRosmFQNAlK5It1rUCY1HGqZcOYA7vFM8UHVZdeeoQNLzHh3ItK92
         UKRUKHVKsIhVpRS6WH0+0bGQ12MkMCrlbIlt2asELn1hpkCV4E2ALJxVfz2zOEQY0WUV
         KiWJ2zGDmheBEjqdk8LoueBsfYqOjMlUEF9ygizu5m6U6Gy0acZ12Ou2ld4aP7ze4GQo
         LmJnHg15O+3IncFUWB6HzK8DD4nqjvag32uKAQsdUTGUzsbmRxGa1aCXjHA2uQ0IvzeB
         kmBroM6H7OHBQAY2Evzggf7fC/IwpVQIREuArIX1e3+/Rbfla0r/3sz+gAo5aCGn8fWQ
         R2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HyQvYAHjwJLyVidH0iTt5hL0jlsvXQr4bOoVWFxjsmo=;
        b=dG1PKVIu/mhZ/8n1rz909cASkeYHhG/L/v/8HB7OUPFYrTRnx5ly/EkTCW+xak0J/p
         sLMOrfZwiubiqGW/ksmoB711gsfLCH1zBAuhXSKUTZ5ZY6SHLZcJbbNm+DzWcA0uTqzk
         lUvNqO5gCj0i5qK3zNymi5pZhADT/En2D5+oljAvyGKHrVUWT3cpfs6j4H4SV+wFfCZy
         8go910iVQULI3CPM0KFtE86zX9uBfkEC3rwiOyXOvV3jdpUpM+yxjBL5m5KDMSvKf0Mw
         M5Mflbqc4na6EKpI9w+u7YjNxcWi3dTJipXt3gMOP3KABuZSrnESxE4cKdk0jHpfQ8uK
         70WA==
X-Gm-Message-State: AGi0Pub9RFNtItY/2xotmfT7n7Oe5rDz1yaF9UlR2f9H6inC7BNBz/KJ
        YC6oovYMH44Ald3kgjv+RRnC4w==
X-Google-Smtp-Source: APiQypLMapGSGRDTSb26mMGVg8UlQz2912TtjWbUh+kMOT2/zTAgGZZ+XpCH78depJhnEtogIQeAKg==
X-Received: by 2002:ac8:543:: with SMTP id c3mr10581959qth.8.1587752773826;
        Fri, 24 Apr 2020 11:26:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k33sm4303771qtd.22.2020.04.24.11.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 11:26:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS31g-0004Qd-MN; Fri, 24 Apr 2020 15:26:12 -0300
Date:   Fri, 24 Apr 2020 15:26:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 2/3] RDMA/efa: Count mmap failures
Message-ID: <20200424182612.GJ26002@ziepe.ca>
References: <20200420062213.44577-1-galpress@amazon.com>
 <20200420062213.44577-3-galpress@amazon.com>
 <20200424145923.GH26002@ziepe.ca>
 <e0ce4fa2-f802-a17c-2b13-666d086029c0@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ce4fa2-f802-a17c-2b13-666d086029c0@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 24, 2020 at 06:25:54PM +0300, Gal Pressman wrote:
> On 24/04/2020 17:59, Jason Gunthorpe wrote:
> > On Mon, Apr 20, 2020 at 09:22:12AM +0300, Gal Pressman wrote:
> >> Add a new stat that counts mmap failures, which might help when
> >> debugging different issues.
> >>
> >> Reviewed-by: Firas JahJah <firasj@amazon.com>
> >> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>  drivers/infiniband/hw/efa/efa.h       | 3 ++-
> >>  drivers/infiniband/hw/efa/efa_verbs.c | 9 +++++++--
> >>  2 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> >> index aa7396a1588a..77c9ff798117 100644
> >> +++ b/drivers/infiniband/hw/efa/efa.h
> >> @@ -1,6 +1,6 @@
> >>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> >>  /*
> >> - * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
> >> + * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
> >>   */
> >>  
> >>  #ifndef _EFA_H_
> >> @@ -40,6 +40,7 @@ struct efa_sw_stats {
> >>  	atomic64_t reg_mr_err;
> >>  	atomic64_t alloc_ucontext_err;
> >>  	atomic64_t create_ah_err;
> >> +	atomic64_t mmap_err;
> >>  };
> >>  
> >>  /* Don't use anything other than atomic64 */
> >> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >> index b555845d6c14..75eef1ec2474 100644
> >> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >> @@ -44,7 +44,8 @@ struct efa_user_mmap_entry {
> >>  	op(EFA_CREATE_CQ_ERR, "create_cq_err") \
> >>  	op(EFA_REG_MR_ERR, "reg_mr_err") \
> >>  	op(EFA_ALLOC_UCONTEXT_ERR, "alloc_ucontext_err") \
> >> -	op(EFA_CREATE_AH_ERR, "create_ah_err")
> >> +	op(EFA_CREATE_AH_ERR, "create_ah_err") \
> >> +	op(EFA_MMAP_ERR, "mmap_err")
> >>  
> >>  #define EFA_STATS_ENUM(ename, name) ename,
> >>  #define EFA_STATS_STR(ename, name) [ename] = name,
> >> @@ -1569,6 +1570,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> >>  		ibdev_dbg(&dev->ibdev,
> >>  			  "pgoff[%#lx] does not have valid entry\n",
> >>  			  vma->vm_pgoff);
> >> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);
> >>  		return -EINVAL;
> >>  	}
> >>  	entry = to_emmap(rdma_entry);
> >> @@ -1604,12 +1606,14 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
> >>  		err = -EINVAL;
> >>  	}
> >>  
> >> -	if (err)
> >> +	if (err) {
> >>  		ibdev_dbg(
> >>  			&dev->ibdev,
> >>  			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
> >>  			entry->address, rdma_entry->npages * PAGE_SIZE,
> >>  			entry->mmap_flag, err);
> >> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);
> > 
> > Really? Isn't this something that is only possible with a buggy
> > rdma-core provider? Why count it?
> 
> Though unlikely, it could happen, otherwise this error flow wouldn't exist in
> the first place.
> 
> If for some reason a customer app steps on a bug we're not aware of, this
> counter could serve as a red flag.

But there are lots of cases where a buggy provider can cause error
exits, why choose this one to count against all the others?

Jason
