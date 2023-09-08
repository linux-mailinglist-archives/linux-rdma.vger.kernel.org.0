Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BC8798635
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjIHKzv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 06:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjIHKzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 06:55:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E123F11B
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 03:55:45 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388Af5hX003321;
        Fri, 8 Sep 2023 10:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SrNN+o5ZAUycHvRvteYBKEgBzqOt40KCFn6mZxi+Ymc=;
 b=V3ShwbshNLhN8DeZ4D/1o9JMcVx9pfeUrj6yXMfqkrbmcItVRqmKSF0D4xI13AR09Udl
 AXJGohnDN29OCCodDzoKAkN9Gc172kNUvfIzkEt/jaGsSaB8n+1i8XIO0dFLHuONsVHV
 d3N0MvcK4ALjiE2bwwtOUM/qCUWVIXJICpxLPmtnsmRGwm++0ueoouRh8txpcx2Ubi1E
 ELd4LqPRHd7n7vR4luhjojz7OHMvuyA9+C3GVM4T4I8ssRuZsWRqgrNVSOKUNdvkvPNc
 JidLa0Jijgc2BOVP9Sh7+Zu8iHywMBSJpaFGkaJktcjs3MrU+0AGGW3so3tCaA0oDUgW Cw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t00hjtns9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 10:55:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5zEfPRtIwch60ae/FxAdrpt8a95Mu0VMOk3Zc6r1UYoDrpOu3WxECqTJTCoG7zlYcr+pj3yRAzoAvJIr2uwMCz37UE/9YQL2Dcqrw9p6a17DkKFn2/TBqBqmMUT2qVaOBpOXaw4ZqRzdN4KQi3f4qIpOCI3lUn2eKpdGfzzK3HpXHdxcIcqXx4RhGdpUdhmBzP9Hl7lcuIneOrU0l3q6F5/SkStcXi0jOkpSKJqBS7WOGWsD1kcBhK5tlP+Yi1EkFSEnZHwycYt09joGbdwF+it24NOEcfwFV2XgNC570dNjUj2Q+PSmoNbZWWhxH1UdJW462rkb/WxiCqyN4CO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrNN+o5ZAUycHvRvteYBKEgBzqOt40KCFn6mZxi+Ymc=;
 b=BjlYZy/bJmmZTIAZ5AprFc38+6TYg5ymOAr4Kws0vvuSzdumG1OGjmaZ579OPLACKDu4Mn0x6jCSC+9OAlbNfSMASk9oTFcthrPvHkrLh4jSm16CsxXWumHQU/l4ZvT0aOGGIbTA31svwiU+pxBQNlmrQJawUuldOJICqW5brPHpmpzqNyAv5Fpvw8YVvA1HjsB5WZQNlqM8UGYe54dAMwTJFepPXKwO4DY6QV+0qz1Om4Ahl4eRVJwIiaxbb19RksFukr4HMjkAkvR5Qh2q7iuUaN5h3p76YLYvEbiNdG+8G7A8GIbuLJKZ+vFW3J6L6+j5QY0Rhpfg6XPRrh5CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by PH7PR15MB6406.namprd15.prod.outlook.com (2603:10b6:510:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 10:55:31 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::c6be:f755:288b:bf2d]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::c6be:f755:288b:bf2d%4]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 10:55:31 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Subject: RE: Re: [PATCH v2] RDMA/siw: Fix connection failure handling
Thread-Topic: Re: [PATCH v2] RDMA/siw: Fix connection failure handling
Thread-Index: AQHZ4kL8/hylzFB7s0qqoGogzD5BuQ==
Date:   Fri, 8 Sep 2023 10:55:31 +0000
Message-ID: <SN7PR15MB57556369B1A52ACA759A9D9D99EDA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230905145822.446263-1-bmt@zurich.ibm.com>
 <332d5cd8-c0ab-3657-513d-0d385fc4bdca@linux.dev>
In-Reply-To: <332d5cd8-c0ab-3657-513d-0d385fc4bdca@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|PH7PR15MB6406:EE_
x-ms-office365-filtering-correlation-id: 576a7b8c-0c45-482e-2022-08dbb05a1ebf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esLpkFOe+Q4CG1Gs529k2SZXrN2nGebwJ7IXkW8/zmsC3pi8oLo0WCVOPllHljFGxxfNAl5QL6L8Zd8cN5JCwo90cmNMGkoi3gi2IgT+HjFJPl1AfdmqISAsnd6SCt1Pv/bRMTpshxFv9oBYBj3pqXO/gIY/DV+PivneT8PSWQ1D01MPnokP5XKHq7c7kHNMAyw6Q5NClrtODUnbaWg8UDrjlWBnE1gqh6x66fZHcrDs/gJw2viXEttnMij0RETaffpB83i6bdBwMDEcU+OEM3qEKqyeb13MicSoy4Zm0up8UBozUyRQy8lnw9GKxFkT6qRo6VsMnx+2e/K4J55xt9SAnSEARKHJKP80h7YRMV35HuXHblCUmAelX2IfMwL9IzA3WAni67lwCcy3H7fHourxkWCrRpg0woQ48OLpBeQ8pvaE6lu78b6YDBW7lG90k+lYQnidi2qgB/PR2fxx2JTjWCsbzhz5EZUjb1P8c6R/8zztm2KtB1S9aGG9GI2Wpl7drS9Ktv1YiOqtHdKXifggVWSWtw+Ofol3M6IUT3gUS1NiWkKp1jCE3/X28AEC+T8puCXhU52NZDzos6qn/66MfXP070KDkCerTOaM66s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(1800799009)(186009)(451199024)(38070700005)(71200400001)(53546011)(6506007)(7696005)(83380400001)(478600001)(9686003)(52536014)(2906002)(66476007)(110136005)(54906003)(64756008)(76116006)(66946007)(5660300002)(8676002)(66446008)(8936002)(66556008)(316002)(4326008)(55016003)(86362001)(33656002)(38100700002)(41300700001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUNZNlFaSlB4Z0hjOFZmSGJBeWJ3d0xJT29xclhvL0IwZjluejQ0a1RoVEJE?=
 =?utf-8?B?QU5JNTJTeU44cURnM0doTXQ5eE1VUjNPZldzY0pUKzRNWko5blVwemNLeHZ4?=
 =?utf-8?B?TXJIcndMZHpGc3RmTkRUL0RYMmZlK3A2alN3bnRsRUUwbUlSbVh6SjlNOTVL?=
 =?utf-8?B?VkZGeUltTHdpd3ltRHVPMVBUeFo3STY0Z2lPUTdvYks5dm1NeW5TUFBrSDVw?=
 =?utf-8?B?R0ZJYVJVYVlvRDFoZ0FYM2pTZGo5S3hENVVRWlRUSjViMllBSG1iczJ1L0g2?=
 =?utf-8?B?cXYzVjVld2IyUUJtbUl4aDk0VFp3UWNDZDViTURZLytYV2lkd1ZaOXVtMlZH?=
 =?utf-8?B?N01VaFhNMjJhOEgxN1liRGtLbnFOaXZWTHE4TUxpeW53WXhDcThJMXNsRmhG?=
 =?utf-8?B?dXgyZE14UzBiT2l0VW5HTG5scjBBWXpKakhGWExNU1kyaEdXUnAvTXA1WEk4?=
 =?utf-8?B?djJDSmZwTjZsMFZPWVRlMkxmdnoyU0M0ZlNCeHUvUWFoMGgvMitqb2hIalN4?=
 =?utf-8?B?emg1VjVQQVp0emd5UW9QcFpkVHJEMlFpQ3dFODNWZkIxQnBwOUFieWN2NGFS?=
 =?utf-8?B?UFc0NzZDSjc2Qmg2SE5ZeHR4cUFSTXRkcHJ3TlM4OVdyUEN3NzcvZGM3eFNx?=
 =?utf-8?B?S011eXVHWnFsSHdpTlIvb2VVOC9Kd2hzeWlIdmNMSi9VUkRqaEwxL0VhOGZh?=
 =?utf-8?B?NWNpeVZJL1RTMkR1QWMzOG4wbmp4UFhCcG9YOFN4RnVDRFNJUGdUeWI2MU80?=
 =?utf-8?B?S1h3VlR4R3hSZGwxQmxxTVdxdTJjODFtaEVVc2pOVjZKWnBMYzJLK3Q4N1Rr?=
 =?utf-8?B?WUpLYXd4aUlPTjlmS2dnWHQ1NENIdUJaZ0J6MnpuNlNnUllUT1RQeGpLNmlk?=
 =?utf-8?B?TTZTOTZ1TnZFT2t1bU96c0hKUlVLaEVKZ3dmdC92RWJiaEdFSzBjZFBpRTdi?=
 =?utf-8?B?NGVQQ3B4ak5ZdGZoREV6TUNmVGtlWjlBYnQyR2FDb29Oa2Fya1I4YXV6Z3hz?=
 =?utf-8?B?KzR0VlVmUm5CZnNNMXA1bU1abmJ6VU9nWHhkdWVraW1mVUlGUFhyTVpYZ3hS?=
 =?utf-8?B?K2hVNEJtSkF4dmZISGNYTmJiZ3pEc1JBSW13RXJKdGh4aE5wdVNBMG5MeDFz?=
 =?utf-8?B?ZHpJMG9uOXhQUlVYRUV6WVc2Q25ORXFLd2NnV2JubkYwRHNBU1hneUhXNVVq?=
 =?utf-8?B?NnJXNjZ6TUpJQkx1NW1RWS9rT2Z4blBuSE9jY0o0bnVvR3hBcTM3c1RxMkxV?=
 =?utf-8?B?WDVubGFidTNhSGNCTVlkY2VGVGhTV3l5dk13YU93K3BPWFBZcDAvOGZTY1pl?=
 =?utf-8?B?UnM1UFRUU3lZRGVPUVZPMjNCRGU4Mk5yczRKaDNia0grZzRGMklUZmZ6c244?=
 =?utf-8?B?bTFVU1lYL09WWWNkUGk4cElubnRQajh0YVh4cnhJVXg2TjNjcHVuODdVZUV6?=
 =?utf-8?B?c0JVMHFZWWxIOGI4MVlqdE5sWndjVm1VdldqdmhDK21FSlR1Z3locW5uaTN5?=
 =?utf-8?B?NGdmS0kxeFVmS2IrS0Q3c2lnb29FaG96TWdQdFB4QzhDN1E4S2dmb29kTUR5?=
 =?utf-8?B?a09MYkdWd3l2Q2hscmZydHpQU3BiYXMrSjRRSWZ2YWZaL0t2Wk8raDFrS0I2?=
 =?utf-8?B?RGQ4dGlaQm5YZWhFaEVEWHRxRVlVQWJLUlZJQmI4TDdtZDFFRUpSNDh1eVRt?=
 =?utf-8?B?cHU5SWNqd2xNU2x6KzFNQ0ppQ3dwQXFpVFRtay9rWWE5bUdLZ0t4R2Ria09V?=
 =?utf-8?B?dVdLb0ZVc0p1c0YwNHpQUWFnMU9zNmxWdERkYTFRN251MFhrdHJQR055cTl3?=
 =?utf-8?B?a3IybysyYkFMd1R4b25OWFdLTnlRZnYzUUpmNFREb28vUUlwNXRFSmNCQWpx?=
 =?utf-8?B?T214T1M3WXRkdjAvUmEvRjJmcWI1M0xhRkFVUlBtemdaRlBjTlN4WmhTZnFw?=
 =?utf-8?B?OHg2Sk9QMTlmdXJNcm5ranBWdzE3T0FEU1UzTU9GaFlNRis0WGlVbktYekVR?=
 =?utf-8?B?TnJtMlFVL3VpUk56UU0weWtTY29mN2E5eVZNNGJsdnNheWdlYjFPTUpiOGt1?=
 =?utf-8?B?UHVSbDlWWVNjT2UwVDhoaVE2VnY1Ym1xbGNSRFVaYnhLUEZ4d3M0YUlVRWEr?=
 =?utf-8?B?QS84aTIvZGxOalk1RVJ1Y1FGL0tJa1VuYmp1aERPYzFwTmFEZCtZeTBKS1Vj?=
 =?utf-8?Q?v2Dgsp5RL+TcyDLYgnJctWthnTuok88SDGI95Z4c9X2H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576a7b8c-0c45-482e-2022-08dbb05a1ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 10:55:31.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFTis6d0hy1c5OGmcziITvyHbxa0b2qqZ9zeTbYx8rt1f7RbVuOh8qmqdt7y6q2vTdj8fv7wtlq5cg56Fkx53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6406
X-Proofpoint-ORIG-GUID: zATRhHt2bqkduNQhVsM77T25Z32gnDdb
X-Proofpoint-GUID: zATRhHt2bqkduNQhVsM77T25Z32gnDdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgOCBTZXB0ZW1iZXIgMjAy
MyAwMzozNQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBsaW51
eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBDYzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5v
cmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIHYyXSBSRE1BL3NpdzogRml4IGNv
bm5lY3Rpb24gZmFpbHVyZQ0KPiBoYW5kbGluZw0KPiANCj4gSGksDQo+IA0KPiBPbiA5LzUvMjMg
MjI6NTgsIEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPiBJbiBjYXNlIGltbWVkaWF0ZSBNUEEg
cmVxdWVzdCBwcm9jZXNzaW5nIGZhaWxzLCB0aGUgbmV3bHkNCj4gPiBjcmVhdGVkIGVuZHBvaW50
IHVubGlua3MgdGhlIGxpc3RlbmluZyBlbmRwb2ludCBhbmQgaXMNCj4gPiByZWFkeSB0byBiZSBk
cm9wcGVkLiBUaGlzIHNwZWNpYWwgY2FzZSB3YXMgbm90IGhhbmRsZWQNCj4gPiBjb3JyZWN0bHkg
YnkgdGhlIGNvZGUgaGFuZGxpbmcgdGhlIGxhdGVyIFRDUCBzb2NrZXQgY2xvc2UsDQo+ID4gY2F1
c2luZyBhIE5VTEwgZGVyZWZlcmVuY2UgY3Jhc2ggaW4gc2l3X2NtX3dvcmtfaGFuZGxlcigpDQo+
ID4gd2hlbiBkZXJlZmVyZW5jaW5nIGEgTlVMTCBsaXN0ZW5lci4gV2Ugbm93IGFsc28gY2FuY2Vs
DQo+ID4gdGhlIHVzZWxlc3MgTVBBIHRpbWVvdXQsIGlmIGltbWVkaWF0ZSBNUEEgcmVxdWVzdA0K
PiA+IHByb2Nlc3NpbmcgZmFpbHMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGZ1cnRoZXJtb3JlIHNp
bXBsaWZpZXMgTVBBIHByb2Nlc3NpbmcgaW4gZ2VuZXJhbDoNCj4gPiBTY2hlZHVsaW5nIGEgdXNl
bGVzcyBUQ1Agc29ja2V0IHJlYWQgaW4gc2tfZGF0YV9yZWFkeSgpIHVwY2FsbA0KPiA+IGlzIG5v
dyBzdXJwcmVzc2VkLCBpZiB0aGUgc29ja2V0IGlzIGFscmVhZHkgbW92ZWQgb3V0IG9mDQo+ID4g
VENQX0VTVEFCTElTSEVEIHN0YXRlLg0KPiA+DQo+ID4gRml4ZXM6IDZjNTJmZGMyNDRiNSAoInJk
bWEvc2l3OiBjb25uZWN0aW9uIG1hbmFnZW1lbnQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlcm5h
cmQgTWV0emxlcjxibXRAenVyaWNoLmlibS5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlTG9nIHYx
LT52MjoNCj4gPiAtIE1vdmUgZGVidWcgbWVzc2FnZSB0byBub3cgY29uZGl0aW9uYWwgbGlzdGVu
ZXIgZHJvcA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20u
YyB8IDE2ICsrKysrKysrKysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
d19jbS5jDQo+ID4gaW5kZXggYTI2MDUxNzhmNGVkLi40M2U3NzYwNzNmNDkgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gPiBAQCAtOTc2LDYgKzk3Niw3IEBAIHN0
YXRpYyB2b2lkIHNpd19hY2NlcHRfbmV3Y29ubihzdHJ1Y3Qgc2l3X2NlcCAqY2VwKQ0KPiA+ICAg
CQkJc2l3X2NlcF9wdXQoY2VwKTsNCj4gPiAgIAkJCW5ld19jZXAtPmxpc3Rlbl9jZXAgPSBOVUxM
Ow0KPiA+ICAgCQkJaWYgKHJ2KSB7DQo+ID4gKwkJCQlzaXdfY2FuY2VsX21wYXRpbWVyKG5ld19j
ZXApOw0KPiANCj4gT25lIHF1ZXN0aW9uLCB3aHkgc2l3X2NtX3dvcmtfaGFuZGxlciBzZXQgY2Vw
LT5tcGFfdGltZXIgdG8gTlVMTCBpbnN0ZWFkDQo+IG9mIGNhbGwNCj4gc2l3X2NhbmNlbF9tcGF0
aW1lciBsaWtlIGFib3ZlPyBDb3VsZCBpdCBiZSBtZW1vcnkgbGVhayBpc3N1ZSBmb3INCj4gY2Vw
LT5tcGFfdGltZXI/DQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQpBYm92ZSBpbiB0aGUgcHJv
cG9zZWQgcGF0Y2gsIHdlIGNhbmNlbCBhIHBlbmRpbmcNCk1QQSB0aW1lci4NCg0KWW91IGFyZSBy
ZWZlcnJpbmcgdG8gc2l3X2NtLmM6MTExNQ0KDQogICAgICAgIGNhc2UgU0lXX0NNX1dPUktfTVBB
VElNRU9VVDoNCiAgICAgICAgICAgICAgICBjZXAtPm1wYV90aW1lciA9IE5VTEw7DQoNCldlIGV4
cGxpY2l0bHkgc2V0IGl0IE5VTEwgaGVyZSBzaW5jZSB3ZSBhcmUgaGFuZGxpbmcNCnRoZSB0aW1l
b3V0LCBzbyB0aGUgTVBBIHRpbWVyIGhhcyBmaXJlZCBhbmQgd2UNCmNhbm5vdCBjYW5jZWwgaXQg
YW55bW9yZS4gQXQgdGhlIGVuZCBvZg0Kc2l3X2NtX3dvcmtfaGFuZGxlcigpLCBhbnkgd29yaywg
aW5jbHVkaW5nIHRoZSBNUEENCnRpbWVvdXQsIGdldHMgcmVjeWNsZWQgdG8gdGhlIGNlcCdzIGxp
c3Qgb2YgZnJlZSB3b3JrDQppdGVtcyB2aWEgc2l3X3B1dF93b3JrKCkuIFRoaXMgbGlzdCBpcyBy
ZWN5Y2xlZCBvbmx5IGF0DQp0aGUgZW5kIG9mIHRoZSBjZXAncyBsaWZldGltZS4NCg0KDQo+IExl
dCdzIHNheSBtcGFfdGltZXIgaXMgc2V0IHRvIE5VTEwgYmVmb3JlwqAgY2FsbCBzaXdfY2FuY2Vs
X21wYXRpbWVyLg0KPiANCj4gPiAgIAkJCQlzaXdfY2VwX3NldF9mcmVlKG5ld19jZXApOw0KPiA+
ICAgCQkJCWdvdG8gZXJyb3I7DQo+ID4gICAJCQl9DQo+ID4gQEAgLTExMDAsOSArMTEwMSwxMiBA
QCBzdGF0aWMgdm9pZCBzaXdfY21fd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdA0KPiAq
dykNCj4gPiAgIAkJCQkvKg0KPiA+ICAgCQkJCSAqIFNvY2tldCBjbG9zZSBiZWZvcmUgTVBBIHJl
cXVlc3QgcmVjZWl2ZWQuDQo+ID4gICAJCQkJICovDQo+ID4gLQkJCQlzaXdfZGJnX2NlcChjZXAs
ICJubyBtcGFyZXE6IGRyb3AgbGlzdGVuZXJcbiIpOw0KPiA+IC0JCQkJc2l3X2NlcF9wdXQoY2Vw
LT5saXN0ZW5fY2VwKTsNCj4gPiAtCQkJCWNlcC0+bGlzdGVuX2NlcCA9IE5VTEw7DQo+ID4gKwkJ
CQlpZiAoY2VwLT5saXN0ZW5fY2VwKSB7DQo+ID4gKwkJCQkJc2l3X2RiZ19jZXAoY2VwLA0KPiA+
ICsJCQkJCQkibm8gbXBhcmVxOiBkcm9wIGxpc3RlbmVyXG4iKTsNCj4gPiArCQkJCQlzaXdfY2Vw
X3B1dChjZXAtPmxpc3Rlbl9jZXApOw0KPiA+ICsJCQkJCWNlcC0+bGlzdGVuX2NlcCA9IE5VTEw7
DQo+ID4gKwkJCQl9DQo+ID4gICAJCQl9DQo+ID4gICAJCX0NCj4gPiAgIAkJcmVsZWFzZV9jZXAg
PSAxOw0KPiA+IEBAIC0xMjI3LDcgKzEyMzEsMTEgQEAgc3RhdGljIHZvaWQgc2l3X2NtX2xscF9k
YXRhX3JlYWR5KHN0cnVjdCBzb2NrICpzaykNCj4gPiAgIAlpZiAoIWNlcCkNCj4gPiAgIAkJZ290
byBvdXQ7DQo+ID4NCj4gPiAtCXNpd19kYmdfY2VwKGNlcCwgInN0YXRlOiAlZFxuIiwgY2VwLT5z
dGF0ZSk7DQo+ID4gKwlzaXdfZGJnX2NlcChjZXAsICJjZXAgc3RhdGU6ICVkLCBzb2NrZXQgc3Rh
dGUgJWRcbiIsDQo+ID4gKwkJICAgIGNlcC0+c3RhdGUsIHNrLT5za19zdGF0ZSk7DQo+ID4gKw0K
PiA+ICsJaWYgKHNrLT5za19zdGF0ZSAhPSBUQ1BfRVNUQUJMSVNIRUQpDQo+ID4gKwkJZ290byBv
dXQ7DQo+ID4NCj4gDQo+IE1heWJlIHNwbGl0IGFib3ZlIHRvIGFub3RoZXIgcGF0Y2ggbWFrZXMg
bW9yZSBzZW5zZSwganVzdCBteSAkMC4wMi4NCj4gDQpJIHByZWZlcnJlZCB0byBoYXZlIGl0IGlu
IG9uZSBwYXRjaCwgc2luY2UgaXQgd2FzIGFsbCB0cmlnZ2VyZWQNCmJ5IHlvdXIgcGF0Y2ggYjA1
NjMyN2JlZTA5DQonUkRNQS9zaXc6IEJhbGFuY2UgdGhlIHJlZmVyZW5jZSBvZiBjZXAtPmtyZWYg
aW4gdGhlIGVycm9yIHBhdGgnDQoNCkFsYXJtZWQgYnkgdGhhdCwgSSByZS10ZXN0ZWQgbWFueSBl
cnJvciBjYXNlcyBpbmNsdWRpbmcgYSBmYWlsaW5nDQpNUEEgcmVxdWVzdCBwcm9jZXNzaW5nLCB3
aGljaCB0cmlnZ2VyZWQgdGhpcyBOVUxMIGJ1Zy4gSXQgYWxzbw0Kc2hvd2VkIG1lIHRoaXMgdXNl
bGVzcyBleHRyYSByZWFkIGV2ZW50IHByb2Nlc3Npbmcgd2hlbiB0aGUgVENQDQpzb2NrZXQgaXMg
Y2xvc2luZyB3aGlsZSB0aGUgZW5kcG9pbnQgaXMgc3RpbGwgaW4gTVBBIGhhbmRzaGFrZSBtb2Rl
Lg0KDQpCdXQgeW91IGFyZSByaWdodCwgaXQgaXMgbm90IG5lY2Vzc2FyaWx5IHJlbGF0ZWQuIEkg
Y2FuIHNwbGl0IGl0Lg0KDQoNCj4gVGhhbmtzLA0KPiBHdW9xaW5nDQo=
