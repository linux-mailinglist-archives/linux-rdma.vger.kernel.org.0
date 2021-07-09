Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC03C27BA
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jul 2021 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhGIQsN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jul 2021 12:48:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25802 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGIQsN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jul 2021 12:48:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169GacRK003338;
        Fri, 9 Jul 2021 16:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aS62XLqmZqfAzhXgqG7ZBGw4Zzc9UiKEd7Z8J7bUDy4=;
 b=P41VYTjazRZ6BfhtWKH3ZQTJQ47VvuDuMgB/MLkLqMrWj0peJ3/DO5A80VZnNfWLTAB3
 AugS4n4UAH1WDIj9LsZ0Fl6Q6bMBHq8tBI2NwPKR4msSA9RLDimI6JRa28DHbFV0mDVK
 fLKp1AUbu6pCUIPuhrfKmce8mAkym1kXNjaXMG4mhP1R5jrSNeSIt2O1u2K1MvdCTi40
 nZepp8W01frcCcUmyxG9Tc4Gor8Tj3ren96bGOqUGVVloL90PYDhGJqTIVbFRdlfp7lF
 COK+bunU+cqDQm+d6LJFDUdqvhES3OJBlSHG8+BQZ0hezA9VAt4ZNG7Yuv2f5Wtat/Ma Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39pgxa972w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 16:45:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 169GaerG004832;
        Fri, 9 Jul 2021 16:45:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 39k1p5ena5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 16:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c66CzbJS7qGlgIhHQdEnQDm+zmvns/1tAaAg4R6nQMnJMkI/rvdc46HzfGAp6qba1WpO+vq9zQhbiNpkkZt59m86rzQ6ID8yL7t30NenYYsOhj7otc4OLVbXoS1ixS/8SklUOHcLfCjPMkQmULgJAd45oh5HWnwCdEDz7KQEHpuXQjQ+KMmeEzKFYptVRjQjsEoevsmoGPeiyJZiDsrNuv1N8Q7ImT4XDiyk2qzETcyQ7XdKoStv7IlYnuY7lSzpuGUDCe+fRfdyw+siTLlszBLHtVbtExs7iaNVqPDSn9ZAIelowY1FzGPFKhgp/5gDEJIuUPpuyQInGbBQ4CS5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS62XLqmZqfAzhXgqG7ZBGw4Zzc9UiKEd7Z8J7bUDy4=;
 b=UKVKMrdbrw6gIvEFzcpMh0Z/9oHmbqxnn1abla7z04JJ+ry9uyIv6Y5MBZfnH/DuMR4rnJJkYfKa2Y899ksZpddMgaF3KyJO+b3UYbSxwtKLqnHK2dhg0JOOO9mVA40fkyei5c0xAZL4aBhCuQNrOI9Z4H69zD4HEHOBbRNc4sofTesyugmOs9v3YMZRmUc03epZyeUwzsaLkB5ZzGFWlbaqw/OVLgGg+BBK7puBifJmp24N+XvEVeCZcYv6z0T6oBFOKJeCZ6daVSasW3aCB6PyTMTv7aMSrp8Ljm46YHfmgdO6XpR/j90VCjoDSBEBFhXSbuRGUX5g+UBiGCzluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS62XLqmZqfAzhXgqG7ZBGw4Zzc9UiKEd7Z8J7bUDy4=;
 b=auVVUuMauxFsO8QDz88hkzfoHEzGKFlFI5DviAERFAgI5lCbc4zy/4OC3BsIa6e0lkLHjigszoiRmr5OkQSq4x/bkIF6sfWCn6UIxXEbVRFhBErPEzqo8oV9IdenlVqhiGS+SRaT3Rai3LQcRB1vYm48s14xpXuna7iHuA/iJro=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM5PR10MB1675.namprd10.prod.outlook.com (2603:10b6:4:e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.19; Fri, 9 Jul 2021 16:45:22 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194%6]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 16:45:22 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Topic: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Index: AQHXQa3Y4CAWkou9VES/lh4Y7MmmMarc+byAgAAeRYCAAAWSgIBOOSGAgAma8wCAAAlKgIAEpiWAgAAwT4CAAW7aAA==
Date:   Fri, 9 Jul 2021 16:45:21 +0000
Message-ID: <0F551BD8-4179-4090-B739-F30202A0BEE6@oracle.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
 <20210510191249.GF1002214@nvidia.com>
 <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
 <20210705162628.GT4459@nvidia.com>
 <DACDFAFC-1851-4965-BCB6-FA83E72EC29C@oracle.com>
 <106645E4-DF2C-4DCB-A82F-ADECEBD242CA@oracle.com>
 <20210708185219.GA1541340@nvidia.com>
In-Reply-To: <20210708185219.GA1541340@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87400c64-4b19-436f-3036-08d942f8f17a
x-ms-traffictypediagnostic: DM5PR10MB1675:
x-microsoft-antispam-prvs: <DM5PR10MB16754A61B652F3DE81ACF511FD189@DM5PR10MB1675.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpCJ/f5nJ89vdujwMxLraLuMvHaKCsXAGpFbX6ajWdIj1qMmDq66Yjm0eTGOy/HCL9WMxwripxscCXbW/EO53fz5V9Mn+V42CDse5BgcZtPcOWykE7eE88ZDzPdbPmPjUNOQb73BKMvSKytG6HrPf/AISfd4uDqMoNKT17YW+BTuJ3bbuKvLvRsUxq6iS01RaYh7xmBmeFnaAQHHVKsAoV99T95yo0hY1Xvsk8HviNJYHgGlIKijAeR+X5GPixqzUQsTnE6QoHmXvehF3yT55K7bKcOriGVIsEagkmLJO/CWFSqI2rKaOXNcdPDzeFfs6ScIIR5YlQ+0BoxJyltD1BQ1tlrNK48DYxCu1VhTDXZJKYg3Vu8eOUXRHQmgu089oDxXQY1RlIm/b7R60Y2Hu4nYPnCo2S9pdpbFzbBEx1Nl0VknBoJIhw9LQA1Kp+FqIi0jvSNeTNAC1YMubmKUUx3DVi9OTmPz2oErj6dw2idmkvjSoE0K2v4HUZleuT3nO1V5V/pScirwfexGHdH3lalvqhsmcuXoA9VCt6epYXZO/92ApaC2F1H+DYxrGeEQZywMlrr4jlcAXBs27wZWwqAtOP/8c24kTNwlxdlBWuz8Y4k9wgSwjKyqIUCQfh4GLv/KY9NK5J1JIIjcnapP7wOAnDf1CCXhqhF7QskF934fKPR7a3MQ+gZlD0qvkfmSm5Xr6M+YKdktFrgKpi/s3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(66946007)(91956017)(66446008)(66476007)(478600001)(66556008)(33656002)(64756008)(83380400001)(86362001)(122000001)(38100700002)(186003)(53546011)(26005)(76116006)(8676002)(66574015)(8936002)(6506007)(36756003)(44832011)(6512007)(71200400001)(5660300002)(54906003)(316002)(4326008)(2906002)(15650500001)(6486002)(2616005)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3c3cXFEMW5oV21TWmpTYkd5NHAvckY1NUxDVE11dS9CTFJNSnh0c1lNS05O?=
 =?utf-8?B?RU5lUWp1cjI3cGdyVmVyWmY4NTd5bmovdlc1ekpHRnlJRVlwUEVYU0VVQk9N?=
 =?utf-8?B?bndzUzZmdlFtckl4Z01YMW9jSzBNL09RWWxNVG40WTVQRjNPeW1yYnIvblls?=
 =?utf-8?B?RU1XckdwUWp6bUJRSzdIZ3RaTFU2VG1aZ1ZCL0szL1NzY3lUcUJOT21DcEdS?=
 =?utf-8?B?RXNTMHR3OFFDZUF0b2ZjaWdQL0VjUXBWdUdaRGVseExlZkQvdndMOHhPZ1N1?=
 =?utf-8?B?NlZvRW9QdkRLN090MzhxZUtnN1RDU1dnMVB5MDVybk1WejR2Y1NlcFBRWW1m?=
 =?utf-8?B?b1huenh1cVE3MDAzdy9naDRJeGljWW5DWEZ0WE9vaFBKTVNOMWd2VzhITGF1?=
 =?utf-8?B?ajh4MG02S3RyQ2pGUnhxdE9LS0ZXTzEvazZOdzg3eWx6VkZWRHo3UTRscGJt?=
 =?utf-8?B?WXBQTGw1d0FxN3ZlN0ZqbWwzdXJtQWR4V3hhajRraEQ5bTNlcnlxUDBSRkR3?=
 =?utf-8?B?aVVRYnRkOFF4bkZyQ05NMmwzT2MwQ0drUkI0bWh2YWM4dkpDRmpTbXRrekxq?=
 =?utf-8?B?aUFIL3RWREdWcUlDeWtDeUF0alVRWFRxU1hIUVRYYklDZU9HR1ppMUlSZWZ5?=
 =?utf-8?B?ZUdoM0NxSXptSldCSGIvdSsxbGN6bXRyTnh5VWt1amFnSU5wVmZoRkkwemk4?=
 =?utf-8?B?M05FSUNpb3FVNnNxSWxpL1ZUa3psRjJQVm5NUmczTHNBaFR3Qm94a3RwcUlt?=
 =?utf-8?B?TCtPZjduQmQ4TnN0eVVacThDNSszK1J3SEM0MFJPbzljR3JGK3VOVGFzVmN3?=
 =?utf-8?B?eGtEQWc0aE90NTZ3SzhEWEdDTytWT0lHVmRROWtiYTJIK3lkOERGM3ZrNll4?=
 =?utf-8?B?ZEhQdUxLc0lzektNRitWUkMwREROSk52NnBvcEZ4RktISzN1enVrTDF6SnJC?=
 =?utf-8?B?eHZiNy83ekE4bEZjT2hUOE9TRG5LWnF2RDl6M3dDMzkrK014dk82M2pBN1Mv?=
 =?utf-8?B?YWpRUG02c0pMaG03TEdRbkF2d1NsWDFncXRuNGNaUVpBSW5IdnpKV3JQaWdC?=
 =?utf-8?B?VkhGMkhlQjVIMWZIM1JrVVRrY2YwRzdMSFExVVh3RE1mMjJtZDI0Vk5ac2lx?=
 =?utf-8?B?M2t5bnQyZy8zNHcrdmFmT1hKWkVHc29mZjNwY3p6QTRyWWY0VkcrSEVkZUoz?=
 =?utf-8?B?WTYycVNaOUw3TWNGSWRxdjZybmZZcmZnYVNGeFNNQjF1dUZieXZ0M1lsL0Zk?=
 =?utf-8?B?c0Q0L0F0eWJ4TmcrYSt1U2hCNUVwY1h4L2N5amRkYTBKaEppSU13aWdXcC9s?=
 =?utf-8?B?Qi82V2VDbzhYVk1rb21tSVR3VWE1TTU2T3ZpWjhsYWpBOC9JTmxyZWsyclZI?=
 =?utf-8?B?ZUtCdzQrTUFseTlSUllad0E2V2ZIZ1VRRTllMytsOTU0SUpqTzVrNjVBWkcx?=
 =?utf-8?B?Nm8yRFUraTNRWDFWMkxtN3R6ZlNXZGRzS1lIcDZWQStYak5ENklDZ0pFQTNL?=
 =?utf-8?B?akp2TEhMUVpMdXJmNFRPR2FsczlwS3RQdFl1VG5GTlpadnRiYWRCclFOWHpH?=
 =?utf-8?B?LzVaN1pLdmxxWXJZdGN1a3hialhmSFBmUUxTQ0pROWxVdWljbjAzdXE2RXgw?=
 =?utf-8?B?OWZ1eGVGVWxOb3QrZjVZYVByMTZhR2FoQW5ZRjhJS2duSmFzMXhsalhkOEhx?=
 =?utf-8?B?ZjZHUDRLazE1U0pUTk1QM1hCcUZTNm13VGtYcnZxZWEycUlJVWwvV2lLcVRN?=
 =?utf-8?B?MmMycGZNcjJyQXdJRzEyMEFUTlhrengrOEVPRDlVMVVTeGsyTDhEV2hHRk1o?=
 =?utf-8?B?KytKSVhEQ1FzaUh3b2piZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9345D9EC54E1E54EA48DC18173873F81@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87400c64-4b19-436f-3036-08d942f8f17a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 16:45:21.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkxPaS0YApaHV/VhG0pfKYktrwJmcwPj5XPEMMVlhXCrR1j8QxNXsKe6p6nD7mQUzUav6MKCXc9yuGXHv3/yUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1675
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090083
X-Proofpoint-GUID: DzJHMDbEtd_VXN9KYu23P1UK5cfZrBQU
X-Proofpoint-ORIG-GUID: DzJHMDbEtd_VXN9KYu23P1UK5cfZrBQU
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gOCBKdWwgMjAyMSwgYXQgMjA6NTIsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMDgsIDIwMjEgYXQgMDM6NTk6MjVQTSAr
MDAwMCwgSGFha29uIEJ1Z2dlIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiA1IEp1bCAyMDIxLCBh
dCAxODo1OSwgSGFha29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4gd3JvdGU6DQo+
Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIDUgSnVsIDIwMjEsIGF0IDE4OjI2LCBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIFR1ZSwgSnVuIDI5
LCAyMDIxIGF0IDAxOjQ1OjM1UE0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+Pj4gDQo+
Pj4+Pj4+PiBJTUhPIGl0IGlzIGEgYnVnIG9uIHRoZSBzZW5kZXIgc2lkZSB0byBzZW5kIEdNUHMg
dG8gdXNlIGEgcGtleSB0aGF0DQo+Pj4+Pj4+PiBkb2Vzbid0IGV4YWN0bHkgbWF0Y2ggdGhlIGRh
dGEgcGF0aCBwa2V5Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlIGFjdGl2ZSBjb25uZWN0b3IgY2Fs
bHMgaWJfYWRkcl9nZXRfcGtleSgpLiBUaGlzIGZ1bmN0aW9uDQo+Pj4+Pj4+IGV4dHJhY3RzIHRo
ZSBwa2V5IGZyb20gYnl0ZSA4LzkgaW4gdGhlIGRldmljZSdzIGJjYXN0DQo+Pj4+Pj4+IGFkZHJl
c3MuIEhvd2V2ZXIsIFJGQyA0MzkxIGV4cGxpY2l0bHkgc3RhdGVzOg0KPj4+Pj4+IA0KPj4+Pj4+
IHBrZXlzIGluIENNIGNvbWUgb25seSBmcm9tIHBhdGggcmVjb3JkcyB0aGF0IHRoZSBTTSByZXR1
cm5zLCB0aGUgYWJvdmUNCj4+Pj4+PiBzaG91bGQgb25seSBiZSB1c2VkIHRvIGZlZWQgaW50byBh
IHBhdGggcmVjb3JkIHF1ZXJ5IHdoaWNoIGNvdWxkIHRoZW4NCj4+Pj4+PiByZXR1cm4gYmFjayBh
IGxpbWl0ZWQgcGtleS4NCj4+Pj4+PiANCj4+Pj4+PiBFdmVyeXRoaW5nIHRoZXJlYWZ0ZXIgc2hv
dWxkIHVzZSB0aGUgU00ncyB2ZXJzaW9uIG9mIHRoZSBwa2V5Lg0KPj4+Pj4gDQo+Pj4+PiBSZXZp
c2l0aW5nIHRoaXMuIEkgdGhpbmsgSSBtaXMtaW50ZXJwcmV0ZWQgdGhlIHNjZW5hcmlvIHRoYXQg
bGVkIHRvDQo+Pj4+PiB0aGUgUF9LZXkgbWlzbWF0Y2ggbWVzc2FnZXMuDQo+Pj4+PiANCj4+Pj4+
IFRoZSBDTSByZXRyaWV2ZXMgdGhlIHBrZXlfaW5kZXggdGhhdCBtYXRjaGVkIHRoZSBQX0tleSBp
biB0aGUgQlRIDQo+Pj4+PiAoY21fZ2V0X2J0aF9wa2V5KCkpIGFuZCB0aGVyZWFmdGVyIGNhbGxz
IGliX2dldF9jYWNoZWRfcGtleSgpIHRvIGdldA0KPj4+Pj4gdGhlIFBfS2V5IHZhbHVlIG9mIHRo
ZSBwYXJ0aWN1bGFyIHBrZXlfaW5kZXguDQo+Pj4+PiANCj4+Pj4+IEFzc3VtZSBhIGZ1bGwtbWVt
YmVyIHNlbmRzIGEgUkVRLiBJbiB0aGF0IGNhc2UsIGJvdGggUF9LZXlzIChCVEggYW5kDQo+Pj4+
PiBwcmltYXJ5IHBhdGhfcmVjKSBhcmUgZnVsbC4gRnVydGhlciwgYXNzdW1lIHRoZSByZWNpcGll
bnQgaXMgb25seSBhDQo+Pj4+PiBsaW1pdGVkIG1lbWJlci4gU2luY2UgZnVsbCBhbmQgbGltaXRl
ZCBtZW1iZXJzIG9mIHRoZSBzYW1lIHBhcnRpdGlvbg0KPj4+Pj4gYXJlIGVsaWdpYmxlIHRvIGNv
bW11bmljYXRlLCB0aGUgUF9LZXkgcmV0cmlldmVkIGJ5DQo+Pj4+PiBjbV9nZXRfYnRoX3BrZXko
KSB3aWxsIGJlIHRoZSBsaW1pdGVkIG9uZS4NCj4+Pj4gDQo+Pj4+IEl0IGlzIGluY29ycmVjdCBm
b3IgdGhlIGlzc3VlciBvZiB0aGUgUkVRIHRvIHB1dCBhIGZ1bGwgcGtleSBpbiB0aGUNCj4+Pj4g
UkVRIG1lc3NhZ2Ugd2hlbiB0aGUgdGFyZ2V0IGlzIGEgbGltaXRlZCBtZW1iZXIuDQo+Pj4gDQo+
Pj4gU29ycnksIEkgbWlzLWludGVycHJldGVkIHRoZSBzcGVjLiBJIHRob3VnaCB0aGUgUEtleSBp
biB0aGUgUGF0aCByZWNvcmQgc2hvdWxkIGJlIHRoYXQgb2YgdGhlIGluaXRpYXRvciwgbm90IHRo
ZSB0YXJnZXQncy4gT0suIFdpbGwgY29tZSB1cCB3aXRoIGEgZml4Lg0KPj4gDQo+PiBPbiB0aGUg
c3lzdGVtcyBJIGhhdmUgYWNjZXNzIHRvIChydW5uaW5nIE9yYWNsZSBmbGF2b3VyIE9wZW5TTSBp
bg0KPj4gb3VyIE5NMiBzd2l0Y2hlcyksIHRoZSBiZWhhdmlvdXIgaXMgZXhhY3RseSB0aGUgb3Bw
b3NpdGUgb2Ygd2hhdCB5b3UNCj4+IHNheS4NCj4gDQo+IENoZWNrIHdpdGggc2FxdWVyeSB3aGF0
IGlzIGhhcHBlbmluZywgaWYgeW91IHJlcXVlc3QgYSByZXZlcnNpYmxlIHBhdGgNCj4gZnJvbSB0
aGUgQ00gdGFyZ2V0IChsaW1pdGVkIHBrZXkpIHRvIHRoZSBDTSBjbGllbnQgKGZ1bGwpIHlvdSBz
aG91bGQNCj4gZ2V0IHRoZSBsaW1pdGVkIHBrZXkgb3IgdGhlIFNNIGlzIGJyb2tlbi4NCj4gDQo+
IElmIHRoZSBTTSBpcyB3b3JraW5nIHRoZW4gcHJvYmFibHkgc29tZXRoaW5nIGluIHRoZSBzdGFj
ayBpcyB1c2luZyBhDQo+IHJldmVyc2VkIHNyYy9kZXN0IHdoZW4gZG9pbmcgdGhlIFBSIHF1ZXJ5
Lg0KPiANCj4gSXQgaXMgbm90IGludHVpdGl2ZSBidXQgdGhlIFBSIHF1ZXJ5IHNob3VsZCBoYXZl
IFNHSUQgYXMgdGhlIENNIFRhcmdldA0KPiBldmVuIHRob3VnaCBpdCBpcyBydW5uaW5nIG9uIHRo
ZSBDTSBDbGllbnQuDQoNClRoYXQgaXMgbm90IGhvdyBpdCBpcyB0b2RheS4gQW5kIGJlY2F1c2Ug
b2YgdGhhdCwgYWxsIGFjY2Vzc2VzIHRvIHRoZSBQUiBhc3N1bWUgdGhlIGR7Z2lkLGxpZH0gaXMg
dGhlIHJlbW90ZSBwZWVyLiBUbyBmaXggdGhpcywgSSBoYXZlIHRvIHN3YXAgZGdpZC9zZ2lkIGFu
ZCBpYi5kbGlkL2liLnNsaWQgYWxsIG92ZXIgdG8gZ2V0IHRoaXMgd29ya2luZy4gVGhhdCBpcyBw
ZXJ2YXNpdmUuIEUuZy4sIGV2ZW4gaW5jbHVkZXMgaXBvaWIuIExldCBtZSBrbm93IGlmIHRoYXQg
aXMgd2hhdCB5b3Ugd2FudC4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4gVGhpcyBpcyBiZWNh
dXNlIHRoZSBSRVEgaXMgc3VwcG9zZWQgdG8gY29udGFpbiBhIHBhdGggdGhhdCBpcyByZWxhdGl2
ZQ0KPiB0byB0aGUgdGFyZ2V0Lg0KPiANCj4gRXZlcnl0aGluZyB3aWxsIGJlIHRoZSBzYW1lIGV4
Y2VwdCBmb3IgdGhpcyBzbWFsbCBkZXRhaWwgYWJvdXQNCj4gZnVsbC9saW1pdGVkIHBrZXlzLg0K
PiANCj4gVGhlIGNsaWVudCBjYW4gZmlndXJlIG91dCB3aGF0IHRvIGRvIHdpdGggaXRzIG93biBw
a2V5IHRhYmxlIGxvY2FsbHkuDQo+IA0KPj4gInRoZSBQX0tleSB0YWJsZSBlbnRyeSAoMHgxMjM0
KSBtYXRjaGluZyBpbmNvbWluZyBCVEguUF9LZXkgZGlmZmVycyBmcm9tIHByaW1hcnkgcGF0aCBQ
X0tleSAoMHg5MjM0KSINCj4gDQo+ICJUaGUgUkVRIGNvbnRhaW5zIGEgUEtleSAoMHgxMjM0KSB0
aGF0IGlzIG5vdCBmb3VuZCBpbiB0aGlzIGRldmljZSdzDQo+IFBLZXkgdGFibGUuIFVzaW5nIGFs
dGVybmF0aXZlIGxpbWl0ZWQgUGtleSAoMHg5MjM0KSBpbnN0ZWFkLiBUaGlzIGlzIGENCj4gY2xp
ZW50IGJ1ZyINCj4gDQo+IEphc29uDQoNCg==
