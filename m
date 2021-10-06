Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68F742404C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhJFOoI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 10:44:08 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:44434 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231403AbhJFOoH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Oct 2021 10:44:07 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1969c7YL019967;
        Wed, 6 Oct 2021 14:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=p4ZLSWO9PC0J2YlQq15BlQEXIV2ML6AX6VdxS4g266U=;
 b=MpCBxIFv+QLCZkHo7EaHUMsdxnTRGPUPBFYAQz/eTe0bquEieTlhYqRoycSn0sfpZ1Bm
 7vNd0OBSQHdnIvD4oWrKwSwwZTBAlulYlC3+dGhv+fXqZGw8GrmkDm5QzYK4LwpNUXlq
 MyKHXYqBZH4OCz8qJ0kpMXjIIxUhfSPj2mM0mOIF7TG6pz58k0Zha9pMb2zNx6wRfetI
 duh1eTmFG7Rr50v/kHzofH+MH/OjPAd/gpzhTxL9CEZwWxov2ywsZtE4UTtPDIZY3l9G
 xlLz8pU12QUIEl8Wpi/Vi5fDnq4+Yr0ZmABab7XbGENP8BR1b8F3kxwXcmZeFmoHxqw5 MA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 3bh9beteuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 14:42:09 +0000
Received: from G9W8453.americas.hpqcorp.net (g9w8453.houston.hp.com [16.216.160.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 5D6126E;
        Wed,  6 Oct 2021 14:42:08 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 6 Oct 2021 14:42:08 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23 via Frontend Transport; Wed, 6 Oct 2021 14:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckYnMlSpepolsP6NvLFIhneSdBGPpgxMnEb76y5vTB2jR0lqh33BdSEQwUjQewzhK+YVk2vXR8IVYlsPVcb3nMyy7FIauQWxAxEODZbqnAps/5CXwzw7Km5JBJGSeaqc9UqZDDSdXfXIwSLIwgm+VmqYH20y9UDP1footkDgvmnJdXM+h9I3yC3Fu3uNh5FHveouc6OfwnEIykFP75fg59eLCmOnmgG2ZD/czZOnK0PLmvnj/Qj4YURxsii5E6IZzOuw06ehrtVI9Z9kRovg61t16/y136yn+My8sxWZ1RMX4aVSvltXizWuNotm+6tfQdM59dYp/nTyOax6H1ppuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4ZLSWO9PC0J2YlQq15BlQEXIV2ML6AX6VdxS4g266U=;
 b=TmV96qrr9PQw/52bwZ173X7FRRsBkU216je9YMcx3jpd67m3NYbHRvkbQGdaZervy5HvMzS8YUQreYSKSlAcwiaeeLWpC31RudOdtPnA4Hn/vCEqYOnlQzd5lUqrP8J+LESX1cDJOA0msXk8OrTVY4S0ROvImRaPGZggdNZxYL0nWBQBX+xauqLtMrAQeps28UtcQHQnXRGYCwWz/oJ4bwSBd3Dzuxlhspv3wcCMKHkBnxlKQv+RHFYIY9V0ztqHU9r2sZjHUWwESuLuBWOCHVZJL3WKjzlmqQ2HQOBzSX0aAgZHPedR04QI4Czwif0njBSl3K6utCS+y3J7v8DxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7511::15) by CS1PR8401MB0325.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7515::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 14:42:07 +0000
Received: from CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ccb1:b47d:5749:87a6]) by CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ccb1:b47d:5749:87a6%10]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 14:42:07 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v5 5/6] RDMA/rxe: Lookup kernel AH from ah index
 in UD WQEs
Thread-Topic: [PATCH for-next v5 5/6] RDMA/rxe: Lookup kernel AH from ah index
 in UD WQEs
Thread-Index: AQHXulWrcfbcIBHqJE6we4XmVTjzJ6vF3ZGAgAAt6NA=
Date:   Wed, 6 Oct 2021 14:42:07 +0000
Message-ID: <CS1PR8401MB1077B75B6233730E5AFB5601BCB09@CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
 <20211006015815.28350-6-rpearsonhpe@gmail.com>
 <CAD=hENda99c3wDoub39EedNrU7cmeMORnW=q6K9EVdFXZaTUsg@mail.gmail.com>
In-Reply-To: <CAD=hENda99c3wDoub39EedNrU7cmeMORnW=q6K9EVdFXZaTUsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7692e41c-5304-4283-f21e-08d988d778a5
x-ms-traffictypediagnostic: CS1PR8401MB0325:
x-microsoft-antispam-prvs: <CS1PR8401MB03257DE4C496DC73BF3EDE8DBCB09@CS1PR8401MB0325.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygjjC9t4DRfAVckQpcbbnKgn7ATVvye6cwXmRmgmOlqzdHj81DpvBfB/1iUm+BdbAnXnuAP425UyQ6HvawSsdeA7jiXLXjtQA7DnkMR71hiPtbWwMsXPOjZhHAYi9NYqf6JNqcAGQaog6AiT1ne+Lk0pmsCRj+gZNisJkYFHrcrYs7ewVqQ7Lg/z0gVEmF6Tnpc4ScSJfXBe3PQbfKKHwyTN1tkGU2Yoa0y603ztCF+NSdwmptfCUQ14gurCtBkntLw4YzUQDmIEuAfKMORTxI7G5bNIOu+OBmoKs909jhi0aTCfi/CkQJT2hUlF+bKVrnujs8spMuQrL3WIrc7SICg8lG07asZ9O/uIcE5cJLrNhBVo/wvGiV57+cpYmAcjgVsXjGHNOFIVyptEeVVox6p5guikWpnSIDF+BChIHxN7LbehinexSyNsbX5fYTvEqgNE45eYIWN5VWPOt1YfvFh0+wo7s/SLRrv/Ke4UQMEquZKCQeOoOoRu/wUYml+X2KEtX4ecjwcYVOnNhGXKcyMbTxvY1HZlckH4re7XFYRiOM0u2HO4Y4/2vLW/hrlrCKNfhLACQWoGF5s+IUkqnSEtco68bmRu4jvg7oueJ0VrBVUZz7bJwTD4sjBI4fJv+vtbMRzPcFbnokKs3rcP4RMgD3xyV3+YyBKVZ0h4PLIDz/jhN0uSc6Z72v56bScUuQPcFhfsmMOs5Gl5ec7n/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(76116006)(66556008)(55016002)(66476007)(6506007)(66946007)(53546011)(9686003)(71200400001)(83380400001)(2906002)(38070700005)(8936002)(8676002)(33656002)(186003)(7696005)(66446008)(64756008)(508600001)(52536014)(5660300002)(110136005)(4326008)(38100700002)(86362001)(316002)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENhNStlaUgxUkMvUGRBR3dVTXhKWmdyUTRqdnR4S2xHL3NkYmJBT0M1V1I3?=
 =?utf-8?B?UTV6MlJKNkNlRGZ3MzFYMysrenVManBhTFNINGJBRHQwQWd5UlpxU0tYdko5?=
 =?utf-8?B?TUpEMG5ZOHVNMUpRZ0FRbHRFK2JETERBcE1uMTN2ZVZtbVRYckJML3B6Qy81?=
 =?utf-8?B?cnZUaUR5WjMwVXpuaXhnc0RuVXU0TFhLYnJXVjM4WkJtRGR1dWJpK3hrUThw?=
 =?utf-8?B?NmNLV0dpcjJyVk9qS0lwM3dBRnpKeHJxNXZrTTg4eFRtNE4wSkJCTnorQ3lw?=
 =?utf-8?B?TjVPUUx6THFqZythVDJyL013WmhLMkJXL2hBN004NHdzWStmUnU4aVJUVUFZ?=
 =?utf-8?B?SlREREZGZWhhL0F3NmUyWGtwSXNyaWJ2U2owNXBRcFh0Q0hKZVZBVHhwRm9r?=
 =?utf-8?B?a1Z3OElZVlplSjNlUWs3MytsQUxMNmg1TTgxSE9nazdGbSs3d1hsMFl0Uldl?=
 =?utf-8?B?bGxXWWZ0djVvYVFYZkVwZ3ZpUmMvQVI3Szc0enhlcDJ6bzkwNEo0dmx1dmgr?=
 =?utf-8?B?MkhiTVdxaDJHS2t3NDlpbnVQS1NURUJpazBsNDJ5d0hweU1pcWl5Q2hjU0x0?=
 =?utf-8?B?WGhiWlhpY1J4UWM4cEtpU0ZwQUlwb0tpSDlROENPZFd1NTQ5bWJLUFpOM29i?=
 =?utf-8?B?UXZPdEliL0tIWC91anFvZXFIVkhocWtaMGQrZGo1ZTF2TzkvU1lCNWMyTU5t?=
 =?utf-8?B?N2RyNkJpSEFSUXhWQXdIbTJCOG1MY3VoSzIvTk5GU3hUTEt3UUlIWTJscGVw?=
 =?utf-8?B?dTd1TkpPOHdQOEJBd3hPY1BWcVlOWVRUYUhSZTgzamJQWGRXM0NkZGxoeUhh?=
 =?utf-8?B?QWg1emdEU3RUZUlhYklkUGowbzVidUFlMkF4SWR3QzNPS3VieFM3TEw4L3BE?=
 =?utf-8?B?aUpJNTZ6TDNjQlEzd0RqbGJNTUdHV3VqTjZLdmt3ekpWZkpRVFZOcGxhQTlr?=
 =?utf-8?B?QllpTnVPNlZQcVYxZEFFOGFmUlhoVVA5Y054UXFuWjZJa3pzYytWUHZqcndl?=
 =?utf-8?B?SlJ3OGFSeGxvVUVaRjcrWWFBNUVBWnIrSUFPVXNzcm1UUmh1NVAvY2l3Q2lB?=
 =?utf-8?B?NG5XZis0TC9sRFZyRlh5bFFXZDlROHhOUkxHdnJyOXJqMmY5cGI1R25rYmlQ?=
 =?utf-8?B?NFoyWHJLZ29VekpFdnYyWWFYSUN2RndqKzZQNytGbUpYMTg1dldmbyt1SWc4?=
 =?utf-8?B?TEhmZ1pCV2hxVFNTQzdUMlZORVRkVjJZR25SK2RQWm95eFRUT01yQmRzc2pz?=
 =?utf-8?B?cEwwdEJhV0tUQjJLWHFTZEFsMjF6UHhPeGZ0enJXSkdIZzhTYUlIRDlqNWpk?=
 =?utf-8?B?L3VHSkhRdVRPQ01QZHd4YWJEdjVIR2FxRUZPcW45Y1BuQnBaYlk2bWJ5L2tV?=
 =?utf-8?B?YlRkaUxYWXRsV0ZkT3lFRGhmZnlQMFJKNkljSm9nMUM3dkdEQkgxUVo4cjZG?=
 =?utf-8?B?eGtKeXptVmpUbm1OKzRUZzBrOFNTSXVvMTRVNUJrT3hLbktONmJ6U0diTGgv?=
 =?utf-8?B?VE0xdkQxMStZYUtsaGtNcUk3TGUyT3BYZFJtNXh5Q05JVklvL1JOVDZ0Q0VR?=
 =?utf-8?B?NTJqdk9jR1lIb3p3TUxuTGh4L2VQbFFaTjdNUitJai9uZm04RVY3empvSmF5?=
 =?utf-8?B?Z1Q2Rmh6ZnMyWUVpYU45SDd2VDJrY1RtbFJqU050Y1Z6TFZKZGxnMXFVM1Va?=
 =?utf-8?B?SUVoNnByZDBjcmxUOWRXRDZhT3dHY1N4eG85ZzQ5enYyck1rdkJsbG4vTStw?=
 =?utf-8?B?QUtrT3M0WGptMlgxcFBOMTIwS3ZybVozR0g4dGdDZWcrc3ovMzMvNWRDYmFu?=
 =?utf-8?B?ZENMNGIvK21sQU1pcDdOKzMxdWQvRTgvZlZMUE9zR05oSHhoNmZ2ZVJ1Y21U?=
 =?utf-8?Q?eIQM4EBIVy1en?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1077.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7692e41c-5304-4283-f21e-08d988d778a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 14:42:07.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGklvAfuO+UHS5q37oPZcIYSXe0y8/iZmGgLyEFoqCPYQ1mPrOZEk5a8Ph/eLn6XKoAp4PlFzTR2Ai5fBJMe4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0325
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: x578XxA-qo_EjLShOzW_A_tcKPKgNCM2
X-Proofpoint-ORIG-GUID: x578XxA-qo_EjLShOzW_A_tcKPKgNCM2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_03,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060091
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wmh1LA0KDQpJdCdzIGEgbWF0dGVyIG9mIHByZWZlcmVuY2UuIEkgZmluZCB0aGF0IGZvciBtZSBh
bHdheXMgcHV0dGluZyBhbGwgdGhlIGxvY2FsIHZhcmlhYmxlcyBhdCB0aGUgdG9wIG9mIGEgc3Vi
cm91dGluZSBzYXZlcyB0aW1lIGFuZCByZWR1Y2VzIGJ1Z3MuIEkga25vdyB3aGVyZSB0byBsb29r
LiBUaGV5J3JlIGFsd2F5cyB0aGVyZS4gQW5kIHRoZXJlIGFyZSBubyB0cmlja3kgc2NvcGUgaXNz
dWVzIHRvIHRoaW5rIGFib3V0LiBJZiB5b3UgY2FuJ3Qgc2VlIHRoZW0gYmVjYXVzZSB0aGV5IGFy
ZSBvZmYgdGhlIHNjcmVlbiB0aGUgc3Vicm91dGluZSBpcyBwcm9iYWJseSB0b28gYmlnLg0KDQpC
VFcgZG8geW91IGhhdmUgYSBuZXcgZW1haWwgYWRkcmVzcz8gSSBqdXN0IHNhdyBvbmUgZ28gYnku
DQoNCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmh1IFlhbmp1biA8
enlqenlqMjAwMEBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDYsIDIwMjEg
Njo1NiBBTQ0KVG86IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQpDYzogSmFz
b24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC1y
ZG1hQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggZm9yLW5leHQgdjUgNS82
XSBSRE1BL3J4ZTogTG9va3VwIGtlcm5lbCBBSCBmcm9tIGFoIGluZGV4IGluIFVEIFdRRXMNCg0K
T24gV2VkLCBPY3QgNiwgMjAyMSBhdCA5OjU4IEFNIEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBn
bWFpbC5jb20+IHdyb3RlOg0KPg0KPiBBZGQgY29kZSB0byByeGVfZ2V0X2F2IGluIHJ4ZV9hdi5j
IHRvIHVzZSB0aGUgQUggaW5kZXggaW4gVUQgc2VuZCBXUUVzIA0KPiB0byBsb29rdXAgdGhlIGtl
cm5lbCBBSC4gRm9yIG9sZCB1c2VyIHByb3ZpZGVycyBjb250aW51ZSB0byB1c2UgdGhlIEFWIA0K
PiBwYXNzZWQgaW4gV1FFcy4gTW92ZSBzZXR0aW5nIHBrdC0+cnhlIHRvIGJlZm9yZSB0aGUgY2Fs
bCB0byANCj4gcnhlX2dldF9hdigpIHRvIGdldCBhY2Nlc3MgdG8gdGhlIEFIIHBvb2wuDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfYXYuYyAgfCAyMCArKysrKysrKysr
KysrKysrKysrLSAgDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwgIDgg
KysrKystLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2F2
LmMgDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfYXYuYw0KPiBpbmRleCA4NTU4
MGVhNWVlZDAuLjM4YzdiNmZiMzlkNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfYXYuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9h
di5jDQo+IEBAIC0xMDEsMTEgKzEwMSwyOSBAQCB2b2lkIHJ4ZV9hdl9maWxsX2lwX2luZm8oc3Ry
dWN0IHJ4ZV9hdiAqYXYsIA0KPiBzdHJ1Y3QgcmRtYV9haF9hdHRyICphdHRyKQ0KPg0KPiAgc3Ry
dWN0IHJ4ZV9hdiAqcnhlX2dldF9hdihzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QpICB7DQo+ICsg
ICAgICAgc3RydWN0IHJ4ZV9haCAqYWg7DQo+ICsgICAgICAgdTMyIGFoX251bTsNCj4gKw0KPiAg
ICAgICAgIGlmICghcGt0IHx8ICFwa3QtPnFwKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7DQo+DQo+ICAgICAgICAgaWYgKHFwX3R5cGUocGt0LT5xcCkgPT0gSUJfUVBUX1JDIHx8IHFw
X3R5cGUocGt0LT5xcCkgPT0gSUJfUVBUX1VDKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuICZw
a3QtPnFwLT5wcmlfYXY7DQo+DQo+IC0gICAgICAgcmV0dXJuIChwa3QtPndxZSkgPyAmcGt0LT53
cWUtPndyLndyLnVkLmF2IDogTlVMTDsNCj4gKyAgICAgICBpZiAoIXBrdC0+d3FlKQ0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ICsNCj4gKyAgICAgICBhaF9udW0gPSBwa3QtPndx
ZS0+d3Iud3IudWQuYWhfbnVtOw0KPiArICAgICAgIGlmIChhaF9udW0pIHsNCj4gKyAgICAgICAg
ICAgICAgIC8qIG9ubHkgbmV3IHVzZXIgcHJvdmlkZXIgb3Iga2VybmVsIGNsaWVudCAqLw0KDQpz
dHJ1Y3QgcnhlX2FoICphaDsNCmFoIGlzIG9ubHkgdXNlZCBpbiB0aGlzIHNuaXBwZXQuIElzIGl0
IGJldHRlciB0byBtb3ZlIHRvIGhlcmU/DQpJdCBpcyBvbmx5IGEgdHJpdmlhbCBwcm9ibGVtLg0K
DQpaaHUgWWFuanVuDQo+ICsgICAgICAgICAgICAgICBhaCA9IHJ4ZV9wb29sX2dldF9pbmRleCgm
cGt0LT5yeGUtPmFoX3Bvb2wsIGFoX251bSk7DQo+ICsgICAgICAgICAgICAgICBpZiAoIWFoIHx8
IGFoLT5haF9udW0gIT0gYWhfbnVtIHx8IHJ4ZV9haF9wZChhaCkgIT0gcGt0LT5xcC0+cGQpIHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcHJfd2FybigiVW5hYmxlIHRvIGZpbmQgQUggbWF0
Y2hpbmcgYWhfbnVtXG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7
DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gJmFoLT5hdjsN
Cj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICAvKiBvbmx5IG9sZCB1c2VyIHByb3ZpZGVyIGZv
ciBVRCBzZW5kcyovDQo+ICsgICAgICAgcmV0dXJuICZwa3QtPndxZS0+d3Iud3IudWQuYXY7DQo+
ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAN
Cj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPiBpbmRleCBmZTI3NWZj
YWZmYmQuLjBjOWQyYWYxNWYzZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfcmVxLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVx
LmMNCj4gQEAgLTM3OSw5ICszNzksOCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKmluaXRfcmVx
X3BhY2tldChzdHJ1Y3QgcnhlX3FwICpxcCwNCj4gICAgICAgICAvKiBsZW5ndGggZnJvbSBzdGFy
dCBvZiBidGggdG8gZW5kIG9mIGljcmMgKi8NCj4gICAgICAgICBwYXlsZW4gPSByeGVfb3Bjb2Rl
W29wY29kZV0ubGVuZ3RoICsgcGF5bG9hZCArIHBhZCArIA0KPiBSWEVfSUNSQ19TSVpFOw0KPg0K
PiAtICAgICAgIC8qIHBrdC0+aGRyLCByeGUsIHBvcnRfbnVtIGFuZCBtYXNrIGFyZSBpbml0aWFs
aXplZCBpbiBpZmMNCj4gLSAgICAgICAgKiBsYXllcg0KPiAtICAgICAgICAqLw0KPiArICAgICAg
IC8qIHBrdC0+aGRyLCBwb3J0X251bSBhbmQgbWFzayBhcmUgaW5pdGlhbGl6ZWQgaW4gaWZjIGxh
eWVyICovDQo+ICsgICAgICAgcGt0LT5yeGUgICAgICAgID0gcnhlOw0KPiAgICAgICAgIHBrdC0+
b3Bjb2RlICAgICA9IG9wY29kZTsNCj4gICAgICAgICBwa3QtPnFwICAgICAgICAgPSBxcDsNCj4g
ICAgICAgICBwa3QtPnBzbiAgICAgICAgPSBxcC0+cmVxLnBzbjsNCj4gQEAgLTM5MSw2ICszOTAs
OSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKmluaXRfcmVxX3BhY2tldChzdHJ1Y3QgDQo+IHJ4
ZV9xcCAqcXAsDQo+DQo+ICAgICAgICAgLyogaW5pdCBza2IgKi8NCj4gICAgICAgICBhdiA9IHJ4
ZV9nZXRfYXYocGt0KTsNCj4gKyAgICAgICBpZiAoIWF2KQ0KPiArICAgICAgICAgICAgICAgcmV0
dXJuIE5VTEw7DQo+ICsNCj4gICAgICAgICBza2IgPSByeGVfaW5pdF9wYWNrZXQocnhlLCBhdiwg
cGF5bGVuLCBwa3QpOw0KPiAgICAgICAgIGlmICh1bmxpa2VseSghc2tiKSkNCj4gICAgICAgICAg
ICAgICAgIHJldHVybiBOVUxMOw0KPiAtLQ0KPiAyLjMwLjINCj4NCg==
