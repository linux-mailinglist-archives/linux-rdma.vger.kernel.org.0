Return-Path: <linux-rdma+bounces-3050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A606903C93
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 15:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B744C2857FA
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0417C9F3;
	Tue, 11 Jun 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewCcNeFy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B517C7D7;
	Tue, 11 Jun 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110876; cv=none; b=T8fSuv0X1pin51g13pIMlT9G7fgqs1fkpj5gPcvD+Q1EbIXFreZ6PptQy3KTLOyRsqZB5csTe+GcMbLT9+apU0+FWf1Hx8m++2Vu+NKLYd3KjDPLSkTLjnJQxcXyTutKh5MIQzJX32lU61nKRzzB9smnpoielCBS5GcBb2A3Ajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110876; c=relaxed/simple;
	bh=0JZaCXW+n6H3OOec6ZC4VzANYpWXLrydYTlRC21cNoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+VPNxhPwld8iu9SoAEvlAvJVRXlT7aRnqE0pgErMQAcHuGh2r9gIRhsHAFbAffuq/ELM9p8+RlEuOzbDi+gZ0gSJjERUxuBUX2h1s7J2PcQ6BRGEX5D+NDqF2wngKCdaFzISjzJU3t9aQH4a6K7s3zCyvZhV7vN/vzS1oLZyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewCcNeFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA5C4AF48;
	Tue, 11 Jun 2024 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718110875;
	bh=0JZaCXW+n6H3OOec6ZC4VzANYpWXLrydYTlRC21cNoM=;
	h=From:To:Cc:Subject:Date:From;
	b=ewCcNeFyq/mkicN6HAoGxWW/7T93ZP4/IaputgZrzcjWFj9c2HBxYUhcfAQqoX31C
	 UREfUSsaHshnuvVSUQbtPqJfdYurZf09CNnL7JSwdtKwwGJMsqTHWi7kntu2DvpL5c
	 1pujHXfcrKtbc/IIPXwCcZcZ+iE3XWEUiZXBR390=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 1/6] auxbus: make to_auxiliary_drv accept and return a constant pointer
Date: Tue, 11 Jun 2024 15:01:04 +0200
Message-ID: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8097; i=gregkh@linuxfoundation.org; h=from:subject; bh=0JZaCXW+n6H3OOec6ZC4VzANYpWXLrydYTlRC21cNoM=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkZXv377+23kF/wqELi4uFeuzsHjbJvzz76ZW5qgbOMi OnP0GzvjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIBnaGBZM3XlC5buT2tvrZ 5hvTphh0fv18aQPDPMU/y30a3d71FF3fpOdu/J5pptniLAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In the quest to make struct device constant, start by making
to_auziliary_drv() return a constant pointer so that drivers that call
this can be fixed up before the driver core changes.

As the return type previously was not constant, also fix up all callers
that were assuming that the pointer was not going to be a constant one
in order to not break the build.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>
Cc: Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: linux-media@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org
Cc: sound-open-firmware@alsa-project.org
Cc: linux-sound@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/auxiliary.c                      | 8 ++++----
 drivers/media/pci/intel/ipu6/ipu6-bus.h       | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 4 ++--
 include/linux/auxiliary_bus.h                 | 2 +-
 sound/soc/sof/sof-client.c                    | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index d3a2c40c2f12..5832e31bb77b 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -180,7 +180,7 @@ static const struct auxiliary_device_id *auxiliary_match_id(const struct auxilia
 static int auxiliary_match(struct device *dev, struct device_driver *drv)
 {
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
-	struct auxiliary_driver *auxdrv = to_auxiliary_drv(drv);
+	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(drv);
 
 	return !!auxiliary_match_id(auxdrv->id_table, auxdev);
 }
@@ -203,7 +203,7 @@ static const struct dev_pm_ops auxiliary_dev_pm_ops = {
 
 static int auxiliary_bus_probe(struct device *dev)
 {
-	struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
+	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 	int ret;
 
@@ -222,7 +222,7 @@ static int auxiliary_bus_probe(struct device *dev)
 
 static void auxiliary_bus_remove(struct device *dev)
 {
-	struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
+	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 
 	if (auxdrv->remove)
@@ -232,7 +232,7 @@ static void auxiliary_bus_remove(struct device *dev)
 
 static void auxiliary_bus_shutdown(struct device *dev)
 {
-	struct auxiliary_driver *auxdrv = NULL;
+	const struct auxiliary_driver *auxdrv = NULL;
 	struct auxiliary_device *auxdev;
 
 	if (dev->driver) {
diff --git a/drivers/media/pci/intel/ipu6/ipu6-bus.h b/drivers/media/pci/intel/ipu6/ipu6-bus.h
index b26c6aee1621..bb4926dfdf08 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-bus.h
+++ b/drivers/media/pci/intel/ipu6/ipu6-bus.h
@@ -21,7 +21,7 @@ struct ipu6_buttress_ctrl;
 
 struct ipu6_bus_device {
 	struct auxiliary_device auxdev;
-	struct auxiliary_driver *auxdrv;
+	const struct auxiliary_driver *auxdrv;
 	const struct ipu6_auxdrv_data *auxdrv_data;
 	struct list_head list;
 	void *pdata;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index ba3fa1c2e5d9..b9e7d3e7b15d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -239,7 +239,7 @@ void bnxt_ulp_stop(struct bnxt *bp)
 
 		adev = &aux_priv->aux_dev;
 		if (adev->dev.driver) {
-			struct auxiliary_driver *adrv;
+			const struct auxiliary_driver *adrv;
 			pm_message_t pm = {};
 
 			adrv = to_auxiliary_drv(adev->dev.driver);
@@ -277,7 +277,7 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 
 		adev = &aux_priv->aux_dev;
 		if (adev->dev.driver) {
-			struct auxiliary_driver *adrv;
+			const struct auxiliary_driver *adrv;
 
 			adrv = to_auxiliary_drv(adev->dev.driver);
 			edev->en_state = bp->state;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1181d2..7341e7c4ef24 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2784,7 +2784,7 @@ static struct ice_pf *
 ice_ptp_aux_dev_to_owner_pf(struct auxiliary_device *aux_dev)
 {
 	struct ice_ptp_port_owner *ports_owner;
-	struct auxiliary_driver *aux_drv;
+	const struct auxiliary_driver *aux_drv;
 	struct ice_ptp *owner_ptp;
 
 	if (!aux_dev->dev.driver)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 47e7c2639774..9a79674d27f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -349,7 +349,7 @@ int mlx5_attach_device(struct mlx5_core_dev *dev)
 {
 	struct mlx5_priv *priv = &dev->priv;
 	struct auxiliary_device *adev;
-	struct auxiliary_driver *adrv;
+	const struct auxiliary_driver *adrv;
 	int ret = 0, i;
 
 	devl_assert_locked(priv_to_devlink(dev));
@@ -406,7 +406,7 @@ void mlx5_detach_device(struct mlx5_core_dev *dev, bool suspend)
 {
 	struct mlx5_priv *priv = &dev->priv;
 	struct auxiliary_device *adev;
-	struct auxiliary_driver *adrv;
+	const struct auxiliary_driver *adrv;
 	pm_message_t pm = {};
 	int i;
 
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index de21d9d24a95..bdff7b85f2ae 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -203,7 +203,7 @@ static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
 	return container_of(dev, struct auxiliary_device, dev);
 }
 
-static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *drv)
+static inline const struct auxiliary_driver *to_auxiliary_drv(const struct device_driver *drv)
 {
 	return container_of(drv, struct auxiliary_driver, driver);
 }
diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
index 99f74def4ab6..5d6005a88e79 100644
--- a/sound/soc/sof/sof-client.c
+++ b/sound/soc/sof/sof-client.c
@@ -357,7 +357,7 @@ EXPORT_SYMBOL_NS_GPL(sof_client_ipc4_find_module, SND_SOC_SOF_CLIENT);
 
 int sof_suspend_clients(struct snd_sof_dev *sdev, pm_message_t state)
 {
-	struct auxiliary_driver *adrv;
+	const struct auxiliary_driver *adrv;
 	struct sof_client_dev *cdev;
 
 	mutex_lock(&sdev->ipc_client_mutex);
@@ -380,7 +380,7 @@ EXPORT_SYMBOL_NS_GPL(sof_suspend_clients, SND_SOC_SOF_CLIENT);
 
 int sof_resume_clients(struct snd_sof_dev *sdev)
 {
-	struct auxiliary_driver *adrv;
+	const struct auxiliary_driver *adrv;
 	struct sof_client_dev *cdev;
 
 	mutex_lock(&sdev->ipc_client_mutex);
-- 
2.45.2


