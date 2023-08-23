Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6979785121
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHWHHh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjHWHHg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 03:07:36 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92093128;
        Wed, 23 Aug 2023 00:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692774453; x=1724310453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DzQAX07p9E2BJqqzF8A6K6KDMmkQa38qOzo1p4yYgU0=;
  b=ecwabKjK1ngv/KVFxrSfZaqgdZfVU8G2o1Ts2b0wt+mA7WDXJ+Idgdw1
   +/PRJCw/K9LwZSTBBsDrL9UaTlb3OwWZLqI+1qVcY0VQPTiEeOQEaWX7y
   iY1LJTVCvdfIhAPQFtNyuFQAw5/SneqdigKf16OHBfLXiAADmSKxSGBCv
   zeXVf74AaorKKjmgZRIIY9GnL2vifnH279rbg0oeEStzn6was64NMwKbk
   Voe4NOKs9vkVF0G3vCMuQIhHO/jkbZWlAgA0Vp26LrQyvDADQf26q/9gy
   nL1ZNk9rOb5esRiuX71GChYZmx21fWEFp1IcWYNj/Kye5BZUqmKzLc5Ja
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="5957103"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="5957103"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:07:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/946cC05WJ3zZu1Il9A9VCcN7ZnvTJEjAd/tDvq6nj6H08hydE3FkPnvEUX/uN5FkxAGu1LbBclQDRK/ZxSONaNsNcFNWpZRiF0KRN5Wj2gttSOuyJo22uVvQJEWdMy6zYmLCdcuuVofXbeLl/xIUI0CRBEAL2OZeGSWPw0NSGSX6UIhvcKedP4XYMFZSynYPB1G29Bg45FKrnz3iQdRg3Z80DeVLaCS8lEPmumPUWZPO4sH4KB1CJFwbYEU67wamPPCtdTx8Rj4kpevz8RYFHMAHnemjhhr/eQJR/eo+7d4dJK/9a2czKSPxzRuLx3XHkyJw2OCt9OFapLwkNPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzQAX07p9E2BJqqzF8A6K6KDMmkQa38qOzo1p4yYgU0=;
 b=mqeYJ+GyFu7uOzqgGr8mZ6nK77gnsFOF/+AWJeo0rOcGgCcXCuJ8gqA2gDBEmz+yRDEsaavMrjREVMfOv745DAWnddki6AXcr2niMzln8Utk/y6czZ5EZi2FkcKJXSlfzt/5BBmfaQYWhk9/bvo8ABkhpJMcJ5igC43QkdWJYJFo25RzVDvzkgH7h0KjjKGwJq2MA+5yNP6RXAMWnMSuc9ay6AvZl1mgtmb0rYfRY7i1Pp3ef5yVMLtNMgKRpDJ7twzfPl4v4b80a256SGzGooijzgj9YaWB8JIGGEwkCedqO+ElvcpAIMHZxUdeQONHroW0PECK3mbVpoCDrwNIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by OSRPR01MB11857.jpnprd01.prod.outlook.com (2603:1096:604:22e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:07:27 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:07:27 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Topic: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Index: AQHZ1Yi6o4zSFSaxzUue6oXlknvmN6/3cgXQ
Date:   Wed, 23 Aug 2023 07:07:26 +0000
Message-ID: <OS7PR01MB11804F618EF235291066AE96EE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
In-Reply-To: <20230823061141.258864-1-lizhijian@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZmQ3M2YwYTItMTM3Ni00ZDc1LWE2OWEtNzcyYzFjZDNm?=
 =?utf-8?B?Y2EzO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0yM1QwNjo1MzozOFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|OSRPR01MB11857:EE_
x-ms-office365-filtering-correlation-id: 0fc4f738-8129-4faa-a9dd-08dba3a79bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrohID5hf08dS8tdf3uzj2PC52kqAIujTnSkVDyTMRqpFi76A045xBEkoYVdtceSA2GoBsEtRILFIbu5FhjN+Sh5hj2Hgpe0nPucCBpRdE3d+OLDLU/NQBhn+/Y6qFr8girSXC5isfdgTmks157SEtCT8hja2Dy7pxzzzumW5pNQM/C6e/3NtTiK+C8cMBrJUGQRMDFJIZFzZkhcsQS5ro79AJhA/yrOhKg+e7CuE5xIYsS/ev9fuGv+HPkP0RVLf9QDyXSMHtj6QmCfvtHOki5VnEbCZY4Xf9gAlzTPt+0pzlSSu1Ng3TzxXQlOy5L9bDMNLCgKCKrOCSBR5yFhYgBGvYBAroUldapl5L8yQEIjy7dX20z73C5iojwL2bB0ac77KGyA7Qfm57PetyewUANxdzXsfvonUM8SW23mUlzCHvb6zP6pZ+8q6XJfOnSATyeyDFHyEBQ1PV/2skk2eKFHZK2pYk3wKh6DgFc2gA/+hl5uLlQWlQFdoCfDAWltvAKs4G2uCbj+fnn6DRdd2884z0Ak3E8RBJjhQaljK33rimhJmg4M0PxbZuOma+Y04l8ZjvZ1+k4BAoQQ9EFQN0IR8enjr3Zn+WOaU39njpIJFx+5kJf6/w6G+Ci4l25eXI29IePKphYpG6zzQzbSkNCkiBO62MqaJTPogYPQNp4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199024)(1590799021)(1800799009)(186009)(478600001)(33656002)(85182001)(86362001)(45080400002)(66446008)(66556008)(6506007)(66476007)(7696005)(316002)(71200400001)(64756008)(76116006)(110136005)(54906003)(53546011)(66946007)(41300700001)(9686003)(82960400001)(38100700002)(8676002)(38070700005)(4326008)(8936002)(52536014)(122000001)(5660300002)(107886003)(26005)(83380400001)(15650500001)(55016003)(2906002)(1580799018)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REY3NzhoNkwzd0J2QXhtZWJJN1AyWkdibzV4ZmpYUVdjUmpXc0VsSW92eWt1?=
 =?utf-8?B?Ry9WSnA0ZzhLUEJxcFN6QVl1TnhJczYyZEZubzVmS1EwaHpJQkFtaXJoWUx6?=
 =?utf-8?B?Wk5YeloxamJwWlU4Q3YyUG92cUNSYXpXZzJPUkFZNWFtTnJ1MC9JQWFjRFBE?=
 =?utf-8?B?L0V3RFJjT0JhVjlSMEkxcjB1WWx6QnByUmFZeTRHV2s2Z2daenJOdTFiNTZK?=
 =?utf-8?B?bC9iYW9yMlhuZER2ZWdxRkQwbkpseXEyeDV4NXZUMVFtVERwU1cyUWJLNWNo?=
 =?utf-8?B?dngrbUNEbFQyVFBOenIydGFCYnFBcWNFSWg1Tm5tNGZ6dzhiRTFpeE10YjVu?=
 =?utf-8?B?T3ljSmZVN1h4aHI3TEZnZFVrS2pOajg4LzlVODN2MzdDTWhGNTB1d3dkMFF0?=
 =?utf-8?B?NjdkTEFWNS95SHQ2ZHI3T1p4WXVRdnA0YlQrOEdveTRZTkc5b3d3STQxeWsv?=
 =?utf-8?B?bmZBY2QrcWI1M2pFaURGdjlmRnQ0YUdpTU42eGROM1U0ZzcrSHBEUnlINDRP?=
 =?utf-8?B?TzhrSXV2V0ZMbUlPUVRLTkNzVkxiTjIwSExWWC8rWUpoM1FxZWxnekVwdGs1?=
 =?utf-8?B?SUYrL3dQcDRqaFpBUzgwQW16OUpQbHFIL2lPU3dhcjVjYlE3NmxzUGdJKzBa?=
 =?utf-8?B?SUNlNkhwdEhYNlpURHNOWC9FVlE3c3ZTb1lNMlltSUZqWlpONEZWdnhGUUUx?=
 =?utf-8?B?SDhYZGtwWWVGUXFYdzN1czFCRkRsQkovYTFteE14M2Z5OXhYZkZHcHZDTFZO?=
 =?utf-8?B?cFRuYXA4VVRESytCR1JRUEcwU3ZBdndkekpVZjdQTk9vYk9TalY3amdNekZ6?=
 =?utf-8?B?bnBDZ2MvQ2pyV2xCT2RTMHlBZTlNQW41NldiamFFampJS2Nsdm5oZW0yVTZJ?=
 =?utf-8?B?OWdDbENsbjA1S0ZjK3FqWC85SGc4ZVN3dGc0eTh2a3N3eWhLdFdtbSt4dWFM?=
 =?utf-8?B?cUZ4ZS9QbXVYa2ZrYlNnYmNKRFNLakdqV0FxSk9PdWFSMW42YWlwM2o0dkFC?=
 =?utf-8?B?U3I3TXcvU3Fsc1V1a1JXSkJjMmZqQkdjZi9JS0MvYmhKUDd2UkNjY2FkTzEy?=
 =?utf-8?B?VW9keFQrZTVaOStYRm45dkJYVTNZRGFwOWdtNW5HblJpMlRuQUNUcTRERnB2?=
 =?utf-8?B?RWU5bnlDY1hlVFVDdXpIeDZKVHJJc3hweXcyZytLWFh6YVMvaE41eklBenVz?=
 =?utf-8?B?VFBXTXlDZXZzb3phaDdzbCtJMUgrZmRXNXhHUG1nYUh1a2wzSHlEU0hjelVB?=
 =?utf-8?B?MEpCdTgxREtKL2xRcVlSSlQvZzRxaS96U2hhUTBzaVJMbFFMSXBMaStkcXhL?=
 =?utf-8?B?SGpkaElkQ09iNVd1bzJJS1c1dFkzWHh6a3dCLzB4TEZuNE1PMkxMYm4zN1p5?=
 =?utf-8?B?QStqdDNYUC9FemtEdEF6bjN1K25MYll2d0p2dlJjSmF0RDJPKytDaXN3Skdx?=
 =?utf-8?B?QUUzTGJ2bExKc3drZWRicnZCYU9jSXlUTXlLWTExcC91Sk1XKy9LbmJ1em9R?=
 =?utf-8?B?OTlTT2RFeWtJNHVMRkQ5U3QwUG85Q1gyK3lDVTcxSkc1VDJnYkM3MlF4NGly?=
 =?utf-8?B?Q2JNMmVFMGNwRWF0Nms0Z04xc05qL0ExdDBGdmx3RlRPdnVDVGxIRXIyVnM5?=
 =?utf-8?B?UmNpR2hhNm9TS2Zvc05VSjREUldJbXBnK2xXc296QXdEakxlRVJyU0JQeTY3?=
 =?utf-8?B?bjBkT21aTTdHSWJmWHAxT2lxanYzakFtS1d2RlFYb21DOGNLSTcxbjQyRUdF?=
 =?utf-8?B?Rmc3SS94anJTa0JodkNRM2dERCs1V2pTVTBaTFIzeWJGRkFkRnYzcUcwWDdB?=
 =?utf-8?B?WkxOeHVEdytzZ281QW9EdjdxQnh3S0RxUjdyZ2pSTWZXeWQ2K0pjc2h2MDZF?=
 =?utf-8?B?QjVtUFRiRTZIVnBDSW1Ob214bm1CaC9vVTlCRFRWdmRuQ0VxZXRxaWFIRTMy?=
 =?utf-8?B?WGtobEt3VjZDK0dvWnJQNFVLMFFHOG1maHFGeU5MaTRkbFAxOTVXcXU1UEo5?=
 =?utf-8?B?a2NSSUo4L3JzazNKWEtXZ3VFbllPeEJ0SHRiWC9vK1JCcHJMeGdKMlRaeVpI?=
 =?utf-8?B?TGg0LytRTklUbjZkeldnc2xMenRLZGtrd0hsRG1hSUN5dGQ2Nkp0akVNWkVs?=
 =?utf-8?B?QjdQb0hRTWxmdHJEZEIxRG1aNjBvOWRQdEpkM2hTNHN3OEVTNWZIcUVzQ2RY?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B/6NtXpG+KENxBO+K+mU4mSuSOpseVvcZrcTQbJeMwSTZL1OSgI38YJnWzxTiWviaX+XyLxy+aWiXkaSZ6xxmph4bqHUOMy0dHP5YN2cDiLBVzESyHNxOfofcfBcN2ZrY1mddETy5cNUGKgNWaIKw7PAaFlWw5lV2ujepOW/UCORRzLLoR0Y/0L+pZ9Dr5jzO0j+W0aImzMxSZNEzxSOrZztuKbLYLPu1eNu13P6HmlOKMflsZElM95EVx5ayX9y77BQ6kjJXljKZYRg7UyjsEuiVZynqKnf35IsYEZPwDdYQSGiIBRPO8nttpeGHAgfdwiLL8TXTKymGx6J59Wtj/zKUIuVBy6xRmrn7s1Y3n/JI95mqFYL4YsrED0s3LYMGF+Q4yo01ibtzv2boMYuNIyC7ann6eWuHLByCAMah9TfWIdIlD+g0EOYBDq0IkePQD6Q5wmh+8AmCL4TjOZGahCKCjQOKwHVEESjupcuN5KHq8SjsevwQCT6/fvcwalI0Wu0Oo1bSqfsvVaSMsnXsjLYJ1JCspTdQPURhOAKlg2no01WdIcJYUE5UTAa1D4gLPvgtUkrZyEQQl7bspOpL7++WObFnAhTWEKYJAcAtbQ7nQpSydnNf7kyYdVmlYeRDnRrzxus+1ryjBUHWFNFpexprHzrTS+UqP8Xwh95gIXagpOjKgRS48iOdYjJbpRirLgwdxB49Rn1NUMBi4mO5Fnw1tJ9iVjKPDofuTFJVDjuqWhewfqqIfENyKtsPqiqI3otyvZXIZNXmos14frVz/mPDXKisr8EK64KJGpCtBGNr5kQfF9Mf2Qq3GJflIVsEBV1GYimt7/0udw+mY0SMnPeC2D013a2yycADeN/UX0=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc4f738-8129-4faa-a9dd-08dba3a79bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:07:26.9791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpOsM/KnrGeQ4wDSri/XUmnDpJn8j7m3++nd7ca3hxWBC40HpgPcPHhHlLiQbU7FQb3jNhwmF78HwKcGgkizyKpQPqbQJtxNfRGzsb7xCRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11857
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMgMzoxMiBQTSBMaSBaaGlqaWFuIHdyb3RlOg0KPiANCj4gUHJl
dmlvdXNseSByeGVfe2RiZyxpbmZvLGVycn0oKSBtYWNyb3MgYXJlIGFwcGVuZWQgYnVpbHQtaW4g
bmV3bGluZSwNCj4gc3V0IHNvbWUgdXNlcnMgd2lsbCBhZGQgcmVkdW5kZW50IG5ld2xpbmUgc29t
ZSB0aW1lcy4gU28gcmVtb3ZlIHRoZQ0KPiBidWlsdC1pbnQgbmV3bGluZSBmb3IgdGhpcyBtYWNy
b3MuDQoNCkl0IHNlZW1zIHRoZSBzZW50ZW5jZXMgYWJvdmUgY29udGFpbiA0IHR5cG9zLg0KUGVy
aGFwcywgeW91IGNhbiB1c2UgYSBzcGVsbCBjaGVja2VyLiAoTVMgT3V0bG9vayB3aWxsIGRvLikN
Cg0KPiANCj4gSW4gdGVybXMgb2YgcnhlX3tkYmcsaW5mbyxlcnJ9X3h4eCgpIG1hY3JvcywgYmVj
YXVzZSB0aGV5IGRvbid0IGhhdmUNCj4gYnVpbHQtaW4gbmV3bGluZSwgYXBwZW5kIG5ld2xpbmUg
d2hlbiB1c2luZyB0aGVtLg0KPiANCj4gQ0M6IERhaXN1a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlz
dWtlQGZ1aml0c3UuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+DQo+IC0tLQ0KDQpHcmVhdCENCkkgYW0gYWZyYWlkIHRoZXJlIGFyZSBzdGls
bCA0IG1hc3NhZ2VzIHRvIGZpeC4NCkNhbiB5b3UgY2hlY2sgcnhlX2luaXRfc3EoKSBhbmQgcnhl
X2luaXRfcnEoKSBpbiByeGVfcXAuYz8NCg0KRmVlbCBmcmVlIHRvIGFkZCBteSByZXZpZXdlZC1i
eSB0YWcgaW4gbmV4dCByZXZpc2lvbjoNClJldmlld2VkLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1h
dHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCg0KRGFpc3VrZQ0KDQo+ICBJIGhhdmUgdXNlIGJl
bG93IHNjcmlwdCB0byB2ZXJpZnkgaWYgYWxsIG9mIHRoZW0gYXJlIGNsZWFudXA6DQo+ICBnaXQg
Z3JlcCAtbiAtRSAicnhlX2luZm8uKlwifHJ4ZV9lcnIuKlwifHJ4ZV9kYmcuKlwiIiBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlLyB8IGdyZXAgLXYgJ1xcbicNCj4gLS0tDQo+ICBkcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZS5jICAgICAgIHwgICA2ICstDQo+ICBkcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZS5oICAgICAgIHwgICA2ICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9jb21wLmMgIHwgICA0ICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9jcS5jICAgIHwgICA0ICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5j
ICAgIHwgIDE2ICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tdy5jICAgIHwg
ICAyICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgIHwgIDEyICst
DQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMgIHwgICA0ICstDQo+ICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jIHwgMjE2ICsrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tDQo+ICA5IGZpbGVzIGNoYW5nZWQsIDEzNSBpbnNlcnRpb25zKCspLCAxMzUg
ZGVsZXRpb25zKC0pDQo=
