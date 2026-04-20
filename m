Return-Path: <linux-rdma+bounces-19437-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMqCLDdR5mkDuwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19437-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 18:15:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFE42F384
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5834732598DD
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039E149550B;
	Mon, 20 Apr 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg5v0wUD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6B495503;
	Mon, 20 Apr 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691945; cv=none; b=hR6mX2Z0vgjN7P8IfLAvWq9DGYSAFfrTCPXhKbFXrqmEfq1RsFPlx0Do5Up3OFTDSXFi2/IodyJ+gdI4uiAvv6EV8QpM14ojGE7ufoZ6+Q1bwsa/kM2erhDqOkGLaY0lYKgbBoPk1em4+rOqWqJpOc841mS/J2/7yu2lJaB5twM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691945; c=relaxed/simple;
	bh=+xu2m1TGmJvOHkE95UvLqER6g9u70PZ6XgszAzjUeRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tL/R+TrHIVOJI+Un1JFfa/IMd2pAjmTnsflc/PHbDZUruAkfcInkpcdK24HK6gXdLMr2GqJMWSES38bTwBifr0Mp4RpA+pHjOf0rycDfyFIlqcRnHMo3HHFp8RsuF1DTgYMsny708LxKancL7H4OZTSEVtTOnb6UljrJnQ32aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg5v0wUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8305CC2BCB8;
	Mon, 20 Apr 2026 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691945;
	bh=+xu2m1TGmJvOHkE95UvLqER6g9u70PZ6XgszAzjUeRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg5v0wUD9MmrwiDdtkP8HCxsXJOL9l6544+bhakuUTMytUk+Pn0AmWOXkFMYiddK+
	 HD/OcKmnHROecx4ZxBcCX6aw7jB7nedIVBRLIbSrL2o25GFOZ31dq4ee/leQERqu4z
	 2/XkfkJUjZQX9PTFKiOYoLwA7jrq4uKpeDJI/43koNdzFBYu7QeaB7kdSYM+9OwPhp
	 jMjoXYvYeJlx/V6/3PNlbWuSK6DdBAl3IzIOVoHYKRpkXA3NmQ65rBzN3+mQfK4hZ2
	 S4Ya5TTgfbT/sZCTZ0opSyhlyYDrz3CF1SDX8siHnVY5Yhhot7bjLLOyh2T30b2vKM
	 HXzQa9M5h/e+g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] RDMA/irdma: Fix double free related to rereg_user_mr
Date: Mon, 20 Apr 2026 09:21:18 -0400
Message-ID: <20260420132314.1023554-284-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19437-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 38BFE42F384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 29a3edd7004bb635d299fb9bc6f0ea4ef13ed5a2 ]

If IB_MR_REREG_TRANS is set during rereg_user_mr, the
umem will be released and a new one will be allocated
in irdma_rereg_mr_trans. If any step of irdma_rereg_mr_trans
fails after the new umem is allocated, it releases the umem,
but does not set iwmr->region to NULL. The problem is that
this failure is propagated to the user, who will then call
ibv_dereg_mr (as they should). Then, the dereg_mr path will
see a non-NULL umem and attempt to call ib_umem_release again.

Fix this by setting iwmr->region to NULL after ib_umem_release.

Fixed: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260227152743.1183388-1-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c77d6d0eafdec..c399aa07bcae8 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3714,6 +3714,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
 
 err:
 	ib_umem_release(region);
+	iwmr->region = NULL;
 	return err;
 }
 
-- 
2.53.0


