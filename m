Return-Path: <linux-rdma+bounces-9734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7706A989F6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 14:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7757A7090
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949426C39E;
	Wed, 23 Apr 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ByPlBnOa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDB19AD8B;
	Wed, 23 Apr 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412093; cv=fail; b=g1M/5GLzezbQYpYV2vBN8odV2E0WUELgJeVQNZnUk51yuDUNsRiI+m//32sZQQ38G5vKxZknj+kuL8nXmTN8+HyTsFefk2y8yndFQHVVt1GfJRhMJAJLbu9wzJ3uDLiZtdNT10gYb1mAbNjIDxCKhLrMwAYPB+ZRo5D6aiup8xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412093; c=relaxed/simple;
	bh=UmV//M9MJSdLvUy8kEoDN/7FdWxl2BEUedsD2MDqcig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GGfAYbyNykYCGZ46pyGl+VjZTWsV2YKg5bkIXKlPKq08ivga6LxmFbFZgVawp6HTdVfgfjD7Ly3HIpfV8cMWL656lhZNVQwExyrgwwTIopGZjEG/FEWK1RGK8w4IDeIT+mASh4IuQ26MwgN07Q2PziNt/hVIgFa8iJW3y6yF214=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ByPlBnOa; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKZOZkRRRUyWTXBGYlGvazsE61TRCvVE84bwWsP3p5r0heJI9at7zkkmDCHVrpJDiFmn6yYy8B3Q7uNDWBn9CfEDWTsjfvBg9cyaVDfg6m+/ZSDIOhce4nHwnJmScCrBRku70vtYCDMMeInPMzxfzGfRbmTQSAEQLtrwWRrDNApzcVXNqK2RQmG31lSva/XooARvVnwfGTBoRwMVI1Vw4uTimgbLl239XR1Fcpmruu5Yrny7pqSDYZ+lwF3XswYi0MavuHZEKnf7+CHCWJPRWl59Gu1kDj48n8hHzmXWHyE074DNv4R5p5YCKs8VV8e6xD5LYzGsscZ3kG2AJfXtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOq5CvDqYYc+ejfQMtnTec1hrv860ortYenzgyNsmmE=;
 b=pWjzugd5hbHW7VRz/IWIeNzP0ffVwBKglXiojx01clQAS1f6fWykrXNXAuzmwkHT9PnP0mUWrCjgqFPuSd7fBd9VLfPIdx+D1FEut1co2XOEaicm/Z1oYfW7OKRyXzPRmoRcIbHpmDL72tDI0T/hCBKeyhy4tgcJH8sQ4sN+yxBlYwEBuYf0HNGUqQGfoeCIl24iMccklhPElrUNSzsQBMdZf1E3AR/S2n1CDBsC7A6AEPu2MzYu9ktcdgk6JRmErmS9eTB4/oqluxJdAIB0M8Hpai6a1Xp/KuqbTKR+2VrPb+Jat3lHvqTAZ9TlyH8QHemndJTSujEHWkizb6+Grw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOq5CvDqYYc+ejfQMtnTec1hrv860ortYenzgyNsmmE=;
 b=ByPlBnOa8leT8J3J7l4M+T/cyKM4dcOn0YhLtlYnzcfLv/9FHjgpI5XdwhaEC/nKP8WdNKbkuV5YS7dMqjDOJGSMrGQ4r7RG4LOTsFtw9PvVQlPDlbutThiXR8UD1wiNaQ/VUxGAK6eBRop14Y5PTYTmp7x+WGoZlGN02HbVKFbQPOSquft63Wlh9EkUXkoEl5QkujS5swYPcCfRxLZhXRzA3qsrgHHnD8aSDBo4E6utA0TMFgqT7I0uIMg1ikSpzZM9NKw/8miARqcDj45W7RICgzdwnyrgjiD9GNhuhjDRPPsM4RlR5lQA431UHgF0CXFAIkoHLzTcKNhAvRx74g==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 12:41:27 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 12:41:27 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQ
Date: Wed, 23 Apr 2025 12:41:26 +0000
Message-ID:
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
 <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
 <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
In-Reply-To: <20250422162943.GA589534@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ2PR12MB9116:EE_
x-ms-office365-filtering-correlation-id: e82b5a15-8ef5-4726-6430-08dd82642a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j+Iu1074a4JeVYmHH2gjSCqAsCvdR0p9w2TBwm3gfW28MGOy6pnPjVsJkqA6?=
 =?us-ascii?Q?r98KsBoeHWRi24eUTYAK2DEjoYziHwJbbkMApng4eAzmU1HzhjMxBJFo3Smo?=
 =?us-ascii?Q?KZ3oogHMhmRf3MhYj9rEC0FGTBTrHRubOEEfECWpVYU8cfGrWtHmrLn8qazQ?=
 =?us-ascii?Q?Q+vqIxdcFO+uBIvTS+fbEajFgnvqE1TYqATsQR89WpY37+7UmCjbliffHHxH?=
 =?us-ascii?Q?/kcIcKIyYfHvateUT2MG8DumbUhp2p2GU0a+o5B2E+EMySFrS10gSg5N4iaF?=
 =?us-ascii?Q?vzJhZA2pOkSeOtiFvU3GItFQLbzEVLkPj05cRgUM2vtXmhez1q1DXtsV7BPp?=
 =?us-ascii?Q?GIfR5rnT45mXkpJ92tYiWZb6ZiexQxfnbyK4xn69JE+a2VXSsNDATLhD6jdl?=
 =?us-ascii?Q?2uSsteEk0TrPcJmpW/ArnaG+knGJFcDn68WB9TNMIBn5ykzkq44F+hIPz+UU?=
 =?us-ascii?Q?yNsb1ExL0z58vRlVmGtnHLLaxm6yk2Rc+z1g3ywb3otVLuu3UNUH3zBqwl0a?=
 =?us-ascii?Q?NJa7iAP1EFUpBoJe0ExAlC/Blrrncdap1zOEA4UZaHI5GHnYDOlNizcEkyBE?=
 =?us-ascii?Q?J8F9iBkIyz5m5qz4KzkjT/x3JBEkaJnxnqOt0u5RlZng35xBhbf1SyT74qpr?=
 =?us-ascii?Q?PDTwpeMKqvbckNqNmdtSrGvh7IgZ727YJEsq71eOPh5ITbLqH2/XyyMB73O7?=
 =?us-ascii?Q?9UNNcAlEMEHb+DVq07kmIDjuQzGtbWrwBpEC1+oX0rP8aNPt+AkrinNC6urx?=
 =?us-ascii?Q?CgNm6qCWmd7ltPhv16ymP9fA+WTc/Be8mTJWuGxdFtwLNXgpa2g24LrK5OXN?=
 =?us-ascii?Q?+qjLyyP9XyE9bXBp8VmW1sFZcdnozxCQM/PioXRkl0QGsQ3xcGx0PqhdZuf7?=
 =?us-ascii?Q?l1iQ0cqTKJybwcq6nt5FUxnSPx+p6TOX31F9lU73GXxSV6bVUVRSEhuBP+4p?=
 =?us-ascii?Q?yWlwmcoZHuQnBLbvX2UYRZzY8PMJYcgOPaIOFzrYGPW5N9On5dPVzpAQORhu?=
 =?us-ascii?Q?ozg6/yeRgosxNXIwXPYKLC4O1B/80l+6IDfPK+hktkPcbaiKH3hQr1k+a21n?=
 =?us-ascii?Q?MSqv6h9HEm8SviciRP6VGHJcIp8NgDmY2oSCsVHXcZ1Ef+nC6/9hRbE8nZZA?=
 =?us-ascii?Q?pi9Ou7gU9dJjYwhwsVBAge7fpPXhFJTUFV1nDPkJw57HAyTogzzBRsaPxvlq?=
 =?us-ascii?Q?itWZ+NBxmt8Y3cCRZ2mGmUncmEr8+/SP8NzSr7zQ7S1NOZvoRB4x0doeq/Cx?=
 =?us-ascii?Q?TfcEht8CAzNTsdudtazPzgcyM8dJ2zuAqsNdMv1PSNSZHvvZXPCF6ZXS/20z?=
 =?us-ascii?Q?F32IaUEHHiShy8jlxlBnSCRn/6p/JjPpa/Yi51eSW7B1df8MddyWJP1J4Lz1?=
 =?us-ascii?Q?Il4bXTlQoeFJSVxIgSW+g1Gq2/C7EQ39df4Lr5QxREJUyu+fzic6dgWYO6DE?=
 =?us-ascii?Q?OJivZuOMCRpT/6WAfWkl8qZ1Ciq6Su+Jh3RwsenTs1L6DynZEsP6/A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kSfw/DQfcEFfR7XqYLvA+rsn2Y+uuTJcb5J+9OlWcWBQoHJVhfUq7P8YxXkP?=
 =?us-ascii?Q?iMlqW5wfQj7Y/VVTZ7XS2RT4h6dL57Iq7oKJD+orDxX3/o66knpPIOlRxzjU?=
 =?us-ascii?Q?e9wSta0/JRQBLsa06Y46bl14+h2i90NaIUuBycvKUAosJmjy0jqyjTnmQwi3?=
 =?us-ascii?Q?Yp27HftCD9yJijCqvSgxNvOW/S8shT2W32Y6hnnxJnfk8ycu0jmy+NgBr4dZ?=
 =?us-ascii?Q?U667uMPk9Vsr67iv3gBoWvwwAMl7FHqcgQt1n55kdIB1RQXBVcEOirF7y2uD?=
 =?us-ascii?Q?FQdMW9xBU4JS8/Uw2LPGkHWpSU0++d060oNjh0zlk9RDigJXt57Iq/Z6aKgz?=
 =?us-ascii?Q?wfPkagAOmG6Ge2JFIrIgikJCgEbLH6jxuPJy/r37HJyuE2WlFqOEO9miiH7+?=
 =?us-ascii?Q?bwVnTP9VgKj0+kyx0wwDJhB4oyMTOsjRuBDRNNXw3j04nHNkfrOgGEepGU1v?=
 =?us-ascii?Q?vDaR3ziT6IN8WxAi5saL3Cp2u3dGByK5E43ZhEwwXmG4STT0PfreNjggWBoK?=
 =?us-ascii?Q?QjaTDhrQbv6rHUMzJAcFB3rAphNlhtT3v/5LyMAWoqDWMTKmROO1ZzyvrxEo?=
 =?us-ascii?Q?B20rKVSemeqUND1jPx8BkQ6aUbKLvj1HQyj68nVfnR/QKuItxrKNykHn/ojD?=
 =?us-ascii?Q?bsr20R0OQtnbo+E3BuxIS7kqV9pA394XaM9Rwg0Gj+fs6BHT/5A9iXt/3GAR?=
 =?us-ascii?Q?52La9J51WJX1EYBoBXtaviYb6YUPa619CuHmpmDAFRhyeQj1OerW82bIh1Wm?=
 =?us-ascii?Q?GgIK0N814I3zQF0aGbMSnRPCbMqBm/sax1HhRSyRKc6u0XYTrQCv+Qm0zanA?=
 =?us-ascii?Q?7Me9UqxiZNvE3/BgVD6vy9OnVgpIAukl74qVtP331tMNaYs6OogFnE56ot5f?=
 =?us-ascii?Q?UHfwFIHswT+71uKR4ZgoQvF4uzuKAcYpEfrPnphxfrn946t4FH2MzIcP4QsV?=
 =?us-ascii?Q?KmmJQj9Uqj+lokO8QiXgROh7+a7Z8BuDiQCNGBl6lNEJhrnwpv2XefWys7s9?=
 =?us-ascii?Q?tUko7MJCAfYs9XN6zwxWf8cJu71bcyh4e/dqCS5npN2IQeehYFPOb2YM+Xb2?=
 =?us-ascii?Q?6FNeIL3ewU5kRCVED43IPNP7VwJmsStP7SO4q2La6dHKeVK72zpK/9EXiT3x?=
 =?us-ascii?Q?a8tq1bxaYOyH3JfzJ/IPSUDnm5OdKofVVzFhZOBn4gpWlLunINXpO46Yq1bk?=
 =?us-ascii?Q?f/Id9n9ndzJcs6ii6VE46S+2qZa3LUhPuhFb4TDVFt8QeRT3KfSGbWYz3gyA?=
 =?us-ascii?Q?aMcUvvEdWHsjdqZNllP/YUir5PfXxGAZc7kpfGkrzUVgsne8j9/4gOI/k41V?=
 =?us-ascii?Q?sxhxqW5lonYy+oCNvltx7T4x7SYzzspsBP6ZyD8V/zrPCzqHd+NM3uHuRKfS?=
 =?us-ascii?Q?YSXDRAjOlvUeQq2nmbscJsuvbohKRHvWOoZhj4P6bF7aF5BHtKbDEJhQBNGJ?=
 =?us-ascii?Q?bFT9hOfbPNsRjDBfKWVZjIEpA/f4gOOFUoMGiK9VzH1w5wBTDCHv6PbgOzGq?=
 =?us-ascii?Q?MKMxUxXo0Dhp0+rtLBzmZN+gP/BO/vVWIIP99qthUBcE6q4Yu/FQqlz4KBZ9?=
 =?us-ascii?Q?DUNPwphBFTDoTN8FgKZT50bDby/LROHYH9JP4n4rUEvne67JQrDiw5BYs/uA?=
 =?us-ascii?Q?z3Vlddj3Xcl0Ctetg94i1LyWwnobOhJxqrd9GJbqCreX?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82b5a15-8ef5-4726-6430-08dd82642a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 12:41:27.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: of2QNr/y2EMLdRtjudQYxE/ovH5b69c0Jmn4RZASpBIEarQp7dyaFXj2z2+uD1OeXdAFuKyUWADUorYHyzq1mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116


> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Tuesday, April 22, 2025 10:00 PM
>=20
> On Tue, Apr 22, 2025 at 01:11:27PM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 22, 2025 at 08:14:33AM -0500, Serge E. Hallyn wrote:
> > > Hi Jason,
> > >
> > > On Tue, Apr 22, 2025 at 09:46:40AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrote:
> > > > > > > 1. the create should check
> > > > > > > ns_capable(current->nsproxy->net->user_ns,
> > > > > > > CAP_NET_RAW)
> > > > > > I believe this is sufficient as this create call happens throug=
h the
> ioctl().
> > > > > > But more question on #3.
> > > >
> > > > I think this is the right one to use everywhere.
> > >
> > > It's the right one to use when creating resources, but when later
> > > using them, since below you say that the resource should in fact be
> > > tied to the creator's network namespace, that means that checking
> > > current->nsproxy->net->user_ns would have nothing to do with the
> > > resource being used, right?
> >
> > Yes, in that case you'd check something stored in the uobject.
>=20
> Perfect, that's exactly the kind of thing I was looking for.  Thanks.
>
It means uboject create path will refcount and store user_ns,=20

uobject->user_ns =3D get_user_ns(current->nsproxy->net->user_ns);

And uobject destroy will do,
	put_user_ns(uobject->user_ns).

This will ensure that in below flow we won't have use_after_free.
1. process_A created object in user_ns_A
2. process_A shared fd with process_B in user_ns_B
3. process_A is killed and
4. user_ns_A is free is attempted (free is skipped, until uobject is destro=
yed by process_B).

