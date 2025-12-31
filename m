Return-Path: <linux-rdma+bounces-15258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99691CEC699
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98625300C0C8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0A2C0269;
	Wed, 31 Dec 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PeLjBzk6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC402BE03B
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202649; cv=none; b=OBzF4XdWjeQAJwpv4KZKm1QrA7lg0A3+/GOdiulO/kvKn9U06NF5VzjUsU4/mpyXQByAsuYzhUvwO6MJwrrdP4/4s260rrARKlKVRTuKduT93uf6Sw1KHHewgUXj0Pe0/1cjD3K0gYConXbutPoV3eYTpR5wDYuXzUfPx6V1skA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202649; c=relaxed/simple;
	bh=WVYQGhpSvliDxHIS3oLwubflGM55eX6MoNuxuho0+Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO34Os3ZRfAiRRR5p2B+OrXV1s4kj8tmI2p2SIc1bDmPlSCV5Tb2udjJu01Wc87n9FToXiks03/bJLc8mldvL7FSQivsczA+lTmm2gefVUtfATzhFLUznjNY3cGGj9ngJYPK3sRKMTS8/IJOSQBY3EffiF9QfRQGVU4SLVTBH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PeLjBzk6; arc=none smtp.client-ip=209.85.208.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-64b6f22bc77so2376118a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202643; x=1767807443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=PeLjBzk6HD/l348HM8MLW1j5beEB21RZ112O4uvyZIZLMA55gblkaKZ2+Mb91hFnY5
         3xyXEyfKbkFaEORoDTeGujBGvo9Mgde/bR0k4fKNzUS85UwkKgp3W5G4IWKl/0Yt8686
         aGl8ymFQekBTdTHyUb7uPi+WekMbyjU8IfBgsPor4YDI1E+PS5EKR5VYt4xEARUdsEG6
         Cb2SRjHTdMhPk5pvMjOOO25PIByS+KZaJmPUfT8OTpglbwB7dzhmMz9mcJNd0PEjCHyK
         ETY4LqgN3btjlMPs9EUGii6evKaTJ36XHobXs1b3Ubn4MCXySU0QB2d2dDRgXN3fWOaH
         r36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202643; x=1767807443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPtJoM4BdsW1AWCT74nIdjccEavCkJ/nIFp8Za4jgwE=;
        b=n1gVAzgAqbOgxX7DpwLa02q5ib2LYykN/cGgdrbSQwLw63Xn+aQ0fcBSFArMnu+V8m
         JGjhvtRoHFBNv54vvSXDrGPbMFKb1kY0Lds/TdNQSyr6XW5K9R49yURmWNuVmQcDEHF2
         U6F5gBOocNRwUE/UNm0sXzHsVX51LnwlQJMiCQcTMW81KkIwWcd9x5VUBMA6nUAQ4+fS
         ZFnKnrGp1sKM4sMwvLk9uil4M1A4jXQJgp72BN2VrY/mUgLopnNSOUKooM2Qf2niKstW
         mYgcSsTlrN7xF2HVvl512Pc3LyhFc0ImcGYlCHkrJHie5gwXpVbRLyIZdlHEsDxZQeDZ
         mcqg==
X-Forwarded-Encrypted: i=1; AJvYcCXWUpNd73rKCLzrQLTWz4IDGM2EPVcwucbp1mcdui6oTGah3tA6LZj1X0du5wXGlxO8HRjualjb6bB7@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvPU8jYxlj5k0EjtPwbdodVojqlrYx99UGsSiv1eF4Qj3p+1i
	GMbzGSmH0HvOuuY+e7pNj/je5oXepgSytwvKHNVwqU8Fg+ciqQljatlXbLAKez7jMzdgZDhySJz
	Vso5op3f/ms8YUKWMQCBCVYNLciJ9ImiPg8Xe
X-Gm-Gg: AY/fxX5NyjGvOwfddOUQ6Kf8oC/4No+k/MVVO4dodKSbpKVQjXBxTM0doRmkvy/+nmu
	c9HQ9DZMEmi85zQNX4d1OowyiMHaKMNoMQyHk9wH0Qp7atTMIVMOVI45xWnegziZfTzebX39Wxl
	ZRoTIT/hhVBCwmJtIXFQkvlsdOhFdYvVnG9qHwtbiV4SAp/vuAJ14b28McosUXwW892A+Hs3p+s
	cWmYDmS9SeHYQfZ3GEYb1thnvtmh8BiwAcJDgYrJkmBgcROlPJcdQU1QBo9K31NW3L8tnu9ergf
	ysX1/8mONLHLR0NNHr2FYnPXFsYj9KXxynwpaScpRjAMPKNZ1QtISxHJ5+pmN2DmWR+dmSt7jWX
	mNtC0peEnjJe7wStvpWYm4eEq/7JnJ59tA1OGQQ2azA==
X-Google-Smtp-Source: AGHT+IEi03ZQZjXAnQiEZTFYKeIsY3RuVDBYnomwpJqWJlLI46xo1bUhyzXBcQMLZiL4Tr8s0Id0tWh610wS
X-Received: by 2002:a17:907:7209:b0:b76:3548:c34c with SMTP id a640c23a62f3a-b80372602eamr1981571766b.8.1767202643158;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b8037d637fasm499254166b.58.2025.12.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA50C34076F;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C307BE4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
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
Subject: [PATCH 2/5] HID: bpf: make __bpf_hid_bpf_ops const
Date: Wed, 31 Dec 2025 10:36:30 -0700
Message-ID: <20251231173633.3981832-3-csander@purestorage.com>
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
declare the __bpf_hid_bpf_ops global variable it points to as const.
This allows the global variable to be placed in readonly memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/hid/bpf/hid_bpf_struct_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_bpf_struct_ops.c
index 702c22fae136..30ddcf78e0ea 100644
--- a/drivers/hid/bpf/hid_bpf_struct_ops.c
+++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
@@ -286,11 +286,11 @@ static int __hid_bpf_hw_request(struct hid_bpf_ctx *ctx, unsigned char reportnum
 static int __hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, u64 source)
 {
 	return 0;
 }
 
-static struct hid_bpf_ops __bpf_hid_bpf_ops = {
+static const struct hid_bpf_ops __bpf_hid_bpf_ops = {
 	.hid_device_event = __hid_bpf_device_event,
 	.hid_rdesc_fixup = __hid_bpf_rdesc_fixup,
 	.hid_hw_request = __hid_bpf_hw_request,
 	.hid_hw_output_report = __hid_bpf_hw_output_report,
 };
-- 
2.45.2


