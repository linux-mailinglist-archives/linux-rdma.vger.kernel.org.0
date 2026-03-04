Return-Path: <linux-rdma+bounces-17493-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDQ6DD1dqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17493-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:26:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A5204394
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D9D31EECC6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE4E35F196;
	Wed,  4 Mar 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zshcCcTM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56835F17F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640055; cv=none; b=MaWPFbSTFlw7BPjJR8IzvIHOmYZUR4Di89Z5NvFtMF8ouR1lFv84Fd+uOuULOlVRmOxwQxppJRQLB8iscRHEiiug4InoQ2aJ0UsnyyQuNzFg1PuTIAPJM+co1xScER9lbH5nIGua4ByhlsoQlOZFMaL7H+d4Iu7ivCLrfXGAEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640055; c=relaxed/simple;
	bh=nAUS3G3ePSgJTCurwLZklAEdq9FSoOxVlxZL3wKzHh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM6JfYY55py2UeOlI6nw4WZ0oP9R+fD3viTmPuKd3Gbhmexl0E8/AigmNY95QwZU1k81CiamvDGCsYzSq2PMja85XF42R2Bdkn1ps1xAhkxR+kAgm9PPQbPecxF3Bqh9iq4vJXYDGrA6xJxFksNZiU4aNW8KHrj8mmoRUh8L9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zshcCcTM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439ac15f35fso3986689f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640052; x=1773244852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq+BNITtc6p+HH6jh9NI7lkPW1WCKPvQbV7cZpOCkHI=;
        b=zshcCcTM5vzhC3nX68hniKrLraivQekWsnTGJLY5YKSMG1x7POpaW1KgWQoziwYpqZ
         DASnhyT2QYMl630e9eql3oegGnmh8ei58/+mkkBMQELoFe56ciUH4I02cxtl4v4nIFku
         CVQ4OE4/RCDbWW5128LlZTSh3MaJhlhVOXOyIaC5vLWF/qx2/w3IacaYk1XgT0lGiwrX
         dyK2lS9q30KmG1utBq+z2D6qEYNf4ij1oLsjX3lM+TafqAE2ef47HDYZbTEUR8worxYU
         tqUd0g+ZfsHXs5aWcvW71VMYWXhwn0e1KbSYkg/gZW9qqv71Y3hQ8TvJUnsL+nrDHqAc
         2EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640052; x=1773244852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sq+BNITtc6p+HH6jh9NI7lkPW1WCKPvQbV7cZpOCkHI=;
        b=dvTC27m3TcEiS4bhbenck8cLMyjdXiRpSZsa/2JEW5zvLQj6E4S4lAytIrxlzKVajj
         0J/TxRd8ju+Mnc2R55eX0cHC9sW2nnSM0/HBgkKr2Dg86+l0DcA13RkPi7VM8D/gsNMf
         2dYh2TAvwR2fqwhd6AF5NJhSu0/zlLYMnx63/ba04o3pA9pXUxxF8ZIeSmVxt8wbWeBr
         /O4fJIRB4c5YshD22klaaQL/DwkQo/CgOrOIMXtU4RpWPVUXesbbM0+8v9Hl6tScI2YN
         vIclGT5+aU5MDgpFDXxYm+HHBcNYgyoUrjy+goI4o6I58uFRnBwpvhkxfOv10nm0jLNl
         eSqA==
X-Forwarded-Encrypted: i=1; AJvYcCV0R7UXStEOcTHKtbjhWB1V0xRGdqlJF05axub7sfKiugWcYcMbhiIbDuE9x8ap3pzf1lnJzsIp2cBP@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHAm5Xvy6Vh0alWuNFPXoIyapQLx/0QQ8teECSmA5kllTBfe5
	jsesLmK1+4xbTs8VzjID9AJb/iW/HQkFfUTgObqcmDi0N0BG4srslBAwUOaVGBE396M=
X-Gm-Gg: ATEYQzxNxl5dCO+0udRf5ciPLL8qb8WiclH2zZuTLFeo92RWrkOFy92K9CIy+xOZSh7
	uD3mWGA/RjQfhWcx+UK6Ph1Nrm3hyH6X9nUMSvMjVRdI+mq1EXDsBYQXt0VwG/MeuQ3WqGcc1Fi
	xnbcjlsCRqCbkOS3Jj8mZi4Aw7NrHy3enHo0YORbKlO4mCVG2Hg1zRZxV+9L25dr0LBM++tp8Gz
	CPdzc/7yQuFTIrbD3DR2KOf76/zS06Oblv7dX4UCWrpG0gLMQm9/kVQ3loRSmvdN/FT5RqSPWEW
	nDL/MPnAZun5seBw0BiwsGJIBYducUuRXUlUeVkYEBZkSDqDnOhKg5YX3+V2lkMi9QzWbjI+7zD
	j7FR63B4wplUnD5Iq308Qoumzz5TmPo/k6pPpkR9vDTDnVrT8xslmHHnoyHaI0HspiIbubgY5i2
	ZMampUkTpK70zJtnB7kFHTteG4mQ8ylnjkQFejq599ttoMmw==
X-Received: by 2002:a05:6000:230c:b0:439:b619:33b2 with SMTP id ffacd0b85a97d-439c7fe64b4mr4723346f8f.43.1772640052085;
        Wed, 04 Mar 2026 08:00:52 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c65e0b23sm7919924f8f.32.2026.03.04.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:51 -0800 (PST)
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
Subject: [PATCH net-next v3 13/13] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Wed,  4 Mar 2026 17:00:22 +0100
Message-ID: <20260304160022.6114-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD1A5204394
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17493-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mellanox.com:email]
X-Rspamd-Action: no action

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


