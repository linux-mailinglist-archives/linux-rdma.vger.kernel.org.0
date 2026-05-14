Return-Path: <linux-rdma+bounces-20687-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PGHLSewBWppZwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20687-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:21:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F8540EAE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C21E307FDE0
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9B3C0A00;
	Thu, 14 May 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcAWgA6w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE33B6C1E
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757473; cv=pass; b=GPtpBMZ3ugjmcDoLTK2WT95FlO6i56beet/kuuXw0JZlM8z3PKQNo+nJ7etK7YTMiNpxSSrBYFeOiNu8j1UDjqC9GAImJKk4tVfueWBbrHwWTJfw79Gtrtd930RjcZVxnKSd/Dc7lSjnj801ja8c8pnNMzfqmcMuxVrFYNVmuHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757473; c=relaxed/simple;
	bh=1l94VpQH6C489MB7AXIRGHt7qCtMVCo/4SssbeQZ2hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8FTX2kPCXpkvVPTxhSz8l7p/aireN8yjJExjFBuYKuoQ3Z3OPAeSZYrDl+mmhh/LWL3iL3k/9MUGviuvjkIjy/pIwVV/tsqwhY4hXUgTuW6nfsLjLlXMLyH3G7HU/a661TOJEUC/+veRd6HuOvLQbn6pdslr/7ueA23TOnHNNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcAWgA6w; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c477a3278so8794004d50.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 04:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778757470; cv=none;
        d=google.com; s=arc-20240605;
        b=UbVkdokAkl8IlhMnH5T1p8FXEEjXKnOj/9POAbc4brBcApUI3DS5WVFmgun5ZrcVfn
         ScaufddbggU8DpzRtY/kAwpb5LwwSstKqFn1uvAg/FSbCJj5RtlITTER3EZV98RzTTj2
         fJlUZL7mY04GrvolAPMNFo+izAITtMEDQV32gQAHN2KOLXlsmnhbti5NFnElpq9KjK0A
         kfbWxR9AU/picziGyPDd7Y3GGHYc9Ye7a8TO1k+W+1a+o+7Q74ZHbTidsmrzcjt8WsgA
         mOizHWVAzyVGiEZZC6R83Q2ebutbzRmvZbd8iHvF3XUSDwEJs98SCQ2ZymNuiN5EZSY0
         vmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uJtMdwOZNkWuXVqDHUqsUES/sB/+FbaOGN+im7H9Kl0=;
        fh=4BK0834p7KlTS1WFDI3QfAopI7A6JFeQOyNBQpMfRyE=;
        b=aoLtlD0n1XddYPpApvh0YJiNnsRIbEb298SrzFo6Vh1XQaar+G9TkqYdfn/paXiQLH
         VFZymNXYHqYzGcf0WJn5Z1khuT3De+Zj/Y5ccOfi4tYYku8iMehPx3F9kCEipwYQIOv7
         uY8f43kze9kzo53T2gqYlQ6Fgz7VosvsLXOroc5VT4hlT8IOmzt9JjDyBCTw/rJZ+RBo
         M/ZVneyG8/i1DRRYG360cvfefSagLvPHJC+isao/yRU7FRU0W/fBHpuWdkPmktjALUN1
         +3wMA0FFTQRXmwGmeKi3/MWwvS+n+VahWJRLBctArhWRVXS+Dlu6SAdsLgBcP7Kv6p0n
         3KYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778757470; x=1779362270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJtMdwOZNkWuXVqDHUqsUES/sB/+FbaOGN+im7H9Kl0=;
        b=RcAWgA6wRQYAqE1UCOK3VuVdwSwEednkyqM/UZsysP2I6LsufS3GRN6v84bWL1V/3f
         aJU9SIGpu7bsNMd2xg7Eh2qS7KSVP8eXHRlLnnSFrchqJMFTuu0f6+rvOgSU6CxX6Tze
         b2/ZmsOdakvPsmEyFkJ3B0dsXPaAfs7JxHiMmJv7MSpk1J8p220s8ed0lFUpLiej3JX9
         5XriZ7UVgfY8K8Ks3g7BMgB3hY6/pO6e7qbuaIcvQ224RvsP2naJ7szfzRRz2W6MSM3V
         kNChFXJaErKgZXn6r0XN+74I1u49lbBBag2+nktrp3xFFKv7YA56v22sUfKW7Icf7J+C
         1P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778757470; x=1779362270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJtMdwOZNkWuXVqDHUqsUES/sB/+FbaOGN+im7H9Kl0=;
        b=fRm+C2AVpcMl529VCrqgS8iuWWy6oCFYbWYjgMb+rI6fEn8AOapZG9y3pmrOUdtl5s
         e4Lq9RL2jDiFGiyHzGJYwTSAOSX6E8HrBbZTXeN2o3f5tO5qDU2P/W3/8S4dO9QyZLpQ
         8dtLyuNb1SV2VFSFZxVNywOt2CQcDAebOCyjQmhtY4QhnoQIMa2yEyFmupRNIhtWUq6U
         4nJnh+GRQFFtRjM+QP1dGkjERTRn+YrJCRrcLEJ6nChPHTdwA55iXY9/HBYc5sBDWvWP
         25olj78/UbUIMsir9bpQC1mt4y1FMMhC5kzH47RmBPyephQjBTPcO5lr4bbzm+z/gO6o
         //AQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yU4JaRoW9uapj9SkcuPv4Gm+NL9eIYpHz3KsOUSdYm6Yr5U8h4cf1Xbfgd3EAPNRLJmkCdMziS5D0@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOhIkfiEW0jTtdmTxgQ7Mwt1R9jyzFFylhHk7JFaMMV68QUna
	wVk7vjaRLwCUeeQqFj7QADQVwX+SGmDtPwR+SZyl08ah9XaexHFgIj4yB003pe6wSRzU6/pnGDR
	Z0xhs89XBGDmtx3cuHcbSpVSNzqFHewM=
X-Gm-Gg: Acq92OFKjYUOujNGE4wxnfFRQr8/Z5uBBjkadXEDZDGHlVeZPDr92/EcGn0cB6YN4Oi
	XWGBMkVKauh8tqiP3S+GDiezON5ZsnzgedrAJyTy5RCBTIKjT7q3QX/21a8YuctBibWrztymHFg
	ZkTaf9rOT6CIbudnYFxUZyRsk8GhAC8SF6sj1/yp/bLEYIkyuN+Rb+hrZl2HISzU+NEhRG0OJPB
	1MMGUAk+0TbAHa6t7Frvfo3Or75Pxi2jHzG/mmD+JbMXLzaJnPc4FdOQXD0zvkCmp0zWyYiB5r3
	dvy9CG8mSLFyLnuy14w=
X-Received: by 2002:a05:690e:c4a:b0:654:63e0:d1d1 with SMTP id
 956f58d0204a3-65df82a7d19mr6292286d50.43.1778757469723; Thu, 14 May 2026
 04:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511121649.770529-1-lgs201920130244@gmail.com> <20260514071038.GM15586@unreal>
In-Reply-To: <20260514071038.GM15586@unreal>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 14 May 2026 19:17:29 +0800
X-Gm-Features: AVHnY4JZwr0lsyhUjT6srG-vycQEXslmk5fap4ghBJ1wB98TEW20sTg_JPYIC8I
Message-ID: <CANUHTR_00aG8Lf=cm=KKKK=jvHDiDoEjhEt88-JYByD+iQGLrw@mail.gmail.com>
Subject: Re: [PATCH v5] IB/mlx4: Fix refcount leak in add_port() error path
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Roland Dreier <roland@purestorage.com>, Jack Morgenstein <jackm@dev.mellanox.co.il>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 641F8540EAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20687-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Leon,

Thanks for reviewing.

On Thu, 14 May 2026 at 15:10, Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 11, 2026 at 08:16:49PM +0800, Guangshuo Li wrote:
> > After kobject_init_and_add(), the lifetime of the embedded struct
> > kobject is expected to be managed through the kobject core reference
> > counting.
> >
> > In add_port(), several failure paths after kobject_init_and_add() free
> > struct mlx4_port directly instead of releasing the embedded kobject with
> > kobject_put(). This leaves the kobject reference count unbalanced and can
> > lead to incorrect lifetime handling.
> >
> > Fix this by routing the kobject_init_and_add() failure path through
> > kobject_put(), and by calling kobject_del() before kobject_put() on
> > later failure paths after the kobject has been successfully added. Since
> > the release callback may now be called for partially initialized
> > mlx4_port objects, make mlx4_port_release() tolerate NULL attribute
> > arrays.
> >
> > The duplicated attribute array frees in add_port() are removed, as the
> > release callback now handles them.
> >
> > Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
> > Cc: stable@vger.kernel.org
>
> This line is not needed.
>
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v5:
> >   - split the add_port() error paths after kobject_init_and_add()
> >   - call kobject_del() before kobject_put() for failures after
> >     kobject_init_and_add() succeeds
> >
> > v4:
> >   - route all add_port() failures after kobject_init_and_add() through
> >     a single kobject_put() based error path
> >   - remove duplicated attribute array frees from add_port()
> >   - keep mlx4_port_release() tolerant of partially initialized objects
> >
> > v3:
> >   - make mlx4_port_release() tolerate NULL attribute arrays
> >   - drop the parent kobject reference on the kobject_init_and_add()
> >     failure path before putting the embedded kobject
> >
> > v2:
> >   - note that the issue was identified by my static analysis tool
> >   - and confirmed by manual review
> >
> >  drivers/infiniband/hw/mlx4/sysfs.c | 44 ++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
> > index b8fa4ecfc961..224a6a1c289d 100644
> > --- a/drivers/infiniband/hw/mlx4/sysfs.c
> > +++ b/drivers/infiniband/hw/mlx4/sysfs.c
> > @@ -380,12 +380,17 @@ static void mlx4_port_release(struct kobject *kobj)
> >       struct attribute *a;
> >       int i;
> >
> > -     for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
> > -             kfree(a);
> > -     kfree(p->pkey_group.attrs);
> > -     for (i = 0; (a = p->gid_group.attrs[i]); ++i)
> > -             kfree(a);
> > -     kfree(p->gid_group.attrs);
> > +     if (p->pkey_group.attrs) {
> > +             for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
> > +                     kfree(a);
> > +             kfree(p->pkey_group.attrs);
> > +     }
> > +
> > +     if (p->gid_group.attrs) {
> > +             for (i = 0; (a = p->gid_group.attrs[i]); ++i)
> > +                     kfree(a);
> > +             kfree(p->gid_group.attrs);
> > +     }
>
> You should reorder the add_port() function to make sure that
> kobject_init_and_add() is called after alloc_group_attrs().
>
> Thanks
>
> >       kfree(p);
> >  }
> >
> > @@ -623,7 +628,6 @@ static void remove_vf_smi_entries(struct mlx4_port *p)
> >  static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
> >  {
> >       struct mlx4_port *p;
> > -     int i;
> >       int ret;
> >       int is_eth = rdma_port_get_link_layer(&dev->ib_dev, port_num) ==
> >                       IB_LINK_LAYER_ETHERNET;
> > @@ -640,7 +644,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
> >                                  kobject_get(dev->dev_ports_parent[slave]),
> >                                  "%d", port_num);
> >       if (ret)
> > -             goto err_alloc;
> > +             goto err_put;
> >
> >       p->pkey_group.name  = "pkey_idx";
> >       p->pkey_group.attrs =
> > @@ -649,43 +653,37 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
> >                                 dev->dev->caps.pkey_table_len[port_num]);
> >       if (!p->pkey_group.attrs) {
> >               ret = -ENOMEM;
> > -             goto err_alloc;
> > +             goto err_del;
> >       }
> >
> >       ret = sysfs_create_group(&p->kobj, &p->pkey_group);
> >       if (ret)
> > -             goto err_free_pkey;
> > +             goto err_del;
> >
> >       p->gid_group.name  = "gid_idx";
> >       p->gid_group.attrs = alloc_group_attrs(show_port_gid_idx, NULL, 1);
> >       if (!p->gid_group.attrs) {
> >               ret = -ENOMEM;
> > -             goto err_free_pkey;
> > +             goto err_del;
> >       }
> >
> >       ret = sysfs_create_group(&p->kobj, &p->gid_group);
> >       if (ret)
> > -             goto err_free_gid;
> > +             goto err_del;
> >
> >       ret = add_vf_smi_entries(p);
> >       if (ret)
> > -             goto err_free_gid;
> > +             goto err_del;
> >
> >       list_add_tail(&p->kobj.entry, &dev->pkeys.pkey_port_list[slave]);
> >       return 0;
> >
> > -err_free_gid:
> > -     kfree(p->gid_group.attrs[0]);
> > -     kfree(p->gid_group.attrs);
> > -
> > -err_free_pkey:
> > -     for (i = 0; i < dev->dev->caps.pkey_table_len[port_num]; ++i)
> > -             kfree(p->pkey_group.attrs[i]);
> > -     kfree(p->pkey_group.attrs);
> > +err_del:
> > +     kobject_del(&p->kobj);
> >
> > -err_alloc:
> > +err_put:
> >       kobject_put(dev->dev_ports_parent[slave]);
> > -     kfree(p);
> > +     kobject_put(&p->kobj);
> >       return ret;
> >  }
> >
> > --
> > 2.43.0
> >

I have sent the v6 version according to your suggestion.

Best regards,
Guangshuo

