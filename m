Return-Path: <linux-rdma+bounces-5462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC39A6F93
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8DF1F262B3
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021A61C462D;
	Mon, 21 Oct 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+HKX9kz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE82946C
	for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528460; cv=fail; b=WmBToBQ46IEI/90uCcdQXl+53j9Q/FuDcCKs6z3HP/Sjs5QqVLIFMWFllXiBGjXayS93V8g+PfY2fugbsriLpigJ0HLw9jDpf1YMsWuyEoJHMYps0w8G4+v+JsFg55dpetORkvR0UGUfxosqSviyWCzTdbHHfppbHOtcqnuHzsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528460; c=relaxed/simple;
	bh=JA8c/rSF89LrLpKlRKRRbQtNxATa/SBpW8UYnR6O+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OSfZ/YnkV37k9gdOZFxqw/lFuc6q0a5LXJan6ev0pn93EozxU+eFBaA3zm+YjszWbru6+TrSIM7i0IgQWZsNfqE16+IDwAeaWL1d6ktny6L/QyMhzEez5mC3EgdCA/OrtrR4E7AX7o6No9LjiP4yK+DVGu/ejyVznWntcIJZghM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+HKX9kz; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKnk+1icn+Oz7aiinw8ITWUf0SMi2QGH2V809DSTiN4xd7EA1lQvvXmLIo89PfWr8rRpqQ7a60/e6fsZAG6LI3UShLPD/kJ3nnFFrRvL8OZLSyvEOXixsbO5NRevS7G5NAyC+siciO4Am59VVwkDAo4GkqZ0R73lHxGs6Z9886ETQJjA1P1jHEYQXtKTwXDgPZgL2EUDt1lPSTvmeVtu8viZQy+jOKYj8FJcMPN+8xh6/pCMJJ22ezx5WoqJRgF4OxW2oxf41f5WcDonO7hpSFgDrJ4lIVbFaIRGYdaGwzWw493MTDiONIUYPFIzb9rcKHtS/KybugWU4DooWUVfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQnAyOez86y2p0J/NJSXW6RyWhaVZYnvdXPqMiBVwyo=;
 b=vy/L8XWymc4hf4q/x0gb3GqcQGCNsNwJ/wdxR855HSVoCnVUp6Wmda896WTjVvfOQWqGYwLYrDSvRyxh/OnRVayhQK/WrUkxY0kbe3z02mqdSojfY9vC2PpvUePhKtOCbHW+/yasAYodah/99ORJirBa2fn/LtXiJ+XAuw9iNxRh2f1sM2vh1oZMBo7qd8Lq22GfLBY+7MNWrhjusWx2P+Q2HIPqBxdpxT+zwAyaCCQw8GBxtExnbI8dizXorJ+89fJdn2ZHy+qYsEpC2toD73vKZBDrPu3htmk1rJuXgtJbqLStIQ2uP9T/qXOuq0U7Kh5pfK0a6uxF12rhuwwnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQnAyOez86y2p0J/NJSXW6RyWhaVZYnvdXPqMiBVwyo=;
 b=g+HKX9kzj3gHvumoPSxYYNddRC9Hd0SKHS/mnCzolCIyKfn0M+tyX2uYlNBTvjQY8XSDK0L5gsigajjLOV9uh5OkWSwX4F+P7/9+lOQaG1ofARrx2yS7rBaC/v0fzDloYpr7XLZetRl3RBqyXAJ7ZxUushEmcq4/6gQflAEh2KrbPH1XdB9kUUxfuwYFDnYgsBnSzKXggNxNj32RMWMssGvdWivM51BSEY53FUS0ay95lJyt8mqmHkRa1mfuYpRyJs466sJvD59UZ6OZ8lG0J0Rm887y0VHq/sHONAeZByVkMg+Wx+y0oT3cfEgFop7jVq6dF6tV3wdU6Q1V5cDkgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:34:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:34:16 +0000
Date: Mon, 21 Oct 2024 13:34:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH for-rc v3 0/2] RDMA/bnxt_re: Bug fixes for 6.12 kernel
Message-ID: <20241021163414.GC40622@nvidia.com>
References: <1728912975-19346-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728912975-19346-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 88029cb6-4fe8-4129-83e8-08dcf1ee33fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uog2ucbjSUuJUBiHLi1XrEjV/QpzN+/xRk8gmC4CrXLuDeI2aaxKr8eTjxW4?=
 =?us-ascii?Q?qagYnqdOqy9sOZ/pwe+sWaxGhHLoMm40pxMWjodF0QIGQepYbyXxra5lDOK4?=
 =?us-ascii?Q?QF0+lupk5ErurLbk7YytZm28E3xUnnCYWaJBNMbIkHOkDsX0ZSPVP7x0AUnS?=
 =?us-ascii?Q?LfazaTtAwKhsXRPGFyXWdjyqMtzakASsyHWFNzXJV8/Rv4ucs5aE9PkKm6Hx?=
 =?us-ascii?Q?4gpeqL3Q0cHeBYGNU1bFSrkO+zCGjwGwHK23CFweWv5IbFxZfa3VoGiKoH8i?=
 =?us-ascii?Q?hRyxNsaUiQ19616VRn8pBXuYUTKvWtwgEJJuOcpZ1FC3rzi9XqwOoB1IRZfP?=
 =?us-ascii?Q?7ptOP9wBQiS1YJ2b5h1iL2rmAON35uAGpLtO0dQTifLJgziZtbf0OxxB3jfA?=
 =?us-ascii?Q?+GAE31HpuzvAIvf95e7y4YPMUm6PJY7UHXCtc7S+0VKGqxvq4szWIPnCNMrm?=
 =?us-ascii?Q?AxPHl+muSVEA04c0K1t7uOk2p8N/HkwoA7qaTNSsQXFv6O66WXE/pdkwSe1Q?=
 =?us-ascii?Q?Vv4mqRD6LCNZZgAgzg784gE6MAz415ktray8RolEPPEYyZK48gikYSlRPuD0?=
 =?us-ascii?Q?CDNclUhPKOLXRUprE24IbjNrnd3eWVwXAkYGnqwe8VBd15yqfG9jHWE6iYUo?=
 =?us-ascii?Q?l1b+PxbktnrxVlzl5Dg4OWZr/B7e6+EE8JnvI38YrIiLu4yRWW3nhapQcpzr?=
 =?us-ascii?Q?korohiuh+NP3LdbLfDRlQ2ZGK1AZRCvE+SOBiOlQMCRMYlDknJcQ9su+BUmo?=
 =?us-ascii?Q?NfS5Km+OsXifSKLoTYBYcRcxiITjsG0tLanLo2mRzUuiDZOPjtHhs6dASVoX?=
 =?us-ascii?Q?SgYPQyOLTuQ5thk0aTPRLSoZlv9Spak8uL9VEgwD7HywX7SYMyNz2qHG3TFx?=
 =?us-ascii?Q?07T8BZAtmnB8gIaoB76gqMDSZxA418oxEgtnNO/y2+bb8gzOR+UlxEEorVNT?=
 =?us-ascii?Q?oDpAOE65r2mpV8hhKH58SBBOYirNt4wWar0NAwTNb4r/sfb4a1JZav6yfizD?=
 =?us-ascii?Q?azOKGQssdZssNh+Ar/XxJxmCEO4oTZTbymv1UuLyfR6X8lbKDw3TGbWsWOeB?=
 =?us-ascii?Q?A03tHBsuLpwiZID8M4GuC1Ufli4iVpYC6pDy8eClEu4sIBUoCV+xk6/B9ul/?=
 =?us-ascii?Q?DOaBRB1McjPglomBODVbafkHHTEJlAO9U8olMJWboxHNZbNt4OssxBXrssl0?=
 =?us-ascii?Q?iI28aNBcgfBLxpadDFN9bdkTCjYalkbh7GkaEn2pUBCoQXvo4uHWDufPGa8U?=
 =?us-ascii?Q?9/YL4UrCD4twrt6ttvA2Wz37ueK5STR6f4pc845McYv+L0OAMbNOsifWhebr?=
 =?us-ascii?Q?dSjxRJH8/dIxH2k0NkVN+E0Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UIgYvywtdtcpsIeVFJA6AnPz8PyefH2+61THMETXiJAFQbQsL+OA3PVXNm2n?=
 =?us-ascii?Q?b4DNTYDu3i10+iZYbHs066MppfVRHQBZL5A0TV15qOMmVzLBFnC98vR4HRQG?=
 =?us-ascii?Q?yNkQv1HQAXPXlEDba7miTey0qAhFTVxk9WMHwJRoX3j8jDY26ipqxzqnpGIG?=
 =?us-ascii?Q?gu2QCCpauwBhA7kBLpbzILiON6VljM/VxOQIqGFe2dWM6tB/jvJ7dTpSG+1O?=
 =?us-ascii?Q?OAGutCDqcj5myUOvqvMC4QcZu/62Hm6zWeKrHQmvTSfm1dEptCN4hKAW2b18?=
 =?us-ascii?Q?NqIUWUKbp+h9HMA402QlYjLpChpFULd+26uNq1xrR0Q/OL1rPKhgNTzFJc8Q?=
 =?us-ascii?Q?A795LiksXPpQx6Rg8jHyxEcLIvJhh0ybkzgsIClrl8For8JgtWBfIkWzI74T?=
 =?us-ascii?Q?GA56G6mMdzTHbFfPR1Dw6HOe980pWHbV6644uHM5V6aSnu55InnaFZyMnh/d?=
 =?us-ascii?Q?nQr4VjNx1AlWGjBHVtuC8NQjg5ZVWYRIg5eTzds3eTJlCmIpMk4lWpZg49r/?=
 =?us-ascii?Q?8fmxKz9F70xRzGraiZL2S4Qj7CtwUOoBHWwv8pMJSnZBuBFCq6X5O4Ykab0I?=
 =?us-ascii?Q?Pa6udDW9L3YbFuDcTT3jy2ecO4z6rpZAPT5ncz2OrbJkz7Rt0ZUZd3iLZaOD?=
 =?us-ascii?Q?X6Z2FknT087g3mQkT17ZTxKZR6a1d4BhLD6+OEYFQm3uvJ8k60RuWPh7ynb6?=
 =?us-ascii?Q?dqCPC6vKK48ezNqNpVZRHhLeOriM3vRaTAWreEh4uBQ4/0hw/Tcv3xAlspVU?=
 =?us-ascii?Q?At4WEl+2Z+3ZrdTqdz5BILAA9+Zado//UzU56c0jZM03oLHyJwTjPly6SH7f?=
 =?us-ascii?Q?CaSuHTF98u8jt5Dc1XbtMBAh6iFhMo+KkNJ30ZSTgQNKmt4X+xFTO+z26mqQ?=
 =?us-ascii?Q?ku/oE/5+6SQcwcD6gsIKQ6jsWmEgTZUtCmvA545lw4dAz6QzoOw21f7Fb/4f?=
 =?us-ascii?Q?PE9oq2Ct2wJehVxtZHpkyuqSF4cWO/Ivky4agwWJEXDtdZYYiFHNdipYS2gT?=
 =?us-ascii?Q?tUVvW7n6vnKFyn8s+s6EKqcjFs0GQaO2m2JnAyd3TJ1VYITZuWD80h9G9dr+?=
 =?us-ascii?Q?lbq+ZN8ZIR1PXzLBKxU/nqhrVkDh9Z2YYgbKVp9ptJXqUjlbYEGjSir+B3zH?=
 =?us-ascii?Q?3oow5/Q1XYUcapQThXhY2Kuqr5MhDwl6oZZq7C7sQ6lKOnbJfZPQ1Ktpjr8b?=
 =?us-ascii?Q?6OUzfPHA7lpjLrJcU7y1MQhkL6VrBkCIZY/i859SVkN8RFRnTQ2OhTiWCGaf?=
 =?us-ascii?Q?QU7kX+yqnoCDwWEIETqJ0s0lJPt/j42NdXNbm0xR5HFl3Ipgh9Qlx+sk0nZk?=
 =?us-ascii?Q?H2+EQWNVsQFwAM1PYNLIKsD68G6Oairrck1+0FynlAKnfHcFIZp0Ux05Pem5?=
 =?us-ascii?Q?7vC312X9/PD1QKJf9gJE4+7hEbnC9v3ztpdYMtemV+MrRROWpfnc88r1HyLT?=
 =?us-ascii?Q?BC5uv5sM2M6zy39x2cyFPbPKtRRKXfpZNwN+EbA4WOxkXIKtRigsV1EcIIX4?=
 =?us-ascii?Q?8yfGEAUNYLDRbdkE7KcLlxxvdVPpX5OsJI1RuQNU3c0rsl7xXym0ZohZqUSv?=
 =?us-ascii?Q?7t3+y7rqFzMVAb5zt9h8hH97f+1EpAVYpASvBg0q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88029cb6-4fe8-4129-83e8-08dcf1ee33fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:34:15.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDiQK9JXbQ+xvUqSK8wwd0VVQWClBrt44WWecv+3pfJSu7/IEgSjivd4FwuzwHhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

On Mon, Oct 14, 2024 at 06:36:13AM -0700, Selvin Xavier wrote:
> Hi,
>  Posting the v3 series for the 2 patches that was not merged from
>  the series. Please review and apply if it is okay to be merged.
> 
> Thanks,
> Selvin Xavier
> 
> v2 - v3:
> 	- Only the patches that got deferred from the previous posting of
> 	  this series
> 	- Addressing Jason's comment to avoid using the lockdep
> 	  annotation for the new spin_lock, as this is not a nested
> 	  lock.
> 
> v1 - v2:
>         - Add a patch that removes irq variant of spinlock and use
>           spin_lock_bh as the control path processing happens from
>           tasklet context
>         - Address the comments from Zhu Yanjun by initializing the
>           newly added spin lock.
>         - One more fix included in the series
> 
> Selvin Xavier (2):
>   RDMA/bnxt_re: Fix the usage of control path spin locks
>   RDMA/bnxt_re: synchronize the qp-handle table array

Applied to for-rc, thanks

Jason

