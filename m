Return-Path: <linux-rdma+bounces-5346-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68635997B9D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 06:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56451F23CB6
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950771922D5;
	Thu, 10 Oct 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E28w7dtP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SO01ijiI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494F4CB2B
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533176; cv=fail; b=mqp//nW+TF0uU+FLGrPQk2W1UqOpfiMzOoD7W0zLopO3SjJ/JttYsyOZ2vfqKuPywnUprxN+zwNRJP6qoJEQHCg8TQs8txcAZ7p01nvW2ak8Eai8X1VZQM9IO78gHXdNe1x40Rg2hELHJrV16ptbmXhYoVTLCiuvkpsyFsqtNVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533176; c=relaxed/simple;
	bh=snb65KBNqk3v0UCXiN5fJmT6vgFX37YQQx9p6DWrUBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hywMXUiWJupFq5tcRwwAkV5YD1K12F511e/ZvO3inW8hg4fvyxcUmCstvjZiKUYvfxlZCf+AuIDne6FXD/lHuD2rVTBF5ZVzWRmhvzok4Gy550ZQ3Z5uydfBun58mYZZfwaklLLaAUJgQs5SyOyVMLcs41jCodMvqItSkkg93t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=E28w7dtP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SO01ijiI; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728533174; x=1760069174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=snb65KBNqk3v0UCXiN5fJmT6vgFX37YQQx9p6DWrUBA=;
  b=E28w7dtPrBnOod20qkFsEO6ybgRwP3ZhrsCo/kPNdUsWcTaqs6RUBkG0
   O+T+JsjOmQ6hfxmSzB19PFWStGumVPdzEw+fJdEW5lj23FtoSYQsLkHEH
   t73PkngQp0upw5SasV3xPx8KmODkM1E7DJprT6qOmD31LK7+fnrrHdGsW
   GDEv5KttoAxcmKMYo4nSu23zQ/PObMSTolugnRW7XvMluOXbKeExpkY+P
   gvAGdiMFXc4zm3uADMA1Nqxs7jqLHpHDcFfhOjaglD8mWI3wAT2gZ3MMI
   eUK3LVvyJcS/+DHdoJNaT58AgsVgG7C0Xy+o3A6C04QnZCkPMTJxNuVW/
   w==;
X-CSE-ConnectionGUID: iNXo9zhfRXyiB+54CvZBjw==
X-CSE-MsgGUID: Vkp0WAQCRwKQ6OizwLYSJw==
X-IronPort-AV: E=Sophos;i="6.11,191,1725292800"; 
   d="scan'208";a="29574546"
Received: from mail-westusazlp17013074.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.74])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2024 12:06:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQMyq/H2dVgyfLMIUVL0hmarMTSxkfe9GtcjQ3f7E+zkfUgFLsUVJM/Bz3EYyEeMf55c5ELcH0aEEwYUjDgRUrlnsXez2uZc46AzBUH0Ni6FMeBu8zL4gkXUAx7PHEuvPzmWiMeWDYppvCt8B6dBidrjb9CLTIXFzkQoj6h8jonUa/BCvvGfHRFbk5X5oUDkGy+lHVjVWXjj1CpMNC+bACOem5LqxPdkIBtIeHTGcxa9ZC4fRAIyAPUDWWQQpBsSraFCy/TKruiKDfrN2OplYMVAMijDWa8A4sFCftdEbewo9RT8jEtZYBnfkyk70mzQLnfifQ0yyEfAMCeUhEDJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX0AyotDV4Jilypew1phLLSfMy5AbqlfDVbo8P6P3g4=;
 b=TKCqM5hyeq/8UNG3C9pJZTSYFu8IRahlzlV2nig1Os8ebNnx3z9hYfR9oTZtl3mWtHsolsuHhP8SSosYo9FWGzWGo5ShD+M0/oBZTTimAxk85a6GAgF7W5Of7Ij0UuuWsEzTS6OgRNvvvIN+P4Dhr/xHooOeKf2d1+u/kXYbIv1aD96dTgiUwK/Z+fFj/OgWvtVlW4csDCPRzi3+rR3CQB9jtumJn9DV9xEJWxEPvi7dDE/m5MCwlD53nULykB6POrKziIkrxlorwXZNfEx88EdLIhDqtMfsI9DCnZG8icWdTFlqf/IFl48rGUe9nyQuZuFRQxz8JvYybIbhBRWPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX0AyotDV4Jilypew1phLLSfMy5AbqlfDVbo8P6P3g4=;
 b=SO01ijiIdv47feIrPFlA+07Lx1vH81P2VMsqFAcFaK0J7AQzObeP0YofVOtLfcFH815PJtzHVZL39C3IoIhQrhYYaH97Ew37/+rEnSi1OrDHve9SVRcPhYMxYeS67RIX4UF9tSo1S1/1u2iVnNRTj/HF8wCO25MQxeD6ZEEXRUc=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by PH0PR04MB7207.namprd04.prod.outlook.com (2603:10b6:510:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 04:06:06 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 04:06:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Zhu Yanjun
	<yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3] RDMA/srpt: Make slab cache names unique
Thread-Topic: [PATCH v3] RDMA/srpt: Make slab cache names unique
Thread-Index: AQHbGo5qJHv9N9ojyUKKE2tgMCETQbJ/XleA
Date: Thu, 10 Oct 2024 04:06:06 +0000
Message-ID: <3k4ltqh4zckmg6vot66zzkgm4cp4d3zhmxaut3tuqvxnx4vyim@4bakjleh3lg3>
References: <20241009210048.4122518-1-bvanassche@acm.org>
In-Reply-To: <20241009210048.4122518-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|PH0PR04MB7207:EE_
x-ms-office365-filtering-correlation-id: 408c6d2c-649d-4779-8e4e-08dce8e0dd42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r45TEvF/T7JAOYEWv+N5BTRZE5zSWcdPjVvVYu02CpzlG7QGwSNcdmWiBb9f?=
 =?us-ascii?Q?qWO9OLh3MxYEZ+x3lwz4IYx73LuD6mp1sQGMlGpcgqdYHZ352OYYke24qiwJ?=
 =?us-ascii?Q?wExdktdvb5cMdyf3sRb0hNdv6VIxa85zWPZrJrUW8w2IALleR/elNGTT2Yt1?=
 =?us-ascii?Q?2uviNoz+FZWVLImzYAvf8UWvWEzpq4PEQZ19rsnUfu4fG4/pf0A2Wm4zJEZr?=
 =?us-ascii?Q?HqpYvCbplwfL+TECUKjtFO5npflmhV963hGBPafsenLj8UDCR2XjMXBaPJMQ?=
 =?us-ascii?Q?D6rcs+UgMTtIsY0MXzxyw0vd3fRrNu/wmdWFuhF5NgZvwvurpg/ugM4UJ9FP?=
 =?us-ascii?Q?tGmhAG25LGaUlDHo4qM94AWr6mu2XjIKN/xuTPvmzZDpKrRhK32HVPUwh084?=
 =?us-ascii?Q?2b3xBM2JVzN5z1FsGtUPnD0oB0UR6VVJoEI09NXNy+4SzQrnRisX41PZ5C5t?=
 =?us-ascii?Q?1P5pvm83j4lg0c06Dmrct5uqrwoEA03v04X9YnDF61zC45i6vZ0o9gohvI28?=
 =?us-ascii?Q?nC4pinEfWzsW3IPhApW5NTOmsGqdRbEZ5AGpWUsbK1lM5WPug2MEmNffmdrc?=
 =?us-ascii?Q?G5zHCKLRKEkdcLqqulbty1XoPY6PGl/tgbgkVY/umHxiG00GIP7z0y9naCnb?=
 =?us-ascii?Q?Q3tVz0g/BhQQ3SXUWms7MQvzrc6S+OJ/fK8PphFaQ8or37fIXu3BCFozQaYy?=
 =?us-ascii?Q?DAd73sdiATrjEIm5r2+V7x0dL3se9jiQ2mPNbUlBWXpVS4MBRpiEwY+C47EJ?=
 =?us-ascii?Q?DQb7G8NRL4QYoak2FII4WhtKzAzS5UFDhhIDSHNkcuw4ZH4laoeJZJ5NUHaH?=
 =?us-ascii?Q?/+6hrmNcdeqcF+gY6VltmNM8OwOkuxuKv5mUPOyF0U7rniVBKfHVShoMRPc0?=
 =?us-ascii?Q?x+ahKFuuFxJkkI1oc8OhvPUywCdBGl1UZS2yn0AiR32ghJhgCIIyryxgggzm?=
 =?us-ascii?Q?CKN6BgRMu3DTcSkJ8N/q/1TVMaosHjqbHHs2oToqLm4GSdPl1diFdHGh/aLI?=
 =?us-ascii?Q?/m9BnTjWKB9Cu7RMs0X1J8/AtHYO7mhA3SOYfRo6tehxip3YFvCEF/3MDNrW?=
 =?us-ascii?Q?eI4hatjTFQUKrm+xpsWv95OhLvX9vpQOWV+yCEkZR/VjstLhlYu9LvMByJ92?=
 =?us-ascii?Q?Yo/H9P98qoOCKt5ivq3FpgYWtAU69ACRjao858IFyQBdTVX3H3icT8bXZLo/?=
 =?us-ascii?Q?1mGLg9znnFZbsiEYj5jVKs6fDVtyipUbSwmDRZy0E7AM/Hle1kbAyWrtZP1p?=
 =?us-ascii?Q?Aud6Q9JD/cl3wdZnexB+aJRVxKDgeBp0+QJH8VluE/1V+152wtto5JTn8cDf?=
 =?us-ascii?Q?pNzHTQTr7PJbwTbspSjHBem4gn23/B6GtqEkatXwPyYciA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2YaNa3LboiQR9nw0M+iu5feMcv9LJdlS6dH9SINIY23TUWJ5AvobxyTcO6kX?=
 =?us-ascii?Q?9JKFnExHCMqf74r/dgfhdmrNQHTq31P6s0orqPT2FhhxQFbhvUmV5CjLUoOx?=
 =?us-ascii?Q?m29K/NhCR0b4CmPi+AkgDSj6cuV8T5DOi8DvoIJW7Hh4N6n+EbekDyNC6cuK?=
 =?us-ascii?Q?5L57JOSBOC1CgtdvETvu8cy23at7LDv5dbOdU89OwXtqwuOa5wc5Jyw1oFxe?=
 =?us-ascii?Q?zYnt1QQnNrM2/ouTdbGuamGk1dGdhP1u797+6L2mzWxo7sHeZ0hdSZ4DjTMI?=
 =?us-ascii?Q?xOGoxgQ/BK5Iay/DsU6wOJELMExpqY9g3lLAuaiJ9tLRBX3FJWECzNoe+7ry?=
 =?us-ascii?Q?8JMYVBmu+3p/LatEzf3pSaHQlnfRurFmiygWrJUzRKfn5ckZnT3Fez7JRMoY?=
 =?us-ascii?Q?kAJNzVK5BUbfp0TYIDloLmsytCZCnsfy9t3PNcXisiEzmnIRgVNocFr3VIik?=
 =?us-ascii?Q?5GWJmnKCYAAH5D0U5O5bT7W9Viqhsz1EkUfHF9eWFqG7w/glsZJT9P+zf8IL?=
 =?us-ascii?Q?pS4PJS8Akl2otgxG7VozzQIqI4bc93eIudIImMl8pvcSNsUxydi6AHJrH/7i?=
 =?us-ascii?Q?jrXwpDMH1jthWIkfp/w2Utv9UTizqRLZsW1bV/KtnQAeFJl6/DHpp7PlQSTW?=
 =?us-ascii?Q?Mnpt6KoqOiBkg0tM0OzTk6KBYjL9ZEdL6PKwCO0X0aUcEuiZOrJCpeJUrTu8?=
 =?us-ascii?Q?tFd3RRS3PL6ozzYi05P16ThFvjMAkMq1dV0o2trDYuyXlcKFZ6vJglV+c6vp?=
 =?us-ascii?Q?SK1NCze2G27+IfNSH8UMiyvA7ajuaxHrFqZGUqVWJjqu6b1ehybrME24FsPD?=
 =?us-ascii?Q?uSGglFamG4jjeAO7CKYT3oOsiki2bYLV1T3hCW6MC+j3e7q724E60jjcWQHp?=
 =?us-ascii?Q?yHsJV2o18LNXnDd06l6VHbIloPS5OFUCyUPTCYZrF8zNH4dBWbCPbzYlpPfz?=
 =?us-ascii?Q?+K7UEcO7rwlIStNnbzBfeJ8koc8n3eWEFkNzOemgo3FARowi2n3GWozCq7sC?=
 =?us-ascii?Q?uz8N3B897u9SB9FcFah7pa1dr2JcDXRLwCDDDyORBF26b5qPqGW2VmducLJp?=
 =?us-ascii?Q?sjOuleHoyV2cIw4HW0eAtmG2683vVgkJ1sqlHVOG8lVL6jl4cRhXA62KBokE?=
 =?us-ascii?Q?9mklPd0UpITwapWJfdvTbbW/fEywZF5OAPP1CZMUhPf068dAuA+AT+rXTcvL?=
 =?us-ascii?Q?cqpUqy+vBYtY+VunyajEu623raTvArwIRi3Rkd6gvbDbDUtW+oJbnwTe2T2R?=
 =?us-ascii?Q?TDm5OLCcVjzowcN0j1xxJV2R8h1sJdzIE/VOP3tYadqhICi6ACIIKohy+KTy?=
 =?us-ascii?Q?Ulm//CVv3HcCdXOqckHilrUEbONp/fZxUr4FtvOqgoPMhiaSUhgNnXFiBGMm?=
 =?us-ascii?Q?bwK/4RcMhBXm9CqlsQoX7jxyw5vbgYrwH019V0Npu8nB58Sp1TeyXXljltGz?=
 =?us-ascii?Q?6TwIa9Axj1VeQtbL5PJSUSRH36TO9PRzZpl6GU5BsUig/vRp93WhuG2d2pSI?=
 =?us-ascii?Q?nFLaG6Vguxg123hrPon36efePDaF6JpTfNmx+DC78buYaw8DpA0DwgFxhYBM?=
 =?us-ascii?Q?9ulG4Ohog/vf/In5tAsAngbTg8yNQZztYAAdC1OIedJQX3yRyxo5shcRHmfI?=
 =?us-ascii?Q?vc/h0L7PcsQwOXC8q/Deqc8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3065C011C06B7A499830CE4D251ED43A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kcui8/hEqQ1EZwnaIJxv8wGNluZDijnqjFWaPfsjckRjSSMaxYosS6f3/pz69tZ8OjPWbNl00w5NybkO+d7wbrAaatgr33lT2kqjF8O56x/2lOO+SvvxoiMdZWo0JOPuZhspK4OxSGX13ErY0aVsvpKNhTIWmZyiJ5R3lIutsMuc6W1XjTiq/+BM/HrIW1Jx0tgG8HeXMC6NQnpKLz3kG0RgCBnfWTUiX+B2iB8048aGQmE07dCFpj951LGgVe66m+/hn3nkXVppaCCsHS4+rWb1Sbc7CbhDA6bO4O3LIJ6l+Y8sefbR2X7flDkPIzi5K5jHr1i3X4Pte4L4N2Czva5qXzAhHDX0X2cyYVn4C0W6mrXyD9FbgeOmQcRuVzZ5LHT7Uz7npf/TFnZDO9TBF+wO5AtvibNOVGv20k3HLoCAAccHapeuILZKTKbT/JnHuEBMRfBpke2xPW9xF0oAAF75qmNfZ/nmXzxOtbn69zbgucgwsoIGgeSHB8b7kCPwIlDMHCEVADxgluKq6pKYrVSvNJBpsznTGAwv5lvgKmCpOz8BcvwIxidYAaePita17EsUkAMDIOiUjNSc58BVHuQa2IVqMJm9Up6DXUCLTh35Ti0M3CTzeSqYpc60vZhv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408c6d2c-649d-4779-8e4e-08dce8e0dd42
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 04:06:06.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPsAHhowYlgR2LIqd6FPP/2jXhLWkZWuHQxHhavTpj9YHxLFFGxjYoVfqFKZTlJSdRuNApk5HmjlFUjfLe23d3C6Aix3CE5tnjyBnIWTUUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7207

On Oct 09, 2024 / 14:00, Bart Van Assche wrote:
> Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
> DEBUG_VM=3Dy"), slab complains about duplicate cache names. Hence this
> patch. The approach is as follows:
> - Maintain an xarray with the slab size as index and a reference count
>   and a kmem_cache pointer as contents. Use srpt-${slab_size} as kmem
>   cache name.
> - Use 512-byte alignment for all slabs instead of only for some of the
>   slabs.
> - Increment the reference count instead of calling kmem_cache_create().
> - Decrement the reference count instead of calling kmem_cache_destroy().
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjm=
jtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks. This v3 is good from testing point of view, in same manner as v1 an=
d v2.
It avoid the failures, and I observed no regression.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

