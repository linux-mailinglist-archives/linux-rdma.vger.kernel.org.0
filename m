Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0064E01E
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 18:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLOR7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Dec 2022 12:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLOR7i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Dec 2022 12:59:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F037F85;
        Thu, 15 Dec 2022 09:59:36 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFHfXXI006128;
        Thu, 15 Dec 2022 17:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IWrKqNjAqmVe7geEQnxhWEOcUEIt1KInXdHb29QZL18=;
 b=sdbG997+SdsXtj7/3sV3lt+aLaTdW5drjuhW3IvLD/qbNSBqrHoe8js3HX+pE7J9yby7
 M2zyyklPjzNfaq4qSbWpm3DUrdOZu9wM4bG6kAUm00ndriTkfWwECCcsuVmkiat9TZy4
 sTf5Zv0hOJJfBuaiQIxLW0Jcj9QLT8qO4MF6AypXduBpoM9NMpZB4bOk3d9Wg/Tu7aRO
 GnYh1BQjQT21KyZBGHGZUykL4mHLMieazddQSc4quT3N7zrWtvDIk/y/eh41Ivtep8a6
 129HHla6zUuywvVHiheVWSbFz2qpUFkMUGM9Ps8SXdTZYSkd2aevc2o/8pHoEHvYmVzO Uw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg5pwmy80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 17:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYIMrd7YGODAtPCA7Vmg0WjvPSIbyWETiue2d6uDlGBUJo1nQXtvz51jm2WL3XVO/Y6qnvrJ7cnrjz5lOkFIwbpz6FYsRxnDcbbx6BokpDAlcWY8YFZT2UP407uLZhQ/Dq9IfofWiVte3wT8MWfzJBNZWivNc22sQvEct3m8Bgm7zmia5sDAGy9jP3TkOZVOvCYvyHtHWUCvRIgPF88QgV/B5TgQRgVHpP0s46twD6EpS696zpNAS7EcjehUqB4J60O+IDwZ7GBvLYaFCfajg3SWXscHoExEps+fSo4pp7TGDa7NQ8pLlxVC3UZgID+gKfZDQWXlHi1JpiUvJFiYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWrKqNjAqmVe7geEQnxhWEOcUEIt1KInXdHb29QZL18=;
 b=bM0QFKmJnqC9cZo7vdPSI7DPKrZUKCVIKgGs6j7c1aDct1eQQyUTsXaQ/Pa4z5XpypMqh97dJ4vPFzvj9hz9wAIGNFaDWGdTVbWn9ab/yfTqZvvjTCxHQRDMM2iGFvhdHdaFLJbSoNMBZ1vedIugQqtObSg7velVG83EIO8+rdBxhAldIklHR7ov+MymlBlbraiYBpMSPjctmDRZNn0RJpIYq3yo4P9NqUGqct326310YCzDci5W1DYzxJX3sJ0vG4iDR6ZKrvW3S7RudZOzMOKvAbw3mn5kObYZ5x2ldB8uXDXXmAjHiZiXXAdWN6luOVuq8waIvAHQU+tUvigLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by MN2PR15MB2703.namprd15.prod.outlook.com (2603:10b6:208:130::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 17:59:23 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:59:23 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Topic: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Index: AQHZEK72hw8+Zmd5vUSPwm9/BL+LoA==
Date:   Thu, 15 Dec 2022 17:59:23 +0000
Message-ID: <SA0PR15MB3919771559C7F2AA90D23B7D99E19@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221215170347.2612403-1-arnd@kernel.org>
In-Reply-To: <20221215170347.2612403-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|MN2PR15MB2703:EE_
x-ms-office365-filtering-correlation-id: f1530348-a17d-4068-3dc1-08dadec6194a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88GdfSFycEC+kQwz2Boo6G/NOAOLYNAk2J/H6Ul/isDjQ/ezgahcXU9QTg8oO5izAL+O2A17nFU7x1Y5v2lA+Sr2nq/vvVUKZ6V2+wb2PkH9/gGlsx3WxNbhHu4BT56S0CCTlONWeFdBjuncv0CUqNBN80UM7NBcRr++f9FvvmHR/mQzWFtmJ5GYUGPdGXWwRKWBHhgUpLEydjsD8J7AuCAUUn0w3LxP2IW37YIZcQtpQ6iZD044c9SBBs9SdfOJyaWtSa0F6CWm2aJ+HlXYoqWLxdku5zMkBwFoQUv3Vr8IdEKuHX891AwUByM+h6Q8xmd5ElpQ9WdxrLmxYF2sr30G0vY2PbCd7BSPwYuVVA08xvmM1p5GL7j7arvrtu1WdG/Ft9HNLHezhMAouv6VnooFtnDDRp5Z90SwInD21Ak919unUrgJ9fbYqX/Q3DQJsqasYzDfcjKV3rFVSgVQDV5H7Z4glodhWCdcpeRTJsScdSdabrp1+cl+HeVkkomsLqa3NMGmnnUkupvYsF8plIxWKVMiHe6ppv45Y4s/77hQ5O8uESp9cRsU7OGDwvkGsZk3Tc0yvQR+QuhGka5926g/rpPU3U7hZAALV/tTJ5nRenFsuUFzZN0w0gHwA2SrISpvjwerVTGRVGaDGFk6b4WKPpebqHotNC0DZG189SX0GUFhZ/lmDALWSMEjCPP6lyWbmBv+32alEZfVjsKwkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(41300700001)(38100700002)(122000001)(110136005)(5660300002)(66946007)(76116006)(66556008)(66476007)(33656002)(4326008)(64756008)(66446008)(86362001)(8676002)(8936002)(52536014)(55016003)(316002)(38070700005)(54906003)(83380400001)(2906002)(53546011)(9686003)(6506007)(71200400001)(7696005)(186003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V21tYlkrVWdHMUFsZElraUJoTXpLbmJlOHZRZjdoemJsajVhUHp0ZDJZaU1p?=
 =?utf-8?B?a1VPZDJ4cDAxNW5TK1lLSHZkVytVcWczaGRIUmpJZnVwcUpJc1JkMXNERGYy?=
 =?utf-8?B?alR4RmV5cElnL21QdnltT1lLZEY5OXE1ZDlhOU02Wll1Z2hRYXNPTkxWRHJZ?=
 =?utf-8?B?ejV5dDZXTDlUOHY5L3NrQm1zL1pHTGd4aWo5U3dBMTVJTCtRRVVsRE4xRXN0?=
 =?utf-8?B?TW5EUjU2dXJlbVJvVktWUFdOV3pLMzl5VVU0bXRoRFdITWpST1Z4YkRieVVD?=
 =?utf-8?B?M2dZT05GUFdyRURLZ2dmVDd3OUpmQU8rcWoreVhRTHcrLzdHbkxmTlVXZkQ4?=
 =?utf-8?B?NG15VjA3RkZjY3pEa21MdDZwV3gzSFd0TkQ2ODlDcU5MWUJTMEUyVVlleG9H?=
 =?utf-8?B?aXdzYWFnbTAxOTlyMFpJK1hZaEFTeEVPNzJ0TWc3enVlRXQxcE5uckY5eW9M?=
 =?utf-8?B?SkJSaWI0OHhYTHEvdGZNYzZQWTcxUnUyYXZrdXl1YjVhZWxIcXo2RitGMWFx?=
 =?utf-8?B?dG10UnNBWWlHVlZqenBSOS9oNm5ITThqV0x0ZjNKQW5WT29iSENrU3RrLzF2?=
 =?utf-8?B?MUZac1JCK1FEYzVsWkJmVkVXVWN2UnpENVRNMGVUZCtGbVhpN2dUaDA1RGkz?=
 =?utf-8?B?cnJraUFWNG40NDc2Nmk3WGJwaUlJOUNaYStlUGlJQk10MnpaeFZDbXhUMlhZ?=
 =?utf-8?B?REFLR0NaZmVnWjdKTmRrZFUwNjliNTlWUS9wNmtWeHhDL2VSZ2VGUm5XRHAr?=
 =?utf-8?B?dHhmQW15bENLZ0Znc25lbWJBK0J2emdpUXpBTFdENUovYkJIRlBEVkdGZU5w?=
 =?utf-8?B?RHo4c0ZwaW81WkJzVGxjK1V4NWs1dmlaTXBxV1hKK1B0T21TT3VCUGxUMnY0?=
 =?utf-8?B?MU9Ua0NVNjRWVUhkSTdKdkpuRDdlbWp1MityQ1hlT1hWV3BxeGdyWlBnWGlQ?=
 =?utf-8?B?NE41RXRmdk9SY2tkNzMzank5NjhlY0xuSjkxTnRNbVRlaWduc0hMa2VwY3pM?=
 =?utf-8?B?NjYwR3hKNmd4RWdMUGFOQWt1UWp4KzBSYUpxcVA3VjluZFBYa3FlS1Y1Rng5?=
 =?utf-8?B?K1RTdmlYVnpuemtteUdIMm1nbzF0VHVXOXlRam5kWXVSTU1jZi9XR1gxOUll?=
 =?utf-8?B?c1hOWVNsN3QycGtKUWJQZzF1Y2IwcS84UE1IYys2aGc3M1QrU01GRldNTUsz?=
 =?utf-8?B?cldLaG5Jb0hBMSs5YkZhNzJkTEZRczFnS1NvQTFPSENoM2pEb0NGaGQ5SDJN?=
 =?utf-8?B?bWFpbWNkamY5ZkpVWEY4TTRhWGFsYmh5SzdGeVg4Y253YzlCbnVTd1FTNWh5?=
 =?utf-8?B?WW9RTzdrWGVrY294V2VGM09JZ0E1blg1WHhKOWgxb2ZNNnlCYTNWOXpJREFW?=
 =?utf-8?B?dHFubnI2aVNNV280TExKaVhNTFZadGpVZmliWUgxbXpnb1JjSElVUHBIeExM?=
 =?utf-8?B?ZllTeWRXRmRsY2ZXSDRzNHpVU0lWWEFYa0VrYWVwUVRIaTdoRUlSaVUxSyt4?=
 =?utf-8?B?VnZoajJyODhKeHdOK08zS2hQRmpkcUFuaC84RGUwUTczZHVkbkxOYXdFTUlO?=
 =?utf-8?B?b2phSGpSS283VVVNalpPcHFvUzAvck8zK0NIQ2hYZ29UbG9zTk15N09mVWlC?=
 =?utf-8?B?S01CQWNXZzA3bnFrY0VXbGF3cXJsRUQxZmpZR3hxbDFJbnJLV05oMmtqQzhz?=
 =?utf-8?B?aEZNSWU0b3BOckh0c2NKYmw1NDFDanluc2tOMTFsSG9aK3l3ZnVINkRkWnBM?=
 =?utf-8?B?ZDhUa09hdjFNdG1sZUpkcFdoTHkyQi9jSU5YUm1xclJ1cTAwSHA5WjdrLzJU?=
 =?utf-8?B?azZMMGFkaXdXK3ZlaFpQUFIwWVVHbFZPaFBuOEdFT3Bac1hKekRqUWk0cXNm?=
 =?utf-8?B?elo0Z1VFU3lxYWRuT3RERWh0UFZ0SEVFeG1pYWpHWURFZTF6dHJuclAzMjE0?=
 =?utf-8?B?aEpYRTFDZzhtQnBsRldmcFFyYlErYlZKeEhIL0hhd05YQkVuVUNueUtGM1lJ?=
 =?utf-8?B?TzNVL2lsaXBRM0laR0pKSGYrNUdUcytxbjNFM09nNml6SmNhemtVamwwM0hq?=
 =?utf-8?B?NE5DYzZlSlh1b0tKVXFuK3VlYVMvVE9uQ3pXMkFydEVtcEViTFdxMm9TeVlT?=
 =?utf-8?B?V2ZCeER5RXdQQ2o1aTdGUXpkQzAwYVVWbHIra05HUmdvWXF4KzY4am5yRDlN?=
 =?utf-8?Q?NVg8EffBXCVhn2vOhqLW2ZcZJYyfjA8rx7KIxBc0qSOH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1530348-a17d-4068-3dc1-08dadec6194a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 17:59:23.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xUY/jZj0WAbEejftzEfSVBfvP9rIWtfqWcHxh3RhkiRi2/WQIJ3mXv6Acpm2doH7PN7saWgcpPw2K3cPrYELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2703
X-Proofpoint-ORIG-GUID: jIRPXZcC5_cFaz0KgDPSttAQRVyM_gnk
X-Proofpoint-GUID: jIRPXZcC5_cFaz0KgDPSttAQRVyM_gnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_10,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=772 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgMTUgRGVjZW1iZXIgMjAyMiAxODow
NA0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBKYXNvbiBHdW50
aG9ycGUgPGpnZ0B6aWVwZS5jYT47DQo+IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3Jn
PjsgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBDYzogQXJuZCBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRD
SF0gUkRNQS9zaXc6IGZpeCBwb2ludGVyIGNhc3Qgd2FybmluZw0KPiANCj4gRnJvbTogQXJuZCBC
ZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IFRoZSBwcmV2aW91cyBidWlsZCBmaXggbGVm
dCBhIHJlbWFpbmluZyBpc3N1ZSBpbiBjb25maWd1cmF0aW9ucw0KPiB3aXRoIDY0LWJpdCBkbWFf
YWRkcl90IG9uIDMyLWJpdCBhcmNoaXRlY3R1cmVzOg0KPiANCj4gZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfcXBfdHguYzogSW4gZnVuY3Rpb24gJ3Npd19nZXRfcGJscGFnZSc6DQo+IGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6MzI6Mzc6IGVycm9yOiBjYXN0IHRv
IHBvaW50ZXIgZnJvbQ0KPiBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2Vycm9yPWludC10
by1wb2ludGVyLWNhc3RdDQo+ICAgIDMyIHwgICAgICAgICAgICAgICAgIHJldHVybiB2aXJ0X3Rv
X3BhZ2UoKHZvaWQgKilwYWRkcik7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXg0KPiANCj4gVXNlIHRoZSBzYW1lIGRvdWJsZSBjYXN0IGhlcmUgdGhhdCB0
aGUgZHJpdmVyIHVzZXMgZWxzZXdoZXJlDQo+IHRvIGNvbnZlcnQgYmV0d2VlbiBkbWFfYWRkcl90
IGFuZCB2b2lkKi4NCj4gDQo+IEl0IHRvb2sgbWUgYSB3aGlsZSB0byBmaWd1cmUgb3V0IHdoeSB0
aGlzIGRyaXZlciBkb2VzIGl0DQo+IGxpa2UgdGhpcywgYXMgdGhlcmUgaXMgbm8gaGFyZHdhcmUg
YWNjZXNzIGFuZCBpdCBqdXN0IHN0b3Jlcw0KPiBrZXJuZWwgcG9pbnRlcnMgaW4gcGxhY2Ugb2Yg
ZGV2aWNlIGFkZHJlc3NlcyB3aGVuIGNvbW11bmljYXRpbmcNCj4gd2l0aCB0aGUgcmRtYSBjb3Jl
IGFuZCB3aXRoIHVzZXIgc3BhY2UuDQo+IA0KPiBGaXhlczogMGQxYjc1NmFjZjYwICgiUkRNQS9z
aXc6IFBhc3MgYSBwb2ludGVyIHRvIHZpcnRfdG9fcGFnZSgpIikNCj4gU2lnbmVkLW9mZi1ieTog
QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19xcF90eC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3
X3FwX3R4LmMNCj4gaW5kZXggN2Q0N2I1MjEwNzBiLi4wNTA1MmI0OTEwN2YgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBAQCAtMjksNyArMjksNyBAQCBzdGF0
aWMgc3RydWN0IHBhZ2UgKnNpd19nZXRfcGJscGFnZShzdHJ1Y3Qgc2l3X21lbSAqbWVtLA0KPiB1
NjQgYWRkciwgaW50ICppZHgpDQo+ICAJZG1hX2FkZHJfdCBwYWRkciA9IHNpd19wYmxfZ2V0X2J1
ZmZlcihwYmwsIG9mZnNldCwgTlVMTCwgaWR4KTsNCj4gDQo+ICAJaWYgKHBhZGRyKQ0KPiAtCQly
ZXR1cm4gdmlydF90b19wYWdlKCh2b2lkICopcGFkZHIpOw0KPiArCQlyZXR1cm4gdmlydF90b19w
YWdlKCh2b2lkICopKHVpbnRwdHJfdClwYWRkcik7DQo+IA0KPiAgCXJldHVybiBOVUxMOw0KPiAg
fQ0KDQpUaGFua3MgQXJuZCwgbWFrZXMgY29tcGxldGUgc2Vuc2UuDQoNCkFja2VkLWJ5OiBCZXJu
YXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==
