Return-Path: <linux-rdma+bounces-20167-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP39Agmr/GkNSgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20167-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:08:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 944684EAD0B
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB3733012C92
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC341B344;
	Thu,  7 May 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEDswSL1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7A3F23B7;
	Thu,  7 May 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166519; cv=none; b=CYsApUyTTHVzCCgz7rSPvUtNgKRfYBVlpIb+dYKaxPd/5dJ8p/XPVeWWL2j9pA/yN0AwJR5NE3ZPXRC5HHL4foGgIeShGqn3iiSc5Ph3WHhs5SWnfO0RE0iTjifDTbsKztaud30tM8E6LIPLcIJW8ZeIxwyTuuJbTkzt7Ju8TZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166519; c=relaxed/simple;
	bh=SXIUITwOGAEBChqgHkDlZ0KO2AJuywRrmHkOcxS3OKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT5UQ02+Ot5QiKpXGm1GmKI2h8tTFxhDlZndCPCCzBllkH33zS6oMfT4RWYSAQ+ZCsT5LCADhGFBGrHtiNuskBDxhesgNta3FIDjs3H+ylgH6p/PK2hBKKwpGoYKHa0Za7aMGMqU2eUdmk37xxrInS0WTWT5WNs5QS+f821M2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEDswSL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310DBC2BCB8;
	Thu,  7 May 2026 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166519;
	bh=SXIUITwOGAEBChqgHkDlZ0KO2AJuywRrmHkOcxS3OKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sEDswSL12C1di4LyvhAV2FoQ3Ogz0NxRiWZqNJzylg98RMum4p+bR04x+ubKzV11R
	 hfKOUnK27wDAvox/jbvv13DPHWW5gxGJFRVrFmnGH/M+kXht89Z4SgRvHo7Qm5EohU
	 r0c0cMr3UhmuDrBYZQI0Z8i+p6VUS6dcZOm3qWTbKlW5JOcxVCZNudpN+N1c9TNau1
	 d9EvWLJEAmCT+h1smjOP+i/EqvdyHQKkOHRoud1+w5z7yovWmZzFLvHDSsGuraTnmN
	 +KlqUu+xdI1AHGz+ctaxARpg3WOpqNdVE7wDlMI6R6dcf/8kBrYLsbmr3+5FGC3s/C
	 yZeNothdkoBow==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next 1/4] namespace: Add function to return fd for netns by pid
Date: Thu,  7 May 2026 09:08:32 -0600
Message-ID: <20260507150836.28105-2-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507150836.28105-1-dsahern@kernel.org>
References: <20260507150836.28105-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 944684EAD0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20167-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Add netns_get_fd_pid - verifies string is an integer,
then returns an fd to /proc/$pid/ns/net.

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 include/namespace.h |  1 +
 lib/namespace.c     | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/namespace.h b/include/namespace.h
index 98f4af59..6a6fa438 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -52,6 +52,7 @@ static inline int setns(int fd, int nstype)
 
 int netns_switch(char *netns);
 int netns_get_fd(const char *netns);
+int netns_get_fd_pid(const char *pidstr);
 int netns_foreach(int (*func)(char *nsname, void *arg), void *arg);
 
 struct netns_func {
diff --git a/lib/namespace.c b/lib/namespace.c
index 74b7e7ca..f391c694 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -114,6 +114,19 @@ int netns_get_fd(const char *name)
 	return open(path, O_RDONLY);
 }
 
+int netns_get_fd_pid(const char *pidstr)
+{
+	char path[PATH_MAX];
+	int pid;
+
+	/* make sure it is an integer */
+	if (get_integer(&pid, pidstr, 0) < 0)
+		return -1;
+
+	snprintf(path, sizeof(path), "/proc/%s/ns/net", pidstr);
+	return open(path, O_RDONLY);
+}
+
 int netns_foreach(int (*func)(char *nsname, void *arg), void *arg)
 {
 	DIR *dir;
-- 
2.50.1 (Apple Git-155)


