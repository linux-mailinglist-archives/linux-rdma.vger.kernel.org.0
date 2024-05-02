Return-Path: <linux-rdma+bounces-2217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507B8BA0FC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 21:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DA3281FFA
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8DF179202;
	Thu,  2 May 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="s76laAUp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2023.outbound.protection.outlook.com [40.92.21.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB315FA74
	for <linux-rdma@vger.kernel.org>; Thu,  2 May 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677539; cv=fail; b=r+af7sSV+RueSgzC/QfnjiMGHANKppZkTp8ub0mDDtY4vQsayzCjQGt2AemfaTb1GDTyppUePxQH4sqetTSiGYK8Bx/AHkkMCzZCC8uu+M4aYc7n/3ZB+swE2Yth8dFGk98B8DE+ePke0UXq4hKaQf2RzCbEIn/a0zNj+idEfB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677539; c=relaxed/simple;
	bh=zNR1qTLG/iPsDTFxmqodvaKYpNX1gk7HBP/YDjzgyPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1hrK9XddXzZKfrmoyz+/ODzyFioGYgZgYQMseLSNk/L3JmJptkQ9BXgmBfzTdZGFUrwKtjcaPh2VEdel8KSIKz12jp33i2p27ZDfsdS9F43chPPrWw+X0LUKg7cM4kjObgcskxhrzbLMBkLbxCnG6aIzcXrDq2Fy2oPt9HkfZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=s76laAUp; arc=fail smtp.client-ip=40.92.21.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMReDirDQRozNWTH9QPz8M1Crlmus6t39QiZswI2qKkj3X/jMxNhHo5iMJZP7NoBBeWShv6xPhmBLi9cXXSXkRxQCauN7Ps2vgrumQM8JfWgiJNhfuokoaTSwKxwFDTNsmDaZdEcYi8E5FU6hSAndHj0l60L23BNYkx6RRR4OWzrNXesOuLneYPT1OBbsADH5KCZxtg9oMw7V2os14a6KxoldBUafgPsYieRY8cogauGnV9KNncOVTxldqrsGVTe5+XjiMkZ9ogn1qVF4q2KLTe9y1Jk4wcrt/Q2wV5dDqy2L4iLAJh6KyZ1yGC2GnUzM1utAo5RrXIvQkemFzKwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNR1qTLG/iPsDTFxmqodvaKYpNX1gk7HBP/YDjzgyPA=;
 b=ogkenoeE38Lwtp81d7imTof/i+ZlG/J3uxlNmrXFFbbQYXPF3bq33eQb9RPDczhr+ARgNwATgTUUjTlFX+kIGKiyG6HkmRvDUELIH5H5Fdaj6kleF67YgSTOgecskG8Zap9KXLkqdDPCNZaGX4wY49mcGJ5s0PaDpt1Neu1/Vi9iMLp+RMVHsMAT3OhC1+jFg6GybkgZDeiiLJlxfaJhotXtOF7CiUDDfvrLl/GLG381THaS1TtSqsS10Le1qcLIeEH1Apqpvs6lrEM5X9aYFfGOH2sjMD7inu5v5udvEwJnN1+8E0KoAeU/i+S9qjUzIs9aJdJNTpwsTJwUU159eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNR1qTLG/iPsDTFxmqodvaKYpNX1gk7HBP/YDjzgyPA=;
 b=s76laAUpslyc64DWHl8i00ujxYLXLy+Kv8tl5fcv1o/+TkMFosw1vb+pVO5qYFCIAV59Ccbp79Nblb1uKIboo5+GJtHbWGfpdl/XFVUDfAkEkTgimpBZ5QyoNnBx+EAPcLN3HBdYNT/xO3DSsNG+6dNUbF5IfBp6sF53xjKPm16Ac5KDgMt2qDCEVGJ3NVYKUAkIqjph8RdzaSjRhcZryWBMOEemZdckff3XytVL8kFUMatuva6dP25CSEZVq9EVACYtuhqk2J73g/msx5QsckKXwCXLhM9c8CEoOSQI5hqsP3YUpf437ximFQ+VgqK5DB+c4Vy+1Sd3qnYP0wO3tg==
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:259::10)
 by MN0P221MB1484.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:4cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 19:18:56 +0000
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::9b48:f062:55f1:5ef8]) by SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::9b48:f062:55f1:5ef8%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 19:18:56 +0000
From: Ewen Chan <alpha754293@hotmail.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: SRIOV virtual functions with Linux "inbox" opensm
Thread-Topic: SRIOV virtual functions with Linux "inbox" opensm
Thread-Index: AQHalJz/zOFXuLYU2EWJz7mH+6NL67GAw3qAgAEXTkuAAl7BAIAAJ7ch
Date: Thu, 2 May 2024 19:18:56 +0000
Message-ID:
 <SA1P221MB1018D63E1912C177F9294E72B5182@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
References:
 <SA1P221MB10184D6002569E274E6630D7B5122@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
 <20240430120303.GB100414@unreal>
 <SA1P221MB1018617920998E6E4F74931AB5192@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
 <20240502165422.GK100414@unreal>
In-Reply-To: <20240502165422.GK100414@unreal>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [FRFJ8mgfDC5h9PTdkgVgdQT6CLoJTrWJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P221MB1018:EE_|MN0P221MB1484:EE_
x-ms-office365-filtering-correlation-id: 0d502e48-1c22-40b7-32e9-08dc6adcb631
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016|1602099003;
x-microsoft-antispam-message-info:
 jMw0PuYTnrSwl9gaChvGvjRaPXDubPn48hr+eWDxoME57/SP2zbw70bgWB9Klvl3xN3hgIbqLos4aYMZMa8x+LMxQRAAuKhNrXhxJYTjnZI2ZnMh6D0Vu28cpfMOS46M9KRGvcDdQDKWmV3HqPBn4+LORaHWjlwaY9WTIzhWazKIXQYFEXqHtKsb1Ze0pAfeSThC6Vm+4Zh4BAjnLt6qHJyH3RmJqK/t5ZNYX1Sr7OenvJ7pFFIY0odfrnjpsPqTNgbHxFyrMiTt/WqzTI+vogXk3GRqbZxYk9kT1JKGTF4s1efF/IOM6kMbi7VD/n+UFeDmBQeL2TMLrp1xpbMyJZPhiTZGvPu1fQ/HlEgZ5HZChOCQZbG9MhK38jbmYsrURtQTy4tSZGK0PqctXOgTaathpVcDjAM1tAPzVy3kNjj/7TGfZ82bvGdvcaDTVznOlEcxAV/B7eRZ2M88Ia4bbowFT2/IDC3W/VJyDPIDydFn7i4YwZ7t3e7fs0EtCdjJxyfg5b2E0FL7CYviyRc4p1snqo+M1/lMnyiMOsLCPQen0hR9kh3UqxmIxqIjmx2c2WqqQjiI5VEw5XfPUsGOPNFHzhkNXy1cgr3qa36vuvP5WfNm0JtXjhv22esDNQVNmwY7sZqaSbdBuMWjxtkZPAPASsM3QogEKRBmBQE2CS0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?39wiHxtrxgSHkuyb+9esO/le8QrgUcz5ljrrdU+gf3IdbZZTa4QTdDsQYw?=
 =?iso-8859-1?Q?O+MHBDPDMDXFY2kk30cnrzAkJwAZpAB6TCPlq9jC/W1+oeD0ebnqmHtxLz?=
 =?iso-8859-1?Q?esqlUIfgovLC9GttRbq+OjYM43XcQhPmu/9llOBsjqkEwhVWrqQWio225u?=
 =?iso-8859-1?Q?npebf0yKKFb9RKfi+1hDkqU+tt37BNZ8YDbXC3SZtL0jMmqZuSyDOdQW8b?=
 =?iso-8859-1?Q?45QCpEnredoIrxtNzvzCthg4Rh22VAB/PoH/tVfimQbE3ohlvNqsnXKbwS?=
 =?iso-8859-1?Q?wUXdW+HlPwg8YIkkFKxx7mFbR0r+1SnMQCQ/auVgWwSLwssiWHV3nfJv8w?=
 =?iso-8859-1?Q?3OSRkfGs5Fg9zvfCkMMaNs2XYJMjV7DgVVc0DkSfQgS5507QPwLQnOIo4Q?=
 =?iso-8859-1?Q?nIS3UW3JLg1muzwWW835meNLHTqqvkgjjLOIRKUx4B+HnIHii3IMWy9Psp?=
 =?iso-8859-1?Q?bPWK2/eElDsDw5CzNJ9GsV02DNa0LLL4oASbN2ry35wA7+UWuNOa2O4orZ?=
 =?iso-8859-1?Q?mDRnA5Mh6aL1HFJW5MXHB0T9rF6JL2K20jN5iKIYphxHnbibba18fNfMDQ?=
 =?iso-8859-1?Q?8WOvSAzt6AloPwy74wDmlIxvS+0EQjJHNCpkLGR3uyfMPfcQNBb6UIT+Cm?=
 =?iso-8859-1?Q?dhZtpK24rJDnICWPT0ofhm4nvEVmSSof9gwDUSeuKWsSuVkNlJ84qk+Jt0?=
 =?iso-8859-1?Q?5Py5SSTUan9C2+/TtWBKvqeqv9z89SW+6/dPwdrOEOh6HyZxaJTInj18o8?=
 =?iso-8859-1?Q?R13KKOS98U8iGVzysTZwDqeL1Maxoh6/3OpRQKzjq5SyqWkVSkkwTZ2diF?=
 =?iso-8859-1?Q?q8AHrtQHc7toCyGXs8rTxTNA6uGzuOel69AB3axtFzDwt1b7RsAtlDvHU3?=
 =?iso-8859-1?Q?qOjTpvXev7EbHKv743Vcg1yTnapAG7FFMLTLGhGvs/D4dm1nym1lyfOAJZ?=
 =?iso-8859-1?Q?6+WiQUEJw+tEhPdRugbp/nYOLoNqX49YzLErPEo7cwrIl7zKi3vHi1xPPm?=
 =?iso-8859-1?Q?bARfVHlodT+cXZuCKPl7C8ZcxbGgdTfXeyfidj8FuS1zNdr0N9KrIJ5PkF?=
 =?iso-8859-1?Q?eKYWoXA25yvI4Q3vX2LK4e8k4/cdk1NxtYxQhWzBBSB03ISUq1rf0g4bWR?=
 =?iso-8859-1?Q?mZHC/pvGYXVZ80NxAziOzDPuas9bgFy6qDiHhCQJgkPk2Cz6ZFooLZ2QMM?=
 =?iso-8859-1?Q?7Opr0pVTfFKlOrFd23d3ZxcVJ+CIFWJYcS+gyF+MCxhzucb7nE2Rp/e9mD?=
 =?iso-8859-1?Q?GU792tZ36bw+Nnl9Pn7tAshB8vImKKixM00778s+0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d502e48-1c22-40b7-32e9-08dc6adcb631
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 19:18:56.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0P221MB1484

Leon:=0A=
=0A=
Thank you.=0A=
=0A=
Your help is greatly appreciated.=0A=
=0A=
________________________________________=0A=
From:=A0Leon Romanovsky <leon@kernel.org>=0A=
Sent:=A0May 2, 2024 9:54 AM=0A=
To:=A0Ewen Chan <alpha754293@hotmail.com>=0A=
Cc:=A0linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>=0A=
Subject:=A0Re: SRIOV virtual functions with Linux "inbox" opensm=0A=
=A0=0A=
On Wed, May 01, 2024 at 04:43:39AM +0000, Ewen Chan wrote:=0A=
> Leon:=0A=
>=0A=
> I see in the link that you provided that the IB management packages are o=
nly available for Redhat.=0A=
>=0A=
> Would it be safe to assume that there are no Debian equivalent to these p=
ackages?=0A=
=0A=
Right, at the moment, there is no Debian equivalent to these packages.=0A=
=0A=
Thanks=0A=
=0A=
>=0A=
> Your help is greatly appreciated.=0A=
>=0A=
> Thank you.=0A=
>=0A=
>=0A=
>=0A=
>=0A=
> From:=A0Leon Romanovsky <leon@kernel.org>=0A=
> Sent:=A0April 30, 2024 8:03 AM=0A=
> To:=A0Ewen Chan <alpha754293@hotmail.com>=0A=
> Cc:=A0linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>=0A=
> Subject:=A0Re: SRIOV virtual functions with Linux "inbox" opensm=0A=
> =A0=0A=
> On Mon, Apr 22, 2024 at 10:09:15AM +0000, Ewen Chan wrote:=0A=
> > To Whom It May Concern:=0A=
> >=0A=
> > I am using a few Mellanox ConnectX-4 100 Gbps Infiniband NIC that's con=
nected together via a Mellanox MSB7890 externally managed switch.=0A=
> >=0A=
> > I have a dual Xeon E5-2697A v4, Proxmox 7.4-17 (Debian 11) server that'=
s running opensm, along with two AMD Ryzen 5950X compute nodes, that also h=
ave the ConnectX-4 in them, running Proxmox 7.4-17 as well.=0A=
> >=0A=
> > I have enabled SR-IOV on all three systems, and all three systems have =
8 virtual functions for said ConnectX-4.=0A=
> >=0A=
> > I read in the Nvidia/Mellanox documentation that I would need to add th=
e parameter "virt_enabled 2" to /etc/opensm/opensm.conf so that the OpenSM =
subnet manager will know that virtual functions are enabled, but it would a=
ppear that the opensm that ships with Debian 11/linux-rdma, either ignores =
that option or doesn't know what to do with it.=0A=
> >=0A=
> > I would prefer NOT to install the MLNX_OFED drivers for Debian (11) if =
I can avoid it.=0A=
> >=0A=
> > My two questions are how do I get the linux opensm to:=0A=
> >=0A=
> >=A0=A0=A0=A0 Recognise that I am using virtual functions (so that it wou=
ld understand that there are multiple traffic streams coming over the wire,=
 via one physical port)?=0A=
> >=0A=
> >=A0=A0=A0=A0 Automatically assign the Node GUID and Port GUID so that I =
don't have to set those manually.=0A=
> >=0A=
> >=A0=A0=A0=A0 (I've set the Node GUID and Port GUID on the my Ryzen compu=
te node host already, and I can see the Node GUID and Port GUID inside my C=
entOS 7.7.1908 VM (which I've updated to use the 5.4.247 kernel), but it is=
 still showing "Port 1, State: Down".)=0A=
> >=0A=
> >=0A=
> > Your help is greatly appreciated.=0A=
>=0A=
> Linux opensm is not supporting ConnectX4+ SRIOV.=0A=
>=0A=
> You can install SM RPM from NVIDIA Web to enable ConnectX4 SRIOV.=0A=
> https://network.nvidia.com/products/adapter-software/infiniband-managemen=
t-and-monitoring-tools/=0A=
>=0A=
> Thanks=0A=
>=0A=
> >=0A=
> > Thank you.=0A=
> >=

