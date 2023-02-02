Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29E6876E1
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 08:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjBBH76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 02:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBH75 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 02:59:57 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81148A4B;
        Wed,  1 Feb 2023 23:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675324796; x=1706860796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wZZtQYOdBkQYUyXd/Rn9lOobi+tgvJBHGRJH8KeQrv8=;
  b=qNH6nfAyPTKc5V3Fv+wi98qoimU/KkTXDe76480aHIrZ97m44cpoN9BT
   LOHG9ndgbl7m8oLu0pruLHUMcQRZYsu1w8uO3lr4oSncaFOYrjJvjkgaX
   xd+9brfJyPgC75exxo8nQcCXE2FEkuKnMK6hZZTHwLV5VbFWZzVbDiCmk
   hN6CJaKg0WJVnHKVZW3TRdkQsSxqpmHHrlMKaGij+rUWxIeA4i46DMeUg
   uLEpJQmfcEjiSWYuyykUDzkQBaKvOr9u0mLFpmgmtgw4Lx1Vp99M1t46Q
   d2R5f/DxhgeZOc++HSqMbThJtzp9z0RbNxS2DvPkn9LojYUaXKokNb6Ze
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="75899428"
X-IronPort-AV: E=Sophos;i="5.97,266,1669042800"; 
   d="scan'208";a="75899428"
Received: from mail-sgaapc01lp2109.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) ([104.47.26.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 16:59:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ+vuYfrIt5+CcKExnXM5BI2WR134AJnaZyfI3piBz/44520YrVDaWcCReQSJO7e41vKWjG2GL+2eQBZgv3bQl10CGP8tU53d5WWOzIstRonj6UdMQe3vcJB0UbLY8/cItQqoCtCvB39gyMRJuHAQP+zWtAd2Mn8UTCVpOEujVwnnHFenNW0roYVev3lnYP+VubqmqFb0I8+ysQTArCs8pjK+CrfbmuG+jHBm9XQGNofDpYOdBiBLYd4zDGfQ9LcOJiMfY6rZMcENrmGFeFoSxwMml3DzjR2o4kEkpakWeA7PRCyMlVpKYtz1zz0JFqmt92NFhKX0qhtzf0UEjDlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZZtQYOdBkQYUyXd/Rn9lOobi+tgvJBHGRJH8KeQrv8=;
 b=KdBso0IfqUmHFkBlIRQRW7CdfO+is5lRo9T2iImaBouE5Rsu5Uv1424WPhXJhe4hIOEzsVHLOk28I/YpqN0S/y2QmzpsZwEVWLR2o4T8EOkvrVURwUYUqMMK7jmkf8dE7ua65vd2nJoNLwbG4TIDFn114dApsHiYi2Vk63yNzd78q5L3+n6ZK8iyOJHK20e0S4feErnWX16/fnPZiWX2jm1llMJGJqyTWl1+Osv1zftS1S3HgKGi9vyFDxh82wWr0eBmImostthvgkjI29xhf14EqGmB2H7PYfn5nHX70+91f9OjKVCQWzm+kMh5VS5VQ9FFPlUrobBESLQCxAHqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OSRPR01MB11809.jpnprd01.prod.outlook.com
 (2603:1096:604:22d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:59:49 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 07:59:49 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Thread-Topic: [PATCH RFC] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Thread-Index: AQHZNknSEl1MkKz1D0mzVosbk4JcKK664lGAgAAh9QCAAAd2AIAANtsAgAAJeIA=
Date:   Thu, 2 Feb 2023 07:59:48 +0000
Message-ID: <42e231f5-63bb-e145-ce80-d9651a9afee1@fujitsu.com>
References: <1675261833-2-1-git-send-email-lizhijian@fujitsu.com>
 <6bcba397-f4f1-26df-f8cd-1dbebf111932@linux.dev>
 <d1751eec-3d48-a8c9-1e3b-3263a4a043a3@fujitsu.com>
 <b82cfec2-b679-7c5a-06fe-a540fddda0f3@linux.dev>
 <fe563b74-efff-2799-ceff-af7af7bf9171@fujitsu.com>
In-Reply-To: <fe563b74-efff-2799-ceff-af7af7bf9171@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OSRPR01MB11809:EE_
x-ms-office365-filtering-correlation-id: 6ef6f08d-f9dd-4a1f-3a99-08db04f3750c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7LqeWathRDVL+vZiGC42pGSzO1fNIsetAO1c2T4jJjqZ7MF1nA36nD9aOHZfl5zYzbN3kwfqADs/3jnhHyIBkI7QOwF4qrT8QpFGscI4KERUV45/CI1PyolTmGMbZc81r6567MLXr5ALNgFE1RlXI8GT8SurFqRVRmbENt4z6QILeZTaHhUybKuLmIXZZlfuhshrBE8ZI/uLiurFUfMJ1inF2WdpeVdbxoyyaI0N4gkrRpHBjWD60XJg2AkjQbW7zvx2RRqmPk+vmxxscTJdYbHSg3xxfuLN6FR2zqWXG+/dBaM/fafLQDYqQoiIUfAzELx6XquMcIfnEhINWMzrA55JKggHafdyWVNG7LsDKH3ExqoCTv0HnII3LE6YRMrHsn2fVKuec8ErJR7+dTjjkKNidJBRWXGtC8TGKqkTX2HGXXLviUd5w1Ff5LB2iYTJiZd5Q2xZMWTt8s5SbeK03wjxwA60wB3EuPQV6aOPrjgbZ5rNWCrjuV1g7dmmYJeucLWMXI6cexiPEiEZeNuqAyB/CqinajBGyAQjusfmz5tOAIS4JJlFGhSXzKTI+hrE3dX0xHBrMOP+dj+okdMZcbrEPoSKzohVZ5tfr4VRGBz0+IdXcPW3FA/POa1LURx//CTNYLL1D3M+76ap1mS0y+4NZmLYiApB9/brnkpex7YbajIqjHyTOuSUUEvrxZT+K5hx/Q5SVPASXX65Q9NSsAL/z/QKk+RU/nhLJBxu+tIk7YnbITtIKBPbtrKKEFXJ5U+ZRTobqSzNSPe3EPUUjgQERFWtJN4c/lForcLiZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199018)(1590799015)(5660300002)(8936002)(1580799012)(4326008)(8676002)(64756008)(91956017)(66946007)(76116006)(83380400001)(66556008)(66476007)(66446008)(316002)(110136005)(54906003)(41300700001)(38070700005)(53546011)(86362001)(186003)(26005)(6512007)(31686004)(31696002)(6506007)(2906002)(71200400001)(36756003)(85182001)(38100700002)(6486002)(82960400001)(478600001)(2616005)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVkzYXN5dVRNWmhQL1VsMFRyY2QvSlhRcHNaNUgzL0RZUjRPVXNySlBaNjY4?=
 =?utf-8?B?TnIyNm52cytLdnF5ejhTejJ6ZXVPZWt4NlU0SWFlT3ZWbm1UK05RUU82S1VN?=
 =?utf-8?B?a3REWUl0dzFHSW9pQmN5dzB1UlhJcVZjazNjdFF3dlhUNkFzYjNFKzNQVk5G?=
 =?utf-8?B?UjFvcUV0VGhNS0xMdzBmOXUrbnVFQ1p6bGNXQUp6ZmVLR3dYWHE0ZWdGNk45?=
 =?utf-8?B?cGt6RmFmNFg2MzZibXVJN2w3ellDL3R1WFlCb1FvLytQVUt1Z3RBbVVMakMz?=
 =?utf-8?B?SERISkgvR2s0eHBuZGdCNGRnb1plRi9GR2EzR1dFWENxWHE0QTFxQmRUV2xl?=
 =?utf-8?B?T2RPWmsrQ2JQSHZraVZBV0tUMmpacElQUGtuZ0Q1ZVB6eDBtZmxTWVRYOE5W?=
 =?utf-8?B?Z2pYM05jVFJjVEd2YWozajBVR0FScXNGNEptbTVyTVJEOElGUklpUWI0RU0y?=
 =?utf-8?B?S0x0UjcrNFU0d0JxaUlad3FGa0MvYU9wRSthYzJYSWpRSXpCQnJpS0RDNEJr?=
 =?utf-8?B?alRlcmxXTnQxdkxNN21yUnVlQ2kyZE9BV3dmZ1oyRFZhVkxkcmhOM0R5QkhO?=
 =?utf-8?B?L1J6U2hzZWtoYXdiNW84SlJuZEl0T3BaUys4MnJOS3k4OEZhcy8rbDRBN2sx?=
 =?utf-8?B?TnorKzY1VnNsVXA3bFg3MG95MVpCTjFUaG84OTljTHVYK2ZPall3d1R3UHRm?=
 =?utf-8?B?dmRGcmlWcjJ3eDVSYlkyNDNxQjVLc0ZnSjhjTzduVCtDdTdyWTd0ZHB6c1VV?=
 =?utf-8?B?cGNRVmJNK1J5K00wSGduZ29rUFVRbWlkL0lPdXBCb3I2T3djVk5XVkYzY2Rl?=
 =?utf-8?B?QWZKK2RzdXgxNHpuclJ6RUlEeDQrQUMzdno3SlFwcVUvU2orQjdQNE1iZWdy?=
 =?utf-8?B?dkk4VUt0dUtadURadVl2RkIzZzluU2ZPcXVPY3ptcUpqVEl3OEJvNms5V1Ux?=
 =?utf-8?B?SjVYeFpYT25hNS82ZEhoYVVQNk5YSG5YL2E5dTIyQ1JwUnB3VkIxQ0RrUkpl?=
 =?utf-8?B?Y3N5d01jcFRBWFYxVHZ0OGFOL1U5bFpJR1czSU1ZelludWJmTkpXSjNJY3Er?=
 =?utf-8?B?QUVmak9MaXU4L0MxYis1WTVaUnptK0wzeWZEMjlZVVJacVR2akJ5bFRPQUdT?=
 =?utf-8?B?SXF2ZEIyUFNjUll2WXBsZ0UzWUQreFJSd3Z4a0taT0JvZUlHYi9QWnpzVVRB?=
 =?utf-8?B?c2l0QU9tSU5xaVJzZU9RVHd5eGtVbTI0S25RNmdmbEVoeDRPWExRRTR3V0NR?=
 =?utf-8?B?eUN0MUE2RWZPdEtiSXN6TXR5dWx5NFcwUWR1bHM4S0NIRzJRK29nbnJwc1pP?=
 =?utf-8?B?VE1KU2lsUkJoeHVHUEQxbk5hYlgrRFQwQWVEQkxZMk1xUEtkYkgwdnJHY0Mv?=
 =?utf-8?B?WXJ0eS9vS0M1WXZiakNCY2ZoU0pQY2RvWjRTVkxxUE1nOFQ5dG1Ob1hHUlM1?=
 =?utf-8?B?bUZFSFc5QmNKY1VzaG1qVVBTYnFDVWt6eDFYWUhUMU1nbGxnNmg1cllQRWtr?=
 =?utf-8?B?VHpPZFNTemdrMUhkMVoyaVJudC9EU3JXQlNXdjEzRVlwb3JhTkUrTllmVG5j?=
 =?utf-8?B?Mm5SdFZ2bEN3UEduOFJkWWlmeVBMVTFhaWpDdzhEV3ZLU2JzYXZhWjdtTUNW?=
 =?utf-8?B?clo2WTY5bm9wUFFWT1lQUVZqWWlZL1A4WjgwMC9tZjR1WWZWZE04bVpwV2Rl?=
 =?utf-8?B?UTgvclJmcDd3WG8xZSsrVEYrMW1PTFhWeGdCSjFIL1A3ZVVqSEdvaGxXUWRD?=
 =?utf-8?B?bWZ3VGwvc2NMSkVFeDIwZmFYUnBKOS8rY2NleWFKM3phYjFHZmptZHFCSFJF?=
 =?utf-8?B?TEVRT1BhRkxzS1U0cGFsT1hvNW81RnRIUHRxYzBpQ1hEc3JsQmxVZVc4MHNE?=
 =?utf-8?B?SEJTbDEyTWJvcG8zM0R4MXJZQzJ0U0h2c2JudnZxYU5RdzE2NkJWTGszM3V3?=
 =?utf-8?B?SFQrSGMzS1U1ZHhDVWw1S2tVMnIzMzFieVp5eUo4L2s2UEJLOEFqdVo0OEFk?=
 =?utf-8?B?OUJLVlpTNnhYT2c2cmhCUHYwbVY3QWRpUFdPMkt2Rk9CLzdsYzlxaFdkK0pR?=
 =?utf-8?B?S1lnU2J3akROcWdFd3ZSUFMxV2hjL2MyZmtMUWtxQkpaQWJYeG9VTmNIWUdr?=
 =?utf-8?B?ZmgrUzZwWGxnSHhtVXowY3FkTktTNXFWTjNxbXQ0Z0E0UzNOZlg3OVVxaDlG?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CA848C2DE8A7E48A4FC8C2C5FAB6A22@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OpkeLiJziAjFps4936g5wKZp4O9ECMqIXgNtWZiqVtulfKfXHnvzp2vLGSC8yStiN00YQW/v/Eg9Z9Uv2lhmlM19CMRuUKk22wbJP3/4dWQg01KzlssVnrPRhgh3MV81jch4rCk0mrf4KTnhm1Lhgbwoj2aZuJaj30uFck5wV6AXWxGr6t8HYyg02BTIJYG6LIzoRqB5/F43N0DSpPoemh6cCK+G+aXTw3LxK4gNkvYfpxvCdoyoLnOloJTpLhoLz4paoFsgcfG6hd2d7V578epqhNe7muDtQ1ouApNnhENrnsndZz1tdpnen9cvaCqxewDlctSoTehHyvVDsX0OqKFC5Fy/MyYIbknjyYANbIV6FpzMo5rEUTMywm/mz9FmtqBbIJY6cYwU633LX52bh2M/EOuXjzpjtJuCl/4SoAmFJ7HuciR/Sdj0Hy+QNZAiajxiGOrq9yVpeQqXmxMFueZN/p+1NL8eWjcqULTd3QCscREKqQMNTZdGc0Z2SwJraKyPsAnVheBPXWKiAqUjYZ/lDrgLr28Azwu24cxSIErlgLaUygZcO4uyDMBajGdzVD2aakldrEKyif/rW20noRw9W3mijMvxH20g1oFR3+xBgjHgzWdyiTeMxoYBuTPbkD58+hlcW4PE0oCNuXGrH8/vfSGVTmY6wonrBxRZmPruWIuycQi2jGtOI9AzZ+bSQTyytQb7NsHRSbJ/6MCLI/IpzbjgvyLfM7g4/O2nhrbVLEAncOE26MOzKKpNUMmPh0ToDbcdyHy+cukgXZ7jQL7/MhPCwe74n4UYPx7sv/JA7WlThLLmPQWJTvoYcqlCQ86a484NhR6Np8O718ryBPb7ro/qL6i1w8aNpepNHd1RIawF8wNPUKNAJh3TMmwe
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef6f08d-f9dd-4a1f-3a99-08db04f3750c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 07:59:48.9575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oo727+HYf1RC7GuDqr3L6KA9kKu/DSSfdQYVDU2Nwm9NBkFzjq6O/H0pA2/dWpzq7mliLuZGz/d7Gl8SqCYGDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11809
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMjMgMTU6MjUsIGxpemhpamlhbkBmdWppdHN1LmNvbSB3cm90ZToNCj4g
DQo+IA0KPiBPbiAwMi8wMi8yMDIzIDEyOjA5LCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPj4+DQo+
Pg0KPj4gU3VwcG9zZcKgaXTCoGFsc2/CoGhhcHBlbmVkwqBkdXJpbmfCoHJ1bsKgeW91csKgc2Ny
aXB0LMKgScKgZ3Vlc3PCoGl0wqBtaWdodMKgYmXCoHNvbWUNCj4+IHJhY3nCoGNvbmRpdGlvbnMu
DQo+IFRoYXQncyB0cnVlDQo+IA0KPiANCj4+DQo+PiAkwqB3aGlsZcKgdHJ1ZTsNCj4+IGRvDQo+
PiAgIMKgwqDCoMKgwqDCoMKgwqBlY2hvwqAic2Vzc25hbWU9Zm9vwqBwYXRoPWlwOjxpcMKgYWRk
cmVzcz7CoGRldmljZV9wYXRoPS9kZXYvbnZtZTBuMSLCoD7CoC9zeXMvZGV2aWNlcy92aXJ0dWFs
L3JuYmQtY2xpZW50L2N0bC9tYXBfZGV2aWNlDQo+PiAgIMKgwqDCoMKgwqDCoMKgwqBlY2hvwqAi
bm9ybWFsIsKgPsKgL3N5cy9ibG9jay9ybmJkMC9ybmJkL3VubWFwX2RldmljZQ0KPj4gZG9uZQ0K
Pj4NCj4+DQo+PiBPcsKgZG9lc8KgaXTCoGRpc2FwcGVhcsKgYWZ0ZXLCoHJldmVydMKgNmFmNDYw
OWMxOGIzP8KgSWbCoHNvLMKgd2XCoGNhbsKgcmV2ZXJ0wqBpdA0KPj4gZmlyc3QuDQo+IA0KPiBX
ZWxsLCBldmVyeXRoaW5nIGdvZXMgd2VsbCBhZnRlciBpIHJldmVydGVkIDZhZjQ2MDljMThiMy4N
Cg0KNmFmNDYwOWMxOGIzIHNlZW1zIG1ha2Ugc2Vuc2VzLCBzbyBpIGRvbid0IHdhbnQgdG8gcmV2
ZXJ0IGl0IGVudGlyZWx5IGlmIHBvc3NpYmxlLg0KDQpJIGhhdmUgYSB1cGRhdGUgZm9yIHRoaXMg
cGF0aCBsaWtlIGJlbG93LCBpIGFtIG5vIGxvbmdlciBnZXQgcHJvYmxlbSB3aXRoIHRoaXMgbmV3
IHVwZGF0ZS4NCg0KaW5kZXggYzc2YmEyOWRhMWUyLi41YWRiYTBmNzU0YjYgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0cnMvcnRycy1zcnYtc3lzZnMuYw0KKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtc3J2LXN5c2ZzLmMNCkBAIC0zMTIsOSArMzEy
LDggQEAgdm9pZCBydHJzX3Nydl9kZXN0cm95X3BhdGhfZmlsZXMoc3RydWN0IHJ0cnNfc3J2X3Bh
dGggKnNydl9wYXRoKQ0KICANCiAgICAgICAgIGlmIChzcnZfcGF0aC0+a29iai5zdGF0ZV9pbl9z
eXNmcykgew0KICAgICAgICAgICAgICAgICBzeXNmc19yZW1vdmVfZ3JvdXAoJnNydl9wYXRoLT5r
b2JqLCAmcnRyc19zcnZfcGF0aF9hdHRyX2dyb3VwKTsNCi0gICAgICAgICAgICAgICBrb2JqZWN0
X2RlbCgmc3J2X3BhdGgtPmtvYmopOw0KICAgICAgICAgICAgICAgICBrb2JqZWN0X3B1dCgmc3J2
X3BhdGgtPmtvYmopOw0KKyAgICAgICAgICAgICAgIHJ0cnNfc3J2X2Rlc3Ryb3lfb25jZV9zeXNm
c19yb290X2ZvbGRlcnMoc3J2X3BhdGgpOw0KICAgICAgICAgfQ0KICANCi0gICAgICAgcnRyc19z
cnZfZGVzdHJveV9vbmNlX3N5c2ZzX3Jvb3RfZm9sZGVycyhzcnZfcGF0aCk7DQogIH0NCg0KDQo+
IA0KPiBUaGFua3MNCj4gWmhpamlhbg0KPj4NCj4+IFRoYW5rcywNCj4+IEd1b3Fpbmc=
