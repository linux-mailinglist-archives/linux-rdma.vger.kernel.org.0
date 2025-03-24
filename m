Return-Path: <linux-rdma+bounces-8926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67FFA6E5AF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 22:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7733B3C8F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF81B21BD;
	Mon, 24 Mar 2025 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t2c3Z5n2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB671FDD;
	Mon, 24 Mar 2025 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851705; cv=fail; b=LnA98+lsgzY/qi05xPxngdfAc6bSUd4Chrf4LvCwa8X/qS6EPvnIFKy2XiaNS2l/dC/vmxYVnlek1lvqGwKQsiZhwfR39/BMHSHfRnhN99fHe7ztbCUowZql5nSDZlxBTWWMfJ3/LbxB7uCQ2a0yiK/I2sz2siW2n/1Pm7bVR5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851705; c=relaxed/simple;
	bh=JR7JcgrGCjhvIdnthj0heTNm49ua/VHtsZ/6chaM1Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nx737fWqKwL+zUgBFjLDgay2TGamx6gfMBHBJyEqOkk3Q7sJq6zZn27gEA1E1x5eq2FVUFgI7BXIakWb3LkSiGwQlsd85x4Ykbq1piv5xcGV8EcOjZP8CpY+MRJukVj4O2tB4IEsavIrp09E9e6MPHBv14EV+6z0oN2kKhJtxGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t2c3Z5n2; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVFNeUV6mww1DV1vN1dqqjJlZN5YIjoXdXp9i87SVCn2vTdcxtCSar0/zs0vL4SfpMUG8DE9q/n9P3BmY5TP2X4dRXLRZG5n6libF1DdOJZbyQk85iJVQjOxIMbAk8JWhmb9Zx3SgputjcBBtvZGcEzI8Um1H/ZdI2S93U4c2VrP0S3Ru5nCNzSrc47vKOeXve+bP2/ev2yttfQgZ18O46XXlPNH3w8vnhHp10Mjh4tB009MpRMKOrx/Rm/8iRwEL72RQ4QpF9V/PjLBmKBgTs3LWD+Ivh46/lcBHOlfwBrolu+DZgdF/m71HGrnNpGpDa+Cj2PKherIzQBheEPJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR7JcgrGCjhvIdnthj0heTNm49ua/VHtsZ/6chaM1Jc=;
 b=CYe3wg7M+jmHnD7SDUoQGsrfCzEGSpHRDx1LNncuDJJYMyzrb287LkpRnUK/VBe5VMU0yhyVdLUIM7G3KG3A4uD4FAzTTGu7fbefkNUDSgRJiox6Cx1wZPXLEYnzrIWB8zarvQqDgCeVF1HC1cDcohMKR8PK9/8c7x2eFoPWh+HIFUYc9/OYM7rAPS5knZoe6hbj9e3MHCf4O2+GXc2IgG0NUJXaaL4N2QNumMM6qZqvV7xn/4sTDKPF4du/gKnq3/3YeCrtLb3cO5psy7fBbXCq7U8BquGskys6wY3F3PN3DJpAFVa2Z20Igy4zjiFkjwQHae09Qq+v5c5+nfs0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR7JcgrGCjhvIdnthj0heTNm49ua/VHtsZ/6chaM1Jc=;
 b=t2c3Z5n2X5Ha7TIPL4gyIGX5AVor++Hvx7WkWnClO0aQUM6fRkHaLizth7hKOM9yvOCDjbmlCoVty1P0zG1cygijTXf3KDLqxrSY6DSDwGvVVoljcSzGbG1fFqfye+hEbPAFnT8QVvORKl283zWrJ8eChRAwmT9Znod9yH6JYt0+megNo6mn3FdCZIQ7BG0CTG1eMy/hYHc2GFmpzhMCsUwUrU393/G87rwiRBhNze6MXAldxmw2cba/BsSWtMSo7mNKVGeB5yt1q+82lw28uekeofOxcUpH6xKIHxQ6XlH2anhAH5zZ38HY7ygf6kwX97nF6I7P4CFMhDrBZM8DVA==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 21:28:18 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 21:28:18 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Roland Dreier <roland@enfabrica.net>, Jason Gunthorpe <jgg@nvidia.com>
CC: Nikolay Aleksandrov <nikolay@enfabrica.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>, "rip.sohan@amd.com"
	<rip.sohan@amd.com>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"bmt@zurich.ibm.com" <bmt@zurich.ibm.com>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, "kheib@redhat.com" <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	"davem@redhat.com" <davem@redhat.com>, "ian.ziemba@hpe.com"
	<ian.ziemba@hpe.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index: AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgA==
Date: Mon, 24 Mar 2025 21:28:17 +0000
Message-ID:
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
In-Reply-To:
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|DM4PR12MB8560:EE_
x-ms-office365-filtering-correlation-id: 3eb1a822-53ea-472b-112c-08dd6b1acb40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWlMNGJpMEV2VHI2WEJaeDllNktjSm9xSlNXalAxR29wYU5QdGRNZWF4NUtq?=
 =?utf-8?B?V2lBY3c2UmdxQlczdXlCVVR5NjBrakNJU3ByN1JabVZyUEpqbXhMSjJGL0Ni?=
 =?utf-8?B?L0VtYWYzU0t2dmhjMVJJYUpGRTd0R1dDNUNDRXRoaWFWVHRTRkJuZ0VVKzF1?=
 =?utf-8?B?ZHZaa1pBenhSUGp5NWtZWFRNMzZaclhMS2RhaDYzN0xUOUZSQVlNdFR3dVJX?=
 =?utf-8?B?S25pNDJpVGloc3ZWTFFiUU1IcVBNdVJ4dmZMcjRBUUwrd05teW1odlVONW4v?=
 =?utf-8?B?TEk5L3ljdUFjTThvZyttQVlzZzAwdHkxQjZQYmJTY0F4OVcyaTNJQ29ZK3VR?=
 =?utf-8?B?Mk9TTVVubmpDaS95WTBMcVY4UTYzMTBHZ0JxNWtsTmt5Zi9DSjZVNytWMTVk?=
 =?utf-8?B?blUxeHBFdHdZejhjdlNwSjlPdUpFSjV5TEhWOXlnQnZJcUlxSm5vWkdpU2Jm?=
 =?utf-8?B?UW5ja2VxNlhvWWxsRUJNZFY3RFRaWm5nQno2cmZzVUtQUVA5amxsa3Y1SHRD?=
 =?utf-8?B?Z1loYlF1ekF5WXhKUjlwZG1MYkZhQWxDaFJsWUVKdHJVcUhtd3loWFd3M3Yx?=
 =?utf-8?B?YWg1WFdiWUtzUTNTYXZNL2hUOTFYZm40SGRYWWl4THpFRHJiRVBweDFydjc2?=
 =?utf-8?B?VkkyZTFHZGFkYnZyODhZK0dadmhHV3RJSDFKQTljNzV1OVdKSXFzcUhwNkN0?=
 =?utf-8?B?UjNDMGpqTU1ibWw3T3BQQWErdHFHRGROSzRWdzdmM3FFS2M4cWRNQnJlU0dn?=
 =?utf-8?B?ZzAyMUFqVE9Rb1k5b0hTM25kejlicS82aldRZ080OWx0Qk44WGQzUk4rQ1VJ?=
 =?utf-8?B?OVFTTG5XL2xVNVNOWU5tZktVWEk3UXZDT0pjSmNUNXRIT2NpdUV5WEZOSXJi?=
 =?utf-8?B?c2szbHgzdm5qQTN2TXNseUNvSlhDNE5ZZlk1YVFRcVEwSFJ3bGVKb1RaS1ZJ?=
 =?utf-8?B?SWpMREpZYTlKR1ArSFBFZFF6ZlF1ajhjQXZjWnRZTXRucDhIdDQ2MENFc0dn?=
 =?utf-8?B?MjgxM2RGbGUwZFNiNFFidUZxL0d2TXQ3U1lQWk1FWEZKa0QySElGcVVpVmF4?=
 =?utf-8?B?MGNjV0dOMXc0bndyUVNaZTdRcXo0WkI4dWMvODNQa295Sitad2VoZ3ltMFpk?=
 =?utf-8?B?cGxzcjVlalFzMzVUK3E4bklqSHZ6bmhKaGJJc0NPMEhBUnc1WEtRNHFGM05r?=
 =?utf-8?B?V01SK2hwKy9JV3JUZlRkbFN0bGw1aUNFelQxeWRPZkFQQjR0MDZ6eWtQejNr?=
 =?utf-8?B?K0pQNmFiQ2RFQlFHV0lXVjJVNEZRMmlyWkhEZ1UyaEdFVlYwWlF0ZzNYNDRu?=
 =?utf-8?B?bERGYmNWWnBETHVLWGRHS2JVbmIyVDY4ZjBpWXNIY2RDOWEvLzlCT3dpc3lU?=
 =?utf-8?B?b1pETmI2bFF3UWRlcFhucXJENzMxTndCcEFsTGxYUE5tQ0lvK2tmNHJMSUxG?=
 =?utf-8?B?MHcwZnZXZ0MxQi9idmtkMGpPdmZ2ekNvMENWbmphQ3BUQVdXSy9QY1ZYNnIz?=
 =?utf-8?B?WDdTdzJWb3VrdlVKYjJsTFBSZGlZZnBSYWZlR2tCQWYvc1hjM3JmWFRQeTZE?=
 =?utf-8?B?L21UQTNxUU1FUTI0WXVISC9pQkllK1J0UTRMYzJZakxkNHBhVEw3Z3JiRWVS?=
 =?utf-8?B?ZjRjaGY1dXpTdzlxeGtBamNEd0dHMnc0Nm5kTy9NYm5wS25TdVA4a1M4N2w4?=
 =?utf-8?B?SVlBRXJzT0ZoUVBENERReGJ1bk04dFN4aW53VFB6RCtZM1VhQlREZXZsclNM?=
 =?utf-8?B?aHByMnM3RDNUcU5lVGpnZ2t5c1Bud2RXUENMRndXaThla0JwOHlEbE16RWdx?=
 =?utf-8?B?VjRvWURpUG9hekY5T01XdldKWCsxRTBOd2o3a21scTREWXIyTzR6QzZjUlVD?=
 =?utf-8?B?VHU0aW1IU1VSMGZVNWNCaTRHY3NIK0pSQTliSUVjdEpoeVRHZFlsVGVhYjdL?=
 =?utf-8?Q?bzqGtUReVqiB2X5c2H1mqQwtVx3ZlX+2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW1IVXYrWGtCZnNYUytCSGQ0ZUpaUVFQeU9Odnk1Z2pmeklQQUxzR2hpTjNN?=
 =?utf-8?B?L0VJNVN3dTZSR0Y0cW1tU1dRc1hSZVpxenFFU0g4aGtaMTI3N2FrM2JsVUJI?=
 =?utf-8?B?WkxSVFc2NGg5Y3ZLenZRd3p1TnYxQndqb0g1Mkt0ZTh0V2Z5NGcvM1gvSHVH?=
 =?utf-8?B?N3FmTkdRL2Q4NGRaQlJDNjFYWk1kZHpHcm1teEZOUi9CUjVrY0N4QnJ0RFR2?=
 =?utf-8?B?T3dMMW02ckRlVXZvVldmMW80R2JOT2h3dzExeHd1K1RWa2NySjN6SVh4bGRm?=
 =?utf-8?B?bmNlcm1WNjNNNVNWTlNIV3ZFL2ZKWTZIeSs4dlE3aGpoYzloOE5Kd1R3dlNO?=
 =?utf-8?B?V1BZSEprbFFWeDVJUzR0a0JtWG5OWnlkK09NOHZQUUlOZjFXdmFNU2hpcWpt?=
 =?utf-8?B?aUVDaVY1K1RtYWd0Qzh3SUx6Y3Jyam1CVjRFcHh0MGxNblI4SkZFdEM4SElC?=
 =?utf-8?B?NTFwQ1VqSkxmSUdWRHdDaStiVUY3Mkw5TGRaOTdWdGhvSXRPcjZPZFpITE9N?=
 =?utf-8?B?Q3ZtNUl0MTFReUxWWXVPbTVhenI5bnRJV0Vkd0NmK0t5N3lkRnNyb2lrUnln?=
 =?utf-8?B?RFNwcGp0b3l6T0IvT3l2a3U3c1VZdnhZaHFoUTNnTlVGN25uN0h4VW9mZjNX?=
 =?utf-8?B?UzYrOUdXTnNkbDIwbjFObkk0YlBrbmVMb0dvdTJWRDFuV0x3OFRJdmRsbk9W?=
 =?utf-8?B?MEIyN01sbmZUclVBWlUyNUJQd2VLQnJDdVNqV1RTdlZ1ejdxZkNaWERCWEF3?=
 =?utf-8?B?WXV0blgzbEtPVGE3VitMSExnSVNNeWxBYlpUVGxMQUdMMEdUZmVTREU2Z2FB?=
 =?utf-8?B?UnNEamgzUEtkUUJPbUFpMHFhTTJqRUVrSzJ2UHR3S1ovTlV6blpjcXZGb2x5?=
 =?utf-8?B?bE5wekRzZmVDS1NZRE80dENtNTVKYzJyQXFidzlKblJtT0RZdzlkY1Rrak56?=
 =?utf-8?B?ZjJOQWpJTkxUZ0hjc3F5YjI4V0VCWE5KVkJsRnJJUnRQV2VoVVFldE02MGJU?=
 =?utf-8?B?eG5lbEZCSXB6SmQ1UDgyNzVlREVqQjVKK3liNFFQeHNwT0doRVJhalZzY1FQ?=
 =?utf-8?B?cFZIV3daQXFRZ3hjSFh1cStRYnVVc1JPSGV0UFpBSHJidnhnUmo1bHpxSW02?=
 =?utf-8?B?S2dla0wzTGZhd1BkTWFSQW82OXJBaDVyNW1DVWhIM1lERG1PS01FRHMveUtC?=
 =?utf-8?B?Y0djaitFaXNwdXlUbGZMQTVQZlhvUWtCaE1qMkNXbStOREovaDN0a0I0RHFE?=
 =?utf-8?B?TFM4L1lDaitZZlRTNUdmUWE2RmxHK1N0UHByOGl2RkJoRTFTS3pJSy9TOU11?=
 =?utf-8?B?RTFZTGtHYWdTZkFYRi9EUTNKellTYmlaWUtmNngrVnpsTkk1MGVZVDh6cW1l?=
 =?utf-8?B?aFRLS0hORGQ3OG8yWmVxVk1MTGpwbjFCeFV1Nk9hM3RUcndhaEVabHAwTHRx?=
 =?utf-8?B?bkRDb3RFR3dIa0tUNlJKaHVLUHVpR2FRQUl6SnVXMG1vOEVVZmdHOFBBdzJy?=
 =?utf-8?B?b1U0YnAreTZNYUVmSVhvaDdmcDVOd0pFVVhmbS9lbWgrY1l1U3pYK2pTb0p0?=
 =?utf-8?B?d21Gd0V6VExHTnpHTWgzVzZoM2JYRDdRYWJJNkVmWkNCTUg5SDF0My93N05V?=
 =?utf-8?B?UkZLZmRlWFZnNTVtWXh3KzB0b2QxNFhVQXY3OFVGUkVQbTJWbW00WEhRNHBL?=
 =?utf-8?B?S2lCSUlwSFRZZ3RDenhNRWlIU2xBeTlReXd5Z2ViM2E5WjJETVU1U2QyM3Ns?=
 =?utf-8?B?ejR6eFdoK0VYcnRHenhpcElPMFhlYUZucmI4ampYc3JEejd3SSt4Q1ZUR2Vy?=
 =?utf-8?B?Vm5nWlRPNUV5K1FrU25md281UE5CTjMvSHhma2p1VnpxRm1yVE5PSit3cVpu?=
 =?utf-8?B?UG5uSVR3MGFjTFRoQUovWSt6WkE0THhSR2pQa2tBRHVPRk5yanhXOWdCRnp3?=
 =?utf-8?B?VVZrWU13dnVHL2hmc0tzNTVOWkg3OWhZdWRvYVNPemJ4WnJqTFUrZ3E2ZTVS?=
 =?utf-8?B?R0dRKzh5TTBucUZqQ1NBKzlCdVpyZ05OWTZGMVkydld5K2gvUUppK29QeVA0?=
 =?utf-8?B?NVdCaFhaTmNJU3BkaGJiUGY0dHpJRVNtbXhEcDdVT0RWb2NxTEhSUjUrY1R6?=
 =?utf-8?Q?J0Vk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb1a822-53ea-472b-112c-08dd6b1acb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 21:28:17.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00+tWDMqU+bYMj02UFzSJbZDsBYKdBS++CTQ5qdAqiTj+ML0EZNQ4a+Eb7zD3f89abeqEDDXkn/J5BwFjUlPpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

PiBJIHRoaW5rIHRoZSBuZXRsaW5rIEFQSSBhbmQgam9iIGhhbmRsaW5nIG92ZXJhbGwgaXMgdGhl
IGFyZWEgd2hlcmUgdGhlIG1vc3QNCj4gZGlzY3Vzc2lvbiBpcyBwcm9iYWJseSByZXF1aXJlZC4g
VUUgaXMgc29tZXdoYXQgbm92ZWwgaW4gZWxldmF0aW5nIHRoZSBjb25jZXB0DQo+IG9mIGEgImpv
YiIgdG8gYSBzdGFuZGFyZCBvYmplY3Qgd2l0aCBzcGVjaWZpYyBwcm9wZXJ0aWVzIHRoYXQgZGV0
ZXJtaW5lIHRoZQ0KPiB2YWx1ZXMgaW4gcGFja2V0IGhlYWRlcnMuIEJ1dCBJJ20gb3BlbiB0byBt
YWtpbmcgImpvYiIgYSB0b3AtbGV2ZWwgUkRNQQ0KPiBvYmplY3QuLi4gSSBndWVzcyB0aGUgaWRl
YSB3b3VsZCBiZSB0byBkZWZpbmUgYW4gaW50ZXJmYWNlIGZvciBjcmVhdGluZyBhIG5ldw0KPiB0
eXBlIG9mICJqb2IgRkQiIHdpdGggYSBzdGFuZGFyZCBBQkkgZm9yIHNldHRpbmcgcHJvcGVydGll
cz8NCg0KSSB2aWV3IGEgam9iIGFzIHNjb3BlZCBieSBhIG5ldHdvcmsgYWRkcmVzcywgdmVyc3Vz
IGEgc3lzdGVtIGdsb2JhbCBvYmplY3QuICBTbywgSSB3YXMgbG9va2luZyBhdCBhIHBlciBkZXZp
Y2Ugc2NvcGUsIHRob3VnaCBJIGd1ZXNzIGEgcGVyIHBvcnQgKHNpbWlsYXIgdG8gYSBwa2V5KSBp
cyBhbHNvIHBvc3NpYmxlLiAgTXkgcmVhc29uaW5nIHdhcyB0aGF0IGEgZGV2aWNlIF9tYXlfIG5l
ZWQgdG8gYWxsb2NhdGUgc29tZSBwZXIgam9iIHJlc291cmNlLiAgUGVyIGRldmljZSBqb2Igb2Jq
ZWN0cyBjb3VsZCBiZSBjb25maWd1cmVkIHRvIGhhdmUgdGhlIHNhbWUgJ2pvYiBhZGRyZXNzJywg
Zm9yIGFuIGluZGlyZWN0IGFzc29jaWF0aW9uLg0KDQpJIGNvbnNpZGVyZWQgdXNpbmcgYW4gZmQg
dG8gc2hhcmUgYSBqb2Igb2JqZWN0IGJldHdlZW4gcHJvY2Vzc2VzOyBob3dldmVyLCBzaGFyaW5n
IHdhcyByZXN0cmljdGVkIHBlciBkZXZpY2UuDQoNCkkgYmVsaWV2ZSBhIGpvYiBtYXkgYmUgYXNz
b2NpYXRlZCB3aXRoIG90aGVyIHNlY3VyaXR5IG9iamVjdHMgKGUuZy4gZW5jcnlwdGlvbikgd2hp
Y2ggbWF5IGFsc28gbmVlZCBwZXIgZGV2aWNlIGFsbG9jYXRpb25zIGFuZCBzdGF0ZSB0cmFja2lu
Zy4NCg0KLSBTZWFuDQo=

