Return-Path: <linux-rdma+bounces-18368-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBimHy5Iu2kliQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18368-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:49:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB92C4313
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C8230FFF11
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B2261B91;
	Thu, 19 Mar 2026 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6W2X2My"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C282571A0;
	Thu, 19 Mar 2026 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881180; cv=none; b=PNCvnCyI9W/+pAtR+BHsmhVv8h7o2gMjeQg+tFUHIWsCEw06g5sFBMIiUMZei4XEdwSU1Nt7gGu9Jp8GWtWht8AVq/5bnz00huouYB2cp/b6Fu/8ereoIa/06mUqmU2NVQIHBLt9o9kLFHwL26sP54wUS6LMbGCUDxs9VxBz0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881180; c=relaxed/simple;
	bh=JpuUNfM4PlsFDqJAjAcCDLatRQsnVPWWIhOS10jM6NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUMezRmLSsYUw+yv52q/focUdZ01drO6XyysYqN89NTn4LSFm9ZZEBiC1LeD6dWEwOpAu01rFxIO3mLr4h2goijdHHXbuHnYiIhoIc8zOh90M8o0oZaW8TRaW/Tuh8Pu08wVEBcnsSfDC96s1T6WlIZ2l28n2XfP2eibQdmCHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6W2X2My; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8B5C2BC87;
	Thu, 19 Mar 2026 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881180;
	bh=JpuUNfM4PlsFDqJAjAcCDLatRQsnVPWWIhOS10jM6NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6W2X2My3XexiQryZHq9I1+IZVPHiMWv7NSu8t1yWCjCw31aFllp2iex+zn67QczF
	 vhPa4OsGiQbp/g3mAOTfRpmWh502/L3utP9Q0g1z94+eb6KCaRRR8Sy7tllTSvJQWr
	 o0+uFt5vjr0A6bojI5vY91Ghy6q0rW9um2R6dLbBCqIihf+H+eyuySILl0amHMUrqS
	 ob25KR8h2zbJdFRZAYAQu53esLLmLr2Ame9ppCd9QxaY55gw6dHULCGA60JmJVlqvt
	 XfKNp9P1nGWbSO0J+m0x7hGYwt1vxNgxwJa4/iroSBSJxJawaIfiDmahjyt6SPMWcf
	 Is4uZNm0m6peg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v2 1/2] selftests: rds: add tools/testing/selftests/net/rds/config
Date: Wed, 18 Mar 2026 17:46:17 -0700
Message-ID: <20260319004618.2577324-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319004618.2577324-1-achender@kernel.org>
References: <20260319004618.2577324-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18368-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21BB92C4313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ksft CI runtime needs an rds specific config file to build a
minimal kernel with the right options enabled.  This patch adds
an rds selftest config containing the required CONFIG_RDS* and
CONFIG_NET_* options.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/Makefile | 1 +
 tools/testing/selftests/net/rds/config   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index fe363be8e358..3eb0f633fd73 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -9,6 +9,7 @@ TEST_FILES := \
 	include.sh \
 	settings \
 	test.py \
+	config \
 # end of TEST_FILES
 
 EXTRA_CLEAN := \
diff --git a/tools/testing/selftests/net/rds/config b/tools/testing/selftests/net/rds/config
new file mode 100644
index 000000000000..103f9d941d10
--- /dev/null
+++ b/tools/testing/selftests/net/rds/config
@@ -0,0 +1,5 @@
+CONFIG_RDS=y
+CONFIG_RDS_TCP=y
+CONFIG_NET_NS=y
+CONFIG_VETH=y
+CONFIG_NET_SCH_NETEM=y
-- 
2.43.0


