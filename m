Return-Path: <linux-rdma+bounces-22725-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id epKVJN+iRmrjagsAu9opvQ
	(envelope-from <linux-rdma+bounces-22725-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:41:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5166FB8CB
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 19:41:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=tiJxDcEY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22725-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22725-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1525D30E077F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46E3624C5;
	Thu,  2 Jul 2026 17:37:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722131D74B;
	Thu,  2 Jul 2026 17:37:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013861; cv=fail; b=KWrqENocbTgVv2MKyeEPZdAXDcour5UI5dJQWHjSH7Wk2CruG3L/DLjqbuzko9sZmh6sMMavWv89Ut8I0fv/eo/PCBanLsNkfADbWtwiUDFmGqwa0KnRffmFk7Iwbj1RTELsU8rusQQkSX0G9tVmneGLiZ2gJ96QAREGQLMZjFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013861; c=relaxed/simple;
	bh=vUsFJZct8/kxP4BYOk6SGSG7VJ8fTh0m85YE6DavOfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V17kMFgpDf/mpd3+mYcmtww216iJUL4mYYqkxttxLCQxl9jgwpu5rJcdBmWDkaei7rFWlFy4+YC+Qa1n6u83O2MrEZgWq5gWa21yB1SsUfzWVGbnJgufn0rzVPKirwpGqXB5wWvnafzSaEos8X4oPYcHBdvZQ4tc7fSNnvppSo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tiJxDcEY; arc=fail smtp.client-ip=40.93.198.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI7fZiTJx84rD4+pknK3bXXp8Vsiy9Ntulvh3b8bNec4BiEpmfKp2J62iIRLHhem7KoPmQ3kaAWD1nt7686DvylErXL6lCx7F4y7gLw0ydNBef9fnNXRoVTKV8VlR++ywN3yuXVO2UFFAevuLW1zDovW0UohRn2ctbcQsizBTH1uEjoTa8tdPUjvBzGROrqe0+SlrTEN+M6jetfIcvI3Bwn4Mr1b/xSsB5GlYlwZIPmSCsWt6k1ZeEyf+acQ4I0eNRbSDDXUpRgJRBFES+HBqV3nfDhR3c9z+zXc4GbTSuIKvGd5QaIbRKIRfbAHv+J17jJ7jqxeLOnjJO++ugq7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmfgIW9BysixLZqMEY12nUHe3y8CUv8+wKsBnJWz2DE=;
 b=G4HqHbjHbHPLCxTat66YsKmpqD94vwMjrtSBlVQgKmtjqTQ8BlaNTtSmwv5jQcxSIIblZjNQwJJA5JPBUlXILYlSnLRcXSjOyosgZtnH2mWzud+4bTIKk3p2Z2hNMRkn/hZdSGvVwPHh0lw14z/NHGaHNR1iP/dSsRoOgnxCNe2Q2CC2T0ijQlAh50nZ9seKYX1gk14oFEVZ11cF5hUlhCozAUXA2KauxSIlSrsB2EH3WzVmErfzF2s5AFx3F5ZUootDMA+vH0utrEsmFrQR1noeNgBY4EKHYJLTBqaiCXNxZlDjuH7xqE+aCh7DvXQBwmFxrBvPg6I8qoVq6JhUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmfgIW9BysixLZqMEY12nUHe3y8CUv8+wKsBnJWz2DE=;
 b=tiJxDcEYBgDj6fVYJpiG/Gqu0HpduuB6ruwJRGm5OpIDh5xGxtZvRhfQwjYv7+YG/si4bI0WKyU+JRRP6KKb5G7xA1FAiLr+laDyggu75VXq63woFMF0smqRvCDAihXCMKLG7Y26VWgGWLgV24cOWmj5+TUlyfApI1IUVEMNq5f8ZYZuf3Rz67r430d0981AeK9apehbOsdb9Vr+UZxGy9Mxy2xxbvoAgn/jNtA/oIB0+k420mibNgREwq5o5vvp++2xSVH6OFX1PeoaWhPEtGu3ie97hWO1KH6dsGQLMRhnaGimmWQww1qx1LPl6Uk89EQYxtrSk7MHYizInZulCg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:37:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:37:38 +0000
Date: Thu, 2 Jul 2026 14:37:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] RDMA/siw: publish QP after initialization
Message-ID: <20260702173736.GA1517422@nvidia.com>
References: <20260630060040.966461-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630060040.966461-1-ruoyuw560@gmail.com>
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a866f1-5418-4208-f00a-08ded8609bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nIsIfB8btfx0SnBNJK0A0VlcgY9/L7Tk1flYCQ4qx/s/DFl/+oSkFQ9je1Hv3WkuJDWkOvyPXTxl62ZXL6hBJ8RPnniLdQXZU6RTIHAGRkeeegaya4758xONhnZbFYEmNkpDnCy0cg5Hm+NbfChtgrzVFpw+wx0fU5IgxOze56fOATP5TrMuXgHDBX0IqAMIXu8h25PkK5cUqAzIX7xIkRt0Kdeq7KgRVEEKhUSi+bhFRNpyUWIkNXyt6g0OqYnM2Mar0WsvVKSXnquXsdCn8ZkSqsSmh0Hbh0u9vyWszT3UsxsOov4g82LAwdsD+YnbiivOy6cPNKQAunAukeLNc/I5WUrabBZpJYWTz1B6sxKFNrNoh3YvApoWeE+faN/bvZQGz2uHHMQrp4pFSc29fXwfGKg7PDdCM1Ns+Ayz/CGhKHnsfTI8NAxZbYWeXrazLMN1nCfEDybP/4yqa1Z7ayWjt1cpHhhbaJ01Z9Re8FN1EietT8vCUfJUi4ncZtRBlbI5wvms3NTj8qGkswQaSLenMKRCRMiSMagano0RT/+rOVO8KYwcYXzInqKFYDuEBTn9eiT2B2zfMT+qcMDDoZ835X3u46AEC72pUSRg18ORmuvbjOzSWKk/sc+X+L4D6POkho8EDd/PvZ+B/sv62QQsIFcgn5Qjq1XhvAz3Wm4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHJ8URRMOadO2y6UZj9l3ciDnCjia367IV+aAbze3IBRWYOzL0XAh7VawGPD?=
 =?us-ascii?Q?v6edonGbmHumK7F5LpHln6WPVd+hHT7O2EVWlXj+Y3ehYIzdNKGu5fZRCsC7?=
 =?us-ascii?Q?XhhCwTdfmLp1eRmvW/ZI81KrkYxszYMycvAD+ZmzzDf/wdKZm3NSQuVyaJg0?=
 =?us-ascii?Q?jJ49M1AGXt0FctMFdWfT3GkUgsb6D4TI5DH6Z7okleouLU6jhrmkfUatuQiO?=
 =?us-ascii?Q?rVUBvLltMAPhqr6lysGTafHuhCRblpqi4InSGVWs03epBfV66ikOvD6aO01h?=
 =?us-ascii?Q?hzsO3nXW48OSSxvqH+BOqIdv3ytsjbdtNMvf9dlIzqbPrsUXxvULId/44D02?=
 =?us-ascii?Q?lMuRGnzCAh2RKBXL8tfcUgnW27wdH2YSXiBpjvWvEEZjBbBuORm0aKOMakaY?=
 =?us-ascii?Q?dh5rMCtixakrY+bz3r3K1fAJ//hVreElp+CHoTHwJCknp8KdQUZ1os11If95?=
 =?us-ascii?Q?vYYrXrz7ufMDMisbNiRGuLGiDsfqUOyJYNx/q/dB8gJQu2nEOpKaH2cWWB2/?=
 =?us-ascii?Q?cbvCKckpu5TDLxtkgJlHEgjlOqg3G4Cd221uyKtjcMjh2ZTIOo9OYTmIatLZ?=
 =?us-ascii?Q?6Mpt1YDDgAq6YMsjdlesys4I3r44I9oiPbcpnf1ts8uXRes+SVoU8NUARnZd?=
 =?us-ascii?Q?xGNZ/KiQxeeNCjgJI+RPp8SIpyEeWfk6+td+Y1br3EfTzaItDV4Hj9PHruTx?=
 =?us-ascii?Q?kHDJ/JmGKr4+oGHIgjjvpWRpCLAMLSOyqgSZ3dZFfX+8PHZzRrCU6c038Z2J?=
 =?us-ascii?Q?tbvMdQfBzr03bGGqWV4PUtZSURT+w2Z9xDyVbiNbF9Ble5av/GOI3wnoPrfi?=
 =?us-ascii?Q?PT0gp0urPcKvRkpfE61k3H8wArT8113Q4I+1Xz4inKmMoiDQZAJntumW7e2W?=
 =?us-ascii?Q?nEpYhw+ep62B25srsy/ZQ6s6ifbncB4+vDnMP+e1Fayrl0xiyCjw4ecscnpp?=
 =?us-ascii?Q?B01XuxfpGRdSkol+qu9zA9d6wj4/W/4evuSH9RaOoZhYCxZBd0JTJG3NOjdm?=
 =?us-ascii?Q?cYMUNbBr+NKWrfMkOGizRptkHpjtMqYxnq2cIJAX75DgElD8OQ9A3Ze3ZtRd?=
 =?us-ascii?Q?G6xwr1qWKea9yys/84gjaj7ZMpvpEX/WXc6P3PGqU5jOEIhoBfhL6aGRp1jk?=
 =?us-ascii?Q?QCLEB4dlkJT4jOzEe3FlbRrW0J8P3H6i1IFmTmfiJMzhPOjghc4OXqP1sd1i?=
 =?us-ascii?Q?aio2wxkB/iWmz1/G+eu+EJhyH49MLBHD3afV8PIAcGWpCRbDVH76NZb/DUZn?=
 =?us-ascii?Q?nNqG6RQ0+amBMq86FExAtHWhtXavk30p/aK6HqLRzYdoPBpAyRjBfN0PW+Q2?=
 =?us-ascii?Q?Doc00QGHFwfov9d6MHS95pNnttc5gl+al7qbMPLGCd4b6rDozDF280xwszK1?=
 =?us-ascii?Q?H0krIuSziRA2ftEIMchzGcgawUWiAXVvVTtFCgCbWQpLBQJBRLdfB8Xuaqaj?=
 =?us-ascii?Q?EpT4QmrT4NqK1oUZlgGkhXU7p9w342kUvVgsvf6gSkN+TIMvkBMK9VRWbG+J?=
 =?us-ascii?Q?7LO+IpgW7uuuVk03DZ1O6xOwGf6C63iLgr7Qt+SFoZn9aShLz9lJbAasa7yD?=
 =?us-ascii?Q?v14EqPPfCWWsT9nm4ZDwl5vwzF3vvkl78aoZdAo7iNFiQOH7om3RfQTTW8MK?=
 =?us-ascii?Q?e6FDJaG6VO1RjhRttcTsBKjGOpgpOQWk/CBCsqNaBGgr9tYS3EcvhffHiauK?=
 =?us-ascii?Q?urivCkBWeEmD20oxAmSqOr1fUVsC02iNPpkL3Jy0N16/wD8r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a866f1-5418-4208-f00a-08ded8609bfd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:37:38.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDRFvOAUskb2NB36qa7nu8VRon7mkZsMmr8pjw/foxEhmUyPYqXHcn3XuVT0wM3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22725-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:bernard.metzler@linux.dev,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D5166FB8CB

On Tue, Jun 30, 2026 at 02:00:40PM +0800, Ruoyu Wang wrote:
> siw_create_qp() currently calls siw_qp_add() before the queues, CQ
> pointers, state, completion, and device list entry are ready. A QPN
> lookup can therefore reach a QP that is still being constructed.
> 
> Move siw_qp_add() to the end of siw_create_qp(), after QP
> initialization and before adding the QP to the siw device list.
> 
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Suggested-by: Bernard Metzler <bernard.metzler@linux.dev>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> Acked-by: Bernard Metzler <bernard.metzler@linux.dev>
> ---
> Changes in v4:
> - Move `if (udata->outlen < sizeof(uresp))` into the second `if (udata)`
>   clause, right before ib_copy_to_udata() (Bernard Metzler).
> - Move INIT_LIST_HEAD(&qp->devq) to just before spin_lock_irqsave(),
>   close to list_add_tail() where it logically belongs (Bernard Metzler).
> 
> Changes in v3:
> - Move siw_qp_add()/xa_alloc() to the end of siw_create_qp().
> - Drop the QPN reservation helper from v2.
> 
>  drivers/infiniband/sw/siw/siw_verbs.c | 57 ++++++++++++++++----------
>  1 file changed, 35 insertions(+), 22 deletions(-)

Applied to for-rc, thanks

Jason

