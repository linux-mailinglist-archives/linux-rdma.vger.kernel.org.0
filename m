Return-Path: <linux-rdma+bounces-5230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FEC990DAC
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 21:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C161C2246E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F6210C1F;
	Fri,  4 Oct 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNYjXU8D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD40210C18;
	Fri,  4 Oct 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066464; cv=none; b=rDL31btxF0MHcMPVhRZGotjUP3ZyoNRGOl/4dKpeLLGs/n4T3BV/95OEaKGK9wUl6ixT/wnW47byCiHFPyQedezzL/UrOEgNVKn2qaknZXcyD95aEGLV6S36iccSqcXUhWyiPT6D4ErOpvF3zJ89iKsA4RkMYlwUws/ylXin8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066464; c=relaxed/simple;
	bh=UcQhd3ogPCXBqWGuWQXCUKJzrAxN8OUEvXNKwaGzHgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsPor3IzQBNlEgWS3p3U1ER5bDGQ6SvzGYrygdK0VO8FN8FN9opnBal/b4z21Ij5Ul9FfOPcprjOKQDlU0E2mbRCceKubZYE0llyMZK2bN+w3Xa8cHO0LVPBsMZEoCOA7KzYy1qYOuAzQAg9z2IOeInmUX6e+uPZqDFcw82AZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNYjXU8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28509C4CECC;
	Fri,  4 Oct 2024 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066464;
	bh=UcQhd3ogPCXBqWGuWQXCUKJzrAxN8OUEvXNKwaGzHgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNYjXU8DLnzrHkiCoj0cqNHkrGGTP2ODQEGCJIex65mQUjuthfGfCRJZd9/fX13aC
	 7w+rqocTWkPQpuzyX40PY1CQuW5zi9o3THim+m0JpiLvPld6IphLq2VJctwRvfHZa6
	 QlWuOKCGJ3NCkuA/zIBw10DfWzV9ZNTR5w3SG0+PPea8Y2WGhqrU8oQ5/T/r8wWMNm
	 4udGxFUFH434DEA7+DkwssCB0zoBobUdjn6Riq355LWfMfcZ/xvMvBvf8/YP0uAGUA
	 E2X17BNoXdsG70qZe3ZYLTPPK4WrIowqTlbGJCY7R7aOLOx+bFq7Wd1R9B1geOEuZ1
	 yGQiiaJ0MmaWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	markzhang@nvidia.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/42] RDMA/mad: Improve handling of timed out WRs of mad agent
Date: Fri,  4 Oct 2024 14:26:25 -0400
Message-ID: <20241004182718.3673735-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

[ Upstream commit 2a777679b8ccd09a9a65ea0716ef10365179caac ]

Current timeout handler of mad agent acquires/releases mad_agent_priv
lock for every timed out WRs. This causes heavy locking contention
when higher no. of WRs are to be handled inside timeout handler.

This leads to softlockup with below trace in some use cases where
rdma-cm path is used to establish connection between peer nodes

Trace:
-----
 BUG: soft lockup - CPU#4 stuck for 26s! [kworker/u128:3:19767]
 CPU: 4 PID: 19767 Comm: kworker/u128:3 Kdump: loaded Tainted: G OE
     -------  ---  5.14.0-427.13.1.el9_4.x86_64 #1
 Hardware name: Dell Inc. PowerEdge R740/01YM03, BIOS 2.4.8 11/26/2019
 Workqueue: ib_mad1 timeout_sends [ib_core]
 RIP: 0010:__do_softirq+0x78/0x2ac
 RSP: 0018:ffffb253449e4f98 EFLAGS: 00000246
 RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 000000000000001f
 RDX: 000000000000001d RSI: 000000003d1879ab RDI: fff363b66fd3a86b
 RBP: ffffb253604cbcd8 R08: 0000009065635f3b R09: 0000000000000000
 R10: 0000000000000040 R11: ffffb253449e4ff8 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000040
 FS:  0000000000000000(0000) GS:ffff8caa1fc80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fd9ec9db900 CR3: 0000000891934006 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <IRQ>
  ? show_trace_log_lvl+0x1c4/0x2df
  ? show_trace_log_lvl+0x1c4/0x2df
  ? __irq_exit_rcu+0xa1/0xc0
  ? watchdog_timer_fn+0x1b2/0x210
  ? __pfx_watchdog_timer_fn+0x10/0x10
  ? __hrtimer_run_queues+0x127/0x2c0
  ? hrtimer_interrupt+0xfc/0x210
  ? __sysvec_apic_timer_interrupt+0x5c/0x110
  ? sysvec_apic_timer_interrupt+0x37/0x90
  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
  ? __do_softirq+0x78/0x2ac
  ? __do_softirq+0x60/0x2ac
  __irq_exit_rcu+0xa1/0xc0
  sysvec_call_function_single+0x72/0x90
  </IRQ>
  <TASK>
  asm_sysvec_call_function_single+0x16/0x20
 RIP: 0010:_raw_spin_unlock_irq+0x14/0x30
 RSP: 0018:ffffb253604cbd88 EFLAGS: 00000247
 RAX: 000000000001960d RBX: 0000000000000002 RCX: ffff8cad2a064800
 RDX: 000000008020001b RSI: 0000000000000001 RDI: ffff8cad5d39f66c
 RBP: ffff8cad5d39f600 R08: 0000000000000001 R09: 0000000000000000
 R10: ffff8caa443e0c00 R11: ffffb253604cbcd8 R12: ffff8cacb8682538
 R13: 0000000000000005 R14: ffffb253604cbd90 R15: ffff8cad5d39f66c
  cm_process_send_error+0x122/0x1d0 [ib_cm]
  timeout_sends+0x1dd/0x270 [ib_core]
  process_one_work+0x1e2/0x3b0
  ? __pfx_worker_thread+0x10/0x10
  worker_thread+0x50/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xdd/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x29/0x50
  </TASK>

Simplified timeout handler by creating local list of timed out WRs
and invoke send handler post creating the list. The new method acquires/
releases lock once to fetch the list and hence helps to reduce locking
contetiong when processing higher no. of WRs

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Link: https://lore.kernel.org/r/20240722110325.195085-1-saravanan.vajravel@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/mad.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 674344eb8e2f4..58befbaaf0ad5 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2616,14 +2616,16 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 
 static void timeout_sends(struct work_struct *work)
 {
+	struct ib_mad_send_wr_private *mad_send_wr, *n;
 	struct ib_mad_agent_private *mad_agent_priv;
-	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_send_wc mad_send_wc;
+	struct list_head local_list;
 	unsigned long flags, delay;
 
 	mad_agent_priv = container_of(work, struct ib_mad_agent_private,
 				      timed_work.work);
 	mad_send_wc.vendor_err = 0;
+	INIT_LIST_HEAD(&local_list);
 
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	while (!list_empty(&mad_agent_priv->wait_list)) {
@@ -2641,13 +2643,16 @@ static void timeout_sends(struct work_struct *work)
 			break;
 		}
 
-		list_del(&mad_send_wr->agent_list);
+		list_del_init(&mad_send_wr->agent_list);
 		if (mad_send_wr->status == IB_WC_SUCCESS &&
 		    !retry_send(mad_send_wr))
 			continue;
 
-		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+		list_add_tail(&mad_send_wr->agent_list, &local_list);
+	}
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
+	list_for_each_entry_safe(mad_send_wr, n, &local_list, agent_list) {
 		if (mad_send_wr->status == IB_WC_SUCCESS)
 			mad_send_wc.status = IB_WC_RESP_TIMEOUT_ERR;
 		else
@@ -2655,11 +2660,8 @@ static void timeout_sends(struct work_struct *work)
 		mad_send_wc.send_buf = &mad_send_wr->send_buf;
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   &mad_send_wc);
-
 		deref_mad_agent(mad_agent_priv);
-		spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	}
-	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 }
 
 /*
-- 
2.43.0


