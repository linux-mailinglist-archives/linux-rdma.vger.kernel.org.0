Return-Path: <linux-rdma+bounces-559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8D826F3A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 14:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5814928273A
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5DA41229;
	Mon,  8 Jan 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UBxbHvpc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7D41239
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jan 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGPlM0OT0KGZZtin6T1fwGXByHn04vWeHk1MeYivwSlhlXlZpQayi0raCh3v1m6oM7rr7v6ZdgaCs9Q1kM0sz5ooJWkQGV+XIBFqWkmOZw4cFLy2wDZURuFTOc3RFr+dsOHuYjmx5pY99GufSt+0lXiZh5ZLx2CtvnyspNQfXgFvJncsSrrgt1SyJbCvyMMUhHjiCdefVe3ZqVZLetGn17c76Hbm455tkLH6eTMtkEGTH67fq9v4KsXnMzSwimprjd+F+D39kCr9OZMMl1bBblMzXY6Kr2nDDdfPBh1vTw5dXhehf79GfbaWiXlR9UvjIHbaGCcfkc4/U4fwm7brLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADqOmHlPFL1cXSR6+NBDIpybGtYNcQz0YmV/jNDi3FI=;
 b=Qs3Lk+1gM0MAHAGX+BSZhaty3vBZgKV/ucRp9SA+bN+WQwK2YsgnBvO23kvl2FygYAu9lYQwLBQmJpm1VXtnVQcQTVzHQ7l56lGdKGzAMQ9PC1hBa6Ci4SrO2y++EZt7xxycRjijQjp3vi+USfhKBitKgpoc4zFOXto1tTa6D4QX9FrIr2brEhQVp2q0VGJStGR9RWL+mHB3i142WwMlNOxTH2f2slwX11RP7UKkNYCPBZr9NtOBZgTj9Z3jNZLGAd+NyJEGCrUFE76Jz7CXMufjDtrvlRwBX+FPialNRQzNx0W1UTX4CRZNhjNIkz+XI/mvvXe9lCT6Ah13TQ0nlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADqOmHlPFL1cXSR6+NBDIpybGtYNcQz0YmV/jNDi3FI=;
 b=UBxbHvpckmHqCt4fKCj2nJmUCHLq9nhmMI6e3jebMY2Jvbp0Cua9el49hbdpvX21T6shKZkSSL17mlSPSDT/lphyEl2cLEA7GowduhNCqnFCEjyAg0Zw5t3sm6R2pRXHRQ9KwIT18H7+LX68BdLditm1NQAUNDysKqYAWnHJhmSx4POjjkQpIQ92t2oRCQFWKtxQNholdjP20s2khyHbL414V5Qmd2A6D5scf+u/I2IQrhLl7TY0fSuWLY7mBwIo5HAcH9EQlLqCg2q4UO7mk1FxWKlVb9dU3N4SGJ1Zdl/vrKlUgu6JmUnl93qo7CDY7geInZ6sojLUFrar0wW28Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:05:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:05:55 +0000
Date: Mon, 8 Jan 2024 09:05:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Michael Margolin <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Message-ID: <20240108130554.GF50406@nvidia.com>
References: <20240104095155.10676-1-mrgolin@amazon.com>
 <20240107100256.GA12803@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107100256.GA12803@unreal>
X-ClientProxiedBy: MN2PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:208:23b::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e0364a-4bda-4561-ceaf-08dc104a8cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7+5dAZN8sfQ9wMfi7k4STZlc67R6JFteySFReHp2ZdF8DYedNVdmZUErpX1v3IhJEuGDKzQAadw/AerEcsWENWozqUQvdccodJOoI97rFsp7rv/QheZDuaDssV7FwC6cYkdkU80eudtaWnN1D+oS9OW1kw5rSrLVPMlIOdIlUAowCfoBOfFEv2hS9dXpLpVnVOeebJs2NH0Fe01k0jBekmMxCk4AhFd57q0z6irDKPAwnQYg0Jsak0XPBkdwwdFhklqfohp4WwQLb6eQMQmuJX1nCiP3zUxA1UByyP2SDmnNQ6Isw5QfuutwU3/tK0Qzz6BtnZ8wbGrDjBKmI9Kd7xTQN6W7YLu/K1BG9QnTzcWKxawwWIKy0Pd9qS19lcL5NXWqYTo0B/6enGms+ofS1NTMaid+ie7v11OqtkcMnNLcetQsCGK6M4nzP5zBovvWHVLlZJlo+PV44BUkF7M/mnKODe2IZSAdSFlCXTxqkcElFS0nIxtzRJtnZ1UMfL45ygTDUMK0Y2m5UWuyMAfktaErlzhlS61sEfz0cuN8x3LUWxlFBScj343dHKa55YTTcaoUpI3dgNRYD3jlniVRf4JvC9ZMQp97TSLJu1TLK4c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6486002)(1076003)(26005)(2616005)(478600001)(6506007)(6512007)(83380400001)(5660300002)(2906002)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(54906003)(8936002)(8676002)(4326008)(38100700002)(33656002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zh0GPWz7jd6HybOmfXODTiIzCgkLcoVoVmx92pch24D3WedxAzFzxyRp5sSi?=
 =?us-ascii?Q?hnk3Gt2onYyoZz0OJHysB8lfK5Ff/k7sEMM6AzyXHJ9E1L5sVBsSE3Vy3TDk?=
 =?us-ascii?Q?W1I7pZyh8/LZBw5YBhN7yHwJ+gw8H/0yrY23w6kEjGtXu58sgyzWDyz9/PqH?=
 =?us-ascii?Q?0qQj4FFrzLUV4S+ZUVZaKDlSDUOVaBgPjbNfgD+ROz4w+2Palj0VtV2rvaCb?=
 =?us-ascii?Q?IqSlWSmebcfWtoHSA+iLd+xa7GwbnMaLJSzi7JxSraXOeJsXJhDPV053Wxoe?=
 =?us-ascii?Q?C5jez9ntOeR4/afXBrGfN9F7YKZVgKZ6sjlf/uFU00muxiGaatPkYFZeKhQU?=
 =?us-ascii?Q?+2ywdn8zcVTmgkOshiN00BI4X9+UWsrC2SrU21iigAUKNdthbZEvd9MTc2o3?=
 =?us-ascii?Q?jMG3zeaEH+hk6YnN+Dvw9FMkw6QpP+l0OOaz8YTqwSfpa66HURnOh8KaVEVI?=
 =?us-ascii?Q?PtwkgEaQkZ2XvHQWDroChgkfCxYBlTUHA5Ryf+gqwd3nqo/cdPyMRmxXZH+4?=
 =?us-ascii?Q?0bwZG3pMEMzX1OWoKreV9Q8y4cjeEk7OdT8Fu+RVo0BqlTenTQfkHd+FOhY/?=
 =?us-ascii?Q?y5hPeyZaBV7c3VY+axcnFmWB4Yxai4HQoiZlALgnEgEwDCf1jOUgy+jZ7Moa?=
 =?us-ascii?Q?36Of98BQpAxR5VQWRIfM4XoWUVfW3Z6//1vWNboRChEfmsYVPYIhJfrisWjt?=
 =?us-ascii?Q?dcpC4LLlLoKZBkew1FxHVeG+btt6drhgIAMhptU7x/d0tw87Jo0dbDwssrkw?=
 =?us-ascii?Q?RM7uemri2FLS4RflQBFfy+0sW3KCkmC9QCy+rojFS4LjWLALkbahqepmVkaO?=
 =?us-ascii?Q?rRu8Lm2zOntUx6GySjeb8GLLMJJLwZcgTo2UMzcr4GNoU9qISVjmYHcK1gaV?=
 =?us-ascii?Q?P7AzaOfPJz5fdnLYWEOaPhlKkWfzXAIgRpxaimhElf7G7zgYmK4/tCfVQfEp?=
 =?us-ascii?Q?Nxj/tZDTPyKuMTQeHpWfnnhWFyWlTzB8Kq7QVa9BKwz/16XFV12XoZS1MS60?=
 =?us-ascii?Q?+1VEXymnV2+rfYhCdeZwpGjgO+ILmjvZfhHn1m1FUA55NjOlIIu0xquBycrL?=
 =?us-ascii?Q?+7Dw+rqE3NTFE6kCajyqWQ4NHK6XCJjQ2Iqp2y/5gHhgbB5DZtH6k/3QcUBX?=
 =?us-ascii?Q?FVXAzgu7NHHPnh1V1Vna4NLhycvFlTaug7/9zWx2aHVLTmvPVgnjk5ahukFP?=
 =?us-ascii?Q?S4J8QLKGeU1+1y6peUr2l7B71evuHVlqF6qzl8B9nzi5/AKrAhTMgU+uQAVd?=
 =?us-ascii?Q?NS47ruOVZaA2ibKKTegoH7iMASxuYRhJoGZLOEp3ERylBN8jRSQBPObrPOyW?=
 =?us-ascii?Q?0iWpxRNQ96DR9g4D02pkZZU3mcJy/L39qvF5/uT1FhtK33TefqqVFYtGhkbi?=
 =?us-ascii?Q?cQVU1YAdPvRplxcLJrZwjkOFrpD9RFc27hEjC3eslQ9n+8ftf+uSzQnlS+yR?=
 =?us-ascii?Q?jUG+drSJAEJsgMk9hSbizKzw52okS/wrwBdUiH6UszlQ5cLBDOS388EdUvty?=
 =?us-ascii?Q?KAm8Fi/Shs9SCJTMLordKNcK7hxDh61HmDLotzVBaEcgTa81ECtdPbzpAVIw?=
 =?us-ascii?Q?zx9dWfiUNiPoJ/aPe6s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e0364a-4bda-4561-ceaf-08dc104a8cc4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:05:55.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZ8EhIGC9/ipqq2FoypwseiS412ZeQuNBODD25P7h633+WFNJLHs799YmfxFY5M9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660

On Sun, Jan 07, 2024 at 12:02:56PM +0200, Leon Romanovsky wrote:
> On Thu, Jan 04, 2024 at 09:51:55AM +0000, Michael Margolin wrote:
> > Add EFA driver uapi definitions and register a new query MR method that
> > currently returns the physical interconnects the device is using to
> > reach the MR. Update admin definitions and efa-abi accordingly.
> > 
> > Reviewed-by: Anas Mousa <anasmous@amazon.com>
> > Reviewed-by: Firas Jahjah <firasj@amazon.com>
> > Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> > ---
> >  drivers/infiniband/hw/efa/efa.h               | 12 +++-
> >  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 33 ++++++++-
> >  drivers/infiniband/hw/efa/efa_com_cmd.c       | 11 ++-
> >  drivers/infiniband/hw/efa/efa_com_cmd.h       | 12 +++-
> >  drivers/infiniband/hw/efa/efa_main.c          |  7 +-
> >  drivers/infiniband/hw/efa/efa_verbs.c         | 71 ++++++++++++++++++-
> >  include/uapi/rdma/efa-abi.h                   | 21 +++++-
> >  7 files changed, 160 insertions(+), 7 deletions(-)
> 
> It is already fourth version of this patch and not a single word about
> the changes. Please add changelog in your next submissions.
> 
> Applied this patch with the following change.
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 8f4435706e4d..2f412db2edcd 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1748,7 +1748,7 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
>  {
>         struct ib_mr *ibmr = uverbs_attr_get_obj(attrs, EFA_IB_ATTR_QUERY_MR_HANDLE);
>         struct efa_mr *mr = to_emr(ibmr);
> -       u16 ic_id_validity;
> +       u16 ic_id_validity = 0;
>         int ret;
> 
>         ret = uverbs_copy_to(attrs, EFA_IB_ATTR_QUERY_MR_RESP_RECV_IC_ID,
> @@ -1766,12 +1766,12 @@ static int UVERBS_HANDLER(EFA_IB_METHOD_MR_QUERY)(struct uverbs_attr_bundle *att
>         if (ret)
>                 return ret;
> 
> -       ic_id_validity = (mr->ic_info.recv_ic_id_valid ?
> -                         EFA_QUERY_MR_VALIDITY_RECV_IC_ID : 0) |
> -                        (mr->ic_info.rdma_read_ic_id_valid ?
> -                         EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID : 0) |
> -                        (mr->ic_info.rdma_recv_ic_id_valid ?
> -                         EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID : 0);
> +       if (mr->ic_info.recv_ic_id_valid)
> +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RECV_IC_ID;
> +       if (mr->ic_info.rdma_read_ic_id_valid)
> +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_READ_IC_ID;
> +       if (mr->ic_info.rdma_recv_ic_id_valid)
> +               ic_id_validity |= EFA_QUERY_MR_VALIDITY_RDMA_RECV_IC_ID;

I was saying in the rdma-core PR that this field shouldn't even
exist..

Jason

