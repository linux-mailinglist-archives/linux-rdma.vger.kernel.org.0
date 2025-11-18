Return-Path: <linux-rdma+bounces-14578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A32EC66A66
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 01:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id DCE9929BBC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 00:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84C42773D2;
	Tue, 18 Nov 2025 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew5l7Q9m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D7223DE9
	for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425495; cv=none; b=kfFkTqc9E6zpLilHGDaON/aDqfj/9s+PiGfNMh2wCOHfG2LNHIBfYlnI/JAWPHMqLX+eKjlYd994SzxgifKyfJSk7HmF1tjszHn7GLT3aesQxgFuNrdqPVSUT/SaKys8enyDE3ZZALzM8IoT3qXRiq2Hg4O1Tux6LEME4j4WNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425495; c=relaxed/simple;
	bh=GU2W4Env3pVySzouvOpft34vMD3lKZ1I3nej/UOh/y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBxrGDg4zjHWld0qwd1mc/qFqAJlKPonn9v3+2Vj455+vbaAECYnkhuvzaD8//a0aYivGmUMr7VLxhIdIFIl127cAGmX5c7ip1r4lBoXy/GLi2Zg+CDcc0+740D7V1/YG5A3Koph98wMJ4NVtty0ki6r6aziQ5ZWKephhIKpRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew5l7Q9m; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7881b67da53so43747837b3.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 16:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763425493; x=1764030293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpm61WVMpXaTS4gWKedINtFRMcV4KgYOfoTCHp0JnK8=;
        b=ew5l7Q9mUw6LE3k06t/c0Pc8M1Q1KK/5qL/vIqo46FWjTp5WOJ+YXb4qzGl8NXulvW
         7a86YXvtjdK/1HVURnrp/AIgFJYeVJyq1jjF0msko5U/xqStRFi/wbcGY74IHYjB+Uno
         NWntIknJ80hPgZFOj6oD2UG8eLftiLIc08pFTjcwLrILM7C9rWEmAWvVYX5AzSA+ojyn
         1u6Ni3HChZybUznQGQ9TwnpFlgWt2jEfNykQdVEC+P+An2/VXOr68UaCgBw/ImufbfYc
         VMEsYzyrx0b4xefMBBtTwyXR1C3tQR8TDxGFxAULfCj/6jLOh9Q8LMKP1STP5qFhsUoZ
         B7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763425493; x=1764030293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lpm61WVMpXaTS4gWKedINtFRMcV4KgYOfoTCHp0JnK8=;
        b=gEkS/kJm9+0KsyNa+f0xf8lVR9Qpawhe5l8/d6oOtXGAY+Lsk7TI4SOOfuWbIoGDZ8
         bkc9ixC9P1hpzdLY+aq0QU/ZunXQBKVQmTlfGi3Q++jWhTZLHam4eGhQb9TEJ3qghgfn
         ukZRfeWf6nPoap8JA7iMDHzBuAUyYi02trxex9jdQfmo5UH24dxUyfSG03bI6z1El+6L
         8uoB4ZxgIU5LYx8NA+tiYtcEIpxcqgzlyUBYbGRMJizRs/YLNGuEsVgy4noIYER3/SFf
         MdpjUbiUvZOg2/jb++KbkQ+LrIV8va8WM+CKg9C//YhNLOtjqH6vg9k2KmeYBgDqgD2y
         miZg==
X-Forwarded-Encrypted: i=1; AJvYcCXJCFSqpI90m9ZnhONCtwe2379GjZ1vDXi4S36OWLylm/Ol7qRe1rvdUqkazBIrL7oU88qxNshpOxIQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8SFVNv5v93oDh3i9jJCtgVmN+14MXdkxCE3lbIH9CVtpHTOp
	KK6/6RnfcJPdFmOBuxNa6u4r9PPqDdJaavKAmvxsFy6jBdXxptyV+NZL
X-Gm-Gg: ASbGncvcpoEiMqTqP2UbnLW7m4rdw1yqgY3IwmYNhVrn83yReu6qkHs9wWfCMJ4+aRA
	5d5S5aDV2B3kGip1hjSQpa2V7KbjfIaiDOdwOzUkNgob0SyRRt9T8Igzo0YpHTiPXjvaj0O70/T
	KH4RSnMNDO51ZB4vQNmDlJkTc7wJgsuZ++f2JhWI065mkVvh43V4KupP9Hv3kuK9ymT9TgLChey
	ItuZ7Hz9jrFa90R0fWSIccHeyJHR+Byw3sG72TrAqOrmoHtx3GDJGnddFcz8TbBa2Tc5nHG/p5s
	bJWuW471tMr1USHP0IecNZZcSw1Egsn0Cc1iAZypxu3KTGiWTrrmGLHD+ApXhB5Bie/63tRLWmq
	j6qY8RfbTujxoksWEBiUKSYEMEM2oGdh5ulY7Nvwc5wnFzkYqrPsB1TTy5clcB5sPwfqmbq10XT
	Ox+olbYQbf5W0fRl8/lJzh
X-Google-Smtp-Source: AGHT+IG+Fh1oMqCwOWhdJCefG39eiTd3KH357Rm2dtFkemtoWRfvUtMRNQYxOyrW7sTnzPCc3JOpvw==
X-Received: by 2002:a05:690c:c3f1:b0:786:660b:82b5 with SMTP id 00721157ae682-78929e46780mr104068197b3.27.1763425492499;
        Mon, 17 Nov 2025 16:24:52 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882214ea47sm46813667b3.45.2025.11.17.16.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:24:49 -0800 (PST)
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
Subject: [PATCH net-next v4 5/6] netdevsim: register a new devlink param with default value interface
Date: Mon, 17 Nov 2025 16:24:31 -0800
Message-ID: <20251118002433.332272-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118002433.332272-1-daniel.zahka@gmail.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
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

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/dev.c       | 55 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 95f66c1f59db..3aeb3abfec83 100644
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
@@ -521,8 +523,51 @@ static int nsim_dev_resources_register(struct devlink *devlink)
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
+static int
+nsim_devlink_param_test2_get_default(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
+{
+	ctx->val.vu32 = 1234;
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
+	nsim_dev->test2 = 1234;
+	return 0;
+}
+
 static const struct devlink_param nsim_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(MAX_MACS,
 			      BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
@@ -531,6 +576,14 @@ static const struct devlink_param nsim_devlink_params[] = {
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
@@ -1396,6 +1449,7 @@ static const struct devlink_ops nsim_dev_devlink_ops = {
 
 #define NSIM_DEV_MAX_MACS_DEFAULT 32
 #define NSIM_DEV_TEST1_DEFAULT true
+#define NSIM_DEV_TEST2_DEFAULT 1234
 
 static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
 			       unsigned int port_index, u8 perm_addr[ETH_ALEN])
@@ -1590,6 +1644,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
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


