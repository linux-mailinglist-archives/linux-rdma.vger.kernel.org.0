Return-Path: <linux-rdma+bounces-10487-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA7ABF5D6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B060E1B67888
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5036263892;
	Wed, 21 May 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJhNf7t7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BE4CB5B;
	Wed, 21 May 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833419; cv=none; b=K35vV4zuDmBE8OLA+nc7bze0STQ0ruYG+LYjNcIzeYQ7WfD57MrzBIehBkQNdfUAnPBwpk9rHm4NRYTt7E/prYfuXy43Kxlp03vmfKGDsFisaXeof/mLAPiqb78iZFtiuPm1JIhY1M1JNXbhmm+4xTtdPPtB1omjWlFc/oamnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833419; c=relaxed/simple;
	bh=vKhw6z6V7OCV8t82boQCakDHSPpGxBivjHyP4/VgWOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bKtwj8agBs7R9GPiucwECH+NNf7PzJmwRTufL4ykEhxeAALyqXdeShvgE1VQeH2TFW5as3VphIllA8fNBam1oFx01PoE/N32juKnzUmQTDP0k4nAPXg4p4yHIsmshVt8BDwVc2JJ1fhenMUZn+sPHpQyZmjaWUXLjuMX+Jj/KRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJhNf7t7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2322f8afe02so31003715ad.2;
        Wed, 21 May 2025 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747833417; x=1748438217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cYgvyteFUsDXg+ceLCjMI2UWdgFf/NgcDDOuU7Imm8=;
        b=EJhNf7t7noGNkty2s5qCtX38m44kKIg1GyMJ3q50+q99ihoAL8MecdHWgVSfiL7Nsg
         pWe2YsW1nVZDPDOiUdEmya3xPOTP9GfY+BLZneGZdEKz/4oZNR/aWZa4/xsijbuqhNct
         zEGsO+dxQOEOGwBLgaP+BT/N3R5AwNabsfZqGg2gxsTnJDLw4LmSX9y8pmbYMCsdiO5W
         dWrkpmJUcwruJp89WtoXtFNkOoxjoxOStkdx6hyDoWxq8xPbrHtke9APNyELvVG9LtfB
         bTAC3lFRNxZfmnwVxIb23v3ORpHGfr3sUAOBI7NGtTLVpzS/33gfYRoK/rfEThoWWI27
         URRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833417; x=1748438217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cYgvyteFUsDXg+ceLCjMI2UWdgFf/NgcDDOuU7Imm8=;
        b=OhKitthchX4xExpA3Xym36a6ETOgY6QZrovWeHcr7xPZAW8Oo1+GgAWOA3/bVtJbx5
         +UPzrmxg0e/72eTTYeT+MbmW33yztYd+gRS8BLYMTyppIRI7er+hy6GQVwa87UupHUcE
         4NCijyl3vTSFLh9OlLQoi6qLsZIx34wsjRMAlRuE9wJaqafRUDem36Wuo0bJgcuRy9pY
         BFVaFHCu6XIKAC+Z+qfchtbonYdU4hHf3rZ3GMgZ+0x3KA3+E8nhqXgcjYMQA5l8ZS48
         Y8ntL/U9+FB08XHxWsKJr2+Ea+2uIuURelIATewuKi6v7256mU+wupQKyq8Jdf5RL37Q
         /vPA==
X-Forwarded-Encrypted: i=1; AJvYcCWL+NbIQvwMIkgMg0rWh12qQm8saPoOs8t+d9JWt+vpDYY3lB11cj+hCKdZv25JpBBc1rX2Wn3naAM+nMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSRLhE4mlnUMtK0eYdEQxnESsg922rvdVZ30PGMEOWrtZ9x6D
	jrRzYjUoNuQ+ly2cvsgSsTnUSlbyH2XhU4CXLiRkbWXraYZiiElbdIELqRy6VPrZ
X-Gm-Gg: ASbGnctdKX1ussmvJ7ZLuYAUopv3S0nXaqhoWEhuBzZK3t9QC8Ff31dTaki8O0uZN0d
	xfraP9rmqUkHFDO4+6PPeUR6kQSTPGoXdQYjkbY23vnEFaondvMcj6dgCgWlp/Qc5Tp/llOhdJK
	BwJlgiBLiYeZ3IKXj380rPZkSnac7Vj8URqFRDVmrAePC5y1FjN/XEUxieStpbqYJoEyOTiv43i
	ADDmbWDaE6TZez/1XxAZrEkx7M/R/PpjBMcJYM5wChaIwjH2cEZVZY9TV1fSA8NZS/o7UojDPmc
	rLYeg/iY494cOWLZfMPjPC/JYwAvy6HrxLJMdtPOuPPVihbKpZqJhIHZ9e7J7/rsrwlFbwbtjN+
	5PUWXKPUZ4wbJhosNttzSzvfbIXY=
X-Google-Smtp-Source: AGHT+IEivtc5dtn52yLZuRGBOCa9xzAJH8RadB2Uw1Xoob3rPki8A8YLhX1DkIkTXI+bI/7zg+cbTg==
X-Received: by 2002:a17:902:d4c3:b0:232:4f8c:1af9 with SMTP id d9443c01a7336-2324f8c1c69mr142772375ad.21.1747833417107;
        Wed, 21 May 2025 06:16:57 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adbfe1sm92901325ad.66.2025.05.21.06.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:16:56 -0700 (PDT)
Message-ID: <3016329a-4edd-4550-862f-b298a1b79a39@gmail.com>
Date: Wed, 21 May 2025 22:16:53 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] [rdma] RXE ODP test hangs with new DMA map API
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com>
Content-Language: en-US
In-Reply-To: <3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>    RDMA/umem: Store ODP access mask information in PFN

This one generates a build error. I modified manually and tried running the test.
It also hanged with ERROR:
```
$ ./build/bin/run_tests.py -v -k odp
test_odp_dc_traffic (tests.test_mlx5_dc.DCTest.test_odp_dc_traffic) ... skipped                                                                                                                                                              'Can not run the test over non MLX5 device'
test_devx_rc_qp_odp_traffic (tests.test_mlx5_devx.Mlx5DevxRcTrafficTest.test_dev                                                                                                                                                             x_rc_qp_odp_traffic) ... skipped 'Can not run the test over non MLX5 device'
test_odp_mkey_list_new_api (tests.test_mlx5_mkey.Mlx5MkeyTest.test_odp_mkey_list                                                                                                                                                             _new_api)
Create Mkeys above ODP MR, configure it with memory layout using the new API and                                                                                                                                                              ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_odp_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase.test_odp_async_pr                                                                                                                                                             efetch_rc_traffic) ... skipped 'Advise MR with flags (0) and advice (0) is not s                                                                                                                                                             upported'
test_odp_implicit_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase.test_odp                                                                                                                                                             _implicit_async_prefetch_rc_traffic) ... skipped 'ODP implicit is not supported'
test_odp_implicit_rc_traffic (tests.test_odp.OdpTestCase.test_odp_implicit_rc_tr                                                                                                                                                             affic) ... skipped 'ODP implicit is not supported'
test_odp_implicit_sync_prefetch_rc_traffic (tests.test_odp.OdpTestCase.test_odp_                                                                                                                                                             implicit_sync_prefetch_rc_traffic) ... skipped 'ODP implicit is not supported'
test_odp_prefetch_async_no_page_fault_rc_traffic (tests.test_odp.OdpTestCase.tes                                                                                                                                                             t_odp_prefetch_async_no_page_fault_rc_traffic) ... skipped 'Advise MR with flags                                                                                                                                                              (0) and advice (2) is not supported'
test_odp_prefetch_sync_no_page_fault_rc_traffic (tests.test_odp.OdpTestCase.test                                                                                                                                                             _odp_prefetch_sync_no_page_fault_rc_traffic) ... skipped 'Advise MR with flags (                                                                                                                                                             1) and advice (2) is not supported'
test_odp_qp_ex_rc_atomic_write (tests.test_odp.OdpTestCase.test_odp_qp_ex_rc_ato                                                                                                                                                             mic_write) ... ERROR


```

Here are the stack of the process:
```
[<0>] rxe_ib_invalidate_range+0x3e/0xa0 [rdma_rxe]
[<0>] __mmu_notifier_invalidate_range_start+0x197/0x200
[<0>] unmap_vmas+0x184/0x190
[<0>] vms_clear_ptes+0x12c/0x190
[<0>] vms_complete_munmap_vmas+0x83/0x1d0
[<0>] do_vmi_align_munmap+0x17f/0x1b0
[<0>] do_vmi_munmap+0xd3/0x190
[<0>] __vm_munmap+0xbb/0x190
[<0>] __x64_sys_munmap+0x1b/0x30
[<0>] x64_sys_call+0x1ea8/0x2660
[<0>] do_syscall_64+0x7e/0x170
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
```
I think this one is related to umem mutex.

So it looks there are two problems:
The stuck issue in rxe_ib_invalidate_range() comes from "RDMA/umem: Store ODP access mask information in PFN",
and the stuck issue in uverbs_destroy_ufile_hw() derives from "RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage".

I'd welcome your help in fixing them.

Thanks,
Daisuke

On 2025/05/21 21:48, Daisuke Matsuda wrote:
> Hi,
> 
> After these two patches are merged to the for-next tree, RXE ODP test always hangs:
>    RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage
>    RDMA/umem: Store ODP access mask information in PFN
> cf. https://lore.kernel.org/linux-rdma/cover.1745831017.git.leon@kernel.org/
> 
> Here is the console log:
> ```
> $ ./build/bin/run_tests.py -v -k odp
> test_odp_dc_traffic (tests.test_mlx5_dc.DCTest.test_odp_dc_traffic) ... skipped 'Can not run the test over non MLX5 device'
> test_devx_rc_qp_odp_traffic (tests.test_mlx5_devx.Mlx5DevxRcTrafficTest.test_devx_rc_qp_odp_traffic) ... skipped 'Can not run the test over non MLX5 device'
> test_odp_mkey_list_new_api (tests.test_mlx5_mkey.Mlx5MkeyTest.test_odp_mkey_list_new_api)
> Create Mkeys above ODP MR, configure it with memory layout using the new API and ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
> test_odp_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase.test_odp_async_prefetch_rc_traffic) ...
> 
> 
> ```
> 
> It looks that the python process is somehow stuck in uverbs_destroy_ufile_hw():
> ```
> $ sudo cat /proc/1845/task/1845/stack
> [<0>] uverbs_destroy_ufile_hw+0x24/0x100 [ib_uverbs]
> [<0>] ib_uverbs_close+0x1b/0xc0 [ib_uverbs]
> [<0>] __fput+0xea/0x2d0
> [<0>] ____fput+0x15/0x20
> [<0>] task_work_run+0x5d/0xa0
> [<0>] do_exit+0x316/0xa50
> [<0>] make_task_dead+0x81/0x160
> [<0>] rewind_stack_and_make_dead+0x16/0x20
> ```
> 
> I am not sure about the root cause but hope we can fix this before the next merge window.
> 
> Thanks,
> Daisuke


