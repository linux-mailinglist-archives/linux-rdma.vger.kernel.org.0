Return-Path: <linux-rdma+bounces-2178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1E8B7E3A
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479BC287941
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAAE17B4F7;
	Tue, 30 Apr 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="X2z6C0Sj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2020.outbound.protection.outlook.com [40.92.42.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5B17B505
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497017; cv=fail; b=Gaj5STX73g6UOJwGk/abzWgHD7M5sqn2HsZf9j8dTM7Oj/25AIc6u8AZ/14CHAYYyjN85Zl+cDY7A+YBHIzhN4/L7w/DWCyB7i56pxiZ8NAuw5ztFrplJJ6eU3JeyRZCQDoX2ehvZGFLl7qsohxLDkPwD7Ud8D8w2UDwn8qsStc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497017; c=relaxed/simple;
	bh=xlMVvbpkBgapZF+sdrqv3OscatZcHQXvO6KOy6+8ZNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Argt99W2ar6Eam2WrH625pxoNiWapBOAE7PmVTfvEudlM2WnYSCxt7H1mjo7b+wMsaGHKx7YkL0wRWFpyUgYX0QvzPFLGw3IHkjmjTdauHzVcsxbrUnYogu7n/bxc9dptcgWKuWWFUKK/TEAUM9iSLKRUd60/L/VGl5XBd5JpnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=X2z6C0Sj; arc=fail smtp.client-ip=40.92.42.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5ZZ8HDp9JkvknDsQTA7vqnzPrHNlsUnQqzqqyQapJMlOYzQ66r6fWnyj/ryzKAH9CfCPVIgidJy794Zr6yFOmxdTCWsEyJUrjnMvCmQtKy8GE0IqxQHE/n11sJMvYouF1FHikgQyqP7qKu2r2eCI0O/X0zqXLgXBiUo/Zut6D+/trvLYo4XsyXkj1pUgNndjPVx/i9B8wdcDLzMb8rkwU6WAKJjIvOXBOCKUJWoBoyzejtzsgNpSWFiG9T3h7O/QisFpie8HjUCgMr42vAwfS89vcf754PYP9ls0QzTv4+yYpF5RhPxX9F5WecxT5VLSENpiPcHm07trpCRrbRRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlMVvbpkBgapZF+sdrqv3OscatZcHQXvO6KOy6+8ZNk=;
 b=apYoYbjS/CtvaZBCIhT8cuI8RBm2cAwZhn9YmkiboTfVECWpypJ9KRXcdsZlfHBFfUOofCnHulIMXWCwvhSOnhs+IA/RR+oNL8jiFAphvGOrThv93TIlDDfvZFO+5CmdFjC0In0Vs6s6b/zAh/vJ06amNCT8mC372hAX1Ckr/e/cRnWkeK9l+PDhn/rZt6FbbTI6o7gGxHYQs9EFIIDoztrCdop1uNzlzabP0pQ8FGvjGMHxNRxP15bbX5Cus82/H6OHWaFpOo9753ih7fm2rO30l+hyTHrueiHYrLqbV0VRCoZVdE0dZ0MhTgRUoop0jK0vmMxkkfj559sVRKwhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlMVvbpkBgapZF+sdrqv3OscatZcHQXvO6KOy6+8ZNk=;
 b=X2z6C0Sjlu2BbJNTTtNo/j+dOjYnx2cgCjNT6rM/iaixWzRFO/cfSCr7nBSz72VYO/MZvkNPoR6b//EbdL81WjG12QzkrY+DsvVy9rfBf6ftqjjnzFjl5nIm59O7KKmxnxrhY60NfZzpSIABiopApZD9gFTOWziZ7882cTZ/3PNYQLtex111/oTKnlsqs4nQUNDAXH0G1PxlSP9bv7wS049s0fA1KJJM+aA2myeK+Bv2/Lvbf07Fmg5tIVyaLz6zKgicCQDs+2olxDmO66vgkjt6aYi/PQPD9CqToTOqBEY3xIc3997GN5i6VLdrjS4bnRTsnRUBpfDd5EuM5STY2g==
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:259::10)
 by SN7P221MB1033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 17:10:14 +0000
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::9b48:f062:55f1:5ef8]) by SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::9b48:f062:55f1:5ef8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:10:14 +0000
From: Ewen Chan <alpha754293@hotmail.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: SRIOV virtual functions with Linux "inbox" opensm
Thread-Topic: SRIOV virtual functions with Linux "inbox" opensm
Thread-Index: AQHalJz/zOFXuLYU2EWJz7mH+6NL67GAw3qAgABVS0c=
Date: Tue, 30 Apr 2024 17:10:14 +0000
Message-ID:
 <SA1P221MB10184EEE7BFF9E3B1121F442B51A2@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
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
x-tmn: [diLctQl0OEBwPEJUiIQL5gysg2mC7j35]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P221MB1018:EE_|SN7P221MB1033:EE_
x-ms-office365-filtering-correlation-id: 0efea023-9d5d-4726-b0b6-08dc693866c3
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016|1602099003;
x-microsoft-antispam-message-info:
 A+1uVlA38gFetzbiah8CHjwKIRs2V3dbUR4ZGBCnxGfAZOn2S4t3HW7LOME0nXAh8XSGGu0QVhTkzRLe83BWB1HZCRpKKnoZClNVPOdDqOiAIR5I4aoU/B2UG5sG7arqMWKw1+6Kk+E4dm5w35OohD6AsfBo2eF2H2dNlylj4NzwNNWAXlXABNRBhMYuaHZSxrDVGP4K1QZktxFtVLwjaH2LQBYRP57Ui42+eFZ71c3b+pX1Chx+1t3j4F8epuvplj6Ns/57lRPkPGZSZ7Urp2GWddDut4gFncyj5xDiX2aBI+9lp5lvXpOOecARKVWpTbysmOGJS1MQF3/aZwAVCVNX6Cw05f9K+sxSwCS0JhhDANmyYZPPxdLQgm3pSn+d+ZTIcMrM4QPR/Z7wwvggV+bBi9T4G+f4K5UOP+4OO46wyy4jscEVsh9NPBXSB23LNvC08dhCZIYBGHSFyFxGBmldMQbCJXgvx9aJrB0EIVHRYWmyct65O5KHbbOoruXbZnrKHbOsyMkLo3FqMzAW26qLnBeMeA8SIoETwE8l9w0IjAt1ap4JZCOJhrzSp5hQ8sHQriZ4MSPjvxt00YonVWpl9cGxpfgbwNghCBsTlMy69gLF3hy3NX/aLPcpRZYh9NLPRXxKxNLEjSmxiimdUd0Jds/+KqI0P7eOiiYDeZk2TDdk8gcEbaNQPdOLortcgfv3pmaxVDLvAH6vIh5vyQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7L4qEUpEzuw+Wc4AmrX8YsCdTkMeQwfR4XIVGzz3owQ6OkvzVNGgU4HwYw?=
 =?iso-8859-1?Q?Hztn24kJkw2mzN5xKJ6KKzL5BelyGbK1XJ4dfHRFOVAlQT136k70r6iZQN?=
 =?iso-8859-1?Q?4jShCiYp/hEilMwhkGMBnCxzZLyFGeexKF2QY2lTAWj+su6wPWwNhyvBKf?=
 =?iso-8859-1?Q?rn1XBLSFbvpv0YPgIdeoC1ryI9fSk1Z4RiqNMl3JB4ifLWA7+HYKMzt6Lk?=
 =?iso-8859-1?Q?Atm5W80bq0Y7xRxAu0DlFb3IiZvibNnoWstCn1YZGpCbDAwZIvSKBhOPbi?=
 =?iso-8859-1?Q?OBzu5WfrDqw2DTTYLisySawqqEvwhPbiiBRvKQNR4WBqtK3dMn6gIGyW/K?=
 =?iso-8859-1?Q?9UFxWTS14dhFZ/5CI4U2UUC4eUPPfYM3L+a75HeQH2yAEE/6Vp0SHQDkEs?=
 =?iso-8859-1?Q?qQlIujemuiSi5gbN8t9nNpoqFPHS9LbVKJbg0dp9FS6wiDJlEUA4ef57LI?=
 =?iso-8859-1?Q?rk0GvwRI2LtpPGj1suKF+NPu/hRb/iOhuZw8oxfzwsoiP+0fZVy2VvoSsa?=
 =?iso-8859-1?Q?rPb4djc099T/kYL7ST0QqOMuTrjD42lT0Ee6tnQCJK59hW48gxvwmqIw1V?=
 =?iso-8859-1?Q?f0i0A6qbKtqlvlWLCIqtT3qRJb6cGY6r/K6cLzs+HILR8sMnKGSd6xGJwi?=
 =?iso-8859-1?Q?uQas5oofz6PprUfw0nVfEY00ftJpI0nIBiHAZy2/T1+faNZ7xSWZ8AieM/?=
 =?iso-8859-1?Q?Fddz4ro7MHYkuO63Kauxlg16OEFIBi4xp2YjU62u/kexSsrEyh57TVWuce?=
 =?iso-8859-1?Q?YdEu2Mk2CcgimItU39QYRbtMUw7DjqKhdOnATzUsmW+2UfAKDbS/nP1hRw?=
 =?iso-8859-1?Q?D5QJxU+rEzwZ4vzWedcOXckYatSp95PFBkdFtpt31vTO+AhBA6e/0UGBE9?=
 =?iso-8859-1?Q?sukrS5SuP+2ivNDtn/8i8yqbtLI9GhhdIoT764aELz5kFHgTSySC7CW8VJ?=
 =?iso-8859-1?Q?Ib+RbdKVphAh/2gAjUIGCEwPzktFwKSO7NO1lKZ7N+cq/nxl/nX+Gemeas?=
 =?iso-8859-1?Q?PL98/eJguzlbI9Neimy4twHRKPc15xlYsg8kDmuL96X7GlagfUam/mpnFq?=
 =?iso-8859-1?Q?WYbGCBhK195usu2vN/8oYfnH82BGmN47T0QtJWx6Yg5zyRGMIEr0KPh6rc?=
 =?iso-8859-1?Q?xXdlhTsUNZZ0DtOYR9zo6noZpcUo5nC3ryaB0e+3Hcd02nvW4lxsP+pS+4?=
 =?iso-8859-1?Q?A1QSi21IPtc2yuu0aPeqRijiWeaWd05YCYSXHhwRNFv6LCJJDo6X/ZU7gp?=
 =?iso-8859-1?Q?qp2dsIdtKNUVR9iPKAOvcrIMXVFwRibc8J4Zm1F74=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efea023-9d5d-4726-b0b6-08dc693866c3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 17:10:14.2897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7P221MB1033

Leon:=0A=
=0A=
Your help is greatly appreciated.=0A=
=0A=
Thank you.=0A=
=0A=
=0A=
=0A=
=0A=
From:=A0Leon Romanovsky <leon@kernel.org>=0A=
Sent:=A0April 30, 2024 5:03 AM=0A=
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

