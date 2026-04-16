Return-Path: <linux-rdma+bounces-19382-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPuiJDSN4GnNjgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19382-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 09:18:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3940AF35
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 09:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6F0730247FF
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6553F3890E1;
	Thu, 16 Apr 2026 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="LDbSdHS0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE403563DD
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776323863; cv=none; b=Rgow1P1Y+nDtghTOKOIrMhxfjxZsg5aKc571f/ZMm4UQesxOEgWPbVxvGRgEM1pMB57lmZYtJAAo2cgEDxe3MvJOfJWOhvkZAPBBGCUM7pg3Y5J4bizSn4Qm0RR6L9HhZygtFffbAB6QSu/oDdMyGRzqBiUxTyUHcrHlfCQf3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776323863; c=relaxed/simple;
	bh=XPDX8mrYjg3Jp/T4eisN5D3/bfj+vWk6KNANQ5CM9Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7nU2lXC7X5iEymc0IzRAC6Tvu0687GSNUpukhoim8aGnDWqQC3KqTBq8myFapRua8m9G76d63AiwGLTKjVpLKDRYwLM7DC7ehDiKbFKqVWWKCayR1kOSAIXeJPOZbLnYHDn9ykgTsvVtGtYbDhRtr7Uaojps0nwY44mx9AMdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=LDbSdHS0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E0B43F790
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776323852;
	bh=y61MtlkOiybG1V4CwysVZFJDayQvZg3YVFuKkra8lkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=LDbSdHS0D3OZFmQXfvAto3n+s9AssrFlFo/YJ1Bv0gE8qLsbhw/OZyrNasEs1s2gG
	 3nL955VBdByMEbCc3t3dWcyhI5dvagq0yoppK03f9qyJLjDE4gzSBjUvMMszjGb2bJ
	 3VIJGYRPxg0bXcO++F722q1BaVeVImdn6z040Zv5Fg5MU9Cw4FEW7Vv+8WhQtDuY7X
	 8TUfmyuQ6sBy7dZ3MQUKFOQ7WRRPiLU+evnVqmkuK2W2nH05B99+d1bE5i2ZvKuj0H
	 Lg0cQaYGduGjOGV4r122s9jtN7QcP77ADM3O6r5eiYSxIvfox/oI5J1Ic65Y9E2Htc
	 v/CmT1wFQvgIGJ6ZWtniIW3jVyP8G7StjoqSUOoOOR2Latr/fu4GbO4l4r21FXGelj
	 GzABitEenawRQSAwOsxId/1UW3laSBozG/7Y50m0/WqHW+omGXJ7Fy700P9HhYeoUj
	 SFoLKZQZR8hIlyGuS6+Vt9SV/k3hxDDIMb3BFi069B944iqgZt0kNnk3PDYhFIDrUd
	 pu313ojjzEnHiUCE9ZzxPWyJL11heqWOvFXg6LNUb3C4K9MWnPskRUZen5+8DSmY94
	 9DNH6jA59Lhaj/97J9if7oqvTyq/8OkAtO3Uz3JAm97BlztwjOBAGDPj0sTyKaCTBE
	 KuevdEdqRQBVQlJxNoTncVHo=
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c795fa31e18so597665a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 00:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323850; x=1776928650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y61MtlkOiybG1V4CwysVZFJDayQvZg3YVFuKkra8lkU=;
        b=JgF5jWlneOVH2uKL2e0K4SH9ONuBO0R8ZrJiC3+vYGVyuvXdbn79xg8bkv31/DQwBQ
         kCMA0uBwy2MSHNHVsEejvID01J7d6ne1xR7cllJSlUigCmocykiSDLi78/Az5IqMbfRB
         eBErcIJhZhDvmmDBf7mA7A13oyhLnD7mA7E+2T56i6RZXNez2tagrHN0mSUoCUkexooM
         Kd5tP2o1gJUpBeoAF7H1WWYeop4ZFssDnKDNZ5qMNELt6ZxZCrT5K2zL41Ww78AA14zw
         zvM1KzdypYfTgDyCb7xhPOyxUmCDVWlz5B619nc9HSz7xt/OX9QA0XK4sYUyBi4gjNrz
         ByAQ==
X-Gm-Message-State: AOJu0YyN5l23ATsHL2e6zAAsAG2X5HDZ5bk67f5Tai5UPetgK20DUW3J
	ls75efs3hujw65WhN7P/22bYj+BJMwtRNjUN4j4RNzYYj7VJsFCB/YZgH28WKtZoVGgFptrTDit
	HVTbS5+qALQOQscise/eQmGmvjzc8jftrWn8+4kmQ9DL9zcYT2Gm4hCVSyQeEeML2MXsztFwRH+
	WQBAzVcdhn9RDXpA==
X-Gm-Gg: AeBDievy9buWFc/xzgONPNawd5exGAjXX6++3R3ipKW0t2TgjHm1D5W43ZACRWsGcNC
	8bQxBzEWqTSGVHc2WMoa7USepuXwk93fhyDUX69aiaT7UuvGAYu7FgAQaaDUBJlXDeFalmFc7QT
	9yS0arBDYGYHcH3n2OWMC3Q3EE/klXgWzpiU84+g0OPgKFxpHbmxYvvmtF3RRbKyWA3RoRfd9F6
	RzufqyYfuIoN54nsUW5rhmGO/60TAhFzCGZ6/STXr6YYzFiXk/wqFS5tMCiuyK5YeVYowW/2MQG
	0uMC9IWkGSHeo1a1di50aGyixgeZnVQhMZ5rQf0jT/yaa6IPLw/ByJRWm7waBOA2XZYIgGevo5R
	D3L9Bc6TZiPYOlFQSnI2gosmKxoboNKhr7VryunOJCQ==
X-Received: by 2002:a05:6a20:4306:b0:398:c351:aa0e with SMTP id adf61e73a8af0-39fe3da4293mr25012672637.25.1776323850451;
        Thu, 16 Apr 2026 00:17:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:4306:b0:398:c351:aa0e with SMTP id adf61e73a8af0-39fe3da4293mr25012643637.25.1776323850024;
        Thu, 16 Apr 2026 00:17:30 -0700 (PDT)
Received: from cnode.tail.seyeong.kim ([39.118.66.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79581a2fc2sm3976343a12.21.2026.04.16.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:17:29 -0700 (PDT)
From: Seyeong Kim <seyeong.kim@canonical.com>
To: linux-rdma@vger.kernel.org
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Seyeong Kim <seyeong.kim@canonical.com>
Subject: [RFC PATCH] RDMA/irdma: Suppress PF reset on HMC error
Date: Thu, 16 Apr 2026 07:15:41 +0000
Message-ID: <20260416071541.3899471-1-seyeong.kim@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-19382-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[seyeong.kim@canonical.com,linux-rdma@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13B3940AF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The irdma driver currently issues an unconditional PF reset whenever the
HMC Error interrupt (PFINT_OICR bit 26) fires:

	if (event->reg & IRDMAPFINT_OICR_HMC_ERR_M) {
		ibdev_err(&iwdev->ibdev, "HMC Error\n");
		iwdev->rf->reset = true;
	}

request_reset() issues an IIDC_PFR to ice. In practice a single HMC_ERR
can trigger cascading PF resets, IOMMU faults during teardown, and
teardown of every RDMA connection on the device.

i40e handles the identically-named interrupt by reading
PFHMC_ERRORINFO and PFHMC_ERRORDATA and logging them without touching
device state; see commit 9c010ee0ea5f ("i40e: Suppress HMC error to
Interrupt message level") which removed the reset as "not necessary".
This patch mirrors that handling on irdma.

With this change, repeated HMC_ERR no longer produces a reset storm and
RDMA traffic on the device continues uninterrupted.

Signed-off-by: Seyeong Kim <seyeong.kim@canonical.com>
---
Notes for reviewers
-------------------

Posted as RFC because some details are inferred rather than verified
against the E810 datasheet:

1. Register offsets. PFHMC_ERRORINFO (0x00520400) and PFHMC_ERRORDATA
   (0x00520500) are inferred from the same 0x00520000 PFHMC bank as
   PFHMC_PDINV (0x00520300); they have not been verified against the
   datasheet.

2. HMC error semantics. The assumption that every E810 HMC_ERR is
   safe to continue past is not datasheet-confirmed. A conditional
   reset branch analogous to the existing PE_CRITERR /
   IRDMA_Q1_RESOURCE_ERR whitelist can be added on top if needed.

3. Test methodology. The interrupt was forced via a /dev/mem bit
   write to PFINT_OICR, which exercises the handler path but does
   not reproduce firmware-triggered HMC errors directly.

Testing details
---------------

Tested on:
  Kernel   : 6.8.0-110-generic (Ubuntu 24.04.4)
  Adapter  : Intel E810-XXV for SFP [8086:159b rev02], 2-port
  NVM      : 3.10, fw.mgmt 6.1.9, irdma fw 1.57, DDP 1.3.36.0
  Repro    : writel(BIT(26), BAR0 + 0x0016CA00) via /dev/mem
  Workload : ib_write_bw -R -F -q 4 -D 60 across the two ports
             (netns-isolated), HMC_ERR forced three times during
             the 60-second run

Before the patch, one forced HMC_ERR produced "HMC Error / Requesting
a reset" followed by two further HMC_ERR occurrences during the reset
cycle, plus DMAR DMA read faults on each teardown. After the patch,
each forced HMC_ERR produced a single "HMC Error: errinfo=...
errdata=..." line and no reset; the ib_write_bw run completed at
1103 MB/s with no interruption.

 drivers/infiniband/hw/irdma/i40iw_hw.c  | 4 +++-
 drivers/infiniband/hw/irdma/icrdma_hw.c | 2 ++
 drivers/infiniband/hw/irdma/icrdma_hw.h | 2 ++
 drivers/infiniband/hw/irdma/icrdma_if.c | 8 ++++++--
 drivers/infiniband/hw/irdma/irdma.h     | 2 ++
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.c b/drivers/infiniband/hw/irdma/i40iw_hw.c
index 60c1f2b1811d..8301938b4543 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.c
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.c
@@ -29,7 +29,9 @@ static u32 i40iw_regs[IRDMA_MAX_REGS] = {
 	I40E_PFHMC_PDINV,
 	I40E_GLHMC_VFPDINV(0),
 	I40E_GLPE_CRITERR,
-	0xffffffff      /* PFINT_RATEN not used in FPK */
+	0xffffffff,     /* PFINT_RATEN not used in FPK */
+	0xffffffff,     /* PFHMC_ERRORINFO not used in FPK */
+	0xffffffff      /* PFHMC_ERRORDATA not used in FPK */
 };
 
 static u32 i40iw_stat_offsets[] = {
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.c b/drivers/infiniband/hw/irdma/icrdma_hw.c
index 32f26284a788..b1f1b5485762 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.c
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.c
@@ -29,6 +29,8 @@ static u32 icrdma_regs[IRDMA_MAX_REGS] = {
 	GLHMC_VFPDINV(0),
 	GLPE_CRITERR,
 	GLINT_RATE(0),
+	PFHMC_ERRORINFO,
+	PFHMC_ERRORDATA,
 };
 
 static u64 icrdma_masks[IRDMA_MAX_MASKS] = {
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.h b/drivers/infiniband/hw/irdma/icrdma_hw.h
index d97944ab45da..0acdeda1236d 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.h
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.h
@@ -40,6 +40,8 @@
 #define GLHMC_VFPDINV(_i)	(0x00528300 + ((_i) * 4)) /* _i=0...31 */
 #define GLPE_CRITERR		0x00534000
 #define GLINT_RATE(_INT)	(0x0015A000 + ((_INT) * 4)) /* _i=0...2047 */ /* Reset Source: CORER */
+#define PFHMC_ERRORINFO		0x00520400
+#define PFHMC_ERRORDATA		0x00520500
 
 #define ICRDMA_DB_ADDR_OFFSET		(8 * 1024 * 1024 - 64 * 1024)
 
diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 2172a2092e3f..4b451d8482a4 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -91,8 +91,12 @@ static void icrdma_iidc_event_handler(struct iidc_rdma_core_dev_info *cdev_info,
 			}
 		}
 		if (event->reg & IRDMAPFINT_OICR_HMC_ERR_M) {
-			ibdev_err(&iwdev->ibdev, "HMC Error\n");
-			iwdev->rf->reset = true;
+			u32 hmc_errinfo = readl(iwdev->rf->sc_dev.hw_regs[IRDMA_PFHMC_ERRORINFO]);
+			u32 hmc_errdata = readl(iwdev->rf->sc_dev.hw_regs[IRDMA_PFHMC_ERRORDATA]);
+
+			/* Log diagnostics; do not reset here. */
+			ibdev_warn(&iwdev->ibdev, "HMC Error: errinfo=0x%08x errdata=0x%08x\n",
+				   hmc_errinfo, hmc_errdata);
 		}
 		if (event->reg & IRDMAPFINT_OICR_PE_PUSH_M) {
 			ibdev_err(&iwdev->ibdev, "PE Push Error\n");
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index ff938a01d70c..e8cda27d7854 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -66,6 +66,8 @@ enum irdma_registers {
 	IRDMA_GLHMC_VFPDINV,
 	IRDMA_GLPE_CRITERR,
 	IRDMA_GLINT_RATE,
+	IRDMA_PFHMC_ERRORINFO,
+	IRDMA_PFHMC_ERRORDATA,
 	IRDMA_MAX_REGS, /* Must be last entry */
 };
 
-- 
2.43.0


