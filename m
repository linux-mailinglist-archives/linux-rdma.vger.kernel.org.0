Return-Path: <linux-rdma+bounces-9814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E87A9D08A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9705F4C52F2
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F04F21639B;
	Fri, 25 Apr 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TxOfTOOM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430F1FCD1F;
	Fri, 25 Apr 2025 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606138; cv=fail; b=EeNwY7xwwn4naD+v4o3Qi2zOrVvFVQDZC3NkHHE36Mjhq22lx+7ZrcpTTf6Gj27nhfHmGl0VmsUGiX86YmjZAziv3S2IPcOa/M/IrVA1BRjxaVwEMoPm85pTuU41deBXOqFLraI+Cvlx9mcRUeaOXNpdfv2EomSphgcA8m26ncM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606138; c=relaxed/simple;
	bh=v+qpOoQCXXQlpZay3MaXevZq30vT1uo8VsHIi/Ytcjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sgYz8lWq6e2Kf6xIKTvEFC4Y0wYSRE9Hhy++zua7WwhcRvOALCWWxvANHRysZjMIHw1FotpvouWqCyGwcipNov4j8Tae4Fp7aPbBIJDqsSkqb4fDM/CIngCgw7U9Wrl6nEKK7tj1zwFdw4YxSlS9fb+D/T6Q+gEeJYypuHTGuas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TxOfTOOM; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCsqFCiylsgxXLkMVVZiBmHJbZdKyZtV83nBOo4v08QnnlVsnrcSuKo+bt1m49J65WHaFCmqLuLpr5IkNUbpjktEnn22BzjR3eYL9VbIVF32dAO0upzRsHQadGcHAHCmtlsSmm2KGtch15TlhUbPoT2WJKnGVOF8mUv8fnzfmjR+94zVtoB8/Y/gVuCSbxym3ljM4kdt7+AMqWblDAzp+2QmkEwfLL//l2jkw3L5NVOo0DMOgOQvMBc0m0qREMYkyMpqID6OdV7B97XSEE2GHlqOHtaIBFluTPGrKd9YgERr7Cbbf0LuiinA63Ks5rcuV5Hy0lh3siyeqSCt0JouBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djpcF+klDRxuM9QsoVZ7c1ze7pr5t+6G4UFwIorz24s=;
 b=O5GSHSB1/txs5+N+rP0CgdNUbUlQZpktFKUf4bqruME3y98IxdIC+rBjOn5UXvlGObetZrjR+7AN8MOVC4NPqccck0tN8ikrH4tdak9YQI5dI6AhSAI2irPAqQZdlH0NYESYn0/AvXqH2LmJPTSSDUOUsgsibJt4uy/59pK1Yfa2MaUGt1rPeuBAIaUUBw5bDgjifyU9u9gCoZRQc0R55SKQHVLXgK+UG4nnW5CYge+j07KtuvK8OWIYAIP6mt9vyVHel05LbyPA14uCfA+osTKi/zZLtoKOB9JDaYE6SfO6RLV+kot3ysBViX2KiIfyk994Ng9QK647EqA7mkRRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djpcF+klDRxuM9QsoVZ7c1ze7pr5t+6G4UFwIorz24s=;
 b=TxOfTOOMkUmAxNOHbn57+H+fLkya+8czMxJp9Gwl8TpvH9LOGV72potceBQDqynycXOqM3bdvs52JgJZ2yGf+zsOjv/HCHKEyX+DkTP01MFGCdWsmcQ/s1Jt9/Hxi7jAnVBMUr25BUZy0oo6jsZKH8LznQj7IKJa9CUKy4TKYFybnHvIA6459DapdJmmJqkkMh/3gBfNAheIpYGLX9faWGbRnpEHPzwNUN5/l1A5o1bQJwAABKbIcQJn/dLXVVo16NXm/kyCghHbmsX7p6k5AouTRGS54UIwAUICY95VIsqGaU6hgj5VREuS+IH0rTdi6rmJcyeadbAGEPyr1ztxhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 18:35:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 18:35:30 +0000
Date: Fri, 25 Apr 2025 15:35:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Parav Pandit <parav@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250425183529.GB2012301@nvidia.com>
References: <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <20250425140144.GB610516@mail.hallyn.com>
 <20250425142429.GC1804142@nvidia.com>
 <87h62ci7ec.fsf@email.froward.int.ebiederm.org>
 <20250425162102.GA2012301@nvidia.com>
 <875xisf8ma.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xisf8ma.fsf@email.froward.int.ebiederm.org>
X-ClientProxiedBy: BL1PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f6c66d-bb8a-4cb8-b952-08dd8427f4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8luR3pXGvYN2y8PYOrV8KhGTHEcKEK44gF9NYY0bi0qsfTBODUaMWaik70j3?=
 =?us-ascii?Q?J3787VHtlLN27aVHvShzgv8MXaNwwHe2pcYWwGWbmaWtiICRyYyRkfwGmin6?=
 =?us-ascii?Q?sNoi1gum/vpfpmxqvfqhXqNdsxilYZZEZnwf+j3FNoGaB+BCf7VhgBF1a55S?=
 =?us-ascii?Q?gwuDL+8K+6E8QWogiw6P2o0xOAdaVkeVj+SAogmQXdULLjt52FE5keojY0Me?=
 =?us-ascii?Q?QdvR/Ro/NmQdHnbtK0qBAUXU+N2SRD3X9nYjjX8qKIEDjb4BHT4s0FOOxjAi?=
 =?us-ascii?Q?SF/ZdTW27ZNuNtZe3IaQ5ZTNsauSdTfokt7VQG4Brp/iS1aBn2dvHWXlcE2Y?=
 =?us-ascii?Q?Pqgq8kqrRoakLPmVrhckx7+F9AmoxGPROIrGoaxStCU73lnsFlF+IukYHYRj?=
 =?us-ascii?Q?gWHioHVx5ud4xjifnNzenykdli2OCGc9njlsTgl0nErUi3n60bd/okCGYaqN?=
 =?us-ascii?Q?0mrQY2K2zeNCFivKd6knc8wZbKFm0AIt0ozgP2G+mUfmFYLg0f7zyB1NakZc?=
 =?us-ascii?Q?XW4AN8sKp0pk8oS0nhEuP0kw0VeBvliE8uEwkJ3jhq2xSDEPQfDApHgQiCkd?=
 =?us-ascii?Q?6yEE5vJABw9njRUyvMMW8lLkgIrS+VnMEWlwclQ2FnMzzEYpG1Mlqllj+CqX?=
 =?us-ascii?Q?zVOpTpKYtlPzj8NwEEAHajzfk57yrCGASjtmvhGe9ris/kNSceH+Gwea8iPD?=
 =?us-ascii?Q?s5ZPAhilRaNrldcDFUpmFWhCVuHgGo31sWstQlr0agxarURxGhD+7iOSCeGM?=
 =?us-ascii?Q?mcE5lv7Cgu34imkBfNi24aHZ74V9LPJuWbUk6fbGtJlulbWjK8QMP6yvfokM?=
 =?us-ascii?Q?+FFNgae70LZuAZ0Dd2TNlnp8kH+cKgzS03lfI+f+GrmOLUmmW/yNoHyVlem1?=
 =?us-ascii?Q?li+B+/egwts0iIOmzdmRWVMEIIlD9rUTSojwKtzFQxG/K0pLtQf/Wag0nKVM?=
 =?us-ascii?Q?TtGeS4YC6SWd8tvnEAB9hImfa46ZPwiHJ4p1CFpjAqNtzBHt0ZAL7bGzUh/C?=
 =?us-ascii?Q?XXGHWtnEjGjlsXbKwtvBUV5ZveOTsfTlL4nWhlkFMoLYUrDRb/M6YvXt2Hoj?=
 =?us-ascii?Q?euNOjkX+++flUO7IGCFDQybD8WgKjzOZeaujw9q0+AZZ3MnTeu1+R4dc43q0?=
 =?us-ascii?Q?bL27+oMyrle+zQbwiLf20g8Y9YrwGq4xovG0DIwqDMtVulZehBWe3Z8rldRs?=
 =?us-ascii?Q?DL5AQpEToAivsfSYVtWJORWZhU0bqPVAzQXobiLDJc93ZsyR07yIh8ap/IRZ?=
 =?us-ascii?Q?TqQhE3s1Y4yB23g21hq/eEwBQcmWFYzs57NwwB2fMNVCPm/PNQwkc/0yXzHM?=
 =?us-ascii?Q?qX6hNl9NKqKt3Ucoa5Cd9voPtpBQqD77CPqqkk4kb6MLPVdw5tQrXosRc2Db?=
 =?us-ascii?Q?+176zUkUraXmbpVyZ7jPx7IXuSl40XiRqQhXPR+Ez0nUDCwL0fFaPqMQJKbF?=
 =?us-ascii?Q?ZD5J9g0XzW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FIs2agIRNRgIAB1zpgzBdz00I/wJy8jbODJvTLnPLJVBZGfTMzX1sItQh8u/?=
 =?us-ascii?Q?WHr5+m8bV9kYf8dHal54AfLDCePDo+VVLXFSYE3+hne9lDkCHKloLWxLxEQw?=
 =?us-ascii?Q?KZf9xweahGZST4O2jn4ok7fVjbSN5CZkXK1ftXZaYb1HKKll1c6gmQBhGE5a?=
 =?us-ascii?Q?zldaKdcMqrgPqSJyVhgy7V4y1nWsBXgikyfino5O0sCOEM8gGcYnvWCja5/h?=
 =?us-ascii?Q?kG674OXcbLNK31r42vSzt5/1bIK9e51mPdg0PSi91J38GG8Dzy7MtmvlgSdn?=
 =?us-ascii?Q?4sKDdVlwqL8EQlRw8T5ks3x6hKwiIqr29aHQxrMW9iLVd8D5MYlnkkpElOsh?=
 =?us-ascii?Q?Gt5poD9TVa1YIIyw8bAClaX1Txp/PRxCXoQ0jCAD4tWvKL6ggZaahqhUiXD1?=
 =?us-ascii?Q?mSJo/o4At0oMJc8uwPCwiIcNIBTBZ9U1x7ONC6HeCeIot5fTtfY0DdLuoNt1?=
 =?us-ascii?Q?KIYI1eKfu/SextIf3/aXn4v8J8M0N8gX/5Ty+o5C3zdAh8431oKbn8/C/QFn?=
 =?us-ascii?Q?+7Y9O67bfW3+dA6L1FlvWGSHhZ1LR16g7UEn4ufGtkS0q3GiIjcosiAP18Mt?=
 =?us-ascii?Q?Zk4qYTLo47HuCiDQKIBXqGItPcee8KC5j7IdJORNvEhem5FRuWgZPRcv3oU0?=
 =?us-ascii?Q?NPQpPXV+5irjb5hVHerwVQbM6+Oncd1b28Igj6Ro3Axiaqi7eHGNLqCZj/GJ?=
 =?us-ascii?Q?vLxg3PGTda2C5L2HzQfXiHRpUBEBjyHrOJyJOFJOPxkYm59k0BNYS8P8mG+P?=
 =?us-ascii?Q?/RgVmeFRoBEDNgOQ4fKzYqWDCRjNjrIcVtAQUugLphnymXo8weJkA0/lK7sp?=
 =?us-ascii?Q?XyNIgQgtkC4LC4mR4JHKBpy/9nc8o+21SaIJZh6vayLgtpc7QZnWE0cuGm1e?=
 =?us-ascii?Q?GpH6JOupWvSDKFN0DM+mpfcB9/558V+vaGPYB0IcmTu02oN/cHh6aSOJ8rZm?=
 =?us-ascii?Q?eQNCRl7RneHz3nfqfyjCiFfmEJMP6YrJ/9CYgp7HJ35OJ7q0j+VMcC3OQC6c?=
 =?us-ascii?Q?T4bR6NQCAvMMdpW8/HiIWERYoUZVxdKN+1nWAlJDfOH0k7VtaorVJhyf283c?=
 =?us-ascii?Q?d+aCBDNwf36Zx6cjStYqNao/ns0QJpDzVgBnEXr29O+B5KnhIig7gFzMjTu+?=
 =?us-ascii?Q?6Ev3h6+viNQS14e6ha8ldGfNJM0dxMHzEUT9vgJEap+QqwFM/EWq9aKH2r5l?=
 =?us-ascii?Q?3GJY7xVDP2TP83BlwKm0Vq12Qdz2AU+TdnKO4yEZvEvUT+/NZjK9APGC7IFl?=
 =?us-ascii?Q?rfK+EULc8dYzd1sBx3Nx2/TL8iV03douW+ShbT1Pyv9d5AcRXn1TI78U1NgA?=
 =?us-ascii?Q?nessnPaWUXPfH7nQQGaOEkIh6uojYI8jwPa2DYXf41/x3smrEZe5+wFf5LHJ?=
 =?us-ascii?Q?A8XUSYoQHc/Rx127TknnhorHJw9S5gVp9lZ2MeUYZeQYbQY0tsh4X0Nf950t?=
 =?us-ascii?Q?RUDF6lWmoP4cfy1vJV+zOGgGeGoD4oFTfZ90TpnIPkdgNKconR+DeLVDJoPr?=
 =?us-ascii?Q?+UGQi4uV3PKbcFPOIbKLdRl/vx29AlJkR26HVur/Zx+gPenPEkjZxzuSBt2W?=
 =?us-ascii?Q?aIOAo97h5Jw5XJVg2IJl7Ic7kThgN7ZR8NFby0GI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f6c66d-bb8a-4cb8-b952-08dd8427f4c9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:35:30.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9jl5aJPhqowct1uNzYTfq+m0aZUEAZF8WuC4bLncePMwDMJSk/9R0D3MjRcDocu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

On Fri, Apr 25, 2025 at 12:34:21PM -0500, Eric W. Biederman wrote:
> > What about something like CAP_SYS_RAWIO? I don't think we would ever
> > make that a per-userns thing, but as a thought experiment, do we check
> > current->XXX->user_ns or still check ibdev->netns->XX->user_ns?
> >
> 
> Oh.  CAP_SYS_RAWIO is totally is something you can have.  In fact
> the first process in a user namespace starts out with CAP_SYS_RAWIO.
> That said it is CAP_SYS_RAWIO with respect to the user namespace.
> 
> What would be almost certainly be a bug is for any permission check
> to be relaxed to ns_capable(resource->user_ns, CAP_SYS_RAWIO).

So a process "has" it but the kernel never accepts it?

> I don't know what an infiniband character device refers to.  Is it an
> attachment of a physical cable to the box like a netdevice?  Is it an
> infiniband queue-pair?

It refers to a single struct ib_device in the kernel. It is kind of a
like a namespace in that all the commands executed and uobjects
created on the FD are relative to the struct ib_device.

> The names (device major and minor) not living in a network namespace
> mean that there can be problems for CRIU to migrate a infiniband device,
> as it's device major and minor number are not guaranteed to be
> available.  Perhaps that doesn't matter, as the name you open is on a
> filesystem.  *Shrug*

I don't see a path for CRIU and rdma, there is too much hardware
state.. Presumably if anyone ever did it they'd have to ignore that
the major/minor changes.

> > static int ib_uverbs_open(struct inode *inode, struct file *filp)
> > {
> > 	if (!rdma_dev_access_netns(ib_dev, current->nsproxy->net_ns)) {
> > 		ret = -EPERM;
> >
> 
> > bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
> > {
> > 	return (ib_devices_shared_netns ||
> > 		net_eq(read_pnet(&dev->coredev.rdma_net), net));
> >
> > So you can say we 'captured' the net_ns into the FD as there is some
> > struct file->....->ib_dev->..->net_ns that does not change
> >
> > Thus ib_dev->...->user_ns is going to always be the user_ns of the
> > netns of the process that opened the FD.
> 
> Nope.
> 
> There is no check against current->cred->user_ns.  So the check has
> nothing to do with the credentials of the process that opened the
> character device.

I said "user_ns of the netns"?  Credentials of the process is something
else?

It sounds like we just totally ignore current->cred->user_ns from the
rdma subsystem perspective?

> > So.. hopefully final question.. When we are in a system call context
> > and want to check CAP_NET_XX should we also require that the current
> > process has the same net ns as the ib_dev?
> 
> I want to say in general only for opening the ib_device.
> 
> I don't know what to say for the case where ib_devices_shared_netns is
> true. In that case the ib_device doesn't have a network namespace at
> all, so at best it would appear to be a nonsense check.

In shared mode it has no namespace containment at all, presumably any
capable checks should continue to be done on the init_net?

> I think you need to restrict the relaxation to the case where
> ib_devices_shared_netns is false.

I think we will never check anything other than init_net in shared
mode.

> The network stack in general uses netlink to talk to network devices
> (sockets are another matter), so this whole using character devices
> to talk to devices is very weird to me.

It isn't that different. In netlink you get the FD through socket, in
char dev you get it through open.

In netdev you can't "open" eth1 but in most other subsystem you can
get a FD that encapsulates a physical device.

Jason

