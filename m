Return-Path: <linux-rdma+bounces-21427-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD+8ONIVGGrKbggAu9opvQ
	(envelope-from <linux-rdma+bounces-21427-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 12:15:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E45F066D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 12:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 411C2307EE1E
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64963793C6;
	Thu, 28 May 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GbFiFNB8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43633A03A
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962553; cv=none; b=BeR3j800JSilwNIbqrxpcfLhmx2VhXWpGmLPnxPzQnktw7DfRRRqoMYHzENg29VCCww0jhTxZbn9CICrK/xzsn33RjAKhbHRTBInfoXRe6OBzVjNMMEERX09iWYh52Mj4Qkru7dabeRk2MV4L6U00QeYlCVedLg30TU8QzYBI+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962553; c=relaxed/simple;
	bh=WC8bhNqhQI6ok+lYewjNkzGNaQrIf1SxGQJ3MGJi+5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwljUbVHt29vRm5/+wCVbzRtRG2ArqDzC6OPbrz0GbwYrpvz8JrE9/iZcgToe1sfmd0rg90jnYVWs8vjwT0aiPhhSUFC7dZHPpfBLN3TDUurLbqZVMUjAA34buvz1sq0j25nKO0zJ+GcQ0VD/1hmZb2vH1ertOFiqa7W/5g+bZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GbFiFNB8; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94d830ba-a8ec-4505-84e0-947a930ccf0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779962540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oejTxN9lF8TU+UST/6qHxdWQ8Qa2Iqj1rEXdtZAOGxc=;
	b=GbFiFNB84PzamiMmdoTUGBp37rckKJqA7QiSwbnqos+obaFzLLxOyp364q13z8YYtgQLi/
	aqB2Tjo7/GR7J3ut+9qyjhQ//c60DWZBFSFN2OD8G2Jr4dr1Kj+maJlofRyThuzgBKqq8H
	F3JY6DJyIXtRr55SM+Z3HCXDt6sS0HA=
Date: Thu, 28 May 2026 12:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] KASAN: slab-use-after-free in siw_cm_work_handler
To: Shuangpeng <shuangpeng.kernel@gmail.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <FFC7BFD6-EDB5-49AE-ACB5-A2F940D8F687@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <FFC7BFD6-EDB5-49AE-ACB5-A2F940D8F687@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21427-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 075E45F066D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28.05.2026 05:52, Shuangpeng wrote:
> Hi Kernel Maintainers,
> 
> I hit the following KASAN report while testing current upstream kernel:
> 
> KASAN: slab-use-after-free in siw_cm_work_handler
> 
> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> 
> The reproducer, detailed document, and .config files are here:
> https://gist.github.com/shuangpengbai/f8a60ffa1b95c54672433bd9ee82e8ce
> 
> I’m happy to test debug patches or provide additional information.
> 

Thanks Shuangpeng, I will look at it next week.
I am currently travelling w/o access to any
development environment.

Thanks for reporting!
Bernard.

> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> 
> 
> 
> [   60.059964][  T817] ==================================================================
> [   60.060980][  T817] BUG: KASAN: slab-use-after-free in siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1053 drivers/infiniband/sw/siw/siw_cm.c:1075)
> [   60.062008][  T817] Write of size 8 at addr ffff888170c8ac70 by task kworker/u8:1/817
> [   60.063033][  T817]
> [   60.063347][  T817] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   60.063350][  T817] Workqueue: siw_cm_wq siw_cm_work_handler
> [   60.063356][  T817] Call Trace:
> [   60.063359][  T817]  <TASK>
> [   60.063361][  T817]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
> [   60.063369][  T817]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
> [   60.063385][  T817]  kasan_report (mm/kasan/report.c:595)
> [   60.063399][  T817]  siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1053 drivers/infiniband/sw/siw/siw_cm.c:1075)
> [   60.063472][  T817]  process_scheduled_works (kernel/workqueue.c:3314 kernel/workqueue.c:3397)
> [   60.063477][  T817]  worker_thread (kernel/workqueue.c:3478)
> [   60.063484][  T817]  kthread (kernel/kthread.c:436)
> [   60.063495][  T817]  ret_from_fork (arch/x86/kernel/process.c:158)
> [   60.063511][  T817]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> [   60.063515][  T817]  </TASK>
> [   60.063516][  T817]
> [   60.087529][  T817] Freed by task 817 on cpu 1 at 60.059899s:
> [   60.088264][  T817]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
> [   60.088821][  T817]  kasan_save_free_info (mm/kasan/generic.c:584)
> [   60.089385][  T817]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
> [   60.089940][  T817]  kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
> [   60.090383][  T817]  siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:141 drivers/infiniband/sw/siw/siw_cm.c:1051 drivers/infiniband/sw/siw/siw_cm.c:1075)
> [   60.090979][  T817]  process_scheduled_works (kernel/workqueue.c:3314 kernel/workqueue.c:3397)
> [   60.091616][  T817]  worker_thread (kernel/workqueue.c:3478)
> [   60.092191][  T817]  kthread (kernel/kthread.c:436)
> [   60.092637][  T817]  ret_from_fork (arch/x86/kernel/process.c:158)
> [   60.093226][  T817]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> [   60.093782][  T817]
> [   60.094033][  T817] The buggy address belongs to the object at ffff888170c8ac00
> [   60.094033][  T817]  which belongs to the cache kmalloc-256 of size 256
> [   60.095541][  T817] The buggy address is located 112 bytes inside of
> [   60.095541][  T817]  freed 256-byte region [ffff888170c8ac00, ffff888170c8ad00)
> 
> 
> 
> 
> Best,
> Shuangpeng
> 


