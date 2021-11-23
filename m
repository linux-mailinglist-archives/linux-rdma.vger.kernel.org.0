Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E74459FB3
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 11:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhKWKFK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 05:05:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46784 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231838AbhKWKFJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Nov 2021 05:05:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN9ZA7W010833;
        Tue, 23 Nov 2021 10:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=frNP9/RmgyRMVYV1nP1XyU7rZ7/sNjMTyZzeAamaie8=;
 b=BHZDK2MJXv3Oor4fipYlJ67Onm0gP1QX8Qr3n4WEPHIuYQq4dbe1pD6oXFRY7yZppvJh
 Mky3gYi7IfUv2Oa5VDmXOaIar4pbRRVPkTPYp3eTwm8dETbt0u1fe7jsEMvG7kghCsWG
 hogcxmX7dsiT10CHAA++8erublrSgy1yDInbhCnhheDGct0/xJeP+lO+KE0L4d5uUmu+
 72uTkXcO84m16/XUamjh9mpY4dxY1b+rY8T+Htk9o4LCT/sar1vTstLTyxYF9i+bt9MU
 uHCwcDf92m/elUAIS2IbAJ99eFFpv01NY984jEm8xXvhEvYIFap14aBYxvMnEB9DdqT8 /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg55g0n5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 10:02:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANA0brZ040648;
        Tue, 23 Nov 2021 10:01:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3cep4y5e65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 10:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6/JwLakrqrRmeCD359yjN/vdFOKxtTe65brKfErT7YF5cNRNMK3LvMBpXJQtoocIVYtBL8Elf/eqVc0Qpuc9Wy742iu84pM+QI2zkhsGP4ujwkuIL5Q1KjuOdJNXwn0jw6B3IrwY4RO4p3oJYLI6zuirn0Gox/Lns+0kkGZ9XQ7Qr8SRBXCVPcUcBa3Ktx0HrGy+7MLZ6m9kcQv5JzkuTOubCOdnTNswCtZzAlJyy7xD7ptdlxu4CHkmZ6R5OntLjkEdWLIeZnb0pHoiNeoVU53YdmUCtEW0mvnpgk97Zlu+KrTmNr+bR1OMuND4zrylAfqtbo8t5yuqIpzObA5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frNP9/RmgyRMVYV1nP1XyU7rZ7/sNjMTyZzeAamaie8=;
 b=kyAzQSwXEHfZmeV43VuNV1l7qK93xk9YtEq/HVKY3lxkuqErgl+Rxxze3H89/VtY6DyGW9PtRTcSvOdMib0wFUVCaYswPbuav4FCMVCS5w5tx8nQWlPVrs5U9FQADoeQUfWhFuywmWpkNgicpGd7aBVmtlGDyOTdqrNA4Fqp8HIaaHsLLC58HxSNG80VT5FL3pvTuG9nQJde7tYliVigAommY5Z2OtOu0yol0itwQDtSR6mFssy3dbtKoMCjNBrKZE/0vcBMOrs3GQXCilIRUovHroVSIcELB4bulzb37gvyRV6pavsBQXvO7VETG7andvLwjM848+MJQbtx3ruSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frNP9/RmgyRMVYV1nP1XyU7rZ7/sNjMTyZzeAamaie8=;
 b=EkbZxUoIXZHmN35Ei/FHoTUZI9gwqKpmhGLsDtRx6Gz4o9MEwVJ0iybiQLk+zvpsSLvi3SwHJXWc3O3WlDq5IVhDEYaj9wMYOOxPED/G2sBz+7m9Ozcesz1vJZUViuPCO8jSKUG4kJ0M4aSpuV4+e2Tzel16S9Ht+BSIbybfpFA=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 10:01:54 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8%7]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 10:01:54 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/cma: Remove open coding for overflow in
 cma_connect_ib
Thread-Topic: [PATCH for-rc] RDMA/cma: Remove open coding for overflow in
 cma_connect_ib
Thread-Index: AQHX38DcuG5mUkRFnU62YK8SgPb7EawQ1MuAgAAKvYCAAAM+gA==
Date:   Tue, 23 Nov 2021 10:01:54 +0000
Message-ID: <4A4CB35B-C9BB-4511-A792-BCB1790E42FF@oracle.com>
References: <1637599733-11096-1-git-send-email-haakon.bugge@oracle.com>
 <YZywV4lRV7g4Bj87@unreal> <49133CD8-6770-4E98-AA04-723C915B636B@oracle.com>
In-Reply-To: <49133CD8-6770-4E98-AA04-723C915B636B@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 945dfadf-5391-4f95-cac4-08d9ae684725
x-ms-traffictypediagnostic: PH0PR10MB5756:
x-microsoft-antispam-prvs: <PH0PR10MB57569BD3026CAF20B704D1EBFD609@PH0PR10MB5756.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nI7gcqUTiV8QtW7tPKTFSkAKJAimFe7pOOy3Nm1xfOLfyluQPVUO2h1gFGNZ3Ec4gqCQdJrE6JHLKqkoB1sTWmgWDgdBcuXVT6p/HjmOuVMgiAXfJf1qRLOH6c3JggTeVinFlOBNzpzYFCp+yqekiqvnFacJSaAexQj0jm/r02GcLUwrUqbkJMpZ4wYPamc+1LC9tJxOpK8iH8jfHcflat7fB1jnJvhtK8sYezf1Vg5xABQlBOpJlgkj7aEzfX0nn4m5fdPzsFamaGnLhMivZKdAkehPQUkTm5TU0CYPuqgFHRIn44Dap1tqwGHq24LkcQ1Ru5UbpjcF0ZEkEWaaelXBG9e9eg/wzcjX+DbwICmtsVn8/e77mE78cttpCOHuEC67HM1/8FpyCo4SMIzZscSO0hVaR3wvtqUoGvE3kilCgK5vn4H9ZO4UjpVsprZYWP4S+etZu5kzvyiU9QI+gKQbirf+bHwawVLAZs1U0QcROXAM1Go+jMKODocQTexmI4rZcU2U5iTKj5tiLcGQi8O1exb4LJWb9QudX0pY2q1hwkBKJBreD4UMSOuSQ/x/Vy+P12Ax7J52PobDvNma4EJBQ1Pzl/xvSw2iHwGOpRK+233IHeFMTMxoWgeJjKnhjx34XPbAU4qdTFvrayUFzcPfeUT/1H2+CEOcXMiz56nUnjw2cKf+A5LfaTkO1HropW9vSQYA0Eh8f1U+xd+rEKs8FZClavxv5Q8P9VCydzKX4pnn2kdYlTpUm+cHaTqw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(71200400001)(44832011)(36756003)(26005)(66574015)(38100700002)(6486002)(122000001)(316002)(33656002)(66556008)(66946007)(91956017)(6512007)(5660300002)(54906003)(2616005)(66446008)(4326008)(8936002)(2906002)(6916009)(64756008)(508600001)(38070700005)(6506007)(86362001)(66476007)(53546011)(186003)(8676002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmlTcnQ2QTdWN3RqdDlwRXNxaWpiajg5TTFrazdXb1JNQ01IYk1USnVvTkd0?=
 =?utf-8?B?NU5JV1JCQ3hpMVFuSm11bEVmTWNuQzc4NzRDd2lGUVdZVnkvTmcyY1RTNnVI?=
 =?utf-8?B?aittcDlZTkxGTE1id2RyTnpYdGk5aGsrbzR2TGE3azB2YXdyckFZWG1JemRX?=
 =?utf-8?B?NmhXRTY2Y1Q0bDhMWkc2dW1uTWx6MWFFa2VKRE9XV2VuL0pXU0I5ZUlrQ2lT?=
 =?utf-8?B?ODJkSVB6eUcwb0g2STFKdFRmSDFqcm8xdisrSXpxdWRndWFEb2JnZVpyOG1Q?=
 =?utf-8?B?RWdwNnpIVWF6VllLaHZadHlpWVNoTkNZVWlUMVU5b3pyN2ZwVDNjNjBpd1VU?=
 =?utf-8?B?dzkvdHBkOW50QjQzUXEwelQ5ek1PMDlnbkRRMFhRV2VBQzU1WmZ3Yk5Ka0gw?=
 =?utf-8?B?QnNGS0c5Qnk1UmxXNS9hNVVEY2tOTmxMeHRHTFczYUpKbUwxcGNnMFV6U2kz?=
 =?utf-8?B?NjRxbExzbkl3WjY0VmRZd0lPMUtuQkdMMGdVbEQ4d04rdEJyU3hmbWhsSWdt?=
 =?utf-8?B?dGNzN1VTbDMxNGtGejF6dlVHUnhmdzI2MmN1ckNQYVhxcEt6Yy9ITWZmWklm?=
 =?utf-8?B?NnBvVDBiUHUra0R5d3V5MTN6ZXlFMGd1VUVvaVRYTy9iQ2JSNnJZSitOQlJ0?=
 =?utf-8?B?SS8wbTNvSFcwS0dHZU1uM1BZUU5nRE9GUFErR3p2bEVuMHlxbmZleEdGR2JL?=
 =?utf-8?B?OWtEUHBKVzFMTDhZZ2d0aUMzRU1JMENadkxIVUdpU1Nsa2I1a3JRNGZmNFFa?=
 =?utf-8?B?RThkRVBjZHI2Vk5zWFI2ZjZOeG1VLytxYkU5cnIwNlhVSTRvUnhhSmxteUY4?=
 =?utf-8?B?d1RBZTRmQ3VwYm84aEo2SHVmN0N2SGJnejBDMXNRcEVaYit6VlFQWDVXVHE5?=
 =?utf-8?B?L0xpY2xwdnkxT1UyRXpFWENQN0VJSzdSTVhTV3dZQUVVOVJTa1cyZERrVmNw?=
 =?utf-8?B?YytTWk5WeVhlMnJ4QzJHenlHaVIyT29JODQ4Z1VaTFk1RkhzMWczb2hDVmVG?=
 =?utf-8?B?Mmd6V3ZKNU5SQ0xvbjZPeFFCd0IrTXVNbDRDdU5DeVJvRkZBczcwWWZVdHpQ?=
 =?utf-8?B?N1pVU0xicGFKMGdHZ0hEQndCaTBuY3FLMDFSbnd0T0ZNbGZ3cWxlSWtaZ2kr?=
 =?utf-8?B?S050anZmbFZjR0RjYUZoeEFKM3NMZm5uOGRQRjlXSVAyVWp3clNsYklqZWE0?=
 =?utf-8?B?NnBNdlBad2JqVUZ1aEFoZVFJNGl0dzBiaXU4TDBXOVNBZFNUSFlPbDBFd3Y3?=
 =?utf-8?B?b1dTaXlQekdyUENVajJjaGcxdTlsVTdYbFkwOWRaMVB1YmtVTTNhMGNkbXNB?=
 =?utf-8?B?cExlSUlWbERPR2xyTEZUZzE3R2VKalpWLzFIMkRDOE5MamxGaXdZb1ZHY2Nt?=
 =?utf-8?B?eWlUWjQxMFg2RVdVc3ZGYjJCWWV5S3NlZVhaQzEzd0VVZ09PQnFWRE9KWDZh?=
 =?utf-8?B?dk1OdFowYWxmZ2tDMTZrbFRtMTk3K2tQM1NaOUVyMTVBR2pYWkJIU09YM0xX?=
 =?utf-8?B?YWFCNGYrT2QzOUZUZk1UWEpud1o2aEorc2lxeUlPTTl4Wm1PeFY3cHNMRlRI?=
 =?utf-8?B?VzlSaGgxVUhvaGFjUE1aNk5jblY5eVc3S0hTQXpYYWRYNWdCME93M25tOW1q?=
 =?utf-8?B?ZTRuQVNuSUFGRlU5cXhMTERLMzFVVlg1ZDgwMTdvSmNOUkE2M2lsUmtlbThq?=
 =?utf-8?B?M3VhNkdvMDBhM2N5cmVhTVU1K2wrWEh3V1lza0hiNjlIa3RnSTJXdmFIcHUw?=
 =?utf-8?B?aHYxREQrc0dsMVFKRStwR1BSeUhVcDRVN0JCWkUwazZwZ21YRWRaWVBUNGUw?=
 =?utf-8?B?aitlUmNwbU9abUZvaWYwSU9Gd01ieldEeUc0Q1Z4Y3RGYzJlSVp1NldNdWt0?=
 =?utf-8?B?WG8rSFVwbmVIbUZnRmtTdTNpVWxVZjRvSlFsL3BtM1k5c2cwSUM1c0tHaGZH?=
 =?utf-8?B?QW85NkZraVorbHpwVWdTa0o1TlluK1NGaE9VVDFQTVVzYkVsVGxITURhUFF1?=
 =?utf-8?B?a2pPaG16MnZ6TUxxOERCZEcySUdXeWxpd284Ti9qK0J0SEw3dGMzWWNhYnMw?=
 =?utf-8?B?bEkxVVM1Q25KTTNZTUJWTncxZm1WZ1ZVSVF5V3h2MXI4M1FDZXJvaEFMNUJD?=
 =?utf-8?B?YTNTTE1kNlVKejJmcFlpZlBqNXZLYmR6cnQ3OGlmNG93a0RGZDZOSTZYaG1M?=
 =?utf-8?Q?fKol3ew0kXgY29hYtTIFOMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36C829CAFE35944B874C962F557AB927@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945dfadf-5391-4f95-cac4-08d9ae684725
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 10:01:54.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZz4Vhocxinow2xbudh/vtwF8wP2ej3ovI3LHbcseI5rWwDrOu8CMTma121/eijee0p/XWuq6HzX6loeh+eM/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230054
X-Proofpoint-ORIG-GUID: lnaLuKBLQmMYfpvpFNKuMu8nawdO0X87
X-Proofpoint-GUID: lnaLuKBLQmMYfpvpFNKuMu8nawdO0X87
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjMgTm92IDIwMjEsIGF0IDEwOjUwLCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIDIzIE5vdiAyMDIxLCBhdCAx
MDoxMSwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBP
biBNb24sIE5vdiAyMiwgMjAyMSBhdCAwNTo0ODo1M1BNICswMTAwLCBIw6Vrb24gQnVnZ2Ugd3Jv
dGU6DQo+Pj4gVGhlIGV4aXN0aW5nIHRlc3QgaXMgYSBsaXR0bGUgaGFyZCB0byBjb21wcmVoZW5k
LiBVc2UNCj4+PiBjaGVja19hZGRfb3ZlcmZsb3coKSBpbnN0ZWFkLg0KPj4+IA0KPj4+IEZpeGVz
OiAwNGRlZDE2NzI0MDIgKCJSRE1BL2NtYTogVmVyaWZ5IHByaXZhdGUgZGF0YSBsZW5ndGgiKQ0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+
DQo+Pj4gLS0tDQo+Pj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgfCAzICstLQ0KPj4+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4+PiANCj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9jbWEuYw0KPj4+IGluZGV4IDgzNWFjNTQuLjA0MzU3NjggMTAwNjQ0DQo+
Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4+PiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9jbWEuYw0KPj4+IEBAIC00MDkzLDggKzQwOTMsNyBAQCBzdGF0aWMg
aW50IGNtYV9jb25uZWN0X2liKHN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3ByaXYsDQo+Pj4g
DQo+Pj4gCW1lbXNldCgmcmVxLCAwLCBzaXplb2YgcmVxKTsNCj4+PiAJb2Zmc2V0ID0gY21hX3Vz
ZXJfZGF0YV9vZmZzZXQoaWRfcHJpdik7DQo+Pj4gLQlyZXEucHJpdmF0ZV9kYXRhX2xlbiA9IG9m
ZnNldCArIGNvbm5fcGFyYW0tPnByaXZhdGVfZGF0YV9sZW47DQo+Pj4gLQlpZiAocmVxLnByaXZh
dGVfZGF0YV9sZW4gPCBjb25uX3BhcmFtLT5wcml2YXRlX2RhdGFfbGVuKQ0KPj4+ICsJaWYgKGNo
ZWNrX2FkZF9vdmVyZmxvdyhvZmZzZXQsIGNvbm5fcGFyYW0tPnByaXZhdGVfZGF0YV9sZW4sICZy
ZXEucHJpdmF0ZV9kYXRhX2xlbikpDQo+Pj4gCQlyZXR1cm4gLUVJTlZBTDsNCj4+IA0KPj4gVGhl
IHNhbWUgY2hlY2sgZXhpc3RzIGluIGNtYV9yZXNvbHZlX2liX3VkcCB0b28uDQo+IA0KPiBUaGFu
a3MgZm9yIHBvaW50aW5nIGl0IG91dCBMZW9uLiBXaWxsIHNlbmQgYSB2Mi4NCg0KQmUgYXdhcmUs
IHdpbGwgY2hhbmdlICRTdWJqZWN0IHNsaWdodGx5Lg0KDQoNCkjDpWtvbg0KDQo+IA0KPiANCj4g
VGh4cywgSMOla29uDQo+IA0KPj4gDQo+PiBUaGFua3MNCj4+IA0KPj4+IA0KPj4+IAlpZiAocmVx
LnByaXZhdGVfZGF0YV9sZW4pIHsNCj4+PiAtLSANCj4+PiAxLjguMy4xDQoNCg==
