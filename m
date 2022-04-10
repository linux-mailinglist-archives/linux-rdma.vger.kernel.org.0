Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E394FADA7
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Apr 2022 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiDJLb6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiDJLb4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 07:31:56 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBCC3A185
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 04:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649590186; x=1681126186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+vOJNVBLYUglYLtp/WKSEnHZGlclUzpMkgbRzxgqmyw=;
  b=nDKEMHkRo89B6WJ/dfdrS2mUI37NY7jLcv0y2TqPJNXiscANKAOdosHd
   +c6OMQn/IZOCiVRUjlwU44OmbG+DaKsH1m0pARzb9zSub4bouKWzsQhny
   xDimEpDPaoOcayGcKJh4vov2oBo3SPT7ha+cniOIORSIAlVxBmH7WeSQP
   EciM+lR6f5jpslmx5OgHmM14swcV04nPR8lhFslke7GSSgH/CNy/Yn2sI
   ExSrAE/v4ecSYqnw/FnksYjYlE8d1IPxvkbXIQU8GS+9KkvZ1+W90JYYA
   IrPC+b2MVNAfzs2TUdAVrUVaGeeibZuypVon3y93+IwTPQJb4rpf0FF6Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="53275973"
X-IronPort-AV: E=Sophos;i="5.90,249,1643641200"; 
   d="scan'208";a="53275973"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 20:29:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXe/fYBgwSw7AV5rBetcE1gDqIfLjHADGouy2yOuUPCAiSUeUZ27DobUCaXtd8+zXOhaw9Ss8fTLYnhjHlz3QDRmyT6i+imYh7oM7ezv/8XXK6Xd8tMDTb8/jksEC9qFW5Uk5KJtsH5iy9i/2+lNTiYvmEELM6+qvZe19eoM9U+cQ1QOoBSm+Omizbeh5weeoANtaLKgXL+Ty+GONd2LF0CxZ9sqNApkv+dGY7tFdgb7CeVyTwZT3OTFw1ZVAN434WA/yFS/Bp/XbSIiJ1uhr/RFbQ9UNRaXe9mFDiRhaPN5pzzfZS7455JWIfMq1JlfrlR37728qwOSHZMao3PzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vOJNVBLYUglYLtp/WKSEnHZGlclUzpMkgbRzxgqmyw=;
 b=fqZ2Oqaopa+e0wBa+MIkU0GDpZolq0nK1T8saxwzY3j0rX0V4ubfdpXdTrANZRz6QvzyFbqwY7wsuZegi/fCUDcvet77eIY2D2nprrElvOdl+2yGlq6hs+JYEHYhb8HeqhBYmNU3Ysq98TBfDaS6iUait47hU7+MYwXA/4nKf/AlyJK+oiUozzpLcZDbD/2op5LHcfjZkfO9+0QwQk1PaPX9zHoHpl9ymKZNm3sEjNRGWbg16aMuM0KFR9lXI25HObe0rktUZc31rafl8D1rHuUsJHiulovzJLekH7oG1nMYv1GCmd3sblMvqJ9FDIJ9bNQA5K1XTuTkTWju4l75gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vOJNVBLYUglYLtp/WKSEnHZGlclUzpMkgbRzxgqmyw=;
 b=RIDo824h72oikcDI+sexppdowh0j1Sv5uC3COG8qhMHhwTU9V25DVk9wUdSdV6snBfZjD+meJ/6xhEYJKQr9nL5JtwbsCpgEkBgjROuzRYSD7ep+Ri0Q/WCAjvRdkajbA9w2DecJ2m2/6+euFss+CRRJEGsgJrvF3ycttJoccM8=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYBPR01MB5424.jpnprd01.prod.outlook.com (2603:1096:404:8029::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Sun, 10 Apr
 2022 11:29:38 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5%4]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 11:29:37 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Generate a completion for unsupported/invalid
 opcode
Thread-Topic: [PATCH] RDMA/rxe: Generate a completion for unsupported/invalid
 opcode
Thread-Index: AQHYSvkEK9+zwjKLYkWQCBNP3IakLKzmVlOAgAAS7ACAAp1RgA==
Date:   Sun, 10 Apr 2022 11:29:37 +0000
Message-ID: <947ce9a1-06ce-965b-d406-0eaaaed5691e@fujitsu.com>
References: <20220408033029.4789-1-yangx.jy@fujitsu.com>
 <20220408182617.GA3648486@nvidia.com>
 <5295c51f-91a3-c9a4-2811-03f13c71205e@gmail.com>
In-Reply-To: <5295c51f-91a3-c9a4-2811-03f13c71205e@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56f6eabc-cc53-451d-398f-08da1ae56558
x-ms-traffictypediagnostic: TYBPR01MB5424:EE_
x-microsoft-antispam-prvs: <TYBPR01MB54246026EA1D1AB1C045B11B83EB9@TYBPR01MB5424.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qf2cSdRhDABxIPOaZFrgsDvFdXxnxrEziP38GTBReUFmDVk4q536FBi8xnkkZz2LF1vYY1p9BMLJeB5rFhlUZzH7VDXja6mv9aT3uiBcSlxGdsn5RVAZuQzTOFvONs4G5M84mZ5gt+ELrc1sBtrxR72Za+10YrGS9GPoZsffmSckVZxgqNkYURQwg9MO62AcU4AWlNc/qQtFl1UbV6/7QweJ1gYGpQcBEYrOFxKDUshDSs1qCPhJ2YIfkQ5sZYoTnsaryHe22azF8+UdteAggZMOhFRdY6sCrYCLN5bEQOZk099BxpTK59BpS5MC1DF2LqAJDGfH3JzU7YdXFhNc72BdNsyRwUSP2iLLChVUY3jknptEF9dfOIYioEiM4rfMw29ZiIVk1AFDKiFAuZPe3AmNraqPoVPHKiSz6pn9HyLbDB+I68ukWFaNnhp9lvKFYuWo7C0fNMeIG691EfHZJ1vh447sCJJKb+dj39lnR+TZURLdG2bRn7z4WkQTwcoYlp62O4DJIT40BaikbralQd/GOSX+55xhdfeTz4NOVPUGkL0VBLb8LGXpZkoPkQ4////3BJhaXPP8pmOoN9ECMtKZAQpUn/aa2NEmi1+7RJ+bsopKnDn4Sef32Varq9uo84zFWpHrDBlpwu1xDXkLKR+asYsUqIQo4io44aUUAEjlJRFHpKieSctY3PNFOosdIsFSqQsPHt/usxT/6Ht1eAZMPDoNgmffYDAlEfIUhdqpl7JDNGhPsUGJssceLy6a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(186003)(76116006)(66946007)(4326008)(38100700002)(31686004)(83380400001)(64756008)(66446008)(66556008)(5660300002)(6486002)(66476007)(91956017)(122000001)(82960400001)(36756003)(85182001)(8936002)(4744005)(38070700005)(31696002)(6506007)(110136005)(54906003)(2906002)(86362001)(316002)(53546011)(508600001)(6512007)(2616005)(71200400001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUxFM2tSRm9yaXMySVR6Z3phM1lXeFJzRzRxVFF4dWF5WS9HQWU2eDNGYUlm?=
 =?utf-8?B?dkd4RmpodEZiemsydVJLZDZCaDhOM3ovZ3AwZ3F6SkNwVDNWSEVBSm50Qlho?=
 =?utf-8?B?alJ4WmQ0OFNjdS9IQ0VQdlFiTFg0WmhjRnFOcmU3WGNJakNCQWpUOXo0dHZr?=
 =?utf-8?B?Rkc2QyszbjlYZ2hwdllCWE5tSjVWRUREcE5Xd2ErMEV5ZjM2U2w4NWMxZ1pI?=
 =?utf-8?B?ZFpiYVB4VEh1RTQxNThjTkYyZ2ZRQzNDTlFDcnFXZWdJRmtyTkFhM0pWWXBi?=
 =?utf-8?B?YTZIOWlhRHZVeFBZa1NkdlBlOXBwWWZ1aGdUSG1jVWpBWGZnMjdoeUl5eXR0?=
 =?utf-8?B?WUlieEVycndzaGltZ3NaejlaWGJlK0pFQ0VhNFV2TkxiVytMWnVEaG5Ba280?=
 =?utf-8?B?Q3Q4WEFsNjJMZVZLbVJWRVlzYlNmZkZYZ25pV0tVemdEdHg1RGc0RDJnSThv?=
 =?utf-8?B?Z0pxcGZycWd2eVJhUjVoOGpUcWlZK2o0MHZ5L0thbWQ4VkRmUlMwY2VFUzVS?=
 =?utf-8?B?MWkweStXT2F5ZEY3UXZnamZ3MHlXRDlBUXJvM2Rwc3lVTVVycHN3SXI0TTVX?=
 =?utf-8?B?aGd3RTR6a2FyU2J0YW9zaEZ1QnJJMkp1SmlIRU5nWm5oK0RFUS9ERW05MDJh?=
 =?utf-8?B?VE53WEQvNFFNQ2szNTlEcUJnbHVPdnIxQ1I1eHNuRFg1TUZJdWpqMXNrTGJQ?=
 =?utf-8?B?SFNrYkE3b1p3L0crWmh0TXVJc3RBMlFpc09LL1dkWGs3KzBnSE1LM3NoSlVs?=
 =?utf-8?B?VEJZcmNGNUM3NjRZRFMwTTZ2L2ZnRU1MZG5lOXgwaUt4MktkTUl4ZXBMbVNx?=
 =?utf-8?B?aWNFSUcyVWxYdUk4WUowYTc3N3d0WDFnd1RETTZadmNJNER2OUhTNmZWZXpL?=
 =?utf-8?B?Tm5aVGsrWFBLK3FjaFY3elhDQVdUZG9xL0xOVzVOU2NXdTdYZUxZY0lVbEZO?=
 =?utf-8?B?V29YVUVhVjlOM2RicTlUS1FPcVdsQzNxNW13Sm9yVjRmUjFHN2ZwZk14WStJ?=
 =?utf-8?B?aFdQQXNONjAxVlo5a2taMGF1MGdjbzZ2OHF0SHFKZ1pSRU1UUk5KRDRtSjVl?=
 =?utf-8?B?TzBOa1lhZFNyU1hNUTFwNE5DZ1hzQ0xsOGhESzNTSUFFYXM3NzZ6RzJEV0Jj?=
 =?utf-8?B?WEZjUWRyMjkwNERIWmZXN3QvQ3dYZkEzOTZyQVcwN3ZWNEMwSXZ0UkpQQjJR?=
 =?utf-8?B?dERzSStTM3RUSExEYVpnTHJBR1k0UXoybkpoQnlwZ2lPekxnS0I0dmZ6RXRv?=
 =?utf-8?B?WGxVTjZQR1R6OFNFWnJkNTRPUjJFUCsxL3ZoWUhlVzRVQnA3SllaUWFkUFJ5?=
 =?utf-8?B?N1B1RkpBVk9BUm5JbmJIWG1IUnNtMTQ3NG1jd1BrL2VRcGZhSFYxZG01anlE?=
 =?utf-8?B?Yk5pNjlYeXpBaElUaUV4d1lSRGw3Ym5rcHdNMGx1UUx6bGNTNFNJR1dXeklF?=
 =?utf-8?B?K05FdTBYcU9xUnc1TlRrY0o5OThFZ2cvaTVvUHJzUkNMMzJBRlZlUkNKU29U?=
 =?utf-8?B?bzdpL2ZpK3RXRGZWd2NDU1BFY2NqL3M5TzAxQ1Z2eVNTQW9OK0IvUTlvTmJM?=
 =?utf-8?B?SDRab0lmb2Rsbnd3WW8yWEQ2d25yOFdJTElPMDljM2hSSyt5MlZVOXNkKytT?=
 =?utf-8?B?VzN4SDNQRklsQkUvMkNxYXdEVXFvNkZBZXZVbWlBdkhRUXVuUW5ObTZyd1cv?=
 =?utf-8?B?b0hxMGVkRjdicXgrbUsvMWNSOU1hYWFybE9NSmJrb2lpVVlKN2VYZjJuQXhC?=
 =?utf-8?B?L1FQcjRPMHZlcUp1VE5kQi9oamRuUTRMK1VneDlFN3FINzFQU0FwNWd0eUI0?=
 =?utf-8?B?QmJCSVJVNVkxcExWSnNYNEdwMkFtMzFDZnNGNER1SjJkZFhpenZtWXh1NHFR?=
 =?utf-8?B?cFNteFZFenlDNlNHQkE2UWdDQk5FSkh4VlYrZXZ6WVFmbHJFRTYya3VsUnl3?=
 =?utf-8?B?NWVOalZyNWNmL1dkMU9veTF1RUcrdzVxWmxPTStldGRoSngxekRmMkpQU1Ju?=
 =?utf-8?B?MUFqR3FLZC9SSzhQOGVNS0VzcTdZWVhNcmlTdE1CTWdvUWdFOVgvMmJEM2hh?=
 =?utf-8?B?OXZhR01Ldmw0R3psaEE0VzZaT0ZMcTdZQWRFU2ZpcUl5bC94ZW1SVDZ1V0JR?=
 =?utf-8?B?RDh2VkM3WU1ZWTR4Wm5vOFlOdGRTZlcxVVlmYTAvQTc2YXBJeHVnNEN0cmZC?=
 =?utf-8?B?Y3NISHB2RGprZUorTUdWQ05ER0lCRkF4enVlSDNOTVpmcE9xSHNxbFIxdTgv?=
 =?utf-8?B?cm1WMG8xNEg4QURHTC8vRi9USkk1MnMwMWtmcXVueHFQUzdKc2tiVk4vUGNj?=
 =?utf-8?B?d3JVSExoTUtpdzJUOVBqOUVDUjdLMmNyUWljMVhabVIrblFaSmRYejcrUkd1?=
 =?utf-8?Q?DRve+pFa5UnN41TM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8946141E467F7644A89A90F4542ACF0A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f6eabc-cc53-451d-398f-08da1ae56558
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2022 11:29:37.3491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGBOE/RzNfjnsHnfjbfaQceieOYTRG1+1q2T1ukTisjMfikxO3wtjSWF4qsqaRQG0VajMjVAN0u35nqqjHxDfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5424
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi80LzkgMzozNCwgQm9iIFBlYXJzb24gd3JvdGU6DQo+IE9uIDQvOC8yMiAxMzoyNiwg
SmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4gT24gRnJpLCBBcHIgMDgsIDIwMjIgYXQgMTE6MzA6
MjlBTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPj4+IEN1cnJlbnQgcnhlX3JlcXVlc3Rlcigp
IGRvZXNuJ3QgZ2VuZXJhdGUgYSBjb21wbGV0aW9uIHdoZW4gcHJvY2Vzc2luZyBhbg0KPj4+IHVu
c3VwcG9ydGVkL2ludmFsaWQgb3Bjb2RlLiBJZiByeGUgZHJpdmVyIGRvZXNuJ3Qgc3VwcG9ydCBh
IG5ldyBvcGNvZGUNCj4+PiAoZS5nLiBSRE1BIEF0b21pYyBXcml0ZSkgYW5kIFJETUEgbGlicmFy
eSBzdXBwb3J0cyBpdCwgYW4gYXBwbGljYXRpb24NCj4+PiB1c2luZyB0aGUgbmV3IG9wY29kZSBj
YW4gcmVwcm9kdWNlIHRoaXMgaXNzdWUuIEZpeCB0aGUgaXNzdWUgYnkgY2FsbGluZw0KPj4+ICJn
b3RvIGVycjsiLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBm
dWppdHN1LmNvbT4NCj4+PiAtLS0NCj4+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3JlcS5jIHwgMiArLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+Pg0KPj4gRml4ZXMgbGluZT8NCj4+DQo+PiBKYXNvbg0KPiANCj4gVGhhdCB3
b3VsZCBiZQ0KPiANCj4gRml4ZXM6IDg3MDBlM2U3YzQ4NSAoIlNvZnQgUm9DRSAoUlhFKSAtIFRo
ZSBzb2Z0d2FyZSBSb0NFIGRyaXZlciIpDQo+IA0KDQpSaWdodCwgSSB3aWxsIHNlbmQgdjIgcGF0
Y2ggd2l0aCB0aGUgRml4ZXMgbGluZS4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IA0K
PiBCZWVuIHRoZXJlIGZvcmV2ZXIu
