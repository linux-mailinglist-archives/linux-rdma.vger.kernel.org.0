Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEBC3B3502
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 19:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhFXRvE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 13:51:04 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:33377
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231407AbhFXRvD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 13:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvPq/zR1Dcc9gkA5eCgWO8XqPV+Ib+owxahe2/YB4Q4io+a98PzkVUiYv3RJ5UfKte/zVo5dqnsfJwhHkRY5d+EuB5nK9KM6yZx5FMLRxssfZ64IT+27cVXNHmsR/QfzMYxfhVyT8R/KO6ykNxIKxXCFGk3pgy52mMje04ZkJJKSOX2hvRnVrHgRsHj8prC3/MlCujsPRU4pk/psvpo8EoKo07V5yuoURh1mvz6370pyoXPMsz7xoGJ6+iD9lOX+KDYinSpqn+H1NxTfBglceDqvO7prrXqi8/vSRCcjWt22cKtbgmO4srvW17LAH9VSFKNQMQ2EbhAbYd05Drcijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/wv3F70OAgpozfWAhurySqq09+3gGTbrn2okzMjPAk=;
 b=EyVsabKdyY2VAva8NQTiLnHc9jvp7wYO5bK87KQqpFy+pISMFuvv0+Lql+g3im2qBnmRFPI86+rOgtIp3dyKAK2jrJqyhPsZb2NPIKSMho+MquaTwEmj6O3k6jpZHKqZWOF5Ia4JhMmHu8iro8LFT5fM0tMPjodjZhDreuXMdtCcTsdJrZz/fqyBHdMPC4qB82cC9fLjruw58SwtZYJ5i0cu75ssZOclTRAvIqLA7YlocAZOSdTXrUS8M7xdu9XNCBpXOf9EeGOpaUQPI9inM0BLegKXSufscb+26y1KhMiWXmjbXyD9jhqDkg43lcDfA485M6kIViBRG5auO4uTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/wv3F70OAgpozfWAhurySqq09+3gGTbrn2okzMjPAk=;
 b=qq0lFpfA811faDNSVGVkhG/3Pak+YNj+BOEJQ0V5cgOypCMEKCobt4jov6/lQ1+ZQvZDgmt724vPTpwIuMCqLNvxaj5OQH70gwVN6Yuwvi0eln9OfyhbFa9HS8nAoElOCu4EnAzqfacwx/R3aB3kytFPIZwqYCbSWKYUPXVc+O6DGDjXgvfK/Bq4uIfUsLXuUEg5EMjLnvvRujBP/hMqUTYuSxed48A9RW4ypDZ1hZbm5RHCAMDzyEJBKTTBw3aSQcADCWPyz9btOsLij3CqkMxfBWxFsDiOETOdS9VcZayd/zud9O13vSRugLW4HKUR1E5ltk+sKpF+g4If06g2IQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 17:48:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 17:48:43 +0000
Date:   Thu, 24 Jun 2021 14:48:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Simplify addition of restrack
 object
Message-ID: <20210624174841.GA2906108@nvidia.com>
References: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0345.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0345.namprd13.prod.outlook.com (2603:10b6:208:2c6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Thu, 24 Jun 2021 17:48:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwTSz-00CC6i-Vd; Thu, 24 Jun 2021 14:48:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9de581-c2a7-4b36-ea54-08d937384ebf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5063F1089333AEB7899BFD67C2079@BL1PR12MB5063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8aHKXRS5yZhfLNeKG/9y3XFOy7PBGWbe2reqgMWrM7zFp8r4FtrsadJLyVRXzDOiic/QrcGkWhEu4fjLERclGpzgW0tBzguRhS8y8DINkkTf0vgIh9odsXS233YtlIWokLF/X2YNQ1x7aoFRoGseK4owGZMOoV/ySXgvWOA0mPkyKmkobOdSSmfOtYpVP+O4BTp94M5Qg8K5lVpDV7iB1T5pffCfPLKMoNU+Rq9YqwJW5T5H5k/1b5LV52JVipTCJf7jZ7srh+mzHQ7dX8qPrzYXwbgh6KtYm/OE0yF3tgNW5aRnsN2VRhI/eWV7fqzsgJbjMbm/s0Du/BXwXqdo1H572ViDDVsp0UYBr5TQkyQVw0jLnxOfqSEsvhzRlyUmK78u1zu+An/vflPaGlj67YSaKksEB6w+ug85xSdY0k4pmrP6/w/y4dgbQqF9xmiWW+B8FYuDiuC+uiGDJGqPL/haGCaY+WrFx8XowCHAeyoOPqVyPEUTP5UaGGQ3sxzvhkLf9bgDMY5FC2y+fpsnDGZioOlhGm/LLRZ38whez/BDulJ0aEZaCFFcpikUYpHl+NxIQThtcdfBME5jTfkwzKF1eXldM2RN1WQKATOHXw89NlWlPLFJupaOvF0r5KBMu+wyKJ6ADG79RY9WJpP0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(5660300002)(8936002)(66946007)(8676002)(4326008)(36756003)(9786002)(38100700002)(66556008)(66476007)(9746002)(86362001)(107886003)(26005)(186003)(478600001)(426003)(316002)(6916009)(2906002)(1076003)(2616005)(54906003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqsuEqsZ7yVdLrgKvyHBUKxrx9MA1LQI9tN1xFYvzy1dZWrKF5Hp+6yoE5J3?=
 =?us-ascii?Q?+74k22tvHbqOUIv/rJ3JodSYYvizCO2OX/YSR++NMVLw2jli1Rpzo6e9zAxA?=
 =?us-ascii?Q?C5mxFZu2uLPVoXke3/UtEID347WrWdYhmqK9rNmvEPasuXC85PUHSAULCYyv?=
 =?us-ascii?Q?jhG3vtPlzWo63fkdvNuqToRBb/MPqI1I65pS3hgjMFWMtP2Xvtboa8Qx7zpR?=
 =?us-ascii?Q?6m4vbbXbynp6K9t7eX+oBPTsyWRDc59d8bFrM639vtobnkg4Cr2x1JqAOYJd?=
 =?us-ascii?Q?jUuKsTPKnRINJqr3IHvL202GJDNULfH7mEJOA2LD6kKkdo4FBDLMhmqzISXn?=
 =?us-ascii?Q?OL8P4Lil56jr0OS45106Mn00mpu1JnC6mV6P3iyYUG83dncUOSac9eschiVg?=
 =?us-ascii?Q?+GKfjmAAaJ0NBB8L72jIb/NnVjutU7CV5KW+gt7z3LX6V3z4fTmmPSp79dy0?=
 =?us-ascii?Q?1/4pSiQC0IirvA1mdZh27OtcjZewsx2+MuysgJsIkCus/Rt6vN+jwneuW+BX?=
 =?us-ascii?Q?SbkhZRuhm6IRpQKeOWq1kARM9PgE0EhEws0Ewfn0EWhdLHzRhxP8nfkXjChm?=
 =?us-ascii?Q?LlNqwooBC58dVZnT6NcLn1v7xGDBUiay+KsV252EszzM+9cOXQqiNXIdgCAx?=
 =?us-ascii?Q?R4svl6wFPsXxSZ4Xqu2D8Y2E8nbgWSrO1gYailAfCzYbLG98G2K/HT4TQwB1?=
 =?us-ascii?Q?SMH2yAwga8a1XFtarOmfzDmOmZ20BRUDHD/12wARqX3MMEpAINFOEgWHxM+q?=
 =?us-ascii?Q?gnaN5mZ6anwLlHG7FeeQtY+7Sg1yvqhwBu/7VdiHDLCYOBh19mpKq9gR5+IS?=
 =?us-ascii?Q?+bFNNeZ3RggCrzt2baKa1h9gl08bMDQ41adx4prnTw64jwxOBN3Mm4sZeuln?=
 =?us-ascii?Q?Kront1UjW+ExjARKpKMGYO0EpLgW4NrarkSpOcf82zCYGa5few6TS2hRx8TP?=
 =?us-ascii?Q?9dHj6NpJ+W6rIw7Lro7rEKY9ZEQsP7lwcmugiuITywm0qnCO6BsTdlrWUiOv?=
 =?us-ascii?Q?Sim3qN5US5bGdO3IM5EmVnpvkpbinOZK7hmtU8xPjowWd61oVIwY0vWtPFTn?=
 =?us-ascii?Q?kNdjPPUlHo1uJuVTjYk8U4No5B2L/JUK9UKHXbSHMb2ot7l33WfefaGqb01S?=
 =?us-ascii?Q?Jk23LaOXVUUc+BXr8pq5FiNkyGjmwrMes5Iiz9f2UAaFePilLwwXq3ikzzK4?=
 =?us-ascii?Q?5E8RKksF0o4/+rtJzuk9y4l0+ByaxchxTjIqNSpSf/haGkw6/kYm+TJJ2CXd?=
 =?us-ascii?Q?Y1F4ou7SX0//RBeRuEydsa1d1jwUzJI174lgHm/8ZchFWhx6yWA2xTcCA9oU?=
 =?us-ascii?Q?RNmfAbobYZO+EV6i/ey9Wcuf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9de581-c2a7-4b36-ea54-08d937384ebf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 17:48:43.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvVpNCLGTHOPgwJMHoMr+mAnMpKu1zSF//plGSblBla5d268bqK5HeMJLVI3iNet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 08:23:48AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Change location of rdma_restrack_add() callers to be near attachment
> to device logic. Such improvement fixes the bug where task_struct was
> acquired but not released, causing to resource leak.
> 
>   ucma_create_id() {
>     ucma_alloc_ctx();
>     rdma_create_user_id() {
>       rdma_restrack_new();
>       rdma_restrack_set_name() {
>         rdma_restrack_attach_task.part.0(); <--- task_struct was gotten
>       }
>     }
>     ucma_destroy_private_ctx() {
>       ucma_put_ctx();
>       rdma_destroy_id() {
>         _destroy_id()                       <--- id_priv was freed
>       }
>     }
>   }

I still don't understand this patch

> @@ -1852,6 +1849,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
>  {
>  	cma_cancel_operation(id_priv, state);
>  
> +	rdma_restrack_del(&id_priv->res);
>  	if (id_priv->cma_dev) {
>  		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
>  			if (id_priv->cm_id.ib)
> @@ -1861,7 +1859,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
>  				iw_destroy_cm_id(id_priv->cm_id.iw);
>  		}
>  		cma_leave_mc_groups(id_priv);
> -		rdma_restrack_del(&id_priv->res);
>  		cma_release_dev(id_priv);

This seems to be the only hunk that is actually necessary, ensuring a
non-added ID is always cleaned up is the necessary step to fixing the
trace above.

What is the rest of this doing?? It looks wrong:

int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
{
[..]
	ret = cma_get_port(id_priv);
	if (ret)
		goto err2;
err2:
[..]
	if (!cma_any_addr(addr))
		rdma_restrack_del(&id_priv->res);

Which means if rdma_bind_addr() fails then restrack will discard the
task, even though the cm_id is still valid! The ucma is free to try
bind again and keep using the ID.

Jason
