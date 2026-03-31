Return-Path: <linux-rdma+bounces-18841-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEpYCIjFy2mnLgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18841-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:00:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A391369DF1
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DFB73069335
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2233E315C;
	Tue, 31 Mar 2026 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lsgSSLkd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D63AEF33;
	Tue, 31 Mar 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961644; cv=fail; b=u1lCNvmh9LPg5mNoGX/FXQPko5QqHOW+g469QppoIQcc7Tt3mluW8XmgbKqa/fXH32hMUDFUDwyH3iTpJqHbBQU/+moqi1/wN7lZ539DqNkmyvgjcoSq7i5LYl3f2EfT6KjjB3H5VgPNpNPrOToeiXO5io6gXmgOtLKk/CmiNTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961644; c=relaxed/simple;
	bh=GeM8sA8WzIps0rUCNGnxK12zqfuouuvxiQH8p9HM8E0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbhaDaTlaRw745SLn/znrIstbdQszVbO0FVjWAHM0D/NcDWSjuh4i1egRBLJ1ytQebdcfk/DWgxmOQSec/OGcg/B2W8S2GBWJYeXR60BnqhPTq59LGqVVEuqLAUh91/m71y/rX9/h5QEa/C5qgSt2TGCIXZBfJwLuaL2hXOZMGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lsgSSLkd; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EysFGKY7VLFcncIb1L6J3oDDlFfTC/IArBfCNvXruiyLFoI+DdnkYAv8Zs3towN3WjQrZmBQVHS8Ui9858wu/CmIRufjFjOjhOLkSCVLDJtvYQKBGMfz5yjgAbsEVRVV1cB/fL+X0WnNBpsrvxD7I4m8hVyjAZCtEJ5HJHQr0vf6+7RPv2UpAGE/unszDDkf0BgGGkyAB/wyMce+16jmivVBnivuQfkqjHBnPlwE7SHLE8JlCKz717M4jf1FVmbiPluoMVP7Dbpci08r/d9XTSFLErIz9czU/hQnhBBDO1Whot1ZdvLLKY1T9juGqSj+nAkaJAVZxKFrssR5ZNunlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeM8sA8WzIps0rUCNGnxK12zqfuouuvxiQH8p9HM8E0=;
 b=ijfmG/S76zh5fEQoTuWivXPiFMMntcpaxukwIbrkDYQUOmsD176WXAJotHxuCUUeq9+H4P3rZYQ0dc8TTfnFOPz1grk0AB7yNSvq2eAGY6dsd99HBEPaHF7zKoFjriGip26CRRa9CVunCcMzK5Zvw6VEeq5ZBej678jym1MXVo9rXtWA1LGmTWhru1eoSmUw77dCHypig3om6Nf/PtkD9+fWJLVHi/GZSL4Zmmg3SGv4hPLbnOU92q+QiMV+KikJcM5jLrW8+1nBqSey7SKbNHWQvfZpCeA4oemMbfttWbpZDaS4phYeglYGx0BJ3OgYPS/u1x1ptXcITSt2EcGwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeM8sA8WzIps0rUCNGnxK12zqfuouuvxiQH8p9HM8E0=;
 b=lsgSSLkdoWYVZ+SWAa6fXF+l47Ku2jEb/S4m/sXqArdEe11M6hB1GlkzV3/pD6Szr6gkreecKAFMafgbla6GkFJYCS0hlRq7I7CtFFuQqaCjim7c3cY0zZxWB7lPzD15e+vdCJwqrArQFQSg6UxG9S6bMw21agHHjJ/FZxTjDcD/LAKvXImJnv+NMey9XYWhDKcQ9Qzf2akK/23FimbBdIMybujbfZAJGczH/eWzhH18aU2rlBsgJojJlgw3GL/OBIafoOFc1fNo3fitkZNCbhqYnmLBgsGQgp1tPf+f4Tr9F/BucTeydhhSDaJd9vsJCHNhA0URzCtGsGsXnjEvsw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS0PR12MB8217.namprd12.prod.outlook.com
 (2603:10b6:8:f1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 12:53:47 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 12:53:47 +0000
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
Subject: Re: [PATCH net-next V9 11/14] net/mlx5: qos: Remove qos domains and
 use shd lock
Thread-Topic: [PATCH net-next V9 11/14] net/mlx5: qos: Remove qos domains and
 use shd lock
Thread-Index: AQHcvO6IXLFzSyQsmEqavWdOpaGuYLXH7J2AgAC0WAA=
Date: Tue, 31 Mar 2026 12:53:47 +0000
Message-ID: <3bd3caead46d1965d3a7a151d0ef0a54ac78332a.camel@nvidia.com>
References: <20260326065949.44058-12-tariqt@nvidia.com>
	 <20260331020817.3525089-1-kuba@kernel.org>
In-Reply-To: <20260331020817.3525089-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS0PR12MB8217:EE_
x-ms-office365-filtering-correlation-id: 09309fdb-39c9-450a-2821-08de8f248c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 ciX/4a5X9G6vO/V5dd8N42LU/QiNjZaqgEEpLp+urTIZM5kVsRtbBJ390kYMF291dLbRktxI3TG+7zo+xK7vrLfgsltnzjnyMIb5lxxtsRS/AT12Ggw41+CISlqEO/XJnMUB/7AAnMe1DGrByUiqBDmmYKxAwKcNF+vZn+M9KcAsDiv5qi4GYn1rZs7C6C7wGAlwUV1QR9OHj/KDa1+eWE1nvI+tB8B7pPk1dMO3jBD73Mq40n7X8x2Uh3rhjNKgTTRtzmMooOJCRcvI2ON6Vaz0l2aqq5pUqWR38j1pEawxQcoEthX9L01Dl8DPwEdEGHaB9LklTAdVmdLP245o6OyLrfQDmrYeRD73hiWGGo9unL5/FAQAQhoqnik/+dtLuiRYU8+kDeLGvcp+YmzgL1M+Pq7yAEHvQxKNX2swcU9Xk4OmNA3A2hC3RCJqL8J+JqKBw0eySsusBItfqK4RAlWGT93vg+tf3qLQey1jFjseJaBhfVeUC2siSo6kmnDULLe6KM2FoZEfns45pdBDet8Tgb/FJhiU362hJ7/7QLyYTBQUZRrPgpYpOLMOWGqZTSjUc50sGPn+6YnqAtNJdiAA0g+8D8i11rfXI6p5v/NDD3WAMwHc1kkSPuWt3HwSCqFNkAj1IIRfOT4o2VFnCPkGl1LvkQFWjZinJ0WORFESHKV/fPCqy7N3S7W72blsm4H0wSggzRELwZp+l9sZkbteJBbv9jWsUtIs3NnN0BqyBRtbIfhD9OYCq6cJekehAzWKhGBhiz/Oc9/LSzEpnxx+x9g37s6VsGce8FexGE0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akkxS1lKZWVjd1E1VXhHcUI2Z1gyNTdUQkRyRlVvN283OWUwUHBhcHJ1RnVM?=
 =?utf-8?B?OElRQ1BHeVlpRTZHVGxqMkpMdXN5RzI3ZEpDY3VqUnZzWWZmK2NOdWtoeVdj?=
 =?utf-8?B?MlliMXg2T3JmUGpOK0xrTnpDRGVVSzV2K05EUjM0NVJ0L3o3c3pLWElicUhl?=
 =?utf-8?B?T1ZIbkpBVEErWDZEU2htWU9HOTFQZFFCTHpSUVBDbmw0dHBUTHc1NkhwVmly?=
 =?utf-8?B?a3BFWW91eDJ4MnlGdWlHaUZ5YUdmREFjcHhKajk5TDRudWdkV2c3VTVnQmk0?=
 =?utf-8?B?U1ZwUzg4d3ZqemcvQ3ZSekdTaXd6Rng1ZE5HUGRsVXpROHowT0VuOUV4clk0?=
 =?utf-8?B?L0xWZFhLblpsTlIwLzdQRVBSOXNodWZlM3prVmdHYTRJc2xjVWNOVWVYdk1z?=
 =?utf-8?B?K0tKMXR0RTVMLzdLUG4wT2hWZzh0QW9kVzgxUVNLeHlzZ0lvTm53NUlvYzUx?=
 =?utf-8?B?MkJybHV1ckt6eWQ3RHlPNGdVNThWb0JZUUwzcWQ4OXAxVWF0bkFHNWhhQXov?=
 =?utf-8?B?MzFzYkcwSFpTZ0lqTnRkbUVrYlJXb3lmMTQ3blhETkJQc3JOTUNxenRCQVNx?=
 =?utf-8?B?WXhrV0ttZlpjdE12UnRkUXF3UEFRNmR1VzR5QUR4UWFpR21MOUVhTGVXcXNq?=
 =?utf-8?B?aTRJaUR0YXpycEVUUTIrVE9ycU1kM0xFV25pMFhZUm9vdUUvMUpnYVdBdUpM?=
 =?utf-8?B?eXBkNThqdDZIcFlZblNDdEw1dnFkOG53aHhHTi9EdnFSQkl6MUdPQU56OW0x?=
 =?utf-8?B?dm0zc1I2VDN3SnB2RUl2ajN0UnRyVENNeG1acjhjOUQyY1IxRkdXOUh0cjZ4?=
 =?utf-8?B?TXpkR3MrN090aWg5b0JrZlYrUVE3ZzR6blhYMlIra2Y1cnNPT3VjSFo5bFhj?=
 =?utf-8?B?UmdrenI2cmliQTh6c3pkQmRaL1UwdTlBVE8rTERGMkhvYlcvUEY3N3djWUcr?=
 =?utf-8?B?ZXpEWnNWN082YUhUcWRtQy91RmtHa3gwbGxHaE9DOWVSTCtvRkE2empjLzdv?=
 =?utf-8?B?b0FxQnBrcXpjK3Fxc2x2MENrZS9jSHFiVXJRcGo3V2JYVVgrRTlZUEpGeDNl?=
 =?utf-8?B?dFVQMGt0S05jcTFyWkZQQXlxTkVsWnQwSzFselNqeXlwc3JNMFdJRXpKdVh1?=
 =?utf-8?B?ZXdoWlBRYjczNll6QzE4UTNKUnV3S2V3RlZBWnNzM1NYNjk0UmE3VytaRkNK?=
 =?utf-8?B?aE1RSnhabXJXRUQ3REFYL1JjKzJqMXo5b1FYQldnMkMzN0VBeTFUVFpQcklp?=
 =?utf-8?B?dGxVdm05cDB6Q041ejJvZDdDa0VCRngvV3c1czFLdXVHYWVoQTRWczM1dkEr?=
 =?utf-8?B?c0tjVk9RS05DVDdpL0tpa2pZSTZ3dnNCcGdZZ1ZMMHBNS0t1S2dXaG9ycW9T?=
 =?utf-8?B?bnhERlBsVzg3bnNMOEVMY1cvdlFXV0F5cDYyYmFUcWF4MjhsRWF3T2pyWDdx?=
 =?utf-8?B?QnVJYTdNb0ZtVFBITUh2dk5QMHZXUjZtSXdlcCtlaHNYNzRCN0Yrdjh2Rm9u?=
 =?utf-8?B?bEtJaEcrWkNDM2VHZDR2TU9tWklkOVlhWUU1L1NJdktnRFRMSEZPQU15cGs0?=
 =?utf-8?B?TDhIeFU2cWRlMVlXb3VnbHVTUGFoNDZVUzJ0dVdiMFRDb1FwUUJlNWE0VmhM?=
 =?utf-8?B?cXJHNnhpNmhWbFJzUXNJZkRRS2toQzN5aXNVdlNpNXZ5UG5WZEh1NDhncERV?=
 =?utf-8?B?elByQWczVXJHR1RvQkdJbUNUS2paYUYydTducFFMSGx6TGZWRGZ5K21oWGJT?=
 =?utf-8?B?NzJjT3dlWnBVWkRrb2plNm04NmNDY01PTzJmR2MxTGlrU05sK01Gd2lKZ2tk?=
 =?utf-8?B?dE1JR1c3RElMN1FObEFmQVNRcHhpWWdWVVBLVk9mTDl1YVpWeTVDUFRENVdr?=
 =?utf-8?B?cEFXNFhXVHFhVVNCbnBSOUdXTk1PSmtRQ2xkRW1qUjZUTG0wb3J0SUNmSGJL?=
 =?utf-8?B?RzV2dU5ZeGlxVWxnU0sva002MmUwbWcyNkxUbXlZS3hueXhmS3B6SWtLRkNt?=
 =?utf-8?B?eGxsMXRYVldOdjBtVlk1b1ozSi9sWHNIMjlMZDRtZVI3K0lRZFg2dXU0aHdO?=
 =?utf-8?B?SC9RTTFaRkViZjkweUhIUGI0VzM5WHJzK05jd0ZlUnphM1dhQkRBaGU1QjFz?=
 =?utf-8?B?ZFp6R2JjcFIzaVRoK2tMdm03eFBtTmdmSlhINVZhZ0d3ekNic0wxeVNJbmdx?=
 =?utf-8?B?bnVCV0NaTVBrMzgyRkN1KzhmTnZCTDJhVXRyWHpIcVhGbnJZR1pGQkdTclpn?=
 =?utf-8?B?WmZZenRwNFk1OGRsYjFJUCtMUGpJeEZNd21CWXRUc28va3N1eVRqdDhSd2ZV?=
 =?utf-8?B?SUVYUzhFVUdqL3hHVzJ0Qjk4d2JpMzdaelh5bE02WjhIbjNYZDdBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A858F19549619B49BD8ACD605BDD52AA@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09309fdb-39c9-450a-2821-08de8f248c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 12:53:47.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFsYBY0wnRP/b5cMhA5ZutrHj8xHqlbmWcp5FaSCJMgfVKRNfj/y1NfSlvoSxxatJgfEMDSiNWoktToRs81bsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,nvidia.com,resnulli.us,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,google.com,blackwall.org,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,intel.com,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18841-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:replyto,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 8A391369DF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE5OjA4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMNCj4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxp
ZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiAtLS0NCj4gwqDCoMKgIG5ldC9tbHg1OiBxb3M6
IFJlbW92ZSBxb3MgZG9tYWlucyBhbmQgdXNlIHNoZCBsb2NrDQo+IA0KPiBUaGlzIGNvbW1pdCBy
ZW1vdmVzIFFvUyBkb21haW5zIGFuZCBzd2l0Y2hlcyB0byB1c2luZyB0aGUgc2hkIGxvY2sgdG8N
Cj4gcHJvdGVjdCBhZ2FpbnN0IGNvbmN1cnJlbnQgUW9TIG1vZGlmaWNhdGlvbnMuIEl0IGFsc28g
ZW5hYmxlcyB0aGUNCj4gc3VwcG9ydGVkX2Nyb3NzX2RldmljZV9yYXRlX25vZGVzIGRldmxpbmsg
b3BzIGF0dHJpYnV0ZS4NCj4gDQo+IExpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25l
dGRldi8yMDI1MDIxMzE4MDEzNC4zMjM5MjktMS10YXJpcXRAbnZpZGlhLmNvbS8NCj4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9kZXZs
aW5rLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9kZXZs
aW5rLmMNCj4gPiBpbmRleCA2Njk4YWM1NWE0YmZhLi5jMDUxNjA1ZmVjZDIzIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9kZXZsaW5rLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZGV2bGlu
ay5jDQo+ID4gQEAgLTM4NSw2ICszODUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldmxpbmtf
b3BzDQo+ID4gbWx4NV9kZXZsaW5rX29wcyA9IHsNCj4gPiDCoAkucmF0ZV9ub2RlX2RlbCA9IG1s
eDVfZXN3X2RldmxpbmtfcmF0ZV9ub2RlX2RlbCwNCj4gPiDCoAkucmF0ZV9sZWFmX3BhcmVudF9z
ZXQgPQ0KPiA+IG1seDVfZXN3X2RldmxpbmtfcmF0ZV9sZWFmX3BhcmVudF9zZXQsDQo+ID4gwqAJ
LnJhdGVfbm9kZV9wYXJlbnRfc2V0ID0NCj4gPiBtbHg1X2Vzd19kZXZsaW5rX3JhdGVfbm9kZV9w
YXJlbnRfc2V0LA0KPiA+ICsJLnN1cHBvcnRlZF9jcm9zc19kZXZpY2VfcmF0ZV9ub2RlcyA9IHRy
dWUsDQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc3RhdGVzIHRoYXQgZW5hYmxpbmcNCj4gc3Vw
cG9ydGVkX2Nyb3NzX2RldmljZV9yYXRlX25vZGVzDQo+IG5vdyBpcyBzYWZlIGJlY2F1c2UgbWx4
NV9lc3dfcW9zX3Zwb3J0X3VwZGF0ZV9wYXJlbnQgcmVqZWN0cyBjcm9zcy0NCj4gZXN3DQo+IHBh
cmVudCB1cGRhdGVzLg0KPiANCj4gV2hlbiBhIHVzZXIgcHJvdmlkZXMgYSBERVZMSU5LX0FUVFJf
UEFSRU5UX0RFViBiZWxvbmdpbmcgdG8gYW4NCj4gdW5yZWxhdGVkDQo+IGRldmljZSwgdGhlIGRl
dmxpbmsgY29yZSAoZGV2bGlua19ubF9yYXRlX3BhcmVudF9ub2RlX3NldCkgZHJvcHMgdGhlDQo+
IGxvY2sgb24NCj4gdGhlIHBhcmVudCBkZXZsaW5rIGFuZCBjYWxscyBkZXZsaW5rX3JhdGVfbm9k
ZV9nZXRfYnlfbmFtZSgpLiBUaGlzDQo+IGZ1bmN0aW9uDQo+IHRyYXZlcnNlcyB0aGUgcmF0ZV9s
aXN0IG9mIHRoZSB1bmxvY2tlZCBwYXJlbnQgZGV2bGluayBpbnN0YW5jZS4NCj4gDQo+IERvZXMg
dGhpcyBsZWF2ZSB0aGUgZGV2bGluayBjb3JlIGV4cG9zZWQgdG8gZGF0YSByYWNlcyBhbmQgcG90
ZW50aWFsDQo+IHVzZS1hZnRlci1mcmVlIHZ1bG5lcmFiaWxpdGllcywgc2luY2UgdGhlIGRyaXZl
cidzIHJlamVjdGlvbiBjYWxsYmFjaw0KPiBleGVjdXRlcyBvbmx5IGFmdGVyIHRoaXMgbG9ja2xl
c3MgbGlzdCB0cmF2ZXJzYWwgaGFzIG9jY3VycmVkPw0KDQpJIHdpbGwgYWRkcmVzcyB0aGlzIGJ5
IGFkZGluZyBjb21tb24gYW5jZXN0b3IgdmFsaWRhdGlvbiBpbiBkZXZsaW5rDQpyYXRlIGNvcmUs
IHdoaWNoIHdhcyBtaXNzaW5nLg0KDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3L3Fvcy5jDQo+ID4gYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3L3Fvcy5jDQo+ID4gaW5kZXggMGJlNTE2MDAz
YmNkZS4uZjY3Zjk5NDI4OTU5ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZXN3L3Fvcy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vzdy9xb3MuYw0KPiA+IEBAIC0xMTEwLDcgKzEwNjgs
NyBAQCB2b2lkIG1seDVfZXN3X3Fvc192cG9ydF9kaXNhYmxlKHN0cnVjdA0KPiA+IG1seDVfdnBv
cnQgKnZwb3J0KQ0KPiA+IMKgCXN0cnVjdCBtbHg1X2Vzd19zY2hlZF9ub2RlICpwYXJlbnQ7DQo+
ID4gwqANCj4gPiDCoAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZlc3ctPnN0YXRlX2xvY2spOw0KPiA+
IC0JZXN3X3Fvc19sb2NrKGVzdyk7DQo+ID4gKwlkZXZsX2xvY2soZXN3LT5kZXYtPnNoZCk7DQo+
IA0KPiBDb3VsZCBlc3ctPmRldi0+c2hkIGJlIE5VTEwgaGVyZT8NCj4gDQo+IEluIG1seDVfc2hk
X2luaXQoKSwgaW5pdGlhbGl6YXRpb24gaXMgZXhwbGljaXRseSBza2lwcGVkIGZvciBub24tUEYN
Cj4gZGV2aWNlcywNCj4gbWVhbmluZyBTdWItRnVuY3Rpb25zIChTRnMpIGFjdGluZyBhcyBFLVN3
aXRjaCBtYW5hZ2VycyB3aWxsIGhhdmUgYQ0KPiBOVUxMDQo+IHNoZCBwb2ludGVyLiBJZiB0aGUg
ZGV2aWNlIGxhY2tzIFZQRCBkYXRhLCBwY2lfdnBkX2FsbG9jKCkgcmV0dXJucyAtDQo+IEVOT0RF
ViwNCj4gY2F1c2luZyBtbHg1X3NoZF9pbml0KCkgdG8gcmV0dXJuIDAgYnV0IGxlYXZpbmcgZGV2
LT5zaGQgYXMgTlVMTC4NCj4gDQo+IFdoZW4gUW9TIG9wZXJhdGlvbnMgYXJlIGF0dGVtcHRlZCBv
biB0aGVzZSBkZXZpY2VzLCBjYWxsaW5nDQo+IGRldmxfbG9jaygpDQo+IGRlcmVmZXJlbmNlcyB0
aGUgcG9pbnRlciwgd2hpY2ggY291bGQgY2F1c2UgYW4gaW1tZWRpYXRlIE5VTEwgcG9pbnRlcg0K
PiBkZXJlZmVyZW5jZSBhbmQga2VybmVsIHBhbmljLg0KDQpSaWdodC4gVGhpcyBpcyBhIHJhY2Ug
d2l0aCBKaXJpJ3MgZml4IChbMV0pLCB3aGljaCBjaGFuZ2VkIHRoZQ0KYXNzdW1wdGlvbiB0aGlz
IGNvZGUgd2FzIGFyY2hpdGVjdGVkIHdpdGggdGhhdCBkZXYtPnNoZCBpcyBhbHdheXMNCmluaXRp
YWxpemVkLiBUaGF0IGlzIG5vIGxvbmdlciB0aGUgY2FzZSwgYW5kIHRoZSBjb25zZXF1ZW5jZSBp
cyB0aGF0DQp0aGlzIG5lZWRzIHRvIDEpIG5vdCB1bmNvbmRpdGlvbmFsbHkgdXNlIGRldi0+c2hk
IGFuZCAyKSB1c2UgYSBmYWxsYmFjaw0KbG9jayB3aGVuIGl0IGlzbid0IGF2YWlsYWJsZS4NCg0K
PiANCj4gQWRkaXRpb25hbGx5LCB0aGlzIGFjcXVpcmVzIHRoZSBkZXZsaW5rIGxvY2sgd2hpbGUg
YWxyZWFkeSBob2xkaW5nDQo+IGVzdy0+c3RhdGVfbG9jaywgZXN0YWJsaXNoaW5nIHRoZSBsb2Nr
IG9yZGVyOg0KPiBzdGF0ZV9sb2NrIC0+IGRldmxpbmstPmxvY2suDQo+IA0KPiBDb252ZXJzZWx5
LCB0aGUgZGV2bGluayBjb3JlIGludm9rZXMgZHJpdmVyIGNhbGxiYWNrcyB3aXRoIHRoZQ0KPiBk
ZXZsaW5rDQo+IGluc3RhbmNlIGxvY2sgaGVsZCwgYW5kIHRoZSBkcml2ZXIgc3Vic2VxdWVudGx5
IGFjcXVpcmVzIGVzdy0NCj4gPnN0YXRlX2xvY2sNCj4gaW5zaWRlIHRoZXNlIGNhbGxiYWNrcywg
Y3JlYXRpbmcgdGhlIHJldmVyc2Ugb3JkZXI6DQo+IGRldmxpbmstPmxvY2sgLT4gc3RhdGVfbG9j
ay4NCj4gDQo+IERvZXMgdGhpcyBpbnRyb2R1Y2UgYSBjaXJjdWxhciBsb2NraW5nIGRlcGVuZGVu
Y3kgc3BsYXQgYmV0d2Vlbg0KPiBzdGF0ZV9sb2NrDQo+IGFuZCB0aGUgZGV2bGluayBpbnN0YW5j
ZSBsb2NrPw0KDQpUaGlzIGNsYWltIGlzIGJhc2VkIG9uIHRoZSBpbmNvcnJlY3QgYXNzdW1wdGlv
biB0aGF0IGRldmxpbmsgaW5zdGFuY2VzDQpzaGFyZSB0aGUgc2FtZSBsb2NrIGNsYXNzLCB3aGls
ZSBpbiBmYWN0IGVhY2ggaXMgdW5pcXVlLiBUaGUNCmVzdGFibGlzaGVkIGxvY2sgb3JkZXIgaXMg
ZGV2bGluay0+bG9jayAtPiBzdGF0ZV9sb2NrIGFuZCB0aGlzIGRvZXNuJ3QNCmNvbmZsaWN0IHdp
dGggc3RhdGVfbG9jayAtPiBzaGQtPmxvY2suDQoNCj4gDQo+ID4gQEAgLTExNTksMjYgKzExMTcs
MjUgQEAgaW50IG1seDVfZXN3X3Fvc19zZXRfdnBvcnRfcmF0ZShzdHJ1Y3QNCj4gPiBtbHg1X3Zw
b3J0ICp2cG9ydCwgdTMyIG1heF9yYXRlLCB1MzIgbWluXw0KPiA+IMKgCXN0cnVjdCBtbHg1X2Vz
d2l0Y2ggKmVzdyA9IHZwb3J0LT5kZXYtPnByaXYuZXN3aXRjaDsNCj4gPiDCoAlpbnQgZXJyOw0K
PiA+IMKgDQo+ID4gLQllc3dfcW9zX2xvY2soZXN3KTsNCj4gPiArCWRldmxfbG9jayhlc3ctPmRl
di0+c2hkKTsNCj4gDQo+IFRoaXMgZnVuY3Rpb24gaXMgaW52b2tlZCBieSBtbHg1X2Vzd2l0Y2hf
c2V0X3Zwb3J0X3JhdGUoKSwgd2hpY2ggYWN0cw0KPiBhcyB0aGUNCj4gaGFuZGxlciBmb3IgdGhl
IG5kb19zZXRfdmZfcmF0ZSBuZXRkZXYgY2FsbGJhY2suIFRoZSBjb3JlIG5ldHdvcmsNCj4gc3Rh
Y2sNCj4gZXhlY3V0ZXMgbmRvX3NldF92Zl9yYXRlIHdpdGggdGhlIHJ0bmxfbG9jayBoZWxkLCBl
c3RhYmxpc2hpbmcgdGhlDQo+IGxvY2sNCj4gb3JkZXI6IHJ0bmxfbG9jayAtPiBkZXZsaW5rLT5s
b2NrLg0KPiANCj4gSG93ZXZlciwgdGhlIGRldmxpbmsgc3Vic3lzdGVtIGVuZm9yY2VzIHRoZSBv
cHBvc2l0ZSBsb2NraW5nIG9yZGVyDQo+IChkZXZsaW5rLT5sb2NrIC0+IHJ0bmxfbG9jaykuIEJl
Y2F1c2UgYWxsIGRldmxpbmsgbG9ja3Mgc2hhcmUgdGhlDQo+IHNhbWUNCj4gbG9ja2RlcCBjbGFz
cywgZG9lcyB0aGlzIGludmVyc2lvbiB0cmlnZ2VyIGEgY2lyY3VsYXIgbG9ja2luZw0KPiBkZXBl
bmRlbmN5DQo+IGxvY2tkZXAgc3BsYXQgYW5kIHBvc2UgYW4gQUJCQSBkZWFkbG9jayByaXNrPw0K
DQpTYW1lIGFzIGFib3ZlLCB0aGVyZSdzIG5vIEFCQkEgaGVyZSBzaW5jZSBkZXZsaW5rIGluc3Rh
bmNlcyB1c2UNCmRpZmZlcmVudCBsb2NrIGNsYXNzZXMuDQpQZXJoYXBzIFNhc2hpa28gKEkgdGhp
bmspIGNvdWxkIGJlIHRhdWdodCB0aGlzIHRvIHJlZHVjZSBmYWxzZQ0KcG9zaXRpdmVzPw0KDQo+
IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBAIC0xODU5LDEzICsxNzYzLDE1IEBAIG1seDVfZXN3X3Fv
c192cG9ydF91cGRhdGVfcGFyZW50KHN0cnVjdA0KPiA+IG1seDVfdnBvcnQgKnZwb3J0LA0KPiA+
IMKgCQkJCQkJwqAgcGFyZW50ID8gOiBlc3ctDQo+ID4gPnFvcy5yb290LA0KPiA+IMKgCQkJCQkJ
wqAgZXh0YWNrKTsNCj4gPiDCoAl9DQo+ID4gLQllc3dfcW9zX3VubG9jayhlc3cpOw0KPiA+ICsN
Cj4gPiDCoAlyZXR1cm4gZXJyOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gwqB2b2lkIG1seDVfZXN3
X3Fvc192cG9ydF9jbGVhcl9wYXJlbnQoc3RydWN0IG1seDVfdnBvcnQgKnZwb3J0KQ0KPiA+IMKg
ew0KPiA+ICsJZGV2bF9sb2NrKHZwb3J0LT5kZXYtPnNoZCk7DQo+ID4gwqAJbWx4NV9lc3dfcW9z
X3Zwb3J0X3VwZGF0ZV9wYXJlbnQodnBvcnQsIE5VTEwsIE5VTEwpOw0KPiA+ICsJZGV2bF91bmxv
Y2sodnBvcnQtPmRldi0+c2hkKTsNCj4gPiDCoH0NCj4gDQo+IER1cmluZyBkZXZpY2UgdGVhcmRv
d24sIGV4ZWN1dGlvbiBwYXRocyBzdWNoIGFzDQo+IG1seDVfdW5sb2FkX29uZV9kZXZsX2xvY2tl
ZCgpDQo+IGhvbGQgdGhlIHByaW1hcnkgZGV2bGluayBpbnN0YW5jZSBsb2NrLiBUaGlzIHBhdGgg
aW52b2tlcw0KPiBtbHg1X2Vzd2l0Y2hfdW5sb2FkX3ZmX3Zwb3J0cygpIC0+DQo+IG1seDVfZXN3
X29mZmxvYWRzX2RldmxpbmtfcG9ydF91bnJlZ2lzdGVyKCkNCj4gLT4gbWx4NV9lc3dfcW9zX3Zw
b3J0X2NsZWFyX3BhcmVudCgpLg0KPiANCj4gQmVjYXVzZSBib3RoIHRoZSBwcmltYXJ5IGRldmxp
bmsgaW5zdGFuY2UgbG9jayBhbmQgdGhlIHNoZCBkZXZsaW5rDQo+IGluc3RhbmNlDQo+IGxvY2sg
YXJlIGluaXRpYWxpemVkIGZyb20gdGhlIHNhbWUgc2l0ZSAoZGV2bGlua19hbGxvYyksIHRoZXkg
c2hhcmUNCj4gdGhlIHNhbWUNCj4gbG9ja2RlcCBjbGFzcy4NCj4gDQo+IERvZXMgY2FsbGluZyBk
ZXZsX2xvY2soKSBkaXJlY3RseSAoaW5zdGVhZCBvZiB1c2luZyB0aGUgZGV2bGluaw0KPiBjb3Jl
J3MNCj4gbXV0ZXhfbG9ja19uZXN0ZWQgY2FwYWJpbGl0eSkgd2hpbGUgYSBsb2NrIG9mIHRoZSBz
YW1lIGNsYXNzIGlzDQo+IGFscmVhZHkgaGVsZA0KPiB0cmlnZ2VyIGEgcmVjdXJzaXZlIGxvY2tp
bmcgbG9ja2RlcCB3YXJuaW5nPw0KDQpBZ2Fpbiwgc2FtZSBmYWxzZSBwb3NpdGl2ZS4gRGV2bGlu
a3MgdXNlIHVuaXF1ZSBsb2NrIGNsYXNzZXMuDQoNCkNvc21pbi4NCg0K

