Return-Path: <linux-rdma+bounces-21631-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ilEHFP0bH2rqgAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21631-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 20:07:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3796630F14
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 20:07:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VlyMhfgR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21631-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21631-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 787FE3055E90
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A61E315D58;
	Tue,  2 Jun 2026 18:01:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42E314B8F
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 18:01:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423315; cv=fail; b=S3J0/DsZNNaUSGtOe/+JfBEqUlvuP2olvWFk6b/UnrQ96nr6thFr6vh6sDPAmGhJ1rLiRC4qfXznlNcH6AmxuzmnVXaTta9WIo6xYsRIuyarDniNN6rixKyBUFe2Vq+nW8vGu+/E1tjQfep9V+Cs64udjRx4PB9aVxIXitAp4Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423315; c=relaxed/simple;
	bh=GCKVqU1yEKp9uLArf7WCGYrMqaj+FoMrf6XD+T94MVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qTOYq+7NV45RhV+ofsyIDdMpAMqUVQ6nZ0GGAvEvipvjivxe6+m1dKIi3GMBTC4YOSIvtgPxCxllwJx5qkjAuo1tHRoum9ADdpxtcO+lSSVw+SLDp/saPfLHMmtltc51FnEUwixyCbaMctP5Bu5VowhCx75cM1GIA7e855rWn3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VlyMhfgR; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAj+c/tb2QU52f+4qcibt2bH6mAjEM30laxxASJ3+tAGjdsST10cRlkR6DL2m4NJzjm4uZJgMM9XhhLRCsiHm+4RPbBzP0//jLNVCqkGSY2S3wiUeswQQs3Szy6VYSA3Bj7/sWeF6rp7xGkNPIfWn4WdxHb/GbBeDDBy3I8VhUr3XRVlR7Y1vyF4beWIEAX5DyYohtpqhKS1A2X4mIiaKlenmyezMg8OgE0+Umiq6whWkf8diiYi318HnGE4GLPVzyh+8fkjqxwNIh752+QqnTbrP8T/xH/f96Unvt/o+8jAnyrJWj8QbJE5hJKgJnmS5ZbNr7VFzn8N5ZO7gmim/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg1tlLiygntmMnooZX7x27JpZWF7pfKBEP1lnyszBV8=;
 b=yHfA2Eknze3lfPtbJEjjk07asZlCTq3Y/uQdu2fZ/uqlO2NNFbpI57J2eqYyZgi308ExYjV5jWm6nb59uarZAU4fnWPLJjFBdBSpsjfbyDEanePJNOJnjVDlFzbVdc0yGItVl5SH2AC2c0T8+dmaVKrLgKEmjM7rpMnbkRlEUNRf4rzEe0pdtU1nDHnNeEajJQxqsl03APjHy5gbnnEgJO0hEy0zMbfmZXeCpxB7M7YCSGfHS6eGUPe24K+7iEP3UIQncYE7z2Y3r1dUMxGz7xv3gYB77AAcUj2dAvqpQADiabFY4N5VYbTBvOJ3RXA7hkgvjaeefsxsubOiz8yF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg1tlLiygntmMnooZX7x27JpZWF7pfKBEP1lnyszBV8=;
 b=VlyMhfgRMYo55WTJRz6IWRugwCHzusdqbJfFzpTZP7HFjGtR4kI2zpSO4RzHAvy0UqllwnzhQ77BcVUxi3y0QMorNswLZQx0lMSpsMq5/+IAHEW1VQD7mHc4AZuSY+h3pt6AcnuqdoCen19ecZQhpLjk/LDy/GR1tFHOI5GBmaDiJiyiCBXRv7sn2/b47me3A+U/+B+oCwZuCNcog4wqaVaSwZsGCHnQc+iUiAZcITAlo7RGeKSgIIot1VCbvs/SuzAj0uMzJFcnQfrQOgNxUDpoWn27fdqPeQXAfNzvcBx2FYVhp/GLeoVvLRb67cUWeUDlm6V125iwGziVFNeW9w==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL4PR12MB9722.namprd12.prod.outlook.com (2603:10b6:208:4ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 18:01:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 18:01:50 +0000
Date: Tue, 2 Jun 2026 15:01:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-rc] RDMA/efa: Validate SQ ring size against max LLQ
 sizey
Message-ID: <20260602180149.GT3195266@nvidia.com>
References: <20260526081536.1203553-1-ynachum@amazon.com>
 <20260602003005.GA648279@nvidia.com>
 <20260602065103.GA18111@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602065103.GA18111@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-ClientProxiedBy: YT4PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL4PR12MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: 717514a6-f81f-4c9f-fe47-08dec0d10579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UJjXhS9/WIRm6QdCtiXXlIwxgl/uI9rfJimHGKsotrpQQD0e3Y3vhHP1ObilWHpxSVMcxXSgjEe8lE796hOTP5QjqcFnJafat1vlpmLqogW6WiRiKwlKrAtkW6HTUlHcbcRLJVKkDhLZ5VaKxW6Bc7PsRpD/Gcrx1JI6XyKLsPDLvVDgKpzq8R5SwR+dNhAWzaHfpvTDRTLJc13xCPKqr4kXhqCP+DC504Xc0CKQQnnR2byIfzzmCHLt0/opNwgDgd6/EjGw4w8t/SKTKFSd0rvpPhzp3BQBGpaVkXLawrvQh6Bs92FWEuHsgW1CFzo9dDygUo3nFzvDyOybGahD0SHG4o1OLmEvw/a83voBS7AGVXDxWKHH+dCFcR1FjsJd4kx89NuDOmcMDFtK2Pym3NNh8irlvky00exITA0g1G/2FVBNJAZ14hFxz4qygnMlT4HQnbrv7TWPa6nMHNrvAW+LL2IVSKEpHV1PdvNrQTaziD8iIh0KVWgORXOOmCrJqbF1We1WKBiecTKu0kdbnvkgn9Uh0FCDA/voj99ybNTfIctXy/s3cnrkqeCE0w3EeLGzWIoyKzTk/b+Jn5auC9O8EBBytTuuPxGw6CQ3aryvdazObBPIveGiaTZdwWyGgR4LHhkj2CMyd96fRN05kRzUYhuB4vCW+gA1MrySVZXZvkJ83FE+k7akdEvwzsIf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFC+1u8vNpks/qn7xzNFqSgLojIkPoGS91AiN4s5V7hFrveKl8II+0F/e0Gh?=
 =?us-ascii?Q?p5SnIhSzZf6mPMX08J1BmJB6xPLCi+veLFhRT3/8Zy20n2ZuEQL0khwI1CZA?=
 =?us-ascii?Q?vZ4lYYlwXE9x6/MKFbDXn5hz+1ZZuTrautVSGX++DdDjGJfDcZ/hj8DO85In?=
 =?us-ascii?Q?Syx1xvZ51TgKwXZU48/VYNtn5U9RewiDS+W7aeOY4jONGOaQHCT4QHnRIUxl?=
 =?us-ascii?Q?h+bihQSD9bZ0kCguiG+udE1vwrLL4M2mfOSGwqhcRk25Wjq/TUZnEGuqLY/d?=
 =?us-ascii?Q?JAp9xuzuyVUz2wMvBu11489+CaOWSNkr07l+jRBzp3DQIYhGYZyIvAjs32mD?=
 =?us-ascii?Q?ioAUBx0ASZfsk4jA8TKyRHy08m6CKkkUwg6aNhzcT16/OmjLNg1Pviu6TPwF?=
 =?us-ascii?Q?bIy96TlzQhQMkn2bHe6Xc4gMREcjkHuuJk3Bu48xK1eWYpdFLNepjSczbxFk?=
 =?us-ascii?Q?03GTwpH27rmxphrPy+iP+4vQg8ZDybZ/fpSW+lCv1OWe3hUDdmB6uER/kciE?=
 =?us-ascii?Q?vs8ktx/V28h7pg8euQkRl/DxcxCkJt1Sc08WxTqRyF0E9sqH2Isx3xfz7aVh?=
 =?us-ascii?Q?2fQcE9ZIrmabhGdRTaOsO93rgFNR3RSJ6VDPLzNetujXNXY1ey1bWHhj8PVR?=
 =?us-ascii?Q?PIb/2KK3dMwd5qqxxET9F1AP5lVYBMhK36FzWmOM2KOTNZGt4UBxDRQB5hVz?=
 =?us-ascii?Q?vxh1bF7E5zcsgsYlfe0nhvIa6EU5skKdFeQtDvKnRwjxCLPh7PPu5m0BYYvx?=
 =?us-ascii?Q?WvLH/2PysYZhxzzCHNZ4hWpcLHKek8swfH6j2y7E7DApsdekC4SHawR1jvHL?=
 =?us-ascii?Q?4xPQDfLa6G4cNakIyaXW4tZ93oP5VreoyeSIVVJoenWESHvVBsgJweJX9kWy?=
 =?us-ascii?Q?x7fi2jsYhw1kPua3aEjrsSXu+s4UppfI8NLgDgyFS48zpkWjCPKZn/Lwu7Hn?=
 =?us-ascii?Q?9YBkyjoNJYsjdq33L8AgB3HpMjz4a2gLeTFB9cCYxNJedAQnpAepb62P8YDU?=
 =?us-ascii?Q?H0kq3D9+KU8EqKz7ae1UWVj9PpN/IwndBtarq7H38tdn8bAoLgReULmg0YNa?=
 =?us-ascii?Q?hIWmmluH5x6sJBvoNYGxwLJbIOSh5ae6l2dhBG0gAbtiCt+8fShAx/lsWomS?=
 =?us-ascii?Q?AHscfYYAx2On2nH9AjbTKI0Z2GBHwHnYDvs/0NL/RVEi5epJTj/RrbVDu9qb?=
 =?us-ascii?Q?tQR5BtIw4GicT3key4FMTtr3ue5WulMxL5pP0s2ngkChbwiA2WX+4WolqSAY?=
 =?us-ascii?Q?5GOz7A75QxVdZIjifBijYlWvaBZB5H0Oka1bqC22pHCZVCAQBTO4iuQFQjg9?=
 =?us-ascii?Q?fpZCN4HkvKd8uI1ATopqs8Q7PKrMbBdPxm2s3ug17O/cnC39F12ijqIbhqFQ?=
 =?us-ascii?Q?EYEolkvfwJoMezaGA19+oJyU6yiPb7PolgSDt1DPvqcQ2FH/sLeXJ7/KLKdW?=
 =?us-ascii?Q?G1iNdHMEVjSNLSMVEvySfwljBXUFD5QJoSi2oNp6edPZgexAQ06tk/+PC2bs?=
 =?us-ascii?Q?pSl09IVCFzHtd0brTx3dbkL99sjAjWAXSCYtdi43uFi7zWORy2HfYX7Tl9mg?=
 =?us-ascii?Q?QLi/nDd/Hh3znnKWj7LWzX54+EkV8wIv5R12zCKtAE1RQ2wxH39Bud9dl37K?=
 =?us-ascii?Q?UWLYB4vVi+S0TzHAIuzknD6h7dlxxNsNT45sxhNxyZcEU1+1t/1NoMIyEagD?=
 =?us-ascii?Q?/ennwadGrKBcqZXWL9KWakq6DZU4xjDobUjos3oHXWmFpr/M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717514a6-f81f-4c9f-fe47-08dec0d10579
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:01:50.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn8GiuanohZnFxi23DUtNZlM6+f0Pwze7uZ3cDfKt+vUrZzTgUXW9/OG4y4eIa9n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9722
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21631-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ynachum@amazon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3796630F14

On Tue, Jun 02, 2026 at 06:51:03AM +0000, Yonatan Nachum wrote:
> On Mon, Jun 01, 2026 at 09:30:05PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 26, 2026 at 08:15:36AM +0000, Yonatan Nachum wrote:
> > > Validate the SQ ring size against the device's max LLQ size. This
> > > ensures that when using 128-byte WQEs, userspace cannot exceed the queue
> > > limits.
> > > 
> > > On create QP, userspace provides the SQ ring size (depth x WQE size)
> > > which is validated against the max LLQ size.
> > > 
> > > Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> > > Reviewed-by: Michael Margolin <mrgolin@amazon.com>
> > > Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> > > ---
> > >  drivers/infiniband/hw/efa/efa_verbs.c | 27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > The Sashiko comments look like they are worth addressing
> > 
> > https://sashiko.dev/#/patchset/20260517175216.614494-1-ynachum%40amazon.com
> > 
> > Jason
> 
> Hi, thanks for the answer.
> That is not the Sashiko link for the patch, its this:
> https://sashiko.dev/#/patchset/20260526081536.1203553-1-ynachum%40amazon.com

Oh boy, it is annoying to get the right one up :\

> I reviewed the comments and none of them is relevant for the patch.

Ok, applied to for-rc

Thanks,
Jason

