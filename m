Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9936476D
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbhDSPtr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 11:49:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45128 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbhDSPtr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Apr 2021 11:49:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JFn44T178273;
        Mon, 19 Apr 2021 15:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ebaLjYo4l4OQiNQ9VxpDdIV8v8qlHnbg3k6lfxBQFe8=;
 b=B1HWAWXhlKpQPUbpYK7mx/eeSfUsa2+4qDJcSUILGMPlBpQa9qjCEQrMI2zvN1MceNZF
 trFAG7mUvbVxPMbXRXgVkZkWKleL/ekLXlDTDaeAoLQWFkD+Irah0l61v3HlvpWO/AbJ
 FPtdxNdUYD+v0muTrJ1W/cYtAG8BVGghAQrPbpKmOw9DwZzVpNPQwnfRpPw5+gxSvQzg
 aQ8detVvEDhK452ZgWAzWkCkOKeXEmp6EDTvQrizZhmzGhVCGQv6UueZ/pbC4QiRTGY2
 Iws3v26o0o/rrSmPXhUNTrHiSPlnxxVwOIhsx8GhlN2z2YmYOilziVLEawXInknz7cuw HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37yqmnc4tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:49:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JFk3Pn147759;
        Mon, 19 Apr 2021 15:49:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 3809jy0cwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+ekA9G5BW8uqohZDnL42VbQ4pS8KecObVn9hmBVIoJxZgLJ5awRI+FdMWcWpPiGuVeEkpEJXPxsUDSo/tcV34SclDWf1NKjEfhp1obqF/zxKj6hzegD3aSQHiuMM+V3Hh+7tEOcBH0v4Orv2evgEou2R9JCF6d1aXKxEwKG+jmwWbo8QdB77L6LL75YpvugRtKg7531Zw79EEEyiM3MnzkCwTrX/HUCjOKCXwcM09WpcMwEkwtbCnaZP1fZO8G1wwTkRYhrD2xX0qatAx1jjXelAmSIGQjSkFQXumfhX/M1MB1KtMau4iqhFMcg1BHT0YgvUKaQ9Tk3oWBVA5oUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebaLjYo4l4OQiNQ9VxpDdIV8v8qlHnbg3k6lfxBQFe8=;
 b=Ubdb4gAvbVHy1DQx0NRqSljb4gYf5MiLmbgkByu0cENgAcZ7nd+NAwg4aIkj6tmIKsImLOTBnocP17qzL2DyuXubCNdYhQx/J7m1rTB8URR/5j4h/24K5vfPMT3M+uEa1u2VnSTV5gRuv5Rx+XQllsF2b45/L9BeKzu4xAE6uKmPb0waKPLV3LuM9KHRc0Hygm28Ko01XoRpzhAqxeQtXMPxnQRnQ7D/4rAL+CRMDEED/0MuSjPQeY7TcS4enkSo4k2wxkKOlp37hNi56JZxhkuRB/0OIIPTA3D7YhtZJ8NiAkf5VdJiI617zVUI6Ges6zTN6ibkGWHUvfcIgbW5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebaLjYo4l4OQiNQ9VxpDdIV8v8qlHnbg3k6lfxBQFe8=;
 b=cXyeg0L3c4dL+u9AQMkuMyk7RG7ZzU9xTRuyDP9RC5IxalgyshmZf/Dl3UDDuNfB0QTDlHdzQpSqRgR48FGxx17kY7vBB1JUggLdHPu7EKFEP4To8pyUnDxbOYB/rjLT5mFMv7JOLgk0kAt4yYqKIbSw3IP9z9G9HJdhIfSRfuA=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1383.namprd10.prod.outlook.com (2603:10b6:903:2d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 15:49:08 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4042.024; Mon, 19 Apr
 2021 15:49:08 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/core: Unify RoCE check and re-factor code
Thread-Topic: [PATCH for-next] RDMA/core: Unify RoCE check and re-factor code
Thread-Index: AQHXKtDWGOevT6/g4UW9ZumAi8BUcaqqjtYAgAAQhACAEXIVAA==
Date:   Mon, 19 Apr 2021 15:49:08 +0000
Message-ID: <DE7C3C55-BDFC-47EE-ABBD-F2399697CBF5@oracle.com>
References: <1617705423-15570-1-git-send-email-haakon.bugge@oracle.com>
 <20210408122518.GA645599@nvidia.com>
 <0E0C2ED4-DA48-49AE-AAF6-686B372638F7@oracle.com>
In-Reply-To: <0E0C2ED4-DA48-49AE-AAF6-686B372638F7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dfe6cb5-dee8-4b17-c762-08d9034aab68
x-ms-traffictypediagnostic: CY4PR10MB1383:
x-microsoft-antispam-prvs: <CY4PR10MB1383F26B480E4942A9D397B6FD499@CY4PR10MB1383.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWvstMREULcg2SekWX2uKCjQnNyPcO/nMFTPNNXmgAZ+0yZj8OVshjkQ0bYyBQnwHVZB6X4SNrfjuwPZWliSB/90D/4h7OVFvUErXIKgq2PYFP4Nxnp+BdUYsVGLO9XBn26IElA6ClUQHxKn52YQ1OM7HJHu8MORZb1pHh79K51+VAdvnLaKSpIexpiEVGizVmrWduRW+YpyGezUZ8AgGoSlEGYNHjoJqjdaYWmII/aIY9gVVUlRZaBjUAReGrnuJZCELn6oKy8lnsM5tzRfHXk7t8lN/Y+6palahMPzXoi2xDkCgpO0hVCsu/S9fONb9Uaa5wQ1GDftWOoTGmCH3ZMB10PDo5oKeYG1vk+SBdnV61XDdPvpXLozdUVquk63KG0NLpjs7RRZuvylns1W3u0EcDxknymbU4W0ddo1pAStHF3RbK0uNEEGmlzIbc3pL7bJE21HkiWQRjxEXObsg7uEYXklAeVL7vaVcPqDAZmPEROUhY90WpYPOAqHNULaHT5KgbttPtmfa8bkKrq2Naxs0F4eeQ+d1m3UmEW8/CC32cFHIcspCOcAO0Xn4JJml0iaHBv6SZTs6PvKp+QcccjLmWp/aQGzP0AwfheYxmh2C90bjNLjkpjQfs4Uv3jpX7wO3NPg+3pw/qchJoO/Kxz5c9pMasmWgFDEQ3qXBSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(396003)(346002)(76116006)(6506007)(36756003)(64756008)(66946007)(6512007)(91956017)(38100700002)(53546011)(66574015)(66556008)(66476007)(71200400001)(66446008)(83380400001)(4326008)(186003)(26005)(8676002)(8936002)(6916009)(478600001)(122000001)(86362001)(44832011)(5660300002)(54906003)(6486002)(2906002)(2616005)(316002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QW45NmkzeVpXWmNzc0ZMVjVhbWVTbFRxVGpkWkVMelpXdWlVYVNZa0RhODNk?=
 =?utf-8?B?TWNCcnIvQ3FWZS9IUmZpVTJnZ3RBM1VKV1NYdG9UeEpmVkJiOGZGeUJ5Tmlo?=
 =?utf-8?B?dUZuN2lONmo5eDlscmVueDhkdVQ2VlRvRFhxdTcvV3gwS3VYL29CSWdZK1N3?=
 =?utf-8?B?NjRGQkNLcEVJNXBXVEppbEhicGhDZzBXdDZaMDB6eXVkb3JUM1grT2ppaHhz?=
 =?utf-8?B?UGZCSXVqN1RVMk5nNjRkZkRmSmlnNU1iMThVVythTHZ5a1Ryekp3KzVxTm9B?=
 =?utf-8?B?WlJLN2dXNUp1bkZPWUZxa1kvcWJTd3BNN3RmaEplV0luVVB1YVFMeFNxNDlY?=
 =?utf-8?B?c2dKTTY3SjRCWXZDaVpXSWdHTmF0Z2hRdmVmaTlNampHM3RPWGUwUjdVdndn?=
 =?utf-8?B?ZFFha0pDQmhIRy9Jb3BydVBHMVRqWktWT0NZaFlqZDdxcVFGay9Sbm9WZTNl?=
 =?utf-8?B?aCtGZnM4SlI5Q2djbnduWTM1cDZjSnY4bkhGV05rQ0s2YkRVVWVKeEZsOWZ6?=
 =?utf-8?B?bkw2YXhicVE0QjdWckQ5d0VCU2tPN1BxNGpJUlhtamU2VzRFRnhiUDc3U1dB?=
 =?utf-8?B?Y2hpK0NtQ2RzNm9TbVZ4dWNMazQzTUx1ZVFwcWxsSVpOcDVWUlVnYzkzVEor?=
 =?utf-8?B?YVlVSno4U0pxZDRsL2xaUGt5UDl2bVBPNXE1N0UxZVBPRktWRFpSdFRjZGNx?=
 =?utf-8?B?bVRxb09RQUxUckROS1BBZWpnM2ZYS0F3eE85b2x1MlpwZStNUEswVlk5Y003?=
 =?utf-8?B?aEladUptOUtiNERPSk1lcmE2Sm8wR1R5WnVubDl3aldpQWZ4OHhSclNXeTNC?=
 =?utf-8?B?ZVhqL2lYc2JHTFBjUTFVUkxQMWI3aGg3amdFeUMwYkd5UzNWUCtFeFVzL1Vi?=
 =?utf-8?B?V3F4d0lyYkJWMjJFVjVDakhMblJQOVB1TDd2MFdiL09SaTRsYzNrUUtkM3lM?=
 =?utf-8?B?M0t2SUpYMzZERm5hVHJOSytKM25WVWZkcUdCTXh6SlVPWDU4MnEvQ2huK09j?=
 =?utf-8?B?RG1UMVFVYStnWUpKbm5QZVBUM1laZFZ0OTJHZlNqNWJ3dHBqTkRFNFFqL1pw?=
 =?utf-8?B?RHIwdmlCWVpSZEdNSGtxUENKL29EQlg3WkdLV3V1bnVqVWNVRHdZVmp5RTFr?=
 =?utf-8?B?YkszMVNpNjk3YnJyQ2R2YlkzUHgzMVBxMk5HZVUra2FZeTZVQ3hkOUZHK1d3?=
 =?utf-8?B?QktRYWdtSTlLQjF5UmJJYllBcGdNL1FEWmt2bzBGTFp2cWc2REZMazBEaHNU?=
 =?utf-8?B?Q0djd1RJV1RlQWlWTVF1ZWtCS3ZXOHJOaVFsNThNbmNSTS8wcW55a2RKZUV5?=
 =?utf-8?B?ZUhYZHBhaWZ1a2twSUNROHFPTDNnZ0hDVC9zWmRONU1GRGhaY1BvNldrenhN?=
 =?utf-8?B?RnVBN1RUVVV0Z2ZEcTNwUlFXZGFRMDJ2VXVIN2p1NUNxcGI4dHI0ckF4VXZH?=
 =?utf-8?B?UnZOVkpkQlJ3Z1BmcThMQ09OWW5DL3AyQWlUOHNGT1JyUjVOZE1SQlVMTk0y?=
 =?utf-8?B?TGIwd3Z5b1Y5elVSeGRKd1hKSk9SUTlTanowUWJuRnEyNEVnWUY1OFFOaEd6?=
 =?utf-8?B?WXJNTVMwR0hmVlBMWWVJNkZBNDFtUVJQbkJHU2JXL1VRV0QvRTNyN1M3SjRw?=
 =?utf-8?B?bFc4S0Y1cWg4RlplM1BhVldteFdoaXVGb3EzVG5DYU41S2wwNFJQVDNjOXlm?=
 =?utf-8?B?cytGcThsVlZmTE5vcUV2Tkd2YWd6UEQveXFMdTJHaW9CL1dpZFBOSlFCTnox?=
 =?utf-8?B?Zk8zc0hvMSs1RTJvVGVFSWttdlZMMWowWnNac1VvVUZBRW43MWlZWVljSXFo?=
 =?utf-8?B?dHU0S2tTWW9FNFcwRXJhQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9A3D481889DF44085248057F3D4C049@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfe6cb5-dee8-4b17-c762-08d9034aab68
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 15:49:08.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5BpG5OUSABqE7Qw9nLTjOlJqUYAhyNjqiyQ1Ey+TE9+gIG3XnV4D50SdDjnAJ7VnAbrJAa1UEsusc3eYo2Xgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1383
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190107
X-Proofpoint-ORIG-GUID: h3Cs68rRCtKu_dPOLUN2IhSqrqfiq1eY
X-Proofpoint-GUID: h3Cs68rRCtKu_dPOLUN2IhSqrqfiq1eY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190107
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gOCBBcHIgMjAyMSwgYXQgMTU6MjQsIEhhYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dl
QG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gOCBBcHIgMjAyMSwgYXQgMTQ6
MjUsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOg0KPj4gDQo+PiBPbiBU
dWUsIEFwciAwNiwgMjAyMSBhdCAxMjozNzowM1BNICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6
DQo+Pj4gSW4gY21fcmVxX2hhbmRsZXIoKSwgdW5pZnkgdGhlIGNoZWNrIGZvciBSb0NFIGFuZCBy
ZS1mYWN0b3IgdG8gYXZvaWQNCj4+PiBvbmUgdGVzdC4NCj4+PiANCj4+PiBTdWdnZXN0ZWQtYnk6
IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+Pj4gRml4ZXM6IDhmOTc0ODYwMjQ5
MSAoIklCL2NtOiBSZWR1Y2UgZGVwZW5kZW5jeSBvbiBnaWQgYXR0cmlidXRlIG5kZXYgY2hlY2si
KQ0KPj4+IEZpeGVzOiAxOTRmNjRhM2NhZDMgKCJSRE1BL2NvcmU6IEZpeCBjb3JydXB0ZWQgU0wg
b24gcGFzc2l2ZSBzaWRlIikNCj4+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtv
bi5idWdnZUBvcmFjbGUuY29tPg0KPj4+IC0tLQ0KPj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L2NtLmMgfCA4ICsrLS0tLS0tDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY20uYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMNCj4+PiBpbmRleCAzMmM4
MzZiLi4wNzRmYWZmIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2Nt
LmMNCj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jDQo+Pj4gQEAgLTIxMzgs
MjEgKzIxMzgsMTcgQEAgc3RhdGljIGludCBjbV9yZXFfaGFuZGxlcihzdHJ1Y3QgY21fd29yayAq
d29yaykNCj4+PiAJCWdvdG8gZGVzdHJveTsNCj4+PiAJfQ0KPj4+IA0KPj4+IC0JaWYgKGNtX2lk
X3ByaXYtPmF2LmFoX2F0dHIudHlwZSAhPSBSRE1BX0FIX0FUVFJfVFlQRV9ST0NFKQ0KPj4+IC0J
CWNtX3Byb2Nlc3Nfcm91dGVkX3JlcShyZXFfbXNnLCB3b3JrLT5tYWRfcmVjdl93Yy0+d2MpOw0K
Pj4+IC0NCj4+PiAJbWVtc2V0KCZ3b3JrLT5wYXRoWzBdLCAwLCBzaXplb2Yod29yay0+cGF0aFsw
XSkpOw0KPj4+IAlpZiAoY21fcmVxX2hhc19hbHRfcGF0aChyZXFfbXNnKSkNCj4+PiAJCW1lbXNl
dCgmd29yay0+cGF0aFsxXSwgMCwgc2l6ZW9mKHdvcmstPnBhdGhbMV0pKTsNCj4+PiAJZ3JoID0g
cmRtYV9haF9yZWFkX2dyaCgmY21faWRfcHJpdi0+YXYuYWhfYXR0cik7DQo+Pj4gCWdpZF9hdHRy
ID0gZ3JoLT5zZ2lkX2F0dHI7DQo+Pj4gDQo+Pj4gLQlpZiAoZ2lkX2F0dHIgJiYNCj4+PiAtCSAg
ICByZG1hX3Byb3RvY29sX3JvY2Uod29yay0+cG9ydC0+Y21fZGV2LT5pYl9kZXZpY2UsDQo+Pj4g
LQkJCSAgICAgICB3b3JrLT5wb3J0LT5wb3J0X251bSkpIHsNCj4+PiArCWlmIChnaWRfYXR0ciAm
JiBjbV9pZF9wcml2LT5hdi5haF9hdHRyLnR5cGUgPT0gUkRNQV9BSF9BVFRSX1RZUEVfUk9DRSkg
ew0KPj4gDQo+PiBJIHRoaW5rIHlvdXIgb3RoZXIgbm90ZSB3YXMgcmlnaHQsIHRoZSBnaWRfYXR0
ciBjYW5ub3QgYmUgTlVMTCB3aGVuIGluDQo+PiBST0NFIG1vZGUsIHNvIHdlIGNhbiBkZWxldGUg
dGhlICdnaWRfYXR0ciAmJicgdGVybSB0b28NCj4gDQo+IFNoYWxsIEkgc2VuZCBhIHYyIG9yIGRv
IHlvdSBmaXggaXQgd2hlbiB5b3UgbWVyZ2U/DQoNCkhhdmUgeW91IG1hZGUgdXAgeW91IG1pbmQg
aGVyZSA6LSkNCg0KDQpIw6Vrb24NCg0K
