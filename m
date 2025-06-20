Return-Path: <linux-rdma+bounces-11504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD76AE1FA1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAE93ABD38
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1392E06C7;
	Fri, 20 Jun 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VntyLvqX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE39291891
	for <linux-rdma@vger.kernel.org>; Fri, 20 Jun 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435016; cv=none; b=HHI8Lwo46ss026/yZmc4oHrHei7LbtR/FL9Hr++uJmMGlCoqwLH0WHn1pAvdlA/TGanNVnZggrsvCl8NtnlVujGRJxuN5Ol7TnEIPvgsa+BG2YSEbTFBZAoIkPZid/h2ahgKdi5LvDhYdwnyG1B8sRiw9DEnwcwDhEBxiHBERS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435016; c=relaxed/simple;
	bh=uvxBpESCMbHsgEzjJh55zIXNCELP+P6fl0LG0UEW5u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjnE976pXv9dN1XbxQGLmohrT4AcvAZHG+kn4Df8ruE7iOIjS0O41vb6Vv6OWYKi3QEH1j0tlNE6wDHA6SOZT0MtTTMtaD5HNfhYpCUgu5AvvkwyYuEjm7YsDtOfHaHbEpS9xyBNCcHl6MrapM0v46gwRrETeETyfh0inWxEixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VntyLvqX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso1537577a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jun 2025 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750435013; x=1751039813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLFMN9XGHEQncN/Rk0oc/2KOZAjQWflIL1sv4KEiWjw=;
        b=VntyLvqXK38iTRkc7avjExvWzAJyhgURw6AKV+BBS7BR8EIgcJHCY95z/E3NcIiaEV
         lWIbl+FaueDupkLEPkgaTHiCHAqT8mmdKyyUI99/BXmIcnwHa1rLKeJkNzJ/EDAPwG90
         oqc4LpI+jjfQvYbt4bP+m3h0SEtkRW1aPM8cIB/YH6jXt1yvwS4wHuYF8vpkP/PnIXbF
         dZYtmsV0JooeLvDxnG4nMqMiScukYfHH83w4m1Q+OOuQoCY+FWxNMiub+zUOtBafDUYZ
         gozSGhsgt/UisYqkOM/B6CEW04LFwT9hHLw7M05SPgm9x+fqkpvuXcFt2TrgkE9CREO0
         c2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750435013; x=1751039813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLFMN9XGHEQncN/Rk0oc/2KOZAjQWflIL1sv4KEiWjw=;
        b=QQ/njYOP7kGMktYmwiMsaURZySrB3/XKPfj0KgG3RAwK4W6ueF7IVDoIUIkVZx4euH
         qEE3fkYPv/D+/fDM6NO/pZqK+OIiSsXmAC1+XWETV3Dt8e0I08mERR4a+g1Ot+cxLeuu
         i8h097u2lTB778hojAmX36GlGFUiVqJR+ZYh8zaxdH2HW3nsMjdWMhIkhx1ZFSiOKGQl
         35YiqyCs5qJvQsqLcFXZZl9L/GPMl2wi3BXR1UDQotlLco/j5AwfrpbqTbuxVKSVqkXd
         8gOlvTC8B5RmEesl59rNKBK6VNhdhBWAZ1HKLGwpLunE5xVroZ0mRb+jkL8Dc+/hW9MI
         c06w==
X-Forwarded-Encrypted: i=1; AJvYcCWfhgHPvbYB2+fFB6UQQBE8F3hp4GhAxcUU32g9Rp06YMzT7k17pXbpUgE+gK/cvVzQYgpogEHa1SDf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gy/Ll2pNfJxDkHqQ7myglM4CM/x+Lnccai9El+QHDExQ80m+
	DFoCCux1mzPPPpk4v/cvukEat8PzlWNGQ0b+xlh8JBqweNkBEQm9+HkD6YX+8Y2C1QO1c9Sb85e
	RegNum8zlUaaz/vYjPNPC85P7PasyoZxH2czeMbrH
X-Gm-Gg: ASbGncuywEP4r5RXOpAUvvyz2ZJAiypzoeyNRI6jz0V07LdELVWEjEAiBYo6/Z3CDuD
	90TmHGYQCAQMY8pC/IxhAeR+fIGKjAyW91oOvyNUDJInEOCRELjLz/r+6W9A5vThIR3jG4f6PeP
	/rit/oD6Ri9OWJRRML3xfuiI/VWM8ee4RwblCpES9zyAPX9Fw9oi9S54obgG5/wZdRjix8UcdtT
	h0=
X-Google-Smtp-Source: AGHT+IGlC42zb8vDWg4AdcpNBkw6kQLXOVdEVVhKiKEi+FEf8PRmfMjgtqSTDp9VyYGZrA0DQNlEsR0V9wYodBKb4jw=
X-Received: by 2002:a17:90a:d888:b0:311:be51:bde8 with SMTP id
 98e67ed59e1d1-3159d8c532cmr5647414a91.20.1750435013192; Fri, 20 Jun 2025
 08:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68552aae.a00a0220.137b3.003f.GAE@google.com> <a3781077-5f71-45e1-bd73-1a85d927fecd@linux.dev>
 <8a3ec239-7504-4c1a-86e7-4911be42e0a0@linux.dev>
In-Reply-To: <8a3ec239-7504-4c1a-86e7-4911be42e0a0@linux.dev>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 20 Jun 2025 17:56:40 +0200
X-Gm-Features: AX0GCFv-ONGi5vchutHvuFs0_g6k6clWB_YsqBacDdJpJXEBWBX-aVyBHib85Ko
Message-ID: <CANp29Y5yssN5p-QwyB=ci4HwY9EUSC0aKcAenU_CyXiu_zhxFA@mail.gmail.com>
Subject: Re: [syzbot] Monthly rdma report (Jun 2025)
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot <syzbot+list130c9052d10c27bfc9e9@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 20, 2025 at 5:24=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
>
> =E5=9C=A8 2025/6/20 8:12, Zhu Yanjun =E5=86=99=E9=81=93:
> > =E5=9C=A8 2025/6/20 2:32, syzbot =E5=86=99=E9=81=93:
> >> Hello rdma maintainers/developers,
> >>
> >> This is a 31-day syzbot report for the rdma subsystem.
> >> All related reports/information can be found at:
> >> https://syzkaller.appspot.com/upstream/s/rdma
> >>
> >> During the period, 0 new issues were detected and 0 were fixed.
> >> In total, 8 issues are still open and 65 have already been fixed.
> >>
> >> Some of the still happening issues:
> >>
> >> Ref Crashes Repro Title
> >> <1> 462     No    INFO: task hung in rdma_dev_change_netns
> >>                    https://syzkaller.appspot.com/bug?
> >> extid=3D73c5eab674c7e1e7012e
> >> <2> 338     Yes   WARNING in rxe_pool_cleanup
> >>                    https://syzkaller.appspot.com/bug?
> >> extid=3D221e213bf17f17e0d6cd
> >> <3> 72      No    INFO: task hung in add_one_compat_dev (3)
> >>                    https://syzkaller.appspot.com/bug?
> >> extid=3D6dee15fdb0606ef7b6ba
> >> <4> 50      No    INFO: task hung in rdma_dev_exit_net (6)
> >>                    https://syzkaller.appspot.com/bug?
> >> extid=3D3658758f38a2f0f062e7
> >> <5> 28      Yes   WARNING in gid_table_release_one (3)
> >>                    https://syzkaller.appspot.com/bug?
> >> extid=3Db0da83a6c0e2e2bddbd4
> >> <6> 5       No    WARNING in rxe_skb_tx_dtor
> >>                    https://syzkaller.appspot.com/bug?
> >> extid=3D8425ccfb599521edb153
> >
> > To this rxe_skb_tx_dtor problem, I think I have posted a fix. Do you
> > make tests with it?

In general, syzbot can test patches for the bugs it reported:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patc=
hes

But syzbot hasn't (yet) managed to find a reproducer for that specific
issue, so there's no way for the tool to test the candidate fix.

>
> Should I file an official commit to confirm if this problem is fixed or n=
ot?
>
> Yanjun.Zhu
>
> >
> > The link should be: https://lore.kernel.org/
> > all/6813a531.050a0220.14dd7d.0018.GAE@google.com/T/
> >
> > Best Regards,
> > Yanjun.Zhu
> >
> >>
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> To disable reminders for individual bugs, reply with the following
> >> command:
> >> #syz set <Ref> no-reminders
> >>
> >> To change bug's subsystems, reply with:
> >> #syz set <Ref> subsystems: new-subsystem
> >>
> >> You may send multiple commands in a single email message.
> >
>
> --
> Best Regards,
> Yanjun.Zhu
>

--=20
Aleksandr

