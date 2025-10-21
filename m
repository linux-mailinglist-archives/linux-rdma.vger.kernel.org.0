Return-Path: <linux-rdma+bounces-13953-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDC4BF45F4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 04:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BE318C5CD5
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 02:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5D27466D;
	Tue, 21 Oct 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1QLicTg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EBC4AEE2
	for <linux-rdma@vger.kernel.org>; Tue, 21 Oct 2025 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013241; cv=none; b=kjod/I5Y5zy25G5tzRrjS/Mdd3zD2qo4v21ww0bTfmE68aiobrj1dLtgZMwaB74OpT+AQuHgPl8rSOmUEPZktG9AtAtEOHfdX+/2NKeqFE75caIvTGyRyDGlcQhLBFmpan4hxIE6aygk0ks+TZO1YzHDsFJBMH2EJUo/nTeli7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013241; c=relaxed/simple;
	bh=sYHUeg0x+Xiq/w7gnn08t+214WQJlGw2JCDLj3a1Iac=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gA+OCY3z/JwYtEipZRRF1dzlwX+Vzsa3kg+slb+WmYDnV5EtqfNaYLbhCqLpy4ooHIcuqBBAIOe49V1tTCpOyEzVEwynrMHp06j3DbgJk3XqMZWtMcqs3+tN6BmviiaYW9MrbL8P2KbbIJVDO0Bvl6NvQPnC43AEQeK779iMnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1QLicTg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso892571866b.0
        for <linux-rdma@vger.kernel.org>; Mon, 20 Oct 2025 19:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761013238; x=1761618038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sYHUeg0x+Xiq/w7gnn08t+214WQJlGw2JCDLj3a1Iac=;
        b=I1QLicTguwFKz1bWVXAlnO1foxOvSaV3eeD6AHksAY4yFjcqinAVdRnUWDpggrfWsJ
         sE1H7tNIJFK+b9Tgv3J4KbYvpc/2yqQ0iwHQxE2PCUH/VGSAbwfo6Naw9IFTD+zjG4Eq
         18oluStf4X1h1T5ItfHMXkK6eGmsBUeA7JrnK+RGPNbfKDkosRC8JMzvz3bGi5QEsCWp
         EVYM4hWvGLXosil6IxYOHLLGVM9HGCWloOqr9Tdl3kYbg1hZY5dkDykUz3zrQgR313xH
         zQGK0hSL4rnNxvZLNWRxd91DseryJgSHioN4nW5y7V8qw2oz9xkM0rlwfnmWrT6Y2mem
         fIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761013238; x=1761618038;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYHUeg0x+Xiq/w7gnn08t+214WQJlGw2JCDLj3a1Iac=;
        b=w+MnKG6vF0LIRYQ4YzRGlZe2R63iIsFo0QWh5jSR1n9jj9/ldtqyY1yiXApg0bneN6
         uYB3h1nFW8bRqrZxtXU6PUJiLrwRjWhaMOVRt1KmhXudPrc9vtCc6dK6AAqlDf8nRi0M
         E6Ih8UCnAj/GCUtpf8YHyWRBRkC5hKM1V/smueG5cm293zLkRt67FbNanL19k2dZkf5R
         eGLe7v1csgEmIJaLOMiUo8hmSkHIUO7n9KYSC2jCXhz32Apy6xiHKsv/vN2fvM2LsbSq
         GZv8ZBo+gSSL3pSIEfOlyRDdePwXIXFFa0L0E1oVHEwYnslhmICMuBuBmEBxMR0+OMOx
         FIeg==
X-Gm-Message-State: AOJu0Yx1tIV50N5axaZaT8aJjTRn3/pnkh+i/2dAoUnTjVed/xok/vUP
	+2KASE2ykrHOLpzzzvJxnGSHBLv9GSr1KujxxKDuvHWTH/YQ/k0F5G/EkEIT+eybFgzWE2MQAqu
	lc/1kfRGPNsZ3FWyn7xUu728k5olrlmT2hewHnXI7YWnr
X-Gm-Gg: ASbGncv5qbNIcwzPwbf7wpzqNJjRRjrdaSsMBM3YfuYvjk1jNZmiV+RDPNE207iHCUw
	vB8iANUarfPM/mGHlEtKVu0grEuKjwY3NMIGEN5ekbM+wH63WX5S4RawpfhSejtbeqzKqAz+uod
	+kEnZmAq0YjMXFy56fx923Ih+FF3UhrRHWx5wCpIH7oTctGW59eWnlHWVMmr5HvVD1jGOgvJUm6
	jc2u19YaeX02e12cs3vK2x6jq87OALdc7V6UK1hXNbJwYvlfgsEnDWHHkqJ1DKpQwkZuAw=
X-Google-Smtp-Source: AGHT+IGjYwbO1cpeqL6ONHFril9H4mz1ScfflJWN7eNg4J3jZucfP/heoCo3JXx3H8VSSZg8r/LjmNdkIT1le4PJU+M=
X-Received: by 2002:a17:907:7241:b0:b58:98ca:f32f with SMTP id
 a640c23a62f3a-b6472a6a151mr1817260366b.16.1761013237641; Mon, 20 Oct 2025
 19:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Liu <asatsuyu.liu@gmail.com>
Date: Tue, 21 Oct 2025 10:20:26 +0800
X-Gm-Features: AS18NWAHwi5P3RJlj8EW-Es4DJaikdVzUgtby1_vugiaKpfqfjGjSglL70CBGHU
Message-ID: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
Subject: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize failure
To: linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"leon@kernel.org" <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A NULL pointer dereference can occur in rxe_srq_chk_attr() when
ibv_modify_srq() is invoked twice in succession under certain error
conditions. The first call may fail in rxe_queue_resize(), which leads
rxe_srq_from_attr() to set srq->rq.queue = NULL. The second call then
triggers a crash (null deref) when accessing
srq->rq.queue->buf->index_mask.

Call Trace:
<TASK>
rxe_modify_srq+0x170/0x480 [rdma_rxe]
? __pfx_rxe_modify_srq+0x10/0x10 [rdma_rxe]
? uverbs_try_lock_object+0x4f/0xa0 [ib_uverbs]
? rdma_lookup_get_uobject+0x1f0/0x380 [ib_uverbs]
ib_uverbs_modify_srq+0x204/0x290 [ib_uverbs]
? __pfx_ib_uverbs_modify_srq+0x10/0x10 [ib_uverbs]
? tryinc_node_nr_active+0xe6/0x150
? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x2c0/0x470 [ib_uverbs]
? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
ib_uverbs_run_method+0x55a/0x6e0 [ib_uverbs]
? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
ib_uverbs_cmd_verbs+0x54d/0x800 [ib_uverbs]
? __pfx_ib_uverbs_cmd_verbs+0x10/0x10 [ib_uverbs]
? __pfx___raw_spin_lock_irqsave+0x10/0x10
? __pfx_do_vfs_ioctl+0x10/0x10
? ioctl_has_perm.constprop.0.isra.0+0x2c7/0x4c0
? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
ib_uverbs_ioctl+0x13e/0x220 [ib_uverbs]
? __pfx_ib_uverbs_ioctl+0x10/0x10 [ib_uverbs]
__x64_sys_ioctl+0x138/0x1c0
do_syscall_64+0x82/0x250
? fdget_pos+0x58/0x4c0
? ksys_write+0xf3/0x1c0
? __pfx_ksys_write+0x10/0x10
? do_syscall_64+0xc8/0x250
? __pfx_vm_mmap_pgoff+0x10/0x10
? fget+0x173/0x230
? fput+0x2a/0x80
? ksys_mmap_pgoff+0x224/0x4c0
? do_syscall_64+0xc8/0x250
? do_user_addr_fault+0x37b/0xfe0
? clear_bhb_loop+0x50/0xa0
? clear_bhb_loop+0x50/0xa0
? clear_bhb_loop+0x50/0xa0
entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix by aligning the error handling path in rxe_srq_from_attr() with
rxe_cq_resize_queue(), which also uses rxe_queue_resize(): do not
nullify the queue when resize fails.

Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
Link: https://paste.ubuntu.com/p/Zhj65q6gr9/
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Tested-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
drivers/infiniband/sw/rxe/rxe_srq.c | 2 --
1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c
b/drivers/infiniband/sw/rxe/rxe_srq.c
index 3661cb627d28..2764dc00e2f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -182,8 +182,6 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct
rxe_srq *srq,
return 0;

err_free:
- rxe_queue_cleanup(q);
- srq->rq.queue = NULL;
return err;
}

--
2.34.1

