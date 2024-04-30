Return-Path: <linux-rdma+bounces-2155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678D8B74EC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 13:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77941F228DC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD01134403;
	Tue, 30 Apr 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9fGSsO4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC81311B0
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477927; cv=none; b=QFz8zKIhFqSnjPUkqbaZBZJodZVnDlwauiEx7ZgDEe5aTXgt568yATlM0OEy7vtKf5M4oTaz9zVNqb1IEeqqRzSh75J+0F0EB74Ohh4YkOQliMY6PnzR8lhKW28iVRvK9lMkudbgcrEsUvMzkaBngW65OInae8X+THowIipD7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477927; c=relaxed/simple;
	bh=VIEqJ/PUwxHI2g2wDJuC7GeQoqSymxol/5JvMk5Ls+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYrgrsE2AZblCYp0eYFwD7XBslBFhU7NLS93ml/8QfxkcRd5CMqn5m1wMv0RDL36Cs4dkdpuOYMO1vANY3QBiPFCjiBK1zgKEcQTJX6kC2UQ2mZk5vWXBTkI77qz89iZieuu2mdYjTNg3lCxSg83oOJLROFJlgkbWpjI0UXSKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9fGSsO4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714477924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/Yx23pSrPLuw1JZyrkamVw9pgFwArO8R+9oG4JDW8U=;
	b=Y9fGSsO4M55gDjt6kl8KtCZxfB2JgPWocPl8mu7Aa99jEke3glSPl0nlwIPtSePZXA/gfX
	YAmcxb26xT6Ucl9/5lTKLnItOlgVGro5S2fZYLVuUWmcv0NtpFbU+gHOx2xyDaHjyD/UqB
	C5gE7tUB1P6GE5DKTkPBRZtiJ303irY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-gaqVtJ7qPsiKm2oHkDd5Lg-1; Tue, 30 Apr 2024 07:52:03 -0400
X-MC-Unique: gaqVtJ7qPsiKm2oHkDd5Lg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e8f59d1d9bso63074175ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 04:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714477922; x=1715082722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Yx23pSrPLuw1JZyrkamVw9pgFwArO8R+9oG4JDW8U=;
        b=LkAjF1g68UBMD9I///66lX1NJgA6ySuImipMHdCj9Jm1qkgB96o/PSZKTbgNqER8OE
         p+yvlma7CGAVxBLMaGE2M8Fw6wM6rQEnRHyaYiNccWyb9CXhhK0xIsc2rIUDzC/50xBs
         TxwkMGP/OaFBuYJrJmnsgr02fRWxlGDmCgxZ4tz0CpE9v0mNNkGQ1mTeXedVmUiHrRC5
         UKKAA6qqnBuR+Wh8bfiU8iJkGkky3X4g7td0lZrXbDNZVEaKvZnjX9MwV+g3UYEYRqBk
         +GsEC/4zQJJXhvM/ah/Y67E08teKn/2XE2xgkHXwbPNehHThvihV1gs+agWVIdhtpUio
         TTZw==
X-Gm-Message-State: AOJu0Yy/nc+oGKERhrrJOX2aiM6De4WXliX12f8VRhqsWhzc85+9jc3R
	rXc+r1G29xbJJlAgFyFoHdbslTzanmpHZky7pfCY2uXbDPa4dPYoVsR2bKacNmDAZe6qsjYnMfk
	OlRvrYiaICvGIn+pw2LY9FiodYc4URoNrvCPwk8F8iptXsyd9zXJZUJhXKYHiSyYHCOYQd6/1Ys
	nV18EP4DpDAUy/8NoKAQ6siUOJIs7zxyc1+Q==
X-Received: by 2002:a17:902:ce86:b0:1e4:55d8:dfae with SMTP id f6-20020a170902ce8600b001e455d8dfaemr15721371plg.4.1714477922036;
        Tue, 30 Apr 2024 04:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdVXJeVGsFBlLD1Dl7cFedddRwMsxyGVKFWKK5jMq6kbJ26ZXcpcT0QJFzsXy7AkfXFpGY/ji8jCMSW2vEWfY=
X-Received: by 2002:a17:902:ce86:b0:1e4:55d8:dfae with SMTP id
 f6-20020a170902ce8600b001e455d8dfaemr15721351plg.4.1714477921617; Tue, 30 Apr
 2024 04:52:01 -0700 (PDT)
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
 <54eea59a-efcd-c281-e998-033c6df81a28@linux.dev>
In-Reply-To: <54eea59a-efcd-c281-e998-033c6df81a28@linux.dev>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 30 Apr 2024 19:51:48 +0800
Message-ID: <CAHj4cs9xwzrhRPoZ2t69b6F2JL8X9mZNVmwBfW2y5g7ZdbR8vg@mail.gmail.com>
Subject: Re: [bug report] kmemleak in rdma_core observed during blktests
 nvme/rdma use siw
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 8:54=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
>
>
> On 4/28/24 20:42, Yi Zhang wrote:
> > On Sun, Apr 28, 2024 at 10:54=E2=80=AFAM Guoqing Jiang <guoqing.jiang@l=
inux.dev> wrote:
> >>
> >>
> >> On 4/26/24 16:44, Yi Zhang wrote:
> >>> On Fri, Apr 26, 2024 at 1:56=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com=
> wrote:
> >>>> On Wed, Apr 24, 2024 at 9:28=E2=80=AFPM Guoqing Jiang <guoqing.jiang=
@linux.dev> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 4/8/24 14:03, Yi Zhang wrote:
> >>>>>> Hi
> >>>>>> I found the below kmemleak issue during blktests nvme/rdma on the
> >>>>>> latest linux-rdma/for-next, please help check it and let me know i=
f
> >>>>>> you need any info/testing for it, thanks.
> >>>>> Could you share which test case caused the issue? I can't reproduce
> >>>>> it with 6.9-rc3+ kernel (commit 586b5dfb51b) with the below.
> >>>> It can be reproduced by [1], you can find more info from the symbol
> >>>> info[2], I also attached the config file, maybe you can this config
> >>>> file
> >>> Just attached the config file
> >>>
> >> I tried with the config, but still unlucky.
> >>
> >> # nvme_trtype=3Drdma ./check nvme/012
> >> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> >> device-backed ns)
> >> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> >> device-backed ns) [passed]
> >>       runtime  52.763s  ...  392.027s device: nvme0
> >>
> >>>> [1] nvme_trtype=3Drdma ./check nvme/012
> >>>> [2]
> >>>> unreferenced object 0xffff8883a87e8800 (size 192):
> >>>>     comm "rdma", pid 2355, jiffies 4294836069
> >>>>     hex dump (first 32 bytes):
> >>>>       32 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  2............=
...
> >>>>       10 88 7e a8 83 88 ff ff 10 88 7e a8 83 88 ff ff  ..~.......~..=
...
> >>>>     backtrace (crc 4db191c4):
> >>>>       [<ffffffff8cd251bd>] kmalloc_trace+0x30d/0x3b0
> >>>>       [<ffffffffc207eff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> >>>>       [<ffffffffc2080206>] add_modify_gid+0x166/0x930 [ib_core]
> >>>>       [<ffffffffc2081468>] ib_cache_update.part.0+0x6d8/0x910 [ib_co=
re]
> >>>>       [<ffffffffc2082e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
> >>>>       [<ffffffffc207749e>] ib_register_device+0x9e/0x3a0 [ib_core]
> >>>>       [<ffffffffc24ac389>] 0xffffffffc24ac389
> >>>>       [<ffffffffc20c6cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
> >>>>       [<ffffffffc2083fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
> >>>>       [<ffffffffc208448c>]
> >>>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> >>>>       [<ffffffff8e30e715>] netlink_unicast+0x445/0x710
> >>>>       [<ffffffff8e30f151>] netlink_sendmsg+0x761/0xc40
> >>>>       [<ffffffff8e09da89>] __sys_sendto+0x3a9/0x420
> >>>>       [<ffffffff8e09dbec>] __x64_sys_sendto+0xdc/0x1b0
> >>>>       [<ffffffff8e9afad3>] do_syscall_64+0x93/0x180
> >>>>       [<ffffffff8ea00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79
> >>>>
> >>>> (gdb) l *(alloc_gid_entry+0x47)
> >>>> 0x2eff7 is in alloc_gid_entry (./include/linux/slab.h:628).
> >>>> 623
> >>>> 624 if (size > KMALLOC_MAX_CACHE_SIZE)
> >>>> 625 return kmalloc_large(size, flags);
> >>>> 626
> >>>> 627 index =3D kmalloc_index(size);
> >>>> 628 return kmalloc_trace(
> >>>> 629 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> >>>> 630 flags, size);
> >>>> 631 }
> >>>> 632 return __kmalloc(size, flags);
> >>>>
> >>>> (gdb) l *(add_modify_gid+0x166)
> >>>> 0x30206 is in add_modify_gid (drivers/infiniband/core/cache.c:447).
> >>>> 442 * empty table entries instead of storing them.
> >>>> 443 */
> >>>> 444 if (rdma_is_zero_gid(&attr->gid))
> >>>> 445 return 0;
> >>>> 446
> >>>> 447 entry =3D alloc_gid_entry(attr);
> >>>> 448 if (!entry)
> >>>> 449 return -ENOMEM;
> >>>> 450
> >>>> 451 if (rdma_protocol_roce(attr->device, attr->port_num)) {
> >>>>
> >>>>
> >>>>> use_siw=3D1 nvme_trtype=3Drdma ./check nvme/
> >>>>>
> >>>>>> # dmesg | grep kmemleak
> >>>>>> [   67.130652] kmemleak: Kernel memory leak detector initialized (=
mem
> >>>>>> pool available: 36041)
> >>>>>> [   67.130728] kmemleak: Automatic memory scanning thread started
> >>>>>> [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
> >>>>>> /sys/kernel/debug/kmemleak)
> >>>>>> [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
> >>>>>> /sys/kernel/debug/kmemleak)
> >>>>>> [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
> >>>>>> /sys/kernel/debug/kmemleak)
> >>>>>> [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
> >>>>>> /sys/kernel/debug/kmemleak)
> >>>>>>
> >>>>>> unreferenced object 0xffff88855da53400 (size 192):
> >>>>>>      comm "rdma", pid 10630, jiffies 4296575922
> >>>>>>      hex dump (first 32 bytes):
> >>>>>>        37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7.........=
......
> >>>>>>        10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4=
.]....
> >>>>>>      backtrace (crc 47f66721):
> >>>>>>        [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
> >>>>>>        [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> >>>>>>        [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
> >>>>> I guess add_modify_gid is called from config_non_roce_gid_cache, no=
t sure
> >>>>> why we don't check the return value of it here.
> >>>>>
> >>>>> Looks put_gid_entry is called in case add_modify_gid returns failur=
e, it
> >>>>> would
> >>>>> trigger schedule_free_gid -> queue_work(ib_wq, &entry->del_work), t=
hen
> >>>>> free_gid_work -> free_gid_entry_locked would free storage asynchron=
ously by
> >>>>> put_gid_ndev and also entry.
> >>>>>
> >>>>>>        [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib=
_core]
> >>>>>>        [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_cor=
e]
> >>>>>>        [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core=
]
> >>>>>>        [<ffffffffc2a3d389>] 0xffffffffc2a3d389
> >>>>>>        [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
> >>>>>>        [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
> >>>>>>        [<ffffffffc264648c>]
> >>>>>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> >>>>>>        [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
> >>>>>>        [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
> >>>>>>        [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
> >>>>>>        [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
> >>>>>>        [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
> >>>>>>        [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x=
79
> >>>>> After ib_cache_setup_one failed, maybe ib_cache_cleanup_one is need=
ed
> >>>>> which flush ib_wq to ensure storage is freed. Could you try with th=
e change?
> >>>> Will try it later.
> >>>>
> >>> The kmemleak still can be reproduced with this change:
> >>>
> >>> unreferenced object 0xffff8881f89fde00 (size 192):
> >>>     comm "rdma", pid 8708, jiffies 4295703453
> >>>     hex dump (first 32 bytes):
> >>>       02 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  ..............=
..
> >>>       10 de 9f f8 81 88 ff ff 10 de 9f f8 81 88 ff ff  ..............=
..
> >>>     backtrace (crc 888c494b):
> >>>       [<ffffffffa7d251bd>] kmalloc_trace+0x30d/0x3b0
> >>>       [<ffffffffc1efeff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> >>>       [<ffffffffc1f00206>] add_modify_gid+0x166/0x930 [ib_core]
> >>>       [<ffffffffc1f01468>] ib_cache_update.part.0+0x6d8/0x910 [ib_cor=
e]
> >>>       [<ffffffffc1f02e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
> >>>       [<ffffffffc1ef749e>] ib_register_device+0x9e/0x3a0 [ib_core]
> >>>       [<ffffffffc22ee389>]
> >>> siw_qp_state_to_ib_qp_state+0x28a9/0xfffffffffffd1520 [siw]
> >> Is it possible to run the test with rxe instead of siw? In case it is
> >> only happened
> >> with siw, I'd suggest to revert 0b988c1bee28 to check if it causes the
> >> issue.
> >> But I don't understand why siw_qp_state_to_ib_qp_state was appeared in=
 the
> >> middle of above trace.
> > Hi Guoqing
> > This issue only can be reproduced with siw, I did more testing today
> > and it cannot be reproduced with 6.5, seems it was introduced from
> > 6.6-rc1, and I saw there are some siw updates from 6.6-rc1.
>
> Yes, pls bisect them.

Sure, will do that after I back from holiday next week.

>
>  > git log --oneline v6.5..v6.6-rc1 drivers/infiniband/sw/siw/|cat
> 9dfccb6d0d3d RDMA/siw: Call llist_reverse_order in siw_run_sq
> bee024d20451 RDMA/siw: Correct wrong debug message
> b056327bee09 RDMA/siw: Balance the reference of cep->kref in the error pa=
th
> 91f36237b4b9 RDMA/siw: Fix tx thread initialization.
> bad5b6e34ffb RDMA/siw: Fabricate a GID on tun and loopback devices
> 9191df002926 RDMA/siw: use vmalloc_array and vcalloc
>
> Thanks,
> Guoqing
>


--=20
Best Regards,
  Yi Zhang


