Return-Path: <linux-rdma+bounces-14550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD557C6598A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 608472923A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59431C84A0;
	Mon, 17 Nov 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IDH3u5cI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927612C11F3
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401662; cv=none; b=sTeiK2hn9XSZqGSCNqIb5tI6DSiO5iRoOtm0n5w6e4fsNbt24R67dJmdAxU67XlNYNJ0ccSfOzjr5Hcnv/oiFrvNRFQqmnHcB4Yk3a4fVU8UitDEFjVdHQX39fEWzLwkS9YsNGzmj8NpPPk99ggKMq8i6XcnJTa5KRb5ySM2M8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401662; c=relaxed/simple;
	bh=btDhMHvVGKwNWkoEdN9tCgMCsRJ706lwryBWAZnSQOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjPBeZTMCwPUI0FjpZF/7nBJOXZAQDCynDoPp7MvLojuhGYLkdDQBhIWsfudgxaeq5WvZxgIsh8kFWU/RAl9arkdx/gDEHbJZRjupqc5GiOL5CaapaCvRdONkSY/neKll2g9qzs8HqyHbWjGRIxnDVE5K6U0T1O9fYyuOOdwzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IDH3u5cI; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88054872394so60873776d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763401659; x=1764006459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfS0cRcV5EzH6vvWSkOArvPc4YDV2MEEprGv3vxqrXo=;
        b=IDH3u5cILKTO13YrOxWkkWpqViRBdXefnx+zOPrQdRertnsIyArJL9nS3yF476+Hft
         BWS/IhI+rbwAtynoZ5UhTGgWcJo01lWwWcxjIFPRGev14UfIYt0md0zhCaXy0v73dzg9
         wOFpbjhHUJio5ElhgT2d3+cA9FI7NRrqjZ6/mdGvCjNktn7bFi8jJ4khaFoXH9ipk+0a
         En4pnwdr5OzK90dNTQwalbffrV+Hv0+O5OJqJezF150VhIwduGR+3PtNQWcLjquC9b1K
         RDV4L0uhxs8FGZb9moa7t5MUKVdvWgF4eW3tF1JslCE2zSSHZAytceSxhI79DT3LLxjG
         Caag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401659; x=1764006459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfS0cRcV5EzH6vvWSkOArvPc4YDV2MEEprGv3vxqrXo=;
        b=MKEvB11pujIm6EOSJt87ckVRdMfAPHa3neQuRLTPL/q/CIEo/YYXz8X36cd7ms5hk5
         WRPuOVl5elcvMkNtVRlpkoaYDnlJPIYQyZmrlQlGekG0O/D1clp2hGrdgnwHZxCQJfEn
         GC4LyagmJqcLRrQhveRJZe9jwjkj9QqNryLNEc9oWoQlgBNBqSvP04owDR0N/vzy5BHd
         WpilEtTiHjkD/OGNLCLUWPYu1CmaVDCYRQO+2Te1aA34hOoLyXDC1uFG8p8+5JT0ywzu
         Su0TtjiOMFjMlkuNqBBrGL2w7dPaM7jBVFDjUljruoxxr4Y9C72ioap0DtsgNf9mi0ln
         mmbg==
X-Forwarded-Encrypted: i=1; AJvYcCVj8NT+G6ueyREsC/4gl7trvFHCc42Z69JZq7kJcLOpbAOvf3lychnswL4exZ/wXJ0oDZRADE7hMPXl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ckgVH+gnvMaUfWTKnq5EY5UN8Ts3asHlP67vlLBvsDr8YuOw
	1iZOoxqeOxtftyqISQmK1Mvy0+aOCW0slGOUxFN7whhui5VExjAAPOp8QNw+4OyMikc=
X-Gm-Gg: ASbGncu9rAifBMWpseHfWqqpzCpf5AAEViBWtiKlahDafJ/gu4q6ByxAtBi5lBdBqa0
	+zFQCjrd0q+5xKdr0v7CG9H4fuS5eMvBb3JQ6jb4SaH0Mol1Z4vfU7qExixd0MAkBeH7nY17cye
	QhSWSjetukv99jsGKVKSjlZfw8o2XCVHuqUU31TMebGL+WOw3TsYvJjpv/2h3O1mJXQ26zDQRdN
	8wtSvZynj+DFMwTjO9vHx3VoCu14TjnU4mO2lGcptXyVFMP2Lw87fGsktPPlch8fOKqMahHnMkn
	ENkQPOgr5XRBI3DPYBqzzo4lmGaCvy99YoMcUp9oA0p6WFORNU9S5dKCSeGyZsQD5oA3ihbrLmE
	IEo5h5Iixh9iU3RGCihTNzo0bW24gDJozjuaesCH1ZgVM9O2EJ4SEPzRnBK74L5uuVMfA70/ilC
	lZK+86cGE7elPPlR+cz1qBMRaMH1llMs54koNb/DNGkBtT31mxmIm2FaSY/A9VjpmB8fDrwFamM
	qbTNQ==
X-Google-Smtp-Source: AGHT+IFl4TETteguEKWX1z3k30oLJAZdTKnD0cFHn41Iy5R9Ub4zv417zwSt5dBSly3WOiblowA+Lg==
X-Received: by 2002:a05:6214:f21:b0:86a:7c95:1266 with SMTP id 6a1803df08f44-88292604ae4mr197460436d6.22.1763401659338;
        Mon, 17 Nov 2025 09:47:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286592388sm96723946d6.49.2025.11.17.09.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:47:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vL3KE-000000005hj-1ar8;
	Mon, 17 Nov 2025 13:47:38 -0400
Date: Mon, 17 Nov 2025 13:47:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: lirongqing <lirongqing@baidu.com>
Cc: Leon Romanovsky <leon@kernel.org>, huangjunxian6@hisilicon.com,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH][v2] RDMA/core: Prevent soft lockup during large user
 memory region cleanup
Message-ID: <20251117174738.GE17968@ziepe.ca>
References: <20251113095317.2628-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113095317.2628-1-lirongqing@baidu.com>

On Thu, Nov 13, 2025 at 05:53:17PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When a process exits with numerous large, pinned memory regions consisting
> of 4KB pages, the cleanup of the memory region through __ib_umem_release()
> may cause soft lockups. This is because unpin_user_page_range_dirty_lock()
> is called in a tight loop for unpin and releasing page without yielding the
> CPU.
> 
>  watchdog: BUG: soft lockup - CPU#44 stuck for 26s! [python3:73464]
>  Kernel panic - not syncing: softlockup: hung tasks
>  CPU: 44 PID: 73464 Comm: python3 Tainted: G           OEL
> 
>  asm_sysvec_apic_timer_interrupt+0x1b/0x20
>  RIP: 0010:free_unref_page+0xff/0x190
> 
>   ? free_unref_page+0xe3/0x190
>   __put_page+0x77/0xe0
>   put_compound_head+0xed/0x100
>   unpin_user_page_range_dirty_lock+0xb2/0x180
>   __ib_umem_release+0x57/0xb0 [ib_core]
>   ib_umem_release+0x3f/0xd0 [ib_core]
>   mlx5_ib_dereg_mr+0x2e9/0x440 [mlx5_ib]
>   ib_dereg_mr_user+0x43/0xb0 [ib_core]
>   uverbs_free_mr+0x15/0x20 [ib_uverbs]
>   destroy_hw_idr_uobject+0x21/0x60 [ib_uverbs]
>   uverbs_destroy_uobject+0x38/0x1b0 [ib_uverbs]
>   __uverbs_cleanup_ufile+0xd1/0x150 [ib_uverbs]
>   uverbs_destroy_ufile_hw+0x3f/0x100 [ib_uverbs]
>   ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
>   __fput+0x9c/0x280
>   ____fput+0xe/0x20
>   task_work_run+0x6a/0xb0
>   do_exit+0x217/0x3c0
>   do_group_exit+0x3b/0xb0
>   get_signal+0x150/0x900
>   arch_do_signal_or_restart+0xde/0x100
>   exit_to_user_mode_loop+0xc4/0x160
>   exit_to_user_mode_prepare+0xa0/0xb0
>   syscall_exit_to_user_mode+0x27/0x50
>   do_syscall_64+0x63/0xb0
> 
> Fix soft lockup issues by incorporating cond_resched() calls within
> __ib_umem_release(), and this SG entries are typically grouped in 2MB
> chunks on x86_64, adding cond_resched() should has minimal performance
> impact.

This is not true, I think this should have been more careful to only
resched after larger groupings.. How much slower did you make normal
4k unpins??

Jason

