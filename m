Return-Path: <linux-rdma+bounces-13637-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD891B9D839
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 08:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15F6326221
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E92DF71D;
	Thu, 25 Sep 2025 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="jwi24nN7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239C2367A8
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780174; cv=none; b=olYJ7JowBCt2HXd25AqIx/tJ9w00pjMfXJ41JiY017N5gX4hZ+gZE8yjdPFEd243zCdH2fAAAv3MWNzpvvcRXnstBeHKNvWh9y1EPgBsSsIJmgl+bBGWqntlRqQMZ6guJlGGiNnxVyh2Dvj42gm6ljEZpSjSZQaL2BWEmPZqMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780174; c=relaxed/simple;
	bh=DUla5PJziyCFNOF5ZSAr69aWrr1mHBZqCAxD1G43xqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5PMt4uZZqBL5TjglXnG2j+u4QyJ7zx+Ad+KeJQ5uP+wH+ptnX2CbKmaEEBR2TbHAAsmE2CqzvTw0mHfLnjB8WIgl++nnASbQ/Oa2ZZP6NhlmFBqgwX+x+dhc1J/rRdfhzQD2h0ggHIgef5vhPg0Uqli9RgRCKWQM7idz8HJfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=jwi24nN7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc686dc41so446605a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1758780170; x=1759384970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUla5PJziyCFNOF5ZSAr69aWrr1mHBZqCAxD1G43xqQ=;
        b=jwi24nN7AQY6ScwC+IqSg/3sjatoQEhWaP4Lg/yXg/5RYSsqTu9Ln7/1INqB2e/qMk
         slCB4ILbZPf66tAdhzF+pYzwCCaAZscUl2vjSUA+s1JXINOa2sCy+jvHJVIqjT1kMbgl
         3tz6k1Buhr4o0UulVfkjKJm5/e4vmwup19ed/Yj/5JTkaHqedp7+e2tiVNJHDneJ18Qb
         K+66CBUIxb7ArPYw4k2GkYrJQVjOcCJ8UEsVVFToRnRd4kEMl4OB6lalIhKSXQ0wr/Oq
         qodzXIED1kpSK1n/VKDBGoBHJOFTpSz7UEpLbzXizSGGqXo7EaObhxDWxZ1O4jl+OuFL
         e+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780170; x=1759384970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUla5PJziyCFNOF5ZSAr69aWrr1mHBZqCAxD1G43xqQ=;
        b=R7fzf8cylwqV2OvWe7fsWTyV2HlfdAD5ef1Fy+8LhDm2VPqZ5qe+bJYTmDSmlw1iee
         fWLZD4hPvhIAiGmi15aFtAL9+tS+TBGU+ch5lLn8nYPYfsh9M4OktfskiuFDNfdItjy6
         rb//+sP4y/gjSmKEhKmofZ8mrapgg9BozYSidr333WF2XYU31OMuut2+FBWS1J/OH2WA
         f4lx9wfP1nLBBlZfgyOXqBXa+J/GHDrRX+ZU7lK0DdvDxvN3A3yl89h9gW//GDsb74bN
         8T33q0vsJr5D1EXdnubQN4CsHym4ZJ6zho1v0dCnu6Nsvf8603zTOjr0GE3bms9bcw8C
         mN1g==
X-Forwarded-Encrypted: i=1; AJvYcCVI3upDj3HmCBm/TS/9pVbwtyi7kWUttuNHVPy8+HWW5+UqpmwOrrjRQw8lHlaMY2bpLLPTPyt5eRMR@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4rwU+OmSaeaCOk9NYnUclCSF1xn3SVX1YXQD4AHTBBiKcmnI
	Pe4D2/Qa7jAxFAW8PmhezHCOCnfM6pO8qdyJrURgcZuTPQ3nLcl9b6MMWkOxMZ7sAsxXkmej5ew
	2TfhjMf4RWVGy5EP/VWh5e1rQdEP2FN+KI++VqR5YTy85qs29YyVjxkK+KUBt
X-Gm-Gg: ASbGncv0R11d606uXTm43+Cd46VT6VGdkeh25oLutPA3U3yS/lT4B8M5E1bya8XsbEx
	nVdWAF4DKK0bEdWJp57KsqYGHFWK4wfYrEDrsUSXeKar8rA7sYElkNtJnn+2hI+2A2yVtSoH0+t
	ICMzzwTyYPsLSuBMOuINfvOk+PTm8zcGDSQj582nqNkFWfzLg3OqJDM2y/7QLrMj6jGPrJpdKKO
	USC8A==
X-Google-Smtp-Source: AGHT+IHuLUhpfZoeQ17XO1nU7j5y2qkgCPBRp5vKsEW0xkb9bgwyW8Z3xNh2ER4vvyV0SOz5/UW/SBD9YiHnzIXwPDM=
X-Received: by 2002:a05:6402:180d:b0:62f:9cfb:7d34 with SMTP id
 4fb4d7f45d1cf-6349fa97d25mr1323894a12.38.1758780170150; Wed, 24 Sep 2025
 23:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822081941.989520-1-philipp.reisner@linbit.com> <20250924132135.GA2653699@nvidia.com>
In-Reply-To: <20250924132135.GA2653699@nvidia.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Thu, 25 Sep 2025 08:02:38 +0200
X-Gm-Features: AS18NWCDO0QwVnXdw28DFlwnSnP-ZYUNKnvXKO4kJg0nbIiw6z-QKTuUt9keuVY
Message-ID: <CADGDV=XkfuNhATA4GkQm1VBVaG+JkFYmXojaVSnGo=rco7bUyQ@mail.gmail.com>
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Wed, Sep 24, 2025 at 3:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > Allow the comp_handler callback implementation to call ib_poll_cq().
> > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> >
> > The Mellanox and Intel drivers allow a comp_handler callback
> > implementation to call ib_poll_cq().
> >
> > Avoid the deadlock by calling the comp_handler callback without
> > holding cq->cq_lock.
>
> I spent some time looking at this, and I think the basic statement
> above is right. The comp_handler should be able to call poll_cq/etc
>
> rxe holding a lock it used to push a CQE is not correct.
>
> However! The comp_handler is also supposed to be single threaded by
> the driver, I don't think ULPs are prepared to handle concurrent calls
> to comp_handler.
>
> Other HW drivers run their comp_handlers from an EQ which is both
> single threaded and does not exclude poll_cq/etc.
>
> So while removing the cq lock here is correct from the perspective of
> allowing poll_cq, I could not find any locking in rxe that made
> do_complete() be single threaded.
>
> Please send a v2, either explain how the do_complete is single
> threaded in a comment above the comp_handler call, or make it be
> single threaded.
>

Thanks for following up. Sure, I will send a new version of it, it will
be v3, as this is already the discussion on v2.

Best regards,
 Philipp

