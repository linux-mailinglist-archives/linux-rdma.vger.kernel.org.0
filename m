Return-Path: <linux-rdma+bounces-16615-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHYKMGBIhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16615-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92CF90D3
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB7D304DCB9
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96318247291;
	Fri,  6 Feb 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gd1ciDqN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260B18DF80
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342355; cv=fail; b=NEI/4zbeyGq2na8Ybkgv6UUapW7HIK/L0Fuv9/fFPwjEeBddFUCgXAjechUVTdTq088AuN5+cFNvrrTWrvdj6MnouAhC6XOoBOPc1YnroNu/khz0AaSUKEj4HRMtBP0zXYbRqkXKbK5/adWv4AdmkaNZqWnoc0TyZNDOBDSBCdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342355; c=relaxed/simple;
	bh=n0ghKorsz19MFzYeqdpS532Pf2f3bT2poI/KGc1WIyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cv1jPKQQhhV0S27CBOngg47YnEYekW5n5M+xCps3WoXWdk7HFzF2JmvATBEWxO/oupxMoZI7oM+mXT7NjUdSLwcYIYJEH+rKbdPPW1/rbHh725uZxVFldjLQIAl+HRiPq60A5e5el3oy1JgrfYXfa4iPMIhw83cY9fPg6vwE2x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gd1ciDqN; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsZyuabqmq11BU4HddJJzs5gtB91UcRSSiujpW9vT1XZibrN+x+nyM9ukGAIqJVZNtFc1XEkD9oxMKSS3JBgHnkCb+s7PFBF9fklUxX8clv9PgA6GW4pnGKASjxXs7elj9CgKz8Ar68RDOsaxj2xVZweKBjqkhnNX5+fYIW209oUPePmP7ABTVLbkBlou5kP0SxNW+EcVITKKGqKF2C7ffAxED3yGurIXG5esSno3Xc2I/9jVx6HYuAaEViAfV1qgsvl5O0Mff3glZK06uQ6nKTqwONXRW2NRdRkZ8kLx9UySbV7++tSNPNhx/WaJL3kHWS6N0fL+1Fei55WjRlM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuzHgagRxNYH/QiMnJntBJGVqVAg1inDY8YtwZRZCwo=;
 b=eqXffpmcXDZP5o/IfhATZrOyXwkbPLiuQtQvWJVT0j0IyxREJMELZ/zEQdQWxMc9KG7OKAQkfBj0CAbcHrwkqI4+fGKR3wZLNgGyhXN0iiJiz4gcWtbzENo27gcHP7EfJG/3V9o1h5FwSEV3d/Ax5l69WHcdjsjmz3bF2NpOoMbRDXO8SyYIt0200jypb6TyOW9Oug86rk9/GrDYxyjZO7HP00sEsQygkxNmQRs4sfMFLJdv4ekphUFW/9W/2cFWlA+22q9BwKSfjtT6a4GXuuFn9+6mXy7ra0Sjo/bDz9WxtlYuSfvrQye1W47OYatpoHdAyDn/vOUBGuR17O9SNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuzHgagRxNYH/QiMnJntBJGVqVAg1inDY8YtwZRZCwo=;
 b=gd1ciDqNQk0zlHSEPV5Ttc8IoL6SfdC1W/Flmoe4v5No7/+Hg9X27Ev4OKF9nrbcEDbQ9TEqOoBZ3jolDSkyBJYlf0k3iZlkj4DJYSTmkXycK5TIa4DRu7mKRe1ta5Utj4SI1OhWOQssb3kvz/npXX/zrP5kt/l3rFP/veqLwpysk9zuJO6L4NvskywXRSNOPeAaReTLl/JwAiyKodlXMZSbVVH1oPcfq0VO5TLJjwZj04oGCqs5HvjCN2Auy2+0f7Qf7XtAriP03OW7FkXgV2Jnd90Wbt02b+i+phHRypbxuyvLsZF2QeOIMK3FmkWGOMC5v920Q5DvtHDKHjyW8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 10/10] RDMA/bnxt_re: Add BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED
Date: Thu,  5 Feb 2026 21:45:44 -0400
Message-ID: <10-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0059.namprd20.prod.outlook.com
 (2603:10b6:208:235::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6052d10e-d665-4761-1776-08de65217276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XkSe/511R81li4f/x7U8aFYE+Cof9O+q/WR4lQqdwwsCxnBnFuBNmPTiA0pX?=
 =?us-ascii?Q?DpcaADI6el0cb2wibhM3vc9Z3MEVIWR93DTOsLUQjE3b7IvW1UYcjz0bAMFF?=
 =?us-ascii?Q?3ZxfiWe944dGhmHRfEh1ZbOs9OqaghC4YoBY794l8eH5CsmTNG1ZNqsORflx?=
 =?us-ascii?Q?432yQ/rPBzLf2Kt9LgvhI9x9uvoluBjOi71/8THEMoN9PS8P1Q/9kjpArbPa?=
 =?us-ascii?Q?9WkxbcCzhj6ULq1TBYVvBH8CFqLcNrcw2Ec2KnZiK1K8M1tF0aCJCuySxEnu?=
 =?us-ascii?Q?Q+lL6BOwu9exchr2IHDC32Ua8GdixJQnSg6BVkJKr+2osgFyYqKUWW9U8l1U?=
 =?us-ascii?Q?wTbrSvap7wkggoK+rAxBSphSgJ5G2pHeycWuySD/wFdon0HgpU2HzywKo4RA?=
 =?us-ascii?Q?BuPvDAQT7ggEln4Vq53NnkfzPwUne6gzOw9y4sODbginnMvwvYnGHEnYA7LB?=
 =?us-ascii?Q?3t4T6xTk8x5krQHvxSz39g8mLL4fa1qMkM/2n5C6xTTyDK1TlSsVlEo/sMrU?=
 =?us-ascii?Q?qcBSggwJEATvqbi1K6dTOfvduPtGqT9BtkeX3vlCdNuYBW4vXoi2eZzRHvd2?=
 =?us-ascii?Q?ZnSRTE6BBDWXklgajjrM2e5bavtVVU/R195e3tAILN7YowNSgkTkT7oIYtGW?=
 =?us-ascii?Q?j6yoD6WaakwuN3yLVm5r39LbNSr+8NTk6AUWwUJgvyp7VA13/EKB+TUFeBjv?=
 =?us-ascii?Q?ZJPBjtizJGlWWODPgorG2NyVFl3RV05g82hNDl6tVZB/jzAZdZF0/vrdRyIW?=
 =?us-ascii?Q?8Y489+gJit3n0hlwJn+e1xn2ju1n6heRcGFQFv4yMUAY8fkhJvIAkAgE8zXc?=
 =?us-ascii?Q?Iqf/4/tUnQNljfmj6f74BnYYIZMYSwHUbYhrUdwEDkQn9L1FTLTyslSiGpCO?=
 =?us-ascii?Q?vfaCweR4gi7AlIQY83hJkzXWnsmugZmZ5ruk4lilvDKDB7ybbgp5uqm6DcuE?=
 =?us-ascii?Q?KYt28nkmXjdurenk6c9khq9YHLgHIvbuF4nyf76clJllYDDVFQygVyEq0aSS?=
 =?us-ascii?Q?6e4IHms9/KAm+gVzWBG03LOTV0b4r0+cO4+yCvIzEvEz+rppr3nIpNI/EGye?=
 =?us-ascii?Q?pgXeRbJ0XWKDWnnQFCoA5KF2DoH6SXn54V6i45YTQvrKKNt9MlpUzxobXQtY?=
 =?us-ascii?Q?moeLoLg0fIxOQaewXqI0tVuNXY6EMN6E2LprRBCi/mLZkrnax8P4wApiyKT0?=
 =?us-ascii?Q?8dQKJxDUkxP1hDj/KYAFw0c5cIeQx7YWGcFTbQKI+YsDtJrRuBBQ5brs3+H2?=
 =?us-ascii?Q?Hh+tDm1WNeK/AMxGq4B4sbSkpiECcZsdOUDoSzkfrX2VeO96D7c46ODSFFfl?=
 =?us-ascii?Q?D7Nj1Am9xhjfG8kRuLewisA9dHAYrgTE3jAffzrvAPkCZSC+wLshlzjd6aJF?=
 =?us-ascii?Q?r8aPy860Ndf01XOhpIyCda4QwAnMrBieVeir8DKl8BDgNKlHS+5Xn629Nlx6?=
 =?us-ascii?Q?m9L0uTMDWtzazWMMq6BZordjIINHywA8uUGSasi0x540tmzAXb43XegfliD2?=
 =?us-ascii?Q?pu6iSXkIvlDDRuXn9V8Kgg6sbIJ7/Tj73CakIj5dArTA6HpsDElO0cKWpZ2r?=
 =?us-ascii?Q?LkrfqXp8ZyrNozXVnfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VKChFFkItL5Hb6eGozHEHeIu3a25z13SXkDWEF2AGK5lZyfs/Gap3Os2Bxpr?=
 =?us-ascii?Q?VRlGfeuIEH8qOjYtXADmiiY6JdcSluyfmGzoaFeiAlnrEFyhFJJvyNER0D42?=
 =?us-ascii?Q?m5xXMuQSfipUSz2oL1ebChzz+mXAe7HAp/SEWHPfqNSoX/PgER7da+9j4dkr?=
 =?us-ascii?Q?dcz5YCbZiI+3h5hCfad8M7ssUd3AHd8m8Gu/W/VAv5vqSkHdTKKnKIYDVN94?=
 =?us-ascii?Q?PhluJsyKUl+74xuPOucjdCl9XzwswrGCTEWET9CM4VnKXusnOcwfvL/ME9at?=
 =?us-ascii?Q?TeWvfKLjJvMCvsDLWGXq/TTD66xgsn6h6Rb/2YwkU+t/NepjgUm8sUFuoeIo?=
 =?us-ascii?Q?AHW90VvaXolyOQ1EBI2yWGICPkINNMPJcOc0iStwbU+RVZtuX8Gzr3Gr7M2N?=
 =?us-ascii?Q?SQTqNEz5nAsCkkh9rz3CWzKyOXFzmU8XZxCrqqQMjL9Ij2LKxCXGn3rqg13G?=
 =?us-ascii?Q?YPrN8x8c9frNiFjquojRM8mRxm9/QCq3JsxG658m/nv7NZ2IcFGtJPc4NFef?=
 =?us-ascii?Q?bXyHaETyfav9kHLMrhgGDFHseW8vmo1H7gjW0z4qAaCZ9FwzliKgRIigMbrP?=
 =?us-ascii?Q?bTVKzb24FfO/twYLGes1YkV/IoGN5jgL1FAc68nfN2GDcNtunFd2x6exGcNv?=
 =?us-ascii?Q?P9ie1hJL6bYsjZhqyLQswm6JKJbxEyJufO1kFCDa0hktIuCKaw3Y4pF8EwGR?=
 =?us-ascii?Q?mmn/2SnyB6H3CnfVyq2dBkjl+MvlLYacVkMVN+yKquA8Tlv0DlHFjPo+27hT?=
 =?us-ascii?Q?wKFrlXBd05wzCDBfextVHJgLMEGXohP+AFTCw8YHwYsbr8ckseCZU/lKRJKu?=
 =?us-ascii?Q?sd7qGyA45MhUX4wFFvyEB7zTKmghO8jCkpoRghRUrxdwXwabJcjAtsWG9LDp?=
 =?us-ascii?Q?m53jyZ3RzVK/+9vrjoKiq+2YmPOPtZwCeHDjfINAnZUPB3Mwrkw7nSOxJuoO?=
 =?us-ascii?Q?RX1mDGYLZXNgrz/ezkp5gauij0UOdZ4QmQRiHQkt1rlmiSZTPBLm6/7yTNFN?=
 =?us-ascii?Q?7uxqtbmopfjwmaeEdwkzIWTyfXd9mTFJq/ieulZhzedZ/0Qk8YjBJBHfEh/u?=
 =?us-ascii?Q?6u4QWvSAmpNVifF7BvNJIt1QEYCucxWgz1PQzc6Qsb0r2rQgNXUizokTSgwS?=
 =?us-ascii?Q?TGzQzNnBYBR/OTcGfG7eqcr6OBIUlczo4/nRRDspXr7u4TBzfE+Bx2m8mql7?=
 =?us-ascii?Q?8W5RFzZ9SMQ3nbtweCJlSL/nMUKWTn1mC+Mck0NoKlxtncLRXemtpTbX/86i?=
 =?us-ascii?Q?zkQZfLBEHHHlO4pWogWUC1rsoG8gggRRyWNb11HUG6vmSiDiJ70mHtAqidKG?=
 =?us-ascii?Q?I9biStRFE7y2P5IcHFeaO8VwU2Fnzrg6/zpHzhwdnVKUiFbjsx55UijA7r4/?=
 =?us-ascii?Q?Vm0i+2DtnJPvVi1u5Ip38RtMc00XVcVFnXA2wtsdssxUd9VAoaINQMhLT0Hk?=
 =?us-ascii?Q?bmtCbyCNelk5hMUKvsNB4/6zGQwr2PZhY6WNiG80Uxv2uCMzDdCrLhzDUX2S?=
 =?us-ascii?Q?gE4A++NzMdXCB7FNqfL6vyD+H1cpDI/t2g+LJq/rhc4OBK0nCisvpqC3nejZ?=
 =?us-ascii?Q?vo9AIBB5IxW8LYEh+KzBhalK6Q9mtd+mrRspHAbH/6bsq0mIEMbp8av0kGLa?=
 =?us-ascii?Q?/AuaybUx8yk8cYfUTnJ0+IWAwA0jRGkpnkIM+Kev/cODfFyQt8NUVr2EzCmv?=
 =?us-ascii?Q?JxQq6A6wvHs492SjqUQJnn9hOF/0Qn61/1Fn+0uiWD5LWQZRbQD8sh8zakam?=
 =?us-ascii?Q?OpHHrQGvaw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052d10e-d665-4761-1776-08de65217276
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:46.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxkYWjzA79vSsNVYgWPSl43mkelIPMwLJKkxSB3veFczJKWdcSzacoeG5RF2gq1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16615-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6D92CF90D3
X-Rspamd-Action: no action

Now that the driver properly implements the uAPI forwards and backwards
compatibility checks tell userspace about it.

If this flag is not set the userspace may not use any of the uAPI newer
than this commit as it will behave in unexpected ways on older kernels
that lack validation.

Userspace should test this flag before invoking any future enhanced calls
relying on changes to the driver data.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 ++-
 include/uapi/rdma/bnxt_re-abi.h          | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9d1c31bb994218..1b3a4fca868fce 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4401,7 +4401,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	}
 	spin_lock_init(&uctx->sh_lock);
 
-	resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
+	resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX |
+			 BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED;
 	chip_met_rev_num = rdev->chip_ctx->chip_num;
 	chip_met_rev_num |= ((u32)rdev->chip_ctx->chip_rev & 0xFF) <<
 			     BNXT_RE_CHIP_ID0_CHIP_REV_SFT;
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index faa9d62b3b3091..f8162438e14e98 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -56,6 +56,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
+	BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED = 0x80,
 };
 
 enum bnxt_re_wqe_mode {
-- 
2.43.0


