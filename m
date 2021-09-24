Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC364176F7
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346791AbhIXOog (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 10:44:36 -0400
Received: from mail-mw2nam10on2113.outbound.protection.outlook.com ([40.107.94.113]:17057
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhIXOog (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 10:44:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/EC3snka7SzY3sTJjXSQdzplmIzQo4/NQr9nWotQEB2D07OCEp4Ix4WFA8Ne+pSZsE8ee6xj3/vjPT2qUPUnrdXtFQCTkOS8AcHMUHDW4gFsHERzl7X7B5nwyYTJz3Y8nbOj0ZPpQ3gzmH57IKwVlH9rL+pO42jpDGDrqsvo9OaaFpofGIDi+QY2FwPIt7LsToIr/73ldYQPyjOxnAgl17dMN4TYOOusTAzsyAd8O0Riqm3jFNeQKahNxkBEH8YBSEZ2dYDqnVNjsSOaH1qyfiA2RkW62L4GzCwQ+Y1pxiuhaE8EjiMoYfeLZXQ+6h4bxSPC6Nw/a8RRLPD75Gubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w2m4vRJGjatozyiQ7QspLZ9unM16r6Kbx4Qfp70lpAk=;
 b=LPrUDcFLxxCORc0QKEkIXjeAevKkE0OWAwNIge8bMEOOW6c43TVmq2omuK3/uuGjgj22AoSElr0EXwQZmI3vBPq480+bzqX983i57ACEtpUPbt+YFB+IRlCt7ZdzxwJHnTUs/7gJDU/pmt5ObZdlsq0FWmcGbzwB4edwcHkS/UU+9z4aSzm5N6Q4N+Zf5LAuMU24Zr6maxTPVXGLTBnQxez/xF0Y+H22L5soCSl4W7ogkW14XvIwxk1Zyo0Kc4bDppY60tkJpP2yiRi4iq9hgEusWQLSmwopqjyMxYLnSwBMKu8J4ZSbPgoqEwIwZekdtKSObRkuMz5xXoBbyQNodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2m4vRJGjatozyiQ7QspLZ9unM16r6Kbx4Qfp70lpAk=;
 b=ZFbvPgim7kkt4feNfPelFwruja8udzFk+9UWoTIV+ntIJY4erXWjKA3nZTnep7/3oZ6NY1Qs02oQg4fXl3a18NyjxSYAuTKyXj+dasNbgn9eDUbUQLrk5iZXGo2M5RMH/RYacB2BUVNX4R3jw9hTFfPMSz3CQ3Cg4Us4pBNWXoQo3jd6LKOfVxtKcUP9efjmBw9z0FN40SWr6TlmRMoRpVFmfXE77gjErp+rfvigC4+yCHXUz7yLkNAjee9aXUQlPsZctpHrW4nR/liU1FsX57PqH2pKxiRRob+MtwqQxXq2C000OFHVmDcfBRFY0iQYqmRaPJJhsrhcbIt+qtISwA==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB6054.prod.exchangelabs.com (2603:10b6:610:4a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Fri, 24 Sep 2021 14:43:01 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 14:43:01 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Topic: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROauwTzmggAAKPwCAANRigIABT5aAgADF2/A=
Date:   Fri, 24 Sep 2021 14:43:01 +0000
Message-ID: <CH0PR01MB71533CD295D5799DC26CF857F2A49@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org> <YUwin2cn8X5GGjyY@unreal>
 <9cda0704-0e63-39b2-7874-fd679314eb2b@acm.org>
In-Reply-To: <9cda0704-0e63-39b2-7874-fd679314eb2b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ba7fee-e9bf-455d-cab4-08d97f699bd3
x-ms-traffictypediagnostic: CH2PR01MB6054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB60540090CABE4570DE17EF2AF2A49@CH2PR01MB6054.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzaryBTSW6T6qAYATfrMN15zw1nwaWNHBY/ErnkqnMz7ohgirOs5FBnNzAFZgnARFuD7CyUVybv43638TznK2vLydmylABp28AtrRO1MPH+piO8rxlpGF/wH2i2+FcN06iN1JdBR9Rs39hDrbmVxxjYYJkanzKHS2kE5UBq+DpfpnIWcHuJ+BUdmo7BwWAK6HlbWtoFqWST9q591Nx+EA77SRqft3Fkw/16jOkTpMSC/9pJy9GX9bHwggCL4ACzCISqzbTFDtal5QZNFUnihuo+VN9A0cFDufhs6fQ6NqNTitdq1nUvEz+XIasJLf021b9lysrbrF+1G5vzuMNqIpXzX//dSFWf/565P14VlT5HeFpx7FQkxizqOdNtpPmG2hNVJEc2jIFdUyZcD6264nyuvs/qmmCTizM0fE9SH2EO7tXJeh+kZ8Wy71BI45HJUTTw73y04HZN/fH8PF640xjSXezRHNU8d/Xpt2lJng1SMQQUYr7wVX8ObAqJ6HFPxnYGTZ5xQPMqs8ZrY0SDCoxQVuxda4aElfD0jXPrTAo4qoDoqBu3UsQy2zhN4fpC/Vt2ToeSPKM7Jda4jsa5UjG9TzHsQ9niSsRm4selGjDJw7M/C+TdWPyrnoJ7DBKEEPGGmTlGiBtIIjErwJuG8i+uHk7kGvin/Czs+2PC02/8Mr36gsovFCiIHU7q65zlUKZxIknyR8EhNdvCNUr28AA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(376002)(346002)(396003)(366004)(33656002)(8936002)(55016002)(186003)(316002)(86362001)(5660300002)(9686003)(52536014)(508600001)(38070700005)(6916009)(6506007)(8676002)(53546011)(66556008)(64756008)(26005)(66446008)(66476007)(38100700002)(122000001)(71200400001)(76116006)(66946007)(2906002)(4326008)(7696005)(54906003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkxLQTRySklsaFJ4NWdEMTRNNTZ6OEUvZWNYamZTMlFudDZVZnF1TTZ1STlF?=
 =?utf-8?B?NEZEY2doUndIQTlDK1hZa3F2bXFtNzVrci96bVp0UlBzL3M2Rzg2UkRSMklw?=
 =?utf-8?B?elNsWi9yS0FLNGRCRERKaDdZRmJ2TFR5VnZBY2RNQjNXYVJiSk1pVEpKTlFu?=
 =?utf-8?B?NnJnYUZ6aEhLbGVRQzd1d1JqemJtWXQ3SXJybk16b1NOTFRaTHhPRXhYaFpY?=
 =?utf-8?B?V0czczBPeDRJZUxTWWd5cXJNWktiUmdQelBqZHIrWWJQdzRndktwU0lUZjBS?=
 =?utf-8?B?UlNjU1VMTllBRW5kaWhnY2ZzVFByb0M4MFg4L3ZKOUw5R1RIT2RRZ3duTy9G?=
 =?utf-8?B?VXZiUk5zSUJJZGZmMUgrY05aNlVKejZDQTgyWUN2WDhUS083NFh0c2dqdUJi?=
 =?utf-8?B?ODgxMUtTZE02UmlyTEhsUU16blA0VmF1alRRcnE5cGtTZG9ldHg0cnJsU1Bh?=
 =?utf-8?B?ajNNTGgxajVtdkxsZmF5bTdzUXdOM2FXY1h3Mk84NC9UYjRIa3BZY2cyOHNS?=
 =?utf-8?B?cUh4aFdIcUhmTkx4emdaSi8yS2NzWDRiSWlVZGxJZkxyaGNJV3RRVDdrTXov?=
 =?utf-8?B?d1lNNWsyS3p6L0JxV0RGakwzY09ySWtDazdPcXAyTDJmRFRFbDBrZGdDLzI1?=
 =?utf-8?B?Q0pleFhQMGlYbFRRTlZQbmNMYTQ1N2NEVTN1WkhqZHB3anJNM2NTSlpVTG1w?=
 =?utf-8?B?SnBKMGFDK3FkZ0wxd2tWVjA4eHZxN1ZIbkY5QWY5TTkzaGhnYWUrUmNUMWhE?=
 =?utf-8?B?U2Q0QWhjcTBMckFYUEhybzZDeTlGa1YyaTRjK3A2MXcvNThzSVJyV3IrOHZx?=
 =?utf-8?B?aisrcWtZL3hBS251UlJ6TnNWOWRQOWplUGFUTWZYNDVOYjNyVXBuS29USzBB?=
 =?utf-8?B?cGgvSlFWWnBBbUVaWmZnUHQ3Y2MzejFuR3h3MTNPSTB4MDVPcUFZcUdKTmN4?=
 =?utf-8?B?YmVRZTBqVGluOGFDWHBhZXdwUjhVRWdMT0ZWU0VQNXNJc3puTVZIaDh0cTJE?=
 =?utf-8?B?aCtoc2QrTWp2bllnb3hqWFBoVEd1NFI1OXpZOXF2ZzZQNFAvcWVvYjc2MVNm?=
 =?utf-8?B?UFhxU1V1dGJ5QkZFWi9ZbkRMaGN6aUtxbEc5Y3dWVlBodTR5ZHhuL3NSWDd4?=
 =?utf-8?B?RktCZCsrdzIvZmVUYi8yZSs1NGo4T1ZZRURwQkhVWnpGdytMZkRzbHJhL1FH?=
 =?utf-8?B?N1BuS2k2SUJuZVFud1F3R09nMUZlUjA2YzdQdENOaTBoenQ5Vkpnb2JIbndW?=
 =?utf-8?B?N1hiWUh3T1ZEL0Zqd0ppdFJ1WldJRTkxWlUvSjdsWkMwYmRaM3VNWTVpeFc3?=
 =?utf-8?B?MGpxcnNwY3V0Qis2cno5RDdELzNua21ON3F1eFJiS253S045MnVweEprdmk3?=
 =?utf-8?B?dE82bENTN2dreFowM3A3aTBsMWswR2dqZmNwcTE2VlZSNEY1REErcnI1K0Jn?=
 =?utf-8?B?K0JzN0k4RWxhNDdHRitXaXY2WWpYR0hpeWhMVE5iL2ZuekJZZUZZTDNxb1pI?=
 =?utf-8?B?TzUyTm1FbkRGbUpNVTRSVzhudzlsQzc2eVgwckVKQkc3MUM1b3I5MkFQbGZa?=
 =?utf-8?B?V053NjJXdEM0a0pNWjE0ekNrTUxKenplSEE0dW8rTExEMDhJbnFrZ3ExUTVt?=
 =?utf-8?B?ZjVwK3ZvcVdxeGo1eHdvZmRxeXM5OUEvVVdRZWx5aGM4dUhGY1lsM2k1b2VM?=
 =?utf-8?B?ZlNYOE1tMVkyWUdUT3huOVpmWnp4RzNzZ2dPTXh0UVdCYkZvSEM3Ync0S1dO?=
 =?utf-8?Q?1xjA9im8/pC4iMjrv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ba7fee-e9bf-455d-cab4-08d97f699bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 14:43:01.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfM8Na7xDMDnjHc0uCFZeSs3pwAMTR2O0dQ47BqNMEH4QPWx+DYF/AnI/S45dDuCsoRGD3lcZPp/FFK760lhvLxwHauqQ6hq6FZoFGR2JCd1cqRkhyqH/vDqp9mcEeSL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6054
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiANCj4gT24gOS8yMi8yMSAyMzo0NSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPiA+IElzbid0
IGtwdHJfcmVzdHJpY3Qgc3lzY3RsIGlzIGZvciB0aGF0Pw0KPiANCj4gSGkgTGVvbiwNCj4gDQo+
IEFmdGVyIEkgc2VudCBteSBlbWFpbCBJIGRpc2NvdmVyZWQgdGhlIGZvbGxvd2luZyBjb21taXQ6
IDVlYWQ3MjNhMjBlMA0KPiAoImxpYi92c3ByaW50Zjogbm9faGFzaF9wb2ludGVycyBwcmludHMg
YWxsIGFkZHJlc3NlcyBhcyB1bmhhc2hlZCI7IHY1LjEyKS4NCj4gSSB0aGluayB0aGF0IGNvbW1p
dCBkb2VzIHdoYXQgd2UgbmVlZD8NCj4gDQoNClRoYW5rcyBCYXJ0LA0KDQpJIGFncmVlLg0KDQpK
YXNvbiwgYXMgdG8gdHJhY2VzLCBJIHN1c3BlY3Qgd2UgbmVlZCB0byBkbyB0aGUgc2FtZSAlcCB0
aGluZyB0aGVyZSBmb3IgZXhpc3RpbmcgY29kZSBhbmQgYW55IG5ldyB3b3JrLg0KDQpGb3Igc2l0
dWF0aW9ucyBmb3IgZGVidWdnaW5nIGluIHRoZSB3aWxkLCBhIGNvbW1hbmQgbGluZSBhcmcgY2Fu
IHNob3cgdGhlIGFjdHVhbCB2YWx1ZS4gICBJJ20gb2sgd2l0aCB0aGF0Lg0KDQpNaWtlDQo=
