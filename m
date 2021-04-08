Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F79358334
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHMZc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:25:32 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:55649
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229741AbhDHMZc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 08:25:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHrdA6gbjWXaSf14zrYtrJ65EYW7TQoHux2/7KKb5mvFPfOvJw3VJlvPxioxN8R+/2a4/Yr0Vo3m4jFICJ9YwhnBk2q4pdTx/P+xZLNu+cGEkVkchh19lWLNu/nkT9jOg5sCuLlhQPCNUGsfPYdx3l3W9RmpcntQxJtzBDKvilt1HVW1MKdSUOBOrOV6RkeMk4Sp33mHB5c8TqcOKii3fVfnuyeITRoaiIUHXQI8K35/ZCN5N8gM29tty079KtcTzMmgIkBBTsM6g/1tSWHZKopx/7omwDm7QWQRloFEp0EcW2u1KGcKSC4jNnlbYXVFDsriKnrd7FGwRPLgWkv7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqY6lSTWfKWS6A1Jgmo4YBunbB9YNBqjCAbYpxeTy9M=;
 b=Nowuab5MkES4i2uHX0BOYzMc6myJdWInL/QoQt2UcrkHE71Y1Ixekobpu/auqyVNU1YLl4vWqQn8gGSDc/sXHLqcDkZR1JKpjmHJHuiU6jj2qH7LyBbK5SRbaSJBJLfKigjpLBiR0viZobqcMjsu22cyTuu07wpSZX4hjXNADDiY/NlLfrxFi8wHa7uSknIvj40DmwqueBmUdmKUd0Ks0eRnOvGCyX8lREHz/O7Olhwfkjn0ugJweEUy1o+9WvtM9eTUOi5IqwO+io+ayOZmt2BMZC8GPGQYZdqOrbsgFo9Li0DTiDqWuGPZ+C2oVdJ8/Mf03CkQ7M4ck4EovIoG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqY6lSTWfKWS6A1Jgmo4YBunbB9YNBqjCAbYpxeTy9M=;
 b=Mr9pgKg4ReZM589QKw/1VVzowHqWLXzJWl/ZeGI4cBawmItpLVeL6KES7dgbsSifWdQH9arGO6smXrgyacKBD+9Rq0YrN/L7+HxLogV6vsfrSspU8PVowMr3VmSNmegqRxE4R6ddhvV//AXOHVy9upEXZ8K6E0Ro/Yy+q/2Xbu299Pbw1sHbpqGHpH4DgCP0zzEp/Nmi7adswmWLKbrzLff5W1Ce3o1h1/WGyHPkNMbmocv9urbmUFFoynWRxw3SPJ7gPooiO6RZVSNcQks4RUNI84bs0sk5YKqdONwcaw5dSJa6/16Mf/TvNS9ctJIvrWIjXLgZUs77IGg7aFgzpA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 12:25:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 12:25:20 +0000
Date:   Thu, 8 Apr 2021 09:25:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Unify RoCE check and re-factor code
Message-ID: <20210408122518.GA645599@nvidia.com>
References: <1617705423-15570-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617705423-15570-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:208:15e::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:208:15e::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Thu, 8 Apr 2021 12:25:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUTio-002hyg-V8; Thu, 08 Apr 2021 09:25:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b4e7f8-1acc-4b0a-a2ba-08d8fa895fff
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4010DAA5300C8E396B94F4CEC2749@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hH0Sgd822jDTGE0pbdTklvJzoblNbphfObpah74472zI8t8CeFLOgHCAewzmrGjqTnB/1eZV+M/2mMRypyWd1bcn0vJkR94rc2gbyuhdmxUyZm9FbpQZkbbfdiq3nrC9awRl5nMWWXP6uCR46EbNUGou9y0PBQekNyO9Qq1RxXWWzvlzRXN0FiUhz4AaSQG4ZR2s7qxth/tyRyHdgrSI6vhgthwYG77DQHQa+Ykjy6AxFzGD1kR2wxsAVVhhlgEiLp4jnsdJCNl8Ip0Z3XUq2Z1xla9bgvmwP8yUmkJ2rP9R7j3S+GpxFy53g1Zie1B6JATRTmy+cG06FQyTiQj7GyzzQduWoTJLcR/rLG5BP9Mvdgzo2J/FTA3oM4iXvN7LQMLpBXMI2oEmHfsDy1pJQgZp73uvbWktWmVL4Xt9p6cYdZAWt1A6cUJOzAir6vkyJ8VZzXt+OtLmpfJIpi8R1GWzjJUdFNH45JJZnlIF1yoRhNH68LW7vslMyFbpYsZkhz2ygfeKdqEUv7RHqHWHZnHkjuTMfoOgdZlZatAD9jZ5/yNrBQnXCwJWWI8ZG2uK8K2u8+z3CYJtstAxYUBpfcKGhucnxR37VJz96IEnyRh6hL2tp8O/WXx5pVqTYk/Y9Ci+CT2Myso0zB/Sxj36bUvZ3nH7geJpIF+Pklo9nPxvI0fmjVcnTJD3uO2huVJ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(8676002)(38100700001)(8936002)(426003)(33656002)(478600001)(26005)(9746002)(9786002)(66476007)(316002)(66946007)(6916009)(66556008)(2616005)(4326008)(83380400001)(36756003)(86362001)(2906002)(186003)(5660300002)(1076003)(66574015)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z0F1SXk2Y2NpSGt5ZW1IbUlDbHRvejk5Q3dLeVUyR2E4Tk40TUIvdVZ3STdH?=
 =?utf-8?B?eWcyWGZ0bXpRU01MeCtzTm80Vmd6T1crSEVTV1U0NlFjZUxNaGN1azFRUTJq?=
 =?utf-8?B?c2lqQTRJalJiU0h5Ni90SG4rSW9sTE5PWVk4Y2hVcDdmbUdOVnlxdGw0RmY2?=
 =?utf-8?B?akVHRXRpRHcwWkdxUGUrcTR3c1FQRGZWRlIwQ1J5Qkg0WXVtZHIydTlGKy80?=
 =?utf-8?B?Y2k0NUlkTkFNK21NWjlDeElxWGp1SE5WQ3kydXk1UjBoMXFuaE1MUUl2UVZh?=
 =?utf-8?B?Vy9WTC9zaXA0TjJPK09uaHFHWVFwRGVYR2h1Ym41Y2d6emkya2VDVE5wUE9i?=
 =?utf-8?B?ZmhiVHA5dWtRb045VDk2NXMrakhkZnpWQURUbENqZGxVbWhHd2c1Y3VSM3Rm?=
 =?utf-8?B?L0tZd2syVW5OaGVOT0ZIaXp6NDRZOWpReStGQWNWVTI4RWhYTC9uY2ZKMHFu?=
 =?utf-8?B?bVVGSUp5U2dnb3d1WmFUL0VQUHZ3T2ZCbHJCWGU2OFQ4cWdXV2pwdnRLUUtK?=
 =?utf-8?B?YzRVazlkRkc0V010NzRtNjMyeFdBdE9rcU5ZWHYxQURpaW1GSlQvZ0h5WFdk?=
 =?utf-8?B?d2xQMnFzcWUzNzFCdTNSbFU0dm9wbUV0Znk2R1d4Vml1Y2dKWmtCMXNLcTlF?=
 =?utf-8?B?OFN2QTFTQWl3R3FUUmVoMXlsRGpiOG5CSEYyd0FrN1lUYkFvaXZ4ckVOdmRo?=
 =?utf-8?B?cXdUM3ZMNHBUL2poazdmUTJxZDJGMzRQeEdZckYvRDhib3doaXpqOVJYNXBM?=
 =?utf-8?B?d3pVRC95STRyR0FsRE5YTkxDdmFLVnk2ZFY4bW1NTTVUTW85elgwRW1abEtm?=
 =?utf-8?B?ajhYa0JwUmlJRWl4YUx3eURIZStabkRRVDRPQTVJbGpzQlREazM3MFQ2blRu?=
 =?utf-8?B?K1FrVXhpTXFGa29CRkdiTlg1K2NIRnNmd0dDTi95dEhsNU1jaWE3WjJWcXhv?=
 =?utf-8?B?TlJLZ21oN1JjbkZ3N1gxcVRpSnY0elp3QjMzeHcrczhVSC90QytSc1VjQm1G?=
 =?utf-8?B?Qk9VMmdkUzY2bC9hTlhac3B4VTRvRUlqcFJRdy9PMHNZWGJaMGs0Y1lIZWdG?=
 =?utf-8?B?MGZPN3l0ZnhEOGFBWUdLdGYzUzNZTkVtemFhRXFPV3BOd29oMkJoZHErR0JV?=
 =?utf-8?B?bjZJVS9KaHdoQlV6SDR1VFJGSlVoYjN5emEva0NlZDZQY0FxclpXYnp4TFNQ?=
 =?utf-8?B?SzdpNXNkNm80RFFmandsQmlFbSttbmZuaGtIUU1wakp3ajVXQ2NyUGx3NHRE?=
 =?utf-8?B?WE9WR3h6YmFaOGtKR3VQQkp2ak5SaVpKVlJwQ2FoVSs2dkhWVEhuakVUcXNR?=
 =?utf-8?B?RVVFdm5Od1U1Nk9LR3ZBbXN4ZE5renpIZnZXSU5nWXJxb25wakpOR3NrV0hW?=
 =?utf-8?B?UXdwVTgxeUQ4Qy91TDlycXM4SFNvQWh1NU5sUExtRVFKT2VOc0VidkxqK3dV?=
 =?utf-8?B?SmhqbjFVV0loRUc4b1V3LzdSa2tRVmdHNW14K3dxSjFKNm0zU1pZMDZIKy9h?=
 =?utf-8?B?SEdMZUZHeHB5WG82TWhicHRhZW9rSzZoRUhKczFMdUcwblp3cUpQTUh3NVN5?=
 =?utf-8?B?U0ExUFJpUHJOeUdDb01WcFlHOExOYWNuYk90bTJBc2dxeDRiUnN3YlVGRlBo?=
 =?utf-8?B?bUV3dTEvREZ4YkFaN0w5bUdaZlk5bC9ueDdYNVpUSjZmbFpYZytvNTVUTGVX?=
 =?utf-8?B?TnJvVnh1ZkZLY1RsRlJxeXYrWElsZTkzM2V4Tm1uaEZ0dEdBWGtBcW5PTGcv?=
 =?utf-8?B?WVVaWjFjVEhYYzBGN0tNeTA5aFBUZUJSM2VCZE84UVBrWHVQN3ZXckRlWlhq?=
 =?utf-8?B?cUVhaGlYSjJhNUV6OW5ldz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4e7f8-1acc-4b0a-a2ba-08d8fa895fff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:25:20.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvg+hqFEOXKQr+DDLH7DXDWs70+JVfjzsca9sLgP8laAh/oIpM47hzgknNtibVzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 12:37:03PM +0200, Håkon Bugge wrote:
> In cm_req_handler(), unify the check for RoCE and re-factor to avoid
> one test.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: 8f9748602491 ("IB/cm: Reduce dependency on gid attribute ndev check")
> Fixes: 194f64a3cad3 ("RDMA/core: Fix corrupted SL on passive side")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 32c836b..074faff 100644
> --- a/drivers/infiniband/core/cm.c
> +++ b/drivers/infiniband/core/cm.c
> @@ -2138,21 +2138,17 @@ static int cm_req_handler(struct cm_work *work)
>  		goto destroy;
>  	}
>  
> -	if (cm_id_priv->av.ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE)
> -		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
> -
>  	memset(&work->path[0], 0, sizeof(work->path[0]));
>  	if (cm_req_has_alt_path(req_msg))
>  		memset(&work->path[1], 0, sizeof(work->path[1]));
>  	grh = rdma_ah_read_grh(&cm_id_priv->av.ah_attr);
>  	gid_attr = grh->sgid_attr;
>  
> -	if (gid_attr &&
> -	    rdma_protocol_roce(work->port->cm_dev->ib_device,
> -			       work->port->port_num)) {
> +	if (gid_attr && cm_id_priv->av.ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE) {

I think your other note was right, the gid_attr cannot be NULL when in
ROCE mode, so we can delete the 'gid_attr &&' term too

Jason
