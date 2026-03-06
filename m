Return-Path: <linux-rdma+bounces-17566-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEplGy8kqmkPMAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17566-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 01:47:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13788219F73
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 01:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50824301DB95
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 00:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7073E264FBD;
	Fri,  6 Mar 2026 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9KfAne2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD2336886
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758059; cv=fail; b=t3hWVeCS5s4rlhZ5xkT7Vk51mCqtlGahXbQBqmiaQS6ZpYsmCyn9qfBoHKhACrUtt30uB1/SimPoP+Nfn0/Bjtgs868/PqsIMj36KgUmA4uUm3LdUiinoIMITECGn+/FoskmPHBUfob957Dpi9eyXQBAJCSF0rSKsQcn4iRYCUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758059; c=relaxed/simple;
	bh=0+Ei9zegYu2wcrWA039rg2WK0ZOGwDGyHnJRDn+/NjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZsC4EbOyrdTea94OwAzo9J7TDPpxzf3YGk/hb0SfGQM9nVy0ssCkO7f8hot2L/b8usI0EY0TfntSLUKdSLHV12OSesj9f5uAi1aUo1cdrjlI12jH7lULlBOyH+67fbGpiw4lROLxP3V9LsRBnHNyI1C2C3CQ+Wp1qqXZUYkG6Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B9KfAne2; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1eISY5yOOtcZBlebpmu5fVDrGb0FOBA1jCIgpop9l6xSD11Au2pMJsL4xSWCBF0xZCUgRGgTgWd+TaKkiBSHP2vSPQSxwfUrMkXscLnY+quEUrN9MK1pFENHXK30jZGjkddIkW4DwiuTt3eWY5lnYMdFT09eT/ymW3IEVyuyHcN0mQwPQiE8rAfIAjv/MiUraXpxbN/5GQ7Z1o9aPmCkO8Cq2h8V0LZ5HRZ1UeFETRGqBEUwml3hLb8YB1tp1h7EQDo0KOMFuQgKuAU2e/miCpCJH2zNNVKlMzhL/zAB7EAnK/EWqTGSAcmhvOmNnQxy37qXH0O0TliMKcsJ64+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1AZz1EEhsaCHyCMJfBodXDc80nx3zKY+hO8DASxWDo=;
 b=vWZb+OJ142eWwHNDv4YcxiOFWiKTtYZbhXY/rAB5J37RMV/6qgQU3i4kYie6xMN3JWsRZiTTuwMbpPzIornL9fKPYgOgjUQLPrfTqhCo9C7OAWPufq7zkUWpW4T4BCadJvPhNodIJchVkrdiSz6ww3DmItRqVRZ6PImnpRlCph3oEwb1nWEiI90fN5jLGrRkqedx3zmlCxzpgXz2xV3yRNO0GJ4gwGP4/wM21LSxZSbUu7meMFr7BYsF/Stq2Z7P6GMDlRdoasoIoR2Dg7GzUmpFNgFXjkDv7uvc7WpdpYnwX6Fb3SVi7GHzqAIDiufj42u1Vx3Sm3PwiJBFE0cI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1AZz1EEhsaCHyCMJfBodXDc80nx3zKY+hO8DASxWDo=;
 b=B9KfAne2Vs4dG1W0G0qBAUBsFmJJc7dttsVdfPwWFH7kg1Zm3bSpZPULUKmIU/YAWcyfcD+1wdkX8CEIv6xFx+mXODiWTp1YE1ujhWcLL1NTIjMXLzWz3Cx8mnq79alSkSVKh+1DtOIbKzUu1pj2Cd/TuP35tB2c82228RhgGtBiJuJAEx2Ingn/5J8r762M5wj2PJ4hGLxHafeZh97qOnxXhAV70KH+IeN/xtgvbLEtlfM/SJJl55IJag3QGsOHYrzdZalrLJ1RDPdTgVLK1NujeOMgK8lzjg9c9JGqznDdSxsB2MbefecKHBE0EJQYXqvoLonT5AaxGH1fBBFdVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 00:47:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 00:47:34 +0000
Date: Thu, 5 Mar 2026 20:47:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v14 0/6] RDMA/bnxt_re: Support uapi extensions
Message-ID: <20260306004733.GA2137346@nvidia.com>
References: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f75770-8fdf-42ca-1868-08de7b19f48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	AgvF+YDkkSGOdnmUXweg68QQKGe4owVkKDc0G4zbRiRfCMpc6z19l+EZKYSge28/0Fr/z2/zXEiFrhJgiQO97+1PJ8pakrHhojHoxWdCCfzWqDiFTFmCafJGFM04pHLSD8B4IvDIqer8gwCOs2eUTEuSttgBKqr7Jl+ZaI00pG8NsQGOtcbpgrYRdWJscfAbz6jjaBmjtJJtuVbeeIjnpgy48dnjy7OLzZzDqwbIZRVHSzuxJOZ7Ig45LwdpnYhpNC7lM6vO93W8NB71YB/g1FCYMoXNr3eskh1d2UHMB4YbMbi17Z87Cl0x36cGfbFjoPIujMQR3oigVg2IQt6xOlyqf4DcfmXjmDUkxTJSb8Ol/TEk32NNaVfYjm2GUxPDLUrbaZYtCurnRO7L2NdjZyWRFu1exTEUCXEJ+OaDrCFGRt5QAzT0VrnI7apz1fhe+JHGOISVmTDNwgw3WMKKWSqzpBVDPVDzXnc042ntVv/3Rxtcw7eXyhDfYX4qG87NjyJauu0xQ5j5V8xn6eRLuafz0aeCaa2xMMXdtkhgeNAP2CKzIqaGER9UD4aFI8hf2giXYcT3IARc+J3X0fZS+dPvwF71PpfZNt8AHOwarS/ICZLFx6jaNUZDT3gvMtuRuSA+GjBFBWHPowLvKHK8WclUdUbEf1k+Q/e2uBvzY0PYkJ0szPikh2a19PDtEPR17pGI6W0+31kLxx25RzoYUkbJJJNPsfJD58T2qGzEFTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DgBR6bhgkBdhbbbRpSbmwL2knRTShlizDFUnCIwcRuHzdVC0l7Fi1BvdgwLn?=
 =?us-ascii?Q?N0wLoW8q4qrZQh93Cb0YfopaCd4XEZFJn8+0smz8WB1aGvDWUg9PtdJZueyU?=
 =?us-ascii?Q?8h6xKjqpiuhyhk2NwlqYvGxl9XaUW6OJFgwj2Vz91BqIIyv7GBMJHV3kGuLI?=
 =?us-ascii?Q?FiryckCjs66Z7RJ0ydU90G7qtTK5IMA1/0jWdrbpBTtk+gINum+5WrGzxO/R?=
 =?us-ascii?Q?YKURZ+WnmEdmW5bfVyT4lnuVYr1lxTEtByyp5OobHG79fLLT9Wv/PdTRpMNr?=
 =?us-ascii?Q?DkqKlEO1zyupenDXHGr8rOpe4y5MuXGE/8/TfIxr33yC6Y0Qr5s3WDEhWlan?=
 =?us-ascii?Q?IU/SCv0gikv+E6u1ItO216y50FGE7/pwMdsXKdPtnnJSTDsA7stFrrTy3K7i?=
 =?us-ascii?Q?3D5cLSgtHoerizsBnctAJfULb9QeKxhuMjLxDe0qW4UnP4Yl6QNHMTczHX4T?=
 =?us-ascii?Q?TapisLhPghCrZ/I99iyOTOXkhdd5U84xOLW7MWEMwfuG5qVWC4fCk9nR/wxP?=
 =?us-ascii?Q?3U+VQTO/AaWmzpTthEl2SELM4Kt0qkM979tO+410mNqxwc+It8kzgLAkoNdP?=
 =?us-ascii?Q?5Ne0WMFaVG7c3XDFziubRfrv/+VPXuK0pQnlyLU2UjW69XIvsCnxyc33Bkwm?=
 =?us-ascii?Q?al5m6935I1JhwSPszvDgKrK4Zb7Vjz6PbT9ev5dfmekKXG+8W5Qx33d5SoCu?=
 =?us-ascii?Q?R6PupuFchGQK3mzuUUkFbeZpMT7wpJS/1oxME/kRVP53d6VlfT7t27fInVBK?=
 =?us-ascii?Q?c3BKwvRCGDNO++QWZptFMc8CGNXMPYb+omtUMJ04VpBb1WcaxgXaQNicwAHO?=
 =?us-ascii?Q?a0mI1NvtcYJZb57gveWuwL1fDlHVeqZ7nto2cHsHmKiOwe3rh8fc8bJz8S4r?=
 =?us-ascii?Q?m1tAGE+U9uXOeebZZ1tZa5o85eRQA52rv7J/OnEEmyTegdSc7rLmHI103Bxs?=
 =?us-ascii?Q?APhfhnn8WWMOf+nXD388xHTcgcVm59dp0IRNPBoJRlxZvc55u35UWbenehkN?=
 =?us-ascii?Q?EmtRQWtvxLblW7ZoUffTproN7MO5fWtY9vzWDqMpvcHnoyj4bL/cr7qC0hxy?=
 =?us-ascii?Q?RXyZ8hbQHpRVfuLxiEj++6a5+fkXd5epOpmu9gUZndZwIhpyJi/MxMruYunu?=
 =?us-ascii?Q?U8v0lviliZS5dvDPnBs4rgXFbNBz/TrkiDSY+8P0hsBq+fkmFMm05y9oIs+f?=
 =?us-ascii?Q?MukiEWiE9bRsPYH012ReD75jLiA6aKKMp4BVsCrYEhFP0KAqloJlM7R1xrfx?=
 =?us-ascii?Q?fjlJ6EK0kf/rMgPWhZCiNnTeY+O5V+hPho6smw8YdTgti+Om9YDTYe2qgeM1?=
 =?us-ascii?Q?eHF0xkKDeBeKx5/hVDUmDctZuuIew26kYZxZO57O1o4bJJ4MvM0O6Of+U9a4?=
 =?us-ascii?Q?lMuzi/tEFocGiV1FS4fwmEcmJGBvU3oJ2w5bY0FOm+XPFVxDUNh/J66ZBizc?=
 =?us-ascii?Q?3KXFddpuIoEA8I1pDVoAu13Uhu7AATOEElvAPWTciin8TWgQejgSTpyY0qtd?=
 =?us-ascii?Q?vQu9NDbIHZRqNkWnHjDe16kkPWucocFbh7r21AGelGT1BuRmZwRGDV5L2ibE?=
 =?us-ascii?Q?lyG/LWycY0UtEMOU6DX5Qfsm0Op+D6aeiP7QFWuhkpTcjvd/ltBDirNmONuu?=
 =?us-ascii?Q?c7g8R8V9UHTocf6ZE3KPgjCy5hcISF9NV5nKQHLOJMdtseR36YNejnN5K1EW?=
 =?us-ascii?Q?Nnir3n34TqDgURD8Q/WlHd9vUQBq+H+u6uDH5pP67bAuc0qMCUeE6QvJt1lv?=
 =?us-ascii?Q?x+ybskeT2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f75770-8fdf-42ca-1868-08de7b19f48e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 00:47:34.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNP6QfQ1vlMXbNAjnKPyXCR+iw8NF7Fs4gCq5xrzkMb2d71yZfItctqxtMyRyfjX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
X-Rspamd-Queue-Id: 13788219F73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17566-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 04:30:30PM +0530, Sriharsha Basavapatna wrote:
> Kalesh AP (3):
>   RDMA/bnxt_re: Move the UAPI methods to a dedicated file
>   RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
>   RDMA/bnxt_re: Support doorbell extensions
> 
> Sriharsha Basavapatna (3):
>   RDMA/bnxt_re: Refactor bnxt_re_create_cq()
>   RDMA/bnxt_re: Separate kernel and user CQ creation paths
>   RDMA/bnxt_re: Support application specific CQs

Applied to for next, but this last patch should have been split into
adding umem support and adding BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE. One
idea per patch

Jason

