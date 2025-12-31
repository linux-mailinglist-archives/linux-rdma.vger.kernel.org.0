Return-Path: <linux-rdma+bounces-15256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069ACEC654
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49AAF300974B
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFAA2BE051;
	Wed, 31 Dec 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aMZ0FO8e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AE2BCF6C
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202647; cv=none; b=IzDgFeqlcvNAaisvORH4YQAJMfcv7cJy2WYZ/Qs/LKgE5Fu6w/PGIwTgY2F6ELlNi3SCJfDd0bEhbTN6GaybcdxXYK0iRPE1KRzyBgVnWqTFIOzQapEtGmoypoec1pTvtj/yWo52ap9oLPs0f6JIPOV95U0qX+QJnvt4mKNs+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202647; c=relaxed/simple;
	bh=j34IflS+eKTJabK0NTs8ebKaiD8zpNvLHhM3IHbHvyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB4GSwpGg2n+uSwh67vs1Y+7IrQrR5EV/9d3Nh5Vyq6yWIk8spR2xf4jajJHsyknf/Ah3uQ7+S/cNQakUURc7UIUIlT1Mani12GWYAIrGuD3YQ4EWXWRgLENN0MGliLKwr28xEgNSTC7uQIOD6uzQOZ4JZPIDTqV7CUDlHkeYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aMZ0FO8e; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6446c7c5178so1687278d50.1
        for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202644; x=1767807444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnMrXoOdHpUw8dswWZLzwCvPJsKuA+x+IPeEnhc/WiU=;
        b=aMZ0FO8eE1ThIaxDlcweBOpkPbQXQynRdRZz9HbAePBd6TuFenODEQ1b/bVzry7W94
         WW2E1+MWmmXR65vJ8OzpXntfG3slaxcCvgmoBYSJjTjwRl+c4LDSo1rehO3z/yNfGsQq
         N0vMsKzGvmtafdCEO97d30auvv1z3sbN9tWUCawyigEykxJuFMS68HN3V8UEOSFd+81z
         tljzvFesn1+clmFE2E6Df+IdZfygCc1mgY4g6ZuN02IA4YBEdNiGnHykh6oWc4VoiFBS
         nXcgO9fRKcKWPlSQbLI5flFEBOnCQQDI5GCEso0++yp9k436pOJyjnvRWfwXbfIzHNyi
         z95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202644; x=1767807444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mnMrXoOdHpUw8dswWZLzwCvPJsKuA+x+IPeEnhc/WiU=;
        b=g8Tj99ay4ZH8s/pYs8zyP+BhMA6utZQ+6jFtcWziK19rOu8+OSGw6Juz+PufRSdPRN
         Nj3VppAFQN2MRZtukzrIGXcs1OKINfIFHo7RgGWVXMg6mStNPFB9786c6sgIYlhA8EYV
         JNWr8KHxjFQa6D4CaOGVsQryHOAnwmtDlMo/XGuyYcUxg7z/d0qvtJ04LAjy6Z08IL8F
         +UTeU3z8hxPfKchh0O5pFgM42Pvc8hpjhiIt6bqPOKwhqjPHM3Disl9SQppbCYkF63LB
         uoB/voWgXA0IDO8rIRKAXbka36Tr8BKMywfhw/ovSqayOPklLRTPU/EPoJAbKO5/dBrs
         zvQw==
X-Forwarded-Encrypted: i=1; AJvYcCWAU3GmBXzENWgiY4xlESmvRfLbX/rzA9B2weTTagFI0Dlm2CWEIivHNBa3JBlvXgwmkwnPCCPtxrPp@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcFI7IoivLQYSB77eXaeTDAyvFwRkFhcV75Gqb0yuOJgZJn6s
	X0mKsWJpH2Pck947Fx3HLYedZ//tFyQ78KGVPM0H6WSGytP2BYi4AntJcKJYYBcVMZwGu4/PEQe
	jcxalvVZYWdPmgX/dlduRbP4SpTlI/C6p9FDQBgX8KmttZ2jIhayQ
X-Gm-Gg: AY/fxX7kg3hcUvksQ8U1gtCI1MBlSCXeHVC9chKadTrDX6Qj5kd4JH/9e+av9ex+imu
	N9SGuouAzN8ISdT6Xbikggk2aUs6v96ert9PtIY+Kto1FxTSac6c7nqxGW6iz8PFnrsvkSQr7OH
	igKUsOqXDa7cDBeWKShlSrdZerCXrWpYtQLFYscaSUvr1qGRrlhNV9psuP1ESc+SjQv74XFD1nJ
	0KTx6Mx18FCjI0KgKluOyjwrcswTWzSkxehUYlYP7jAjQ6tN5shRbOSL3UDQFMju0PL0kHLFmtF
	rq67d6ml/yINLjBObVSP4f2YHxttRg8nFF35cXt9LNdRoI5wwMCbOlqqa7ekbHhSRknFWaMJmo6
	P61Nkw3LTHc1sDKiQKWZd/Qh7WDw=
X-Google-Smtp-Source: AGHT+IGMlV6Wi+eGoWgPSuCkcnDiX+llPw/Yxuw1WalLbJ19UweEl9/hcQpJmEfRSWezvyZ75uRmTz4c8mpi
X-Received: by 2002:a05:690c:387:b0:790:1669:d796 with SMTP id 00721157ae682-7901669d995mr128786567b3.1.1767202643785;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fc994a092sm16171307b3.6.2025.12.31.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 738753420F4;
	Wed, 31 Dec 2025 10:37:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6E501E4234A; Wed, 31 Dec 2025 10:37:22 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/5] net: make cfi_stubs globals const
Date: Wed, 31 Dec 2025 10:36:32 -0700
Message-ID: <20251231173633.3981832-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __bpf_bpf_dummy_ops, __bpf_ops_tcp_congestion_ops,
__bpf_ops_qdisc_ops, and __smc_bpf_hs_ctrl global variables it points to
as const. This allows the global variables to be placed in readonly
memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 net/bpf/bpf_dummy_struct_ops.c | 2 +-
 net/ipv4/bpf_tcp_ca.c          | 2 +-
 net/sched/bpf_qdisc.c          | 2 +-
 net/smc/smc_hs_bpf.c           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 812457819b5a..198152dbce9a 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -296,11 +296,11 @@ static int bpf_dummy_test_2(struct bpf_dummy_ops_state *cb, int a1, unsigned sho
 static int bpf_dummy_test_sleepable(struct bpf_dummy_ops_state *cb)
 {
 	return 0;
 }
 
-static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
+static const struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
 	.test_1 = bpf_dummy_ops__test_1,
 	.test_2 = bpf_dummy_test_2,
 	.test_sleepable = bpf_dummy_test_sleepable,
 };
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e01492234b0b..bd2ce4ff1762 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -306,11 +306,11 @@ static void __bpf_tcp_ca_init(struct sock *sk)
 
 static void __bpf_tcp_ca_release(struct sock *sk)
 {
 }
 
-static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
+static const struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.ssthresh = bpf_tcp_ca_ssthresh,
 	.cong_avoid = bpf_tcp_ca_cong_avoid,
 	.set_state = bpf_tcp_ca_set_state,
 	.cwnd_event = bpf_tcp_ca_cwnd_event,
 	.in_ack_event = bpf_tcp_ca_in_ack_event,
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..8f9a6440f113 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -427,11 +427,11 @@ static void Qdisc_ops__reset(struct Qdisc *sch)
 
 static void Qdisc_ops__destroy(struct Qdisc *sch)
 {
 }
 
-static struct Qdisc_ops __bpf_ops_qdisc_ops = {
+static const struct Qdisc_ops __bpf_ops_qdisc_ops = {
 	.enqueue = Qdisc_ops__enqueue,
 	.dequeue = Qdisc_ops__dequeue,
 	.init = Qdisc_ops__init,
 	.reset = Qdisc_ops__reset,
 	.destroy = Qdisc_ops__destroy,
diff --git a/net/smc/smc_hs_bpf.c b/net/smc/smc_hs_bpf.c
index 063d23d85850..5c562e2a15be 100644
--- a/net/smc/smc_hs_bpf.c
+++ b/net/smc/smc_hs_bpf.c
@@ -60,11 +60,11 @@ static int __smc_bpf_stub_set_tcp_option_cond(const struct tcp_sock *tp,
 					      struct inet_request_sock *ireq)
 {
 	return 1;
 }
 
-static struct smc_hs_ctrl __smc_bpf_hs_ctrl = {
+static const struct smc_hs_ctrl __smc_bpf_hs_ctrl = {
 	.syn_option	= __smc_bpf_stub_set_tcp_option,
 	.synack_option	= __smc_bpf_stub_set_tcp_option_cond,
 };
 
 static int smc_bpf_hs_ctrl_init(struct btf *btf) { return 0; }
-- 
2.45.2


