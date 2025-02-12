Return-Path: <linux-rdma+bounces-7675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B3A325C3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 13:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEE07A2297
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A821D514C;
	Wed, 12 Feb 2025 12:22:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4BF4FA;
	Wed, 12 Feb 2025 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362943; cv=none; b=iKW4eDoIDfCpzwEM9aTII1oJ87pm1EGYv6lYzcW7awYN2haSKFZoMVOOFvBDixoNpn0xojS7Yy64AhXvE5HTv5S7tr4W8l6EDAMOh86yGxlXGCiZ7Riy2h1MVy1vi1L/ZeWdA4LqU6ot2Jf4o0mIhBKYp5dQbptlL6YbZ81YnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362943; c=relaxed/simple;
	bh=cCIJduEuJ3qTG4czoWe3x6ybI1Ydl1gfGQHplij7Lqo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9hPz62bvFZQBm2O5CuUt/yas+et7q/9IW8qDCZr8TaxJ4+iAg7s9j/tYEnmYWAYVtNh6TKkw78/72cJTfsmVyWSK7pcGOQ0DbM6phxsCA7BDfuhhXhJ/GzLk9fTdnhw/F2XCGJIz2wXEi5RxBlyKcorrVMORR+vn1Sbu82AUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtHTp54lkz6D8Y6;
	Wed, 12 Feb 2025 20:21:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5092C140441;
	Wed, 12 Feb 2025 20:22:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 13:22:17 +0100
Date: Wed, 12 Feb 2025 12:22:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <saeedm@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<brett.creeley@amd.com>
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
Message-ID: <20250212122215.000001a0@huawei.com>
In-Reply-To: <20250211234854.52277-4-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
	<20250211234854.52277-4-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:48:52 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
> devices.  This sets up a simple auxiliary_bus driver that registers
> with fwctl subsystem.  It expects that a pds_core device has set up
> the auxiliary_device pds_core.fwctl
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
Hi Shannon,
A few comments inline

Jonathan



> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> new file mode 100644
> index 000000000000..24979fe0deea
> --- /dev/null
> +++ b/drivers/fwctl/pds/main.c
> @@ -0,0 +1,195 @@

> +
> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
> +{
> +	struct device *dev = &pdsfc->fwctl.dev;
> +	union pds_core_adminq_comp comp = {0};
> +	union pds_core_adminq_cmd cmd = {0};
> +	struct pds_fwctl_ident *ident;
> +	dma_addr_t ident_pa;
> +	int err = 0;
> +
> +	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
> +	err = dma_mapping_error(dev->parent, ident_pa);
> +	if (err) {
> +		dev_err(dev, "Failed to map ident\n");
> +		return err;
> +	}
> +
> +	cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
> +	cmd.fwctl_ident.version = 0;
> +	cmd.fwctl_ident.len = cpu_to_le32(sizeof(*ident));
> +	cmd.fwctl_ident.ident_pa = cpu_to_le64(ident_pa);

Could save intializing cmd above and do it here where all
the data is available.

	cmd = (union pds_core_adminq_cmd) {
		.fwctl_ident = {
			.opcode = ...
etc. Up to you.


	}
> +
> +	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
> +	if (err) {
> +		dma_free_coherent(dev->parent, PAGE_SIZE, ident, ident_pa);
> +		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
> +			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
> +		return err;
> +	}
> +
> +	pdsfc->ident = ident;
> +	pdsfc->ident_pa = ident_pa;

I guess it will become clear in later patches, but I'm not immediately sure why
it makes sense to keep a copy of ident and the dma mappings live etc.
Does it change at runtime?


> +
> +	dev_dbg(dev, "ident: version %u max_req_sz %u max_resp_sz %u max_req_sg_elems %u max_resp_sg_elems %u\n",
> +		ident->version, ident->max_req_sz, ident->max_resp_sz,
> +		ident->max_req_sg_elems, ident->max_resp_sg_elems);
> +
> +	return 0;
> +}

> +static int pdsfc_probe(struct auxiliary_device *adev,
> +		       const struct auxiliary_device_id *id)
> +{
> +	struct pdsfc_dev *pdsfc __free(pdsfc_dev);
Convention for these is to put the constructor and destructor definitions
on one line.  I'm too lazy to find the email from Linus where he
specified this but Dan did add docs to cleanup.h.
https://elixir.bootlin.com/linux/v6.14-rc2/source/include/linux/cleanup.h#L129
is referring to setting this to NULL, which is minimum that should be done
as future code changes might mean there is a failure path between
declaration and use.  Anyhow, it argues in favor of inline as shown
below.


> +	struct pds_auxiliary_dev *padev;
> +	struct device *dev = &adev->dev;
> +	int err = 0;
Set in all paths where it is used so no need to set it here.

> +
> +	padev = container_of(adev, struct pds_auxiliary_dev, aux_dev);
	struct pdsfc_dev *pdsfc __free(pdsfc_dev) = 
 		fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
> +				   struct pdsfc_dev, fwctl);
> +	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
> +				   struct pdsfc_dev, fwctl);
> +	if (!pdsfc) {
> +		dev_err(dev, "Failed to allocate fwctl device struct\n");
> +		return -ENOMEM;
> +	}
> +	pdsfc->padev = padev;
> +
> +	err = pdsfc_identify(pdsfc);
> +	if (err) {
> +		dev_err(dev, "Failed to identify device, err %d\n", err);
> +		return err;

Perhaps use return dev_err_probe() just to get the pretty printing.
Note though that it won't print for enomem cases.

> +	}
> +
> +	err = fwctl_register(&pdsfc->fwctl);
> +	if (err) {
> +		dev_err(dev, "Failed to register device, err %d\n", err);
> +		return err;
> +	}
> +
> +	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
> +
> +	return 0;
> +
> +free_ident:

Nothing goes here. Which is good as missing __free magic with gotos
is a recipe for pain.

> +	pdsfc_free_ident(pdsfc);
> +	return err;
> +}
> +
> +static void pdsfc_remove(struct auxiliary_device *adev)
> +{
> +	struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
> +
> +	fwctl_unregister(&pdsfc->fwctl);
> +	pdsfc_free_ident(pdsfc);
> +}

> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
> index 4b4e9a98b37b..7fc353b63353 100644
> --- a/include/linux/pds/pds_adminq.h
> +++ b/include/linux/pds/pds_adminq.h
> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>  	u8     status;
>  };
>  
> +enum pds_fwctl_cmd_opcode {
> +	PDS_FWCTL_CMD_IDENT		= 70,
> +};
> +
> +/**
> + * struct pds_fwctl_cmd - Firmware control command structure
> + * @opcode: Opcode
> + * @rsvd:   Word boundary padding
> + * @ep:     Endpoint identifier.
> + * @op:     Operation identifier.
> + */
> +struct pds_fwctl_cmd {
> +	u8     opcode;
> +	u8     rsvd[3];
> +	__le32 ep;
> +	__le32 op;
> +} __packed;
None of these actually need to be packed given explicit padding to
natural alignment of all fields.  Arguably it does no harm though
so up to you.

> +
> +/**
> + * struct pds_fwctl_comp - Firmware control completion structure
> + * @status:     Status of the firmware control operation
> + * @rsvd:       Word boundary padding
> + * @comp_index: Completion index in little-endian format
> + * @rsvd2:      Word boundary padding
> + * @color:      Color bit indicating the state of the completion
> + */
> +struct pds_fwctl_comp {
> +	u8     status;
> +	u8     rsvd;
> +	__le16 comp_index;
> +	u8     rsvd2[11];
> +	u8     color;
> +} __packed;


