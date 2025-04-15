Return-Path: <linux-rdma+bounces-9450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB408A8A253
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092C7442CA6
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A194A1A;
	Tue, 15 Apr 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JfOw9fE3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D82DFA48
	for <linux-rdma@vger.kernel.org>; Tue, 15 Apr 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729231; cv=none; b=fefWxborZ7bSDkFXzWkH8Aue1jHk4Kw9LJ+nXGglUs13zf/BrJOjTR5RS/0wx8KoL/FUklWpb+NFFpcUnSxtU0b8KrijeIrukxRXwp107neKuDH/I3x3WtQ60RhqxL8PjnChlylDBTzq3EkWV7grHrHDpd1K6xTzu/pYFGBBEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729231; c=relaxed/simple;
	bh=P+J7zMOgKZ8JniDo/IpMgNzxJgHPcwdOkRCw4RxjAXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoY8/IHUfTLYYXipH63BHY4lSOrqYyVuesZBVwgQ91tGJKlbFXf/m9VcDrXoTWrg6bbZgXm60hIXiAvsaYuvy/BPsU8IhXtVmZN3HGxCl8DINEaV7aVceBbicExCV74MK/KTMbL8fbnQS1Ze0Crbz9cmvs3CMbkN/UODvD7jFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JfOw9fE3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cf845ac-fd87-4808-bb53-c4495b03e68e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744729222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThqIT2AP0ALdm3s55dR+LeeXUEMOdOL616ZKy1RI59M=;
	b=JfOw9fE3XB20w4yNNTribRYtTimDQReFh7xmzCU5IRTsrYinXOz2Tpu126UMgv2DdFSmfF
	l9moYHqc2nW+tDq9a7NQpfU3vMcb0Ne6VA7h7f5zXZ05L1Crkw+rdqmsz+CxLdsgbeEZpG
	/MLeubNBGS+ONK3ru+xr5gY8wxM+Ouk=
Date: Tue, 15 Apr 2025 17:00:20 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
To: Bernard Metzler <BMT@zurich.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <BN8PR15MB2513CD2A5725F5A035AE905699B22@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15.04.25 15:09, Bernard Metzler wrote:

> [  106.826346] rdma_rxe: loaded
> [  106.832164] loop: module loaded
> [  107.066868] run blktests nvme/061 at 2025-04-15 15:03:04
> [  107.081270] infiniband eno1_rxe: set active
> [  107.081274] infiniband eno1_rxe: added eno1
> [  107.089683] infiniband enp4s0f4d1_rxe: set active
> [  107.089687] infiniband enp4s0f4d1_rxe: added enp4s0f4d1
> [  107.264770] loop0: detected capacity change from 0 to 2097152
> [  107.267376] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  107.271276] nvmet_rdma: enabling port 0 (10.0.0.2:4420)
> [  107.312957] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [  107.312973] #PF: supervisor read access in kernel mode
> [  107.312979] #PF: error_code(0x0000) - not-present page
> [  107.312986] PGD 0 P4D 0
> [  107.312992] Oops: Oops: 0000 [#1] SMP PTI
> [  107.312999] CPU: 1 UID: 0 PID: 123 Comm: kworker/u32:4 Not tainted 6.15.0-rc2 #1 PREEMPT(undef)
> [  107.313008] Hardware name: LENOVO 10A6S05601/SHARKBAY, BIOS FBKTD8AUS 09/17/2019
> [  107.313016] Workqueue: rxe_wq do_work [rdma_rxe]
> [  107.313030] RIP: 0010:rxe_mr_copy+0x58/0x230 [rdma_rxe]

Hi, Bernard

An interesting test. Can you find the line number of 
(rxe_mr_copy+0x58/0x230) with crash tool?

Thus we can find what variable is becoming NULL pointer.

Thanks a lot.
Zhu Yanjun

> [  107.313041] Code: 83 7f 7c 04 49 89 f6 48 89 d3 41 89 cd 0f 84 f9 00 00 00 89 ca e8 68 f7 ff ff 85 c0 0f 85 95 01 00 00 49 8b 84 24 f0 00 00 00 <f6> 40 28 02 74 28 44 8b 45 d4 44 89 e9 48 89 da 4c 89 f6 4c 89 e7
> [  107.313055] RSP: 0018:ffffb00b40467cc8 EFLAGS: 00010246
> [  107.313062] RAX: 0000000000000000 RBX: ffff8f64434f804a RCX: 0000000000000400
> [  107.313070] RDX: 0000000000000400 RSI: ffff8f64b8c9cc00 RDI: ffff8f64bef78a00
> [  107.313077] RBP: ffffb00b40467d00 R08: 0000000000000000 R09: ffff8f6440b68e00
> [  107.313084] R10: ffffb00b40467d50 R11: ffff8f6440b68e00 R12: ffff8f64bef78a00
> [  107.313091] R13: 0000000000000400 R14: ffff8f64b8c9c800 R15: ffff8f64470d1000
> [  107.313098] FS:  0000000000000000(0000) GS:ffff8f6b8dc9e000(0000) knlGS:0000000000000000
> [  107.313106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  107.313129] CR2: 0000000000000028 CR3: 000000069d81a004 CR4: 00000000001706f0
> [  107.313148] Call Trace:
> [  107.313164]  <TASK>
> [  107.313170]  rxe_receiver+0x1310/0x26d0 [rdma_rxe]
> [  107.313180]  do_task+0x6b/0x1f0 [rdma_rxe]
> [  107.313189]  do_work+0xe/0x20 [rdma_rxe]
> [  107.313198]  process_one_work+0x1b3/0x400
> [  107.313206]  worker_thread+0x25b/0x370
> [  107.313212]  kthread+0x116/0x240
> [  107.313218]  ? __pfx_worker_thread+0x10/0x10
> [  107.313225]  ? _raw_spin_unlock_irq+0x17/0x40
> [  107.313233]  ? __pfx_kthread+0x10/0x10
> [  107.313239]  ret_from_fork+0x3c/0x60
> [  107.313246]  ? __pfx_kthread+0x10/0x10
> [  107.313253]  ret_from_fork_asm+0x1a/0x30
> [  107.313260]  </TASK>


