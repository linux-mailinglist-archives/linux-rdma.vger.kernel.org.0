Return-Path: <linux-rdma+bounces-3073-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8DA904DC6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5A11C239EA
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340616D304;
	Wed, 12 Jun 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2mSFth+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80541FB5;
	Wed, 12 Jun 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180110; cv=none; b=u0i0v7yXJXX6iGCQyBSp+h0Cx5ZjfeSFvf1rUpbadkZ5MN/CWiydZyThDOyM6d3Qg20BswOuQTknFoeNo5MeqM6Nxds4y8B+Nont5LrP0kr4RkjxQ0xWdYgtTn9D9NXkj4yXWyTdOfDC1FJltGONozhVs+qrLth9D6OZS3MPRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180110; c=relaxed/simple;
	bh=ptjoa9q63pGOGPnQ/n0kmQAoJ+aCRDrxJ5Ou5lbiPV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGk7endYihD4kQ32BRhgHs2sT/44diPPDMHy4xgbam7YopSGqAbZhf9L0AFNjGRko3FIsIJUgvdQHrBHxoeAMd50AYg5zeU4Nqd5J/g8QeQkZmCXzVdUnyLqtkJlkCxFlFgO9p0SM+U8pdnHimGUiFGjtCD1JUOF7UsAABo8/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2mSFth+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f09eaf420so417015466b.3;
        Wed, 12 Jun 2024 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718180106; x=1718784906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXAjKTvBEAvP+svvitn9yofnK0X/5/4ahwWqCi/xEWA=;
        b=A2mSFth+Y5PxE1DZrMUgfZ5nEM+H423GMIfx96Zw53A9zr0ooe5mdXH61Lx/0RWP4T
         GCakmc3hKZ8opNFEFjkyZ3tLHLUWjDFSDwvUq/zdNlrPCOI6GbQzyOnzADPPizrXFB94
         1EP1RS4O1SYdPRiI4wygJKV9WqKta0CFOvzuXBzryLJlXv1MPmgy3/fTCEntkXzG1lyM
         ag+7yo2a8F26+EBib2cj092IrtFuCl7LvHBNk556hFX5TgjZRHIsCCW0OkYF90LefpwQ
         f7WjoVUcr+xXbOzHIuoeMRNPXAWSh2MlNU7pVEQoU/rGmV5XZmNSoRinWtz5kUB1nRpa
         N99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180106; x=1718784906;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXAjKTvBEAvP+svvitn9yofnK0X/5/4ahwWqCi/xEWA=;
        b=utDviaqCHf96x3jJa7DLRdfPwmcXLzLlrwl1eGwjZtm9IVY5FlfVIL/HKNBa4NjLR/
         9y5Pcq3nKuW190rPXG1myUn4kUQVQVKTy65REmCJePwuCvhs6McqW/Z6G+47r0hyCmnx
         Kv+ijqqHEHe2T94zv+ydVlEx/GmG3QYeWva715XBLnZEWoXqicCc8hB6eCoIqGKBlpLz
         yhFeMrkjE8XBTBpMtIqfKZ3Grg3B9ZSVn6dK+6thuIaD2eBzQgIIyzuYrvfIVDBuPCYg
         1blebGG5KzvHjXJBbByvyMlUEiBReY0wXMXTzikVKJXe2+AIJn3w47hMIPsUjW7PlsYL
         R4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXsHUO2ZVvlN0Kt2lYbpDVSeL9T2Q6i6EUlf86armZ5ORPcPc8e6zPzTJNW5e4z8A4ipusW1y6EUIsXrd2gTWeKUSnFZPqSHMbaXHVL4cUXPMsdX2I/cx7Hu+9fi7PTiTr/ICasxNI5Op64x60hdNZJk99xs9gdOlaDmLiM3AZ496ejcZlPsZnVdwAEsWPEZz20I0PFUNp96SH+g9Y=
X-Gm-Message-State: AOJu0YxzfGe4oiVceu60ruMHV7UVXM6enojBjxSYDUTwoxYC/UMydJGN
	3S+JQOnT/0W5hGp4VMKutP5Bkrw6qlhNpkIQOfnGFKoU7K3ZrJKw
X-Google-Smtp-Source: AGHT+IH2Jza44/FQ9SGdlIxn5PkVhcYbkPK2nXfzm1wPEO8f0NiF848hJKQFk5hzcZUj941+u9uWPw==
X-Received: by 2002:a17:907:f81:b0:a6f:1972:7fd with SMTP id a640c23a62f3a-a6f480272c3mr62515366b.67.1718180105733;
        Wed, 12 Jun 2024 01:15:05 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f212aed2esm8466666f8f.26.2024.06.12.01.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:15:05 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:15:03 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/6] auxbus: make to_auxiliary_drv accept and return a
 constant pointer
Message-ID: <20240612081503.GA8955@gmail.com>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
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
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>

On Tue, Jun 11, 2024 at 03:01:04PM +0200, Greg Kroah-Hartman wrote:
> In the quest to make struct device constant, start by making
> to_auziliary_drv() return a constant pointer so that drivers that call
> this can be fixed up before the driver core changes.
> 
> As the return type previously was not constant, also fix up all callers
> that were assuming that the pointer was not going to be a constant one
> in order to not break the build.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dave Ertman <david.m.ertman@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Bingbu Cao <bingbu.cao@intel.com>
> Cc: Tianshu Qiu <tian.shu.qiu@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: linux-media@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: linux-rdma@vger.kernel.org
> Cc: sound-open-firmware@alsa-project.org
> Cc: linux-sound@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/base/auxiliary.c                      | 8 ++++----
>  drivers/media/pci/intel/ipu6/ipu6-bus.h       | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/dev.c | 4 ++--
>  include/linux/auxiliary_bus.h                 | 2 +-
>  sound/soc/sof/sof-client.c                    | 4 ++--
>  7 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index d3a2c40c2f12..5832e31bb77b 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -180,7 +180,7 @@ static const struct auxiliary_device_id *auxiliary_match_id(const struct auxilia
>  static int auxiliary_match(struct device *dev, struct device_driver *drv)
>  {
>  	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
> -	struct auxiliary_driver *auxdrv = to_auxiliary_drv(drv);
> +	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(drv);
>  
>  	return !!auxiliary_match_id(auxdrv->id_table, auxdev);
>  }
> @@ -203,7 +203,7 @@ static const struct dev_pm_ops auxiliary_dev_pm_ops = {
>  
>  static int auxiliary_bus_probe(struct device *dev)
>  {
> -	struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
> +	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
>  	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
>  	int ret;
>  
> @@ -222,7 +222,7 @@ static int auxiliary_bus_probe(struct device *dev)
>  
>  static void auxiliary_bus_remove(struct device *dev)
>  {
> -	struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
> +	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
>  	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
>  
>  	if (auxdrv->remove)
> @@ -232,7 +232,7 @@ static void auxiliary_bus_remove(struct device *dev)
>  
>  static void auxiliary_bus_shutdown(struct device *dev)
>  {
> -	struct auxiliary_driver *auxdrv = NULL;
> +	const struct auxiliary_driver *auxdrv = NULL;
>  	struct auxiliary_device *auxdev;
>  
>  	if (dev->driver) {
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-bus.h b/drivers/media/pci/intel/ipu6/ipu6-bus.h
> index b26c6aee1621..bb4926dfdf08 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-bus.h
> +++ b/drivers/media/pci/intel/ipu6/ipu6-bus.h
> @@ -21,7 +21,7 @@ struct ipu6_buttress_ctrl;
>  
>  struct ipu6_bus_device {
>  	struct auxiliary_device auxdev;
> -	struct auxiliary_driver *auxdrv;
> +	const struct auxiliary_driver *auxdrv;
>  	const struct ipu6_auxdrv_data *auxdrv_data;
>  	struct list_head list;
>  	void *pdata;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index ba3fa1c2e5d9..b9e7d3e7b15d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -239,7 +239,7 @@ void bnxt_ulp_stop(struct bnxt *bp)
>  
>  		adev = &aux_priv->aux_dev;
>  		if (adev->dev.driver) {
> -			struct auxiliary_driver *adrv;
> +			const struct auxiliary_driver *adrv;
>  			pm_message_t pm = {};
>  
>  			adrv = to_auxiliary_drv(adev->dev.driver);
> @@ -277,7 +277,7 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
>  
>  		adev = &aux_priv->aux_dev;
>  		if (adev->dev.driver) {
> -			struct auxiliary_driver *adrv;
> +			const struct auxiliary_driver *adrv;
>  
>  			adrv = to_auxiliary_drv(adev->dev.driver);
>  			edev->en_state = bp->state;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 0f17fc1181d2..7341e7c4ef24 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2784,7 +2784,7 @@ static struct ice_pf *
>  ice_ptp_aux_dev_to_owner_pf(struct auxiliary_device *aux_dev)
>  {
>  	struct ice_ptp_port_owner *ports_owner;
> -	struct auxiliary_driver *aux_drv;
> +	const struct auxiliary_driver *aux_drv;
>  	struct ice_ptp *owner_ptp;
>  
>  	if (!aux_dev->dev.driver)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> index 47e7c2639774..9a79674d27f1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
> @@ -349,7 +349,7 @@ int mlx5_attach_device(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_priv *priv = &dev->priv;
>  	struct auxiliary_device *adev;
> -	struct auxiliary_driver *adrv;
> +	const struct auxiliary_driver *adrv;
>  	int ret = 0, i;
>  
>  	devl_assert_locked(priv_to_devlink(dev));
> @@ -406,7 +406,7 @@ void mlx5_detach_device(struct mlx5_core_dev *dev, bool suspend)
>  {
>  	struct mlx5_priv *priv = &dev->priv;
>  	struct auxiliary_device *adev;
> -	struct auxiliary_driver *adrv;
> +	const struct auxiliary_driver *adrv;
>  	pm_message_t pm = {};
>  	int i;
>  
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index de21d9d24a95..bdff7b85f2ae 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -203,7 +203,7 @@ static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
>  	return container_of(dev, struct auxiliary_device, dev);
>  }
>  
> -static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *drv)
> +static inline const struct auxiliary_driver *to_auxiliary_drv(const struct device_driver *drv)
>  {
>  	return container_of(drv, struct auxiliary_driver, driver);
>  }
> diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
> index 99f74def4ab6..5d6005a88e79 100644
> --- a/sound/soc/sof/sof-client.c
> +++ b/sound/soc/sof/sof-client.c
> @@ -357,7 +357,7 @@ EXPORT_SYMBOL_NS_GPL(sof_client_ipc4_find_module, SND_SOC_SOF_CLIENT);
>  
>  int sof_suspend_clients(struct snd_sof_dev *sdev, pm_message_t state)
>  {
> -	struct auxiliary_driver *adrv;
> +	const struct auxiliary_driver *adrv;
>  	struct sof_client_dev *cdev;
>  
>  	mutex_lock(&sdev->ipc_client_mutex);
> @@ -380,7 +380,7 @@ EXPORT_SYMBOL_NS_GPL(sof_suspend_clients, SND_SOC_SOF_CLIENT);
>  
>  int sof_resume_clients(struct snd_sof_dev *sdev)
>  {
> -	struct auxiliary_driver *adrv;
> +	const struct auxiliary_driver *adrv;
>  	struct sof_client_dev *cdev;
>  
>  	mutex_lock(&sdev->ipc_client_mutex);
> -- 
> 2.45.2
> 

