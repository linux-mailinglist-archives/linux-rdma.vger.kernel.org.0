Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140545FF8E7
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 09:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJOHAj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJOHAf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 03:00:35 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D23473C
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 00:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665817231; x=1697353231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Po1nUBP5T/xqof1SNVoGuv9Iwblse8pMCUb4kKM5/r4=;
  b=UctbBuFg9iWIs+DCNm1645pbPUR1iaAsLf+tGdtRuD1IoniRSo+rlNuI
   C3NF6L1tluySEV2LqvaRYeNFHnuUXNCmhqLGOMK/B1gdAAgkCGUjxmfoe
   J3NDjbOJ4hR47keew4zvYPlg4Ke118zXnSCxFDdiPrGndVm37DOdRk2gq
   Iw8GPA7J1fyeAq3tnSp+tcqiICvvPGXjA3FOmckJoeetPWIuk+ONeU48b
   uYqMErDq9Wpjut8Bo5oS2vfmnpcWYRlSxAif79hrIkQOUfjryP/NifgqT
   3l/GamKe05gfO9eM1+q2nlBs1crCdyUmolQMGdUfzZA37eRhlWFdfle5Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67689753"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67689753"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp+vP4zrRkggKHIqDeeU1eBQfGm4H7+1CPhoqwxwwLR7VgQHUgpmfV5GvfU8MHxEq99uyR+0kx6zgRMD5tqP3BSRM5nkTq+DM3+QWFypOL8oeo6fwgrhmNfcbm/xr8nY91FP7/nixqMAE3QG1vervoJdi1M7OWxbSzMQ4cZwPbydkWIqWknGRRyQU51lMdp5UZCk/I10SjPMrrDMyxHp7GA6VxLZefKMOC4RXC+VTbGiXGIRPn4fA2NF56wTwczBRxXmmwfGrZTZCLlilmCs0wiR/UYryrAMAkVvQuWafWpwkmhhfTGEZL/kVA2zEbfy6SfMwNevzbLOLTNrzhj3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po1nUBP5T/xqof1SNVoGuv9Iwblse8pMCUb4kKM5/r4=;
 b=QfIHBeNUjkLt2aQ675TRL8gecXoGp6CmE7b08QoE82QS7uHVYI74uqZ5Nzt+BtESfBW6nqWSGXLxYsdo3q2/iRMPd1A3Vv4IXq8FeKGGOwgrSRIV/y65MNz/AmJqrg/mo4xxO/dJTjxL4efJmBbB+FJjmwkIdxPi08jzzg9so9JbEAsTsMxY1LosN5UrrI3j5oQBUUljKnch5P7DBDZreBIDJZsl60J4MKyXQbI12oe4FYnz3BhVsSQnTsVsI2Zc43JLUqwYjBt5DUM3G1Vm3636X+ixoLEIVsEriBrPJgo0fDdvyd7X7dg9eTvztD6mCnQadMaRc+91DtDQNpuK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 06:37:07 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100%6]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:37:07 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v6 5/8] RDMA/rxe: Make requester support atomic write on RC
 service
Thread-Topic: [PATCH v6 5/8] RDMA/rxe: Make requester support atomic write on
 RC service
Thread-Index: AQHY4GCLwS0zgfjsPUu2hvsrSYqV8A==
Date:   Sat, 15 Oct 2022 06:37:07 +0000
Message-ID: <20221015063648.52285-6-yangx.jy@fujitsu.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
In-Reply-To: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB8661:EE_
x-ms-office365-filtering-correlation-id: 3dbc3261-ceb8-4b85-30f3-08daae77ae1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WoRTva9QJt6YsWxCq0g5Nd9k750uIdlBs376DyPbBv7C0Wtti0DUEX0w6syr2uHl3bQFap6deBn051dBcTPxdv31HwJlYnmGvcKabyRD8b1AGh9sh/fpnIBMYWGafjtK0pU2cdc7i1cWSJyC63W51oKOmb/4BxmX+iLhzDrxKnXdk7j3j2k2s2QCFREK8WYVC7Uqph8deoTrQmZ2iem5nvas8G9rXw395pCNKsTPNiaO7+/nf+Py0HUqtZIFsTqvCHpFm4rN6eqStmG6o2s+nmpDIx8tJTxMDft1MPXOfwvrULKKO/p1GhtZ1o0D7rnW1GSk9oozw72JjzUP3XOQI71K/+7ah7VEsONEkcXCKLpHTcH9v0Bqa6H/AtV+4CvkDLkinYsWd7mPHvvcpdlCpsFpsWTceYsumM6ys5wDTO7z/jzCof5aNvltF7MkElR+OEXO+WANECt5yUDQYneCobTMAQPUK8bJEye+I632wv3vvmLEeyhlUC0nfg3vVt/YcJRIIDSX85GmyIMuOk/leEnTEmb7TQce1vUVUqExVEtANBt1MigXxVaS5TKDkJr/1cDxC20CBG1To9Tg8qZYkV2gcBQeDqb2Wu+yeqCMuEDsd+gRIfb52nTw90ABEeoP/qmr1a5jk1di3+U1zSFzNtBiNJvq45N3p16aymY6KB9XNv6nRozC4/VtzcPwAGQvVMMegB1qOy4D0Z7oML3mk/cbUqjFSAszEeTqLz8hWRydd+E+N/dKLDHpevqD23BNjRAQ8TFd3T5OqyI6uqi7kxfx/wHFcsnE/4GAYAF1aHG0XMPxUIReE52OpP1AKkSoxKb7pQJlTXVY7ECgU5lQ9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(83380400001)(8936002)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003)(375104004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YjV3Qi9Wa3Avdm5tcTA0dWE5dlhEY0Qxb3hLVmlzQXBvRWc4TFlQNzJQV2tm?=
 =?gb2312?B?d0JtSnZGbzNFemtQdFFhaHhXeUlkR3d6amZmVEZ2OUd6NVJlZ1FhdFZMWTZu?=
 =?gb2312?B?RlVIbW5lUmlVL09LOXlNdjBQZG0vdjRXRy9aMXJLcXBlWTNHRmVTU2E0SHZi?=
 =?gb2312?B?dVNMMVJncVBCR1ljWVczTTV6VTRTVFkrdGdDREN1bGNIR2lvOWxuaHE1RndB?=
 =?gb2312?B?VVRyc0F2YUlnQ2psTCs5YXgreHZZQ2VNYTlTUUhFanNrM0pUYkxqaTJSQmVh?=
 =?gb2312?B?NWJwNFlZdXUrTERmamhTZGJ2QjZqV0R0WWwvcmZYbHVJY0JxWEN2NU8xNmZp?=
 =?gb2312?B?M3E0ZFY3cEJOSTNkSlpUb0NvOTZ1dWlCZUppMFRpMTlJalcwdk9OWVFRdjBn?=
 =?gb2312?B?ZTlvbXZmVW1KVFpWTEdoTEpzQXVjZ0lYWm9DWlpNWmNFbzIxUnJXNTR5ZU01?=
 =?gb2312?B?ZVRBb1d2N3lYNm1QVnF4TGVkcGs3Y1U3V1lXWERGbzNLbytXeVVQeXVjbXVH?=
 =?gb2312?B?Slk0eUc2SGFDZDdGZTlLUStrYk1SZCs3VnpQaGxpRHBxYjRFNjVHYUljQUt3?=
 =?gb2312?B?ajh4ZnBVOTZrZU5yY1MxZUhxemVzTzRFSUdDU1NnTzdBQ2VPZ2NEbFJYaHdj?=
 =?gb2312?B?UVFpbUtlcUNPNjhQa1V5MTZZMVI4QUFVMjdHbGVsWE1ra3A1aTBlQXpKK1Ew?=
 =?gb2312?B?Z2tnSzVHbjJZVlhvOFlGc2pPbElKMzBuK1FDTEVoZkFYRTFTVks2WWQwOEVB?=
 =?gb2312?B?MDNvVFUxNlAxWVFZVGhGNWVwSmpzN2NESnRIV0xySnkrMlpNMng5dWZYZ1BC?=
 =?gb2312?B?eS9RUUZqT0dGdWFDRXdISi9Db0Z6ZzllQ1A3bUl4VUkzeUFHcjNHK2p2U3ln?=
 =?gb2312?B?cGtGdmFBUFBqQkdZSWYvRGhRVlY5aXlsR3cyVDl4TTk2Q28vQWlqRHhpS0Zn?=
 =?gb2312?B?VldFMDVhUzFQaDh6L2NSYnlZb2JZWTNqaW9Sa1I2V3VLbk1JclE2RWp3Q04z?=
 =?gb2312?B?K1duVVAxbjY4eVBkMndmRVNUdFFqSGk4Nk9kSk1XU2czRVgyRzJGUHJJT3A1?=
 =?gb2312?B?NGdhdHU2a2ZqY0RRZDJxL2dZWkRrT1lCZ0dwUDB2QkRIVGtjUnU2T3hva0xQ?=
 =?gb2312?B?VnJHdjI1RzNDeW5YZjQ3UWtaZXVOU09OOXU3c0x6R0dhRzlBVDBJb1J3RUdj?=
 =?gb2312?B?MTZ2UTlncHovV01mOXBGRE1wQ2lxakhhb3JQMVl1SDA1SWlFeGJhSFdJdUVm?=
 =?gb2312?B?M2E2VUF1SERqOGdFMDJENVdEU2czVTJRNkFGWExWSm5BblBhelFZeVArT0Z5?=
 =?gb2312?B?NmZNT2F4bUdlcU1NRDN5bTBWZG41YSs1ejcwQjNYbkRFTmdFSzlBTDN4d2VP?=
 =?gb2312?B?VXRVb1NUYSswR1orWjYyeFVESzlpMnI3Q1BFN3NZYWlrRXB2YS96MHEzQW42?=
 =?gb2312?B?NlpGYnVvdFYrcDdIN3FrZXBsdlJWd3AxRVRMZld5cEpuL3JRdzFQK3VOV2pV?=
 =?gb2312?B?YmM3UFZCQ2JiTDVRVi9QVmVTTEFZZWcyekluUVI4S0sxSnloOGk1RkNuaG8y?=
 =?gb2312?B?Vlc2RFRUOVY2KzdOTHloMjhKaUdMSXV3amczbXpWamJ0MVZPNjRzcVhUTGV1?=
 =?gb2312?B?bmw2eHpiM0xpekJUL1Z6cEE3bENXWW8wZXZkTlp4ZFoxNzBsLzRxTmhFNHQr?=
 =?gb2312?B?WXpKU2JFNk1JMytPVFovdGh4WXNSUTZ0bzgyV1hwTXBZNGlyWHB5UWozN2sr?=
 =?gb2312?B?R3g3dCtzMXoyZEdDQkVyNXV1WGtUc3BkQWFHY29TZ2lzRVkxSGU1bDlWNndm?=
 =?gb2312?B?NzdILzdFeGJtc3ZwZEc0SXRJeitWcXRuclBsditSVDhsRy9yN1hMNjRzLzZs?=
 =?gb2312?B?VlNVRFBNaXpBd3JtMHEva3JDT2FTVVNoZEZSQVB1V2FSOFVCUElzR25kRGF4?=
 =?gb2312?B?QUp0L1B5WEhGNXNwckZTR09pbEZGWEpWaVpIeG15R29ycWtXemc0QTdmTGdK?=
 =?gb2312?B?U0dDY1VhcEhsdm4wdDkwK2tybW1aS1pTVUNIa05mamtQQXFaL0N2VHF0S2Ry?=
 =?gb2312?B?MElsQkJFN2c2Z0gvYjkyeDVyY0lwMkxsTDMwZHJ6SEsxS3ZTbE5KcTlCYW92?=
 =?gb2312?B?WG41Zzc4QkV0ekRHYzhnWU1aZ3NuTnczb2xUcmRyZ1hXSGd6dkMybEhIc3dx?=
 =?gb2312?B?UEE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbc3261-ceb8-4b85-30f3-08daae77ae1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:07.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ol2G+6cT0yDbxUH0tt76DqBHc4/PbFH7mRaLzHN6lCTDLkVa1xjHnVvNQsNHkN2V31CcwMUX+hweiFH3r+JbqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

TWFrZSByZXF1ZXN0ZXIgcHJvY2VzcyBhbmQgc2VuZCBhbiBhdG9taWMgd3JpdGUgcmVxdWVzdCBv
biBSQyBzZXJ2aWNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0
c3UuY29tPg0KLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgfCAxNSAr
KysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
cS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCmluZGV4IGY2Mzc3MTIw
Nzk3MC4uNTBkNzk0OTEwYTNmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfcmVxLmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQpA
QCAtMjU4LDYgKzI1OCwxMCBAQCBzdGF0aWMgaW50IG5leHRfb3Bjb2RlX3JjKHN0cnVjdCByeGVf
cXAgKnFwLCB1MzIgb3Bjb2RlLCBpbnQgZml0cykNCiAJCWVsc2UNCiAJCQlyZXR1cm4gZml0cyA/
IElCX09QQ09ERV9SQ19TRU5EX09OTFlfV0lUSF9JTlZBTElEQVRFIDoNCiAJCQkJSUJfT1BDT0RF
X1JDX1NFTkRfRklSU1Q7DQorDQorCWNhc2UgSUJfV1JfQVRPTUlDX1dSSVRFOg0KKwkJcmV0dXJu
IElCX09QQ09ERV9SQ19BVE9NSUNfV1JJVEU7DQorDQogCWNhc2UgSUJfV1JfUkVHX01SOg0KIAlj
YXNlIElCX1dSX0xPQ0FMX0lOVjoNCiAJCXJldHVybiBvcGNvZGU7DQpAQCAtNDg2LDYgKzQ5MCwx
MSBAQCBzdGF0aWMgaW50IGZpbmlzaF9wYWNrZXQoc3RydWN0IHJ4ZV9xcCAqcXAsIHN0cnVjdCBy
eGVfYXYgKmF2LA0KIAkJfQ0KIAl9DQogDQorCWlmIChwa3QtPm1hc2sgJiBSWEVfQVRPTUlDX1dS
SVRFX01BU0spIHsNCisJCW1lbWNweShwYXlsb2FkX2FkZHIocGt0KSwgd3FlLT5kbWEuYXRvbWlj
X3dyLCBwYXlsb2FkKTsNCisJCXdxZS0+ZG1hLnJlc2lkIC09IHBheWxvYWQ7DQorCX0NCisNCiAJ
cmV0dXJuIDA7DQogfQ0KIA0KQEAgLTcwOSwxMyArNzE4LDE1IEBAIGludCByeGVfcmVxdWVzdGVy
KHZvaWQgKmFyZykNCiAJfQ0KIA0KIAltYXNrID0gcnhlX29wY29kZVtvcGNvZGVdLm1hc2s7DQot
CWlmICh1bmxpa2VseShtYXNrICYgUlhFX1JFQURfT1JfQVRPTUlDX01BU0spKSB7DQorCWlmICh1
bmxpa2VseShtYXNrICYgKFJYRV9SRUFEX09SX0FUT01JQ19NQVNLIHwNCisJCQlSWEVfQVRPTUlD
X1dSSVRFX01BU0spKSkgew0KIAkJaWYgKGNoZWNrX2luaXRfZGVwdGgocXAsIHdxZSkpDQogCQkJ
Z290byBleGl0Ow0KIAl9DQogDQogCW10dSA9IGdldF9tdHUocXApOw0KLQlwYXlsb2FkID0gKG1h
c2sgJiBSWEVfV1JJVEVfT1JfU0VORF9NQVNLKSA/IHdxZS0+ZG1hLnJlc2lkIDogMDsNCisJcGF5
bG9hZCA9IChtYXNrICYgKFJYRV9XUklURV9PUl9TRU5EX01BU0sgfCBSWEVfQVRPTUlDX1dSSVRF
X01BU0spKSA/DQorCQkJd3FlLT5kbWEucmVzaWQgOiAwOw0KIAlpZiAocGF5bG9hZCA+IG10dSkg
ew0KIAkJaWYgKHFwX3R5cGUocXApID09IElCX1FQVF9VRCkgew0KIAkJCS8qIEMxMC05My4xLjE6
IElmIHRoZSB0b3RhbCBzdW0gb2YgYWxsIHRoZSBidWZmZXIgbGVuZ3RocyBzcGVjaWZpZWQgZm9y
IGENCi0tIA0KMi4zNC4xDQo=
