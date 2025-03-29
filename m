Return-Path: <linux-rdma+bounces-9030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A8A75777
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Mar 2025 19:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605123AB7C8
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Mar 2025 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E751DB55D;
	Sat, 29 Mar 2025 18:33:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749142AE8E;
	Sat, 29 Mar 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743273224; cv=none; b=CmAX8sbMqVwseTi8IKxFNCDP8Wv4BobGVQIP5iMKRQCBseOxDrJLGWaJL337bfB0L3SvBKwbiRbVAkSQxFTVK41+cgj24JVIzmJSMO67QTGXhFAWLbnEdIfelqCVGMpnd6ZoOxFWuC1g6cSNzua3zSYN/ZbNJnMbCn1N+oHRyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743273224; c=relaxed/simple;
	bh=N0Bu789B+gdjMhkE5nvBLyPmkVSv0quQvGRlrjO9+28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsozICA+AN9R9g+aOQhuxULd79HS3n25N+HofRx6FaIHT42gglKyFOLSphIOZ+bCizWibC3FotAD/gO/EUWJQ3ivpSFi4Vy3+StMQRTF6Fb3EM2CCeDpO/PxbPGBcWdJzusiyoAsE26z1I+YuoDjcR6Ae0I8KkGdI487vZFs8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id AB1B9300034D8;
	Sat, 29 Mar 2025 19:23:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9633C11B31C; Sat, 29 Mar 2025 19:23:35 +0100 (CET)
Date: Sat, 29 Mar 2025 19:23:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Moshe Shemesh <moshe@mellanox.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-rdma@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/16] net/mlx5: Handle sync reset now event
Message-ID: <Z-g6pzpZu_TU0-nA@wunner.de>
References: <1602050457-21700-1-git-send-email-moshe@mellanox.com>
 <1602050457-21700-10-git-send-email-moshe@mellanox.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602050457-21700-10-git-send-email-moshe@mellanox.com>

The following was applied as commit eabe8e5e88f5 ("net/mlx5: Handle
sync reset now event").

It does some questionable things (from a PCI perspective), so allow
me to ask for details:

On Wed, Oct 07, 2020 at 09:00:50AM +0300, Moshe Shemesh wrote:
> On sync_reset_now event the driver does reload and PCI link toggle to
> activate firmware upgrade reset. When the firmware sends this event it
> syncs the event on all PFs, so all PFs will do PCI link toggle at once.
> To do PCI link toggle, the driver ensures that no other device ID under
> the same bridge by checking that all the PF functions under the same PCI
> bridge have same device ID. If no other device it uses PCI bridge link
> control to turn link down and up.
[...]
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
> @@ -156,6 +157,120 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
>  		mlx5_core_warn(dev, "PCI Sync FW Update Reset Ack. Device reset is expected.\n");
>  }
>  
> +#define MLX5_PCI_LINK_UP_TIMEOUT 2000
> +
> +static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
> +{
> +	struct pci_bus *bridge_bus = dev->pdev->bus;
> +	struct pci_dev *bridge = bridge_bus->self;
> +	u16 reg16, dev_id, sdev_id;
> +	unsigned long timeout;
> +	struct pci_dev *sdev;
> +	int cap, err;
> +	u32 reg32;
> +
> +	/* Check that all functions under the pci bridge are PFs of
> +	 * this device otherwise fail this function.
> +	 */
> +	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
> +	if (err)
> +		return err;
> +	list_for_each_entry(sdev, &bridge_bus->devices, bus_list) {
> +		err = pci_read_config_word(sdev, PCI_DEVICE_ID, &sdev_id);
> +		if (err)
> +			return err;
> +		if (sdev_id != dev_id)
> +			return -EPERM;
> +	}
> +
> +	cap = pci_find_capability(bridge, PCI_CAP_ID_EXP);
> +	if (!cap)
> +		return -EOPNOTSUPP;
> +
> +	list_for_each_entry(sdev, &bridge_bus->devices, bus_list) {
> +		pci_save_state(sdev);
> +		pci_cfg_access_lock(sdev);
> +	}
> +	/* PCI link toggle */
> +	err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
> +	if (err)
> +		return err;
> +	reg16 |= PCI_EXP_LNKCTL_LD;
> +	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
> +	if (err)
> +		return err;
> +	msleep(500);
> +	reg16 &= ~PCI_EXP_LNKCTL_LD;
> +	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
> +	if (err)
> +		return err;

The commit message doesn't state the reason why you're toggling
the Link Disable bit.

It propagates a Hot Reset down the hierarchy, so perhaps that's
the reason you're doing this?

If it is, why didn't you just use one of the existing library calls
such as pci_reset_bus(bridge)?

Thanks,

Lukas

