Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD132313B78
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhBHRsz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 12:48:55 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:28508 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235006AbhBHRro (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 12:47:44 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118HbMIn009779;
        Mon, 8 Feb 2021 17:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=qzy7dEbdRSVuwsXAp1BgU91a69eQaMJzkf/aHMRhYV8=;
 b=S5nPdpS9vRopbl2fVq7IusDdk70kIf2TNsF05K97zTmylBMfV+CAn3tfv1YQopSVvHUC
 AveZjei3tubvdhpUrEN47k1fOPKAVKySSTWDg6+lx1acdKms+M/BLpi7ifo3C6nIowGO
 Qqb6lfy2eR61OE6h4wBMSHOnowtiDDptCwulwcWr/DnJ/Dgg3mO9eyY+qCGG/5fS31vp
 VWmS7cuviA7kjmD5XXU7EB+m7w9xKxbzh+pdv/u2oMVhtT1QoJlsod31+yYk3BEQ0BhN
 yccMJi73VESZH6WnAEEtxggdpBmxQVVKrizgWHkD924EP+rk80pHbFsPIDHeEgj48q8o Wg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 36jymuwpay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 17:46:50 +0000
Received: from G4W9120.americas.hpqcorp.net (g4w9120.houston.hp.com [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 9472B59;
        Mon,  8 Feb 2021 17:46:49 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 17:46:49 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 17:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di985yz5H+llbAh9np1z9Y8Fw0w7FNuff2sn67JugY9dzvYC3hymnIw1pfIpyMaUREoKDm99/vUoXq+Cbd3ZZa68WZLpFPgALd8ZJqcP6yHNslP6zTdLFQUePuPKH5KwZEecNOcS7hnv3iq2ow1D6IEYQxUHOICCIyWGQeevTd+mKlDEW+hY5rlAVdeSqUJ/tBpCrfUyUzGtMY5UYvsladwMvtDD9AHW2lT0/FM02P4Fi03R9iM7KVbXmXf5Ik0vva9/B89me0Gvt2UYhHT+dv0zHanU3W9SPOW+jEhh9vJadicnZ32rvo8rHYOD0y/+cRB8m3FHASFkvZHOMyLVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzy7dEbdRSVuwsXAp1BgU91a69eQaMJzkf/aHMRhYV8=;
 b=hqk9Emb5DUO5XbHUNDpK9ocyTU03TVENxH7hWiUkFY41jq/0DFzz9oQJuQb0bhvjXxtV1H2cf2a/J82kXDapPkD34SCapi6Gkj5TSgJBGI56AdV0mm12EbowAcqLNr/beKRM+J6iDkfvPTmHPCEkFDUkvisZdTUY1mLIrlL3tW/RpocOj5GTGmPqCSece+UqEaxZro7zre7piPMxu8ystSDr7vTJyLGi9ATLYmsuJu/3CYC6q3JOifNWtltk8BHaUhuObX13cJ4ic36px1niJGzy6vsztZ8GoDGKO7dV2Pi3FddrMO/SYlUGl7NmbmRnUisssMJu4868mStn2UF4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB1126.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 17:46:47 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8%5]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 17:46:47 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Cleanup init_send_wqe
Thread-Topic: [PATCH for-next] RDMA/rxe: Cleanup init_send_wqe
Thread-Index: AQHW/B6E0K5rUxDVg0ucouRNzroWaapNlyIAgAD09VA=
Date:   Mon, 8 Feb 2021 17:46:47 +0000
Message-ID: <CS1PR8401MB08219C191399F7E5A266FFBBBC8F9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210206002437.2756-1-rpearson@hpe.com>
 <CAD=hENfXTKfZQ9ip7jWbtSjj8KPq58E5uRbcjieTA=TFXgovkw@mail.gmail.com>
In-Reply-To: <CAD=hENfXTKfZQ9ip7jWbtSjj8KPq58E5uRbcjieTA=TFXgovkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:ddfb:f657:acad:ed54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a52152f-61c0-481b-f594-08d8cc5981a3
x-ms-traffictypediagnostic: CS1PR8401MB1126:
x-microsoft-antispam-prvs: <CS1PR8401MB1126705D7C1E36CFC47A6CA9BC8F9@CS1PR8401MB1126.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wW2dyDNP8owoalt7FkaxZriOix4NzhGcrYPVVymg+A2V4nsdnixcAD+1J0Vhcgwnz5MZnM8b1S3DchB5sc3Ypq9+2RkCfnc0ickCS3QYN+afPeEI4jMLoeTTKq6YD1yVhCgqHSFI+hQzIFXRDY2WsrvUfZPFj60lIlzawYAK+KReHu5JiTtTxSNNRhL5/A1dgn30vhcKwfLDoQwQ0xqNLvbkslqIxZ682K7ll1niccZV0aPt2L8AYzR7qSl75wrXtCLI0cc4YDFXiMda8DT58ICTvCNKskTkKoLp13SVBmSUsbjNrbFkqZXJVsmU3YI9yE/vStLNx41HOG3USgwA3fV70/KrN/XO6yWkucXdMwmTfugLgOlyltf7MFNjdHDZKVwyYNsuHQk7NPY+XXV+L+nykDT+q60iC/NSz033ms6MgJyDSwo9Vt4UVE9ZuhUCwpxix4/TMex9icIVqYmXqTCCzopVzJDtB+48QUme1KKNdtb6CFk9v9LNBn8/Q7fpxyB9WGN1/kHns3jvwWbCjZ8Lxd+aYx88u7+oRAApdO6imdi9Aksx8WAp8JL86QSn46W7k9n1MbQUnCYRguFuvTZunTM1aTgqi/oqeoZoG3Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(346002)(366004)(55016002)(4326008)(6506007)(53546011)(966005)(9686003)(478600001)(83380400001)(186003)(66446008)(64756008)(66556008)(66946007)(33656002)(2906002)(7696005)(66476007)(316002)(76116006)(54906003)(110136005)(71200400001)(86362001)(8936002)(8676002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UDB6dWtueVVZQ01OZTYzUEFraWpIVmIzYmQrODM4UlA3RTFQN0pFdVp3dlBz?=
 =?utf-8?B?QTBVaFkzYXQ4QVEyVmVULzV4S3dlajJqQ2JCZXFKOGFrVjhRN3VpZWl1NzFZ?=
 =?utf-8?B?aFcwSjRMeDVQdVl2dzU0L1JEVkpiYURNTDQwYnFIZnRQQ2w1akx2K0ZGZHEx?=
 =?utf-8?B?UWtsTWNtVXJxTWJqWnNrRDNJSy82U09GS0p5M25TeWovQlRPZDZmTVllMFFZ?=
 =?utf-8?B?R0tXM1JmTnNmOGdTeTRIcFZldUQ5U2Z4dG4rdjd0aGlPZkc3RmRCalNGaDll?=
 =?utf-8?B?YTUvTENWRURJdElPRWhWOEhrR0JvcStNTUtLWUdadVVjSGZhbkd3VVhBZEsv?=
 =?utf-8?B?NUpxNVB0SlVrVmFpZktwOGRsMXFQZk1zbXVOdXhsSFR1T0YvT3U3LytPc1pZ?=
 =?utf-8?B?Q0RLcWxHdzNRd3U1ZHR2ZE9TaW8xNkE4NFUya05jUTM0cTZseFpuSjBXUnhB?=
 =?utf-8?B?VG5jT2VlV2txTUVPSzRDcUpQaEEzUTFTWVhYNlRTelR2ZlZHNVE2SEg5VG9j?=
 =?utf-8?B?VnYya0puMEtia0tLcFZyRVYrdzZkcHlTbU4xQ0Y0cWxZMzNLQlZseGtxRGJT?=
 =?utf-8?B?dmxUalJDNHcrdEhYQ3NDbW5SeWFPMEEzRWNVRzVkQW1DUXBQOFdsMjc3OEtK?=
 =?utf-8?B?WnBtL1VpZjNnRDh1Q2pnUlB2aWRNQ2lmRkp0VWx2M2JqYVpiamVrZG81WW5L?=
 =?utf-8?B?dG8wRzZzdnJsMWFSVU5kcGt5bGlVb2p3SFA1d0FsZ3YxRVp0elE4OXpZVUUx?=
 =?utf-8?B?aXA4eDBtTWFMZkYxeHQzR215cE5ONUExdWFJdks2Ky8zb2dHU1RJY3RLenMx?=
 =?utf-8?B?aVdzSXhxbkJ2MW1qTWZEbFovdjJmYW1lNEJyRExoWnFINjk5dGhGRnhUV0Q0?=
 =?utf-8?B?Mm92bDVGR3BIOVhINjJpaXFWRnFaUCtydGZTbUUxeWdBM3YySDZtWVJjSXpB?=
 =?utf-8?B?bHBFM1Q2d3N3YkNkcENzSG54VGxmN2d5MWpCajBTYnpRQWxlMzArdHJnd2Rn?=
 =?utf-8?B?NTNWS0xUeW9qQ2FqaUN3aFVDSjVkck5qS3VFWXFKbVhpeXVIZXh4NUhaS1Vl?=
 =?utf-8?B?UFhBL0Jld2IwRFIrZmlwU25obU5jaFhyWGthaHoyRGkxZkV0QWRUNFYzOEZT?=
 =?utf-8?B?eVlCWC9hTE9ySzEwb0xvOFFjc0dOcFBXRXRoSFJtYXRkQlB0YzNoTU9pc0ow?=
 =?utf-8?B?cnIrMjUzZHcwWVU5K25LVjVsampkN3E0eUNucEp3UzlybzgvT3RIZkE0S2tU?=
 =?utf-8?B?cUJremNYYUNhY1FtZG5zR0FqTER2bWUvVFVhdk5hN25nTThMc3RwbmJlMjJ1?=
 =?utf-8?B?ek1vd01ZbFh2K1VkYVhMMUtmMUNUS0pERWRvQ2ZJb0U0NGJBWEtnTnhOR1Fw?=
 =?utf-8?B?Sk05b09TeFAvOEFLbDRBWDdkMU5HdWkvc3I5K2Jiemlkb1c3dXRIb3c1T3Rn?=
 =?utf-8?B?dlpFK0JNNnlwSFdadjJFaGxkZVBtSUlhVjlPcDlySkk0OVZ6MEp0S0VzL0Zs?=
 =?utf-8?B?V0dHMnRQQTVoQ3BsSU9ZaW1lcUZJb2xxQVdZSWlPV2hwQjk2eFlhU3VGb09C?=
 =?utf-8?B?RmtxeTJyR0lBMnRtbmRPYS9JanNhK3B4RnRoVW5lQW5YOExVbTFSa3Jja3Ba?=
 =?utf-8?B?OHF6c3JFR3llS2FMeDhwUWxTcW9SOHlNaG53alZGUjhjR3B2UUxKUmM4MFMw?=
 =?utf-8?B?c2FQV3hYbUloaHhOaCtWVTVUdGVDeTJMUWEvbnZlZ05vcUU2WXVxZUFOMkZR?=
 =?utf-8?B?N0RwYUFrUVB1QzNKbEpVaFZZaFFndkNHeHJDbVU5Nno5VFNVMWxLNzU0bjlS?=
 =?utf-8?B?blhMNzdYcUVaZWNJaDhEQjRYUytrcGNNMTY5ZU9EbHlFallTeFF1enNBRmNP?=
 =?utf-8?Q?p2lAHN1JQ0XtU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a52152f-61c0-481b-f594-08d8cc5981a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 17:46:47.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04/NwFAdiyCXEqEjJiq3AcCDdDb/UgAmqJ73mLQxL/2DykjGAotU7rCLBI8e4WhCpEmpByBsMA9rN2i7+KdrJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1126
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_10:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U29ycnkgZm9yIHRoZSBjb25mdXNpb24uIFRoZXJlIHdhcyBhIHByZXZpb3VzIHBhdGNoIHNlbnQg
dGhlIHNhbWUgZGF5IHRoYXQgZml4ZWQgc29tZSBjaGVja3BhdGNoIHdhcm5pbmdzLiBJdCBoYXMg
dG8gYmUgaW5zdGFsbGVkIGZpcnN0LiBUaGVyZSBtdXN0IGJlIHNvbWUgd2F5IHRvIGluZGljYXRl
IHRoaXMgdHlwZSBvZiBkZXBlbmRlbmN5Lg0KDQpib2INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwuY29tPiANClNlbnQ6IFN1
bmRheSwgRmVicnVhcnkgNywgMjAyMSA5OjA5IFBNDQpUbzogQm9iIFBlYXJzb24gPHJwZWFyc29u
aHBlQGdtYWlsLmNvbT4NCkNjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgUkRN
QSBtYWlsaW5nIGxpc3QgPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPjsgUGVhcnNvbiwgUm9i
ZXJ0IEIgPHJvYmVydC5wZWFyc29uMkBocGUuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCBmb3It
bmV4dF0gUkRNQS9yeGU6IENsZWFudXAgaW5pdF9zZW5kX3dxZQ0KDQpPbiBTYXQsIEZlYiA2LCAy
MDIxIGF0IDg6MjUgQU0gQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4gd3JvdGU6
DQo+DQo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgdHlwZSBvZiBpbml0X3NlbmRfd3FlIGluIHJ4
ZV92ZXJicy5jIHRvIHZvaWQgDQo+IHNpbmNlIGl0IGFsd2F5cyByZXR1cm5zIDAuIEl0IGFsc28g
c2VwYXJhdGVzIG91dCB0aGUgY29kZSB0aGF0IGNvcGllcyANCj4gaW5saW5lIGRhdGEgaW50byB0
aGUgc2VuZCB3cWUgYXMgY29weV9pbmxpbmVfZGF0YV90b193cWUoKS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogQm9iIFBlYXJzb24gPHJwZWFyc29uQGhwZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYyB8IDQyIA0KPiArKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Zl
cmJzLmMgDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYw0KPiBpbmRl
eCA5ODQ5MDllMDNiMzUuLmRlZTVlMGU5MTlkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV92ZXJicy5jDQo+IEBAIC01NTUsMTQgKzU1NSwyNCBAQCBzdGF0aWMgdm9pZCBpbml0
X3NlbmRfd3Ioc3RydWN0IHJ4ZV9xcCAqcXAsIHN0cnVjdCByeGVfc2VuZF93ciAqd3IsDQo+ICAg
ICAgICAgfQ0KPiAgfQ0KPg0KPiAtc3RhdGljIGludCBpbml0X3NlbmRfd3FlKHN0cnVjdCByeGVf
cXAgKnFwLCBjb25zdCBzdHJ1Y3QgaWJfc2VuZF93ciANCj4gKmlid3IsDQo+ICtzdGF0aWMgdm9p
ZCBjb3B5X2lubGluZV9kYXRhX3RvX3dxZShzdHJ1Y3QgcnhlX3NlbmRfd3FlICp3cWUsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBpYl9zZW5kX3dy
ICppYndyKSB7DQo+ICsgICAgICAgc3RydWN0IGliX3NnZSAqc2dlID0gaWJ3ci0+c2dfbGlzdDsN
Cj4gKyAgICAgICB1OCAqcCA9IHdxZS0+ZG1hLmlubGluZV9kYXRhOw0KPiArICAgICAgIGludCBp
Ow0KPiArDQo+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IGlid3ItPm51bV9zZ2U7IGkrKywgc2dl
KyspIHsNCj4gKyAgICAgICAgICAgICAgIG1lbWNweShwLCAodm9pZCAqKSh1aW50cHRyX3Qpc2dl
LT5hZGRyLCBzZ2UtPmxlbmd0aCk7DQo+ICsgICAgICAgICAgICAgICBwICs9IHNnZS0+bGVuZ3Ro
Ow0KPiArICAgICAgIH0NCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgaW5pdF9zZW5kX3dxZShz
dHJ1Y3QgcnhlX3FwICpxcCwgY29uc3Qgc3RydWN0IGliX3NlbmRfd3IgDQo+ICsqaWJ3ciwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBtYXNrLCB1bnNpZ25lZCBpbnQg
bGVuZ3RoLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJ4ZV9zZW5kX3dxZSAq
d3FlKSAgew0KPiAgICAgICAgIGludCBudW1fc2dlID0gaWJ3ci0+bnVtX3NnZTsNCj4gLSAgICAg
ICBzdHJ1Y3QgaWJfc2dlICpzZ2U7DQo+IC0gICAgICAgaW50IGk7DQo+IC0gICAgICAgdTggKnA7
DQo+DQo+ICAgICAgICAgaW5pdF9zZW5kX3dyKHFwLCAmd3FlLT53ciwgaWJ3cik7DQo+DQo+IEBA
IC01NzAsNyArNTgwLDcgQEAgc3RhdGljIGludCBpbml0X3NlbmRfd3FlKHN0cnVjdCByeGVfcXAg
KnFwLCBjb25zdCBzdHJ1Y3QgaWJfc2VuZF93ciAqaWJ3ciwNCj4gICAgICAgICBpZiAodW5saWtl
bHkobWFzayAmIFdSX1JFR19NQVNLKSkgew0KPiAgICAgICAgICAgICAgICAgd3FlLT5tYXNrID0g
bWFzazsNCj4gICAgICAgICAgICAgICAgIHdxZS0+c3RhdGUgPSB3cWVfc3RhdGVfcG9zdGVkOw0K
PiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+
ICAgICAgICAgfQ0KPg0KPiAgICAgICAgIGlmIChxcF90eXBlKHFwKSA9PSBJQl9RUFRfVUQgfHwg
QEAgLTU3OCwyMCArNTg4LDExIEBAIHN0YXRpYyANCj4gaW50IGluaXRfc2VuZF93cWUoc3RydWN0
IHJ4ZV9xcCAqcXAsIGNvbnN0IHN0cnVjdCBpYl9zZW5kX3dyICppYndyLA0KPiAgICAgICAgICAg
ICBxcF90eXBlKHFwKSA9PSBJQl9RUFRfR1NJKQ0KPiAgICAgICAgICAgICAgICAgbWVtY3B5KCZ3
cWUtPmF2LCAmdG9fcmFoKHVkX3dyKGlid3IpLT5haCktPmF2LCANCj4gc2l6ZW9mKHdxZS0+YXYp
KTsNCj4NCj4gLSAgICAgICBpZiAodW5saWtlbHkoaWJ3ci0+c2VuZF9mbGFncyAmIElCX1NFTkRf
SU5MSU5FKSkgew0KPiAtICAgICAgICAgICAgICAgcCA9IHdxZS0+ZG1hLmlubGluZV9kYXRhOw0K
PiAtDQo+IC0gICAgICAgICAgICAgICBzZ2UgPSBpYndyLT5zZ19saXN0Ow0KPiAtICAgICAgICAg
ICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9zZ2U7IGkrKywgc2dlKyspIHsNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgbWVtY3B5KHAsICh2b2lkICopKHVpbnRwdHJfdClzZ2UtPmFkZHIsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZ2UtPmxlbmd0aCk7DQo+
IC0NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcCArPSBzZ2UtPmxlbmd0aDsNCj4gLSAgICAg
ICAgICAgICAgIH0NCj4gLSAgICAgICB9IGVsc2Ugew0KPiArICAgICAgIGlmICh1bmxpa2VseShp
YndyLT5zZW5kX2ZsYWdzICYgSUJfU0VORF9JTkxJTkUpKQ0KPiArICAgICAgICAgICAgICAgY29w
eV9pbmxpbmVfZGF0YV90b193cWUod3FlLCBpYndyKTsNCj4gKyAgICAgICBlbHNlDQo+ICAgICAg
ICAgICAgICAgICBtZW1jcHkod3FlLT5kbWEuc2dlLCBpYndyLT5zZ19saXN0LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIG51bV9zZ2UgKiBzaXplb2Yoc3RydWN0IGliX3NnZSkpOw0KPiAtICAg
ICAgIH0NCg0KSSBnaXQgY2xvbmUgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3JkbWEvcmRtYS5naXQsDQpCdXQgdGhpcyBjb21taXQgY2FuIG5vdCBiZSBh
cHBsaWVkIHN1Y2Nlc3NmdWxseS4NCg0KWmh1IFlhbmp1bg0KPg0KPiAgICAgICAgIHdxZS0+aW92
YSA9IG1hc2sgJiBXUl9BVE9NSUNfTUFTSyA/IGF0b21pY193cihpYndyKS0+cmVtb3RlX2FkZHIg
Og0KPiAgICAgICAgICAgICAgICAgbWFzayAmIFdSX1JFQURfT1JfV1JJVEVfTUFTSyA/IA0KPiBy
ZG1hX3dyKGlid3IpLT5yZW1vdGVfYWRkciA6IDA7IEBAIC02MDMsOCArNjA0LDYgQEAgc3RhdGlj
IGludCBpbml0X3NlbmRfd3FlKHN0cnVjdCByeGVfcXAgKnFwLCBjb25zdCBzdHJ1Y3QgaWJfc2Vu
ZF93ciAqaWJ3ciwNCj4gICAgICAgICB3cWUtPmRtYS5zZ2Vfb2Zmc2V0ICAgICA9IDA7DQo+ICAg
ICAgICAgd3FlLT5zdGF0ZSAgICAgICAgICAgICAgPSB3cWVfc3RhdGVfcG9zdGVkOw0KPiAgICAg
ICAgIHdxZS0+c3NuICAgICAgICAgICAgICAgID0gYXRvbWljX2FkZF9yZXR1cm4oMSwgJnFwLT5z
c24pOw0KPiAtDQo+IC0gICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+ICBzdGF0aWMgaW50IHBv
c3Rfb25lX3NlbmQoc3RydWN0IHJ4ZV9xcCAqcXAsIGNvbnN0IHN0cnVjdCBpYl9zZW5kX3dyIA0K
PiAqaWJ3ciwgQEAgLTYyNywxMCArNjI2LDcgQEAgc3RhdGljIGludCBwb3N0X29uZV9zZW5kKHN0
cnVjdCByeGVfcXAgKnFwLCBjb25zdCBzdHJ1Y3QgaWJfc2VuZF93ciAqaWJ3ciwNCj4gICAgICAg
ICB9DQo+DQo+ICAgICAgICAgc2VuZF93cWUgPSBwcm9kdWNlcl9hZGRyKHNxLT5xdWV1ZSk7DQo+
IC0NCj4gLSAgICAgICBlcnIgPSBpbml0X3NlbmRfd3FlKHFwLCBpYndyLCBtYXNrLCBsZW5ndGgs
IHNlbmRfd3FlKTsNCj4gLSAgICAgICBpZiAodW5saWtlbHkoZXJyKSkNCj4gLSAgICAgICAgICAg
ICAgIGdvdG8gZXJyMTsNCj4gKyAgICAgICBpbml0X3NlbmRfd3FlKHFwLCBpYndyLCBtYXNrLCBs
ZW5ndGgsIHNlbmRfd3FlKTsNCj4NCj4gICAgICAgICBhZHZhbmNlX3Byb2R1Y2VyKHNxLT5xdWV1
ZSk7DQo+ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcXAtPnNxLnNxX2xvY2ssIGZs
YWdzKTsNCj4gLS0NCj4gMi4yNy4wDQo+DQo=
