Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4B6C7DEF
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 13:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjCXMUf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 08:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCXMUd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 08:20:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9D6241CB
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 05:20:26 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OBCDgX029096;
        Fri, 24 Mar 2023 12:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=+pIBotb4vvIGNX/d3XoEwkMKjGezoYazZKTtUYOHqcQ=;
 b=Z8EBBqk03/7XYZOvv+pCL3NIj7zB2NC16MhcTS89Uz7ExkrzoZeFVcsGpFyGYR1lYYoa
 1yXLU1Zi0nRVk3CM3NI/gdvr1wnBgdamkxS8ypClhumIRDtkkCxu86WONJl/BXwyECWI
 mrDBvBU7pev9y0/HG4L2zcBhdNSfIZmqKv1vbgpjKyguiGhLKybSFZsD9nyKW53yLNFk
 lP9zJOIzQVvHoDt/+5LJlreI2k6qRTLjpydHe86Ze53lxUjQyuo0bt5hYiHL0scwzYrz
 SzWXh4Npfg9IXNkWIh+6BsjNJRy5k4pexqxJglBc+6FcdaBZLOrrs3yYgHA9SYMkQh2U Kg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phas9sjss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 12:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5YYR8lw6rPYcIpDoktsc8NO+Dmz5/LgQCuyBUi8WOb1RG6IvtYsBznVCeaQGgnaOLQAeHAudhL3PS48fJEFbiACusp7Vs0Ix4o9U1s9/0TPaGU5UBztlE0wyeQDXd/7+xMc55UcfIr3tto5+jYj4Aquw8XasYRaMCUAY3gGGCbFrwfHLiJ9oBDMS+e2rTpGHChIxbWw+aSg5zoluD6rqK09eB8dyHwDZbA6Vs0XThXcsjbWmdu5maMLp2NoeRGf5VU3UFY/qb/zWp7kr9N8kSA3hg5YbgCE2AV0Woi+l3acbtAM/iTWkjUt4olShVTCPnc4woRAuOP5M4FbrFBM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HvduSGrLUYBXNDUbjlZpUC7ovUwTmaBxmGDqP0lXxs=;
 b=PsGGBXLMukjVPkpYrUFNZttt8JZlwdT+Sb7gdUn4yZlppoy4ZCYOJy+0jok50eOyJP2YhRzty1J1Kzx7jl9pX7R+0vLHBWkkhrHrdBCDsqyh8xlX5AF0LyhjO78G18I2Lx6nBGoZGM7YEJZ+2kbGh8i0pzobEc/d2+qNvNY+/MpidvwRZ51PYRP45x7og5JrLKH225h4rXo+odCm4v7USeAe/Iw0rQkHOMrzVSrV33kiryj/ycLW+EO5NFcTdBsM7azn2bW0JThwpAuWPuPac+ErFyTu9XYmfI2L7x98EmUYlgSbXTzkknq9XVkerE5r97nl/dv/VUsi5tbkIooNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by CH0PR15MB6234.namprd15.prod.outlook.com (2603:10b6:610:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 12:20:17 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::2f90:a221:4b7b:7f99%4]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 12:20:16 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: fix a refcount leak in
 siw_newlink()
Thread-Index: AQHZXkPZyMWFzyNKYE+CrkP68an5jK8J1m+A
Date:   Fri, 24 Mar 2023 12:20:16 +0000
Message-ID: <SA0PR15MB391911C8375361CCE0D67C8B99849@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <0ae07b18-e384-5d5d-54e8-8fe508af4f6a@I-love.SAKURA.ne.jp>
In-Reply-To: <0ae07b18-e384-5d5d-54e8-8fe508af4f6a@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|CH0PR15MB6234:EE_
x-ms-office365-filtering-correlation-id: fb5e83de-1e02-4fd7-e31c-08db2c6220a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6eSR08RkNwicyYnPAYayp1zHrGlMzZqcrZ/A3grORxZYVPWRSVFklpu/wx/ZluOE3QFkh/wAy8wFkjd467XoMU3rppHPoiCH+OLO3wA/V6o1W2PXR+I0GCFTH+1RdmVT7QzCb8gzdSGB9oqx3fdQvL0Erpz8E0lqdqDuCXKxHmYhQNcadYhqdfhNTI3n4NLGoUOo685Hsoccr+SI6Re6qm+b0QnNhdnsz1/pFml/e482h6vHbdcOAlDxyCrBnJqIH/V4BBDRsGmswhmygdmhfAnXvttQHw4/CZ0bGolvQF4IqLEt60a/SO60hdkZ4ed+zU20blEkxZ2NEzdgPB6pPrF5DPiapfHYw0nAvwjaELl+TXtRi/3YXAyWB0LYB7rz1MANkKS/R3zKJhEpMagGuc85DofCZBHyIQCD6SpqY6s38Bjb92RBbvB4+XAbiOSpPF3jX2rxmsDm1Vwq9d29KAsvPt5KfkZyF9spq5ZMFmoBcmK9voLDlHx+E1cIvsy34XJ6i3DVG74KpjEgEfp25T/7B6fP25CoQMNavlHW1OhpL+086peILzYCNPYlVfWncDA1y9qqssVriy6D7U4ramYEbps+CUOO3GY1dbJ7xGXkHnTprdC5AKzuweQ4uJiTCgBVwlASF7we6GszqOW+9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199018)(966005)(83380400001)(478600001)(110136005)(41300700001)(6506007)(53546011)(4326008)(66556008)(8676002)(66446008)(66476007)(64756008)(76116006)(66946007)(186003)(5660300002)(52536014)(9686003)(8936002)(2906002)(122000001)(38070700005)(71200400001)(7696005)(38100700002)(316002)(66899018)(33656002)(86362001)(55016003)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnpSS0tnVlArT2I5QjIyT0h1dDNSYUlicTc5RkZLbmx5ZkQ1YXQwV0Z1TE91?=
 =?utf-8?B?eVROVGRkT2F0SzVJekN1OWNzSlJRcE16UzVJUHI2QnpXcW1LVmdQbTNLTWoz?=
 =?utf-8?B?WitrWFFtdHU0QmJHcHM1TXo4WnVyWVVUWmJPeFRmV1dHbnNxVmwxQ0FzZnpW?=
 =?utf-8?B?d21vWjJrZmhuSitrV3ljYW1CR2xhMldzUXVKU253ZkhGUGNMaWNJQUV5T3BD?=
 =?utf-8?B?WUJzaHU5bmF4Y0NwT1o4OExBWXZCT0pFRnJINDdXc3hlZk44RUF2SGl3WTlD?=
 =?utf-8?B?U2dVbDhmV2RSblBCLzhlemYxKy9FYytzWnIzSlorcUhLYmNaVHlnV1RreUhm?=
 =?utf-8?B?YjF0cEkwOFJmdE5SQWFGeStPRDFHRDF6Q1U4U0p0YWpTSlBlTWFkOVd0eXNW?=
 =?utf-8?B?WjRsSmU5Y2dYS1VjN1kwUVE1MHl6akVTdFFOS01jWjAyRzYvOWdVakhQQ2lU?=
 =?utf-8?B?TXBCeVFtcmh2QVJsUEUvcFExUWpYakk5VXVOQ0tETXBBU0ZnVEFaSU14TE9N?=
 =?utf-8?B?QklydTl3bndrNk5SdmJvQWoreGpuT3g2M2tNT0pFcysyeWpxL1ZUYTZEOC96?=
 =?utf-8?B?aWdMKzRtWTN0WHlDZGloMy9PL1pEYnJJWmJpY05TSTJQejVTNkJISFlDTDg5?=
 =?utf-8?B?RGpvZGFOa3l4V1pxMmVtZDd2bktrcUtGMnlPY0FNeEFZUzJWK2VsY1UxME42?=
 =?utf-8?B?eFR0TWRtS09obDRjV0l6eHRrYkhoaGhZYk1nRExqNTR6Z0JWQkF1OThRdTk0?=
 =?utf-8?B?V21oYlJ4bzBoaFVEWkRxOWdEbnVDemFMTk5SVzZvdW5vQzN1NHZqbm1tVlA0?=
 =?utf-8?B?NE9ncDdyeUxXdmQ4Rloxa2dqWUVRZmQ2TkFocmMxUFJyUlYzaE5MVU5mYjF2?=
 =?utf-8?B?cGQ1STFQakZycWZzZ08yZ0Rxc3BHeWVUS0txWUoyektvL09NeWErdXUxT3hB?=
 =?utf-8?B?QlduUDN4Q2NsT1JXUmZPWnNjL3pRT200VW5pS2NMUWNjaWFzNHBqTkVLcnJN?=
 =?utf-8?B?cjFPcEJJd0JTK3RNejJYTVhRdjQrUWIxbmtCRWgvOS9ZMVZNOWpFM3JZSmRD?=
 =?utf-8?B?M21BRW5QSWdqbmpmcGVGUEh1NWF0WDh1SnNMK01XT3pDNmNoeENuNloxZEE0?=
 =?utf-8?B?aEg2VHg1U0o0RUdkY0xkNUlHU1djZ2xXc05rTXlXWHdPUDMydVhwZGNML2Fy?=
 =?utf-8?B?SkplTUdwWmlLeDRWR0xMSGd0dWdXWDZHdjZGYXZDazhneDhHY1huUWhHL3p6?=
 =?utf-8?B?bEI0MVB1NGlrSTJrbVNQL3NRZHVIRGRYeXpxc0dYRzBuUEFzQnJDU0xoZXlZ?=
 =?utf-8?B?cXFncm8xdzVTSFQ1NHhKUDE1U0kyUkl4cG4xTEpldDBWREYwSVBmVjJudVhm?=
 =?utf-8?B?ZkRPZTZzeWVDUTlYTlR0a0dwTVo5MUFpSzJIbHc2RllVQXVaa2F0cW5RZWRB?=
 =?utf-8?B?NlV4Zi9SbmJRcEQzR2dPMjBRZGRDVUZsUHhQR3IweGZXTGszR3p4V0kweXBN?=
 =?utf-8?B?cTBtR01BcEtnd29qRVBsUWtyTFVPSUFtN0E0Q3E5OGQzNkFwYkozM3A2TUhw?=
 =?utf-8?B?M3BmMHFsRGtGTHhKM0FBdXF0UUdrTWVzNDN3SFlVVFRNWlpPY1lvRnNrVVph?=
 =?utf-8?B?QktLVk9KOHNyKzhsSkxKZlpaYWVEVE9KWmE0L2RkSnEzMlhiUS9hY3ovbXZM?=
 =?utf-8?B?WWdkQ2JtdCtKK2hrTUpLdlV6VXZDRFVCd2N1czRYdDhwRmRHeC9XYUpHOGdn?=
 =?utf-8?B?NnJEY1RIY1k5QmN6UTFmVEdqblpKTFNTbnh4VmZoNTZlMmNBUUc1WEdvQnVP?=
 =?utf-8?B?a1VqUGpnSnV1aWhYNHhrVVFndGI4Zjcxek1GWklIVzU5aFZDbVc3WjFNaEht?=
 =?utf-8?B?STJTd0ZkaGl0dzJhS2t5MDB4alRqankwQ2FLM0tRemxKZ0h1SHhRV3V3SHRv?=
 =?utf-8?B?RjY3M3VZOEJvN0hoK04rcWoyS29QRlBEeS9qRW9qd2hmVkwwdlBDVkhuWVE1?=
 =?utf-8?B?aXIxa2gxaVZkZmI5VW5NSEhOOURvVHkrNHQramNJS2pqdXVMWjlOT1FuMzVZ?=
 =?utf-8?B?b05yOTZnU0lrL29xYitUdERPV0FyeHpvU0RUMDR2U0g4RDlVMHp0MVlhZzlM?=
 =?utf-8?B?aU1maitXU1FRdUYwOGJHeXhiK2FEcXY4ME9HeVlhSGtZWCt3a2J2MFRFZjNQ?=
 =?utf-8?Q?ZYeY6GIOypb06jiSkmgOsV2Mt5GRxCfVq34OBc4s6z73?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5e83de-1e02-4fd7-e31c-08db2c6220a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 12:20:16.8813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUbLt08qI6JWLqs7YzyLBRX07YYrO3OUTHjrUj0wbP09fR/rjYmJjdebeXnwxhNiCMJ+ViBKJmRXuQmQeg9vjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6234
X-Proofpoint-ORIG-GUID: Z4xLQiRDuflGWfKhEmaXnfb7vyrorrSs
X-Proofpoint-GUID: Z4xLQiRDuflGWfKhEmaXnfb7vyrorrSs
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE:  [PATCH] RDMA/siw: fix a refcount leak in siw_newlink()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_06,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxlogscore=870 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240099
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGV0c3VvIEhhbmRhIDxw
ZW5ndWluLWtlcm5lbEBJLWxvdmUuU0FLVVJBLm5lLmpwPg0KPiBTZW50OiBGcmlkYXksIDI0IE1h
cmNoIDIwMjMgMTI6MjkNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29t
PjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+Ow0KPiBMZW9uIFJvbWFub3Zza3kgPGxl
b25Aa2VybmVsLm9yZz4NCj4gQ2M6IE9GRUQgbWFpbGluZyBsaXN0IDxsaW51eC1yZG1hQHZnZXIu
a2VybmVsLm9yZz4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0hdIFJETUEvc2l3OiBmaXgg
YSByZWZjb3VudCBsZWFrIGluIHNpd19uZXdsaW5rKCkNCj4gDQo+IHNpd19uZXdsaW5rKCkgaXMg
bGVha2luZyBhIHJlZmNvdW50IG9uICJiYXNlX2RldiIgd2hlbiBremFsbG9jKCkgZnJvbQ0KPiBf
aWJfYWxsb2NfZGV2aWNlKCkgZnJvbSBpYl9hbGxvY19kZXZpY2UoKSBmcm9tIHNpd19kZXZpY2Vf
Y3JlYXRlKCkNCj4gcmV0dXJuZWQgTlVMTC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRldHN1byBI
YW5kYSA8cGVuZ3Vpbi1rZXJuZWxASS1sb3ZlLlNBS1VSQS5uZS5qcD4NCj4gRml4ZXM6IGJkY2Yy
NmJmOWIzYSAoInJkbWEvc2l3OiBuZXR3b3JrIGFuZCBSRE1BIGNvcmUgaW50ZXJmYWNlIikNCj4g
LS0tDQo+IEkgZG9uJ3Qga25vdyB3aGV0aGVyIHRoaXMgaXMgYSBidWcgc3l6Ym90IGlzIGN1cnJl
bnRseSByZXBvcnRpbmcgYXQNCj4gSU5WQUxJRCBVUkkgUkVNT1ZFRA0KPiAzQV9fc3l6a2FsbGVy
LmFwcHNwb3QuY29tX2J1Zy0zRmV4dGlkLQ0KPiAzRDVlNzBkMDFlZTg5ODVhZTYyYTNiJmQ9RHdJ
Q2FRJmM9amZfaWFTSHZKT2JUYngtc2lBMVpPZyZyPTJUYVlYUTBULQ0KPiByOFpPMVBQMWFsTndV
X1FKY1JSTGZtWVRBZ2QzUUN2cVNjJm09aVdmcjFfMS1zUUhCYzJPNnlxYmxwLXhNU2VMUmEydi0N
Cj4gdG5naVc0Mk5hTk1Oa1BlSFJWVXdzWkhOOExKdHJhRmwmcz1YOU9SZ0VOdkttNWtQVk9jOEdJ
blhmSzhhRTVWZWlTS1JfLQ0KPiBCQjhpaVRfQSZlPSAgLg0KPiBQbGVhc2UgY2hlY2sgaWYgdGhp
cyBwYXRjaCBoZWxwcy4NCj4gDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWlu
LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jDQo+IGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jDQo+IGluZGV4IGRhY2MxNzQ2MDRiZi4uYWVm
ZWRhNjMzNjU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19t
YWluLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jDQo+IEBA
IC01MjIsNiArNTIyLDggQEAgc3RhdGljIGludCBzaXdfbmV3bGluayhjb25zdCBjaGFyICpiYXNl
ZGV2X25hbWUsIHN0cnVjdA0KPiBuZXRfZGV2aWNlICpuZXRkZXYpDQo+ICAJCXJ2ID0gc2l3X2Rl
dmljZV9yZWdpc3RlcihzZGV2LCBiYXNlZGV2X25hbWUpOw0KPiAgCQlpZiAocnYpDQo+ICAJCQlp
Yl9kZWFsbG9jX2RldmljZSgmc2Rldi0+YmFzZV9kZXYpOw0KPiArCX0gZWxzZSB7DQo+ICsJCWli
X2RldmljZV9wdXQoYmFzZV9kZXYpOw0KDQpiYXNlX2RldiBpcyBhbHdheXMgTlVMTCBoZXJlLCBz
byBub3RoaW5nIHRvIHB1dCwNCnJpZ2h0Pw0KDQoNCj4gIAl9DQo+ICAJcmV0dXJuIHJ2Ow0KPiAg
fQ0KPiAtLQ0KPiAyLjE4LjQNCg==
