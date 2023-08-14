Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159477B9F1
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjHNN1f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjHNN1d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 09:27:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205012D;
        Mon, 14 Aug 2023 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692019652; x=1723555652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uEAgFuelBW2HgyEvKYz5wAP7z+RpkG1urn+9Q46Dy7I=;
  b=bk+eyYKuBrFmu+7+0R+2HpsogVQuD8ts7xFdW/Pp6C1EArEkdnu3+4jI
   19OxaOgzzDCvlgIdF31Qfb81FZ5JC+8hVhXRw2AoiTPVARHq+I/PSLLtT
   VAo//rcdqEiftiPjRrctjwm1jYol+8CbssBn4+NebN9+jReQd6FxBQ4XC
   k0Lu5V7ZoKjKnMGQQSStms3U4wqk8jwDZzQXQPKI7YndgjTSV2OTYNlJ7
   ltntS49aTu0bsbBU1cBTAmYrlTaSLz265XprDPcXdxMZfNQjXxRLXtcD7
   ZcISf1J/O2BUV3jqCqdGaQFvGLtPfGcMtiQfdeVHCqFhvrucMpD6nDkGD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="458399097"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="458399097"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 06:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="768452779"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="768452779"
Received: from lgarello-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.40.121])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 06:27:28 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Date:   Mon, 14 Aug 2023 16:27:20 +0300
Message-Id: <20230814132721.26608-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
errnos.

Convert the PCI specific error values to generic errno using
pcibios_err_to_errno() before returning them.

Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---

Maintainers beware, this will conflict with read+write -> set/clear_word
fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
take it instead of net people.


I wonder if these PCIBIOS_* error codes are useful at all? There's 1:1
mapping into errno values so no information loss if the functions would just
return errnos directly. Perhaps this is just legacy nobody has bothered to
remove? If nobody opposes, I could take a look at getting rid of them.

---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 4804990b7f22..0afd9dbfc471 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -371,7 +371,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 
 	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	err = mlx5_check_dev_ids(dev, dev_id);
 	if (err)
 		return err;
@@ -386,16 +386,16 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	/* PCI link toggle */
 	err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	reg16 |= PCI_EXP_LNKCTL_LD;
 	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	msleep(500);
 	reg16 &= ~PCI_EXP_LNKCTL_LD;
 	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 
 	/* Check link */
 	if (!bridge->link_active_reporting) {
@@ -408,7 +408,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	do {
 		err = pci_read_config_word(bridge, cap + PCI_EXP_LNKSTA, &reg16);
 		if (err)
-			return err;
+			return pcibios_err_to_errno(err);
 		if (reg16 & PCI_EXP_LNKSTA_DLLLA)
 			break;
 		msleep(20);
@@ -426,7 +426,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	do {
 		err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &reg16);
 		if (err)
-			return err;
+			return pcibios_err_to_errno(err);
 		if (reg16 == dev_id)
 			break;
 		msleep(20);
-- 
2.30.2

