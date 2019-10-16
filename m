Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25E1D98B6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfJPRre (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 13:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfJPRrd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 13:47:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F06289F300;
        Wed, 16 Oct 2019 17:47:31 +0000 (UTC)
Received: from [10.3.117.195] (ovpn-117-195.phx2.redhat.com [10.3.117.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C498A5D6A9;
        Wed, 16 Oct 2019 17:47:29 +0000 (UTC)
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
To:     Potnuri Bharat Teja <bharat@chelsio.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, nirranjan@chelsio.com
References: <20190930074252.20133-1-bharat@chelsio.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <411c4ea1-4320-fa04-b014-7e5fe91869a8@redhat.com>
Date:   Wed, 16 Oct 2019 13:47:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190930074252.20133-1-bharat@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 16 Oct 2019 17:47:31 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 09/30/2019 03:42 AM, Potnuri Bharat Teja wrote:
> remove iw_cxgb3 module from kernel as the corresponding HW Chelsio T3 has
> reached EOL.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>   .../ABI/stable/sysfs-class-infiniband         |   19 -
>   MAINTAINERS                                   |    8 -
>   arch/powerpc/configs/powernv_defconfig        |    1 -
>   arch/powerpc/configs/ppc64_defconfig          |    1 -
>   arch/powerpc/configs/pseries_defconfig        |    1 -
>   drivers/infiniband/Kconfig                    |    1 -
>   drivers/infiniband/hw/Makefile                |    1 -
>   drivers/infiniband/hw/cxgb3/Kconfig           |   19 -
>   drivers/infiniband/hw/cxgb3/Makefile          |    7 -
>   drivers/infiniband/hw/cxgb3/cxio_hal.c        | 1312 ----------
>   drivers/infiniband/hw/cxgb3/cxio_hal.h        |  204 --
>   drivers/infiniband/hw/cxgb3/cxio_resource.c   |  344 ---
>   drivers/infiniband/hw/cxgb3/cxio_resource.h   |   69 -
>   drivers/infiniband/hw/cxgb3/cxio_wr.h         |  802 ------
>   drivers/infiniband/hw/cxgb3/iwch.c            |  282 --
>   drivers/infiniband/hw/cxgb3/iwch.h            |  155 --
>   drivers/infiniband/hw/cxgb3/iwch_cm.c         | 2258 -----------------
>   drivers/infiniband/hw/cxgb3/iwch_cm.h         |  233 --
>   drivers/infiniband/hw/cxgb3/iwch_cq.c         |  230 --
>   drivers/infiniband/hw/cxgb3/iwch_ev.c         |  232 --
>   drivers/infiniband/hw/cxgb3/iwch_mem.c        |  101 -
>   drivers/infiniband/hw/cxgb3/iwch_provider.c   | 1321 ----------
>   drivers/infiniband/hw/cxgb3/iwch_provider.h   |  347 ---
>   drivers/infiniband/hw/cxgb3/iwch_qp.c         | 1082 --------
>   drivers/infiniband/hw/cxgb3/tcb.h             |  632 -----
>   include/uapi/rdma/cxgb3-abi.h                 |   82 -
>   include/uapi/rdma/rdma_user_ioctl_cmds.h      |    1 -
>   27 files changed, 9745 deletions(-)
>   delete mode 100644 drivers/infiniband/hw/cxgb3/Kconfig
>   delete mode 100644 drivers/infiniband/hw/cxgb3/Makefile
>   delete mode 100644 drivers/infiniband/hw/cxgb3/cxio_hal.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/cxio_hal.h
>   delete mode 100644 drivers/infiniband/hw/cxgb3/cxio_resource.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/cxio_resource.h
>   delete mode 100644 drivers/infiniband/hw/cxgb3/cxio_wr.h
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch.h
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_cm.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_cm.h
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_cq.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_ev.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_mem.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_provider.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_provider.h
>   delete mode 100644 drivers/infiniband/hw/cxgb3/iwch_qp.c
>   delete mode 100644 drivers/infiniband/hw/cxgb3/tcb.h
>   delete mode 100644 include/uapi/rdma/cxgb3-abi.h
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
> index aed21b8916a2..96dfe1926b76 100644
> --- a/Documentation/ABI/stable/sysfs-class-infiniband
> +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> @@ -314,25 +314,6 @@ Description:
>   		board_id:	(RO) Manufacturing board ID
>   
>   
> -sysfs interface for Chelsio T3 RDMA Driver (cxgb3)
> ---------------------------------------------------
> -
> -What:		/sys/class/infiniband/cxgb3_X/hw_rev
> -What:		/sys/class/infiniband/cxgb3_X/hca_type
> -What:		/sys/class/infiniband/cxgb3_X/board_id
> -Date:		Feb, 2007
> -KernelVersion:	v2.6.21
> -Contact:	linux-rdma@vger.kernel.org
> -Description:
> -		hw_rev:		(RO) Hardware revision number
> -
> -		hca_type:	(RO) HCA type. Here it is a driver short name.
> -				It should normally match the name in its bus
> -				driver structure (e.g.  pci_driver::name).
> -
> -		board_id:	(RO) Manufacturing board id
> -
> -
>   sysfs interface for Mellanox ConnectX HCA IB driver (mlx4)
>   ----------------------------------------------------------
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7a47b5210fd..b705ee91a55d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4420,14 +4420,6 @@ W:	http://www.chelsio.com
>   S:	Supported
>   F:	drivers/scsi/cxgbi/cxgb3i
>   
> -CXGB3 IWARP RNIC DRIVER (IW_CXGB3)
> -M:	Potnuri Bharat Teja <bharat@chelsio.com>
> -L:	linux-rdma@vger.kernel.org
> -W:	http://www.openfabrics.org
> -S:	Supported
> -F:	drivers/infiniband/hw/cxgb3/
> -F:	include/uapi/rdma/cxgb3-abi.h
> -
>   CXGB4 CRYPTO DRIVER (chcr)
>   M:	Atul Gupta <atul.gupta@chelsio.com>
>   L:	linux-crypto@vger.kernel.org
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 34219d555e8a..d01fc0472b29 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -251,7 +251,6 @@ CONFIG_INFINIBAND=m
>   CONFIG_INFINIBAND_USER_MAD=m
>   CONFIG_INFINIBAND_USER_ACCESS=m
>   CONFIG_INFINIBAND_MTHCA=m
> -CONFIG_INFINIBAND_CXGB3=m
>   CONFIG_INFINIBAND_CXGB4=m
>   CONFIG_MLX4_INFINIBAND=m
>   CONFIG_INFINIBAND_IPOIB=m
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index dc83fefa04f7..c0d199349c0c 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -269,7 +269,6 @@ CONFIG_INFINIBAND=m
>   CONFIG_INFINIBAND_USER_MAD=m
>   CONFIG_INFINIBAND_USER_ACCESS=m
>   CONFIG_INFINIBAND_MTHCA=m
> -CONFIG_INFINIBAND_CXGB3=m
>   CONFIG_INFINIBAND_CXGB4=m
>   CONFIG_MLX4_INFINIBAND=m
>   CONFIG_INFINIBAND_IPOIB=m
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index 38abc9c1770a..cc6be0a7d669 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -225,7 +225,6 @@ CONFIG_INFINIBAND=m
>   CONFIG_INFINIBAND_USER_MAD=m
>   CONFIG_INFINIBAND_USER_ACCESS=m
>   CONFIG_INFINIBAND_MTHCA=m
> -CONFIG_INFINIBAND_CXGB3=m
>   CONFIG_INFINIBAND_CXGB4=m
>   CONFIG_MLX4_INFINIBAND=m
>   CONFIG_INFINIBAND_IPOIB=m
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index b44b1c322ec8..ade86388434f 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -83,7 +83,6 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
>   if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
>   source "drivers/infiniband/hw/mthca/Kconfig"
>   source "drivers/infiniband/hw/qib/Kconfig"
> -source "drivers/infiniband/hw/cxgb3/Kconfig"
>   source "drivers/infiniband/hw/cxgb4/Kconfig"
>   source "drivers/infiniband/hw/efa/Kconfig"
>   source "drivers/infiniband/hw/i40iw/Kconfig"
> diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
> index 433fca59febd..0aeccd984889 100644
> --- a/drivers/infiniband/hw/Makefile
> +++ b/drivers/infiniband/hw/Makefile
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_INFINIBAND_MTHCA)		+= mthca/
>   obj-$(CONFIG_INFINIBAND_QIB)		+= qib/
> -obj-$(CONFIG_INFINIBAND_CXGB3)		+= cxgb3/
>   obj-$(CONFIG_INFINIBAND_CXGB4)		+= cxgb4/
>   obj-$(CONFIG_INFINIBAND_EFA)		+= efa/
>   obj-$(CONFIG_INFINIBAND_I40IW)		+= i40iw/
> diff --git a/drivers/infiniband/hw/cxgb3/Kconfig b/drivers/infiniband/hw/cxgb3/Kconfig
> deleted file mode 100644
> index 8c1a72bff447..000000000000
> --- a/drivers/infiniband/hw/cxgb3/Kconfig
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -config INFINIBAND_CXGB3
> -	tristate "Chelsio RDMA Driver"
> -	depends on CHELSIO_T3
> -	select GENERIC_ALLOCATOR
> -	---help---
> -	  This is an iWARP/RDMA driver for the Chelsio T3 1GbE and
> -	  10GbE adapters.
> -
> -	  For general information about Chelsio and our products, visit
> -	  our website at <http://www.chelsio.com>.
> -
> -	  For customer support, please visit our customer support page at
> -	  <http://www.chelsio.com/support.html>.
> -
> -	  Please send feedback to <linux-bugs@chelsio.com>.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called iw_cxgb3.
> diff --git a/drivers/infiniband/hw/cxgb3/Makefile b/drivers/infiniband/hw/cxgb3/Makefile
> deleted file mode 100644
> index 34bb86a6ae3a..000000000000
> --- a/drivers/infiniband/hw/cxgb3/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -ccflags-y := -I $(srctree)/drivers/net/ethernet/chelsio/cxgb3
> -
> -obj-$(CONFIG_INFINIBAND_CXGB3) += iw_cxgb3.o
> -
> -iw_cxgb3-y :=  iwch_cm.o iwch_ev.o iwch_cq.o iwch_qp.o iwch_mem.o \
> -	       iwch_provider.o iwch.o cxio_hal.o cxio_resource.o
> diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
> deleted file mode 100644
> index 95b22a651673..000000000000
> --- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
> +++ /dev/null
> @@ -1,1312 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include <asm/delay.h>
> -
> -#include <linux/mutex.h>
> -#include <linux/netdevice.h>
> -#include <linux/sched.h>
> -#include <linux/spinlock.h>
> -#include <linux/pci.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/slab.h>
> -#include <net/net_namespace.h>
> -
> -#include "cxio_resource.h"
> -#include "cxio_hal.h"
> -#include "cxgb3_offload.h"
> -#include "sge_defs.h"
> -
> -static LIST_HEAD(rdev_list);
> -static cxio_hal_ev_callback_func_t cxio_ev_cb = NULL;
> -
> -static struct cxio_rdev *cxio_hal_find_rdev_by_name(char *dev_name)
> -{
> -	struct cxio_rdev *rdev;
> -
> -	list_for_each_entry(rdev, &rdev_list, entry)
> -		if (!strcmp(rdev->dev_name, dev_name))
> -			return rdev;
> -	return NULL;
> -}
> -
> -static struct cxio_rdev *cxio_hal_find_rdev_by_t3cdev(struct t3cdev *tdev)
> -{
> -	struct cxio_rdev *rdev;
> -
> -	list_for_each_entry(rdev, &rdev_list, entry)
> -		if (rdev->t3cdev_p == tdev)
> -			return rdev;
> -	return NULL;
> -}
> -
> -int cxio_hal_cq_op(struct cxio_rdev *rdev_p, struct t3_cq *cq,
> -		   enum t3_cq_opcode op, u32 credit)
> -{
> -	int ret;
> -	struct t3_cqe *cqe;
> -	u32 rptr;
> -
> -	struct rdma_cq_op setup;
> -	setup.id = cq->cqid;
> -	setup.credits = (op == CQ_CREDIT_UPDATE) ? credit : 0;
> -	setup.op = op;
> -	ret = rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, RDMA_CQ_OP, &setup);
> -
> -	if ((ret < 0) || (op == CQ_CREDIT_UPDATE))
> -		return ret;
> -
> -	/*
> -	 * If the rearm returned an index other than our current index,
> -	 * then there might be CQE's in flight (being DMA'd).  We must wait
> -	 * here for them to complete or the consumer can miss a notification.
> -	 */
> -	if (Q_PTR2IDX((cq->rptr), cq->size_log2) != ret) {
> -		int i=0;
> -
> -		rptr = cq->rptr;
> -
> -		/*
> -		 * Keep the generation correct by bumping rptr until it
> -		 * matches the index returned by the rearm - 1.
> -		 */
> -		while (Q_PTR2IDX((rptr+1), cq->size_log2) != ret)
> -			rptr++;
> -
> -		/*
> -		 * Now rptr is the index for the (last) cqe that was
> -		 * in-flight at the time the HW rearmed the CQ.  We
> -		 * spin until that CQE is valid.
> -		 */
> -		cqe = cq->queue + Q_PTR2IDX(rptr, cq->size_log2);
> -		while (!CQ_VLD_ENTRY(rptr, cq->size_log2, cqe)) {
> -			udelay(1);
> -			if (i++ > 1000000) {
> -				pr_err("%s: stalled rnic\n", rdev_p->dev_name);
> -				return -EIO;
> -			}
> -		}
> -
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
> -static int cxio_hal_clear_cq_ctx(struct cxio_rdev *rdev_p, u32 cqid)
> -{
> -	struct rdma_cq_setup setup;
> -	setup.id = cqid;
> -	setup.base_addr = 0;	/* NULL address */
> -	setup.size = 0;		/* disaable the CQ */
> -	setup.credits = 0;
> -	setup.credit_thres = 0;
> -	setup.ovfl_mode = 0;
> -	return (rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, RDMA_CQ_SETUP, &setup));
> -}
> -
> -static int cxio_hal_clear_qp_ctx(struct cxio_rdev *rdev_p, u32 qpid)
> -{
> -	u64 sge_cmd;
> -	struct t3_modify_qp_wr *wqe;
> -	struct sk_buff *skb = alloc_skb(sizeof(*wqe), GFP_KERNEL);
> -	if (!skb) {
> -		pr_debug("%s alloc_skb failed\n", __func__);
> -		return -ENOMEM;
> -	}
> -	wqe = skb_put_zero(skb, sizeof(*wqe));
> -	build_fw_riwrh((struct fw_riwrh *) wqe, T3_WR_QP_MOD,
> -		       T3_COMPLETION_FLAG | T3_NOTIFY_FLAG, 0, qpid, 7,
> -		       T3_SOPEOP);
> -	wqe->flags = cpu_to_be32(MODQP_WRITE_EC);
> -	sge_cmd = qpid << 8 | 3;
> -	wqe->sge_cmd = cpu_to_be64(sge_cmd);
> -	skb->priority = CPL_PRIORITY_CONTROL;
> -	return iwch_cxgb3_ofld_send(rdev_p->t3cdev_p, skb);
> -}
> -
> -int cxio_create_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq, int kernel)
> -{
> -	struct rdma_cq_setup setup;
> -	int size = (1UL << (cq->size_log2)) * sizeof(struct t3_cqe);
> -
> -	size += 1; /* one extra page for storing cq-in-err state */
> -	cq->cqid = cxio_hal_get_cqid(rdev_p->rscp);
> -	if (!cq->cqid)
> -		return -ENOMEM;
> -	if (kernel) {
> -		cq->sw_queue = kzalloc(size, GFP_KERNEL);
> -		if (!cq->sw_queue)
> -			return -ENOMEM;
> -	}
> -	cq->queue = dma_alloc_coherent(&(rdev_p->rnic_info.pdev->dev), size,
> -					     &(cq->dma_addr), GFP_KERNEL);
> -	if (!cq->queue) {
> -		kfree(cq->sw_queue);
> -		return -ENOMEM;
> -	}
> -	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
> -	setup.id = cq->cqid;
> -	setup.base_addr = (u64) (cq->dma_addr);
> -	setup.size = 1UL << cq->size_log2;
> -	setup.credits = 65535;
> -	setup.credit_thres = 1;
> -	if (rdev_p->t3cdev_p->type != T3A)
> -		setup.ovfl_mode = 0;
> -	else
> -		setup.ovfl_mode = 1;
> -	return (rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, RDMA_CQ_SETUP, &setup));
> -}
> -
> -static u32 get_qpid(struct cxio_rdev *rdev_p, struct cxio_ucontext *uctx)
> -{
> -	struct cxio_qpid_list *entry;
> -	u32 qpid;
> -	int i;
> -
> -	mutex_lock(&uctx->lock);
> -	if (!list_empty(&uctx->qpids)) {
> -		entry = list_entry(uctx->qpids.next, struct cxio_qpid_list,
> -				   entry);
> -		list_del(&entry->entry);
> -		qpid = entry->qpid;
> -		kfree(entry);
> -	} else {
> -		qpid = cxio_hal_get_qpid(rdev_p->rscp);
> -		if (!qpid)
> -			goto out;
> -		for (i = qpid+1; i & rdev_p->qpmask; i++) {
> -			entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> -			if (!entry)
> -				break;
> -			entry->qpid = i;
> -			list_add_tail(&entry->entry, &uctx->qpids);
> -		}
> -	}
> -out:
> -	mutex_unlock(&uctx->lock);
> -	pr_debug("%s qpid 0x%x\n", __func__, qpid);
> -	return qpid;
> -}
> -
> -static void put_qpid(struct cxio_rdev *rdev_p, u32 qpid,
> -		     struct cxio_ucontext *uctx)
> -{
> -	struct cxio_qpid_list *entry;
> -
> -	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> -	if (!entry)
> -		return;
> -	pr_debug("%s qpid 0x%x\n", __func__, qpid);
> -	entry->qpid = qpid;
> -	mutex_lock(&uctx->lock);
> -	list_add_tail(&entry->entry, &uctx->qpids);
> -	mutex_unlock(&uctx->lock);
> -}
> -
> -void cxio_release_ucontext(struct cxio_rdev *rdev_p, struct cxio_ucontext *uctx)
> -{
> -	struct list_head *pos, *nxt;
> -	struct cxio_qpid_list *entry;
> -
> -	mutex_lock(&uctx->lock);
> -	list_for_each_safe(pos, nxt, &uctx->qpids) {
> -		entry = list_entry(pos, struct cxio_qpid_list, entry);
> -		list_del_init(&entry->entry);
> -		if (!(entry->qpid & rdev_p->qpmask))
> -			cxio_hal_put_qpid(rdev_p->rscp, entry->qpid);
> -		kfree(entry);
> -	}
> -	mutex_unlock(&uctx->lock);
> -}
> -
> -void cxio_init_ucontext(struct cxio_rdev *rdev_p, struct cxio_ucontext *uctx)
> -{
> -	INIT_LIST_HEAD(&uctx->qpids);
> -	mutex_init(&uctx->lock);
> -}
> -
> -int cxio_create_qp(struct cxio_rdev *rdev_p, u32 kernel_domain,
> -		   struct t3_wq *wq, struct cxio_ucontext *uctx)
> -{
> -	int depth = 1UL << wq->size_log2;
> -	int rqsize = 1UL << wq->rq_size_log2;
> -
> -	wq->qpid = get_qpid(rdev_p, uctx);
> -	if (!wq->qpid)
> -		return -ENOMEM;
> -
> -	wq->rq = kcalloc(depth, sizeof(struct t3_swrq), GFP_KERNEL);
> -	if (!wq->rq)
> -		goto err1;
> -
> -	wq->rq_addr = cxio_hal_rqtpool_alloc(rdev_p, rqsize);
> -	if (!wq->rq_addr)
> -		goto err2;
> -
> -	wq->sq = kcalloc(depth, sizeof(struct t3_swsq), GFP_KERNEL);
> -	if (!wq->sq)
> -		goto err3;
> -
> -	wq->queue = dma_alloc_coherent(&(rdev_p->rnic_info.pdev->dev),
> -				       depth * sizeof(union t3_wr),
> -				       &(wq->dma_addr), GFP_KERNEL);
> -	if (!wq->queue)
> -		goto err4;
> -
> -	dma_unmap_addr_set(wq, mapping, wq->dma_addr);
> -	wq->doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
> -	if (!kernel_domain)
> -		wq->udb = (u64)rdev_p->rnic_info.udbell_physbase +
> -					(wq->qpid << rdev_p->qpshift);
> -	wq->rdev = rdev_p;
> -	pr_debug("%s qpid 0x%x doorbell 0x%p udb 0x%llx\n",
> -		 __func__, wq->qpid, wq->doorbell, (unsigned long long)wq->udb);
> -	return 0;
> -err4:
> -	kfree(wq->sq);
> -err3:
> -	cxio_hal_rqtpool_free(rdev_p, wq->rq_addr, rqsize);
> -err2:
> -	kfree(wq->rq);
> -err1:
> -	put_qpid(rdev_p, wq->qpid, uctx);
> -	return -ENOMEM;
> -}
> -
> -void cxio_destroy_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq)
> -{
> -	cxio_hal_clear_cq_ctx(rdev_p, cq->cqid);
> -	kfree(cq->sw_queue);
> -	dma_free_coherent(&(rdev_p->rnic_info.pdev->dev),
> -			  (1UL << (cq->size_log2))
> -			  * sizeof(struct t3_cqe) + 1, cq->queue,
> -			  dma_unmap_addr(cq, mapping));
> -	cxio_hal_put_cqid(rdev_p->rscp, cq->cqid);
> -}
> -
> -int cxio_destroy_qp(struct cxio_rdev *rdev_p, struct t3_wq *wq,
> -		    struct cxio_ucontext *uctx)
> -{
> -	dma_free_coherent(&(rdev_p->rnic_info.pdev->dev),
> -			  (1UL << (wq->size_log2))
> -			  * sizeof(union t3_wr), wq->queue,
> -			  dma_unmap_addr(wq, mapping));
> -	kfree(wq->sq);
> -	cxio_hal_rqtpool_free(rdev_p, wq->rq_addr, (1UL << wq->rq_size_log2));
> -	kfree(wq->rq);
> -	put_qpid(rdev_p, wq->qpid, uctx);
> -	return 0;
> -}
> -
> -static void insert_recv_cqe(struct t3_wq *wq, struct t3_cq *cq)
> -{
> -	struct t3_cqe cqe;
> -
> -	pr_debug("%s wq %p cq %p sw_rptr 0x%x sw_wptr 0x%x\n", __func__,
> -		 wq, cq, cq->sw_rptr, cq->sw_wptr);
> -	memset(&cqe, 0, sizeof(cqe));
> -	cqe.header = cpu_to_be32(V_CQE_STATUS(TPT_ERR_SWFLUSH) |
> -			         V_CQE_OPCODE(T3_SEND) |
> -				 V_CQE_TYPE(0) |
> -				 V_CQE_SWCQE(1) |
> -				 V_CQE_QPID(wq->qpid) |
> -				 V_CQE_GENBIT(Q_GENBIT(cq->sw_wptr,
> -						       cq->size_log2)));
> -	*(cq->sw_queue + Q_PTR2IDX(cq->sw_wptr, cq->size_log2)) = cqe;
> -	cq->sw_wptr++;
> -}
> -
> -int cxio_flush_rq(struct t3_wq *wq, struct t3_cq *cq, int count)
> -{
> -	u32 ptr;
> -	int flushed = 0;
> -
> -	pr_debug("%s wq %p cq %p\n", __func__, wq, cq);
> -
> -	/* flush RQ */
> -	pr_debug("%s rq_rptr %u rq_wptr %u skip count %u\n", __func__,
> -		 wq->rq_rptr, wq->rq_wptr, count);
> -	ptr = wq->rq_rptr + count;
> -	while (ptr++ != wq->rq_wptr) {
> -		insert_recv_cqe(wq, cq);
> -		flushed++;
> -	}
> -	return flushed;
> -}
> -
> -static void insert_sq_cqe(struct t3_wq *wq, struct t3_cq *cq,
> -		          struct t3_swsq *sqp)
> -{
> -	struct t3_cqe cqe;
> -
> -	pr_debug("%s wq %p cq %p sw_rptr 0x%x sw_wptr 0x%x\n", __func__,
> -		 wq, cq, cq->sw_rptr, cq->sw_wptr);
> -	memset(&cqe, 0, sizeof(cqe));
> -	cqe.header = cpu_to_be32(V_CQE_STATUS(TPT_ERR_SWFLUSH) |
> -			         V_CQE_OPCODE(sqp->opcode) |
> -			         V_CQE_TYPE(1) |
> -			         V_CQE_SWCQE(1) |
> -			         V_CQE_QPID(wq->qpid) |
> -			         V_CQE_GENBIT(Q_GENBIT(cq->sw_wptr,
> -						       cq->size_log2)));
> -	cqe.u.scqe.wrid_hi = sqp->sq_wptr;
> -
> -	*(cq->sw_queue + Q_PTR2IDX(cq->sw_wptr, cq->size_log2)) = cqe;
> -	cq->sw_wptr++;
> -}
> -
> -int cxio_flush_sq(struct t3_wq *wq, struct t3_cq *cq, int count)
> -{
> -	__u32 ptr = wq->sq_rptr + count;
> -	int flushed = 0;
> -	struct t3_swsq *sqp = wq->sq + Q_PTR2IDX(ptr, wq->sq_size_log2);
> -
> -	while (ptr != wq->sq_wptr) {
> -		sqp->signaled = 0;
> -		insert_sq_cqe(wq, cq, sqp);
> -		ptr++;
> -		sqp = wq->sq + Q_PTR2IDX(ptr, wq->sq_size_log2);
> -		flushed++;
> -	}
> -	return flushed;
> -}
> -
> -/*
> - * Move all CQEs from the HWCQ into the SWCQ.
> - */
> -void cxio_flush_hw_cq(struct t3_cq *cq)
> -{
> -	struct t3_cqe *cqe, *swcqe;
> -
> -	pr_debug("%s cq %p cqid 0x%x\n", __func__, cq, cq->cqid);
> -	cqe = cxio_next_hw_cqe(cq);
> -	while (cqe) {
> -		pr_debug("%s flushing hwcq rptr 0x%x to swcq wptr 0x%x\n",
> -			 __func__, cq->rptr, cq->sw_wptr);
> -		swcqe = cq->sw_queue + Q_PTR2IDX(cq->sw_wptr, cq->size_log2);
> -		*swcqe = *cqe;
> -		swcqe->header |= cpu_to_be32(V_CQE_SWCQE(1));
> -		cq->sw_wptr++;
> -		cq->rptr++;
> -		cqe = cxio_next_hw_cqe(cq);
> -	}
> -}
> -
> -static int cqe_completes_wr(struct t3_cqe *cqe, struct t3_wq *wq)
> -{
> -	if (CQE_OPCODE(*cqe) == T3_TERMINATE)
> -		return 0;
> -
> -	if ((CQE_OPCODE(*cqe) == T3_RDMA_WRITE) && RQ_TYPE(*cqe))
> -		return 0;
> -
> -	if ((CQE_OPCODE(*cqe) == T3_READ_RESP) && SQ_TYPE(*cqe))
> -		return 0;
> -
> -	if (CQE_SEND_OPCODE(*cqe) && RQ_TYPE(*cqe) &&
> -	    Q_EMPTY(wq->rq_rptr, wq->rq_wptr))
> -		return 0;
> -
> -	return 1;
> -}
> -
> -void cxio_count_scqes(struct t3_cq *cq, struct t3_wq *wq, int *count)
> -{
> -	struct t3_cqe *cqe;
> -	u32 ptr;
> -
> -	*count = 0;
> -	ptr = cq->sw_rptr;
> -	while (!Q_EMPTY(ptr, cq->sw_wptr)) {
> -		cqe = cq->sw_queue + (Q_PTR2IDX(ptr, cq->size_log2));
> -		if ((SQ_TYPE(*cqe) ||
> -		     ((CQE_OPCODE(*cqe) == T3_READ_RESP) && wq->oldest_read)) &&
> -		    (CQE_QPID(*cqe) == wq->qpid))
> -			(*count)++;
> -		ptr++;
> -	}
> -	pr_debug("%s cq %p count %d\n", __func__, cq, *count);
> -}
> -
> -void cxio_count_rcqes(struct t3_cq *cq, struct t3_wq *wq, int *count)
> -{
> -	struct t3_cqe *cqe;
> -	u32 ptr;
> -
> -	*count = 0;
> -	pr_debug("%s count zero %d\n", __func__, *count);
> -	ptr = cq->sw_rptr;
> -	while (!Q_EMPTY(ptr, cq->sw_wptr)) {
> -		cqe = cq->sw_queue + (Q_PTR2IDX(ptr, cq->size_log2));
> -		if (RQ_TYPE(*cqe) && (CQE_OPCODE(*cqe) != T3_READ_RESP) &&
> -		    (CQE_QPID(*cqe) == wq->qpid) && cqe_completes_wr(cqe, wq))
> -			(*count)++;
> -		ptr++;
> -	}
> -	pr_debug("%s cq %p count %d\n", __func__, cq, *count);
> -}
> -
> -static int cxio_hal_init_ctrl_cq(struct cxio_rdev *rdev_p)
> -{
> -	struct rdma_cq_setup setup;
> -	setup.id = 0;
> -	setup.base_addr = 0;	/* NULL address */
> -	setup.size = 1;		/* enable the CQ */
> -	setup.credits = 0;
> -
> -	/* force SGE to redirect to RspQ and interrupt */
> -	setup.credit_thres = 0;
> -	setup.ovfl_mode = 1;
> -	return (rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, RDMA_CQ_SETUP, &setup));
> -}
> -
> -static int cxio_hal_init_ctrl_qp(struct cxio_rdev *rdev_p)
> -{
> -	int err;
> -	u64 sge_cmd, ctx0, ctx1;
> -	u64 base_addr;
> -	struct t3_modify_qp_wr *wqe;
> -	struct sk_buff *skb;
> -
> -	skb = alloc_skb(sizeof(*wqe), GFP_KERNEL);
> -	if (!skb) {
> -		pr_debug("%s alloc_skb failed\n", __func__);
> -		return -ENOMEM;
> -	}
> -	err = cxio_hal_init_ctrl_cq(rdev_p);
> -	if (err) {
> -		pr_debug("%s err %d initializing ctrl_cq\n", __func__, err);
> -		goto err;
> -	}
> -	rdev_p->ctrl_qp.workq = dma_alloc_coherent(
> -					&(rdev_p->rnic_info.pdev->dev),
> -					(1 << T3_CTRL_QP_SIZE_LOG2) *
> -					sizeof(union t3_wr),
> -					&(rdev_p->ctrl_qp.dma_addr),
> -					GFP_KERNEL);
> -	if (!rdev_p->ctrl_qp.workq) {
> -		pr_debug("%s dma_alloc_coherent failed\n", __func__);
> -		err = -ENOMEM;
> -		goto err;
> -	}
> -	dma_unmap_addr_set(&rdev_p->ctrl_qp, mapping,
> -			   rdev_p->ctrl_qp.dma_addr);
> -	rdev_p->ctrl_qp.doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
> -
> -	mutex_init(&rdev_p->ctrl_qp.lock);
> -	init_waitqueue_head(&rdev_p->ctrl_qp.waitq);
> -
> -	/* update HW Ctrl QP context */
> -	base_addr = rdev_p->ctrl_qp.dma_addr;
> -	base_addr >>= 12;
> -	ctx0 = (V_EC_SIZE((1 << T3_CTRL_QP_SIZE_LOG2)) |
> -		V_EC_BASE_LO((u32) base_addr & 0xffff));
> -	ctx0 <<= 32;
> -	ctx0 |= V_EC_CREDITS(FW_WR_NUM);
> -	base_addr >>= 16;
> -	ctx1 = (u32) base_addr;
> -	base_addr >>= 32;
> -	ctx1 |= ((u64) (V_EC_BASE_HI((u32) base_addr & 0xf) | V_EC_RESPQ(0) |
> -			V_EC_TYPE(0) | V_EC_GEN(1) |
> -			V_EC_UP_TOKEN(T3_CTL_QP_TID) | F_EC_VALID)) << 32;
> -	wqe = skb_put_zero(skb, sizeof(*wqe));
> -	build_fw_riwrh((struct fw_riwrh *) wqe, T3_WR_QP_MOD, 0, 0,
> -		       T3_CTL_QP_TID, 7, T3_SOPEOP);
> -	wqe->flags = cpu_to_be32(MODQP_WRITE_EC);
> -	sge_cmd = (3ULL << 56) | FW_RI_SGEEC_START << 8 | 3;
> -	wqe->sge_cmd = cpu_to_be64(sge_cmd);
> -	wqe->ctx1 = cpu_to_be64(ctx1);
> -	wqe->ctx0 = cpu_to_be64(ctx0);
> -	pr_debug("CtrlQP dma_addr %pad workq %p size %d\n",
> -		 &rdev_p->ctrl_qp.dma_addr, rdev_p->ctrl_qp.workq,
> -		 1 << T3_CTRL_QP_SIZE_LOG2);
> -	skb->priority = CPL_PRIORITY_CONTROL;
> -	return iwch_cxgb3_ofld_send(rdev_p->t3cdev_p, skb);
> -err:
> -	kfree_skb(skb);
> -	return err;
> -}
> -
> -static int cxio_hal_destroy_ctrl_qp(struct cxio_rdev *rdev_p)
> -{
> -	dma_free_coherent(&(rdev_p->rnic_info.pdev->dev),
> -			  (1UL << T3_CTRL_QP_SIZE_LOG2)
> -			  * sizeof(union t3_wr), rdev_p->ctrl_qp.workq,
> -			  dma_unmap_addr(&rdev_p->ctrl_qp, mapping));
> -	return cxio_hal_clear_qp_ctx(rdev_p, T3_CTRL_QP_ID);
> -}
> -
> -/* write len bytes of data into addr (32B aligned address)
> - * If data is NULL, clear len byte of memory to zero.
> - * caller acquires the ctrl_qp lock before the call
> - */
> -static int cxio_hal_ctrl_qp_write_mem(struct cxio_rdev *rdev_p, u32 addr,
> -				      u32 len, void *data)
> -{
> -	u32 i, nr_wqe, copy_len;
> -	u8 *copy_data;
> -	u8 wr_len, utx_len;	/* length in 8 byte flit */
> -	enum t3_wr_flags flag;
> -	__be64 *wqe;
> -	u64 utx_cmd;
> -	addr &= 0x7FFFFFF;
> -	nr_wqe = len % 96 ? len / 96 + 1 : len / 96;	/* 96B max per WQE */
> -	pr_debug("%s wptr 0x%x rptr 0x%x len %d, nr_wqe %d data %p addr 0x%0x\n",
> -		 __func__, rdev_p->ctrl_qp.wptr, rdev_p->ctrl_qp.rptr, len,
> -		 nr_wqe, data, addr);
> -	utx_len = 3;		/* in 32B unit */
> -	for (i = 0; i < nr_wqe; i++) {
> -		if (Q_FULL(rdev_p->ctrl_qp.rptr, rdev_p->ctrl_qp.wptr,
> -		           T3_CTRL_QP_SIZE_LOG2)) {
> -			pr_debug("%s ctrl_qp full wtpr 0x%0x rptr 0x%0x, wait for more space i %d\n",
> -				 __func__,
> -				 rdev_p->ctrl_qp.wptr, rdev_p->ctrl_qp.rptr, i);
> -			if (wait_event_interruptible(rdev_p->ctrl_qp.waitq,
> -					     !Q_FULL(rdev_p->ctrl_qp.rptr,
> -						     rdev_p->ctrl_qp.wptr,
> -						     T3_CTRL_QP_SIZE_LOG2))) {
> -				pr_debug("%s ctrl_qp workq interrupted\n",
> -					 __func__);
> -				return -ERESTARTSYS;
> -			}
> -			pr_debug("%s ctrl_qp wakeup, continue posting work request i %d\n",
> -				 __func__, i);
> -		}
> -		wqe = (__be64 *)(rdev_p->ctrl_qp.workq + (rdev_p->ctrl_qp.wptr %
> -						(1 << T3_CTRL_QP_SIZE_LOG2)));
> -		flag = 0;
> -		if (i == (nr_wqe - 1)) {
> -			/* last WQE */
> -			flag = T3_COMPLETION_FLAG;
> -			if (len % 32)
> -				utx_len = len / 32 + 1;
> -			else
> -				utx_len = len / 32;
> -		}
> -
> -		/*
> -		 * Force a CQE to return the credit to the workq in case
> -		 * we posted more than half the max QP size of WRs
> -		 */
> -		if ((i != 0) &&
> -		    (i % (((1 << T3_CTRL_QP_SIZE_LOG2)) >> 1) == 0)) {
> -			flag = T3_COMPLETION_FLAG;
> -			pr_debug("%s force completion at i %d\n", __func__, i);
> -		}
> -
> -		/* build the utx mem command */
> -		wqe += (sizeof(struct t3_bypass_wr) >> 3);
> -		utx_cmd = (T3_UTX_MEM_WRITE << 28) | (addr + i * 3);
> -		utx_cmd <<= 32;
> -		utx_cmd |= (utx_len << 28) | ((utx_len << 2) + 1);
> -		*wqe = cpu_to_be64(utx_cmd);
> -		wqe++;
> -		copy_data = (u8 *) data + i * 96;
> -		copy_len = len > 96 ? 96 : len;
> -
> -		/* clear memory content if data is NULL */
> -		if (data)
> -			memcpy(wqe, copy_data, copy_len);
> -		else
> -			memset(wqe, 0, copy_len);
> -		if (copy_len % 32)
> -			memset(((u8 *) wqe) + copy_len, 0,
> -			       32 - (copy_len % 32));
> -		wr_len = ((sizeof(struct t3_bypass_wr)) >> 3) + 1 +
> -			 (utx_len << 2);
> -		wqe = (__be64 *)(rdev_p->ctrl_qp.workq + (rdev_p->ctrl_qp.wptr %
> -			      (1 << T3_CTRL_QP_SIZE_LOG2)));
> -
> -		/* wptr in the WRID[31:0] */
> -		((union t3_wrid *)(wqe+1))->id0.low = rdev_p->ctrl_qp.wptr;
> -
> -		/*
> -		 * This must be the last write with a memory barrier
> -		 * for the genbit
> -		 */
> -		build_fw_riwrh((struct fw_riwrh *) wqe, T3_WR_BP, flag,
> -			       Q_GENBIT(rdev_p->ctrl_qp.wptr,
> -					T3_CTRL_QP_SIZE_LOG2), T3_CTRL_QP_ID,
> -			       wr_len, T3_SOPEOP);
> -		if (flag == T3_COMPLETION_FLAG)
> -			ring_doorbell(rdev_p->ctrl_qp.doorbell, T3_CTRL_QP_ID);
> -		len -= 96;
> -		rdev_p->ctrl_qp.wptr++;
> -	}
> -	return 0;
> -}
> -
> -/* IN: stag key, pdid, perm, zbva, to, len, page_size, pbl_size and pbl_addr
> - * OUT: stag index
> - * TBD: shared memory region support
> - */
> -static int __cxio_tpt_op(struct cxio_rdev *rdev_p, u32 reset_tpt_entry,
> -			 u32 *stag, u8 stag_state, u32 pdid,
> -			 enum tpt_mem_type type, enum tpt_mem_perm perm,
> -			 u32 zbva, u64 to, u32 len, u8 page_size,
> -			 u32 pbl_size, u32 pbl_addr)
> -{
> -	int err;
> -	struct tpt_entry tpt;
> -	u32 stag_idx;
> -	u32 wptr;
> -
> -	if (cxio_fatal_error(rdev_p))
> -		return -EIO;
> -
> -	stag_state = stag_state > 0;
> -	stag_idx = (*stag) >> 8;
> -
> -	if ((!reset_tpt_entry) && !(*stag != T3_STAG_UNSET)) {
> -		stag_idx = cxio_hal_get_stag(rdev_p->rscp);
> -		if (!stag_idx)
> -			return -ENOMEM;
> -		*stag = (stag_idx << 8) | ((*stag) & 0xFF);
> -	}
> -	pr_debug("%s stag_state 0x%0x type 0x%0x pdid 0x%0x, stag_idx 0x%x\n",
> -		 __func__, stag_state, type, pdid, stag_idx);
> -
> -	mutex_lock(&rdev_p->ctrl_qp.lock);
> -
> -	/* write TPT entry */
> -	if (reset_tpt_entry)
> -		memset(&tpt, 0, sizeof(tpt));
> -	else {
> -		tpt.valid_stag_pdid = cpu_to_be32(F_TPT_VALID |
> -				V_TPT_STAG_KEY((*stag) & M_TPT_STAG_KEY) |
> -				V_TPT_STAG_STATE(stag_state) |
> -				V_TPT_STAG_TYPE(type) | V_TPT_PDID(pdid));
> -		BUG_ON(page_size >= 28);
> -		tpt.flags_pagesize_qpid = cpu_to_be32(V_TPT_PERM(perm) |
> -			((perm & TPT_MW_BIND) ? F_TPT_MW_BIND_ENABLE : 0) |
> -			V_TPT_ADDR_TYPE((zbva ? TPT_ZBTO : TPT_VATO)) |
> -			V_TPT_PAGE_SIZE(page_size));
> -		tpt.rsvd_pbl_addr = cpu_to_be32(V_TPT_PBL_ADDR(PBL_OFF(rdev_p, pbl_addr)>>3));
> -		tpt.len = cpu_to_be32(len);
> -		tpt.va_hi = cpu_to_be32((u32) (to >> 32));
> -		tpt.va_low_or_fbo = cpu_to_be32((u32) (to & 0xFFFFFFFFULL));
> -		tpt.rsvd_bind_cnt_or_pstag = 0;
> -		tpt.rsvd_pbl_size = cpu_to_be32(V_TPT_PBL_SIZE(pbl_size >> 2));
> -	}
> -	err = cxio_hal_ctrl_qp_write_mem(rdev_p,
> -				       stag_idx +
> -				       (rdev_p->rnic_info.tpt_base >> 5),
> -				       sizeof(tpt), &tpt);
> -
> -	/* release the stag index to free pool */
> -	if (reset_tpt_entry)
> -		cxio_hal_put_stag(rdev_p->rscp, stag_idx);
> -
> -	wptr = rdev_p->ctrl_qp.wptr;
> -	mutex_unlock(&rdev_p->ctrl_qp.lock);
> -	if (!err)
> -		if (wait_event_interruptible(rdev_p->ctrl_qp.waitq,
> -					     SEQ32_GE(rdev_p->ctrl_qp.rptr,
> -						      wptr)))
> -			return -ERESTARTSYS;
> -	return err;
> -}
> -
> -int cxio_write_pbl(struct cxio_rdev *rdev_p, __be64 *pbl,
> -		   u32 pbl_addr, u32 pbl_size)
> -{
> -	u32 wptr;
> -	int err;
> -
> -	pr_debug("%s *pdb_addr 0x%x, pbl_base 0x%x, pbl_size %d\n",
> -		 __func__, pbl_addr, rdev_p->rnic_info.pbl_base,
> -		 pbl_size);
> -
> -	mutex_lock(&rdev_p->ctrl_qp.lock);
> -	err = cxio_hal_ctrl_qp_write_mem(rdev_p, pbl_addr >> 5, pbl_size << 3,
> -					 pbl);
> -	wptr = rdev_p->ctrl_qp.wptr;
> -	mutex_unlock(&rdev_p->ctrl_qp.lock);
> -	if (err)
> -		return err;
> -
> -	if (wait_event_interruptible(rdev_p->ctrl_qp.waitq,
> -				     SEQ32_GE(rdev_p->ctrl_qp.rptr,
> -					      wptr)))
> -		return -ERESTARTSYS;
> -
> -	return 0;
> -}
> -
> -int cxio_register_phys_mem(struct cxio_rdev *rdev_p, u32 *stag, u32 pdid,
> -			   enum tpt_mem_perm perm, u32 zbva, u64 to, u32 len,
> -			   u8 page_size, u32 pbl_size, u32 pbl_addr)
> -{
> -	*stag = T3_STAG_UNSET;
> -	return __cxio_tpt_op(rdev_p, 0, stag, 1, pdid, TPT_NON_SHARED_MR, perm,
> -			     zbva, to, len, page_size, pbl_size, pbl_addr);
> -}
> -
> -int cxio_reregister_phys_mem(struct cxio_rdev *rdev_p, u32 *stag, u32 pdid,
> -			   enum tpt_mem_perm perm, u32 zbva, u64 to, u32 len,
> -			   u8 page_size, u32 pbl_size, u32 pbl_addr)
> -{
> -	return __cxio_tpt_op(rdev_p, 0, stag, 1, pdid, TPT_NON_SHARED_MR, perm,
> -			     zbva, to, len, page_size, pbl_size, pbl_addr);
> -}
> -
> -int cxio_dereg_mem(struct cxio_rdev *rdev_p, u32 stag, u32 pbl_size,
> -		   u32 pbl_addr)
> -{
> -	return __cxio_tpt_op(rdev_p, 1, &stag, 0, 0, 0, 0, 0, 0ULL, 0, 0,
> -			     pbl_size, pbl_addr);
> -}
> -
> -int cxio_allocate_window(struct cxio_rdev *rdev_p, u32 * stag, u32 pdid)
> -{
> -	*stag = T3_STAG_UNSET;
> -	return __cxio_tpt_op(rdev_p, 0, stag, 0, pdid, TPT_MW, 0, 0, 0ULL, 0, 0,
> -			     0, 0);
> -}
> -
> -int cxio_deallocate_window(struct cxio_rdev *rdev_p, u32 stag)
> -{
> -	return __cxio_tpt_op(rdev_p, 1, &stag, 0, 0, 0, 0, 0, 0ULL, 0, 0,
> -			     0, 0);
> -}
> -
> -int cxio_allocate_stag(struct cxio_rdev *rdev_p, u32 *stag, u32 pdid, u32 pbl_size, u32 pbl_addr)
> -{
> -	*stag = T3_STAG_UNSET;
> -	return __cxio_tpt_op(rdev_p, 0, stag, 0, pdid, TPT_NON_SHARED_MR,
> -			     0, 0, 0ULL, 0, 0, pbl_size, pbl_addr);
> -}
> -
> -int cxio_rdma_init(struct cxio_rdev *rdev_p, struct t3_rdma_init_attr *attr)
> -{
> -	struct t3_rdma_init_wr *wqe;
> -	struct sk_buff *skb = alloc_skb(sizeof(*wqe), GFP_ATOMIC);
> -	if (!skb)
> -		return -ENOMEM;
> -	pr_debug("%s rdev_p %p\n", __func__, rdev_p);
> -	wqe = __skb_put(skb, sizeof(*wqe));
> -	wqe->wrh.op_seop_flags = cpu_to_be32(V_FW_RIWR_OP(T3_WR_INIT));
> -	wqe->wrh.gen_tid_len = cpu_to_be32(V_FW_RIWR_TID(attr->tid) |
> -					   V_FW_RIWR_LEN(sizeof(*wqe) >> 3));
> -	wqe->wrid.id1 = 0;
> -	wqe->qpid = cpu_to_be32(attr->qpid);
> -	wqe->pdid = cpu_to_be32(attr->pdid);
> -	wqe->scqid = cpu_to_be32(attr->scqid);
> -	wqe->rcqid = cpu_to_be32(attr->rcqid);
> -	wqe->rq_addr = cpu_to_be32(attr->rq_addr - rdev_p->rnic_info.rqt_base);
> -	wqe->rq_size = cpu_to_be32(attr->rq_size);
> -	wqe->mpaattrs = attr->mpaattrs;
> -	wqe->qpcaps = attr->qpcaps;
> -	wqe->ulpdu_size = cpu_to_be16(attr->tcp_emss);
> -	wqe->rqe_count = cpu_to_be16(attr->rqe_count);
> -	wqe->flags_rtr_type = cpu_to_be16(attr->flags |
> -					  V_RTR_TYPE(attr->rtr_type) |
> -					  V_CHAN(attr->chan));
> -	wqe->ord = cpu_to_be32(attr->ord);
> -	wqe->ird = cpu_to_be32(attr->ird);
> -	wqe->qp_dma_addr = cpu_to_be64(attr->qp_dma_addr);
> -	wqe->qp_dma_size = cpu_to_be32(attr->qp_dma_size);
> -	wqe->irs = cpu_to_be32(attr->irs);
> -	skb->priority = 0;	/* 0=>ToeQ; 1=>CtrlQ */
> -	return iwch_cxgb3_ofld_send(rdev_p->t3cdev_p, skb);
> -}
> -
> -void cxio_register_ev_cb(cxio_hal_ev_callback_func_t ev_cb)
> -{
> -	cxio_ev_cb = ev_cb;
> -}
> -
> -void cxio_unregister_ev_cb(cxio_hal_ev_callback_func_t ev_cb)
> -{
> -	cxio_ev_cb = NULL;
> -}
> -
> -static int cxio_hal_ev_handler(struct t3cdev *t3cdev_p, struct sk_buff *skb)
> -{
> -	static int cnt;
> -	struct cxio_rdev *rdev_p = NULL;
> -	struct respQ_msg_t *rsp_msg = (struct respQ_msg_t *) skb->data;
> -	pr_debug("%d: %s cq_id 0x%x cq_ptr 0x%x genbit %0x overflow %0x an %0x se %0x notify %0x cqbranch %0x creditth %0x\n",
> -		 cnt, __func__, RSPQ_CQID(rsp_msg), RSPQ_CQPTR(rsp_msg),
> -		 RSPQ_GENBIT(rsp_msg), RSPQ_OVERFLOW(rsp_msg), RSPQ_AN(rsp_msg),
> -		 RSPQ_SE(rsp_msg), RSPQ_NOTIFY(rsp_msg), RSPQ_CQBRANCH(rsp_msg),
> -		 RSPQ_CREDIT_THRESH(rsp_msg));
> -	pr_debug("CQE: QPID 0x%0x genbit %0x type 0x%0x status 0x%0x opcode %d len 0x%0x wrid_hi_stag 0x%x wrid_low_msn 0x%x\n",
> -		 CQE_QPID(rsp_msg->cqe), CQE_GENBIT(rsp_msg->cqe),
> -		 CQE_TYPE(rsp_msg->cqe), CQE_STATUS(rsp_msg->cqe),
> -		 CQE_OPCODE(rsp_msg->cqe), CQE_LEN(rsp_msg->cqe),
> -		 CQE_WRID_HI(rsp_msg->cqe), CQE_WRID_LOW(rsp_msg->cqe));
> -	rdev_p = (struct cxio_rdev *)t3cdev_p->ulp;
> -	if (!rdev_p) {
> -		pr_debug("%s called by t3cdev %p with null ulp\n", __func__,
> -			 t3cdev_p);
> -		return 0;
> -	}
> -	if (CQE_QPID(rsp_msg->cqe) == T3_CTRL_QP_ID) {
> -		rdev_p->ctrl_qp.rptr = CQE_WRID_LOW(rsp_msg->cqe) + 1;
> -		wake_up_interruptible(&rdev_p->ctrl_qp.waitq);
> -		dev_kfree_skb_irq(skb);
> -	} else if (CQE_QPID(rsp_msg->cqe) == 0xfff8)
> -		dev_kfree_skb_irq(skb);
> -	else if (cxio_ev_cb)
> -		(*cxio_ev_cb) (rdev_p, skb);
> -	else
> -		dev_kfree_skb_irq(skb);
> -	cnt++;
> -	return 0;
> -}
> -
> -/* Caller takes care of locking if needed */
> -int cxio_rdev_open(struct cxio_rdev *rdev_p)
> -{
> -	struct net_device *netdev_p = NULL;
> -	int err = 0;
> -	if (strlen(rdev_p->dev_name)) {
> -		if (cxio_hal_find_rdev_by_name(rdev_p->dev_name)) {
> -			return -EBUSY;
> -		}
> -		netdev_p = dev_get_by_name(&init_net, rdev_p->dev_name);
> -		if (!netdev_p) {
> -			return -EINVAL;
> -		}
> -		dev_put(netdev_p);
> -	} else if (rdev_p->t3cdev_p) {
> -		if (cxio_hal_find_rdev_by_t3cdev(rdev_p->t3cdev_p)) {
> -			return -EBUSY;
> -		}
> -		netdev_p = rdev_p->t3cdev_p->lldev;
> -		strncpy(rdev_p->dev_name, rdev_p->t3cdev_p->name,
> -			T3_MAX_DEV_NAME_LEN);
> -	} else {
> -		pr_debug("%s t3cdev_p or dev_name must be set\n", __func__);
> -		return -EINVAL;
> -	}
> -
> -	list_add_tail(&rdev_p->entry, &rdev_list);
> -
> -	pr_debug("%s opening rnic dev %s\n", __func__, rdev_p->dev_name);
> -	memset(&rdev_p->ctrl_qp, 0, sizeof(rdev_p->ctrl_qp));
> -	if (!rdev_p->t3cdev_p)
> -		rdev_p->t3cdev_p = dev2t3cdev(netdev_p);
> -	rdev_p->t3cdev_p->ulp = (void *) rdev_p;
> -
> -	err = rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, GET_EMBEDDED_INFO,
> -					 &(rdev_p->fw_info));
> -	if (err) {
> -		pr_err("%s t3cdev_p(%p)->ctl returned error %d\n",
> -		       __func__, rdev_p->t3cdev_p, err);
> -		goto err1;
> -	}
> -	if (G_FW_VERSION_MAJOR(rdev_p->fw_info.fw_vers) != CXIO_FW_MAJ) {
> -		pr_err("fatal firmware version mismatch: need version %u but adapter has version %u\n",
> -		       CXIO_FW_MAJ,
> -		       G_FW_VERSION_MAJOR(rdev_p->fw_info.fw_vers));
> -		err = -EINVAL;
> -		goto err1;
> -	}
> -
> -	err = rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, RDMA_GET_PARAMS,
> -					 &(rdev_p->rnic_info));
> -	if (err) {
> -		pr_err("%s t3cdev_p(%p)->ctl returned error %d\n",
> -		       __func__, rdev_p->t3cdev_p, err);
> -		goto err1;
> -	}
> -	err = rdev_p->t3cdev_p->ctl(rdev_p->t3cdev_p, GET_PORTS,
> -				    &(rdev_p->port_info));
> -	if (err) {
> -		pr_err("%s t3cdev_p(%p)->ctl returned error %d\n",
> -		       __func__, rdev_p->t3cdev_p, err);
> -		goto err1;
> -	}
> -
> -	/*
> -	 * qpshift is the number of bits to shift the qpid left in order
> -	 * to get the correct address of the doorbell for that qp.
> -	 */
> -	cxio_init_ucontext(rdev_p, &rdev_p->uctx);
> -	rdev_p->qpshift = PAGE_SHIFT -
> -			  ilog2(65536 >>
> -			            ilog2(rdev_p->rnic_info.udbell_len >>
> -					      PAGE_SHIFT));
> -	rdev_p->qpnr = rdev_p->rnic_info.udbell_len >> PAGE_SHIFT;
> -	rdev_p->qpmask = (65536 >> ilog2(rdev_p->qpnr)) - 1;
> -	pr_debug("%s rnic %s info: tpt_base 0x%0x tpt_top 0x%0x num stags %d pbl_base 0x%0x pbl_top 0x%0x rqt_base 0x%0x, rqt_top 0x%0x\n",
> -		 __func__, rdev_p->dev_name, rdev_p->rnic_info.tpt_base,
> -		 rdev_p->rnic_info.tpt_top, cxio_num_stags(rdev_p),
> -		 rdev_p->rnic_info.pbl_base,
> -		 rdev_p->rnic_info.pbl_top, rdev_p->rnic_info.rqt_base,
> -		 rdev_p->rnic_info.rqt_top);
> -	pr_debug("udbell_len 0x%0x udbell_physbase 0x%lx kdb_addr %p qpshift %lu qpnr %d qpmask 0x%x\n",
> -		 rdev_p->rnic_info.udbell_len,
> -		 rdev_p->rnic_info.udbell_physbase, rdev_p->rnic_info.kdb_addr,
> -		 rdev_p->qpshift, rdev_p->qpnr, rdev_p->qpmask);
> -
> -	err = cxio_hal_init_ctrl_qp(rdev_p);
> -	if (err) {
> -		pr_err("%s error %d initializing ctrl_qp\n", __func__, err);
> -		goto err1;
> -	}
> -	err = cxio_hal_init_resource(rdev_p, cxio_num_stags(rdev_p), 0,
> -				     0, T3_MAX_NUM_QP, T3_MAX_NUM_CQ,
> -				     T3_MAX_NUM_PD);
> -	if (err) {
> -		pr_err("%s error %d initializing hal resources\n",
> -		       __func__, err);
> -		goto err2;
> -	}
> -	err = cxio_hal_pblpool_create(rdev_p);
> -	if (err) {
> -		pr_err("%s error %d initializing pbl mem pool\n",
> -		       __func__, err);
> -		goto err3;
> -	}
> -	err = cxio_hal_rqtpool_create(rdev_p);
> -	if (err) {
> -		pr_err("%s error %d initializing rqt mem pool\n",
> -		       __func__, err);
> -		goto err4;
> -	}
> -	return 0;
> -err4:
> -	cxio_hal_pblpool_destroy(rdev_p);
> -err3:
> -	cxio_hal_destroy_resource(rdev_p->rscp);
> -err2:
> -	cxio_hal_destroy_ctrl_qp(rdev_p);
> -err1:
> -	rdev_p->t3cdev_p->ulp = NULL;
> -	list_del(&rdev_p->entry);
> -	return err;
> -}
> -
> -void cxio_rdev_close(struct cxio_rdev *rdev_p)
> -{
> -	if (rdev_p) {
> -		cxio_hal_pblpool_destroy(rdev_p);
> -		cxio_hal_rqtpool_destroy(rdev_p);
> -		list_del(&rdev_p->entry);
> -		cxio_hal_destroy_ctrl_qp(rdev_p);
> -		cxio_hal_destroy_resource(rdev_p->rscp);
> -		rdev_p->t3cdev_p->ulp = NULL;
> -	}
> -}
> -
> -int __init cxio_hal_init(void)
> -{
> -	if (cxio_hal_init_rhdl_resource(T3_MAX_NUM_RI))
> -		return -ENOMEM;
> -	t3_register_cpl_handler(CPL_ASYNC_NOTIF, cxio_hal_ev_handler);
> -	return 0;
> -}
> -
> -void __exit cxio_hal_exit(void)
> -{
> -	struct cxio_rdev *rdev, *tmp;
> -
> -	t3_register_cpl_handler(CPL_ASYNC_NOTIF, NULL);
> -	list_for_each_entry_safe(rdev, tmp, &rdev_list, entry)
> -		cxio_rdev_close(rdev);
> -	cxio_hal_destroy_rhdl_resource();
> -}
> -
> -static void flush_completed_wrs(struct t3_wq *wq, struct t3_cq *cq)
> -{
> -	struct t3_swsq *sqp;
> -	__u32 ptr = wq->sq_rptr;
> -	int count = Q_COUNT(wq->sq_rptr, wq->sq_wptr);
> -
> -	sqp = wq->sq + Q_PTR2IDX(ptr, wq->sq_size_log2);
> -	while (count--)
> -		if (!sqp->signaled) {
> -			ptr++;
> -			sqp = wq->sq + Q_PTR2IDX(ptr,  wq->sq_size_log2);
> -		} else if (sqp->complete) {
> -
> -			/*
> -			 * Insert this completed cqe into the swcq.
> -			 */
> -			pr_debug("%s moving cqe into swcq sq idx %ld cq idx %ld\n",
> -				 __func__, Q_PTR2IDX(ptr,  wq->sq_size_log2),
> -				 Q_PTR2IDX(cq->sw_wptr, cq->size_log2));
> -			sqp->cqe.header |= htonl(V_CQE_SWCQE(1));
> -			*(cq->sw_queue + Q_PTR2IDX(cq->sw_wptr, cq->size_log2))
> -				= sqp->cqe;
> -			cq->sw_wptr++;
> -			sqp->signaled = 0;
> -			break;
> -		} else
> -			break;
> -}
> -
> -static void create_read_req_cqe(struct t3_wq *wq, struct t3_cqe *hw_cqe,
> -				struct t3_cqe *read_cqe)
> -{
> -	read_cqe->u.scqe.wrid_hi = wq->oldest_read->sq_wptr;
> -	read_cqe->len = wq->oldest_read->read_len;
> -	read_cqe->header = htonl(V_CQE_QPID(CQE_QPID(*hw_cqe)) |
> -				 V_CQE_SWCQE(SW_CQE(*hw_cqe)) |
> -				 V_CQE_OPCODE(T3_READ_REQ) |
> -				 V_CQE_TYPE(1));
> -}
> -
> -/*
> - * Return a ptr to the next read wr in the SWSQ or NULL.
> - */
> -static void advance_oldest_read(struct t3_wq *wq)
> -{
> -
> -	u32 rptr = wq->oldest_read - wq->sq + 1;
> -	u32 wptr = Q_PTR2IDX(wq->sq_wptr, wq->sq_size_log2);
> -
> -	while (Q_PTR2IDX(rptr, wq->sq_size_log2) != wptr) {
> -		wq->oldest_read = wq->sq + Q_PTR2IDX(rptr, wq->sq_size_log2);
> -
> -		if (wq->oldest_read->opcode == T3_READ_REQ)
> -			return;
> -		rptr++;
> -	}
> -	wq->oldest_read = NULL;
> -}
> -
> -/*
> - * cxio_poll_cq
> - *
> - * Caller must:
> - *     check the validity of the first CQE,
> - *     supply the wq assicated with the qpid.
> - *
> - * credit: cq credit to return to sge.
> - * cqe_flushed: 1 iff the CQE is flushed.
> - * cqe: copy of the polled CQE.
> - *
> - * return value:
> - *     0       CQE returned,
> - *    -1       CQE skipped, try again.
> - */
> -int cxio_poll_cq(struct t3_wq *wq, struct t3_cq *cq, struct t3_cqe *cqe,
> -		     u8 *cqe_flushed, u64 *cookie, u32 *credit)
> -{
> -	int ret = 0;
> -	struct t3_cqe *hw_cqe, read_cqe;
> -
> -	*cqe_flushed = 0;
> -	*credit = 0;
> -	hw_cqe = cxio_next_cqe(cq);
> -
> -	pr_debug("%s CQE OOO %d qpid 0x%0x genbit %d type %d status 0x%0x opcode 0x%0x len 0x%0x wrid_hi_stag 0x%x wrid_low_msn 0x%x\n",
> -		 __func__, CQE_OOO(*hw_cqe), CQE_QPID(*hw_cqe),
> -		 CQE_GENBIT(*hw_cqe), CQE_TYPE(*hw_cqe), CQE_STATUS(*hw_cqe),
> -		 CQE_OPCODE(*hw_cqe), CQE_LEN(*hw_cqe), CQE_WRID_HI(*hw_cqe),
> -		 CQE_WRID_LOW(*hw_cqe));
> -
> -	/*
> -	 * skip cqe's not affiliated with a QP.
> -	 */
> -	if (wq == NULL) {
> -		ret = -1;
> -		goto skip_cqe;
> -	}
> -
> -	/*
> -	 * Gotta tweak READ completions:
> -	 *	1) the cqe doesn't contain the sq_wptr from the wr.
> -	 *	2) opcode not reflected from the wr.
> -	 *	3) read_len not reflected from the wr.
> -	 *	4) cq_type is RQ_TYPE not SQ_TYPE.
> -	 */
> -	if (RQ_TYPE(*hw_cqe) && (CQE_OPCODE(*hw_cqe) == T3_READ_RESP)) {
> -
> -		/*
> -		 * If this is an unsolicited read response, then the read
> -		 * was generated by the kernel driver as part of peer-2-peer
> -		 * connection setup.  So ignore the completion.
> -		 */
> -		if (!wq->oldest_read) {
> -			if (CQE_STATUS(*hw_cqe))
> -				wq->error = 1;
> -			ret = -1;
> -			goto skip_cqe;
> -		}
> -
> -		/*
> -		 * Don't write to the HWCQ, so create a new read req CQE
> -		 * in local memory.
> -		 */
> -		create_read_req_cqe(wq, hw_cqe, &read_cqe);
> -		hw_cqe = &read_cqe;
> -		advance_oldest_read(wq);
> -	}
> -
> -	/*
> -	 * T3A: Discard TERMINATE CQEs.
> -	 */
> -	if (CQE_OPCODE(*hw_cqe) == T3_TERMINATE) {
> -		ret = -1;
> -		wq->error = 1;
> -		goto skip_cqe;
> -	}
> -
> -	if (CQE_STATUS(*hw_cqe) || wq->error) {
> -		*cqe_flushed = wq->error;
> -		wq->error = 1;
> -
> -		/*
> -		 * T3A inserts errors into the CQE.  We cannot return
> -		 * these as work completions.
> -		 */
> -		/* incoming write failures */
> -		if ((CQE_OPCODE(*hw_cqe) == T3_RDMA_WRITE)
> -		     && RQ_TYPE(*hw_cqe)) {
> -			ret = -1;
> -			goto skip_cqe;
> -		}
> -		/* incoming read request failures */
> -		if ((CQE_OPCODE(*hw_cqe) == T3_READ_RESP) && SQ_TYPE(*hw_cqe)) {
> -			ret = -1;
> -			goto skip_cqe;
> -		}
> -
> -		/* incoming SEND with no receive posted failures */
> -		if (CQE_SEND_OPCODE(*hw_cqe) && RQ_TYPE(*hw_cqe) &&
> -		    Q_EMPTY(wq->rq_rptr, wq->rq_wptr)) {
> -			ret = -1;
> -			goto skip_cqe;
> -		}
> -		BUG_ON((*cqe_flushed == 0) && !SW_CQE(*hw_cqe));
> -		goto proc_cqe;
> -	}
> -
> -	/*
> -	 * RECV completion.
> -	 */
> -	if (RQ_TYPE(*hw_cqe)) {
> -
> -		/*
> -		 * HW only validates 4 bits of MSN.  So we must validate that
> -		 * the MSN in the SEND is the next expected MSN.  If its not,
> -		 * then we complete this with TPT_ERR_MSN and mark the wq in
> -		 * error.
> -		 */
> -
> -		if (Q_EMPTY(wq->rq_rptr, wq->rq_wptr)) {
> -			wq->error = 1;
> -			ret = -1;
> -			goto skip_cqe;
> -		}
> -
> -		if (unlikely((CQE_WRID_MSN(*hw_cqe) != (wq->rq_rptr + 1)))) {
> -			wq->error = 1;
> -			hw_cqe->header |= htonl(V_CQE_STATUS(TPT_ERR_MSN));
> -			goto proc_cqe;
> -		}
> -		goto proc_cqe;
> -	}
> -
> -	/*
> -	 * If we get here its a send completion.
> -	 *
> -	 * Handle out of order completion. These get stuffed
> -	 * in the SW SQ. Then the SW SQ is walked to move any
> -	 * now in-order completions into the SW CQ.  This handles
> -	 * 2 cases:
> -	 *	1) reaping unsignaled WRs when the first subsequent
> -	 *	   signaled WR is completed.
> -	 *	2) out of order read completions.
> -	 */
> -	if (!SW_CQE(*hw_cqe) && (CQE_WRID_SQ_WPTR(*hw_cqe) != wq->sq_rptr)) {
> -		struct t3_swsq *sqp;
> -
> -		pr_debug("%s out of order completion going in swsq at idx %ld\n",
> -			 __func__,
> -			 Q_PTR2IDX(CQE_WRID_SQ_WPTR(*hw_cqe),
> -				   wq->sq_size_log2));
> -		sqp = wq->sq +
> -		      Q_PTR2IDX(CQE_WRID_SQ_WPTR(*hw_cqe), wq->sq_size_log2);
> -		sqp->cqe = *hw_cqe;
> -		sqp->complete = 1;
> -		ret = -1;
> -		goto flush_wq;
> -	}
> -
> -proc_cqe:
> -	*cqe = *hw_cqe;
> -
> -	/*
> -	 * Reap the associated WR(s) that are freed up with this
> -	 * completion.
> -	 */
> -	if (SQ_TYPE(*hw_cqe)) {
> -		wq->sq_rptr = CQE_WRID_SQ_WPTR(*hw_cqe);
> -		pr_debug("%s completing sq idx %ld\n", __func__,
> -			 Q_PTR2IDX(wq->sq_rptr, wq->sq_size_log2));
> -		*cookie = wq->sq[Q_PTR2IDX(wq->sq_rptr, wq->sq_size_log2)].wr_id;
> -		wq->sq_rptr++;
> -	} else {
> -		pr_debug("%s completing rq idx %ld\n", __func__,
> -			 Q_PTR2IDX(wq->rq_rptr, wq->rq_size_log2));
> -		*cookie = wq->rq[Q_PTR2IDX(wq->rq_rptr, wq->rq_size_log2)].wr_id;
> -		if (wq->rq[Q_PTR2IDX(wq->rq_rptr, wq->rq_size_log2)].pbl_addr)
> -			cxio_hal_pblpool_free(wq->rdev,
> -				wq->rq[Q_PTR2IDX(wq->rq_rptr,
> -				wq->rq_size_log2)].pbl_addr, T3_STAG0_PBL_SIZE);
> -		BUG_ON(Q_EMPTY(wq->rq_rptr, wq->rq_wptr));
> -		wq->rq_rptr++;
> -	}
> -
> -flush_wq:
> -	/*
> -	 * Flush any completed cqes that are now in-order.
> -	 */
> -	flush_completed_wrs(wq, cq);
> -
> -skip_cqe:
> -	if (SW_CQE(*hw_cqe)) {
> -		pr_debug("%s cq %p cqid 0x%x skip sw cqe sw_rptr 0x%x\n",
> -			 __func__, cq, cq->cqid, cq->sw_rptr);
> -		++cq->sw_rptr;
> -	} else {
> -		pr_debug("%s cq %p cqid 0x%x skip hw cqe rptr 0x%x\n",
> -			 __func__, cq, cq->cqid, cq->rptr);
> -		++cq->rptr;
> -
> -		/*
> -		 * T3A: compute credits.
> -		 */
> -		if (((cq->rptr - cq->wptr) > (1 << (cq->size_log2 - 1)))
> -		    || ((cq->rptr - cq->wptr) >= 128)) {
> -			*credit = cq->rptr - cq->wptr;
> -			cq->wptr = cq->rptr;
> -		}
> -	}
> -	return ret;
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.h b/drivers/infiniband/hw/cxgb3/cxio_hal.h
> deleted file mode 100644
> index 40c029ffa425..000000000000
> --- a/drivers/infiniband/hw/cxgb3/cxio_hal.h
> +++ /dev/null
> @@ -1,204 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef  __CXIO_HAL_H__
> -#define  __CXIO_HAL_H__
> -
> -#include <linux/list.h>
> -#include <linux/mutex.h>
> -#include <linux/kfifo.h>
> -
> -#include "t3_cpl.h"
> -#include "t3cdev.h"
> -#include "cxgb3_ctl_defs.h"
> -#include "cxio_wr.h"
> -
> -#define T3_CTRL_QP_ID    FW_RI_SGEEC_START
> -#define T3_CTL_QP_TID	 FW_RI_TID_START
> -#define T3_CTRL_QP_SIZE_LOG2  8
> -#define T3_CTRL_CQ_ID    0
> -
> -#define T3_MAX_NUM_RI (1<<15)
> -#define T3_MAX_NUM_QP (1<<15)
> -#define T3_MAX_NUM_CQ (1<<15)
> -#define T3_MAX_NUM_PD (1<<15)
> -#define T3_MAX_PBL_SIZE 256
> -#define T3_MAX_RQ_SIZE 1024
> -#define T3_MAX_QP_DEPTH (T3_MAX_RQ_SIZE-1)
> -#define T3_MAX_CQ_DEPTH 65536
> -#define T3_MAX_NUM_STAG (1<<15)
> -#define T3_MAX_MR_SIZE 0x100000000ULL
> -#define T3_PAGESIZE_MASK 0xffff000  /* 4KB-128MB */
> -
> -#define T3_STAG_UNSET 0xffffffff
> -
> -#define T3_MAX_DEV_NAME_LEN 32
> -
> -#define CXIO_FW_MAJ 7
> -
> -struct cxio_hal_ctrl_qp {
> -	u32 wptr;
> -	u32 rptr;
> -	struct mutex lock;	/* for the wtpr, can sleep */
> -	wait_queue_head_t waitq;/* wait for RspQ/CQE msg */
> -	union t3_wr *workq;	/* the work request queue */
> -	dma_addr_t dma_addr;	/* pci bus address of the workq */
> -	DEFINE_DMA_UNMAP_ADDR(mapping);
> -	void __iomem *doorbell;
> -};
> -
> -struct cxio_hal_resource {
> -	struct kfifo tpt_fifo;
> -	spinlock_t tpt_fifo_lock;
> -	struct kfifo qpid_fifo;
> -	spinlock_t qpid_fifo_lock;
> -	struct kfifo cqid_fifo;
> -	spinlock_t cqid_fifo_lock;
> -	struct kfifo pdid_fifo;
> -	spinlock_t pdid_fifo_lock;
> -};
> -
> -struct cxio_qpid_list {
> -	struct list_head entry;
> -	u32 qpid;
> -};
> -
> -struct cxio_ucontext {
> -	struct list_head qpids;
> -	struct mutex lock;
> -};
> -
> -struct cxio_rdev {
> -	char dev_name[T3_MAX_DEV_NAME_LEN];
> -	struct t3cdev *t3cdev_p;
> -	struct rdma_info rnic_info;
> -	struct adap_ports port_info;
> -	struct cxio_hal_resource *rscp;
> -	struct cxio_hal_ctrl_qp ctrl_qp;
> -	void *ulp;
> -	unsigned long qpshift;
> -	u32 qpnr;
> -	u32 qpmask;
> -	struct cxio_ucontext uctx;
> -	struct gen_pool *pbl_pool;
> -	struct gen_pool *rqt_pool;
> -	struct list_head entry;
> -	struct ch_embedded_info fw_info;
> -	u32	flags;
> -#define	CXIO_ERROR_FATAL	1
> -};
> -
> -static inline int cxio_fatal_error(struct cxio_rdev *rdev_p)
> -{
> -	return rdev_p->flags & CXIO_ERROR_FATAL;
> -}
> -
> -static inline int cxio_num_stags(struct cxio_rdev *rdev_p)
> -{
> -	return min((int)T3_MAX_NUM_STAG, (int)((rdev_p->rnic_info.tpt_top - rdev_p->rnic_info.tpt_base) >> 5));
> -}
> -
> -typedef void (*cxio_hal_ev_callback_func_t) (struct cxio_rdev * rdev_p,
> -					     struct sk_buff * skb);
> -
> -#define RSPQ_CQID(rsp) (be32_to_cpu(rsp->cq_ptrid) & 0xffff)
> -#define RSPQ_CQPTR(rsp) ((be32_to_cpu(rsp->cq_ptrid) >> 16) & 0xffff)
> -#define RSPQ_GENBIT(rsp) ((be32_to_cpu(rsp->flags) >> 16) & 1)
> -#define RSPQ_OVERFLOW(rsp) ((be32_to_cpu(rsp->flags) >> 17) & 1)
> -#define RSPQ_AN(rsp) ((be32_to_cpu(rsp->flags) >> 18) & 1)
> -#define RSPQ_SE(rsp) ((be32_to_cpu(rsp->flags) >> 19) & 1)
> -#define RSPQ_NOTIFY(rsp) ((be32_to_cpu(rsp->flags) >> 20) & 1)
> -#define RSPQ_CQBRANCH(rsp) ((be32_to_cpu(rsp->flags) >> 21) & 1)
> -#define RSPQ_CREDIT_THRESH(rsp) ((be32_to_cpu(rsp->flags) >> 22) & 1)
> -
> -struct respQ_msg_t {
> -	__be32 flags;		/* flit 0 */
> -	__be32 cq_ptrid;
> -	__be64 rsvd;		/* flit 1 */
> -	struct t3_cqe cqe;	/* flits 2-3 */
> -};
> -
> -enum t3_cq_opcode {
> -	CQ_ARM_AN = 0x2,
> -	CQ_ARM_SE = 0x6,
> -	CQ_FORCE_AN = 0x3,
> -	CQ_CREDIT_UPDATE = 0x7
> -};
> -
> -int cxio_rdev_open(struct cxio_rdev *rdev);
> -void cxio_rdev_close(struct cxio_rdev *rdev);
> -int cxio_hal_cq_op(struct cxio_rdev *rdev, struct t3_cq *cq,
> -		   enum t3_cq_opcode op, u32 credit);
> -int cxio_create_cq(struct cxio_rdev *rdev, struct t3_cq *cq, int kernel);
> -void cxio_destroy_cq(struct cxio_rdev *rdev, struct t3_cq *cq);
> -void cxio_release_ucontext(struct cxio_rdev *rdev, struct cxio_ucontext *uctx);
> -void cxio_init_ucontext(struct cxio_rdev *rdev, struct cxio_ucontext *uctx);
> -int cxio_create_qp(struct cxio_rdev *rdev, u32 kernel_domain, struct t3_wq *wq,
> -		   struct cxio_ucontext *uctx);
> -int cxio_destroy_qp(struct cxio_rdev *rdev, struct t3_wq *wq,
> -		    struct cxio_ucontext *uctx);
> -int cxio_peek_cq(struct t3_wq *wr, struct t3_cq *cq, int opcode);
> -int cxio_write_pbl(struct cxio_rdev *rdev_p, __be64 *pbl,
> -		   u32 pbl_addr, u32 pbl_size);
> -int cxio_register_phys_mem(struct cxio_rdev *rdev, u32 * stag, u32 pdid,
> -			   enum tpt_mem_perm perm, u32 zbva, u64 to, u32 len,
> -			   u8 page_size, u32 pbl_size, u32 pbl_addr);
> -int cxio_reregister_phys_mem(struct cxio_rdev *rdev, u32 * stag, u32 pdid,
> -			   enum tpt_mem_perm perm, u32 zbva, u64 to, u32 len,
> -			   u8 page_size, u32 pbl_size, u32 pbl_addr);
> -int cxio_dereg_mem(struct cxio_rdev *rdev, u32 stag, u32 pbl_size,
> -		   u32 pbl_addr);
> -int cxio_allocate_window(struct cxio_rdev *rdev, u32 * stag, u32 pdid);
> -int cxio_allocate_stag(struct cxio_rdev *rdev, u32 *stag, u32 pdid, u32 pbl_size, u32 pbl_addr);
> -int cxio_deallocate_window(struct cxio_rdev *rdev, u32 stag);
> -int cxio_rdma_init(struct cxio_rdev *rdev, struct t3_rdma_init_attr *attr);
> -void cxio_register_ev_cb(cxio_hal_ev_callback_func_t ev_cb);
> -void cxio_unregister_ev_cb(cxio_hal_ev_callback_func_t ev_cb);
> -u32 cxio_hal_get_pdid(struct cxio_hal_resource *rscp);
> -void cxio_hal_put_pdid(struct cxio_hal_resource *rscp, u32 pdid);
> -int __init cxio_hal_init(void);
> -void __exit cxio_hal_exit(void);
> -int cxio_flush_rq(struct t3_wq *wq, struct t3_cq *cq, int count);
> -int cxio_flush_sq(struct t3_wq *wq, struct t3_cq *cq, int count);
> -void cxio_count_rcqes(struct t3_cq *cq, struct t3_wq *wq, int *count);
> -void cxio_count_scqes(struct t3_cq *cq, struct t3_wq *wq, int *count);
> -void cxio_flush_hw_cq(struct t3_cq *cq);
> -int cxio_poll_cq(struct t3_wq *wq, struct t3_cq *cq, struct t3_cqe *cqe,
> -		     u8 *cqe_flushed, u64 *cookie, u32 *credit);
> -int iwch_cxgb3_ofld_send(struct t3cdev *tdev, struct sk_buff *skb);
> -
> -#ifdef pr_fmt
> -#undef pr_fmt
> -#endif
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#endif
> diff --git a/drivers/infiniband/hw/cxgb3/cxio_resource.c b/drivers/infiniband/hw/cxgb3/cxio_resource.c
> deleted file mode 100644
> index c6e7bc4420b6..000000000000
> --- a/drivers/infiniband/hw/cxgb3/cxio_resource.c
> +++ /dev/null
> @@ -1,344 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -/* Crude resource management */
> -#include <linux/kernel.h>
> -#include <linux/random.h>
> -#include <linux/slab.h>
> -#include <linux/kfifo.h>
> -#include <linux/spinlock.h>
> -#include <linux/errno.h>
> -#include "cxio_resource.h"
> -#include "cxio_hal.h"
> -
> -static struct kfifo rhdl_fifo;
> -static spinlock_t rhdl_fifo_lock;
> -
> -#define RANDOM_SIZE 16
> -
> -static int __cxio_init_resource_fifo(struct kfifo *fifo,
> -				   spinlock_t *fifo_lock,
> -				   u32 nr, u32 skip_low,
> -				   u32 skip_high,
> -				   int random)
> -{
> -	u32 i, j, entry = 0, idx;
> -	u32 random_bytes;
> -	u32 rarray[16];
> -	spin_lock_init(fifo_lock);
> -
> -	if (kfifo_alloc(fifo, nr * sizeof(u32), GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	for (i = 0; i < skip_low + skip_high; i++)
> -		kfifo_in(fifo, (unsigned char *) &entry, sizeof(u32));
> -	if (random) {
> -		j = 0;
> -		random_bytes = prandom_u32();
> -		for (i = 0; i < RANDOM_SIZE; i++)
> -			rarray[i] = i + skip_low;
> -		for (i = skip_low + RANDOM_SIZE; i < nr - skip_high; i++) {
> -			if (j >= RANDOM_SIZE) {
> -				j = 0;
> -				random_bytes = prandom_u32();
> -			}
> -			idx = (random_bytes >> (j * 2)) & 0xF;
> -			kfifo_in(fifo,
> -				(unsigned char *) &rarray[idx],
> -				sizeof(u32));
> -			rarray[idx] = i;
> -			j++;
> -		}
> -		for (i = 0; i < RANDOM_SIZE; i++)
> -			kfifo_in(fifo,
> -				(unsigned char *) &rarray[i],
> -				sizeof(u32));
> -	} else
> -		for (i = skip_low; i < nr - skip_high; i++)
> -			kfifo_in(fifo, (unsigned char *) &i, sizeof(u32));
> -
> -	for (i = 0; i < skip_low + skip_high; i++)
> -		if (kfifo_out_locked(fifo, (unsigned char *) &entry,
> -				sizeof(u32), fifo_lock) != sizeof(u32))
> -					break;
> -	return 0;
> -}
> -
> -static int cxio_init_resource_fifo(struct kfifo *fifo, spinlock_t * fifo_lock,
> -				   u32 nr, u32 skip_low, u32 skip_high)
> -{
> -	return (__cxio_init_resource_fifo(fifo, fifo_lock, nr, skip_low,
> -					  skip_high, 0));
> -}
> -
> -static int cxio_init_resource_fifo_random(struct kfifo *fifo,
> -				   spinlock_t * fifo_lock,
> -				   u32 nr, u32 skip_low, u32 skip_high)
> -{
> -
> -	return (__cxio_init_resource_fifo(fifo, fifo_lock, nr, skip_low,
> -					  skip_high, 1));
> -}
> -
> -static int cxio_init_qpid_fifo(struct cxio_rdev *rdev_p)
> -{
> -	u32 i;
> -
> -	spin_lock_init(&rdev_p->rscp->qpid_fifo_lock);
> -
> -	if (kfifo_alloc(&rdev_p->rscp->qpid_fifo, T3_MAX_NUM_QP * sizeof(u32),
> -					      GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	for (i = 16; i < T3_MAX_NUM_QP; i++)
> -		if (!(i & rdev_p->qpmask))
> -			kfifo_in(&rdev_p->rscp->qpid_fifo,
> -				    (unsigned char *) &i, sizeof(u32));
> -	return 0;
> -}
> -
> -int cxio_hal_init_rhdl_resource(u32 nr_rhdl)
> -{
> -	return cxio_init_resource_fifo(&rhdl_fifo, &rhdl_fifo_lock, nr_rhdl, 1,
> -				       0);
> -}
> -
> -void cxio_hal_destroy_rhdl_resource(void)
> -{
> -	kfifo_free(&rhdl_fifo);
> -}
> -
> -/* nr_* must be power of 2 */
> -int cxio_hal_init_resource(struct cxio_rdev *rdev_p,
> -			   u32 nr_tpt, u32 nr_pbl,
> -			   u32 nr_rqt, u32 nr_qpid, u32 nr_cqid, u32 nr_pdid)
> -{
> -	int err = 0;
> -	struct cxio_hal_resource *rscp;
> -
> -	rscp = kmalloc(sizeof(*rscp), GFP_KERNEL);
> -	if (!rscp)
> -		return -ENOMEM;
> -	rdev_p->rscp = rscp;
> -	err = cxio_init_resource_fifo_random(&rscp->tpt_fifo,
> -				      &rscp->tpt_fifo_lock,
> -				      nr_tpt, 1, 0);
> -	if (err)
> -		goto tpt_err;
> -	err = cxio_init_qpid_fifo(rdev_p);
> -	if (err)
> -		goto qpid_err;
> -	err = cxio_init_resource_fifo(&rscp->cqid_fifo, &rscp->cqid_fifo_lock,
> -				      nr_cqid, 1, 0);
> -	if (err)
> -		goto cqid_err;
> -	err = cxio_init_resource_fifo(&rscp->pdid_fifo, &rscp->pdid_fifo_lock,
> -				      nr_pdid, 1, 0);
> -	if (err)
> -		goto pdid_err;
> -	return 0;
> -pdid_err:
> -	kfifo_free(&rscp->cqid_fifo);
> -cqid_err:
> -	kfifo_free(&rscp->qpid_fifo);
> -qpid_err:
> -	kfifo_free(&rscp->tpt_fifo);
> -tpt_err:
> -	return -ENOMEM;
> -}
> -
> -/*
> - * returns 0 if no resource available
> - */
> -static u32 cxio_hal_get_resource(struct kfifo *fifo, spinlock_t * lock)
> -{
> -	u32 entry;
> -	if (kfifo_out_locked(fifo, (unsigned char *) &entry, sizeof(u32), lock))
> -		return entry;
> -	else
> -		return 0;	/* fifo emptry */
> -}
> -
> -static void cxio_hal_put_resource(struct kfifo *fifo, spinlock_t * lock,
> -		u32 entry)
> -{
> -	BUG_ON(
> -	kfifo_in_locked(fifo, (unsigned char *) &entry, sizeof(u32), lock)
> -	== 0);
> -}
> -
> -u32 cxio_hal_get_stag(struct cxio_hal_resource *rscp)
> -{
> -	return cxio_hal_get_resource(&rscp->tpt_fifo, &rscp->tpt_fifo_lock);
> -}
> -
> -void cxio_hal_put_stag(struct cxio_hal_resource *rscp, u32 stag)
> -{
> -	cxio_hal_put_resource(&rscp->tpt_fifo, &rscp->tpt_fifo_lock, stag);
> -}
> -
> -u32 cxio_hal_get_qpid(struct cxio_hal_resource *rscp)
> -{
> -	u32 qpid = cxio_hal_get_resource(&rscp->qpid_fifo,
> -			&rscp->qpid_fifo_lock);
> -	pr_debug("%s qpid 0x%x\n", __func__, qpid);
> -	return qpid;
> -}
> -
> -void cxio_hal_put_qpid(struct cxio_hal_resource *rscp, u32 qpid)
> -{
> -	pr_debug("%s qpid 0x%x\n", __func__, qpid);
> -	cxio_hal_put_resource(&rscp->qpid_fifo, &rscp->qpid_fifo_lock, qpid);
> -}
> -
> -u32 cxio_hal_get_cqid(struct cxio_hal_resource *rscp)
> -{
> -	return cxio_hal_get_resource(&rscp->cqid_fifo, &rscp->cqid_fifo_lock);
> -}
> -
> -void cxio_hal_put_cqid(struct cxio_hal_resource *rscp, u32 cqid)
> -{
> -	cxio_hal_put_resource(&rscp->cqid_fifo, &rscp->cqid_fifo_lock, cqid);
> -}
> -
> -u32 cxio_hal_get_pdid(struct cxio_hal_resource *rscp)
> -{
> -	return cxio_hal_get_resource(&rscp->pdid_fifo, &rscp->pdid_fifo_lock);
> -}
> -
> -void cxio_hal_put_pdid(struct cxio_hal_resource *rscp, u32 pdid)
> -{
> -	cxio_hal_put_resource(&rscp->pdid_fifo, &rscp->pdid_fifo_lock, pdid);
> -}
> -
> -void cxio_hal_destroy_resource(struct cxio_hal_resource *rscp)
> -{
> -	kfifo_free(&rscp->tpt_fifo);
> -	kfifo_free(&rscp->cqid_fifo);
> -	kfifo_free(&rscp->qpid_fifo);
> -	kfifo_free(&rscp->pdid_fifo);
> -	kfree(rscp);
> -}
> -
> -/*
> - * PBL Memory Manager.  Uses Linux generic allocator.
> - */
> -
> -#define MIN_PBL_SHIFT 8			/* 256B == min PBL size (32 entries) */
> -
> -u32 cxio_hal_pblpool_alloc(struct cxio_rdev *rdev_p, int size)
> -{
> -	unsigned long addr = gen_pool_alloc(rdev_p->pbl_pool, size);
> -	pr_debug("%s addr 0x%x size %d\n", __func__, (u32)addr, size);
> -	return (u32)addr;
> -}
> -
> -void cxio_hal_pblpool_free(struct cxio_rdev *rdev_p, u32 addr, int size)
> -{
> -	pr_debug("%s addr 0x%x size %d\n", __func__, addr, size);
> -	gen_pool_free(rdev_p->pbl_pool, (unsigned long)addr, size);
> -}
> -
> -int cxio_hal_pblpool_create(struct cxio_rdev *rdev_p)
> -{
> -	unsigned pbl_start, pbl_chunk;
> -
> -	rdev_p->pbl_pool = gen_pool_create(MIN_PBL_SHIFT, -1);
> -	if (!rdev_p->pbl_pool)
> -		return -ENOMEM;
> -
> -	pbl_start = rdev_p->rnic_info.pbl_base;
> -	pbl_chunk = rdev_p->rnic_info.pbl_top - pbl_start + 1;
> -
> -	while (pbl_start < rdev_p->rnic_info.pbl_top) {
> -		pbl_chunk = min(rdev_p->rnic_info.pbl_top - pbl_start + 1,
> -				pbl_chunk);
> -		if (gen_pool_add(rdev_p->pbl_pool, pbl_start, pbl_chunk, -1)) {
> -			pr_debug("%s failed to add PBL chunk (%x/%x)\n",
> -				 __func__, pbl_start, pbl_chunk);
> -			if (pbl_chunk <= 1024 << MIN_PBL_SHIFT) {
> -				pr_warn("%s: Failed to add all PBL chunks (%x/%x)\n",
> -					__func__, pbl_start,
> -					rdev_p->rnic_info.pbl_top - pbl_start);
> -				return 0;
> -			}
> -			pbl_chunk >>= 1;
> -		} else {
> -			pr_debug("%s added PBL chunk (%x/%x)\n",
> -				 __func__, pbl_start, pbl_chunk);
> -			pbl_start += pbl_chunk;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -void cxio_hal_pblpool_destroy(struct cxio_rdev *rdev_p)
> -{
> -	gen_pool_destroy(rdev_p->pbl_pool);
> -}
> -
> -/*
> - * RQT Memory Manager.  Uses Linux generic allocator.
> - */
> -
> -#define MIN_RQT_SHIFT 10	/* 1KB == mini RQT size (16 entries) */
> -#define RQT_CHUNK 2*1024*1024
> -
> -u32 cxio_hal_rqtpool_alloc(struct cxio_rdev *rdev_p, int size)
> -{
> -	unsigned long addr = gen_pool_alloc(rdev_p->rqt_pool, size << 6);
> -	pr_debug("%s addr 0x%x size %d\n", __func__, (u32)addr, size << 6);
> -	return (u32)addr;
> -}
> -
> -void cxio_hal_rqtpool_free(struct cxio_rdev *rdev_p, u32 addr, int size)
> -{
> -	pr_debug("%s addr 0x%x size %d\n", __func__, addr, size << 6);
> -	gen_pool_free(rdev_p->rqt_pool, (unsigned long)addr, size << 6);
> -}
> -
> -int cxio_hal_rqtpool_create(struct cxio_rdev *rdev_p)
> -{
> -	unsigned long i;
> -	rdev_p->rqt_pool = gen_pool_create(MIN_RQT_SHIFT, -1);
> -	if (rdev_p->rqt_pool)
> -		for (i = rdev_p->rnic_info.rqt_base;
> -		     i <= rdev_p->rnic_info.rqt_top - RQT_CHUNK + 1;
> -		     i += RQT_CHUNK)
> -			gen_pool_add(rdev_p->rqt_pool, i, RQT_CHUNK, -1);
> -	return rdev_p->rqt_pool ? 0 : -ENOMEM;
> -}
> -
> -void cxio_hal_rqtpool_destroy(struct cxio_rdev *rdev_p)
> -{
> -	gen_pool_destroy(rdev_p->rqt_pool);
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/cxio_resource.h b/drivers/infiniband/hw/cxgb3/cxio_resource.h
> deleted file mode 100644
> index a2703a3d882d..000000000000
> --- a/drivers/infiniband/hw/cxgb3/cxio_resource.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef __CXIO_RESOURCE_H__
> -#define __CXIO_RESOURCE_H__
> -
> -#include <linux/kernel.h>
> -#include <linux/random.h>
> -#include <linux/slab.h>
> -#include <linux/kfifo.h>
> -#include <linux/spinlock.h>
> -#include <linux/errno.h>
> -#include <linux/genalloc.h>
> -#include "cxio_hal.h"
> -
> -extern int cxio_hal_init_rhdl_resource(u32 nr_rhdl);
> -extern void cxio_hal_destroy_rhdl_resource(void);
> -extern int cxio_hal_init_resource(struct cxio_rdev *rdev_p,
> -				  u32 nr_tpt, u32 nr_pbl,
> -				  u32 nr_rqt, u32 nr_qpid, u32 nr_cqid,
> -				  u32 nr_pdid);
> -extern u32 cxio_hal_get_stag(struct cxio_hal_resource *rscp);
> -extern void cxio_hal_put_stag(struct cxio_hal_resource *rscp, u32 stag);
> -extern u32 cxio_hal_get_qpid(struct cxio_hal_resource *rscp);
> -extern void cxio_hal_put_qpid(struct cxio_hal_resource *rscp, u32 qpid);
> -extern u32 cxio_hal_get_cqid(struct cxio_hal_resource *rscp);
> -extern void cxio_hal_put_cqid(struct cxio_hal_resource *rscp, u32 cqid);
> -extern void cxio_hal_destroy_resource(struct cxio_hal_resource *rscp);
> -
> -#define PBL_OFF(rdev_p, a) ( (a) - (rdev_p)->rnic_info.pbl_base )
> -extern int cxio_hal_pblpool_create(struct cxio_rdev *rdev_p);
> -extern void cxio_hal_pblpool_destroy(struct cxio_rdev *rdev_p);
> -extern u32 cxio_hal_pblpool_alloc(struct cxio_rdev *rdev_p, int size);
> -extern void cxio_hal_pblpool_free(struct cxio_rdev *rdev_p, u32 addr, int size);
> -
> -#define RQT_OFF(rdev_p, a) ( (a) - (rdev_p)->rnic_info.rqt_base )
> -extern int cxio_hal_rqtpool_create(struct cxio_rdev *rdev_p);
> -extern void cxio_hal_rqtpool_destroy(struct cxio_rdev *rdev_p);
> -extern u32 cxio_hal_rqtpool_alloc(struct cxio_rdev *rdev_p, int size);
> -extern void cxio_hal_rqtpool_free(struct cxio_rdev *rdev_p, u32 addr, int size);
> -#endif
> diff --git a/drivers/infiniband/hw/cxgb3/cxio_wr.h b/drivers/infiniband/hw/cxgb3/cxio_wr.h
> deleted file mode 100644
> index 53aa5c36247a..000000000000
> --- a/drivers/infiniband/hw/cxgb3/cxio_wr.h
> +++ /dev/null
> @@ -1,802 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef __CXIO_WR_H__
> -#define __CXIO_WR_H__
> -
> -#include <asm/io.h>
> -#include <linux/pci.h>
> -#include <linux/timer.h>
> -#include "firmware_exports.h"
> -
> -#define T3_MAX_SGE      4
> -#define T3_MAX_INLINE	64
> -#define T3_STAG0_PBL_SIZE (2 * T3_MAX_SGE << 3)
> -#define T3_STAG0_MAX_PBE_LEN (128 * 1024 * 1024)
> -#define T3_STAG0_PAGE_SHIFT 15
> -
> -#define Q_EMPTY(rptr,wptr) ((rptr)==(wptr))
> -#define Q_FULL(rptr,wptr,size_log2)  ( (((wptr)-(rptr))>>(size_log2)) && \
> -				       ((rptr)!=(wptr)) )
> -#define Q_GENBIT(ptr,size_log2) (!(((ptr)>>size_log2)&0x1))
> -#define Q_FREECNT(rptr,wptr,size_log2) ((1UL<<size_log2)-((wptr)-(rptr)))
> -#define Q_COUNT(rptr,wptr) ((wptr)-(rptr))
> -#define Q_PTR2IDX(ptr,size_log2) (ptr & ((1UL<<size_log2)-1))
> -
> -static inline void ring_doorbell(void __iomem *doorbell, u32 qpid)
> -{
> -	writel(((1<<31) | qpid), doorbell);
> -}
> -
> -#define SEQ32_GE(x,y) (!( (((u32) (x)) - ((u32) (y))) & 0x80000000 ))
> -
> -enum t3_wr_flags {
> -	T3_COMPLETION_FLAG = 0x01,
> -	T3_NOTIFY_FLAG = 0x02,
> -	T3_SOLICITED_EVENT_FLAG = 0x04,
> -	T3_READ_FENCE_FLAG = 0x08,
> -	T3_LOCAL_FENCE_FLAG = 0x10
> -} __packed;
> -
> -enum t3_wr_opcode {
> -	T3_WR_BP = FW_WROPCODE_RI_BYPASS,
> -	T3_WR_SEND = FW_WROPCODE_RI_SEND,
> -	T3_WR_WRITE = FW_WROPCODE_RI_RDMA_WRITE,
> -	T3_WR_READ = FW_WROPCODE_RI_RDMA_READ,
> -	T3_WR_INV_STAG = FW_WROPCODE_RI_LOCAL_INV,
> -	T3_WR_BIND = FW_WROPCODE_RI_BIND_MW,
> -	T3_WR_RCV = FW_WROPCODE_RI_RECEIVE,
> -	T3_WR_INIT = FW_WROPCODE_RI_RDMA_INIT,
> -	T3_WR_QP_MOD = FW_WROPCODE_RI_MODIFY_QP,
> -	T3_WR_FASTREG = FW_WROPCODE_RI_FASTREGISTER_MR
> -} __packed;
> -
> -enum t3_rdma_opcode {
> -	T3_RDMA_WRITE,		/* IETF RDMAP v1.0 ... */
> -	T3_READ_REQ,
> -	T3_READ_RESP,
> -	T3_SEND,
> -	T3_SEND_WITH_INV,
> -	T3_SEND_WITH_SE,
> -	T3_SEND_WITH_SE_INV,
> -	T3_TERMINATE,
> -	T3_RDMA_INIT,		/* CHELSIO RI specific ... */
> -	T3_BIND_MW,
> -	T3_FAST_REGISTER,
> -	T3_LOCAL_INV,
> -	T3_QP_MOD,
> -	T3_BYPASS,
> -	T3_RDMA_READ_REQ_WITH_INV,
> -} __packed;
> -
> -static inline enum t3_rdma_opcode wr2opcode(enum t3_wr_opcode wrop)
> -{
> -	switch (wrop) {
> -		case T3_WR_BP: return T3_BYPASS;
> -		case T3_WR_SEND: return T3_SEND;
> -		case T3_WR_WRITE: return T3_RDMA_WRITE;
> -		case T3_WR_READ: return T3_READ_REQ;
> -		case T3_WR_INV_STAG: return T3_LOCAL_INV;
> -		case T3_WR_BIND: return T3_BIND_MW;
> -		case T3_WR_INIT: return T3_RDMA_INIT;
> -		case T3_WR_QP_MOD: return T3_QP_MOD;
> -		case T3_WR_FASTREG: return T3_FAST_REGISTER;
> -		default: break;
> -	}
> -	return -1;
> -}
> -
> -
> -/* Work request id */
> -union t3_wrid {
> -	struct {
> -		u32 hi;
> -		u32 low;
> -	} id0;
> -	u64 id1;
> -};
> -
> -#define WRID(wrid)		(wrid.id1)
> -#define WRID_GEN(wrid)		(wrid.id0.wr_gen)
> -#define WRID_IDX(wrid)		(wrid.id0.wr_idx)
> -#define WRID_LO(wrid)		(wrid.id0.wr_lo)
> -
> -struct fw_riwrh {
> -	__be32 op_seop_flags;
> -	__be32 gen_tid_len;
> -};
> -
> -#define S_FW_RIWR_OP		24
> -#define M_FW_RIWR_OP		0xff
> -#define V_FW_RIWR_OP(x)		((x) << S_FW_RIWR_OP)
> -#define G_FW_RIWR_OP(x)	((((x) >> S_FW_RIWR_OP)) & M_FW_RIWR_OP)
> -
> -#define S_FW_RIWR_SOPEOP	22
> -#define M_FW_RIWR_SOPEOP	0x3
> -#define V_FW_RIWR_SOPEOP(x)	((x) << S_FW_RIWR_SOPEOP)
> -
> -#define S_FW_RIWR_FLAGS		8
> -#define M_FW_RIWR_FLAGS		0x3fffff
> -#define V_FW_RIWR_FLAGS(x)	((x) << S_FW_RIWR_FLAGS)
> -#define G_FW_RIWR_FLAGS(x)	((((x) >> S_FW_RIWR_FLAGS)) & M_FW_RIWR_FLAGS)
> -
> -#define S_FW_RIWR_TID		8
> -#define V_FW_RIWR_TID(x)	((x) << S_FW_RIWR_TID)
> -
> -#define S_FW_RIWR_LEN		0
> -#define V_FW_RIWR_LEN(x)	((x) << S_FW_RIWR_LEN)
> -
> -#define S_FW_RIWR_GEN           31
> -#define V_FW_RIWR_GEN(x)        ((x)  << S_FW_RIWR_GEN)
> -
> -struct t3_sge {
> -	__be32 stag;
> -	__be32 len;
> -	__be64 to;
> -};
> -
> -/* If num_sgle is zero, flit 5+ contains immediate data.*/
> -struct t3_send_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -
> -	u8 rdmaop;		/* 2 */
> -	u8 reserved[3];
> -	__be32 rem_stag;
> -	__be32 plen;		/* 3 */
> -	__be32 num_sgle;
> -	struct t3_sge sgl[T3_MAX_SGE];	/* 4+ */
> -};
> -
> -#define T3_MAX_FASTREG_DEPTH 10
> -#define T3_MAX_FASTREG_FRAG 10
> -
> -struct t3_fastreg_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	__be32 stag;		/* 2 */
> -	__be32 len;
> -	__be32 va_base_hi;	/* 3 */
> -	__be32 va_base_lo_fbo;
> -	__be32 page_type_perms; /* 4 */
> -	__be32 reserved1;
> -	__be64 pbl_addrs[0];	/* 5+ */
> -};
> -
> -/*
> - * If a fastreg wr spans multiple wqes, then the 2nd fragment look like this.
> - */
> -struct t3_pbl_frag {
> -	struct fw_riwrh wrh;	/* 0 */
> -	__be64 pbl_addrs[14];	/* 1..14 */
> -};
> -
> -#define S_FR_PAGE_COUNT		24
> -#define M_FR_PAGE_COUNT		0xff
> -#define V_FR_PAGE_COUNT(x)	((x) << S_FR_PAGE_COUNT)
> -#define G_FR_PAGE_COUNT(x)	((((x) >> S_FR_PAGE_COUNT)) & M_FR_PAGE_COUNT)
> -
> -#define S_FR_PAGE_SIZE		16
> -#define M_FR_PAGE_SIZE		0x1f
> -#define V_FR_PAGE_SIZE(x)	((x) << S_FR_PAGE_SIZE)
> -#define G_FR_PAGE_SIZE(x)	((((x) >> S_FR_PAGE_SIZE)) & M_FR_PAGE_SIZE)
> -
> -#define S_FR_TYPE		8
> -#define M_FR_TYPE		0x1
> -#define V_FR_TYPE(x)		((x) << S_FR_TYPE)
> -#define G_FR_TYPE(x)		((((x) >> S_FR_TYPE)) & M_FR_TYPE)
> -
> -#define S_FR_PERMS		0
> -#define M_FR_PERMS		0xff
> -#define V_FR_PERMS(x)		((x) << S_FR_PERMS)
> -#define G_FR_PERMS(x)		((((x) >> S_FR_PERMS)) & M_FR_PERMS)
> -
> -struct t3_local_inv_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	__be32 stag;		/* 2 */
> -	__be32 reserved;
> -};
> -
> -struct t3_rdma_write_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	u8 rdmaop;		/* 2 */
> -	u8 reserved[3];
> -	__be32 stag_sink;
> -	__be64 to_sink;		/* 3 */
> -	__be32 plen;		/* 4 */
> -	__be32 num_sgle;
> -	struct t3_sge sgl[T3_MAX_SGE];	/* 5+ */
> -};
> -
> -struct t3_rdma_read_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	u8 rdmaop;		/* 2 */
> -	u8 local_inv;
> -	u8 reserved[2];
> -	__be32 rem_stag;
> -	__be64 rem_to;		/* 3 */
> -	__be32 local_stag;	/* 4 */
> -	__be32 local_len;
> -	__be64 local_to;	/* 5 */
> -};
> -
> -struct t3_bind_mw_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	u16 reserved;		/* 2 */
> -	u8 type;
> -	u8 perms;
> -	__be32 mr_stag;
> -	__be32 mw_stag;		/* 3 */
> -	__be32 mw_len;
> -	__be64 mw_va;		/* 4 */
> -	__be32 mr_pbl_addr;	/* 5 */
> -	u8 reserved2[3];
> -	u8 mr_pagesz;
> -};
> -
> -struct t3_receive_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	u8 pagesz[T3_MAX_SGE];
> -	__be32 num_sgle;		/* 2 */
> -	struct t3_sge sgl[T3_MAX_SGE];	/* 3+ */
> -	__be32 pbl_addr[T3_MAX_SGE];
> -};
> -
> -struct t3_bypass_wr {
> -	struct fw_riwrh wrh;
> -	union t3_wrid wrid;	/* 1 */
> -};
> -
> -struct t3_modify_qp_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	__be32 flags;		/* 2 */
> -	__be32 quiesce;		/* 2 */
> -	__be32 max_ird;		/* 3 */
> -	__be32 max_ord;		/* 3 */
> -	__be64 sge_cmd;		/* 4 */
> -	__be64 ctx1;		/* 5 */
> -	__be64 ctx0;		/* 6 */
> -};
> -
> -enum t3_modify_qp_flags {
> -	MODQP_QUIESCE  = 0x01,
> -	MODQP_MAX_IRD  = 0x02,
> -	MODQP_MAX_ORD  = 0x04,
> -	MODQP_WRITE_EC = 0x08,
> -	MODQP_READ_EC  = 0x10,
> -};
> -
> -
> -enum t3_mpa_attrs {
> -	uP_RI_MPA_RX_MARKER_ENABLE = 0x1,
> -	uP_RI_MPA_TX_MARKER_ENABLE = 0x2,
> -	uP_RI_MPA_CRC_ENABLE = 0x4,
> -	uP_RI_MPA_IETF_ENABLE = 0x8
> -} __packed;
> -
> -enum t3_qp_caps {
> -	uP_RI_QP_RDMA_READ_ENABLE = 0x01,
> -	uP_RI_QP_RDMA_WRITE_ENABLE = 0x02,
> -	uP_RI_QP_BIND_ENABLE = 0x04,
> -	uP_RI_QP_FAST_REGISTER_ENABLE = 0x08,
> -	uP_RI_QP_STAG0_ENABLE = 0x10
> -} __packed;
> -
> -enum rdma_init_rtr_types {
> -	RTR_READ = 1,
> -	RTR_WRITE = 2,
> -	RTR_SEND = 3,
> -};
> -
> -#define S_RTR_TYPE	2
> -#define M_RTR_TYPE	0x3
> -#define V_RTR_TYPE(x)	((x) << S_RTR_TYPE)
> -#define G_RTR_TYPE(x)	((((x) >> S_RTR_TYPE)) & M_RTR_TYPE)
> -
> -#define S_CHAN		4
> -#define M_CHAN		0x3
> -#define V_CHAN(x)	((x) << S_CHAN)
> -#define G_CHAN(x)	((((x) >> S_CHAN)) & M_CHAN)
> -
> -struct t3_rdma_init_attr {
> -	u32 tid;
> -	u32 qpid;
> -	u32 pdid;
> -	u32 scqid;
> -	u32 rcqid;
> -	u32 rq_addr;
> -	u32 rq_size;
> -	enum t3_mpa_attrs mpaattrs;
> -	enum t3_qp_caps qpcaps;
> -	u16 tcp_emss;
> -	u32 ord;
> -	u32 ird;
> -	u64 qp_dma_addr;
> -	u32 qp_dma_size;
> -	enum rdma_init_rtr_types rtr_type;
> -	u16 flags;
> -	u16 rqe_count;
> -	u32 irs;
> -	u32 chan;
> -};
> -
> -struct t3_rdma_init_wr {
> -	struct fw_riwrh wrh;	/* 0 */
> -	union t3_wrid wrid;	/* 1 */
> -	__be32 qpid;		/* 2 */
> -	__be32 pdid;
> -	__be32 scqid;		/* 3 */
> -	__be32 rcqid;
> -	__be32 rq_addr;		/* 4 */
> -	__be32 rq_size;
> -	u8 mpaattrs;		/* 5 */
> -	u8 qpcaps;
> -	__be16 ulpdu_size;
> -	__be16 flags_rtr_type;
> -	__be16 rqe_count;
> -	__be32 ord;		/* 6 */
> -	__be32 ird;
> -	__be64 qp_dma_addr;	/* 7 */
> -	__be32 qp_dma_size;	/* 8 */
> -	__be32 irs;
> -};
> -
> -struct t3_genbit {
> -	u64 flit[15];
> -	__be64 genbit;
> -};
> -
> -struct t3_wq_in_err {
> -	u64 flit[13];
> -	u64 err;
> -};
> -
> -enum rdma_init_wr_flags {
> -	MPA_INITIATOR = (1<<0),
> -	PRIV_QP = (1<<1),
> -};
> -
> -union t3_wr {
> -	struct t3_send_wr send;
> -	struct t3_rdma_write_wr write;
> -	struct t3_rdma_read_wr read;
> -	struct t3_receive_wr recv;
> -	struct t3_fastreg_wr fastreg;
> -	struct t3_pbl_frag pbl_frag;
> -	struct t3_local_inv_wr local_inv;
> -	struct t3_bind_mw_wr bind;
> -	struct t3_bypass_wr bypass;
> -	struct t3_rdma_init_wr init;
> -	struct t3_modify_qp_wr qp_mod;
> -	struct t3_genbit genbit;
> -	struct t3_wq_in_err wq_in_err;
> -	__be64 flit[16];
> -};
> -
> -#define T3_SQ_CQE_FLIT	  13
> -#define T3_SQ_COOKIE_FLIT 14
> -
> -#define T3_RQ_COOKIE_FLIT 13
> -#define T3_RQ_CQE_FLIT	  14
> -
> -static inline enum t3_wr_opcode fw_riwrh_opcode(struct fw_riwrh *wqe)
> -{
> -	return G_FW_RIWR_OP(be32_to_cpu(wqe->op_seop_flags));
> -}
> -
> -enum t3_wr_hdr_bits {
> -	T3_EOP = 1,
> -	T3_SOP = 2,
> -	T3_SOPEOP = T3_EOP|T3_SOP,
> -};
> -
> -static inline void build_fw_riwrh(struct fw_riwrh *wqe, enum t3_wr_opcode op,
> -				  enum t3_wr_flags flags, u8 genbit, u32 tid,
> -				  u8 len, u8 sopeop)
> -{
> -	wqe->op_seop_flags = cpu_to_be32(V_FW_RIWR_OP(op) |
> -					 V_FW_RIWR_SOPEOP(sopeop) |
> -					 V_FW_RIWR_FLAGS(flags));
> -	wmb();
> -	wqe->gen_tid_len = cpu_to_be32(V_FW_RIWR_GEN(genbit) |
> -				       V_FW_RIWR_TID(tid) |
> -				       V_FW_RIWR_LEN(len));
> -	/* 2nd gen bit... */
> -	((union t3_wr *)wqe)->genbit.genbit = cpu_to_be64(genbit);
> -}
> -
> -/*
> - * T3 ULP2_TX commands
> - */
> -enum t3_utx_mem_op {
> -	T3_UTX_MEM_READ = 2,
> -	T3_UTX_MEM_WRITE = 3
> -};
> -
> -/* T3 MC7 RDMA TPT entry format */
> -
> -enum tpt_mem_type {
> -	TPT_NON_SHARED_MR = 0x0,
> -	TPT_SHARED_MR = 0x1,
> -	TPT_MW = 0x2,
> -	TPT_MW_RELAXED_PROTECTION = 0x3
> -};
> -
> -enum tpt_addr_type {
> -	TPT_ZBTO = 0,
> -	TPT_VATO = 1
> -};
> -
> -enum tpt_mem_perm {
> -	TPT_MW_BIND = 0x10,
> -	TPT_LOCAL_READ = 0x8,
> -	TPT_LOCAL_WRITE = 0x4,
> -	TPT_REMOTE_READ = 0x2,
> -	TPT_REMOTE_WRITE = 0x1
> -};
> -
> -struct tpt_entry {
> -	__be32 valid_stag_pdid;
> -	__be32 flags_pagesize_qpid;
> -
> -	__be32 rsvd_pbl_addr;
> -	__be32 len;
> -	__be32 va_hi;
> -	__be32 va_low_or_fbo;
> -
> -	__be32 rsvd_bind_cnt_or_pstag;
> -	__be32 rsvd_pbl_size;
> -};
> -
> -#define S_TPT_VALID		31
> -#define V_TPT_VALID(x)		((x) << S_TPT_VALID)
> -#define F_TPT_VALID		V_TPT_VALID(1U)
> -
> -#define S_TPT_STAG_KEY		23
> -#define M_TPT_STAG_KEY		0xFF
> -#define V_TPT_STAG_KEY(x)	((x) << S_TPT_STAG_KEY)
> -#define G_TPT_STAG_KEY(x)	(((x) >> S_TPT_STAG_KEY) & M_TPT_STAG_KEY)
> -
> -#define S_TPT_STAG_STATE	22
> -#define V_TPT_STAG_STATE(x)	((x) << S_TPT_STAG_STATE)
> -#define F_TPT_STAG_STATE	V_TPT_STAG_STATE(1U)
> -
> -#define S_TPT_STAG_TYPE		20
> -#define M_TPT_STAG_TYPE		0x3
> -#define V_TPT_STAG_TYPE(x)	((x) << S_TPT_STAG_TYPE)
> -#define G_TPT_STAG_TYPE(x)	(((x) >> S_TPT_STAG_TYPE) & M_TPT_STAG_TYPE)
> -
> -#define S_TPT_PDID		0
> -#define M_TPT_PDID		0xFFFFF
> -#define V_TPT_PDID(x)		((x) << S_TPT_PDID)
> -#define G_TPT_PDID(x)		(((x) >> S_TPT_PDID) & M_TPT_PDID)
> -
> -#define S_TPT_PERM		28
> -#define M_TPT_PERM		0xF
> -#define V_TPT_PERM(x)		((x) << S_TPT_PERM)
> -#define G_TPT_PERM(x)		(((x) >> S_TPT_PERM) & M_TPT_PERM)
> -
> -#define S_TPT_REM_INV_DIS	27
> -#define V_TPT_REM_INV_DIS(x)	((x) << S_TPT_REM_INV_DIS)
> -#define F_TPT_REM_INV_DIS	V_TPT_REM_INV_DIS(1U)
> -
> -#define S_TPT_ADDR_TYPE		26
> -#define V_TPT_ADDR_TYPE(x)	((x) << S_TPT_ADDR_TYPE)
> -#define F_TPT_ADDR_TYPE		V_TPT_ADDR_TYPE(1U)
> -
> -#define S_TPT_MW_BIND_ENABLE	25
> -#define V_TPT_MW_BIND_ENABLE(x)	((x) << S_TPT_MW_BIND_ENABLE)
> -#define F_TPT_MW_BIND_ENABLE    V_TPT_MW_BIND_ENABLE(1U)
> -
> -#define S_TPT_PAGE_SIZE		20
> -#define M_TPT_PAGE_SIZE		0x1F
> -#define V_TPT_PAGE_SIZE(x)	((x) << S_TPT_PAGE_SIZE)
> -#define G_TPT_PAGE_SIZE(x)	(((x) >> S_TPT_PAGE_SIZE) & M_TPT_PAGE_SIZE)
> -
> -#define S_TPT_PBL_ADDR		0
> -#define M_TPT_PBL_ADDR		0x1FFFFFFF
> -#define V_TPT_PBL_ADDR(x)	((x) << S_TPT_PBL_ADDR)
> -#define G_TPT_PBL_ADDR(x)       (((x) >> S_TPT_PBL_ADDR) & M_TPT_PBL_ADDR)
> -
> -#define S_TPT_QPID		0
> -#define M_TPT_QPID		0xFFFFF
> -#define V_TPT_QPID(x)		((x) << S_TPT_QPID)
> -#define G_TPT_QPID(x)		(((x) >> S_TPT_QPID) & M_TPT_QPID)
> -
> -#define S_TPT_PSTAG		0
> -#define M_TPT_PSTAG		0xFFFFFF
> -#define V_TPT_PSTAG(x)		((x) << S_TPT_PSTAG)
> -#define G_TPT_PSTAG(x)		(((x) >> S_TPT_PSTAG) & M_TPT_PSTAG)
> -
> -#define S_TPT_PBL_SIZE		0
> -#define M_TPT_PBL_SIZE		0xFFFFF
> -#define V_TPT_PBL_SIZE(x)	((x) << S_TPT_PBL_SIZE)
> -#define G_TPT_PBL_SIZE(x)	(((x) >> S_TPT_PBL_SIZE) & M_TPT_PBL_SIZE)
> -
> -/*
> - * CQE defs
> - */
> -struct t3_cqe {
> -	__be32 header;
> -	__be32 len;
> -	union {
> -		struct {
> -			__be32 stag;
> -			__be32 msn;
> -		} rcqe;
> -		struct {
> -			u32 wrid_hi;
> -			u32 wrid_low;
> -		} scqe;
> -	} u;
> -};
> -
> -#define S_CQE_OOO	  31
> -#define M_CQE_OOO	  0x1
> -#define G_CQE_OOO(x)	  ((((x) >> S_CQE_OOO)) & M_CQE_OOO)
> -#define V_CEQ_OOO(x)	  ((x)<<S_CQE_OOO)
> -
> -#define S_CQE_QPID        12
> -#define M_CQE_QPID        0x7FFFF
> -#define G_CQE_QPID(x)     ((((x) >> S_CQE_QPID)) & M_CQE_QPID)
> -#define V_CQE_QPID(x)	  ((x)<<S_CQE_QPID)
> -
> -#define S_CQE_SWCQE       11
> -#define M_CQE_SWCQE       0x1
> -#define G_CQE_SWCQE(x)    ((((x) >> S_CQE_SWCQE)) & M_CQE_SWCQE)
> -#define V_CQE_SWCQE(x)	  ((x)<<S_CQE_SWCQE)
> -
> -#define S_CQE_GENBIT      10
> -#define M_CQE_GENBIT      0x1
> -#define G_CQE_GENBIT(x)   (((x) >> S_CQE_GENBIT) & M_CQE_GENBIT)
> -#define V_CQE_GENBIT(x)	  ((x)<<S_CQE_GENBIT)
> -
> -#define S_CQE_STATUS      5
> -#define M_CQE_STATUS      0x1F
> -#define G_CQE_STATUS(x)   ((((x) >> S_CQE_STATUS)) & M_CQE_STATUS)
> -#define V_CQE_STATUS(x)   ((x)<<S_CQE_STATUS)
> -
> -#define S_CQE_TYPE        4
> -#define M_CQE_TYPE        0x1
> -#define G_CQE_TYPE(x)     ((((x) >> S_CQE_TYPE)) & M_CQE_TYPE)
> -#define V_CQE_TYPE(x)     ((x)<<S_CQE_TYPE)
> -
> -#define S_CQE_OPCODE      0
> -#define M_CQE_OPCODE      0xF
> -#define G_CQE_OPCODE(x)   ((((x) >> S_CQE_OPCODE)) & M_CQE_OPCODE)
> -#define V_CQE_OPCODE(x)   ((x)<<S_CQE_OPCODE)
> -
> -#define SW_CQE(x)         (G_CQE_SWCQE(be32_to_cpu((x).header)))
> -#define CQE_OOO(x)        (G_CQE_OOO(be32_to_cpu((x).header)))
> -#define CQE_QPID(x)       (G_CQE_QPID(be32_to_cpu((x).header)))
> -#define CQE_GENBIT(x)     (G_CQE_GENBIT(be32_to_cpu((x).header)))
> -#define CQE_TYPE(x)       (G_CQE_TYPE(be32_to_cpu((x).header)))
> -#define SQ_TYPE(x)	  (CQE_TYPE((x)))
> -#define RQ_TYPE(x)	  (!CQE_TYPE((x)))
> -#define CQE_STATUS(x)     (G_CQE_STATUS(be32_to_cpu((x).header)))
> -#define CQE_OPCODE(x)     (G_CQE_OPCODE(be32_to_cpu((x).header)))
> -
> -#define CQE_SEND_OPCODE(x)( \
> -	(G_CQE_OPCODE(be32_to_cpu((x).header)) == T3_SEND) || \
> -	(G_CQE_OPCODE(be32_to_cpu((x).header)) == T3_SEND_WITH_SE) || \
> -	(G_CQE_OPCODE(be32_to_cpu((x).header)) == T3_SEND_WITH_INV) || \
> -	(G_CQE_OPCODE(be32_to_cpu((x).header)) == T3_SEND_WITH_SE_INV))
> -
> -#define CQE_LEN(x)        (be32_to_cpu((x).len))
> -
> -/* used for RQ completion processing */
> -#define CQE_WRID_STAG(x)  (be32_to_cpu((x).u.rcqe.stag))
> -#define CQE_WRID_MSN(x)   (be32_to_cpu((x).u.rcqe.msn))
> -
> -/* used for SQ completion processing */
> -#define CQE_WRID_SQ_WPTR(x)	((x).u.scqe.wrid_hi)
> -#define CQE_WRID_WPTR(x)	((x).u.scqe.wrid_low)
> -
> -/* generic accessor macros */
> -#define CQE_WRID_HI(x)		((x).u.scqe.wrid_hi)
> -#define CQE_WRID_LOW(x)		((x).u.scqe.wrid_low)
> -
> -#define TPT_ERR_SUCCESS                     0x0
> -#define TPT_ERR_STAG                        0x1	 /* STAG invalid: either the */
> -						 /* STAG is offlimt, being 0, */
> -						 /* or STAG_key mismatch */
> -#define TPT_ERR_PDID                        0x2	 /* PDID mismatch */
> -#define TPT_ERR_QPID                        0x3	 /* QPID mismatch */
> -#define TPT_ERR_ACCESS                      0x4	 /* Invalid access right */
> -#define TPT_ERR_WRAP                        0x5	 /* Wrap error */
> -#define TPT_ERR_BOUND                       0x6	 /* base and bounds voilation */
> -#define TPT_ERR_INVALIDATE_SHARED_MR        0x7	 /* attempt to invalidate a  */
> -						 /* shared memory region */
> -#define TPT_ERR_INVALIDATE_MR_WITH_MW_BOUND 0x8	 /* attempt to invalidate a  */
> -						 /* shared memory region */
> -#define TPT_ERR_ECC                         0x9	 /* ECC error detected */
> -#define TPT_ERR_ECC_PSTAG                   0xA	 /* ECC error detected when  */
> -						 /* reading PSTAG for a MW  */
> -						 /* Invalidate */
> -#define TPT_ERR_PBL_ADDR_BOUND              0xB	 /* pbl addr out of bounds:  */
> -						 /* software error */
> -#define TPT_ERR_SWFLUSH			    0xC	 /* SW FLUSHED */
> -#define TPT_ERR_CRC                         0x10 /* CRC error */
> -#define TPT_ERR_MARKER                      0x11 /* Marker error */
> -#define TPT_ERR_PDU_LEN_ERR                 0x12 /* invalid PDU length */
> -#define TPT_ERR_OUT_OF_RQE                  0x13 /* out of RQE */
> -#define TPT_ERR_DDP_VERSION                 0x14 /* wrong DDP version */
> -#define TPT_ERR_RDMA_VERSION                0x15 /* wrong RDMA version */
> -#define TPT_ERR_OPCODE                      0x16 /* invalid rdma opcode */
> -#define TPT_ERR_DDP_QUEUE_NUM               0x17 /* invalid ddp queue number */
> -#define TPT_ERR_MSN                         0x18 /* MSN error */
> -#define TPT_ERR_TBIT                        0x19 /* tag bit not set correctly */
> -#define TPT_ERR_MO                          0x1A /* MO not 0 for TERMINATE  */
> -						 /* or READ_REQ */
> -#define TPT_ERR_MSN_GAP                     0x1B
> -#define TPT_ERR_MSN_RANGE                   0x1C
> -#define TPT_ERR_IRD_OVERFLOW                0x1D
> -#define TPT_ERR_RQE_ADDR_BOUND              0x1E /* RQE addr out of bounds:  */
> -						 /* software error */
> -#define TPT_ERR_INTERNAL_ERR                0x1F /* internal error (opcode  */
> -						 /* mismatch) */
> -
> -struct t3_swsq {
> -	__u64			wr_id;
> -	struct t3_cqe		cqe;
> -	__u32			sq_wptr;
> -	__be32			read_len;
> -	int			opcode;
> -	int			complete;
> -	int			signaled;
> -};
> -
> -struct t3_swrq {
> -	__u64			wr_id;
> -	__u32			pbl_addr;
> -};
> -
> -/*
> - * A T3 WQ implements both the SQ and RQ.
> - */
> -struct t3_wq {
> -	union t3_wr *queue;		/* DMA accessible memory */
> -	dma_addr_t dma_addr;		/* DMA address for HW */
> -	DEFINE_DMA_UNMAP_ADDR(mapping); /* unmap kruft */
> -	u32 error;			/* 1 once we go to ERROR */
> -	u32 qpid;
> -	u32 wptr;			/* idx to next available WR slot */
> -	u32 size_log2;			/* total wq size */
> -	struct t3_swsq *sq;		/* SW SQ */
> -	struct t3_swsq *oldest_read;	/* tracks oldest pending read */
> -	u32 sq_wptr;			/* sq_wptr - sq_rptr == count of */
> -	u32 sq_rptr;			/* pending wrs */
> -	u32 sq_size_log2;		/* sq size */
> -	struct t3_swrq *rq;		/* SW RQ (holds consumer wr_ids */
> -	u32 rq_wptr;			/* rq_wptr - rq_rptr == count of */
> -	u32 rq_rptr;			/* pending wrs */
> -	struct t3_swrq *rq_oldest_wr;	/* oldest wr on the SW RQ */
> -	u32 rq_size_log2;		/* rq size */
> -	u32 rq_addr;			/* rq adapter address */
> -	void __iomem *doorbell;		/* kernel db */
> -	u64 udb;			/* user db if any */
> -	struct cxio_rdev *rdev;
> -};
> -
> -struct t3_cq {
> -	u32 cqid;
> -	u32 rptr;
> -	u32 wptr;
> -	u32 size_log2;
> -	dma_addr_t dma_addr;
> -	DEFINE_DMA_UNMAP_ADDR(mapping);
> -	struct t3_cqe *queue;
> -	struct t3_cqe *sw_queue;
> -	u32 sw_rptr;
> -	u32 sw_wptr;
> -};
> -
> -#define CQ_VLD_ENTRY(ptr,size_log2,cqe) (Q_GENBIT(ptr,size_log2) == \
> -					 CQE_GENBIT(*cqe))
> -
> -struct t3_cq_status_page {
> -	u32 cq_err;
> -};
> -
> -static inline int cxio_cq_in_error(struct t3_cq *cq)
> -{
> -	return ((struct t3_cq_status_page *)
> -		&cq->queue[1 << cq->size_log2])->cq_err;
> -}
> -
> -static inline void cxio_set_cq_in_error(struct t3_cq *cq)
> -{
> -	((struct t3_cq_status_page *)
> -	 &cq->queue[1 << cq->size_log2])->cq_err = 1;
> -}
> -
> -static inline void cxio_set_wq_in_error(struct t3_wq *wq)
> -{
> -	wq->queue->wq_in_err.err |= 1;
> -}
> -
> -static inline void cxio_disable_wq_db(struct t3_wq *wq)
> -{
> -	wq->queue->wq_in_err.err |= 2;
> -}
> -
> -static inline void cxio_enable_wq_db(struct t3_wq *wq)
> -{
> -	wq->queue->wq_in_err.err &= ~2;
> -}
> -
> -static inline int cxio_wq_db_enabled(struct t3_wq *wq)
> -{
> -	return !(wq->queue->wq_in_err.err & 2);
> -}
> -
> -static inline struct t3_cqe *cxio_next_hw_cqe(struct t3_cq *cq)
> -{
> -	struct t3_cqe *cqe;
> -
> -	cqe = cq->queue + (Q_PTR2IDX(cq->rptr, cq->size_log2));
> -	if (CQ_VLD_ENTRY(cq->rptr, cq->size_log2, cqe))
> -		return cqe;
> -	return NULL;
> -}
> -
> -static inline struct t3_cqe *cxio_next_sw_cqe(struct t3_cq *cq)
> -{
> -	struct t3_cqe *cqe;
> -
> -	if (!Q_EMPTY(cq->sw_rptr, cq->sw_wptr)) {
> -		cqe = cq->sw_queue + (Q_PTR2IDX(cq->sw_rptr, cq->size_log2));
> -		return cqe;
> -	}
> -	return NULL;
> -}
> -
> -static inline struct t3_cqe *cxio_next_cqe(struct t3_cq *cq)
> -{
> -	struct t3_cqe *cqe;
> -
> -	if (!Q_EMPTY(cq->sw_rptr, cq->sw_wptr)) {
> -		cqe = cq->sw_queue + (Q_PTR2IDX(cq->sw_rptr, cq->size_log2));
> -		return cqe;
> -	}
> -	cqe = cq->queue + (Q_PTR2IDX(cq->rptr, cq->size_log2));
> -	if (CQ_VLD_ENTRY(cq->rptr, cq->size_log2, cqe))
> -		return cqe;
> -	return NULL;
> -}
> -
> -#endif
> diff --git a/drivers/infiniband/hw/cxgb3/iwch.c b/drivers/infiniband/hw/cxgb3/iwch.c
> deleted file mode 100644
> index 56a8ab6210cf..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch.c
> +++ /dev/null
> @@ -1,282 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -
> -#include <rdma/ib_verbs.h>
> -
> -#include "cxgb3_offload.h"
> -#include "iwch_provider.h"
> -#include <rdma/cxgb3-abi.h>
> -#include "iwch.h"
> -#include "iwch_cm.h"
> -
> -#define DRV_VERSION "1.1"
> -
> -MODULE_AUTHOR("Boyd Faulkner, Steve Wise");
> -MODULE_DESCRIPTION("Chelsio T3 RDMA Driver");
> -MODULE_LICENSE("Dual BSD/GPL");
> -
> -static void open_rnic_dev(struct t3cdev *);
> -static void close_rnic_dev(struct t3cdev *);
> -static void iwch_event_handler(struct t3cdev *, u32, u32);
> -
> -struct cxgb3_client t3c_client = {
> -	.name = "iw_cxgb3",
> -	.add = open_rnic_dev,
> -	.remove = close_rnic_dev,
> -	.handlers = t3c_handlers,
> -	.redirect = iwch_ep_redirect,
> -	.event_handler = iwch_event_handler
> -};
> -
> -static LIST_HEAD(dev_list);
> -static DEFINE_MUTEX(dev_mutex);
> -
> -static void disable_dbs(struct iwch_dev *rnicp)
> -{
> -	unsigned long index;
> -	struct iwch_qp *qhp;
> -
> -	xa_lock_irq(&rnicp->qps);
> -	xa_for_each(&rnicp->qps, index, qhp)
> -		cxio_disable_wq_db(&qhp->wq);
> -	xa_unlock_irq(&rnicp->qps);
> -}
> -
> -static void enable_dbs(struct iwch_dev *rnicp, int ring_db)
> -{
> -	unsigned long index;
> -	struct iwch_qp *qhp;
> -
> -	xa_lock_irq(&rnicp->qps);
> -	xa_for_each(&rnicp->qps, index, qhp) {
> -		if (ring_db)
> -			ring_doorbell(qhp->rhp->rdev.ctrl_qp.doorbell,
> -					qhp->wq.qpid);
> -		cxio_enable_wq_db(&qhp->wq);
> -	}
> -	xa_unlock_irq(&rnicp->qps);
> -}
> -
> -static void iwch_db_drop_task(struct work_struct *work)
> -{
> -	struct iwch_dev *rnicp = container_of(work, struct iwch_dev,
> -					      db_drop_task.work);
> -	enable_dbs(rnicp, 1);
> -}
> -
> -static void rnic_init(struct iwch_dev *rnicp)
> -{
> -	pr_debug("%s iwch_dev %p\n", __func__,  rnicp);
> -	xa_init_flags(&rnicp->cqs, XA_FLAGS_LOCK_IRQ);
> -	xa_init_flags(&rnicp->qps, XA_FLAGS_LOCK_IRQ);
> -	xa_init_flags(&rnicp->mrs, XA_FLAGS_LOCK_IRQ);
> -	INIT_DELAYED_WORK(&rnicp->db_drop_task, iwch_db_drop_task);
> -
> -	rnicp->attr.max_qps = T3_MAX_NUM_QP - 32;
> -	rnicp->attr.max_wrs = T3_MAX_QP_DEPTH;
> -	rnicp->attr.max_sge_per_wr = T3_MAX_SGE;
> -	rnicp->attr.max_sge_per_rdma_write_wr = T3_MAX_SGE;
> -	rnicp->attr.max_cqs = T3_MAX_NUM_CQ - 1;
> -	rnicp->attr.max_cqes_per_cq = T3_MAX_CQ_DEPTH;
> -	rnicp->attr.max_mem_regs = cxio_num_stags(&rnicp->rdev);
> -	rnicp->attr.max_phys_buf_entries = T3_MAX_PBL_SIZE;
> -	rnicp->attr.max_pds = T3_MAX_NUM_PD - 1;
> -	rnicp->attr.mem_pgsizes_bitmask = T3_PAGESIZE_MASK;
> -	rnicp->attr.max_mr_size = T3_MAX_MR_SIZE;
> -	rnicp->attr.can_resize_wq = 0;
> -	rnicp->attr.max_rdma_reads_per_qp = 8;
> -	rnicp->attr.max_rdma_read_resources =
> -	    rnicp->attr.max_rdma_reads_per_qp * rnicp->attr.max_qps;
> -	rnicp->attr.max_rdma_read_qp_depth = 8;	/* IRD */
> -	rnicp->attr.max_rdma_read_depth =
> -	    rnicp->attr.max_rdma_read_qp_depth * rnicp->attr.max_qps;
> -	rnicp->attr.rq_overflow_handled = 0;
> -	rnicp->attr.can_modify_ird = 0;
> -	rnicp->attr.can_modify_ord = 0;
> -	rnicp->attr.max_mem_windows = rnicp->attr.max_mem_regs - 1;
> -	rnicp->attr.stag0_value = 1;
> -	rnicp->attr.zbva_support = 1;
> -	rnicp->attr.local_invalidate_fence = 1;
> -	rnicp->attr.cq_overflow_detection = 1;
> -	return;
> -}
> -
> -static void open_rnic_dev(struct t3cdev *tdev)
> -{
> -	struct iwch_dev *rnicp;
> -
> -	pr_debug("%s t3cdev %p\n", __func__,  tdev);
> -	pr_info_once("Chelsio T3 RDMA Driver - version %s\n", DRV_VERSION);
> -	rnicp = ib_alloc_device(iwch_dev, ibdev);
> -	if (!rnicp) {
> -		pr_err("Cannot allocate ib device\n");
> -		return;
> -	}
> -	rnicp->rdev.ulp = rnicp;
> -	rnicp->rdev.t3cdev_p = tdev;
> -
> -	mutex_lock(&dev_mutex);
> -
> -	if (cxio_rdev_open(&rnicp->rdev)) {
> -		mutex_unlock(&dev_mutex);
> -		pr_err("Unable to open CXIO rdev\n");
> -		ib_dealloc_device(&rnicp->ibdev);
> -		return;
> -	}
> -
> -	rnic_init(rnicp);
> -
> -	list_add_tail(&rnicp->entry, &dev_list);
> -	mutex_unlock(&dev_mutex);
> -
> -	if (iwch_register_device(rnicp)) {
> -		pr_err("Unable to register device\n");
> -		close_rnic_dev(tdev);
> -	}
> -	pr_info("Initialized device %s\n",
> -		pci_name(rnicp->rdev.rnic_info.pdev));
> -	return;
> -}
> -
> -static void close_rnic_dev(struct t3cdev *tdev)
> -{
> -	struct iwch_dev *dev, *tmp;
> -	pr_debug("%s t3cdev %p\n", __func__,  tdev);
> -	mutex_lock(&dev_mutex);
> -	list_for_each_entry_safe(dev, tmp, &dev_list, entry) {
> -		if (dev->rdev.t3cdev_p == tdev) {
> -			dev->rdev.flags = CXIO_ERROR_FATAL;
> -			synchronize_net();
> -			cancel_delayed_work_sync(&dev->db_drop_task);
> -			list_del(&dev->entry);
> -			iwch_unregister_device(dev);
> -			cxio_rdev_close(&dev->rdev);
> -			WARN_ON(!xa_empty(&dev->cqs));
> -			WARN_ON(!xa_empty(&dev->qps));
> -			WARN_ON(!xa_empty(&dev->mrs));
> -			ib_dealloc_device(&dev->ibdev);
> -			break;
> -		}
> -	}
> -	mutex_unlock(&dev_mutex);
> -}
> -
> -static void iwch_event_handler(struct t3cdev *tdev, u32 evt, u32 port_id)
> -{
> -	struct cxio_rdev *rdev = tdev->ulp;
> -	struct iwch_dev *rnicp;
> -	struct ib_event event;
> -	u32 portnum = port_id + 1;
> -	int dispatch = 0;
> -
> -	if (!rdev)
> -		return;
> -	rnicp = rdev_to_iwch_dev(rdev);
> -	switch (evt) {
> -	case OFFLOAD_STATUS_DOWN: {
> -		rdev->flags = CXIO_ERROR_FATAL;
> -		synchronize_net();
> -		event.event  = IB_EVENT_DEVICE_FATAL;
> -		dispatch = 1;
> -		break;
> -		}
> -	case OFFLOAD_PORT_DOWN: {
> -		event.event  = IB_EVENT_PORT_ERR;
> -		dispatch = 1;
> -		break;
> -		}
> -	case OFFLOAD_PORT_UP: {
> -		event.event  = IB_EVENT_PORT_ACTIVE;
> -		dispatch = 1;
> -		break;
> -		}
> -	case OFFLOAD_DB_FULL: {
> -		disable_dbs(rnicp);
> -		break;
> -		}
> -	case OFFLOAD_DB_EMPTY: {
> -		enable_dbs(rnicp, 1);
> -		break;
> -		}
> -	case OFFLOAD_DB_DROP: {
> -		unsigned long delay = 1000;
> -		unsigned short r;
> -
> -		disable_dbs(rnicp);
> -		get_random_bytes(&r, 2);
> -		delay += r & 1023;
> -
> -		/*
> -		 * delay is between 1000-2023 usecs.
> -		 */
> -		schedule_delayed_work(&rnicp->db_drop_task,
> -			usecs_to_jiffies(delay));
> -		break;
> -		}
> -	}
> -
> -	if (dispatch) {
> -		event.device = &rnicp->ibdev;
> -		event.element.port_num = portnum;
> -		ib_dispatch_event(&event);
> -	}
> -
> -	return;
> -}
> -
> -static int __init iwch_init_module(void)
> -{
> -	int err;
> -
> -	err = cxio_hal_init();
> -	if (err)
> -		return err;
> -	err = iwch_cm_init();
> -	if (err)
> -		return err;
> -	cxio_register_ev_cb(iwch_ev_dispatch);
> -	cxgb3_register_client(&t3c_client);
> -	return 0;
> -}
> -
> -static void __exit iwch_exit_module(void)
> -{
> -	cxgb3_unregister_client(&t3c_client);
> -	cxio_unregister_ev_cb(iwch_ev_dispatch);
> -	iwch_cm_term();
> -	cxio_hal_exit();
> -}
> -
> -module_init(iwch_init_module);
> -module_exit(iwch_exit_module);
> diff --git a/drivers/infiniband/hw/cxgb3/iwch.h b/drivers/infiniband/hw/cxgb3/iwch.h
> deleted file mode 100644
> index 310a937bffcf..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch.h
> +++ /dev/null
> @@ -1,155 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef __IWCH_H__
> -#define __IWCH_H__
> -
> -#include <linux/mutex.h>
> -#include <linux/list.h>
> -#include <linux/spinlock.h>
> -#include <linux/xarray.h>
> -#include <linux/workqueue.h>
> -
> -#include <rdma/ib_verbs.h>
> -
> -#include "cxio_hal.h"
> -#include "cxgb3_offload.h"
> -
> -struct iwch_pd;
> -struct iwch_cq;
> -struct iwch_qp;
> -struct iwch_mr;
> -
> -struct iwch_rnic_attributes {
> -	u32 max_qps;
> -	u32 max_wrs;				/* Max for any SQ/RQ */
> -	u32 max_sge_per_wr;
> -	u32 max_sge_per_rdma_write_wr;	/* for RDMA Write WR */
> -	u32 max_cqs;
> -	u32 max_cqes_per_cq;
> -	u32 max_mem_regs;
> -	u32 max_phys_buf_entries;		/* for phys buf list */
> -	u32 max_pds;
> -
> -	/*
> -	 * The memory page sizes supported by this RNIC.
> -	 * Bit position i in bitmap indicates page of
> -	 * size (4k)^i.  Phys block list mode unsupported.
> -	 */
> -	u32 mem_pgsizes_bitmask;
> -	u64 max_mr_size;
> -	u8 can_resize_wq;
> -
> -	/*
> -	 * The maximum number of RDMA Reads that can be outstanding
> -	 * per QP with this RNIC as the target.
> -	 */
> -	u32 max_rdma_reads_per_qp;
> -
> -	/*
> -	 * The maximum number of resources used for RDMA Reads
> -	 * by this RNIC with this RNIC as the target.
> -	 */
> -	u32 max_rdma_read_resources;
> -
> -	/*
> -	 * The max depth per QP for initiation of RDMA Read
> -	 * by this RNIC.
> -	 */
> -	u32 max_rdma_read_qp_depth;
> -
> -	/*
> -	 * The maximum depth for initiation of RDMA Read
> -	 * operations by this RNIC on all QPs
> -	 */
> -	u32 max_rdma_read_depth;
> -	u8 rq_overflow_handled;
> -	u32 can_modify_ird;
> -	u32 can_modify_ord;
> -	u32 max_mem_windows;
> -	u32 stag0_value;
> -	u8 zbva_support;
> -	u8 local_invalidate_fence;
> -	u32 cq_overflow_detection;
> -};
> -
> -struct iwch_dev {
> -	struct ib_device ibdev;
> -	struct cxio_rdev rdev;
> -	u32 device_cap_flags;
> -	struct iwch_rnic_attributes attr;
> -	struct xarray cqs;
> -	struct xarray qps;
> -	struct xarray mrs;
> -	struct list_head entry;
> -	struct delayed_work db_drop_task;
> -};
> -
> -static inline struct iwch_dev *to_iwch_dev(struct ib_device *ibdev)
> -{
> -	return container_of(ibdev, struct iwch_dev, ibdev);
> -}
> -
> -static inline struct iwch_dev *rdev_to_iwch_dev(struct cxio_rdev *rdev)
> -{
> -	return container_of(rdev, struct iwch_dev, rdev);
> -}
> -
> -static inline int t3b_device(const struct iwch_dev *rhp)
> -{
> -	return rhp->rdev.t3cdev_p->type == T3B;
> -}
> -
> -static inline int t3a_device(const struct iwch_dev *rhp)
> -{
> -	return rhp->rdev.t3cdev_p->type == T3A;
> -}
> -
> -static inline struct iwch_cq *get_chp(struct iwch_dev *rhp, u32 cqid)
> -{
> -	return xa_load(&rhp->cqs, cqid);
> -}
> -
> -static inline struct iwch_qp *get_qhp(struct iwch_dev *rhp, u32 qpid)
> -{
> -	return xa_load(&rhp->qps, qpid);
> -}
> -
> -static inline struct iwch_mr *get_mhp(struct iwch_dev *rhp, u32 mmid)
> -{
> -	return xa_load(&rhp->mrs, mmid);
> -}
> -
> -extern struct cxgb3_client t3c_client;
> -extern cxgb3_cpl_handler_func t3c_handlers[NUM_CPL_CMDS];
> -extern void iwch_ev_dispatch(struct cxio_rdev *rdev_p, struct sk_buff *skb);
> -
> -#endif
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.c b/drivers/infiniband/hw/cxgb3/iwch_cm.c
> deleted file mode 100644
> index 0bca72cb4d9a..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_cm.c
> +++ /dev/null
> @@ -1,2258 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include <linux/module.h>
> -#include <linux/list.h>
> -#include <linux/slab.h>
> -#include <linux/workqueue.h>
> -#include <linux/skbuff.h>
> -#include <linux/timer.h>
> -#include <linux/notifier.h>
> -#include <linux/inetdevice.h>
> -
> -#include <net/neighbour.h>
> -#include <net/netevent.h>
> -#include <net/route.h>
> -
> -#include "tcb.h"
> -#include "cxgb3_offload.h"
> -#include "iwch.h"
> -#include "iwch_provider.h"
> -#include "iwch_cm.h"
> -
> -static char *states[] = {
> -	"idle",
> -	"listen",
> -	"connecting",
> -	"mpa_wait_req",
> -	"mpa_req_sent",
> -	"mpa_req_rcvd",
> -	"mpa_rep_sent",
> -	"fpdu_mode",
> -	"aborting",
> -	"closing",
> -	"moribund",
> -	"dead",
> -	NULL,
> -};
> -
> -int peer2peer = 0;
> -module_param(peer2peer, int, 0644);
> -MODULE_PARM_DESC(peer2peer, "Support peer2peer ULPs (default=0)");
> -
> -static int ep_timeout_secs = 60;
> -module_param(ep_timeout_secs, int, 0644);
> -MODULE_PARM_DESC(ep_timeout_secs, "CM Endpoint operation timeout "
> -				   "in seconds (default=60)");
> -
> -static int mpa_rev = 1;
> -module_param(mpa_rev, int, 0644);
> -MODULE_PARM_DESC(mpa_rev, "MPA Revision, 0 supports amso1100, "
> -		 "1 is spec compliant. (default=1)");
> -
> -static int markers_enabled = 0;
> -module_param(markers_enabled, int, 0644);
> -MODULE_PARM_DESC(markers_enabled, "Enable MPA MARKERS (default(0)=disabled)");
> -
> -static int crc_enabled = 1;
> -module_param(crc_enabled, int, 0644);
> -MODULE_PARM_DESC(crc_enabled, "Enable MPA CRC (default(1)=enabled)");
> -
> -static int rcv_win = 256 * 1024;
> -module_param(rcv_win, int, 0644);
> -MODULE_PARM_DESC(rcv_win, "TCP receive window in bytes (default=256)");
> -
> -static int snd_win = 32 * 1024;
> -module_param(snd_win, int, 0644);
> -MODULE_PARM_DESC(snd_win, "TCP send window in bytes (default=32KB)");
> -
> -static unsigned int nocong = 0;
> -module_param(nocong, uint, 0644);
> -MODULE_PARM_DESC(nocong, "Turn off congestion control (default=0)");
> -
> -static unsigned int cong_flavor = 1;
> -module_param(cong_flavor, uint, 0644);
> -MODULE_PARM_DESC(cong_flavor, "TCP Congestion control flavor (default=1)");
> -
> -static struct workqueue_struct *workq;
> -
> -static struct sk_buff_head rxq;
> -
> -static struct sk_buff *get_skb(struct sk_buff *skb, int len, gfp_t gfp);
> -static void ep_timeout(struct timer_list *t);
> -static void connect_reply_upcall(struct iwch_ep *ep, int status);
> -
> -static void start_ep_timer(struct iwch_ep *ep)
> -{
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	if (timer_pending(&ep->timer)) {
> -		pr_debug("%s stopped / restarted timer ep %p\n", __func__, ep);
> -		del_timer_sync(&ep->timer);
> -	} else
> -		get_ep(&ep->com);
> -	ep->timer.expires = jiffies + ep_timeout_secs * HZ;
> -	add_timer(&ep->timer);
> -}
> -
> -static void stop_ep_timer(struct iwch_ep *ep)
> -{
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	if (!timer_pending(&ep->timer)) {
> -		WARN(1, "%s timer stopped when its not running!  ep %p state %u\n",
> -			__func__, ep, ep->com.state);
> -		return;
> -	}
> -	del_timer_sync(&ep->timer);
> -	put_ep(&ep->com);
> -}
> -
> -static int iwch_l2t_send(struct t3cdev *tdev, struct sk_buff *skb, struct l2t_entry *l2e)
> -{
> -	int	error = 0;
> -	struct cxio_rdev *rdev;
> -
> -	rdev = (struct cxio_rdev *)tdev->ulp;
> -	if (cxio_fatal_error(rdev)) {
> -		kfree_skb(skb);
> -		return -EIO;
> -	}
> -	error = l2t_send(tdev, skb, l2e);
> -	if (error < 0)
> -		kfree_skb(skb);
> -	return error < 0 ? error : 0;
> -}
> -
> -int iwch_cxgb3_ofld_send(struct t3cdev *tdev, struct sk_buff *skb)
> -{
> -	int	error = 0;
> -	struct cxio_rdev *rdev;
> -
> -	rdev = (struct cxio_rdev *)tdev->ulp;
> -	if (cxio_fatal_error(rdev)) {
> -		kfree_skb(skb);
> -		return -EIO;
> -	}
> -	error = cxgb3_ofld_send(tdev, skb);
> -	if (error < 0)
> -		kfree_skb(skb);
> -	return error < 0 ? error : 0;
> -}
> -
> -static void release_tid(struct t3cdev *tdev, u32 hwtid, struct sk_buff *skb)
> -{
> -	struct cpl_tid_release *req;
> -
> -	skb = get_skb(skb, sizeof(*req), GFP_KERNEL);
> -	if (!skb)
> -		return;
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_TID_RELEASE, hwtid));
> -	skb->priority = CPL_PRIORITY_SETUP;
> -	iwch_cxgb3_ofld_send(tdev, skb);
> -	return;
> -}
> -
> -int iwch_quiesce_tid(struct iwch_ep *ep)
> -{
> -	struct cpl_set_tcb_field *req;
> -	struct sk_buff *skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> -
> -	if (!skb)
> -		return -ENOMEM;
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, ep->hwtid));
> -	req->reply = 0;
> -	req->cpu_idx = 0;
> -	req->word = htons(W_TCB_RX_QUIESCE);
> -	req->mask = cpu_to_be64(1ULL << S_TCB_RX_QUIESCE);
> -	req->val = cpu_to_be64(1 << S_TCB_RX_QUIESCE);
> -
> -	skb->priority = CPL_PRIORITY_DATA;
> -	return iwch_cxgb3_ofld_send(ep->com.tdev, skb);
> -}
> -
> -int iwch_resume_tid(struct iwch_ep *ep)
> -{
> -	struct cpl_set_tcb_field *req;
> -	struct sk_buff *skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> -
> -	if (!skb)
> -		return -ENOMEM;
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, ep->hwtid));
> -	req->reply = 0;
> -	req->cpu_idx = 0;
> -	req->word = htons(W_TCB_RX_QUIESCE);
> -	req->mask = cpu_to_be64(1ULL << S_TCB_RX_QUIESCE);
> -	req->val = 0;
> -
> -	skb->priority = CPL_PRIORITY_DATA;
> -	return iwch_cxgb3_ofld_send(ep->com.tdev, skb);
> -}
> -
> -static void set_emss(struct iwch_ep *ep, u16 opt)
> -{
> -	pr_debug("%s ep %p opt %u\n", __func__, ep, opt);
> -	ep->emss = T3C_DATA(ep->com.tdev)->mtus[G_TCPOPT_MSS(opt)] - 40;
> -	if (G_TCPOPT_TSTAMP(opt))
> -		ep->emss -= 12;
> -	if (ep->emss < 128)
> -		ep->emss = 128;
> -	pr_debug("emss=%d\n", ep->emss);
> -}
> -
> -static enum iwch_ep_state state_read(struct iwch_ep_common *epc)
> -{
> -	unsigned long flags;
> -	enum iwch_ep_state state;
> -
> -	spin_lock_irqsave(&epc->lock, flags);
> -	state = epc->state;
> -	spin_unlock_irqrestore(&epc->lock, flags);
> -	return state;
> -}
> -
> -static void __state_set(struct iwch_ep_common *epc, enum iwch_ep_state new)
> -{
> -	epc->state = new;
> -}
> -
> -static void state_set(struct iwch_ep_common *epc, enum iwch_ep_state new)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&epc->lock, flags);
> -	pr_debug("%s - %s -> %s\n", __func__, states[epc->state], states[new]);
> -	__state_set(epc, new);
> -	spin_unlock_irqrestore(&epc->lock, flags);
> -	return;
> -}
> -
> -static void *alloc_ep(int size, gfp_t gfp)
> -{
> -	struct iwch_ep_common *epc;
> -
> -	epc = kzalloc(size, gfp);
> -	if (epc) {
> -		kref_init(&epc->kref);
> -		spin_lock_init(&epc->lock);
> -		init_waitqueue_head(&epc->waitq);
> -	}
> -	pr_debug("%s alloc ep %p\n", __func__, epc);
> -	return epc;
> -}
> -
> -void __free_ep(struct kref *kref)
> -{
> -	struct iwch_ep *ep;
> -	ep = container_of(container_of(kref, struct iwch_ep_common, kref),
> -			  struct iwch_ep, com);
> -	pr_debug("%s ep %p state %s\n",
> -		 __func__, ep, states[state_read(&ep->com)]);
> -	if (test_bit(RELEASE_RESOURCES, &ep->com.flags)) {
> -		cxgb3_remove_tid(ep->com.tdev, (void *)ep, ep->hwtid);
> -		dst_release(ep->dst);
> -		l2t_release(ep->com.tdev, ep->l2t);
> -	}
> -	kfree(ep);
> -}
> -
> -static void release_ep_resources(struct iwch_ep *ep)
> -{
> -	pr_debug("%s ep %p tid %d\n", __func__, ep, ep->hwtid);
> -	set_bit(RELEASE_RESOURCES, &ep->com.flags);
> -	put_ep(&ep->com);
> -}
> -
> -static int status2errno(int status)
> -{
> -	switch (status) {
> -	case CPL_ERR_NONE:
> -		return 0;
> -	case CPL_ERR_CONN_RESET:
> -		return -ECONNRESET;
> -	case CPL_ERR_ARP_MISS:
> -		return -EHOSTUNREACH;
> -	case CPL_ERR_CONN_TIMEDOUT:
> -		return -ETIMEDOUT;
> -	case CPL_ERR_TCAM_FULL:
> -		return -ENOMEM;
> -	case CPL_ERR_CONN_EXIST:
> -		return -EADDRINUSE;
> -	default:
> -		return -EIO;
> -	}
> -}
> -
> -/*
> - * Try and reuse skbs already allocated...
> - */
> -static struct sk_buff *get_skb(struct sk_buff *skb, int len, gfp_t gfp)
> -{
> -	if (skb && !skb_is_nonlinear(skb) && !skb_cloned(skb)) {
> -		skb_trim(skb, 0);
> -		skb_get(skb);
> -	} else {
> -		skb = alloc_skb(len, gfp);
> -	}
> -	return skb;
> -}
> -
> -static struct rtable *find_route(struct t3cdev *dev, __be32 local_ip,
> -				 __be32 peer_ip, __be16 local_port,
> -				 __be16 peer_port, u8 tos)
> -{
> -	struct rtable *rt;
> -	struct flowi4 fl4;
> -
> -	rt = ip_route_output_ports(&init_net, &fl4, NULL, peer_ip, local_ip,
> -				   peer_port, local_port, IPPROTO_TCP,
> -				   tos, 0);
> -	if (IS_ERR(rt))
> -		return NULL;
> -	return rt;
> -}
> -
> -static unsigned int find_best_mtu(const struct t3c_data *d, unsigned short mtu)
> -{
> -	int i = 0;
> -
> -	while (i < d->nmtus - 1 && d->mtus[i + 1] <= mtu)
> -		++i;
> -	return i;
> -}
> -
> -static void arp_failure_discard(struct t3cdev *dev, struct sk_buff *skb)
> -{
> -	pr_debug("%s t3cdev %p\n", __func__, dev);
> -	kfree_skb(skb);
> -}
> -
> -/*
> - * Handle an ARP failure for an active open.
> - */
> -static void act_open_req_arp_failure(struct t3cdev *dev, struct sk_buff *skb)
> -{
> -	pr_err("ARP failure during connect\n");
> -	kfree_skb(skb);
> -}
> -
> -/*
> - * Handle an ARP failure for a CPL_ABORT_REQ.  Change it into a no RST variant
> - * and send it along.
> - */
> -static void abort_arp_failure(struct t3cdev *dev, struct sk_buff *skb)
> -{
> -	struct cpl_abort_req *req = cplhdr(skb);
> -
> -	pr_debug("%s t3cdev %p\n", __func__, dev);
> -	req->cmd = CPL_ABORT_NO_RST;
> -	iwch_cxgb3_ofld_send(dev, skb);
> -}
> -
> -static int send_halfclose(struct iwch_ep *ep, gfp_t gfp)
> -{
> -	struct cpl_close_con_req *req;
> -	struct sk_buff *skb;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	skb = get_skb(NULL, sizeof(*req), gfp);
> -	if (!skb) {
> -		pr_err("%s - failed to alloc skb\n", __func__);
> -		return -ENOMEM;
> -	}
> -	skb->priority = CPL_PRIORITY_DATA;
> -	set_arp_failure_handler(skb, arp_failure_discard);
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_CLOSE_CON));
> -	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_CON_REQ, ep->hwtid));
> -	return iwch_l2t_send(ep->com.tdev, skb, ep->l2t);
> -}
> -
> -static int send_abort(struct iwch_ep *ep, struct sk_buff *skb, gfp_t gfp)
> -{
> -	struct cpl_abort_req *req;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	skb = get_skb(skb, sizeof(*req), gfp);
> -	if (!skb) {
> -		pr_err("%s - failed to alloc skb\n", __func__);
> -		return -ENOMEM;
> -	}
> -	skb->priority = CPL_PRIORITY_DATA;
> -	set_arp_failure_handler(skb, abort_arp_failure);
> -	req = skb_put_zero(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_REQ));
> -	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ABORT_REQ, ep->hwtid));
> -	req->cmd = CPL_ABORT_SEND_RST;
> -	return iwch_l2t_send(ep->com.tdev, skb, ep->l2t);
> -}
> -
> -static int send_connect(struct iwch_ep *ep)
> -{
> -	struct cpl_act_open_req *req;
> -	struct sk_buff *skb;
> -	u32 opt0h, opt0l, opt2;
> -	unsigned int mtu_idx;
> -	int wscale;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -
> -	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> -	if (!skb) {
> -		pr_err("%s - failed to alloc skb\n", __func__);
> -		return -ENOMEM;
> -	}
> -	mtu_idx = find_best_mtu(T3C_DATA(ep->com.tdev), dst_mtu(ep->dst));
> -	wscale = compute_wscale(rcv_win);
> -	opt0h = V_NAGLE(0) |
> -	    V_NO_CONG(nocong) |
> -	    V_KEEP_ALIVE(1) |
> -	    F_TCAM_BYPASS |
> -	    V_WND_SCALE(wscale) |
> -	    V_MSS_IDX(mtu_idx) |
> -	    V_L2T_IDX(ep->l2t->idx) | V_TX_CHANNEL(ep->l2t->smt_idx);
> -	opt0l = V_TOS((ep->tos >> 2) & M_TOS) | V_RCV_BUFSIZ(rcv_win>>10);
> -	opt2 = F_RX_COALESCE_VALID | V_RX_COALESCE(0) | V_FLAVORS_VALID(1) |
> -	       V_CONG_CONTROL_FLAVOR(cong_flavor);
> -	skb->priority = CPL_PRIORITY_SETUP;
> -	set_arp_failure_handler(skb, act_open_req_arp_failure);
> -
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ, ep->atid));
> -	req->local_port = ep->com.local_addr.sin_port;
> -	req->peer_port = ep->com.remote_addr.sin_port;
> -	req->local_ip = ep->com.local_addr.sin_addr.s_addr;
> -	req->peer_ip = ep->com.remote_addr.sin_addr.s_addr;
> -	req->opt0h = htonl(opt0h);
> -	req->opt0l = htonl(opt0l);
> -	req->params = 0;
> -	req->opt2 = htonl(opt2);
> -	return iwch_l2t_send(ep->com.tdev, skb, ep->l2t);
> -}
> -
> -static void send_mpa_req(struct iwch_ep *ep, struct sk_buff *skb)
> -{
> -	int mpalen;
> -	struct tx_data_wr *req;
> -	struct mpa_message *mpa;
> -	int len;
> -
> -	pr_debug("%s ep %p pd_len %d\n", __func__, ep, ep->plen);
> -
> -	BUG_ON(skb_cloned(skb));
> -
> -	mpalen = sizeof(*mpa) + ep->plen;
> -	if (skb->data + mpalen + sizeof(*req) > skb_end_pointer(skb)) {
> -		kfree_skb(skb);
> -		skb=alloc_skb(mpalen + sizeof(*req), GFP_KERNEL);
> -		if (!skb) {
> -			connect_reply_upcall(ep, -ENOMEM);
> -			return;
> -		}
> -	}
> -	skb_trim(skb, 0);
> -	skb_reserve(skb, sizeof(*req));
> -	skb_put(skb, mpalen);
> -	skb->priority = CPL_PRIORITY_DATA;
> -	mpa = (struct mpa_message *) skb->data;
> -	memset(mpa, 0, sizeof(*mpa));
> -	memcpy(mpa->key, MPA_KEY_REQ, sizeof(mpa->key));
> -	mpa->flags = (crc_enabled ? MPA_CRC : 0) |
> -		     (markers_enabled ? MPA_MARKERS : 0);
> -	mpa->private_data_size = htons(ep->plen);
> -	mpa->revision = mpa_rev;
> -
> -	if (ep->plen)
> -		memcpy(mpa->private_data, ep->mpa_pkt + sizeof(*mpa), ep->plen);
> -
> -	/*
> -	 * Reference the mpa skb.  This ensures the data area
> -	 * will remain in memory until the hw acks the tx.
> -	 * Function tx_ack() will deref it.
> -	 */
> -	skb_get(skb);
> -	set_arp_failure_handler(skb, arp_failure_discard);
> -	skb_reset_transport_header(skb);
> -	len = skb->len;
> -	req = skb_push(skb, sizeof(*req));
> -	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA)|F_WR_COMPL);
> -	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	req->len = htonl(len);
> -	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
> -			   V_TX_SNDBUF(snd_win>>15));
> -	req->flags = htonl(F_TX_INIT);
> -	req->sndseq = htonl(ep->snd_seq);
> -	BUG_ON(ep->mpa_skb);
> -	ep->mpa_skb = skb;
> -	iwch_l2t_send(ep->com.tdev, skb, ep->l2t);
> -	start_ep_timer(ep);
> -	state_set(&ep->com, MPA_REQ_SENT);
> -	return;
> -}
> -
> -static int send_mpa_reject(struct iwch_ep *ep, const void *pdata, u8 plen)
> -{
> -	int mpalen;
> -	struct tx_data_wr *req;
> -	struct mpa_message *mpa;
> -	struct sk_buff *skb;
> -
> -	pr_debug("%s ep %p plen %d\n", __func__, ep, plen);
> -
> -	mpalen = sizeof(*mpa) + plen;
> -
> -	skb = get_skb(NULL, mpalen + sizeof(*req), GFP_KERNEL);
> -	if (!skb) {
> -		pr_err("%s - cannot alloc skb!\n", __func__);
> -		return -ENOMEM;
> -	}
> -	skb_reserve(skb, sizeof(*req));
> -	mpa = skb_put(skb, mpalen);
> -	memset(mpa, 0, sizeof(*mpa));
> -	memcpy(mpa->key, MPA_KEY_REP, sizeof(mpa->key));
> -	mpa->flags = MPA_REJECT;
> -	mpa->revision = mpa_rev;
> -	mpa->private_data_size = htons(plen);
> -	if (plen)
> -		memcpy(mpa->private_data, pdata, plen);
> -
> -	/*
> -	 * Reference the mpa skb again.  This ensures the data area
> -	 * will remain in memory until the hw acks the tx.
> -	 * Function tx_ack() will deref it.
> -	 */
> -	skb_get(skb);
> -	skb->priority = CPL_PRIORITY_DATA;
> -	set_arp_failure_handler(skb, arp_failure_discard);
> -	skb_reset_transport_header(skb);
> -	req = skb_push(skb, sizeof(*req));
> -	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA)|F_WR_COMPL);
> -	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	req->len = htonl(mpalen);
> -	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
> -			   V_TX_SNDBUF(snd_win>>15));
> -	req->flags = htonl(F_TX_INIT);
> -	req->sndseq = htonl(ep->snd_seq);
> -	BUG_ON(ep->mpa_skb);
> -	ep->mpa_skb = skb;
> -	return iwch_l2t_send(ep->com.tdev, skb, ep->l2t);
> -}
> -
> -static int send_mpa_reply(struct iwch_ep *ep, const void *pdata, u8 plen)
> -{
> -	int mpalen;
> -	struct tx_data_wr *req;
> -	struct mpa_message *mpa;
> -	int len;
> -	struct sk_buff *skb;
> -
> -	pr_debug("%s ep %p plen %d\n", __func__, ep, plen);
> -
> -	mpalen = sizeof(*mpa) + plen;
> -
> -	skb = get_skb(NULL, mpalen + sizeof(*req), GFP_KERNEL);
> -	if (!skb) {
> -		pr_err("%s - cannot alloc skb!\n", __func__);
> -		return -ENOMEM;
> -	}
> -	skb->priority = CPL_PRIORITY_DATA;
> -	skb_reserve(skb, sizeof(*req));
> -	mpa = skb_put(skb, mpalen);
> -	memset(mpa, 0, sizeof(*mpa));
> -	memcpy(mpa->key, MPA_KEY_REP, sizeof(mpa->key));
> -	mpa->flags = (ep->mpa_attr.crc_enabled ? MPA_CRC : 0) |
> -		     (markers_enabled ? MPA_MARKERS : 0);
> -	mpa->revision = mpa_rev;
> -	mpa->private_data_size = htons(plen);
> -	if (plen)
> -		memcpy(mpa->private_data, pdata, plen);
> -
> -	/*
> -	 * Reference the mpa skb.  This ensures the data area
> -	 * will remain in memory until the hw acks the tx.
> -	 * Function tx_ack() will deref it.
> -	 */
> -	skb_get(skb);
> -	set_arp_failure_handler(skb, arp_failure_discard);
> -	skb_reset_transport_header(skb);
> -	len = skb->len;
> -	req = skb_push(skb, sizeof(*req));
> -	req->wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_TX_DATA)|F_WR_COMPL);
> -	req->wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	req->len = htonl(len);
> -	req->param = htonl(V_TX_PORT(ep->l2t->smt_idx) |
> -			   V_TX_SNDBUF(snd_win>>15));
> -	req->flags = htonl(F_TX_INIT);
> -	req->sndseq = htonl(ep->snd_seq);
> -	ep->mpa_skb = skb;
> -	state_set(&ep->com, MPA_REP_SENT);
> -	return iwch_l2t_send(ep->com.tdev, skb, ep->l2t);
> -}
> -
> -static int act_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	struct cpl_act_establish *req = cplhdr(skb);
> -	unsigned int tid = GET_TID(req);
> -
> -	pr_debug("%s ep %p tid %d\n", __func__, ep, tid);
> -
> -	dst_confirm(ep->dst);
> -
> -	/* setup the hwtid for this connection */
> -	ep->hwtid = tid;
> -	cxgb3_insert_tid(ep->com.tdev, &t3c_client, ep, tid);
> -
> -	ep->snd_seq = ntohl(req->snd_isn);
> -	ep->rcv_seq = ntohl(req->rcv_isn);
> -
> -	set_emss(ep, ntohs(req->tcp_opt));
> -
> -	/* dealloc the atid */
> -	cxgb3_free_atid(ep->com.tdev, ep->atid);
> -
> -	/* start MPA negotiation */
> -	send_mpa_req(ep, skb);
> -
> -	return 0;
> -}
> -
> -static void abort_connection(struct iwch_ep *ep, struct sk_buff *skb, gfp_t gfp)
> -{
> -	pr_debug("%s ep %p\n", __FILE__, ep);
> -	state_set(&ep->com, ABORTING);
> -	send_abort(ep, skb, gfp);
> -}
> -
> -static void close_complete_upcall(struct iwch_ep *ep)
> -{
> -	struct iw_cm_event event;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	memset(&event, 0, sizeof(event));
> -	event.event = IW_CM_EVENT_CLOSE;
> -	if (ep->com.cm_id) {
> -		pr_debug("close complete delivered ep %p cm_id %p tid %d\n",
> -			 ep, ep->com.cm_id, ep->hwtid);
> -		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
> -		ep->com.cm_id->rem_ref(ep->com.cm_id);
> -		ep->com.cm_id = NULL;
> -		ep->com.qp = NULL;
> -	}
> -}
> -
> -static void peer_close_upcall(struct iwch_ep *ep)
> -{
> -	struct iw_cm_event event;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	memset(&event, 0, sizeof(event));
> -	event.event = IW_CM_EVENT_DISCONNECT;
> -	if (ep->com.cm_id) {
> -		pr_debug("peer close delivered ep %p cm_id %p tid %d\n",
> -			 ep, ep->com.cm_id, ep->hwtid);
> -		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
> -	}
> -}
> -
> -static void peer_abort_upcall(struct iwch_ep *ep)
> -{
> -	struct iw_cm_event event;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	memset(&event, 0, sizeof(event));
> -	event.event = IW_CM_EVENT_CLOSE;
> -	event.status = -ECONNRESET;
> -	if (ep->com.cm_id) {
> -		pr_debug("abort delivered ep %p cm_id %p tid %d\n", ep,
> -			 ep->com.cm_id, ep->hwtid);
> -		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
> -		ep->com.cm_id->rem_ref(ep->com.cm_id);
> -		ep->com.cm_id = NULL;
> -		ep->com.qp = NULL;
> -	}
> -}
> -
> -static void connect_reply_upcall(struct iwch_ep *ep, int status)
> -{
> -	struct iw_cm_event event;
> -
> -	pr_debug("%s ep %p status %d\n", __func__, ep, status);
> -	memset(&event, 0, sizeof(event));
> -	event.event = IW_CM_EVENT_CONNECT_REPLY;
> -	event.status = status;
> -	memcpy(&event.local_addr, &ep->com.local_addr,
> -	       sizeof(ep->com.local_addr));
> -	memcpy(&event.remote_addr, &ep->com.remote_addr,
> -	       sizeof(ep->com.remote_addr));
> -
> -	if ((status == 0) || (status == -ECONNREFUSED)) {
> -		event.private_data_len = ep->plen;
> -		event.private_data = ep->mpa_pkt + sizeof(struct mpa_message);
> -	}
> -	if (ep->com.cm_id) {
> -		pr_debug("%s ep %p tid %d status %d\n", __func__, ep,
> -			 ep->hwtid, status);
> -		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
> -	}
> -	if (status < 0) {
> -		ep->com.cm_id->rem_ref(ep->com.cm_id);
> -		ep->com.cm_id = NULL;
> -		ep->com.qp = NULL;
> -	}
> -}
> -
> -static void connect_request_upcall(struct iwch_ep *ep)
> -{
> -	struct iw_cm_event event;
> -
> -	pr_debug("%s ep %p tid %d\n", __func__, ep, ep->hwtid);
> -	memset(&event, 0, sizeof(event));
> -	event.event = IW_CM_EVENT_CONNECT_REQUEST;
> -	memcpy(&event.local_addr, &ep->com.local_addr,
> -	       sizeof(ep->com.local_addr));
> -	memcpy(&event.remote_addr, &ep->com.remote_addr,
> -	       sizeof(ep->com.local_addr));
> -	event.private_data_len = ep->plen;
> -	event.private_data = ep->mpa_pkt + sizeof(struct mpa_message);
> -	event.provider_data = ep;
> -	/*
> -	 * Until ird/ord negotiation via MPAv2 support is added, send max
> -	 * supported values
> -	 */
> -	event.ird = event.ord = 8;
> -	if (state_read(&ep->parent_ep->com) != DEAD) {
> -		get_ep(&ep->com);
> -		ep->parent_ep->com.cm_id->event_handler(
> -						ep->parent_ep->com.cm_id,
> -						&event);
> -	}
> -	put_ep(&ep->parent_ep->com);
> -	ep->parent_ep = NULL;
> -}
> -
> -static void established_upcall(struct iwch_ep *ep)
> -{
> -	struct iw_cm_event event;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	memset(&event, 0, sizeof(event));
> -	event.event = IW_CM_EVENT_ESTABLISHED;
> -	/*
> -	 * Until ird/ord negotiation via MPAv2 support is added, send max
> -	 * supported values
> -	 */
> -	event.ird = event.ord = 8;
> -	if (ep->com.cm_id) {
> -		pr_debug("%s ep %p tid %d\n", __func__, ep, ep->hwtid);
> -		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
> -	}
> -}
> -
> -static int update_rx_credits(struct iwch_ep *ep, u32 credits)
> -{
> -	struct cpl_rx_data_ack *req;
> -	struct sk_buff *skb;
> -
> -	pr_debug("%s ep %p credits %u\n", __func__, ep, credits);
> -	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> -	if (!skb) {
> -		pr_err("update_rx_credits - cannot alloc skb!\n");
> -		return 0;
> -	}
> -
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_RX_DATA_ACK, ep->hwtid));
> -	req->credit_dack = htonl(V_RX_CREDITS(credits) | V_RX_FORCE_ACK(1));
> -	skb->priority = CPL_PRIORITY_ACK;
> -	iwch_cxgb3_ofld_send(ep->com.tdev, skb);
> -	return credits;
> -}
> -
> -static void process_mpa_reply(struct iwch_ep *ep, struct sk_buff *skb)
> -{
> -	struct mpa_message *mpa;
> -	u16 plen;
> -	struct iwch_qp_attributes attrs;
> -	enum iwch_qp_attr_mask mask;
> -	int err;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -
> -	/*
> -	 * Stop mpa timer.  If it expired, then the state has
> -	 * changed and we bail since ep_timeout already aborted
> -	 * the connection.
> -	 */
> -	stop_ep_timer(ep);
> -	if (state_read(&ep->com) != MPA_REQ_SENT)
> -		return;
> -
> -	/*
> -	 * If we get more than the supported amount of private data
> -	 * then we must fail this connection.
> -	 */
> -	if (ep->mpa_pkt_len + skb->len > sizeof(ep->mpa_pkt)) {
> -		err = -EINVAL;
> -		goto err;
> -	}
> -
> -	/*
> -	 * copy the new data into our accumulation buffer.
> -	 */
> -	skb_copy_from_linear_data(skb, &(ep->mpa_pkt[ep->mpa_pkt_len]),
> -				  skb->len);
> -	ep->mpa_pkt_len += skb->len;
> -
> -	/*
> -	 * if we don't even have the mpa message, then bail.
> -	 */
> -	if (ep->mpa_pkt_len < sizeof(*mpa))
> -		return;
> -	mpa = (struct mpa_message *) ep->mpa_pkt;
> -
> -	/* Validate MPA header. */
> -	if (mpa->revision != mpa_rev) {
> -		err = -EPROTO;
> -		goto err;
> -	}
> -	if (memcmp(mpa->key, MPA_KEY_REP, sizeof(mpa->key))) {
> -		err = -EPROTO;
> -		goto err;
> -	}
> -
> -	plen = ntohs(mpa->private_data_size);
> -
> -	/*
> -	 * Fail if there's too much private data.
> -	 */
> -	if (plen > MPA_MAX_PRIVATE_DATA) {
> -		err = -EPROTO;
> -		goto err;
> -	}
> -
> -	/*
> -	 * If plen does not account for pkt size
> -	 */
> -	if (ep->mpa_pkt_len > (sizeof(*mpa) + plen)) {
> -		err = -EPROTO;
> -		goto err;
> -	}
> -
> -	ep->plen = (u8) plen;
> -
> -	/*
> -	 * If we don't have all the pdata yet, then bail.
> -	 * We'll continue process when more data arrives.
> -	 */
> -	if (ep->mpa_pkt_len < (sizeof(*mpa) + plen))
> -		return;
> -
> -	if (mpa->flags & MPA_REJECT) {
> -		err = -ECONNREFUSED;
> -		goto err;
> -	}
> -
> -	/*
> -	 * If we get here we have accumulated the entire mpa
> -	 * start reply message including private data. And
> -	 * the MPA header is valid.
> -	 */
> -	state_set(&ep->com, FPDU_MODE);
> -	ep->mpa_attr.initiator = 1;
> -	ep->mpa_attr.crc_enabled = (mpa->flags & MPA_CRC) | crc_enabled ? 1 : 0;
> -	ep->mpa_attr.recv_marker_enabled = markers_enabled;
> -	ep->mpa_attr.xmit_marker_enabled = mpa->flags & MPA_MARKERS ? 1 : 0;
> -	ep->mpa_attr.version = mpa_rev;
> -	pr_debug("%s - crc_enabled=%d, recv_marker_enabled=%d, xmit_marker_enabled=%d, version=%d\n",
> -		 __func__,
> -		 ep->mpa_attr.crc_enabled, ep->mpa_attr.recv_marker_enabled,
> -		 ep->mpa_attr.xmit_marker_enabled, ep->mpa_attr.version);
> -
> -	attrs.mpa_attr = ep->mpa_attr;
> -	attrs.max_ird = ep->ird;
> -	attrs.max_ord = ep->ord;
> -	attrs.llp_stream_handle = ep;
> -	attrs.next_state = IWCH_QP_STATE_RTS;
> -
> -	mask = IWCH_QP_ATTR_NEXT_STATE |
> -	    IWCH_QP_ATTR_LLP_STREAM_HANDLE | IWCH_QP_ATTR_MPA_ATTR |
> -	    IWCH_QP_ATTR_MAX_IRD | IWCH_QP_ATTR_MAX_ORD;
> -
> -	/* bind QP and TID with INIT_WR */
> -	err = iwch_modify_qp(ep->com.qp->rhp,
> -			     ep->com.qp, mask, &attrs, 1);
> -	if (err)
> -		goto err;
> -
> -	if (peer2peer && iwch_rqes_posted(ep->com.qp) == 0) {
> -		iwch_post_zb_read(ep);
> -	}
> -
> -	goto out;
> -err:
> -	abort_connection(ep, skb, GFP_KERNEL);
> -out:
> -	connect_reply_upcall(ep, err);
> -	return;
> -}
> -
> -static void process_mpa_request(struct iwch_ep *ep, struct sk_buff *skb)
> -{
> -	struct mpa_message *mpa;
> -	u16 plen;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -
> -	/*
> -	 * Stop mpa timer.  If it expired, then the state has
> -	 * changed and we bail since ep_timeout already aborted
> -	 * the connection.
> -	 */
> -	stop_ep_timer(ep);
> -	if (state_read(&ep->com) != MPA_REQ_WAIT)
> -		return;
> -
> -	/*
> -	 * If we get more than the supported amount of private data
> -	 * then we must fail this connection.
> -	 */
> -	if (ep->mpa_pkt_len + skb->len > sizeof(ep->mpa_pkt)) {
> -		abort_connection(ep, skb, GFP_KERNEL);
> -		return;
> -	}
> -
> -	pr_debug("%s enter (%s line %u)\n", __func__, __FILE__, __LINE__);
> -
> -	/*
> -	 * Copy the new data into our accumulation buffer.
> -	 */
> -	skb_copy_from_linear_data(skb, &(ep->mpa_pkt[ep->mpa_pkt_len]),
> -				  skb->len);
> -	ep->mpa_pkt_len += skb->len;
> -
> -	/*
> -	 * If we don't even have the mpa message, then bail.
> -	 * We'll continue process when more data arrives.
> -	 */
> -	if (ep->mpa_pkt_len < sizeof(*mpa))
> -		return;
> -	pr_debug("%s enter (%s line %u)\n", __func__, __FILE__, __LINE__);
> -	mpa = (struct mpa_message *) ep->mpa_pkt;
> -
> -	/*
> -	 * Validate MPA Header.
> -	 */
> -	if (mpa->revision != mpa_rev) {
> -		abort_connection(ep, skb, GFP_KERNEL);
> -		return;
> -	}
> -
> -	if (memcmp(mpa->key, MPA_KEY_REQ, sizeof(mpa->key))) {
> -		abort_connection(ep, skb, GFP_KERNEL);
> -		return;
> -	}
> -
> -	plen = ntohs(mpa->private_data_size);
> -
> -	/*
> -	 * Fail if there's too much private data.
> -	 */
> -	if (plen > MPA_MAX_PRIVATE_DATA) {
> -		abort_connection(ep, skb, GFP_KERNEL);
> -		return;
> -	}
> -
> -	/*
> -	 * If plen does not account for pkt size
> -	 */
> -	if (ep->mpa_pkt_len > (sizeof(*mpa) + plen)) {
> -		abort_connection(ep, skb, GFP_KERNEL);
> -		return;
> -	}
> -	ep->plen = (u8) plen;
> -
> -	/*
> -	 * If we don't have all the pdata yet, then bail.
> -	 */
> -	if (ep->mpa_pkt_len < (sizeof(*mpa) + plen))
> -		return;
> -
> -	/*
> -	 * If we get here we have accumulated the entire mpa
> -	 * start reply message including private data.
> -	 */
> -	ep->mpa_attr.initiator = 0;
> -	ep->mpa_attr.crc_enabled = (mpa->flags & MPA_CRC) | crc_enabled ? 1 : 0;
> -	ep->mpa_attr.recv_marker_enabled = markers_enabled;
> -	ep->mpa_attr.xmit_marker_enabled = mpa->flags & MPA_MARKERS ? 1 : 0;
> -	ep->mpa_attr.version = mpa_rev;
> -	pr_debug("%s - crc_enabled=%d, recv_marker_enabled=%d, xmit_marker_enabled=%d, version=%d\n",
> -		 __func__,
> -		 ep->mpa_attr.crc_enabled, ep->mpa_attr.recv_marker_enabled,
> -		 ep->mpa_attr.xmit_marker_enabled, ep->mpa_attr.version);
> -
> -	state_set(&ep->com, MPA_REQ_RCVD);
> -
> -	/* drive upcall */
> -	connect_request_upcall(ep);
> -	return;
> -}
> -
> -static int rx_data(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	struct cpl_rx_data *hdr = cplhdr(skb);
> -	unsigned int dlen = ntohs(hdr->len);
> -
> -	pr_debug("%s ep %p dlen %u\n", __func__, ep, dlen);
> -
> -	skb_pull(skb, sizeof(*hdr));
> -	skb_trim(skb, dlen);
> -
> -	ep->rcv_seq += dlen;
> -	BUG_ON(ep->rcv_seq != (ntohl(hdr->seq) + dlen));
> -
> -	switch (state_read(&ep->com)) {
> -	case MPA_REQ_SENT:
> -		process_mpa_reply(ep, skb);
> -		break;
> -	case MPA_REQ_WAIT:
> -		process_mpa_request(ep, skb);
> -		break;
> -	case MPA_REP_SENT:
> -		break;
> -	default:
> -		pr_err("%s Unexpected streaming data. ep %p state %d tid %d\n",
> -		       __func__, ep, state_read(&ep->com), ep->hwtid);
> -
> -		/*
> -		 * The ep will timeout and inform the ULP of the failure.
> -		 * See ep_timeout().
> -		 */
> -		break;
> -	}
> -
> -	/* update RX credits */
> -	update_rx_credits(ep, dlen);
> -
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -/*
> - * Upcall from the adapter indicating data has been transmitted.
> - * For us its just the single MPA request or reply.  We can now free
> - * the skb holding the mpa message.
> - */
> -static int tx_ack(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	struct cpl_wr_ack *hdr = cplhdr(skb);
> -	unsigned int credits = ntohs(hdr->credits);
> -	unsigned long flags;
> -	int post_zb = 0;
> -
> -	pr_debug("%s ep %p credits %u\n", __func__, ep, credits);
> -
> -	if (credits == 0) {
> -		pr_debug("%s 0 credit ack  ep %p state %u\n",
> -			 __func__, ep, state_read(&ep->com));
> -		return CPL_RET_BUF_DONE;
> -	}
> -
> -	spin_lock_irqsave(&ep->com.lock, flags);
> -	BUG_ON(credits != 1);
> -	dst_confirm(ep->dst);
> -	if (!ep->mpa_skb) {
> -		pr_debug("%s rdma_init wr_ack ep %p state %u\n",
> -			 __func__, ep, ep->com.state);
> -		if (ep->mpa_attr.initiator) {
> -			pr_debug("%s initiator ep %p state %u\n",
> -				 __func__, ep, ep->com.state);
> -			if (peer2peer && ep->com.state == FPDU_MODE)
> -				post_zb = 1;
> -		} else {
> -			pr_debug("%s responder ep %p state %u\n",
> -				 __func__, ep, ep->com.state);
> -			if (ep->com.state == MPA_REQ_RCVD) {
> -				ep->com.rpl_done = 1;
> -				wake_up(&ep->com.waitq);
> -			}
> -		}
> -	} else {
> -		pr_debug("%s lsm ack ep %p state %u freeing skb\n",
> -			 __func__, ep, ep->com.state);
> -		kfree_skb(ep->mpa_skb);
> -		ep->mpa_skb = NULL;
> -	}
> -	spin_unlock_irqrestore(&ep->com.lock, flags);
> -	if (post_zb)
> -		iwch_post_zb_read(ep);
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static int abort_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	unsigned long flags;
> -	int release = 0;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	BUG_ON(!ep);
> -
> -	/*
> -	 * We get 2 abort replies from the HW.  The first one must
> -	 * be ignored except for scribbling that we need one more.
> -	 */
> -	if (!test_and_set_bit(ABORT_REQ_IN_PROGRESS, &ep->com.flags)) {
> -		return CPL_RET_BUF_DONE;
> -	}
> -
> -	spin_lock_irqsave(&ep->com.lock, flags);
> -	switch (ep->com.state) {
> -	case ABORTING:
> -		close_complete_upcall(ep);
> -		__state_set(&ep->com, DEAD);
> -		release = 1;
> -		break;
> -	default:
> -		pr_err("%s ep %p state %d\n", __func__, ep, ep->com.state);
> -		break;
> -	}
> -	spin_unlock_irqrestore(&ep->com.lock, flags);
> -
> -	if (release)
> -		release_ep_resources(ep);
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -/*
> - * Return whether a failed active open has allocated a TID
> - */
> -static inline int act_open_has_tid(int status)
> -{
> -	return status != CPL_ERR_TCAM_FULL && status != CPL_ERR_CONN_EXIST &&
> -	       status != CPL_ERR_ARP_MISS;
> -}
> -
> -static int act_open_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	struct cpl_act_open_rpl *rpl = cplhdr(skb);
> -
> -	pr_debug("%s ep %p status %u errno %d\n", __func__, ep, rpl->status,
> -		 status2errno(rpl->status));
> -	connect_reply_upcall(ep, status2errno(rpl->status));
> -	state_set(&ep->com, DEAD);
> -	if (ep->com.tdev->type != T3A && act_open_has_tid(rpl->status))
> -		release_tid(ep->com.tdev, GET_TID(rpl), NULL);
> -	cxgb3_free_atid(ep->com.tdev, ep->atid);
> -	dst_release(ep->dst);
> -	l2t_release(ep->com.tdev, ep->l2t);
> -	put_ep(&ep->com);
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static int listen_start(struct iwch_listen_ep *ep)
> -{
> -	struct sk_buff *skb;
> -	struct cpl_pass_open_req *req;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> -	if (!skb) {
> -		pr_err("t3c_listen_start failed to alloc skb!\n");
> -		return -ENOMEM;
> -	}
> -
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_PASS_OPEN_REQ, ep->stid));
> -	req->local_port = ep->com.local_addr.sin_port;
> -	req->local_ip = ep->com.local_addr.sin_addr.s_addr;
> -	req->peer_port = 0;
> -	req->peer_ip = 0;
> -	req->peer_netmask = 0;
> -	req->opt0h = htonl(F_DELACK | F_TCAM_BYPASS);
> -	req->opt0l = htonl(V_RCV_BUFSIZ(rcv_win>>10));
> -	req->opt1 = htonl(V_CONN_POLICY(CPL_CONN_POLICY_ASK));
> -
> -	skb->priority = 1;
> -	return iwch_cxgb3_ofld_send(ep->com.tdev, skb);
> -}
> -
> -static int pass_open_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_listen_ep *ep = ctx;
> -	struct cpl_pass_open_rpl *rpl = cplhdr(skb);
> -
> -	pr_debug("%s ep %p status %d error %d\n", __func__, ep,
> -		 rpl->status, status2errno(rpl->status));
> -	ep->com.rpl_err = status2errno(rpl->status);
> -	ep->com.rpl_done = 1;
> -	wake_up(&ep->com.waitq);
> -
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static int listen_stop(struct iwch_listen_ep *ep)
> -{
> -	struct sk_buff *skb;
> -	struct cpl_close_listserv_req *req;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> -	if (!skb) {
> -		pr_err("%s - failed to alloc skb\n", __func__);
> -		return -ENOMEM;
> -	}
> -	req = skb_put(skb, sizeof(*req));
> -	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	req->cpu_idx = 0;
> -	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_LISTSRV_REQ, ep->stid));
> -	skb->priority = 1;
> -	return iwch_cxgb3_ofld_send(ep->com.tdev, skb);
> -}
> -
> -static int close_listsrv_rpl(struct t3cdev *tdev, struct sk_buff *skb,
> -			     void *ctx)
> -{
> -	struct iwch_listen_ep *ep = ctx;
> -	struct cpl_close_listserv_rpl *rpl = cplhdr(skb);
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	ep->com.rpl_err = status2errno(rpl->status);
> -	ep->com.rpl_done = 1;
> -	wake_up(&ep->com.waitq);
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static void accept_cr(struct iwch_ep *ep, __be32 peer_ip, struct sk_buff *skb)
> -{
> -	struct cpl_pass_accept_rpl *rpl;
> -	unsigned int mtu_idx;
> -	u32 opt0h, opt0l, opt2;
> -	int wscale;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	BUG_ON(skb_cloned(skb));
> -	skb_trim(skb, sizeof(*rpl));
> -	skb_get(skb);
> -	mtu_idx = find_best_mtu(T3C_DATA(ep->com.tdev), dst_mtu(ep->dst));
> -	wscale = compute_wscale(rcv_win);
> -	opt0h = V_NAGLE(0) |
> -	    V_NO_CONG(nocong) |
> -	    V_KEEP_ALIVE(1) |
> -	    F_TCAM_BYPASS |
> -	    V_WND_SCALE(wscale) |
> -	    V_MSS_IDX(mtu_idx) |
> -	    V_L2T_IDX(ep->l2t->idx) | V_TX_CHANNEL(ep->l2t->smt_idx);
> -	opt0l = V_TOS((ep->tos >> 2) & M_TOS) | V_RCV_BUFSIZ(rcv_win>>10);
> -	opt2 = F_RX_COALESCE_VALID | V_RX_COALESCE(0) | V_FLAVORS_VALID(1) |
> -	       V_CONG_CONTROL_FLAVOR(cong_flavor);
> -
> -	rpl = cplhdr(skb);
> -	rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -	OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL, ep->hwtid));
> -	rpl->peer_ip = peer_ip;
> -	rpl->opt0h = htonl(opt0h);
> -	rpl->opt0l_status = htonl(opt0l | CPL_PASS_OPEN_ACCEPT);
> -	rpl->opt2 = htonl(opt2);
> -	rpl->rsvd = rpl->opt2;	/* workaround for HW bug */
> -	skb->priority = CPL_PRIORITY_SETUP;
> -	iwch_l2t_send(ep->com.tdev, skb, ep->l2t);
> -
> -	return;
> -}
> -
> -static void reject_cr(struct t3cdev *tdev, u32 hwtid, __be32 peer_ip,
> -		      struct sk_buff *skb)
> -{
> -	pr_debug("%s t3cdev %p tid %u peer_ip %x\n", __func__, tdev, hwtid,
> -		 peer_ip);
> -	BUG_ON(skb_cloned(skb));
> -	skb_trim(skb, sizeof(struct cpl_tid_release));
> -	skb_get(skb);
> -
> -	if (tdev->type != T3A)
> -		release_tid(tdev, hwtid, skb);
> -	else {
> -		struct cpl_pass_accept_rpl *rpl;
> -
> -		rpl = cplhdr(skb);
> -		skb->priority = CPL_PRIORITY_SETUP;
> -		rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> -		OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL,
> -						      hwtid));
> -		rpl->peer_ip = peer_ip;
> -		rpl->opt0h = htonl(F_TCAM_BYPASS);
> -		rpl->opt0l_status = htonl(CPL_PASS_OPEN_REJECT);
> -		rpl->opt2 = 0;
> -		rpl->rsvd = rpl->opt2;
> -		iwch_cxgb3_ofld_send(tdev, skb);
> -	}
> -}
> -
> -static int pass_accept_req(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *child_ep, *parent_ep = ctx;
> -	struct cpl_pass_accept_req *req = cplhdr(skb);
> -	unsigned int hwtid = GET_TID(req);
> -	struct dst_entry *dst;
> -	struct l2t_entry *l2t;
> -	struct rtable *rt;
> -	struct iff_mac tim;
> -
> -	pr_debug("%s parent ep %p tid %u\n", __func__, parent_ep, hwtid);
> -
> -	if (state_read(&parent_ep->com) != LISTEN) {
> -		pr_err("%s - listening ep not in LISTEN\n", __func__);
> -		goto reject;
> -	}
> -
> -	/*
> -	 * Find the netdev for this connection request.
> -	 */
> -	tim.mac_addr = req->dst_mac;
> -	tim.vlan_tag = ntohs(req->vlan_tag);
> -	if (tdev->ctl(tdev, GET_IFF_FROM_MAC, &tim) < 0 || !tim.dev) {
> -		pr_err("%s bad dst mac %pM\n", __func__, req->dst_mac);
> -		goto reject;
> -	}
> -
> -	/* Find output route */
> -	rt = find_route(tdev,
> -			req->local_ip,
> -			req->peer_ip,
> -			req->local_port,
> -			req->peer_port, G_PASS_OPEN_TOS(ntohl(req->tos_tid)));
> -	if (!rt) {
> -		pr_err("%s - failed to find dst entry!\n", __func__);
> -		goto reject;
> -	}
> -	dst = &rt->dst;
> -	l2t = t3_l2t_get(tdev, dst, NULL, &req->peer_ip);
> -	if (!l2t) {
> -		pr_err("%s - failed to allocate l2t entry!\n", __func__);
> -		dst_release(dst);
> -		goto reject;
> -	}
> -	child_ep = alloc_ep(sizeof(*child_ep), GFP_KERNEL);
> -	if (!child_ep) {
> -		pr_err("%s - failed to allocate ep entry!\n", __func__);
> -		l2t_release(tdev, l2t);
> -		dst_release(dst);
> -		goto reject;
> -	}
> -	state_set(&child_ep->com, CONNECTING);
> -	child_ep->com.tdev = tdev;
> -	child_ep->com.cm_id = NULL;
> -	child_ep->com.local_addr.sin_family = AF_INET;
> -	child_ep->com.local_addr.sin_port = req->local_port;
> -	child_ep->com.local_addr.sin_addr.s_addr = req->local_ip;
> -	child_ep->com.remote_addr.sin_family = AF_INET;
> -	child_ep->com.remote_addr.sin_port = req->peer_port;
> -	child_ep->com.remote_addr.sin_addr.s_addr = req->peer_ip;
> -	get_ep(&parent_ep->com);
> -	child_ep->parent_ep = parent_ep;
> -	child_ep->tos = G_PASS_OPEN_TOS(ntohl(req->tos_tid));
> -	child_ep->l2t = l2t;
> -	child_ep->dst = dst;
> -	child_ep->hwtid = hwtid;
> -	timer_setup(&child_ep->timer, ep_timeout, 0);
> -	cxgb3_insert_tid(tdev, &t3c_client, child_ep, hwtid);
> -	accept_cr(child_ep, req->peer_ip, skb);
> -	goto out;
> -reject:
> -	reject_cr(tdev, hwtid, req->peer_ip, skb);
> -out:
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static int pass_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	struct cpl_pass_establish *req = cplhdr(skb);
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	ep->snd_seq = ntohl(req->snd_isn);
> -	ep->rcv_seq = ntohl(req->rcv_isn);
> -
> -	set_emss(ep, ntohs(req->tcp_opt));
> -
> -	dst_confirm(ep->dst);
> -	state_set(&ep->com, MPA_REQ_WAIT);
> -	start_ep_timer(ep);
> -
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static int peer_close(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	struct iwch_qp_attributes attrs;
> -	unsigned long flags;
> -	int disconnect = 1;
> -	int release = 0;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	dst_confirm(ep->dst);
> -
> -	spin_lock_irqsave(&ep->com.lock, flags);
> -	switch (ep->com.state) {
> -	case MPA_REQ_WAIT:
> -		__state_set(&ep->com, CLOSING);
> -		break;
> -	case MPA_REQ_SENT:
> -		__state_set(&ep->com, CLOSING);
> -		connect_reply_upcall(ep, -ECONNRESET);
> -		break;
> -	case MPA_REQ_RCVD:
> -
> -		/*
> -		 * We're gonna mark this puppy DEAD, but keep
> -		 * the reference on it until the ULP accepts or
> -		 * rejects the CR. Also wake up anyone waiting
> -		 * in rdma connection migration (see iwch_accept_cr()).
> -		 */
> -		__state_set(&ep->com, CLOSING);
> -		ep->com.rpl_done = 1;
> -		ep->com.rpl_err = -ECONNRESET;
> -		pr_debug("waking up ep %p\n", ep);
> -		wake_up(&ep->com.waitq);
> -		break;
> -	case MPA_REP_SENT:
> -		__state_set(&ep->com, CLOSING);
> -		ep->com.rpl_done = 1;
> -		ep->com.rpl_err = -ECONNRESET;
> -		pr_debug("waking up ep %p\n", ep);
> -		wake_up(&ep->com.waitq);
> -		break;
> -	case FPDU_MODE:
> -		start_ep_timer(ep);
> -		__state_set(&ep->com, CLOSING);
> -		attrs.next_state = IWCH_QP_STATE_CLOSING;
> -		iwch_modify_qp(ep->com.qp->rhp, ep->com.qp,
> -			       IWCH_QP_ATTR_NEXT_STATE, &attrs, 1);
> -		peer_close_upcall(ep);
> -		break;
> -	case ABORTING:
> -		disconnect = 0;
> -		break;
> -	case CLOSING:
> -		__state_set(&ep->com, MORIBUND);
> -		disconnect = 0;
> -		break;
> -	case MORIBUND:
> -		stop_ep_timer(ep);
> -		if (ep->com.cm_id && ep->com.qp) {
> -			attrs.next_state = IWCH_QP_STATE_IDLE;
> -			iwch_modify_qp(ep->com.qp->rhp, ep->com.qp,
> -				       IWCH_QP_ATTR_NEXT_STATE, &attrs, 1);
> -		}
> -		close_complete_upcall(ep);
> -		__state_set(&ep->com, DEAD);
> -		release = 1;
> -		disconnect = 0;
> -		break;
> -	case DEAD:
> -		disconnect = 0;
> -		break;
> -	default:
> -		BUG_ON(1);
> -	}
> -	spin_unlock_irqrestore(&ep->com.lock, flags);
> -	if (disconnect)
> -		iwch_ep_disconnect(ep, 0, GFP_KERNEL);
> -	if (release)
> -		release_ep_resources(ep);
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -/*
> - * Returns whether an ABORT_REQ_RSS message is a negative advice.
> - */
> -static int is_neg_adv_abort(unsigned int status)
> -{
> -	return status == CPL_ERR_RTX_NEG_ADVICE ||
> -	       status == CPL_ERR_PERSIST_NEG_ADVICE;
> -}
> -
> -static int peer_abort(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct cpl_abort_req_rss *req = cplhdr(skb);
> -	struct iwch_ep *ep = ctx;
> -	struct cpl_abort_rpl *rpl;
> -	struct sk_buff *rpl_skb;
> -	struct iwch_qp_attributes attrs;
> -	int ret;
> -	int release = 0;
> -	unsigned long flags;
> -
> -	if (is_neg_adv_abort(req->status)) {
> -		pr_debug("%s neg_adv_abort ep %p tid %d\n", __func__, ep,
> -			 ep->hwtid);
> -		t3_l2t_send_event(ep->com.tdev, ep->l2t);
> -		return CPL_RET_BUF_DONE;
> -	}
> -
> -	/*
> -	 * We get 2 peer aborts from the HW.  The first one must
> -	 * be ignored except for scribbling that we need one more.
> -	 */
> -	if (!test_and_set_bit(PEER_ABORT_IN_PROGRESS, &ep->com.flags)) {
> -		return CPL_RET_BUF_DONE;
> -	}
> -
> -	spin_lock_irqsave(&ep->com.lock, flags);
> -	pr_debug("%s ep %p state %u\n", __func__, ep, ep->com.state);
> -	switch (ep->com.state) {
> -	case CONNECTING:
> -		break;
> -	case MPA_REQ_WAIT:
> -		stop_ep_timer(ep);
> -		break;
> -	case MPA_REQ_SENT:
> -		stop_ep_timer(ep);
> -		connect_reply_upcall(ep, -ECONNRESET);
> -		break;
> -	case MPA_REP_SENT:
> -		ep->com.rpl_done = 1;
> -		ep->com.rpl_err = -ECONNRESET;
> -		pr_debug("waking up ep %p\n", ep);
> -		wake_up(&ep->com.waitq);
> -		break;
> -	case MPA_REQ_RCVD:
> -
> -		/*
> -		 * We're gonna mark this puppy DEAD, but keep
> -		 * the reference on it until the ULP accepts or
> -		 * rejects the CR. Also wake up anyone waiting
> -		 * in rdma connection migration (see iwch_accept_cr()).
> -		 */
> -		ep->com.rpl_done = 1;
> -		ep->com.rpl_err = -ECONNRESET;
> -		pr_debug("waking up ep %p\n", ep);
> -		wake_up(&ep->com.waitq);
> -		break;
> -	case MORIBUND:
> -	case CLOSING:
> -		stop_ep_timer(ep);
> -		/*FALLTHROUGH*/
> -	case FPDU_MODE:
> -		if (ep->com.cm_id && ep->com.qp) {
> -			attrs.next_state = IWCH_QP_STATE_ERROR;
> -			ret = iwch_modify_qp(ep->com.qp->rhp,
> -				     ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
> -				     &attrs, 1);
> -			if (ret)
> -				pr_err("%s - qp <- error failed!\n", __func__);
> -		}
> -		peer_abort_upcall(ep);
> -		break;
> -	case ABORTING:
> -		break;
> -	case DEAD:
> -		pr_debug("%s PEER_ABORT IN DEAD STATE!!!!\n", __func__);
> -		spin_unlock_irqrestore(&ep->com.lock, flags);
> -		return CPL_RET_BUF_DONE;
> -	default:
> -		BUG_ON(1);
> -		break;
> -	}
> -	dst_confirm(ep->dst);
> -	if (ep->com.state != ABORTING) {
> -		__state_set(&ep->com, DEAD);
> -		release = 1;
> -	}
> -	spin_unlock_irqrestore(&ep->com.lock, flags);
> -
> -	rpl_skb = get_skb(skb, sizeof(*rpl), GFP_KERNEL);
> -	if (!rpl_skb) {
> -		pr_err("%s - cannot allocate skb!\n", __func__);
> -		release = 1;
> -		goto out;
> -	}
> -	rpl_skb->priority = CPL_PRIORITY_DATA;
> -	rpl = skb_put(rpl_skb, sizeof(*rpl));
> -	rpl->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_RPL));
> -	rpl->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
> -	OPCODE_TID(rpl) = htonl(MK_OPCODE_TID(CPL_ABORT_RPL, ep->hwtid));
> -	rpl->cmd = CPL_ABORT_NO_RST;
> -	iwch_cxgb3_ofld_send(ep->com.tdev, rpl_skb);
> -out:
> -	if (release)
> -		release_ep_resources(ep);
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static int close_con_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -	struct iwch_qp_attributes attrs;
> -	unsigned long flags;
> -	int release = 0;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	BUG_ON(!ep);
> -
> -	/* The cm_id may be null if we failed to connect */
> -	spin_lock_irqsave(&ep->com.lock, flags);
> -	switch (ep->com.state) {
> -	case CLOSING:
> -		__state_set(&ep->com, MORIBUND);
> -		break;
> -	case MORIBUND:
> -		stop_ep_timer(ep);
> -		if ((ep->com.cm_id) && (ep->com.qp)) {
> -			attrs.next_state = IWCH_QP_STATE_IDLE;
> -			iwch_modify_qp(ep->com.qp->rhp,
> -					     ep->com.qp,
> -					     IWCH_QP_ATTR_NEXT_STATE,
> -					     &attrs, 1);
> -		}
> -		close_complete_upcall(ep);
> -		__state_set(&ep->com, DEAD);
> -		release = 1;
> -		break;
> -	case ABORTING:
> -	case DEAD:
> -		break;
> -	default:
> -		BUG_ON(1);
> -		break;
> -	}
> -	spin_unlock_irqrestore(&ep->com.lock, flags);
> -	if (release)
> -		release_ep_resources(ep);
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -/*
> - * T3A does 3 things when a TERM is received:
> - * 1) send up a CPL_RDMA_TERMINATE message with the TERM packet
> - * 2) generate an async event on the QP with the TERMINATE opcode
> - * 3) post a TERMINATE opcode cqe into the associated CQ.
> - *
> - * For (1), we save the message in the qp for later consumer consumption.
> - * For (2), we move the QP into TERMINATE, post a QP event and disconnect.
> - * For (3), we toss the CQE in cxio_poll_cq().
> - *
> - * terminate() handles case (1)...
> - */
> -static int terminate(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep *ep = ctx;
> -
> -	if (state_read(&ep->com) != FPDU_MODE)
> -		return CPL_RET_BUF_DONE;
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	skb_pull(skb, sizeof(struct cpl_rdma_terminate));
> -	pr_debug("%s saving %d bytes of term msg\n", __func__, skb->len);
> -	skb_copy_from_linear_data(skb, ep->com.qp->attr.terminate_buffer,
> -				  skb->len);
> -	ep->com.qp->attr.terminate_msg_len = skb->len;
> -	ep->com.qp->attr.is_terminate_local = 0;
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static int ec_status(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct cpl_rdma_ec_status *rep = cplhdr(skb);
> -	struct iwch_ep *ep = ctx;
> -
> -	pr_debug("%s ep %p tid %u status %d\n", __func__, ep, ep->hwtid,
> -		 rep->status);
> -	if (rep->status) {
> -		struct iwch_qp_attributes attrs;
> -
> -		pr_err("%s BAD CLOSE - Aborting tid %u\n",
> -		       __func__, ep->hwtid);
> -		stop_ep_timer(ep);
> -		attrs.next_state = IWCH_QP_STATE_ERROR;
> -		iwch_modify_qp(ep->com.qp->rhp,
> -			       ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
> -			       &attrs, 1);
> -		abort_connection(ep, NULL, GFP_KERNEL);
> -	}
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -static void ep_timeout(struct timer_list *t)
> -{
> -	struct iwch_ep *ep = from_timer(ep, t, timer);
> -	struct iwch_qp_attributes attrs;
> -	unsigned long flags;
> -	int abort = 1;
> -
> -	spin_lock_irqsave(&ep->com.lock, flags);
> -	pr_debug("%s ep %p tid %u state %d\n", __func__, ep, ep->hwtid,
> -		 ep->com.state);
> -	switch (ep->com.state) {
> -	case MPA_REQ_SENT:
> -		__state_set(&ep->com, ABORTING);
> -		connect_reply_upcall(ep, -ETIMEDOUT);
> -		break;
> -	case MPA_REQ_WAIT:
> -		__state_set(&ep->com, ABORTING);
> -		break;
> -	case CLOSING:
> -	case MORIBUND:
> -		if (ep->com.cm_id && ep->com.qp) {
> -			attrs.next_state = IWCH_QP_STATE_ERROR;
> -			iwch_modify_qp(ep->com.qp->rhp,
> -				     ep->com.qp, IWCH_QP_ATTR_NEXT_STATE,
> -				     &attrs, 1);
> -		}
> -		__state_set(&ep->com, ABORTING);
> -		break;
> -	default:
> -		WARN(1, "%s unexpected state ep %p state %u\n",
> -			__func__, ep, ep->com.state);
> -		abort = 0;
> -	}
> -	spin_unlock_irqrestore(&ep->com.lock, flags);
> -	if (abort)
> -		abort_connection(ep, NULL, GFP_ATOMIC);
> -	put_ep(&ep->com);
> -}
> -
> -int iwch_reject_cr(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len)
> -{
> -	struct iwch_ep *ep = to_ep(cm_id);
> -
> -	pr_debug("%s ep %p tid %u\n", __func__, ep, ep->hwtid);
> -
> -	if (state_read(&ep->com) == DEAD) {
> -		put_ep(&ep->com);
> -		return -ECONNRESET;
> -	}
> -	BUG_ON(state_read(&ep->com) != MPA_REQ_RCVD);
> -	if (mpa_rev == 0)
> -		abort_connection(ep, NULL, GFP_KERNEL);
> -	else {
> -		send_mpa_reject(ep, pdata, pdata_len);
> -		iwch_ep_disconnect(ep, 0, GFP_KERNEL);
> -	}
> -	put_ep(&ep->com);
> -	return 0;
> -}
> -
> -int iwch_accept_cr(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
> -{
> -	int err;
> -	struct iwch_qp_attributes attrs;
> -	enum iwch_qp_attr_mask mask;
> -	struct iwch_ep *ep = to_ep(cm_id);
> -	struct iwch_dev *h = to_iwch_dev(cm_id->device);
> -	struct iwch_qp *qp = get_qhp(h, conn_param->qpn);
> -
> -	pr_debug("%s ep %p tid %u\n", __func__, ep, ep->hwtid);
> -	if (state_read(&ep->com) == DEAD) {
> -		err = -ECONNRESET;
> -		goto err;
> -	}
> -
> -	BUG_ON(state_read(&ep->com) != MPA_REQ_RCVD);
> -	BUG_ON(!qp);
> -
> -	if ((conn_param->ord > qp->rhp->attr.max_rdma_read_qp_depth) ||
> -	    (conn_param->ird > qp->rhp->attr.max_rdma_reads_per_qp)) {
> -		abort_connection(ep, NULL, GFP_KERNEL);
> -		err = -EINVAL;
> -		goto err;
> -	}
> -
> -	cm_id->add_ref(cm_id);
> -	ep->com.cm_id = cm_id;
> -	ep->com.qp = qp;
> -
> -	ep->ird = conn_param->ird;
> -	ep->ord = conn_param->ord;
> -
> -	if (peer2peer && ep->ird == 0)
> -		ep->ird = 1;
> -
> -	pr_debug("%s %d ird %d ord %d\n", __func__, __LINE__, ep->ird, ep->ord);
> -
> -	/* bind QP to EP and move to RTS */
> -	attrs.mpa_attr = ep->mpa_attr;
> -	attrs.max_ird = ep->ird;
> -	attrs.max_ord = ep->ord;
> -	attrs.llp_stream_handle = ep;
> -	attrs.next_state = IWCH_QP_STATE_RTS;
> -
> -	/* bind QP and TID with INIT_WR */
> -	mask = IWCH_QP_ATTR_NEXT_STATE |
> -			     IWCH_QP_ATTR_LLP_STREAM_HANDLE |
> -			     IWCH_QP_ATTR_MPA_ATTR |
> -			     IWCH_QP_ATTR_MAX_IRD |
> -			     IWCH_QP_ATTR_MAX_ORD;
> -
> -	err = iwch_modify_qp(ep->com.qp->rhp,
> -			     ep->com.qp, mask, &attrs, 1);
> -	if (err)
> -		goto err1;
> -
> -	/* if needed, wait for wr_ack */
> -	if (iwch_rqes_posted(qp)) {
> -		wait_event(ep->com.waitq, ep->com.rpl_done);
> -		err = ep->com.rpl_err;
> -		if (err)
> -			goto err1;
> -	}
> -
> -	err = send_mpa_reply(ep, conn_param->private_data,
> -			     conn_param->private_data_len);
> -	if (err)
> -		goto err1;
> -
> -
> -	state_set(&ep->com, FPDU_MODE);
> -	established_upcall(ep);
> -	put_ep(&ep->com);
> -	return 0;
> -err1:
> -	ep->com.cm_id = NULL;
> -	ep->com.qp = NULL;
> -	cm_id->rem_ref(cm_id);
> -err:
> -	put_ep(&ep->com);
> -	return err;
> -}
> -
> -static int is_loopback_dst(struct iw_cm_id *cm_id)
> -{
> -	struct net_device *dev;
> -	struct sockaddr_in *raddr = (struct sockaddr_in *)&cm_id->m_remote_addr;
> -
> -	dev = ip_dev_find(&init_net, raddr->sin_addr.s_addr);
> -	if (!dev)
> -		return 0;
> -	dev_put(dev);
> -	return 1;
> -}
> -
> -int iwch_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
> -{
> -	struct iwch_dev *h = to_iwch_dev(cm_id->device);
> -	struct iwch_ep *ep;
> -	struct rtable *rt;
> -	int err = 0;
> -	struct sockaddr_in *laddr = (struct sockaddr_in *)&cm_id->m_local_addr;
> -	struct sockaddr_in *raddr = (struct sockaddr_in *)&cm_id->m_remote_addr;
> -
> -	if (cm_id->m_remote_addr.ss_family != PF_INET) {
> -		err = -ENOSYS;
> -		goto out;
> -	}
> -
> -	if (is_loopback_dst(cm_id)) {
> -		err = -ENOSYS;
> -		goto out;
> -	}
> -
> -	ep = alloc_ep(sizeof(*ep), GFP_KERNEL);
> -	if (!ep) {
> -		pr_err("%s - cannot alloc ep\n", __func__);
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -	timer_setup(&ep->timer, ep_timeout, 0);
> -	ep->plen = conn_param->private_data_len;
> -	if (ep->plen)
> -		memcpy(ep->mpa_pkt + sizeof(struct mpa_message),
> -		       conn_param->private_data, ep->plen);
> -	ep->ird = conn_param->ird;
> -	ep->ord = conn_param->ord;
> -
> -	if (peer2peer && ep->ord == 0)
> -		ep->ord = 1;
> -
> -	ep->com.tdev = h->rdev.t3cdev_p;
> -
> -	cm_id->add_ref(cm_id);
> -	ep->com.cm_id = cm_id;
> -	ep->com.qp = get_qhp(h, conn_param->qpn);
> -	BUG_ON(!ep->com.qp);
> -	pr_debug("%s qpn 0x%x qp %p cm_id %p\n", __func__, conn_param->qpn,
> -		 ep->com.qp, cm_id);
> -
> -	/*
> -	 * Allocate an active TID to initiate a TCP connection.
> -	 */
> -	ep->atid = cxgb3_alloc_atid(h->rdev.t3cdev_p, &t3c_client, ep);
> -	if (ep->atid == -1) {
> -		pr_err("%s - cannot alloc atid\n", __func__);
> -		err = -ENOMEM;
> -		goto fail2;
> -	}
> -
> -	/* find a route */
> -	rt = find_route(h->rdev.t3cdev_p, laddr->sin_addr.s_addr,
> -			raddr->sin_addr.s_addr, laddr->sin_port,
> -			raddr->sin_port, IPTOS_LOWDELAY);
> -	if (!rt) {
> -		pr_err("%s - cannot find route\n", __func__);
> -		err = -EHOSTUNREACH;
> -		goto fail3;
> -	}
> -	ep->dst = &rt->dst;
> -	ep->l2t = t3_l2t_get(ep->com.tdev, ep->dst, NULL,
> -			     &raddr->sin_addr.s_addr);
> -	if (!ep->l2t) {
> -		pr_err("%s - cannot alloc l2e\n", __func__);
> -		err = -ENOMEM;
> -		goto fail4;
> -	}
> -
> -	state_set(&ep->com, CONNECTING);
> -	ep->tos = IPTOS_LOWDELAY;
> -	memcpy(&ep->com.local_addr, &cm_id->m_local_addr,
> -	       sizeof(ep->com.local_addr));
> -	memcpy(&ep->com.remote_addr, &cm_id->m_remote_addr,
> -	       sizeof(ep->com.remote_addr));
> -
> -	/* send connect request to rnic */
> -	err = send_connect(ep);
> -	if (!err)
> -		goto out;
> -
> -	l2t_release(h->rdev.t3cdev_p, ep->l2t);
> -fail4:
> -	dst_release(ep->dst);
> -fail3:
> -	cxgb3_free_atid(ep->com.tdev, ep->atid);
> -fail2:
> -	cm_id->rem_ref(cm_id);
> -	put_ep(&ep->com);
> -out:
> -	return err;
> -}
> -
> -int iwch_create_listen(struct iw_cm_id *cm_id, int backlog)
> -{
> -	int err = 0;
> -	struct iwch_dev *h = to_iwch_dev(cm_id->device);
> -	struct iwch_listen_ep *ep;
> -
> -
> -	might_sleep();
> -
> -	if (cm_id->m_local_addr.ss_family != PF_INET) {
> -		err = -ENOSYS;
> -		goto fail1;
> -	}
> -
> -	ep = alloc_ep(sizeof(*ep), GFP_KERNEL);
> -	if (!ep) {
> -		pr_err("%s - cannot alloc ep\n", __func__);
> -		err = -ENOMEM;
> -		goto fail1;
> -	}
> -	pr_debug("%s ep %p\n", __func__, ep);
> -	ep->com.tdev = h->rdev.t3cdev_p;
> -	cm_id->add_ref(cm_id);
> -	ep->com.cm_id = cm_id;
> -	ep->backlog = backlog;
> -	memcpy(&ep->com.local_addr, &cm_id->m_local_addr,
> -	       sizeof(ep->com.local_addr));
> -
> -	/*
> -	 * Allocate a server TID.
> -	 */
> -	ep->stid = cxgb3_alloc_stid(h->rdev.t3cdev_p, &t3c_client, ep);
> -	if (ep->stid == -1) {
> -		pr_err("%s - cannot alloc atid\n", __func__);
> -		err = -ENOMEM;
> -		goto fail2;
> -	}
> -
> -	state_set(&ep->com, LISTEN);
> -	err = listen_start(ep);
> -	if (err)
> -		goto fail3;
> -
> -	/* wait for pass_open_rpl */
> -	wait_event(ep->com.waitq, ep->com.rpl_done);
> -	err = ep->com.rpl_err;
> -	if (!err) {
> -		cm_id->provider_data = ep;
> -		goto out;
> -	}
> -fail3:
> -	cxgb3_free_stid(ep->com.tdev, ep->stid);
> -fail2:
> -	cm_id->rem_ref(cm_id);
> -	put_ep(&ep->com);
> -fail1:
> -out:
> -	return err;
> -}
> -
> -int iwch_destroy_listen(struct iw_cm_id *cm_id)
> -{
> -	int err;
> -	struct iwch_listen_ep *ep = to_listen_ep(cm_id);
> -
> -	pr_debug("%s ep %p\n", __func__, ep);
> -
> -	might_sleep();
> -	state_set(&ep->com, DEAD);
> -	ep->com.rpl_done = 0;
> -	ep->com.rpl_err = 0;
> -	err = listen_stop(ep);
> -	if (err)
> -		goto done;
> -	wait_event(ep->com.waitq, ep->com.rpl_done);
> -	cxgb3_free_stid(ep->com.tdev, ep->stid);
> -done:
> -	err = ep->com.rpl_err;
> -	cm_id->rem_ref(cm_id);
> -	put_ep(&ep->com);
> -	return err;
> -}
> -
> -int iwch_ep_disconnect(struct iwch_ep *ep, int abrupt, gfp_t gfp)
> -{
> -	int ret=0;
> -	unsigned long flags;
> -	int close = 0;
> -	int fatal = 0;
> -	struct t3cdev *tdev;
> -	struct cxio_rdev *rdev;
> -
> -	spin_lock_irqsave(&ep->com.lock, flags);
> -
> -	pr_debug("%s ep %p state %s, abrupt %d\n", __func__, ep,
> -		 states[ep->com.state], abrupt);
> -
> -	tdev = (struct t3cdev *)ep->com.tdev;
> -	rdev = (struct cxio_rdev *)tdev->ulp;
> -	if (cxio_fatal_error(rdev)) {
> -		fatal = 1;
> -		close_complete_upcall(ep);
> -		ep->com.state = DEAD;
> -	}
> -	switch (ep->com.state) {
> -	case MPA_REQ_WAIT:
> -	case MPA_REQ_SENT:
> -	case MPA_REQ_RCVD:
> -	case MPA_REP_SENT:
> -	case FPDU_MODE:
> -		close = 1;
> -		if (abrupt)
> -			ep->com.state = ABORTING;
> -		else {
> -			ep->com.state = CLOSING;
> -			start_ep_timer(ep);
> -		}
> -		set_bit(CLOSE_SENT, &ep->com.flags);
> -		break;
> -	case CLOSING:
> -		if (!test_and_set_bit(CLOSE_SENT, &ep->com.flags)) {
> -			close = 1;
> -			if (abrupt) {
> -				stop_ep_timer(ep);
> -				ep->com.state = ABORTING;
> -			} else
> -				ep->com.state = MORIBUND;
> -		}
> -		break;
> -	case MORIBUND:
> -	case ABORTING:
> -	case DEAD:
> -		pr_debug("%s ignoring disconnect ep %p state %u\n",
> -			 __func__, ep, ep->com.state);
> -		break;
> -	default:
> -		BUG();
> -		break;
> -	}
> -
> -	spin_unlock_irqrestore(&ep->com.lock, flags);
> -	if (close) {
> -		if (abrupt)
> -			ret = send_abort(ep, NULL, gfp);
> -		else
> -			ret = send_halfclose(ep, gfp);
> -		if (ret)
> -			fatal = 1;
> -	}
> -	if (fatal)
> -		release_ep_resources(ep);
> -	return ret;
> -}
> -
> -int iwch_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new,
> -		     struct l2t_entry *l2t)
> -{
> -	struct iwch_ep *ep = ctx;
> -
> -	if (ep->dst != old)
> -		return 0;
> -
> -	pr_debug("%s ep %p redirect to dst %p l2t %p\n", __func__, ep, new,
> -		 l2t);
> -	dst_hold(new);
> -	l2t_release(ep->com.tdev, ep->l2t);
> -	ep->l2t = l2t;
> -	dst_release(old);
> -	ep->dst = new;
> -	return 1;
> -}
> -
> -/*
> - * All the CM events are handled on a work queue to have a safe context.
> - * These are the real handlers that are called from the work queue.
> - */
> -static const cxgb3_cpl_handler_func work_handlers[NUM_CPL_CMDS] = {
> -	[CPL_ACT_ESTABLISH]	= act_establish,
> -	[CPL_ACT_OPEN_RPL]	= act_open_rpl,
> -	[CPL_RX_DATA]		= rx_data,
> -	[CPL_TX_DMA_ACK]	= tx_ack,
> -	[CPL_ABORT_RPL_RSS]	= abort_rpl,
> -	[CPL_ABORT_RPL]		= abort_rpl,
> -	[CPL_PASS_OPEN_RPL]	= pass_open_rpl,
> -	[CPL_CLOSE_LISTSRV_RPL]	= close_listsrv_rpl,
> -	[CPL_PASS_ACCEPT_REQ]	= pass_accept_req,
> -	[CPL_PASS_ESTABLISH]	= pass_establish,
> -	[CPL_PEER_CLOSE]	= peer_close,
> -	[CPL_ABORT_REQ_RSS]	= peer_abort,
> -	[CPL_CLOSE_CON_RPL]	= close_con_rpl,
> -	[CPL_RDMA_TERMINATE]	= terminate,
> -	[CPL_RDMA_EC_STATUS]	= ec_status,
> -};
> -
> -static void process_work(struct work_struct *work)
> -{
> -	struct sk_buff *skb = NULL;
> -	void *ep;
> -	struct t3cdev *tdev;
> -	int ret;
> -
> -	while ((skb = skb_dequeue(&rxq))) {
> -		ep = *((void **) (skb->cb));
> -		tdev = *((struct t3cdev **) (skb->cb + sizeof(void *)));
> -		ret = work_handlers[G_OPCODE(ntohl((__force __be32)skb->csum))](tdev, skb, ep);
> -		if (ret & CPL_RET_BUF_DONE)
> -			kfree_skb(skb);
> -
> -		/*
> -		 * ep was referenced in sched(), and is freed here.
> -		 */
> -		put_ep((struct iwch_ep_common *)ep);
> -	}
> -}
> -
> -static DECLARE_WORK(skb_work, process_work);
> -
> -static int sched(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct iwch_ep_common *epc = ctx;
> -
> -	get_ep(epc);
> -
> -	/*
> -	 * Save ctx and tdev in the skb->cb area.
> -	 */
> -	*((void **) skb->cb) = ctx;
> -	*((struct t3cdev **) (skb->cb + sizeof(void *))) = tdev;
> -
> -	/*
> -	 * Queue the skb and schedule the worker thread.
> -	 */
> -	skb_queue_tail(&rxq, skb);
> -	queue_work(workq, &skb_work);
> -	return 0;
> -}
> -
> -static int set_tcb_rpl(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> -{
> -	struct cpl_set_tcb_rpl *rpl = cplhdr(skb);
> -
> -	if (rpl->status != CPL_ERR_NONE) {
> -		pr_err("Unexpected SET_TCB_RPL status %u for tid %u\n",
> -		       rpl->status, GET_TID(rpl));
> -	}
> -	return CPL_RET_BUF_DONE;
> -}
> -
> -/*
> - * All upcalls from the T3 Core go to sched() to schedule the
> - * processing on a work queue.
> - */
> -cxgb3_cpl_handler_func t3c_handlers[NUM_CPL_CMDS] = {
> -	[CPL_ACT_ESTABLISH]	= sched,
> -	[CPL_ACT_OPEN_RPL]	= sched,
> -	[CPL_RX_DATA]		= sched,
> -	[CPL_TX_DMA_ACK]	= sched,
> -	[CPL_ABORT_RPL_RSS]	= sched,
> -	[CPL_ABORT_RPL]		= sched,
> -	[CPL_PASS_OPEN_RPL]	= sched,
> -	[CPL_CLOSE_LISTSRV_RPL]	= sched,
> -	[CPL_PASS_ACCEPT_REQ]	= sched,
> -	[CPL_PASS_ESTABLISH]	= sched,
> -	[CPL_PEER_CLOSE]	= sched,
> -	[CPL_CLOSE_CON_RPL]	= sched,
> -	[CPL_ABORT_REQ_RSS]	= sched,
> -	[CPL_RDMA_TERMINATE]	= sched,
> -	[CPL_RDMA_EC_STATUS]	= sched,
> -	[CPL_SET_TCB_RPL]	= set_tcb_rpl,
> -};
> -
> -int __init iwch_cm_init(void)
> -{
> -	skb_queue_head_init(&rxq);
> -
> -	workq = alloc_ordered_workqueue("iw_cxgb3", WQ_MEM_RECLAIM);
> -	if (!workq)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -void __exit iwch_cm_term(void)
> -{
> -	flush_workqueue(workq);
> -	destroy_workqueue(workq);
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.h b/drivers/infiniband/hw/cxgb3/iwch_cm.h
> deleted file mode 100644
> index cc7fe644d260..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_cm.h
> +++ /dev/null
> @@ -1,233 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef _IWCH_CM_H_
> -#define _IWCH_CM_H_
> -
> -#include <linux/inet.h>
> -#include <linux/wait.h>
> -#include <linux/spinlock.h>
> -#include <linux/kref.h>
> -
> -#include <rdma/ib_verbs.h>
> -#include <rdma/iw_cm.h>
> -
> -#include "cxgb3_offload.h"
> -#include "iwch_provider.h"
> -
> -#define MPA_KEY_REQ "MPA ID Req Frame"
> -#define MPA_KEY_REP "MPA ID Rep Frame"
> -
> -#define MPA_MAX_PRIVATE_DATA	256
> -#define MPA_REV		0	/* XXX - amso1100 uses rev 0 ! */
> -#define MPA_REJECT		0x20
> -#define MPA_CRC			0x40
> -#define MPA_MARKERS		0x80
> -#define MPA_FLAGS_MASK		0xE0
> -
> -#define put_ep(ep) {							\
> -	pr_debug("put_ep (via %s:%u) ep %p refcnt %d\n",		\
> -		 __func__, __LINE__, ep, kref_read(&((ep)->kref)));	\
> -	WARN_ON(kref_read(&((ep)->kref)) < 1);				\
> -	kref_put(&((ep)->kref), __free_ep);				\
> -}
> -
> -#define get_ep(ep) {							\
> -	pr_debug("get_ep (via %s:%u) ep %p, refcnt %d\n",		\
> -		 __func__, __LINE__, ep, kref_read(&((ep)->kref)));	\
> -	kref_get(&((ep)->kref));					\
> -}
> -
> -struct mpa_message {
> -	u8 key[16];
> -	u8 flags;
> -	u8 revision;
> -	__be16 private_data_size;
> -	u8 private_data[0];
> -};
> -
> -struct terminate_message {
> -	u8 layer_etype;
> -	u8 ecode;
> -	__be16 hdrct_rsvd;
> -	u8 len_hdrs[0];
> -};
> -
> -#define TERM_MAX_LENGTH (sizeof(struct terminate_message) + 2 + 18 + 28)
> -
> -enum iwch_layers_types {
> -	LAYER_RDMAP		= 0x00,
> -	LAYER_DDP		= 0x10,
> -	LAYER_MPA		= 0x20,
> -	RDMAP_LOCAL_CATA	= 0x00,
> -	RDMAP_REMOTE_PROT	= 0x01,
> -	RDMAP_REMOTE_OP		= 0x02,
> -	DDP_LOCAL_CATA		= 0x00,
> -	DDP_TAGGED_ERR		= 0x01,
> -	DDP_UNTAGGED_ERR	= 0x02,
> -	DDP_LLP			= 0x03
> -};
> -
> -enum iwch_rdma_ecodes {
> -	RDMAP_INV_STAG		= 0x00,
> -	RDMAP_BASE_BOUNDS	= 0x01,
> -	RDMAP_ACC_VIOL		= 0x02,
> -	RDMAP_STAG_NOT_ASSOC	= 0x03,
> -	RDMAP_TO_WRAP		= 0x04,
> -	RDMAP_INV_VERS		= 0x05,
> -	RDMAP_INV_OPCODE	= 0x06,
> -	RDMAP_STREAM_CATA	= 0x07,
> -	RDMAP_GLOBAL_CATA	= 0x08,
> -	RDMAP_CANT_INV_STAG	= 0x09,
> -	RDMAP_UNSPECIFIED	= 0xff
> -};
> -
> -enum iwch_ddp_ecodes {
> -	DDPT_INV_STAG		= 0x00,
> -	DDPT_BASE_BOUNDS	= 0x01,
> -	DDPT_STAG_NOT_ASSOC	= 0x02,
> -	DDPT_TO_WRAP		= 0x03,
> -	DDPT_INV_VERS		= 0x04,
> -	DDPU_INV_QN		= 0x01,
> -	DDPU_INV_MSN_NOBUF	= 0x02,
> -	DDPU_INV_MSN_RANGE	= 0x03,
> -	DDPU_INV_MO		= 0x04,
> -	DDPU_MSG_TOOBIG		= 0x05,
> -	DDPU_INV_VERS		= 0x06
> -};
> -
> -enum iwch_mpa_ecodes {
> -	MPA_CRC_ERR		= 0x02,
> -	MPA_MARKER_ERR		= 0x03
> -};
> -
> -enum iwch_ep_state {
> -	IDLE = 0,
> -	LISTEN,
> -	CONNECTING,
> -	MPA_REQ_WAIT,
> -	MPA_REQ_SENT,
> -	MPA_REQ_RCVD,
> -	MPA_REP_SENT,
> -	FPDU_MODE,
> -	ABORTING,
> -	CLOSING,
> -	MORIBUND,
> -	DEAD,
> -};
> -
> -enum iwch_ep_flags {
> -	PEER_ABORT_IN_PROGRESS	= 0,
> -	ABORT_REQ_IN_PROGRESS	= 1,
> -	RELEASE_RESOURCES	= 2,
> -	CLOSE_SENT		= 3,
> -};
> -
> -struct iwch_ep_common {
> -	struct iw_cm_id *cm_id;
> -	struct iwch_qp *qp;
> -	struct t3cdev *tdev;
> -	enum iwch_ep_state state;
> -	struct kref kref;
> -	spinlock_t lock;
> -	struct sockaddr_in local_addr;
> -	struct sockaddr_in remote_addr;
> -	wait_queue_head_t waitq;
> -	int rpl_done;
> -	int rpl_err;
> -	unsigned long flags;
> -};
> -
> -struct iwch_listen_ep {
> -	struct iwch_ep_common com;
> -	unsigned int stid;
> -	int backlog;
> -};
> -
> -struct iwch_ep {
> -	struct iwch_ep_common com;
> -	struct iwch_ep *parent_ep;
> -	struct timer_list timer;
> -	unsigned int atid;
> -	u32 hwtid;
> -	u32 snd_seq;
> -	u32 rcv_seq;
> -	struct l2t_entry *l2t;
> -	struct dst_entry *dst;
> -	struct sk_buff *mpa_skb;
> -	struct iwch_mpa_attributes mpa_attr;
> -	unsigned int mpa_pkt_len;
> -	u8 mpa_pkt[sizeof(struct mpa_message) + MPA_MAX_PRIVATE_DATA];
> -	u8 tos;
> -	u16 emss;
> -	u16 plen;
> -	u32 ird;
> -	u32 ord;
> -};
> -
> -static inline struct iwch_ep *to_ep(struct iw_cm_id *cm_id)
> -{
> -	return cm_id->provider_data;
> -}
> -
> -static inline struct iwch_listen_ep *to_listen_ep(struct iw_cm_id *cm_id)
> -{
> -	return cm_id->provider_data;
> -}
> -
> -static inline int compute_wscale(int win)
> -{
> -	int wscale = 0;
> -
> -	while (wscale < 14 && (65535<<wscale) < win)
> -		wscale++;
> -	return wscale;
> -}
> -
> -/* CM prototypes */
> -
> -int iwch_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
> -int iwch_create_listen(struct iw_cm_id *cm_id, int backlog);
> -int iwch_destroy_listen(struct iw_cm_id *cm_id);
> -int iwch_reject_cr(struct iw_cm_id *cm_id, const void *pdata, u8 pdata_len);
> -int iwch_accept_cr(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param);
> -int iwch_ep_disconnect(struct iwch_ep *ep, int abrupt, gfp_t gfp);
> -int iwch_quiesce_tid(struct iwch_ep *ep);
> -int iwch_resume_tid(struct iwch_ep *ep);
> -void __free_ep(struct kref *kref);
> -void iwch_rearp(struct iwch_ep *ep);
> -int iwch_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new, struct l2t_entry *l2t);
> -
> -int __init iwch_cm_init(void);
> -void __exit iwch_cm_term(void);
> -extern int peer2peer;
> -
> -#endif				/* _IWCH_CM_H_ */
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_cq.c b/drivers/infiniband/hw/cxgb3/iwch_cq.c
> deleted file mode 100644
> index a098c0140580..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_cq.c
> +++ /dev/null
> @@ -1,230 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include "iwch_provider.h"
> -#include "iwch.h"
> -
> -static int __iwch_poll_cq_one(struct iwch_dev *rhp, struct iwch_cq *chp,
> -			      struct iwch_qp *qhp, struct ib_wc *wc)
> -{
> -	struct t3_wq *wq = qhp ? &qhp->wq : NULL;
> -	struct t3_cqe cqe;
> -	u32 credit = 0;
> -	u8 cqe_flushed;
> -	u64 cookie;
> -	int ret = 1;
> -
> -	ret = cxio_poll_cq(wq, &(chp->cq), &cqe, &cqe_flushed, &cookie,
> -				   &credit);
> -	if (t3a_device(chp->rhp) && credit) {
> -		pr_debug("%s updating %d cq credits on id %d\n", __func__,
> -			 credit, chp->cq.cqid);
> -		cxio_hal_cq_op(&rhp->rdev, &chp->cq, CQ_CREDIT_UPDATE, credit);
> -	}
> -
> -	if (ret) {
> -		ret = -EAGAIN;
> -		goto out;
> -	}
> -	ret = 1;
> -
> -	wc->wr_id = cookie;
> -	wc->qp = qhp ? &qhp->ibqp : NULL;
> -	wc->vendor_err = CQE_STATUS(cqe);
> -	wc->wc_flags = 0;
> -
> -	pr_debug("%s qpid 0x%x type %d opcode %d status 0x%x wrid hi 0x%x lo 0x%x cookie 0x%llx\n",
> -		 __func__,
> -		 CQE_QPID(cqe), CQE_TYPE(cqe),
> -		 CQE_OPCODE(cqe), CQE_STATUS(cqe), CQE_WRID_HI(cqe),
> -		 CQE_WRID_LOW(cqe), (unsigned long long)cookie);
> -
> -	if (CQE_TYPE(cqe) == 0) {
> -		if (!CQE_STATUS(cqe))
> -			wc->byte_len = CQE_LEN(cqe);
> -		else
> -			wc->byte_len = 0;
> -		wc->opcode = IB_WC_RECV;
> -		if (CQE_OPCODE(cqe) == T3_SEND_WITH_INV ||
> -		    CQE_OPCODE(cqe) == T3_SEND_WITH_SE_INV) {
> -			wc->ex.invalidate_rkey = CQE_WRID_STAG(cqe);
> -			wc->wc_flags |= IB_WC_WITH_INVALIDATE;
> -		}
> -	} else {
> -		switch (CQE_OPCODE(cqe)) {
> -		case T3_RDMA_WRITE:
> -			wc->opcode = IB_WC_RDMA_WRITE;
> -			break;
> -		case T3_READ_REQ:
> -			wc->opcode = IB_WC_RDMA_READ;
> -			wc->byte_len = CQE_LEN(cqe);
> -			break;
> -		case T3_SEND:
> -		case T3_SEND_WITH_SE:
> -		case T3_SEND_WITH_INV:
> -		case T3_SEND_WITH_SE_INV:
> -			wc->opcode = IB_WC_SEND;
> -			break;
> -		case T3_LOCAL_INV:
> -			wc->opcode = IB_WC_LOCAL_INV;
> -			break;
> -		case T3_FAST_REGISTER:
> -			wc->opcode = IB_WC_REG_MR;
> -			break;
> -		default:
> -			pr_err("Unexpected opcode %d in the CQE received for QPID=0x%0x\n",
> -			       CQE_OPCODE(cqe), CQE_QPID(cqe));
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -	}
> -
> -	if (cqe_flushed)
> -		wc->status = IB_WC_WR_FLUSH_ERR;
> -	else {
> -
> -		switch (CQE_STATUS(cqe)) {
> -		case TPT_ERR_SUCCESS:
> -			wc->status = IB_WC_SUCCESS;
> -			break;
> -		case TPT_ERR_STAG:
> -			wc->status = IB_WC_LOC_ACCESS_ERR;
> -			break;
> -		case TPT_ERR_PDID:
> -			wc->status = IB_WC_LOC_PROT_ERR;
> -			break;
> -		case TPT_ERR_QPID:
> -		case TPT_ERR_ACCESS:
> -			wc->status = IB_WC_LOC_ACCESS_ERR;
> -			break;
> -		case TPT_ERR_WRAP:
> -			wc->status = IB_WC_GENERAL_ERR;
> -			break;
> -		case TPT_ERR_BOUND:
> -			wc->status = IB_WC_LOC_LEN_ERR;
> -			break;
> -		case TPT_ERR_INVALIDATE_SHARED_MR:
> -		case TPT_ERR_INVALIDATE_MR_WITH_MW_BOUND:
> -			wc->status = IB_WC_MW_BIND_ERR;
> -			break;
> -		case TPT_ERR_CRC:
> -		case TPT_ERR_MARKER:
> -		case TPT_ERR_PDU_LEN_ERR:
> -		case TPT_ERR_OUT_OF_RQE:
> -		case TPT_ERR_DDP_VERSION:
> -		case TPT_ERR_RDMA_VERSION:
> -		case TPT_ERR_DDP_QUEUE_NUM:
> -		case TPT_ERR_MSN:
> -		case TPT_ERR_TBIT:
> -		case TPT_ERR_MO:
> -		case TPT_ERR_MSN_RANGE:
> -		case TPT_ERR_IRD_OVERFLOW:
> -		case TPT_ERR_OPCODE:
> -			wc->status = IB_WC_FATAL_ERR;
> -			break;
> -		case TPT_ERR_SWFLUSH:
> -			wc->status = IB_WC_WR_FLUSH_ERR;
> -			break;
> -		default:
> -			pr_err("Unexpected cqe_status 0x%x for QPID=0x%0x\n",
> -			       CQE_STATUS(cqe), CQE_QPID(cqe));
> -			ret = -EINVAL;
> -		}
> -	}
> -out:
> -	return ret;
> -}
> -
> -/*
> - * Get one cq entry from cxio and map it to openib.
> - *
> - * Returns:
> - *	0			EMPTY;
> - *	1			cqe returned
> - *	-EAGAIN		caller must try again
> - *	any other -errno	fatal error
> - */
> -static int iwch_poll_cq_one(struct iwch_dev *rhp, struct iwch_cq *chp,
> -			    struct ib_wc *wc)
> -{
> -	struct iwch_qp *qhp;
> -	struct t3_cqe *rd_cqe;
> -	int ret;
> -
> -	rd_cqe = cxio_next_cqe(&chp->cq);
> -
> -	if (!rd_cqe)
> -		return 0;
> -
> -	qhp = get_qhp(rhp, CQE_QPID(*rd_cqe));
> -	if (qhp) {
> -		spin_lock(&qhp->lock);
> -		ret = __iwch_poll_cq_one(rhp, chp, qhp, wc);
> -		spin_unlock(&qhp->lock);
> -	} else {
> -		ret = __iwch_poll_cq_one(rhp, chp, NULL, wc);
> -	}
> -	return ret;
> -}
> -
> -int iwch_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_cq *chp;
> -	unsigned long flags;
> -	int npolled;
> -	int err = 0;
> -
> -	chp = to_iwch_cq(ibcq);
> -	rhp = chp->rhp;
> -
> -	spin_lock_irqsave(&chp->lock, flags);
> -	for (npolled = 0; npolled < num_entries; ++npolled) {
> -
> -		/*
> -		 * Because T3 can post CQEs that are _not_ associated
> -		 * with a WR, we might have to poll again after removing
> -		 * one of these.
> -		 */
> -		do {
> -			err = iwch_poll_cq_one(rhp, chp, wc + npolled);
> -		} while (err == -EAGAIN);
> -		if (err <= 0)
> -			break;
> -	}
> -	spin_unlock_irqrestore(&chp->lock, flags);
> -
> -	if (err < 0)
> -		return err;
> -	else {
> -		return npolled;
> -	}
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_ev.c b/drivers/infiniband/hw/cxgb3/iwch_ev.c
> deleted file mode 100644
> index 9d356c1301c7..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_ev.c
> +++ /dev/null
> @@ -1,232 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include <linux/gfp.h>
> -#include <linux/mman.h>
> -#include <net/sock.h>
> -#include "iwch_provider.h"
> -#include "iwch.h"
> -#include "iwch_cm.h"
> -#include "cxio_hal.h"
> -#include "cxio_wr.h"
> -
> -static void post_qp_event(struct iwch_dev *rnicp, struct iwch_cq *chp,
> -			  struct respQ_msg_t *rsp_msg,
> -			  enum ib_event_type ib_event,
> -			  int send_term)
> -{
> -	struct ib_event event;
> -	struct iwch_qp_attributes attrs;
> -	struct iwch_qp *qhp;
> -	unsigned long flag;
> -
> -	xa_lock(&rnicp->qps);
> -	qhp = xa_load(&rnicp->qps, CQE_QPID(rsp_msg->cqe));
> -
> -	if (!qhp) {
> -		pr_err("%s unaffiliated error 0x%x qpid 0x%x\n",
> -		       __func__, CQE_STATUS(rsp_msg->cqe),
> -		       CQE_QPID(rsp_msg->cqe));
> -		xa_unlock(&rnicp->qps);
> -		return;
> -	}
> -
> -	if ((qhp->attr.state == IWCH_QP_STATE_ERROR) ||
> -	    (qhp->attr.state == IWCH_QP_STATE_TERMINATE)) {
> -		pr_debug("%s AE received after RTS - qp state %d qpid 0x%x status 0x%x\n",
> -			 __func__,
> -			 qhp->attr.state, qhp->wq.qpid,
> -			 CQE_STATUS(rsp_msg->cqe));
> -		xa_unlock(&rnicp->qps);
> -		return;
> -	}
> -
> -	pr_err("%s - AE qpid 0x%x opcode %d status 0x%x type %d wrid.hi 0x%x wrid.lo 0x%x\n",
> -	       __func__,
> -	       CQE_QPID(rsp_msg->cqe), CQE_OPCODE(rsp_msg->cqe),
> -	       CQE_STATUS(rsp_msg->cqe), CQE_TYPE(rsp_msg->cqe),
> -	       CQE_WRID_HI(rsp_msg->cqe), CQE_WRID_LOW(rsp_msg->cqe));
> -
> -	atomic_inc(&qhp->refcnt);
> -	xa_unlock(&rnicp->qps);
> -
> -	if (qhp->attr.state == IWCH_QP_STATE_RTS) {
> -		attrs.next_state = IWCH_QP_STATE_TERMINATE;
> -		iwch_modify_qp(qhp->rhp, qhp, IWCH_QP_ATTR_NEXT_STATE,
> -			       &attrs, 1);
> -		if (send_term)
> -			iwch_post_terminate(qhp, rsp_msg);
> -	}
> -
> -	event.event = ib_event;
> -	event.device = chp->ibcq.device;
> -	if (ib_event == IB_EVENT_CQ_ERR)
> -		event.element.cq = &chp->ibcq;
> -	else
> -		event.element.qp = &qhp->ibqp;
> -
> -	if (qhp->ibqp.event_handler)
> -		(*qhp->ibqp.event_handler)(&event, qhp->ibqp.qp_context);
> -
> -	spin_lock_irqsave(&chp->comp_handler_lock, flag);
> -	(*chp->ibcq.comp_handler)(&chp->ibcq, chp->ibcq.cq_context);
> -	spin_unlock_irqrestore(&chp->comp_handler_lock, flag);
> -
> -	if (atomic_dec_and_test(&qhp->refcnt))
> -		wake_up(&qhp->wait);
> -}
> -
> -void iwch_ev_dispatch(struct cxio_rdev *rdev_p, struct sk_buff *skb)
> -{
> -	struct iwch_dev *rnicp;
> -	struct respQ_msg_t *rsp_msg = (struct respQ_msg_t *) skb->data;
> -	struct iwch_cq *chp;
> -	struct iwch_qp *qhp;
> -	u32 cqid = RSPQ_CQID(rsp_msg);
> -	unsigned long flag;
> -
> -	rnicp = (struct iwch_dev *) rdev_p->ulp;
> -	xa_lock(&rnicp->qps);
> -	chp = get_chp(rnicp, cqid);
> -	qhp = xa_load(&rnicp->qps, CQE_QPID(rsp_msg->cqe));
> -	if (!chp || !qhp) {
> -		pr_err("BAD AE cqid 0x%x qpid 0x%x opcode %d status 0x%x type %d wrid.hi 0x%x wrid.lo 0x%x\n",
> -		       cqid, CQE_QPID(rsp_msg->cqe),
> -		       CQE_OPCODE(rsp_msg->cqe), CQE_STATUS(rsp_msg->cqe),
> -		       CQE_TYPE(rsp_msg->cqe), CQE_WRID_HI(rsp_msg->cqe),
> -		       CQE_WRID_LOW(rsp_msg->cqe));
> -		xa_unlock(&rnicp->qps);
> -		goto out;
> -	}
> -	iwch_qp_add_ref(&qhp->ibqp);
> -	atomic_inc(&chp->refcnt);
> -	xa_unlock(&rnicp->qps);
> -
> -	/*
> -	 * 1) completion of our sending a TERMINATE.
> -	 * 2) incoming TERMINATE message.
> -	 */
> -	if ((CQE_OPCODE(rsp_msg->cqe) == T3_TERMINATE) &&
> -	    (CQE_STATUS(rsp_msg->cqe) == 0)) {
> -		if (SQ_TYPE(rsp_msg->cqe)) {
> -			pr_debug("%s QPID 0x%x ep %p disconnecting\n",
> -				 __func__, qhp->wq.qpid, qhp->ep);
> -			iwch_ep_disconnect(qhp->ep, 0, GFP_ATOMIC);
> -		} else {
> -			pr_debug("%s post REQ_ERR AE QPID 0x%x\n", __func__,
> -				 qhp->wq.qpid);
> -			post_qp_event(rnicp, chp, rsp_msg,
> -				      IB_EVENT_QP_REQ_ERR, 0);
> -			iwch_ep_disconnect(qhp->ep, 0, GFP_ATOMIC);
> -		}
> -		goto done;
> -	}
> -
> -	/* Bad incoming Read request */
> -	if (SQ_TYPE(rsp_msg->cqe) &&
> -	    (CQE_OPCODE(rsp_msg->cqe) == T3_READ_RESP)) {
> -		post_qp_event(rnicp, chp, rsp_msg, IB_EVENT_QP_REQ_ERR, 1);
> -		goto done;
> -	}
> -
> -	/* Bad incoming write */
> -	if (RQ_TYPE(rsp_msg->cqe) &&
> -	    (CQE_OPCODE(rsp_msg->cqe) == T3_RDMA_WRITE)) {
> -		post_qp_event(rnicp, chp, rsp_msg, IB_EVENT_QP_REQ_ERR, 1);
> -		goto done;
> -	}
> -
> -	switch (CQE_STATUS(rsp_msg->cqe)) {
> -
> -	/* Completion Events */
> -	case TPT_ERR_SUCCESS:
> -
> -		/*
> -		 * Confirm the destination entry if this is a RECV completion.
> -		 */
> -		if (qhp->ep && SQ_TYPE(rsp_msg->cqe))
> -			dst_confirm(qhp->ep->dst);
> -		spin_lock_irqsave(&chp->comp_handler_lock, flag);
> -		(*chp->ibcq.comp_handler)(&chp->ibcq, chp->ibcq.cq_context);
> -		spin_unlock_irqrestore(&chp->comp_handler_lock, flag);
> -		break;
> -
> -	case TPT_ERR_STAG:
> -	case TPT_ERR_PDID:
> -	case TPT_ERR_QPID:
> -	case TPT_ERR_ACCESS:
> -	case TPT_ERR_WRAP:
> -	case TPT_ERR_BOUND:
> -	case TPT_ERR_INVALIDATE_SHARED_MR:
> -	case TPT_ERR_INVALIDATE_MR_WITH_MW_BOUND:
> -		post_qp_event(rnicp, chp, rsp_msg, IB_EVENT_QP_ACCESS_ERR, 1);
> -		break;
> -
> -	/* Device Fatal Errors */
> -	case TPT_ERR_ECC:
> -	case TPT_ERR_ECC_PSTAG:
> -	case TPT_ERR_INTERNAL_ERR:
> -		post_qp_event(rnicp, chp, rsp_msg, IB_EVENT_DEVICE_FATAL, 1);
> -		break;
> -
> -	/* QP Fatal Errors */
> -	case TPT_ERR_OUT_OF_RQE:
> -	case TPT_ERR_PBL_ADDR_BOUND:
> -	case TPT_ERR_CRC:
> -	case TPT_ERR_MARKER:
> -	case TPT_ERR_PDU_LEN_ERR:
> -	case TPT_ERR_DDP_VERSION:
> -	case TPT_ERR_RDMA_VERSION:
> -	case TPT_ERR_OPCODE:
> -	case TPT_ERR_DDP_QUEUE_NUM:
> -	case TPT_ERR_MSN:
> -	case TPT_ERR_TBIT:
> -	case TPT_ERR_MO:
> -	case TPT_ERR_MSN_GAP:
> -	case TPT_ERR_MSN_RANGE:
> -	case TPT_ERR_RQE_ADDR_BOUND:
> -	case TPT_ERR_IRD_OVERFLOW:
> -		post_qp_event(rnicp, chp, rsp_msg, IB_EVENT_QP_FATAL, 1);
> -		break;
> -
> -	default:
> -		pr_err("Unknown T3 status 0x%x QPID 0x%x\n",
> -		       CQE_STATUS(rsp_msg->cqe), qhp->wq.qpid);
> -		post_qp_event(rnicp, chp, rsp_msg, IB_EVENT_QP_FATAL, 1);
> -		break;
> -	}
> -done:
> -	if (atomic_dec_and_test(&chp->refcnt))
> -	        wake_up(&chp->wait);
> -	iwch_qp_rem_ref(&qhp->ibqp);
> -out:
> -	dev_kfree_skb_irq(skb);
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_mem.c b/drivers/infiniband/hw/cxgb3/iwch_mem.c
> deleted file mode 100644
> index ce0f2741821d..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_mem.c
> +++ /dev/null
> @@ -1,101 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include <linux/slab.h>
> -#include <asm/byteorder.h>
> -
> -#include <rdma/iw_cm.h>
> -#include <rdma/ib_verbs.h>
> -
> -#include "cxio_hal.h"
> -#include "cxio_resource.h"
> -#include "iwch.h"
> -#include "iwch_provider.h"
> -
> -static int iwch_finish_mem_reg(struct iwch_mr *mhp, u32 stag)
> -{
> -	u32 mmid;
> -
> -	mhp->attr.state = 1;
> -	mhp->attr.stag = stag;
> -	mmid = stag >> 8;
> -	mhp->ibmr.rkey = mhp->ibmr.lkey = stag;
> -	pr_debug("%s mmid 0x%x mhp %p\n", __func__, mmid, mhp);
> -	return xa_insert_irq(&mhp->rhp->mrs, mmid, mhp, GFP_KERNEL);
> -}
> -
> -int iwch_register_mem(struct iwch_dev *rhp, struct iwch_pd *php,
> -		      struct iwch_mr *mhp, int shift)
> -{
> -	u32 stag;
> -	int ret;
> -
> -	if (cxio_register_phys_mem(&rhp->rdev,
> -				   &stag, mhp->attr.pdid,
> -				   mhp->attr.perms,
> -				   mhp->attr.zbva,
> -				   mhp->attr.va_fbo,
> -				   mhp->attr.len,
> -				   shift - 12,
> -				   mhp->attr.pbl_size, mhp->attr.pbl_addr))
> -		return -ENOMEM;
> -
> -	ret = iwch_finish_mem_reg(mhp, stag);
> -	if (ret)
> -		cxio_dereg_mem(&rhp->rdev, mhp->attr.stag, mhp->attr.pbl_size,
> -		       mhp->attr.pbl_addr);
> -	return ret;
> -}
> -
> -int iwch_alloc_pbl(struct iwch_mr *mhp, int npages)
> -{
> -	mhp->attr.pbl_addr = cxio_hal_pblpool_alloc(&mhp->rhp->rdev,
> -						    npages << 3);
> -
> -	if (!mhp->attr.pbl_addr)
> -		return -ENOMEM;
> -
> -	mhp->attr.pbl_size = npages;
> -
> -	return 0;
> -}
> -
> -void iwch_free_pbl(struct iwch_mr *mhp)
> -{
> -	cxio_hal_pblpool_free(&mhp->rhp->rdev, mhp->attr.pbl_addr,
> -			      mhp->attr.pbl_size << 3);
> -}
> -
> -int iwch_write_pbl(struct iwch_mr *mhp, __be64 *pages, int npages, int offset)
> -{
> -	return cxio_write_pbl(&mhp->rhp->rdev, pages,
> -			      mhp->attr.pbl_addr + (offset << 3), npages);
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
> deleted file mode 100644
> index dcf02ec02810..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
> +++ /dev/null
> @@ -1,1321 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/device.h>
> -#include <linux/netdevice.h>
> -#include <linux/etherdevice.h>
> -#include <linux/delay.h>
> -#include <linux/errno.h>
> -#include <linux/list.h>
> -#include <linux/sched/mm.h>
> -#include <linux/spinlock.h>
> -#include <linux/ethtool.h>
> -#include <linux/rtnetlink.h>
> -#include <linux/inetdevice.h>
> -#include <linux/slab.h>
> -
> -#include <asm/io.h>
> -#include <asm/irq.h>
> -#include <asm/byteorder.h>
> -
> -#include <rdma/iw_cm.h>
> -#include <rdma/ib_verbs.h>
> -#include <rdma/ib_smi.h>
> -#include <rdma/ib_umem.h>
> -#include <rdma/ib_user_verbs.h>
> -#include <rdma/uverbs_ioctl.h>
> -
> -#include "cxio_hal.h"
> -#include "iwch.h"
> -#include "iwch_provider.h"
> -#include "iwch_cm.h"
> -#include <rdma/cxgb3-abi.h>
> -#include "common.h"
> -
> -static void iwch_dealloc_ucontext(struct ib_ucontext *context)
> -{
> -	struct iwch_dev *rhp = to_iwch_dev(context->device);
> -	struct iwch_ucontext *ucontext = to_iwch_ucontext(context);
> -	struct iwch_mm_entry *mm, *tmp;
> -
> -	pr_debug("%s context %p\n", __func__, context);
> -	list_for_each_entry_safe(mm, tmp, &ucontext->mmaps, entry)
> -		kfree(mm);
> -	cxio_release_ucontext(&rhp->rdev, &ucontext->uctx);
> -}
> -
> -static int iwch_alloc_ucontext(struct ib_ucontext *ucontext,
> -			       struct ib_udata *udata)
> -{
> -	struct ib_device *ibdev = ucontext->device;
> -	struct iwch_ucontext *context = to_iwch_ucontext(ucontext);
> -	struct iwch_dev *rhp = to_iwch_dev(ibdev);
> -
> -	pr_debug("%s ibdev %p\n", __func__, ibdev);
> -	cxio_init_ucontext(&rhp->rdev, &context->uctx);
> -	INIT_LIST_HEAD(&context->mmaps);
> -	spin_lock_init(&context->mmap_lock);
> -	return 0;
> -}
> -
> -static void iwch_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
> -{
> -	struct iwch_cq *chp;
> -
> -	pr_debug("%s ib_cq %p\n", __func__, ib_cq);
> -	chp = to_iwch_cq(ib_cq);
> -
> -	xa_erase_irq(&chp->rhp->cqs, chp->cq.cqid);
> -	atomic_dec(&chp->refcnt);
> -	wait_event(chp->wait, !atomic_read(&chp->refcnt));
> -
> -	cxio_destroy_cq(&chp->rhp->rdev, &chp->cq);
> -}
> -
> -static int iwch_create_cq(struct ib_cq *ibcq,
> -			  const struct ib_cq_init_attr *attr,
> -			  struct ib_udata *udata)
> -{
> -	struct ib_device *ibdev = ibcq->device;
> -	int entries = attr->cqe;
> -	struct iwch_dev *rhp = to_iwch_dev(ibcq->device);
> -	struct iwch_cq *chp = to_iwch_cq(ibcq);
> -	struct iwch_create_cq_resp uresp;
> -	struct iwch_create_cq_req ureq;
> -	static int warned;
> -	size_t resplen;
> -
> -	pr_debug("%s ib_dev %p entries %d\n", __func__, ibdev, entries);
> -	if (attr->flags)
> -		return -EINVAL;
> -
> -	if (udata) {
> -		if (!t3a_device(rhp)) {
> -			if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
> -				return  -EFAULT;
> -
> -			chp->user_rptr_addr = (u32 __user *)(unsigned long)ureq.user_rptr_addr;
> -		}
> -	}
> -
> -	if (t3a_device(rhp)) {
> -
> -		/*
> -		 * T3A: Add some fluff to handle extra CQEs inserted
> -		 * for various errors.
> -		 * Additional CQE possibilities:
> -		 *      TERMINATE,
> -		 *      incoming RDMA WRITE Failures
> -		 *      incoming RDMA READ REQUEST FAILUREs
> -		 * NOTE: We cannot ensure the CQ won't overflow.
> -		 */
> -		entries += 16;
> -	}
> -	entries = roundup_pow_of_two(entries);
> -	chp->cq.size_log2 = ilog2(entries);
> -
> -	if (cxio_create_cq(&rhp->rdev, &chp->cq, !udata))
> -		return -ENOMEM;
> -
> -	chp->rhp = rhp;
> -	chp->ibcq.cqe = 1 << chp->cq.size_log2;
> -	spin_lock_init(&chp->lock);
> -	spin_lock_init(&chp->comp_handler_lock);
> -	atomic_set(&chp->refcnt, 1);
> -	init_waitqueue_head(&chp->wait);
> -	if (xa_store_irq(&rhp->cqs, chp->cq.cqid, chp, GFP_KERNEL)) {
> -		cxio_destroy_cq(&chp->rhp->rdev, &chp->cq);
> -		return -ENOMEM;
> -	}
> -
> -	if (udata) {
> -		struct iwch_mm_entry *mm;
> -		struct iwch_ucontext *ucontext = rdma_udata_to_drv_context(
> -			udata, struct iwch_ucontext, ibucontext);
> -
> -		mm = kmalloc(sizeof(*mm), GFP_KERNEL);
> -		if (!mm) {
> -			iwch_destroy_cq(&chp->ibcq, udata);
> -			return -ENOMEM;
> -		}
> -		uresp.cqid = chp->cq.cqid;
> -		uresp.size_log2 = chp->cq.size_log2;
> -		spin_lock(&ucontext->mmap_lock);
> -		uresp.key = ucontext->key;
> -		ucontext->key += PAGE_SIZE;
> -		spin_unlock(&ucontext->mmap_lock);
> -		mm->key = uresp.key;
> -		mm->addr = virt_to_phys(chp->cq.queue);
> -		if (udata->outlen < sizeof(uresp)) {
> -			if (!warned++)
> -				pr_warn("Warning - downlevel libcxgb3 (non-fatal)\n");
> -			mm->len = PAGE_ALIGN((1UL << uresp.size_log2) *
> -					     sizeof(struct t3_cqe));
> -			resplen = sizeof(struct iwch_create_cq_resp_v0);
> -		} else {
> -			mm->len = PAGE_ALIGN(((1UL << uresp.size_log2) + 1) *
> -					     sizeof(struct t3_cqe));
> -			uresp.memsize = mm->len;
> -			uresp.reserved = 0;
> -			resplen = sizeof(uresp);
> -		}
> -		if (ib_copy_to_udata(udata, &uresp, resplen)) {
> -			kfree(mm);
> -			iwch_destroy_cq(&chp->ibcq, udata);
> -			return -EFAULT;
> -		}
> -		insert_mmap(ucontext, mm);
> -	}
> -	pr_debug("created cqid 0x%0x chp %p size 0x%0x, dma_addr %pad\n",
> -		 chp->cq.cqid, chp, (1 << chp->cq.size_log2),
> -		 &chp->cq.dma_addr);
> -	return 0;
> -}
> -
> -static int iwch_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_cq *chp;
> -	enum t3_cq_opcode cq_op;
> -	int err;
> -	unsigned long flag;
> -	u32 rptr;
> -
> -	chp = to_iwch_cq(ibcq);
> -	rhp = chp->rhp;
> -	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> -		cq_op = CQ_ARM_SE;
> -	else
> -		cq_op = CQ_ARM_AN;
> -	if (chp->user_rptr_addr) {
> -		if (get_user(rptr, chp->user_rptr_addr))
> -			return -EFAULT;
> -		spin_lock_irqsave(&chp->lock, flag);
> -		chp->cq.rptr = rptr;
> -	} else
> -		spin_lock_irqsave(&chp->lock, flag);
> -	pr_debug("%s rptr 0x%x\n", __func__, chp->cq.rptr);
> -	err = cxio_hal_cq_op(&rhp->rdev, &chp->cq, cq_op, 0);
> -	spin_unlock_irqrestore(&chp->lock, flag);
> -	if (err < 0)
> -		pr_err("Error %d rearming CQID 0x%x\n", err, chp->cq.cqid);
> -	if (err > 0 && !(flags & IB_CQ_REPORT_MISSED_EVENTS))
> -		err = 0;
> -	return err;
> -}
> -
> -static int iwch_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
> -{
> -	int len = vma->vm_end - vma->vm_start;
> -	u32 key = vma->vm_pgoff << PAGE_SHIFT;
> -	struct cxio_rdev *rdev_p;
> -	int ret = 0;
> -	struct iwch_mm_entry *mm;
> -	struct iwch_ucontext *ucontext;
> -	u64 addr;
> -
> -	pr_debug("%s pgoff 0x%lx key 0x%x len %d\n", __func__, vma->vm_pgoff,
> -		 key, len);
> -
> -	if (vma->vm_start & (PAGE_SIZE-1)) {
> -	        return -EINVAL;
> -	}
> -
> -	rdev_p = &(to_iwch_dev(context->device)->rdev);
> -	ucontext = to_iwch_ucontext(context);
> -
> -	mm = remove_mmap(ucontext, key, len);
> -	if (!mm)
> -		return -EINVAL;
> -	addr = mm->addr;
> -	kfree(mm);
> -
> -	if ((addr >= rdev_p->rnic_info.udbell_physbase) &&
> -	    (addr < (rdev_p->rnic_info.udbell_physbase +
> -		       rdev_p->rnic_info.udbell_len))) {
> -
> -		/*
> -		 * Map T3 DB register.
> -		 */
> -		if (vma->vm_flags & VM_READ) {
> -			return -EPERM;
> -		}
> -
> -		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -		vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;
> -		vma->vm_flags &= ~VM_MAYREAD;
> -		ret = io_remap_pfn_range(vma, vma->vm_start,
> -					 addr >> PAGE_SHIFT,
> -				         len, vma->vm_page_prot);
> -	} else {
> -
> -		/*
> -		 * Map WQ or CQ contig dma memory...
> -		 */
> -		ret = remap_pfn_range(vma, vma->vm_start,
> -				      addr >> PAGE_SHIFT,
> -				      len, vma->vm_page_prot);
> -	}
> -
> -	return ret;
> -}
> -
> -static void iwch_deallocate_pd(struct ib_pd *pd, struct ib_udata *udata)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_pd *php;
> -
> -	php = to_iwch_pd(pd);
> -	rhp = php->rhp;
> -	pr_debug("%s ibpd %p pdid 0x%x\n", __func__, pd, php->pdid);
> -	cxio_hal_put_pdid(rhp->rdev.rscp, php->pdid);
> -}
> -
> -static int iwch_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
> -{
> -	struct iwch_pd *php = to_iwch_pd(pd);
> -	struct ib_device *ibdev = pd->device;
> -	u32 pdid;
> -	struct iwch_dev *rhp;
> -
> -	pr_debug("%s ibdev %p\n", __func__, ibdev);
> -	rhp = (struct iwch_dev *) ibdev;
> -	pdid = cxio_hal_get_pdid(rhp->rdev.rscp);
> -	if (!pdid)
> -		return -EINVAL;
> -
> -	php->pdid = pdid;
> -	php->rhp = rhp;
> -	if (udata) {
> -		struct iwch_alloc_pd_resp resp = {.pdid = php->pdid};
> -
> -		if (ib_copy_to_udata(udata, &resp, sizeof(resp))) {
> -			iwch_deallocate_pd(&php->ibpd, udata);
> -			return -EFAULT;
> -		}
> -	}
> -	pr_debug("%s pdid 0x%0x ptr 0x%p\n", __func__, pdid, php);
> -	return 0;
> -}
> -
> -static int iwch_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_mr *mhp;
> -	u32 mmid;
> -
> -	pr_debug("%s ib_mr %p\n", __func__, ib_mr);
> -
> -	mhp = to_iwch_mr(ib_mr);
> -	kfree(mhp->pages);
> -	rhp = mhp->rhp;
> -	mmid = mhp->attr.stag >> 8;
> -	cxio_dereg_mem(&rhp->rdev, mhp->attr.stag, mhp->attr.pbl_size,
> -		       mhp->attr.pbl_addr);
> -	iwch_free_pbl(mhp);
> -	xa_erase_irq(&rhp->mrs, mmid);
> -	if (mhp->kva)
> -		kfree((void *) (unsigned long) mhp->kva);
> -	ib_umem_release(mhp->umem);
> -	pr_debug("%s mmid 0x%x ptr %p\n", __func__, mmid, mhp);
> -	kfree(mhp);
> -	return 0;
> -}
> -
> -static struct ib_mr *iwch_get_dma_mr(struct ib_pd *pd, int acc)
> -{
> -	const u64 total_size = 0xffffffff;
> -	const u64 mask = (total_size + PAGE_SIZE - 1) & PAGE_MASK;
> -	struct iwch_pd *php = to_iwch_pd(pd);
> -	struct iwch_dev *rhp = php->rhp;
> -	struct iwch_mr *mhp;
> -	__be64 *page_list;
> -	int shift = 26, npages, ret, i;
> -
> -	pr_debug("%s ib_pd %p\n", __func__, pd);
> -
> -	/*
> -	 * T3 only supports 32 bits of size.
> -	 */
> -	if (sizeof(phys_addr_t) > 4) {
> -		pr_warn_once("Cannot support dma_mrs on this platform\n");
> -		return ERR_PTR(-ENOTSUPP);
> -	}
> -
> -	mhp = kzalloc(sizeof(*mhp), GFP_KERNEL);
> -	if (!mhp)
> -		return ERR_PTR(-ENOMEM);
> -
> -	mhp->rhp = rhp;
> -
> -	npages = (total_size + (1ULL << shift) - 1) >> shift;
> -	if (!npages) {
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
> -	page_list = kmalloc_array(npages, sizeof(u64), GFP_KERNEL);
> -	if (!page_list) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -	for (i = 0; i < npages; i++)
> -		page_list[i] = cpu_to_be64((u64)i << shift);
> -
> -	pr_debug("%s mask 0x%llx shift %d len %lld pbl_size %d\n",
> -		 __func__, mask, shift, total_size, npages);
> -
> -	ret = iwch_alloc_pbl(mhp, npages);
> -	if (ret) {
> -		kfree(page_list);
> -		goto err_pbl;
> -	}
> -
> -	ret = iwch_write_pbl(mhp, page_list, npages, 0);
> -	kfree(page_list);
> -	if (ret)
> -		goto err_pbl;
> -
> -	mhp->attr.pdid = php->pdid;
> -	mhp->attr.zbva = 0;
> -
> -	mhp->attr.perms = iwch_ib_to_tpt_access(acc);
> -	mhp->attr.va_fbo = 0;
> -	mhp->attr.page_size = shift - 12;
> -
> -	mhp->attr.len = (u32) total_size;
> -	mhp->attr.pbl_size = npages;
> -	ret = iwch_register_mem(rhp, php, mhp, shift);
> -	if (ret)
> -		goto err_pbl;
> -
> -	return &mhp->ibmr;
> -
> -err_pbl:
> -	iwch_free_pbl(mhp);
> -
> -err:
> -	kfree(mhp);
> -	return ERR_PTR(ret);
> -}
> -
> -static struct ib_mr *iwch_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> -				      u64 virt, int acc, struct ib_udata *udata)
> -{
> -	__be64 *pages;
> -	int shift, n, i;
> -	int err = 0;
> -	struct iwch_dev *rhp;
> -	struct iwch_pd *php;
> -	struct iwch_mr *mhp;
> -	struct iwch_reg_user_mr_resp uresp;
> -	struct sg_dma_page_iter sg_iter;
> -	pr_debug("%s ib_pd %p\n", __func__, pd);
> -
> -	php = to_iwch_pd(pd);
> -	rhp = php->rhp;
> -	mhp = kzalloc(sizeof(*mhp), GFP_KERNEL);
> -	if (!mhp)
> -		return ERR_PTR(-ENOMEM);
> -
> -	mhp->rhp = rhp;
> -
> -	mhp->umem = ib_umem_get(udata, start, length, acc, 0);
> -	if (IS_ERR(mhp->umem)) {
> -		err = PTR_ERR(mhp->umem);
> -		kfree(mhp);
> -		return ERR_PTR(err);
> -	}
> -
> -	shift = PAGE_SHIFT;
> -
> -	n = ib_umem_num_pages(mhp->umem);
> -
> -	err = iwch_alloc_pbl(mhp, n);
> -	if (err)
> -		goto err;
> -
> -	pages = (__be64 *) __get_free_page(GFP_KERNEL);
> -	if (!pages) {
> -		err = -ENOMEM;
> -		goto err_pbl;
> -	}
> -
> -	i = n = 0;
> -
> -	for_each_sg_dma_page(mhp->umem->sg_head.sgl, &sg_iter, mhp->umem->nmap, 0) {
> -		pages[i++] = cpu_to_be64(sg_page_iter_dma_address(&sg_iter));
> -		if (i == PAGE_SIZE / sizeof(*pages)) {
> -			err = iwch_write_pbl(mhp, pages, i, n);
> -			if (err)
> -				goto pbl_done;
> -			n += i;
> -			i = 0;
> -		}
> -	}
> -
> -	if (i)
> -		err = iwch_write_pbl(mhp, pages, i, n);
> -
> -pbl_done:
> -	free_page((unsigned long) pages);
> -	if (err)
> -		goto err_pbl;
> -
> -	mhp->attr.pdid = php->pdid;
> -	mhp->attr.zbva = 0;
> -	mhp->attr.perms = iwch_ib_to_tpt_access(acc);
> -	mhp->attr.va_fbo = virt;
> -	mhp->attr.page_size = shift - 12;
> -	mhp->attr.len = (u32) length;
> -
> -	err = iwch_register_mem(rhp, php, mhp, shift);
> -	if (err)
> -		goto err_pbl;
> -
> -	if (udata && !t3a_device(rhp)) {
> -		uresp.pbl_addr = (mhp->attr.pbl_addr -
> -				 rhp->rdev.rnic_info.pbl_base) >> 3;
> -		pr_debug("%s user resp pbl_addr 0x%x\n", __func__,
> -			 uresp.pbl_addr);
> -
> -		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
> -			iwch_dereg_mr(&mhp->ibmr, udata);
> -			err = -EFAULT;
> -			goto err;
> -		}
> -	}
> -
> -	return &mhp->ibmr;
> -
> -err_pbl:
> -	iwch_free_pbl(mhp);
> -
> -err:
> -	ib_umem_release(mhp->umem);
> -	kfree(mhp);
> -	return ERR_PTR(err);
> -}
> -
> -static struct ib_mw *iwch_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
> -				   struct ib_udata *udata)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_pd *php;
> -	struct iwch_mw *mhp;
> -	u32 mmid;
> -	u32 stag = 0;
> -	int ret;
> -
> -	if (type != IB_MW_TYPE_1)
> -		return ERR_PTR(-EINVAL);
> -
> -	php = to_iwch_pd(pd);
> -	rhp = php->rhp;
> -	mhp = kzalloc(sizeof(*mhp), GFP_KERNEL);
> -	if (!mhp)
> -		return ERR_PTR(-ENOMEM);
> -	ret = cxio_allocate_window(&rhp->rdev, &stag, php->pdid);
> -	if (ret) {
> -		kfree(mhp);
> -		return ERR_PTR(ret);
> -	}
> -	mhp->rhp = rhp;
> -	mhp->attr.pdid = php->pdid;
> -	mhp->attr.type = TPT_MW;
> -	mhp->attr.stag = stag;
> -	mmid = (stag) >> 8;
> -	mhp->ibmw.rkey = stag;
> -	if (xa_insert_irq(&rhp->mrs, mmid, mhp, GFP_KERNEL)) {
> -		cxio_deallocate_window(&rhp->rdev, mhp->attr.stag);
> -		kfree(mhp);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -	pr_debug("%s mmid 0x%x mhp %p stag 0x%x\n", __func__, mmid, mhp, stag);
> -	return &(mhp->ibmw);
> -}
> -
> -static int iwch_dealloc_mw(struct ib_mw *mw)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_mw *mhp;
> -	u32 mmid;
> -
> -	mhp = to_iwch_mw(mw);
> -	rhp = mhp->rhp;
> -	mmid = (mw->rkey) >> 8;
> -	cxio_deallocate_window(&rhp->rdev, mhp->attr.stag);
> -	xa_erase_irq(&rhp->mrs, mmid);
> -	pr_debug("%s ib_mw %p mmid 0x%x ptr %p\n", __func__, mw, mmid, mhp);
> -	kfree(mhp);
> -	return 0;
> -}
> -
> -static struct ib_mr *iwch_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> -				   u32 max_num_sg, struct ib_udata *udata)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_pd *php;
> -	struct iwch_mr *mhp;
> -	u32 mmid;
> -	u32 stag = 0;
> -	int ret = -ENOMEM;
> -
> -	if (mr_type != IB_MR_TYPE_MEM_REG ||
> -	    max_num_sg > T3_MAX_FASTREG_DEPTH)
> -		return ERR_PTR(-EINVAL);
> -
> -	php = to_iwch_pd(pd);
> -	rhp = php->rhp;
> -	mhp = kzalloc(sizeof(*mhp), GFP_KERNEL);
> -	if (!mhp)
> -		goto err;
> -
> -	mhp->pages = kcalloc(max_num_sg, sizeof(u64), GFP_KERNEL);
> -	if (!mhp->pages)
> -		goto pl_err;
> -
> -	mhp->rhp = rhp;
> -	ret = iwch_alloc_pbl(mhp, max_num_sg);
> -	if (ret)
> -		goto err1;
> -	mhp->attr.pbl_size = max_num_sg;
> -	ret = cxio_allocate_stag(&rhp->rdev, &stag, php->pdid,
> -				 mhp->attr.pbl_size, mhp->attr.pbl_addr);
> -	if (ret)
> -		goto err2;
> -	mhp->attr.pdid = php->pdid;
> -	mhp->attr.type = TPT_NON_SHARED_MR;
> -	mhp->attr.stag = stag;
> -	mhp->attr.state = 1;
> -	mmid = (stag) >> 8;
> -	mhp->ibmr.rkey = mhp->ibmr.lkey = stag;
> -	ret = xa_insert_irq(&rhp->mrs, mmid, mhp, GFP_KERNEL);
> -	if (ret)
> -		goto err3;
> -
> -	pr_debug("%s mmid 0x%x mhp %p stag 0x%x\n", __func__, mmid, mhp, stag);
> -	return &(mhp->ibmr);
> -err3:
> -	cxio_dereg_mem(&rhp->rdev, stag, mhp->attr.pbl_size,
> -		       mhp->attr.pbl_addr);
> -err2:
> -	iwch_free_pbl(mhp);
> -err1:
> -	kfree(mhp->pages);
> -pl_err:
> -	kfree(mhp);
> -err:
> -	return ERR_PTR(ret);
> -}
> -
> -static int iwch_set_page(struct ib_mr *ibmr, u64 addr)
> -{
> -	struct iwch_mr *mhp = to_iwch_mr(ibmr);
> -
> -	if (unlikely(mhp->npages == mhp->attr.pbl_size))
> -		return -ENOMEM;
> -
> -	mhp->pages[mhp->npages++] = addr;
> -
> -	return 0;
> -}
> -
> -static int iwch_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
> -			  int sg_nents, unsigned int *sg_offset)
> -{
> -	struct iwch_mr *mhp = to_iwch_mr(ibmr);
> -
> -	mhp->npages = 0;
> -
> -	return ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, iwch_set_page);
> -}
> -
> -static int iwch_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_qp *qhp;
> -	struct iwch_qp_attributes attrs;
> -	struct iwch_ucontext *ucontext;
> -
> -	qhp = to_iwch_qp(ib_qp);
> -	rhp = qhp->rhp;
> -
> -	attrs.next_state = IWCH_QP_STATE_ERROR;
> -	iwch_modify_qp(rhp, qhp, IWCH_QP_ATTR_NEXT_STATE, &attrs, 0);
> -	wait_event(qhp->wait, !qhp->ep);
> -
> -	xa_erase_irq(&rhp->qps, qhp->wq.qpid);
> -
> -	atomic_dec(&qhp->refcnt);
> -	wait_event(qhp->wait, !atomic_read(&qhp->refcnt));
> -
> -	ucontext = rdma_udata_to_drv_context(udata, struct iwch_ucontext,
> -					     ibucontext);
> -	cxio_destroy_qp(&rhp->rdev, &qhp->wq,
> -			ucontext ? &ucontext->uctx : &rhp->rdev.uctx);
> -
> -	pr_debug("%s ib_qp %p qpid 0x%0x qhp %p\n", __func__,
> -		 ib_qp, qhp->wq.qpid, qhp);
> -	kfree(qhp);
> -	return 0;
> -}
> -
> -static struct ib_qp *iwch_create_qp(struct ib_pd *pd,
> -			     struct ib_qp_init_attr *attrs,
> -			     struct ib_udata *udata)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_qp *qhp;
> -	struct iwch_pd *php;
> -	struct iwch_cq *schp;
> -	struct iwch_cq *rchp;
> -	struct iwch_create_qp_resp uresp;
> -	int wqsize, sqsize, rqsize;
> -	struct iwch_ucontext *ucontext;
> -
> -	pr_debug("%s ib_pd %p\n", __func__, pd);
> -	if (attrs->qp_type != IB_QPT_RC)
> -		return ERR_PTR(-EINVAL);
> -	php = to_iwch_pd(pd);
> -	rhp = php->rhp;
> -	schp = get_chp(rhp, ((struct iwch_cq *) attrs->send_cq)->cq.cqid);
> -	rchp = get_chp(rhp, ((struct iwch_cq *) attrs->recv_cq)->cq.cqid);
> -	if (!schp || !rchp)
> -		return ERR_PTR(-EINVAL);
> -
> -	/* The RQT size must be # of entries + 1 rounded up to a power of two */
> -	rqsize = roundup_pow_of_two(attrs->cap.max_recv_wr);
> -	if (rqsize == attrs->cap.max_recv_wr)
> -		rqsize = roundup_pow_of_two(attrs->cap.max_recv_wr+1);
> -
> -	/* T3 doesn't support RQT depth < 16 */
> -	if (rqsize < 16)
> -		rqsize = 16;
> -
> -	if (rqsize > T3_MAX_RQ_SIZE)
> -		return ERR_PTR(-EINVAL);
> -
> -	if (attrs->cap.max_inline_data > T3_MAX_INLINE)
> -		return ERR_PTR(-EINVAL);
> -
> -	/*
> -	 * NOTE: The SQ and total WQ sizes don't need to be
> -	 * a power of two.  However, all the code assumes
> -	 * they are. EG: Q_FREECNT() and friends.
> -	 */
> -	sqsize = roundup_pow_of_two(attrs->cap.max_send_wr);
> -	wqsize = roundup_pow_of_two(rqsize + sqsize);
> -
> -	/*
> -	 * Kernel users need more wq space for fastreg WRs which can take
> -	 * 2 WR fragments.
> -	 */
> -	ucontext = rdma_udata_to_drv_context(udata, struct iwch_ucontext,
> -					     ibucontext);
> -	if (!ucontext && wqsize < (rqsize + (2 * sqsize)))
> -		wqsize = roundup_pow_of_two(rqsize +
> -				roundup_pow_of_two(attrs->cap.max_send_wr * 2));
> -	pr_debug("%s wqsize %d sqsize %d rqsize %d\n", __func__,
> -		 wqsize, sqsize, rqsize);
> -	qhp = kzalloc(sizeof(*qhp), GFP_KERNEL);
> -	if (!qhp)
> -		return ERR_PTR(-ENOMEM);
> -	qhp->wq.size_log2 = ilog2(wqsize);
> -	qhp->wq.rq_size_log2 = ilog2(rqsize);
> -	qhp->wq.sq_size_log2 = ilog2(sqsize);
> -	if (cxio_create_qp(&rhp->rdev, !udata, &qhp->wq,
> -			   ucontext ? &ucontext->uctx : &rhp->rdev.uctx)) {
> -		kfree(qhp);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	attrs->cap.max_recv_wr = rqsize - 1;
> -	attrs->cap.max_send_wr = sqsize;
> -	attrs->cap.max_inline_data = T3_MAX_INLINE;
> -
> -	qhp->rhp = rhp;
> -	qhp->attr.pd = php->pdid;
> -	qhp->attr.scq = ((struct iwch_cq *) attrs->send_cq)->cq.cqid;
> -	qhp->attr.rcq = ((struct iwch_cq *) attrs->recv_cq)->cq.cqid;
> -	qhp->attr.sq_num_entries = attrs->cap.max_send_wr;
> -	qhp->attr.rq_num_entries = attrs->cap.max_recv_wr;
> -	qhp->attr.sq_max_sges = attrs->cap.max_send_sge;
> -	qhp->attr.sq_max_sges_rdma_write = attrs->cap.max_send_sge;
> -	qhp->attr.rq_max_sges = attrs->cap.max_recv_sge;
> -	qhp->attr.state = IWCH_QP_STATE_IDLE;
> -	qhp->attr.next_state = IWCH_QP_STATE_IDLE;
> -
> -	/*
> -	 * XXX - These don't get passed in from the openib user
> -	 * at create time.  The CM sets them via a QP modify.
> -	 * Need to fix...  I think the CM should
> -	 */
> -	qhp->attr.enable_rdma_read = 1;
> -	qhp->attr.enable_rdma_write = 1;
> -	qhp->attr.enable_bind = 1;
> -	qhp->attr.max_ord = 1;
> -	qhp->attr.max_ird = 1;
> -
> -	spin_lock_init(&qhp->lock);
> -	init_waitqueue_head(&qhp->wait);
> -	atomic_set(&qhp->refcnt, 1);
> -
> -	if (xa_store_irq(&rhp->qps, qhp->wq.qpid, qhp, GFP_KERNEL)) {
> -		cxio_destroy_qp(&rhp->rdev, &qhp->wq,
> -			ucontext ? &ucontext->uctx : &rhp->rdev.uctx);
> -		kfree(qhp);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	if (udata) {
> -
> -		struct iwch_mm_entry *mm1, *mm2;
> -
> -		mm1 = kmalloc(sizeof(*mm1), GFP_KERNEL);
> -		if (!mm1) {
> -			iwch_destroy_qp(&qhp->ibqp, udata);
> -			return ERR_PTR(-ENOMEM);
> -		}
> -
> -		mm2 = kmalloc(sizeof(*mm2), GFP_KERNEL);
> -		if (!mm2) {
> -			kfree(mm1);
> -			iwch_destroy_qp(&qhp->ibqp, udata);
> -			return ERR_PTR(-ENOMEM);
> -		}
> -
> -		uresp.qpid = qhp->wq.qpid;
> -		uresp.size_log2 = qhp->wq.size_log2;
> -		uresp.sq_size_log2 = qhp->wq.sq_size_log2;
> -		uresp.rq_size_log2 = qhp->wq.rq_size_log2;
> -		spin_lock(&ucontext->mmap_lock);
> -		uresp.key = ucontext->key;
> -		ucontext->key += PAGE_SIZE;
> -		uresp.db_key = ucontext->key;
> -		ucontext->key += PAGE_SIZE;
> -		spin_unlock(&ucontext->mmap_lock);
> -		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
> -			kfree(mm1);
> -			kfree(mm2);
> -			iwch_destroy_qp(&qhp->ibqp, udata);
> -			return ERR_PTR(-EFAULT);
> -		}
> -		mm1->key = uresp.key;
> -		mm1->addr = virt_to_phys(qhp->wq.queue);
> -		mm1->len = PAGE_ALIGN(wqsize * sizeof(union t3_wr));
> -		insert_mmap(ucontext, mm1);
> -		mm2->key = uresp.db_key;
> -		mm2->addr = qhp->wq.udb & PAGE_MASK;
> -		mm2->len = PAGE_SIZE;
> -		insert_mmap(ucontext, mm2);
> -	}
> -	qhp->ibqp.qp_num = qhp->wq.qpid;
> -	pr_debug(
> -		"%s sq_num_entries %d, rq_num_entries %d qpid 0x%0x qhp %p dma_addr %pad size %d rq_addr 0x%x\n",
> -		__func__, qhp->attr.sq_num_entries, qhp->attr.rq_num_entries,
> -		qhp->wq.qpid, qhp, &qhp->wq.dma_addr, 1 << qhp->wq.size_log2,
> -		qhp->wq.rq_addr);
> -	return &qhp->ibqp;
> -}
> -
> -static int iwch_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> -		      int attr_mask, struct ib_udata *udata)
> -{
> -	struct iwch_dev *rhp;
> -	struct iwch_qp *qhp;
> -	enum iwch_qp_attr_mask mask = 0;
> -	struct iwch_qp_attributes attrs = {};
> -
> -	pr_debug("%s ib_qp %p\n", __func__, ibqp);
> -
> -	/* iwarp does not support the RTR state */
> -	if ((attr_mask & IB_QP_STATE) && (attr->qp_state == IB_QPS_RTR))
> -		attr_mask &= ~IB_QP_STATE;
> -
> -	/* Make sure we still have something left to do */
> -	if (!attr_mask)
> -		return 0;
> -
> -	qhp = to_iwch_qp(ibqp);
> -	rhp = qhp->rhp;
> -
> -	attrs.next_state = iwch_convert_state(attr->qp_state);
> -	attrs.enable_rdma_read = (attr->qp_access_flags &
> -			       IB_ACCESS_REMOTE_READ) ?  1 : 0;
> -	attrs.enable_rdma_write = (attr->qp_access_flags &
> -				IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
> -	attrs.enable_bind = (attr->qp_access_flags & IB_ACCESS_MW_BIND) ? 1 : 0;
> -
> -
> -	mask |= (attr_mask & IB_QP_STATE) ? IWCH_QP_ATTR_NEXT_STATE : 0;
> -	mask |= (attr_mask & IB_QP_ACCESS_FLAGS) ?
> -			(IWCH_QP_ATTR_ENABLE_RDMA_READ |
> -			 IWCH_QP_ATTR_ENABLE_RDMA_WRITE |
> -			 IWCH_QP_ATTR_ENABLE_RDMA_BIND) : 0;
> -
> -	return iwch_modify_qp(rhp, qhp, mask, &attrs, 0);
> -}
> -
> -void iwch_qp_add_ref(struct ib_qp *qp)
> -{
> -	pr_debug("%s ib_qp %p\n", __func__, qp);
> -	atomic_inc(&(to_iwch_qp(qp)->refcnt));
> -}
> -
> -void iwch_qp_rem_ref(struct ib_qp *qp)
> -{
> -	pr_debug("%s ib_qp %p\n", __func__, qp);
> -	if (atomic_dec_and_test(&(to_iwch_qp(qp)->refcnt)))
> -	        wake_up(&(to_iwch_qp(qp)->wait));
> -}
> -
> -static struct ib_qp *iwch_get_qp(struct ib_device *dev, int qpn)
> -{
> -	pr_debug("%s ib_dev %p qpn 0x%x\n", __func__, dev, qpn);
> -	return (struct ib_qp *)get_qhp(to_iwch_dev(dev), qpn);
> -}
> -
> -
> -static int iwch_query_pkey(struct ib_device *ibdev,
> -			   u8 port, u16 index, u16 * pkey)
> -{
> -	pr_debug("%s ibdev %p\n", __func__, ibdev);
> -	*pkey = 0;
> -	return 0;
> -}
> -
> -static int iwch_query_gid(struct ib_device *ibdev, u8 port,
> -			  int index, union ib_gid *gid)
> -{
> -	struct iwch_dev *dev;
> -
> -	pr_debug("%s ibdev %p, port %d, index %d, gid %p\n",
> -		 __func__, ibdev, port, index, gid);
> -	dev = to_iwch_dev(ibdev);
> -	BUG_ON(port == 0 || port > 2);
> -	memset(&(gid->raw[0]), 0, sizeof(gid->raw));
> -	memcpy(&(gid->raw[0]), dev->rdev.port_info.lldevs[port-1]->dev_addr, 6);
> -	return 0;
> -}
> -
> -static u64 fw_vers_string_to_u64(struct iwch_dev *iwch_dev)
> -{
> -	struct ethtool_drvinfo info;
> -	struct net_device *lldev = iwch_dev->rdev.t3cdev_p->lldev;
> -	char *cp, *next;
> -	unsigned fw_maj, fw_min, fw_mic;
> -
> -	lldev->ethtool_ops->get_drvinfo(lldev, &info);
> -
> -	next = info.fw_version + 1;
> -	cp = strsep(&next, ".");
> -	sscanf(cp, "%i", &fw_maj);
> -	cp = strsep(&next, ".");
> -	sscanf(cp, "%i", &fw_min);
> -	cp = strsep(&next, ".");
> -	sscanf(cp, "%i", &fw_mic);
> -
> -	return (((u64)fw_maj & 0xffff) << 32) | ((fw_min & 0xffff) << 16) |
> -	       (fw_mic & 0xffff);
> -}
> -
> -static int iwch_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
> -			     struct ib_udata *uhw)
> -{
> -
> -	struct iwch_dev *dev;
> -
> -	pr_debug("%s ibdev %p\n", __func__, ibdev);
> -
> -	if (uhw->inlen || uhw->outlen)
> -		return -EINVAL;
> -
> -	dev = to_iwch_dev(ibdev);
> -	memcpy(&props->sys_image_guid, dev->rdev.t3cdev_p->lldev->dev_addr, 6);
> -	props->hw_ver = dev->rdev.t3cdev_p->type;
> -	props->fw_ver = fw_vers_string_to_u64(dev);
> -	props->device_cap_flags = dev->device_cap_flags;
> -	props->page_size_cap = dev->attr.mem_pgsizes_bitmask;
> -	props->vendor_id = (u32)dev->rdev.rnic_info.pdev->vendor;
> -	props->vendor_part_id = (u32)dev->rdev.rnic_info.pdev->device;
> -	props->max_mr_size = dev->attr.max_mr_size;
> -	props->max_qp = dev->attr.max_qps;
> -	props->max_qp_wr = dev->attr.max_wrs;
> -	props->max_send_sge = dev->attr.max_sge_per_wr;
> -	props->max_recv_sge = dev->attr.max_sge_per_wr;
> -	props->max_sge_rd = 1;
> -	props->max_qp_rd_atom = dev->attr.max_rdma_reads_per_qp;
> -	props->max_qp_init_rd_atom = dev->attr.max_rdma_reads_per_qp;
> -	props->max_cq = dev->attr.max_cqs;
> -	props->max_cqe = dev->attr.max_cqes_per_cq;
> -	props->max_mr = dev->attr.max_mem_regs;
> -	props->max_pd = dev->attr.max_pds;
> -	props->local_ca_ack_delay = 0;
> -	props->max_fast_reg_page_list_len = T3_MAX_FASTREG_DEPTH;
> -
> -	return 0;
> -}
> -
> -static int iwch_query_port(struct ib_device *ibdev,
> -			   u8 port, struct ib_port_attr *props)
> -{
> -	pr_debug("%s ibdev %p\n", __func__, ibdev);
> -
> -	props->port_cap_flags =
> -	    IB_PORT_CM_SUP |
> -	    IB_PORT_SNMP_TUNNEL_SUP |
> -	    IB_PORT_REINIT_SUP |
> -	    IB_PORT_DEVICE_MGMT_SUP |
> -	    IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
> -	props->gid_tbl_len = 1;
> -	props->pkey_tbl_len = 1;
> -	props->active_width = 2;
> -	props->active_speed = IB_SPEED_DDR;
> -	props->max_msg_sz = -1;
> -
> -	return 0;
> -}
> -
> -static ssize_t hw_rev_show(struct device *dev,
> -			   struct device_attribute *attr, char *buf)
> -{
> -	struct iwch_dev *iwch_dev =
> -			rdma_device_to_drv_device(dev, struct iwch_dev, ibdev);
> -
> -	pr_debug("%s dev 0x%p\n", __func__, dev);
> -	return sprintf(buf, "%d\n", iwch_dev->rdev.t3cdev_p->type);
> -}
> -static DEVICE_ATTR_RO(hw_rev);
> -
> -static ssize_t hca_type_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct iwch_dev *iwch_dev =
> -			rdma_device_to_drv_device(dev, struct iwch_dev, ibdev);
> -	struct ethtool_drvinfo info;
> -	struct net_device *lldev = iwch_dev->rdev.t3cdev_p->lldev;
> -
> -	pr_debug("%s dev 0x%p\n", __func__, dev);
> -	lldev->ethtool_ops->get_drvinfo(lldev, &info);
> -	return sprintf(buf, "%s\n", info.driver);
> -}
> -static DEVICE_ATTR_RO(hca_type);
> -
> -static ssize_t board_id_show(struct device *dev,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct iwch_dev *iwch_dev =
> -			rdma_device_to_drv_device(dev, struct iwch_dev, ibdev);
> -
> -	pr_debug("%s dev 0x%p\n", __func__, dev);
> -	return sprintf(buf, "%x.%x\n", iwch_dev->rdev.rnic_info.pdev->vendor,
> -		       iwch_dev->rdev.rnic_info.pdev->device);
> -}
> -static DEVICE_ATTR_RO(board_id);
> -
> -enum counters {
> -	IPINRECEIVES,
> -	IPINHDRERRORS,
> -	IPINADDRERRORS,
> -	IPINUNKNOWNPROTOS,
> -	IPINDISCARDS,
> -	IPINDELIVERS,
> -	IPOUTREQUESTS,
> -	IPOUTDISCARDS,
> -	IPOUTNOROUTES,
> -	IPREASMTIMEOUT,
> -	IPREASMREQDS,
> -	IPREASMOKS,
> -	IPREASMFAILS,
> -	TCPACTIVEOPENS,
> -	TCPPASSIVEOPENS,
> -	TCPATTEMPTFAILS,
> -	TCPESTABRESETS,
> -	TCPCURRESTAB,
> -	TCPINSEGS,
> -	TCPOUTSEGS,
> -	TCPRETRANSSEGS,
> -	TCPINERRS,
> -	TCPOUTRSTS,
> -	TCPRTOMIN,
> -	TCPRTOMAX,
> -	NR_COUNTERS
> -};
> -
> -static const char * const names[] = {
> -	[IPINRECEIVES] = "ipInReceives",
> -	[IPINHDRERRORS] = "ipInHdrErrors",
> -	[IPINADDRERRORS] = "ipInAddrErrors",
> -	[IPINUNKNOWNPROTOS] = "ipInUnknownProtos",
> -	[IPINDISCARDS] = "ipInDiscards",
> -	[IPINDELIVERS] = "ipInDelivers",
> -	[IPOUTREQUESTS] = "ipOutRequests",
> -	[IPOUTDISCARDS] = "ipOutDiscards",
> -	[IPOUTNOROUTES] = "ipOutNoRoutes",
> -	[IPREASMTIMEOUT] = "ipReasmTimeout",
> -	[IPREASMREQDS] = "ipReasmReqds",
> -	[IPREASMOKS] = "ipReasmOKs",
> -	[IPREASMFAILS] = "ipReasmFails",
> -	[TCPACTIVEOPENS] = "tcpActiveOpens",
> -	[TCPPASSIVEOPENS] = "tcpPassiveOpens",
> -	[TCPATTEMPTFAILS] = "tcpAttemptFails",
> -	[TCPESTABRESETS] = "tcpEstabResets",
> -	[TCPCURRESTAB] = "tcpCurrEstab",
> -	[TCPINSEGS] = "tcpInSegs",
> -	[TCPOUTSEGS] = "tcpOutSegs",
> -	[TCPRETRANSSEGS] = "tcpRetransSegs",
> -	[TCPINERRS] = "tcpInErrs",
> -	[TCPOUTRSTS] = "tcpOutRsts",
> -	[TCPRTOMIN] = "tcpRtoMin",
> -	[TCPRTOMAX] = "tcpRtoMax",
> -};
> -
> -static struct rdma_hw_stats *iwch_alloc_stats(struct ib_device *ibdev,
> -					      u8 port_num)
> -{
> -	BUILD_BUG_ON(ARRAY_SIZE(names) != NR_COUNTERS);
> -
> -	/* Our driver only supports device level stats */
> -	if (port_num != 0)
> -		return NULL;
> -
> -	return rdma_alloc_hw_stats_struct(names, NR_COUNTERS,
> -					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
> -}
> -
> -static int iwch_get_mib(struct ib_device *ibdev, struct rdma_hw_stats *stats,
> -			u8 port, int index)
> -{
> -	struct iwch_dev *dev;
> -	struct tp_mib_stats m;
> -	int ret;
> -
> -	if (port != 0 || !stats)
> -		return -ENOSYS;
> -
> -	pr_debug("%s ibdev %p\n", __func__, ibdev);
> -	dev = to_iwch_dev(ibdev);
> -	ret = dev->rdev.t3cdev_p->ctl(dev->rdev.t3cdev_p, RDMA_GET_MIB, &m);
> -	if (ret)
> -		return -ENOSYS;
> -
> -	stats->value[IPINRECEIVES] = ((u64)m.ipInReceive_hi << 32) +	m.ipInReceive_lo;
> -	stats->value[IPINHDRERRORS] = ((u64)m.ipInHdrErrors_hi << 32) + m.ipInHdrErrors_lo;
> -	stats->value[IPINADDRERRORS] = ((u64)m.ipInAddrErrors_hi << 32) + m.ipInAddrErrors_lo;
> -	stats->value[IPINUNKNOWNPROTOS] = ((u64)m.ipInUnknownProtos_hi << 32) + m.ipInUnknownProtos_lo;
> -	stats->value[IPINDISCARDS] = ((u64)m.ipInDiscards_hi << 32) + m.ipInDiscards_lo;
> -	stats->value[IPINDELIVERS] = ((u64)m.ipInDelivers_hi << 32) + m.ipInDelivers_lo;
> -	stats->value[IPOUTREQUESTS] = ((u64)m.ipOutRequests_hi << 32) + m.ipOutRequests_lo;
> -	stats->value[IPOUTDISCARDS] = ((u64)m.ipOutDiscards_hi << 32) + m.ipOutDiscards_lo;
> -	stats->value[IPOUTNOROUTES] = ((u64)m.ipOutNoRoutes_hi << 32) + m.ipOutNoRoutes_lo;
> -	stats->value[IPREASMTIMEOUT] = 	m.ipReasmTimeout;
> -	stats->value[IPREASMREQDS] = m.ipReasmReqds;
> -	stats->value[IPREASMOKS] = m.ipReasmOKs;
> -	stats->value[IPREASMFAILS] = m.ipReasmFails;
> -	stats->value[TCPACTIVEOPENS] =	m.tcpActiveOpens;
> -	stats->value[TCPPASSIVEOPENS] =	m.tcpPassiveOpens;
> -	stats->value[TCPATTEMPTFAILS] = m.tcpAttemptFails;
> -	stats->value[TCPESTABRESETS] = m.tcpEstabResets;
> -	stats->value[TCPCURRESTAB] = m.tcpOutRsts;
> -	stats->value[TCPINSEGS] = m.tcpCurrEstab;
> -	stats->value[TCPOUTSEGS] = ((u64)m.tcpInSegs_hi << 32) + m.tcpInSegs_lo;
> -	stats->value[TCPRETRANSSEGS] = ((u64)m.tcpOutSegs_hi << 32) + m.tcpOutSegs_lo;
> -	stats->value[TCPINERRS] = ((u64)m.tcpRetransSeg_hi << 32) + m.tcpRetransSeg_lo,
> -	stats->value[TCPOUTRSTS] = ((u64)m.tcpInErrs_hi << 32) + m.tcpInErrs_lo;
> -	stats->value[TCPRTOMIN] = m.tcpRtoMin;
> -	stats->value[TCPRTOMAX] = m.tcpRtoMax;
> -
> -	return stats->num_counters;
> -}
> -
> -static struct attribute *iwch_class_attributes[] = {
> -	&dev_attr_hw_rev.attr,
> -	&dev_attr_hca_type.attr,
> -	&dev_attr_board_id.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group iwch_attr_group = {
> -	.attrs = iwch_class_attributes,
> -};
> -
> -static int iwch_port_immutable(struct ib_device *ibdev, u8 port_num,
> -			       struct ib_port_immutable *immutable)
> -{
> -	struct ib_port_attr attr;
> -	int err;
> -
> -	immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
> -
> -	err = ib_query_port(ibdev, port_num, &attr);
> -	if (err)
> -		return err;
> -
> -	immutable->pkey_tbl_len = attr.pkey_tbl_len;
> -	immutable->gid_tbl_len = attr.gid_tbl_len;
> -
> -	return 0;
> -}
> -
> -static void get_dev_fw_ver_str(struct ib_device *ibdev, char *str)
> -{
> -	struct iwch_dev *iwch_dev = to_iwch_dev(ibdev);
> -	struct ethtool_drvinfo info;
> -	struct net_device *lldev = iwch_dev->rdev.t3cdev_p->lldev;
> -
> -	pr_debug("%s dev 0x%p\n", __func__, iwch_dev);
> -	lldev->ethtool_ops->get_drvinfo(lldev, &info);
> -	snprintf(str, IB_FW_VERSION_NAME_MAX, "%s", info.fw_version);
> -}
> -
> -static const struct ib_device_ops iwch_dev_ops = {
> -	.owner = THIS_MODULE,
> -	.driver_id = RDMA_DRIVER_CXGB3,
> -	.uverbs_abi_ver = IWCH_UVERBS_ABI_VERSION,
> -	.uverbs_no_driver_id_binding = 1,
> -
> -	.alloc_hw_stats	= iwch_alloc_stats,
> -	.alloc_mr = iwch_alloc_mr,
> -	.alloc_mw = iwch_alloc_mw,
> -	.alloc_pd = iwch_allocate_pd,
> -	.alloc_ucontext = iwch_alloc_ucontext,
> -	.create_cq = iwch_create_cq,
> -	.create_qp = iwch_create_qp,
> -	.dealloc_mw = iwch_dealloc_mw,
> -	.dealloc_pd = iwch_deallocate_pd,
> -	.dealloc_ucontext = iwch_dealloc_ucontext,
> -	.dereg_mr = iwch_dereg_mr,
> -	.destroy_cq = iwch_destroy_cq,
> -	.destroy_qp = iwch_destroy_qp,
> -	.get_dev_fw_str = get_dev_fw_ver_str,
> -	.get_dma_mr = iwch_get_dma_mr,
> -	.get_hw_stats = iwch_get_mib,
> -	.get_port_immutable = iwch_port_immutable,
> -	.iw_accept = iwch_accept_cr,
> -	.iw_add_ref = iwch_qp_add_ref,
> -	.iw_connect = iwch_connect,
> -	.iw_create_listen = iwch_create_listen,
> -	.iw_destroy_listen = iwch_destroy_listen,
> -	.iw_get_qp = iwch_get_qp,
> -	.iw_reject = iwch_reject_cr,
> -	.iw_rem_ref = iwch_qp_rem_ref,
> -	.map_mr_sg = iwch_map_mr_sg,
> -	.mmap = iwch_mmap,
> -	.modify_qp = iwch_ib_modify_qp,
> -	.poll_cq = iwch_poll_cq,
> -	.post_recv = iwch_post_receive,
> -	.post_send = iwch_post_send,
> -	.query_device = iwch_query_device,
> -	.query_gid = iwch_query_gid,
> -	.query_pkey = iwch_query_pkey,
> -	.query_port = iwch_query_port,
> -	.reg_user_mr = iwch_reg_user_mr,
> -	.req_notify_cq = iwch_arm_cq,
> -	INIT_RDMA_OBJ_SIZE(ib_pd, iwch_pd, ibpd),
> -	INIT_RDMA_OBJ_SIZE(ib_cq, iwch_cq, ibcq),
> -	INIT_RDMA_OBJ_SIZE(ib_ucontext, iwch_ucontext, ibucontext),
> -};
> -
> -static int set_netdevs(struct ib_device *ib_dev, struct cxio_rdev *rdev)
> -{
> -	int ret;
> -	int i;
> -
> -	for (i = 0; i < rdev->port_info.nports; i++) {
> -		ret = ib_device_set_netdev(ib_dev, rdev->port_info.lldevs[i],
> -					   i + 1);
> -		if (ret)
> -			return ret;
> -	}
> -	return 0;
> -}
> -
> -int iwch_register_device(struct iwch_dev *dev)
> -{
> -	int err;
> -
> -	pr_debug("%s iwch_dev %p\n", __func__, dev);
> -	memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
> -	memcpy(&dev->ibdev.node_guid, dev->rdev.t3cdev_p->lldev->dev_addr, 6);
> -	dev->device_cap_flags = IB_DEVICE_LOCAL_DMA_LKEY |
> -				IB_DEVICE_MEM_WINDOW |
> -				IB_DEVICE_MEM_MGT_EXTENSIONS;
> -
> -	/* cxgb3 supports STag 0. */
> -	dev->ibdev.local_dma_lkey = 0;
> -
> -	dev->ibdev.uverbs_cmd_mask =
> -	    (1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
> -	    (1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
> -	    (1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
> -	    (1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
> -	    (1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
> -	    (1ull << IB_USER_VERBS_CMD_REG_MR) |
> -	    (1ull << IB_USER_VERBS_CMD_DEREG_MR) |
> -	    (1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
> -	    (1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
> -	    (1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
> -	    (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
> -	    (1ull << IB_USER_VERBS_CMD_CREATE_QP) |
> -	    (1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
> -	    (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
> -	    (1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
> -	    (1ull << IB_USER_VERBS_CMD_POST_SEND) |
> -	    (1ull << IB_USER_VERBS_CMD_POST_RECV);
> -	dev->ibdev.node_type = RDMA_NODE_RNIC;
> -	BUILD_BUG_ON(sizeof(IWCH_NODE_DESC) > IB_DEVICE_NODE_DESC_MAX);
> -	memcpy(dev->ibdev.node_desc, IWCH_NODE_DESC, sizeof(IWCH_NODE_DESC));
> -	dev->ibdev.phys_port_cnt = dev->rdev.port_info.nports;
> -	dev->ibdev.num_comp_vectors = 1;
> -	dev->ibdev.dev.parent = &dev->rdev.rnic_info.pdev->dev;
> -
> -	memcpy(dev->ibdev.iw_ifname, dev->rdev.t3cdev_p->lldev->name,
> -	       sizeof(dev->ibdev.iw_ifname));
> -
> -	rdma_set_device_sysfs_group(&dev->ibdev, &iwch_attr_group);
> -	ib_set_device_ops(&dev->ibdev, &iwch_dev_ops);
> -	err = set_netdevs(&dev->ibdev, &dev->rdev);
> -	if (err)
> -		return err;
> -
> -	return ib_register_device(&dev->ibdev, "cxgb3_%d");
> -}
> -
> -void iwch_unregister_device(struct iwch_dev *dev)
> -{
> -	pr_debug("%s iwch_dev %p\n", __func__, dev);
> -	ib_unregister_device(&dev->ibdev);
> -	return;
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.h b/drivers/infiniband/hw/cxgb3/iwch_provider.h
> deleted file mode 100644
> index 8adbe9658935..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_provider.h
> +++ /dev/null
> @@ -1,347 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef __IWCH_PROVIDER_H__
> -#define __IWCH_PROVIDER_H__
> -
> -#include <linux/list.h>
> -#include <linux/spinlock.h>
> -#include <rdma/ib_verbs.h>
> -#include <asm/types.h>
> -#include "t3cdev.h"
> -#include "iwch.h"
> -#include "cxio_wr.h"
> -#include "cxio_hal.h"
> -
> -struct iwch_pd {
> -	struct ib_pd ibpd;
> -	u32 pdid;
> -	struct iwch_dev *rhp;
> -};
> -
> -static inline struct iwch_pd *to_iwch_pd(struct ib_pd *ibpd)
> -{
> -	return container_of(ibpd, struct iwch_pd, ibpd);
> -}
> -
> -struct tpt_attributes {
> -	u32 stag;
> -	u32 state:1;
> -	u32 type:2;
> -	u32 rsvd:1;
> -	enum tpt_mem_perm perms;
> -	u32 remote_invaliate_disable:1;
> -	u32 zbva:1;
> -	u32 mw_bind_enable:1;
> -	u32 page_size:5;
> -
> -	u32 pdid;
> -	u32 qpid;
> -	u32 pbl_addr;
> -	u32 len;
> -	u64 va_fbo;
> -	u32 pbl_size;
> -};
> -
> -struct iwch_mr {
> -	struct ib_mr ibmr;
> -	struct ib_umem *umem;
> -	struct iwch_dev *rhp;
> -	u64 kva;
> -	struct tpt_attributes attr;
> -	u64 *pages;
> -	u32 npages;
> -};
> -
> -typedef struct iwch_mw iwch_mw_handle;
> -
> -static inline struct iwch_mr *to_iwch_mr(struct ib_mr *ibmr)
> -{
> -	return container_of(ibmr, struct iwch_mr, ibmr);
> -}
> -
> -struct iwch_mw {
> -	struct ib_mw ibmw;
> -	struct iwch_dev *rhp;
> -	u64 kva;
> -	struct tpt_attributes attr;
> -};
> -
> -static inline struct iwch_mw *to_iwch_mw(struct ib_mw *ibmw)
> -{
> -	return container_of(ibmw, struct iwch_mw, ibmw);
> -}
> -
> -struct iwch_cq {
> -	struct ib_cq ibcq;
> -	struct iwch_dev *rhp;
> -	struct t3_cq cq;
> -	spinlock_t lock;
> -	spinlock_t comp_handler_lock;
> -	atomic_t refcnt;
> -	wait_queue_head_t wait;
> -	u32 __user *user_rptr_addr;
> -};
> -
> -static inline struct iwch_cq *to_iwch_cq(struct ib_cq *ibcq)
> -{
> -	return container_of(ibcq, struct iwch_cq, ibcq);
> -}
> -
> -enum IWCH_QP_FLAGS {
> -	QP_QUIESCED = 0x01
> -};
> -
> -struct iwch_mpa_attributes {
> -	u8 initiator;
> -	u8 recv_marker_enabled;
> -	u8 xmit_marker_enabled;	/* iWARP: enable inbound Read Resp. */
> -	u8 crc_enabled;
> -	u8 version;	/* 0 or 1 */
> -};
> -
> -struct iwch_qp_attributes {
> -	u32 scq;
> -	u32 rcq;
> -	u32 sq_num_entries;
> -	u32 rq_num_entries;
> -	u32 sq_max_sges;
> -	u32 sq_max_sges_rdma_write;
> -	u32 rq_max_sges;
> -	u32 state;
> -	u8 enable_rdma_read;
> -	u8 enable_rdma_write;	/* enable inbound Read Resp. */
> -	u8 enable_bind;
> -	u8 enable_mmid0_fastreg;	/* Enable STAG0 + Fast-register */
> -	/*
> -	 * Next QP state. If specify the current state, only the
> -	 * QP attributes will be modified.
> -	 */
> -	u32 max_ord;
> -	u32 max_ird;
> -	u32 pd;	/* IN */
> -	u32 next_state;
> -	char terminate_buffer[52];
> -	u32 terminate_msg_len;
> -	u8 is_terminate_local;
> -	struct iwch_mpa_attributes mpa_attr;	/* IN-OUT */
> -	struct iwch_ep *llp_stream_handle;
> -	char *stream_msg_buf;	/* Last stream msg. before Idle -> RTS */
> -	u32 stream_msg_buf_len;	/* Only on Idle -> RTS */
> -};
> -
> -struct iwch_qp {
> -	struct ib_qp ibqp;
> -	struct iwch_dev *rhp;
> -	struct iwch_ep *ep;
> -	struct iwch_qp_attributes attr;
> -	struct t3_wq wq;
> -	spinlock_t lock;
> -	atomic_t refcnt;
> -	wait_queue_head_t wait;
> -	enum IWCH_QP_FLAGS flags;
> -};
> -
> -static inline int qp_quiesced(struct iwch_qp *qhp)
> -{
> -	return qhp->flags & QP_QUIESCED;
> -}
> -
> -static inline struct iwch_qp *to_iwch_qp(struct ib_qp *ibqp)
> -{
> -	return container_of(ibqp, struct iwch_qp, ibqp);
> -}
> -
> -void iwch_qp_add_ref(struct ib_qp *qp);
> -void iwch_qp_rem_ref(struct ib_qp *qp);
> -
> -struct iwch_ucontext {
> -	struct ib_ucontext ibucontext;
> -	struct cxio_ucontext uctx;
> -	u32 key;
> -	spinlock_t mmap_lock;
> -	struct list_head mmaps;
> -};
> -
> -static inline struct iwch_ucontext *to_iwch_ucontext(struct ib_ucontext *c)
> -{
> -	return container_of(c, struct iwch_ucontext, ibucontext);
> -}
> -
> -struct iwch_mm_entry {
> -	struct list_head entry;
> -	u64 addr;
> -	u32 key;
> -	unsigned len;
> -};
> -
> -static inline struct iwch_mm_entry *remove_mmap(struct iwch_ucontext *ucontext,
> -						u32 key, unsigned len)
> -{
> -	struct list_head *pos, *nxt;
> -	struct iwch_mm_entry *mm;
> -
> -	spin_lock(&ucontext->mmap_lock);
> -	list_for_each_safe(pos, nxt, &ucontext->mmaps) {
> -
> -		mm = list_entry(pos, struct iwch_mm_entry, entry);
> -		if (mm->key == key && mm->len == len) {
> -			list_del_init(&mm->entry);
> -			spin_unlock(&ucontext->mmap_lock);
> -			pr_debug("%s key 0x%x addr 0x%llx len %d\n",
> -				 __func__, key,
> -				 (unsigned long long)mm->addr, mm->len);
> -			return mm;
> -		}
> -	}
> -	spin_unlock(&ucontext->mmap_lock);
> -	return NULL;
> -}
> -
> -static inline void insert_mmap(struct iwch_ucontext *ucontext,
> -			       struct iwch_mm_entry *mm)
> -{
> -	spin_lock(&ucontext->mmap_lock);
> -	pr_debug("%s key 0x%x addr 0x%llx len %d\n",
> -		 __func__, mm->key, (unsigned long long)mm->addr, mm->len);
> -	list_add_tail(&mm->entry, &ucontext->mmaps);
> -	spin_unlock(&ucontext->mmap_lock);
> -}
> -
> -enum iwch_qp_attr_mask {
> -	IWCH_QP_ATTR_NEXT_STATE = 1 << 0,
> -	IWCH_QP_ATTR_ENABLE_RDMA_READ = 1 << 7,
> -	IWCH_QP_ATTR_ENABLE_RDMA_WRITE = 1 << 8,
> -	IWCH_QP_ATTR_ENABLE_RDMA_BIND = 1 << 9,
> -	IWCH_QP_ATTR_MAX_ORD = 1 << 11,
> -	IWCH_QP_ATTR_MAX_IRD = 1 << 12,
> -	IWCH_QP_ATTR_LLP_STREAM_HANDLE = 1 << 22,
> -	IWCH_QP_ATTR_STREAM_MSG_BUFFER = 1 << 23,
> -	IWCH_QP_ATTR_MPA_ATTR = 1 << 24,
> -	IWCH_QP_ATTR_QP_CONTEXT_ACTIVATE = 1 << 25,
> -	IWCH_QP_ATTR_VALID_MODIFY = (IWCH_QP_ATTR_ENABLE_RDMA_READ |
> -				     IWCH_QP_ATTR_ENABLE_RDMA_WRITE |
> -				     IWCH_QP_ATTR_MAX_ORD |
> -				     IWCH_QP_ATTR_MAX_IRD |
> -				     IWCH_QP_ATTR_LLP_STREAM_HANDLE |
> -				     IWCH_QP_ATTR_STREAM_MSG_BUFFER |
> -				     IWCH_QP_ATTR_MPA_ATTR |
> -				     IWCH_QP_ATTR_QP_CONTEXT_ACTIVATE)
> -};
> -
> -int iwch_modify_qp(struct iwch_dev *rhp,
> -				struct iwch_qp *qhp,
> -				enum iwch_qp_attr_mask mask,
> -				struct iwch_qp_attributes *attrs,
> -				int internal);
> -
> -enum iwch_qp_state {
> -	IWCH_QP_STATE_IDLE,
> -	IWCH_QP_STATE_RTS,
> -	IWCH_QP_STATE_ERROR,
> -	IWCH_QP_STATE_TERMINATE,
> -	IWCH_QP_STATE_CLOSING,
> -	IWCH_QP_STATE_TOT
> -};
> -
> -static inline int iwch_convert_state(enum ib_qp_state ib_state)
> -{
> -	switch (ib_state) {
> -	case IB_QPS_RESET:
> -	case IB_QPS_INIT:
> -		return IWCH_QP_STATE_IDLE;
> -	case IB_QPS_RTS:
> -		return IWCH_QP_STATE_RTS;
> -	case IB_QPS_SQD:
> -		return IWCH_QP_STATE_CLOSING;
> -	case IB_QPS_SQE:
> -		return IWCH_QP_STATE_TERMINATE;
> -	case IB_QPS_ERR:
> -		return IWCH_QP_STATE_ERROR;
> -	default:
> -		return -1;
> -	}
> -}
> -
> -static inline u32 iwch_ib_to_tpt_access(int acc)
> -{
> -	return (acc & IB_ACCESS_REMOTE_WRITE ? TPT_REMOTE_WRITE : 0) |
> -	       (acc & IB_ACCESS_REMOTE_READ ? TPT_REMOTE_READ : 0) |
> -	       (acc & IB_ACCESS_LOCAL_WRITE ? TPT_LOCAL_WRITE : 0) |
> -	       (acc & IB_ACCESS_MW_BIND ? TPT_MW_BIND : 0) |
> -	       TPT_LOCAL_READ;
> -}
> -
> -static inline u32 iwch_ib_to_tpt_bind_access(int acc)
> -{
> -	return (acc & IB_ACCESS_REMOTE_WRITE ? TPT_REMOTE_WRITE : 0) |
> -	       (acc & IB_ACCESS_REMOTE_READ ? TPT_REMOTE_READ : 0);
> -}
> -
> -enum iwch_mmid_state {
> -	IWCH_STAG_STATE_VALID,
> -	IWCH_STAG_STATE_INVALID
> -};
> -
> -enum iwch_qp_query_flags {
> -	IWCH_QP_QUERY_CONTEXT_NONE = 0x0,	/* No ctx; Only attrs */
> -	IWCH_QP_QUERY_CONTEXT_GET = 0x1,	/* Get ctx + attrs */
> -	IWCH_QP_QUERY_CONTEXT_SUSPEND = 0x2,	/* Not Supported */
> -
> -	/*
> -	 * Quiesce QP context; Consumer
> -	 * will NOT replay outstanding WR
> -	 */
> -	IWCH_QP_QUERY_CONTEXT_QUIESCE = 0x4,
> -	IWCH_QP_QUERY_CONTEXT_REMOVE = 0x8,
> -	IWCH_QP_QUERY_TEST_USERWRITE = 0x32	/* Test special */
> -};
> -
> -u16 iwch_rqes_posted(struct iwch_qp *qhp);
> -int iwch_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
> -		   const struct ib_send_wr **bad_wr);
> -int iwch_post_receive(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
> -		      const struct ib_recv_wr **bad_wr);
> -int iwch_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
> -int iwch_post_terminate(struct iwch_qp *qhp, struct respQ_msg_t *rsp_msg);
> -int iwch_post_zb_read(struct iwch_ep *ep);
> -int iwch_register_device(struct iwch_dev *dev);
> -void iwch_unregister_device(struct iwch_dev *dev);
> -void stop_read_rep_timer(struct iwch_qp *qhp);
> -int iwch_register_mem(struct iwch_dev *rhp, struct iwch_pd *php,
> -		      struct iwch_mr *mhp, int shift);
> -int iwch_alloc_pbl(struct iwch_mr *mhp, int npages);
> -void iwch_free_pbl(struct iwch_mr *mhp);
> -int iwch_write_pbl(struct iwch_mr *mhp, __be64 *pages, int npages, int offset);
> -
> -#define IWCH_NODE_DESC "cxgb3 Chelsio Communications"
> -
> -#endif
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_qp.c b/drivers/infiniband/hw/cxgb3/iwch_qp.c
> deleted file mode 100644
> index c649faad63f9..000000000000
> --- a/drivers/infiniband/hw/cxgb3/iwch_qp.c
> +++ /dev/null
> @@ -1,1082 +0,0 @@
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#include <linux/sched.h>
> -#include <linux/gfp.h>
> -#include "iwch_provider.h"
> -#include "iwch.h"
> -#include "iwch_cm.h"
> -#include "cxio_hal.h"
> -#include "cxio_resource.h"
> -
> -#define NO_SUPPORT -1
> -
> -static int build_rdma_send(union t3_wr *wqe, const struct ib_send_wr *wr,
> -			   u8 *flit_cnt)
> -{
> -	int i;
> -	u32 plen;
> -
> -	switch (wr->opcode) {
> -	case IB_WR_SEND:
> -		if (wr->send_flags & IB_SEND_SOLICITED)
> -			wqe->send.rdmaop = T3_SEND_WITH_SE;
> -		else
> -			wqe->send.rdmaop = T3_SEND;
> -		wqe->send.rem_stag = 0;
> -		break;
> -	case IB_WR_SEND_WITH_INV:
> -		if (wr->send_flags & IB_SEND_SOLICITED)
> -			wqe->send.rdmaop = T3_SEND_WITH_SE_INV;
> -		else
> -			wqe->send.rdmaop = T3_SEND_WITH_INV;
> -		wqe->send.rem_stag = cpu_to_be32(wr->ex.invalidate_rkey);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	if (wr->num_sge > T3_MAX_SGE)
> -		return -EINVAL;
> -	wqe->send.reserved[0] = 0;
> -	wqe->send.reserved[1] = 0;
> -	wqe->send.reserved[2] = 0;
> -	plen = 0;
> -	for (i = 0; i < wr->num_sge; i++) {
> -		if ((plen + wr->sg_list[i].length) < plen)
> -			return -EMSGSIZE;
> -
> -		plen += wr->sg_list[i].length;
> -		wqe->send.sgl[i].stag = cpu_to_be32(wr->sg_list[i].lkey);
> -		wqe->send.sgl[i].len = cpu_to_be32(wr->sg_list[i].length);
> -		wqe->send.sgl[i].to = cpu_to_be64(wr->sg_list[i].addr);
> -	}
> -	wqe->send.num_sgle = cpu_to_be32(wr->num_sge);
> -	*flit_cnt = 4 + ((wr->num_sge) << 1);
> -	wqe->send.plen = cpu_to_be32(plen);
> -	return 0;
> -}
> -
> -static int build_rdma_write(union t3_wr *wqe, const struct ib_send_wr *wr,
> -			    u8 *flit_cnt)
> -{
> -	int i;
> -	u32 plen;
> -	if (wr->num_sge > T3_MAX_SGE)
> -		return -EINVAL;
> -	wqe->write.rdmaop = T3_RDMA_WRITE;
> -	wqe->write.reserved[0] = 0;
> -	wqe->write.reserved[1] = 0;
> -	wqe->write.reserved[2] = 0;
> -	wqe->write.stag_sink = cpu_to_be32(rdma_wr(wr)->rkey);
> -	wqe->write.to_sink = cpu_to_be64(rdma_wr(wr)->remote_addr);
> -
> -	if (wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM) {
> -		plen = 4;
> -		wqe->write.sgl[0].stag = wr->ex.imm_data;
> -		wqe->write.sgl[0].len = cpu_to_be32(0);
> -		wqe->write.num_sgle = cpu_to_be32(0);
> -		*flit_cnt = 6;
> -	} else {
> -		plen = 0;
> -		for (i = 0; i < wr->num_sge; i++) {
> -			if ((plen + wr->sg_list[i].length) < plen) {
> -				return -EMSGSIZE;
> -			}
> -			plen += wr->sg_list[i].length;
> -			wqe->write.sgl[i].stag =
> -			    cpu_to_be32(wr->sg_list[i].lkey);
> -			wqe->write.sgl[i].len =
> -			    cpu_to_be32(wr->sg_list[i].length);
> -			wqe->write.sgl[i].to =
> -			    cpu_to_be64(wr->sg_list[i].addr);
> -		}
> -		wqe->write.num_sgle = cpu_to_be32(wr->num_sge);
> -		*flit_cnt = 5 + ((wr->num_sge) << 1);
> -	}
> -	wqe->write.plen = cpu_to_be32(plen);
> -	return 0;
> -}
> -
> -static int build_rdma_read(union t3_wr *wqe, const struct ib_send_wr *wr,
> -			   u8 *flit_cnt)
> -{
> -	if (wr->num_sge > 1)
> -		return -EINVAL;
> -	wqe->read.rdmaop = T3_READ_REQ;
> -	if (wr->opcode == IB_WR_RDMA_READ_WITH_INV)
> -		wqe->read.local_inv = 1;
> -	else
> -		wqe->read.local_inv = 0;
> -	wqe->read.reserved[0] = 0;
> -	wqe->read.reserved[1] = 0;
> -	wqe->read.rem_stag = cpu_to_be32(rdma_wr(wr)->rkey);
> -	wqe->read.rem_to = cpu_to_be64(rdma_wr(wr)->remote_addr);
> -	wqe->read.local_stag = cpu_to_be32(wr->sg_list[0].lkey);
> -	wqe->read.local_len = cpu_to_be32(wr->sg_list[0].length);
> -	wqe->read.local_to = cpu_to_be64(wr->sg_list[0].addr);
> -	*flit_cnt = sizeof(struct t3_rdma_read_wr) >> 3;
> -	return 0;
> -}
> -
> -static int build_memreg(union t3_wr *wqe, const struct ib_reg_wr *wr,
> -			u8 *flit_cnt, int *wr_cnt, struct t3_wq *wq)
> -{
> -	struct iwch_mr *mhp = to_iwch_mr(wr->mr);
> -	int i;
> -	__be64 *p;
> -
> -	if (mhp->npages > T3_MAX_FASTREG_DEPTH)
> -		return -EINVAL;
> -	*wr_cnt = 1;
> -	wqe->fastreg.stag = cpu_to_be32(wr->key);
> -	wqe->fastreg.len = cpu_to_be32(mhp->ibmr.length);
> -	wqe->fastreg.va_base_hi = cpu_to_be32(mhp->ibmr.iova >> 32);
> -	wqe->fastreg.va_base_lo_fbo =
> -				cpu_to_be32(mhp->ibmr.iova & 0xffffffff);
> -	wqe->fastreg.page_type_perms = cpu_to_be32(
> -		V_FR_PAGE_COUNT(mhp->npages) |
> -		V_FR_PAGE_SIZE(ilog2(wr->mr->page_size) - 12) |
> -		V_FR_TYPE(TPT_VATO) |
> -		V_FR_PERMS(iwch_ib_to_tpt_access(wr->access)));
> -	p = &wqe->fastreg.pbl_addrs[0];
> -	for (i = 0; i < mhp->npages; i++, p++) {
> -
> -		/* If we need a 2nd WR, then set it up */
> -		if (i == T3_MAX_FASTREG_FRAG) {
> -			*wr_cnt = 2;
> -			wqe = (union t3_wr *)(wq->queue +
> -				Q_PTR2IDX((wq->wptr+1), wq->size_log2));
> -			build_fw_riwrh((void *)wqe, T3_WR_FASTREG, 0,
> -			       Q_GENBIT(wq->wptr + 1, wq->size_log2),
> -			       0, 1 + mhp->npages - T3_MAX_FASTREG_FRAG,
> -			       T3_EOP);
> -
> -			p = &wqe->pbl_frag.pbl_addrs[0];
> -		}
> -		*p = cpu_to_be64((u64)mhp->pages[i]);
> -	}
> -	*flit_cnt = 5 + mhp->npages;
> -	if (*flit_cnt > 15)
> -		*flit_cnt = 15;
> -	return 0;
> -}
> -
> -static int build_inv_stag(union t3_wr *wqe, const struct ib_send_wr *wr,
> -			  u8 *flit_cnt)
> -{
> -	wqe->local_inv.stag = cpu_to_be32(wr->ex.invalidate_rkey);
> -	wqe->local_inv.reserved = 0;
> -	*flit_cnt = sizeof(struct t3_local_inv_wr) >> 3;
> -	return 0;
> -}
> -
> -static int iwch_sgl2pbl_map(struct iwch_dev *rhp, struct ib_sge *sg_list,
> -			    u32 num_sgle, u32 * pbl_addr, u8 * page_size)
> -{
> -	int i;
> -	struct iwch_mr *mhp;
> -	u64 offset;
> -	for (i = 0; i < num_sgle; i++) {
> -
> -		mhp = get_mhp(rhp, (sg_list[i].lkey) >> 8);
> -		if (!mhp) {
> -			pr_debug("%s %d\n", __func__, __LINE__);
> -			return -EIO;
> -		}
> -		if (!mhp->attr.state) {
> -			pr_debug("%s %d\n", __func__, __LINE__);
> -			return -EIO;
> -		}
> -		if (mhp->attr.zbva) {
> -			pr_debug("%s %d\n", __func__, __LINE__);
> -			return -EIO;
> -		}
> -
> -		if (sg_list[i].addr < mhp->attr.va_fbo) {
> -			pr_debug("%s %d\n", __func__, __LINE__);
> -			return -EINVAL;
> -		}
> -		if (sg_list[i].addr + ((u64) sg_list[i].length) <
> -		    sg_list[i].addr) {
> -			pr_debug("%s %d\n", __func__, __LINE__);
> -			return -EINVAL;
> -		}
> -		if (sg_list[i].addr + ((u64) sg_list[i].length) >
> -		    mhp->attr.va_fbo + ((u64) mhp->attr.len)) {
> -			pr_debug("%s %d\n", __func__, __LINE__);
> -			return -EINVAL;
> -		}
> -		offset = sg_list[i].addr - mhp->attr.va_fbo;
> -		offset += mhp->attr.va_fbo &
> -			  ((1UL << (12 + mhp->attr.page_size)) - 1);
> -		pbl_addr[i] = ((mhp->attr.pbl_addr -
> -			        rhp->rdev.rnic_info.pbl_base) >> 3) +
> -			      (offset >> (12 + mhp->attr.page_size));
> -		page_size[i] = mhp->attr.page_size;
> -	}
> -	return 0;
> -}
> -
> -static int build_rdma_recv(struct iwch_qp *qhp, union t3_wr *wqe,
> -			   const struct ib_recv_wr *wr)
> -{
> -	int i, err = 0;
> -	u32 pbl_addr[T3_MAX_SGE];
> -	u8 page_size[T3_MAX_SGE];
> -
> -	err = iwch_sgl2pbl_map(qhp->rhp, wr->sg_list, wr->num_sge, pbl_addr,
> -			       page_size);
> -	if (err)
> -		return err;
> -	wqe->recv.pagesz[0] = page_size[0];
> -	wqe->recv.pagesz[1] = page_size[1];
> -	wqe->recv.pagesz[2] = page_size[2];
> -	wqe->recv.pagesz[3] = page_size[3];
> -	wqe->recv.num_sgle = cpu_to_be32(wr->num_sge);
> -	for (i = 0; i < wr->num_sge; i++) {
> -		wqe->recv.sgl[i].stag = cpu_to_be32(wr->sg_list[i].lkey);
> -		wqe->recv.sgl[i].len = cpu_to_be32(wr->sg_list[i].length);
> -
> -		/* to in the WQE == the offset into the page */
> -		wqe->recv.sgl[i].to = cpu_to_be64(((u32)wr->sg_list[i].addr) &
> -				((1UL << (12 + page_size[i])) - 1));
> -
> -		/* pbl_addr is the adapters address in the PBL */
> -		wqe->recv.pbl_addr[i] = cpu_to_be32(pbl_addr[i]);
> -	}
> -	for (; i < T3_MAX_SGE; i++) {
> -		wqe->recv.sgl[i].stag = 0;
> -		wqe->recv.sgl[i].len = 0;
> -		wqe->recv.sgl[i].to = 0;
> -		wqe->recv.pbl_addr[i] = 0;
> -	}
> -	qhp->wq.rq[Q_PTR2IDX(qhp->wq.rq_wptr,
> -			     qhp->wq.rq_size_log2)].wr_id = wr->wr_id;
> -	qhp->wq.rq[Q_PTR2IDX(qhp->wq.rq_wptr,
> -			     qhp->wq.rq_size_log2)].pbl_addr = 0;
> -	return 0;
> -}
> -
> -static int build_zero_stag_recv(struct iwch_qp *qhp, union t3_wr *wqe,
> -				const struct ib_recv_wr *wr)
> -{
> -	int i;
> -	u32 pbl_addr;
> -	u32 pbl_offset;
> -
> -
> -	/*
> -	 * The T3 HW requires the PBL in the HW recv descriptor to reference
> -	 * a PBL entry.  So we allocate the max needed PBL memory here and pass
> -	 * it to the uP in the recv WR.  The uP will build the PBL and setup
> -	 * the HW recv descriptor.
> -	 */
> -	pbl_addr = cxio_hal_pblpool_alloc(&qhp->rhp->rdev, T3_STAG0_PBL_SIZE);
> -	if (!pbl_addr)
> -		return -ENOMEM;
> -
> -	/*
> -	 * Compute the 8B aligned offset.
> -	 */
> -	pbl_offset = (pbl_addr - qhp->rhp->rdev.rnic_info.pbl_base) >> 3;
> -
> -	wqe->recv.num_sgle = cpu_to_be32(wr->num_sge);
> -
> -	for (i = 0; i < wr->num_sge; i++) {
> -
> -		/*
> -		 * Use a 128MB page size. This and an imposed 128MB
> -		 * sge length limit allows us to require only a 2-entry HW
> -		 * PBL for each SGE.  This restriction is acceptable since
> -		 * since it is not possible to allocate 128MB of contiguous
> -		 * DMA coherent memory!
> -		 */
> -		if (wr->sg_list[i].length > T3_STAG0_MAX_PBE_LEN)
> -			return -EINVAL;
> -		wqe->recv.pagesz[i] = T3_STAG0_PAGE_SHIFT;
> -
> -		/*
> -		 * T3 restricts a recv to all zero-stag or all non-zero-stag.
> -		 */
> -		if (wr->sg_list[i].lkey != 0)
> -			return -EINVAL;
> -		wqe->recv.sgl[i].stag = 0;
> -		wqe->recv.sgl[i].len = cpu_to_be32(wr->sg_list[i].length);
> -		wqe->recv.sgl[i].to = cpu_to_be64(wr->sg_list[i].addr);
> -		wqe->recv.pbl_addr[i] = cpu_to_be32(pbl_offset);
> -		pbl_offset += 2;
> -	}
> -	for (; i < T3_MAX_SGE; i++) {
> -		wqe->recv.pagesz[i] = 0;
> -		wqe->recv.sgl[i].stag = 0;
> -		wqe->recv.sgl[i].len = 0;
> -		wqe->recv.sgl[i].to = 0;
> -		wqe->recv.pbl_addr[i] = 0;
> -	}
> -	qhp->wq.rq[Q_PTR2IDX(qhp->wq.rq_wptr,
> -			     qhp->wq.rq_size_log2)].wr_id = wr->wr_id;
> -	qhp->wq.rq[Q_PTR2IDX(qhp->wq.rq_wptr,
> -			     qhp->wq.rq_size_log2)].pbl_addr = pbl_addr;
> -	return 0;
> -}
> -
> -int iwch_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
> -		   const struct ib_send_wr **bad_wr)
> -{
> -	int err = 0;
> -	u8 uninitialized_var(t3_wr_flit_cnt);
> -	enum t3_wr_opcode t3_wr_opcode = 0;
> -	enum t3_wr_flags t3_wr_flags;
> -	struct iwch_qp *qhp;
> -	u32 idx;
> -	union t3_wr *wqe;
> -	u32 num_wrs;
> -	unsigned long flag;
> -	struct t3_swsq *sqp;
> -	int wr_cnt = 1;
> -
> -	qhp = to_iwch_qp(ibqp);
> -	spin_lock_irqsave(&qhp->lock, flag);
> -	if (qhp->attr.state > IWCH_QP_STATE_RTS) {
> -		spin_unlock_irqrestore(&qhp->lock, flag);
> -		err = -EINVAL;
> -		goto out;
> -	}
> -	num_wrs = Q_FREECNT(qhp->wq.sq_rptr, qhp->wq.sq_wptr,
> -		  qhp->wq.sq_size_log2);
> -	if (num_wrs == 0) {
> -		spin_unlock_irqrestore(&qhp->lock, flag);
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -	while (wr) {
> -		if (num_wrs == 0) {
> -			err = -ENOMEM;
> -			break;
> -		}
> -		idx = Q_PTR2IDX(qhp->wq.wptr, qhp->wq.size_log2);
> -		wqe = (union t3_wr *) (qhp->wq.queue + idx);
> -		t3_wr_flags = 0;
> -		if (wr->send_flags & IB_SEND_SOLICITED)
> -			t3_wr_flags |= T3_SOLICITED_EVENT_FLAG;
> -		if (wr->send_flags & IB_SEND_SIGNALED)
> -			t3_wr_flags |= T3_COMPLETION_FLAG;
> -		sqp = qhp->wq.sq +
> -		      Q_PTR2IDX(qhp->wq.sq_wptr, qhp->wq.sq_size_log2);
> -		switch (wr->opcode) {
> -		case IB_WR_SEND:
> -		case IB_WR_SEND_WITH_INV:
> -			if (wr->send_flags & IB_SEND_FENCE)
> -				t3_wr_flags |= T3_READ_FENCE_FLAG;
> -			t3_wr_opcode = T3_WR_SEND;
> -			err = build_rdma_send(wqe, wr, &t3_wr_flit_cnt);
> -			break;
> -		case IB_WR_RDMA_WRITE:
> -		case IB_WR_RDMA_WRITE_WITH_IMM:
> -			t3_wr_opcode = T3_WR_WRITE;
> -			err = build_rdma_write(wqe, wr, &t3_wr_flit_cnt);
> -			break;
> -		case IB_WR_RDMA_READ:
> -		case IB_WR_RDMA_READ_WITH_INV:
> -			t3_wr_opcode = T3_WR_READ;
> -			t3_wr_flags = 0; /* T3 reads are always signaled */
> -			err = build_rdma_read(wqe, wr, &t3_wr_flit_cnt);
> -			if (err)
> -				break;
> -			sqp->read_len = wqe->read.local_len;
> -			if (!qhp->wq.oldest_read)
> -				qhp->wq.oldest_read = sqp;
> -			break;
> -		case IB_WR_REG_MR:
> -			t3_wr_opcode = T3_WR_FASTREG;
> -			err = build_memreg(wqe, reg_wr(wr), &t3_wr_flit_cnt,
> -					   &wr_cnt, &qhp->wq);
> -			break;
> -		case IB_WR_LOCAL_INV:
> -			if (wr->send_flags & IB_SEND_FENCE)
> -				t3_wr_flags |= T3_LOCAL_FENCE_FLAG;
> -			t3_wr_opcode = T3_WR_INV_STAG;
> -			err = build_inv_stag(wqe, wr, &t3_wr_flit_cnt);
> -			break;
> -		default:
> -			pr_debug("%s post of type=%d TBD!\n", __func__,
> -				 wr->opcode);
> -			err = -EINVAL;
> -		}
> -		if (err)
> -			break;
> -		wqe->send.wrid.id0.hi = qhp->wq.sq_wptr;
> -		sqp->wr_id = wr->wr_id;
> -		sqp->opcode = wr2opcode(t3_wr_opcode);
> -		sqp->sq_wptr = qhp->wq.sq_wptr;
> -		sqp->complete = 0;
> -		sqp->signaled = (wr->send_flags & IB_SEND_SIGNALED);
> -
> -		build_fw_riwrh((void *) wqe, t3_wr_opcode, t3_wr_flags,
> -			       Q_GENBIT(qhp->wq.wptr, qhp->wq.size_log2),
> -			       0, t3_wr_flit_cnt,
> -			       (wr_cnt == 1) ? T3_SOPEOP : T3_SOP);
> -		pr_debug("%s cookie 0x%llx wq idx 0x%x swsq idx %ld opcode %d\n",
> -			 __func__, (unsigned long long)wr->wr_id, idx,
> -			 Q_PTR2IDX(qhp->wq.sq_wptr, qhp->wq.sq_size_log2),
> -			 sqp->opcode);
> -		wr = wr->next;
> -		num_wrs--;
> -		qhp->wq.wptr += wr_cnt;
> -		++(qhp->wq.sq_wptr);
> -	}
> -	spin_unlock_irqrestore(&qhp->lock, flag);
> -	if (cxio_wq_db_enabled(&qhp->wq))
> -		ring_doorbell(qhp->wq.doorbell, qhp->wq.qpid);
> -
> -out:
> -	if (err)
> -		*bad_wr = wr;
> -	return err;
> -}
> -
> -int iwch_post_receive(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
> -		      const struct ib_recv_wr **bad_wr)
> -{
> -	int err = 0;
> -	struct iwch_qp *qhp;
> -	u32 idx;
> -	union t3_wr *wqe;
> -	u32 num_wrs;
> -	unsigned long flag;
> -
> -	qhp = to_iwch_qp(ibqp);
> -	spin_lock_irqsave(&qhp->lock, flag);
> -	if (qhp->attr.state > IWCH_QP_STATE_RTS) {
> -		spin_unlock_irqrestore(&qhp->lock, flag);
> -		err = -EINVAL;
> -		goto out;
> -	}
> -	num_wrs = Q_FREECNT(qhp->wq.rq_rptr, qhp->wq.rq_wptr,
> -			    qhp->wq.rq_size_log2) - 1;
> -	if (!wr) {
> -		spin_unlock_irqrestore(&qhp->lock, flag);
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -	while (wr) {
> -		if (wr->num_sge > T3_MAX_SGE) {
> -			err = -EINVAL;
> -			break;
> -		}
> -		idx = Q_PTR2IDX(qhp->wq.wptr, qhp->wq.size_log2);
> -		wqe = (union t3_wr *) (qhp->wq.queue + idx);
> -		if (num_wrs)
> -			if (wr->sg_list[0].lkey)
> -				err = build_rdma_recv(qhp, wqe, wr);
> -			else
> -				err = build_zero_stag_recv(qhp, wqe, wr);
> -		else
> -			err = -ENOMEM;
> -
> -		if (err)
> -			break;
> -
> -		build_fw_riwrh((void *) wqe, T3_WR_RCV, T3_COMPLETION_FLAG,
> -			       Q_GENBIT(qhp->wq.wptr, qhp->wq.size_log2),
> -			       0, sizeof(struct t3_receive_wr) >> 3, T3_SOPEOP);
> -		pr_debug("%s cookie 0x%llx idx 0x%x rq_wptr 0x%x rw_rptr 0x%x wqe %p\n",
> -			 __func__, (unsigned long long)wr->wr_id,
> -			 idx, qhp->wq.rq_wptr, qhp->wq.rq_rptr, wqe);
> -		++(qhp->wq.rq_wptr);
> -		++(qhp->wq.wptr);
> -		wr = wr->next;
> -		num_wrs--;
> -	}
> -	spin_unlock_irqrestore(&qhp->lock, flag);
> -	if (cxio_wq_db_enabled(&qhp->wq))
> -		ring_doorbell(qhp->wq.doorbell, qhp->wq.qpid);
> -
> -out:
> -	if (err)
> -		*bad_wr = wr;
> -	return err;
> -}
> -
> -static inline void build_term_codes(struct respQ_msg_t *rsp_msg,
> -				    u8 *layer_type, u8 *ecode)
> -{
> -	int status = TPT_ERR_INTERNAL_ERR;
> -	int tagged = 0;
> -	int opcode = -1;
> -	int rqtype = 0;
> -	int send_inv = 0;
> -
> -	if (rsp_msg) {
> -		status = CQE_STATUS(rsp_msg->cqe);
> -		opcode = CQE_OPCODE(rsp_msg->cqe);
> -		rqtype = RQ_TYPE(rsp_msg->cqe);
> -		send_inv = (opcode == T3_SEND_WITH_INV) ||
> -		           (opcode == T3_SEND_WITH_SE_INV);
> -		tagged = (opcode == T3_RDMA_WRITE) ||
> -			 (rqtype && (opcode == T3_READ_RESP));
> -	}
> -
> -	switch (status) {
> -	case TPT_ERR_STAG:
> -		if (send_inv) {
> -			*layer_type = LAYER_RDMAP|RDMAP_REMOTE_OP;
> -			*ecode = RDMAP_CANT_INV_STAG;
> -		} else {
> -			*layer_type = LAYER_RDMAP|RDMAP_REMOTE_PROT;
> -			*ecode = RDMAP_INV_STAG;
> -		}
> -		break;
> -	case TPT_ERR_PDID:
> -		*layer_type = LAYER_RDMAP|RDMAP_REMOTE_PROT;
> -		if ((opcode == T3_SEND_WITH_INV) ||
> -		    (opcode == T3_SEND_WITH_SE_INV))
> -			*ecode = RDMAP_CANT_INV_STAG;
> -		else
> -			*ecode = RDMAP_STAG_NOT_ASSOC;
> -		break;
> -	case TPT_ERR_QPID:
> -		*layer_type = LAYER_RDMAP|RDMAP_REMOTE_PROT;
> -		*ecode = RDMAP_STAG_NOT_ASSOC;
> -		break;
> -	case TPT_ERR_ACCESS:
> -		*layer_type = LAYER_RDMAP|RDMAP_REMOTE_PROT;
> -		*ecode = RDMAP_ACC_VIOL;
> -		break;
> -	case TPT_ERR_WRAP:
> -		*layer_type = LAYER_RDMAP|RDMAP_REMOTE_PROT;
> -		*ecode = RDMAP_TO_WRAP;
> -		break;
> -	case TPT_ERR_BOUND:
> -		if (tagged) {
> -			*layer_type = LAYER_DDP|DDP_TAGGED_ERR;
> -			*ecode = DDPT_BASE_BOUNDS;
> -		} else {
> -			*layer_type = LAYER_RDMAP|RDMAP_REMOTE_PROT;
> -			*ecode = RDMAP_BASE_BOUNDS;
> -		}
> -		break;
> -	case TPT_ERR_INVALIDATE_SHARED_MR:
> -	case TPT_ERR_INVALIDATE_MR_WITH_MW_BOUND:
> -		*layer_type = LAYER_RDMAP|RDMAP_REMOTE_OP;
> -		*ecode = RDMAP_CANT_INV_STAG;
> -		break;
> -	case TPT_ERR_ECC:
> -	case TPT_ERR_ECC_PSTAG:
> -	case TPT_ERR_INTERNAL_ERR:
> -		*layer_type = LAYER_RDMAP|RDMAP_LOCAL_CATA;
> -		*ecode = 0;
> -		break;
> -	case TPT_ERR_OUT_OF_RQE:
> -		*layer_type = LAYER_DDP|DDP_UNTAGGED_ERR;
> -		*ecode = DDPU_INV_MSN_NOBUF;
> -		break;
> -	case TPT_ERR_PBL_ADDR_BOUND:
> -		*layer_type = LAYER_DDP|DDP_TAGGED_ERR;
> -		*ecode = DDPT_BASE_BOUNDS;
> -		break;
> -	case TPT_ERR_CRC:
> -		*layer_type = LAYER_MPA|DDP_LLP;
> -		*ecode = MPA_CRC_ERR;
> -		break;
> -	case TPT_ERR_MARKER:
> -		*layer_type = LAYER_MPA|DDP_LLP;
> -		*ecode = MPA_MARKER_ERR;
> -		break;
> -	case TPT_ERR_PDU_LEN_ERR:
> -		*layer_type = LAYER_DDP|DDP_UNTAGGED_ERR;
> -		*ecode = DDPU_MSG_TOOBIG;
> -		break;
> -	case TPT_ERR_DDP_VERSION:
> -		if (tagged) {
> -			*layer_type = LAYER_DDP|DDP_TAGGED_ERR;
> -			*ecode = DDPT_INV_VERS;
> -		} else {
> -			*layer_type = LAYER_DDP|DDP_UNTAGGED_ERR;
> -			*ecode = DDPU_INV_VERS;
> -		}
> -		break;
> -	case TPT_ERR_RDMA_VERSION:
> -		*layer_type = LAYER_RDMAP|RDMAP_REMOTE_OP;
> -		*ecode = RDMAP_INV_VERS;
> -		break;
> -	case TPT_ERR_OPCODE:
> -		*layer_type = LAYER_RDMAP|RDMAP_REMOTE_OP;
> -		*ecode = RDMAP_INV_OPCODE;
> -		break;
> -	case TPT_ERR_DDP_QUEUE_NUM:
> -		*layer_type = LAYER_DDP|DDP_UNTAGGED_ERR;
> -		*ecode = DDPU_INV_QN;
> -		break;
> -	case TPT_ERR_MSN:
> -	case TPT_ERR_MSN_GAP:
> -	case TPT_ERR_MSN_RANGE:
> -	case TPT_ERR_IRD_OVERFLOW:
> -		*layer_type = LAYER_DDP|DDP_UNTAGGED_ERR;
> -		*ecode = DDPU_INV_MSN_RANGE;
> -		break;
> -	case TPT_ERR_TBIT:
> -		*layer_type = LAYER_DDP|DDP_LOCAL_CATA;
> -		*ecode = 0;
> -		break;
> -	case TPT_ERR_MO:
> -		*layer_type = LAYER_DDP|DDP_UNTAGGED_ERR;
> -		*ecode = DDPU_INV_MO;
> -		break;
> -	default:
> -		*layer_type = LAYER_RDMAP|DDP_LOCAL_CATA;
> -		*ecode = 0;
> -		break;
> -	}
> -}
> -
> -int iwch_post_zb_read(struct iwch_ep *ep)
> -{
> -	union t3_wr *wqe;
> -	struct sk_buff *skb;
> -	u8 flit_cnt = sizeof(struct t3_rdma_read_wr) >> 3;
> -
> -	pr_debug("%s enter\n", __func__);
> -	skb = alloc_skb(40, GFP_KERNEL);
> -	if (!skb) {
> -		pr_err("%s cannot send zb_read!!\n", __func__);
> -		return -ENOMEM;
> -	}
> -	wqe = skb_put_zero(skb, sizeof(struct t3_rdma_read_wr));
> -	wqe->read.rdmaop = T3_READ_REQ;
> -	wqe->read.reserved[0] = 0;
> -	wqe->read.reserved[1] = 0;
> -	wqe->read.rem_stag = cpu_to_be32(1);
> -	wqe->read.rem_to = cpu_to_be64(1);
> -	wqe->read.local_stag = cpu_to_be32(1);
> -	wqe->read.local_len = cpu_to_be32(0);
> -	wqe->read.local_to = cpu_to_be64(1);
> -	wqe->send.wrh.op_seop_flags = cpu_to_be32(V_FW_RIWR_OP(T3_WR_READ));
> -	wqe->send.wrh.gen_tid_len = cpu_to_be32(V_FW_RIWR_TID(ep->hwtid)|
> -						V_FW_RIWR_LEN(flit_cnt));
> -	skb->priority = CPL_PRIORITY_DATA;
> -	return iwch_cxgb3_ofld_send(ep->com.qp->rhp->rdev.t3cdev_p, skb);
> -}
> -
> -/*
> - * This posts a TERMINATE with layer=RDMA, type=catastrophic.
> - */
> -int iwch_post_terminate(struct iwch_qp *qhp, struct respQ_msg_t *rsp_msg)
> -{
> -	union t3_wr *wqe;
> -	struct terminate_message *term;
> -	struct sk_buff *skb;
> -
> -	pr_debug("%s %d\n", __func__, __LINE__);
> -	skb = alloc_skb(40, GFP_ATOMIC);
> -	if (!skb) {
> -		pr_err("%s cannot send TERMINATE!\n", __func__);
> -		return -ENOMEM;
> -	}
> -	wqe = skb_put_zero(skb, 40);
> -	wqe->send.rdmaop = T3_TERMINATE;
> -
> -	/* immediate data length */
> -	wqe->send.plen = htonl(4);
> -
> -	/* immediate data starts here. */
> -	term = (struct terminate_message *)wqe->send.sgl;
> -	build_term_codes(rsp_msg, &term->layer_etype, &term->ecode);
> -	wqe->send.wrh.op_seop_flags = cpu_to_be32(V_FW_RIWR_OP(T3_WR_SEND) |
> -			 V_FW_RIWR_FLAGS(T3_COMPLETION_FLAG | T3_NOTIFY_FLAG));
> -	wqe->send.wrh.gen_tid_len = cpu_to_be32(V_FW_RIWR_TID(qhp->ep->hwtid));
> -	skb->priority = CPL_PRIORITY_DATA;
> -	return iwch_cxgb3_ofld_send(qhp->rhp->rdev.t3cdev_p, skb);
> -}
> -
> -/*
> - * Assumes qhp lock is held.
> - */
> -static void __flush_qp(struct iwch_qp *qhp, struct iwch_cq *rchp,
> -				struct iwch_cq *schp)
> -	__releases(&qhp->lock)
> -	__acquires(&qhp->lock)
> -{
> -	int count;
> -	int flushed;
> -
> -	lockdep_assert_held(&qhp->lock);
> -
> -	pr_debug("%s qhp %p rchp %p schp %p\n", __func__, qhp, rchp, schp);
> -	/* take a ref on the qhp since we must release the lock */
> -	atomic_inc(&qhp->refcnt);
> -	spin_unlock(&qhp->lock);
> -
> -	/* locking hierarchy: cq lock first, then qp lock. */
> -	spin_lock(&rchp->lock);
> -	spin_lock(&qhp->lock);
> -	cxio_flush_hw_cq(&rchp->cq);
> -	cxio_count_rcqes(&rchp->cq, &qhp->wq, &count);
> -	flushed = cxio_flush_rq(&qhp->wq, &rchp->cq, count);
> -	spin_unlock(&qhp->lock);
> -	spin_unlock(&rchp->lock);
> -	if (flushed) {
> -		spin_lock(&rchp->comp_handler_lock);
> -		(*rchp->ibcq.comp_handler)(&rchp->ibcq, rchp->ibcq.cq_context);
> -		spin_unlock(&rchp->comp_handler_lock);
> -	}
> -
> -	/* locking hierarchy: cq lock first, then qp lock. */
> -	spin_lock(&schp->lock);
> -	spin_lock(&qhp->lock);
> -	cxio_flush_hw_cq(&schp->cq);
> -	cxio_count_scqes(&schp->cq, &qhp->wq, &count);
> -	flushed = cxio_flush_sq(&qhp->wq, &schp->cq, count);
> -	spin_unlock(&qhp->lock);
> -	spin_unlock(&schp->lock);
> -	if (flushed) {
> -		spin_lock(&schp->comp_handler_lock);
> -		(*schp->ibcq.comp_handler)(&schp->ibcq, schp->ibcq.cq_context);
> -		spin_unlock(&schp->comp_handler_lock);
> -	}
> -
> -	/* deref */
> -	if (atomic_dec_and_test(&qhp->refcnt))
> -	        wake_up(&qhp->wait);
> -
> -	spin_lock(&qhp->lock);
> -}
> -
> -static void flush_qp(struct iwch_qp *qhp)
> -{
> -	struct iwch_cq *rchp, *schp;
> -
> -	rchp = get_chp(qhp->rhp, qhp->attr.rcq);
> -	schp = get_chp(qhp->rhp, qhp->attr.scq);
> -
> -	if (qhp->ibqp.uobject) {
> -		cxio_set_wq_in_error(&qhp->wq);
> -		cxio_set_cq_in_error(&rchp->cq);
> -		spin_lock(&rchp->comp_handler_lock);
> -		(*rchp->ibcq.comp_handler)(&rchp->ibcq, rchp->ibcq.cq_context);
> -		spin_unlock(&rchp->comp_handler_lock);
> -		if (schp != rchp) {
> -			cxio_set_cq_in_error(&schp->cq);
> -			spin_lock(&schp->comp_handler_lock);
> -			(*schp->ibcq.comp_handler)(&schp->ibcq,
> -						   schp->ibcq.cq_context);
> -			spin_unlock(&schp->comp_handler_lock);
> -		}
> -		return;
> -	}
> -	__flush_qp(qhp, rchp, schp);
> -}
> -
> -
> -/*
> - * Return count of RECV WRs posted
> - */
> -u16 iwch_rqes_posted(struct iwch_qp *qhp)
> -{
> -	union t3_wr *wqe = qhp->wq.queue;
> -	u16 count = 0;
> -
> -	while (count < USHRT_MAX && fw_riwrh_opcode((struct fw_riwrh *)wqe) == T3_WR_RCV) {
> -		count++;
> -		wqe++;
> -	}
> -	pr_debug("%s qhp %p count %u\n", __func__, qhp, count);
> -	return count;
> -}
> -
> -static int rdma_init(struct iwch_dev *rhp, struct iwch_qp *qhp,
> -				enum iwch_qp_attr_mask mask,
> -				struct iwch_qp_attributes *attrs)
> -{
> -	struct t3_rdma_init_attr init_attr;
> -	int ret;
> -
> -	init_attr.tid = qhp->ep->hwtid;
> -	init_attr.qpid = qhp->wq.qpid;
> -	init_attr.pdid = qhp->attr.pd;
> -	init_attr.scqid = qhp->attr.scq;
> -	init_attr.rcqid = qhp->attr.rcq;
> -	init_attr.rq_addr = qhp->wq.rq_addr;
> -	init_attr.rq_size = 1 << qhp->wq.rq_size_log2;
> -	init_attr.mpaattrs = uP_RI_MPA_IETF_ENABLE |
> -		qhp->attr.mpa_attr.recv_marker_enabled |
> -		(qhp->attr.mpa_attr.xmit_marker_enabled << 1) |
> -		(qhp->attr.mpa_attr.crc_enabled << 2);
> -
> -	init_attr.qpcaps = uP_RI_QP_RDMA_READ_ENABLE |
> -			   uP_RI_QP_RDMA_WRITE_ENABLE |
> -			   uP_RI_QP_BIND_ENABLE;
> -	if (!qhp->ibqp.uobject)
> -		init_attr.qpcaps |= uP_RI_QP_STAG0_ENABLE |
> -				    uP_RI_QP_FAST_REGISTER_ENABLE;
> -
> -	init_attr.tcp_emss = qhp->ep->emss;
> -	init_attr.ord = qhp->attr.max_ord;
> -	init_attr.ird = qhp->attr.max_ird;
> -	init_attr.qp_dma_addr = qhp->wq.dma_addr;
> -	init_attr.qp_dma_size = (1UL << qhp->wq.size_log2);
> -	init_attr.rqe_count = iwch_rqes_posted(qhp);
> -	init_attr.flags = qhp->attr.mpa_attr.initiator ? MPA_INITIATOR : 0;
> -	init_attr.chan = qhp->ep->l2t->smt_idx;
> -	if (peer2peer) {
> -		init_attr.rtr_type = RTR_READ;
> -		if (init_attr.ord == 0 && qhp->attr.mpa_attr.initiator)
> -			init_attr.ord = 1;
> -		if (init_attr.ird == 0 && !qhp->attr.mpa_attr.initiator)
> -			init_attr.ird = 1;
> -	} else
> -		init_attr.rtr_type = 0;
> -	init_attr.irs = qhp->ep->rcv_seq;
> -	pr_debug("%s init_attr.rq_addr 0x%x init_attr.rq_size = %d flags 0x%x qpcaps 0x%x\n",
> -		 __func__,
> -		 init_attr.rq_addr, init_attr.rq_size,
> -		 init_attr.flags, init_attr.qpcaps);
> -	ret = cxio_rdma_init(&rhp->rdev, &init_attr);
> -	pr_debug("%s ret %d\n", __func__, ret);
> -	return ret;
> -}
> -
> -int iwch_modify_qp(struct iwch_dev *rhp, struct iwch_qp *qhp,
> -				enum iwch_qp_attr_mask mask,
> -				struct iwch_qp_attributes *attrs,
> -				int internal)
> -{
> -	int ret = 0;
> -	struct iwch_qp_attributes newattr = qhp->attr;
> -	unsigned long flag;
> -	int disconnect = 0;
> -	int terminate = 0;
> -	int abort = 0;
> -	int free = 0;
> -	struct iwch_ep *ep = NULL;
> -
> -	pr_debug("%s qhp %p qpid 0x%x ep %p state %d -> %d\n", __func__,
> -		 qhp, qhp->wq.qpid, qhp->ep, qhp->attr.state,
> -		 (mask & IWCH_QP_ATTR_NEXT_STATE) ? attrs->next_state : -1);
> -
> -	spin_lock_irqsave(&qhp->lock, flag);
> -
> -	/* Process attr changes if in IDLE */
> -	if (mask & IWCH_QP_ATTR_VALID_MODIFY) {
> -		if (qhp->attr.state != IWCH_QP_STATE_IDLE) {
> -			ret = -EIO;
> -			goto out;
> -		}
> -		if (mask & IWCH_QP_ATTR_ENABLE_RDMA_READ)
> -			newattr.enable_rdma_read = attrs->enable_rdma_read;
> -		if (mask & IWCH_QP_ATTR_ENABLE_RDMA_WRITE)
> -			newattr.enable_rdma_write = attrs->enable_rdma_write;
> -		if (mask & IWCH_QP_ATTR_ENABLE_RDMA_BIND)
> -			newattr.enable_bind = attrs->enable_bind;
> -		if (mask & IWCH_QP_ATTR_MAX_ORD) {
> -			if (attrs->max_ord >
> -			    rhp->attr.max_rdma_read_qp_depth) {
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -			newattr.max_ord = attrs->max_ord;
> -		}
> -		if (mask & IWCH_QP_ATTR_MAX_IRD) {
> -			if (attrs->max_ird >
> -			    rhp->attr.max_rdma_reads_per_qp) {
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -			newattr.max_ird = attrs->max_ird;
> -		}
> -		qhp->attr = newattr;
> -	}
> -
> -	if (!(mask & IWCH_QP_ATTR_NEXT_STATE))
> -		goto out;
> -	if (qhp->attr.state == attrs->next_state)
> -		goto out;
> -
> -	switch (qhp->attr.state) {
> -	case IWCH_QP_STATE_IDLE:
> -		switch (attrs->next_state) {
> -		case IWCH_QP_STATE_RTS:
> -			if (!(mask & IWCH_QP_ATTR_LLP_STREAM_HANDLE)) {
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -			if (!(mask & IWCH_QP_ATTR_MPA_ATTR)) {
> -				ret = -EINVAL;
> -				goto out;
> -			}
> -			qhp->attr.mpa_attr = attrs->mpa_attr;
> -			qhp->attr.llp_stream_handle = attrs->llp_stream_handle;
> -			qhp->ep = qhp->attr.llp_stream_handle;
> -			qhp->attr.state = IWCH_QP_STATE_RTS;
> -
> -			/*
> -			 * Ref the endpoint here and deref when we
> -			 * disassociate the endpoint from the QP.  This
> -			 * happens in CLOSING->IDLE transition or *->ERROR
> -			 * transition.
> -			 */
> -			get_ep(&qhp->ep->com);
> -			spin_unlock_irqrestore(&qhp->lock, flag);
> -			ret = rdma_init(rhp, qhp, mask, attrs);
> -			spin_lock_irqsave(&qhp->lock, flag);
> -			if (ret)
> -				goto err;
> -			break;
> -		case IWCH_QP_STATE_ERROR:
> -			qhp->attr.state = IWCH_QP_STATE_ERROR;
> -			flush_qp(qhp);
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		break;
> -	case IWCH_QP_STATE_RTS:
> -		switch (attrs->next_state) {
> -		case IWCH_QP_STATE_CLOSING:
> -			BUG_ON(kref_read(&qhp->ep->com.kref) < 2);
> -			qhp->attr.state = IWCH_QP_STATE_CLOSING;
> -			if (!internal) {
> -				abort=0;
> -				disconnect = 1;
> -				ep = qhp->ep;
> -				get_ep(&ep->com);
> -			}
> -			break;
> -		case IWCH_QP_STATE_TERMINATE:
> -			qhp->attr.state = IWCH_QP_STATE_TERMINATE;
> -			if (qhp->ibqp.uobject)
> -				cxio_set_wq_in_error(&qhp->wq);
> -			if (!internal)
> -				terminate = 1;
> -			break;
> -		case IWCH_QP_STATE_ERROR:
> -			qhp->attr.state = IWCH_QP_STATE_ERROR;
> -			if (!internal) {
> -				abort=1;
> -				disconnect = 1;
> -				ep = qhp->ep;
> -				get_ep(&ep->com);
> -			}
> -			goto err;
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		break;
> -	case IWCH_QP_STATE_CLOSING:
> -		if (!internal) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		switch (attrs->next_state) {
> -			case IWCH_QP_STATE_IDLE:
> -				flush_qp(qhp);
> -				qhp->attr.state = IWCH_QP_STATE_IDLE;
> -				qhp->attr.llp_stream_handle = NULL;
> -				put_ep(&qhp->ep->com);
> -				qhp->ep = NULL;
> -				wake_up(&qhp->wait);
> -				break;
> -			case IWCH_QP_STATE_ERROR:
> -				goto err;
> -			default:
> -				ret = -EINVAL;
> -				goto err;
> -		}
> -		break;
> -	case IWCH_QP_STATE_ERROR:
> -		if (attrs->next_state != IWCH_QP_STATE_IDLE) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -
> -		if (!Q_EMPTY(qhp->wq.sq_rptr, qhp->wq.sq_wptr) ||
> -		    !Q_EMPTY(qhp->wq.rq_rptr, qhp->wq.rq_wptr)) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		qhp->attr.state = IWCH_QP_STATE_IDLE;
> -		break;
> -	case IWCH_QP_STATE_TERMINATE:
> -		if (!internal) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		goto err;
> -		break;
> -	default:
> -		pr_err("%s in a bad state %d\n", __func__, qhp->attr.state);
> -		ret = -EINVAL;
> -		goto err;
> -		break;
> -	}
> -	goto out;
> -err:
> -	pr_debug("%s disassociating ep %p qpid 0x%x\n", __func__, qhp->ep,
> -		 qhp->wq.qpid);
> -
> -	/* disassociate the LLP connection */
> -	qhp->attr.llp_stream_handle = NULL;
> -	ep = qhp->ep;
> -	qhp->ep = NULL;
> -	qhp->attr.state = IWCH_QP_STATE_ERROR;
> -	free=1;
> -	wake_up(&qhp->wait);
> -	BUG_ON(!ep);
> -	flush_qp(qhp);
> -out:
> -	spin_unlock_irqrestore(&qhp->lock, flag);
> -
> -	if (terminate)
> -		iwch_post_terminate(qhp, NULL);
> -
> -	/*
> -	 * If disconnect is 1, then we need to initiate a disconnect
> -	 * on the EP.  This can be a normal close (RTS->CLOSING) or
> -	 * an abnormal close (RTS/CLOSING->ERROR).
> -	 */
> -	if (disconnect) {
> -		iwch_ep_disconnect(ep, abort, GFP_KERNEL);
> -		put_ep(&ep->com);
> -	}
> -
> -	/*
> -	 * If free is 1, then we've disassociated the EP from the QP
> -	 * and we need to dereference the EP.
> -	 */
> -	if (free)
> -		put_ep(&ep->com);
> -
> -	pr_debug("%s exit state %d\n", __func__, qhp->attr.state);
> -	return ret;
> -}
> diff --git a/drivers/infiniband/hw/cxgb3/tcb.h b/drivers/infiniband/hw/cxgb3/tcb.h
> deleted file mode 100644
> index c702dc199e18..000000000000
> --- a/drivers/infiniband/hw/cxgb3/tcb.h
> +++ /dev/null
> @@ -1,632 +0,0 @@
> -/*
> - * Copyright (c) 2007 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef _TCB_DEFS_H
> -#define _TCB_DEFS_H
> -
> -#define W_TCB_T_STATE    0
> -#define S_TCB_T_STATE    0
> -#define M_TCB_T_STATE    0xfULL
> -#define V_TCB_T_STATE(x) ((x) << S_TCB_T_STATE)
> -
> -#define W_TCB_TIMER    0
> -#define S_TCB_TIMER    4
> -#define M_TCB_TIMER    0x1ULL
> -#define V_TCB_TIMER(x) ((x) << S_TCB_TIMER)
> -
> -#define W_TCB_DACK_TIMER    0
> -#define S_TCB_DACK_TIMER    5
> -#define M_TCB_DACK_TIMER    0x1ULL
> -#define V_TCB_DACK_TIMER(x) ((x) << S_TCB_DACK_TIMER)
> -
> -#define W_TCB_DEL_FLAG    0
> -#define S_TCB_DEL_FLAG    6
> -#define M_TCB_DEL_FLAG    0x1ULL
> -#define V_TCB_DEL_FLAG(x) ((x) << S_TCB_DEL_FLAG)
> -
> -#define W_TCB_L2T_IX    0
> -#define S_TCB_L2T_IX    7
> -#define M_TCB_L2T_IX    0x7ffULL
> -#define V_TCB_L2T_IX(x) ((x) << S_TCB_L2T_IX)
> -
> -#define W_TCB_SMAC_SEL    0
> -#define S_TCB_SMAC_SEL    18
> -#define M_TCB_SMAC_SEL    0x3ULL
> -#define V_TCB_SMAC_SEL(x) ((x) << S_TCB_SMAC_SEL)
> -
> -#define W_TCB_TOS    0
> -#define S_TCB_TOS    20
> -#define M_TCB_TOS    0x3fULL
> -#define V_TCB_TOS(x) ((x) << S_TCB_TOS)
> -
> -#define W_TCB_MAX_RT    0
> -#define S_TCB_MAX_RT    26
> -#define M_TCB_MAX_RT    0xfULL
> -#define V_TCB_MAX_RT(x) ((x) << S_TCB_MAX_RT)
> -
> -#define W_TCB_T_RXTSHIFT    0
> -#define S_TCB_T_RXTSHIFT    30
> -#define M_TCB_T_RXTSHIFT    0xfULL
> -#define V_TCB_T_RXTSHIFT(x) ((x) << S_TCB_T_RXTSHIFT)
> -
> -#define W_TCB_T_DUPACKS    1
> -#define S_TCB_T_DUPACKS    2
> -#define M_TCB_T_DUPACKS    0xfULL
> -#define V_TCB_T_DUPACKS(x) ((x) << S_TCB_T_DUPACKS)
> -
> -#define W_TCB_T_MAXSEG    1
> -#define S_TCB_T_MAXSEG    6
> -#define M_TCB_T_MAXSEG    0xfULL
> -#define V_TCB_T_MAXSEG(x) ((x) << S_TCB_T_MAXSEG)
> -
> -#define W_TCB_T_FLAGS1    1
> -#define S_TCB_T_FLAGS1    10
> -#define M_TCB_T_FLAGS1    0xffffffffULL
> -#define V_TCB_T_FLAGS1(x) ((x) << S_TCB_T_FLAGS1)
> -
> -#define W_TCB_T_MIGRATION    1
> -#define S_TCB_T_MIGRATION    20
> -#define M_TCB_T_MIGRATION    0x1ULL
> -#define V_TCB_T_MIGRATION(x) ((x) << S_TCB_T_MIGRATION)
> -
> -#define W_TCB_T_FLAGS2    2
> -#define S_TCB_T_FLAGS2    10
> -#define M_TCB_T_FLAGS2    0x7fULL
> -#define V_TCB_T_FLAGS2(x) ((x) << S_TCB_T_FLAGS2)
> -
> -#define W_TCB_SND_SCALE    2
> -#define S_TCB_SND_SCALE    17
> -#define M_TCB_SND_SCALE    0xfULL
> -#define V_TCB_SND_SCALE(x) ((x) << S_TCB_SND_SCALE)
> -
> -#define W_TCB_RCV_SCALE    2
> -#define S_TCB_RCV_SCALE    21
> -#define M_TCB_RCV_SCALE    0xfULL
> -#define V_TCB_RCV_SCALE(x) ((x) << S_TCB_RCV_SCALE)
> -
> -#define W_TCB_SND_UNA_RAW    2
> -#define S_TCB_SND_UNA_RAW    25
> -#define M_TCB_SND_UNA_RAW    0x7ffffffULL
> -#define V_TCB_SND_UNA_RAW(x) ((x) << S_TCB_SND_UNA_RAW)
> -
> -#define W_TCB_SND_NXT_RAW    3
> -#define S_TCB_SND_NXT_RAW    20
> -#define M_TCB_SND_NXT_RAW    0x7ffffffULL
> -#define V_TCB_SND_NXT_RAW(x) ((x) << S_TCB_SND_NXT_RAW)
> -
> -#define W_TCB_RCV_NXT    4
> -#define S_TCB_RCV_NXT    15
> -#define M_TCB_RCV_NXT    0xffffffffULL
> -#define V_TCB_RCV_NXT(x) ((x) << S_TCB_RCV_NXT)
> -
> -#define W_TCB_RCV_ADV    5
> -#define S_TCB_RCV_ADV    15
> -#define M_TCB_RCV_ADV    0xffffULL
> -#define V_TCB_RCV_ADV(x) ((x) << S_TCB_RCV_ADV)
> -
> -#define W_TCB_SND_MAX_RAW    5
> -#define S_TCB_SND_MAX_RAW    31
> -#define M_TCB_SND_MAX_RAW    0x7ffffffULL
> -#define V_TCB_SND_MAX_RAW(x) ((x) << S_TCB_SND_MAX_RAW)
> -
> -#define W_TCB_SND_CWND    6
> -#define S_TCB_SND_CWND    26
> -#define M_TCB_SND_CWND    0x7ffffffULL
> -#define V_TCB_SND_CWND(x) ((x) << S_TCB_SND_CWND)
> -
> -#define W_TCB_SND_SSTHRESH    7
> -#define S_TCB_SND_SSTHRESH    21
> -#define M_TCB_SND_SSTHRESH    0x7ffffffULL
> -#define V_TCB_SND_SSTHRESH(x) ((x) << S_TCB_SND_SSTHRESH)
> -
> -#define W_TCB_T_RTT_TS_RECENT_AGE    8
> -#define S_TCB_T_RTT_TS_RECENT_AGE    16
> -#define M_TCB_T_RTT_TS_RECENT_AGE    0xffffffffULL
> -#define V_TCB_T_RTT_TS_RECENT_AGE(x) ((x) << S_TCB_T_RTT_TS_RECENT_AGE)
> -
> -#define W_TCB_T_RTSEQ_RECENT    9
> -#define S_TCB_T_RTSEQ_RECENT    16
> -#define M_TCB_T_RTSEQ_RECENT    0xffffffffULL
> -#define V_TCB_T_RTSEQ_RECENT(x) ((x) << S_TCB_T_RTSEQ_RECENT)
> -
> -#define W_TCB_T_SRTT    10
> -#define S_TCB_T_SRTT    16
> -#define M_TCB_T_SRTT    0xffffULL
> -#define V_TCB_T_SRTT(x) ((x) << S_TCB_T_SRTT)
> -
> -#define W_TCB_T_RTTVAR    11
> -#define S_TCB_T_RTTVAR    0
> -#define M_TCB_T_RTTVAR    0xffffULL
> -#define V_TCB_T_RTTVAR(x) ((x) << S_TCB_T_RTTVAR)
> -
> -#define W_TCB_TS_LAST_ACK_SENT_RAW    11
> -#define S_TCB_TS_LAST_ACK_SENT_RAW    16
> -#define M_TCB_TS_LAST_ACK_SENT_RAW    0x7ffffffULL
> -#define V_TCB_TS_LAST_ACK_SENT_RAW(x) ((x) << S_TCB_TS_LAST_ACK_SENT_RAW)
> -
> -#define W_TCB_DIP    12
> -#define S_TCB_DIP    11
> -#define M_TCB_DIP    0xffffffffULL
> -#define V_TCB_DIP(x) ((x) << S_TCB_DIP)
> -
> -#define W_TCB_SIP    13
> -#define S_TCB_SIP    11
> -#define M_TCB_SIP    0xffffffffULL
> -#define V_TCB_SIP(x) ((x) << S_TCB_SIP)
> -
> -#define W_TCB_DP    14
> -#define S_TCB_DP    11
> -#define M_TCB_DP    0xffffULL
> -#define V_TCB_DP(x) ((x) << S_TCB_DP)
> -
> -#define W_TCB_SP    14
> -#define S_TCB_SP    27
> -#define M_TCB_SP    0xffffULL
> -#define V_TCB_SP(x) ((x) << S_TCB_SP)
> -
> -#define W_TCB_TIMESTAMP    15
> -#define S_TCB_TIMESTAMP    11
> -#define M_TCB_TIMESTAMP    0xffffffffULL
> -#define V_TCB_TIMESTAMP(x) ((x) << S_TCB_TIMESTAMP)
> -
> -#define W_TCB_TIMESTAMP_OFFSET    16
> -#define S_TCB_TIMESTAMP_OFFSET    11
> -#define M_TCB_TIMESTAMP_OFFSET    0xfULL
> -#define V_TCB_TIMESTAMP_OFFSET(x) ((x) << S_TCB_TIMESTAMP_OFFSET)
> -
> -#define W_TCB_TX_MAX    16
> -#define S_TCB_TX_MAX    15
> -#define M_TCB_TX_MAX    0xffffffffULL
> -#define V_TCB_TX_MAX(x) ((x) << S_TCB_TX_MAX)
> -
> -#define W_TCB_TX_HDR_PTR_RAW    17
> -#define S_TCB_TX_HDR_PTR_RAW    15
> -#define M_TCB_TX_HDR_PTR_RAW    0x1ffffULL
> -#define V_TCB_TX_HDR_PTR_RAW(x) ((x) << S_TCB_TX_HDR_PTR_RAW)
> -
> -#define W_TCB_TX_LAST_PTR_RAW    18
> -#define S_TCB_TX_LAST_PTR_RAW    0
> -#define M_TCB_TX_LAST_PTR_RAW    0x1ffffULL
> -#define V_TCB_TX_LAST_PTR_RAW(x) ((x) << S_TCB_TX_LAST_PTR_RAW)
> -
> -#define W_TCB_TX_COMPACT    18
> -#define S_TCB_TX_COMPACT    17
> -#define M_TCB_TX_COMPACT    0x1ULL
> -#define V_TCB_TX_COMPACT(x) ((x) << S_TCB_TX_COMPACT)
> -
> -#define W_TCB_RX_COMPACT    18
> -#define S_TCB_RX_COMPACT    18
> -#define M_TCB_RX_COMPACT    0x1ULL
> -#define V_TCB_RX_COMPACT(x) ((x) << S_TCB_RX_COMPACT)
> -
> -#define W_TCB_RCV_WND    18
> -#define S_TCB_RCV_WND    19
> -#define M_TCB_RCV_WND    0x7ffffffULL
> -#define V_TCB_RCV_WND(x) ((x) << S_TCB_RCV_WND)
> -
> -#define W_TCB_RX_HDR_OFFSET    19
> -#define S_TCB_RX_HDR_OFFSET    14
> -#define M_TCB_RX_HDR_OFFSET    0x7ffffffULL
> -#define V_TCB_RX_HDR_OFFSET(x) ((x) << S_TCB_RX_HDR_OFFSET)
> -
> -#define W_TCB_RX_FRAG0_START_IDX_RAW    20
> -#define S_TCB_RX_FRAG0_START_IDX_RAW    9
> -#define M_TCB_RX_FRAG0_START_IDX_RAW    0x7ffffffULL
> -#define V_TCB_RX_FRAG0_START_IDX_RAW(x) ((x) << S_TCB_RX_FRAG0_START_IDX_RAW)
> -
> -#define W_TCB_RX_FRAG1_START_IDX_OFFSET    21
> -#define S_TCB_RX_FRAG1_START_IDX_OFFSET    4
> -#define M_TCB_RX_FRAG1_START_IDX_OFFSET    0x7ffffffULL
> -#define V_TCB_RX_FRAG1_START_IDX_OFFSET(x) ((x) << S_TCB_RX_FRAG1_START_IDX_OFFSET)
> -
> -#define W_TCB_RX_FRAG0_LEN    21
> -#define S_TCB_RX_FRAG0_LEN    31
> -#define M_TCB_RX_FRAG0_LEN    0x7ffffffULL
> -#define V_TCB_RX_FRAG0_LEN(x) ((x) << S_TCB_RX_FRAG0_LEN)
> -
> -#define W_TCB_RX_FRAG1_LEN    22
> -#define S_TCB_RX_FRAG1_LEN    26
> -#define M_TCB_RX_FRAG1_LEN    0x7ffffffULL
> -#define V_TCB_RX_FRAG1_LEN(x) ((x) << S_TCB_RX_FRAG1_LEN)
> -
> -#define W_TCB_NEWRENO_RECOVER    23
> -#define S_TCB_NEWRENO_RECOVER    21
> -#define M_TCB_NEWRENO_RECOVER    0x7ffffffULL
> -#define V_TCB_NEWRENO_RECOVER(x) ((x) << S_TCB_NEWRENO_RECOVER)
> -
> -#define W_TCB_PDU_HAVE_LEN    24
> -#define S_TCB_PDU_HAVE_LEN    16
> -#define M_TCB_PDU_HAVE_LEN    0x1ULL
> -#define V_TCB_PDU_HAVE_LEN(x) ((x) << S_TCB_PDU_HAVE_LEN)
> -
> -#define W_TCB_PDU_LEN    24
> -#define S_TCB_PDU_LEN    17
> -#define M_TCB_PDU_LEN    0xffffULL
> -#define V_TCB_PDU_LEN(x) ((x) << S_TCB_PDU_LEN)
> -
> -#define W_TCB_RX_QUIESCE    25
> -#define S_TCB_RX_QUIESCE    1
> -#define M_TCB_RX_QUIESCE    0x1ULL
> -#define V_TCB_RX_QUIESCE(x) ((x) << S_TCB_RX_QUIESCE)
> -
> -#define W_TCB_RX_PTR_RAW    25
> -#define S_TCB_RX_PTR_RAW    2
> -#define M_TCB_RX_PTR_RAW    0x1ffffULL
> -#define V_TCB_RX_PTR_RAW(x) ((x) << S_TCB_RX_PTR_RAW)
> -
> -#define W_TCB_CPU_NO    25
> -#define S_TCB_CPU_NO    19
> -#define M_TCB_CPU_NO    0x7fULL
> -#define V_TCB_CPU_NO(x) ((x) << S_TCB_CPU_NO)
> -
> -#define W_TCB_ULP_TYPE    25
> -#define S_TCB_ULP_TYPE    26
> -#define M_TCB_ULP_TYPE    0xfULL
> -#define V_TCB_ULP_TYPE(x) ((x) << S_TCB_ULP_TYPE)
> -
> -#define W_TCB_RX_FRAG1_PTR_RAW    25
> -#define S_TCB_RX_FRAG1_PTR_RAW    30
> -#define M_TCB_RX_FRAG1_PTR_RAW    0x1ffffULL
> -#define V_TCB_RX_FRAG1_PTR_RAW(x) ((x) << S_TCB_RX_FRAG1_PTR_RAW)
> -
> -#define W_TCB_RX_FRAG2_START_IDX_OFFSET_RAW    26
> -#define S_TCB_RX_FRAG2_START_IDX_OFFSET_RAW    15
> -#define M_TCB_RX_FRAG2_START_IDX_OFFSET_RAW    0x7ffffffULL
> -#define V_TCB_RX_FRAG2_START_IDX_OFFSET_RAW(x) ((x) << S_TCB_RX_FRAG2_START_IDX_OFFSET_RAW)
> -
> -#define W_TCB_RX_FRAG2_PTR_RAW    27
> -#define S_TCB_RX_FRAG2_PTR_RAW    10
> -#define M_TCB_RX_FRAG2_PTR_RAW    0x1ffffULL
> -#define V_TCB_RX_FRAG2_PTR_RAW(x) ((x) << S_TCB_RX_FRAG2_PTR_RAW)
> -
> -#define W_TCB_RX_FRAG2_LEN_RAW    27
> -#define S_TCB_RX_FRAG2_LEN_RAW    27
> -#define M_TCB_RX_FRAG2_LEN_RAW    0x7ffffffULL
> -#define V_TCB_RX_FRAG2_LEN_RAW(x) ((x) << S_TCB_RX_FRAG2_LEN_RAW)
> -
> -#define W_TCB_RX_FRAG3_PTR_RAW    28
> -#define S_TCB_RX_FRAG3_PTR_RAW    22
> -#define M_TCB_RX_FRAG3_PTR_RAW    0x1ffffULL
> -#define V_TCB_RX_FRAG3_PTR_RAW(x) ((x) << S_TCB_RX_FRAG3_PTR_RAW)
> -
> -#define W_TCB_RX_FRAG3_LEN_RAW    29
> -#define S_TCB_RX_FRAG3_LEN_RAW    7
> -#define M_TCB_RX_FRAG3_LEN_RAW    0x7ffffffULL
> -#define V_TCB_RX_FRAG3_LEN_RAW(x) ((x) << S_TCB_RX_FRAG3_LEN_RAW)
> -
> -#define W_TCB_RX_FRAG3_START_IDX_OFFSET_RAW    30
> -#define S_TCB_RX_FRAG3_START_IDX_OFFSET_RAW    2
> -#define M_TCB_RX_FRAG3_START_IDX_OFFSET_RAW    0x7ffffffULL
> -#define V_TCB_RX_FRAG3_START_IDX_OFFSET_RAW(x) ((x) << S_TCB_RX_FRAG3_START_IDX_OFFSET_RAW)
> -
> -#define W_TCB_PDU_HDR_LEN    30
> -#define S_TCB_PDU_HDR_LEN    29
> -#define M_TCB_PDU_HDR_LEN    0xffULL
> -#define V_TCB_PDU_HDR_LEN(x) ((x) << S_TCB_PDU_HDR_LEN)
> -
> -#define W_TCB_SLUSH1    31
> -#define S_TCB_SLUSH1    5
> -#define M_TCB_SLUSH1    0x7ffffULL
> -#define V_TCB_SLUSH1(x) ((x) << S_TCB_SLUSH1)
> -
> -#define W_TCB_ULP_RAW    31
> -#define S_TCB_ULP_RAW    24
> -#define M_TCB_ULP_RAW    0xffULL
> -#define V_TCB_ULP_RAW(x) ((x) << S_TCB_ULP_RAW)
> -
> -#define W_TCB_DDP_RDMAP_VERSION    25
> -#define S_TCB_DDP_RDMAP_VERSION    30
> -#define M_TCB_DDP_RDMAP_VERSION    0x1ULL
> -#define V_TCB_DDP_RDMAP_VERSION(x) ((x) << S_TCB_DDP_RDMAP_VERSION)
> -
> -#define W_TCB_MARKER_ENABLE_RX    25
> -#define S_TCB_MARKER_ENABLE_RX    31
> -#define M_TCB_MARKER_ENABLE_RX    0x1ULL
> -#define V_TCB_MARKER_ENABLE_RX(x) ((x) << S_TCB_MARKER_ENABLE_RX)
> -
> -#define W_TCB_MARKER_ENABLE_TX    26
> -#define S_TCB_MARKER_ENABLE_TX    0
> -#define M_TCB_MARKER_ENABLE_TX    0x1ULL
> -#define V_TCB_MARKER_ENABLE_TX(x) ((x) << S_TCB_MARKER_ENABLE_TX)
> -
> -#define W_TCB_CRC_ENABLE    26
> -#define S_TCB_CRC_ENABLE    1
> -#define M_TCB_CRC_ENABLE    0x1ULL
> -#define V_TCB_CRC_ENABLE(x) ((x) << S_TCB_CRC_ENABLE)
> -
> -#define W_TCB_IRS_ULP    26
> -#define S_TCB_IRS_ULP    2
> -#define M_TCB_IRS_ULP    0x1ffULL
> -#define V_TCB_IRS_ULP(x) ((x) << S_TCB_IRS_ULP)
> -
> -#define W_TCB_ISS_ULP    26
> -#define S_TCB_ISS_ULP    11
> -#define M_TCB_ISS_ULP    0x1ffULL
> -#define V_TCB_ISS_ULP(x) ((x) << S_TCB_ISS_ULP)
> -
> -#define W_TCB_TX_PDU_LEN    26
> -#define S_TCB_TX_PDU_LEN    20
> -#define M_TCB_TX_PDU_LEN    0x3fffULL
> -#define V_TCB_TX_PDU_LEN(x) ((x) << S_TCB_TX_PDU_LEN)
> -
> -#define W_TCB_TX_PDU_OUT    27
> -#define S_TCB_TX_PDU_OUT    2
> -#define M_TCB_TX_PDU_OUT    0x1ULL
> -#define V_TCB_TX_PDU_OUT(x) ((x) << S_TCB_TX_PDU_OUT)
> -
> -#define W_TCB_CQ_IDX_SQ    27
> -#define S_TCB_CQ_IDX_SQ    3
> -#define M_TCB_CQ_IDX_SQ    0xffffULL
> -#define V_TCB_CQ_IDX_SQ(x) ((x) << S_TCB_CQ_IDX_SQ)
> -
> -#define W_TCB_CQ_IDX_RQ    27
> -#define S_TCB_CQ_IDX_RQ    19
> -#define M_TCB_CQ_IDX_RQ    0xffffULL
> -#define V_TCB_CQ_IDX_RQ(x) ((x) << S_TCB_CQ_IDX_RQ)
> -
> -#define W_TCB_QP_ID    28
> -#define S_TCB_QP_ID    3
> -#define M_TCB_QP_ID    0xffffULL
> -#define V_TCB_QP_ID(x) ((x) << S_TCB_QP_ID)
> -
> -#define W_TCB_PD_ID    28
> -#define S_TCB_PD_ID    19
> -#define M_TCB_PD_ID    0xffffULL
> -#define V_TCB_PD_ID(x) ((x) << S_TCB_PD_ID)
> -
> -#define W_TCB_STAG    29
> -#define S_TCB_STAG    3
> -#define M_TCB_STAG    0xffffffffULL
> -#define V_TCB_STAG(x) ((x) << S_TCB_STAG)
> -
> -#define W_TCB_RQ_START    30
> -#define S_TCB_RQ_START    3
> -#define M_TCB_RQ_START    0x3ffffffULL
> -#define V_TCB_RQ_START(x) ((x) << S_TCB_RQ_START)
> -
> -#define W_TCB_RQ_MSN    30
> -#define S_TCB_RQ_MSN    29
> -#define M_TCB_RQ_MSN    0x3ffULL
> -#define V_TCB_RQ_MSN(x) ((x) << S_TCB_RQ_MSN)
> -
> -#define W_TCB_RQ_MAX_OFFSET    31
> -#define S_TCB_RQ_MAX_OFFSET    7
> -#define M_TCB_RQ_MAX_OFFSET    0xfULL
> -#define V_TCB_RQ_MAX_OFFSET(x) ((x) << S_TCB_RQ_MAX_OFFSET)
> -
> -#define W_TCB_RQ_WRITE_PTR    31
> -#define S_TCB_RQ_WRITE_PTR    11
> -#define M_TCB_RQ_WRITE_PTR    0x3ffULL
> -#define V_TCB_RQ_WRITE_PTR(x) ((x) << S_TCB_RQ_WRITE_PTR)
> -
> -#define W_TCB_INB_WRITE_PERM    31
> -#define S_TCB_INB_WRITE_PERM    21
> -#define M_TCB_INB_WRITE_PERM    0x1ULL
> -#define V_TCB_INB_WRITE_PERM(x) ((x) << S_TCB_INB_WRITE_PERM)
> -
> -#define W_TCB_INB_READ_PERM    31
> -#define S_TCB_INB_READ_PERM    22
> -#define M_TCB_INB_READ_PERM    0x1ULL
> -#define V_TCB_INB_READ_PERM(x) ((x) << S_TCB_INB_READ_PERM)
> -
> -#define W_TCB_ORD_L_BIT_VLD    31
> -#define S_TCB_ORD_L_BIT_VLD    23
> -#define M_TCB_ORD_L_BIT_VLD    0x1ULL
> -#define V_TCB_ORD_L_BIT_VLD(x) ((x) << S_TCB_ORD_L_BIT_VLD)
> -
> -#define W_TCB_RDMAP_OPCODE    31
> -#define S_TCB_RDMAP_OPCODE    24
> -#define M_TCB_RDMAP_OPCODE    0xfULL
> -#define V_TCB_RDMAP_OPCODE(x) ((x) << S_TCB_RDMAP_OPCODE)
> -
> -#define W_TCB_TX_FLUSH    31
> -#define S_TCB_TX_FLUSH    28
> -#define M_TCB_TX_FLUSH    0x1ULL
> -#define V_TCB_TX_FLUSH(x) ((x) << S_TCB_TX_FLUSH)
> -
> -#define W_TCB_TX_OOS_RXMT    31
> -#define S_TCB_TX_OOS_RXMT    29
> -#define M_TCB_TX_OOS_RXMT    0x1ULL
> -#define V_TCB_TX_OOS_RXMT(x) ((x) << S_TCB_TX_OOS_RXMT)
> -
> -#define W_TCB_TX_OOS_TXMT    31
> -#define S_TCB_TX_OOS_TXMT    30
> -#define M_TCB_TX_OOS_TXMT    0x1ULL
> -#define V_TCB_TX_OOS_TXMT(x) ((x) << S_TCB_TX_OOS_TXMT)
> -
> -#define W_TCB_SLUSH_AUX2    31
> -#define S_TCB_SLUSH_AUX2    31
> -#define M_TCB_SLUSH_AUX2    0x1ULL
> -#define V_TCB_SLUSH_AUX2(x) ((x) << S_TCB_SLUSH_AUX2)
> -
> -#define W_TCB_RX_FRAG1_PTR_RAW2    25
> -#define S_TCB_RX_FRAG1_PTR_RAW2    30
> -#define M_TCB_RX_FRAG1_PTR_RAW2    0x1ffffULL
> -#define V_TCB_RX_FRAG1_PTR_RAW2(x) ((x) << S_TCB_RX_FRAG1_PTR_RAW2)
> -
> -#define W_TCB_RX_DDP_FLAGS    26
> -#define S_TCB_RX_DDP_FLAGS    15
> -#define M_TCB_RX_DDP_FLAGS    0x3ffULL
> -#define V_TCB_RX_DDP_FLAGS(x) ((x) << S_TCB_RX_DDP_FLAGS)
> -
> -#define W_TCB_SLUSH_AUX3    26
> -#define S_TCB_SLUSH_AUX3    31
> -#define M_TCB_SLUSH_AUX3    0x1ffULL
> -#define V_TCB_SLUSH_AUX3(x) ((x) << S_TCB_SLUSH_AUX3)
> -
> -#define W_TCB_RX_DDP_BUF0_OFFSET    27
> -#define S_TCB_RX_DDP_BUF0_OFFSET    8
> -#define M_TCB_RX_DDP_BUF0_OFFSET    0x3fffffULL
> -#define V_TCB_RX_DDP_BUF0_OFFSET(x) ((x) << S_TCB_RX_DDP_BUF0_OFFSET)
> -
> -#define W_TCB_RX_DDP_BUF0_LEN    27
> -#define S_TCB_RX_DDP_BUF0_LEN    30
> -#define M_TCB_RX_DDP_BUF0_LEN    0x3fffffULL
> -#define V_TCB_RX_DDP_BUF0_LEN(x) ((x) << S_TCB_RX_DDP_BUF0_LEN)
> -
> -#define W_TCB_RX_DDP_BUF1_OFFSET    28
> -#define S_TCB_RX_DDP_BUF1_OFFSET    20
> -#define M_TCB_RX_DDP_BUF1_OFFSET    0x3fffffULL
> -#define V_TCB_RX_DDP_BUF1_OFFSET(x) ((x) << S_TCB_RX_DDP_BUF1_OFFSET)
> -
> -#define W_TCB_RX_DDP_BUF1_LEN    29
> -#define S_TCB_RX_DDP_BUF1_LEN    10
> -#define M_TCB_RX_DDP_BUF1_LEN    0x3fffffULL
> -#define V_TCB_RX_DDP_BUF1_LEN(x) ((x) << S_TCB_RX_DDP_BUF1_LEN)
> -
> -#define W_TCB_RX_DDP_BUF0_TAG    30
> -#define S_TCB_RX_DDP_BUF0_TAG    0
> -#define M_TCB_RX_DDP_BUF0_TAG    0xffffffffULL
> -#define V_TCB_RX_DDP_BUF0_TAG(x) ((x) << S_TCB_RX_DDP_BUF0_TAG)
> -
> -#define W_TCB_RX_DDP_BUF1_TAG    31
> -#define S_TCB_RX_DDP_BUF1_TAG    0
> -#define M_TCB_RX_DDP_BUF1_TAG    0xffffffffULL
> -#define V_TCB_RX_DDP_BUF1_TAG(x) ((x) << S_TCB_RX_DDP_BUF1_TAG)
> -
> -#define S_TF_DACK    10
> -#define V_TF_DACK(x) ((x) << S_TF_DACK)
> -
> -#define S_TF_NAGLE    11
> -#define V_TF_NAGLE(x) ((x) << S_TF_NAGLE)
> -
> -#define S_TF_RECV_SCALE    12
> -#define V_TF_RECV_SCALE(x) ((x) << S_TF_RECV_SCALE)
> -
> -#define S_TF_RECV_TSTMP    13
> -#define V_TF_RECV_TSTMP(x) ((x) << S_TF_RECV_TSTMP)
> -
> -#define S_TF_RECV_SACK    14
> -#define V_TF_RECV_SACK(x) ((x) << S_TF_RECV_SACK)
> -
> -#define S_TF_TURBO    15
> -#define V_TF_TURBO(x) ((x) << S_TF_TURBO)
> -
> -#define S_TF_KEEPALIVE    16
> -#define V_TF_KEEPALIVE(x) ((x) << S_TF_KEEPALIVE)
> -
> -#define S_TF_TCAM_BYPASS    17
> -#define V_TF_TCAM_BYPASS(x) ((x) << S_TF_TCAM_BYPASS)
> -
> -#define S_TF_CORE_FIN    18
> -#define V_TF_CORE_FIN(x) ((x) << S_TF_CORE_FIN)
> -
> -#define S_TF_CORE_MORE    19
> -#define V_TF_CORE_MORE(x) ((x) << S_TF_CORE_MORE)
> -
> -#define S_TF_MIGRATING    20
> -#define V_TF_MIGRATING(x) ((x) << S_TF_MIGRATING)
> -
> -#define S_TF_ACTIVE_OPEN    21
> -#define V_TF_ACTIVE_OPEN(x) ((x) << S_TF_ACTIVE_OPEN)
> -
> -#define S_TF_ASK_MODE    22
> -#define V_TF_ASK_MODE(x) ((x) << S_TF_ASK_MODE)
> -
> -#define S_TF_NON_OFFLOAD    23
> -#define V_TF_NON_OFFLOAD(x) ((x) << S_TF_NON_OFFLOAD)
> -
> -#define S_TF_MOD_SCHD    24
> -#define V_TF_MOD_SCHD(x) ((x) << S_TF_MOD_SCHD)
> -
> -#define S_TF_MOD_SCHD_REASON0    25
> -#define V_TF_MOD_SCHD_REASON0(x) ((x) << S_TF_MOD_SCHD_REASON0)
> -
> -#define S_TF_MOD_SCHD_REASON1    26
> -#define V_TF_MOD_SCHD_REASON1(x) ((x) << S_TF_MOD_SCHD_REASON1)
> -
> -#define S_TF_MOD_SCHD_RX    27
> -#define V_TF_MOD_SCHD_RX(x) ((x) << S_TF_MOD_SCHD_RX)
> -
> -#define S_TF_CORE_PUSH    28
> -#define V_TF_CORE_PUSH(x) ((x) << S_TF_CORE_PUSH)
> -
> -#define S_TF_RCV_COALESCE_ENABLE    29
> -#define V_TF_RCV_COALESCE_ENABLE(x) ((x) << S_TF_RCV_COALESCE_ENABLE)
> -
> -#define S_TF_RCV_COALESCE_PUSH    30
> -#define V_TF_RCV_COALESCE_PUSH(x) ((x) << S_TF_RCV_COALESCE_PUSH)
> -
> -#define S_TF_RCV_COALESCE_LAST_PSH    31
> -#define V_TF_RCV_COALESCE_LAST_PSH(x) ((x) << S_TF_RCV_COALESCE_LAST_PSH)
> -
> -#define S_TF_RCV_COALESCE_HEARTBEAT    32
> -#define V_TF_RCV_COALESCE_HEARTBEAT(x) ((x) << S_TF_RCV_COALESCE_HEARTBEAT)
> -
> -#define S_TF_HALF_CLOSE    33
> -#define V_TF_HALF_CLOSE(x) ((x) << S_TF_HALF_CLOSE)
> -
> -#define S_TF_DACK_MSS    34
> -#define V_TF_DACK_MSS(x) ((x) << S_TF_DACK_MSS)
> -
> -#define S_TF_CCTRL_SEL0    35
> -#define V_TF_CCTRL_SEL0(x) ((x) << S_TF_CCTRL_SEL0)
> -
> -#define S_TF_CCTRL_SEL1    36
> -#define V_TF_CCTRL_SEL1(x) ((x) << S_TF_CCTRL_SEL1)
> -
> -#define S_TF_TCP_NEWRENO_FAST_RECOVERY    37
> -#define V_TF_TCP_NEWRENO_FAST_RECOVERY(x) ((x) << S_TF_TCP_NEWRENO_FAST_RECOVERY)
> -
> -#define S_TF_TX_PACE_AUTO    38
> -#define V_TF_TX_PACE_AUTO(x) ((x) << S_TF_TX_PACE_AUTO)
> -
> -#define S_TF_PEER_FIN_HELD    39
> -#define V_TF_PEER_FIN_HELD(x) ((x) << S_TF_PEER_FIN_HELD)
> -
> -#define S_TF_CORE_URG    40
> -#define V_TF_CORE_URG(x) ((x) << S_TF_CORE_URG)
> -
> -#define S_TF_RDMA_ERROR    41
> -#define V_TF_RDMA_ERROR(x) ((x) << S_TF_RDMA_ERROR)
> -
> -#define S_TF_SSWS_DISABLED    42
> -#define V_TF_SSWS_DISABLED(x) ((x) << S_TF_SSWS_DISABLED)
> -
> -#define S_TF_DUPACK_COUNT_ODD    43
> -#define V_TF_DUPACK_COUNT_ODD(x) ((x) << S_TF_DUPACK_COUNT_ODD)
> -
> -#define S_TF_TX_CHANNEL    44
> -#define V_TF_TX_CHANNEL(x) ((x) << S_TF_TX_CHANNEL)
> -
> -#define S_TF_RX_CHANNEL    45
> -#define V_TF_RX_CHANNEL(x) ((x) << S_TF_RX_CHANNEL)
> -
> -#define S_TF_TX_PACE_FIXED    46
> -#define V_TF_TX_PACE_FIXED(x) ((x) << S_TF_TX_PACE_FIXED)
> -
> -#define S_TF_RDMA_FLM_ERROR    47
> -#define V_TF_RDMA_FLM_ERROR(x) ((x) << S_TF_RDMA_FLM_ERROR)
> -
> -#define S_TF_RX_FLOW_CONTROL_DISABLE    48
> -#define V_TF_RX_FLOW_CONTROL_DISABLE(x) ((x) << S_TF_RX_FLOW_CONTROL_DISABLE)
> -
> -#endif /* _TCB_DEFS_H */
> diff --git a/include/uapi/rdma/cxgb3-abi.h b/include/uapi/rdma/cxgb3-abi.h
> deleted file mode 100644
> index 85aed672f43e..000000000000
> --- a/include/uapi/rdma/cxgb3-abi.h
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
> -/*
> - * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the
> - * OpenIB.org BSD license below:
> - *
> - *     Redistribution and use in source and binary forms, with or
> - *     without modification, are permitted provided that the following
> - *     conditions are met:
> - *
> - *      - Redistributions of source code must retain the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer.
> - *
> - *      - Redistributions in binary form must reproduce the above
> - *        copyright notice, this list of conditions and the following
> - *        disclaimer in the documentation and/or other materials
> - *        provided with the distribution.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -#ifndef CXGB3_ABI_USER_H
> -#define CXGB3_ABI_USER_H
> -
> -#include <linux/types.h>
> -
> -#define IWCH_UVERBS_ABI_VERSION	1
> -
> -/*
> - * Make sure that all structs defined in this file remain laid out so
> - * that they pack the same way on 32-bit and 64-bit architectures (to
> - * avoid incompatibility between 32-bit userspace and 64-bit kernels).
> - * In particular do not use pointer types -- pass pointers in __aligned_u64
> - * instead.
> - */
> -struct iwch_create_cq_req {
> -	__aligned_u64 user_rptr_addr;
> -};
> -
> -struct iwch_create_cq_resp_v0 {
> -	__aligned_u64 key;
> -	__u32 cqid;
> -	__u32 size_log2;
> -};
> -
> -struct iwch_create_cq_resp {
> -	__aligned_u64 key;
> -	__u32 cqid;
> -	__u32 size_log2;
> -	__u32 memsize;
> -	__u32 reserved;
> -};
> -
> -struct iwch_create_qp_resp {
> -	__aligned_u64 key;
> -	__aligned_u64 db_key;
> -	__u32 qpid;
> -	__u32 size_log2;
> -	__u32 sq_size_log2;
> -	__u32 rq_size_log2;
> -};
> -
> -struct iwch_reg_user_mr_resp {
> -	__u32 pbl_addr;
> -};
> -
> -struct iwch_alloc_pd_resp {
> -	__u32 pdid;
> -};
> -
> -#endif /* CXGB3_ABI_USER_H */
> diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h b/include/uapi/rdma/rdma_user_ioctl_cmds.h
> index b8bb285f6b2a..b2680051047a 100644
> --- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
> +++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
> @@ -88,7 +88,6 @@ enum rdma_driver_id {
>   	RDMA_DRIVER_UNKNOWN,
>   	RDMA_DRIVER_MLX5,
>   	RDMA_DRIVER_MLX4,
> -	RDMA_DRIVER_CXGB3,
>   	RDMA_DRIVER_CXGB4,
>   	RDMA_DRIVER_MTHCA,
>   	RDMA_DRIVER_BNXT_RE,
> 
Isn't there a better way to mark a driver deprecated?

This kind of removal makes long-term maintenance of such drivers painful in downstream distros, as API changes that are rippled from core through all the drivers, don't update these drivers, and when backporting such API changes to downstream distros, we have to +1 removed drivers.

It's much easier if upstream continues to update the drivers for such across-the-driver-patch-changes.
heck, add a separate patch that punches out a printk stating DEPRECATED (dropping a patch to backport is easy! :) ).

I told Doug I'd shoot him if he removed another driver from upstream again, that still has to be maintained in RHEL -- don't make me take him *and Jason* out! ;-)  ... yeah, you too Jason!





