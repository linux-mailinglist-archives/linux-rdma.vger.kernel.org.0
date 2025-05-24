Return-Path: <linux-rdma+bounces-10668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CCAC3185
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 23:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F076E16F95F
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F627B4E8;
	Sat, 24 May 2025 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua3O7UBL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716A8F6B;
	Sat, 24 May 2025 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748122057; cv=none; b=sb0rq4x5eWXIA1CPI3sJIgJYpwVj43MVluplIQSInNY5J1iUp/TAOWA4HB7esukU0csqmyjrPyTaCYb/Ty1b2M9HOIp+MIz0zRUB1vqciJ40rRgFOF1bK44OE1iTbjmluiuXROfYoe83uq0WzbMh0CGdBuWvcMhYq7wNfqnHX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748122057; c=relaxed/simple;
	bh=diRzJ6g6imSGZtFsx5Vm5N7uGAlGC8tn2nAtwwyRR6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnqV2P9sO4d9IA9AMU1g1+zQItjusoYrOlWjP9nQipneXds0AzbzELsXYpT6Pkc9NandNnyWzPcNCo/IPHD1DOPLlHidKMgB7JufOn2SSTrf/iXsAAcpm0b3FtM1c2TN7VfelBuATeUb64/8WutVfEqhqpgH4UAJ5677l2cEF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua3O7UBL; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4033c70577fso607369b6e.0;
        Sat, 24 May 2025 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748122055; x=1748726855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Noh8Y++Az3xPmWSkejOe9xkA0YPFPMNwQjZr0ewVOqE=;
        b=Ua3O7UBL7gKpzx7yNqDh9+honGdrz7OYw3nyYYsq02iCUvdyb+zm/5oaS1BN0PDEb4
         V6DnOOZ1lcQYBsv2CyulT7jEzjq8cwDyZDab8SjEMU1idxIVrF+RsF8FMaV35ZbgNfGs
         h3pLcIvLlwOKNbXyxmq54vUuIX8wp+/A0GAQc4hcnO0xS2L/p2yaq9Fto94OwRIedP2t
         fllsdrROeRotQRxtxPnOugib7lgXtE1fZEMqPdXBG7feH/Hbb7ssOfVCrp98G1wmmhX1
         tPR9v2GGwtb/CAov61TFVu9Xk3bMeUCn/RRQi0RPwd6Su2tZm5f5WoVAOUSxdsPhPFLK
         R9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748122055; x=1748726855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Noh8Y++Az3xPmWSkejOe9xkA0YPFPMNwQjZr0ewVOqE=;
        b=jYhaG5Jkh9OIfvIfHE6kIGBYts3wrQ8RICXe7PLfGnXJr+Pmsu5ZqlRhAagy0Eqpoj
         dWtqFQ1ROAb+cdgMuftIa+TKu66EH/CP8Q2r8Rs8xp84D4jArHHaQi7PpxlA8HlRtOi4
         1XJJsn+tRHd6gAQGhUM3X9xP+RUkCYZ+FSsHPVdcgnM/DVlaYu1mjpkhZb9GqzBeqSQP
         wc233kF9FMqKvabWME+QHU8BuBJVpEK0sDbzb5orNvxxOjRzHYfUUm2JbG/6WboBi1Vj
         bKoQIPqoeKm3fF3ePkRt9hti/R7ZyX5NEnOZDKGo3wRfM0r+hM2rDYtBbW4xmXEaREcn
         0PLg==
X-Forwarded-Encrypted: i=1; AJvYcCWJsi9PDek1mZFTUJElcyAnuaXqx18K4Ze+hzNiL1vnAlIYR3wPaZC9VKSv2Oe1P6VsS7dyVjt6i+zn@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAZz99XikYI8t91rA3wIcS6T2mNR5EWg9FHMeE7qzZ1De11d1
	YeCjuzB9dKqJdGeiLNmbkj07CvbaUT5dGSYB9Bxgax6CvADVtMj9Kmo6EQ5jzFupCsJ+wAWPsID
	pEHqMn8qRlfdbybjXddqjMBpPZrtdrWI=
X-Gm-Gg: ASbGncs6Wvo5oJZY4uJE69b2AEGjJ/huoHtSdeilMAX61vvZSbrtXCZNhYTYAbBKd4E
	zSetDkUbuXT83NsLTkWwOfhEJyUV7V1auCKhcqVTVA0Uk7025Y1j51aSg4g72l4NFYaKTEMFRaI
	cUB5OU2Qh7wA6/9XzJvohf2a79EgfmF9sxWO3CvrpP994=
X-Google-Smtp-Source: AGHT+IGU530JBUosRBQTFkjA+6YA/kj6DGBKAugfIRPhB3YVDKf5FDVNYMRLQLnnJCdv+Q6wREgwzZzLMKCoi3MWJQE=
X-Received: by 2002:a05:6808:399b:b0:404:12e9:d3ee with SMTP id
 5614622812f47-40646830aedmr2053829b6e.15.1748122055104; Sat, 24 May 2025
 14:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524144328.4361-1-dskmtsd@gmail.com>
In-Reply-To: <20250524144328.4361-1-dskmtsd@gmail.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Sun, 25 May 2025 05:27:23 +0800
X-Gm-Features: AX0GCFvnItnSdA63h8rBIshDHygqPVtOF1Zod5pVSJYalAbDb8lWcFZnuIa3C6Y
Message-ID: <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, leon@kernel.org, 
	jgg@ziepe.ca, zyjzyj2000@gmail.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 10:43=E2=80=AFPM Daisuke Matsuda <dskmtsd@gmail.com=
> wrote:
>
> Drivers such as rxe, which use virtual DMA, must not call into the DMA
> mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> pointer dereference is observed as shown below. This patch ensures the RD=
MA
> core handles virtual and physical DMA paths appropriately.
>
> This fixes the following kernel oops:
>
>  BUG: kernel NULL pointer dereference, address: 00000000000002fc
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G        W           6=
.15.0-rc1+ #11 PREEMPT(voluntary)
>  Tainted: [W]=3DWARN
>  Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
>  RIP: 0010:hmm_dma_map_alloc+0x25/0x100
>  Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 d6 49 =
c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc <f6> 87 fc 02 0=
0 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
>  RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
>  RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
>  RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
>  RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>  R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
>  FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
>   ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
>   rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
>   rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
>   ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
>   ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
>   ? mmap_region+0x63/0xd0
>   ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uver=
bs]
>   ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
>   __x64_sys_ioctl+0xa4/0xe0
>   x64_sys_call+0x1178/0x2660
>   do_syscall_64+0x7e/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? do_syscall_64+0x8a/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? syscall_exit_to_user_mode+0x4e/0x250
>   ? do_syscall_64+0x8a/0x170
>   ? do_user_addr_fault+0x1d2/0x8d0
>   ? irqentry_exit_to_user_mode+0x43/0x250
>   ? irqentry_exit+0x43/0x50
>   ? exc_page_fault+0x93/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7262a6124ded
>  Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 =
00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f=
0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>  RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
>  RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
>  RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
>  R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
>  R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
>   </TASK>
>
> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching =
IOVA and page linkage")
> Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@=
gmail.com/
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>  drivers/infiniband/core/device.c   | 17 +++++++++++++++++
>  drivers/infiniband/core/umem_odp.c | 11 ++++++++---
>  include/rdma/ib_verbs.h            |  4 ++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index b4e3e4beb7f4..abb8fed292c0 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2864,6 +2864,23 @@ int ib_dma_virt_map_sg(struct ib_device *dev, stru=
ct scatterlist *sg, int nents)
>         return nents;
>  }
>  EXPORT_SYMBOL(ib_dma_virt_map_sg);
> +int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
> +                         size_t dma_entry_size)
> +{
> +       if (!(nr_entries * PAGE_SIZE / dma_entry_size))
> +               return -EINVAL;
> +
> +       map->dma_entry_size =3D dma_entry_size;
> +       map->pfn_list =3D kvcalloc(nr_entries, sizeof(*map->pfn_list),
> +                                GFP_KERNEL | __GFP_NOWARN);
> +       if (!map->pfn_list)
> +               return -ENOMEM;
> +
> +       map->dma_list =3D NULL;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
>  #endif /* CONFIG_INFINIBAND_VIRT_DMA */
>

Your ODP patches have caused significant issues, including system
instability. The latest version of your patches has led to critical
failures in our environment. Due to these ongoing problems, we have
decided that our system will no longer incorporate your patches going
forward.

--G--

>  static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] =3D=
 {
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core=
/umem_odp.c
> index 51d518989914..a5b17be0894a 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -75,9 +75,14 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_o=
dp,
>         if (unlikely(end < page_size))
>                 return -EOVERFLOW;
>
> -       ret =3D hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
> -                               (end - start) >> PAGE_SHIFT,
> -                               1 << umem_odp->page_shift);
> +       if (ib_uses_virt_dma(dev))
> +               ret =3D ib_dma_virt_map_alloc(&umem_odp->map,
> +                                           (end - start) >> PAGE_SHIFT,
> +                                           1 << umem_odp->page_shift);
> +       else
> +               ret =3D hmm_dma_map_alloc(dev->dma_device, &umem_odp->map=
,
> +                                       (end - start) >> PAGE_SHIFT,
> +                                       1 << umem_odp->page_shift);
>         if (ret)
>                 return ret;
>
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index b06a0ed81bdd..9ea41f288736 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -36,6 +36,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/preempt.h>
>  #include <linux/dim.h>
> +#include <linux/hmm-dma.h>
>  #include <uapi/rdma/ib_user_verbs.h>
>  #include <rdma/rdma_counter.h>
>  #include <rdma/restrack.h>
> @@ -4221,6 +4222,9 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_=
device *dev,
>                                    dma_attrs);
>  }
>
> +int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
> +                         size_t dma_entry_size);
> +
>  /**
>   * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresse=
s
>   * @dev: The device for which the DMA addresses are to be created
> --
> 2.43.0
>
>

