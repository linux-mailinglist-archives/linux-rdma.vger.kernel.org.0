Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC95A492661
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 14:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbiARNDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 08:03:50 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58428 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241428AbiARNDu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 08:03:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V2CR6za_1642511027;
Received: from 30.43.105.202(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2CR6za_1642511027)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:03:48 +0800
Message-ID: <adcb2e8f-4383-bc54-b4ac-1e41cbdd8a3a@linux.alibaba.com>
Date:   Tue, 18 Jan 2022 21:03:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-10-chengyou@linux.alibaba.com>
 <20220117152217.GD8034@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220117152217.GD8034@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/17/22 11:22 PM, Jason Gunthorpe wrote:
> On Mon, Jan 17, 2022 at 04:48:26PM +0800, Cheng Xu wrote:
>> Add the main erdma module and debugfs files. The main module provides
>> interface to infiniband subsytem, and the debugfs module provides a way
>> to allow user can get the core status of the device and set the preferred
>> congestion control algorithm.
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>   drivers/infiniband/hw/erdma/erdma_main.c | 707 +++++++++++++++++++++++
>>   1 file changed, 707 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
>>
>> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
>> new file mode 100644
>> index 000000000000..e35902a145b3
>> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
>> @@ -0,0 +1,707 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +
>> +/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
>> +/*          Kai Shen <kaishen@linux.alibaba.com> */
>> +/* Copyright (c) 2020-2022, Alibaba Group. */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/pci.h>
>> +#include <net/addrconf.h>
>> +#include <rdma/erdma-abi.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/ib_user_verbs.h>
>> +
>> +#include "erdma.h"
>> +#include "erdma_cm.h"
>> +#include "erdma_hw.h"
>> +#include "erdma_verbs.h"
>> +
>> +#define DESC __stringify(ElasticRDMA(iWarp) Driver)
>> +
>> +MODULE_AUTHOR("Alibaba");
>> +MODULE_DESCRIPTION(DESC);
>> +MODULE_LICENSE("GPL v2");
>> +
>> +/*Common string that is matched to accept the device by the user library*/
>> +#define ERDMA_NODE_DESC_COMMON "Elastic RDMA(iWARP) stack"
>> +
>> +static struct list_head erdma_dev_list = LIST_HEAD_INIT(erdma_dev_list);
>> +static DEFINE_MUTEX(erdma_dev_mutex);
> 
> No lists of devices in drivers. Use the core code to do it.
> 
>> +static int erdma_newlink(const char *dev_name, struct net_device *netdev)
>> +{
>> +	struct ib_device *ibdev;
>> +	struct erdma_pci_drvdata *drvdata, *tmp;
>> +	struct erdma_dev *dev;
>> +	int ret;
>> +
>> +	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_ERDMA);
>> +	if (ibdev) {
>> +		ib_device_put(ibdev);
>> +		return -EEXIST;
>> +	}
>> +
>> +	list_for_each_entry_safe(drvdata, tmp, &erdma_dev_list, list) {
>> +		if (erdma_netdev_matched_edev(netdev, drvdata) && !drvdata->is_registered) {
>> +			dev = erdma_ib_device_create(drvdata, netdev);
>> +			if (IS_ERR(dev)) {
>> +				pr_info("add device failed\n");
>> +				return PTR_ERR(dev);
>> +			}
>> +
>> +			if (netif_running(netdev) && netif_carrier_ok(netdev))
>> +				dev->state = IB_PORT_ACTIVE;
>> +			else
>> +				dev->state = IB_PORT_DOWN;
>> +
>> +			ret = erdma_device_register(dev, dev_name);
>> +			if (ret) {
>> +				ib_dealloc_device(&dev->ibdev);
>> +				return ret;
>> +			}
>> +
>> +			drvdata->is_registered = 1;
>> +			drvdata->dev = dev;
>> +
>> +			return 0;
>> +		}
>> +	}
> 
> Leaks a ibdev reference
> 
>> +static int erdma_probe_dev(struct pci_dev *pdev)
>> +{
>> +	int err;
>> +	struct erdma_pci_drvdata *drvdata;
>> +	u32 version;
>> +	int bars;
>> +
>> +	err = pci_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "pci_enable_device failed(%d)\n", err);
>> +		return err;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +
>> +	drvdata = kcalloc(1, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata) {
>> +		err = -ENOMEM;
>> +		goto err_disable_device;
>> +	}
>> +
>> +	pci_set_drvdata(pdev, drvdata);
> 
> No, the drvdata should be the struct that has the ibdevice, do not
> have two structs like this.
> 
> The only use of drvdata should be in the remove function.
> 
>> +static int erdma_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> +{
>> +	return erdma_probe_dev(pdev);
>> +}
> 
> Don't make wrappers like this..
> 
>> +static void erdma_remove(struct pci_dev *pdev)
>> +{
>> +	struct erdma_pci_drvdata *drvdata = pci_get_drvdata(pdev);
>> +
>> +	if (drvdata->is_registered) {
>> +		ib_unregister_device(&drvdata->dev->ibdev);
>> +		drvdata->is_registered = 0;
>> +	}
>> +
>> +	erdma_remove_dev(pdev);
>> +}
> 
> Or this
> 
>> +static __init int erdma_init_module(void)
>> +{
>> +	int ret;
>> +
>> +	ret = erdma_cm_init();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pci_register_driver(&erdma_pci_driver);
>> +	if (ret) {
>> +		pr_err("Couldn't register erdma driver.\n");
>> +		goto uninit_cm;
>> +	}
>> +
>> +	ret = register_netdevice_notifier(&erdma_netdev_nb);
>> +	if (ret)
>> +		goto unregister_driver;
> 
> And notifiers should not be registered without devices.
> 
>> +static void __exit erdma_exit_module(void)
>> +{
>> +	rdma_link_unregister(&erdma_link_ops);
>> +	ib_unregister_driver(RDMA_DRIVER_ERDMA);
> 
> A PCI driver should not call this function, this is all messed up
> because you are trying to dynamically create a PCI functions IB
> device.
> 
> The PCI function should always create the IB device, and it may remain
> in some inoperating state (eg no GID table entries) until the pair'd
> netdev is found, and the lifecycle of the IB device should always
> follow the PCI device.
> 
> Jason

Hi, Jason,

I have tried this without devices list in our code (which you
mentioned above), and met some problems. I would be really grateful if
you could take the time to review this again.

Before calling ib_register_device(), the driver must call 
ib_device_set_netdev(), otherwise ib_register_device() will failed
due to NULL netdev in ib_device structure, the call stack is:

ib_register_device -> ib_cache_setup_one -> ib_cache_update ->
ib_query_port -> iw_query_port

This prevents calling ib_register_device() in PCI probe function. The 
pair'd netdev is found in rdma link command, and we should call
ib_register_device() in rdma_link_ops.newlink(). So, in newlink(), we
need finding out the pair'd IB deivce (allocated by ib_alloc_device()
in PCI probe function). To achieve this, the driver should maintain
a list or something else.

If I can use a deivces list in our code (maintain the unregistered
devices), this can solved, and the init flow looks like this:

     In PCI probe:
           Init PCI device, call ib_alloc_device(), init most parts of ib
           device, add to list.
     In newlink:
           Find the pair'd ib_device, remove from the list, call
           ib_register_device().

Thanks,
Cheng Xu

