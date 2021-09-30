Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F9741DA0E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351018AbhI3Mno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 08:43:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27718 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350974AbhI3Mno (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Sep 2021 08:43:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UCYVe3013465;
        Thu, 30 Sep 2021 12:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hK9uVdzG4gHCObHSqm0bkNeaYH3maCwTS5E5WF1hh60=;
 b=kNCrLFL90kBGn0fUV5pgLmea2yobTU2TIiDJwskothSS+duEgTuDU97kAdgHqi2KNDhT
 xDBsrMbH8NcS6h0EErcOU0dX/q4emQ9WbKUkJJ7m6AVFPeS5MOYffnzLmcBW/dGlj9aa
 OpG+dLxivbEZI2H71qVplY1AuY3e6nkOGrMKgENayMMJ8mvnhT6P7S9VXk8L3RoUTHzl
 HUta4TcxchxrhZVQdwTH8iO3oIc6f8wWhQc0ARYZ36w0vn13p80CqVMbg50qWeyGjm8T
 AYa/1+gNuNmLya6iEidwEHIyvZXgDhsfwTIYBzhB1/yH9QAaUBBCSgd5ubJ1c+zpx3lB 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3hvs60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:41:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCeEB7027475;
        Thu, 30 Sep 2021 12:41:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3020.oracle.com with ESMTP id 3bc3cftckq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYfIGZc6BnYle3k2R3t1UfFYv3PcVSQuthugNQTPKbQhDOZRyhmQYWHhm/Y4zIGCdShWJjN1YqnscR+/UGkEJ7ulYAl9Tn/8UEaVs9pqV+RlXTMci4vpm425gs3BmEX8PMaPJvhkTMzteIEDrKXkZNXqJVU1QVsYILDUvtoZhMPm49JcDf+a1UlIkP/5jO+dY6qVJ1emzwcbDcHOaT5yJI/dXDnwtJsd66gVdNmZwmL9ar1ayr+Z95wDbyaKcQqXFinWalSbts00elX3ggUyt6Lryz6auTrCYG8A0STpwIgi4/Sjis2Fdisj8Ct6esW7Oi4HokIQNpG+18bXRH7B5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hK9uVdzG4gHCObHSqm0bkNeaYH3maCwTS5E5WF1hh60=;
 b=hjpsdM/aPLbH+d08wnYgOQudfXse4gF+cE5P6EnusQxLCaxmWL0ud17nXc+sL4fekG0oWxORcB7Dl3HMW1nJIiJSvRugzKwp8gw1EaWzj3JfYl0G+Zq+W7s/A7+FPQdq4dVT6JV+2ofHytigmA99gubbr4NcdNg8LWL0THtIEBesdSwRqwTTAmEhT6tDbQiKfLgV633nTic1rhIlri452dKMB/Rxf6Lpt47VlwXreOzsuSouhuLZbhzVsosW4pGFomaCS0zNsl6nEq8vsnXa/A6QoqxWD4SZJ3leWHejKsIxh9sjHYSlG7j9pN4coNkRPQtQuefc0rfXnUWcxroadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK9uVdzG4gHCObHSqm0bkNeaYH3maCwTS5E5WF1hh60=;
 b=NCmBYwx8OxjHwCQXoF5SOE7P46xQ1rzTDAOCknQXCACIaSi35Azklw9ZRyOpRIILx2JnR+3ZBPR/5hMERCEAiaF5/2d3iO05JdMSipKyoOsZ1RD3zhvF9c1hlzW7XUcnIqUTXZNXGMN4yhOmGq7/ACM8MroSDu7MhcaDrHhu++U=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5449.namprd10.prod.outlook.com (2603:10b6:510:e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Thu, 30 Sep
 2021 12:41:55 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66%5]) with mapi id 15.20.4566.017; Thu, 30 Sep 2021
 12:41:55 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Shunsuke Mie <mie@igel.co.jp>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Provider/rxe: Allocate rxe/ib objs by calloc
Thread-Topic: [PATCH] Provider/rxe: Allocate rxe/ib objs by calloc
Thread-Index: AQHXte9McORXS8j+20qY3OEHsUZx9au8hTkA
Date:   Thu, 30 Sep 2021 12:41:55 +0000
Message-ID: <C389F2A9-2F49-4A7A-AD1B-39765C6CFC0E@oracle.com>
References: <20210930113527.49659-1-mie@igel.co.jp>
In-Reply-To: <20210930113527.49659-1-mie@igel.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: igel.co.jp; dkim=none (message not signed)
 header.d=none;igel.co.jp; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10da8578-ed3e-46e5-b90e-08d9840faf87
x-ms-traffictypediagnostic: PH0PR10MB5449:
x-microsoft-antispam-prvs: <PH0PR10MB5449EF9C65E1269DEDD22794FDAA9@PH0PR10MB5449.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSO7k291z1xIVBHuvSTF4a+XRiqMnPjNhCtXjFss0hPV9TJnJwDjd+X+Q8sN5xNKrsLOPcmKRnzqZYaQco4KE3SuaDrsAoobSpIV4tRg3WULglRMkFDG0CIabQqp3c6FfnUsQxVvkT3IK3nTXyplCZfaPgTd/Hqx/hCZtuf/EnqpoQP23dSPIlb0CTQQ7RUv1DQDVYKUOqebaJ/wIElLvkWkRV4CQX9VB7zhQ+Clfh/8Npg6spNC6kpkv63y8brbwhrG5D6MIgwpXr/1emW4eed6J9Toy8O+w+zbgmUjPtz8NX9b2bDwwe/dc4lf2c4ONVZAGwKlZ/srqnEOJxPUW8mKjC9+fQOg0t3b0hBd61LcHGStYBIYyMhzQ4IOp5we95SRnXBJgqMv1+EWci0G4oARSysAv9TerD2fH3aGGt81ACv3sxBMRW6kjsjJ4hfstDHoA1p8vM++1lNw14cD2grn5/CJMpo/JFVzAvTOwVdcaI9P1kP4sRS/YY5o/02zvDDHVbBliGbfRu1N0QV1cc3S176Lrc4s49VEQQ1mYdHLpFhUtLWJu6aM7OAIyJoF5XvMX6NokMddoZasTCAm5zWS6DAAlXZCzllFzcrrTGemmzPjfgUnkAGSZHQe0kA0rw5Ojhhs4DX6EE+yRlY+k7xRzyI+/hQDtZEepTZVmziB3eGTW6a4GkL66ZIOPM3i1kdDAX9Oh8MxoC3dIYMpUjlM1POhAMOzH/2wEPIRoBXwlS2u0h/5zuPp2ngx2LgO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(53546011)(6506007)(66446008)(76116006)(91956017)(38070700005)(66946007)(66556008)(66476007)(316002)(64756008)(38100700002)(44832011)(186003)(54906003)(4326008)(6916009)(6486002)(26005)(2616005)(33656002)(6512007)(8936002)(86362001)(71200400001)(5660300002)(2906002)(83380400001)(36756003)(508600001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2plY0VCV09RdTkvODRYNkFPUTNBVmlGZGt1aFJRY3VBKzNwRTZUdlFEUEs3?=
 =?utf-8?B?NXJENTV0VXMxM3RrZlJ0MUQ1b0I2ZDI5OG9LVWNDeU1hOHI1YkV2N096UkZm?=
 =?utf-8?B?QVU2U1FaWTNSWms5ak1Zb2dhL1RKSkNaRmEwL2ZxaVFTL3BQekVsdGNuOTVT?=
 =?utf-8?B?akhCUEJIYnF2ZFR1U1BGSEhKTjJYSm8xTFBGanFWeGRqaW54L05TU2szMXhV?=
 =?utf-8?B?T3BJWVRWem5oU3h3bmEvZ2ZZNkRkSkI2MWpKUzRPcGdMdm1Zc0NuSWJaTmQ2?=
 =?utf-8?B?cW9YOFZ2S01OUTVKcHBzQlJ3RklTNlVUclEyelBnWGJJZ2NTQlU5UFJubDJO?=
 =?utf-8?B?cnBKdk9VdWZQbTc4Zy9Wb1FUM2M5TjV6QjFidVpnZVpNZE56WWtpTVEza25T?=
 =?utf-8?B?eGx3bjhKbU5DVkVobFprK09QcXh2Z0hrUWcyN3ZLWmV1aHZlQnJ5TGNudjd1?=
 =?utf-8?B?K3Vwd245NUFhUnpUVlBsKzJ2WUphWnlRVk5VRHZIVWlpSVZZUDN4YUhuR01h?=
 =?utf-8?B?UEtLb0s5TzVwa25YSENuMzVXVDBZQXcrRnlxRDFvM0ZJU2tBQzJTeERaQ3BY?=
 =?utf-8?B?YThSMlhwWis0bEZmM1BYMHZ5ZHhwTFovc0xTY1hhK1lVMHJEd0hQZ2FTUVZ4?=
 =?utf-8?B?STRVV0haSFluQjdGbVNyYnYyMGlBVFRzU0NvNzVGejRYMWpxek1hT21YS0Vh?=
 =?utf-8?B?SnR6MmNWdXJvNDlJY1VFdytMR3dnWXJEZVl4N0FueHNSOHo5b3E0VThyQjd2?=
 =?utf-8?B?VEkwWTJlNlpDMVBFMnFVMGZHN21IMjhwNmZBVzdORzV6ckh6TjN3MzVrMEl4?=
 =?utf-8?B?dm5nTjNqNEkvQ3UvaFJOd2pmNVhWaHF2eS9aNFI5c2JocmIzRlVZWDVrRzYy?=
 =?utf-8?B?Qy9Pd2FGWDlJOGRRSnhkTHRGcEF5MFdiR1REMStYYW8xcUJ6ZDZHMURMaDVF?=
 =?utf-8?B?V2Y2djJrMEYvVmJyeHdIWHRrbEZZOWpicGI0b2tQd0tOOEc1aXJGKzJaWnRy?=
 =?utf-8?B?ZFpRd3cxVVlrWHFQeTVaZGloS2k2Yld3bDlkM1ZWdTFpMUJGaUJTNTI1RXJI?=
 =?utf-8?B?YzJLSHJhQWl0cnh5Zk00SG1EWFlxRkJHdGp0VjNKamdNK0toRWh2ZkF2dUdv?=
 =?utf-8?B?anBwZTE0N2ppSGJ1SmtLS25tQ0xyYXRRaFdqMzhlQ0dmNVIzVWlhOEtwYThH?=
 =?utf-8?B?czlKYm5RUCtGUHVMV2owTFVLVVEyK0tQQXFYei9GanlSOG1uWDlhTnduZlpO?=
 =?utf-8?B?WHgwbEExOWZZaGY2bVFTSVJTSlFOUnc4bXRqUm5LV1RNWlZOU1M5bE5icnFv?=
 =?utf-8?B?M3FKeEFNOXdvY05TdG43YU95T2NTNWsyMFk2NXdmSWRHTVR4UHZmZDRDNkYr?=
 =?utf-8?B?d0JkRmlWUHd5dzZFc3p1TXRLV1VGY21qR2ticmxnWXNrTm13NTAvcmtncE16?=
 =?utf-8?B?ZkZVVDdMOWlNalorRCtOVmhydFdUQWNLcmxQem00VUdyRURoamtTNFN1bllC?=
 =?utf-8?B?dWk1Wmh6Q3VsdVgrK1dtZWxTZG5mUkdPdkJxVm1GclBxTXNCZVNBRzNjamdr?=
 =?utf-8?B?YVN6aGdPQ0ZRY1VZKzBhU0RIS05NVmZxeFd6dmpVMi9vUThvTDdYODQwcXdZ?=
 =?utf-8?B?U0ZaSVJBcW5FQVRhd0VGakM4Y3lZUmxKUXY1LytHQ0pNY1pHTUNneHk2cUc5?=
 =?utf-8?B?aVBXT2NncngzdGtRZmU1REFWRHdFay8yd2xZU1RUUzlyRzBNOEZTTm9WY2xl?=
 =?utf-8?B?Z0wxVm5SdllVNXFhRjBXdlhXSWZPMmtabkxZR29rWGxDQVY5T29sTzIyRU5X?=
 =?utf-8?B?dVR2aEVkNjZZcllwY3dKdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBE9E4D95BF138439A420B7A000F900B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10da8578-ed3e-46e5-b90e-08d9840faf87
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 12:41:55.2774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ISY26PQ+k5oHtQPkxRkFKnS85tW+d1pU8+JXUfsoyjyiXmVNtCFt7Zy/vdSrhl8H57FirIzZ/4fw7jkScpHdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300080
X-Proofpoint-GUID: LF0obReOg4AwzAtEYVKH00SkjONsjOv7
X-Proofpoint-ORIG-GUID: LF0obReOg4AwzAtEYVKH00SkjONsjOv7
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzAgU2VwIDIwMjEsIGF0IDEzOjM1LCBTaHVuc3VrZSBNaWUgPG1pZUBpZ2VsLmNv
LmpwPiB3cm90ZToNCj4gDQo+IFNvbWUgcnhlL2liIG9iamVjdHMgYXJlIGFsbG9jYXRlZCBieSBt
YWxsb2MoKSBhbmQgaW5pdGlhbGl6ZSBtYW51YWxseQ0KPiByZXNwZWN0aXZlbHkuIFRvIHByZXZl
bnQgYSBidWcgY2F1c2VkIGJ5IG1lbW9yeSB1bmluaXRpYWxpemF0aW9uLCB0aGlzDQo+IHBhdGNo
IGNoYW5nZSB0byB1c2UgY2FsbG9jKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVuc3VrZSBN
aWUgPG1pZUBpZ2VsLmNvLmpwPg0KDQoNCkxHVE0sDQoNClJldmlld2VkLWJ5OiBIw6Vrb24gQnVn
Z2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KDQoNClRoeHMsIEjDpWtvbg0KDQo+IC0tLQ0K
PiBwcm92aWRlcnMvcnhlL3J4ZS5jIHwgMTIgKysrKysrLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcHJv
dmlkZXJzL3J4ZS9yeGUuYyBiL3Byb3ZpZGVycy9yeGUvcnhlLmMNCj4gaW5kZXggMzUzM2EzMjUu
Ljc4OGExYmJkIDEwMDY0NA0KPiAtLS0gYS9wcm92aWRlcnMvcnhlL3J4ZS5jDQo+ICsrKyBiL3By
b3ZpZGVycy9yeGUvcnhlLmMNCj4gQEAgLTEwNCw3ICsxMDQsNyBAQCBzdGF0aWMgc3RydWN0IGli
dl9wZCAqcnhlX2FsbG9jX3BkKHN0cnVjdCBpYnZfY29udGV4dCAqY29udGV4dCkNCj4gCXN0cnVj
dCBpYl91dmVyYnNfYWxsb2NfcGRfcmVzcCByZXNwOw0KPiAJc3RydWN0IGlidl9wZCAqcGQ7DQo+
IA0KPiAtCXBkID0gbWFsbG9jKHNpemVvZigqcGQpKTsNCj4gKwlwZCA9IGNhbGxvYygxLCBzaXpl
b2YoKnBkKSk7DQo+IAlpZiAoIXBkKQ0KPiAJCXJldHVybiBOVUxMOw0KPiANCj4gQEAgLTIyNSw3
ICsyMjUsNyBAQCBzdGF0aWMgc3RydWN0IGlidl9tciAqcnhlX3JlZ19tcihzdHJ1Y3QgaWJ2X3Bk
ICpwZCwgdm9pZCAqYWRkciwgc2l6ZV90IGxlbmd0aCwNCj4gCXN0cnVjdCBpYl91dmVyYnNfcmVn
X21yX3Jlc3AgcmVzcDsNCj4gCWludCByZXQ7DQo+IA0KPiAtCXZtciA9IG1hbGxvYyhzaXplb2Yo
KnZtcikpOw0KPiArCXZtciA9IGNhbGxvYygxLCBzaXplb2YoKnZtcikpOw0KPiAJaWYgKCF2bXIp
DQo+IAkJcmV0dXJuIE5VTEw7DQo+IA0KPiBAQCAtMzgyLDcgKzM4Miw3IEBAIHN0YXRpYyBzdHJ1
Y3QgaWJ2X2NxICpyeGVfY3JlYXRlX2NxKHN0cnVjdCBpYnZfY29udGV4dCAqY29udGV4dCwgaW50
IGNxZSwNCj4gCXN0cnVjdCB1cnhlX2NyZWF0ZV9jcV9yZXNwIHJlc3AgPSB7fTsNCj4gCWludCBy
ZXQ7DQo+IA0KPiAtCWNxID0gbWFsbG9jKHNpemVvZigqY3EpKTsNCj4gKwljcSA9IGNhbGxvYygx
LCBzaXplb2YoKmNxKSk7DQo+IAlpZiAoIWNxKQ0KPiAJCXJldHVybiBOVUxMOw0KPiANCj4gQEAg
LTU5NCw3ICs1OTQsNyBAQCBzdGF0aWMgc3RydWN0IGlidl9zcnEgKnJ4ZV9jcmVhdGVfc3JxKHN0
cnVjdCBpYnZfcGQgKnBkLA0KPiAJc3RydWN0IHVyeGVfY3JlYXRlX3NycV9yZXNwIHJlc3A7DQo+
IAlpbnQgcmV0Ow0KPiANCj4gLQlzcnEgPSBtYWxsb2Moc2l6ZW9mKCpzcnEpKTsNCj4gKwlzcnEg
PSBjYWxsb2MoMSwgc2l6ZW9mKCpzcnEpKTsNCj4gCWlmIChzcnEgPT0gTlVMTCkNCj4gCQlyZXR1
cm4gTlVMTDsNCj4gDQo+IEBAIC0xMTY3LDcgKzExNjcsNyBAQCBzdGF0aWMgc3RydWN0IGlidl9x
cCAqcnhlX2NyZWF0ZV9xcChzdHJ1Y3QgaWJ2X3BkICppYnBkLA0KPiAJc3RydWN0IHJ4ZV9xcCAq
cXA7DQo+IAlpbnQgcmV0Ow0KPiANCj4gLQlxcCA9IG1hbGxvYyhzaXplb2YoKnFwKSk7DQo+ICsJ
cXAgPSBjYWxsb2MoMSwgc2l6ZW9mKCpxcCkpOw0KPiAJaWYgKCFxcCkNCj4gCQlnb3RvIGVycjsN
Cj4gDQo+IEBAIC0xNjU5LDcgKzE2NTksNyBAQCBzdGF0aWMgc3RydWN0IGlidl9haCAqcnhlX2Ny
ZWF0ZV9haChzdHJ1Y3QgaWJ2X3BkICpwZCwgc3RydWN0IGlidl9haF9hdHRyICphdHRyKQ0KPiAJ
CXJldHVybiBOVUxMOw0KPiAJfQ0KPiANCj4gLQlhaCA9IG1hbGxvYyhzaXplb2YoKmFoKSk7DQo+
ICsJYWggPSBjYWxsb2MoMSwgc2l6ZW9mKCphaCkpOw0KPiAJaWYgKGFoID09IE5VTEwpDQo+IAkJ
cmV0dXJuIE5VTEw7DQo+IA0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQo=
