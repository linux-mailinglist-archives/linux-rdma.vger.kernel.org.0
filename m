Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754703D7BF2
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhG0ROu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 13:14:50 -0400
Received: from mail-bn8nam11on2136.outbound.protection.outlook.com ([40.107.236.136]:52257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhG0ROt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 13:14:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQQatz2gwhn9MzpE8qb4Ab3jw9R+WRp3xnDacWpArxzW33F04juuYXJHmPFlVK8m4gEuLxHXfugyXlxSzkk4/ChVTrNip8OHXvCIBID8f9f3SffdNPoRXZLXd5i0IMVHunrjj8ZEHw2RBw7IcD2CRpaIRLCwGC86w6UVeY3xIzm1Fmq8L2FkRBtk23Tplnru3EQ//JiAdWYbcaUXwegRlLZS5oUm2PINA3wNqa2fPWXkv0iO8To6UFF6JUCXDMojzVn1iaKerbxfyXeNpnK/WexS4ukgrAWSU0f6FWI+sytl9/5GfS281liwVuU5lIIK40rogc3oagvuXRf8afcp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr0+h22C2lGzXujNOnoOP2HOC45pBwvtpE8NqEL4T1A=;
 b=g3IO/kChAXO5Ev27ddoJuxgsQfBGjxhIa3LEY4+MGcFlqJAWTpdY9SAPeSzoGc2D8UerYYqov9d6xLxtaRHeN7uKa5haIiZzKFc0ExqMtoSuO9EvGLuWwkNhC4lCxPZKRtGvhVPLqULGVa2lIRxL/O7s+m15I+8XJp4scS38ySbqFJyoVRJk+cNMexsObalD0UUaax7YIfSRJWEMX53aPQMCiQlhF+YJRQNFXs9MCW5wvRtym2AknrHemj7wnawNbj61ANBpPdwxIMNxAyoQW4a/ynKqxK62vUb3xdu4FDCGcrwSUXJpYifIdHJDLXgQEvWn7+x4cr5p34AKbDL6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr0+h22C2lGzXujNOnoOP2HOC45pBwvtpE8NqEL4T1A=;
 b=aIQCiDkc0J2OiZ3gL6XpssC7PIArm8NSBFmsC7PpXpEeZ3hV/VOVSmi8XBKHsw9hPp0z8FZ6Hbn/64L4OCoUSRHiB/ZLzRVs17+EtgeJ2kcKTUx0BWxJH40pv5gZYkevWiJw3BTxyBpyahs90dLxx48z/y9/qODfm+WNa1UXhQMZ8z5vHP/tvjw2jyx8+GskLysmqKyVXQmxT5dw0BO7dRDzozqa8qXP5cMiCMYIlEjiObJjJO/lkGxLc3HgUupRVfF+WSGLXrxppVEv2yXcqJwH2ARvzE8aF2GzNpxx/ESmCE53BFstIMUyTQPPc2Fpt0CPeqPTeKsqJtef7BtfAw==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25; Tue, 27 Jul 2021 17:14:46 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 17:14:46 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: RE: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAHw3HQ
Date:   Tue, 27 Jul 2021 17:14:46 +0000
Message-ID: <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ff2384c-455c-4e47-243e-08d9512208dd
x-ms-traffictypediagnostic: CH0PR01MB6873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB687392F3E9E0E71CAD7DE225F2E99@CH0PR01MB6873.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +N/B0Nj/ub9ZsAHmlMCCkdN3wMEH1joueb8R+X1/4tt41zAzrTrgcZsHVkwhVQ9XybNFF5ECzOPRLwXVr0giwmrrAiGHiuXOCIB22b/yA5qCu9Svv5WyHyf34gFijv/dhyT2sYgOKEsbZIGmZ5aKV8pFxolZgXqh0A0FmRuRTaqFGeU8w27zC8ZU8AxVDpK4Ogn8n7Qte5WxYhh7SFhhQFv1eA51G4DPlb7TVwV4VHunNSV9WeVQuqvaORdt/BVu4a35d63Qpa9Z7OOFW5JGDE2p5/f8zQjRjS5gRHAfpQOGS7ftQNA8vDlLrKyidlhrw29eL5xdaVXkzZlP/h9B74FTwY8cylSKq4VlUQ/kdO9kEcqvdrpL0axUyLr5CX/A7mhy3qq55ZC7PSIImfxBtUs1ltNZwA3iFApe6yh9XbVE+h/TYgtJG5kfpITqwld1yTQc7O7BsSAJNom2/Q1nEdJuqw4FY6U9Xmn/wtkMrmso45fNzXUmH0gR/4ZkzdFR0w6b61tNP3F1wOiAY8pFRXuj01YltyKY1AW90g1ujrtrcaP5OC6r6TDz4hDr74Va7/fiWd8Rhh2ZRKdY/rGvjplnTWRddqRvOJzYMp7Y44EyyyyOOOl95a47lXIdR9iUG98hZohZoHL7tL7ts74fG2qK3Xg5i1OJmiwVdtLsFufYLYgEukVeTzZyW+KvZ6ZyHUxgbv6TQtw0ERCznWiisg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39840400004)(346002)(136003)(376002)(8936002)(76116006)(6506007)(26005)(6916009)(52536014)(5660300002)(33656002)(2940100002)(186003)(64756008)(66446008)(38100700002)(66946007)(66556008)(66476007)(71200400001)(316002)(54906003)(55016002)(9686003)(86362001)(8676002)(478600001)(122000001)(7696005)(2906002)(4326008)(83380400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVlGRVhnQjhLdXIvSkh4TTdKTXRxcFQ5NzB1OEdSRnd4RTJmNHQrZFJMYk5E?=
 =?utf-8?B?T2JNbnZVL2loeHNvaFo2UXAyTTludWZpRnZxeFh1K29hYlprVzQyM2doZnFD?=
 =?utf-8?B?SlQwSUNLSFdJKzhsZkxjOHBJaG1PV043UEZpSEc0ajhwbzN0SFg5ZWlvN25s?=
 =?utf-8?B?WWI0c0M5a3RuQmV6NmRZK2ptb1BES1VDQlpKbUpjQ1ZwZTZwOFBwWkxvUGwz?=
 =?utf-8?B?b3pvNHlGMmo3VU5nQzhqR2JxcmlxcmRSSithMDl4N245R0xkN1JqZlcwejBu?=
 =?utf-8?B?SytuVXpUaTQzSmdwaVVVLy9Ya0ZldmdXbisyV1JzL0JaamFlRVlORkx5K0U3?=
 =?utf-8?B?N25KcWVpOUxpZ2FGOUpMOTBlY1hVNEl2UkxHaUpSMVUzdFlLNUxMUnpUODNX?=
 =?utf-8?B?T0JoL2JOR25oVXU0OXp4azdmOGRzWGFhWlpmbWtseUJyOThvYlBrNDdRbCtN?=
 =?utf-8?B?QXZqY2JleWh5UUFzZ25VY0NvWUd6UitKS1VWb2xiZURzbG9wb1dlR3pDWkQ5?=
 =?utf-8?B?V2U0MGlKOWdqOVk0ZGk0M1ZIaHZiQVUvR2orSHdHV3ZPU3RZc09hTDdEa1ht?=
 =?utf-8?B?eUY2c1NwdVRhTU5vSUpWeVZWZmJyL1VlMU9GM01GeXJFVTRTMGdoSHVLQU9s?=
 =?utf-8?B?dDVobWU3VWgyRGJ6S0J2TjdEbndoTWRvOVB4U0VrNTRNdGorODhjMzVKMzRS?=
 =?utf-8?B?UUpaQVJYQVV3aEFTZmhDTWVzdSsrbGtLNzg4cGRDUUhzT1hxZlhlOG1CWUFJ?=
 =?utf-8?B?Vnp1dHh3Z1cycnZUaXN0YlVPZW0xeFVCNGtPZElNMW1TNkV4NUlkV2VUNmZJ?=
 =?utf-8?B?WWtHQ1owdnQyMEVTS3pmN1Nrc2pQRnBCN2VhNXcvNGlpSUFrT1JxeVo0YURV?=
 =?utf-8?B?azNVTEtzUTAwb3I4RXdjN0Rwa1FIYi9HRXdwK0dacmJKNjhGamtjM2xZVElp?=
 =?utf-8?B?VHRVekVKV1EyWld0VmZhSjNnR2hNbEVqUzZIMG9MSFg1dzRwVU5ZU04wOEtZ?=
 =?utf-8?B?b1ZZWFdZbnVHQXZqSEZRdVZuVU5WejdXSUdDQW9kUE53dFFWOGhVUXJlUThZ?=
 =?utf-8?B?bi9UQy85TkVJeVZsTEFUNUFUZzNJOTZlQkM2UXVkVEJleGxIeW5kRHBJbXJm?=
 =?utf-8?B?eWZvczZlTURCZzhZNGVLV1JHTTJXZ2JEUG83WG9EUHA1OXFvc01qc2VWL01l?=
 =?utf-8?B?NVRDdjVwdXRvK3o1VEFBZnZXVUJqQWhGeThzWWh5ekpOUDhwd2xxd3k2RnNC?=
 =?utf-8?B?Vjh3WWRtVHNPTytud3JlU21OT2Zwc1Z1ZWhsOHBMbDFlWlJmOFVZSVBrNkVF?=
 =?utf-8?B?amVxbHJ3WWxCZUphdG1WVkJ5ckdRcGZrV1RSdjVWQjBUOFRvSEVmbUhwc0NN?=
 =?utf-8?B?bmx0azdnczhLTXNSSzJOSGppWmxTUUQvQ2srMTNsUmhPOXhLcDNSbDhVSDMx?=
 =?utf-8?B?SHlBQ3BBSjNVbGdiVU9TcmVsL21IbWVJUldsNVhOUXRhN3N5d3loOVBlT3ZT?=
 =?utf-8?B?QTErSmdvUkNvZ1NlelVhOVhmWDBVdWc2V1I2eDltb2FiWVpRako2Uldvb3Vi?=
 =?utf-8?B?TUp2b2FQZGRIMGM1elYzNU5YWjRheHBLRzVwUjdEb0FLZWM4bml1Wjd5dmNz?=
 =?utf-8?B?bmdjZStZNXFlejNTbTV3Nit2blRjcjFmMVZ6dnpiUWJvZnlIOTZyYXU0cEMw?=
 =?utf-8?B?ci9CcHFQZFpVK2RNQnpycEhVZ2hvRVdzVU5abklhZVcwbm9hTEhEQk8vZ05N?=
 =?utf-8?Q?q1UbL4qXsH/mr0mKIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff2384c-455c-4e47-243e-08d9512208dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:14:46.6873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDZGnBTQ8sP8o4msM0PjhqsYjyYlqBDO6g8zSLAqZXyreKmKLlHXWC29o8GJQMRu6CgsN6unTgqIP1o0PcV/B8QmZXvAh79pc1lz13m3Kyq8P/p5XpFtuelAmeSIIqJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6873
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Lg0KPiANCj4gSSBzdXNwZWN0IHRoZSBwYXRjaCBuZWVkcyB0byBiZSByZXZlcnRlZCBvciBORlMg
UkRNQSBuZWVkcyB0byBoYW5kbGUgdGhlDQo+IHRyYW5zaXRpb24gdG8gSU5JVD8NCj4gDQoNClJl
dmVydGluZyB0aGUgcGF0Y2ggYmVsb3cgd29ya3MuDQoNCj4gY29tbWl0IGRjNzBmN2MzZWQzNGIw
ODFjMDJhNjExNTkxYzUwNzljNTNiNzcxYjgNCj4gQXV0aG9yOiBI77+9a29uIEJ1Z2dlIDxoYWFr
b24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gRGF0ZTogICBUdWUgSnVuIDIyIDE1OjM5OjU2IDIwMjEg
KzAyMDANCj4gDQo+ICAgICBSRE1BL2NtYTogUmVtb3ZlIHVubmVjZXNzYXJ5IElOSVQtPklOSVQg
dHJhbnNpdGlvbg0KDQpBIHF1aWNrIGF1ZGl0IG9mIC5wb3N0X3JlY3YgY2FsbHM6DQoNCjEgbWFp
bi5jICAgICAgICAgICA8Z2xvYmFsPiAgICAgICAgICAgICAgICAgICA2OTggLnBvc3RfcmVjdiA9
IGJueHRfcmVfcG9zdF9yZWN2LCA8LS0gYWxsb3dzDQoyIHByb3ZpZGVyLmMgICAgICAgPGdsb2Jh
bD4gICAgICAgICAgICAgICAgICAgNDg5IC5wb3N0X3JlY3YgPSBjNGl3X3Bvc3RfcmVjZWl2ZSwg
PC0tIGFsbG93cw0KMyBobnNfcm9jZV9od192MS5jIDxnbG9iYWw+ICAgICAgICAgICAgICAgICAg
NDQxMSAucG9zdF9yZWN2ID0gaG5zX3JvY2VfdjFfcG9zdF9yZWN2LCA8LS0gYWxsb3dzDQo0IGhu
c19yb2NlX2h3X3YyLmMgPGdsb2JhbD4gICAgICAgICAgICAgICAgICA2MTkwIC5wb3N0X3JlY3Yg
PSBobnNfcm9jZV92Ml9wb3N0X3JlY3YsIDwtLSAtRUlOVkFMDQo1IHZlcmJzLmMgICAgICAgICAg
PGdsb2JhbD4gICAgICAgICAgICAgICAgICA0Mzk2IC5wb3N0X3JlY3YgPSBpcmRtYV9wb3N0X3Jl
Y3YsIDwtLSBhbGxvd3MNCjYgbWFpbi5jICAgICAgICAgICA8Z2xvYmFsPiAgICAgICAgICAgICAg
ICAgIDI1NjEgLnBvc3RfcmVjdiA9IG1seDRfaWJfcG9zdF9yZWN2LCA8LS0gYWxsb3dzDQo3IG1h
aW4uYyAgICAgICAgICAgPGdsb2JhbD4gICAgICAgICAgICAgICAgICAzNzY3IC5wb3N0X3JlY3Yg
PSBtbHg1X2liX3Bvc3RfcmVjdl9ub2RyYWluLCA8LS0gYWxsb3dzDQo4IG10aGNhX3Byb3ZpZGVy
LmMgPGdsb2JhbD4gICAgICAgICAgICAgICAgICAxMTQ4IC5wb3N0X3JlY3YgPSBtdGhjYV9hcmJl
bF9wb3N0X3JlY2VpdmUsIDwtLSBhbGxvd3MNCjkgbXRoY2FfcHJvdmlkZXIuYyA8Z2xvYmFsPiAg
ICAgICAgICAgICAgICAgIDExNTQgLnBvc3RfcmVjdiA9IG10aGNhX3Rhdm9yX3Bvc3RfcmVjZWl2
ZSwgPC0tIGFsbG93cw0KYSBvY3JkbWFfbWFpbi5jICAgIDxnbG9iYWw+ICAgICAgICAgICAgICAg
ICAgIDE3MyAucG9zdF9yZWN2ID0gb2NyZG1hX3Bvc3RfcmVjdiwgPC0tIC1FSU5WQUwNCmIgbWFp
bi5jICAgICAgICAgICA8Z2xvYmFsPiAgICAgICAgICAgICAgICAgICAyMjEgLnBvc3RfcmVjdiA9
IHFlZHJfcG9zdF9yZWN2LCA8LSAtRUlOVkFMDQpjIHB2cmRtYV9tYWluLmMgICAgPGdsb2JhbD4g
ICAgICAgICAgICAgICAgICAgMTc1IC5wb3N0X3JlY3YgPSBwdnJkbWFfcG9zdF9yZWN2LCA8LSAt
RUlOVkFMDQpkIHZ0LmMgICAgICAgICAgICAgPGdsb2JhbD4gICAgICAgICAgICAgICAgICAgMzky
IC5wb3N0X3JlY3YgPSBydnRfcG9zdF9yZWN2LDwtIC1FSU5WQUwNCmUgcnhlX3ZlcmJzLmMJICAg
PGdsb2JhbD4gICAgICAgICAgICAgICAgICAxMTMyIC5wb3N0X3JlY3YgPSByeGVfcG9zdF9yZWN2
LCA8LSAtRUlOVkFMDQpmIHNpd19tYWluLmMJICAgPGdsb2JhbD4gICAgICAgICAgICAgICAgICAg
Mjg3IC5wb3N0X3JlY3YgPSBzaXdfcG9zdF9yZWNlaXZlLCA8LS0gYWxsb3dzPw0KDQpMb29rcyBs
aWtlIGl0IGlzIGEgbm9uLXBvcnRhYmxlIGFzc3VtcHRpb24gdGhhdCBhbiBvdXQtb2Ytc3RhdGUg
cG9zdCByZWN2IHdvcmtzLiAgIEkgZ3Vlc3MgaXQgaXMgcG9zc2libGUgdGhhdCB0aGUgcG9zdCBo
YXBwZW5zIGFuZCBnZXRzIGZsdXNoZWQgYmFjaz8NCg0KRnJvbSB0aGUgSUJUQSBzcGVjOg0KDQpS
ZXNldCB0byBJbml0IC0gRW5hYmxlIHBvc3RpbmcgdG8gdGhlIFJlY2VpdmUgUXVldWUNCg0KLi4u
IHBvc3QgcmVjZWl2ZSBub3RlcyAiSW52YWxpZCBRUCBzdGF0ZSIgYXMgYSBwb3NzaWJsZSBpbW1l
ZGlhdGUgZmFpbHVyZSwgYnV0IG5vdGhpbmcgbW9yZSBiaW5kaW5nIHRoYW4gdGhhdC4NCg0KTWlr
ZQ0KDQo=
