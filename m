Return-Path: <linux-rdma+bounces-19660-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGLMEPnZ8GkLaQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19660-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:02:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774B488681
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9735430A1CD2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA303C197C;
	Tue, 28 Apr 2026 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AhAGGXYc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD328640C
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391745; cv=fail; b=pEKqP/lGr61AlaydgOOWVP9YQTHYg+WN3lZu+n28GEvJH3KlYkId4aXWdgfIOsSQuTLmL/WtaiDiQxmzbCPNeBo+eux0Za5KI/0tw64a/iw84R7HuSzBCGojaKgpy36Kx3PrceNvMq6oxgiG+oo4YhM4KyR20nSEKSVcsTi01Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391745; c=relaxed/simple;
	bh=A2qzo7KWkeJa2PqDQSDivwmqdperJvlsm/MSq93ltHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GoFOoPyBuX0M2nSypjCI7bYx9tDpS5gkoMkLl5ezsKjkpCrlSAnjvQfRYWZpWor1v/mIFHjGmj6LT4EVezw8wWMSdIZFvsF3OGKcGhzVzc4RLhIdXgWuxWrzeKFHng88WpOdVSnBM1A/jGRShm4zdCDKUafq+nKTj/batrcuKGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AhAGGXYc; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apJ7MZFIc1DatFe/OnwAsMzIVTONgTAab/5QcFkkCdLmtMXaM1hxcD8D0pu98KT2/keLUcXPR+/5effJxFvCasR16kcbbJdKTxSW9p6qURoL91HEm6PgL3CfF9kB3RIx1WLERbwQVqAPDk9AJCtfFvg9cmoRaaHWylnlCDE/1SlVufhMd8qz70nKwImw5+CDxd9jRtVxgfH33wKoWO3oaLB2sEF8vK3b9+zOyTjaIQfPLa9poyyrmueNaYugyHOBub4nXolxs4fuUvkqoXUoSKyW+w9nNwNj+dk1RbOCaZsnBk+HS3HKa3dLIieNk/5uNgPUdtDi0FV5u1qzmrEnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0M9zLtjuEjV72yM66VmtCnn9RgIKTr2gSxKgpB1l3w=;
 b=YHGswjpjK6YabhF4a3NJPVPz9t+SjNusGqcFDtz1BrR0kBCXkXOlzo0QIPHTuHxgSV1HBXvFu/hoSaUlic9ORoVCr675y0w39qKV/ZhxeXpSiiShVglLooFROYWmhNRIPzaDeWEr5whw/7pt7uIrtUX69/kNMOb02+xoKRKmMvg13w1MrH8QV166EQEpyDqamfFgPNiFgTNHIJPkZOHcin2kOEsesQKmiHyTi7WApghxQIh7zhyklWmOOkufMdsXlm4+BxT2sBOEjXPmNc/FA/GicWjEcx/j3CwQqCkWd/agr2ewSRIXhPm2RmZntM31K5u8it3aYN5FP4r+u60Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0M9zLtjuEjV72yM66VmtCnn9RgIKTr2gSxKgpB1l3w=;
 b=AhAGGXYc/ywBpwvjeaKse3C7gYqcz1y1kzEPZjMwtrl/NHjMCm5MWY48VpigQMx6CdLUuDOtwHB2UyOG9lMWzcYpFa7zBca8oC+zM4ke63Bw6fgSnu4CbLCEIneyYX1kF9QdoStI03R2cQDoUiJeag+lBjXH89hJrX+5yKaKU88CY6w/AAbWpp85PipYjj6jBLNzTpHdGddEPKuNIMhIfvr08gKWkn8zTRfipSSrh6tXNPM7msWpYNp+sncCTRoeF1NANkTO6yCah+xm2QxwfZIasOhTEt5O/u3FkDBjotNJf/hxdX/fvUoHXYEhh6UhkSL+IHR3y+9Bm9U3bt7Ddw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 15:55:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 15:55:37 +0000
Date: Tue, 28 Apr 2026 12:55:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: bernard.metzler@linux.dev
Cc: rosenp@gmail.com, leon@kernel.org, kees@kernel.org,
	gustavoars@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH] RDMA/siw: use kzalloc_flex
Message-ID: <20260428155536.GA2774550@nvidia.com>
References: <20260421192821.2305-1-bernard.metzler@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421192821.2305-1-bernard.metzler@linux.dev>
X-ClientProxiedBy: BN0PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:408:143::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: eba85818-8882-4b8b-60d9-08dea53e96ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UKXna8RNf0dDep3x8NfG8+sc6b3nJ3fg+XUFEy5ZdDCe3/ccguajXKpOZxvc8k3Fp49ZBOoRKaopuzwq5dim7o1VySQ+Nh33PKwKF3lxaq0LvXeeelR2CdAnYm9DdGR73QdmcQvOToF6SHNruOdtLDKeOEbQ2VL9j6vobllGKF9hsSAL5k5iWLG4e/j5NGGMraSrBhv/Cy52XjDuxabAJsamV56iCV9fOqYTuz2eQmT1UJVaJiVAZonWzaTDIAF7+vk0BJcDxVyP4DJS8euQ5mZxjYds/fbgni+n1R6nC+WxA+wmMzSS99StmBAr9f267FkGUoLp+ETubtOvpy+xLHFc0DkJ5HVYmqh+fMrIjCfO7UcHtv+aexrgM+Y9bhaKqdRwiDs5UYG/arFCBylkH+xk+iT0BOdR0sPuKE2XedF0rtwpOtN8I2D5oCf45gum1A/SSWdCBilL+2e+j5lw5FmsmLbh5PE2HFP0yYeVhLOke5vKyAPwdFgWvABOgdeb2ehLntpNBbpsjqW63408ITM3lVrxLuKk4aAG9DJYbcOfPkZiiIJseaorcyXqGW73PRkM/sSxY5nIwCSOoxCy6jCoIQvTnAmzlIQrzpor5d8yx03V19GuU2khfqwRHycA0zjrByhNhm7CHl0OkBLdUsnNMCDJqn0lUfhCKINbMnV7VerBWx4K8qIYGx3uSPexBt6Yddg2WeaIG1nuSV2ewg1h0eSbAzdU30wJeAL9TE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gm2vLtzteAk/GiJlIC2wZXxFtPKFDuIvMnB7GVSTsvG4josXFojf4ZCo1VOW?=
 =?us-ascii?Q?5yMefZAH4C8+8uMe+ivbNcml18GI0JEIQ57zGkbxJBbAuRDCQpeAktxH2vAZ?=
 =?us-ascii?Q?jBOc1EUWq8h/FM7/idyI61TXQz7g+Ior8ilEuqwPdRdIUQkejxKNFoAXhNTA?=
 =?us-ascii?Q?KPPwdXMix1x8Y56aYjl/WfIx9ORte7lDTS71dlJxM0wY0z7688rZpkWAliA4?=
 =?us-ascii?Q?YOX8U3t4h3mNNriLATW3VCXwZgQ2LlnT883/MPiIscv8L2ryg/XDUkbkVrkB?=
 =?us-ascii?Q?tzDf3qddY6Zt6Nnf2/u5jJqhO1+RsEr8UFg5rAGw4ZYVN6S47m3XW0453B5U?=
 =?us-ascii?Q?kFhA73FQEP93NUo6xiG0uAejt4TOep1wBbJ/UOsELhHCRaHEOuh8kOK9vkoW?=
 =?us-ascii?Q?Lq+D2G5RXyQEF3tw0Q6a3TKYz4BqXwaThAB0J3FrNoXYEraZee8n/yIknGoC?=
 =?us-ascii?Q?9FNqvE3A1qF1M/q11aTl8pkz4YnDtbuUxqo3QKA8xyZwQjViGu7cJ9PHCH7C?=
 =?us-ascii?Q?cngv3+vWRkJd7u5oDP9vMA1rlZ9+chQZmhK2Y+aquZzLoVWldWGsE0R8OJ+t?=
 =?us-ascii?Q?qmv4mjAHUbQpexw4eL3Fl1AsDDrSUMI0SahRi8Wcn/Vr2Zdvmg6jq131orP/?=
 =?us-ascii?Q?tPuCBGT8cAkSO5GLMjhReDhXTgarWgz1UEASLDPYMkuo52Wlb1cYn1jmEPyO?=
 =?us-ascii?Q?FZZsqfW5turJ8AOpbC+FJIQIbFB7lGJpAOeuxcq1eBQ76cMA/RVEDA1dAYK4?=
 =?us-ascii?Q?ry/nOMka4PIm9HhEZ4AvBwAvGZ/t5OTDmdO66oi/ShGSJgfyZqETdXvtx52J?=
 =?us-ascii?Q?Er8+EBBJDez7MGZQGBwG4as+R4ga6BeyyM9g0oU0ZSv9IVP65miiFNautT5t?=
 =?us-ascii?Q?kaLYcgITyP2pzxDkBwlJ1hs++SlPyRdz/IuJaWj+Mkx0c4pynKO9FGlnu7v6?=
 =?us-ascii?Q?oe7TjWEd5atyitPCnRk4kWfrQNH16ORyBxFQhxvkiGTiT8iIZnI8OcmlTig/?=
 =?us-ascii?Q?1jmehjX5OVrIFd+HkGyIk23pHRQFYG+dL+YeTACBjSJ5iwuNWIyu2jNSKglO?=
 =?us-ascii?Q?/9uh8dwCQrxEaxBKr+rWxr/M9hku45/V6Pgx9Ed0bM/y6Q8bfEc+7KxYrqEb?=
 =?us-ascii?Q?0IjOrEWoTZBc5ZL0VIjO5tWkOo4D0aNSuTY86JW/IzgRpNAT42vOL+ikBxkZ?=
 =?us-ascii?Q?s6/pTyKNQNnCTpZon+8VIwhQ9A7YUJnUNj8/Eu/RWo0j0tCFP3rYFMogmbdW?=
 =?us-ascii?Q?nFtAtlkJMKfPtedXTCYL9/2Avm9axu8YzH01XXElX20BIhHou7iQNE8v/qaY?=
 =?us-ascii?Q?WeFJ2kmCrWVqt/Tclxt/9uqzWdQwz64i0NKbZ/0e7sqTBkfiilrcc3Gv3boC?=
 =?us-ascii?Q?/7SV6TUPLPHpS2XrL6MuXXoyJxXQYFRZvb3St3uVDiPey84UWOZzQoclkWyk?=
 =?us-ascii?Q?Si0N7Pi0Ydz3wyPQMRjSd+QbczZBz0b5co8z+WEb4JuNR1Sq1B+ThJ/XGJH/?=
 =?us-ascii?Q?3entSpB0hLmOjkeZg7rY+wtspexWnOt13e6EaXGAVCs0Fg/qC1kB4neqXOIs?=
 =?us-ascii?Q?tEG0aQkDAT7nVyKVWM0tuGsHAP0T1x3ZiooouBaCP9Ua7pFZL5OdSKF3JqmO?=
 =?us-ascii?Q?vOnp2tX66fTonJMGAzvo2GSl6k9wMc6NCIl/LDB00jOR+xDbxLc6X5z6adLu?=
 =?us-ascii?Q?LytU05HANRGtGykZ1cTm073SlyQ0ai0iM6WQJM2mX8N6JHl6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba85818-8882-4b8b-60d9-08dea53e96ff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:55:37.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkSP+JUCaQjxPXUjoUdzLSKJSh/DVP1KrQTIpgFMWQo3dqWIjJFrERJSklUNYW0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
X-Rspamd-Queue-Id: 1774B488681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19660-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[sashiko.dev:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sashiko.dev:url,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 09:28:21PM +0200, bernard.metzler@linux.dev wrote:
> From: Bernard Metzler <bernard.metzler@linux.dev>
> 
> Simplify umem allocation by using flexible array member.
> Add __counted_by to get extra runtime analysis.
> 
> Suggested-by: Rosen Penev <rosenp@gmail.com>
> Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
> ---
>  drivers/infiniband/sw/siw/siw.h     |  4 ++--
>  drivers/infiniband/sw/siw/siw_mem.c | 19 ++++++-------------
>  drivers/infiniband/sw/siw/siw_mem.h |  2 +-
>  3 files changed, 9 insertions(+), 16 deletions(-)

Sashiko has quite a few interesting things to say about this:

https://sashiko.dev/#/patchset/20260421192821.2305-1-bernard.metzler%40linux.dev

Jason

