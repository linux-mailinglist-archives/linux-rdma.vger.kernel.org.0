Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A26615F6A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKBJUc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiKBJUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 05:20:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81E2A730
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 02:17:27 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A284ai1022237;
        Wed, 2 Nov 2022 09:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WDP1BltNFJL+iK74G2Dxr2DlicXQui+hEMRm91SXTnI=;
 b=Ai4eiPpSZx189UBsX5GpoejOtMTRQJM5h3skKJsQIlUlBg+Jyfkhe+taeKsOFN/KvfAz
 EaSk2jIT9/IeY29DazZxV3H033c+xyTAbvNyMaqkWEA4KcwWrBnlxjeh/8iwPlZBUm4B
 0vbmPn7H51MBvw4CAHUDC2km70mBeQSSIo+gaThzAKgOL1NIT5enq4HxwteLsT5MCMAd
 spXXB5Mz2cwJDrvVT9dayaQn27NZjopg+IK46lgKh2RxagNXWmthQLwQlDM/Sub1qXEK
 rbJ4ETob2V0QGZqklv5BlyDXHQtjYrC16ZTKmbqPoBcnyPPQ9LnkjdvJ/ud0gw4F2FCT zw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkmqfj3hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:17:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVeHQai6Wey64xUCLysXF+5IXrB+w9d7tbwj/JqldxVnVg3yW0RRxpC8OXq6ArMkTw1M//FAVTRhyMQBA4yarcEh4C7Id56v4qhijhCqlpzyIQeMk1gECccnchLAdTwmgsEcBAfvZiaBRAFhhkJ/4nx/y+yQ8kC8eQASpPXIU6ciJBKT7decpZwd3PFcAomP6PQb/QjMwM8VmNhOSrDDz5pxQ935EObFrjG29iRs/tiznSjWurnsVe0FQE5plK9PJIUT7Ynvs6GqWVhDhU+w+VYHClD4/OBENPifMLrCbDa6JyTs87Lj/nl7apMvOG6v5rE6v/TEk71b/4fMnjUi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDP1BltNFJL+iK74G2Dxr2DlicXQui+hEMRm91SXTnI=;
 b=RnAkzVfxlI16tXyZUo8eUv313o/7x44TrdEJdFfB0FIghp1xlur3th8MALFDRyyTofdll89sTlX8LDcrtOZayL2aqoly7SSdRyAvGTMWlDr9PW0fqB/BWddpmIxu92YOd8eblNy7TCPUmzbFP6ExMOC0Lnh0qk08wCsof+XhhOo1a9ni0xH7YFLicF5ajqi5wU2si8urJZLEhP9deZbv8EAJg1BTtWKqDcR8Eci1UKjYP5BlakxHNE/dma5qrm68Tg7p2JBJos773IALbzqscEiPZHLKQcgxJGrvX0lSEJ8ErOh1icrI1tfmPhIuRO9hVKU0mJWmG0utKdCYJ8vHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by PH0PR15MB4942.namprd15.prod.outlook.com (2603:10b6:510:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 09:17:19 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::f0bd:f3a3:9b7f:d3cb]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::f0bd:f3a3:9b7f:d3cb%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 09:17:19 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: RE: Re: [PATCH] RDMA/siw: Fix immediate work request flush to
 completion queue.
Thread-Topic: Re: [PATCH] RDMA/siw: Fix immediate work request flush to
 completion queue.
Thread-Index: AQHY7pvodBYM1APo3k+JaAWX3eIGIg==
Date:   Wed, 2 Nov 2022 09:17:19 +0000
Message-ID: <SA0PR15MB391926D626A22048B898592399399@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221101153705.626906-1-bmt@zurich.ibm.com>
 <062bf1bc-f6c2-4cfe-b3d7-786c4efc379c@talpey.com>
In-Reply-To: <062bf1bc-f6c2-4cfe-b3d7-786c4efc379c@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|PH0PR15MB4942:EE_
x-ms-office365-filtering-correlation-id: 79a3e5a2-6cd6-43ad-556f-08dabcb30abc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: URBrA1w8f2YRxK+xHKt5OmsgflAS14GVnIuex7x0TLOwK33tWR6r4cpHxUPSQ6LWbAl9PE+s4dFx9cX2VLNOODOedQVQthwk+S+ezgJYN1nyOUAC1aCf8ewWD2QE6zdAh0S6ZOS49e5Rsvq6SqYU8hyu+wZTsbfFgf8Af7YSH35KvmTW6EsoOpf7oMYaFf7AnEgtv1LXRyRs6lcd00MXjYALlGHTE+5S5Dy8Nnl5LweedtM8NeeZCzpv/5inHg64J6TIwhQ0SQ44mIevsWwoyaWbB8VTo++UqQnGalxTazCcGVVlx/3iZZMJG1iFs8XQ04b8+VD1D+2pDyBtqD7ZRZeehP90e181PXxUtVvf3oq1xMHOnwuSYIkrz/HA2EcqwZYiSY8cQqncCWR12f/rtKL3Q5JcJGy40UEQXFDb97RYDBhKMXp5AveLWIZmqzmEykVXSkPRdjDh76rhc1RNLKGpEe7vb0r15duu5wJG+mFxOGoJ8uNLLjgKG9/WaGVljL0c5QkNASveEJz/trgWeQU569/m8J/pPh+BRn/4AM9QLySTklVcCFEJoL7WKs+DtP0NVY+7ZKxbO4nXd8hAbkLklzOLtZv8viCkv1XdKyLXKeFlUCY99DN5s1u6vV4Zsmbipo7DwgB9AHRVlLLBgZcHjd+UZ7EilSdLIiY/FCFU29Gd/qp9BAf96+TmVoJ1ByiQoFIxh7cT7YzmG9Nrqpp2j+DUa2fNPdzw+ycGjHznePtKeS9xcqQBes63LdgNGmbW3/bhvTjDyvFdJnqoCihaELn5hJjU4vr7842HV54=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(71200400001)(55016003)(122000001)(38100700002)(8936002)(5660300002)(38070700005)(83380400001)(86362001)(33656002)(6506007)(7696005)(186003)(53546011)(9686003)(316002)(478600001)(54906003)(110136005)(52536014)(66946007)(76116006)(41300700001)(2906002)(66476007)(66556008)(66446008)(64756008)(4326008)(8676002)(14773001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRCdTQ0Y0RrTVRVMFlyL3c5SHNPV0dmeVVKT20vVWZLbjFhaitabnhyTmxs?=
 =?utf-8?B?MDlmdWZQY25adzNHUTc5Zy9RNGNQSlJBUW1LWXJFWFgvOWNuTm9QbFdkOHFB?=
 =?utf-8?B?TDBHUUlCbFh0Mk9vcGt4eDl3QWRRSHNXVDE1U0xiaXNaREV3blMxMzA5VUFD?=
 =?utf-8?B?ZTNIMVVqZEVsYnlpZ1dyV3lRcW01ZTdjRWVmcVpDVThHSENCWXBVVzQ2QVZO?=
 =?utf-8?B?WkpuSnc1eXBiUnV0MS8ycGQ2UkpDbktnRTNCT1JJOXlmMkN0V04yK2REaEdk?=
 =?utf-8?B?TzFyRENTNVo5anJOU1JKejdJdWN3L2JyV3l3OWpQdXVFWHJGMFp1MEgvMkFq?=
 =?utf-8?B?alR4QVBWZHZkU1pXNVN5dW5Da3Jta2M3MHRYZnUySHFUanNoWUJYaFVzdFlD?=
 =?utf-8?B?bHRLb3U3eG9IZzN0SFhrVVM1UCtnZFRHQ01CSzNPdHFvak16YXNkdVZIOFF4?=
 =?utf-8?B?MmJmMkhUdXQ2YmFxS0VaSFdpM1MyVGg2RzNNTTZ5K0NGdXdCV2lzODh3aUZU?=
 =?utf-8?B?anFMdExrRkJCQktLMUlMYTNnYlNKTDFSMVNJRTJRRGYyRFFqWFMzUStWbEgz?=
 =?utf-8?B?R29SOThpSjJQeWNlTm5BLzRIbS9STzMxYndHSHRGNThETFNSby8wMHpveTV2?=
 =?utf-8?B?SkI5UXVSY0pDRkEydVFPV0s0MlpnaUVBRExoZllPL1pUOU0zekViYXZtd1Zj?=
 =?utf-8?B?SEZOeFJwb290aVlmQk12OVpMRld4TTBwSDFVUUFVcEd2dm5Qa0NieWkyMFVq?=
 =?utf-8?B?L0VFVlVKSHRGNTFRUWlKbUZmemtjcThLYjJRenpqM1NqMklkMWpqdnN3OFVS?=
 =?utf-8?B?ak9lL0Zrb3M4U09LNFNMeGR5TFBGWmRyUURsUGc2bmJjOXIzQ1dqYi9PaFhy?=
 =?utf-8?B?eGExOW9VU0FXV1d3UG9LSHB5RDJEc1ArVnl0TmhNczhPOVl1QnQyc2JoZUNQ?=
 =?utf-8?B?RHcyS3k2cVBiUi9SbTcrdnM0amF2WmFDemg2TmIvN2lKbXhBa1pBdjdIaWR0?=
 =?utf-8?B?UjZTSE1oT1dBR0RZU2NFREQyK2czSHorbTd0d1JCRml5NnRrUmdDcm9ubzJW?=
 =?utf-8?B?RnpPYXFPazBJNUhtYVp1UTFyTVpiTHBMK0FkS3ZzbXg1UWJzQ2JxQmVNVWUr?=
 =?utf-8?B?U3JNWW4xT2pkdVVGMVdma1pZUjlxZFJyR1kxZ3RnSlVTWnZTSk8yWGI5STM4?=
 =?utf-8?B?bFBpMmFOUXB5VWxCT0VXSFYySFMrcFVZaHBvVWoxOTRIZk9ENmI3OTRvZ1Ar?=
 =?utf-8?B?aUlFTTdoK2FpRTRoZFlDdFlWWktwRTduZmZ0SnJaMlNZamtVK3N4VStraWRv?=
 =?utf-8?B?dGNTb2RXeWIvNHhZZy9jaGF2VHNDK3oxVHlhYkVwRHVpcWpaTkRhYnZueHhy?=
 =?utf-8?B?WVNYbVIyQ0Z5dW9hUlQzT1NEdzB3YjlrZEI2NzlmWmFzekJwVEFvdjBwQmd0?=
 =?utf-8?B?eEVOaDE0NWZNKzhMNVhKaytoUEMvaHVlNjdKbGk4ejJ6dWYyOUtBZzNiZjZR?=
 =?utf-8?B?cFd0VU5hSDM5ME5ScVJyekg5ZjdnanFEZmwzdVVmM3RpUk4wR2N3VjFZa2J5?=
 =?utf-8?B?Q09JWmtsblNVWVRKNXJ1bUhFYXJ1UFJLdlY1TGd5VjA4bTdUTmI2RGlTOWo5?=
 =?utf-8?B?Nkk0MDU5d0UxU0FXZ3FGbzJZVFR6cUIwWWRPaWplcjg5ekczbnoyK3Y2Mksy?=
 =?utf-8?B?a2RTa2lSRXAwTEhtQ2dmZDlWdjg5Z3B2ellsSVdyRjZZSVNZU0ZFc1ZubmMy?=
 =?utf-8?B?bjQ1NE5JbWNQc2xDYklvc1doa2dUUTgrcTBMWWl0L3lZZFVMV3plakM4aXpk?=
 =?utf-8?B?a3dsVVNONjNEcW41MzIvQ3UwZ0FqRm54em50cVg4UE9BSlBNNTg4YWRBbG9O?=
 =?utf-8?B?OWdzNDUxSHVmK0JOSHFmNDFreTVRNTZmQWc1cERqcU5sOHdqR2p3VWNraVMv?=
 =?utf-8?B?YnJENFVycXQyZ2EvZGVVTjJ6dVYvNlUzS0lMTHllSEVUOXdYeEpscmdoanRB?=
 =?utf-8?B?KzVDNjIwNlFyTnJwWHErTWVaS2c2bkVjSE1raFBUalRIY1BBRjVrYzhOZy8x?=
 =?utf-8?B?anptU3lrdDBOUm0xcTI5TUg5U1E5N2xxUE5UejJzODI1eEhiTFFHem9lbzdT?=
 =?utf-8?B?dU5Nc0hrWVlQd3RFanBpUTI1d3NlWUpUd2piTlQ1N3BCT3ZDR3BONWhSQStH?=
 =?utf-8?Q?0lAtEIYqH2DAFba/Gk3FrU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a3e5a2-6cd6-43ad-556f-08dabcb30abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 09:17:19.1160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8qsTByRrjfDucuoRHVo79Fjt8fK3eBlMW+bgHusWTXem6gE5PqkPc/bVlHNgjV67xjX85nzia3x1vGScoFckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4942
X-Proofpoint-GUID: xS5BsvnG-KadkVxS-Ekaa7bBWYZoRLuJ
X-Proofpoint-ORIG-GUID: xS5BsvnG-KadkVxS-Ekaa7bBWYZoRLuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_04,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFRhbHBleSA8dG9t
QHRhbHBleS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDEgTm92ZW1iZXIgMjAyMiAyMjowNQ0KPiBU
bzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBsaW51eC1yZG1hQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogamdnQG52aWRpYS5jb207IGxlb25yb0BudmlkaWEuY29tOyBPbGdh
IEtvcm5pZXZza2FpYQ0KPiA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFM
XSBSZTogW1BBVENIXSBSRE1BL3NpdzogRml4IGltbWVkaWF0ZSB3b3JrIHJlcXVlc3QNCj4gZmx1
c2ggdG8gY29tcGxldGlvbiBxdWV1ZS4NCj4gDQo+IE9uIDExLzEvMjAyMiAxMTozNyBBTSwgQmVy
bmFyZCBNZXR6bGVyIHdyb3RlOg0KPiA+IENvcnJlY3RseSBzZXQgc2VuZCBxdWV1ZSBlbGVtZW50
IG9wY29kZSBkdXJpbmcgaW1tZWRpYXRlIHdvcmsgcmVxdWVzdA0KPiA+IGZsdXNoaW5nIGluIHBv
c3Qgc2VuZHF1ZXVlIG9wZXJhdGlvbiwgaWYgdGhlIFFQIGlzIGluIEVSUk9SIHN0YXRlLg0KPiA+
IEFuIHVuZGVmaW5lZCBvY29kZSB2YWx1ZSByZXN1bHRzIGluIG91dC1vZi1ib3VuZHMgYWNjZXNz
IHRvIGFuIGFycmF5DQo+ID4gZm9yIG1hcHBpbmcgdGhlIG9wY29kZSBiZXR3ZWVuIHNpdyBpbnRl
cm5hbCBhbmQgUkRNQSBjb3JlDQo+IHJlcHJlc2VudGF0aW9uDQo+ID4gaW4gd29yayBjb21wbGV0
aW9uIGdlbmVyYXRpb24uIEl0IHJlc3VsdGVkIGluIGEgS0FTQU4gQlVHIHJlcG9ydA0KPiA+IG9m
IHR5cGUgJ2dsb2JhbC1vdXQtb2YtYm91bmRzJyBkdXJpbmcgTkZTb1JETUEgdGVzdGluZy4NCj4g
PiBUaGlzIHBhdGNoIGZ1cnRoZXIgZml4ZXMgYSBwb3RlbnRpYWwgY2FzZSBvZiBhIG1hbGljaW91
cyB1c2VyIHdoaWNoDQo+IG1heQ0KPiA+IHdyaXRlIHVuZGVmaW5lZCB2YWx1ZXMgZm9yIGNvbXBs
ZXRpb24gcXVldWUgZWxlbWVudHMgc3RhdHVzIG9yIG9wY29kZSwNCj4gPiBpZiB0aGUgQ1EgaXMg
bWVtb3J5IG1hcHBlZCB0byB1c2VyIGxhbmQuIEl0IGF2b2lkcyB0aGUgc2FtZSBvdXQtb2YtDQo+
IGJvdW5kcw0KPiA+IGFjY2VzcyB0byBhcnJheXMgZm9yIHN0YXR1cyBhbmQgb3Bjb2RlIG1hcHBp
bmcgYXMgZGVzY3JpYmVkIGFib3ZlLg0KPiA+DQo+ID4gRml4ZXM6IDMwM2FlMWNkZmRmNyAoInJk
bWEvc2l3OiBhcHBsaWNhdGlvbiBpbnRlcmZhY2UiKQ0KPiA+IEZpeGVzOiBiMGZmZjczMTdiYjQg
KCJyZG1hL3NpdzogY29tcGxldGlvbiBxdWV1ZSBtZXRob2RzIikNCj4gPg0KPiA+IFJlcG9ydGVk
LWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NxLmMgICAgfCAyNCArKysrKysrKysrKysr
Ky0tDQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jIHwgNDAgKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiAtLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1OCBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NxLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19jcS5jDQo+ID4gaW5kZXggZDY4ZTM3ODU5ZTczLi5hY2M3YmNkNTM4YjUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY3EuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NxLmMNCj4gPiBAQCAtNTYsOCArNTYsNiBA
QCBpbnQgc2l3X3JlYXBfY3FlKHN0cnVjdCBzaXdfY3EgKmNxLCBzdHJ1Y3QgaWJfd2MNCj4gKndj
KQ0KPiA+ICAgCWlmIChSRUFEX09OQ0UoY3FlLT5mbGFncykgJiBTSVdfV1FFX1ZBTElEKSB7DQo+
ID4gICAJCW1lbXNldCh3YywgMCwgc2l6ZW9mKCp3YykpOw0KPiA+ICAgCQl3Yy0+d3JfaWQgPSBj
cWUtPmlkOw0KPiA+IC0JCXdjLT5zdGF0dXMgPSBtYXBfY3FlX3N0YXR1c1tjcWUtPnN0YXR1c10u
aWI7DQo+ID4gLQkJd2MtPm9wY29kZSA9IG1hcF93Y19vcGNvZGVbY3FlLT5vcGNvZGVdOw0KPiA+
ICAgCQl3Yy0+Ynl0ZV9sZW4gPSBjcWUtPmJ5dGVzOw0KPiA+DQo+ID4gICAJCS8qDQo+ID4gQEAg
LTcxLDEwICs2OSwzMiBAQCBpbnQgc2l3X3JlYXBfY3FlKHN0cnVjdCBzaXdfY3EgKmNxLCBzdHJ1
Y3QgaWJfd2MNCj4gKndjKQ0KPiA+ICAgCQkJCXdjLT53Y19mbGFncyA9IElCX1dDX1dJVEhfSU5W
QUxJREFURTsNCj4gPiAgIAkJCX0NCj4gPiAgIAkJCXdjLT5xcCA9IGNxZS0+YmFzZV9xcDsNCj4g
PiArCQkJd2MtPm9wY29kZSA9IG1hcF93Y19vcGNvZGVbY3FlLT5vcGNvZGVdOw0KPiA+ICsJCQl3
Yy0+c3RhdHVzID0gbWFwX2NxZV9zdGF0dXNbY3FlLT5zdGF0dXNdLmliOw0KPiA+ICAgCQkJc2l3
X2RiZ19jcShjcSwNCj4gPiAgIAkJCQkgICAiaWR4ICV1LCB0eXBlICVkLCBmbGFncyAlMngsIGlk
IDB4JXBLXG4iLA0KPiA+ICAgCQkJCSAgIGNxLT5jcV9nZXQgJSBjcS0+bnVtX2NxZSwgY3FlLT5v
cGNvZGUsDQo+ID4gICAJCQkJICAgY3FlLT5mbGFncywgKHZvaWQgKikodWludHB0cl90KWNxZS0+
aWQpOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCS8qDQo+ID4gKwkJCSAqIEEgbWFsaWNpb3Vz
IHVzZXIgbWF5IHNldCBpbnZhbGlkIG9wY29kZSBvcg0KPiA+ICsJCQkgKiBzdGF0dXMgaW4gdGhl
IHVzZXIgbW1hcHBlZCBDUUUgYXJyYXkuDQo+ID4gKwkJCSAqIFNhbml0eSBjaGVjayBhbmQgY29y
cmVjdCB2YWx1ZXMgaW4gdGhhdCBjYXNlDQo+ID4gKwkJCSAqIHRvIGF2b2lkIG91dC1vZi1ib3Vu
ZHMgYWNjZXNzIHRvIGdsb2JhbCBhcnJheXMNCj4gPiArCQkJICogZm9yIG9wY29kZSBhbmQgc3Rh
dHVzIG1hcHBpbmcuDQo+ID4gKwkJCSAqLw0KPiA+ICsJCQl1OCBvcGNvZGUgPSBjcWUtPm9wY29k
ZTsNCj4gPiArCQkJdTE2IHN0YXR1cyA9IGNxZS0+c3RhdHVzOw0KPiA+ICsNCj4gPiArCQkJaWYg
KG9wY29kZSA+PSBTSVdfTlVNX09QQ09ERVMpIHsNCj4gPiArCQkJCW9wY29kZSA9IDA7DQo+ID4g
KwkJCQlzdGF0dXMgPSBJQl9XQ19HRU5FUkFMX0VSUjsNCj4gPiArCQkJfSBlbHNlIGlmIChzdGF0
dXMgPj0gU0lXX05VTV9XQ19TVEFUVVMpIHsNCj4gPiArCQkJCXN0YXR1cyA9IElCX1dDX0dFTkVS
QUxfRVJSOw0KPiA+ICsJCQl9DQo+ID4gKwkJCXdjLT5vcGNvZGUgPSBtYXBfd2Nfb3Bjb2RlW29w
Y29kZV07DQo+ID4gKwkJCXdjLT5zdGF0dXMgPSBtYXBfY3FlX3N0YXR1c1tzdGF0dXNdLmliOw0K
PiA+ICsNCj4gPiAgIAkJfQ0KPiA+ICAgCQlXUklURV9PTkNFKGNxZS0+ZmxhZ3MsIDApOw0KPiA+
ICAgCQljcS0+Y3FfZ2V0Kys7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9zaXcvc2l3X3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJi
cy5jDQo+ID4gaW5kZXggM2U4MTRjZmIyOThjLi44MDIxZmJkMDA0YjAgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gPiBAQCAtNjc2LDEzICs2NzYsNDUg
QEAgc3RhdGljIGludCBzaXdfY29weV9pbmxpbmVfc2dsKGNvbnN0IHN0cnVjdA0KPiBpYl9zZW5k
X3dyICpjb3JlX3dyLA0KPiA+ICAgc3RhdGljIGludCBzaXdfc3FfZmx1c2hfd3Ioc3RydWN0IHNp
d19xcCAqcXAsIGNvbnN0IHN0cnVjdA0KPiBpYl9zZW5kX3dyICp3ciwNCj4gPiAgIAkJCSAgIGNv
bnN0IHN0cnVjdCBpYl9zZW5kX3dyICoqYmFkX3dyKQ0KPiA+ICAgew0KPiA+IC0Jc3RydWN0IHNp
d19zcWUgc3FlID0ge307DQo+ID4gICAJaW50IHJ2ID0gMDsNCj4gPg0KPiA+ICAgCXdoaWxlICh3
cikgew0KPiA+IC0JCXNxZS5pZCA9IHdyLT53cl9pZDsNCj4gPiAtCQlzcWUub3Bjb2RlID0gd3It
Pm9wY29kZTsNCj4gPiAtCQlydiA9IHNpd19zcWVfY29tcGxldGUocXAsICZzcWUsIDAsIFNJV19X
Q19XUl9GTFVTSF9FUlIpOw0KPiA+ICsJCXN0cnVjdCBzaXdfc3FlIHNxZSA9IHt9Ow0KPiA+ICsN
Cj4gPiArCQlzd2l0Y2ggKHdyLT5vcGNvZGUpIHsNCj4gPiArCQljYXNlIElCX1dSX1JETUFfV1JJ
VEU6DQo+ID4gKwkJCXNxZS5vcGNvZGUgPSBTSVdfT1BfV1JJVEU7DQo+ID4gKwkJCWJyZWFrOw0K
PiA+ICsJCWNhc2UgSUJfV1JfUkRNQV9SRUFEOg0KPiA+ICsJCQlzcWUub3Bjb2RlID0gU0lXX09Q
X1JFQUQ7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCWNhc2UgSUJfV1JfUkRNQV9SRUFEX1dJVEhf
SU5WOg0KPiA+ICsJCQlzcWUub3Bjb2RlID0gU0lXX09QX1JFQURfTE9DQUxfSU5WOw0KPiA+ICsJ
CQlicmVhazsNCj4gPiArCQljYXNlIElCX1dSX1NFTkQ6DQo+ID4gKwkJCXNxZS5vcGNvZGUgPSBT
SVdfT1BfU0VORDsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJY2FzZSBJQl9XUl9TRU5EX1dJVEhf
SU1NOg0KPiA+ICsJCQlzcWUub3Bjb2RlID0gU0lXX09QX1NFTkRfV0lUSF9JTU07DQo+ID4gKwkJ
CWJyZWFrOw0KPiA+ICsJCWNhc2UgSUJfV1JfU0VORF9XSVRIX0lOVjoNCj4gPiArCQkJc3FlLm9w
Y29kZSA9IFNJV19PUF9TRU5EX1JFTU9URV9JTlY7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCWNh
c2UgSUJfV1JfTE9DQUxfSU5WOg0KPiA+ICsJCQlzcWUub3Bjb2RlID0gU0lXX09QX0lOVkFMX1NU
QUc7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCWNhc2UgSUJfV1JfUkVHX01SOg0KPiA+ICsJCQlz
cWUub3Bjb2RlID0gU0lXX09QX1JFR19NUjsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJZGVmYXVs
dDoNCj4gPiArCQkJcnYgPSAtRU9QTk9UU1VQUDsNCj4gDQo+IEkgdGhpbmsgLUVJTlZBTCB3b3Vs
ZCBiZSBtb3JlIGFwcHJvcHJpYXRlIGhlcmUuIFRoYXQgZXJyb3IgaXMNCj4gcmV0dXJuZWQgZnJv
bSBzaXdfcG9zdF9zZW5kKCkgaW4gYSBzaW1pbGFyIHNpdHVhdGlvbiwgYW5kDQo+IHRoaXMgcm91
dGluZSBpcyBhY3R1YWxseSBjYWxsZWQgZnJvbSB0aGVyZSBhbHNvLCBhbmQgaXRzIHJjDQo+IGlz
IHJldHVybmVkLCBzbyBpdCdzIGJlc3QgdG8gYmUgY29uc2lzdGVudC4NCj4gDQpJIGFncmVlLCBp
dCB3b3VsZCBtYWtlIGl0IG1vcmUgY29uc2lzdGVudC4gSSdsbCBzZW5kIGFuDQp1cGRhdGUuDQoN
ClRoYW5rcyBUb20hDQoNCg0KPiBPdGhlciB0aGFuIHRoYXQsIGxvb2tzIGdvb2QgdG8gbWU6DQo+
IFJldmlld2VkLWJ5OiBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4NCj4gDQo+IFRvbS4NCj4g
DQo+IA0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+ID4gKwkJaWYgKCFydikgew0KPiA+ICsJ
CQlzcWUuaWQgPSB3ci0+d3JfaWQ7DQo+ID4gKwkJCXJ2ID0gc2l3X3NxZV9jb21wbGV0ZShxcCwg
JnNxZSwgMCwNCj4gPiArCQkJCQkgICAgICBTSVdfV0NfV1JfRkxVU0hfRVJSKTsNCj4gPiArCQl9
DQo+ID4gICAJCWlmIChydikgew0KPiA+ICAgCQkJaWYgKGJhZF93cikNCj4gPiAgIAkJCQkqYmFk
X3dyID0gd3I7DQo=
