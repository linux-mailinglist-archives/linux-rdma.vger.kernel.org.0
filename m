Return-Path: <linux-rdma+bounces-18931-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK4vCj6/zWlMggYAu9opvQ
	(envelope-from <linux-rdma+bounces-18931-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:58:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A19343821DE
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 02:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B7C93021D1B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 00:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A13265CBE;
	Thu,  2 Apr 2026 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ8eHygk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33E21767D;
	Thu,  2 Apr 2026 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091515; cv=none; b=hCWbsqeuPcIklzYWHrQ2QpY+WctVYyJzsGYZWAGgJ7v+9A8gzA+WT5VTYCElMRS7AqDg120umo0CuJS0Vn4vaUpCs9mpReBLeIk8b6XsIkS1UYtOgoJjZ1Wuh1YJ+COeLw5lyt5i16EcKE+3eVF1B7+y2IfBSpOFDnIspfeJ7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091515; c=relaxed/simple;
	bh=F9i1ZlCzrHzzOXS4B9dOE6C/JNIYXDXmoGbZHz2eL3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOrLAxkP+DzR8FeErJMcri8EtcE38xEFdvHa7UIMv7l4pZ6VoJLhsWH40ZsW18XBd6S3Z0ta4ObVz5fHxwJ5zjv9mBVnSM12mf6PkUO0IkR74u7EyPtY4DQyv8POPL1ECSP8YeY49gPUmm31Upi3Xj8Hv/o7tMuw0sthMZipro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ8eHygk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E4EC4CEF7;
	Thu,  2 Apr 2026 00:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775091514;
	bh=F9i1ZlCzrHzzOXS4B9dOE6C/JNIYXDXmoGbZHz2eL3U=;
	h=From:To:Cc:Subject:Date:From;
	b=fZ8eHygkntWN582oOVd0opeiCYI5japrMfSfm63PZEGCmXzQptX5NRapK86Owf+3Q
	 7fErzr54eNrwCftVe7R4JRnEqZ0lV8RX4aJHdNsHalxNKRf/UGz4p76pMIuhkzsXo1
	 760UiOJXNVEHbbcc+rI7i4dYF2poFxeNO+E0d78HTmAD69WafNgDHseMz28zKvZxFL
	 yCEO+EI5OWBnaI2SyzxQr2cxo7Le/E0g3WIhOxrKBX2RUhcEG45OLYS/1aZQaPYtQM
	 CJd/GFwCQEQNObeVXQrX529QipwdrC7ecrf2Tv2Gh1pBxz8dI8HWCRpMOpxjRo3jBz
	 9CEoxEW3vv6sw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update email for Allison Henderson
Date: Wed,  1 Apr 2026 17:58:33 -0700
Message-ID: <20260402005833.38376-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18931-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A19343821DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch active email address to kernel.org alias

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..72e56bc8865c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22119,7 +22119,7 @@ S:	Supported
 F:	drivers/infiniband/sw/rdmavt
 
 RDS - RELIABLE DATAGRAM SOCKETS
-M:	Allison Henderson <allison.henderson@oracle.com>
+M:	Allison Henderson <achender@kernel.org>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 L:	rds-devel@oss.oracle.com (moderated for non-subscribers)
-- 
2.43.0


