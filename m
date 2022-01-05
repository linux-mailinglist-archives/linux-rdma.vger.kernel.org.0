Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FDE484BD7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 01:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiAEAoi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 19:44:38 -0500
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:53409
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235646AbiAEAoi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 19:44:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxXqkGx5+oJVzq8gVODJIiVvMhu+3mvluftbPzQlZ5kwU810PsIWU05BxCackt/pYmwg6zPL99WHDzG+dmPeuiC7GXnWnfhNQ8Ti2Do2RBMSd5424jdVpFMjEUCD2CsFG+6If/IZmL9EdcaWy8Nxa+fWl44glGF8/8F8qOOnHAvsalqo8Gp/9Cw20WVNBwOkmsMsN1H1D+MvxQM6N6Tl3wPSAZoq+n/slFw0kBaauBbxfLaxLNpl/oVXQu4y1e5arZHeyqVCobLK8E3HZBP8XKs9R1q+wqBZYWL2xk6PUhTEvaeuec4A1y/L1c8xoNrytDa/eDd5bRCU7Bs6ssJvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHAGWQGmq9qZ0OzRVjL/tVrAdrREKdLh2RFi0NT8LHQ=;
 b=DjKA04fcYversRGGASlucdNNrG79SPAiu3LrzxsFT4MHXFU6OWL4hS3Y3Tafn2HRtoIVTvH+ejrW5twzSqZuW2DmYxnEqqetxn4WLl/9JduUKf4jWnMsL2HwEh8mdKFwXU3K6CJG8cFfeAJvFsVCpA7p4c/NbSDNHwQEiuoy9i8qK5othqoGMyWv+WLfscknnKm9VhSA/l8DDLRTuqCy3Jss9vlt0SGObq5LIbnfFRpRlFS+gcS3Tbq1ZeXpudB4YhEre1nwL9dRVwY83zNEi114XGTrdijj2NM1T6qHmgP9KWD0QdfdFm7xRUeLGM9Z7fYjFxtgAs69XD83R+7DbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHAGWQGmq9qZ0OzRVjL/tVrAdrREKdLh2RFi0NT8LHQ=;
 b=OmN0i+KH3ZaZscPuJX4xLHqsRRd34GS+nzcFPfp8ilYTTEVK6J8bNjzEB8/kRRGCSUc9vpJowWJ2Zo4EgLJjeY5QBsdEE4TMcTpPWnXPH5YvJQPadPfowqGVS5YgbngrJkRGrZzKvV2oTYT0/0KPmwc3daOJljMO1LgAXdt2E5EgNY+uiQzR5IE2kVxb2Jz3s/HipE11ynK1CxGny9JNcovPLdmcwc83w0UzdL6VsvVGsPc81cC3080vMQmmzBfq+kel56JbMUnpZPfSydtl5fh2f60PCS1XJrQN2HuC5UaeFaHYKLuUl6ccY2SQDFRr8LW17YxyF5PW6akF56AZ0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.13; Wed, 5 Jan 2022 00:44:36 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 00:44:36 +0000
Date:   Tue, 4 Jan 2022 20:44:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com
Subject: Re: [PATCH v2] RDMA/rxe: Prevent from double freeing rxe_map_set
Message-ID: <20220105004434.GA2712053@nvidia.com>
References: <20211228014406.1033444-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228014406.1033444-1-lizhijian@cn.fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5307b665-bc5b-49cf-8b48-08d9cfe48c42
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB54784D73137D121BC4CC7864C24B9@DM8PR12MB5478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvS7zRDLawTnjvZxehgkkhaQDSH2lrtG+qy/gBM+ATs/3HRSiTkbLFaT0zAxmbGNt4/W1sDQpNG8AVyHg/gtX6XaDhQbiRgoVDI9jDO2YJjNcsc5X2/d9HMFklEgY7BUwDWv66JfLHZaSwXxLq2oMTc+gb7xP/DvxYK80IO2hCwbVaHYnhW2WdU44h0AVyeBvFAP5ObJNN+nYUmi/tFjqlKmSFov05OpDaFw7rNXLWav2sf/5T9Ow2QGPA67FRnHdglOmtxbwacnusHPfaIl5Mt/fSnOYOXZhQZs0EsUc7AX3BjCqycclxqC+pdRJyZL1VHktxGKn16WCsZgFb443KuQTSzKlPtYn6vgoFvBFbHVqOLiYIKd0nDwALfsW7gK98pPGVzHH6wlXSxgaQIAyiH4w76YaMe+jVXsT/GSwD+wN5uJTwcBC3EkXhX2KHgOKyS9bN+oq+DEjZU0tmlhiaUXo9SFj1QMy/EaAxBmaYYTOlox9D0X9sCPpHT06NjkbvOjt0pSFOdOyi1LksqAEMQHjBralAVYB1+eftNEUINxaYVZhRmai6ep5JxNRve3ti2NUjLos6oTKZ17crXN+1TI3cpw+0+W5MPFbdTzTOVBOPrCHvwMFmALyN8jcj0ZuOVn0Bzn8pebHwJ8OqlY+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2906002)(8936002)(6506007)(1076003)(33656002)(36756003)(6512007)(66946007)(66476007)(38100700002)(86362001)(4326008)(66556008)(186003)(8676002)(316002)(6486002)(83380400001)(2616005)(5660300002)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8tVWgXEtA+jBYFKeariipyIbQHSWvIvUfGNPoJtymHJeXDBLoyrbApGCbrAx?=
 =?us-ascii?Q?K3ICpWoliy2iA0ucUIIIsIfYIa19vLctg5yuaF7/8SBbhrOCqq9dY6O09TWa?=
 =?us-ascii?Q?935/Q2ZUvqBirxIOuVSCqyGpT0ZuUPdCNNo31Z+j20npvRMUNuiUH8mJotv5?=
 =?us-ascii?Q?yKWBDUKzeKm0Xx7+TxIdVN1ObseaZN1lUEaJMnSoCAVnq2UWTtD847mJliZP?=
 =?us-ascii?Q?SkoWg3HUb2BXCVUni6lELHyMXl0E0alqjQNqGG9dyIC/U9bYPmSu5xIe3hW5?=
 =?us-ascii?Q?GPGGXEdCCD/m7X1S7F6jEve6bJHhPpyJx6SiQw0ipFgFcktYUQjBmINB22Ev?=
 =?us-ascii?Q?IK3OmS9VzcSdHsRwcw4BTeGCwuJJROL7OSiB+1XT3bcQNZQKDkNuvS19lffl?=
 =?us-ascii?Q?zcsY872f98K5KIRZZsCPK4H6Qnf841/kykaA6fEM19NYK3hpyZ0beQK11XX1?=
 =?us-ascii?Q?FhexzyGx39IlARQ1yjwQf5G8CcB1HxKYqLRknAqRMVNLJiQ0vT8t6xxuwIfn?=
 =?us-ascii?Q?atjYz4bvhZJ8iJk6ZJxItu3oORObh0O/eQ4N5hY4C4XTu6d3F2yLA9gLC8IF?=
 =?us-ascii?Q?dxxjbwrA6ra7CPzUmxTMjwhxznGt6N1QZOvX7OxWVbcoB2RlP0/H0XUtcAuI?=
 =?us-ascii?Q?2DH9o/Uh0/wvFvv5Tec2QDyBTKvsllqIH6qTJQAj+VZINHg3dlkxYn0/8rT1?=
 =?us-ascii?Q?diOO2LRQ6C9Sl5q4G5CbOtjBIMeMrtYKaji4UnyeTRNpsyQ0hK17gvRjqo99?=
 =?us-ascii?Q?qj0yLLNvuBu6CAzQFwiU9gLd3396KURaYvekv31xYlme7akGBqSzZcJWfXNt?=
 =?us-ascii?Q?VKK+NNPDkzTSn4guv4p2hhksw9Duh95QGzg1XdSqF0cwYWpG9tlrKnZeJCX1?=
 =?us-ascii?Q?bg7qDsz2uvBYvW9zVQFpoykk0dQho4Z5+bsioFzpclw5yuYYYZ2eBTmHv3yl?=
 =?us-ascii?Q?vxA7bT3CTmHZcQ18ntKNc+6onVltcgTcKQdCq9sJf1K8zWWgczf3A4SI0njG?=
 =?us-ascii?Q?JJnym/ioECtZP3WTsKIyulFOEAGj7SgAc9mxNfIe4w8Xf4g+Cq01OlQyiETb?=
 =?us-ascii?Q?fXfG8duhGin2rCxR7umuyG6saFr81p+XbEn5gAJ9CThHIz9JPMsyuwtResC9?=
 =?us-ascii?Q?ucAIDQp5X4eqF0w4RX1NRizu6zH7FVZRWbVOPxqWdhSp8yuxOeSmRc1TD606?=
 =?us-ascii?Q?OJVxzZVx/RSiuG8tm8S/ptwwWMkHV4ZEPbbttf7m9+7KgyW7JscKnOBJD3CJ?=
 =?us-ascii?Q?vbxJHMrUl0wSD/cMsJ+iUv/0W3aFyD0ozjW3JbwveD5ZZHbzMbaA9E0AVA/z?=
 =?us-ascii?Q?GJQWYM+kUlQIcpq0H/n0L4Z2XhO946db/pa877iG1b+vLGEvxOL9ZZ5zOxJR?=
 =?us-ascii?Q?t5RGnfptpITp7yvnFtN8P9H9Z8IDkYvZwH0SYGeQRgavDLm8Rk4q32IpqWhm?=
 =?us-ascii?Q?SIrtShb85Y7PHamZddpWHCqdp0I6CP84fgaOyeOkxq5/D4j5+h2+c+lwn0af?=
 =?us-ascii?Q?XvlVWptZ76OKN4PTF+ftYhl7ckg4KwxvsxaEpD5+TX88iylNs58U82wi60E0?=
 =?us-ascii?Q?z5w5PtbgWl5Jw4uUnPU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5307b665-bc5b-49cf-8b48-08d9cfe48c42
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 00:44:36.4486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUS/xyVCsgS4guGRiL4cTrTc6lUVHACrVoT/GeITtL/yFKrEucpyjMZoc2gfdX2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 28, 2021 at 09:44:06AM +0800, Li Zhijian wrote:
> a same rxe_map_set could be freed twice:
> rxe_reg_user_mr()
>   -> rxe_mr_init_user()
>     -> rxe_mr_free_map_set() # 1st
>   -> rxe_drop_ref()
>    ...
>     -> rxe_mr_cleanup()
>       -> rxe_mr_free_map_set() # 2nd
> 
> By convention, we should cleanup/free resources in the error path in the
> same function where the resources are alloted in. So rxe_mr_init_user()
> doesn't need to free the map_set directly.
> 
> In addition, we have to reset map_set to NULL inside rxe_mr_alloc() if needed
> to prevent from map_set being double freed in rxe_mr_cleanup().
> 
> CC: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
> V2: Fix it by a simpler way by following suggestion from Bob,
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-rc, but I changed it to keep the goto unwind as is
normal.

@@ -135,19 +135,19 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
 
        ret = rxe_mr_alloc_map_set(num_map, &mr->cur_map_set);
        if (ret)
-               goto err_out;
+               return -ENOMEM;
 
        if (both) {
                ret = rxe_mr_alloc_map_set(num_map, &mr->next_map_set);
-               if (ret) {
-                       rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
-                       goto err_out;
-               }
+               if (ret)
+                       goto err_free;
        }
 
        return 0;
 
-err_out:
+err_free:
+       rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+       mr->cur_map_set = NULL;
        return -ENOMEM;
 }
