Return-Path: <linux-rdma+bounces-2653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E1F8D2BC4
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 06:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57424B20BB3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 04:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361313D899;
	Wed, 29 May 2024 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TDHTGGqX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF35A55
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957228; cv=none; b=eQCSKQ4hoMR1TioSYfSw8tv/Tfgtb4l34uxK/SBwoO+3oz4GK6km1hSKtqjwlCoiGG2e1pja00UN45SMLEXpP6wAMQB8KM7CZkD0NbMdIcIMGadiOk6xjL1j4PaEN2l883YwoYF74z71i/2sj4wiIVOB1hKWLXj096ruP4ENP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957228; c=relaxed/simple;
	bh=H6oymDE/dlDacQ7OJSlKZJ0i5/zar6Pp9Hg61fQiDaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHvRVSp3zxD/sz+X1+ujFoOWw30AFzI31LKiz+He5dPbZ2NNbBodS39sLiwZrwlsRiudZSXcseoBs0u8RjLUyF094ba+hFdm6zwWUuzxZzYc7OG1Qu1ic7YV6Q9V1Elw5I66tTVQFUZjYrsGgEW6KKdT1z/pfl+gUXOqlrcA9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TDHTGGqX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-578676a1b57so715448a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2024 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1716957223; x=1717562023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgbrgm9oN3J4LdRd0FzNOIpeae3tCUcQtmI86SumNi8=;
        b=TDHTGGqXzuzGTJUV61uBZD/MF2bTFo0sUT2gX9LK+zhy4kZsfXV7zXd6ysb5Eomg3y
         3t8C1npfjwCQQFtu9z8PhdeW7+iCfmLUgXKF2y0orHhsA9Mm4hLuzopqUtsjCkSICCAu
         f3Fm1wsYxRi5WCleXKpJeVJxnXHIRVpwmWbUltlWXNigBgf8chya7MF3Co2kob3lPOrR
         3zwdF0JeNsFcX08w9K7GhODHICOYhVDLeZ0A7jbY1fK720y0W30JgK9exZ16a0H2Gy/q
         y8AQU49hSwg90qdW/lUnDlYFPn0lGp8nCR/Uq1TWOPcXQFJRzB5I0NzFOrNYfdD3zXwX
         jgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716957223; x=1717562023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vgbrgm9oN3J4LdRd0FzNOIpeae3tCUcQtmI86SumNi8=;
        b=duda4Fk+urm32sdruYFSBgFzYY3yJBY9JwyG1/cjLgtvyO+fa9K5K+2aoH1o2NLktc
         BJEF958RwolueOUiT5ZzHpOB16S3vcfUt333/Tif6RmNfAh5CXJ3g1sipiw9Bnf3I/Hn
         3V/Hhyb4q0Ff7hzpI1/Ru0eNbFMSRJWemKCcBFiTSGDkCEziUVQlODB7oY0byiPCrTro
         qGBECMuVYwsTHW9pUWN2yM4pZeQt3eTRKXFMg0SzP9khYcdHr0Oz5Dhxc58x9vAZPww4
         YXhx6ftdMXjC192+P4ph0Fb+85mnnS9YUN8N3NZfzvCbGJCkeF/5ALFOS6P2YKbRF9FW
         hO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjGZv1z6EYfTdI/bwDKK5dqMku7/oa5ILu+n3SewqtL56LRUMkVychn6l50eoY5KWlyhjM+4d3nfAe89S+XjDDg+EFHA6PcGmTXg==
X-Gm-Message-State: AOJu0YyPPH/7RBqVM3kxHKfKu6D64ZN5lQ/3C5R35k4BNkmzutPWqHj4
	EIJER7tBjSVjHoBHIRzPStFcZOHejm5m0eFKz3ZBGnhJNgbqh8qGk/pK78i+utzetNKhFA1Kvdm
	sTXKZ7vrCjYnBMMi0QszSRAJtksusbanDYoGgiw==
X-Google-Smtp-Source: AGHT+IGAryn3arceUC635cfwoAvOXPpWFnbmIdw+E8kjjK6Wq/qFCx+Tv9/wBRf6Jag06COBE4amUVuEf9vRktTeJ98=
X-Received: by 2002:a50:d49e:0:b0:578:5dc5:a4fb with SMTP id
 4fb4d7f45d1cf-5785dc5a6f2mr9117151a12.32.1716957223300; Tue, 28 May 2024
 21:33:43 -0700 (PDT)
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
 <ZlX-Swq4Hi-0iHeh@x1n> <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
In-Reply-To: <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 29 May 2024 06:33:32 +0200
Message-ID: <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, 
	Michael Galaxy <mgalaxy@akamai.com>, Elmar Gerdes <elmar.gerdes@ionos.com>, 
	zhengchuan <zhengchuan@huawei.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
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

On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huawei=
.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > Exactly, not so compelling, as I did it first only on servers
> > > > > widely used for production in our data center. The network
> > > > > adapters are
> > > > >
> > > > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > >
> > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks more
> > reasonable.
> > > >
> > > >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15
> > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > >
> > > > Appreciate a lot for everyone helping on the testings.
> > > >
> > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > [ConnectX-5]
> > > > >
> > > > > which doesn't meet our purpose. I can choose RDMA or TCP for VM
> > > > > migration. RDMA traffic is through InfiniBand and TCP through
> > > > > Ethernet on these two hosts. One is standby while the other is ac=
tive.
> > > > >
> > > > > Now I'll try on a server with more recent Ethernet and InfiniBand
> > > > > network adapters. One of them has:
> > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01)
> > > > >
> > > > > The comparison between RDMA and TCP on the same NIC could make
> > > > > more
> > > > sense.
> > > >
> > > > It looks to me NICs are powerful now, but again as I mentioned I
> > > > don't think it's a reason we need to deprecate rdma, especially if
> > > > QEMU's rdma migration has the chance to be refactored using rsocket=
.
> > > >
> > > > Is there anyone who started looking into that direction?  Would it
> > > > make sense we start some PoC now?
> > > >
> > >
> > > My team has finished the PoC refactoring which works well.
> > >
> > > Progress:
> > > 1.  Implement io/channel-rdma.c,
> > > 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying it
> > > is successful, 3.  Remove the original code from migration/rdma.c, 4.
> > > Rewrite the rdma_start_outgoing_migration and
> > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx function=
s
> > > from migration/ram.c. (to prevent RDMA live migration from polluting =
the
> > core logic of live migration), 6.  The soft-RoCE implemented by softwar=
e is
> > used to test the RDMA live migration. It's successful.
> > >
> > > We will be submit the patchset later.
> >
> > That's great news, thank you!
> >
> > --
> > Peter Xu
>
> For rdma programming, the current mainstream implementation is to use rdm=
a_cm to establish a connection, and then use verbs to transmit data.
>
> rdma_cm and ibverbs create two FDs respectively. The two FDs have differe=
nt responsibilities. rdma_cm fd is used to notify connection establishment =
events,
> and verbs fd is used to notify new CQEs. When poll/epoll monitoring is di=
rectly performed on the rdma_cm fd, only a pollin event can be monitored, w=
hich means
> that an rdma_cm event occurs. When the verbs fd is directly polled/epolle=
d, only the pollin event can be listened, which indicates that a new CQE is=
 generated.
>
> Rsocket is a sub-module attached to the rdma_cm library and provides rdma=
 calls that are completely similar to socket interfaces. However, this libr=
ary returns
> only the rdma_cm fd for listening to link setup-related events and does n=
ot expose the verbs fd (readable and writable events for listening to data)=
. Only the rpoll
> interface provided by the RSocket can be used to listen to related events=
. However, QEMU uses the ppoll interface to listen to the rdma_cm fd (gotte=
n by raccept API).
> And cannot listen to the verbs fd event. Only some hacking methods can be=
 used to address this problem.
>
> Do you guys have any ideas? Thanks.
+cc linux-rdma
+cc Sean



>
>
> Regards,
> -Gonglei

