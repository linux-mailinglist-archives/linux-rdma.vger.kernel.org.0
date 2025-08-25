Return-Path: <linux-rdma+bounces-12904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA9B34482
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCC5162A1D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6872FAC0D;
	Mon, 25 Aug 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7+MDOFj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF41E89C
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133109; cv=fail; b=sRzozEZgrwcSH8XyoVc6QER51h+C3UNVIupxSSbE+6D9ngGbaquMp6ZH3zdpJWekBmkcF3el3iw9vfnzyK4SeMaXSv6YJwuXt4UcDvaGtWdBjtTXzBwdnZh1tnOKElsDYhQEtMa4C502tqb6pXGL19gfumwIbn8MBpZfuvctC80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133109; c=relaxed/simple;
	bh=jBG/vyPvoeqhcKo7uRpPM9bBBgA37LUWWLFMxvvGm90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n+PJo2zODEpEPJXUQkLX/QSiqSfzjCjD8UVih2+0mmyuXl6pJ7xSxJLkR2UqQWnGkDT8MoXMJWB8obcsgQB1wNoA9KI824NYk3nBqk0K9MIWmy87bQfIS6TX6OR83/vYirDzWMUQKRzTDqDgTzW/wuWCLL39YPNnO4ltCg7PZ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7+MDOFj; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ6xJr1combdVVR5ldjNWTdyOdEcIDIa/VgAHGEy0doiz5gC4rtOM/ykFG6DCQehO/eePYBEjM/HYK+RAOppEFYchYd42J/3LcKHAIaqb3beqhdyqLGFoOyr20HTJg2HE4uV+XhKlb1aS6Alfolv8+uDo/ArpzblpiRFOFzHwP1QEaCkpu4pG7mQUlt2Gt49rX8uNmO463Uq9sprylk8yFjVZYBvZi5w+cn2lPVsCYv8vDo/Hze6cEC/xGKtd9v1w62ypNImtjvDqHEPpDTg51IkgRWdY3Yjev8VpI9FokSlts83kUuM881iY6F2pUEXCrtx1nsq9WND7c8XUqrTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3+Z3/y17OqfWJTztayGQRDa0lgF1BkyoCS/NDq2V48=;
 b=yXgSqFepdlcpfFVH6ieAvHG/WdnvxDQBLB8YHw6O3yIVIqzj9GpA2jR8AgrGlJaIL/HQLBESaDzNh2o4aLRciCGjVbDGXB+X/j55SVL0+Zl3IR/NkjK+eq2RP1KOqnbR+EVKwcGUuugcv+HDUcI2J1lthXKBOq9ARxa3f1aRtmfgGmUuHgEuPaokqZl6j+nOROuoW1YBJf/JQMsauhk6HkIyrhpRaM0WCU5wzz8gqGZEIA/6lISJArpMR12Jsu+DfkRYz2jZh/LOP4fFeg3FauPAcyrJpCm18K60Iu0KnB+QTqlNKqf7InBxXQXui9NQITIPu5ya3OgdKvW3MZ6qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3+Z3/y17OqfWJTztayGQRDa0lgF1BkyoCS/NDq2V48=;
 b=h7+MDOFjTcmIu7eMhR4lQxQ6auIXv/eWiVR7UTREmnw4gXDnW9alLJFZpjTp9zZJgraODjGR5aVV/yWCeOjGJvqFxu/P4cuNyQuiJJ2OpnKFLYKEAZzaRyqFfr0N0B7QBNFGX6fQilO2u7GLjH167mOL8hyakVwQ01gQJAJtk/vWNJJ1SA/7Bz/p5eVQJrpRlHYKVO+W73+2iwVHZ6rgl0aoShPS06gEz23uhaD6W8VZ+lbkTbZ6/dYYMO4HMwYdH7a+/r1CpxlGW9BUXqbdNEpl0P0fbS7Hgy/d+lMhXrHhZbUtWPFQ+Mlb3mevZhpCB/oLcBncEatC41T8voaC4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:45:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:45:05 +0000
Date: Mon, 25 Aug 2025 11:45:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	Douglas Miller <doug.miller@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 19/23] RDMA/hfi2: Add in support for verbs
Message-ID: <20250825144504.GC2070157@nvidia.com>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129748380.1859400.2079032224081921772.stgit@awdrv-04.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175129748380.1859400.2079032224081921772.stgit@awdrv-04.cornelisnetworks.com>
X-ClientProxiedBy: YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5f3146-bb36-4625-5218-08dde3e5fadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YlysTPWwMw/bfXATqs30OHdkFDhc693cxGHSZceQs94klK/d5ARnxrKSw8j8?=
 =?us-ascii?Q?Bk82R0YNM8oFnKR2lhqJ/+W7fQVdmQFCd5VXeflhBlo/ZywwtfC1iq+w8M2b?=
 =?us-ascii?Q?s70Iiz8l0NV0zbetxAwqLwAQ7HZa+k84f/eJBA9nCRiiKMGHhE096zj00oRb?=
 =?us-ascii?Q?g1ZgYKD22nrPY0oyedNNnTAmscP09nYwBCpZjh2teRyChZGjwRfs62K1ytZg?=
 =?us-ascii?Q?/5DALmUr5QvsmyyZU7XQ01aRhohcbFDtC/bjSyHLMHrE+yLJ3vV2cMKZCY59?=
 =?us-ascii?Q?RmweoeP9/Rmp878123JHO7TJD1G9CHz8HKcQSYYNVPYCCfZf1PcZ74m65rTU?=
 =?us-ascii?Q?29X8tv6JVAar1PSTqtcIEoTjVm0DRqXVJF7iciOJQWl9Pa3gkifjve0gLY2H?=
 =?us-ascii?Q?oox0tKCtDJgLZfkOjOryQ7GcFGR++1xHqel7hbujLg5tnWMpKo0spMLbU4gO?=
 =?us-ascii?Q?kbJmEp8QUgDodY+cgvzPOV+vY7Cbk1IQy7Uar9h2c102cENmNR3gSZZ3brga?=
 =?us-ascii?Q?RZ6YtlTezxWrh70ehAruurWtVDXcm6YcpqbreVsRFYB5ZW5t3Aju4dDK+fNW?=
 =?us-ascii?Q?s3zFH2Mg7on5Xo+u0OOE3p8qnViboVwMwTwq+VERAqrzBBIQZf47AbbGF2Ej?=
 =?us-ascii?Q?fRhQOIbnlrBf34KPQuFvJtuy9nE37Zc8mJGcGlB8IIiiWoobz+DHMMFd7eCS?=
 =?us-ascii?Q?CAfG/DdEsrgYsSVnO+Rpu7T/g8fhH9333OaLZQSwzMJUQ3glwOuniT4rmKHU?=
 =?us-ascii?Q?fhhJ/B0hN51OlWlpQ0I0A05i0oQRH/72t4+aVtpueFySNiXO1NBLCuCPB0OT?=
 =?us-ascii?Q?3NtDKP8QQdmTbPClFCd+lx3VvjY0spWxrYPGNlPK38U3jGk1Hx+JJD5YaSPy?=
 =?us-ascii?Q?EK93+9HO4wst76osuI1TW3vytcmXtPHb9tgY3AyR78oee8X9mdD/hKUQL2/f?=
 =?us-ascii?Q?7lI0wUWa6HMNb8dLOPDu4isLZNRkGlQ0/D2JQrdKdUH6jKr6pQXIekK9anu3?=
 =?us-ascii?Q?I5EAyN9akZ6z5x0CF3GY/wIuJY2aMI693cvBYDLdHuXmgjPiN2QJuSRw/WHn?=
 =?us-ascii?Q?OnrbGd55M7h/WLhgDE41lEnDxUkepprpQ2iETrJL5BQ0je0ouwSiUpuI9NJ/?=
 =?us-ascii?Q?lVKLNEQbOFW6a/BZdCIEtdFmTgeG2K7sk6+6iwCFBJraFJpjf1u1iG3eqhfI?=
 =?us-ascii?Q?f/k/wNMFkKmAyPO1gVXqKG7uYkNQK1/BhiaezysPmDiGTmqFEnJpezXXe0wr?=
 =?us-ascii?Q?ESkoe1LtiNrzN/0E4Aeq6VmpIPFiqKAdgClhBfn0V5yM4oQRWSlnVd+EnSlD?=
 =?us-ascii?Q?mkWO14R3fyrLTgPyeDc7PwHfUtPHgNv9YAIDhoiw6O2Iy+8LsFgSREgCtfvs?=
 =?us-ascii?Q?WVDsDkCMFRxPQKVSL5U/H8N0biZciYE0E4vfwqtrdFaY/5ZhN+xf/63sgi0q?=
 =?us-ascii?Q?0mn/g8PBytA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vb7J+KjE4l5d1zQr6F7LUTzvHqOYjbOTYPAmh/rutpMakfh7A1rOHcciu4pl?=
 =?us-ascii?Q?+faQUDboYU+q/qAxflOxzY4OOW9jgJv9PYMw8HabXKu8wnQq2XntOu3iDIOK?=
 =?us-ascii?Q?kXMgOL41jB6L/idG2p0F1bIGsdPMVSKiFn6l9gqzvqI03/10hwhbbZvMwEbW?=
 =?us-ascii?Q?rffE5kKQkVQZt7aE4o6fQGaZ9zPjzG40HO5ogYo+EWvvE8dcRWpq+TuoFVZP?=
 =?us-ascii?Q?TunJXnw97EcffMS4Y7L1ztOg2+jwIYrxcLTuozpM0veTeH5bVAFWTBfIgBOi?=
 =?us-ascii?Q?GGp0CA2JfBtUPsoDS3mjkwWlFRJBBd6prHGa6tKC9hjve37n/B2glpgDrK1u?=
 =?us-ascii?Q?TXjyOay1ZEQJJIMk/8fdsWt6H4ge+9IxZ5RsqNpD0man9hjXj1ZlAcR0Bc4m?=
 =?us-ascii?Q?DQs4Z+6FKY6d9MTGMNbVlyYQGzkpBhelbb07ZVklNZjSTvDv/Gk/hVLGbHc6?=
 =?us-ascii?Q?cADTgGiYTgVkw8nSQL1DDU3bxr0LJtD5IzPty0utTP+J3k5VP6HsOYcrxIeS?=
 =?us-ascii?Q?ULiJnPXu9Vb3DHQiJB2ZZeVbaOxxQTwnQQdx2GDLIQE40lXA8mghe73aDk/R?=
 =?us-ascii?Q?l1XyB+rIbZzMaN46UYLu4crtVnCOte5zyDrMJVqiOhmiuH3Dd9vIEvIbDb46?=
 =?us-ascii?Q?peQBGU1WqD2iJlpK/tc5+JleQQOCNlU/L9YAh1nYCDhsoa0K5Cr6cbwFpWZ0?=
 =?us-ascii?Q?FlYVqedIhP5cty6V27+sHva60zy4zBi6wNgjNsuUS/+uW6zSU0pIDyo5k08r?=
 =?us-ascii?Q?ETGnHiECoz9fwt0sN22AWihRWm5wx6VU9SKUjcVyQ7RXd1x5A3mjStbr6s6p?=
 =?us-ascii?Q?+EELGY+q8rFZZ4rMVGVOgfy8K8AsYcx0tTfhe8KJYnc4u6q8njRWHE77Zdep?=
 =?us-ascii?Q?D0EeQSDGAk13Y9lHaLmk48HOOYBironLoBWU8GE/OzqCgYW55kY4bn+rxpne?=
 =?us-ascii?Q?OLB1psLj7XmcUTts7xEiF6qeLdvjrkAfpX/2N+E7DNVLhvvPQu285p66hVm4?=
 =?us-ascii?Q?+v8xAyyF6GU73jCaLusmktHVPTQfG+0YA7V1uMR/q2oDn+1qn9kjvE6yZRYp?=
 =?us-ascii?Q?sI/oXAzk6ETuzBVP/xRc67lB442bXiIbbGRt8xMawRGBd+6Lt4GUOmV1vWjL?=
 =?us-ascii?Q?J1Kgx/HbHa1XIkZUyXOSEmhAaf1wXpqOPTdruqo2sy46OLfe3SPHcNc76Yd7?=
 =?us-ascii?Q?n8gmRS8yj04Zt+Pem9yfUzQQ+ZXItKT5C0tAZvcBN7eUlq9fISoMpcgUVJl+?=
 =?us-ascii?Q?MykHo1BnLJyOAAUKc7/iYs5gYanhmoj6gQDYNxjnheL2RwUOPyiEpw4Per+j?=
 =?us-ascii?Q?Hh9mYikbYXIAeBaNzseVz1ti23u5b6ghIiUZomKuaEt/Oo3BfzZ/NyziiB2P?=
 =?us-ascii?Q?te5qLeBNkT3R80xo817EjrqyhJy4jre5t3ChGWAp8xkeLKgKHHHVjmlwD2bA?=
 =?us-ascii?Q?UOsfWHcwgnp7TsDGUh4dju4RCu5fHox1PbrBX0NNTW/BlupbMaQYe1JLwEG8?=
 =?us-ascii?Q?1X06sj1Rqdg80IGmnA7AdSHBwnGpMxtNDQx5etswy1/dvMdNdxNp6jEvn/ub?=
 =?us-ascii?Q?aZ6YUJH2xkvQRjhBw88=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5f3146-bb36-4625-5218-08dde3e5fadb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:45:05.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dysdhEb6EqnJtWuBum9iK+vC8eOn5SA01ap6q9groWrJ/d/GqR35bZVRalFCi5aT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

On Mon, Jun 30, 2025 at 11:31:23AM -0400, Dennis Dalessandro wrote:

> +int hfi2_rdma_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
> +{
> +	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
> +	struct hfi2_filedata *fd = rcontext->priv;
> +	unsigned long token;
> +	u8 type;
> +
> +	if (!fd)
> +		return -EINVAL;
> +
> +	token = vma->vm_pgoff << PAGE_SHIFT;
> +	type = rdma_mmap_get_type(token);
> +
> +	return hfi2_do_mmap(fd, type, vma);
> +}

New drivers need to use the new mmap infrastructure, so this should be
all be modernized here too

Jason

