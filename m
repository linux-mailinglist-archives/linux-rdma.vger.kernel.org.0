Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349F14BA702
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 18:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiBQRVz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 12:21:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243661AbiBQRVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 12:21:52 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5076EBDB
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 09:21:34 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HFdpwv025772;
        Thu, 17 Feb 2022 17:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=UZalWEHZo9sxFA31FUZOwngoG68sQJHSJuLhY8H2aY8=;
 b=kmc02eqYr5Ay8xq8MXxfzOSIOTS+h94rVOMCiJWoIiMHPgHWgbV0iI7P+H6POd53dIa1
 Lbq4CMaCLc7Yvsg01++RUrbLA8h5O+ShV0fz82EhHnoBbOrgQ2SaxjkxSuV/nUOC5rmQ
 1OCr97EAU9uv30e4ygpRSDckZwlgvsjjoAytiBu0vW2khWkg4MhQ3IJaKRz2UBloJVC8
 /8y4m25yvj2QIROfvkvDVG/5CHE/2Ufd6vHmczA7sxy1ii6w58qofM+zGgzs/xhJNr3M
 3imWQ/U9MRId6tJKbGBp7XwuZv1hzvVkWVPZibv5d4iUhNy8uNdJ+iZQe7b33WiVMA8/ +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9reckw09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 17:21:18 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HGpUPD031433;
        Thu, 17 Feb 2022 17:21:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9reckvyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 17:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PptOMQQ5Ll6EvYXVYD0KmfMeSHtz9FgXb9d/FAWpPR0M8oejDsjjV+yYyu4rWepk4My1dE2vGwb/1cipE6gH3De2SXsS6bN/6QaQPxbHD0ehpvoLB8ggpnDh4rDuv6miYfGiQTAU82oZVM+pbz77KDxE2aDpyiCjBiLlfrCOTTKf97rdlQ2TDC0BJz99G+VPcWpnMVlC1E/eT0+3b9WUbrbAZxgtv3pkUI5RQD9lqw4wMI4uCrXbw2JC4SLbMbwuzUm+sctAkXkJq1xBgWen5pMOMxuXzrJiSw2iSlelnH+z4Vnt3BSOW19Lz1J1cZn0l9WAhjPZth5WNZkfq8ELFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPp75BzHCAQrXSvll7R08RpBtThD6xh+CFCd/+BDaR4=;
 b=UCI22TKHlog0N0wdc3aRxEZ91VMjn4sZqGytWC79m428ghLtsLhAkVlD1gRINjLL4hDz/YHZwuOMFPMjcSs9Ka9/hZlnEhA3IYyf/RHZS6pdBAsWmCjv9hkAGaQocc5+c4yMQQ/ZwhisQESi56bu205411VC4TZv0XJbYop7xA2yD8nhjGEweWqwuAlNPZaiznuQooS19ETKeZMvCu4XUaESEuEvdjv2oHI76ZdjwpDWn3cBukFX3esMveTmIWTxEpezy1noIkfhHCF0ifMVp0SG4KF63/kinARmgHjR4p5VOXA8NzTUySec9Rq3ZG2XRJ78AGvs6qdweLsPFvMitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by MWHPR15MB1952.namprd15.prod.outlook.com (2603:10b6:320:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 17:21:14 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::a1f0:35ce:ba08:a286]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::a1f0:35ce:ba08:a286%5]) with mapi id 15.20.4975.011; Thu, 17 Feb 2022
 17:21:14 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou.xc@alibaba-inc.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "chengyou@linux.alibaba.com" <chengyou@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Subject: RE: [PATCH for-next v3 00/12] Elastic RDMA Adapter (ERDMA) driver
Thread-Topic: [PATCH for-next v3 00/12] Elastic RDMA Adapter (ERDMA) driver
Thread-Index: AdgkIi20vxL+XJJwQA6aVUBqcn56NA==
Date:   Thu, 17 Feb 2022 17:21:14 +0000
Message-ID: <BYAPR15MB2631867F60D52B2626D3708499369@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4035bdf4-1ca5-4929-2e40-08d9f239e6bb
x-ms-traffictypediagnostic: MWHPR15MB1952:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1952D94A0F451154A7BDF76E99369@MWHPR15MB1952.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yAsCakaOZGIs40i9gdrqQgbRT83yvc8lqFv4GTqPvWhkFYWS314s7UwmxM5d/QLApIXj2M/uVraCAuxJ3hxxHe8Gcl8dqs++XiMZVBAocAJP24Aon3b6ApFW/UkWNezogOFCHQ1ofBOIhg3igBjSHi9HAYHnFY1irvjkp/pkoDQHBISQjGJUH5qCEYg95qzVKdlYjeGDdieP+DBLTxWLpYTfycskTgkGC3YUsel77GtbVk/abcDOIJnjYXM0fGVqPallqQNt1m6id+qtQUmYf9OdFha965RFOMrSAOnwJRzQrVGLlPtwSz0e+jC2GdaLzW/GGEqpz+oIyuXa8pHa3Qfiyk22vcHGvN1gRM7v66RmLeWgb64HxPg5FK1WbtmN21nopr481pa/QMK5ikRW3zTBFFPqhYYCB4xudoDzc8yAbWq4K8g7cUILB12rbSNNzOKwkGKs5F4u/6qhXga21Hkw4zeJlGpyCa9yw832jQw5uG0APw6tjjW2FF0AqVjRDM9zXTEs76YsOZZ8j5c4C6mgMclPcS+4E8dv1U3RJs2HeWZLsKzJH1Mrlb/D4nUZn671mTc4oXfxkt+a+eRM/9WmQhT1eRAOlH3j1+Gp8rqAwbm4gu5iqBqM7Av+tyKOqtiqPrP47RM0ma2E7sNlnik4KGbcYi0EpKxgBRCJCq59xKK4L2T31/70HHW3nupOFHS8O0A/V8Noe5MAFtH0pdGwvVMG8ZpAcd1U+d6Rk/KPyhIK7d5fvRk3f6LCUqr7rHbVNg/z9g8fa1AiBdCh+VHyQOJlCdRcSWqAAP7FJ+Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(71200400001)(66946007)(86362001)(76116006)(64756008)(9686003)(53546011)(66446008)(66556008)(7696005)(55016003)(316002)(54906003)(508600001)(6506007)(966005)(38100700002)(186003)(110136005)(38070700005)(122000001)(83380400001)(2906002)(52536014)(8676002)(5660300002)(4326008)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDJHMkduVldrLzBqVXhjN2hWOWRCSnVDL25mdFJmSVBRaUlwMzBHZmxCZHAr?=
 =?utf-8?B?RzUwbnQyd0NBaUxlMEc5SWdqUytTN2VmYUwzNDl0bGZXTG1odVBLR2hFSGFF?=
 =?utf-8?B?ejZ6L3l2YWFBTTFsVi9hbWNESlZ5MTJJblQwNDZuOTMzYkhXazVmRUlTYTg0?=
 =?utf-8?B?bFhVOHMwN1pHNjl0UURydFRNeUtMS3hpRHRXOGpYUXZIa2dIYjAyNFA1L2J5?=
 =?utf-8?B?bzZEWnRqT3FXbElpYlNBV0NQMnd1N09DSGprM2svRkk4K28zWEgzVmFYZ1dO?=
 =?utf-8?B?U3M3UjVFSXlXNHEwYmlNMkNQU3NUNGFrbUxDQmRDdFFMZ1ZVRjNFd3FxUTBh?=
 =?utf-8?B?aGVEM2pZZ1ovOTF5aXhHZlFQMHB3bXFlZVd4bjUxWVFZK3NjQWRaRm5yWlBM?=
 =?utf-8?B?ZTBuMFpYclNJY0VXZTIwSC9xZUJtVzJQV0FSOEpqNlF6MSt6S2ZyLzhRSnYz?=
 =?utf-8?B?a3NyMUh4OUcxanBOdCt5L1Rnc0tPQU54ZzBWR0YyYlpZRXlNdHUxS1JtQjNz?=
 =?utf-8?B?WnhFV0JGL3IxSTBBWWY2WUhmZ2dmZ2FySW8vVEhIOUpjNENsVVU1ZUdXb3VL?=
 =?utf-8?B?OEpkdksxUFRrNlE4cGdDUytaMFR2d3h4ZmxabURMVzhnQmpqUndJWlFNdURp?=
 =?utf-8?B?NlhLdGNQbmlMNG96bkdMRHI2WncrTnIyOFNBWmJLUi9PYkdlSDVvYW0zYlFs?=
 =?utf-8?B?ajk4aGxZd2VaM1pnQitDRVNIWEw3K3pZRXcxL0d3SUtzMjUzNHloamxkS0Ri?=
 =?utf-8?B?VGlFOFI5dXpWaVJId3ZFOWZaZ1R4NTBwbWhtK051UUdRK1lRNjVXYldaR0l2?=
 =?utf-8?B?cXhoNzNUdm9sZjBZWU5HdXhPcUUvaTVVODFGeWtia3dLOW0xOU8rc1krSHNZ?=
 =?utf-8?B?UEdxbTNnY2lGTGxYcDI4bC9NbzdXbDczWHpyTlRRMzlZNEo0ekhja2NQUHBG?=
 =?utf-8?B?Mk1XUzYwNzZ6dnV5UE5KZHp0QktLSmZ3dWFBYlA0MDlYZVdKWU1MYmw2QTdh?=
 =?utf-8?B?U0piRDZjZWFiUUtZZmM0QzVoa0g1Um1nWm50bHkzR0c3a2gyK1lyTkNqTWZp?=
 =?utf-8?B?VFJjeTlEUXc3a2N2VXZOdGxZMG9DeVltclR4dWRDZm4xNkdvcDVUei8yc2s0?=
 =?utf-8?B?UVhDKzJKV0N3eEZuN1lvUFJJaFlMWEtTZk9XbkhXakhvZVk5ZThjUlZBT3N4?=
 =?utf-8?B?U2gzZVhQeWM3R1JlOWlEeGw5YlpGcjBJTDl6aGxrWXRyWHltWHdKRXg5VnFw?=
 =?utf-8?B?RTAyZzhkME9PS0pOSGpPc3NKZ3g4Y0hZSm1RbmpoZkxLQTcyK2gzelBhTlBz?=
 =?utf-8?B?MzhVY1I4NEhUUXpmLzdDbElKeU1PbGd3ci9lcS9zSFJNK1NFTVRQU2MvMHRJ?=
 =?utf-8?B?WDdmSysvVFFSRHV6YjM4QVJmQzhqcG1QcHlIK2JaVVFaUnlxLzIrQXFpSmd0?=
 =?utf-8?B?U0JVQTRjNTJleFBTTVlKKzNNZlZ0MkM3UUFvaGhQR2s1S3hlbHE5bmRyOExu?=
 =?utf-8?B?YXNoc0wwc3ROWEFoUU5OdU1FU0o1YWdaVWVRUUlBTlBTd3JjRStscUY3V3lG?=
 =?utf-8?B?OXNkUi9lbU4wb3N0MTVPNXBCaDdPUzJYSkMvb1BncjBsd0JMZWhnUjlyckFL?=
 =?utf-8?B?Q2pmVE1JdUdkS0FSNENUZldybkJqZzZ1ZWRkaG9pT2t3bEYwU1Y5R0VsU3JZ?=
 =?utf-8?B?UU9zNm5ySm85TytXc2VYMmhqQlh1RnBwQmsrTlROaFZJL251YThZSkFMMDlk?=
 =?utf-8?B?cDF0UTZlbHhsekphUEp2L0VpZXYrMDB2c1JYcEJjV1RJNEtNems0SUlodlBI?=
 =?utf-8?B?cFkzRVlLcGJsTkJycWY4VUY0aSszSy95WUN3eEdWL1BPbEQ3MlJXbEJtaHBu?=
 =?utf-8?B?ZVlqR24rTG1VbU5XNkxGYzBqUUUvbEhHTEhlcXRIWDBSeDM1dC96TmlvaU4w?=
 =?utf-8?B?RGw3Q0c5UnVLeDdtQ0RaZ2RNemtyNGVsNFc4bFZNUElGMXVHMTRNaUliS2xv?=
 =?utf-8?B?ZmtqaXgrM3lKbVpXK1o2aElVUlZFK3FybVFDbTdqSXI1S0UyaENLd1J0Y0lv?=
 =?utf-8?B?MFRkY203M0dSSkhmbGtGU3BHeit0dnhFcGFLOWNHYjYwam55dzRHOVhqNG84?=
 =?utf-8?B?dncvOXhUdnlEQ1ZheDhVL3VRMitLcFdXbzBhSURRQ3M5NmdQMFEzN1ptYnFS?=
 =?utf-8?B?OGMwQ05PSGtMaDd1WVoveitvR3BPN0dUQmkwUkJnSlR1VEFNcTBnZ3BybTNt?=
 =?utf-8?Q?uy34zN+ONzzCTuSOuf3+TRblr+7uU6Sv17TyJZhNas=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4035bdf4-1ca5-4929-2e40-08d9f239e6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 17:21:14.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5s6ZgiT+Ee6VeJc4Fpr7Z7FG9rbf2qEWpO4Lb90v2JkOzWa5VpCv1OsQRoXvuaRQ1RVEM2hleCaUhR5LU77EAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1952
X-Proofpoint-GUID: kWGK_WCmcQeDBlC3QXaOAhLdJA1q3qtn
X-Proofpoint-ORIG-GUID: x0oCjmamRJ9qXeN14naHGri32unFbyKc
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_06,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW5nIFh1IDxjaGVuZ3lv
dS54Y0BhbGliYWJhLWluYy5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAxNyBGZWJydWFyeSAyMDIy
IDA0OjAxDQo+IFRvOiBqZ2dAemllcGUuY2E7IGRsZWRmb3JkQHJlZGhhdC5jb20NCj4gQ2M6IGxl
b25Aa2VybmVsLm9yZzsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IEthaVNoZW5AbGlu
dXguYWxpYmFiYS5jb207IGNoZW5neW91QGxpbnV4LmFsaWJhYmEuY29tOw0KPiB0b255bHVAbGlu
dXguYWxpYmFiYS5jb20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0ggZm9yLW5leHQgdjMg
MDAvMTJdIEVsYXN0aWMgUkRNQSBBZGFwdGVyIChFUkRNQSkNCj4gZHJpdmVyDQo+IA0KPiBGcm9t
OiBDaGVuZyBYdSA8Y2hlbmd5b3VAbGludXguYWxpYmFiYS5jb20+DQo+IA0KPiBIZWxsbyBhbGws
DQo+IA0KPiBUaGlzIHYzIHBhdGNoIHNldCBpbnRyb2R1Y2VzIHRoZSBFbGFzdGljIFJETUEgQWRh
cHRlciAoRVJETUEpIGRyaXZlciwNCj4gd2hpY2ggcmVsZWFzZWQgaW4gQXBzYXJhIENvbmZlcmVu
Y2UgMjAyMSBieSBBbGliYWJhLiBUaGUgUFIgb2YgRVJETUENCj4gdXNlcnNwYWNlIHByb3ZpZGVy
IGhhcyBhbHJlYWR5IGJlZW4gY3JlYXRlZCBbMV0uDQo+IA0KDQpJcyB0aGlzIG9ubHkgYXQgbXkg
c2lkZT8gSSBkaWQgbm90IGdldCBbMDkvMTJdIG9mIHRoYXQgdjMgc2V0Lg0KSWYgeWVzLCBJJ2xs
IGZpbmQgYSB3YXkgdG8gY29tbWVudCBvbiB0aGF0IGFzIHdlbGwgaWYNCm5lZWRlZC4gSSBzZWUg
aXQgYXQgcGF0Y2h3b3JrLg0KDQpJIGFtIHRyYXZlbGluZyB0aGVzZSBkYXlzLCB0aGVyZWZvcmUg
Y2Fubm90IGNvbW1lbnQgYmVmb3JlIG1pZA0KbmV4dCB3ZWVrLg0KDQpUaGFua3MsDQpCZXJuYXJk
Lg0KDQo+IEVSRE1BIGVuYWJsZXMgbGFyZ2Utc2NhbGUgUkRNQSBhY2NlbGVyYXRpb24gY2FwYWJp
bGl0eSBpbiBBbGliYWJhIEVDUw0KPiBlbnZpcm9ubWVudCwgaW5pdGlhbGx5IG9mZmVyZWQgaW4g
ZzdyZSBpbnN0YW5jZS4gSXQgY2FuIGltcHJvdmUgdGhlDQo+IGVmZmljaWVuY3kgb2YgbGFyZ2Ut
c2NhbGUgZGlzdHJpYnV0ZWQgY29tcHV0aW5nIGFuZCBjb21tdW5pY2F0aW9uDQo+IHNpZ25pZmlj
YW50bHkgYW5kIGV4cGFuZCBkeW5hbWljYWxseSB3aXRoIHRoZSBjbHVzdGVyIHNjYWxlIG9mIEFs
aWJhYmENCj4gQ2xvdWQuDQo+IA0KPiBFUkRNQSBpcyBhIFJETUEgbmV0d29ya2luZyBhZGFwdGVy
IGJhc2VkIG9uIHRoZSBBbGliYWJhIE1PQyBoYXJkd2FyZS4gSXQNCj4gd29ya3MgaW4gdGhlIFZQ
QyBuZXR3b3JrIGVudmlyb25tZW50IChvdmVybGF5IG5ldHdvcmspLCBhbmQgdXNlcyBpV2FycA0K
PiB0cmFucG9ydCBwcm90b2NvbC4gRVJETUEgc3VwcG9ydHMgcmVsaWFibGUgY29ubmVjdGlvbiAo
UkMpLiBFUkRNQSBhbHNvDQo+IHN1cHBvcnRzIGJvdGgga2VybmVsIHNwYWNlIGFuZCB1c2VyIHNw
YWNlIHZlcmJzLiBOb3cgd2UgaGF2ZSBhbHJlYWR5DQo+IHN1cHBvcnRlZCBIUEMvQUkgYXBwbGlj
YXRpb25zIHdpdGggbGliZmFicmljLCBOb0YgYW5kIHNvbWUgb3RoZXIgaW50ZXJuYWwNCj4gdmVy
YnMgbGlicmFyaWVzLCBzdWNoIGFzIHhyZG1hLCBlcHNsLCBldGMsLg0KPiANCj4gRm9yIHRoZSBF
Q1MgaW5zdGFuY2Ugd2l0aCBSRE1BIGVuYWJsZWQsIG91ciBNT0MgaGFyZHdhcmUgZ2VuZXJhdGVz
IHR3bw0KPiBraW5kcyBvZiBQQ0kgZGV2aWNlczogb25lIGZvciBFUkRNQSwgYW5kIG9uZSBmb3Ig
dGhlIG9yaWdpbmFsIG5ldCBkZXZpY2UNCj4gKHZpcnRpby1uZXQpLiBUaGV5IGFyZSBzZXBhcmF0
ZWQgUENJIGRldmljZXMsIHVzaW5nICJyZG1hIGxpbmsiIGNvbW1hbmQNCj4gd2l0aCBhIGZpbHRl
ciBpbnNpZGUgb3VyIHJkbWFfbGlua19vcHMubmV3bGluayBpbXBsZW1lbnRhdGlvbiBjYW4gYmlu
ZA0KPiB0aGVtIHRvZ2V0aGVyIHByb3Blcmx5Lg0KPiANCj4gQmVzaWRlcywgdGhpcyBwYXRjaHNl
dCBjb250YWlucyBhIGNoYW5nZSBpbiBpd19xdWVyeV9wb3J0IHRvIGZpeCB0aGlzDQo+IGlzc3Vl
IFsyXS4gVGhpcyBjaGFuZ2UgbGV0cyB0aGUgZGV2aWNlIGRyaXZlcnMgZGVjaWRlIHRoZSByZXR1
cm4gdmFsdWUgb2YNCj4gaXdfcXVlcnlfcG9ydCB3aGVuIGF0dGFjaGVkIG5ldGRldiBpcyBOVUxM
LiBBZnRlciB0aGlzIGNoYW5nZSwgZXJkbWEgY2FuDQo+IHJlZ2lzdGVyIGRldmljZSBzdWNjZXNz
ZnVsbHkgaW4gcGNpIHByb2JlIGZ1bmN0aW9uLCBhbmQga2VlcCBwb3J0IHN0YXRlDQo+IGludmFs
aWQgdW50aWwgYSBuZXRkZXYgaXMgYmluZGVkIHRvIGl0Lg0KPiANCj4gRml4ZWQgaXNzdWVzIG9y
IGNoYW5nZXMgaW4gdjM6DQo+IC0gQ2hhbmdlIGNoYXIgbGltaXQgb2YgY29sdW1uIGZyb20gMTAw
IHRvIDgwLg0KPiAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBmaWVsZCBvciBzdHJ1Y3R1cmUgZGVmaW5p
dGlvbnMgaW4gZXJkbWEuaC4NCj4gLSBVc2UgZXhhY3RseSB0eXBlIChib29sLCB1bnNpZ25lZCBp
bnQpIGluc3RlYWQgb2YgImludCIgaW4gZXJkbWFfZGV2Lg0KPiAtIE1ha2UgaWJkZXYgYW5kIHBj
aSBkZXZpY2UgaGF2aW5nIHRoZSBzYW1lIGxpZmVjeWNsZS4gRVJETUEgd2lsbCByZW1haW4NCj4g
ICBhbiBpbnZhbGlkIHBvcnQgc3RhdGUgdW50aWwgYmluZGVkIHRvIHRoZSBjb3JyZXNwb25kaW5n
IG5ldGRldi4NCj4gLSBpYl9jb3JlOiBhbGxvdyBxdWVyeV9wb3J0IHdoZW4gbmV0ZGV2IGlzIE5V
TEwgZm9yIGlXYXJwIGRldmljZS4NCj4gLSBNb3ZlIGxhcmdlIGlubGluZSBmdW5jdGlvbiBpbiBl
cmRtYS5oIHRvIC5jIGZpbGVzLg0KPiAtIFVzZSBkZXZfe2luZm8sIHdhcm4sIGVycn0gb3IgaWJk
ZXZfe2luZm8sIHdhcm4sIGVycn0gaW5zdGVhZCBvZg0KPiAgIHByX3tpbmZvLCB3YXJuLCBlcnJ9
IGZ1bmN0aW9uIGNhbGxzLg0KPiAtIFJlbW92ZSBwcmludCBmdW5jdGlvbiBjYWxscyBpbiB1c2Vy
c3BhY2UtdHJpZ2dlcmVkIHBhdGhzLg0KPiAtIEFkZCBuZWNlc3NhcnkgY29tbWVudHMgaW4gQ00g
cGFydC4NCj4gLSBSZW1vdmUgdW51c2VkIGVudHJpZXMgaW4gbWFwX2NxZV9vcGNvZGVbXSB0YWJs
ZS4NCj4gLSBVc2UgcmRtYV9pc19rZXJuZWxfcmVzIGluc3RlYWQgb2Ygc2VsZi1kZWZpbml0aW9u
cy4NCj4gLSBSZW1vdmUgdW5zZWQgcmVzb3VyY2VzIGNvdW50ZXIgaW4gZXJkbWFfZGV2Lg0KPiAt
IFVzZSBwZ3Byb3RfZGV2aWNlIGluc3RlYWQgb2YgcGdwcm90X25vbmNhY2hlZCBpbiBlcmRtYV9t
bWFwLg0KPiAtIFJlbW92ZSBkaXNhc3NvY2lhdGVfdWNvbnRleHQgaW50ZXJmYWNlIGltcGxlbWVu
dGF0aW9uDQo+IA0KPiBGaXhlZCBpc3N1ZXMgaW4gdjI6DQo+IC0gTm8gImV4dGVybiIgdG8gZnVu
Y3Rpb24gZGVjbGFyYXRpb25zLg0KPiAtIE5vIGlubGluZSBmdW5jdGlvbnMgaW4gLmMgZmlsZXMs
IG5vIHZvaWQgY2FzdGluZyBmb3IgZnVuY3Rpb25zIHdpdGgNCj4gICByZXR1cm4gdmFsdWVzLg0K
PiAtIEJhc2VkIG9uIHNpdydzIG5ld2VzdCBrZXJuZWwgdmVyc2lvbiwgcmV3cml0ZSB0aGUgY29k
ZSAobWFpbmx5IENNIGFuZA0KPiAgIENNIHJlbGF0ZWQgcGFydCkgd2hpY2ggb3JpZ2luYWxseSBi
YXNlZCBvbiBhbiBvbGQgc2l3IHZlcnNpb24uDQo+ICAgdmVyc2lvbi4NCj4gLSByZW1vdmUgZGVi
dWdmcy4NCj4gLSBmaXggaXNzdWVzIHJlcG9ydGVkIGJ5IGtlcm5lbCB0ZXN0IHJlYm90Lg0KPiAt
IFVzaW5nIFJETUFfTkxERVZfQ01EX05FV0xJTksgaW5zdGVhZCBvZiBiaW5kaW5nIGluIG5ldCBu
b3RpZmllcnMuDQo+IA0KPiBbMV0gSU5WQUxJRCBVUkkgUkVNT1ZFRA0KPiAyRHJkbWFfcmRtYS0y
RGNvcmVfcHVsbF8xMTI2JmQ9RHdJREFnJmM9amZfaWFTSHZKT2JUYngtc2lBMVpPZyZyPTJUYVlY
UTBULQ0KPiByOFpPMVBQMWFsTndVX1FKY1JSTGZtWVRBZ2QzUUN2cVNjJm09OWd4ckJYRzdibFJh
eXh0b2llblNWZzdZeVBQSk1BQXU0RTduOA0KPiBmMGlWYjAmcz1rdHM3SlR4aWViLXVjT0QzVXV1
RFJjNVVqMTFWZlp6RGFHZ000c3FTamE4JmU9DQo+IFsyXSBJTlZBTElEIFVSSSBSRU1PVkVEDQo+
IDNBX19sb3JlLmtlcm5lbC5vcmdfYWxsXzIwMjIwMTE4MTQxMzI0LkdGODAzNC0NCj4gNDB6aWVw
ZS5jYV8mZD1Ed0lEQWcmYz1qZl9pYVNIdkpPYlRieC1zaUExWk9nJnI9MlRhWVhRMFQtDQo+IHI4
Wk8xUFAxYWxOd1VfUUpjUlJMZm1ZVEFnZDNRQ3ZxU2MmbT05Z3hyQlhHN2JsUmF5eHRvaWVuU1Zn
N1l5UFBKTUFBdTRFN244DQo+IGYwaVZiMCZzPXBWeVprMVRVUjVrd1RLbFN3eHZ3UnlxS0N0OEFC
S1J4TmY1UXplODYwTGMmZT0NCj4gDQo+IFRoYW5rcywNCj4gQ2hlbmcgWHUNCj4gDQo+IENoZW5n
IFh1ICgxMik6DQo+ICAgUkRNQTogQWRkIEVSRE1BIHRvIHJkbWFfZHJpdmVyX2lkIGRlZmluaXRp
b24NCj4gICBSRE1BL2NvcmU6IEFsbG93IGNhbGxpbmcgcXVlcnlfcG9ydCB3aGVuIG5ldGRldiBp
c24ndCBhdHRhY2hlZCBpbg0KPiAgICAgaVdhcnANCj4gICBSRE1BL2VyZG1hOiBBZGQgdGhlIGhh
cmR3YXJlIHJlbGF0ZWQgZGVmaW5pdGlvbnMNCj4gICBSRE1BL2VyZG1hOiBBZGQgbWFpbiBpbmNs
dWRlIGZpbGUNCj4gICBSRE1BL2VyZG1hOiBBZGQgY21kcSBpbXBsZW1lbnRhdGlvbg0KPiAgIFJE
TUEvZXJkbWE6IEFkZCBldmVudCBxdWV1ZSBpbXBsZW1lbnRhdGlvbg0KPiAgIFJETUEvZXJkbWE6
IEFkZCB2ZXJicyBoZWFkZXIgZmlsZQ0KPiAgIFJETUEvZXJkbWE6IEFkZCB2ZXJicyBpbXBsZW1l
bnRhdGlvbg0KPiAgIFJETUEvZXJkbWE6IEFkZCBjb25uZWN0aW9uIG1hbmFnZW1lbnQgKENNKSBz
dXBwb3J0DQo+ICAgUkRNQS9lcmRtYTogQWRkIHRoZSBlcmRtYSBtb2R1bGUNCj4gICBSRE1BL2Vy
ZG1hOiBBZGQgdGhlIEFCSSBkZWZpbml0aW9ucw0KPiAgIFJETUEvZXJkbWE6IEFkZCBkcml2ZXIg
dG8ga2VybmVsIGJ1aWxkIGVudmlyb25tZW50DQo+IA0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICA4ICsNCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9LY29u
ZmlnICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9k
ZXZpY2UuYyAgICAgICAgICB8ICAgIDcgKy0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9NYWtl
ZmlsZSAgICAgICAgICAgIHwgICAgMSArDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEv
S2NvbmZpZyAgICAgICB8ICAgMTAgKw0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL01h
a2VmaWxlICAgICAgfCAgICA0ICsNCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRt
YS5oICAgICAgIHwgIDI4OCArKysrDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJk
bWFfY20uYyAgICB8IDE0NDAgKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9lcmRtYS9lcmRtYV9jbS5oICAgIHwgIDE2NyArKysNCj4gIGRyaXZlcnMvaW5maW5p
YmFuZC9ody9lcmRtYS9lcmRtYV9jbWRxLmMgIHwgIDUxMiArKysrKysrKw0KPiAgZHJpdmVycy9p
bmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2NxLmMgICAgfCAgMjAyICsrKw0KPiAgZHJpdmVycy9p
bmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2VxLmMgICAgfCAgMzY2ICsrKysrKw0KPiAgZHJpdmVy
cy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2h3LmggICAgfCAgNDgwICsrKysrKysNCj4gIGRy
aXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV9tYWluLmMgIHwgIDYyOSArKysrKysrKysN
Cj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV9xcC5jICAgIHwgIDU2NyArKysr
KysrKw0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX3ZlcmJzLmMgfCAxNDQ3
ICsrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2Vy
ZG1hX3ZlcmJzLmggfCAgMzQ1ICsrKysrDQo+ICBpbmNsdWRlL3VhcGkvcmRtYS9lcmRtYS1hYmku
aCAgICAgICAgICAgICB8ICAgNDkgKw0KPiAgaW5jbHVkZS91YXBpL3JkbWEvaWJfdXNlcl9pb2N0
bF92ZXJicy5oICAgfCAgICAxICsNCj4gIDE5IGZpbGVzIGNoYW5nZWQsIDY1MjMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5maW5p
YmFuZC9ody9lcmRtYS9LY29uZmlnDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbmZp
bmliYW5kL2h3L2VyZG1hL01ha2VmaWxlDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9p
bmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2luZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfY20uYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV9jbS5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2NtZHEuYw0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV9jcS5jDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2VxLmMNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfaHcu
aA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRt
YV9tYWluLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJk
bWEvZXJkbWFfcXAuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5maW5pYmFuZC9o
dy9lcmRtYS9lcmRtYV92ZXJicy5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbmZp
bmliYW5kL2h3L2VyZG1hL2VyZG1hX3ZlcmJzLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL3VhcGkvcmRtYS9lcmRtYS1hYmkuaA0KPiANCj4gLS0NCj4gMi4yNy4wDQoNCg==
