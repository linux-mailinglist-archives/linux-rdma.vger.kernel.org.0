Return-Path: <linux-rdma+bounces-3923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E113938DD6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 13:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CB01C213B0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903716C87B;
	Mon, 22 Jul 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DQ5YG/1c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456B27702
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2024 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646221; cv=none; b=DDqGO+Qmmckpi9uazCJH2KQcHJtGqSxHKOMhGwqOzAgFXIMv0OdMLeJWJd2jP/7GnJd1D3yHpqIIXaVZHzCVlFSZmowLgv8ApLTMaU5r9bkUAuFBx97rumogNReRhkc7ev+0T9Fv2/W0HVFGb/Xw+aHyGiBtZrShBJ7jAl9+D0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646221; c=relaxed/simple;
	bh=H9SKrY71wu3AGesEf7VrHlYAbqFhbYEx5w395dN7bZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uzv0tN+UrtyYXSyn8PaEH7qxHLVh4v90om7irEGkfoYuyJKSjto8hz0jds9CRVJRaHe1GmOZopbFjLxnVep71J4qZxEJz2phEai+/fN62iOcY6HuEN69PytwO36oqy1CKPN1RsufC52xGPidTdU2eqWs+sA29IxkqZE4rH6CHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DQ5YG/1c; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso3204813a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2024 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721646219; x=1722251019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJMvVNnXfFTBaIsaLqLJMyamzajrwdA37cvDjhHwupM=;
        b=DQ5YG/1cmoidNC+RzziruopzaWBZckgpHUjqrm2tv7dsqhEE5oqbtcEjXRr37SCjTI
         VCZ7otZI7o4p1S3BeaJuE20OfPDlYSrGebr1exrbAy6Tq3lKynJVpm0qHorjcXDHLRIT
         pDXjK6IxHACxFCUxpoWlIJHi4jkX8jkkEGGlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721646219; x=1722251019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJMvVNnXfFTBaIsaLqLJMyamzajrwdA37cvDjhHwupM=;
        b=K6bVcUT2Ft0fTrXfakYRkK8mXxfLshYVHX7MJkxmZIM6/54DJhtGz8KQnf47j98mmm
         neGFtwCnn3myCbxneFYVwgS6hmU3w6ynD5gRZ/7EBHa1YBqS672dL4XbZPDC7aZjO/nM
         48+JXttEgCGrdjbz6U7BwiM+tDbbWPQw1kYGmKheQqMEcCegfiOt1o3RFBhjNWRsAert
         +UsvEQeEenPGH8N9nbnI7+7MiUmLdje+D/nIN51nCQTBI3tA8+udr3CZvU/kVR9/9a8W
         7dHoPkCEAYEnsQqomeVTc9EzLomdx0fNFbxG5rwQ8gQY9pvCZL0usFNzdRubE/nPDR9i
         iEzw==
X-Gm-Message-State: AOJu0YyDn+4aCwrjsNv4Uxv/m69Um4+q7R4etGhGeAV9O9Ll3Ee/ih6h
	SxhZkpL4xgYsKc1XICEXl3TG9p7ndoUy+NAVRuHgn1l8fSU7zC2dGdBxg6JKxVMfok28DPmjVRk
	=
X-Google-Smtp-Source: AGHT+IHA4/2x2/sR062ZIzPr8GO0ph7Iq85FaZVZbfH64W0TWeGaddd3bxAqn64UTDoFdoqU9NNn/Q==
X-Received: by 2002:a05:6a20:4320:b0:1c0:eba5:e180 with SMTP id adf61e73a8af0-1c4285ef19fmr9342196637.26.1721646218787;
        Mon, 22 Jul 2024 04:03:38 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ab3csm52174905ad.1.2024.07.22.04.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:03:38 -0700 (PDT)
From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH for-rc] rdma-core/mad: Improve handling of timed out WRs of mad agent
Date: Mon, 22 Jul 2024 16:33:25 +0530
Message-ID: <20240722110325.195085-1-saravanan.vajravel@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current timeout handler of mad agent aquires/releases mad_agent_priv
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
---
 drivers/infiniband/core/mad.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 674344eb8e2f..58befbaaf0ad 100644
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
2.39.3


