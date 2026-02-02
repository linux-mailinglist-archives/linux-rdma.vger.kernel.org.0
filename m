Return-Path: <linux-rdma+bounces-16331-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A+NIlGngGlNAAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16331-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:32:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8A9CCBFE
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B095300C32B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD236920F;
	Mon,  2 Feb 2026 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BWhQFgYB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26631369226
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039117; cv=none; b=jJnT36+0QMQ0NxDDzrS9TaTuBO64nhN934jy89pYDYB0OnjcFlAwKGic2T5bZv99eAhtvwPFhbuSpIa+SUNLVG2M1qb+UtxzxKS8Yt+aSrmPz6Jj5eKrwbM829QNIpxckqOp7ey4O4nRigByD1HOIL8wE4aE143GS0A6Vhgfhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039117; c=relaxed/simple;
	bh=93uMD+yp9t4+d4/NmoR2MkPKSouLTnjaLyD2kLirT4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQ5fr+pJGK2qESlnTWM70o/8h15rI6A1UsSwN6U2Ttyw1CSDe9G8inP8KtETdV7agarw/5zHrnLcicd/Y3IPCeORDDq9Di2PPqrAZ0PnbR0h91iEWKcJ24w2o+db8LRDm8tnkIBvNKBg9WtbL/o1jlR3DOvAopOUbcOAvuY3M78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BWhQFgYB; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so1600779a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039115; x=1770643915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cty+Tz6ON92mbWNwJv9pUiuSw2Fnn4bFe5ecL6lnV0=;
        b=pnXszq6ilvqlKhAkGMvv2cIIykHy/I0IysIyun1QD2ZYXs+HBxz62BIYxUDJmoEeQm
         joeHFaRy0eUNxICHg3XK7RxNCa1B4NGo+Jnkw/aMwxDhbZpIIgRM6eGnW+EMoHbBUn6B
         JwJ5HLL+DMMw5Ou8x49nvMfeqFpwLmfWH+K3WlO3Z1gPmB90Sa9U/6mCjPNmmqzHVPXJ
         dReSpuqjRZTIl742aiuqnN1VD3tFqHY7LXX0cJZ8znVN35Sm8ZVgzINBkhjn3qrYLbTq
         bxFhOaHcr52C+JTW6yjQAAEl8uO3/Au1PZ7BZa6eiRfARKDqRnjRpS1hPOg20Wix9TMA
         Rl5A==
X-Gm-Message-State: AOJu0Yy33tQ9QMsZPZ7LSuvamJeMYMHjeLprrhYCxUkghxk4LIOeB8H6
	wYy2UfnEpY6EjnAV7c8iI6IGVy9suFgFmrTxWUptLLOu7EutjVJfd/1DHIwhE7kqGYZcRilXqST
	w8UtKAOYpG4ExALKgXH3P31mpD91kE9ovlA9EeB/EqtgZdRfWICukaDMEWfqm+Zw/1zXsWXckyA
	7fEWVACbdDQBXkXi7qRCzHRAsdIgZ4Y/YhIEpGg1aKA69GoBIGpmtq0IzgXlWrmqHpMpsqfXE4T
	A2y0T3kAtZEAkqpAo5RIjNq54rVug==
X-Gm-Gg: AZuq6aLjitiz32Qz0J7awLzRHcJOu505S3Yr3th9vms4A4OfkKDDNxNJ+Wa21mruIIY
	kiP+v1BMFtDgn8kNdqV1l80MCPU8009cAfseVZu7IHUG7F+NdxNw8EXvNdnFXaeTRYuhMGyeFfC
	gPFiVgbfjKVGb6Ivd/MaeLAiPnI3mcUzGAwlBlXP2xM4gwFDxl9nMZD4rB2bRWCURb69AnJ3lfQ
	AkeB7LrAz5V7XAy1HtDaamFI1QdBfFBVBbkGpMkGlJigiXwkYtbZo6PgX+Qn5Ye6YDWfC9rHl4y
	gkHQXDmodomwoAXEtgTRp8M4g7qQtT6Y296oFFiqkYjii6VRSYiPJ02hPGZGocXyXkD5atgezz2
	Gvoq+guvY+lI4hAHfYFc9a6OhNEvt73waErzK0bXDmcsawIqRNgzZvYuf2T4f+PabnhPzTqQ7Dr
	n0J51Kp+CaJ9CLMH9JKTiVecNjDcSM91b/TQWkbeXEp153keO6zO5s5mk=
X-Received: by 2002:a17:90b:56ce:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-3543b3168bamr11474803a91.12.1770039115370;
        Mon, 02 Feb 2026 05:31:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35458c070c3sm788281a91.0.2026.02.02.05.31.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 05:31:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a76f2d7744so43343945ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770039113; x=1770643913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cty+Tz6ON92mbWNwJv9pUiuSw2Fnn4bFe5ecL6lnV0=;
        b=BWhQFgYBdjJMOoExpd5wKZ/bUNnJAlRzxAR0BK7v22vKHtDM37hmmttkSVv36HLU9X
         R1Liqo5h7sL1+u3cIC+RBb4t1MAAjY92RfumOnleGw947h5PfjhoZs/VAzASwS+LwwKZ
         FE7HxRZ6R/TcznGneMsDNUhnUBFPmAn7XIEr4=
X-Received: by 2002:a17:903:24c:b0:2a0:8859:3722 with SMTP id d9443c01a7336-2a8d7eeb853mr111530495ad.25.1770039113507;
        Mon, 02 Feb 2026 05:31:53 -0800 (PST)
X-Received: by 2002:a17:903:24c:b0:2a0:8859:3722 with SMTP id d9443c01a7336-2a8d7eeb853mr111530165ad.25.1770039113073;
        Mon, 02 Feb 2026 05:31:53 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0007sm18859382a91.12.2026.02.02.05.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:31:52 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rext V4 0/5] RDMA/bnxt_re: Add QP rate limit support
Date: Mon,  2 Feb 2026 19:04:08 +0530
Message-ID: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16331-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B8A9CCBFE
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

V3->V4:
Addressed an issue pointed out by AI review. Thanks to Leon.

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

 drivers/infiniband/core/verbs.c           |  9 ++++--
 drivers/infiniband/hw/bnxt_re/debugfs.c   | 14 ++++++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 34 +++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 +++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  3 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  5 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 13 ++++++---
 drivers/infiniband/hw/mlx5/qp.c           |  5 ++++
 include/uapi/rdma/bnxt_re-abi.h           | 16 +++++++++++
 11 files changed, 107 insertions(+), 12 deletions(-)

-- 
2.43.5


