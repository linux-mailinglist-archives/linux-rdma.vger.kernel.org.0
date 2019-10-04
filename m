Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6FCC1BA
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbfJDR2O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:28:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34209 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbfJDR2O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:28:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so9636103qta.1
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FA74ZJSi0TnMlk2JnIE4dyE0xg2hdHkFTTa7DCSkTYs=;
        b=G2YN7X6yBxKFwxgkP9+HN91dBiRxgSxKrcODCmw3gwN4KRt+IgAbeoCf+As7I9BqY7
         nHOTZvFm0ShCvqLapPr4K+IcVLxtSm6BVQuEyMu90yqH4vGlijcXhdQ1cSbPVc9nwyd6
         Ahf58M8Vn/eZZrJsOpV2wKet3k6mjmFkLVRe+SoLqn6QGbLFnXLBzDpgdQYsbAzFZH5h
         K0yV1ul6Kqs6ltUWOCll69G4rOxrcn/mJ85diqGuJU8gFjDSMPoj4ADiiNP+N6Qt0YMI
         GJ0Pz2zhbtZOWcZAyIoJ0xyKvEvoZOga4PPmqJINS6J3W156z6BPCiUKWHdnAEXLFPeY
         6P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FA74ZJSi0TnMlk2JnIE4dyE0xg2hdHkFTTa7DCSkTYs=;
        b=B3NH7w3+BdcqeGoiZlfY3bR3wBnq3AsLK4xrGYZzAf5/QuGqWeUM8AxUbEJmb42ilH
         8yYCcV9ClayZDsYUGV2qKqXdm9ZAUcRz9+9/3qZPh4pJQR9Hoibp/gVEWzHI7vv39oP4
         I0T14J0n7J8SbqpovmMkZbt/gZ3f6XuJtrwF4kXj0pDUCVLGi8Bk4a7sqarIp+j4Wm4s
         6O7Pgq1pDE9ztUm5WeuuKNb7ZQwyWBWCXf4+Wngy5/2FKx0pCeZqc/gg3DQvCSJw4QWA
         kj8weXUh07QeCNrQYTZMHOIj3kYz401QhAu4ejhRVvWtdDB3Wk5SNB3OfOcBdG0Au0QW
         0YvA==
X-Gm-Message-State: APjAAAX0kPCBBX6xI7n8f0CRmFFu/BA4kBjZIVMnCj+TyXOonUJbmHRR
        e2FuauBk4Or3QjrpaKnnx/QWXQ==
X-Google-Smtp-Source: APXvYqxYWGeO+YEUKOG4kqjENs/qFxWttgxhFxeaIW4bSHvPHpMdTxVPtBjUy29xuehyJn7EAElBGw==
X-Received: by 2002:a0c:eda2:: with SMTP id h2mr14766766qvr.190.1570210091636;
        Fri, 04 Oct 2019 10:28:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h10sm3295235qtk.18.2019.10.04.10.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:28:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRNC-0003pP-5d; Fri, 04 Oct 2019 14:28:10 -0300
Date:   Fri, 4 Oct 2019 14:28:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization
 methods and memory leaks in qedr
Message-ID: <20191004172810.GA13988@ziepe.ca>
References: <20191003120342.16926-1-michal.kalderon@marvell.com>
 <20191003120342.16926-2-michal.kalderon@marvell.com>
 <20191003161633.GA15026@ziepe.ca>
 <MN2PR18MB318226121DAB349647E1903CA19F0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20191004003609.GC1492@ziepe.ca>
 <MN2PR18MB3182A3BF6C37425F9AA82757A19E0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182A3BF6C37425F9AA82757A19E0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 05:10:20PM +0000, Michal Kalderon wrote:
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
> > 
> > On Thu, Oct 03, 2019 at 07:33:00PM +0000, Michal Kalderon wrote:
> > > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Sent: Thursday, October 3, 2019 7:17 PM On Thu, Oct 03, 2019 at
> > > > 03:03:41PM +0300, Michal Kalderon wrote:
> > > >
> > > > > diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > > b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > > index 22881d4442b9..ebc6bc25a0e2 100644
> > > > > +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> > > > > @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct
> > > > > qed_iwarp_cm_info
> > > > *cm_info,
> > > > >  	}
> > > > >  }
> > > > >
> > > > > +static void qedr_iw_free_qp(struct kref *ref) {
> > > > > +	struct qedr_qp *qp = container_of(ref, struct qedr_qp, refcnt);
> > > > > +
> > > > > +	xa_erase_irq(&qp->dev->qps, qp->qp_id);
> > > >
> > > > why is it _irq? Where are we in an irq when using the xa_lock on this
> > xarray?
> > > We could be under a spin lock when called from several locations in
> > > core/iwcm.c
> > 
> > spinlock is OK, _irq is only needed if the code needs to mask IRQs because
> > there is a user of the same lock in an IRQ context, see the documentation.
> > 
> > > > > @@ -516,8 +548,10 @@ int qedr_iw_connect(struct iw_cm_id *cm_id,
> > > > struct iw_cm_conn_param *conn_param)
> > > > >  		return -ENOMEM;
> > > > >
> > > > >  	ep->dev = dev;
> > > > > +	kref_init(&ep->refcnt);
> > > > > +
> > > > > +	kref_get(&qp->refcnt);
> > > >
> > > > Here 'qp' comes out of an xa_load, but the QP is still visible in
> > > > the xarray with a 0 refcount, so this is invalid.
> > 
> > > The core/iwcm takes a refcnt of the QP before calling connect, so it
> > > can't be with refcnt zero
> > 
> > > > Also, the xa_load doesn't have any locking around it, so the entire
> > > > thing looks wrong to me.
> > > Since the functions calling it from core/iwcm ( connect / accept )
> > > take a qp Ref-cnt before the calling there's no risk of the entry
> > > being deleted while xa_load is called
> > 
> > Then why look it up in an xarray at all? If you already have the pointer to get a
> > refcount then pass the refcounted pointer in and get rid of the sketchy
> > xarray lookup.
> > 
> I don't have the pointer, the core/iwcm has the pointer. 
> The interface between the core and driver is that the driver gets a qp number from
> the core/iwcm and needs to get the QP pointer from it's database. All the iWARP drivers
> are implemented this way, this is also not new to qedr. 

That seems crazy.

Jason
