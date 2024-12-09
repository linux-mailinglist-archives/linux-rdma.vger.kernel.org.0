Return-Path: <linux-rdma+bounces-6342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED59E9EEF
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E4C16852E
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7D155345;
	Mon,  9 Dec 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XNfTSQyt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6951233155;
	Mon,  9 Dec 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770900; cv=fail; b=is9CwvrHs+zYQ/nUDdY7S6jv+MhlaJBiLHg6lkXrsdqivwynlGL7v3jYOG6u8q8XmWHbr9TVbcqTRcRsudYY6TuyIaNr7gKp6SklBVal4xA7kr7bZfcEdKE4Zm+lXhvLe2ZAKCfuEobb8piWjXpCZOJKS7ILq7AS8/UAxfiPBqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770900; c=relaxed/simple;
	bh=5wS2tUmLh1y05SFvpsTGXNxp0izMCtvqeRcOu5M7BPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sKOJpCr8aCGE/UyLV/MkCT29OVdb7LKwPT99wYbaBYMz9ifVVLTRw+wCDS0HVZx2Zg3ucmAH1Wt4kZUqNeSQ5ViigamWk/LYWIN9D0VGuHsA0IXCsVnkC0gnsKILq+fsuPN/lpH9N8aorxm8ioQeckMyrE51OAVdKQ7B76y2k0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XNfTSQyt; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmgeDXG6p3BQGBrkqDPnbW/bKg4iBnRYPhf5/y1RL4HL4MPsrF1BVIDB2g34Z3oc6yx987eYg0VY/YX4kD8MsAyTGcu971uDp88Sjb7Yk+I01VP8sWEryXWsPblp+Ctay28Uf3ycK09KZycA+IYHUQ0g1wnotw7wyteaCCt3baci+JuD7vYOUvQHju1q5uCTtvca1D2vkgKmM+z2px0P0piCclupt8UtYeysXm9G317ZS3Wvqfk2nDyxVHh2KPg6sLmx3N1vw1zAMJJSgMdg+pFKY54EDWS2CfmWrSPNKvZpLrnmnOR8+bJ8saUIuJb62ExkAGvpL6Y2J2JvwE0SWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+ygpNrM+OKLF/AhY2invmluCuLKMSMJl2QBYUQy8NU=;
 b=G8YpLuQe4+pK7nPiQBrekaaLvPfxryuPtpo/SiGcc6CUxP2v9jeFLQeWjuziise8dz0jskwb4iw1u7sVflWVKjq/E6EKr0tLwMWc8zsSIPnRhy/61W+zwl8ASePzLHP3R+wrTjNuct57ELfwFXrssi+Z+Xni1AqnJCI0EMMOJMM1jF2HkBhntnrUyFyCO0pME9qQuygL9DGw1lVh04IgXz7YvpKqABCs9oX6gICcamaONBEtnfkZQ1RwfE/HMH8bXeg45c4zdD5KfgCdcYlMEsv7tY5kFL34OHdKoTBmFuO2tlwvWXNfYSg1ZtpA7hN8UvoFPiAVWS8mbUc5OC38QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+ygpNrM+OKLF/AhY2invmluCuLKMSMJl2QBYUQy8NU=;
 b=XNfTSQyti1vvU49zfXeHLR50qpn0HVbEYtIOoq5dIxwrSGs1MG4KpFWvixQ/9kRh24TuZfrytvqc8Jtnhi96rJoeqQD5nB1DOtuoTf47tgzLMw4yxzFn/kiJfvtkIVVgdrpV9IwJywU0RinGCVE3uys4I9oQlwVsGs7Mda1TrYB5PeysxSSkfOoMyxTFtgNkyWeLioNvczKGOmZ9i3r6kzyhk+ITkpl203KXoBVu+lOufrH56+J9AF1n6xJCDz7yPuETEL0iwMciYGFoluo2euRxwfHsP6BUvVv4J//Eq1E8JBIRZ7xgI8eVoLgY3qZ4NP+K1mUoPmOyE9UGfkIoBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 19:01:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 19:01:27 +0000
Date: Mon, 9 Dec 2024 15:01:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Support mmapping reset state to
 userspace
Message-ID: <20241209190125.GA2367762@nvidia.com>
References: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: MN2PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:23a::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c15325-f648-4c66-794c-08dd1883e210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dEsVa4+BN01qC7DXLggDQsrzad1XcCOlhQxzMwgKul2dzAKn/kTcSOhb8+B?=
 =?us-ascii?Q?FiUUs9rVqZb9g4Z0DBpf06SnY2XXIMIPA5boEYKLfSbdmEQxxLzmZqfVCrsP?=
 =?us-ascii?Q?ZXetZXI0XdN8JxVHOBsq/6SczCCAC9qe2jxj7uwqULjGjIQnQyUkSdZvs5xg?=
 =?us-ascii?Q?4P3u/bmTcT+uWLrE8eJ5VgnTDUPYsYfnM7yary5sYaDgE3D4DYtgERBoFd4n?=
 =?us-ascii?Q?BCtDbU9j6D7ck/17cK2MDigIFCYxD0TVKcDg6leVxcEIv0LbiNS8zIH9k92D?=
 =?us-ascii?Q?uRocHNlxkcbef9FCWGYadsUZElgqmWKPwOWz9qCmu9KS6ele0BpfiLDJ6Ffd?=
 =?us-ascii?Q?EgerxTk7BQnswVMjkp4++Rh9JLUBUkYEqSqn32Pncscgpm1+MeyUtsOxlGVA?=
 =?us-ascii?Q?KEy6OQ2JcoimnI/hy7QNmDmounqf9Njl4t6Nb9aZPu5XGin7e08z83JDndpw?=
 =?us-ascii?Q?w5ryMgj9Z8e7EleZko1P3gvgJ/ZRmeH2O9e3rrDUsg5OwziYEb02srfIk86f?=
 =?us-ascii?Q?ojiIa+J7zi2yGv7tL4+qbqt5yOgLtZ1kRwGozZF6zJ8BnD+5x4yl7HitkBU2?=
 =?us-ascii?Q?tqH/yeGUv1TrWRNROgRRezyIMaVCIsRrpw1PIogmuvWgVgM64K33AI7mst7r?=
 =?us-ascii?Q?xy9KE33aICVBpYdWonmKnrAmR/ZgVQLXAzlzEjoUkpnM6oxCf0xsmFaYvl+B?=
 =?us-ascii?Q?YIfWN1AE6Wfm2Me1WKIpN2vMiLfS+kj14nG59QHGHgENEnsTBihpLZJPA/Zq?=
 =?us-ascii?Q?mxmyaSjC+Dd7oYhrl/zszoT3g4ppRL4DOFFkfw4PYX0KlWNqETkf3NDGnFaO?=
 =?us-ascii?Q?Z2VzcGhIYgdtEDELPCInGnYVtUenxZ+JWIpRCLTqGiB8gl9szN3G2ScRavJs?=
 =?us-ascii?Q?En0YjFtbvRe0uomYzWdlUtuaXEHcxztLKdZ0Nqy0tmUKJ3W7offbWC2Y2D87?=
 =?us-ascii?Q?/uprg1KLNvKkut4N/I/j5b+5/VtZ84F6NY76gUCA7M0W/GSgQuvry1fw7WLc?=
 =?us-ascii?Q?+uXs27TDOHcGDAJDYtqsZpWd+sW2WeuCGLUnh8qs8k0imPYKYk6LaOSXWo6V?=
 =?us-ascii?Q?V1hANz87dBMzpABYWPRx6IZ9qhBUD1mio7o2OoPOv9lsJHRB2JlMDb8x46/8?=
 =?us-ascii?Q?Op2R2VHvQ/zTZV5f4fTXABHSsvIgoWt2RsZnJJhMJkFdLExws9DZRU6Hmrfh?=
 =?us-ascii?Q?5sq6hfr8FWUL2Z4CkUGP7elROq1U1yPqCk5KC+Pb7OabLYtvnQL8vPNUHYls?=
 =?us-ascii?Q?7RcR1qD1xH94ZbbDUhUNLE6CTeJDe+pPWba0r7WDiBOdsculqXSI0E3qAhPy?=
 =?us-ascii?Q?1upBEiLrk+pvrfhm1lp1ToWbFJ5Jn+zhrKL+6mL1AteTDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k28cN095yqSrEoVZ4MTc1bpRJIo5OWJvm48t3eEbejkqg46KeHZNTeCPJjaJ?=
 =?us-ascii?Q?WKmEwP2/ADEpd5Cx2rPq/8STwJKs5K+6D/fH1xwdQbVhTRDDjR5je/8mpwgN?=
 =?us-ascii?Q?GKl8zRbGfc5KCQtqBGj97KlkwlN+VbckQgRL64qy6/0DNCO3zxacRGr2naYD?=
 =?us-ascii?Q?VwvTKV9XGh7OwiGJlt1xftfeBLxxgMq1z97yGfSdZHSYXv1yt7yZSLSgAROc?=
 =?us-ascii?Q?LeHmQLfPsDxjHA5qjMnh7d+dLk+lfsDurlfmtaDkn9ZrnppPsqjKKkQPQ6ut?=
 =?us-ascii?Q?VuIscFiYST1bGjwYs+EyVD/DkRYlo2AyoTWTL9fuTE7Tb3gW2oBrriMPGsKC?=
 =?us-ascii?Q?wxeuRU6RhvTDVT2j70oeX/FmkyQq2BWQ44wV3hEZp41/o+BE5sKqoVSVQcIk?=
 =?us-ascii?Q?pace3qeK+7eRJionbs3rV2S2E71NYLNWFDozM4sn/cn9SrJTL/cfvtUFj7Sh?=
 =?us-ascii?Q?ZtLj6ZaOPusMw+WZCkMB2uC1pEvqXiTsayA6s/gkKfVt0a2n6qtzNns6+t3L?=
 =?us-ascii?Q?EK9KMuwR1DKIGjflhxzi0df4f4ecU/5eeEudLnP+vxFaaZH/DU0vO+ghviRX?=
 =?us-ascii?Q?4/ywqvVTDAvyzSjWle/j+NpDIhEmEZE/p7n7s9XlGLY20Jkc0OfEB27P4FOc?=
 =?us-ascii?Q?k683swkcKRQgcIh+r/FBS0E6mmDgvRut2xCJDwNy/JI8liXlm6MvhcvFbfBN?=
 =?us-ascii?Q?RVs9P7hq6K+7k9xZGZMpkuRYbx9y6ucz18QjFtB296vibfaAlzwNeC2gL9I/?=
 =?us-ascii?Q?quNhvfhjx11RQJxit+2h4FTEY7NeEYiDJIUW3ZoOtIYJascUYDYUOIo2k3HA?=
 =?us-ascii?Q?d9IcRqACFkWusNtXH9a33mrvb57R2M24cgN73razRQlbtPaWGzsDlcBlOlbY?=
 =?us-ascii?Q?VehIcnlkS/QJRcseMjXZrKZDIAEzikEUmTFLmb0wSSUTG1bReZuzJUFz1gE0?=
 =?us-ascii?Q?+Zy0T8Jt5gV7HEm9KK9o/x0QrWtBe3Z3uWQH2msYuyHwWlfPP/39WJ9ki/+Q?=
 =?us-ascii?Q?msdLa10abidrJboGcmRH4wuRcFRTDSx/iAMSyYpSO5qOAr1POQLl+MeOqB7N?=
 =?us-ascii?Q?hG5FTGVSjoctFIS786eKyAHb5NJtxDnxnS+7/IEeIc7wFd2hcxMkm3wYdvhk?=
 =?us-ascii?Q?WiloQz3H0VRGv1+3ZpLENLpLVg0YuE8YRsvQYD+Clyabhr23029vVDA/otqG?=
 =?us-ascii?Q?pDhYwVJrbqY8rW36M7ZJGaxkAQ3fYVYm0D2qRsHAYtl2a9G5f85FzWp7lhE3?=
 =?us-ascii?Q?/f8QaVXEVj/FEDroFV1qKMwlf4uNQfo4XuCn0pkVWVoWuB/rlwLqmxcIQz3j?=
 =?us-ascii?Q?L85fe+TmDWGoBRqqAW+f681PXEJxprNEVD/Mp+KszQ+NC0C6+8tLFpm55rl0?=
 =?us-ascii?Q?NfrhMcK1Mh3rXr3m1TLCR3pqVUgx7F7kR5ApAFpljv7RHawfSY63VxnxlPFk?=
 =?us-ascii?Q?r+sMP8RuqcA3aWQkklKqe6bxachYNJfZ50GOt6asTYRIfAaFWw7kdqOj4zLx?=
 =?us-ascii?Q?B19t/5YvBZygKSimnGD/ldV95EfW15TCNnlyWMjZkmt5A2CJ9pYS7qu8yjaV?=
 =?us-ascii?Q?Uzs8KBcoldBD/IkiFmo5KAhZ2qkUwccL6nVYlOaq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c15325-f648-4c66-794c-08dd1883e210
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:01:27.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmYuSgjM5QPvztZvJxN2oyGaSAn2JOcswtXeD4p7LkMtjcwdgtxZ0Se9IAIvvdGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

On Mon, Oct 14, 2024 at 09:07:31PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Mmap reset state to notify userspace about HW reset. The mmaped flag
> hw_ready will be initiated to a non-zero value. When HW is reset,
> the mmap page will be zapped and userspace will get a zero value of
> hw_ready.

This needs alot more explanation about *why* does userspace need this
information and why is hns unique here.

Usually when the HW is reset there are enough existing system calls
that will start failing that a driver should not need to do something
like this.

Jason

