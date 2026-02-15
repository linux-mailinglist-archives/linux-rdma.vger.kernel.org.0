Return-Path: <linux-rdma+bounces-16898-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHO8FinhkWkxngEAu9opvQ
	(envelope-from <linux-rdma+bounces-16898-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 16:07:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D439213EF4F
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF963305A43D
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EE26056D;
	Sun, 15 Feb 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+YFq41M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3D2BEC2A;
	Sun, 15 Feb 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771167828; cv=none; b=bmEE1D/1fpAU0uyB6zuJFqXko7xrZzGCCvsUTQseGh7E56kR4pSSjWc7NLFJGYPzIk1kSfGii9hUAtd4wM/V4SFzt1wlD9PfJhzaSjDOUrHAJmUmBtGmmlXzrEdVOlDGSJqaN7zKF+AWlyUQckHkO8FK/z5xJ2GUJGsRlIpzf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771167828; c=relaxed/simple;
	bh=HbrphodJ+SuvhOYBz4bQr366KsqiFgwRrJZdR5Fhwtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdp5fnGnFXKnQ2inOoXknSMaP/Atu3cmrXPT5vhxJ1WVz0JQZt2gXw41pZuWxzHI0szvR7r4Je8OsVQLfNcAifwf2BYHs8ePGJcyiIhwy0au7nXRcwsOckPif35Re2TMXnh+iiC1ArnzUf3rmaz4zvBUkW8wZIDAhfMRh28yKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+YFq41M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E5CC2BC86;
	Sun, 15 Feb 2026 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771167828;
	bh=HbrphodJ+SuvhOYBz4bQr366KsqiFgwRrJZdR5Fhwtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+YFq41MF6CdT+q3P9UhH+3JoKxWxWuK+hsSi9N96sb/CqEvAeMbvOoJXOg/ZSDg3
	 PJ25apNtAZpMKEzh9c5pG+//0BWk+5X3L5idKojwd+ahUXT6tASiU2vXN0l9ISPSJs
	 aeyM4QnL+bh3bQ+PmcL6do5rqEq2WQtkoEm6asC01u7+AKM/ODTPZXdxObmF+HGikq
	 Mc8w9J+JIdMRwhLkYVvxRB+McibpBJzQDeh72E74hjmTQIbT8J/Zu3qQlbnbcCK1Vd
	 ZoNHY2mkqAg060qsPZB0+aB1Qk3j3Bt2Ky8jqVPUhMsnN/1p+hSGB/MxezdyLF9isS
	 cE7NsK10cWs7Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] RDMA/rtrs-clt: For conn rejection use actual err number
Date: Sun, 15 Feb 2026 10:03:27 -0500
Message-ID: <20260215150333.2150455-10-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150333.2150455-1-sashal@kernel.org>
References: <20260215150333.2150455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16898-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: D439213EF4F
X-Rspamd-Action: no action

From: Md Haris Iqbal <haris.iqbal@ionos.com>

[ Upstream commit fc290630702b530c2969061e7ef0d869a5b6dc4f ]

When the connection establishment request is rejected from the server
side, then the actual error number sent back should be used.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Link: https://patch.msgid.link/20260107161517.56357-10-haris.iqbal@ionos.com
Reviewed-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of RDMA/rtrs-clt: For conn rejection use actual err number

### Commit Message Analysis

The commit message says: "When the connection establishment request is
rejected from the server side, then the actual error number sent back
should be used." This is a bug fix — the function was discarding the
server-provided error code and always returning `-ECONNRESET`,
regardless of what the server actually reported.

### Code Change Analysis

The change is small and surgical, touching only the
`rtrs_rdma_conn_rejected()` function in
`drivers/infiniband/ulp/rtrs/rtrs-clt.c`:

1. **Initialization change**: `int status, errno;` → `int status, errno
   = -ECONNRESET;` — initializes `errno` to the previous hard-coded
   return value as a default.

2. **Return value change**: `return -ECONNRESET;` → `return errno;` —
   now returns the actual error number from the server's rejection
   message.

**What this fixes**: Previously, when the server rejected a connection
and sent back a specific error code (e.g., `-EBUSY`), the function would
parse and log the error correctly but then discard it, always returning
`-ECONNRESET`. This means the caller couldn't distinguish between
different rejection reasons. The most important case is `-EBUSY`, which
tells the client that a previous session still exists and it should
reconnect later — with the old code, the caller couldn't differentiate
this from a generic connection reset.

**Fallback behavior**: If the rejection message is malformed or too
short (`else` branch), `errno` retains its default `-ECONNRESET` value,
preserving the old behavior for that case. This is clean and safe.

### Bug Classification

This is a **real bug fix** — incorrect error propagation. The function
was designed to extract the error number from the server's rejection
message but then threw it away. This could cause:
- Incorrect reconnection behavior (treating `-EBUSY` like `-ECONNRESET`)
- Misleading error reporting to upper layers
- Potentially infinite reconnection loops or incorrect session
  management decisions

### Scope and Risk Assessment

- **Lines changed**: ~3 lines of actual logic change
- **Files touched**: 1
- **Complexity**: Very low
- **Risk**: Very low — the default initialization ensures backward-
  compatible behavior for the malformed-message path, and the fix simply
  propagates information that was already being parsed but discarded
- **Subsystem**: RDMA/rtrs (RDMA Transport) — used for high-performance
  storage over RDMA networks

### Review and Testing

- Has `Reviewed-by:` from two reviewers (Grzegorz Prajsner and Jack
  Wang)
- Merged by Leon Romanovsky (RDMA subsystem maintainer)
- Part of a patch series (patch 10), but this change is self-contained —
  it doesn't depend on other patches in the series

### User Impact

Users of rtrs (RDMA transport for block storage) could experience
incorrect reconnection behavior when the server rejects connections. The
`-EBUSY` case is particularly important — without the proper error code,
the client can't handle "session still exists" rejections appropriately,
potentially leading to connection failures or suboptimal retry behavior.

### Stable Kernel Criteria Check

1. **Obviously correct and tested**: Yes — simple, well-reviewed,
   logical fix
2. **Fixes a real bug**: Yes — incorrect error code propagation
3. **Important issue**: Moderate — affects connection management in RDMA
   storage, could cause reconnection failures
4. **Small and contained**: Yes — 3 lines changed in 1 file
5. **No new features**: Correct — this fixes existing behavior
6. **Applies cleanly**: Likely — the change is simple and localized

### Risk vs Benefit

- **Risk**: Minimal — the default initialization preserves backward
  compatibility, and the fix is straightforward
- **Benefit**: Correct error propagation enables proper connection
  rejection handling, especially for the `-EBUSY` case

The fix is small, surgical, well-reviewed, and fixes a real bug where
error information was being discarded. It meets all stable kernel
criteria.

**YES**

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 2b397a544cb93..8fa1d72bd20a4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1923,7 +1923,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 	struct rtrs_path *s = con->c.path;
 	const struct rtrs_msg_conn_rsp *msg;
 	const char *rej_msg;
-	int status, errno;
+	int status, errno = -ECONNRESET;
 	u8 data_len;
 
 	status = ev->status;
@@ -1945,7 +1945,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 			  status, rej_msg);
 	}
 
-	return -ECONNRESET;
+	return errno;
 }
 
 void rtrs_clt_close_conns(struct rtrs_clt_path *clt_path, bool wait)
-- 
2.51.0


