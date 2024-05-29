Return-Path: <linux-rdma+bounces-2660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D3A8D2DC2
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 09:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6681C22256
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961DE15FD1A;
	Wed, 29 May 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JS3SSIZT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702A15B14B
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966311; cv=none; b=dmsuUJmBzL6o1HgYgHGDdeqG8wxRk+iguZliac2i8sJTann0LDFo8kjVhP3Uq9Z6wDTLVfhQfm3vv3fj7UI32BCg0fy71AxNNtf3QpBufGVR1VZq4gP6ombZhdPCwiON0azZFRy2Q4Aaqyet/e3NkbdO55WngiNKP7X71anfEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966311; c=relaxed/simple;
	bh=jWOJnpDL7J7j1LQMR87OGxI+YpLabjQNwjtHSyHgtXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enHATJcmwQUI+18J4mTah1FMQ67YCHpr/HTfws5MPLEQhoCV4+9D7Uguq2fsOdh7BxMKJU6Q7GLlPQtXkbw4gk2DLnP+btrMCNfvFkozy4utARWkmq/9167rpzcoBYSFqDhCp3rCY4Q+g471vvbfofZELztUpfsDBRiDg2B6Y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JS3SSIZT; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-578626375ffso1883703a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1716966307; x=1717571107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22gZMj9Ngyl5QFYYx0ERdhbxSEHP/ywydalXgqeU78E=;
        b=JS3SSIZThCZf+6ZRzQWByPbOff9PhYuyeKyZHEz/n8H7HZgQvp5rjxbdN0RoJkeR5v
         KkdQFl+aJIVIre9SBlewl3/8xh0AGRfQTOqO1dZ4CapXh5jhLkzaJK6Kyu+Qe+4IUAs0
         7Z6GkEJRu+pEsjrATBnQM7+3A5QDx77GCTwc30N+7DaZbiQKyTlSduMbnXdvA+N9zzdY
         XvPoVk28EOkPggwKhCJ9iXZ4oSfYf4Skfd5B/jisUXEG/AaJFXFN3zW2Tuqdi6Ivobdl
         253JxlCRM1ouqV8oxF0MEhBiL5bbeC8x7XxsrqR2fnWu3yK3BUIWDBR7vMCmjl0UjqEM
         APuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966307; x=1717571107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22gZMj9Ngyl5QFYYx0ERdhbxSEHP/ywydalXgqeU78E=;
        b=HnroWahZ5seC8/rlB657oS336LijHGOqim7z9NZ2jw/JdDgcbtSByFdtXVsaqCZq5/
         dL6PylGxCEGHo069Qax9I4wYUVBwNfLXSyPSAPdKj4mQk+x4mshlyjyyDraSh7jOKIGK
         1mOTWLf4gR5PFoS/K0EA86RF76GMdArE9o42VFLaiTpX5woyC/lJo2IWNajmzoFn+vWj
         RAiuMnPAuyqTkGs8OvALqPXWPEBN+FwG77myHbFFC/r1eELZukfAPiQ7PwbOBFAlefr8
         t5f8Rm8FbUl8IFWx3HoB94rYgb8FHNMjf4zVgcF4H2gcDGAbRbDuhteB3glzgIhqW5EK
         nT+g==
X-Forwarded-Encrypted: i=1; AJvYcCXoBjq5h+YmrK3hHHuojapWCMTZ9pVbXglMl5+ZUqpilZqQZX78oJlee25D2MMP+iKTy9FyoYPyX1mjDw4NNoRGSghM3Z7l7nqgLQ==
X-Gm-Message-State: AOJu0YzETPvctfHmy6C8pRRacmr14ahlVG0OT6czir+3TVcJYUVDMYIO
	OpSLyCwzZjhDcFQFGxUUOfSK5PHX5r8AhlvGbwMZV5YeVo9TF6sXBSHcqZCJzkEd8vsjjjzV3pE
	ETi3XjZxHy3u+DGf86Qs2t1HR7Uunp2nnwYtRFg==
X-Google-Smtp-Source: AGHT+IH17d5G6ahvy7oU/fSrXyANl8v8lU70vG84e0bYEsVBUuxtJhA0Z+r05KIWT/GljKSJrG5pqgBNLjpiSt2Pibk=
X-Received: by 2002:a50:a402:0:b0:572:cfa4:3ccb with SMTP id
 4fb4d7f45d1cf-578519160c0mr8899917a12.8.1716966306728; Wed, 29 May 2024
 00:05:06 -0700 (PDT)
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
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com> <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
In-Reply-To: <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 29 May 2024 09:04:54 +0200
Message-ID: <CAMGffEnoZ980i_=KaxoBqkbsSNTfjBV6fTPM0XjDT5cLN2XAAA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Greg Sword <gregsword0@gmail.com>
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

On Wed, May 29, 2024 at 8:08=E2=80=AFAM Greg Sword <gregsword0@gmail.com> w=
rote:
>
> On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com=
> wrote:
> >
> > On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@hu=
awei.com> wrote:
> > >
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > > > Exactly, not so compelling, as I did it first only on servers
> > > > > > > widely used for production in our data center. The network
> > > > > > > adapters are
> > > > > > >
> > > > > > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > > > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > > > >
> > > > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks mo=
re
> > > > reasonable.
> > > > > >
> > > > > >
> > > > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda1=
5
> > > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > > >
> > > > > > Appreciate a lot for everyone helping on the testings.
> > > > > >
> > > > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > > > [ConnectX-5]
> > > > > > >
> > > > > > > which doesn't meet our purpose. I can choose RDMA or TCP for =
VM
> > > > > > > migration. RDMA traffic is through InfiniBand and TCP through
> > > > > > > Ethernet on these two hosts. One is standby while the other i=
s active.
> > > > > > >
> > > > > > > Now I'll try on a server with more recent Ethernet and Infini=
Band
> > > > > > > network adapters. One of them has:
> > > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev =
01)
> > > > > > >
> > > > > > > The comparison between RDMA and TCP on the same NIC could mak=
e
> > > > > > > more
> > > > > > sense.
> > > > > >
> > > > > > It looks to me NICs are powerful now, but again as I mentioned =
I
> > > > > > don't think it's a reason we need to deprecate rdma, especially=
 if
> > > > > > QEMU's rdma migration has the chance to be refactored using rso=
cket.
> > > > > >
> > > > > > Is there anyone who started looking into that direction?  Would=
 it
> > > > > > make sense we start some PoC now?
> > > > > >
> > > > >
> > > > > My team has finished the PoC refactoring which works well.
> > > > >
> > > > > Progress:
> > > > > 1.  Implement io/channel-rdma.c,
> > > > > 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying=
 it
> > > > > is successful, 3.  Remove the original code from migration/rdma.c=
, 4.
> > > > > Rewrite the rdma_start_outgoing_migration and
> > > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx func=
tions
> > > > > from migration/ram.c. (to prevent RDMA live migration from pollut=
ing the
> > > > core logic of live migration), 6.  The soft-RoCE implemented by sof=
tware is
> > > > used to test the RDMA live migration. It's successful.
> > > > >
> > > > > We will be submit the patchset later.
> > > >
> > > > That's great news, thank you!
> > > >
> > > > --
> > > > Peter Xu
> > >
> > > For rdma programming, the current mainstream implementation is to use=
 rdma_cm to establish a connection, and then use verbs to transmit data.
> > >
> > > rdma_cm and ibverbs create two FDs respectively. The two FDs have dif=
ferent responsibilities. rdma_cm fd is used to notify connection establishm=
ent events,
> > > and verbs fd is used to notify new CQEs. When poll/epoll monitoring i=
s directly performed on the rdma_cm fd, only a pollin event can be monitore=
d, which means
> > > that an rdma_cm event occurs. When the verbs fd is directly polled/ep=
olled, only the pollin event can be listened, which indicates that a new CQ=
E is generated.
> > >
> > > Rsocket is a sub-module attached to the rdma_cm library and provides =
rdma calls that are completely similar to socket interfaces. However, this =
library returns
> > > only the rdma_cm fd for listening to link setup-related events and do=
es not expose the verbs fd (readable and writable events for listening to d=
ata). Only the rpoll
> > > interface provided by the RSocket can be used to listen to related ev=
ents. However, QEMU uses the ppoll interface to listen to the rdma_cm fd (g=
otten by raccept API).
> > > And cannot listen to the verbs fd event. Only some hacking methods ca=
n be used to address this problem.
> > >
> > > Do you guys have any ideas? Thanks.
> > +cc linux-rdma
>
> Why include rdma community?
rdma community has a lot people with experience in rdma/rsocket?
>
> > +cc Sean
> >
> >
> >
> > >
> > >
> > > Regards,
> > > -Gonglei
> >

