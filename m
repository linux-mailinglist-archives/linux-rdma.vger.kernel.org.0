Return-Path: <linux-rdma+bounces-21841-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tjI4GFD2ImpBfwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21841-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:16:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C5649AC4
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:16:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NDKFaCkF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21841-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21841-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89978307E028
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275863EC2EF;
	Fri,  5 Jun 2026 16:09:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABF3B2FFB
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 16:08:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675744; cv=fail; b=g6X+FfpGERY2F42OHePOOf30typ6BIHd0per2kFg3L3eN1g7zgEn5WUqs0739VgFHBAdC+fmMhtbSvTkAvcB7AFq18ed4xw52RbmGUKxU4iOmqxLop63eFJN1u+ySJ+lVXLguQZSGrZrAEBUniw4eO6/9E22Zo12FmIGp/Cmnj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675744; c=relaxed/simple;
	bh=axnenB6S6C9MaPqzRwhd4Vcq7uCMtPrUb8TayvXiBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FMtBdSFApy8VzoF43IJLroGybB6aSK8ziceK2xJC5Ot6MtTW9nOWNwMtrfhdU7SKAHPoXItphkTxpo4tzWBGQT0k0eQYfkWXQj2h05VD+f4+6STtq2b94V28y3yU20h8MIEmUOW6pNICGHA4+u1aqYLJQYr/E4oeuOaS/ZMpX1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDKFaCkF; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYqzWIQGx50BoohL6WN/TPjgOv8BMs04K5I1PWFLJxM3WvUGtOnTly8OSdInM+ruAlbDnQR9t9ryb3RfWj0KrixId0QldCJxS1eMEEoKkTBQwjudLvvksr/jo967DoGtx9sg7JKMjp8eMBM5ok9FXHe9doESlV1CnChnZ+F7YMCHThRCsmXiMm8DvNNefpJYR7jcCfdSraIwy/XeHaI8nt2ndhNO3TK60WTxgum4+szfqyRi4RdRRb2UU5BILXP2LmC2xHD3UyMDqFJieqrOqFuu7hOyj21SHc91XduZR9Jtg4PK7iwnD0jpH2ue21JhODCjm9O2Pa6rvc/optvVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiimVp75lvNaIazIWFwQmCpM/wTFKdsGNP/WXYKn9Bk=;
 b=wMEcyAxLRp22TP/vc68GlAW8DIUf2ioGsZ9OV9vVwkQNDdHCfvwlhvYNqvY3b5vQkJHXSCweoftcWeoekUUEPAezvO6p5exwbG0wfpDJHdBbhp/kgYNrVCDYkvFVTy+nHG1+6f/yNzbiG2mRp83P9MoXXRKqc+S7fHhkBLrDu+NrY+qdvyqymZmOGH4VDPTBRTy09dUWR04azjUrP+yd6+GZHTkLn83DafAymJ9RF139nyFW+hNTmgD1XfqBdsm4srMd0lBDqfVtz4ENYEqgvu2Jqi5FM+vgMVH0AEBbc5wvM68IlaYZfS64X/9f/ZGj5ttPdayqo5qwOct4AzU76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiimVp75lvNaIazIWFwQmCpM/wTFKdsGNP/WXYKn9Bk=;
 b=NDKFaCkFIrw2gtMue0MdHb9+NdzRMcc7eaEsaxxvCR10kFrUahayD0DkD644Zfk/dLLmjbMhoUQ09SaCkzmXJaPeBWMjWqGzPBBcObonH+GHFmQFKnrXL/eyH4I5JlJUEYhrWDpWiBEl24DorDFl6rLRVwNypdIoo2EGr+qlKCI+oeNP5x3XZJZMQc1JNOh0KQNW9kw5hZda+ZBPRrf3GlpTA84Fgz2sJ76AW0uRgyRBRCbXh282GpxNTAi5Zy7FqMVGGWfZxFJ0VAvlAqaGKx0TKjieQ90KQeMIJOJDNpMgZH8GD/X5Lal5l7DWuZOA/VEoJ19zEnlFr/udITog9Q==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:08:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:08:55 +0000
Date: Fri, 5 Jun 2026 13:08:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xvier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Update create_qp to use QP
 buffer umem attrs
Message-ID: <20260605160853.GA2728758@nvidia.com>
References: <20260602145618.21643-1-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602145618.21643-1-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e4d685-e8e8-40f2-f85b-08dec31cbdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/KksnVOPhCWeRYzY/Tdu1dqqCyLvjE/BC6wA9OjTuIIUwqqDalmg4Q5Ag5V4A4UiJkvDcEZWUoK36O59olL6jUtm/I4YAwmQsjkz4NsR5Q0ZSgcpMRYSQAcfoGb0/yalyAxBQD0evxOhRn22aqpInr1O0q++VdtooUobwGnEfUVnXeMpdbbcrXirLaI9UOdU+kEWfOVHgpkKSz1b0/LYMDQlyx1LDI5ewKTmC0+SXBjAh/rHu1KeYJBzBgGGikHmiA4O+j3MMuJ/Kxt78Tf0wTrn02OTlk3dK9tD72MR60V14gYaMFrgI+PAcFyi49VAtbb5tJrZwTTB/jJJ5tN9lViN7n0L007D5WoKWLxrbo0Dzi7mt3Vlwf4SVSwLG6AIx7yWXK/Pt36f5m2MmeGGxxRlrkhAWCmdxj9vllrCzDA+LYzfqwM81he3aTMTNXCvHd7hhRCXvsXZfGPirhW0R4KSsXVbmWQYycH8oNNuId9N80bbM4WUog1R/lSb1mepEoy+o1gsfDKhy/axRnDVzIACG310EHx/HvqDddyn66XVSf8hqr4UxLFOYw/qf/YxPNnP6ugKaf7yUPySolvn8j7uhuD5tf+jHSXPht+wXCAEEUfd4KMCApQGWZW69JDfpF3FwBQny87h7puQ6uiqg93lD3U0r8jwp4O4GAgViqyCR+VCoFuGpDUW5dV61rCh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tz44xITsQNXUVI9RYjechvzwTd2ZnnXszj62JIildwC+bSsewVTvQcp9DNH/?=
 =?us-ascii?Q?0d6uy742zi88zSQGUmWWKtyc51/EvX9C9urDN1ZF+auE41z3tWn4yQXzBCkq?=
 =?us-ascii?Q?PHDjjuCpmoZiRwI6r3zItpspQ37QIFrOYYaCRGvHaTQ1qsjOOFZjUgp1n8ga?=
 =?us-ascii?Q?s42BJIDZd84Z1IIMqH0JrKB8Wd4L0B03MqtUMt1hm8Uemzv8sPXiwPO+ld5F?=
 =?us-ascii?Q?jJPRlQaNNYLgaj8As1AJO4esRSrif0qfRrYyMDZx+zoiSoXOdfi6rET3vybU?=
 =?us-ascii?Q?+I7Jt/t0fikgAsvUtgJEBBAWHo6o0wrkgEuReDU3hOihUfu2wb8LE1bjP9ha?=
 =?us-ascii?Q?ZOWT9wCofm/mK0msBVvvXI371QzTtAED1C03/Qa6HvQR5DpzRsSyaJWnM6sI?=
 =?us-ascii?Q?7eAw3pu2OGTW7uOvTCJ4PaMCOEZWWCD2f9eLohihOEIeHA6RhPof6DbqtTDW?=
 =?us-ascii?Q?t8dBaE3W1ZatLnKtwPvn95T5pq29ETX5a051l+y8SDrHuXqMC7gDizF7VLWg?=
 =?us-ascii?Q?8AXOJEM3imyO/ZykKpSZpkSdCPRG+q/ywOQcdn73EAvpBaq1l7FxVU9q3jNj?=
 =?us-ascii?Q?8GRHvr2xq3iAva62gUlr1pJyrIV1mRA2gC7sYlnvHTjbnan3GGujY6aCpWW1?=
 =?us-ascii?Q?/rDuA5YtOvAve+EM67KWdHqsxkSPNraDeYyk5F2Kr2ks+xipgxN9/z8hs1+D?=
 =?us-ascii?Q?xoqaHJSswYvgrj01xHECvcnfp9LE6ddKxvESVZXdJEUuofEusZQ92E+VVogQ?=
 =?us-ascii?Q?zhUXet9/1KcotZ1+xCm1MUAdATtJApBEtYo+2kh/DEbns5X0rH3LvrkMaGXW?=
 =?us-ascii?Q?uaCWDd2Yi11TXP14zS70HL2EFjpaA/vWj5nAerIpLBL7IDisWNH5EypUqFGt?=
 =?us-ascii?Q?QfLDy2eitjgzGcVZbssKrcb7TDHpfCGRnTa1OlLvj68fFWK/MmKoLTWEIXvq?=
 =?us-ascii?Q?37hD04e0yRMIDwGB8Kdg/oytvxX+8/b7aSGR8i6kxbGaEFhb0WE05DmgxuSm?=
 =?us-ascii?Q?l26VpYxegFLVECG3/9UhIIkZfEObtNsyb0xvl87GeCe+7PdorhR2DcvBJyz1?=
 =?us-ascii?Q?zIKGgidlQNkT/bRx8kQMnHDATHggd3Ncl6nATMF4y5tjNyY1EeVoDZZknHG3?=
 =?us-ascii?Q?U2UiJnSBbAo0ClwUmCH1yh56f2QkyssucjEuvZ3N3R91S/2iUqxUlPDV6m74?=
 =?us-ascii?Q?h3GgO1ckDVxtotgcK0CItR61tuDf2APukkM/fzR3pGnsRiczEVMn5TnB35IH?=
 =?us-ascii?Q?8qQbICd21kF3Ywu2AUR1/Tnc9ZrF3SEoWk118m54YthaD6v5s1zk0hI3ZYKm?=
 =?us-ascii?Q?Ad22CDyt+9xtU623G0j/WF9/l3d2zqG4eZywQ3rPGykQJpwoFMEIiZN2c3db?=
 =?us-ascii?Q?ka3/yivkyxN4Re2XaCatSuFh8/bHMlU14eCH8C/3RPDZVt5IiB5yzW4RPFni?=
 =?us-ascii?Q?UdoSTPkh1dqniJJpRxOpZmOty1zrge04O9kngSJnxpaBwcKPwb14ZUSvL02J?=
 =?us-ascii?Q?dHHmoRMzNrlHfM4y11MDXwBfmqhlx8OGa4ye3zo55M1oNPWKomBI2jOrkgky?=
 =?us-ascii?Q?Z4fUdjRGql003paZBMEBMJYNyRyvgqGlgUPZQzTZ6dxAd5dP+8Fjkk9wrUcq?=
 =?us-ascii?Q?Zd39RpnN/p9WH+F0DuYcpn+nbVZPmwsfU2DqmGtZCQ22uf0TtTOH6zLLlblN?=
 =?us-ascii?Q?O+tVKRH6a1jSEnkOZLXTerv4KAx6hR7uGeu8HMw7z5P9C0tX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e4d685-e8e8-40f2-f85b-08dec31cbdff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:08:54.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApbAULUb/QrW6G+ijzmbld7tBQpFc7VxciT5waaN1woUQ7kTygQBj/dk7oneb75K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21841-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sriharsha.basavapatna@broadcom.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:selvin.xvier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A49C5649AC4

On Tue, Jun 02, 2026 at 08:26:18PM +0530, Sriharsha Basavapatna wrote:
> Use ib_umem_get_attr_or_va() helper to pin QP buffer umems.
> Pass attribute ids SQ_BUF_UMEM and RQ_BUF_UMEM for respective
> buffers.
> 
> Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Applied, but please read the sashiko report and send a patch fixing
all the maths overflows in this driver for the uapi. Any maths from a
udata should be done with checked arithmetic.

Jason

