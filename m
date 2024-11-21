Return-Path: <linux-rdma+bounces-6052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F389D50E7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F834B240E7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6C1AA1DB;
	Thu, 21 Nov 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VrZr9KeO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057A197A87
	for <linux-rdma@vger.kernel.org>; Thu, 21 Nov 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207635; cv=none; b=MrB6fJsxDAWf57A+947Qr/6Gb3VHfDx5zeNG0OJVSsWMqlhMHCb4XTe7+8rimtmMspgryDVPeP+LoPiJ/eqYg0zCOjitUsnDZ4NFr9kyiTN6KhPS/dHdWWZSaNLrM2fv0joh/0ETtai9nyOifFdZD0dNZawJOYdZ77VvoiVTxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207635; c=relaxed/simple;
	bh=FSh0bBGhrrOK1CDRhKYaX1tSXVKd4tobZNfOnwPsJoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuMckzUTvce69f8oyZJSOilZciZnTmw+0aF+rb06vMCNQVlINQNdmbHKTh6zfDtqe9H8DuLMs6PI7OQ64a3UO8xSF5OuQ+tzri3XqY1rpz25+M9ENaZ6t575zBZaeN78NQAStEsX6WMBU+2C/yIvMqLydbmiTDTU+/XWZZmUua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VrZr9KeO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7245f6ee486so65312b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Nov 2024 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1732207632; x=1732812432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSh0bBGhrrOK1CDRhKYaX1tSXVKd4tobZNfOnwPsJoU=;
        b=VrZr9KeOIDxwQ9W/Qn2wi+7GBwWOo4ITII91IWLS2T5qe52f1NKRo49PYsEEXDxNXT
         St7TKElWxxRGmDWpISzhVlUfd5wf7lA8FFOJuF4L9W+o3wEnl+gk2A3PerZxG3oQ10YI
         qqLLUk56lju7Oc3RZdz8oujd1H5nw44pRtVpE/4Qkr+xNagC24aTl369SvcufkQCeJWl
         U62TKPc7X194IDrSa32zJAnqt7WO4kL4qBZfW67fvPRoTswcxcMHBLdUR+lvx2gbK1gP
         cqO9YSp+FJrbL/Dlu5EZ0lcS6MqtkvTd9km2ryQ9rez5WTii/uGtOBsKmjFJlqtESsqS
         z5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732207632; x=1732812432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSh0bBGhrrOK1CDRhKYaX1tSXVKd4tobZNfOnwPsJoU=;
        b=Urg7Gvt+Y8jFn7MsTMK8wJR1amoZQsr39ZOjkxJUmihmvNreecaTwYP7R+74zMHLm6
         mHUkbAF19CX0FLxfdF28XzifpZKIopFCHe4800XW0vNATmMJyJkiL/RZmJNfkYpRNP8h
         fTDAIVV0PHOAnO8DNiFIj6HQFwLIcOQ49MwEx1bCYbt7HXx1eekGR7YxH3Nc90OD03++
         o2udkZXaEpBZr2vsNEVb+wfP6jZCnTB74DTPf2nbZsVh+S878d5miLRYfzq303oFAZmt
         7jy7aT7kwYZxDVLKHu4PbluMaVBAOOru6aBcHZs0F22xgwHpx5jcCWMSe7gj5u34d6lS
         RFEA==
X-Forwarded-Encrypted: i=1; AJvYcCWcK1lE5M7XLAZj6AyxZJvSqd8t/0RJwL6RbYFcTAs5zMHMET2XT9wacTooza+VVpcYV/4RG40j0d7+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8yh0lOmmEehZDUaWGBCqkNREkvvCOOEOo80TOx/24awouJ7z
	m4Jg3wDipoc1uxTOqmJ3+0WL4UxeHLuOwAAMluRLL3vN7kbXVLK7+kJrCgz6sWB7fdVPy/P8xRs
	sNf31C8c0GiRYZaqGxQulG8T/fuaShvqxkETVcg==
X-Gm-Gg: ASbGnctaviDiIUp+hsfXLY/p5xic+zLP1JbEws2RXKYJLuR+lFkRvmTAmDSt7xD8zp9
	77ii5qXy4aPqRHmY+kJcdJOz/TpNDFg==
X-Google-Smtp-Source: AGHT+IEk/9vx8VKZ9elTLl71i89UlCMkVZZvP2AUDPYQQ0TAnCaGg+99yW+OV5aFAZYoUZidMionD46GKKhdQsyomcI=
X-Received: by 2002:a17:903:41c4:b0:212:54c0:b523 with SMTP id
 d9443c01a7336-2126a3192cemr40875155ad.2.1732207631026; Thu, 21 Nov 2024
 08:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119042448.2473694-1-csander@purestorage.com> <59c96191-3203-4338-9754-ac7c5ee35e78@redhat.com>
In-Reply-To: <59c96191-3203-4338-9754-ac7c5ee35e78@redhat.com>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 21 Nov 2024 08:47:00 -0800
Message-ID: <CADUfDZpL6ap2gN1KeaxpTA53FPbx+EoLSWm+N-Q27gFd444VxQ@mail.gmail.com>
Subject: Re: [PATCH] mlx5/core: remove mlx5_core_cq.tasklet_ctx.priv field
To: Paolo Abeni <pabeni@redhat.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 11/19/24 05:24, Caleb Sander Mateos wrote:
> > The priv field in mlx5_core_cq's tasklet_ctx struct points to the
> > mlx5_eq_tasklet tasklet_ctx field of the CQ's mlx5_eq_comp. mlx5_core_c=
q
> > already stores a pointer to the EQ. Use this eq pointer to get a pointe=
r
> > to the tasklet_ctx with no additional pointer dereferences and no void =
*
> > casts. Remove the now unused priv field.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>
> [Under the assumption Tariq is still handling the mlx5 tree, and patches
> from 3rd party contributors are supposed to land directly into the
> net/net-next tree]
>
> @Caleb: please include the target tree ('net-next') into the subj
> prefix. More importantly:

Sorry, I realized I forgot to add a subject prefix after I had sent
out the patch. net-next is indeed what I intended.

>
> ## Form letter - net-next-closed
>
> The merge window for v6.13 has begun and net-next is closed for new
> drivers, features, code refactoring and optimizations. We are currently
> accepting bug fixes only.
>
> Please repost when net-next reopens after Dec 2nd.
>
> RFC patches sent for review only are welcome at any time.
>
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle

Sure, there's no rush to get this in, it's just a small cleanup. I
will resend the patch when the branch opens again. Appreciate the
development cycle reference.

Thanks,
Caleb

