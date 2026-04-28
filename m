Return-Path: <linux-rdma+bounces-19658-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAUZIe7W8GkSZQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19658-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:49:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECACE488367
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BB30301981C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D083BBA18;
	Tue, 28 Apr 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TX9PWWwv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDDE24A069;
	Tue, 28 Apr 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391338; cv=fail; b=dWETugJKPX5DdFUgkBZDDbe5EtR2hLt0yACVNSyCN6MEtdpKtYt0ngfmaWppaNlrubB5gB85HPkl1M9xRP4AE1R2//CjkZjB7hreGaCStXT9+nqeOs3XkApTs2Jl8y2WBl0sEMrq1HMdZHSVoVZqm0MLaiehD3z78U7odn1w3qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391338; c=relaxed/simple;
	bh=6EeDoH0I+gZdq9TzgPPqVQsEF/KJip3eXk/LKf7dkB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LMSp0YzeayNVlTlmbSSut8me2elnmrQU7Vz/Qt3J033kV+tk9BIQaNU0IDLQYMoInCIz1gLPgdNsFw8M10B1UwKpO7qG3Bb2Dz2Vd6EFRpkZ2+cBmIbIWJCleH1q6a+fv5IZIH2M9SIws47Ff3/lYq0nXR/OAiMjhD/48SdmhiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TX9PWWwv; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQsaz6E+PPsSlIAlq+SS1cOroz8XlznrYpTrRWSvQi0Y9PbT2dE90Td5cA0UvmP0qM2dOdNPQOyzbdBhwZFumgJqqxUI792L/RfGNkdHmu2ZCMVJRcvLrU1HXS5jkd504A/z+PYHxQoSipY3+hHtvPHGau91rzHqOFuQqLAGsjD6rXpN+1IkrlyPjOTvkNEt/ahtPgY+iyRxRW7V98tETSs7WgmKIefGfYsH23m00isWiuSiNPCLhExD8tEZCQTbD73YxlP4sTXyJ83h2vOxWecqgWnqaOzrLeEgHvZTlLF70bY5F3qgnFUM+ioFSR8JEnCtfBuOdr600Mm3qJwSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/rDHvEWtvgLV9foJ6+66NS7kyJXsnGyXEy4pS1fSpA=;
 b=P/gG6RNRszoh79ICRSIqPM4wHZS5rtFNTKTprIKE70K4mdCsoywToFUbu0G2kEs9He6iMDHTltyJN1D0jqqHSEN+z5pu+zgChatk1WCQYw2bcGdcoCuptIlPe6NXiRjDvANjHbIVoM86K+87M5GN+rGUVA/P3M/x7vo5IPaKy2Dn7Kw/3RZz3XxXRfGvhA5BtZ7jCZJY2iFBbUXuedTtrZl+ubW+rb/O4ePYx5P1XUL6+CuLpWIVKYf1FrZ2lQt/EVOV2k+gDH4oZ0YX9STPl8vnEQWNtaEwUaHfXg1VEcdLoLYFUOId+IlHEc0R+cEdn0crnCOGglTOhyNtdFEoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/rDHvEWtvgLV9foJ6+66NS7kyJXsnGyXEy4pS1fSpA=;
 b=TX9PWWwvEy0dANgRxVVaUS8F02rcWEVwmjpwr+g3qR0LOC5FHd5hjFO+Y/FRWHmhnTymoW5RYPRRPz9efpND0bTeUZtXoWJuJUzRtI8mKGKACFISe/REMg21aXfk30IwFZXZWuy6AodQOv1at11aluhsX4bTd2BwGTt6k1n/Gkyyc/+PN6aO6DuHHDU+FDZTuXIRY/Eae3xcL4/gHWVlltDQs2BZheGBLI15H0ycGlmzMWztZtBXUdGWCzvWXqKSFvJgR46mEYqAGLcmijx1Aw3WmX9NpbcaM4XkVUI67kw7p8grDVpXdAQs428vxZoEjkm2Z168lj+NkQtH+0krww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 15:48:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 15:48:47 +0000
Date: Tue, 28 Apr 2026 12:48:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Fix error path fall-through in
 mlx5_ib_dev_res_srq_init()
Message-ID: <20260428154845.GA2767188@nvidia.com>
References: <SYBPR01MB7881E1E0970268BD69C0BA75AF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881E1E0970268BD69C0BA75AF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-ClientProxiedBy: YT4P288CA0072.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 6377d59b-90d0-4fd7-cc95-08dea53da23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TbcNagK3/gkjc1fT95XVw5jztQbH+XK00IcJajcBCYcMb6rYkqVrNl/ilZBglmO+FEHmEvWE15Uqfm/fB7ItKDSg1JP/5amtQYRuPrJtNbW4SEkKyx2bqeh0J+xOBdGN6+ybQ5sb1vYfGATZx6onzFlmz4hTT8rN6vz2nwRoWmJp6v80iT4YeW/ZMHpCDdF0h7/EYm4zY9MnDIk3GUKaEx+rSin/G+pGwE1uuqAWUXVI0pyuEhPEmDkJLy475LFga+i29DoWdq2J5q+nK5l1TTgXdUHhjt2esl6InSGWoouSw1v8N3KwlNfZqJXdYMgF1drXoBjITSi8LZW3JPfEsEXSHdZ5ku2eAVM3BtWYsH89IsrY3ZJmv0XJKuGZK4Z8FE+BICCSaZpQofDJcZOwe23nEjRZ3eHxjbcux8VXnx+SqaoxoixUAxRMmDgP3r/KeHhzRfR+i/gC0vIvHTo+hjaDhyxY4Jo9YSrRF3ESBLPVXi6bbqMCUzKAyuUsWr7sr8cLKTHE949Pmvt7XsDG+fytvNbtsZLjli38YZ/YFFiwtXP+ko4ALKVADV1Qo4YeLbZHiZljHWeA4BMUeJxxCpWrRxCSHt+DBeOVWMLdgpOXi6BJ0bu743yHsP/MzA1x7gswfAnFWtvglyjK65w01Wycq3lYtCkm1PTsktnym7hrOG1DLl8BvLt4hBgTrctXfG38UJuAR0GoCaRPnPgAOfkn+e76Ax1y2Dgco0APWMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFs/oebOVVUN6IVx0V35sOrVj/aEJiWdYzUSQxky98+E5/YpnVAWBsDwjDFV?=
 =?us-ascii?Q?vmXAaOubiLCjegCOIEXlHB29IbbckZFQRP6rNPK/ru026BIKbgS/Ye3N+x2x?=
 =?us-ascii?Q?/klR1v3ik4uFrOx6K9DKJasAQcxLa70Cg9L+NS+ENPDftm8FhBASxSxuMJL2?=
 =?us-ascii?Q?znpYcDRONUng5xNRBSjvl/UzSN/+/VfnZJ6iqpQpCVYzlKVzzW1apL+NL/ew?=
 =?us-ascii?Q?ZMRbn3OoVEAgPlpmhmjx0wp2zF0Cf/27wuJwmj9tKrt2yd98eWg0tuWF9pvD?=
 =?us-ascii?Q?4S1FLN3UEaA3cvf/MOemdMLiCHYJ60nMRFOW9iC/YNWWNbrJrDNzzNsZIKRM?=
 =?us-ascii?Q?aW0ywPDh0vfLWITK2mBPTKDAlcCwWavP/G4/oz/rUmDsMoi7c64fHbUfxDpC?=
 =?us-ascii?Q?a8BLvcFrIbmBibmZd/Qfw/49l6p5+dkiVsso7P2UrJ7/lquA5qPAWfAmneGx?=
 =?us-ascii?Q?KOBJjolOULH2ae4VlyQAP8/9Sdbq/oPP8NxIkhNeXwviyReGdKMKw6SOuEBO?=
 =?us-ascii?Q?m5AC9ZofKxfiMmfJB3/hMfI350wGjMbZaeUwlzPKrd9jt7red+G+PgOYPoDM?=
 =?us-ascii?Q?X9U8P73Vkr/A+88+ecTkkahj6khoxZ9IbCIsOrVtWT0kra5rS+4HYl254Sjm?=
 =?us-ascii?Q?MIaIVjJg4kX03qXLMWVN03xAKjaNX+nXcEGUnb+6TE9am6MUSR4IJbaDMiS3?=
 =?us-ascii?Q?GmtwknkYXInN1AiSsx57QRO3dSJAGE7ZZpQ9+Q+KfqdPLMkJXXtrL8q+lz0S?=
 =?us-ascii?Q?fUCdCAL7J6N789OrKEyeH6wXdP1gIThsyrizfIMd+3EqtbermsZFxzLRKxNa?=
 =?us-ascii?Q?USJ3vCshAY+Z4r/MuLnp1gPS85ZoA2XMc9aMFjjTZDpRhHEJDbJFv9Bg7Izx?=
 =?us-ascii?Q?xmk3JI+xNHAe7YFqyyqQu9hzHAQSkxHSQT5eS9hqNdAIVbrhQ10BkCb/ywcm?=
 =?us-ascii?Q?eEH3xBnClAfWGj/Ys+Twd1iMKLS/rajQ/IO6TNCDVyrFjn6qBhNfMaUQNOIS?=
 =?us-ascii?Q?9vkBNlnJ1EcRFfjiIaXAo8qjFzG1681dZzrqwberqv41CanEVh2aYLAJpqWy?=
 =?us-ascii?Q?eJj8mgVfdKEt55OULm1hl4beOh7D2XSbNz7vj1FIZ8ys+UXYo21UCtWW2Pvw?=
 =?us-ascii?Q?kvQrGuR/396ef9THb6fMNbBuVeNxK9q8dU//yvNoz3E29YxDKCEFKhDMNVID?=
 =?us-ascii?Q?yueQX/hrFO1HEwBYPo6zORgEfbRewBO2PoVyeNqiu863XvUKt7zPUtjvdvQS?=
 =?us-ascii?Q?6l57prQQnfmRh4nvLHc/2ng+c2VQ5aThSnLTYrRSO/LzHpZP3w5P/X2bceu4?=
 =?us-ascii?Q?MOkKB1RI3Qb/Q9KBDNAqwPmfr1dDJAzkQCc+VqSUagv0o+hILfWfDnXVatKo?=
 =?us-ascii?Q?leAv9tAkrZjOCaXPWu7J3VDdpaEWaTIPS6M25wIbM5eLkJC5gELflgXHr1vh?=
 =?us-ascii?Q?j6jWPUfcMq/taXlOMvO+44YJouqFPyPVWhtY5tOc8jSPTTQu9ZhVac0wOfk1?=
 =?us-ascii?Q?nz+sj6esXvt/HTGbVmWlxQ6Ji7p73i5CqCfzntleRr7l5CksEwDD6IOAY4re?=
 =?us-ascii?Q?BofafxyXVwT47cGSa/sntCE8L06nuPFx79niuGZDlokpOiejE0CYFWP3qA8/?=
 =?us-ascii?Q?NaCCeMMG83lEEh4WXbc+Y83CJlJRzMkEi/3U95JxYe9TTKpZRNebPO3zciTk?=
 =?us-ascii?Q?Kg2ZYt+nZ9sRQd80fVGUxhr2Cs6ncBtLgNZqWzOdU/szaFiY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6377d59b-90d0-4fd7-cc95-08dea53da23c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:48:47.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PbwjBJ+ERUZ0gRzIcYxct2Te2hQjdBV/mY0a6HVQHUSTP7vH4aFcM7kDQk3z9Ci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
X-Rspamd-Queue-Id: ECACE488367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19658-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,Nvidia.com:dkim,nvidia.com:mid]

On Fri, Apr 24, 2026 at 01:51:02PM +0800, Junrui Luo wrote:
> mlx5_ib_dev_res_srq_init() allocates two SRQs, s0 and s1. When
> ib_create_srq() fails for s1, the error branch destroys s0 but falls
> through and unconditionally assigns the freed s0 and the ERR_PTR s1
> to devr->s0 and devr->s1.
> 
> This leads to several problems: the lock-free fast path checks
> "if (devr->s1) return 0;" and treats the ERR_PTR as already
> initialised; users in mlx5_ib_create_qp() dereference the freed SRQ or
> ERR_PTR via to_msrq(devr->s0)->msrq.srqn; and mlx5_ib_dev_res_cleanup()
> dereferences the ERR_PTR and double-frees s0 on teardown.
> 
> Fix by adding the same `goto unlock` in the s1 failure path.
> 
> Fixes: 5895e70f2e6e ("IB/mlx5: Allocate resources just before first QP/SRQ is created")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for rc

Thanks,
Jason

