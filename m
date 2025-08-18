Return-Path: <linux-rdma+bounces-12808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8BB29FAE
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 12:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71CF1773A4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1767630FF22;
	Mon, 18 Aug 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tj/Bm0j2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE430100E;
	Mon, 18 Aug 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514436; cv=none; b=u0Ag04Zl8H+WGqN1EznOb1/YZFtf3Q7i17cbeswqwMbOQI1DfsEqDTd7OYHFBSGkS/aTASSIk3ICzQDrydRF7b7nR+vsH+mOwWwBf8bU5xs0CwPMzxuLqlzubraDgFwF830gplFAIUuAj/+pjC66kOIYLJ97bYBnC1Oo3M2hcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514436; c=relaxed/simple;
	bh=bdkGFGntJn6b9/DexCBKcDKT9nz79mQibMj1XFOZbAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGnSIcWusYB7agiqeRG1GmcUeE3GYtv7Cg4IlQ923yP28LTwvEij7+XvLCykNs+6OV4nrt346b7V9JGZ2vtY70QNWEXtye5npxbbg+WMTRBVUmcezqFyaSE8rCnfnNnffCKSzRw2RY6mnD+ZaoTPXhLw1jCCJfxJzhw5DOlB00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tj/Bm0j2; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755514424; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=UC+BNZzpQ+2R/7vUVL670jKwVT1hX1AhqBX1uis4yPM=;
	b=Tj/Bm0j27okO4rsi+mbgGvlrgwicdRTNTF/uIGXmKv0ArGiJOkb0XWoGVxfywZrPPtZlac6pQHsC6h8FwElRGkkBtVU39vhQTSwlZGF7o42CEFjVgT+jm9wGkMgZNChGARmk8uwCKrbLnCLPnV7q4PtAGeszYVNY/eQrY57BIkc=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wm-j9fQ_1755514423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 18:53:43 +0800
Date: Mon, 18 Aug 2025 18:53:43 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, Mahanta.Jambigi@ibm.com,
	Sidraya.Jayagond@ibm.com, wenjia@linux.ibm.com,
	wintera@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, jaka@linux.ibm.com
Subject: Re: [PATCH net] net/smc: fix UAF on smcsk after smc_listen_out()
Message-ID: <aKMGNyMUUwq7ufT7@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250818054618.41615-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818054618.41615-1-alibuda@linux.alibaba.com>

On 2025-08-18 13:46:18, D. Wythe wrote:
>BPF CI testing report a UAF issue:
>
>  [   16.446633] BUG: kernel NULL pointer dereference, address: 000000000000003  0
>  [   16.447134] #PF: supervisor read access in kernel mod  e
>  [   16.447516] #PF: error_code(0x0000) - not-present pag  e
>  [   16.447878] PGD 0 P4D   0
>  [   16.448063] Oops: Oops: 0000 [#1] PREEMPT SMP NOPT  I
>  [   16.448409] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Tainted: G           OE      6.13.0-rc3-g89e8a75fda73-dirty #4  2
>  [   16.449124] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODUL  E
>  [   16.449502] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/201  4
>  [   16.450201] Workqueue: smc_hs_wq smc_listen_wor  k
>  [   16.450531] RIP: 0010:smc_listen_work+0xc02/0x159  0
>  [   16.452158] RSP: 0018:ffffb5ab40053d98 EFLAGS: 0001024  6
>  [   16.452526] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 000000000000030  0
>  [   16.452994] RDX: 0000000000000280 RSI: 00003513840053f0 RDI: 000000000000000  0
>  [   16.453492] RBP: ffffa097808e3800 R08: ffffa09782dba1e0 R09: 000000000000000  5
>  [   16.453987] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0978274640  0
>  [   16.454497] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa09782d4092  0
>  [   16.454996] FS:  0000000000000000(0000) GS:ffffa097bbc00000(0000) knlGS:000000000000000  0
>  [   16.455557] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003  3
>  [   16.455961] CR2: 0000000000000030 CR3: 0000000102788004 CR4: 0000000000770ef  0
>  [   16.456459] PKRU: 5555555  4
>  [   16.456654] Call Trace  :
>  [   16.456832]  <TASK  >
>  [   16.456989]  ? __die+0x23/0x7  0
>  [   16.457215]  ? page_fault_oops+0x180/0x4c  0
>  [   16.457508]  ? __lock_acquire+0x3e6/0x249  0
>  [   16.457801]  ? exc_page_fault+0x68/0x20  0
>  [   16.458080]  ? asm_exc_page_fault+0x26/0x3  0
>  [   16.458389]  ? smc_listen_work+0xc02/0x159  0
>  [   16.458689]  ? smc_listen_work+0xc02/0x159  0
>  [   16.458987]  ? lock_is_held_type+0x8f/0x10  0
>  [   16.459284]  process_one_work+0x1ea/0x6d  0
>  [   16.459570]  worker_thread+0x1c3/0x38  0
>  [   16.459839]  ? __pfx_worker_thread+0x10/0x1  0
>  [   16.460144]  kthread+0xe0/0x11  0
>  [   16.460372]  ? __pfx_kthread+0x10/0x1  0
>  [   16.460640]  ret_from_fork+0x31/0x5  0
>  [   16.460896]  ? __pfx_kthread+0x10/0x1  0
>  [   16.461166]  ret_from_fork_asm+0x1a/0x3  0
>  [   16.461453]  </TASK  >
>  [   16.461616] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)  ]
>  [   16.462134] CR2: 000000000000003  0
>  [   16.462380] ---[ end trace 0000000000000000 ]---
>  [   16.462710] RIP: 0010:smc_listen_work+0xc02/0x1590
>
>The direct cause of this issue is that after smc_listen_out_connected(),
>newclcsock->sk may be NULL since it will releases the smcsk. Therefore,
>if the application closes the socket immediately after accept,
>newclcsock->sk can be NULL. A possible execution order could be as
>follows:
>
>smc_listen_work                                 | userspace
>-----------------------------------------------------------------
>lock_sock(sk)                                   |
>smc_listen_out_connected()                      |
>| \- smc_listen_out                             |
>|    | \- release_sock                          |
>     | |- sk->sk_data_ready()                   |
>                                                | fd = accept();
>                                                | close(fd);
>                                                |  \- socket->sk = NULL;
>/* newclcsock->sk is NULL now */
>SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk))
>
>Since smc_listen_out_connected() will not fail, simply swapping the order
>of the code can easily fix this issue.
>
>Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> net/smc/af_smc.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 9311c38f7abe..e0e48f24cd61 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -2568,8 +2568,9 @@ static void smc_listen_work(struct work_struct *work)
> 			goto out_decl;
> 	}
> 
>-	smc_listen_out_connected(new_smc);
> 	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
>+	/* smc_listen_out() will release smcsk */
>+	smc_listen_out_connected(new_smc);
> 	goto out_free;
> 
> out_unlock:
>-- 
>2.45.0
>

