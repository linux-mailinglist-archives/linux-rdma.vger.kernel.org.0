Return-Path: <linux-rdma+bounces-2385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267078C1C2C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 03:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3751283A05
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19013B780;
	Fri, 10 May 2024 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwm3Dg53"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3113B5A5
	for <linux-rdma@vger.kernel.org>; Fri, 10 May 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715305329; cv=none; b=lrhsFnZ9PYt0YLVQdc9kxDrJXU9WUibfX39CK6nkhNvXeikYoWHOv+ZT8gVjNKRyE8mmpGvKaz1ybbxIZWeVGE0cchakXmlU3DRgSwEopfUiZpu09nI6Emq62N3uPsoHzzcfcINec1UNzicYE0oBhSz9HQiQsCnIKtpco8foShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715305329; c=relaxed/simple;
	bh=4YUPFZM06XsrWIyoCOXnbsSY9Hm9KYAayxdloL7QEhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWyx9vJWzlqbAyKV1WGwDqrM3YmJFruT9mjc+pQlSy2KswS0lyBj7pkeu1+6STeyFwPFWGasnla9iFknvJIWRwteN8wazsLPpQEGY4MKgYQuYl+hLwWsh0Ld8ovz/f/29fr2T55OHf6uKzyi5zxNEFn3kuGX4SavpvXjNPgkA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwm3Dg53; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715305325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Frtf/yOv7MDf4F0f2Eq8Gy9rg9rn+YekiZOilac1Fa0=;
	b=hwm3Dg53IrBTLQB3kjAUmW7Ttg52iN1PtpSFNLTzH7MZONOJBapdOnyxbuAsVKQ7OidWXc
	wSUHO26BwC7v1SRBe8WQprxD52UaUvoRX+w2si3IBxMLziipOIBET+UH3NyHsGCZUdzOhw
	MqnUMpwWZbhMv4fXIpbjn5xgSIG1UCI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-2kL8ah8dP8-IoiA9r1ApGQ-1; Thu, 09 May 2024 21:42:04 -0400
X-MC-Unique: 2kL8ah8dP8-IoiA9r1ApGQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b364c4c4b0so1413503a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2024 18:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715305323; x=1715910123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frtf/yOv7MDf4F0f2Eq8Gy9rg9rn+YekiZOilac1Fa0=;
        b=t4kDlwQ7e29aVQDK8W5wsB82nO7CNsG/YRJQ28ljQYqKMzneifR9W9LrdMFf3MJaWC
         CuGWJZR/LHq1M69OEvLjLhuwbA13yYIq106chC+0hiGifb5pefwrPkhabMZIInVEz/VP
         6otPkDw/lRsNaKZRkqqxMX3ceMPBSGW5+3DL39HfM6BBYE9Wup8xQFn7byh7gGfGvpIf
         LoNDyCv2ysGIkZZuMpbd6xps1IC2r/q6DCWrmHa/3Ml8f1kiP8iGyg+ncUNhU6UmPO21
         1Q0XjfLhUBzfgQQntEdhCi66FsYoYBM5NYV74pR2MubWaS1RjLAr6TIOGTUMrlL9rV9n
         0/bA==
X-Forwarded-Encrypted: i=1; AJvYcCX7RmNy/34yLb3FHb/OcsTt68IeX3ojyGZoY0BHCfV+D8bN7kxiThzomAIzVawF1V85cNkj49jVY3YixX9ltnG8K0XNDDPHOiEYhQ==
X-Gm-Message-State: AOJu0YxGTX5w0szVaEfuXqVXWzx3lc600g9xHaadZCy12uymnpDBOL13
	w/p+SjHxg/Cs2tiOrM5JiV57pGlwyTEXjnTY8EKr6oVt5VlwAkMaANhA5Uk5kZATc6uu+vxVk6H
	cpUIttutF6BS+8IM1LAuiuhlu4yb4mhfPp3SK3YgS9t2GLaSBNcbVkSh5zUTzj3EdHrkFbPXqNn
	KqnVHPxw5YFA0j9F4ejMPQTOmEJYPSGqvmiA==
X-Received: by 2002:a17:90a:6d8f:b0:2b3:90ab:fb9 with SMTP id 98e67ed59e1d1-2b6cd1e7570mr1234044a91.49.1715305322823;
        Thu, 09 May 2024 18:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqFZqRIK7y1DyoVN2epPRbNTMOTzK8TRVPUn0sDls4ytVvbo+mJi4HeoMM8tQgnv2o7Vsmd2nFqBabRkPJjH8=
X-Received: by 2002:a17:90a:6d8f:b0:2b3:90ab:fb9 with SMTP id
 98e67ed59e1d1-2b6cd1e7570mr1234027a91.49.1715305322352; Thu, 09 May 2024
 18:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
 <7de9793f-6805-1412-3fae-a5508910124b@linux.dev> <CAHj4cs-RiZXAdz131ihQ=wsW8nsViphJeHAD_i6qi7_DtW7NwQ@mail.gmail.com>
 <CAHj4cs-HWjMq__89RR1WwLcOa5H46H8+d2t=jj=qFJ_m5kRwFQ@mail.gmail.com>
 <c9e68631-0e60-578d-e88d-23e1f9d8eb2f@linux.dev> <CAHj4cs99vDgjfA8So4dd7UW04+rie65Uy=jVTWheU0JY=H4R8g@mail.gmail.com>
 <54eea59a-efcd-c281-e998-033c6df81a28@linux.dev> <CAHj4cs9xwzrhRPoZ2t69b6F2JL8X9mZNVmwBfW2y5g7ZdbR8vg@mail.gmail.com>
 <CAHj4cs-mz5Dh6WrqB3PzoV89YaMTHrt9PbJv_4ofQD2r0BktTw@mail.gmail.com> <9eb4ed5e-0872-40fd-ab96-e210463d82ee@linux.dev>
In-Reply-To: <9eb4ed5e-0872-40fd-ab96-e210463d82ee@linux.dev>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 10 May 2024 09:41:47 +0800
Message-ID: <CAHj4cs9nRtM4Dsh=ciSBS4OMx26T7EsccE13G6sEXUG+963OPQ@mail.gmail.com>
Subject: Re: [bug report][bisected] kmemleak in rdma_core observed during
 blktests nvme/rdma use siw
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>, RDMA mailing list <linux-rdma@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com, 
	chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 11:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2024/5/8 15:08, Yi Zhang =E5=86=99=E9=81=93:
> > So bisect shows it was introduced with below commit, please help check
> > and fix it, thanks.
> >
> > commit f8ef1be816bf9a0c406c696368c2264a9597a994
> > Author: Chuck Lever <chuck.lever@oracle.com>
> > Date:   Mon Jul 17 11:12:32 2023 -0400
> >
> >      RDMA/cma: Avoid GID lookups on iWARP devices
>
> Not sure if the following can fix this problem or not.
> Please let me know the test result.
> Thanks a lot.

Hi Yanjun

Seems the change introduced new issue, here is the log:

[ 3017.171697] run blktests nvme/003 at 2024-05-09 21:35:41
[ 3032.344539] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3032.351780] BUG: KASAN: slab-use-after-free in
rdma_put_gid_attr+0x23/0xa0 [ib_core]
[ 3032.359659] Write of size 4 at addr ffff88813c1c3f00 by task kworker/27:=
1/370
[ 3032.366791]
[ 3032.368293] CPU: 27 PID: 370 Comm: kworker/27:1 Not tainted
6.9.0-rc2.rdma.fix+ #1
[ 3032.375859] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[ 3032.383425] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdm=
a]
[ 3032.390304] Call Trace:
[ 3032.392757]  <TASK>
[ 3032.394864]  dump_stack_lvl+0x84/0xd0
[ 3032.398537]  ? rdma_put_gid_attr+0x23/0xa0 [ib_core]
[ 3032.403561]  print_report+0x19d/0x52e
[ 3032.407228]  ? rdma_put_gid_attr+0x23/0xa0 [ib_core]
[ 3032.412256]  ? __virt_addr_valid+0x228/0x420
[ 3032.416537]  ? rdma_put_gid_attr+0x23/0xa0 [ib_core]
[ 3032.421563]  kasan_report+0xab/0x180
[ 3032.425142]  ? rdma_put_gid_attr+0x23/0xa0 [ib_core]
[ 3032.430173]  kasan_check_range+0x104/0x1b0
[ 3032.434275]  rdma_put_gid_attr+0x23/0xa0 [ib_core]
[ 3032.439128]  ? cma_dev_put+0x1f/0x60 [rdma_cm]
[ 3032.443591]  cma_release_dev+0x1b2/0x270 [rdma_cm]
[ 3032.448401]  _destroy_id+0x35f/0xc80 [rdma_cm]
[ 3032.452867]  nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
[ 3032.458360]  nvmet_rdma_release_queue_work+0x42/0x90 [nvmet_rdma]
[ 3032.464460]  process_one_work+0x85d/0x13e0
[ 3032.468573]  ? worker_thread+0xcc/0x1130
[ 3032.472501]  ? __pfx_process_one_work+0x10/0x10
[ 3032.477038]  ? assign_work+0x16c/0x240
[ 3032.480797]  worker_thread+0x6da/0x1130
[ 3032.484648]  ? __pfx_worker_thread+0x10/0x10
[ 3032.488923]  kthread+0x2ed/0x3c0
[ 3032.492155]  ? _raw_spin_unlock_irq+0x28/0x60
[ 3032.496514]  ? __pfx_kthread+0x10/0x10
[ 3032.500267]  ret_from_fork+0x31/0x70
[ 3032.503854]  ? __pfx_kthread+0x10/0x10
[ 3032.507607]  ret_from_fork_asm+0x1a/0x30
[ 3032.511539]  </TASK>
[ 3032.513734]
[ 3032.515234] Allocated by task 1997:
[ 3032.518725]  kasan_save_stack+0x30/0x50
[ 3032.522562]  kasan_save_track+0x14/0x30
[ 3032.526402]  __kasan_kmalloc+0x8f/0xa0
[ 3032.530155]  add_modify_gid+0x18e/0xb80 [ib_core]
[ 3032.534922]  ib_cache_update.part.0+0x6fc/0x8e0 [ib_core]
[ 3032.540380]  ib_cache_setup_one+0x3ff/0x5f0 [ib_core]
[ 3032.545495]  ib_register_device+0x5ba/0xa20 [ib_core]
[ 3032.550607]  siw_newlink+0xb0d/0xe50 [siw]
[ 3032.554724]  nldev_newlink+0x301/0x520 [ib_core]
[ 3032.559404]  rdma_nl_rcv_msg+0x2e7/0x600 [ib_core]
[ 3032.564256]  rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
[ 3032.570756]  netlink_unicast+0x437/0x6e0
[ 3032.574679]  netlink_sendmsg+0x775/0xc10
[ 3032.578607]  __sys_sendto+0x3e5/0x490
[ 3032.582273]  __x64_sys_sendto+0xe0/0x1c0
[ 3032.586198]  do_syscall_64+0x9a/0x1a0
[ 3032.589862]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[ 3032.594917]
[ 3032.596416] Freed by task 339:
[ 3032.599475]  kasan_save_stack+0x30/0x50
[ 3032.603312]  kasan_save_track+0x14/0x30
[ 3032.607153]  kasan_save_free_info+0x3b/0x60
[ 3032.611338]  poison_slab_object+0x103/0x190
[ 3032.615523]  __kasan_slab_free+0x14/0x30
[ 3032.619450]  kfree+0x120/0x3a0
[ 3032.622508]  free_gid_work+0xd4/0x120 [ib_core]
[ 3032.627100]  process_one_work+0x85d/0x13e0
[ 3032.631200]  worker_thread+0x6da/0x1130
[ 3032.635038]  kthread+0x2ed/0x3c0
[ 3032.638271]  ret_from_fork+0x31/0x70
[ 3032.641849]  ret_from_fork_asm+0x1a/0x30
[ 3032.645777]
[ 3032.647277] Last potentially related work creation:
[ 3032.652153]  kasan_save_stack+0x30/0x50
[ 3032.655994]  __kasan_record_aux_stack+0x8e/0xa0
[ 3032.660525]  insert_work+0x36/0x310
[ 3032.664019]  __queue_work+0x6a4/0xcb0
[ 3032.667685]  queue_work_on+0x99/0xb0
[ 3032.671263]  cma_release_dev+0x1b2/0x270 [rdma_cm]
[ 3032.676072]  _destroy_id+0x35f/0xc80 [rdma_cm]
[ 3032.680537]  nvme_rdma_free_queue+0x4a/0x70 [nvme_rdma]
[ 3032.685768]  nvme_do_delete_ctrl+0x146/0x160 [nvme_core]
[ 3032.691108]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[ 3032.696707]  nvme_sysfs_delete+0x96/0xc0 [nvme_core]
[ 3032.701696]  kernfs_fop_write_iter+0x3a5/0x5b0
[ 3032.706142]  vfs_write+0x62e/0x1010
[ 3032.709636]  ksys_write+0xfb/0x1d0
[ 3032.713041]  do_syscall_64+0x9a/0x1a0
[ 3032.716707]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[ 3032.721760]
[ 3032.723259] The buggy address belongs to the object at ffff88813c1c3f00
[ 3032.723259]  which belongs to the cache kmalloc-rnd-07-192 of size 192
[ 3032.736370] The buggy address is located 0 bytes inside of
[ 3032.736370]  freed 192-byte region [ffff88813c1c3f00, ffff88813c1c3fc0)
[ 3032.748441]
[ 3032.749942] The buggy address belongs to the physical page:
[ 3032.755513] page: refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x13c1c2
[ 3032.763511] head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 3032.770212] flags:
0x17ffffe0000840(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x3fffff)
[ 3032.777604] page_type: 0xffffffff()
[ 3032.781097] raw: 0017ffffe0000840 ffff888100053c00 dead000000000122
0000000000000000
[ 3032.788837] raw: 0000000000000000 0000000080200020 00000001ffffffff
0000000000000000
[ 3032.796574] head: 0017ffffe0000840 ffff888100053c00
dead000000000122 0000000000000000
[ 3032.804400] head: 0000000000000000 0000000080200020
00000001ffffffff 0000000000000000
[ 3032.812225] head: 0017ffffe0000001 ffffea0004f07081
ffffea0004f070c8 00000000ffffffff
[ 3032.820050] head: 0000000200000000 0000000000000000
00000000ffffffff 0000000000000000
[ 3032.827874] page dumped because: kasan: bad access detected
[ 3032.833447]
[ 3032.834944] Memory state around the buggy address:
[ 3032.839737]  ffff88813c1c3e00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 3032.846958]  ffff88813c1c3e80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 3032.854177] >ffff88813c1c3f00: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 3032.861393]                    ^
[ 3032.864628]  ffff88813c1c3f80: fb fb fb fb fb fb fb fb fc fc fc fc
fc fc fc fc
[ 3032.871845]  ffff88813c1c4000: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[ 3032.879065] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3032.886311] Disabling lock debugging due to kernel taint
[ 3032.891630] ------------[ cut here ]------------
[ 3032.896255] refcount_t: underflow; use-after-free.
[ 3032.901104] WARNING: CPU: 27 PID: 370 at lib/refcount.c:28
refcount_warn_saturate+0xf2/0x150
[ 3032.909552] Modules linked in: siw ib_uverbs nvmet_rdma nvmet
nvme_keyring nvme_rdma nvme_fabrics nvme_core nvme_auth rdma_cm iw_cm
ib_cm ib_core intel_rapl_msr intel_rapl_coma
[ 3032.992273] CPU: 27 PID: 370 Comm: kworker/27:1 Tainted: G    B
         6.9.0-rc2.rdma.fix+ #1
[ 3033.001324] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[ 3033.008899] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdm=
a]
[ 3033.015787] RIP: 0010:refcount_warn_saturate+0xf2/0x150
[ 3033.021022] Code: 2f 1b 66 04 01 e8 6e f7 9c fe 0f 0b eb 91 80 3d
1e 1b 66 04 00 75 88 48 c7 c7 80 16 c5 91 c6 05 0e 1b 66 04 01 e8 4e
f7 9c fe <0f> 0b e9 6e ff ff ff 80 3d fe7
[ 3033.039775] RSP: 0018:ffffc9000e627c10 EFLAGS: 00010286
[ 3033.045019] RAX: 0000000000000000 RBX: ffff88813c1c3f00 RCX: 00000000000=
00000
[ 3033.052158] RDX: 0000000000000000 RSI: ffffffff91c5c760 RDI: 00000000000=
00001
[ 3033.059303] RBP: 0000000000000003 R08: 0000000000000001 R09: fffff52001c=
c4f36
[ 3033.066449] R10: ffffc9000e6279b7 R11: 0000000000000001 R12: ffff88a88f3=
94248
[ 3033.073588] R13: ffff888135750240 R14: ffff88825385fb80 R15: dead0000000=
00100
[ 3033.080730] FS:  0000000000000000(0000) GS:ffff88c7ad200000(0000)
knlGS:0000000000000000
[ 3033.088824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3033.094579] CR2: 00007fdfcb573c58 CR3: 0000000ea6e98004 CR4: 00000000007=
706f0
[ 3033.101720] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 3033.108859] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 3033.116001] PKRU: 55555554
[ 3033.118723] Call Trace:
[ 3033.121182]  <TASK>
[ 3033.123300]  ? __warn+0xcc/0x170
[ 3033.126548]  ? refcount_warn_saturate+0xf2/0x150
[ 3033.131176]  ? report_bug+0x1fc/0x3d0
[ 3033.134860]  ? handle_bug+0x3c/0x80
[ 3033.138368]  ? exc_invalid_op+0x17/0x40
[ 3033.142217]  ? asm_exc_invalid_op+0x1a/0x20
[ 3033.146428]  ? refcount_warn_saturate+0xf2/0x150
[ 3033.151056]  cma_release_dev+0x1b2/0x270 [rdma_cm]
[ 3033.155874]  _destroy_id+0x35f/0xc80 [rdma_cm]
[ 3033.160348]  nvmet_rdma_free_queue+0x7a/0x380 [nvmet_rdma]
[ 3033.165851]  nvmet_rdma_release_queue_work+0x42/0x90 [nvmet_rdma]
[ 3033.171958]  process_one_work+0x85d/0x13e0
[ 3033.176077]  ? worker_thread+0xcc/0x1130
[ 3033.180017]  ? __pfx_process_one_work+0x10/0x10
[ 3033.184561]  ? assign_work+0x16c/0x240
[ 3033.188332]  worker_thread+0x6da/0x1130
[ 3033.192187]  ? __pfx_worker_thread+0x10/0x10
[ 3033.196475]  kthread+0x2ed/0x3c0
[ 3033.199724]  ? _raw_spin_unlock_irq+0x28/0x60
[ 3033.204099]  ? __pfx_kthread+0x10/0x10
[ 3033.207860]  ret_from_fork+0x31/0x70
[ 3033.211447]  ? __pfx_kthread+0x10/0x10
[ 3033.215209]  ret_from_fork_asm+0x1a/0x30
[ 3033.219152]  </TASK>
[ 3033.221352] irq event stamp: 255979
[ 3033.224855] hardirqs last  enabled at (255979):
[<ffffffff9160160a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 3033.234863] hardirqs last disabled at (255978):
[<ffffffff91433f0a>] __do_softirq+0x75a/0x967
[ 3033.243391] softirqs last  enabled at (255766):
[<ffffffff8e269f56>] __irq_exit_rcu+0xc6/0x1d0
[ 3033.252015] softirqs last disabled at (255757):
[<ffffffff8e269f56>] __irq_exit_rcu+0xc6/0x1d0
[ 3033.260637] ---[ end trace 0000000000000000 ]---

>
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 1e2cd7c8716e..901e6c40d560 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -715,9 +715,13 @@ cma_validate_port(struct ib_device *device, u32 port=
,
>                  rcu_read_lock();
>                  ndev =3D rcu_dereference(sgid_attr->ndev);
>                  if (!net_eq(dev_net(ndev), dev_addr->net) ||
> -                   ndev->ifindex !=3D bound_if_index)
> +                   ndev->ifindex !=3D bound_if_index) {
> +                       rdma_put_gid_attr(sgid_attr);
>                          sgid_attr =3D ERR_PTR(-ENODEV);
> +               }
>                  rcu_read_unlock();
> +               if (!IS_ERR(sgid_attr))
> +                       rdma_put_gid_attr(sgid_attr);
>                  goto out;
>          }
> Zhu Yanjun
>
> >
> > On Tue, Apr 30, 2024 at 7:51=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> =
wrote:
> >>
> >> On Mon, Apr 29, 2024 at 8:54=E2=80=AFAM Guoqing Jiang <guoqing.jiang@l=
inux.dev> wrote:
> >>>
> >>>
> >>>
> >>> On 4/28/24 20:42, Yi Zhang wrote:
> >>>> On Sun, Apr 28, 2024 at 10:54=E2=80=AFAM Guoqing Jiang <guoqing.jian=
g@linux.dev> wrote:
> >>>>>
> >>>>>
> >>>>> On 4/26/24 16:44, Yi Zhang wrote:
> >>>>>> On Fri, Apr 26, 2024 at 1:56=E2=80=AFPM Yi Zhang <yi.zhang@redhat.=
com> wrote:
> >>>>>>> On Wed, Apr 24, 2024 at 9:28=E2=80=AFPM Guoqing Jiang <guoqing.ji=
ang@linux.dev> wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> On 4/8/24 14:03, Yi Zhang wrote:
> >>>>>>>>> Hi
> >>>>>>>>> I found the below kmemleak issue during blktests nvme/rdma on t=
he
> >>>>>>>>> latest linux-rdma/for-next, please help check it and let me kno=
w if
> >>>>>>>>> you need any info/testing for it, thanks.
> >>>>>>>> Could you share which test case caused the issue? I can't reprod=
uce
> >>>>>>>> it with 6.9-rc3+ kernel (commit 586b5dfb51b) with the below.
> >>>>>>> It can be reproduced by [1], you can find more info from the symb=
ol
> >>>>>>> info[2], I also attached the config file, maybe you can this conf=
ig
> >>>>>>> file
> >>>>>> Just attached the config file
> >>>>>>
> >>>>> I tried with the config, but still unlucky.
> >>>>>
> >>>>> # nvme_trtype=3Drdma ./check nvme/012
> >>>>> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> >>>>> device-backed ns)
> >>>>> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> >>>>> device-backed ns) [passed]
> >>>>>        runtime  52.763s  ...  392.027s device: nvme0
> >>>>>
> >>>>>>> [1] nvme_trtype=3Drdma ./check nvme/012
> >>>>>>> [2]
> >>>>>>> unreferenced object 0xffff8883a87e8800 (size 192):
> >>>>>>>      comm "rdma", pid 2355, jiffies 4294836069
> >>>>>>>      hex dump (first 32 bytes):
> >>>>>>>        32 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  2........=
.......
> >>>>>>>        10 88 7e a8 83 88 ff ff 10 88 7e a8 83 88 ff ff  ..~......=
.~.....
> >>>>>>>      backtrace (crc 4db191c4):
> >>>>>>>        [<ffffffff8cd251bd>] kmalloc_trace+0x30d/0x3b0
> >>>>>>>        [<ffffffffc207eff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> >>>>>>>        [<ffffffffc2080206>] add_modify_gid+0x166/0x930 [ib_core]
> >>>>>>>        [<ffffffffc2081468>] ib_cache_update.part.0+0x6d8/0x910 [i=
b_core]
> >>>>>>>        [<ffffffffc2082e1a>] ib_cache_setup_one+0x24a/0x350 [ib_co=
re]
> >>>>>>>        [<ffffffffc207749e>] ib_register_device+0x9e/0x3a0 [ib_cor=
e]
> >>>>>>>        [<ffffffffc24ac389>] 0xffffffffc24ac389
> >>>>>>>        [<ffffffffc20c6cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
> >>>>>>>        [<ffffffffc2083fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
> >>>>>>>        [<ffffffffc208448c>]
> >>>>>>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> >>>>>>>        [<ffffffff8e30e715>] netlink_unicast+0x445/0x710
> >>>>>>>        [<ffffffff8e30f151>] netlink_sendmsg+0x761/0xc40
> >>>>>>>        [<ffffffff8e09da89>] __sys_sendto+0x3a9/0x420
> >>>>>>>        [<ffffffff8e09dbec>] __x64_sys_sendto+0xdc/0x1b0
> >>>>>>>        [<ffffffff8e9afad3>] do_syscall_64+0x93/0x180
> >>>>>>>        [<ffffffff8ea00126>] entry_SYSCALL_64_after_hwframe+0x71/0=
x79
> >>>>>>>
> >>>>>>> (gdb) l *(alloc_gid_entry+0x47)
> >>>>>>> 0x2eff7 is in alloc_gid_entry (./include/linux/slab.h:628).
> >>>>>>> 623
> >>>>>>> 624 if (size > KMALLOC_MAX_CACHE_SIZE)
> >>>>>>> 625 return kmalloc_large(size, flags);
> >>>>>>> 626
> >>>>>>> 627 index =3D kmalloc_index(size);
> >>>>>>> 628 return kmalloc_trace(
> >>>>>>> 629 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> >>>>>>> 630 flags, size);
> >>>>>>> 631 }
> >>>>>>> 632 return __kmalloc(size, flags);
> >>>>>>>
> >>>>>>> (gdb) l *(add_modify_gid+0x166)
> >>>>>>> 0x30206 is in add_modify_gid (drivers/infiniband/core/cache.c:447=
).
> >>>>>>> 442 * empty table entries instead of storing them.
> >>>>>>> 443 */
> >>>>>>> 444 if (rdma_is_zero_gid(&attr->gid))
> >>>>>>> 445 return 0;
> >>>>>>> 446
> >>>>>>> 447 entry =3D alloc_gid_entry(attr);
> >>>>>>> 448 if (!entry)
> >>>>>>> 449 return -ENOMEM;
> >>>>>>> 450
> >>>>>>> 451 if (rdma_protocol_roce(attr->device, attr->port_num)) {
> >>>>>>>
> >>>>>>>
> >>>>>>>> use_siw=3D1 nvme_trtype=3Drdma ./check nvme/
> >>>>>>>>
> >>>>>>>>> # dmesg | grep kmemleak
> >>>>>>>>> [   67.130652] kmemleak: Kernel memory leak detector initialize=
d (mem
> >>>>>>>>> pool available: 36041)
> >>>>>>>>> [   67.130728] kmemleak: Automatic memory scanning thread start=
ed
> >>>>>>>>> [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
> >>>>>>>>> /sys/kernel/debug/kmemleak)
> >>>>>>>>> [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
> >>>>>>>>> /sys/kernel/debug/kmemleak)
> >>>>>>>>> [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
> >>>>>>>>> /sys/kernel/debug/kmemleak)
> >>>>>>>>> [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
> >>>>>>>>> /sys/kernel/debug/kmemleak)
> >>>>>>>>>
> >>>>>>>>> unreferenced object 0xffff88855da53400 (size 192):
> >>>>>>>>>       comm "rdma", pid 10630, jiffies 4296575922
> >>>>>>>>>       hex dump (first 32 bytes):
> >>>>>>>>>         37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7.....=
..........
> >>>>>>>>>         10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.]..=
...4.]....
> >>>>>>>>>       backtrace (crc 47f66721):
> >>>>>>>>>         [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
> >>>>>>>>>         [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_cor=
e]
> >>>>>>>>>         [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_cor=
e]
> >>>>>>>> I guess add_modify_gid is called from config_non_roce_gid_cache,=
 not sure
> >>>>>>>> why we don't check the return value of it here.
> >>>>>>>>
> >>>>>>>> Looks put_gid_entry is called in case add_modify_gid returns fai=
lure, it
> >>>>>>>> would
> >>>>>>>> trigger schedule_free_gid -> queue_work(ib_wq, &entry->del_work)=
, then
> >>>>>>>> free_gid_work -> free_gid_entry_locked would free storage asynch=
ronously by
> >>>>>>>> put_gid_ndev and also entry.
> >>>>>>>>
> >>>>>>>>>         [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910=
 [ib_core]
> >>>>>>>>>         [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib=
_core]
> >>>>>>>>>         [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_=
core]
> >>>>>>>>>         [<ffffffffc2a3d389>] 0xffffffffc2a3d389
> >>>>>>>>>         [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core=
]
> >>>>>>>>>         [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_co=
re]
> >>>>>>>>>         [<ffffffffc264648c>]
> >>>>>>>>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> >>>>>>>>>         [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
> >>>>>>>>>         [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
> >>>>>>>>>         [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
> >>>>>>>>>         [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
> >>>>>>>>>         [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
> >>>>>>>>>         [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x7=
1/0x79
> >>>>>>>> After ib_cache_setup_one failed, maybe ib_cache_cleanup_one is n=
eeded
> >>>>>>>> which flush ib_wq to ensure storage is freed. Could you try with=
 the change?
> >>>>>>> Will try it later.
> >>>>>>>
> >>>>>> The kmemleak still can be reproduced with this change:
> >>>>>>
> >>>>>> unreferenced object 0xffff8881f89fde00 (size 192):
> >>>>>>      comm "rdma", pid 8708, jiffies 4295703453
> >>>>>>      hex dump (first 32 bytes):
> >>>>>>        02 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  ..........=
......
> >>>>>>        10 de 9f f8 81 88 ff ff 10 de 9f f8 81 88 ff ff  ..........=
......
> >>>>>>      backtrace (crc 888c494b):
> >>>>>>        [<ffffffffa7d251bd>] kmalloc_trace+0x30d/0x3b0
> >>>>>>        [<ffffffffc1efeff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> >>>>>>        [<ffffffffc1f00206>] add_modify_gid+0x166/0x930 [ib_core]
> >>>>>>        [<ffffffffc1f01468>] ib_cache_update.part.0+0x6d8/0x910 [ib=
_core]
> >>>>>>        [<ffffffffc1f02e1a>] ib_cache_setup_one+0x24a/0x350 [ib_cor=
e]
> >>>>>>        [<ffffffffc1ef749e>] ib_register_device+0x9e/0x3a0 [ib_core=
]
> >>>>>>        [<ffffffffc22ee389>]
> >>>>>> siw_qp_state_to_ib_qp_state+0x28a9/0xfffffffffffd1520 [siw]
> >>>>> Is it possible to run the test with rxe instead of siw? In case it =
is
> >>>>> only happened
> >>>>> with siw, I'd suggest to revert 0b988c1bee28 to check if it causes =
the
> >>>>> issue.
> >>>>> But I don't understand why siw_qp_state_to_ib_qp_state was appeared=
 in the
> >>>>> middle of above trace.
> >>>> Hi Guoqing
> >>>> This issue only can be reproduced with siw, I did more testing today
> >>>> and it cannot be reproduced with 6.5, seems it was introduced from
> >>>> 6.6-rc1, and I saw there are some siw updates from 6.6-rc1.
> >>>
> >>> Yes, pls bisect them.
> >>
> >> Sure, will do that after I back from holiday next week.
> >>
> >>>
> >>>   > git log --oneline v6.5..v6.6-rc1 drivers/infiniband/sw/siw/|cat
> >>> 9dfccb6d0d3d RDMA/siw: Call llist_reverse_order in siw_run_sq
> >>> bee024d20451 RDMA/siw: Correct wrong debug message
> >>> b056327bee09 RDMA/siw: Balance the reference of cep->kref in the erro=
r path
> >>> 91f36237b4b9 RDMA/siw: Fix tx thread initialization.
> >>> bad5b6e34ffb RDMA/siw: Fabricate a GID on tun and loopback devices
> >>> 9191df002926 RDMA/siw: use vmalloc_array and vcalloc
> >>>
> >>> Thanks,
> >>> Guoqing
> >>>
> >>
> >>
> >> --
> >> Best Regards,
> >>    Yi Zhang
> >
> >
> >
>


--=20
Best Regards,
  Yi Zhang


