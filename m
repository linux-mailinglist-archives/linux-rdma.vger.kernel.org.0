Return-Path: <linux-rdma+bounces-19093-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GWtGDMS1Wm30AcAu9opvQ
	(envelope-from <linux-rdma+bounces-19093-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:18:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31003AFE5C
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B054B3004DF8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E623B7B96;
	Tue,  7 Apr 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HUS/E55P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2973B8BD9
	for <linux-rdma@vger.kernel.org>; Tue,  7 Apr 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571463; cv=fail; b=aEU6ZYmxRGHRrHJPILSrL0GozGLAdZn882D7D9h9q3wQ+V/izm56f9+6x9kRzgsZI18mcvw7rTNOMWl/O4ZuN6j3AvLg7+gC2CAUkHLlX60DDlHNpUVRJTteu+ocVvHqH5Q0YtLH1NyerI+un7uiSYOExJcVKQXhHawrOzPJaN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571463; c=relaxed/simple;
	bh=bzarty4WQE7R/BeVfOcxtnF4mmxEY03fUA2AExGlgG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nM01Y79uKM9Nd1HQn61B5ARE682iz7akIlRZAJ7BSn8UYAmudaztOF7gg+IoWYn8Mg8yXZwRDoZq7yCromL2qFtlsvlXkM16nUcBuI3NGIxIBgnrkjrJlZ7XF2xJOMXwiwBoOgKAigY2tmbORSwXOGTBaLGAjNMBDkBXlwbUEXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HUS/E55P; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCAmET83+2GY27rwm7dcqcxva2DyA/4RunmpQPuDbH41qVuX94Nf1zRttn1EK1QGq1S1Fl5vEC6uENUHg6326Mh1Q2bJVZYXp80NPwwT43Jh2pYIV+zWKsbOpvgtBFq3mChRqxKIWC7U97C9TOYenQZHpk05maQ4feuOFc2VDKTIOSpgJq0l01jcM39XLT2V6arJL2ZAsN/VrQmGOmK3P5W605afdiqwHdqYf2AzYmUz4lhiB6qM6kM4299xcl9SVXA7oSiBypM/jKz5wB4Nc4W0sJQAliuwGy/TnL2bAVWil9C8yW11cHyfSN6K2AkRj2tYx7c1TRw5500U0XRQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoeoGdoI27RPop0ApX7qJ+clgg1civKx9Xdob8wIz9M=;
 b=dB+LAVh/bFmIzjN0k/yaXgzWYZsol15yctrkV84ZmsMDoAP+CCgLRX+WtSOIweESiaDDPhAtWhZOccctA64yr4a9WF8xZAr2rKYRDZn1AlP1yWCLFhGeX4aXyjWg7yc7DrhasAGiHnkr19kGU7WBplYCnelhXHJnycfQ/dnwt+eKFU3LEKk/PulURHk6GlVJU4OL2uU+aDARQzv32PXWsGlb7htVHsJgHJkGa+0NFS0sq7D2MkwFxQg5wJ2ZgHgePTcXT7/dk1u2a5zVPBJLqoBu4R1sxqXov4o5P2qmLDQ8yvamq4TUROVps8SXqZKWXsA9NMC6qSg+Kuv+v5RM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoeoGdoI27RPop0ApX7qJ+clgg1civKx9Xdob8wIz9M=;
 b=HUS/E55P5/ulag+Z2X3f39S8ZhbAP+qVUwbno67jyl2f+0+++2VpnV/Ymn0bf9c6a7/WnUyMt2qBy599kwDP2H9h6GQzDezVFli+Gny3ZP/IEMsGuOD2DxkoxFPkpzIXdFhsivdhaKA5KWh3JOsNSL3exqNHszpS9q+3T37ZYklnrw2FsJUkZGSFlTR/RanUiSoJe+rcsT9PpfhQHhWEOl11mc/xvo9DAtktE4rG68Qf8v+FhwxrJ/XIkVX3oMjcdNAFq68SnlMMyJRKY5XMniIBKP7AqIoRnGoMLV0+n3FVDZVXMMTsha9HIpRPSGia4NpyjZPZe8+Bg5+6L42VKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 7 Apr
 2026 14:17:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 14:17:32 +0000
Date: Tue, 7 Apr 2026 11:17:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 1/4] RDMA/core: Add Completion Counters support
Message-ID: <20260407141731.GC3357077@nvidia.com>
References: <20260407115424.13359-1-mrgolin@amazon.com>
 <20260407115424.13359-2-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407115424.13359-2-mrgolin@amazon.com>
X-ClientProxiedBy: MN0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:52f::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: a2717a61-ec08-4862-46d0-08de94b068c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X5k2WB73Hv7fgMdajnldQxRaIBfMH9V53F8utClhoehqM4iHD2Si9x+2tG/ldVlvHMXrERLn0lvDxdmmCn2OovpNUMjZ9gitFfMrCdgsiiEza+XYAJRATt0ISwKub3oBl3r+sIopeTekCKmGmPA2mAnEpUwU4TIIMlrwneLxjkt/uq1LdwRqPQj3Pi4hnYwm6yEZbbHVsjj1+BmC4h9ja/DDWne1kbJRIK8nE1W5YiVguWCqTW0uwcPsgSKbxd914JQscBussN7zBglOqD9ML+XFUTW51gtWm68ldU5iUE8+MuG5XTs2s/rlAg2JL8qBhnC0aZyaeezT5wgHWl5BFb0Oo3hVhA2FGkVSczXK8z2lc/EnhPVtUv3qEKn3t6KIfSNp+YGCoMtaNyicWRoeyZ5jAb7JzI5fYk++p1IttLxksVCdD3/3+xyUE/FeZR6Zq/U8DCSHOC376rHu7/twaeh7/5ezjdt5VtQmJ8FC1yglf2gCmrsLg9trSOMC3n+zbSR1lmjQJvuRsrkosCIQajsW1nhwohphngJzVQz4hElZ3WliptgRlY5YniOWwjn2xcA9v2BGz8lrvlYvRHyGhCDuWOYrmVsVcX4u074FRwvsNd0dSaetNKeLWWGmjg913g6xLw5ST1TGH/jJTS1/IXBrnxdY1mjaUGswEOmtKSJ8yQRhCLp4BPBcuUWl9z66TOjImWNv53rQbo/gWDfALXBrxZ4ffQqfZFmcrdPte0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yoi13ndV1uZyY1KVVdP9Awz6dU6Fb0ytDff4fHpcMLj1K/6LpL+LH2ShY2oQ?=
 =?us-ascii?Q?jafIeibYZTdP//PiiTRlWBl10/UPJWe2PcTF5TxdkdFQbS187exlmpXHdxj0?=
 =?us-ascii?Q?dvmczOHe+OOsXupmX6Zeu6GUfypVgfhEsqqVl0g4vPyERdlQv8HA9JuPO5do?=
 =?us-ascii?Q?q/MAY7+e0TITBniDOZyXf12wVwlDm4PfWQwoXOQUZBMjOCA2lW2/ZRd/eJCw?=
 =?us-ascii?Q?UhNIAXKkpPhqiq7kChQjex5jw6OGqoOyd9Lp6lL1ACG+FJQofKaw+T42hVg+?=
 =?us-ascii?Q?7SdhOL9h+l5eO3ozGwjThe9iYGdq6S5T1D22zCcJCZSD/4dJV98uUI73SRq3?=
 =?us-ascii?Q?31IZFZ7zcgtvtt0ikR6Dt/cIZyfr9zuWb0vncCZ4jnHbxdHGYc+nxu6cbET/?=
 =?us-ascii?Q?VjjKU9NZac35Km03Uc2C+wTi6EcDW8oJKp0DtIQVBVfFG1JrentCRVZFpFqa?=
 =?us-ascii?Q?7lWAqFaNARus7jBAMlu2KBlxuPcYi0SkvAzyedCxfSUFC+ia9zwdfDerzw1Z?=
 =?us-ascii?Q?FQ5GTNZcpfzTkCVyqyw5bE1d7xvScgmN6UQgx8X6HwV7EtszWM1vNTDD8Mme?=
 =?us-ascii?Q?0RHtZxvsaUPgD4jJax5b0gwEGYRBMmw5b3ZnUK49cvRFpnIJ1WGn+61Hlc16?=
 =?us-ascii?Q?HIugnrdElkTZNXQ1DndClFR2SIWWMftdYAr5eMcFZx6oXLbATbGzH98FWO/V?=
 =?us-ascii?Q?Hb9x+ZwPrzzDIF13bPMwkCHV1Ek+BdXaS5b+1owrZVcFaryYPfb98TYztIZ1?=
 =?us-ascii?Q?ULcnW4ed9phS+7VnRbDzz3oGDNsTva2KpuDZh8K2BT0xhrYL2eHJkvhT1sQP?=
 =?us-ascii?Q?IxsPW+KW+OIVy7hs+hiUASPBNV5nW7mWUM6fYeOfGkJYcQhY+cAAaQrwgR7B?=
 =?us-ascii?Q?JcM/KbrNQfSF37EBI94Q23EFOt+7FsidfwnbHcfhIwgr1Myn5a9guOiK/bOx?=
 =?us-ascii?Q?MCy63imDUNVy9TlR9sB2YGJy2Hdk0ik10UTGsyGHGWXOY93u+RcYG09onoj8?=
 =?us-ascii?Q?3UDvrr7HOyNIUprlhNrT8Ckv9jFDawtrb+A7zqwmVxVOZ8MJ1cDzFMX973ew?=
 =?us-ascii?Q?lqCmD2FvbQiZnQ3imDttiOtOUeB4/atvm7RhwiJCXVFRfjyFngr1Vp8a1w/n?=
 =?us-ascii?Q?NgN07GJjCfnZy8N9Zny4FkXZ6tOFPIc7JfTMKoj1edHs3mmVOcfc397WE+9/?=
 =?us-ascii?Q?PDhoxW7h+TL/sXxfFRBOldThpzA7MivCa2FM5eY375z0a8Gnc+uEI0gDWe/o?=
 =?us-ascii?Q?2JprZ5nbq5LBvytToJT4yJMszTjBKl9IER1DbCk40945D6VX+vWjJWxWNeE6?=
 =?us-ascii?Q?cxcovlVQZkRb7PL0yV+17TzGZk6ELv4wK8jB4l+tiNlZNGIa5Fbsxz26EO4B?=
 =?us-ascii?Q?1eXZvKS1huqiaXKHKjmE3hvqOVA+da1KhKxJNr//1wLS4DPOH9T6hy0lCc/v?=
 =?us-ascii?Q?GiW9m3CDh+l4ddIHf5evzZGuPmYa3GLkXqjM4Q7EakEFC60iJyv2Yt99fgGA?=
 =?us-ascii?Q?mgCVkQecROHNXfhe5tFcsijUUNQGbj37Oo5fyRFMwdHDqCnIZW2C5aFAkJi+?=
 =?us-ascii?Q?UOCjdQZqyqnrrR6Lnc4eDLQdBITp7vQ6ZQzM3OoTQWC/drVqZ+fTP4sAX1uk?=
 =?us-ascii?Q?6jXT9PKBlr2wXVObB6Rxms691e4AHa3c/9JivDJ+0jxk9azBehKsDAULhC2/?=
 =?us-ascii?Q?2X8tj9+X5u1098kUhaQ/VHNNsVqMhwxog1Z/qegvTkYzQEbc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2717a61-ec08-4862-46d0-08de94b068c5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:17:32.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ9hN4w+StxRJTQCKhGbK/8OcsES04cqxG56Yi7z/BnYAvX4lUVtyxJ4N5kUyCru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19093-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: F31003AFE5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:54:21AM +0000, Michael Margolin wrote:
> +static int UVERBS_HANDLER(UVERBS_METHOD_COMP_CNTR_CREATE)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_uobject *uobj = uverbs_attr_get_uobject(
> +		attrs, UVERBS_ATTR_CREATE_COMP_CNTR_HANDLE);
> +	struct ib_device *ib_dev = attrs->context->device;
> +	struct ib_comp_cntr *cc;
> +	int ret;
> +
> +	if (!ib_dev->ops.create_comp_cntr ||
> +	    !ib_dev->ops.destroy_comp_cntr ||
> +	    !ib_dev->ops.qp_attach_comp_cntr)
> +		return -EOPNOTSUPP;
> +
> +	cc = rdma_zalloc_drv_obj(ib_dev, ib_comp_cntr);
> +	if (!cc)
> +		return -ENOMEM;
> +
> +	cc->device = ib_dev;
> +	cc->uobject = uobj;
> +
> +	ret = comp_cntr_get_umem(ib_dev, attrs,
> +				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_VA,
> +				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_FD,
> +				 UVERBS_ATTR_CREATE_COMP_CNTR_BUFFER_OFFSET,
> +				 &cc->comp_umem);
> +	if (ret)
> +		goto err_free;
> +
> +	ret = comp_cntr_get_umem(ib_dev, attrs,
> +				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_VA,
> +				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_FD,
> +				 UVERBS_ATTR_CREATE_COMP_CNTR_ERR_BUFFER_OFFSET,
> +				 &cc->err_umem);
> +	if (ret)
> +		goto err_comp_umem;

Seems a bit weird to have two things inside the object? Why not have
the counter support all events and if userspace wants two it can just
create two? There is alot of code to support this err/not err split..

Did any spec define the API this way?

Jason

