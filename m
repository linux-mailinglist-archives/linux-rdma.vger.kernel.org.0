Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C927430855B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jan 2021 06:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhA2Fuj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jan 2021 00:50:39 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:48010 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232008AbhA2Fug (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Jan 2021 00:50:36 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10T5YTmk001232;
        Fri, 29 Jan 2021 05:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Crt+f0AbTnPaZL2ezyR7W9Rxu+pqvGVA5BB8gA9Xmsc=;
 b=MfZThnPWzZqBK44TMl2jPxAhcNiWoBGCYU8leCZx1zw/7WFJ5MCZ2UWn/gLvQqtj79WA
 koIe7sQ+ZcoDxkQhUdVSbjKVhmfuao5bjWvqL779twagSXNXn6wdLTSvGuARTAiXoygD
 kVFYig7mw4m8/9P+NVyt59GiaAY+2nGZ68B0CdRCO08LEdFrjpYfiC7rH+6iGM6ZTnQ8
 iR28OP4ODQogLAWPyhHROyy2n6mr8grXNZNiOot0vohWq79ffYsLflxjBxaMZiMfSp7T
 INLTVRdyS924gB7xC6cc4i/7aVVoN0kb3e/8zdWF+f0ZJVlikPm+C5CRTOJK+X1SCpae 3g== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 36bcf15ny2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 05:49:46 +0000
Received: from G9W8455.americas.hpqcorp.net (g9w8455.houston.hp.com [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id B15454F;
        Fri, 29 Jan 2021 05:49:45 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 29 Jan 2021 05:49:45 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 29 Jan 2021 05:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGMtpOTeprLg/h44QJgX95JUd6pcnZQXY/qb6ZqVyeEeCa8Uy8yAGPZFU5Kb0NU2UxPjRcE6e7tnjyFebtscvPZuCO2dHyPmEKO0kBMzImNPXSpcARr21Owr+JfbA8XcJtV8UICMlnsUsEHlmWMTNLXcw2+Wv1zQ9uJduCJ/dBTLCQHcb5ANqdKBSWTnZpk1vxxQ7KOy3ez+hCq34+ppjeBBnv7drE0he2iR5M/QMHDUkuzxnYg+7jlSi7dAXgDDJKfbZPI1v+IvAAulI7SO6YektJ/F68TutfaO16+u+pNUer9g3k7ZBHP/WGF3RQWOxpycA7hyINdbH5fupGIFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crt+f0AbTnPaZL2ezyR7W9Rxu+pqvGVA5BB8gA9Xmsc=;
 b=myGB8W41Ag/hbT2LO+iWqRrkl1rbzKfWv2Z/uQicDzUANVIOCizmAisWLi90ad/0BIUxOn7T8zAk62c3kYqmc3x3+HsylhzAha1PPjqI/JcTKU5PD0sD3FkJ1sAxKy52eUVRdro44EDQhYdLBIwWyVW02HHGaLPxLf1jlpncLtqcpJh2RXprMq2FH2Eay61QEAMTHBgy3QgbuGa0KhuD2Sg6owWx8fUCcUE1XUfn/OcS0B7lD6wuz5fUEy3o1DLUubJBZhvYQZdqEXzOWw1rM7P+8Dsd2XoMCRQSDfo94jZn/OL8KovfdaRIC3C/hSYsmtD98FvOgMpaMQ0onrgeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB0600.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7509::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 29 Jan
 2021 05:49:44 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 05:49:44 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Thread-Topic: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Thread-Index: AQHW9ImNyfzWU0ybtUqjnD0r5FqHFqo7YAuAgAB/TACAAjqWAIAAAO0Q
Date:   Fri, 29 Jan 2021 05:49:44 +0000
Message-ID: <CS1PR8401MB082172C5F1CAD4D7ABD740B2BCB99@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
 <20210127120427.GJ1053290@unreal>
 <b4f0d73c-9624-b971-e56a-f1db02d683e3@gmail.com>
 <6013A038.9000903@cn.fujitsu.com>
In-Reply-To: <6013A038.9000903@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:e8ce:e6e3:ff39:a619]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5afe8583-f47e-484d-6cc6-08d8c419adda
x-ms-traffictypediagnostic: CS1PR8401MB0600:
x-microsoft-antispam-prvs: <CS1PR8401MB060099F23DA900B1562341D1BCB99@CS1PR8401MB0600.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hfIMN80hnbv/hAaXT0piaDHZ1020pMfzAiLr25wwvIqyBSVHiHIltuVShAmUpTLBx+QAIc9SLvb7i/bKAy7Y7ewdbcU7GRTkfl0OUnEc5apFJIISxeF7fBc7ft5vTgwAZTmqs4STca1Q0lslvro5RHG89kMP3kuZhri+vDMz88PfgeqVIfXVs/cv0lHubxym2Qrs/u0kpeSEclEOZ6T/a04FNRmypA5pH/4kQTTyMUrLy9AASI6R26tGXxbJ05hRrVAJPu8so1KY3iThyYqGYnUd7NtQD0VVMFN4JebbhU3Omej1Q4l2BNY00YgyBAJr6cU2fwsyjzw8gS7ZxOZK/aH1sRRc4i0aYXUVufGxl51NzOt4adIL9OzRM2XFPH+YAErC2xaxOe1AZ9bkYv2G6aEhm8vxfhgcoFc9NWdnOEe4VQoEbkedep75tpIpy6QvuTaQ0AdIcN7X4P6RXbRMAZPDXkoo043GtBJBEOU3LJgP+95f1IoHTs4NCvZ80oxiIf6XjcdJ4mvybWbkdTAEcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(39860400002)(346002)(7696005)(4326008)(55016002)(52536014)(478600001)(53546011)(71200400001)(9686003)(83380400001)(186003)(6506007)(86362001)(316002)(8936002)(66446008)(76116006)(5660300002)(64756008)(66556008)(54906003)(8676002)(110136005)(66476007)(33656002)(2906002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Sy9QNStaNUI2SWhpZnBCanJVWHBRekN1Mnk2TnJuUlZjaGhKTnVzSlBFS3Bt?=
 =?utf-8?B?MkVIcytTa3ByNkZNYXAyUmE2bXhSK2FVeGowZWhoL3l2THA0b1lVV2RVaVIv?=
 =?utf-8?B?K0NmNTRsWE5pdGhCUlhlQkdENzFjSDlwdGtHSnluQVR0c3VjRmo5UHo4Zmcv?=
 =?utf-8?B?aWRVSHAzeVMya2VwVmlzc2ZkZ2pBaE45QmxPN1N0L002YngyV2dlelh5VEgx?=
 =?utf-8?B?WFJ1aUJhV1crWXB1MDd6T29hTFpVS0RRRjUxaDB4TW0wZk9ua3BDb1hCaVRx?=
 =?utf-8?B?M3IzMmxNY3N3V3RvWk50NmUxM0gxMDZHWERTYS9LUHR4V2lwb2t3dHU5NG44?=
 =?utf-8?B?Q1ViV0NkYmY4Q09QTk5tR050QVFGbGt1N3JWSGkzR3V4cEVCYllucnU3ckRx?=
 =?utf-8?B?cGFWbzFTdE5iRFZtN282a2EzMjhCQVIxY01pVDRJTUJFQTNaM0FjWDZUUG1Y?=
 =?utf-8?B?L2VDYnVLbE8wS3NuWHRNeTZmYWIreXBUa2xOY0U5dlp6MW12b3ZQUEoyeUNo?=
 =?utf-8?B?KzdseW5aZ1MvcU9yRkxBYkN5aWR3QWRSS1VVN3JOYlZQV3dMYVlCalUyOHc0?=
 =?utf-8?B?R1dQdmQ4T25nUTBqQUMxcUZKYUVQK1RXdkQydlJmY1R4MCs4Q282Q1AvTDZi?=
 =?utf-8?B?UFRFMnFmN3RzSDdFb1o0eE9Qbm1uNkFPL2UxTFlvTTlVY0FXS1RYNnI3c25t?=
 =?utf-8?B?OVRLSk0xYVhHWS9idTVLMGwvMmRxcVZkZEFqdFlEZUJYK3JaR3RvUWhjYXQ3?=
 =?utf-8?B?VXpiYzA3bWQ5RHNWYzVqcEp3NUVrTkFMNGpKWlkvTHBSbUREbW9JN2ZBZFhq?=
 =?utf-8?B?MFFMQmpFL3EvRHNjMm1uNEd0TWZDczQzK2lYcUg3S25zTWkwZDZ3MFBUbFly?=
 =?utf-8?B?bG5haE1CSWk2eTBZbGs2eGRVb3Zla2JtRldlVEU5UldHMCtmcnlMUXZqMTFs?=
 =?utf-8?B?MElBVExsL2ZVMHlOS2NDM2pGZWRDZ0pqb000SnRNUXJlK3QyYml0TmFUWE9q?=
 =?utf-8?B?Ylc0U3dleFlxaU9RLy9SYWxNUitjcFdGRGovZGJuN1l5Z1VBRXNkdkhPR0xT?=
 =?utf-8?B?MkVnVm1XZC9TdFZrMCtNNG9JbFd4MXljcEJDc3lIVC95NUN1SU1aM0Jwc0xJ?=
 =?utf-8?B?ZkZvaVNianJuVnBOZEVUQVR4Q2lUMDNsOGZiVmUrQzNDc2x5RGtsMkU2TklP?=
 =?utf-8?B?TXhCOE41enFEeFg5YUJtS3Vmdm54VFRXY2hOems0VHZHNDRLcjFZVVhhY2FO?=
 =?utf-8?B?bEtYSEc3a0cvckRwMUtrUjRvQW5GdXhvMTZsdFlXcFRLVFgzejBsLzcxdXpB?=
 =?utf-8?B?V2x2S1piNE9qMCt1WkJZVGtoMUQwcmdUT2JFa1ZQMkV1emFISjdSYmhHbnZI?=
 =?utf-8?B?Q1pBemtrUUdvWXA1ODREek9GWmxkU05qbkRmVjEyYlJkNGZIOG80QnZaZDFQ?=
 =?utf-8?B?QVM3YkRNZFhRdVVGaVlhNUd5Q0I2QVk5SmVpN1pWOXhLcHVwVzBSUlZWUFBU?=
 =?utf-8?Q?PCajVQhMmjzFieaGbALV9xbw+4x?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afe8583-f47e-484d-6cc6-08d8c419adda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 05:49:44.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F33r0gFzBAeVcwJE1NvV94aEliVIycKuOC8Dr/9FWxnazhhzpIMlsWLKaxJSCukYdEkUoGGBSYf9cHCab+G33Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0600
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-29_02:2021-01-28,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290029
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBYaWFvIFlhbmcgPHlhbmd4Lmp5
QGNuLmZ1aml0c3UuY29tPiANClNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI4LCAyMDIxIDExOjQy
IFBNDQpUbzogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCkNjOiBMZW9uIFJv
bWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBq
Z2dAbnZpZGlhLmNvbQ0KU3ViamVjdDogUmU6IFtSRkMgUEFUQ0hdIFJETUEvcnhlOiBFeHBvcnQg
aW1tX2RhdGEgdG8gV0Mgd2hlbiB0aGUgcmVsYXRlZCBXUiB3aXRoIGltbV9kYXRhIGZpbmlzaGVk
IG9uIFNRDQoNCk9uIDIwMjEvMS8yOCAzOjQwLCBCb2IgUGVhcnNvbiB3cm90ZToNCj4gT24gMS8y
Ny8yMSA2OjA0IEFNLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+PiBPbiBXZWQsIEphbiAyNywg
MjAyMSBhdCAwNDoyNDozMVBNICswODAwLCBYaWFvIFlhbmcgd3JvdGU6DQo+Pj4gRXZlbiBpZiB3
ZSBlbmFibGUgc3Ffc2lnX2FsbCBvciBJQlZfU0VORF9TSUdOQUxFRCwgY3VycmVudCByeGUgDQo+
Pj4gbW9kdWxlIGNhbm5vdCBzZXQgaW1tX2RhdGEgaW4gV0Mgd2hlbiB0aGUgcmVsYXRlZCBXUiB3
aXRoIGltbV9kYXRhIA0KPj4+IGZpbmlzaGVkIG9uIFNRLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogWGlhbyBZYW5nPHlhbmd4Lmp5QGNuLmZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+DQo+Pj4g
Q3VycmVudCByeGUgbW9kdWxlIGFuZCBvdGhlciByZG1hIG1vZHVsZXMoZS5nLiBtbHg1KSBvbmx5
IHNldCANCj4+PiBpbW1fZGF0YSBpbiBXQyB3aGVuIHRoZSByZWxhdGVkIFdSIHdpdGggaW1tX2Rh
dGEgZmluaXNoZWQgb24gUlEuDQo+Pj4gSSBhbSBub3Qgc3VyZSBpZiBpdCBpcyBhIGV4cGVjdGVk
IGJlaGF2aW9yLg0KPj4gVGhpcyBpcyBJQlRBIGJlaGF2aW9yLg0KPj4NCj4+IDUuMi4xMSBJTU1F
RElBVEUgREFUQSBFWFRFTkRFRCBUUkFOU1BPUlQgSEVBREVSIChJbW1EdCkgLSA0IEJZVEVTIA0K
Pj4gIkltbWVkaWF0ZSBEYXRhIChJbW1EdCkgY29udGFpbnMgZGF0YSB0aGF0IGlzIHBsYWNlZCBp
biB0aGUgcmVjZWl2ZQ0KPj4gICBDb21wbGV0aW9uIFF1ZXVlIEVsZW1lbnQgKENRRSkuIFRoZSBJ
bW1EdCBpcyBvbmx5IGFsbG93ZWQgaW4gU0VORCBvcg0KPj4gICBSRE1BIFdSSVRFIHBhY2tldHMg
d2l0aCBJbW1lZGlhdGUgRGF0YS4iDQo+Pg0KPj4gSWYgSSB1bmRlcnN0YW5kIHRoZSBzcGVjLCB5
b3Ugc2hvdWxkbid0IHNldCBpbW1fZGF0YSBpbiBTUS4NCj4+DQo+PiBUaGFua3MNCj4+DQo+IFRo
aXMgc2VlbXMgYSBsaXR0bGUgY29uZnVzZWQgdG8gbWUuIHdjLmltbV9kYXRhIGlzIHNldCBpbiBy
eGVfcmVzcC5jIGluIHJlc3BvbnNlIHRvIGFuIGluY29taW5nIHJlcXVlc3QgcGFja2V0IHRoYXQg
Y29udGFpbnMgYW4gSU1NRFQgZXh0ZW5zaW9uIGhlYWRlci4gSS5lLiBhIHdyaXRlIHdpdGggaW1t
ZWRpYXRlIG9yIHNlbmQgd2l0aCBpbW1lZGlhdGUgb3Bjb2RlIGZyb20gdGhlIHJlbW90ZSBlbmQg
b2YgdGhlIHdpcmUuIFRoaXMgd2MgaXMgZGVsaXZlcmVkIHRvIHRoZSByZWNlaXZlIGNvbXBsZXRp
b24gcXVldWUgd2hlbiB0aGUgbWVzc2FnZSBpcyBjb21wbGV0ZS4gSXQgc2hvdWxkIG5vdCBoYXZl
IGFueXRoaW5nIHRvIGRvIHdpdGggdGhlIGxvY2FsIHNlbmQgd29yayBxdWV1ZSBlbnRyaWVzLg0K
SGkgQm9iLA0KDQpDdXJyZW50IHJkbWEgbW9kdWxlcyhlLmcgc29mdHJvY2UsIG1seDUpIG9ubHkg
c2V0IHdjX2ZsYWdzIHRvIElCVl9XQ19XSVRIX0lNTSBmb3IgdGhlIGNvbXBsZXRlZCBzZW5kIHdv
cmsgcXVldWUgZW50cmllcy4NCkkgYW0gbm90IHN1cmUgaWYgaXQgaXMgYWxzbyB0aGUgSUJUQSBi
ZWhhdmlvci4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IEJvYiBQZWFyc29uDQo+DQo+
DQo+IC4NCj4NCg0KDQpBaC4gVGhhdCBtaWdodCBiZSBhbiBpc3N1ZS4gSSdsbCBjaGVjayBpdCBp
biB0aGUgbW9ybmluZyBhbmQgZml4IGl0IGlmIGl0cyB3cm9uZy4gTm90IHN1cmUgd2hhdCB0aGUg
cHVycG9zZSBpcyBmb3IgdGhlIHNlbmQgY29tcGxldGlvbiBldmVudCBzaW5jZSB0aGUgdmVyYnMg
Y29uc3VtZXIga25vd3Mgd2hhdCB3YXMgcHV0IGluIHRoZSBzZW5kIHdvcmsgcXVldWUgZW50cnku
IE9uIHRoZSBvdGhlciBoYW5kIHRoZSByZWNlaXZlIGNvbXBsZXRpb24gZXZlbnQgY29uc3VtZXIg
bmVlZHMgdG8ga25vdyB3aGV0aGVyIHRoZSBpbW1fZGF0YSBmaWVsZCBpcyB2YWxpZC4NCg0KQm9i
DQo=
