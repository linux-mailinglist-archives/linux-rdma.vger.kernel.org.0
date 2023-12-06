Return-Path: <linux-rdma+bounces-287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD23807343
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EA81C20EB3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A533EA8C;
	Wed,  6 Dec 2023 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QPD/uklr"
X-Original-To: linux-rdma@vger.kernel.org
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 07:02:32 PST
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03456D47
	for <linux-rdma@vger.kernel.org>; Wed,  6 Dec 2023 07:02:31 -0800 (PST)
Message-ID: <08c5ccbe-1f9a-4e4d-b6bd-91ef62ef1b5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701874361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6evMIKmJlRyI2ZiHskvLdMud2JhVJZeooUPWJh9/SM=;
	b=QPD/uklrugfzfHQX+89qaTXRmkdeWeqSycEtQxp7/DxZV5YXW94sGnYrajoW7Jpy/fCjNl
	V3BqVmjaNIbY+jFhHUCcTn3IwjpLKS7RUi6VSVjeVgD0eWM+gaMzXPgT5khGf5vwxPhlPQ
	ozUl9eusNc0TyQt7OeduqoJ18qvkRH0=
Date: Wed, 6 Dec 2023 16:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Add EFA query MR support
Content-Language: en-US
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Anas Mousa <anasmous@amazon.com>,
 Firas Jahjah <firasj@amazon.com>
References: <20231205221606.26436-1-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20231205221606.26436-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Michael,

On 06/12/2023 0:16, Michael Margolin wrote:
> @@ -432,6 +435,9 @@ static int efa_ib_device_add(struct efa_dev *dev)
>  
>  	ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
>  
> +	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))

EFA depends on CONFIG_INFINIBAND_USER_ACCESS:

      7 config INFINIBAND_EFA
      8         tristate "Amazon Elastic Fabric Adapter (EFA) support"
      9         depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
     10         depends on INFINIBAND_USER_ACCESS

> +		dev->ibdev.driver_def = efa_uapi_defs;
> +
>  	err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
>  	if (err)
>  		goto err_destroy_eqs;
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 0f8ca99d0827..d81904f4b876 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -13,6 +13,9 @@
>  #include <rdma/ib_user_verbs.h>
>  #include <rdma/ib_verbs.h>
>  #include <rdma/uverbs_ioctl.h>
> +#define UVERBS_MODULE_NAME efa_ib
> +#include <rdma/uverbs_named_ioctl.h>
> +#include <rdma/ib_user_ioctl_cmds.h>
>  
>  #include "efa.h"
>  #include "efa_io_defs.h"
> @@ -1653,6 +1656,9 @@ static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
>  	mr->ibmr.lkey = result.l_key;
>  	mr->ibmr.rkey = result.r_key;
>  	mr->ibmr.length = length;
> +	mr->recv_pci_bus_id = result.recv_pci_bus_id;
> +	mr->rdma_read_pci_bus_id = result.rdma_read_pci_bus_id;
> +	mr->rdma_recv_pci_bus_id = result.rdma_recv_pci_bus_id;

Why is a query_mr ioctl better than returning this data through udata on
MR creation?

