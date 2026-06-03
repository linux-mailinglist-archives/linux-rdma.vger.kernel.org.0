Return-Path: <linux-rdma+bounces-21660-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BpmGCnx1H2qHmAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21660-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 02:29:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A43633347
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 02:29:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VcRr1AQ1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21660-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21660-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C1073027705
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 00:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B0221FB1;
	Wed,  3 Jun 2026 00:29:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C882BB1D;
	Wed,  3 Jun 2026 00:29:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446583; cv=fail; b=XXb6jE7qTob3l9UhWm1AiD289ETXj+7QTaZYGA/KO8AnpIIIxi6a4kzscZYcuf3/3sirtOUozUW05AwnEYGsrg91puKpNTixrlxUpf2NIUoY6jn2IlBqFfoqi4GInIXlRzkGFHqg65HdX1q22z9z2wE5fMZrEDcW2DCQOvabzbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446583; c=relaxed/simple;
	bh=mmDZY9Q6ifERnc+QGMZi040eXO9Y9LBvsBKJP2/qCs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EkWZrRfC+E0Eiqv+EtF7UTfNRET39w4/URHVwn2fGDFjKRla53RJInBPWSttyl8zyMd/boxkRWry47OP4eTQLmGmq4cUypBeRMrv+NlHuvJBOzVtqlhDsATRy1An0wZKwpmnm2jhVxb8IhZBILNY4UFQKJnh1OgQ/n2onMoOuo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VcRr1AQ1; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye+jhS8VL697ABKorjk3XJFWvn2SD0NAjdZ+UTHgl050q2dNnQLGaVk/hKYthFBnYa4nPsDLncPizNgyXFzjeJ56tap8633unp8dDqcD98Wk3sPfjJuU6WF5+2fPXz0z8YBow6y04lbTk4wJdxlG5DBhl4uZWG+zEWjOIMmACRfh3qcPdvGXgiHO1kb2suZkj0EpsTdqu37I4AWcIK2LJs5bRoHFa1IzqULy3yX/OvTDz8P0tyaRaId3DEAUkMFPlG9artZvjzNzMg5z+FDF9NCDXcRTfZE26tEy7MrOlI3OdtL5h6NyX3UuV2c/6SELpVx7Gy4D99rISvsYuWo50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70Kp+WzbEE4olC3z/w+cg2yLgUnnAGFCzGOm3MfaVgg=;
 b=xSM1eCLHElsNVAABjG0tW6BlCiu9c8kjINSZYxDAHpqIyx4c3Uy+hOSBTRPO6hv0b+3dE+IeiiwWFlQIUK23odo+wFsAjM77zGV5cz4tKaeuG+BxsLdulv4J6VaBHqgMD9LU6+RE5WVbZ3usZSjuGSf7ZvZTvV6+pgiwq3TrhXcg5Rux+qIe/qE6iMGkLRGLpyEeQz4sPraJpRrZmsefzMQeDHGq55omBHKHhd8EaamqSh+FKbVkumIF+dE3NvVQsJZNUILXGFcFIn8x2b1ikHyqydAegMY07yniAYIK1Rge9lvizVSJt1q5RLi7mURkKU2ou/z8fn73JDY2Jztp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70Kp+WzbEE4olC3z/w+cg2yLgUnnAGFCzGOm3MfaVgg=;
 b=VcRr1AQ1O5HjAlcHkK5P3bs9Kd3OCLdB+QBZO7ZUNGDvQv8WHjiOVtC4M7M1XGa5q3eMvqNg0wqaEn2wDy7oT6aidphOwVerv3SiJC0sNwFLcX/OsoVzodzGr0W7KYT/PASDbwyes+XR2j0yIpT9rvbl0f+VZ0BiGhkLt9VE5O17Hf/jQKYYDooA9CWH880lH15q1hZ+rtezB4JoHR8JzoOICs5T13S0NRXbVo367T/72jiVNbhib+tRIxjgPIW9eYtJKTvodAJWwsmDVRvtTfJI/M4zXzW2lpNs1ZuOPN5lmkUn0WF/1gaqNfCClmF5olntN89X2FPVYCQRAyX4tA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 00:29:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 00:29:37 +0000
Date: Tue, 2 Jun 2026 21:29:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Doug Ledford <dledford@redhat.com>,
	Haggai Eran <haggaie@nvidia.com>, Majd Dibbiny <majd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/2] IB/mlx5: Fix transport-domain rollback and
 initialize lb mutex earlier
Message-ID: <20260603002936.GA1171492@nvidia.com>
References: <20260510222258.6654-1-prathameshdeshpande7@gmail.com>
 <20260510222258.6654-2-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510222258.6654-2-prathameshdeshpande7@gmail.com>
X-ClientProxiedBy: MN2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:208:239::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c878b9-5655-4422-07ce-08dec107317a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uuQ8aH9Q+g8oiIqsCKJiHM+AU5oi52WqZQUqlLFElVBjusWu0vW5y8k3POo/asthLrgm7PaIpwbxDzYZvDhfHC5K1p3v0ndjBrmz2IUgTqWJ73xE5+Us1GaMzTGAaFukyI/k+fPH9TN7Da7dLwysQENCjPIIxIUEYqmDXVViUXnTVlDV9RL5OwEpC1AqqNZXlPreOqQGuaE9lCcCseCDoSZQ49fcfWAeRHsMItUUV46YgFvJC79FuJTUYrKFFlaF2YQnvjkbPEWQoI5o7h98WFPzxzvj5FiI6zIzWGO0xWaaBDggDVZw0PKB4Vi+XMKYbqheK6Gq4hVSx2UKlgEyjQyQ1w4VH58JPIzc9QjfEqjzwDKKHqdKZUuJ06RPnhidy1Bfg5JXyEi4maSO2+OUNwR+qt6y4j54RrnOKaeWfnWh47h160NiEWcB1b9nqDDLHhsTPPoyBORKOHzj57K4Te0xtmuoysRl15tO7tyL6jh4igsZCJ5w0AZTbuTOEiuQURAzXUvTX+ow0tt9JydhDQ2YJcbCQqnD10oQ14gWiDkv4Np7QHDuKkpho2wQQyF1+6qaGeF2biQgLy5Ye18D98bZW1e1NA29cJS/IjHfNyuRECwmSNvBi2fCLFQ48NHq5VDdSn+3oTf8pSO6vqKy5ph0H6O3Fv3DgJvHQDdsBTyvXrzriwATAxsSrL5BLBiO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ag+tsD1/P2YWzbJBr2FcUHDOOP9HdmhWdG7s/zeU3HMKihTHvzPKudrhnZFm?=
 =?us-ascii?Q?bqBXYhFYl7MknzV0vZZ09ZxXs//ulmmmvR0kjALnJBx8FEpVSaUEMgboYSfP?=
 =?us-ascii?Q?MGduI+2Hpzgq/KYSc6F1qJ6QY8gA72/A9LEcpaF6/9x8WsxVRhmmCLoZLWb4?=
 =?us-ascii?Q?1JLazxThwBBF5J+EEW64/oL5xWjbeqei1zk0U/DlkCJEs5DVdMaLShvmMBZJ?=
 =?us-ascii?Q?YaDQhyH4AJQh7j9b+5z/rlN3acayUo4NaICiszyWqsztTYxujbiSxzAFCS7q?=
 =?us-ascii?Q?d715iUY9G10H2ca6hF2pu/VuoNmxSep2H2xE3M2hhIFWMcSBgvKqgiW9KfJV?=
 =?us-ascii?Q?i0UBPfISGM2EMqyGi+UnVbdUNCBs40YCGWNQEOLYcVmy92ahXPwAg/+jy+tc?=
 =?us-ascii?Q?kMImb4PYPxLX9zqRWnSbyFBVzYpJ0gYwzmJ69FbRp4xpwQRbH1sqfZFDNSYB?=
 =?us-ascii?Q?YB3l8lXS9NRfobhN0hjnxb09oVpZQ6oIJewVlXE8ZF3ASQ3whLImlcuKhUmf?=
 =?us-ascii?Q?AiK3jbb4LrA4Q+xWCGq+MpsBgji9ZXk1k2BJsTwD8eTpBKju6Jw87Q4d+7FL?=
 =?us-ascii?Q?C7SbTTVW7uzneirFTAfRtW6Cpk2DuXr8hCuzFkqpRG1bQAUJrahtaGPRLUn4?=
 =?us-ascii?Q?qtKTSpJzYJj7Dg82TXRmjGoZCVPRhzX3LY5T0sQR0tJbIkztKCyrS1E6HoqN?=
 =?us-ascii?Q?SriaMieZOO4+x1JOPjF5IMjar+QKswPaeiQyZbwrqsq42J+MvMRdhCI30nYJ?=
 =?us-ascii?Q?6MUmKXOTnmTlrLlGwntIRjF56paLdFnkrnli74rYcYhdfZ1J8X7cxh61DGtx?=
 =?us-ascii?Q?h0GBprwHNvwosOq1wnRixVfP/tTs2ru7HibILHqK/FkOfXziUKqh7LrtzFvt?=
 =?us-ascii?Q?6AlcgiPcrSxgDMg0W/Re2H3xMif6elm1f9liu0yaMUtOLqACxwXc0X+aS6zx?=
 =?us-ascii?Q?YgbtcLI1Q2afaY244ibjHNVqXqbX8KTZXoO93Y93z/ntSOPHZmNwYB/vJv0v?=
 =?us-ascii?Q?ZONlUvRgMntPeHEzxKUOCHekbn1FnT61fDOAPRReCsR04T767dKtDx3uG5pC?=
 =?us-ascii?Q?F0A1PKtsvudp33ZYfHGxSTOsRY47eCxhQ3+A/1/tqqcvCqmWWzwDgchv5e9Q?=
 =?us-ascii?Q?YG46u4hrXtHPmTMg0IKMj1yExwQs9Y37ukOYh1Li4ORxYG7sAZl84KOLtLni?=
 =?us-ascii?Q?zRlhr65oP4jQu/DhF9YxhTVltkVaDuw9Bw3PCwt5IFm1lwL2hkoYRLRXOhXA?=
 =?us-ascii?Q?fexe6R2HLQtmWROCB+G/u4aL1jUYTVNU7h1Ip5UOgYPAsPQRxPrO8P4MdGAJ?=
 =?us-ascii?Q?AoL3rqLL/ELKaDrmxp/sDUx59A5qHRTvtkDMTF1yG+XhnTnfVtcYdQWpKR19?=
 =?us-ascii?Q?BzYaPE/trBP0kRz2+FD31w9YVC8zGSeYl/jX7oBHgft8xRPJh7unA5cVDfAf?=
 =?us-ascii?Q?skbCHKd6FvIPhXZCdhio5CKDzu7lTUY2dqKqA8U8vJUZ0WdJf3TPRVDvr4Qj?=
 =?us-ascii?Q?KdyjlM70AJCLocpzVTN9liBGRT5Gbg4b6Z7xS9UOPtnjsbV5mOMLazWH+ML5?=
 =?us-ascii?Q?t8riWspGlE8kSiTiq8xgP9DePqfKSY5/rQf2l8YUrBdjRemdYoVuj2WLZEFw?=
 =?us-ascii?Q?8CMDDdgfL7C53U7QZAh05ukcv3g07MwqAhfo5b1bw51YHvrPk9YIwI8kTOHd?=
 =?us-ascii?Q?maKglF0v6bPCcRnc/yccegghR1P+Sg6D/LOBcGsVqZHkV8wI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c878b9-5655-4422-07ce-08dec107317a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 00:29:37.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vg4kpED0sOfHbD/YZyM+kA3+7c7l0MJRhHKA3LN1BtGJMeBvjeOmrFrufDgOKMZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21660-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:prathameshdeshpande7@gmail.com,m:leon@kernel.org,m:phaddad@nvidia.com,m:mbloch@nvidia.com,m:dledford@redhat.com,m:haggaie@nvidia.com,m:majd@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91A43633347

On Sun, May 10, 2026 at 11:22:53PM +0100, Prathamesh Deshpande wrote:
> mlx5_ib_alloc_transport_domain() allocates a transport domain and then
> may fail in mlx5_ib_enable_lb(). In that case, the allocated TD is leaked.
> 
> Fix this by deallocating the TD when mlx5_ib_enable_lb() returns an
> error. Also return 0 explicitly in the no-loopback-capability success
> branch, and move dev->lb.mutex initialization to mlx5_ib_stage_init_init().
> 
> Destroy dev->lb.mutex in the matching cleanup path and in init failure
> paths after the mutex is initialized.

To many things in one patch

> @@ -2068,9 +2068,13 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
>  	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
>  	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
>  	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
> -		return err;
> +		return 0;
> +
> +	err = mlx5_ib_enable_lb(dev, true, false);
> +	if (err)
> +		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
>  
> -	return mlx5_ib_enable_lb(dev, true, false);
> +	return err;
>  }

This seems like it might be reasonable

But mutex_destroy is only a debugging feature, we don't need to rework
code to carefully destroy it in error paths.. It should be init'd when
the memory is allocated and free'd when the memory is destroyed.

> -	if ((MLX5_CAP_GEN(dev->mdev, port_type) == MLX5_CAP_PORT_TYPE_ETH) &&
> -	    (MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) ||
> -	     MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
> -		mutex_init(&dev->lb.mutex);

Though I am wondering why someone did this..

Jason

