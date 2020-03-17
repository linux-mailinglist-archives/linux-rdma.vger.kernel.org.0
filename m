Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE9188676
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 14:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgCQNz0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 09:55:26 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:33166
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbgCQNz0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 09:55:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9yFu9isIg/6W3leIeSV14Uxsl/rNAwVuTSM5B1A6z9URxg3oK86n0hJ4+2bTEbsDhW8SP1SSprIgKx7du+EThN5YA8LjVaBLHkpukaKffLCzwtmoaBsCnnxpNBKVTmRVnCuK4b/JhxLae8mJqJfOSsnf5d7NcDMOkuXnChrnRFZep9jZ9OKOsINL9CH+aTNCAwNrQlciYt9CPOz16QggckrQhOL6sMlEW5CB9UCRaPgmPH302FciZgsmFY2V6sSvTeselIUpF8CkLSl+Aa0DcoYjYsaIPefAg0Xv4fNs6Zly6Zh4D3cWXPkHascvSQ3u9BJ5k6VZFq6abhvLO0AdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFT6+HHXVEoYukrvO8Wm2VfJe1B7JBgxggF4zzHWQ30=;
 b=Tv/M692yGVGe93myWNOHiIuzrtK8XjWZ1UHMhAqLPw3jV9QIU++jTs7XbLhWME4MVdfp1Qz+fkKD6Uahfi2udShDAdwWpdgC+bot9XM4Cx+5Uy5E2joaMFrfHxqTZXRJdwf8Uz4b/kOzBGTbgiNTVtxvQcd3gX4fLgdoSSz+O7nX0/VhrfrP37NVkFKG+jNlZyvJ93+ilFbHdz6IEVsXL3q/bEur+x1n8jaksAa1WSJSZ/YaSbNvCPD55S2z9NOsFEJwmriXbtjtBBbJOHrqSEy7pWwOE4YalaCcnR6r8ckZL4FXbx3O8SmDCMDH7AK2vqDnXGNf1gAbCmh0mHBKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFT6+HHXVEoYukrvO8Wm2VfJe1B7JBgxggF4zzHWQ30=;
 b=np1tc7Tc3FTmkBex8R7JU8eCbVDwhUerwOvnozEVyyfb9SHJX9GHbf60QzCKT2cX8gE11qPv6MgPk/kiOAYNf0CqU/YhSr2seqefDgfIU8W0tSx1gHZALZI8Ee9HB2nnCLn7azFxqJHNBc5UPMzvVXvxg7dpECGh9hgvQJM6vyE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB5638.eurprd05.prod.outlook.com (20.178.93.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 13:55:20 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 13:55:20 +0000
Date:   Tue, 17 Mar 2020 15:55:18 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
Message-ID: <20200317135518.GG3351@unreal>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317134030.152833-2-maxg@mellanox.com>
X-ClientProxiedBy: AM4PR0101CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::19) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by AM4PR0101CA0051.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 13:55:20 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9cefc1f7-f6ee-4bba-9052-08d7ca7ad4e3
X-MS-TrafficTypeDiagnostic: AM6PR05MB5638:|AM6PR05MB5638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB56383B11679CA8C0C199DAA0B0F60@AM6PR05MB5638.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(6636002)(1076003)(33716001)(316002)(33656002)(52116002)(6496006)(478600001)(66556008)(66946007)(81156014)(8676002)(6486002)(9686003)(2906002)(6862004)(5660300002)(186003)(16526019)(81166006)(4326008)(86362001)(8936002)(107886003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5638;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2bRZb7nRpoWsEHtvAjV6WLtmOksUtst3AtmP9lZcQpogLeOp+9IMTK6OqJWL0w5WZ3zimDsRqGqtUd5+VgW7pqVVuJN9xi8TXuWyM1wGd+cH/QotF93F5Eim+Er2d7ZxziiwR5AjAKV/AcZUl52HaX9FxmkkzCqOykvVHCBHHK1dfJM7to+s22aCCKv9cpTtCUxrT26q6zM9wV5pyR4Z4GePrKGMJEfANhb7D5TqIiO83K5mReWeL9T7gZDImA56VZs5L7Yj0PT9Vtr+3kexiv+tO9iuKUibMiGIqVgA/ihP/YDueZTGKGm/QFOIwRzRUagw6DAotMEGJTFaf3Rc+/HEl0+t+asc2ZsHdQoybOQ14T0SVceWT3sQZbetuUzE/+ktjZpj17grIGu1SsvpD0IlXB/Epfg3hfIhNFGVF5S742OJq/yfj+MIWY+IaJF
X-MS-Exchange-AntiSpam-MessageData: A+GaHkPSxnTCkeRLMcZqCPfGRVjMR7qNMvZAQ2RGlPRTUvu73e9yUxQ2Hj9qQx5qlSK60akDz2VfnctmoIDUmfHRhGlq27VcthtnTD01bPB53PCHQ7DL2a6Zj1RJwLEtBE9swIyLhdPG3Txpo3qbkqjH/pcDXZXvEMk9RPhkkxo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cefc1f7-f6ee-4bba-9052-08d7ca7ad4e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:55:20.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMAZ0kd7ROuPBQs1g8agkSUHmV1Z8wH84g+lDhJt5g1bGrgiif0SCtjjt3eRY12AzPTrbXT4X9vzzhFu+pKgNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5638
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 03:40:26PM +0200, Max Gurtovoy wrote:
> ULP's can use this API to create/destroy SRQ's with the same
> characteristics for implementing a logic that aimed to save resources
> without significant performance penalty (e.g. create SRQ per completion
> vector and use shared receive buffers for multiple controllers of the
> ULP).
>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/core/Makefile  |  2 +-
>  drivers/infiniband/core/srq_set.c | 78 +++++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/core/verbs.c   |  4 ++
>  include/rdma/ib_verbs.h           |  5 +++
>  include/rdma/srq_set.h            | 18 +++++++++
>  5 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/infiniband/core/srq_set.c
>  create mode 100644 include/rdma/srq_set.h
>
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> index d1b14887..1d3eaec 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
>  				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
>  				multicast.o mad.o smi.o agent.o mad_rmpp.o \
>  				nldev.o restrack.o counters.o ib_core_uverbs.o \
> -				trace.o
> +				trace.o srq_set.o

Why did you call it "srq_set.c" and not "srq.c"?

>
>  ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
>  ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
> diff --git a/drivers/infiniband/core/srq_set.c b/drivers/infiniband/core/srq_set.c
> new file mode 100644
> index 0000000..d143561
> --- /dev/null
> +++ b/drivers/infiniband/core/srq_set.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
> + */
> +
> +#include <rdma/srq_set.h>
> +
> +struct ib_srq *rdma_srq_get(struct ib_pd *pd)
> +{
> +	struct ib_srq *srq;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pd->srq_lock, flags);
> +	srq = list_first_entry_or_null(&pd->srqs, struct ib_srq, pd_entry);
> +	if (srq) {
> +		list_del(&srq->pd_entry);
> +		pd->srqs_used++;

I don't see any real usage of srqs_used.

> +	}
> +	spin_unlock_irqrestore(&pd->srq_lock, flags);
> +
> +	return srq;
> +}
> +EXPORT_SYMBOL(rdma_srq_get);
> +
> +void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pd->srq_lock, flags);
> +	list_add(&srq->pd_entry, &pd->srqs);
> +	pd->srqs_used--;
> +	spin_unlock_irqrestore(&pd->srq_lock, flags);
> +}
> +EXPORT_SYMBOL(rdma_srq_put);
> +
> +int rdma_srq_set_init(struct ib_pd *pd, int nr,
> +		struct ib_srq_init_attr *srq_attr)
> +{
> +	struct ib_srq *srq;
> +	unsigned long flags;
> +	int ret, i;
> +
> +	for (i = 0; i < nr; i++) {
> +		srq = ib_create_srq(pd, srq_attr);
> +		if (IS_ERR(srq)) {
> +			ret = PTR_ERR(srq);
> +			goto out;
> +		}
> +
> +		spin_lock_irqsave(&pd->srq_lock, flags);
> +		list_add_tail(&srq->pd_entry, &pd->srqs);
> +		spin_unlock_irqrestore(&pd->srq_lock, flags);
> +	}
> +
> +	return 0;
> +out:
> +	rdma_srq_set_destroy(pd);
> +	return ret;
> +}
> +EXPORT_SYMBOL(rdma_srq_set_init);
> +
> +void rdma_srq_set_destroy(struct ib_pd *pd)
> +{
> +	struct ib_srq *srq;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pd->srq_lock, flags);
> +	while (!list_empty(&pd->srqs)) {
> +		srq = list_first_entry(&pd->srqs, struct ib_srq, pd_entry);
> +		list_del(&srq->pd_entry);
> +
> +		spin_unlock_irqrestore(&pd->srq_lock, flags);
> +		ib_destroy_srq(srq);
> +		spin_lock_irqsave(&pd->srq_lock, flags);
> +	}
> +	spin_unlock_irqrestore(&pd->srq_lock, flags);
> +}
> +EXPORT_SYMBOL(rdma_srq_set_destroy);
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index e62c9df..6950abf 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -272,6 +272,9 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
>  	pd->__internal_mr = NULL;
>  	atomic_set(&pd->usecnt, 0);
>  	pd->flags = flags;
> +	pd->srqs_used = 0;
> +	spin_lock_init(&pd->srq_lock);
> +	INIT_LIST_HEAD(&pd->srqs);
>
>  	pd->res.type = RDMA_RESTRACK_PD;
>  	rdma_restrack_set_task(&pd->res, caller);
> @@ -340,6 +343,7 @@ void ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
>  		pd->__internal_mr = NULL;
>  	}
>
> +	WARN_ON_ONCE(pd->srqs_used > 0);

It can be achieved by WARN_ON_ONCE(!list_empty(&pd->srqs))

>  	/* uverbs manipulates usecnt with proper locking, while the kabi
>  	   requires the caller to guarantee we can't race here. */
>  	WARN_ON(atomic_read(&pd->usecnt));
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 1f779fa..fc8207d 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1517,6 +1517,10 @@ struct ib_pd {
>
>  	u32			unsafe_global_rkey;
>
> +	spinlock_t		srq_lock;
> +	int			srqs_used;
> +	struct list_head	srqs;
> +
>  	/*
>  	 * Implementation details of the RDMA core, don't use in drivers:
>  	 */
> @@ -1585,6 +1589,7 @@ struct ib_srq {
>  	void		       *srq_context;
>  	enum ib_srq_type	srq_type;
>  	atomic_t		usecnt;
> +	struct list_head	pd_entry; /* srq set entry */
>
>  	struct {
>  		struct ib_cq   *cq;
> diff --git a/include/rdma/srq_set.h b/include/rdma/srq_set.h
> new file mode 100644
> index 0000000..834c4c6
> --- /dev/null
> +++ b/include/rdma/srq_set.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR Linux-OpenIB) */
> +/*
> + * Copyright (c) 2020 Mellanox Technologies. All rights reserved.
> + */
> +
> +#ifndef _RDMA_SRQ_SET_H
> +#define _RDMA_SRQ_SET_H 1

"1" is not needed.

> +
> +#include <rdma/ib_verbs.h>
> +
> +struct ib_srq *rdma_srq_get(struct ib_pd *pd);
> +void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq);

At the end, it is not get/put semantics but more add/remove.

Thanks

> +
> +int rdma_srq_set_init(struct ib_pd *pd, int nr,
> +		struct ib_srq_init_attr *srq_attr);
> +void rdma_srq_set_destroy(struct ib_pd *pd);
> +
> +#endif /* _RDMA_SRQ_SET_H */
> --
> 1.8.3.1
>
