Return-Path: <linux-rdma+bounces-7899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A692A3E2C1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A07A96A8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A652144C3;
	Thu, 20 Feb 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzgGs4Tm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2C2135C1
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073092; cv=none; b=rZroM/mUab9NGNjoKNk2AiFxzrKf1KbVD+QfDo/Ud7RAvn4d43H+ybkJmcwfi913Yfiscq1ZhD7QgF6f65tip2GEEAUGA/BqiUXFKCgD2R1/OvuVkw9ujF1xT+2KuLQ2TFvvpuVBR5nuZs/kg972CixQKpHdhu1gkgNZ6bjRYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073092; c=relaxed/simple;
	bh=m996q6vO0iXzWxDYY2qrv07uM0l28IGHtkDBWQCmh2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtoDNZv7qVzGg0sMcbLfaSoCVDJFozgENWnXTVRxs3bZprcOK2eEvdNo7bVW0yx8jARlQQOoXs0v42xoPggSijubp9MOiIJJVaMf4hh7L2MXIbxvgnN7C9a7Mgr5sIcXg2edOSG/i2xxMo7JtgYwvrxcUh8ae/p5RX8qh+R3ycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzgGs4Tm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so2285837a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740073088; x=1740677888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMF86dvJYSnQvAJgZO/5z/ZtNfskKAeOlzNKthxOi2U=;
        b=WzgGs4TmLROKdXXgITQf4YPUxp17+JLm9IH0nNbEosptmlu4Wt3tYm4W0e4MIVMG/i
         rzgzspXvAQqSwZyq9zQm4ae+APaA2PMCd5GN0bs4Dd0ZfSE9UUEYP3Y4uEIMu2zmYd05
         DAnV+LKOUtTo79vhe2DeRH0g0yPsqKzllYcbkXjpvn75cRYV5aAjGZhcIDQR7+H6aU6q
         EyHLM0DCuIOvbg/0GwdHP9w+lzmCOIpbo+nKhowe1qWpI3UAQ/H5Atjh8hdzagiTa9B4
         ESy3y4JSB1UDMbMujWTXL7vLhmIDZUNmgdJvfRBHmA5teAzwR5ZrF4Rli02Hk4CjChad
         hNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073088; x=1740677888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMF86dvJYSnQvAJgZO/5z/ZtNfskKAeOlzNKthxOi2U=;
        b=nngC3yYITl+s/UYzRiVKKVLrNh50VlQKa+db5YVqlzABTXf5deAChWAduhTwDY2ov8
         60q+JXyFNmO2YT/Xh1HNHcHkfgmn1utuOt2QzdileaESFGEkyeHLoPyGD1SPt/V7CMhe
         foewiKf2+Wr3mmJ/6JESaRJfAQLEHAjgay3JX8KLGA0k7gafbdVzUkfMv0EuJ+tefcla
         HHdT8yvRHkx+GBItfWq6NpR2NQi9xLfC07Cit9u38vQBxTixpCJIVoHJSDV5lOQ3J60w
         AAFvXMrzhX9JefG8Z2ztSHbXa7MCUYxpR6PRZnzLlktTqi31hAy486oCyYzd2sVT0VvN
         ogdA==
X-Forwarded-Encrypted: i=1; AJvYcCWDj9qz15hteEOLuhLobQT66Mvi/IGnGkE90i9WwX8cB8Pm8jhn26X6nO75p3hGcg835bKZ88p30fcA@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHG5BA97gIFJlxMPfS1s2EQbrCCSGcPyKlimN9sPR/Odm0Fuq
	uB76SJHYl8DmLL/tfO10ci2XLSwKi4Acauaq5Rszk63Nr0AQxHFp+lAR/WOex/Kl45rpJKOd3XM
	wGOgm1DAR+z1/a5JMa/tvBSNVfqWNbNqo9i0D
X-Gm-Gg: ASbGncsctT/a6QwgWNwBmrRluxLCz97VxiLMxC2YJV94xoZcEL9a0AqfLeiA5kxT57c
	rLisooiRKG0v4/8xj9ydF3EwE/hwKyZ7+W+VdMh22m9eS3rloMoUNv2TiojQ7dKULRM5yajvu4s
	9tYr7TY/13dgZz1rgbcEZr/K/qRFOYUQ==
X-Google-Smtp-Source: AGHT+IHCTQyVqQ19w+hCnVON2vFH4ZvpncAf5AfsNmNbx7pLFmxcDw88MHH7wkCjdUrHoR/4Ui6EZ/cpFTAp0EQKMkw=
X-Received: by 2002:a05:6402:2103:b0:5de:5939:6c34 with SMTP id
 4fb4d7f45d1cf-5e0a12d7bf1mr4209102a12.15.1740073087606; Thu, 20 Feb 2025
 09:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHYDg1Sdi0UZXzMzWo=HkWzJx9jp6HF23oGSO_kgobs0=JyEcw@mail.gmail.com>
In-Reply-To: <CAHYDg1Sdi0UZXzMzWo=HkWzJx9jp6HF23oGSO_kgobs0=JyEcw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 18:37:56 +0100
X-Gm-Features: AWEUYZm64lSun7GoGyYp7OuLmL9vU-HmA9llCnEvCX7S5b498mJ7bVR2zsCWJIw
Message-ID: <CANn89iJWoeXaUVWUx_b_SWUR+e9du2oyjpGTnLYhddV0FtgVxw@mail.gmail.com>
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
To: Jacob Moroni <jmoroni@google.com>
Cc: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:05=E2=80=AFPM Jacob Moroni <jmoroni@google.com> w=
rote:
>
> In workloads where there are many processes establishing
> connections using RDMA CM in parallel (large scale MPI),
> there can be heavy contention for mad_agent_lock in
> cm_alloc_msg.
>
> This contention can occur while inside of a spin_lock_irq
> region, leading to interrupts being disabled for extended
> durations on many cores. Furthermore, it leads to the
> serialization of rdma_create_ah calls, which has negative
> performance impacts for NICs which are capable of processing
> multiple address handle creations in parallel.
>
> The end result is the machine becoming unresponsive, hung
> task warnings, netdev TX timeouts, etc.
>
> Since the lock appears to be only for protection from
> cm_remove_one, it can be changed to a rwlock to resolve
> these issues.
>
> Reproducer:
>
> Server:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) &
>   done
>
> Client:
>   for i in $(seq 1 512); do
>     ucmatose -c 32 -p $((i + 5000)) -s 10.2.0.52 &
>   done
>
> Fixes: 76039ac9095f5ee5 ("IB/cm: Protect cm_dev, cm_ports and
> mad_agent with kref and lock")

Fixes: tag should be on a single line.

> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---

It seems your patch is mangled.

Can you use "git send-email" to resend it ?

