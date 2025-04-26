Return-Path: <linux-rdma+bounces-9825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C536A9DC99
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 19:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EDF4A382D
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Apr 2025 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644B25E45D;
	Sat, 26 Apr 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W+Zjfl9a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022091.outbound.protection.outlook.com [52.101.43.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1825DCEF;
	Sat, 26 Apr 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745688626; cv=fail; b=FZObrRplv9d/Tc8WET0RqHDVAoFuTIUzBDtKyGSR453FI/BikAR6sS17huaHuQqNaLPTCQJ1d+oBZIGgWo962BJAhCNzC/lkM4sbv1P6OIfKTkhbPUS2URR77HykLE2UOxEF2teIi7t2cE3cNPFaHBgxsdKg1e9cDGX4ASMdGtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745688626; c=relaxed/simple;
	bh=YCVNXXhptU6D3abMKsMssAPTppIoWNdqg7eFkPrBfyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9RowoPlq02b1wt/45DpGHsaL5qi7GJiqmeF5nWvoQoqURiA0U+nAw5E8CQcM6AT1bi4s7cyJd25zEnhp4ySdb+hz8SijUcXgbVycK7rObA6EbNfIWqewRhJMY9DgNxpvsowvS1gMm5rvtAkV35VXeVAnX4umIRXRdz+J0ARrpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=W+Zjfl9a; arc=fail smtp.client-ip=52.101.43.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0B/5eYRJn4IZsC+7VM+w94Oda33ygSJdGyo1V4ysgURmN4RhdCSQfCtAw+76xSqwB7mWw7AE0zPJpZbPOGgybdMxUyUBV2mzJZklDQei/RY2CgB5rhgU0bpKOdXYXBXhlFzEMn9PL3lNYkDMTcFA2yYjwN+2lVNS5AAZ5+/ACpYTRlUc36OMzUWlN+T4TwGtaUYcINIRhHlrTFkKkRSSGrapodcg4qFE6BWH6L6ddUXDOqlqPOtqHaIRbmtlzUupdBcryGTbUhndT/N5ai0hYmDvkH9z/a5B1GDj6xWF6fNuwR+87Aqhw7k2U8g20OlDFkRuZBKM8pxT7/0oBbkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCVNXXhptU6D3abMKsMssAPTppIoWNdqg7eFkPrBfyY=;
 b=cbSAA8YE114CbfaGZ3WLBcfB2ThsqURh0jk3cTZZTqrHVkMKWhakZhIgaJEcJVcjo/sq5XCMXhTW4ETxJtV4aLZ2I2qsPxCZ1ZOBu1wig3A1Gt+Arvp6PPulB4/jyCTKPPTn4N87Y735YNYeyi9Scttqxha1h25CSoEeqpXNHSMm+usatEkE6aa2dfm/nSyJOCKLTquj1qHHAMh5AdS2HvlNA9u3cbzN2iGH0dAiPYAJfUBDzst8YISs+beHQyi9aSz0QPk65tQNkMsX7Rz0lkn5gjuSNTpOlcynqKlgwSyRJtlgHYIOtXjLT7QdY0wmwTtjx15iUS6EUkfojzB/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCVNXXhptU6D3abMKsMssAPTppIoWNdqg7eFkPrBfyY=;
 b=W+Zjfl9al4/lqIMPIlnvBMhG+SPormGtBQzVPlIVgrXrtVkID/c5nPenagSuw8t2X+hAc7V5Rt19JOu3ZSFuEK6iXlAblJeLuZjrP84E+jwTcXoNeR+Ib4PPDL00gB4TrGlUe+0vcew4wA81j5u1OwEFLocYxGQ6L0Fh0HdFLSw=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by LV8PR21MB4159.namprd21.prod.outlook.com (2603:10b6:408:266::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.17; Sat, 26 Apr
 2025 17:30:20 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8699.012; Sat, 26 Apr 2025
 17:30:20 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 0/4] RDMA/mana_ib: allow separate mana_ib for
 each mana client
Thread-Topic: [PATCH rdma-next v2 0/4] RDMA/mana_ib: allow separate mana_ib
 for each mana client
Thread-Index: AQHbteYaKwNI4nneEUSohFsvBsnxbLO2NUhA
Date: Sat, 26 Apr 2025 17:30:20 +0000
Message-ID:
 <SA6PR21MB4231180CF3D14B3FDFF4E5C2CE872@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1745587777-15716-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1745587777-15716-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=694ac127-dc85-4241-acae-3c0c19f11973;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-26T17:27:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|LV8PR21MB4159:EE_
x-ms-office365-filtering-correlation-id: 2b06f0bd-76fa-48a4-bb05-08dd84e804d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uuyRyULqjcszmQ1sUxF5YNc5Bk5NP1I5PpPHGtaHMHyMx95SR/hvmE5jwVH6?=
 =?us-ascii?Q?CeXRaTOQj+doE80DSC1RWtlm1NfIMXs7cwQz6rUAQVwqFF9bMPY8wx/THuxe?=
 =?us-ascii?Q?GmlsBExIquSPUcAayxunACBhE6rkwVg4pXmZ5v9qPHph2v/E36tTWv0MnU50?=
 =?us-ascii?Q?BDR/E9RGMraQ7TZR3vtQnpV3RkXXd0fvOxXJx93gMxGpV2vV0wj6gf2gnk8j?=
 =?us-ascii?Q?2hzZCtmovAVGP15P7+BII8lf1wRenssuezzPJs63aYUtJYnH8apVgWr/Zh8Z?=
 =?us-ascii?Q?SXmcIROstqa3h6qXccGAv4uFfwXNxVO2Wk565pHjOaZ9OqErt+KA5fmKG5Hu?=
 =?us-ascii?Q?8AfHApUJ1z16lPDHjvQ9kIAwOLEi9rSYqNf7s39R2+syt4PJaDXO8/DRQVjL?=
 =?us-ascii?Q?pPIZXH0T2c1yY7RqrPbwwYNCmX+oImVViyYiinbCSLvzWWab/UBnE6tYnhJ/?=
 =?us-ascii?Q?GVyvVN50po1BdIATrPB9tvWpzttlMx1yITZxacp28WzzGZn49FxNJkHDYYua?=
 =?us-ascii?Q?yL7Ve6kkaDsMl3yDlH40dnIyNsBKJllt9g4E9lENETXg0emcO1cy9K0W7XY6?=
 =?us-ascii?Q?IkuSpfP9pruwq3V/HNZ9NvQoLMXK7G+EbfrCa562gadvnI6ICBL49FW53MnA?=
 =?us-ascii?Q?N+eYyorKpJ+kOb31PzazlboDbkHS/pmtsquiV26wQNkHhvv02ksCVz3bljcT?=
 =?us-ascii?Q?zNePYpymg6t/Vv6H85ayYibfG5vmVSpVmp0kpngyLDw8DbYvdOhmf6AJZiyD?=
 =?us-ascii?Q?0Eoww/IUBxhOlWI0AzVjrNBDGUHfdQ4V+6OnOnbZHYgrJwIzjMiru5ERKSWR?=
 =?us-ascii?Q?XziN+Dig6D75a8zz7jBDcOwIJeJiKe5HciVYCgq/RL1vOoU4fgBe4Ehhc2Zq?=
 =?us-ascii?Q?w6GeEGqLwKGp99A22D2S5PMhw6wUE/Z8ctT4CdTSrZHMO095Q1si3seeBJkq?=
 =?us-ascii?Q?f/hF9jzGsooRkNryc3H4pEC+qvUWVS7PLE5yRYUHmOxIXwcugKEtYF/x19DA?=
 =?us-ascii?Q?AuJJdgcFT7ImOshRM87TMsU1Y2Yr9+kyB3Ku8RMoYsi0a+jy9U+SZCSRpK89?=
 =?us-ascii?Q?xJ+xPBLmZLmdC67xmp37U3AZnqIS5NN7Ybi/N4E/ucPW5ckZSEMkSRK0wr7l?=
 =?us-ascii?Q?N3yh7rwtRz7SoQTfFmd92ijDXBEX0vFwdWOrEtVwYEgCzWITzj2vKBrZe1TW?=
 =?us-ascii?Q?xCrdqBcEwRzToYjfT1MFmATPiu5CaSDNlDAYziQN8YM9t+95UE79xuxoQhLL?=
 =?us-ascii?Q?t3ZYi0GzCBEZINgiUjlA8ZOy1kGo4ST1Cqb8SEwQU3yo7S0KBG90LP7U3KI9?=
 =?us-ascii?Q?MM0swvY7zQES3jsEkxd3FoxTqJ2TcoLsjtLnqYM+43o6oKOS2mNXbRZ5xS06?=
 =?us-ascii?Q?DOPOWQOLZvsEqtHXfb8WQ72L/unzQ+ekGJLIh0H8IJ2E9gqHlK5oL12SgeVQ?=
 =?us-ascii?Q?6IgbVNZNA5jbF4njtYp48rcocMztgaW9PXxvpgMf/z+EyvEYe5nDF/dMSNyI?=
 =?us-ascii?Q?Ni4gzsxD7gGvBWg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xiIKxoG2y3PPL/5NFSCRxJFHba6hBHcbwTNoDFSfN64602XjkAMihcG5jGmX?=
 =?us-ascii?Q?xm9E/J/zpqTGvevTxaTc7L/XKa2YPjj0VirWc+5lIE4+GXR2V3HxUXxRH0Dj?=
 =?us-ascii?Q?tKhEJrJ8Xz7ojssbaVPlcBJ5r5jleOfxu20BKMFsSs4gPnl1FvzE+IV4q5Es?=
 =?us-ascii?Q?88kNYNeilv5JTQ4HJ6wSLpIF8jvSRiK+K/OulNgMJO/SwbmDQt8uOsELB9+q?=
 =?us-ascii?Q?dfwg1vfkweTNaIz/AfI6BQ/Li3J7EM/pjiCgyj0z70QSpyOOBUHtcyQJ0Gux?=
 =?us-ascii?Q?2RhdkdITMwULc2xFSu4XrCanSUP277g3UlhX7dWde/Q1NFERoNJzs6WEXjnK?=
 =?us-ascii?Q?ZgjDgx1aUoOZQqOix7LzsX85prnwcWFpqWuBDtSggs0soAkgvd+8TMlKgmlS?=
 =?us-ascii?Q?FUAMZhM1EzLNYG5U0nRgUnZthfvEcd2VrB9idrFnbdFEtG1kvEBx9liL49Wj?=
 =?us-ascii?Q?nCOcSfNXyQXVD/mQ8VQlWp6tTBybYNVk/MJEOG/nzoGceG9NP5gFKneQRz3Z?=
 =?us-ascii?Q?5tIcTY1MjYqMK/qTogVLlLyTIKwAz3muZ+COdop5drBDZKiaUO8ceQfK5+iP?=
 =?us-ascii?Q?cD00p3m70U0l1S8HZ397TXSjYRrOhbxLS3In2eICbpyGVynvOX71Vk/RJ5T1?=
 =?us-ascii?Q?EB0I7URvlDP1fEf8MP6DoZD76mWrHPieNQg5Lg0tm3eaY8iHTMa6i5wU5n2j?=
 =?us-ascii?Q?xhP8bJ935XNZaTwOfSB5Ox7pngkXd4SCUe4XezvQJjzGBO2uzF1oaIglXdZ0?=
 =?us-ascii?Q?7Tb4tpJ4kDXoflRwodGHqelxcAIdWS2liT38WuAuc8SuSwIPvlCZiJAkil+r?=
 =?us-ascii?Q?J+yXr8JYjX5IF4iM1pEd9zP/lt0YPaHrOxKbCDyvV7BGjTzkofaHt7Oub+6I?=
 =?us-ascii?Q?TSvew3lx+9ynYtqXBwEA+aZ2okRjOUR1VdsjR3ZayuVGbrpbQuqjoMZRxYwm?=
 =?us-ascii?Q?fRGvsnoWMUJJSa1UD01RgyaXDIn4phkoaBwtzlqjSydevyW9KatKTGLC9WcU?=
 =?us-ascii?Q?OXXxsHwhSoB0H85eFMF3Z+FODCJpYW35fftG6qRJJFQAGiMc4fqOqVRJ6H9w?=
 =?us-ascii?Q?nS17sYZ+z2SAccrM1qdJDFMQ+SNRrslCZzRxqSVCAd1YEBfpSontorDhW9LT?=
 =?us-ascii?Q?LmJipRvD0MB9mnJxrexM4G5LiB64SW0UnO99Ssu8nIbf6vW77X1gFuz1Lz7f?=
 =?us-ascii?Q?CCXDGxsxi891nbouwXhoYxtNsmA9hP4/9CbIjOjrnwri4G7bUVakViK9v9QI?=
 =?us-ascii?Q?mKKBtmHqcZZV6Y8z8y2YIFtbct7MMU8bTTBUBWFW7A2ZBPpelmXXaJLT125W?=
 =?us-ascii?Q?yGlhiDRz2FK48JCAdPi0vAXmIAMnOn9oBtzE7tIni825S8WChWOKZ9Tzh7Mu?=
 =?us-ascii?Q?oMMZVz89KSEPhmFdEBXy5TCRIyc2sfhPX71Xp4QRQLJiyFc541k8A5AL/X4U?=
 =?us-ascii?Q?KQIJfmzg06+y8fgl69eK/9ZO2r3oSWnLSbi76nEOz0mzinDr6W0Mg0r98rKg?=
 =?us-ascii?Q?yp2HJfUESF2N0/QdLgRGEn0og16zQjIEtqMZSLNX/IG6NEMX+QmyOCW7vzKb?=
 =?us-ascii?Q?TYoTQVSH3qQU0rIF3blv38Gsq91nSYL5a4Hyvpzy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b06f0bd-76fa-48a4-bb05-08dd84e804d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2025 17:30:20.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V46MsPXnsZHD84RAleoecyg1okQhyWxkuL9UivbhpvC05DAzFBq4CfADMiG8/twXYoL6HvWfkKtqHs7G3co+XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4159

> Subject: [PATCH rdma-next v2 0/4] RDMA/mana_ib: allow separate mana_ib fo=
r
> each mana client
>=20
> Microsoft mana adapter has 2 devices in the HW: mana ethernet device and
> RNIC device.
> Both devices can implement RDMA drivers and, so far, they have been shari=
ng
> one ib device context. However, they are different devices with different
> capabilities in the HW and have different lifetime model.
>=20
> This series allows us to model the aforementioned two devices as separate=
 ib
> devices.
> The mana_ib will continue supporting two devices but as individual ib dev=
ices.
> It enables the driver to dynamically destroy and create the auxiliary dev=
ice over
> RNIC, when the HW reboots the RNIC module. Without this separation, the
> reboot would cause destruction of the ib device serving DPDK clients from=
 the
> uninterrupted ethernet HW module.

There are test failures. Please ignore this patch set.

Thanks,
Long

