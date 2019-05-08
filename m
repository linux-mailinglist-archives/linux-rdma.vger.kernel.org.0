Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC1E17B6B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEHOSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 10:18:45 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:41337 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHOSo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 10:18:44 -0400
Received: by mail-qk1-f177.google.com with SMTP id g190so3448053qkf.8
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0sGsOAVx8VIlM9AUztrSkVB39lMZrYtVTzkiRQarhIg=;
        b=TO3cBfU6wod9zQFlG9r7m/2WzotvS27KUP4ECSRNOVYMl+rrS+xPDU9I6UOKbnPqEB
         By3JaqEYQXtqKQ3d2c73UpTSdLVUOjV4FV54n3k1q7cOZA31T50dNpwWqGzL6+TlqVR3
         M5g1omUrd/j+FwJKMwoYqGAk8m3+IuQTiVF/Qy4dsR9/5dynwp7qUrtWuuoMoxGjtgLt
         R3m8ET1Fb0CMYcYX7mMrwPtKjwl9pco3mGy9o7RFfDEZAFFkWs7eYukPYC74iZ/dC9Jh
         9cTKzKo8OgvZ9VaKMG/2kP77+5TcFZhH5kbYmFEimX/78yzuPc7jhvffDFWVZaTbhSm1
         P+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0sGsOAVx8VIlM9AUztrSkVB39lMZrYtVTzkiRQarhIg=;
        b=KgqIONNuoKc0qzYpU3kzUcuhqdFDIjYsstHJG+ZUCxcdHNaXhIa35j+1ziB3diot2a
         cx5DrxNsYgSNsKJe79/sNGTfXTy1ljC7qSm3MjepYczuK3YXLJ6VqqGr3GYqsGX7Oe3Z
         ochDRRfwU7nUlh1ownO0uZ2csShDUIv9/VEbkXYdKndGVMrgInM1smUkDk+hMmDbe+B+
         3N0a84Y5OH7XDh9JZswXdgZkcr1U2qZyiM154HwJapdC4wIQCH6sj29jnTVUnkiFaZyB
         MCwIU+2dT3vw2CMjL5CJtyYNFvpXRpi9mIg0FcEkLS0yS4yIQJYNXSrb4OTNxSHBHhs1
         xXgg==
X-Gm-Message-State: APjAAAVCrfmfB4K29Vn4/DZrvZaNN+BZwuC0Nu//TbeUZXh56VDb/Y8I
        2VrJYOHK7bo5cX9RB4pqSXWjpg==
X-Google-Smtp-Source: APXvYqzJqOvTEI/5QNmxQVRKuK5fFhFULZdyleR86TUev1Cg56bp0gTrgY/ep29t6h7bpVmWUcHlVg==
X-Received: by 2002:a37:6117:: with SMTP id v23mr15323702qkb.309.1557325123534;
        Wed, 08 May 2019 07:18:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id w23sm5869887qki.40.2019.05.08.07.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 07:18:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hONP7-0002ID-SI; Wed, 08 May 2019 11:18:41 -0300
Date:   Wed, 8 May 2019 11:18:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190508141841.GD32282@ziepe.ca>
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <20190507161304.GH6201@ziepe.ca>
 <20190508062600.GV6938@mtr-leonro.mtl.com>
 <20190508133028.GB32282@ziepe.ca>
 <20190508140644.GB6938@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508140644.GB6938@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 05:06:44PM +0300, Leon Romanovsky wrote:
> On Wed, May 08, 2019 at 10:30:28AM -0300, Jason Gunthorpe wrote:
> > On Wed, May 08, 2019 at 09:26:00AM +0300, Leon Romanovsky wrote:
> > > On Tue, May 07, 2019 at 01:13:04PM -0300, Jason Gunthorpe wrote:
> > > > On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> > > > > So, Jason and I were discussing the soft-iWARP driver submission, and he
> > > > > thought it would be good to know if it even works with the various iWARP
> > > > > hardware devices.  I happen to have most of them on hand in one form or
> > > > > another, so I set down to test it.  In the process, I ran across some
> > > > > issues just with the hardware versions themselves, let alone with soft-
> > > > > iWARP.  So, here's the results of my matrix of tests.  These aren't
> > > > > performance tests, just basic "does it work" smoke tests...
> > > >
> > > > Well, lets imagine to merge this at 5.2-rc1?
> > >
> > > Can we do something with kref in QPs and MRs before merging it?
> > >
> > > I'm super worried that memory model and locking used in this driver
> > > won't allow me to continue with allocation patches?
> >
> > Well, this use of idr doesn't look right to me:
> >
> > static inline struct siw_qp *siw_qp_id2obj(struct siw_device *sdev, int id)
> > {
> > 	struct siw_qp *qp = idr_find(&sdev->qp_idr, id);
> >
> > 	if (likely(qp && kref_get_unless_zero(&qp->ref)))
> > 		return qp;
> >
> > kref_get_unless_zero is nonsense unless used with someting like rcu,
> > and there is no rcu read lock here.
> >
> > Also, IDR's have to be locked..
> >
> > It probably wants to be written as
> >
> > xa_lock()
> > qp = xa_load()
> > if (qp)
> >    kref_get(&qp->ref);
> > xa_unlock()
> >
> > But I'm not completely sure what this is all about.. A QP cannot
> > really exist past destroy - about the only thing that would make sense
> > is to leave some memory around so other things can see it is failed -
> > but generally it is better to wipe out the QP from those other things
> > then attempt to do reference counting like this.
> 
> No, no,, no, it is still not enough. I need to be sure that destroy path
> always successes and kref_get(&qp->ref) doesn't guarantee that.
> 
> The good coding pattern can be seen in rdmavt
> https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/sw/rdmavt/cq.c#L316
> They krefing and releasing extra structure outside of user visible object.

In some respects I would rather the core code put a proper memory kref
in every object. We wanted this anyhow for the netlink restrack
stuff, and used properly it is pretty useful.

Jason
