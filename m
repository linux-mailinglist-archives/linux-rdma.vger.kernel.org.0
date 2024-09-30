Return-Path: <linux-rdma+bounces-5158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E84398A89B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 17:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD021F24C25
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2024 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100211925B8;
	Mon, 30 Sep 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XE6rjtyd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2681925B7
	for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710283; cv=none; b=ZYhoOK5N8szG1+xlG0n5Nw+3czyVywf03H/gZK7ZDJeRrPnLc7xYwYqezi8QPcGG3C+jaM+Dh7wIeCBvwso+7LVO4aErq7f6yL97b15QGXnfKYsos83MlG5mvlOAuIcSR8EuZ2KqbpgsVaYddyjjwCbDIas3Z/rH/K2x+sf7KUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710283; c=relaxed/simple;
	bh=tJmHsUaVzv5m6d9E3FcttzhOb8b5asi0lJnsZpR73jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpabhFgu+tOWQijrQ3Yd8Fac/qfKcCfIGiTxzXpCuRja+0h4C4xq767NnoWuhrCUaRBUMwfpo7FLrkxR4ED2vektaTi+RBF6YbYRTB5gOQRyKcAoCKGbbpcP0ulQxVbQIaJrW6SgtHEIsNmexZ0BtjuOLbdlVMlZ1guqyY1NFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XE6rjtyd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso1084820a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2024 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1727710278; x=1728315078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BXX468qL0r2NQKwVpnTOoFA8mwwQGqQCuV9lJ2ZWO0=;
        b=XE6rjtydICo9PLL3jTdMw59mUTBLAYqq6J217fOzr7azqm+I0NhAV7AEK+YRgf6QXM
         5VqFR46sC9Djovy2/65Jfyehmi2ndUhdMHpT4XjIOqosyr+4qFLQZ9Z/0M0ARcmn6sVA
         4SF7h/jAzAzYjrihgTUqmxpqrkW1r9VgWwf4uBWE38Xe9gSHk9PHjwaRLXOuVPz+enAa
         SjeyngidKQD1uKQLpjUGI7w8K+S+5aiwvL5Efs4ajC5dt/2LWGxIDwUcyHotaRjfF+wC
         p5Kk2rYUJao5x0JzSk8y373s4GFdeDe5+zQnVvfBV2Fegnn4KULo5wbudr8pHze35qYy
         T2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727710278; x=1728315078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BXX468qL0r2NQKwVpnTOoFA8mwwQGqQCuV9lJ2ZWO0=;
        b=GeFISUnUFJ5pWBZUCQR4GVeasXgZm3T5caB5ttAm9xcNqwJdHbtOE/HZ0iNxAtXG76
         S1B4KTOKR4tFZph4vFhJPbPRwnpGxpcvwNZo7W26rCE+y6qh/+I8SSAgilI1lEoDk8XG
         JDYbvXkoeck+iJ2KXiD6/N+yIXNzg+4OLweSoLWaUewK11+RKYMFsBHY4IyIeB4ovKOp
         hEMGib+24B53Le5OAvRlps1wczjb8nQqZMtonsTqnfEXlx34fybnx2JL5few2w6n6Ake
         zc8/fe880x6Rk4ceKpj2wpTDY8vBjsXLijs1VM73S2sQdZqNiEyv2TBkgtt5knjrI7FM
         rdCw==
X-Forwarded-Encrypted: i=1; AJvYcCWRAhoPQEIb03qSlYe3GUei7+fQeE7SK77w+VNy+2Y99ayFOP+sBSyM4JNaZozWgd+flVZeVVuvWBSh@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1fr8McpiEotqeOhCVe6ui2uuzMdJKyJlJE6Z1zZ003v8OvwM
	S2JIsSdGZeYdY9uUuWfPcc70S9lriDlDIZi/Fjbgp/Iq0++0FENCtNWNb6bRGfEEgPvo+mbnMZ7
	uGM0zHbCGHztIMWNmJh3Ud/JWUjApvXmOPTVXFw==
X-Google-Smtp-Source: AGHT+IHluEb4B7Koo7MifzrpmBQfMoz7nnODdaANxlpzG/ANSBzF2DKPiSP0Dt8XFQq+rifbj4YkwrlR9chPCXX5rOU=
X-Received: by 2002:a17:907:6d1b:b0:a8d:64af:dc4c with SMTP id
 a640c23a62f3a-a93c4909952mr1461012166b.25.1727710278245; Mon, 30 Sep 2024
 08:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com> <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n> <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <20240929141323-mutt-send-email-mst@kernel.org>
 <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com> <20240929182538-mutt-send-email-mst@kernel.org>
 <ce4dc43a-69d7-4623-abc4-b40b681595b2@akamai.com>
In-Reply-To: <ce4dc43a-69d7-4623-abc4-b40b681595b2@akamai.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 30 Sep 2024 17:31:07 +0200
Message-ID: <CAHEcVy4737zxRhOeXg=W-49e0ffhik6+gr1KxSLepWA_dVf4xw@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Michael Galaxy <mgalaxy@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sean Hefty <shefty@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>, 
	"berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, 
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Xiexiangyou <xiexiangyou@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>, 
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>, Wangjialin <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michael,

That's true. To my understanding, to ease the maintenance, Gonglei's
team has taken efforts to refactorize the RDMA migration code by using
rsocket. However, due to a certain limitation in rsocket, it turned
out that only small VM (in terms of core number and memory) can be
migrated successfully. As long as this limitation persists, no
progress can be achieved in this direction. One the other hand, a
proper test environment and integration / regression test cases are
expected to catch any possible regression due to new changes. It seems
that currently, we can go in this direction.

Best regards,
Yu Zhang @ IONOS cloud

On Mon, Sep 30, 2024 at 5:00=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.com>=
 wrote:
>
>
> On 9/29/24 17:26, Michael S. Tsirkin wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On Sun, Sep 29, 2024 at 03:26:58PM -0500, Michael Galaxy wrote:
> >> On 9/29/24 13:14, Michael S. Tsirkin wrote:
> >>> !-------------------------------------------------------------------|
> >>>     This Message Is From an External Sender
> >>>     This message came from outside your organization.
> >>> |-------------------------------------------------------------------!
> >>>
> >>> On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
> >>>> A bounce buffer defeats the entire purpose of using RDMA in these ca=
ses.
> >>>> When using RDMA for very large transfers like this, the goal here is=
 to map
> >>>> the entire memory region at once and avoid all CPU interactions (exc=
ept for
> >>>> message management within libibverbs) so that the NIC is doing all o=
f the
> >>>> work.
> >>>>
> >>>> I'm sure rsocket has its place with much smaller transfer sizes, but=
 this is
> >>>> very different.
> >>> To clarify, are you actively using rdma based migration in production=
? Stepping up
> >>> to help maintain it?
> >>>
> >> Yes, both Huawei and IONOS have both been contributing here in this em=
ail
> >> thread.
> >>
> >> They are both using it in production.
> >>
> >> - Michael
> > Well, any plans to work on it? for example, postcopy does not really
> > do zero copy last time I checked, there's also a long TODO list.
> >
> I apologize, I'm not following the question here. Isn't that what this
> thread is about?
>
> So, some background is missing here, perhaps: A few months ago, there
> was a proposal
> to remove native RDMA support from live migration due to concerns about
> lack of testability.
> Both IONOS and Huawei have stepped up that they are using it and are
> engaging with the
> community here. I also proposed transferring over maintainership to them
> as well.  (I  no longer
> have any of this hardware, so I cannot provide testing support anymore).
>
> During that time, rsocket was proposed as an alternative, but as I have
> laid out above, I believe
> it cannot work for technical reasons.
>
> I also asked earlier in the thread if we can cover the community's
> testing concerns using softroce,
> so that an integration test can be made to work (presumably through
> avocado or something similar).
>
> Does that history make sense?
>
> - Michael
>

