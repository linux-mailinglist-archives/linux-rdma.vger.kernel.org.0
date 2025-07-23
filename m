Return-Path: <linux-rdma+bounces-12446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF3B0FA1F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 20:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F83BF584
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCBE22DFB6;
	Wed, 23 Jul 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="kBeoPSi6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mta-202a.earthlink-vadesecure.net (mta-202b.earthlink-vadesecure.net [51.81.232.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA64EB38;
	Wed, 23 Jul 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.232.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294652; cv=none; b=hrm0P5bNhFcaR+Sx/JQHLp4WPsWLBpCOaD5hMS7y3G7RzN4FI0dcANxP8ZeOHqCjJ4QT/8pmbbguuGPNv37u/AQgzl6X7fItS5H70CbCkRoHFBrP93EW81AclXE4ZcfkMm6CpdGDKFpsa8y8/CtgHvBrFRvT9mnkFheYWKdnjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294652; c=relaxed/simple;
	bh=/jQc3j7DJwR5+BiQLNSRZ/dtUWfBfXiQ/+HoNM56VrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPXz2XWpvCE67WUk9oqskx2XDpU7UPQ+WH9ySxcgC+YavvSKMBJ16ac6xRe+xsSg2uc1qOcgQUoEpOBAWk8lFj0SCCnJyYxV9H9KEg/6eeGmzuORex15wK75JPRBta8pqz8vWhjeH7R0GWVozU63BeQH+7rCULHla8LQ7PgtZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=kBeoPSi6; arc=none smtp.client-ip=51.81.232.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=ssjC8MJ/TxjzUiBg9LlMZVnIHlF1CmaJn7A7xV
 Ut2to=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1753294308; x=1753899108; b=kBeoPSi6hcRFMifGOO2wta/Gp3/
 asIn2Bt4HyNjVOUaDG+QF51WpTHurbWPAPIH18fK5/P/F3ZpbXXks5qrjA96XvTb9nWdDl9
 Z8/7peF4B+7CBBWAmIHcfLNZneKnNmzwHCZZ7Uy6bhyxDolFB0R9aqRwoyovMNBtxAlCWHx
 Yym6SUSySlmfXsDC9rJwV6FHHzZLWBMqbncVuJ9MxQhVIm2GYhVFvS3uK1q4CkjTHzR+hUz
 Eu9K5ZAC6gFUv+7mrQ1WH9/ruNySBdv02By14O3g95nWkoP+WcaJVih0i0qb7T1CDFFY/Zc
 NJ3Ouz4/jk789eYwf6YoJB3PJROEDKg==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel2nmtao02p.internal.vadesecure.com with ngmta
 id a5a4b02c-1854f3e1fccff4b7; Wed, 23 Jul 2025 18:11:48 +0000
Message-ID: <3528db67-86b4-47af-b002-87a75bbdc4df@onemain.com>
Date: Wed, 23 Jul 2025 11:11:46 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] net: ionic: Create an auxiliary device for rdma
 driver
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
 leon@kernel.org, andrew+netdev@lunn.ch
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-2-abhijit.gangurde@amd.com>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20250723173149.2568776-2-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/23/25 10:31 AM, Abhijit Gangurde wrote:
> To support RDMA capable ethernet device, create an auxiliary device in
> the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
> device to the Ethernet device.
>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>   drivers/net/ethernet/pensando/Kconfig         |  1 +
>   drivers/net/ethernet/pensando/ionic/Makefile  |  2 +-
>   .../net/ethernet/pensando/ionic/ionic_api.h   | 21 ++++
>   .../net/ethernet/pensando/ionic/ionic_aux.c   | 95 +++++++++++++++++++
>   .../net/ethernet/pensando/ionic/ionic_aux.h   | 10 ++
>   .../ethernet/pensando/ionic/ionic_bus_pci.c   |  5 +
>   .../net/ethernet/pensando/ionic/ionic_lif.c   |  7 ++
>   .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +
>   8 files changed, 143 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.h
>   create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.c
>   create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.h

Hi Abhijit,

It occurred to me that there should be some discussion added into the 
ionic.rst file about this new auxiliary_device support.  You might look 
in the amd/pds_core.rst and mellanox/mlx5/switchdev.rst files for 
similar examples.  This perhaps isn't a blocker for this patchset, but 
should be planned soon, or added if you do another rev for other reasons.

(In a similar vein, the pds_core.rst should be updated for the new 
pds_core.fwctl auxiliary_device, but that's a different problem)

sln


>
> diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ethernet/pensando/Kconfig
> index 01fe76786f77..c99758adf3ad 100644
> --- a/drivers/net/ethernet/pensando/Kconfig
> +++ b/drivers/net/ethernet/pensando/Kconfig
> @@ -24,6 +24,7 @@ config IONIC
>   	select NET_DEVLINK
>   	select DIMLIB
>   	select PAGE_POOL
> +	select AUXILIARY_BUS
>   	help
>   	  This enables the support for the Pensando family of Ethernet
>   	  adapters.  More specific information on this driver can be
> diff --git a/drivers/net/ethernet/pensando/ionic/Makefile b/drivers/net/ethernet/pensando/ionic/Makefile
> index 4e7642a2d25f..a598972fef41 100644
> --- a/drivers/net/ethernet/pensando/ionic/Makefile
> +++ b/drivers/net/ethernet/pensando/ionic/Makefile
> @@ -5,5 +5,5 @@ obj-$(CONFIG_IONIC) := ionic.o
>   
>   ionic-y := ionic_main.o ionic_bus_pci.o ionic_devlink.o ionic_dev.o \
>   	   ionic_debugfs.o ionic_lif.o ionic_rx_filter.o ionic_ethtool.o \
> -	   ionic_txrx.o ionic_stats.o ionic_fw.o
> +	   ionic_txrx.o ionic_stats.o ionic_fw.o ionic_aux.o
>   ionic-$(CONFIG_PTP_1588_CLOCK) += ionic_phc.o
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
> new file mode 100644
> index 000000000000..f9fcd1b67b35
> --- /dev/null
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#ifndef _IONIC_API_H_
> +#define _IONIC_API_H_
> +
> +#include <linux/auxiliary_bus.h>
> +
> +/**
> + * struct ionic_aux_dev - Auxiliary device information
> + * @lif:        Logical interface
> + * @idx:        Index identifier
> + * @adev:       Auxiliary device
> + */
> +struct ionic_aux_dev {
> +	struct ionic_lif *lif;
> +	int idx;
> +	struct auxiliary_device adev;
> +};
> +
> +#endif /* _IONIC_API_H_ */
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
> new file mode 100644
> index 000000000000..781218c3feba
> --- /dev/null
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#include <linux/kernel.h>
> +#include "ionic.h"
> +#include "ionic_lif.h"
> +#include "ionic_aux.h"
> +
> +static DEFINE_IDA(aux_ida);
> +
> +static void ionic_auxbus_release(struct device *dev)
> +{
> +	struct ionic_aux_dev *ionic_adev;
> +
> +	ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
> +	kfree(ionic_adev);
> +}
> +
> +int ionic_auxbus_register(struct ionic_lif *lif)
> +{
> +	struct ionic_aux_dev *ionic_adev;
> +	struct auxiliary_device *aux_dev;
> +	int err, id;
> +
> +	if (!(le64_to_cpu(lif->ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA))
> +		return 0;
> +
> +	ionic_adev = kzalloc(sizeof(*ionic_adev), GFP_KERNEL);
> +	if (!ionic_adev)
> +		return -ENOMEM;
> +
> +	aux_dev = &ionic_adev->adev;
> +
> +	id = ida_alloc_range(&aux_ida, 0, INT_MAX, GFP_KERNEL);
> +	if (id < 0) {
> +		dev_err(lif->ionic->dev, "Failed to allocate aux id: %d\n",
> +			id);
> +		err = id;
> +		goto err_adev_free;
> +	}
> +
> +	aux_dev->id = id;
> +	aux_dev->name = "rdma";
> +	aux_dev->dev.parent = &lif->ionic->pdev->dev;
> +	aux_dev->dev.release = ionic_auxbus_release;
> +	ionic_adev->lif = lif;
> +	err = auxiliary_device_init(aux_dev);
> +	if (err) {
> +		dev_err(lif->ionic->dev, "Failed to initialize %s aux device: %d\n",
> +			aux_dev->name, err);
> +		goto err_ida_free;
> +	}
> +
> +	err = auxiliary_device_add(aux_dev);
> +	if (err) {
> +		dev_err(lif->ionic->dev, "Failed to add %s aux device: %d\n",
> +			aux_dev->name, err);
> +		goto err_aux_uninit;
> +	}
> +
> +	lif->ionic_adev = ionic_adev;
> +
> +	return 0;
> +
> +err_aux_uninit:
> +	auxiliary_device_uninit(aux_dev);
> +err_ida_free:
> +	ida_free(&aux_ida, id);
> +err_adev_free:
> +	kfree(ionic_adev);
> +
> +	return err;
> +}
> +
> +void ionic_auxbus_unregister(struct ionic_lif *lif)
> +{
> +	struct auxiliary_device *aux_dev;
> +	int id;
> +
> +	mutex_lock(&lif->adev_lock);
> +	if (!lif->ionic_adev)
> +		goto out;
> +
> +	aux_dev = &lif->ionic_adev->adev;
> +	id = aux_dev->id;
> +
> +	auxiliary_device_delete(aux_dev);
> +	auxiliary_device_uninit(aux_dev);
> +	ida_free(&aux_ida, id);
> +
> +	lif->ionic_adev = NULL;
> +
> +out:
> +	mutex_unlock(&lif->adev_lock);
> +}
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.h b/drivers/net/ethernet/pensando/ionic/ionic_aux.h
> new file mode 100644
> index 000000000000..f5528a9f187d
> --- /dev/null
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
> +
> +#ifndef _IONIC_AUX_H_
> +#define _IONIC_AUX_H_
> +
> +int ionic_auxbus_register(struct ionic_lif *lif);
> +void ionic_auxbus_unregister(struct ionic_lif *lif);
> +
> +#endif /* _IONIC_AUX_H_ */
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 4c377bdc62c8..bb75044dfb82 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -9,6 +9,7 @@
>   #include "ionic.h"
>   #include "ionic_bus.h"
>   #include "ionic_lif.h"
> +#include "ionic_aux.h"
>   #include "ionic_debugfs.h"
>   
>   /* Supported devices */
> @@ -375,6 +376,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		goto err_out_deregister_devlink;
>   	}
>   
> +	ionic_auxbus_register(ionic->lif);
> +
>   	mod_timer(&ionic->watchdog_timer,
>   		  round_jiffies(jiffies + ionic->watchdog_period));
>   	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
> @@ -415,6 +418,7 @@ static void ionic_remove(struct pci_dev *pdev)
>   
>   		if (ionic->lif->doorbell_wa)
>   			cancel_delayed_work_sync(&ionic->doorbell_check_dwork);
> +		ionic_auxbus_unregister(ionic->lif);
>   		ionic_lif_unregister(ionic->lif);
>   		ionic_devlink_unregister(ionic);
>   		ionic_lif_deinit(ionic->lif);
> @@ -444,6 +448,7 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
>   	timer_delete_sync(&ionic->watchdog_timer);
>   	cancel_work_sync(&lif->deferred.work);
>   
> +	ionic_auxbus_unregister(ionic->lif);
>   	mutex_lock(&lif->queue_lock);
>   	ionic_stop_queues_reconfig(lif);
>   	ionic_txrx_free(lif);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7707a9e53c43..146659f6862a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -19,6 +19,7 @@
>   #include "ionic_bus.h"
>   #include "ionic_dev.h"
>   #include "ionic_lif.h"
> +#include "ionic_aux.h"
>   #include "ionic_txrx.h"
>   #include "ionic_ethtool.h"
>   #include "ionic_debugfs.h"
> @@ -3293,6 +3294,7 @@ int ionic_lif_alloc(struct ionic *ionic)
>   
>   	mutex_init(&lif->queue_lock);
>   	mutex_init(&lif->config_lock);
> +	mutex_init(&lif->adev_lock);
>   
>   	spin_lock_init(&lif->adminq_lock);
>   
> @@ -3349,6 +3351,7 @@ int ionic_lif_alloc(struct ionic *ionic)
>   	lif->info = NULL;
>   	lif->info_pa = 0;
>   err_out_free_mutex:
> +	mutex_destroy(&lif->adev_lock);
>   	mutex_destroy(&lif->config_lock);
>   	mutex_destroy(&lif->queue_lock);
>   err_out_free_netdev:
> @@ -3384,6 +3387,7 @@ static void ionic_lif_handle_fw_down(struct ionic_lif *lif)
>   
>   	netif_device_detach(lif->netdev);
>   
> +	ionic_auxbus_unregister(ionic->lif);
>   	mutex_lock(&lif->queue_lock);
>   	if (test_bit(IONIC_LIF_F_UP, lif->state)) {
>   		dev_info(ionic->dev, "Surprise FW stop, stopping queues\n");
> @@ -3446,6 +3450,8 @@ int ionic_restart_lif(struct ionic_lif *lif)
>   	netif_device_attach(lif->netdev);
>   	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
>   
> +	ionic_auxbus_register(ionic->lif);
> +
>   	return 0;
>   
>   err_txrx_free:
> @@ -3532,6 +3538,7 @@ void ionic_lif_free(struct ionic_lif *lif)
>   
>   	mutex_destroy(&lif->config_lock);
>   	mutex_destroy(&lif->queue_lock);
> +	mutex_destroy(&lif->adev_lock);
>   
>   	/* free netdev & lif */
>   	ionic_debugfs_del_lif(lif);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> index e01756fb7fdd..43bdd0fb8733 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> @@ -10,6 +10,7 @@
>   #include <linux/dim.h>
>   #include <linux/pci.h>
>   #include "ionic_rx_filter.h"
> +#include "ionic_api.h"
>   
>   #define IONIC_ADMINQ_LENGTH	16	/* must be a power of two */
>   #define IONIC_NOTIFYQ_LENGTH	64	/* must be a power of two */
> @@ -225,6 +226,8 @@ struct ionic_lif {
>   	dma_addr_t info_pa;
>   	u32 info_sz;
>   	struct ionic_qtype_info qtype_info[IONIC_QTYPE_MAX];
> +	struct ionic_aux_dev *ionic_adev;
> +	struct mutex adev_lock;	/* lock for aux_dev actions */
>   
>   	u8 rss_hash_key[IONIC_RSS_HASH_KEY_SIZE];
>   	u8 *rss_ind_tbl;


