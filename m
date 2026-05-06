Return-Path: <linux-rdma+bounces-20091-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPaOBExc+2nHaAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20091-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 17:20:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B574DD12F
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50D430071FA
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9C480DE4;
	Wed,  6 May 2026 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYhBgUta"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6F48B39A
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080798; cv=pass; b=DRz5dU/MZ4UnWNCjynp8ii4RCh4D3CZ6eKGc+Hl19XipiVS9TXonly4gvy+wSDPhyBzdFwiW3uW3gnw/JEy/u8jruqWNsfz6JujODI1zK6PnrRFgu1PR8qNhR1f+bZZ1+Dv1Mo7jCUkSePgnIEzF2pvLCuonVC/og3PWLsMo8Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080798; c=relaxed/simple;
	bh=m16fKxmhGhuJ7B3jLust56D9Y0CJQn0MnszLnnO7hjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keZPYukNTiswiH8oBUJJR2Hj4V5+SJGT/LcXYuvEhEl7rF9WxcRqxiZ7LP9JAkF367FrgO0D+O52bPOCK0vtm8MVgzu+Plp4oAdnQTqZGqwYZD9MyL5TSDOeumVEqc3ms3TRkXL0XwL6kVmuqX819SbVAlV51W59dmOgGtdgB6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYhBgUta; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-130b2295ed0so5382790c88.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 08:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778080794; cv=none;
        d=google.com; s=arc-20240605;
        b=Dz98X7puPTqxesg7zZQmdPqA0YQQB2us4FDYBb4eL5v0h3TWjzoDvPtzMEmkSmwqc2
         LgiX22RIcZZSYDKbhKHMSOYs7/2sBMoVUdh9MdMZbHHnrUTYi0kQW0mLDW7QANuzC2/F
         eLKxD8WvGhw9ibejvX1ate1on+NXMLWMj0YLPW1+eVGAHut1pWLHtVzNKIOspsRSD6ZN
         WLLPpKufEfXD+yiBwHPMCGI7h6QJD6SU5GGfKK1jtjZdRy9CyKSRAoUpfj+iqgaBZR/J
         fCjMcwmxRWBvCAvYpeSJuUrLaJz8Nsf3s1nbHUWVdTRKn9yoGYjBDd+ohglZgryFCl9X
         FLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cpQKErwL5v1PeRSLbaPmQhFKaI4koIGbE+JbuMQEurY=;
        fh=bv6uahmoCQJyU1AwVFW/QpeDRCvw3FzEifY8JXLFHmY=;
        b=MnFStjyQQpAKVC1IdlCEz1iTmHuhEjgQB930A5YKAsO3Lt+9eC4bJkULAO6CSi790O
         h6nHZR0BRRxvH1c92v8wm0IUZUpZ2xTtvIv50N7OmX7R57DMzk096dLBzoHp8qxCiia7
         Ev7tH1pSUvi490PIrJ8D+9Lwn0/Pq4sYQm8LWtHRQol8+DD6a7qCwX/OQBSNT1Betc5G
         ZGeMSvNTg3HklSwu0MdcKhgmCBuLjgxo3c20Xd9jDwbMnNyhhIkXOx8FaMuxuWY7PYqL
         TmgoMWeB6pDF4TkVsr8gJO8SikkxMMw3ohV1lPhloaOw8m3rFI508Ge4jXHGj0/8o5Ov
         BTKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778080794; x=1778685594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpQKErwL5v1PeRSLbaPmQhFKaI4koIGbE+JbuMQEurY=;
        b=DYhBgUtapbuhKALL/2Ur/l1TYokrH3fgOa0B5vNdjOgrGm61JISOg7vgDxd7CdvoOY
         AlOFP1K03mWPj1xJlIbj6sJoXcVeKvka53xHccbiBfjxKe9KiN4X+p2kSz5VxXeN7fxr
         XJizDK9FWetAV31OFDo6wO0GeCXg8l6brJ4olPPE0XAc+78i/71C6OkJrjWCPhS+OOv7
         ulh+/l96quRD4MdQ0GdbgI3hgppCZOk8KNnNhVw3Izg1YAtUq4KfV9XlUmV17/nomLNl
         5s1qPWq7HEWOdLTr/47TcfJjKo4nhzKU4zvyGLEBen4tRotV+kkJ8Adl9X0X7nnxmsiX
         X3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080794; x=1778685594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cpQKErwL5v1PeRSLbaPmQhFKaI4koIGbE+JbuMQEurY=;
        b=S8MjioLSpqRGjlLgVTeqsnQHi4xEEpjU60KKLzHOYG05dvuAqoZKm5cspzWvY2k7gQ
         YdRlhgCWHn73YLTEgVBKXZOkIyv6BObhjGZCg5Zwq6WU+siEh0E1EMsNajA2QZ9L5m4o
         wQZUtOA9by955ctsUriycjZYCbsivQDL7zn67xON1XRL5zMUhocOF8Xobv/evXLz4sXw
         jDUZl5YK/9bNXEDTR0yfrOLxR5tRl3Yc6odVh/J+KtYCGQUdA6iLGOZrb3xIwdu7u4ZS
         Dfm+BCJ06+to38LJl//Wpsyo1+Cr7hui6Lp4LEjpxhY6ABaBDcp0xUyzOyUdo3lGe1zT
         eogw==
X-Forwarded-Encrypted: i=1; AFNElJ8SeaEL0kAWrg9xJOEp52aZ9ZkUGFM3s9dD9B4wt68n8OvWpA6mAA2o8WstZ8W4qhY+IFhO0iMnFx5g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AFBKSGM6F+WzAyyjQsQXEtHRNWipRBOaq7Tl95IOU34TlffU
	rJ0dmKhcLo8nhk91dTSvb67sK/w7hunK55eZbubs6xYo5PTOYVxowMeEVM2iLSPv7fwXngjYbWN
	vPOHZ5mUy/5Ykx1m+HXsMKnFyea+OxKToc9u/kIK3
X-Gm-Gg: AeBDieshyTOjcQpekj8yQ7ZvFeepXVQaOGv1OG3NrDUWcz/EzA157GY7xOv3uXyuwCn
	aH+WHM9CWBDcwgJgky0ClDYOug9LglvkRwKnBpEGrSr0kWwrKtztFYV6/iuWFMIB8TkSzOLsT+v
	U8VLcT1Yi5Jl7bnK5Zl+w3VRPzxf1PbbYKmCBPpUK0TKIMled8ymy28PN9V/axG5Jyu+iPQbDUx
	u4cBp09pwNaWmFxascOiQG4FpK8DJwGTzkwshyWco+lZQ4+C2irjXNJ2tI3UJiwFu3Moa+6P4yd
	yqfAzuETMttB+OoAM6Q5cB2ivMRgSznFfAmseghDt9Hbf23l9I/auAYmgrWSn6WCcgMryI3QnI6
	zUCLPxqI4nkhbSxymdg6xQPpTdv5XUaNtZt+n07SKm6BwvqLg/yQwPO2ZSKbYSE3zNv9Bz9Pc7w
	==
X-Received: by 2002:a05:7022:1b0e:b0:12a:72af:83d1 with SMTP id
 a92af1059eb24-131852e2bb5mr2101729c88.11.1778080793272; Wed, 06 May 2026
 08:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69fb46ae.a00a0220.387fc1.0002.GAE@google.com> <78183562-ff83-4b7a-9c7b-b3cb92676ee8@linux.dev>
In-Reply-To: <78183562-ff83-4b7a-9c7b-b3cb92676ee8@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 May 2026 08:19:41 -0700
X-Gm-Features: AVHnY4JNtxJaB1nXkXSeADYgjNWogJRVGksEMWkM3mg3pHcGlY2h7MbXmMCHH2A
Message-ID: <CAAVpQUA4kYQ0KTxdJ=xtWp6u7uBUR2B8ZcvwHNV7FDDRu0OHvA@mail.gmail.com>
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown (4)
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, jgg@ziepe.ca, 
	kuba@kernel.org, kuni1840@gmail.com, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 46B574DD12F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20091-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,storage.googleapis.com:url,syzkaller.appspot.com:url]

On Wed, May 6, 2026 at 7:28=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
>
>
> =E5=9C=A8 2026/5/6 6:48, syzbot =E5=86=99=E9=81=93:
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    74fe02ce122a Merge tag 'wq-for-7.1-rc2-fixes' of git://=
git..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e895ce580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D59da38148f3=
a3d24
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd8f76778263ab=
65c2b21
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for=
 Debian) 2.44
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13a613ba5=
80000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/d900f083ada3/non_bootable_disk-74fe02ce.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c0a591d96864/vmli=
nux-74fe02ce.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9f94fb623cd1=
/bzImage-74fe02ce.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc000000000d: 0000 [#1] SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
>
> Thanks a lot. IIRC, this problem is in process. The link is
> https://patchwork.kernel.org/project/linux-rdma/patch/20260424013759.7282=
88-1-kuniyu@google.com/
>
> Hi, Kuniyuki Iwashima
>
> I think you are fixing this problem. I hope that we can see your commit
> very soon.

Yes, I was sidetracked but will respin v3 this week.

