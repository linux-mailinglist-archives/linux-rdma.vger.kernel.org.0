Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C883B004A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFVJeu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 05:34:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63818 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhFVJet (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 05:34:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M9RUUL030682;
        Tue, 22 Jun 2021 09:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gC4WqOp1cv4DXGkHD13Gv8B/X9pVvTKVfivWS0gyk5c=;
 b=cHcyhue/tghQTmKXkAjlaqUvWYonLWzyUlPRvdJI7Z/N9uckD+4EKEPn89dQTXgQoJUC
 +XnXs4UeaNUi0wAEZXpU7gmcgsVuIdN4Z6IjB9KBUPstAXWspqx9gGzfJ2PCWSHaDHra
 2Foh1NES7io9jIVh1aJ7D559guEe09UXzt8A4l2rY9BxKsIKpY5C4rkqdI5ViCFrtW4b
 9i7a2xQ/jiKRfv3snu6kvbclf0chZtG3JYk611tWtZ4iEbK7SIdQO2yCOUvcZRBLKPok
 uwBRaG/elhcfeBo5TpxyiqHKew7DPvS5CBIehryr4BSB9Cxxy6PQ36qAntg3dPfqVeqI kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66judr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 09:32:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M9PRer111549;
        Tue, 22 Jun 2021 09:32:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 3998d73ten-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 09:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCykEBwMn7g+2gNrGAYAemgHgTLx6YgBuYH0HYYr2AO3UiCMbt59HcJNgs5YVsiJaSG957hUzO462As4EqSiwcUMhfGrmyhnalYv2++YbBiyOEDbJhhNeohiF+znt5Y5F5V9iIbCLmFCnM4hjwDm7KEtuepOLh4XX5TXKuF19oJrda0DHvXtT3rgXwu2sswNvGCtNQroBgGORTsad7pSJq7HtwWGa5xXqXwvghV5MvROtS1TSm43oNQMZ15qZH9hcXn3jTKxPI9GugetWHMUnYOFueWxVukEQKhgEuJ/cbBR/FQ6SOywEDRDDu5pHxBUYiN6oegZCX1urB5IB8yBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC4WqOp1cv4DXGkHD13Gv8B/X9pVvTKVfivWS0gyk5c=;
 b=duPScotJosGiEmRC975jIchQsuHO7YQD8Yt+XyF0VPG71+Zr7ToRgIhukSmZ3WamdG0HrfwyQjCgfatZTGdIj3AVkoHp14h4aISwXvAaZ3l/+I/asokP8GXCwd9m1BRkSeUp7nxT/n/XFPgCMzqwyyFPl+EBmDop5DNT2PDqerfDYqXtX84ohd2t4ZfgMC9zib5LGakXpCfBhOQDttVgSAFwXGh75suFdxGZvJ4FbB0OkYSq2+OoWyx5J7YBHKCOaMQYomRr5e+HnY1J5bKxXAwTO70MEo4eDIXxqvTZf/C+vHQkfF5O98Zm53sNRRx+cf/2GU5kgBzvL1Xd1sMh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC4WqOp1cv4DXGkHD13Gv8B/X9pVvTKVfivWS0gyk5c=;
 b=TbeoR0+fWaYiYOShfKFHz8hLzyoBOVugUNCos9U7DVgZlZMVsD6iV3/AfdNPhLkXphqWClGk4CU/64iPz2K/NbQTWShkHZNslMLRupjp4WlP37gwt03lp61VVVQTBrSslHCQAyWgq9Fu6OaF1TIEXri0nK+x3Mm/3+lA8aLJDEE=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1336.namprd10.prod.outlook.com (2603:10b6:903:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 09:32:27 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 09:32:27 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next] RDMA/cma: Fix incorrect Packet Lifetime
 calculation
Thread-Topic: [PATCH for-next] RDMA/cma: Fix incorrect Packet Lifetime
 calculation
Thread-Index: AQHXZqAMs2kFDz9F0ECrCUIE8RPlz6sfsRQAgAAUsgA=
Date:   Tue, 22 Jun 2021 09:32:27 +0000
Message-ID: <E0581DD9-4001-48E5-9BF7-24E4D149C089@oracle.com>
References: <1624281537-5573-1-git-send-email-haakon.bugge@oracle.com>
 <YNGcznXKXn2+izJX@unreal>
In-Reply-To: <YNGcznXKXn2+izJX@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e384f66b-a6aa-44b7-7c98-08d93560a6a6
x-ms-traffictypediagnostic: CY4PR10MB1336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1336303A4DC1A030974D87BEFD099@CY4PR10MB1336.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7t74Q7P883vBL9kgxbYOhZNtIchpic4O6aUtFq/iEEgSfYjKvkU1VQ/QzX/S4LH66nQfFSI4yjUd7J52uUuK1dV1E7DQ4u97hpzZ/aSQFuwRZ1N1Mazv9Zy/n+C6/e7ZWUf2jal3pP8ovjTeOHla5D1QIu/aThwbI+q6DpHixOD1NJtpcI7X0tW6cZnymuSqRzlEobFl+PL8x1IBqUEsRrksiCbfjphbUWrZKP2+S/c8qpMTWDKK35f9+J3YuHjPPJc3Oo+tpaUT+GPVKEb76gsI159asz9GStzdtBf8fE+c3sgMJkd4G+fm0MPO9KV5Jij/r/nDjB4u45lL/9qb8sayTt0e5iM6RXGfVq+L/SlXtRXWKgJdroES9/BBf0Ibtx0HHIk7VqADHbxkobXZaQAEt1J+wLEFMEfnSEyZeAP0Nepxjo5zp4S9SNj4P0YLEd/hIOV/y5QsjVJQqEItas0e/+Y/7gGOk8eowVb2ZE9QvdVqZn5ZmYPWcwS2IDMuGvja7UjmKraI2BcKXopqs5iNSBJQlIS3id4pBqJHyKHtNr9gggdXVsbwXwZs3DH+E/q+uraltEZ7sS0VlzPgAcDrnHVNPhepRZF1J++7/66na/VqcO65U8L+IpPXDs7QjK9kO5Y9tZbfSvVSYM3NzlUT4faZ6BLHUt5HPVBSwng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(366004)(53546011)(83380400001)(6506007)(26005)(186003)(33656002)(6486002)(6512007)(6916009)(4326008)(122000001)(107886003)(38100700002)(478600001)(8676002)(2906002)(8936002)(316002)(54906003)(36756003)(66946007)(44832011)(2616005)(66476007)(66556008)(64756008)(66446008)(86362001)(76116006)(5660300002)(71200400001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjRXaHBSOTZjcnUwY3ZUU0FNTDcrNUsvaVE4T2kvNjA1Nk94OGJHRSt3RWMy?=
 =?utf-8?B?MVJjQndBT3NpSGtUV0V1UDhGMWlrM0NTVDNKaXBqK0VyVldOSUZsWjBDZU4x?=
 =?utf-8?B?OGhxUUtIOFVMdVRXZi9JRVA4alcxdHQyVUZFb1lFU2lCMFYzRWFpcUIxTmJp?=
 =?utf-8?B?N1FFSWMvb1JyUXM2b2FBZ01oSG5JL2NEWlB6WDlDSUxlVVRhazVZQlN2aGRF?=
 =?utf-8?B?d2JJbnNHdWJ2eEd1aExlbFdRODd3cWsxUmhtV1V4b1dyWDlrMkVKUDJDWUdH?=
 =?utf-8?B?UVd5ZEt4WE9hcmMvMGoyOU04ME51bFMyZXJxZ3JkZW9GZDE4Y2V3bHlEbnlz?=
 =?utf-8?B?TklsbkthbU5xQVBuVGN0OGpiVHNJRjRVMHF6RUgzRGQ3NVFvWHFRYmkxelhI?=
 =?utf-8?B?R3dDOFNOTGUzSzNPVit1bVBrRFdhSVBxNzJJUXZ2YkE1N1Nzb21FVWJPbVFO?=
 =?utf-8?B?ckFvZmRSU0lsdTJqdkpjU2dqSUVIMmNHcDhrNWs3OUJhK3RNYnpuNU5Yakh4?=
 =?utf-8?B?TnFlYWlBT3ZxNFhXZ0pzamJkbU1FNXNYQlJOOHhJTEJtemx6eDg5d0czb3Bs?=
 =?utf-8?B?V2NpUDdkTGIxVDRwZHJVN3A3RjBQckhadk5uekZTQ3ZadDhIUU5GaUFYcVdM?=
 =?utf-8?B?ZEdYQjJ5aFBmbVVyWGRMZEhpVG9vamlQKzRhT1BiVGJqNHEzSVVWZWJjRjlk?=
 =?utf-8?B?YnVWelB1THI0aWc3Q2RpaXNHVytiYVAzc3FseXhES1RjY2NqU2I1cHh0eDB6?=
 =?utf-8?B?c25RQW1yNmNhRmNUbklkMHNBMGtxL1NpaUNmNkJiTE80VjlnRllOK0xBWVk5?=
 =?utf-8?B?K1NuRDQweU9NdXZEeUhIbTB2dDFXTFZMeHRrZitYd0REVnAwbWc4c3R6Q05N?=
 =?utf-8?B?ZmFQVC9hK3BMc2FtcjM0eFpmWjNROXdiekZUZXNJYnJhVkR0bmR6OFN0YnpO?=
 =?utf-8?B?bVdKaVVlV1ZzckQ5alovU055QmRGMStyYktLMk9HQ0tZd2xCdldDYjlMd1FJ?=
 =?utf-8?B?anNBRTQ3SnlTdVVFbFB1YzFmSzJXQ1NrWTBicjh3aVJYendTOS9LcnB4VWFh?=
 =?utf-8?B?S3d6dzErRHArZEZQKzdhNEF6T082VHZIL2kzeis1ZFZldkJDeDFkMEJzS3Vm?=
 =?utf-8?B?NUp5TlRlUVRXWGc5MFVYNmJJb05CUlcrTnNva2VqYkRiVXdaR3pLTkNKNVdO?=
 =?utf-8?B?YWtDUkU5NDczTkMxWXZJTlVaaVlFWlZ2d05ta3FFcFlISmhQalJuMHM2cGIv?=
 =?utf-8?B?WFJOb1B5QW4zYmtmM2ZzTHEvenFMdUZKZWphR0xkYkczZW9zTXRlSEFPVXhQ?=
 =?utf-8?B?YnoxWUgzVk1CNlZkMHd6NHlPblRUcmFHOExVUnQwZEpvYkRkZHdWdUNvOTZ4?=
 =?utf-8?B?NTBpZi9ObGtBT0ZUQXVZdmZTaWdwazJ4amE0UEVBWHRHd1R4SUsydktWR2Fv?=
 =?utf-8?B?SUZCY0M4WnhueGtZRnRqaU9HSEhJdUxCWXdPRHdHZFdPbFRvcUlOdHJoYmNv?=
 =?utf-8?B?ckpheUZ6OXlTWGFkYjZYREhtbTNaSU5tMGFyUUZKRE5lSUxsa3lZNzZjRWNh?=
 =?utf-8?B?TTZZQ1h1cHdBN1YrTmFvRUdCbzFDVUEwTmNrSW5vRm10RDBWZHBLb3kxWlRP?=
 =?utf-8?B?cGV5aUJoYWpmMk8zdmswNmxEWDNqMUtrcmdJMjI2cDF3MTR2TnVkaFpMWk9S?=
 =?utf-8?B?ZDRncFNaWTlXV2pVZlk5U2NEUlNFY3J1MVRVMGRkVG93ZGZpL3h5eVQxV1ZD?=
 =?utf-8?B?ZWdDVFBvbVdocjNxYXVYZjlscnpiUzJEdVdTRmp3VFFaU2hFTU0rTHc3V01U?=
 =?utf-8?B?b0JFVUY4K0Z5VEdWem9ydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E29E830764D5DC429E1F2D957A4592ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e384f66b-a6aa-44b7-7c98-08d93560a6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 09:32:27.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuGEwe1kgE8oNj1QYOqEMf6ZxH1P9vQloAanGGF0zkJw8kkNCbep3a0wngKZhFUcQCPOtVKZFO0O43DgWdPGew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1336
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220061
X-Proofpoint-ORIG-GUID: _ECvDBnzr-brPUPj7BB-kWA5FiutPhCB
X-Proofpoint-GUID: _ECvDBnzr-brPUPj7BB-kWA5FiutPhCB
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgSnVuIDIwMjEsIGF0IDEwOjE4LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCAwMzoxODo1N1BN
ICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBBbiBhcHByb3hpbWF0aW9uIGZvciB0aGUg
UGFja2V0TGlmZVRpbWUgaXMgaGFsZiB0aGUgbG9jYWwgQUNLIHRpbWVvdXQuDQo+PiBUaGUgZW5j
b2RpbmcgZm9yIGJvdGggdGltZXJzIGFyZSBsb2dhcml0aG1pYy4gVGhlIFBhY2tldExpZmVUaW1l
DQo+PiBjYWxjdWxhdGlvbiBpcyB3cm9uZyB3aGVuIGxvY2FsIEFDSyB0aW1lb3V0IGlzIHplcm8u
IEluIHRoYXQgY2FzZSwNCj4+IFBhY2tldExpZmVUaW1lIGlzIHNldCB0byB0aGUgaW5jb3JyZWN0
IHZhbHVlIDI1NS4NCj4+IA0KPj4gRml4ZWQgYnkgZXhwbGljaXRseSB0ZXN0aW5nIGZvciB0aW1l
b3V0IGJlaW5nIHplcm8uDQo+PiANCj4+IEZpeGVzOiBlMWVlMWU2MmJlYzQgKCJSRE1BL2NtYTog
VXNlIEFDSyB0aW1lb3V0IGZvciBSb0NFIHBhY2tldExpZmVUaW1lIikNCj4+IFNpZ25lZC1vZmYt
Ynk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiANCj4+IC0tLQ0K
Pj4gDQo+PiAJKiBOb3RlOiBUaGlzIGNvbW1pdCBtdXN0IGJlIG1lcmdlZCBhZnRlciAoIlJETUEv
Y21hOiBSZXBsYWNlDQo+PiAgICAgICAgICBSTVcgd2l0aCBhdG9taWMgYml0LW9wcyIpDQo+PiAt
LS0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jIHwgOCArKysrKy0tLQ0KPj4gMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+IA0KPiANCj4g
VGhhbmtzLA0KPiBSZXZpZXdlZC1ieTogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNv
bT4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBMZW9uISBJIGhhdmUgdG8gcmViYXNlIG9uIHRo
ZSB0aXAgb2YgZm9yLW5leHQsIHNpbmNlIHRoZSAoIlJETUEvY21hOiBSZXBsYWNlIFJNVyB3aXRo
IGF0b21pYyBiaXQtb3BzIikgd2lsbCBub3QgaGF2ZSB0aGUgZ2V0X2JpdCgpIHN0dWZmIGluIGNt
YV9yZXNvbHZlX2lib2Vfcm91dGUoKSBhbnltb3JlLiBJIGFzc3VtZSBJIGNhbiByZXRhaW4geW91
ciByLWIgYWZ0ZXIgdGhlIHJlYmFzZT8NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQoNCg0K
