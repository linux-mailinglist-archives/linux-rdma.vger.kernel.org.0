Return-Path: <linux-rdma+bounces-3531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC6918DA3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 19:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6A2828A8
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6819048D;
	Wed, 26 Jun 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qv+y+Wll"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6A190079
	for <linux-rdma@vger.kernel.org>; Wed, 26 Jun 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424560; cv=fail; b=qqYRLyAA3eBtjMZQvAlSlllvf8CJu4Qpdyr5tVK8cIPgHN96CTaYT9ZCiJcs0jg+hIC10sgfagDJmLtfldV3+ilMrU4BZV2rQuQ1m/KOeYWtMrm/Ie8/MC7FNHhSwI3L1gqIETdb9VPXaEnkyZ/jI9xb0Tmb61a77yraL0GLBQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424560; c=relaxed/simple;
	bh=gKJX1z6YBSvfJtgdOTSVFqR6s8calbd7Z4CJ7y7tveQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yd6jeO5kzGkcLlyz2rMyBgLld9thF5lJbmfqySCGmO88QJLrpFHmec35jYIBMBJdK7uLADDccn87bqOwDtmgpM0PxLNYixiyDDspFYpE4sdCvWnwH2qCRy1aTzZwXUqOJU39VOAYCt/KdvItz57sluKHLJuFGjHgoB2yMNchecM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qv+y+Wll; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL9WcH52qOj/KoG2acoy6JP8xJdIFT42jJv9W/JSMlzb1I7ZPxN/ewbkttAiHuMCcIEp97rnK6JqI5H0zRkiBDG2QV9Ky6EDBtc0/SXDwT6XCEJdtnEviXSQN1EYjLVpWWt8Lk8fyP/siRmoApGHvAeMR1KckNwzmkCtdJ1V9QQq5227+TkrHjK3Wwa7AthZLs16CcvuZ8zCYvPfk3DS8eNNlI9nRnULyBJhHtnJF+hiSuLmaxtko79ttKbLzNIUHDmejUAbWrzDoCCqZbKpFi/YA83pjRZnuYHDJ9J9g/EDX1t9w93RuDufiwyYPF9D22guxgeyHMaQsMO6AsLrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAwo/obvFU08A1LhWidnj0/TQ71re1aM6bGyfFwj5jk=;
 b=ll6uQQU0Fxn4iH1nOpqnBrs2K6Ss45TyVKDa0OtgMpYpqkS9Wb/tvt5ehnDkfy+HFX8LGsgoUrrJjymYcPe9jC1HiMzMQyfG9gHdU+3rB43r/WE1P5VVjKHfxJH66zL4vJ3kPwvZ4hycJ7Nr5OlglirNMhE/p1VUFcDo4ZohK5vhsPcdrJtJklv//udgHK4mcEWsnPSyi5+AljrbMZw3mRt3TaOhdTaM9RJNYByP3js3Zfq/12kw7Y0N3vLZALdyB3qD8kWQgyGx0wFQsYexFxXnc2P22f9tkH0LRTsz+jex8MICMkWVv5kVIy6XSWjHH3r3paVhi5WOEKLUWZOEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAwo/obvFU08A1LhWidnj0/TQ71re1aM6bGyfFwj5jk=;
 b=Qv+y+WlllNsRe6aobTA0ewKYIwhmy3ybMYsahU+yjzK73Jbisu/htGFLw1WxxSDuK0bVAtXIwZuO++ZQoztY21TVhxwHBGFaGBlyaPLLI7LbDp09freTHuSEMFYqyb2S+wz+tIcwHNcNzyOrNmHTPa6Doi1Qdz9Eoam+2bc8/c2/TDp0hoetOEE0iGC+C7vueMTj8G2xIw+drJwb0YqMZJAYlSuBbmruqeyfByAjgdYO06GL7cnfwWUgRpjWhSvGkRiPWfpmr1kREWyzYHewcQmThmicSRhm/Ue1x6m3CnOc9E++QHncVbdh9g1RoZc7jo42YwUGxwfCIDvFXcwQ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 17:55:55 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 17:55:55 +0000
Date: Wed, 26 Jun 2024 14:55:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-next 0/5] RDMA/efa: Cleanups and minor improvements
Message-ID: <20240626175554.GA3308900@nvidia.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624160918.27060-1-mrgolin@amazon.com>
X-ClientProxiedBy: BL1PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:256::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f07294-a5cc-471e-2bbb-08dc96093a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7JBmxNob3HZo97MsGT5waSCzlntMLFMcw4G3JyPrB+l/6gW4q5FzohmiW9l?=
 =?us-ascii?Q?ddufPAUpCPZJUM9JZPprYyBAMBmyFQe6tBj8SppsEuOszsZHAZyJYXhRQYlb?=
 =?us-ascii?Q?lLNZdUIi7ZsHSICbwE5wFgMVVgMW+Kq5aX8ZGpzcLdXC5juX9oyBSKGMq2fM?=
 =?us-ascii?Q?9aW1k8kxlUZOgzfUNEWQAaMfqiBIZ1G8msYHJy2GTANdQnHHTgIjbSNONq+0?=
 =?us-ascii?Q?CE9GfrhDQFpLHQAUO4QeWhhP4XJyTLLt1jsbZK0CgUKtK1f9lbpj4moF4P0q?=
 =?us-ascii?Q?zK7F/AlUFAeLXNdR7C7RreHMBLXnLufQNUgR0gglvM7xE4H/KNGA15PV4JmE?=
 =?us-ascii?Q?HE+qMClCw160a19+4ofwfQ+cK0RM8oY+++X49GBOqafgMufgP44yUK3oJJyS?=
 =?us-ascii?Q?r+w1gbucATnby4m9NyiiXItX+ulB7T5Q6M6Pym2QLg8z+40VjA6Cnb9FeYNt?=
 =?us-ascii?Q?9jYSoVAGRcKUVvb3DAugDNDLHUQmm+wUSXAVWioyhDjz39BjYRq4e8otFZe+?=
 =?us-ascii?Q?OEv5rWn5NpmYNfIisFvP0WaLCDFAePvgd/GG2I0/JDMC3UbQND8dAAxIbDzO?=
 =?us-ascii?Q?95w5PFpZDuN59Br1rAV/0YfA3SqI/yFbu+38T1/dsiuDZUVKA0yx1SNwywce?=
 =?us-ascii?Q?rn410QyGOmZp7I6D5PogpGDSHrBwXC0yeCi1fQ61dphajG7a/lz6Csbo7bxf?=
 =?us-ascii?Q?RzX0FuslN1NCLd6yeVADWER1aM9aVihYhhA+3LzoNFH9vKc+csIo6kfYJ8K/?=
 =?us-ascii?Q?b77e4+9ITKaaSWGDosoRFywIfyVOysORCWddEqNddqZXov3f7bBPbZnnBxB2?=
 =?us-ascii?Q?GXrhe3EBvWfKpJpWLQymHnqlkuWkBJA4AXWUKStMJuCh/TnnlIza4Csbd1jz?=
 =?us-ascii?Q?hl3ckgYI7H9XIueAS+pUI2YbZqOmWUyoPYvV/AbSH1w+b+gTJ/H5ol9u13zO?=
 =?us-ascii?Q?R6sZT7Xo5ujecWZqfIp0df8enI+QTn7nXPKoHn29SPhMLNOg2HjXdPRr0MGw?=
 =?us-ascii?Q?QvG+uO3r+sk+ygDwiZ01DBUL1T5oVdt6jXEJL7O9rOTwW4svKPC71FllZG20?=
 =?us-ascii?Q?EUc6oVBfEHXhXf3fEVOdbwZob9zwGlb8m1VR7V/ATQ0fvNv/ift196EWrRho?=
 =?us-ascii?Q?QTp6fD7O0BL7KkU7N/SG7m+I4kchJX93CwOK7QNcQJ/ByLKXLOHwP/pOi9ub?=
 =?us-ascii?Q?TP/2j8qGI4bJTt/+aI/SYiiyi8u17UfP1bRpTce9U3eODJewXkrP41V3yfrU?=
 =?us-ascii?Q?rSgqSYnLn7ETvTn5jr8U3MXWKCyoChph61tJCKRPPXIzzndu9SebmqXaXDbr?=
 =?us-ascii?Q?SVFcTL0QAcsutwKQMzoU3NSg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qtrDixmUjbDs7PVDcUia1RTkwq5wgFTypP+B6EIQQyVen4NVXmmYY+x97kvu?=
 =?us-ascii?Q?8IEJfQojTcvqyIabG5UxZZCbJO3l3ljVQYQsrF2tvbFR5oROEFTGqBxWSHSn?=
 =?us-ascii?Q?g38UKqWbWTeVWD1ekvg8/UvCEjjZiO390m8eyPz4WM/wazAdbC2orCkMB4gi?=
 =?us-ascii?Q?f31xo4f6DCw4oorihyFTBKtjyRnrCzFNZ9JAkNaBtsePGyJo0vDMV/I8iNCw?=
 =?us-ascii?Q?DTu+h0lLQBhQyICwfAs8ELlPiX8k1n0hUsBTDEqgxBCkq3IubBio1ZVakSg8?=
 =?us-ascii?Q?knUl/qTuazuSZ1MtpTHT/XFPb3gdlOhuGc/hFsEG94cvHwd1cWrORuYiR4r2?=
 =?us-ascii?Q?RwGxXD6NNo4BsnbvDP4ZbycshRMNLm1gZ9VSt/5krBiIhGh4FRJGhRrn0WeM?=
 =?us-ascii?Q?PFxWPf+1lhev3x2nb1ocl3XI1MP0i9hEq43gtRmmxEP1fdRk+5RlmvtzPDpA?=
 =?us-ascii?Q?MFfiDEPOnf59Gt8qo+J1XT84XqZu6T/qGaYBhEHDsCBxL1hQLmzGiieprhjG?=
 =?us-ascii?Q?cCvnLz4+Mqo0MyXGh4A2sejrzTWuoRvwBH5KUO8Z1HqKWg8surg3LBzsHWmz?=
 =?us-ascii?Q?JTpLrIMm/9jouigmd1I2y8cXvKxmvarcFv46Ekxklcz4eq6s8521wiam8Scu?=
 =?us-ascii?Q?EAr8lfpZXRJHeEjCnjVhPNGHfmVQlT1JCBFIZPrsn+vhZW2F3BfG2fYlLAAp?=
 =?us-ascii?Q?cYpp/EOha/nU8fuPMeebHLp2AkMHs6kKy+2rsIifGLvLANpRXFvJEJRFMZgJ?=
 =?us-ascii?Q?/3CnIUKsV9+xhlCKUPtPnBtAGj+Cw1pSADBrqwRbGRXIl+6GAPOPI2AiyBCM?=
 =?us-ascii?Q?KqVcSF6jn70AxgnNHApKVkJgs0m9pGTd689hjZjCsJcpW+CnF1lnYKyITXez?=
 =?us-ascii?Q?8ZLGni8EoP3W0bJWiAuRp9kZ/X6nwS8iEGlz/mRhMjggq6512Cm00AzOBhxd?=
 =?us-ascii?Q?vqQGupYCvh0H711aDYA2dM/aSAdXWrgqoZqB4NwLOKq86kiwPv0tsef4KXfz?=
 =?us-ascii?Q?VfRzneTCI4ZvcR+OTjDDlGlTsv3Z2lXvrhWtMNeXLhYL8aGfWsHHE3ZoZ+dl?=
 =?us-ascii?Q?sonUladY676bZT341r1/4QDuEzo4RP2LwTJIITSX09TyTrj1EJ5e1UTUh1U9?=
 =?us-ascii?Q?1Zd81Px1lDNceBxE6e2ymk36XzaDQx2hXcsTP8LXJQeLvgaU+6Cx+l7Wqt3S?=
 =?us-ascii?Q?m+J1ytDyogQ4/KP48eqJ/W0I/tOXZsr86B9rhb/1mLpQGwm97triA7JLAcm/?=
 =?us-ascii?Q?80/MY1UlN99IewBpd+oejaD6IKvhl7benoNcFoCctuo3ruQszJkuzOChHA+K?=
 =?us-ascii?Q?qpKoQxmxfS5MHLD4jIGBkDAaJIMv9hbBEmkU8JqTIkRrDfU15vYv8ofbld2l?=
 =?us-ascii?Q?wNW6cLvebgGuXy86cIjmZ3u9hWcHHpCDG2dMsuDyAEKSviFqGqasrrX+b1Sp?=
 =?us-ascii?Q?wEqLZmzZ1H89FjMDFBoigemVTydnTwg+UNtT5NFW2fzYsJ7xsmfeC7FbpIVp?=
 =?us-ascii?Q?bKAao6GG9aMY0HqXjfIzEbZoBz5Zs4vYDqh6yGM9qkU5UnVfU5ynlmMlnC49?=
 =?us-ascii?Q?lHtUt9C0QEBdtuuq7284/lqI0Mz8fkSGceaIrhBo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f07294-a5cc-471e-2bbb-08dc96093a14
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 17:55:55.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEyMNehiU5LUVKYYCAEGDN0DN/Ttwy4algHe35vFoMO1DS5KM5YstWu+lbUuQh6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673

On Mon, Jun 24, 2024 at 04:09:13PM +0000, Michael Margolin wrote:

>   RDMA/efa: Use offset_in_page() function
>   RDMA/efa: Remove duplicate aenq enable macro

I took these two into for-next. It seems the others have comments.

Thanks,
Jason 

