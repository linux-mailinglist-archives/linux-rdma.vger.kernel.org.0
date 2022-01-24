Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4A4977BE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 04:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiAXDsG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 22:48:06 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:48021 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235823AbiAXDsF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 23 Jan 2022 22:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642996086; x=1674532086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K8ZENhPDvqkPQz5qK7Va0BN7me0npdLI5BxclrC2bSc=;
  b=l5DX7e37mgWke65z5vECbk31vaxpchCQOZ88su/HHCScuJqQNk/J6v08
   fidA7lLy8NCnE0eVDnFpbeeXg2X+vf5qKYOrODpqB9BU93qnQDOTz6rE/
   F0rpMvGA+gObNu6yhMtUcGpnLsM0Cr58otCfOx5Z5OVqMnSo4pXhi3feX
   mdHcuwCz3BKnGe+hPRqGwJzw9UMIGKK1OdJLZlkjCuC/lEnXBPtakVwOi
   +uTA28oQVF3BDJyM/fsEesNFWyJ5EJ6ZqsSkOip6MgXyQPjT6aRzgZY4f
   2v7/LSciZY+7xWqMVH/tQNuDPd3afpA8AbB60wNJZyi8X6hozKTFwMOSR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="48237167"
X-IronPort-AV: E=Sophos;i="5.88,311,1635174000"; 
   d="scan'208";a="48237167"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 12:48:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alFzq9n/oKEIs3oSo5SQueMqPVeWZ57hDdhpk7Hb51nWnX61ocFlVtArCEsXS3hbHTCIO5HWodWea6mn3DhuVurvMaWNglv5OKbesvzEmIpxG6iS6oHBYxPaL8dXTjSK9P/pE2GsFXzIteu4Rm1GPUqzTQcPDJggrgIvgtPhgqVnpGbk1nCPYzsbUmGRio9IYryrCkQyyF1gcWxhDEx71pzdjHUm8jgMVNGXaTh4HyJXYwXQRDiB/0VXcd4s5IhvRf81kFNroojbf+zLTKtoDdAIiYPIWwOqV5NFBljHuhUvnD5Ec2D33/RnBG5O8op/tRaCRBaZrbXZ2B0SnBZHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8ZENhPDvqkPQz5qK7Va0BN7me0npdLI5BxclrC2bSc=;
 b=VYndy3HgBUwf5bOtRP3IzzE8Pi1Uwjd9moRjzRRy0TWbEboPH24o0vrBny1NMGUVe+FmX6wwx03TUawoeXp8/JCdvo86b/niWdZ8xpaMhFycKul0U2tFmiW/7iLYSb7411mNiqdsfegfkJcW2zX6MA7i/i1iisGrcX0bN+c7H8CIX6MIojYChS491QmZJg/R4xr6Nk6zvt44fm2hproe2sugs96RiUlYwUgaJShYrr2zCLkmhR+X8TLcJd2I7WlzPm0qK+SqjtQe36zlx9R88r4Zw5nGuflEYcE1tqPSiRaZZqgyg1uFY2nqjk2eayW/C3vWIxVGu7/MaV+no0KI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8ZENhPDvqkPQz5qK7Va0BN7me0npdLI5BxclrC2bSc=;
 b=LR123FDjCHTjuVjg1+yk1AmxMbEgkTLM0vDcS0nTOsXahos8EDX3TnjJbFh7j4rTq3M0igeAuENW86zS/Vmn32pAr+LfK7PtBanDQip3P4NSHPrMwCG6ggoPXgG9WckZAgF86sMv7eR7Ls4sK9U9Y7e4+bFRP7kLUL7VDzhiJHc=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB5951.jpnprd01.prod.outlook.com (2603:1096:400:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 03:47:59 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 03:47:59 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUI91epBJvsUKhqFcN98TGpqxnOIUAgAE6fICAAExOgIAA31eAgACzaYCAAYo8AIABoJWAgAA0mwCAAACAgIAD6BYA
Date:   Mon, 24 Jan 2022 03:47:59 +0000
Message-ID: <33225e9c-a1f4-4b20-0a57-ac3a42e7fb52@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com> <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
 <20220121125837.GV84788@nvidia.com>
 <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
 <20220121160841.GD773547@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220121160841.GD773547@iweiny-DESK2.sc.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f465b9-e84d-4055-0339-08d9deec5096
x-ms-traffictypediagnostic: TYCPR01MB5951:EE_
x-microsoft-antispam-prvs: <TYCPR01MB595148DDE6E514152D3F5FCCA55E9@TYCPR01MB5951.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qyd01TzDCU8+U5oMXtUqQoVryznwVnf17o78FDlT4/7oiVJrTHwzb56WUQGE1LqZnc2ExzEy3ZSc+f/8P2jmZamu+5uFm/sgxKZaeCiHCJJUH4p6/p7bvtCtOCebnjte0SOz0QSql6++s1c3eSpsTS7whYOgOZ34GzCNVN1Z99aYKktZN9h+9YN0cW19lbgbdu1NQldLD46Qqb6n4kD1vXcxCaQonIXg6+MsmdhnQy/Ghm/hCV2UcbWiDDOArZJPO/7mRAfBdQqGL5cfYpuHz5oAWsCsuPtspylEw2KN46AeaH4bkXKzajWo7R9uQxCmKkWq5YxXWaalGcfW2zVfYQxPBaRcIh+MjfZOGOX9jEETDxVEWgheudkm8JoAYzCzJRaLGhj/pHrb0sgG08bqNwIZbPddf25al8qb16c3s2+Pyzjj5qGNZOD7xyOC28vtQYxh00mi2ReD7nRYbztG7T2+Bsnv4S3JOGaWzd3E3pJHS1NdLo6rFkgFIj9qQwXwOYnjX74BRnWn8sirdwVH2Hl0/7mYIJXmu5uuLldt95fLLWBq2V81zzaLWPG6BQMEB/vf8RnP/Q+h/2rJB1ay6pLA58I5PbAJ4tZvFrDTN0uDy5IdeD2JRCJplFeJpnvWklPhdwslJQ7wKfqYQKC8iHKxt7bWu4vH4oA0ufXy3PmAeUGDfQInQ9hAMs4xk8gB/FZG5NNqt//RnH1yLIJad9M9zmFPP+iR7E2KgAN3EGx+ZU0K9q1Kiki8Ih1/f0/zanKtPvbZGIexDO5Uo5Imvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(86362001)(2616005)(66556008)(6486002)(36756003)(6512007)(110136005)(83380400001)(8936002)(31686004)(31696002)(508600001)(82960400001)(2906002)(66946007)(38070700005)(6506007)(53546011)(26005)(186003)(5660300002)(54906003)(76116006)(91956017)(66446008)(38100700002)(316002)(8676002)(122000001)(85182001)(64756008)(4326008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWwyZDB3QTNJZWRjbTc5U2N2UmlRalVGUjU2NzBaRU9ielhkNVk5dTE5d2ky?=
 =?utf-8?B?dkx5YXZzdnF0ZE1UYmtlbmk2bnEvVWxNTEkrUzhmVUQzamFhOG5Vc3pVUHVl?=
 =?utf-8?B?ZzB5KzQ1elJ4YUN0NDY4VE1WSFBvbllBV09ZeDEzdUFrajZONHpQMkU0ZXJ4?=
 =?utf-8?B?Y3N5YlZkejJ2YzVKRXBqMEpvVWRJSi9vZ3BNUzJvbDYrWWQyWTFzU29RbzE2?=
 =?utf-8?B?dkRpVm45UVh4dXo2RzN4ckV6VFloMWVneUZScHMyWGw4RXQ4ajB2TmQ4ZmRh?=
 =?utf-8?B?OVcwL1dDZUllMjNvS1UzQkdBcjEvOG5VNkl0MTczb1N4Z1VKa2ZBQ0F5R0Y3?=
 =?utf-8?B?SHJKUDdJdllzRmxhRG1hTk1BV3d4MWtJOFNUNFJTMlY5bjlwa3UrWFRhWDlI?=
 =?utf-8?B?cFlVbW5ybTU5V2FhVDA2bEpveTJVZG0wRjJaakRzQnJETjRiaitMNGs2ZHFr?=
 =?utf-8?B?cUtWWVNJT3ZnS0NKODJjbC9hUklPeGI3RFJydjJ6OUd1RkZ0UlMvV2s5eHhw?=
 =?utf-8?B?Sk1RUGljeGtSREdUNUM5M0lSVFFNQWU2NXRMdDlBTVlBQXMvQXR2QllUSUl5?=
 =?utf-8?B?aGlXUm5rT3oxb01tREVnVDYxVHhYVEdpRjlnSFdvNW5ReEo4TnpLekR6Q3B2?=
 =?utf-8?B?TFQvMkd2WndOUTBsNndXcEJqZkJGQk5hR2VXRHlVRFdmeFpzcHNvVjdTNU91?=
 =?utf-8?B?Wkk2bVZNK3RoWVl0bGNHOEpQN01ZQjFWQ3pzTFh3QStEWXo1S2o2N1d4SHNR?=
 =?utf-8?B?QWtqeHM4MHZLWmp5OHFSR1dyNjNqR1F0YWxWWjBqWEVlOVBNaE1KL2FqNE9i?=
 =?utf-8?B?eXJlKzdqTUlpcWhoMTRiK0ZnWnZmTzlhTW5HTVE2UHhiS2Q0bktkMms3blUx?=
 =?utf-8?B?ZnFDazMvSlc0UTg2Y3RZcUFja0VETFRzZTMyVW4wc1NMSEZheUhuSjZoVUZP?=
 =?utf-8?B?Q1FtUFZBMnhrc0VjRUw5czRvMllmeVpGY1pja2lheEJQWVd1VER1UHE1RGZ2?=
 =?utf-8?B?YWt2dHUwNjNWQnJPSXppTjJnSVNSYUtaamlZaVJYMkZUczJBcjQwcDUyT2Jx?=
 =?utf-8?B?L3RZeUk5R01tVTBXSmpraSs4TmtXdnB2ellwdmFuckY2NTJJcVZqSi9JeEda?=
 =?utf-8?B?RGVYUVdnRXI2K1NCVUJ6Y1RUalVQOXJQb1FxZEtxY0swT0RYTGZmMXBaVGdT?=
 =?utf-8?B?VEZQODRpS2pLbkRsRk43VGlEdVVMdUJiR2RpWVJWOEJEa0lReUNyMEpOcUJU?=
 =?utf-8?B?REk5cVNwK3VudFdTaFRrZ0FvMW9GZnZ2YVlNeWZiWkFHWjllQWRrRVB6VmVJ?=
 =?utf-8?B?YXJnSlhDSkIrNEpZYVFnNDEydEpWNVBuMkxhM0JrVGlvTjRqbmdrY2UxN1hK?=
 =?utf-8?B?ekFlMStFcHQ4OHNxejFLTlNVMW5pQml2c0huaHZXb2FjYzN1UzJEOWt1bWpR?=
 =?utf-8?B?NDQyNUtaY1U4U3lZSWxITTBRbE1IOVhDcWZtck9NNkgyNERpRis4RHdTak02?=
 =?utf-8?B?eVRDZGNkTFVoYThDaUJXMzJ2U3hObXVxQzA0L21MaEQ1akMrSjBBb3ZNMnNv?=
 =?utf-8?B?OXIrYzhoOU5Fd2tiNXJYWnFrdUZYcFdSOHJMWWw1V2J2M2JjaVJ2ejNSaWtp?=
 =?utf-8?B?d2YvcTRMYjc0Smw0TnVyQnBRS3p2RldqYVFXOXovSGJQaWpYbit5ejl6Q25X?=
 =?utf-8?B?L3hRbyswYUxscGpneDVQY2VISkIvM2Q3Tjk4OGptQUhtMzdEMmd5VHRienFm?=
 =?utf-8?B?em5pS3NCUFhWVlFhejJOMGRIWmtnVEJ0QXllWWJ4Q1V3bmhUTE9iZzR3STB5?=
 =?utf-8?B?SXNQbm9DWHJ3ZWpkSGplZ1M2bzQrbW5yZmZrR0hTQTZjZzNGV2taUnM2OUcv?=
 =?utf-8?B?bzBvMUlBdzAxN2JrUnZMc01BZllOSUVrazkvYlpyUS8wVGk3RWF0ZjNlY2s3?=
 =?utf-8?B?SlhxUkhjRGgzSEZwNUlUZTJHVHFxaW5hYmhXK295S2kyTTI4WFJwaUNNcGho?=
 =?utf-8?B?VytZVHFoWnp2NGhMK1JlcVdRN3VVV2FVN1RQUXZQcmFSYU5oSllQSXdzeEFO?=
 =?utf-8?B?dTl0SHlVYTBrT2lsQllVNy9WL0Z1QWNGUkNSMWxHWjdWdERKZitOUmxPeFAy?=
 =?utf-8?B?VkpQWXR4Unlwb2w4M0loeEdkYWc0ejdjTFRuZjJGcGxkMkhHZ2g2TFAzTmFZ?=
 =?utf-8?Q?GCjwgiH+4H6iXkR/r9JEGUY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E74A249367D3041A87768C4D50CE663@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f465b9-e84d-4055-0339-08d9deec5096
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 03:47:59.4511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNwfs2XctciJxJMrRXUECnRtoWL/qZrjSrORymjVV600yfWJR7ji+oQk7EwE0PotbIQ1HVuguN6ZxWzhjehX2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5951
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SmFzb24gJiBJcmENCg0KDQpPbiAyMi8wMS8yMDIyIDAwOjA4LCBJcmEgV2Vpbnkgd3JvdGU6DQo+
IE9uIEZyaSwgSmFuIDIxLCAyMDIyIGF0IDA4OjA2OjU0QU0gLTA4MDAsICdJcmEgV2VpbnknIHdy
b3RlOg0KPj4gT24gRnJpLCBKYW4gMjEsIDIwMjIgYXQgMDg6NTg6MzdBTSAtMDQwMCwgSmFzb24g
R3VudGhvcnBlIHdyb3RlOg0KPj4+IE9uIFRodSwgSmFuIDIwLCAyMDIyIGF0IDA4OjA3OjM2UE0g
KzA4MDAsIExpLCBaaGlqaWFuIHdyb3RlOg0KPj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+Pj4+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfbXIuYw0KPj4+PiBpbmRleCAwNjIxZDM4N2NjYmEuLjk3OGZkZDIzNjY1YyAxMDA2
NDQNCj4+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPj4+PiBA
QCAtMjYwLDcgKzI2MCw4IEBAIGludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVfcGQgKnBk
LCB1NjQgc3RhcnQsIHU2NA0KPj4+PiBsZW5ndGgsIHU2NCBpb3ZhLA0KPj4+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVt
X2J1ZiA9IDA7DQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0NCj4+Pj4NCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHZhZGRyID0gcGFnZV9hZGRyZXNzKHNnX3BhZ2VfaXRlcl9wYWdlKCZzZ19pdGVy
KSk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
LyBGSVhNRTogZG9uJ3QgZm9yZ2V0IHRvIGt1bm1hcF9sb2NhbCh2YWRkcikNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0ga21hcF9sb2Nh
bF9wYWdlKHNnX3BhZ2VfaXRlcl9wYWdlKCZzZ19pdGVyKSk7DQo+Pj4gTm8sIHlvdSBjYW4ndCBs
ZWF2ZSB0aGUga21hcCBvcGVuIGZvciBhIGxvbmcgdGltZS4gVGhlIGttYXAgaGFzIHRvDQo+Pj4g
anVzdCBiZSBhcm91bmQgdGhlIHVzYWdlLg0KPj4gSW5kZWVkIEphc29uIGlzIGNvcnJlY3QgaGVy
ZS4gIEEgY291cGxlIG9mIGRldGFpbHMgaGVyZS4gIEZpcnN0DQo+PiBrbWFwX2xvY2FsX3BhZ2Uo
KSBpcyBvbmx5IHZhbGlkIHdpdGhpbiB0aGUgY3VycmVudCB0aHJlYWQgb2YgZXhlY3V0aW9uLiAg
U28NCj4+IHdoYXQgeW91IHByb3Bvc2UgYWJvdmUgd2lsbCBub3Qgd29yayBhdCBhbGwuDQoNClRo
YW5rcyB5b3UgYWxsIGZvciB0aGUgZGV0YWlscyBleHBsYW5hdGlvbi4gSXQgKmRvZXMqIG1ha2Ug
c2Vuc2UuDQoNCg0KDQo+PiAgIFNlY29uZCwga21hcCgpIGlzIHRvIGJlIGF2b2lkZWQuDQo+Pg0K
Pj4gRmluYWxseSwgdGhhdCBwYWdlX2FkZHJlc3MoKSBzaG91bGQgYmUgYXZvaWRlZCBJTU8gYW5k
IHdpbGwgYmUgYnJva2VuLCBhdCBsZWFzdA0KPj4gZm9yIHBlcnNpc3RlbnQgbWVtb3J5IHBhZ2Vz
LCBvbmNlIHNvbWUgb2YgbXkgd29yayBsYW5kcy5bKl0gIEphc29uIHdvdWxkIGtub3cNCj4+IGJl
dHRlciwgYnV0IEkgdGhpbmsgcGFnZV9hZGRyZXNzIHNob3VsZCBiZSBhdm9pZGVkIGluIGFsbCBk
cml2ZXIgY29kZS4gIEJ1dA0KPj4gdGhlcmUgaXMgbm8gY2xlYXIgZG9jdW1lbnRhdGlvbiBvbiB0
aGF0Lg0KPj4NCj4+IFRha2luZyBhIHF1aWNrIGxvb2sgYXQgcnhlX21yLmMgYnVmLT5hZGRyIGlz
IG9ubHkgdXNlZCBpbiByeGVfbXJfaW5pdF91c2VyKCkuDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXg0K
PiBTb3JyeS4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSSBt
ZWFudCByeGVfbXJfY29weSgpLi4uDQoNCmlvdmFfdG9fdmFkZHIoKSBpcyBhbm90aGVyIHVzZXIg
YnkgcHJvY2Vzc19hdG9taWMoKS4NCg0KDQoNCj4NCj4+IFlvdSBuZWVkIHRvIGttYXBfbG9jYWxf
cGFnZSgpIGFyb3VuZCB0aGF0IGFjY2Vzcy4gIFdoYXQgZWxzZSBpcyBzdHJ1Y3QNCj4+IHJ4ZV9w
aHlzX2J1Zi0+YWRkciB1c2VkIGZvcj8NCg0KSUlVQywgcnhlX3BoeXNfYnVmLT5hZGRyIGlzIHVz
ZWQgZm9yIHBlcm1hbmVudGx5IG1hcHBpbmcgYSB1c2VyIHNwYWNlIGFkZHJlc3MgdG8ga2VybmVs
IHNwYWNlIGFkZHJlc3MuDQpTbyBpbiBSRE1BIHNjZW5lLCBSRU1PVEUgc2lkZSBjYW4gYWNjZXNz
KHJlYWQvd3JpdGUpIExPQ0FMIG1lbW9yeSBhbGxvY2F0ZWQgYnkgdXNlciBzcGFjZSBhcHBsaWNh
dGlvbiBkaXJlY3RseS4NCg0KDQo+PiBDYW4geW91IGp1c3QgbWFwIHRoZSBwYWdlIHdoZW4geW91
IG5lZWQgaXQgaW4NCj4+IHJ4ZV9tcl9pbml0X3VzZXIoKT8NCg0KSXQgY2FuIGJlIGluIHRoZW9y
eSwgYnV0wqAgSSdtIG5vdCBzdXJlLiBASmFzb24sIHdoYXQncyB5b3VyIG9waW5pb24uDQoNCg0K
PiByeGVfbXJfY29weSgpLi4uDQo+DQo+IElyYQ0KPg0KPj4gSWYgeW91IG11c3QgY3JlYXRlIGEg
bWFwcGluZyB0aGF0IGlzIHBlcm1hbmVudCB5b3UgY291bGQgbG9vayBhdCB2bWFwKCkuDQoNCldl
bGwsIGxldCBtZSBzZWUNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KPj4NCj4+IElyYQ0KPj4NCj4+
PiBKYXNvbg0K
