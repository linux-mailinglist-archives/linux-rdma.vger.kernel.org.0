Return-Path: <linux-rdma+bounces-20439-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN+fEYaAAmpDtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20439-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:21:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A851827C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8462B305ECD2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09415296BBA;
	Tue, 12 May 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGB1/HiY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCDA29BD82
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548704; cv=none; b=moRh3UuusHG4WWlbAjT2KZn8tBS4gNJ8a7xW4TxuRMb4k5mRAku3SgsR4MOPvuW/TxBqcrXxdJ8w///DbHMN30HXbUExyGMhu8txEE63sdzAukmaF+MzGCW9bMZo6R3HAXsGpgyyEqHbSAuIthNw5kw/YokoFjgjbU0LLGau4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548704; c=relaxed/simple;
	bh=1QC4PkD36OXhmrBejw/9qqlS5pST0Kv6rS1HYH/Wsr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qy7wTZBTA9FpvBQJ1bl0qdReIe1+6B4po2CwQafRocOKVrNjj0yfckA51eYkq1dEo2ymiYxjnStVGEKHZVUnqG+35jCTp60tQNl87gRa/GyN8fNa88nzMAiyD8UEJcESQ+hKbzIEyGPWs2D0fU8ZB9D/4y42TF6UIpDm+wzYO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGB1/HiY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90caad2e944so62616385a.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 18:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548698; x=1779153498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXRLmOaeN9M4AwY3iBISX01P3DWw0uS/LnGVtbElBLg=;
        b=NGB1/HiYzPr5PkViOS+y5Yd85YYRNxoJK7krJlOqjGqkO9w02kF24VXWwMayogw1oa
         RiozLEcOU7BGga+IoXQO5y+jLfP9hLZeqic+zw6Enl7iEk8j8b0XJT8bmkxcsFKLFVra
         rS1mj5VlsrWFKfeUzQfzQmlNbPkubIKGrRCLUGJFjhZl+QBR8bhQTf2jS/d/Jej1tp3s
         6VFnTPzkWtBJY8r8ZzdA34mgeQaE9fUU5P+Vd2KUxlWoPfA2DKFf38ROa+dVbgPTlqRA
         qd1ZCg/Jor2/XYoTxBFY5X9TY3NTh3yMw86G03R5MJBNeZchf7o34KfGzdocUYp53IXA
         CfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548698; x=1779153498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXRLmOaeN9M4AwY3iBISX01P3DWw0uS/LnGVtbElBLg=;
        b=di+JrR+INZha5diHGeq3FeK/gDEOB3smtEOLYRppMRYdLDbjmCIVtCP4HjnPwzFusy
         2+o5d+FVNNWSiolJW6jQaT79Hrdx7EM+/7LgQ+vnGeHcrX107ICqFbmaJWWd5grXlLAA
         EgdyS9q+nynuPrrShownt0TOpedC6myDFH0gQhdvLxMXzHfiepLb8p2nKSl7zo9PZSYj
         cQwzCHxPjDvOMfIoqQizfiIjQRzHjqRtrflzikhceG5jC3n9TDT9vRDe41pV+ch15Cdt
         WqKXyS4EdhttyVRkfhV5i6B66WC0GMAE/4nA2RqtFhbrpGVHTlvCo/Ez2i8ApaIDdwVk
         /RKA==
X-Forwarded-Encrypted: i=1; AFNElJ+FOH8ZYVEFXDJ/r0zeTJTYXOgMwHGeoM5HRSG2tj26Lre46gTSMnYCxtvudFVE9Yee58QCPCBRWxl+@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJnw1qjd5RShAt7fLsxwOgYCsqmgP/6Y+Ybx0M6Ww6MID9HR2
	an5lftjul2Hl45kK4IeOO+XDLkDM0dw1qZ/L/5pLD1mSOy9VqItzVNzR
X-Gm-Gg: Acq92OEwHKwnMUHWZ9LnfOFOa6Z6KJ1aKmm3lHnNf2UJvGimj/QNq/SwX3v6Jv4khBN
	CRPgNPaNnlNxQlmVRXX1z3jKrkIjG8moKQ8GAnOyy25tQdwpnFsa0K9mrDiQTxwP8GGsZkjSzep
	yIDzCquyEJDhBxJKx/y0u7fxrXRq6dvNC0PzF9PaDBuj88Ri56jk7Kwj9NjmmpeLgMSgbtg9Tdx
	hLXa4mtLaPU1Q/StX+cKwxho2Y+qazNBZTqaK8nQZFGoS+qfvil+kihw3VsWOipb9uH+TkesXG1
	NvRVfmaFYvhzRUvq70HfDw5yLFekNI6kV1nSXpqmfoNVQU9M2eXziru6sIu6+LNhjCkC08ajWb7
	/Ce+DSXew047EEIp1kgQZSAVrzD1CXBUdg/py88YUy1Z1X/z/lYR2JKYIEUD+Dkjb6maSxAY8rT
	tuRwzJDH72LTZdwlFMvH8=
X-Received: by 2002:a05:620a:3713:b0:8cd:80f1:f460 with SMTP id af79cd13be357-904d66eeaf8mr3772364685a.45.1778548698188;
        Mon, 11 May 2026 18:18:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04de9sm3313682185a.44.2026.05.11.18.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 11 May 2026 18:17:58 -0700
Subject: [PATCH net-next v4 4/8] selftests: drv-net: ncdevmem: add -n flag
 to skip NIC configuration
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tcp-dm-netkit-v4-4-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
In-Reply-To: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
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
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 8B3A851827C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20439-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:mid,fomichev.me:email]
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


