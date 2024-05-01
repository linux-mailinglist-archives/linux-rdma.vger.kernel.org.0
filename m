Return-Path: <linux-rdma+bounces-2184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F838B8515
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 06:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B54C1F23600
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 04:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70213BBCC;
	Wed,  1 May 2024 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ez9eg/A3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2051.outbound.protection.outlook.com [40.92.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DF2F875
	for <linux-rdma@vger.kernel.org>; Wed,  1 May 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714538624; cv=fail; b=irq8tT3li0CwCF5jny3NOy9RV4yPf7DuNgTK85rLqHBiHKnXcxiM2xIHxaocX7hvFGapnePvXM429/45HQ9RKsSzkaTAG5ke7E1gYtuqwSEDEw6QQlC56tabys1UBOdawmYLvDLejkxgjXGnDGMT+PWXkFDGelGbpiRvySgT1gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714538624; c=relaxed/simple;
	bh=u12E6sxEwwX7Z2JO+hispliahf7XHq54Ioba97ZIJEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeTaCByOJEtt6XHv8oQ5xQrtgOlf7Ysoj7QLAaCm6xs8L8Kzdy2wWUS+vjpnley5Oo/3fjGVUy0pYPODJZyvBPE8Kqzvl+ZVZ7KtiDXRq3Jrd+oiM1u7fpll5iBytAjyiSD6X1jmui0CQWwUQdczyCC7iJqxCmhfgUsbeffDPKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ez9eg/A3; arc=fail smtp.client-ip=40.92.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhBFrq/66j6e0lHjvaz5kNe3GWnUbB+mMdGGXOc3aeWxh9O/s5gC2X5lnXNULUP3mmuTBz9vRingMIiGoxhAu6rLjXwwTYro0NiOT4R1cSPP/gFHqnJbB11BvKAFGLq0t+cnZvhAx8pmMdLgDnCs3AYC6O9+L2lXBwt0OIOWH4ofFldLXqPX454sLsKb/AJoiOzpyLvFXgJ76cbuB7vBw1KKtQfrEDGnbD9Mup9bk2ThYI4Qb84SVUIu01iBpgwEv203oWTuRaNJoRnksiaoCFNsKjwmKELpIqFZLMvp4uNckhfHeblBfg5tXZbo0ep/O4USmftqvA9a/q41Wf4ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u12E6sxEwwX7Z2JO+hispliahf7XHq54Ioba97ZIJEU=;
 b=Ufm+eA4sNngj8jfPKW/loX4cIWQWYbFYbuq54P3hGvnIP3+ZqwqV35dHdIDhfcG37nXDVXmiWR9ZPdYJbVtt5b/0Bpw29ev+WxwO7Xj9mP/6wiPzHZg6RJqoA3Py1PQx7tPyIZgBZsCjEB+RYHtlxFRZalvBcfLbptL3YeRFuWF3IDvSNl/q6Hi4QHMj5uUpldIehH4TyeqPEFxfE5jUUbS6YI7xByIRd+xXJjnvfOC5jggu9puqxT9fg4HtIM9wPCowKhVv1rGo1cwW8Ovp8Ksh7Y5NSS8dHp4bB22zKF3P49X7mKw7BdLwO8j19PDd7K2oFYAqis7YZ3xsu9ifrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u12E6sxEwwX7Z2JO+hispliahf7XHq54Ioba97ZIJEU=;
 b=ez9eg/A3+fciKhxSW1Mgk6Edw9ZhaEHCx53VxV2b6pb1MiDKu0+xFuIpB/yBAr10YZEcKmPcreTmfPDX4XoylgJrn1/hzmbeGtZjMaBkhm07W5LyPvUTh5gdwqNmgwKV/Zvq565WjgJ4T4epAueo2GI9ldwXbLIfitzchQu+68oTmqaNb/dTOwjUvAFjvXBGZ7S7CkqhS7VzDkwtCPPMbZ15WEQ7JW6CI7OUlBPggFoEDtUSBImq2R3MyGHYdi55NHjK/LSiDA0+sJrrUZ6/zxXskuo75g7jVkvCu5dVAmUe0oGo+dUDBkczAX7gyfMz4K8GzZCiAG96gqGnxTM4+g==
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:259::10)
 by BL3P221MB0403.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:35a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 04:43:40 +0000
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::9b48:f062:55f1:5ef8]) by SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::9b48:f062:55f1:5ef8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 04:43:40 +0000
From: Ewen Chan <alpha754293@hotmail.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: SRIOV virtual functions with Linux "inbox" opensm
Thread-Topic: SRIOV virtual functions with Linux "inbox" opensm
Thread-Index: AQHalJz/zOFXuLYU2EWJz7mH+6NL67GAw3qAgAEXTks=
Date: Wed, 1 May 2024 04:43:39 +0000
Message-ID:
 <SA1P221MB1018617920998E6E4F74931AB5192@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
References:
 <SA1P221MB10184D6002569E274E6630D7B5122@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
 <20240430120303.GB100414@unreal>
In-Reply-To: <20240430120303.GB100414@unreal>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [iZq9iis1uFMGBbAwV3855RK3I32p7wj7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P221MB1018:EE_|BL3P221MB0403:EE_
x-ms-office365-filtering-correlation-id: 2490a6d1-72d2-4032-25c9-08dc699945af
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|1602099003|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 MKsWOaxCMW0dhWREQdvTwiJJQduZXjRUX+g/M/+otqXVi7v3yIWY4BDYZNdZbePP+xv5MSr7Ra4goL6wTCnXcuYKdtfmRM3afIXjbeCN5UTp7jp3vbl4HdrsbPmcii6njwGvIv8a3EAYrWhwtVVGrIdNfgDNugqEtJwnKy784nAnhg/c7c5sBvXZ9m2hYodhbh2zJzSk1PNXNm3Tln2EWsCjWRltGn/XVMNExVz+BQIExvpzDnszFV0v2NZeqgCnnJfizxVvnIqeqfZ76EsM4mrgWMCoC3dXkJMmLJILneqaBo1p8txrO/d/8eVLGQf4MWhtTwyFPtZYU99RUKAA2fATQasVQeF9FxJl8LesVPDNXQo18G/Xb0Jb0JdcNXOYiQJMlNOzo2DbtGLDuTaa6idv6WrFIHe5lVibgCaM2cJgA3w6zbV9JhaWebuYjhPkzAFULVPgu06yGhWjrlI8NLsfO0q82bWpq4K+OPPmQ/KuPRbJcFvSW3uDCPHpj+KMUcM3RoMKIfNlqmKv63R1pT2LKcR00caU7bFFKe4aDTf1hUYAhzpePFHLQqFfjmaGb4WLJcvBFGLhAEIUAfAiSqqwzHihaNx+kdBqwqkDbzc0iBDK/3Min6xWwR3GkVvKdjD3tKW3xIKcoTdQgPj+TlAzfxs/n6fNWsmUynZmPoPIF5muDmJbst/Lh2K1KjKTF62Aev2TKWW7DcLUws0wIw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wK/iD9S/d+39HEWMC15raQIueQyEnC/3xoBdV4/I5ZV9HNkplx14y4VYhp?=
 =?iso-8859-1?Q?zsetOnvo/ShdgZeMH3HYaTBxVl4q5ZXyO5WJxmjpVMio9UWi7rsQPEPktg?=
 =?iso-8859-1?Q?RLPHSiz7VE7TYkdiP0D36yyFavbWoAuYTKG2/67ftt0CMDBdVUq+fmcDe+?=
 =?iso-8859-1?Q?s+Ys/5wWa7qsUP4HFNZrGZd7YldnIUURRluNj57qTx+reYvbUVzoO2f/sz?=
 =?iso-8859-1?Q?UQZZ8YiIN2dwe8OWQc9Xj3CNVuVWBN/AnO/zaHR2CvLDKViIdX3l2+12qA?=
 =?iso-8859-1?Q?ocldpjpcrsfou3fpXbmtmjZ/K6xc4EGUgPWSNmy6YpVJ2lHIXrUQ5HiusK?=
 =?iso-8859-1?Q?GuF/8+R+ZzAJT0FrUn0g7WYTr3JM7iAC3FO0q2nnczTSd7KO7hHSntD9jv?=
 =?iso-8859-1?Q?eSArjVG8PEhRmhbcj9H3JK3ZS4Sw2engqEp8xPx+f7VcRFYy5n6prbgNSF?=
 =?iso-8859-1?Q?V3mP6rwUbQza8wRWapXXqRP6D8M4K/mpwYDxPIvFAu9vAfTHDbBQR8P05F?=
 =?iso-8859-1?Q?RS65ohUcaPlpFPAk5oeII0hKsITYYpSeKjllmWji71ZjX6TJhisrmhlMMr?=
 =?iso-8859-1?Q?tz8rlC48NKExqqLc8irhMRck9atf8m1siarG+kYmP2i4pjbM6EQCfPbGvl?=
 =?iso-8859-1?Q?yDakAFc3zxAuHV8RkBmlMWyu2Aw9ZMG+TfbOMFXPqx+CeBz5QnpaQw7cI1?=
 =?iso-8859-1?Q?3N0gQzG0l26yrFyl5KnTBesj4pfD5m6epeEyyOtHmSH1IHLlGM7EA+Tpmg?=
 =?iso-8859-1?Q?vLoeUXtE1hWICA8mCG55X9q7mUHU8yo5sLXTqhd1VbCrTAe23PNYwOLaju?=
 =?iso-8859-1?Q?YPbhu3NuhNxvKqa0ewH3/FhAdlIT1cCmfjvFniRwZKZ1TF+/whsdlDipVF?=
 =?iso-8859-1?Q?qcOzNHaK0w7nU/XXm2I7sKL0KRhJHcTF3jJzPyHvy9eBq9i+sBCkfOm/u+?=
 =?iso-8859-1?Q?8REZyNRnXeZK3GAbgJfjAeN/7WzD2eA8gkPmwQpTJeVNX4+8WqKuPqqn0N?=
 =?iso-8859-1?Q?F5hpXxWR15Ru8TnrPrMO4m9vL3nUiNWnhbsuOzo6iP/50Kr9qxc8CPUFeB?=
 =?iso-8859-1?Q?siC4xQaDtf5WpQr5Pinlyfjio9kndjdlNz/0tWPRm5cnFB6MMEw2SFv3xt?=
 =?iso-8859-1?Q?XVoZRBoSfkhx1548LlHWlCJmNBZN0hnMjT6S5OxlmvxIVWVYm4xLHG3FZ+?=
 =?iso-8859-1?Q?ADWQ9Gpl4guMwVKA+he6NoWPGolMcVKrC/1NH/s3XdhQ87ppv9asgVU9cz?=
 =?iso-8859-1?Q?zLW2TJ3/rY3VIanTFa/lmEDxOzHQyYQQblO/syVrQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f5d03.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2490a6d1-72d2-4032-25c9-08dc699945af
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 04:43:39.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3P221MB0403

Leon:=0A=
=0A=
I see in the link that you provided that the IB management packages are onl=
y available for Redhat.=0A=
=0A=
Would it be safe to assume that there are no Debian equivalent to these pac=
kages?=0A=
=0A=
Your help is greatly appreciated.=0A=
=0A=
Thank you.=0A=
=0A=
=0A=
=0A=
=0A=
From:=A0Leon Romanovsky <leon@kernel.org>=0A=
Sent:=A0April 30, 2024 8:03 AM=0A=
To:=A0Ewen Chan <alpha754293@hotmail.com>=0A=
Cc:=A0linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>=0A=
Subject:=A0Re: SRIOV virtual functions with Linux "inbox" opensm=0A=
=A0=0A=
On Mon, Apr 22, 2024 at 10:09:15AM +0000, Ewen Chan wrote:=0A=
> To Whom It May Concern:=0A=
>=0A=
> I am using a few Mellanox ConnectX-4 100 Gbps Infiniband NIC that's conne=
cted together via a Mellanox MSB7890 externally managed switch.=0A=
>=0A=
> I have a dual Xeon E5-2697A v4, Proxmox 7.4-17 (Debian 11) server that's =
running opensm, along with two AMD Ryzen 5950X compute nodes, that also hav=
e the ConnectX-4 in them, running Proxmox 7.4-17 as well.=0A=
>=0A=
> I have enabled SR-IOV on all three systems, and all three systems have 8 =
virtual functions for said ConnectX-4.=0A=
>=0A=
> I read in the Nvidia/Mellanox documentation that I would need to add the =
parameter "virt_enabled 2" to /etc/opensm/opensm.conf so that the OpenSM su=
bnet manager will know that virtual functions are enabled, but it would app=
ear that the opensm that ships with Debian 11/linux-rdma, either ignores th=
at option or doesn't know what to do with it.=0A=
>=0A=
> I would prefer NOT to install the MLNX_OFED drivers for Debian (11) if I =
can avoid it.=0A=
>=0A=
> My two questions are how do I get the linux opensm to:=0A=
>=0A=
>=A0=A0=A0=A0 Recognise that I am using virtual functions (so that it would=
 understand that there are multiple traffic streams coming over the wire, v=
ia one physical port)?=0A=
>=0A=
>=A0=A0=A0=A0 Automatically assign the Node GUID and Port GUID so that I do=
n't have to set those manually.=0A=
>=0A=
>=A0=A0=A0=A0 (I've set the Node GUID and Port GUID on the my Ryzen compute=
 node host already, and I can see the Node GUID and Port GUID inside my Cen=
tOS 7.7.1908 VM (which I've updated to use the 5.4.247 kernel), but it is s=
till showing "Port 1, State: Down".)=0A=
>=0A=
>=0A=
> Your help is greatly appreciated.=0A=
=0A=
Linux opensm is not supporting ConnectX4+ SRIOV.=0A=
=0A=
You can install SM RPM from NVIDIA Web to enable ConnectX4 SRIOV.=0A=
https://network.nvidia.com/products/adapter-software/infiniband-management-=
and-monitoring-tools/=0A=
=0A=
Thanks=0A=
=0A=
>=0A=
> Thank you.=0A=
>=

