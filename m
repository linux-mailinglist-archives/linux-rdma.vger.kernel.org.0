Return-Path: <linux-rdma+bounces-8295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638ACA4D667
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 09:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29B21749EC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5A1F91F6;
	Tue,  4 Mar 2025 08:30:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023341FBE8A;
	Tue,  4 Mar 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077058; cv=none; b=Lg1PhtQJh0aArvHeRmVcmCQ/kGNPRp1p+H9fLTZuO9Z5iw8f6XORM+7RUxraGaySSp64CFB2gYA2FVDnwPL+IbYt+mVvap+6bS21ZpFqBewcKMoVdolDvm3dpPn4OdEizwMSzXVzXI03ob/Erb4Nx7esb7XICkTGQRlGIyULou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077058; c=relaxed/simple;
	bh=kr6ObC/6QXZsMC2qaGjs8lfNLbpivFo5meVDtPvojnQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dejdahl4xQoLs58IAEMwC0UL/5fXcgzAXVdtUbn/1EihiuhXLF2rM9cK/5gw6tW3Eo3ayYfKwDD9c35f1+ng1Zcl4d9BiC5tmh7vpyC+J1xgraGRRWcAo/tbjG/FYBEC96STN1tNg1UGAN4M6aJnht9JhMHu6rK79hdevLmko80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6TMd6CBQz6H8Yb;
	Tue,  4 Mar 2025 16:27:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 36046140390;
	Tue,  4 Mar 2025 16:30:53 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 09:30:47 +0100
Date: Tue, 4 Mar 2025 16:30:43 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
	<brett.creeley@amd.com>
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
Message-ID: <20250304163043.00006b34@huawei.com>
In-Reply-To: <20250301013554.49511-5-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
	<20250301013554.49511-5-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Feb 2025 17:35:52 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
> devices.  This sets up a simple auxiliary_bus driver that registers
> with fwctl subsystem.  It expects that a pds_core device has set up
> the auxiliary_device pds_core.fwctl
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
A few minor comments inline,

> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
> new file mode 100644
> index 000000000000..afc7dc283ad5
> --- /dev/null
> +++ b/drivers/fwctl/pds/main.c
> @@ -0,0 +1,169 @@
> +struct pdsfc_dev {
> +	struct fwctl_device fwctl;
> +	struct pds_auxiliary_dev *padev;
> +	struct pdsc *pdsc;

Not used in this patch that I can see.  I was curious why it is
here as I would expect that to match with the padev parent.

> +	u32 caps;
> +	struct pds_fwctl_ident ident;
> +};
> +DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));


> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
> +	struct fwctl_info_pds *info;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->uctx_caps = pdsfc_uctx->uctx_caps;

What about the UID? If it is always zero, what is it for?

> +
> +	return info;
> +}

> +/**
> + * struct pds_fwctl_comp - Firmware control completion structure
> + * @status:     Status of the firmware control operation
> + * @rsvd:       Word boundary padding
> + * @comp_index: Completion index in little-endian format
> + * @rsvd2:      Word boundary padding

11 bytes is some extreme word padding.  I'd just call it reserved
space.

> + * @color:      Color bit indicating the state of the completion
> + */
> +struct pds_fwctl_comp {
> +	u8     status;
> +	u8     rsvd;
> +	__le16 comp_index;
> +	u8     rsvd2[11];
> +	u8     color;
> +} __packed;

...

> +/**
> + * struct pds_fwctl_ident - Firmware control identification structure
> + * @features:    Supported features

Nice to have some defines or similar that give meaning to these
features, but maybe that comes in later patches.

> + * @version:     Interface version
> + * @rsvd:        Word boundary padding

word size seems to be varying between structures. I'd just document
it as "reserved"

> + * @max_req_sz:  Maximum request size
> + * @max_resp_sz: Maximum response size
> + * @max_req_sg_elems:  Maximum number of request SGs
> + * @max_resp_sg_elems: Maximum number of response SGs
> + */
> +struct pds_fwctl_ident {
> +	__le64 features;
> +	u8     version;
> +	u8     rsvd[3];
> +	__le32 max_req_sz;
> +	__le32 max_resp_sz;
> +	u8     max_req_sg_elems;
> +	u8     max_resp_sg_elems;
> +} __packed;

Jonathan

