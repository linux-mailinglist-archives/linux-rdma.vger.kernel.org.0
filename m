Return-Path: <linux-rdma+bounces-16059-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCClGLOIeGmqqwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16059-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:43:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A7791E98
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 10:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1AC03078408
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811EF2E11A6;
	Tue, 27 Jan 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ebSffr6A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C732C0F7A
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506728; cv=none; b=uGjRNnEZYmpUHD1kMWxUrWvxpRIQjxfjVcbMSu8vmB+u/NLGCyPRFCVlFIBOBqAk2GSlq3UCfff2fy89EU8wq56gJDIQBoXa8mROwJGM3X1TDoIJcFvodKRAMAAwrVhs8bM074I+YtHihs3LhQe4ynAQmuz+HY6421IJugfbxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506728; c=relaxed/simple;
	bh=AgtTYhhvJyKGOLVu7q/IH2S8UKytT6MP/K47rLshEb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gUGKLtXptVXzUc6N1lfvlhdhjpiJ3bMGKRBZKJXXOV1+6QEo5QacgottkKzuzZlIyq98gIj6Kpty2Rofm8WicENquy/uQJc7Pb+X67jD+nujM8/snU0/QLk9A03seDcNb8Wykw3vC/vMrzwde02RWzkSevRlINoWnAZ9AOO5JQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ebSffr6A; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359a302794so3371026f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 01:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769506721; x=1770111521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDDdsa/Lk3z+U0PNa0N1wk0lw7dL2b2l/PaayLWCqBc=;
        b=ebSffr6AxCyzGdZaebL8hMcEzTkWKgP6K/9YVteT6VC1DSF1ByIMQMj6W+at8Eg0Dt
         0s7210dWaWcyt7Fc1SNJkLfVHRxgTdlQWSdA/Q9Ou+g/SoHVcmJBAR6jMfEHYXNSR9mW
         KosrCYjbv0tvDSjlZM2ct2nNUYP5YY/rpGbZ+imHZpYW2Wpo3LAxp0dHz4a0glOpCnyn
         /Q5Cpv2HeeX50murPTMqVvdvno7a2x1XV3UQlWJlUrFeyVYBiP6U5D21ba7bNwZfIVKf
         VD0b4Cx+H+z/rIPy8vg29B7zxopun4HGdrALZpvjLA6uNwOQKk77hE3CnLBeb0Q2bnGF
         y6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769506721; x=1770111521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDDdsa/Lk3z+U0PNa0N1wk0lw7dL2b2l/PaayLWCqBc=;
        b=S1jEW+r3ZjkJ+PjXnA5SD2kNBXmKehUSUloONtWWQnEsTCYSV2csl0f+tPxfZFD7pK
         QqogzOIjCOWRKqN7r+HvttxdkUUWk4TxL3bnckDdFuXd0OCVq8e/FhQgPLmv5z5KtE3d
         1z2vp0pjZTOnFz69zypCiR4Zyj/vVDfHm6AElAZullwl6aruaDgpDsKxbaCMkfn7Gljw
         gy2t+XMKunmGAENkyjp8HQKJDF2Uv5JkdOCh7nbjXEs4DPlx8mntlLGQ7Rx0E+U77CeS
         cTyPs0u4vXtcps9O29D3+XpNf0OF3KuILLzkiF/PtdsoxgsW2F38Gxtz772AVjV8O1q0
         /o6g==
X-Gm-Message-State: AOJu0Yy5yQ0LJqTfzSKLAKL7ZIjvOp9vQ4f6M+M8FF0Tr99Ancx2Q/dt
	d5+fho9CI8uYybjg3LHjAcKl/5vh9x4kjtCKLSpYjuBIcPE+snUvdpZ80l7MyFBi6VXAze+lsOE
	BLbFS
X-Gm-Gg: AZuq6aKeWQSy9Bm2v6W8v1lVKNP32iCNiS35+CLKnxlrNXRmiM+viMOjsRx9w10UEdu
	zAAdXMlIDH5puRMzJ8Ny3ybVBC4U3CJWQjVWrFtpuvxVKS4r+CQ+yErkajr+gMer8UBEcf/fu5J
	AFwgMABrkczznHB+f5nHfWJgXhczYHJEu8x+67wEzYPClBZ+GRPi92+kB/bAafuV9TBIFGSzA5L
	OsPBD4gBiM4qs12kmGj2xSiOe66itCZlxyWrOG5lyUn5hyKoq6qfmGCETENnySjykea5QrgIOoT
	Zz0ThfU2HIIi/F7SPlR4d1fBygEVbSfJdbgo++1AjCO+u305d0FD1u6ZiC8hjatiWsAbcLxYJoF
	bKhNZQMH/ApO9RGmX76H2fFaVrZp1Tj3R7xeXQkIYAMJyXWcMAzMNuX1mqgugaYUpvgzj1QaWKK
	9AKw==
X-Received: by 2002:a05:6000:2310:b0:435:9770:9ecb with SMTP id ffacd0b85a97d-435dd1cd9d7mr1483223f8f.56.1769506720864;
        Tue, 27 Jan 2026 01:38:40 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c9cesm37601534f8f.41.2026.01.27.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:38:40 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	msanalla@nvidia.com,
	maorg@nvidia.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	markzhang@nvidia.com,
	marco.crivellari@suse.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	roman.gushchin@linux.dev,
	wangliang74@huawei.com,
	yanjun.zhu@linux.dev
Subject: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at registration
Date: Tue, 27 Jan 2026 10:38:39 +0100
Message-ID: <20260127093839.126291-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16059-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6A7791E98
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

RoCE GID entries become stale when netdev properties change during the
IB device registration window. This is reproducible with a udev rule
that sets a MAC address when a VF netdev appears:

  ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth4", \
    RUN+="/sbin/ip link set eth4 address 88:22:33:44:55:66"

After VF creation, show_gids displays GIDs derived from the original
random MAC rather than the configured one.

The root cause is a race between netdev event processing and device
registration:

  CPU 0 (driver)                    CPU 1 (udev/workqueue)
  ──────────────                    ──────────────────────
  ib_register_device()
    ib_cache_setup_one()
      gid_table_setup_one()
        _gid_table_setup_one()
          ← GID table allocated
        rdma_roce_rescan_device()
          ← GIDs populated with
            OLD MAC
                                    ip link set eth4 addr NEW_MAC
                                    NETDEV_CHANGEADDR queued
                                    netdevice_event_work_handler()
                                      ib_enum_all_roce_netdevs()
                                        ← Iterates DEVICE_REGISTERED
                                        ← Device NOT marked yet, SKIP!
    enable_device_and_get()
      xa_set_mark(DEVICE_REGISTERED)
          ← Too late, event was lost

The netdev event handler uses ib_enum_all_roce_netdevs() which only
iterates devices marked DEVICE_REGISTERED. However, this mark is set
late in the registration process, after the GID cache is already
populated. Events arriving in this window are silently dropped.

Fix this by introducing a new xarray mark DEVICE_GID_UPDATES that is
set immediately after the GID table is allocated and initialized. Use
the new mark in ib_enum_all_roce_netdevs() function to iterate devices
instead of DEVICE_REGISTERED.

This is safe because:
- After _gid_table_setup_one(), all required structures exist (port_data,
  immutable, cache.gid)
- The GID table mutex serializes concurrent access between the initial
  rescan and event handlers
- Event handlers correctly update stale GIDs even when racing with rescan
- The mark is cleared in ib_cache_cleanup_one() before teardown

This also fixes similar races for IP address events (inetaddr_event,
inet6addr_event) which use the same enumeration path.

Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/cache.c     | 13 +++++++++++
 drivers/infiniband/core/core_priv.h |  3 +++
 drivers/infiniband/core/device.c    | 34 ++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 81cf3c902e81..e0bef9fa6dc0 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -927,6 +927,13 @@ static int gid_table_setup_one(struct ib_device *ib_dev)
 	if (err)
 		return err;
 
+	/*
+	 * Mark the device as ready for GID cache updates. This allows netdev
+	 * event handlers to update the GID cache even before the device is
+	 * fully registered.
+	 */
+	ib_device_enable_gid_updates(ib_dev);
+
 	rdma_roce_rescan_device(ib_dev);
 
 	return err;
@@ -1638,6 +1645,12 @@ void ib_cache_release_one(struct ib_device *device)
 
 void ib_cache_cleanup_one(struct ib_device *device)
 {
+	/*
+	 * Clear the GID updates mark first to prevent event handlers from
+	 * accessing the device while it's being torn down.
+	 */
+	ib_device_disable_gid_updates(device);
+
 	/* The cleanup function waits for all in-progress workqueue
 	 * elements and cleans up the GID cache. This function should be
 	 * called after the device was removed from the devices list and
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 05102769a918..a2c36666e6fc 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -100,6 +100,9 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 			      roce_netdev_callback cb,
 			      void *cookie);
 
+void ib_device_enable_gid_updates(struct ib_device *device);
+void ib_device_disable_gid_updates(struct ib_device *device);
+
 typedef int (*nldev_callback)(struct ib_device *device,
 			      struct sk_buff *skb,
 			      struct netlink_callback *cb,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1174ab7da629..87eaefd3794b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -93,6 +93,7 @@ static struct workqueue_struct *ib_unreg_wq;
 static DEFINE_XARRAY_FLAGS(devices, XA_FLAGS_ALLOC);
 static DECLARE_RWSEM(devices_rwsem);
 #define DEVICE_REGISTERED XA_MARK_1
+#define DEVICE_GID_UPDATES XA_MARK_2
 
 static u32 highest_client_id;
 #define CLIENT_REGISTERED XA_MARK_1
@@ -2441,11 +2442,42 @@ void ib_enum_all_roce_netdevs(roce_netdev_filter filter,
 	unsigned long index;
 
 	down_read(&devices_rwsem);
-	xa_for_each_marked (&devices, index, dev, DEVICE_REGISTERED)
+	xa_for_each_marked(&devices, index, dev, DEVICE_GID_UPDATES)
 		ib_enum_roce_netdev(dev, filter, filter_cookie, cb, cookie);
 	up_read(&devices_rwsem);
 }
 
+/**
+ * ib_device_enable_gid_updates - Mark device as ready for GID cache updates
+ * @device: Device to mark
+ *
+ * Called after GID table is allocated and initialized. After this mark is set,
+ * netdevice event handlers can update the device's GID cache. This allows
+ * events that arrive during device registration to be processed, avoiding
+ * stale GID entries when netdev properties change during the device
+ * registration process.
+ */
+void ib_device_enable_gid_updates(struct ib_device *device)
+{
+	down_write(&devices_rwsem);
+	xa_set_mark(&devices, device->index, DEVICE_GID_UPDATES);
+	up_write(&devices_rwsem);
+}
+
+/**
+ * ib_device_disable_gid_updates - Clear the GID updates mark
+ * @device: Device to unmark
+ *
+ * Called before GID table cleanup to prevent event handlers from accessing
+ * the device while it's being torn down.
+ */
+void ib_device_disable_gid_updates(struct ib_device *device)
+{
+	down_write(&devices_rwsem);
+	xa_clear_mark(&devices, device->index, DEVICE_GID_UPDATES);
+	up_write(&devices_rwsem);
+}
+
 /*
  * ib_enum_all_devs - enumerate all ib_devices
  * @cb: Callback to call for each found ib_device
-- 
2.51.1


