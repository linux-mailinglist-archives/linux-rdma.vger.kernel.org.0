Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5258381F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 07:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiG1FWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 01:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1FWT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 01:22:19 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634051A2D
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658985738; x=1690521738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bw4ywVQBFOu4h1EuINI2UxVSLdI6istsbjD1lwWqrVQ=;
  b=aYwP1f1BjinZObpEAn1KBgYU/tPqfx5mqX0f8kZ6v2QmQgwynmLgaYDd
   sCUEqq6phbOL2XILkj+Ql1MpXG3LuPNZ8AMmQ4SNiKl6cUQCtIjwQAAhE
   oNM2fAmXPgrv+KcjGxApqFZZgpYl/bGBzpDBD6n9Hsw56+od2237M42Fa
   ZPsye71SlD40EX7tBWnks5ua1Yi6/2gy5Nn3WgDSUNHZUGp4txbvhCytS
   JuXrquG5lxzF+AzK7N2jFzY8/Q5fVV2ydMLRfuYLrjkCbJMYesMruTxce
   m4pC9MHDe7v48PrSmuyX0ah9kB3732QgtqdFjcoMzWMSmNjvAlrynMxpq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="61409525"
X-IronPort-AV: E=Sophos;i="5.93,196,1654527600"; 
   d="scan'208";a="61409525"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 14:22:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeYa5ktgf0HSlCTAeY8MXZ3EulVWW+jg+aoezpJQcoNS4qaXwSkdx1lU+y+/lgHJSJQnTg7yiqgskNKpvIMXXqANtnF0DfQRNqXr5f60+liarTiVqXphJTLtWf7HCWBHRTCnpmywdSqYiqAUdCGGTlxwq+r20QbsuOVbnncf8dVCPWnKPMdhUdZ5v/JdxojD12/79W2i9TW85o1WTrQcWEd2VT0Q7SLOzhZrbm1X9xArlO+8IeItR/N2rL1yKVbVmaNeGhhCRuleaquTpqtShOb/LW+HGvg8H6pED6nQgT5AsKyQXulh9PwzrYMO+pgWFhwk9Thir+W8E6ZAW9LTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw4ywVQBFOu4h1EuINI2UxVSLdI6istsbjD1lwWqrVQ=;
 b=KYScHBSJxWrwr9Bgkr9aESzAhruBf1BpoQO6jr7fGL1sG1bkg3OUwqheig0Ht/fAwBYxD+LiSGoN6OGkSXS6K4uhqHlpkYkn7ucQNjYJlgyoEMtysSaGDsOS7cMsJmFcZjQKdvzlyRCiWaLRiCXsP70QLud/GxwWeW2TSb+6r6S7VyTRQ4BftL/PM7Ua/xOdPAjgxEPruLWLo47er0YVeCxcB2gjNJ2vLPryLIhZ9x17W3wrsmqslKzTQxqpPiubc81xyXJBzlzmMwCLD/7mZct1+GWQ9FqgDNb8t/YP2KWJuAMTnJ6NVRN/W/ayBqhODYypus38MQmz4jFD6QN/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSZPR01MB8466.jpnprd01.prod.outlook.com (2603:1096:604:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Thu, 28 Jul
 2022 05:22:10 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820%6]) with mapi id 15.20.5482.010; Thu, 28 Jul 2022
 05:22:10 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
Thread-Topic: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
Thread-Index: AQHYoTXIOjFXZzXvhUCb0Y264lSTv62R/d8AgACB9wCAAMGvgA==
Date:   Thu, 28 Jul 2022 05:22:10 +0000
Message-ID: <3ec0677e-f652-1541-b094-e74d23b7b1da@fujitsu.com>
References: <20220726212156.1318010-1-bvanassche@acm.org>
 <20220726212156.1318010-4-bvanassche@acm.org>
 <c8663ec2-0436-cafd-448b-50f3e191c5b8@fujitsu.com>
 <e268fd7d-e828-c5ed-8f95-0c6179db43fa@acm.org>
In-Reply-To: <e268fd7d-e828-c5ed-8f95-0c6179db43fa@acm.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a72771e5-eee2-4424-e619-08da70591f73
x-ms-traffictypediagnostic: OSZPR01MB8466:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZeEVSjRVfpA0ZOyidU+aBOWY8bFNKX+XvzbA1zQLCvs4Gum/AGCYd6SltU3De+JKKFlS9T3njSl5AgVF4w2NKvqvBKdvrCq269PXHavKeWRp39E0LUf2c0hCId5qK9C8bg+3tmAtizDg63jMSnvJ+ds7BGJkfvCAgr3OdaGkoZ4UqMQjFd0hvPiW9lx6iL58rO/8MPv7aKoUy1mJcib+n5JLGbH4/dYCwI8igARpIQRPCD6S4y1eY3eHFAABLwsB/VfGvEJ+g8rxwpa1//4TUFFOHIds16k4szUXurwLDeMVdNyuzt+XOlcYQYwn8yfzi/BGiUmjIIQ8PXTu4XDjmQefeDsedtpfO3VK4p2+PQPgM7kPZz5MWeVc8ax+XKewj211DqoMsr+bzesSVxkkOKBTBRcwbAM2IIBVkH+jSS9N4ABeNPAldNx+9FNj9AU2ugaCCO/DXxUh7kwtR6nZTS9VRSPeMme2Or3CQ50uAUhIhIc4wikemQfthrgAeeIzifZDCvgOm/b2NXN82V4Y+2wNOCTMSdOwhi0bVdcZdDpJHLp1ssn8fkd1SoTlT226ykF2WXKvrwQcFZwdoCf3R06OUwAmeQF6KM2sokW6birCJqWhqMxVRUxPms5gsSuqdL2MiIgyplVdhI2syHW9oXhNHXKWk3+TvbKGRtdq3QV61MaBeH63jSDj4CLp60cti8BAnBVuB8RsvdyRkSGPgVkeyusX6bQtLwSiLfMR44N297eZiBnHt46luw3w3X+8Y7BXvosZbMIaIoq/ggc0B+9Z4V+CiZUbg5VvPfUWuHATujUuM4hKllHvRBj0arex8+aU9OeWKT8vAfNhlEwOh4hjopMtK7WMsXIzx8j+TzPpQuDjLH8x4gFkRt8U/L5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(6486002)(186003)(71200400001)(478600001)(41300700001)(53546011)(2616005)(26005)(6506007)(6512007)(122000001)(38100700002)(82960400001)(4744005)(31686004)(66446008)(64756008)(8676002)(4326008)(85182001)(38070700005)(2906002)(5660300002)(8936002)(36756003)(66556008)(316002)(66476007)(54906003)(31696002)(110136005)(86362001)(76116006)(66946007)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHg0ZjN0NGt0OXJTbVFZcDQ2bm9ZV1NUa2dxUTZnaFplWEpsMWQwdklTdnZV?=
 =?utf-8?B?UEtQSk9ydlI3Qm95UU5aalVuM2I2Z2JtZittTnl2T3NaZEFLcG5jbS9rdHlT?=
 =?utf-8?B?bGg5QktTSEU5RXYvZlRFamJ1SHFQdE5SWTliYTBvTWtPQnVHWXZxN1pkNE5v?=
 =?utf-8?B?QVlZYTc1ZFR5WVRJMk1VYldzclFEMURoTW5OTEN2NHhWbUxkTUpOQzQwamxs?=
 =?utf-8?B?UlN6WTJWd29zcWNCUENnKzV4dHNGWmVhYnZxZkV4UXZVZkdkdHh5NUZVazdR?=
 =?utf-8?B?NTBPSXpSL0tteGpUSWNkNGJZZms3SExzcXRLUHRRMEp2QUZYVWpMQ01uWVJi?=
 =?utf-8?B?ZW1WTjEwK2trVURza1VoNmJDR2poVmZ2MStlQjBvKzJhbDR6aFdmUnBaMjNJ?=
 =?utf-8?B?SVBxWmFBWVJ4Q3ZCc2F5aUQ4a20ydE5mRVloYm1UV2VtK01nNTBpbWlqOWgy?=
 =?utf-8?B?Ym5NMGRxUjlYem9KWEpEazdqWTZoMGw2QXcrQ2RrTFgzVG5ReGtPMlZkMDlE?=
 =?utf-8?B?c0RDYlEvdXdJUU41RVg5V3dsYWVFaXczUUJHVHMzeEhDdWZwWWIzQjE2QWtr?=
 =?utf-8?B?Z2RkVFF5dktFRXl4N0lEZ1RFU25CVWZvZmhjZHJpbTBOckxUZmNhRXQ3YUho?=
 =?utf-8?B?WGltTHBOYkEvUE04cXBWUUN0eHF2a0VBRlhFV0lzRWN6NGd2bVdhS2d2Zi9h?=
 =?utf-8?B?c0dHanZFMm1zVGhERGlTTWd0Qkk3ZVB5dko3MWF0RnUycUx0SC9WYStqWHVs?=
 =?utf-8?B?bGttazg1Q2dpK1pGTVlHN0FjOWtmZmpjZjkvWmU3VWN0SjRTY010ckNROG1X?=
 =?utf-8?B?UE94UElBWm92bk93SFdtZUdQNWJDTEFxalNPU0VLcitUQzBNUGdDU3Bmdk4x?=
 =?utf-8?B?WDdJNnNiT0EzMmtldzhRcUtjNExoNXoyQ015cWxqTGNXZzAvRlVjNU1wQ2xo?=
 =?utf-8?B?ZVoxaFM2dWEzQllSMmx6MkhaajhvbThJWTBIMHpkS1dVN3hwTWdDT0xlSTAy?=
 =?utf-8?B?MUo3ekpnTG55WGpPV2dsbkwrTTE0dDdnVzd0TG1abnAvYXVnOUF3ai80cjRQ?=
 =?utf-8?B?T1FONGdTeW5CdWlLVFdjTU0vTmxQOWF4cmNnN1o3R05Mb1FzYndGZlRpR0lr?=
 =?utf-8?B?eHhJcE53SlBjcThMWEVlbng3MFFReDZVMnRSUE9TdTRTbitwVWRoT3JnMXFw?=
 =?utf-8?B?TEI1akFsbjlHaUN4QlU0RmNaS3Rja00zb0pNVDZIVWs0aXlrelk1Qk4xVTFU?=
 =?utf-8?B?MlV1MEkvMkFFZUhJbVA3clp2VnJCOE9nellqSnNHdzk3WEthVXVTeGdDUUpp?=
 =?utf-8?B?RTIzdXVIa2JFOHV1cG55NCtoOURmdk1YWFp0dUN1cUJuU2hJZzJpNWhralVV?=
 =?utf-8?B?aWVBdDVCa0JwYS9GZXl2QWttcW9wUkJVVXV3TXdrQ1lxR0RPeVcyUkc0Y2w1?=
 =?utf-8?B?bXAyL0dvMDdKUVhzRzVLL1BrWTlST2Ura2liem54T1k4QXpJNDIrVG5iNUI5?=
 =?utf-8?B?SmZwcmZoOW11YTVaNmIyNythNEs5ZHN4cW9nOUV6blpkS0dhS1FNa0RLMU1V?=
 =?utf-8?B?MkI0WVdXK2xBcG16emplbVRQQmxwUEppT3lEWUJzaGdwZ2Z6SlNIVmhpN1d2?=
 =?utf-8?B?cWJWVVJxdHJHMi94V0oyYXhCbUtQbEIrd1FCekJEOEVnYTVwMjhoL0IvQXJw?=
 =?utf-8?B?bEwvMStSRW4rS084K21OTm94VDF6b1VFVVVJQ2w4YkpiSFZqZ0hDcUJaSDhY?=
 =?utf-8?B?b3NuUldYZFBRVTZlOE5WRXA1V3B1UUZOMFRGZjZ3ekhEZ09EY1Irb0Ftayt2?=
 =?utf-8?B?elBNekhLYVVCVHhxcmhkNnNtYXZoL3JRV0tJaW9ERXJOUDU2K2h5VkcyLzRr?=
 =?utf-8?B?b3lQRkxkOTc2NUE5cVNOb3A4MENXcTdacWlWcXFFK0xsaklmamYxdDZrTUNu?=
 =?utf-8?B?ZUJTNFVqNXJOZXk0ODNMUytrVVhjbHA0V3k0dDA2ak1haDFOa2RaV0x0NXBq?=
 =?utf-8?B?Z1kzL0xDOVpaQXpqQzFNZTVlaWQ4djFZV2dXSkFVQ3lZMTU2YmdNdlRqU2tn?=
 =?utf-8?B?d2hSNkl2d3ZIdmxDYWVWTWx4bldWdWhreUZMcHJ1b2FsNTYrQ1ljSVQrOWNM?=
 =?utf-8?B?ZGtzVjFVY2Y4aDUxRFBtNml5dFJtZnpZODhlckVJeE9iZzRuOGt0LzVwZnRX?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A0E189271678B4E95420A7067C220F3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72771e5-eee2-4424-e619-08da70591f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 05:22:10.8279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJlYDjovoL7g7goPIyOAquzxMHyNEF1xvnabsuxfPlKj6YMXj8zO+PfjFL6W185e1oyM1Kvaxti9MBNFKnrdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8466
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI4LzA3LzIwMjIgMDE6NDgsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gNy8y
Ny8yMiAwMzowMywgbGl6aGlqaWFuQGZ1aml0c3UuY29tIHdyb3RlOg0KPj4gSSB0ZXN0ZWQgcGF0
Y2hlcyB3aXRoIGJsa3Rlc3RzL3NycCwgaXQgd29ya3Mgd2VsbCBhbmQgdGhlIFVBRiBpcyBnb25l
Lg0KPg0KPiBIaSBMaSwNCj4NCj4gVGhhbmsgeW91IGZvciBoYXZpbmcgdGVzdGVkIHRoZXNlIHBh
dGNoZXMgc28gcXVpY2tseSA6LSkgSSBhc3N1bWUgdGhhdCB0aGUgYWJvdmUgY291bnRzIGFzIGEg
VGVzdGVkLWJ5Pw0KDQpTdXJlIDopDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4NCj4gQmFydC4N
Cg==
