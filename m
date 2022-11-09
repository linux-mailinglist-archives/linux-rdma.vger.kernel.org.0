Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367A4622C9E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKINnL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 08:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKINnK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 08:43:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5189F2E6A3
        for <linux-rdma@vger.kernel.org>; Wed,  9 Nov 2022 05:43:09 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9D4tGX002207;
        Wed, 9 Nov 2022 13:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=RM70qtlEKxJjVdBAZxLvlTrnqBUaSzLSqBALg6Urf8E=;
 b=a3EzoRzo1vqCPPx+zcRNxG7Azgo3ppt7xduJoRr+/tzjiDSNhKJlqrmg7bpwlEMY/CT/
 vmAokrGOHNRY/2wsbUtjbUg67hknI4U3wURI75mvuGJdQKB1qHCAjt/lW4JFcx/TMm7s
 BvVOzVHJkFWnsm9pGHg7VcKgTlQF1QzT8Oxy/OHCvAZ7obPhRTyGcLnWA3arh3MwDUIl
 gwK4K1NqZRuDdGt6bIaArAUmSdlH5WIQvI+fQnp2obRbUT0ASNmhU6pRjbhPyD7SscuL
 kECvLZ8HxPU7hduAjhYTZCMNMkiQhftpsjsgTRm5ef2hwWHvK9331hdqjUh0Bsu45aXK HA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kr8wxqdy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 13:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNY6oLyCbHT93DCVH+vbamoEgGtqF4SfPDK1aUX10YKoCkiarQ1ZX9AhEO6JLD1YKseML1ov7sEAUPvJ2/g6XnRcVAlRFd96I/QTekchE5AkA7mzRpTDN326F8F8OD7xu+DTqOtMpGzsLnQjukdPv/+HfqpUTzV7HsVZujX/f03LjGRrZoTKih2BNC0jLZsrPttF7ZWo69Kp1r+h9ODDIpGGzNQc+XfIXyocxeUj5kzk5HPcPVHIwsznRdFo7lYwXOoY+75+zGM71bQqbmEyFN0SkDezECdkh5KdgIKPS7ta9vVAcAMNuALqj0dJu2dND/z2WigeattbA7XYi6kQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM70qtlEKxJjVdBAZxLvlTrnqBUaSzLSqBALg6Urf8E=;
 b=P3airH0Rw2E42N3QUR338ITwKshUBzwhwJEeSISuPsG5PfpaxkMwZFd2etQ7KePzRsTiukoxUdQlm4xhXN5ZNhQuMdwhEdTGk5CxgDijnWiUSPcDyaSYgRa369ABiaMJMLuXTr6wzTQ7TscCef2oZu+ISiZsI5TPvAWFu0BqeFrmIRoFxP4Ol00zr2WVnZeUAPk6f19km2Sdzks0DRVo5su43d6iMDUfcPAsAWMHFY/eDLx2RBURo+z3Nh2DIoIPtjQgW0mtFeZPgl7l9pP9t6y2Pzcluvt/dG7P/YReLcqnezY1IM2JRfQLHOpLft3UGTsxapZMqhK2y/z9WxUmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by CY4PR15MB1253.namprd15.prod.outlook.com (2603:10b6:903:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 13:43:02 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::f0bd:f3a3:9b7f:d3cb]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::f0bd:f3a3:9b7f:d3cb%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 13:43:02 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] RDMA/siw: Fix immediate work request
 flush to completion queue.
Thread-Index: AQHY8rhgGsoQtPJr20W0PkMTW8p24642mOyAgAADzvA=
Date:   Wed, 9 Nov 2022 13:43:02 +0000
Message-ID: <SA0PR15MB39198DD65647C45C58CA26EC993E9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221107145057.895747-1-bmt@zurich.ibm.com>
 <Y2urCSWTEpRmBddD@unreal>
In-Reply-To: <Y2urCSWTEpRmBddD@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|CY4PR15MB1253:EE_
x-ms-office365-filtering-correlation-id: 4473793e-c05f-4d7c-baf1-08dac2585268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkupX7CMnBYN2vXIiRrP5q34SLvgM+jm6qQ1n01H3Pe6WNxFRkq7gqf9dMp6BEJjpoWgtCYe3i4MOSTdRfVYyaIhGx5MCgqkve3WCD6eCFhgEnacBLa6gt0IVpyU5pqHoshBhqDhsKIy64vvbRd7ndmjd3a6ZlwRU3tru0Qkj1SJna49h590baAdb017gMgFsuu3MSO3poaUFlPYMg/q3i1mox6UC2ZduaPeTdcis5bJNhzIQdZ8kAPmjvfOEZl7SRJ0pXzmdl1uJYVksqbAdlYljh1xrvMOlgdQWw7tlhwP30bYx/gQX9EE1XyajFtK7yfll4hD4tHPeiGz9QwrJviI3a80eSrEq5CTJtP0YmLy5VU0sTrTDaRXTzszDsLJF834cts7RKWaKbTGcDeRJNaVuRYOP8ZWRWd4exT4WC9aEzz4Cn4RQNS32939Bgcm2Eopo/TQ3S2niqxSRO7+IpAXzKuwClhE/sbHABIdGHPBpx4cf2peiI6kHNtSu9j1Tvyd0GeUQXE65MiikFhwCSKVVmj5iFQa5qX6tgwJCSWkhsRaYnxbqLJpTSKYI0K3FHaHWzaHt8o4E0VwneNGxpyORMvpdxqduoecncXEij9m1eT2a5hAdmVXko7s6hyI8qvQKNdJDqRgPdsCmknMZj2tONqtKlVO3MXhOlNV5cZzhoStQ9/Xv7z6oHysF0A0IVkEFHWt8gkyhjzNYnGcsFdR2fqjKhwgN1AY2q/+UBfMealFVna2mkNFvljlVW14HIoU8cmF7CDJ47vtoxF7+67x3srz+HniEH4dEu62ZIw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(478600001)(38100700002)(2906002)(38070700005)(71200400001)(83380400001)(186003)(122000001)(33656002)(9686003)(53546011)(6506007)(7696005)(66446008)(64756008)(316002)(66476007)(66556008)(4326008)(8676002)(66946007)(76116006)(86362001)(55016003)(8936002)(52536014)(5660300002)(6916009)(54906003)(41300700001)(14773001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z05uSHpWVkxZME05Mlhva1UwN1k5Sk85THFpMFFRenAwWG5lczZGaUFJaGU0?=
 =?utf-8?B?VHorTGc3SHNGODdaSk0xTFBCa1RUWWV6SStpQm1Lc2ZrajUwSWdHRm9NUVdD?=
 =?utf-8?B?NFNRekdpWTJHM2VUUm85R3Joa3RNUGtNdFN1VExUdGc5QmEzaGd0dG0rYXhp?=
 =?utf-8?B?Nm8zdUE4NjNhV2UxY0lJMVc2bWMxWFFYMzlqdDEzbU1sZklqTWRPT0RvbWQ3?=
 =?utf-8?B?Qld1dnlURm81NCtONkhXY1RWc0c4MkFtckMrMm1oblJleGpwdzlYc3hXNWtp?=
 =?utf-8?B?MkszcERobm9Jbko0bk5vYndXdlA5eVQvVDBnNDRrYlR4T3NaNXpuMHJpZFYw?=
 =?utf-8?B?NHI1byszU3RkbmUrK3FNUWJFOWRKcDVDQkFKNUxoclJEMDYyQWZsM2tCVXk3?=
 =?utf-8?B?Ri9zcmpnTTVzM3BzN211TTl3d0NDRTdoRTltb1pnbWNYRlRrd2piNzdZSXU5?=
 =?utf-8?B?UmtaNU1IS3dtR3hRaTFVQTJqRlo0QTY2eXd5eGhaOHE4Nm5mWW8vT0REaHhx?=
 =?utf-8?B?RW5GV0hkOVlsMkw1Y05qLzdQUllEdHowOC8rNU9zR3R3Ti90dnpYRS8vUXRy?=
 =?utf-8?B?dUVDZFNSZWIzczlVUHMwUWZwbmVHUGxZemlmWDJoMHRheWg4OVhZUVN5RGxG?=
 =?utf-8?B?RDdjeis1bER0MzMxcys2eGxPckJYRHdFN3N5V2lENnFaYndJMmlSaWN6N00z?=
 =?utf-8?B?bWFxY3J3bExTaW5PUisrc1dsRzFXdk9kYTdQWGUrTHE3L1BSNjJ1Q2ZOWUZ3?=
 =?utf-8?B?VmhTZ3JHTW82T05sUXpoVkJmZ243THR1bDNCWnRlV01zKzc2eUkxQ2Z1NWRy?=
 =?utf-8?B?YnN2QkhRbnQ4TGduc0xGaXhXbFBNQkVHdFVzd2VFcDR3OTMvbFFNd1VXMFVE?=
 =?utf-8?B?V0xidzNyamVpMXhzaGR6TnRJZDdhamFsWkFaZ3RYNlU0Y3AvUjJ1bSttVHEv?=
 =?utf-8?B?WHB2cCtpM24ra3VlV3VHNms4MHdLN1pkdUpYenVpVTAwUktVWWVGckJQeDNn?=
 =?utf-8?B?TC9ERTFvN1lxSFRXYkk0S3lTUEZWZFRQZXNVZ1pVNHp3ZVpnODlsOGxGNEU2?=
 =?utf-8?B?dzdxcTZBaEhpTzhSK0FGNWhlaVBRZnQzcExtVGs3Q2o1NkcvYTVqQ3BEeEFM?=
 =?utf-8?B?WVhDM0tzb3hrcCs4TlU1U3BJcmhkYWEyRGFSZzVyWnEzOVJhV2MwU2NCRnl1?=
 =?utf-8?B?RDYva1FyY1NBeFdJOThtWStCUm4wQ3hIMXFweDlwZnk4VFhWek11YS9aLysy?=
 =?utf-8?B?UmhYTmdubzF6MVp4bjVmY0hENWl0L2xMNVJQMVhpWlNHVzVpenc4MUs5TFNJ?=
 =?utf-8?B?R0MvQTlqdjN5YTN5ZVFJcmxKL2ErYUF0bDdycHBkcVdGbW9wM09UYUJIMWE0?=
 =?utf-8?B?VU9WamdzckRlM042eEkrbDVSaEFFUk1wSmxRRlltRjExcjlDSVBuOVlqQmRt?=
 =?utf-8?B?YUlNZm1xM2FHSFNBV29taDk3bTdCekV2M0dtYm9oV21nMkRkamc5L0RwN3ls?=
 =?utf-8?B?aU40RDZjbytkUy9ENHpuaDdVQlcwWTRZVWN3S29qT2dqY1h0T0M2dkRBQTJn?=
 =?utf-8?B?cGpkVWxRaE5xWktORU54blBaNU96aWMyVUlvSUUrb1k0RnpMZWxaeE5jbUpo?=
 =?utf-8?B?TytQdHhXdVdhYVNBcHdQVFhOWmx4Q2oyVkdVbmk4dk5qOXlkYzlTQnUyb2hZ?=
 =?utf-8?B?b0NWWDNoaTdtUmJydUtNQTFDcXpocDlxbmpvOXZKRGdyZHdBM1RNa0I0S0d3?=
 =?utf-8?B?OXBndnhma2lsYjRXM3VPamhmcWtWRGNBYWxXeWgrVEpURTBRdHVEeWo4NTNw?=
 =?utf-8?B?d3hrTSsrR3U1N0I5MWpVKzl3bUZuNEV1VlRUSmJYSjBNNnJWRlR3TU96THd2?=
 =?utf-8?B?Z3lMdjZiWXl3enhqL1k1Z2Q0RTRjOFZTUFJTelNMZ0o2S3NTKzB1OUNiUjRx?=
 =?utf-8?B?dTNmK0llMkN5VHVPekRwaktVa3RLblBOeWtaUGd4eGRNc2s1a25UK2FTVk1q?=
 =?utf-8?B?emdYb3JTVTE1aFh3eDVDOG5IM0g1d2hXa29JMndPU0NzRitqOU5WM0FwUXJO?=
 =?utf-8?B?VWdjV2RGZzloOGJRVW5odWplQlpaVGpyM0d0eUlEK1E1M0RDaktnREN3VERB?=
 =?utf-8?B?andvUEdrbzk4dENGYVZVVEJYYmFOcFpNSVlSTVpXUDFZRkMrODArZnBSbFZk?=
 =?utf-8?Q?urzBKy3/0X7Z6kKf5YTva8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4473793e-c05f-4d7c-baf1-08dac2585268
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 13:43:02.1852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBhRxe/OJUr7jBqiNdX0klpPTZ4VzUcnR9ghbDdXPVqUagVOf57/J8h12bLL/4ris96Z4rtZC/+FF4eh2qFJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1253
X-Proofpoint-ORIG-GUID: o7sHpUNe2FCU9ImcFxy2ynNkxGhlhlgp
X-Proofpoint-GUID: o7sHpUNe2FCU9ImcFxy2ynNkxGhlhlgp
Subject: RE: [PATCH v3] RDMA/siw: Fix immediate work request flush to completion
 queue.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=883
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9ucm9AbnZpZGlhLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCA5IE5vdmVtYmVyIDIwMjIg
MTQ6MjkNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzog
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGpnZ0BudmlkaWEuY29tOyBPbGdhIEtvcm5pZXZz
a2FpYQ0KPiA8a29sZ2FAbmV0YXBwLmNvbT47IFRvbSBUYWxwZXkgPHRvbUB0YWxwZXkuY29tPg0K
PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjNdIFJETUEvc2l3OiBGaXggaW1tZWRp
YXRlIHdvcmsgcmVxdWVzdA0KPiBmbHVzaCB0byBjb21wbGV0aW9uIHF1ZXVlLg0KPiANCj4gT24g
TW9uLCBOb3YgMDcsIDIwMjIgYXQgMDM6NTA6NTdQTSArMDEwMCwgQmVybmFyZCBNZXR6bGVyIHdy
b3RlOg0KPiA+IENvcnJlY3RseSBzZXQgc2VuZCBxdWV1ZSBlbGVtZW50IG9wY29kZSBkdXJpbmcg
aW1tZWRpYXRlIHdvcmsgcmVxdWVzdA0KPiA+IGZsdXNoaW5nIGluIHBvc3Qgc2VuZHF1ZXVlIG9w
ZXJhdGlvbiwgaWYgdGhlIFFQIGlzIGluIEVSUk9SIHN0YXRlLg0KPiA+IEFuIHVuZGVmaW5lZCBv
Y29kZSB2YWx1ZSByZXN1bHRzIGluIG91dC1vZi1ib3VuZHMgYWNjZXNzIHRvIGFuIGFycmF5DQo+
ID4gZm9yIG1hcHBpbmcgdGhlIG9wY29kZSBiZXR3ZWVuIHNpdyBpbnRlcm5hbCBhbmQgUkRNQSBj
b3JlDQo+IHJlcHJlc2VudGF0aW9uDQo+ID4gaW4gd29yayBjb21wbGV0aW9uIGdlbmVyYXRpb24u
IEl0IHJlc3VsdGVkIGluIGEgS0FTQU4gQlVHIHJlcG9ydA0KPiA+IG9mIHR5cGUgJ2dsb2JhbC1v
dXQtb2YtYm91bmRzJyBkdXJpbmcgTkZTb1JETUEgdGVzdGluZy4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2ggZnVydGhlciBmaXhlcyBhIHBvdGVudGlhbCBjYXNlIG9mIGEgbWFsaWNpb3VzIHVzZXIgd2hp
Y2gNCj4gbWF5DQo+ID4gd3JpdGUgdW5kZWZpbmVkIHZhbHVlcyBmb3IgY29tcGxldGlvbiBxdWV1
ZSBlbGVtZW50cyBzdGF0dXMgb3Igb3Bjb2RlLA0KPiA+IGlmIHRoZSBDUSBpcyBtZW1vcnkgbWFw
cGVkIHRvIHVzZXIgbGFuZC4gSXQgYXZvaWRzIHRoZSBzYW1lIG91dC1vZi0NCj4gYm91bmRzDQo+
ID4gYWNjZXNzIHRvIGFycmF5cyBmb3Igc3RhdHVzIGFuZCBvcGNvZGUgbWFwcGluZyBhcyBkZXNj
cmliZWQgYWJvdmUuDQo+ID4NCj4gPiBGaXhlczogMzAzYWUxY2RmZGY3ICgicmRtYS9zaXc6IGFw
cGxpY2F0aW9uIGludGVyZmFjZSIpDQo+ID4gRml4ZXM6IGIwZmZmNzMxN2JiNCAoInJkbWEvc2l3
OiBjb21wbGV0aW9uIHF1ZXVlIG1ldGhvZHMiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBPbGdhIEtvcm5p
ZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogVG9tIFRhbHBleSA8
dG9tQHRhbHBleS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRA
enVyaWNoLmlibS5jb20+DQo+IA0KPiBQbGVhc2UgZG9uJ3QgYWRkIGRvdCBhdCB0aGUgZW5kIG9m
IHRoZSB0aXRsZS4gSSBmaXhlZCBpdCBsb2NhbGx5Lg0KPiANCg0KVGhhbmtzIGZvciB0aGUgcGF0
aWVuY2UhDQoNCkJlc3QsDQpCZXJuYXJkLg0K
