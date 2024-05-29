Return-Path: <linux-rdma+bounces-2655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39468D2CE5
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 08:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F127B1C221A0
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 06:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F1115CD6F;
	Wed, 29 May 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+RDeyFd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E91D531
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962765; cv=none; b=rBNbruSMVfuv8j1SG4XaKEJ5G1jLGBtPOfxH37C65epV9x9hKM6D1cSdrDVTcl/32laNKPwl9FuZN0yByKiez9eCNtd+HPAOhOoos5uY4YQAqx43hi8OhgQ69JpV0Xh+mQe3dv/WQdS5/7YPdXj620BqXIWwU2kAcWAXPnmWk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962765; c=relaxed/simple;
	bh=HaQKucuedBwxhiSV+jDbfji4kkPm99VK+KHAntqPTtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/Ypgpx7t7A7+F4PDqadUXVcaeufZY4O/0tr4ATuUMlL0ZF31u7qPAp3yRd/GX7mg/wgB0e++nqTb02QSBUxzFkvn2jFkgkjlpQxjqhPB+8pKyLyfCOkDnpo2LVET/81A8ykdYreoylwk573kKIvUZSQ+xTdUWukrww3ugX1gFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+RDeyFd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8e98784b3so1212271b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 23:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716962763; x=1717567563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEgMQmsoY6w77UNCa3Z5qcf9/UXUdDI7rLaVDP7lhWk=;
        b=J+RDeyFdG1pfNsHmDHta22Dt80UfVEvYOmBjaXbhGtRxP28rYsFp4tDAR83U6DXEG5
         6NUnh3ntEZ19Q3/L0ucxLlx+fXQ6I+DP9edQ5p+IhLhY4UpOG5rEX5e0/v4wQTEhyD1u
         1cTG7xUlTgBvlJrhdelU74XYLxpYxlRxBJ58NMhix/N96YKM/Ho6Aa3vv8XtTtYcYgwb
         Sw9oj641MG3iJPhdsspUY7YKh01zZpxZGBf8dJfE6QL2kd7Qnn1IfBmRprI/DGO/pz8Q
         CeE+cbQsJ1siz8xDoRfNg+5C4eM0f3jUL/SmfOEsGWte5XNRiGSI8q+f5Wx1Wp4H1LLt
         3yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716962763; x=1717567563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEgMQmsoY6w77UNCa3Z5qcf9/UXUdDI7rLaVDP7lhWk=;
        b=dm4fTgv6OsU25Kjsor19bByRpyfg0Gzx2aCrmEiI3XJi2nNeZJcaIU52+6fLlTfQbC
         NRoWx0H4xSgYS1YqkbX5vk+6h/kpZEZ5pZRcBYAAZOVVybbq5vUL2q0dYdsas/LOnBAt
         WVWlMVfYBcp6a3LTYoggJi0puuuRih7X85qx0Jl12RfM/Tl8fOYrr7sUkaqakqjQxDtB
         RswGGAQTlZ2XGuLs7GHxq5voETWZUOaN1thRQ/TxfP8kC2DoBAgXxAJTa2bjOAHtLfvl
         AOaP7sy6ulZcoATUleT30Htrf4y7aBLM4M8xLH6BSPKijwnJRZIovS1Dqijplaxzdvei
         r6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY611GDFerOAxFn4/U/Kmwzf0RyM8kOSKg6ATiiAIqRGszdCc/V/VK0nJ9cd4Sn5Hy/vA/QOm1xWAXVrJ+TqxNfzihyRB8htJh0A==
X-Gm-Message-State: AOJu0YxRNSBTfEIfqHILvsh0tv3kQxcUigdcJySfXZpwfrHMGHamsJS7
	vZ5FdmyEEn5ptMg6XNqzMiuKnRbfZS/1hmHUM/+xABIoomRL0hfl7wyRD7Rv4EeYf8Tcv+d9RF7
	SQE51TduVkJyk2C50Bmvf+K0vNyg=
X-Google-Smtp-Source: AGHT+IE7LTWSBj8XmYSLzZMgQYYFw3ve7P+UkkueGO919dc1QddwFfptKMgBO6ImETtbEC9BOJvX62jjxJZL7pRYxmg=
X-Received: by 2002:a05:6300:808c:b0:1af:fbab:cf92 with SMTP id
 adf61e73a8af0-1b212f74721mr14358553637.54.1716962763038; Tue, 28 May 2024
 23:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zjj0xa-3KrFHTK0S@x1n> <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n> <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n> <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com> <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n> <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com> <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
In-Reply-To: <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Wed, 29 May 2024 14:05:51 +0800
Message-ID: <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>, 
	Yu Zhang <yu.zhang@ionos.com>, Michael Galaxy <mgalaxy@akamai.com>, 
	Elmar Gerdes <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Markus Armbruster <armbru@redhat.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, 
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia.ml@gmail.com>, 
	Kevin Wolf <kwolf@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
	Prasanna Kumar Kalever <prasanna4324@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>, "devel@lists.libvirt.org" <devel@lists.libvirt.org>, 
	Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Wainer dos Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
	Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>, 
	Fabiano Rosas <farosas@suse.de>, RDMA mailing list <linux-rdma@vger.kernel.org>, shefty@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> =
wrote:
>
> On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huaw=
ei.com> wrote:
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Peter Xu [mailto:peterx@redhat.com]
> > > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > > Exactly, not so compelling, as I did it first only on servers
> > > > > > widely used for production in our data center. The network
> > > > > > adapters are
> > > > > >
> > > > > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > > >
> > > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks more
> > > reasonable.
> > > > >
> > > > >
> > > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15
> > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > >
> > > > > Appreciate a lot for everyone helping on the testings.
> > > > >
> > > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > > [ConnectX-5]
> > > > > >
> > > > > > which doesn't meet our purpose. I can choose RDMA or TCP for VM
> > > > > > migration. RDMA traffic is through InfiniBand and TCP through
> > > > > > Ethernet on these two hosts. One is standby while the other is =
active.
> > > > > >
> > > > > > Now I'll try on a server with more recent Ethernet and InfiniBa=
nd
> > > > > > network adapters. One of them has:
> > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01=
)
> > > > > >
> > > > > > The comparison between RDMA and TCP on the same NIC could make
> > > > > > more
> > > > > sense.
> > > > >
> > > > > It looks to me NICs are powerful now, but again as I mentioned I
> > > > > don't think it's a reason we need to deprecate rdma, especially i=
f
> > > > > QEMU's rdma migration has the chance to be refactored using rsock=
et.
> > > > >
> > > > > Is there anyone who started looking into that direction?  Would i=
t
> > > > > make sense we start some PoC now?
> > > > >
> > > >
> > > > My team has finished the PoC refactoring which works well.
> > > >
> > > > Progress:
> > > > 1.  Implement io/channel-rdma.c,
> > > > 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying i=
t
> > > > is successful, 3.  Remove the original code from migration/rdma.c, =
4.
> > > > Rewrite the rdma_start_outgoing_migration and
> > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx functi=
ons
> > > > from migration/ram.c. (to prevent RDMA live migration from pollutin=
g the
> > > core logic of live migration), 6.  The soft-RoCE implemented by softw=
are is
> > > used to test the RDMA live migration. It's successful.
> > > >
> > > > We will be submit the patchset later.
> > >
> > > That's great news, thank you!
> > >
> > > --
> > > Peter Xu
> >
> > For rdma programming, the current mainstream implementation is to use r=
dma_cm to establish a connection, and then use verbs to transmit data.
> >
> > rdma_cm and ibverbs create two FDs respectively. The two FDs have diffe=
rent responsibilities. rdma_cm fd is used to notify connection establishmen=
t events,
> > and verbs fd is used to notify new CQEs. When poll/epoll monitoring is =
directly performed on the rdma_cm fd, only a pollin event can be monitored,=
 which means
> > that an rdma_cm event occurs. When the verbs fd is directly polled/epol=
led, only the pollin event can be listened, which indicates that a new CQE =
is generated.
> >
> > Rsocket is a sub-module attached to the rdma_cm library and provides rd=
ma calls that are completely similar to socket interfaces. However, this li=
brary returns
> > only the rdma_cm fd for listening to link setup-related events and does=
 not expose the verbs fd (readable and writable events for listening to dat=
a). Only the rpoll
> > interface provided by the RSocket can be used to listen to related even=
ts. However, QEMU uses the ppoll interface to listen to the rdma_cm fd (got=
ten by raccept API).
> > And cannot listen to the verbs fd event. Only some hacking methods can =
be used to address this problem.
> >
> > Do you guys have any ideas? Thanks.
> +cc linux-rdma

Why include rdma community?

> +cc Sean
>
>
>
> >
> >
> > Regards,
> > -Gonglei
>

