Return-Path: <linux-rdma+bounces-13016-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6CCB3DC86
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 10:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E6189D203
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B52FB627;
	Mon,  1 Sep 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sc0b3nr2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BxHqpGY1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sc0b3nr2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BxHqpGY1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4A2FAC1C
	for <linux-rdma@vger.kernel.org>; Mon,  1 Sep 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715667; cv=none; b=U11IB3uXwiIsqn6W39kGkspr95vI9MYb+LiTGWphKzDn6FZCsG+H7qMXY+lDFLnH8dH+CB8w4Vny0NCqK1sCAoUBymnCVbpxsXB2V4ifnbWoov9YOB8P3QPhnLY46qMt+zWyV4SKC95F+jR/kR1BAR1e4iRpE6Vod+JG12W9dvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715667; c=relaxed/simple;
	bh=CX+TO9gDNqsfYA4iSTZNQQzCZgBpeGXDXpWJCsncFrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ8apJxCvqgjhNyyRgnxzEGjKI+hz7EE9LIM5/M4aI6qV+w5pzcipTbvOEhpEGAZBKevAP3HbBeSkjNQnCYPA45KOiC5UsgS7gFIoSa2FCpN0JrGwYsa1T5rfFMw+rfnqpLJPsWl116xRoz5kp5k2ku4JPMcJ+km1rZJjAX4sUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sc0b3nr2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BxHqpGY1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sc0b3nr2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BxHqpGY1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45F2F21A19;
	Mon,  1 Sep 2025 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756715663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUs0tvmNOhyGihKsdzrfm7Mns2CmpxurqjG3WitBJfk=;
	b=Sc0b3nr2ige8EVi76LakLqqkQVNbLrDvb0J6XGyVHRXjq1NZwQL5KtTkRsZBX0hiKQjKx9
	oZ2SQyYcncPwwNIdOBQMBXNEEcqZOo6X5zOJ+SItRwWCFI3p6NcunB+LXyrwrY34VXvwM0
	ciPOTFOw9o6ku/3JilKbm168I61O70M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756715663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUs0tvmNOhyGihKsdzrfm7Mns2CmpxurqjG3WitBJfk=;
	b=BxHqpGY1rvjhaflWoPzUdUz+03Yl3md7QpYrdNENyDY1xPmyCv4skO5A1y+Q7XfsRRjA0e
	o9jCj3X7T7lcLsBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756715663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUs0tvmNOhyGihKsdzrfm7Mns2CmpxurqjG3WitBJfk=;
	b=Sc0b3nr2ige8EVi76LakLqqkQVNbLrDvb0J6XGyVHRXjq1NZwQL5KtTkRsZBX0hiKQjKx9
	oZ2SQyYcncPwwNIdOBQMBXNEEcqZOo6X5zOJ+SItRwWCFI3p6NcunB+LXyrwrY34VXvwM0
	ciPOTFOw9o6ku/3JilKbm168I61O70M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756715663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUs0tvmNOhyGihKsdzrfm7Mns2CmpxurqjG3WitBJfk=;
	b=BxHqpGY1rvjhaflWoPzUdUz+03Yl3md7QpYrdNENyDY1xPmyCv4skO5A1y+Q7XfsRRjA0e
	o9jCj3X7T7lcLsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3376E136ED;
	Mon,  1 Sep 2025 08:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UB1ADI9atWhjXQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Sep 2025 08:34:23 +0000
Date: Mon, 1 Sep 2025 10:34:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
 <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
 <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Sat, Aug 30, 2025 at 01:15:48PM +0000, Shinichiro Kawasaki wrote:
> On Aug 28, 2025 / 13:33, Daniel Wagner wrote:
> > Would you mind to give the attached patch a try? It fixes the problem I
> > was able to reproduce.
> 
> Thanks for the effort. I applied the patch attached to v6.17-rc3 kernel an
> repeated nvme/061. It avoided the WARN and the refcount_t message. This looks
> good.

Glad to hear this!

> However, unfortunately, I observed a different failure symptom with KASAN
> slab-use-after-free [*]. I'm not sure if the fix patch unveiled this KASAN, or
> if created this KASAN. This failure is observed on my test systems in stable
> manner, but it is required to repeat nvme/061 a few hundreds of times to
> recreated it.

I am not surprised that there are more bugs popping up. Maybe it was
hidden by the previous one. Anyway let's have a look.

> Aug 29 15:26:06 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.

Do you happen to know if this is necessary to reproduce? After looking
at it, I don't think it matters.

> Aug 29 15:26:06 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connect complete
> Aug 29 15:26:06 testnode1 kernel: (NULL device *): {0:0} Association deleted
> Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to lldd error 6
> Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport association event: transport detected io error
> Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting controller
> Aug 29 15:26:07 testnode1 kernel: (NULL device *): {0:0} Association freed
> Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subsystem-1"
> Aug 29 15:26:07 testnode1 kernel: (NULL device *): queue 0 connect admin queue failed (-111).
> Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connectivity lost. Awaiting Reconnect
> Aug 29 15:26:07 testnode1 kernel: ==================================================================
> Aug 29 15:26:07 testnode1 kernel: BUG: KASAN: slab-use-after-free in fcloop_remoteport_delete+0x150/0x190 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel: Write of size 8 at addr ffff8881145fa700 by task kworker/u16:9/95
> Aug 29 15:26:07 testnode1 kernel: 
> Aug 29 15:26:07 testnode1 kernel: CPU: 0 UID: 0 PID: 95 Comm: kworker/u16:9 Not tainted 6.17.0-rc3+ #356 PREEMPT(voluntary) 
> Aug 29 15:26:07 testnode1 kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
> Aug 29 15:26:07 testnode1 kernel: Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
> Aug 29 15:26:07 testnode1 kernel: Call Trace:
> Aug 29 15:26:07 testnode1 kernel:  <TASK>
> Aug 29 15:26:07 testnode1 kernel:  dump_stack_lvl+0x6a/0x90
> Aug 29 15:26:07 testnode1 kernel:  ? fcloop_remoteport_delete+0x150/0x190 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel:  print_report+0x170/0x4f3
> Aug 29 15:26:07 testnode1 kernel:  ? __virt_addr_valid+0x22e/0x4e0
> Aug 29 15:26:07 testnode1 kernel:  ? fcloop_remoteport_delete+0x150/0x190 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel:  kasan_report+0xad/0x170
> Aug 29 15:26:07 testnode1 kernel:  ? fcloop_remoteport_delete+0x150/0x190 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel:  fcloop_remoteport_delete+0x150/0x190 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel:  nvme_fc_ctlr_inactive_on_rport.isra.0+0x1b1/0x210 [nvme_fc]
> Aug 29 15:26:07 testnode1 kernel:  nvme_fc_connect_ctrl_work.cold+0x33f/0x348e [nvme_fc]
> Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x170/0x310
> Aug 29 15:26:07 testnode1 kernel:  ? __pfx_nvme_fc_connect_ctrl_work+0x10/0x10 [nvme_fc]
> Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x180/0x310
> Aug 29 15:26:07 testnode1 kernel:  ? process_one_work+0x722/0x14b0
> Aug 29 15:26:07 testnode1 kernel:  ? lock_release+0x1ad/0x300
> Aug 29 15:26:07 testnode1 kernel:  ? rcu_is_watching+0x11/0xb0
> Aug 29 15:26:07 testnode1 kernel:  process_one_work+0x868/0x14b0
> Aug 29 15:26:07 testnode1 kernel:  ? __pfx_process_one_work+0x10/0x10
> Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x170/0x310
> Aug 29 15:26:07 testnode1 kernel:  ? assign_work+0x156/0x390
> Aug 29 15:26:07 testnode1 kernel:  worker_thread+0x5ee/0xfd0
> Aug 29 15:26:07 testnode1 kernel:  ? __pfx_worker_thread+0x10/0x10
> Aug 29 15:26:07 testnode1 kernel:  kthread+0x3af/0x770
> Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x180/0x310
> Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
> Aug 29 15:26:07 testnode1 kernel:  ? ret_from_fork+0x1d/0x4e0
> Aug 29 15:26:07 testnode1 kernel:  ? lock_release+0x1ad/0x300
> Aug 29 15:26:07 testnode1 kernel:  ? rcu_is_watching+0x11/0xb0
> Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
> Aug 29 15:26:07 testnode1 kernel:  ret_from_fork+0x3be/0x4e0
> Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
> Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
> Aug 29 15:26:07 testnode1 kernel:  ret_from_fork_asm+0x1a/0x30
> Aug 29 15:26:07 testnode1 kernel:  </TASK>
> Aug 29 15:26:07 testnode1 kernel: 
> Aug 29 15:26:07 testnode1 kernel: Allocated by task 14561:
> Aug 29 15:26:07 testnode1 kernel:  kasan_save_stack+0x2c/0x50
> Aug 29 15:26:07 testnode1 kernel:  kasan_save_track+0x10/0x30
> Aug 29 15:26:07 testnode1 kernel:  __kasan_kmalloc+0x96/0xb0
> Aug 29 15:26:07 testnode1 kernel:  fcloop_alloc_nport.isra.0+0xdb/0x910 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel:  fcloop_create_target_port+0xa6/0x5a0 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel:  kernfs_fop_write_iter+0x39a/0x5a0
> Aug 29 15:26:07 testnode1 kernel:  vfs_write+0x523/0xf80
> Aug 29 15:26:07 testnode1 kernel:  ksys_write+0xfb/0x200
> Aug 29 15:26:07 testnode1 kernel:  do_syscall_64+0x94/0x3d0
> Aug 29 15:26:07 testnode1 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Aug 29 15:26:07 testnode1 kernel: 
> Aug 29 15:26:07 testnode1 kernel: Freed by task 14126:
> Aug 29 15:26:07 testnode1 kernel:  kasan_save_stack+0x2c/0x50
> Aug 29 15:26:07 testnode1 kernel:  kasan_save_track+0x10/0x30
> Aug 29 15:26:07 testnode1 kernel:  kasan_save_free_info+0x37/0x70
> Aug 29 15:26:07 testnode1 kernel:  __kasan_slab_free+0x5f/0x70
> Aug 29 15:26:07 testnode1 kernel:  kfree+0x13a/0x4c0
> Aug 29 15:26:07 testnode1 kernel:  fcloop_delete_remote_port+0x238/0x390 [nvme_fcloop]
> Aug 29 15:26:07 testnode1 kernel:  kernfs_fop_write_iter+0x39a/0x5a0
> Aug 29 15:26:07 testnode1 kernel:  vfs_write+0x523/0xf80
> Aug 29 15:26:07 testnode1 kernel:  ksys_write+0xfb/0x200
> Aug 29 15:26:07 testnode1 kernel:  do_syscall_64+0x94/0x3d0
> Aug 29 15:26:07 testnode1 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Aug 29 15:26:07 testnode1 kernel: 
> Aug 29 15:26:07 testnode1 kernel: The buggy address belongs to the object at ffff8881145fa700
>                                    which belongs to the cache kmalloc-96 of size 96
> Aug 29 15:26:07 testnode1 kernel: The buggy address is located 0 bytes inside of
>                                    freed 96-byte region [ffff8881145fa700, ffff8881145fa760)
> Aug 29 15:26:07 testnode1 kernel: 
> Aug 29 15:26:07 testnode1 kernel: The buggy address belongs to the physical page:
> Aug 29 15:26:07 testnode1 kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1145fa
> Aug 29 15:26:07 testnode1 kernel: flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> Aug 29 15:26:07 testnode1 kernel: page_type: f5(slab)
> Aug 29 15:26:07 testnode1 kernel: raw: 0017ffffc0000000 ffff888100042280 ffffea0004792400 dead000000000002
> Aug 29 15:26:07 testnode1 kernel: raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
> Aug 29 15:26:07 testnode1 kernel: page dumped because: kasan: bad access detected
> Aug 29 15:26:07 testnode1 kernel: 
> Aug 29 15:26:07 testnode1 kernel: Memory state around the buggy address:
> Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa600: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa680: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> Aug 29 15:26:07 testnode1 kernel: >ffff8881145fa700: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> Aug 29 15:26:07 testnode1 kernel:                    ^
> Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa800: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
> Aug 29 15:26:07 testnode1 kernel: ==================================================================

The test is removing the ports while the host driver is about to
reconnect and accesses a stale pointer.

nvme_fc_create_association is calling nvme_fc_ctlr_inactive_on_rport in
the error path. The problem is that nvme_fc_create_association gets half
through the setup and then fails. In the cleanup path

	dev_warn(ctrl->ctrl.device,
		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
		ctrl->cnum, ctrl->association_id, ret);

is issued and then nvme_fc_ctlr_inactive_on_rport is called. And there
is the log message above, so it's clear the error path is taken.

But the thing is fcloop is not supposed to remove the ports when the
host driver is still using it. So there is a race window where it's
possible to enter nvme_fc_create_assocation and fcloop removing the
ports.

So between nvme_fc_create_assocation and nvme_fc_ctlr_active_on_rport.

