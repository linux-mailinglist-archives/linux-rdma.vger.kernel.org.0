Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4925745
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfEUSIr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:08:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37455 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfEUSIr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:08:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id d10so11665086qko.4
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMSuq+m4/RPW0r8LxwYmxt7WH/802VIB6e0JoV0NfEE=;
        b=Q+mdNhd+Wf0Ir4d/t1h0HApmDge+9cpbjvoYJdgn0WndbwYFtqSYBp6nLgnKzR2Bg5
         0KlRqYoPpcT9Gh9oGNIL4F4vapORBEMD3nY9vW3p0zo+M5U3RpR9gNJKvv4HgnL/cQyn
         ze6R6lorq48BIG/w0YOwL/9IrNmTHYufRFJZngFRhSgtMZSZuSopyDlj707rGLLi+cO2
         fZQdsaJ26jMP/Ely0v/q6qVYsaUT+pLxtJRcDsyMLktxm6/7pHFnn3F2t+aPBbAz6D7n
         ombWyXsozWUv+lsa5dLf3Y1hkXA2oLoud1PnB4YL94VZkdDx3MaFNV6aEgdVrhEwMt1E
         xclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMSuq+m4/RPW0r8LxwYmxt7WH/802VIB6e0JoV0NfEE=;
        b=mQ+42+TR/3I23QpYNiCJBLN4fM2vELkxG0Vj2gDWFQO8zghUox6vMZ//YiPVukfx9t
         84BT1psb60Jwitdu47r3xZu7PJ8scnT4YVjEsOXRMUogx5meYLYCFmyPHCpNLTLF8FuT
         fsCN4uNvZqr9NYfd7LfSVVLfwHLNoyANyzAHTTh2SVKbySv4T8qiWhnXCswhyDOiQuh0
         +xlY0I/H8F4cqLl0TeYy7kH/T+2rrxcfWIJc1ilsbg23KM6BozGP0QJzUweVOot9gQo7
         CC9HxP57isy2A4u5QapJpA/7inUkZEKLpYLHJ94ak28oWuHSbfS6A/cXZ6XY1efcZrHM
         ljrA==
X-Gm-Message-State: APjAAAV3i5jD20Eiy8rewhdThQfL0Fmc5019VV9wcOpikabPUbsI87di
        MvFd5u4gufgu5me0iY+qmTSYLg==
X-Google-Smtp-Source: APXvYqwdPx491Cz2KDSUPCafE6Yp4jcqm2zuMjdWoyhIF7k9eirJU3cyE+Of9YQcIEQR2XujPrqlfw==
X-Received: by 2002:ae9:ec10:: with SMTP id h16mr27382055qkg.215.1558462125877;
        Tue, 21 May 2019 11:08:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v3sm15810824qtc.97.2019.05.21.11.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:08:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9Bs-0008Pu-SP; Tue, 21 May 2019 15:08:44 -0300
Date:   Tue, 21 May 2019 15:08:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v4] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
Message-ID: <20190521180844.GA28301@ziepe.ca>
References: <20190517124310.14815-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517124310.14815-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 17, 2019 at 03:43:10PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> SRP logic used device name and port index as symlink to relevant
> kobject. This situation caused to device name to be cached and
> triggered on the boot the kernel panic below.
> 
> [    8.163181] RPC: Registered rdma transport module.
> [    8.163182] RPC: Registered rdma backchannel transport module.
> [    8.319908] pps_core: LinuxPPS API ver. 1 registered
> [    8.319910] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    8.346610] PTP clock support registered
> [    9.317026] mlx5_core 0000:00:08.0: firmware version: 12.25.1020
> [    9.317157] mlx5_core 0000:00:08.0: 126.016 Gb/s available PCIe bandwidth (8 GT/s x16 link)
> [    9.532121] mlx5_core 0000:00:08.0: E-Switch: Total vports 2, per vport: max uc(1024) max mc(16384)
> [    9.694930] mlx5_core 0000:00:08.1: firmware version: 12.25.1020
> [    9.694995] mlx5_core 0000:00:08.1: 126.016 Gb/s available PCIe bandwidth (8 GT/s x16 link)
> [    9.904603] mlx5_core 0000:00:08.1: E-Switch: Total vports 2, per vport: max uc(1024) max mc(16384)
> [    9.981334] mlx5_core 0000:00:08.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
> [   10.161993] mlx5_core 0000:00:08.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
> [   10.162424] mlx5_core 0000:00:08.0 ens8f0: renamed from eth0
> [   10.357080] mlx5_core 0000:00:08.1 ens8f1: renamed from eth0
> [   10.484528] mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
> [   10.622868] sysfs: cannot create duplicate filename '/class/infiniband_srp/srp-mlx5_0-1'
> [   10.622871] CPU: 3 PID: 1107 Comm: modprobe Not tainted 5.1.0-for-upstream-perf-2019-05-12_15-09-52-87 #1
> [   10.622872] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [   10.622873] Call Trace:
> [   10.622883]  dump_stack+0x5a/0x73
> [   10.622889]  sysfs_warn_dup+0x58/0x70
> [   10.622891]  sysfs_do_create_link_sd.isra.2+0xa3/0xb0
> [   10.622896]  device_add+0x33f/0x660
> [   10.622900]  srp_add_one+0x301/0x4f0 [ib_srp]
> [   10.622917]  add_client_context+0x99/0xe0 [ib_core]
> [   10.622926]  enable_device_and_get+0xd1/0x1b0 [ib_core]
> [   10.622934]  ib_register_device+0x533/0x710 [ib_core]
> [   10.622938]  ? mutex_lock+0xe/0x30
> [   10.622948]  __mlx5_ib_add+0x23/0x70 [mlx5_ib]
> [   10.622983]  mlx5_add_device+0x4e/0xd0 [mlx5_core]
> [   10.622999]  mlx5_register_interface+0x85/0xc0 [mlx5_core]
> [   10.623000]  ? 0xffffffffa0791000
> [   10.623003]  do_one_initcall+0x4b/0x1cb
> [   10.623007]  ? kmem_cache_alloc_trace+0xc6/0x1d0
> [   10.623009]  ? do_init_module+0x22/0x21f
> [   10.623011]  do_init_module+0x5a/0x21f
> [   10.623013]  load_module+0x17f2/0x1ca0
> [   10.623015]  ? m_show+0x1c0/0x1c0
> [   10.623017]  __do_sys_finit_module+0x94/0xe0
> [   10.623019]  do_syscall_64+0x48/0x120
> [   10.623022]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   10.623038] RIP: 0033:0x7f157cce10d9
> [   10.623039] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 ad 2c 00 f7 d8 64 89 01 48
> [   10.623040] RSP: 002b:00007ffd79f91538 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   10.623042] RAX: ffffffffffffffda RBX: 0000561a4a8f2d80 RCX: 00007f157cce10d9
> [   10.623043] RDX: 0000000000000000 RSI: 0000561a48e1f85c RDI: 0000000000000001
> [   10.623050] RBP: 0000561a48e1f85c R08: 0000000000000000 R09: 0000000000000000
> [   10.623050] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> [   10.623051] R13: 0000561a4a8f2eb0 R14: 0000000000040000 R15: 0000561a4a8f2d80
> [   10.858147] random: crng init done
> [   10.858149] random: 7 urandom warning(s) missed due to ratelimiting
> [   99.994965] FS-Cache: Loaded
> [  100.283059] FS-Cache: Netfs 'nfs' registered for caching
> [  100.322275] Key type dns_resolver registered
> [  100.558079] NFS: Registering the id_resolver key type
> [  100.558086] Key type id_resolver registered
> [  100.558087] Key type id_legacy registered
> 
> This panic is caused due to races between device rename during boot and
> initialization of new devices for multi-adapter system.
> 
> The module load/unload sequence was used to trigger such kernel panic:
>  sudo modprobe ib_srp
>  sudo modprobe -r mlx5_ib
>  sudo modprobe -r mlx5_core
>  sudo modprobe mlx5_core
> 
> Fixes: d21943dd19b5 ("RDMA/core: Implement IB device rename function")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> Changelog
> v3->v4:
>  * fixed typo
> v2->v3:
>  * Tried to be "good kernel developer"
>  * Dropped RFC
> v1-v2:
>  * Fixed checkpatch warnings
>  * Rewrote loop to call client->rename
> v0->v1:
>  * Reimplemented
> ---
>  drivers/infiniband/core/device.c    | 35 +++++++++++++++++++++--------
>  drivers/infiniband/ulp/srp/ib_srp.c | 18 ++++++++++++++-
>  include/rdma/ib_verbs.h             |  1 +
>  3 files changed, 44 insertions(+), 10 deletions(-)

Applied to for-rc thanks

Jason
