Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98ED56B234
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 07:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiGHFXN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 01:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiGHFXM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 01:23:12 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE39B796AC
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 22:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657257791; x=1688793791;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dgY8TvELyF+9y9PHvU5LQ5G5XEqXf2+7/GsRL3kGjME=;
  b=PxsR7Hs0moLBZqJW71ZJVwKS/EcDbmKJKl82cwSnryeeArawoJW4c2Zw
   a/Ryg95+MbOu93JUCg+mDFZPdvOSjoX6ujXuDyUNuwxwgMhV+AAJQPFiU
   j4JNa4WK25NWkNm2+Lp18w0dPzOHV/e3hrMbrFk3taJunEugWNwXYjrpU
   GRNDFDa8XN8MjBkcCVOwnXYyfXX/h3o9zrHWMb/HX6H8yUC6n2jfn0w9k
   rTh1WJ7hmS0JInfW4paSSyz3zoj6BcbTp/KRNNXWCU0FeHgf1QXlOTlrJ
   R9ufQKyw/qTt/teZCU+W2IuhAXz0mTGDiq2L3e9rrPqGzKKkh70QKvL2V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="60073150"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="60073150"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:23:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOnR0XqnToSmrslxIJW0u+XrA1ItRMPmVO7uHpCILj9+ARhLJzp1glfrMbX5c69xnYIfd/L6sZofGi5Pvef8TWii95qPuKRpXlo1VZ2+jQsNuW8OmPRYJd8gbJsBd/NQ7a9eEy59QSO1RXIqTQrkXOwBzvEUYbTFUSvppdv9SsX0S2FrZ09ADSKtH914TBYMwFTmTYk8DAcD44I1DdpGEnVQvhvEQ7PIcoZHmXIG+CEKZY8DGxqIoz6K0KlujpK0h6OK6/Fmqg44ZmSXui3OU3v16/KXMeMzOnk2laqhYVtWIaOUfp33BK+J8dvTAHjBCLVr5D9jPeTbk1BiOUFiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgY8TvELyF+9y9PHvU5LQ5G5XEqXf2+7/GsRL3kGjME=;
 b=ApLgGNs5LpLo9wNMKdCV/jlEFy/4FsOO1ZlOlS84h3AyYT6XUYSBsH6amgufiHvAZQm5ij4Zpmfjw7jWCDUpaQcsTGPv3j7BIoqGTPsU2PQTo6C2xL56+Y5m8p9OsA6/ylogRFb8ZvFUVLfnp9uHfRv6cO7zksFzfqHwBcn8FtyP8E8jdcWu7rUSCGcRZ1wM7C5othKETFdj27Fs74/+tqHv2JNBduZ/pCAffZa5l7FD3oNsJNGIDLNRvktNNAaTJkP5wkSJm0hnSZtvHPjxTfUdixktOlebB6/eI1aJfwIXlPY3TvrEKH9s1idI80yV4reK1BK2PvFMsqAMdGMkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgY8TvELyF+9y9PHvU5LQ5G5XEqXf2+7/GsRL3kGjME=;
 b=JZO16B1VBT092v9ujqVVeRjqaen4F01bHNqT9s0krZCWwKYKTwOgsLCU2QzQTRzcAYNkRMwPNta/BHgpcR4j6WzpbFM7AwZoyGSktikNncEkD3A38A8P7DGOfbqXiyMM3SEJor4Z6SO5gs9+XbKhQxPFH6+FnLk3+k13iSWfBq8=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB8476.jpnprd01.prod.outlook.com (2603:1096:604:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 05:23:05 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.021; Fri, 8 Jul 2022
 05:23:05 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove unused mask parameter
Thread-Topic: [PATCH] RDMA/rxe: Remove unused mask parameter
Thread-Index: AQHYkorNlaIujxrCr0+zt2skLeAZmA==
Date:   Fri, 8 Jul 2022 05:23:05 +0000
Message-ID: <20220708053014.1823332-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2aa1493-902b-40c5-219f-08da60a1efc4
x-ms-traffictypediagnostic: OS3PR01MB8476:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWukW0VFS4GYYXBeVeLo/HQhYLkEiKI+Z3ENHsnCIbqZt24In0BJHjZJok8GzNkO9gqBlkbP+7CCZ+ebsAxX/XU69yhOi0o6/AdIjUd57JzmQ7BRbbpDPQnjXZp0R+wCNGrS1jQKZeQRBDY8WLkIAI8ipvFih87hcsETpKRzclR4ptXGsQrtqq5liHpBfn92quPQnF3EVA6wWUAkcVJeVUnn/OmIA7OLsBjkY12zeEXYXB8fQInK3ojSWNaDAxcBczp2UlaEVwCbre8LwHayT0ZyqSyU8QzJ9svn7mvAvw+HgAeAbPYNL6fRxSNtLuAR8d3vu8Yk7k+jC2v2Zw78t/diq0XLihzK9167p6ot0VvZFUu4OZSwHOkaUBcezVxCDuIQttNQiDAKXd3rkJhPh8AvKiwgenZTD0ovfLzM218OMmiC9Q3mgmHJ5P0FSVNKd6G3q/BV4EcB3Tr96tje8XF6O4OIibaLTP7zJPsQvjDnTyj+B1Hj4EQRScgQJ2n8NR7RHFa+mYMHY4Ssia22ETsRG/Ygen4hngEf8zLHBXokeUq4niNT/jgfpewi/t5iRY+KoxmTW1TYjz9iyKXLV0gyRdjfsuXf98gwGAMXlfZ5u8VHOA1cvpYMfTh3OIKbbx0SZJAC5+LnBMnDkySlxeFgfy2YmM63AMwVJeNRnD1ZJPcT/NDdGqxXg+MAqzAjKJd5eBURAMWyHC888hwJSZTiesVuenOW3uz8vh6OZZ5eFkhiOD1X2TGxpn/eSO3GGjKhkcJ/KBeCRQvBiv+dn5vqNZDzQLVpt5eM0+2h76/hoxhj0IUoFIwVpGmzf47X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(4744005)(110136005)(2906002)(1076003)(83380400001)(107886003)(6486002)(82960400001)(186003)(38100700002)(5660300002)(66556008)(86362001)(85182001)(71200400001)(316002)(36756003)(66476007)(64756008)(26005)(66446008)(66946007)(4326008)(478600001)(8676002)(41300700001)(6512007)(38070700005)(8936002)(76116006)(6506007)(2616005)(122000001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MGFGV0NKVEdETldGNDhDNDZIdjI3NWdIYjJjY3ZMbHh4Q0ZTWjlKWHZxQ3Vn?=
 =?gb2312?B?WnlPNGZSTExvaGV3aE90ajdGY2FIM0hYdEZMTy83QlI4S296VzdrdEh5UjFF?=
 =?gb2312?B?KzlBV2I0YUhuZXVvbnZTZkxsTVFZdVlrK3NLTHZldXpIV1psb1ZlcG0yc1Q3?=
 =?gb2312?B?MEt4NGhZMCtDTlhscVlhaWxrb3VFMzg2d3pnbkd6akNFNCt0ZTV2SnVubG1h?=
 =?gb2312?B?N0lTeXNQTHNFTnRzTnc5cXlCNjlSQkE1SGwydms5Qm8vcDA3NEhwUG00dG1O?=
 =?gb2312?B?cGdLamU5dHIzNVRPN21rdjVrQ0gwOGVIeUpySG01cko2RGFPR0pRbmVBZU80?=
 =?gb2312?B?VWRSRytqeE1GaGl6b3Q5aCticnlla1M5cUNjb0ZWM05ZVzNBQ0RhQ2dvUzhi?=
 =?gb2312?B?WEJmYm5LUXVJekppeDl6K0VvcFZSZEQvdDdpR1FoTkdTR2QwNzNnb1lCUVZM?=
 =?gb2312?B?MUlYTWpnc1ZaYzEzdEpHVHkyM29HMUh3RWswQ2pnc3JHbVRMOVVLUTNoTi9H?=
 =?gb2312?B?NUFTZVA0ZS9TTnVZdjVrT3RhZ0hMWVpkNWVYSFdWemtBVWhoTjh1bGF3RU5L?=
 =?gb2312?B?Qks0VkxhT0dLdEtoM0N1b0ROTW5XQXAyUFZHUUh5L29IbE9xSHlVVnFDelJS?=
 =?gb2312?B?UjFqcWZ5SDlodVpXcHAwdjdVUDhRMmJsS2lDY0J0M1RQU3hDTjA5L0VJQnpj?=
 =?gb2312?B?bTV2bWRNVEEyK25nWE9laWY3OXIwREF0Q09Bemp3R013UDl6QnVFUmd5c3FF?=
 =?gb2312?B?aGEvdTBVZzl6UlQrWkNURjRuSDUwTGNERE40MEJTLzI0NGYzSm9QckRJYTN2?=
 =?gb2312?B?YlJtUTFPZnFHZm1tN0EvRVROaEhkTzFSWjdUQVB2R3RBQitWTEVCRUcxNVgr?=
 =?gb2312?B?ZVlCcWM4S2ZoZ2NoWmVzNXQ0bTVuQ09EY0xzY3R2TnN3UEJ5NG9pZ0N6V3Zi?=
 =?gb2312?B?SGtxQ3UzQkJkemFxSzUxSlhIeW1vNnpHa3VtYks5RWRvZTg3enZtVjlPcTVq?=
 =?gb2312?B?NmJMUmNXU2R0NkVZM0pxNE02ZjliRTZ5L0pNSnMzQWp1cHpmRlFWTWhLMnUx?=
 =?gb2312?B?aUxjMXJsaFg4Vk00MzRCRi9lUXlHRkhSNVRYbE84bUVQR3VRRUwwWXJrLzhH?=
 =?gb2312?B?Y0NSb1ZxaGZkSGl2NGJhVGV2U1RJZ0NSaStEM3k0L1ArZmxzL09yT1kreDgz?=
 =?gb2312?B?LzZIcDRIK0J6S05VZko5RHg5S29rTVZPejFLSHhNalBCcnpEZWZuTmtucjNB?=
 =?gb2312?B?cWFkRUNnM2RQcVg4ZzE3aDFuYnpBZVJkQlZtYVRjQVZEOVdEd0xDVm15MzZo?=
 =?gb2312?B?bWpQTml0NWV4Z0ZJb29GTWdwOHVXWGZVNU83WHdtYWV6VEo1YjRkTEtPOVQ5?=
 =?gb2312?B?YkFXd283QlA0OXNRbS83VzIza25jdzIreUhheWVHc1RRTDBsc2hPWmtjZG0y?=
 =?gb2312?B?aFNiTE9LcGpJZHgrZ3NFMXQvblpFTlI3eGVUMWlGekk5K2xkTDdsdS94dHNk?=
 =?gb2312?B?QWd0V0s4MmlpVGYwY1FwN2JXVGcvVlArbWNZenprU09Lc1pZdUZ4c2FGWGs0?=
 =?gb2312?B?THl2VjFDNGxnOFZHcjhaZkoxOTZMRXM2SU1GN2dLQ2VTb1RuUi94eFJ6TDN6?=
 =?gb2312?B?ektvNzdJRm9qa0NWc1V4cTVJbDN1WVF5L3lyQmZ3dG1jRGVuYVJVUy94RS82?=
 =?gb2312?B?aGRyd0RobWxMUGZKY3dMZEFsL3F2WUZ4N0FMQjhMK3VrUnRoTXJMNXVMMU90?=
 =?gb2312?B?SE92ZVV3OTZzRDM3bXRvdlF2V2FnU1FGb1lJTDc5Q3hFUmptdHVNYnNXYldn?=
 =?gb2312?B?bENVQkc0TnpTTXdkL0wxaFJpcFdPeFZDci9qL3JuZFFNNjBJY3NwbEUwV21R?=
 =?gb2312?B?UUsyN3c1akx6UWMrQTYyaXdsTGxwMVNNb3ZZWE02UUxaOGlsMHQvdUp0MXRU?=
 =?gb2312?B?Y0JaNm93UDFtalhlVWxQZzZKWEREYmxzSnMwQ01zT0E3azZhVHBSVHpjS2Nw?=
 =?gb2312?B?cnFUd2txdFhiZGlhZ3NlL2gwM2pReE5BNkNtOTF5ZDBUL0tjQlBteGJLRkdM?=
 =?gb2312?B?TVJnbTAvZjY5NmRjb3ViL2Iza3JyUTlNUU5RamdWZGMybThOb1RKcUlxL0xr?=
 =?gb2312?B?NGdLMkZuQzVaazlQUUVWdFJHWGcya1JrRWhWV3dPNWszL0M0alIxVVJjZUFV?=
 =?gb2312?B?a0E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aa1493-902b-40c5-219f-08da60a1efc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 05:23:05.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pri/2Vf5Fk0kAW3knXAB1DlAWFr7uTrkNbYr2CkUg090wTUZQrf9VQZFGItjTcxRYOg827IAUjj52fUnE9i2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8476
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KLS0tDQog
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgfCA1ICsrLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfcmVxLmMNCmluZGV4IDY5ZmMzNTQ4NWU2MC4uMzVhMjQ5NzI3NDM1IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCisrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQpAQCAtMTUsOCArMTUsNyBAQCBzdGF0aWMgaW50
IG5leHRfb3Bjb2RlKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3NlbmRfd3FlICp3cWUs
DQogCQkgICAgICAgdTMyIG9wY29kZSk7DQogDQogc3RhdGljIGlubGluZSB2b2lkIHJldHJ5X2Zp
cnN0X3dyaXRlX3NlbmQoc3RydWN0IHJ4ZV9xcCAqcXAsDQotCQkJCQkgIHN0cnVjdCByeGVfc2Vu
ZF93cWUgKndxZSwNCi0JCQkJCSAgdW5zaWduZWQgaW50IG1hc2ssIGludCBucHNuKQ0KKwkJCQkJ
ICBzdHJ1Y3QgcnhlX3NlbmRfd3FlICp3cWUsIGludCBucHNuKQ0KIHsNCiAJaW50IGk7DQogDQpA
QCAtODMsNyArODIsNyBAQCBzdGF0aWMgdm9pZCByZXFfcmV0cnkoc3RydWN0IHJ4ZV9xcCAqcXAp
DQogCQkJaWYgKG1hc2sgJiBXUl9XUklURV9PUl9TRU5EX01BU0spIHsNCiAJCQkJbnBzbiA9IChx
cC0+Y29tcC5wc24gLSB3cWUtPmZpcnN0X3BzbikgJg0KIAkJCQkJQlRIX1BTTl9NQVNLOw0KLQkJ
CQlyZXRyeV9maXJzdF93cml0ZV9zZW5kKHFwLCB3cWUsIG1hc2ssIG5wc24pOw0KKwkJCQlyZXRy
eV9maXJzdF93cml0ZV9zZW5kKHFwLCB3cWUsIG5wc24pOw0KIAkJCX0NCiANCiAJCQlpZiAobWFz
ayAmIFdSX1JFQURfTUFTSykgew0KLS0gDQoyLjMxLjENCg==
