Return-Path: <linux-rdma+bounces-18299-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLr3Cad4ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18299-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:04:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6E32B99D5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2706F30579F2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CB36B04E;
	Wed, 18 Mar 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWIFJE0F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4913624A6;
	Wed, 18 Mar 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828166; cv=none; b=nM8DdnGu0I7Fu+g7sQN8cywke+aUHuCuXPwwm6ljVts/mgNJ3R41OH3isuvwAFFCtkJ6ciNVJCVZ3IKLd1bAyqzHS4AcGAHr2pLdZXAzvXJhYZi6biA90yfsNV1P3qhoeNU4j081qty7YK7ednbQ7eCW78R+wJTQeAtul9wCoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828166; c=relaxed/simple;
	bh=fUs/GwVvhw1nB9OWWrL3W4YPbFYa42FP3Y7gMK73z0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDy9zsGR9D68YjBNscJjhZY27rB45VLXUYDaNqlUsu1pM1PvCx6Riw3I1zSqOHabEdePsOUS+tXWDOi8ziyETDEf73sNCv1ugAsOQ/QaLRbPA9MJAlqverRwhaKevq7+KG5nmVGeY1yxV4tIdN55k3ShBRtv2VExq5U6Z3van3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWIFJE0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AEEC19424;
	Wed, 18 Mar 2026 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773828165;
	bh=fUs/GwVvhw1nB9OWWrL3W4YPbFYa42FP3Y7gMK73z0c=;
	h=From:To:Cc:Subject:Date:From;
	b=KWIFJE0FxflNSkoTEoAS/kSQ6TloG0G6cjXZbGc9tJjSbvJCKO/xePWUJCDsFJoxi
	 LmpaE+2OxjjPx1iHYjQm9atKEMRttgzPIMYlNJk71VYS2itNOaMQVSQn/D9o1p8b59
	 TJCIMhSbB1t422Ou90KlQZNiTd/Z0zRMoyklCb2YADk06j7jj4GvI1CCvRZRbt1Qjp
	 HjEQUumg1tcUu0hpsumfcrdhRwUFDNFkpiaj4NJ5N6uBLfzyiamjtw0ufVm22nCq8r
	 QWyIK+y9jMnIF6aQIo2n//TRH/1ZdaM/64CGSvvPVcinDBWDcvyuDmaqpnn1SnhIQ0
	 1wuOyOQ9Vnymg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/2] RDMA: Clarify that CQ resize is a user-space verb
Date: Wed, 18 Mar 2026 12:02:35 +0200
Message-ID: <20260318-resize_cq-type-v1-0-b2846ed18846@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260318-resize_cq-type-a6208c447068
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18299-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,broadcom.com,intel.com,nvidia.com,cornelisnetworks.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 7D6E32B99D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let's start to clean resize CQ path.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (2):
      RDMA/core: Remove unused ib_resize_cq() implementation
      RDMA: Clarify that CQ resize is a user‑space verb

 drivers/infiniband/core/device.c             |  2 +-
 drivers/infiniband/core/uverbs_cmd.c         |  4 ++--
 drivers/infiniband/core/verbs.c              | 10 ----------
 drivers/infiniband/hw/bnxt_re/main.c         |  2 +-
 drivers/infiniband/hw/irdma/verbs.c          |  2 +-
 drivers/infiniband/hw/mlx4/main.c            |  2 +-
 drivers/infiniband/hw/mlx5/main.c            |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c   |  2 +-
 drivers/infiniband/sw/rdmavt/vt.c            |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  2 +-
 include/rdma/ib_verbs.h                      | 12 ++----------
 12 files changed, 13 insertions(+), 31 deletions(-)
---
base-commit: 5122be2a19aa0fc512ea689fd1064f7e05b45d17
change-id: 20260318-resize_cq-type-a6208c447068

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


