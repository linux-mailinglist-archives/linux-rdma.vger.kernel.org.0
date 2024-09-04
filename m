Return-Path: <linux-rdma+bounces-4742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C407C96C09E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 16:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC6281533
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F738DF9;
	Wed,  4 Sep 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g754HXgV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011241386C9
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460280; cv=fail; b=Q91vAqkQ8dSUBIUs5kww12e6UqU/exC3ipIRJFdj7mTeq0wL/eIvL+Wgvl8DMCbM8s1O8h5wKfiM8REu+axQCcYMpU2uEdbpl/WRSrOsQkO91bUhkGxke+OSurEIrgWCpiJTOyKYy8rPnXK32ml5Oot1TY/j9Aowq5YFVK0IWMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460280; c=relaxed/simple;
	bh=NQCoCsYXnT1XnfQisZnWZpJYAGjNOIL7ru0VptxMVCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k5jdtF4qlEbfs9QoEOi8gblJe0Qp+BZa3apUMZBh1HZCtryTOxj4AKyRdKVxBQCUeNqQhO7lBNpam9lkCbwky6vjQMdiq1kygW73T54UiGSkZOJLJ46W5cfCL052ZF08UKkn1LDbsBy8M9yn55jHStf0PaHICjiScHvJKFMhM7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g754HXgV; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csDq1rnVXXF1Z1pe6sjy/BxHU3h+B6Z2siuQhWcHFzQcA9cSkbc/qZ9U6/R/foRsMxeuPj6rnrdSW8o4e7XhcgzpFB771N+RhiAleliNroxVmVqxZDsvpnFHgGZ/HHSTjCi4/gxr9Ct+FroOFRWYze6eay7XBsmTmY20+ZtVgLEBgacq+1S6AnP6IkSrnADp0Iej4Eb0idrk3QoDyqsavF2KAIbeMgNoUcuPKgRb8UPff1wvtiREqN1TG3ZLcl0MneEiOcfkNPIWY60duJi4pi5wpTv1ratbTxixVDJ+lHR0aXHwWAmOMvvHHKjfliI3FxLZQyHLLXMKikWcNEjpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FijW1X+VXsy+xC8KTqHmgSNQO/L/0pmLJnUTdKVvuoc=;
 b=DC6hZVtiuKhFGX8OXgV2m1ChjM+skBZ7ne2AG/rXVkeo6UzIZyj7lVB7H6jtdamDqBNq2DPE6F11kdBgEB/Tf4XpVMs+Tcdqszdq9kc4po6u+IYBbXVr1fP0UyLc91U44SBlmR9iaaqrw4HaIBGMX6+CsfegyUrlHj0s6EXJYPykQscnkRRrupZHDXDw3/PR0/cM7Z2mx1CUHOUPEFISZtE38afpg/JKLwBoY+vY9bYjaZgJrWh8ILzusGgTF2beZiADPq/3YhEB3gMyg1nGb7aGfvIpjhxazFroa8znhiErOUCsi+fkWOi4R7wtiggBK9FeaDvZb3x0QNUEWqZHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FijW1X+VXsy+xC8KTqHmgSNQO/L/0pmLJnUTdKVvuoc=;
 b=g754HXgV6r9LuRIg73mvY7e+6BYzrfBkWHYUAxxOk2IZRjoAbIm6U9ym64ZVKDC3K5DNbWTo5aG5c9KPMcaLqrSgZ21KWgaQQcbbs1qYq10PvNMIlRkr3yY/LBOrAb5q8uQGymC1rl+ccrFmMcU2b8fRs6FjMpL/sTw7p/BU8tUgd+PKllMk/c1vFFS9pefyoLgOlIrNMJz+CnP2VO5qvRzcHFms0rQnD4/kG04Ye1Cp3BCqvpcjCtX6bCj4pKGDwqtGqWxKpcqg+SoYDZAm4f21MvoDlTsqXAi2CGYWaF6+5ZLuvbM84kK4KWzyJhV2OzwSz7VOdqpsl5Hx4yCtLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 14:31:14 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:31:14 +0000
Date: Wed, 4 Sep 2024 11:31:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next] RDMA/core: Skip initialized but not leaked GID
 entries
Message-ID: <20240904143113.GG3915968@nvidia.com>
References: <7cce156160c4da8062e3cc8c5e9d5b7880feaafd.1725284500.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cce156160c4da8062e3cc8c5e9d5b7880feaafd.1725284500.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::10) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: e4783276-6f9e-4d78-182e-08dcccee3b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qfd8l0BhCi0akpuHea2+LWUga1MYu9F3Brg1tPd1dBsSBObUslmgWOmZukyU?=
 =?us-ascii?Q?rmHGJbDvIKK57vrjXT43P0Cy3KxdZ8iWU5k5cL+0BC98TpOzSpXt0ejQZw76?=
 =?us-ascii?Q?Dav2hQXmN+E3E56WvGzfzbGlDxJl/X8NZZpIUU5lHcQQTMbeNqhNazeE8381?=
 =?us-ascii?Q?vGoDUJ0/FF5Z0XwHxwya4XS54RepMV7Cc7ikhLoD5XNlqgpzm6vdogBw/NkX?=
 =?us-ascii?Q?TSxNXK6rOrD9/ypCKsfRs6T/UzXQZ9lFntVYaWd2TmMQECz7FE/5Cusmiufa?=
 =?us-ascii?Q?bIB9q0FclRsfHQdFD86DX6XF1fDYIdOCrcKZ8dL5s3/preE2rwTSP36FNznl?=
 =?us-ascii?Q?NbziS9ZLWWIA4poVEwDbIOpnfs8l4xnY4nhVtJuiTafZ+yGImqk4Id29ey5G?=
 =?us-ascii?Q?KIkcRva5Y5HFD1LiG7vgK8TXnThJgygThEoSMZE7/J6fJR3rdnb8WBH4SofU?=
 =?us-ascii?Q?40E6DGDPQgSMGN4TO3oLv9rltCuZTvvxilll881al+WwWVmnKE7L3IZ63yuM?=
 =?us-ascii?Q?nEiKy9CurnLUtkuMWTJLb1XFfIkD9VfXIF6gG5oqImvqjIzmvWOUyFu+I9Zg?=
 =?us-ascii?Q?19Ux2yne4qLcyFpfHuD2NQVZWEgFd8kjDImTiOZSgekmpIq1ukT2CEaEWXtU?=
 =?us-ascii?Q?bC7SkI5SvjsVMbRxS6aVzAwaFjHuTS+WkSFJOHT7YgLhuI2qWSrJ6sbarPpd?=
 =?us-ascii?Q?Y2xx9pJoJiB545iA3tVed7sHMiANa5V77uvnoRG8mNPHXgPfCHoAPtG5tSEW?=
 =?us-ascii?Q?9KTweIuLPSTFFgLXnVwchkqfly1RqQv96PJx43NSBAb0yVHrg3udd60n5KKX?=
 =?us-ascii?Q?SS4If+dPre+kT7/2z9reEYMFqnFfIiZufKNd+/A9kzjtX4PgXG6vS4e4huki?=
 =?us-ascii?Q?D5/NQ4aSZdTiR/zX1ncadZeNO8Hfdd0QltmRXGR4ZxTg4NsCSPdaV9Pe0j7o?=
 =?us-ascii?Q?qDyXC36LMhd+EgNgDHvE1ogCxlCMTRGkrC+o1ydz7EcgeSPx1M7AeR+MSTs+?=
 =?us-ascii?Q?RRfGzQo+08LeKvSvBCgWt9l00OPwKlI01vE/6TATLzwndJGOp3FmQnbRHrED?=
 =?us-ascii?Q?xmZ94qQ5wtImuDEvodtMfVW+i8dVlusSw3UI2gaI4uxwBITVG9Hxny8izQQD?=
 =?us-ascii?Q?vUEN1zFyaqpcOWzFFTffmkY/TKvMzg8CvUPLaa0TuHHcimEgMpE+jqrnIGC8?=
 =?us-ascii?Q?0cAv0Ew89KfsRYCH4l1MNRaOA7y4saFD7pcpRSlB/phaAVt0QgWY0gCJEbdK?=
 =?us-ascii?Q?OKLvf3ka7JjuZSL64Fvo79TjGxFOkzb+wo1QHV8DbID5XnWIXKzKdPgtz9HP?=
 =?us-ascii?Q?j/jPKapYq+6DewJIn9wMxh4W1/mE2Cp2KRMj+TLWXHpt8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yYnMUFiJtP38AHzDUHtJoEkaJw9/PiCbJvVWS8t7NhIChKAw8hrRLS6KUW46?=
 =?us-ascii?Q?k69jH62GQzu4dN3z0mHnrmd5Qi0OTlFahpAT9P2f/ujZ8LqxX5cVm2WGNINA?=
 =?us-ascii?Q?QM6btNT9mfT9vs1y4k8Zr5UTnGiTv0Au2+32MBEAi1cuZ/+yEkckLQUWvjOJ?=
 =?us-ascii?Q?a2UmvlysDHEt5L3MXFpYrUValfL1cyfeyTaulawdvtW4QsfTiQDVHMpeaAT7?=
 =?us-ascii?Q?J1nRJpoOAVYQjTskMZOIJPn2m5afl/QLsC5Ngdgev59fVsJGXENymhCkE2Yo?=
 =?us-ascii?Q?2gjZow7bPbtkZLBhfrYG1oRnIJRk5PBdcZqXXx4ZiQMzkf7XX8SEaBYf6jf6?=
 =?us-ascii?Q?oz1YPlDAoAy+9H3/d4TCuoBFiDmo2444klIyOOkr/p+czKgFOxZdefjjc6oe?=
 =?us-ascii?Q?nQMoViRBD/8LYCGBJAGDindf1Ifbhlvu095X6IMJk+2NmWGdF7a9F4VXc/Gt?=
 =?us-ascii?Q?nGVolxKlVSYCs/EMDP6S8pYVxzJwBRFOtCvt/7RRvBfAToDc9+3zHP2YeDT1?=
 =?us-ascii?Q?eZut7h8BrFLG+nG1oezH3bYO2aZiIOP2L6uZDBaqAJh2n9FwisJcO3cp67kD?=
 =?us-ascii?Q?lfRVaWw/GK0zIV8hzIkOHYDmdzCtIZMiozatLFwj9J9sBFBnTc5xCRMll0ke?=
 =?us-ascii?Q?HNWBg1Q+oabRBqbo8hddZpHLeu1EmjWrhVxpzdDWVyun64IPq/+f/7RtBoGB?=
 =?us-ascii?Q?hCi5ART0h/+P5Uu+w6g6WY2BwIV/BVb8z3JnovnXS/IqnzRCKHdDqKg9NJKX?=
 =?us-ascii?Q?VIUAFtc62XwivYDVkIKMc01PDP/QUBqUHsKHemIbsMkDPwIIzU3+0TppxSEl?=
 =?us-ascii?Q?1+qGabmVUhb3wfPENQWXQ8Os0tTD/LJDYtEYoKosXCJvWg4zH3CY/BNRIlXI?=
 =?us-ascii?Q?7qt8AXYNSy1A2dQyzztLKfUqNR2DtwqoTOOMHRf0GZzVnLjGbLYtmmVpBW1V?=
 =?us-ascii?Q?4fYiIqUfrrdKK4aMyZ92BM4DMAJC8oEboM45BeJ11QJUqQUbeKE7ntw+zIAW?=
 =?us-ascii?Q?rI56oM2FxC0gZIHk9PdlhjnSdwtXjXSZCzqRT196TlanUoLM9/MN6N1YADmS?=
 =?us-ascii?Q?MxmWYE8N5Kj194Pcwhns65QAT68yUAMWanhD7y9b64thYWM2EUX22dO5PC/2?=
 =?us-ascii?Q?a1PnnFLfV9U+pC1m/J9cUowWdMXs805WI9LcWvOTWxJq02re0fVvFUPtwEGn?=
 =?us-ascii?Q?H2aYpYkD+p1N32GiFv3CF79JDY9hyeo3TMcOw1XNoMQV3J03V8hmoabes5MI?=
 =?us-ascii?Q?LZYC+f3gLLz0rZuCmUDpccFm4qqKhHlwf7DtKKWzE0mkVOpTOpek1kmSjI9K?=
 =?us-ascii?Q?fZnmuCQWq654EaEv86B8dc12Tb6tqRh8uuyJ4Blcc/kD61x2fxzr2EDmg1sD?=
 =?us-ascii?Q?wI79hi+fhQrBXIFX/G3PrOMNcSfAGFFUokgzYc3+LWcthygTsEl0BqE+uRuk?=
 =?us-ascii?Q?Yz/mqHWQ1YoD4JOeEVocZUE2K3YxO4dgXM+YCLGmgbkyo6GWZarvd3De3itF?=
 =?us-ascii?Q?Zao1lAnVDedJxh6vCKFi0qCU2Xb2DA0wdZmbDjkBvj3FSIbTAWqgKjWPL+7V?=
 =?us-ascii?Q?0u+n9fc4neetwrNmn54Uf2YmyDuQvNL705qaZBbP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4783276-6f9e-4d78-182e-08dcccee3b02
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:31:14.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuyjvVEu/pzGh7LHgrdCcLngUSO5Uw2TOL6DRhHv74BlXg4dBOoKfJu4HPk7N0uy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439

On Mon, Sep 02, 2024 at 04:42:52PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Failure in driver initialization can lead to a situation where the GID
> entries are set but not used yet. In this case, the kref will be equal to 1,
> which will trigger a false positive leak detection.

Why does that happen??


> For example, these messages are printed during the driver initialization
> and followed by release_gid_table() call:
> 
>  infiniband syz1: ib_query_port failed (-19)
>  infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache

Okay, but who set the ref=1?

> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index b7c078b7f7cf..c6aec2e04d4c 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -800,13 +800,15 @@ static void release_gid_table(struct ib_device *device,
>  		return;
>  
>  	for (i = 0; i < table->sz; i++) {
> +		int gid_kref;
> +
>  		if (is_gid_entry_free(table->data_vec[i]))
>  			continue;
>  
> -		WARN_ONCE(true,
> +		gid_kref = kref_read(&table->data_vec[i]->kref);
> +		WARN_ONCE(gid_kref > 1,
>  			  "GID entry ref leak for dev %s index %d ref=%u\n",
> -			  dev_name(&device->dev), i,
> -			  kref_read(&table->data_vec[i]->kref));
> +			  dev_name(&device->dev), i, gid_kref);
>  	}

I'm not convinced, I think the bug here is something wrong on the
refcounting side not the freeing side. Ref should not be 1. Seems like
missing error unwinding in the init side.

Jason

