Return-Path: <linux-rdma+bounces-15321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8790FCF787A
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92F64303E694
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6F2DAFAA;
	Tue,  6 Jan 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Nx3qMgDz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F961A285
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691736; cv=none; b=MfS2SyWSYv2aKRNf5x6NRQNcWfWP8hEimMbUUOKhj6C7fFTcWggBg9ImfVdh+6GWsYY0c+87OXF90TCsD3ZxAn0C049TbEobrwUTCGRMToqlRyqM/vrL62hS+pM3T48NJ37cfuCL3VeqC8WiP3umPHyf7iHnM8OJOKhb7Wea7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691736; c=relaxed/simple;
	bh=fD9QgFOhbmzILNgf8uTSMN6AR332/6GC6k6XUR1cOYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMY6ULBetIXab/d6uAm1CSD+CBGrXp0xV4qSo9bgM+h5veb+49wDXmmp1zBYm33Qw3aEw01/StBlYVNPbAmNED93uKDLusEumCINRAXslQV2JQUVdTWBnNMBS/m3bIEtBoSuXemobwfIlercNFk78UYtfBmFmjnxLErk2Uec/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Nx3qMgDz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37fd6e91990so6705841fa.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jan 2026 01:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767691733; x=1768296533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOx6oMYGbl0Nm8fh2fQSWBSwuTZaFX/o6jedzBtP/qs=;
        b=Nx3qMgDzk41OBRkaiz2xLepaJDrGdGU3fkK2eNj8fT408EqQ2da1fOMqLtZMMTI18p
         mv+LcdsMi+pLACC0kNubch/9EbwGNnmvW2lEfngLVJ9Qn4HqvSCmgWmn0PNfGgA1+Yx4
         j1Mp3suFpeQ7yG0z85inVr8SxP1xnyGq+03HImYeUzYDvygxArZbVEdTyLy8g9pNw/EB
         2+wAPJ+shwpfLyeuX7URT9oP/OTU8eHSC9Wvo4mU8/+iX6ljQGVmFM51GpfMU9CXV4WJ
         rQ7EB3wuTICKbAr5qdsd2/4aju3rBgwtzqODhOPNgPDcWMVePObD+gPdpntXu4SPLiI5
         tLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767691733; x=1768296533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOx6oMYGbl0Nm8fh2fQSWBSwuTZaFX/o6jedzBtP/qs=;
        b=tS7ztpV4D2In/bG5elQxZ826PQwHNtUWrHlOl3SwqfIdrAROApI+dTIxyTHqfYJ5QN
         iYzVzhc49h4IRqIEqFnwC47vPNx+8bWqkQ2/1DhcVk11mFFupXiciDG5KzAl/cJZNrOn
         WQJIlhyUdExhqBrPoj7T/8AMBRAHnpOUBr5hvPNXtaQEbRDI2/6MBvMPXF+hfZjaDBn4
         QCTLD48+slv0xo+4er/W+/OoVVeWIWw3t64spbh+wBNQFbW8Cg6ge9hjk1aSh6lXkzDS
         BpcFIk5JgP4KrE22p5wB21m0VIdmf8jYENB22amTrA/swaI3WhixLmBoxrDJ4Uari2CQ
         RJlw==
X-Gm-Message-State: AOJu0YwGn2pwGUB7dr5hs8Cf0mg1rf2dnkaTHKKuumCBupk3h4jTWApg
	gmzqYbuI+Zagz4HNEhs4GrKj+SWNDtvmVXbMT8QzDeqU69amHdCqPcYRWzlV63iBKELMBPHjfp/
	RecZLvkK4XteddtTKT5n2/uAZrM9BjL1cVD2u0aoAaADh5GrlaIeh
X-Gm-Gg: AY/fxX4pxhoZZISPIlcYUc6grPNbXNSx6CRILsFp2emgICMi8gmEnZmUN5Dk3A7TQw8
	eKvB8E5v4hOKH+VukUHV9MWVix4PuFDwB8PCPYtOle8/N0cWMST88IpdLuxa5H7ZlMZvIhK/XgD
	hD/jmrgVGQqVcwc8ns6onEBNxZPaPZf/YU0ohn99OFqAlETWV99T7/rEaqPoFu/P/Q992joh/7i
	Fm0BWdk6W/Lo/1zlq6NN047Dn/RsFL59GRnPjWSD9QnchkNkVk5as4IwjJUyqFvd39t1CM=
X-Google-Smtp-Source: AGHT+IEX92pqnk14BjfkDtNoItKAL+06o2l97yoaokxffXxQ/rznk9SNWZ/xuUc1yVxrkEJhN2GL+6gXIO4/mGcgr1Q=
X-Received: by 2002:a05:651c:4210:b0:382:5f1b:99c5 with SMTP id
 38308e7fff4ca-382eaacd968mr5196581fa.28.1767691732866; Tue, 06 Jan 2026
 01:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-4-haris.iqbal@ionos.com> <aTd3fOJcyRklaHGg@fedora>
In-Reply-To: <aTd3fOJcyRklaHGg@fedora>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 6 Jan 2026 10:28:41 +0100
X-Gm-Features: AQt7F2pjgVjaWEauvl7pYRQYcfjAnP2uI_3780H3DPdOBQbrGriN7yHaQ7-gNOs
Message-ID: <CAJpMwyi-Cc4EDfCizpop+koTtu0Bfjf_veqbOsad1xnJ=Kr5tA@mail.gmail.com>
Subject: Re: [PATCH 3/9] RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_GAPS
To: Honggang LI <honggangli@163.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org, 
	jgg@ziepe.ca, jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com, 
	Kim Zhu <zhu.yanjun@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:13=E2=80=AFAM Honggang LI <honggangli@163.com> wro=
te:
>
> On Mon, Dec 08, 2025 at 05:15:07PM +0100, Md Haris Iqbal wrote:
> > Subject: [PATCH 3/9] RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_=
GAPS
> > From: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Date: Mon,  8 Dec 2025 17:15:07 +0100
> > X-Mailer: git-send-email 2.43.0
> >
> > Support IB_MR_TYPE_SG_GAPS, which has less limitations
> > than standard IB_MR_TYPE_MEM_REG, a few ULP support this.
>
> Do you have benchmark performance difference between IB_MR_TYPE_MEM_REG
> and IB_MR_TYPE_SG_GAPS?

We haven't benchmarked it yet. As a ULP, we wanted to first add
support to RTRS.

>
> thanks
>

