Return-Path: <linux-rdma+bounces-357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B908480CDF2
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 15:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEA91F21912
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1349F7F;
	Mon, 11 Dec 2023 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R92vx2g1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580892733
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 06:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702303794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAAvf3xWNdiA5yQ9F9boRppGC66yI7jkgPgymNCWcs8=;
	b=R92vx2g1hnIfX/zQAobP/qqL87O/PCGxvERK8tK5LgP8YqNmBhXR+Xzbbs820f92560POo
	IELifdkvHQRCx3iIxL2TI2wIJ3PuQRRmCgfhgd/jzHvRbHQzk5leAU4cqRTXGdGKVbDkDH
	KBQ95ZXe7b0jnOtixzl/0OtSn9SNHaQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-y5lZoxzZMvaIOGuVlE_RUg-1; Mon, 11 Dec 2023 09:09:51 -0500
X-MC-Unique: y5lZoxzZMvaIOGuVlE_RUg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c644341390so2237076a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 06:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303790; x=1702908590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAAvf3xWNdiA5yQ9F9boRppGC66yI7jkgPgymNCWcs8=;
        b=jfPk7DiPdWqfhb4jzTjF2uNEfdBOVSJzB296XEdcG5SVeJMGqPuo35HnbCnn4ZAwA0
         gnK4jmaOrEDsbfyp3b9XEE2eGbGGXePz7R6xhbzf8mqoj5wpEfb8kRlxaexCv/mnQcDz
         MkvYauls+z4KeC+fWc+iZ5cPSSyfd1rE8ZAmNoRk+QSaDDYIxqVrWEcYkT1VM+VjUibJ
         LDDoqb/W3EbuKP0R9dWTb+HX/Bo8EtHzWzMYCOe1PpE0jg++1A3WbzGQWYBPvf9Q0M7m
         McBCPoLIXNqsL43Izhai+pVplk/fnYlxQ89ca4CxU7o4ssrXLyzueWK1E98iGwmOFYzJ
         Rh5A==
X-Gm-Message-State: AOJu0YyhNQ1f26X6aneZBEdGdh0KegH+mWf7TZOvBKHLcQJiusF4UBSU
	p2F79natjlP/AU4YMx+YfSyaUpa/gpNbf8wGT7OJxQyJYQ03uIy+hOdcZ0dtLaZPW4fa2y3Z0Ni
	qbR4sGjEK1ccEa2nnFcFKOViWOQmKOL36ZGCQbg==
X-Received: by 2002:a17:90a:6e42:b0:286:6cc1:2cb1 with SMTP id s2-20020a17090a6e4200b002866cc12cb1mr1793349pjm.59.1702303790639;
        Mon, 11 Dec 2023 06:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR/6GiM7/0vFHkDfHn1IFcQktjWuh0v87SXtOh2Gg4WrYU1x0CHfs0k8+lUvJEjfRLnRGu0eSx98AeHk6CVWU=
X-Received: by 2002:a17:90a:6e42:b0:286:6cc1:2cb1 with SMTP id
 s2-20020a17090a6e4200b002866cc12cb1mr1793339pjm.59.1702303790367; Mon, 11 Dec
 2023 06:09:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211131051.1500834-1-neelx@redhat.com> <20231211132217.GF4870@unreal>
 <20231211132522.GY1489931@ziepe.ca>
In-Reply-To: <20231211132522.GY1489931@ziepe.ca>
From: Daniel Vacek <neelx@redhat.com>
Date: Mon, 11 Dec 2023 15:09:13 +0100
Message-ID: <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the warning
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 2:25=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
>
> > Please fill some text in commit message.
>
> Yes, explain *why* you are doing this

Oh, sorry. I did not mention it but there's no particular reason
really. The @Subject says it all. There should be no logical or
functional change other than reducing the span of that critical
section. In other words, just nitpicking, not a big deal.

While checking the code (and past changes) related to the other issue
I also sent today I just noticed the way 08bc327629cbd added the
spin_lock before returning from this function and it appeared to me
it's clearer the way I'm proposing here.

Honestly, I was not looking into why the lock is released for that
completion. And I'm not changing that logic.

If this complete() can be called with priv->lock held, the cleanup
would look different, of course.

That said, If you'd like to keep this patch I can send a v2 with the
above details in the message body. Otherwise feel free to drop this.

--nX

> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers=
/infiniband/ulp/ipoib/ipoib_multicast.c
> > > index 5b3154503bf4..ae2c05806dcc 100644
> > > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > @@ -536,17 +536,17 @@ static int ipoib_mcast_join(struct net_device *=
dev, struct ipoib_mcast *mcast)
> > >     multicast =3D ib_sa_join_multicast(&ipoib_sa_client, priv->ca, pr=
iv->port,
> > >                                      &rec, comp_mask, GFP_KERNEL,
> > >                                      ipoib_mcast_join_complete, mcast=
);
> > > -   spin_lock_irq(&priv->lock);
> > >     if (IS_ERR(multicast)) {
> > >             ret =3D PTR_ERR(multicast);
> > >             ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\=
n", ret);
> > > +           spin_lock_irq(&priv->lock);
> > >             /* Requeue this join task with a backoff delay */
> > >             __ipoib_mcast_schedule_join_thread(priv, mcast, 1);
> > >             clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
> > >             spin_unlock_irq(&priv->lock);
> > >             complete(&mcast->done);
> > > -           spin_lock_irq(&priv->lock);
>
> It is super weird to unlock just around complete.
>
> Jason
>


