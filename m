Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4870A6EE14
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jul 2019 08:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfGTGzB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Jul 2019 02:55:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfGTGzB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Jul 2019 02:55:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03A546626494DDE4A0FD;
        Sat, 20 Jul 2019 14:54:59 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 20 Jul 2019
 14:54:56 +0800
From:   oulijun <oulijun@huawei.com>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>, <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: =?UTF-8?Q?=e3=80=90Question_for_srpt_in_kernel-4.14=e3=80=91?=
Message-ID: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
Date:   Sat, 20 Jul 2019 14:54:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Bart Van Assche & Doug Ledford
  I am targeting a problem about RoCE and SCSI over RDMA from srpt in kernel-4.14. When insmod srpt.ko and insmod hns-roce-hw-v2.ko, it will
report a warning in srpt_add_one:
  ib_srpt srpt_add_one(hns_0) failed.

  I am tracking the error from ib_cm_listen in srpt_add_one.I found it returned an error when doing server_id validation
the error code as follows:
  static int __ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id,
			  __be64 service_mask)
{
	struct cm_id_private *cm_id_priv, *cur_cm_id_priv;
	int ret = 0;

	service_mask = service_mask ? service_mask : ~cpu_to_be64(0);
	service_id &= service_mask;
	if ((service_id & IB_SERVICE_ID_AGN_MASK) == IB_CM_ASSIGN_SERVICE_ID &&
	    (service_id != IB_CM_ASSIGN_SERVICE_ID))
		return -EINVAL;
 	......
 }

static void srpt_add_one(struct ib_device *device)
{
	struct srpt_device *sdev;
	struct srpt_port *sport;
	int i;

	pr_debug("device = %p\n", device);

	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
	if (!sdev)
		goto err;

	sdev->device = device;
	mutex_init(&sdev->sdev_mutex);

	sdev->pd = ib_alloc_pd(device, 0);
	if (IS_ERR(sdev->pd))
		goto free_dev;

	sdev->lkey = sdev->pd->local_dma_lkey;

	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);

	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);

	if (!srpt_service_guid)
		srpt_service_guid = be64_to_cpu(device->node_guid);

	sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
	if (IS_ERR(sdev->cm_id))
		goto err_ring;

	/* print out target login information */
	pr_debug("Target login info: id_ext=%016llx,ioc_guid=%016llx,"
		 "pkey=ffff,service_id=%016llx\n", srpt_service_guid,
		 srpt_service_guid, srpt_service_guid);

	/*
	 * We do not have a consistent service_id (ie. also id_ext of target_id)
	 * to identify this target. We currently use the guid of the first HCA
	 * in the system as service_id; therefore, the target_id will change
	 * if this HCA is gone bad and replaced by different HCA
	 */
	if (ib_cm_listen(sdev->cm_id, cpu_to_be64(srpt_service_guid), 0))
		goto err_cm;

	......
}

However, I check the srpt_service_guid is obtained by device->node_guid. I think that the compute algorithm is ok for device->node_guid.
In addition, I analyzed a patch in kernel-4.17(IB/srpt: Add RDMA/CM support). As a result, I can understand that the previous srpt is not supported by RDMA/CM?
So, all RoCE will failed when use kernel-4.14 version to run srpt.ko?

Thanks
Lijun Ou



