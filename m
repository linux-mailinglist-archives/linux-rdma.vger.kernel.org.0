Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D563965C3B6
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjACQTW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 11:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjACQTO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 11:19:14 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D21A0
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 08:19:13 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303FvUFA025176;
        Tue, 3 Jan 2023 16:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wvzKziIKQuEUPoBiQaM/BnMr9N4EGfol9P+rxyLP6TA=;
 b=WAghaZ2RQAIvlsgpvTVAOdzeOaFdiZXBfh4drHrrwP3mUoi2CNg0bHsSNN31ROA/TBPj
 r4J3mfMsYl/jEZYPlIkM4/W40YetbUGNpY6Dz4dBk1sqGthCPTRpkTDn7dG7/24UdFwk
 y2WXdVupJIIYnoNWGHxGNMKUF9ZFrW0X/axwPxh4CBL/ntM+Csae7gjXh1rvDA56z5LH
 dxpc0TTnifoIV0/8YGIDIDOub5Hrt3YnyS6Yt819En014Wgew7ZDmTZQC7HfI7+zA6jP
 465homwlCSNYt7osdNk8RFfAYhcfhkXIQJpWS0sTeYCkPZ8iaTWPxK1l6L+KA/HkCXzn +g== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjveyp15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxMUxfDqyEracjf5Lf9SAfsJfnk7nwp0ZKTHwpXAZ59Y1I2qfn6vKg6FbP9igcH81dvdoIm1w9eQOpuSnQu1K86LIRzibcFOWjZt9ErinlPTSspJ4C3n/4KagLThixZuostnjPkmO7cddl8+l1ROlvUPoyYZ/e6Eu2REvaVSkZ/yV8G8qvAa1N+vF60WdLmIo3YrswJLQLfdPa6noaQ3LiVnoyvGdwaFDB1U6iZIcKsU1b729L2jXyFSlqTdkH9GQ4PYeZ+9hgVGg1+NHjru91bRzoL7SVAsKNHwqARTYWPf3kGxzE3u5K7fmUorqZWEfygSx3S0FBprGikD25/MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvzKziIKQuEUPoBiQaM/BnMr9N4EGfol9P+rxyLP6TA=;
 b=dOSIDRJn2gdb2+KW8RMIQ87EkwxHuxYScs2tr9LzKux/nVmcPXuniJl4Vqu+rU095rOk3vrY79QHkvk7ekkbWrwtv8VhIb9EmFAkm+foNPbbxjQiLdTQSrHtSFTLs4R0ZGsKq9888PVpbTKfZdv3n973UTNh0R750X/umfcnvqcObPkGcNxXMQFbzuQ0Mk1CxuasA6dlmCfQr4/AgUyMStqcrczXW71bL1AXJHxRIoX2MdCoX4v5Phy17wgoVYUdxenCjrloKSNEve6RXaX1H2a5walBN8RxQ37qnKDYVw+ps0JUqVAkclCBSW5pvh+8sGS4itvTtuiCdfosUK1WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by PH0PR15MB4720.namprd15.prod.outlook.com (2603:10b6:510:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:19:07 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:19:07 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
Subject: RE: Re: Re: [PATCH] RDMA/siw: Fix missing permission check in user
 buffer registration
Thread-Topic: Re: Re: [PATCH] RDMA/siw: Fix missing permission check in user
 buffer registration
Thread-Index: AQHZH48aohXrGt83M0WbFBy6u47KNA==
Date:   Tue, 3 Jan 2023 16:19:07 +0000
Message-ID: <SA0PR15MB3919775F88638972E8C700B899F49@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
 <Y5y6OaG4+6kPt9O5@nvidia.com>
 <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y5zRR4KbAFOFIvpU@nvidia.com>
 <SA0PR15MB3919266C672961F49B28C7A499EA9@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y7QopYj1p4eeLo5N@nvidia.com>
 <SA0PR15MB39196C05636860B60263FF3599F49@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y7Q4bZqvDWeDNE/m@nvidia.com>
In-Reply-To: <Y7Q4bZqvDWeDNE/m@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|PH0PR15MB4720:EE_
x-ms-office365-filtering-correlation-id: 04392f21-aaca-492a-010e-08daeda63d14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWMXgr0BXi12qVK5fsPVqvjeTiZQ58pEbIjvyBT4tnh38q3wFmhU/tq/2B5SlvXcEVf6FMjN25HzOTNs8b6TZMemfZGEy3JDSqMRxp4CsF/e8QIyZq7xaDsM5GyCxsfBrXPhArBQprJaqPKhiokmuADXtSKb0KlefgwMH2J3mgxjDMgh63Fo9SRZPqzf320CAuuK1peZM/Wu+qwRViv+N50pEw0lwy1flhhQ0x+3V9ukDMw88U85I55M3Lcip7L7R5w8+LOzWFZqFjuimA1xVKVI7uUILdWP1pSPYbcO3IaKAnW3pvhzpHRxaz8EFm9sewc5lVDiBMtN/XFjJAMPi0zSp8QTEpS8IUP/yIWKw3POVZMCFnqJrLcs4hZ9Pw393iexA75+IyTNFRb/r27O7mdg4M+khM31H1RImjvkfMhzaUfrh926XJTefT8RnXowChv6bQX4AomvdZ7whDU8N27ecZYzyF11K1D2GgtHeuSLnKClZjio7NEkRRXpyjjZHY48M5Bsco1eRsTpe9DE7kfxRF6osFyYjDrF8o2tWmF3IYCBQNwDhFZVR4bFTVMYqpC/p2EWvYZvdH7D7Y9SeSry0Q5FA1KBOxQJxxcP2dU9LFSks2yrEiLd/ggTEX0AhzAY3y5rEsELACIJA7qDNLqRhqK6Lg1SLd0wlG51/WQNVaImpchwsd7Vm3p2pQwF9x+5AjXQwbr9pZ9sF97ekH2ZFmPZNttEycew/ErkSvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(38070700005)(122000001)(38100700002)(33656002)(55016003)(86362001)(7696005)(64756008)(6916009)(53546011)(66446008)(6506007)(66476007)(478600001)(9686003)(66556008)(76116006)(186003)(71200400001)(316002)(54906003)(8676002)(66946007)(2906002)(52536014)(41300700001)(4326008)(8936002)(83380400001)(5660300002)(22166006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anVxMHRvK2dzUlNWQjNUUTdnUXUvVm5oT3FjSDJ0c0xJdm5pZUM0UkRNN1Vv?=
 =?utf-8?B?bXBRQ1RpTEU1ekJOZ2t4djRGQ0U5RDg4YXYrOTFCa2R3dWtVZjB0K28vYTNK?=
 =?utf-8?B?Q0krdmR2QWxOTDI3RmthUjV2QTduc1dkZnJUbUFxK3IrbVNrUkdKYnB1WDU4?=
 =?utf-8?B?WHMyelRTRGdTQWFZZTQySEFCbUpLOEc1RWdMU2NmbnRlT09wN3R3UjIwQmdV?=
 =?utf-8?B?OWVtL0JLbmdzbXlaa2xLQmx5Q3BYbElpM29Ta1FTQXRYbzJSVjI1Rms0TFVm?=
 =?utf-8?B?UHd4NlVzYnpTV3NTYVZDUHVRdFJKRlF1dXF5K3diK0daUkhVeDZwQkNYOVNj?=
 =?utf-8?B?ZGdCUms5RXpaVXBZUFVtblBLNnFPWjduMXgrVHdEWktyQzNOWnJaWUNVNEFQ?=
 =?utf-8?B?M3BmK3djY0pUcEd4eXlVNkk4UEtnUGxjbmhCU2Q1U3UyNVo5MGVYR0RpV0Rr?=
 =?utf-8?B?RWluQjVDS2c2a2pFUjZsL2NoTEtITmt3dE5DdVQyWndieWpXVzdrZVM4dmt1?=
 =?utf-8?B?NXBiaEZsd2dCeEIrUGtCb3M5OTdvUXNsbDdlaXNkeHFzQ0ZBMDk0SVlmNTRK?=
 =?utf-8?B?TGhRMjlFcFBIeUlha1hEcGhLRXErNGYwRU94RkVIUCt6MHN3U3NnVjlOQWVS?=
 =?utf-8?B?ekpXb0RXdzFXZDJpV1pyNm9peEhQeE5aMWZnZTFLc3pMK3o0ZEZ3MGZyekhM?=
 =?utf-8?B?b25ZQjhWMkxFTkM2Z3F1bTF3cnlYTlIxWElFNy83RVhrbjExRXc0RGdIMEZD?=
 =?utf-8?B?UHpCOTBxVmMrVEtRNEdDbjRMU2l3Q016eC9JVTMvdll0UXlNYmtoNUo4d1VT?=
 =?utf-8?B?UUxXZTBkNmpKZ05qVUJvS2RNY0MzbElGeExYa0Rwa1ZkTEdSZ2hBVWREcnhz?=
 =?utf-8?B?Mlg3QXk5eGZMOHQrRVE0UjM3OVRjb1ZVY09yK20wRUpsNTlOSWhuME83NHB6?=
 =?utf-8?B?eGVQL01Ka2JzL2lTb1ErRkpwU05lMzRlSlBpMFJjaWpCMWd6MVJ2UlV5SUVW?=
 =?utf-8?B?NVFYZGxYTU9ENDREZnNINU1DU1p0eXVkSk9TMC9qSGVtU0pvRCtqWVdEbWV0?=
 =?utf-8?B?cnFIN0NnR3U3Z256NUEvMUJOck5ZRTYvMG0xdGxZV1lVUEVleVgwN284b3VR?=
 =?utf-8?B?Rk0yQkJ0bHgySStpRWdIQXl0Ny9laHg1d1pUNG9rUjNCWFp0dUtwQUNvYXA4?=
 =?utf-8?B?RE9JcEUvK0dIK2ZXcFlOSm5YNWFIajd2MW5GbUdhcVJmK0xOSENadHFxdVdL?=
 =?utf-8?B?RVZrVS8xenRSZGRHOW53RVZsTDd5clVNUEJnWnhQNUJVNHlPc21JWGZCZjRo?=
 =?utf-8?B?WlZjejBadkhZSjlMWUV6eE14VjNSdmNHbkNQSHNZenNIYnpQUTE3MkYxWGFw?=
 =?utf-8?B?OVhUTzJPbk5FMGUyT2Fidlo1Y2RmL0lIVjdYQTBaOEtrQ21VTklFS1pCTTUv?=
 =?utf-8?B?a3RTMEl5cFFramhUUTRJeHcvQW9PWUtXVGh1Q0NvNlhQZi9xRnQwampYRXhV?=
 =?utf-8?B?N3FvV1pxYUEweUVhbGVsa0RIdWVSbFV5LzRmTlNqSm0zVlFVc0VTLyt1MXRI?=
 =?utf-8?B?aUYzdWxxeDZyTEVxUkhTZVBtL1cvVUNrWWVWN1lpb21ZaEw1Kzl6NDJTK2Ns?=
 =?utf-8?B?YncyckphZnlidWtqclFsZnFXSzZTd082SW5odi9jNE13L0NnZGVTamxlcXhF?=
 =?utf-8?B?ZkNBQk92Y1NFMzZJK3RzSnlNQS9EM25UUHBiaVlWMkl0RlFkMlI0Ti9qdTJa?=
 =?utf-8?B?cVlEcWR4Q0kzZ2JpZ2dSVklFT01CLzRHalluRVZIeTNua1pxQlp3eHlZWDFt?=
 =?utf-8?B?c0Y5SkRVWHBERklFVS9CYXBZTks0eEw5dHZNNy9wZW9vN0JyQUpueVd3c3J5?=
 =?utf-8?B?bXJNbDhTWHpJSXV3RkpwUzNGNk5rbnk3ODF3Z2s2SDBZS2tpM2xCMG4zVnRT?=
 =?utf-8?B?VmJDTW8vK05zVmZQb3JnRzVoWGVwM0t0bWVlQk9qN3pUQldTY25pbllqNURj?=
 =?utf-8?B?L3NsVHdPVW5PV3NadU0rMEVVMWhLSVExVDNTSjVhbVBzUWc2cTVYaHlCZms3?=
 =?utf-8?B?NDRlREM2c3Yrd0lFN21Md0g0dTlxeWpWL00xZExxV0QvWnB2VHhCVTVnellN?=
 =?utf-8?B?SE1UWUxVa055VE5WQStXWXF3SVQ3cU1QbVR5QmppV1dFNCtQdWhYNldralYw?=
 =?utf-8?Q?8oVqgXs9MfUyG+t30yDtsxM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04392f21-aaca-492a-010e-08daeda63d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 16:19:07.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAkMWeEcfsqon+7NCHKp6dHm+FPg1bpxl52xX4kM5hOluu6lbbISEicugcfFWrUEaUfeWW795oZxV0jBq8hLhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4720
X-Proofpoint-ORIG-GUID: rd1V2FAGnUZkKdS1UeZeoJnGc6eVRuoQ
X-Proofpoint-GUID: rd1V2FAGnUZkKdS1UeZeoJnGc6eVRuoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=855
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMyBKYW51YXJ5IDIwMjMgMTU6MTUN
Cj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogbGludXgt
cmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxlb25yb0BudmlkaWEuY29tOw0KPiBEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBSZTogW1BBVENIXSBSRE1BL3Np
dzogRml4IG1pc3NpbmcgcGVybWlzc2lvbg0KPiBjaGVjayBpbiB1c2VyIGJ1ZmZlciByZWdpc3Ry
YXRpb24NCj4gDQo+IE9uIFR1ZSwgSmFuIDAzLCAyMDIzIGF0IDAyOjExOjE5UE0gKzAwMDAsIEJl
cm5hcmQgTWV0emxlciB3cm90ZToNCj4gPiBPaCBvaywgdGhhbmtzLiBJdCBpcyBwcm9iYWJseSBm
aW5kX3ZtYSgpIGZ1cnRoZXIgZG93biB0aGUgY2FsbA0KPiA+IHdoaWNoIG1ha2VzIHN1cmUgdGhl
IGFkZHJlc3MgaXMgdmFsaWQgZm9yIHRoZSB1c2VyIGNvbnRleHQuIEkNCj4gPiB0cmllZCByZXNl
cnZpbmcgYm9ndXMgdXNlciBtZW1vcnkgd2l0aCBzaXcgYW5kIGluZGVlZCBnZXQgdGhlDQo+ID4g
cmlnaHQgZmFpbHVyZSBmcm9tIHRyeWluZyB0byBwaW4gaXQuDQo+IA0KPiBXaHkgaXNuJ3QgdGhp
cyB1c2luZyBhIG5vcm1hbCB1bWVtIHdoaWNoIGRvZXMgYWxsIHRoaXMgZm9yIHlvdT8NCj4gDQo+
IEphc29uDQoNCnNpdyBhcyBhIHNvZnR3YXJlIG9ubHkgZHJpdmVycyBzaXRzIG9uIHRvcCBvZiBU
Q1Agc29ja2V0cw0KYW5kIGp1c3Qgd2FudHMgdG8gcmVhZCBhbmQgd3JpdGUgZnJvbS90byBwYWdl
cy4gRm9yIGVmZmljaWVuY3kNCmluIHN0YXJ0aW5nL3Jlc3VtaW5nIHNlbmRpbmcgb3IgcmVjZWl2
aW5nLCBpdCBiZW5lZml0cyBmcm9tDQphIHNpbXBsZSBtZWNoYW5pc20gdG8gZ2V0IHRoZSByaWdo
dCBwYWdlIG9mIGEgcmVnaXN0ZXJlZCBtZW0NCnJlZ2lvbiBhcyBxdWljayBhcyBwb3NzaWJsZS4g
U28gaXQga2VlcHMgdGhlIHBhZ2VzIG9mIGEgbWVtb3J5DQpyZWdpb24gaW4gYSB0d28gZGltZW5z
aW9uYWwgYXJyYXksIGluZGV4YWJsZSB3aXRoIHZlcnkgc2ltcGxlDQphcml0aG1ldGljIC0gc2Vl
IHNpd19nZXRfdXBhZ2UoKS4gaWJfdW1lbV9nZXQoKSBwcm92aWRlcw0KYSBzY2F0dGVybGlzdCBv
ZiBwYWdlcywgd2hpY2ggYSBzdyBwcm92aWRlciB3b3VsZCBoYXZlDQp0byB0cmF2ZXJzZSBsaW5l
YXJseSBvbiB0aGUgZmFzdCBwYXRoIHRvIGdldCB0byB0aGUgcmlnaHQgcGFnZQ0KdG8gcmVhZC93
cml0ZS4gc2l3IGFscyBkb2VzIG5vdCBjYXJlIGFib3V0IGRtYSBhZGRyZXNzZXMuDQpJIHNlZSBv
dGhlciBkcml2ZXJzLCBzdWNoIGFzIGhmaSBvciBxaWIsIHdoaWNoIGFsc28gZG8gbm90DQp1c2Ug
aWJfdW1lbV9nZXQoKS4NCnNpdyBjb3VsZCBvZiBjb3Vyc2UgdXNlIGliX3VtZW1fZ2V0KCkgZmly
c3QgdG8gZ2V0IGENCnNjYXR0ZXJsaXN0IG9mIHBpbm5lZCBwYWdlcyBhbmQgdHJhbnNsYXRlIHRo
aXMgaW50byBhbiBpbmRleGFibGUNCmludGVybmFsIHByZXNlbnRhdGlvbiBvZiBwYWdlcywgYnV0
IEkgY29uc2lkZXJlZCB0aGlzIGFuDQp1bmFjY2VwdGFibGUgd2FzdGUgb2Yga2VybmVsIHJlc291
cmNlcy4NCg0KQmVybmFyZC4NCg==
