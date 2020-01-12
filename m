Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48A4138823
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jan 2020 21:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbgALUC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jan 2020 15:02:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36141 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbgALUC5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jan 2020 15:02:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so6578568wru.3
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jan 2020 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faIXdGPpZmJPBIRUgXj9/YDztvaQ38kmTeTF/uAkEoM=;
        b=QdtROlHzyFhmTvUZt4CPaGhvvsMyuxNsMQYndorEkaIAPzHZxVGShKI+DXjNkA80B6
         FBlnNU6sY1uoHfSqzw7cbkEhFgkHawCP6LJp3oQL6qJlzd4ZRa00jcsTFnMcxcDSk4pc
         /SHTDWu0Y88WDxAG/ufbmhagnT9n/iwLXrXXZOm0ana/qnAJU7npLf0bVgRLuQhKTw2g
         a8Tv0e7PGiZVGOhqeMZgWm0wtpB+DQAsozd9SlZBg1oXAwfYIo0HowugsUQ4fhp9j9iX
         KPjatyhcEy/rbJKIAavzMYc2ojb/eSiHHvITo7TTcAYGFj/2Em5uCuXyn+B1b90L5HIg
         OaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faIXdGPpZmJPBIRUgXj9/YDztvaQ38kmTeTF/uAkEoM=;
        b=csz6UEnhB1tVc9s1WLhcjGIhRfksw+I/JJOoZcHSVKuOhYcxis24/6NNbi+AIp2dWb
         AfQ3IGotSjDOstH2c6j/wRJ7lmDKF8Pu4le8WOrueDnPJn9GWHiOgJ+Q657vOYS3Lqqr
         Yr7fHywdGAEEoWeUyAH8hdRBoL4J7zjTWn1bpe7Po8ogSPH4wFe9FjmTH91sOgw1zLUv
         u13MQdSeOMscns9BSUii3MycV84v8e9hdrU1nnwThfzXcRfupgL2+ZM52ITzqDwCwIxq
         IVUWlEEnvTxSO5mwdDZideRZ0G4ikCdrw0fBNhf1RoQZp2392s9M75bWyCsHRTf4UHDS
         ux4A==
X-Gm-Message-State: APjAAAUuhFjA0D8+XWBhAU/lhhBuc7H5MWz9TA+NR9nRXvT+UhRcFAZ+
        Q/xKoLvWLQZx8zbCgrSasIUY82M2
X-Google-Smtp-Source: APXvYqz94ZpNoRFVAGEYkBH+tNPEV1Qynznlt3Ri2jdzOGwqDLwomFtxTaZo3ssEEPVX15BQ7GoVQA==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr13787516wrr.215.1578859375604;
        Sun, 12 Jan 2020 12:02:55 -0800 (PST)
Received: from kheib-workstation (bzq-79-181-7-148.red.bezeqint.net. [79.181.7.148])
        by smtp.gmail.com with ESMTPSA id t131sm11690363wmb.13.2020.01.12.12.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 12:02:54 -0800 (PST)
Date:   Sun, 12 Jan 2020 22:02:52 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix storing node_desc
Message-ID: <20200112200252.GA5112@kheib-workstation>
References: <20191223093943.17883-1-kamalheib1@gmail.com>
 <20200103231212.GA18973@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103231212.GA18973@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 03, 2020 at 07:12:12PM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 23, 2019 at 11:39:43AM +0200, Kamal Heib wrote:
> > When writing to node_desc sysfs using echo a new line symbol will be
> > stored at the end of the string, avoid that by dropping the new line
> 
> Why do we want to do this? AFAIK technically new line is valid in a
> node description.
>

Self-Nack, please drop this patch, I didn't do a good job here.

Thanks,
Kamal

> > symbol and also make sure to return -EINVAL when the supplied string is
> > bigger then IB_DEVICE_NODE_DESC_MAX.
> 
> This makes sense though
> 
> > diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> > index 087682e6969e..2de5f6710c0b 100644
> > +++ b/drivers/infiniband/core/sysfs.c
> > @@ -1263,12 +1263,21 @@ static ssize_t node_desc_store(struct device *device,
> >  {
> >  	struct ib_device *dev = rdma_device_to_ibdev(device);
> >  	struct ib_device_modify desc = {};
> > +	size_t len;
> >  	int ret;
> >  
> >  	if (!dev->ops.modify_device)
> >  		return -EOPNOTSUPP;
> >  
> > -	memcpy(desc.node_desc, buf, min_t(int, count, IB_DEVICE_NODE_DESC_MAX));
> 
> > +	if (count > IB_DEVICE_NODE_DESC_MAX)
> > +		return -EINVAL;
> > +
> > +	len = strlen(buf);
> 
> Why strlen? The buf is count bytes long.
> 
> > +	if (buf[len - 1] == '\n')
> > +		len--;
> 
> And if it is zero bytes this buffer underflows
> 
> > +	strncpy(desc.node_desc, buf, len);
> 
> What was the point of switching away from memcpy?
> 
> > +	desc.node_desc[len] = 0;
> >  	ret = ib_modify_device(dev, IB_DEVICE_MODIFY_NODE_DESC, &desc);
> >  	if (ret)
> >  		return ret;
> 
> Jason
