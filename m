Return-Path: <linux-rdma+bounces-18428-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGZsIO/KvGnT2wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18428-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 05:19:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDE2D5C02
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 05:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C9B30D2AB2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9592E8B8A;
	Fri, 20 Mar 2026 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdqf2+jS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77F2E6CA6;
	Fri, 20 Mar 2026 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773980317; cv=none; b=swZP3LMjNvoSkYgYew2v/u8TXDeXFUBAFcfqF7RoevuMQqC6SKAVTSDJxTdl1ka3WBySvWAvg2YalClA2Pdl94BugMYTzYb+Lbb+z1Rl6rcfPPSS4hlgtN6w+dEVUae5cfouCRC+gJMnKEGlfrOXPmINU2OJfFNc7U29NfdTwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773980317; c=relaxed/simple;
	bh=6/2m7v2FTKlsxTQgTk/QAht/zdSlPXEdWJXqjyjWuR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj7nyqUc2Nml+qgHOu0/sWUvwYvP3mk62W2R2Fg2Wxfsj/cl8XKgEaqbIb3aUARUGPC4An/JVvsvVVQySxMs4yBP3/g+2gVZR4t6OoM2veBIz407liQeOc5Hcr80QXBdjpeVMfdP8sviNTkIn4mzZvmOK6dc4p5PWiDdTp6vgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdqf2+jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36785C2BCB0;
	Fri, 20 Mar 2026 04:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773980316;
	bh=6/2m7v2FTKlsxTQgTk/QAht/zdSlPXEdWJXqjyjWuR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdqf2+jSCfAwtau8mY3C1s+bn+/NpQ8+CilhDgjpn7mdKB4TwkHXyfHP+5kCuvxGU
	 4ZmPwTtmKw7r4c7Q257vKjbaoJd+jTovzCa1kq9AwOMtfXm8SNgUSYyIzSmc9qdTJF
	 U1ESiY+R6XYxb8wPljf2Z8rgOpTiWF13g8Mn5NHWQZB9z2FfCJf8K6702T5UUx8KsB
	 tbXrFJEOm/LtwlMzLh3+EfAb42OPT3oYjv4RJ+MMkxGfR8BTEdrVzg76q8C7koODLC
	 wPKhOe/X3fNWFkEytNLbdJlfKFfNkmVBgGPN0OH9OCwu9gUoNV9tfk2ht9aJKUN6IF
	 GHoV+tnEKTAYw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v3 1/2] selftests: rds: add tools/testing/selftests/net/rds/config
Date: Thu, 19 Mar 2026 21:18:33 -0700
Message-ID: <20260320041834.2761069-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320041834.2761069-1-achender@kernel.org>
References: <20260320041834.2761069-1-achender@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18428-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,run.sh:url]
X-Rspamd-Queue-Id: 2CBDE2D5C02
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
index fe363be8e358..a3462dadb47c 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -6,6 +6,7 @@ all:
 TEST_PROGS := run.sh
 
 TEST_FILES := \
+	config \
 	include.sh \
 	settings \
 	test.py \
diff --git a/tools/testing/selftests/net/rds/config b/tools/testing/selftests/net/rds/config
new file mode 100644
index 000000000000..97db7ecb892a
--- /dev/null
+++ b/tools/testing/selftests/net/rds/config
@@ -0,0 +1,5 @@
+CONFIG_NET_NS=y
+CONFIG_NET_SCH_NETEM=y
+CONFIG_RDS=y
+CONFIG_RDS_TCP=y
+CONFIG_VETH=y
-- 
2.43.0


