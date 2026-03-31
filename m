Return-Path: <linux-rdma+bounces-18839-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCmdK/PDy2mnLgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18839-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:54:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27D369C3F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EED830513E5
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324113E3D9A;
	Tue, 31 Mar 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kLnvwaGr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B51382F10;
	Tue, 31 Mar 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961059; cv=fail; b=j5XeCbfMPqwguB0O1+bPznVyVKbR1u+43sYbDgZBkabQVQ8l7+rawXrMZKknOd1kxVQAUP20Wqa1RetylRIh0OxctyeIwlJc0mqzi5jH5b/0RObY3sq4nVQx3sxeSYpb/sSdnzG2r+v3nKN1aexTcjEyGNL0ALwUJ30KH3gOPec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961059; c=relaxed/simple;
	bh=s39WTAn/kUXBOlfPODPNualxTqdYIiv9sRe42eMZ2zc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/2nfk18joQBJdvk1LSaH45ODiyiAnyEkQ4zCdiOHkfvQZ4GxYikFZEaVAbD60Sgylje+BpcnQIqzOm6iElUPGDy3sWj3PifMJnzscx7lrINBkCRqZirpCzs90fgZncumBqxtO6ItIHz12U7659H4Ahc8JkV+k8ZooFyXcZ+zGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kLnvwaGr; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sezHNFJw6jXZQEUNorJd4vrP6WU4XYHobX+Y+DzmjTn7q0Lr9m5rxreoZbsrAmyD1vfjhJkB7Ie3VYMK2GGsCXNK8hkMq+wsfnMTfTsa4HXLXeYAhm0T6Wu2qfJvYoPxvqysvrAaGWzz6p7tedKkg8LfhyMkIVCDwW0HpqRbV6N/YSuv074P7c8LL5ijd+1rXAZiiSJzPxVs+US1Ffyi14WY5V0Os0HpxO/i0L29rlCNO69INz0V8EQiWJtlqpLhj3S0QyGvcGrq+fUpn/qoOGalt82nRKMJZvZBNDub7b7xiHwvWTbPbK5ONTpTkvTafHsb9zyR13BNaG9AgQSpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s39WTAn/kUXBOlfPODPNualxTqdYIiv9sRe42eMZ2zc=;
 b=TtiA3tTegTLN//8LbnUtULhFE2rLderYRrjItUPqN2m+Rmzn3X0iQ9ivKxce4J5xRLMOHwFj9M7zTgQLI6t4Nj2TM14lLYrPpeKOQli2LW2j/cH51+9usCUhOCFl9LXSgZtiTreXGIl15QucZIfIsAW6GIUpbm63hO2zwxSOhuokr0VehPhW/HCeQl9KjY19UEELQRrSQPwR0bNfGCSmTMm4DOlbyXfu7vwyCE7wiI9ePT8+Xkahq0aImLWiw/YQx+JAortsBRBKyd/is0MyTggpg7++zsEJWPSUFoSJj1N3KtylRg5ehSsMfimdns1tV/l5sPdbBNi6m3c42X2vaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s39WTAn/kUXBOlfPODPNualxTqdYIiv9sRe42eMZ2zc=;
 b=kLnvwaGrFPqbXn2A8OzRC/UmGJ42+0qf6CvcGxMXzZFUtEk+aTH4Ad0eJhd7TE5gBvpXjwqQitl+0UKMv4YUwGskA3vpykzVAW1gh4cKYp4Rw0wVUI7X2MXs6yw2uQM3Ekfcrj2minryCPuaOcpkbfNXa+PXzTSHkwiaNlTpGFNrr6so/Wz1KpJiBChVzC67GiLBk2GrtXhg4Zzc+RwDEVScRoGnm7U6kebNQx/DyPqb5nvsq381SG+Eq7BvlK88O7+m5A4kfbd+Ud0G+BKw1Azs1KALjiFXasdvg7kwwTJCi7JmDvyzIbhwkHmxvzzHumpOvB0Qtq0fWsI9Kcw7iA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SJ2PR12MB9243.namprd12.prod.outlook.com
 (2603:10b6:a03:578::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 12:44:11 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 12:44:11 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "allison.henderson@oracle.com" <allison.henderson@oracle.com>, Moshe
 Shemesh <moshe@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matttbe@kernel.org" <matttbe@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>, "kees@kernel.org"
	<kees@kernel.org>, "willemb@google.com" <willemb@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "razor@blackwall.org" <razor@blackwall.org>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, Dan Jurgens <danielj@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"minhquangbui99@gmail.com" <minhquangbui99@gmail.com>, Nimrod Oren
	<noren@nvidia.com>, "dw@davidwei.uk" <dw@davidwei.uk>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Petr Machata
	<petrm@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"antonio@openvpn.net" <antonio@openvpn.net>, "mst@redhat.com"
	<mst@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Shay Drori <shayd@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, Gal Pressman <gal@nvidia.com>, "joe@dama.to"
	<joe@dama.to>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next V9 07/14] devlink: Allow rate node parents from
 other devlinks
Thread-Topic: [PATCH net-next V9 07/14] devlink: Allow rate node parents from
 other devlinks
Thread-Index: AQHcvO5rRrjolvz4nUOt2X6O/VODgbXH7JkAgACxrIA=
Date: Tue, 31 Mar 2026 12:44:10 +0000
Message-ID: <f71dd96cf32d312ec80f5ef74023e19eecf8c8a5.camel@nvidia.com>
References: <20260326065949.44058-8-tariqt@nvidia.com>
	 <20260331020814.3525053-1-kuba@kernel.org>
In-Reply-To: <20260331020814.3525053-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SJ2PR12MB9243:EE_
x-ms-office365-filtering-correlation-id: 2c23d613-7bd3-4125-1063-08de8f233516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 i7HY8JaoVxLFqmSjcnUrA/A/nfeFQ5jcWLpEXUzm64ktZHxSlko+OqbCE/fHKDJDzkDi6pg9Q+VF5aPpDltaBlmG92yyLey38m6SbBOFb4jJQRyWdIVZdrQyYj/VWSvfIoT4UaWsRJWXVLxpt7lpJWmPI1xwDbHE/p67eyaqJI19JZ+u/LYOcMex7EoJwjyCrCRZmmanEqlcG7UnsOcd03PK2URUJ3LgV1T2FeQJaA0+4PWdACnPumW6TUySRbMtm45oqPG/dLBFkxUbktJXkY+1LydCugJoCs63HAIjAlHNuGWF/6P6/Zg7+wAsy8gMbQmVAMvMpm5zDMc61saqoA/uP08LaP94Dccrx+FDK1FZQfzI4HUh32/mL4wDZsDWG0ntL2FLNkk/3irfeM+TN/nIgOcVxp8uPFrGkQwu1fsrJwbgSJ8iJzX5Npjg83ZSQg2ihbrBPEcuFEwKp6wDqGawCmdlwKkz2lZNkm3L2uLIVcCtXQxqHjjZWIwJ1rGc2X3V9RI/AlXCKMOxndklMXkFfw2pkfQGhSTr+1Bp969UvrNzAcpENBdyjQeTghgxyr69ESxUs9VEQpBT5GgEffpsnEoGM1Id9SeOCM6jht6ajwOp147tcc2bgzfO+Us8QQZvOTt/6Yl6tcan/RYl9tDO5ejlMfYrVdmDzUCaPHqmE9BqF/MCxrCeaVUFObwO68k3sh7ejdPlNu/viFDj/yf/l6I2JPllqfyAlvpyUsqEOriNFWb53UCvbNQ9C8K2o4ufxJFcpK4v992p1mgwFUgrAMR098XN3Qp1Mywi8VE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vk5abE9PVzBWZUR0dUlxSVNnakFlRkY3WHdlVkw0Q1BqbmYwQVlVWkFUZ0NY?=
 =?utf-8?B?M2Z2U3ZlTnVjWXl4R3BYM2dXOVlkVW40TTFvZzBZKzhtUkdGNmcyWHFhd0dh?=
 =?utf-8?B?WmUzTjNxWWNXa1k0aG9iMWRRbk0rbEVxT09TN091NjNWRG81d0FnbGJqK3lT?=
 =?utf-8?B?Tkc2UndCMkN2c0pMWVlRdlZad1lyQ3IrT0M3WU40R2h1NUk3YWFGT0RMWWcr?=
 =?utf-8?B?ZnA0dzE0OTVHREpSbFI0NE9rQ1dZRmhkQ243N2t5M0h4SndCbEJhUVcvVi9T?=
 =?utf-8?B?M3NuckZNYkJ6RUVuYVcvR25zVElJYmczdGZONUJYTXNJWlk3aHZValAyc0JG?=
 =?utf-8?B?b2ZlRGZENytoREcvcXBUdXp4MTB6QmVoci9tcDNacjZ2U2F6TGxCSzBFMHhG?=
 =?utf-8?B?N2xZZHVvTy9Ib0NRTFptajRBcGw4UFFlUzF0QnY4dHR5ZTFZY0haQ3BaSjNj?=
 =?utf-8?B?ZUNWMWtGVEV1MVdQZW15OXpuN0J3Q211aXFoSkRibldublROQUloZkM4bUVu?=
 =?utf-8?B?SjRDWTNlMG9lWEQ3QmUweDN1TGZBNStqbE1XTmJYTkl2THY4cy9jYi95U1kv?=
 =?utf-8?B?ZXRUKzEvOGpWckx6Q2tCUlI2KzNxL1hpTFNqK3FybTFucWdWVjByMllOU3Jt?=
 =?utf-8?B?VkRuWlUzbG93ZFNOOXA0YWxzTzVnd2JwSDRSSkpHZFFJaExWVDJKeTQyNEt4?=
 =?utf-8?B?WTJsSVdHZGhkVEFkdTIwc0dkVDJuMHU2eTJJbFM2NzY2TUtNelVDc1FwSDNH?=
 =?utf-8?B?czdmaExHRGNRQnFSZndFRXg0NWpKNHA4eXo4aHFLVy9kaG9LYVJYNlNPVFNZ?=
 =?utf-8?B?cGtwMGR6OWVCU3ZBWFcrb2dyNG5heFpsZkpFVmNldVVIeFVnMDVqTFU1dENP?=
 =?utf-8?B?UC9CcCtiaThxc3FpcjBYNWpvRjM2bXdCa1ZST3lIa0JMLzJzOU5SeVpoMEF1?=
 =?utf-8?B?SnFsS011ZWxWU3pWTjJKMXBqZnRBNUVVRUIzbENxT2VpT2NwZkZXeFM2QVRx?=
 =?utf-8?B?QjhqNHYzbVJ5bmp0cDJvRHl5eUFMV3ZPK2JlMXRPbDhya3R1cHZULzJFUnRq?=
 =?utf-8?B?a1F1cjZYZFpRYTJJM2hIOHB4Vkh1N09Ucm40M2l5a0F4SElyQlJsam5QYjZp?=
 =?utf-8?B?ejduZE1yV2tjUUwxQkh2VFlxMDBPQll2d3VoUnE0bGIyZE56cGJRMUJXMDJq?=
 =?utf-8?B?emJLand0NklRS25KZnF1Zi9xOE94Ym5YaFZKekZ1SnNWbndUaFdkWGpheHNO?=
 =?utf-8?B?RkV4NzZzd3c5RXE3UG8wbHBmSU42cGt3dStiSXlTWFhzRE8zQnJLN0VHZkEz?=
 =?utf-8?B?UnJaL1RpRVo1dXVsOWxiSGJXM3lhMDZUTHdkSXV6YXZibGZYQjl6WVJWWXV2?=
 =?utf-8?B?WE5mSjFwNGd3RHFxQ2ZZU2lXQ3Q5YTFoenNnNEdubWcwdEZPTHFaU3JsdlVa?=
 =?utf-8?B?Z3BhbUl0ckcxb0F6ZmU4UmhtMVVMTldkY3ArZFpSVzRLYlFNaTZVdVpsM1Bv?=
 =?utf-8?B?UVdUT2tNU0JOYW5UY1pMdjFwb2E0R3lqT2lqY2V4aTZFeFE1dTd2dXlpT0Rl?=
 =?utf-8?B?N0YvMGw0VEdmV2l4WUlCWVA2OVppM0tEcnVPUk1tM3ZWamR5emx3bm43d3Rm?=
 =?utf-8?B?cmhsRGNOaXFDRE5XalZuZ3M2RzNKcHpwMEoweVptd01Kbm92R0Rac21xdm5t?=
 =?utf-8?B?b3pjNVlOc3Nqakw4ZkdSTy9aWXA1clF3ZnpQN3RJU2RiY1VwRld5bSs4SlZq?=
 =?utf-8?B?aDgwZDNRbER5aitaSjBLMElneTJqaWZLTVArZWhmRXVmdE5Ud1BQcDJya1B3?=
 =?utf-8?B?Y3ZhRkZneUE5REJMOE1odFZLeC9oK0Jvb0xzY0tSbXY2MHJIaktNVkQ3dlVn?=
 =?utf-8?B?YUJPUFBpdzNsZE8rVXM1MHpRYXd0dmFEbmUyVWt6YUkyYkNBWlN1MGdCdCtL?=
 =?utf-8?B?elN6SklzOEpPbS9hbm13bCtoSUxidnRjajlKSmtsVWFsM1FOcUdIeERleXVx?=
 =?utf-8?B?YXZrZUlsWCswY0ZFQXBMeGpveldXSFpGQXQwalAvU1UvUld4QWxKc1VyM2tO?=
 =?utf-8?B?aFFNc3lRdGZDcS82OXpiOEFCTElCdXlvYnVBbWs2M0xOZFBxQVFXZ0xTek9n?=
 =?utf-8?B?UXdjQStaY0dpbEtVSWh1VlV5WnZKelA1UGlKWlJGYldpcVVnYlZNQ3crSE1x?=
 =?utf-8?B?aC9ubzUxN3dodzhBc0xSWmZYT2dCdkcwdEJBT1BmM01WT3ZMTUlLOFdYaDM1?=
 =?utf-8?B?RzBDOUJKTEt3dDVMaDN3M1dyaElLcWIrMVVPek5uYmEyVkNuS2JYNkl3bW1L?=
 =?utf-8?B?WWYwMHFKbzQwa2NkTG1Ub0pmK0sxbHNSMklZeWlmZ3NvcG9CcUFCdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F67129E6ADF5A144904FE87BEEA2D121@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c23d613-7bd3-4125-1063-08de8f233516
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 12:44:11.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5cB6U9Xh5f5iVnVPBZgHnJUTvbtGHcH2z1UtsLnuieW90nALsFETm2Q7Op/MQXMHJRxy427Yh8YLpHYdal3xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,nvidia.com,resnulli.us,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,google.com,blackwall.org,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,intel.com,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18839-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 8D27D369C3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE5OjA4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMNCj4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxp
ZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiAtLS0NCj4gZGV2bGluazogQWxsb3cgcmF0ZSBu
b2RlIHBhcmVudHMgZnJvbSBvdGhlciBkZXZsaW5rcw0KPiANCj4gVGhpcyBjb21taXQgbWFrZXMg
dXNlIG9mIHRoZSBidWlsZGluZyBibG9ja3MgcHJldmlvdXNseSBhZGRlZCB0bw0KPiBpbXBsZW1l
bnQgY3Jvc3MtZGV2aWNlIHJhdGUgbm9kZXMuDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L25ldC9kZXZsaW5rLmggYi9pbmNsdWRlL25ldC9kZXZsaW5rLmgNCj4gPiBpbmRleCAzMDM4YWY2
ZWMwMTdlLi44ZDVhZDVkNGYxZDA1IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L2Rldmxp
bmsuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbmV0L2RldmxpbmsuaA0KPiA+IEBAIC0xNTg1LDYgKzE1
ODUsMTEgQEAgc3RydWN0IGRldmxpbmtfb3BzIHsNCj4gPiDCoAkJCQnCoMKgwqAgc3RydWN0IGRl
dmxpbmtfcmF0ZSAqcGFyZW50LA0KPiA+IMKgCQkJCcKgwqDCoCB2b2lkICpwcml2X2NoaWxkLCB2
b2lkDQo+ID4gKnByaXZfcGFyZW50LA0KPiA+IMKgCQkJCcKgwqDCoCBzdHJ1Y3QgbmV0bGlua19l
eHRfYWNrDQo+ID4gKmV4dGFjayk7DQo+ID4gKwkvKiBJbmRpY2F0ZXMgaWYgY3Jvc3MtZGV2aWNl
IHJhdGUgbm9kZXMgYXJlIHN1cHBvcnRlZC4NCj4gPiArCSAqIFRoaXMgYWxzbyByZXF1aXJlcyBh
IHNoYXJlZCBjb21tb24gYW5jZXN0b3Igb2JqZWN0IGFsbA0KPiA+IGRldmljZXMgdGhhdA0KPiA+
ICsJICogY291bGQgc2hhcmUgcmF0ZSBub2RlcyBhcmUgbmVzdGVkIGluLg0KPiA+ICsJICovDQo+
ID4gKwlib29sIHN1cHBvcnRlZF9jcm9zc19kZXZpY2VfcmF0ZV9ub2RlczsNCj4gDQo+IFdoZW4g
YSBkZXZpY2UgYWN0aW5nIGFzIGEgY3Jvc3MtZGV2aWNlIHJhdGUgcGFyZW50IGlzIGRlc3Ryb3ll
ZCwNCj4gZGV2bF9yYXRlX25vZGVzX2Rlc3Ryb3koKSBpdGVyYXRlcyB0aGUgc2hhcmVkIHJhdGVf
bGlzdCB0byBkZXRhY2ggaXRzDQo+IGNoaWxkcmVuLiBJZiBpdCBlbmNvdW50ZXJzIGEgY2hpbGQg
cmF0ZSBub2RlIGJlbG9uZ2luZyB0byBhIGRpZmZlcmVudA0KPiBkZXZpY2UsDQo+IGl0IGludm9r
ZXMgdGhlIGNoaWxkIGRyaXZlcidzIG9wcy0+cmF0ZV9ub2RlX3BhcmVudF9zZXQgb3INCj4gb3Bz
LT5yYXRlX2xlYWZfcGFyZW50X3NldCBjYWxsYmFja3MuDQo+IA0KPiBTaW5jZSB0aGUgY2xlYW51
cCBwYXRoIG9ubHkgaG9sZHMgdGhlIHBhcmVudCdzIGRldmxpbmsgbG9jayBhbmQgdGhlDQo+IHNo
YXJlZA0KPiByb290IGRldmxpbmsgbG9jaywgZG9lcyB0aGlzIGFsbG93IHRoZSBjaGlsZCBkcml2
ZXIncyByYXRlIG9wZXJhdGlvbnMNCj4gdG8NCj4gZXhlY3V0ZSBjb25jdXJyZW50bHkgd2l0aCBv
dGhlciBvcGVyYXRpb25zIG9uIHRoZSBjaGlsZCBkZXZpY2UNCj4gd2l0aG91dCBob2xkaW5nDQo+
IHRoZSBjaGlsZCdzIGRldmxpbmsgaW5zdGFuY2UgbG9jaz8NCg0KVGhlIHJhdGVfbm9kZSBsb2Nr
IHByb3RlY3RzIGNoYW5nZXMgdG8gdGhlIHJhdGUgaGllcmFyY2h5LCBldmVuIGlmDQpjaGlsZCBk
ZXZsaW5rIGluc3RhbmNlIGxvY2tzIGFyZW4ndCBoZWxkLiBUaGUgY29kZSB3b3JrcyBieSBsb2Nr
aW5nDQpldmVyeXRoaW5nIGZyb20gdGhlIGFmZmVjdGVkIGluc3RhbmNlIEEgdXAgdG8gdGhlIGlu
c3RhbmNlIGF0IHRoZSByb290DQpvZiB0aGUgaGllcmFyY2h5IFIsIGFuZCBhZmZlY3RzIHRoZSBo
aWVyYXJjaHkgd2l0aCBSJ3MgaW5zdGFuY2UgbG9jaw0KaGVsZC4gSSB0aGluayB0aGlzIGNhbiBi
ZSBtYWRlIGNsZWFyZXIgaW4gdGhlIGNvZGUvY29tbWVudHMgdGhvdWdoLCBzbw0KV2lsbCB0d2Vh
ayBzb21lIHRoaW5ncyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBbIC4uLiBdDQo+ID4g
ZGlmZiAtLWdpdCBhL25ldC9kZXZsaW5rL3JhdGUuYyBiL25ldC9kZXZsaW5rL3JhdGUuYw0KPiA+
IGluZGV4IDE5NDk3NDZmYWIyOTEuLmYyNDNjY2NjOTViZWUgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0
L2RldmxpbmsvcmF0ZS5jDQo+ID4gKysrIGIvbmV0L2RldmxpbmsvcmF0ZS5jDQo+ID4gQEAgLTMw
LDE5ICszMCw1MyBAQCBkZXZsaW5rX3JhdGVfbGVhZl9nZXRfZnJvbV9pbmZvKHN0cnVjdCBkZXZs
aW5rDQo+ID4gKmRldmxpbmssIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQo+ID4gwqAJcmV0dXJu
IGRldmxpbmtfcmF0ZSA/OiBFUlJfUFRSKC1FTk9ERVYpOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4g
Ky8qIFJlcGVhdGVkbHkgbG9ja3MgdGhlIG5lc3RlZC1pbiBkZXZsaW5rIGluc3RhbmNlcyB3aGls
ZSBjcm9zcw0KPiA+IGRldmljZSByYXRlDQo+ID4gKyAqIG5vZGVzIGFyZSBzdXBwb3J0ZWQuIFJl
dHVybnMgdGhlIGRldmxpbmsgaW5zdGFuY2Ugd2hlcmUgcmF0ZXMNCj4gPiBzaG91bGQgYmUNCj4g
PiArICogc3RvcmVkLg0KPiA+ICsgKi8NCj4gPiDCoHN0YXRpYyBzdHJ1Y3QgZGV2bGluayAqZGV2
bF9yYXRlX2xvY2soc3RydWN0IGRldmxpbmsgKmRldmxpbmspDQo+ID4gwqB7DQo+ID4gLQlyZXR1
cm4gZGV2bGluazsNCj4gPiArCXN0cnVjdCBkZXZsaW5rICpyYXRlX2RldmxpbmsgPSBkZXZsaW5r
Ow0KPiA+ICsNCj4gPiArCXdoaWxlIChyYXRlX2RldmxpbmstPm9wcyAmJg0KPiA+ICsJwqDCoMKg
wqDCoMKgIHJhdGVfZGV2bGluay0+b3BzLQ0KPiA+ID5zdXBwb3J0ZWRfY3Jvc3NfZGV2aWNlX3Jh
dGVfbm9kZXMpIHsNCj4gPiArCQlkZXZsaW5rID0gZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xvY2so
cmF0ZV9kZXZsaW5rLQ0KPiA+ID5yZWwpOw0KPiA+ICsJCWlmICghZGV2bGluaykNCj4gPiArCQkJ
YnJlYWs7DQo+ID4gKwkJcmF0ZV9kZXZsaW5rID0gZGV2bGluazsNCj4gPiArCX0NCj4gPiArCXJl
dHVybiByYXRlX2Rldmxpbms7DQo+ID4gwqB9DQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICsvKiBS
ZXBlYXRlZGx5IHVubG9ja3MgdGhlIG5lc3RlZC1pbiBkZXZsaW5rIGluc3RhbmNlcyBvZiAnZGV2
bGluaycNCj4gPiB3aGlsZSBjcm9zcw0KPiA+ICsgKiBkZXZpY2Ugbm9kZXMgYXJlIHN1cHBvcnRl
ZC4NCj4gPiArICovDQo+ID4gwqBzdGF0aWMgdm9pZCBkZXZsX3JhdGVfdW5sb2NrKHN0cnVjdCBk
ZXZsaW5rICpkZXZsaW5rKQ0KPiA+IMKgew0KPiA+ICsJaWYgKCFkZXZsaW5rIHx8ICFkZXZsaW5r
LT5vcHMgfHwNCj4gPiArCcKgwqDCoCAhZGV2bGluay0+b3BzLT5zdXBwb3J0ZWRfY3Jvc3NfZGV2
aWNlX3JhdGVfbm9kZXMpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCWRldmxfcmF0ZV91
bmxvY2soZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xvY2tlZChkZXZsaW5rLQ0KPiA+ID5yZWwpKTsN
Cj4gPiArCWRldmxpbmtfbmVzdGVkX2luX3B1dF91bmxvY2soZGV2bGluay0+cmVsKTsNCj4gPiDC
oH0NCj4gDQo+IElmIGEgcGFyZW50IGRldmxpbmsgaXMgbm90IHlldCByZWdpc3RlcmVkLA0KPiBk
ZXZsaW5rX25lc3RlZF9pbl9nZXRfbG9jaygpIGNhbg0KPiByZXR1cm4gTlVMTCBpbiBkZXZsX3Jh
dGVfbG9jaygpIGFuZCBicmVhayB0aGUgbG9vcCB3aXRob3V0IHRha2luZyBhDQo+IGxvY2suDQo+
IA0KPiBJZiBhbm90aGVyIHRocmVhZCBjb21wbGV0ZXMgcmVnaXN0ZXJpbmcgdGhlIHBhcmVudCBk
ZXZsaW5rDQo+IGNvbmN1cnJlbnRseSwNCj4gZGV2bGlua19uZXN0ZWRfaW5fZ2V0X2xvY2tlZCgp
IGluIGRldmxfcmF0ZV91bmxvY2soKSB3aWxsIGZpbmQgaXQuIA0KPiANCj4gQ291bGQgdGhpcyBs
ZWFkIHRvIHVubG9ja2luZyBhIG11dGV4IHRoYXQgd2FzIG5ldmVyIGFjcXVpcmVkIGFuZA0KPiBk
cm9wcGluZyBhDQo+IHJlZmVyZW5jZSB0aGF0IHdhcyBuZXZlciB0YWtlbiwgcmVzdWx0aW5nIGlu
IGEgdXNlLWFmdGVyLWZyZWUgb3IgbG9jaw0KPiBjb3JydXB0aW9uPw0KDQpBIHZhbGlkIGNvbmNl
cm4gaW4gdGhlb3J5LCBldmVuIHRob3VnaCBpbiBwcmFjdGljZSB0aGVyZSB3b24ndCBiZQ0KYW5v
dGhlciB0aHJlYWQgcmVnaXN0ZXJpbmcgYSBzaGFyZWQgZGV2bGluayBpbnN0YW5jZSB0aGF0IHdv
dWxkIHJhY2UNCndpdGggcmVnaXN0cmF0aW9uIGluIHRoaXMgd2F5Lg0KDQpJIHdpbGwgbWFrZSB0
aGVzZSBsb2NrL3VubG9jayBoZWxwZXJzIG1vcmUgcm9idXN0IGluIHRoZSBuZXh0IHZlcnNpb24u
DQoNCj4gDQo+IFsgLi4uIF0NCj4gPiBAQCAtMzIwLDEzICszNzEsMTQgQEAgZGV2bGlua19ubF9y
YXRlX3BhcmVudF9ub2RlX3NldChzdHJ1Y3QNCj4gPiBkZXZsaW5rX3JhdGUgKmRldmxpbmtfcmF0
ZSwNCj4gPiDCoAkJCQlzdHJ1Y3QgZ2VubF9pbmZvICppbmZvLA0KPiA+IMKgCQkJCXN0cnVjdCBu
bGF0dHIgKm5sYV9wYXJlbnQpDQo+ID4gwqB7DQo+ID4gLQlzdHJ1Y3QgZGV2bGluayAqZGV2bGlu
ayA9IGRldmxpbmtfcmF0ZS0+ZGV2bGluazsNCj4gPiArCXN0cnVjdCBkZXZsaW5rICpkZXZsaW5r
ID0gZGV2bGlua19yYXRlLT5kZXZsaW5rLA0KPiA+ICpwYXJlbnRfZGV2bGluazsNCj4gPiDCoAlj
b25zdCBjaGFyICpwYXJlbnRfbmFtZSA9IG5sYV9kYXRhKG5sYV9wYXJlbnQpOw0KPiA+IMKgCWNv
bnN0IHN0cnVjdCBkZXZsaW5rX29wcyAqb3BzID0gZGV2bGluay0+b3BzOw0KPiA+IMKgCXNpemVf
dCBsZW4gPSBzdHJsZW4ocGFyZW50X25hbWUpOw0KPiA+IMKgCXN0cnVjdCBkZXZsaW5rX3JhdGUg
KnBhcmVudDsNCj4gPiDCoAlpbnQgZXJyID0gLUVPUE5PVFNVUFA7DQo+ID4gwqANCj4gPiArCXBh
cmVudF9kZXZsaW5rID0gZGV2bGlua19ubF9jdHgoaW5mbyktPnBhcmVudF9kZXZsaW5rID8gOg0K
PiA+IGRldmxpbms7DQo+ID4gwqAJcGFyZW50ID0gZGV2bGlua19yYXRlLT5wYXJlbnQ7DQo+ID4g
wqANCj4gPiDCoAlpZiAocGFyZW50ICYmICFsZW4pIHsNCj4gPiBAQCAtMzQ0LDcgKzM5NiwxMyBA
QCBkZXZsaW5rX25sX3JhdGVfcGFyZW50X25vZGVfc2V0KHN0cnVjdA0KPiA+IGRldmxpbmtfcmF0
ZSAqZGV2bGlua19yYXRlLA0KPiA+IMKgCQlyZWZjb3VudF9kZWMoJnBhcmVudC0+cmVmY250KTsN
Cj4gPiDCoAkJZGV2bGlua19yYXRlLT5wYXJlbnQgPSBOVUxMOw0KPiA+IMKgCX0gZWxzZSBpZiAo
bGVuKSB7DQo+ID4gLQkJcGFyZW50ID0gZGV2bGlua19yYXRlX25vZGVfZ2V0X2J5X25hbWUoZGV2
bGluaywNCj4gPiBwYXJlbnRfbmFtZSk7DQo+ID4gKwkJLyogcGFyZW50X2RldmxpbmsgKHdoZW4g
ZGlmZmVyZW50IHRoYW4gZGV2bGluaykNCj4gPiBpc24ndCBsb2NrZWQsDQo+ID4gKwkJICogYnV0
IHRoZSByYXRlIG5vZGUgZGV2bGluayBpbnN0YW5jZSBpcywgc28NCj4gPiBub2JvZHkgZnJvbSB0
aGUNCj4gPiArCQkgKiBzYW1lIGdyb3VwIG9mIGRldmljZXMgc2hhcmluZyByYXRlcyBjb3VsZA0K
PiA+IGNoYW5nZSB0aGUgdXNlZA0KPiA+ICsJCSAqIGZpZWxkcyBvciB1bnJlZ2lzdGVyIHRoZSBw
YXJlbnQuDQo+ID4gKwkJICovDQo+ID4gKwkJcGFyZW50ID0NCj4gPiBkZXZsaW5rX3JhdGVfbm9k
ZV9nZXRfYnlfbmFtZShwYXJlbnRfZGV2bGluaywNCj4gPiArCQkJCQkJwqDCoMKgwqDCoMKgDQo+
ID4gcGFyZW50X25hbWUpOw0KPiANCj4gSXMgcGFyZW50X2RldmxpbmsgdmFsaWRhdGVkIHRvIGVu
c3VyZSBpdCBzaGFyZXMgdGhlIHNhbWUgY29tbW9uIHJhdGUNCj4gcm9vdA0KPiBhbmNlc3RvciBh
cyBkZXZsaW5rPw0KPiANCj4gSWYgYW4gYXJiaXRyYXJ5IHVucmVsYXRlZCBwYXJlbnRfZGV2bGlu
ayBpcyBzcGVjaWZpZWQsDQo+IGRldmxpbmtfcmF0ZV9ub2RlX2dldF9ieV9uYW1lKCkgY291bGQg
dHJhdmVyc2UgYW4gdW5yZWxhdGVkIHBhcmVudCdzDQo+IHJhdGVfbGlzdCB0aGF0IHdhcyBuZXZl
ciBsb2NrZWQgYnkgZGV2bF9yYXRlX2xvY2soKSwgbGVhZGluZyB0byBhDQo+IGRhdGEgcmFjZS4N
Cj4gDQo+IEFkZGl0aW9uYWxseSwgaWYgYSByYXRlIG5vZGUgaXMgZm91bmQsIGl0cyBwcml2IHBv
aW50ZXIgaXMgcGFzc2VkIHRvDQo+IHRoZQ0KPiB0YXJnZXQgZHJpdmVyJ3Mgb3BzLT5yYXRlX25v
ZGVfcGFyZW50X3NldC4gQ291bGQgdGhpcyBjYXVzZSB0aGUNCj4gdGFyZ2V0IGRyaXZlcg0KPiB0
byBjYXN0IGEgZm9yZWlnbiBwcml2IHBvaW50ZXIgdG8gaXRzIG93biBwcml2YXRlIHN0cnVjdCB0
eXBlLA0KPiByZXN1bHRpbmcgaW4NCj4gdHlwZSBjb25mdXNpb24gYW5kIG1lbW9yeSBjb3JydXB0
aW9uPw0KDQpSaWdodCwgdGhlcmUncyBubyBjb21tb24gYW5jZXN0b3IgdmFsaWRhdGlvbiB3aGlj
aCBjb3VsZCBsZWFkIHRvDQp1bnBsZWFzYW50IHJlc3VsdHMgaWYgb25lIHRyaWVzIHRvIHNldCBh
IHJhdGUgcGFyZW50IGFjcm9zcyBkcml2ZXJzDQp3aGljaCBzdXBwb3J0IGNyb3NzLWVzdy4NCkkn
bGwgYWRkIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkNvc21pbi4NCg==

