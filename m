Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845D9562B44
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiGAGKi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Jul 2022 02:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiGAGKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Jul 2022 02:10:34 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E2113DED
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 23:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656655832; x=1688191832;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QvdLTCjo5zlbS2jZ7uRlObpl8qbBKPB+I5xiTw592tw=;
  b=yZthBsqiF+cgP+uuJCCi2S+JUuHQmer7YARjNiv/QxfgeSNys0CwZdMo
   M3z+PWtT+FI86otpznlhVo18dFTyK1/Br/crIq4LRiKa7icDkvuesxeZ2
   VmWyOrByWPbVCELrFIpmd7CXhuqm7jq71VSE/CcOum9ntW81XLZjXEcIg
   zxdRa4WGKYPjOhw7hY3iXAqYsWKvMlec4WS1xe9ktdgxHVlYkXaNtszho
   m9wfO6h4fKvXvDh66gIKkT5tNNxvKvj/dDvUlVIj7SEDtpW/glAphnnNw
   Dqn3oHVGHJF3Z2e+mibM1rEv03tCyNf7A3xZIEPNBs4xhGI1DBCbkuKp5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="59519676"
X-IronPort-AV: E=Sophos;i="5.92,236,1650898800"; 
   d="scan'208";a="59519676"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 15:10:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHRcNd1YOwJNBC0a3c+FdRftFivwdYOlRkA99fajCp2pLLfbktX0j7lLEd5gxXxgHRq1l2sdlT6e9hkZobAiIIIqF/ivLMAjwe2kEK/OTIo1jYDbc36ye1dW+FCPTLlR2VXxXfyiOYamzPGoSXo4GXTXnbwESY66PseEjYv2c2KxbAZeTCtzigOOlmeJFBE9Oum0Ndpg8j87P7HbFKmJknDETr9wxgDCai7U8f4Z/CZVn9QZP/IoDzMbcAJni8FbAJ3RsrC6igxcPRj7JF8kpeZ8KZf49mO+bYH2au/XBlBVvxIygwtAyA+/oVuhBGl91x7sPiUzrUYXppaJXknlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvdLTCjo5zlbS2jZ7uRlObpl8qbBKPB+I5xiTw592tw=;
 b=mIpn3dZrFpysoLiTf12w0fTXRPfsectEDUqS4M23We/4REJWoRO5mOUDylQ5HFrNz/zXcYi1beQkBqVIPLt0G07t9o5oEcq4wUBfBfuelwFxOoGNyVymtvpv9Yql7E9vxU1iGD1ZMwmwHsoVb0XfkKx7qknRx5YtAH5hDwqR4F4ZdupWVS12UVq7thP3jhVs3fLf88YGnjpuFVGywzSNHRIWnP6ycy68nxfbE/Hou1jAs5VIux6L6Jvk3bLn2YKsRrOk7VScsSZIknIFkVOsVkyI+KoXsHLFy/68g1sKjTj93lSyAFHVmX1aIU2kzCY27L4fgzxHexX2RZQqAq1vNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvdLTCjo5zlbS2jZ7uRlObpl8qbBKPB+I5xiTw592tw=;
 b=eDmUflcKXTMUv64v9WHliZbUVY5J0/aRQz1s9g+32gWGcWX2uH0Qbe3zJzdSaqtGZ07AI7mpyyqCo2LtJE2nBRAGWaPBgJiEAXacwxv7VPOBLQIhZPOsJxX9N0DfgIdgZToErf8g7m+cSgal7N1t6oDprKCPQabZT+fd8/42oTA=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB6626.jpnprd01.prod.outlook.com (2603:1096:604:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 06:10:22 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 06:10:22 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v4 3/3] RDMA/rxe: Split qp state for requester and completer
Thread-Topic: [PATCH v4 3/3] RDMA/rxe: Split qp state for requester and
 completer
Thread-Index: AQHYjRE/TP5Oo7sEp0ak3lQusoVWIA==
Date:   Fri, 1 Jul 2022 06:10:22 +0000
Message-ID: <20220701061731.1582399-4-lizhijian@fujitsu.com>
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
x-ms-office365-filtering-correlation-id: f3628d7f-6831-41ff-23c2-08da5b2861b3
x-ms-traffictypediagnostic: OS3PR01MB6626:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EW8wvLW+2U2CCVKAeJ2nKGKvUnbK39zWKcOxYGRaVuQzkntCO/+cPNvXTEaNwvpnlwaYpsuAylHKBAZvS+HAx6Ootx1ztj8IpWWiosTxrEyj26ebHgPhnRKlBQB+xeNS9REB6SIq3omsR5tcCcNHSwwoJwpF+pIWwvPjlcEqzTDDYbsDw9+km/bRcMRXlRHWbyWngn8KKg+afpSFWnQaUVwxG5hmKk5a7WkitaGURw8lHaPPjkHKfrFg6rzDsmvdOX5Ge1rscN4zHYE/Wgj3xwmQQY8Ni0Hx0RtFPOOBUMn2E2vvXiG3nD8zfLdx2oujNvtJj5+wjFvRtlxFA0O9GpfUHDd9itYxPxxNuF0/s4v49vPs8InuplOvDWNS3ODuRezXx3oxlkWi1tiZIx93bgfgxEm90e14uVVCDpMIbd+dMUkfrkxT/FVmWQE3qLijcxQIKpcGyb5KUUoMKnZl/6Tl0pAoKc6XX8v8XeGVD0pQ1fpOJN5AmiEag7LE8F3ph7fvFHGk+GOofaGb7GpZ6b9KKN6JOCyYrs0Cmu8XsqOrRBQGX3fH+HIskMZqgHc8Kywk+cVrZMHHDmM7BGIAgpREo7sYJGqP+EJZ9O/voX8d2YwnKs5SCF3SeJKfymHVQRPb4stS9ykg6/FKR+4zBf39q2+ZzdbpWPAgJr0SYG+2oBREJ8rvaXsTenWh5IK5WeC8FkRPT5muEAyiQ3oYctfRoyEAKGLPVNj80S3FZ0WGjEBkI80U5FO96FS+K1TCUqofr0/D4Eec96Y7a1ObW+OokTLYPrpQVxlUhPTVylG+2RBfOIuv9CfrtEIxOfD0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(5660300002)(36756003)(64756008)(110136005)(8676002)(122000001)(8936002)(2906002)(38070700005)(66446008)(91956017)(186003)(41300700001)(83380400001)(85182001)(66476007)(316002)(76116006)(66946007)(6486002)(71200400001)(66556008)(82960400001)(38100700002)(478600001)(86362001)(1076003)(6512007)(26005)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M0pBNTkzL0RJNU1CMHlXTlovVFZ0WlhKYkRBd2UyN0E3RU5tS0FzVWNsVHFI?=
 =?gb2312?B?WC9GQU1MaTlVWUh0bFMyS2ZKMVVzRmQwSUJOLzBXY2NkZUUvMUVBY2JCdDFt?=
 =?gb2312?B?RHFVQkkvT3dQbXdpUXdpbDRmNmtCbjlXckJvTHJsc2NHR0lyWG90TFhkRHpN?=
 =?gb2312?B?TWFnUm5DcGtqMFlTOWRrcllCZGE4MlhTWHRzUml5a2dFNXpkc3VMNjVYbUQr?=
 =?gb2312?B?MmxMNFAxd0Zyb2pJTDVrb3hZQ0xJOGVlRzFFdkZRRHdkUVBWQlZiOUlKQ2Z0?=
 =?gb2312?B?MUJoeUMvSlp2YXpDcXBkNHFMZ0hGNHZETmFRTGVWMkpXcFZyem1UL2lZUHZS?=
 =?gb2312?B?aUJYZUFFZ1N1OFNreGk2cmZrbFVlc0plQVkxbFVMWEtNZkttOUk3VDJJUHlz?=
 =?gb2312?B?cUVYcnpmOWFzVUVZQjBOSThjcFlzMkNQb1VQa2syZnhlMU0wQUI5aUJualpS?=
 =?gb2312?B?QmtKNzEwMW8wUjhyTk96L0ZxOGt1aU92Vkxub0tMejFDQlc3WU9HRkdRcDZU?=
 =?gb2312?B?eVlaYTlPM1IyanMrV2JpTXVNdWwwd0wwT0E1Ri9QTTVVVWRZbjJYd3JzS0E4?=
 =?gb2312?B?ZEFaZzEwWnEvOHlFUkgySUxMSmVLbUczclU5OGdKUXdSMU8zMm8rMG1SU1RF?=
 =?gb2312?B?TEViVzNFb3BRdnJwRnZrY0UzRTdEajdoSFJ0UHpyTHM0SUJmYUE1cGppclNm?=
 =?gb2312?B?amM2NHdzbDgrQWVTRlVTdkh5eWhUbCtvY2k0eXlTVE4wR1hSL2lwcW8reXQv?=
 =?gb2312?B?bm45cllFS0JNUHBoc0Z0L3dSVGxXL0hMMVBXUmgxQmFHMFI1bGRVa3NxaG1L?=
 =?gb2312?B?VTFTUFlTb0JMOFJDZXhmVDFEK2FTeXphajVrUXFmaDc3VldSLzZUSjM2dEZ3?=
 =?gb2312?B?bDlFL1hFRzhsOExER3g0UUhVYXFaSHVoYjN2bGtGZlY0WUs4Z3BtNTYvdzJ2?=
 =?gb2312?B?bVlaZjUvTDNPRFhPclYveFNlRFZFMlVwWFR4K2dFandKL1dOUGd6bTZxbVBa?=
 =?gb2312?B?RytDemZKeCtKckRxSW9vQm9lVnB6OWxVTi8vaysrbllmTlZlL2l5UlNkYlJZ?=
 =?gb2312?B?TUxobHozcmFLRmN0QnQ5djZxWVcraW1CTHFJdDBpMFdqemRZOFpXRThIOEJG?=
 =?gb2312?B?YU1yM21keTdJWWIybUVUTVRqc04rSW8ydlBSRDNPQjR2TDJCRmttWlgzNlQv?=
 =?gb2312?B?cWtFMXB1bW50dGx0VlhQZ3VkTW80VVBNQXB2TkV5Y2U5Vm9uUTY5NUpSeVA3?=
 =?gb2312?B?d1FpdTgrYzBYZm56NkVPNWRheDZESnVZK1B5eTBnSDJmcHpjeWRJb1JoZFFU?=
 =?gb2312?B?YzMvWndyY2d4TEdaL1psS3JzZU80L2plNkVBYnNQQVpXQmJsNHZqSFBLMmV6?=
 =?gb2312?B?SmJNMHNkdnRENjJhRElYYWFDRlRXbUVObDBCS0pyajFTYm1vdU4xeUc3c0ZF?=
 =?gb2312?B?bEpqcXJDNmtGMGV6RlYxeEZMTGdLeUdPNE94SGZ0dDNpUXYwYVppQXdLRHJv?=
 =?gb2312?B?UWdGQnhXcG0reHlWaHZWOXdHeEttMnV5TnVSUkJ4ZHR5L2ZKdXR6QnE2eDFI?=
 =?gb2312?B?WEx0WDk4bENqWG5jbTNGbGVFUC9rZEJVeFVMTXFvRU1ScHhCdHZvK1JLVktZ?=
 =?gb2312?B?Tk9BWmIxTmxiUlpjODhXKzY5UWFwZDVaWFZ5MExpZ3BSNFBjYkczanBQRVA5?=
 =?gb2312?B?M1BRWGlGMmZtT1NjQWZubkpNTE1WOWlZUWd3WjhobEM3NnBDRDNCODRURXVK?=
 =?gb2312?B?WmlJdnNvZ2plZ2xQbWYxS0VoNkdpMWtWZCtSb1NOL291ak4xdXl5YVZoa1hs?=
 =?gb2312?B?Qm5OWStFMmdpcGZQZnZmN1JraitJT0ZMSVo1UGIrbXQyczNYalB3RnRYaGhW?=
 =?gb2312?B?VktBR1d6enpQYVQxTzFuMGpoY0Zobkl3VVpNM052Mi9NRzM2VDdVUGlRWXRZ?=
 =?gb2312?B?L2kvcE5OaDFoeVNxajVrKzhEcnJlelB2RCt1Zzl2Z2g5cEt6V1NwUWhDdkNx?=
 =?gb2312?B?aUdMNWNDRkJVVDVnR1VGbnpyUWxYSVphWUVTSGIyUm5CZUJtcExzakRxWml2?=
 =?gb2312?B?OWozYzVET0pyREJVUE5WVXdQR3M1NWZNNmM3QS9Ea1cyN0pZVWhuUnk5L0Vo?=
 =?gb2312?B?L1NQVXZZSGROdWNSZUhMZmdBR0NiT05TOGFUR0gvWXZoWUZqMXgzY2Z4RURh?=
 =?gb2312?B?V3c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3628d7f-6831-41ff-23c2-08da5b2861b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 06:10:22.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02BLG0nQ5JRCqmHy/RCVnTQnLA2Yx7FV+xg7jviXAs2NCgGpXESbLmSh+ytO8iHKl1JbdnjisAcqAGMH1Fe61g==
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

RnJvbTogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCg0KQ3VycmVudGx5IHRo
ZSByZXF1ZXN0ZXIgY2FuIGNvbnRpbnVlIHRvIHByb2Nlc3Mgc2VuZCB3cWVzIGFmdGVyDQphbiBs
b2NhbCBxcCBvcGVyYXRpb24gZXJyb3IgaXMgZGV0ZWN0ZWQgYmVjYXVzZSB0aGUgc2V0dGluZyBv
Zg0KdGhlIHFwIHN0YXRlIHRvIHRoZSBlcnJvciBzdGF0ZSBpcyBkZWZlcnJlZCB1bnRpbCBsYXRl
ci4gVGhpcw0KcGF0Y2ggc3BsaXRzIHRoZSBxcCBzdGF0ZSBmb3IgdGhlIGNvbXBsZXRlciBhbmQg
cmVxdWVzdGVyIGludG8NCnR3byBzZXBhcmF0ZSBzdGF0ZXMgYW5kIHNldHMgcXAtPnJlcS5zdGF0
ZSA9IFFQX1NUQVRFX0VSUk9SIGFzDQpzb29uIGFzIHRoZSBlcnJvciBpcyBkZXRlY3RlZCBiZWZv
cmUgYW5vdGhlciB3cWUgY2FuIGJlIGV4ZWN1dGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBCb2IgUGVh
cnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KLS0tDQpWNDogbmV3IHBhdGNoDQotLS0NCiBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9jb21wLmMgIHwgNiArKystLS0NCiBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jICAgIHwgNSArKysrKw0KIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3JlcS5jICAgfCAxICsNCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV92ZXJicy5oIHwgMSArDQogNCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfY29tcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jDQppbmRleCBk
YTNhMzk4MDUzYjguLjBiNjg2MzBhM2U0OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX2NvbXAuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
Y29tcC5jDQpAQCAtNTY1LDEwICs1NjUsMTAgQEAgaW50IHJ4ZV9jb21wbGV0ZXIodm9pZCAqYXJn
KQ0KIAlpZiAoIXJ4ZV9nZXQocXApKQ0KIAkJcmV0dXJuIC1FQUdBSU47DQogDQotCWlmICghcXAt
PnZhbGlkIHx8IHFwLT5yZXEuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IgfHwNCi0JICAgIHFwLT5y
ZXEuc3RhdGUgPT0gUVBfU1RBVEVfUkVTRVQpIHsNCisJaWYgKCFxcC0+dmFsaWQgfHwgcXAtPmNv
bXAuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IgfHwNCisJICAgIHFwLT5jb21wLnN0YXRlID09IFFQ
X1NUQVRFX1JFU0VUKSB7DQogCQlyeGVfZHJhaW5fcmVzcF9wa3RzKHFwLCBxcC0+dmFsaWQgJiYN
Ci0JCQkJICAgIHFwLT5yZXEuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IpOw0KKwkJCQkgICAgcXAt
PmNvbXAuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IpOw0KIAkJcmV0ID0gLUVBR0FJTjsNCiAJCWdv
dG8gZG9uZTsNCiAJfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3FwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jDQppbmRleCAyMmU5Yjg1
MzQ0YzMuLmE5NWQzYjQ5YWUyMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3FwLmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMNCkBA
IC0yMzAsNiArMjMwLDcgQEAgc3RhdGljIGludCByeGVfcXBfaW5pdF9yZXEoc3RydWN0IHJ4ZV9k
ZXYgKnJ4ZSwgc3RydWN0IHJ4ZV9xcCAqcXAsDQogCQkJCQkgICAgICAgUVVFVUVfVFlQRV9GUk9N
X0NMSUVOVCk7DQogDQogCXFwLT5yZXEuc3RhdGUJCT0gUVBfU1RBVEVfUkVTRVQ7DQorCXFwLT5j
b21wLnN0YXRlCQk9IFFQX1NUQVRFX1JFU0VUOw0KIAlxcC0+cmVxLm9wY29kZQkJPSAtMTsNCiAJ
cXAtPmNvbXAub3Bjb2RlCQk9IC0xOw0KIA0KQEAgLTQ5MCw2ICs0OTEsNyBAQCBzdGF0aWMgdm9p
ZCByeGVfcXBfcmVzZXQoc3RydWN0IHJ4ZV9xcCAqcXApDQogDQogCS8qIG1vdmUgcXAgdG8gdGhl
IHJlc2V0IHN0YXRlICovDQogCXFwLT5yZXEuc3RhdGUgPSBRUF9TVEFURV9SRVNFVDsNCisJcXAt
PmNvbXAuc3RhdGUgPSBRUF9TVEFURV9SRVNFVDsNCiAJcXAtPnJlc3Auc3RhdGUgPSBRUF9TVEFU
RV9SRVNFVDsNCiANCiAJLyogbGV0IHN0YXRlIG1hY2hpbmVzIHJlc2V0IHRoZW1zZWx2ZXMgZHJh
aW4gd29yayBhbmQgcGFja2V0IHF1ZXVlcw0KQEAgLTU1Miw2ICs1NTQsNyBAQCB2b2lkIHJ4ZV9x
cF9lcnJvcihzdHJ1Y3QgcnhlX3FwICpxcCkNCiB7DQogCXFwLT5yZXEuc3RhdGUgPSBRUF9TVEFU
RV9FUlJPUjsNCiAJcXAtPnJlc3Auc3RhdGUgPSBRUF9TVEFURV9FUlJPUjsNCisJcXAtPmNvbXAu
c3RhdGUgPSBRUF9TVEFURV9FUlJPUjsNCiAJcXAtPmF0dHIucXBfc3RhdGUgPSBJQl9RUFNfRVJS
Ow0KIA0KIAkvKiBkcmFpbiB3b3JrIGFuZCBwYWNrZXQgcXVldWVzICovDQpAQCAtNjg5LDYgKzY5
Miw3IEBAIGludCByeGVfcXBfZnJvbV9hdHRyKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgaWJf
cXBfYXR0ciAqYXR0ciwgaW50IG1hc2ssDQogCQkJcHJfZGVidWcoInFwIyVkIHN0YXRlIC0+IElO
SVRcbiIsIHFwX251bShxcCkpOw0KIAkJCXFwLT5yZXEuc3RhdGUgPSBRUF9TVEFURV9JTklUOw0K
IAkJCXFwLT5yZXNwLnN0YXRlID0gUVBfU1RBVEVfSU5JVDsNCisJCQlxcC0+Y29tcC5zdGF0ZSA9
IFFQX1NUQVRFX0lOSVQ7DQogCQkJYnJlYWs7DQogDQogCQljYXNlIElCX1FQU19SVFI6DQpAQCAt
Njk5LDYgKzcwMyw3IEBAIGludCByeGVfcXBfZnJvbV9hdHRyKHN0cnVjdCByeGVfcXAgKnFwLCBz
dHJ1Y3QgaWJfcXBfYXR0ciAqYXR0ciwgaW50IG1hc2ssDQogCQljYXNlIElCX1FQU19SVFM6DQog
CQkJcHJfZGVidWcoInFwIyVkIHN0YXRlIC0+IFJUU1xuIiwgcXBfbnVtKHFwKSk7DQogCQkJcXAt
PnJlcS5zdGF0ZSA9IFFQX1NUQVRFX1JFQURZOw0KKwkJCXFwLT5jb21wLnN0YXRlID0gUVBfU1RB
VEVfUkVBRFk7DQogCQkJYnJlYWs7DQogDQogCQljYXNlIElCX1FQU19TUUQ6DQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9yZXEuYw0KaW5kZXggN2ZkYzhlNmJmNzM4Li40OTIzMzI1MzM4OTIgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCkBAIC03NzUsNiArNzc1LDcgQEAgaW50
IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KIAkvKiB1cGRhdGUgd3FlX2luZGV4IGZvciBlYWNo
IHdxZSBjb21wbGV0aW9uICovDQogCXFwLT5yZXEud3FlX2luZGV4ID0gcXVldWVfbmV4dF9pbmRl
eChxcC0+c3EucXVldWUsIHFwLT5yZXEud3FlX2luZGV4KTsNCiAJd3FlLT5zdGF0ZSA9IHdxZV9z
dGF0ZV9lcnJvcjsNCisJcXAtPnJlcS5zdGF0ZSA9IFFQX1NUQVRFX0VSUk9SOw0KIAlfX3J4ZV9k
b190YXNrKCZxcC0+Y29tcC50YXNrKTsNCiANCiBleGl0Og0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV92ZXJicy5oDQppbmRleCBhYzQ2NGU2OGM5MjMuLmJiZmZmZTI0M2ZkNiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgNCisrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgNCkBAIC0xMjksNiArMTI5LDcgQEAgc3RydWN0
IHJ4ZV9yZXFfaW5mbyB7DQogfTsNCiANCiBzdHJ1Y3QgcnhlX2NvbXBfaW5mbyB7DQorCWVudW0g
cnhlX3FwX3N0YXRlCXN0YXRlOw0KIAl1MzIJCQlwc247DQogCWludAkJCW9wY29kZTsNCiAJaW50
CQkJdGltZW91dDsNCi0tIA0KMi4zMS4xDQo=
