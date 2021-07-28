Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445633D8FA7
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhG1NxB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 09:53:01 -0400
Received: from mail-dm6nam12on2099.outbound.protection.outlook.com ([40.107.243.99]:53855
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236763AbhG1Nuw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 09:50:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU+xMQdp26mWjcRrIcNydEMl6ClsaY16HFBkU1IneULu3xv5mm+t7di1pUx37nPIFKiWPo8YIB0BsMXbODtSV+vEKsAR5bMuCIcDcRGgV7Wh7dGRfBJ/22HInleA5uphpq2FEciKv6e04Gb64BT66dwFZZu3MurouoFFT4PxvwtN3RcJMMzKNIdgfz5LndQGtMqtXIR8Y+4Bp6Fu1VKbzfybAuuwKi1YGcMW22iaBNnoFczJzGOn0FUjUI91wuOUvU4ntCGR09Y5TLwRIySLVdG3G39VywStgKYQ7xsnYcUIUCRSHssfL9xPu/bn2/X1w1m6ee9AMK2lvP3+/gNBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5YJ/p/+P3PV6uSftJVeq9iO6vuWg5YoPtQ9pqLZERo=;
 b=dx1FHsPhjhd2oJSYOG70KLthE6Q5yDLDS3Xsbjj7a+wreDpN3Lstf17tcfC5ThyInaarmJm3QEhiovXqDlDye7Yr8S9VfuNGr1DnVhFlruw9P8a33NZbfMpfNY97Cmz7mkaLO4bg01/Fy844Vq4dFVHUyGHAGwJbi4Fezjbcq6o/qpyG0EBbpa5c/ZfXAwRsZ2+NhH3DMctHHfw/nPLM5RBb1hNkaHBjW0umr+aUOnZsvWtvTxDGTS3cKMg31HqL4enodPytPOFfOPXFrEugtlq53NcKLDWZkh69JchzBYHTB/SRY31uo7r4tR6aHtWntE68irayc5npvAEnJM/QTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5YJ/p/+P3PV6uSftJVeq9iO6vuWg5YoPtQ9pqLZERo=;
 b=mNaLF+3B2Osr8hRmrw6Xw2jCCIxGlaPzUNEW7vWqrncbVA23fr1ClBqvnM++prywib3k1Q2Bh22gZ1Nx3oEo8fecBfetCgsS6SGPJg/kpuRlC0UyZsN67Idjn97veqpU/qlEjb3JLDi/hq9gCbHVfrJrZhSKBp+Wy0mFqrJyqQ4TSGyW49bNd6ooPHtdFLLJjIT+LtijuQ1+p5j/qkqR0ra3XDJ2P2kblgmh7lxrrzXUTpJYyTUf96kyvmCAI8s4VEAB33lsixX39ncB7LogjXPmwYChSwCTxGrx/PPeSNwA/QCzsfLuQIOlhDWXNmu1ehz/TgGZaspGMlD7Gr1w6A==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB6875.prod.exchangelabs.com (2603:10b6:610:100::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 28 Jul 2021 13:50:49 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.020; Wed, 28 Jul 2021
 13:50:49 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: RE: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAOO93QACMdPeA=
Date:   Wed, 28 Jul 2021 13:50:48 +0000
Message-ID: <CH0PR01MB71535949BACC7C43261EDAD2F2EA9@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb69d46c-3738-4eb2-9524-08d951ceb504
x-ms-traffictypediagnostic: CH0PR01MB6875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB6875C31BEBC6B6AF69603C32F2EA9@CH0PR01MB6875.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDURi6HXY6SBkciKnATKXj3orJpC2IlpCAPt4f5zpBR7ZUzWAuLQ/YtlfiGt7FSQMX2fD+MqVxwriW/Xn/HhbcnQIZOLjY4sn/kPclXjhQCiQj/mLtDFKjN3EvqIBox0CC0VY3I9mODaDNE4i7m5SbELPOv/rTSrBMTe4OWgsvwSG+XOCT2/TGb4YFBoSihtOJfWweB0t59aYX2SDbtmQqu1wRM9o6YpLZuEOep/fLEM+UNlgLoDUIKl50DVRfmQ0XPUMw2nt/hZfS06t4A3sUZ7pyDVXktQriHkcGIqdrSEMUX30GgC4SLf5tkHDepkZbIzEyUH60ejPr7T77eo2ok0MQ3SMPeorCZfVpchqAV3V2FUlycfWWjudqYVe5DQV+38fNyln1Q2DtJGBQ/T2fM4fE29mb4tOicppCLXEXlAVKUU/36LxhvSVn3FhwfUlgbFG2n4tC47g5zZO9Ixb7XBM7cky71tyLsGvDWuxFOrTYz99ysGWfVAEbszLvyX8HimhyonCD5xap78owlpyV3V2dlnfRRt8aKcQc3TMeRHk8CMdD9u23WHTntRymY45KI3WmjsMatkH9mdfNQI1ytzjmjVuZhJdzLvHs0/AEDFlIFMZ08l3ZHzyw3JiXanNJfCzllc9uu56BX67Wt4ClKRmTMGVsGiAu/TIGDdqptH7a5lGcm7zcUpZWuWRUeU+N+mrCXcQ710I9hcoaTFe8Hdfq1dIdSR1iHOlsAJOA9KDZOT9rTKAfs9LXYY/6/gljX1IyjqUx/73pVtVHNXHxG7lZ90c5aYDjy+Km9caD4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39840400004)(346002)(136003)(366004)(7696005)(38100700002)(5660300002)(55016002)(9686003)(122000001)(186003)(6506007)(76116006)(316002)(26005)(66476007)(8936002)(66946007)(33656002)(66556008)(66446008)(64756008)(2906002)(478600001)(86362001)(110136005)(71200400001)(966005)(52536014)(38070700005)(8676002)(54906003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3V3TmRFYTYzbFg0UEpZVzhObldWeGtxR3E5UlVFSi9SNzNzL21vR01mU2Fw?=
 =?utf-8?B?ckdBalRIT1VUQjRnNUlNWVAxbzQ4aFVQVEVFVU5POGtKUDB4OGx1aU9KanU3?=
 =?utf-8?B?V0gwYU1nb0N5RGtOS2tnTlhmaHU0RHVaMW54b2pabTBXaVJUcHJ2MHMvZ0Ew?=
 =?utf-8?B?NUZ5TkYwWk5TMjhmRi9hSmZsR0pxbnpRTnJITkNrUFZGb3k1eVJnODRpNjI5?=
 =?utf-8?B?V3B3WTl3ckN2clJiV1NORXZGVElvam0vTnhNSlpJWnlBWU1leWpMditwMGlL?=
 =?utf-8?B?Q0h4TVlRdUpYSlFxZGZ2T1VQTC9RYmxhNi9MSGdodGk4VnQ4WGp4eXQrWm1k?=
 =?utf-8?B?WUZ6YTVYeTVrZGMyeW9zMTkyNjhwdDdONVhmRlU3d2RleXVnL2szNTc4WFh5?=
 =?utf-8?B?Q3hmLzd3WUJWS3FZY0d4RW9KMGE4SW1xRzFTZWJwcGk5aVBWempqLytURjJR?=
 =?utf-8?B?NkdMd29SYzVmbUYvRngrY21SNHp5NE95dmRKbThaRXVYeUJHOWFkT0o4bDNZ?=
 =?utf-8?B?SG9XU1JsdEVQWUF0Q0NKM1hGcDVhTnhjTS9aVVlVdHlBMU1SYlRtaU02NzFa?=
 =?utf-8?B?aWlFMmt6bzJOYkdCclYweFFSN3g4RkRScWFzM0Z3R0JYdlZkUDRpUlNqNnIy?=
 =?utf-8?B?ZzBicXBLQnh6YWJ2cy9WUmxLbTJjaytrMEZCOVdqT25UdFBqcHgxdjdOV01K?=
 =?utf-8?B?dmM1ZnEzWWpFeFErblY2WGsyajRJb0RlbDd3WXBja2hlUW9hOU5wRU5nclZG?=
 =?utf-8?B?dVBDNDZzZFBSQ1czSzF0ci9CZm9QQWZrK00yWkYxaUtKZFRJQjFiV2NpWXhv?=
 =?utf-8?B?dnoxUnJpNXVBSVA2TE5WZ0RHaktlME5qeWJiYm1OeGVVa3pySDdJdjB3VUZT?=
 =?utf-8?B?dXBKaU1BbmRZc3d0V2hjOXBXMUpMOFhKVUlFcHE0RTRPeGNWNVYyTmExVUhQ?=
 =?utf-8?B?OU5DT3V4ZlFzcFRmTnBXbWNwcHh5SmpsaTNDWkxBZ0JOMVJNMWtrN1AzRldp?=
 =?utf-8?B?c1BVWUtaRlZ0MFlCQUJ0Zmw4VnM4K3crSDdVSHVwcWMyb0VXVDd1dEdvbGRy?=
 =?utf-8?B?QS9pWkZqTXF4OFpsS2lIczdHQXdGU3U4Y29Heks5UDRZTFV2VlRJL2Q2TG9O?=
 =?utf-8?B?VnFKVUJOL0F0U0dRME9KdlR1ZnVQL2J0anlEczgrYnFEOEtmem1sU3cyVjlZ?=
 =?utf-8?B?WVdvQTA0QmUxNDJMNlV5M2JxZzBHL1Z6ei92YTdJejBHZWMxcG9vZ2JyMDlx?=
 =?utf-8?B?SjJJWlo4VVk4VkNhRDQ0UVMxcTYrb0k0TUZVa0RBZEw4aWRLaE5zTkZRbDFC?=
 =?utf-8?B?QTFDK3pmOG12a0xoZE52MmNYZm9kZmpyRmxHRytZVHpZN3lNaWFqeFNQNU5o?=
 =?utf-8?B?NkF3UFM0T3E5cXI2cFJPN2svdEhqQTYxK3UyVWoyU3EyN1dRWW9nT3IxZzVH?=
 =?utf-8?B?bmZMTHdnZlAzQnRQS3l1bnVmbXJ6MkxYZFpwOEVQQ2NYb0lDSDNUdFNkTDc4?=
 =?utf-8?B?ajlOLzhXQ1BuT2JUS010KzVadDRjSnc0cWdveGp4cnB4ZE5Ud3VwNjhCZUhu?=
 =?utf-8?B?NHAycGg0YUFGMjQzalhkZTk5dzZzTnZKS01XM1BnVHRob25MdHhuZno4YStF?=
 =?utf-8?B?MVByYVdWSnZVdmZTUzVVaitZbkhTMS9FUHhKSnhBMmFTNVBQaE5zVHpSL0gy?=
 =?utf-8?B?S2dQZWY2UDhBdGZDSDRROXpqdDYzMHp1cWhmSWpsQ0N1bUVoYmhvTnpIRzZv?=
 =?utf-8?Q?3wArCFx9RSSxfBOEKg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb69d46c-3738-4eb2-9524-08d951ceb504
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 13:50:48.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X783r1vYWNJLNJoNjxzxl3p012CjKfMoAhe7dFT5LUljhDuwGVi7t+awM/hTZ9VwHCOp7XXrbjmgC4Ocg3Re6dXSyCkW8bUak5/2mJppPvYnVOitReK76QbV221lf6KF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6875
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiA+DQo+ID4gY29tbWl0IGRjNzBmN2MzZWQzNGIwODFjMDJhNjExNTkxYzUwNzljNTNiNzcxYjgN
Cj4gPiBBdXRob3I6IEgga29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gPiBE
YXRlOiAgIFR1ZSBKdW4gMjIgMTU6Mzk6NTYgMjAyMSArMDIwMA0KPiA+DQo+ID4gICAgIFJETUEv
Y21hOiBSZW1vdmUgdW5uZWNlc3NhcnkgSU5JVC0+SU5JVCB0cmFuc2l0aW9uDQo+ID4NCj4gPiAg
ICAgSW4gcmRtYV9jcmVhdGVfcXAoKSwgYSBjb25uZWN0ZWQgUVAgd2lsbCBiZSB0cmFuc2l0aW9u
ZWQgdG8gdGhlIElOSVQNCj4gPiAgICAgc3RhdGUuDQo+ID4NCj4gPiAgICAgQWZ0ZXJ3YXJkcywg
dGhlIFFQIHdpbGwgYmUgdHJhbnNpdGlvbmVkIHRvIHRoZSBSVFIgc3RhdGUgYnkgdGhlDQo+ID4g
ICAgIGNtYV9tb2RpZnlfcXBfcnRyKCkgZnVuY3Rpb24uIEJ1dCB0aGlzIGZ1bmN0aW9uIHN0YXJ0
cyBieSBwZXJmb3JtaW5nIGFuDQo+ID4gICAgIGliX21vZGlmeV9xcCgpIHRvIHRoZSBJTklUIHN0
YXRlIGFnYWluLCBiZWZvcmUgYW5vdGhlciBpYl9tb2RpZnlfcXAoKSBpcw0KPiA+ICAgICBwZXJm
b3JtZWQgdG8gdHJhbnNpdGlvbiB0aGUgUVAgdG8gdGhlIFJUUiBzdGF0ZS4NCj4gPg0KPiA+ICAg
ICBIZW5jZSwgdGhlcmUgaXMgbm8gbmVlZCB0byB0cmFuc2l0aW9uIHRoZSBRUCB0byB0aGUgSU5J
VCBzdGF0ZSBpbg0KPiA+ICAgICByZG1hX2NyZWF0ZV9xcCgpLg0KPiA+DQo+ID4gICAgIExpbms6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYyNDM2OTE5Ny0yNDU3OC0yLWdpdC1zZW5kLWVt
YWlsLQ0KPiA+IGhhYWtvbi5idWdnZUBvcmFjbGUuY29tDQo+ID4gICAgIFNpZ25lZC1vZmYtYnk6
IEgga29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gPiAgICAgUmV2aWV3ZWQt
Ynk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+DQo+ID4gICAgIFNpZ25lZC1v
ZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+IA0KPiBBIGJyaWVmIHVu
aXQgdGVzdCB3aXRoIHRoZSBwYXRjaCByZXZlcnRlZCBpbiA1LjE0LXJjMyBzaG93cyB0aGF0IHRo
aXMgcGF0Y2ggbWF5DQo+IGJlIHJlc3BvbnNpYmxlIGZvciBpU2VyIENJIHJlZ3Jlc3Npb25zIHRo
ZXJlIGFzIHdlbGwuDQoNCkEgdGVzdCBvZiA1LjE1LXJjMyArIGEgcmV2ZXJ0IHRlc3RlZCBjbGVh
bi4NCg0KSmFzb24sIGRvIHlvdSBuZWVkIGEgcGF0Y2ggdG8gcmV2ZXJ0IG9yIHNob3VsZCBJIHNl
bmQgb25lLg0KDQpNaWtlDQo=
