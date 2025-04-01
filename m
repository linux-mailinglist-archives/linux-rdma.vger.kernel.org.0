Return-Path: <linux-rdma+bounces-9093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68824A780EA
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 18:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C45D16B805
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D420F076;
	Tue,  1 Apr 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rUAIOp+o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74020E718;
	Tue,  1 Apr 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526677; cv=fail; b=kYVBSv0FaKtHVeMCm8rS/kkkQ2Q6+nN7flZPx+r7xIUZFxgW7yT3WmjsFMhYKE+i7CcTENj9aVU7WvNstIvxx7oAnJGfcDU6BGYqFclEid6uKifYOjBwVf4L2b8LWCqra6SEWm1xbx1uwJW+LuG1zEumq8VYSEbQGrONxNsb3GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526677; c=relaxed/simple;
	bh=m9cr9DNrRAEiPLjnVt+Y6e1a7m0bbQZWI0SWbb4rmC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NW4QnnK9qjiQb+Q4QQLfRuwbTfNYQQ6dr1Z+gR4RC2vRdW1tuOWWu3yu9Q1ETNdYNNax8z4YbeX7SFaMh6X857xkEZ9bTzBHlHnjco4QrlbF/Y/l29WUgowzrPDrxcT5dP40c4HIh9AJA9Zo2qAVgDLqyqu9h3kxRqV+Pwf0Hak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rUAIOp+o; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7lfCH+XROgd4EKYSJvcY0SXdl7Ut62aRygbnnX/mG2nNMjIJYOC+SW0cCPWraZtgQYaEFLAzoua3TlxeUFPvZpY1T3Qm5dvwu7cKHWFQp2OHos4zgQ5r8s4MWsAODwz8QzP6CzVZWNzjLsT1z+jYQMg4pO/VBSVKG8DPS/wuLms1PR1mJ0AXq1FBeLe+GAlDmqEG3WhQV0nD/5cwpyg9uKvfy8Hv7v7+jNf7Wd/7FJIDHo4u7fp9AV7NtO6ej4bqbVFaupFQg3r8J6auQUxOumi/sTfGpn54KbPsX0Q/o6UdJ2huC+tia1oJD1iAXM9c0/ORwQIODqtstDo/FArCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOjFswSfa6WnQfMYYViYmvbPOD4MsAYEs3nWbHZnPrc=;
 b=QIxbBIiKPMphhxi50buJaJCIrm3ZkpgvZbR0uJQVlFR/ArwnQMMHdgPwYUTIXWwmHN2eV5lJnmgCedrwchoQwwzrapfTitHkp8KRqlGU63lM0g6wfW9g4vfGJ4kjW7M7+kiQ98TNk9NLbhiuoQU/R/dS11t8g2vr5R9lBZ6G5vXZmpG2CnujG9A6gCCKgn3nsBu/ZeOOtuMgKgfd8fMGN8Tb7sXTh532NkSY42dvZc8AZXS4TSTZEXryCkzakeaKvwfWWQXT8EYpFlgLA5YedQvZnMF91VD/4MWoXH7kBSJJBDFfKXCZyDwjqGjCtZkchjjsBJc/meLbiWAbsDxnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOjFswSfa6WnQfMYYViYmvbPOD4MsAYEs3nWbHZnPrc=;
 b=rUAIOp+o44XMITLozHQfNBdHwdv0ehli6xUQQLWN04LOfTRLh2GmWMUJiK8Qe1K9yxts/kSat52s2uuyT0GHsaySarlzJWDytFp7BN4spPGNtoJHBuOHiz0BM5MaCWCl1P8iDQDntig6R7f1nBiIVUSbP2GGbvkN8Y/Xx9T4PDBJHzW7XSMXvj2yiZwz+dK3yb8P2P7vGdILzPpLwd6+d4Ogy2WP+CvpgOpcqMabFSdBDWCercE/rA3YR43UTyJutaQ1vWzkE1cXx92K51bxHJgkXsyfb2Lb9p6Ht3epELjBcmS1yEnQu7cytB8j9kdyOaf9wGACFtortmQa3wrkkQ==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Tue, 1 Apr
 2025 16:57:52 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 16:57:52 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>, Roland Dreier
	<roland@enfabrica.net>, Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiCAAUvLgIAAK6Tw
Date: Tue, 1 Apr 2025 16:57:52 +0000
Message-ID:
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
References:
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
In-Reply-To: <20250401130413.GB291154@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|PH7PR12MB7817:EE_
x-ms-office365-filtering-correlation-id: b99a9115-46c5-43bf-a29f-08dd713e577f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JDkxETIhi47kX16TKaEnBoUIJZzy0UYl8CUKOAmxwQZ3rMoZ5z1p0ljxmxrs?=
 =?us-ascii?Q?NtbACISctA91VxBS90O8S6fWSjNn55bN7gjI6r3CsZMfCJead0RbO/ztrQ+G?=
 =?us-ascii?Q?1BcjTTVNdQ0yBDrwlKT94CwdnVGLZek/Z401uloUKjzkOzswn2r94n78hlMp?=
 =?us-ascii?Q?g78/KXd5nF9zw8WvAbdaPd+wBvsvN0dFAifIeNJBPKgMDu21WxhPDkLX12zH?=
 =?us-ascii?Q?vR76ycWZSz7U/Ts6AaB/kFWWq3NPsD0v/3ZgmENDzMOTr6KpS7LOWcDNdfL0?=
 =?us-ascii?Q?aiQvXcCQqnl5xpJO64xhR6sKfwII1kXjZJMtzpdUUAT/wv5rT+Fk90bkj1yK?=
 =?us-ascii?Q?cISh1nXtXR5T9u/gYT9aOCTGt0pF5YZvx3rH//HRyhkiPnAnsBxBTiAci6gp?=
 =?us-ascii?Q?fXTOwjm0KQw3mzlHakXdJXN8pZ6gbIuUrwo6UnHlXVXPAwlXff8TO+Jd6hTZ?=
 =?us-ascii?Q?hTV2hvnhMcdlryjJChmpzvyvreLQl6MjYy5tp5UeCGbJPnx7P/kqpdAQt3A7?=
 =?us-ascii?Q?Z0UglyN7NtfbuEtxID4UzeyrLnHAenbDH+nZIkGO1kNAo5oCfrY4jhXIzFtz?=
 =?us-ascii?Q?R0iLJx8PRr/vff67P417uetQI3DR2D6Dm+lgq3kUoV0KIX+jUYRTj+TXAoGe?=
 =?us-ascii?Q?GXN2SCOg5H6dALRpSNB9jEMMX6vSh8ylnSrt4NY0pG/vsMifKu3H0FyyZM/D?=
 =?us-ascii?Q?Yz9qHZRSji4z6s85dptNGshpHTvQd2BtvdD48AF0xn5/68YfCZzLqar+Fyue?=
 =?us-ascii?Q?hTc3CPuKddKEH8MsyDCZlQseQYMYzQsPpyNs5zGL3CWqTOTbcA8uSu63d1q5?=
 =?us-ascii?Q?kEbWJJFhwrwiHdAUJ6GGpjn+SfF1DKhv6U7l07MqqhQ/LsuAYzm/UY6Hh6fj?=
 =?us-ascii?Q?tWR2mhNFkqa4c/EQ6/h2mYDL2LgRh57PiIcE3rYb4meu7sIZ/vIQHBgoszER?=
 =?us-ascii?Q?0C465mrTraPTtNOAAx6nUYNHqNdQmoKbcrQqiIlw5JAMKGNnJtzQ+J99kUk7?=
 =?us-ascii?Q?2sdejUFexHgFnU8U29jmZ6gMX3R9uxolM/Azv5tEUmCONvuapn3Ng3TXuEPV?=
 =?us-ascii?Q?z1MVMVvhwhk/NPrqYGNglFeNmIuPs8zejZScCEbzx8MrP7aBdZut82eCJYC9?=
 =?us-ascii?Q?G5y3I1dWgCKoaSjfAQidwkqFV3oQ4DBcDMkVotpEvdkhKSDQYS499KzXuPjy?=
 =?us-ascii?Q?xIU1xbcVQJAhb47GrT1Gol1E/SCfSDd7BoYs+JrBDszMk5t3alEsoNTwgI2P?=
 =?us-ascii?Q?U3AfNCzkNwzz48kW8jYUw6iUGJu/FHX660LwtKg+nB5Y8WwUVagyRoC2aOfR?=
 =?us-ascii?Q?VMZl0TxpwIJTmI0Y0XrX9xkoihVB34amIalznt2i573962QiVg+qTNE6EsTK?=
 =?us-ascii?Q?56MoOzykXbAR0O52T6FIBU4bC/QVd7uGJk6KoGFiMhzyrw8tBV+ZlrRjsCjX?=
 =?us-ascii?Q?jWYou3MQZeY7k19mGprTBsCbNkfWfGlK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SxAni1LCbLcvwDzkJvMMIgCOWa9bF0FvxVPRhywddKoKChPpnq9Q7ru/zxUD?=
 =?us-ascii?Q?dY3hLVqngHUoxBAKuIdJ3iqLnMD7390kaddrFe1YBsG2C6+BIlQeAvF1ePs/?=
 =?us-ascii?Q?PN9AO4ehOSzxIwOr/SBt7UM/Q8Y9kI9JBqS6dhfDoIORhVHo1Pc6JLqhQRVr?=
 =?us-ascii?Q?WumZpNf8eXW+5fBdZwitQvE5noVocIeromDH+Y+yb4dVSjJktC+3h9Bhyt9K?=
 =?us-ascii?Q?Q+KRuPC+vdCQGFO4tOPdN2Ke+nlKSxEidCFDxRQ7tRjkPmwLeomRbJHBZVbW?=
 =?us-ascii?Q?wz9RGopxH9oU8Rf8+mxJ59khPRooKvDqLM9sgtgGR0tOFCcVIx3udBSXpLWs?=
 =?us-ascii?Q?9McX59NtCnglPLZpcVPZPwY2s1moq8mCKxpR4wcz7nxPW9kQ0K9zV3UW4Io/?=
 =?us-ascii?Q?fcHh9XZ/HMnSeckgIUxdKKRp97x8NDyQB3gX80r3CsQ13xRUDfFb66wLUAIa?=
 =?us-ascii?Q?eu4ECczycG5tEtURJauGl+vqjSZ4FvR0eXqF9S8+heAOoLho9IocnFXsFen8?=
 =?us-ascii?Q?wGiVIZYmTkKPMcbyNf/ViJxsjpEKLzF0/rSyMkp2nf5pHQL4nz0M7o9sScSm?=
 =?us-ascii?Q?ZTg59Zy56+yqbr1HOnG/aErGkveODnEJW8AnuRa2La8q8yUjYUhkuzsNuNcj?=
 =?us-ascii?Q?sXeFPHC9a7wFWXLDF4cxwqi4mE/U7+ezOxJSBqStETUrp1589XP8BlgaPYqk?=
 =?us-ascii?Q?B5S9Y9+sgVGowbuBKm8mV9+DLWgncuS/6ngTqSTjk+a+DYFUKCeX9Ml1ZH6u?=
 =?us-ascii?Q?511fSd0vJ1RRsOUQj8wgPdE3TTB3UEKFEs3/r9AunEtkBwfBZatCTLaue+yM?=
 =?us-ascii?Q?kAPBIucbaiQtDB0LIkB0z8hbTYPIv6/hx05j+2jFsg+n9uGsfdHWnpBYFNj8?=
 =?us-ascii?Q?3JCdrqTyWp6F78aGmffUJrJKbEqZ7jdL8fdEcjxxrHWN2+oaVOlS4SpWqfgB?=
 =?us-ascii?Q?mIg5IlfBYyWWr1tL3r7/uwBgsT6n7IG9Jl79ljPspipWwRWGLY11jTP5pvlf?=
 =?us-ascii?Q?cFGCjx2szqkw058VMSXPxhDC0HEIS+pX1234P2Ry2PE2NseLKPfwoR9sUTuR?=
 =?us-ascii?Q?PZmiL7bMdM7pSLwDeAKa+s/oVoBQTCSP/+u9rONQtq2fBBqqpcjbxbfEJr8i?=
 =?us-ascii?Q?UjlYl6YhtzQrmEyziV4bRBCE95uulFOoMFUsM1jQyuX+CT2RvYYFMyd+rjIP?=
 =?us-ascii?Q?hO5dML19RM1NjxHrHgrZZY37EFdqoJV6CLr6j2RdEgsHvaCm/c9ro+ohacjh?=
 =?us-ascii?Q?J6KqYP4G/H/VbyNbM/y8+bC6Eswx6vayFl1x0lLKSA2u4wlVjHMqL+3Oudim?=
 =?us-ascii?Q?04TA9+lLuS8VwuD6bf+d1kYK5DTGkDMA/Q0aJNtRpHImzeKd9lwYCqIH3r31?=
 =?us-ascii?Q?OEg837Fz7STKuvkWwDlxtLpsiGvI0SIIBjuhMizxQLMG+JKOFywQ0+y4uErf?=
 =?us-ascii?Q?x/lvtet/pS8NgbW2Nb0h22jc1FFc6yqtm5kUkuPWAG5CXc4F060PTmMP/x5N?=
 =?us-ascii?Q?VVHlTpH1Zk2dguRQhqyZAL0uopRJzTcxDUPWMON0EU6sDQAJv6YynBeJa2p8?=
 =?us-ascii?Q?PY9SJi3yQe6OD8wOnwA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99a9115-46c5-43bf-a29f-08dd713e577f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 16:57:52.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/3zXC7eIqMe7uOFPRq2202fcpxw09xthEDKTjmSQ2GA2H12+ANxhSM0vsqDOaqogj84t+MI853rFoZcShk3QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

> > Specifically, I want to *allow* separating the different functions
> > that a single PD provides into separate PDs.  The functions being page
> > mapping (registration), local (lkey) access, and remote (rkey) access.
>=20
> That seems like quite a stretch for the PD.. Especially from a verbs pers=
pective
> we do expect single PD and that is the entire security context.

From the viewpoint of a transport, the target QPN and incoming rkey must al=
ign on some backing security object (let's call that the PD).  As a model, =
I view this as there needs to exist some {QPN, rkey, PD ID} tuple with appr=
opriate memory access permissions.=20

The change here is to expand that tuple to include a job id: {QPN, rkey, jo=
b ID, PD ID}.

Conceptually, one could view the rkey + job ID as a larger, virtual rkey.  =
(Or maybe job ID + PD ID is a bigger, virtual PD ID...  Or job ID + QPN ...=
)

> I think you face a philosophical choice of either a bigger PD that encomp=
asses
> multiple jobs, or a PD that isn't a security context and then things like=
 job
> handle lists in other APIs..
>
> > As an optimization, registration can be a separate function, so that
> > the same page mapping can be re-used across different jobs as they
> > start and end.  This requires some ability to import a MR from one PD
> > into another.  This is probably just an optimization and not required
> > for a job model.
>=20
> Donno, it depends what the spec says about the labels. Is there an expect=
ation
> that the rkey equivalent is identical across all jobs, or is there an exp=
ectation
> that every job has a unique rkey for the same memory?
>=20
> I still wouldn't do something like import (which implies sharing the unde=
rlying
> page list), having a single MR object with multiple rkeys will make an ea=
sier
> implementation.

I don't know that I can talk about the UEC spec, but the libfabric memory r=
egistration APIs (UEC has openly mentioned adopting libfabric) are closer t=
o a single MR object with multiple keys.  Different jobs could have differe=
nt rkeys.

Libfabric defines a 'base MR' and allows 'sub-MRs' to be created from that =
base.  So, there are separate MR objects for tracking purposes.  A sub-MR h=
as its own access rights, job association, and rkey.

Libfabric doesn't have PDs, but this model is closer to the bigger PD that =
encompasses multiple jobs.  A job is assigned to the MR at MR creation.

A possible RDMA model could be:

PD <-- QP
   ^--- MR (not affiliated with a job)
   ^--- job thingy  <-- MR (restricted to job)

A device likely needs some capability to indicate whether it can limit MR a=
ccess by {QPN, rkey, job ID, PD ID}.

I can envision a job manager creating, sharing, and possibly controlling th=
e PD-related resources.

- Sean

