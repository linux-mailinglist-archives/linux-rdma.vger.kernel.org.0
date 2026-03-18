Return-Path: <linux-rdma+bounces-18354-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDk/NSPfumk3cwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18354-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 18:21:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2152C0278
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 18:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5F9831866D2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A4F3FBEC6;
	Wed, 18 Mar 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ugw6fRG5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD53FB049
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850450; cv=fail; b=ZVRMPLvw2Wl6UNMZzuAvoYgoR8Iz+fol3yEUmpZBzNl/khS0DtJ+/7n2JXaULH46eELy2w4EoSdknUfz+rqg+dlAkpD5XIs0luwqSwRaNCFzzX6u25cPEqXk2OSy1IkIKN1Wm3FcFkMKOv6gKjF984hdFo7Y9wpweJHm9H62HhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850450; c=relaxed/simple;
	bh=8xKk21KGqzFXRs3ZazCw4A9o51tjJtPCZCVDsiZO81E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uigG2Ds1veJ06+D4iMtBdjvTsP91dIvXhLKaPUGUQEPdt7vvr5h9qdjw2Vn3/GuGSKLEZ7NN3dBmwkcpXcylS0aF8nBxIWOFgfl6w/GeJ1SXfYvEA2HpoFyo3r2LxrE0RFDIzBnqnhstniIDIyro1Lqh1a0DTKAnjnGiHpZT1Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ugw6fRG5; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4UWCgfIRRy/ERKxJVEriOYx01pCP//DzIuwbl1wAsRLPjPQtlj/pugJH9DI6pJWmWah+hmViZF4z90XokpHC+0UZrveCSbhVA53/i3kDIPBz34Pcy82K/rLRDfCYnsjwBQjOs9/b9dcIaPQaSgYWQ6NUq8I6k1IO1cnqXpFePHOC2Gsucp0iWB17wQYW+GD8o6ETxVPoZ+goy79NX/Uze9WHKU9maWvfkcOhkjTdm0yjYHEvmJ8YhwXYAAbIh8yaa97jJv6zfvexoBsClH9aW8Nm1CgSwzlw25S422DMMH4R8dN7o4SVkpiWfNUIQy2FBqHMwWcyR4aK3GhiGl1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXusI6iBuQQyesCeijzfC6N4cajRRSeZow/Uy5ZVt14=;
 b=ROAreI9Yh27ULwVmp3qDQd88xO8dYvpT3HLEpDjX5EJhhC655vm6kpRbpFXPoHtBEncwVeNPJrDT2oMGLSMt/nqC5RI6DnUeUWat5j5sHj/Iaq1IguZ8qh2BW3UtYqV/bjJH0GdvJx6cIzPwmvAuc0yKItiqltaDeEyFZ939XeiGRXAmOh5Pw+1JlYRyOD5/GVG0ulvGKO1k66D7qCZ1aAskT03Pe06AgeDYuYUV/kc2vdzFdx+WqDo/QcTk7UJihGQdO2nA0Txs5Am0iVQhaWebY20cXifBrccJF/va4C1du8J1aM1ks2Mler6Z/e8M3VChtvHVGeJQ9uluQG9opg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXusI6iBuQQyesCeijzfC6N4cajRRSeZow/Uy5ZVt14=;
 b=Ugw6fRG5KDvkLmHO1D4FCIqv6JufUtpBZClcF//PMVRtxliLp+O3mBT7b63UFZax7gXNuCJnYDOTpuI8IkDrVrwR5QLk2Fx+laab5zvBiYdwEYXRqIIzRQKX8R5MmNLnf3gU/Qw6jwYuv5VdTcyq9t1u+LeyVP2U6ChmcGgiKVUzAgkWas/V0BI/6kK5zxPWjVu4K82T89JCnNxDMQwSk7fk8WoDA56YqMVj9tNQIZCmadw2nxBKrCWx74I0r4S/FQrYMqNSlcr99yw3JHgdWjsXM2SNyJ11DTCMebhr4vwnS6wjd0ZqJttcvqDqTE31gYXhmVQZcpWUX5zc4tx9wg==
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 16:13:58 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::d6) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 16:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 16:13:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 09:13:36 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 09:13:34 -0700
Date: Wed, 18 Mar 2026 18:13:30 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: Add BNG_RE to rdma_driver_id definition
Message-ID: <20260318161330.GH352386@unreal>
References: <20260114100728.484834-1-siva.kallam@broadcom.com>
 <20260114115858.GA10680@unreal>
 <CAMet4B5RtLYaY=wB_T3fBUGYQk-peaLbLsqXy_0Vhp=mqLDm8g@mail.gmail.com>
 <20260217135209.GA281368@unreal>
 <CAMet4B5jhJXU8WYmcuw1ba=SuJ2f-YCqnD9fGwQ1MNyjF_u3MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMet4B5jhJXU8WYmcuw1ba=SuJ2f-YCqnD9fGwQ1MNyjF_u3MQ@mail.gmail.com>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 466ec3c4-9aca-42a9-5d70-08de85095c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LxQJ4k46JfXpf/MClt/GE511RVa68oOqm3OACcqldWTNF4eSFJ0YSyg3EcobZceRJLDiwY8bCpva8X0x+NzXuJHDu0TCRiaVACEEwJLDoreAesNjyd7NGuBj6ZmWJL++DukNwoGnCO5nyht0DMPpJPuZfOz28riCrElgMqFvZhsLim6vnNxM/JH3b3Qn2njhifX14IoX7viVLAmBk0SS51KBbtguJ11E8+PyQFv0vBJFxMi/xaZRgtK1F/Z6dseCUDiusVQ9yqsGQTZfLqslow9z8mTSTypxNdOeuf/ClB7GvBwZSqlLZbWhOZzTFlbUVEPEH/t2N0l6zvRfFciucxqFMq3kcdm69FUAxGHPIM5yIMDWfSMNeqpa8sNlmX2sUCwnyg/RkqowTsQ19UPHee3tojhhnnMW0XQovHPwGz+XaNXqzJBHTFYoXEvwNKOz5jnxGA3vfLkOXdpEvQOgrmyzb1LKJ6B8RjO3nv3ujhVNhMJKTJfblfS+1978ZP3uk2pV+cn+d77cJkcbCYNoAZeLNYsQmlI5cUaB2gVG98/zUJv1AFF9d8ZptTEvM+P1rlfSO+/0J3g2xYRT1wO14D8YJ21G6SIR5OAxgd6H5TVr/VLgt9bvPitV4bYRT7iNfEiTZ4dwqwDNa2H83fcDUMPGqvGViQllIcIETscjJInInzfdHM19QB+yUlWThUWMa4eAaelVoPL6gnJj5rlpfGmo3fB9cbXDl0/lKAVqoseOxqep+/3qgBB2MbBw8oqKTR+gNSExMJHe6UcZ2ZGlqQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gYt5yXJDAKokEWgd0xA5TN42445w+1ofw6ZI43e9/gnBbdMXSoaMmDZ+k8Qszr9JBMu3I7Ax16TPWtMHK4jz72P6YmZ5Roiq4ILE9tnslyocGU2yQ1JDSrHtLGwmsX3nm1M0UgA0QuaQacl8Xl/F+2ffgR97E+5dmbWjulRgEC3iuR58VjpZTczBThRWvcex5hZ056SBIwChwoBOk14tZkIQOh2LVTAP3MWj9oVG7ZRL5YiMc1jLaUW9M+ClKUOUP2/0LN9uc7d795NCJnQrnK7o4Y7zHPKhjha7swy+fpag/4FiIHerJqhI1f+gsN4REQPug6uKnFYc+xmGO+ldKe/niZjbiOv9x2nISRt4BzN+d1ZqFCDr7t+EUazZ5/hhsq4Zmu5AZMSxIHeN7RjAwokeucAbaGYE9om+ayJX9+WjXEEhM5Nz1+oo+SBR2iT3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 16:13:57.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466ec3c4-9aca-42a9-5d70-08de85095c22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18354-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2F2152C0278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Feb 18, 2026 at 01:55:05PM +0530, Siva Reddy Kallam wrote:
> On Tue, Feb 17, 2026 at 7:22 PM Leon Romanovsky <leonro@nvidia.com> wrote:
> >
> > On Thu, Jan 15, 2026 at 04:35:20PM +0530, Siva Reddy Kallam wrote:
> > > On Wed, Jan 14, 2026 at 5:29 PM Leon Romanovsky <leonro@nvidia.com> wrote:
> > > >
> > > > On Wed, Jan 14, 2026 at 10:07:28AM +0000, Siva Reddy Kallam wrote:
> > > > > Define RDMA_DRIVER_BNG_RE in enum rdma_driver_id.
> > > >
> > > > This should be accompanied with use of such define, where is the call to
> > > > ib_register_device() in bng_re?
> > > >
> > > > Thanks
> > > Hi Leon,
> > > I was under the impression that driver_id can be added independently.
> > > I am planning to send the next patch series including ib_register_device.
> > > So, This change can be sent along with my next series. Thanks for the
> > > clarification.
> >
> > What's the current status of enabling this driver?
> >
> > Thanks
> 
> Hi Leon,
> 
> Next series of bng_re is in progress. bng_re is dependent on some of
> the bnge driver's code.
> Next series of bng_re will be sent once required bnge changes are
> merged. Internal testing of
> bng_re with bnge is in progress.

What is the current status here? I think it is reasonable to expect that we
should revert this driver if no progress is made before -rc7.

Thanks

> 
> Thanks



