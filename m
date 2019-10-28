Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3455E738A
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 15:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfJ1OXt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 10:23:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbfJ1OXt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 10:23:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id o49so14775873qta.7
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUQCP5CReX2JQZZ5BR+RkTXR4iQpv0CtvhUvEAxVb0Y=;
        b=O9WzZalcNScWDaLsDAX1ZsqT3DQ+inBhqU7p/q2vyX7h4JVXWeGGzdpuwrMnquoI/e
         WL9YdBuX5HkoLzGj1+vuqDbOydLG/+hgo0dvDZUp03iybxdoxIWEDKimLOKSaF5+mQqx
         LPDiehPO2dphLufgBWd0vRhExbSS+ktbqGb2Hf/h4CTgVZfht5dtPMxz37qY7gGd6QC+
         XOoH5L6INfgyA2xJ5psO5iy2ILXlUm/D7P1CyX7ZcbZkGhCuqIZyAt6GAeS14ABhs3RK
         mY2aFlqtVI/adtsVOOI5gxm9WqqNVjfaMPPIF0i6WpoQ3oG3vBmd/h4jgXOuvdIK+8Wf
         dA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUQCP5CReX2JQZZ5BR+RkTXR4iQpv0CtvhUvEAxVb0Y=;
        b=LJBV2CB/HdDQLchQyRAMpesOryhqiOomL14IvwN/dgTvFa7RA8h2djtq4yByO7Sf3t
         C9hsg2Y90rtFIyZX8YBiVrip7Ny5NRJAifVSqpbmWfm1J0PprAxl3C7YT2UQ4keO/4Vc
         7SfJlVR/dUmvbN/hxVBa3HKrPscQ6Vb6FGSjrAMO45BNea6lSJWq2ogPjx2Sdwq2SRyO
         Sq63yuSHvEQMOMVILQv7MELCw3z6YYy+JqvjDVXa5S3k9xuqN2lsVN9p/nsjl5P274lu
         mJPp2SHS7AHUohmtC9JU4+64WNuwQczrlwsxnFr2k49o+Off9y/0ZrCYEdyYa+SxtY9y
         HUZg==
X-Gm-Message-State: APjAAAUrPezNf85q5AjRlNFN9JYcCDV7NQf64NMMhaUkEqQZXWnIVQxn
        tQJS4hn1YxGvD0Rr3vb6kAt8Ug==
X-Google-Smtp-Source: APXvYqz5f/bgBdskahYgG3hj4tMfdpNuheM+qtxqbjUUKMxf+zo6Px3/ntzDkwNmR4axXmcWZ6IN4A==
X-Received: by 2002:a0c:e70b:: with SMTP id d11mr10838637qvn.51.1572272628359;
        Mon, 28 Oct 2019 07:23:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 104sm5681039qtc.6.2019.10.28.07.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 07:23:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP5vv-0002bC-9S; Mon, 28 Oct 2019 11:23:47 -0300
Date:   Mon, 28 Oct 2019 11:23:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: prevent undefined behavior in
 hns_roce_set_user_sq_size()
Message-ID: <20191028142347.GE29652@ziepe.ca>
References: <20190608092514.GC28890@mwanda>
 <20191007121821.GI21515@kadam>
 <20191024163749.GX23952@ziepe.ca>
 <20191024182039.GB23523@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024182039.GB23523@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 09:20:39PM +0300, Dan Carpenter wrote:
> On Thu, Oct 24, 2019 at 01:37:49PM -0300, Jason Gunthorpe wrote:
> > On Mon, Oct 07, 2019 at 03:18:22PM +0300, Dan Carpenter wrote:
> > > This one still needs to be applied.
> > > 
> > > regards,
> > > dan carpenter
> > 
> > Weird, it is marked changes requested in patchworks. An email must
> > have been lost??
> >
> 
> Maybe you replied to a different thread?
> 
> > I think I probably wanted to say that:
> > 
> > > >  	/* Sanity check SQ size before proceeding */
> > > > -	if ((u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes ||
> > > > +	if (ucmd->log_sq_bb_count > 31 ||
> > > > +	    (u32)(1 << ucmd->log_sq_bb_count) > hr_dev->caps.max_wqes
> > > > ||
> > 
> > Overall should probably be coded using check_shl_overflow(), as this
> > later shift:
> > 
> > 	hr_qp->sq.wqe_cnt = 1 << ucmd->log_sq_bb_count;
> > 
> > Is storing it into an int and hardwring '31' because it magically
> > matches that lower shift is pretty fragile.
> > 
> > More like this?
> > 
> 
> Yeah.  I like your patch.  I'd feel silly claiming authorship though.
> I'm willing to, because it's nice, but probably you should just give me
> Reported-by credit instead.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Okay applied to for-next

Jason
