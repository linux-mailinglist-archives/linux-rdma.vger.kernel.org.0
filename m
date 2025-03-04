Return-Path: <linux-rdma+bounces-8334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC34A4EAF2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8150018937B9
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6412862A6;
	Tue,  4 Mar 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mmgxUxSU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C371284B2F;
	Tue,  4 Mar 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110622; cv=fail; b=R9TAYxenkp4kYNdwOAbRYILI2JM661Tx5XxEKJq2lT4CbvNDmSz6cSeMJ5ZZL4nQUlmmHe1P0Pr1cOMZHlEIQY/x7Yqd2RGtB2wV+Ec48/yFylZQyAZTniHBOveMY4ZML1p9lQ8MJVCBxlSbfTpjn8ASa0j2tbM960VKqyOQ2Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110622; c=relaxed/simple;
	bh=Z6zOtzOMvRSmoYOXufz0WRMMxVKSTvvwwERADgaitIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FuuhFNC16KOrtczTb0a7yknUqbLZeSj6EYQ5tmzce6zJeSJAc/bvZhpGZqOD49ngrosNnV2BkqaGC7qQJqjd73acbkfVw67S4Yh98BSJ46CZu3HbIcjP+U/w5dh3lm9Pxu6vyjs1spmGTarBjQoRdH3a8L7kmuQhX2eARF8ovuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mmgxUxSU; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxgKKgI7Qqq20FPcZuEMVgJ3xfdLbWW2BeU72pbuHQtVRDhCl589K+5ZeZqKRW892h3AK87AwZ1WzPI6b20zAbYKj2iDZkokBgLVBOY9Ikj+VRbUSMF4pcJkfSIfsBlUlHwMnxAbW84/WKHP2kjRQpyvAECMW0N793QMs2b8jxMOHL9dRzieFWEfefdCz9JhSOGcFLWuTUfYWCsijmKeCYG1wUEezqBb57ZA8XBXz/RHraRBfvTnKThgWAqlWfj7TaC1opNGRju0zJc9vHfkVVw4khjqbzE2x1XB9k0LA5Ah74vwmo5ww5k0LYCqE8zhjWTTE0JzH8nq7wRk/X5VWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIDxx3OJ8yWfDaxvSnmbmN6jS0u2kZNw1zwL+69SDIQ=;
 b=vza1GJitYtzUq/Shl6T4jlxp+z8+PKBDVy5+lyD6YRJEkJsjfcZ276BHYvyVo9OT98eCyIYhkufCj8joTra33jB9xDupAik4MZxVJqZd37Dkoe2Uhsa8yY3oZ5VY4lso5CAQaTqyIBNe9HnOqK6oDCpETENYK2iOUrtDg9FgjGAJSR+9b/aJymj3/zVPbVKqqZkywQI//OVrHgeLCdcyBuBNs795Cs0hyEwobelT6/w7VNIKEUCuPyH2wdZfxZJ0pHnNGFF0fftUK8OEUc0AslHsWpAi9ldMVyU6cpaZrIP2E+EoIuD8+5WI6McYRf1yzNCyq3s8eKzMNCkOV5mdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIDxx3OJ8yWfDaxvSnmbmN6jS0u2kZNw1zwL+69SDIQ=;
 b=mmgxUxSUOOAEUAQBZtaDJthjZKiHovLxbGMIeFbmkyksHt2DV3EsShHA2o5P+gTxZhnAoYj8vHYE2j3rjbe09M9gqMkmYuwNo9tHTDdOxwY38NF2Z6b0dPCB+B0H3Yn492xAS4wk2JQXoVOzE7RMEThrFx+fm86N9c0bn/QmmglPfzNoZwYVYX4AGRHH1hgC08YwcU/9tlWd9xe0j4ZjW+wqlXtrnATnbZJXYXuzBr9rB83MltH2u5zpu87v9dr54Om2LUNejlJB75x80I316+r+WLW5B2lcnTM5zE3rq9DnsFs9wQibH6X7M0tQNoRLZw0fEYUFFUpwnsogtZ3XLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 17:50:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:50:16 +0000
Date: Tue, 4 Mar 2025 13:50:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 7/8] fwctl/mlx5: Support for communicating with mlx5 fw
Message-ID: <20250304175015.GP133783@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <7-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250302121144.GB1539246@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302121144.GB1539246@unreal>
X-ClientProxiedBy: MN2PR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:208:237::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b1078c-5d14-44e9-3246-08dd5b4505c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8EonMTAVYdOGf8SCoYcqRbms1lMx5tpIyNXOufiRKs3XBpoZ4HksfATgp3lL?=
 =?us-ascii?Q?aRCJs+t5gskbGuMGtdMADRpSAgIrMQcs74EyiqQ35ORaH5wk8yWqQa5Bfl6Z?=
 =?us-ascii?Q?8J+GzHfQ3U0tFiqthFOJtOvX/5ix5AalaauHSJkA8gbz1FBIsXXjuKdBzl0H?=
 =?us-ascii?Q?HzWIeJQAodoT8synTpDwCDMvDi6spWdH39KdUGfTWkwpwgI/dZeFOzoNliYc?=
 =?us-ascii?Q?3g2/SM7XLyRMxMhHg4031Mu44W2k9EBEaXSHRkoqQXz8QeJlRE+lt8USFTwm?=
 =?us-ascii?Q?wnXYbunsfydfWzBM5zHOV3yyebXQ108fTObv+0Kz3TVDU6rkmanZrDIvcPP/?=
 =?us-ascii?Q?AHXUALboMhVmqC8mznlQgmLWpu63Y1VC5qFYKmASmUsbgZ3amqv/chi1ioFA?=
 =?us-ascii?Q?W9Yn/V0HU7VrP4v6TiIaMxANst36orkK8wPmQZwOuoVmvbVNkobrlMxmnwPA?=
 =?us-ascii?Q?EPVffY+nCDCg6Tc1cyOj2fnSuVKSZp3QVzfrFVWU7YWQvBbZXicrj4foEBaA?=
 =?us-ascii?Q?MFYn36KIURWkZADPo5i4gPw1l6ZG+UR4znQ8zpbhFIjqNVyfBtw8zBQVkBxs?=
 =?us-ascii?Q?PEcnVt+wqyeaQgQ0bZxDXAlGR37Wv43ibDmoZ4O825Z85B/6LEjf26mCqYGb?=
 =?us-ascii?Q?mVtqZo74Oq1ZqlHd9aiydN9gBzydskgbCRER0NX1avg/kPPCgAQxmzdFuAzB?=
 =?us-ascii?Q?HLu5+o/oUueYZ9FTPzI1UsnBQRJXKODepNXu8Q7OtsGjPnLx4PZVscPMbn1m?=
 =?us-ascii?Q?2fcPM79/Tq6355MBBaC6Rp9om6YqRS60ZIaQUxoh2Gjon5nQhxcIJhRPRNWv?=
 =?us-ascii?Q?fwEFqjVM97aFFND+oVNpvQccBzhGrRKh6K1jNArffIbjhjPsc5xb/wxPg12t?=
 =?us-ascii?Q?3jaVddma1xmMc+DvRDrfgh5xLdW1TaJ/w7JQiEJZjUIK5hsOWmiWqsAO1MuH?=
 =?us-ascii?Q?EwCBNmGIi5z8/haYL0jh7fQXa/7XF2LvVog9ypLmxeRsYigtNXKsAJ6VZJSf?=
 =?us-ascii?Q?gN0k+3SZC873bUIVqG7ozIEYq/8Ym54dPbDQbSUGGPirD9jnUyXzUfRvD7lY?=
 =?us-ascii?Q?L245XWz/f+YtLz+brb3yagDY71okbPO4V904TV1nzKyevUQiEKcB36pL3BTh?=
 =?us-ascii?Q?UT1/UgALRLDDXk+piaVlqafsWZ9OA30ssVRHYdPhH5KR2sS8S7bNNZrxxgod?=
 =?us-ascii?Q?NEt5FagN5rnXQG6Y6RKgZoIw4r17uMf6xDo107+fEh6BuRzY+rPL1B+D2/be?=
 =?us-ascii?Q?EzI+AxXcU/ZqwhhVETGKtCUqDmxHL8hg2R7BIgqmsuw/4wEHmt3+rTFh2WZV?=
 =?us-ascii?Q?/fWrVhMkpFWahyL57hc9L2JZTeCHffPGg24GUiPOeMZa7r7DMjT8mLVthJN6?=
 =?us-ascii?Q?+CN0xbU1BDyQZzUArMTCKL03Sudq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TkTfteOoACjbuHtyJzBMAvl68fY+7ffdmJjr7i4JMkSVrlT+2iSjSzZA5VwR?=
 =?us-ascii?Q?hCM+Ti1UY4L8agHe5ThHaXtJ8WHlSC0P+cYEyRSYocRtXgm4w6+OmEMyAumZ?=
 =?us-ascii?Q?aADed2NN2eohFIOWIW2fT+Bf3Z8kwEMCvjfXkVbWWVbRH1cRMtXmwwIujfej?=
 =?us-ascii?Q?T594iiVbQk5uOMArfdfcJp9Fh7FNBW4mmUkBCq02+GM7hqgalQAuCTOWLogB?=
 =?us-ascii?Q?eSgW6fyRBonwQ6S1kiG1EK3i7KJxtI20FJRXvMyGQJ/L6L4DAYjaCF7/GA1e?=
 =?us-ascii?Q?XFEFsSdHDGj2O3RZQTNnT79U9gWWnk8VskHQ/QXXMqUkHLEQyF23BCSduudu?=
 =?us-ascii?Q?Q/W1TkU5gaIE7HgPPE++UpbTC4oAr06cduRAd7OVSp+Ry2RQWAPTlF/y9yQK?=
 =?us-ascii?Q?k3uu0RvXjPvGzt+uqb3859A0QSNButc0dnTkChM+2hdBD4CdIdszsoPWfqVA?=
 =?us-ascii?Q?8xuPE8XsirguxXyCvOpUhdkNCCITTMStcQPCwKPDzQiOG8JJW/lB+VO5UTxS?=
 =?us-ascii?Q?x2AjXB0ABKM0Pp1GWEdmQO6Q4mTnyGAyIzaKEp/6M4hTyXWCZ50m4NSgSQGc?=
 =?us-ascii?Q?khcH0QjYU/2BggBZS4BScYWJmOd3xaTQNlbcs9dB7G3KfRZ0hdKeQr4YUqgB?=
 =?us-ascii?Q?szPd001A32vata1yhdhjqgmIu2RdYoMXm5n2DuvKLwYD9flrWlk6ogTCncue?=
 =?us-ascii?Q?ZKbOIUmRTqID7cur9Vb3TdRqhoA0OYxmQ16yh8a1Y8snhU2+pF4qFoM6Bfq0?=
 =?us-ascii?Q?k9dEL3WtS5HbJLhsQKl0Xi4IQeDinIf19Esvoep/+03OPUQPerdp72vccDoU?=
 =?us-ascii?Q?EEj3V/sA6HIqVc0E5vlDSTK9ZjitJFpyPX6TsqzOpPoHza6w16eBSTuGD6ts?=
 =?us-ascii?Q?G0l/Z++QmBhNiAoR7HMnGASV7srUJAQmxCeRGsfz1PV4PuU50g/VTz7aF+Yw?=
 =?us-ascii?Q?8kG/XOt7RzQzygUt2+PaeHuJ3A9brlD5FrqfHGw2AzRnIcL7n1s0pKJOtPSJ?=
 =?us-ascii?Q?ZTLe1k3TXNp6CP5VvhsVlGniOEW6KW1ANLG3Yjb23xWXfijIPmkldmop9g+3?=
 =?us-ascii?Q?ahfV0+0fGXjW7Yzir5++2TSx2DISgGa8QJsYyEKmm5KwH9BxBLkF9Nqu2wx1?=
 =?us-ascii?Q?CqNv3VnZxfcZDbmcMLw7mog2TVb6wtkRCWFm8MMlecj2a5dBBvrnh0xIzRHI?=
 =?us-ascii?Q?9Ro67nDUHusUouhebuMWbDX3IzpSEFM7jLhevyfg2UIWlmvBA3jwBg1QpUCe?=
 =?us-ascii?Q?UiMbdbGoyCOi61HzqgaE6mVyWIzJms8IQx+giVuE+Q9RSpISqyN//YfyZrSg?=
 =?us-ascii?Q?v/1HYUK1nJQ9rUn8KFwbmAHIBma3yf2zV6U3fjgKgzvfEFfiTvMR7yrkw5Mm?=
 =?us-ascii?Q?wWoaOeTEw8UXbb59rndcDWanWqFvNNPvuwDVKN8Rb0M11ADA2GSDguzIKIJf?=
 =?us-ascii?Q?7tKaL8C9edWDnd3+K+hf87TDGmnauyNEMxobZhcDN0u2KZimEa9EpOwTaRp+?=
 =?us-ascii?Q?i3XMwcYUp5/BmVBk4tBNXRSIblgoQtMvfgXuDNv1y9cWJYJCtTp+q09N47UC?=
 =?us-ascii?Q?WjZNlltjkohRy6HlMQ4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b1078c-5d14-44e9-3246-08dd5b4505c0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:50:16.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdqxiJ3YvL7E/YrVSHpBAqDrkyMmN8RoAXI5dt78k5rRDOoFSi0/T5siC1klZ2NN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333

On Sun, Mar 02, 2025 at 02:11:44PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 27, 2025 at 08:26:35PM -0400, Jason Gunthorpe wrote:
> > From: Saeed Mahameed <saeedm@nvidia.com>
> 
> <...>
> 
> >  FWCTL SUBSYSTEM
> > +M:	Dave Jiang <dave.jiang@intel.com>
> >  M:	Jason Gunthorpe <jgg@nvidia.com>
> >  M:	Saeed Mahameed <saeedm@nvidia.com>
> > +R:	Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These are unrelated changes, probably rebase error.

Got it, thanks

Jason

