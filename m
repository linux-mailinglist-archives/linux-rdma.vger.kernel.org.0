Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397E4562B43
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiGAGKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Jul 2022 02:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiGAGKb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Jul 2022 02:10:31 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA61A83D
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656655828; x=1688191828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a0k25UCVG/3LCE5UMaU+GGyZmhy5TKmEHdzJxta0PPQ=;
  b=seohw2z64wPQXcH0kG/8xa1616op0WeRqwP3mbjg/eNf+ro9iBK0lXTE
   5D2cM/n1Y2l4xSZzSg1GMIs5edehlZmcR96dZFzxeg+/inW4URSPzg9nM
   Ifif6x4bFBgkaU/7B1wrrFlNnOR0MREeSwaqvNjroTDo4aOuYvsAFLW5v
   TUUncDWDvoSdf94hs+bGuN7n2z9J8yAeNaATxy8hYDdXBpxMuI3oBkIab
   KJUqeaqHpq/Y+sUsYLGlVpzqYpXUjPhlB3V0Xr/rinwDG+otfMBGTGcfc
   bKsMhj5wSFfNzNDOpfcSleehSt6LIXJh4rxjZjYWKfQoxUFq7AmXuAjLH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="59519665"
X-IronPort-AV: E=Sophos;i="5.92,236,1650898800"; 
   d="scan'208";a="59519665"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 15:10:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/xwnuEN1V9UsgYVHoncEag10Jeyksqw+YLUwhq7TpNnh2CKhVYK1WwIrr/Bq6QWBw2y/DKEnlIZVS9onbYDGV7S17cqBAKXSY8czilhvxS6ripezeQVOQAqfwqeltkURM6YxXCPQn92V9rnWrs3EMA3kOZ+HxRbVlj3b4WQoOSrTkCVkvOWea73EeP70mH2UlDMxzsTsbLrgB1HMyZgOAXSl7ySHQpo0uIG2xOI87rFN/ZTuRBP/3O/+ndmJdB35EHhdVGiJ+Ns6zK7vw5dIcblG0lyrwMlBYnfkMxaDhQJoDlNBN8xpgNorLruJ69w0JBruqqpKD7Y5W4SQ1/shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0k25UCVG/3LCE5UMaU+GGyZmhy5TKmEHdzJxta0PPQ=;
 b=LNfxbklhNSyVdiKcUci+bsuJMdmGScbdG+qfjqbHTaxiDvSv+qfokJDtCsr8Ushf88PCg1BdBDK0U3U1Zxwf08P+IGp0ID0t7NS0nkqiSc7lGmRHNj5KOM4qsyjhYGxYI7/v/043D0QFTZX6Eha7ni48E7H/TNvYQUyX3WLypZVi4/eKn2tO2+YS4W7ljimedDGdHkHEhwsmqPQ2HL9JYqJDfLbhwff3853hzf02zZItAdSy/8cd4F93NvYDPnbALt1+lK9yIdIniYDHa3Pex4AKPtPQPZkfhyU4i89zn1rrMN4Vvw+J9Ox6rgbQmFYkLejNNHl4F5Jc2F+R86Q0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0k25UCVG/3LCE5UMaU+GGyZmhy5TKmEHdzJxta0PPQ=;
 b=UG/ZeSBw8Yg7qbFwR9NXlI28svPvkZP9TTuSEa1F/uTFLEyVsvr3U0VtepqKYpM7uACgtJWnTiQIfQx8iwLGPFFBJG+6Ce1QZMgL4Jx2aJdophJBZbEUt921AHE4komZMTN3jOklm6H4QQle60a/q7a6A3TQ3lH1GYBx3CQ8Gg8=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB6626.jpnprd01.prod.outlook.com (2603:1096:604:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 06:10:21 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 06:10:21 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH v4 1/3] RDMA/rxe: Update wqe_index for each wqe error
 completion
Thread-Topic: [PATCH v4 1/3] RDMA/rxe: Update wqe_index for each wqe error
 completion
Thread-Index: AQHYjRE+Jg119Y7SOk2VHq5PYaeVgQ==
Date:   Fri, 1 Jul 2022 06:10:21 +0000
Message-ID: <20220701061731.1582399-2-lizhijian@fujitsu.com>
References: <20220701061731.1582399-1-lizhijian@fujitsu.com>
In-Reply-To: <20220701061731.1582399-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 245f05e1-3b29-4170-fe07-08da5b286117
x-ms-traffictypediagnostic: OS3PR01MB6626:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cg9GyNyWBvK4QyjGB1e9e1YPp6DeliIHklW0lzTkd31Ru3OTtyHDTrZ5Q1nROHX8AzwAzgWs02X3HBKdWnj+RBF0tuxQMOAbC8+7gIoqF2WU2FgqZDIJXGLRtMbusIq+nmBNH64KzIaWdWMpjih/KomJ3zIgXmCCKz5x0xDE9A46Hls1YTibiHSoR+iiYmvLIuRghacjPQcc42lbG/4aGcvIfhdB4u8eG/5ETkTEpCrslt1OiMAatnM+KxKsKFlEF5huIk/OqPc1JoJaj7HBl0eqcN/6eKafCf1sNuSuuDByZPJi7WfPnc/MzhLPtd54yLyHEL701zg/wphRNFTEIew0fwXBJ2wSyUlCvxgFYHnC/oKJBtaPj+yP7gYO2Uh0iPT0DnamdU0CqN5LoRH4lrPcnYNwzWUgra7WVnfCnRNjwDwobGRRx49Q3TTYjfVOblRlRCpfopsJx7bOFbYX+MlBPx2qtbG7Vy+x29BAuPQhSzMGHN4xLu8r4+YUWRDxjduo/HSMF8f93DYqlxY3H3W3xzeejteJCWathV0ufmpBHHgnTDXozAfFhfZ6K0TDn7/+PwjxeCViZxzue9WBtf2S+UHPJV2GVqHcQxA+QmC1tLluTd2CRHGcSYZRvAakckOS6W2yKuolJpgVCqrfZGQRP0DHAWM5NYRuWmL5Hx3Rj8AlDFI+ec3C/9egkC2h5LmNaBo1ugS52RHet7AqFfGSeE6zRdFH2nYdfnyboGGiRXAV92WKI4h3KWiKKguJtIjiVANRYGYtACIYrsh+EhMMgdt5gOJqqVQZrcMU+8yFeq+D72hp/rx8EvPDHnP/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(5660300002)(36756003)(4326008)(64756008)(110136005)(8676002)(122000001)(8936002)(2906002)(38070700005)(66446008)(91956017)(186003)(41300700001)(83380400001)(85182001)(66476007)(316002)(76116006)(66946007)(6486002)(71200400001)(66556008)(82960400001)(38100700002)(478600001)(107886003)(86362001)(4744005)(1076003)(6512007)(15650500001)(26005)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?emt4dkV6anJJMVZ5REUxc3A2M3NhaG5ZWUZ1V1ptVnA1dWNrYURjN1lVMEtl?=
 =?gb2312?B?QnhvaFRYM21iRERocGxidE01NDJOMUNNR3A0amFjSElVR1NhM2N0UXN1b09m?=
 =?gb2312?B?VFQ1ZmxTSzlYSEFVeGZYVHhDYkx3UHBqMCtJNFhOdTFuNnhZR1Y3Q2E1d29O?=
 =?gb2312?B?NTJyM0tEYUlQb1J2dC9TMEphdTEzM05OMEZ0U0dxUTQwZHNJRDFmcmNSOGM2?=
 =?gb2312?B?UWhhZjA2YkdiOElCT1djQ2ROek5qZHRtUERETUtSWDdMVU15dFZ3RUhNbWF6?=
 =?gb2312?B?NTBUZDFHdnNTUGhib29UdExidnpHZXpQcDlheXZLaDc5N0FreE1XYm9iSWli?=
 =?gb2312?B?OGhNczRMK0dSSVRCV3p0RkRRdm16WWlWTlpod2piSXloYndFdmVmZ2FYYU10?=
 =?gb2312?B?b1pvWmlkaDREcHRtR0x4dTdock1ySU1xdkxQSnZTNHNsMEhFcjR5c0ttbmhC?=
 =?gb2312?B?MVVHK1FPSEZZcnExK21wcU90cllHaTJVL0wrMVNjdXdIWGRIUjdkTjRpd1Vy?=
 =?gb2312?B?aHkzZ2M2cnhzaUVDd0xldDQ0SDNzV1FyUFN5SEtZdUEvVnpmM1RZcFE3OTV5?=
 =?gb2312?B?MXRuc1lxV2NJOTlZRGpJMEI1blA5ZXNEZE9yMEo3Wkc0K3NwY00zUXhkM0t4?=
 =?gb2312?B?OG1vL2o4ZmR1NTk2ZEdXMnRyRjFQb0FWM3hsbHY4RmQvY2ZxYzlySmVRY0h3?=
 =?gb2312?B?cTBhZ3dqbzF1QTQzbW9iN01MS2hsMlR1bStvbVlQVUgzSFdRNWU0b1owN3lj?=
 =?gb2312?B?MUlKTXhwTm9xSmlZYkptQ2JjTTFBUWFpdmZhNHdhYUdGMnlZOGRVb0NrSzkv?=
 =?gb2312?B?Uy9OTHA3cmw2b3RHdytZbHNkVmZtSmk1QkdhNTVCNXJmRzVObkRhbDB6NFBz?=
 =?gb2312?B?WmxEbDdlTGdoMjcva0F1ZE5XV250UVFnUGdLT3JKdndsbFBCbHBUQUZPTVk3?=
 =?gb2312?B?ckdzOTVhRG9jVlV6b3ZUeE5meWtpc2JsRnY3L3UwQkVXbXd2TGdHd1dnK05J?=
 =?gb2312?B?WFdKYS96M3FHc0N0a0J6aFBkdCtRakdYWFlCeFFhWEV4dDVwVzdPdUxnRDAr?=
 =?gb2312?B?b1pWVzBsaXlvTkVpOVZtNEtqZkFrY0h5Q0Voa3k1MWtXN3h6bDh0YWVzTWlW?=
 =?gb2312?B?ZmRqTG1XMXYwZWNZRnNURFpVMm9WYmVwWmVONnlMWVdUY1ZRWFh4cjYyM1E3?=
 =?gb2312?B?Szk3Y0ducE1oVVExcm5PS1NjeWlHNXIrWmd2OUxoTU15Wjl0TlJNY0RNd0JF?=
 =?gb2312?B?Rk1hS3pVVnFjb1k5bTJ5RTF0N2poMXNzaFdhczVRMkUvWU9neDVsNk44VUtZ?=
 =?gb2312?B?dGVNMzRMSmk2bDkxdWJHOFlEVFF2bmJDSzlHRG0vaXZnaWRxaHR3eW9WdkJY?=
 =?gb2312?B?YldQTEtEVXVDZ1pnWjJUVUVWNFNMOENJenc4eXdmYlBZdHpXZnBLbUtBNHFa?=
 =?gb2312?B?QVo4eGpRY3ljS3JCQ2dnWFZVOHQ3N2VrcERIM0NvU1l2WFduSC9pa1JDWjc0?=
 =?gb2312?B?cStUV1VtNWh2cm9ORU9qdmhPY2VOVVhjOXRUL3ljRk12YkV0eUxoWWxYK2hU?=
 =?gb2312?B?YnBxS1JVTWdTUFJ0ZUdVWjlFay9VeTgwWHNqMXliMjZleTFUQU5OU0ZnM3Zq?=
 =?gb2312?B?aDZOQ0lPMkxad2JjbHIyRDBZNExGZjhvTWpCeUJ5MW1RNzBqUXJFWGFWS09Z?=
 =?gb2312?B?VCtVNHRSRTMzMWtscjl0OG1RU3lLY09IR3lhZGtzV0dGcXlVSUd2aGhxMEZ5?=
 =?gb2312?B?NlZYanZNZWNlcHRpcXZYZFlJZTFLV0JWM1grNUxBcVFydlZ6WDVCd01kem41?=
 =?gb2312?B?RjBwS0QrNFIvaDFJQ2FXTnpuS0dRZkU0ZW5IYUxrQjZqalcxOTRJQVVvU2Qz?=
 =?gb2312?B?aVJ0Y0xheUpZdWYyR3FkMmZpVjA2ZzViL1pRaEdNdTlxZTQ3WU9telJXbW9F?=
 =?gb2312?B?bC9yaGU0azJ0VDhRUzVEUkVxSFJaYWtQMUtpaDc1YkwvUnVVV3Q3eFVsZzFo?=
 =?gb2312?B?Y1BaOGdPaU83Qytyai9qYmhmb2V2WUhZbVVaZ2lhN3BkeGVhcm9rN0JUZEpG?=
 =?gb2312?B?VksvTS9TMENaOE0rYVhDNEJXcFdScklLTFNtWXVEcTRwMURST0ZCaXNhT0Ft?=
 =?gb2312?B?cTFnMm5tS3FMb1YvdGNaMG1uakxsWmw5WGJxdjVKdlg3RkFZYVA2M3Yvamhy?=
 =?gb2312?B?WGc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245f05e1-3b29-4170-fe07-08da5b286117
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 06:10:21.1972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdNxIZoOYduGw1owAEEtxlr3zK5xycOeNAvnWzzAgAU0O58F3Bb8a32Hvv9838tRpacvRz3s21eJX6TNApM+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6626
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

UHJldmlvdXNseSwgaWYgdXNlciBzcGFjZSBrZWVwcyBzZW5kaW5nIGFibm9ybWFsIHdxZSwgcXVl
dWUucHJvZCB3aWxsDQprZWVwIGluY3JlYXNpbmcgd2hpbGUgcXVldWUuaW5kZXggZG9lc24ndC4g
T25jZQ0KcXVldWUuaW5kZXg9PXF1ZXVlLnByb2QgaW4gbmV4dCByb3VuZCwgcmVxX25leHRfd3Fl
KCkgd2lsbCB0cmVhdCBxdWV1ZQ0KYXMgZW1wdHkuIEluIHN1Y2ggY2FzZSwgbm8gbmV3IGNvbXBs
ZXRpb24gd291bGQgYmUgZ2VuZXJhdGVkLg0KDQpVcGRhdGUgd3FlX2luZGV4IGZvciBlYWNoIHdx
ZSBjb21wbGV0aW9uIHNvIHRoYXQgcmVxX25leHRfd3FlKCkgY2FuIGdldA0KbmV4dCB3cWUgcHJv
cGVybHkuDQoNClNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCi0tLQ0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwgMiArKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
cmVxLmMNCmluZGV4IDlkOTgyMzczODljZi4uNGZmYzRlYmQ2ZTI4IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3JlcS5jDQpAQCAtNzU5LDYgKzc1OSw4IEBAIGludCByeGVfcmVxdWVzdGVy
KHZvaWQgKmFyZykNCiAJaWYgKGFoKQ0KIAkJcnhlX3B1dChhaCk7DQogZXJyOg0KKwkvKiB1cGRh
dGUgd3FlX2luZGV4IGZvciBlYWNoIHdxZSBjb21wbGV0aW9uICovDQorCXFwLT5yZXEud3FlX2lu
ZGV4ID0gcXVldWVfbmV4dF9pbmRleChxcC0+c3EucXVldWUsIHFwLT5yZXEud3FlX2luZGV4KTsN
CiAJd3FlLT5zdGF0ZSA9IHdxZV9zdGF0ZV9lcnJvcjsNCiAJX19yeGVfZG9fdGFzaygmcXAtPmNv
bXAudGFzayk7DQogDQotLSANCjIuMzEuMQ0K
