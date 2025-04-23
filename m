Return-Path: <linux-rdma+bounces-9744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D985EA995A9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB21464FC0
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DF27990F;
	Wed, 23 Apr 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k9mOdg+P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB4264610;
	Wed, 23 Apr 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426751; cv=fail; b=YRReL4YQpZ2YfjCWhdHXVXtOFVsexiQ5d5MtqCYVclHBZFz8AOksK/qGENqtqNmrpYOK+d772lC7sAJCCKL66ZKIXySn+K8A1SMkRH8vgMH4KvTVYbaFFdPu2Yso8jDn/AsBq56NxyOV5Go/jMdUvXILhmuFzvB63V5655nMQvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426751; c=relaxed/simple;
	bh=GqSeJyHUENxM2CM1HhecPA0cFA+T3EZofGqiLrzXDJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CHhTjAzpRPSxez3uwU8JmxBWiLuoJwXWQAsYysd3g8osWtbBYk1xe0s1MMPq9mWeEFDXM6OLVfvwXwWEzdGM7qS94avWho6Jq4hbVnZXKU1ABUAmVPQNvW147DqkR6AwQGjNP80ttbJURd09Re0a5CtqhyibcFNjWvjbkhHfoVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k9mOdg+P; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoGH0iUVUOyHsZGf2F8raTWlzI/h/DwafMatwkFWLaamPJBQryrl2Nr7lj/uZqbAU98F3FlWAEc6FsQ7CmXEZwvVv/DB+w3uXzrIRFqJOFa4+ZCgvvSD6dVX0DcXrAjivcaty0vZlqInAgsRN+NCwwgoYs8SdObUTWTElY0HIImtODRkPE2wb/j89x0hyEjZXNfqCYfqB3ybOeSbIW/6TCAUTtNBtD/TGg5XMkwLQ+FjFpUKXg3sY9Gmlnf5dk/WAkUW0109Oc0E0IzP/BGX0/39KlQd3waiIaX/M4Cd+S1MVhvlHKrUfMGBZtZzAUTLnlwcAGZZGjRPxQQrPirCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb2eNeeSI51gOXLoUU+7F/J7TKC9y3YVschP6qjF2kM=;
 b=atGr9agS6kOpDyStfPx3ujRu4OwpyKX7P/AmksriveUgWTtWi5dU6tNuJqtuFpF3pOjks/KCfLpmxTnevOogbEhdkM8VtHWd1YEPhYiK6IHuG+Y1J/4QJcsErvwAO6Zm0/PFyB4B5tR17uqU+uh0xwERTC48O6nq6+sNeAppvZlxs2XteBumCtOCG0dg7P3SjEpvFmQLNTlFDpTxYZVoLfHLXyGPgNdmP6C3Dr3/NTXkkmMR41uRyZqsl9uw6NAvo1sskH5eGTICqXX+HI6d/GXxQrV+tonYVTsfauUfVdP30F12lSV3jhqu6O6lwy+hTHj2YHmyfjhBCYClnhz5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb2eNeeSI51gOXLoUU+7F/J7TKC9y3YVschP6qjF2kM=;
 b=k9mOdg+P9CXiHu7+PlkOute0aqJEHqnY1eTdcsUfP69UNxdR4C7vBN5kQH1ZIYKcqqT15fWwDQy5/2sYlu1z/n/Olo0/YaDXZ+3cS6eCveD0+k2E+rJ7EYPMn+1DTb09Kx+qeH55VtK5Fk0+4kp2PK4nFlbyAOINoohHJDpkKyvIk4fqQY7dIj4hb16/66k5ewhJEbtrTu1rnITcO+AoTV/DjGPqlaqdASsgIL6XRbvP1uFnHNbRrFg93zmCdrkGTgywu9Bmentm4nNO0jgis1AqyNvRhw92so8wSNprj+wXRCnEgyZaNKS3rRrpGhGkzlrHGKqGBq+6vHgUBWvTQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 16:45:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 16:45:46 +0000
Date: Wed, 23 Apr 2025 13:45:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250423164545.GM1648741@nvidia.com>
References: <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
 <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
 <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN8PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:408:94::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ca6827-be1b-4902-7b47-08dd82864b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqBm14IGSY82B+3tpHhbYKf+KvoHQeStsgzHKCOj1ELQU2a0dipYHZA1lurp?=
 =?us-ascii?Q?P8zpc/10aCuKHgrpicnKfx4Bb79/TEwtjmHlXOGEa+nZHu+JDpmL5awdt6nm?=
 =?us-ascii?Q?XSYuH0uIJEfWPYdVtaM8ptf5RJRGBwC5j6RI1qjjpnnpEyglUF0uyr78b3x8?=
 =?us-ascii?Q?PKZcjpUu2QyyXuJ3ba+lPDWvOXppe1BCfKe46bfQB96OUZGRdO6bBBsMtRXT?=
 =?us-ascii?Q?8rPdLFxh3tGPFsiu/57GyR17NiKNaJ3azvFH1Q5wXql81MOQ7En66TI58ByN?=
 =?us-ascii?Q?cj9BqkafBWPJXOWEKex0+CSs/yTxVANKTRbhwGkXZRTw5m3y1faa9Ip3s5bA?=
 =?us-ascii?Q?2BKSgKBt4QOyjX97oWDwU97sIM2bcjUcOnw1APo65BTtdfeoThlvuW0EnL7t?=
 =?us-ascii?Q?6eRpClkq1bEXcFogGupkxcAa12xrBWjW1+oTHceCNRK75uLUmIBSd4uqj5lX?=
 =?us-ascii?Q?MoxEnoLYML7GkY+mhfx67W2P7p+zoqwqr2ro1uQ+Y2Dj8qoqBP37t5IwfSrm?=
 =?us-ascii?Q?FtLf3MFJuLXOn2hUOmhe5iYdISeJ/uyfsTYVAIP/7l8OACEIVWWgjinKdg+T?=
 =?us-ascii?Q?hzpfZV8coPtfgKhpWXwVQkWN2bfCPVOJUeHqKzrPrG3Oh2bM60/gm7yQc3dc?=
 =?us-ascii?Q?VR7SB2yjuW3EUBP4L8G4baq2koDKwgGPGRdSV7EMVTVs0gqPdxvSPXdpPYzv?=
 =?us-ascii?Q?tXnOxIBLC2khGToI3+OmvFQWck1+Fa+I9BZdn+5SUv4g2o6UujZKmgSbi100?=
 =?us-ascii?Q?Wlta+5X+QNQFHuLnS9bXCFO10b7rNAr4rUpuzVAn+86fpDMuDG9O+uxSKZ32?=
 =?us-ascii?Q?HsibpavpTURToDuKmQp/Vqb1zkfUFt3NQIpeeidxf0AT7EYdDjtbVoryIZGP?=
 =?us-ascii?Q?lRXwFSRtn0it7YY/vVq+dXfi8lPQztLuq+LfV7oy1vfoX0Epu6QpHMj7L84C?=
 =?us-ascii?Q?5zEez74p011eZXnngTte67twn78oH45BZfh/3fNU2WXTZA1Rp+UpcFB5oNbV?=
 =?us-ascii?Q?It4iQZz+OdxNMhPRnHFPz1BUtYfLLyermYD8r0By+taK3HVpgKdiE2xIngod?=
 =?us-ascii?Q?jMTAbXufo18Mu/Pq/7qidxdAWjVqwb6J3pfeAlV2k6OTy06GGUdSqCSEfNtV?=
 =?us-ascii?Q?/a9Mf3WGi7EoOJdKcXuURcfkhMvyTWoagG4eA5VXG8pPIgObwfjV1YlypayI?=
 =?us-ascii?Q?uHALtScXMqc8EWWi+ZDITPAjGTSzd+YIKaLgpYl57qOg2L7vSLGG1M0QIBcz?=
 =?us-ascii?Q?1GKyRrnQSiLwTTzPYxDohBsyOB66XzO4/ARPP3YSeRC2Ij5LZP/SuIBH2SGc?=
 =?us-ascii?Q?/VRv4iei0cPVRrvdXiWfbLBialWC82AjbqyI27/rOq6v7VyFnqJ4Wl3EKmIj?=
 =?us-ascii?Q?+olRRendsZULWVUfPx3z+9PAkj9CiW8yQtwkch922N4qyG34OK4Xk6NVTH/w?=
 =?us-ascii?Q?WvNyVlS/OSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3rPsunIhWHdIUG73X058+VJoUlGwLUTlNXubzoh+gAZ+/UPgYA2Bw+EEvaw?=
 =?us-ascii?Q?6deXmwsoVSuyZjmJMcSp35JXv5jrd/YL4I07MuRoSmlukeL06InfyD9HoAtN?=
 =?us-ascii?Q?ncuH5KAhh647gHSgL5U0ZkNMZHLivFbPSvxEc1/2Ud7eXOuEZODRVoFARt/P?=
 =?us-ascii?Q?x5Cq38gI1mbhseqQue5dLKQ/rmzleYCdSDVtVRkS+RxycYJK7H0r0ihqx4y6?=
 =?us-ascii?Q?z7A0cNf+ZCUrNlcsAjD/zKylcwPfqman/LlV8Pzqsdno/z+h6Ckm05lGKnnE?=
 =?us-ascii?Q?EZHuqFZaoygJog+Jn+YN96rn+n8WcNyN1dYfugsdjZdbm75lUlUkJK6D0vEd?=
 =?us-ascii?Q?T7HnhLxm/X1dx1zYGT44Z92MHE2vb8yCbWqAz/2XnvL0uKmPfewtsewndZS/?=
 =?us-ascii?Q?tbsp9fBpidg9KqC80mdBEuw117FDmHhGN9B8g0HCCK1xgY6m//FvcRAntEts?=
 =?us-ascii?Q?0VkeTFRQXkQdSBd7Ds5mBVlmcFdbYyLbTm8W9FlrBgqPuA1EIbZleVNblbd/?=
 =?us-ascii?Q?3IeaXpUQpMEHLEzMj7tWVpwl0fFpOb7hoJ5M0grl9FKoYI5wqMzgi6hFGCXV?=
 =?us-ascii?Q?PQpRIGcUBN2+Hfqte6N7Q3OZ9TgEhPfnp1Fv2B0WGI6T0FTmqf/j/xIn4wPb?=
 =?us-ascii?Q?lEBV/uTc9FKhab4p1Np8cgC3wdetqXYq7+Gv87wMhYg5DCxdmINnun/3DhNP?=
 =?us-ascii?Q?ZRT1xKJ9cth1aBTyNKsvh6wqYHBVdfUgAURnuARUp89HtOng8yp853rsFC8P?=
 =?us-ascii?Q?AO1SZOZSPPBPVYuxz20+5kZQnle/YXkeJuZFNtkoUSAtEQUbubXmZITlxZtq?=
 =?us-ascii?Q?lLpeVgZz7waNiq3al5+rFQ/HDMbhSKthRzMC0DhkK75iq+kOl3HuHuv0gGKy?=
 =?us-ascii?Q?bsS1A2mrmvUflH8pObIj/l+tkTxnqKwAMkwhiUP9r/cSHPafVV8TNUMHKp7A?=
 =?us-ascii?Q?Ph0aa/b0TotwzxdwDPvWmowNz2sjlj7t84eB2jzeRE7Co7/jpIO4aXIiaKeA?=
 =?us-ascii?Q?phbDeygArg834Ukrn/vwXNsgi2ed01w/Fk2mFUkBiDdFwdVEpwmzA5jglbeK?=
 =?us-ascii?Q?2Q78nG2IGWFnF847UJSRmZgp2dfNRS/jNM197K0q7Aq2JYzsWFnY7PRL8HzL?=
 =?us-ascii?Q?N7w+shpXlhqB8HRNZvlJO0W6j4DbaCGA1WxgkjoZeT07T6r2n8T+jV4k9hF3?=
 =?us-ascii?Q?3q2G3tkZ00roA/x45QmH4etUqKB3DGprB2rDZT23HkA34btW3YBLHzD3Wdm8?=
 =?us-ascii?Q?qNObTwMQMpRFQ9u9xCZasxaMoRKCT3KovNk/urWCcTkTSP0x1Zg0K9GS8svp?=
 =?us-ascii?Q?173Aff5ej04BuQsbN+aevH4KHtKQlCS1EyW4GSvKPGokTCguioEAFaK89scp?=
 =?us-ascii?Q?F3bJkft+xs0zRfnsnEWXCsunt/tEQqtCXlndw3IQr2mQzc9l0nbeJ3d7u2NA?=
 =?us-ascii?Q?FUkPEK6g40LawLq9gXBFdjlOsGuyC6g2Vr1lcWF9W6Jz7+Uz7Aa+W3o1zCqg?=
 =?us-ascii?Q?2wAzPRsouFYMjO3vHyzv7Qt4oEfCwdIcT7GbovwiZlK8UxmSecYapRhsl9Nm?=
 =?us-ascii?Q?06hxqrmxCVPmyMoxD8e+szkI5FOFNLBfXAXxtZu1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ca6827-be1b-4902-7b47-08dd82864b8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 16:45:46.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+6Es6U8kCsbh/oIC2DJ27/3brh/eZeQFel1fFxDiGwHgvwmGg6EvVziTx4VW80J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346

On Wed, Apr 23, 2025 at 03:56:39PM +0000, Parav Pandit wrote:
> > > And I wonder if using the uobjects affiliated netdev's namespace is
> > > OK?
> >
> We don't refer to the netdev of the rdma. Because netdev is not there in many cases.
> Its just rdma device.

The ib_device itself also has a net namespace these days.

I really worry that a single uobject has too many choices for the namespace:

 1) The one provided by current during a system call
 2) The one that was active in current when the uobject was created
 3) The one that is linked to a netdev associated with the uobject when it was created
 4) The one that is linked to the ufile's underlying ib_device
 5) The one that was active in current when the ufile was opened.

In all practical cases we expect that all of the above are the same
thing, so this is looking at fringe cases where userspace is changing
the namespaces during the lifecycle of the FD.

So.. Some basic questions.

Since ib_device has a namespace and ufile is tied to a ib_device, can
we ever have a situation where the ib_device has a different namespace
than the ufile's? This would mean we changed the namespace of the
ib_device, and IIRC, that means we revoked/disassociated the ufile? So
the answer is no? This means #4 and #5 are the same thing.

Can a uobject affiliated netdev have a different namespace than the
ib_device? The netdevs arise from the gid table, and the gid table
population should strictly follow the ib_device namespace, yes? So, I
think the answer is generally no, but there are going to be transient
cases where a gid table entry is in progress to delete while a netdev
is moving to another namespace? This means #3/#4/#5 are the same
thing.

Can current have a different namespace than the ib_device? I guess
yes, the FD can be passed around. However this would mean that the FD
caller should not be able to get any gid table handles as none of its
ifindexes will work. So #1 is != #3/#4/#5

And finally the FD can be passed around after the uobject is created
so #2 != #1.

So, I would say the correct namespace path to use depends entirely on
what it is you are checking.

1) During uobject creation CAP_NET_RAW is checked against current.
   Perhaps we should further insist that current == ib_device's NS
   as well?
2) During gid_table lookup for any reason. Use current to translate
   the ifindex to a netdevice. Match the netdevice against the gid
   table. Effectively fails if current != ib_device's NS.
3) Routing lookups/etc should use the namespace of the netdevice of
   the gid index being looked up.

What other NS users are there?

> > Going back to the original proposal I don't know how ready the code is to
> > handle callers that are not root.  This is both a question of semantics (is it safe
> > in theory) and a question of implementation (are there unfixed bugs that no
> > one cares about because only root has been using the code).

We need to look at each change, but I think most of it is fine.

Jason

