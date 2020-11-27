Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2682C65C7
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 13:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgK0Me6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 07:34:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgK0Me6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 07:34:58 -0500
Date:   Fri, 27 Nov 2020 13:34:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606480496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDWbnRd+f/JZr3bfd4uAWaFJ6D4EoJsadC7HxpQ3oOc=;
        b=FD3pSQV4ChqFogZtSWr3du9JYPtfPi3uwyS0Up3Q00W1KvhBf7PPeVLWTXtQVzRAwXnEnt
        iUneLnlChoJdfafVK5vPiVnY7jT8E2vKyCxM6EXzTzlz0icqupfson62tum7Y7ijojgWY+
        WTCc3kzobuOg6l8sRBuU8iJrhD/kFQUsXZZC2x4yrxewjBjzfFNEMn8SQRQQn6+x+6LYSP
        fhddo5ewYpwAnfZt1Fd8/jffNrgEtFM1A6ebE4C1IbUoOvz2WUr/iZa9HBIOK/UJUjLxd4
        cL+PSjCq9lKTDL/XKvXqsynJ13goxEQ1h56o4sJdkX28yZu/HJIm07ImHw7WCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606480496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oDWbnRd+f/JZr3bfd4uAWaFJ6D4EoJsadC7HxpQ3oOc=;
        b=jZdYIYxpmaORVDDUQ47OS6Gq/OQpZe8uNaBCKh0QxUOXXyjUbHl/lh5whto+6t2JVc/5DB
        Er22jD0gqF02xSDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@nvidia.com>,
        linux-rdma@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201126205357.GU5487@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-11-26 16:53:57 [-0400], Jason Gunthorpe wrote:
> > --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> > +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> > @@ -187,12 +187,8 @@ iser_initialize_task_headers(struct iscsi_task *ta=
sk,
> >  	struct iser_device *device =3D iser_conn->ib_conn.device;
> >  	struct iscsi_iser_task *iser_task =3D task->dd_data;
> >  	u64 dma_addr;
> > -	const bool mgmt_task =3D !task->sc && !in_interrupt();
> >  	int ret =3D 0;
>=20
> Why do you think the task->sc doesn't matter?

Based on the call paths I checked, there was no evidence that
state_mutex can be acquired. If I remove locking here then `mgmt_task'
is no longer needed.
How should task->sc matter?

> > -	if (unlikely(mgmt_task))
> > -		mutex_lock(&iser_conn->state_mutex);
> > -
> >  	if (unlikely(iser_conn->state !=3D ISER_CONN_UP)) {
> >  		ret =3D -ENODEV;
> >  		goto out;
=E2=80=A6
> Jason

Sebastian
