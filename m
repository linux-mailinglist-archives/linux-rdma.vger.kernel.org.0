Return-Path: <linux-rdma+bounces-16187-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGklJlg1e2mGCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16187-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:24:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13098AE991
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72AC8304924A
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B3331212;
	Thu, 29 Jan 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GoyWOzLH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A22749ED
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681930; cv=none; b=JV/rTvyUGV1lTBvcj9L/iIm8l0whBdz8yN1NrwlIOkfIJ8iOUZxt/ctUtw5ZRflkFufG6BBaHpAavOZ5rG/JXF5BSNLIwFlwbQbRLPKcQNzmWHAGJ2Z4UzN1SJdfpqS/d1mKgY/OT7LyoLzzZnOeqqBevNljXNVHrWDqUdnxY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681930; c=relaxed/simple;
	bh=72F0jJ8JuWLKpktk2N/MBNL+cOpsVsMKI7GPYa78wm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJ1OMqYrknDaMOK3IPAauL6uutWgm1aKLXjC4XFDHzt1FDI44yPxw6HnhEdWn2XKIguCenl40kNDLLAIRdCL+jyEi5zUHtGlzCZPSzkLEQuJSgDvVTJQaLoW28jTdn2yNCT0XD8nMgNfbc4MHkVMECoyeiFAqU4VTqTEQfTD+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GoyWOzLH; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so636498a34.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681928; x=1770286728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51rKoMnSZIF496uiRPw4nurfUC0imoiCkgtIJdCJAME=;
        b=NBza1rWcqdk4hWKVBkQ0ctKJa87CeW8Sn9I7iICA5JkiT5+h+CY6QeiP+xCwyEbhv5
         13Tm0TTjxLcFPAqldFVOi3fceZOky+PM/Z8Es/XdfupHc4aAdOkynq4yqat+mUO6G5O5
         BWdGi+yVZXLVDRoLc3wm8s3fPotnkRXPr6wQAzlEDSY7LGAAtZkH1AzegHr551sS93t3
         PNvAnU9aG6vRYQAy+ncHVrC/zMSrfbWmrRWYWB4KJRJywAY+lYoqDBTk4g2DDBJv6IJM
         OpVLM/cEWx1WwOAw7uqgRpmi+LlIMzJz3n2cJmYCNH5t3cKpWN/9rjav+3JlXWOt2Gbi
         tHqQ==
X-Gm-Message-State: AOJu0YxshkbY0oJXUI6dKox3bDi66lsD7MLucV1wmmnZosUxdFotJ0Wc
	Hk5Oj48f/vVv0+saaiYm7Gbzbe7whPzvV1iGbsRRR9Mh5NEL2IYtXZL62ns0x1GCSMc4KKRQIum
	NaFdZXa9IGWzqgC9haL5wQvFMr22zkncJIh2uB1TjduqscTo6iZR5pXWnu/i64bqWGjl+tj5tL3
	2J+axH5EwV85/gMHtYvgufrRizW1yLPNAVujLha5+R99Id1wlJH3aCWp6TsHiez+3SGyjQWGoQ2
	yvgpRcna8F8lhIN2QmTHWYm2f+dsw==
X-Gm-Gg: AZuq6aIrkdZVDnzQnEloSVYGUFXnp512Ft/wKyB7Mj+1rQ5eeuZ0zio+t1duCff9eIl
	lqv1FjiqjVKfhhwI+jsJaAovZju+fss3DqBOgZAK7VTZFmNuSeq5ND6f6tBaJdLtdZibZ+rheOG
	u8ccDc2r54xZD48V1dzBSn15egMpEE986wTg9s7itj08uBzIXJZfxXqDsZGvNs/mqDyb9o/bE76
	8TdTnAqUafEcgdjooeIUE6CkUnLXcdlclYT/yTwo6ux7Ob8+Ff09A5cw3oqTpVixNRtW80UN206
	VWVweIQQgPgFyE36FMTn1iA9pleP/K1+UIqT0PPFblbgQz1GoFVTZVPaRikPcQBE8BNmrCTFgB/
	AaIWjII44TMDhC7AF9Cy47/z0X30hiTBuuHCUbEt9EyI9pbatoJHXlaQJq3Zv5ZidVvwIZAXr/v
	A0RI2aDg2mmfiVCfaiNEIPhDZKpX4ewq+JjsH5FIqYnBtQFq8EAhdX9KlFAw==
X-Received: by 2002:a05:6830:6a16:b0:7cf:e57f:def6 with SMTP id 46e09a7af769-7d185085334mr5894729a34.6.1769681927939;
        Thu, 29 Jan 2026 02:18:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d18c7cf254sm821120a34.8.2026.01.29.02.18.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:18:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a863be8508so10233135ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769681926; x=1770286726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51rKoMnSZIF496uiRPw4nurfUC0imoiCkgtIJdCJAME=;
        b=GoyWOzLHnyZYj1VhKj8uYrCSsONmteFQ1ahS9L2DQ6WpO9Eid0JNO5QPS1W6uNJ6sB
         RK8YEbaBFSH6OppbwCa2ZDAS61MhC8myxGZEA6upbga6LkhjfFd4Q4f7S6ww3JhelBuw
         i3DwqwxMQQqXB5Il9eLZf8D4nW+6O/c9aWgsA=
X-Received: by 2002:a17:903:40cc:b0:2a1:4293:beb9 with SMTP id d9443c01a7336-2a870eaf1a0mr76675585ad.58.1769681926231;
        Thu, 29 Jan 2026 02:18:46 -0800 (PST)
X-Received: by 2002:a17:903:40cc:b0:2a1:4293:beb9 with SMTP id d9443c01a7336-2a870eaf1a0mr76675405ad.58.1769681925712;
        Thu, 29 Jan 2026 02:18:45 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm46155295ad.3.2026.01.29.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:18:45 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rext V2 0/5] RDMA/bnxt_re: Add QP rate limit support
Date: Thu, 29 Jan 2026 15:51:28 +0530
Message-ID: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16187-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13098AE991
X-Rspamd-Action: no action

Hi,

This patchset supports QP rate limit in the bnxt_re driver.

Broadcom P7 devices supports setting the rate limit while changing
RC QP state from INIT to RTR, RTR to RTS and RTS to RTS. Or, once
the QP is transitioned to RTR or RTS state.

First patch adds stack support for rate limit for RC QPs.

Second patch adds support for QP rate limiting in the bnxt_re driver.

Third patch adds support to report packet pacing capabilities in the
query_device.

Forth patch adds support to report QP rate limit in debugfs QP info.

The pull request for rdma-core changes are at:

https://github.com/linux-rdma/rdma-core/pull/1692

V1->V2: 
1. Added a new patch#5 to limit the support for rate limit only for
Raw Packet QP on mlx5 hardware.
2. Modified to use ibdev_err instead of dev_err in patch#2. Also,
modified to return error for rate_limit for non RC QPs.

Regards,
Kalesh

Kalesh AP (5):
  IB/core: Extend rate limit support for RC QPs
  RDMA/bnxt_re: Add support for QP rate limiting
  RDMA/bnxt_re: Report packet pacing capabilities when querying device
  RDMA/bnxt_re: Report QP rate limit in debugfs
  RDMA/mlx5: Support rate limit only for Raw Packet QP

 drivers/infiniband/core/verbs.c           |  9 ++++--
 drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 39 +++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 +++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 +++++---
 drivers/infiniband/hw/mlx5/qp.c           |  5 +++
 include/uapi/rdma/bnxt_re-abi.h           | 16 ++++++++++
 11 files changed, 112 insertions(+), 12 deletions(-)

-- 
2.43.5


