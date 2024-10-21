Return-Path: <linux-rdma+bounces-5460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A388D9A6F91
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC38284C02
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF691CFEC1;
	Mon, 21 Oct 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ksWe66iJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D61CC161
	for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528426; cv=fail; b=Rpte34A8ZQEOLVlMzqjvEBI/qtnVXlDUtLrT5Ax0lBMgAxOsKi8ZFNFD1u1osCve1FtDO7R28TitxcueeXD53UyOoG7NpjR3dkwuQtS/XHGtCL5ji6RCrxqWcoZ9t5tqeEyTVqpHsxmzovtK1G3gIgNKvIyAzLxa/XFE/ZP7Jbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528426; c=relaxed/simple;
	bh=b/r5j0759gZYNrgMZVjQcAjU3eXcgxYAhhmtwRTZurg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=APsspphub799eIzXdGfYEJaZJf2np2KuHqvZzxUsOKRCtKX5i+Hc7l5JwrezRlcAlGp2S7NpDUtv0L/ZIJChdthoEnRMVOZU46iWh6g0L3QlzOO3j2IZLj1JtDBcRoSIX5yr+ETgX4ZzV2jejPBlvmX8i2gcHfA1joiDAFcg++I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ksWe66iJ; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf2dDBTwc+LAZnl+/NEs2dA/BXlgT+6Vbzb8MjHCf7HCrfa4d3TR7R6+upuHQ8083JhWAwVioa8J6JglCkXW/7z9XrU7B2nFkwP52ekglsCKEaGoKjcOSb6LY6nFHqy5bqr3boTNjLGx9zkFNVxBqt02PImfvCy8nythZtetzD7SGbzhqLkjtEJVj4zingBpE+qN6cv/dmeBIzVKu49DS65UXX9uG/eDHehs/prweanB6YNxvgmWw1cAMaqHAgHyadZwjie8i6H/qP/DB+2jabQpiKNZ+SgCu/w2G6RvkJ61FKzB6ED1PpAh73dc5ub2PDxYU6a8SM7aVhBDyyBCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRyz3sRbtan6148bDPdSSBhLWzPMk8IkREWj/XLRpTA=;
 b=gsQZ0bs69pjCX52ZZ8Kn8lAKzZ10yC3/EFaiEwPERLKmbhbVy2sQKwA6cmTJn0FzrgWmwbnMK6M/hCJQymyrlw9zEUuCm5zfFeIBZPuKa7yPJ5rlic/11nMJ/AmRPNy4RzmLyk8HhB/OcGMaIvPIF6c+sn6WUCTaVnm6PYmB0518n+tmdZ2WbeFReCXioZTnj9ITuEH5Ovd6dh+9mB2FTuf5NdZOLGdh5VsYnHT/0bC0yyQj3ojV+JWQhQatoJEcbooo/+DUSEdmqT41ETWRtNkSjIoCcx4ji+a7UFZ48gEVjAow66nu7oKLQFuL9GG27Oa35IHn26Q7MsujM7Vd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRyz3sRbtan6148bDPdSSBhLWzPMk8IkREWj/XLRpTA=;
 b=ksWe66iJhTolo0fWkNgJet36T5bRCSqS0yffob6YSGaiNS5jDO+EKrmp5yEAzmV8EY35HE+haps6xEyZ8nLcJPCGK/pwqbbggup6kT0AN6EjypDH5+udY3sTeKoCeZvYoI+mnmN0QZgR2GlXNjAjefYaiMdv4JgL8jlzdNl5xg6ko/AnaO7RFsb+YrdhEJofP8MCq1zqUUaSxWsDTGXWtHp6Jt3JFWHJw81XXQKaOCwFfTU3XyOl36aPTPsqEwBEMFBe9YXugTzWOJ+KGnHj6D1FpUIhM799Y+TPE84VFjOJzSq9mQgCWQLW7/3ZzFpVjSOodylxueI4ufAnIlMGdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:33:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:33:40 +0000
Date: Mon, 21 Oct 2024 13:33:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH rdma-next] RDMA/cxgb4: Dump vendor specific QP details
Message-ID: <20241021163338.GA40622@nvidia.com>
References: <ed9844829135cfdcac7d64285688195a5cd43f82.1728323026.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9844829135cfdcac7d64285688195a5cd43f82.1728323026.git.leonro@nvidia.com>
X-ClientProxiedBy: MN0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:52c::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ed9f60-8c16-4daf-2ac9-08dcf1ee1e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1enhQ/otlaIusZV5lj/0NkXI7ceUGv0ixWXAtLM74Yh48HScQ+3eSYRmR//H?=
 =?us-ascii?Q?4uBw6MZZz/8gOAOVvpaTBE51HprFVpRGcS6BaTDhYFzmN9V/MeVDMrHxP+CH?=
 =?us-ascii?Q?t/a6HnnB/XG+T5R3S//pYmQn6X6v1NwBSpb6jDEkej5/+uDwNMeAwRvbz617?=
 =?us-ascii?Q?yqd2FkpAadISvOduqZOKhd6L3dAX3fenlLSRh/Xiio8uo/Xx5VRkXP0IMV9q?=
 =?us-ascii?Q?3YkPCaA8q3wruIiZUjjnTFlvSomoLKv3qVomMwHhq+FZXt+kr/mBBbUE/w1d?=
 =?us-ascii?Q?cnLs7Ey6F2ZJgjlzPgk79yfxu1qsm4naYS7l84wIhirD2HOFbmySZk07t+PK?=
 =?us-ascii?Q?1B2xs3YoBEKkrqx49q/fQegThUzTZPlaywtr44f2i1WiDpCCtEcX/uOFEFRF?=
 =?us-ascii?Q?+hv29hKMJM5dsedCj5RH6vQ5o5dbnSEc0MW40K7Ey/t4ImxOpIkMoq6IKvru?=
 =?us-ascii?Q?iADM9JPZBE6f5UN9f/BkWeA7ecohZ90I0/TpSe903ros9XQOS81j9v4V2mLE?=
 =?us-ascii?Q?g4S5HufMI6apZv1NYiulkMxNEtFWoAJPTtmqihbgzg2h9w9dxZL00oYFLxLB?=
 =?us-ascii?Q?efkfW5ujKeHlgBe/uIZ77TaskqOfXjOgD8qHWD6RXT0OfF667x4LE1yh6Ukl?=
 =?us-ascii?Q?ikKK0Wikr9Deu5yQ0iGCkGeKaS59NHqo5goRGLJXAC4WjsvYMRMKhJ7oK1HK?=
 =?us-ascii?Q?x4qjmMXleBgWjlmfgh+pwDAvLEQV3gEOZ5w8V/wV+V4GHAwhvcHi2Ujz46kZ?=
 =?us-ascii?Q?Ue5KWAlHW5fffkHV4PYC8mbkzXnhQC2+B6Nn7GaKP8Ke47TgNsJjpZqPQH09?=
 =?us-ascii?Q?fkyLjDYdU87IXnNHaCd4nVj/wY7Efhg8l8VDw35Rx/g9P115ZyqKB6rPIhIu?=
 =?us-ascii?Q?aDLqgKtKwX1ih5uanCTRkf4Z61mHYxjWthO06CR1J7oCvVMpUzpTH1h14o3j?=
 =?us-ascii?Q?XxBUyGNYt0KuVJLsPA25D+xCLooJwnZlQ3DndwKeT4u+SR0bKbNTuD5sN457?=
 =?us-ascii?Q?Jc16qyl9o1XWt/7KLKCtGyTGv36AlsMuiIJ71dTtGrgR8QExYxPTqkXIc3Zu?=
 =?us-ascii?Q?C+dy4w98l8t7lfEHPHebdahK/lhx1Uqjmy8d+jyJzXTXtfbOdKTLG1WRT8OZ?=
 =?us-ascii?Q?+JQ4rfy4RnkXx5pRuVD508IiwdEU1oocgToFQR2t5b3bQnVFroqEKvHRWZBm?=
 =?us-ascii?Q?fLhvCeYmFi8ivNs/8GtiB2iKpjzTcqyt1+fAnmBTmXZEMrNW0E3JwL3QqIDz?=
 =?us-ascii?Q?12yAFFhz9JQxrf72vGRQbPfqTkheR+hgrBL1XVNsnhdZ3gsgBpgO5Y5OA8Ds?=
 =?us-ascii?Q?sECk10hXEvjUmuexYcW2YOxv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Evu9hz7D8qq0Wrby24FmSGD8B7wOKlvURHUoiNS2+KS5ttl7N4bzxWoezZGX?=
 =?us-ascii?Q?4A875qqWxl3FHujaZQnLy+TNITCV+wCe7nTNipaJ6Lxa0s0P84xx+O6Q8rty?=
 =?us-ascii?Q?DBKYpxofO3NCvTjRlwDcRHV5FARoAJo/OY+bW8Swg52+4bkXX1Cg2pw/t0Na?=
 =?us-ascii?Q?9QgD3Ti4iedYf/SCe8eqj3wueG6s79faMbFTRk/6G+6Dt2e2/eVPCkHlF9Oy?=
 =?us-ascii?Q?WXo/ijJGyS1QYnDkDXMhp0kTWpYx9nX/vXKBNZfBTJiwskaTsVLUCsh3Aa+2?=
 =?us-ascii?Q?SEjll5MhW7z9f2l4vIf7Uwm16Infi02Fa1p+/u6xpjSHFzhVNUHeFj54rQKF?=
 =?us-ascii?Q?ZXUFWzBQV8VL2nOlMy/bC/UJPIrDLfuYM+q5juzZ3N0WUaVczO+xOcVeNCPn?=
 =?us-ascii?Q?AAf7AjO/DKQRqZvNSBghkiZzRuhydpNh8JRADENxEUSdPBZ4IXDnSJye5w9R?=
 =?us-ascii?Q?Nt6AVi58El8Pi2RFvPxiYHmixuOzd6J6UH4Uvvj9zINB86ASWxHEWO3O9Lew?=
 =?us-ascii?Q?ERT7bBCWO+xvFu8bbyi31xLWQFhsGMnrHlKYs942c3jdP9PaMXAnwJB25twN?=
 =?us-ascii?Q?nfFJRvEVJT9PxotACs71Rr59pf9lnBnAQaDafQHQfNts7UllEP0bLWGT3r+g?=
 =?us-ascii?Q?7BYvMqZq8lWdud34RCPtqrrFVqqrt1m1oW5pxk+yLp9LrCtrn2qeieNsTxc5?=
 =?us-ascii?Q?JeHF13Y9BFXnxaEUjo4lNafAvURx70NWmHQ79jI2Yx9A2ZoLYgKh502rXdMh?=
 =?us-ascii?Q?CMBK1gKWWdkmP66FWsgYp9l1JePhSIaww03N681F5itUGwW91np8orn1KumF?=
 =?us-ascii?Q?dprdxa507avwQj6DXxm2GXtQldhL4NZw1JcIFWGU3RkazfKhkbVj4RoiqDLJ?=
 =?us-ascii?Q?0P4yCnUP43qvrTiF7oKjDr5XlrPcrnYglSPJjiggWR3GbwjpzZ1hSS+ydRdp?=
 =?us-ascii?Q?cEdElerl5TxHgzDSw6IAuP1PlLSVUhHY6OZqJPSHTk87+dVd/HnQi3VW0ECs?=
 =?us-ascii?Q?N/YHVkTAWpO0iDoAt2YMLaYeOxqzx8pHXumd+91qqaFCJV6yvlqTQ6MWhLYe?=
 =?us-ascii?Q?/ZEeT73mmDlm9BzFRSGaTgEwpdqi5gBotdUWNQ/WeTwPVWEi8em/LyyHTy5x?=
 =?us-ascii?Q?1AcuWwlAHEyDe8GsuWGjXUoD7DIJQK9Y0CPnXbeYQAzXdnwRdUwQNM4Uz6qN?=
 =?us-ascii?Q?49QNRR5z/8Il0IHH1NO4f7397m+SKCyuccHCuQ0xlaR/A+i1qR1/T/L7T9QA?=
 =?us-ascii?Q?dMq72ANEOtl9knu6crVQ+vm9Hg7uXyS7hcmLsojejL8Lbal1MbZWJ5/+TGcN?=
 =?us-ascii?Q?Fr2DS92N2dTDDyOGDrSdND9kija2WAnz1ZTBHWhSB49qjvqChEmMFtBYtyO2?=
 =?us-ascii?Q?hz1dWZqlTU7nbbccsmX9QeIIQnLgTkDPHupFtL9xb79JkQWm6KH7QucYykU/?=
 =?us-ascii?Q?YAe2cYwKL4w+nB4Ul7z/qyYf7c/SY5GFheBaP5dFRi4hxuY9/wbFjEdG8ufr?=
 =?us-ascii?Q?1V1Hxke01BulcdKbeG5Yx2nX+LepBCX+rEKuQPwDlUnd7u857hya5ZXReYNk?=
 =?us-ascii?Q?U1H6Mp5o0tAs8RgsfMRKFDnS42zPj6jrg8xdBgpp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ed9f60-8c16-4daf-2ac9-08dcf1ee1e91
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:33:40.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kE31thftfMQqXxNRjlR3pkFDGkdyxQ1NjrJeBp406WqQbq1446IDwD1xIW7iznj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

On Mon, Oct 07, 2024 at 08:55:17PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Restore the missing functionality to dump vendor specific QP details,
> which was mistakenly removed in the commit mentioned in Fixes line.
> 
> Fixes: 5cc34116ccec ("RDMA: Add dedicated QP resource tracker function")
> Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
> Closes: https://lore.kernel.org/all/Zv_4qAxuC0dLmgXP@gallifrey
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/cxgb4/provider.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc

Thanks,
Jason

