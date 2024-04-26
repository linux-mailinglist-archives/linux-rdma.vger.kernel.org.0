Return-Path: <linux-rdma+bounces-2083-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236058B2FF4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 07:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF1C2847A4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FB13A89C;
	Fri, 26 Apr 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiZlxhKE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A513A888
	for <linux-rdma@vger.kernel.org>; Fri, 26 Apr 2024 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110982; cv=none; b=eWehGZ1o2KNnuCqrMi6hyL8H5Wd4FQmGQmoETP7xKNQkJ5svK2Ill1rwfsmzclGC09AmCFbcM0Jo1PQqSnER4oV9/RBwm9UiK1p+xs8nQqNvI9x8sHKtfAmSXWIprMcX66khJ3beDzS16SUTLT+EClRshTroLTZw75Kxclos9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110982; c=relaxed/simple;
	bh=JWL0K+5cjco6VRaW87mFC6aB8ORRe1FwNgm8NeijOf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb3QtgTulwrzO/asnJvZel23XPYg4IhwsvwNZgXCswsD0EvNeDBuco2xGw3luNa9aFXJjO+o9ZxoysotAprKoD8h4u9MUggQj/neVjCW+7FZL8mWAjnmT8gl8E1i8ZQzQeMT5MZ60YndKMtGHQniXxJsDlYWAMbGeudBZ0J5LAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiZlxhKE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714110979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oseE2SagcK+9TQbRDfArlJyrCB1uVI9DqUhHB0b+jLY=;
	b=LiZlxhKEicRyeXhWBDLGhyEvCfBGkjuLnwzXUq/Z6ZYjy73O9qDVO3hSaIlZEo+aJ09Pn4
	6SM2AySqwlS2pZSq/UumfvSKeMFPIG5hYTNIpfzbKdlqKX1X1qUe2PCMcw+RNtgaRYmeXF
	YyMADuu8uOKzWtHI+sbRnh5sMQNncJI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-dq2w-MJ8NG6_ByOVx92iYw-1; Fri, 26 Apr 2024 01:56:17 -0400
X-MC-Unique: dq2w-MJ8NG6_ByOVx92iYw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so1752515a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 22:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714110977; x=1714715777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oseE2SagcK+9TQbRDfArlJyrCB1uVI9DqUhHB0b+jLY=;
        b=VRnwMauLXDwrwMcti3Cc+j71um6d2sN4HHHQCmYRvHH52+P8FjpzbT6nL2w+hyq+ja
         j+sRqB1Ign9LHwrKCHRJK1PyURIDIkCp419ioV3GpkcJSIJUmIZRZs9fz+J0Z1p5FpTF
         TOtWQhXbkg0ckbq9rBFrtUs3Cz0k9Rq3Hwphl3tMF707Padk7B8QXmZvqakkG6S2pw8v
         tDVY/uTePJxuEGmSGd1Grzc8oME9ox8CSDuV1a6PbztnDxm1VApiZwFylU4O9NHhKdT+
         mHfgP7EDZs88Nia0gbtLZQfXHRxbkVGGkZm7wIpDd5UULgax9hQXgIiOe28nZuSDqMF9
         bOjg==
X-Gm-Message-State: AOJu0Yyg5zxL6N0vNIfMh29pdopUrpTS9p/F5e3m7kVYtn6/IEsnCvx6
	TXqdGvpsnOso9bb1W5AlUwrcGyHVm5Y43Rz5t8Cwk4YmrhqKmbVqxjgpWGuIfgU9hlVv1D7pDae
	Walx7izOnZTDHypxGBxbTBG0zCN1vUQpHHiFhHlSmSpTIJcRfHwabimf9q3VUC5S4+mGZJppKqG
	SwglEAhIiM1cDBN2bLEAHKeXXbFvyFbtqVew==
X-Received: by 2002:a05:6a20:9703:b0:1a7:59b5:4276 with SMTP id hr3-20020a056a20970300b001a759b54276mr1701395pzc.54.1714110976701;
        Thu, 25 Apr 2024 22:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw35M5ARP4m194YuZKGPHmY1bgJm3BpiPORyvpPXZ3mjXO4++5+YiTVW8mxXku7ijF4pDI+tFjbWeAWc/a+6g=
X-Received: by 2002:a05:6a20:9703:b0:1a7:59b5:4276 with SMTP id
 hr3-20020a056a20970300b001a759b54276mr1701389pzc.54.1714110976335; Thu, 25
 Apr 2024 22:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
 <7de9793f-6805-1412-3fae-a5508910124b@linux.dev>
In-Reply-To: <7de9793f-6805-1412-3fae-a5508910124b@linux.dev>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 26 Apr 2024 13:56:04 +0800
Message-ID: <CAHj4cs-RiZXAdz131ihQ=wsW8nsViphJeHAD_i6qi7_DtW7NwQ@mail.gmail.com>
Subject: Re: [bug report] kmemleak in rdma_core observed during blktests
 nvme/rdma use siw
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:28=E2=80=AFPM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
> Hi,
>
> On 4/8/24 14:03, Yi Zhang wrote:
> > Hi
> > I found the below kmemleak issue during blktests nvme/rdma on the
> > latest linux-rdma/for-next, please help check it and let me know if
> > you need any info/testing for it, thanks.
>
> Could you share which test case caused the issue? I can't reproduce
> it with 6.9-rc3+ kernel (commit 586b5dfb51b) with the below.

It can be reproduced by [1], you can find more info from the symbol
info[2], I also attached the config file, maybe you can this config
file

[1] nvme_trtype=3Drdma ./check nvme/012
[2]
unreferenced object 0xffff8883a87e8800 (size 192):
  comm "rdma", pid 2355, jiffies 4294836069
  hex dump (first 32 bytes):
    32 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  2...............
    10 88 7e a8 83 88 ff ff 10 88 7e a8 83 88 ff ff  ..~.......~.....
  backtrace (crc 4db191c4):
    [<ffffffff8cd251bd>] kmalloc_trace+0x30d/0x3b0
    [<ffffffffc207eff7>] alloc_gid_entry+0x47/0x380 [ib_core]
    [<ffffffffc2080206>] add_modify_gid+0x166/0x930 [ib_core]
    [<ffffffffc2081468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
    [<ffffffffc2082e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
    [<ffffffffc207749e>] ib_register_device+0x9e/0x3a0 [ib_core]
    [<ffffffffc24ac389>] 0xffffffffc24ac389
    [<ffffffffc20c6cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
    [<ffffffffc2083fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
    [<ffffffffc208448c>]
rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
    [<ffffffff8e30e715>] netlink_unicast+0x445/0x710
    [<ffffffff8e30f151>] netlink_sendmsg+0x761/0xc40
    [<ffffffff8e09da89>] __sys_sendto+0x3a9/0x420
    [<ffffffff8e09dbec>] __x64_sys_sendto+0xdc/0x1b0
    [<ffffffff8e9afad3>] do_syscall_64+0x93/0x180
    [<ffffffff8ea00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79

(gdb) l *(alloc_gid_entry+0x47)
0x2eff7 is in alloc_gid_entry (./include/linux/slab.h:628).
623
624 if (size > KMALLOC_MAX_CACHE_SIZE)
625 return kmalloc_large(size, flags);
626
627 index =3D kmalloc_index(size);
628 return kmalloc_trace(
629 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
630 flags, size);
631 }
632 return __kmalloc(size, flags);

(gdb) l *(add_modify_gid+0x166)
0x30206 is in add_modify_gid (drivers/infiniband/core/cache.c:447).
442 * empty table entries instead of storing them.
443 */
444 if (rdma_is_zero_gid(&attr->gid))
445 return 0;
446
447 entry =3D alloc_gid_entry(attr);
448 if (!entry)
449 return -ENOMEM;
450
451 if (rdma_protocol_roce(attr->device, attr->port_num)) {


>
> use_siw=3D1 nvme_trtype=3Drdma ./check nvme/
>
> > # dmesg | grep kmemleak
> > [   67.130652] kmemleak: Kernel memory leak detector initialized (mem
> > pool available: 36041)
> > [   67.130728] kmemleak: Automatic memory scanning thread started
> > [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> >
> > unreferenced object 0xffff88855da53400 (size 192):
> >    comm "rdma", pid 10630, jiffies 4296575922
> >    hex dump (first 32 bytes):
> >      37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
> >      10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
> >    backtrace (crc 47f66721):
> >      [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
> >      [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> >      [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
>
> I guess add_modify_gid is called from config_non_roce_gid_cache, not sure
> why we don't check the return value of it here.
>
> Looks put_gid_entry is called in case add_modify_gid returns failure, it
> would
> trigger schedule_free_gid -> queue_work(ib_wq, &entry->del_work), then
> free_gid_work -> free_gid_entry_locked would free storage asynchronously =
by
> put_gid_ndev and also entry.
>
> >      [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
> >      [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
> >      [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
> >      [<ffffffffc2a3d389>] 0xffffffffc2a3d389
> >      [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
> >      [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
> >      [<ffffffffc264648c>]
> > rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> >      [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
> >      [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
> >      [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
> >      [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
> >      [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
> >      [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79
>
> After ib_cache_setup_one failed, maybe ib_cache_cleanup_one is needed
> which flush ib_wq to ensure storage is freed. Could you try with the chan=
ge?
Will try it later.

>
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1388,7 +1388,7 @@ int ib_register_device(struct ib_device *device,
> const char *name,
>          if (ret) {
>                  dev_warn(&device->dev,
>                           "Couldn't set up InfiniBand P_Key/GID cache\n")=
;
> -               return ret;
> +               goto cache_cleanup;
>          }
>
> Thanks,
> Guoqing
>


--
Best Regards,
  Yi Zhang


