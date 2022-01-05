Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103FE484BE5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 02:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiAEBAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 20:00:49 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:55694 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbiAEBAt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 20:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641344449; x=1672880449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7yCtaUsfHCKqIbAd2UGxQO0sqJ7TA34fwAuw9Mu7n0c=;
  b=LQXzRO+abk8SpKDXN5KxMvbt8OiXyJ/thuIUrHt8rMeV+cZwAQFh0GHH
   KotU22nnbBy+JGO1VugkQk1W6mpzdPLSdEPwy2pRSXdrwgpCutAD8hht4
   ZHo+mR/dQhToCqwjSlKtYYdO1XX656j7swBj+c2jKy0Wx2QLEjDbtQct3
   7elIokFbEgUSVGVDXAp3yF3iGgKK/muAc6rs/rhk8L69kPyjv3FzT6Lc/
   dd/5X9p3dljj84LXBccvDLo48cFS/MAymG3+BpsdT8GLklURHgmt7Wb8f
   NFAICb+IJWl24fdi5cZqIR4A3WkC8x7RpqlnyWi3hDiLZeWcReWtdyKnb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="46968632"
X-IronPort-AV: E=Sophos;i="5.88,262,1635174000"; 
   d="scan'208";a="46968632"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:00:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk1IcBWFIzJsV3f1x8L5VrWbW2TRkeeoAXUq4mS2NSjQRBz2pPb2smnGA5fqKifN9R5UDzgM20gZ88lzKTwqcDfXr8cJ4jsNUuGPqEgp+K23KNfwYHzQSieXSRcQNSgitVWB+7l8Uc+oXrvGpRaeunmwebMVrwQrqCVaUtraNSLSJlCk9jRH+0/3ZWRlz5+fx4yGLgLCA/9XvJpzYUWrTUblKNi4XUZhDmWikHtRNXbM/GcOY5MQ5tjlx4fJTNQsOSZEIhYAnzc7J8fm7Cm6sNwG80QosCXiWQXDFa8gZfbPITsiYRwVwUiSEIESXqAKJUQci2HECxykF0E0AML+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yCtaUsfHCKqIbAd2UGxQO0sqJ7TA34fwAuw9Mu7n0c=;
 b=eukHgWMeGa/l2Aj4ONjZ9wuTeYvbbk0hhTwuZN0c/nM2z34yrbX7DYTGH6B6XGAXE1nqkwrq+AJOdBfwHVFVhUZo5OKc2OH3LJpXDydF3+ZsQ3rTn1wArJF0bgcniQMrjI8EzjUX+Z3E1geV4YpaKlLAK9vzgl2CFQ71uw45utI1uo0baB8N2wG99ucJJVGnKd42bXR1mdvMo07jqjWyjbYfv0JRE2q8qVrQa+0EyPdKAtmVK6OXdCdyfKwDmUn8jcuXCNdllPjiYSSSUnRzbsbrYbBJuas7V0TuPKSBeuq/aaSKZq+7uvxfSGxJsSQzMPFZ+NSH44v9CJ5wTRUoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yCtaUsfHCKqIbAd2UGxQO0sqJ7TA34fwAuw9Mu7n0c=;
 b=VgQKhcEBBMFiJylyvK5eex/bEnjTa12CjFGVk+roWAIn0qh+Js0UmeYyM5wsSWvA1Nrud5o80PTTPY6OCdz3UgwUwCpzezdkAkKQPFsO6KLX9QRgGl9Lk7eMa482Qljql9ZocNWhJZdawQVh6yFxe0EbE5oPrCJpxq9JzubS4Zg=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 01:00:42 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 01:00:42 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>
CC:     "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbrMyXFTG4iC0uvkiFLA5nCQaxLae+AgAAndACAAJOUAIAGetKAgABhiwCAAKMMAA==
Date:   Wed, 5 Jan 2022 01:00:42 +0000
Message-ID: <61D4EDB6.7040504@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com> <61D4131D.5070700@fujitsu.com>
 <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
In-Reply-To: <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7587aef-2334-46d4-da01-08d9cfe6cc0a
x-ms-traffictypediagnostic: OS0PR01MB6371:EE_
x-microsoft-antispam-prvs: <OS0PR01MB6371642A7DB1F9743F35FD38834B9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BO8a6ompAbEcGktwnSK2A5Osowvp69Atdype4HN0rsi9dWGMjCEunUjxH1gihPBPw0fS8kE/NX0/mje3bluFoSw3pp0hey6AaOaqwGhh3vNRVbBMjvreEWDHGFly9o9QcoBEYpG+YS6n85AYgU5+uHg8988lfrQOX+siI08elJl+gq2uWPyj094uxx35TGmP6g4YyFgup/8T623kb3yRZol9OnwcOJ2urCzyApLpX1liNhLXiZokT9thuDjO7aE9kK8EdjfJRSJ1Ec7mjAYkMwcpyzzflipXezH5hLSOC6GPJOLETunHeIltYZYyj+2Ta2TIJSaXaEE4nQVufnU9934/54fwYOKcoTklNsdJVvjzzb/oAGshpPX53N0psfA3WXRl5C0nwt7yXAA2WnjhTlPpozDLUutvHYPPDfhaB/GuTXcwLmFd5+bB8YrhnLUKEjaRnPNhvgerBked9rE9zGTV3nqL21yb8sVqSjJG4bvYOHxjDjOD2jPxZgr5talL1r+uyU3TVjowAfzMEtvJlraF0VlaB0vXnKvzB4WyXgsfSpIj5NmmueNPT6jRe3Aj/SoGfGTtc4KGBznfIxMCOMg3INOL8NtSfcwO0JB9b7UrvexZGUXDSyA7IB+uTPgUPKnfhsKE4nzOL5lyPhFtyz8HNv/pv1o9Wul/uvPRRv/2R9DdGWmYHJry4dWShs4S10niORZ8MM2q5Xv2aVV12g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(36756003)(5660300002)(87266011)(4326008)(33656002)(26005)(71200400001)(6506007)(53546011)(6486002)(186003)(508600001)(8676002)(6916009)(86362001)(107886003)(2616005)(85182001)(54906003)(8936002)(66556008)(38070700005)(82960400001)(83380400001)(91956017)(76116006)(66476007)(66446008)(38100700002)(316002)(2906002)(122000001)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHFBNWd5bGQySFlGalRTSy9ZR2wvK1krczNjK25rb2IrV0d2R0pGOTBEQmdt?=
 =?utf-8?B?RWJwVkx0aC9rM3p4VGlManZwR0x3UXo1NlE2a2x5SnBQN1M3cEtHVjhjNGZC?=
 =?utf-8?B?b1ZEbVVlR25vbXlMaTFxYkNmT1NKUVhmSGVWU2FuVFpCQ1Y4TlVSem1na2to?=
 =?utf-8?B?UUxVNXVSdElFSGhLay8rVmJhVmIxeG9XS0x5ODdodGJkUllBd29EcEpDM0NC?=
 =?utf-8?B?bGVjNXVheWx0NFR3T21zR3FPS0F5a0FEZE1kMmtEWlpFRFQrSlR4cDYrRjd1?=
 =?utf-8?B?alh0SHJJVWNoM2R2S3BWM3oyZ2t1SVhtRkhhdUhxTWRpdG1VYmhKU3MxOGJF?=
 =?utf-8?B?R1RMZ1ZsMkpjRGtjSmNHMVpyakNSaHNmMzNRN1BHdVJTcFlBNTkrQ1E1OVR3?=
 =?utf-8?B?VHhIQkxCWGVyQ2dxbGVqdTlSbkpsNndweGF0UG9tNFRLT2hpMkczbGErUzRu?=
 =?utf-8?B?S3lkNWVzV0RWeml6alJYR0ZaM1ppYVdLNVplN3VWRVdrQkFtWndjVWE4ZXpy?=
 =?utf-8?B?UVByM05WZTJRQVJwQjRveVhpaFAxZUlvSzFmRlpkSVZUcEdXaXhjYVF5ZzJB?=
 =?utf-8?B?WnlpQ1YzOXRFRGR0YTVDRG0yY211c3h4eUdobGNib3VFU29MVHQ0bmNKUXlo?=
 =?utf-8?B?Z21vaEM1L2hBY1hiTkJud2IzbC9IY2JobGFmdmZvNEJQZFhJRkV4SUN0NmR4?=
 =?utf-8?B?T05vN1NOdVpSVUlnSmxFeEQ5MHVvcU50Uyt6U24yQVByNm9paHJmRldJR0lX?=
 =?utf-8?B?dVNPeFIybWRVeU95QUR3OU9SeHpEVEVhMjcwb1N0VG5BRGl3TzJXYWQvK0xS?=
 =?utf-8?B?ZjZTU2x4S294VXBLY213dWVBb2VxK0NBdWJkRzRPN1R6ZC91VGRQOFNVRVRK?=
 =?utf-8?B?dWFLcXZ0Q1VMcFhEdnBlSm5DTmlkN1JEdUVYWis4djg2U1pOR2U5QmNsbEtC?=
 =?utf-8?B?TmxMd2RJbHJKdWNiUEZVeERMQk11YS93SmtHcVkreDljeHVUTUN0ODl2amZn?=
 =?utf-8?B?eEJtSlVZNVhzS1pYaGtNUGNtZGRIZDlTM1BRNWRwdjdOUEJ0aEZYVVl3MjYv?=
 =?utf-8?B?UzNNcllUdW1zYmJZbFVHZWgweEE0NzBzcktrQTgvYmpEVDhMdDZPYnlMdjY0?=
 =?utf-8?B?aVBTQ3ZEWlVtMlBKcGM2VGI5WHJiWG9RZDZmendDSXB6RnlHZnNNNzlMdXVX?=
 =?utf-8?B?YlNvQUlUZXh6dGFZTGV2UDcvNitxL0twK1k0SDJ2djV4QUNUa2NiUDFyU3d6?=
 =?utf-8?B?OTY0dHN3WmNheVI1cE1Bb210RU4xYXV4QlZFZk9JVmpONVVIQjVWelBpNGVu?=
 =?utf-8?B?WjAycVdpOGgzTU9pam9TN1RGU2pqSFBxSmkzVXo3VlVMbVQ4YmZPN0pYbUp6?=
 =?utf-8?B?QW91bExWNjF1aDB2ZmVCVGNzYnUyRkxsWFNXSUhISkRtY1oveWZYQUpWRys1?=
 =?utf-8?B?UkxWdVdDNHF5dTRnYlhNcm5RUitPU3llSS9IeDIvN2lCNkpyS0dLTGw1bkNM?=
 =?utf-8?B?aHJwcVphTVhXQTVWMmhITktiQlI3a0dxdWczMkxRaDdCRCt1Tmd0QytUN1p5?=
 =?utf-8?B?d3lkcWN3Y1hoUmlNS2xFdU9XTEFmV3Z4RWhRTTRaTkowd1RHMEVlODY4ajh5?=
 =?utf-8?B?RmdXa1BDTWp0OE5ZV0laSTZ5bW5kTzd0WkVlUmttK2lZYk1IdlhXT3AybVBD?=
 =?utf-8?B?YWlvNEwxU2hFaVVlcy8rTWxPbGQrZm51OGpDSFQrenVvK0J5Wjd3MVpCVzVJ?=
 =?utf-8?B?Ymd5OTBzei82Wk5BNVhCYnhONUxlR1p0VWdQcGhjREdaYU9iUVpRanhudFlG?=
 =?utf-8?B?YWRMaW1DNnVqNXlRaWhMTE53NE55UnVWMjNBWUtGZUd4aUpoVXN3WTdiN204?=
 =?utf-8?B?THZSY2YyZzVwUkhlN3dFeGZzV3VDVjBVMzlkZjB5VGZGOE80SVVwdmxFYWh4?=
 =?utf-8?B?R0VtVUJKMmJMM2x2UFcyaXpNSEZzbTEwUGczVzlQK1BWSWppcURrbEFYdjIz?=
 =?utf-8?B?cmdkSmEwNmxHbmJBUGtEbUdtcUZwTDlCcXNuNUdSMk9QbEc3T2k3bnAwc3Vp?=
 =?utf-8?B?bnBPeERKNTl6NW9HRzdMeGpMZEc5ekVtSENhT1VOQW9nRXJHUHdaUGI1ZUlG?=
 =?utf-8?B?RW9HeDV0T1JrZU1BTDZSbGlTTG9iSjlKbDlzNmowQ3lnY3dwL05SRmFkUzRR?=
 =?utf-8?Q?FwoWxPcYD0NXcThaL4EGhk8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77DD024BEEA0B14ABCAC1DD33A53CBEE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7587aef-2334-46d4-da01-08d9cfe6cc0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 01:00:42.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChnQ6Us3pMSDlzseoIwneutbmym7AUNNiudzEh/To9+4Kr5XizuDNTE8JPBuZglA36CAFTvOOsWypFrwA4Mw5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6371
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzQgMjM6MTcsIFRvbSBUYWxwZXkgd3JvdGU6DQo+DQo+IE9uIDEvNC8yMDIyIDQ6
MjggQU0sIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3RlOg0KPj4gT24gMjAyMS8xMi8zMSAxNDoz
MCwgeWFuZ3guanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+Pj4gT24gMjAyMS8xMi8zMSA1OjQyLCBU
b20gVGFscGV5IHdyb3RlOg0KPj4+PiBPbiAxMi8zMC8yMDIxIDI6MjEgUE0sIEdyb21hZHpraSwg
VG9tYXN6IHdyb3RlOg0KPj4+Pj4gMSkNCj4+Pj4+PiByZG1hX3Bvc3RfYXRvbWljX3dyaXRldihz
dHJ1Y3QgcmRtYV9jbV9pZCAqaWQsIHZvaWQgKmNvbnRleHQsIHN0cnVjdA0KPj4+Pj4+IGlidl9z
Z2UgKnNnbCwNCj4+Pj4+PiAgICAgICAgICAgICAgIGludCBuc2dlLCBpbnQgZmxhZ3MsIHVpbnQ2
NF90IHJlbW90ZV9hZGRyLCB1aW50MzJfdCANCj4+Pj4+PiBya2V5KQ0KPj4+Pj4gRG8gd2UgbmVl
ZCB0aGlzIEFQSSBhdCBhbGw/DQo+Pj4+PiBPdGhlciBhdG9taWMgb3BlcmF0aW9ucyAoY29tcGFy
ZV9zd2FwL2FkZCkgZG8gbm90IHVzZSBzdHJ1Y3QgaWJ2X3NnZQ0KPj4+Pj4gYXQgYWxsIGJ1dCBo
YXZlIGEgZGVkaWNhdGVkIHBsYWNlIGluDQo+Pj4+PiBzdHJ1Y3QgaWJfc2VuZF93ciB7DQo+Pj4+
PiAuLi4NCj4+Pj4+ICAgICAgICAgICBzdHJ1Y3Qgew0KPj4+Pj4gICAgICAgICAgICAgICB1aW50
NjRfdCAgICByZW1vdGVfYWRkcjsNCj4+Pj4+ICAgICAgICAgICAgICAgdWludDY0X3QgICAgY29t
cGFyZV9hZGQ7DQo+Pj4+PiAgICAgICAgICAgICAgIHVpbnQ2NF90ICAgIHN3YXA7DQo+Pj4+PiAg
ICAgICAgICAgICAgIHVpbnQzMl90ICAgIHJrZXk7DQo+Pj4+PiAgICAgICAgICAgfSBhdG9taWM7
DQo+Pj4+PiAuLi4NCj4+Pj4+IH0NCj4+Pj4+DQo+Pj4+PiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8g
cmV1c2UgKGV4dGVuZCkgYW55IGV4aXN0aW5nIGZpZWxkPw0KPj4+Pj4gaS5lLg0KPj4+Pj4gICAg
ICAgICAgIHN0cnVjdCB7DQo+Pj4+PiAgICAgICAgICAgICAgIHVpbnQ2NF90ICAgIHJlbW90ZV9h
ZGRyOw0KPj4+Pj4gICAgICAgICAgICAgICB1aW50NjRfdCAgICBjb21wYXJlX2FkZDsNCj4+Pj4+
ICAgICAgICAgICAgICAgdWludDY0X3QgICAgc3dhcF93cml0ZTsNCj4+Pj4+ICAgICAgICAgICAg
ICAgdWludDMyX3QgICAgcmtleTsNCj4+Pj4+ICAgICAgICAgICB9IGF0b21pYzsNCj4+Pj4gQWdy
ZWVkLiBQYXNzaW5nIHRoZSBkYXRhIHRvIGJlIHdyaXR0ZW4gYXMgYW4gU0dFIGlzIHVubmF0dXJh
bA0KPj4+PiBzaW5jZSBpdCBpcyBhbHdheXMgZXhhY3RseSA2NCBiaXRzLiBUd2Vha2luZyB0aGUg
ZXhpc3RpbmcgYXRvbWljDQo+Pj4+IHBhcmFtZXRlciBibG9jayBhcyBUb21hc3ogc3VnZ2VzdHMg
aXMgdGhlIGJlc3QgYXBwcm9hY2guDQo+Pj4gSGkgVG9tYXN6LCBUb20NCj4+Pg0KPj4+IFRoYW5r
cyBmb3IgeW91ciBxdWljayByZXBseS4NCj4+Pg0KPj4+IElmIHdlIHdhbnQgdG8gcGFzcyB0aGUg
OC1ieXRlIHZhbHVlIGJ5IHR3ZWFraW5nIHN0cnVjdCBhdG9taWMgb24gdXNlcg0KPj4+IHNwYWNl
LCB3aHkgZG9uJ3Qgd2UNCj4+PiB0cmFuZmVyIHRoZSA4LWJ5dGUgdmFsdWUgYnkgQVRPTUlDIEV4
dGVuZGVkIFRyYW5zcG9ydCBIZWFkZXIgDQo+Pj4gKEF0b21pY0VUSCkNCj4+PiBvbiBrZXJuZWwg
c3BhY2U/DQo+Pj4gUFM6IElCVEEgZGVmaW5lcyB0aGF0IHRoZSA4LWJ5dGUgdmFsdWUgaXMgdHJh
bmZlcmVkIGJ5IFJETUEgRXh0ZW5kZWQNCj4+PiBUcmFuc3BvcnQgSGVhZGUoUkVUSCkgKyBwYXls
b2FkLg0KPj4+DQo+Pj4gSXMgaXQgaW5jb25zaXN0ZW50IHRvIHVzZSBzdHJ1Y3QgYXRvbWljIG9u
IHVzZXIgc3BhY2UgYW5kIFJFVEggKyANCj4+PiBwYXlsb2FkDQo+Pj4gb24ga2VybmVsIHNwYWNl
Pw0KPj4gSGkgVG9tYXN6LCBUb20NCj4+DQo+PiBJIHRoaW5rIHRoZSBmb2xsb3dpbmcgcnVsZXMg
YXJlIHJpZ2h0Og0KPj4gUkRNQSBSRUFEL1dSSVRFIHNob3VsZCB1c2Ugc3RydWN0IHJkbWEgaW4g
bGlidmVyYnMgYW5kIFJFVEggKyBwYXlsb2FkIGluDQo+PiBrZXJuZWwuDQo+PiBSRE1BIEF0b21p
YyBzaG91bGQgdXNlIHN0cnVjdCBhdG9taWMgaW4gbGlidmVyYnMgYW5kIEF0b21pY0VUSCBpbiAN
Cj4+IGtlcm5lbC4NCj4+DQo+PiBBY2NvcmRpbmcgdG8gSUJUQSdzIGRlZmluaXRpb24sIFJETUEg
QXRvbWljIFdyaXRlIHNob3VsZCB1c2Ugc3RydWN0IHJkbWENCj4+IGluIGxpYmlidmVyYnMuDQo+
DQo+IEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB0aGlzIHN0YXRlbWVudCwgdGhlIElCVEEgZGVm
aW5lcyB0aGUgcHJvdG9jb2wNCj4gYnV0IGRvZXMgbm90IGRlZmluZSB0aGUgQVBJIGF0IHN1Y2gg
YSBsZXZlbC4NCkhpIFRvbSwNCg0KMSkgSW4ga2VybmVsLCBjdXJyZW50IFNvZnRSb0NFIGNvcGll
cyB0aGUgY29udGVudCBvZiBzdHJ1Y3QgcmRtYSB0byBSRVRIIA0KYW5kIGNvcGllcyB0aGUgY29u
dGVudCBvZiBzdHJ1Y3QgYXRvbWljIHRvIEF0b21pY0VUSC4NCjIpIElCVEEgZGVmaW5lcyB0aGF0
IFJETUEgQXRvbWljIFdyaXRlIHVzZXMgUkVUSCArIHBheWxvYWQuDQpBY2NvcmRpbmcgdG8gdGhl
c2UgdHdvIHJlYXNvbnMsIEkgcGVyZmVyIHRvIHR3ZWFrIHRoZSBleGlzdGluZyBzdHJ1Y3QgcmRt
YS4NCg0KPg0KPiBJIGRvIGhvd2V2ZXIgYWdyZWUgd2l0aCB0aGlzOg0KPg0KPj4gSG93IGFib3V0
IGFkZGluZyBhIG1lbWJlciBpbiBzdHJ1Y3QgcmRtYT8gZm9yIGV4YW1wbGU6DQo+PiBzdHJ1Y3Qg
ew0KPj4gICAgICAgdWludDY0X3QgICAgcmVtb3RlX2FkZHI7DQo+PiAgICAgICB1aW50MzJfdCAg
ICBya2V5Ow0KPj4gICAgICAgdWludDY0X3QgICAgd3JfdmFsdWU6DQo+PiB9IHJkbWE7DQo+DQo+
IFllcywgdGhhdCdzIHdoYXQgVG9tYXN6IGFuZCBJIHdlcmUgc3VnZ2VzdGluZyAtIGEgbmV3IHRl
bXBsYXRlIGZvciB0aGUNCj4gQVRPTUlDX1dSSVRFIHJlcXVlc3QgcGF5bG9hZC4gVGhlIHRocmVl
IGZpZWxkcyBhcmUgdG8gYmUgc3VwcGxpZWQgYnkNCj4gdGhlIHZlcmIgY29uc3VtZXIgd2hlbiBw
b3N0aW5nIHRoZSB3b3JrIHJlcXVlc3QuDQoNCk9LLCBJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBp
biB0aGlzIHdheS4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+DQo+IFRvbS4NCg==
