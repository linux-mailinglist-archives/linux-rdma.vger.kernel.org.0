Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B169348D266
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 07:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiAMGnm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jan 2022 01:43:42 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:1452 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230003AbiAMGnm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jan 2022 01:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642056223; x=1673592223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DZ/fiqe01JhbAAxWJhA8SCQXcsCtV5Nd7AH01bDqwoQ=;
  b=PxY21CRcUC+lXDnjbKXqoL91P43E5VTj1lnhT7et7OfJoT7pNGPccZXR
   +aeEfnrcJvc8Pv4w3rNBWU+fyuTVbrPwGlSaVVx1dYK85D2vH8wmmYz7u
   Z/RyJva4q0uVqtqHRjC2AFyggWkhmaQABkbHQZzuTFDsvEWtokvpaZtrH
   lWv1E2UJIhRvsW0vB/zsBcYGhpukJsrassCUIZhVuXYM6LVTyu9oI9AQ8
   DkfC2sQr6EjKzGYzzGJZXjhlldEDH7d3Ih3hD6A78l9kMzWW047c3qqnk
   ErATq9SYvqB9zUqPWXcnvX+P4n/bqKRjNvMVE1papX5pD3k+af7Er0YO3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="48499226"
X-IronPort-AV: E=Sophos;i="5.88,284,1635174000"; 
   d="scan'208";a="48499226"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:43:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He7JinS+MrDKrdDDz8SZcvFRi+re8sEBk3PdMQ+DZJMF6k9Mk9NH+CX7F+G5rXL9OnZZ/ZINAAAWFfi0lkVIpDzuG4S+shv9eUNPoEZ47QlUDVO0wz8wEK0DsfHwp3xLcdekejeZD4cyOLtvM69sMdKeR6EDZQ8NUOzrO0LSDSWjxidNbs4lTZqp3gJ4nJP3jkUwAMgCBhfV6raMtfDAnoKN+fGgwMmCQpl1fHnqQ0OvFqB+fRed902n066N+V7dBBt/P/CwLrhIo35+usA57u3+k5Z3F5kaZkz6/pMHZrZWaXe+UsIs5I5gbEwnzu/bbYWGUgOFUdks4L6g4VsGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ/fiqe01JhbAAxWJhA8SCQXcsCtV5Nd7AH01bDqwoQ=;
 b=I1Qyg7XkfJWwONav3K/R1W0HLkztNZGQ1ZLjmAmbwUx1ZI1jfv0xvjmd3iAQvoCs7BGykPMdnPN4bl6KbiOykuvI/R/4hon0Oi6H3f8Coh3Dqy5qe+joeZTDwUwboDlQ5hiIcjWsaONBgLT0HjIje/Uuvl2rNX0cXRa7UBotPEYhEm7sxVIJedgyLJvZARx+ht8dSFs4ZSbau+eL4K5hIXh0+XZWezjkljVz9YyvHPObnjOCwtJ5cQTk50H3OP6YgE4neopvrCo/BTOoDS6UAtq7FMGW1O+060orwGjcel1qV/7FC/Lr4zD1i0gN0lHIrCnmulZ3cYM+0TDIWxU0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ/fiqe01JhbAAxWJhA8SCQXcsCtV5Nd7AH01bDqwoQ=;
 b=cSklNBl63HxDgsKKd3VLLd+fYIMocFwg8pPJItqr72B26vw4Oo1W2sZ4JnIc5N0pZjzLmApUlKg/svJc1f6dD76By3AnMEcWIm6RLTtyfTY/ZyMTQPd+ml26Sc8XvgUfU+/SA8hu+aWuSn82dVreLjUWftT3CiTwjvclahvRUkI=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSZPR01MB8548.jpnprd01.prod.outlook.com (2603:1096:604:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 06:43:34 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 06:43:34 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>, Tom Talpey <tom@talpey.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 03/10] RDMA/rxe: Allow registering FLUSH
 flags for supported device only
Thread-Topic: [RFC PATCH rdma-next 03/10] RDMA/rxe: Allow registering FLUSH
 flags for supported device only
Thread-Index: AQHX+8Er95KpI1UKtUu28PtoB5n6zaxgmkSA
Date:   Thu, 13 Jan 2022 06:43:34 +0000
Message-ID: <45600750-5c50-2ee4-4f7c-e03510a799a7@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-4-lizhijian@cn.fujitsu.com>
In-Reply-To: <20211228080717.10666-4-lizhijian@cn.fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eeb5b216-e562-4fde-f163-08d9d6600588
x-ms-traffictypediagnostic: OSZPR01MB8548:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8548C4860716AAF6C156A49BA5539@OSZPR01MB8548.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2S7IJDe+afF0sI2sajxIbNn+Vt9FrY7p2sspg5UhIseVtd+1lfjoHPF4P2Ziy27kuUzmS2nhYcDbqowJgc3FiMEWFSbbX41SQq6Y/JzjrdfdAfXCU9gQ/DpHVnRqDp1QQdPNSIDeyiesqkOdEmmDiTAZ72Xxnuf8VAUVuEubkFmNnfDuC6FF9L+glOrXVUYObAi3aAhOxXcKVWJis9Eoa+cXxvwDTuxXDjsXwBWgHktyfHU5j2/EHQGxtoJThBgeqt2pBUV3NJTBRfUuEbTINplyIA/3xNx5LKJj04zIigE+Gr4nXMuIu48n3TJxRBgUCdWUrhDL3VgrGxHSVVvh/E3lKWcbSKqJg+kXhrdQH03j6LGJIDjFfZN1iLQ2dYAFy+HP25BRoX06AL2KP7sY0ONIMEEqbT77W7mAXqYtCuhyF+0m8aQhNfd/hPCx0A1Wfx7p3SlWetawE6UsFtblTRmtdL7n0LXWtcKcYWAD3hj2SNCC3LqcJcT/MllsHlMxi1U7RN8Jc+UsLGvz5/udbrNT/GC7qaTCelDYeH5hsmKgrIxBT3TdL7BKoIopZfoxEnTljpohevBb0HdWydEp5mFXqFOgdwhDAwY8YL24HN0csqE6ewqL/seRW4VvxkLaDAMB0knH4KH49xJ+hBj58lRT1YlBJn5Y+0AVcNbRLRrFBrzZarbUC/cJmpv2TZeF339His7wzYZlmCBj1rUeQck7RREflik9GYMZithMgdEnwwwLLs3JS4QhwU/HcrfqOKk9rb4HSEXMIQO16C9lws0Cd5inYfWcM28qJo5U7U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(83380400001)(53546011)(6506007)(26005)(85182001)(5660300002)(2616005)(66476007)(66946007)(82960400001)(66446008)(6486002)(76116006)(36756003)(66556008)(186003)(91956017)(64756008)(7416002)(86362001)(110136005)(54906003)(316002)(8936002)(4326008)(6512007)(71200400001)(921005)(8676002)(107886003)(38100700002)(508600001)(38070700005)(31696002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG84WVdIb1FZeVQwenlKeldXZkNtVzVkaVc3UXB2T3F0SjMwZXVIaUs2SldM?=
 =?utf-8?B?SGtaeTJzc3BXQ0NrekZ0V2oyNWI1OTFLOW9LbFFFMWhiWjE1ckY1REcyeTBJ?=
 =?utf-8?B?Q21mWFdzUS9lMEVOU041dnFSUkRIMFBLWnR1VDBVbGw3R2w0QVUwRzBwcGNr?=
 =?utf-8?B?NDVjUzVDbE5DT0I3NVJVY3hMY3gwdXpDb2YvamRySmp6SnYzcnZ2NlNFSDVJ?=
 =?utf-8?B?M3IyV1hHb0h2MTB5S0pjQlRPcnBNR1MyQy9BaitpdWFsQUcrU2h4dHMrUG9N?=
 =?utf-8?B?U0txMm4xS1UvL3RyWDVleDlBM2N3UjlSaE1iZjVmb080anRmWEVRYXFCL2l1?=
 =?utf-8?B?S0I0TzdLR3o4aHpaVUxYdXRkUFJYWUNFS2FQVmIyTFVSTmtsRHlYczIzNGpF?=
 =?utf-8?B?OTNDSDlEa2F1Z0phdDMvZnNHaVhyVjNpZWJubVB4QURsN3FqKzB6amNMVDhF?=
 =?utf-8?B?ZlZxTDhDNDhCZ09WK1VKdVhySGQwRUtDQWE0WDY5aXdJdEg1cTVQUXVkOXJD?=
 =?utf-8?B?MSt6dWtscXRLbGFjdTdtRlZsUWlDUkovQWZsWFNBeUVWRGVTNjlxV2dLSVVr?=
 =?utf-8?B?Z3gwOXM5Yng4TFVxRENGQlY3Rk5mR29qS0t5QTNXYWIrY21rKzJWRG9JYUg2?=
 =?utf-8?B?RCtDY01aVzViemtZeG96ZzNNc2NJT05FbVFyWk5nK1pRRE93a2Vtenh4N20v?=
 =?utf-8?B?NGY1MVpOYjRrK0ZQVUg5UWlSSmRqc1JRWVZHc2ZGeDQ2NUluK0ZqVzhUSmN1?=
 =?utf-8?B?K2lMakxhbEJoejB0dVRpa21jSFpWN250VUVWbVV0N2R2WklRQVhmclI1RkxO?=
 =?utf-8?B?ZHFjQkVOODAvY2tiTTBJazZxOE1YOUNnQmxldkFvUmpxU1hDOEFZNVZjZnJI?=
 =?utf-8?B?SXZ0dGRLZEMycDg4MEpSY1RMZmpGcUt6by90SWk3NGp2OXJldzdtNmlmOWJv?=
 =?utf-8?B?eDFDdFBhTUZzT1FBT1FZNlNUS2V6Nmp0RHZwYWNQVU9RSHQ4djJkYTl0Mm9G?=
 =?utf-8?B?eTFqNWFUYWkySllmdUpSVmhMbncybVNBSVZ1VWxhYjZ0bHdwQ29hK3pLNXR6?=
 =?utf-8?B?MTNjQXN1Z2tNNVlIaW9kRC8yVlprMStoR2dDYXdJb1U4MStRR0FjQk9SYmdP?=
 =?utf-8?B?TTBKRHdML2pUZkxmQngvQWpqOFA2MDJQSlBCYW5EaTdtajArN3A0cDB3Y1lB?=
 =?utf-8?B?NnVKNTkxaXVkSnBJYy91MVZiODNoQlVScU16dUhUaHBNZE1CeDhOQjdDYmZN?=
 =?utf-8?B?Z1dPNVlmQ1BmSFo5Y3NzRDN0cjFsWGZnSWpwZjJWSUloM2RWcXRTODJPYWlt?=
 =?utf-8?B?TTVpSzJseVl3SUVVMW1BaGsxQi82bTR0dksxdmJJWVl6ZGxpV0k3VThiaml6?=
 =?utf-8?B?VThGRktpaDFSakEzZmd5TllnaloxdTEySkVydUN0NXVSdzYxU21IY05WNnNv?=
 =?utf-8?B?dkY1YTdUVS9td1R2dDJPMkZMVTF4OVNSNS9VN0t2NU5tRHdlWUtOZmFidXRU?=
 =?utf-8?B?ZFo1NDRxRWhnaG5rRHRLc3BlWU9WSC9VNTJwcU9SZitwUDVaZGs0VDVOSWZl?=
 =?utf-8?B?WUF0MmlwSGV1Q1BqWXZlZStyOFp1ZzMwY1kwdmZ1VW80NUJPMlZ3d2V2MC9Q?=
 =?utf-8?B?U1NwOVMvVDQxYlQ2emI1UVZIaGZnaEkzbUE1TWc0bE5qRzJSQlB1UXVjMVVq?=
 =?utf-8?B?YVJYcHh5Yyt6YjZVejk0aG9BS2ZXV3c5YTZEb1VPNEdBaEFXcmRWeHBrUGFJ?=
 =?utf-8?B?NEsybisyeTRYRW5VRlZoeDU0enhIMFpNTDhjSnFJN29zUjlheGFueVNUNW44?=
 =?utf-8?B?TmxPRy9ZM0Vwbm5QTlcvSmxQMHU3TVdEdy85YkUrc2R3RmZoTlFVNFlkazZr?=
 =?utf-8?B?USsrcjFOb2s2Z1krR1l0UFFsSjJpN21xbE9wakE1aU9mSHdIWXlCS0pySCtw?=
 =?utf-8?B?NU53ZDhYS2JMM3lkem1vbjh2dnlpSDYvSUFJYmlyQ0VsMFlDcHZRbzdvU1B6?=
 =?utf-8?B?WVZaVjFtR1FPWGF0NGlJay84azZWZ1ZsUzNJdzFrR2JXMmRydE1SWXhXeVlp?=
 =?utf-8?B?MURmekE1Lyt6UkRmTmxOeUZ6YXY2dVI3QWFTOXB1bkVVeS9lVXg3RVlhTll2?=
 =?utf-8?B?UmljVnluczlYZ0ZYbW5ZcDFvUmVabmYrczI4U2xnM1FpNWgrU250WGgzdWp4?=
 =?utf-8?Q?+bUhQ0fttzsAzSNO5AdmerU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0A1F3DBFCB1A4F88CBEE5394F98581@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb5b216-e562-4fde-f163-08d9d6600588
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 06:43:34.6763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFFUi3qXNk50S4Ls9/2iOe36+Y4ZWTrmw2otWCLFUbK+054H6Dvpj2xcLaKGbOm0p65xad2HhkLVz5TRQITdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8548
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGV5IFRvbSwgVG9tYXMsIGFsbA0KDQpJIHJlY2FsbCB0aGF0IHRoZSBTUEVDIHNheXM6DQo+IEEx
OS40LjMuMSBIQ0EgUkVTT1VSQ0VTDQo+IFRoaXMgQW5uZXggaW50cm9kdWNlcyB0aGUgZm9sbG93
aW5nIG5ldyBIQ0EgYXR0cmlidXRlczoNCj4g4oCiIEFiaWxpdHkgdG8gc3VwcG9ydCBNZW1vcnkg
UGxhY2VtZW50IEV4dGVuc2lvbnMNCj4gYSkgQWJpbGl0eSB0byBzdXBwb3J0IEZMVVNIDQo+IGkp
IEFiaWxpdHkgdG8gc3VwcG9ydCBGTFVTSCB3aXRoIFBMVCBHbG9iYWwgVmlzaWJpbGl0eQ0KPiBp
aSkgQWJpbGl0eSB0byBzdXBwb3J0IEZMVVNIIHdpdGggUExUIFBlcnNpc3RlbmNlDQoNCkRvIHlv
dSBoYXZlIGFueSBpZGVhIHRoYXQgY2FuIHRoZSBIQ0Egc3VwcG9ydCBqdXN0IHBhcnQgb2YgdGhl
IEZMVVNIIGNhcGFiaWxpdGllcy4NCkZvciBleGFtcGxlLMKgIEhDQV9mb28gb25seSBzdXBwb3J0
cyBQTFQgR2xvYmFsIFZpc2liaWxpdHksIG5vIFBMVCBQZXJzaXN0ZW5jZSBzdXBwb3J0Lg0KDQpU
aGFua3MNClpoaWppYW4NCg0KDQoNCk9uIDI4LzEyLzIwMjEgMTY6MDcsIExpIFpoaWppYW4gd3Jv
dGU6DQo+IERldmljZSBzaG91bGQgZW5hYmxlIElCX0RFVklDRV9SRE1BX0ZMVVNIIGNhcGFiaWxp
dHkgaWYgaXQgd2FudCB0bw0KPiBzdXBwb3J0IFJETUEgRkxVU0guDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4gLS0tDQo+ICAgaW5j
bHVkZS9yZG1hL2liX3ZlcmJzLmggfCA1ICsrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmggYi9p
bmNsdWRlL3JkbWEvaWJfdmVyYnMuaA0KPiBpbmRleCBmMDRkNjY1Mzk4NzkuLjUxZDU4YjY0MTIw
MSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmgNCj4gKysrIGIvaW5jbHVk
ZS9yZG1hL2liX3ZlcmJzLmgNCj4gQEAgLTI5MSw2ICsyOTEsNyBAQCBlbnVtIGliX2RldmljZV9j
YXBfZmxhZ3Mgew0KPiAgIAkvKiBUaGUgZGV2aWNlIHN1cHBvcnRzIHBhZGRpbmcgaW5jb21pbmcg
d3JpdGVzIHRvIGNhY2hlbGluZS4gKi8NCj4gICAJSUJfREVWSUNFX1BDSV9XUklURV9FTkRfUEFE
RElORwkJPSAoMVVMTCA8PCAzNiksDQo+ICAgCUlCX0RFVklDRV9BTExPV19VU0VSX1VOUkVHCQk9
ICgxVUxMIDw8IDM3KSwNCj4gKwlJQl9ERVZJQ0VfUkRNQV9GTFVTSAkJCT0gKDFVTEwgPDwgMzgp
LA0KPiAgIH07DQo+ICAgDQo+ICAgZW51bSBpYl9hdG9taWNfY2FwIHsNCj4gQEAgLTQzMTksNiAr
NDMyMCwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBpYl9jaGVja19tcl9hY2Nlc3Moc3RydWN0IGli
X2RldmljZSAqaWJfZGV2LA0KPiAgIAlpZiAoZmxhZ3MgJiBJQl9BQ0NFU1NfT05fREVNQU5EICYm
DQo+ICAgCSAgICAhKGliX2Rldi0+YXR0cnMuZGV2aWNlX2NhcF9mbGFncyAmIElCX0RFVklDRV9P
Tl9ERU1BTkRfUEFHSU5HKSkNCj4gICAJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJaWYgKGZs
YWdzICYgSUJfQUNDRVNTX0ZMVVNIICYmDQo+ICsJICAgICEoaWJfZGV2LT5hdHRycy5kZXZpY2Vf
Y2FwX2ZsYWdzICYgSUJfREVWSUNFX1JETUFfRkxVU0gpKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0K
