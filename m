Return-Path: <linux-rdma+bounces-16684-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDgAGmLqiWmdDwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16684-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 15:08:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D7110165
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 15:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757213012254
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F74378D8C;
	Mon,  9 Feb 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhc/fPuJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DACA3783D1
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646006; cv=fail; b=Z8fTjSr96CeWgQ6tmxk0CKe5rMJqk28j0Mee3X4Grsb1Ym703rl9vtfjNpwwz/S5OJKrPtaV98XOqndWnjNy6079JduqVgCv50hcBj5QOxNFZ0RJoVT1ImVson5i4uvMu/TuGRAirR9TVjifQPV9V0kDbGjLi04de6ekPw6b0dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646006; c=relaxed/simple;
	bh=5/n1ibo8xpks2HDjb8Yo8Bs9Lke+wl0YQTHSbh8ONow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PJoxhMURNkyfbPy+s2Vl5Osaq4kPNzHc2cFMLbWfcoPpthRALF6I7H/PAzzxqW+Pvn5Iei533+/jwpfrE1T7IvuNztUtyzpT9YnYo8SxDEolQaz19niub/dSkS7GOkX10ukq+G35f1IauHf5d/b6B0Dn8Js69QiEUcbaftflp7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uhc/fPuJ; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/xOY4P8/jXMDOSC2vtt5A3WHDg3FTm8QBL84hjtu2A5gYxKQH42W9Z+zJIpTtoB+eOetWkS7rkxhSUQChVabRlLeruqDq2kEWWkG1JX1/nYtHaqLolfO5+Ug6WM6kEuN8aK/8YWsHKPpTbRsFcHJD0p+rV8GTkwwhlrMuXftg2bLw+eXSsxmgRccWyfpaKKZCYihKMNyonFDpqe8sUBiqwz/rb1NLKexLkNUv4vQWx6ChDmj3H0yA3WTFKosxSDuj2cIpECZXaxYa3r5VaVdFR7wzHR4KvplMiSDY5OFdmGKIveiorL8beAx2wryBlQ78QY0Y0dEmw/vonwQi75PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSsxq5sKP5sFPvixm74kkjYnt6T1j68lT9lSAP56TkI=;
 b=XEN6x2MlJRuV/NPbXEz8bCRUFUK5XxJcn41jSnu1fmsvpOmg7LIeA6F8vc5dkiUNlsGI+6iFlE8pWg3tzStUU1Gtqjc0D2ibqUash/zB0vYIWwNmHDbblyIaGhAbBJqTprXVBzSaHAfIMQIFliLG9BmPT+8il5Qd4tv0qjSTPbSkgu3JkBlLipi+Xm2vkfSmo/ztdTYELoU/2xURWsDN+kBQAMlTdklYpTGpedoCnYiJXN/sACJAIDXsm/Nh6HIj9qLAOhZBrgAwLvn64tJyl+dtNctucFI3c9L02/LJl+/0sh1p2FwR7GHcwIaMcEb7WdFoe9Spvmz9VxjPDkkmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSsxq5sKP5sFPvixm74kkjYnt6T1j68lT9lSAP56TkI=;
 b=uhc/fPuJ5lpoqmuGdK1MJy14WfxPUrLLNolgTtRMWEP6tJE8DArC7TZo+MBRhT/BmzRkZwgxksBYb0uvJoMw2w/lgxnCjr4Sp40N04FFq81pChluojlrQIFhITQvSjooNYlkt4vQDjATxVjZVx+SZhUOD1FNF+lX1c8mEgiHm8iWrJBEst/FvqNaTX40vs0zl+3t5ndTQd6sNNcCECgILoeONp9Yvjp/tuXyc2nUK/AahcqDsvltTlSXogmWyvHZcDM5kLzjtYZjl+BvDw7QN6Cy552uoJ74tAcY6BqSDWwRRSYOzD9YAOwDFXlQVCb6A0Vdk/bfip1Dc3XzgvbVuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 14:06:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:06:42 +0000
Date: Mon, 9 Feb 2026 10:06:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 01/10] RDMA: Add ib_copy_validate_udata_in()
Message-ID: <20260209140641.GC3076640@nvidia.com>
References: <1-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <5d569a30-832d-fe8d-1227-e409176b75ef@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d569a30-832d-fe8d-1227-e409176b75ef@hisilicon.com>
X-ClientProxiedBy: MN2PR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:208:238::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 874eaca4-096e-4df0-c923-08de67e47396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VdJqpI+n9at3i1t2dhl3GZKT2zZBC1f91ibEh+Wr7UcjoHYPk4G8lLoD3csc?=
 =?us-ascii?Q?s75Cw29j2gclf2NRoZrtDNbR++k1mAiyd/FDUJC5YF5bow4NQ6UnG7iVBP9I?=
 =?us-ascii?Q?ffhTEjy8rh/m+ttduDcs1YFEcjQMPjC3ZbO/Ox+o5uD9zD6bWx75kC5a8Uio?=
 =?us-ascii?Q?+/H6jdmZwNBhnYutkCm70rVmePzbd9rm+uG9kUJKiNnbqxXf63veRwdoU+l+?=
 =?us-ascii?Q?c3c5vj37tjG1t7MHW06IFJKU/6iOJj/EJ8pXegXEtfdPrmXpPmInyH2Gv6kt?=
 =?us-ascii?Q?4UFGjsHRWh2okURwu3HMyEVbu5393gp0PC3LUL+HJNalNREe36ICFlmubzRF?=
 =?us-ascii?Q?y4aCMvWzt8lPruvea4d5dsmJG3BHZ2PymhS4V/erSz6b9L4FaCl/CUPPCqzT?=
 =?us-ascii?Q?/HuFmHvnq3mNbFD22bYGuQlPiZl69Fd2utoK5hPBB43KBc7Y78FoluDs3YWM?=
 =?us-ascii?Q?y37u/bAo7/0MwAE//Kak3YrKMLPMcKQH+jkttuoo+BVy1gPUJ6NQtAYvDwrJ?=
 =?us-ascii?Q?Gz9/6UNlnDJktbxY/4G3jRdJyAy8hEAagIpeWwV3O17rh1Ae4o50mBYAxpO6?=
 =?us-ascii?Q?bgVKTb3nrK1QHUf8dHqoef70Wqb8co9GQw08um6fi+3MZJD8w0OcN4broYQd?=
 =?us-ascii?Q?wOx864KoddB8n9bDAU9dHxax0MaF7Oc5AciVBod/KqApY+ZG9GIPPI5zXK4V?=
 =?us-ascii?Q?a92Rnjyn72ztZHVZBu+DytC3xo/lrxbPYTuflJyuWvyFrPkI04otOuYbgGHh?=
 =?us-ascii?Q?Ld1u0uU0Spu6BtCyj6I3eg0ohWQygDDZPHVm4MrTdhTOopfWVmBTxptMK0Au?=
 =?us-ascii?Q?xfPAytBzPonrD2133HrDKCwnh0XBDSv9ly+wh766WboINAb9rexrvjxYbT8Z?=
 =?us-ascii?Q?r6e4DSaqyxgBpediA+l0rLq12uK7CwLVOr6wmXspB5T3AEi3VMZusVi3M56x?=
 =?us-ascii?Q?kKxjN5MKyLtouMVXdrdmlq60xqEYLlXn4sK8anyLICsxinGOBuzN1AA6vkol?=
 =?us-ascii?Q?27YaPvBlPGKRgxrfqp5Pd979RpMcXWoJ1L7iD4Dj2mMk3O5Zu3rAgtMFuMvA?=
 =?us-ascii?Q?/vmmA3537FBiyMEm3gXi0Pr/qBeVVPTQBBk0hoWFIu3sdRvxE9QbJcf62UFB?=
 =?us-ascii?Q?ACFhUE400Hb87upSBbIPHA0jHfSEjCyhbmVeN0jt468CQCvJozOqSOtuO60y?=
 =?us-ascii?Q?4IYDjpzvBfEa2AgJU3SZLiOh/5xbO+535fk1hjk0RS5836HdltJg9Rl3weeL?=
 =?us-ascii?Q?Bot4Hm3Dc8f6kSkgFPZmZzRzH3Ef5uDsFpUAFEfXjHoNvScTaMGlcOrbiV+E?=
 =?us-ascii?Q?z+IgTJWjoMNlQe4VxeHdHEPmqIDMrGb7wmhJ1CiMOgcv4S23fACPreMZhzYY?=
 =?us-ascii?Q?0rjJ+ml5kY/jwysrHl+mJmYSbpggFy0JIOgT0YhFmFraoiLz6IbHmwZbZi1y?=
 =?us-ascii?Q?5rjlmRIOBoW3nn6QDpEKYTSuTHgVB9nZ9lZ3GDAkoduY6gTklN/YlBYSs+bw?=
 =?us-ascii?Q?8LC79QpgsipBAd0KyLRf1USMh9Zk/fRBv6hLUf0Qeyiy70UA/BPPDZrLC/Bc?=
 =?us-ascii?Q?+Dld5xb6Kt/iDXcqmP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HNhngaqZVtCpF9YLPviYvQR6BIcr2vy0LAd2GPipEFZBMVRkeZZ3vS0JuGls?=
 =?us-ascii?Q?P0910Nw5QQn0JFKNPFuey/kkXjxZ1iQrVQPe2dOgJfmGbie4LEX0wQNQZyNz?=
 =?us-ascii?Q?U0e9mkwJ58e/b/GMsT8oZsEm1ITWKT+jQwEJeNkXl55ZGHPy3Z5nK5m7CEg/?=
 =?us-ascii?Q?DW110ZdxWuH7ez0IB+yWDpgPoLAYBMbgwv76dH+u6lx+Kvg2gXZijwwNKA0u?=
 =?us-ascii?Q?VNKHGNAauzCZ1XqqTISpkoRkFsuDHMH5HzQM6l8dloDQMS0RKTzOqLTIWKon?=
 =?us-ascii?Q?bifRz6ImSqsvcz2zkbGJ45I5nLJYZejLWPGtyCc59mfNTk8V1Ofq2KpLG2tX?=
 =?us-ascii?Q?akuPpdRLMaYROyUB8EVflk2qOZzHB/7JXeis+Wn/uU9sd7IQqvWxqgaJZ2NF?=
 =?us-ascii?Q?5noLcar1gJeBTKiBg6MY8SLulCJqxCW9Ret+tDo0HuZB0TdukU0QUfguZG3+?=
 =?us-ascii?Q?Rf4ijrpQ4fC7exMn27+TNvrlINI8QkCBsLzk0rFyQuF+1XaoRuvADGXJenWj?=
 =?us-ascii?Q?P+GHCr0ik+ze9LAe9mkl1KnWP86z3hl9J48GTzmIj0XHW4Ryl9kcJVFItms2?=
 =?us-ascii?Q?hkEN7gH1sKVGYGuSkcpLvehH4NENC17tcHbMsYLejLRyiK5+HiI0/QJgmus6?=
 =?us-ascii?Q?LPcjlFtSjQzeKV2+zY2NYpfG0qMmrs1DB+QxQ60vb5adhzDvK01z6/MDqt5p?=
 =?us-ascii?Q?pxF6aFapbKaQwGiEtJTB2gG8upkRn6rjbpg8XdkbKPHKryyGDc4vI/Zg64Eh?=
 =?us-ascii?Q?6lrzbCbBOM80PovTCsntbbT4gOBA8D1Cse8dxR35SLkkSLO/jHWYhMLyiSAD?=
 =?us-ascii?Q?UusPNHNRdWEBzQH1GyzOA0qcalb63ofK0mLMB8Cm9f2EOQE7J7evdGeOZ9Gp?=
 =?us-ascii?Q?SP7B26zHPEE7GHDb41lpYXXsPzDOcTnjfZlYko7BZ6OqkUjXTl9vdDka0xCL?=
 =?us-ascii?Q?LuZlR/lXPMoX0QsK2gaY1zNgIg5RdHtPkk4W8tVrsMa3Yw77vDRNijHMiRvu?=
 =?us-ascii?Q?ZEEHGqMy9+RuUB3DEJHtHzOhEhEzHQkcm53idUezV3MpEXtk1goGsp6rUMUu?=
 =?us-ascii?Q?OKl0jvqGUoi8cn/2xVSXr2vttyt7xUK2HxquQhoRnKlB7nLa4bdHUKKcdHPs?=
 =?us-ascii?Q?X3OfezgZot6cMZBXrS5Vdb/rcLP20FD1WQFSx95VE0HGYPs/6wzcofpWNXRf?=
 =?us-ascii?Q?DYhhW5560/kf6jWfGBzorpZPWLx0qjc7mZfDEbf4RXYVJMDWwUBDFzTu6z2D?=
 =?us-ascii?Q?Kpz1gvmyxFG/jYC4DeaK6b/BbZsJLV8Cf6wV4uuLuQpLnsJpWYKnEEi3kKur?=
 =?us-ascii?Q?IgU9nkXW9YT095BEcAIetIuL0uErJKd2Es3jBNpPMoNKmPAtqRN1NcuiLmZn?=
 =?us-ascii?Q?ec2D/fdaiRD7W2Dxz/4WyXiOhPcuTIdI1+q8UG1EM9LTF9YJmUYF4CsQAaX7?=
 =?us-ascii?Q?fDgqe5J82Lk/nZ86kRFIqtXXbSGfuT4yeFbG5sOZUxGBp9gC/u7ZgT/2hdpL?=
 =?us-ascii?Q?48xRWmKUmnfcR/3pOu8e+L27fQXPN7Lgv5ZI9Lc9BLSYM5tvsur70DS/76rb?=
 =?us-ascii?Q?KMcWIIHUbYu/ZgGMyTuNmjFm+OUaWphXTfoEZ/nrNun75NxiLyREPhIJgB1y?=
 =?us-ascii?Q?BZ9firohDsMWinXfOHHC2dNXGWOsw4EGkW7hCylb+3k0R5L9jwGvbOBl4XTg?=
 =?us-ascii?Q?i2fuMEtdqhFhIHK39KWPIEQd4pRrmfg9yAonEdflq9gKWnfE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874eaca4-096e-4df0-c923-08de67e47396
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 14:06:42.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjDdeLrnsXJjrNvbUk1x11u8h0AHLXtvTKA0RH6ODwGemgCmkxRIUHgAg2uOiDk8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16684-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD2D7110165
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 02:11:32PM +0800, Junxian Huang wrote:

> > +static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
> > +					     size_t kernel_size,
> > +					     size_t minimum_size)
> > +{
> > +	int err;
> > +
> > +	if (udata->inlen < minimum_size)
> > +		return -EINVAL;
> > +	err = copy_struct_from_user(req, kernel_size, udata->inbuf,
> > +				    udata->inlen);
> > +	if (err) {
> > +		if (err == E2BIG)
> 
> The E2BIG should be negative.

Oops, thanks!!

Jason

