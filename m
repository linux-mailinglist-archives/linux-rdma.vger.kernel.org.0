Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554F27DCA4E
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 11:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjJaKAF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjJaKAE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 06:00:04 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98283;
        Tue, 31 Oct 2023 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698746402; x=1730282402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2tnhUGFTiad0G3DYbQtkydRSgid95kucJC4azHlwkrs=;
  b=A0xjLgvKAYbvRdUkvGdlimGBuQOr9mKOlxCs6JD4ACJ6i6wFavZiXZeY
   2bk8xEdbRwS9/Ws0vjJTw84OlaM5bcd2dqzn58w2k1VOTJuL9ztLLiZ5U
   4VXa8P/Ah1QUC2EflVkAVIYBdruLQukpHQ/KDt044MQm9a4MQuQ6TSHxf
   mL38N3zUgza6McV3BGS5ChAtl6kqYuwX1zDq2tT1SKNUSUS0i5l/fm+lY
   tfxV0jR9YtQ8fgfiSmd5khT7A5sOLIP4FiHTYt6j8F3uDy/7WUdsjs0h/
   zdinh6i7X8D7V3x3Z3n7XqqQkYLVgX9blYrf6jUHxN6obHQ1JOPQXsMJR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="100555717"
X-IronPort-AV: E=Sophos;i="6.03,265,1694703600"; 
   d="scan'208";a="100555717"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 18:59:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgIjGljwIWpeakCp8IJ3c7wjLIR9iCB5c0ZlwRmFvwYqj4LY3kGzeGqxkcM89zg0MjbMktWJzUpib4QPQD9MwRdYUruJLbwtDnWEeFX30pS9k+j/QA/7jRaVvcskCQnytYEbq8E/CgL03Jd0uw70tldSekvUE58bBSsN3AwU0nStn8D7EK63ViVQ5DyVvfxRMfO3QXAII5jyBUQKa7sgGbWsMWrHZIeE/yTdQJAdDWkOJRpCE4X5ZQzrGDansVliFclYVd5VzdUEu/KFMAzyStvaENPYIy4g/JMkLmkGGKYG/1Cd+1o4pHIT35r98ltLL/hDVntGWIUtJVxNXCyv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tnhUGFTiad0G3DYbQtkydRSgid95kucJC4azHlwkrs=;
 b=LPJWHDeFDYI4rYn9VXqE7H6G9qdMEygmBiJW7h74D/GiEF1ZivQa69rkcrj/QMhohypliDcg4WqcTaHf7xmeT34vJMDRjdJZuvpIHtWm/KO8VcCVKaBFKPQ6se1mtGoifnesVh94IgsW/lpISm9q2Ln1C/Fi1gF/ndeCrM4NDGmT2/aoDrYvpY0V2k+d28V8Nrptbll+Ei8ngHxktlSlDMFqf5cyjzyTkGmxAJdf0o5hsy5U00sOMYpMUPsGPEZN+9TrNU/8OIF5Ov71ZTzeWTqBqpPZhvYhajBvKetPWp60cIrS4pZ6psIIbGx8VUZSIt3fvSWZG9okG2hJIo0mbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB9353.jpnprd01.prod.outlook.com (2603:1096:400:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 09:59:54 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 09:59:54 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Thread-Topic: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Thread-Index: AQHaCJhTvrj5SCKGZEeB5zGuZXPZvLBh+qQAgABQwICAAWVogA==
Date:   Tue, 31 Oct 2023 09:59:54 +0000
Message-ID: <80ea66c5-2afc-43c5-b1f5-66cc2e62295d@fujitsu.com>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <4da48f85-a72f-4f6b-900f-fc293d63b5ae@fujitsu.com>
 <20231030124041.GE691768@ziepe.ca>
In-Reply-To: <20231030124041.GE691768@ziepe.ca>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB9353:EE_
x-ms-office365-filtering-correlation-id: 3fe2e78b-3fdf-4a11-6957-08dbd9f821a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNBQunzBRwEf0ef0fJABr0K0Ny94Y6Wnc25qr9JOEwNY9E3+8iz9I2l5zrZ3P4Oy2YwozknqMuCRrW+8TVH88bkuIo+u+mTpXb7EE/l5iqrVmz+DTTQZQYoI9LTjU82dVYbtOQq2skn86NFKn1Fp8cHY7HPgqpuextoR8KM9+Oq8qghiikXtggelsWR6WJVRyxQ0ysGpE2Arx3eHA7zM7zm1pZ1NOfb1OcQFiKfoQrjVHCV+KTvP6kSCtmDuY7/kl1RdRH8v1NGRCKhY00BxtLN95jhI2A2G2zP57HcpdVo055QX81HcZhCRZlDYymHMQjnVa3mRCCrzVGJ+Iw2aOEMCDVQRepjXpd2BiI6lPsgMlcHPTWaN8YdauJpSTQRVTleIzE5r94c5SDBNWGU91Jj4zGyvoTj+636EVw8vr6WSTwIcEOaa1mJr05JqsuXCRTTEGl3yl1qHC7Or/kXVbhTLZa7cazLgvExKkuknhOfAFcdbk4txbH/ZeXe3VQNifBfNPqJTZevRse95utFtvOmUQJta6h+oVmiMVMyrDxwV+LdupyOBwt+eLyL1yHGRzrJ3b4Tk3SaOGmNyrZbVtxEaU7DADv0TLpSZ8Xa1CNamKuXS2Ydf5Lk7Ldx6iJwA4gU9gEtJBXyK1YLaE8RZY24KeMUshZ0cZd2zhb6/eeQU6wlAOkl0HF855LOtRSseWamgXpo4T+3k4tTobJpVEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1590799021)(1800799009)(82960400001)(86362001)(85182001)(36756003)(122000001)(31696002)(38070700009)(31686004)(2906002)(6512007)(6486002)(41300700001)(478600001)(8676002)(8936002)(4326008)(53546011)(71200400001)(83380400001)(2616005)(26005)(1580799018)(6506007)(76116006)(91956017)(5660300002)(316002)(66476007)(6916009)(66946007)(66556008)(66446008)(64756008)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zjhoek5lRERHdzJHMUpjelAvTSs4cXUxc3JVR05KN0xaWnZ1U0NFcUxSdUdP?=
 =?utf-8?B?Q2ExYkNpTHRCR1NFTmRlQjJyRnBuUEg5dlc4NFZETGxzUk5DZVJ0ZGQyR2to?=
 =?utf-8?B?Z0FHNVZOVDRldWpRRXdXTGtuSUJxQzJEOEl2d3lMdisrOFBJWi9GQm1UbWIr?=
 =?utf-8?B?dlVmY2dkb3lIM09xNk9GZ2lQVlVyK2ZubW9zV0NNQXFpa1JjWmwxVEdmVUh3?=
 =?utf-8?B?SlRJWXpWWXVqeXdERGFMYi9NZzdYUGpVK2taY1BDZGFsNEtMV1V6T1dLSEc4?=
 =?utf-8?B?YStEaVB2YWJUWTViS1ZnTG9aWEdZMDM1QUFJbUMxZklmSFRYV0ZsWE55YXNo?=
 =?utf-8?B?VGFuZGxveTAraFJoOWZWa3paT1VzTS9vajlDNDE4V0VLb0lCNi9yYVprengx?=
 =?utf-8?B?R0ZNYTE1bCtGUjFDOHFXNklCQzgwWklWS0x0RnZZQmlINldOditDc2UrZ3Nj?=
 =?utf-8?B?RXF1YWU2WEM3bmdLcHFyR1M2QktkRHdJUlJRaDNUN2FuUEZnSS9yZng2SmxT?=
 =?utf-8?B?WVhlKzNkcXU0RC9nak8wOTlFTzY5RUQ3STJRbG0rS3ZOQ3Qyb0FERVBhRFVS?=
 =?utf-8?B?UHgydVdPSldXR05GcWZGR2ozM2tmNHduMWhjbWdYMHZSZU9LcVlrRHdLdHJW?=
 =?utf-8?B?V3lFeFVMQ3M2dnNHWDRQUW1adXNSeUxadHdqY2MxcEUwT3BkenhUanRyVTky?=
 =?utf-8?B?M0hMTWwvalVPT1kzcCtvMDhBNXBWTEsya2kvMHgzOFY4WkNxYkNwSk5HNVZB?=
 =?utf-8?B?a1N3L2ZFTnA1MDdodmNJVlIzNW01VTQwd2VrYnZQRUFxeTZCQVltbkhmOVR2?=
 =?utf-8?B?dENtR1cwblBDR05qVXFiU21JM1JnUmZZd3dPV3c0SllzUnA5TklGSmdrTTB4?=
 =?utf-8?B?ekViV25EMzFFMk8wa1VrL2ZFalEzRzlUUlFCWkdNM3hWejVyTmtjQ28xMW9v?=
 =?utf-8?B?Y2FmSjZjb2t1NG5RN0xWZ21ldURyYXVTU1c3eTB0d1duQnZrakpNMTRCNUk3?=
 =?utf-8?B?QUFnWktwMlQ1aXB0ZVQvOXdyZFZ2dTVXOFVYR1M5aTVONEdPelIzbjdlbUs4?=
 =?utf-8?B?TGQ1a3Vud3c4NWlTZ1VxTUdXWDZ3SkFNSnBqbG9qUnVLZHhzN0xNR0ZWZFI4?=
 =?utf-8?B?c3lnaFhsTGxIWGhBbzFZYU1UZmpjYjc3VG53aUs2MnYrYk53cmNsdWo5REl1?=
 =?utf-8?B?LzVGQzNqZzN6NEp6VXU3R2Vua3VwUUZBSjRCMVhXUmZXSzZ4TVBNM01wc3Q4?=
 =?utf-8?B?L282dG9SOE5vTitkcjFKRERkb2xGYTY0WXZiMEJZQjcrdmpsVDRtZC9JM0JJ?=
 =?utf-8?B?Y0EvQkpLdWkzalFldzQyNlNsYzdyZHZzdEoyRW1UcDZBMWVJbER6NElUaVpV?=
 =?utf-8?B?aGYrb1o1WlB4SmZhZmM2WnVncjV6RmtxM2djM21XVmluNzVvMkw5WldtMXJh?=
 =?utf-8?B?OG9wazQvb2pvcG5uVlAwcTE3eG9wU0ZlSHlLaTV6VjJBbUc1STEwYm13SnBW?=
 =?utf-8?B?VUpYRmF2NTBMWDB0SzJVb2pVTTljZlY2QTAvRjlaRzBudXk1N3E0MGVRcncy?=
 =?utf-8?B?bEpzMWJHTmRGejNmRXVoaEdnL3RFWkRjcHYyNkl0bUI5ZDVDMkdnSTBmMjEy?=
 =?utf-8?B?NGd2SXB3KzB0Sy9JTTVydEVmMFI4SnZFNFVXSDBLbFdWbGMvMFNqSHlFYkFT?=
 =?utf-8?B?VGlPVnU5TGZGL0dmenJ5aGZYOEtKNkhFUVJEdDNWcDF4SGtxQTU5Q3cwL1Uz?=
 =?utf-8?B?OG9Dd1g0aGFIdVRrT0dvYy9wd3FuVGZLV01tK1NFOGwrTXVUcGMvSEZ5WVgv?=
 =?utf-8?B?N09ST1pRek5QVHFUZ0hTdEpENXI5VlVqVmtpdEZ0cGtFR1VvUEc1TmJmT1dr?=
 =?utf-8?B?dFowTXZwb1kwQWNIRGIvOHJ0WWp6dmZ6RFNJc1ZrM2c1NGZPUDdCTG1zZ1JX?=
 =?utf-8?B?UUkvcExXYW8xbUtEL1V0RkpVNDRRaldKNHUrNWlaVmR4TzJGT1FPeXA4c2Jl?=
 =?utf-8?B?Z1VtV3MxL3lhb0FjM2x3ZjQvVjZYOVdTWWdQWVdCS1NBdlgzVFVEQ1lrazE4?=
 =?utf-8?B?bXR6aStJQ2FkVjQ2VU1DRGgrelRqUFB4L0FTS09ZWTBJeHBQM3hCR2hOQ1My?=
 =?utf-8?B?RkR1ajREeFdmTk5jR0d2TWxCTDAveEFBSGNaWFdXY3VRd2pQdVRyOHQ2OXow?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F191AC4947EAFF4187D5762E408F92DC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3QGkLlWWUfjhnsTeJSuueVXr/oO3yWim4Z3nlc502vqpw0CtoSNVvcgk7OKcJz7E9GkqolXPVM/LKVIqmWAO9MEaGtFLmwbTGKZTGyUk1vIJ6zOK6nV/4bG3vnRqzlJOWAzpdHiMHJh1joIEmyAulqfRrnZQ/Bkjh2PVLYSRooMp24iCGXaBHKlpOtvDhUvG3VABOQfK95CGPrkWn4b+egILFWNNJi7Tbc3y9k+ta6C+kbGbMoRK4crs2ybE4Mvw59x1jmKcBtyQ6p3R1vYh2aBfHsAAbmtKVTSfNv3irthTy1oTxgq5tzJtN/UGUmBrEkoeEzVOOeIl4SNO5k3iHmNzei8AyjPn1lrmEF9WfiDTpjUEJjaJnbWweU2qB9A0Q4zZubF3ublo9GWucfs1oGaU8w7YqJ7kaoie7ZbU3/I7ZG8eIMOlsavyJoDOl27pl0SqCw+WMVHUw/cNK/q5G61TSBGDayMefdzEoNOmwsgV9YJxB8ZKpDPTaIQIsx4+Iil7FQCVkVUmsPXwHNaTxvLGt9jgaHN73gVGxdgKO4mtSXauc6i6bqWj3YuFz20gE/NZDOII7u2/ovrSJU/8ZncGafHM/NPaq9Lia9chzmoywPUPJsztuHkLXzUGdBxhoJkhhy83cvFhYzMRhbgdOheRHn5R/D5JpsIbnFneXSqwvaYdiqKm1TF2ZWaKwIpWAE9SzxBfTq2yrnVGfHh0kcjqf7NyQ8kHwYNacaXkw4uEPuwor4i0ZngRWk98uWtdKQdCHJuFIwGiXonu+qn1QAW0T5oTqSuuc/5uINSWX5GchtbH6AwXudJMqdoAuHvnfG4mz+emZy5bCnnVByjy86in4hjnUNOWF0CLlpdddddDXtwN3TldXDoqmgtzzt3z
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe2e78b-3fdf-4a11-6957-08dbd9f821a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 09:59:54.2396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KR2OJhECpbZsG8iF4SrYxk4xlNSUKDRQy7GetctKNrTf8mn+drHdhM5ksqQQx3DPZOjumyU2dc8HJHZuyInnAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDMwLzEwLzIwMjMgMjA6NDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gTW9u
LCBPY3QgMzAsIDIwMjMgYXQgMDc6NTE6NDFBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkg
d3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDI3LzEwLzIwMjMgMTM6NDEsIExpIFpoaWppYW4gd3JvdGU6
DQo+Pj4gbXItPnBhZ2VfbGlzdCBvbmx5IGVuY29kZXMgKnBhZ2Ugd2l0aG91dCBwYWdlIG9mZnNl
dCwgd2hlbg0KPj4+IHBhZ2Vfc2l6ZSAhPSBQQUdFX1NJWkUsIHdlIGNhbm5vdCByZXN0b3JlIHRo
ZSBhZGRyZXNzIHdpdGggYSB3cm9uZw0KPj4+IHBhZ2Vfb2Zmc2V0Lg0KPj4+DQo+Pj4gTm90ZSB0
aGF0IHRoaXMgcGF0Y2ggd2lsbCBicmVhayBzb21lIFVMUHMgdGhhdCB0cnkgdG8gcmVnaXN0ZXIg
NEsNCj4+PiBNUiB3aGVuIFBBR0VfU0laRSBpcyBub3QgNEsuDQo+Pj4gU1JQIGFuZCBudm1lIG92
ZXIgUlhFIGlzIGtub3duIHRvIGJlIGltcGFjdGVkLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgfCA2ICsrKysrKw0KPj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYw0KPj4+IGluZGV4IGY1NDA0MmU5YWViMi4uNjFhMTM2ZWExZDkxIDEwMDY0NA0KPj4+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+PiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+Pj4gQEAgLTIzNCw2ICsyMzQsMTIgQEAgaW50
IHJ4ZV9tYXBfbXJfc2coc3RydWN0IGliX21yICppYm1yLCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNn
bCwNCj4+PiAgICAJc3RydWN0IHJ4ZV9tciAqbXIgPSB0b19ybXIoaWJtcik7DQo+Pj4gICAgCXVu
c2lnbmVkIGludCBwYWdlX3NpemUgPSBtcl9wYWdlX3NpemUobXIpOw0KPj4+ICAgIA0KPj4+ICsJ
aWYgKHBhZ2Vfc2l6ZSAhPSBQQUdFX1NJWkUpIHsNCj4+DQo+PiBJdCBzZWVtcyB0aGlzIGNvbmRp
dGlvbiBpcyB0b28gc3RyaWN0LCBpdCBzaG91bGQgYmU6DQo+PiAJaWYgKCFJU19BTElHTkVEKHBh
Z2Vfc2l6ZSwgUEFHRV9TSVpFKSkNCj4+DQoNCkkgaGF2ZSB0byBzYXkgSSByZXRyYWN0IHRoaXMg
Y29uY2x1c2lvbi4gSXQgc3RpbGwgbWlzc2VzIHNvbWV0aGluZy4NCg0KVG8gc3VwcG9ydCBQQUdF
X1NJWkUgYWxpZ25lZCBNUiwgd2UgaGF2ZSB0byByZWZhY3RvciByeGVfbWFwX21yX3NnKCkgb3Ig
cnhlX3NldF9wYWdlKCkNCg0KQ3VycmVudGx5LCByeGVfc2V0X3BhZ2UoKSB3aWxsIGJlIGNhbGxl
ZCBpbiB0aGUgc3RlcCBvZiBwYWdlX3NpemUsIHRoaXMgZG9lc24ndCBzcGxpdCBOKlBBR0VfU0la
RSBtZW1vcnkgaW50bw0KTiAqcGFnZS4gU28gd2hlbiB3ZSByZXN0b3JlIGFuIGlvdmEgZnJvbSB4
YXJyYXksIHRoZSBhcnJheSBpbmRleCBpcyB3cm9uZyBhcyB3ZWxsLg0KDQpTbyBpJ20gZ29pbmcg
dG8gcmVmYWN0b3IgcnhlX21hcF9tcl9zZygpIHRvIGl0ZXJhdGUgdGhlIHNnbCBieSBteXNlbGYg
aW4gcnhlX21hcF9tcl9zZygpIGxpa2UgU0lXIGRvZXMuDQpIb3BlIHRoaXMgcmVmYWN0b3IgY2Fu
IGhlbHAgUlhFIHRvIHN1cHBvcnQgU1pfNEsgd2hlbiBQQUdFX1NJWkUhPTRLIGFzIHdlbGwuDQoN
Cg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPj4gU28gdGhhdCwgcGFnZV9zaXplIHdpdGggKE4gKiBQ
QUdFX1NJWkUpIGNhbiB3b3JrIGFzIHByZXZpb3VzbHkuDQo+PiBCZWNhdXNlIHRoZSBvZmZzZXQo
bXIuaW92YSAmIHBhZ2VfbWFzaykgd2lsbCBnZXQgbG9zdCBvbmx5IHdoZW4gIUlTX0FMSUdORUQo
cGFnZV9zaXplLCBQQUdFX1NJWkUpDQo+IA0KPiBUaGF0IG1ha2VzIHNlbnNlDQo+IA0KPiBKYXNv
bg==
