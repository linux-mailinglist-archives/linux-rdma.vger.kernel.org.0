Return-Path: <linux-rdma+bounces-8784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AF6A67431
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 13:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817343B01F0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CDC20C029;
	Tue, 18 Mar 2025 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nmH0WseZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E97464;
	Tue, 18 Mar 2025 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301900; cv=fail; b=Q11I8bdcH4uOANHNLTpChNaYaywAoY0YXwFZhjgojjUjlcFqsVtFRQbXm6SO8QhMJoJoNDl/srbnRQxIDU4A3zByMl2f6HBRyhBZQJVEikoQUYqqnqRuVsByQvLEjUogNckKBZxcRo3S0nF1npLX1q4fBUInJi/CAdU/S9VFxn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301900; c=relaxed/simple;
	bh=c2Pt3jZdc20bUeF8stKx1k1Cwg3rZLuIc55hHGxMKjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Txh4j90mwetFIk61DDQxk7XDmyeDTHy+NMjlmDc4amVbvOuYgvhpOOy4aMMQIfKr7ralz4ERWuDhn3Ymc98aZrmIvEB0fp4S7VzaFX8q2FJaRoBmlzph5xgvsxmX1vFIV31E44JGBNNZo9hnBxATVdKHHCuiIQsL/UJbQJDf1lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nmH0WseZ; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgLiU+FJr2xdrWJofX/yV8G9VbuXcWOVh8tKEbcoLhS6XsHd8K77BPQAudUbsvL7zENgSryygei2GLxRBR+xLJnMfpAEnuqXijmfJ0RDc7carND4R43WNMsfRLhcT0ubdzSQgw/RtLqc2yEhcaWtOalGQdBjA6W0jO29Kp1VMXnKlWUOqVWfBkP1EBe/qjl6IDX5ClkhkQNu1LlkK9hDzCgyAaQx7FThA4XMGt2WftACpr3CJ3+yEe7eDQT7CAJV3urxi9jkdK4sjXevAFawR/rAxMwbplAV6tB2NqSR6SrzMlL+Tbl8xc5pw0RAyJv1mBGbSx7mHqZa4VMMhHBPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejXTaiPEMaeatoACiSWpFM8o0DgYS5GbRCmA5D0VqNY=;
 b=DZY0MJLO8XCUqqRMfQjLvB99UzcoPDLxHpaBqSOnvvrsjtXJWWeY0xHiceihnqCkQPKj85KrWvxgRQphGE8h+f8c3JBGyhVPVQTlgI2gPUOn6OjRTcfxWip6YWbf9d4QBj7ekHLhlDjj4SAf0SEG1AZnOYMJgMBuk38OJSuKVwO7SnuNJY77F127tyfMk29f9jfAYmnSXgNCxzIE8mn5TVCetMj1NKHAKPTA5J4V/hajpTmnlOTu295RgQOEeKGc1mUxGgS9yXLfAS0XaKLqF3S/pyKfbPoAvcgta3iLdxLRE9lj3JOCyISwfxLfYczhIzJ6Kt75PX9gdo1rfuuV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejXTaiPEMaeatoACiSWpFM8o0DgYS5GbRCmA5D0VqNY=;
 b=nmH0WseZf7Udb9x9Dx+34rQ5zA2vjvV61J42M8zVNge8JzM+Mr2zTqTqtz4bp7UBd6bCNYdQFCDbO6NfzZjvrv73U5efy1qCGst0KMEYq0WZ/vgKwqsDJ1qBuJRUi2ekIiU9pU1Pl+PUcANMIBincu1fTGxte1I2smAfPBv9epYxZYKuG1Qe1yoZl8iFaRE0kdsXRSfZ6Qpkvg3gffXshmdxwU8uX43zjmzNB/vaVdGXiUcbl8u+qKNfwiJlAK9hAFVQ2m+6qgwDAqrbk4JXjAXg7X8PEsOWQDkN40ZvHNyxGDos5WHU1N67S+AnC+QG2A71IcfdJC8DMVviasQb7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:44:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:44:53 +0000
Date: Tue, 18 Mar 2025 09:44:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"serge@hallyn.com" <serge@hallyn.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250318124452.GO9311@nvidia.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <CY8PR12MB71958550549E3F0F016952B2DCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71958550549E3F0F016952B2DCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:208:134::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b22863c-eda6-46fd-68f5-08dd661aadeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IRlOWRd0Hd/vtJfRf8ZduoHFdwqmQ39v5J/2Py81swokpiKoy2O9D6LWBAB+?=
 =?us-ascii?Q?Bn+veRkEVjOqwhIz3oNorHtVNT7n4Plbhmc1tomMOjsJHwI2fecmqztkcsuM?=
 =?us-ascii?Q?b2ii3HSANNGHCXjECgQ8EzmzpP1ofUmaspwYDvxGzEppmsZlsiKLzF+Ho37B?=
 =?us-ascii?Q?L+PkhLBQiXqNbF/6Zm8wUMhIkggZUYYMu07cw90/HrXwZ4FqyjcLW1akvcfR?=
 =?us-ascii?Q?Xeyu+6avdRkRgb6Mr7QmjMl0kmGsS3Iy87XdMvlseFL+tGurT2gyGN5MBXrz?=
 =?us-ascii?Q?4dcK+fp5K7aTSFYZNmFKWqUVk4qATXuWj9GvRKBtREo+x35jbjOu0OA1hOT6?=
 =?us-ascii?Q?umSitHHvMWUY9BbwSfgWeGgb9nk9VVDsIQPtk3Vy9sJFABU2f/kjemSPa56r?=
 =?us-ascii?Q?ivMMdRkABHY2HolrD+AVroGOvHlIdM9Vc0XEL/sjYcEpuWey5E3m7Fe3G6sB?=
 =?us-ascii?Q?fXjZw7xcTPUbamTmDT0D3M8VorqGAlvm8+FjjKk8m29lKqNzOi3Pt/klJXAp?=
 =?us-ascii?Q?MXeKBenOlFIz2mdRYuEK/lcFvostubxNaHvdAYtv+aJVeL/K/oLZ/v7oLo/c?=
 =?us-ascii?Q?C8jdb/FXmgJr8vU80dk0P0SD6sA8jmjmRZzPlGqEhOtz/B1Uz+COS6hju3W4?=
 =?us-ascii?Q?QUFuVcoyyChIJCRpelpv/ayElztFCCIT8IGui0yHcTRwK8aVbFaMqripz0oD?=
 =?us-ascii?Q?C/dyIaJ0eZoBK2CrX7gfV4f2K1UrKGK9PxcmJGrqdJ9C0ikNjND1+23p0p+r?=
 =?us-ascii?Q?i3/ZqFBsm/c4GfdptMYWHfVFJHeD9G/g7Dbs3gd1yLD+09CUM/9yWeEm038L?=
 =?us-ascii?Q?pEXomSLA+wQGfYCe2ekbY+IRM5U9WWYb9rsKHW3cOqx70YDnhKvU5BeFWCw0?=
 =?us-ascii?Q?sbKY5WQwjt+THhGpO/DH6aeA0zjgRw5RgZ34WeT7EfweKg33RD6j1d09DEV+?=
 =?us-ascii?Q?9NKQ+bSD8Ahffu7ICNu2w/mxVWQdqiSxZdk8vwp8l1Wc70WLB1zPbH9SI7ut?=
 =?us-ascii?Q?f3oBUPHkOp2sq/QteX1RtoEzHUCY6978luVYdE8/Wk+X+mzbGWEkEQcoh78U?=
 =?us-ascii?Q?od5HPB3Zyp74YPGdZ4jCx2X/MIeRYifWchv+Kck8RTNFwdKyvw3TMvdh3+D1?=
 =?us-ascii?Q?qt4kIXhV/F64DoHqlPtGuYHiSowQddW1e5I6GiZsRMisfWnzz1gDnC0aElh8?=
 =?us-ascii?Q?xUm/5oPl5FqxFCH7vWS/QAUh2z/G0ov5dtUfkqik6GEBwaANyjzNQdIIsK7u?=
 =?us-ascii?Q?ZAMrLwf++rDqooLeFw4g4q1I+nmD/Qk0ep533IbNtohLsg1/Xi2NubdlAP7q?=
 =?us-ascii?Q?myCtlVv1kV/YnA8QFzxGKPQwHrdQyKU+w8P61bmmjAHAw/3+ZGXXZNtnJIfd?=
 =?us-ascii?Q?jD61pyXWhM1mRvFFim17s/qvKkUd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ms5S87nn8rtqWvyfd3ij1YaedDskz4CjmUDN+QeBJaRHVbSFIwfME22OpThu?=
 =?us-ascii?Q?qEW2lCvCtBt4K3SdWiNmIlSCduE7buZY0tiSjVINSXNe8M7MvwSU+V6AXu57?=
 =?us-ascii?Q?Z/QaF1Dq8oev4L2iaWyuyWqaVCueFWfFB0yifbUSBb80rUm7nn0GhuX50oAg?=
 =?us-ascii?Q?FRpNd/C2UM0cfaa/6OrAgxr1XGaSrK4kEzj3Y64sAwX2FvcI19MD4ywvs57T?=
 =?us-ascii?Q?sZkg14ZCeHa1yrV+Y9KR/FMOG3ryXnhu2qgKeXAfmymIyY8qfnH+Cj9In5E+?=
 =?us-ascii?Q?L/hfhuRDZGPmMXK1W72HKtMuBEDQYOSjo0/xBIlLJJmUuIEsOCNkV3GJcAEa?=
 =?us-ascii?Q?+SBHvNjiezUaV0jvPCNfzoWaYr3ZHXELJwo7qpkOfiIscb2oRifRjK4PsH7X?=
 =?us-ascii?Q?VIJVI3lUH+aCd/gkX00+bR/0bGnXNHu+PVc1y2ZhNyVWfkJRiXU2UaT7TSvB?=
 =?us-ascii?Q?68Ca3aowUtB9bvus9BYQTuBau+EqZx6LrPwbzwhkQ7PiBo6UMdED3Huu0Uer?=
 =?us-ascii?Q?/sgiVPN4dRDDFpG6MZ6g2iju5r2lRtBqfqmKS+Y45zkQMAoMstsjFfuU71y/?=
 =?us-ascii?Q?TTGmpyMzKiOIm8Yf/jBfd2vHMlLhcqJcDYTlwq5Qw/tf7PYXokYZIVmDhVqA?=
 =?us-ascii?Q?+PbAhiwMpWrbM1Kn82r9bh5YAdQ86fooft3Eeg+/+Ced6mCWGTti6aUMBLmj?=
 =?us-ascii?Q?3JQredWtAY2P431m0bV8QpAV0bTawV9G+w6Wy2PI1uhaAoUCcsAKGGXuSGYp?=
 =?us-ascii?Q?xaOJ2nvqtPChlQdulrCdwh+I6fEP/mlgxYwK0nS0d6G2MoC4di8F17sZZAPm?=
 =?us-ascii?Q?1i7DWZRbKBE1aabQDfUcGLYGzRoAumwxxn/xNxAnZpPpT7ffleyluUqAkj/t?=
 =?us-ascii?Q?a7eJG6x20xysW4Fkq1qBj6NDR7ASVM/GSqrjYI9UvEFngl0YwVrkv3zNwFhW?=
 =?us-ascii?Q?SUgePXF2xjMg8CKZooXb9GYvFD2UGvyc3yUo545LPBv38wvTrVAkUGR8HcZW?=
 =?us-ascii?Q?Q06JGhCznL4LRr1f5god/wjT6QldWNuWor7BjyINe844w9mMnOZU0gH/M1oc?=
 =?us-ascii?Q?0KubEH690tQ2GjdDQ1QV5D4vqdD1GjaHFwtY7Kpvwd4YK49XFpNarop4CQag?=
 =?us-ascii?Q?gm3ALXjPuY8PI5SvfDRRR6c02lLSO2FLRUnYSdH/vkZIcikmb2UPBG4bIH+9?=
 =?us-ascii?Q?FTJYN9lQl6+3UIQZ2OZ576+kW6bZvQhJTXTfnTIcphn93al41HkhjlTUECO5?=
 =?us-ascii?Q?bXbNbQ0RnCWSROSMPy0gY3dN8cDre9LDeJU6VCoY769J4LM14Mp9Qjp7Iaem?=
 =?us-ascii?Q?7M4l57aFik5dCQBlLNMVvhkHwG6cTp8gghfuSIIhZ0vWZ1TCrfJcZZnCiyNn?=
 =?us-ascii?Q?XxJqHQBFJuDKalKFz477ctZz16sNtyOjHgV8MFfJy+ZDY7M1h4ErokKpD2Hg?=
 =?us-ascii?Q?xxgcffPW4hiVbFjoChAfPERSpbUNXXBNt3mW0dpEQNFPxM+AH1QEhWJuZSRN?=
 =?us-ascii?Q?2vehbbn0D7oQEY3YEBHvyaP/L2UkvcUffXeu2bw0vGcDaR15qjV37S1LMhef?=
 =?us-ascii?Q?fNKXDgbf+k9N35r+vSN08vxstBffdZvfoXk+q4Zv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b22863c-eda6-46fd-68f5-08dd661aadeb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:44:53.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9eAYE11LD3vTnoWt1UVpApvwOH4h/nGGavN5rn5TfAVYkHz4KBScbhgvM2W4Y22
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

On Tue, Mar 18, 2025 at 12:30:18PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 18, 2025 4:51 PM
> > 
> > On Tue, Mar 18, 2025 at 03:43:07AM +0000, Parav Pandit wrote:
> > 
> > > > I would say no, that is not our model in RDMA. The process that
> > > > opens the file is irrelevant. We only check the current system call
> > > > context for capability, much like any other systemcall.
> > > >
> > > Eric explained the motivation [1] and [2] for this fix is:
> > > A lesser privilege process A opens the fd (currently caps are not
> > > checked), passes the fd to a higher privilege process B.
> > 
> > > And somehow let process B pass the needed capabilities check for
> > > resource creation, after which process A continue to use the resource
> > > without capability.
> > 
> > Yes, I'd say that is fine within our model, and may even be desirable in some
> > cases.
>
> Is this subsystem specific?

Probably.. How a FD works and it's security model is very specific to
each FD type.

> I was thinking it is generic enough to all configurations done through ioctl().
> For example, I don't see any difference between [1] and rdma.
> 
> [1] https://github.com/torvalds/linux/blob/76b6905c11fd3c6dc4562aefc3e8c4429fefae1e/block/ioctl.c#L441

Isn't that the same thing? roset is an ioctl on a block char dev file
descriptor. It doesn't check the capability of the process that opened
the file.

> > We don't use a file descriptor linked security model, it is always secured based
> > on the individual ioctl system call. The file descriptor is just a way to route the
> > system calls.
> If I understood right, Eric suggests to improve this model by file level additional checks.

Yes, but I'm not sure it is an improvement, or that it won't cause
regressions.

> > You would not say that if process B creates a CAP_NET_RAW socket FD and
> > passes it to process A without CAP_NET_RAW then A should not be able to
> > use the FD.
> Well, process B is higher privilege which shared the socket FD.

Yes, and?
 
> This is what I was asking in this patch to Eric above, should we have the min() check of both the process?

No. We don't do it above for sockets, we shouldn't do it for RDMA
objects either.

Jason

