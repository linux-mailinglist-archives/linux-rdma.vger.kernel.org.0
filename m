Return-Path: <linux-rdma+bounces-6829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F54A0225D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 11:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752871883577
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 10:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4A1D63CF;
	Mon,  6 Jan 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UGiumO1c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB41DA628
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157676; cv=none; b=dwNURuLNRl/3fXJJkIcX6lmhtpvTtx50Rdyhch989NOSOtEegXM5mFAuxYcFsp43J4Dmcl7OunErZZn3Aooh3TZUm/0kgAZipgtQDrcgYCeF2Zgb6htMat+vfKI8okQNpCDhteYPCf0LIL6ePbW801CKarNtiyCe984opvo0xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157676; c=relaxed/simple;
	bh=/6F27y9kQKa9Q22CBQ8xNBg1XcD8YPMW3jnNjvbuFyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkAy5DZdQX3flqGakJarFOK7ZsB3B7ZA0LPSXYsRCoWjM3W7rKcILYiun4VDCjhZv1RjjCgW9J+0t7evteAlne+R0zLco3CYDAoLmzbgUOcjhTobTHmsbvuFH9HY0JIECG2K6/f4SBUZkHsAbeQTiQbzQPglgJzXruZAzkr7bVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UGiumO1c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165cb60719so205304865ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 02:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736157673; x=1736762473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1l+xAlw2herRAu4qdkkcLWOtbIwdNqzOj5BQXF51Ik=;
        b=UGiumO1cZv10ayrJDjTPRCjCLrMWtG2YrQbUW5KeFCl/FFq+8WBjFk7+zE4OLVvQrH
         x58vRWTQB2d6cklrbjKSVS+vFZmaU24P30HbXDSq9a15dczy1Gn2hLqyXyhz453sVZJF
         NVabunJNXtKJFR7dmXgxp98QPeszMGxRV3nyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157673; x=1736762473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1l+xAlw2herRAu4qdkkcLWOtbIwdNqzOj5BQXF51Ik=;
        b=NksKFwfjxXfNFy9/BwSorsRDs6F+/5IuFnf0mX3FtZeyRU2iR5/plwIdxbmQYfo9ib
         DobGu0gfCuvjIJiLpkToeHG9Ws+fmaim67gpZs0VCt0QIOlBM/IsWFkeGoSFWxPHzmhN
         SDJCxnVIDC/eUqjGcm3DAKGcmgzSzwgCEuBlry1JYKPArUXompSEovqbx+1RIgZpGtOC
         Zw/c5PvfOjOW1gprKh6Z3pmQyA6N89HhPDCkjEVhaHWN6Cil/0RNrB+1DSFSdEnMphk+
         e84oQyj2kELAkwQpDVCx3+CQkSlafWQZvDRObh4I3tUn8y93aMnlBIoPw1Jpd2JXsVqO
         UEcA==
X-Gm-Message-State: AOJu0YzRbClp1eSAXhg1XEmAJPHS5IpYQO9hv0+5nx/Zx0U7m0news8S
	XNP7OQ+1bvrLtBP1VzhF4KMRCoo3EqcqULWzg4zPW4hMlMWaYzfEe50saojZDQ==
X-Gm-Gg: ASbGncuojVza1/5tdVvdujuM9KVHNL/MFv8aF/VSJiV03KsfFxUkpq0RJPzaHStx+xY
	+/APgXYVvtHqCtaAsZFe5vQZpwLx1F5UvU7ayhVD1899gEnMDoVKantAOAcrbGhgdlHUwBiwpwf
	AYE3sPanZUyhxkSuSknTpaPb+4LDmG5G1c6jKSNTK/rl8sW4nMUXfjlSqyYiJXIATIxiSLMQE4d
	MZIuxkSMUiVxPZhz375M0GjK9YRdYVk3ZE/LccyZ62iUZ8DT6JpBdE5EoIdet7ZMa1HzfxlA6AG
	5LtdJjdGKndcQJP6NeyRQHYbHn7jKRunfuU1wmOw77F5rkBTpnCtUG7QwaE=
X-Google-Smtp-Source: AGHT+IH6Av7biyJePXyEWkfwMvpccxw7ZsWuLUW2oYP0UK0gmwka1D6K0W0pituN+gSQdwqBQItXkA==
X-Received: by 2002:a17:903:234f:b0:216:4b6f:ddda with SMTP id d9443c01a7336-219e6f0e6c3mr837996575ad.35.1736157671589;
        Mon, 06 Jan 2025 02:01:11 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4c89sm282325265ad.124.2025.01.06.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:01:10 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-next v2 0/4] RDMA/bnxt_re: Support for FW async event handling
Date: Mon,  6 Jan 2025 15:23:45 +0530
Message-ID: <20250106095349.2880446-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for FW async event handling
in the bnxt_re driver.

V1->V2:
1. Rebased on top of the latest "for-next" tree.
2. Split Patch#1 into 2 - one for Ethernet driver changes and
   another one for RDMA driver changes.
3. Addressed Leon's comments on Patch#1 and Patch #3.
V1: https://lore.kernel.org/linux-rdma/1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com/T/#t

Patch #1:
1. Removed BNXT_EN_FLAG_ULP_STOPPED state check from bnxt_ulp_async_events().
   The ulp_ops are protected by RCU. This means that during bnxt_unregister_dev(),
   Ethernet driver set the ulp_ops pointer to NULL and do RCU sync before return
   to the RDMA driver.
   So ulp_ops and the pointers in ulp_ops are always valid or NULL when the
   Ethernet driver references ulp_ops. ULP_STOPPED is a state and should be
   unrelated to async events. It should not affect whether async events should
   or should not be passed to the RDMA driver.
2. Changed Author of Ethernet driver changes to Michael Chan.
3. Removed unnecessary export of function bnxt_ulp_async_events.

Patch #3:
1. Removed unnecessary flush_workqueue() before destroy_workqueue()
2. Removed unnecessary NULL assignment after free.
3. Changed to use "ibdev_xxx" and reduce level of couple of logs to debug. 

Please review and apply.

Regards,
Kalesh

Kalesh AP (3):
  RDMA/bnxt_re: Add Async event handling support
  RDMA/bnxt_re: Query firmware defaults of CC params during probe
  RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event

Michael Chan (1):
  bnxt_en: Add ULP call to notify async events

 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   3 +
 drivers/infiniband/hw/bnxt_re/main.c          | 156 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c      | 113 +++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  28 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   1 +
 8 files changed, 307 insertions(+)

-- 
2.43.5


