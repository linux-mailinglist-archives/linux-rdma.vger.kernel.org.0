Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CDD6521C8
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Dec 2022 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiLTNww (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 08:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiLTNwv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 08:52:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518B1AF04
        for <linux-rdma@vger.kernel.org>; Tue, 20 Dec 2022 05:52:49 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKDQgJt006489;
        Tue, 20 Dec 2022 13:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PcQ+KK4TTfYMvIFSXWzrpA+1Su1Itaz3gz93ZAtdOyM=;
 b=mxcx4o3I8qcrxykm2RfI2PMogHUsUhUWpn+yYcV6PxdOxj6PP8KQCCkPg3vuekNADBaT
 tlVRuKgJrA9Rjod4zXIm0oylNhI/leH9+gKsL0Fxmo1vfm60e5nGKM0qHXa4dRuk7zmk
 n4kwwKwlLiWnfOdx6XBJamW7rZ2VGo5c2X0Ij94BhT354VzwXTq6LP14/OL5Vdz0AsRn
 SU5HdwZs4lpJ0fJYk09QoGQbsR8L5X5OSEkP59OZ7WYZL0BnWJMqbM6N9G44aoepXj5E
 FVAKKa/5ReqOJdgYImnvQWBoNYTQI5sp7m4PHfaAjLQOcoDQyDF13t7p1OOFio/4AI9t Pg== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mkdxhh1gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 13:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlrYc8oszvY7NOPYvLGD2AD1ncEUB4VcnNoFl1zx5n0RTBfjCLoaRmL85YJkzoY1ZyKAl1ajR0/oVh3oQKa8m+9NufMv1K0TZxfjxqEwcL0QBVrplRPjraMB1lRMyNpqDbz3e0eYCLgbm1zL0lyyRW4u+zG9v/fAc8y8wVQnQDb0iBBdaVmAOF+wx1QAX74MRbbvFnbt3ao/6w/y18a6jQxPzWEkGhU+8pPPLD6Mf2XgLtYxPFUUbxU/ei5U7+Fj4WeKgx77XQQxN8M+3BvqLuluR7cNiMFOfI3cXMhl2VvwB0maZs3vSnT6emDF0Lrqh7Qj0FoZehSRYnb4RnpXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcQ+KK4TTfYMvIFSXWzrpA+1Su1Itaz3gz93ZAtdOyM=;
 b=eW/OkcLHkBz6RpmrnF0loFkodWlpXvodeqt8uQlbpnaiEly2q/97iLilGNq9qd8gktatAd7oTDgcRBdUmP67a5l8nPzak0pDLaiYp7dL/2NyTX1iqNCVQuZyNkDDzybepGxuVyKhOow809oFQsPZ0FXEmcsNgSmDCguiy4lW0dcQeQVnuQubphnk10rT1XH2eR1zlX4zTsOLt2S0D71lKWHTVoF4XXz0ruhIImVBVPb0v70F1TffBICroez+HUzfUPrqJ6Ac07EgDzuB4UJEpoodni4f+H0nkzlCVxmZFByQOR7I2ZLa+ZH/9dwRpJtcWgulL6TAJ0WJE7DiZc4h+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by CY4PR15MB1528.namprd15.prod.outlook.com (2603:10b6:903:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 13:52:43 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%5]) with mapi id 15.20.5924.012; Tue, 20 Dec 2022
 13:52:43 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
Subject: RE: Re: [PATCH] RDMA/siw: Fix missing permission check in user buffer
 registration
Thread-Topic: Re: [PATCH] RDMA/siw: Fix missing permission check in user
 buffer registration
Thread-Index: AQHZFHpVHTtYK/Rev0KRs40pmkXpwg==
Date:   Tue, 20 Dec 2022 13:52:43 +0000
Message-ID: <SA0PR15MB3919266C672961F49B28C7A499EA9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
 <Y5y6OaG4+6kPt9O5@nvidia.com>
 <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y5zRR4KbAFOFIvpU@nvidia.com>
In-Reply-To: <Y5zRR4KbAFOFIvpU@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|CY4PR15MB1528:EE_
x-ms-office365-filtering-correlation-id: fb248910-6419-4a06-f280-08dae29177ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bHv+qsi2YL2rEH4I3bYyue6qIM8EXJZW4b4wHjI2fUcbqu/MJxqeWkjq11daEG3RSd3Gx2RcjIAe89iFgoiJN1f66mv7Etd80mNRS6cJOWNSWNJ1xNKVQAZVpjkWUufsybcYhEX226dAfOH8PCHSBiElTq8zWtUT8bNZEVeeaTeMK1GtarOveRZZnDQPtiNqFsWRXwLKVfQpfJsQGLaCHCDz/MtHnDd0duxiUlfu0MIHJPrzKHKnCamK5t3pv+raoDPq2RPd83h6r3ufFyYU4Veb7x/fpiRpvLYV/ZojLBijERjHuVFmH20KtNxUEmmFW5E/P5iZdLyfaLANLqCuoH3BP/uNVVwWz+RTNp34GYdZwd34g7WEbwi6YXwqHRTiHyFq87L8jFdiIVnnmvupzY7vqziOFIH/USteLIlQK8sazA4yZch1R4QgQ+BSVuKB24r89ckq5gdI8IfSmJQjkf2JK81tlbY1bpQhpU6iUFBNqZjgavbci6DzJ0nSbJst3CiDqwCIYtrJJnThF+23a4TJhD4fsNfa8mZIpVCAsyO7qKMRou/zquJYUHLs3jUuPeHGzQwVsnR10ItX3PM+6JP6jPYv6f6ApywY3a4tYoOiGxm5r1U/c9AxEH+7WcT45LbVbd6DJUvpujTmfFGLSuCJ5NjpTiI5pZCgNSOzubAa+eAzCSTsOewqAosmDkXUDU+FkUWQ6y7+UiPlaupQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(2906002)(38100700002)(122000001)(38070700005)(5660300002)(52536014)(83380400001)(41300700001)(55016003)(66446008)(64756008)(66556008)(8676002)(66946007)(66476007)(76116006)(316002)(4326008)(8936002)(53546011)(6916009)(9686003)(186003)(86362001)(54906003)(478600001)(33656002)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1hxamlCQmNzTWNpVUhhQkVTNEpxQ3FuWGlLVFlBek9IZlFNTkpucTYvK0xZ?=
 =?utf-8?B?NGZRVmIxZlZHT25lTVF6eFVSWWx1dHIwU3VuYXVaMEE2SktRSGFQN2hzbjRW?=
 =?utf-8?B?NVluWG1hcUhtVzdwazhsV0dISFdISFVqUGRBL3RjN2cxaURZMVp1MzN1Y01s?=
 =?utf-8?B?SlRnYnhwSnYzVVRZNGt6TW9BOGhnNVVIWWszU0QvRi93ZWxTaVV3WXRBTnRI?=
 =?utf-8?B?RlpYS0ZpL1FiNC81c2NCNjBLU25vNXlkOTlYb0ZLTTVrQnlzbENCb0c0SlYw?=
 =?utf-8?B?bmpORzRsUEMwOEJmaitPRzJhWUxLS2tSeGtsWDhNbTdwWVlCd0REYUZ1d1pZ?=
 =?utf-8?B?MjNHQmFBS0xKOHVQYkd6RTkrSHNqWkxpSS9aZmdWenZlWnNoZXJodko5MnEx?=
 =?utf-8?B?Z3lRa0xBUkVzSFM0MzRvRXZQZkR3V0pmek81VXJORWdzd1EzS21iY2poOFFq?=
 =?utf-8?B?akJjaWNtbmUxMThWK2NZSjBuSVJUWEs4YUpUMGZnbkJ5Skx2dUZOSWNLUnVx?=
 =?utf-8?B?M0NxcmVSV2czYThnaTlWa2JXL1hoaHpkM2dtL2swcGlkTzdHL3RFNmdMVXpX?=
 =?utf-8?B?Wlhmd1dLQ25tc2tVekZDbGlNbWN2dkZwZ1dEb29CMFpZVEs4cUhSWkJOTEdZ?=
 =?utf-8?B?SWtHRjRPTkppNlpXcTc3OUt4TGdJMkxrc1pKc2JhbGtnQVVXdkg0bEtJTHk3?=
 =?utf-8?B?bnRqd3Via0RySUdpL0ZBN1FGUUZOM1hiK0h5UVBJTCt1NWYrTjdQbS8zcFlY?=
 =?utf-8?B?dGJOMkduQ091Q0xPWWpRQVlrVE5zdjg1bjQrNnZkdUY0QlZvK0E3ekpkQkNi?=
 =?utf-8?B?Q1BGbC9ZSzhCaHAwcjFqdHUxd2drTFpuR0M3L2xxT1NlcjZYSGxhbUVFamVa?=
 =?utf-8?B?R2FIQjlSaE9ZV2tUeGRFQTlZaHpycGhVZUVqK1NQbVFjU1hEMU1YVytrMXhU?=
 =?utf-8?B?Y1dwb0pPdFRON0hwaENMTkFWcDd6S0s1K0RMcmladlk3Tmg3a1ZncTVNL090?=
 =?utf-8?B?S2NVS0RLOW5aWDZzbkFCYkRTYVY1Y04wVlpOcXo1UzBkbEtmVHIxUzIzenN2?=
 =?utf-8?B?ZEFLc2ZuQW5PbWdWTnB6K1VBb1FZRTFJM3ZtOU5hT3E4aE1VWnRoRThtRjI2?=
 =?utf-8?B?eEsyWUFMSnJSSERxNzNzYzF2NHRyWFluaTdBTDVoNklKbXRGaFZ0d00wbDJP?=
 =?utf-8?B?SzNoSVJWQ0JlbHpiMytPdHk0aHJaM1FHYm9wRE5scm1KUHpiR2pibGRnWFQw?=
 =?utf-8?B?dmx3ZXM3bDZSOU54ZDYrN3VUaEZHNDBUOHhsNG9uMk0vOXBXUWsyVEJYQ1A1?=
 =?utf-8?B?SkROZVZIZGc3enFka0xBL1I2VHdSbHNSUU94bXY3WnJhNVgweEdCa1VZTWdU?=
 =?utf-8?B?WlJ3SldlQmNha1U0L2xtR1pIZDA1Y3o1TzlYekpCTmVYSVExSnlnbUtmOXdI?=
 =?utf-8?B?dmFnVjlWWEdudWxaeXNIRzlWTGthZEw5UmVZaEljWVFkT0hnTDdxTDVRL2V0?=
 =?utf-8?B?SlFqU3ZJb2tldUVSVlY3c29OMjdrS1Q4RXVnMmRyMWtxUFNsVWh5SUNkNHcr?=
 =?utf-8?B?dzJGNng5aFdvYlpsTEtFVTlhM3FmRzhOaXFVK09wNlJ1cS9wWG0zeUNQa3Mz?=
 =?utf-8?B?cG1HTEYrWjBKbTNwd0pHVmc1cSs3eFZNR3AvR0cwMVNVRW1XUkZ5TGxTUUVU?=
 =?utf-8?B?Y0pBZVN6c2hNdW1aNkUzY29QMVhjU1NEdE95MmF6OXpCdmRYMTBWWWJFSHdw?=
 =?utf-8?B?NmNjc3BIRDN5Z0pjRVpkbkpKbVQzOUw5eENmSXE0T0IrOUR1VHpsSG9YRDRx?=
 =?utf-8?B?NFMzSHlseG9pRGNzK1ZUWWNZTzdoQmRHQ1RBelFCZE8rUjRWS2I3VWluZ0hW?=
 =?utf-8?B?RjhMcksrbG1wZG9xTk1LN2FOZjFnKzhoTHNtOFo5dWV2OTBYU2N0SFB5WlNJ?=
 =?utf-8?B?NGswZnpHUDlMcktyWGlLU0VaaTIrQitYTVBKUFA1c2xKeUYwYUFBcndvUGRz?=
 =?utf-8?B?cnhTZ2Vab2xTeXVFVzVhTnlLQnJiTGk4NlZ3VjdDaEkyVHpiSEtuWTVxUkpM?=
 =?utf-8?B?VkhEZTZRTkJyUXlJLy9kZ1BrNnJLV0pNZjJFZmd5b0ZYTlFEaDdaOWJlTnl3?=
 =?utf-8?B?RHpLRkFCZVZTWHNUSFBQd0tUV3pDK1pocGg1bXoyU1NJOTlqM1Zqd1RpQ0ZW?=
 =?utf-8?Q?D3S4XBVwFWLiHEWW3UTzVoU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb248910-6419-4a06-f280-08dae29177ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 13:52:43.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVcKqInzT+I6Ldxrq2Gf6q7cyVAb1kzcsdcPdYxko+1gwu8nbUxoWsBAqXrYLz0q/Nsml6hAZ2CGtbiXWSadVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1528
X-Proofpoint-ORIG-GUID: O9qkNapzlxK7lxw0GvAQFfQlYPnGTNhP
X-Proofpoint-GUID: O9qkNapzlxK7lxw0GvAQFfQlYPnGTNhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=859 clxscore=1015
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogRnJpZGF5LCAxNiBEZWNlbWJlciAyMDIyIDIxOjEz
DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGxpbnV4
LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsZW9ucm9AbnZpZGlhLmNvbTsNCj4gRGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3Npdzog
Rml4IG1pc3NpbmcgcGVybWlzc2lvbiBjaGVjaw0KPiBpbiB1c2VyIGJ1ZmZlciByZWdpc3RyYXRp
b24NCj4gDQo+IE9uIEZyaSwgRGVjIDE2LCAyMDIyIGF0IDA4OjExOjMyUE0gKzAwMDAsIEJlcm5h
cmQgTWV0emxlciB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiA+
IFNlbnQ6IEZyaWRheSwgMTYgRGVjZW1iZXIgMjAyMiAxOTozNQ0KPiA+ID4gVG86IEJlcm5hcmQg
TWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXJkbWFAdmdlci5r
ZXJuZWwub3JnOyBsZW9ucm9AbnZpZGlhLmNvbTsNCj4gRGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20N
Cj4gPiA+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gUkRNQS9zaXc6IEZpeCBtaXNz
aW5nIHBlcm1pc3Npb24NCj4gY2hlY2sgaW4NCj4gPiA+IHVzZXIgYnVmZmVyIHJlZ2lzdHJhdGlv
bg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgRGVjIDE2LCAyMDIyIGF0IDA3OjMyOjA5UE0gKzAxMDAs
IEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPiA+ID4gVXNlciBjb21tdW5pY2F0aW9uIGJ1ZmZl
ciByZWdpc3RyYXRpb24gbGFja3MgY2hlY2sgb2YgYWNjZXNzDQo+ID4gPiA+IHJpZ2h0cyBmb3Ig
cHJvdmlkZWQgYWRkcmVzcyByYW5nZS4gVXNpbmcgcGluX3VzZXJfcGFnZXNfZmFzdCgpDQo+ID4g
PiA+IGluc3RlYWQgb2YgcGluX3VzZXJfcGFnZXMoKSBkdXJpbmcgdXNlciBwYWdlIHBpbm5pbmcg
aW1wbGljaXRlbHkNCj4gPiA+ID4gaW50cm9kdWNlcyB0aGUgbmVjZXNzYXJ5IGNoZWNrLiBJdCBm
dXJ0aGVybW9yZSB0cmllcyB0byBhdm9pZA0KPiA+ID4gPiBncmFiYmluZyB0aGUgbW1hcF9yZWFk
X2xvY2suDQo+ID4gPg0KPiA+ID4gSHVoPyBXaGF0IGFjY2VzcyBjaGVjaz8NCj4gPiA+DQo+ID4N
Cj4gPiAgICAgICAgIGlmICh1bmxpa2VseSghYWNjZXNzX29rKCh2b2lkIF9fdXNlciAqKXN0YXJ0
LCBsZW4pKSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+ID4NCj4gPiBz
aXcgbmVlZHMgdG8gY2FsbCBhY2Nlc3Nfb2soKSBkdXJpbmcgdXNlciBidWZmZXIgcmVnaXN0cmF0
aW9uLg0KPiANCj4gTm8sIGl0IGRvZXNuJ3QNCj4gDQo+IEVpdGhlciBwaW5fdXNlcl9wYWdlcyBv
ciBwaW5fdXNlcl9wYWdlc19mYXN0KCkgYXJlIGVxdWl2YWxlbnQuDQo+IA0KPiBZb3UgZG8gaGF2
ZSBhIGJhZCBidWcgaGVyZSBpZiB0aGlzIGlzbid0IGhvbGRpbmcgdGhlIG1tYXAgbG9jayB0aG91
Z2gNCj4gDQoNCk5vLCB0aGF0IGxvY2sgaXMgaGVsZC4gSSB3YXMgdHJpZ2dlcmVkIGJ5IERhdmlk
J3MgYXJndWluZyBhYm91dA0KcHJvdGVjdGlvbi4gSSB3ZW50IGRvd24gdGhlIHBhdGggb2YgcGlu
X3VzZXJfcGFnZXMoKSBhbmQgZGlkDQpub3QgZmluZCBhIHNpbmdlIHBvaW50IHdoZXJlIGFjY2Vz
cyByaWdodHMgdG8gdGhlIGJ1ZmZlciBiZWluZw0KcmVnaXN0ZXJlZCBhcmUgZW5mb3JjZWQuIHBp
bl91c2VyX3BhZ2VzX2Zhc3QoKSBkbyBoYXZlIGl0IHRob3VnaC4NClNvIEkgcHJvcG9zZWQgYSBj
aGFuZ2UgaW4gc2l3IHRvIHVzZSB0aGF0IGZ1bmN0aW9uLg0KDQpCZXN0LA0KQmVybmFyZC4NCg0K
