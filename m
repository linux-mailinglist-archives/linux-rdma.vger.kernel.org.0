Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60E555A275
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFXURh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 16:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiFXURh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 16:17:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77D823B0;
        Fri, 24 Jun 2022 13:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4mQuEwrL7V4tT0SwKL4XLyidHSr/GsdaKa9iCJfZr/QH/fHdY+IuPvR6TXLGYiVfn6IZpnI9uDf1ZtgpVzdqIFHuRbkZfjdEJocDlp8o/fHq2sfbQCFAp4bJGvTzuvfCSiDszLKvQXhHTCBT6I9er4UZRgwfNALzCFUavg3YkM3K4V+AtnVJfWO1sIdcqS61Gj66NYXNfUdYeB+90S4mY6hGzJmwe4v1l0/0U7TZyPWR1WCvF2HY6X4VLkFt4Kz0knAvtA7KgEA92VIo6719a8EURCLGlGkcf+tKbXpy48k66THJxMaIobihUaFk8r7BK1UiC2M/bIHTESZ58zQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHJKSTmb0JocfdJgnT1iUZ89kEOKKuOPceCp9F7l7U4=;
 b=F01Z5ujUYzFKcpsYzySfn5k+mKO2MAPS566rG7aH/EjqqOYI4QIY/YYQW2NhbDMtlUU0XH/2sy7pD7BykdC06zn1SvozZKoby8+rYIfWuyq/4xMNo+2PYsjVIo58SyGE3GlXmMnT+o2hV2ZyfUtsN80RszDcCjAfAV9kJqzQsCmLgXN5Q6Kbxm9vnlmUIrYj+x8jwEviQiB1ElwWux7kH24xPZIwrAIT5JxTYIZdaNaoq23skXdT7HhbGRE52ynEz1+n3IZ0xtNVmA4g6bMYVxykE0PQfYe8BVAnxlebjgQ/m6pa/1ozNTtGhG/YZ8ZLtyTLZcA8DRgGNAXdJi/Aig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHJKSTmb0JocfdJgnT1iUZ89kEOKKuOPceCp9F7l7U4=;
 b=hFwyMZXUUJCrI3a2/RzkyhyFSQm4P7WgYqMdDezUOJYQeQYTdkU64On9dPmyM64c4s/5fzaOUu/Vpj8F1k+AEURezrbClrdTzVj6s84h7RDHtcBjLAARO8P0izPlo8rkCtc5j9b2jmf9Walz+LeVpKlprL0vHAo1FkghyoZ7jEUGq8sSY2RIy8IsYQ++tAwZBFyEkjEfKZJ5z3q8ppmuOVD6yI9Wbkas4V8ZOBKILbg9Jv3Csh5xiJctO3jNk1kNpzFzIlsRxIgr2/zMmb+Y1Ij84Oe+BItwJXnEbnCGbFcdJtfqZipivbKmYCgljNzIL2DXTEvG1/nKL9ki28Elmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 20:17:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 20:17:34 +0000
Date:   Fri, 24 Jun 2022 17:17:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] RDMA/cm: fix cond_no_effect.cocci warnings
Message-ID: <20220624201733.GA284068@nvidia.com>
References: <20220610094530.28950-1-jiapeng.chong@linux.alibaba.com>
 <e187af34-d0a8-55ed-cc21-d88845ec1eb5@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e187af34-d0a8-55ed-cc21-d88845ec1eb5@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1265c336-b26a-420a-2539-08da561e9307
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glCt6IQu3rXijD1RB5In7SSjh9p8iRPeIcQPV/NSjNWUVJFqYe8q0Jch8nb7VrQqbGGm/yT1o6SSMZ1FBcC5etvYWVVIpXDvPuvo260/48GqL6Yz6exuS021D6f4hdxbX/OcCLwGjLxi8TwWA7nUK1P+YjJ5XaLUHUgE35UFUwpPQwNBb1hKqYmxly2wNpcs6hFtcD0nVGrmzodHKD2JgvYrQXW1RVpcKVUnQTSjTEeltqIoCnhHiqRU3zLByE0SG+CgfcO4WAlwiXXDGFOqpdHzPd+FKQN0SBeaXfXnm/h07UqLDvZO67s2qLhvii9wKPD2sFiTZhcfIcnaJGZrMEuWqGPHD2jyhiRtZzKmDsWw8Ru1il5gyBtSaGFdiRmwhHHcYGjQQi4YmoTiPAZhkd+DDxeNXd4iQPF7p+rCYtdm0cE2h1/GRD6+wXevD2wqa+Z+1K+7cM7YwUST1CujIHo0mE6AeGwZHaiZFakDzEEwaQIyyl5kiQ1LWu0fp3QV3TrRdp+QlXCrq96Dg/J/4zLypUwfeEpy5rw0RL/XHGocKdFidgSVXvHdSHl/x4kUaiunJKixD4UecYqDkpp9XGxbCvBKOV6Z6gGCvxfg616XFEYteQTqDNT4rlpW0ppFa8SIivEkMcNqLDtxPkYmSwjVPLPsw2FwfYJsXMQzIfHU1isA0HKbxihLax/sPCijUee/kPxnRVStQFjx6aF35XAbX4H8qxJeM/wtiaTYhjjv0K22ZpmYqfyZ0uDJo4mv3KQ3ky4SUH7vYC8dpHyedmFrLMQwAs1Uv1Uc0Miw8/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(83380400001)(478600001)(38100700002)(6486002)(186003)(2906002)(33656002)(5660300002)(36756003)(6512007)(6636002)(66556008)(316002)(8936002)(86362001)(41300700001)(66946007)(4326008)(8676002)(1076003)(2616005)(6862004)(66476007)(54906003)(53546011)(6506007)(37006003)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8SpWjDHCYiIFm7KVsLTISqwVOTTrhCHltJXXZgkfi2FMV+z0dLNFiXq1nK0x?=
 =?us-ascii?Q?6dKvCkCz0RkvOvc3WkUd21dxSa7b3lV0aF0L2X3eG8rU3mcEJdSBzdSsGOTh?=
 =?us-ascii?Q?qEsPEwPoRICGbWWFWt88Vx89qKUFxT7EtfLZZxtPw+5y8C34fgHENcjDXtqB?=
 =?us-ascii?Q?CrvyZaDK81xRBxbK6u14WlIqs+NTrU90Tb5bYVLzkjtbmLAuEgm5e2io9Y0c?=
 =?us-ascii?Q?Uv5wT86ybSfoaWkqG3VVxPNDykKIxDjuoD4CAqQJe4BDIPmHYQ069UBMUO+I?=
 =?us-ascii?Q?a2pL3tRZZ83KtR7DOu1bt4OQUlet/sW65naZzYnsGZoqLt3O/eb9v0skXY5g?=
 =?us-ascii?Q?QRn8FDvzCyFLSUUzD8rxH+bi71+c9BqlkWRKKGnIKNI1wzfIoUJbZXZhkLc8?=
 =?us-ascii?Q?FRynrkUXXlWy+zYzTN8TFTJ5T3GrTGXWalmfupOLcceDGO999BS3aclyF6BA?=
 =?us-ascii?Q?CQYmBbnu0O/m8Tw3JAB0OP++mhXS6rfsFtnFyFsnYcCQRFn9OJWZSKUi6+Xl?=
 =?us-ascii?Q?V7eOFUAaKNuw95DpvyHhdzA+1cd1B/zltkjbEnLhWuBsHdhjRAewCWlTu+VD?=
 =?us-ascii?Q?5aal4pSy8Zv+pRH/9+/ChFUzbiL5ZDRq2bDDQ4OK2+/uj2ZBNah++5RlAwnr?=
 =?us-ascii?Q?xIhqF+moqSNVHKMHGNNgqD/LoN+QT7/Ec+LOCe4+7Sh9b5lu06cdXrtV+fh/?=
 =?us-ascii?Q?7gl4dxJZJeCZAteIkRfiYEk2sfGZZVV1F3BDQ1ZDfGm3fVZxaKgrESctv0DB?=
 =?us-ascii?Q?vQcNEZ30UBs0QMDckNb/so6dGeaSVg2jY5ro4t2uCTtyU4vdT77XsHk2ZuJ2?=
 =?us-ascii?Q?P0Qp5kYIKBgsrFVhKshzLIsXkVIopXJFp3fbNf4LV79m6Hb7eM3YLM9Irb6b?=
 =?us-ascii?Q?vAS9N5JKvvwaKis5BlA3TAGz7dGoHxpbgiBisou20tnFwi0i0xgNcy2/foRQ?=
 =?us-ascii?Q?ixn7JXh90Ze9geqUv1km7VxEwpC3Yzh1HkImgUAj8v8MPAExXnCBsB9yy8/c?=
 =?us-ascii?Q?nCBHbGapdUff6ETROTc0epPlCSZYsuBcJNve6IfSh5fU9I3ZGlCyFcTTrYb7?=
 =?us-ascii?Q?sWhhR3A2iEGVXyqegFU/2k8Y3SNY49axD29aXzTt7P7WSa22iS4YzC1TT3W9?=
 =?us-ascii?Q?VW54UbUX/rQuVMMwiiSJqvXGv8hkMwuiiMyuV+ZAaU4KyOBwg+C9Fe+D++HY?=
 =?us-ascii?Q?R/G9+t9hiCBAl00CgnLG5qmhEwft8E1zboDUe6iE2uRIyX8oWCuC8r9+S7Oi?=
 =?us-ascii?Q?WN3PPh4Lqh65mKllb5zTjykR/0whPOVPcdsDCgXkTwm4IAl8E2KfsY+zC6Rt?=
 =?us-ascii?Q?9AagEUfeoIwA5zBJdUZPDbYZE0xcWUPJdbgBqMXnKOXSx/VKaw14OSkKzkyL?=
 =?us-ascii?Q?KcG5eb054e/fg8G+ksBrl6sTi9TdizxbFofjOyXd1Cs7w6d2s/TcGrZkC4WM?=
 =?us-ascii?Q?N+spfjngvJL7KIyCYIHJOqV+TMvgISniLuh78JB8ut0cVzlb/B1ZfvZaoq2Z?=
 =?us-ascii?Q?Bjim39NwikRsbSGjr7dTMMbO0mKPzwXvN/pm2LxfVpIOU6UFseqSXqz/qv6j?=
 =?us-ascii?Q?bJB8HSk8fWP+NvnIqaHp9TeLHeMJ//ywtl/iMjVw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1265c336-b26a-420a-2539-08da561e9307
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 20:17:34.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0Dqmr58Twx/41X+7vfXgb6zTDC2sM0+/oldZlJXIIX4Nr6xf+ZK5KZa+OGxAu1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 14, 2022 at 09:19:14AM +0800, Mark Zhang wrote:
> On 6/10/2022 5:45 PM, Jiapeng Chong wrote:
> > This was found by coccicheck:
> > 
> > ./drivers/infiniband/core/cm.c:685:7-9: WARNING: possible condition with no effect (if == else).
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >   drivers/infiniband/core/cm.c | 9 ++-------
> >   1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > index 1c107d6d03b9..bb6a2b6b9657 100644
> > --- a/drivers/infiniband/core/cm.c
> > +++ b/drivers/infiniband/core/cm.c
> > @@ -676,14 +676,9 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
> >   			refcount_inc(&cm_id_priv->refcount);
> >   			return cm_id_priv;
> >   		}
> > -		if (device < cm_id_priv->id.device)
> > +		if (device < cm_id_priv->id.device ||
> > +		    be64_lt(service_id, cm_id_priv->id.service_id))
> >   			node = node->rb_left;
> > -		else if (device > cm_id_priv->id.device)
> > -			node = node->rb_right;
> > -		else if (be64_lt(service_id, cm_id_priv->id.service_id))
> > -			node = node->rb_left;
> > -		else if (be64_gt(service_id, cm_id_priv->id.service_id))
> > -			node = node->rb_right;
> >   		else
> >   			node = node->rb_right;
> >   	}
> 
> Not sure if the fix is correct, e.g. with this condition:
>   device > cm_id_priv->id.device &&
>   be64_lt(service_id, cm_id_priv->id.service_id)
> 
> The original code gets rb_right but this fix gets rb_left. Maybe the warning
> is complain about this:
> 	...
> 	else if (be64_gt(service_id, cm_id_priv->id.service_id))
> 		node = node->rb_right;
> 	else
> 		node = node->rb_right;
> 
> Besides cm_insert_listen() has same logic.

Yes, this is a standard pattern for walking tree with priority, we
should not obfuscate it.

The final else means 'equal' and the first if should ideally be placed
there

However this function is complicated by the use of the service_mask
for equality checking, and it doesn't even work right if the
service_mask is not -1.

If someone wants to clean this then please go through and eliminate
service_mask completely. From what I can see its value is always -1.
Three patches:
 - Remove the service_mask parameter from ib_cm_listen(), all callers
   use 0
 - Remove the service_mask parameter from cm_init_listen(), all
   callers use 0. Inspect and remove cm_id_priv->id.service_mask,
   it is the constant value  ~cpu_to_be64(0) which is a NOP when &'d
 - Move the test at the top of cm_find_listen() into the final else

Jason
