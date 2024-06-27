Return-Path: <linux-rdma+bounces-3557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52CE91AFF3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12890B21022
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 19:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056019DF7A;
	Thu, 27 Jun 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cvni4IYI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40E19ADA4;
	Thu, 27 Jun 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518159; cv=fail; b=JN9i7ATUclpKQ1XQnZFPuIAmzJITo/hDh7jqhDJFtoVTiZWhfU62l7LwuCjIyvHfPbQaAUrYAiO18+MbsL+WnAJE0zEkc+S0RCMZ9BWhI0EaXZ/2AxIhOVpqj+k8fdSTjgiUX2hqNjP+b68ASGihSTkw7xT00EQVA4zkClYljxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518159; c=relaxed/simple;
	bh=mWeYV9I4fyAvb/UEuZSB/yUt6UqWs/Z55ezgDBTwyh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s7YNifj+vwlTfp/zbU9XyII5UR5hf2rEacFRqYjCBRkoGIdIfeahSLhLZjEJiWeEQgmZecmGDlp4NoHnjksCTUFAmOmhAtcfJdejSupZXOBulTLkv4B+6czf0E0X612Rub3qHdWmGpBfFi+NQBBCv/abALfdWo36szWdsm4iTIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cvni4IYI; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+R5y1n2KXNjThBhhZbZ8rj6lJDaRfoCJ1nAt4oidWBQkK83ylQEpCickQKt9ELh9nSL49cESsgTDDvwJqwwPQ1dc6QykHUd2D9nMU5abVprDROfgNguZYQT9uX+gyt8UVZog3zRHEDY0hM/WH/FZni72v8j5p3G8PENE3NecwDiFsHPJYZzO04ZJR4IFhn66VljW/AvQu+xLhr2dk8YowTmVuChDZbur01LRVcUmzgtD17f/cvRm5kWSxjTjqdkfV6azoP1QtkNiPZTQLC5oIdHujGvR816nklnVEwJKwnZo+ewbt0E7aeC3BiiBrG/+9ZMAIxJxvd546lDqVoxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrBWmVO1ymN1OVSHvrgkVie06QAbz/aUDL7dDAo21MI=;
 b=JFLCPXt3d38l8wetRjcKTIYdXs7X6RYhE4xwPIk0ePJvxQRDSoQUtgoiNJzas/3tyeYtbXIpu6DtLOh+c48jb7H91SMJr5i76AZMs69vZx2wcAKRdOSy9eWx4ONVWdf6MQI1LsNHj+2ZkWgvIeirb0ykiNNLgFZpq6hLRSsgJOxQzR8ClxG8hepo+zS69ybFXSNmEKfzZqlg9sgwWDDkaBrly5548uVQ2rSV1eOX8CSF5fXP4XSSv5KZfpdAmO0fFI6XQJMySZAQ3GEzU89dg3wIBTUYiGI6gXpeMNbrTEtVH43+1NhkSucAL+vTOBZvE+sqzlh9nLN+BOHZJgOWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrBWmVO1ymN1OVSHvrgkVie06QAbz/aUDL7dDAo21MI=;
 b=cvni4IYIHW4JIxO4ZHntU/jfZdTvKWrZEVjTwVQESA6JeMjiJrdYAjKwJvrMNlhbmwNp0N0O5lrU6JApOFnP5NAQ7M0DAhbG9S5eZ//4BjRcnuiCF/NRkV6VEvfs3MSy83WjKDHVxWL9Y/0afE3W4CxBcON1Uaz0yiTI6ZgoY9vLAsXeEz04Qz7JC/Sxw4EWpKOIRKolmk0MlbE9SW/MfVQV/RR8Ncxb+NcGB5XVkwOCetnCkAMEz7nffbgNW0P2suxJREff1DH8gJ4MuGYRdfBSbq+z6tWVUg1I8pJHXQVcU/EoWb2xowf72uz3p1cjU63SIwX3aLgNTL906zjzIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 19:55:55 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 19:55:55 +0000
Date: Thu, 27 Jun 2024 16:55:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v2 0/2] Extend mlx5 CQ creation with large UAR
 page index
Message-ID: <20240627195553.GB51822@nvidia.com>
References: <cover.1719512393.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719512393.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:208:23b::9) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccca0ad-a541-42f9-1d3f-08dc96e327a6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sZoBR+QD8kkRw5k+2mbaSFXq9N8VCvsskL0S6HdC0358VcOJ0aG9tl+jXf8?=
 =?us-ascii?Q?Cyna7khnioXGB9yGe9sk2k9ZmQh2LOz7fHlmgUZPKZ+wqeXGVptxPLgJac9A?=
 =?us-ascii?Q?jRpPkbu6EOpbzTibLDWwQ/clSSPWJ7DRX/8VWFX6zpJDJhzZrwI+RiNkJ2I3?=
 =?us-ascii?Q?Frxbfml7TOIT51XRExdgACNzCXLxRJin2VzVFPVrcdyK6L5hC+cP7HSKvwNj?=
 =?us-ascii?Q?YoUncGQ3d3JsPtNg3guCM1hAlpr55ulOGeFPP3xN63BpsGnLZ3ofKkAo9FU0?=
 =?us-ascii?Q?Y5y/n2tRYBWmtACIx23rrIyaAcJ89jCp48S3w6kpq6MJLBv6fZBbaCYrpidL?=
 =?us-ascii?Q?0UP0lfiS6O/2Fa74yYk/KAyaM7OTvWd5rhqlnwNkjblmLIado2JWOriatfxT?=
 =?us-ascii?Q?Y2/vkH8Tcn1+SjjsCLe/QDNM2p5M8I0KZ7dQm11AiPeAcECPnT3pc++Hfxxc?=
 =?us-ascii?Q?AKWhtPk6RbYsEI939g1dxAa0zE/Aksm6//Oa7h3TPbHxrVKdEqldvRq5Jpq4?=
 =?us-ascii?Q?wamrN1/s27gNiiH6vRl2XIB92Otx8jYnJU2J/chRJhg4bFhw8vqwjgPoKVsM?=
 =?us-ascii?Q?fCFzLemQz4we5k2XIJtXqz8Aqo0ggQu4TwEFNwTDWRz0yuRa1ViQcYiyWDXO?=
 =?us-ascii?Q?S1Eoo+e55Ba/8kxDoG9mZCysMlNEEx/hsKGkhxs4pztz+DcLNRzDqRk1019Q?=
 =?us-ascii?Q?nMlC3VSYV4TIWElxs2vlrZK+5u4csWdyT7MaKq0ev07jySqsMgis9v55umX2?=
 =?us-ascii?Q?W5084oW76ErKqUZl4gqKjEbdVH2EDqlk/Bogc9xd0mjWzvHBBniPGnopMyIR?=
 =?us-ascii?Q?pVpdVXRRXzoWCaSR4/GJjaOhLFWN3NNPWDyYvyfRNtAGh2za9/LfHKVPiZgf?=
 =?us-ascii?Q?endVkJhPykLMB53XVaNGLaracEKSwVQZ8wtY2n1FpC6JYT5CYBYXDlnEIiua?=
 =?us-ascii?Q?rasp1hZw2Ziy8C4XijJ3WETnqgo3g+/NTERQ/bPvcUWl8yNDKRbeGEERQdR8?=
 =?us-ascii?Q?LSFc5vOQM9KU6rL58jTCqHPwYM3EWcDFAJnRuiNALs25bajj7VVRfR6QldG0?=
 =?us-ascii?Q?rXQTqucNPV87ZXvDJJ3jvQiHEBmY48SLosscwv//V8CnyRl1GHeuBDt3cl24?=
 =?us-ascii?Q?DcYNZh5fiJzwkoFRkYOvt7FZX13M3t2OBpH6mgm9R/2hA7XvJx9/vpIx31fu?=
 =?us-ascii?Q?qVWZ0Ly9XwM7d5Vx+lIr0DoaC52Pe4FYXk9HZdNDpHNRd4LOOi6o1KEeFkNN?=
 =?us-ascii?Q?fbKLhCdU/Rciu9fUvdmdeCHeA9moUBwdsGWo+eE5JKfHtG5wt7lOuS+H8HiH?=
 =?us-ascii?Q?GhEhTyhab/xNdwqjd9ty+2fOwlZ3rXRVLSbRdyX8adL9KA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wtfV3K6+bHxME2U/spLxl+gACU7CUF2p9p3+g6IEUqKU1XyLJEswUZJD/1U+?=
 =?us-ascii?Q?/5l6SQChNr5QSYQlKmrwQCwbzfGweVufJg5K8nA7XjAN3p1xRT7z8v4IirCl?=
 =?us-ascii?Q?wNOxuDVvC+Yau/5wvwdehlfMELFl3Um6NJc2d+/B28ytE06tkKSpDAWDqV22?=
 =?us-ascii?Q?myj7jR82P8rkZB3139lPCcYQobqU4GEj8k8jXaT1LlAxGOU533xdqdUVWqHY?=
 =?us-ascii?Q?BjbIv3vzPpwo7H/zDRlYtYwe23pax+kpZzfuygCzZspfoGDGg1//f8KADmrY?=
 =?us-ascii?Q?82P4ChfpZASzblPvJFWdKdbGtU3I/M/EFsfHgDm4r5p+hNapFIMQq6fGvUY/?=
 =?us-ascii?Q?elguNadz5Ahvn8xRcioxl8panC9wxM8WQc44TsNuY3+gTEEpzAN3U+CUtPHG?=
 =?us-ascii?Q?ffXy9ZW0hXdIK0bG+70Nwsi9PdAsfuZvwoKWdjtMHJ88QCmd9bLaH0NhyDJm?=
 =?us-ascii?Q?eHusqsCAhzNNjhXoSGpApElff0FNerOF+uFbBx5Ueg/83183+4gdB8CDem/u?=
 =?us-ascii?Q?5gNhWbn8cKcoyBCOy32qnLWrQdnp7Cl0spsCZ5lB30Pqcw7iqn3Aqbej3IlO?=
 =?us-ascii?Q?OHtHP5WhRLdocH2mzQGqqv/7+e3J7Xw+MrpBPLHSaqhqIkm/zDqg8Ny47Blz?=
 =?us-ascii?Q?AN8L4qziMg1xRmtB9cVxj+gPP+OUUoN5rl2MmcI4v5FipHics+8LpmiVKmTm?=
 =?us-ascii?Q?j2pvS4B+FPx0MaXo7g+O5iE9QAkdYDI7dp6P3myKO9HERtZhLErlj8SuJQSw?=
 =?us-ascii?Q?hhDkLQDvH9+YLTxlBU6VE1nnDSI2fJrGiIoV7hIdvSEckn0K5Y63QTM4HdOB?=
 =?us-ascii?Q?qzGvV3f5Pydc52Vbe/T24ys3vtSA1p5PTNWWZRQDU2NLYgxqxAjuTjVQ1/Ip?=
 =?us-ascii?Q?Ug0rFPt++rSSWJJHakr7qOGW+0WPfwsVc4fnJmH993LoHY8PwItgzCA1NAO0?=
 =?us-ascii?Q?FMVwU2mxwCZ99f/kWNnywn90yZRdT+NNhteeGoxsYoN0ISAAj57UTLyhDidd?=
 =?us-ascii?Q?VWyE543yTj8KzRHWBlspaw6of0IMl4aBRuU+HEf8AOltDThD/8zC+9IHuHoK?=
 =?us-ascii?Q?OP47wnzgSJ2hSxXAyH6FMYB6JqVHHatIm0WO/d4gX0EcjIqizm4rACpxZ14a?=
 =?us-ascii?Q?bLKG8VaaH+pMCKJUtDbVPV6oLVd8l59L0Tm9PcSqUFojkP3QCv9WNNqWO2Js?=
 =?us-ascii?Q?9XTt1Yfj6gShgGqNepq3RrPa5zcEZImSpU9rNvaDDAK0SWsdbEb4ruoQkNs3?=
 =?us-ascii?Q?cHX2UAF7yM3yxUsO5sKZ9J9usCiFw2o2+3YqIeuq1jrgd+BKrhoEI3FYGaqf?=
 =?us-ascii?Q?FEhDZSijrGxmMaCgukagSgG6JiiNStHSCVbemOsWameZcPShWLgpru2w93A+?=
 =?us-ascii?Q?41ZK9zpf4SImTvWhYiwyL2EFdHh93W7mU/CNQStZCe5l8lEnbe3XvROP1+BL?=
 =?us-ascii?Q?VgVB1XsyYIFRUtVvQy0mGbd6Ajx9c0xZ/6gL7e7XzOzFo0nlhYZkrqnqekMv?=
 =?us-ascii?Q?gqqt9leBtiOpizCdJ8+0SP8fuZvI7+LSV7CDi8CCCljgEelkQeuxk47mRqb+?=
 =?us-ascii?Q?p3AmtGUhaQiwc32IO3G9ITp4uKrKumjQbCbT5SWr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccca0ad-a541-42f9-1d3f-08dc96e327a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 19:55:54.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhZdCnfbDDT+3ra8CMjIqc+UPw+s+U4uRn7QmHaHp23mk5FmVWvyzKSzFYAccwkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

On Thu, Jun 27, 2024 at 09:23:48PM +0300, Leon Romanovsky wrote:
> This series from Akiva extends the mlx5 private field with the UAR page
> index which is larger than 16 bits as was before.
> 
> As this is first time, we extend ioctl API with private data field after
> it already has UHW object, we need to change create CQ API signature to
> support it.
> 
> Thanks
> 
> Akiva Goldberger (2):
>   RDMA: Pass entire uverbs attr bundle to create cq function
>   RDMA/mlx5: Send UAR page index as ioctl attribute

Applied to for-next, thanks

Jason

