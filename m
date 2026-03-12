Return-Path: <linux-rdma+bounces-18095-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJlVHf2Qsml5NgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18095-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:10:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43682701DB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57DEE322061A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5B3B6C1D;
	Thu, 12 Mar 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eorr51LJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C83C3449
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309872; cv=none; b=hUayVBGiLasRKUnrYa5KsK0dITa5+O2Ko3veUjx//ym9H4sacABqjGLWILsxHLMRXnA/l4MHHJyVaxqcDWzi8LIIst7Do2/JpWW57nGZiZePMJWtPgZwULrP1GQpSUwR54WvGqBuwK1n+KrDz5KzqzhOHDN4KeONIlsLUWI2+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309872; c=relaxed/simple;
	bh=nAUS3G3ePSgJTCurwLZklAEdq9FSoOxVlxZL3wKzHh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyAd+vRXf8Scs4yExsFV1fcYulBOIuml+YHHYIjmF/4tNZGVqO5fMEECcbupL5k+9+POdUCwxy2wxsrfVrDC6HkOQyM1CbLGTxiOmsj+Tvgnlt8XqfxRIwQXBi9hE2CV7p2NZqtrNv+I/hyz7Bt9s46STsDgJdR/jNCsd89TvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eorr51LJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c5b40f60so712429f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309865; x=1773914665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq+BNITtc6p+HH6jh9NI7lkPW1WCKPvQbV7cZpOCkHI=;
        b=eorr51LJ/amQqIc7WsBmHe2J8VmGH6YlOTZGiOhQsNXzd7ovP4ePbTOIEpMRq5CTj4
         AUxT19oCSAZ985fKaZo3oqX/WzDE8vMiLnU6zG3fVJCci2A0W/IWSdo8NGVaTloUa/O7
         JTWfChmQJKcCpEUJVdgahr6WENEcA7DZwX48ThC4Ssq+Rf0ecs6K0KrwUhiYeyc6k4nF
         9RMYt+Ft+bSfO/Xetsh8nPpJLYeLNx8DGiQBqeTOBJu3TOxU2uSDBpDHLrLBz2BFsWZW
         tYruF1xmXRMEyMNu028i+jNWC/+8+OpTS8bEuUrk5ixGaJrWDr5fSX7ikUZ2f7JxxmTN
         OoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309865; x=1773914665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sq+BNITtc6p+HH6jh9NI7lkPW1WCKPvQbV7cZpOCkHI=;
        b=j2aHj9ZHFehPL443IjdnLv3W1cuCoHvRQ5PR46ax4FiB/W1TIx6UOUfqmbAm/qYuIL
         jXvgj3Oyyw3wJG3chPglTyHwb+Q7M5GiLVDCS+cfy3OZnAt6fZKYQowfD5O+7bi+bZg3
         1pc1H+EFWIA6l9k5TdfTbq1S1WMrYXY/rxTjV6DKl6RCu4ObA4Lv/1/XBjvcZ3fT7q1F
         IF+AJi6s1shJ9jOF91k3YC+5qk/UqR/iMH8yRa54Yt4iTjoayFIveQpQh+3Psih48T4S
         kg5TUpn3jMpC3HYR0vXNDO130P+0s/QKAfvNISK4Pan+ENyu6deS7Pl6MWZNH6qsl6Ef
         dXIg==
X-Forwarded-Encrypted: i=1; AJvYcCU5RQpLxDYjflZ99uT8wUVA4IZLXTA5ju+2EfClCRGcf9lZWbjz4ClBYob+SUCrAZ1Y9lApK/TZxmrF@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTgZrpCuOowpOE3G2iViUiq/Asirg4752Iq3vqKLVqYMNPCrQ
	yKpOIniDMMRbU2twOORg9l3uOeBXVHHZGaq5I/a73HggI6ciCjRhkZMBOCRs8KNMCsY=
X-Gm-Gg: ATEYQzyp8eMw60dhIQ6L/kgKfBcmgcAxhkPnAK8G8228dsAWgtKnFVsktzgSpM/lZVT
	eEMaInG6iW4wz6wejgcMu98UojuEHNEmYOGOEEb9dErUNvAuJjpwMNP0TODXPuGatjN2zawKq5C
	WH8MB96DTxABmNoP8N4jpBTDYAqVvjwQqNKXa2QT96BBMdqLg6XuPS/VWtorwyVEKaB9eGGYv34
	wZ60Wa3LtmGMt7uiGKrDynp0fMupoVoIISYb9o2pPY5e/zkKhDKfNC/Mk+Z++HPR39fZIq6/udY
	R5KugIF/3MklVrpV0FG5t9d9N/nPXHFBidIGXcC4lJYquI5snxAQf3LsqrOE0uxMEeRpJhcypdn
	YQ6tTIoVOYJV65XMea+NxEZioKWbtJYARU0yqaJYyDcvfUp4mljJX5Zu24KH+LLuvq4mibBwGPF
	egAOt5T5HTrHMBOgRkc9Zqdr5o
X-Received: by 2002:a05:6000:1acb:b0:439:ad2d:99f7 with SMTP id ffacd0b85a97d-439f821a221mr10260693f8f.28.1773309864988;
        Thu, 12 Mar 2026 03:04:24 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2187aasm6340802f8f.30.2026.03.12.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:24 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Thu, 12 Mar 2026 11:04:07 +0100
Message-ID: <20260312100407.551173-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18095-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,mellanox.com:email]
X-Rspamd-Queue-Id: E43682701DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Use the previously introduced shared devlink infrastructure to create
a shared devlink instance for mlx5 PFs that reside on the same physical
chip. The shared instance is identified by the chip's serial number
extracted from PCI VPD (V3 keyword, with fallback to serial number
for older devices).

Each PF that probes calls mlx5_shd_init() which extracts the chip serial
number and uses devlink_shd_get() to get or create the shared instance.
When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
to release the reference. The shared instance is automatically destroyed
when the last PF is removed.

Make the PF devlink instances nested in this shared devlink instance,
allowing userspace to identify which PFs belong to the same physical
chip.

Example:

pci/0000:08:00.0: index 0
  nested_devlink:
    auxiliary/mlx5_core.eth.0
devlink_index/1: index 1
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0: index 2
pci/0000:08:00.1: index 3
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1: index 4

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- removed "const" from "sn"
- passing driver pointer to devlink_shd_get()
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
 include/linux/mlx5/driver.h                   |  1 +
 5 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 8ffa286a18f5..d39fe9c4a87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,8 +16,9 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
+		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
+		lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index fdc3ba20912e..1c35c3fc3bb3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(dev->shd, devlink);
+		if (err)
+			goto unlock;
+	}
 	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+unlock:
 	devl_unlock(devlink);
 	return err;
 }
@@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_shd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
+			      err);
+		goto shd_init_err;
+	}
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..bc33f95302df
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/mlx5/driver.h>
+#include <net/devlink.h>
+
+#include "sh_devlink.h"
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	u8 *vpd_data __free(kfree) = NULL;
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct devlink *devlink;
+	char *sn, *end;
+	int start;
+	int err;
+
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		err = PTR_ERR(vpd_data);
+		return err == -ENODEV ? 0 : err;
+	}
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start < 0) {
+		/* Fall-back to SN for older devices. */
+		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
+		if (start < 0)
+			return -ENOENT;
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn)
+		return -ENOMEM;
+	/* Firmware may return spaces at the end of the string, strip it. */
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	/* Get or create shared devlink instance */
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
+	kfree(sn);
+	if (!devlink)
+		return -ENOMEM;
+
+	dev->shd = devlink;
+	return 0;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+
+	devlink_shd_put(dev->shd);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..8ab8d6940227
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+#include <linux/mlx5/driver.h>
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04dcd09f7517..1268fcf35ec7 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -798,6 +798,7 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	struct devlink *shd;
 };
 
 struct mlx5_db {
-- 
2.51.1


