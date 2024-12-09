Return-Path: <linux-rdma+bounces-6349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB69E9FBE
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0086B18839F6
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B817DFE3;
	Mon,  9 Dec 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nhvoHApS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5E13B584;
	Mon,  9 Dec 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773014; cv=fail; b=MMyO1PmVTWlxVEc8C199n/uGu2ZBErUNu38Zlqq7WFeHgl6cKxSKq3rnJ4AWPa0XQ5OwkqrCf1uwGxU7VJKe1NoBup4tISgUBY+IX2yk8PGnRI6cNRuyT/mWiO0Us6WvDlhNDh63Id9FI6i+1sJ68HVC6/ZiOX0bzVuGkK/4Kzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773014; c=relaxed/simple;
	bh=Fye6svb2cGXCmofn1mtpFZDT/OuolmGK9rQxoruc9f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tVwbHbDx2pQ7I3rQ6jPTYPwLpvDQRSXe2HxvVSuaP4FvRIBaxyw9W3acOM/w5yZNLG5MheIAwCHbdwA9//wmZSK9nzS3ofFLsyBQUV1FnrYlndVmQSNSWURj9iQInhYdfBHVxGAgd8GZ3gKFmxrJWQsfR5NvoaJwVZeHPm/hI28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nhvoHApS; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap7HQE2rQHCKFpQ3DFXDdt70uTdK2pNV/em3DGve4njMBuUdyuNV+2KdvVnRpyHbGahUxWY6cF1mnckssz0yarqpRGvMgIq8cjn4Ls04zv9Muyd+0pJeTAVzAQWdE1Y7loFs8n1NJNB14UO4qqF4rffJNqiPKW5Xh5LpVEx3p7KPL6Rjfs1HwV3Ug/FnjLUTEobckaCfOcTbs31RlNvartvcaFWwARNNlWJum5cpsQ1adFQqWdDTy/6BmvhU2oE1/OERSLtfEVVh43FLzlmxZwRYU1Iy2SG9wGjYROtwYrLfx6+cqMXCTmW4d5Odeg0HHYsFJXxdAaIET7xJBj03Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fye6svb2cGXCmofn1mtpFZDT/OuolmGK9rQxoruc9f8=;
 b=g1q+nAlErXyvjf5u0t5fEHjyDzMjEpPzL+Sak5JXm5d6sAqI60mNf2MmYoueNgjNMNMKxSipe8N483rTVFHTqZHA2kHcEBOZ4vg0B5Fp0KbIJiSHRMeuffLlk7HL3V+tAMGAQDJvtkbHPBAzODtoaDA1WMgPJkqQIwhE+6vyhmy5KWnxvDV++svEl/Vpk/687tnQgHvSWMHOV2Wm0xSEytjWUf1Ix/7/B2HV7S1ybywbL+641/1IyBgh/6IlWjamYzS10XFfqulzI+lt+XTttwYZTFtiahRwUC8j7TSXFmROSCMK0pcjEbDSSivFdLZY85e8y2kHX+l+qh8fpNIAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fye6svb2cGXCmofn1mtpFZDT/OuolmGK9rQxoruc9f8=;
 b=nhvoHApS/V3a+F+DQbg5NJ38WTsczmXMsLp3ax/TGW1DCG9TR1YoegPPIGSsn4m+M6hxHZrpkaMzeUcUw1Fxw4aU4OlQP/k4QdJ1EupjMy09Oo59o1HVqgARRRB6W1M4g3sXWfoucq+ci/b/OhmX51lZH/6fx+2rFrLCcrqWPwUhI5kGw0hPwfOAtjDW3J5wZuNMF0GkmJUERRwyFkHDKvdjSrsSRsEq3G+7uJ3jPZPve+8pdLVrkeou1BgoxTstlu/waiFi++pR8DHMPormI8xd+UjovS9JaU7MNQ6GG/UXCabP4oTKTCCvRn3CuJ8VsgZW2CQ7EPFb+BNlFcddPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 19:36:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 19:36:49 +0000
Date: Mon, 9 Dec 2024 15:36:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v8 0/6] On-Demand Paging on SoftRoCE
Message-ID: <20241209193648.GF2368570@nvidia.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL1P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 29261b87-e635-4b1d-4d3f-08dd1888d33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n62I10b2gtMAYT1Nrg19ER17Bu5sIqSrnAQH2XToFUe50dvN2byFd8EZaa8G?=
 =?us-ascii?Q?cVZUDpEJHVfh5ZPgcglN3IaPIBJh9WIeA4FoV8S8hpk/zibjxVDb5VOzVqiA?=
 =?us-ascii?Q?7Qhi5nedSBqYN/cK9kPGHUJjusO76BxcwestmcaTX1u2HfQNPOYc274vv2fa?=
 =?us-ascii?Q?MnX8WFa43J+0vweixsE2SWV7MkrgS8IG13OdBzjLyjSNuLMI4uoXUmU65CZV?=
 =?us-ascii?Q?rxnHdHUzMfEbGoD0soP/pLVOmiHE26VgtArOdWU8xHtPhnKIEm8IMHN6DJKR?=
 =?us-ascii?Q?+JO+NEqo8P7O8SWke6fySVa5lWbxERmBhvjaQ9kgLq5JZucavyKKJZwa44UW?=
 =?us-ascii?Q?ETbKiknSrKNawLckiZJ0u2NTsxSxHYLhpNknhY9y2KJVBXb3z3lhqhCxC6fI?=
 =?us-ascii?Q?LP7xU5PvrNwTfPtZv7w294L24PTt2OBaJtT5Q5UJqLwUzACpUg7SjSKocoVa?=
 =?us-ascii?Q?NCMixesEMd9cBt1dyRfUca7phYTWUOiPDImEMWKGlaBOde/ByV+0izRHU+qu?=
 =?us-ascii?Q?Jqw4zn87VkKtF9g/d4qFl4tHYKKjZ30GDilcXzuX2TMvKJ0WamPmJ7+PTK2Z?=
 =?us-ascii?Q?Qfj/hv+NSYuvmyhCpHymyqlf3SttEJ/MbSThxajW5cB6Hh+C1TZnoJ57Mv3L?=
 =?us-ascii?Q?0cq4KV4J9NrwlloSGIVsMH299I6o/IDSA61JUIBQ1RcCyNLWrsHX2Qf4qA8I?=
 =?us-ascii?Q?pEhdSZOhejiqc3wnU43+DqhYZeDgSP2GaIhXtX9KTIZDPV5zy9LpmlO2UL75?=
 =?us-ascii?Q?PI8h4mLV35shQyFiG3soLtt56KlqqnoebwH4z8V2tZfetYg52kHtbe0hE/Dh?=
 =?us-ascii?Q?NWxDewcap55VL3BVvuL8kl/PjCqEoqvkiUvOkk9Ky06iOv3je5rvWXnrwFBx?=
 =?us-ascii?Q?O9QCnnTyxIx219cXKoXUBJOqHZGDCHT3YOZKFO0FDgh8KxCaywVgk/oZYooJ?=
 =?us-ascii?Q?3WLXqQLH4iN1tWJJlVlC0FQ28h2ziEmynXbSZ2cRi3H+G8ch3yK7rReARzZ8?=
 =?us-ascii?Q?tzplkhl/f/2uCi6fDBBKOJPAR1bdxNG8jxkuEjGTM73EOVBUuHNbUUJbRnDw?=
 =?us-ascii?Q?0FnMOoB7+eo/OZJfDpe6YFam5VWIEoQ8WH4hBs0Ei8EuVBPyJo5EZDwPuFk3?=
 =?us-ascii?Q?mngxqW9SfhN/5u2zGvSiZFv4wh/2KomtY7GM+/k9A3MNU1yqAKFYQHnxca3L?=
 =?us-ascii?Q?HkaPShhx6YLfl9h+4z91QE1YEsmu/GQPzT8Rg+qMkY65knKiDQ/6GSrVfb2Z?=
 =?us-ascii?Q?UY7P8wKByNK0bFHsn5tNCZx+8943eOX23484Grik4Phv/uRTEKexCIvPUgCk?=
 =?us-ascii?Q?L19MJYrBNnmLvM6Wdl+3QmX/o4Coa4HJNgAYtB8XTlvJ7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zdssOIO+SGDfKHkD8Cmx9Ji0LSBHnlCm0xbr7oslVslYKG98dyFuiJ3IWwSn?=
 =?us-ascii?Q?DUYvnW96pbsDT9A8fgOcPcxzF4TOFvTOrDGPg7uPibXJivsXYNB4EZWZeJWQ?=
 =?us-ascii?Q?voNn3bLr0PnhhLh/GjPHG1E9SjLjcoGj0hvaoYw+TU8A4m38uuNgA+77JPYf?=
 =?us-ascii?Q?LpWPF5IbPlJ5Ud4Cy8oZSxhfeFGvrlmpdtqaRKbAz2B1IhQsWT89Zq5qu9xf?=
 =?us-ascii?Q?+3NxE3kWFtbcewogoozbKiGNwv6s+sDy7SNbXRJnFO+43giI9jpK16jrhQ9P?=
 =?us-ascii?Q?Mi/YgyW23M49FTocFFp3qTVcp/Y2C2RKq5guE10EGnZY2xN5yVMRJ+XOqKJJ?=
 =?us-ascii?Q?aA0zN1LthT3yX9DMnDSxYltd9yKeqPYPlE33Cw+iUHlG6/R1GN0ubjBkaECI?=
 =?us-ascii?Q?aY6hi0FZv8nRCHzpHKH0XG99hh0SyYS37VgfP8JYBEn6q6AgxklRUTJubau3?=
 =?us-ascii?Q?TRJAY6H8ugjguaCrPld2CiHkUgm4um++9O3JiUGTzBe3c8Ujus4qnEDLj06B?=
 =?us-ascii?Q?x4suZJkoQ7J/KIXcGc8CpbpomMU2tkgLFik+9strpiVxXppIGJ2RcJFptOZe?=
 =?us-ascii?Q?a6MI0X5KwFdUvEmrw2Afd7k/u3RODBHSkWgutHRbgbEbC8KNf6uGzqdXV917?=
 =?us-ascii?Q?Tclpf98uSBggizP93lQEAmNxzHtvtPYa7151XRhr3YX0oR+49i7F3YLr0lBx?=
 =?us-ascii?Q?BZiQXest1TdsZATlLIijfv59CNzCVsU4mN/C2MKcf7iGxuxwowt5OzKLwCjU?=
 =?us-ascii?Q?W0y8a3p/0NFWr8qUSvTV8G7NVcNBlktpJ70TKyjmoouTap8iTCg7YGPjrYfW?=
 =?us-ascii?Q?BUQ78ewFW7li/0ivbzF+xBS2tgxu4hkTEM3hpeB5oyHocvkN+Cy3t+oMv0hP?=
 =?us-ascii?Q?GrI7snnMudxMeIOJcJr2+hXwWSqA1VPH5+zQ5cEQZc9UMoYIcaWGY6rAWKbe?=
 =?us-ascii?Q?sdY7EPoUa+7Yg00U8QH1Ft34Y5kAdzI8+X9bKF5bixGhFUSK37WWeeRSE2gQ?=
 =?us-ascii?Q?Gf5AHzDuOB/SVeRmhd3b/tcM50Jc1cUaUYP4fEsVZeulGQZhWNnsc0X+cocl?=
 =?us-ascii?Q?dKHhHRJG8SoTjPPP2bGVKGZWwQORPUA1GId9Jn4fTHVvj0vQmxcy5igfADeY?=
 =?us-ascii?Q?TJ3s9BsWayoKQ82zfgeui3AjK1WD/BAsY8Ah10yo3pskbdsHEsUNFAQoR64Y?=
 =?us-ascii?Q?hYpdkWRJyJ6Olf512oXCnNOci/+qvh0p0b8w4jKnIBhFyaDPwCshQnjNctHQ?=
 =?us-ascii?Q?AK/QVzw0z+jVMYP4Jr0wKL0S3vzhf1XvNNRyC3xAWTa98+HoK46Jn4j4IOQQ?=
 =?us-ascii?Q?+lnSm0suImDJcJhjVhZqav6beFT9TGec18sAzXP+gha2UCBp+Ibgl5pPVycx?=
 =?us-ascii?Q?M2HeyfDYhwbyp7L9DiNoDcDH1b00hNb3EK6XOz6m3uZJmYFlINJcDddZcq9C?=
 =?us-ascii?Q?uiwC9rFQ6uaE5OvOp7Xn2BsKLIGX/1LwdDnhajk8Nq7vyjDOj4fdqaxkIxJz?=
 =?us-ascii?Q?jk2G+wmHGmzof3Mhe0TC/vuulAvzzik1haAY5tH40as5BN3aDRSa2TTkr8o5?=
 =?us-ascii?Q?ULF58sX/wUfqUeK/GCO1QvHwGgnfL54yLAanqJx/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29261b87-e635-4b1d-4d3f-08dd1888d33d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:36:49.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL9qruE4c5MiFHPps7ll1vwUC0P3O5eQ62w5r7vzEWVXCiyrIqnHJFS2d2IioMXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246

On Wed, Oct 09, 2024 at 10:58:57AM +0900, Daisuke Matsuda wrote:
> This patch series implements the On-Demand Paging feature on SoftRoCE(rxe)
> driver, which has been available only in mlx5 driver[1] so far.

Other than my questions about the xarray vs pfn_list I didn't see
anything worrying about this. If you answer them and respin it I will
apply it in January unless someone who knows rxe points out something
wrong with it - as I really don't know much about rxe.

Thanks,
Jason

