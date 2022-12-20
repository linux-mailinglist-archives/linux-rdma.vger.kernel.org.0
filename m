Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C20651AA8
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Dec 2022 07:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLTG2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 01:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTG2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 01:28:44 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BD1082
        for <linux-rdma@vger.kernel.org>; Mon, 19 Dec 2022 22:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1671517724; x=1703053724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lr8MQtylqhMHEpBO3kX+YvH5v9Y1k6bIq+k4BVOpGkU=;
  b=WlSyqJVJ7mHy8Cj8ENsjqCL8G6Gp7FHykUQDOEM6WPAH3zgpSbvqsy/5
   pxl89CpaXtYqGtDyQHtDMPZG0drD0N2HRbEh2rF4IZcoQ8JA6eWk/1GIG
   9Msph4qheiVsMP1TaNknfeBcjSRNxcM6AxcadxrLoEkZvVpbGfelcTOg0
   qp9fST1stauCSfSYbmYUyOoWYnLLhaSWxFZKbe1epe2htz3xgEjBuPq9H
   yD4H0EG/uDkpOTGyuHb6oBkAXEPTiGVwHJ8Coh43Ha0hkZJIC/RgpVu4q
   SEY8+Oml5xlgY4tHm69C+CBLhAwR854GihjYj4vGFHZVTfdb9lgO3JAJb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="74853027"
X-IronPort-AV: E=Sophos;i="5.96,258,1665414000"; 
   d="scan'208";a="74853027"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 15:28:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L58c4lNF8pHiqwVBU0SRLY3Z+N7d5oA2nn5YlMpiq29n5yY9uasRLpKdq/NFWySzTnR9oEnuAXz1MlKzb9qem9sP5rwJVrpzE+BcAQNJ/QVFK6cos42JDtgNfHHJ0Rct6ToWQFPSqajuQeMP3dzYn1hhaLI+C9KUvxkezRyFWTzbO1iGrDhjor8LdStk+jC06avc4Zka6hp75AIJ8L7FK0oczs8Scadb+RdALsaEI9CHyBaPTBIHXsyr9c6Mlv5VOxJ99yxorLJ03hn5A9XskwgqAF6UvirIefBLqp1Wk3gdbemaUlICfRq/tRPl5KO+l9zoc8XFVPCVhQQeNTePjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr8MQtylqhMHEpBO3kX+YvH5v9Y1k6bIq+k4BVOpGkU=;
 b=HjGJvB08vaRI+wDfcQQ7mIKX29NVoewf+Qu/WfHFVOIFgUnZoSwcNs/q/jOeyJXDiFWt6nQaaXHp9qZdZekTSjiiF+B7Wl+pD1W1dW+bnn9bjTlRcnd421VsQE0o9cYpxvupzRL7HYliPASDuhSKZP5CHUfXVJ10vyGNmYw9tbqTrFDNjCH6iNWLBDabLneBEblpFT2YvfACY1JvSPHb8x4a7LusyfzpOEH4xmSWaxIgqPpJ7EGpJu5it96a/hxIsN+9EZkZSqA5qPg8uvpBvMaPdMnreCvav2CmG1oNSauvr6X0bTtzP0m496ZNF4fl0LWvjXhYfZ0BS7z0W37Siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB10632.jpnprd01.prod.outlook.com
 (2603:1096:400:290::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:28:36 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:28:36 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Rao.Shoaib@oracle.com" <Rao.Shoaib@oracle.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix inaccurate constants in
 rxe_type_info
Thread-Topic: [PATCH v2 1/2] RDMA/rxe: Fix inaccurate constants in
 rxe_type_info
Thread-Index: AQHZE21L74W3dbgVZE6D8/RAHeaZzK52UbcA
Date:   Tue, 20 Dec 2022 06:28:36 +0000
Message-ID: <93c5f8e0-b634-4151-9a8a-0f86290d9bfd@fujitsu.com>
References: <20221219054644.4530-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20221219054644.4530-1-matsuda-daisuke@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB10632:EE_
x-ms-office365-filtering-correlation-id: 6c1778fc-cc7b-4aec-8dac-08dae2536cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03Wm6pZk2ceni0Rwy/H4nSjkkShM4IYRUUFWYV1Qe+hIMyh/j9N3GiQDNSlq4aYXtZT5MPfpxKWdGqlRZkCVfvxk7vt8Y4hQ4x+vXgrahRaAuDe+P9UCbHGmwIPOt6YflaOCyMInmgZKfjkLj01lgZJtZ3srcfDJA591yTSZu7ux8DwhYWB+FPBbBq8+abEVz7Yhx0ljWe8lPl5PNlq0caK/TyASqa2XoQ5W7VXPFGjqG6AT16OSHeA93EyYA1gM1qd6Vy4UZqkkAWzr83XIaKEl9I/vaE349mo9ZDn9LbQAJZE+ozFq+5KLVv2Ue4XT4NvG6UDuX0XYR/XzN/S3XwKW5JwHmZ7BwiYRNzzcIM9PqeJWtvsdi+QZ70LLn1SGERnXJ0gZwhzUwBgz5m3q8n0g4T4LVvgCAhsB3V0p/9iOPDJg93GWtuu0ThDZbTmKEOhL/Wi4ASxWNLm5FACosZgsu8w4ajx/0L3FLKdLikOapan+59vvOIp4sWJGh4xjASa1R6p/Maqz3ngBex3te1GXW8VrFQIWx4VPeBcyPvHpLT5GmAwZRM6Te8bDe1qkWRC018Dk2/BHhOQXkE+LqZ6oiJw97ludtYc9pyPVJYDYmRQeh7yKPveyzZJyEFVnEV0E9Ki/kEp635lD4ATxy6OTz3DK0d43O9iSGyjefKlWUB09XFXWy7XsfRPbv/Vc/RBmcoFdPH/9Mc/Y1Bk2nmA468EyCpmsNAlzuiQK3ApzcmXt/vOP6mMP9oJkU56ItpIOHiXlYn7lY/nrteTNDRRsSljNr44AXqMdG4nUa/avk1GobF6wDGTqy+ob912BIRnWXEevTzA31hKV4k18Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(1590799012)(451199015)(38100700002)(122000001)(82960400001)(83380400001)(38070700005)(66476007)(31696002)(86362001)(66946007)(66556008)(66446008)(8676002)(76116006)(5660300002)(2906002)(4326008)(64756008)(8936002)(41300700001)(6512007)(26005)(186003)(2616005)(53546011)(6506007)(110136005)(54906003)(316002)(478600001)(71200400001)(91956017)(6486002)(1580799009)(31686004)(36756003)(85182001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clF2QVNvMm1pRUpIMzRPVW91NStPQjNxR3BDM2xsT3JKSmF0bEx0NXE0K0cv?=
 =?utf-8?B?S2p4d2FmSExqay9iNDBvbFFNSjIrcDc3N2tZQzN1Rzd4V0ZLUEtLTmhHa2E3?=
 =?utf-8?B?bndlQklMUlFHOXM1OS9KcGJuL28veEM3UGZEWHMya0ExOHlFamRNWlU3K2Ra?=
 =?utf-8?B?ZmYrSW95UDZHVzNkd1FyUDd4WkJQeFBKWnFyNjhUV05OcVIyNXhwV1g0ME9S?=
 =?utf-8?B?cDNleFg5eTRmT0xad3NLRzFRdjdhY21Fa2ZvWEFVb2VPRUo2T0tZZ2NXc0dK?=
 =?utf-8?B?bktUbEhORWt2eDY5UFRTYUNoY0VsNnIxTGZ0NjdYamQreEVINHdFN3Z2TVRI?=
 =?utf-8?B?S010SGhWc1M0dHFQR3pSM1NYL2FyOWt5bXVGaUFIODFHNWtZZUtta3FIVlF1?=
 =?utf-8?B?S1RWOGVIL1ZkNk11VkJJRzhTd3ArVkpIaFlIS2t2MGc1aU9FMlBRU3FjaCtS?=
 =?utf-8?B?MDZxOVQ0Wm9OT1JsV0VSL2szR1J4cy8rdVUrK3JBaGlEdmpPbFQ0bm1PdGFK?=
 =?utf-8?B?M3ZSd2hoY1czbDVOWk5WQjNYMUM5T2ZueG0zM2h3YU5sajh6ckJnSWtuSnRh?=
 =?utf-8?B?czVrQ1hiNFVWNy9JRHJiRFBjU2wzSXhVNllPZmdmdm4yOFhyZ09VaFlKUm51?=
 =?utf-8?B?dis5U0hlZS9KWVBOS2lYVUdZRGZGZUFzY3p0SFZUaE9zL2hwUEVHN2hVcktj?=
 =?utf-8?B?Ni9Rby9xbDUydFpLRnJ6eGIxQnFROTZEZTJGYkh5Q0o2QUIvSkFRNnVXQ3Jm?=
 =?utf-8?B?U0RCcE1uT2w5OXYxdlBqSWFJUW9VZW5sWlhGZ2dxbTVZQ3BUWnRPSlVhUjFl?=
 =?utf-8?B?c3o3NXhMQVNLZ0lyUSt3a2N3OU5vd0s5eVBFVXdrZmNQQTlZaTV5QlJIa05Q?=
 =?utf-8?B?YmtEbm5XaEpDMjRCUlhCYlRONTRhOVBVUG5ocEdVdVZXMDFRNWVtL0NwMW9T?=
 =?utf-8?B?TzhIZG9OTmo4ais4RjVRQzF6U2E4Q2hKK21sZkQzK0NKbHVzZFo5WTQrKytE?=
 =?utf-8?B?SHlOdHB6enNmK0FBMHNhcUhxcHZCM3YzL3hGUE4zWGhJYTBScUhrQWh5MXhy?=
 =?utf-8?B?eE5mT2Z1c1N4cmJtaVBtSm1XU1M4MEFZK2JGZTl4bVJwcERybTEvVE5jYVdr?=
 =?utf-8?B?M09GQ1gvTmg0L2RkSFRHZTdYdStaTmgyZXByWVpKaVE0QmhXeDFRK2R1cEJH?=
 =?utf-8?B?NXJUcGpEUVFuUEJtNUtLTFhrQzN1cE95dW1NSmVBVG16bm81am16TWxxREo1?=
 =?utf-8?B?NDAyRHY2QnpKdEIwMVdLWWdPOFRyNUozZXlwdEdvSHRMWmdkQjZEVEFlR3BW?=
 =?utf-8?B?V1ZmOWFqMzg3TjdpZ1I3WlZ4Zkc4SXZYaHBXQ1dVeGVPMkVVRnYyWEE0VWdi?=
 =?utf-8?B?L2J2MG9TS3RtbXhHZnpyWVFEdjF6MlJOaUl5TmhIc2txSTB6dnhHYkxhb0t1?=
 =?utf-8?B?VjNvNGoraUZhT0dlUTV2UGF5S0NobTVMT3ZPWEFuUUZBWTlLdWNwcjlaZTBl?=
 =?utf-8?B?eEF4dXN1QVNUUVg0UXNMSXYxbGZabWFsemNpSWljVGdSNytXeUlvWUM5Q0xV?=
 =?utf-8?B?Sjk0STc3bEFROXp0UjkzSWVWcFRqNWk4ZklrYmZ3YXF3OVgzOXN1R3B4SS9E?=
 =?utf-8?B?OGZrdWtUS2hvN2RrYlBDWHpEeVd2cWxTdC9MQ2VITGFpL0kvZUNncy9rLy9p?=
 =?utf-8?B?UzlXa29UQ2doL0FBVDZuNncvd1QxMmZNVXovaFpNaUo1VkZxY1Y3cDk0Wmw0?=
 =?utf-8?B?Ny9FaXk0eFZSdE9xOC9kekZ0aG9objE4cHhvTVVTVmo1aFhac0FFYjcrVGZp?=
 =?utf-8?B?Z0pFeVJNbWhSQ1Fnb05EVVBwN1dmTEpwbHd3NzYrY1NjbVFZTmJzR3dsaVQ2?=
 =?utf-8?B?dnY4eFFrbVlvS3J3dFBPYjdOYUFqQXVoV1FNUk9CZzkyYkFhNC9Tajd1SFJD?=
 =?utf-8?B?Z0wxM1dsZFRVQWc3RW1Wb1p3ZnhTbENPUHVNUmJUSUhDeTdrVFozbjJkTlZZ?=
 =?utf-8?B?T0pwejhwRmVEa1NKUXJOb3hpZFpsL3ZpQ3IwcG8vRWZHNUgrQytrRy9OSGRj?=
 =?utf-8?B?SU5FV25pdlZoMm5DZGw0SGFiYy95WmFRMWEwRHNYamhIL3JlNHV6QVp5K1hz?=
 =?utf-8?B?bnROajNZRng1bEpRSEUySVVNcHNHUW1uY21RZWRPRU5MRU1UaVNlYklOTlVv?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEE7946AFE06A3428791110384EA9C55@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1778fc-cc7b-4aec-8dac-08dae2536cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 06:28:36.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyTeYX/pibEmoiHATS/Jf/amhYJuX2bwdg4ZhAhcO8aV6e7eFsbqkkHvXacv3MBeHSx+IclBFspEgZtz5DaOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10632
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpMR1RNLA0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQpPbiAxOS8xMi8yMDIyIDEzOjQ2LCBEYWlzdWtlIE1h
dHN1ZGEgd3JvdGU6DQo+IGlidl9xdWVyeV9kZXZpY2UoKSBoYXMgcmVwb3J0ZWQgaW5jb3JyZWN0
IGRldmljZSBhdHRyaWJ1dGVzLCB3aGljaCBhcmUNCj4gYWN0dWFsbHkgbm90IHVzZWQgYnkgdGhl
IGRldmljZS4gTWFrZSB0aGUgY29uc3RhbnRzIGNvcnJlc3BvbmQgd2l0aCB0aGUNCj4gYXR0cmli
dXRlcyBzaG93biB0byB1c2Vycy4NCj4gDQo+IEZpeGVzOiAzY2NmZmU4YWJmMmYgKCJSRE1BL3J4
ZTogTW92ZSBtYXhfZWxlbSBpbnRvIHJ4ZV90eXBlX2luZm8iKQ0KPiBGaXhlczogMzIyNTcxN2Y2
ZGZhICgiUkRNQS9yeGU6IFJlcGxhY2UgcmVkLWJsYWNrIHRyZWVzIGJ5IHhhcnJheXMiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNv
bT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcG9vbC5jIHwgMjIg
KysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9wb29sLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wb29s
LmMNCj4gaW5kZXggZjUwNjIwZjVhMGExLi4xMTUxYzBiNWNjZWEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYw0KPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9wb29sLmMNCj4gQEAgLTIzLDE2ICsyMywxNiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHJ4ZV90eXBlX2luZm8gew0KPiAgIAkJLnNpemUJCT0gc2l6ZW9mKHN0cnVjdCBy
eGVfdWNvbnRleHQpLA0KPiAgIAkJLmVsZW1fb2Zmc2V0CT0gb2Zmc2V0b2Yoc3RydWN0IHJ4ZV91
Y29udGV4dCwgZWxlbSksDQo+ICAgCQkubWluX2luZGV4CT0gMSwNCj4gLQkJLm1heF9pbmRleAk9
IFVJTlRfTUFYLA0KPiAtCQkubWF4X2VsZW0JPSBVSU5UX01BWCwNCj4gKwkJLm1heF9pbmRleAk9
IFJYRV9NQVhfVUNPTlRFWFQsDQo+ICsJCS5tYXhfZWxlbQk9IFJYRV9NQVhfVUNPTlRFWFQsDQo+
ICAgCX0sDQo+ICAgCVtSWEVfVFlQRV9QRF0gPSB7DQo+ICAgCQkubmFtZQkJPSAicGQiLA0KPiAg
IAkJLnNpemUJCT0gc2l6ZW9mKHN0cnVjdCByeGVfcGQpLA0KPiAgIAkJLmVsZW1fb2Zmc2V0CT0g
b2Zmc2V0b2Yoc3RydWN0IHJ4ZV9wZCwgZWxlbSksDQo+ICAgCQkubWluX2luZGV4CT0gMSwNCj4g
LQkJLm1heF9pbmRleAk9IFVJTlRfTUFYLA0KPiAtCQkubWF4X2VsZW0JPSBVSU5UX01BWCwNCj4g
KwkJLm1heF9pbmRleAk9IFJYRV9NQVhfUEQsDQo+ICsJCS5tYXhfZWxlbQk9IFJYRV9NQVhfUEQs
DQo+ICAgCX0sDQo+ICAgCVtSWEVfVFlQRV9BSF0gPSB7DQo+ICAgCQkubmFtZQkJPSAiYWgiLA0K
PiBAQCAtNDAsNyArNDAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ4ZV90eXBlX2luZm8gew0K
PiAgIAkJLmVsZW1fb2Zmc2V0CT0gb2Zmc2V0b2Yoc3RydWN0IHJ4ZV9haCwgZWxlbSksDQo+ICAg
CQkubWluX2luZGV4CT0gUlhFX01JTl9BSF9JTkRFWCwNCj4gICAJCS5tYXhfaW5kZXgJPSBSWEVf
TUFYX0FIX0lOREVYLA0KPiAtCQkubWF4X2VsZW0JPSBSWEVfTUFYX0FIX0lOREVYIC0gUlhFX01J
Tl9BSF9JTkRFWCArIDEsDQo+ICsJCS5tYXhfZWxlbQk9IFJYRV9NQVhfQUgsDQo+ICAgCX0sDQo+
ICAgCVtSWEVfVFlQRV9TUlFdID0gew0KPiAgIAkJLm5hbWUJCT0gInNycSIsDQo+IEBAIC00OSw3
ICs0OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnhlX3R5cGVfaW5mbyB7DQo+ICAgCQkuY2xl
YW51cAk9IHJ4ZV9zcnFfY2xlYW51cCwNCj4gICAJCS5taW5faW5kZXgJPSBSWEVfTUlOX1NSUV9J
TkRFWCwNCj4gICAJCS5tYXhfaW5kZXgJPSBSWEVfTUFYX1NSUV9JTkRFWCwNCj4gLQkJLm1heF9l
bGVtCT0gUlhFX01BWF9TUlFfSU5ERVggLSBSWEVfTUlOX1NSUV9JTkRFWCArIDEsDQo+ICsJCS5t
YXhfZWxlbQk9IFJYRV9NQVhfU1JRLA0KPiAgIAl9LA0KPiAgIAlbUlhFX1RZUEVfUVBdID0gew0K
PiAgIAkJLm5hbWUJCT0gInFwIiwNCj4gQEAgLTU4LDcgKzU4LDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCByeGVfdHlwZV9pbmZvIHsNCj4gICAJCS5jbGVhbnVwCT0gcnhlX3FwX2NsZWFudXAsDQo+
ICAgCQkubWluX2luZGV4CT0gUlhFX01JTl9RUF9JTkRFWCwNCj4gICAJCS5tYXhfaW5kZXgJPSBS
WEVfTUFYX1FQX0lOREVYLA0KPiAtCQkubWF4X2VsZW0JPSBSWEVfTUFYX1FQX0lOREVYIC0gUlhF
X01JTl9RUF9JTkRFWCArIDEsDQo+ICsJCS5tYXhfZWxlbQk9IFJYRV9NQVhfUVAsDQo+ICAgCX0s
DQo+ICAgCVtSWEVfVFlQRV9DUV0gPSB7DQo+ICAgCQkubmFtZQkJPSAiY3EiLA0KPiBAQCAtNjYs
OCArNjYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ4ZV90eXBlX2luZm8gew0KPiAgIAkJLmVs
ZW1fb2Zmc2V0CT0gb2Zmc2V0b2Yoc3RydWN0IHJ4ZV9jcSwgZWxlbSksDQo+ICAgCQkuY2xlYW51
cAk9IHJ4ZV9jcV9jbGVhbnVwLA0KPiAgIAkJLm1pbl9pbmRleAk9IDEsDQo+IC0JCS5tYXhfaW5k
ZXgJPSBVSU5UX01BWCwNCj4gLQkJLm1heF9lbGVtCT0gVUlOVF9NQVgsDQo+ICsJCS5tYXhfaW5k
ZXgJPSBSWEVfTUFYX0NRLA0KPiArCQkubWF4X2VsZW0JPSBSWEVfTUFYX0NRLA0KPiAgIAl9LA0K
PiAgIAlbUlhFX1RZUEVfTVJdID0gew0KPiAgIAkJLm5hbWUJCT0gIm1yIiwNCj4gQEAgLTc2LDcg
Kzc2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByeGVfdHlwZV9pbmZvIHsNCj4gICAJCS5jbGVh
bnVwCT0gcnhlX21yX2NsZWFudXAsDQo+ICAgCQkubWluX2luZGV4CT0gUlhFX01JTl9NUl9JTkRF
WCwNCj4gICAJCS5tYXhfaW5kZXgJPSBSWEVfTUFYX01SX0lOREVYLA0KPiAtCQkubWF4X2VsZW0J
PSBSWEVfTUFYX01SX0lOREVYIC0gUlhFX01JTl9NUl9JTkRFWCArIDEsDQo+ICsJCS5tYXhfZWxl
bQk9IFJYRV9NQVhfTVIsDQo+ICAgCX0sDQo+ICAgCVtSWEVfVFlQRV9NV10gPSB7DQo+ICAgCQku
bmFtZQkJPSAibXciLA0KPiBAQCAtODUsNyArODUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ4
ZV90eXBlX2luZm8gew0KPiAgIAkJLmNsZWFudXAJPSByeGVfbXdfY2xlYW51cCwNCj4gICAJCS5t
aW5faW5kZXgJPSBSWEVfTUlOX01XX0lOREVYLA0KPiAgIAkJLm1heF9pbmRleAk9IFJYRV9NQVhf
TVdfSU5ERVgsDQo+IC0JCS5tYXhfZWxlbQk9IFJYRV9NQVhfTVdfSU5ERVggLSBSWEVfTUlOX01X
X0lOREVYICsgMSwNCj4gKwkJLm1heF9lbGVtCT0gUlhFX01BWF9NVywNCj4gICAJfSwNCj4gICB9
Ow0KPiAgIA==
