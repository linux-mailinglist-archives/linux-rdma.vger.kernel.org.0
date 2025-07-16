Return-Path: <linux-rdma+bounces-12223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA751B07FB9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 23:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09ED3ACD44
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F72EBDFB;
	Wed, 16 Jul 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiBcqvIv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C31F7580;
	Wed, 16 Jul 2025 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701841; cv=none; b=PyBlXT0y6FqkE06BiHBlPn4R6YGQcf6eIyVt2jPG+bWFN3dcBVr/BnOfRyIs7o8dM5T1IdQFvwmKIvP1YeCrbST4KlA4Yn2KMVHC09dofXi9KYyk2moWtVzRG4wCPQPh/ubuqwyGdOlq73aBBVCEvnbOuzLKeRV/dq+CL02yic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701841; c=relaxed/simple;
	bh=LnH/zbHPfJWHGgBWUQIwpU0PB4j8D8Bz3+PAjLLj5RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKaCwZ+gAPvX5HBw7OxyIK8fxK4yR7MPzHOugfdurZXsg4VzBhysGw3E4oBkcdqd6SpgV8+l6O6LPaQ3QALla6xMM6pFeEtKBNiZrjYjvDf95yf3bzVyOn56TmhV51QMFVFVquJpnmnRDpSLChIRkvzELJZtFw3TyG8G1a0aLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiBcqvIv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73972a54919so388603b3a.3;
        Wed, 16 Jul 2025 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752701838; x=1753306638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx8nWj5mjeDPGQpM7dEz+k0SLy+7OPUCTVS9f48HVW0=;
        b=TiBcqvIvyIrfzbrjeX0za++BbBeiuunfXGkMr4SM29uhwXp24ucXSpTv97O+HEgEGR
         Db2G1dYNHrjO+dvJDpHyA/9Jw7nEjMb/a6lVLx0riZMg92W8+fK7LztZ7fb+5SmuVD2n
         FmWp3fKIMNq9JbX5cCc42wHN34ql+J9iA62MnmFlkkL5+maB4ZF4QbZkZst5DYX9baop
         RzNgjQWFY4R18CbBoX+snqlaR5KymxDLHnLhypTCop9R5KKNvKS3Pd4smOis8WJCnDRk
         nKCqU0Ch0J9ILBrumZ99QBFJIiTcCbwGJeeLo+XVxHPs2d1YLthjm0A8/skZ2q18iDVy
         dsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752701838; x=1753306638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx8nWj5mjeDPGQpM7dEz+k0SLy+7OPUCTVS9f48HVW0=;
        b=LdWTH8V2r9IDKEoBN2A4fMrRpknnJDmJ1aAGHvZnCEZ46Oycq8UQMDl0Jka8aY3tUa
         FP/1P1vENGZ+cZMpGGizaVdWiMfHT87ou1iM1Czk0ew6kyu1hjrGAzBl3aiszPREwQgJ
         yjRHiEdcqEltxYoVnJEBWn+uyX+TMTMrks2JGsdBVx8HepBuZlRQy/Fioxb9P6isjSQ6
         xh+nM4HgUDa0f8t+xsh1+W/ijl61Wq9He/1eBjj4RbWylAtC6GlPxGORVTImvF3Wo1Qs
         WhoqVT00iJBsw5kUgd3V2sGIymNtK2QUJ2YO+rYz1zZrq1/M72jEoq0XkpZPbc5npxP6
         kuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGY8G3IzwztxAqNNcuNdqyrMQKBlTIY8J7Hey+O4ppKRGjW0kEZYDU9Bzvd5a1HVxkpogAttdStpUZQQ==@vger.kernel.org, AJvYcCUWsempNtqHRLu+zO8+7xDcZFDH3aLoNp2J+UOpDbMgb7FYbpRDfKXH/CzfHA8tLRh6aHR6fsgW@vger.kernel.org, AJvYcCWmslQJyXPs9GBy9c7PMu7cP9VxxSOIkm4jEYOtEojOAeRy3OIzoUFvFgQil+DYkQQ9i3TzpHYRJrV0BtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/pET3ny2xv+WLpeXIYfAfM6mMDltpQ4vWz79+1B6R0CRPH4F
	cmNJmArLEb3oYcQbY/eLqC+MdeZgvwUlw8+fNIlKNATpdobxUjKWLhY=
X-Gm-Gg: ASbGncuMkipSiqIgDkCC9IawxmLtJybbJWxR6GfnGcWGCrEIdK2BBfzprK+3kI5VA8I
	/shY+WnVLl/drgtNLNcIDdKUpOwD/U2cbMzsXWiC78WovVxWzJT6Rzbs//4fimW9ln2W2dA8G+R
	oMKGfiXeP9MSXu5xMMsI7mKJtdLnIK/cDuTYnVvYERKLHt0silgKhtY8/ROw3FmC7wI+wrtGv/q
	bhyOMH4O5Z5eb6FXIcHcNroDPfkJFZYtjvw/m/uKAj8SB5Glabif3ubeGzUbLA11lcm2ntb13DS
	W61R2UpNtLD2wTkqlK7t8ZJdJEb6xeICkdslteJD3/vj9wb5Kn+bTp7azhLDjSF/2lp92SSneh8
	vvdec5sDW/GJb+KTEHYo5tSrtCwQpGgPb6OYOJbEPkqms1AIls8lUpneL3wA=
X-Google-Smtp-Source: AGHT+IEm4+W7LCwFRCt/SICoySbflKVka84r3ZiJbUn4fm6675nsrSiYNTaU0c1tdmYKnKBHrJm4bw==
X-Received: by 2002:a05:6a00:188f:b0:739:50c0:b3fe with SMTP id d2e1a72fcca58-7572315d7bbmr6663236b3a.8.1752701837614;
        Wed, 16 Jul 2025 14:37:17 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3bbe6f4fc8sm14426434a12.51.2025.07.16.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 14:37:16 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:37:16 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next] net/mlx5e: TX, Fix dma unmapping for devmem tx
Message-ID: <aHgbjCh0UzYAD8Tm@mini-arch>
References: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>

On 07/16, Tariq Toukan wrote:
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
>   WARNING: CPU: 14 PID: 2587 at drivers/iommu/dma-iommu.c:1228 iommu_dma_unmap_page+0x7d/0x90
>   Modules linked in: [...]
>   Unloaded tainted modules: i10nm_edac(E):1 fjes(E):1
>   CPU: 14 UID: 0 PID: 2587 Comm: ncdevmem Tainted: G S          E       6.15.0+ #3 PREEMPT(voluntary)
>   Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
>   Hardware name: HPE ProLiant DL380 Gen10 Plus/ProLiant DL380 Gen10 Plus, BIOS U46 06/01/2022
>   RIP: 0010:iommu_dma_unmap_page+0x7d/0x90
>   Code: [...]
>   RSP: 0000:ff6b1e3ea0b2fc58 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ff46ef2d0a2340c8 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
>   RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8827a120
>   R10: 0000000000000000 R11: 0000000000000000 R12: 00000000d8000000
>   R13: 0000000000000008 R14: 0000000000000001 R15: 0000000000000000
>   FS:  00007feb69adf740(0000) GS:ff46ef2c779f1000(0000) knlGS:0000000000000000
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

