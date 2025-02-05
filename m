Return-Path: <linux-rdma+bounces-7472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05409A299C5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 20:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9295E3A8E3E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C91FFC5D;
	Wed,  5 Feb 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OQEBpIOz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021116.outbound.protection.outlook.com [52.101.57.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E91FFC6C;
	Wed,  5 Feb 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782522; cv=fail; b=XoXTeZnxJgMCcwusy5WqkO1PYE++BQJq9ZRxcXAdc2SJLoWHsXU9EKqsp57uhWcRM7xPYGr/lm6iUPqYMZw0FSkwaYeqXkZ/K1fQSEoMLV1w0A0Bo1qqYRFb8Bah1jeMw9L4HdGM0HwT70tWUB+L/vbUvETbwC8mIl4pjCAwIIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782522; c=relaxed/simple;
	bh=ECaSqxPNyqdxQwbasAKhlU1XbhImB5M+3dfRCX9eSOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jL7HLY2xCJSGnNRxGtKhCYOe1GzCmACRRE/9laFsKskjYVpMwqG1WXptSZJdjJKljJofyp8JE85PphFWRTqsUXbXmlC5QFOWff8PQlKpsBg4zGthEnKhaAhL+FPCjnc6bfKYupahbnHB08xbJ/pDHsGLNz5ac1rifBZALwoeQ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OQEBpIOz; arc=fail smtp.client-ip=52.101.57.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0cL+kWbjRB9AoAKEOuc1unrB/SsAcykkReq2f6cjZpez6akX1Cr83G1kIGNK0PMpXcIAdS/D1X5DB1Yq0Hde79QGq8sovJsmIrFALBz3EEGSu1PAGXfbUkLa7XMCY1eB6BMVP8Q/sQLH+RmMxQlkWtl1AA6r0PGLGkRVQr4eDBLL6jreXy9LJ5vNT/ZPxmJ29jdGdvm/nQq0NqQuy004X28z2Y0DJYDXlRCTz0bAGudusCtFhIhivsoFzq2w9VIGNukeL6BgzEDsGcS/OEGdG9Vv5SQMLxaRc8b2fMekbnaklVSWXzyWvGre8QSEiEv8ezjLjVCyVcBsQp7Eq4grQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29AIi5U8OLr6D/Vk1GOQzEfLFoko+9J2T8f4w0btFv0=;
 b=QZsKvJPPrbyZ1yBWnt052bM36M24gR2ud3z2zvNEf1mwrFHuni2laCAJwNjAaXp2YdHZ9l0aR+3/VRVKfgoOFT+Whw7+f7eTqFsPaK5e35uoBOHYzgQyLGc9P8+l44FxhYQQCPOUFCEH3eKET+lPPKUL4aenGM1Jpyk9Mb1idR1CXqQGsJJMoYbKWvC2H8tJAEURKYcsBAj4GSo3/Awd3X4oNsHjbBThSMSTh14N6zBsA0/UBpdMrkzGmC8tkd2ldC44ebYBncg6w1SxWpi7aBuB67xpLYjYc5YbOSyL4cCMD/k16p9zmDH+y5sd922KHGk2lFfo7H5mKe1I7LhwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29AIi5U8OLr6D/Vk1GOQzEfLFoko+9J2T8f4w0btFv0=;
 b=OQEBpIOzicdOGbJNe2YulTvsgIIIfTTauPv9+74RgrQRtT1fESsZu4EOj9apV3JyjHBTWVMtfs+5gPNPSk5NIwhpyr+E0BU0Ylbe6d+9N6qNbjNYCDkzHuzlmtSIHuLDr/LqRNB8DR9G7UNc8FV+3uZaSN/4oemH1KV6cuysEOQ=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB2036.namprd21.prod.outlook.com (2603:10b6:806:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Wed, 5 Feb
 2025 19:08:36 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%3]) with mapi id 15.20.8445.005; Wed, 5 Feb 2025
 19:08:36 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Add port statistics support
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Add port statistics support
Thread-Index: AQHbd7k7fbVS8T8Fz0quZqv6Dd5RqrM5EykQ
Date: Wed, 5 Feb 2025 19:08:36 +0000
Message-ID:
 <SA6PR21MB423192250850A77A47E8BCBACEF72@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1738751527-15517-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1738751527-15517-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=341f0e66-6a92-4653-b0b4-c3cb20a83709;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-05T19:08:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB2036:EE_
x-ms-office365-filtering-correlation-id: bf28ff1a-5f46-45e0-635c-08dd46187e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oYVK9QrivxIkte47t6cRQ6ySZLpsFzZjxTHWcjCW8oAinNhrMPkwLwKl5zD3?=
 =?us-ascii?Q?Ac1EZ/zVkWyF6dPUYU6RG+4RERuMdE1qI4zE0lrPzu0dRFqKDW8nNXghBpf+?=
 =?us-ascii?Q?/NPPiG/9/Q+dLg7KHmdhSColn4NFWOqEDNGguoXBZot/cTH6iMETaxcHQbB7?=
 =?us-ascii?Q?qJVrMGh9UsFF4gKSWeVS7GCI8uWivbsvhSPUYCI6Wb5mT+E5K6rXA+oDwKoR?=
 =?us-ascii?Q?R387r113sp4lYGr0cwhAJQrBExOVz0igAOPSB76WcOGTwZjkxF4pCqP7w1h2?=
 =?us-ascii?Q?znuopwWtgAobRpEZ359P0HR/st9Si0Aqr1/1iKSyYvgAMNvXZyQse61iOkGM?=
 =?us-ascii?Q?fq1tMHbJWQ61ggXmdp+IZOjrajFmK8iYmFkiGiIL7um4OFwkCO+G/i4MGuB1?=
 =?us-ascii?Q?JfX+VIAPayupvaGs2P8rC8UJpp3Huh7L4+/dWzGNnbiqnuLGrcPxoIkPvArF?=
 =?us-ascii?Q?A9zkK1H+zmbaNA5JpYYU/x1p+bY5F13oaSPLOuv2mkFY5X4+PW2QLoX3CUvg?=
 =?us-ascii?Q?MDVF02NFeZTAaABB1JTtaVdPkuywIHY2U8h0GtxsjtscbzyGp3To9WfLLFhl?=
 =?us-ascii?Q?NJVrk/7HWOha6B+Lo48C2aU3o9KJaGHFAy+XePjyJUdVBtmVRJ+jRhKmhQRa?=
 =?us-ascii?Q?Y91r1klCKj31ysM7DnGfmWeHb9g0Q++EX9WeX04bCcKqoTU3S6PFs6YYbQdb?=
 =?us-ascii?Q?jTtTArSDZ4GMK8vNNLUhF5vcpDRkC7GbTPIqi+ShT4bBVRlEi1f39YAdZqoA?=
 =?us-ascii?Q?89eUARBhTbxIxgQqnjtrC9+L8p1rADDrwEZjQN9Hk/+eUjDVa3amBvM6vUN3?=
 =?us-ascii?Q?t8WYH55UXu1z+Oa/HE5Oo8ygkZ00cM68jCmNO7bA5Mdze/KE+eB/dhfonjUe?=
 =?us-ascii?Q?Q8e5TAvIic135Dgp6ZOKvxLBuIjZW1Gsi4A2VtHGpYuXGfHKRJZ0hDAniwiq?=
 =?us-ascii?Q?UYx/LdDyPzjNnZeAuzV3ILhE3/KD0r28DtKrJXXJuNMZ/5qLRQjPJ6iP7Naw?=
 =?us-ascii?Q?yM/qxWuyT40fxPLfMIAatP7RHgKY29XepR5PXWRxhk4mEJZRQfrawgaliXfH?=
 =?us-ascii?Q?Fq9yGvJqYcDVMLkRNFubHnc03mXGzKFztSWf7pF5DDpSZLsb4s3VlOTUOtg1?=
 =?us-ascii?Q?SpglJzt5hR3uaYd6rBYWwg7YP3wIvwnyFOZR3EXgyYKpjjFpeh1DpURONrTw?=
 =?us-ascii?Q?bfYT1qI1u1v5Em5Qv7nb//vAYgRfFS+/qmNZQHRvPpUbBMRVjPQxdnWjzzEM?=
 =?us-ascii?Q?A02UHqRIJ3gtfmtyF3GUNsalyCEOlrbredsY178nhq35v4WgeoHDeg/dT/Qu?=
 =?us-ascii?Q?MEWSYksNkmsPJlC9hDWmcvMEMGgS9HNm5W06bxDcJa9xEIoqH2lnXgdQbFMq?=
 =?us-ascii?Q?ArE5juMP2dKjFjtZL3EMxe0hygi1OlQ9PlFxlN9dKaX7itvk+F2jWjyhj22v?=
 =?us-ascii?Q?HllT83vO8fTfydeQmtlFB4ASmXzNfaxu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gmu31R2zVL46HoFOU86XFK0FaT8lNopgsGTDWIsuyryexEG6Q5B24I2gKyEj?=
 =?us-ascii?Q?5yFCr03oEGXZ39yBKUE2nOteaiytp1btIC1MrefLOe2XbRAkpXGhf87TPwVe?=
 =?us-ascii?Q?m7bbAWH/emgrJ93xc4p6XYp44NITtu4Ch4364T00QP1iC3cR5x6LZ0XaFWef?=
 =?us-ascii?Q?Bg+Sfq0niEGmhFCagnDfqiLkyTNxTZF9B/poqdnt1zlsXFzHHmjigTGBFu0N?=
 =?us-ascii?Q?GkYSeT0a2GfECLOfVSPTPklbdsZPrQOWrmtQRrnaEiY0zYTrzWR/u0/Oe/8q?=
 =?us-ascii?Q?e6/3pKv2GZFUT4DYISI/Hmlh0YY4Ky8yB5qgPmqCImFXygtoPxlcEK3EQEzz?=
 =?us-ascii?Q?WMHpyblnLzj8XraduJ4zt5eY8D7mb1V366ZOw9oEPm1uUlUptA4emu/OeP9l?=
 =?us-ascii?Q?bXlR5cI4XNODKSWqZgn3vj+2qYYQ8zbUgNWE7wCwoJ+fh4tq/QfF71GY01YS?=
 =?us-ascii?Q?SLT3C1SwijRyvcSDRncxSGMFLteeTyO2WJGPMTXaUKxYPljMXB4NVvK1Fvc8?=
 =?us-ascii?Q?USnz8j/zLp+fSZYwINKx10xyknzp0A1+6wp+NhlUlYT5nyp2DbTMFKDsuICV?=
 =?us-ascii?Q?gs88g9BUemFbjpW11mKcwy7egX8tElC3c29MqgoacC8jiH05NaaVNzPcVc5U?=
 =?us-ascii?Q?8jfiUsKd7MDNA4okKQyucjBpGh5ENyv0iQpwaiulafl8tlx8Dz6n7wvn65MV?=
 =?us-ascii?Q?Dop/vft2UjJXtjkFfSycfo9yWhVXAtA64R+lBsnWsw+Ak3L5Fopg3MicdRJb?=
 =?us-ascii?Q?RPGiog96rjFRz2nQiyBhzyukazoxWfiZ81h3yq9OiVRsYQ1QOTesTBBKSvkR?=
 =?us-ascii?Q?uEagG1IOn7AvnEAgilOeP4zeTAl3dCxjxjTcVRmkafwXxuYn2Lx/My+Qi1aW?=
 =?us-ascii?Q?IEjfGjKIjVwinGf6f45Bj9JclXEbWeMcMxuuT7ZMBSwOaFw3y/ZHeN5qGM0Y?=
 =?us-ascii?Q?IgwYLW7KGRaRj6+u1n0oaBnWusj3MDDD93bbail8tzglUqxmA0/uMCz7z2IH?=
 =?us-ascii?Q?qKnxldVcrB1GrFPG7HujgWY/kHQWcQEJpqEEpCerTwQd16iH9nEdieK+TZsr?=
 =?us-ascii?Q?G99KUVAlXh3EuK4yvFhupz5xe5Caf9iZu9uaA6eedhs7AVNbX2BPtPKd2nPe?=
 =?us-ascii?Q?mZX1OrJHZiQsRQP5dAB9o4y50qeXVbQ5gdoEbSAs/LIgLAscQG3kzQNxPHIc?=
 =?us-ascii?Q?xWZuYN+La6lbo4CL/Mp4C1epK9SmyflWN2BZ6jkMR8m3s1iAB8Q61hNmKQ2G?=
 =?us-ascii?Q?KQ3RrFBkVpRQmUgC2Z8K/xtoQGi2UqhdKZobHclJPiapTQrCqJUjwdnBTDin?=
 =?us-ascii?Q?tzDM0Hy8hIULpjJDH7illiVUHGMIZeYD0N1Nqf/S+txDc5m40f0MqCE/a1xB?=
 =?us-ascii?Q?VXGFLDwAGl7ujujNIkjW/Fl+3NFp2a6qwNx5dQTmWA8b/fPYkx7XciQCJM0z?=
 =?us-ascii?Q?U1tQOO0wR8jBiqJcAmODwENGf6aPvJ2hEm/5TPe/cFMI8CNXhr6eaSs3JxHK?=
 =?us-ascii?Q?ZI5RYqKbtq1C/yLTFYh8D36KLF/HgVGvu4bRufTIANlqG+gz8OwncOCb13Wn?=
 =?us-ascii?Q?KTSTYKeeHgaNyadJAuX8Uvn1N4FMrTwgjE6eFm0I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf28ff1a-5f46-45e0-635c-08dd46187e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 19:08:36.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W42rZfhC5nGH0qepRwgcuXkHleB2PqkIQXSHNtQL/yAOeXxqxzLh+8ybsasHn9hk28qc0bLaAT5+AoSQQ8o/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2036

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Add port statistics support
>=20
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
>=20
> Implement alloc_hw_port_stats and get_hw_stats APIs to support querying
> MANA VF port level statistics from rdma stat tool.
>=20
> Example output from rdma stat tool:
>=20
> $rdma statistic show link mana_0/1 -p
> link mana_0/1
>     requester_timeout 45
>     requester_oos_nak 0
>     requester_rnr_nak 0
>     responder_rnr_nak 0
>     responder_oos 0
>     responder_dup_request 0
>     requester_implicit_nak 0
>     requester_readresp_psn_mismatch 0
>     nak_inv_req 0
>     nak_access_error 0
>     nak_opp_error 0
>     nak_inv_read 0
>     responder_local_len_error 0
>     requestor_local_prot_error 0
>     responder_rem_access_error 0
>     responder_local_qp_error 0
>     responder_malformed_wqe 0
>     general_hw_error 6
>     requester_rnr_nak_retries_exceeded 0
>     requester_retries_exceeded 5
>     total_fatal_error 6
>     received_cnps 0
>     num_qps_congested 0
>     rate_inc_events 0
>     num_qps_recovered 0
>     current_rate 100000
>=20
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/Makefile   |   2 +-
>  drivers/infiniband/hw/mana/counters.c | 105 ++++++++++++++++++++++++++
> drivers/infiniband/hw/mana/counters.h |  44 +++++++++++
>  drivers/infiniband/hw/mana/device.c   |   7 ++
>  drivers/infiniband/hw/mana/mana_ib.h  |  61 ++++++++++++---
>  5 files changed, 206 insertions(+), 13 deletions(-)  create mode 100644
> drivers/infiniband/hw/mana/counters.c
>  create mode 100644 drivers/infiniband/hw/mana/counters.h
>=20
> diff --git a/drivers/infiniband/hw/mana/Makefile
> b/drivers/infiniband/hw/mana/Makefile
> index 79426e7..921c05e 100644
> --- a/drivers/infiniband/hw/mana/Makefile
> +++ b/drivers/infiniband/hw/mana/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MANA_INFINIBAND) +=3D mana_ib.o
>=20
> -mana_ib-y :=3D device.o main.o wq.o qp.o cq.o mr.o ah.o wr.o
> +mana_ib-y :=3D device.o main.o wq.o qp.o cq.o mr.o ah.o wr.o counters.o
> diff --git a/drivers/infiniband/hw/mana/counters.c
> b/drivers/infiniband/hw/mana/counters.c
> new file mode 100644
> index 0000000..e533ce2
> --- /dev/null
> +++ b/drivers/infiniband/hw/mana/counters.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Microsoft Corporation. All rights reserved.
> + */
> +
> +#include "counters.h"
> +
> +static const struct rdma_stat_desc mana_ib_port_stats_desc[] =3D {
> +	[MANA_IB_REQUESTER_TIMEOUT].name =3D "requester_timeout",
> +	[MANA_IB_REQUESTER_OOS_NAK].name =3D "requester_oos_nak",
> +	[MANA_IB_REQUESTER_RNR_NAK].name =3D "requester_rnr_nak",
> +	[MANA_IB_RESPONDER_RNR_NAK].name =3D "responder_rnr_nak",
> +	[MANA_IB_RESPONDER_OOS].name =3D "responder_oos",
> +	[MANA_IB_RESPONDER_DUP_REQUEST].name =3D
> "responder_dup_request",
> +	[MANA_IB_REQUESTER_IMPLICIT_NAK].name =3D
> "requester_implicit_nak",
> +	[MANA_IB_REQUESTER_READRESP_PSN_MISMATCH].name =3D
> "requester_readresp_psn_mismatch",
> +	[MANA_IB_NAK_INV_REQ].name =3D "nak_inv_req",
> +	[MANA_IB_NAK_ACCESS_ERR].name =3D "nak_access_error",
> +	[MANA_IB_NAK_OPP_ERR].name =3D "nak_opp_error",
> +	[MANA_IB_NAK_INV_READ].name =3D "nak_inv_read",
> +	[MANA_IB_RESPONDER_LOCAL_LEN_ERR].name =3D
> "responder_local_len_error",
> +	[MANA_IB_REQUESTOR_LOCAL_PROT_ERR].name =3D
> "requestor_local_prot_error",
> +	[MANA_IB_RESPONDER_REM_ACCESS_ERR].name =3D
> "responder_rem_access_error",
> +	[MANA_IB_RESPONDER_LOCAL_QP_ERR].name =3D
> "responder_local_qp_error",
> +	[MANA_IB_RESPONDER_MALFORMED_WQE].name =3D
> "responder_malformed_wqe",
> +	[MANA_IB_GENERAL_HW_ERR].name =3D "general_hw_error",
> +	[MANA_IB_REQUESTER_RNR_NAK_RETRIES_EXCEEDED].name =3D
> "requester_rnr_nak_retries_exceeded",
> +	[MANA_IB_REQUESTER_RETRIES_EXCEEDED].name =3D
> "requester_retries_exceeded",
> +	[MANA_IB_TOTAL_FATAL_ERR].name =3D "total_fatal_error",
> +	[MANA_IB_RECEIVED_CNPS].name =3D "received_cnps",
> +	[MANA_IB_NUM_QPS_CONGESTED].name =3D "num_qps_congested",
> +	[MANA_IB_RATE_INC_EVENTS].name =3D "rate_inc_events",
> +	[MANA_IB_NUM_QPS_RECOVERED].name =3D "num_qps_recovered",
> +	[MANA_IB_CURRENT_RATE].name =3D "current_rate", };
> +
> +struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibde=
v,
> +						  u32 port_num)
> +{
> +	return rdma_alloc_hw_stats_struct(mana_ib_port_stats_desc,
> +
> ARRAY_SIZE(mana_ib_port_stats_desc),
> +
> RDMA_HW_STATS_DEFAULT_LIFESPAN); }
> +
> +int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats
> *stats,
> +			 u32 port_num, int index)
> +{
> +	struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev,
> +						ib_dev);
> +	struct mana_rnic_query_vf_cntrs_resp resp =3D {};
> +	struct mana_rnic_query_vf_cntrs_req req =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_QUERY_VF_COUNTERS,
> +			     sizeof(req), sizeof(resp));
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
> +	req.adapter =3D mdev->adapter_handle;
> +
> +	err =3D mana_gd_send_request(mdev_to_gc(mdev), sizeof(req), &req,
> +				   sizeof(resp), &resp);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to query vf counters err %d",
> +			  err);
> +		return err;
> +	}
> +
> +	stats->value[MANA_IB_REQUESTER_TIMEOUT] =3D
> resp.requester_timeout;
> +	stats->value[MANA_IB_REQUESTER_OOS_NAK] =3D
> resp.requester_oos_nak;
> +	stats->value[MANA_IB_REQUESTER_RNR_NAK] =3D
> resp.requester_rnr_nak;
> +	stats->value[MANA_IB_RESPONDER_RNR_NAK] =3D
> resp.responder_rnr_nak;
> +	stats->value[MANA_IB_RESPONDER_OOS] =3D resp.responder_oos;
> +	stats->value[MANA_IB_RESPONDER_DUP_REQUEST] =3D
> resp.responder_dup_request;
> +	stats->value[MANA_IB_REQUESTER_IMPLICIT_NAK] =3D
> +					resp.requester_implicit_nak;
> +	stats->value[MANA_IB_REQUESTER_READRESP_PSN_MISMATCH] =3D
> +
> 	resp.requester_readresp_psn_mismatch;
> +	stats->value[MANA_IB_NAK_INV_REQ] =3D resp.nak_inv_req;
> +	stats->value[MANA_IB_NAK_ACCESS_ERR] =3D resp.nak_access_err;
> +	stats->value[MANA_IB_NAK_OPP_ERR] =3D resp.nak_opp_err;
> +	stats->value[MANA_IB_NAK_INV_READ] =3D resp.nak_inv_read;
> +	stats->value[MANA_IB_RESPONDER_LOCAL_LEN_ERR] =3D
> +					resp.responder_local_len_err;
> +	stats->value[MANA_IB_REQUESTOR_LOCAL_PROT_ERR] =3D
> +					resp.requestor_local_prot_err;
> +	stats->value[MANA_IB_RESPONDER_REM_ACCESS_ERR] =3D
> +					resp.responder_rem_access_err;
> +	stats->value[MANA_IB_RESPONDER_LOCAL_QP_ERR] =3D
> +					resp.responder_local_qp_err;
> +	stats->value[MANA_IB_RESPONDER_MALFORMED_WQE] =3D
> +					resp.responder_malformed_wqe;
> +	stats->value[MANA_IB_GENERAL_HW_ERR] =3D resp.general_hw_err;
> +	stats->value[MANA_IB_REQUESTER_RNR_NAK_RETRIES_EXCEEDED] =3D
> +
> 	resp.requester_rnr_nak_retries_exceeded;
> +	stats->value[MANA_IB_REQUESTER_RETRIES_EXCEEDED] =3D
> +					resp.requester_retries_exceeded;
> +	stats->value[MANA_IB_TOTAL_FATAL_ERR] =3D resp.total_fatal_err;
> +
> +	stats->value[MANA_IB_RECEIVED_CNPS] =3D resp.received_cnps;
> +	stats->value[MANA_IB_NUM_QPS_CONGESTED] =3D
> resp.num_qps_congested;
> +	stats->value[MANA_IB_RATE_INC_EVENTS] =3D resp.rate_inc_events;
> +	stats->value[MANA_IB_NUM_QPS_RECOVERED] =3D
> resp.num_qps_recovered;
> +	stats->value[MANA_IB_CURRENT_RATE] =3D resp.current_rate;
> +
> +	return ARRAY_SIZE(mana_ib_port_stats_desc);
> +}
> diff --git a/drivers/infiniband/hw/mana/counters.h
> b/drivers/infiniband/hw/mana/counters.h
> new file mode 100644
> index 0000000..7ff92d2
> --- /dev/null
> +++ b/drivers/infiniband/hw/mana/counters.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 Microsoft Corporation. All rights reserved.
> + */
> +
> +#ifndef _COUNTERS_H_
> +#define _COUNTERS_H_
> +
> +#include "mana_ib.h"
> +
> +enum mana_ib_port_counters {
> +	MANA_IB_REQUESTER_TIMEOUT,
> +	MANA_IB_REQUESTER_OOS_NAK,
> +	MANA_IB_REQUESTER_RNR_NAK,
> +	MANA_IB_RESPONDER_RNR_NAK,
> +	MANA_IB_RESPONDER_OOS,
> +	MANA_IB_RESPONDER_DUP_REQUEST,
> +	MANA_IB_REQUESTER_IMPLICIT_NAK,
> +	MANA_IB_REQUESTER_READRESP_PSN_MISMATCH,
> +	MANA_IB_NAK_INV_REQ,
> +	MANA_IB_NAK_ACCESS_ERR,
> +	MANA_IB_NAK_OPP_ERR,
> +	MANA_IB_NAK_INV_READ,
> +	MANA_IB_RESPONDER_LOCAL_LEN_ERR,
> +	MANA_IB_REQUESTOR_LOCAL_PROT_ERR,
> +	MANA_IB_RESPONDER_REM_ACCESS_ERR,
> +	MANA_IB_RESPONDER_LOCAL_QP_ERR,
> +	MANA_IB_RESPONDER_MALFORMED_WQE,
> +	MANA_IB_GENERAL_HW_ERR,
> +	MANA_IB_REQUESTER_RNR_NAK_RETRIES_EXCEEDED,
> +	MANA_IB_REQUESTER_RETRIES_EXCEEDED,
> +	MANA_IB_TOTAL_FATAL_ERR,
> +	MANA_IB_RECEIVED_CNPS,
> +	MANA_IB_NUM_QPS_CONGESTED,
> +	MANA_IB_RATE_INC_EVENTS,
> +	MANA_IB_NUM_QPS_RECOVERED,
> +	MANA_IB_CURRENT_RATE,
> +};
> +
> +struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibde=
v,
> +						  u32 port_num);
> +int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats
> *stats,
> +			 u32 port_num, int index);
> +#endif /* _COUNTERS_H_ */
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 97502bc..fd8efc9 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -59,6 +59,11 @@ static const struct ib_device_ops mana_ib_dev_ops =3D =
{
>  			   ib_ind_table),
>  };
>=20
> +static const struct ib_device_ops mana_ib_stats_ops =3D {
> +	.alloc_hw_port_stats =3D mana_ib_alloc_hw_port_stats,
> +	.get_hw_stats =3D mana_ib_get_hw_stats,
> +};
> +
>  static int mana_ib_probe(struct auxiliary_device *adev,
>  			 const struct auxiliary_device_id *id)  { @@ -124,6
> +129,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  		goto deregister_device;
>  	}
>=20
> +	ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
> +
>  	ret =3D mana_ib_create_eqs(dev);
>  	if (ret) {
>  		ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret); diff
> --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index cd771af..4660dab 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -15,6 +15,7 @@
>=20
>  #include <net/mana/mana.h>
>  #include "shadow_queue.h"
> +#include "counters.h"
>=20
>  #define PAGE_SZ_BM                                                      =
       \
>  	(SZ_4K | SZ_8K | SZ_16K | SZ_32K | SZ_64K | SZ_128K | SZ_256K |        =
\
> @@ -192,18 +193,19 @@ struct mana_ib_rwq_ind_table {  };
>=20
>  enum mana_ib_command_code {
> -	MANA_IB_GET_ADAPTER_CAP =3D 0x30001,
> -	MANA_IB_CREATE_ADAPTER  =3D 0x30002,
> -	MANA_IB_DESTROY_ADAPTER =3D 0x30003,
> -	MANA_IB_CONFIG_IP_ADDR	=3D 0x30004,
> -	MANA_IB_CONFIG_MAC_ADDR	=3D 0x30005,
> -	MANA_IB_CREATE_UD_QP	=3D 0x30006,
> -	MANA_IB_DESTROY_UD_QP	=3D 0x30007,
> -	MANA_IB_CREATE_CQ       =3D 0x30008,
> -	MANA_IB_DESTROY_CQ      =3D 0x30009,
> -	MANA_IB_CREATE_RC_QP    =3D 0x3000a,
> -	MANA_IB_DESTROY_RC_QP   =3D 0x3000b,
> -	MANA_IB_SET_QP_STATE	=3D 0x3000d,
> +	MANA_IB_GET_ADAPTER_CAP		=3D 0x30001,
> +	MANA_IB_CREATE_ADAPTER		=3D 0x30002,
> +	MANA_IB_DESTROY_ADAPTER		=3D 0x30003,
> +	MANA_IB_CONFIG_IP_ADDR		=3D 0x30004,
> +	MANA_IB_CONFIG_MAC_ADDR		=3D 0x30005,
> +	MANA_IB_CREATE_UD_QP		=3D 0x30006,
> +	MANA_IB_DESTROY_UD_QP		=3D 0x30007,
> +	MANA_IB_CREATE_CQ		=3D 0x30008,
> +	MANA_IB_DESTROY_CQ		=3D 0x30009,
> +	MANA_IB_CREATE_RC_QP		=3D 0x3000a,
> +	MANA_IB_DESTROY_RC_QP		=3D 0x3000b,
> +	MANA_IB_SET_QP_STATE		=3D 0x3000d,
> +	MANA_IB_QUERY_VF_COUNTERS	=3D 0x30022,
>  };
>=20
>  struct mana_ib_query_adapter_caps_req { @@ -466,6 +468,41 @@ struct
> mana_rdma_cqe {
>  	};
>  }; /* HW DATA */
>=20
> +struct mana_rnic_query_vf_cntrs_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t adapter;
> +}; /* HW Data */
> +
> +struct mana_rnic_query_vf_cntrs_resp {
> +	struct gdma_resp_hdr hdr;
> +	u64 requester_timeout;
> +	u64 requester_oos_nak;
> +	u64 requester_rnr_nak;
> +	u64 responder_rnr_nak;
> +	u64 responder_oos;
> +	u64 responder_dup_request;
> +	u64 requester_implicit_nak;
> +	u64 requester_readresp_psn_mismatch;
> +	u64 nak_inv_req;
> +	u64 nak_access_err;
> +	u64 nak_opp_err;
> +	u64 nak_inv_read;
> +	u64 responder_local_len_err;
> +	u64 requestor_local_prot_err;
> +	u64 responder_rem_access_err;
> +	u64 responder_local_qp_err;
> +	u64 responder_malformed_wqe;
> +	u64 general_hw_err;
> +	u64 requester_rnr_nak_retries_exceeded;
> +	u64 requester_retries_exceeded;
> +	u64 total_fatal_err;
> +	u64 received_cnps;
> +	u64 num_qps_congested;
> +	u64 rate_inc_events;
> +	u64 num_qps_recovered;
> +	u64 current_rate;
> +}; /* HW Data */
> +
>  static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev) =
 {
>  	return mdev->gdma_dev->gdma_context;
> --
> 2.43.0


