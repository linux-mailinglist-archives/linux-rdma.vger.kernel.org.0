Return-Path: <linux-rdma+bounces-18828-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBo5A0Jiy2nCHAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18828-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:57:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CF36445A
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6037305BB8F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8F0371D0F;
	Tue, 31 Mar 2026 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEDlhw7V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D0371890;
	Tue, 31 Mar 2026 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936614; cv=none; b=UBVLa8mpXzkgMp3afh64U9qy4LD6xGtA+AIDcEWEnOeBk1Nff1qKUpSxAk6q/a1qnHB9g61BDTBf8ge59sn2s/4XcwI7PscgIcRRHVjlKwceLgaT6M0H/T/gmA+ukGnqdz5O9F33f4WYNf3hg7VCJu5AnFPKuR+RnHFxPRjANrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936614; c=relaxed/simple;
	bh=8PCIPCDnlGfi9fRYFfkIETHKvqA/mw9m2S1aONNRJdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4o7KCuJQ9uIYYrpDHg6ulYOWeG6hq68dD/wKOHfoLKGmwJsqgfqmCAhCsOpg1v5qA0eInv6064mwPVMyMg64aZ6cIXjHYnlX3t8C6gqo0DKuXcx71JYTxeL8GNpy/4rfSR1yssB7zxRpkz/u8nj3/Q1YPdL1+IfpYJ2ZQLu1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEDlhw7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E68C19424;
	Tue, 31 Mar 2026 05:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774936614;
	bh=8PCIPCDnlGfi9fRYFfkIETHKvqA/mw9m2S1aONNRJdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEDlhw7VVzT/CYwpIFBHeexNZr3ySdv6Q6DFNCI6hRvVoRs448+dEJWih0bXjsHVW
	 5HnhMQ2/qutuLUfw6oHPWRr8ywJ9aFQa4ncfBYUvae+bNS8H/lo7qWeGjFSmrkk1b1
	 OQ90B3YryNMfu2cC8upcdvjd19qix0+awhiM4ttAA6BrLPNL6zyxSHfAvebRbxYU5s
	 0QdrDTbr0BZbLaJN2w3NrEkU3rSvr6s7hWeAUcZDQut6OJCpdFENnK5asilqh7uuPB
	 Pxr6UlLob6z+Gm6ajWWU5VwZB6BhnIhNYoDQ95JX0avI7AAnbziAvlzKNOLHO5bD0T
	 KDcvkpWxhaEaw==
From: Leon Romanovsky <leon@kernel.org>
To: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH v2 2/4] selftests/bpf: add test cases for fw_validate_cmd hook
Date: Tue, 31 Mar 2026 08:56:34 +0300
Message-ID: <20260331-fw-lsm-hook-v2-2-78504703df1f@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18828-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B46CF36445A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chiara Meiohas <cmeiohas@nvidia.com>

The first test validates that the BPF verifier accepts a program
that accesses the hook parameters (in_len) and returns
values in the valid errno range.

The second test validates that the BPF verifier rejects a program
that returns a positive value, which is outside the valid [-4095, 0]
return range for BPF-LSM hooks.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 38e8e91768620..9b2487948f8cb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -188,4 +188,27 @@ int BPF_PROG(null_check, struct file *file)
 	return 0;
 }
 
+SEC("lsm/fw_validate_cmd")
+__description("lsm fw_validate_cmd: validate hook parameters")
+__success
+int BPF_PROG(fw_validate_cmd_test, const void *in, size_t in_len,
+	     const struct device *dev, enum fw_cmd_class class_id, u32 id)
+{
+	if (!in_len)
+		return -22;
+
+	return 0;
+}
+
+SEC("lsm/fw_validate_cmd")
+__description("lsm fw_validate_cmd: invalid positive return")
+__failure __msg("R0 has smin=1 smax=1 should have been in [-4095, 0]")
+__naked int fw_validate_cmd_fail(void *ctx)
+{
+	asm volatile (
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0


