Return-Path: <linux-rdma+bounces-2139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C08B5768
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2024 14:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B1B1C2033D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2024 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755165338D;
	Mon, 29 Apr 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9Bc/PsW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D26524D9
	for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392409; cv=fail; b=cxm3+lnbu+bRL+a6uRzH8bhK6g63uGzdlK4lBICBJgESmzAQsy8EY6xnZl7LRg1NY4jKAII80mhSlPRyDrg1q8Q55Yp2Jgw7ACejsNslh5eAQPdWFOAaDmhI1VJ0ne50kQzFYcGbOAnTyDzyZAc0Qlvu/NLIo5Z6pYmf01fNjUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392409; c=relaxed/simple;
	bh=afqVFg4uHyDQJtPdRv4ZPUPPyG5XgY4gOzxy8+31aNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qtlt3z2ufU9dsbwlM1ohw1NUifzcsqYMgFfqlXMVQzEi2KcMIYd/RJvV6dkf0R/vuG2W6m+GfaUGiMGT1jfX/M+kYOtRydz0n2q8fVeKVbirS9zKMWmkHfFFURgH0Fq7TUufbONhrEOkJdqjzU9EC0i/m4hrqH+UfLw6wcNBYGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9Bc/PsW; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTmG02g3tYaN+JAiphTh2CSfOb1TfdtsZ2rYlMWQ2QeLTGiBpc1fOek8aIktzGDSzuOixuY2NK5DuM5Sj7VjH8ThDNsKQMaBMiPQEt4ehFLcM3m/3RRe1+sbmlxXX52Dqqjuep7xHRnzAh240DwS5BQ4+Rq/uAu+uEHOVMFPryPwes8XtEcaHJ+N1dI8fCfjpHykyZ+/qqno6HanCbzhlCal/yy4mRjP9l6QlTcizbrfkiKKBhvTXJ4LfnSy90G45DcC3vTbHjXNJDgxIpAF9nQgtlQrWxtv9mzWxyiyRau+Cp5dLQoz5R99B6TdVYKOIGb3uPJfhKZhakh1hDJjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMs9ILtUUxcTiO9pqwub52ND0YSoKxy7E/HjV+gqJ3c=;
 b=j/ZMVGwJCel0HgEnokb9JUpNqxf39gJ7wy6NTuAesL2MdfHyju95MFCvLbFGovC7j13lNQWrvdUs+FsQ9MUR7o28CVTa4yU44nmMsn8EfessBe1wwpsEqC6/ASrsRVRikLBx3LeareP80X1H+7nt6ldbGN7vMEFrEWk0PgfacmtnAHkHnm9HkP+KAzmJeMU3O46NpblDx0Jt/KL3mGVzeGV22iDw0h0DgBg5rbqYJt461a0wmLhxAKMOaGcbKhGgkgw/k8T0GZOJen+qtwProxhPs3VqsIBWPaO3/ILaYhCvXGGS9zium1yFDj76YS6XpXMagEo57gxMoVQf79qK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMs9ILtUUxcTiO9pqwub52ND0YSoKxy7E/HjV+gqJ3c=;
 b=n9Bc/PsWkX+eY/uYqII9T3WSL/EsbE8wJ6gc/k00vnXhT81zlfywawiIfnw4CYdFsx35rI8230V3JHuw835mwXfaNO3fK/H/xybqFl4WI2axbuGCRNYmHBL4fvONqEWxQXrwtXVufZhwgWYkd26R9P+9bTzAxzT/6vihHjAFOyKU/FTDyGq0agmybFCSz7iLDj3kJ1uUjB0eKlzkiGPia/QnMmvofcSB2riSboQc8xaKjaEBErpP37qNQ/udP3ZLSuZFwKxFaWUyZjSRYgpQuHJOVMkYgBcqzPRfYbVQi7xY71nZ7PyVVhAK0UlG3MJN2kp5V9YqRCUoyaS2M293aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:06:42 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:06:42 +0000
Date: Mon, 29 Apr 2024 09:06:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev, ltao@redhat.com,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-rc v2] RDMA/efa: Add shutdown notifier
Message-ID: <20240429120640.GA188339@nvidia.com>
References: <6bafebb9-0b2c-42c2-ae9c-851e8499d5d9@linux.dev>
 <20240425171814.25216-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425171814.25216-1-mrgolin@amazon.com>
X-ClientProxiedBy: MN2PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:208:23d::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c877220-ee3b-4b8b-3e3d-08dc6844d4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kZIt2vu0qanbk5MWzHs+RQoBGf03V8uDyAwbAdoWRwIipQIfk6YkuyZIiCyT?=
 =?us-ascii?Q?pFCWMdfmO7PLzJ4mMzLQu/1ShveoAe4QrfXVa6d8oaVxCjC75VkrRQA0ACit?=
 =?us-ascii?Q?56R3bf6SZPZiDwPqKDoH44W3aY3wQcuWDFwm4YaEeq03ytcSlBdd1HJ55X/R?=
 =?us-ascii?Q?q3OcCcyKjRqiTJ5lOC8hy4AuMOmH5BAfV30kuBjr/0jQuOQMvXLgPBDwoSDU?=
 =?us-ascii?Q?76ON6Vb9JHghEpjqwy0MGjpGnTRt19wmLHGTP8OOENbHfhzeoHb364MoTCVD?=
 =?us-ascii?Q?rc2NhGMLwq9KQjJ/Iew5jiaMqaJyodpiXpBh57YReMEnQlSaVZXqoIl4767I?=
 =?us-ascii?Q?0iAC5xiuEFJzyu5qXlAz3DBC1C3rv7h1bzZ/JXbimlWgkaMyMsTzqkFMtQDI?=
 =?us-ascii?Q?8qW7lLz36B/CjwYEbZjsJAjSPWFJfWWdFGHx59Mhh5HO8ssZWCWTLJD3r57o?=
 =?us-ascii?Q?da+Y513uNbUatMvueHHqNthahFFqh/5Ro7Gu1Zu1pjk8bz6039hgLR7eL39L?=
 =?us-ascii?Q?AqhTC+Vp1H4dMvn81zMCtuCih51qU8HoSbPivgC68N1Fa0kL6+IzPKIj6rqt?=
 =?us-ascii?Q?mVzBLq54jY3zu4eh5X0W49sgPpg/dR5bp02j8eo7sZ6FLZgf6DhWxma191FF?=
 =?us-ascii?Q?xD7QeJ3bNch633JSLq3fLMumenmYl0lu+DX0E2xzWL/YSSJpGF+yASUrJZ6U?=
 =?us-ascii?Q?oMlb/D++r0AHlrrrqAWjqkbS1mKvN/6EN6eteqE+RSk2GT93NgyLy0lENBml?=
 =?us-ascii?Q?qwHFzl30KQ8mIOAFeylk8g04bDPb2BnNUH8czIIKErZ5kTljiJZhnx8W18aB?=
 =?us-ascii?Q?Sejy9bEMQWEbf4sWZkjNCcADvN730ahs2ZDGOhsIImfQnsS9oq5wn5wX1qeZ?=
 =?us-ascii?Q?qgOyMF3zF4cSQYPB4Uup+TXJQWbaTho/+lkeOvDkIYlyoMm/8JDN10gPNrBL?=
 =?us-ascii?Q?tjfH1ny+YZaercGZuVKsmeOmv7+IQVtdSg8XwAxmC/CUFhwMtbRLGslMVklv?=
 =?us-ascii?Q?1JldeRghvPKw422XKUHOa/yk0Y333bzNLdfqWsIKnnWK6R8ALizOU8TtegXI?=
 =?us-ascii?Q?0ykR93P0P3RirVws7a1X4pfpYl2jyvKM6GIo3PyRA1GVrSjS81p5QsDeuTE2?=
 =?us-ascii?Q?JIfs3FkpivSPJhWNsJ1Z60AwL/NZPWZK3tHm6aPUGfRAZ2iFjo8dg23qzig0?=
 =?us-ascii?Q?jWa+bBdd9EXMV1UudfQb4knCJMHoE+fJzKeKegDSRbxlytkp9fgbukdwq+Xb?=
 =?us-ascii?Q?LjMMrxCCvfGE58w+zVZfI9jWcq52yeXcwVWFZzrG1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WKklaRnGZi533i5Wb3WXwBwxKdlwboodfAo6BxKlah03U7y/2fprXS4QU1fc?=
 =?us-ascii?Q?nssYszccw0Hiwy4wnrN2DuhyScTLfUyEIV6FzJNRYSR1wT/dfXar46QLGYIF?=
 =?us-ascii?Q?4IG7rkEDJNEVm1VNKFERAsFB42at9apJjyqQroLlvb47Src8gbTKo8G0Rbku?=
 =?us-ascii?Q?xGDLGr/L52sXEHAVAgNMBKEY5/0U/Us0xj6uF5yYaUCrFEoWfdZcjamoRhsv?=
 =?us-ascii?Q?IplRHKfE1PkbJ32h+S/NLXAvBS7r6MbUUPw6Lq5Gvlyex+D04TFWXH8wsOY8?=
 =?us-ascii?Q?tpnSSFZQ3EU9FAwxIxtS3T3d37pdYE27DRpOgkURKBtzs18rr6W7iHD+JkFZ?=
 =?us-ascii?Q?hivcBoPh6dGiAx0YAOnU+8HISn3sb9+tqLRQrKB7BRRxUaU6cXLya0uQtWiR?=
 =?us-ascii?Q?w3hIwAKS/4CBxYyp/U9E2oGFRs7KJHMUYZPKUfyTsAC7otvdMBJah22/GJCG?=
 =?us-ascii?Q?+UP+cU0toJVsQs+geqxwsi3pvkr5F6aoDys9MPbdmdLfLWcoEQh2mUdwchRb?=
 =?us-ascii?Q?exDO+LbDuFmfxThppzKkcLdnpfo9Nh2f/3NwpTJQ7DYK35kZ9GQ83YYgctBl?=
 =?us-ascii?Q?+VmIQZtvBn+K8AaNvn8/ViMswceCBaEcI63UcdEi4Em5jgNioGysY3RN9Xg2?=
 =?us-ascii?Q?3Hl+pqz6iXtme5LdcKXEVS9ESCZZGYFOH1vA/eXXJtj4TXDQv2+JPLD1ZanK?=
 =?us-ascii?Q?guNVv/Ax/M5L+B+MQgf8BFI6s+sDmH4LTr1//jgbupICh/IFFmPlfv6eyDic?=
 =?us-ascii?Q?rSoOXvPb6BJQ3NpHMDlkzklCyJb0VknJG7Aqle0WpNwxAVLgIB4CAo/dd2f+?=
 =?us-ascii?Q?BgtFSt2kseRwsEoemlxvoOdnEVKpX7uPxIL5EQk6lu5xevIYsWC8FjwvpN6W?=
 =?us-ascii?Q?lSjQOC0bFkBmjfltNBdTp5HpBqfX7v2SLTK+9xQ8NN5CcZUBW3lHVgRn0Rrf?=
 =?us-ascii?Q?b+HbDtEJ4LqOytrtwY0Ms9O1NmJDsEjOHrfmvcNxGuWr5FfFJY2n+SgJvl0p?=
 =?us-ascii?Q?4vAsqJUjOS/JWgDjCYn+NVs8fIPeWeNenfXeJ3Am7/wiCd5ceJWZ1lg9Z799?=
 =?us-ascii?Q?XEF9MF5n+TWAsk9+kd5cvpM/CoxmQKBy4CBlUdivmkkVXix8GFIXxjHlU9Bq?=
 =?us-ascii?Q?7RvhViRq0d19Kb4lH+/H19F6wTTz+OBicH+MxkvfEa2JScdOB17B5GurNSzL?=
 =?us-ascii?Q?NlSQdGHRotADuWFvYLnmvZwkv6pfl4HvN4CW4tqo3+U1BAnJStX5nj8d0ZPB?=
 =?us-ascii?Q?QVMPqmKe52J2S35PFthxX0p7BdGIh3fGFyIFunBECHRsF5+3zkk+N+gCpqw5?=
 =?us-ascii?Q?nOUhpVFx+h3QJUk8dcElQDexC3fNw6hmsc17o5Sm8avH4ho0bQ8g76dX1TLe?=
 =?us-ascii?Q?q2tT0j244CynvWZuG1eGLRsfa7/P2eVuMWfcIp4NX4GolkAQQeTOJbQhsqeB?=
 =?us-ascii?Q?cD0KMQ8Ml8SneVul872NTSMx8/lue4mlV0PCDTJjlh81AJKIYyzLZhH2mV3A?=
 =?us-ascii?Q?JfxlN5fPef1uPFyi0o0qMubGg2yTL2FE3kd+S6301fUj3vBNFIAntdLruOXs?=
 =?us-ascii?Q?vAfvdrZHqr/5p02V/+M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c877220-ee3b-4b8b-3e3d-08dc6844d4e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:06:42.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9WMVTYdfErbj0kQ2QxJHs5P3RqM8pQy9dsKTgAzm25CCQorFs66VfKhIeBG/4wl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

On Thu, Apr 25, 2024 at 05:18:14PM +0000, Michael Margolin wrote:
> Add driver function to stop the device and release any active IRQs as
> preparation for shutdown. This should fix issues caused by unexpected AQ
> interrupts when booting kernel using kexec and possible data integrity
> issues when the system is being shutdown during traffic.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied to for-next

Jason

