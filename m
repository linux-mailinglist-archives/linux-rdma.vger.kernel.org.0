Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE81490B51
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiAQPWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 10:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiAQPWU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jan 2022 10:22:20 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A7AC061574
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 07:22:19 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id j85so19903894qke.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jan 2022 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQzfC+uQyF2wh0I/QtyCX62mK+bzVkofszrA2S+O/6c=;
        b=ED/xt7MdIlBGFwQpHTImc2QGMWSBkHXPKjW9+IG+ZE0AK2UztFTexswreD5vrNZ2eR
         Gbek1DUGI5lEyS34RpA3sWmB9DtwytS2t5eut7AnpwGP2TRV/NGRZbRF5myHnfKCxN2C
         uBNF+kmwwCRNUIVMttysfC7B2XU5kPfr5z3WiuZ9u/oVtj7E3oVD7enynZTUhLl7Lo1K
         zzhX48O1s+orxyN15ki/Qmw3gdxMKgcyTl4JbZ+0VyovXayxqzAsFim3hUPzViDaW+Rb
         9cFzn5DrhvZg8N91GPxcbVYaQSbxwJpdg2iPqOZDow7CousiBe/SHsyGBAkyOl1E1x8H
         OeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQzfC+uQyF2wh0I/QtyCX62mK+bzVkofszrA2S+O/6c=;
        b=cStf4GkoKHfskJ89UnARLd9P1qyOBZLKoExkJWx+rIs9Iwe8F3eEAbPZVBp1urIlpo
         txjghw5ThYSVn57ydKzheUjh9lY4FrQqw6HZzVHOwaAjDvoEgQhxqyA5zlyH1soqWfpB
         RBTsFg2QN/Z264jj39RoBxCFVlC2wTmAE44QmMq/fITXnCWStLT7TRrtHha2sK30i7jh
         jjCQFnlCVOEhjjpkguyHcwn5xPKL5GRtKJb3E77h0opkzq1RAadV+yebUaK6ozfC20ZP
         I+D2SYu261+A5v4ZR74YJBCyHjMsgFbGcw7/DPeYLUc5e1NmZ0+06asQ6oRYtUMAMyVM
         ga9g==
X-Gm-Message-State: AOAM532y7MtJl+un2VxBWIrvfXcjwKi/y93jQ56GHBIqJPnt8xrbjHpS
        n3FrrB92WpmPSPQvg2hP5TU4ASCmi79P2w==
X-Google-Smtp-Source: ABdhPJwDro/zljY+8ITve4EEQ3It1kxXM5KwO0sfylQKEypz+V06tdEM8N/Z1NxTpd/HWVL/YKhD3Q==
X-Received: by 2002:a37:9e95:: with SMTP id h143mr14957677qke.50.1642432939042;
        Mon, 17 Jan 2022 07:22:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v7sm8699835qkp.30.2022.01.17.07.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:22:18 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9Tpp-000MX9-Sd; Mon, 17 Jan 2022 11:22:17 -0400
Date:   Mon, 17 Jan 2022 11:22:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Message-ID: <20220117152217.GD8034@ziepe.ca>
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-10-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117084828.80638-10-chengyou@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 17, 2022 at 04:48:26PM +0800, Cheng Xu wrote:
> Add the main erdma module and debugfs files. The main module provides
> interface to infiniband subsytem, and the debugfs module provides a way
> to allow user can get the core status of the device and set the preferred
> congestion control algorithm.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>  drivers/infiniband/hw/erdma/erdma_main.c | 707 +++++++++++++++++++++++
>  1 file changed, 707 insertions(+)
>  create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> new file mode 100644
> index 000000000000..e35902a145b3
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -0,0 +1,707 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +
> +/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
> +/*          Kai Shen <kaishen@linux.alibaba.com> */
> +/* Copyright (c) 2020-2022, Alibaba Group. */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +#include <net/addrconf.h>
> +#include <rdma/erdma-abi.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/ib_user_verbs.h>
> +
> +#include "erdma.h"
> +#include "erdma_cm.h"
> +#include "erdma_hw.h"
> +#include "erdma_verbs.h"
> +
> +#define DESC __stringify(ElasticRDMA(iWarp) Driver)
> +
> +MODULE_AUTHOR("Alibaba");
> +MODULE_DESCRIPTION(DESC);
> +MODULE_LICENSE("GPL v2");
> +
> +/*Common string that is matched to accept the device by the user library*/
> +#define ERDMA_NODE_DESC_COMMON "Elastic RDMA(iWARP) stack"
> +
> +static struct list_head erdma_dev_list = LIST_HEAD_INIT(erdma_dev_list);
> +static DEFINE_MUTEX(erdma_dev_mutex);

No lists of devices in drivers. Use the core code to do it.

> +static int erdma_newlink(const char *dev_name, struct net_device *netdev)
> +{
> +	struct ib_device *ibdev;
> +	struct erdma_pci_drvdata *drvdata, *tmp;
> +	struct erdma_dev *dev;
> +	int ret;
> +
> +	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_ERDMA);
> +	if (ibdev) {
> +		ib_device_put(ibdev);
> +		return -EEXIST;
> +	}
> +
> +	list_for_each_entry_safe(drvdata, tmp, &erdma_dev_list, list) {
> +		if (erdma_netdev_matched_edev(netdev, drvdata) && !drvdata->is_registered) {
> +			dev = erdma_ib_device_create(drvdata, netdev);
> +			if (IS_ERR(dev)) {
> +				pr_info("add device failed\n");
> +				return PTR_ERR(dev);
> +			}
> +
> +			if (netif_running(netdev) && netif_carrier_ok(netdev))
> +				dev->state = IB_PORT_ACTIVE;
> +			else
> +				dev->state = IB_PORT_DOWN;
> +
> +			ret = erdma_device_register(dev, dev_name);
> +			if (ret) {
> +				ib_dealloc_device(&dev->ibdev);
> +				return ret;
> +			}
> +
> +			drvdata->is_registered = 1;
> +			drvdata->dev = dev;
> +
> +			return 0;
> +		}
> +	}

Leaks a ibdev reference

> +static int erdma_probe_dev(struct pci_dev *pdev)
> +{
> +	int err;
> +	struct erdma_pci_drvdata *drvdata;
> +	u32 version;
> +	int bars;
> +
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "pci_enable_device failed(%d)\n", err);
> +		return err;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	drvdata = kcalloc(1, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata) {
> +		err = -ENOMEM;
> +		goto err_disable_device;
> +	}
> +
> +	pci_set_drvdata(pdev, drvdata);

No, the drvdata should be the struct that has the ibdevice, do not
have two structs like this.

The only use of drvdata should be in the remove function.

> +static int erdma_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	return erdma_probe_dev(pdev);
> +}

Don't make wrappers like this..

> +static void erdma_remove(struct pci_dev *pdev)
> +{
> +	struct erdma_pci_drvdata *drvdata = pci_get_drvdata(pdev);
> +
> +	if (drvdata->is_registered) {
> +		ib_unregister_device(&drvdata->dev->ibdev);
> +		drvdata->is_registered = 0;
> +	}
> +
> +	erdma_remove_dev(pdev);
> +}

Or this

> +static __init int erdma_init_module(void)
> +{
> +	int ret;
> +
> +	ret = erdma_cm_init();
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_register_driver(&erdma_pci_driver);
> +	if (ret) {
> +		pr_err("Couldn't register erdma driver.\n");
> +		goto uninit_cm;
> +	}
> +
> +	ret = register_netdevice_notifier(&erdma_netdev_nb);
> +	if (ret)
> +		goto unregister_driver;

And notifiers should not be registered without devices.

> +static void __exit erdma_exit_module(void)
> +{
> +	rdma_link_unregister(&erdma_link_ops);
> +	ib_unregister_driver(RDMA_DRIVER_ERDMA);

A PCI driver should not call this function, this is all messed up
because you are trying to dynamically create a PCI functions IB
device.

The PCI function should always create the IB device, and it may remain
in some inoperating state (eg no GID table entries) until the pair'd
netdev is found, and the lifecycle of the IB device should always
follow the PCI device.

Jason
