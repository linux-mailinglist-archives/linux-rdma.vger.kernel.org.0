Return-Path: <linux-rdma+bounces-14869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE35CC9F2DA
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Dec 2025 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218733A5BDB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Dec 2025 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DBD2F8BC5;
	Wed,  3 Dec 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NUh8bUn0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048C2E0930
	for <linux-rdma@vger.kernel.org>; Wed,  3 Dec 2025 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764769601; cv=none; b=pPwjsHOBJhfzrzQSckLJuEox+Z1ci7tBPa4hbRWdjKKGPt0KDsr5B1LqPbi1j593NmKs1wbzE8AXivqEq33tNf0+qSu6VHqUnDVIXLAEL2/E6R0g8D3dUim214hT3vufUaf9KubolvHGsXZgzwi2Ln/PU7rv7eKhXhoVlmgPr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764769601; c=relaxed/simple;
	bh=q8/zRfd4wwCoAGEIgjMl86VmZupmLqXrtI6SDYcbsMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/Gt+GX0uem+IbbsWHpn4pVcoFFiwtk+wRol4MVd6+hcVnb/tGP4OXiBM5xySoSlzEH+FN+lLzEsIdiStUKIYB4LN5M0Tq/ZrqqaUq2h2IAMnzqqI68AkVgDi8PD6znva4jJcAzCDTsQd3tyqxsUBUE3Tq+Zs1nqsT63SZeiagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NUh8bUn0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-596ba07504dso5829790e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Dec 2025 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764769597; x=1765374397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8/zRfd4wwCoAGEIgjMl86VmZupmLqXrtI6SDYcbsMI=;
        b=NUh8bUn0X+jIL94MgKyc8apc0UqEjtZcFj+55GlDPsLg4NvyUb5ujpitymY+J2+zSJ
         +NbzJGZ+p+8OmnQTtucc3RDqlNyhEqwkQkC1O5mCNzkJNiGhmK3wn/7Sg6b78Z4uNznb
         jtahvs9QAAnzdHza17rynaV46vKqdHSXmPvUemtAdwGBWL0aR8EuNTlKIWekbMT4HwHj
         /T30bLfV1IBUtkD+id5LShUnHoECXpbBBmkkxvQt4pAHNn6CRLW1LbduvI3PcKg3Sc2E
         rJyEk1Evf8sm04CPU955qHSKMp2Dc5LrRFI0qDsAkwgJzXGkfCpJgvuqShxeWX83FiQo
         GWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764769597; x=1765374397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q8/zRfd4wwCoAGEIgjMl86VmZupmLqXrtI6SDYcbsMI=;
        b=tOeo3mPeASKyiehsH65SF9VKT9rFZYbOWljNFolC3y7D3C2oCi5coUMi43vujvfbkD
         CTqWYFi88XOG1uFYqgKt7sdxagsBxLKhOGivFvcTqQsQj93qvPegdHFv9npP98NPFx/J
         wotB/z5A4yR3mqn0ULRLbLX5vrVO+PM93WTGjQaP7wy04kJCxc2uLG+KAq/qMkR/obIq
         Soe87agplTGb527nuCDm7Kb9Tnb29xnw/CqSez/5zJC5+0/jh34qnX30RPa8MjwckwNw
         KDRuVWOG9IIVVYtSkc9B4fQb+Q/zw2svSWVysj08uIzR0w/USXpHmaHeo2/CUy09BlU5
         b9vA==
X-Forwarded-Encrypted: i=1; AJvYcCUkPeSz2Ff5jA4TWxavFZFdJOaEEs3BhHwUfbnTsiJ7PWf5j4X9YJl9wEZcDgjeH0N1kPNXRi54aixx@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSE0wgpMGmhLNbQ926FGQF5oOvy/M/MNA6NlxmKAfoOoizNqX
	uN7zLKMg6XRA7m1FAj5IcnhahXUREJ38T+9T8p5xmFZqV+yi/9mMCt0s6fyguebwNqtN0sP2jpD
	Ty/tUEVjeDEK04t6TYt1hCN9i2K0nuDV8DfG44rPYwqyMYUSy4OMt
X-Gm-Gg: ASbGncu1QrvtzRb5LhpIA6qAgBnSGR+xjEGSZ7qQYy6/gZFX2chl/7II6+RVKMK/2U/
	D1po573Vbac0OYZpiVZ97vBvfBkD49bfC+Z/WdgmbwXXz/mWVAYUvkcOm1UQb3UMCkFu9lpYcGz
	IZ1SYNUEYsb796eEzSv9kwGNChYnpYxzxTQRRFOOgoosUZO0NvwPjjqjl/nJe7RtMsDYEyuxUz6
	1vZNPnFtgvo9ADVh2DI6j7H7Nr2Dw5fX/SIeVmX/uLunIlqLgAlRD4Lrvka9terdkX2nZ645xhA
	16BJUVFRnhRckHMBPCX4Lijcoz8E
X-Google-Smtp-Source: AGHT+IFgcoOHYwPG+HirZ0tvUINMoGB3cL0yDD58U2MPgYM9a7UZ6TNdhtu+dgl2bd6Lb3O9r6RLWIVJSyxq1sCJ+Zo=
X-Received: by 2002:a05:6512:1315:b0:595:9d90:5dc8 with SMTP id
 2adb3069b0e04-597d3ff1f31mr1004602e87.49.1764769597281; Wed, 03 Dec 2025
 05:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101163121.78400-1-marco.crivellari@suse.com>
 <CAAofZF7o+hA18Eiw=F9jbXBkeFqiw__eRx74Wb41EeTE1KP5PA@mail.gmail.com> <20251202191752.GJ812105@ziepe.ca>
In-Reply-To: <20251202191752.GJ812105@ziepe.ca>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 3 Dec 2025 14:46:26 +0100
X-Gm-Features: AWmQ_bkGWkiHw8rAei6ejQueeIhW1EktGSoouL-JskXcwJK5-9sk1-fPDlAsBbM
Message-ID: <CAAofZF52mibA0m8OCzqvM2xwb28C03_YEU9Nz7ecGDpGzE3wiw@mail.gmail.com>
Subject: Re: [PATCH 0/5] replaced system_unbound_wq, added WQ_PERCPU to alloc_workqueue
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
> It looks like it was picked up, the thank you email must have become lost=
:
>
> 5c467151f6197d IB/isert: add WQ_PERCPU to alloc_workqueue users
> 65d21dee533755 IB/iser: add WQ_PERCPU to alloc_workqueue users
> 7196156b0ce3dc IB/rdmavt: WQ_PERCPU added to alloc_workqueue users
> 5267feda50680c RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
> 5f93287fa9d0db hfi1: WQ_PERCPU added to alloc_workqueue users
> e60c5583b661da RDMA/core: WQ_PERCPU added to alloc_workqueue users
> f673fb3449fcd8 RDMA/core: RDMA/mlx5: replace use of system_unbound_wq wit=
h system_dfl_wq
>
> Jason

Aha, thank you and sorry for the useless email!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

