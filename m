Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9803AEA9
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbfFJFkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 01:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387505AbfFJFkk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 01:40:40 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3838020820;
        Mon, 10 Jun 2019 05:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560145239;
        bh=uDmQJ2fdQe3pgp+2HPDsgrwEUsVDgDu2ffQ/i9CSCIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eStEphU+eZssUS9RDbJD0H4aiVyDN2HQaUAhddX42NYqLvOaMBI3kFXRiyaSTOjbK
         noi6bTAacBjwSWi6nGRcwwihGaiUrJUUQ5bXJn9jvVSWCfGP9Xen3AOhf0Gdq+AZhb
         9xXa0pIIwEYBCZUDLnIvgMmHaBixr8CEKlzj4HyY=
Date:   Mon, 10 Jun 2019 08:40:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 03/12] SIW network and RDMA core interface
Message-ID: <20190610054035.GB6369@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-4-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-4-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:47PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_main.c | 701 +++++++++++++++++++++++++++
>  1 file changed, 701 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/siw_main.c
>
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> new file mode 100644
> index 000000000000..a9b8a5d2aaa3
> --- /dev/null
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
> +
> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> +/* Copyright (c) 2008-2019, IBM Corporation */
> +
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/netdevice.h>
> +#include <linux/inetdevice.h>
> +#include <net/net_namespace.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/if_arp.h>
> +#include <linux/list.h>
> +#include <linux/kernel.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <rdma/ib_verbs.h>
> +#include <rdma/ib_smi.h>
> +#include <rdma/ib_user_verbs.h>
> +#include <rdma/rdma_netlink.h>
> +#include <linux/kthread.h>
> +
> +#include "siw.h"
> +#include "siw_cm.h"
> +#include "siw_verbs.h"
> +#include "siw_debug.h"
> +
> +MODULE_AUTHOR("Bernard Metzler");
> +MODULE_DESCRIPTION("Software iWARP Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> +
> +/* transmit from user buffer, if possible */
> +const bool zcopy_tx = true;
> +
> +/* Restrict usage of GSO, if hardware peer iwarp is unable to process
> + * large packets. try_gso = true lets siw try to use local GSO,
> + * if peer agrees.  Not using GSO severly limits siw maximum tx bandwidth.
> + */
> +const bool try_gso;
> +
> +/* Attach siw also with loopback devices */
> +const bool loopback_enabled = true;
> +
> +/* We try to negotiate CRC on, if true */
> +const bool mpa_crc_required;
> +
> +/* MPA CRC on/off enforced */
> +const bool mpa_crc_strict;
> +
> +/* Control TCP_NODELAY socket option */
> +const bool siw_tcp_nagle;
> +
> +/* Select MPA version to be used during connection setup */
> +u_char mpa_version = MPA_REVISION_2;
> +
> +/* Selects MPA P2P mode (additional handshake during connection
> + * setup, if true.
> + */
> +const bool peer_to_peer;
> +
> +struct task_struct *siw_tx_thread[NR_CPUS];
> +struct crypto_shash *siw_crypto_shash;
> +
> +static int siw_device_register(struct siw_device *sdev, const char *name)
> +{
> +	struct ib_device *base_dev = &sdev->base_dev;
> +	static int dev_id = 1;
> +	int rv;
> +
> +	base_dev->driver_id = RDMA_DRIVER_SIW;
> +
> +	rv = ib_register_device(base_dev, name);
> +	if (rv) {
> +		pr_warn("siw: device registration error %d\n", rv);
> +		return rv;
> +	}
> +	sdev->vendor_part_id = dev_id++;
> +
> +	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->netdev->dev_addr);
> +
> +	return 0;
> +}
> +
> +static void siw_device_cleanup(struct ib_device *base_dev)
> +{
> +	struct siw_device *sdev = to_siw_dev(base_dev);
> +
> +	siw_dbg(base_dev, "Cleanup device\n");
> +
> +	if (atomic_read(&sdev->num_ctx) || atomic_read(&sdev->num_srq) ||
> +	    atomic_read(&sdev->num_mr) || atomic_read(&sdev->num_cep) ||
> +	    atomic_read(&sdev->num_qp) || atomic_read(&sdev->num_cq) ||
> +	    atomic_read(&sdev->num_pd)) {
> +		pr_warn("siw at %s: orphaned resources!\n", sdev->netdev->name);
> +		pr_warn("           CTX %d, SRQ %d, QP %d, CQ %d, MEM %d, CEP %d, PD %d\n",
> +			atomic_read(&sdev->num_ctx),
> +			atomic_read(&sdev->num_srq), atomic_read(&sdev->num_qp),
> +			atomic_read(&sdev->num_cq), atomic_read(&sdev->num_mr),
> +			atomic_read(&sdev->num_cep),
> +			atomic_read(&sdev->num_pd));
> +	}

We already talked about it, most of this code is redundant due to restrack and it should be removed.

> +	while (!list_empty(&sdev->cep_list)) {
> +		struct siw_cep *cep =
> +			list_entry(sdev->cep_list.next, struct siw_cep, devq);
> +		list_del(&cep->devq);
> +		pr_warn("siw: at %s: free orphaned CEP 0x%p, state %d\n",
> +			sdev->base_dev.name, cep, cep->state);

Does it mean that SIW leak memory? If cep can be not-empty at this
stage, what will be the purpose of pr_warn? If it can't, it is better
to find memory leak.

> +		kfree(cep);
> +	}
> +	xa_destroy(&sdev->qp_xa);
> +	xa_destroy(&sdev->mem_xa);
> +}
> +
> +static int siw_create_tx_threads(void)
> +{
> +	int cpu, rv, assigned = 0;
> +
> +	for_each_online_cpu(cpu) {
> +		/* Skip HT cores */
> +		if (cpu % cpumask_weight(topology_sibling_cpumask(cpu))) {
> +			siw_tx_thread[cpu] = NULL;
> +			continue;
> +		}
> +		siw_tx_thread[cpu] =
> +			kthread_create(siw_run_sq, (unsigned long *)(long)cpu,
> +				       "siw_tx/%d", cpu);

I don't decide here, but just for the record, creating kernel threads
for every CPU is wrong.

> +		if (IS_ERR(siw_tx_thread[cpu])) {
> +			rv = PTR_ERR(siw_tx_thread[cpu]);
> +			siw_tx_thread[cpu] = NULL;
> +			pr_info("Creating TX thread for CPU %d failed", cpu);
> +			continue;
> +		}
> +		kthread_bind(siw_tx_thread[cpu], cpu);
> +
> +		wake_up_process(siw_tx_thread[cpu]);
> +		assigned++;
> +	}
> +	return assigned;
> +}
> +
