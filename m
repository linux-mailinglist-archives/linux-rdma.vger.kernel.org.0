Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486B53B1B13
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFWNbK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 09:31:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29008 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231147AbhFWNbI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 09:31:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NDAVsB019979;
        Wed, 23 Jun 2021 13:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FZPGjNqxDqWHdv2TrC1nIePPr0wkUZiK50sTgIX1eNk=;
 b=s0Z0H5HfGGaoyHtI3QhWkvtPBH8JK2XsNa5Z8JOd1n1IQ1vOHH2vl76EKPJh3RGiABxT
 lPnkkH5GMtbFPedsN3ItwEh8eZv9CUGrcMgsA3MlZ4vAhaGySfX085ot3hFUPWV13T0k
 9ajVAwHyxlrYP9Wz+herk5J5VQEzib2+hb5dupvwMo0XKewc0SCc5b16Dbp24AXl4ZiO
 EVVQ7FV/Fj1QJCIpLjDiEVn6nZG71FPPfhx4CdjzPcI5gaJqN7L3pvvZstOdPTwtYSwJ
 oA/9ZbkvUsXy8scFGEIrXSJArlu4pK289i2RgThithiuymVStdMRHuxB6/2ZMgU3UMO/ aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39bf94tw38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 13:28:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ND9t0o126294;
        Wed, 23 Jun 2021 13:28:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 399tbug3tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 13:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN+1idBpLmSQgC1YdXA5hZ90iSbNMK08tRIGQxazzfDyNLINY2hLDnBWGQ/oUSNiggc+kUxSxmxOeaXTKS0oIPyEYLQDYAo+tGwh0wC1dl1tnbHZg7/c94n7sRukWL2hoFX8yOlqNdBp8+lVZM0BfAE7mDqMcUJCXW8ZUkEhIhW0t9F9IvyjiNQnb4xRrUx8tQelydaQDF6yuzkQ1hDezxsWzlVf1b/lFYuBCtGK7zykSoN+zWAIGFZJ+rcUESqN8ynlupL9w54rEIvcHymr/M98ZSlSToD8iI4xpZQgNlOPQg5b2GcLikwlQVmeXlDBzGNbQmcMYwtj8uscjzQYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZPGjNqxDqWHdv2TrC1nIePPr0wkUZiK50sTgIX1eNk=;
 b=VwAtCnIoeUytR8ruAycPTooVfGGLnM+4HDjTw7JtKgV1Svv2JMGZNfksA1eLB9ue+pk3sKpzid2SakP0gKlCOEpyx0D3auMZ/N3r7RDbMOAdJHyK8eETuXu+CrpJ/UXRJfF0W6cqA/5wg2bQxHLM0pwh74yRaI2jlosGiIrzbaZ2+68yQXiqCqQIVwPZnhPnJekg1UEgRR3S7FtKSXMkyrstVV5tX+oG8KWp/tdD9XGhUVkK+xmm3iovOK0U668Jh63eA+HII8kv1FD3kfti/J0OUatFYDwfzbk8/pbyeA8qu9IsP/rQOL1ATzKgq3f7ix6B+LREQLYMAEW/SDStIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZPGjNqxDqWHdv2TrC1nIePPr0wkUZiK50sTgIX1eNk=;
 b=CH3n1wTy+CjeLSGKFW2GlNLqrP/CnAGiv52dAghEoj4iIXZLQQ6WGJc5bryqegKuFsI4nrcbYA9ukfpov2CloGsq8iiInHAh1WDZVQY+oWyWtU0vjlS680NgxePzm5c3yc77F11Qu3p8hUFN9p+N1vGdkn2m6f0A6syskygt6mU=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1350.namprd10.prod.outlook.com (2603:10b6:903:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 13:28:42 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 13:28:42 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Topic: [PATCH for-next v2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Index: AQHXZAhX/oELL5w1L0qtdcCaS0DmnqshGmOAgAADBICAAIHlgA==
Date:   Wed, 23 Jun 2021 13:28:42 +0000
Message-ID: <EE280374-9002-4ADF-B3F0-733E57DB52A3@oracle.com>
References: <1623996475-23986-1-git-send-email-haakon.bugge@oracle.com>
 <YNLHixlGokuQOjmW@unreal> <YNLKE6lJ6Qxf+hHj@unreal>
In-Reply-To: <YNLKE6lJ6Qxf+hHj@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b625e198-4ee6-401f-72af-08d9364ad1a3
x-ms-traffictypediagnostic: CY4PR10MB1350:
x-microsoft-antispam-prvs: <CY4PR10MB1350A97B62332139ED88AC0AFD089@CY4PR10MB1350.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8n1p6xkRIGuEQGWW0zgGUU4Rgj0LF7WKKapkiB3oyK6x5PQUaCUZGjqcdnCEQaqgDLAAZM+5dDpMqq3Jd/nhNgxV/dNpWNipoASXlIJ59drJv2gQD9bX11yx0GioSQ5RarfwUHhmo5BjFb6mADUojVZJtEpxlVC71/5AdXMVNK9KYlp7qfukUVvCh3okJn+fXhp4e/xMdqZMCzzIIpUgVShPxPVBe+tFAsgtUxFqoJts+c55rL7m73wx2iFR3Pp69km1XaAiItx2b0aPe4T02CNxsju9UADy1KMu2ePCrfiFAcZE8K0HcQJeJNAamPy6IovW0vDUZBFnaSf35z46YyTF8aE7LFVdnugFz1dpDY8LIJ1M6tRdqQXfSgXOjMHx1efw9F0W3R+GYmRYavLsg9pMha32ajEjr49XcVf8boBvnN7xrXBJGo42OCxBhn4pHrWODYaILOYOHUnpRXgS+7LmI5u8G0KU4uKH5Tdvs+IV7Pfhxh8J5kLMU7vE2Lyk41DIBGqz0+bGjdqsMjjEbpsAeiSQds3prSMel2Hu4EJ1NgBux0sbNdIWidmChwpZbMWrI7AGUqFkPD/7oTesQ2h5Fu+0qz4QzCOdFhH6Q4ukH1+b8xNdU+C74aH6ymAC/+lTTYlqdCMSZPUduEDCd+Ug/GHGLwz9GiXbRPVDzwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(39860400002)(366004)(54906003)(2906002)(66556008)(66946007)(66476007)(33656002)(66446008)(91956017)(76116006)(64756008)(4326008)(53546011)(186003)(5660300002)(26005)(6506007)(6486002)(86362001)(122000001)(83380400001)(38100700002)(6512007)(8936002)(36756003)(8676002)(6916009)(71200400001)(44832011)(478600001)(2616005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkJKWU9EWERZVVd2Q0x1TXpDYTJySENRMXcwZmVTa2FpeE9HZ05meTMxbkYy?=
 =?utf-8?B?QUQ3SVkyVmVhK2dGd1J5ODZPK2FIZURpaUxUczA1VWNUMDNiQ0NrbS81UnZ3?=
 =?utf-8?B?dkJzQTR4QllxNWtYSnNDSzBtRm9rblVYemFRZmJuWGJZVzg5dVdXcERyRFlw?=
 =?utf-8?B?MDByZCtNNW9RZjVydndhN3Uyb3FNRy9RZ2FnTUZQTlVxWnhXaU9sWVh2cnA4?=
 =?utf-8?B?RzJuR2JJYldXUGJPTXRTNnFMZmdrQzVIRmhxK0Z6MXhPc281TlN4SEdmYnhI?=
 =?utf-8?B?eExvb0V5ZTRJOW8wODFxcm9FeU1tVTVzTEhkYnBxQTcwOHRZem1oQWpTKzNx?=
 =?utf-8?B?TWxHMVB2MDBCZGM5WHowcCs3akQvWVgzZTRMRTd3UjM0MUJ4c2hCekdya282?=
 =?utf-8?B?YU1VYkpvWXVHT0x6TEVyU0dxdTJXVXJkUnZSYjBmTG1mNGNsWFpIOXRFcm9r?=
 =?utf-8?B?R2ZRdTNpbkhKTnlnNytHMWxLYUZPeDRQRHgvSitXMmtmZjE5NXRmeTFYNHo4?=
 =?utf-8?B?QjkvL2RLdjFNdVVnb3FjbHhUTmJ6YnRPdFNsNjUwZkhtTkVxYm5jaUJvNVo0?=
 =?utf-8?B?MFQrYmFVTGdzZTVqZjFVUDJxZkZUUnlhVCt5SnlWZFB5WUFqR1paTVlWdTVL?=
 =?utf-8?B?MmsxMEF1QXJON3JHTHBiY3RmYUh4UlRRalFVNmRpSEZVdXZzMWZNeXREdDBz?=
 =?utf-8?B?aE1EeGx5VTRwQk5Hdit5dTlMUkZmWnMyelZ2OFRMbSsyZHEycEI1Y2dXNzdu?=
 =?utf-8?B?R1hCWmgzZlZJeTVLNGljOHFnNXBTVVRuOGZKbVNzNjNycTNET3Z0MytoZkt3?=
 =?utf-8?B?UDhxSnNtcitEMHdaTVM1MloxTnF6dTZBVStsYzdNNlJlbTdqUmpZNEQwRXVa?=
 =?utf-8?B?bW1UdVZUb1lLbGJDOUhtUjEyamRKanBwUmF0V2RjQzB6b3hIMHg3bFdOQkpH?=
 =?utf-8?B?Q0xlQTNLNFZ2a0pSdDVhUEJFMFRQVGhVSUVzZjJJSlMwZytoSlR3aytFS3hF?=
 =?utf-8?B?RkFGc3p3YkZDeXlYa05jY1pnd25ZWDN3RUFMNG1JOENkeUtDQkdWMzFmRUFI?=
 =?utf-8?B?QzhuclMwSUo0QUpBVC8xMERuZFZ0bzJoVm92SytWTk9LaXp1clQ4NXBodUMr?=
 =?utf-8?B?TXE5c0tjNzI3SFJScFJkRk45NlhhcVdLWXhyVVVaRDRNS3JGNk9VTXllZzFO?=
 =?utf-8?B?WGZmQ2hlRHNNVWczdG40cWtHSU4wZmxSaXB2WkYrT0JhRTFsZitXemFoZjhz?=
 =?utf-8?B?Zll5WmxBa1h5bkxHZ3MxVHozWWd2eEQwemJBeHBlczhVR0pjU2lBcDJLYzJy?=
 =?utf-8?B?NEt6VXcwNUhPTzRKNWE2dndBOFJHTDRKUk56cWc4N3NaVGJSRUxWcmxqZjFi?=
 =?utf-8?B?ZXNYV1ZQT1ZVaFFqTzFzRFNiM0VVUWpUWnVtUTlvTk9rb2lGb0hTK3Z2VW1S?=
 =?utf-8?B?d0Y0Y09yTU1FZ0R2NnFKcUFOd1B4UVBlQ29DM2o3d29jam1pZ2FsVk5tajd3?=
 =?utf-8?B?Um1jVHFoM0dOYzVLdEkzeXpOdmdocnNMOEFuMGFSTHJ0b1FjV0VoQlJWN1A4?=
 =?utf-8?B?OFRsNTZVU0lsMVg4d0FWS2Rick5YRC9OOWJGd2I5amFCNCsyaFJYb2lGZUV3?=
 =?utf-8?B?VmJPUFBSZWJYcHJXRXRrNHVpSm5jVjMxQk1LaFF1bHFEN1g5dkprUjBGQUpG?=
 =?utf-8?B?KytqQXRTT0k2alRHTnBwVHVFVXJqRUZwQmNjcHFXQ1UyZ3FIOWFZZFpnbENp?=
 =?utf-8?B?eTdJR0JQWmQ0S2F1ejh0cmpzZ1hpOWg2ZEJPSUdvbmFOczJ4dUZ2WnltZW53?=
 =?utf-8?B?aE1pSzlEY0N3a292REhuQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <803FD7AA9D0CE148B75EDC49B27CAEBF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b625e198-4ee6-401f-72af-08d9364ad1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 13:28:42.1255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlchlyGbPOrGecF8ShfsgMfFufd4sFif7SbT15gh6NSK09EYq562u6lsPQVqGrcCCF8CTzcXzwVQ61vjaHUMvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1350
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10023 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106230077
X-Proofpoint-ORIG-GUID: AHcSiT-B3nqMNRx8_lYNgxL5_a0f0dzk
X-Proofpoint-GUID: AHcSiT-B3nqMNRx8_lYNgxL5_a0f0dzk
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjMgSnVuIDIwMjEsIGF0IDA3OjQzLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEp1biAyMywgMjAyMSBhdCAwODozMjo1OUFN
ICswMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+PiBPbiBGcmksIEp1biAxOCwgMjAyMSBh
dCAwODowNzo1NUFNICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+Pj4gSW4gcmRtYV9jcmVh
dGVfcXAoKSwgYSBjb25uZWN0ZWQgUVAgd2lsbCBiZSB0cmFuc2l0aW9uZWQgdG8gdGhlIElOSVQN
Cj4+PiBzdGF0ZS4NCj4+PiANCj4+PiBBZnRlcndhcmRzLCB0aGUgUVAgd2lsbCBiZSB0cmFuc2l0
aW9uZWQgdG8gdGhlIFJUUiBzdGF0ZSBieSB0aGUNCj4+PiBjbWFfbW9kaWZ5X3FwX3J0cigpIGZ1
bmN0aW9uLiBCdXQgdGhpcyBmdW5jdGlvbiBzdGFydHMgYnkgcGVyZm9ybWluZw0KPj4+IGFuIGli
X21vZGlmeV9xcCgpIHRvIHRoZSBJTklUIHN0YXRlIGFnYWluLCBiZWZvcmUgYW5vdGhlcg0KPj4+
IGliX21vZGlmeV9xcCgpIGlzIHBlcmZvcm1lZCB0byB0cmFuc2l0aW9uIHRoZSBRUCB0byB0aGUg
UlRSIHN0YXRlLg0KPj4+IA0KPj4+IEhlbmNlLCB0aGVyZSBpcyBubyBuZWVkIHRvIHRyYW5zaXRp
b24gdGhlIFFQIHRvIHRoZSBJTklUIHN0YXRlIGluDQo+Pj4gcmRtYV9jcmVhdGVfcXAoKS4NCj4+
PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUu
Y29tPg0KPj4+IA0KPj4+IC0tLQ0KPj4+IA0KPj4+IAl2MSAtPiB2MjoNCj4+PiAJICAgKiBGaXhl
ZCB1bmluaXRpYWxpemVkIHJldCB2YXJpYWJsZSBhczoNCj4+PiAJICAgICBSZXBvcnRlZC1ieTog
a2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gZHJpdmVycy9p
bmZpbmliYW5kL2NvcmUvY21hLmMgfCAxNyArLS0tLS0tLS0tLS0tLS0tLQ0KPj4+IDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTYgZGVsZXRpb25zKC0pDQo+Pj4gDQo+PiANCj4+IEkg
cmV2aWV3ZWQgdjEsIGxldCdzIGFkZCB0aGlzIHRhZyB0byB2MiB0b28uDQo+PiANCj4+IFJldmll
d2VkLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPg0KPiANCj4gQWhoLCB5
b3Ugc2VudCB0aGlzIHBhdGNoIGFzIHBhcnQgb2Ygb3RoZXIgc2VyaWVzIHdpdGggc2FtZSB2ZXJz
aW9uIDooLg0KDQpPb3BzLCB5ZXMuIFNvcnJ5IGZvciB0aGUgY29uZnVzaW9uIDstKQ0KDQpIw6Vr
b24NCg0KPiANCj4gVGhhbmtzDQoNCg==
