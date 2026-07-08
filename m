Return-Path: <linux-rdma+bounces-22886-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4uKlCIQsTmpPEgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22886-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:55:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 850417248FB
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 12:54:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TfCpEBRo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22886-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22886-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2F16309FFA2
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9784433BD2;
	Wed,  8 Jul 2026 10:47:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3C43148B;
	Wed,  8 Jul 2026 10:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507637; cv=none; b=Mgv+C7LCZYWp1e3xwS+DOkhgz6YnkXKzBqbJAwP/i++DMbhcjtq5fPGWnwle6deHl1YMq02QwIq9G0aHE1OKzqpvoDDQvnIAqeuXNCGWZptGqOWK62INgVdyd9T0QzRqhuIIQ1X43Vl+yfxoLuiEHhDSiRvFu4FCRXiqjXY8fY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507637; c=relaxed/simple;
	bh=a4dS/UiPc/QHodEfFseju7TpOI67ygWgMsIDnPSRQQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iM6D9SydeXBNG9nc09dFBzcGTB/2vPba8Z10VccZ8EszWGebRx2aMDf+oO3obvmuEcrQdbFaz6Ij55y8QIPzMzIeBlipvjkZgogk6N0+WFDUur9pmyzfkxnDiHOx0ifgAaad1tVmURUajw30eSKHvIP86+HFwknXUsZlDWDNfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfCpEBRo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564381F000E9;
	Wed,  8 Jul 2026 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507622;
	bh=OHWRCDgCdIwQ2/CAECN0JCNEaAdtjqe/1gk7PD7NE5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TfCpEBRobkYpxisnHx/hcIKCXhc5gV2RJbYXYP9kr1Ap9b9AoGxz44MPNP8u9qd6E
	 SuVLpItVXaHEEsf1U/unYp4PjXUEqoI82XoVeTEv9XIpctAY0bi4gldWBNvqv1frO5
	 6Zro8IN6CC35ijGajHXqwiZ5usNLjzir3KQt3XVlkwDTEBj02pwTkcNc3+IvQt/daA
	 xykNeA0SVkCIx6QvKTuEUPszklv+Cwm2kt3oXYamHNPLoZwI4mfKAeeVkeZbxjkPd4
	 s6SColS7eC5O67LhV3n6/2qKw3NPKiSIA+jenORPwKvJl5/rEzG2V6NAsTBLKfwu2H
	 8fcuz7Bt9bYeg==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Sadanand Warrier <sadanand.warrier@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Dean Luick <dean.luick@intel.com>,
	Sebastian Sanchez <sebastian.sanchez@intel.com>,
	Jubin John <jubin.john@intel.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>
Subject: [PATCH rdma-next 08/13] RDMA/hfi1: Allocate device data after PCI initialization
Date: Wed,  8 Jul 2026 13:45:46 +0300
Message-ID: <20260708-clean-init-one-hfi1-v1-8-b9e9641268a5@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
References: <20260708-clean-init-one-hfi1-v1-0-b9e9641268a5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:iweiny@kernel.org,m:dledford@redhat.com,m:willy@infradead.org,m:grzegorz.andrejczuk@intel.com,m:mike.marciniszyn@intel.com,m:sadanand.warrier@intel.com,m:michael.j.ruhl@intel.com,m:dean.luick@intel.com,m:sebastian.sanchez@intel.com,m:jubin.john@intel.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dennis.dalessandro@intel.com,m:dawei.feng@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22886-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,vger.kernel.org:from_smtp,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 850417248FB

From: Leon Romanovsky <leonro@nvidia.com>

After the preceding changes, module parameter validation and common PCI
setup no longer need hfi1_devdata. init_one() nevertheless allocates it
first, so failures in those early steps return without releasing it.

Move the allocation after hfi1_pcie_init() and return directly when no
resources are held. Use dev_err() and pci_info() for diagnostics emitted
before allocation so they retain the adapter BDF. Once PCI setup succeeds,
unwind allocation failures through hfi1_pcie_cleanup() to disable the
device and release its regions.

Some PCI error delivery paths are not serialized against probe. Keep their
diagnostics based on pci_dev and skip resume while driver data is absent,
preventing recovery from dereferencing a missing hfi1_devdata.

Fixes: 57f97e96625f ("IB/hfi1: Get the hfi1_devdata structure as early as possible")
Reported-by: Dawei Feng <dawei.feng@seu.edu.cn>
Closes: https://lore.kernel.org/all/20260627060159.2543686-1-dawei.feng@seu.edu.cn/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/init.c | 42 ++++++++++++++++++---------------------
 drivers/infiniband/hw/hfi1/pcie.c | 20 +++++++++----------
 2 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 79e253ac61f3..0545180b5a11 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1569,25 +1569,16 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* First, lock the non-writable module parameters */
 	HFI1_CAP_LOCK();
 
-	/* Allocate the dd so we can get to work */
-	dd = hfi1_alloc_devdata(pdev, NUM_IB_PORTS *
-				sizeof(struct hfi1_pportdata));
-	if (IS_ERR(dd)) {
-		ret = PTR_ERR(dd);
-		goto bail;
-	}
-
 	/* Validate some global module parameters */
 	ret = hfi1_validate_rcvhdrcnt(pdev, rcvhdrcnt);
 	if (ret)
-		goto bail;
+		return ret;
 
 	/* use the encoding function as a sanitization check */
 	if (!encode_rcv_header_entry_size(hfi1_hdrq_entsize)) {
-		dd_dev_err(dd, "Invalid HdrQ Entry size %u\n",
-			   hfi1_hdrq_entsize);
-		ret = -EINVAL;
-		goto bail;
+		dev_err(&pdev->dev, "Invalid HdrQ Entry size %u\n",
+			hfi1_hdrq_entsize);
+		return -EINVAL;
 	}
 
 	/* The receive eager buffer size must be set before the receive
@@ -1607,12 +1598,10 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			clamp_val(eager_buffer_size,
 				  MIN_EAGER_BUFFER * 8,
 				  MAX_EAGER_BUFFER_TOTAL);
-		dd_dev_info(dd, "Eager buffer size %u\n",
-			    eager_buffer_size);
+		pci_info(pdev, "Eager buffer size %u\n", eager_buffer_size);
 	} else {
-		dd_dev_err(dd, "Invalid Eager buffer size of 0\n");
-		ret = -EINVAL;
-		goto bail;
+		dev_err(&pdev->dev, "Invalid Eager buffer size of 0\n");
+		return -EINVAL;
 	}
 
 	/* restrict value of hfi1_rcvarr_split */
@@ -1620,15 +1609,22 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ret = hfi1_pcie_init(pdev);
 	if (ret)
-		goto bail;
+		return ret;
+
+	/* Allocate the dd so we can get to work */
+	dd = hfi1_alloc_devdata(pdev, NUM_IB_PORTS *
+				sizeof(struct hfi1_pportdata));
+	if (IS_ERR(dd)) {
+		ret = PTR_ERR(dd);
+		goto clean_pcie;
+	}
 
 	ret = create_workqueues(dd);
 	if (ret)
 		goto free_devdata;
 
 	/*
-	 * Do device-specific initialization, function table setup, dd
-	 * allocation, etc.
+	 * Do device-specific initialization, function table setup, etc.
 	 */
 	ret = hfi1_init_dd(dd);
 	if (ret)
@@ -1679,7 +1675,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		postinit_cleanup(dd);
 		if (initfail)
 			ret = initfail;
-		goto bail;	/* everything already cleaned */
+		return ret;	/* everything already cleaned */
 	}
 
 	sdma_start(dd);
@@ -1690,8 +1686,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	destroy_workqueues(dd);
 free_devdata:
 	hfi1_free_devdata(dd);
+clean_pcie:
 	hfi1_pcie_cleanup(pdev);
-bail:
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 7ca8f07ba43e..1154b8cc713c 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -514,29 +514,28 @@ pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 
 	switch (state) {
 	case pci_channel_io_normal:
-		dd_dev_info(dd, "State Normal, ignoring\n");
+		dev_info(&pdev->dev, "State Normal, ignoring\n");
 		break;
 
 	case pci_channel_io_frozen:
-		dd_dev_info(dd, "State Frozen, requesting reset\n");
+		dev_info(&pdev->dev, "State Frozen, requesting reset\n");
 		pci_disable_device(pdev);
 		ret = PCI_ERS_RESULT_NEED_RESET;
 		break;
 
 	case pci_channel_io_perm_failure:
+		dev_info(&pdev->dev, "State Permanent Failure, disabling\n");
 		if (dd) {
-			dd_dev_info(dd, "State Permanent Failure, disabling\n");
 			/* no more register accesses! */
 			dd->flags &= ~HFI1_PRESENT;
 			hfi1_disable_after_error(dd);
 		}
-		 /* else early, or other problem */
 		ret =  PCI_ERS_RESULT_DISCONNECT;
 		break;
 
 	default: /* shouldn't happen */
-		dd_dev_info(dd, "HFI1 PCI errors detected (state %d)\n",
-			    state);
+		dev_info(&pdev->dev, "HFI1 PCI errors detected (state %d)\n",
+			 state);
 		break;
 	}
 	return ret;
@@ -563,9 +562,7 @@ pci_mmio_enabled(struct pci_dev *pdev)
 static pci_ers_result_t
 pci_slot_reset(struct pci_dev *pdev)
 {
-	struct hfi1_devdata *dd = pci_get_drvdata(pdev);
-
-	dd_dev_info(dd, "HFI1 slot_reset function called, ignored\n");
+	dev_info(&pdev->dev, "HFI1 slot_reset function called, ignored\n");
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
@@ -574,7 +571,10 @@ pci_resume(struct pci_dev *pdev)
 {
 	struct hfi1_devdata *dd = pci_get_drvdata(pdev);
 
-	dd_dev_info(dd, "HFI1 resume function called\n");
+	dev_info(&pdev->dev, "HFI1 resume function called\n");
+	if (!dd)
+		return;
+
 	/*
 	 * Running jobs will fail, since it's asynchronous
 	 * unlike sysfs-requested reset.   Better than

-- 
2.54.0


