Return-Path: <linux-rdma+bounces-21863-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TsuQH84LI2pMhAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21863-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:47:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3E764A4D6
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Ul5gdWCY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21863-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21863-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0023019138
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD9539734B;
	Fri,  5 Jun 2026 17:47:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B437756F;
	Fri,  5 Jun 2026 17:47:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681638; cv=fail; b=CARMK4lStv4Rcl0DPpA0FpIVbBHqQe/T7eR9WLKs2UjQR+1x+qElBpZWNNyRStguqzlz+YjG5J4K41r5VpH9tZzodOX4cZ/bmFIULmJOAFBbJtmb/+8Mg7nqXGBbKwnuh0Z7S4m7NX3eZh8I2enMCUzqPmOwYk24jxDXtyfnrdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681638; c=relaxed/simple;
	bh=Wbh3PkKuwPiqGT5rXriV5hZM4bpwgkfNWXEntxIG58g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YOPY3eazlwiNC8PubBH6dPJ+pto3JTuP3ZM9Jxr1aRFbJ/yo3qWWQIKVSg82Yazx4EbWyKtrullrhOii6QwVoZPEznvciQePqHSFsV/SwRqk12dkOOT1RA3FN+cK0sGXi62WLZvYFtMo0DXeUsJIcu1AZxCytwXXKLldgGmM74Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ul5gdWCY; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb4JNUKSsvA7FvlkQpsTypaaHcv7Fov01zT1xCN5vV3GoDhxmW7TZWkKvqTRQeQX+ndijL2gm6fxc23NSVYZH+QysRdz+19SWgYyG8XNfp2qUoXGUFJON+c0BTRvUEhU8bLcnh19FCOrS4boDVpx3VJog2rb4QmU9krF2n3aUkGW5FJowBe2PzXCrMmZnpvchXZbcdYWySNMlUXjpqGJl08Uddhe3dw9++klxghHRiOv7OWDxxosJ2MU1Alt9mHDsz2shxgX/p0MZqBKTrl++yGN716UFliu6uLu0c9uPqNdj8AACwcYvSgWzw2tybq00PcuRLeqVuqGe3vn3VUZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9TKtxIRaSDflv75+twLJ44ozdd4RC0P8c4bfPXgOkk=;
 b=tWkGCw3d22gcS5SKYMpZ6r3xVYf2VZKP0wG4iWeEsB1H7FbbfOmIcux23zbd9v8qGS3zNOp1NNn+weiFwStJHe61+cNBPXIoHMwTfhq0rC9LDUGWopBNm9Y/4+T/a89beMtoOVvSqABkMf2D4G4O/tbK+Ue8etMEn5i/rfYK4pKXNJKJ+ttdxWiqU1c01dmbwwooMLdfMKn8dtqAmkWPV6ihbrs2qAmMnyxyk5nhSY+Tmo8tgS+3LEgt96M4nS2RfbduqJj+zCAUe1zUJnWhYXatKR8hZT6t4o7PdVZZb8UeiEkowqqceHjmgyNdpjxflpWgwqtzZwOjJSVwC+z/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9TKtxIRaSDflv75+twLJ44ozdd4RC0P8c4bfPXgOkk=;
 b=Ul5gdWCYfQAJ7gUADgqZ2azL3QW0equ7bv4R2MMhqXQWnlHhaR9mAAbFGKlfUiRJ5fMjCAKfx91AFoUFVaokB18HR+YW8onuetSS0If/u/EAGVEAwkwRP188cnTkqSAOt6N/oCvq5SbwbeKsZkwdyaYKVE0gah1CvIC/TUJzqII2E6OxKHHOIpgXX8YnDlFlFN3QE/RN/qBFR01DflB+/0W4u5/7Lzq8JLQlxd9xRkU96Cg7A57uIcwe12aryYy6hDg3iLZ4jF99k+apnXucsBCG0WW/xA9jXEEWk2wuwTDPerKI32KSXHcWJGC/lG9VfT1a3XTj7/qe6KX6sTR+Lg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:47:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:47:12 +0000
Date: Fri, 5 Jun 2026 14:47:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jordan Walters <jaggyaur@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix use-after-free of netdev in
 smc_ib_port_event_work
Message-ID: <20260605174710.GA2790493@nvidia.com>
References: <20260603100919.268055-1-jaggyaur@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603100919.268055-1-jaggyaur@gmail.com>
X-ClientProxiedBy: YT4PR01CA0481.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ba670b-b831-485e-4247-08dec32a791d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ubg++q4t7j8go4teOOsVjnW4dUfUiBHMx5W/nV850U0FHYwyGqEq19HpZRm6DPTh9Na5fAPYYOPGmSfRIG9sTdwcEcCrFteGp28f2j2g/V5uTbkG94ihADJg7DuoKhGbXvl4xd33+cmCkYdoFAZNLjkPmRIa9xzjes3VV7pJQEGxe2uoU/jfT/2+DcMW2N+MPYUPq+XNLZaQkhDQE8G0wvEwOJ2+eUaomCHgZG4fEaiJE4A+zo91niVHJ0DThM0I05whpgLtF+v4Tb0apMoPVDhxUnvet8153tPjP4rX5g22TW8M8mw69g0Kx0qO+Yybs520blUGk9PGZobTjmxgG/gWHucTIHDD2isBileoTlJx/KxLoSG970jtUvzkabB85lMqTprO4IR9QHwihS1Lrt8lfoVzDe/+5Q8FUvo7JyPjJjUrOD14Ko76PWeEVnvwg0IR0cIHWPgPeqFVP5t99ENyd628ew199XN8nFbMODuLEJCIHWkBOBLzyg7g7ZVG7Arp4IpK22qLU+1986poVaLS0gQ285tCkHIyBNdp/Z/7qK/WlGS2qnavrKhU7xt659N580IF7f/i4/SKZXmEw5VfaFXw7Zs3/Y6+F7ZdGOS35uVqHPcLVF05f99yevHd+KrojppHjjCjUunmvVGOlvZAZV6lh5tvr90fpVO7HZ7hLK+xgX+pRGYNAtl0WTfQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/jYP2ho4/On/OIWXUPjrrWVXjg9ckLK333wh5nZUW6NCPxvQnNyCv/izSfVf?=
 =?us-ascii?Q?wJVW8/0zvhodTTiuSvQJlQ9KzhCevfyk+jxdjM5BwXhfEnQZuOuRD4ZgBvBP?=
 =?us-ascii?Q?txTo0ru8zpGa+kF5NyCBLhdamjRPBYCX1LYgYl9Iu0CTTCyEsSF/jsCRLUJ0?=
 =?us-ascii?Q?Mqs90c473U4j2kABFm7mmYY2VFVI498xio4166qo3yQvGbJlen3HoLrrFZcP?=
 =?us-ascii?Q?A+G6bJuJt9HbC7zG4A/NfWO5L1lkbzqC/yM63ViByLIKDMMzB/DH19sA7S+1?=
 =?us-ascii?Q?GZKQszZdX+c5B4kVePabilLIHe9rgQeUYXJwa6XMwNHS1VAm79iChWbGZaw2?=
 =?us-ascii?Q?4gMqphgtd9Pm48PDogaGIbLF76UlbcTHtjwU19hCuFDezI0jrcXK2XS93f2f?=
 =?us-ascii?Q?EPi2iIhnKiMD4iUyTdC9zo8Xw7ZLctbsJOWgY4+HB8VFp5YMhQCNCWWtEXt2?=
 =?us-ascii?Q?bfkogBwogWPg1sl2ER7wPwZAXS86l7rWm2lbWTrd9boOdkMoozOMl/I5qNV/?=
 =?us-ascii?Q?l8q6G3wrofdMrpqU5T0jA+gh8vjzE/NnNhpKl3X9DMal+AbW7LB9TsrT4P3D?=
 =?us-ascii?Q?qJD93XumIB0uhsD4T2rRfvTQo2aUOmwybrSaLmAL0Pjo0mI9KUgGwhG4hiP6?=
 =?us-ascii?Q?OuNpBnAxlRcukPmVFtyvhl7EttzMNzIGvC+Z1imBDRqRWrXrOSuQ2Hl+zMNV?=
 =?us-ascii?Q?Xm0WZW2MZpwOH+FRcx4iVLJQrfLz4stW7Ixq+Sl1f07hB2jOVLJkASBP+13B?=
 =?us-ascii?Q?ZEyq+XmKKEb2kCXtlg0sj0etXNmE+DIHZw96Ii/zb30LNrCpR/4/hePSS+sA?=
 =?us-ascii?Q?oG0G1TLE+QB3MFqkB75XtjR2uHn0t3J9RBIxXI2RRq74GWXJnxLv4Zp0wdSe?=
 =?us-ascii?Q?Pti2p1o4DBColDqp5kfi3szZVKcDGWlRctedfD3OTxSVZPeQ7TbtXlW7dXrg?=
 =?us-ascii?Q?MHfV3K/IdMr+gm64mffh3gEaiCPjeiLftZrNDxtd2UoU5P9z4EGp3SGFKdIq?=
 =?us-ascii?Q?UVtDsTTybvtypbLBe8CH5y3OaYOegu7/dOrWZOdH1eqoD+3aeOnsaxRwqm8s?=
 =?us-ascii?Q?0u5Sj2rB1qtN3mB4JjRydKicMsRQuI+mF1wik95dQ71xI7Go4esv4JNy664z?=
 =?us-ascii?Q?p810BK9aTc0g/CBx0covioWpkgWqi/8raghv8fTpfFq2NC4FZu/kMB/+KzFa?=
 =?us-ascii?Q?lO2KNHfRhSSe2jE8IfOs0hf2o6MMavlaV78IZsAgoaDftDMWC+HJoS7x50Pt?=
 =?us-ascii?Q?dhz2pDjrm/DIdOFaHjDSanuGaruyVkmLiR0CI5IKysqWNaBtyGVkfc+BWLFF?=
 =?us-ascii?Q?fEgVaDdHwXZDucpNRCTRP8q4Y/Sv5W6ADN5L0sJIWWJkNK5AxF0eYYLIn9ew?=
 =?us-ascii?Q?nCTli3jufU4Bxj+A8eL/wc3/F2F3AnSQYbTIBV2aTkRZk0Fub/VhsV3ti1D4?=
 =?us-ascii?Q?3aYKzkQL0yCDXR9Obssh2Nvl/R2LbDfkTSQEsRDMMtaJJmjAqmwX2VCHVSnS?=
 =?us-ascii?Q?ERw0eUxpzfIi6KRkCcNYDUSrC4QIidVvWd3Y140d8wlW5FXP2UTWHkIEBMwH?=
 =?us-ascii?Q?Ck62YXsy/T5gtE3IrZvB2skk6EY/obgwkHIVIBjoVoULoq3e4DDJLBrnrcxq?=
 =?us-ascii?Q?jggiCnjTqFhhVHtox3LGtgQC6/yT6M2dQ5RsKAFvvehTvaMygoh+8f9aVh1b?=
 =?us-ascii?Q?PAN/nBKrGhTfnJA/5OUsvUTDvJJxWbSVs8g8fxXlb54M7lvA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ba670b-b831-485e-4247-08dec32a791d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:47:12.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDbodUo5DjZAGlZ49B6BN5i8Wmpoodby3oGaRPwH4og7RtiXb5lD47Y4/w2+xY7T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21863-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jaggyaur@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF3E764A4D6

On Wed, Jun 03, 2026 at 06:09:19AM -0400, Jordan Walters wrote:
> @@ -663,6 +663,7 @@ void rxe_net_del(struct ib_device *dev)
>  	if (sk)
>  		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
>  
> +	ib_device_set_netdev(dev, NULL, 1);
>  	dev_put(ndev);

None of how rxe is handling the netdev seems to be correct at all.

The affiliated netdev of an IB device cannot be unrefed until the ib
device itself is destroyed, the above is just more racy wrongness even
if it makes the splat go away.

rxe_net_del() needs to be deleted, not patched.

I'm getting very fed up with all this RXE garbage, it has got a lot
worse lately with all these attempts to "improve" it and I don't want
to be looking at this endless stream of bugs reports.

and zhu don't send me any more AI written emails.

Jason

