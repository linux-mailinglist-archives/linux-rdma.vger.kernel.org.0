Return-Path: <linux-rdma+bounces-2348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92528BFE07
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F6E1F22731
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15456A33F;
	Wed,  8 May 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emxyk0V5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39326AFF
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173727; cv=none; b=cdo7llXGOgc0dBwWE1gpJirBkUoME1bvBlu+mmOyrCaA4lysgOZI/EO7xcRDxX8GZca/o+nr5qeo1oFr3SWT1fgfneBI96H8TIXQZf61sOSjhxZKRAXsEfSvcGTSlvyQ93R7dwVCnTp45PPkVRfHJWJ4VatVDpn1GuKJB26W1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173727; c=relaxed/simple;
	bh=kpX9ogTdQlCyqilL+DU2NGIKkOGWHLuEhhLVWjihotI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCTwqfFgHO/Nnn40NmhBychJ1aLyDgvIlGdpIH/ZtrQQiEC3fxZ3hV9iYaLrMQMHov6EnDaxM25OcjX6UMBf+JzStKUjesYOD4/Ygbr4+i6pSDz4vPOBaTLmh9Xdvp5p50uxu4ikOsdWb+JTywXlWU8AotSTBwLRYubwjqMW5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emxyk0V5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715173724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gjVw9AUzSvIkTUDAi8No1m8xPpF/yi4R/5IBsjq4hc=;
	b=emxyk0V5QQsKX808ojkBLR9n6dzHVINh4dF9fQg5lMcV6PfMO0CSLcR9Nmq40whcGD/iM5
	g7JiSE9luM0W2zAgYvCwQoGQlF1bsqeFVWzvIT1l4HbuyvmqUG19Q0QHyULvx9xYJYcg0j
	jJtbdkPPfJLXPdp64IgvK5uUpwJYPGs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-55vZnbqINEGPBCD5D1-e0w-1; Wed, 08 May 2024 09:08:43 -0400
X-MC-Unique: 55vZnbqINEGPBCD5D1-e0w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a473ba0632so4609706a91.0
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2024 06:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715173722; x=1715778522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gjVw9AUzSvIkTUDAi8No1m8xPpF/yi4R/5IBsjq4hc=;
        b=WjjTS1+JOE5+9PHv2oe/mR44E31mv6AS3tCWpx+sRdqkjZFIn9cvWuLZqzkzPrfPNU
         gh7uYBHvvCCLWO3kCsxnVkJDAPPI6VOW+Uekn6YOVaBl/1jynqYmCv3dZ11jRb7J4Z8S
         VdujcD3aftM/bL2Fi4+/X/PPn1VDJ2RbxMJ9gLO6VtEjh/GtNFEzBJU4jFptlbsZ6wpt
         jBI3vNuNItah7HLLMrNmqZ9RdJ1I6kpLXCQNH5wx/KVa97Y4FdCEandcTxV+K7kDfT0H
         isSGZT6J71m14cmFJFOxCsy5aOHHO7jxfjbL2iYzBXm+16Am+1cnh4revcfCrE4kfXxa
         vQNg==
X-Gm-Message-State: AOJu0YxEJtFRmxRk570xVPRFfe84IRfPw2PYX69Iw/WUR0pdFgnR1nqV
	NDfKXlINOe3PHzls4m6y59bLaB6FV6XhWuaA48UHYR4grro9B7zzKdNxWQJDrUKd/3s1ckNyJ5s
	StfLEBvCrWSxZHuV3/HstR7kr98rFvRg365LXVrEQbTxmEnc7Ju1lx0AgnwsBLRonPcmAKOsSni
	FjYIGEcxHMiskDqVSSlDnkwAdLwaw7TwxMew==
X-Received: by 2002:a17:90b:19c8:b0:2b6:226a:a198 with SMTP id 98e67ed59e1d1-2b6226aa388mr2031678a91.44.1715173722168;
        Wed, 08 May 2024 06:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeOaCTYp1FdA5bRIs60LjtTwgQpzgbb/oWA5EzCN9ofyviTGf3YD85JmuC+gTPx2SjlU3Iy/yKMH5GbgEoBhc=
X-Received: by 2002:a17:90b:19c8:b0:2b6:226a:a198 with SMTP id
 98e67ed59e1d1-2b6226aa388mr2031650a91.44.1715173721716; Wed, 08 May 2024
 06:08:41 -0700 (PDT)
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
In-Reply-To: <CAHj4cs9xwzrhRPoZ2t69b6F2JL8X9mZNVmwBfW2y5g7ZdbR8vg@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 8 May 2024 21:08:29 +0800
Message-ID: <CAHj4cs-mz5Dh6WrqB3PzoV89YaMTHrt9PbJv_4ofQD2r0BktTw@mail.gmail.com>
Subject: Re: [bug report][bisected] kmemleak in rdma_core observed during
 blktests nvme/rdma use siw
To: Guoqing Jiang <guoqing.jiang@linux.dev>, Yanjun Zhu <yanjun.zhu@linux.dev>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com, 
	chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So bisect shows it was introduced with below commit, please help check
and fix it, thanks.

commit f8ef1be816bf9a0c406c696368c2264a9597a994
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Mon Jul 17 11:12:32 2023 -0400

    RDMA/cma: Avoid GID lookups on iWARP devices

On Tue, Apr 30, 2024 at 7:51=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> On Mon, Apr 29, 2024 at 8:54=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linu=
x.dev> wrote:
> >
> >
> >
> > On 4/28/24 20:42, Yi Zhang wrote:
> > > On Sun, Apr 28, 2024 at 10:54=E2=80=AFAM Guoqing Jiang <guoqing.jiang=
@linux.dev> wrote:
> > >>
> > >>
> > >> On 4/26/24 16:44, Yi Zhang wrote:
> > >>> On Fri, Apr 26, 2024 at 1:56=E2=80=AFPM Yi Zhang <yi.zhang@redhat.c=
om> wrote:
> > >>>> On Wed, Apr 24, 2024 at 9:28=E2=80=AFPM Guoqing Jiang <guoqing.jia=
ng@linux.dev> wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> On 4/8/24 14:03, Yi Zhang wrote:
> > >>>>>> Hi
> > >>>>>> I found the below kmemleak issue during blktests nvme/rdma on th=
e
> > >>>>>> latest linux-rdma/for-next, please help check it and let me know=
 if
> > >>>>>> you need any info/testing for it, thanks.
> > >>>>> Could you share which test case caused the issue? I can't reprodu=
ce
> > >>>>> it with 6.9-rc3+ kernel (commit 586b5dfb51b) with the below.
> > >>>> It can be reproduced by [1], you can find more info from the symbo=
l
> > >>>> info[2], I also attached the config file, maybe you can this confi=
g
> > >>>> file
> > >>> Just attached the config file
> > >>>
> > >> I tried with the config, but still unlucky.
> > >>
> > >> # nvme_trtype=3Drdma ./check nvme/012
> > >> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> > >> device-backed ns)
> > >> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> > >> device-backed ns) [passed]
> > >>       runtime  52.763s  ...  392.027s device: nvme0
> > >>
> > >>>> [1] nvme_trtype=3Drdma ./check nvme/012
> > >>>> [2]
> > >>>> unreferenced object 0xffff8883a87e8800 (size 192):
> > >>>>     comm "rdma", pid 2355, jiffies 4294836069
> > >>>>     hex dump (first 32 bytes):
> > >>>>       32 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  2..........=
.....
> > >>>>       10 88 7e a8 83 88 ff ff 10 88 7e a8 83 88 ff ff  ..~.......~=
.....
> > >>>>     backtrace (crc 4db191c4):
> > >>>>       [<ffffffff8cd251bd>] kmalloc_trace+0x30d/0x3b0
> > >>>>       [<ffffffffc207eff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> > >>>>       [<ffffffffc2080206>] add_modify_gid+0x166/0x930 [ib_core]
> > >>>>       [<ffffffffc2081468>] ib_cache_update.part.0+0x6d8/0x910 [ib_=
core]
> > >>>>       [<ffffffffc2082e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core=
]
> > >>>>       [<ffffffffc207749e>] ib_register_device+0x9e/0x3a0 [ib_core]
> > >>>>       [<ffffffffc24ac389>] 0xffffffffc24ac389
> > >>>>       [<ffffffffc20c6cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
> > >>>>       [<ffffffffc2083fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
> > >>>>       [<ffffffffc208448c>]
> > >>>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> > >>>>       [<ffffffff8e30e715>] netlink_unicast+0x445/0x710
> > >>>>       [<ffffffff8e30f151>] netlink_sendmsg+0x761/0xc40
> > >>>>       [<ffffffff8e09da89>] __sys_sendto+0x3a9/0x420
> > >>>>       [<ffffffff8e09dbec>] __x64_sys_sendto+0xdc/0x1b0
> > >>>>       [<ffffffff8e9afad3>] do_syscall_64+0x93/0x180
> > >>>>       [<ffffffff8ea00126>] entry_SYSCALL_64_after_hwframe+0x71/0x7=
9
> > >>>>
> > >>>> (gdb) l *(alloc_gid_entry+0x47)
> > >>>> 0x2eff7 is in alloc_gid_entry (./include/linux/slab.h:628).
> > >>>> 623
> > >>>> 624 if (size > KMALLOC_MAX_CACHE_SIZE)
> > >>>> 625 return kmalloc_large(size, flags);
> > >>>> 626
> > >>>> 627 index =3D kmalloc_index(size);
> > >>>> 628 return kmalloc_trace(
> > >>>> 629 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> > >>>> 630 flags, size);
> > >>>> 631 }
> > >>>> 632 return __kmalloc(size, flags);
> > >>>>
> > >>>> (gdb) l *(add_modify_gid+0x166)
> > >>>> 0x30206 is in add_modify_gid (drivers/infiniband/core/cache.c:447)=
.
> > >>>> 442 * empty table entries instead of storing them.
> > >>>> 443 */
> > >>>> 444 if (rdma_is_zero_gid(&attr->gid))
> > >>>> 445 return 0;
> > >>>> 446
> > >>>> 447 entry =3D alloc_gid_entry(attr);
> > >>>> 448 if (!entry)
> > >>>> 449 return -ENOMEM;
> > >>>> 450
> > >>>> 451 if (rdma_protocol_roce(attr->device, attr->port_num)) {
> > >>>>
> > >>>>
> > >>>>> use_siw=3D1 nvme_trtype=3Drdma ./check nvme/
> > >>>>>
> > >>>>>> # dmesg | grep kmemleak
> > >>>>>> [   67.130652] kmemleak: Kernel memory leak detector initialized=
 (mem
> > >>>>>> pool available: 36041)
> > >>>>>> [   67.130728] kmemleak: Automatic memory scanning thread starte=
d
> > >>>>>> [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
> > >>>>>> /sys/kernel/debug/kmemleak)
> > >>>>>> [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
> > >>>>>> /sys/kernel/debug/kmemleak)
> > >>>>>> [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
> > >>>>>> /sys/kernel/debug/kmemleak)
> > >>>>>> [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
> > >>>>>> /sys/kernel/debug/kmemleak)
> > >>>>>>
> > >>>>>> unreferenced object 0xffff88855da53400 (size 192):
> > >>>>>>      comm "rdma", pid 10630, jiffies 4296575922
> > >>>>>>      hex dump (first 32 bytes):
> > >>>>>>        37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7.......=
........
> > >>>>>>        10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.]....=
.4.]....
> > >>>>>>      backtrace (crc 47f66721):
> > >>>>>>        [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
> > >>>>>>        [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> > >>>>>>        [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
> > >>>>> I guess add_modify_gid is called from config_non_roce_gid_cache, =
not sure
> > >>>>> why we don't check the return value of it here.
> > >>>>>
> > >>>>> Looks put_gid_entry is called in case add_modify_gid returns fail=
ure, it
> > >>>>> would
> > >>>>> trigger schedule_free_gid -> queue_work(ib_wq, &entry->del_work),=
 then
> > >>>>> free_gid_work -> free_gid_entry_locked would free storage asynchr=
onously by
> > >>>>> put_gid_ndev and also entry.
> > >>>>>
> > >>>>>>        [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [=
ib_core]
> > >>>>>>        [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_c=
ore]
> > >>>>>>        [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_co=
re]
> > >>>>>>        [<ffffffffc2a3d389>] 0xffffffffc2a3d389
> > >>>>>>        [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
> > >>>>>>        [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core=
]
> > >>>>>>        [<ffffffffc264648c>]
> > >>>>>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> > >>>>>>        [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
> > >>>>>>        [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
> > >>>>>>        [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
> > >>>>>>        [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
> > >>>>>>        [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
> > >>>>>>        [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/=
0x79
> > >>>>> After ib_cache_setup_one failed, maybe ib_cache_cleanup_one is ne=
eded
> > >>>>> which flush ib_wq to ensure storage is freed. Could you try with =
the change?
> > >>>> Will try it later.
> > >>>>
> > >>> The kmemleak still can be reproduced with this change:
> > >>>
> > >>> unreferenced object 0xffff8881f89fde00 (size 192):
> > >>>     comm "rdma", pid 8708, jiffies 4295703453
> > >>>     hex dump (first 32 bytes):
> > >>>       02 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  ............=
....
> > >>>       10 de 9f f8 81 88 ff ff 10 de 9f f8 81 88 ff ff  ............=
....
> > >>>     backtrace (crc 888c494b):
> > >>>       [<ffffffffa7d251bd>] kmalloc_trace+0x30d/0x3b0
> > >>>       [<ffffffffc1efeff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> > >>>       [<ffffffffc1f00206>] add_modify_gid+0x166/0x930 [ib_core]
> > >>>       [<ffffffffc1f01468>] ib_cache_update.part.0+0x6d8/0x910 [ib_c=
ore]
> > >>>       [<ffffffffc1f02e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
> > >>>       [<ffffffffc1ef749e>] ib_register_device+0x9e/0x3a0 [ib_core]
> > >>>       [<ffffffffc22ee389>]
> > >>> siw_qp_state_to_ib_qp_state+0x28a9/0xfffffffffffd1520 [siw]
> > >> Is it possible to run the test with rxe instead of siw? In case it i=
s
> > >> only happened
> > >> with siw, I'd suggest to revert 0b988c1bee28 to check if it causes t=
he
> > >> issue.
> > >> But I don't understand why siw_qp_state_to_ib_qp_state was appeared =
in the
> > >> middle of above trace.
> > > Hi Guoqing
> > > This issue only can be reproduced with siw, I did more testing today
> > > and it cannot be reproduced with 6.5, seems it was introduced from
> > > 6.6-rc1, and I saw there are some siw updates from 6.6-rc1.
> >
> > Yes, pls bisect them.
>
> Sure, will do that after I back from holiday next week.
>
> >
> >  > git log --oneline v6.5..v6.6-rc1 drivers/infiniband/sw/siw/|cat
> > 9dfccb6d0d3d RDMA/siw: Call llist_reverse_order in siw_run_sq
> > bee024d20451 RDMA/siw: Correct wrong debug message
> > b056327bee09 RDMA/siw: Balance the reference of cep->kref in the error =
path
> > 91f36237b4b9 RDMA/siw: Fix tx thread initialization.
> > bad5b6e34ffb RDMA/siw: Fabricate a GID on tun and loopback devices
> > 9191df002926 RDMA/siw: use vmalloc_array and vcalloc
> >
> > Thanks,
> > Guoqing
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


