Return-Path: <linux-rdma+bounces-18838-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACvGBAm/y2k9LgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18838-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:33:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F68B369842
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0616C3014BC4
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5A3E1D0E;
	Tue, 31 Mar 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N8Vi3g1S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248ED2BCF46;
	Tue, 31 Mar 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960145; cv=fail; b=ekCNYG3++LpHn0YH4Civz8SEVrNj9yvky2deqi8VCuIUhh3lNPEDmnUG6ILVx4qd313iswoho/k5XyQbfLXw1ta3BJ1RTRHUfCm/KrnNhB5fB2q3ajhddVj6wQoljrN7HIoFnRma8NYaE3UWxH2a9nr2QXuxYC4EwVa4RWct16s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960145; c=relaxed/simple;
	bh=mZilyWqJyFxws2BHti1JtKM//Vr/yIWxmToXmueRZRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WNgYRJwIxbC7a2qo84Dt2KmSv3feHja66IxrdDHliZusjLIh8djxVemIpumBacWbPwEfsmLoo8M1H/dh5asVwfkRvwg6/V+/La3Dg21+f/onwjxRJIYcEgveOfJ+p0ugXWsUXLs8f5JXTqj77aKvvBEeDl+mx1/N+2prI3IKKtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N8Vi3g1S; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G166ja0gAudFI+mnjzWATb2511KuL369OysRqLCq73eGV45F3PICCtuGJmHTj7arJPFZZcUoDyUIBQKDSRiZw42lEnSzX8eNP354gYvhT4bIFrRqfbTdDWn6d2IxYAJ0G7WQPS1CUaDJQlBxxeT69qnkkif3wWQJfIpiC87isA/LvNIubqL3BD56Nasc8H13iygAGpjBWaWJjrIwtI6J0xi8/pEMtxlp5ahdvE5pCuu8bofeyHvBoBJ1GEdpbXGC0UNQEKj7zLXyjSati2fw7dQpT4IC49+KH97BIyPUvvGHqHK0LiaYtsXKN1Pv10wdjZQWbxoWatV8BzOiZDJxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZilyWqJyFxws2BHti1JtKM//Vr/yIWxmToXmueRZRQ=;
 b=FEudbt2SKyyq9xES+t2Vb9dWd65qQObkVErj8NCQl2Q1m4yILPimnYFdSiPZFp9eTSDPmWUiscj+sqqU351UUBusasfRBluVHhu+empaYYhUVJfMszxINbjeGqo+QvobKJ5NNXjWEF4sS5cJGbwwtGidj7AplBDshKLSb+HMSNvfLtlyzInGWkGSUemog5ON/pQ4gKTaTV+bYihj3V/hr3sYZG7aIKNv6Z0f1cAISnnuGc0vxKjTl+nsesB+997b0Tx50qqoy8H0CLZ3SKxbtN3qOxEJGGDhjZKIDpmdPBG/dHFik/aw9dZY/K550dn7xWLSFcNnLYjBZvZ+aVurkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZilyWqJyFxws2BHti1JtKM//Vr/yIWxmToXmueRZRQ=;
 b=N8Vi3g1S/BHcZ4k0ERlABjmWmEG06CwBhKnnkDlZSmBy2BbA/+EHaR6siDpwX/p9KyN9LZgAZjfhPUxnydBInHiFEJVBoUXZimiSmJeIwqJAHMBMFNyzpfmKSGIGpLkmMT1dWtGDnmDPG3NZn6WBpvWYzlWKL+sSbLzH/fzux8EcWRxBGuOPPTBEbzbmSbrXKDbgjF3Itp54+rsvfYJD2/c9yiBu4SbSk8b+zcvChnG7VNZUogSSPmU3wuBh3Rw4+IdcVqafqfjXkXyQUcJRmfeCYHz3BGlHsAM0BAJLxXHIQs0XxR0FFTuWU+NP8fxMAt6YP65sfPQ7abRB8Yr/bg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by IA1PR12MB8311.namprd12.prod.outlook.com
 (2603:10b6:208:3fa::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 12:28:53 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 12:28:53 +0000
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
Subject: Re: [PATCH net-next V9 04/14] devlink: Decouple rate storage from
 associated devlink object
Thread-Topic: [PATCH net-next V9 04/14] devlink: Decouple rate storage from
 associated devlink object
Thread-Index: AQHcvO5f+kgv1db1r0eq3hh3jmTT8LXH7JQAgACtbAA=
Date: Tue, 31 Mar 2026 12:28:53 +0000
Message-ID: <33f895ee8dd2c846c03133a744e89e6e76a80f40.camel@nvidia.com>
References: <20260326065949.44058-5-tariqt@nvidia.com>
	 <20260331020810.3524941-1-kuba@kernel.org>
In-Reply-To: <20260331020810.3524941-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|IA1PR12MB8311:EE_
x-ms-office365-filtering-correlation-id: c4464858-9772-46ed-e10c-08de8f211215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 DiVNQho1K2HkZzk3LR2691oJmr71vTyvv7yX8LTNYAI+2Mch1a9+1AF8PnrAjOni58s2WuiXYDtmFVf0xC6J/tpZ6hLZmXE4SF2NKFMuh9K3595DQ2pXINQ7z2jk49cCJJ2W6ooZDRRo1Ch+2Omolngb8XHDhMjPzl0C7CEcjTDJiN/1O25cwd2dLoYhytqiYrJdI4caZu6wW3SqeQ5jlAZ3BjdG16eRmi0TquSzO8CnHDb84N2ROfkNsT3cPnD7ITmuHbnC+9N7rgewKx12N+Dx55INgygPwHCFoqWfQpMYMpQmynicA3iRTWh4AatdRCaeO8cLk9ZJ35UTAdN40kKTRYhhVsNotiVVRo9Z0nvP+0LGAzDrnW9IvryFAmqLywUYiJvw5L8nJY7AinV6ZQML3tUr2N9r9HythBHyftNhzol6vU5IHYNpiGZAw58OMpetppoePwqZhiSuk6gh9uDsWIyEfe6omsBkVpU5Tn5goTE440FFLcrEQ1hMGbMTshEHEd6Nvf2QAH8vHI8vP0nPuBQ9KxKZd1XxDOMLh4j84sUpkqcEKlRqhPaheLMDltFHzUQowbGyid8Ux4pXdJEHP8Zbll+PuVtazNNUPl1vy9B69R3grt4pJlLEXoNQ2umSPMh68m/Yi0fs+nnfUpeopjnFgefOpnypzAC+h4McBShGlw0pi6bm6mhFpB8oqrGBNcVA/W0kYISd/7phZNYAA5pInqyXGQCI47RuhfkUrs0sCoa+QsNelmdImtUxTaGU5nNICB9AKb3Wgw9tL7GSAfbjTiLB1shkykmWT84=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFdqUW0wNmxzQnRYSllDQkNEMno4TXkvaVFGWnZjZENQZWE3L05jUFJNb1R4?=
 =?utf-8?B?bEgrMzNUb1ZGTTE3U1pGOWtTclBrbDF2STdUUUtjY29WaE1GbUZ1MU9qNWhr?=
 =?utf-8?B?Szg2OFRqbjJHRDR2aHlKc3QzUmNRY0EzNnRidmlyK3BoaDhhTkY5L2pZTURz?=
 =?utf-8?B?TW9GTVhaZ1FkVzZDb2hCUVMvbWRwVnBmUmdvdTNiL3AvNmg2TEltNnlwMnlP?=
 =?utf-8?B?dmxneFdIelB5MTBZZkg5d0RlVnIvNFJ2SnkvSWJuTkkrNGFmWVNZLzZvSkMr?=
 =?utf-8?B?blQ0a0p4b3hZQk9SN0xoTE9IcXlYdVNrZGx2OS9Ta25XRmsyeG1XTzdwdi9v?=
 =?utf-8?B?aEdWZUQrcHAxQkhwSm1mNlN3QXBQc2daSGtJdWtJUXhWdi9TaFo0T0dpVUUz?=
 =?utf-8?B?dXlCd1N3SkE5S1BsMTdTQUN5QURob0hjN2FTZm5wdndnTVVLYlJPS1IrR2tR?=
 =?utf-8?B?Yk9WaWNHVTFvQ0NoV1cxUHhkaHBwMmpvOUJ5MktxTXJ4ZVBzMTgyQlRqaFVL?=
 =?utf-8?B?dHpkcVR1SGg3T0l5RFRudkNIWGpmSU1WNGZDRU84YnFyUTErWWxsUVk0RW5G?=
 =?utf-8?B?bVpDdGVSWVpGeEsxM1VMcXBlbm5yTVpyTnNyZUFQdU5JT1pnRVN1VzJVbVVt?=
 =?utf-8?B?UlhiQ2w3RkhodFd2bGd4NlJSN2R6ZHJoQzc2UnBZRWtQL2lDTkhYd1Bzcjdt?=
 =?utf-8?B?Zzh0Zzk3cnJHZU5SSGRuUUJrTE16NHhGQ3BoZloxVkxjUlBuWXVucEdrai9V?=
 =?utf-8?B?dlJ2d3htTkY5UFVYYk9CUDBQSVpMV2JKQlpiU0JEZE0rcU9MNFZSZWhVckQx?=
 =?utf-8?B?c1U2Zk9lYWtXbk5HdHdaYlJtamlISktrYmdLQWI0KzkvUUtsMnhTMVlmeGV2?=
 =?utf-8?B?Z2VvZWV3TVBHK203dE1UMU9SWFdOS3o3ZCtHNUgrSS9yZzhtMHN5Q0NhYmFZ?=
 =?utf-8?B?VEtnc0gyYTRsOTJVWjBMYUR0VWoxcW9NdTd5MWRJSGdmVGxPNlJlTWQ1eFUz?=
 =?utf-8?B?Tm9WK0tCWDd1b1UxcExnYkFoYXpjRUFzSG9LVjNGcVdpR3lsdzRpQ1I5ZHV3?=
 =?utf-8?B?ckxjbTI3aXhldmNwQnUrU2N4cjFTWHlRVDZMZVEvaXUyOW9qMTIwUWdxLzJD?=
 =?utf-8?B?OXplMFQrSXM4SnFRc01EdDEwS1d5anRiQTk3VHhMK09QbWZFWlEzNjhpM0dh?=
 =?utf-8?B?WFhCUlNRWE5leWl3d3VoTy9sTHNWWnk2MTQydHJNbUw1RmdYVkJHTEI4YWFV?=
 =?utf-8?B?ckZPWElJUmx2V1lSLzBJTDk1cU83WlM1VTNrQkVPM0NiRCtyYWNtYTcvSUNa?=
 =?utf-8?B?ak95TzJERkpER01JdCtvTGZYME1zUE52bHprVm9NcW5YQ24wVXVhZWM4SWZJ?=
 =?utf-8?B?OXM2ZFZZeThqazJjL2wxQ1lRR1FhUlhuWTlOQWVnUGdBUkFwNkx2TWZRK1hP?=
 =?utf-8?B?Z0p2cW1tRE1zU0F5b0VmTmROSG9tRFVGOFpvSzluUTFoMmNTVFN1Vnk4UlR2?=
 =?utf-8?B?SzBqTGgvT2tsVFk5VVFjREliSndUWVV2ajk5WmkzS0F3QVdKTDRaTDk4NFpp?=
 =?utf-8?B?aXAvL01TUUlMYk9qdGFpTFJmS1NwVFM1YkVQTmxBdWJsWVl1NFdIMERnSTZx?=
 =?utf-8?B?ZTNFanU1dkxiZXFlVjNkdXRDaFl5c3c3Y1lDOU4weVloRFArVW0ycFpNeFMz?=
 =?utf-8?B?djJvQy9OSFIrekQxUmtqTTI4ZXJOMzF4d01yMThJcmtIZGt2Y0d2NnNtZXBo?=
 =?utf-8?B?WkpWZDVXaGl5YVEydEtLM2JSRWROU3g0R1JHMElFalRlNzB0aVBYTGpnN0Z1?=
 =?utf-8?B?a1RpTmZ5aVJqVWRkc2pIZzdneE9ha0JMNXpLZ1FNS3ljVm1rSG15UUxFWGkw?=
 =?utf-8?B?RW4zMmY0SFlicHZrTUJ6dzZUMzRPR1lPRnR5NDB6QmtoUWowR3M4ekR0cTlY?=
 =?utf-8?B?TjlCaTI3d1NzVWNqajRXV1NkRm00U0xRVE5QUHkxODNFY3A4bzlia2FlK3hR?=
 =?utf-8?B?cWVYb1VvR2JSbGRFa3BHaVdzM2hHUzdWU1JqVnFTQ1VtdTdxeTEvcXoyTldp?=
 =?utf-8?B?aWY2aXNyZUJEdW9zcTNVNVdxdGVEMnd3ZXZHMEdtRGhZK1VFdHVzY2ZmaHMy?=
 =?utf-8?B?RG1KYjVKMjNzSXEwR0ptdVp5WkFmV0czWnBLcUdNQVNwZU9VamN0bFZ3aldw?=
 =?utf-8?B?dWhKUkxrVHdoRWZFT3FsVU9qT3JvSG9hZ0VROVRyVFAvYWFyeS9SZFNVSkxT?=
 =?utf-8?B?dTRqUWJlSFZNR1hEY241RXZtWWZIT3g3NVY0VjUwbCs2OVpnT0IydjFTOU1v?=
 =?utf-8?B?Yk8yYThrdWJqSnlRbWNiTnY1b3BjS3FJYXRqdTZkd1JXa0dlTWx1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <500F99B97B49724DB58562D26B245BE3@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4464858-9772-46ed-e10c-08de8f211215
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 12:28:53.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gooOEARrwftZI0JxOoV9j5GeNbuCH+1g8GBav8CKIkqb3L3xj3+dMxgfDF5KYhpYMNq41/e6RjUcxRjBKUJM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,nvidia.com,resnulli.us,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,google.com,blackwall.org,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,intel.com,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18838-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 6F68B369842
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE5OjA4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMNCj4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxp
ZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiAtLS0NCj4gZGV2bGluazogRGVjb3VwbGUgcmF0
ZSBzdG9yYWdlIGZyb20gYXNzb2NpYXRlZCBkZXZsaW5rIG9iamVjdA0KPiANCj4gRGV2bGluayBy
YXRlIGxlYWZzIGFuZCBub2RlcyB3ZXJlIHN0b3JlZCBpbiB0aGVpciByZXNwZWN0aXZlIGRldmxp
bmsNCj4gb2JqZWN0cyBwb2ludGVkIHRvIGJ5IGRldmxpbmtfcmF0ZS0+ZGV2bGluay4NCj4gDQo+
ID4gZGlmZiAtLWdpdCBhL25ldC9kZXZsaW5rL3JhdGUuYyBiL25ldC9kZXZsaW5rL3JhdGUuYw0K
PiA+IGluZGV4IDQ3ODE0MjkxMDkxOTUuLjllYmJjNzIxMzBjNmEgMTAwNjQ0DQo+ID4gLS0tIGEv
bmV0L2RldmxpbmsvcmF0ZS5jDQo+ID4gKysrIGIvbmV0L2RldmxpbmsvcmF0ZS5jDQo+IFsgLi4u
IF0NCj4gPiBAQCAtNjQ4LDggKzcwMiw5IEBAIGludCBkZXZsaW5rX25sX3JhdGVfbmV3X2RvaXQo
c3RydWN0IHNrX2J1ZmYNCj4gPiAqc2tiLCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKQ0KPiA+IMKg
CQlnb3RvIGVycl9yYXRlX3NldDsNCj4gPiDCoA0KPiA+IMKgCXJlZmNvdW50X3NldCgmcmF0ZV9u
b2RlLT5yZWZjbnQsIDEpOw0KPiA+IC0JbGlzdF9hZGQoJnJhdGVfbm9kZS0+bGlzdCwgJmRldmxp
bmstPnJhdGVfbGlzdCk7DQo+ID4gKwlsaXN0X2FkZCgmcmF0ZV9ub2RlLT5saXN0LCAmcmF0ZV9k
ZXZsaW5rLT5yYXRlX2xpc3QpOw0KPiA+IMKgCWRldmxpbmtfcmF0ZV9ub3RpZnkocmF0ZV9ub2Rl
LCBERVZMSU5LX0NNRF9SQVRFX05FVyk7DQo+ID4gKwlkZXZsX3JhdGVfdW5sb2NrKGRldmxpbmsp
Ow0KPiA+IMKgCXJldHVybiAwOw0KPiA+IMKgDQo+ID4gwqBlcnJfcmF0ZV9zZXQ6DQo+ID4gwqAJ
b3BzLT5yYXRlX25vZGVfZGVsKHJhdGVfbm9kZSwgcmF0ZV9ub2RlLT5wcml2LCBpbmZvLQ0KPiA+
ID5leHRhY2spOw0KPiA+IEBAIC02NTgsNiArNzEzLDggQEAgaW50IGRldmxpbmtfbmxfcmF0ZV9u
ZXdfZG9pdChzdHJ1Y3Qgc2tfYnVmZg0KPiA+ICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8p
DQo+ID4gwqAJa2ZyZWUocmF0ZV9ub2RlLT5uYW1lKTsNCj4gPiDCoGVycl9zdHJkdXA6DQo+ID4g
wqAJa2ZyZWUocmF0ZV9ub2RlKTsNCj4gPiArdW5sb2NrOg0KPiA+ICsJZGV2bF9yYXRlX3VubG9j
ayhkZXZsaW5rKTsNCj4gPiDCoAlyZXR1cm4gZXJyOw0KPiA+IMKgfQ0KPiANCj4gSWYgZGV2bGlu
a19ubF9yYXRlX3NldCgpIGZhaWxzIGFmdGVyIGl0IHN1Y2Nlc3NmdWxseSBzZXRzIHRoZSBwYXJl
bnQNCj4gbm9kZQ0KPiBhbmQgaW5jcmVtZW50cyB0aGUgcGFyZW50J3MgcmVmY291bnQsIGRvZXMg
dGhpcyBlcnJvciBwYXRoDQo+IHBlcm1hbmVudGx5DQo+IGxlYWsgdGhhdCByZWZlcmVuY2Ugc2lu
Y2UgaXQgZnJlZXMgdGhlIG5vZGUgd2l0aG91dCBkZWNyZW1lbnRpbmcgaXQ/DQoNClRoaXMgaXMg
YSBwcmVleGlzdGluZyBidWcgY2F1c2VkIGJ5IHRoZSBmYWN0IHRoYXQgZGV2bGlua19ubF9yYXRl
X3NldA0KZG9lc24ndCByb2xsYmFjayB3aGF0IGl0IGRpZCBvbiBmYWlsdXJlLCBsZWF2aW5nIHZh
cmlvdXMgc2lkZSBlZmZlY3RzLg0KTW9zdCBhcmUgc2V0dGluZyBvZiB2YXJpb3VzIHJhdGUgcGFy
YW1zLCBidXQgdGhpcyBwYXJlbnQgcmVmY291bnQgaXMNCm1vcmUgc2VyaW91cy4gSXQgd2lsbCBo
YXZlIHRvIGJlIGFkZHJlc3NlZCwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhpcw0Kc2VyaWVzIGlzIHRo
ZSByaWdodCBwbGFjZSBmb3IgaXQuIChJJ2xsIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCBzb29uKS4N
Cg0KPiANCj4gWyAuLi4gXQ0KPiA+IEBAIC03MTYsMTQgKzc4NSwyMCBAQCBkZXZsX3JhdGVfbm9k
ZV9jcmVhdGUoc3RydWN0IGRldmxpbmsNCj4gPiAqZGV2bGluaywgdm9pZCAqcHJpdiwgY2hhciAq
bm9kZV9uYW1lLA0KPiA+IMKgCQnCoMKgwqDCoMKgIHN0cnVjdCBkZXZsaW5rX3JhdGUgKnBhcmVu
dCkNCj4gPiDCoHsNCj4gPiDCoAlzdHJ1Y3QgZGV2bGlua19yYXRlICpyYXRlX25vZGU7DQo+ID4g
KwlzdHJ1Y3QgZGV2bGluayAqcmF0ZV9kZXZsaW5rOw0KPiA+IMKgDQo+ID4gKwlyYXRlX2Rldmxp
bmsgPSBkZXZsX3JhdGVfbG9jayhkZXZsaW5rKTsNCj4gPiDCoAlyYXRlX25vZGUgPSBkZXZsaW5r
X3JhdGVfbm9kZV9nZXRfYnlfbmFtZShkZXZsaW5rLA0KPiA+IG5vZGVfbmFtZSk7DQo+ID4gLQlp
ZiAoIUlTX0VSUihyYXRlX25vZGUpKQ0KPiA+IC0JCXJldHVybiBFUlJfUFRSKC1FRVhJU1QpOw0K
PiA+ICsJaWYgKCFJU19FUlIocmF0ZV9ub2RlKSkgew0KPiA+ICsJCXJhdGVfbm9kZSA9IEVSUl9Q
VFIoLUVFWElTVCk7DQo+ID4gKwkJZ290byB1bmxvY2s7DQo+ID4gKwl9DQo+ID4gwqANCj4gPiDC
oAlyYXRlX25vZGUgPSBremFsbG9jX29iaigqcmF0ZV9ub2RlKTsNCj4gPiAtCWlmICghcmF0ZV9u
b2RlKQ0KPiA+IC0JCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+ICsJaWYgKCFyYXRlX25v
ZGUpIHsNCj4gPiArCQlyYXRlX25vZGUgPSBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+ICsJCWdvdG8g
dW5sb2NrOw0KPiA+ICsJfQ0KPiA+IMKgDQo+ID4gwqAJaWYgKHBhcmVudCkgew0KPiA+IMKgCQly
YXRlX25vZGUtPnBhcmVudCA9IHBhcmVudDsNCj4gPiBAQCAtNzM3LDEyICs4MTIsMTUgQEAgZGV2
bF9yYXRlX25vZGVfY3JlYXRlKHN0cnVjdCBkZXZsaW5rDQo+ID4gKmRldmxpbmssIHZvaWQgKnBy
aXYsIGNoYXIgKm5vZGVfbmFtZSwNCj4gPiDCoAlyYXRlX25vZGUtPm5hbWUgPSBrc3RyZHVwKG5v
ZGVfbmFtZSwgR0ZQX0tFUk5FTCk7DQo+ID4gwqAJaWYgKCFyYXRlX25vZGUtPm5hbWUpIHsNCj4g
PiDCoAkJa2ZyZWUocmF0ZV9ub2RlKTsNCj4gPiAtCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsN
Cj4gPiArCQlyYXRlX25vZGUgPSBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+ICsJCWdvdG8gdW5sb2Nr
Ow0KPiA+IMKgCX0NCj4gDQo+IFNpbWlsYXJseSwgaWYga3N0cmR1cCgpIGZhaWxzIGhlcmUsIGRv
ZXMgdGhpcyBsZWFrIHRoZSBwYXJlbnQncw0KPiByZWZjb3VudA0KPiBzaW5jZSBpdCB3YXMgYWxy
ZWFkeSBpbmNyZW1lbnRlZCBlYXJsaWVyIGluIHRoZSBmdW5jdGlvbj8NCg0KQW5vdGhlciBwcmVl
eGlzdGluZyBpc3N1ZS4gVGhlc2UgY29kZSBjaGFuZ2VzIGJyb3VnaHQgdGhpcyBzZWN0aW9uIHRv
DQpBcmd1cycgRXllcyBhdHRlbnRpb24uIEkgbWFkZSBhIG5vdGUgdG8gc2VuZCBhIHBhdGNoIHRv
IGZpeCB0aGlzLg0KDQpDb3NtaW4uDQo=

