Return-Path: <linux-rdma+bounces-8757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3CA65E03
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 20:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FEB3AACDF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2291CDFD5;
	Mon, 17 Mar 2025 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvXX3mpY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77481F9DA;
	Mon, 17 Mar 2025 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239915; cv=fail; b=iCUPzMTeZeBOpqVpBumhyLXlUQZOrresXS/hy5qzEwfHzFqz7PM5h3TjCUaTp6nmQ6OG2YGVOJmzCweVDVAgZw2R4wzfCC0oeXqPJxDpImKetO6q+iVWURLb2qAcd9m5TGj0ijFo3QsvJF3dUJkY+lIi/eMMVl5GUDZ/IUHc+L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239915; c=relaxed/simple;
	bh=bU/de9RAlKvWs4Vemdfm7JRuBeg/vHh6vtgpST+TkRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UQhgGi0UtLYpWcEgjJJyVbH+79ZQ3uQPpdXh7VBocKMPK2/juoSVhu1EIWubhJFR+kDtWNRzmFC0yaRPBXDwuqpyGV7JE3xa5orkSuSrHa4b0SLqdBYHMGkSe7qT14cl7dym+htChfHHLyXC2WJOcIe1jiqsmdVW+ePElT5Kenc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LvXX3mpY; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu8XXnsi/GxVUJoBXCJjgjTF+nUDtwhhD5P9vU+RaUzJAlhJYTkERcgzyGzfUNbFtFFSnmRrct7qOcmJ4ukHqlvjLDBT5fG0Zyr2HPbriY7p0lomS3AZkedTMk+MMriOZaymWwvSE0EMZ/jRaOsteGIJOtFpnHbh44pASQO/VGZeTc5rLIgllFuxtEydaQeRFrtsVHxXZw9TZz4jJcwaXGububFYaaEWOKUkX6q5pdrvI9hYSkD93yk3KktfKwF20stVtCBr7uhT4CQZodNfSnzPzkBfYFD1uexp72CHEuWHzRjMUpUj7RR2pX+zdwbEZ/dAhTwJkCVieJAyGKERYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2CPJHgzRrOptJvHBnqRNhUzXDSQ6/+Cyg93/ICAWWg=;
 b=MVZCBZeqmHo0C/5Fs1rIEerxrtyMmchrAMecO6e8m0umUH/URu2aAcnTMVIBfu86O42rMn/flosNXJ05/GGg5BrOQ4YIqROEMNSrRc3brqS5ehNJvmtthYVDDaZjxNZmTaeVS+q4IwSwh46dOWetjzssOAHjTMmp29FtF0nXt58pbk14b3VJJL78g1EMqZ5+PytM7eo3E8GnUTdHAPAa7lz5ro77qGuwKtGZfkOSnW5Y4B2+4UsdgYkOriv0j4VmYEx7EPDiqXo8G0zsMNOysIXxl/kD3PfSmkO0LMTPMWzVemo8Q6I5Uk7ujgyNIfZIeYTRFTI0pB7f9jE12CozrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2CPJHgzRrOptJvHBnqRNhUzXDSQ6/+Cyg93/ICAWWg=;
 b=LvXX3mpYBi/slVKE37LpVM9t1911J3szNN7uaZMnw1b03LvnlvfZuqmSm6WPd4xBwL9T/JJRYO/8Hwlmh/n2/QWNMVx97+HLULy/+Xf0Kfmg2lL+OOB9zcs1OGvlbSEmJFP3y22FfQnEgk/wxuZB2jh8uLA3nWrFLUHUfakf4NSOieASVGfaCdkqhswofg/YI1yi1OR0znI58xsZQtpmpfx0B18tfts5emvc78jjWnk6xilRanvYYfOVp7Nqhm3Q67jOG5/ll+/l2lq4a/PO8y+Jk5oyF+Pv4jTf6abMxJV3+MR5XeHdv3R7Gu+VLhnlZYVvxIUOo6KBLpAsrP2peA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 19:31:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 19:31:49 +0000
Date: Mon, 17 Mar 2025 16:31:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-security-module@vger.kernel.org,
	ebiederm@xmission.com, serge@hallyn.com, leonro@nvidia.com
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250317193148.GU9311@nvidia.com>
References: <20250313050832.113030-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313050832.113030-1-parav@nvidia.com>
X-ClientProxiedBy: BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: ead92e9d-9b19-4b71-573a-08dd658a5cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YM+8NFqnbdaqCeYSMQUiXA150Rw0ZSpkXmIt3wtLo5NjD82HbaTqClbQlNY?=
 =?us-ascii?Q?4raTtfNIK/xGeGbH+amg2rLfDFluTbTOuv2v7TszrE2hVynZ39uA2kh9Pl9w?=
 =?us-ascii?Q?crr0mIlzxdRgbXKOvUBmbtQ5T6FIvc6FF2UILfAqb54Rpq1MqE6C3XYxqjC7?=
 =?us-ascii?Q?ZBZqisKLhFoo2T/L77dw+PxAKWMSn8H3clqvVBvDBLKdlv3D/x4Yy9buxPGQ?=
 =?us-ascii?Q?X1k5fiiVQnVY8JPos/DtFHrZvqvGJLNqkIiUtSZ/YlsfyPMM6TsQVFPA1UIK?=
 =?us-ascii?Q?XMmijmBn0ZIQUWIpQ0oGIbqm/TBi+Y/8auSWoRfTjoVpX3bbZ+8DgJBvZ9GJ?=
 =?us-ascii?Q?svFAx9UtQg5yTVUPT4mgt1cO/kvfyn4aDlrOrGKd0hXLE7DH84E+YU9JCFlt?=
 =?us-ascii?Q?ma/bP82Dop+75BOescEBUOlXofDqiVZeSB8juUJQ63i/+94bvDX6WBiSDesa?=
 =?us-ascii?Q?afvZW+qYReyxZxNWbLltVTGG8H0v1wZZv7tWx3vgeF4MEra+C8RPvMOVpCeB?=
 =?us-ascii?Q?g5EbU1j0QW40Ea7kK+mo87Pdxi5aL0OOCpbmyxhs9qPM4zrDKIGU4SiFEnLA?=
 =?us-ascii?Q?t/3xzG1ZV0UWWCjsd/xs2geO90dZz04gNPAV/lwS5l+X7mB5tiZ7DgysCJRM?=
 =?us-ascii?Q?PMsXaSlYi9VP48+zgLdt4R91SojkX02t+oSOiByKLtOaUDPZVUQnR2wxmKKe?=
 =?us-ascii?Q?2k1jndqpdvQjK7mXZnYDhAARqn4oGcVivLDhYyzn/ZaQcI9A3OxOHgMuXrl/?=
 =?us-ascii?Q?xG9ITMoFnQX46u/crB4XoVZL4QJqy8uz3BpZ/P+xdIeFNQGK82vRmruFlMA7?=
 =?us-ascii?Q?Y+gt6+2vm+bZbx2wiwMLDcT8Zkw8GbgfJBaPqOKBsQSbac0eQ0/ccnijhB9V?=
 =?us-ascii?Q?IWCx8/UbHzZC3XvKWNf3ciMQjdBF/PP6HP1vZsojPQyGvxxAj+7WD184o1MD?=
 =?us-ascii?Q?kz94wSiFGwh4EkYWAH3ec9YWnJP4vcnx4EaD423zjqF5pzaVLsEg4oUKsRIC?=
 =?us-ascii?Q?ikf7ugjCteT1gUHA6uMLhFeKavNZfSZUqXhnncwHPEHy7Wvj91G3gSzD2Cm7?=
 =?us-ascii?Q?UtLkMq3+Wl0SB2ptLYkSTkmvqCaePJS6Wqu4sFErOicLoBexh910Oj81razh?=
 =?us-ascii?Q?V4QpI3RzAS6kS8Gsc7MHjzxrbOJVfUpooz24d5xTHxYUG9ULLm7Y1mgd02UJ?=
 =?us-ascii?Q?2Nwly0ff1MQMmUtUg0wnW5DeRH2ARixH3U+aSHEo/VNaiw+frm2yfwP3Lu11?=
 =?us-ascii?Q?eE63srUbmnOZUCmGYxfG7KguvAvmUhH5kAxT6FDnqqGptnqp2x4grJt56rte?=
 =?us-ascii?Q?6JTTdLDwApXjqhGWziiRhua8DpvabRMa+tIIGj33QGVODRMoahx0TCUdtwqg?=
 =?us-ascii?Q?Z8srnCgjh81OXiLz/OtbF78oujfH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pq5mzNRpavWtD2u5w5R2VNuXDzzmtEW008gqhfH/NmO2dqj/g2OdqqD9e7J1?=
 =?us-ascii?Q?T6NFJ+6amQLla4GUR6muHf/fbuhOtHqOUQvNGUUJXHeNwBYtg2PV1YXT4DTF?=
 =?us-ascii?Q?v1nQMOcf0dFRfpiO2A3lY08k+hJTltup+2O3dnXMSRx21dCt6wxZgqvLkxFc?=
 =?us-ascii?Q?11GeY/sdfJgR+HrXmLJAg+YFWJLZU7BHlgB+rQkUigIDfZJlCyQZLBcDZOSZ?=
 =?us-ascii?Q?UKSUP4+JH5ud6X0SBVRXU6lz15S5W+pQP5Y240Jje+9aMbcM4bc1KN/ikh4S?=
 =?us-ascii?Q?8GXvgDAU4nU9OKvSijXdcAwYw9L+HeFbtVAkd8QHyqdjSAyyiqWf5BbTjvkd?=
 =?us-ascii?Q?Yz8JHL4FAbwicI3H713ad3POP9xCCYPiDnuqtIDAq2F1VxaaI9XEA/UBMzKg?=
 =?us-ascii?Q?TG/BscWmywIeXjTaXTkzI/dh+vdJFsyRwaU5Kb23O9NisZAVbzZMp7EXlmX/?=
 =?us-ascii?Q?Mu8Et/Jil3fj/a8MaEfPxEa6jNF+wCRMDn/KqBYxUJHGaf2aOt59xMh93XoL?=
 =?us-ascii?Q?5YJvnXz1++qqpXBmbj8xq1fb14FRffzWuJ5XMfoyclJ7CYP3NgAvTkodvTTU?=
 =?us-ascii?Q?DHDuo43w8CGSbXsmj+aLzh91+teVdfw3xwoFRwn1rxFM+YPwI03ue3HtgU7W?=
 =?us-ascii?Q?UqKIPylFEYX8nv/b4+2qp0u3UjYujF5rLOcYQPOKVJZPWUhGGD8IxnhDnAkV?=
 =?us-ascii?Q?3zXL1KFQ6YeJr/e8wiyoZE6YB7nYwjrZbOhg6S12z+tmFZbZGTDlW3g1bmS3?=
 =?us-ascii?Q?0ljTIdAZkfXrtuqd1ZPnM0953jRu5g7vNWv1AwYohtRpyd9xw4e3FaMF3kNv?=
 =?us-ascii?Q?ZpylDqBBQkeXEvGnoO5zdmfHjGxQZlKMTE3IDZL9FVpuoOlpEDHkJ37cqyhM?=
 =?us-ascii?Q?WQrCIUrdXPUF+wUCgZhj/pIdtGvOFPN1fvGWM9IYV4Vtcor+7njxdadQMQed?=
 =?us-ascii?Q?qgiuAxTBMfxro7uwJ0BU5J0qy9tK7dqzW0W1WT06B4C4I20qzrowk1OMG3zs?=
 =?us-ascii?Q?59UmRb7wGxXqL7naMYn5tKpq15hCWRC+N1HLrPwY8V2qk1VOhlEY1WUeiZmT?=
 =?us-ascii?Q?752/0oLyVck/O/2jqIDr7FuNfnRj90JzCH/u3/27vZT4HMTYdiRvD05F/AP1?=
 =?us-ascii?Q?ukVDJRv4zGjxqbsSMnENEUAX96fr8p89IxLnKwUNdtfIK+vdaaER5aINipeW?=
 =?us-ascii?Q?oHSAkgY4saZo5FaaLTrClHKhzJ6F31KLP2+Wf0bJn9EKBW9Q8570O8/zkSWe?=
 =?us-ascii?Q?kv2mGgUCa6jj1dU23Vt815N6ilkT+3L18wab03gRmWGYXGHy+NZ2GII8kTcn?=
 =?us-ascii?Q?9eS3pKFuPtrKkyLugIjmOypH8IVKMsNj1w59FXc9t/6gv9ykNP/EEmKCaAPu?=
 =?us-ascii?Q?ZAIxnFox73cFp5B77ClbTpnbh59gYGjZhQDza91TJrRvvhUmDeKZTSskrq/E?=
 =?us-ascii?Q?rsehG6dD7D7JmwddsCUe2tY5QcP5HmMgO02UIfgHdO8q7e/UmsAU3BdQ5jln?=
 =?us-ascii?Q?e1e0+w0SNq8IFs5VGBB0Bpt2YzjaE3Be8RwZG4BOHIsWQ8d9TjDe3+HQAGve?=
 =?us-ascii?Q?p62ScS/+QACwWK9hYf/5MYPSm9jVkLzHZEf1REM1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead92e9d-9b19-4b71-573a-08dd658a5cfc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 19:31:49.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfsYeBVXcy6bZbZs1RtD0LpfskoESfXE8M5dqdyoz0ELG38Ui6qpp6nKuTUjXSaX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

On Thu, Mar 13, 2025 at 07:08:32AM +0200, Parav Pandit wrote:
> Currently, the capability check is done on the current process which
> may have the CAP_NET_RAW capability, but such process may not have
> opened the file. A file may could have been opened by a lesser
> privilege process that does not possess the CAP_NET_RAW capability.

> To avoid such situations, perform the capability checks against
> the file's credentials. This approach ensures that the capabilities
> of the process that opened the file are enforced.
> 
> Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> 
> ---
> 
> Eric,
> 
> Shouldn't we check the capabilities of the process that opened the
> file and also the current process that is issuing the create_flow()
> ioctl? This way, the minimum capabilities of both processes are
> considered.

I would say no, that is not our model in RDMA. The process that opens
the file is irrelevant. We only check the current system call context
for capability, much like any other systemcall.

Jason

