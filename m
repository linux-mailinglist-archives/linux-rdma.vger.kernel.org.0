Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD29348AA2A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 10:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349053AbiAKJKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 04:10:48 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:46519 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236757AbiAKJKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 04:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641892247; x=1673428247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zgHbpv5r6pj9KwRFNmeeWPJgux5l18UVqFleUnWx4c0=;
  b=r4J6adO6v+rnY4B61mQjOMd4w3WgJUMz1hytWAh5xinr4IwZ3491Frv6
   FTy4IMUxmqUQPXSCjbw4Va3eOriyiXlglq3q4qr7MYbeeKFCgHRKypMEc
   l9MpNObfw4ABeVHPtaZyq0bVObjSJeVI/Bi8VnjJW0ByMdwkoQpx3XQ8a
   ZHRv7e3S5CXDtm8mVDjk29MlR4bn/WZyCnsjWOw2LYQlfHoY3NDoxWydr
   Kwhz1UJDvU2Cci2STxalFcKdiSkjC3zcZEQwKI8ZODWEClebQ+VZMmoye
   QTkS3AkKs4wWbaDEfUyhg4rQrdAvPJXVsyS6vU+DzLs4/8VkTEI/8aPIh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47224973"
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; 
   d="scan'208";a="47224973"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 18:10:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAtZ6WiPb5JC8S3Cb8qFywf+oQ2m8ELHhRxQ7ojgdlQ0zW/wqckZqaG8GpuatSkkbHZbHIJtgaBCZ+UsUO/4VQrmr9rTII3ZOj9lbgraaUi6kn4jeTpD+xURfukJlUUdRsTE7S9XNo2izTmOgRLL1/9XimFmSkMtJEu6BPzNutovJTU9DGXfGJZCurVqRTOxIcgcXDStcjxWTvQWVa8bAfD3+A5LYsKFbMqJB1vyRh6cTYaFKI4sUYYIJjDLW7MtdVdYXA/VIvzhVtnutOILwiZ8HYYcCntCFf1cvyl2DkzbzdMlqwJ9VNQ0EVlrjsbYSvgmrY6/z7nkuCnfBgZIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgHbpv5r6pj9KwRFNmeeWPJgux5l18UVqFleUnWx4c0=;
 b=bjtblE4bbOCTklbdP84fCA8dUWtYX32FQj2BXCIrmFkkvuErMgZVxTe/hf4PePN6jJ0x44NVBl7Ecb3tSXFUXsg8VuZP1FoVgSebXuC15JXo+auz64XTRu+BbwtK2YBSf9XCiO5KVzNuzfwFa0zEoxj+QmozYdaueK7d4wc7gIOPn+Bdvd/od3Pm507xEgXPWwIa5qCe5mAj8FIeLnezlRbxTKJhH02C7bLBoJ6MrXOCJd7JsMyRfG5rsb/7QErjKnvwr+5AbUTxLhmryLNm1hqqaD4KFJY9RvceM3RQi3tuPbIKvOSIQtY8M6enVe0Kq5Mll9ZSqntEQKy7RQskGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgHbpv5r6pj9KwRFNmeeWPJgux5l18UVqFleUnWx4c0=;
 b=CmV7bR+hnaBc78u1tB5hzNVBdjDevepSdgYRnPVyRI/0SzI1RHdI7SRKJQ4c/9Kz3ViC9NisJf4ZwVpT5Jrz6NRROvzw6u2EIsozsqfnGYhIEt1vi8IE++pBnwByV/0nP7yMsSeRZTT4PU5XhBsQF6R1yZza23Rj5Hn1NrlO4Xg=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB3491.jpnprd01.prod.outlook.com (2603:1096:604:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 09:10:42 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:10:42 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Devesh Sharma <devesh.s.sharma@oracle.com>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBpJuJ6RKP3ud9UOOlkH1pyHpjqxdNaOAgABTbQA=
Date:   Tue, 11 Jan 2022 09:10:42 +0000
Message-ID: <61DD4990.7060908@fujitsu.com>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
 <CO6PR10MB56356364CD8AA266B4ADC2E1DD519@CO6PR10MB5635.namprd10.prod.outlook.com>
In-Reply-To: <CO6PR10MB56356364CD8AA266B4ADC2E1DD519@CO6PR10MB5635.namprd10.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e979746a-3cb0-4091-faad-08d9d4e23e51
x-ms-traffictypediagnostic: OSAPR01MB3491:EE_
x-microsoft-antispam-prvs: <OSAPR01MB34914DDC8A4CC80ECF5B495383519@OSAPR01MB3491.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5t9SMTptnOngOY34hvKmf4lo29/yp7HOpSeZv5slsXnBCV2/mecqo7bjow9ZHNCnJN1Q2m9UcpUFo5MF1wfvC88XRkXS3dEPxOkMZdcgkucc14byBJ7bGJpA7dWr/DX0wIN0BptUNs74BBtw6xGLFe4U1fX1JFrpc5UdSYn0NLNW7r3ExTNXMZYZfDIsho+Y+0EUyGm790m3eZDEDRmYh6Dn6FB7Ia1DE+AuSdWH3B0Nl7NHKjOuhbHGKOnoZfSTKRJqFe52aTMtXyXZxRF/TYcDjD7FtctrJsCLDQkdemst+pUIEo0AZV7VVBnY90fT2Wt8if3aPvA0vnZkNTih1nohrsJpDdVyn+/i6XGsMRCVkQzWl7iXJkVzrJbXK/5p7dnaoa+tlGdNYXKmVOWjq5hpamxdz9WkYi888GqRLyI6t9VRtFEpjN+K02DjJQDOOQUre6z6TC6Rs6WtXT9FkGD8fbjUQ0U8il7nKp09L6G2h/fyfedlWCSSui3gdlgDMMADaQPwOJLo2Hmqk66qIvEDrYuoQrdXyfSvZ3RsRoi7mrOTWU54vHBkw7O4ZKpAvT/BOWMxe4mBABDWChpHqWLrLQuOkrG1+1wsIC/F2WyeLlRdExge1jRRVDZc87RK5fV02fNsMee3NmgDHr2RLJNUsNgMWir4em1uXALoDR3FHSDmqBXQ8QdWoSXxALuUGARbbAMOLCIeb5fPygUT9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(33656002)(122000001)(64756008)(66446008)(66946007)(86362001)(91956017)(71200400001)(66556008)(8676002)(76116006)(83380400001)(38070700005)(6506007)(5660300002)(38100700002)(8936002)(6512007)(66476007)(53546011)(85182001)(186003)(2906002)(316002)(26005)(54906003)(82960400001)(6916009)(36756003)(508600001)(6486002)(2616005)(87266011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d2R5UWl0OTQ4eVJYa0FQVzR0U3E0ckF1UHNlL280Y2xITGR1c2VkYkxNSWli?=
 =?gb2312?B?bk5hYWZLbUR5Vk8rWEtxREJtWlFMVlZVdUtJellCbHZHeFJEdmJOWFR6c2lF?=
 =?gb2312?B?QlV0YjdlVWFRTVNMWnR0T0lEeUFhWmFxMzNkVk8vaTN4elJYZkpCay9OL0VG?=
 =?gb2312?B?SzJDSDlEMTRvdVpTRExSMG9UdldxMEZEd1E4TlUwWUJiUjhlaEp2ajg1NENP?=
 =?gb2312?B?Ym1OK3B4TUVtbUpyY0QzVXBSTkVJY3Z4MFZtTHZqVXpmRU1aV1hzQjdkcjF6?=
 =?gb2312?B?anJneVdkc0IvUVh6Y3lPN0E2WlRzaVRic1BIWEFWZk41Nk9nd2pmWGNBRjdj?=
 =?gb2312?B?N1ZlcjBXTFA1d0lDVFFITStCYjZ2TzFCVGtNdmYzcEtIa3dxS2hSSHlBTnl5?=
 =?gb2312?B?MURZTDJ6N0pJRk9kOXZWOEVIbVpQT29iTzR0R0VhN25ZbWQ0YmxKSmRWNEVw?=
 =?gb2312?B?MnNFSGRtSDFIYkFhSksxMjV4V2lUSEUxVEtzRTBZMWRQM01tYnUrdnMxellH?=
 =?gb2312?B?a3pVNGV6UXU1aStQc3FaVktRbFRzN211c1lwenRrVUEyaVNrMzZ0VGFuZkFw?=
 =?gb2312?B?WlhIVVF0S01MNzEyM21WQ3hPQTExR0ZoQnYxeGR0TEN3RmhHRVZ0U3owV3JV?=
 =?gb2312?B?T0dBa1d1K2hKTjIrS0Q0TW50RXNVaXpmRU9MWU4vbThIZjdTcEk1RHZYZ3Zu?=
 =?gb2312?B?WElxaU11QU1wOWJEVU5jRjN0Z3llQVVsbzdkZVlkY3YvVUhZT21Ja2JDQWRI?=
 =?gb2312?B?cEhxUTVTYm1ZSU1hcHBqenl3eUNoZjk3N3pHRCtkMEVFN2RMaFQza0QzQUx3?=
 =?gb2312?B?elczTEdoVmtocHlSOHhoRE5wMHJiZmtPb29PZCtNTlZFbmZwZVdyZTlzRnJB?=
 =?gb2312?B?ZnJkTHVEYmFzY21WVG5PUnA5N3RjWU9ianRIV0dIK0x6SlhQYWZhdW5tZmVX?=
 =?gb2312?B?NENyRms5N3Z6NktjWW5BM1hSMmR1SG1aUXdQRk9acm5aekxyKzBrdjNiOS8w?=
 =?gb2312?B?c2EvVTFBZ3Jrc0FKUkpwWVRGVnRxN0RwRFAyUHAvdzhNcEc1Z1htcUVrZ0wy?=
 =?gb2312?B?L09xOWxqR25mWVY2czdodVRmMnh1SEo5ckZteEhKVWM3T3BZVjlHS0ZUbUxp?=
 =?gb2312?B?NHp5K2JvM2VoSytBbERKVk1MTkJoRXRJL2dIaHRkWll5OVZPWisvYU5iek9n?=
 =?gb2312?B?emZQS3VoWVBobWpJRlg0S1N3bDRIUjljQUZlYnE2c3ZTdll4VE9UT1hnaEZm?=
 =?gb2312?B?b0V5YUNjMDdtaE5nSWZTaDFpMWJZMzUvY2tnV0RLTVZHczlLeCsvcWJNU0Ev?=
 =?gb2312?B?MFdGTkwrbjhqdlNiTnY5Sno0NGpwK21Ramo1MHlxeUtjMU1QV3l0VUt6U0Na?=
 =?gb2312?B?aU44VmZub0E3ZW9pUURJb3Fqd0d3aGg4NHV5K3dxajJNRHpHYno1dGxiVjlO?=
 =?gb2312?B?cW5Ma3BDYzN3UDNHSjBXRVM4TkpyOXFMOWVqVStmODNIVEk5S04yVlNvNG9j?=
 =?gb2312?B?MXFJU3NpRmFkMnhNOXM3L1lFdnpKSEZ4L3pyL0gyT0NQNTYwbDVlczlhR1p5?=
 =?gb2312?B?MmJlSklLUW92ZjJFM20zb0hzK3NJT3B6by9XZUFQcHExbkZTYnV6eFQrUDJk?=
 =?gb2312?B?U0hVK1hkMm9vT216VDkxVXZ5c3FhNjRLdjZ1V1E0QjNWL0xmRHpnclJleHZk?=
 =?gb2312?B?b2srQWNhZ3hyZVNwSmdCL0tmWWZSSlJTWlpIU2N0aFNRU3BWcjkyUjhHM3Z3?=
 =?gb2312?B?eTNUbUdvNVhCYUlaQ2crN3JoOGZKcENoVEpnK0paUURUU1pyMlY3a0pReVZ5?=
 =?gb2312?B?VHhGaG1BWk1qS2JOYnNYbkprWEVqY2l2dEJ1ZGRnTUJXMXE3cUNnMVQxbmRj?=
 =?gb2312?B?aU5mOWk0S1k3MjhTUG0wbEpEdGFuU1d0OTY2UjNwWGQ5OUp3emJHN3V1ZXJQ?=
 =?gb2312?B?T25saXZJN3c2WGtkaDRZZW9CS1dNakZDUGlVTGsweFRJZkJoVXV5LzZTUnVT?=
 =?gb2312?B?QXZoZE51QjFYUk5uUkJBazRDTFliR2h6OFJqbGJDUWNuTFlmMGZTR0pWcisv?=
 =?gb2312?B?bGdpSDRyM0RpT3Y1VWtNaE5nK1hITzNwcFN4QmtKalZ5ZUJVMWRHY0t3QUc0?=
 =?gb2312?B?aFZ2QmJ0bm1PcDV3OGE1dGViTFk4dTRreUpZcmhJczVsMFFyS2h4TjZsTE1q?=
 =?gb2312?Q?UQ+901osFHXD6DVIcDbB2d8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <106E6729E3E1F746B4D182F12C8D521D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e979746a-3cb0-4091-faad-08d9d4e23e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 09:10:42.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VOgTuPe1w2tBprfiQWExOans15ErrhiU+6vY2ZUuJvCVbDVj2bfT3XVtLB+81Aw08w63z5t27dxup9yOgYfHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3491
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzExIDEyOjEyLCBEZXZlc2ggU2hhcm1hIHdyb3RlOg0KPg0KPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IFhpYW8gWWFuZzx5YW5neC5qeUBmdWppdHN1LmNv
bT4NCj4+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTEsIDIwMjIgNzo1NCBBTQ0KPj4gVG86IHJw
ZWFyc29uaHBlQGdtYWlsLmNvbTsgbGVvbkBrZXJuZWwub3JnDQo+PiBDYzogbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmc7IFhpYW8gWWFuZzx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4+IFN1Ympl
Y3Q6IFtQQVRDSCByZG1hLWNvcmUgUkVTRU5EXSBwcm92aWRlcnMvcnhlOiBSZXBsYWNlICclJyB3
aXRoICcmJyBpbg0KPj4gY2hlY2tfcXBfcXVldWVfZnVsbCgpDQo+Pg0KPj4gVGhlIGV4cHJlc3Np
b24gImNvbnMgPT0gKChxcC0+Y3VyX2luZGV4ICsgMSkgJSBxLT5pbmRleF9tYXNrKSIgbWlzdGFr
ZW5seQ0KPj4gYXNzdW1lcyB0aGUgcXVldWUgaXMgZnVsbCB3aGVuIHRoZSBudW1iZXIgb2YgZW50
aXJlcyBpcyBlcXVhbCB0byAibWF4aW11bQ0KPj4gLSAxIg0KPj4gKG1heGltdW0gaXMgY29ycmVj
dCkuDQo+Pg0KPj4gRm9yIGV4YW1wbGU6DQo+PiBJZiBjb25zIGFuZCBxcC0+Y3VyX2luZGV4IGFy
ZSAwIGFuZCBxLT5pbmRleF9tYXNrIGlzIDEsDQo+PiBjaGVja19xcF9xdWV1ZV9mdWxsKCkgcmVw
b3J0cyBFTk9TUEMuDQo+Pg0KPj4gRml4ZXM6IDFhODk0Y2ExMDEwNSAoIlByb3ZpZGVycy9yeGU6
IEltcGxlbWVudCBpYnZfY3JlYXRlX3FwX2V4IHZlcmIiKQ0KPj4gU2lnbmVkLW9mZi1ieTogWGlh
byBZYW5nPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIHByb3ZpZGVycy9yeGUv
cnhlX3F1ZXVlLmggfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9wcm92aWRlcnMvcnhlL3J4ZV9xdWV1
ZS5oIGIvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaCBpbmRleA0KPj4gNmRlODE0MGMuLjcwOGU3
NmFjIDEwMDY0NA0KPj4gLS0tIGEvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaA0KPj4gKysrIGIv
cHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaA0KPj4gQEAgLTIwNSw3ICsyMDUsNyBAQCBzdGF0aWMg
aW5saW5lIGludCBjaGVja19xcF9xdWV1ZV9mdWxsKHN0cnVjdCByeGVfcXANCj4+ICpxcCkNCj4+
ICAgCWlmIChxcC0+ZXJyKQ0KPj4gICAJCWdvdG8gZXJyOw0KPj4NCj4+IC0JaWYgKGNvbnMgPT0g
KChxcC0+Y3VyX2luZGV4ICsgMSkgJSBxLT5pbmRleF9tYXNrKSkNCj4+ICsJaWYgKGNvbnMgPT0g
KChxcC0+Y3VyX2luZGV4ICsgMSkmICBxLT5pbmRleF9tYXNrKSkNCj4gQXJlIHlvdSBzdXJlIHRo
YXQgaW5kZXhfbWFzayB3b3VsZCBhbHdheXMgYmUgYWxpZ25lZCB3aXRoIDJeWD8NCkhpIERldmVz
LA0KDQpJIHRoaW5rIGl0IGlzLiAgaW5kZXhfbWFzayBpcyBhbHdhc3kgc2V0IHRvIDJeWCAtMSBp
biBrZXJuZWw6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpzdHJ1Y3QgcnhlX3F1ZXVlICpyeGVfcXVldWVfaW5pdChzdHJ1
Y3QgcnhlX2RldiAqcnhlLCBpbnQgKm51bV9lbGVtLA0KICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGludCBlbGVtX3NpemUsIGVudW0gcXVldWVfdHlwZSB0eXBlKQ0Kew0KICAgICAu
Li4NCiAgICAgbnVtX3Nsb3RzID0gKm51bV9lbGVtICsgMTsNCiAgICAgbnVtX3Nsb3RzID0gcm91
bmR1cF9wb3dfb2ZfdHdvKG51bV9zbG90cyk7DQogICAgIHEtPmluZGV4X21hc2sgPSBudW1fc2xv
dHMgLSAxOw0KICAgICAuLi4NCn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5n
DQo+PiAgIAkJcXAtPmVyciA9IEVOT1NQQzsNCj4+ICAgZXJyOg0KPj4gICAJcmV0dXJuIHFwLT5l
cnI7DQo+PiAtLQ0KPj4gMi4yNS4xDQo+Pg0KPj4NCg==
