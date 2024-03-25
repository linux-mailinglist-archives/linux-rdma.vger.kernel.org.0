Return-Path: <linux-rdma+bounces-1555-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909F788B45D
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 23:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E272E1734
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82017F7CB;
	Mon, 25 Mar 2024 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jRZAnNKg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dyncDcco"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F2757F4;
	Mon, 25 Mar 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406497; cv=fail; b=damjibaGq+g8/azCB31RLzeyolcDL5RA0h4cR6R8bJiEtAljqvjybpH2Ih3WFZjkJB858wreSXu/89fvdzG8UC8+GyAyO0j0Li7j4mcPfrP+PM6SvfKXFroH/etdpS6Xp2FV7jDHvuqKHGjLRap+58UfcDL9V6xabQhUOarM2Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406497; c=relaxed/simple;
	bh=3g6ZVgi/ixQ1ARXqvitlNf4IPzqHNnis/41n2QmgE5g=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=KINZv613HxCc/eS3BoeQ7kS0GigXSfBfl5k2W23txZr8wzYlWqpgP/LWqHEoG3Hl42qzXUHyeQvri0xtmWhb0t1tg+9s3B/jjAdy3nXlRmQPOBISZ6gXcIe2nFsqWH3bPZ0g2bpqwjIIz3gdCgbyK29lobaEh1fZz0eQvQr32HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jRZAnNKg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dyncDcco; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PLG7sn020631;
	Mon, 25 Mar 2024 22:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=lA3ECgfU9G8BAeaGds9VxPvIC81nnfzrc2YqASPKsR4=;
 b=jRZAnNKgry+vVyYdIrAO0neePWZjE5v+yPwD+HKnpc4fYbITc4u3HQfRtHQvW6DEfwWY
 xUOoB5KlDFvpnue+l43gADcOlCoiEGikMTQxPvNKCs35xl6Wql275o9+RDCOD9zpQhfO
 K4oveELENr3UIzDMWhQpIAr2/8zh8wj+wZD2TyguEf2UytDjGmC/JEk447YQfOHfclLs
 1cK+87ZkhG87SaSl6+zZjykaldLGSg5Jo7qnxXiZwYduQVrEuwoTwMDkrp7NdQwUsDdK
 hKgwsLOl4XJPt/RFkRGtqUqXfxBWTSOieHDi40DhOs2+CoGgfNTlGJbx7OnHbXubp+BN 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct33f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 22:41:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PMbNBg015935;
	Mon, 25 Mar 2024 22:41:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh65kcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 22:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV+VP0uoXVAGqMw+sRTyHy+YyEwsY5fTiYJTfaIA0IdgsVQtHrvO+dpj93YUKtEdtOgXZEBmhHsvoTi0EHhLSyDjEgwqzAEsfoo8J/PvSX9OjfZOoMVkAfMsLCyvxY9fPu6wY6FJvUT6CkZkq93J0W9TpYJsdPngIOEDyIzACx6DlP91v+vuEjG0BUPbrjXPlGWHTiLtdNKl+oih/poMlc0P9PZGNLMwDnXT4KbgJzPxd581mwWjCdj52b/9+BVzq7Qyn+/tpzyr0TdBQuuWV2QARFVfRL5aSP5YWvKoBhzCwMBv72nePG3ljX2jx2VLcRXl1bAN489GbD+EWGJSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA3ECgfU9G8BAeaGds9VxPvIC81nnfzrc2YqASPKsR4=;
 b=Ms2kAc6hIJfuV3B4wOsUreYd+coqV0AwNIo2JNbIA9klQP3EDROuDlHiMB7KvMnJf33q9xN6zJZa3FBfXEWEg4RJy60Q4GsnDWUf4siMjj9yugdLf9xKkokQO/ApctCAJN1uIxMfBs71duQHbi4sA0ktof4Qw6J8vYTPf3yHeTH2Ssnnb/NqpD8aohWIFOKGOQJeNS8pibyrqd6NG/s3AR+MqD/vgqBlkBEjO3+78ekVsPIkH3Cf9emgYAncBcIytmJQsspBd+jNqCIcCaoGxkwB3q4YU4x7fSxO9lGg3whMsSmr0TeLWye4hhpc1Ceu2//bAQT60YdI2gVVYVAlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA3ECgfU9G8BAeaGds9VxPvIC81nnfzrc2YqASPKsR4=;
 b=dyncDcco3d8RYbnTdWBnz9+kdZS447K4f4NCE33YTNMTYZvIX7TCk9T/9679xPhYRn/FUnnroXT3SjYYP+sYWDnYrBe2JJGZLXDhvRu0VL5LWMF73a9pWsBaWrYEj8NTnGTBuLKwleZGHGHnVVXUD7Al6n+N5WQXX67lbOu61TA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ2PR10MB7617.namprd10.prod.outlook.com (2603:10b6:a03:545::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:41:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 22:41:06 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
        Lee Jones
 <lee@kernel.org>, David Airlie <airlied@gmail.com>,
        amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] : [PATCH 00/28] Remove PCI_IRQ_LEGACY
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Mon, 25 Mar 2024 16:09:11 +0900")
Organization: Oracle Corporation
Message-ID: <yq14jcu9bq6.fsf@ca-mkp.ca.oracle.com>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
Date: Mon, 25 Mar 2024 18:41:05 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ2PR10MB7617:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M64s68fo0caB6T8oEsGRk8hosny4u4X6t9xlxkTLVqVXTOd6rT5AA93RlLkFy7SOKyK/Hy5DJ+hkv9mWk4KkMaBQj+lh8v/LQQYXDUQYCoCs53foTZ3NdcMifv5TXmNBqiS9p8loU2i+SSKecrysTfpyUopSsXdOQ/DJMvGmWCXSxgT9QacqQz21fjrabfn27Zo9Q9dzgsQ24liov5LcD9v6IxJiFj6CL5yg1LnNoeSupjHwNAUUeRqVTbPpqvEPZpy98J9ZzG92SyI4aQXg1CnQRrrI6cMxo4m7WTnf6TTuche1tV98UbOQEc47nLD+Kg6slDLBoa9WHIXqWArMdt89L/jzEPnCpPD5r3Rv7AE4OatiRmcWfNM5E6Pgn4xet0mkqEe2sZD/1TdVyy4bkw5uQueNElRa/uZC1DON7k8MWnxBdlrgWTw5SKIBpXcQSciyFhGs1GEcmvvlognZeuMthBfjXcNPUTd9kNv0dsOO2oqtTrQCVcqWiYELO1EQe5AKGvq6Rc2riS9vZ3mPgW9Mgt+bHVp+Pbtbzsciu71eAjbbNf0MviJ3Bk4Ig39wKmUoRPPTXjzL3Q31p/vHycBxT4493qnSrZwAz9XGDYsuObaR3FYxDL0h5apSgWtK4Qh5DQohNyEtugvTkxxKK1H7CB/FsEyyl87TCUsytaU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k9I6uqYz+wqt7JEHHB2LYleYlaud/oclOcUwBHezOjyMTz1ImDd+indXMcZ+?=
 =?us-ascii?Q?RqfpWOnFW1+kwf8u3pYbN+lFwPVwSCgI6c9b9fEgRgnMZLu4JjWr2Q3Th6an?=
 =?us-ascii?Q?rVHRUvev8uQkD6D9Ex+zO3EKbD2bXppQ3noMMukrUArRso0x1Ad3Su7wI1ZO?=
 =?us-ascii?Q?p3eOABB7k2XDQRTKqMpSSIn0gAVBEgwIOw87nRhYxtegG+1gpHdP/TXwe8W9?=
 =?us-ascii?Q?KhlLBKhx6yxYTEmxQbSA8LqL7421q/69UyVx5r/TVZzGQReB8bu54SzPsS8+?=
 =?us-ascii?Q?JRZ5Y6L7YR/AkxKQ0pxIKkZPGbqJtvcXta9OmjpO+GXK13c+nYQWNFfKz+Fg?=
 =?us-ascii?Q?imGMynpIn/2cl9/mHBwT8TFjF87Y9Hl1EJiCe0fxswY9W0EokGXTa8jyNvTx?=
 =?us-ascii?Q?EjmByg1H4QKZqo/SQO6lZi8oFs553tVPZ1bd05T3RLARKyzqPHrzfmWQApA8?=
 =?us-ascii?Q?pYu1IwI9zUNjrHsu9mbYLWgH0dTT7r6lX5qmIisH0hwGqsgEZR1d+BHAH6UH?=
 =?us-ascii?Q?e5iPkbhlutGo+FaPYe09Jjg7v6V0RDPG9wm6yzq6kYZ8FK6lJIoIz8j4C+ma?=
 =?us-ascii?Q?5bH5oAvzH4n+JCByZD19lpsvHwi65V8TpR5GD8+hpDPT48+XZmEucQwHaQoD?=
 =?us-ascii?Q?WiwsUCcwB5hrzVjIp5TY60jiYOW0OSwQLpFKia5+e3ChZIHwWfPzgU2uGEZZ?=
 =?us-ascii?Q?caF9o8eChHip9ZAuAtxBGQTG23IZJ10ibAy24k1+Uf4BpQ4+Ugu6sEArEwyd?=
 =?us-ascii?Q?cJXzZBNYEF+mFWREJl2JXxOa3aHSr5buzcW+kDPRxosWRCfUWkvnLhb/rKVL?=
 =?us-ascii?Q?wDtg3bFjI+WyM9eKDsV2sETv32Iw5+BZOCQQdsLd/RSU2agUPlKL1StKdi3B?=
 =?us-ascii?Q?3hFuXllUbbIBtZOGP7F6hWAgYKuebHeRucTnXyT4gRpLhmm4GG5xp1UeN2wA?=
 =?us-ascii?Q?BCOQKqV2Dp82gFcJ2tHXZ3fOXBQwlXDVpIKzUwpWPg4F6RjuAjIeoDjl1x9T?=
 =?us-ascii?Q?uL+Ssw0DWyy0DsYYMQ4BWPn/l0+8oQsZGRHlDsCwqm9X66HRCjMjtJ11lpz0?=
 =?us-ascii?Q?p/DLRmMyEwUFgAg4DE7pl9SU5AyQf8AbVDicX3RSXB56yBPOsz6GZPyuwMkG?=
 =?us-ascii?Q?TsHwkPwwFc6eRy8tdnoeFwiRTj/vYRxwvLcXyQtL3jVe136JmigItklUccGF?=
 =?us-ascii?Q?YzuPM7vIGPKNyo9jNccLZwwF86C4FAe5hhOwdaUFbS/2M3KjNi/Njh9brt4H?=
 =?us-ascii?Q?53NSq1xEpzg+MeSnN6IQ/fnnWac1SclVaPylrpPBodDaf44OROfmM4QkHOcj?=
 =?us-ascii?Q?F0+6n8wJFI9gFLGoEBuOvs0pYYePXNpiFpaLX1CEz2CEf9bpLFHcPteQgML3?=
 =?us-ascii?Q?eU47yk2MJIEKJYkMdPmBpmteZ63cLrQ7V/sKvS3AnMuuAVsO6XMpjjwzYs3f?=
 =?us-ascii?Q?yInnT/hlfks7BX4wZ10InCCSQVxsMws09SdQ6SH7tX2yzp4TzF7DOnL4Pt6x?=
 =?us-ascii?Q?gpuMo8NYaOfCw3+Zb9hfJtc3i/pIfKfufBiEXUjUeGySaEmftj6ev1H3ml9w?=
 =?us-ascii?Q?fIV9uDHwlibH701StZVwRN6eCfYFiaiOqGxtZZfeGeXUnq4YQkUm5y/K6i8Q?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RJcU51W8Fu/NWeqnT6/4Os165jMO76dhAOnowOmWN+YnQwGL3wCGvaQNq/7GVpLNpt2bALKyUuYEenk+VzoNHrtKVgaJuja52dNV8byGGSIYHeHaY4gIPA4DTxFjDOh2HTPFdEKDIBUfSDoUZWWxa/pk2Cop0taZU1gajKRMVvhPI1RmKTuyx/x9ZLWiuH+FznXMfVaPLeMmpciYAKA0IXHTmbvIax5Lxj04UKUJ9jiiL0wlFsN7/as8eWuLsDDV+kkkuZkDI3GIizEmMlbH5VS8ebOi/D7/cYXY9JJpBIkYPZj5tn7m+UnTAuYUk7t17WayPehg8vjUIQCD/Zews97NvIZs4Pc6UTjUG2zuAyKL0UVW5xXtF1h5uu9fQ4APHEC3XAj+wcneprkugRrIUGnIqmMM2jDYSkp/S04aWOE4wDhy3na1bXV3Ylsrn68glSiwLjHdiURTdiyr0iE1uzphPmdO4Eg6nHCcdYtrKUkE/G/Gm9qZDrkJ+WvVaWKm9716H9OhywS6wpA9811ucW1oaiN0tkXTPi+AQVEd4qyp1vILX8D17H19V2xtTlA71j+7lSxr/juqCUWH/22zvZcX9Si5Kn4W8hCojQQrFzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96af9bea-6427-4f88-64ba-08dc4d1ca8d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:41:06.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XwpL+63l314dLfI6/BF6Bk5k4TGLTdAYXe3wWB/hsE24IUyTGOPKs15p2rpt99pVzUD3e+uNJz4H0rQR64K65+RPvz7l4yE3wRFy89DQg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_22,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250142
X-Proofpoint-GUID: zg0dHLrcfCofqOo-vhkjTyPHeJCKCX67
X-Proofpoint-ORIG-GUID: zg0dHLrcfCofqOo-vhkjTyPHeJCKCX67


Damien,

> This patch series removes the use of the depracated PCI_IRQ_LEGACY macro
> and replace it with PCI_IRQ_INTX. No functional change.

SCSI changes look good to me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

