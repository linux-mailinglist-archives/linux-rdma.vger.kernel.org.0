Return-Path: <linux-rdma+bounces-18588-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PmIL4jkwmm/nAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18588-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 20:22:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4E331B6E9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 20:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36DB630F99E5
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1126A0A7;
	Tue, 24 Mar 2026 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b3muFB4R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF69230D0F;
	Tue, 24 Mar 2026 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379822; cv=fail; b=EM24el/oongEtabxsnhvc8M1H2zgai9eFU2s/eVZTmXD4UVIr7TIzYhaGG6u0SbMO7qZyGK3Y4JwbUK0Sty6mMiYbaT8x9yX/wqwVUm183o/laBzAa7pZB0+jkcSIfKhF/3bTPulFHHBFaW2eVy0Hx3EUtWclgXmDF0MEmWJz2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379822; c=relaxed/simple;
	bh=eZJHSPIizTF6nl78FHJFiY4Ok469JFZ/8soRWo7IBNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNEmxAXAaaAAw9AiTfRSUJbTF8NALXXeR7c72CEKiTbrkMjYuIyawvHnWFGSaMCuQ8YxYF3cbi5QgJi5XM6PlUSwxLRoR/UyRdIVdtOGrJRP8ZSqFgIMm0TNZ8XXYtnNLzl5dSivnmB/IgIEEbPrPNj8JNO6LjHSf1PvWeKMH5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b3muFB4R; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h34opll2m8bJPVGVKLrJBLqdt/ahRqQ33qxaery/27sZZ7gNFh5EpB+QT6+3NxMjWT9G3KO+wkQVXtKD+t5bus1hO/j5q1kwaQCscSyoiVNGuFfqkKo9RaP4p7cV1yG0f0HDMUcQU76DFlN7WQ5iDONqWAMnxiphaQL6FEdwIY39ANmbM06CIBlAmmF1mv0z8RXVar8bmxIBpfrPfM53qOi1ZNNxTHiSGiqST3RkZnzLR4GlNoU6cEc2Q8w5oaYQG02oiilABQi6Kh++oQ6sP8Lh8WxF7u1he0/svhr/N4hW+oCZJ1sqaxqxVZX8+jJ0bZ6g5Ipak1YKRQsENHwfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZJHSPIizTF6nl78FHJFiY4Ok469JFZ/8soRWo7IBNM=;
 b=EYp1DZHL1P2dstbPqPmI+0jA9jziotX1MDlZwftf+zjxdfpWO2XKRsv3g4y5m+3A1eHN8cVJKV5VhMjkylDXf2pDWZkfRWBpwITT05evZpZM/8v8V2Usm0Lp5LpYbZvUBmTNLY0yTKzLSeDPLoSgAtEbOreGXY1VASc0yfrlMdc6ZIISE8PdTC8GdzWBBM4/8ktbI5HpBfvO73LsESP8ooSLeZviq95t9Vk3v+w03hDwx2vxjkHfRktVn2LLIifwPHDY6xFMBotiGZf3dB91a+y+SXa673REyH8Lz2QTeDx042JcNSNsVdhOHOMkqEO1AuLmS3SuDwprUi3Vev5OBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZJHSPIizTF6nl78FHJFiY4Ok469JFZ/8soRWo7IBNM=;
 b=b3muFB4RXjM7Qb5/yq/Ul0QzCAdY9pm+pM6U1PHuRAApI0BwwOeJwOz49YZRbXy74/JKRpuySdq9QIrIHgsgVDL0d/RACHdNvj5cZBDuc4uAquK6g+eVB1X/s13Vu6l3IlwCNEwLgDEqgMzCWiDmSatiuzt7V9VixfSMn2sZxRlMaK3l48geIhWzmPesDxypWUNoAbn47yRLfdvEhiMuTMGdhdVDLzKNBoJrpG9kX+WyHWnlMjfACuEM76RE/VLfBS3uRV3chVtEib6eT1f0XXmXOL0BOKcOG6T+Umsu22kF3Cp6eIuFb5EYBC7tvYAR1EN4jJFlccM4krehetzDcQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SA1PR12MB6728.namprd12.prod.outlook.com
 (2603:10b6:806:257::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:16:54 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9723.008; Tue, 24 Mar 2026
 19:16:54 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, Dan Jurgens <danielj@nvidia.com>, "leon@kernel.org"
	<leon@kernel.org>, Gal Pressman <gal@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"willemb@google.com" <willemb@google.com>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	"kees@kernel.org" <kees@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, Saeed
 Mahameed <saeedm@nvidia.com>, "matttbe@kernel.org" <matttbe@kernel.org>, Shay
 Drori <shayd@nvidia.com>, "dw@davidwei.uk" <dw@davidwei.uk>, Moshe Shemesh
	<moshe@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V8 06/14] devlink: Allow parent dev for rate-set
 and rate-new
Thread-Topic: [PATCH net-next V8 06/14] devlink: Allow parent dev for rate-set
 and rate-new
Thread-Index: AQHcu4oKhJZAUNYPIkSFg2MgLmHkabW+DnWA
Date: Tue, 24 Mar 2026 19:16:54 +0000
Message-ID: <a25ac72fb6a5988376690f4ac979a752a8fd79b9.camel@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
	 <20260324122848.36731-7-tariqt@nvidia.com>
In-Reply-To: <20260324122848.36731-7-tariqt@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SA1PR12MB6728:EE_
x-ms-office365-filtering-correlation-id: 44d2c3d3-c70a-4122-aeae-08de89d9e90a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 O88iT7lQWdIVj7NaU8WwAKiyUydhGFvYW/YIhtnxI9OWO99NF3jQYK5w5xab8VoR7LZ9hssr3XwVHdIZogzZjECHgIyH8vJj1Ta20szU9hPUGn64Qd0vMidZvRO/Sw94V656pxlu67xWoIUTEXrljVhTIpcxMF17VeNOseSW9KYJNoy/eqrqp5IbAxf5GkXYa4hIiqLCVe0qAONwvIUEX0yzgOmOwGYqFMpZSgho3PDr7SVuHBqQtCFcMUxJIvGt/QMFxBHTBsgOFHRWpXvXEYmRrveiVI+LhBlM+QpG44+j1KliC1XxfdlwKEwXp5647oefn2mCKpcAk1Bss4qHIU3GyF4RlfhT1Of6KDYTQ9Eb31fbrICvfZFyXXNkwlnTf53iWrzK3e8d9uTh9+c1pneQib9/DWj3wFMwRC7gqZrRs5iafNGZh562yDyRxyfy/t1OdJ4Eht2LE1EbqHjD5OAVuKnan79+MIqhUMcqe+EslK33q1JV+9Hc9GNI53UqH91RvthvaJspZ3jF7Zz5bi8mx+wrmGl/Etm5RFIp3xhpnkurUl+vTbEI5sEaMBfPMBNdOp13LbD2dvOMbUIwLD7fYjRegDx+iFhMRAiChmyabIyIHFj81ac5VXtSEuwyAZdPFIcRSz6r5VCNv0rRvhcc5/69aasW7bbFMQkjcyPVDbD5n8vmnEIZSZou3TIZLxIx9oBQVybXdWXYoEka2nxvJ/JIWNLAp9wxl0HTYOrPeWUvSimi0YLwUsjxTWLpTeK7JJ68q7xcJrtXYC6yn7Bjd1jjeyNFmDRz+vH5+PA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTNQdDNrU2dwdmtGRnpuNDIvelUxLzMwUjNkckJJQVpVSlJRME45empOUGxo?=
 =?utf-8?B?dXpDNmhVR1h6QkJjNW1LOEIrRUVjVlRYMWpFelVqRkNmR0M1VzJDWGZGWjBZ?=
 =?utf-8?B?UXRxdmdDWjk1NHpEM25jRGxvRzhEZytxYW1QRlE1YXlDZHNtNCtzSnJYSHEr?=
 =?utf-8?B?b3NEVkRrSUxjOXpxNjVXU3FJb1Z1Mko2RTZCOWdBb0taWVJxMFd2T3FZVEY1?=
 =?utf-8?B?ZVROSWdXNStiTzNnUUU5UzVSM1lDSGhCYVM3US8xQlFKcDJrclN3eG9HTnlr?=
 =?utf-8?B?UCtoL3Zscm52c2NFUFRwNlBMeTBNR1VHa3NRMkdEenMxRWl0bTBYNzRMM214?=
 =?utf-8?B?THlpaVR2YlpLcGFRaHp1aDhKS0xBRGRJa2JyVk52OVlCZFpZUEZRUFduMElO?=
 =?utf-8?B?Nmo5UTNZbHc0VkgxeDZ0RVlOd25vc2lob1ZRWjhIdlpONXU4Vm0rRUhIclhl?=
 =?utf-8?B?L3E4WWtFWVcybWQ4c0p5UVFsVk1EcXZmMFFIZ1MxSi9iRnY4WndyV3N0L2JB?=
 =?utf-8?B?Vkh1ZW1BOGhvSXBOOWJVOWlwaERFem52ZUwyYmdQTUFyejZmTjV2SnZiSkhv?=
 =?utf-8?B?b1JnRE1PMTFYcDdHVWJvdmFpOUhkMEhad1RnOThYRkYycnh4d01GVDdNOFZu?=
 =?utf-8?B?dFEyaEszNFlzYko4SlBWWDhiemZnb2hyeTJFT1BFNXV1Uk82aDNlV2h0OW95?=
 =?utf-8?B?VExlbTc0c1h1dWtETjhIenJtKzVDczRrSkRwaXgzOFc5Z3lpWVF0U0g1U09m?=
 =?utf-8?B?Q0MyNHg2NE9tTklPWkcrR2M4YXprQWpsRlRsa3hSam1HN2p0Z2FBNXdiYUQz?=
 =?utf-8?B?ME96aFhsZ0ppSkMvUUx6OURIQ0l3Mnd2RjlvM3o5em10dGRaOFFkZEZYL0lO?=
 =?utf-8?B?YlR3UEt3TXNic3drQVhyOUM1SkppODM0cUlYeEt5M3VkQTMxZngvVm9IQ3Bh?=
 =?utf-8?B?d04wUWJsLzN4TWlGbC8rN2Y0ZEI4R0MrT0xTcnpBTUJCMENQMElDdTBUcHZp?=
 =?utf-8?B?aWxXQzFpTDVGUVV5MjlYQXM0ZTNwZzdQMXBlRGtFc3ZxOTBJNWNqMy9ta0dH?=
 =?utf-8?B?WXR2dTlWRVVzRGZEMnIzUDdVU1BKZWtNcjBiT0pobGI5dEh3MVpDR3phZ1Ez?=
 =?utf-8?B?YkpzL1FuRXQ5clQ2VnZqZkpMVGFXTHJVZXNSdEt4aWxvNldKWGhjdytIZlY0?=
 =?utf-8?B?Q3doUWR0TFR2eFZNMXdNaFgyUGplYng4M3FvdUFJT3BGbE9SbW1DdE9HZUo2?=
 =?utf-8?B?TFlTR1FWRmp2YnJtdmhlVjdaQWJldStKVnBKNWxUN01kWkI0Y1Byb0JleW9t?=
 =?utf-8?B?VGZ4U0ZPbmV4eHpHeTdXMEdKVlpzTExSRHNGa01BOWtUM3FtUVZRUFNYSEw4?=
 =?utf-8?B?Q0JXL01wd0pYTVEvczZyK2R3a0poQlh1eisvcXovR3dtOTRneEpVZEhnUUtR?=
 =?utf-8?B?NDVyTjVlTTZvV1B3VTVNMEFZSVpVTWtGeUNrU1ViSThJbVBRRjI3dkZKclM3?=
 =?utf-8?B?amxCeDJJYlkyQ1ArVHJEWDhTZ2R0OU5HVGszU1FISW81dlJIb2tDUVJ3MHRQ?=
 =?utf-8?B?UW1BSlRpRGpVUzdmaXlVLzd6UmI1NTAyRGFETWczbHF4NWt2Q29iQ0xQbTc0?=
 =?utf-8?B?UThSRC94azBZQ1AzZUQxR2VsSS96N1AvVHFkbk5GbnZCOHZsclMvaVhEQmxV?=
 =?utf-8?B?Q2xCTzdZb3JyZ2JOSitLSHVzL3E2NXFtdzlpQUJ0M29XZVpMNUtTdmQ2QWt3?=
 =?utf-8?B?b1lMUmJiTTNnUzI2dDdBeDVZeEhHYnZsNkxWaklYM2V5QlQzNWkwaFBzSndU?=
 =?utf-8?B?WkZsVVFzVlQ1SDJVYWlGUjFqTHdrSW9IZXZRWG9ob05nOFBscTlWZGM0Z3lX?=
 =?utf-8?B?TEFjTXRjdTF5aFFJMjF4WlN3eXdDaFZNYjZCWmpsSWpWZzlvTiswclpOck4z?=
 =?utf-8?B?LzVpcVdJUERscm1NNzdzRG82NWxXejE4VEZXTklnTHNaSmpQRzJ3bldXSTlV?=
 =?utf-8?B?ZGRBRGM2dXdxbnlEUFh2eGZVWU1iUWpRVGh6Vy9LakM4UzBKZ1RBT2t5MnBw?=
 =?utf-8?B?UEkzekJ3REJLV1BSVjVrVnVVQTZzczFjNUVkWmlRQnQvaHRzUUVKOFBwVVZx?=
 =?utf-8?B?ZUgxUmwvVDBZbExpYzVNV05lQ1IxMEdDVWtCem80cG1Ua3VDSU5QcFV5Rjd1?=
 =?utf-8?B?SDMzVFFGNFk5eVYwTlpMQldpb0ZZem02dTJGdGpwZ0Rla0orb2VxRE9xSFo0?=
 =?utf-8?B?NTlmRm5PeFE1MHN4TUZ0OVNGQS96RXlUdEFyeHlRTjJwQXhjeWNEcy8vYmlW?=
 =?utf-8?B?cnUxZVlYS0I0QTdGUnR1YTdkMXR3RVVtU1VXMThzMkNxb0R0TjZxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEBC6BB30ECBD147AB5CCC36D37FFFD2@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d2c3d3-c70a-4122-aeae-08de89d9e90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 19:16:54.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzWKhoK83NYOSJY81E8VjEfM6bc/Bp4u6q7s2y4VJEI7yE9mDpdFdZ7L1BV8XxQ8YLyiSnx/6hwpr3e/rPlMag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,nvidia.com,vger.kernel.org,gmail.com,kernel.org,google.com,oracle.com,resnulli.us,linux.dev,linuxfoundation.org,fomichev.me,davidwei.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18588-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:replyto,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 3D4E331B6E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTI0IGF0IDE0OjI4ICswMjAwLCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+
IEZyb206IENvc21pbiBSYXRpdSA8Y3JhdGl1QG52aWRpYS5jb20+DQo+IGRpZmYgLS1naXQgYS9u
ZXQvZGV2bGluay9uZXRsaW5rX2dlbi5jIGIvbmV0L2RldmxpbmsvbmV0bGlua19nZW4uYw0KPiBp
bmRleCBlYjM1ZTgwZTAxZDEuLmY0N2E5NjU5NzJhMCAxMDA2NDQNCj4gLS0tIGEvbmV0L2Rldmxp
bmsvbmV0bGlua19nZW4uYw0KPiArKysgYi9uZXQvZGV2bGluay9uZXRsaW5rX2dlbi5jDQo+IEBA
IC00NCw2ICs0NCwxMiBAQCBkZXZsaW5rX2F0dHJfcGFyYW1fdHlwZV92YWxpZGF0ZShjb25zdCBz
dHJ1Y3QNCj4gbmxhdHRyICphdHRyLA0KPiDCoH0NCj4gwqANCj4gwqAvKiBDb21tb24gbmVzdGVk
IHR5cGVzICovDQo+ICtjb25zdCBzdHJ1Y3QgbmxhX3BvbGljeQ0KPiBkZXZsaW5rX2RsX3BhcmVu
dF9kZXZfbmxfcG9saWN5W0RFVkxJTktfQVRUUl9JTkRFWCArIDFdID0gew0KPiArCVtERVZMSU5L
X0FUVFJfQlVTX05BTUVdID0geyAudHlwZSA9IE5MQV9OVUxfU1RSSU5HLCB9LA0KPiArCVtERVZM
SU5LX0FUVFJfREVWX05BTUVdID0geyAudHlwZSA9IE5MQV9OVUxfU1RSSU5HLCB9LA0KPiArCVtE
RVZMSU5LX0FUVFJfSU5ERVhdID0geyAudHlwZSA9IE5MQV9VSU5ULCB9LA0KPiArfTsNCj4gKw0K
DQpJdCBzZWVtcyB0aGlzIGh1bmsgd2FzIG5vdCB1cGRhdGVkIGFmdGVyIGEgbmV3ZXIgdmVyc2lv
biBvZiBKaXJpJ3MNCnNoYXJlZCBkZXZsaW5rIHBhdGNoZXMgd2FzIGFwcGxpZWQgYXMgYmFzZSwg
YW5kIGFzIGEgcmVzdWx0IHRoZXJlIGFyZQ0KbmV0bGlua19nZW4gZGlmZnMuDQoNCldlIHdpbGwg
Zml4IGFuZCByZXBvc3QgcHJvcGVybHkgaW4gdjkuDQoNCkJ1dCBwbGVhc2Uga2VlcCBhbnkgb3Ro
ZXIgY29tbWVudHMgY29taW5nLg0KDQpDb3NtaW4uDQo=

