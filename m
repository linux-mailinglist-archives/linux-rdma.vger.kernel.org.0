Return-Path: <linux-rdma+bounces-16883-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHeOJ/Nij2n0QgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16883-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 18:44:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D064138B7A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C13A304E32F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 17:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025A33C501;
	Fri, 13 Feb 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QzNyeC+7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AF1C5D72;
	Fri, 13 Feb 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004651; cv=none; b=Y1nciqY7pqI0IqvOk8WqpWqGMB3PQUJBGrqdoujtEKUqrTjRzu5D00nT7oD+ycD41+zyZUcSirhjNjzL9G7LrvO07+tlENXlEd7D+flv2Gr4XHdut6ZQYk0eesIUcV8hSl6A6PZh3kx/YYJZ/vrOFpKVmQelUTOxDUuwyQIWK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004651; c=relaxed/simple;
	bh=D79a4GzqBUqsbj5ac+8oLuPoUQ+fQfKkkmR+53g3EUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qPYM6mN4+8zSifFLNRf/5bBriMqspeRdi8pDX//wmA37e6Fs0/cXPlmbp7/0FUvMAWTJy9MzNQDUMStvGjr7VXP1zu5lXytF5LhJEFLcKz9jvovBbvmJ+AmIRrhkXhlxGXNE8xkdXkdkCf+ba1+x5U6E1zTQq5oLNFw1Tm7pkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QzNyeC+7; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fCKKj6mlFzlgqwF;
	Fri, 13 Feb 2026 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771004648; x=1773596649; bh=t9RzRfvwbSgpAAn+57L/twMb
	K6THI0fSwkzw1UKZRes=; b=QzNyeC+78j+FCizjBSZLWJPixMNPatJ8HNzEwubp
	yRQdiq+UcNG4TgXbrCcSBO+1U5RLvQF2JDPAWNVvrEr9kjznYAo+foAHwGGzPjK2
	8iNettCMNTrcbNYGdjuD6pbrRwHvT07kkG+TTiCX6wWnUDwHG+0J+H4goOL9P1lh
	ey4fyk4jg112tX+f2Ac+RqUjOivwmP4IltVmK6Fk1BvJjCIe418yhhV7GOZV7IK0
	GF7K2kY2+RDX9ynJ2WTrhSKVHXX2gD16iDiIbiXGi7BvEh0+Zgid3FSsfUv10bFq
	Snt3Pp7CNxP2zBTqV4ydz3FCoyDTnnOozvhyQU0r7U2m/A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8XnJ08o8QUxG; Fri, 13 Feb 2026 17:44:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fCKKg1FjCzlfgPZ;
	Fri, 13 Feb 2026 17:44:06 +0000 (UTC)
Message-ID: <5157497a-3536-4187-883e-19a54167955a@acm.org>
Date: Fri, 13 Feb 2026 09:44:06 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.19 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <aY7ZBfMjVIhe_wh3@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aY7ZBfMjVIhe_wh3@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16883-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D064138B7A
X-Rspamd-Action: no action

On 2/12/26 11:57 PM, Shinichiro Kawasaki wrote:
> [5] kmemleak at nvme/061 wiht rdma transport and siw driver
> 
> unreferenced object 0xffff888114792600 (size 32):
>    comm "kworker/2:1H", pid 66, jiffies 4295489358
>    hex dump (first 32 bytes):
>      c2 f6 83 05 00 ea ff ff 00 00 00 00 00 10 00 00  ................
>      00 b0 fd 60 81 88 ff ff 00 10 00 00 00 00 00 00  ...`............
>    backtrace (crc 3dbac61d):
>      __kmalloc_noprof+0x62f/0x8b0
>      sgl_alloc_order+0x74/0x330
>      0xffffffffc1b73433
>      0xffffffffc1bc1f0d
>      0xffffffffc1bc8064
>      __ib_process_cq+0x14f/0x3e0 [ib_core]
>      ib_cq_poll_work+0x49/0x160 [ib_core]
>      process_one_work+0x868/0x1480
>      worker_thread+0x5ee/0xfd0
>      kthread+0x3af/0x770
>      ret_from_fork+0x55c/0x810
>      ret_from_fork_asm+0x1a/0x30

There are no sgl_alloc() calls in the RDMA subsystem. I think the above
indicates a memory leak in either the RDMA NVMe target driver or in the
NVMe target core.

> [7] kmemleak at zbd/009
> 
> unreferenced object 0xffff88815f1f1280 (size 32):
>    comm "mount", pid 1745, jiffies 4294866235
>    hex dump (first 32 bytes):
>      6d 65 74 61 64 61 74 61 2d 74 72 65 65 6c 6f 67  metadata-treelog
>      00 93 9c fb af bb ae 00 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 2ee03cc2):
>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>      kstrdup+0x42/0xc0
>      kobject_set_name_vargs+0x44/0x110
>      kobject_init_and_add+0xcf/0x140
>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>      create_space_info+0x247/0x320 [btrfs]
>      btrfs_init_space_info+0x143/0x1b0 [btrfs]
>      open_ctree+0x2eed/0x43fe [btrfs]
>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>      vfs_get_tree+0x87/0x2f0
>      vfs_cmd_create+0xbd/0x280
>      __do_sys_fsconfig+0x64f/0xa30
>      do_syscall_64+0x95/0x540
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff888128d80000 (size 16):
>    comm "mount", pid 1745, jiffies 4294866237
>    hex dump (first 16 bytes):
>      64 61 74 61 2d 72 65 6c 6f 63 00 4b 96 f6 48 82  data-reloc.K..H.
>    backtrace (crc 1598f702):
>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>      kstrdup+0x42/0xc0
>      kobject_set_name_vargs+0x44/0x110
>      kobject_init_and_add+0xcf/0x140
>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>      create_space_info+0x211/0x320 [btrfs]
>      open_ctree+0x2eed/0x43fe [btrfs]
>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>      vfs_get_tree+0x87/0x2f0
>      vfs_cmd_create+0xbd/0x280
>      __do_sys_fsconfig+0x64f/0xa30
>      do_syscall_64+0x95/0x540
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e

Please report the above to the BTRFS maintainers.

Thanks,

Bart.

