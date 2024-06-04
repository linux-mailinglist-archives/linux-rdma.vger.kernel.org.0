Return-Path: <linux-rdma+bounces-2849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841C8FB97D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15DC1B24602
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C41487FF;
	Tue,  4 Jun 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P63+k2qu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAC1E501;
	Tue,  4 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519468; cv=fail; b=jjWEwHkKeobEXrw9krvR12zU/FzjjjgS0P0qAHoskSiE4dp7PZHNZOZ98Alw9R1YYwRE6lxvcG/VjncGyvedjoYbjAiDQ2IUEVTk7RUze/rmJfSHlIAogQs2F/k801MWmUmpYrym5aMESg1DI4Ld2pwpejVHepABkGfgL4d72vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519468; c=relaxed/simple;
	bh=YU0r2hPASRERY0EMn9kUsYrT9+RTJtdA8tWQqEmfP8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=scB243Q+gOQxUf7gKL5ksmrJsyia9PiTzUPuvXljfrO2T+CBwqHlQG7WUL45igV6DSJtJSC7dQwdC4OZSCXq6JGqOotIS8zV2jJmOI7WAc4iSGNPLQspBi/4GrFp3nwQBt0A/OT0zhmIPfakcdUa29R+KmqyzsSjku94m+qs/Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P63+k2qu; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeOoOZgysNI1/g7QuNN7+Uk9FbSd4EV513/60sxtVtbdMf1S6EvAyDYLdLBs8IS2E0EnCHoPA1etVwcIbdgtXTessA+fnX0HfavhGhYzcppClhdIP+qIGy+lI6vMVswq0kfI512pydE5WeAAIcq+P/pgdHTumModZeX+Vr+en+C+sOcIH8vR6Aju79YppBM+zuRs0eqgL9ATxCAXTFyQgfGbIB2FtlXxrtNTCs7PvirC2Zk7uazPap+TlywAPvu/tsQGtl869vLMf3l/IL+94nEV3R0mwwsL9/qKDsnN3c1wuBe7qNPNLGlQsu+aEMEjjM86w3kEym5IDvZgPW3hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q73cnQ53cgBlqIgKBYX9u3DTazkf8YWGLBWS3+KhxFc=;
 b=EeBo2X6zBwGu/WCQyFTRUCs52AzwFu2X0/LZTSP8EwRVbOBvQXRVAM9Gj6XcoIowmLZSQGldyfG9GdCsuPVt7PRnfG6xq+jsSTZMLegFUMPAdymY7WLw1eypML893UL54BTsepANj6mCSMrhr13nk5DOK52IfNQeYs8bTq79g40ddULhvIXy1VVqeLyS6+wnH1n5tqhrnzbnS6d4EDp4Gq5TtF3HW1VDwLlYpgTGU61kLLg5OvCYk/YRfhGq6IE9NRK+h19cTt780lK5XHCs2JV0MWv+7a8bOmWcMhNPAZDwn16NB+Jp2QQzNNRxqo9L7YrlTq9ysZyOioKRdzhFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q73cnQ53cgBlqIgKBYX9u3DTazkf8YWGLBWS3+KhxFc=;
 b=P63+k2qu+MxTks1KoP60qYX7FnBSsH5QYYzDACLYjHxhS9OXT8MqSTzuTeSPlT1C0R54AWbV/JAlwSqrGSMdct+AmzdOBHc8BbFo41Eo+ZajpnKT0e4QxRbhL4ckNgpUaZ4LkYvuMEO0uwdOtvxd13s/H0aX9KCPi8JFC5UTZ77CRO6HpORNn2KudDMQjz70dgoukNDKnhtWUc5Mqz/h5sHHeZx4i032sdHnOIgTYiFYdrzgtrKsJmGx0yCVsVaglmLbg5DS+ZN21JT7tf985K4zA+bCSVWblHPm76BbGqeOcC8tDf11tlAoXBVg+inf2Yo+BGqNj7LdnUAmBWIX1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 16:44:23 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:44:22 +0000
Date: Tue, 4 Jun 2024 13:44:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240604164420.GL19897@nvidia.com>
References: <1-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <68ae1ebb-90d7-4b4b-84a2-578b7217d5c5@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ae1ebb-90d7-4b4b-84a2-578b7217d5c5@infradead.org>
X-ClientProxiedBy: BLAPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:208:329::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: eef6b361-b429-4463-ab7f-08dc84b59670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDo0SO+pnoe9eTOKYcPs6nBr/fPAVybqIRv1TE8BiCHRSBn1wEilh14lO6pU?=
 =?us-ascii?Q?TZ4hgSzUxA5jd4y0yvUL2FyyjOHUxqdrFJfCUNPiPzUBkBUda9o8qtGGue6f?=
 =?us-ascii?Q?pUixQihk118qeKixZTKEnHLkIPqxGsGuDTc/FTVpme1QX8JhXv5AqzR3VSW9?=
 =?us-ascii?Q?AndEG9DX5649CiVqTB4/zuvXcCNET5U6gGj7Sri1mUGgeKM1FqBG77ivsEZV?=
 =?us-ascii?Q?O5BybBnkfl7w8+trxX0/nKtJXaZBnC9pOZdEb7Z3g/7zelSgTuXnxUQnn5cH?=
 =?us-ascii?Q?6c9IlipPTHdHHBG7X3YSGYhuzeUV85TOqmDaqXAY771dbyM1OQgujVneUjOS?=
 =?us-ascii?Q?MJCZeCgZLtEJEItFPCpnRXgwqUn9sgdtU2Z+PQSGBlc6JAH2ArngyRvR/E1q?=
 =?us-ascii?Q?Q9Cy/uOlpWgeaql8iJwF7thWUHvG+b/4qiO6FejDca3xiBt9Ci5kvwJof/9f?=
 =?us-ascii?Q?0G0N+0I0CLutD7TRZ/YLFDkehafajYehjgpe66KUyHKSgSlj/yhZyv8UErWf?=
 =?us-ascii?Q?W5/L2xWDEXPCVj80MC/l/qgUaqd1YVEv1qOazwTniJ//+5JUVdvzgG3uL117?=
 =?us-ascii?Q?qJV2mfI3+fMqCqJoflIEJeowW8T5JJH0yEq1VtG/Lw49/pJKFvzNXKt5xyji?=
 =?us-ascii?Q?eCM9PlS6fb3p2043R0Gp81+Sj9WNI7K7T7jz9BWTA3hBUNe7g/QcO8dvdFqg?=
 =?us-ascii?Q?LD97snGjc2GrSqkJ1k+QLQJu/EVowF5H4Mb4VzHYKoE2rSyXC5YxFfz5W8iZ?=
 =?us-ascii?Q?p384m/JDQdT+6iFccKgHssUoxbbGp+PL5YZloP8WxRSbplKIt1AFQweeWtf2?=
 =?us-ascii?Q?fQsMf3H9drI7kpyUcCM8Mg1mSTk21+DSBtjjA3lQ8byT2ENLUU+mhXMvzyGc?=
 =?us-ascii?Q?12vsv9kEgtuyvHD+8anoy5lVuXhwnkz0pRnQZTWH4BU2mVREBWuYuzOt474u?=
 =?us-ascii?Q?AoMIft1X67rzM5aY4eHNtkyuIthcSoabXIWk1SEgbRRTL/WBIOt/6K3EV0Go?=
 =?us-ascii?Q?1P8fNU+fH0KjFY2ZlblgcXg8vJximwcUiP2dHT5ZqWdNGVJW+LwcJkoohtAi?=
 =?us-ascii?Q?V2QtpjZQUvBlHO81YdFgxnpnsOJZJJOjWkretVN+KLlB+zP5qbyeMVIuZoJ/?=
 =?us-ascii?Q?PL5Z7hdajBLp2laqMxpiz61E6hUfdaPPq2YDldoNaPI/o0yx7rOp1mL8o5N4?=
 =?us-ascii?Q?SwyCG9AgHQquCIkKUC06QyOmBCShuj8XIOzmazn/xc/tnZrmXPNdeeIqxv+i?=
 =?us-ascii?Q?Vwmz7YtDCV/NpYBzZ5L9SGCEdBRYdspU8tpQHnmTBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sa93GoABwAytPRWnCB7pCw9OLqqT0eZ6yHhVQhRTYNgKsq3w7jhvLSpUldWH?=
 =?us-ascii?Q?D0b+JcsYGpVw+lxRtJMkqxFUv2JSyCYeiZqkIrQKMxZ7Xq79e2L208LQnUnA?=
 =?us-ascii?Q?ceSRa5cxNy2ESZtquC7wo1eIy5ccx5LB5U4OgZ6M7kZOj4vWxhRJj9+0/3WW?=
 =?us-ascii?Q?mD9sZIvLQPt+ycQSqUGgsLA8NTtNYLpb6jQ/l3p5+ydnTzTG3oAE0YrjjWm6?=
 =?us-ascii?Q?lbFtJGnZVWkjbDC5sQPn5Y7zHhHzZURuLNrHHy9tJgJIZZDl0USLI2g8mHqb?=
 =?us-ascii?Q?rTxeDPNlFREjJRgn/QQ/zu53eQWcrhxKqbpsVUrum+WG+g0J6ZtKuOoaQHsD?=
 =?us-ascii?Q?+UzfYFDIzahnmSESSicLBdYrglZsccYGRFM+ese4Y7uld32cPclqe98WgizL?=
 =?us-ascii?Q?MEfNYDQUSap1c1tDgr91uqDHcPgOoOp6RVfrV1ezXFMVuxW4D8Tzzl5MW9M4?=
 =?us-ascii?Q?Yq4BzAaoso9hqC4ievnKoa6sBAPr2Lw2Vpwiu4mRd5QP2BJMHZDgwVqdIVhY?=
 =?us-ascii?Q?BRsrBBqFCPaj30p7T482ojOZGjfKUFykZPPY1FdKNg+Qqg/ziF+9kDziPBZR?=
 =?us-ascii?Q?3ZD99tgDen8N8n/uqjpKMjtMd/GwV2kenGe9bzZXRm07fXbsKFBBxhIyNUxr?=
 =?us-ascii?Q?OmSVtfBmHWItHGhd7El9DbxEsCvhMb/QYRchUBAo/nj2esmeRTwGGXiZg6NX?=
 =?us-ascii?Q?tU/WWmAgUPzfK7T4p+RCYW+pW4D9fLUTj4CqBiOjZ60ZgzrTBZkRsRraamD2?=
 =?us-ascii?Q?4flv0DAyvRMbBVNDM+Yr9Y3kwO7okvPADpurSuUpZSBziA+g8NLj6oZYjw5C?=
 =?us-ascii?Q?gx1k9VKTQTWzXYS2pUJmIcTZXwrhLTobuKYYmkVFpFjvGK21BupreYGXfA8r?=
 =?us-ascii?Q?wNOSciC5tZwChteGOzwi+a5NuXJzyBcqARVsge9W10deqjmpnRk7RMHUe8ct?=
 =?us-ascii?Q?vP4Q8q9vW0LaAYh+AbE+gLqHI75WxE4ewFSxaxxanl2cgNw84bJXLp76uZyT?=
 =?us-ascii?Q?QalT4JVeUH8Tb9IUa2fNhHobnQn4bHDEHPFPygvAZdEs9TaQ4Lb3nGmgTafx?=
 =?us-ascii?Q?lckNHrUBMz8ug87BaZkqu4NmHwK6MaQ8VdczDx39x8R/SHPZOiuQJmLQR3Vl?=
 =?us-ascii?Q?BHm16xSbeLX52RO/0VdzHK26TKHjov3aYC1X3ejbo0tbPMEXbR38eeohM5TH?=
 =?us-ascii?Q?8vFC9c3HrjAHl7co553lfv8sj1yzYMeFcRPLuAgwnd3JTXOCY3NobT6q8wkU?=
 =?us-ascii?Q?zVNrL6sySkkaA3iyXcl8sNQ0BEsKTLBvvhQQgXERTz/pcfx4eqA+vgPu+GS0?=
 =?us-ascii?Q?HOCVWEvrwi0YwnQMQdbvqRIuuhYnvozcGBVI4IWe7RgqBS/ZpQ+cxz5oZcOW?=
 =?us-ascii?Q?ET67bOy/h5oSqjj3MUEPq4Iaib/d3bUfeQyD9rRDBeJMvmI6wAgtjovUc7Hj?=
 =?us-ascii?Q?5Y4UkFOxBBGuAqmXR1FFt/yycINjY/ZDdLerX0KQe6LdVadzTP5PzHzJ1SFU?=
 =?us-ascii?Q?sVMpt4OqkmhmlBnHpnrfLoFoQTlzKgxo+oBhnVm2xYzjcwWiclmct5uDp3Z+?=
 =?us-ascii?Q?vvNgc9qO8/i1qOJ11x4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef6b361-b429-4463-ab7f-08dc84b59670
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:44:22.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lWaNZoPoRymGFuNt4EYwOvU2k65FVwE8hs991CcCIwuyWBhQr/wuQ5bmbrPXx0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

On Tue, Jun 04, 2024 at 09:42:50AM -0700, Randy Dunlap wrote:
> 
> 
> On 6/3/24 8:53 AM, Jason Gunthorpe wrote:
> > diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> > new file mode 100644
> > index 00000000000000..6ceee3347ae642
> > --- /dev/null
> > +++ b/drivers/fwctl/Kconfig
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menuconfig FWCTL
> > +        tristate "fwctl device firmware access framework"
> 
> Use tab above instead of spaces for indentation, please.

Thanks, done. Bit surprised checkpatch didn't flag it..

Jason

