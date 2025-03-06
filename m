Return-Path: <linux-rdma+bounces-8447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC62A55A8E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6AF1676E0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7504D27EC92;
	Thu,  6 Mar 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="bDL6EARs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1E27EC6C
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302253; cv=none; b=nyn7JsihXzZvnUK55pQBTkwCIOsfgZYeB9/t5MpERW48x0WIT4hXAT/EywxVFbPPmNEElo47QpEC1/O+QWJ8WNIN1SkJuIYrgoQUBrx+KunRUe/aJqqygmVmfuj2/z/v9Fy/vyw+GQhDnmWjdCWlC4J085M2ZP/0MCbbOZ35NL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302253; c=relaxed/simple;
	bh=rhAdls14aXXr+B3banKqLmvbLqUuZInVd88ZhCUc3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqI9rPnmfd3cYZbVJQgEgJxUbUKuK5yrZEWJOBm80uAsaIgRV5S2YxaQMFjGvXofcvWtwFs6YeHBwRHjgBqbtQm0zw5yt4aCpdfCNwyBl6E3LaE8wfGPqKBiAM4XlCBSbpA3ZGpT6lyK2r6IKYtM2cJtUhqEfrcLtJIJ1bm+O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=bDL6EARs; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so19127846d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302249; x=1741907049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fIFQBWAbnslNfcoBo9zTprT+wxmi9gtYJ6rGux2+U8=;
        b=bDL6EARsr9MPoZFIMmPRdekv7u7/QORpBvSUlXOzBaCRYM4JsFeEOpDGs/l+xGrMJs
         1MqEfKVjlNt+RY6Y4b2J2kK69ZkSVNlB9uNDaKH26PfC4CExyReMBqwdOhYdeQ21QkX6
         7izS8luE5js7BUurTn3fMmvU9qjSZh6OgcVdQaxN1Jgx2xP99rjZ/SlB17dD89EemA7l
         xPNTkKtkJoU0WrwRPLgPApcixNXSVtOveZDdGATgDc+uOmkTvTEPlme/xs3N9XqsNpnE
         vmrCFlTMI7ejL5z8AMMZHTViHVjnuXuYNA85RUbkxgBhLtnGmkkt0xL7Rp8OCnPlAOI2
         uEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302249; x=1741907049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fIFQBWAbnslNfcoBo9zTprT+wxmi9gtYJ6rGux2+U8=;
        b=Q1CkCzPx1lCYEfAB0GRQRhi7UNsY61s8xikwA9BjCV3UguYxrvWFAt9uEjZ0UTxNKM
         1vVNPfXfWm0DsdlK095yNcH2013uHAyI55EHcLtaHxPsdGVp8XNq7PKf5b31FhGxqURn
         URxTvOMtzCrDGnZMfUwdlFWAHa+brbvtyf/jJT1QdkMwEph9vNevD/PXWtwDfQ5HSI3L
         88gPl06YFCXfXyi3v35yR0QJje0fAbrRXfWFmGjPJdyBJLnWRt1Bkq6LK3AufHp5oQTV
         ht2vP91lkT3xrBUe+xUxnIggNJg3s7UnInTmQKzL6G2Hn9b1CgMZ95kGf8JWRfLCytN1
         rkRg==
X-Forwarded-Encrypted: i=1; AJvYcCXX2Jvv6sM2R7rUDRIexKlOibuVAuRB6ulOn90yDtByR9XNDc0TqIO6zm9+co7KZwCs3PjQE/icAHJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyalHXUrTcKtNDm9x9cH42VoloFP+QHY5pFtsmTXcHYxUwqUMNl
	XKsYWoaXAnl8b3a5DgJprzDS1obQsnxH8+J0YpxGk9baq2JyW4WIwwYCgklJUVc=
X-Gm-Gg: ASbGncu4uJIeRJu2xlwA24IKfLJzkUm8NsWyIHKVPiaeZIicBkdmNdz8rFozqtc3C/W
	XkyaRzuRW0GBGedGa3gfC13YrbEWpgz2Vs08unKqzwBsMuGo3XNXyCXVjNsUAhuMB/VKK6FSXZA
	5hUMHXtWoCDtxdsdjJ/B0FtkQwv5TQHcV7IrrrfjyDgfMT+1QA4gxihsS/thRdhqn5D+vv14+F4
	K9BVZUrxcPRmz9Uus16u28Vw7Jq58+v8JMcBDdqipaOszrWfjEknIhYFRShl3JzrWPjjSPCBEvE
	ufblElmPs87NEDZBI/sYMVKBKjP6NFEEx3bYlm/I79WkTp8BATkfBipCYn27NEEYRy8b
X-Google-Smtp-Source: AGHT+IE8RTkpccWKR7R9PIQ42rOgsV9xy4dpzuu3Ea5ud+SklRJR2rjnOUq4KV2vowlIyWuc7cqZ0Q==
X-Received: by 2002:a05:6214:2606:b0:6e4:31d9:b357 with SMTP id 6a1803df08f44-6e8f46b019cmr93542806d6.1.1741302249312;
        Thu, 06 Mar 2025 15:04:09 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:08 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 06/13] drivers: ultraeth: add initial PDS infrastructure
Date: Fri,  7 Mar 2025 01:01:56 +0200
Message-ID: <20250306230203.1550314-7-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PDS structures as described in the specifications and helpers to
access their fields which are also exposed to user-space. Add initial
kernel PDS structures and routines to manage PDCs. PDC ids are random
and allocated when a PDC gets created. Each PDC instance has a spinlock to
protect it, lookups are done with RCU using two rhashtables
 - one for our local PDC ids
 - one for endpoints

Receiving a packet currently is a noop.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/Makefile          |   2 +-
 drivers/ultraeth/uecon.c           |  23 +-
 drivers/ultraeth/uet_context.c     |   7 +
 drivers/ultraeth/uet_job.c         |   1 +
 drivers/ultraeth/uet_pdc.c         | 124 ++++++++++
 drivers/ultraeth/uet_pds.c         | 159 +++++++++++++
 include/net/ultraeth/uet_context.h |  14 ++
 include/net/ultraeth/uet_pdc.h     |  79 +++++++
 include/net/ultraeth/uet_pds.h     |  93 ++++++++
 include/uapi/linux/ultraeth.h      | 354 +++++++++++++++++++++++++++++
 10 files changed, 850 insertions(+), 6 deletions(-)
 create mode 100644 drivers/ultraeth/uet_pdc.c
 create mode 100644 drivers/ultraeth/uet_pds.c
 create mode 100644 include/net/ultraeth/uet_pdc.h
 create mode 100644 include/net/ultraeth/uet_pds.h

diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
index 0035023876ab..f2d6a8569dbf 100644
--- a/drivers/ultraeth/Makefile
+++ b/drivers/ultraeth/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_ULTRAETH) += ultraeth.o
 
 ultraeth-objs := uet_main.o uet_context.o uet_netlink.o uet_job.o \
-			uecon.o
+			uecon.o uet_pdc.o uet_pds.o
diff --git a/drivers/ultraeth/uecon.c b/drivers/ultraeth/uecon.c
index 4b74680700af..38f930bf93ec 100644
--- a/drivers/ultraeth/uecon.c
+++ b/drivers/ultraeth/uecon.c
@@ -42,9 +42,9 @@ static netdev_tx_t uecon_ndev_xmit(struct sk_buff *skb, struct net_device *dev)
 				   use_cache ? &info->dst_cache : NULL);
 	if (IS_ERR(rt)) {
 		if (PTR_ERR(rt) == -ELOOP)
-			dev->stats.collisions++;
+			DEV_STATS_INC(dev, collisions);
 		else if (PTR_ERR(rt) == -ENETUNREACH)
-			dev->stats.tx_carrier_errors++;
+			DEV_STATS_INC(dev, tx_carrier_errors);
 
 		goto out_err;
 	}
@@ -83,7 +83,7 @@ static netdev_tx_t uecon_ndev_xmit(struct sk_buff *skb, struct net_device *dev)
 out_err:
 	rcu_read_unlock();
 	dev_kfree_skb(skb);
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 
 	return NETDEV_TX_OK;
 }
@@ -91,7 +91,11 @@ static netdev_tx_t uecon_ndev_xmit(struct sk_buff *skb, struct net_device *dev)
 static int uecon_ndev_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct uecon_ndev_priv *uecpriv;
-	int len;
+	__be32 saddr, daddr;
+	unsigned int len;
+	__be16 dport;
+	__u8 tos;
+	int ret;
 
 	uecpriv = rcu_dereference_sk_user_data(sk);
 	if (!uecpriv)
@@ -100,6 +104,11 @@ static int uecon_ndev_encap_recv(struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		goto drop;
 
+	saddr = ip_hdr(skb)->saddr;
+	daddr = ip_hdr(skb)->daddr;
+	dport = udp_hdr(skb)->source;
+	tos = ip_hdr(skb)->tos;
+
 	/* we assume [ tnl ip hdr ] [ tnl udp hdr ] [ pdc hdr ] [ ses hdr ] */
 	if (iptunnel_pull_header(skb, sizeof(struct udphdr), htons(ETH_P_802_3), false))
 		goto drop_count;
@@ -109,7 +118,11 @@ static int uecon_ndev_encap_recv(struct sock *sk, struct sk_buff *skb)
 	skb->pkt_type = PACKET_HOST;
 	skb->dev = uecpriv->dev;
 	len = skb->len;
-	consume_skb(skb);
+	ret = uet_pds_rx(&uecpriv->context->pds, skb, daddr, saddr, dport, tos);
+	if (ret < 0)
+		goto drop_count;
+	else if (ret == 0)
+		consume_skb(skb);
 	dev_sw_netstats_rx_add(uecpriv->dev, len);
 
 	return 0;
diff --git a/drivers/ultraeth/uet_context.c b/drivers/ultraeth/uet_context.c
index e0d276cb1942..6bdd72344e01 100644
--- a/drivers/ultraeth/uet_context.c
+++ b/drivers/ultraeth/uet_context.c
@@ -107,6 +107,10 @@ int uet_context_create(int id)
 	if (err)
 		goto ctx_jobs_err;
 
+	err = uet_pds_init(&ctx->pds);
+	if (err)
+		goto ctx_pds_err;
+
 	err = uecon_netdev_init(ctx);
 	if (err)
 		goto ctx_netdev_err;
@@ -116,6 +120,8 @@ int uet_context_create(int id)
 	return 0;
 
 ctx_netdev_err:
+	uet_pds_uninit(&ctx->pds);
+ctx_pds_err:
 	uet_jobs_uninit(&ctx->job_reg);
 ctx_jobs_err:
 	uet_context_put_id(ctx);
@@ -129,6 +135,7 @@ static void __uet_context_destroy(struct uet_context *ctx)
 {
 	uet_context_unlink(ctx);
 	uecon_netdev_uninit(ctx);
+	uet_pds_uninit(&ctx->pds);
 	uet_jobs_uninit(&ctx->job_reg);
 	uet_context_put_id(ctx);
 	kfree(ctx);
diff --git a/drivers/ultraeth/uet_job.c b/drivers/ultraeth/uet_job.c
index 3a55a0f70749..4a421dd8e86c 100644
--- a/drivers/ultraeth/uet_job.c
+++ b/drivers/ultraeth/uet_job.c
@@ -55,6 +55,7 @@ static void __job_disassociate(struct uet_job *job)
 	WRITE_ONCE(fep->job_id, 0);
 	RCU_INIT_POINTER(job->fep, NULL);
 	synchronize_rcu();
+	uet_pds_clean_job(&fep->context->pds, job->id);
 }
 
 struct uet_job *uet_job_find(struct uet_job_registry *jreg, u32 id)
diff --git a/drivers/ultraeth/uet_pdc.c b/drivers/ultraeth/uet_pdc.c
new file mode 100644
index 000000000000..47cf4c3dee04
--- /dev/null
+++ b/drivers/ultraeth/uet_pdc.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <net/ultraeth/uet_context.h>
+#include <net/ultraeth/uet_pdc.h>
+
+/* use the approach as nf nat, try a few rounds starting at random offset */
+static bool uet_pdc_id_get(struct uet_pdc *pdc)
+{
+	int attempts = UET_PDC_ID_MAX_ATTEMPTS, i;
+
+	pdc->spdcid = get_random_u16();
+try_again:
+	for (i = 0; i < attempts; i++, pdc->spdcid++) {
+		if (uet_pds_pdcid_insert(pdc) == 0)
+			return true;
+	}
+
+	if (attempts > 16) {
+		attempts /= 2;
+		pdc->spdcid = get_random_u16();
+		goto try_again;
+	}
+
+	return false;
+}
+
+struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
+			       u16 dpdcid, u16 pid_on_fep, u8 mode,
+			       u8 tos, __be16 dport,
+			       const struct uet_pdc_key *key, bool is_inbound)
+{
+	struct uet_pdc *pdc, *pdc_ins = ERR_PTR(-ENOMEM);
+	IP_TUNNEL_DECLARE_FLAGS(md_flags) = { };
+	int ret __maybe_unused;
+
+	switch (mode) {
+	case UET_PDC_MODE_RUD:
+		break;
+	case UET_PDC_MODE_ROD:
+		fallthrough;
+	case UET_PDC_MODE_RUDI:
+		fallthrough;
+	case UET_PDC_MODE_UUD:
+		fallthrough;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	pdc = kzalloc(sizeof(*pdc), GFP_ATOMIC);
+	if (!pdc)
+		goto err_alloc;
+	memcpy(&pdc->key, key, sizeof(*key));
+	pdc->pds = pds;
+	pdc->mode = mode;
+	pdc->is_initiator = !is_inbound;
+
+	if (!uet_pdc_id_get(pdc))
+		goto err_id_get;
+
+	spin_lock_init(&pdc->lock);
+
+	pdc->rx_base_psn = rx_base_psn;
+	pdc->tx_base_psn = rx_base_psn;
+	pdc->state = state;
+	pdc->dpdcid = dpdcid;
+	pdc->pid_on_fep = pid_on_fep;
+	pdc->metadata = __ip_tun_set_dst(key->src_ip, key->dst_ip, tos, 0, dport,
+					 md_flags, 0, 0);
+	if (!pdc->metadata)
+		goto err_tun_dst;
+
+#ifdef CONFIG_DST_CACHE
+	ret = dst_cache_init(&pdc->metadata->u.tun_info.dst_cache, GFP_ATOMIC);
+	if (ret) {
+		pdc_ins = ERR_PTR(ret);
+		goto err_ep_insert;
+	}
+#endif
+	pdc->metadata->u.tun_info.mode |= IP_TUNNEL_INFO_TX;
+
+	if (is_inbound) {
+		/* this PDC is a result of packet Rx */
+		pdc_ins = pdc;
+		goto out;
+	}
+
+	pdc_ins = uet_pds_pdcep_insert(pdc);
+	if (!pdc_ins) {
+		pdc_ins = pdc;
+	} else {
+		/* someone beat us to it or there was an error, either way
+		 * we free the newly created pdc and drop the ref
+		 */
+		goto err_ep_insert;
+	}
+
+out:
+	return pdc_ins;
+
+err_ep_insert:
+	dst_release(&pdc->metadata->dst);
+err_tun_dst:
+	uet_pds_pdcid_remove(pdc);
+err_id_get:
+	kfree(pdc);
+err_alloc:
+	goto out;
+}
+
+void uet_pdc_free(struct uet_pdc *pdc)
+{
+	dst_release(&pdc->metadata->dst);
+	kfree(pdc);
+}
+
+void uet_pdc_destroy(struct uet_pdc *pdc)
+{
+	uet_pds_pdcep_remove(pdc);
+	uet_pds_pdcid_remove(pdc);
+	uet_pds_pdc_gc_queue(pdc);
+}
diff --git a/drivers/ultraeth/uet_pds.c b/drivers/ultraeth/uet_pds.c
new file mode 100644
index 000000000000..4aec61eeb230
--- /dev/null
+++ b/drivers/ultraeth/uet_pds.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/bug.h>
+
+#include <net/ultraeth/uet_context.h>
+#include <net/ultraeth/uet_pdc.h>
+
+static const struct rhashtable_params uet_pds_pdcid_rht_params = {
+	.head_offset = offsetof(struct uet_pdc, pdcid_node),
+	.key_offset = offsetof(struct uet_pdc, spdcid),
+	.key_len = sizeof(u16),
+	.nelem_hint = 2048,
+	.max_size = UET_PDC_MAX_ID,
+	.automatic_shrinking = true,
+};
+
+static const struct rhashtable_params uet_pds_pdcep_rht_params = {
+	.head_offset = offsetof(struct uet_pdc, pdcep_node),
+	.key_offset = offsetof(struct uet_pdc, key),
+	.key_len = sizeof(struct uet_pdc_key),
+	.nelem_hint = 2048,
+	.automatic_shrinking = true,
+};
+
+static void uet_pds_pdc_gc_flush(struct uet_pds *pds)
+{
+	HLIST_HEAD(deleted_head);
+	struct hlist_node *tmp;
+	struct uet_pdc *pdc;
+
+	spin_lock_bh(&pds->gc_lock);
+	hlist_move_list(&pds->pdc_gc_list, &deleted_head);
+	spin_unlock_bh(&pds->gc_lock);
+
+	synchronize_rcu();
+
+	hlist_for_each_entry_safe(pdc, tmp, &deleted_head, gc_node)
+		uet_pdc_free(pdc);
+}
+
+static void uet_pds_pdc_gc_work(struct work_struct *work)
+{
+	struct uet_pds *pds = container_of(work, struct uet_pds, pdc_gc_work);
+
+	uet_pds_pdc_gc_flush(pds);
+}
+
+void uet_pds_pdc_gc_queue(struct uet_pdc *pdc)
+{
+	struct uet_pds *pds = pdc->pds;
+
+	spin_lock_bh(&pds->gc_lock);
+	if (hlist_unhashed(&pdc->gc_node))
+		hlist_add_head(&pdc->gc_node, &pds->pdc_gc_list);
+	spin_unlock_bh(&pds->gc_lock);
+
+	queue_work(system_long_wq, &pds->pdc_gc_work);
+}
+
+int uet_pds_init(struct uet_pds *pds)
+{
+	int ret;
+
+	spin_lock_init(&pds->gc_lock);
+	INIT_HLIST_HEAD(&pds->pdc_gc_list);
+	INIT_WORK(&pds->pdc_gc_work, uet_pds_pdc_gc_work);
+
+	ret = rhashtable_init(&pds->pdcid_hash, &uet_pds_pdcid_rht_params);
+	if (ret)
+		goto err_pdcid_hash;
+
+	ret = rhashtable_init(&pds->pdcep_hash, &uet_pds_pdcep_rht_params);
+	if (ret)
+		goto err_pdcep_hash;
+
+	return 0;
+
+err_pdcep_hash:
+	rhashtable_destroy(&pds->pdcid_hash);
+err_pdcid_hash:
+	return ret;
+}
+
+struct uet_pdc *uet_pds_pdcep_insert(struct uet_pdc *pdc)
+{
+	struct uet_pds *pds = pdc->pds;
+
+	return rhashtable_lookup_get_insert_fast(&pds->pdcep_hash,
+						 &pdc->pdcep_node,
+						 uet_pds_pdcep_rht_params);
+}
+
+void uet_pds_pdcep_remove(struct uet_pdc *pdc)
+{
+	struct uet_pds *pds = pdc->pds;
+
+	rhashtable_remove_fast(&pds->pdcep_hash, &pdc->pdcep_node,
+			       uet_pds_pdcep_rht_params);
+}
+
+int uet_pds_pdcid_insert(struct uet_pdc *pdc)
+{
+	struct uet_pds *pds = pdc->pds;
+
+	return rhashtable_insert_fast(&pds->pdcid_hash, &pdc->pdcid_node,
+				      uet_pds_pdcid_rht_params);
+}
+
+void uet_pds_pdcid_remove(struct uet_pdc *pdc)
+{
+	struct uet_pds *pds = pdc->pds;
+
+	rhashtable_remove_fast(&pds->pdcid_hash, &pdc->pdcid_node,
+			       uet_pds_pdcid_rht_params);
+}
+
+static void uet_pds_pdcep_hash_free(void *ptr, void *arg)
+{
+	struct uet_pdc *pdc = ptr;
+
+	uet_pdc_destroy(pdc);
+}
+
+void uet_pds_uninit(struct uet_pds *pds)
+{
+	rhashtable_free_and_destroy(&pds->pdcep_hash, uet_pds_pdcep_hash_free, NULL);
+	/* the above call should also release all PDC ids */
+	WARN_ON(atomic_read(&pds->pdcid_hash.nelems));
+	rhashtable_destroy(&pds->pdcid_hash);
+	uet_pds_pdc_gc_flush(pds);
+	cancel_work_sync(&pds->pdc_gc_work);
+	rcu_barrier();
+}
+
+void uet_pds_clean_job(struct uet_pds *pds, u32 job_id)
+{
+	struct rhashtable_iter iter;
+	struct uet_pdc *pdc;
+
+	rhashtable_walk_enter(&pds->pdcid_hash, &iter);
+	rhashtable_walk_start(&iter);
+	while ((pdc = rhashtable_walk_next(&iter))) {
+		if (pdc->key.job_id == job_id)
+			uet_pdc_destroy(pdc);
+	}
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+}
+
+int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
+	       __be32 remote_fep_addr, __be16 dport, __u8 tos)
+{
+	if (!pskb_may_pull(skb, sizeof(struct uet_prologue_hdr)))
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/include/net/ultraeth/uet_context.h b/include/net/ultraeth/uet_context.h
index 8210f69a1571..76077df3bce6 100644
--- a/include/net/ultraeth/uet_context.h
+++ b/include/net/ultraeth/uet_context.h
@@ -10,6 +10,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <net/ultraeth/uet_job.h>
+#include <net/ultraeth/uet_pds.h>
 
 struct uet_context {
 	int id;
@@ -19,6 +20,7 @@ struct uet_context {
 
 	struct net_device *netdev;
 	struct uet_job_registry job_reg;
+	struct uet_pds pds;
 };
 
 struct uet_context *uet_context_get_by_id(int id);
@@ -27,4 +29,16 @@ void uet_context_put(struct uet_context *ses_pl);
 int uet_context_create(int id);
 bool uet_context_destroy(int id);
 void uet_context_destroy_all(void);
+
+static inline struct uet_context *pds_context(const struct uet_pds *pds)
+{
+	return container_of(pds, struct uet_context, pds);
+}
+
+static inline struct net_device *pds_netdev(const struct uet_pds *pds)
+{
+	struct uet_context *ctx = pds_context(pds);
+
+	return ctx->netdev;
+}
 #endif /* _UET_CONTEXT_H */
diff --git a/include/net/ultraeth/uet_pdc.h b/include/net/ultraeth/uet_pdc.h
new file mode 100644
index 000000000000..70f3c6aa03df
--- /dev/null
+++ b/include/net/ultraeth/uet_pdc.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UECON_PDC_H
+#define _UECON_PDC_H
+
+#include <linux/rhashtable.h>
+#include <linux/rcupdate.h>
+#include <linux/spinlock.h>
+#include <linux/limits.h>
+#include <linux/refcount.h>
+#include <net/dst.h>
+#include <net/dst_metadata.h>
+
+#define UET_PDC_ID_MAX_ATTEMPTS 128
+#define UET_PDC_MAX_ID U16_MAX
+#define UET_PDC_MPR 128
+
+#define UET_SKB_CB(skb)       ((struct uet_skb_cb *)&((skb)->cb[0]))
+
+struct uet_skb_cb {
+	u32 psn;
+	__be32 remote_fep_addr;
+};
+
+enum {
+	UET_PDC_EP_STATE_CLOSED,
+	UET_PDC_EP_STATE_SYN_SENT,
+	UET_PDC_EP_STATE_NEW_ESTABLISHED,
+	UET_PDC_EP_STATE_ESTABLISHED,
+	UET_PDC_EP_STATE_QUIESCE,
+	UET_PDC_EP_STATE_ACK_WAIT,
+	UET_PDC_EP_STATE_CLOSE_ACK_WAIT
+};
+
+struct uet_pdc_key {
+	__be32 src_ip;
+	__be32 dst_ip;
+	u32 job_id;
+};
+
+enum {
+	UET_PDC_MODE_ROD,
+	UET_PDC_MODE_RUD,
+	UET_PDC_MODE_RUDI,
+	UET_PDC_MODE_UUD
+};
+
+struct uet_pdc {
+	struct rhash_head pdcid_node;
+	struct rhash_head pdcep_node;
+	struct uet_pdc_key key;
+	struct uet_pds *pds;
+
+	struct metadata_dst *metadata;
+
+	spinlock_t lock;
+	u32 psn_start;
+	u16 state;
+	u16 spdcid;
+	u16 dpdcid;
+	u16 pid_on_fep;
+	u8 tx_busy;
+	u8 mode;
+	bool is_initiator;
+
+	u32 rx_base_psn;
+	u32 tx_base_psn;
+
+	struct hlist_node gc_node;
+	struct rcu_head rcu;
+};
+
+struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
+			       u16 dpdcid, u16 pid_on_fep, u8 mode,
+			       u8 tos, __be16 dport,
+			       const struct uet_pdc_key *key, bool is_inbound);
+void uet_pdc_destroy(struct uet_pdc *pdc);
+void uet_pdc_free(struct uet_pdc *pdc);
+#endif /* _UECON_PDC_H */
diff --git a/include/net/ultraeth/uet_pds.h b/include/net/ultraeth/uet_pds.h
new file mode 100644
index 000000000000..43f5748a318a
--- /dev/null
+++ b/include/net/ultraeth/uet_pds.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UECON_PDS_H
+#define _UECON_PDS_H
+
+#include <linux/types.h>
+#include <linux/rhashtable.h>
+#include <uapi/linux/ultraeth.h>
+#include <linux/skbuff.h>
+
+/**
+ * struct uet_pds - Packet Delivery Sublayer state structure
+ *
+ * @pdcep_hash: a hash table mapping <dst ip, job id, pid on fep> to struct PDC
+ * @pdcid_hash: a hash table mapping PDC id to struct PDC
+ *
+ * @pdcep_hash is used in fast path to find the assigned PDC, @pdcid_hash
+ * is used when allocating a new PDC
+ */
+struct uet_pds {
+	struct rhashtable pdcep_hash;
+	struct rhashtable pdcid_hash;
+
+	spinlock_t gc_lock;
+	struct hlist_head pdc_gc_list;
+	struct work_struct pdc_gc_work;
+};
+
+struct uet_pdc *uet_pds_pdcep_insert(struct uet_pdc *pdc);
+void uet_pds_pdcep_remove(struct uet_pdc *pdc);
+
+int uet_pds_pdcid_insert(struct uet_pdc *pdc);
+void uet_pds_pdcid_remove(struct uet_pdc *pdc);
+
+int uet_pds_init(struct uet_pds *pds);
+void uet_pds_uninit(struct uet_pds *pds);
+
+void uet_pds_pdc_gc_queue(struct uet_pdc *pdc);
+void uet_pds_clean_job(struct uet_pds *pds, u32 job_id);
+
+int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
+	       __be32 remote_fep_addr, __be16 dport, __u8 tos);
+
+static inline struct uet_prologue_hdr *pds_prologue_hdr(const struct sk_buff *skb)
+{
+	return (struct uet_prologue_hdr *)skb_network_header(skb);
+}
+
+static inline struct uet_pds_req_hdr *pds_req_hdr(const struct sk_buff *skb)
+{
+	return (struct uet_pds_req_hdr *)skb_network_header(skb);
+}
+
+static inline struct uet_pds_ack_hdr *pds_ack_hdr(const struct sk_buff *skb)
+{
+	return (struct uet_pds_ack_hdr *)skb_network_header(skb);
+}
+
+static inline struct uet_pds_nack_hdr *pds_nack_hdr(const struct sk_buff *skb)
+{
+	return (struct uet_pds_nack_hdr *)skb_network_header(skb);
+}
+
+static inline struct uet_pds_ack_ext_hdr *pds_ack_ext_hdr(const struct sk_buff *skb)
+{
+	return (struct uet_pds_ack_ext_hdr *)(pds_ack_hdr(skb) + 1);
+}
+
+static inline struct uet_ses_rsp_hdr *pds_ack_ses_rsp_hdr(const struct sk_buff *skb)
+{
+	/* TODO: ack_ext_hdr, CC_STATE, etc. */
+	return (struct uet_ses_rsp_hdr *)(pds_ack_hdr(skb) + 1);
+}
+
+static inline struct uet_ses_req_hdr *pds_req_ses_req_hdr(const struct sk_buff *skb)
+{
+	/* TODO: ack_ext_hdr, CC_STATE, etc. */
+	return (struct uet_ses_req_hdr *)(pds_req_hdr(skb) + 1);
+}
+
+static inline __be16 pds_ses_rsp_hdr_pack(__u8 opcode, __u8 version, __u8 list,
+					  __u8 ses_rc)
+{
+	return cpu_to_be16((opcode & UET_SES_RSP_OPCODE_MASK) <<
+			   UET_SES_RSP_OPCODE_SHIFT |
+			   (version & UET_SES_RSP_VERSION_MASK) <<
+			   UET_SES_RSP_VERSION_SHIFT |
+			   (list & UET_SES_RSP_LIST_MASK) <<
+			   UET_SES_RSP_LIST_SHIFT |
+			   (ses_rc & UET_SES_RSP_RC_MASK) <<
+			   UET_SES_RSP_RC_SHIFT);
+}
+#endif /* _UECON_PDS_H */
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
index a4ac25455aa0..6f3ee5ac8cf4 100644
--- a/include/uapi/linux/ultraeth.h
+++ b/include/uapi/linux/ultraeth.h
@@ -9,6 +9,360 @@
 #define UET_DEFAULT_PORT 5432
 #define UET_SVC_MAX_LEN 64
 
+/* types used for prologue's type field */
+enum {
+	UET_PDS_TYPE_RSVD0,
+	UET_PDS_TYPE_ENC_HDR,
+	UET_PDS_TYPE_RUD_REQ,
+	UET_PDS_TYPE_ROD_REQ,
+	UET_PDS_TYPE_RUDI_REQ,
+	UET_PDS_TYPE_RUDI_RESPONSE,
+	UET_PDS_TYPE_UUD_REQ,
+	UET_PDS_TYPE_ACK,
+	UET_PDS_TYPE_ACK_CC,
+	UET_PDS_TYPE_ACK_CCX,
+	UET_PDS_TYPE_NACK,
+	UET_PDS_TYPE_CTRL_MSG
+};
+
+/* ctl_type when type is UET_PDS_CTRL_MSG (control message) */
+enum {
+	UET_CTL_TYPE_NOOP,
+	UET_CTL_TYPE_REQ_ACK,
+	UET_CTL_TYPE_CLEAR,
+	UET_CTL_TYPE_REQ_CLEAR,
+	UET_CTL_TYPE_CLOSE,
+	UET_CTL_TYPE_REQ_CLOSE,
+	UET_CTL_TYPE_PROBE,
+	UET_CTL_TYPE_CREDIT,
+	UET_CTL_TYPE_REQ_CREDIT
+};
+
+/* next header, 0x06-0x0E reserved */
+enum {
+	UET_PDS_NEXT_HDR_NONE		= 0x00,
+	UET_PDS_NEXT_HDR_REQ_SMALL	= 0x01,
+	UET_PDS_NEXT_HDR_REQ_MEDIUM	= 0x02,
+	UET_PDS_NEXT_HDR_REQ_STD	= 0x03,
+	UET_PDS_NEXT_HDR_RSP		= 0x04,
+	UET_PDS_NEXT_HDR_RSP_DATA	= 0x05,
+	UET_PDS_NEXT_HDR_RSP_DATA_SMALL	= 0x06,
+	UET_PDS_NEXT_HDR_PDS		= 0x0F,
+};
+
+/* fields(union): type_next_flags, type_ctl_flags  */
+#define UET_PROLOGUE_FLAGS_BITS 7
+#define UET_PROLOGUE_FLAGS_MASK 0x7f
+#define UET_PROLOGUE_NEXT_BITS 4
+#define UET_PROLOGUE_NEXT_MASK 0x0f
+#define UET_PROLOGUE_NEXT_SHIFT UET_PROLOGUE_FLAGS_BITS
+#define UET_PROLOGUE_CTL_BITS UET_PROLOGUE_NEXT_BITS
+#define UET_PROLOGUE_CTL_SHIFT UET_PROLOGUE_NEXT_SHIFT
+#define UET_PROLOGUE_CTL_MASK UET_PROLOGUE_NEXT_MASK
+#define UET_PROLOGUE_TYPE_BITS 5
+#define UET_PROLOGUE_TYPE_MASK 0x1f
+#define UET_PROLOGUE_TYPE_SHIFT (UET_PROLOGUE_NEXT_SHIFT + UET_PROLOGUE_NEXT_BITS)
+struct uet_prologue_hdr {
+	union {
+		__be16 type_next_flags;
+		__be16 type_ctl_flags;
+	};
+} __attribute__ ((__packed__));
+
+static inline __u8 uet_prologue_flags(const struct uet_prologue_hdr *hdr)
+{
+	return __be16_to_cpu(hdr->type_next_flags) & UET_PROLOGUE_FLAGS_MASK;
+}
+
+static inline __u8 uet_prologue_next_hdr(const struct uet_prologue_hdr *hdr)
+{
+	return (__be16_to_cpu(hdr->type_next_flags) >> UET_PROLOGUE_NEXT_SHIFT) &
+	       UET_PROLOGUE_NEXT_MASK;
+}
+
+static inline __u8 uet_prologue_ctl_type(const struct uet_prologue_hdr *hdr)
+{
+	return (__be16_to_cpu(hdr->type_ctl_flags) >> UET_PROLOGUE_CTL_SHIFT) &
+	       UET_PROLOGUE_CTL_MASK;
+}
+
+static inline __u8 uet_prologue_type(const struct uet_prologue_hdr *hdr)
+{
+	return (__be16_to_cpu(hdr->type_next_flags) >> UET_PROLOGUE_TYPE_SHIFT) &
+	       UET_PROLOGUE_TYPE_MASK;
+}
+
+/* rud/rod request flags */
+enum {
+	UET_PDS_REQ_FLAG_RSV2	= (1 << 0),
+	UET_PDS_REQ_FLAG_CC	= (1 << 1),
+	UET_PDS_REQ_FLAG_SYN	= (1 << 2),
+	UET_PDS_REQ_FLAG_AR	= (1 << 3),
+	UET_PDS_REQ_FLAG_RETX	= (1 << 4),
+	UET_PDS_REQ_FLAG_RSV	= (1 << 5),
+	UET_PDS_REQ_FLAG_CRC	= (1 << 6),
+};
+
+/* field: pdc_mode_psn_offset */
+#define UET_PDS_REQ_PSN_OFF_BITS 12
+#define UET_PDS_REQ_PSN_OFF_MASK 0xff1
+#define UET_PDS_REQ_MODE_BITS 4
+#define UET_PDS_REQ_MODE_MASK 0xf
+#define UET_PDS_REQ_MODE_SHIFT UET_PDS_REQ_PSN_OFF_BITS
+struct uet_pds_req_hdr {
+	struct uet_prologue_hdr prologue;
+	__be16 clear_psn_offset;
+	__be32 psn;
+	__be16 spdcid;
+	union {
+		__be16 pdc_mode_psn_offset;
+		__be16 dpdcid;
+	};
+} __attribute__ ((__packed__));
+
+static inline __u16 uet_pds_request_psn_offset(const struct uet_pds_req_hdr *req)
+{
+	return __be16_to_cpu(req->pdc_mode_psn_offset) & UET_PDS_REQ_PSN_OFF_MASK;
+}
+
+static inline __u8 uet_pds_request_pdc_mode(const struct uet_pds_req_hdr *req)
+{
+	return (__be16_to_cpu(req->pdc_mode_psn_offset) >> UET_PDS_REQ_MODE_SHIFT) &
+	       UET_PDS_REQ_MODE_MASK;
+}
+
+/* rud/rod ack flags */
+enum {
+	UET_PDS_ACK_FLAG_RSVD	= (1 << 0),
+	UET_PDS_ACK_FLAG_REQ1	= (1 << 1),
+	UET_PDS_ACK_FLAG_REQ2	= (1 << 2),
+	UET_PDS_ACK_FLAG_P	= (1 << 3),
+	UET_PDS_ACK_FLAG_RETX	= (1 << 4),
+	UET_PDS_ACK_FLAG_M	= (1 << 5),
+	UET_PDS_ACK_FLAG_CRC	= (1 << 6)
+};
+
+struct uet_pds_ack_hdr {
+	struct uet_prologue_hdr prologue;
+	__be16 ack_psn_offset;
+	__be32 cack_psn;
+	__be16 spdcid;
+	__be16 dpdcid;
+} __attribute__ ((__packed__));
+
+/* ses request op codes */
+enum {
+	UET_SES_REQ_OP_NOOP			= 0x00,
+	UET_SES_REQ_OP_WRITE			= 0x01,
+	UET_SES_REQ_OP_READ			= 0x02,
+	UET_SES_REQ_OP_ATOMIC			= 0x03,
+	UET_SES_REQ_OP_FETCHING_ATOMIC		= 0x04,
+	UET_SES_REQ_OP_SEND			= 0x05,
+	UET_SES_REQ_OP_RENDEZVOUS_SEND		= 0x06,
+	UET_SES_REQ_OP_DGRAM_SEND		= 0x07,
+	UET_SES_REQ_OP_DEFERRABLE_SEND		= 0x08,
+	UET_SES_REQ_OP_TAGGED_SEND		= 0x09,
+	UET_SES_REQ_OP_RENDEZVOUS_TSEND		= 0x0A,
+	UET_SES_REQ_OP_DEFERRABLE_TSEND		= 0x0B,
+	UET_SES_REQ_OP_DEFERRABLE_RTR		= 0x0C,
+	UET_SES_REQ_OP_TSEND_ATOMIC		= 0x0D,
+	UET_SES_REQ_OP_TSEND_FETCH_ATOMIC	= 0x0E,
+	UET_SES_REQ_OP_MSG_ERROR		= 0x0F,
+	UET_SES_REQ_OP_INC_PUSH			= 0x10,
+};
+
+enum {
+	UET_SES_REQ_FLAG_SOM		= (1 << 0),
+	UET_SES_REQ_FLAG_EOM		= (1 << 1),
+	UET_SES_REQ_FLAG_HD		= (1 << 2),
+	UET_SES_REQ_FLAG_RELATIVE	= (1 << 3),
+	UET_SES_REQ_FLAG_IE		= (1 << 4),
+	UET_SES_REQ_FLAG_DC		= (1 << 5)
+};
+
+/* field: resv_opcode */
+#define UET_SES_REQ_OPCODE_MASK 0x3f
+/* field: flags */
+#define UET_SES_REQ_FLAGS_MASK 0x3f
+#define UET_SES_REQ_FLAGS_VERSION_MASK 0x3
+#define UET_SES_REQ_FLAGS_VERSION_SHIFT 6
+/* field: resv_idx */
+#define UET_SES_REQ_INDEX_MASK 0xfff
+/* field: idx_gen_job_id */
+#define UET_SES_REQ_JOB_ID_BITS 24
+#define UET_SES_REQ_JOB_ID_MASK 0xffffff
+#define UET_SES_REQ_INDEX_GEN_MASK 0xff
+#define UET_SES_REQ_INDEX_GEN_SHIFT UET_SES_REQ_JOB_ID_BITS
+/* field: resv_pid_on_fep */
+#define UET_SES_REQ_PID_ON_FEP_MASK 0xfff
+struct uet_ses_req_hdr {
+	__u8 resv_opcode;
+	__u8 flags;
+	__be16 msg_id;
+	__be32 idx_gen_job_id;
+	__be16 resv_pid_on_fep;
+	__be16 resv_idx;
+	__be64 buffer_offset;
+	__be32 initiator;
+	__be64 match_bits;
+	__be64 header_data;
+	__be32 request_len;
+} __attribute__ ((__packed__));
+
+static inline __u8 uet_ses_req_opcode(const struct uet_ses_req_hdr *sreq)
+{
+	return sreq->resv_opcode & UET_SES_REQ_OPCODE_MASK;
+}
+
+static inline __u8 uet_ses_req_flags(const struct uet_ses_req_hdr *sreq)
+{
+	return sreq->flags & UET_SES_REQ_FLAGS_MASK;
+}
+
+static inline __u8 uet_ses_req_version(const struct uet_ses_req_hdr *sreq)
+{
+	return (sreq->flags >> UET_SES_REQ_FLAGS_VERSION_SHIFT) &
+	       UET_SES_REQ_FLAGS_VERSION_MASK;
+}
+
+static inline __u16 uet_ses_req_index(const struct uet_ses_req_hdr *sreq)
+{
+	return __be16_to_cpu(sreq->resv_idx) & UET_SES_REQ_INDEX_MASK;
+}
+
+static inline __u32 uet_ses_req_job_id(const struct uet_ses_req_hdr *sreq)
+{
+	return __be32_to_cpu(sreq->idx_gen_job_id) & UET_SES_REQ_JOB_ID_MASK;
+}
+
+static inline __u8 uet_ses_req_index_gen(const struct uet_ses_req_hdr *sreq)
+{
+	return (__be32_to_cpu(sreq->idx_gen_job_id) >> UET_SES_REQ_INDEX_GEN_SHIFT) &
+	       UET_SES_REQ_INDEX_GEN_MASK;
+}
+
+static inline __u16 uet_ses_req_pid_on_fep(const struct uet_ses_req_hdr *sreq)
+{
+	return __be16_to_cpu(sreq->resv_pid_on_fep) & UET_SES_REQ_PID_ON_FEP_MASK;
+}
+
+/* return codes */
+enum {
+	UET_SES_RSP_RC_NULL		= 0x00,
+	UET_SES_RSP_RC_OK		= 0x01,
+	UET_SES_RSP_RC_BAD_GEN		= 0x02,
+	UET_SES_RSP_RC_DISABLED		= 0x03,
+	UET_SES_RSP_RC_DISABLED_GEN	= 0x04,
+	UET_SES_RSP_RC_NO_MATCH		= 0x05,
+	UET_SES_RSP_RC_UNSUPP_OP	= 0x06,
+	UET_SES_RSP_RC_UNSUPP_SIZE	= 0x07,
+	UET_SES_RSP_RC_AT_INVALID	= 0x08,
+	UET_SES_RSP_RC_AT_PERM		= 0x09,
+	UET_SES_RSP_RC_AT_ATS_ERROR	= 0x0A,
+	UET_SES_RSP_RC_AT_NO_TRANS	= 0x0B,
+	UET_SES_RSP_RC_AT_OUT_OF_RANGE	= 0x0C,
+	UET_SES_RSP_RC_HOST_POISONED	= 0x0D,
+	UET_SES_RSP_RC_HOST_UNSUCC_CMPL	= 0x0E,
+	UET_SES_RSP_RC_AMO_UNSUPP_OP	= 0x0F,
+	UET_SES_RSP_RC_AMO_UNSUPP_DT	= 0x10,
+	UET_SES_RSP_RC_AMO_UNSUPP_SIZE	= 0x11,
+	UET_SES_RSP_RC_AMO_UNALIGNED	= 0x12,
+	UET_SES_RSP_RC_AMO_FP_NAN	= 0x13,
+	UET_SES_RSP_RC_AMO_FP_UNDERFLOW	= 0x14,
+	UET_SES_RSP_RC_AMO_FP_OVERFLOW	= 0x15,
+	UET_SES_RSP_RC_AMO_FP_INEXACT	= 0x16,
+	UET_SES_RSP_RC_PERM_VIOLATION	= 0x17,
+	UET_SES_RSP_RC_OP_VIOLATION	= 0x18,
+	UET_SES_RSP_RC_BAD_INDEX	= 0x19,
+	UET_SES_RSP_RC_BAD_PID		= 0x1A,
+	UET_SES_RSP_RC_BAD_JOB_ID	= 0x1B,
+	UET_SES_RSP_RC_BAD_MKEY		= 0x1C,
+	UET_SES_RSP_RC_BAD_ADDR		= 0x1D,
+	UET_SES_RSP_RC_CANCELLED	= 0x1E,
+	UET_SES_RSP_RC_UNDELIVERABLE	= 0x1F,
+	UET_SES_RSP_RC_UNCOR		= 0x20,
+	UET_SES_RSP_RC_UNCOR_TRNSNT	= 0x21,
+	UET_SES_RSP_RC_TOO_LONG		= 0x22,
+	UET_SES_RSP_RC_INITIATOR_ERR	= 0x23,
+	UET_SES_RSP_RC_DROPPED		= 0x24,
+};
+
+/* ses response list values */
+enum {
+	UET_SES_RSP_LIST_EXPECTED	= 0x00,
+	UET_SES_RSP_LIST_OVERFLOW	= 0x01
+};
+
+/* ses response op codes */
+enum {
+	UET_SES_RSP_OP_DEF_RESP		= 0x00,
+	UET_SES_RSP_OP_RESPONSE		= 0x01,
+	UET_SES_RSP_OP_RESP_W_DATA	= 0x02
+};
+
+/* field: lst_opcode_ver_rc */
+#define UET_SES_RSP_RC_BITS 6
+#define UET_SES_RSP_RC_MASK 0x3f
+#define UET_SES_RSP_RC_SHIFT 0
+#define UET_SES_RSP_VERSION_BITS 2
+#define UET_SES_RSP_VERSION_MASK 0x3
+#define UET_SES_RSP_VERSION_SHIFT (UET_SES_RSP_RC_SHIFT + \
+				   UET_SES_RSP_RC_BITS)
+#define UET_SES_RSP_OPCODE_BITS 6
+#define UET_SES_RSP_OPCODE_MASK 0x3f
+#define UET_SES_RSP_OPCODE_SHIFT (UET_SES_RSP_VERSION_SHIFT + \
+				  UET_SES_RSP_VERSION_BITS)
+#define UET_SES_RSP_LIST_BITS 2
+#define UET_SES_RSP_LIST_MASK 0x3
+#define UET_SES_RSP_LIST_SHIFT (UET_SES_RSP_OPCODE_SHIFT + \
+				UET_SES_RSP_OPCODE_BITS)
+/* field: idx_gen_job_id */
+#define UET_SES_RSP_JOB_ID_BITS 24
+#define UET_SES_RSP_JOB_ID_MASK 0xffffff
+#define UET_SES_RSP_INDEX_GEN_MASK 0xff
+#define UET_SES_RSP_INDEX_GEN_SHIFT UET_SES_RSP_JOB_ID_BITS
+struct uet_ses_rsp_hdr {
+	__be16 lst_opcode_ver_rc;
+	__be16 msg_id;
+	__be32 idx_gen_job_id;
+	__be32 mod_len;
+} __attribute__ ((__packed__));
+
+static inline __u8 uet_ses_rsp_rc(const struct uet_ses_rsp_hdr *rsp)
+{
+	return (__be32_to_cpu(rsp->lst_opcode_ver_rc) >>
+		UET_SES_RSP_RC_SHIFT) & UET_SES_RSP_RC_MASK;
+}
+
+static inline __u8 uet_ses_rsp_list(const struct uet_ses_rsp_hdr *rsp)
+{
+	return (__be32_to_cpu(rsp->lst_opcode_ver_rc) >>
+		UET_SES_RSP_LIST_SHIFT) & UET_SES_RSP_LIST_MASK;
+}
+
+static inline __u8 uet_ses_rsp_version(const struct uet_ses_rsp_hdr *rsp)
+{
+	return (__be32_to_cpu(rsp->lst_opcode_ver_rc) >>
+		UET_SES_RSP_VERSION_SHIFT) & UET_SES_RSP_VERSION_MASK;
+}
+
+static inline __u8 uet_ses_rsp_opcode(const struct uet_ses_rsp_hdr *rsp)
+{
+	return (__be32_to_cpu(rsp->lst_opcode_ver_rc) >>
+		UET_SES_RSP_OPCODE_SHIFT) & UET_SES_RSP_OPCODE_MASK;
+}
+
+static inline __u32 uet_ses_rsp_job_id(const struct uet_ses_rsp_hdr *rsp)
+{
+	return __be32_to_cpu(rsp->idx_gen_job_id) & UET_SES_RSP_JOB_ID_MASK;
+}
+
+static inline __u8 uet_ses_rsp_index_gen(const struct uet_ses_req_hdr *rsp)
+{
+	return (__be32_to_cpu(rsp->idx_gen_job_id) >> UET_SES_RSP_INDEX_GEN_SHIFT) &
+	       UET_SES_RSP_INDEX_GEN_MASK;
+}
+
 enum {
 	UET_ADDR_F_VALID_FEP_CAP	= (1 << 0),
 	UET_ADDR_F_VALID_ADDR		= (1 << 1),
-- 
2.48.1


