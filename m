Return-Path: <linux-rdma+bounces-4419-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46EB95735A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287DC1F2382A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0203D189903;
	Mon, 19 Aug 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pEeOpN8T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4131891D1;
	Mon, 19 Aug 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092413; cv=fail; b=VzNq/A4VFBrS/wVKwndfdCB6ihIKmEMJ6Sq/rX28heQI4x8cEq2cHZ8+0Zc5ElIe7D9al7f3sUATJ2lcO40z0VTEmCIJb/3uy+YHxXc7nR/GaPWJxPKKaOaV++BOBz3LoS3SNyyrRVxQq6hHgUEKqs9Q3xljUSfX71WevsLBqnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092413; c=relaxed/simple;
	bh=ch5XBrgN4uEMdUhUUnhr0js46Iv+P7KEn6XzH1uTo/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jSLLVy454EiGgpMcas7H0TCwD7R/xk+rmLnXmxJXRlRhq5r1B6al66e5+K5kF1zzT9DbgwFhA7B8ZfzpmYFVCXyXvjkLxK4MCr2gCimUn+E+DB5bcw5fxPmwVzUC8hYrnfqxDhKERopS0OiavWZXaMb1OAD3BAmF4YSr2BFDsA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pEeOpN8T; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrJvJZC5c1xhayRnqyKTfAcINjm+6qlJ+6O8VIJIJ188RhUVUVhUdD6QVgG2UmG1ltAAuqxfEHt4nznIZKmfV98pc97NZgt5fBngynsMReFdvwMmzewcBiP4fl3oYiOpf7dI1bW3bg1Vsj33QaN5YHpkbrSIGuOw+e24hgylAUxdpe7oVzDtSbhr8lKKL0jo3zWwhckIfYCJB4nnOUpd+CgTVfnpcJz/KnDybJOMGrdgAukKdfkmvqfinpBU9ShdAsRseMUonKi9Y7sU1jdBuq7tzL2FNmNgfQ9qeOCh7T8TfqPdeM7BBd2ZQDTRpxT9YlEZgYg3opaSL60B6qOwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=666N7EAaGGQovKi+UTsZ48NdH9zpsf4eCeG07i9x9cM=;
 b=gHHSMakUGHTwXMBM7PRQbjeDJH53LTnUZvzS10JVtKMZQQt0p42eWSxAxvG3DHQLnkOGs6lf6JUL+ZkQaVxBvPxOeZxWqJYnWbNJD31XxPTfh3uh8RNPag/0rgYJw2ysfxEjb9N+F63YgytWw9OIUEvdsSsqYg7P32HYu/c/ssIQrneoSX4tB41oq+ono7EscBjFEbVe5QqeNDqHMzikOlJ6quQ13wJT0EDGcf7sRnIvZzCW595aiQDQteEta4oRSYGHhkIGA+uyjgu4a3I3pToAR70vXUiCk3ZMsEll5Ec51ps0MdBS9X1+T+0ovqsPYNAVOyhBT5VvWGnwqck9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=666N7EAaGGQovKi+UTsZ48NdH9zpsf4eCeG07i9x9cM=;
 b=pEeOpN8TzLgfZtPklFdLFPkRMAf3bOTP3gbfy+JLCwBhHeqqQjLGo/yZFOzMepwezGYGcpj4DipLUulo36GtlPNQv/pxUo/dVnwKkngkeOjeLMDztWX2QULQtfm3jsjCsiEs3UeRaru8985NrymFv2rqWDfeTrBgPrS7KS7oYs76ZuNBrQ23Yu3ZsARWvg2hHTfCRxBjKmx+uUE6lprymgbb7hZBYWReVfTzM3EBQ0/EGMo9r5WN8cks5XxerwzsaejosBoQVSDI2BeZR4FLOuY36AQziHYbVEWAg00AhoKbPD69lv03f4c/VOwE4ypVdi8FNpz6TmtaUzsy8bW9XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:33:28 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:33:28 +0000
Date: Mon, 19 Aug 2024 15:33:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/mlx5: Remove two unused declarations
Message-ID: <20240819183327.GA3482615@nvidia.com>
References: <20240816101358.881247-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816101358.881247-1-yuehaibing@huawei.com>
X-ClientProxiedBy: MN2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:208:a8::26) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 7575c934-0ecc-4de5-2281-08dcc07d6afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dhyez/DtsZXmMQFWKnpO0It1si1KFpfNMmXg+iPBxfZ0xOyujJzE7lD0tkA4?=
 =?us-ascii?Q?JZxoElTt6kVRWkKTDwGjTuYJC1FlBMSdUdUGXVrt8lOHUIlo+kgXj73gqyVF?=
 =?us-ascii?Q?Z5pPGzGpIGj2DcrG2OA9+1e4AHl5P89pXjYYQJuCX/gGJKQBUbMurvxex6/+?=
 =?us-ascii?Q?LG8kh6DPA89CeokTvs+lwOdz6iTIMouYSMFGooR7WySVpcqQNJQxxITlbDTN?=
 =?us-ascii?Q?Y8pAT4Qkr3L3i7ankO48JAroXmIF+KWSs8ACgb5SuCbDzHRqg5nonyC3Qxqj?=
 =?us-ascii?Q?PG5xjQ8vHVWJ1FoPYM9e7Lpzh6QMKR6hTdu7TbueNDGQauVFAt312n4Og1ek?=
 =?us-ascii?Q?AVX+9rJNe9yMZjeTpL5X1CKBIpRWEkryENhIVnCyeJeQbe6DWbhMWzOMYf1o?=
 =?us-ascii?Q?zm16yTcHF1UjTYkgi4X8s3sG5I4qtKV/vLFSQx6zZYoqiWIlF+mfA+mj4/A2?=
 =?us-ascii?Q?eGnUgA3EiRAmd/rcXWC0R1kcZbRiQuwX79CFaith/0wEOG9qQD8ZLlowYzgc?=
 =?us-ascii?Q?35+su1mKW8A1kV4nMLUQ/2cZLoC1WqiF37R3XDPfTqO3QElC+qV2nulU9kMF?=
 =?us-ascii?Q?j5zhOCcHrspc8C83fy0xQSPDf3n/I2/RHZv2B3DEbbiUonVBbnp/xsmQKV3X?=
 =?us-ascii?Q?+l3cYdzUkGiu6+e9IkuoVwCYJFB9RJuXEJexKmcCBRv3YW2ope29KRAo2dsY?=
 =?us-ascii?Q?jgmFwYp7GYDnOGueu5BFY2a3MPGdYTnVmfRF223mpAXCEx1qaUjxdeCtAkbj?=
 =?us-ascii?Q?NWV/oGK2jLXlppZDgYfriYdLzqw6fGqZg4j8vr6S4aqsiHEEvP+fJyb0Prb5?=
 =?us-ascii?Q?7O6c2UmmwIDK3G7cssrfOjVcE7Po91zmMyUrSb1oNlvMlWjmhY7Z5bGEvgyW?=
 =?us-ascii?Q?QamNEbzh5q79JWwKPT8loMGCz+/EpNwCTlq4frJl6E0qaYhXAHFbjFzD8K4F?=
 =?us-ascii?Q?lSGwJ2sDpvXMsFlS1c5q88geP4ALNzxxut8BLfzbYk4A2gb7x8pD2KX2xKT5?=
 =?us-ascii?Q?q3zRInqZGPWbugMwnKw2tBBxl1dLYlzaaHMHzDtW3VwMpDt6XKS6UPbr0tOz?=
 =?us-ascii?Q?0zZqLH06bYEE5DrPFMsrS298iaKlDgIdrhK6MNEGiFu/lRHJI/l8WchOFYWM?=
 =?us-ascii?Q?eTNJ1T7e8cBmZzU6MhCPlI+GwZe4VxMRAFhJt/vHQ+gcbTEGX3LoPTAL8VgC?=
 =?us-ascii?Q?gOdocKPH3t1GDdd2Mr4zsEBrzUsdqIFzU0bMRiFTw4jrfceTNkOK1bW+qgr+?=
 =?us-ascii?Q?BhCmglrd2kI7MrrBJu+HsfcX7dkmxIKOSFQeBQAQO3ShYY3H3ElcZ6y/FT8O?=
 =?us-ascii?Q?J/PiVWxDyPvPnJNhmq7JsI9Zq7krYbUZMDOZ8ZlH42l64g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YbI2QCMk4FnH84ICUtaYkeY5cO8sdToN7jyJhZuKpNXddIyJVudFnZxY+tTZ?=
 =?us-ascii?Q?+lullSRgG5RQoDnsM8E76palFPkHihFyogyzo5cavHzGu4FChRXy8tv5EhyC?=
 =?us-ascii?Q?hnx4zZa5qy9HCmpwxDKOPVvoEYYZUt+NHshyYOEY3Kj6KdzuV4y0ZDGEC9C8?=
 =?us-ascii?Q?2620Dc/r+Eb5kEwusunQo0zCrgGu9dyvqce7000c2iSbBHDDoCU8/T5OkO2M?=
 =?us-ascii?Q?aTRDzaPycgkniB1ZxMQtnaVNafX03eyo3+J4NovvyR8G4Kmdz20ISFoRkyA9?=
 =?us-ascii?Q?OjLESW0HbJn4z77atRFKXUO/WhDPjuOQuj0Jcz5XatkXn1oObX2gUUo/jiq7?=
 =?us-ascii?Q?Bv7O+22NH7jk96QTy3Mb+JbVEz2D+nUc6Z0+0bnhhzzqTpqcWtAEqDwH0N76?=
 =?us-ascii?Q?ysTOfMAgaRLfcNp9OJA4ftL/S0wQIRnzgCXfsXWZLRna9Yw7g8yhgV9OKXdm?=
 =?us-ascii?Q?VvVUxJu0bSnCzKfzhPetS6Z4IOCDw6O50y3OCTjRRGtEXXoPaOL0wRI6ymIN?=
 =?us-ascii?Q?vd3iNLzSDJQg/DY93XNTb7cJxwK2KQ5MrOsVkVR8WBQdjfzMObPeHkrdFMPb?=
 =?us-ascii?Q?GHBD7qyxUoV4qLMzkyKLCWkq+oXQ4ULEfJrExpxUwFo1slq4c6Taasm3sYl1?=
 =?us-ascii?Q?RAi7bmnOTmqsKRqljH2fc4oDJUhGwT3BYcc/rtrK/cLCTJql9UE2gudoSXMT?=
 =?us-ascii?Q?5y3xHPifnYalhEZscXq1yPTYnQyr3uatvQuU9IunmMjlzAH5JwkKz+wHkgxp?=
 =?us-ascii?Q?lAniYgAPRD9woUlIwasUgYGPlGTa55ePyd5UlhxFubksLIb3vMD21KeSa+mV?=
 =?us-ascii?Q?pcgA2dY+ByH1Sb/NL+KmaltEFblgU/w/qy+kAQR1qhY/tiPNP97gZVllIIWB?=
 =?us-ascii?Q?DPaQq1aEGwIaKwE/gdkjl7H8LaHe4ZNVGUhWM+1p3llPVVbF2WRp5aXE1TGo?=
 =?us-ascii?Q?P36yenvO4iFMFHHc3DEbeswHxUoSHBPzQTQkLb1c4N/u3J7580vibUpC02fe?=
 =?us-ascii?Q?0gkcFHx7jbhNZ5UJ1mZ8d23YAyjyjnPDAxMY/8Zxp3bIKAF7j8fbUf8vrVPO?=
 =?us-ascii?Q?7bumTERXAFk58uLCExazflrpN+xK5nZ1WujH7AOwQbOL8v2StE3lYGN2HsZM?=
 =?us-ascii?Q?c1nXJudjjOFi6d5njWuP71W8SNUEJNZ+mPWzmpjMMUwDC5iV5SGIIbmoJPgu?=
 =?us-ascii?Q?k7EkQy2PQ4tv4WfwzSJLECRX6rq2L3cuhBRYkwvtkjMna2mOBmnUqUtbbxpa?=
 =?us-ascii?Q?6q9Apjg9a1GOTWGrnNj7pKvQH+m/CIUObBpId17lG2LZXMf49DnB7AWILFFj?=
 =?us-ascii?Q?MJBFTbVqKgDvKmik0p54v/7n71VMaTq0mgSFcHiBmGUNw5w7ojTf8CwdwA8k?=
 =?us-ascii?Q?npx129Tl9ihPB21XaXfex6y9kIGnEloCUujo4Ji8mu/PTx8MMU32wMuUlPCd?=
 =?us-ascii?Q?/UlHRhsuzbFRXUGqBtqvrXPMxvWIc+FkpQPCQ6tbuqiUrL30D7cyOaTN72Ob?=
 =?us-ascii?Q?lflhBZVWqAWLOwIJgVCprpXgGVOiPAmI/CUsVTym/0s016vrL1C2KRGJR1zw?=
 =?us-ascii?Q?EELrNrf4nL/j3RDQfRFiCpKnPJ8M63SYKKA7FjWu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7575c934-0ecc-4de5-2281-08dcc07d6afd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:33:27.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wjr16xPUyOF2RMadtf6/KKHqJFpNIFiouhGimd2pNwBCwAnF5Nzb17CDESBg66mp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427

On Fri, Aug 16, 2024 at 06:13:58PM +0800, Yue Haibing wrote:
> Commit e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to
> mlx5_ib_dereg_mr()") removed mlx5_ib_free_implicit_mr() but leave
> the declaration. And commit d98995b4bf98 ("net/mlx5: Reimplement
> write combining test") leave mlx5_ib_test_wc().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason

