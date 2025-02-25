Return-Path: <linux-rdma+bounces-8074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2682A44AC0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F27189C51F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAB91A238F;
	Tue, 25 Feb 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gNe3PNP3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C73189F57
	for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508976; cv=fail; b=twwSdEb7Jbjz2d9plQ8251xCD6SFPeaeY3ClnJUigv93hEf1w1O+s4tAVj1Too1O6iBLniySRI8YmO7Vr04Fp87u0YDfgFU+0DgJfw+9834tSbZYKAS1681T/6VotM34HG3wGpUSGKv8OpVyLrLreuloxIq2qR5uqJUjGSZd71s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508976; c=relaxed/simple;
	bh=O0Go8dYF0gZ5cIPsMUwL7QffN3xESuVP51OPo0KEs0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TKXY09u6NZm3FB6GVoIvpCxc/zkoY1Pvoxq9sE4yRDoOWAb6s4PMelJpR1PfDWdyPfvSVjdNoNZQnh9+nd0XmzU4WJQxN7XhUc1+3ycto39Yy7GdyrwElHXD0sbW0eqRl+/Kh9HX95HSQmo3loC5XTBhfZ0Yu9ACljQ/dd/My2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gNe3PNP3; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdPiZ9jIlofcNxQsfIS3vxUmi+lFBf1gTG34x/dQ9j+d/G77+sXaxQyhARKt4gvsyAr6Sg2OPHQ8Y1jvEXbkMY1gbTvhcBzQyau7egjDRGv95AVSvGDaq5n+a+UGFq/zCjVIsNnAdwTs4kbDdLljjUANgCpAUilD9rB486i7ES7oIJOKPyumuUVjolgr5k5FdkRMwz1vCMgrtJjTenN5gIUTHT3l8y9r5mQBzi7Wlwtu9XpMq3D90hdle6SpqAWVdUBs+Bj3EfQKJgjK2OwnjvoXCKixcdIviNmqmVnM4hUhtHDDzTAowr0n324MX6Ry0gTNw7CFJx5JCIlR/mhelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVieqMYKC6gS/vvOXxRicOnqxj34PcUy9jOE7FhlQBQ=;
 b=ouWbZuEagcKwQtA0gpqosAzlAjuE1t3kPWs9c946TrfVtUSXR+ijW2UzuLz4SyLW7kEWaP4xdBoHIZ3VoE/sYzsyhr7KXUnBejtjFXUEgmqcTi1I3hFbrx7c/EZMxnwDiIGTGdyDyUrRvWQOllNpSge8o+KLgSFSchrCQQb35OomlHqqCo4Lx7Sm121RUw3S5ICNwFwl7tbtvDrsHjjwcqNgzOEpV/D09gHcRvhTyvF0AMNg0y96gNO8JP9uP1t+bWAZYfjIT8/+Hk12p9HMugvaYYqrFYhiCKiO3F3JVt8td9qAwyohyNhyWVQZk0KYju1oUr6yDXlsBD56OAmHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVieqMYKC6gS/vvOXxRicOnqxj34PcUy9jOE7FhlQBQ=;
 b=gNe3PNP35swIKwMyKKH2ADIzYktvPMhiqouZEcA/kHv9l6ZjykCg5WdqIIRzImlBZNIEdLQ7cdNaaBPEgMVPHbhbhn3tx1eeeZ7akxf7pjzq3FZJYbkquVQeLmIdrkfL74Jmz5Fm3RBHucUpkyfTJllXj9fqo5eHbCmv0hcpZCsUzQU25XAp+7dYATcrDiJdfv7b4ApxGCA5GdyZ/SNH6tAJgXG9vfUn1dgWxuVwKuKm6gV2wLJYnY2mwyT0fB487fxVDikEHcPXdARmtlMzmo9jhlmoG6BtIdMWBXKSig8jiQHXVSqn9lFvLO3W+5JVMCC4u8/EIv2Ak2yWpdJamw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 18:42:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 18:42:50 +0000
Date: Tue, 25 Feb 2025 14:42:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-rc 3/4] RDMA/bnxt_re: Fix issue in the unload path
Message-ID: <20250225184249.GA609904@nvidia.com>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-4-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1738657285-23968-4-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: YQBPR0101CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 3930c5de-53b5-4810-9704-08dd55cc34d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mNlWdRxbBEyActEb33cxvvVHYmH6MazbR6CEpwKDZiUqOh54pVRRVGMHNTG5?=
 =?us-ascii?Q?0cxqhiHOWbv+6RMyYz0Ti71Y5d2rqcgo4iElGd299wpvNyzXye+zj8d7NXj4?=
 =?us-ascii?Q?CQYDtVtixQNdqxYrrCjfdgo5Gt5g+NlXgzKx+1jsvwXGRbUwOxDZeIAwjzRQ?=
 =?us-ascii?Q?wcYuI95uoqRR+1xZW54jz5vJifiQoxyVqghsHu7350HnJrDazBx2WK16w3/f?=
 =?us-ascii?Q?duiSqHNqWuAksNwa7HEpA4l4e9yu23mo+7x1FO4WwGeLvuoafzANA6yQjlor?=
 =?us-ascii?Q?hNPZ9/LyOz8qdAzlH2ltdRIsq3tWnhk4DeWmwO8mvbjeayoTZaZldVWeDQ2U?=
 =?us-ascii?Q?XlejLEoHh9PXso7k8dHVnpPr+PQWW6T+Kb7KsTCwhLjFD5UKnjmtgBoVD8Hw?=
 =?us-ascii?Q?eYVkAOayq7NI+hXwGe52ttKjrwP4+ZRN06x57qC6emBWU8a1mEaljXd/K3Z0?=
 =?us-ascii?Q?c8m+xV5FxQk8kkfNZCtXOOBi2onMjQ5BXYoI1s2i0cm1SZVbgGjZNMfjrjaT?=
 =?us-ascii?Q?NpKYsA7tnNgYWDbsTVS3gsEdxl7SgOT05iwXyyxRRYhqaNwO9QP4Rqn76GD7?=
 =?us-ascii?Q?l6uicN4J2tOMGp02sx4JbZx9mehMizNcpKmodhpkkuhTpFqQV4YfnPKbLGbp?=
 =?us-ascii?Q?nZ+GaRD6ayf1DWrg+wGarjVVMYdFfEU6Smp1AP/w8yw7Q3ohH4frXspwxxFW?=
 =?us-ascii?Q?EEqOXWuFktZAw4kzwhIZIqmN+Nvt8hU01fJ0wBWlhkzif0cQTnhAwUGA0ygG?=
 =?us-ascii?Q?Xfsl50dqiWKKwrZu5mp7VfivQP5Ye8eXp/E4yQMviIcFhIdJlGwA9fd7H/pe?=
 =?us-ascii?Q?lehKeSCbXPGNUgDF+MVKYURAEPO9DiQ+vfcMGgVGAZZ3Dj7g/6/tfeAlUSbq?=
 =?us-ascii?Q?kZslD/6daI2psVapgE3Z68QObUgNFhC6iDBRHQ5OTfsHv1L9UJqP9W/zA5xF?=
 =?us-ascii?Q?upN3walMbZYvuHf8jv2viZuAbXmgevdyjCXrD7LmCgpYIX5pT9KyaoohQ8WU?=
 =?us-ascii?Q?fabdkh5RnjRyALlTsLwZU8FUrYW8Sc2+R9cz+zRqy+2txf7mMlHGsKPcPk+K?=
 =?us-ascii?Q?t2cZ9tSKVih8euqzX7dmba7TXTRgKymrMKpyADaDwFOL2b//k6M1Nm56v5ss?=
 =?us-ascii?Q?9y0mRbyjG3Ckf/LrmDG9Xph851dXCP4dW9gfofN4K8lmQWlD/j9pamrzqZP6?=
 =?us-ascii?Q?q7jqc+4hQJtrWK/nKytkP2IZgK3nahq/vV4YNasB7cA6X3frsEjZt3mHV1vp?=
 =?us-ascii?Q?zfarS6kCe8yvhUX4t2PWVy055SWy/FT0YFwFfFSdFD/prztj2MZa607BQaCU?=
 =?us-ascii?Q?yVlHLAwvwdOHA3U8QAwNjRsaL0473MdLF0+VwYLAfzBBlMdCywRospzxmGie?=
 =?us-ascii?Q?1w1uC6ENBiwXX0JQHX7znSmz4D1Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkJ4yr9cnYDdSoR65z3LCGIIP/6b89wYf1W5J6urin/6k6s1IsU3M+RVzMU1?=
 =?us-ascii?Q?JETAomhtLuJPtBXwwH7SFOk8H4figpzuSLSwVJF5G2LZ8bkTUF/ZYsFcBRvi?=
 =?us-ascii?Q?8DiRLUsiBjKC6HGaHRkPWtU5Za0PAmp0aIESmYd0Zd6OU/TSOquoHmwFSQw1?=
 =?us-ascii?Q?UqMLTohbUW3pZUR5TOsJKQznCz1A7Obnn3UxV85dXU8lvYl7jUXER2A1Bzy/?=
 =?us-ascii?Q?ZsknCpucLLpxlPzRdVd7RZ2RP0RWxzO4F3X0G2mLMuFVBUhHLIWI5A/admy8?=
 =?us-ascii?Q?VzpJqfqziREParUDhGT8wIPOnlZbid9VSWC/zEPCF9Ibj6lP7rkjsy/0gH/w?=
 =?us-ascii?Q?8eB+REifTdi2Uld+qH2nFH3EWmOEHWH2WKid+wnoex2CSLz4OfijYJRWeHsv?=
 =?us-ascii?Q?hVptgmLvnyyM2Mg0bsE6ixfkQTxxlYkY4d3OHK9fDJvEOiI7DJMiozmRXunk?=
 =?us-ascii?Q?5RAjUwQiGoeVtgwFlXCSlZLlBpLSbuV8VGzZzxeAS616FATzY9gLWjSnIHER?=
 =?us-ascii?Q?jBpF6FQa6fBg/cMuVCR2+D+2jgxwINHpr6RmrU9e9VVGXsoQQACVhaWE2NGA?=
 =?us-ascii?Q?1u2+daOm+4CzvhpESFX9dpiRkPvP79OX8V0ro1Lv+Fjt0DvUUIgG1/Wcibg2?=
 =?us-ascii?Q?FXnPwH5LYcjoMvLloZMr0NaRR/vTiAsEX3sU9PQrtm0DrhgrhPWIhAUXHru+?=
 =?us-ascii?Q?N1TEzNR2boJ65xCyAn2xb3+H5LZAGOl8uYLEE/IcZ33v2MnNc+4S267pPrTq?=
 =?us-ascii?Q?o+jVlzQKWXZetuqfLHcEul6VCONCNnYTCPWVjFSrqQUbFlKz/0a3/qnS15bc?=
 =?us-ascii?Q?wBPSKf5btwEM+ybC64a0v1UZ/l2g21wiXnRoty4CuxPxfmWnJvtqWP7R2iY3?=
 =?us-ascii?Q?+NWjK5sYLyvdM+AnIkXWtmMSqGBiGB50uCAVGxJu5eQBtEJZN7LNQGyqguq6?=
 =?us-ascii?Q?NpWlUqyBJzR2D3zAYAz+uulb4OcaTnimTfbh4vnujxoKXC8lbfJgmtC51Kp5?=
 =?us-ascii?Q?QOyDI+mO/wu+jq2TN1L0RJj6UG8GBi/a2NmjczTKCFb7tDRxC4b89d5lhYlF?=
 =?us-ascii?Q?H1oKuY2SuUJNzDWgDu7tcUZSqdUX0x4n75nvexINz/k1nei106yTafa0fCOb?=
 =?us-ascii?Q?srViC9Ev6VeaE3LqVa4FbdLSjPXHvS203vdFwrAeWxeqTz4hGHKb2KANWeDD?=
 =?us-ascii?Q?j6ohSWphpvHCvQ/hSHvlEDftJLR+kPwKsGO9xhcSrvlpGndlPexWtqM38zvJ?=
 =?us-ascii?Q?YbD7Kj7hhkhb77Hhzg8kbL/SDOpXQhez3krtHiezhDXKXBPFvzYPMjDw/BIb?=
 =?us-ascii?Q?lvjU3s9lFDVNOpACBzzqmeUSV1jVTvKWwtlUzFGBgMklSqm6/vMSX8nGsiZY?=
 =?us-ascii?Q?DrOBrdLv9jeS9IU3NjsGGLSPOQzeqP5h1b4ukJaIvGaQG4gZvU+GYdzkGYdh?=
 =?us-ascii?Q?L0c9QtKhxOaOHoTREALy7ZPMS5NkQhaQ7HHTykBJLhuwRN1NyvQX1hwj2DbG?=
 =?us-ascii?Q?RIsNahBz7JdB+qdG5JiUAyOUDdt80XfpVMVWdQkJcZyXfVbfVHx+SMbn++5C?=
 =?us-ascii?Q?HiGw2kipN5eYDIPQ448o4l1rBrk2Sf5UEJE+ssG+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3930c5de-53b5-4810-9704-08dd55cc34d4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:42:50.8561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9SmsK+HnbutoTZMB8Vsr1t11ycA+FukuiTUwP3ZU0VXkFHS8sTu3I/be+TKkr5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329

On Tue, Feb 04, 2025 at 12:21:24AM -0800, Selvin Xavier wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> The cited comment removed the netdev notifier register call
> from the driver. But, it did not remove the cleanup code from
> the unload path. As a result, driver unload is not clean and
> resulted in undesired behaviour.

Please don't use vauge generic commit titles:

 RDMA/bnxt_re: Fix issue in the unload path

Be specific and exact, there are several cases like this in this
series and I'm actively wondering if Linus will object to this for rc
patches.

 RDMA/bnxt_re: Fix missed call to ib_unregister_device()

 Since rdev->nb.notifier_call is always NULL the actual work in 
 bnxt_re_remove_device() was skipped

Jason

