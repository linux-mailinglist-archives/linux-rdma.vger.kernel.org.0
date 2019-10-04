Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1CCB2CB
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 02:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfJDAgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 20:36:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34134 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfJDAgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 20:36:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so6320479qta.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Oct 2019 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQD4omyi9N/BtTj9DWECyLs/QrR/F0iIMAjAxhi1qps=;
        b=krFL0rTSChGPuuJH1OiRImxrPnIYMui/yMrL+WIWG9qv75HfcK62jPdUtIJqF2yO+4
         o8kWr6DRW/KBlZWIoK/IPyx56EkBG9qsuVug02bCeVrEy66Y1PWVnEp0b5SIcXxeggO/
         doEyXh9Jd/pW/B+rBZRqYP3nbHDCyk4YmSnEjYHuns9NVUiD6xPUXwS40UVsOO+9+pEM
         SdmwH7Zn+GEqcD5vZpze+MsCWwT5lgbKIi7eQY+pVWCgYd6UQMxqX5cXrd2PCX6/8kqx
         DSm4Z+S6Bdsu/rBq217yHkAxrQUmcH5yoqtPj5TuWPsCrF/naWTWAJNGg0+0NovJ9PrX
         lsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQD4omyi9N/BtTj9DWECyLs/QrR/F0iIMAjAxhi1qps=;
        b=NlXnZ5MHegBaLxaOrX7q21VmgJpcEVaFWH/8Rrm3ssoi+0Tnpeb0RlcO4Y5rG0jmQS
         mA7+MMOHCs++lSJNGwWOEsXTFL0lDEqAhrSByZWKpZ+va6ufeDYflVSIlOEhU5kd1Wwf
         xhzpALxAsDvuaihleRzLAZnHimSCi8WGbrIO91/4VXx3id03OzCsa83M9nGVTqG8i00o
         SQKU8sM4ekSnqxrNlAaEy8mo8VdkbVcAR6P48R/ha0IRKNvbcDObQxki3ZjLFfyQKfNo
         LSivGVZDyOYjkTRkX+nsC3TjWbEeG0w42HmeJLMNU4tJkbDij5HGWlRYOCziyNyw05/y
         h6Xw==
X-Gm-Message-State: APjAAAXfQ1hZ51hnr6l4iICjEzh+qFLa+GfyTdlXIECC5FlzY+Xq3aV8
        qooTx4Yd8TlmLw4BK3I5oFy1vA==
X-Google-Smtp-Source: APXvYqzQG8j1FHSgYyJF5HyKxQOEQHCgsIYaP183TRzaYNgqq5SxePebgXnG++hE8YGn0shDTjv8FA==
X-Received: by 2002:ac8:2ac5:: with SMTP id c5mr13565584qta.297.1570149370660;
        Thu, 03 Oct 2019 17:36:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g31sm2521543qte.78.2019.10.03.17.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 17:36:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGBZp-00017T-LP; Thu, 03 Oct 2019 21:36:09 -0300
Date:   Thu, 3 Oct 2019 21:36:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Message-ID: <20191004003609.GC1492@ziepe.ca>
References: <20191003120342.16926-1-michal.kalderon@marvell.com>
 <20191003120342.16926-2-michal.kalderon@marvell.com>
 <20191003161633.GA15026@ziepe.ca>
 <MN2PR18MB318226121DAB349647E1903CA19F0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB318226121DAB349647E1903CA19F0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 07:33:00PM +0000, Michal Kalderon wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, October 3, 2019 7:17 PM
> > On Thu, Oct 03, 2019 at 03:03:41PM +0300, Michal Kalderon wrote:
> > 
> > > diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > index 22881d4442b9..ebc6bc25a0e2 100644
> > > +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct qed_iwarp_cm_info
> > *cm_info,
> > >  	}
> > >  }
> > >
> > > +static void qedr_iw_free_qp(struct kref *ref) {
> > > +	struct qedr_qp *qp = container_of(ref, struct qedr_qp, refcnt);
> > > +
> > > +	xa_erase_irq(&qp->dev->qps, qp->qp_id);
> > 
> > why is it _irq? Where are we in an irq when using the xa_lock on this xarray?
> We could be under a spin lock when called from several locations in core/iwcm.c

spinlock is OK, _irq is only needed if the code needs to mask IRQs
because there is a user of the same lock in an IRQ context, see the
documentation.

> > > @@ -516,8 +548,10 @@ int qedr_iw_connect(struct iw_cm_id *cm_id,
> > struct iw_cm_conn_param *conn_param)
> > >  		return -ENOMEM;
> > >
> > >  	ep->dev = dev;
> > > +	kref_init(&ep->refcnt);
> > > +
> > > +	kref_get(&qp->refcnt);
> > 
> > Here 'qp' comes out of an xa_load, but the QP is still visible in the xarray with
> > a 0 refcount, so this is invalid.

> The core/iwcm takes a refcnt of the QP before calling connect, so it can't be with
> refcnt zero

> > Also, the xa_load doesn't have any locking around it, so the entire thing looks
> > wrong to me.
> Since the functions calling it from core/iwcm ( connect / accept ) take a qp
> Ref-cnt before the calling there's no risk of the entry being deleted while
> xa_load is called

Then why look it up in an xarray at all? If you already have the
pointer to get a refcount then pass the refcounted pointer in and get
rid of the sketchy xarray lookup.

I'm skeptical of this explanation

Jason
