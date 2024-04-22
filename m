Return-Path: <linux-rdma+bounces-2002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1BF8ACA4B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA9B2147B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AED113D611;
	Mon, 22 Apr 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="I99fK7lU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2075.outbound.protection.outlook.com [40.92.18.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470450280
	for <linux-rdma@vger.kernel.org>; Mon, 22 Apr 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780558; cv=fail; b=CfPiAG/77x+7Aztz5Lr1rOxlMz2ZacCL0wV7yyyvR3t6lZu6A2RRvugLIZFNm/QnXNV3eAEjebPFLglBd8mhtFvUq30FsQlEOcjyvnTWjcOw1ZBKEGe2k56yBhnx6nBwSJjp+GMZqLJcnghVH1bQYESfeR9lh2/tAdrJOxvu1c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780558; c=relaxed/simple;
	bh=fGmhc6hue2AMV06NypVOexZTtq6NPphuNiu+ZgoIWHU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=upg7v3gk3pnYWumlS21F7EETYTm8fhdn+Axhk6KcEjL3JpJ2/oGgTDmsH3bBHzGHmbmrbESbgUjbFhvOAoclNAw4lE7jo8+2MXc6G7CtezEEiYrBir+EBvKY99QLuswBfxu+Hn60BjOlLc96FHCqHv+lEMxe9x5nbzQ+qDVtuQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=I99fK7lU; arc=fail smtp.client-ip=40.92.18.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3tDoL1CuNuF2yaSRrjd2C8gcRyi+6rUYs1drgoREutc2MYONz844rvkPxDi+xkp5vEqmfFn32jCvZtic4VNi8BmKJQk9OEInuqiVy5lFzJFEMWQulVHLs09lOBFOLuefzcoaJaQSqmuxkS1wM2UOXLtSVQKe9w0a7Y1M+8udy4LosgGCmFMASYsgzNHKw7Ewmicq8Z2/6YQXkcM6AZ7kuWwgvotdWce04Ndq1nnjgsx3tyCUy5Ny3B5kKB2z9UMPruOo/Dwd2lyBl1XR3Men1YCBIbR12ET7NSbmihhKQdM38/Ynl1hZrGOxgSWHZUSXUnJOcTLyPOEueb0OIHVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj1x01oseqT57jtr32d3obOpz9SKEudkd016yIHXoNc=;
 b=ND1D0j2vX5vxUIsbUpZc/GVVute64TcE/a5neLrm5AVqZ6sAuIrRu4JGhs3pmmaFWd7akfNfyfTW6WeDjX/u2lOTW314e7Gegkc7z7r4GahPE9Tfj0FsI3dDOBLtd7XcERu0BoG94tkuSM8yVONOMOLgIntiwp5zcSSgTCC+ki1S0UdDVAjvN7a/Bn2wh49x4/Wfop6pYjIIy30NWeMNJbivrXGfb9h5ap56NhRzvb3yUOH4dER5Cx6mX6QZrjLzjDVFXVBMEwU4HUkupt+17ALi5doEvGxfLNf/Nx/ZisOMqilRXNr+Wr3OmdHyyFSQ4WTYgFS37GbCUoRaoz28Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj1x01oseqT57jtr32d3obOpz9SKEudkd016yIHXoNc=;
 b=I99fK7lUU74bUNXyvnKGmXiG1myCIhNX2lTj4jdql85fYBP1E3jh5ruswaiHDiNjNWMtM3C/PXPy/M9ooGdjtwrQiUqnWr7Dl6PNjwMTwltIti9RCj9Mm38w2Fvxcv2rBOnvLsfFv9VSU2whxnpMGLIHGf4nLGHQmhRSJGH9MVhWoTmG/w6sR1Ztv6SKaVC7pc8zu2BwRLd5meLAQrT+c6AHlVbTuqiTrpmPaMZL7mNgCEw4+v2q7aVk4UDk2o0WRP73Z8bBYfmBwELRGu5GxQfLKjohS57vFur1BL5JFqu3aD4vKGHs5iA89FHCN+ell767wY5C8oKasHl/+RCqww==
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:259::10)
 by IA2P221MB1350.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:4b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:09:15 +0000
Received: from SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::2890:9823:488c:2ded]) by SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM
 ([fe80::2890:9823:488c:2ded%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 10:09:15 +0000
From: Ewen Chan <alpha754293@hotmail.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: SRIOV virtual functions with Linux "inbox" opensm
Thread-Topic: SRIOV virtual functions with Linux "inbox" opensm
Thread-Index: AQHalJz/zOFXuLYU2EWJz7mH+6NL6w==
Date: Mon, 22 Apr 2024 10:09:15 +0000
Message-ID:
 <SA1P221MB10184D6002569E274E6630D7B5122@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [A2yAfw9riTrvrl4bp25hj4/D5EDWDcAp]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P221MB1018:EE_|IA2P221MB1350:EE_
x-ms-office365-filtering-correlation-id: bb7d50ff-da21-4479-1235-08dc62b443cf
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uhnhMybMMZPobcmBUBzgn+mztez467VJIQrZ9TRcMul/Vabzxxe9ZiXbhB1/hfEBiYb7HLuTzUFnZf1NdgCLQPPw8i5jKdiv7v0QvbVJsi8fhrVZATOSd/nHeuRhmtP3j5z1Fpf1A2vbicfGN1u45cSGA9rrBEIRkg/18rKa1Vqp8OuYa5gVW+Jy23B4AtmxITVhrYhYWVLx/HembFbBlTKMIfN/h1647tLRj3bAdYgHyGIrRyhMfn9WhSwPiN/hdKHJQB0VAEvMMdGn8BG1vsgF0lh80UyTpqzH5TJLPPGbJjwDCYczxqQE5xBaRG9jAEJ/1P4o9C2Q8IBKrQrqmutOvGlnnZIX461GZbbAuNIOysqdYCK+V5FqbPVpI+7QaxM+DNR/zu1tihTX+zeQtvZ1x0Me70xIUoieAAMYhJtP8WxTJLoK4YwO0XMCePtvtlnb5y+O3EC7k4OOOLivIv4RmUwaDA2Hofb4xKFKvJc3ALnvF2Fgquc94Z1wJYdUA+Oa1m/7aVSVnGttx/eDH1Bg/wM9yi9HQRKO8nt27aFEbZloSSu8Yzts36IRE2aY
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RVtU5Duwxoadn6DCjdHW7dpsJIGMSetg0O0JuVAVwWY+p98SfbcRc/iPQT?=
 =?iso-8859-1?Q?UXdRNC2dNbrJpbQQn/CKY9MCo1p4yVer9PbpBChPNCXLMxf0k4DQ7QZ57a?=
 =?iso-8859-1?Q?7JKi4472WkZ8ZRVlGHMGXBfTCKJZ8WUSO0roZ6912xQLr+IG35iiQ4nmn6?=
 =?iso-8859-1?Q?1GTuY/3d+K6ExupkswSWJFiDD0Qurp8oqlLPVb3221//FVPF6FBamT93Pq?=
 =?iso-8859-1?Q?khnkitFAhjVBpyyT21Ixj/5Cwxv2QcMU0EaRp6dbnE2eotVQRV7Dic+IOy?=
 =?iso-8859-1?Q?H6xYoad3RlGN1sLg2XFSQcY+vg5uJ/wQ3eEYGFPU8VWTJKPhFNqygzTT1g?=
 =?iso-8859-1?Q?CPBeXhVNIHuwR5Ns/XsM/b5WwYaxAxsAEAvdHb+rFY/GS17Qf5gUhOYD7J?=
 =?iso-8859-1?Q?dfRUTZ5q43skdSPVQuZzsaJxw1QIfXh2CwZBDNMuJ8JmaBYEZCDvQtzX48?=
 =?iso-8859-1?Q?GPZqAkOYHPc5XeA0s86vB+s5C+IMWp9fD91xJUNCEthVfFw2IAzhP6hCDd?=
 =?iso-8859-1?Q?lT/j0G6DCmtDynkBRrp53MZm3ducNhreg0RHeugeGAlSZaUNBznEdfyN8Q?=
 =?iso-8859-1?Q?XeSxuakJdcMn0xqRfUs3tOWJnJS5CEJwLB7bkTL9Rlno1H8th9tvg7UOiq?=
 =?iso-8859-1?Q?TMcovKOGgN0WCPjsIRMt4rYsxzOd5UInUW+oAjm4QovPDKtiY0VZK8+nsj?=
 =?iso-8859-1?Q?lh6PR+DW/ZMCnZZApdBDc+wkYYVZcmyei4RAtJ5tfByZlqwtskQyyZ67gV?=
 =?iso-8859-1?Q?0E29LAGqGFdFwICqAXLVM4ZTfiq0EX4Z5ypSxIpJHT391NmZkTFb1BiDdd?=
 =?iso-8859-1?Q?/VeZ5Mo7uCn9b6gXoJ0qIS4Kp4V525IYeCoCBdVEXMZcEfAhCl+WkZKsVF?=
 =?iso-8859-1?Q?cjBzxYtCtMw1WqRSdQuVUA13/KQrUtWpscYU38qaUXmYaE4p0t6Io6J8oJ?=
 =?iso-8859-1?Q?H0oBlzTVRD3xaszunGsN1PUUpBYCCRPjMdke3oEW3vy55YdnBNgYAwP3ez?=
 =?iso-8859-1?Q?ssY2X7GjBzyP9JL65yjQNOsElhAzYSXxGsSBLsPoZD42NAw/+MVSoknvfc?=
 =?iso-8859-1?Q?GLKFK4rN0ePRdR7KufqHreWnu85lEOLC3g9B1mViWLl8od2glgrZN9Kli7?=
 =?iso-8859-1?Q?9T5TMeLuQCaeIvzLAbbgOjCkuTqJWJLkRZVYAQxrRq1XyGsmS9Zcci1WPZ?=
 =?iso-8859-1?Q?DMD10kv/qGK44VCZOm5PamxA3oOEfYqCefeLbEXO7H/DyT/sayg4GzkDO6?=
 =?iso-8859-1?Q?5Nm8M68KyT9Xx1BvoO5Rj/zu0ZLG8uRDCMJJLDYCU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7d50ff-da21-4479-1235-08dc62b443cf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 10:09:15.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2P221MB1350

To Whom It May Concern:=0A=
=0A=
I am using a few Mellanox ConnectX-4 100 Gbps Infiniband NIC that's connect=
ed together via a Mellanox MSB7890 externally managed switch.=0A=
=0A=
I have a dual Xeon E5-2697A v4, Proxmox 7.4-17 (Debian 11) server that's ru=
nning opensm, along with two AMD Ryzen 5950X compute nodes, that also have =
the ConnectX-4 in them, running Proxmox 7.4-17 as well.=0A=
=0A=
I have enabled SR-IOV on all three systems, and all three systems have 8 vi=
rtual functions for said ConnectX-4.=0A=
=0A=
I read in the Nvidia/Mellanox documentation that I would need to add the pa=
rameter "virt_enabled 2" to /etc/opensm/opensm.conf so that the OpenSM subn=
et manager will know that virtual functions are enabled, but it would appea=
r that the opensm that ships with Debian 11/linux-rdma, either ignores that=
 option or doesn't know what to do with it.=0A=
=0A=
I would prefer NOT to install the MLNX_OFED drivers for Debian (11) if I ca=
n avoid it.=0A=
=0A=
My two questions are how do I get the linux opensm to:=0A=
=0A=
    Recognise that I am using virtual functions (so that it would understan=
d that there are multiple traffic streams coming over the wire, via one phy=
sical port)?=0A=
=0A=
    Automatically assign the Node GUID and Port GUID so that I don't have t=
o set those manually.=0A=
=0A=
    (I've set the Node GUID and Port GUID on the my Ryzen compute node host=
 already, and I can see the Node GUID and Port GUID inside my CentOS 7.7.19=
08 VM (which I've updated to use the 5.4.247 kernel), but it is still showi=
ng "Port 1, State: Down".)=0A=
=0A=
=0A=
Your help is greatly appreciated.=0A=
=0A=
Thank you.=0A=

