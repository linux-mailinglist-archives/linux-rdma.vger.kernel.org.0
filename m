Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BDD2A79A8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 09:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKEIwt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 03:52:49 -0500
Received: from mail-am6eur05on2050.outbound.protection.outlook.com ([40.107.22.50]:63649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbgKEIws (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 03:52:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMM3ly8Vi3r0Oob+8kFTjaabiXQEKYRN81pib/BxzUJe8aGUTgBtJ1uwnt3sPBIC+5rL6YYaQ3xGwAQ6Ma1vnmFLz61IH5K+jf3I/veeQIg1YpJV2UasaGWiKKGsfceTPhA6dYHgRgmtevnWoeMX5m+08FWwUWj1dJJElvzpiyc9LSJMzgwKCTSbG0IpsIBr0nOxGwyWo844ZwZw2AUBVippHvQnr8mspzbP3oB40XVspanV/f+bUQxxZyk1WBOddqFmCL4NwLY9aKsuIc4mpsikdJtdcY64XpnxdacbCPrOFzR3Zm+NLGrEm1zxgkozEdi6wSQQbdhPq+LeMyFzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usYIq6ArO5tvX9DB3w6Dz5XSyyphpRXoniQxebcJFaU=;
 b=hWqPtRAeCZ5RrCyeqqYjHXdxlzI/Dk8PgKwV6MNj8uAwhN/xknSzQphqyGRYvcEblMmGXWEwjSD620lHSoFzKrkrUEyTztXZbCaofLymrm2rFzHFt6E81cGGugJiyzjOD6QYWMPur3pXIY7uxZ/jTMwu0A8A2JON6Jol0ex2EfM2Yj3UX2WTuAzdcY58tEpe1MuE9EPezXokX1j2lx8Pazp3wa5qXhdsF0SECZP9fEtDtKfyPq9pe9reHf+Axuw2Xjqac+seH1LZ0yMk6HkQeuVXW25Rno2/4ghgjOfdm23n+FYt3aJfgX/DPQkdO1wI64zDGDJQUAAwNxh1tWSffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usYIq6ArO5tvX9DB3w6Dz5XSyyphpRXoniQxebcJFaU=;
 b=LyeSOeKV15iUfGd50Uk3T8T/rcZQqmb41uPvgVzr5prjlkFv2HKpGpaPZFpbxdvPQh6SdLNkGUya35pfa+g42Y43Fq351MUtoOpHoP4f4ZxDloyqmRwf9mAyY/S+KSIwtS40jp9RbXQ87cedhB0Zm7Q7V+VUkgeJwmRc+vs5BNQ=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM7PR05MB7137.eurprd05.prod.outlook.com (2603:10a6:20b:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 5 Nov
 2020 08:52:45 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c809:3cfb:d4d5:6007]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c809:3cfb:d4d5:6007%6]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 08:52:44 +0000
Date:   Thu, 5 Nov 2020 10:52:31 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] RDMA/cm: Make the local_id_table xarray non-irq
Message-ID: <20201105085231.GP5429@unreal>
References: <0-v1-808b6da3bd3f+1857-cm_xarray_no_irq_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-808b6da3bd3f+1857-cm_xarray_no_irq_jgg@nvidia.com>
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (216.228.112.21) by SJ0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:a03:2c2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 5 Nov 2020 08:52:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 436c7ed9-8cb1-48ae-716d-08d8816828e7
X-MS-TrafficTypeDiagnostic: AM7PR05MB7137:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-Microsoft-Antispam-PRVS: <AM7PR05MB7137ACAC37F35F3266A82535B0EE0@AM7PR05MB7137.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qeok2nUf8d9htCkbLJ0TPhroKDoQpgdJQQdsOCEqEymMtexaxR7RZ+dgGai5itO6+aSSwA3x6ajsacuDYFdOmnqhXfHEPL4blAhp0oXKwLspZa4wX3N3FZkzAaVPu6qeH5lc91gZCgyElPVbeqAe7hP524J2W2qXtuGQl/Bxzh8GLON/Yk0KHPgel9CkZXJtcrEcf22OtZd49kg7KpLwx8opaqsdQZOl38bn9hVSWeWLRL7MCs6P0cXjMX+ue76Mkx83NlmCc5Y/QsWcnMKezawHyzW9vV9iZOyKf/vD689FrlzgGWhPXRwaakfoFRx9uzoPSlmpCEb+9c0gQa7auQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(346002)(376002)(39860400002)(366004)(396003)(4326008)(2906002)(478600001)(52116002)(956004)(86362001)(66476007)(66556008)(6496006)(33716001)(9686003)(66946007)(1076003)(8936002)(5660300002)(83380400001)(33656002)(316002)(186003)(6666004)(8676002)(6916009)(16526019)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V2c5bIhtPMR8I9/HXCtTkFOCRHcTudEsINVmEZUD/vi0ShLhNrH2uzHybKl9Ytvw5lvaSD4Cw/1iHKYUZe2T/aiYMoHABURcJvLTT1RaEfaU2TMmMS7o6mdz87iDLqp15R6Y3M3wbEOV2RKyrlWRdGFO4X28TDDKLz2EDDIQ8iiAGFU5g+TF1uaxZ+rcYSE5ORfFnn0kuh4eqovcq+2d/UeQFCCi9ZlAFxPaDjhqL6BjG+f3KUPjZ6jROY1Pgjz4fVOxR4uciWaZrFwHFvQj0pDIoqZxay+j79g8NVungiPDnM1qcuKY7Zid3z3JVbiJpW2gNJKujB5U0OArzVJ3bl7xDfKNL6muKeNfeRsyXuJ+FDt2MH10ADCobynE+XbJJ79yDJ7U9J9MyCSlOqfjg1i3gi+YnKMTbRrwSTRs4kGIBs7ZytGY07zGYxD2xoOQuueZeRpQpZX2uV0TdGHceE5jT7MGhJ5sXTrUZz/mD4NFJjqpOJWgfH77tpviLAs3zdYhNQgRqt7482ZR4jLMhTDu9Mgr21viO0xVvMoHNF/VMllIaSzjCHOE7zSqZjqafngN/wcNE4Di/a4hJc2vtVjCaOUWVYMwDBJqB0UPpOWiCY+0i35KyR4X/FPATNG75EcWATTo+vmOBQQenuifpQ==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436c7ed9-8cb1-48ae-716d-08d8816828e7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 08:52:44.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtoADNsMaM7oDQ/amUGxt0Xy0i1nmhufUs9qU8zPaTy/PQtvsSyrADXxIQMGi9TAx0sQUx2evosQQPiTkAXREg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB7137
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 05:40:59PM -0400, Jason Gunthorpe wrote:
> The xarray is never mutated from an IRQ handler, only from work queues
> under a spinlock_irq. Thus there is no reason for it be an IRQ type
> xarray.
>
> This was copied over from the original IDR code, but the recent rework put
> the xarray inside another spinlock_irq which will unbalance the unlocking.
>
> Fixes: c206f8bad15d ("RDMA/cm: Make it clearer how concurrency works in cm_req_handler()")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 0201364974594f..167e436ae11ded 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -859,8 +859,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
>  	atomic_set(&cm_id_priv->work_count, -1);
>  	refcount_set(&cm_id_priv->refcount, 1);
>
> -	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
> -				  &cm.local_id_next, GFP_KERNEL);
> +	ret = xa_alloc_cyclic(&cm.local_id_table, &id, NULL, xa_limit_32b,
> +			      &cm.local_id_next, GFP_KERNEL);
>  	if (ret < 0)
>  		goto error;
>  	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
> @@ -878,8 +878,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
>   */
>  static void cm_finalize_id(struct cm_id_private *cm_id_priv)
>  {
> -	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> -		     cm_id_priv, GFP_KERNEL);
> +	xa_store(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> +		 cm_id_priv, GFP_ATOMIC);
>  }

I see that in the ib_create_cm_id() function, we call to cm_finalize_id(),
won't it be a problem to do it without irq lock?

Thanks
