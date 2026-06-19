Return-Path: <linux-rdma+bounces-22371-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PrOgOg/NNGphhQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22371-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 07:01:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA46A3E4F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 07:01:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=ZEWq9cfm;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22371-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22371-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D728C302759D
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E4315D23;
	Fri, 19 Jun 2026 05:00:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61665301474
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2026 05:00:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845258; cv=none; b=iZ8DT/e/l3sKhnPs+adEqpcWljciBPBnTEsCNxJQHHXRVS80RcgiPgUtFSE6DNWXEDmqC9XwAYd7JDEgoIdInj98Ci+EdIl6z1V22BRpE8jn8YJf80vONjsXBtaziAlBcIHoG7mVV2lqXrZ4ADUyY2xpBxQA+RFMeDXCGkXCKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845258; c=relaxed/simple;
	bh=c3kQj1GQlx40HHQiQvyzs1YrwxoPHgoBNBXDFg6n5Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlI1vHeLraFCUbhOK4X5i2D9WwvazDOsShEeeXgVKcYPRtPsa3KW0luZWr9fNbQzCQhWA43Smb7104V1GLcsDJVQWk1AD+38qalW6zfWJhZ7tGxHyXNGkacghWDWDoU17d9P6e59/FUg7au2M7fBXp1StME/pWUM6WB6k1K1CtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZEWq9cfm; arc=none smtp.client-ip=185.125.188.123
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 91A583F96E
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2026 05:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781845253;
	bh=dq7k2qixv5n5QsQAv2VQBIBM10GjustBkFtn+GrOoEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ZEWq9cfm2bgoCcB2qFJW3kpzpcrO39Gb4U8d0XGhSFHGwH1kSX5ItCOZx02a7/0VU
	 YbsEyUEJnkmoPj1YwSIr465XMfl8dzlXIs7GcRUBkynAUSRWDyn0RXhOir2ocmMNUg
	 OM20A3HSmDduicyYsuJwnNjBa/eO8zmqB32dDj5VayXWYnIqd9T9wJRA1R+ewcqbZm
	 Gv14WvGvPOi3gfzv95IOMv/21jFWCy+CHT3C2/fjgcA4o1NlKcTS68jePdl5k19ZXe
	 DiUD9xC5bwqo5v5JsgQhU4n6CKXZQ3z0N+UiOltUrbUrSvZ7o4qRM+Lu7hgn53VpkK
	 Z9vv37348lr0f43VezJhNQv5OrSt50ronWUc8XEf5QwrZqb55m7s52nFDs5KBm0d24
	 bUNTXCsI/sGHidCGC7I7IpbP3MLMsNUxVlmjOwrYrLLZO1ZhuFUaspnL84tXz1k4aV
	 eCYPrW1BR+43K16Rt3bFOCkHyxyXC1GMjq9rbE3Cc6v6RpLEn6vjqPx6FHGl5TK/th
	 22fF8R0VgChgGZNbXSPrOfH8YDF33Xoj29uaWDgDjwDxS3OI7OOisXDUDVA4sm+fwL
	 IiHz+cCY2OZsgts9hMyDmfHvupuwtHvgSB9qJzglK1pjTdQKy652qRe0h46lqTY+Ro
	 7003Y4gtMfT3P6VSw1Iem1TA=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37c85c9ac50so1534787a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 22:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781845252; x=1782450052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq7k2qixv5n5QsQAv2VQBIBM10GjustBkFtn+GrOoEM=;
        b=qk3AvOnoB5kgWoLXfBnfDS1ODFAbzecdvM+f+Hb69YI1cXwqTkIV+IqnyhIWzqgz4H
         D1BIZ/09Nv9B5GAin9BvDWnTxszgVPPX1E6zv8vEOCamJiNeCLZB51K3FcIBqwTy2DTJ
         UNRpR/x4hPr3V8PQkrNGarmrOCcdqrTnGaLpvF8A5cwTNBqmGpbHY2JjA4NtyvgwwEdg
         M0knVenDgEQmjNBKWflCL96RkGFdE9wWzCFOJzqlTr/kh/nHwDEnpXfODY4LA8Idu89x
         xM6H6lPfGkTdhtzwix6QE37ovs3oXGdH3yfryxrof4z4mgca9V92Gu0uKzo3YKx9XZ6a
         RzLw==
X-Gm-Message-State: AOJu0YzFr0M6dl27f6GXkQRsWzcnbf+nRy8uftg/Yb7+DrpUC1+MQOYK
	p6drWYizPwDzhuaNRgqOLLtcnG0O2Lxx3pngAZR55dlgywiySdxwhrZbpOX0r29W0F277Q5zJwX
	sy9PTDMnq5SsJURJDZDc6ecEerhC53EpKHk4gSCH2ynvD/AtHN6whAzTSU7Rye4fVfqJB4PBcBG
	T63RUygbVx0WLYaQ==
X-Gm-Gg: AfdE7cm4tJq9vDWpuv7KXWYDf3kJPzwb/n5sfKKzlSFHCHUE0OHFxAAZg5SGRvOV4Bh
	sGbEXoyc+z6tjmVXAhe78oTVJzVRFE9lpb/MOMXPQEM8nFN4ecLLLGHkRFNJRnWfrzeob8qm5sO
	XD8iIdOPeUPEiWdqKuQdtOY5OyS8aeLGbsk3Rf2jXeCnp89MiQ6EzDMvuV2BNhlb/Jcqa47x8Af
	UNjUYcaALqlgn84jeqie2/zWxc0odpMNNxlkTpLlJqxrBVwYjlcu/fFHUd9NHY6wv1aRDChU9J1
	lZq2b6YEANJJicQl0kfv1TJtUbpmbitfdD0HeA57gxBaCRiefvh3nyAcM1dBcM7ZIbxNQoj5oGq
	2aScn56YE/WKWtppqUNDSxUUZ0PJculc=
X-Received: by 2002:a17:90b:2891:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-37d19c9db59mr1486498a91.1.1781845251644;
        Thu, 18 Jun 2026 22:00:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2891:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-37d19c9db59mr1486473a91.1.1781845251124;
        Thu, 18 Jun 2026 22:00:51 -0700 (PDT)
Received: from cnode.tail.seyeong.kim ([39.118.66.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d157b2a87sm1406990a91.12.2026.06.18.22.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 22:00:50 -0700 (PDT)
From: Seyeong Kim <seyeong.kim@canonical.com>
To: linux-rdma@vger.kernel.org
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Seyeong Kim <seyeong.kim@canonical.com>
Subject: [PATCH v2] RDMA/irdma: Suppress PF reset on HMC error
Date: Fri, 19 Jun 2026 05:00:44 +0000
Message-ID: <20260619050044.1807044-1-seyeong.kim@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22371-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:krzysztof.czurylo@intel.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:seyeong.kim@canonical.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[seyeong.kim@canonical.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seyeong.kim@canonical.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,canonical.com:dkim,canonical.com:email,canonical.com:mid,canonical.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74FA46A3E4F

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
v2:
 - Drop RFC; retested on mainline v7.1-rc4 (NVM 4.51). The patch
   applies unchanged and behaves the same. No functional change.

v1: https://lore.kernel.org/linux-rdma/20260416071541.3899471-1-seyeong.kim@canonical.com/

Notes for reviewers
-------------------

Some details are inferred rather than verified against the E810
datasheet; Intel confirmation would settle them:

1. Register offsets. PFHMC_ERRORINFO (0x00520400) and PFHMC_ERRORDATA
   (0x00520500) are inferred from the same 0x00520000 PFHMC bank as
   PFHMC_PDINV (0x00520300); they have not been verified against the
   datasheet. On v7.1-rc4 both reads returned 0x00000000, which is
   consistent but not a positive confirmation of the offsets.

2. HMC error semantics. The assumption that every E810 HMC_ERR is
   safe to continue past is not datasheet-confirmed. A conditional
   reset branch analogous to the existing PE_CRITERR /
   IRDMA_Q1_RESOURCE_ERR whitelist can be added on top if needed.

3. Test methodology. The interrupt was forced via a /dev/mem bit
   write to PFINT_OICR, which exercises the handler path but does
   not reproduce firmware-triggered HMC errors directly.

Testing details (mainline v7.1-rc4)
-----------------------------------

Tested on:
  Kernel   : 7.1.0-rc4 (mainline)
  Adapter  : Intel E810-XXV for SFP [8086:159b rev02], 2-port
  NVM      : 4.51, fw.mgmt 7.5.4, DDP 1.3.43.0
  Repro    : writel(BIT(26), BAR0 + 0x0016CA00) via /dev/mem
  Workload : ib_write_bw -R -F -q 4 -D 90, 4 QPs, loopback on the
             injected PF; HMC_ERR forced three times during the run

Before the patch, a forced HMC_ERR caused a full PF reset. With an
RDMA workload running, the reset tore down the irdma aux device with a
uverbs file still open and hit a WARNING at uverbs_destroy_ufile_hw
(rdma_core.c:957, via ice_prepare_for_reset -> ice_unplug_aux_dev);
the ib_write_bw run aborted. After the patch, each forced HMC_ERR only
logged a single "HMC Error: errinfo=0x00000000 errdata=0x00000000"
line - no reset, no WARNING - and the run completed (8622 MiB/s over
4 QPs).

The customer report this addresses was on NVM 3.10, where a single
HMC_ERR produced cascading PF resets and DMAR faults rather than the
single reset seen on NVM 4.51. The unconditional reset is the common
cause in both cases.

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


