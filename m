Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882556B122
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 05:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiGHDz6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 23:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGHDz5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 23:55:57 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB874DE2
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657252556; x=1688788556;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=osY7demwA/7Kb4EgSQ7PDTDRfuEeaIyloiu9i+C+9/Q=;
  b=b2RSoUuM+s6PomsrLyq7sR4dWroyTz/bVBp/VOeICB5o3vCBnDESPvmu
   ggNzexOS4iRpwy2mYCWXmKxndrJ1DrZgQSLG3H0LFrpynY+zsdYyJpjwD
   GWo6UT2NQjUfhmZLNkD7pkdJ6tlUEzohjauVW509U91AQvngGN6+XhGEt
   J9KxhElIpipTmJgWy+VUKS3piLKetcVsrDXrv3pNDRC9W/SpsEwTYJCLU
   JI3PprQNmDOp5Px1RYvV4D6iqyOIJ8fXfFVBcx3x7m3GDZcVnwToxMIqL
   s1ubbyKhoX43xLqQzPNXPzw9QEee/l7WT+eH/Shtk83jH/bMnD3XcEoEL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="60037383"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="60037383"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 12:55:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/e2JaRPgelgobMxHefIgelNMjNGCtzD9uJ4BbYYdv3wDICYiOlUDy3C7WmN/6EkkNZj9TTtMbj868EHs6Ln6YM0SvSaz7wD0NtDkLiFtjUeFSrcf4S9ttU1DmQRogPOWwxXwa0JG4EXH4wFyXlVmb++rKOFot3Jc9iG71jpXrV7Bck8FKG22ikM5ntV9d8L+dyj8dd5pCj1P6Essjbjz5JBoSwGBHN+VoA/dPiA5fgCtN1flupj81fVpWiZ8HkXe5FDfle2qK+2M3goyLDxrrOhvp3m5ATcp8ODDJMVEC6NNX03KR16Kn9v/68J8b3SP0sOxb+35Pw7DilEWvBkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osY7demwA/7Kb4EgSQ7PDTDRfuEeaIyloiu9i+C+9/Q=;
 b=iEAZ6pJ0bRPjp0ZAMQGNrMGJn78iAawLfkIXEwPxXnZ342B20g3xhQ0JEFW/79gF7cd9plPRbB9sDYD2DupA7yoTCUzk0PLqIKVhkyWL2B//86C5WwcVSY1mquQNSJDCEh1DVrrFL/2sJz9JRmu/4gb4ds0PRmMorP5wq1d+hUbMMaXfppTs+29b87RA/XQaGYo+5JtyQGnX5iSRlA3qNkFMVS+yoXfPqLiJj/Ow1rM4nlKldCmveLNDp3dCBNESsAxO8QWzJnIP6i2rLwH2gcNqT3qjoLMnaWrKp9RF65s5SGUtCgCahO69tXxoNqbW754j/2UkUiWGSt4TF7usRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osY7demwA/7Kb4EgSQ7PDTDRfuEeaIyloiu9i+C+9/Q=;
 b=HBqkStrSv4vlef+B9zCsCTkSkNWKDf2kZ+nPisyCm7b5c4JiWbsmflrZGQi7k3eSp68Kt34NqTqkI14GQz+lDyPNdMZ4o2UiI0ZNIVJe+LVkdLypIOAfA6V0vkVV9GZAGWhmU0y97kJsAap58bEhqirvYSQqmzUM8jKFnh5yER8=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB9861.jpnprd01.prod.outlook.com (2603:1096:400:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 03:55:50 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 03:55:50 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Topic: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Index: AQHYkn6c+nf9xkj1KUiqbqr8TyUl7A==
Date:   Fri, 8 Jul 2022 03:55:50 +0000
Message-ID: <20220708035547.6592-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34d04e8c-4217-43b0-0a28-08da6095bf3f
x-ms-traffictypediagnostic: TYCPR01MB9861:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cE4z1BkbUVj0FGbbXHBIvIgKTIbAJEeG2mhd1vTBd9DTn0VWWeOPkA3T3CfVndCNw7RSuB/OCT7RzUOc/D9v5zyl/Ks8d0gCS+Nt5yE7ZkBquNfLRnxX4Py4vvfMLILW9NQ+rbZfJhhys1rREVnmwa9El2MO65N49b/8+Gyv4dUmH7vOlPBorObf83yX1R969iSDU++gLjAiUCvTYcZe4iaChBcbPYaKsyiBdm9UWAhQaWPNEfxiusJPBiPAOkgfETrgshk+7DXn4z0gc3cmEKbTOPbqL+touJMgXtkggZET13hO+XUqB24CgPouJN34/s2f8FdAqJ4fFUU17dOFukXQNMbDw+CXL4rFSW6Sy1n/OgiP9dGzGksPn9AjwjhSMfvBjpxJ+CtXzqvrwuOih0/DOLlU50MsAbNWlvxOKnNDWjxP5LdlAN2HNXwroF+sEbyZ0lgESUXKP7ZWzG5jvx83ABsTrZAsXt5UlKyZE9TAhFtcQWgIn+MmNxtwyDZMn5a1nAQd8ysqpDSq2EyyVHKikva5s37wfGnuKCQptah9EkyWw/H9rtu9wnmBQyg+5/9xSocjd1Y6i7jvKkasKa4E+/Fb6Y5prnlTbf5GTassAg5tfrscyXzDAl2+9ImlP+e81B6l7ZvBZz+TzJ6O2AKrcPjzrV/gvZ2eoofbg1iRagWR4VoBPXX9y2dusSLVd0PZaEiqk+L61XjFlUg5CZ7Xwfjf/nK2BtqiJr2T8BU98EneFdxdGO1BWESvTQ0OgvJCMDbetNYwR71G1U6IbD6Knkqw7QBtS6EqypURDDEw57s577bK5OxCKrZuU0wU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(66556008)(66476007)(1076003)(83380400001)(86362001)(2616005)(186003)(107886003)(38070700005)(38100700002)(82960400001)(8676002)(85182001)(6916009)(64756008)(316002)(91956017)(478600001)(122000001)(8936002)(5660300002)(71200400001)(54906003)(4326008)(6486002)(2906002)(76116006)(26005)(66946007)(36756003)(6506007)(41300700001)(66446008)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZldWREh1eTBNcmNQb01FalpESExJeTlWcGk3bzdiRUx6cURaRU5XV3k0Rmdr?=
 =?gb2312?B?QXgyR2Nyb3JZKzRrZ2QzRXdid1g2SWtRR1QyaVZSQkpoZGxtOUFXSFBxUGJH?=
 =?gb2312?B?ak9GL2VlSFRXQWlxcWNzbk9ZK3JKaHFObXM4cDRtQzVRWUlNVmZ6ZjNJNnFJ?=
 =?gb2312?B?NGRTMzNjcytGZlRweWxZM21PUmZBcDdoVkpxdkN1RkdMU2JjdkgveitPWXMw?=
 =?gb2312?B?OU0zc1VHZEcwS1JleXRRbDBMVnRTSTZRTElPNGhBRjRtaFR2SXQyVUdYY2t3?=
 =?gb2312?B?TFBlNmp5VzVVMTlLUWc0TVA1Wk5QQmdQSERPTzhmUDZjRE1nb2duMC9kMExY?=
 =?gb2312?B?d0NVV1RBeEhJOHp2c0dLOEczK1E1U1dzdDlwemZhNVJQMkx6N0VnSUhkSG1V?=
 =?gb2312?B?TjBIa3dRakJUcHlrWDhldDJnV0JTSVF3T1VZSXptN09NUE1BMFVWMEJGelBC?=
 =?gb2312?B?VlE3d2t0cityeEczV2dDOVpQQTZSYVNrU0xKNjRROU9nZnRJTlhNVFNyN3BG?=
 =?gb2312?B?N3dDNGNWcU1pTTRURkZlTGtlOVpxUVJuYWdRWjV6U3MyOHJ4WHBXZndjVWZz?=
 =?gb2312?B?andVM3VaTUxPZjFrN3pKN1Y1cXAzdXlQbVdiclNpMzlJNHJQNWtzVkJSQVdJ?=
 =?gb2312?B?Tk0ramcrallDeDhwS1dlM1p1OXluejJIZXFYbTZ2TktIZkM2cEY5MGkzVXl1?=
 =?gb2312?B?d1ZSbDRtOXpGY1VmQjFKY2VWWUlGNEg3aGRVTkJHYXVBNVp5cGYzbjl2UnND?=
 =?gb2312?B?T2Y1RjV6UkVxWjg4Y284bjNEK0pLZytTcjgyTUV5QW02YzZMSlFrbmkwYlpZ?=
 =?gb2312?B?RWgwL2pRRXFHam5ZckRQNFoxTTB4cS9KZTlzS3BFTWRwNURXMVFPSVFUaVFR?=
 =?gb2312?B?Y0w2Qzk4M0VLQ01BdDAvOG5wL0FsVFJoZjRVTGJGaU5mb3lwZzdJTDB3bWor?=
 =?gb2312?B?T0FqTStqamZpcFBPSHBocXE5YnhBSDNPWmRwbGRtVjgzN3l4UzQ3NjJIWUls?=
 =?gb2312?B?QjFwV1BIRDFycGVCOXl4VkttY3pWWnVGWnBIMkhzeTN1QStqZVVqSk1QaWNR?=
 =?gb2312?B?MTZUMDQ5OVdzSmo5NDRHNVJWajBsd2ViS0hyTnBEdHlxei9oOFRwcWpIalk3?=
 =?gb2312?B?d3hyZ2c2b0ZVa25KaldCN2V3eGtPellib29DUUZNOXNCbGxtRW1VZXJkYTI2?=
 =?gb2312?B?OE45SXYrbjc1MG1kdytIVzQyTG5tMFNmNHJLNjE4V3p1NWFEUW1CWW5zeGtv?=
 =?gb2312?B?RzVNVEE3RUt0Y1JnOWZDdmljTVRIU29mL3JKWTloS1ZOdmxKaEIyWnJHbEhW?=
 =?gb2312?B?clZYNEYva1E3eVowRjhrZmlpaUxCZk5QQUd5RXZ2eGI3UU5WQ3JCLzhxYlJp?=
 =?gb2312?B?cFpPVUFLeFlFREJUamt2MEZFVmtsVFppcTVycHJlTEtaS3Joc1dIcmpvai9Z?=
 =?gb2312?B?d1ZXMURuY1h5dDBoMzduM3k4TnRFdXp6Z3cyRXhaYzlIR0VXUDNVYWJQZnVi?=
 =?gb2312?B?NzJNSVNCMkp4UTRSWjNSc2ZWUThnTkFMQTZ4cU0rY2UzdHdyTlkzSlJaMGpJ?=
 =?gb2312?B?eGtRQlhwdk9OMlFRWkF3YldnU1JjTUFUN3k1Z3RTd2d6UVlnM015RzNTM1Rs?=
 =?gb2312?B?VzlZdnprQWVWNmc3cmV5TWR0SFJhRm5kZjgzaUxNZXpDQktraDFmMjMzcUg3?=
 =?gb2312?B?YStTeXBhQWRVVm9jODJiT2JFZFVmZlpOM1N2aW4rdGNHN0tkUXQxTjJmOVBO?=
 =?gb2312?B?bjZEeU91Qm5SRXlWZVROZ0Q3eWdGa0ZQZFp3VGNjWnYvNEsvSmRZcFIyRFZT?=
 =?gb2312?B?b1ZzME15a3NoQlkxdytvTDljdExETjVxeVhUZ1BhSW1JMjEvL0RCQTMvNDM1?=
 =?gb2312?B?QW1rOSsveE83Z3gxOTBhSVpWZmRvOHh5N0xhRlBHV0s0OVFuUDl6T2hwc2lV?=
 =?gb2312?B?WWtqd1RTenZMY0doZCt0a3hmZFlScmJLRklpU0ZPcGs3dUJGRzJFK0VDTkFn?=
 =?gb2312?B?MGFoeFpmZkxVL3JaRU8xMFUxdUFoSEw4SXhDNG9tWmswN1N3c2x5VitEdkFW?=
 =?gb2312?B?ZElHS2svdEtDM0xXdFFVTWNGajV6MndEY0FuS0lBdUVuSFhXcmdCQitJSmo1?=
 =?gb2312?B?ZlVVQ0Z6SUp4bFlkU3F2Z1NFOU40cTB0eldhT2c3ZlV3azRBQk1pWHc5MGZR?=
 =?gb2312?B?Y1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d04e8c-4217-43b0-0a28-08da6095bf3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 03:55:50.0851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RNNVqgObncRpQw4BjCJlhERH2ZAlIZVYWm257pIJs+v8oYxaFukLudcTb9ExFna+ippo7H+SFADXM9BqMjFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9861
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlIHFwIHBhcmFtZXRlciBpbiBmcmVlX3JkX2F0b21pY19yZXNvdXJjZSgpIGhhcyBiZWNvbWUN
CnVudXNlZCBzbyByZW1vdmUgaXQgZGlyZWN0bHkuDQoNCkZpeGVzOiAxNWFlMTM3NWVhOTEgKCJS
RE1BL3J4ZTogRml4IHFwIHJlZmVyZW5jZSBjb3VudGluZyBmb3IgYXRvbWljIG9wcyIpDQpTaWdu
ZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KLS0tDQogZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmggIHwgMiArLQ0KIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3FwLmMgICB8IDYgKysrLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfcmVzcC5jIHwgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbG9jLmggYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaA0KaW5kZXggMGUw
MjJhZTFiOGE1Li4zMzYxNjQ4NDNkYjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9sb2MuaA0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9j
LmgNCkBAIC0xNDUsNyArMTQ1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgcmN2X3dxZV9zaXplKGlu
dCBtYXhfc2dlKQ0KIAkJbWF4X3NnZSAqIHNpemVvZihzdHJ1Y3QgaWJfc2dlKTsNCiB9DQogDQot
dm9pZCBmcmVlX3JkX2F0b21pY19yZXNvdXJjZShzdHJ1Y3QgcnhlX3FwICpxcCwgc3RydWN0IHJl
c3BfcmVzICpyZXMpOw0KK3ZvaWQgZnJlZV9yZF9hdG9taWNfcmVzb3VyY2Uoc3RydWN0IHJlc3Bf
cmVzICpyZXMpOw0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCByeGVfYWR2YW5jZV9yZXNwX3Jlc291
cmNlKHN0cnVjdCByeGVfcXAgKnFwKQ0KIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9xcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0K
aW5kZXggODM1NWE1YjFjYjYwLi45ZWNiOTgxNTBlMGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9xcC5jDQpAQCAtMTIwLDE0ICsxMjAsMTQgQEAgc3RhdGljIHZvaWQgZnJlZV9yZF9hdG9t
aWNfcmVzb3VyY2VzKHN0cnVjdCByeGVfcXAgKnFwKQ0KIAkJZm9yIChpID0gMDsgaSA8IHFwLT5h
dHRyLm1heF9kZXN0X3JkX2F0b21pYzsgaSsrKSB7DQogCQkJc3RydWN0IHJlc3BfcmVzICpyZXMg
PSAmcXAtPnJlc3AucmVzb3VyY2VzW2ldOw0KIA0KLQkJCWZyZWVfcmRfYXRvbWljX3Jlc291cmNl
KHFwLCByZXMpOw0KKwkJCWZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHJlcyk7DQogCQl9DQogCQlr
ZnJlZShxcC0+cmVzcC5yZXNvdXJjZXMpOw0KIAkJcXAtPnJlc3AucmVzb3VyY2VzID0gTlVMTDsN
CiAJfQ0KIH0NCiANCi12b2lkIGZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHN0cnVjdCByeGVfcXAg
KnFwLCBzdHJ1Y3QgcmVzcF9yZXMgKnJlcykNCit2b2lkIGZyZWVfcmRfYXRvbWljX3Jlc291cmNl
KHN0cnVjdCByZXNwX3JlcyAqcmVzKQ0KIHsNCiAJcmVzLT50eXBlID0gMDsNCiB9DQpAQCAtMTQw
LDcgKzE0MCw3IEBAIHN0YXRpYyB2b2lkIGNsZWFudXBfcmRfYXRvbWljX3Jlc291cmNlcyhzdHJ1
Y3QgcnhlX3FwICpxcCkNCiAJaWYgKHFwLT5yZXNwLnJlc291cmNlcykgew0KIAkJZm9yIChpID0g
MDsgaSA8IHFwLT5hdHRyLm1heF9kZXN0X3JkX2F0b21pYzsgaSsrKSB7DQogCQkJcmVzID0gJnFw
LT5yZXNwLnJlc291cmNlc1tpXTsNCi0JCQlmcmVlX3JkX2F0b21pY19yZXNvdXJjZShxcCwgcmVz
KTsNCisJCQlmcmVlX3JkX2F0b21pY19yZXNvdXJjZShyZXMpOw0KIAkJfQ0KIAl9DQogfQ0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KaW5kZXggMjY1ZTQ2ZmUwNTBmLi4yODAzMzg0
OWQ0MDQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMN
CisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KQEAgLTU2Miw3ICs1
NjIsNyBAQCBzdGF0aWMgc3RydWN0IHJlc3BfcmVzICpyeGVfcHJlcGFyZV9yZXMoc3RydWN0IHJ4
ZV9xcCAqcXAsDQogDQogCXJlcyA9ICZxcC0+cmVzcC5yZXNvdXJjZXNbcXAtPnJlc3AucmVzX2hl
YWRdOw0KIAlyeGVfYWR2YW5jZV9yZXNwX3Jlc291cmNlKHFwKTsNCi0JZnJlZV9yZF9hdG9taWNf
cmVzb3VyY2UocXAsIHJlcyk7DQorCWZyZWVfcmRfYXRvbWljX3Jlc291cmNlKHJlcyk7DQogDQog
CXJlcy0+dHlwZSA9IHR5cGU7DQogCXJlcy0+cmVwbGF5ID0gMDsNCi0tIA0KMi4zNC4xDQo=
