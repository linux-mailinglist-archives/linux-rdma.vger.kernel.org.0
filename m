Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B06548B0A3
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbiAKPRJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 10:17:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23782 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231534AbiAKPRH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 10:17:07 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BFEXPM001294;
        Tue, 11 Jan 2022 15:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WDDGOTeVOmTtpP1nbPBvGLk79wG8rzD2dLE+GAmvglA=;
 b=XZaOQuqiK4jH0gwHg94CPnt4Wht0RIxN8X+Pxetw0W9CXp91TnE7jnxktK5WVSvlUWVi
 stswfb27LIBTwFspyMkXabVP8gFU3/inG+71zP03pOvsW+irCTIzVkFQOyDdG3WZTUh7
 UsDIUfAo8Z+kq3P2XETY6roJAzJXiC56fx1nfm2ZUB3iFmi/LFgXybIPnHTgqE9UaCuW
 BhX9V6bFWnH9h8+QWXxp6J6lXVZP39OLlUx+ZfxsoNvclhADn8gQOJ0xW83/NG6PRInm
 XWSLm1G9Z+FzHq1zHW8RfiVKTUfZW1PX67HssrvYKfn+eg3wv4ELyaNbmrRYduzbtpX8 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74b8d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:16:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BFGPQ3152390;
        Tue, 11 Jan 2022 15:16:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 3deyqxatmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw4BcR17Q+kZB0aV27oDF26bPYC+vWSZY8JPoHhNP2az34UrW8juDvNDO4uNbIT5nFc1gweqE+N8joELNECqnmTwJxofNu5jmPrPhkl6knmNFLqtMubhu/sfGXm0TDJ97rlLG/lscpm+Y7j+1mbav4FmDlNpF48Ef6hCGNo0JFvOiX1nEqhs4VaPXtf4vvW3gS/oVF0tKsc2DfHI2f4amUWhXcZohdFJbNfwJ/kcWzZUaIwCw4i7eLfevr1lh3F4DlxAJGhvuyzS0xP3TPYbSTRaylvWOZX2egYyZOGF2DeGLiTy91hkX50EmOO4S5IC4gKz38chCT19T/YYHClahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDDGOTeVOmTtpP1nbPBvGLk79wG8rzD2dLE+GAmvglA=;
 b=L4Gu6mL6bI0daAR0uMIwgNgOwiKw8AnoeyWLIn0a06fVAXOFIt1rIoesNFrkK+HOR28y2APcjIp3VXPu/qXxddHe8zWi0djNhF8BeXVVRSRw6nguxSgJXCn6EuCXkxxgM5ph6IGov/4zXhu2rljxHpt0c9iYBk3NG37xfxh85ekyzB8O59r/rttXhBsDJbw/fMf9YdhIBJtDeyII3+YBAokj/ZuMdHZ4/b3WZH6xRk3DiJYIhZSbsptsJhJV+NtTzUJz0NgLoUwCi47ummwdkAMAtCa/SvcK03kd6vGC0azezYZvPga6YTARbGa3E73YXCTpjUG94o6Lg7LiKdho9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDDGOTeVOmTtpP1nbPBvGLk79wG8rzD2dLE+GAmvglA=;
 b=yCL8HeZJRV9RV8sN/LLHqRPtY9J/uNY3ZJJUMqbj+lW8zQaoKdPpBdA0tYF4GI9/jPlmNzVceMbE6JL4CUp1bABM6IuGaFO4xztms7SmjFw3KTDMkFfoJhOORwvXxJDTvRYkSkWiJiryExdaQKDzo4rLCnjf0kchfBJ/QDxehFM=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by SN6PR10MB2480.namprd10.prod.outlook.com (2603:10b6:805:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 15:16:56 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:16:55 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
CC:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Topic: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Index: AQHX/GaSxhbS41Z1cUu1/sMQW6wiBaxVMxeAgAJNfwCABElLAIACMCcAgAAJsgA=
Date:   Tue, 11 Jan 2022 15:16:55 +0000
Message-ID: <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
 <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
In-Reply-To: <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebe20e55-12af-4a61-38f6-08d9d51567a7
x-ms-traffictypediagnostic: SN6PR10MB2480:EE_
x-microsoft-antispam-prvs: <SN6PR10MB248004D2051B0E8BE5BA4459FD519@SN6PR10MB2480.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVnUWPyr7LgQNEtwLww/UM+CWSrTcwvr9BvhqZtLUF0idkhrzKU2FRgNLwTnrwYK3L8qXXPurdFacQ8quxlT97wc6xOnHnqoN12zdk8MJmgIJL2Zp8TmaSRVk6KzyzJwVjBrHSFXELgftYxHIQ5OxA9q/Skf2cCqTrcJ1PMWChPXTTiY7QADdpAE8x+lpH/qHsy/rC2+ddG2qLdjG81XGBmUKLXDg+nZya0H3RP2zFoJUaby/TUu7lxaH+6rSMio6GC2HL7ZJ2rW28FSXab3Wu3AbF4qDYU7tGidmX1lcu5+uSCpVG12FWgL1FVZPkNK6axWB79qH92INJlxobxrFR2FOORTUPR96xMMkYzODFE3wHj1rdHmpx2MTchnv0A659uz9j3XXIJJpkKzTraHpyUMg0wQdcNk3yLN7qL/PbLZxibDKuAcZlUWK1hPAcYpevqjwFGgGU2Q5Gy0wW1yoFWWY5XxwGOQW5/h3PN/OA/rvzvjGn470Ea89SliJguwwSCk+X/94JB/0c1HbkEFGNYSE0DewPpbTLdsVwwXBJt5KRb77EclSZ55mc0kq4+72BCT8yG9ugkG7HlpO00bV+UQUUVxI9dlN3d1FKgNfOaamtpP7xKmVuA6pu+pEmFbRwZNyKh0v8z5ncu3rPsd03KZgTwelX6s5WZ0Mi9kXbJouTULS2V8+0+ierl+wRGBwTYHVFRe6dHb0mjw8kZ+LHqo7vFelrHSchEBjHEPNsU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(6486002)(186003)(64756008)(38100700002)(8936002)(6512007)(4326008)(2616005)(122000001)(66556008)(76116006)(66476007)(91956017)(66446008)(66946007)(6916009)(8676002)(86362001)(26005)(4744005)(45080400002)(53546011)(54906003)(316002)(5660300002)(508600001)(38070700005)(36756003)(83380400001)(33656002)(2906002)(6506007)(71200400001)(66574015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1NabjEveFRYcE4rc1JHT2xPdjliZXdyb3hFR05GOThOY0hGVlUwM25aT1U0?=
 =?utf-8?B?SXJ4OWNDaXBROTEyQ3U5QjNVVWsvcVdXc3lOeTdScXFVY1V3dXNvemJSdk5s?=
 =?utf-8?B?WjRnV2RuZXJoRDRmdGNuSnd1TVAvaXNTV043SUM5UG5LWExKKzhZZDNUSzVD?=
 =?utf-8?B?V3JRVUowTFowVUczd21xWi92NCtldU1NSnp1MmJXN1FEZEJzWlE4bExwWkJC?=
 =?utf-8?B?WjJFaEhZNFkxbXpobW15YmJhWkFEUnBjaDdBaXhGakN2SUsrRTJZSHFKR0JM?=
 =?utf-8?B?VUFuOHJmR2UvMDVoMVVtbk5oQVpEVSt4TzU3TitzRTZZNGc5b29OeEEydjJH?=
 =?utf-8?B?RVkwZXlDekt2RUEzQlA2bnpWOFVUNHU3ZGNLVGtsTmErb2hNWTYwclFrWU4x?=
 =?utf-8?B?ODgvOVlxNy84N3RtdEZ2cEx4T3NrY2FIQlhTdmVpVXdBSks4dkM4N2E0MlFv?=
 =?utf-8?B?L2lUYVhxUFpEdTFzaXNTaHdpYkxXdW5FdCtMbjR6blZmRXRWTnBXYnpjakxU?=
 =?utf-8?B?cVN2Q1c5SjYybFpVbGRlY3VVbUZ6SThWSStITVV6d0I0a2l4TjBUYkpnWDdt?=
 =?utf-8?B?RytsTGZZZFFsK0l0RkhVb01uaGJmTktTMHh1VHdZUXJjeFh6ZWhNRXJRd3VS?=
 =?utf-8?B?RnNLQk5rbE9RdDFoK28zVS9vbWxwMytid0plSFpPc0ZaUk5mcXFYeGJRajho?=
 =?utf-8?B?SGo5SWNSYzdPSUJqSlJ3M1pVNG8rNWIxUnBwMi9sck9tVnNsMmhIN3F0ZHBD?=
 =?utf-8?B?L2JqbXc5MXZwbmlZNnRHMUthZ2lJd095L2lmU1FTQW9Pczh2NVp2QnlKQ2hF?=
 =?utf-8?B?bi9xd3p0d2NXQmVVYTRUM3lXcHpuSjRjRkh2Ny91bWJESFlHZnJIU2hiam03?=
 =?utf-8?B?Q3JHYmFQcUM1RnZzS1lvVWM3Qm04SVQ3cUl0aG1mYnp0L1FDcjkxUndGUSsx?=
 =?utf-8?B?MHdJSHFnT0orL0ZMZmFsOUprSi80TEgvMUpGTFFnZjNPSzZCY3FkU1dtUDNY?=
 =?utf-8?B?K3kxMEVoVHNTdVFOdW0ydzJEdnNiR09QYzVKSzRUWTB5OVovUncxTTNtRnNz?=
 =?utf-8?B?dlZieStBc1RpUHRaK3k3bkVJaGFXdDhkblZZdW5xenBOM0VqU1ZoUUc5eFRL?=
 =?utf-8?B?a0xsRWFIOUlzNEVMSCtHSUl0emUxQldOVVAyMGV3ckU3MXAva1RUZXA5M3Nk?=
 =?utf-8?B?UXlNVnZGc2liaXBsTUNyY0NLcTJnZDllL2phMCs2Qk14VFpFMjA0Ym5vUGtN?=
 =?utf-8?B?eWdDaUV2dEpzVVdteUN5dVdTMnBtRFJMamV5N3VYZ0lnM3lXTmJDTWhWZ1Bs?=
 =?utf-8?B?NVJCOUZZNUZCN2xyMWgzMlQyem9VV0JUaGwrQTVSQlVwQTkzcWxYQ3V2QWhX?=
 =?utf-8?B?QkhLaVRrcVhMRTB4TFFxVVF5RndpUnlSZkJmODJTbnVRa3BWR0F5MnhtRy91?=
 =?utf-8?B?aHJidzNFWFZ4Kzgwa3BpM0hFbHZBT21reWFRUEJ1MHMvMFB1U1BaRFpFa0ZI?=
 =?utf-8?B?N1B1VTNaK3NvL0lrSWNCakxjR2QwVGdOUnhxb0x4R2s4Mlo3eHcydW5MWlVm?=
 =?utf-8?B?UmVpaUdDT2ZFUTBtM1pnT3FXMWh0YkV1aWN6eXpZZU5JUGhRNDdJUm9ZbFZR?=
 =?utf-8?B?Y09DVFE4NEdPazhUN1JjdjFpUlpmTGtqZ0pGR2dtOUlhSnRFVGp2Z2NtR25v?=
 =?utf-8?B?Qm0rV0FqaFQ5YVFmYmRBbDNSTVdobVIvczliemp0Nm9mL2FCN2VnWkVsZUIx?=
 =?utf-8?B?ZU1ZQ25rSnJxVFkyL3F5dzJQY0ROVGdKK3J6NG1KSVoyWGVGSUtWSlVFcFJE?=
 =?utf-8?B?MXJLUmp0bFJnK2tyaEVkWWRqemdjNmVyL1hlMjF1b2lrajRlVEFZQmRQY0tB?=
 =?utf-8?B?bi9jTGZmMTBUdmE0SzF6eEphZXkzcitub2F3WmRQbGlranhCSU1NYmhmNWJi?=
 =?utf-8?B?QVdRcnlwK2JRNjk2dkRoRmxPS0tXUWFwRnBNeWtPM0dJODNLQXpTSTdVOG5h?=
 =?utf-8?B?WmwvdTlqQW91blpORkpKTGpHQ1ZCRnZjM1F2ZlFkaGlNYm4xUTZQSkZxK2Vt?=
 =?utf-8?B?RTVVbU1PTldqbFkzb1o5aGliM2pQbFR6V1IvWEM0STBNQVpUYmgwVE4rRld4?=
 =?utf-8?B?NFEzY1huWnRPYm5CQTFqRUdIQURnelVrWUNWZjhKcm5TVjNGMWpHOFpqZVVn?=
 =?utf-8?Q?e6aSD4IouQjGgDjlMIGpLKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EFEB0099E3AF94F823D22BCC6AB8A3D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe20e55-12af-4a61-38f6-08d9d51567a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 15:16:55.9052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2J0hGlpayhdRiLm57ZKZOCOYKT+5/6Vrl3gZipUQLWichk/OslHC1GiEBJNgDjpK40l0Tkl31DWY++0wAT83Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2480
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=904 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110090
X-Proofpoint-ORIG-GUID: zVVD7TrKwGHgEjvmMRoysiW3ZH75_9QE
X-Proofpoint-GUID: zVVD7TrKwGHgEjvmMRoysiW3ZH75_9QE
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgSmFuIDIwMjIsIGF0IDE1OjQyLCBZYW5qdW4gWmh1IDx5YW5qdW4uemh1QGxp
bnV4LmRldj4gd3JvdGU6DQo+IA0KPiANCj4g5ZyoIDIwMjIvMS8xMCAxMzoxNywgeWFuZ3guanlA
ZnVqaXRzdS5jb20g5YaZ6YGTOg0KPj4gT24gMjAyMi8xLzcgMTk6NDksIFlhbmp1biBaaHUgd3Jv
dGU6DQo+Pj4gSXQgc2VlbXMgdGhhdCBpdCBkb2VzIG5vdCBtZWFuIHRvIGNoZWNrIHRoZSBsYXN0
IHBhY2tldC4gSXQgbWVhbnMgdGhhdA0KPj4+IGl0IHJlY2VpdmVzIGEgTVNOIHJlc3BvbnNlLg0K
Pj4gSGkgWWFuanVuLA0KPj4gDQo+PiBDaGVja2luZyB0aGUgbGFzdCBwYWNrZXQgaXMgYSB3YXkg
dG8gaW5kaWNhdGUgdGhhdCByZXNwb25kZXIgaGFzDQo+PiBjb21wbGV0ZWQgYW4gZW50aXJlIHJl
cXVlc3QoaW5jbHVkaW5nIG11bHRpcGxlIHBhY2tldHMpIGFuZCB0aGVuDQo+PiBpbmNyZWFzZXMg
YSBtc24uDQo+IA0KPiBIaSwgWGlhbw0KPiANCj4gV2hhdCBkb2VzIHRoZSBtc24gbWVhbj8NCg0K
TWVzc2FnZSBTZXF1ZW5jZSBOdW1iZXIuDQoNCg0KVGh4cywgSMOla29uDQoNCj4gDQo+IFRoYW5r
cyBhIGxvdC4NCj4gDQo+IFpodSBZYW5qdW4NCj4gDQo+PiANCj4+IEJlc3QgUmVnYXJkcywNCj4+
IFhpYW8gWWFuZw0KDQo=
