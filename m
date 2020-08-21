Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537C924DEC6
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 19:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHURnW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 13:43:22 -0400
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:5025
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726870AbgHURnV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Aug 2020 13:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPLd2z72N0zHBpm2esuIDtCZheIj9Z4wtKw7QcYsk+Fx4hgDo88f1P0jjFLo08NWj5NfreZWO60dC7o4v7uRY79tcMSAKwP6njOPTpWYLtK21N6bqSnDSMTskROfLfM8DNftNPcN2pxUz16OCCMnVckLSOwjYO6DZOXAy0qRFb84N5NcDV1OhbUsTXs9GNAq4yiPfMNvyhdO+i38rZbr6xNYqsoHFANo3LW0PQ8wXtghY9CKiArqnZz+4UovY/ZVc4tibvUFqDMFf1h1Ezhtt/8MK4JWKY7atLPF4Fcy7oZn7Pvhvbm1AcfIiAV5DX5PIm3WV/Zbcuw33BPBnHQzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir5ocSeRJ6+mUYPmruVgRCy+pQR8AWg78IBsyA7SB0A=;
 b=e6GOHV0YxlE59LkHV9OXIqiE9Eme4DMoO+7Wtw077OjwJgfOePkdwQ99QhW+KXXGf5jsinlNRAghUP83BYVLDFoaNK4y5O0W9rj2IEWo2gQ80X6EWLAsPfw2sTNaj+S640hxeh8Ru+5a4NJD9JUSenGgq7F5wlHsAktl1RuhBY5yAyGWHp1iNQGs7mpcD+FkqKkyCrXZsvPNWBrJb0VAvW57c+DbBF/YgNlbaNJhE8DQhlo4W+nvScD3E8+nSuprco6ijNXT+dLQy405eiQkpWmMwc54kseSGd44mH9SeDbctVOnNtRr9LyJtWoEM4OpIudSIyW+e5WJs1iRQ28Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir5ocSeRJ6+mUYPmruVgRCy+pQR8AWg78IBsyA7SB0A=;
 b=fHnmEcC6CRDwhhepQZEJ4kewZk9CVQde2KdhhvhSz5E2CYjO3EAkglEMqQ8o1MXvypJc3bCnQteaFLfAlrPftmmrSuFQOITFPV7ODblm7wyYaRPxBQNsfACq9bNySZ6gs/+hYO+u9QIE1IIiZY0u93f5ZVf2YiMr+k1WZvlQ/mc=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by SJ0PR05MB7422.namprd05.prod.outlook.com (2603:10b6:a03:280::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13; Fri, 21 Aug
 2020 17:43:18 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::dd13:644:c295:2ef0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::dd13:644:c295:2ef0%7]) with mapi id 15.20.3326.010; Fri, 21 Aug 2020
 17:43:18 +0000
Subject: Re: [PATCH for-next] RDMA/vmw_pvrdma: Fix kernel-doc documentation
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20200820123512.105193-1-kamalheib1@gmail.com>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <ac9d933c-47d7-100d-0ad1-3e87e9481105@vmware.com>
Date:   Fri, 21 Aug 2020 10:43:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200820123512.105193-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:1d0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 17:43:17 +0000
X-Originating-IP: [66.170.99.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3e8864f-9769-48f9-20d2-08d845f9b04f
X-MS-TrafficTypeDiagnostic: SJ0PR05MB7422:
X-Microsoft-Antispam-PRVS: <SJ0PR05MB74227E3B7B55BC71E6F094E2C55B0@SJ0PR05MB7422.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJGRbamK2JXcWYJ7x7qvooMza5XOKU79VTsbrIHugr+fHcyOQFE1THVFXiWgdf+B/D0VMSob1BAWRNvZ1++iioKELhx7Zs9/obo9PUfQA5GzC6J3nKXXCg6CJx7Fmbeg6UztYr8lfEl5mOvedU92p0kKpCC+8CkTULjhMDa15ddlMZD0HuHxjzBh5zSfbkvXfXy+ndWQ4e/QjaqGao/VDRFuwwRXDPGKDCgScQ1oKqoK84O1EkFsFvQSNNXhGFDWI6eJ/gurk3zBVb+lEAqIITccpIhoM1lMiEvZsMBVqH2/RorVtXDnPXrcLzmP+h3cQaT0Rgoi65qtuJEpftsIkmYkp5Te+rCVccQ03SVK3yfl6zSsYvQB+av02rnKUgT/rPinOQRP+CoX33SLBVStCR4t5T19lTptT3+cEQ+ZiIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(66946007)(83380400001)(16576012)(478600001)(4326008)(8936002)(53546011)(66556008)(66476007)(5660300002)(6486002)(86362001)(316002)(31696002)(26005)(186003)(6666004)(2616005)(2906002)(110011004)(36756003)(52116002)(54906003)(31686004)(8676002)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7roarEHE/t2EbZTXZQ3oxExM0K3VqM4F1/JRLksvPSzxvxF9zEwRN5XnfCEOzO90YlnJ/j18xbO4JzSqRidtQ2sFbwF1LRFVWFKtvhn8lg5aXPscRlWT9j2k+F+0ZE9ryDm38NYmZToMKKsWKHexnc5QbxRRgwwSbQI+bj6cGdoqdck6fBx67RFcZLQ9PLOtf+e6iyVyy32HkfgUpT4IJ4eLdOxvR2N7AqALIY9bXX3gCI3IeJWMYPQ5MB3wl6Dezm9JNLozwjb10piOMPBWxov1PXXSqI0UhHKcryY8Z+LiStUHsBU83QeqGKH5gb2A0hGRBBk8tKC8NkNTNZoz04/KxvDdALIQLqIcOaA+WMOuRKvsiXziKn6/6qSI+e7YsjIhbeJ/pJh+d4DZXtJk06eIBYOepJi8W2rKIqn9PF9subiCXODwv34EWz+KkHnZQmKwLvgBrClPQWbaxxLcDcUO2uMqbBCPJ2RLumzos+IHR9tX0V25mIeTf9OvYW5FM1kfYmG3wKQWod/awdiKC2rFH6jgC8jRRI/K22Gsb5/XkI6q0eURJJjfWS20KZGUHbm5a55YrcSX6tCdJM7CEqOeXr5vmiG9FDf16HaNcUCcO/RFXIeLEErQvpd2Fc1BcDv82ncnlUe5BB8MeOx8TQ==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e8864f-9769-48f9-20d2-08d845f9b04f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 17:43:18.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07go3M1mCOE8ICscxg7dFvFfQqWnsUjveqhk5tLB+ba0Fq0h/wH3zhpKpicieFWPVKeMhmPs1VZx/+qIPEhbPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7422
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/20 5:35 AM, Kamal Heib wrote:
> Fix the kernel-doc documentation by matching between the functions
> definitions and documentation.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c    | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c    | 1 +
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c   | 2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 7 +++----
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 

Thanks!

Acked-by: Adit Ranadive <aditr@vmware.com>

> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
> index 4f6cc0de7ef9..01cd122a8b69 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
> @@ -375,7 +375,7 @@ static int pvrdma_poll_one(struct pvrdma_cq *cq, struct pvrdma_qp **cur_qp,
>   * pvrdma_poll_cq - poll for work completion queue entries
>   * @ibcq: completion queue
>   * @num_entries: the maximum number of entries
> - * @entry: pointer to work completion array
> + * @wc: pointer to work completion array
>   *
>   * @return: number of polled completion entries
>   */
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
> index 77a010e68208..91f0957e6115 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c
> @@ -270,6 +270,7 @@ struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>  /**
>   * pvrdma_dereg_mr - deregister a memory region
>   * @ibmr: memory region
> + * @udata: pointer to user data
>   *
>   * @return: 0 on success.
>   */
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
> index d330decfb80a..f60a8e81bddd 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
> @@ -90,7 +90,7 @@ int pvrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
>  
>  /**
>   * pvrdma_create_srq - create shared receive queue
> - * @pd: protection domain
> + * @ibsrq: the IB shared receive queue
>   * @init_attr: shared receive queue attributes
>   * @udata: user data
>   *
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> index ccbded2d26ce..65ac3693ad12 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> @@ -502,10 +502,9 @@ void pvrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
>  
>  /**
>   * pvrdma_create_ah - create an address handle
> - * @pd: the protection domain
> - * @ah_attr: the attributes of the AH
> - * @udata: user data blob
> - * @flags: create address handle flags (see enum rdma_create_ah_flags)
> + * @ibah: the IB address handle
> + * @init_attr: the attributes of the AH
> + * @udata: pointer to user data
>   *
>   * @return: 0 on success, otherwise errno.
>   */
> 

