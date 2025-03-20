Return-Path: <linux-rdma+bounces-8885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C0A6B190
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 00:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A70176830
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10BE22A4E2;
	Thu, 20 Mar 2025 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YpqWdJd3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA4218ADD;
	Thu, 20 Mar 2025 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512947; cv=fail; b=YQ/DgYLf2JtEicFAQvy+SgxODOSmx7NyIU6rsC1ngjNYTKs3EdMAPIcwO11gqCjlS+d4jXXOrsj2ZxWDFxeRAXwHkOuspif+qUAyaGrji2GC8AIVStJo8Jb13cqzUSmB21T/i6fn/lxy/fEZwXu+fGGOUws5XEaBI4c1Py/Fo6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512947; c=relaxed/simple;
	bh=Psl/YDGHBCFn2ZkndDa4s6DYj4Y1rq20U6gYCqv+mDw=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pbzf+5pcAAuTa79l+i49pL/FxaeW1FlbP0jUWIOeyPzXHnPqcBqKO/knWxIKz+FO20xVJb/DWzYpe9FbAixu2kSV/8jy8J/7WxAYOe5gpDQcJgUzd+CqrA4djx5/xMQrbU1HKi+Gt19ZQcOY51E8TKZL572cdnte/D1dLKoQ9lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpqWdJd3; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyhtxDEUKuXNVGhROeRJKThCTIIvp9OXxL1V/Xc6hCQ9g2coosjPrDTuC8CcZqM5tUAUIB8KCLtbUVbzrJwOgyOufg7I57wNTI7yz6IIiOZsGWUb4MgxV0nLoa408LjxMqKLf+Wddbp+k3/N1uJ3dP4ry7g1Ha51QQbCghwgkVAgyItfQAIXxweaxwlDU6EWRkBlYgOkkJ6IytjzPN5sh3v+03lHOeXfE03owP1S34Nytp8RQjDGL1oqy8ea9yVJN7XY+11EqEGHWKv6pZ4Wdf/v/VnXrBSffFvm/f16Q+65UEf/vVojkdQPIQx9JR22/c+DEEY7C9arOOyWhn46QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCT1oSWvRGHEpOHzGIO1H5am6GrNnH/vY8caafjTQ1k=;
 b=AcdVeZH1U+LjgQr0CCwuhZBV5DNbnJUerq+klYIpMywd7mRLcoTe1ph7oROvLSWr07mgTHrsx4hZIaNRxdx2+a9xfIBiQMXYO/XMZ8q964Tn75qcS2QggKXrbX55kbTZBlBwdxSNSlexgkzm5AoRLMRoIgN4q9oY94Wl22SEpkOGZeOy61dWQ+GhZoX0lWSRHdgZFte87x+dXGrqqn/weJD1Hj0SXoZm632hbxdFLehlFYqFCt2320MbKkxBLO87LVpNieBBjHnrR6m1gjfJRcVX4sGIRHI/nKAQonk41Hv8vwEo1hMK5GqTuLlW2lDI7BSLBxq7sLPVzbomYoqy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCT1oSWvRGHEpOHzGIO1H5am6GrNnH/vY8caafjTQ1k=;
 b=YpqWdJd3eXx5xPRunYjUjb2jr0ScbixciAWq6tdLaZtuj6KReAuEDWqLOAE98C02Q8nopzB2IavsQmNBqY/q9ZIT2uh8V3Cb0oQ7WtT5N//UWQhczVHPKDDpPFMztIzuiZNlh3ebW9jvvcog7lPTGEAiopxDMn8BdEbS5vN7aXsP/esn89AXYZzARgIZFYLQB+UK60ERsov4gWRt3h8AGfGX0Nmb7U5RGlDiSEY4ZBRa+CqcUxUQ5posKzLsQLj7u/Z/aTrHVjihVBh2anf/PvUtF0pbVewD6r7FGipMmSM1wYDEAnf3UpoZoCjI2nXA2UMPD5psWCTQHsnrjs98Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:22:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 23:22:21 +0000
Date: Thu, 20 Mar 2025 20:22:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250320232219.GA229239@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:c0::47) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f30963-c922-4cb5-10f4-08dd68061020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rD27Rmj6zfew46mxfMMYZeiJJgfTgHkwv9WgxGH6e/0HNkdtBAjmvuj9BqE5?=
 =?us-ascii?Q?cqmsMPaT4ZgYUjS0tx8BQ7nj97LEMGvg0L5KQccGcSeP5MtTvCcp9PXPP1QS?=
 =?us-ascii?Q?rWbBrB79NfevQmZ6elTDOMd2LAxCZoYUhSKgQB2JI2hkEBv/kgrD8u1F1m5z?=
 =?us-ascii?Q?F7mGs6P9H5HbMMRpRqy3IgPWuytKT6+fRbRupZN5wL8RIbluhgD2C6/Dn8Ij?=
 =?us-ascii?Q?tY1CEAXCdFSfR2pzr08Nmy2xQeg6oeP4rD/k7tyR9j/w2Gi7U83iQMWDJhpk?=
 =?us-ascii?Q?kFxcqq2NJXXxLlO1fDeJ9QE9w8jN1Wp5wG0MXpCqY7ev1xzuWovKD5pucz9J?=
 =?us-ascii?Q?WYRuuO/S92HstTcUXHdkxDPQfnkwAQwdv92h4VWdFmQGJGWO/pNMaz0A7ti+?=
 =?us-ascii?Q?a/I6HzYFxjLCGvb8qnzDYCcCqnjbJ8UGJk9t9B4J0GDljysp4POlq93iCmZo?=
 =?us-ascii?Q?kWgIE0sCUt/NXExGt2vbtpELn6HwYmN0motoTIW/aelO6/1sRUsVxKoUwiVE?=
 =?us-ascii?Q?ELEm6jdkwgOLZRRKKnw8e1jW4sa9pGo+zbsR5ludD6FGszAU4Xmjqn+lan56?=
 =?us-ascii?Q?ZPXH/dMcbyWi0JI6bNksQm15flC3XJV2xFvNqeUBWE+60tQr3h0uT6lV2kCQ?=
 =?us-ascii?Q?SdvzPzcwzF0vaXMgPN29h8TJVC5vR9u+wvr7dnwqIZ5QoOtI2cfMzH6Mszxu?=
 =?us-ascii?Q?puQxFv+NbbzFFiCul4nb5yl8MxbQRBOnaYdCFvZsGCZkesRKI1zNTcPT/ruD?=
 =?us-ascii?Q?RgQx+QFLyqNH9E3k5ctFdXtcJgtjZl/6/knnrxmlx2aWOVsfrWHXogPopX35?=
 =?us-ascii?Q?5XUr4/Jbr1G/9y8riRqrPuTqO1foKti9y+noHgt2se6hnDUHxu3982JOTbeJ?=
 =?us-ascii?Q?ibaVvG/WAIPxACou34XygNSGSyWI7MUhtXOPz32dAy0fW3JwqG5w5wa5ssZ5?=
 =?us-ascii?Q?pvRg6M+CXHKfkM3n8EiyJh5il/nC/O/c/EIJVoOoz7CA02enO7PD2TexCU01?=
 =?us-ascii?Q?+zBJLvdAH+To7WgRiQhQTKWPanCWVkE2e2sLCRth92muzfOc8iSTgPPReHFX?=
 =?us-ascii?Q?fBDNXXROdV/NoROKBs/Cnq0Vti3YYPWQl1NsV+ktLS7f21PGrB0fCEOLbFt+?=
 =?us-ascii?Q?RfW7IIC3ofBeluf1QFysIQ1/YdKNsI/XDCoWRzlsPJn1dMv+T59M4t9muSfv?=
 =?us-ascii?Q?3IGvCU4RJ8LN2V5RjcoJlDsY8AjVFB/StfRUDZ5yyGr3RfKfDabt8HJFMxiL?=
 =?us-ascii?Q?wS/mGTY5346w9Zglqr9I5q/WOTlC9lsHjqQwBmmquBAJZaazRFDWFWGGeldG?=
 =?us-ascii?Q?5r4tvlTfhr8mQocHTqgaqA4eJ3LCTJPd5Ry2VRwjx014lAEfbTwWWGMO4DN1?=
 =?us-ascii?Q?bex7hmFMmormJWYbwosSIxTnETHsYWcu9mAqa/Vn/yodEeIIDHEPCEtqMRFt?=
 =?us-ascii?Q?MbiBnKtCGMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/00ky0UtS8xM6XQy4ENfPIKsYg0yJxzQWFOr9+G7IHKWur9ntVRzx6LtzueU?=
 =?us-ascii?Q?rslzS+T0nYtRx+6qE5GE2eHQ0oiSu2XAGLMTiD93mxq18gzFwFFP+7Lscbr1?=
 =?us-ascii?Q?hbvILzsPVWHA94KpFZTAkCslccWEof6cI7Ma58DppSrkI+/wXnSdiD7baymN?=
 =?us-ascii?Q?s3lQZCYtSR5HWW+0SkyLqfxRGE9OoaXaqKHVKT5bjH7nQw5P97hVkQfE1OYr?=
 =?us-ascii?Q?5IMWEOWvRpA5o/IFxl6gT6hZEg6XFvxrNy8Z9P4uYnwnSP/ZBiFoNIry50rX?=
 =?us-ascii?Q?iZVa1LQg2B531/tT8L/sqohfRcXNOeZ5rSWA5uYruI8Z0JDCsl1PpxvM3X3E?=
 =?us-ascii?Q?q0i5O2yihv7SQYUnC5TmwmODNSqZl93xoYheKgPo9jhmpCMCz0YWDZjG+bQ2?=
 =?us-ascii?Q?E4kFv0WJ8AhZ7sFMflPHrvdjthpkBx0q1lqpmnpurNPlUQAqS90BSWpnkFaB?=
 =?us-ascii?Q?cdjPeZwCkG7tOD7GASa8710l8VWAm4mvTcFDpVcnv/MTTAbZIGNTzvfH3MmV?=
 =?us-ascii?Q?Keq5FTuIB/aEE8F+0I2BfmZU0B/fjpvBwQtmgVfB+AjSVUw8nbY+9So/3HKR?=
 =?us-ascii?Q?/kO2xvr1GZoV3s80PnWMvAw7RmPKp5lJTougBwQlCk9vnOwsRq7wYXRJgGy8?=
 =?us-ascii?Q?w9O+8l7nC06EdazPOZ3YXHfOv4O3L7mTLsqO2elcvgDr906xFjWT4Se2VcOu?=
 =?us-ascii?Q?Cmh7RRPb51m29/l5RX9Cf14faxdMGvz2Zej7fZKK5gBXWbVEBEP+LNLlwoy1?=
 =?us-ascii?Q?HtNcccfVmaKSwtsypz9MDsgX0gSu9fhg2kjzB1qAhDMspo75PY4sSSmk0Hcb?=
 =?us-ascii?Q?YcDchs3r3rm6sEJXH29lphv9HuYdi8Ekj1+sR1E4ha+u7EpOduhK13/y8Ofo?=
 =?us-ascii?Q?4skhhNg5wqkfmJPr+6Tq5cs8SbDrOOu4nfZepE645PjH3OL5pRpEu6U+7Vkh?=
 =?us-ascii?Q?xUBtHauJbmFk5ym+dI7e8xDrQ7uBJbnS4cwxCNE6q8DlFKB9rOMyAQY3Oc/+?=
 =?us-ascii?Q?738c2T8E/soVBxjLDUOG7l9Ln6XsnzVkpKY3FOMD+qA6OFay+YmYGjudYXmb?=
 =?us-ascii?Q?yQPYnOqdkSb+ABoSwcElc5S616WKo9pR1XI/66TqJoxlKcgqjCZMmFqGjH2X?=
 =?us-ascii?Q?yfoIsyYVvShkfm+YaUkxro+P0pEKs7ubFg4qNKaLeeCtR0qmatM8/RGPzg7u?=
 =?us-ascii?Q?qcDtgJKrvTke4N3ZTFuarDZymTLN9hJ6uymrcRR2I2zUwayrk1flm6/A8mqa?=
 =?us-ascii?Q?fntw1/T1mYnzdRSldc+9SHGce2q+HSNIyAbI55+XE1hXtCxdDahve/cdbuep?=
 =?us-ascii?Q?mi5GNUR8rqbWaWf3WmQFAbaIUcakY4DOEM+pkkkMWB6EZDN/5jFQKkwXM5xc?=
 =?us-ascii?Q?QPmXKESgwn856o7xKY5qrrYr11cVOmF5enH8pex4ELGl+I7szE/nFQUvkem0?=
 =?us-ascii?Q?c0d0uu+YjULfIK6aMtVEfETvKlcY/YHMrKjjXs7WPqW6ccQxzGbO23WFVRim?=
 =?us-ascii?Q?9kEMTFShzkhteXARII+PRb+UPz5ZkR3vXPPmBiDjhZ1X1LvPkM3vhpwoI2Uz?=
 =?us-ascii?Q?OCZWZTP5qyKie2C+Z19oB9vty3L9IXtIhK4/H/fQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f30963-c922-4cb5-10f4-08dd68061020
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:22:20.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ4rBelLL47gjWPTVtEAPUKiidzhDX8hXF+8NMZfCkR+GxSxxgPVOPC4G8HXd4Yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

On Thu, Feb 27, 2025 at 08:26:28PM -0400, Jason Gunthorpe wrote:
> Jason Gunthorpe (6):
>   fwctl: Add basic structure for a class subsystem with a cdev
>   fwctl: Basic ioctl dispatch for the character device
>   fwctl: FWCTL_INFO to return basic information about the device
>   taint: Add TAINT_FWCTL
>   fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
>   fwctl: Add documentation
> 
> Saeed Mahameed (2):
>   fwctl/mlx5: Support for communicating with mlx5 fw
>   mlx5: Create an auxiliary device for fwctl_mlx5

Applied - it has been in linux-next for two weeks already.

Jason

