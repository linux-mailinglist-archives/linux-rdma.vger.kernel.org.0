Return-Path: <linux-rdma+bounces-6791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A371A00A4B
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EB87A1B5F
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F571FA171;
	Fri,  3 Jan 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jU2ocprE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BE1F9A95;
	Fri,  3 Jan 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913488; cv=fail; b=VbFRjOVe1sZyiNfozPmNhwV9M8DXw3xqPlpRVb5WMAtUB0hc6He6Z4iKX1rexNhwMqRvrm6VJBXAvHGkEClSWem0K/IJgZHmrqyYc9wvECvrZ7xAehp/VY98drR/r/B1smfGbuM8XZU419XrBKiTbph86Tc3ifoRqH0PZqwTbEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913488; c=relaxed/simple;
	bh=X4baqnJ49RRnlkwX4Arvfwh67jA7ByRZncJ8GyMMPMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXne/1m1S9fkIUGlSKneWnjXToneeGeTj1ba42BVfPZdjw6UDat2svpw2ntHJ4XYqzOQF5L6tp/tk/wdEFuKPmbwZI3cpHilRSAEKmy0e3VNT5qo3cmwmhoEmZRnH3tM4wP/Zkcz5h4Oo3TizbhGCnWa7yVjbWcaLPMW7tNgAjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jU2ocprE; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arO7xZ4yzWwuXGfZiavo6z7hi+V4I5S05gAdYNe8mcRaciCC7enZ3O/pHe80sd4lU4zQlZATjnUVQK2u1aUmq07e3XYHXc4iPqAKKjR+5Ujrm2+9RHaUCSZ0hc1IYJsxgkCPfitPzeAnxDNj8bn4A93yPT2fggBBT6dmXlq6w55XF84T8FWD8ih9advZlUt6zks/qm3X+SL9qi3LkFYfWeLCp3wO7MFOMmxZS0fQ7IPoOvVl1+ySWJldXyA3uXrKR+X1NjM2gckEPsjmJgeethuhgNRATsvxKxtXnG9eVEKGo26S+heN6dGQsZvGyWJWw440//jYFC9TkNf8NW5gGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hNdG7ZdAZ0l/MSsDH3PZOM2/O/Ty2LW+wyXRI5OA5I=;
 b=V9zFqNcvjwf10SarlaiMQ2KQHk6bgqxW+axnyGQMeGD2EaLJJ1F10EiYJthUx0uelLdTxHMSJ/GMaX/eiEpU1P3895p0zXR8HB8IC918Rp+NbomglL0dViaDX0bAbqJ3tIFERqaGCnqSy2PemAtaM+6aFwQpitnas0Al86r7q0V49Np7n9tt2OWaFYmvYd5Of3E9OeXdDUGq9QUaHtiR8QoSbzT+gAnL22vs7HhHvebLw8CY0vVBSz4O60D2WWXJbXZpjktcNSBcfc3BUBNgfmArT15JxcXZZBlkLNNxpgAYrEMwzccfBYWxMB91nUnVdNk0H3flxNotKxS25VjOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hNdG7ZdAZ0l/MSsDH3PZOM2/O/Ty2LW+wyXRI5OA5I=;
 b=jU2ocprENmDoUeKJ013v/GoHBl9bTqncesMwyKw5WKuHBPFDzYJGkfjTg2soPiDXxxpR/Gj75fqnwLSZyG4/GR7BNVZwdhoWbn3YObxMByglXdhWz2DDiut7jM9zrb7DD2K/vmYI0TG82Kv3X+zPzKRJ+aB2ELBh/YpR8SoKidlYW59kOLj0PBkUBkFn9lZ3/Cp49W7HMvZyfQU9waY8v01XKnB7RkZyR8bpPiAs+bSESuUngazoyFhStI4uZEE6EzGa162BODH4hmLy2tbr9kPNcWb/p0yl87O1PsAWJSlASKMhrjMHJkmAQZ7dvoOZlDJKgl0UC0zaHqEqiWRCrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 14:11:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 14:11:19 +0000
Date: Fri, 3 Jan 2025 10:11:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Francesco Poli <invernomuto@paranoici.org>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Enable multiplane mode only when it
 is supported
Message-ID: <20250103141117.GA137209@nvidia.com>
References: <1ef901acdf564716fcf550453cf5e94f343777ec.1734610916.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef901acdf564716fcf550453cf5e94f343777ec.1734610916.git.leon@kernel.org>
X-ClientProxiedBy: BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2440a3-3da5-4ebc-82f3-08dd2c007e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DbHiCjEkmj4vyEwCQfTekDInyxQpE5e6fIxAmUG52nls0ymtPye5K7pejUL8?=
 =?us-ascii?Q?xKZCGzrowGsDSkoKQmneR+Jif6GexCGII3K8O+Em9vY7xIQfabLgXTEO9Jiq?=
 =?us-ascii?Q?0mgZBtmY/7E4ffIMIINO764HgAQ01ZI2OgTJnLmLo+ftvvU4nJOudSSWm1GL?=
 =?us-ascii?Q?boXEqnH+Y/6q9BFcQlGRTqusAtpBFENx4VizvHeLgqMt44K1nafDfrRSD+Gb?=
 =?us-ascii?Q?2c+omW1UhCvJPs5NF6qSBcEvgHKW5Wi8Hr8680JejnkBtqU6iLYxoYlS4r6e?=
 =?us-ascii?Q?sEeiLpPnoK88BAYodN32UsnIvc2ebofOOGqzi888b/oGYJhpoPgsEoJ0Tj06?=
 =?us-ascii?Q?8tdcyv3kG4zhUDeYpRwPwlJwHUaZxtqWiYCtV9aQvBYqp0dV1h0O44ah7duj?=
 =?us-ascii?Q?u09sqp/caYm8rdvTV6nXa882WdnOwE1vbukguYPDCTXLB6uXBKAwlmTiS5v8?=
 =?us-ascii?Q?eJ/Ws2pkdlKGEZvgMATR+VpnMzjtzXkfoALK9Df7DRsOish+c53DybU+vgjV?=
 =?us-ascii?Q?3+1sjGuG62wP5ZG2fZTSGdIX1jova9BQmiL9wefseM9z/DrlFBCNdtNkSOct?=
 =?us-ascii?Q?UNeod998qpkxouYMF/RfiiEBrJk76ndxaP7ofmSEtO+Vxix+aruec1x+JMVJ?=
 =?us-ascii?Q?iVOhvL8nquXFwmTAi3ZTCV0caFF3W1na4K5p4sPTAATcX3rMuDup3Yze7TWY?=
 =?us-ascii?Q?PrNmo3ZVjUTWP50IivqijDFi3EK4lVmDKTv1DF4BfIkwPvhaih8uUqYAfzY7?=
 =?us-ascii?Q?PeW7aIUlZh09s4ZE3EKxr91pIVxTzkPzzhTi7Tw/eFjLtKqC6RP3jkbQIVWp?=
 =?us-ascii?Q?yJEQfWwsAE3HszDYgYVuhj7cPPtTov7iiD8EHnrclUwNZrVlLapC7B8P+mmF?=
 =?us-ascii?Q?SD7BhT6zLS5svA2rMHFFfuvq6VWwTLR/MjKr7U8Eqz5n6byU/Q5SatxCoIoI?=
 =?us-ascii?Q?8jlrq55LHjFjateVHIKi1NYOCc1sowjQTRrNn7df1U1FvX34bDblVRV+bMUN?=
 =?us-ascii?Q?xmgYUu0PFbC03rykU0cobbvr9kJcoI/rwKO6mAHPENShqWxXgw3LqVYisd4i?=
 =?us-ascii?Q?yMizAMMhvHRxuApLzzQD2WM+L/noU8+mNgpeBlrsRi23Ee7FLS8SydfPD1xB?=
 =?us-ascii?Q?Iv0HAC5YRuNeegQbw+rdEfIaZBlK0+Ug0g/hYED2vorUoKM1jAaXxiBfYbEs?=
 =?us-ascii?Q?mb2Q1LcdMhexs32H8lPMYdiiT2FbDcP329uPLV9CxPBIQx7YmfGTaLYfBlMl?=
 =?us-ascii?Q?zWxpRx+NGup1IRmd9lhJbsGKLl/0m9Q879YxdphlOjXJKt59q65Ton8pSVmI?=
 =?us-ascii?Q?z4i90VeufqIfBI8uE2MDgAlVe98mhUX+zON25429LAS+KYQ/YjdQGEuNVu77?=
 =?us-ascii?Q?du3aQcV3b5keF6RhetcUKkl1mpl3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lwsc5ZcbmFQtv3iMxlpQKkRUMNXl8WIftmg5mrmqXTGolcftZ040qxeyIdz0?=
 =?us-ascii?Q?DtcCIhSopdEuF2WYlclGRC32nSd4/9pL/2HEdC7YUX40a9gqBJLbCMvXmmYW?=
 =?us-ascii?Q?Gg99ZP76ZlMJdKMIYq0CFfY5KW4Rf+ZbUjj4aqwgcIH0qdGowcjFCh9MpZ54?=
 =?us-ascii?Q?aC/luDw+jaXKcfI/ZDWJOvlr2nJI7o5fH6j0srlIzaP9MiDwngGgcfe8Q6Oh?=
 =?us-ascii?Q?2CvdR4hiKv5FDoqeEHDHRVDewxoqr+F1TIh7WCaO6inLYfOPZPraup7FfZ7m?=
 =?us-ascii?Q?lbKQmGcZiW9+vh0KGna10wYA53fPxwSQOCHCPqtrzF4J1JhHPjMvN9VmSI1U?=
 =?us-ascii?Q?xkQbyJUtJYIzIcmNuPsWmzJAdWGwtJt5X3HgTIpWl/RNNOsmtZ0yEDeFJlba?=
 =?us-ascii?Q?CDnWodE1pC4uLBip2CyABdCamIW+XWrO5VtR2p2TDarfagQJC0S0AcDrboI7?=
 =?us-ascii?Q?1KxbB/foVQJeoLvjr88jXI8AT6ZagaJcsnK91EZ6a0kHPX340mKzlyspXXRR?=
 =?us-ascii?Q?d73baq8lZruH0FSgYYcsH6tXtf72NTgrKQUNnT9y6qGEEc1mMvoTOhffp7ih?=
 =?us-ascii?Q?hY725Vh02av8z66xNihgv1zyfHmLVdciIwBhYArsSg0DL7L1XaABnaDzDEHq?=
 =?us-ascii?Q?8hWryUqUJGGSVyNDDbCUzj+aylsmj20MRePvSlXkj8zIMPtLAB2NpQdtOEnR?=
 =?us-ascii?Q?viqdAaTxIxABOcY+/68W5c+fcOQ6BUlS/jZ8bfN98//bRzymg6bGfOhcdm7Y?=
 =?us-ascii?Q?fiR2Gy3OEyseBvA1Sn3KwoywenrDVHwRS58ZDPn0/48Uw4747TVtHWDGWxRK?=
 =?us-ascii?Q?hvLm9MPTwtxpCDH0tz470L+HLYraQcPU3TjeTiMWCfj4RYTttda1BEwiCCiU?=
 =?us-ascii?Q?ZKZYVaoWUF5o/IY99UZicyZDqZQekyo+J8DDLD6AzE1Z7GsCIkMvhkxJvcmW?=
 =?us-ascii?Q?OxBWnBDmYWAMjY16nROIVGcWdn6mbDRTt8E8gI+pAQpnX8HsnlyWKBfFZaSd?=
 =?us-ascii?Q?Z4HC9GMNYorJNIsk24M8LKFmoSuFHXfQvCtjxg7MxoXJ9hpQGot5I5Z6fETL?=
 =?us-ascii?Q?HPqlN7gYOqeFPIZIxasdGIICg/SSFfx/cLeAwqKjt9EAw53UnBDsMxm1mNVr?=
 =?us-ascii?Q?kUq5FWyqO459ObLqCj+RmIXotc11i4bnQ6Il894keMbmSF/faG7bTycSn5q+?=
 =?us-ascii?Q?EVVQdr1Z5DqmimONSgr+jwhGPKFXaNesjMeciRPmxx6cEFIY3VO3u0bu6X8t?=
 =?us-ascii?Q?sZ5QgFeB+lfZie80H6AOliBPUgZIZIwH3coWblmht6lW7ssnvJjihyWPNkvf?=
 =?us-ascii?Q?/NOxutA870fCFzVpKzKVO/xi9D8a4VSXP9gUYrQwtH+8yd/w65qTKZgPTMHB?=
 =?us-ascii?Q?0j2jVoqmCqX6XFxiR0pU3KrsEJQnq+l2LFqT2d4ctXNiGJVQery8F46TGPXq?=
 =?us-ascii?Q?tLnogQJAL2BAY+RiRUrqvE2nlEUQHxU0jCmV1s+IQNpAjB5KmEKIoG2djo3p?=
 =?us-ascii?Q?PXZdHGVHl2XW+DPQSPnJJd81MHoOTNFDFLSE5JvkmHnZAio/wzaOvB9zlIrS?=
 =?us-ascii?Q?2bb67/UJ40G88urMIQe9qrF5HZecL9lQnm/lEbeb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2440a3-3da5-4ebc-82f3-08dd2c007e68
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 14:11:19.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ44Nmtq2aW8JBxcCfNS45lkGO/qiuLJ4vyH2L740LzszAtnMoBumei4U4eRXei/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

On Thu, Dec 19, 2024 at 02:23:36PM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Driver queries vport_cxt.num_plane and enables multiplane when it is
> greater then 0, but some old FWs (versions from x.40.1000 till x.42.1000),
> report vport_cxt.num_plane = 1 unexpectedly.
> 
> Fix it by querying num_plane only when HCA_CAP2.multiplane bit is set.
> 
> Fixes: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane device and port")
> Cc: stable@vger.kernel.org
> Reported-by: Francesco Poli <invernomuto@paranoici.org>
> Closes: https://lore.kernel.org/all/nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl/
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  include/linux/mlx5/mlx5_ifc.h     | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Applied to for-rc thanks

Jason

