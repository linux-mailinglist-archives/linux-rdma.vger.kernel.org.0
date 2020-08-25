Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA73251555
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgHYJ1U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYJ1S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 05:27:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369F5C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 02:27:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so5927619wro.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 02:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BsNDHmkedWg4LSFZ2MgEXa16GhrMcrPldUbtM6uF3BE=;
        b=g37SMro+6IZ/ufN0I7NYn6mlBz9WpLFUW50ZCs4RA58iDFan29yhs1UyYpVfKOj3v/
         BjvCJ7ZXAsbXySfkCFtUY9tsxTFXB8IUPf2TXflGzFtKMQMUnq2EJ2+jlKvcqDfjirin
         JfnAVGslI6yYpmz5SxfQ3NSWNIihm7huO1nizwwXi9bCCyOAwp0CSxSoItZMg4A3HmFY
         KPHaYWc9hzTMKqWOdtAUVfd3twQ+wyiyIOerMhpBgC+qRqY5zrAddXdLwKnI0jhIh9Pu
         J6cGF46dJFJN0NNIi/5ZhItx6D6wrJyJZOogzjrN7l3q5CD3k+ZhNeav8IQRXm80uYAb
         nE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BsNDHmkedWg4LSFZ2MgEXa16GhrMcrPldUbtM6uF3BE=;
        b=K/Dt0o7OSQHU9RSUJm+74OVzSf65SSUciz2viwlgK5JZzD+bzB4HCZoWKOv3DonnSO
         21g8DINGZCZahPq4EZ7N7OH0ZXPdJNKWtQWiPndcXFVFXe6BeVEvUMTpY4iuqJqjIFps
         UQdFbxZJ46uMsxrCvTX1CTgDeWHwZJ3vuKE+CoCPZhshzAo/Ur+7ECAguxZqPef/mkoi
         OtQSThg9OtsZ/GmFv/nDtz+qgVjdFDC2cfIpTFWv7uJWMErpJ2++pT9oSWl8pqey88na
         6VEiXt6KCGDLLbp48M3pe7A4R5IU6YOd739+uNsd3wjS+DyIMFHeDx6Q7Mp+a/t+vKWc
         2WXw==
X-Gm-Message-State: AOAM531W7TCzRbAJ7y9OUfIoYuZX+YAnWh5mR13W5B/WcZb+0LuQnwqS
        SiUeZCrsibl7VwwbadT0CHgy1M4MDfQ=
X-Google-Smtp-Source: ABdhPJzv48wu4UcACEZ8E1s0vYhPvnVTjczXm9d105mHyNfSmc3+Sj32YOXiva6pNxV8Gx9MB9AMuQ==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr9676323wru.222.1598347636900;
        Tue, 25 Aug 2020 02:27:16 -0700 (PDT)
Received: from kheib-workstation ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id n205sm5394880wma.47.2020.08.25.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 02:27:16 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:27:13 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH v3 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200825092713.GA194958@kheib-workstation>
References: <20200824155220.153854-1-kamalheib1@gmail.com>
 <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee809280-48d2-a5cc-c1a1-521ba58636b1@acm.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 09:41:14AM -0700, Bart Van Assche wrote:
> On 8/24/20 8:52 AM, Kamal Heib wrote:
> > +bool rxe_is_loaded;
> 
> The name of this variable seems wrong to me. My understanding is that rxe_module_init() is
> called whether or not rxe has been built as a module. Consider renaming this variable into
> e.g. "rxe_initialized".
>
OK, I'll change it.

> > diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > index ccda5f5a3bc0..12c7ca0764d5 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
> > @@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
> >   	struct net_device *ndev;
> >   	struct rxe_dev *exists;
> > +	if (!rxe_is_loaded) {
> > +		pr_err("Please make sure to load the rdma_rxe module first\n");
> > +		return -EINVAL;
> > +	}
> > +
> >   	len = sanitize_arg(val, intf, sizeof(intf));
> >   	if (!len) {
> >   		pr_err("add: invalid interface name\n");
> 
> The above message is misleading. Consider changing it into e.g. the following:
> 
>     Please wait until initialization of the rdma_rxe module has finished.
> 
> Additionally, how about returning -EAGAIN instead of -EINVAL?
>
Yes, this makes more sense, I'll change it.

Thanks,
Kamal

> Thanks,
> 
> Bart.
> 
> 
