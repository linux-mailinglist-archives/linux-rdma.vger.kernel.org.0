Return-Path: <linux-rdma+bounces-3999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E193CB49
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 01:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACE91C20B23
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE0149009;
	Thu, 25 Jul 2024 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HgDb+FGk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417D143878;
	Thu, 25 Jul 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950806; cv=fail; b=uq+BcHskyxn/NYuhyDBxEUceMSd8dW0ePNmeVtWxBeuad1RUfJh2dKherPukzLa1/v5Jh0eZHXeknWmSmmtWGDPM1c180oONvwXAamXLs1knRLTo3lb5tLkcgivQM0hy/XMqBkNnpdDMufGJNNcUA1mCZ5VC/11io1lB2KNR7e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950806; c=relaxed/simple;
	bh=d7VVZ+TDV4z0PgM6H+vtLFMcY7gmNgQJIjEFqqGEBvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T7PPqrwI8bds2wD+rirUnvT8AbKd/V3DrJNyhdCvRZZiU32uc7vMl2k11F9WOEmkkHqTc+4VP2Q5zOosaymU+FqwI22O4U0ftdqgkGNmiapq4rMYOgMObmTtwDxsuk0JNV8pWA/JVjUp3qpbETij1aoG9eVmysnqbLYIIjHWYHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HgDb+FGk; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/hOl9emFQGRsfWA55h7Fs7PEdeVwvLOx3UNCTwqmd4IeyYzsN21ZLApr73bsDhUtKXI87BfTorg8cTxlbhuYsWAo8zGGrK/Bkv6lZZUqm9v7cKKQD5SiL7u3Em1pGrBzlW7ZfVeZ2oFS1WwPPkO4C0LZd5pojhvTn4sJJ/qgEi+5ihCJGj90pM7CLUMN4foS59gSwER13+ESisqrCwW/f9y9Wvb9PyMBrSnxOtND8A8CRBlcXLsNh2Z0Sp4zfZZNTBZ3vBMLdOxm7pesOYAoaKKDH9ItCVO8kQ2kUy6RzfyVGZ01q6TLZPx+UKj+A7LlMnpxtn5qL4rjM+C46zxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7VVZ+TDV4z0PgM6H+vtLFMcY7gmNgQJIjEFqqGEBvc=;
 b=Wz6ISFoZum9vFVEJ7dGXi6quWbZpRrUWgRZgY9vOEW0HWnEEhFIHw0k/bIqDZjMhTxEQ1m7V3XZwTZQJFbsqzQtnQM6BzInCJSYdn+fI6gI+pgr1Z1SSpMOfCXON3MjNXj4LwldOplZt5USGBNZaiWCIJzIYxRnXToyR7rMwpKOtEFOfloeqJrlbJBzD8Sq3foMX6BkjcfZknUb1KH7CMZThKco3lpjL8TgqTSm6HqFOBATQAAIBlaLtH2bn37UKDWYRrWF27A6n2jWifHLb0LEYhqR1XZqHMsLFCjFz+yzLdMAwgOehcpLJ38ldNtap1msHRWAX4hJFeypaXaGOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7VVZ+TDV4z0PgM6H+vtLFMcY7gmNgQJIjEFqqGEBvc=;
 b=HgDb+FGkVslravnGrCxrzHbbRAJHYnuD2KGnMXRK1fn1Z7FuvQLtw0o9rPlLNfyKSZn8H4EhhNvnzAo6XdQROaKrtIR7NxG6yUJT8GjnLY0B5rThx+GQZI8LeBaVPgVHibfJdDiSoM73lUWPL6NZK7cuKVS17e24eN0YIRCVXN2ESg4T5EHlqNwFOu75tt9V8NXFGRH1dkw97HQK2vvapTw26XjkDK9UsRHmBSczr3vYB7t4d1arEKIRIz4gJljed4BIg3QayKPJQCZwXpsMY3ToG3VSUlijXE7HFYLT4pdaVtGqR3E1JCaeMXFFnf1IPdjpFOVxfSaG7H/nVjca4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 23:40:01 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 23:40:01 +0000
Date: Thu, 25 Jul 2024 20:39:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725233958.GT3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725200703.GG14252@pendragon.ideasonboard.com>
X-ClientProxiedBy: BN9PR03CA0509.namprd03.prod.outlook.com
 (2603:10b6:408:130::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 67edcefb-2693-4ab5-2049-08dcad0319ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OPiPATsTxOo59rYY8opeRLDh3Njl3+Ge/n4kKhz7TJ7Va372SH1DGasRhPTl?=
 =?us-ascii?Q?Un35EZI5mchKCy51FkpHrfqxSuOzcA/o5dOvjtu1mjgqngWVxjIsm7tIgV0B?=
 =?us-ascii?Q?mYml5/uCtM1di71U97Qcsw2ixI3EYLElKXdnoCSyHWNKe0nsaRnfWP3JKTb8?=
 =?us-ascii?Q?kExDJgcWNl82iOVoraq2HM+TjpMGmAhLDj1kIuOqiQpWFEf6n97NktjioHGk?=
 =?us-ascii?Q?wQsIoX5bTW9vecsY3kbecgqs/jWsjMzjBk9otum82PJFr+t2HJ02NXA+ErYk?=
 =?us-ascii?Q?kkKk742cK5UiUB8qKtQhvqXV5dXNq/pgVdYVAi9CUrYzOutlZ3SHzhVcOs/w?=
 =?us-ascii?Q?LWbrMuJJ/+bVw1jm68odj7b65EbyZUewUDhCcixO3aIR72NmhYJP/ld/+C87?=
 =?us-ascii?Q?tbFDXDLs3kRUZpYh7T5OiURIs4tnVqFId9q3VDUuaZSzdQD37XMFfaXhEaZG?=
 =?us-ascii?Q?wfdbaQEVH6lhaQfQEpiM5f1cl4U1uhRRH9Zk7KOELmjbNp25S+DyQUrRb4R9?=
 =?us-ascii?Q?MuKHUbD0L1/3LWz/l7Of/rgD/cKeYyibl/a/b2SWQ30VwaRY5fjkZ6dpQ/y3?=
 =?us-ascii?Q?A6QLzX6HFOHqbWlhVlcL8W3JkmLqpexIQrHibNacZwbrZ8uxhxgEUO5WYLVE?=
 =?us-ascii?Q?yjJP4BS9NwCbLnmzIblyTl/zeDknt1oda4MuFxLq+mbgJjFEvE6iG128skbe?=
 =?us-ascii?Q?SnaCLzjZvJrl6SS+Ho0oDOsDXCjQfTupnUrU+xJgH9ggFUMps8/GDAZo54Pk?=
 =?us-ascii?Q?u2/kQiuGb+pgM7N1wqn0Z0i5Jt5smqaTp9kc+jkhJbCkG2Ya/+oIAx11jkdB?=
 =?us-ascii?Q?/2EZF6vupIeAHGyBeoFs0vm8yZQzea9eMZrNTAEj4r5IZp+88x4h7aJCPlqN?=
 =?us-ascii?Q?e8I0uon1p3P9bIgTYY17LuL4sKnPFN/AMWe7NWduXyu+LT3Q/BcvPNmm7hn4?=
 =?us-ascii?Q?fZb+5KTbCYg8V6BHGcxwigJ68TfYEEyT+9k76mzQmOrjzwXtjkf1VKVtMd/T?=
 =?us-ascii?Q?kI5QdXY8UmD3+ajDbho78TyL+mpMv//iwDjEexI7SxEgvOotnazKHHwiHU78?=
 =?us-ascii?Q?ww29TeH1EHZV5amGmVjeipOCdvZABBXTbMcYLHGjlS1uSaA4Cx7zKAUghn+I?=
 =?us-ascii?Q?Z+sZ+2uVNah+Wi58tqXk2cgGj7ioLeqvHoE5KvUJYhGj5EeIlnGbfpPU1Cli?=
 =?us-ascii?Q?/LzvM8EcKsPKgrCv3WUB1c1P2KKbs79RgheE5GdJxw9P7WlFJCoL9Es1xc2w?=
 =?us-ascii?Q?dyxhaDEFQO8x7JF/FYewN1gxfsozO9/a5KtjGttlRBk0Hsrpun5eXouYjRUi?=
 =?us-ascii?Q?F/iNVto4xgC8O4lwe3HGDQpl0DZpJWyCugBYXSLYn2KJ1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ITjanChirtuMYaJ/cINDmijHdsVOB0PLlB4iPsyXZeXyxf5BZ3utez9BAUoU?=
 =?us-ascii?Q?/L89DvNU72Uo3TDSsvQif8/BWaMrTmJ3DOkoGFXIsMn/B34awO5PXiDJEw1v?=
 =?us-ascii?Q?gJN3vtck+a1vfNxAP3BdfUlZpOl6nca7zo2+vyRplhxFvp1HCpHfecAO8LSO?=
 =?us-ascii?Q?k0fq75ES/S5YLDTKX85gq7D21qePZm+CiOqMiW2wVeLBHXGOdcB7+B3Hb9bU?=
 =?us-ascii?Q?m5AAeMyWzR6LkTGTgtZtPEPoiiLQwnyxD+AeDXw1ZH5PEXEGLQrbpyzSi1FD?=
 =?us-ascii?Q?AqvIksH9ZSuOTJ0MKoHIHZeAY0kgV21Hd1as9sXYYjWcEuw3oJM3pOi8WWwa?=
 =?us-ascii?Q?Rs4tyCNnh2Qd5I79AxjZGK0b8FPHDHIBS0Sl+/LtCYXChDL8c8BIl1Rxw9PK?=
 =?us-ascii?Q?IzwQf2zbsZ5sBWpEsPZEBf65ltMcdkwofZiObS6Nl6o1IWxxoPhmXQogO4ri?=
 =?us-ascii?Q?sbeXS+g025scVTzkG2XqpEgBgCmQD7nhjzT/Q4kaWv5oU5+oCvBSMGYMTdSz?=
 =?us-ascii?Q?mQesB4Y0C114m/18LF7pAHoibmkylQPBOI5GNFPQKUM1RRY0pNI7u7Cvtv2B?=
 =?us-ascii?Q?02xWsmbtGt3Z6uGavBrig4Og5YgsdtzYICzcts5JpZh81nRIml51ebf5LsSS?=
 =?us-ascii?Q?HrjC3PpBQ0Mig/BWJ8uBjGcKzvEEeeoIuHtVPkl/vgcY/+mw6cw/im8yxvIe?=
 =?us-ascii?Q?nELgeGg2QVocvyXSy6X+tma7iCpX0JjSZKhDH/LZY3z0+pBdPluZbloUqyPJ?=
 =?us-ascii?Q?7m+T0OYDP6nYLtGcwP518zKc5fNrtAR+XiHyGvLAiTbFehZLBJkd4FWYVHgE?=
 =?us-ascii?Q?dUdlfI6XhK1Kba2Fi5w1puNfvFV9PcIF5Q0z4uCqNXaRX7AwKiRGWLJtDN4w?=
 =?us-ascii?Q?vNjBWl8GugOsIwVHyT/iyBvK4RcqFZKNOv6McmwnKQaDy9SAioPgIbxhO8Vr?=
 =?us-ascii?Q?wt2VuPbTRh44aKOflZALLVShbQ+FoRgzGENCzl032DrfbQGZSziREvvJC3mu?=
 =?us-ascii?Q?cO/CZYyPjEa1acPatcPpE3//1eY69ZTlAAwj8V5zUBedIMgim827uJKdZCgd?=
 =?us-ascii?Q?SUZbChCyBcCCMFSS7jd33Ep9mXj0SnZXpPanrep7Ezh+VtekbsKnH3CcvebT?=
 =?us-ascii?Q?mC/2B9lNBHlfkPXdMR9sCtpbPOIyF+n72k1SqK6fZnSa0LsEGZ6x0EATaWCy?=
 =?us-ascii?Q?bBO+j/M7naUhF1x0owD+z1lgu6Sktns06+ka+tpwFPza0l9wUfE7wXpMKpQP?=
 =?us-ascii?Q?/XJpwy39HjtKL41dIJFC93AO7pdHIArKpfNQj3GWK+qVYJtzMc85zIEonEI3?=
 =?us-ascii?Q?UE8Q2j0VfSMzp4xy2tPqjAbnhU9aev3K5ChL9XV4qALT/tSxSR+O5n0c5WlG?=
 =?us-ascii?Q?zbREWRqIwTZdYfGeAIK3TMgBnAiCpVf1aJHhjXojJrIvibKg05f2UxU46WYQ?=
 =?us-ascii?Q?IoORI0/lsVnqVinbB+bVc5u4dWuohKIirNQp7EXuQZjfx3N1d5nek7zG0htd?=
 =?us-ascii?Q?/9Umthk473/kylA3gKT+QowgF3yPljFowR3tlT2K1stS3Kbh5A58deCOx3gu?=
 =?us-ascii?Q?wRMWbdXleLTZRtFIreU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67edcefb-2693-4ab5-2049-08dcad0319ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 23:40:01.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RosiQmEQPJ0aCcuKhBbaZh69QhY41V6WhwHr4V0Q7G3vbq4xxfQdMhMNf5G4fPxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474

On Thu, Jul 25, 2024 at 11:07:03PM +0300, Laurent Pinchart wrote:

> If it means a kernel driver that takes the majority of its runtime
> parameters from a buffer blob assembled by userspace, while controlling
> clocks, power domains and performing basic validation in kernelspace,
> then I've already acked multiple drivers with such a design, exactly
> because they have open-source userspace that doesn't try to keep many
> device features proprietary and usable by closed-source userspace only.

This also pretty much matches where we are with RDMA as well. Lots and
lots of stuff in userspace, but lots and lots is open. We've been able
to keep open kernel and userspace drivers quite well.

Thanks,
Jason

