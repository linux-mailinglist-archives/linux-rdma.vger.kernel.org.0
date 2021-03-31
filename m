Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD7350131
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhCaN0N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 09:26:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhCaN0A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 09:26:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VDOhEF164987;
        Wed, 31 Mar 2021 13:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mLumVOGH+eQKZ92seNLxXM432KmTr3T6vDfnedZ6Ceo=;
 b=CdoMiu9iaRb/uE/05fxLWK2YrRzqOt57nV6xFehGPk+hWTRURa+zdTYn0dQcLZ9G4JFW
 bmjyYTYhZhnasYx6TcCeuxhafwmFnBvqkjPUOzGDDLPWLE2RZskNUCTINDjf5BYxczkQ
 TgxIHgDHBRgX2t6suJc05IyNQVGdj1IXB2F/vo6JsV46J2I1O7aGhOXDxfv2eVA0x6Cz
 eGpb79WRbqp+CJbsBGyKiwN2/mmmYm5UTI0F9zEA7ytEicVakOuSoL8we3HqXEmmB4aH
 lsj8thPQ6luOPrdKaniCn1X4zthECO706gcZkqZZhQDgjFdkxKzmciobcwOt6xNJdaNT YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mp06rpbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 13:25:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VDKrsX013880;
        Wed, 31 Mar 2021 13:25:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 37mac8njnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 13:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBiBVlnNJ9aT5GMnQSiwqRl8FXdADSJoLjEHyQDmDHqYsz3LU8XV8QHwh0YQFLdDhP2nISrvYXGnz/+KbsGskMiBHBDvyntpuD6blI1KUj1WcKbbHYv1JEe/i3yK+CkX+lkZnrZ+ym888t6YxSeqltWcxy8YaRrqCbxYB7a5gfWP4jE2mZmKvaAt6QPzXhz+JfkFHQsLDSlolqBf3wt/vuHxQt/7MBXKsab1hM5bZqT848BjktYo7UgIJmvwNjTIyvZQ503HW5xNkxLqrGcmFMxO8o5lCnqigDbKh69/WZPCK6ONfY/6XOj6oUKyftvBgk3BiQ5fwhykCpqh++7kTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLumVOGH+eQKZ92seNLxXM432KmTr3T6vDfnedZ6Ceo=;
 b=ekTUwUIn8dfrlfwrp2Itf9qGUMkVuDa2NRklAz00pfX0Qc5J/g++TGF0EjpLvbGrHAUfnRMpzaTmf3sCQ6NtXQiTfouyvf4ElpdeDKf6wZrPxD+Mw99kxIwp1/tlBdrNULtBf92+Jtds2EtNYDVzAxzvNQU52VnaJIhpBXzrYuTy6MQQ3RW1XwqKzpiWinf8jMYvBOD16cEEHONuDGh1NzZ7M605oIt03RBfrJa0Jg3g/Gt6D8dbIwj5hqU5yWQYaZhRiK97ZN02GemMG3pQ+25E6zPQGsoD6Tr12I+K7z18fCYJTmpW2LLD9HHIPffcKMI1SCx1qh4QAnHLiAQvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLumVOGH+eQKZ92seNLxXM432KmTr3T6vDfnedZ6Ceo=;
 b=F6ZH8eEoMxjWUCpJ1jlTg7CFJd37DIOmvU1+04T9CI1zIj0Y+6/bB+7MYDBQY1YOyFk6Q+6SQGKEAm+Z4NXARDbWsMg+X9DLWNIEYYD6bzC4gDPlneNV59aZXPO3FiK5vGNdR7HrkdMG+augIAaxUvhpm3cjU8KElmpRtMlBZ4E=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1254.namprd10.prod.outlook.com (2603:10b6:910:5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 31 Mar
 2021 13:25:53 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 13:25:53 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfEcjVZJS51L0umIr0ZkYgnuKqdMUWAgAC/ogCAABcagIAAEDKAgAAHmwA=
Date:   Wed, 31 Mar 2021 13:25:53 +0000
Message-ID: <7039186B-7308-4FED-90DC-A1337B4D6B73@oracle.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
In-Reply-To: <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a5fe885-58bf-4a5c-6ef1-08d8f448826f
x-ms-traffictypediagnostic: CY4PR10MB1254:
x-microsoft-antispam-prvs: <CY4PR10MB1254F92E2A5B3E20422D229AFD7C9@CY4PR10MB1254.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Usoug6M2lDBg6VbxjOJZRd1TvrvOG21AIc/KSqunNirIimG/G1ET+dMz019WcswsnMMHBFYczyzKVdOoc8x0m6csppQlwwW4NbAvPNzyNMd2s8OblDtDP5cwTOhqI27MA/2jXsuFYw2EXhyhQEiOwEEG52r5AEOrwUVxshPK4SbgyRbV1hfmJoIK9SY6rQ4mMvf0LDODK5qq9iF+c+ZUKQ6ImCnW1yU6hBllD9PE/DDdMWequnyoSgCcv40ngjGEikqIGfSkkzftXLNpvtCVoGMZ/qHuZ6NcLG7JCddssEJEYshiU4BlaH3iV319JeJKqeU1M42Z7dBWr4eSqHp+xyCl/rxprbTuWeXyOFFWoZ8jL8btirqRL/4d6KW2imDdFqB3QJJoQOHD1ytjwMDDsPGF+TTTggcwM9U7a1pC1XvP8euUTQkNO31dal08LohlDvttQGghEKxd/8K869jHfJkZOUSo7SLTYkQNhPg++qh1TF4LY0EvynNgzoU7Fi9UEDqntkrg0KUtCOkF0KcFLCb7YnuohFAftcXYWd+Sz4xY71K9Oru6W3F2XYjHZGP601fsDaTHO08Vpu1y6ZDvEhaSssopT1gpZp2pbJ+r+h1yTMPUXQRdgVBUp1xweH3qeDrBjFXr2r0Pb6fd40tLb4EOPBg4dQAdwBchNgEJJoLdLdq9xSIEvDcGePsck1Jx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(8936002)(54906003)(6916009)(53546011)(44832011)(6486002)(6512007)(186003)(4326008)(6506007)(38100700001)(2616005)(316002)(478600001)(86362001)(5660300002)(2906002)(91956017)(36756003)(64756008)(66556008)(66946007)(33656002)(66476007)(71200400001)(8676002)(76116006)(66446008)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ejFlODFXcEtWbW5mUGRqSmRXTzFydlpmdC9jZnNzNFpjZU5QMFFLNWpBZ1FJ?=
 =?utf-8?B?aUkwWlI4N0FKSlpJV0RiK3RxOG1xaU5lYmE5Q0podE85SnR2YlpNRGxhNWQw?=
 =?utf-8?B?WmVrS3pQaWJsd1dXQnFhSkJkZURWdGxuV0NVM3RVQ3p5NDI3dmNhdjY3RlZJ?=
 =?utf-8?B?V1RIZ0JvNDNQSEtkQ0c5MVY0TDNWL0RtcXdBYmRkcm5ob3k1NjkwSkhYa1F3?=
 =?utf-8?B?b3RZOGdJbllwNUQyazByY0NPZWZRYTQ2WU1CbWJIWm5NalFFbFRVYTBhT3hm?=
 =?utf-8?B?c1VzSUpKSjNnN2RZYWE1SHVHa0NCZi9lUDBFODlsT21mRGFEYlVMRkIzMG8v?=
 =?utf-8?B?VHk4cmFjSENRbXdHMXp4TGpXTndVZU5iVTFNcjRMNVN0QjRvai84TkMxQmU5?=
 =?utf-8?B?RWF3SGQxMmtUV0hUNU40b3d1a0ZIK2o0TlVpcnZsdlFrUEV2QUxLR0drWEZ6?=
 =?utf-8?B?cXYrNXU1NTVOU0lFdHpRa1VkUmZJb2NnZi9jRXZUTjkxRkE3a2VtS24rR1Ri?=
 =?utf-8?B?S3RJcS82SWkwc2prMGZ5SncxYmVKN091K1ZqTVUwVnlMQU5uUWloVzRieUR5?=
 =?utf-8?B?dHMrUk5LcGZlazRZOU5ob3NFM3RKdlpZc3NoSThRSFR5K2FXZEhOd3pEVE1D?=
 =?utf-8?B?OTNvTXJNTkc0L3pBS21XV2RVYSt3N0xRbUFoVjcvZzhVOUFkbkdvbWVnWjEz?=
 =?utf-8?B?aitJSk1hekYwODNoS1hJQ0Q5MGlIbXVhQi9uVm5Kanp6bm5tdzFrQXBpWE1X?=
 =?utf-8?B?R2JlcThSNk02QitJcVdheVpic0RWay9VbzcvTzJPbzlRVThGLzVVU3RVQ2RJ?=
 =?utf-8?B?QWV3MzB2UVoyUk1OZEpUN0pRL3FNU1E4NFV1aisyekdEcVVIR3gvSGhpQXdk?=
 =?utf-8?B?WEFFbEZSKzZ1c2NPTVl6NzBSeXdmWUZ0aEsxS3RnYW5UeDNMWElDUUhBMUh4?=
 =?utf-8?B?REZWYWw5Yk5tUmgrb3JzVUlRdXJGd2xGV3FNV3ExOU5JZVA1UlVQeU1wSjJI?=
 =?utf-8?B?YjlyK3hXY3p5cGJoWDFhR0VzUjVWekdVM3h6VVd1S2pwTE5peXRzSko5OUg0?=
 =?utf-8?B?SU1WNytScElZb3BQR2p0dkxFRXVGQmlhMHExUjU0T2ZlREhtOXVqclM0Y29B?=
 =?utf-8?B?UjZDcW1zRG8zRmZJUzRxR2I5bk5BQTRWcVIrKzNEYXVTWGg4cVNEcUt6Z3kw?=
 =?utf-8?B?Mmw1bGlyeDJvamYrVStsZXhBRXBMZTdzc29qTVBkMHFBSXpiV0JNZGgxYjRk?=
 =?utf-8?B?OEYvVVBGR1dncXM5TFI5ZzhnRkRIMTNwZ1BCS0ZLOVVUM3MvVFlpYjZlaG9O?=
 =?utf-8?B?YTlVMzRxRVVXbENEQnNnSHNpS1dzaXg2S3ZKU01JTytGeWlWWjdPd3FPMTZE?=
 =?utf-8?B?cnZkZTUvMmVsU2t0NWFlZVFWdlBEZVJndU9iL1hVaXpPZjVSbWdyTWVUSEU0?=
 =?utf-8?B?VmU2NnkyMzBLTWxwNy80aHJvbjl0cU4wU1FKanZuVW9BNXAySlliRHpMUXpS?=
 =?utf-8?B?eTIyOHBrQ0pSekNzbkxsb1IyemtCbjZjTEp5TThsWWZ0cXp1UG04MWN2V2NG?=
 =?utf-8?B?aWFmamI3N29XeDdMYk90WUE5STVqL1hzeXlIY2t1UlVLL2hQNVZCT05ZcnNZ?=
 =?utf-8?B?TUdjYnYyeldpTUVORjZMS1BzeUd3dzBiaFAxZ2pBUjA2WHFzcGtsL3k5TkNk?=
 =?utf-8?B?d1FkcHpwUmNGQjJZTG00Qk9yK3hOMUxBSDVTbEdZdi8xRWw3aWM0dkdYME1P?=
 =?utf-8?B?NDE1QVpVZnVWcFlLdWkwUVVFbnAwNFNwRVVRZy94a0tYQTdpN2tQMlFlbEV6?=
 =?utf-8?B?QlRsenloZHg2T0RCc09wQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ECCCD3FDB57E14DA4EBB593F4B8D216@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5fe885-58bf-4a5c-6ef1-08d8f448826f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 13:25:53.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQU2/4T9bvOsDw/QFz9b0jIFgpZRNQ6Hl9qDtSzFcECJ3xae0XMzOWPpVgXP7NiyH6bQwLsz3ljUk9hLPhc78Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1254
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310098
X-Proofpoint-ORIG-GUID: x_Fm4hox50JVU4_-cUrlfPArtJpdewXw
X-Proofpoint-GUID: x_Fm4hox50JVU4_-cUrlfPArtJpdewXw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310098
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjEsIGF0IDE0OjU4LCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIDMxIE1hciAyMDIxLCBhdCAx
NDowMCwgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6DQo+PiANCj4+IE9u
IFdlZCwgTWFyIDMxLCAyMDIxIGF0IDEwOjM4OjAyQU0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90
ZToNCj4+PiANCj4+PiANCj4+Pj4gT24gMzEgTWFyIDIwMjEsIGF0IDAxOjEyLCBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIFRodSwgTWFyIDI1
LCAyMDIxIGF0IDAyOjA1OjQ3UE0gKzAxMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+Pj4+IElu
dHJvZHVjZSB0aGUgYWJpbGl0eSBmb3IgYm90aCB1c2VyLXNwYWNlIGFuZCBrZXJuZWwgVUxQcyB0
byBhZGp1c3QNCj4+Pj4+IHRoZSBtaW5pbXVtIFJOUiBSZXRyeSB0aW1lci4gVGhlIElOSVQgLT4g
UlRSIHRyYW5zaXRpb24gZXhlY3V0ZWQgYnkNCj4+Pj4+IFJETUEgQ00gd2lsbCBiZSB1c2VkIGZv
ciB0aGlzIGFkanVzdG1lbnQuIFRoaXMgYXZvaWRzIGFuIGFkZGl0aW9uYWwNCj4+Pj4+IGliX21v
ZGlmeV9xcCgpIGNhbGwuDQo+Pj4+IA0KPj4+PiBDYW4ndCB1c2Vyc3BhY2Ugb3ZlcnJpZGUgdGhl
IGlidl9tb2RpZnlfcXAoKSBjYWxsIHRoZSBsaWJyZG1hY20gd2FudHMNCj4+Pj4gdG8gbWFrZSB0
byBkbyB0aGlzPw0KPj4+IA0KPj4+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gVGhlIHBvaW50IGlz
LCB0aGF0IHVzZXItbGFuZCB3aGljaCBpbnRlbmRzIHRvDQo+Pj4gc2V0IHNhaWQgdGltZXIsIGNh
biBkbyBzbyB3aXRob3V0IGFuIGFkZGl0aW9uYWwgaWJ2X21vZGlmeV9xcCgpDQo+Pj4gY2FsbC4g
TWF5IGJlIEkgc2hvdWxkIGhhdmUgYWRkZWQ6DQo+PiANCj4+IElJUkMgaW4gdXNlcnNwYWNlIHRo
ZSBhcHBsaWNhdGlvbiBoYXMgdGhlIG9wdGlvbiB0byBjYWxsDQo+PiBpYnZfbW9kaWZ5X3FwKCkg
c28gaXQgY2FuIGp1c3QgY2hhbmdlIGl0IGJlZm9yZSBpdCBtYWtlcyB0aGUgY2FsbD8NCj4gDQo+
IFVzZXItc3BhY2UgY2FuIGNhbGwgaWJ2X21vZGlmeV9xcCwgYnV0IHRoYXQgY2FsbCBpcyBpbmhl
cmVudGx5IGV4cGVuc2l2ZSBvbiBzb21lIEhDQSBpbXBsZW1lbnRhdGlvbnMgcnVubmluZyB2aXJ0
dWFsaXplZC4gU28gdGhpcyBjb21taXQgZW5hYmxlcyB1c2VyLXNwYWNlIHRvIHVzZSByZG1hX3Nl
dF9vcHRpb24oKSB0byBzZXQgaW5mb3JtYXRpb24gaW4gdGhlIGtlcm5lbCdzIGNtX2lkIHN1Y2gg
dGhhdCB0aGUgcmVxdWlyZWQgSU5JVCAtPiBSVFIgdHJhbnNpdGlvbiB0YWtlcyBjYXJlIG9mIHRo
ZSBSTlIgUmV0cnkgdGltZXIgdmFsdWUgYXMgd2VsbCAtIHdpdGggYW4gYWRkaXRpb25hbCBtb2Rp
ZnlfcXAuDQoNCnMvd2l0aC93aXRob3V0Lw0KDQotaA0KDQo+IA0KPiBUaHhzLCBIw6Vrb24NCj4g
DQo+Pj4gU2hhbWVsZXNzbHktaW5zcGlyZWQtYnk6IDJjMTYxOWVkZWY2MSAoIklCL2NtYTogRGVm
aW5lIG9wdGlvbiB0byBzZXQgYWNrIHRpbWVvdXQgYW5kIHBhY2sgdG9zX3NldCIpDQo+PiANCj4+
IEhtbS4uDQo+PiANCj4+IEphc29uDQo+IA0KDQo=
