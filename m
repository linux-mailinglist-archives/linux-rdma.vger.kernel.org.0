Return-Path: <linux-rdma+bounces-16886-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJB3AQG2j2mpSwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16886-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 00:38:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6680C13A03D
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 00:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDB1B303CEBE
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 23:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702CA33C51A;
	Fri, 13 Feb 2026 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P7NNcXId"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137D330331
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025897; cv=none; b=ecoN+GIEEUESQBBDzrr+E8xj9rne3WdhlR/YJI2r/pwg2pIYT57CRzPgawXpQ+UztgSzllohDx9kRGwruJa4LvU+SQQrsHor5w19RrPR0F2HYTtmqzIRm0zBvtjOr/Nv+1vv/ovKGHS2gYdhYwesV/EgRnp4rAryBl98ofuvHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025897; c=relaxed/simple;
	bh=TXMJe3hBKLcPh/W+bHssOgmmFSwiSApZC4ftDAEiPaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pm44pg6kaKX/Z9v6pioxLlmddHD6QbzXtyUIVk7x+FRDQmV5H43YiurjHWUMGoJ7AdDSlS1BPlA0BAcaJbHY4APzyQSgXYWCRizr1Fuc1Ue9Mv4paPKCOOqOVrLClHhJFhU2Mxafyw4b3gDps/xCR5YWLrvWgZE3ZakJZ79UaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P7NNcXId; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8589b6b-504c-4fdb-b73b-83b9c97e65df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771025893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0u/IuCNWvSJPlla9QPP4kMmxoVzieNBHkIWAmPtgRc=;
	b=P7NNcXIdPcDZ58+AYdPbw5Z3ONI++aHW/pw1hK92qtUQMed4x8YZOqThUAXbMtzoF/5eoy
	JdtATkM0c7QB5T58X1JzqDFMmCFWJLc0kTEhJ/uJ8B9Lpi8Wd1Y44a+kyOPj6/Z1w7WCc2
	HR+DVY84GEc/kkzdnSO3Rs6ns34Rcvo=
Date: Fri, 13 Feb 2026 15:38:08 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: blktests failures with v6.19 kernel
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <aY7ZBfMjVIhe_wh3@shinmob>
 <5157497a-3536-4187-883e-19a54167955a@acm.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <5157497a-3536-4187-883e-19a54167955a@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16886-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 6680C13A03D
X-Rspamd-Action: no action

On 2/13/26 9:44 AM, Bart Van Assche wrote:
> On 2/12/26 11:57 PM, Shinichiro Kawasaki wrote:
>> [5] kmemleak at nvme/061 wiht rdma transport and siw driver
>>
>> unreferenced object 0xffff888114792600 (size 32):
>>    comm "kworker/2:1H", pid 66, jiffies 4295489358
>>    hex dump (first 32 bytes):
>>      c2 f6 83 05 00 ea ff ff 00 00 00 00 00 10 00 00  ................
>>      00 b0 fd 60 81 88 ff ff 00 10 00 00 00 00 00 00  ...`............
>>    backtrace (crc 3dbac61d):
>>      __kmalloc_noprof+0x62f/0x8b0
>>      sgl_alloc_order+0x74/0x330
>>      0xffffffffc1b73433
>>      0xffffffffc1bc1f0d
>>      0xffffffffc1bc8064
>>      __ib_process_cq+0x14f/0x3e0 [ib_core]
>>      ib_cq_poll_work+0x49/0x160 [ib_core]
>>      process_one_work+0x868/0x1480
>>      worker_thread+0x5ee/0xfd0
>>      kthread+0x3af/0x770
>>      ret_from_fork+0x55c/0x810
>>      ret_from_fork_asm+0x1a/0x30
> 
> There are no sgl_alloc() calls in the RDMA subsystem. I think the above
> indicates a memory leak in either the RDMA NVMe target driver or in the
> NVMe target core.

3a2c32d357db RDMA/siw: reclassify sockets in order to avoid false 
positives from lockdep
85cb0757d7e1 net: Convert proto_ops connect() callbacks to use 
sockaddr_unsized
0e50474fa514 net: Convert proto_ops bind() callbacks to use sockaddr_unsized

There are only three commits touching the siw driver between v6.18 and 
v6.19. I therefore suspect the issue is more likely in the NVMe side.

Best Regards,
Zhu Yanjun

> 
>> [7] kmemleak at zbd/009
>>
>> unreferenced object 0xffff88815f1f1280 (size 32):
>>    comm "mount", pid 1745, jiffies 4294866235
>>    hex dump (first 32 bytes):
>>      6d 65 74 61 64 61 74 61 2d 74 72 65 65 6c 6f 67  metadata-treelog
>>      00 93 9c fb af bb ae 00 00 00 00 00 00 00 00 00  ................
>>    backtrace (crc 2ee03cc2):
>>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>>      kstrdup+0x42/0xc0
>>      kobject_set_name_vargs+0x44/0x110
>>      kobject_init_and_add+0xcf/0x140
>>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>>      create_space_info+0x247/0x320 [btrfs]
>>      btrfs_init_space_info+0x143/0x1b0 [btrfs]
>>      open_ctree+0x2eed/0x43fe [btrfs]
>>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>>      vfs_get_tree+0x87/0x2f0
>>      vfs_cmd_create+0xbd/0x280
>>      __do_sys_fsconfig+0x64f/0xa30
>>      do_syscall_64+0x95/0x540
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> unreferenced object 0xffff888128d80000 (size 16):
>>    comm "mount", pid 1745, jiffies 4294866237
>>    hex dump (first 16 bytes):
>>      64 61 74 61 2d 72 65 6c 6f 63 00 4b 96 f6 48 82  data-reloc.K..H.
>>    backtrace (crc 1598f702):
>>      __kmalloc_node_track_caller_noprof+0x66b/0x8c0
>>      kstrdup+0x42/0xc0
>>      kobject_set_name_vargs+0x44/0x110
>>      kobject_init_and_add+0xcf/0x140
>>      btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
>>      create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
>>      create_space_info+0x211/0x320 [btrfs]
>>      open_ctree+0x2eed/0x43fe [btrfs]
>>      btrfs_get_tree.cold+0x90/0x1da [btrfs]
>>      vfs_get_tree+0x87/0x2f0
>>      vfs_cmd_create+0xbd/0x280
>>      __do_sys_fsconfig+0x64f/0xa30
>>      do_syscall_64+0x95/0x540
>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Please report the above to the BTRFS maintainers.
> 
> Thanks,
> 
> Bart.


