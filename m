Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112864980EE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 14:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiAXNU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 08:20:59 -0500
Received: from mail-bn1nam07on2098.outbound.protection.outlook.com ([40.107.212.98]:62080
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242280AbiAXNU7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jan 2022 08:20:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3RXqBxsGNsFUFZ6VucjnemQ0H4Bt/994rsMrS8r7QiPv+S8a9WP/9CEfwIA/h7d6QVzbWbb5H5Yp52sOCmWXMgcWSXBtz6dCEk2e5Xq4OLlARw4xlg1g+F7V2VBHrPiUGc8bI1o2TbjAshimtTmj0LhP3/kPf/M4LEVQzEri5kFL4UunnsU5rPLajXV94Yb9K1OVQcGhtpuIbZ3HlTOQnu8ru/Nromj88+4ddUIAvYTAuRHlH9149znS4oH6Y9FDMfy0WNa08VRLBK5P7sYuMrMQxtN7c9XLglMHYLCLct2/Dvl15j2NWWHmhbKF5B+QP4Lwm02Sgw35jmpUHeptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qsjw0TE5VNjiuwHWLXr6n3vQpUC+3Tpy0Z2wwOCzEos=;
 b=ZtcSQdzK7KapQv1tcUcoZxizY2ALdwmb/vGykkDeXAo2pR/SKldJQfr9sfp8j0GOYMZ9nqjg6uMkZ8sjm6s8Jn3iURf0HlS1z3LsC07XpPWEqt79CFUE04juGlyv3mS3idfebojUiJxojjiSzCsyXNMI+neFOvvuvcYOmLtpX5bKLyPbnTvHzNlRDHPVa9aUJg5GTmqkcTJPHTkP7vnCzBebSaMPkSpSsw1SQAVWi3CwiPnaz+Apz20B3tYx5afCa76v1o9Iu4DmtN5VusA854q6brp+WvtGru7+p3+s08Qu1Eh2n0YCAI07+e2fenQzLbXM5DznZciBbdMgLIkKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsjw0TE5VNjiuwHWLXr6n3vQpUC+3Tpy0Z2wwOCzEos=;
 b=GtSbnD/6ahSzIUCpscuts4HtoJ0Kc94NPnvKFwoloX1+orw1LHKIks+UBLCDD5RzQC1iHaYGxKoxHy8QB4RObMy7qO0NLUovkkHP7jItykdhgrE5mFqDeLk+7P4/Nob1E9Z9Kvy7TlNLcZXOjdkxCIf5m+m4aIch0llkClvDXSwyjbyb0zx3Hut2DJNAFWYULXMsLLFC0rktYLaQOqt1O4/W7EFx8nQFdR/NWNhrDekKgNgoIoVPhlgBnyX7nJrMyNjo0GR2leceydcDxYJAof802WNJJ7Kya2xTCCSIoJDDXStoXL+/uii38lMl1wH4uvw3pLeooZ5Z10PCzd6Aag==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 SA1PR01MB6592.prod.exchangelabs.com (2603:10b6:806:185::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Mon, 24 Jan 2022 13:20:56 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 13:20:56 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Thread-Topic: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Thread-Index: AQHYDRbi6ecqHdAHN0+hFl+W9aYJ4Kxwb3QAgAGxUwCAAAJTgIAAAseAgAAH/YA=
Date:   Mon, 24 Jan 2022 13:20:56 +0000
Message-ID: <CH0PR01MB7153A251BF2D1F2C4A8ACFDAF25E9@CH0PR01MB7153.prod.exchangelabs.com>
References: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
 <Ye0vPMAF6NdF0pMu@unreal> <E3A123CC-3C34-4EE9-BF6E-3F9FEF04A939@oracle.com>
 <Ye6cry944qSVHi6z@unreal> <4579CC13-F537-4F54-887B-B9CFB570DE43@oracle.com>
In-Reply-To: <4579CC13-F537-4F54-887B-B9CFB570DE43@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 564a257e-b14f-4a6c-f5a6-08d9df3c5af7
x-ms-traffictypediagnostic: SA1PR01MB6592:EE_
x-microsoft-antispam-prvs: <SA1PR01MB6592B542FC98B9085B6BC4D3F25E9@SA1PR01MB6592.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQv8gUQ10E6tMBmtHS11u0mpGXaX2bsgMKDKgAAokWj6gPn4JJxqnbt3oHQ9nvcgd8BOnlA+WX14PpniufDrKcTUx/JWrdo3H1NTK+sKBaauA7sHNNCx8tuo9KnzsVCTpGH1nTGxQxZ8Zk3z82CVLS6QcksHxZ7VjZsM1sVB0/3eOtp0eI+0xirm3Wnad/UGokhqUAthmy7E6Yte8Zz2k2KNfiGf4EnkjSRRkj4YtE5TUMuR/XSGsgfUmJ4sExKCK85+So3nZJxsYTSfPsKT4WkJ8FTjVboCYa8MXYkWp6psZE1paek8d5j3AltVnt7nUBylNRHQeXoX9DzaeOg7DexjMlBwNBI9Ow/0a3Ih7OFN3vuHfHWJVQMxDsLmUFmfegdXOQyo+03tTa7KOnhFGXpq9ilh37EsVNWDM3ATQNej0LSiVIv3xeTl/3VXCnTuEeg3VUmbQvxt0w2gVqP95PZfi8SA/l5R4fmlscEz/s3iflctaqsfbQE1+UPZ3eQUBZ8jk6OALP4aupcJuA39UP1WEED2d3e67i8EfhH5HPNY3WznSMBwIOkBDaNQE5ea7LoI6EmYHTYuMSB445ELqpHxR4OPPxgVA81gtfZUiHG5+ydLJ1Gmr4Qkx8tv5P4RceMQjg658NMq8N4N+6wAxwSAUoBslx8a8iATQEYK723UC/gLebspaVilw1GrC/Fb/m9Gdr2mZXo/c6jLiV/goA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(346002)(396003)(376002)(366004)(4326008)(53546011)(26005)(186003)(71200400001)(8936002)(122000001)(33656002)(110136005)(66476007)(83380400001)(86362001)(6506007)(9686003)(54906003)(76116006)(15650500001)(52536014)(2906002)(8676002)(508600001)(5660300002)(66946007)(38100700002)(64756008)(66446008)(66556008)(55016003)(38070700005)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTFvdTg1YXloamdYM1ZkRmhIaGZsdVFFdThKZEpCQzk2WjgzSUY4WHJBWEk3?=
 =?utf-8?B?WVJ1YWFuSXljY2wwdzNscDZzY3k3c001Q09wK0lITVc2cDB2SWhyaUdDUUpz?=
 =?utf-8?B?UU1UY1lVbFVSbS9oakdFRWVLWGppazFoM1NFYWQ1bDdBYks0NDJ0dVdZR1pM?=
 =?utf-8?B?R3VmS21PVExlZ2VER3VSdk5FMjZtNi9IdHB6aEYwM28wamlJWk5WdjRFNWlY?=
 =?utf-8?B?ZFRXY3pDRkNyRlZVUU1KUUhhTys2aTJ6VEl3WVBiTnY2WFM3UjZKcTNTQ091?=
 =?utf-8?B?d1JKZTg4dS9xdW9jaFlWZ3VzQjRvNlgzcldWNzg4TytmMzBEbm5mMXpTS3dB?=
 =?utf-8?B?VWV1WEhyZXlIRmVUT3NPQW5TSDh4TWRlcVBWdTh5akxGZ3ZWWmdOc0xtbjhI?=
 =?utf-8?B?T1hXeDVoR1ZCMlh4cXg5YzhHSFkvam1CK2FRbXBLdExJTmtLZTg4UjRkeXJD?=
 =?utf-8?B?WW8xcHMvMjA0aG5heityR1dSMUgzRHkwZDluV0NKTEl5UWZBL0tTQ29LR2Rq?=
 =?utf-8?B?M2lDMExqeERTTkU4bFYrak1CVy9KU29LbzVEU3lmcmhnMDVDeWd0c3JsOXFw?=
 =?utf-8?B?djVsNVR3RjR6eDFNMzRRRjFHemcvRkNLQjFML3B2a0xUZkIwUzRmK21LRzUw?=
 =?utf-8?B?czgya0lHOXpxTXBjL0ZYWUZqc0NRcHIxUDlKVTJBdGttQkpCek9ZdUdBUDFO?=
 =?utf-8?B?NitYZTU3NisyQVRidlRMM2ZzcHBQbkJ2QTk2Y2hvdVh4eHpscEJlb3ZMU0Vi?=
 =?utf-8?B?ekFReWNnYUZwSVpCa2gyVlZvRm5wWjlReldsNEZDelhRbHlnbkR4alYvek9J?=
 =?utf-8?B?VDMrVWNEMjh5dDc0R0x3MkdGaEQ1OGY5L1FjakpKMzFUT1dWcnlDODhYcU1W?=
 =?utf-8?B?S3Nwb2crRytoTWxmcXA1bWI4cGNlTWtzYXZRcThWakxEUlhxZks5YnM3cXVJ?=
 =?utf-8?B?eWxYVjcvNVdVWVBCTk1pT2IycWNHV3BQTDRWMHB3MmtMalU0ZUpQQ1Ezdk9J?=
 =?utf-8?B?YjZydVVNTS9YZkE4bU5rNGdXOG1CcDh1WC8yYVZhc1A4N3dDN2lBdVdLSHYr?=
 =?utf-8?B?cEhXUm0vazFoOURscGFpVytmTkxMWCtVdCtQN2IvOEZqbFQxQmJaVy9lR3ky?=
 =?utf-8?B?djl2TWliSTMrS1IzQUFoakc3STZsNnVXVHljMExhNU42SVFnUFdNazF0TENs?=
 =?utf-8?B?d3Flb3ZWUzZpUHdlUmtMaWtaZ2VVa2VEdVBmaWNBQ1hmaFZyRUszSlpFdDU5?=
 =?utf-8?B?dWRKWTZURS90YStpcXUvRmxwbEkwc0hFWmMzWERJZDZKMXMwOG5FTVh5VmJN?=
 =?utf-8?B?ZnVRK2RSeE5WdURwbHFIYUhLMFJmUHhwSjl2bmdBMjRXLzhMREpIOGF3SCs3?=
 =?utf-8?B?WnNRR1N1ZXBpS1JleDJDd0N5V0JQVFRWNGxHaFdlRmpsUXA5dzNiaFpBMjFF?=
 =?utf-8?B?aE1BN2svaThSaCtQUGZVT09mZ3kvYXVNTWp1bUI5RmN3MVVSZFpmTXRueGhs?=
 =?utf-8?B?QS90c1BOenFqaWZpUE1qVGFFdkF5SGxFUE1mK0ptWTFoaENkNzFnWWZLOGRC?=
 =?utf-8?B?Wk9KNkRLOG00MnI2YmxMdGZjbGZqZFA1M0hqZUMxa0FKQ3F0YW9NOTBzVGJz?=
 =?utf-8?B?OUJVOEFham9NU2pWc24yeEJCWEpqaitJbFllWEl5N1VkaDNaRzBneGg4Qi9V?=
 =?utf-8?B?WGpld05DMW9uc3dVWDl4YThaMURweWw5KzB3bWlxZmdkTGp0bHdKRTh3RXIz?=
 =?utf-8?B?d1U5MnRtZUJtaXoyTmZBdlBiWnlQTVZteC9rVXAxTVI0bis5cE1BcHBWQk91?=
 =?utf-8?B?b2U5azdxNHgyNkt3eTh0TUVMQWxRWnpPSlNRcytXTEYrRHg1SE1uS0RSbHl4?=
 =?utf-8?B?bWRjMjZLRmEvSGxYSGpKWTNnN09IKzJQdEppY1QzMkI2QzRlUVcxcW1iNkpD?=
 =?utf-8?B?QWJmaXU4VG1mc2FndSs0eTVObXo3ajNma1NCbng1c293MEt5N1IrTStXRVlW?=
 =?utf-8?B?QkhqVWZHeUMvVHQ5VDZYakt5MGJ3UE9WeVJhY2NWUjNQcDFaRmRGditSVzZk?=
 =?utf-8?B?Y1h0blFpMlZHOHRvUWZ3YkVTa3pRT3dmZCttMzl0dCtsZERoeTdEMVJDZkVP?=
 =?utf-8?B?VTNsNVNqbjlFQWROU21VNDU2UDcvZ243L2hueGpQV1U0V055MnZlMTRrMkFH?=
 =?utf-8?B?aDNVQ0JkOXhwMWZ4MUtyaTVXRU5Xb2pMdEFIZGd1dCtaSmJMbVlSN3dVcVVL?=
 =?utf-8?B?MmIxQXl6OS9nVnR6M2Rabk40alB3RGRNbk8xNThkb3E4Qmh5b2FVamlSclp5?=
 =?utf-8?Q?xxH/jHQDbJBPWzn/NF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564a257e-b14f-4a6c-f5a6-08d9df3c5af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 13:20:56.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+jRJQCqIsEZFxbthRDbNE8Z8TYe2ZClQopdc3VkIdDOAAb21dXF6kfIbDiIj9BiEZYPA8KAQEd4YKM0c30EQy4+nvodsD7k8m9ghv4IYvVqc6m/actfiV+G6oGXc6VJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6592
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPiBTZW50OiBN
b25kYXksIEphbnVhcnkgMjQsIDIwMjIgNzo0NCBBTQ0KPiBUbzogTGVvbiBSb21hbm92c2t5IDxs
ZW9uQGtlcm5lbC5vcmc+DQo+IENjOiBNYXJjaW5pc3p5biwgTWlrZSA8bWlrZS5tYXJjaW5pc3p5
bkBjb3JuZWxpc25ldHdvcmtzLmNvbT47DQo+IGpnZ0B6aWVwZS5jYTsgT0ZFRCBtYWlsaW5nIGxp
c3QgPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGZv
ci1yY10gSUIvcmRtYXZ0OiBWYWxpZGF0ZSByZW1vdGVfYWRkciBkdXJpbmcNCj4gbG9vcGJhY2sg
YXRvbWljIHRlc3RzDQo+ID4gQW5kIGlzIElCVEEgcmVzdHJpY3Rpb24gYXBwbGljYWJsZSB0byBo
ZmkxPw0KPiANCj4gRm9yIGhmaTEsIEkgZG8gbm90IGtub3cuIEJ1dCB0aGlzIGZpeCB3YXMgaW4g
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3JkbWF2dCwgZm9yDQo+IHdoaWNoIHRoZSBmaXJzdCBjb21t
aXQgbWVzc2FnZSBzdGF0ZXM6DQo+IA0KPiAgVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHRoZSBiYXNp
Y3MgZm9yIGEgbmV3IG1vZHVsZSBjYWxsZWQgcmRtYV92dC4gVGhpcyBuZXcNCj4gICAgIGRyaXZl
ciBpcyBhIHNvZnR3YXJlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBJbmZpbmlCYW5kIHZlcmJzLi4u
DQo+IA0KPiANCj4gTW9yZSBpbXBvcnRhbnRseSwgdGhlIGNoZWNrIHdlIGRpc2N1c3MgaXMgbm90
IGFib3V0IGJlaW5nIHBhZ2UtYWxpZ25lZCwgYnV0DQo+IGFib3V0IGJlaW5nIG5hdHVyYWxseSBh
bGlnbmVkLCByaWdodD8NCj4gDQoNCkhhcmR3YXJlIHN1cHBvcnRlZCBieSByZGFtdnQgc3RyaXZl
cyB0byBiZSAxMDAlIGNvbXBhdGlibGUgd2l0aCB0aGUgdmVyYnMgQVBJLg0KDQpBbmQgeWVzLCB0
aGUgbmF0dXJhbCBhbGlnbm1lbnQgaXMgdGhlIG9iamVjdGl2ZSBmb3IgdGhlIHRlc3QuDQoNCkFj
Y29yZGluZyB0byB0aGUgSUIgU3BlYyAoVjEtUmVsMS4yLjEgc2VjdGlvbiA5LjQuNSBBVE9NSUMg
T1BFUkFUSU9OUyk6DQogICAgICAgICJUaGUgdmlydHVhbCBhZGRyZXNzIGluIHRoZSBBVE9NSUMg
Q29tbWFuZCBSZXF1ZXN0IHBhY2tldCBzaGFsbA0KICAgICAgICBiZSBuYXR1cmFsbHkgYWxpZ25l
ZCB0byBhbiA4IGJ5dGUgYm91bmRhcnkuIFRoZSByZXNwb25kaW5nIENBDQogICAgICAgIGNoZWNr
cyB0aGlzIGFuZCByZXR1cm5zIGFuIEludmFsaWQgUmVxdWVzdCBOQUsgaWYgaXQgaXMgbm90IG5h
dHVyYWxseQ0KICAgICAgICBhbGlnbmVkLiINCg0KVGhlIHJlY2VudCBhZGRpdGlvbnMgdG8gdGhl
IHJkbWEtY29yZSB0ZXN0IHN1aXRlIGNhdWdodCB0aGlzIGlzc3VlLg0KDQpUaGUgdGVzdCBpcyBj
b25zaXN0ZW50IHdpdGggaW5wdXQgcGFja2V0IHBhcnNpbmc6DQoNCiAgICAgICAgY2FzZSBPUChD
T01QQVJFX1NXQVApOg0KICAgICAgICBjYXNlIE9QKEZFVENIX0FERCk6IHsNCjxzbmlwPg0KICAg
ICAgICAgICAgICAgIGlmICh1bmxpa2VseSh2YWRkciAmIChzaXplb2YodTY0KSAtIDEpKSkNCiAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gbmFja19pbnZfdW5sY2s7DQo=
