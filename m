Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9568C46C30C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 19:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhLGSru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 13:47:50 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:10912
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhLGSrt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 13:47:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmCStLSwNBvO8SFi51jAp9r048Y/Vc6kpVx9shMOjVqYfWSDWUtHrPTfnTFvlGgOigBio2A0maBUuab3BO+3RY7kc1IqevjQ8ng7J3P1sTFuDyIiT6hQBwTfPHgHgwk8AG2c4jwe6aYSqQCUGaYmEbTE9GH5AzGrUmRumCw3Xi1R+1+cSriPaYjD1beQNhY1mDd9M/duRSQziuGjcUzfMZ0Y9Ie/LbxOPbQdFO6Sl3k3I8wEzHyUBWtORnt61zO05K3p0KW16m2UMoNV2eOdS0M3jWgmrzEldjjuQGlnCYPLAjVWki7TGn5/8T6/b0og2XcmGiVHFyI04CHUb0j68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErENgi2X92f7Xw6rPaxb3iSCpuygJndbbwCTuXkF0HM=;
 b=PYqgsOB5mG4hmdl4WemgV3fbGzskNh5UIpGR9MgtTIC8qzq8IYBDK3Uz8IoDpyvMIa04m2g5ogn8BkxmY03vvXmIKp0nqMXfcofXbq4IeNEJ9Sgx5pWazO4nunRa3+LYhCw9K0/EybOy6/YdyCbKPhL2OMMhHEfOUEoahWiWiASwPUzs82N8PspI4dz59UCllclQ5r9QReCFbK1uc6e3paXwjccdKasVXE3p9od408dHK2udaah0megox2Cm+sJhNzQ7KyJvzC9lBlgQBkz6QFno3xbGkAC1GzxSlWl98NDm08GBb71vPBxL3shci0jlXMWbEOWlQOBOQjvb6DAOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErENgi2X92f7Xw6rPaxb3iSCpuygJndbbwCTuXkF0HM=;
 b=FdGvE2rotn/Xi1VPbBSr94Zg7WURYUgK7Gr2G7kJ9C9sqXtnXiL/QlsHukEtcnnQd43tUJvJRtG+b3QKJrBT/TTq7cx2oWre6J0mdqrE5YiW+MZV/d9+epu+SDa+JXmZng/UFQrIlrwe6L/1Z/yOCIav5BeQ6pwyA08NrknhJLp8KozbuA6daJtX+mIsbTJkyYzqGhXeOMqlwmM8sCxsNVQ4fpooJ8VqIvO3Y0hxsIX9k6dP0v8GQ/PeaQCZAz0jZ7jP7X4+5sVEoe2hnuprHWI0rNQiCqKpNdv/qrOBGQLHQ79RElcHpowndbqcvwxkrPXt/WdkXBGCPBqQQdg4lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 18:44:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 18:44:12 +0000
Date:   Tue, 7 Dec 2021 14:44:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next 3/3] RDMA/cma: Let cma_resolve_ib_dev()
 continue search even after empty entry
Message-ID: <20211207184410.GC114160@nvidia.com>
References: <cover.1637581778.git.leonro@nvidia.com>
 <3e133449a4c7484cafc0fe6bd7f9dbaec63a0c87.1637581778.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e133449a4c7484cafc0fe6bd7f9dbaec63a0c87.1637581778.git.leonro@nvidia.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 18:44:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mufRi-000Tmt-Ax; Tue, 07 Dec 2021 14:44:10 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93fe4669-98e2-463b-6d1a-08d9b9b18fd7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110BF388337DB227C1C48C7C26E9@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhSPgrxvXJpACe819PRO/tBTaIXFJ1YHgTKGOl+/8y+izMoA9dUXbh7gofnDmOG9+CqUQss0WYnghowjug6Dbu/5IB3Vn09UJ0Xi601LHeZvyFdZmSp/RHxDyAH/01rNGV2AfcqbQVj03+vM5AOjWknqv5t7Bq+NzZQ4bVhIj+L7mm5VP07Ux3MVxViC4mo3IVBrC2nzrcix9oUnFQeJ1X1PF5LIUq4zTRRRH6WVnSquIBF+rNeevio1kt4Bl4DxW9EC1WOrTzQxuDOERUAPOlnWonRd/+YD97vtYv+Sf2Y0pzRSwhi4Qank1AnDct4PpC/vDLGnxQdDu33oMtitVNvuSZJNMtQazpjmfPDdbMkwUFeReTQ6RIwzELkIucHFKq5RsPFDb9z8jfmVtwOlZGS9eGZmUybdKgX8y6QIC6lMmoyW/CSZFie00UnUXm9GBCeP03IB02+Ka8V8eSjKlHYjQACYDVw90GyjfrNW7qsBiqOunX0P9ZH5jYMtoEvgjBDzoXZUxhmnVPMnvpbe5Y4FVTnupf/kFsoXGljn1jRmBa73Twu/4BDcFtAZjKfIiiXueqJNHiamqfnxPn6cSarFvP3k4E0sFGi9GODQ/YfPz5BmISowSrFcEL/BxDQYV2rcGYhz4fxuQrK+VlW1XQZm5mSMjBLzhWtTiK+7aAXLA0/7GDHz8UgRrHMGNy/LNhnou72RXbY4QF1YPp/AWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(86362001)(36756003)(38100700002)(107886003)(4326008)(33656002)(8936002)(2906002)(316002)(1076003)(2616005)(54906003)(8676002)(9746002)(9786002)(6916009)(5660300002)(66946007)(426003)(66476007)(66556008)(186003)(508600001)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cn7yb10+OyRuCuxtoIuMs/836QovfAZ66Yo1LfS8GpDPW42m78uPFTmklxZ?=
 =?us-ascii?Q?E4OeuDdvRM+FCL2+bbel5XNqWnbKegoTNDW1jLcQVkPnZL06jExdg27FnDEa?=
 =?us-ascii?Q?GyEM4zHyiI+kyui1PMEWFsT9kEMfkd7XcAs7HT+WEBILCMa2y9V53pjT6zpC?=
 =?us-ascii?Q?Lz+jw8H2Wlek3EY9LdcdonVCRryqiuYRGjaoc15QpzQjyxGlp5hRvDwO0bOy?=
 =?us-ascii?Q?ovd5EcHZnRR+sAOZGzrT08SDb317/GElUdZFfBwelshpcLH/irG5Y5HVj50t?=
 =?us-ascii?Q?bBnIHe5/FFvM1JpP5yVpAEeQ5c3Lm73EgCEgXIF8QMG0VVAj5kLe6so00wWR?=
 =?us-ascii?Q?88GSe2vMtlhgoaDDD68jFe7gpu/UjkpesbpL1Dhvt2nXpUNUJhOMAYo6dqYp?=
 =?us-ascii?Q?Sf11Cgb/Iw2nId14J5f27dUN9PYB6yKFaOXIULvy6nldt8MO9OVvcsBn6zol?=
 =?us-ascii?Q?rI3jj6tC8GdPkW4m+EcoWB70NeLUzGUjqFpC27Wqz96BCNK6t8nj89Rr6WwH?=
 =?us-ascii?Q?+Y7Eyw0AerV5DcwD5Eix05AAw+ncX1zp11zs83LLP/aUslGp274BVD9RFJgz?=
 =?us-ascii?Q?OegZE1BM1/H+Gxj81vEJ80wKnUh6OSXBTLBjeg89A0KNaksulhcB20tcZX8z?=
 =?us-ascii?Q?7xAPRzL9nZ1+i5jtGvoWy2Pbj0dneEOkGOtSIwly+HxbBaDFa/LCF74vCJ3x?=
 =?us-ascii?Q?9cIygSCQfb7in5+tF5DeuWEjubdeB2ZXZNjnicZ8Auy0/lu4MwzuEDf4jrGw?=
 =?us-ascii?Q?vlRk0hJvoMb7iTVTP69pwLoQS5Cdz0wvn253CN9ba2acGABuRA2nsGGwPA9e?=
 =?us-ascii?Q?fajC5iSaW/OHjkZ4kwYaKlEccdeutcrhcN7+4E88mC/sQP7HEd5eZL13+8NS?=
 =?us-ascii?Q?oiO+pJgdWHbC6erQAC9+9HIBb3Ji5XxZXsIUW6RvnUT471hYJxBltn6tBhLP?=
 =?us-ascii?Q?4bAiGCj5YAzfrRDxBBMK7B7KgdncU+TX1GUIMof4KF73MUxZux09CuExCvF2?=
 =?us-ascii?Q?c5Kt1SSsppyEM2qBxRXQ1UDBBZOdTFkEPMuBI4RAF46R1TNjCnFGjUqwH9EY?=
 =?us-ascii?Q?LxvkPTXpgssgTxLeO9A10mAj844GWNiXwnX6TniFPNkLMQ2gH0I7wgUueLgx?=
 =?us-ascii?Q?MATB99A+DPDWYam0mKibOd1+7TDsyWGRfpUBYBbHB5kMr7xMd+m5r6ITziH8?=
 =?us-ascii?Q?6H2iQVn1NNaSaOcBqHS0sjCHiLFXfd+yR7t2v5agHFQfrJRj9wjBLxN/ovay?=
 =?us-ascii?Q?/a2QfLhKxoGYoBXlrCzXIiG8ki8MhymQfMgfLMBc8/YdbI8mErkya6J+/Ohc?=
 =?us-ascii?Q?/eFKVQJfCe1E2eClwQFKbzlK8AZSoNLZ35sP730Q4WmvCrheXROZPrH99Dsb?=
 =?us-ascii?Q?7ep582uzowCAN2/oDsCPUYj+iXgaF3Nccovv+TwZJeXOtEQ51poXepw0iPd2?=
 =?us-ascii?Q?sR05Mxw6hNQlkGPWeQm2g2rj00PuEVYZEkN/TBjklIo6KDwqolRWqlwDFCJH?=
 =?us-ascii?Q?3vD51IDYVvCyDykQc+e3D+5nLD8p/DPHjk769PEjqJBi3jqd2gAKtjXh4nKg?=
 =?us-ascii?Q?9Orcikgs1nD53XMa48o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fe4669-98e2-463b-6d1a-08d9b9b18fd7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 18:44:12.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcxvD2mVMMinT0MrLZrCOphU6l9etHfk/gkdMYOoeg6tlhvydfswt1Gxx79A8m9z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 01:53:58PM +0200, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Currently, when cma_resolve_ib_dev() searches for a matching GID it will
> stop searching after encountering the first empty GID table entry. This
> behavior is wrong since neither IB nor RoCE spec enforce tightly packed
> GID tables.
> 
> For example, when the matching valid GID entry exists at index N, and if
> a GID entry is empty at index N-1, cma_resolve_ib_dev() will fail to
> find the matching valid entry.
> 
> Fix it by making cma_resolve_ib_dev() continue searching even after
> encountering missing entries.
> 
> Fixes: f17df3b0dede ("RDMA/cma: Add support for AF_IB to rdma_resolve_addr()")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cma.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 835ac54d4a24..b669002c9255 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -766,6 +766,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
>  	unsigned int p;
>  	u16 pkey, index;
>  	enum ib_port_state port_state;
> +	int ret;
>  	int i;
>  
>  	cma_dev = NULL;
> @@ -784,9 +785,16 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
>  
>  			if (ib_get_cached_port_state(cur_dev->device, p, &port_state))
>  				continue;
> -			for (i = 0; !rdma_query_gid(cur_dev->device,
> -						    p, i, &gid);
> -			     i++) {
> +
> +			for (i = 0; i < cur_dev->device->port_data[p].immutable.gid_tbl_len;
> +			     ++i) {
> +				ret = rdma_query_gid(cur_dev->device, p, i,
> +						     &gid);
> +				if (ret == -ENOENT)
> +					continue;
> +				if (ret)
> +					break;

Same here, just always continue

Jason
