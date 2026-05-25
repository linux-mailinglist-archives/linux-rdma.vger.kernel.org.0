Return-Path: <linux-rdma+bounces-21241-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAetEMRvFGqXNQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21241-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 17:50:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF75CC81E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C259930071FE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884D33F54C8;
	Mon, 25 May 2026 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sFezzcwp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D133D4F5
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724026; cv=fail; b=Ev9gO+R042Q9YI6AbrBhF/5vtSc99xwI8xgmYeXFh2j4NSXtPH2IegjUgzen5ImRndQdJAzo1fHakUhYkx/lfrXvlnu8nk5yjHqcoWwpUfka67kLseaLTRRtgTyMtcUWCpDZge3th2Qnvpk5gc0i3YmfkllK8bkErYZwrWPsM+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724026; c=relaxed/simple;
	bh=YVi732moDY84DqZVajncFRuGqbKRvY5wk4ZZZhGHQH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t9r+0NYbho1n+WytQabd3U9O00io4XXN3it2WfMP0PNy+1ToVqhYUMPdkoZXkCXdyKuq4Psz9BHTCocPgqfkjS/mBmmB6DIAfsqfecHNJfQhYDG80NWScFdRyWCY9aGo6ghLCDuAo/uCGGfABc+8C/cSU4tOVwIluJoRMtfXPdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sFezzcwp; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oftZYEGtPDakP8KCKgVbFhM4wDUTAnc+gvVBJnAa+NM4juxZdjRqy90mLf4OzJG6zIrDehtOfSS184d3Areqw4otgozI6Ho/8HIGYZ7NwSmXqaLudhKKmioFACYkAnZzzA6h1RDoPZbxDR6aF0Z8eZj5xUP3eU5yXvZwnYfITYWs9kmdDnIXALe285YgZ+qH8PYTD0AoMjO99KnOh0iyQI314L9drPUvB07vBvxz8QQ5OyyAHGIxKrKH7yi7WB94u3Rw2QSO7ZqWhn/IjDDPNvdz6LqP3FsAsaUo0gM9WD63CMQe2cCZTbp47OpMsIB8oPQVvnv/qDhH9sF77NpqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mytnPYMmg9OJHAjlLhVLlJc6NSK4yZ8he+rb2QXfI8k=;
 b=QStkOkup2WzT28nb9uHPa3ZsgLdYOcfLu4kmlWp93TvWln65RMi5/DkWeAurgJCK0ftFq/eUIng+xa8a1pFILlAVBzhNNWnbQzcV2RvtBaO7E2SNiVO+jA9jZVv+Gg3OMV1h2OcwpWkKgHfxKUkS4szs42lYU2AN1rut2HZtU+IpRS9ga1i3DjDuy50bAb2c7z7eYPLF0MiohC0eGiw2cU3l5qHlKbDAaJAkHn2OE98OGPVoPg+eLp9xW1XxaAkzRSA74RIho8DqgUuz+j0lTfGsEiODu3lp9m1nxxWWYKqihE9B/ykN7b80z6QfTViGI4A85k3BQwnNeyk6nEUMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mytnPYMmg9OJHAjlLhVLlJc6NSK4yZ8he+rb2QXfI8k=;
 b=sFezzcwpFf4+28jPqSrkF/M414pBnDEeguvDbHA/SALrrZVtnSGyCDXlBQcfpFEJmWql3aAtKXjXfp9UFD0Gxrxp+rqqYLAKpLPfSkiNsKPSLyhEriSv1xR8dLIzLqs1jnh16ZtMmyYU2McRZvDAlcpPBe2C5ckEQFoQyRXlWekb0P1bky0yVDdg+idTEMf+r70nNpP6e2GeBC+dC9sHPDVaEJf2e93hnQtNZeZ/r85XjurDgEQ28/tti16UhNkivEL2X//1e5SjXEFYLVQQeAZBqU9FxRx+Bi1zTpkJX0kEGUhInr/3OmOFilBYwVqncnW2Ey5Ak++7WLk9y8by3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 15:47:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 15:47:01 +0000
Date: Mon, 25 May 2026 12:47:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2] RDMA/cgroup: fix resource leak in
 DRIVER_FAILURE cleanup path
Message-ID: <20260525154700.GA2483194@nvidia.com>
References: <20260520115506.1782475-1-cuitao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520115506.1782475-1-cuitao@kylinos.cn>
X-ClientProxiedBy: YT4PR01CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac26f4a-853b-468f-c7fb-08deba74dc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vMHjXaI1vT+Byav+QiqPUk1aEOoB9y3p1vZzGuqQar8/R+s6RgHpef6Dyy6bdzb2WydjxjgQMq6HwwTax//lBx1RRpqXPX/87tHgNFFVJ4vIokMB0qoOvTix6TfzCeTs19VOqCJgADZ6siYWxRQD/q+JJ/8E7qrY3dHIk8W8ytKc1q15x5KdFe7i/cEJXW3fmZE86hy1eQYbVngukbUm2PUIlsu7BpN0io4XVJ+iVc8Mguo4J3VTEASExrnr/mok3+ydUtHvJwDzbNGYIvRqC1Iy/ycR3rrh2AjgKaf2yVSuvUIOnRxefB8mUaeLYbx0tof0PNfeZXLtsYWVaNSZksUhkMTBEsh1CwN6bocE00PAX2mxIyPBpNXvhzfXxOtBqcefAEW69a1Log3rdXO298ul4xT272ZnoU1J+zi8oPTQeBfC9RHXz8Z0bzyEMzaoidcEqldqo+8pMPWOhpqGkCfUbnMyGSzjQ19WHgjne3oR4zG9f+uZHQ6+PG3vA9iNprxYlKrcTfM1QZwghMtUIXtRW1ir3c1Tsdcu8JmPWr2zEgKd22PzDvDCdrgJUo9Cb6XCapXuHNGWhtG72wXtqf9156VwydIch94SGale58KLQQ0Xfnt1YSQXIMP9Pv+DzlHCnUqgSftwzzD8w7CLempkCe3lyhIUUt3VWJVMh62D5HLxTBj21tO2Et8/lD8S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BKkb4iHjcKrK5RXD4zJHAu4bffYz8fC4gPef1GqIUlzaVt4ijEhNs0940fEf?=
 =?us-ascii?Q?ouWqwYGPj1QgSorCx/vuUYGshYXqY+xod/mvGU4MuDL4Pj1WpBzHCgn9QXCD?=
 =?us-ascii?Q?OfMdqCT726ndHVIv+BOqGTFI/mlfvYexyPGPY8HppFfT2c+4TsgP06jTfg1d?=
 =?us-ascii?Q?UihVW5JR/EITYv9sVMCo13e61csZnTfrZHk5KDqn5b5TsJJ7FIf9GnNmtfd5?=
 =?us-ascii?Q?gj5v66NV9xwVNaRFrL4ST5PmLvBj8aee02k9Cy5/tlPH4+OP9OWu0T3UQclr?=
 =?us-ascii?Q?6X6CBAvWql06DCbL62I0bLQLobcIAD+QyN7YFy9A5F+0aHg+OtW3GcJQk8JL?=
 =?us-ascii?Q?Ih0QvhnACIns3zQUeDAkc4RwLgFYQIJs9CgwK1qX3NBQ2al39x2n0qC9UhX4?=
 =?us-ascii?Q?npipLUKv40Q14IlRXkIlqnTmOdiYptlXVSDBn1k/HQu4FN7VxjJEOZhI3st5?=
 =?us-ascii?Q?z21vQcg8T9VNtDlisFHf/ZG/KtNxod8Oov2VlsiQEW/sHU8iRxkGvmtpOKab?=
 =?us-ascii?Q?PmluRdtD4YAMYHgFk7DZ5tenU1qvB1J0I2cKWFG1RgFUjIPAqoWb4HPT4kxa?=
 =?us-ascii?Q?Sv6CnNTEPVqh8c2bD9Er0RSL/UJhqCR6ZTwaVgHg7+Q/vK6vE+x71vzPl4R5?=
 =?us-ascii?Q?Bg8htvbyTgzoXNA0AZYgDoCL1NNX3bmRJelaFzLEzVyMo6JT5FqotY08UeKw?=
 =?us-ascii?Q?6oHReQx1ZLta2lMXB6vVRPm4owQzEq3PIxP+t0w3Tc9rbXQVIjG+y5b9ZwLK?=
 =?us-ascii?Q?JP1i9BqFmQ8C+mcSK6qfaSI5w3ABi6RLt5KmDBDgzt0FdckdXEzJpSxT/JYq?=
 =?us-ascii?Q?2TLa8bjklqLhX4TiJxWqbl2lZMIQlD7zqJGily4dvOViBEgNVJEqK2V09hma?=
 =?us-ascii?Q?pyCpFvwP2h/qUROLUZi5up8jxLpjMNz4+7iYSR3F5l/TABsXSXuWuu0qkAyI?=
 =?us-ascii?Q?d4oX4JuULer6MmH67MvzImrt7ARJqngpspIrMxYN7zUC2hPBKZhc9Dqf28R7?=
 =?us-ascii?Q?44McQVRU2cgrjRMDBASHkRD89nylpkNsenI0zB9MhxSN++oJyS8TbB0laZ4m?=
 =?us-ascii?Q?eFEBNgGOJHqqDN5VFvNVvzEBYmh4dd1je9wW7XrtCnLtMnKkOZHBh0dtRngf?=
 =?us-ascii?Q?k6uAVCDs5s+x5RXbNHTwq7R/CMZw42UJ38aSww0OCNc2SU10ZfUdpMgjD2ru?=
 =?us-ascii?Q?/UwTZQtUW8B5NUe4D8XUsfb8ib7oX7BSXfYLJENCdnZC7rnhpJEUvmmlwjLa?=
 =?us-ascii?Q?u459aL3wj2/mI6QeXkOcE0N4MFEN1DOaWXY1FqeXRev8EkTv4wU3ARTspA7/?=
 =?us-ascii?Q?KB76sOzZcDpoh6ZizJEIOq+2dipuuZFobgxPcelcitDQjo3toEstN5DFE5zB?=
 =?us-ascii?Q?w5vowwqfmWxYzE0flg5hXsW17C1aglBBo6kSCJeKYwuE0Q6Fds3ZHZXaMEx6?=
 =?us-ascii?Q?Esh72dKRzAG8YNzEQTbvFKiUX0XEJaQVJzypcjsLnAiyCBsWOv9xZ8WxS4UJ?=
 =?us-ascii?Q?khzwcWJi47fnx22IHL5ke2sk3xr6gYnhGqnJlP4VD9mvazeEpdvm3YZOomU3?=
 =?us-ascii?Q?hFPjtWO7tLXC9PBeXo/IgziQB5Pm39ObmLumRAv6SNS+Z9g10JQAG3mRz1OX?=
 =?us-ascii?Q?NjV2dsZsQyUJZaz5gdWihH5bhJbPOUypCR1/Yc8jdCxgAEf5zqQt4NY2UoaF?=
 =?us-ascii?Q?K+nMclZqZbAE/Y6RHbsJVMfZzQQjbswbjAjGU7xTPgbwgyDu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac26f4a-853b-468f-c7fb-08deba74dc65
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 15:47:01.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kAjdXWM3qOppDEWu7ekQdq4vdBi5DDbNUEqPuHzGyNuKqt1Bn1uojnwFSl6SiGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-21241-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,nvidia.com:mid,cg_obj.cg:url]
X-Rspamd-Queue-Id: 86EF75CC81E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 07:55:06PM +0800, Tao Cui wrote:
> When a driver fails to destroy an RDMA object during ufile cleanup,
> the kernel retries and eventually falls back to the
> RDMA_REMOVE_DRIVER_FAILURE path. This path sets obj->object = NULL
> before calling uverbs_destroy_uobject(), which skips the destroy_hw
> callback. Since ib_rdmacg_uncharge() lives inside destroy_hw_idr_uobject(),
> the HCA_OBJECT cgroup charge is never released.
> 
> Add an explicit ib_rdmacg_uncharge() call in the DRIVER_FAILURE path
> to prevent the resource counter leak.  Restrict this to IDR uobjects
> (type_class == &uverbs_idr_class), since only IDR objects charge
> RDMACG_RESOURCE_HCA_OBJECT in alloc_begin_idr_uobject().  FD objects
> never charge this resource, so their cg_obj.cg remains NULL and must
> not be passed to ib_rdmacg_uncharge(), which would otherwise dereference
> a NULL pointer in rdmacg_uncharge_hierarchy().
> 
> Suggested-by: Sashiko AI
> Link: https://sashiko.dev/#/patchset/20260518031541.1552942-1-cuitao%40kylinos.cn
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> ---
> Changes in v2:
> - Add type_class check to restrict ib_rdmacg_uncharge() to IDR uobjects
>   only, as suggested by Sashiko AI.
> ---
>  drivers/infiniband/core/rdma_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 5018ec837056..4fa14f27b76f 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -917,8 +917,12 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
>  		 * racing with a lookup_get.
>  		 */
>  		WARN_ON(uverbs_try_lock_object(obj, UVERBS_LOOKUP_WRITE));
> -		if (reason == RDMA_REMOVE_DRIVER_FAILURE)
> +		if (reason == RDMA_REMOVE_DRIVER_FAILURE) {
>  			obj->object = NULL;
> +			if (obj->uapi_object->type_class == &uverbs_idr_class)
> +				ib_rdmacg_uncharge(&obj->cg_obj, ib_dev,
> +						   RDMACG_RESOURCE_HCA_OBJECT);
> +		}

No, this is AI slop, the point of this flow is to try to keep the
kernel hobbling forward when it has experienced a critical
failure. The only way to get here includes a WARN_ON.

We don't need to do any more than the bare minimal to not crash -
which is only to clean the ufile->uobjects

Jason

