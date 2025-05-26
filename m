Return-Path: <linux-rdma+bounces-10734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184AAC4395
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 20:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134B31895250
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C1023F295;
	Mon, 26 May 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7vNnabh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3E6F53E
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748282446; cv=none; b=NJ38nZWmplY9aIwHp16K8Thqjia2w6+0OnzkQMs/iJxZmwwwAqg/yVs/Jd4p/de/a3Fnv3Vtbnk1MQe8UTAeDmLp4BhqmaHn1+w2YbLuH+aIPqu+admf84KTvuKGe2GSlMFgV0s3axBbORHr8cD8K3iOBUOyYWsq2K1yNIv4GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748282446; c=relaxed/simple;
	bh=rI+licYUolL5nhcW9GoIZLfSpbwxMtL6YthxBl22SZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHRA8cd7cbY9EDZFW7JJgvkxiu6ehYx+UPpXXyS5xtCDoiTHhhiI66kkADsSY/7/uA5w6ifGaMCgqSbRF5BoKc4OdVf+dyIsc6K4OVcQtKbOCVh9mSbLdn1LlZKQOOseri/DyuhkRP3t5YJi7es4bsXp7RVIDeoM8sqJqEakX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7vNnabh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2348ac8e0b4so85455ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748282444; x=1748887244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE00iNGaQOBcvJTWH1HJdDZjS8vODDdLLtmR/QEPXS8=;
        b=f7vNnabhvdOz0PP/Pa+YruFib71wohXXIsckWp4N7raMihaWFWdtGU0iwOCFIUuKsp
         rHDtYtQm8cvpalAzewKWO5Qsu2Ni/Lj388MvKw+8Ubnks0PPr3Bu6WhunmtXo3CrKUTv
         FEa4NQNNzeBdCLIOcO2Ablmh3WcJ7VDyumAWkhPl2NY1/AHTPrvmAGd25fjGTMsm7xOb
         OrEVPBJ3NPzLIW5m/zqzTVAZp7HSkx5QIvBX9xBrQ/MifvQxp/reImpMB4t39wpUcN8K
         HaHm7RrnACuH2U8cWM/prs4K4HStYaQkftkA6T25bScCeeNtaw8zc0UukANCGaMPR19P
         GySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748282444; x=1748887244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE00iNGaQOBcvJTWH1HJdDZjS8vODDdLLtmR/QEPXS8=;
        b=TQfjfjlkXg90tn1tlY17kWU5ngeyWVYu4KMRpkc2OsxwAebtQrmkwlFm5ezILiatYu
         PrntiylXtRIIb+mDyoaOwoHxjqvc9K9PHXoz203JTLkehna6WP5RB33gojN1HLp2mFNM
         nmQb2HCh9byF0N2GuVtqqkgwi2dcyBpIxorowQlgjDpCbGW1g58/Ly+BTf+2GczAFBe7
         6eR5I3WZJU3MX78Ci9iEiFHZ/IAjWbNQvQBLjL5ypgnurzJMoby4cFXYjMzMqW7pScGz
         G/XCVRe7FniAH7Ezj/NzYoKP61Z5w4PruJHQeLK9UOdoHS3hS/+j54swXRlxj0/g2Ktp
         BCAA==
X-Forwarded-Encrypted: i=1; AJvYcCXNsLEMCJ7NKGi4glIoa9hyJsvmn0SQDulZScDvWBp6umsG52c8dAUCVd2+2N8ipzBAhMa51jKUd2Cl@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3uVG4OFe8nzlaka31myyNguZR5TYR0bfqUYgoATD0nOZlVnc
	s0etwOg3/ioDe2+1OOHoWpm/PW4/mD6DHb3kn/tAriWiWk15Da6BFWJiHOzHek18Spk+YiIEMN/
	0myp7xVUgWPrCTwiF1/tZQrCNO5/L7+p6Ee/+LcNc
X-Gm-Gg: ASbGnct9DAFArB7AgBet0eNI9Cc4WGfGOIEQZBWlwJ2z1BOC0jrkK8/9/3moe75WAM/
	5YroPT0wng61+dlHfwqiK0MdIKhOrqJd3em8sfKXCtM6RGXKJBiT71fo3HSWnDWe25OeoM/omVN
	1PXAunaUGwRxntfXBbsM5HS01pRz1XnMg6WqSLwOa8MU/H
X-Google-Smtp-Source: AGHT+IEtmxefPpCTSi1gvHA9a9DIBuanG4oeTpITjr5Cfh4ZkHf1HTV7gnyeYgG8lD3UeMrlJvwRa++zz4aloVbC260=
X-Received: by 2002:a17:902:ec8d:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-2341b52771amr4576785ad.19.1748282443435; Mon, 26 May 2025
 11:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-14-byungchul@sk.com>
 <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
 <20250526030858.GA56990@system.software.com> <20250526081247.GA47983@system.software.com>
In-Reply-To: <20250526081247.GA47983@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 26 May 2025 11:00:30 -0700
X-Gm-Features: AX0GCFsrsXIO7EOCYLWTkGfVc6XTbNgw4nzAjpdO0g7ysDNdP-dZJFnwMLd86jQ
Message-ID: <CAHS8izOMkgiWnkixFLhJ1+7OWFbYv+N0am83jV_2cgBecj-jxw@mail.gmail.com>
Subject: Re: [PATCH 13/18] mlx5: use netmem descriptor and APIs for page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:12=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Mon, May 26, 2025 at 12:08:58PM +0900, Byungchul Park wrote:
> > On Fri, May 23, 2025 at 10:13:27AM -0700, Mina Almasry wrote:
> > > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.=
com> wrote:
> > > >
> > > > To simplify struct page, the effort to seperate its own descriptor =
from
> > > > struct page is required and the work for page pool is on going.
> > > >
> > > > Use netmem descriptor and APIs for page pool in mlx5 code.
> > > >
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > >
> > > Just FYI, you're racing with Nvidia adding netmem support to mlx5 as
> > > well. Probably they prefer to take their patch. So try to rebase on
> > > top of that maybe? Up to you.
> > >
> > > https://lore.kernel.org/netdev/1747950086-1246773-9-git-send-email-ta=
riqt@nvidia.com/
> > >
> > > I also wonder if you should send this through the net-next tree, sinc=
e
> > > it seem to race with changes that are going to land in net-next soon.
> > > Up to you, I don't have any strong preference. But if you do send to
> > > net-next, there are a bunch of extra rules to keep in mind:
> > >
> > > https://docs.kernel.org/process/maintainer-netdev.html
>
> It looks like I have to wait for net-next to reopen, maybe until the
> next -rc1 released..  Right?  However, I can see some patches posted now.
> Hm..
>

We try to stick to 15 patches, but I've seen up to 20 sometimes get reviewe=
d.

net-next just closed unfortunately, so yes you'll need to wait until
it reopens. RFCs are welcome in the meantime, and if you want to stick
to mm-unstable that's fine by me too, FWIW.

--=20
Thanks,
Mina

