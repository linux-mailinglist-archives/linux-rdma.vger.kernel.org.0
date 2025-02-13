Return-Path: <linux-rdma+bounces-7726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7BA34196
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656D0188939E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1E2222A7;
	Thu, 13 Feb 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOsQmGPq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A48171E43
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455467; cv=fail; b=ZudPdYCAtJ0Ob8OPrq8r7V8jPlaATHwspgvWHjgbfswHnT3s5lFBdz9bmNnDdQ1jtr2vVSAvigrUMsRW4Jy+aAxAF3tJ/kCGIB7M7wsqHl3tgXeoTQchF60zCAQNF2gn9RjrtchA5UPaq0eFDPN9qW9mCcp5Z7C+HPL73nBZUZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455467; c=relaxed/simple;
	bh=+cjtmjlO7V3ObMBGZDMe7R0Ex2JiMBLc3GyZoAjshSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m/6+4CqE0c/FYcOc/ZZlPR1lvamzGmHhMr4Llea7KWGWxOdDCAsLvnRzTLfr+55RyHTyjZP5HUvTWHRHmKVi5UJecWY4zgB7LUIrTikGNDnSQQJYdaEmVy9VI4W41AVL3FyDv7hEymtaKaGQnMHkbwPQjyLujP7NrnTCmzcS7mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOsQmGPq; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLvXRija4U7cnGMHxLgXAHAuRiSHvu2j0hQUkNark/vzK4nDJtvVqmsIOvcKUmvdHvZX4tjwVBIrFg91vlDN1xIiIoo4M4jwBHi5DwdwQ2Jlvlv3+d4qKwDL7HxchsIcvZoSxnz+uToYZnpPtZGV06lr0mNrihk1wdkNl6i0EABngLUmplf1N2YT1BhBoPDrN2Ninx7vC5/QRi1oCcRFhfrl5i+5f0o/wAVVStU6Cg0hfO/fpW/HBsU5Iv6ZETBIUTJ2WkZUFrKhLq+gw+QD1OIjNWkEtrGCVFNX1jhBaLWcaX5FjWo/XrMJ3XQICsZld9DkZCZDVuTqDcDHO0jAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phrLvvaB7WmpgpG3lOhBrJqvalD7burLr+SqcZp7H6A=;
 b=OhOiiHFVVPDTM8u63feBaijWsZEY57FrL+D0xlmaZDXH3HOuTRrJ4VB4ftLYDv+VrUewmb1en6hW3WNaTxo9t1vrRqRL9u8POnDdKyU3NrT/xKVUQ78tn/12DHvSktIIyBBkecXa/rhUuoFNVZ0VCnile8ukvItyjHieD9ombJIB2hRBjnfKGuMHAnYmLARspQ8leCiSxNgrJG7gEeihDF04a0D/pjeazJs8H+RXcPlFlLAK7IjZCwzks/JSVlgH3YmP5RqXnO9TgEM4yBWCUee0H/wJGHjgRG4LqrfoQtHz6jVSNQMs5N2h+6Rp1b76SN+oOitVJWWf30M636eeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phrLvvaB7WmpgpG3lOhBrJqvalD7burLr+SqcZp7H6A=;
 b=VOsQmGPq/TDnKmxU1Zr+1cGeoMakrSnWIxyx57o/etPYls8iHF4MHl0bYpfAPCLd7zXPlIcU3Sl29YLHAfEYhHV5IS2+0gjUTbxl9nUWYvt2WFg3xCU8srb7LLApXNo98PcQ+OJyo2OUNrJqsB/3kdLwdqiXa5eQxguj6VL0DFYJ3lz4c2OQkAlk2CV7DgrlMPS09kISYQTZ5C+LfKI4QIrxxOsWI+d+NOINmUDOQOkfQlXl++mNftoZtAQ1Wm8xenSHi+wxxyQ7vaITQ6ZY7gvrQBwrmElyVqEE4gd2dDeZ/+E/YT1R6nSBPC0/meOVgdpQCMTc0we2GmaynillTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 14:04:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 14:04:23 +0000
Date: Thu, 13 Feb 2025 10:04:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Michael Margolin <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250213140421.GZ3754072@nvidia.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213125126.GK17863@unreal>
X-ClientProxiedBy: BN9PR03CA0632.namprd03.prod.outlook.com
 (2603:10b6:408:13b::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2421b8a7-2633-44ec-4c18-08dd4c375171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ryaW2Tz3mxpXqmfY8ByBJV7kfroGqrY0eHX3nozYp/CkmXg4BiSHAv16Ibq?=
 =?us-ascii?Q?AZEq+xqdjwNeOPJk07usUhB9NZt5ZSXtZFV+hAiKBcD5tbbiW3fsiPc0o/kg?=
 =?us-ascii?Q?QrfKXP1WyQTmqDQOVNqAtpU86Ef+Rgb4RPpq32iXpvomdL0GW08nwyDe/C6g?=
 =?us-ascii?Q?vx1vpLTCuD6pz7DswdoeoNHIIJcLNh2Vn0zOygrjKI+5xqCAXbIeVnqKNCR6?=
 =?us-ascii?Q?O1ySwHV8zoNNph4wcGc78hr1ImlSUr2Zl1K8pW929zmrnTNpQO19q4gwSHvG?=
 =?us-ascii?Q?MGCDXEYm7gGB+UDI5e/9HckATaKZ+el3p9R6g2uPUSX5pLFPaDi9wTMFicd8?=
 =?us-ascii?Q?SBI7cZZTF6CE4mkjt6+BtC+G5X2MMAuFL/X6++GBFHNuh6QQ1QdF4hrAeN+F?=
 =?us-ascii?Q?7kKTsBOG7JHwwxB7qKK0fmeP2azOGGFsqD+rxlfa4P+fkC97QDFf9i3wZ7Kc?=
 =?us-ascii?Q?3sUWzv+0hL0IG9vj9SXV7UsKRs1T0Qma7fnHQc85z8Cv9er2dqhS6d+htDtW?=
 =?us-ascii?Q?e76R6EICfsxN1l7tymyiVPxH9ndZjXUHEzuYUQydgOIwI+6qZPknEdUaOqSh?=
 =?us-ascii?Q?myqpArQNM3aNAYyrv8VNQJ0I5tOdsAtZU7muFj464Cu8vKrFeFUqDs/LmthZ?=
 =?us-ascii?Q?+tjz3eNvXQMuJKjIbB4ZG5SznCQg3w+/4TXA/EzSe03qY/4/F0GLsLWCQiuj?=
 =?us-ascii?Q?l0KcwH1TbYO5ewGZkl9mb4uLj5dTE5zPZJL1SyZkwrbGUFETixNsRRHisPbj?=
 =?us-ascii?Q?zAiliTtOhHbXfNsicHzAiXcIfP6Y4oWBY2h5sZfkSeQU+tRApHxlR8wsvwHj?=
 =?us-ascii?Q?/4BkevOQw0u2YfcrS+qRC2V+tNXgd3mpkxpzXmcu7utmMNokVt4gOvgfi9Yv?=
 =?us-ascii?Q?P03bRTTU57nZ4PzOVIK/U3pyqfeG3Ce1St6yzsxqgTf/wNAa6f/Ss3INJaW0?=
 =?us-ascii?Q?bFshiPorIQYS3dWViGQID6qdR6bx0TF6hFZ4GJVjeUgSRilDS1V52CGD7BNv?=
 =?us-ascii?Q?H/AcZBu8bfNr8/3w7Ab1rL/HK+ziRmlFJbg+IAfUJtXxJj74A/ZTpDLkh0iQ?=
 =?us-ascii?Q?7jSpUa06xq9cHdI9Cb0/r+STu1lsu4gGoeP94888uHNWGcHTw5mK5bMSS3Qy?=
 =?us-ascii?Q?Mdd964IMNvWCvcy5zzGedjLiFpYFs9nX43jQh5j7IS9T5OGxE9mm9bxwX5gC?=
 =?us-ascii?Q?zYgvFEfWGHxCfvRA3bxHvxfrJ/6BpBlv3AeG1diFs12rJwt5P8qPuphlwjn+?=
 =?us-ascii?Q?bznJRe2TPGkO/VsfDECu6QmydxhSFCtwtVgu0I22WLTx1ospyMqQD3ZvwRxa?=
 =?us-ascii?Q?wslwiTK79uZUfCz2c653mH83VfMrX5Cm5W1NMlB+bbJnZfzKpWX1WJdteU/L?=
 =?us-ascii?Q?QX6jk7f0NM2C9bukfc0Kre1pJsuI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEByEJrgddO8RQovYdHgDajy+OmqVmyplV4ORw84s3l9HsFd5fIet6Ni9nq7?=
 =?us-ascii?Q?nwBRrEQVp+cjiHo9DcdPGNLI7BhEnc40ruUWAiTI8tBJM3qtZj9x1wHImNHq?=
 =?us-ascii?Q?nzZtB9P1bUiGtrAQfyM/I+Z6kIPY2uPkViCwmwz9MNX1h5SO0cuUprWYrEgl?=
 =?us-ascii?Q?qO6MdGXRGVUAXIoooEJcfxg+ptbiPJOx1Qm6QpiZP+4oGnYkCJ/EXJpW7OR4?=
 =?us-ascii?Q?wXGkhuvmdPP4Zgt4BOoEdXv/5k/v+DlFzM1M2FZCeeJ20iCf/jewjLZIolT1?=
 =?us-ascii?Q?1CLuKwScpKzn2PzAHlzGJaLleBktRmasxKd52YZFIzp4lAvPSYFGpuhqwJM/?=
 =?us-ascii?Q?Ju5xNG6++ve3wAkuB4jD7uw+B7RsoxfefUVgRYMk1TWU4UwB6FKCmfpFP7YF?=
 =?us-ascii?Q?7k2gZ5rEgeZiZDfClxUinHDFovUEPnM3kyMUzRNzzbKN9Q4hv8VJXwvn4+9C?=
 =?us-ascii?Q?mI8U/3/0F9QLxiMugULXArytI5vpvTI5qOooB3z4axo0X6Qm9PZg/6c1+8/I?=
 =?us-ascii?Q?pK/GHsAdhmlqPTACI/GnaTofsRdjyQ06F7XdlkRsC5k+4Lr24stFeOK1ug0E?=
 =?us-ascii?Q?lKuLpKgheGNO00z1U4UO6JevEusIXnzhcNK6K2F4jHwXuxiSVDPyS61VtXml?=
 =?us-ascii?Q?Md7tZJWZMN2OWfpbAOz67nNPE2XP51L2TGdcE5HHT/F4vEnR3yn1VTjptnoQ?=
 =?us-ascii?Q?FfJfTUSjks7HEoQ467e9brjMoulXtJY6hnhuUY0nJUHI0OalnOFNYpJG2a7s?=
 =?us-ascii?Q?uMf3P1zAfZz4VTCG8TiliGtTj9xmy/qG6LKIOGDDikLzxBqrN73BxUOd7wkV?=
 =?us-ascii?Q?nTSw1Njnr7jnwQtuPw4/PjpZn4eKvHDcTfxjc+LohebBe3KVCFv1e8sMiTc4?=
 =?us-ascii?Q?3GLgmvjqx31r9DdqdWNSDrUd3+jtQcq/NqiM0WzKfX6cLIVW8w/yDl5bm+U8?=
 =?us-ascii?Q?fCCnSeguWjsNm+7uG/w8cNGvq651g9z7WO+YjHUQWnlgMBm7Z6PHInYM4HBA?=
 =?us-ascii?Q?fpsZSl4yvAPkyKILT0WZHQ+JJxRln6XM1rVqjurQU2u8ekg7NUKSZejQVHHW?=
 =?us-ascii?Q?Xwgn+8cXUq5bZ1sLIn4RqO2fS12WXf5b7o04ctUDYJTTmrslIaUt7JRRck9P?=
 =?us-ascii?Q?gngk2gJl/Um1nRYe25K4MFrAn0HAVnIww/I7UtFMRwZJqb2a60mJYTijwqzn?=
 =?us-ascii?Q?5UQw0aYF/8eYXSc6SSbNtr5SjoVIvtd6ibB3kjy27Hz6mWs0YpfqDg49MjHr?=
 =?us-ascii?Q?016yfxJ4OWmlFlfs4CPSTrbJW96YQLyppanqUpDmCJglwY8Bb+FbRvVJRM7w?=
 =?us-ascii?Q?YbFPcvK/dzLAMW995IxnRkySvv8og6FsvZT/9fCkd5DrkPmjbpAYz7+NNRvi?=
 =?us-ascii?Q?ib7BQs9Gd8uh/C8ZzaMSaHEBImoJVOcmDC/tdUcS9iktOwVxw1DFp6HmEV7X?=
 =?us-ascii?Q?BpqYZQ/Xpzg/T7TaJamg0Zc73pvhdBNNUwPAJn1Kx7ch6hLgxEUx96cZe9iM?=
 =?us-ascii?Q?sbdmCqa1P6ZLWPuGo4HU5o8rtBmClXLgzIi7crs8vHZPfj8ObQB0zViXRjgZ?=
 =?us-ascii?Q?SRg/70FjYrIBhffprSd8mUtq/mEfLaaAPFlvr9mo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2421b8a7-2633-44ec-4c18-08dd4c375171
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:04:23.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4PbeAEpT5l8tqThFeIpv2818qSTzxZvFunUyMiBFz+8GvbrxDrz7igl+21Tvkfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

On Thu, Feb 13, 2025 at 02:51:26PM +0200, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index e7e428369159..63a92d6cfbc2 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -112,8 +112,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>                 /* If the current entry is physically contiguous with the previous
>                  * one, no need to take its start addresses into consideration.
>                  */
> -               if (curr_base + curr_len != sg_dma_address(sg)) {
> -
> +               if (curr_base != sg_dma_address(sg) - curr_len) {
>                         curr_base = sg_dma_address(sg);
>                         curr_len = 0;

I'm not sure about this, what ensures sg_dma_address() > curr_len?

curr_base + curr_len could also overflow, we've seen that AMD IOMMU
sometimes uses the very high addresess already

Jason

