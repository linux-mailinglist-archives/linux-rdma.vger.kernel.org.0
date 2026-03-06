Return-Path: <linux-rdma+bounces-17573-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NB7GiB0qmkfRwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17573-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 07:28:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714CF21C118
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 07:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9752E300B9F1
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5144C330D2F;
	Fri,  6 Mar 2026 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cslXAdE6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F31A9B58
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778521; cv=none; b=uYb000uuPtvNzOEpp2yOel9QLp1BZXOII+AtD7yJDktxMGJMoZfFMMFqB6guOoNqxZpMhtC/7zSHx4N4V8KXWak5cwqAEVo5rQlntmZbhkvU3JA4w5h1O2xTUBfeVh6MrqaZfvMqQm4o+kZXGUTeeZgqE+Y2Xt0zLbAlbZqUje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778521; c=relaxed/simple;
	bh=qXT5LvUFbMcSMq8xIfhfKKcajvlxZePXoeBCWy1RMlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emw8h08oypd/Sx7w+HDWDpayM8sfoDKkM1CyC41nGs5ZzIby9oCf8qk5J0qr4sRk6hTGiKtiGN81/TPBteEy0zhB+YRIUlkMkn/DPc/1M77QNMdYXRPo91Vaa80E9qDsRyyWyrDWzs1x66I+maBQ5uG7F+YSMl9Qa36+CStiqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cslXAdE6; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-359bda8abb0so152043a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 22:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778519; x=1773383319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CiFhOv4J9/hK5r+Rx477yVJExHro1XCTVkk0YEM7hY=;
        b=F5KBswdLQjaDNP0brDIEOEhcfH1PFXRFCRVa19YJtjcp7l/T6OdSNOWgyshxc6jogV
         7PFXP98K/xQsvwjEMnY/MTx3Et5gRllYe578NO8TOZN5b6debyP9lW3Wa+N4ZKW8Sufx
         CcbfU4oIu9pGTVOjQc/9so4f2LJiVvL5MZ0jb2p8eTX7qtKHjSqqa+j4Wf8hwj7HOrW+
         +4Do4+oseKVUCUb3Jx9OQbQJNIi+HRb+OSknwDbAaJgfhtWfFOAbq0vOu7Rm9lCkNe4C
         U3VJ+Y/TSC8osCJWk8iJCm8ATtppKUfVMjAck1YHTqcWbe+1nPvX35QaWWp18x9zKsIC
         HvjQ==
X-Gm-Message-State: AOJu0YwOJSlKPph05VowUKC7EE5OrHU8qIHZ3NXKB0ycg33JVZPBpzDr
	pihq7amrTuJH34mqj6hOgdhNIBnPaSo/U3n3u/Y4L3/gQ591LoDOTz079XD/6wXtYNguJspAMkw
	JAxOSCD7QbpCzK+wcKC3AepapoHkvzOdUFmFKBAJJ4EC5DcVTCi2vSG7PxrV0uqGmSBEK9ZlICZ
	QanATi4Ww9IsHs4tiK8q/oua8WJlgZKwQFm+gKvN0DA7/SuAlGWYW9x6ngCchXaNRaqxvgsiOlE
	eVhME6H25NU1mzN8bhXr4xbLc7v
X-Gm-Gg: ATEYQzxwnafsdG7ENVweLXBmzq1K9ro2Y+olWnrTH8hv/0PIVLJB9xlVNs36buVfRMi
	DqVmySIEZfXpgSSxSmwcu8Nm83AzEJ5GrihnEeKrhew6XT1uW87Gjo0EQowaEhuUJq4qYCDLOFl
	C5phqnMPjsIwn/uB5BOnNbygfN5E/ZJzZ4VPLlaSUelCJWqPhtX8o16DRLtFVOfjp10HwQrN2o5
	weILyAwRvWp3sXNoHSqiMYD2yC3hDgQGqF5bDtKdRcbvTGjvSPYRXZeBbmSVXGzH904jk7zx5CG
	BAs6D9gD7hydAQfJpakDdt7K2NgB8bw2e2bVLS/kddmE40FXt5pBDYWI7b+fZtVxLbJ049pk4jZ
	hWdc8N/L95cMafms4y0Rv0wH7iKqozW4JPDcRdU4mgao1R2E9cCxAXzqBGqOgVn8s7jv5UwTqH9
	FLA8D0TMAOTEVp6G1wGvLa9B6vu9Dfa0JPtnwW+z4qCByuPMeyLJCoACJsoigQPXxaf5Vh
X-Received: by 2002:a17:90b:4e86:b0:353:6373:590b with SMTP id 98e67ed59e1d1-359be21f5e0mr966074a91.7.1772778519090;
        Thu, 05 Mar 2026 22:28:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-359bbac44fasm58749a91.0.2026.03.05.22.28.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 22:28:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35983ee9f3bso5730025a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 22:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772778517; x=1773383317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CiFhOv4J9/hK5r+Rx477yVJExHro1XCTVkk0YEM7hY=;
        b=cslXAdE6KC/0zYRQvdJ22yUNJ3yx4mbDhwJwm/QSZDzzM02RPHSAO/B9gjUlKR49X/
         n4cNfOA4ZKGyB71sYuXg0fN3xl7PRXgrB0jIaVj5YylKWLNmhNeXW2b5t/8S1rLaQ4Sa
         kYVjWTornLXVb3VBhqMPnMyu563S1syuJ2+AI=
X-Received: by 2002:a17:90a:d40f:b0:359:91a0:98fc with SMTP id 98e67ed59e1d1-359be2ef312mr1022107a91.21.1772778516859;
        Thu, 05 Mar 2026 22:28:36 -0800 (PST)
X-Received: by 2002:a17:90a:d40f:b0:359:91a0:98fc with SMTP id 98e67ed59e1d1-359be2ef312mr1022100a91.21.1772778516430;
        Thu, 05 Mar 2026 22:28:36 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0a7104sm571432a12.3.2026.03.05.22.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:28:35 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH rdma-next] RDMA/bnxt_re: Fix a warning in bnxt_re_create_cq()
Date: Fri,  6 Mar 2026 11:49:52 +0530
Message-ID: <20260306061952.11922-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 714CF21C118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17573-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The chip_ctx variable is unused in the kernel CQ creation path,
delete it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603060549.g4df8HXz-lkp@intel.com/
Fixes: 387f31e96d46 ("RDMA/bnxt_re: Separate kernel and user CQ creation paths")
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 63cd4ab80a6f..182128ee4f24 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3479,7 +3479,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
-	struct bnxt_qplib_chip_ctx *cctx;
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3497,7 +3496,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 	cq->rdev = rdev;
-	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
 	entries = bnxt_re_init_depth(cqe + 1, uctx);
-- 
2.51.2.636.ga99f379adf


