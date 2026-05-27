Return-Path: <linux-rdma+bounces-21339-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM8vGmNYFmo9lgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21339-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 04:35:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E55DE9AB
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 04:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81C22304971B
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36C36EAAE;
	Wed, 27 May 2026 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxLmBOnS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19E36EA8C;
	Wed, 27 May 2026 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849276; cv=none; b=KnTa9x+FO2W1QYiEbYE5SW8CwDXLp4IHx+p49N34cePVXySzj53DFeT3gr38AZ6fMfOwPaYESW5yPjj8L7c7cAuW5uE8ELPiou1wFhLR0gSNvaodh3UDoPWJnVlH0xv/E6SGlIZoM5HlkHaHNUM+aWcLESZqepgydLc9sG/85+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849276; c=relaxed/simple;
	bh=DoWIO1eGzc0n/hfrDSk3VoHhaL8sOcywKv/wR+IHfVE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiifegrB8npIUi6OmbPTdf2A0D4BM2R7+ksv6As6tv0fFt0DU8RnHQzI1uzVHkkGFp5nAncVdInxfq6frIQ0wQAFpbyfBHb48sgpllmCY2wWtGykbaegy7bltjCrKsNwg/he2EatO7tv3cm0LtplE4JV/vPMQPg35YNlna60pR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxLmBOnS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306361F00A3D;
	Wed, 27 May 2026 02:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779849267;
	bh=Gu+R75Y++7vB0SL9/BGl405Ez85MNphmxi54TCUO7hQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=WxLmBOnSsbqsy0mYrCGgXQ6uus+J0Ku4dQpcqDLcly0J/xeQvXFMpSQFS4Sy+7CI3
	 JN+8p8K4esjMmJqulEJGt7x+SWShngrPCmnASq8UpSqQeItdaezCqOPiv3yzIt24LI
	 IIJEcJd0WMmSs8k4mjbiEa1+/3hsY05MfnE1usgXhfgMlBcg6IQIIOxLK0dBZXWjoq
	 YCNXekPQv+QlvVUR2Rr3UPp3y4qOgvhympPTC77nl+Cjxc2tuKBuYsNaOe42IYLhra
	 fw9+S9YSDMGkyfXWVrB0vIGKBAk6yV06yTv7enHCeq+SblA2ObXc/b7Xf+2O2KnlQX
	 tgY/x+YlqsqtQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH net-next v2 4/4] selftests: rds: report missing RDMA prereqs as XFAIL
Date: Tue, 26 May 2026 19:34:23 -0700
Message-Id: <20260527023423.387792-5-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527023423.387792-1-achender@kernel.org>
References: <20260527023423.387792-1-achender@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21339-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DD0E55DE9AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make the RDMA test return XFAIL rather than skip when RXE is not
available, since the RDMA datapath is not run in netdev CI.

Change the three RDMA-prerequisite checks in check_rdma_conf() and
check_rdma_conf_enabled() to exit with the XFAIL code (5) and tag their
messages [XFAIL] instead of [SKIP].

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/rds_run.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/rds/rds_run.sh b/tools/testing/selftests/net/rds/rds_run.sh
index c16b30dbdd169..ba957a2257c91 100755
--- a/tools/testing/selftests/net/rds/rds_run.sh
+++ b/tools/testing/selftests/net/rds/rds_run.sh
@@ -123,10 +123,10 @@ check_rdma_conf_enabled() {
 		probe_module "$2"
 		return
 	fi
-	echo "selftests: [SKIP] rdma transport requires $1 enabled"
+	echo "selftests: [XFAIL] rdma transport requires $1 enabled"
 	echo "To enable, run" \
 	     "tools/testing/selftests/net/rds/config.sh -r and rebuild"
-	exit 4
+	exit 5
 }
 
 # Load the module backing a config that is built as a loadable module
@@ -148,7 +148,7 @@ check_conf() {
 }
 
 # Check kernel config and host environment for RDS-RDMA support.
-# Exits with SKIP (4) if the user requested rdma but prerequisites
+# Exits with XFAIL (5) if the user requested rdma but prerequisites
 # are not met.
 check_rdma_conf()
 {
@@ -163,9 +163,9 @@ check_rdma_conf()
 	check_rdma_conf_enabled CONFIG_RDS_RDMA rds_rdma
 
 	if ! which rdma > /dev/null 2>&1; then
-		echo "selftests: [SKIP] rdma transport requires the 'rdma'" \
-		      " tool (iproute2)"
-		exit 4
+		echo "selftests: [XFAIL] rdma transport requires the 'rdma'" \
+		      "tool (iproute2)"
+		exit 5
 	fi
 }
 
-- 
2.25.1


