Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2E77C384
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 00:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHNWdP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 18:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjHNWcp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 18:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1360C1723;
        Mon, 14 Aug 2023 15:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A595064ABB;
        Mon, 14 Aug 2023 22:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963D2C433C8;
        Mon, 14 Aug 2023 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692052355;
        bh=fNvbnPblE97vAUcJkov68DyQCZiCJ762WhRrdDSXMKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m186P7fQpmg6zfJXBT7tLHECFS2PvRf9qof7SD3dZuBOLHMKmmkIBn/XNrIYlPw2o
         BU0pH0o1JrKcy/IRsnJai2OaqxRZKl3pJxkZKUmwWdyj87n5gA87cvYO9sHnn7mlAw
         /SNvpFZQyRrKKFoSNCw9mL2ZgC9nw2Ik1PiamQ2tOnxxTinTEhhm1a+onGOSyhBXSz
         iiwHdaHN2iobrrQer6JmoxyIdhYZPsgSOT3aZxUjiUvWyz9K3BdPL/nMQAdsOrV1R9
         fxG5s8WqX9udiQjXXfwLJje45ok9OoVJpggj/xKRnXzLoD0I1A8Ap9EhRP3ynG15nj
         KDRKI5HfdZsqg==
Date:   Mon, 14 Aug 2023 17:32:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <20230814223232.GA195681@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814132721.26608-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
> mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
> errnos.
> 
> Convert the PCI specific error values to generic errno using
> pcibios_err_to_errno() before returning them.
> 
> Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
> Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> ---
> 
> Maintainers beware, this will conflict with read+write -> set/clear_word
> fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
> take it instead of net people.

I provisionally rebased and applied it on pci/pcie-rmw.  Take a look
and make sure I didn't botch it -- I also found a case in
mlx5_check_dev_ids() that looks like it needs the same conversion.

The commit as applied is below.

If networking folks would prefer to take this, let me know and I can
drop it.

> I wonder if these PCIBIOS_* error codes are useful at all? There's 1:1
> mapping into errno values so no information loss if the functions would just
> return errnos directly. Perhaps this is just legacy nobody has bothered to
> remove? If nobody opposes, I could take a look at getting rid of them.

I don't think the PCIBIOS error codes are very useful outside of
arch/x86.  They're returned by x86 PCIBIOS functions, and I think we
still use those calls, but I don't think there's value in exposing the
x86 error codes outside arch/x86.  Looks like a big job to clean it up
though ;)

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> index 4804990b7f22..0afd9dbfc471 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> @@ -371,7 +371,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
>  
>  	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
>  	if (err)
> -		return err;
> +		return pcibios_err_to_errno(err);
>  	err = mlx5_check_dev_ids(dev, dev_id);
>  	if (err)
>  		return err;
> @@ -386,16 +386,16 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
>  	/* PCI link toggle */
>  	err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
>  	if (err)
> -		return err;
> +		return pcibios_err_to_errno(err);
>  	reg16 |= PCI_EXP_LNKCTL_LD;
>  	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
>  	if (err)
> -		return err;
> +		return pcibios_err_to_errno(err);
>  	msleep(500);
>  	reg16 &= ~PCI_EXP_LNKCTL_LD;
>  	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
>  	if (err)
> -		return err;
> +		return pcibios_err_to_errno(err);
>  
>  	/* Check link */
>  	if (!bridge->link_active_reporting) {
> @@ -408,7 +408,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
>  	do {
>  		err = pci_read_config_word(bridge, cap + PCI_EXP_LNKSTA, &reg16);
>  		if (err)
> -			return err;
> +			return pcibios_err_to_errno(err);
>  		if (reg16 & PCI_EXP_LNKSTA_DLLLA)
>  			break;
>  		msleep(20);
> @@ -426,7 +426,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
>  	do {
>  		err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &reg16);
>  		if (err)
> -			return err;
> +			return pcibios_err_to_errno(err);
>  		if (reg16 == dev_id)
>  			break;
>  		msleep(20);

commit a48c6af2d2a5 ("net/mlx5: Convert PCI error values to generic errnos")
Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Date:   Mon Aug 14 16:27:20 2023 +0300

    net/mlx5: Convert PCI error values to generic errnos
    
    mlx5_pci_link_toggle() returns a mix of PCI-specific error codes and
    generic errnos.
    
    Convert the PCI-specific error values to generic errno using
    pcibios_err_to_errno() before returning them.
    
    Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
    Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
    Link: https://lore.kernel.org/r/20230814132721.26608-1-ilpo.jarvinen@linux.intel.com
    Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    [bhelgaas: rebase to pci/pcie-rmw, also convert in mlx5_check_dev_ids()]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 99dcbd006357..85a2dfbb5c46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -311,7 +311,7 @@ static int mlx5_check_dev_ids(struct mlx5_core_dev *dev, u16 dev_id)
 	list_for_each_entry(sdev, &bridge_bus->devices, bus_list) {
 		err = pci_read_config_word(sdev, PCI_DEVICE_ID, &sdev_id);
 		if (err)
-			return err;
+			return pcibios_err_to_errno(err);
 		if (sdev_id != dev_id) {
 			mlx5_core_warn(dev, "unrecognized dev_id (0x%x)\n", sdev_id);
 			return -EPERM;
@@ -371,7 +371,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 
 	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	err = mlx5_check_dev_ids(dev, dev_id);
 	if (err)
 		return err;
@@ -386,11 +386,11 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	/* PCI link toggle */
 	err = pcie_capability_set_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 	msleep(500);
 	err = pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 
 	/* Check link */
 	if (!bridge->link_active_reporting) {
@@ -403,7 +403,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	do {
 		err = pci_read_config_word(bridge, cap + PCI_EXP_LNKSTA, &reg16);
 		if (err)
-			return err;
+			return pcibios_err_to_errno(err);
 		if (reg16 & PCI_EXP_LNKSTA_DLLLA)
 			break;
 		msleep(20);
@@ -421,7 +421,7 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 	do {
 		err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &reg16);
 		if (err)
-			return err;
+			return pcibios_err_to_errno(err);
 		if (reg16 == dev_id)
 			break;
 		msleep(20);
