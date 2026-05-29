Return-Path: <linux-rdma+bounces-21534-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJeMGFIkGmow1wgAu9opvQ
	(envelope-from <linux-rdma+bounces-21534-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 01:42:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBE609EBE
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 01:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FCEB304EB9A
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 23:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29483976AD;
	Fri, 29 May 2026 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+rcsYpt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511D3859F0
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097728; cv=fail; b=nppcbFBPqpW+ACpSaZp2zm8DcJ/SGSRBcmglsDBzrS/5o4EvOAcd6jsZ4bnVNFlIyA+LDljOzlhgpkkYX2FBdJDYzjN8NvunPWg9gfjhA24HeCR2Vo2IEYEiRI6q9VDJSuTXb/0ay45jz7ZEYsH5ZC1oZWkbLznp8ecug+IzDLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097728; c=relaxed/simple;
	bh=PDvfZRCCJpnm8Ez41GDcMYdggEf/v7qGnr5Xaw6iwak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nHofZDj84dMfwCyW0fZUCjkEGBDM0K9D8MGOAUzn3LljgUXThUzSPjNJ9bKaO83xrOnZXHTdL0Z07bCzDraVWPrnxB7s34m/QyRTa0ejm6F3+7TpJtipsuKSv/zU4KxQDs6mytvXed5P65tGEkeJmBGICfy1A97wUzzGpbLLbvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+rcsYpt; arc=fail smtp.client-ip=40.93.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwruXCAm4ec+qDKCEzC6uz+tGmfvMUVOw2iWJEuFXxRuOIArxvLfmm2mt74WQGr7Jx1wUkM+v/uHNGrpnmdAyjd6ikLQl2dSw6GhFBW55zqhqHra2MjnyPyKWEMODiAUKUj7a3RaVkgRY3DtWtYvSHqIHSsCTv4IG0dC9NAxT7TCdp+yDQINjPcEuOFV0naZayYrrQU0QQ8rkbEFx95f3xgdDG7Qv/pqBe1qmlzA8/0XNIlSAXknXgA0dkZ+ZjKsBF7qKFfcBZ9CzHmfi6vqr5CoF6nmKZ7KlwR9j2MTLF4Gd3fN6v9dsCWHB43m2FtElOm8RFGAfmyFeb2gxK4SFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3Hh6U8352JnnwCieDT4mEQl133BV/l4/7VOFk8pm0k=;
 b=H4TZmVvKZsDyNMw+hgkVUVHVMrfC3qVGVjWDee9clc4E5S7YTzN+SvxrQ0L8BnxxSYqRTPpXQFOaN+0wi5bt6MxxDwso9/8y0AaaNqYiD8+WJhfCUY4hs1o3Z8GMiDKa4HwMZMNL5FbUleNpzeJlGtVKdC/x23esiKLoQ+ZCyo7DovsKfDD/HhpzfQpMMJ3HkrHTH35iV3TF+dof0m6CjQN3PDewSPJ2RrwDJbQCn+htIi0YyN2ITt6bsKZKLathaUdx8koUsPwHJ2qvJkB0IHwl3UYQ5vNvS5V2WapRj9EtTW2yYscaafSPnDk6tdH7JG+wK+23KLUBWP6h8xzf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3Hh6U8352JnnwCieDT4mEQl133BV/l4/7VOFk8pm0k=;
 b=V+rcsYpt+3rNzYcGeY8iEuVnhVlL1F4/TkXUv8mDLI5YrgtEjpfuNXIDo1MTJmo4Unu1Z8QsEw4nmWCjoi+ehouuGEDS9ed8jjCU6G+/Rg1SQTjIlHqD8FKRha4vgaWnS/YbGES1Qnq0LhMCzctc3Mwzdunn/m6hN7OsB0n+asxY69iQl8b73mbi2FAjq2/7ZpyOy+Vz5mD8vugTtE2+FO6AR1099jDGeS3KR6f/Sibmi9KSLEE6XV0IQQ+giSzjllC/GOlrS2G0Jpnxgr1gd0nY73AxzmoyK4+hv/IFtbMWL36cnHBIWcXe7LHRK2SdcKh83TNrG7j9VRIbO2QYvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 23:35:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 23:35:24 +0000
Date: Fri, 29 May 2026 20:35:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
Message-ID: <20260529233522.GA223905@nvidia.com>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518215040.1598586-1-tristan@talencesecurity.com>
X-ClientProxiedBy: YT4PR01CA0237.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c123f8-c6c0-4819-bab5-08debddaf4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TrzLTb/WaERZalCr+DzfMx/k9hkOW5hm8IrWVql6zI7+wggg+7v6I5ly0DyHytvwx37r1CS+ysgJvibQZXCdURvm+DzpP99PBSgdcDQlZV9u+nUIsp8B0CY5FXYu1TsDuOlEV/3BLlaiD7HwtYqEcx5cUx3NttSDaH0Vnle9Q6VBAGnNcEsXGnYhXwWMQQzfBS+FPyK2/7FVUx+Qh5FfRAUQ8g/q2cR0/6D9UxUQLhuRFH5/1k1qVdOolsgeKAj5K10f4lEjmQAPGHWqhGzzlpsKfme/9fakwUhT6rWqy61tkMhp6OR3cOlWQLDzpT+gwooXzP63qMJOh7ws7hhb9tPjUod4mSwsTd21kOMlBlMkwIcGZRwwLaOlycUWU+UyqkGvEWeioQnkPUwrxx/7jjQt3+XY9y90UZac0u+5TqetOVBDO8VDWt5ZoNjEW5b/dmNyn6gsGMvHxWbyI0nXnlzKkjU+MwbpjO6/0nK29Ch6a5NfMy4F9ytPLVUlZaY2wtJwkYh/DKNhiTvXsJt7gIVAj/HqHDfozlS653lJ9GjnSNsL5qdmB1BqOVu72d6pnQN23YeqAA9uLvq6hChj1PYVsv+EV3KavRHzOIwJNDAE3NcG5Sy5aezOnrgkSUg8hATiWiVsnUmNqEVC6RB4xaQB9lmArPHM+EAbEccvgLenxh+oYYhnfC1GT+3Z1yvT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0fF5gpDHbJuV25+goNb7I5zdgaV5lNdN5alGOtjI7b+oucUWmtyfZ3eMeu+?=
 =?us-ascii?Q?uzao79MsNhsZCkZ7YBGmWDXTJXdUhH60l/oQp6RlOikoRiES6/ajKNqibeeM?=
 =?us-ascii?Q?9nldVFUM8v0WCYjmQAjwMkaUJID3Wyt/ic0Dj88KvvvFzv8R8eQNi7yTw6N7?=
 =?us-ascii?Q?V+3QtmqrzCZ1YKs+lx1+QGGeAaSjPHDRLiyk8fxcYI5cZjRC8AAzHJTxZgms?=
 =?us-ascii?Q?/2pHG8UBjbj+akOhnXZwpAZ7PrBuluQcvMIrdLJqPIW1oSwGcEH1KS+LrkXQ?=
 =?us-ascii?Q?0nnRLRGLUomoY/JGu50h7P4w3TmeARuMviRZUQTpzS/vvEi1Vy/yMUE6w3fL?=
 =?us-ascii?Q?jLw5xeinMg9NTGztAYhYIr4H1oXSpPNPjlJsFPVrhddbLcy99kmqq0TMavgB?=
 =?us-ascii?Q?wbr5bwha6DblULUsEsUBxWCWAL+kMq6wJI36g+/QZC7n4z6z0vWtCQgwxu2P?=
 =?us-ascii?Q?Nmqaw50aEVL8oegS2kiFXuNNJvgwfLaKm3yGjI1/04pKhQj5hONKQtUT5zxh?=
 =?us-ascii?Q?5hoiRKF6R9vXRwFdmj8DXMArO/TZXM4XObe6HxH0YBn7/i3i6ZmseUZLTtiJ?=
 =?us-ascii?Q?Rq8zWh3OnECEpBNOMs789MUMfQbcQWylt0ILnOKTDb1YuAnju7iMrbq2xEkA?=
 =?us-ascii?Q?476wHB73l83IkCxgQygUQIAJOigTBwprBlVdwXVfljQXq9pyVBjxfSU0EA9W?=
 =?us-ascii?Q?vcz5ev2e0ctEdCo0AWP2IAtK9miu0iozTnPMCaEOY4wNlAOkPkMetGzJaN9C?=
 =?us-ascii?Q?rY6HsZg4Cn+AQ+i2zphxFMlYzxIn+xocU7jldeCjSKn6Dm8J+gE26KQ09872?=
 =?us-ascii?Q?nqyG9yJOSynAo0AOs3Ihn1HW0kMvqhq17NmdUA0BIgPWktkVfn/lu1N7MHuG?=
 =?us-ascii?Q?b4fqNGig0GzhL3DtiMEK9SvrwRRQKaERJ2NFHxUtMMPq5EtzDG7LLkqSbDTT?=
 =?us-ascii?Q?y/muM4IF/PRbnwh4GeZKrjHQuc+Dw7/cYoRv4REn5lqEsJluDkmUytIZ4Vuf?=
 =?us-ascii?Q?K9N/ul9yDJVfJ9oLqzFLW9gwx8C+uEre9DbArtaJISkYTl6W/ojj2fo15Ol+?=
 =?us-ascii?Q?HhoaaJ2oSidV8uwgJNvDQ7dX9YqCHaE6SXfNnsNt4adFmlnIqz3DdoYy++vh?=
 =?us-ascii?Q?WiFe9RRFgacDtQ5UTJHYudzDkjjp+fyezQy/CrwBzGzsPUGZTTw7pUwUZ0xg?=
 =?us-ascii?Q?Q3VLqA+8jwIDpwlV+BAcL4x395WJEzPpQE8DCjqexmRoGu5LOzliOo1HR6OL?=
 =?us-ascii?Q?BpXoNx9OJbXInD/QDRu9AjShbKgSAc/sA7dFJOpzjU9n6e3PA3z5xgR5kBYR?=
 =?us-ascii?Q?BW6I1R8aJ3T6+vcBpROELVpDdeZPo2fvcLyYZ7sLaw+wh7eSy45UKCGG5t02?=
 =?us-ascii?Q?7V2re54zayH4FcnCmDNGyLuTWn7GPFDWUQu1IbkfWAkHUlEdWhbHWzjdMiZK?=
 =?us-ascii?Q?vZrZ8wc+jRKmPuNvtsjNZ6gDXYXLO6eJWeq6FyJp1hodf78VsVDIA17jWv57?=
 =?us-ascii?Q?iMCgKkMxz2zLp4ZkmxKGGTEsuaf/uo3I03I6Yl7743rWRV4tPG9aoDJixZU2?=
 =?us-ascii?Q?rNQJXKzNEho2esXZHteu7VeaGSBMgspKguDAFu/c4OGWsh2G/rML/itbdQ28?=
 =?us-ascii?Q?dAEtFvmMECPXyUDmYo0NlXe5pL/WnGk03o1i57DHhXJjeIfNxz73b3yuv2er?=
 =?us-ascii?Q?lLg5h/VGFSwByq2IcYMu2Uyu3MajXPhtw36n/1SwRN0i/f/7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c123f8-c6c0-4819-bab5-08debddaf4d4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:35:24.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rclgRO77L9c2ciWf3WVklLPd0JNQq41Y6njRQiTJG97sVnO4Z7vFLUkx2XEPrpHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21534-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,talencesecurity.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: B8EBE609EBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:50:38PM +0000, Tristan Madani wrote:
> RXE queue buffers are mapped read-write into userspace. The receive
> path reads WQE fields from these shared buffers, which lets a
> concurrent userspace thread modify them between validation and use.
> 
> Patch 1 fixes a heap overflow in the SRQ path where num_sge is
> validated but then re-read for the memcpy size calculation.
> 
> Patch 2 addresses the non-SRQ path by copying the WQE to a
> kernel-local buffer before processing, preventing TOCTOU on
> fields used in check_length and copy_data.
> 
> Tristan Madani (2):
>   RDMA/rxe: fix TOCTOU heap overflow in get_srq_wqe
>   RDMA/rxe: copy WQE to local buffer in non-SRQ receive path
> 
>  drivers/infiniband/sw/rxe/rxe_resp.c | 33 ++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 5 deletions(-)

Applied to for-next, I added the rxe_ Zhu pointed out

Jason


