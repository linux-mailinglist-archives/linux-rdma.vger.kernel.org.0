Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89182589865
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Aug 2022 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiHDHa3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Aug 2022 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHDHa2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Aug 2022 03:30:28 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C013F44
        for <linux-rdma@vger.kernel.org>; Thu,  4 Aug 2022 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659598227; x=1691134227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ybmgGH9oSrHLt1MUaBQaFCiVEBsHcdPRAktgikvKcO8=;
  b=HxhP2NllWeRjx+79ehwoKFAOauJmqmyoJZ9qRnBg55Hun8A7mOHSVOq6
   VPR9VDHe8TPFjm3DnmO6DPBkBB0SZ5kS6DtJUsOc3oLwTAgk7PSlkYtsf
   gKzXMF6vDB0XHu2jta5Se07izPk6xrqpi/zlLXIBdFAHMh+MNX/Bn6s0n
   oQwhbnteP8zh+pwyJ8HZbTtiYokVxQKTk4S2rqIcvI4etupLsPXxwKN84
   NJ2XxYpsxXSsNKugjWiHoB+aJfdvATyFFHGxDQ0qR0+8sfl4wQrG/u8MR
   rCC2qDpefmiz0fMzMcOELc7irmdkw1k5U0nJ4mKIkGJ6SmnMkSGgy/qU7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="62139982"
X-IronPort-AV: E=Sophos;i="5.93,215,1654527600"; 
   d="scan'208";a="62139982"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 16:30:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/cnwmz4QjZ4yDJh79e/R09BdiqZFGBf3OVbCyXJ63ou7RWJan+J0KikF+DSdqvFTzvopWaXUPtkBUR0rCYeMKE7eVqBn4BomTEoVM05T7rQp2jJj4AzTfJmOv+8G7uFtu2Y11eVJ/yxRMi9pwCTvMyY3kGVcdeP2O1uxLqNmxbAj21rE/wfX+8smLyZFF3rbYCR2ryRjl/2GBCQId5ZuHt5XXfJjrLjFwOFsb41Te34f1LqpZ/NiCUOsU2a1vPJmUBzkD84372yag6hZZBI0+cX9+ZPLPttpQGq9s0+U5VlysouGA2/8T1sfwqTDHkSd1Q5JgDR+8GFSj0+5CBP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybmgGH9oSrHLt1MUaBQaFCiVEBsHcdPRAktgikvKcO8=;
 b=MLHPNo/DIu6HqNT4ty5+oMOaDdS5uXJif08Jz0pcJtib/ybY5/ABFzvemgjTsInnKjUtXlx+S/uanNx+ahpFqmlBe3/zADQXI9MvQJ0fJ8x5OFWOw5wi21tDhtjlgUVyVUhrNVxMVktheMhruoeVEjMQT0/99MTXZeH7YD9fPvJuUr5uYkRHYM+fsz5+43O7pCub6GYOzUVKMoWcWDF8bfl9apeH48juDRhaOSpuIKhmkedG9lMJ+ORKTBHG7rQBGRrpBtvbrl370xkr2PKXcgxcSf5H3hzyAxSdm3ogqPA3laMImGEf3R35EdQFEAz58SvJw5PuTWMCNfKZv4YJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB7817.jpnprd01.prod.outlook.com (2603:1096:604:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 07:30:20 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419%4]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 07:30:20 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH v5 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RESEND PATCH v5 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHYkn+OvgSlKAPHREqgV/9WP2Vh0q2egfcA
Date:   Thu, 4 Aug 2022 07:30:20 +0000
Message-ID: <d2ed21c9-ef86-8a83-425c-829f84a66a52@fujitsu.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220708040228.6703-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71fedce-97ed-4455-7348-08da75eb2fcb
x-ms-traffictypediagnostic: OSZPR01MB7817:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?WlpOL24yc1J3OTA2NVN2OWF5SU42c0o2NUFJdDUvcDdOUTYzaGo1Y3VGTElQ?=
 =?utf-8?B?Q051T1E3QlBublBpWUVHYnMwNVFNWkZOTkQ4enlQSmtvczVQa3Y3dWpPdUt1?=
 =?utf-8?B?d0xBRmxZcXluejQzV0ppd1VGVWFwT3FUZVNQemUvTW5wSVJPMGJ1N2RlT0FK?=
 =?utf-8?B?VXROc2NRK1FkR1cwUXVKOElwOEhkaXRHSEVDTW1FbmVIV0ZHbjRpMFBVaFJ5?=
 =?utf-8?B?Zi9rT0tHa2w1NlcvQjlJcTFybTBhMW1xbW9NSXIvNG1jMytFY2ZFUEZDdmxv?=
 =?utf-8?B?KzVPOGdERmlZaXdRbW92L2s0RWxRTFYxRi9zaGFPZVl6VU9hdzI3OENaRGc1?=
 =?utf-8?B?dGplK1BlZElWS0FqeTdvS2lKL1dhTWgyOFM0TGhiT3JvcGRRVldyTzJwNEto?=
 =?utf-8?B?TlIwanBwL2xtU3NpRXRmNGgvaVZuWmcyRDRubzZjOFZpNTBibEpuMkNGN2hq?=
 =?utf-8?B?cXhESVJQcGVxRXN2OXNhd0JVT0t4WHYvQ0pRRXRYWHRnYTlLcTJGSkk1V2Nm?=
 =?utf-8?B?VldNWHhLM3BXU2RpdGYycU5nRUdPUkI3UjQyYVlCMUFSNHYxZXpja09zNDNk?=
 =?utf-8?B?bWFhTmZMdXNBVUw2NzExUGlBTDh1YytWWEJzb3Q5ZzlzalRxa2lzdW9xWFcz?=
 =?utf-8?B?TFIrWHUwSmEzVncvQWlocmFENnBuZ2dPeU95L2xDUHlQcTFZd3dsOVA1eDIz?=
 =?utf-8?B?d0R3aFRFNHJwMTBwM2tUZ0NmVUVUUnpYeWJmQ05vTVV3QTdaWSs1UzN0VlhP?=
 =?utf-8?B?Y1V1bHRIQkUyRm9IUmd5TWhvMDNFMjhjNCszQ1FXSFpTa3dOZmwxSkk1bUVV?=
 =?utf-8?B?UHVvNThuY2VDRlBXS3Zhem0xRURyaTd1MlVnM21KcEtqOE1nZ1g3WlhMVUV2?=
 =?utf-8?B?NUJacHJjTDZ6aHFrcFhzcDZpQ2o5aHNNTHM0Nm56MFIzZzRaSmhwUHlBUWo3?=
 =?utf-8?B?alhWdnpVeVg1TVhIOW1jeS9FQTg1OXlsd04rbE0wOXI2Sk51YklLd29ySEtE?=
 =?utf-8?B?Zm9Edkpad3k2UmpKUVBwNlpIVWJqMGg4YU5FcDNBcnlmTXF6TTJlVFZwL1VS?=
 =?utf-8?B?QTErSGRMYWVIQzFWcU51N1RsTm5nYXZvT0hNMnVacmladTI2b29yclEvdWlk?=
 =?utf-8?B?eGtHKzlNbTQ1WnF1OUd1bXpOOElZL2pKbDlZVmJjZzNVVXRCT0RKWDlIcWxD?=
 =?utf-8?B?YnE4Ynd4SXhYakRHMzNGd1MxTkV5UHp6U1lNMGkzaHR3SE83WUZSdldneE1k?=
 =?utf-8?B?ekhBOGEwVDl6Q3VCeXl1QnhHeDlGN1RSREthaTBTZzk5S1ozZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(122000001)(71200400001)(66556008)(31686004)(36756003)(66446008)(64756008)(8936002)(8676002)(66476007)(4326008)(91956017)(478600001)(6916009)(6486002)(966005)(54906003)(316002)(85182001)(76116006)(5660300002)(66946007)(107886003)(41300700001)(2906002)(2616005)(26005)(186003)(6506007)(6512007)(38070700005)(83380400001)(53546011)(38100700002)(82960400001)(31696002)(86362001)(43620500001)(45980500001)(15398625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1BQTmhsSXo3RmtRWVVHQkFYdVMvOG9TRkYrTzlPYjZleWxZazh5UkhMTVJY?=
 =?utf-8?B?b3AvUXZXb0twL2JaKzROaFJCbG5Ub2UzSXFSYUlvTE9nMnlaQWhaL3RLOFJY?=
 =?utf-8?B?WjdpNStrM1FGWTJNSjVkbnNpYXFZeXRqVCtxci9pSGV2SE5JU0J6QW5wbFVF?=
 =?utf-8?B?VnNFVjgvd1dTVkw3WTAvYkN4dVpWVTdQdUFCajB3ZmptSnlZQWxBSWdjMXRG?=
 =?utf-8?B?RDZZWGZIbGJyVUxDWVlGWTExU0RqNzNzdDUwN09zRVhyVnZmM2RsZjdxdUJj?=
 =?utf-8?B?dGhGR0dlRmlMaDVjTEFVMmhWMlVTaCtWSi81aDF6a2NNemVkbUpsUUhzUWF3?=
 =?utf-8?B?VHRBcDJ1QXdRamFQa0p2bnpLdFd6dE9NY3VtNXlJWDNSa3JaNThzWFlUSjJn?=
 =?utf-8?B?SkFyVkVkRVFnVlk2THBlK2dMaXhVeG9OY3YrZXMyUjVxcXJoUGxCY05RSTNB?=
 =?utf-8?B?QlNRaUd6TDgvNnJKbDhIeDkwQ29TUFJYdjdJQzdUTHBUd2RnQUloK040K1Ur?=
 =?utf-8?B?cHZPRk5OaFc4T2xrcGwrbVF0bVc5UVFxUGp4dzF0Qm04R1NLVjlnWERUV2l0?=
 =?utf-8?B?WmYyeUhJTUk4ZmpCSkVpVzBrL3RBZENvSXg2RkJEU2JFMnk0Y2tqNGRaUEU5?=
 =?utf-8?B?WXhNTHp0ODZRRXAwUCttdFdQNU90SXRmKy9NeEVlcS9aMWZ3S2NWcHFtamda?=
 =?utf-8?B?ekRvYWJaVTN3SXN6eUNUZmJNZWtMR3VTa3lHaGhTNTZrQjV1NlVhMnBJQTdU?=
 =?utf-8?B?dGxmL3g3dklETWs2Rk83MnprVU1Va2tVNEtkdllCM29CNUd5Sm1lbzlKY2xm?=
 =?utf-8?B?dHdXMjVYVk5OT2hlTnpsNm1iWXUwUUh1Ynh1L2ZtcERlWjRsK0J5eHhZV1c2?=
 =?utf-8?B?MW1jNVNNQjYyUUY1a09tQUxsWWo5TFk5bnlrUkhWakVDemU0dXpDdjVENUsw?=
 =?utf-8?B?U1h3QzlkdlczaGRwYVUzZlcrbWVsY0FvaG1tMmkydGMySHJKVVBmYkpkalJN?=
 =?utf-8?B?N1pha0pmd0ROMnk0a3FsUVFSRUlhNG5jZXVqRVVhdE90R3dUaUttd04vdFI5?=
 =?utf-8?B?MXZwUzB6T1Y4WVV2QlFzMGNHU1hNU3ArYnJGMWdjcmxKK2V4d3NXZ0wyS2hs?=
 =?utf-8?B?eVVHbXFEWjJCU3U3WjRnQnFBL0R1TWhTRVNCYk5vN1JMU3FJUTFyMVFSL0xQ?=
 =?utf-8?B?aS85eE5QVUJMK0ZrM283Um11eWttZEZSaEdFbVhTM0liM2FVdDNtSG1WVHRx?=
 =?utf-8?B?U2o5UHg0ckJNZU9oQXo3N3hXemJPSExldTBCNjBpVE5RcExiSk1IVkxmSVY0?=
 =?utf-8?B?elNIUzZCMWkxSXNwRVU5WG9RUTJjaHkrRUk3blNQTm1SWWo1VVFvTGp0RWRn?=
 =?utf-8?B?NzdPaFJSMldMNXd1NnlsNnpXaVMrNDlWSWROOEo5TFhwNFpxdGV0clpHazFs?=
 =?utf-8?B?aGJ6KzFjU2E1aHR5TkdjcWZUM0Rsc3pnbVluVXFuNWlGWUpsenRVWFY0ZEtQ?=
 =?utf-8?B?T0I2ZUhtUjRrcTlJUHBBb1VJYWFFbHo2VVQ1VVc4Vm9kRmk3cC9acjMyNm8w?=
 =?utf-8?B?QkxiOXR2YmJUWldNRjVPWEZZbzlRN0k2ZkQvMzBIcU9QZzZYVE1lQjZaR0Vu?=
 =?utf-8?B?eFFVV1hwUVNXdVR1clpQalVUSDRZUGdCaytJTnU2OUhMa2EvR1ZOejNPTDhv?=
 =?utf-8?B?SDNsaTE1YVRxUDRZOWlkYkQ1Q3pvYmJTb0ZKMHByb0tjeWs0VkpHUllMODZz?=
 =?utf-8?B?Qk1FMVlzbmcwTU14RUlzbXNFQjdIZ1NTTWJaOWd6TXd5SHN3VTBERm1UTWdP?=
 =?utf-8?B?UWdoYjNsbWU4a0dkam43NXRtRWlHdXRhbElWVVc3bmZGcklJbWxkNFZPTkR4?=
 =?utf-8?B?dTg1aDZMTWFqSTNXSk1YSmNGVElJZm8yMm5rKzV3cFZwRWM0V09KbHFlenR6?=
 =?utf-8?B?Qm5HZ3FHWkJqL3pmajMwYXcvNHFIZU5LSCs5cHRrODZsbmNRb2xEMUpiZGFS?=
 =?utf-8?B?b05Qd1Z6bmhqUFcrcys3ekVPQ0RleVhsZ3RvS1BDT0FvUk14VmM5cTNpTXlP?=
 =?utf-8?B?dEJ2b056b2lZL09hVUVodjI5NzloOVVhenRFajlJNDgrdEhMdlRXa1NENWZR?=
 =?utf-8?B?bFdHTThCUnN2eUFJUHJNUWJnalJmRytTRU9PSzArc1dQbjZXZVhyWTZkcWda?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AAC501A78E3094FA00F6595ACABE2F9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71fedce-97ed-4455-7348-08da75eb2fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 07:30:20.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFogs+qWbVQWkxEnf3N8O+Kn3CwuzWZS01ztk1U0aceZArmkJ5qFGvIkpMJJeoYs32ffle09IGRu9xPikE9ncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7817
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgYWxsLA0KDQpQaW5nLiBJcyBpdCB0aW1lIHRvIHJldmlldyB0aGUgcGF0Y2ggc2V0Pw0KDQpC
ZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCg0KT24gMjAyMi83LzggMTI6MDIsIFlhbmcsIFhpYW8v
5p2oIOaZkyB3cm90ZToNCj4gVGhlIElCIFNQRUMgdjEuNVsxXSBkZWZpbmVkIG5ldyBSRE1BIEF0
b21pYyBXcml0ZSBvcGVyYXRpb24uIFRoaXMNCj4gcGF0Y2hzZXQgbWFrZXMgU29mdFJvQ0Ugc3Vw
cG9ydCBuZXcgUkRNQSBBdG9taWMgV3JpdGUgb24gUkMgc2VydmljZS4NCj4gDQo+IE9uIG15IHJk
bWEtY29yZSByZXBvc2l0b3J5WzJdLCBJIGhhdmUgaW50cm9kdWNlZCBSRE1BIEF0b21pYyBXcml0
ZSBBUEkNCj4gZm9yIGxpYmlidmVyYnMgYW5kIFB5dmVyYnMuIEkgYWxzbyBoYXZlIHByb3ZpZGVk
IGEgcmRtYV9hdG9taWNfd3JpdGUNCj4gZXhhbXBsZSBhbmQgdGVzdF9xcF9leF9yY19yZG1hX2F0
b21pY193cml0ZSBweXRob24gdGVzdCB0byB2ZXJpZnkNCj4gdGhlIHBhdGNoc2V0Lg0KPiANCj4g
VGhlIHN0ZXBzIHRvIHJ1biB0aGUgcmRtYV9hdG9taWNfd3JpdGUgZXhhbXBsZToNCj4gc2VydmVy
Og0KPiAkIC4vcmRtYV9hdG9taWNfd3JpdGVfc2VydmVyIC1zIFtzZXJ2ZXJfYWRkcmVzc10gLXAg
W3BvcnRfbnVtYmVyXQ0KPiBjbGllbnQ6DQo+ICQgLi9yZG1hX2F0b21pY193cml0ZV9jbGllbnQg
LXMgW3NlcnZlcl9hZGRyZXNzXSAtcCBbcG9ydF9udW1iZXJdDQo+IA0KPiBUaGUgc3RlcHMgdG8g
cnVuIHRlc3RfcXBfZXhfcmNfcmRtYV9hdG9taWNfd3JpdGUgdGVzdDoNCj4gcnVuX3Rlc3RzLnB5
IC0tZGV2IHJ4ZV9lbnAwczMgLS1naWQgMSAtdiB0ZXN0X3FwZXguUXBFeFRlc3RDYXNlLnRlc3Rf
cXBfZXhfcmNfcmRtYV9hdG9taWNfd3JpdGUNCj4gdGVzdF9xcF9leF9yY19yZG1hX2F0b21pY193
cml0ZSAodGVzdHMudGVzdF9xcGV4LlFwRXhUZXN0Q2FzZSkgLi4uIG9rDQo+IA0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IFJhbiAxIHRlc3QgaW4gMC4wMDhzDQo+IA0KPiBPSw0KPiANCj4gWzFdOiBodHRw
czovL3d3dy5pbmZpbmliYW5kdGEub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDIxLzA4L0lCVEEt
T3ZlcnZpZXctb2YtSUJUQS1Wb2x1bWUtMS1SZWxlYXNlLTEuNS1hbmQtTVBFLTIwMjEtMDgtMTct
U2VjdXJlLnBwdHgNCj4gWzJdOiBodHRwczovL2dpdGh1Yi5jb20veWFuZ3gtankvcmRtYS1jb3Jl
L3RyZWUvbmV3X2FwaV93aXRoX3BvaW50DQo+IA0KPiBOb3RlOg0KPiBUaGlzIHBhdGNoIHNldCBk
ZXBlbmRzIG9uIHRoZSBmb2xsb3dpbmcgcGF0Y2ggc2V0Og0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1yZG1hLzIwMjIwNzA1MTQ1MjEyLjEyMDE0LTEteWFuZ3guanlAZnVqaXRzdS5j
b20vVC8jdA0KPiANCj4gdjQtPnY1Og0KPiAxKSBSZWJhc2Ugb24gY3VycmVudCB3aXAvamdnLWZv
ci1uZXh0DQo+IDIpIFJld3JpdGUgdGhlIGltcGxlbWVudGF0aW9uIG9uIHJlc3BvbmRlcg0KPiAN
Cj4gdjMtPnY0Og0KPiAxKSBSZWJhc2Ugb24gY3VycmVudCB3aXAvamdnLWZvci1uZXh0DQo+IDIp
IEZpeCBhIGNvbXBpbGVyIGVycm9yIG9uIDMyLWJpdCBhcmNoIChlLmcuIHBhcmlzYykgYnkgZGlz
YWJsaW5nIFJETUEgQXRvbWljIFdyaXRlDQo+IDMpIFJlcGxhY2UgNjQtYml0IHZhbHVlIHdpdGgg
OC1ieXRlIGFycmF5IGZvciBSRE1BIEF0b21pYyBXcml0ZQ0KPiANCj4gVjItPlYzOg0KPiAxKSBS
ZWJhc2UNCj4gMikgQWRkIFJETUEgQXRvbWljIFdyaXRlIGF0dHJpYnV0ZSBmb3IgcnhlIGRldmlj
ZQ0KPiANCj4gVjEtPlYyOg0KPiAxKSBTZXQgSUJfT1BDT0RFX1JETUFfQVRPTUlDX1dSSVRFIHRv
IDB4MUQNCj4gMikgQWRkIHJkbWEuYXRvbWljX3dyIGluIHN0cnVjdCByeGVfc2VuZF93ciBhbmQg
dXNlIGl0IHRvIHBhc3MgdGhlIGF0b21pYyB3cml0ZSB2YWx1ZQ0KPiAzKSBVc2Ugc21wX3N0b3Jl
X3JlbGVhc2UoKSB0byBlbnN1cmUgdGhhdCBhbGwgcHJpb3Igb3BlcmF0aW9ucyBoYXZlIGNvbXBs
ZXRlZA0KPiANCj4gWGlhbyBZYW5nICgyKToNCj4gICAgUkRNQS9yeGU6IFN1cHBvcnQgUkRNQSBB
dG9taWMgV3JpdGUgb3BlcmF0aW9uDQo+ICAgIFJETUEvcnhlOiBBZGQgUkRNQSBBdG9taWMgV3Jp
dGUgYXR0cmlidXRlIGZvciByeGUgZGV2aWNlDQo+IA0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX2NvbXAuYyAgIHwgIDQgKysNCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9vcGNvZGUuYyB8IDE4ICsrKysrDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfb3Bjb2RlLmggfCAgMyArDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFy
YW0uaCAgfCAgNSArKw0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jICAg
IHwgMTUgKysrLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyAgIHwg
OTQgKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gICBpbmNsdWRlL3JkbWEvaWJfcGFjay5o
ICAgICAgICAgICAgICAgICB8ICAyICsNCj4gICBpbmNsdWRlL3JkbWEvaWJfdmVyYnMuaCAgICAg
ICAgICAgICAgICB8ICAzICsNCj4gICBpbmNsdWRlL3VhcGkvcmRtYS9pYl91c2VyX3ZlcmJzLmgg
ICAgICB8ICA0ICsrDQo+ICAgaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91c2VyX3J4ZS5oICAgICAg
fCAgMSArDQo+ICAgMTAgZmlsZXMgY2hhbmdlZCwgMTQyIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+IA==
