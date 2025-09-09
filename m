Return-Path: <linux-rdma+bounces-13209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E719B4FFFB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0121C60749
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A3226D1D;
	Tue,  9 Sep 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="oXXsW2cB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85846352061
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429315; cv=none; b=O3FMK+QUTV7IOZNJq7SY8BRoM+mlmxtksmiAykuBSIkQZ5HSf1XQOeiIVvy73O2NahAR/OGkztnr1vDgMNo+0G0PN3feysX2eaPhaeRS862JgpzONGmSrMCeRuXaOjLgz6ZoTNw6+ptCIa7LBIDovsRYlqDbjEFT8dso988MgtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429315; c=relaxed/simple;
	bh=IrCEEvQ6quZd6vGY+hKaSFP8/aFjFmPuYsUXXSdfZ/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbEKUHXBLInUuT98o6CdwV2A3gSvIFgFIkZZwVPgnO1FSqRjOac1rsSJSBYclT/pTzs9za365iwM8dbSWbIfW14Fr5ipplaPgrYftzCjtN/LAQbP/oTte8vCVbVvED42VbR9hIaRM7vav+RgHE3tY6i6nVjoCqMjj0aOJgTD0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=oXXsW2cB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-628caee5ba2so4027647a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1757429311; x=1758034111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riVtaRT7j8OUAE/oqMgy7zD7jURxy+XGa9bDP6fI0Tg=;
        b=oXXsW2cBgOjJTgeBUA3sZDKJZdHC5+LLg5GiNLXVuK60w8LctFTS0JEcAQyYYRhIsh
         3iPX1bNEy7b0e3rWy5l9rnNwJmgVvAY7U1w8u3KopqHwI6vvkdj0uJOp1bocUkfpW1uI
         rrAnNjr6Tdjs9o3cODByIEmxld5SjSJ7XsJnk6I4TM4ZCVcgjksm/q0vuEnZFS3jjx+A
         r/KWnK57JWBnWtaU8iD7tWbNPJzq6N1ZGiBBpfXJCSH2JfnxEvDjvziuTJBsX//kQ4wm
         hNtvZReEKIeniM0exXWArbExqRRR3hNUiqL+quA/aP4psOu0Uo/pE1zfLQYW6Cx7eXnf
         fYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429311; x=1758034111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riVtaRT7j8OUAE/oqMgy7zD7jURxy+XGa9bDP6fI0Tg=;
        b=ZQBo2WStjyedDvBFpAy/unmK4ggRp73i/yYOciPOCGiNIvwXWE5mlZsh2kcT3FoUNi
         tcPxZFgpAVyyGMrFlJq0e6ahuIP4cCqvN6sQNkwQbol/mjWmEKHgFz4/Zx4SKDQ50i9F
         57eciACJmtNHceSc/Uoc5EPV+45I5LieOfYYjZ4yyZhDlHZI16LUtKcM+sLcZk3lvoxr
         jLTm4hUelWORpDDu366Qa20gh7dkCGq77OtiOyFLSIaSF1okCemPBBj+AGLszXMAACBM
         BggS17PYCVwWODUia+pQDG3mw17MLkyy7eg0QuuroB2tsozMUe+Ex9DkWU9COY7ZMcIO
         Xt3g==
X-Forwarded-Encrypted: i=1; AJvYcCVnNJPRyw0gAfPs4loFHgE/QRju/clL5NI+Q1Q293lNJy4bXalEo9xnCxr/C2Y7xT82pMldMDEAJA1Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tNK3QdMdkldCYTbwPsGl0i5noRIzhNJA9sxeolLdb03q8teu
	fxmTsdfftNic6PPDH4ptXwgAa992hIwWy9F57ixhrz17K50CpbdkRjjv6FwjEUF8/Eim2t/WjVf
	+9+ScrCaeCO1sORqZqZl1SinlbF6rwn1nBkJ6dr3aiTGU4kPwHZiGpxaN/g==
X-Gm-Gg: ASbGncv5Zse1xQYyfAxAreXtG2nzNk0ewE19tL4T6p9XaAECnnCyFDss7N+5EkFqZf0
	mxemtj4lIUNnqVIirnzBNnbh/UQGbg1tA7UP5rU2Nn2RbyGiuFRXeiBNSyJdYjoXlG8gSz32Ury
	TUg9a9GxinSKaOCcqLSaqJRvERSf29oM2KBrGC0xPIZDRiNYsK+Pg6ucZUF5Y8XmprK13SUIGHL
	+7a7pcmukeuWvSp
X-Google-Smtp-Source: AGHT+IHmy4DiiZdCV07ewiDp5l0AAhtM6iSoXVlHB4cqIHw0PJz6J4GlBBIkNRNqG6GZflgKWGQY+CG/OTYDOfBqZr4=
X-Received: by 2002:a05:6402:688:b0:626:15e3:fa with SMTP id
 4fb4d7f45d1cf-62615e3029dmr7305027a12.13.1757429310762; Tue, 09 Sep 2025
 07:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822081941.989520-1-philipp.reisner@linbit.com> <20250908142457.GA341237@unreal>
In-Reply-To: <20250908142457.GA341237@unreal>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 9 Sep 2025 16:48:19 +0200
X-Gm-Features: Ac12FXwmbry1Lsm2nYhF0TgAF0dI5C-wuaikLjA0cYwT_2X5O2PH5N0rOEeO8dQ
Message-ID: <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 4:25=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > Allow the comp_handler callback implementation to call ib_poll_cq().
> > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
>
> Can you please be more specific about the deadlock?
> Please write call stack to describe it.
>
Instead of a call stack, I write it from top to bottom:

The line numbers in the .c files are valid for Linux-6.16:

1  rxe_cq_post()                      [rxe_cq.c:85]
2   spin_lock_irqsave()               [rxe_cq.c:93]
3   cq->ibcq.comp_handler()           [rxe_cq.c:116]
4    some_comp_handler()
5     ib_poll_cq()
6      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
7       rxe_poll_cq()                 [rxe_verbs.c:1165]
8        spin_lock_irqsave()          [rxe_verbs.c:1172]

In line 8 of this call graph, it deadlocks because the spinlock
was already acquired in line 2 of the call graph.

This patch changes that call graph to:
(Line numbers now valid with the patch in discussion applied)

1  rxe_cq_post()                      [rxe_cq.c:85]
2   spin_lock_irqsave()               [rxe_cq.c:93]
3   spin_unlock_irqrestore()          [rxe_cq.c:120]
4   cq->ibcq.comp_handler()           [rxe_cq.c:123]
5    some_comp_handler()
6     ib_poll_cq()
7      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
8       rxe_poll_cq()                 [rxe_verbs.c:1165]
9        spin_lock_irqsave()          [rxe_verbs.c:1172]

With the patch, there is no deadlock in line 9 of the call graph,
as the spinlock was released in line 3.

I hope that helps.

[...]

