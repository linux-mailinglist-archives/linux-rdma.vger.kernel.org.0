Return-Path: <linux-rdma+bounces-11053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E9AD03F8
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jun 2025 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0BF3AB7D9
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jun 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D477261E;
	Fri,  6 Jun 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EroYOhtL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7449659
	for <linux-rdma@vger.kernel.org>; Fri,  6 Jun 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219943; cv=none; b=gbihscw+vA8icGU67NvIlAS6cHOCs56h5zDgDTsYRnI67nMBeSw4x2qjpGRcsuzAB9y0ebdmGvHCaAYDq4QBJMO4MuXTCUzoAl36pE1d7js/ykVw19QmR7Uwq9Ef4iKV1iYz6Q9pb3ryAaWBSdWJVUwVFcWYquyuM394l02JOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219943; c=relaxed/simple;
	bh=3qDXXSo9V97Ln9bq/SaJnvqAfowOQYvP+bIcxRBosxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOhuzlwbBfoaF6UhSUDuqNrvmz91Febg1ut2xmooehX2oYKF13j8V3cpE6dHOnctS2w8p0svQRvW4lla0JRmBoEeTliZXaLw58GzZpzJDdPSxe6e44ExmR+UIXqE4M4vhlgN25Lagty4ps1TxO+Adq5817AcH1luMYw6hytVAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EroYOhtL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749219941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbe1K1n6EnoNpJDeM1+H0VVygYl65ltcXFDiurkXp0I=;
	b=EroYOhtLQ581wz0nBQY+GBav5DYHmif7L88xoTL99V1qs7fJPZgedNUQrseMWZOkXslVaM
	mDp3/kiRG+zZKrTO4A3xZQo0riVfHxan0k3RTVuPDzJ+9yDUEFVFA2Poh4Z35aV1Wuplob
	eV78Jzdf7Kw7q2nOaL0qGinGTjvdxL0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-27XExsfoM8O3K6ayRt8r4A-1; Fri, 06 Jun 2025 10:25:39 -0400
X-MC-Unique: 27XExsfoM8O3K6ayRt8r4A-1
X-Mimecast-MFC-AGG-ID: 27XExsfoM8O3K6ayRt8r4A_1749219938
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32a6e117b55so14480241fa.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Jun 2025 07:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219938; x=1749824738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbe1K1n6EnoNpJDeM1+H0VVygYl65ltcXFDiurkXp0I=;
        b=xD/reyh5iCDzV8kkkH1DIPfwFOEVWbrgz0SaauWDpBlY8PcN+mBKXFoP5HgH1mg5uo
         7SkK6JpRHa7JzlNrNeEEd0v8j7IcLMUfoUuv7aLT74wenvv2EEwsvOp0+HmVxamTrwap
         Ljo2323/Dm5D4+ZbSNywrNylnZvKja3Yka07g7ftW/iERMoO1laecZEdGSNvALRbVLr4
         L1xZET1rrmfmgxH1dSec0+2EgqVZaO7sb7wWQNZLyypUvM1jzvJwKfxiiRD2HWulFomw
         BNcoToJ3uY8cec7lkwVGYQqawAjQps6uDa+GV7FYXchwJwnmADORP2TgbVwsqWim+50Z
         8ZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdsODr2G+Z+BW+nZ0JQ9fUmnE2xohj0OMHohzIIeAMK/KH9RNcxrRkAe1v1vJWBg8Fjf6E++YPZCiJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxhwn9m55gM2LU7QHMUm0zHsAMzoXU/8M/dTidd4UvgD8J8PZ0
	Z4PPjaJywN/bth4ARezNZqflI8k840DkpqCm3yHFtxxn757cG/X3ml2JqUSWM6t0dZ3n3ObEVzs
	pHRRmdPbVQ0jCI13jMcIHgf3F513SP8q+XSnkcHw/ZOlKlYeH0H6XBN6JmQ6QcKFaN3yfll2wrW
	lQugMZFklrzKGrinfgN4X8w9ku0kXmjw8pZ1mLcw==
X-Gm-Gg: ASbGncvUAUSmeHpyGiDtFH5ztc5wzVko/1T+3Opoi8HOYXw+JbztpTmfQzoFlgPyvWm
	PsSSXdSxCc3hMELU00tEJmSMPtgfDJFJeS34w0iFbd5oKpUs9gU3t9McUMJ8MCEm5KeKx5Q==
X-Received: by 2002:a05:651c:a0a:b0:32a:ec98:e144 with SMTP id 38308e7fff4ca-32aec98e7b9mr2665391fa.15.1749219938106;
        Fri, 06 Jun 2025 07:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXglcxl80BE482xq4dx91qTebsclNfPlMg1sw20ymT3/ZEh0z8jxknKBzXzbqnEY78ZQMjNrsOPiXqzhYfTLw=
X-Received: by 2002:a05:651c:a0a:b0:32a:ec98:e144 with SMTP id
 38308e7fff4ca-32aec98e7b9mr2665271fa.15.1749219937714; Fri, 06 Jun 2025
 07:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local> <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
In-Reply-To: <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 6 Jun 2025 22:25:25 +0800
X-Gm-Features: AX0GCFuL4XNUJVJ0lfr1A30P6N_O92q6LMT8TriVlRQc68jUCEDZAsCtx8zBrpc
Message-ID: <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
Subject: Re: blktests failures with v6.15 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Tomas Bzatek <tbzatek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 3:55=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> To+: Yi,
>
> On Jun 05, 2025 / 15:02, Daniel Wagner wrote:
> > Hi,
>
> Hi Daniel, thank you for the fix actions!
>
> >
> > On Thu, May 29, 2025 at 08:46:35AM +0000, Shinichiro Kawasaki wrote:
> > > #1: nvme/023
> > >
> > >     When libnvme has version 1.13 or later and built with liburing, n=
vme-cli
> > >     command "nvme smart-log" command fails for namespace block device=
s. This
> > >     makes the test case nvme/032 fail [2]. Fix in libnvme is expected=
.
> > >
> > >     [2]
> > >     https://lore.kernel.org/linux-nvme/32c3e9ef-ab3c-40b5-989a-7aa323=
f5d611@flourine.local/T/#m6519ce3e641e7011231d955d9002d1078510e3ee
> >
> > Should be fixed now. If you want, I can do another release soon, so the
> > fix get packaged up by the distros.
>
> As of today, CKI project keeps on reporting the failure:
>
>   https://datawarehouse.cki-project.org/kcidb/tests/redhat:1851238698-aar=
ch64-kernel_upt_7
>
> Yi, do you think the new libnvme release will help to silence the failure

I've created one CKI issue to track the nvme/023 failure, so the
failure will be waived in the future test.

> reports? I'm guessing the release will help RedHat to pick up and apply t=
o CKI

Yes, if we have the new release for libnvme, our Fedora libnvme
maintainer can build the new one for Fedora. I also created the Fedora
issue to track it on libnvme side.

https://bugzilla.redhat.com/show_bug.cgi?id=3D2370805

> blktests runs.
>


--
Best Regards,
  Yi Zhang


