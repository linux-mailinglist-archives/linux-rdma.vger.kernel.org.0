Return-Path: <linux-rdma+bounces-12199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B718BB064EB
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A0B567534
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2C28507B;
	Tue, 15 Jul 2025 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfRqkZjG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1E27A455
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599240; cv=none; b=AqdJvPASMe3VgWkho1rOkxKWWU3dTKJ+w3xuDuE7i6STOywIsf1b0cQ2v+37zPKpR4AH+EOLbLpsOmXjubvn8TfLtnOj/JSqu3/2C7iacxYbnBr5NjXugzldDKyKEBQRwDWTxujKVJaqW39WtGC0L06QjSiHqlG7vtiZ9O1Ik6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599240; c=relaxed/simple;
	bh=D5iNuzhutabTsgyHNmq5UmAbTLz86s43oSR1uhCMj50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu/pjfMyrwlVEGytHtmSzUEZ30+53WmobI/a59fs6KRp+LInLJIkmyjwMqcYbDpo1AVHIAJ1CbawEizrYRzJ+UpB/gYAwj0bdbh0ke0bwFxpsxbWGX5YFXsF2bErbxqf8iwhixM2+mxj9wf184GFF1D2/kOwnvFD9RUsFPWLHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfRqkZjG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b350704f506so90221a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752599237; x=1753204037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5iNuzhutabTsgyHNmq5UmAbTLz86s43oSR1uhCMj50=;
        b=SfRqkZjGk4xLkiKRPkic45WPKXaunL6NYZ24h/zXDjXDzVm4ku84fp4z7wFl5/gT/o
         RO6VUrqjGgUqCgv11XHDFwX/RXJi6jdpIzJ/Egn3oy3gd4uWtNb9YDgk2RNu4YiT/s8+
         ieb5H1s1tn8Q4K4o1pTRHw5hsLHncT4J2Wf0S2hUXP+tDsX7KOzQ7Sfi6xNYHdyFUzwN
         /+zg0zJDgJsfKcDCSQ6rdvbZdUu1xVWK6NkTIrocbAeqszZCU1iaAGC5vwXdns35Lv+b
         7RtAceJEbs34p7AF5aUCyvRXEWT/pIQNgCZ0Bz43VMepOiDH5PDya6ERuVPSyRaYaT/v
         FNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599237; x=1753204037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5iNuzhutabTsgyHNmq5UmAbTLz86s43oSR1uhCMj50=;
        b=XIPe+XlGja1dvV8eEd4AyDjmVPYg+kDw8fPxZVfUXbhkqjEHDojIF/DshCWEqVyO5s
         dzLxEebnn4yi/iZUTx9NFsCJhfcIYp74SFHyRmHsrrtYTjXqKtFJRd8t/Q/bybhR1NVk
         boK5BXH3rxoS7sGPmJqhmjQXrxeziNAKe2U6QUXnlOPI35/7kGTtYaKpWtrNIAH0yzvW
         vAdjnCpaqdmebMVjNMJPNlolcOSrSM+n6MvHpyyqGb3Wvq3rAWN8Xe9uCjS0zCFY/Fbv
         DoW5VXDqmFUH+nuWK63AHsYRX7tjO1WE+WDiPY2K/n1v63GtMJHSe9jp5aBBD2NCEZDN
         O7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVzsR+gWczKHghYoJ6IWQuXaCLZfOFMSSoK3ifq8ySer8CgP02te4tlu/h9gCxzvJvKX/IN922dAhEf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/1moIcjiWs674lYNkGXjNtcI3mOYDY5ncLCAfUND3wK3lduQ
	CNjlcRhEaaKByMxUq4Cl+xuOhIOnR68KdtiSCdUehP3l9KYZOCRBKm9dc9VOo31LQzA8Tp0A50r
	SAHmmo6ghXwlCrvAm87CRI8wtKTDMTsJBZVkGF6cZ
X-Gm-Gg: ASbGnculsK3qP0sh/j34PiNu9ZJg/LLfD4/qdj+JfTpxG5V9fb8UR/9l8S/Wq3Wl73r
	Xzte3mwfvUqmnHd8m4jkuf5bRgyXH7Gp1FLLXxkkKfx79bezF+br7+MC8P2+0iEY+yh4squnvO0
	JRpAEbfItkVjM464Y2AHnSY2nvPx36K8L2HIZELlUn3h42j/MVmOE5GO7U/wBxOgqfY+rsG6592
	SObLDTIgaam2LQKFI7bmt86teWE+/HhO6NVMQ==
X-Google-Smtp-Source: AGHT+IHLAGTn1Emeu5qzmFf+v0WLOm0wkpMjlKYOjirs6Jes9LhingmeqRFWoO0Ayq2Sf39BciZkEOn0fxvO6vjDMnk=
X-Received: by 2002:a17:90b:4e83:b0:311:a5ab:3d47 with SMTP id
 98e67ed59e1d1-31c8f7dbf49mr7146720a91.1.1752599236745; Tue, 15 Jul 2025
 10:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711060808.2977529-1-kuniyu@google.com> <965af724-c3b4-4e47-97d6-8591ca9790db@linux.ibm.com>
 <20250715115852.GA20773@j66a10360.sqa.eu95>
In-Reply-To: <20250715115852.GA20773@j66a10360.sqa.eu95>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Jul 2025 10:07:05 -0700
X-Gm-Features: Ac12FXyF2RRGFRlApZSFjNa_0BZUMnhfS-C-PutTrPe_apQKn2nYMlszR-omJEs
Message-ID: <CAAVpQUDrtvVadYGG1ZfL=usU11jbN-bZ=FQ4n5+1Ammry-w1yQ@mail.gmail.com>
Subject: Re: [PATCH v1 net] smc: Fix various oops due to inet_sock type confusion.
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, 
	syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com, 
	syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com, 
	syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 4:59=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> On Mon, Jul 14, 2025 at 09:42:22AM +0200, Alexandra Winter wrote:
> >
> >
> > On 11.07.25 08:07, Kuniyuki Iwashima wrote:
> > > syzbot reported weird splats [0][1] in cipso_v4_sock_setattr() while
> > > freeing inet_sk(sk)->inet_opt.
> > >
> > > The address was freed multiple times even though it was read-only mem=
ory.
> > >
> > > cipso_v4_sock_setattr() did nothing wrong, and the root cause was typ=
e
> > > confusion.
> > >
> > > The cited commit made it possible to create smc_sock as an INET socke=
t.
> > >
> > > The issue is that struct smc_sock does not have struct inet_sock as t=
he
> > > first member but hijacks AF_INET and AF_INET6 sk_family, which confus=
es
> > > various places.
> > >
> > > In this case, inet_sock.inet_opt was actually smc_sock.clcsk_data_rea=
dy(),
> >
> > I would like to remind us of the discussions August 2024 around a patch=
set
> > called "net/smc: prevent NULL pointer dereference in txopt_get".
> > That discussion eventually ended up in the reduced (?)
> > commit 98d4435efcbf ("net/smc: prevent NULL pointer dereference in txop=
t_get")
> > without a union.
> >
> > I still think this union looks dangerous, but don't understand the code=
 well enough to
> > propose an alternative.
> >
> > Maybe incorporate inet_sock in smc_sock? Like Paoplo suggested in
> > https://lore.kernel.org/lkml/20240815043714.38772-1-aha310510@gmail.com=
/T/#maf6ee926f782736cb6accd2ba162dea0a34e02f9
> >
> > He also asked for at least some explanatory comments in the union. Whic=
h would help me as well.
> >
>
> Just caught this suggestion... The primary risk with using a union is the
> potential for the sk member's offset within the inet_sock structure to
> change in the future, although this is highly improbable.

Right, and this only happens when we start using inet_sock in the union.


> But in any
> case, directly using inet_sock is certainly a safer approach.
>
> Uncertain if @Kuniyuki will still get to revise a version, If there's no =
further
> follow-up, I'll make the changes when I get a change.

I'll post a follow-up once net.git is merged to net-next.

