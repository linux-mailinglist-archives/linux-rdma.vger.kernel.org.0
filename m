Return-Path: <linux-rdma+bounces-1403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7A879439
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 13:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13671F23D94
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857A4DA10;
	Tue, 12 Mar 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zphrWtR1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AE1E4BD
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246897; cv=none; b=u+IUIfiXidylm58Z19tQzUvD+oJw1YTy+ibAMAx30wQL8T46hkVHtdzD6q2dlqL+Q/L5IX8oOJazoDFVO4myuE+r1QmiiWCMmtmdCsQZr3AQ3dVHJr8TvQFTBjaOonPy/VxL8VUd1qcIvF04i5K9oKdvvYM6jLAczqPGwnR/z7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246897; c=relaxed/simple;
	bh=kR0tEDOgKaIUv+cPTORVbcVMByNslT3pwaH0KnUvoyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAvQ5FTTvlFfxL5b0IdJGmjunnnAzNEHx/ES4UIYcjTUDY0YJ/+VrbtjWTeO6VJrtmSbE4xyBWlYpnNgrFF9DsXMyIf4QVq0kv9R/vk/InIWY0uNZm8S5iGI/Jivs0uCbq4kGhLr4T2NRV6Py+GtjDXHeuKqPbz86N1l9orzUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zphrWtR1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so16613a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710246894; x=1710851694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfh1UjKD83DIxA9AQa8yYjvPesUNU0GzJOlhCtJkyho=;
        b=zphrWtR1BnghL2Uhs2GSYRgcDav8sifScTYtLFZDWbAODt+1JDPSF7OGTM/YUe/Z57
         lLVU40aBbTM1TzLIZ9Qx94vjKYN2HuSQU+7zL6f7/X+49dwyiUzJvAr+Ysva89vn3UCs
         TWl4I9O6e52381bDl9BgORXXzbcLovSx477BCVxQ/mSXrsr2BXT3xbZlGBpBZ/w1ECM9
         JSs8iOX5WTpdxV3xJiqOB15g7/f9SOeODnyxEsSL/x63i4NHaMixHjYJi+U+zNREEi5f
         Dj5q9+Iz/Sv1t9MLYauQTWoGawu9E5Rg8xjeGZjt4Nrd7ZNB1D5MrLRIrjP5kZ8iuDOs
         3pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710246894; x=1710851694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mfh1UjKD83DIxA9AQa8yYjvPesUNU0GzJOlhCtJkyho=;
        b=iOvpb9+9IRnLsGPe35KLjN8Wk9wINFlyitbLaY/v9GQKYtnYAkEi7fymNAOBndYLdl
         eMYvBXoCn+9vmg3h7xoTbj7nVh+p3/k4n56t0TjnC7GrnbCvsEQiEfp6kaXB7C6TG96q
         Htz7VBq/6pcMzktmCl1cSj+b9hPUCjqlOPU8ByHa5jr6WG+CTjvala1t9cKSh/P2JPNJ
         13TThtG6rwEjH/1pcV/EuSJl/PgJ/1CoVLjGud7C+Xz1DOq/706CL6hfTPTfFmcYA1gK
         dCj2tVGSQzEbwPCNhH88hqz9pIQOhpHBC0jRJ818+Ooq17nFnWBPHctImRFVT+vNF24Z
         sbTw==
X-Forwarded-Encrypted: i=1; AJvYcCUeazXrqRDEDeK9a6LThAkRTSDPycFxtxaKu7w3AtroWATGMjtUO8GaFhRPYBj22f+F2oaTttvMrTLJ5wVfn/GEuxrnjYL9kcDV4w==
X-Gm-Message-State: AOJu0YxheIzy5Ds2BzpXhZn5V8TJ7o8ULvQa6WORdHR5uDEGCk6tq/1R
	C3Vrr7WVDC/83CyViRA92hzlDph+ap/j/AqdKhsxdNoLBx+Bh3Go9urtABqdjqR9iXSDafhnyQR
	nPSb6wX2t/Awcn+IeNMHumSpLBknOqCbigmrh
X-Google-Smtp-Source: AGHT+IG1DK0iOGIVXmV1a+IPHupfSkd3uPey87zgHgHK67atM7sAV5q2StsWOfCWdAKL9cbjYg03uvGJIFo0wakVF2I=
X-Received: by 2002:a50:ee90:0:b0:568:271a:8c13 with SMTP id
 f16-20020a50ee90000000b00568271a8c13mr134341edr.1.1710246893822; Tue, 12 Mar
 2024 05:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308200122.64357-1-kuniyu@amazon.com> <20240308200122.64357-3-kuniyu@amazon.com>
 <6bc2bab66d3bc7aebbde92d4f268effe6b62db35.camel@redhat.com>
In-Reply-To: <6bc2bab66d3bc7aebbde92d4f268effe6b62db35.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Mar 2024 13:34:39 +0100
Message-ID: <CANn89iKcY54osPG-5kJFhpG4EOodhfoacsM3GNSHJrDM=b3AMw@mail.gmail.com>
Subject: Re: [PATCH v5 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, syzkaller <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Allison Henderson <allison.henderson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 12:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Fri, 2024-03-08 at 12:01 -0800, Kuniyuki Iwashima wrote:
> > syzkaller reported a warning of netns tracker [0] followed by KASAN
> > splat [1] and another ref tracker warning [1].
> >
> > syzkaller could not find a repro, but in the log, the only suspicious
> > sequence was as follows:
> >
> >   18:26:22 executing program 1:
> >   r0 =3D socket$inet6_mptcp(0xa, 0x1, 0x106)
> >   ...
> >   connect$inet6(r0, &(0x7f0000000080)=3D{0xa, 0x4001, 0x0, @loopback}, =
0x1c) (async)
> >
> > The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.
> >

>
> Eric, the patches LGTM, and I can see your suggested-by tag, but better
> safe then sorry: could you please confirm it is ok for you too?

Sure thing.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

