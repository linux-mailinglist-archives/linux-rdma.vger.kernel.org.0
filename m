Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED55491438
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 03:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244660AbiARCVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 21:21:04 -0500
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:19454 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244675AbiARCUh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 21:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642472437; x=1674008437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VKfEKWZEZf7Nx7mgXBvKGbjhJA3n0SbpFFeAX6ilccM=;
  b=HBtRPb2v9FZotksLeSw+52XVwukDX41q48KKHercJi/9Ax/OHc+D3nVg
   38qOFuvUq88Huwq8dEFpFtGt1+fq43r75kNR9rHEycq0/jcHCKPzckH//
   oh0vGZMFYPYfAXxbv18XWXDnsaMuFkpM/LRA/1Milv42gYUcgEo0ylubO
   B4VCRhjZtT00UbrjljsnBdPhymrJmLGw5eHwqI5VnYFAM5n9TtBhkWQEr
   mgjpXHkM8cH6r15HomQDL7yZsQg6hZCfXpOrnBj/jIgrvKgbmnBYo36B3
   DRYtpiPRoxaamtzkr1/OabgcaJbMIFyLI18TubSlHSUVW/my9ap11FHqI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="47824222"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; 
   d="scan'208";a="47824222"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 11:20:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKiEQbzmyJ5rTG7c1+2FjhDvsI99Tt5NHMSN4jJZb4TmKpbPO2qeiVdWaHKFNXbXpmoOLuiWAU6/LagTtjPzmOyN8Idz5aKsZiUUj8rjPKhnslBzEnLg4/6NtP+38/wIfAW235TXRQ4IyNambJ+ZOEzCc48pb0lw+LoKwnYTQxEEOCVDqjS+EXDeDPQpddARv2DmokfsoII4adWoFZ8s6gPms9+6OKCgF8ooSal9w+pK6F/wAJyLeWqIfCUoY30Wobfc7EAwxMYAV2WzuBZ/F7KoLTYqKfDjOPvwjaJMCFtH7mTSHmFjBw1UqZKUKKkHTtELhN2V+eBELVZ03Os1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKfEKWZEZf7Nx7mgXBvKGbjhJA3n0SbpFFeAX6ilccM=;
 b=TMhGOuNfXkIC4vltu9PZ3RcUF8G6J+F3tjHAS9J1bef3UNvUMX57jH8kkFVVznQ7qUK153giVxSdNvvG+QMFhzJ6w5EtJPXp8nw6jqTXByd42gmMD2uVdx4glGwa/YMcfFjG8qQ9Hk+k7p72XyZXB1OP5clxhbYwmBJ9BfG73cno02p7gd+UMztJxSdt9ajoQhmJCxnVTHNTnjD6qI6F043+y/vC2U2cI3TkPlufq1A1VPJC0tR92rAAHZ9LSgezsV2WqtuOgq3JfEjI6w3gZvRHzXmDhyRlpnCzgXIYme3BmKUf1MB/Xi/0h2/RO2WLJDS4x0qMYWIrW0VahVoMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKfEKWZEZf7Nx7mgXBvKGbjhJA3n0SbpFFeAX6ilccM=;
 b=WzmmW4tyfYco3/Pxt1PIWJAuVZ1pdBg1s9eAvJhj8Iqh0kN6ey0OpwStzp0Y8P6niSIfqVovYbcvawkmpM2ZilgrzMp3Trl/piQG4XNTWZFOvl6lsIXmonKR4e2fhtcKB6iexCb5b9wx3yefhT3MgLKicxe+ydaaVQK10tV274M=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB4226.jpnprd01.prod.outlook.com (2603:1096:604:31::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 02:20:30 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 02:20:30 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Topic: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Index: AQHX/GaNtF/ypvfLdEmpN5TwUFz2Y6xVMxeAgAJNfwCABElJAIACMCkAgAAJtICAAKg9AIAALHmAgASxiwCABKERgA==
Date:   Tue, 18 Jan 2022 02:20:30 +0000
Message-ID: <61E623DF.5000007@fujitsu.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
 <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
 <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
 <744a7e96-6084-2977-69c3-fd0e35a0e99f@linux.dev>
 <61DE51D7.5050400@fujitsu.com>
 <468c411e-8f68-00da-5c44-a3de72bf0d9b@linux.dev>
In-Reply-To: <468c411e-8f68-00da-5c44-a3de72bf0d9b@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 901b7208-55e5-4add-a947-08d9da291961
x-ms-traffictypediagnostic: OSAPR01MB4226:EE_
x-microsoft-antispam-prvs: <OSAPR01MB42264C0B9259EF8C5EC9005C83589@OSAPR01MB4226.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFq1++F46z3zo49jpAQsve6QftnwloqKgm2KD5upbFcokjxtJsJ065Zx2jojB+mr+9xqGZYCofdS9l9Sil7wEYQ2hS32UxFLlrRshXOrNR3XnUBwQE37PecSmjTSZA3ty1UUDbp/azCH+oxL261LvJFFB7xBzRc7lvrqgtWPrY97gZKoGcfoW+d9wPHecOIxuss6QRaNFLv7K8NLwuaGEPqT6r6N8B9DGbssXc5yPYo1sqiUrpKnHePUTJgfl0Ivk14nzKuT28GaBafOxFmVSCwVFu1R8UcTdTNr62+HQJQt0aMOv+Qc1h3dGUsVeFaSvXgZPxln1h48CFb6ZLcZrF5Or7NqVg0hCNdsQld4PRLbK3POxz2Q10DTG/2GBv5ni/1ZyXKweV4VQJUAk3YUlHHCEHUugLzTcMgTG2VQxPPyL1lZLzCCKlryqAwMVPfTwm3Qs1LmsJI9hPOc8SSHLObex08owc6uUk6yxg3at27j71QDPH77+eewhwCXg7mgmECnRAnAc1I6jvWpcfbMXhlmKiboQGC0XiS2DUDOTcXh/KrPfZ3m2vAUYiVQ6jXxrBaNZXqheOEGGS6pLPcVbbNQXDd+UU4SjHFr1TxSUdaUlqGvmV4EhYJEcDX4HeLQBVsunNs65JyjEw7S+tbJ3JHhr35JC5Ktxr/wf0BhBGKw9OBpDFbcqntfs9GF1bi2NJA/euUVB9ZP5EBhIaHwjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66574015)(54906003)(76116006)(66556008)(66476007)(91956017)(66946007)(66446008)(64756008)(85182001)(2616005)(8936002)(316002)(36756003)(45080400002)(38070700005)(186003)(2906002)(33656002)(6486002)(82960400001)(8676002)(6512007)(86362001)(122000001)(71200400001)(4326008)(26005)(38100700002)(6916009)(5660300002)(87266011)(508600001)(53546011)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R25rdEpXT0dwOEtESGZCSGRHMUEvMGpvMDlIUWtZb3FoeWF1bzlMM0k3ckdp?=
 =?utf-8?B?Y0RNaFVQTWJZVjlod08zVFRXZEI0TnkwL0t4S3owQnE3REZRS281enNlNXZB?=
 =?utf-8?B?cWZXV2RvUng4c2l4Y1dRWGdxRXVBTGtsRWt0eFZPQ0JyRXByV05rK2tkdVFR?=
 =?utf-8?B?ZktOR2xnbHZubXdtZlQ0VXRXVjM0UGxuMmtkQjI0bDVHaFpGejB6R24rL0ha?=
 =?utf-8?B?ZkNjVVh3U2xJUDU0REVDa2YzS0QvNlRHako2SWJocUFPRDh4TlMwbWczdTdq?=
 =?utf-8?B?TG10MlB5S0xzMFBDWlRBeHhwd2xnd2hSd1Y2eUN3N0JmOGVkQlVwc2JOa2hB?=
 =?utf-8?B?VkFRR2xCbGppY3pVeW50VUgrRmtvYlpkTkxvZG5hUXlFNExaRDFzVzV6R3dB?=
 =?utf-8?B?MmZ2V0xTaUYvTFY0UHZjR0cwZ0lnVXpLS3A0U2Q1U1BjazFLczJnMW45ZXhN?=
 =?utf-8?B?ZkVSQmxQcCtDR2RaUWRCbkhLOEtxUFcrOXcrbGRqeTRxL2NFLzZBd0QwMURi?=
 =?utf-8?B?d2VvMUZpeTI3VG4yaDdsL0pPdFh4cGQxampHbXBiY2ZCQjY0NG5yS2JOSFkr?=
 =?utf-8?B?RFRMbXRwMDJhTllFKy9ud1QyVDh6ZE4zRnlhOFVGWTFvWlBTN01ndjJrT2tl?=
 =?utf-8?B?YzRwUTdmUXk2MFk2YUVhQVFEVTBQRHg4UlpVSHZTNTc5S2VhKzAxNTdCYlRi?=
 =?utf-8?B?TFNOVmV4c3docWNrYUNERW1BeHovZGlwbVpZeTRhaWQyQ1dUNzNaeUZnK25H?=
 =?utf-8?B?Z1duQnhTb00vWHZWVkhDbTNqaEJNN1MvaWZvSzBRUzBPci9QU3NWZTh0K2N2?=
 =?utf-8?B?RTM0QXZwczFmYUpNL2xVSVdTSmwyb0IzOHhoakFQeVpsdng3UFFjZ3FqVENK?=
 =?utf-8?B?dzh3TktVbjg2M0hqbWlycXhQRWtOd3dGZWIwdGs4NFpsc0JFMU9ub1BnTkdq?=
 =?utf-8?B?NXRKdGR2UHpLZEZmUkxxN2FhQlhBaTgxYVd4NG80YjFCNnNvbmt4KzRnM1Aw?=
 =?utf-8?B?eFZEdENZV0lGMm8rbXMzdHB5d09jb3RlcW03eldybWp4UkNKYzNMTGRHcE5r?=
 =?utf-8?B?VmVqMEF5cWV2dlExQ3FDaXNZSEM3WEE2Z3NzTXhYZnhHUnIyYm5iYWduekF2?=
 =?utf-8?B?dk9sWmYwNGdQb1B0bEpzVXVNQmJNWCtrOFFKL1dXOVUxUjk5eFNXVUVtR21O?=
 =?utf-8?B?Qi8vbTA1Y2hCKyswSUdFOXVRVWlUc2NhZlhSRnhjTlNMcW93NXpPNWduVzF0?=
 =?utf-8?B?Sy9aeWk0RzJSVlJwdW9QdTF3eFJiZTIxTzhwWWhidDFuZlNzNlZHWG5ES3M1?=
 =?utf-8?B?RVV0ZDZwSWpqWmlDREZXTDJVSnVTdTJnTDduaDU5QWVWUGduQjlxcUxiRElS?=
 =?utf-8?B?UUVDeDJJN0ZWUzFjRy9NYVVNNkZoWGhqL1FNSUtleTk3Yk9MdVdCZDltSkMr?=
 =?utf-8?B?cDBpS0JKTzBvaVVqWG1KMWdHa1A3dU9rSEFiK1VxL1JBWlYzK2liUVI4QWFL?=
 =?utf-8?B?dy8zSEZrSXZBT0h5ZGdkVGl4R1JCZE5tcmJTMHhHU3FYeFR4ZnpVVnF0NGNL?=
 =?utf-8?B?Y1E5YVQybSsvTHpHMmtUNUF4NEVEdkU5QjNOVFVHdGZ5eVdVbkhheWJwWWhD?=
 =?utf-8?B?Q2k5N21tQmpJYWhtUk5uaVdINW1lNUduSnBNU0wvUFh4Yy80eTBUV1pOUG5h?=
 =?utf-8?B?YWYwNTNLbWp0aWt6aWErRC80SSs4OGx5NFNZUmhLMGpTdDV4SHNmelVNak01?=
 =?utf-8?B?eGMrU2FjbHg5ZTZ3c2VMTEhsZWJONmQyd2tQU3pBVThEOWdwMnJSVW5RdldB?=
 =?utf-8?B?cUF0Qm0rZlhxRExHUmJ4bllKVXZNUXpwWmdpYWU0TXIxTnRxNEJTanAvTDhW?=
 =?utf-8?B?dER4b3VhNWx1TFdpV1g3ODNDSXdYNXUzTFlrZlhCVFgyamtvTExEcURrcnlG?=
 =?utf-8?B?cm5WYWpQT2FiTzdaUS90SFZrVjROaThiK2NLRWt0blZNdncrcjVlWlhQTVF5?=
 =?utf-8?B?NlJRbmpoYUFLVTdKYUd4eStDM1Z3Y1lxdHB3cjBNeHE0ZFExVWo4a0s4WXJQ?=
 =?utf-8?B?SThLdWs5REpHTUQ4VDRjQmlmZmtXVUNJSjU1UEtFU2xiNStYdDJ3ZThaem1l?=
 =?utf-8?B?MG13dUI5VlBDSS9YaFU4bmxWeUVid0pSSDBHUjVIVFdGd1hQd3VETU4yWUhT?=
 =?utf-8?Q?HaUXUuy8J9NimyZxxMtpxQM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B80B74532F8D046874D8DEA6088BEF0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b7208-55e5-4add-a947-08d9da291961
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 02:20:30.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfSf+EH3LFTQoxiJBISIEN1Qy1apykuDL4oYYWk6s9Wwb4qIAIzM7m+lTfdA/UqqS41ccUO3Gf/kZO6V4ehnIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4226
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzE1IDExOjM4LCBZYW5qdW4gWmh1IHdyb3RlOg0KPg0KPiDlnKggMjAyMi8xLzEy
IDExOjU4LCB5YW5neC5qeUBmdWppdHN1LmNvbSDlhpnpgZM6DQo+PiBPbiAyMDIyLzEvMTIgOTox
OSwgWWFuanVuIFpodSB3cm90ZToNCj4+PiDlnKggMjAyMi8xLzExIDIzOjE2LCBIYWFrb24gQnVn
Z2Ug5YaZ6YGTOg0KPj4+Pj4gT24gMTEgSmFuIDIwMjIsIGF0IDE1OjQyLCBZYW5qdW4gWmh1IDx5
YW5qdW4uemh1QGxpbnV4LmRldj4gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IOWcqCAyMDIy
LzEvMTAgMTM6MTcsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIOWGmemBkzoNCj4+Pj4+PiBPbiAyMDIy
LzEvNyAxOTo0OSwgWWFuanVuIFpodSB3cm90ZToNCj4+Pj4+Pj4gSXQgc2VlbXMgdGhhdCBpdCBk
b2VzIG5vdCBtZWFuIHRvIGNoZWNrIHRoZSBsYXN0IHBhY2tldC4gSXQgbWVhbnMNCj4+Pj4+Pj4g
dGhhdA0KPj4+Pj4+PiBpdCByZWNlaXZlcyBhIE1TTiByZXNwb25zZS4NCj4+Pj4+PiBIaSBZYW5q
dW4sDQo+Pj4+Pj4NCj4+Pj4+PiBDaGVja2luZyB0aGUgbGFzdCBwYWNrZXQgaXMgYSB3YXkgdG8g
aW5kaWNhdGUgdGhhdCByZXNwb25kZXIgaGFzDQo+Pj4+Pj4gY29tcGxldGVkIGFuIGVudGlyZSBy
ZXF1ZXN0KGluY2x1ZGluZyBtdWx0aXBsZSBwYWNrZXRzKSBhbmQgdGhlbg0KPj4+Pj4+IGluY3Jl
YXNlcyBhIG1zbi4NCj4+Pj4+IEhpLCBYaWFvDQo+Pj4+Pg0KPj4+Pj4gV2hhdCBkb2VzIHRoZSBt
c24gbWVhbj8NCj4+Pj4gTWVzc2FnZSBTZXF1ZW5jZSBOdW1iZXIuDQo+Pj4gVGhhbmtzLCBIYWFr
b24NCj4+Pg0KPj4+IEkgYW0gcmVhZGluZyB0aGUgZm9sbG93aW5nIGZyb20gdGhlIHNwZWMuDQo+
Pj4NCj4+PiAiDQo+Pj4NCj4+PiBDOS0xNDg6IEFuIEhDQSByZXNwb25kZXIgdXNpbmcgUmVsaWFi
bGUgQ29ubmVjdGlvbiBzZXJ2aWNlIHNoYWxsDQo+Pj4gaW5pdGlhbGl6ZQ0KPj4+DQo+Pj4gaXRz
IE1TTiB2YWx1ZSB0byB6ZXJvLiBUaGUgcmVzcG9uZGVyIHNoYWxsIGluY3JlbWVudCBpdHMgTVNO
DQo+Pj4gd2hlbmV2ZXIgaXQgaGFzIHN1Y2Nlc3NmdWxseSBjb21wbGV0ZWQgcHJvY2Vzc2luZyBh
IG5ldywgdmFsaWQgcmVxdWVzdA0KPj4+IG1lc3NhZ2UuIFRoZSBNU04gc2hhbGwgbm90IGJlIGlu
Y3JlbWVudGVkIGZvciBkdXBsaWNhdGUgcmVxdWVzdHMuIFRoZQ0KPj4+IGluY3JlbWVudGVkIE1T
TiBzaGFsbCBiZSByZXR1cm5lZCBpbiB0aGUgbGFzdCBvciBvbmx5IHBhY2tldCBvZiBhbiBSRE1B
DQo+Pj4gUkVBRCBvciBBdG9taWMgcmVzcG9uc2UuIEZvciBSRE1BIFJFQUQgcmVxdWVzdHMsIHRo
ZSByZXNwb25kZXINCj4+PiBtYXkgaW5jcmVtZW50IGl0cyBNU04gYWZ0ZXIgaXQgaGFzIGNvbXBs
ZXRlZCB2YWxpZGF0aW5nIHRoZSByZXF1ZXN0IGFuZA0KPj4+IGJlZm9yZSBpdCBoYXMgYmVndW4g
dHJhbnNtaXR0aW5nIGFueSBvZiB0aGUgcmVxdWVzdGVkIGRhdGEsIGFuZCBtYXkNCj4+PiByZXR1
cm4NCj4+PiB0aGUgaW5jcmVtZW50ZWQgTVNOIGluIHRoZSBBRVRIIG9mIHRoZSBmaXJzdCByZXNw
b25zZSBwYWNrZXQuIFRoZSBNU04NCj4+PiBzaGFsbCBiZSBpbmNyZW1lbnRlZCBvbmx5IG9uY2Ug
Zm9yIGFueSBnaXZlbiByZXF1ZXN0IG1lc3NhZ2UuDQo+Pj4NCj4+PiAiDQo+Pj4NCj4+PiBJdCBz
ZWVtcyB0aGF0IHRoZSBhYm92ZSBkZXNjcmliZSBob3cgdG8gaGFuZGxlIE1TTiBpbmNyZW1lbnQg
aW4gDQo+Pj4gZGV0YWlscy4NCj4+IEhpIFlhbmp1biwNCj4+DQo+PiBTb3JyeSBmb3IgdGhlIGxh
dGUgcmVwbHkuDQo+Pg0KPj4gUmlnaHQsIDkuNy43LjEgR0VORVJBVElORyBNU04gVkFMVUUgc2Vj
dGlvbiBleHBsYWlucyBNZXNzYWdlIFNlcXVlbmNlDQo+DQo+IERvZXMgeW91ciBjb21taXQgdGFr
ZSBpbnRvIGFjY291bnQgb2YgZHVwbGljYXRlIHJlcXVlc3RzPw0KSGkgWWFuanVuLA0KDQpSZXNw
b25kZXIgd2lsbCBjaGVjayBkdXBsaWNhdGUgcmVxdWVzdHMgYnkgY2hlY2tfcHNuKCkgYW5kIHBy
b2Nlc3MgdGhlbSANCmJ5IGR1cGxpY2F0ZV9yZXF1ZXN0KCkuDQpBY2NvcmRpbmcgdG8gdGhlIGxv
Z2ljIG9mIGR1cGxpY2F0ZV9yZXF1ZXN0KCksIHJlc3BvbmRlciBkb2Vzbid0IA0KaW5jcmVhc2Ug
bXNuIGZvciBkdXBsaWNhdGUgcmVxdWVzdHMuDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0K
Pg0KPiBaaHUgWWFuanVuDQo+DQo+PiBOdW1iZXIoTVNOKS4NCj4+DQo+PiBCZXN0IFJlZ2FyZHMs
DQo+PiBYaWFvIFlhbmcNCj4+PiBaaHUgWWFuanVuDQo+Pj4NCj4+Pj4NCj4+Pj4gVGh4cywgSMOl
a29uDQo+Pj4+DQo+Pj4+PiBUaGFua3MgYSBsb3QuDQo+Pj4+Pg0KPj4+Pj4gWmh1IFlhbmp1bg0K
Pj4+Pj4NCj4+Pj4+PiBCZXN0IFJlZ2FyZHMsDQo+Pj4+Pj4gWGlhbyBZYW5nDQo=
