Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC7390552
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhEYP0f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 11:26:35 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:40256 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234288AbhEYPZb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 11:25:31 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PF8IJO022077;
        Tue, 25 May 2021 15:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=8PEo3laaHldvXwDWwUT2J0pBvs2C84GuPzmq49laxNc=;
 b=olYYSYhTK6uyB3UZA/OA1Jk6FdBHkVp4voFstfdIwCtrcaPBz7zRD6MWMPPKx5ursZsT
 A4rOhDVj/9PQXXBIbQUEP/xFQkW6BTfVNQBiVCHQqFCGpzOqFqBjSKFj/c+/VX3VSrw3
 flp4jj+FAsbdPNktuWTwkqpLuUvs6cOj6D1zWk8MvgxVSqHa1t/oDuw+cBiCN8Corey8
 O+UnVvE8f+frKwwYpfMx5jfOsB0PbJrv6rg7hO2VIx85EvrJj8XDmZ/1JZn1LDkfiNcY
 9n7cMHWeh7IforAEwR2GTRGbkwTYWeEOUYgifY24vsnBpMFGPjBpDsdAKM6XxBJ0w2w0 XA== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 38s0acammq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 15:23:52 +0000
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 331189A;
        Tue, 25 May 2021 15:23:52 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 25 May 2021 15:23:51 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (15.241.52.10) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 25 May 2021 15:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf+kgBsKSLAFsvWioNvZmUOrAZU5AJjxdwxJzfNIHNtKiAbTeAfyEKB8wqFK+zw42IjIvouYOj+3mYd+PC6jRnQEpPGnkijjVtjLTCJnEGCRcFlRYmP1gxjWq7jkW36t0u5RvH91ijqth5WPBDrrBfmS46qbdmDKfY8p2sTKAam0uOCkUE7MG7RPyciPnNrqhOxltopPggvfmLbFqaIRzQ83o+pYpQ7oj2cR7Z0Anv0dvSFTy88J8lwYEdL/9QFmaI1gTx9nE/JtCRxMGzhatBju2SlWO1J3aRsSl0L/mGsLbkwAPqjSayamhBvMUI4aYk8pwpTiuXvrIXJfFVvfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PEo3laaHldvXwDWwUT2J0pBvs2C84GuPzmq49laxNc=;
 b=T3NJUjIdWoGGZ/LHPGlYYgR9hvadZDOPiqDTUn0rA+CkAysQIfXyshjXJy07NF0mZ5vY2HVmJN0IdnyFNVzzLEHupft+9JriCuPjiW9A0WC5/pzPRQ8maKcpMqAGriscehplYh99elEemU0Hw0Q753isiKfc/+LWkBrILCSfKRPhqM6m2n4qzz+pi1fWq8BlwerZoQjXnR3h9BZCZotqJaJROz+mYe2PfW6DjV5yzHHbDGpsa7gTORMSmmfGtOD3NDSZm6lhAc0Rr8GkderJ/Mkgz7CVY1bZqqvoOokzi9nCWAlySfYO0TPQqPebz3T97MNuclwKHulega5JNWJC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB1190.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 15:23:50 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 15:23:50 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     "Pearson, Robert B" <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Thread-Topic: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Thread-Index: AQHXTn6ajK43gL8jsk+C/W8EbrrkNqrx+NAAgADXEgCAAKjxAIAAK81QgAAJFoCAAAAsYIAAonmAgAAD4iA=
Date:   Tue, 25 May 2021 15:23:50 +0000
Message-ID: <CS1PR8401MB109691557DEE165AC0B9C47ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
 <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
 <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
 <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENdi4XC=ZQDnm4TGx2CHTgkQuFWd2ET7GbXOMz1zsz_JRg@mail.gmail.com>
 <CS1PR8401MB10960767E276430FB619CC6ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENfATTprVG+wYa+1qjdTcuetLyzTt8gHjfcWp5PsLVL4Pw@mail.gmail.com>
In-Reply-To: <CAD=hENfATTprVG+wYa+1qjdTcuetLyzTt8gHjfcWp5PsLVL4Pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:c8b7:c209:b9f4:b5f3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f30040c-f81c-42d4-6d87-08d91f911940
x-ms-traffictypediagnostic: CS1PR8401MB1190:
x-microsoft-antispam-prvs: <CS1PR8401MB1190B16C57DCB23ED3CF9134BC259@CS1PR8401MB1190.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1NAhX28rgDBBIvFqp66ZFXi75aqiiw8th4Nj+fPBqfyBsafoitsqrRty5ETl5ki/mpgtUeQyrNYEQDigiGNydyHwBj/spgHVELDYm9s9TSKl5CYGWRvmQY704XXH+7j0ApJYmemR7AwkMJcmMfeojDmgCs1s/gUqEra5lJfd+w/7OimW59tG/xiU/kBLO/jiPg1PsU0+3AH4ZRT7RCvJ5JeEbyiFFHCeCYkJpubDa3jWVqHpHUMk70IwS/L38VtSW5bOEAkcYAwGr6rXWig0vkat1XVfcSGIH8rSOF4/GYdVdY4vBD8rEhw5wx4K1vzHELfDb0RMe9NvD2v2+Zn7bxXbCPCUG8titYQU8DBjIpgGKzlTl5tSeCIwRlR5NvYFK9OcG2ddA9Tf1NtkHmMHNl3vJe8bdin4AjSa7zZXC1i3OVc8QBeJ5TBP2AJK9PAhz73yZVbMuybD/UUau0oqLkCe8+c9t0m0WVyvU//+yMf2g6fsyEK4MpfeDx6k/+5m2/igEb6z1QCDvhgB2oDTglPCExO6vU1RjoIy6ZOU/SzV1KSbeomis6XxhT+xFxphOJ+eS8ygcQ6ygCnVIFlVumGEuUibpInUD234BBU/W1liDw4p93BheWLnKHbKxsJ+n+v0ahtHKc6UiBn4FBbdHzSUJ8Bs+Oh568w8WUpmR3KO+3zGSfUO6p92vSwBGsX7YxbyVzA9epbHqZTwFDW8ijcz2Gr21AzeJXo3IsykT1c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(33656002)(9686003)(66556008)(64756008)(52536014)(76116006)(66946007)(66446008)(8936002)(6916009)(86362001)(6506007)(122000001)(66476007)(38100700002)(7696005)(53546011)(83380400001)(54906003)(966005)(4326008)(5660300002)(8676002)(71200400001)(316002)(2906002)(55016002)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VDNhUkVqRytVMUc1NFlwK09mcDJqUFM2NGFIWVVYTUdrU3dqUk15a3dqYjVC?=
 =?utf-8?B?NVpieTR1a3hVbEpkQllSMDhHRVNDM3pMVUZPcThkNzVmTlJPSlJNdDViWFFk?=
 =?utf-8?B?THJZWGlrZWtIVXpGcnh2aDFSL2FMa3NzWVFES2ZSM1BnL2Qrc2JSWUc1b0Nj?=
 =?utf-8?B?ejQvelloZmprdVAxcit3SlY5K3RxZFZTTllhaW5idTNLN3JJeVhTRlJYcXVW?=
 =?utf-8?B?dUdjdS9zV053ckRMTDF5Y0hnMkcwckhmUWFsUng0bk1WUW9KQ3Bsd24xVjJ4?=
 =?utf-8?B?blhTTHZMQUdrTHVqdU5tdmx3d21UTzJodC9wQ3NxbzVOQlpOVHFUZEtsbW5R?=
 =?utf-8?B?TXJsaStHUFZ2V3hOTXo4clhtdFdsWWx1V3BURkd0bU5INytvTEJmRng4aitO?=
 =?utf-8?B?TTVIbXV1K2tNK2svODMyK3pnNjlHY2k5bjl5TVZiRlNMenZiQjkvTFhRc1ox?=
 =?utf-8?B?MG1uMlBOanhCaUUrVFhaYkdjT00vWmZmNG1Tazc1V2p1RTNscVVGZXdJQlZq?=
 =?utf-8?B?ZjczKzN6K09uTlo5UFhMODNwOWxDbnRRZ1FpMGFya1lRNjdVT1J1c2I2MzBW?=
 =?utf-8?B?QnNoNnlTRXdrU0pvcFVSSGJCSUtRZEw3ZmJLendNLzd2dENCaTlXSlFLMEll?=
 =?utf-8?B?NDNsOXYvYWZzVVBQVGIzb2hzT3JHLzh0dFpVa2NuZ1RWWWpIZVVRa25LSWNP?=
 =?utf-8?B?d1J6d1VtODVzbit4aXBLRkRxTk5wc1ZmZmdodzAyUDhCbmE5b0JCTWVaTmFK?=
 =?utf-8?B?L0pvYWxWeWZOMG1qcmdEa0VhaFA1UndNVXFIS1g5ak5uZW90SlAwbEU5aUxa?=
 =?utf-8?B?aUR5TWhTYjVybUJNMWhNVVBHQzc0VmFIbHJQZ3pEY3JLZUZDVVpWVHZIaUdW?=
 =?utf-8?B?N0tVMDhDRE1oR0I4N2JWM0xJQTFCdDhCMk1ibUF5YzNIUFZpa2l6L0lCREV1?=
 =?utf-8?B?OWRLN0NLZGlleVU2KzRrSXJFRVZJVGRXMTFuYmFVSnJ3eTE5UXJkRUJoMjR4?=
 =?utf-8?B?TmwxR1F1T2dWdDQxeEI5NnB1ekYrQjNqeVR1Z0oyeU1qUEowK3hqaXRBMHFS?=
 =?utf-8?B?Y0ZoQWZKbWwwU0R6WXRVZVZHN1hUZFZYcTNGY01kendFSUN5ZXIzZkc2YTFp?=
 =?utf-8?B?aVF5VTZidTF6dnJOdVVJNVgwMitVa3VXcEw1THJrektQcXd0SWoxTVFYNEFp?=
 =?utf-8?B?c3cySVc0MHhQR3dFVDhhOU9XZjUvK0E3U0gvTWtHMFJ3VFExNlVxMzFtWVQv?=
 =?utf-8?B?ZGtjZkhPd0p0ZnhHRDdiak5UeVFJRmRmWk9UalJaYzc1Z1RXc2ZmU0V2aGZP?=
 =?utf-8?B?NEZBVEhUcmdQamExYWVuK0xCKytVaWNSeHp1czNWelZXSnhDN0JoaWVnN0lI?=
 =?utf-8?B?T2wxOUVlZmZjV3l0UXVDbXRzY1ZTSzZWVDA5WHNZOXFXSUJDcGptbGY3VmNE?=
 =?utf-8?B?bmhnN2xhOHJPckxYQk5tMFNMUVN6bkQ0dU5WamZNRWRIanVlS3UyUndnSzVN?=
 =?utf-8?B?cEtjOWlYNmZ3SmdGYW8rT21qbEY1Rkt6TmQ2L2V6M2xWd1ppRzdtSDB3Qjcv?=
 =?utf-8?B?RTlKVkp1WTB1dzFJL2E1ZnI4L3JQbjAyekFiYURraUxXMVZzMFRPSmhzTW1R?=
 =?utf-8?B?WGEzS1hOc00rNVY5QTlTZDg0Y1BkcDZPUndhYU1iRjZRcHVjdVA3V01PeWxZ?=
 =?utf-8?B?c0xqeW83bDU0SmExbDA2Um1rbDBhL2dCaFBSLzVtcHN2U3dqN0FzMUNRd2NS?=
 =?utf-8?B?YVlQQVlMUXZ3cGY2TlBybHhmaHBOM1dETW9UN2xmMUllYVU4bG5FUzJpRldw?=
 =?utf-8?B?NUxkUUhXdzBUUE13RDVzQTh1NzdGREZwUWNCWGVqeWlSYmtsV2hRV1UySTZq?=
 =?utf-8?Q?Iu4dE7LbXXZxK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f30040c-f81c-42d4-6d87-08d91f911940
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 15:23:50.1908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGTYnVM6ors0KydABHyQHT9qRaxzXIaqnMAqzIMuOsJ5y6WfLuaJ4Hf43p7Mf2AJDNNhhy7V/asTLcF2QIrLmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1190
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: Ucxypd8PWoGuzLroeYBr79DkRPx1cpG7
X-Proofpoint-ORIG-GUID: Ucxypd8PWoGuzLroeYBr79DkRPx1cpG7
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250093
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gZnVydGhlciByZWZsZWN0aW9uIEkgcmVhbGl6ZSBJIGRpZCBub3QgdW5kZXJzdGFuZCBjb3Jy
ZWN0bHkgdGhlIHVzZXIva2VybmVsIEFQSSBpc3N1ZSBjb3JyZWN0bHkuIEkgd2FzIGFzc3VtaW5n
IHRoYXQgdGhlIHVzZXIgYXBwbGljYXRpb24gc2hvdWxkIGNvbnRpbnVlIHRvIHJ1biBidXQgdGhh
dCB3ZSBjb3VsZCByZXF1aXJlIHJlLWNvbXBpbGluZyByZG1hLWNvcmUuIElmIHdlIHJlcXVpcmUg
dGhhdCBvbGQgcmRtYS1jb3JlIGJpbmFyaWVzIHJ1biBvbiBuZXdlciBrZXJuZWxzIHRoZW4gdGhl
IDQwIGJ5dGVzIGlzIGFuIGlzc3VlLiBJIGFsd2F5cyByZWNvbXBpbGVkIHJkbWEtY29yZSBhbmQg
ZGlkbid0IHRlc3QgcnVubmluZyB3aXRoIG9sZCBiaW5hcmllcy4gRm9ydHVuYXRlbHkgdGhlcmUg
aXMgYW4gZWFzeSBmaXguIFRoZSBmbGFncyBmaWVsZCBpbiB0aGUgZWFybGllciByeGUgbXcgdmVy
c2lvbiBoYWQgb25lIGJpdCBpbiBpdCBidXQgdGhlIG5ldyB2ZXJzaW9uIGRyb3BwZWQgdGhhdCBh
bmQgSSBuZXZlciB3ZW50IGJhY2sgYW5kIHJlbW92ZWQgdGhlIGZpZWxkLiBEcm9wcGluZyB0aGUg
ZmxhZ3MgZmllbGQgZG9lc24ndCBicmVhayBhbnl0aGluZyBidXQgbGV0cyB0aGUgbXcgc3RydWN0
IGZpdCBpbiB0aGUgd3IgdW5pb24gd2l0aG91dCBleHRlbmRpbmcgaXQuDQoNCkkgd2lsbCBmaXgs
IHJldGVzdCBhbmQgcmVzdWJtaXQuDQoNCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+IA0KU2VudDogVHVlc2Rh
eSwgTWF5IDI1LCAyMDIxIDEwOjAwIEFNDQpUbzogUGVhcnNvbiwgUm9iZXJ0IEIgPHJvYmVydC5w
ZWFyc29uMkBocGUuY29tPg0KQ2M6IFBlYXJzb24sIFJvYmVydCBCIDxycGVhcnNvbmhwZUBnbWFp
bC5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgUkRNQSBtYWlsaW5nIGxp
c3QgPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSCBmb3It
bmV4dCB2NyAwMC8xMF0gUkRNQS9yeGU6IEltcGxlbWVudCBtZW1vcnkgd2luZG93cw0KDQpPbiBU
dWUsIE1heSAyNSwgMjAyMSBhdCAxOjI3IFBNIFBlYXJzb24sIFJvYmVydCBCIDxyb2JlcnQucGVh
cnNvbjJAaHBlLmNvbT4gd3JvdGU6DQo+DQo+IFRoZXJlJ3Mgbm90aGluZyB0byBjaGFuZ2UuIFRo
ZXJlIGlzIG5vIHByb2JsZW0uIEp1c3QgZ2V0IHRoZSBoZWFkZXJzIHN5bmMnZWQuDQo+IElmIHRo
YXQgZG9lc24ndCBmaXggeW91ciBpc3N1ZXMgeW91ciB0cmVlIGhhcyBnb3R0ZW4gY29ycnVwdGVk
IHNvbWVob3cuIEJ1dCwgSSBkb24ndCB0aGluayB0aGF0IGlzIHRoZSBpc3N1ZS4gSSBzYXcgdGhl
IHNhbWUgdHlwZSBvZiBlcnJvcnMgeW91IHJlcG9ydGVkIHdoZW4gcmRtYV9jb3JlIGlzIGJ1aWx0
IHdpdGggdGhlIG9sZCBoZWFkZXIgZmlsZS4gVGhhdCBkZWZpbml0ZWx5IHdpbGwgY2F1c2UgcHJv
YmxlbXMuIFRoZSBzaXplIG9mIHRoZSBzZW5kIHF1ZXVlIFdRRXMgY2hhbmdlZCBiZWNhdXNlIG5l
dyBmaWVsZHMgd2VyZSBhZGRlZC4gVGhlbiB1c2VyIHNwYWNlIGFuZCB0aGUga2VybmVsIGltbWVk
aWF0ZWx5IGdldCBvZmYgZnJvbSBlYWNoIG90aGVyLg0KPg0KPiBHb29kIGx1Y2ssDQoNCkFib3V0
IHJkbWEtY29yZSwgdGhlIHJvb3QgY2F1c2UgaXMgY2xlYXIuIEkgYW0gZmluZSB3aXRoIHRoaXMg
cGF0Y2ggc2VyaWVzLg0KVGhhbmtzLCBCb2IuDQoNClpodSBZYW5qdW4NCg0KPg0KPiBCb2INCj4N
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmh1IFlhbmp1biA8enlqenlq
MjAwMEBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNSwgMjAyMSAxMjoxOCBBTQ0K
PiBUbzogUGVhcnNvbiwgUm9iZXJ0IEIgPHJvYmVydC5wZWFyc29uMkBocGUuY29tPg0KPiBDYzog
UGVhcnNvbiwgUm9iZXJ0IEIgPHJwZWFyc29uaHBlQGdtYWlsLmNvbT47IEphc29uIEd1bnRob3Jw
ZSANCj4gPGpnZ0BudmlkaWEuY29tPjsgUkRNQSBtYWlsaW5nIGxpc3QgPGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGZvci1uZXh0IHY3IDAwLzEwXSBS
RE1BL3J4ZTogSW1wbGVtZW50IG1lbW9yeSANCj4gd2luZG93cw0KPg0KPiBPbiBUdWUsIE1heSAy
NSwgMjAyMSBhdCAxMjo1NyBQTSBQZWFyc29uLCBSb2JlcnQgQiA8cm9iZXJ0LnBlYXJzb24yQGhw
ZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gWmh1LA0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIGFib3V0
IHRoZSBzY3JpcHQuIFN0YXJ0aW5nIGZyb20gd2hlcmUgeW91IHdlcmUgSSBjb3BpZWQgDQo+ID4g
PExJTlVYPi9pbmNsdWRlL3VhcGkvcmRtYS9yZG1hX3VzZXJfcnhlLmggdG8gDQo+ID4gPFJETUFf
Q09SRT4va2VybmVsLWhlYWRlcnMvcmRtYS9yZG1hX3VzZXJfcnhlLmguIEFmdGVyIHJ1bm5pbmcg
dGhlIA0KPiA+IHNjcmlwdCB5b3Ugc2hvdWxkIGJlIGFibGUgdG8ganVzdCBkaWZmIHRoZXNlIHR3
byBmaWxlcyB0byBtYWtlIHN1cmUgDQo+ID4gdGhleSBhcmUgdGhlIHNhbWUuIElmIHRoZXkgYXJl
bid0IGNvcHkgdGhlIGhlYWRlciBmaWxlIG92ZXIuIEFmdGVyIA0KPiA+IHRoZSBzaGlmdCB0byA1
LjEzDQo+ID4gcmMxKyBJIHJlLXB1bGxlZCBib3RoIHRyZWVzIGFuZCBhcHBsaWVkIHRoZSBrZXJu
ZWwgcGF0Y2hlcyBhbmQgdGhlbiANCj4gPiByYzErIGJ1aWx0IGV2ZXJ5dGhpbmcuIFRoZSBweXRo
b24gdGVzdCBjYXNlcyBsb29rIGxpa2UNCj4gPg0KPiA+IC4uLi4uLi4uLi4uLi5zc3Nzc3Nzc3Mu
Li4uLi4uLi4uLi4uc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzDQo+ID4gc3MgDQo+
ID4gc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzLnNzc3Nzc3Nzc3Nzc3Nzc3Nz
c3Nzc3Nzc3NzLi4uLnMNCj4gPiBzcyBzLi4uLi4uLi4uLi4uLnMuLi4uLnMuLi4uLi4uc3Nzc3Nz
c3Nzcy4uc3MNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tDQo+ID4gUmFuIDE4MiB0ZXN0cyBpbiAw
LjM4MHMNCj4NCj4gVGhhbmtzLiBQbGVhc2Ugc3VibWl0IGEgbmV3IHBhdGNoIGZvciB0aGlzIHBy
b2JsZW0uDQo+DQo+ID4NCj4gPiBPSyAoc2tpcHBlZD0xMjQpDQo+ID4NCj4gPiBUaGVyZSBhcmUg
YSBsb3Qgb2Ygc2tpcHMgYnV0IG5vIGVycm9ycy4gVGhlIHNraXBzIGFyZSBmcm9tIGZlYXR1cmVz
IHRoYXQgcnhlIGRvZXMgbm90IHN1cHBvcnQuDQo+ID4NCj4gPiBBZGRpbmcgdGhlIE1XIHJkbWFf
Y29yZSBwYXRjaCBwaWNrcyB1cCBhIHNtYWxsIG51bWJlciBvZiBhZGRpdGlvbmFsIHRlc3QgY2Fz
ZXMgaW52b2x2aW5nIG1lbW9yeSB3aW5kb3dzLg0KPg0KPiBUaGFua3MgYSBsb3QuIExvb2sgZm9y
d2FyZCB0byB0aGVzZSBhZGRpdGlvbmFsIHRlc3QgY2FzZXMgaW52b2x2aW5nIG1lbW9yeSB3aW5k
b3dzLg0KPg0KPiBaaHUgWWFuanVuDQo+DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4gQm9i
DQo+ID4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFpodSBZYW5q
dW4gPHp5anp5ajIwMDBAZ21haWwuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDI0LCAyMDIx
IDk6MDkgUE0NCj4gPiBUbzogUGVhcnNvbiwgUm9iZXJ0IEIgPHJwZWFyc29uaHBlQGdtYWlsLmNv
bT4NCj4gPiBDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IFJETUEgbWFpbGlu
ZyBsaXN0IA0KPiA+IDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz4NCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIGZvci1uZXh0IHY3IDAwLzEwXSBSRE1BL3J4ZTogSW1wbGVtZW50IG1lbW9yeSAN
Cj4gPiB3aW5kb3dzDQo+ID4NCj4gPiBPbiBUdWUsIE1heSAyNSwgMjAyMSBhdCAxMjowNCBBTSBQ
ZWFyc29uLCBSb2JlcnQgQiA8cnBlYXJzb25ocGVAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+DQo+
ID4gPiBPbiA1LzIzLzIwMjEgMTA6MTQgUE0sIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4gPiA+IE9u
IFNhdCwgTWF5IDIyLCAyMDIxIGF0IDQ6MTkgQU0gQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdt
YWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+PiBUaGlzIHNlcmllcyBvZiBwYXRjaGVzIGltcGxlbWVu
dCBtZW1vcnkgd2luZG93cyBmb3IgdGhlIA0KPiA+ID4gPj4gcmRtYV9yeGUgZHJpdmVyLiBUaGlz
IGlzIGEgc2hvcnRlciByZWltcGxlbWVudGF0aW9uIG9mIGFuIGVhcmxpZXIgcGF0Y2ggc2V0Lg0K
PiA+ID4gPj4gVGhleSBhcHBseSB0byBhbmQgZGVwZW5kIG9uIHRoZSBjdXJyZW50IGZvci1uZXh0
IGxpbnV4IHJkbWEgdHJlZS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBCb2Ig
UGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPiA+ID4gPj4gLS0tDQo+ID4gPiA+PiB2
NzoNCj4gPiA+ID4+ICAgIEZpeGVkIGEgZHVwbGljYXRlIElOSVRfUkRNQV9PQkpfU0laRShpYl9t
dywgLi4uKSBpbiByeGVfdmVyYnMuYy4NCj4gPiA+ID4gV2l0aCB0aGlzIHBhdGNoIHNlcmllcywg
dGhlcmUgYXJlIGFib3V0IDE3IGVycm9ycyBhbmQgMSBmYWlsdXJlIGluIHJkbWEtY29yZS4NCj4g
PiA+DQo+ID4gPiBaaHUsDQo+ID4gPg0KPiA+ID4gWW91IGhhdmUgdG8gc3luYyB0aGUga2VybmVs
LWhlYWRlciBmaWxlIHdpdGggdGhlIGtlcm5lbC4NCj4gPg0KPiA+IEZyb20gdGhlIGxpbmsNCj4g
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvdA0KPiA+IHJlDQo+ID4gZS9Eb2N1bWVudGF0aW9uL2tidWlsZC9oZWFkZXJz
X2luc3RhbGwucnN0P2g9djUuMTMtcmMzDQo+ID4geW91IG1lYW4gIm1ha2UgaGVhZGVyc19pbnN0
YWxsIj8NCj4gPg0KPiA+IEluIGZhY3QsIGFmdGVyICJtYWtlIGhlYWRlcnNfaW5zdGFsbCIsIHRo
ZXNlIHBhdGNoZXMgc3RpbGwgY2F1c2UgZXJyb3JzIGFuZCBmYWlsdXJlcyBpbiByZG1hLWNvcmUu
DQo+ID4NCj4gPiBJIHdpbGwgZGVsdmUgaW50byB0aGVzZSBlcnJvcnMgb2YgcmRtYS1jb3JlLiBU
b28gbWFueSBlcnJvcnMuDQo+ID4NCj4gPiBaaHUgWWFuanVuDQo+ID4NCj4gPiA+DQo+ID4gPiBC
b2INCj4gPiA+DQo+ID4gPiA+ICINCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAtLQ0KPiA+ID4g
PiAtLQ0KPiA+ID4gPiAtLQ0KPiA+ID4gPiBSYW4gMTgzIHRlc3RzIGluIDIuMTMwcw0KPiA+ID4g
Pg0KPiA+ID4gPiBGQUlMRUQgKGZhaWx1cmVzPTEsIGVycm9ycz0xNywgc2tpcHBlZD0xMjQpICIN
Cj4gPiA+ID4NCj4gPiA+ID4gQWZ0ZXIgdGhlc2UgcGF0Y2hlcywgbm90IHN1cmUgaWYgcnhlIGNh
biBjb21tdW5pY2F0ZSB3aXRoIHRoZSANCj4gPiA+ID4gcGh5c2ljYWwgTklDcyBjb3JyZWN0bHkg
YmVjYXVzZSBvZiB0aGUgYWJvdmUgZXJyb3JzIGFuZCBmYWlsdXJlLg0KPiA+ID4gPg0KPiA+ID4g
PiBaaHUgWWFuanVuDQo+ID4gPiA+DQo+ID4gPiA+PiB2NjoNCj4gPiA+ID4+ICAgIEFkZGVkIHJ4
ZV8gcHJlZml4IHRvIHN1YnJvdXRpbmUgbmFtZXMgaW4gbGluZXMgdGhhdCBjaGFuZ2VkDQo+ID4g
PiA+PiAgICBmcm9tIFpodSdzIHJldmlldyBvZiB2NS4NCj4gPiA+ID4+IHY1Og0KPiA+ID4gPj4g
ICAgRml4ZWQgYSB0eXBvIGluIDEwdGggcGF0Y2guDQo+ID4gPiA+PiB2NDoNCj4gPiA+ID4+ICAg
IEFkZGVkIGEgMTB0aCBwYXRjaCB0byBjaGVjayB3aGVuIE1ScyBoYXZlIGJvdW5kIE1Xcw0KPiA+
ID4gPj4gICAgYW5kIGRpc2FsbG93IGRlcmVnIGFuZCBpbnZhbGlkYXRlIG9wZXJhdGlvbnMuDQo+
ID4gPiA+PiB2MzoNCj4gPiA+ID4+ICAgIGNsZWFuZWQgdXAgdm9pZCByZXR1cm4gYW5kIGxvd2Vy
IGNhc2UgZW51bXMgZnJvbQ0KPiA+ID4gPj4gICAgWmh1J3MgcmV2aWV3Lg0KPiA+ID4gPj4gdjI6
DQo+ID4gPiA+PiAgICBjbGVhbmVkIHVwIGFuIGlzc3VlIGluIHJkbWFfdXNlcl9yeGUuaA0KPiA+
ID4gPj4gICAgY2xlYW5lZCB1cCBhIGNvbGxpc2lvbiBpbiByeGVfcmVzcC5jDQo+ID4gPiA+Pg0K
PiA+ID4gPj4gQm9iIFBlYXJzb24gKDkpOg0KPiA+ID4gPj4gICAgUkRNQS9yeGU6IEFkZCBiaW5k
IE1XIGZpZWxkcyB0byByeGVfc2VuZF93cg0KPiA+ID4gPj4gICAgUkRNQS9yeGU6IFJldHVybiBl
cnJvcnMgZm9yIGFkZCBpbmRleCBhbmQga2V5DQo+ID4gPiA+PiAgICBSRE1BL3J4ZTogRW5hYmxl
IE1XIG9iamVjdCBwb29sDQo+ID4gPiA+PiAgICBSRE1BL3J4ZTogQWRkIGliX2FsbG9jX213IGFu
ZCBpYl9kZWFsbG9jX213IHZlcmJzDQo+ID4gPiA+PiAgICBSRE1BL3J4ZTogUmVwbGFjZSBXUl9S
RUdfTUFTSyBieSBXUl9MT0NBTF9PUF9NQVNLDQo+ID4gPiA+PiAgICBSRE1BL3J4ZTogTW92ZSBs
b2NhbCBvcHMgdG8gc3Vicm91dGluZQ0KPiA+ID4gPj4gICAgUkRNQS9yeGU6IEFkZCBzdXBwb3J0
IGZvciBiaW5kIE1XIHdvcmsgcmVxdWVzdHMNCj4gPiA+ID4+ICAgIFJETUEvcnhlOiBJbXBsZW1l
bnQgaW52YWxpZGF0ZSBNVyBvcGVyYXRpb25zDQo+ID4gPiA+PiAgICBSRE1BL3J4ZTogSW1wbGVt
ZW50IG1lbW9yeSBhY2Nlc3MgdGhyb3VnaCBNV3MNCj4gPiA+ID4+DQo+ID4gPiA+PiAgIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvTWFrZWZpbGUgICAgIHwgICAxICsNCj4gPiA+ID4+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyAgICAgICAgfCAgIDEgKw0KPiA+ID4gPj4gICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9jb21wLmMgICB8ICAgMSArDQo+ID4gPiA+PiAg
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oICAgIHwgIDI5ICstDQo+ID4gPiA+
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgICAgIHwgIDc5ICsrKystLQ0K
PiA+ID4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tdy5jICAgICB8IDM1NiAr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX29wY29kZS5jIHwgIDExICstDQo+ID4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX29wY29kZS5oIHwgICAzICstDQo+ID4gPiA+PiAgIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3BhcmFtLmggIHwgIDE5ICstDQo+ID4gPiA+PiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYyAgIHwgIDQ1ICsrLS0NCj4gPiA+ID4+ICAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcG9vbC5oICAgfCAgIDggKy0NCj4gPiA+ID4+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgICAgfCAxMDIgKysrKy0tLQ0KPiA+ID4g
Pj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgICB8IDExMCArKysrKy0t
LQ0KPiA+ID4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jICB8ICAg
NSArLQ0KPiA+ID4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oICB8
ICAzOCArKy0NCj4gPiA+ID4+ICAgaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91c2VyX3J4ZS5oICAg
ICAgfCAgMzQgKystDQo+ID4gPiA+PiAgIDE2IGZpbGVzIGNoYW5nZWQsIDY5MSBpbnNlcnRpb25z
KCspLCAxNTEgZGVsZXRpb25zKC0pDQo+ID4gPiA+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tdy5jDQo+ID4gPiA+PiAtLQ0KPiA+ID4gPj4gMi4y
Ny4wDQo+ID4gPiA+Pg0K
