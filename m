Return-Path: <linux-rdma+bounces-7513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A6A2C2F7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BD63A4918
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501E51E00A0;
	Fri,  7 Feb 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBGczZCp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5802C1624D0
	for <linux-rdma@vger.kernel.org>; Fri,  7 Feb 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932465; cv=none; b=seCFOzqybOIm0rWta7acpi//IyfTSXI3e0qECgriaYtAtxh5aF7u7HI7QSO8Ck8ilcnT9mATXny09BEQT0PzJBVYjI2D6cz0bFxGi2FsUggfsr2p3nTK8Ah1JZXU5ZM6s33UNuDLuxPVMQrwe0qZ7DgcExJPeWtTsOXgHFd+IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932465; c=relaxed/simple;
	bh=ffa/d4eb/sQGZFSMrug6DXLNNF+El+vTHXGJVysjvi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q30n93AbPvwaGjfaqPInRSgGXYj5CAMqKDbdI7trcN0dQH1/3YgOhqG86bKPs/h8hbGmdpKvm09gds8vBHSG6gj5iQiciqcZWZ6akjH4aoBNIU7rVlNdfuC52jwUjxDue2oUXjIu2/urVDQEBJOgNXvEeP7N0gbrEFQXbLxU5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBGczZCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738932462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aisc3fRvKAqcLJAVV6uLqWitLc3/Yzy62i8C3NhDsMU=;
	b=DBGczZCp06pF7YuLyppXSQv2czVjCdRfY5aLxlWzhyOXYwcDAT8GCv9KNAOHsu1e4a3fcz
	C0cxGYKaVv106A4ocKgXRVWeSL0dQY1jDUAh007T0zaS3hajbWijIIEdC+aIgvottdt6KE
	KN2IYBC34aBtPYrWpwmg8BpTLMQtYV4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-UWmOV8dXMX28o8vg1eV_vw-1; Fri,
 07 Feb 2025 07:47:39 -0500
X-MC-Unique: UWmOV8dXMX28o8vg1eV_vw-1
X-Mimecast-MFC-AGG-ID: UWmOV8dXMX28o8vg1eV_vw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 127E11809CA1;
	Fri,  7 Feb 2025 12:47:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.158])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6CAF1954233;
	Fri,  7 Feb 2025 12:47:25 +0000 (UTC)
Date: Fri, 7 Feb 2025 20:47:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.14-rc1 kernel
Message-ID: <Z6YA2OakDUyI8Vmc@fedora>
References: <uyijd3ufbrfbiyyaajvhyhdyytssubekvymzgyiqjqmkh33cmi@ksqjpewsqlvw>
 <Z6XJuIz012XATr7h@fedora>
 <ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Feb 07, 2025 at 12:22:32PM +0000, Shinichiro Kawasaki wrote:
> On Feb 07, 2025 / 16:52, Ming Lei wrote:
> > Hi Shinichiro,
> 
> Hi Ming, thanks for the comments. Let me comment on the block/002 failure.
> 
> > > Failure description
> > > ===================
> > > 
> > > #1: block/002
> > > 
> > >     This test case fails with a lockdep WARN "possible circular locking
> > >     dependency detected". The lockdep splats shows q->q_usage_counter as one
> > >     of the involved locks. It was observed with the v6.13-rc2 kernel [2], and
> > >     still observed with v6.14-rc1 kernel. It needs further debug.
> > > 
> > >     [2] https://lore.kernel.org/linux-block/qskveo3it6rqag4xyleobe5azpxu6tekihao4qpdopvk44una2@y4lkoe6y3d6z/
> > 
> > [  342.568086][ T1023] -> #0 (&mm->mmap_lock){++++}-{4:4}:
> > [  342.569658][ T1023]        __lock_acquire+0x2e8b/0x6010
> > [  342.570577][ T1023]        lock_acquire+0x1b1/0x540
> > [  342.571463][ T1023]        __might_fault+0xb9/0x120
> > [  342.572338][ T1023]        _copy_from_user+0x34/0xa0
> > [  342.573231][ T1023]        __blk_trace_setup+0xa0/0x140
> > [  342.574129][ T1023]        blk_trace_ioctl+0x14e/0x270
> > [  342.575033][ T1023]        blkdev_ioctl+0x38f/0x5c0
> > [  342.575919][ T1023]        __x64_sys_ioctl+0x130/0x190
> > [  342.576824][ T1023]        do_syscall_64+0x93/0x180
> > [  342.577714][ T1023]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > The above dependency between ->mmap_lock and ->debugfs_mutex has been cut by
> > commit b769a2f409e7 ("blktrace: move copy_[to|from]_user() out of ->debugfs_lock"),
> > so I'd suggest to double check this one.
> 
> Thanks. I missed the fix. Said that, I do still see the lockdep WARN "possible
> circular locking dependency detected" with the kernel v6.14-rc1. Then I guess
> there are two problems and I confused them. One problem was fixed by the commit
> b769a2f409e7, and the other problem that I still observe.
> 
> Please take a look in the kernel message below, which was observed at the
> block/002 failure I have just recreated on my test node. The splat indicates the
> dependency different from that observed with v6.13-rc2 kernel.

Yeah, indeed, thanks for sharing the log.

> 
> 
> [  165.526908] [   T1103] run blktests block/002 at 2025-02-07 21:02:22
> [  165.814157] [   T1134] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
> [  166.031013] [   T1135] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
> [  166.031986] [   T1135] scsi host9: scsi_debug: version 0191 [20210520]
>                             dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  166.035727] [   T1135] scsi 9:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
> [  166.038449] [      C1] scsi 9:0:0:0: Power-on or device reset occurred
> [  166.045105] [   T1135] sd 9:0:0:0: Attached scsi generic sg3 type 0
> [  166.046426] [     T94] sd 9:0:0:0: [sdd] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> [  166.048275] [     T94] sd 9:0:0:0: [sdd] Write Protect is off
> [  166.048854] [     T94] sd 9:0:0:0: [sdd] Mode Sense: 73 00 10 08
> [  166.051019] [     T94] sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [  166.059601] [     T94] sd 9:0:0:0: [sdd] permanent stream count = 5
> [  166.063623] [     T94] sd 9:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
> [  166.064329] [     T94] sd 9:0:0:0: [sdd] Optimal transfer size 524288 bytes
> [  166.094781] [     T94] sd 9:0:0:0: [sdd] Attached SCSI disk
> 
> [  166.855819] [   T1161] ======================================================
> [  166.856339] [   T1161] WARNING: possible circular locking dependency detected
> [  166.856945] [   T1161] 6.14.0-rc1 #252 Not tainted
> [  166.857292] [   T1161] ------------------------------------------------------
> [  166.857874] [   T1161] blktrace/1161 is trying to acquire lock:
> [  166.858310] [   T1161] ffff88811dbfe5e0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x99/0x120
> [  166.859053] [   T1161] 
>                           but task is already holding lock:
> [  166.859593] [   T1161] ffff8881082a1078 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: relay_file_read+0xa3/0x8a0
> [  166.860410] [   T1161] 
>                           which lock already depends on the new lock.
> 
> [  166.861269] [   T1161] 
>                           the existing dependency chain (in reverse order) is:
> [  166.863693] [   T1161] 
>                           -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
> [  166.866064] [   T1161]        down_write+0x8d/0x200
> [  166.867266] [   T1161]        start_creating.part.0+0x82/0x230
> [  166.868544] [   T1161]        debugfs_create_dir+0x3a/0x4c0
> [  166.869797] [   T1161]        blk_register_queue+0x12d/0x430
> [  166.870986] [   T1161]        add_disk_fwnode+0x6b1/0x1010
> [  166.872144] [   T1161]        sd_probe+0x94e/0xf30
> [  166.873262] [   T1161]        really_probe+0x1e3/0x8a0
> [  166.874372] [   T1161]        __driver_probe_device+0x18c/0x370
> [  166.875544] [   T1161]        driver_probe_device+0x4a/0x120
> [  166.876715] [   T1161]        __device_attach_driver+0x15e/0x270
> [  166.877890] [   T1161]        bus_for_each_drv+0x114/0x1a0
> [  166.878999] [   T1161]        __device_attach_async_helper+0x19c/0x240
> [  166.880180] [   T1161]        async_run_entry_fn+0x96/0x4f0
> [  166.881312] [   T1161]        process_one_work+0x85a/0x1460
> [  166.882411] [   T1161]        worker_thread+0x5e2/0xfc0
> [  166.883483] [   T1161]        kthread+0x39d/0x750
> [  166.884548] [   T1161]        ret_from_fork+0x30/0x70
> [  166.885629] [   T1161]        ret_from_fork_asm+0x1a/0x30
> [  166.886728] [   T1161] 
>                           -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
> [  166.888799] [   T1161]        __mutex_lock+0x1aa/0x1360
> [  166.889863] [   T1161]        blk_mq_init_sched+0x3b5/0x5e0
> [  166.890907] [   T1161]        elevator_switch+0x149/0x4b0
> [  166.891928] [   T1161]        elv_iosched_store+0x29f/0x380
> [  166.892966] [   T1161]        queue_attr_store+0x313/0x480
> [  166.893976] [   T1161]        kernfs_fop_write_iter+0x39e/0x5a0
> [  166.895012] [   T1161]        vfs_write+0x5f9/0xe90
> [  166.895970] [   T1161]        ksys_write+0xf6/0x1c0
> [  166.896931] [   T1161]        do_syscall_64+0x93/0x180
> [  166.897886] [   T1161]        entry_SYSCALL_64_after_hwframe+0x76/0x7e

I think we can kill the above dependency, all debugfs API needn't to be
protected by q->debugfs_mutex, which is supposed for covering block
layer internal data structure update & query.

I will try to cook patch for fixing this one.


Thanks,
Ming


