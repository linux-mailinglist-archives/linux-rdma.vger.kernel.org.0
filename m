Return-Path: <linux-rdma+bounces-13465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F049B82A39
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 04:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1314A1BC42B9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 02:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEB223708;
	Thu, 18 Sep 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwStEsb8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DA17E0
	for <linux-rdma@vger.kernel.org>; Thu, 18 Sep 2025 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162100; cv=none; b=YVRGVemW2dDf7iQmz6uKvnPNS7ywkeLps+ucWxMX7hCzG61tc2U738Wpe2BzRFc4IEn6x9mfg5hGszte5iwxnN7+m8oOQCTgkT1eWZDwpGtMa4zAsUDvIxZDDRI/liOLKVJOxwkEgHjOt49MUe5lKauMCYxqj3XnIV3hKVdhZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162100; c=relaxed/simple;
	bh=ebWucFsXDWMzdyZC6AqBlwW00MZe0MYweojXX8TIBP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPqER7mhvnZxLqQGrBWa9PnsF99WvA0M6DUOzNuw5h3vwtRCcCaUHabdn2ALfzCjChXf91FMTK9IsbyRlV2BnL8W+s7Utd9JQJ91QHGY/cKInaozGGEZf/WUutS/3d87uVwP/E6A7H9822DNU+77nOGnjfueS3HDnXBMXv4hN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwStEsb8; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43b40cc73f3so307672b6e.0
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758162098; x=1758766898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2TqJf5AbRGlHKv2lbhFK/JOV0pCd+aUBT6OgPSYYCY=;
        b=cwStEsb8UmY/CuXg0YDYhy4nRw4jFXIjVAgSBbkbP4JYEqX/DqLvG08+c/I+1zVJH9
         QPuJQpZr0E4zLWfPRoj44Unsuxdd9LOJ9xNOXHyrdjLmXWkhXY1Z+eqlp7n4fmQbnUYa
         wfsNoFcaamvpQFmsfO3V8h8ui6t75fB0L9JcM/RvLEmf2CSVu3vAD7FA1d7RcKxBcDSc
         N+ZO3tDVxZZ5NweLwdWPwAtYkuL2ukUNQ8H11Uqkaj+XzN/oCqkeHVMkL9pFSHRPuKMQ
         qdUeVDFZi1DxBv8W6VdC/sXdlJOjLqyFM3o/OjT/d/e2tXIntQhbpqMQWtaqkQ+/p3Px
         pNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758162098; x=1758766898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2TqJf5AbRGlHKv2lbhFK/JOV0pCd+aUBT6OgPSYYCY=;
        b=rj4qoKdTXzB6wxx8TKZpPMxrgfb4+TeYJuBk2WBDqRIbI50pJWzMrTc8acW+1gZKnS
         0qZs8ZAodGw5BjrSv/rVIl3LKeifPmECRexiJT5iWrQ1Wi7BjRDziLeA5oPGUIjCRZK+
         pB4IAEP1kozmNOdeQ59ofzijXpwQbHfHvEvYCX9ZzxNINcCDqeeApHvAXd6ryEMdBrf/
         8sS2J9OxPOPt7BHkBRYch8JXDQuOZEumJPgtdLel78tkdNt/5qWaRmTdVcU4gLw8RW8K
         TO0AIxR7Bx3CZYfLDWmoQSxbQO7vuKwDWsSHW61RV6BM3SfuoVWSCT1Mg8l89te4zRRm
         eRJA==
X-Forwarded-Encrypted: i=1; AJvYcCWFQa40TWPzKLJHYJ0tq6bJDtBe9koi61hNc+lTiPRsWqMpatSlFv6HdgVbmoRHp5HkInQef5sGEGJ1@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8cGhkl9SvSIwC8HlRX/6Nw4BCbfrXYJeG5UulIv6zS75kMiT
	2d4RIAK86L7rSKLn96bF9PsO9HYtWxO3n6yyZnCdWi+lSjIlckBM+4EKtoN6IECp9JBeRYSAo2U
	GRQ+6wAzgYEeKgZtxOXyjkiNjua/ce8A=
X-Gm-Gg: ASbGncuoGdOkNxLkodirGLMgqFNjgmzV/VrtDw3B5KF1K2JMMSmZVd81khfhmITYGJY
	7wVNrzv7EKWDSXZnNXuP+OtEELvs/r59elHjWKC9QAYxRijVj9wrD8RWAl2qSijl+W0Q9JU47aA
	4MXRXOcd+0tSPrm7z8BMXFt/KcnP/tMin1I7XTbVrd8aGzAjcdXqx7/R3SSHuiWKW8uLoBO63xq
	rEPp7Fp6NYezMdw+z9XhJJFzNLIXrbGsHaP
X-Google-Smtp-Source: AGHT+IFiyC+IjhAbMWMow6p7uPNgXnstsaivtCdHNqfRscvhsSN/dyt0pD/3gEu1tlnG4bR/2rk2mlKMQTKp049LQN0=
X-Received: by 2002:a05:6808:17a6:b0:43d:1e76:2986 with SMTP id
 5614622812f47-43d5b47b3dfmr920609b6e.12.1758162098180; Wed, 17 Sep 2025
 19:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917100657.1535424-1-hanguidong02@gmail.com> <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>
In-Reply-To: <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Thu, 18 Sep 2025 10:21:30 +0800
X-Gm-Features: AS18NWDqJzoh_yFV7HHAEDZyUJiKc_hQLSWoj6UQ7QcKaPVU1R5EfBncWXG4_6E
Message-ID: <CALbr=LZFZP3ioRmRx1T4Xm=LpPXRsDhkNMxM9dYrfE5nOuknNg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org, rpearsonhpe@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:31=E2=80=AFAM yanjun.zhu <yanjun.zhu@linux.dev> w=
rote:
>
> On 9/17/25 3:06 AM, Gui-Dong Han wrote:
> > When do_task() exhausts its RXE_MAX_ITERATIONS budget, it unconditional=
ly
>
>  From the source code, it will check ret value, then set it to
> TASK_STATE_IDLE, not unconditionally.

Hi Yanjun,

Thanks for your review. Let me clarify a few points.

You are correct that the code checks the ret value. The if (!ret)
branch specifically handles the case where the RXE_MAX_ITERATIONS
limit is reached while work still remains. My use of "unconditionally"
refers to the action inside this branch, which sets the state to
TASK_STATE_IDLE without a secondary check on task->state. The original
tasklet implementation effectively checked both conditions in this
scenario.

>
> > sets the task state to TASK_STATE_IDLE to reschedule. This overwrites
> > the TASK_STATE_DRAINING state that may have been concurrently set by
> > rxe_cleanup_task() or rxe_disable_task().
>
>  From the source code, there is a spin lock to protect the state. It
> will not make race condition.

While a spinlock protects state changes, rxe_cleanup_task() and
rxe_disable_task() do not hold it for its entire duration. It acquires
the lock to set TASK_STATE_DRAINING, but then releases it to wait in
the while (!is_done(task)) loop. The race window exists when do_task()
acquires the lock during this wait period, allowing it to overwrite
the TASK_STATE_DRAINING state.

>
> >
> > This race condition breaks the cleanup and disable logic, which expects
> > the task to stop processing new work. The cleanup code may proceed whil=
e
> > do_task() reschedules itself, leading to a potential use-after-free.
> >
>
> Can you post the call trace when this problem occurred?

This issue was identified through code inspection and a static
analysis tool we are developing to detect TOCTOU bugs in the kernel,
so I do not have a runtime call trace. The bug is confirmed by
inspecting the Fixes commit (9b4b7c1f9f54), which lost the special
handling for the draining case during the migration from tasklets to
workqueues.

Regards,
Han

