Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD83CE4E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfFKOQJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Jun 2019 10:16:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387486AbfFKOQJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 10:16:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BEEQwF005125
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:16:07 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2cnnves5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 10:16:07 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Jun 2019 14:16:05 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Jun 2019 14:16:03 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019061114160261-581698 ;
          Tue, 11 Jun 2019 14:16:02 +0000 
In-Reply-To: <20190610054035.GB6369@mtr-leonro.mtl.com>
Subject: Re: [PATCH for-next v1 03/12] SIW network and RDMA core interface
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Jun 2019 14:16:03 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190610054035.GB6369@mtr-leonro.mtl.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-4-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: B982EA89:45144E18-00258416:004E2684;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 43239
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061114-9695-0000-0000-0000067C5513
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.415104; ST=0; TS=0; UL=0; ISC=; MB=0.000016
X-IBM-SpamModules-Versions: BY=3.00011246; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216458; UDB=6.00639602; IPR=6.00997557;
 BA=6.00006331; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027261; XFM=3.00000015;
 UTC=2019-06-11 14:16:05
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-11 11:40:24 - 6.00010036
x-cbparentid: 19061114-9696-0000-0000-000067C162DC
Message-Id: <OFB982EA89.45144E18-ON00258416.004E2684-00258416.004E5FC2@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 06/10/2019 07:40AM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 03/12] SIW network and
>RDMA core interface
>
>On Sun, May 26, 2019 at 01:41:47PM +0200, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_main.c | 701
>+++++++++++++++++++++++++++
>>  1 file changed, 701 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_main.c
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>> new file mode 100644
>> index 000000000000..a9b8a5d2aaa3
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -0,0 +1,701 @@
>> +// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
>> +
>> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> +/* Copyright (c) 2008-2019, IBM Corporation */
>> +
>> +#include <linux/init.h>
>> +#include <linux/errno.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/inetdevice.h>
>> +#include <net/net_namespace.h>
>> +#include <linux/rtnetlink.h>
>> +#include <linux/if_arp.h>
>> +#include <linux/list.h>
>> +#include <linux/kernel.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/ib_smi.h>
>> +#include <rdma/ib_user_verbs.h>
>> +#include <rdma/rdma_netlink.h>
>> +#include <linux/kthread.h>
>> +
>> +#include "siw.h"
>> +#include "siw_cm.h"
>> +#include "siw_verbs.h"
>> +#include "siw_debug.h"
>> +
>> +MODULE_AUTHOR("Bernard Metzler");
>> +MODULE_DESCRIPTION("Software iWARP Driver");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> +
>> +/* transmit from user buffer, if possible */
>> +const bool zcopy_tx = true;
>> +
>> +/* Restrict usage of GSO, if hardware peer iwarp is unable to
>process
>> + * large packets. try_gso = true lets siw try to use local GSO,
>> + * if peer agrees.  Not using GSO severly limits siw maximum tx
>bandwidth.
>> + */
>> +const bool try_gso;
>> +
>> +/* Attach siw also with loopback devices */
>> +const bool loopback_enabled = true;
>> +
>> +/* We try to negotiate CRC on, if true */
>> +const bool mpa_crc_required;
>> +
>> +/* MPA CRC on/off enforced */
>> +const bool mpa_crc_strict;
>> +
>> +/* Control TCP_NODELAY socket option */
>> +const bool siw_tcp_nagle;
>> +
>> +/* Select MPA version to be used during connection setup */
>> +u_char mpa_version = MPA_REVISION_2;
>> +
>> +/* Selects MPA P2P mode (additional handshake during connection
>> + * setup, if true.
>> + */
>> +const bool peer_to_peer;
>> +
>> +struct task_struct *siw_tx_thread[NR_CPUS];
>> +struct crypto_shash *siw_crypto_shash;
>> +
>> +static int siw_device_register(struct siw_device *sdev, const char
>*name)
>> +{
>> +	struct ib_device *base_dev = &sdev->base_dev;
>> +	static int dev_id = 1;
>> +	int rv;
>> +
>> +	base_dev->driver_id = RDMA_DRIVER_SIW;
>> +
>> +	rv = ib_register_device(base_dev, name);
>> +	if (rv) {
>> +		pr_warn("siw: device registration error %d\n", rv);
>> +		return rv;
>> +	}
>> +	sdev->vendor_part_id = dev_id++;
>> +
>> +	siw_dbg(base_dev, "HWaddr=%pM\n", sdev->netdev->dev_addr);
>> +
>> +	return 0;
>> +}
>> +
>> +static void siw_device_cleanup(struct ib_device *base_dev)
>> +{
>> +	struct siw_device *sdev = to_siw_dev(base_dev);
>> +
>> +	siw_dbg(base_dev, "Cleanup device\n");
>> +
>> +	if (atomic_read(&sdev->num_ctx) || atomic_read(&sdev->num_srq) ||
>> +	    atomic_read(&sdev->num_mr) || atomic_read(&sdev->num_cep) ||
>> +	    atomic_read(&sdev->num_qp) || atomic_read(&sdev->num_cq) ||
>> +	    atomic_read(&sdev->num_pd)) {
>> +		pr_warn("siw at %s: orphaned resources!\n", sdev->netdev->name);
>> +		pr_warn("           CTX %d, SRQ %d, QP %d, CQ %d, MEM %d, CEP
>%d, PD %d\n",
>> +			atomic_read(&sdev->num_ctx),
>> +			atomic_read(&sdev->num_srq), atomic_read(&sdev->num_qp),
>> +			atomic_read(&sdev->num_cq), atomic_read(&sdev->num_mr),
>> +			atomic_read(&sdev->num_cep),
>> +			atomic_read(&sdev->num_pd));
>> +	}
>
>We already talked about it, most of this code is redundant due to
>restrack and it should be removed.

yes. removed.

>
>> +	while (!list_empty(&sdev->cep_list)) {
>> +		struct siw_cep *cep =
>> +			list_entry(sdev->cep_list.next, struct siw_cep, devq);
>> +		list_del(&cep->devq);
>> +		pr_warn("siw: at %s: free orphaned CEP 0x%p, state %d\n",
>> +			sdev->base_dev.name, cep, cep->state);
>
>Does it mean that SIW leak memory? If cep can be not-empty at this
>stage, what will be the purpose of pr_warn? If it can't, it is better
>to find memory leak.
>
Hmm, I would not offer that driver if I would be aware
of a mem leak. Older versions of rdma midlayer did not reliably
call reject in case an application got killed within the accept
phase (new connection signaled but not yet accepted/rejected by
application). siw ended up witha lingering connection endpoint
which gets freed here. I re-checked and that issue got obviously
fixed. So I remove that code as well. Thanks!

>> +		kfree(cep);
>> +	}
>> +	xa_destroy(&sdev->qp_xa);
>> +	xa_destroy(&sdev->mem_xa);
>> +}
>> +
>> +static int siw_create_tx_threads(void)
>> +{
>> +	int cpu, rv, assigned = 0;
>> +
>> +	for_each_online_cpu(cpu) {
>> +		/* Skip HT cores */
>> +		if (cpu % cpumask_weight(topology_sibling_cpumask(cpu))) {
>> +			siw_tx_thread[cpu] = NULL;
>> +			continue;
>> +		}
>> +		siw_tx_thread[cpu] =
>> +			kthread_create(siw_run_sq, (unsigned long *)(long)cpu,
>> +				       "siw_tx/%d", cpu);
>
>I don't decide here, but just for the record, creating kernel threads
>for every CPU is wrong.
>
>> +		if (IS_ERR(siw_tx_thread[cpu])) {
>> +			rv = PTR_ERR(siw_tx_thread[cpu]);
>> +			siw_tx_thread[cpu] = NULL;
>> +			pr_info("Creating TX thread for CPU %d failed", cpu);
>> +			continue;
>> +		}
>> +		kthread_bind(siw_tx_thread[cpu], cpu);
>> +
>> +		wake_up_process(siw_tx_thread[cpu]);
>> +		assigned++;
>> +	}
>> +	return assigned;
>> +}
>> +
>
>

