Return-Path: <linux-rdma+bounces-20519-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI9kKMCAA2pB6gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20519-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:34:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B7528ABB
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43F3B304A6CE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B535BDBB;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgVS3OmE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4782D7DD7;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614455; cv=none; b=HvS5IBRp2O9OlDzmRXet+oSXIJu9lZo5QuWYvfGOthWFrvZkQrhS0hbQJkU8khuUD3KaeT6hZVTe+7TUB+DQmdgmQURAbTb0R+k9Ua7BffVEu15h09NzqXQmOZcloYq5ONk8IwIPGk8WIFNUjfXI61kndnjz0/Guj7xm4/UTY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614455; c=relaxed/simple;
	bh=XnyJ9HXr74bmm4ecRCtrCPQuMKlo0P1cNEN7loRKKHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJLBL9gEGTYgQ47aWcWnmCXeie+pHgo+p/Aoa6UoR9yALyfX5OpCq2aAZgR6aJBn1cliMtbujgQtg0Z5fi8GrYag4qIAIVfsFmF8rny89WxgrG0gTdk4SorN6XPerpGAnJMhRE1LW+0euDhhEDUNtcHrx3QrP/0R8VcGuE7sBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgVS3OmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09315C2BCF5;
	Tue, 12 May 2026 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778614455;
	bh=XnyJ9HXr74bmm4ecRCtrCPQuMKlo0P1cNEN7loRKKHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgVS3OmErR35CNLEqdszs769IVM+BHo6Wba1mvdzOJNwLbTGj5D8edEnLippz2e09
	 Fk9l7ZuOIaqpV+uk3VCo2vX4CLEH+SzmedLyDcq+IMud73Wh2VVlgWxGIcVo+MQF77
	 RBA35ow8zy2hQZ3NDb0LtupMAzMCUk4KcgeH8BCJ0/m3VdJ1loG+mmG4dbnHfRSIZI
	 dfCpac/sg5Tbp5YmC8t4z+GdmPUPSNCR+Nw1ovUcuKO40GY4lhPXkkCmIUUWPUNC4W
	 zWV0DN27ycBDaMIl7ZR6GVbOs/bVjQH0qGmbrxF+2zoJkJ0rDMVCp2GhXltjoPmvkE
	 30fBXcvIlOREw==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	David Ahern <dahern@nvidia.com>
Subject: [PATCH iproute2-next v2 1/4] namespace: Add fallback to netns by pid
Date: Tue, 12 May 2026 13:34:04 -0600
Message-ID: <20260512193412.32019-2-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260512193412.32019-1-dsahern@kernel.org>
References: <20260512193412.32019-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 041B7528ABB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20519-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

From: David Ahern <dahern@nvidia.com>

Update netns_get_fd to try the passed in string as a name first. If the
netns filesystem entry does not exist, try converting the string to an
integer and if successful return an fd to /proc/<pid>/ns/net.

This allows netns_get_fd to uniformly handle the 2 common use cases of
specifying network namespace by name and pid.

Signed-off-by: David Ahern <dahern@nvidia.com>
---
 lib/namespace.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/namespace.c b/lib/namespace.c
index 74b7e7caf0e5..0bba3a163563 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -99,19 +99,33 @@ int netns_switch(char *name)
 	return 0;
 }
 
-int netns_get_fd(const char *name)
+/* try str as the name of the namespace first, then
+ * fallback to pid
+ */
+int netns_get_fd(const char *str)
 {
 	char pathbuf[PATH_MAX];
-	const char *path, *ptr;
+	const char *path;
+	int pid;
+	int fd;
 
-	path = name;
-	ptr = strchr(name, '/');
-	if (!ptr) {
+	path = str;
+	if (!strchr(str, '/')) {
 		snprintf(pathbuf, sizeof(pathbuf), "%s/%s",
-			NETNS_RUN_DIR, name );
+			NETNS_RUN_DIR, str);
 		path = pathbuf;
 	}
-	return open(path, O_RDONLY);
+
+	fd = open(path, O_RDONLY);
+	if (fd >= 0)
+		return fd;
+
+	/* make sure string is an integer */
+	if (get_integer(&pid, str, 0) < 0)
+		return -1;
+
+	snprintf(pathbuf, sizeof(pathbuf), "/proc/%s/ns/net", str);
+	return open(pathbuf, O_RDONLY);
 }
 
 int netns_foreach(int (*func)(char *nsname, void *arg), void *arg)
-- 
2.43.0


