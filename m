Return-Path: <linux-rdma+bounces-9790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE7AA9CA58
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CB6172C42
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14428253957;
	Fri, 25 Apr 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NF3rmXw2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B58253939;
	Fri, 25 Apr 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587775; cv=fail; b=POpRNWuOgbjVr0cIO5EceWzJRoSD0AqJZZ3rGXOru4TBIj3ztd+aaEnGZyWQy6K5rExQTrI9aCPLB0HcNWlfbB3QN9M2ja352f7oaGmLoqjjZZkOPJX8bzDgWlvkImP6GukZPKHwQmIAzH64/qicLc3CtB1d7T6lIitKCnd9kA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587775; c=relaxed/simple;
	bh=v7ttCt3pK+FMsBskIfzZghkwYxKEvgBaEwgTQo5fd2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bVBy+TalGnm2M4waDwI37JmH6lVoqj/etxPy1jSifF4CsCH++1thq/UUUzF4LQTef+t77eSanVVGFA+wp9Ehhdrar/UldL6VtVyw6W3K1xvAwW89Vt++GK03r8xM3CpmJ8dWnHI1MyiQ441U3AvzMBqFIu7ZW+b5FufQz0I4Dzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NF3rmXw2; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQECP+O5kNs1dqI8Z1v4/jO0HQmDTDHjHZSQ6Fopv1C1FcTWXypyG0rku9XO5eZFURr6FQvJOzNy+1kUxAjcOCWaJ84s9yNchrY6ywoijidq0+e+h5ICsolPF9qAahVJZwaD4suqCgaAAKKz83Ji1EJAmNeSVl/WxflDsb8EX0ypVc3klUqHroEANV7AtxuCYdo2klfhgAkZirrmD8KymC/GRzQp0ZL3l943/IW7DmIlMXlpr3kdZmCf6Igkk+40aDAdCTZImpvmTZeG78NH9O3kmDajNKX2JaF/7AqlO35BPdgeVMrBAtBg6LPRdZEqnB0oyPZ8f3cdyNK0Tl/kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXpF8iMJFyqgJhMVDQC3jii/a0taSDY5/9gRJTzeISQ=;
 b=r1vNTq19u7RkHEjNYVMMtRQLNHG2Fyvx31iYxByu/o39givtd0eMd3jspgpxthMJv0DCGkK2l/RiRD9WQxmEbrOlAZKPHD+jFXXxxDV3jw2dF72zaWuihMSvoiY8dZF0E2MnZCFsKTKAJmBrMdta3lgd6C1UzEgN775BTW3yZNaCxXbAYuwjn5ywsujP3Nd8JAFdcS7ozOgQXpO0A8i5rZB1whP5xYOlwNDGyMZ4gQZbsT+dzedXQPnQHucwxtInCTxqD3SqBJXQ6IOcaC4sHCwq4MNwa+Yi1ARi0EqHWo8L+TIiZBxMjW82Wq8wehrClnYCC9N/FFyAX4Y/bcvRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXpF8iMJFyqgJhMVDQC3jii/a0taSDY5/9gRJTzeISQ=;
 b=NF3rmXw2hY8nJE3BCA0TTlrST3AttDV5YY8gmmckuq4XRBk3I9L8Ct+tUNJXlVadBIngd/YLQMIzdYUL6GMFs02mp+VZAmaTM+dAzu56epuor0oA3aE/celAEVKzij5FINhRbsdFO1wjUjkftvEjtMhxjU4/WHDw2h5ZHmxcXtmnmu6mGfMSKwkIjw3bvwW59YKoO8PukuuxZIKJy+wUxEMhYVawH/NWxMzwp0yKkjG4C8igP2MnEdyB8yKqOHsocpmYVm/xZMAUH/gsPutqxJ5c/9A7zouO5SUSiK2ZXTUPo5rSA0/fRjL8PGz/dHWBtHfp+Vlv8PfKjtgnOKq3Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Fri, 25 Apr
 2025 13:29:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 13:29:31 +0000
Date: Fri, 25 Apr 2025 10:29:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425132930.GB1804142@nvidia.com>
References: <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: de39dd2d-99e5-4d6b-5b3e-08dd83fd35cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBnKl7j6UhByLZ+s4GcHTslgWbvsWWaEsPlI5QlPwz4j+HLtQyYWWiTN++6j?=
 =?us-ascii?Q?EUcTzy4A3YoFujZz+o9xUrjtxXbmmvTTs2TtF/l6TxsjQfoxhBEvCjOLdDE0?=
 =?us-ascii?Q?WQm87BBPT4J/9eeHGSzoyuSE+DXtfyCtn2MqFAK1iaQ6xMPrRGnmvDEL7f0n?=
 =?us-ascii?Q?ubW+mu1VblpXUe6mSUOQ045jVQ8Z5ITHRQJ/MUCDMwI5vvIW9VsKPW6fJ/dN?=
 =?us-ascii?Q?ZFp+C/6yi7n5V4ibomHrP/mzAfu21oVoMJ2CwKEVGxr7D/6LesnVKTmcHqOI?=
 =?us-ascii?Q?nswZQZm20QS51IrUNeDI74coNpcS110RhrlMN64mfz47ABIYwKhFB8IpSDrQ?=
 =?us-ascii?Q?nEsfqdAmxwS62ROT8l8moDrZRbV1X3/Qo6yWQshgl4wDp+YYIQUlj3DHaxS3?=
 =?us-ascii?Q?0rWZMhYYhs8MOHDIecXZ5FUVN1rsM1eOO3zFkFPqMX13Lz1ZXhXKdRZMOeeq?=
 =?us-ascii?Q?LFSG9m6mZi23odgi7ix3qZNOKZ1wzpbJ2zO0IRvaF5ftfXW7Gh+HZ1Z6mTh6?=
 =?us-ascii?Q?oi66UWLTHPtrbOUschAH1CIWeKPaY8nJPTqM4hutzZHUgXOHS2mJ1EGHw2Xx?=
 =?us-ascii?Q?P2MIcRd2dCYlsa2Z4iiwOCrkNwvNHeIMSAOee6fg2XVAxXt7BNZyx4j27Eug?=
 =?us-ascii?Q?XWKsmH6JbUp5igbKDo8MmH4Fvpj+he29WEntaug40QI5ahR388yhpPXiO/U/?=
 =?us-ascii?Q?1vp4SD7Jj96yIqr3OQM89rJVPUIoG12ZioVsrIrIaidpQ3bUNKZDop/hdeDv?=
 =?us-ascii?Q?dWW9aaNTapmKIK13yy1axC9SHRiriGkJakRbH58u+ooO5iCO9qsuN35hGMTa?=
 =?us-ascii?Q?Ncw74fug8EIPEN0mvcfi4hVfUlQtulLpyTJCXdfR9lEU1QjAZ5NFdINu44aa?=
 =?us-ascii?Q?LxkZ7+gOFDyNLcXyu222JZFkdAJ5Xkh71bbu4APOMVDWnjQMYaQJbWjhVDcd?=
 =?us-ascii?Q?HTsyGzi6PfbnlQorc5BfRfZ+Db4zgv52DsowAE5wKWX7G4DFz/mLx0coPFI4?=
 =?us-ascii?Q?7N/Fo/lxp7fiWuiXe1qYgCQJ+ttN/qveu9oqMFkiF19r6LFMnTrEJ05SnM14?=
 =?us-ascii?Q?KMVqbmod4YsYlxGgyeEoqBApSM7cBVknQx3dKhBdZvm1YRoeMtkjf1Oxlzn7?=
 =?us-ascii?Q?cez8jw4hf+5vu7vvRSbwGfRLdT+u6SrrVD8DePnRIE7hG8VolrC/AsWeKkgx?=
 =?us-ascii?Q?Z6z1lS4l/0Y8DVLj7yPXDFOrQghIyzZVWQPc6yRTfMu/bRoGtlNlFoMV08H4?=
 =?us-ascii?Q?9riRmW4LoVXZf3DCrOfr1o/FA6OFKoRzVwckKbqvNqmAsJFEicYeiCX3JtJd?=
 =?us-ascii?Q?kx4ccxQH3P0E8zhed7IhHoGUIInO8kXMatZMKpoZEFWGrDeJ9wso8wyOjcKU?=
 =?us-ascii?Q?/POdYuOG/q0aGRjOhY5DOsm33mWIZIAdGe+0u7ihOxj25F819YqFKaCJKyWO?=
 =?us-ascii?Q?9ZthnxzPHhk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcqf04uYFYEtdWZzeJIogu7ysegx67eZkVH2o81BVUTxv+vjoU84wMQqS0Wn?=
 =?us-ascii?Q?uYgy5jhRZKpPxXfkPprdeuMARLF03yzlVPzFAnK+Jn6WggQwnRUJ+un2gHgf?=
 =?us-ascii?Q?4vjx4QT3tsITbPndh+SNTlmVgAiX18ikyf9YDRVn3U+/t2wzR+Il/aCCcPZN?=
 =?us-ascii?Q?uUmZPOvOCuJ1/pwBduEAF4fR579B9IPIiPG26PjjgUdHI6tpHQEdcDwVEnV2?=
 =?us-ascii?Q?jJBVxeIIRm/OBAoQsV8zJiyB1IeeRPhG8P5xAvt156iC2xeBuPU/XzBseK4c?=
 =?us-ascii?Q?xgNqOYBNV+b04dpCgTxbHg28yC3P4gnZREgqLMfICt/Ml51mRACyIpWIFKM2?=
 =?us-ascii?Q?FtzYvQZ4+YpHMnMqrfG03jLjvum0UhP0nXvjGPDFcU19mLcZIQYhgvN2ucSG?=
 =?us-ascii?Q?UTOghNlS3+RM7j/j7aFq/uf/bKz5A7Q1r8bQthNI+mjcp0N3wWCylHxVxfTi?=
 =?us-ascii?Q?nZh47h41Y09OjczubnGXJvaXl5gCLHIoDATA/gxrJAVZhp20871eM008ZqVO?=
 =?us-ascii?Q?iJs01+nY2tgXvcM8KRZOzLAOgA3Jr7dAKf8hsAKDC0ph3ihPVGEnWhhHG0Uv?=
 =?us-ascii?Q?QOdHvBj+aXoNWHgmf5L/Rrn5/yYGK6YJ7RyuqtXHdSdjHuLCaWZ7nRdZjXHD?=
 =?us-ascii?Q?DlsTFYphq4jsTHHi9JxahNx5MuDh/bYnuUqxcVM/DSnge2h0ny1yvq3nDvxi?=
 =?us-ascii?Q?+x1bF1bPPfBaVzw7mryPugJUahCW7eB1Jcsz0jBFc9yZEhQ8xaX4lYeJV02Y?=
 =?us-ascii?Q?nCGSYJy7N71VCWl8qOajPlBESg9mCVnu65yGmoNG9J7U3v50rDJX/miYhFw0?=
 =?us-ascii?Q?BqO5bCcD/+7e8cU9ShFhZnIXQu8N1XVt9IhaYxhtPR2z/NEzuU9VlHzrCh9U?=
 =?us-ascii?Q?gMPCXyq4uZ5wIFcw39+kOOcfWJKuATd5J6uOI8c72V4fena1Nw1I/LCJSWx7?=
 =?us-ascii?Q?j4HBWh27sGUSUslWVTaj80EWtbtUxKotItuD8BIkAdpcakZTOxhX6ilbo8Qj?=
 =?us-ascii?Q?bQpW0Gz8z0R9nH/slMkXpXFoYZj/F5wRS4oXmxkVqV0/W6pxvvQ78yQZD3FD?=
 =?us-ascii?Q?2FvrLEuIbfKMJaPvpuKGb4RK3zQLzqyxSjrNfekbhTzC3uI6e2NajAqGuXBI?=
 =?us-ascii?Q?mnFpJlPw61Fxf7i0AU0Jp5bVK1SN2WFq68u6hmECB/njmsnaxET60fGnS7Yf?=
 =?us-ascii?Q?F9mwl5Xj5z425/e5DJaHf7OAPf4s7znTBOj4UsFh3qrifhkrq2GW+CkeQs2m?=
 =?us-ascii?Q?1Q+1+t36VKmOKUniJMqfxGW7cQh/vUxjOICsNjSfT5sPdXqv8jomDcjsEL6S?=
 =?us-ascii?Q?OZNDQ2NrzFtORRzcRevXLDm6nAfL00KVWR6jPHM886NF2ZdFZXwTKddJrYNp?=
 =?us-ascii?Q?0evdsvL9cgvvg80ODYLioLUQ/ahJKDNnfpGR8uzIthe67YNH1KYDMbrX6+ng?=
 =?us-ascii?Q?izBZ/Ek6AMDgdD0L+xFjNGWIrrxQIPOqPqU53W/vwK5IFwWZh2gHKEf4E7TR?=
 =?us-ascii?Q?NH4QtzIcWoHe88uWooCZpZNClFmgK3/ASiby9bQE5nVJkCKX1Ta29ZA7kIGO?=
 =?us-ascii?Q?whBkSvcJo/lgmfuDRjBAOpQ1EoIetEHM7xGdiGsk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de39dd2d-99e5-4d6b-5b3e-08dd83fd35cf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 13:29:31.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLc6RT4YASpCUa80Stiiud9bS/QgB+sKRoHaQewlKS1HuhIZ8qz6AUUHIHz9rsne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588

On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:

> 1. In uobject creation syscall, I will add the check current->nsproxy->net->user_ns capability using ns_capable().
> And we don't hold any reference for user ns.

This is the thing that makes my head ache.. Is that really the right
way to get the user_ns of current? Is it possible that current has
multiple user_ns's? We are picking nsproxy because ib_dev has a net
namespace affiliation?

> This will be only done for the selected objects who need cap enforcement.
> Can we proceed with this for user ns cap enforcement?
> 
> 2. For net ns protection in exclusive mode, few enforcements to be done for 
> ib device modify_qp, sysfs, gid query. This will be a separate, unrelated patch(es) to user ns.
> 
> 3. Do not enforce things in shared net ns mode.
> 
> For #1 and #2, will send two different patch set.
> 
> Does this path look ok?

Yes

Jason

