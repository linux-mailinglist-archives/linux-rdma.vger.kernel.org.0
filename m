Return-Path: <linux-rdma+bounces-2662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA68D32BC
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD271F23AF0
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52630161914;
	Wed, 29 May 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="W45An+Zz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31C15CD41
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974267; cv=none; b=PvMyc2TlqpnVFQiDLX+Kno/g8UDgRlQfOXAwr2KBkgKvET7FOcOaC6yQyvYTlZAfSfry4dh//Slinyq6nIX/KF2gmFgIaNddWuB7jn2fkFEh1ybFEU47t/gcXfK92jH9B18GdojZNV2+9CpOuO1r0WL0SYIJ9Vxb1B4HSjc/VlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974267; c=relaxed/simple;
	bh=aoyNI6+kQJ0Sb7JfUulStQKWlTVH27sro76tJ7T2/go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfHt3EJrr+Odd1yHU/GxHWNI3D4UzW+SnRcN1g3urWgzoGdwlqIaxcWio/57XsY8i8+cvKaiNL8FAxXTMHHQ9lLdPKjoCRbSYPEan7SsMKbOoFMxORdcEpAMJinp4ktEaA36/FwlX4uFThKcom5FFKDMJp68cPMaRfHoxLKkypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=W45An+Zz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a635c83bb7eso49415166b.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1716974263; x=1717579063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU3m5vxu3rbmfROVAzPs883xqmmfLXiDDF3GK+pTdyg=;
        b=W45An+ZzonkXA5U9W/6qICDYoJzUqYlLn7GhJncdPN8FYEIhFMHlju1MFIwy+76Brl
         JjU9o2utiKl5ngtHg/NyYc9/Iy3dB9I/8zGaQLhd0nBvCzhi1w1DcpE+RWx6ZzbP8GPd
         sJm2aq4N0KyKcdt7+C6DSfO8h7PeeaTJ+QoEzDMLicPf8q4FSZTvScgRNuPVRJoZdAa6
         3Z3/dghRsGCTlRF2jU4H91HKKaU1LFSit9mWmpAhoBZ0ONYcwD2WbrknM0z38uyaBYBX
         t+KV9VXumKTnRNC+KlJxGuCM2Fr80+7+jcFhhSwaNKZUCgSISPGOyrWOs0g5S0x/10y2
         qllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716974263; x=1717579063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU3m5vxu3rbmfROVAzPs883xqmmfLXiDDF3GK+pTdyg=;
        b=dpazPYi+pwGXWygLW08PtFaB/LIJnJ9Sx/rjK5safPUAbF6wMXJ/WE949PzT8m40r4
         4AkRrvqe6WbIAPmKvXEmTd24Z35naWu2TrQDNkLgPHq8JvBc2FYQOXKKDNRAauJLu/L3
         B0p+etS2aQJd9Iv14XqIRQNDqSgNF6tE+mnxpgAR6mEkuOkcWwjnvFVQiLX2HIVK2K7p
         /AfsdTYQFm7gHaSgXhJ1Od3FGKpcvAyDLGpgz1qcgqUak56TeS7bclKkMmbCnnSf1AJk
         T+yP1v9Ti91fbpGH8iMvq0alONsTqjX8OanNNl6EHjXPGFrBCe86qFthbxZhEiOD458v
         ZtlA==
X-Forwarded-Encrypted: i=1; AJvYcCW9bYxEYZRqlho1djV/GrdKmE8MJfOFkzGBi69UdESLcaLQiCjMz6hHk9yKghoh4bFt6ydUIdfmBV7cCVedhHpcZGKhqFq+ps6nsA==
X-Gm-Message-State: AOJu0YyJnEeIk/kpCkLfl1/UmNF3RdPmRNmk0SZLz5r6EsP4T6Jx8Ic+
	5KMjmpGR8vqEm+5dqrHIcco+A5dcIY7pNHlTWE7iK1uv/xPXf4IONZP57Ov52LDo/sBX5aMOIVc
	Pts7dA/N5GRqsFEqnl2B1oTZWx/dOVkzmIQYugw==
X-Google-Smtp-Source: AGHT+IHOEdJAj5z5kfkYTgPocxN+HTeCtwYAW44s6OSN3sMCcl7pCatWHNyHFNi0MnzCboTZWq9fFOiVksluTzgOuZk=
X-Received: by 2002:a50:d755:0:b0:578:6198:d6fc with SMTP id
 4fb4d7f45d1cf-5786198d81emr10903456a12.18.1716974262618; Wed, 29 May 2024
 02:17:42 -0700 (PDT)
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
 <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com> <e0fa7fc42118407f8731c34f8c192fda@huawei.com>
In-Reply-To: <e0fa7fc42118407f8731c34f8c192fda@huawei.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 29 May 2024 11:17:31 +0200
Message-ID: <CAMGffEna=8vNm89SkzRknLb7irTit0dBeciuC+_KMp+4U0PtQw@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Greg Sword <gregsword0@gmail.com>, Peter Xu <peterx@redhat.com>, 
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
	Fabiano Rosas <farosas@suse.de>, RDMA mailing list <linux-rdma@vger.kernel.org>, 
	"shefty@nvidia.com" <shefty@nvidia.com>, Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gonglei,

On Wed, May 29, 2024 at 10:31=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huawe=
i.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Greg Sword [mailto:gregsword0@gmail.com]
> > Sent: Wednesday, May 29, 2024 2:06 PM
> > To: Jinpu Wang <jinpu.wang@ionos.com>
> > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol han=
dling
> >
> > On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.c=
om>
> > wrote:
> > >
> > > On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@=
huawei.com>
> > wrote:
> > > >
> > > > Hi,
> > > >
> > > > > -----Original Message-----
> > > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > > > > Exactly, not so compelling, as I did it first only on
> > > > > > > > servers widely used for production in our data center. The
> > > > > > > > network adapters are
> > > > > > > >
> > > > > > > > Ethernet controller: Broadcom Inc. and subsidiaries
> > > > > > > > NetXtreme
> > > > > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > > > > >
> > > > > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks
> > > > > > > more
> > > > > reasonable.
> > > > > > >
> > > > > > >
> > > > >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda
> > > > > 15
> > > > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > > > >
> > > > > > > Appreciate a lot for everyone helping on the testings.
> > > > > > >
> > > > > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > > > > [ConnectX-5]
> > > > > > > >
> > > > > > > > which doesn't meet our purpose. I can choose RDMA or TCP fo=
r
> > > > > > > > VM migration. RDMA traffic is through InfiniBand and TCP
> > > > > > > > through Ethernet on these two hosts. One is standby while t=
he other
> > is active.
> > > > > > > >
> > > > > > > > Now I'll try on a server with more recent Ethernet and
> > > > > > > > InfiniBand network adapters. One of them has:
> > > > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (re=
v
> > > > > > > > 01)
> > > > > > > >
> > > > > > > > The comparison between RDMA and TCP on the same NIC could
> > > > > > > > make more
> > > > > > > sense.
> > > > > > >
> > > > > > > It looks to me NICs are powerful now, but again as I mentione=
d
> > > > > > > I don't think it's a reason we need to deprecate rdma,
> > > > > > > especially if QEMU's rdma migration has the chance to be refa=
ctored
> > using rsocket.
> > > > > > >
> > > > > > > Is there anyone who started looking into that direction?
> > > > > > > Would it make sense we start some PoC now?
> > > > > > >
> > > > > >
> > > > > > My team has finished the PoC refactoring which works well.
> > > > > >
> > > > > > Progress:
> > > > > > 1.  Implement io/channel-rdma.c, 2.  Add unit test
> > > > > > tests/unit/test-io-channel-rdma.c and verifying it is
> > > > > > successful, 3.  Remove the original code from migration/rdma.c,=
 4.
> > > > > > Rewrite the rdma_start_outgoing_migration and
> > > > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx
> > > > > > functions from migration/ram.c. (to prevent RDMA live migration
> > > > > > from polluting the
> > > > > core logic of live migration), 6.  The soft-RoCE implemented by
> > > > > software is used to test the RDMA live migration. It's successful=
.
> > > > > >
> > > > > > We will be submit the patchset later.
> > > > >
> > > > > That's great news, thank you!
> > > > >
> > > > > --
> > > > > Peter Xu
> > > >
> > > > For rdma programming, the current mainstream implementation is to u=
se
> > rdma_cm to establish a connection, and then use verbs to transmit data.
> > > >
> > > > rdma_cm and ibverbs create two FDs respectively. The two FDs have
> > > > different responsibilities. rdma_cm fd is used to notify connection
> > > > establishment events, and verbs fd is used to notify new CQEs. When
> > poll/epoll monitoring is directly performed on the rdma_cm fd, only a p=
ollin
> > event can be monitored, which means that an rdma_cm event occurs. When
> > the verbs fd is directly polled/epolled, only the pollin event can be l=
istened,
> > which indicates that a new CQE is generated.
> > > >
> > > > Rsocket is a sub-module attached to the rdma_cm library and provide=
s
> > > > rdma calls that are completely similar to socket interfaces.
> > > > However, this library returns only the rdma_cm fd for listening to =
link
> > setup-related events and does not expose the verbs fd (readable and wri=
table
> > events for listening to data). Only the rpoll interface provided by the=
 RSocket
> > can be used to listen to related events. However, QEMU uses the ppoll
> > interface to listen to the rdma_cm fd (gotten by raccept API).
> > > > And cannot listen to the verbs fd event.
I'm confused, the rs_poll_arm
:https://github.com/linux-rdma/rdma-core/blob/master/librdmacm/rsocket.c#L3=
290
For STREAM, rpoll setup fd for both cq fd and cm fd.

> > > >
> > > > Do you guys have any ideas? Thanks.
> > > +cc linux-rdma
> >
> > Why include rdma community?
> >
>
> Can rdma/rsocket provide an API to expose the verbs fd?
Why do we need verbs fd? looks rsocket during rsend/rrecv is handling
the new completion if any via rs_get_comp

Another question to my mind is Daniel suggested a bit different way of
using rsocket: https://lore.kernel.org/qemu-devel/ZjtOreamN8xF9FDE@redhat.c=
om/
Have you considered that?

Thx!
Jinpu




>
>
> Regards,
> -Gonglei
>
> > > +cc Sean
> > >
> > >
> > >
> > > >
> > > >
> > > > Regards,
> > > > -Gonglei
> > >

