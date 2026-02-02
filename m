Return-Path: <linux-rdma+bounces-16316-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V59sA8UsgGlZ3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-16316-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB81C8357
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 05:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53FDA3008514
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 04:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6722F16E;
	Mon,  2 Feb 2026 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AHZxzpLU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9F1C01
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770007742; cv=none; b=VKOHz3F3gveHth87EYFv8YMpAxZGOhVxwtoj7eXPqo7EqJ6sViIUH51WCs2liIawWQwUy9vMgDX/QCaOxF8VyH6rP9Ag7DLh8kH8NlSlbYgRTqKu3xhEI0E3x3rcDD439HRx3SROeXglrZ6etPMrG9vv+llrmLD+syR1xyZGsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770007742; c=relaxed/simple;
	bh=rSKSHtMmc1303Kvi0VFbR1wQkZ4JvqlAv77U8CqOXkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ho9lGAVfbBTDEtfAjr/TEXFA6RPfay66VuWCmLHj2nRY87YzotBnu69e9UA8IIPJ9ua3g1f57mj67WFMh8CVRa3e5WILPqClDfwWQK1uMFX0YZ7wogP5gF+/RSxiYTtG1foE/PvU/CRFfOEPhqSGncRQowLEYSx6v8PFowMAyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AHZxzpLU; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so43282875ad.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770007741; x=1770612541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vUW87w1YVVBUGRYDsGY+6XvncD+OMyo7UysRLWtWcU=;
        b=ZQa0uxv0nOSxPNEPtAZhj105IReRcob47rYsjjwsvQ4n1+DkGL5ojGWhN4AVFotvPC
         miq2L66se1aiB2PKN80iV+uZeHqKBOukstshenxGQvS5EUFGHUNLeR/p8msY1yMSdFyi
         am1e2W812T2S5DtYdqA5HKCt/RnrwfqngeddeTZs0zPIJQmQDmH04dMlStvss5/DYKnY
         mRJ79H7JjpSFLjhMR6Cxhfng0E33VaZdBcGP52TGmkQ2UbgHJDMxJEe1azxhZxRTOvsR
         VX9L34uBEC2EJbkum+VB7pH/1VFQCnLhVKRXVINIQqITklAIbEBSRjvE0KkSYae5DusJ
         7QWg==
X-Gm-Message-State: AOJu0Yyj4Dl364JFA9WBcT/OCSWLq3zQ64qDySLep0X+S615RJOxES+5
	eeXwmcGbOC1mRYI2bY5Q1USJzGO7CxrEw99yCORmwDZcXygPTkMMKfOw/vUb+4OtaCLPuYnLmcM
	yDaHouTpbXbXJEIwTsoKKDaDC+vNat614ui1xHHyackIV6luOGcHg9QDAIGcnASjVeGkTBrs8F9
	7XN6eGKWOeY8xSL2ydmsnGxaHXexDBMpH0Dd0ULfCzAydX6qrCfxktARw28cLsIRMWRfiFL6OrM
	uPRlAu6J8u1OG1by77YOTMJUvLeog==
X-Gm-Gg: AZuq6aLXkNnz7bhyiTVAhYGvPHHxGcl4b2iUve/F8NHo7daW383Z6CRK7382C4Kb3qx
	4azGVt9SotJlG3hDXyXA6E0OgDF3h+t01v6AieXGFi4kHak+lQHa0EY/EzhdR2hzysQqqPVF4VV
	63iKhKMjLwfYgz7EPp13mzffqrZlgMKA3FiVdHa7EoGBU85ugRPDhWb2ggG6zaaaVpai0oCZYHC
	STmYXwvSuUPulwlcgoYHma2UDRPV3gJpGTJObfiXCIx6t8r2IcXV+Qq8RTu/tgxEpg+h+rkqv+V
	t8Bq9lqMW3FvsejTZfFTTAJJW5pNqCEZLTPb+zPvFMBwCkgoIkBfqZ0OFpm+kRXtImkgSjLrpYx
	qRmKheL+DstZftMNdb/VqYqoaDungwKEUCaJ1F5E0wzPu5B1v7KppBwrnateGRCEnFtH+bFveLg
	aQoSCZlk6vBf++sWuaSJPEeHk2wPD3RRmEB0p05OiW9K2pSkduEoAI9w/9KA==
X-Received: by 2002:a17:903:388d:b0:2a7:5171:9222 with SMTP id d9443c01a7336-2a8d9a62833mr112744975ad.49.1770007740776;
        Sun, 01 Feb 2026 20:49:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b3ee9b0sm19346215ad.6.2026.02.01.20.49.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 20:49:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso9610213a91.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Feb 2026 20:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770007739; x=1770612539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vUW87w1YVVBUGRYDsGY+6XvncD+OMyo7UysRLWtWcU=;
        b=AHZxzpLUfnhakEsF1d7CsqHVECLI1p0/xdpjhPKHkGUq7+QX0Hxpa1vRL2Xw3wrcJP
         AnTG3tLtMDpBVKRoe58TuViV+XNVV3zW6ztOOWfNL69+PVXp3/h4sV0lIfE2zaVI7lVA
         6g8ofh8DivcgmIAlBytVUQWIlxDomgW+zR+Ak=
X-Received: by 2002:a17:90b:5546:b0:353:5595:3247 with SMTP id 98e67ed59e1d1-3543b315814mr10964699a91.12.1770007739130;
        Sun, 01 Feb 2026 20:48:59 -0800 (PST)
X-Received: by 2002:a17:90b:5546:b0:353:5595:3247 with SMTP id 98e67ed59e1d1-3543b315814mr10964640a91.12.1770007737759;
        Sun, 01 Feb 2026 20:48:57 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm20282135a91.9.2026.02.01.20.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:48:57 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rext V3 0/5] RDMA/bnxt_re: Add QP rate limit support
Date: Mon,  2 Feb 2026 10:21:15 +0530
Message-ID: <20260202045120.3139712-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16316-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5FB81C8357
X-Rspamd-Action: no action

Hi,

This patchset supports QP rate limit in the bnxt_re driver.

Broadcom P7 devices supports setting the rate limit while changing
RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
the QP is transitioned to RTR or RTS state.


Patch#1 adds support for QP rate limiting in the bnxt_re driver.
Patch#2 adds support to report packet pacing capabilities in the
query_device.
Patch#3 adds support to report QP rate limit in debugfs QP info.
Patch#4 adds a check in mlx5 driver to support QP rate limit only
on Raw Ethernet QPs.
Patch#5 adds stack support for rate limit for RC QPs.

The pull request for rdma-core changes are at:

https://github.com/linux-rdma/rdma-core/pull/1692

V2->V3:
1. re-ordered the patches in the series so that kernel changes will be
added as last patch.
2. removed a defensive check from Patch#1

V1->V2:
1. Added a new patch#5 to limit the support for rate limit only for
Raw Packet QP on mlx5 hardware.
2. Modified to use ibdev_err instead of dev_err in patch#2. Also,
modified to return error for rate_limit for non RC QPs.

Regards,
Kalesh

Kalesh AP (5):
  RDMA/bnxt_re: Add support for QP rate limiting
  RDMA/bnxt_re: Report packet pacing capabilities when querying device
  RDMA/bnxt_re: Report QP rate limit in debugfs
  RDMA/mlx5: Support rate limit only for Raw Packet QP
  IB/core: Extend rate limit support for RC QPs

 drivers/infiniband/core/verbs.c           |  9 ++++---
 drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 33 +++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 +++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 +++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 ++++++---
 drivers/infiniband/hw/mlx5/qp.c           |  5 ++++
 include/uapi/rdma/bnxt_re-abi.h           | 16 +++++++++++
 11 files changed, 106 insertions(+), 12 deletions(-)

-- 
2.43.5


