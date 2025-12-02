Return-Path: <linux-rdma+bounces-14857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6730C9B94F
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 14:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3070E4E3559
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DF1313535;
	Tue,  2 Dec 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VcUuCWfR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBD36D507
	for <linux-rdma@vger.kernel.org>; Tue,  2 Dec 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764681790; cv=none; b=ilKWH9vhuFzp1r7RKfXOVtLaIGxGezuLQaYKiR3GlSTskQnkkHMqg7Pi+WjeW+Gpy8eLrK6YwwGGObZkou+MjP3R5YF2CE6OLXMm9CUooqEHgl9ChDYIaMrYdEU9is/Pzxt5Q/qAuqjswagw/Rz5sBWxY6Cj7ZmaR1ynZfxi9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764681790; c=relaxed/simple;
	bh=VIOhJrGX/xXTxKSGAU01LVY81C++52JVjkMTIsSymOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZlUHhDbyRea8uKDnTnTpTgpHrVeVd/xovQK01x31OaZENw6SxilDOs2ipVu6lQKOKg9tceCOtMeiacbsoQfIhUY27kxjJ8lcQ3KhlZQz2+VbOrTSQCII61wrC/hqV1oMnUS3yF36S8r8siZd11LG5Bx43aG1rlfk612N2NQIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VcUuCWfR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37d056f5703so53028381fa.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Dec 2025 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764681786; x=1765286586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNq8xVJi4A8uCr2hxDQeMdFJh8pqUoM5RndgbkUFj2Q=;
        b=VcUuCWfRRk1oZ1MhROjE5IFQtdyvxOSuTCgjHimkZTl5IXqKXdwSfpUn39+S1c/fgM
         496RDI6pflGuarQBo7iHy/VVNiQIwDVgmhYiWSHw+cXKhrsBKXHtwTMsmJMXtMZHuDNJ
         dVa5JLsqA6NahOUvc0ynLhpKfqM6QuMzyUUkyJg4B8g4+/LzFTJn9dbxYcVcGwnr36nG
         KnRuO/zxEVB+83T/jEu3+5PfKwpimGpFNdEGx6lPySvSoKbWq7qpVMGZhukZHPyD425A
         mzy1zgK/ObXEqZzI0072iRoTOPwjKHA26HaBBePkd5QKNLmhyeofeEZn3QmHfOZgM4h9
         KUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764681786; x=1765286586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNq8xVJi4A8uCr2hxDQeMdFJh8pqUoM5RndgbkUFj2Q=;
        b=rZ0FfhFfhmX1ff+ASXAdYuE59o7vJfo2xfslHejZTSHgyqdBjKuceMw7EqVxw9nfBL
         PbA60+wc/WL5e1YH387D/8RcpsImJNJkZLO4UPswrWMGhYkvJNg7LPOSvTKBa3jOuQNp
         1ZMTf+K1eu9zRb3aFjUtIBHv0ior0OIfpypMts2rEJykTcPh48KqiAZ1Kzqtxytb4bc3
         ENHwKro3gt/yWSYVneFsXIdXakK+dUnIZEnZbPQLvt31Rxe3PetXXgdJGSC9j6zAUGiP
         3d+brUbKHfR5m9cZbtvoZEeTZ7DfE3Ih8x9D7TtO0xHOnVeXFs4wWPkEujvbKmdgdFzn
         soVA==
X-Forwarded-Encrypted: i=1; AJvYcCUf/IkKnMyOtdS/0tbaYK9XP+cqDL74tud2y9oJCvyWmZ/E81Oto/BbS1dPlsSZl4jwoofwe3qaJdN0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UT3WTn3Dga2PPoC5TufzP/1yYJVUl5Y02qI9fCHgMdSTOdO+
	PHYPG79V19jitRX1FeSa3lp59olrHWmHjtO3PeagpFnRBX3svHpGlcBXWvDr349V4ihG41K7i6D
	u45xOOVJ1gun5TKcw0OPhr/5CV6qCIrckGitc1ZUnl0/tv6g6ow6z
X-Gm-Gg: ASbGncv+QpqIPtqNToqTqierG/91Ej92BX9uGUro5v7yQzv3M7Ny/EvPumC/FZbSEq6
	uArKBLt4yUM+IZuMolASqK+QPIENdGVtsj6Zzrpr0e0GWSWDejfF6NJS1AUofbx3O3t+L5++++w
	jiFhUrDU9+4MflNgHOt8diKVSsepdsqOP686MJXZS5f3cWJ4jVjq7eODzxC/YyU2WugCN9x+SpR
	zgHy44kU3eYpYVZYm2U0BfwvD6QFHMERTD0gYqb5dS7iC+wye2MN3gOSOsrQdFmD01NBgokX/Aa
	YFLdWva2vX2p57ZECLlQ3P7jXHPf
X-Google-Smtp-Source: AGHT+IEASLEk2auNHqzxJ7oDEfKMDj7BcVyrQ+lpdoiKuOtJB9bu1WembB1xTd+v+unY9hNN8/Nkh2R3e1uAqveHB7c=
X-Received: by 2002:a2e:2403:0:b0:37b:a821:8ebf with SMTP id
 38308e7fff4ca-37cd92638b6mr108031901fa.32.1764681786553; Tue, 02 Dec 2025
 05:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101163121.78400-1-marco.crivellari@suse.com>
In-Reply-To: <20251101163121.78400-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 2 Dec 2025 14:22:55 +0100
X-Gm-Features: AWmQ_bku0-Gghcxy1O2RgkD6wgiKk7b9iTM-TlIJVF03XA23TdLYekhJzeK6C4s
Message-ID: <CAAofZF7o+hA18Eiw=F9jbXBkeFqiw__eRx74Wb41EeTE1KP5PA@mail.gmail.com>
Subject: Re: [PATCH 0/5] replaced system_unbound_wq, added WQ_PERCPU to alloc_workqueue
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 1, 2025 at 5:31=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> Marco Crivellari (5):
>   RDMA/core: RDMA/mlx5: replace use of system_unbound_wq with
>     system_dfl_wq
>   RDMA/core: WQ_PERCPU added to alloc_workqueue users
>   hfi1: WQ_PERCPU added to alloc_workqueue users
>   RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
>   IB/rdmavt: WQ_PERCPU added to alloc_workqueue users
>
>  drivers/infiniband/core/cm.c      | 2 +-
>  drivers/infiniband/core/device.c  | 4 ++--
>  drivers/infiniband/core/ucma.c    | 2 +-
>  drivers/infiniband/hw/hfi1/init.c | 4 ++--
>  drivers/infiniband/hw/hfi1/opfn.c | 4 ++--
>  drivers/infiniband/hw/mlx4/cm.c   | 2 +-
>  drivers/infiniband/hw/mlx5/odp.c  | 4 ++--
>  drivers/infiniband/sw/rdmavt/cq.c | 3 ++-
>  8 files changed, 13 insertions(+), 12 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

