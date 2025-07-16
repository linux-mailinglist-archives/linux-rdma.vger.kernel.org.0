Return-Path: <linux-rdma+bounces-12221-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D151B07D7B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 21:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C0F586D04
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFC21D5B8;
	Wed, 16 Jul 2025 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibHrRFc0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700F1C5D5A
	for <linux-rdma@vger.kernel.org>; Wed, 16 Jul 2025 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693386; cv=none; b=bF0LgggiD9bozTtGxddyQiIUEPlurlUTZcd8u+/r4vF3eUyacRp4xdKmccYhHpPtgc5I0aBOEjyhd6AWzSBstinARD3ma5M8NSoNiXG1O3QHKG6gBoGz+ss4+/qTEaYJCfy1zXjPTDdjcw95Uz37C4RnqIIz0AVdTUxXfEYNTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693386; c=relaxed/simple;
	bh=7a4F/v5t0VTy1cn1BrYaA4E3/yySyypOsX+OzuYTcvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2Hz0KT+nmvZUn468mY5QLQKzfzHkdpOGS8Zd9IGzU0kG/zoypfIT7pjSHDKTmD+wgA5PJvlqL21O09q6Axwz66YNrAxHGuGikSD1pdcdw6acqIbuouv+C3zYFAsMhlO3sLUX3+T9nVx/CzZMo8axPIbqcZcVrAMUwDDM/UepUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibHrRFc0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dd9ae5aacso30805ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 16 Jul 2025 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752693384; x=1753298184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCXogAk+cweZ2SJB8bYDRGUnX9Id22JuJKEB410D5Ak=;
        b=ibHrRFc03Sf8/ldGtJILbmnsOevN4x8rgu12BcksInJYOfZa25kEpCiawb7jO4In1+
         tfH1rpGPCvnBQXe6h1TE2NvnhZpN5fZD+Osw083MSgFuZr37nWZJJ8qLTpGGiIg9O+R7
         i2XwGDvoqbkD8sDZJxU1XkfhDaUb+yeNZQVMdyOH6g5YItiB9rvIaBTsw92qknkLOWHZ
         4hXyg9ZEkqpoUfP69z2uNRUtKmUGBHc3RGrhrHMnhkabEpUluN3VT/dcWiJNMp0HtCbj
         yVsvXISeFbmXaTatSLuwoMkes3xtMIIZw7f79kVeVLTvkP0axFgtFbv3jnsMhRb9SzC0
         LLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752693384; x=1753298184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCXogAk+cweZ2SJB8bYDRGUnX9Id22JuJKEB410D5Ak=;
        b=hRhzDVujK1JAawQ3saO8tNfSlj5lHK+wN86+mCouN6x9J8oPUppGdp4abuLgHfnSRa
         tVxv05w2HyHb6RmZRhnKRoDDmD8VT8gRwpcOK4J5hGa0g0ayng1mkOn2e1aXpFC1xZYo
         ZGfWw1XEH3rQmWm1SuYtRWtfwuCvF/unIvzibFLMFrToQUn1tPySjLDwJsry0iM7dOLB
         yW5I1n4uT9bOkDRB3jchJqZ1y9b/y+tDMc+6TyxeNFPMD0LQkuS8Rj+iDg8bS7Pwvk6T
         jokhyeYtJroj00cVoPVoNV2W2aGC5YvZJFwql4C7AfZJuOO0ohJ11NdZtfPrOy1B1ajm
         DZnA==
X-Forwarded-Encrypted: i=1; AJvYcCVpQNuMv9JnSyxGgO6KUIhpPEdATOsEP0Ah4afdV6XXur3t+k9fMfw+rQoekjpdGq2j41Kwt9h62kYG@vger.kernel.org
X-Gm-Message-State: AOJu0YxobazOwYtEAxl0o7j3mw4qk+uslfgCjWVlt2Dzt73HJd/wQCiv
	eZ9pJj+/+8eOe60VIgp2DZV43V4uaov/KGV/L6CchW9cKbh3dXInxSH76P+MdQUf/CctU67PtuS
	NgQngw9DsXfSFt+M0L1tOFlFkEz03owTAOY7cIIQw
X-Gm-Gg: ASbGnctKvIe6QNDvUYrxuWOK+/xqxYo8K4T0yCZuUQ7BZvH1TWaObxgFu9Y+/OsRr8r
	xRclTuBcDtfCHL9+J59+8DzJNSRz15ixWnG0zzo5S8FOxXphrdPo0n2KQUVENwpqZ8DDA1Ej1VB
	8VhK+Md5BhV1ks6i/okFDQYQzQF7ZQhtjdIUiK+MullVyxGYkkzGLZzDb32FpHhK9BmY3q0+u5/
	AVVlZ/Q
X-Google-Smtp-Source: AGHT+IGjz6prczNhR+tpnPf3HqDU6DjfU18vzOHN51hPdE3NBlhP0WNSMfiyXgFly1IMHdVGdlB6xyeXDOHplgNGr7E=
X-Received: by 2002:a17:903:1b48:b0:223:fd7e:84ab with SMTP id
 d9443c01a7336-23e2fe9b868mr480835ad.24.1752693384098; Wed, 16 Jul 2025
 12:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 16 Jul 2025 12:16:11 -0700
X-Gm-Features: Ac12FXxxij_WhdVUZejr3zF9wy4BTmiPJrkxcdFq014hkkwU57ufFSCs6aIMXQ0
Message-ID: <CAHS8izOkpcpO0KwtOZb0WE5kw+hec8nN9cWGarjT7dupw3Z+UQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: TX, Fix dma unmapping for devmem tx
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:01=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> w=
rote:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> net_iovs should have the dma address set to 0 so that
> netmem_dma_unmap_page_attrs() correctly skips the unmap. This was
> not done in mlx5 when support for devmem tx was added and resulted
> in the splat below when the platform iommu was enabled.
>
> This patch addresses the issue by using netmem_dma_unmap_addr_set()
> which handles the net_iov case when setting the dma address. A small
> refactoring of mlx5e_dma_push() was required to be able to use this API.
> The function was split in two versions and each version called
> accordingly. Note that netmem_dma_unmap_addr_set() introduces an
> additional if case.
>
> Splat:
>   WARNING: CPU: 14 PID: 2587 at drivers/iommu/dma-iommu.c:1228 iommu_dma_=
unmap_page+0x7d/0x90
>   Modules linked in: [...]
>   Unloaded tainted modules: i10nm_edac(E):1 fjes(E):1
>   CPU: 14 UID: 0 PID: 2587 Comm: ncdevmem Tainted: G S          E       6=
.15.0+ #3 PREEMPT(voluntary)
>   Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MODULE
>   Hardware name: HPE ProLiant DL380 Gen10 Plus/ProLiant DL380 Gen10 Plus,=
 BIOS U46 06/01/2022
>   RIP: 0010:iommu_dma_unmap_page+0x7d/0x90
>   Code: [...]
>   RSP: 0000:ff6b1e3ea0b2fc58 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ff46ef2d0a2340c8 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
>   RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8827a120
>   R10: 0000000000000000 R11: 0000000000000000 R12: 00000000d8000000
>   R13: 0000000000000008 R14: 0000000000000001 R15: 0000000000000000
>   FS:  00007feb69adf740(0000) GS:ff46ef2c779f1000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007feb69cca000 CR3: 0000000154b97006 CR4: 0000000000773ef0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    dma_unmap_page_attrs+0x227/0x250
>    mlx5e_poll_tx_cq+0x163/0x510 [mlx5_core]
>    mlx5e_napi_poll+0x94/0x720 [mlx5_core]
>    __napi_poll+0x28/0x1f0
>    net_rx_action+0x33a/0x420
>    ? mlx5e_completion_event+0x3d/0x40 [mlx5_core]
>    handle_softirqs+0xe8/0x2f0
>    __irq_exit_rcu+0xcd/0xf0
>    common_interrupt+0x47/0xa0
>    asm_common_interrupt+0x26/0x40
>   RIP: 0033:0x7feb69cd08ec
>   Code: [...]
>   RSP: 002b:00007ffc01b8c880 EFLAGS: 00000246
>   RAX: 00000000c3a60cf7 RBX: 0000000000045e12 RCX: 000000000000000e
>   RDX: 00000000000035b4 RSI: 0000000000000000 RDI: 00007ffc01b8c8c0
>   RBP: 00007ffc01b8c8b0 R08: 0000000000000000 R09: 0000000000000064
>   R10: 00007ffc01b8c8c0 R11: 0000000000000000 R12: 00007feb69cca000
>   R13: 00007ffc01b90e48 R14: 0000000000427e18 R15: 00007feb69d07000
>    </TASK>
>
> Cc: Mina Almasry <almasrymina@google.com>
> Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
> Closes: https://lore.kernel.org/all/aFM6r9kFHeTdj-25@mini-arch/
> Fixes: 5a842c288cfa ("net/mlx5e: Add TX support for netmems")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>


Hmm, a couple of issues I see, but I'm not sure if it's really wrong
or my own non-understanding.

I don't see  netmem_dma_unmap_page_attrs called anywhere in your
driver. The point of  netmem_dma_unmap_addr_set setting the addr to 0
is that a later call to netmem_dma_unmap_page_attrs skips the
dma-unmap call if it's 0.

I could not understand why the mlx5/core/* files still used the
non-netmem variant. The netdev->netmem_tx was set to true in
mlx5/core/en_main.c, so I would have thought at least all the
mlx5/core/en_tx.c callsites should have gone to that.

--=20
Thanks,
Mina

