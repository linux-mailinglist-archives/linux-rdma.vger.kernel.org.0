Return-Path: <linux-rdma+bounces-8454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A60AA55AA0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CDD3B2C0E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F2280A4C;
	Thu,  6 Mar 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="hUCnDA17"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C8280A4D
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302265; cv=none; b=TwVmuBqAEMj6lzI5oKY05BtQ8Zx4nnQvXa+Q5+3tak5S7jJEyNeLIE+95C6UhL7y4Oq5OYFgjOqO5CLdzqD92zkX+EzXIboOE121MQK0jd0vURQZ1iKeRVSISfe8s8G03jfunkkLOwm2YCqNjy9PVqRfyE4+wYg5Db5rl31+yOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302265; c=relaxed/simple;
	bh=VlTJWrfskKiMJ0jPrrZCGioBK+EUcD/4Mq939WrXGtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZQINMND1iUs5xl/YvNWFLwGIz3vavpCPoze0ecujCydD9kbLWw8os+3PWzJB/7tc5DE/UjappxeO0pXE68+3P/3oK7bYa1W1Va/spr1+sO3qYpAFscLFwASaUrP1baOdKGA9eYAj1cAYp2ogIp7iEzqRc/PEGG3E3zE0YP64+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=hUCnDA17; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso9621396d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302262; x=1741907062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TFGwcWhVCnTXz5ntSIwjluyAOC28ms1ec0UlWPS2kE=;
        b=hUCnDA17oM+nxjRjNYefTc9kU+HxAiw7SVXD3V045UwHPZ4pl8RzZxhhpoBIbE2ajX
         aBBMm15OPKLqFpthyRGO7YBrhXmayKPl2fTSKAGLVvO/AeLLqMu06nqO2tyzg2LcCEYp
         QsHW6/nKBj5mUWut8xTSU09Y+Zpuxl13/tVPQDsETHn8ifrCXxIlAE6uaVHi55GUVpQn
         t11gQQZRix+6bVmOjJd6yZRsyz7DVSUO1/Thb5147Q4ECST/Tol3QlMFsKNtgXPf27KR
         7gMv8vPu5CyLvhDP7lXblUcnU3OY0ZmbWpgI1NsC45e+HqAn42owOnO6+EClJqQxhzlB
         3GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302262; x=1741907062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TFGwcWhVCnTXz5ntSIwjluyAOC28ms1ec0UlWPS2kE=;
        b=WkuYlmrfT9/vOeIO5N6/Fdhu7TWEI/JIDTgGD4ChiActckgp0w+OaRKkDSQ90aVG2z
         jsKbkdhRIEJLKBHgY4rRdAuBM27x4nLmS6Gkjt2yUK+XGwIfujae/eUa1Z9WPyrU8jwf
         gxgNx/pL/kp0e2kzgMpUVwlRMkkERGI4oNjV1seFLADcsaf18BfQ0LzlPzsDmPH1LQyb
         tmBMxo7LSdRLL2I0VZP7jGw0j+4lsUZcHVRxaz067CpYe9Itq5v6NEyxhE3e2Zzh5csG
         U+UvsS+F/fcMzXzlxYiMNqEx0DDfk6OPfdG4vyzEvo/rcLLPAWQuzuJQ9P0Z4tsHsuvg
         /oQw==
X-Forwarded-Encrypted: i=1; AJvYcCWuiR/G7HS9Y3KvnqAaBwxClriFdyqhBD5/4/QwCjmbreZ0eIheKNovnvrIyQNLHQCtid+WU8bxv/z7@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvLLTjQfquSVTz6oTzb3u1V6bw6PaJingEc6yT1cqrJARGIbg
	UZL7rwW3TLzh0dls08CI17j+MNj9nbzUJAAFiIWk2IKvbzuuBQUZNPAdklkt+pdAWUC3MhqQkdN
	n
X-Gm-Gg: ASbGncsMzAHGKhp5pmS8nlCNqnvJBoDeBbtKAwDA2IkuDLolJ8qie13rL10PFPaQr0J
	kI/ohel40AIAxoEshztyUoV2hXTNkNKWD4kl8nFqG+dlDXL+aCi2bDZkbBWGu66rYX4YujksDK6
	hEKWxN5RoJD9yEAyAIzQRQlXVsVLD6amHeNZZKh8G3U+PRzNFrkXct2REoSTLLtEjGsYgkssJNw
	I2BgeBES6/C45pC+8v45kDehg1LyN+AYqP+nFizKYTfFi8WKOvsiqsgmUfkI94U0QwLjWFwSzZa
	avZ5DjpK1mHH/R/RdQ2zY5r6/6+bcI2ZP1lCKWNQHPB5Te2fs4p8qeZ0d7eeW3IYG5CW
X-Google-Smtp-Source: AGHT+IGl6OtlqTz58lYmGOcKPuPseJIz0NnomobhDiNmx6hs+qVTfcOzr6tA/falt0FtKrpp3jjUmQ==
X-Received: by 2002:a05:6214:326:b0:6e8:fee2:aae4 with SMTP id 6a1803df08f44-6e9006ad479mr12029116d6.28.1741302262036;
        Thu, 06 Mar 2025 15:04:22 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:21 -0800 (PST)
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
Subject: [RFC PATCH 13/13] HACK: drivers: ultraeth: add char device
Date: Fri,  7 Mar 2025 01:02:03 +0200
Message-ID: <20250306230203.1550314-14-nikolay@enfabrica.net>
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

From: Alex Badea <alex.badea@keysight.com>

Add a character device so we can send and receive packets from
user-space. It also implements a private ioctl for associating with a job.
This patch is just a quick hack to allow using the Ultra Ethernet
software device from user-space until proper user<->kernel APIs are
defined.

Signed-off-by: Alex Badea <alex.badea@keysight.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
---
 Documentation/netlink/specs/ultraeth.yaml |   9 +
 drivers/ultraeth/Makefile                 |   2 +-
 drivers/ultraeth/uet_chardev.c            | 264 ++++++++++++++++++++++
 drivers/ultraeth/uet_context.c            |  31 ++-
 include/net/ultraeth/uet_chardev.h        |  11 +
 include/net/ultraeth/uet_context.h        |   3 +
 include/uapi/linux/ultraeth.h             |  21 ++
 include/uapi/linux/ultraeth_nl.h          |   3 +
 8 files changed, 342 insertions(+), 2 deletions(-)
 create mode 100644 drivers/ultraeth/uet_chardev.c
 create mode 100644 include/net/ultraeth/uet_chardev.h

diff --git a/Documentation/netlink/specs/ultraeth.yaml b/Documentation/netlink/specs/ultraeth.yaml
index 847f748efa52..3dc10e52131e 100644
--- a/Documentation/netlink/specs/ultraeth.yaml
+++ b/Documentation/netlink/specs/ultraeth.yaml
@@ -22,6 +22,15 @@ attribute-sets:
       -
         name: netdev-name
         type: string
+      -
+        name: chardev-name
+        type: string
+      -
+        name: chardev-major
+        type: s32
+      -
+        name: chardev-minor
+        type: s32
   -
     name: contexts
     attributes:
diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
index f2d6a8569dbf..bee8e7aa00bb 100644
--- a/drivers/ultraeth/Makefile
+++ b/drivers/ultraeth/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_ULTRAETH) += ultraeth.o
 
 ultraeth-objs := uet_main.o uet_context.o uet_netlink.o uet_job.o \
-			uecon.o uet_pdc.o uet_pds.o
+			uecon.o uet_pdc.o uet_pds.o uet_chardev.o
diff --git a/drivers/ultraeth/uet_chardev.c b/drivers/ultraeth/uet_chardev.c
new file mode 100644
index 000000000000..f02f2c1e1afd
--- /dev/null
+++ b/drivers/ultraeth/uet_chardev.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/netdevice.h>
+
+#include <rdma/ib_umem.h>
+
+#include <uapi/linux/ultraeth.h>
+#include <net/ultraeth/uet_context.h>
+#include <net/ultraeth/uet_chardev.h>
+
+#define MAX_PDS_HDRLEN	64	/* -ish? */
+
+static int uet_char_open(struct inode *inode, struct file *file)
+{
+	struct uet_context *ctx;
+	struct uet_fep *fep;
+	int rv;
+
+	ctx = uet_context_get_by_minor(iminor(inode));
+	if (!ctx)
+		return -ENOENT;
+
+	fep = kzalloc(sizeof(*fep), GFP_KERNEL);
+	if (!fep) {
+		rv = -ENOMEM;
+		goto err_alloc;
+	}
+
+	fep->context = ctx;
+	fep->ack_gen_min_pkt_add = UET_DEFAULT_ACK_GEN_MIN_PKT_ADD;
+	fep->ack_gen_trigger = UET_DEFAULT_ACK_GEN_TRIGGER;
+	skb_queue_head_init(&fep->rxq);
+	file->private_data = fep;
+	rv = nonseekable_open(inode, file);
+	if (rv < 0)
+		goto err_open;
+
+	return rv;
+
+err_open:
+	kfree(fep);
+err_alloc:
+	uet_context_put(ctx);
+
+	return rv;
+}
+
+static int uet_char_release(struct inode *inode, struct file *file)
+{
+	struct uet_fep *fep = file->private_data;
+
+	uet_job_reg_disassociate(&fep->context->job_reg, fep->job_id);
+	skb_queue_purge(&fep->rxq);
+	uet_context_put(fep->context);
+	kfree(fep);
+
+	return 0;
+}
+
+static long uet_char_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct uet_fep *fep = file->private_data;
+	void __user *p = (void __user *)arg;
+	int ret = 0;
+
+	switch (cmd) {
+	case UET_ADDR_REQ: {
+		struct uet_job_addr_req areq;
+
+		if (copy_from_user(&areq, p, sizeof(areq)))
+			return -EFAULT;
+		// XXX: validate address
+
+		areq.service_name[UET_SVC_MAX_LEN - 1] = '\0';
+		memcpy(&fep->addr.in_address, &areq.address,
+		       sizeof(fep->addr.in_address));
+
+		ret = uet_job_reg_associate(&fep->context->job_reg, fep,
+					    areq.service_name);
+		if (!ret) {
+			if (areq.ack_gen_trigger > 0)
+				fep->ack_gen_trigger = areq.ack_gen_trigger;
+			if (areq.ack_gen_min_pkt_add > 0)
+				fep->ack_gen_min_pkt_add = areq.ack_gen_min_pkt_add;
+		}
+		break;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static ssize_t uet_char_read(struct file *file, char __user *ubuf,
+			       size_t usize, loff_t *off)
+{
+	struct uet_fep *fep = file->private_data;
+	struct uet_prologue_hdr *prologue;
+	struct uet_pds_meta meta = {};
+	struct sk_buff *skb = NULL;
+	int ret = -ENOTCONN;
+	int hdrlen = 0;
+	size_t userlen;
+
+	pr_debug("%s file=%p fep=%p size=%zu\n", __func__, file, fep, usize);
+
+	ret = -EAGAIN;
+	skb = skb_dequeue(&fep->rxq);
+	if (!skb)
+		goto out_err;
+
+	ret = skb_linearize(skb);
+	if (ret)
+		goto out_err;
+
+	prologue = pds_prologue_hdr(skb);
+	meta.next_hdr = uet_prologue_next_hdr(prologue);
+	meta.addr = UET_SKB_CB(skb)->remote_fep_addr;
+	switch (meta.next_hdr) {
+	case UET_PDS_NEXT_HDR_RSP_DATA:
+	case UET_PDS_NEXT_HDR_RSP_DATA_SMALL:
+		/* TODO */
+		ret = -EOPNOTSUPP;
+		goto out_err;
+	case UET_PDS_NEXT_HDR_RSP:
+		hdrlen = sizeof(struct uet_pds_ack_hdr);
+		break;
+	default:
+		hdrlen = sizeof(struct uet_pds_req_hdr);
+		break;
+	}
+	userlen = sizeof(meta) + skb->len - hdrlen;
+	if (userlen > usize) {
+		ret = -EMSGSIZE;
+		goto out_err;
+	}
+
+	if (copy_to_user(ubuf, &meta, sizeof(meta))) {
+		ret = -EFAULT;
+		goto out_err;
+	}
+	if (copy_to_user(ubuf + sizeof(meta), skb->data + hdrlen, skb->len - hdrlen)) {
+		ret = -EFAULT;
+		goto out_err;
+	}
+
+	consume_skb(skb);
+	ret = userlen;
+
+	return ret;
+
+out_err:
+	kfree_skb(skb);
+
+	return ret;
+}
+
+static ssize_t uet_char_write(struct file *file, const char __user *ubuf,
+			      size_t usize, loff_t *off)
+{
+	struct uet_fep *fep = file->private_data;
+	struct sk_buff *skb = NULL;
+	struct uet_pds_meta *meta;
+	struct uet_job *job;
+	__be32 daddr, saddr;
+	int ret = -ENODEV;
+	__be16 dport;
+	void *buf;
+
+	pr_debug("%s file=%p fep=%p size=%zu\n", __func__, file, fep, usize);
+
+	rcu_read_lock();
+	job = uet_job_find(&fep->context->job_reg, fep->job_id);
+	if (!job)
+		goto out_err;
+
+	ret = -ENOMEM;
+	skb = alloc_skb(MAX_HEADER + MAX_PDS_HDRLEN + usize, GFP_ATOMIC);
+	if (!skb)
+		goto out_err;
+	skb_reserve(skb, MAX_HEADER + MAX_PDS_HDRLEN);
+	buf = skb_put(skb, usize);
+	ret = -EFAULT;
+	if (copy_from_user(buf, ubuf, usize))
+		goto out_err;
+
+	print_hex_dump_bytes("pds tx ", DUMP_PREFIX_OFFSET, skb->data, skb->len);
+
+	meta = skb_pull_data(skb, sizeof(*meta));
+	if (!meta) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+	/* TODO: IPv6 */
+	/* TODO: per-packet daddr */
+	saddr = fep->addr.in_address.ip;
+	daddr = meta->addr;
+	dport = meta->port;
+
+	switch (meta->next_hdr) {
+	case UET_PDS_NEXT_HDR_RSP_DATA:
+	case UET_PDS_NEXT_HDR_RSP_DATA_SMALL:
+		ret = -EOPNOTSUPP; /* TODO */
+		goto out_err;
+	case UET_PDS_NEXT_HDR_RSP:
+		ret = 0; /* FIXME: ACK PSN would be wrong */
+		break;
+	default:
+		ret = uet_pds_tx(&fep->context->pds, skb, saddr, daddr, dport,
+				 job->id);
+		break;
+	}
+
+	if (ret < 0)
+		goto out_err;
+	rcu_read_unlock();
+
+	return usize;
+
+out_err:
+	rcu_read_unlock();
+	kfree_skb(skb);
+
+	return ret;
+}
+
+static const struct file_operations uet_char_ops = {
+	.owner		= THIS_MODULE,
+	.open		= uet_char_open,
+	.release	= uet_char_release,
+	.read		= uet_char_read,
+	.write		= uet_char_write,
+	.unlocked_ioctl	= uet_char_ioctl,
+};
+
+#define UET_CHAR_MAX_NAME 20
+
+int uet_char_init(struct miscdevice *cdev, int id)
+{
+	int ret = -ENOMEM;
+
+	cdev->minor = MISC_DYNAMIC_MINOR;
+	cdev->name = kzalloc(UET_CHAR_MAX_NAME, GFP_KERNEL);
+	if (!cdev->name)
+		return ret;
+	snprintf((char *)cdev->name, UET_CHAR_MAX_NAME, "ultraeth%d", id);
+	cdev->fops = &uet_char_ops;
+
+	ret = misc_register(cdev);
+	if (ret)
+		kfree(cdev->name);
+
+	return ret;
+}
+
+void uet_char_uninit(struct miscdevice *cdev)
+{
+	kfree(cdev->name);
+	misc_deregister(cdev);
+}
diff --git a/drivers/ultraeth/uet_context.c b/drivers/ultraeth/uet_context.c
index 6bdd72344e01..7bddc810503b 100644
--- a/drivers/ultraeth/uet_context.c
+++ b/drivers/ultraeth/uet_context.c
@@ -2,6 +2,7 @@
 
 #include <net/ultraeth/uet_context.h>
 #include <net/ultraeth/uecon.h>
+#include <net/ultraeth/uet_chardev.h>
 #include "uet_netlink.h"
 
 #define MAX_CONTEXT_ID 256
@@ -78,6 +79,24 @@ struct uet_context *uet_context_get_by_id(int id)
 	return ctx;
 }
 
+struct uet_context *uet_context_get_by_minor(int minor)
+{
+	struct uet_context *ctx;
+
+	mutex_lock(&uet_context_lock);
+	list_for_each_entry(ctx, &uet_context_list, list) {
+		if (ctx->cdev.minor == minor) {
+			refcount_inc(&ctx->refcnt);
+			goto out;
+		}
+	}
+	ctx = NULL;
+out:
+	mutex_unlock(&uet_context_lock);
+
+	return ctx;
+}
+
 void uet_context_put(struct uet_context *ctx)
 {
 	if (refcount_dec_and_test(&ctx->refcnt))
@@ -111,6 +130,10 @@ int uet_context_create(int id)
 	if (err)
 		goto ctx_pds_err;
 
+	err = uet_char_init(&ctx->cdev, ctx->id);
+	if (err)
+		goto ctx_char_err;
+
 	err = uecon_netdev_init(ctx);
 	if (err)
 		goto ctx_netdev_err;
@@ -120,6 +143,8 @@ int uet_context_create(int id)
 	return 0;
 
 ctx_netdev_err:
+	uet_char_uninit(&ctx->cdev);
+ctx_char_err:
 	uet_pds_uninit(&ctx->pds);
 ctx_pds_err:
 	uet_jobs_uninit(&ctx->job_reg);
@@ -135,6 +160,7 @@ static void __uet_context_destroy(struct uet_context *ctx)
 {
 	uet_context_unlink(ctx);
 	uecon_netdev_uninit(ctx);
+	uet_char_uninit(&ctx->cdev);
 	uet_pds_uninit(&ctx->pds);
 	uet_jobs_uninit(&ctx->job_reg);
 	uet_context_put_id(ctx);
@@ -183,7 +209,10 @@ static int __nl_ctx_fill_one(struct sk_buff *skb,
 
 	if (nla_put_s32(skb, ULTRAETH_A_CONTEXT_ID, ctx->id) ||
 	    nla_put_s32(skb, ULTRAETH_A_CONTEXT_NETDEV_IFINDEX, ctx->netdev->ifindex) ||
-	    nla_put_string(skb, ULTRAETH_A_CONTEXT_NETDEV_NAME, ctx->netdev->name))
+	    nla_put_string(skb, ULTRAETH_A_CONTEXT_NETDEV_NAME, ctx->netdev->name) ||
+	    nla_put_string(skb, ULTRAETH_A_CONTEXT_CHARDEV_NAME, ctx->cdev.name) ||
+	    nla_put_s32(skb, ULTRAETH_A_CONTEXT_CHARDEV_MAJOR, MISC_MAJOR) ||
+	    nla_put_s32(skb, ULTRAETH_A_CONTEXT_CHARDEV_MINOR, ctx->cdev.minor))
 		goto out_err;
 
 	genlmsg_end(skb, hdr);
diff --git a/include/net/ultraeth/uet_chardev.h b/include/net/ultraeth/uet_chardev.h
new file mode 100644
index 000000000000..963b3e247630
--- /dev/null
+++ b/include/net/ultraeth/uet_chardev.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UECON_CHARDEV_H
+#define _UECON_CHAR_H
+
+#include <linux/miscdevice.h>
+
+int uet_char_init(struct miscdevice *cdev, int id);
+void uet_char_uninit(struct miscdevice *cdev);
+
+#endif /* _UECON_CHARDEV_H */
diff --git a/include/net/ultraeth/uet_context.h b/include/net/ultraeth/uet_context.h
index 76077df3bce6..06a5c7f252ac 100644
--- a/include/net/ultraeth/uet_context.h
+++ b/include/net/ultraeth/uet_context.h
@@ -11,6 +11,7 @@
 #include <linux/wait.h>
 #include <net/ultraeth/uet_job.h>
 #include <net/ultraeth/uet_pds.h>
+#include <linux/miscdevice.h>
 
 struct uet_context {
 	int id;
@@ -21,9 +22,11 @@ struct uet_context {
 	struct net_device *netdev;
 	struct uet_job_registry job_reg;
 	struct uet_pds pds;
+	struct miscdevice cdev;
 };
 
 struct uet_context *uet_context_get_by_id(int id);
+struct uet_context *uet_context_get_by_minor(int minor);
 void uet_context_put(struct uet_context *ses_pl);
 
 int uet_context_create(int id);
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
index c1d5457073e1..2843bb710f1e 100644
--- a/include/uapi/linux/ultraeth.h
+++ b/include/uapi/linux/ultraeth.h
@@ -512,4 +512,25 @@ struct fep_address {
 	__u16 padding;
 	__u8 version;
 };
+
+/* char device hacks */
+#define UET_IOCTL_MAGIC	'u'
+#define UET_ADDR_REQ		_IO(UET_IOCTL_MAGIC, 1)
+
+struct uet_job_addr_req {
+	struct fep_in_address address;
+	char service_name[UET_SVC_MAX_LEN];
+	__u32 ack_gen_trigger;
+	__u32 ack_gen_min_pkt_add;
+	__u8 flags;
+};
+
+struct uet_pds_meta {
+	__u8 next_hdr:4;
+	__u8 reserved1:4;
+	__u8 reserved2;
+	__be16 port;
+	/* XXX: fep_address */
+	__be32 addr;
+} __attribute__((packed));
 #endif /* _UAPI_LINUX_ULTRAETH_H */
diff --git a/include/uapi/linux/ultraeth_nl.h b/include/uapi/linux/ultraeth_nl.h
index 515044022906..884fa165adb6 100644
--- a/include/uapi/linux/ultraeth_nl.h
+++ b/include/uapi/linux/ultraeth_nl.h
@@ -13,6 +13,9 @@ enum {
 	ULTRAETH_A_CONTEXT_ID = 1,
 	ULTRAETH_A_CONTEXT_NETDEV_IFINDEX,
 	ULTRAETH_A_CONTEXT_NETDEV_NAME,
+	ULTRAETH_A_CONTEXT_CHARDEV_NAME,
+	ULTRAETH_A_CONTEXT_CHARDEV_MAJOR,
+	ULTRAETH_A_CONTEXT_CHARDEV_MINOR,
 
 	__ULTRAETH_A_CONTEXT_MAX,
 	ULTRAETH_A_CONTEXT_MAX = (__ULTRAETH_A_CONTEXT_MAX - 1)
-- 
2.48.1


