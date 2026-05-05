Return-Path: <linux-rdma+bounces-20025-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB5FFEcU+mmlJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20025-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:01:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB54D0CE9
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDF3304001C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C44648AE20;
	Tue,  5 May 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRLB5fuK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55C48AE01
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996656; cv=pass; b=r0nORYDii8ltXG+4tiyER4z9IyxLieMZYId6ftAROOodsPQzwRerC3fvmOKHd3KNQUtAr9x/GJMCR5C4oQIC/RizAV9CITVjVIX3c79QNVIg1Pfq+mwGnBFN8oU93TAKSQ6g3/PYHOP1uMbwbqxMV+TgQEgpbqx4gFsTHwmYHo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996656; c=relaxed/simple;
	bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msGpOHdHhH1o7RE9a+Cb4Ez0z5hPD9AD0OMs6/lcf6PKCy/dnPQVmSOFOtmtasKNn6VWQgZPIJTn4ssL2tmWGUDNQ5708BKONekJ+cjkyg9Y7LnA8gLTYJo7jufQCQccR3I7DIsKjHzcexjqW/QnE99AV/dta7XVP90FZtf38ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRLB5fuK; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-130b2295ed0so2446421c88.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 08:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777996654; cv=none;
        d=google.com; s=arc-20240605;
        b=exPf+Ckscj66lqDC6BmED8puqybrSY7oJWXhDtBPUFjglswuyetnT4QtfPpudbaXib
         Hes1PtP8QpsCc91ywQL5zKhdxqczfPyaNxodG4Ous2pifh2HyUdwN3ecNRgb63FI5qPy
         C6wSL2gxrq3YCCPHTsX4ctNn1jgv6KlkRK9gZkBJWzhrKAXgaBJ7oH2rCq3MOkRJ3pEv
         Q2ONkXO0kNnaAK63ff9TfHNqYViIwKEQJ9WphB0VNp8/UO7BFxFHya8OoW9EIJHfkWS4
         NTQQimdcr9cfL86k0bZKkwpsmRiIXJxBxGcaNTCX9PP0Lc2yW0MjvxJd4dVaZp4zhVPG
         1wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        fh=mSo/Z4CM3nmQeB/oAraC5TJdNz4NvxY132j2pZp5b/U=;
        b=bFvE67NLKpbK/VgpT5nFZmVkrBmNdmzujSbkBZbSqAAYmiYfnFTRjpVEREXf2ncjX0
         KGPgaehlOzcjSxi08ljJ+dbTjeQ+8oQBKaJ0AbrnBebhmb8lXCU+4/yTWuMEPjf2igk6
         827mnQER99xwyw7rmUvu62n1O41O5AozhOjKcDrGm2Ed1t7Nzb4FW96tEiL48Jb2FcYu
         HZAKB1f10ZWU/ch4w/NF6RkjqVdMqoYmwYEL4LOrWwwqRM8XaYCzhEz/z+QZSrokDxHF
         3fvUujDovvEbDZNY7/mBMSWeUsRYlTPRhcDHhGTitP8ZIat3YIHVPkznJZlEIDjjklWf
         xocw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777996654; x=1778601454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        b=SRLB5fuK+rlRbRhR19pBwry7cLZbvtRVEXUjGHjYwtc7Am201qdkI/9ScVbPpVQdvn
         o2+lMM+mNjjwpz3ySgVFsMjc05G/Bf52ulrCsBdX7D1k+oOdBGuX+Blizi0Db0U0DQZl
         gTtzzuxGExcSNZrIP+LJ2Fy65AuAcfV4gP3yHMpJbf3+WcmoeJqfp/YykIkfmeW/Wmog
         axaqM/d0gMoaPtVMeQtHkwwIP31E8UzAem7dL8aR/VWks1SJMK1r5/UMEOZGfd7wFjgH
         sQRJNkzol8SOmXs5P68i43fKcXV8qkp6/l/nsK5WGFQAENusU/Bf/XPf15vZX5LuAXTU
         yTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996654; x=1778601454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        b=AEKDb2g13zZQEIchZ6ghG19oCjruF6Y8cQ9DZcC6CCNpFY9FrcYjaNn9pkBveTR0lD
         YDHEmvILQHisuMZELEv0EllY/FhXSR02UIx6/GkNyPEwudjLqZdnXuD1HrEajkdDzOXs
         vdxDnnWfSxE6ZTgCS4H3HhQyvK6mOoCCbFzo7BB4gCtxYzHj65W2hVa9n4Hk0RMdPHfm
         pQp3MEWtzPwfM4m/j4/hfV0DARxkDNV2mB42IXL33dsfd3OATEjj7COWjFe+kM9Dqn6z
         GU6jCGfJ7z2n1z4NMYhazli9zPOhKXIWjgtPSG0cdwu/LYW7FVmUJf3PJKgnxdlZpUed
         RAlw==
X-Forwarded-Encrypted: i=1; AFNElJ8Jym771eI43kXxrwD8ZXn3vE2r4IApKZf3GAlXtYJoBTJcjcXbGh72tY6u4oxDy34vCjGMSndCF9QG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyik6KAbRzwyjYeo+8ZurjEyR8fxIlWqpTc30iW/8P+CzynGWvk
	0HDwXSnwsiT+bNh2hzhS90YEIs9waIsenjhdw8y6owCbsBMwl0LG+78A1ecX8xX741Lz1WyJFNN
	uYMZHXu9dLskNpNKGA3PrVNYirVccLDoiHjz0wQpo
X-Gm-Gg: AeBDietKaONHIUiI5fcAuibUnVLLQPpmAODdZqT6Hh5SGcbdhDdDaF1v2nHAOM3/8lZ
	mtkJurPj5CntLtChAmUFbjkWho3WyaYcBqY7WtWswxFEptVkxN1NS+Vwadt3D6lomVR9q5oCeEr
	luRowApa1RpakUO1Byjitbwg+JonsdsQtdbaiJCbfGG2lzZBXQ1vK+TX8zRlOWP1sYupzr5Vjdq
	lHdkFaBatiMCuyTM+gZzk31jtupEVpszXgMnq+06XUMrRqg92+TCE82OrGfvHHBXcWLj/+Bef5/
	qq1cAM2a5BEdiLRfYoMMGmP70w5FfQ==
X-Received: by 2002:a05:7022:b8c:b0:128:d34a:320f with SMTP id
 a92af1059eb24-130b173badamr2261604c88.12.1777996653500; Tue, 05 May 2026
 08:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
 <20260501164314.GA1381708@nvidia.com> <afkjkBq8B-4KjhS_@google.com> <afoR1izCEe9y0MZA@nvidia.com>
In-Reply-To: <afoR1izCEe9y0MZA@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 08:57:06 -0700
X-Gm-Features: AVHnY4JrW8dKYzLI7vKq9aNciL3ihCmWQQqvYeVf-qNxqF1RpyWt82ID73cuiLw
Message-ID: <CALzav=d7a-55mg01MEfaonsU-+4QxbRE3QXpZLskteF28tdaUg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A0DB54D0CE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20025-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]

On Tue, May 5, 2026 at 8:50=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 10:54:08PM +0000, David Matlack wrote:
> > > The PF support flow requires a bunch more complicated stuff.
> >
> > Do you think it's worth supporting PFs? If anyone with a CX NIC can
> > enable SR-IOV and run selftests on a VF then we can keep the driver
> > somewhat simpler.
>
> It turns out my test system cannot enable SR-IOV due to iommu_group
> problems so I rather prefer to have this :) I had to hack a kernel up
> to do the initial testing and it was very annoying.

Ok sounds good.

