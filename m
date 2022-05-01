Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28A75164AF
	for <lists+linux-rdma@lfdr.de>; Sun,  1 May 2022 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiEAOVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 May 2022 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEAOVo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 May 2022 10:21:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D80537BCE
        for <linux-rdma@vger.kernel.org>; Sun,  1 May 2022 07:18:18 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24175S1x001241;
        Sun, 1 May 2022 14:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=vJ/Ok1pHikirUn6P4/kzH14WULCfr+fa73mKHxbEmsQ=;
 b=YqnFW9y8yngU/zkG4Tfo6FR7d1bOIFQtm9dW4kRRERz/Dr+y22kgVhh9LMQB2tRB2Zof
 rPci4thl0i4aKXm+bZYc8LxXxOscYt/pW1BfBreu0Fx4+ZNKWDHDU9fMSvdk28P1MEvw
 u4LfclD58XhwQXAM8M0UegM545x71hWQrYQCZ6m89yp+IfBDJhw3dkTsVY0csJPIRBLR
 KXz3mW0X5NVSPAFWHykUPXPwgLXR9PAJ91I6w2Z2A4lLAxEk3BdVdiPmGx3qU8x+9n2e
 qu/ls0POTU/C1sCiZrXEV+Qm6KMVgZEPJZNSvMob9DaVz27RvTR0t27jQOQFQcPWg91D 6A== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fsedth939-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 May 2022 14:18:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/Sy0AFwaVuVUkcLaK/ghQp2owQQLesSLPSXVx0p6WW3e3GmrcSVmk3j29qLO1vyTe5q8HQt7qrIDlZ5OVLz6KwhExkN7t3WFARQhDPCy3ACAA/EPZQWiOjKHs6SZ5kFVga4H7VWJwps/555aW82UF+2WX8/XBspNX3cBxZ1fJd1vkHgCTlyltVjp3G+V/EzEcg46bRAp4LwrI5eYE01GLfgNuZmDBUnaawOLhOMuboS9CKJIIPOuKIUt5D962+ATojzfhFtcg9i2hdPWUUC+E2hb6efVx+UVfs38f+77LDBXKhP0zURiFBjwlIw542YXUKPaxhmwkHbihrxU4/pDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ/Ok1pHikirUn6P4/kzH14WULCfr+fa73mKHxbEmsQ=;
 b=VsTmKGh+yu29KMhWbZ4qO5PFTM71d5yJERgmpuY4pqmU/o7glOicoxuuU6haoiBSCnCuxtRVbPIdjFxxFN7yVgxRmELHBu2uo3pFQlP3TP71tJ8e7p12k8RQKvnkU/wiTQ6MIpQb+QOB6HOeIsz+AbUJD/O1x+ybjTrqFz31LDt/oSAU9L9CDMSWaWTeNaZYN4Lolg56ngqm4mn5LrHYDp3yfObLZI97g6oPFliQCRKUE+k2e9H6t9LjuVVARcJ9dSGtIYIw1H8ahdn5FMbPQt3FqjVr5ku5vliU3EPreo/PH13um2BMH2SwUfxyfE/4/UkPwTR2/Sas6lkeVYPkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by DM6PR15MB2731.namprd15.prod.outlook.com (2603:10b6:5:1a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 14:18:14 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3%7]) with mapi id 15.20.5206.014; Sun, 1 May 2022
 14:18:14 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: Enable siw on tunnel devices
Thread-Topic: [PATCH] RDMA/siw: Enable siw on tunnel devices
Thread-Index: AdhdZknq2jgD5B2IR0yMDpmefDAxhA==
Date:   Sun, 1 May 2022 14:18:14 +0000
Message-ID: <BYAPR15MB2631F0F28155C7DDDD1BCCFD99FE9@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc775aa7-195a-4475-c9da-08da2b7d6de5
x-ms-traffictypediagnostic: DM6PR15MB2731:EE_
x-microsoft-antispam-prvs: <DM6PR15MB273140F12290BCAE7C446E3A99FE9@DM6PR15MB2731.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RebIxdtog2T5b5Gi4ODkaDQqIZ8XU06s/wcDSixuIHxSi++X4IfP1ZU24JyZQ/1iOuR1dAha0+vjXMnnO3EdnNpUhzBrX8e5K1oYPVTmZAXRqGtK+hjZP4Jmm7PQe49Ctc+v8Fcvie2s1s3llNo273CDNpzgGx9SYwVIBPDrvh9o4TkbM/bhAxuNYHNHCWPVixR4pPZcxddD+IVRVWXaZklwrxlTnKowL3oXrCxDbK9xXmsivjfyc7MQGy6cr5hzRA3pPXTUwWKZGT9668hTkgbejsGhzhyM8S2OJvB/XaIeBW1d0CLNa2VqkPHD3xJ3CPNKycAaU3rPqsGYgM7fLN+v+C3A9s5qSODsFoCABQSfIswUjl33Y99byTxq+Cu4fibn51JKJv8Yem2VM5uGIx2BWhNLtws3/yD8chEQ+Ew3ug1z6qwYy96ct5gGF/GFNCV/Ol/1eXHvfRhmxhHYLg5bKbYwbAh/UoWUuB/Kioh2RgDlidNUiu12/ED+CxDQVggs38uBS/zgklFtGWDjlBWZhSoURYCAL00+rF2iMRkYjJw3/5iToAbYQwXzSZB4rl2kaq1b8WcBmxkwriErSXeq7631onjISSdafK0ickeG+mzQPXeHRV3szLJvMyJEZybWEijEiliGdHUd7gGzFef57BhEt4qoTp7XF/Z5Vg6gzs1/qnLFx9RExpZTnh7aPEUzRvxs35ApELOOIQTb3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(186003)(7696005)(33656002)(53546011)(508600001)(6506007)(6916009)(316002)(55016003)(71200400001)(38070700005)(38100700002)(122000001)(86362001)(83380400001)(76116006)(4326008)(8936002)(8676002)(5660300002)(66446008)(66476007)(66556008)(64756008)(66946007)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFiTmFkVzBPR2VEdS9uNi8xLzluVkJrQnViWC94V0tKVmwzbnJWcUhWL21m?=
 =?utf-8?B?Slczd2N1cXJ5dklPenNodDhDTW51TzZERS9BSTVlRTJwZXUrc1B5N0I3eitN?=
 =?utf-8?B?dURTUjN1dlJzWTBXK3Iya2NNRjFJcnZEMjhCcmlLd05tckpoTG1qUFJ4aGlp?=
 =?utf-8?B?KzZzS3pWSFl2M05YcU5KaGpJV0l4SVBaS3RRYmtxYXNmU003VVdOQy85Z2VJ?=
 =?utf-8?B?TTlwWjBVcTRrakwxQ2FndktZbG91cHMzdlIxVG11NFpWbE1JMEVJYTBKc2RJ?=
 =?utf-8?B?NmxPdDlucUFCcGhHczEyUEM3U0RrUUFOSVVQbEVLR1M4SG1oVjFTQ1A4emQ1?=
 =?utf-8?B?cnU4enFXSzdCbnhRdmw2UTNPcXhaaFZCZmdsYy8rZ2M2bHIwMks5am50Q1pX?=
 =?utf-8?B?Wlk0b2daYUhRWTcyU1UvMm9JQkREcFl3bVN0TlFRN2NmTTdoKzBhM1FBcFd6?=
 =?utf-8?B?cGZuNENKc1FkWmxYQXhWOTJrMU1SNGhVM0dmWGxTaVE3OHVRcDlwTzNGU1NL?=
 =?utf-8?B?ZjBiOGpjZzNRVGdGS3RpR0Z6VVkzQTdPVUdjeGYwRmJXZ2V0b1A5NWxuMjFo?=
 =?utf-8?B?VXBNaEZoakxscE1nVzQ2RlNPSzdKYklYQmo5OTczNlY1VUhSQmNSMHlaZzRJ?=
 =?utf-8?B?eTBRSm8vbWtkdWZYUGRDTmRkbUdFRjEyMHZONU5VUU16cEZ1ZTZ6MmFUN0xm?=
 =?utf-8?B?V2luVENEQW9KWXJ5azhNMXdwSno3cTU0dnlMVldLV1RiUlp2ZWQxTldMQmo1?=
 =?utf-8?B?TU5hb3p1Q2FVdCt1dnpLQmhaM2RsV3pVYTVyU3pPT2pIOHVCKzhEdDZuclNW?=
 =?utf-8?B?QXJIclUxQ29uK1gvcUQ5ZmNMbndncE94cElnL1oyOG9pUDUxTmN2VGtYcHNH?=
 =?utf-8?B?VXdDR0YvaEFNT0FTb1J0TjBScTgvdkJSckpSRXlac2RDWUt5bHdZVStvWWZJ?=
 =?utf-8?B?dFFQRWNjWUZlSHkxeWxvWER4aExJRWZkaG85YjV0b09qSWhPRTBPSGRjQk5F?=
 =?utf-8?B?TDZ5U1J3MzlsTVVQVnZ3MXNabjFWZWpsM1FlOG1YL3dPU2dlNGJyMElFK0NW?=
 =?utf-8?B?MkE1V0tzUGFQR0hUWUc2djZtTlFNUWN5TlBOOHQ3Tm5JVkZvNkVLcEMrR2h1?=
 =?utf-8?B?eHFqRmg4LzUveFpMbXRiSzF1SHUvUnVXSmIxVTFHVWVUV1RCaU5GZ2JubWMr?=
 =?utf-8?B?dUF1Y3laYmhtZ1VhRFR6aWlOc2tuNUFDeGoyVjlwd3ZNM0RIckhYY3U3S1Ft?=
 =?utf-8?B?dVEwQmlNWFdKdTNhU05nb2IxWVl5dHRuVmJSRllPSHNZVTF4SkxNOHpud1hN?=
 =?utf-8?B?SklJeUVHd3o0VDc1eTdYbDUzY0daTmQ5WUtNRWFyc2NaOXJNR2FjUjNmVVZV?=
 =?utf-8?B?YUhkajVlNVdFRDhRSG9kRjlGaHJQTk1DTXhXR3RPYmlLWmoxL3I2bDQ2UjJQ?=
 =?utf-8?B?eTVIUFNLT1VIVWM0SXRocEtqRDJaWGczc1ZIWXN6WTRHSGtMSHNua25wZEpu?=
 =?utf-8?B?YXh4NndyZE42Z2RUUlpQT0hOR3lQUk1xYlVKeWpLMXNXbVUxWDlxdzJsRHB5?=
 =?utf-8?B?alE3WjZmMHNRQlRwOWQvRkxXVXNldlNRYlFVWmZ1WDB1WTFWY25JVTZnUlZQ?=
 =?utf-8?B?QWptVXdyRXlPK3JVRjN4NDJ4bzYrcDNJcUlXSmJyTWZIaDRCMjFJU0VSK1dL?=
 =?utf-8?B?djlYVnNpY0lPaEM0U3QzNldaUGJjOEFUQXo0b0duZmhieVF5ZXNNOE5XdEor?=
 =?utf-8?B?VVZyMGxOSzRUMjNGRjFabkkxY2p2a2diZW1XeFViQTVBSzQyRTVQRVVPdWFP?=
 =?utf-8?B?OFBCZVZQTldueUs3ZXh2SW02Rmw5YjUxODhoUEh6djhGNTN6MGJ3aDh0bWk0?=
 =?utf-8?B?Ulk4b2VkMFBUYVBlUnVrMEhQS0pKVDV5OEJjK2JNa3M4b0c4MUtNNnVSdXRt?=
 =?utf-8?B?S2FnUk5qUDllZUpremVETmpCTWl4YWdmcFRFQjZoQ0xLNmFBK09LeC9KUGZD?=
 =?utf-8?B?cFFGU0tFdWZkYnJRSFNsK3RIdXlneno0UUVGdXRMTnpMeGkrUjF3UjNWMnV6?=
 =?utf-8?B?Nm1ZUmpXNEo2TGdMTnpoTE9wSTFoSndJRnQ2bUFCNE14SUZCV0hnMkNuMzcw?=
 =?utf-8?B?cm9UZW5ST1l2Ymt5Tm1tVjVtenZ3WHZwZXhtNHFzTUhNWnVkSWk1RnByZlZv?=
 =?utf-8?B?UHB1MThEMDhELzN6RktjS3ZEQm53WGpaS3k4UFA5R0JkbS85NVNIMDNiZGpL?=
 =?utf-8?B?Z01vTS93eDVJTG4xUFJ3cWE4K0xRNVZ1dUFyL2tnc05JcG1samFpWkRRVnpD?=
 =?utf-8?B?aysrdHBHT2JjUHFsSVdLZlZSZGgvUEFmcHhHQkVFVVkzQlN5elh1d24wbUhh?=
 =?utf-8?Q?ON893jCZqOoZAj72YZLqfQXsHp/lVpA+r63GavfgRO6Dv?=
x-ms-exchange-antispam-messagedata-1: Z38C3cplNP8aTg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc775aa7-195a-4475-c9da-08da2b7d6de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 14:18:14.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbvIYCvwPDq5oia+Xct0FWLJo8p2uRyH/eGmOFS379Cr1li6YjuMQ8iz5KfUvtbVGHmdYMg2YCHinIq0xLPHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2731
X-Proofpoint-GUID: 027-K7kit6xreKvNYqJ2kOXAn8NDWMiW
X-Proofpoint-ORIG-GUID: 027-K7kit6xreKvNYqJ2kOXAn8NDWMiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_05,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205010113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1Y2sgTGV2ZXIgPGNo
dWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAyOCBBcHJpbCAyMDIyIDE5
OjQ5DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGxp
bnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIXSBS
RE1BL3NpdzogRW5hYmxlIHNpdyBvbiB0dW5uZWwgZGV2aWNlcw0KPiANCj4gRnJvbTogQmVybmFy
ZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZXJu
YXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19tYWluLmMgfCAgICA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IEhpIEJlcm5hcmQhDQo+
IA0KPiBIb3cgY29tZSB0aGlzIGNoYW5nZSBpc24ndCBpbiB0aGUgdXBzdHJlYW0gc2l3IGRyaXZl
ciB5ZXQ/DQo+IA0KPiANCg0KSGkgQ2h1Y2ssDQpHb29kIHF1ZXN0aW9uISBEaWQgSSBldmVyIHNl
bmQgdGhlIHBhdGNoIHRvIGxpbnV4LXJkbWEsIG9yIHdhcw0KdGhhdCBjb252ZXJzYXRpb24gb2Zm
LWxpc3Q/IFNvcnJ5IGZvciBhc2tpbmcsIEkgY2FuJ3QgZmluZCBpdCBpbiBteQ0Kb3IgbGludXgt
cmRtYSBoaXN0b3J5Li4uDQoNClRoYW5rIHlvdSENCkJlcm5hcmQNCg0KDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gaW5kZXggZTVjNTg2OTEzZDBiLi5kYWNjMTc0NjA0
YmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0K
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gQEAgLTExOSw2
ICsxMTksNyBAQCBzdGF0aWMgaW50IHNpd19kZXZfcXVhbGlmaWVkKHN0cnVjdCBuZXRfZGV2aWNl
DQo+ICpuZXRkZXYpDQo+ICAJICogPGxpbnV4L2lmX2FycC5oPiBmb3IgdHlwZSBpZGVudGlmaWVy
cy4NCj4gIAkgKi8NCj4gIAlpZiAobmV0ZGV2LT50eXBlID09IEFSUEhSRF9FVEhFUiB8fCBuZXRk
ZXYtPnR5cGUgPT0NCj4gQVJQSFJEX0lFRUU4MDIgfHwNCj4gKwkgICAgbmV0ZGV2LT50eXBlID09
IEFSUEhSRF9OT05FIHx8DQo+ICAJICAgIChuZXRkZXYtPnR5cGUgPT0gQVJQSFJEX0xPT1BCQUNL
ICYmIGxvb3BiYWNrX2VuYWJsZWQpKQ0KPiAgCQlyZXR1cm4gMTsNCj4gDQo+IEBAIC0zMTUsMTIg
KzMxNiwxMiBAQCBzdGF0aWMgc3RydWN0IHNpd19kZXZpY2UgKnNpd19kZXZpY2VfY3JlYXRlKHN0
cnVjdA0KPiBuZXRfZGV2aWNlICpuZXRkZXYpDQo+IA0KPiAgCXNkZXYtPm5ldGRldiA9IG5ldGRl
djsNCj4gDQo+IC0JaWYgKG5ldGRldi0+dHlwZSAhPSBBUlBIUkRfTE9PUEJBQ0spIHsNCj4gKwlp
ZiAobmV0ZGV2LT50eXBlICE9IEFSUEhSRF9MT09QQkFDSyAmJiBuZXRkZXYtPnR5cGUgIT0NCj4g
QVJQSFJEX05PTkUpIHsNCj4gIAkJYWRkcmNvbmZfYWRkcl9ldWk0OCgodW5zaWduZWQgY2hhciAq
KSZiYXNlX2Rldi0NCj4gPm5vZGVfZ3VpZCwNCj4gIAkJCQkgICAgbmV0ZGV2LT5kZXZfYWRkcik7
DQo+ICAJfSBlbHNlIHsNCj4gIAkJLyoNCj4gLQkJICogVGhlIGxvb3BiYWNrIGRldmljZSBkb2Vz
IG5vdCBoYXZlIGEgSFcgYWRkcmVzcywNCj4gKwkJICogVGhpcyBkZXZpY2UgZG9lcyBub3QgaGF2
ZSBhIEhXIGFkZHJlc3MsDQo+ICAJCSAqIGJ1dCBjb25uZWN0aW9uIG1hbmdhZ2VtZW50IGxpYiBl
eHBlY3RzIGdpZCAhPSAwDQo+ICAJCSAqLw0KPiAgCQlzaXplX3QgbGVuID0gbWluX3Qoc2l6ZV90
LCBzdHJsZW4oYmFzZV9kZXYtPm5hbWUpLCA2KTsNCj4gDQoNCg==
