Return-Path: <linux-rdma+bounces-9590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67232A93B4C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DC28E26B0
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDEA2153DA;
	Fri, 18 Apr 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOkk5dRx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90926214225;
	Fri, 18 Apr 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995030; cv=fail; b=uHpKLGPAIhl+5yYc1Rykm7A3VBiC3qnJS7rLKzyNwXWbvbulwDz4TalGlyEnqXqlDZ8sJiL5NsuGCXmtHXZq13WKtZLTyM+iUXuENXDb17f0sBa5WVceI0OCxssF8eCMo1jY9N2ekv2UB0/4vucWX0mtzqU1npiwqgcT56ebH+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995030; c=relaxed/simple;
	bh=tcEk99UlNuxGsQjR7j7DkmkSW0+izkfUkJO5RcFaJTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKmgxoBy2vNHuiXaj0x6O4SyTMpOHn6s+FzRnURhtPrg/VcmZyqzooOocEzJuvrvu2JDbuXotY//Ccguy2uTC9IQDCEQ9+64Ml+byi3WasxjzXzuCqoU7g5caVa6UGUV/TTlANJ0vw/VWk9FDz9UqGxYO7RD1wHi1a01WlzqobA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOkk5dRx; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khZglBvmjINkYPYrz7SAiW9rmtH+FOoR4Aswrwvrfqv1I9B/yMdOMex+dC1lOpg08nCi6odZnOAdcwTbG7LCKv8coS88jJ931P7OwCRC8F6WZVASFtBxL5Xchn+DBFmVo2FvV93MiAwpmMFKVA86JfWCM4aLGc3w8pZNNhzmKKsUz6HgZMvIF34JlTgh1uNTS2+hVmN8dXBW09mFmvY91ttCdEsibA05j6Jq11tGZDuHMhRdMirGCFi7rbqGvodPiZ5vq7Sw90UvWG4X4C2UJVxWIJ0snPh1RmvFPSolrG08SwgL3JIEVVcGf8LHoISg9SjiNQJDA3fmibsfqrjNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOMx7JTC/OZeeaYAuUFQEFTVaTsTy9TIZdiHQBCZrbw=;
 b=OzgG3xQcsC7ZlrsTL0AO0XSEKoKb6/lMQq82rP3KmBRuFoOY3ssrCIpARyfFQa5HsrZ5MtcSzo829HDJNWgrPX/4RWg+7A7qSe6go5eKvR7RhXTMOnwiNgpB9EvGa1zLcTqQJZbf5LRYxxtWJAV4mZznSWfivkRCsqsP9gy8j1RqhRlh9VQjXvjIuoZAy2ZdtyCNaLBfaWeFKMd+HBiPkhVViwxKvLnAEbm7e8xwO8AjmPQkK/5Gwhh06WA7MNxEdCCkiDGVhWz9CZJxIv+oJ3zfxIeZPQUrC+yqy2mjYHO8rapR3cvMZE2M4aebbjwyxmRt8THIlzxqao9lxkK0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOMx7JTC/OZeeaYAuUFQEFTVaTsTy9TIZdiHQBCZrbw=;
 b=FOkk5dRxIcK2Da1qnBdz+koirnqDVkKaKWPA/LS6OBxzKVKa7tIZHbIm1EAum2dWnHmuEWxRSTZ5SvJ4GGFue8y5vKcTWVLyS6U1nMAlHMA4dFs0lV6o7FSunyctsR/mPGoVJMLhUWHSfXC0bAEqJPPCcRYbW7PiL/B6Mufw6S8qiAaSerjXPs6Vx9WEwWQ471WkJxM53+Vicp1GIWpUX9A58g55V14JvMgf6Jwd7PwEwfb1Z0JXmMEsmjOn2AUKZHzGev8W/0YUeA14oochGArJ+69TIihnGk1Ty4BmyTaDP7RwROaJJYcvfXFF91i0p0SbWVqZVWBgozHB1Kon5w==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Fri, 18 Apr
 2025 16:50:25 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8655.029; Fri, 18 Apr 2025
 16:50:25 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Ziemba, Ian" <ian.ziemba@hpe.com>, Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>, Nikolay Aleksandrov
	<nikolay@enfabrica.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiCAAUvLgIAAK6TwgABCwQCABHrAgIAAgVrAgARv/wCADl708IAAJ/AAgAAB6bCAAMnAAIAAa3zw
Date: Fri, 18 Apr 2025 16:50:24 +0000
Message-ID:
 <DM6PR12MB4313E0C29EA74A94748EBD53BDBF2@DM6PR12MB4313.namprd12.prod.outlook.com>
References:
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
 <DM6PR12MB4313339425CB8921299AB9CCBDBD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250417012300.GC823903@nvidia.com>
 <DM6PR12MB431337B52F88E8E22323E066BDBC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250417133156.GG823903@nvidia.com>
In-Reply-To: <20250417133156.GG823903@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|IA0PR12MB8975:EE_
x-ms-office365-filtering-correlation-id: 70b138dc-5d2f-45c0-0441-08dd7e991dd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uZ4Rw1/OzWeQYmLERIE2Xk71KoI1osMSUV30ChbHG1Sjfet32UpMPSeCq6qm?=
 =?us-ascii?Q?r4Hoz+jJ7LsQB1DDYIbnWuVT/d73T2p49P+t2WGedbMP8EocBCt50XIdsdF1?=
 =?us-ascii?Q?dPvIJxsTsOYKGEoc85XDEpaGuSXsDlc3MrENa7Jrd95XxqvOc0fFt3Sj7hUS?=
 =?us-ascii?Q?6WjBtikZcRGxDIwYrykKcStlK2Dr8S672+4vjrFQw1UGZ8KiCAn15z0EtTzM?=
 =?us-ascii?Q?e2GmaDcEOpaY5hNKjzXPBa6ZKQmDJMwdBTFeFW7WNQk1XnqtNWo92rHsYfqQ?=
 =?us-ascii?Q?OpxTyJ0JFYs1utFbWfK8Dy771Dzjkm0iHhGXRfxFwrtmKqLpP08d+JZbZm+O?=
 =?us-ascii?Q?HOu2G7sgCE6vNeRdSeRHYU+3zicwWVIr0J1E1BWNANw9ozpMvdLZc7idjOrC?=
 =?us-ascii?Q?zsNZ3LuTaR7/WNN5x0W5MexkSJvgG+0S8SUtUngznskM+RB5ACuRvWpd4mS4?=
 =?us-ascii?Q?sGPOfhnFV4d1GZeU7HplF1OTcWUyaoROyOToZGoETe1X4fze1k/oAW+HF0Og?=
 =?us-ascii?Q?hFUlAxUiy3oLNeTjF6AxRQUbFKcptQHSpUuMJKN8Q0MAl1Z2xful5Fj4kW9V?=
 =?us-ascii?Q?Qerr+YKSXpBJkzZ50RJb7gUbmExam6lhGv26Xf1PXNAIaiD7+RsevYmOJX5U?=
 =?us-ascii?Q?5if6MRJd2UC2duwTtSL7qYfEr0Lq3JLHj6Mb3sOQQwpCwBLXy50l0vl28Hkp?=
 =?us-ascii?Q?0CGxx+fCtNAZNqEwIEUr3IDYNVuLqkWdmShV2PzCmBMAu4qND29zT7c09JnD?=
 =?us-ascii?Q?r6/PSdIaJJDPe4xmRlyUDpUy3A2QUDyexNv94wLb8v/hEGmsSu1ftW/AvDh6?=
 =?us-ascii?Q?Te1A2dv9V4s1/LZSZZjGrzJ092aI5rwgM081g1pN5cE7VQd2rAabJPNTFshz?=
 =?us-ascii?Q?1NcE1+DJ2NdqefThikVK3i3O370gUX7cP97pJJKyid6P47+yJXNDbAZQjH58?=
 =?us-ascii?Q?RlTFaYegFfA4hFMl+L9MkEjkwMCpsrCbYkieMWbT/Kpbwt2Hn2gHTIEB6V02?=
 =?us-ascii?Q?OftEBKJu/D79DShQJDt6XQy+D4LPpmFFEzPeL2R9hFOhMe3BBozBUpWQP/Ic?=
 =?us-ascii?Q?rDc4k9eaEMNY1/McfAl3QidogmHbLM0DSNq1qBOJ5zwHivn041R/qb5uC8zU?=
 =?us-ascii?Q?1Grv/2nahJBSUm1PgPwIQWaP4vXtSQuYvPEHXWMOtQGAfmAdzPjKnubLHvZt?=
 =?us-ascii?Q?b0YwdQQzmIr4Sb7FrgBDfdE2qGT/h3LPH/2y8Lk8e2i0/QDpV22chLbxkNPZ?=
 =?us-ascii?Q?6X4DOq0KMkaske2kWjsw9m+vw/6wH3IURdevMIxbhaO3Q6qkz/+KtwLXRuq3?=
 =?us-ascii?Q?g0rrOo99t4+LJDZnmfu0zhWq/70Q2kc2wlLKlWJUY0d7bc/Ya7UsfmyJhKYT?=
 =?us-ascii?Q?wy/KuLJUifbY7cXJZ+TdZ0Xui7VeKLtJB2X0y8/ejcBKZJna3ZinD5DaDlpH?=
 =?us-ascii?Q?n87I1EXo7N9Wm1Y2NuADDSGkXr6JUyOZEkLuR+a7vEGF9jQ66GNfzpcPj7Mx?=
 =?us-ascii?Q?GbEbqrfyL8pKieo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O0ivOQ0dmju+HDQN0NaL4MiywHk2yASUWDfX1pFBdnMSzHf2c6EBg1vKU8lV?=
 =?us-ascii?Q?JSgH0mYWRa2jxQazra1WkNsWXAqCz41bibznUsA7EmX6XMHMp8HXeAjViS79?=
 =?us-ascii?Q?uX5I9Y/BovshLCT4NliBbiMHntguUzjLCiUHo46DSrdSQOgtT5xttAFYEPdZ?=
 =?us-ascii?Q?Vz6fkvMjKO9C/ekwQOx0+yRQWNSagP1fNtqiICnTcUlsHgIfF3UvTym2g+rI?=
 =?us-ascii?Q?4QEIViorp0TLFTVPfcJ/r6yAq9ViVLnz7eNSQWPIVgLBB8HfJRgEE31VRC2P?=
 =?us-ascii?Q?QxLRnFQJe+KtQsl8y6P+1Kbvs3DUogirTj9yAZqQInRFvm1VIp/06VsSqPq+?=
 =?us-ascii?Q?ME3JPYErjkXfB9APID+5C0C1+sOUvFd60LWTfkkOQRIiY3/4DvbAg4zn0Vhg?=
 =?us-ascii?Q?tS9/AJhUwDWMoF57LGhE5642lSIpQrvh5txczxBpL3fjbTb9UJQctdRNILc9?=
 =?us-ascii?Q?SMPVYiCDw+M3ly4vx7cBnUkH1SQ8q1naG16JtcNlSFnmhxH0LNfjSrMuR+Ws?=
 =?us-ascii?Q?PRFviiSMxw2hIk3IDTCoYMfkEAZm38pc//bWN3jfFoo3bdD25TgXV0hkhPSr?=
 =?us-ascii?Q?NDUgwuXCAIdFdq68DKzefJ4QKgzO6zh7LgHLulLCK2uLqVYRQtZLXgdzrj30?=
 =?us-ascii?Q?s9mGg3Nypustvg9+kcZh7A45bVbWJy0ezu3ZYtzMUXoQdst0OvvW0qQj5sa/?=
 =?us-ascii?Q?Aw9I3wkpyuWHG7GAEkZ44VGcOGNmkDHkish7Aot+X7a+Qil6xeofKO+Y2U1E?=
 =?us-ascii?Q?gzmFi+XDXiuAWSRnRPv83lYYxteHMKbIkAU+yplyFdGukvyx4GeX+YXG3MDO?=
 =?us-ascii?Q?PJkNDtqJvnw0UF5upeX3AL5INbI/g4arf4zI66cvYbSh4IG0drmIL8j3rwZk?=
 =?us-ascii?Q?aenv2PIMG6a4SPTgcgY5AXObIEFnBRKsWi2i8sFZBb91hYX/vNj6QlzLuJ+4?=
 =?us-ascii?Q?Yc3MwgVnrH78P6UYnmv6VSHMhGRbjyfwOUyMQSd4eCpQWHYF52LglgUYyIGw?=
 =?us-ascii?Q?UUgW/45eVfUaMfwaqnJGDo7oK24W4tg3LtP8Mg91IjwCQ3+1yClV1QkV6hht?=
 =?us-ascii?Q?z+0em7kpquhIkusOSJHS3HrFoXjjpJYq04oJm0NxMom2Iu7VImiDRBZLEfrD?=
 =?us-ascii?Q?sH1kSCsVjL4Wyhg4JcKB9IcA1mMb4XADuHjPrsjeQMG7E4cRG94vVlglxaRZ?=
 =?us-ascii?Q?mu4jJaO6iW/eXxGcN0nG4QbhgkAGoXWpu/+SbO9AbZTFvG3daj4sIUuNmL6d?=
 =?us-ascii?Q?nsa6HRyuVhfzb/giYwsea/eGIs0oLQGl4Jr3dGZFc+ywd3cB9NKfgHML1H53?=
 =?us-ascii?Q?0+bBw7VkInRkPdwCSbJ1N5jX79le+O2A2sE/4KVeVP3953SS7XrjjeTPERbE?=
 =?us-ascii?Q?dUoqUg6F3PAe6TlPTX+9lCh+5FDoiRo120iS+m4i9wgHNKZK6JbdMOXDwsq+?=
 =?us-ascii?Q?v8nUIZzN/NS73PHbLC+/isSbY5RWBuJzmD03YIadHBOYyxPx0h+EC/T2RtB5?=
 =?us-ascii?Q?4yuVHcw6u79yvd42YSJEBciMqOHdg+8O1rlFR4KsxrWNGwTEtYFOGTpXywx/?=
 =?us-ascii?Q?9QugjosA8RqvWgIGaSE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b138dc-5d2f-45c0-0441-08dd7e991dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 16:50:25.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyEI6seW8YnSb0lPY+y7W+zwbrAxvxI+9++Wjk3tPtAwa3G785trFRvRGMpPIVNC6GBRgiMkpMBfiB+qwzpydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975

> On Thu, Apr 17, 2025 at 02:59:58AM +0000, Sean Hefty wrote:
> > > I think the "Relative Addressing" Ian described is just a PD
> > > pointing to a single job and all MRs within the PD linked to a single=
 job. Is
> there more than that?
> >
> > Relative / absolute addressing is in regard to the endpoint address.
> > I.e. the equivalent of the QPN.
> >
> > With relative addressing, the QPN is relative to the job ID.  So
> > QPN=3D5 for job=3D2 and QPN=3D5 for job=3D3 may or may not be the same =
HW
> > resource.  A HW QP may still belong to multiple jobs, if supported by
> > the vendor.
>=20
> Yes, but I think the key distinction is that everything is relative to, o=
r contained
> with in the job key so we only have ony job key and every single object
> touched by a packet must be within that job. That is the same security mo=
del
> as PD if the PD has 1 job.

Relative addressing does not constrain the QP to a single job.  QPN=3D5 job=
=3D2 and QPN=3D4 job=3D3 may be the same HW QP.  There's a per-job table/ha=
sh/tree used to map QPNs to HW queues.  A multi-port NIC may need separate =
per-job tables per port.

(Let's ignore how the QP addressing gets assigned...)

> > As an example, assigning MRs to jobs allows the server to setup RMA
> > buffers with access restricted to that job.
> >
> > I have no idea how the receiver plans to enable sending back a response=
.
>=20
> Or get access to the new job id, which seems like a more important questi=
on
> for the OS. I think I understand that there must be some privileged entit=
y that
> grants fine grained access to jobs, but I have not seen any detail on how=
 that
> would actually work inside the OS to cover all these cases.
>=20
> Does this all-listening process have to do some kind of DBUS operation to
> request access to a job and get back a job FD? Something else? Does anyon=
e
> have a plan in mind?
>=20
> MPI seems to have a more obvious design where the launcher could be
> privileged and pass a job FD to its children. The global MPI scheduler co=
uld
> allocate the network-global job ids. Un priv processes never request a jo=
b on
> the fly.

My guess is storage is allocated and configured prior to launching the comp=
ute nodes using the mechanism being defined.  Once the compute portion of t=
he job completes, the storage portion of the job is removed.  I have not he=
ard of a specific plan in this area, however.

> > The second feature is called scalable
> > endpoints.  A scalable endpoint has multiple receive queues, which are
> > directly addressable by the peer.  Different jobs could target
> > different receive queues.
>=20
> That's just a new queue with different addressing rules. If the new queue=
 is
> created inside a new PD from it's endpoint are we OK then?

I.. think so.

> > I've gone back and forth between separating and combining the
> > 'security key' and job objects.  Today I opted for separate, more
> > focused objects.  Tomorrow, who knows?  Job is where addressing
> > information goes.
>=20
> I don't know about combining, but it seems like security key and addressi=
ng
> are sub objects of the top level job? Is there any reason to share a secu=
rity key
> with two jobs???

I doubt sharing a security key between HPC jobs is needed.  I think of the =
set of addresses being a component of the top-level job.  Individual addres=
ses are sub-objects, if that's what you mean.

I was thinking of security key as an independent object, passed as an attri=
bute when creating the top-level job.  The separation is so a job isn't nee=
ded to apply encryption to some RDMA QP in the future.  It seems possible t=
o define security key as a component of the top-level job (and give job a n=
ew name), rather than an independent object.

> > A separate security key made more sense to me when I considered
> > applying it to an RC QP.  Additionally, an MPI/AI job may require
> > multiple job objects, one for each IP address.  (Imagine a system
> > connected to separate networks, such that the job ID value cannot be
> > global).  A single security key can be used with all job instances.
>=20
> I haven't heard any definition of how the job id is actually matched.

I define a job key.  The job key provides a secure way to select the job ID=
 carried in the transport.  A job key references a PD and is specified as p=
art of any transfer.

A job key may be provided when creating a MR.  If so, the job *ID* is store=
d with the MR.  The PD of the job key and MR must be the same.

With absolute addressing, the QPN finds the QP through some table/hash/look=
up.  An rkey locates a MR.  If the MR has a valid job ID associated with it=
, it's compared with the job ID from the transport.  If those match, the tr=
ansfer is valid.  This check is in addition to verifying the QP and MR belo=
ng to the same PD.

With relative addressing, the job ID selects some table/hash, which identif=
ies the QP.  Job matching is a natural part of mapping the QPN to the QP.  =
Job related checks against target MRs is the same as above.

There are other ways these checks may be implemented, including tighter res=
trictions on what MRs a QP may access.  But at least the above checks shoul=
d hold.

Generalizing the above to remove UET addressing, a QP may either receive fr=
om any job or only those jobs that it is associated with.  A QP may belong =
to multiple jobs.  And a MR may be restricted to access by a single job.  V=
endors may optimize their implementations around which features to support.=
  E.g. limit a QP to 1 job, no per job MRs, etc.=20

- Sean

