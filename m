Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D555A9960
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiIANrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiIANrl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 09:47:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96B250
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 06:47:39 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281DN6Ys004337;
        Thu, 1 Sep 2022 13:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=vKcs4tPAOT0R5EIInuxmvB8flky5wm4Tf0TZhGU+76Y=;
 b=CYnMdAijyOHKm1JjSnOVe8RPuQfEwEn8CRhBUp7XHqSvzZ23x7vYpVTE8w95HgDob9gy
 yb0OAUrpEsJa36pnvEOboY1sBkvcXAMW9eFTiBXg3GtfvbJq2OAI4d/CbkYI/n5naqrX
 IwHc53PmnaUghdsmq3hkcFuJA9sWXhrhEGTzsAU54a1w0OYV3y8tok9rBKDqv1WsjVsH
 cffi02Yxv19JVWFidq64/CLXF1Y1IrzRJAO+6vXT95vQwGTrV2ZVStb43cWAkZobIgf3
 NHoD7dsGtvZQ79/e9EO20ehwGXpXSf9p2Nm32MCphkHSzioreiSjQ43ZxwY4BUzCJPVc ZA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jawjwh4tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 13:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtGhq7aRa9ZQoicIO+0CHHpyuFjXeOC8RGedvm6zBvExJBeSJdgeoBw9esvgZRohNhYbg+6+ERsqdgDmmu/1lbmULZRYr1IOeoO08ZM0DQyMNa8kQQG34Rk6vh7or0+HzSLopRkLUcGyRX6f1YGlE3x8vQVPsn5BAz6bTzL9PVYRGFH+4RgQSmOY2BgkhzXWl0Ru0zpndy4QLsxLn7qwJE36fBPbeEDkZ0OE0tq5Y8t8q5S4wqtE/c7ZbLnhVBakzf4DGFIASDtMoOGQCUBiG1UHLUbozVCZWLAhekrwweLSzdTnphNHvQOmtjlgN4kgzWXe49Jp9mETMFEsfeZqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKcs4tPAOT0R5EIInuxmvB8flky5wm4Tf0TZhGU+76Y=;
 b=Pc6q2slmkUAK/G30uqQNsFBDj/7UWbCU6CAFTe+OGort6yB7p6Di9sLrjALHqrS1Dynrj0EGlWyHoBUsAJ4BG6Y/sqYLNbZSiYIsnTnaWXsAiEEb3SUuuLAEFB8owA+HNu3ZOqYGim6+7n4MohQjmhfNZW3mafCe/At3L4Pm3VmT+S4nn/rq16nlBklDFinAvRhOK+E/cHAFS7pRGUyq0HucYCQqfES8BElDmm4rAYoKMzPJoDCYUr8ch708fV9yQWKpoIeXmK8BMwdTPDWsisV6pdgvLtvCKWCApESGrGAPh/yfnnk5mDmQQK+cJnoZAzpW0GF4zkEq9qiEBOTZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SA1PR15MB4707.namprd15.prod.outlook.com (2603:10b6:806:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 13:47:35 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 13:47:35 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] RDMA/siw: Pass a pointer to virt_to_page()
Thread-Index: AQHYvgdf75qwoD5oj0m6yvj2uCA5EK3Kk0RA
Date:   Thu, 1 Sep 2022 13:47:35 +0000
Message-ID: <SA0PR15MB391974392E37FF66792171BA997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20220901133056.570396-1-linus.walleij@linaro.org>
In-Reply-To: <20220901133056.570396-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e651a169-2756-41ea-7a07-08da8c2086fc
x-ms-traffictypediagnostic: SA1PR15MB4707:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUoewmsggtSoXMg/+Tkmwe1DBUu91TW6MlLaqp3smDyNDP8LIBTYs7z+nuPfZPY/rywKW9b5MDOevUHwnzZfiHo/l+34JekIrpVWkfsYFWO7uyW2wP15ECgfyVpRzVx2D0gtjnPOYB0CebOkdBEqFvHcVolItSb2CG0KdYY24QOJ3+ZlEIjy98wijk03wG6pYFJFFo2YtXeKEYKC+hh5YbhykOQykWYo/gq+vHyaTpWdhWAclXGa6AyRMFy3sDfrDnm0BpkF5iru6GeZ6HEAlVeZWFrlWGK8SSURoDeBbC2ARbKl/15lCUw1YxU2FTAcpySxYMg/9P+tyDbLY304Oc7TjVWeXA13bdPe4hKc+AUxUkElm7e8s9gxpDtscNp55gog0Te6qjgpPcMpEpdXbRCwDq2VWVqP4hX1fOlglSL5i7nhUa7fWt2xS8spsRvHXyl1NItBoY9vKap6jtYHsYdopiApDUos4WKanA6glsioW0qOWhrEOwph1NwTxZQ+UAs9U1He2YyYudKevyB8Q1CnZvuPnIoaFkMnXpUrKBvtwSaHrZC/1VONAFu6iWZDUdURCpx+KXlqAcvqbtL+gozCO/gbuz2wUajZzYbehBb2prx5Vc4vmjwleKZyhirf8gqXKoYSAOSUCRyatkhtT7TgRlEsC7b/1BC6Nj71l7qWA/Y6/8FDU+H+MuB6e6ya2spzN35wZ/En938x5m1mIver7RWzWEg2Vm6R7PfJoNF/oB0AdTd7L4Tz1cy1oTj7UpfCZIOJKb3LTjgWlnWYuN3fmm+XSzYWuHG4vSg0qgg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(39860400002)(376002)(83380400001)(38070700005)(38100700002)(76116006)(122000001)(66946007)(55016003)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(110136005)(316002)(2906002)(52536014)(8936002)(5660300002)(6506007)(9686003)(7696005)(53546011)(71200400001)(186003)(41300700001)(478600001)(86362001)(33656002)(266184004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGs2MWJ3ckQ3bEhESmNYQjF5ejErQ3MyanVxUU5LZ2tSRjVVYll6YXRJWmcv?=
 =?utf-8?B?bnZ4eEo3NXdGK2FqQ2g3TjVEeGR3QWg2N2NEckNlMTVIV1JLL1pKeVJBWHpB?=
 =?utf-8?B?dlM1ZzY5OS9yZE5BZ1F1QklvMC9wVDR5NzZwaWRYb0RyOXhFV2VRYzhnaE1i?=
 =?utf-8?B?c1I3MW14NGI5WUZpK2lPbXd5QzBjS2pWaVRyUUxGbnY0RlZudk1qdVRENFAz?=
 =?utf-8?B?RW15RnhYaGFUbjA1WFRaWVBJbXNhTEVtUmNFU1ovR3RxaFJjZ2YzYWlWcU9B?=
 =?utf-8?B?dU91MnpWNHNIS2cwRTR2K2VMK2hMY1pmYWRYK1JhZ204WjllNFEycG5NRy9x?=
 =?utf-8?B?Ylp4ZWloVG9VZHQvWlZKT1g5M3RKaTdFcDF1bHh1OUZORlFzczUyN05KMHNx?=
 =?utf-8?B?MmhsQjdlYU5wYWRVT3BVckFKZE0rWjNyMkU2cXFCcmY1YitmQTk2U2Q2NVpu?=
 =?utf-8?B?L2l5MDNiNnIybWs1YW9zaXhtZzdXOS9iYWc4RzRaUGYySUxkSUVrb1RuL2o2?=
 =?utf-8?B?UnNLTk42dVZOeVdqb0IxK0tSU0NNVkZvdmoxMjBEZHgyMWpPMXVpZ0Z5c3FB?=
 =?utf-8?B?WTZlVFBVRFpxZWQwUEJuNW5YNXJvRzdTYVdjREhNWmxXYVhOQTdoUElUaTVU?=
 =?utf-8?B?LzF0NlEyNitkc3l1RHRvY1lZcUFFQzQrSGlhSHB5ckVFTndhS1ZlVEtaT29k?=
 =?utf-8?B?dkRqZnlER3d0akloR21LTDZSWERXTmJrN2VFM2R2aUt1MHY4T0tjQ1hsZnBR?=
 =?utf-8?B?VHZPQXRmNXMvRFB5SFI2bmszcHBIQ1VRV3J1dytxdDB4VnBkOENEWmV6Wk9S?=
 =?utf-8?B?bDV5dmJVRkNxSmwrMkVEa2NVSkFCbXZEdWZObm9BeldPK0hRZHNGYUdtdXV6?=
 =?utf-8?B?eG5Eb3JWRElVWnVlWW1FYmhFbmp5QTk1SUMxMldGa1BHSXRIblFsamJOcG5I?=
 =?utf-8?B?ak9SV1I1SU5MNkVHMlZxdXRQTjlONlRLZkl0NVY1eUo3VklCODJBM3V2QURW?=
 =?utf-8?B?NnM5VXliZHNCYzB5VVNvdUtsQnVMNW9YMTJ6NTQ3ZERHVUJQSTJ4T0lVUDA5?=
 =?utf-8?B?cTJYL1RHWE1wak0ySVhqMUhWcm5IdHI1bGhIQzJwTkIrME9WYnpwNVh6MXhX?=
 =?utf-8?B?aDRNVGlQR29LWmNvK3hlMzFDODhlZkd1TzJzM3YrM2xFZnN6YjQ0T2Q2MHFp?=
 =?utf-8?B?dDI4RlNOYXVGSi96ai9kcVNLeTBVNGFiZjdhdzRyMzF6VENNUEZlQkdFQ282?=
 =?utf-8?B?Z1NlVkpKTTlCV2o1TTJ0RzVTekh5ZVlOSDNiTkVBa1cwZ0xyS3Y2czg5NFJY?=
 =?utf-8?B?Q3Y1MGZqbFBqWjhzRW5CSjMwN2dvR0hnakRwSmhVR2FyNTJGMTBtRnRTSnN1?=
 =?utf-8?B?MnVlR3IwdzkzS1Jvd0FGeW5aVXA0K09nczZ2RGFWaDJOMG44SEovZ0E5RzJn?=
 =?utf-8?B?SURhZFM3ak5jdE1xTlhLeU8yQkdocjBKM3JlSzBIaHpvRVlGRkdwSzFRVlJW?=
 =?utf-8?B?R0tMNXB5d1BwMXRPQjFnSWZMdzZQbjhrT1pBRUZhaGVUdDRvYVhqbGxVSkNM?=
 =?utf-8?B?WW4yR3JqRFFIU1B5ckNmNWN4NEZZenU3Rkdwb3A2d1BjYXFtVGtSdVFYaExX?=
 =?utf-8?B?Yk55cDU2OVpLMExYYnZBeEVxa3pyR2lwaGxjVUZoWG44K1k1Q0dTVWFMcEV5?=
 =?utf-8?B?d0tKb2p1TGhaMUk3ZmtzWTRmaURkbHZNVTBCOUhPY1hIdTZVY3VuVTI5MC9O?=
 =?utf-8?B?WE5MeWlqL0I3alRSeWVRbm92OWhZSTRIb1hKVm4zS3I3eXZIYldnM1V2ajF0?=
 =?utf-8?B?TzIxWWJRQ3d4Z2llU0ZaUEQwN2RCQ2VLL3BtdVhnaDZDR1lVbjhINDhiWDg0?=
 =?utf-8?B?YkFSTFlrV2pkdTRyQ1cxL1BaZEVsdmlVTjdvL0tMOEhDV0lValdrRWQySm9o?=
 =?utf-8?B?dWZ1TmNCMENMemh4UitQeEoyM1dNWmRLZjE1NmNFSmM2bHhsQWdPdlJwYSsw?=
 =?utf-8?B?ZVhiUTBpaytIUjdNK1hhaVN4aDBQRE9FOHcrVS90eUpCWDI1QWdNVFBBeXVH?=
 =?utf-8?B?R0oyNmxWUUNUSWQxbmNkZDNJQnUrQ0ExaEM3dU5Ud2IrQzdRRWJMdm0yVkNZ?=
 =?utf-8?B?TDhvZlI4STRGejBOWjFld0ZiVDZOakJaNDRNWlptVEsxTytZQ3c3Nm0zU25o?=
 =?utf-8?Q?2ByemcliOVrr4k9/7ecCAY1cCSVfz7hW4cgbPDxlk+j7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e651a169-2756-41ea-7a07-08da8c2086fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 13:47:35.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3WXZCwZTKRHdrMs2ujfrIpmRJ3zJ8zOQRT060NwXHJZ9T8CCLzPmRlJAoXyvXtfm6DlkK/TpPQpsFCADcaUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4707
X-Proofpoint-GUID: zd8nbuMGvfUjy0DfbWzFugaxtslmVCVZ
X-Proofpoint-ORIG-GUID: zd8nbuMGvfUjy0DfbWzFugaxtslmVCVZ
Subject: RE:  [PATCH v2] RDMA/siw: Pass a pointer to virt_to_page()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgMSBTZXB0ZW1iZXIg
MjAyMiAxNTozMQ0KPiBUbzogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IExlb24g
Um9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+Ow0KPiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6
dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBMaW51cyBX
YWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
W1BBVENIIHYyXSBSRE1BL3NpdzogUGFzcyBhIHBvaW50ZXIgdG8gdmlydF90b19wYWdlKCkNCj4g
DQo+IEZ1bmN0aW9ucyB0aGF0IHdvcmsgb24gYSBwb2ludGVyIHRvIHZpcnR1YWwgbWVtb3J5IHN1
Y2ggYXMNCj4gdmlydF90b19wZm4oKSBhbmQgdXNlcnMgb2YgdGhhdCBmdW5jdGlvbiBzdWNoIGFz
DQo+IHZpcnRfdG9fcGFnZSgpIGFyZSBzdXBwb3NlZCB0byBwYXNzIGEgcG9pbnRlciB0byB2aXJ0
dWFsDQo+IG1lbW9yeSwgaWRlYWxseSBhICh2b2lkICopIG9yIG90aGVyIHBvaW50ZXIuIEhvd2V2
ZXIgc2luY2UNCj4gbWFueSBhcmNoaXRlY3R1cmVzIGltcGxlbWVudCB2aXJ0X3RvX3BmbigpIGFz
IGEgbWFjcm8sDQo+IHRoaXMgZnVuY3Rpb24gYmVjb21lcyBwb2x5bW9ycGhpYyBhbmQgYWNjZXB0
cyBib3RoIGENCj4gKHVuc2lnbmVkIGxvbmcpIGFuZCBhICh2b2lkICopLg0KPiANCj4gSWYgd2Ug
aW5zdGVhZCBpbXBsZW1lbnQgYSBwcm9wZXIgdmlydF90b19wZm4odm9pZCAqYWRkcikNCj4gZnVu
Y3Rpb24gdGhlIGZvbGxvd2luZyBoYXBwZW5zIChvY2N1cnJlZCBvbiBhcmNoL2FybSk6DQo+IA0K
PiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jOjMyOjIzOiB3YXJuaW5nOiBp
bmNvbXBhdGlibGUNCj4gICBpbnRlZ2VyIHRvIHBvaW50ZXIgY29udmVyc2lvbiBwYXNzaW5nICdk
bWFfYWRkcl90JyAoYWthICd1bnNpZ25lZCBpbnQnKQ0KPiAgIHRvIHBhcmFtZXRlciBvZiB0eXBl
ICdjb25zdCB2b2lkIConIFstV2ludC1jb252ZXJzaW9uXQ0KPiBkcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd19xcF90eC5jOjMyOjM3OiB3YXJuaW5nOiBwYXNzaW5nIGFyZ3VtZW50DQo+ICAg
MSBvZiAndmlydF90b19wZm4nIG1ha2VzIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBj
YXN0DQo+ICAgWy1XaW50LWNvbnZlcnNpb25dDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcv
c2l3X3FwX3R4LmM6NTM4OjM2OiB3YXJuaW5nOiBpbmNvbXBhdGlibGUNCj4gICBpbnRlZ2VyIHRv
IHBvaW50ZXIgY29udmVyc2lvbiBwYXNzaW5nICd1bnNpZ25lZCBsb25nIGxvbmcnDQo+ICAgdG8g
cGFyYW1ldGVyIG9mIHR5cGUgJ2NvbnN0IHZvaWQgKicgWy1XaW50LWNvbnZlcnNpb25dDQo+IA0K
PiBGaXggdGhpcyB3aXRoIGFuIGV4cGxpY2l0IGNhc3QuIEluIG9uZSBjYXNlIHdoZXJlIHRoZSBT
SVcNCj4gU0dFIHVzZXMgYW4gdW5hbGlnbmVkIHU2NCB3ZSBuZWVkIGEgZG91YmxlIGNhc3QgbW9k
aWZ5aW5nIHRoZQ0KPiB2aXJ0dWFsIGFkZHJlc3MgKHZhKSB0byBhIHBsYXRmb3JtLXNwZWNpZmlj
IHVpbnRwdHJfdCBiZWZvcmUNCj4gY2FzdGluZyB0byBhICh2b2lkICopLg0KPiANCj4gQ2M6IGxp
bnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IExpbnVzIFdhbGxlaWog
PGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gLS0tDQo+IENoYW5nZUxvZyB2MS0+djI6DQo+
IC0gQ2hhbmdlIHRoZSBsb2NhbCB2YSB2YXJpYWJsZSB0byBiZSB1aW50cHRyX3QsIGF2b2lkaW5n
DQo+ICAgZG91YmxlIGNhc3RzIGluIHR3byBzcG90cy4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19xcF90eC5jIHwgMTggKysrKysrKysrKysrKystLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+IGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiBpbmRleCAxZjRlNjAyNTc3MDAuLjdk
NDdiNTIxMDcwYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
cXBfdHguYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+
IEBAIC0yOSw3ICsyOSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqc2l3X2dldF9wYmxwYWdlKHN0
cnVjdCBzaXdfbWVtICptZW0sDQo+IHU2NCBhZGRyLCBpbnQgKmlkeCkNCj4gIAlkbWFfYWRkcl90
IHBhZGRyID0gc2l3X3BibF9nZXRfYnVmZmVyKHBibCwgb2Zmc2V0LCBOVUxMLCBpZHgpOw0KPiAN
Cj4gIAlpZiAocGFkZHIpDQo+IC0JCXJldHVybiB2aXJ0X3RvX3BhZ2UocGFkZHIpOw0KPiArCQly
ZXR1cm4gdmlydF90b19wYWdlKCh2b2lkICopcGFkZHIpOw0KPiANCj4gIAlyZXR1cm4gTlVMTDsN
Cj4gIH0NCj4gQEAgLTUzMywxMyArNTMzLDIzIEBAIHN0YXRpYyBpbnQgc2l3X3R4X2hkdChzdHJ1
Y3Qgc2l3X2l3YXJwX3R4ICpjX3R4LA0KPiBzdHJ1Y3Qgc29ja2V0ICpzKQ0KPiAgCQkJCQlrdW5t
YXBfbG9jYWwoa2FkZHIpOw0KPiAgCQkJCX0NCj4gIAkJCX0gZWxzZSB7DQo+IC0JCQkJdTY0IHZh
ID0gc2dlLT5sYWRkciArIHNnZV9vZmY7DQo+ICsJCQkJLyoNCj4gKwkJCQkgKiBDYXN0IHRvIGFu
IHVpbnRwdHJfdCB0byBwcmVzZXJ2ZSBhbGwgNjQgYml0cw0KPiArCQkJCSAqIGluIHNnZS0+bGFk
ZHIuDQo+ICsJCQkJICovDQo+ICsJCQkJdWludHB0cl90IHZhID0gKHVpbnRwdHJfdCkoc2dlLT5s
YWRkciArIHNnZV9vZmYpOw0KPiANCj4gLQkJCQlwYWdlX2FycmF5W3NlZ10gPSB2aXJ0X3RvX3Bh
Z2UodmEgJiBQQUdFX01BU0spOw0KPiArCQkJCS8qDQo+ICsJCQkJICogdmlydF90b19wYWdlKCkg
dGFrZXMgYSAodm9pZCAqKSBwb2ludGVyDQo+ICsJCQkJICogc28gY2FzdCB0byBhICh2b2lkICop
IG1lYW5pbmcgaXQgd2lsbCBiZSA2NA0KPiArCQkJCSAqIGJpdHMgb24gYSA2NCBiaXQgcGxhdGZv
cm0gYW5kIDMyIGJpdHMgb24gYQ0KPiArCQkJCSAqIDMyIGJpdCBwbGF0Zm9ybS4NCj4gKwkJCQkg
Ki8NCj4gKwkJCQlwYWdlX2FycmF5W3NlZ10gPSB2aXJ0X3RvX3BhZ2UoKHZvaWQgKikodmEgJg0K
PiBQQUdFX01BU0spKTsNCj4gIAkJCQlpZiAoZG9fY3JjKQ0KPiAgCQkJCQljcnlwdG9fc2hhc2hf
dXBkYXRlKA0KPiAgCQkJCQkJY190eC0+bXBhX2NyY19oZCwNCj4gLQkJCQkJCSh2b2lkICopKHVp
bnRwdHJfdCl2YSwNCj4gKwkJCQkJCSh2b2lkICopdmEsDQo+ICAJCQkJCQlwbGVuKTsNCj4gIAkJ
CX0NCj4gDQo+IC0tDQo+IDIuMzcuMg0KDQpUaGFua3MgTGludXMhIENvZGUgbG9va3MgZ29vZCB0
byBtZS4gRm9yIGEgZGVjZW50IHBhdGNoLA0KYWRkIGEgRml4ZXMgbGluZSBhbmQgcmVzZW5kLiBJ
dCBmaXhlcyBjb21taXQNCmI5YmU2ZjE4Y2Y5ZSByZG1hL3NpdzogdHJhbnNtaXQgcGF0aC4NCg0K
SSBhbHNvIGZvdW5kIHRoZSBkZXNjcmlwdGlvbiBvZiB3aGF0IHlvdXIgcGF0Y2ggZG9lcw0KYSBs
aXR0bGUgdG8gdmVyYm9zZSwgYnV0IHRoYXQgaXMgbWF5YmUganVzdCBteSB0YXN0ZSwNCnByZWZl
cnJpbmcgYSB2ZXJ5IGNyaXNwIGFuZCBzaG9ydCBkZXNjcmlwdGlvbiA7KQ0KDQpUaGFua3MsDQpC
ZXJuYXJkLg0K
