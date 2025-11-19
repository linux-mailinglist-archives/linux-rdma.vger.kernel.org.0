Return-Path: <linux-rdma+bounces-14613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95820C6C75E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97BE64EE8F4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 02:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327A92DBF5B;
	Wed, 19 Nov 2025 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mliOOtzB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BA29E10B
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520648; cv=none; b=XpUGpqC3PJ+GzfZAUogM+sUtkdbK4lKS2/e1wEjHr/y1lHjdffL7yU5XZG9C2pY8BflmPLUlQbqh3JeljpQknFqGFbEHBM8LtcmaesP32aPq/SsS7NAkOiPpTszr5cAFMmkNIWDBHsVGY8TU+y5OBSlWIP6QlzVZYQ9rEzQUEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520648; c=relaxed/simple;
	bh=l/PApn1G/c4u9BEsPG1poIW4K3XiIGRyssMDc+QqiBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX0+yqOgyQXg16QmVrRtVjCB3Hkq49AFdp1tn7qI1KG021fBOKIT4Xv6VAgdoL6QNfYRHJoayrsyzygDXSc4cte+uDohrp+8Iub2jAle/BGFfmlZkqMkPPOIdL6JP5o6y2GnijFYKbl0Kq+rx7eW1ffUq1aJ8PLL/GUsSV+ivPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mliOOtzB; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e19642764so5275382d50.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 18:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520645; x=1764125445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfMYKL1MowanU+ydcWrbRX5x+m+UA3104k+MyV8UJCU=;
        b=mliOOtzBJ34BZeVHA3TxaQTLNzsoWolk7hMB2EGCh1bvYTprwMwxtKXQQn3+9LadLc
         1sdSkciwdi6k/EGBDzW/skQMBgyoxzAqPcqpeorbgkCH9UAIv5AQN2xab7TrN/NqvQxT
         PT1L8k45eL2hqwestEfrocTONhBVTAuGIijieLoBhZe8gCKUJIpBvSDh/CwuSzp6nC2a
         UyLm8A9uXcyQh0LUdl18OIVXBnvjtOVK8rLXHvB6eD+R9ZLVZrk6lARb0l04UI7yz/wV
         ysBgBmApz6uLfSgl42SyVcwAuFiq3e01lOHRBxZSLj0nSFXFJ8OCwG/u9fEfjHbUAEeM
         YPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520645; x=1764125445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfMYKL1MowanU+ydcWrbRX5x+m+UA3104k+MyV8UJCU=;
        b=YoyzjjEBsmQbgyL0OEDCIqt/uEEzF77wRaN8SYRumXq2kd322oU48F/jnmA8orjnuj
         TS16DDb8RAiSt40ngoZXJaUDD5ON6SEN4D29ao6ppauC89XfNRmfwuVpjI7DqOH9i5Cf
         01YvARGZBQk2a9vP+PAP6imBIUGelLbeYPfBZrDWeQwS/LmGUGjo72l6NKPn1DAVaTaI
         RMSU/CL1kXs589PMh+Czy1papKUoYl64qNvOMq50eIQspUbw94cSVURWgqvEC640SnGQ
         zBtNqaaXSz0YvgXCoWQ4wes2WN3bOg8pxdwv9Bia8b2yZ6iWepa/LOz5ssdFYnyxifWk
         /P5w==
X-Forwarded-Encrypted: i=1; AJvYcCU0R0ab9FiboPSKfX1g3zlBcDbe1q2ygII6F2owWQiTIoowKhYAK9H4aU1qX8h0yIaPCS3ifzVGSD14@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbgaf8Z4cM7e2z14P0rcj1FsLCWM2l9EVcWjiqSoBzB8uWBDvQ
	Aa4lqueOlcVaYoH3JZL89taz5PzUrvjxgKCCoPw5iky+VB1rNQGRJAQg
X-Gm-Gg: ASbGncv4LTzJyBrHu5cIcO9xQKnEk0Kf2eeqy49TljYL2N/pe0OanDilvsZq0u5HUBw
	QHZ5/JCrnjl4yfrAnUocLuNYi8QD1tueOXR4Vy4npAEev95b/q8X4UNxQSXyDaI/wQE5L0InArD
	k8gITCog98AdFa4qflnjhoeyF57VZ6WuS9Liegm7noEZCrdXQiefd2C0UaXJHzN34B8A/89wDcA
	1Mq/mZr42tm3UyIT1JCmF9egiJodZNR1pVjum9qmmxkZAwneu+DZkdzoS3cnm3kTBqCT9BEHeNi
	wZjt4m2qcys+MQmC+kyOtcg5ytkWsX4Tw5N0UufF9H1tdg1kE+yUAwRcFmdd5q+Pm1Bo66Y8owE
	r4y+oAxsMgrtCEg4JK+kcUO3e8OIiSSbDGca5ASzhB6fG8mCC3lF5a9V0ddgUKcL0KX7QHIqDMl
	y0i1X1Bu1kD2P4qeOgEz40EUuqFtRmOc0=
X-Google-Smtp-Source: AGHT+IH0Fq/B03G5Ni+5EL+C2Zjoi3HIOENrIEn4SmPL1fIk2tuLkPEZkquimopS4n2FAt0wQw4oUQ==
X-Received: by 2002:a53:c052:0:20b0:63f:b922:ed79 with SMTP id 956f58d0204a3-641e755565amr13345889d50.14.1763520645166;
        Tue, 18 Nov 2025 18:50:45 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410eabb46esm6540895d50.17.2025.11.18.18.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:50:44 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 5/6] netdevsim: register a new devlink param with default value interface
Date: Tue, 18 Nov 2025 18:50:35 -0800
Message-ID: <20251119025038.651131-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119025038.651131-1-daniel.zahka@gmail.com>
References: <20251119025038.651131-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new devlink param, test2, that supports default param actions
via the devlink_param::get_default() and
devlink_param::reset_default() functions.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v5:
     - don't use magic value in get_default() reset_default()

 drivers/net/netdevsim/dev.c       | 56 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 57 insertions(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 95f66c1f59db..2683a989873e 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -320,6 +320,8 @@ static int nsim_dev_debugfs_init(struct nsim_dev *nsim_dev)
 			   &nsim_dev->max_macs);
 	debugfs_create_bool("test1", 0600, nsim_dev->ddir,
 			    &nsim_dev->test1);
+	debugfs_create_u32("test2", 0600, nsim_dev->ddir,
+			   &nsim_dev->test2);
 	nsim_dev->take_snapshot = debugfs_create_file("take_snapshot",
 						      0200,
 						      nsim_dev->ddir,
@@ -521,8 +523,53 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 enum nsim_devlink_param_id {
 	NSIM_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	NSIM_DEVLINK_PARAM_ID_TEST1,
+	NSIM_DEVLINK_PARAM_ID_TEST2,
 };
 
+static int
+nsim_devlink_param_test2_get(struct devlink *devlink, u32 id,
+			     struct devlink_param_gset_ctx *ctx,
+			     struct netlink_ext_ack *extack)
+{
+	struct nsim_dev *nsim_dev = devlink_priv(devlink);
+
+	ctx->val.vu32 = nsim_dev->test2;
+	return 0;
+}
+
+static int
+nsim_devlink_param_test2_set(struct devlink *devlink, u32 id,
+			     struct devlink_param_gset_ctx *ctx,
+			     struct netlink_ext_ack *extack)
+{
+	struct nsim_dev *nsim_dev = devlink_priv(devlink);
+
+	nsim_dev->test2 = ctx->val.vu32;
+	return 0;
+}
+
+#define NSIM_DEV_TEST2_DEFAULT 1234
+
+static int
+nsim_devlink_param_test2_get_default(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
+{
+	ctx->val.vu32 = NSIM_DEV_TEST2_DEFAULT;
+	return 0;
+}
+
+static int
+nsim_devlink_param_test2_reset_default(struct devlink *devlink, u32 id,
+				       enum devlink_param_cmode cmode,
+				       struct netlink_ext_ack *extack)
+{
+	struct nsim_dev *nsim_dev = devlink_priv(devlink);
+
+	nsim_dev->test2 = NSIM_DEV_TEST2_DEFAULT;
+	return 0;
+}
+
 static const struct devlink_param nsim_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(MAX_MACS,
 			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
@@ -531,6 +578,14 @@ static const struct devlink_param nsim_devlink_params[] = {
 			     "test1", DEVLINK_PARAM_TYPE_BOOL,
 			     BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
 			     NULL, NULL, NULL),
+	DEVLINK_PARAM_DRIVER_WITH_DEFAULTS(NSIM_DEVLINK_PARAM_ID_TEST2,
+					   "test2", DEVLINK_PARAM_TYPE_U32,
+					   BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+					   nsim_devlink_param_test2_get,
+					   nsim_devlink_param_test2_set,
+					   NULL,
+					   nsim_devlink_param_test2_get_default,
+					   nsim_devlink_param_test2_reset_default),
 };
 
 static void nsim_devlink_set_params_init_values(struct nsim_dev *nsim_dev,
@@ -1590,6 +1645,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 	nsim_dev->fw_update_flash_chunk_time_ms = NSIM_DEV_FLASH_CHUNK_TIME_MS_DEFAULT;
 	nsim_dev->max_macs = NSIM_DEV_MAX_MACS_DEFAULT;
 	nsim_dev->test1 = NSIM_DEV_TEST1_DEFAULT;
+	nsim_dev->test2 = NSIM_DEV_TEST2_DEFAULT;
 	spin_lock_init(&nsim_dev->fa_cookie_lock);
 
 	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index af6fcfcda8ba..d1a941e2b18f 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -331,6 +331,7 @@ struct nsim_dev {
 	u32 fw_update_flash_chunk_time_ms;
 	u32 max_macs;
 	bool test1;
+	u32 test2;
 	bool dont_allow_reload;
 	bool fail_reload;
 	struct devlink_region *dummy_region;
-- 
2.47.3


