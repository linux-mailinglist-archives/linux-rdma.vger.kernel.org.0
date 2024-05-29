Return-Path: <linux-rdma+bounces-2666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E348D3538
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 13:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455BA1C21089
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E6168C03;
	Wed, 29 May 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XJjvzyAN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D653802
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981196; cv=none; b=GLqaTuSiRerj+JkRqNuH+ZrzGxSpEQTGqJci0KohIhuvdJGbMG1kVXlh4SrU5lR8Ua1mpmNQ73lSPn+smC9CObIRW3aIO/DzEAdpiIB9S6URBht9JBWUuxorlcaIKSYhSRZq46a2FYjLPTFyjLsv0/ap7Pq9pThMawvdVFpVnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981196; c=relaxed/simple;
	bh=JfeaA2668cVypaEm+rIDYtnSMSfltDBlzCjoIM/7ywQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doffoFNziwtNP3MnQjqz+hn5ALMRtue2PTEO4jMJEByvKDTmNHawFK4UZsNizdnWXAFxjKb2WVDjlUWE3SiZWgNHt83YLDwRCCOvEKYsUaReWoqDVBmQN601goxSepoSXQRxNUAYvjegLf0HdETOuC55TsB8WaSbEQJo4t0Fhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XJjvzyAN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso606901fa.2
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1716981191; x=1717585991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp7FwyoZGXVo71/jnJJ+Mwe0LKTj87+Ve6G71cZE8Io=;
        b=XJjvzyANRcvnZ9wk0SRRZqcz4PpMAGkIRCOKdjFyWvcsRZat8QnRh2EcxB7v41rtoU
         SQZgl+w43A2MEILytHjUyz9kpSzNjZcv2HBEnDLo8mN/TbqixAX9pH5hsUvplGeQMjs0
         aiks0KkE/hAUwF+7qYB8zzOLoFeo8RTmqFnMsespzI7lbH7/SkvzYXk+416tKkwGBFNf
         0GB1hqmZV5ogUfE1V+7+J9/ZAYq/GwKKwOXFnwkI5NQ7c4VDBKULqrZzByf5mHsSmI9f
         nH+VVA028BXhOS0LQEGPJbPQLXFq2kSX+G9f4ITCgzAf45FUIw1w3LaIVnJvHLKt0Vr0
         PFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981191; x=1717585991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp7FwyoZGXVo71/jnJJ+Mwe0LKTj87+Ve6G71cZE8Io=;
        b=S5HSNthWdfex3CSGCn0XZS4V+N1pB/Y0BAa2Jmge3kzhLHevVuT/4OJQqSqd5e6rIr
         JxQIJTzO2tNo5d/Nf/xF+rjvd8rs8f7/PmVPa6OuF1TDncqLnV8FsMER9nv+Bc2beiyJ
         mrGvBUEaoX0tDDBuWr9zPhKzuMC0bqAeC1zreSaBytLe5O+ESozX59B/s+CSL0lHDQrK
         RJgRPRyxwt3NBGtnuN0obIob6QU/g+egfz8oae+N79bRHX6tpinqeUlSnUVw0UNYA24k
         TkGn/1kkxlZ8olodDaHfoCqN6TFfzPzijms6ZsQqgIY0YYe9v2XJ6PutINQLDUT74v7U
         v7/A==
X-Forwarded-Encrypted: i=1; AJvYcCWslt9MTUoYZe9/w30RYsdctGyOlCQEzR2ZOg4kc5kwuB6tbD5ZD0cst58uguOFahBdcnnOzwAKZuHcar46+MjO1UnVtjT+x7RHfg==
X-Gm-Message-State: AOJu0YxkFDBuO8eZGfCUeYhLTUL0aVjiFNM6p/jX4gqFe1HMRm9r4kYS
	7Obd5ScDcCac3MgipeRW4E8InxcpPXXOoleAputROZ/mqu8T9Zgt1sHijBDEX97ud5+3kJu8hc8
	mUdq09eBTgsg2wWYNby6GrsmhSlIY4ST4y0utfw==
X-Google-Smtp-Source: AGHT+IH/oUD5Inaeu+o0fI3Za9H1NuIhyJhnk0QSFNQBIW/9hiAhC57rr9W16ylrr2pwHyvL84/OFfeaeDFPgN2U07Y=
X-Received: by 2002:a05:651c:2222:b0:2de:ca7f:c849 with SMTP id
 38308e7fff4ca-2e95b279514mr139412721fa.43.1716981191318; Wed, 29 May 2024
 04:13:11 -0700 (PDT)
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
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
 <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
 <e0fa7fc42118407f8731c34f8c192fda@huawei.com> <CAMGffEna=8vNm89SkzRknLb7irTit0dBeciuC+_KMp+4U0PtQw@mail.gmail.com>
 <2665934438364f5e9e80ac4564cac2c3@huawei.com>
In-Reply-To: <2665934438364f5e9e80ac4564cac2c3@huawei.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 29 May 2024 13:13:00 +0200
Message-ID: <CAJpMwyj_qrj1r1e6SCLzUf_jFn+do+71h08=LmPM-Mv0nFk7nQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>, Greg Sword <gregsword0@gmail.com>, 
	Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, 
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
	Fabiano Rosas <farosas@suse.de>, RDMA mailing list <linux-rdma@vger.kernel.org>, 
	"shefty@nvidia.com" <shefty@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am part of the storage kernel team which develops and maintains the
RDMA block storage in IONOS.
We work closely with Jinpu/Yu, and currently I am supporting Jinpu
with this Qemu RDMA work.

On Wed, May 29, 2024 at 11:49=E2=80=AFAM Gonglei (Arei) via
<qemu-devel@nongnu.org> wrote:
>
> Hi,
>
> > -----Original Message-----
> > > >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda
> > > > > > > 15
> > > > > > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > > > > > >
> > > > > > > > > Appreciate a lot for everyone helping on the testings.
> > > > > > > > >
> > > > > > > > > > InfiniBand controller: Mellanox Technologies MT27800
> > > > > > > > > > Family [ConnectX-5]
> > > > > > > > > >
> > > > > > > > > > which doesn't meet our purpose. I can choose RDMA or TC=
P
> > > > > > > > > > for VM migration. RDMA traffic is through InfiniBand an=
d
> > > > > > > > > > TCP through Ethernet on these two hosts. One is standby
> > > > > > > > > > while the other
> > > > is active.
> > > > > > > > > >
> > > > > > > > > > Now I'll try on a server with more recent Ethernet and
> > > > > > > > > > InfiniBand network adapters. One of them has:
> > > > > > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
> > > > > > > > > > (rev
> > > > > > > > > > 01)
> > > > > > > > > >
> > > > > > > > > > The comparison between RDMA and TCP on the same NIC
> > > > > > > > > > could make more
> > > > > > > > > sense.
> > > > > > > > >
> > > > > > > > > It looks to me NICs are powerful now, but again as I
> > > > > > > > > mentioned I don't think it's a reason we need to deprecat=
e
> > > > > > > > > rdma, especially if QEMU's rdma migration has the chance
> > > > > > > > > to be refactored
> > > > using rsocket.
> > > > > > > > >
> > > > > > > > > Is there anyone who started looking into that direction?
> > > > > > > > > Would it make sense we start some PoC now?
> > > > > > > > >
> > > > > > > >
> > > > > > > > My team has finished the PoC refactoring which works well.
> > > > > > > >
> > > > > > > > Progress:
> > > > > > > > 1.  Implement io/channel-rdma.c, 2.  Add unit test
> > > > > > > > tests/unit/test-io-channel-rdma.c and verifying it is
> > > > > > > > successful, 3.  Remove the original code from migration/rdm=
a.c, 4.
> > > > > > > > Rewrite the rdma_start_outgoing_migration and
> > > > > > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xx=
x
> > > > > > > > functions from migration/ram.c. (to prevent RDMA live
> > > > > > > > migration from polluting the
> > > > > > > core logic of live migration), 6.  The soft-RoCE implemented
> > > > > > > by software is used to test the RDMA live migration. It's suc=
cessful.
> > > > > > > >
> > > > > > > > We will be submit the patchset later.
> > > > > > >
> > > > > > > That's great news, thank you!
> > > > > > >
> > > > > > > --
> > > > > > > Peter Xu
> > > > > >
> > > > > > For rdma programming, the current mainstream implementation is
> > > > > > to use
> > > > rdma_cm to establish a connection, and then use verbs to transmit d=
ata.
> > > > > >
> > > > > > rdma_cm and ibverbs create two FDs respectively. The two FDs
> > > > > > have different responsibilities. rdma_cm fd is used to notify
> > > > > > connection establishment events, and verbs fd is used to notify
> > > > > > new CQEs. When
> > > > poll/epoll monitoring is directly performed on the rdma_cm fd, only
> > > > a pollin event can be monitored, which means that an rdma_cm event
> > > > occurs. When the verbs fd is directly polled/epolled, only the
> > > > pollin event can be listened, which indicates that a new CQE is gen=
erated.
> > > > > >
> > > > > > Rsocket is a sub-module attached to the rdma_cm library and
> > > > > > provides rdma calls that are completely similar to socket inter=
faces.
> > > > > > However, this library returns only the rdma_cm fd for listening
> > > > > > to link
> > > > setup-related events and does not expose the verbs fd (readable and
> > > > writable events for listening to data). Only the rpoll interface
> > > > provided by the RSocket can be used to listen to related events.
> > > > However, QEMU uses the ppoll interface to listen to the rdma_cm fd
> > (gotten by raccept API).
> > > > > > And cannot listen to the verbs fd event.
> > I'm confused, the rs_poll_arm
> > :https://github.com/linux-rdma/rdma-core/blob/master/librdmacm/rsocket.=
c#
> > L3290
> > For STREAM, rpoll setup fd for both cq fd and cm fd.
> >
>
> Right. But the question is QEMU do not use rpoll but gilb's ppoll. :(

I have a query around this topic. Are the fds used in socket migration
polled through ppoll?
If yes, then can someone point out where; I couldn't find that piece of cod=
e.

I could only find that sendmsg/send and recvmsg/recv is being used.

>
>
> Regards,
> -Gonglei
>

