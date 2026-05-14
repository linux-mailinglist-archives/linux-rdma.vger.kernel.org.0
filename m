Return-Path: <linux-rdma+bounces-20725-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO0GLjYFBmrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20725-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:24:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EBE54535E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A407301CF40
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8C391831;
	Thu, 14 May 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScAMzkbl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F826391834
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779373; cv=none; b=Wpq7H/Cxz2DyYzDvxLkooCHwgDjAJpu3r4NSOSWfOGJGQgvjk5hdt6L1Nhp3OfOp8pNxh1WyTS+nB0UAXE4HVO4mvDguRelhNAhnK6cNAKr/Md3KbILNKTR1LoCA2kSMxLlFD8nqQJ4ORxZKHc2Rh7S34Lf39d0jHd95ovQY33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779373; c=relaxed/simple;
	bh=1QC4PkD36OXhmrBejw/9qqlS5pST0Kv6rS1HYH/Wsr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZudS8AvHq6bjeEdcrI8uNX0+JV6GM3FhDB7dwRx+PGulX1dHp7lgsrvZY5Uz/w/FopySBMf3t8l93ZMX5FpmxoG+6Eetoj0kV5ab8wDO0376It7LBqFZoZBJZprVVV1f9LVrm4oy2A0X7xiib7tVYjewL6mQgyzGbk6vPKamAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScAMzkbl; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-654672a6d68so10325027d50.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779370; x=1779384170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXRLmOaeN9M4AwY3iBISX01P3DWw0uS/LnGVtbElBLg=;
        b=ScAMzkblT7qEDln9wMUuYFMaxTnmSPjhz0noMVYe7tl0vUi6ucNEVtdY1cJtNBOtjk
         sAymgASCXcLuM//46H/kTzQ6Xr66JALSSoTxBDDCqbtaKmbUHEv0kILlmm+pgzhqyZ9t
         XeZPotVpZWVdcSj/tELH6sFH51fzmyxwj7Bkh+RuuYR9aoSEr6tsfrED7itTGsnP3v1T
         4Iu8SKZ+cn0XiwfBsw5mr5e5sZMa2I1GJ3pMTMssMBKwD5SC43//EIDoOtO1Xng9Qn2W
         vj8sSipZgjs6tqut4Kk4aFETcio9B28Xq7lS6Rd9M6cxZq/pGPCD4cnTIYSyziDQEgxk
         gQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779370; x=1779384170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXRLmOaeN9M4AwY3iBISX01P3DWw0uS/LnGVtbElBLg=;
        b=T2f8mXawSiASKP+n8oM1fT+38IGzwsXu/YcAZFovvF6Z3bvqW76O4mY14s9XIy+Usu
         Lu++tm46oyiySQf2JarySbpEjVJBvbY3ZIZBBqYyhaha6Xvi0dyWNFPfMJKBv4+2deEO
         XVGbo2Ls2JU+vszhtVauTVT1XUAcrQtMFCIWmRRKCcyN5WQXnfS5Q3vyB/bifyvNvfq5
         YmIaUsF7ciLQMW2ZdxOI5qApkdbpipRqyio+PeJ9UPGlJ/cA789vHNyjKBa9rtwez1Bw
         WyuIVFJBEogOS+yqgq0xnrS4gxx5ikKTdMSVMSiGQ5qSMRjOPjlkMoHJeRgPoAyUkw2s
         l+BA==
X-Forwarded-Encrypted: i=1; AFNElJ8oWm2ZWPsNTktVpe6zuscPgALpplOWPI7s0g0b2SC7+i3SrbfPqM5fFNpc54mbp/InhtnSeMbfsw5a@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5HaFwYkPEVkCLeybZDCldPO5D9CdL1/2ZEsLiuThGWdonqB0D
	hnAmPuX7CemD4LbEW7dHArefgQBOKMNAK6Zt9Sa0Od08hS7IDxQuanii
X-Gm-Gg: Acq92OER0ot7l9NHNFYHgCB6Hvf1uSvCuXlRnLq1jAZZm32XpjtC5uqOt94DpKZTWod
	P/bgCU0UcfBpMOqS5ihtEhUReJeKhXzeNzYmuPIB449HDwvZRj61t7qlhnkDa1Djn2hixfXOCKX
	ZVBLj5CJOdqgv3urCurdomXaMdEqCz6nkRmmKkDkUh9ixpU5cuU+DAGwh20cCwBdgDN51SXs6Ot
	99qSq2WTXZEBbVwwlUFmQUOMPql8XnTDMmeqIX1i8uqw8qoxio5VwdgsiXibALJOqhGTySVHEb2
	lbazeEliC9M9SwLwDRTt5/Iqx0sc/cItSP4VGf92L+X1gEII+0z2GfV0D5lsR0S7LXlOqMAkLPH
	1KTOwSayarkoiME49jjZ8x0d2YTxTwaYKo3ZfyXVSt3KY/WPEo1DtkvdKnOvUZSt5HulA1rzk1S
	wbyDVV3y+oBp3rMZWeZd/kYw==
X-Received: by 2002:a53:d046:0:10b0:65d:f14d:8651 with SMTP id 956f58d0204a3-65e226e0182mr151093d50.24.1778779369718;
        Thu, 14 May 2026 10:22:49 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:19::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e701fsm1373608d50.8.2026.05.14.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:49 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:31 -0700
Subject: [PATCH net-next v5 4/8] selftests: drv-net: ncdevmem: add -n flag
 to skip NIC configuration
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-tcp-dm-netkit-v5-4-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: B4EBE54535E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20725-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email,meta.com:mid]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a -n (skip_config) flag that causes ncdevmem to skip NIC
configuration when operating as an RX server. When -n is passed,
ncdevmem skips configuring header split, RSS, and flow steering, as well
as their teardown on exit.

This allows ksft tests to pre-configure the NIC in the host namespace
before launching ncdevmem in the guest namespace. This is needed for
netkit devmem tests where the test harness namespace has direct access
to the NIC and the ncdevmem namespace does not.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 58 +++++++++++++----------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index e098d6534c3c..d96e8a3b5a65 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -93,6 +93,7 @@ static char *port;
 static size_t do_validation;
 static int start_queue = -1;
 static int num_queues = -1;
+static int skip_config;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -828,7 +829,7 @@ static struct netdev_queue_id *create_queues(void)
 
 static int do_server(struct memory_buffer *mem)
 {
-	struct ethtool_rings_get_rsp *ring_config;
+	struct ethtool_rings_get_rsp *ring_config = NULL;
 	char ctrl_data[sizeof(int) * 20000];
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
@@ -851,27 +852,29 @@ static int do_server(struct memory_buffer *mem)
 		return -1;
 	}
 
-	ring_config = get_ring_config();
-	if (!ring_config) {
-		pr_err("Failed to get current ring configuration");
-		return -1;
-	}
+	if (!skip_config) {
+		ring_config = get_ring_config();
+		if (!ring_config) {
+			pr_err("Failed to get current ring configuration");
+			return -1;
+		}
 
-	if (configure_headersplit(ring_config, 1)) {
-		pr_err("Failed to enable TCP header split");
-		goto err_free_ring_config;
-	}
+		if (configure_headersplit(ring_config, 1)) {
+			pr_err("Failed to enable TCP header split");
+			goto err_free_ring_config;
+		}
 
-	/* Configure RSS to divert all traffic from our devmem queues */
-	if (configure_rss()) {
-		pr_err("Failed to configure rss");
-		goto err_reset_headersplit;
-	}
+		/* Configure RSS to divert all traffic from our devmem queues */
+		if (configure_rss()) {
+			pr_err("Failed to configure rss");
+			goto err_reset_headersplit;
+		}
 
-	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering(&server_sin)) {
-		pr_err("Failed to configure flow steering");
-		goto err_reset_rss;
+		/* Flow steer our devmem flows to start_queue */
+		if (configure_flow_steering(&server_sin)) {
+			pr_err("Failed to configure flow steering");
+			goto err_reset_rss;
+		}
 	}
 
 	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
@@ -1052,13 +1055,17 @@ static int do_server(struct memory_buffer *mem)
 err_unbind:
 	ynl_sock_destroy(ys);
 err_reset_flow_steering:
-	reset_flow_steering();
+	if (!skip_config)
+		reset_flow_steering();
 err_reset_rss:
-	reset_rss();
+	if (!skip_config)
+		reset_rss();
 err_reset_headersplit:
-	restore_ring_config(ring_config);
+	if (!skip_config)
+		restore_ring_config(ring_config);
 err_free_ring_config:
-	ethtool_rings_get_rsp_free(ring_config);
+	if (!skip_config)
+		ethtool_rings_get_rsp_free(ring_config);
 	return err;
 }
 
@@ -1404,7 +1411,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:n")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
@@ -1436,6 +1443,9 @@ int main(int argc, char *argv[])
 		case 'z':
 			max_chunk = atoi(optarg);
 			break;
+		case 'n':
+			skip_config = 1;
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.53.0-Meta


