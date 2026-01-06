Return-Path: <linux-rdma+bounces-15320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C7CF78BD
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 10:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBE23071BAC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B128CF6F;
	Tue,  6 Jan 2026 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hN1pBZBm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1027B35F
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691667; cv=none; b=m/31PBREA3COXGly+Mo9Ccs1y9AfyyTyBamRx7gCkhOLHWfxn2zxcE4K2e6pLSwprJWy//5lMgfsSB9G7awqyn6TO2YN5VnKX+YLsbvTx8awtKiJI3B3d9O3Ug6DD3T9de1YLpeFDyJJruG5TdztqoHWLsk9ZwJGB+q6HCgQS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691667; c=relaxed/simple;
	bh=dtndWUsgj85PQo16LuZa/tafUe1MirpBxN+gQSL5zCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5j3o1pcIpNDRhylXPZ3wfGzOgOfRcZKaIKeQnAl5IgcVoOgrTSNrcZZVuhuVJfXkkm7xDBv0rj0/hKXfjvuSlaJIdSdQQlmXRJn9R4zIiYxWQjxaCFgBdZwTNM0i8hTGL+GSVIRbxip7KgJrjngt89LejyVH+O/kXLPAQ/9WB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hN1pBZBm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-595819064cdso1218291e87.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jan 2026 01:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767691663; x=1768296463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg1reobfh/4Vy1aOcIyNvW5D6D+SJKCYz8ItnZLsKh4=;
        b=hN1pBZBmhkyjuCh/4RTWzOiPMkCNlSAliMeE06hzUPBP2hA3AvrBPspm+vz+qSTa3Q
         /ujO3EfjCCAotFNpPNw7yeO4WL7ECm+jpLLkssRdTfIdMnjsMtHHNdLGlZnAvt41Dq/7
         keC8v4WAviXFLi4ZRMseD25i8KPwuox2GazPu+iiasBmjrDHEa95wyeXpWh43QGwNY9A
         ptsVhABnuFkVzxaTTfGiv8wa3I26I0IKy2kugxR5uy4MEMY1IgmrK07zPfBQhYsFfZAr
         1RIBCRudcdxr3UW2QpmDEJWQU18NmIKTLXIjV8J66V4OfO0TQO4hXbjclJ2jsBLxo49a
         vuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767691663; x=1768296463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bg1reobfh/4Vy1aOcIyNvW5D6D+SJKCYz8ItnZLsKh4=;
        b=RsKKy/xz/YCZOr1HAVaXiC+oaS86ElFlVgeNTAdAncTHdd7Ih1yU+bhXkUn29w71gM
         Vj81Y3lKsaMObvnWDUMlvFbAoNMV51HIv5ybF3iGTutsVuhveC3chA7V+OUPaTPn1qey
         F4hP2s/qlW8WA00nBmBegfdN70Wd8gnfbMeU0nT5AvhA+WY0gp6mY1dNEkPQvorT3bXj
         eYp2lv8TxsurBidx9pXXTukc1OatOrj4y2CWWLyFeKTCQxx4nNCl/ytM7A6jZkhN4QZR
         wyflHmowQVYU4UjqVZZdBtCczwSzv9mMA3NZV1/K/pzwLVIsdZaeHOZT5tmayT+3o/DZ
         bd+Q==
X-Gm-Message-State: AOJu0YymWcMdtH/0PQ0eDXcoBh8ki39xsNFmhZIjzi9TUnT3pTjD5u3A
	lA7Jv7JcU2V0lFxCZm0L2FgrBAcuXpGYx8XtZAEU6uCB5hFsHmdwSA0kh5VScXGEKkpMTInL3y2
	+QJy+m2FHx0pHWpTM5RG+ifHeT1maUiKiHt4cNl0IbQ==
X-Gm-Gg: AY/fxX7XEE56NesmOWhy6rmE29N0QMQ5X/+ZGJvRuI0kfh3Bgh80SCXuMVxEg4h4TjH
	FbmaZ8jVFdEPKvlAaEvOkD3n6sqFcgbZuCQvuCtLwTutsjCqwniBUB+um0PMuscgnTXB6zJvHIp
	o1KNckuHRWohpCLutUNOqRD1kivkqoK0wVc0VjDkOezTDu1Gxu3ZxEjDSpg/f6bSvUlRPcsPCo4
	KxTEMRbI7h1jv63vhUEnOrgKSvbSUmN9DM8nYFqBtB4lCe/oP3qJeYGWYQwI9dE6TPf4Jo=
X-Google-Smtp-Source: AGHT+IFQU1wkeJVczJ/OYqfklU4Mw+4ooJM6k4S6B353LssPAAQijyprxwUFQmHVjTlhQBpyXZE1q2ircQLMumz2nKg=
X-Received: by 2002:a05:6512:a90:b0:59b:572e:83e8 with SMTP id
 2adb3069b0e04-59b65899838mr739712e87.24.1767691663348; Tue, 06 Jan 2026
 01:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
 <20251208161513.127049-7-haris.iqbal@ionos.com> <aTd4n-mGUSP_kk11@fedora>
In-Reply-To: <aTd4n-mGUSP_kk11@fedora>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 6 Jan 2026 10:27:31 +0100
X-Gm-Features: AQt7F2r2lY4SSjPqROC_ZMX76gCQ9duhliZbhwM3PrlR1ZyDUF7vokXRXS44mi4
Message-ID: <CAJpMwyiCeSXmTojK7nhJtE+dDdTSzFs6Jq9ap6okomVm9SLXEw@mail.gmail.com>
Subject: Re: [PATCH 6/9] RDMA/rtrs-srv: Add check and closure for possible
 zombie paths
To: Honggang LI <honggangli@163.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org, 
	jgg@ziepe.ca, jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 2:17=E2=80=AFAM Honggang LI <honggangli@163.com> wro=
te:
>
> On Mon, Dec 08, 2025 at 05:15:10PM +0100, Md Haris Iqbal wrote:
> > Subject: [PATCH 6/9] RDMA/rtrs-srv: Add check and closure for possible
> >  zombie paths
> > From: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Date: Mon,  8 Dec 2025 17:15:10 +0100
> > X-Mailer: git-send-email 2.43.0
> >
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -911,6 +911,13 @@ static int process_info_req(struct rtrs_srv_con *c=
on,
> >                                     tx_iu->dma_addr,
> >                                     tx_iu->size, DMA_TO_DEVICE);
> >
> > +     /*
> > +      * Now disable zombie connection closing. Since from the logs and=
 code,
> > +      * we know that it can never be in CONNECTED state.
> > +      * See RNBD-3128 comments.
>                ^^^^^^^^^^^^^^^^^
> What is it? How to access it?

It is an internal ticket number. Should have been removed, but we
missed it. Will remove it.
Thanks.

>
> thanks
>

