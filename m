Return-Path: <linux-rdma+bounces-11405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75AADDA57
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C13E163A05
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A9CA4B;
	Tue, 17 Jun 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q89CH1aQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EF2FA624
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180176; cv=fail; b=u3Z9IgzGiy7qtxI0D8chE+LDCcpDongpmRQGFw1Tpvtkk66ngIlxniZVypn3jgOv9VFtdg8MWP2ipXjPq2fqh1BACXsWsSmePSCr5cPwUmJ/5TG1ILBJxM3u+yqGhlGehtaL6jF2I8xXBn/27jmKe0ZDOZf8sILgnHv99BWmRZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180176; c=relaxed/simple;
	bh=DK2jA80mPx7VE/jbEp4lZo3oTIU5MhxccBinAs+eDxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kSB0j7h0ncUekniez5rxi2i+JSAQluNcST0M9rIuUKDS6UC4C56FC+folUaPKk/FHK7jyX3gB6fjrubrz59u2FHbnonMZBp5rztp8mQWKCa/eoSVdIrrQLd/gyjIpw7qEaMSZM6Pv/ZTuo1zocqXhVOCoOFZ4CsAxcod0WYEuwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q89CH1aQ; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4eDVGLNEK1SqthK9wFR2SIwXnpBi2GMh33dQ9QA9oVhQT+SUGzQGwfOkhNU4HD6lXZOmPonjAi7rPhNAkdIRnUVqKYvVJ9CwLlHwcEHAfcfivkIgq8WkC1VBcbW+cR9ZudDB5QvV7bO7rloDNtmU1upUP8L7ON6FVtMkuqj3FhQmyrhOlzys1ys48S16ZmdFTmLBmWqw6BdOh6aLavlWgsFvMYulvKnM5H2eM9Aqn8n1Wg0gk0Q47BVqCSeU3uq++AI9xzQSUzancQXj4w4NTKgOOvZYBk23RSmoW3USQsh4mBpeMOKa/6UsZJJ32huj/jXE1hvACiIg8NZ0Mi18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dhVwKpJcv454e1lWYpJpJm+g4Xtn/S0J/a9pIIULv8=;
 b=ig4fcB2kbpCi+E/IY2jBdOy4XZjXQQAiQDZL8Az7vryYhRJWV+QaIgHR53+u15eojq3mlzayBQYgKey76BIVlCXdTuq+x0rjJ0SKEF8k1cuS5bZkRTNXFoBC54CNXe4aSkpoHOvPF+MR2zzefi3uH9Zr24XhiPfYjdHh07maWVl5WE8GqNgmIC+GJ03IxNlOETmXriU6UXVzJaS8pcRK+Um6EZ0dvfjzGqWOV+NbPr+tqLMrzTbRB49o03NYJrp+GNS83zDLbll8rxsJtu2FJB3q8tINKZ8p8N5DXL4+V8/z5qcaW2Rmthxtc2WEgpDB/4xKnLseHN4UM73JlZ8tlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dhVwKpJcv454e1lWYpJpJm+g4Xtn/S0J/a9pIIULv8=;
 b=q89CH1aQoyRQjj0i/a6CX9OZVFpIs2AfwJ5rqu5JqjTmNEPArwmlVQP1msgZ3nSv97UyYonVxMr3D1d9hqfBEq83x6olnZgcKOWVA+evRgkuUDFDd0WFExWcNDiByCZrUaSvH7JDtRtXAkbqopQzMHJ2z9pK81+jts9lLOl4w+vHWahgIQu0lZpTd/ehE2VuoervYa2dGpEIkJA6OUqpdqUKYnK8C+Ij/7ym8r51IDJk8jra/jTwqWBP3Lb8zAsujQu27CmI4viRbIx3NS+EpYCphsM9SXgu5I1zHs3O5L7dSQ1OJBjeRvV2psLxKNZIS21PyGh38zthwALXFOfs4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 17 Jun
 2025 17:09:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 17:09:32 +0000
Date: Tue, 17 Jun 2025 14:09:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] Remove ancient qib driver
Message-ID: <20250617170930.GA1565073@nvidia.com>
References: <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>
X-ClientProxiedBy: YT3PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7486e635-6a87-4222-321f-08ddadc1ba4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMVZsX+YrVAEYakDHCNl/fLAvtR2mdguUF0X5rzJ4khFqdW6yIqZU2D6UB2J?=
 =?us-ascii?Q?i7XqgdyMuh2hI+/CMZiksD8OENup8W7lY+25lgayuFav8nGO1OUzh/UlSI0+?=
 =?us-ascii?Q?JstSMOHqXnR4woHZ65dyPIvOCv5RqNPeEBisljgVRCMeJRV4/J2n8I83yAJv?=
 =?us-ascii?Q?Fi55ptpZY0c9Z9ghOXKtEx694452pMu0Jl7QmQOMKfRDoo+21p50x0vvN3kj?=
 =?us-ascii?Q?V3rjkhQbI+/yXoiW+xxyhF3gpqIdZWbOhT6C9gPWEiJAK6mNOKp+f116f4Jn?=
 =?us-ascii?Q?CtcEmtC7i11jWVEK33o1lKbnQfWUU6MB5xgoZD9wosA5dXxGdI4wYwOZKgFw?=
 =?us-ascii?Q?7qfVrfLKBrJWeXLqVMV7bwjaMQbFaC9/HxrZeAe17hDtwEsbvhcReocH4H7P?=
 =?us-ascii?Q?c+0fx+2d163DmgvifxS5t+dXSxRygUKc1eeUfG+uzHp0cv5iz4iMVYggxehR?=
 =?us-ascii?Q?/jSmhb17UGEpAWblDZ90N4yRVD1zwz8d6CoBTh5xJftFSiw9K22SnXD4LitN?=
 =?us-ascii?Q?I/LEKjfBGx3Nk1aG6uXE8ZuGYs45vxrmLwRngcLOVmEWWHXJ3//2DesFZ63E?=
 =?us-ascii?Q?hxBvfn6N3XDiVqcvyizq+zV+K+j23Cesk1FKdVQ6yzA2PgW/kpSV5LQiyeVI?=
 =?us-ascii?Q?lfrsHg0hLwYrOw+4KGLETyr+IRxRSL8vPFhZoH3AkUaGEn+WI0YzzxK3jsHn?=
 =?us-ascii?Q?ciA9CCwLyD/DBuO3r6PepHDP+WPcqwkYdqX0TYQJnZwa3qXiaqVgfLOVFYPF?=
 =?us-ascii?Q?/cmg3fUq4OOqIrLY/uMx7pLSnWcctZ28PHvItJLIgBb5d6aFdEqa45R6yrO8?=
 =?us-ascii?Q?QQJvp/nL44jMMihbV77EONOkz6WwPgS8QGiiXidVsHla0+d93aQ3Wk7Bljlu?=
 =?us-ascii?Q?r5jEdU0t/SzinFFhJYfU+IEN7S5PoN3LQ8MufrcMjnnTgrjlCSnIqnpa5Jjc?=
 =?us-ascii?Q?0OjIjg5E4tldDvNfecF45FXXPHgm8xE6j6Et7DFCSsSOI5hnOJPSmFnMo3rY?=
 =?us-ascii?Q?bX55XmtgS6OCIQQB1scZEbPEFQbdjZEyQ59xe7JMavKGcCQhoBlyepT2yvMr?=
 =?us-ascii?Q?5RVLRuigXFNDjz6BNIrNELa454DMI+alnwWHsmms9VZfomeTaNGLqzlO9DFp?=
 =?us-ascii?Q?oLLxZuCqKQSpz//oeKYEUNvRfLCQ9qgUru8kBg7NuKaNAHowZHcUaakhIWL8?=
 =?us-ascii?Q?ROb+q9bAT8+1sADwdegJjD5cbwqBq6u+VQrr6wC7FtsHaLnyOPAgbHR6Jzq+?=
 =?us-ascii?Q?x46spKrurKeG/ZvYDwJ1O8SoopvviZuQfJUEUqfAHt3UofQoV9jdKiBiiSPt?=
 =?us-ascii?Q?XcmBqXYBJJ162ZZE5w30dDNPiCeX31oCpeF3kMTeanNulZyMsIdse9db613v?=
 =?us-ascii?Q?pfHI0G4P0SVUjWTq1Hf0xVNHmZWdPdV99vbzPOQaweq4/IhOE+wp2EpEluQR?=
 =?us-ascii?Q?81ViXM4yTJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5+OmjpG2WPmnxLt5mVBXKb+BmVPfeNUOn3mOtGkRPrtq/4Sn/wB0YPyUIH48?=
 =?us-ascii?Q?9jKEHwPmmrqDoTdxp+Rzz1gNO7iau3+G9LN97TyP1JZzR8sIT1S3fFTnZX+6?=
 =?us-ascii?Q?jLAL/9iA+p3k9rJFvvmmNFEuwBd1KDLcAV84ZnIZ8TdRW7D5VlmjpaABeAQa?=
 =?us-ascii?Q?HwY23TSIpWbk2HuSiFUEKwlJUEQMx/eqbhkis4uPnST+zzTVEN+QeGqt7Y+3?=
 =?us-ascii?Q?CeNpNxt1JOXQbJcGfTz2ncWbBidYCxjKEQVg5Dxrq00AOXKEgRsGAW/xdjje?=
 =?us-ascii?Q?6QlxExGbKoqA4lxtrXfv6pnMx9gYfyJgkdrG/mWy15tBaqzzMxzbtZ+JW2Sl?=
 =?us-ascii?Q?xBltIc9xz3ohHQ/Y+dEWmxHbGm5wkQlPUTBabExomgR1+0I2YA7KMkCHDsXn?=
 =?us-ascii?Q?HPClcTsMmPEh/Lbusnf2HUcENvEeyhGw3IkK/b8JcFd2s5eUZuZAvknSpDRE?=
 =?us-ascii?Q?XKuXD+1X8o3QVUyqn1V2AjYD+uK/RdIsh+DtQ7LIwwZ45VP9s6OdJ1yjoNxZ?=
 =?us-ascii?Q?WrQZOWDqDNYB2cvdY8e74biRRCwNMO7meCKaIyIywH8KX+NGtVtRPHBQZemt?=
 =?us-ascii?Q?4VyHWEim7qcFBMbLZ8kmpj0RRfgvOAXgReczyw56MZiE7nk+jitV61X8KbV0?=
 =?us-ascii?Q?m67n6K7D8Z7rPwRUpaWv/FyIbhGhGDnKLq3iRjuL2O1t4wMYMPNl2X80lEnA?=
 =?us-ascii?Q?mzhnr0ItzpXPcz62C1GALb16GvJg/JjqXszST/U5Enq0RGj9vwSY+rOvLnM7?=
 =?us-ascii?Q?2B+6u3UowFG899Dq2jJ5J3uuA9XTVxk/ffGpzWFIrMyeq8eFs8oAjkifHAeK?=
 =?us-ascii?Q?ecnc4rXbH9ir2V4hdOpoX0mO8ybxCJ/eqY6yWAeydv+ruvNP3I6Z9upOw3+Y?=
 =?us-ascii?Q?H7TG6IzKFd8k1fBXHyQnEMYmUXlEbrI9VMIhEZM0yNjRDyEwPycq2B4W1Ud+?=
 =?us-ascii?Q?iyD5lI2DEDOFZ7h2kmQkKuTnW5r868KE7HG6XxeOB/c7wwEkM6+UQ6oF2Iwm?=
 =?us-ascii?Q?t6b45hDTEBn5RzdjK7t+51waxoQGQv8TT31yvlZbI0SsRiSAFc3UqngsRPf8?=
 =?us-ascii?Q?WJ0nlRw7XU7nnE1t39keRKB002ZiA3JtKuru1Qbjb1rhzG7OUx4BHc1wMUFZ?=
 =?us-ascii?Q?BY+eA8JmDMue5FOYYDMZ33dJkbUGcBCNe5eX7St8xCqTg5Ap7bgUm+rMxO6I?=
 =?us-ascii?Q?X2wkJN/ZXW68HZbX6MgQUe+Ju6pZ7MI3zDDiLZu/hUNiFwxYvxsbJLMUZFBZ?=
 =?us-ascii?Q?wnS1rHYRAFCDhb6G2qy4jgOCI5NjBnWjemlhiQ7kuuUZyqTWvPo5s/efl1EO?=
 =?us-ascii?Q?inQ9Suk4d/sUDbcsqltgDmOqJP9n2rhKXx4adOBOePh0lzZ6sXdfol7k2gVg?=
 =?us-ascii?Q?eEhNdJze9YlF78y3EfITxcR60aYIMA2YkcNk3/a89uEm5ZKM5MbZNBa1D5C/?=
 =?us-ascii?Q?mVUiTWEUuIuclaTPZMMJpU5w3HulP+n87t0cp1GqU9HJDYSzkKpaqPfz8uEF?=
 =?us-ascii?Q?rcDuEXHJdVJFDMBvPJqx5IrLNY8RYzabbmM46RoWmTLEMHiQDpk9RBDF9ExN?=
 =?us-ascii?Q?ZFOMZ+JanUvN3XXhKe6umufTXce1h4kAxWDwWlJ7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7486e635-6a87-4222-321f-08ddadc1ba4a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:09:32.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmgbDGK7RmeUeDzuEmUWpodWCdIXQCfJvjX5+8K32WTTmZAmwByttJOEvizkPppd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129

On Tue, May 27, 2025 at 11:46:02AM -0400, Dennis Dalessandro wrote:
> Time for qib to go bye-bye.
> 
> ---
> 
> Dennis Dalessandro (2):
>       RDMA/qib: Remove outdated driver
>       Maintainers: Remove QIB

The conflicts are easy enough to fix, so applied to for-next

Thanks,
Jason

