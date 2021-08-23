Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9653F4409
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 05:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhHWD7K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 23:59:10 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:57440 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbhHWD7J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Aug 2021 23:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629691109; x=1661227109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ztnhWzjyC4gBWa5I6Tj1EnCPONn2vt/5FvOiUXGsPzU=;
  b=mwr/oOVo3deOhkrpNlYh8gTC+1/oxT0FgyMTarPT2WJjgmnFV1QgGtAs
   ec3TsdMH86YlHOk7rga8cblYjBaWAnFnTzmXcJq975jBKBvSm9AcKE6aN
   KLLKNrjhcYzZGRHivQ1cqkQ025iheES6UPs7ZBcyOSmTeTsZMys8wdHBf
   ++CvDXARLbQ6K7fEBy3bW7jFlHNEuT6xd2e0blitsq14hxdzs9x6b6A1a
   9OTIZkV4vntWgYiodIwmOQ6FMn+/kOpnqTeBNOAGqDywXEv09SV/qq5js
   CztQDOIRRKFU2xQ+CY5Wlrz70Rih3RIJhCwR0roWDVzWGpgoSELFssI7g
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="45495202"
X-IronPort-AV: E=Sophos;i="5.84,343,1620658800"; 
   d="scan'208";a="45495202"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 12:58:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWr9t3j5cPHGMMQQkz4YX5j0jrvD9uGv1NxsHuq4rXmnjg0gnf0eL8UNok1D0im0MrtKZhHXxk09Ch5a6M3iUgnFb+FXaIiUcYlf5TUEYSnkYOiipWOrF/Hyc+rcenesPiO26xEqQlLA9XXqzTt/2Mrh6JfoBKwecsRsy5B7Eu57ys5NY/bA7h90ncOLn/xqQHF9v+XfiHP1i1uvCXEfdd3FZ9MJOfvSutwlzzckBlQ83kGpeUDXhrd3e/lqLb2fqatAPWGwyTm9rBNids04Bd9L14AjWEGS02mcywvRw6/0FcMiY/IuF4vm+JbG+xmzJ1MXhidLPgTVsyzcYfgVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztnhWzjyC4gBWa5I6Tj1EnCPONn2vt/5FvOiUXGsPzU=;
 b=ededxznKEm+a/X8bNGNRc1mqVi0U/XaGfrqyW7VT+DkVNQZ0bewqLOhNUHz+Kgt6wkIxgV3umA0PNGqFkft4xltxJGyZ6ouuzkYx25Rxyach+HOOgLTXCHdmGznKdPfnTj96lICktId56DmC7jrBITjBDLJnrZjpi1EM0mOIihfucEZHWYM9+kD03ZdKdrf7EJeMfW05LtU/IyUHwMKWhe/bT2hH6IgB6llHVHL1FzeFsxOK95auaObv9TpWfCzcIX63q2a6xPA1Cs4CySCYEM1PySnFOHP9bPHITRmIYCIuip3DScV+gC+nvyiEKpu/3U/XXHewy0INJ/9gUaaJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztnhWzjyC4gBWa5I6Tj1EnCPONn2vt/5FvOiUXGsPzU=;
 b=GX49jzAUM0D2y5L2WRUxMmH9MgJJWbfjdWOrKk7OI/ypIDH1+t7pDXZLYsZsc5agLFKFegxrqAFKQ1II9LEUi5n2xXfCtW1zHiLex8Bfs8uSjZuCu5PkVTshU1B9tmTLPQv7SE/GiE0VJMnrFMgR9dmCEV370hxhhia01v8uwiI=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB3761.jpnprd01.prod.outlook.com (2603:1096:604:52::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 03:58:21 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 03:58:21 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Topic: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Index: AQHXjSu/7XTFLNlnDk+JDe1qihCp9qtsGJsAgADXggCACNuAAIABHv8AgAmMqoCAABSZgA==
Date:   Mon, 23 Aug 2021 03:58:21 +0000
Message-ID: <61231CDB.4010602@fujitsu.com>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <CAD=hENd6StySon04rW1CPeJbN1KFPDDP1JFsYNBxXNYYegtF5A@mail.gmail.com>
 <6112A9FA.2050300@fujitsu.com>
 <CAD=hENdB6chvVtzgcYunhTNuHDGbYi8=ePnGKhOwuF83HY8O1w@mail.gmail.com>
 <611B08D8.90605@fujitsu.com>
 <CAD=hENeOka=Fm5WqyFK3mY27t8wRqt4uZ0gQ5GJ027KhZcQVuQ@mail.gmail.com>
In-Reply-To: <CAD=hENeOka=Fm5WqyFK3mY27t8wRqt4uZ0gQ5GJ027KhZcQVuQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a365d230-02d7-4998-0342-08d965ea3fe8
x-ms-traffictypediagnostic: OSAPR01MB3761:
x-microsoft-antispam-prvs: <OSAPR01MB37614906BA62EC5087EE832C83C49@OSAPR01MB3761.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xL1+YPMdMFYdvmFDcdB3/EfkvDUuVt3jxt75HmMehQV4Xj/eNegjQGUMe7/NSv0YxLbriGKP0drltwhTB7qW4sFZhOqSbhEVQAXQyGbXy73J49DfJ2Zr+17ctztSoWG15Pc7IhnfVnJbY4ozsPwV8z4BIiSDxC5rRMmZti/wV1+e55NhRLL79IyggNNF3iGW+YaiBpdOukL/sydXNkc1pBnF9snSNcJ75bF44klgT8SAxOfO+DP9bhTk4bZK8LyiGU5vcvelIe5bP9SdYcyZrmuQUGmDyiEHeVdqX0GGfRdgLcJHZgQnf/j/ZrpkjL0AdqhBuA1xEO5z3o/i5gMVevWhrE7gFpt3lgBORT0un2a10pvLqBnviyEGav1U8H8bZPnks7C3hJvS/YPcxOsM3KYG+un1uaajtoSfB3QD6En7TUvXA8vn4pVqACH5p6qZ2ifrWBExk9xQrlWxboDEJEn/9K1MWT1xGLkWKzCJsXeyhkWdju6znGxEHlTICxz7f//e9ztrsRH3bYhOg1rmlyiIaDBJ+jNmSs7zM81OyAXYuSU+hecyMqOJMB4SAaBxuXY2c1fagMR9HooTXZBHf5uPoYNHky02HNACTpyG2j/d5pTu40IczRqeljcT7YptxkVlahI93TpqjDx20VSsj0mjv7bGPxaYdzWCeXlpLulUwGvXBIDwVC0Ux69K1C4gxVf+dvjnywQUqkttk/Es+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(33656002)(38070700005)(83380400001)(186003)(6916009)(8676002)(6512007)(5660300002)(54906003)(85182001)(66556008)(71200400001)(2616005)(2906002)(6486002)(316002)(53546011)(87266011)(6506007)(38100700002)(36756003)(26005)(8936002)(76116006)(91956017)(478600001)(66446008)(64756008)(66946007)(66476007)(122000001)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d01SZmlCQzhPZk9GT1lpdUc4ZFJTdlJHWURnQi9kRDlzWUoxV0VVUVNrWTd6?=
 =?utf-8?B?ekZZWFZBMnhiay9JZ09NNVBsMWlqQ3FnM1IxMk5JUFBHaHM0Vi9lSk9BV2M0?=
 =?utf-8?B?aG91WFpMcmFpbVNVdnB5MmxWK0I3WDNqTzBnWUg5UEJnY3kxeU1kTHVSekZa?=
 =?utf-8?B?MUhtOVl4UlY1QWgrbnNaV3I0ZHByZUxrd0Q3dFNTeVRsRXNCYzRxRTVDdDND?=
 =?utf-8?B?K09xSUtXQkVmNXFSeFZDZXNnc2wvNXQ2MG1wUGNweEl4L0dpM3dhTTNxWmJD?=
 =?utf-8?B?eGplQTU5SUFWcmZLRlg1WEI3dGVCQlNrL3RwWVZOUUVVUVhhTFVZYzd2bWNR?=
 =?utf-8?B?bkhwOWk1dE1sN2trWGNycTUvYmY1MDNQVGVRQVl5U21PekZDWjJJY2hDaVBZ?=
 =?utf-8?B?OWxpVFo4cks2Z21ONGNXdU5MZUNWQ2orWEJTUFBYb0RYWENiaXVORnFOS1R1?=
 =?utf-8?B?K1NNUnJrYzZjM3RnM1c4bTJnS1RjaTZKckp1d09ycjQ2QkV3S1plUXlzT2tP?=
 =?utf-8?B?Sm16U3gvbEVZeTYxNi9mOFliVXZ5OUN1WHRaUTJHOUpMaUJiMENYL25MUFNV?=
 =?utf-8?B?c3BuVmJPOThjY0YrVVdrNXhscmdNcXR6c0UyVEMzNEZ0Y2txNUQyeS9nQTZR?=
 =?utf-8?B?cGQwYSt4UG9pMWJSM0xoQndSWW50VFcyNDNQQnZpMSsxSnp6OURxVEJyRVdj?=
 =?utf-8?B?Ry9GSkZBNUlXMmM2SzB4UUk1NE9nTTE4aHc4S2VBejdsSVZXSnpIVDNtck9N?=
 =?utf-8?B?ekt2SHdUUDlkVXRuS1dCL0dtdDUzZ3pGUm5iREhEdmxsVVRla3lMVDRwaEVa?=
 =?utf-8?B?REV0VmYrQ1dkMkVNRE1Jdjh0cTBCTi9NTWU1d3BNSFZxZlZweUg5LzY3eGgv?=
 =?utf-8?B?OFZhcGRNSkQ0R2lGdXhqa2pjeDA2dEQ0SjBaUXFrMG91RXY1bjFHc2VCdjVG?=
 =?utf-8?B?TzdaV1NPVXU4WmVSRUxjWk1QamZ2NnhHQ1kwRkk2K0s5Y3lubkNTS3RXN2Mz?=
 =?utf-8?B?WFdFeTZlWUI2dWxDTjdsR2k2QlVHNTE2L0ZjMUM1aEc2S2JKUUhLajZjanpL?=
 =?utf-8?B?WXpselFPMGVNSjJEZCt4WWJzYlMxaEpMZ3BNQ1piWitBQS95MklVTkVIQWNO?=
 =?utf-8?B?L3F1OURtTXZMc2pwZkZPMFRCcVl6ZFJsQnNqRnFiRGI5TjVsSmlOTDFPcUxU?=
 =?utf-8?B?S2tXaStCTGRFRS9qWnk2cU00UGE0RzlLYStYL1BhZTJ5aTZqU0JUVmdXcGR5?=
 =?utf-8?B?QmpoNFRzeUFBK3hxcm5UTHhBakJMYVZTSEZDOGhzSmwyaHNZQVVPV3pDWHBr?=
 =?utf-8?B?M1hzZ1FibUpSaVBKcldlaFg4Z0tIcmRscUVWNDkwV3ZJeHpwUU50b3dwVmxD?=
 =?utf-8?B?dUsxUGg5SWxSbHR4dWlVM3lnUDVpQ0VMTUlYMDZoaTB1ckRRMlBPZ3FXSjlC?=
 =?utf-8?B?V09ZRFp1MFF6UjVEWndJVkpxU2hzRk91TFZFUzI5UDNoaUJ3QkZiV0lVSDV6?=
 =?utf-8?B?UnQzeHE2byt4aisxSnQ3UTVPMGEyaURsazBXS3NTeVRFU2YwR1loczM0Skpj?=
 =?utf-8?B?MUxzVWc4aFFwbDlydkFMTVovQjNqZnBPVUhQeldSZEJDMTFRZ2kwcUlsYXVQ?=
 =?utf-8?B?NytsQzlFWnFoaU5xb1owbmY4cGx1WVRJcE56bkcrWDhZcHhlMHo3VWk3SHZN?=
 =?utf-8?B?b3BQNU5xWGthdWRJUzBOWE80UWJGc203d0hTNC9GcFRRRlU4SmdUMEloMTFH?=
 =?utf-8?Q?XUvGiR/0AaEZtNTud5TehRww/8o0gBDjcMO/v25?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <59CD0089B487894B97D7F3B03921E9F4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a365d230-02d7-4998-0342-08d965ea3fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 03:58:21.7980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvg1/zj/1qHwvtbdWbt09FHS4mqIXqM7HGLyYMP3/RbtTRuGFyJkBtafojfgUFepH3ZM/gl70p/WRMTGZWoBVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3761
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

5LqOIDIwMjEvOC8yMyAxMDo0NCwgWmh1IFlhbmp1biDlhpnpgZM6DQo+IE9uIFR1ZSwgQXVnIDE3
LCAyMDIxIGF0IDg6NTQgQU0geWFuZ3guanlAZnVqaXRzdS5jb20NCj4gPHlhbmd4Lmp5QGZ1aml0
c3UuY29tPiAgd3JvdGU6DQo+PiBPbiAyMDIxLzgvMTYgMTU6NDcsIFpodSBZYW5qdW4gd3JvdGU6
DQo+Pj4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMTI6MzMgQU0geWFuZ3guanlAZnVqaXRzdS5j
b20NCj4+PiA8eWFuZ3guanlAZnVqaXRzdS5jb20+ICAgd3JvdGU6DQo+Pj4+IE9uIDIwMjEvOC8x
MCAxMTo0MCwgWmh1IFlhbmp1biB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgQXVnIDksIDIwMjEgYXQg
MTA6NDMgUE0gWGlhbyBZYW5nPHlhbmd4Lmp5QGZ1aml0c3UuY29tPiAgIHdyb3RlOg0KPj4+Pj4+
IFJlc2lkIGluZGljYXRlcyB0aGUgcmVzaWR1YWwgbGVuZ3RoIG9mIHRyYW5zbWl0dGVkIGJ5dGVz
IGJ1dCBjdXJyZW50DQo+Pj4+Pj4gcnhlIHNldHMgaXQgdG8gemVybyBmb3IgaW5saW5lIGRhdGEg
YXQgdGhlIGJlZ2lubmluZy4gIEluIHRoaXMgY2FzZSwNCj4+Pj4+PiByZXF1ZXN0IHdpbGwgdHJh
bnNtaXQgemVybyBieXRlIHRvIHJlc3BvbmRlciB3cm9uZ2x5Lg0KPj4+Pj4gV2hhdCBhcmUgdGhl
IHN5bXB0b21zIGlmIHJlc2lkIGlzIHNldCB0byB6ZXJvPw0KPj4+PiBIaSBZYW5qdW4sDQo+Pj4+
DQo+Pj4+IFlvdSBjYW4gY29uc3RydWN0IGNvZGUgYnkgdGhlIGF0dGFjaGVkIHBhdGNoIGFuZCB0
aGVuIHJ1bg0KPj4+PiByZG1hX2NsaWVudC9zZXJ2ZXIgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZS4N
Cj4+Pj4NCj4+Pj4gSWYgcmVzaWQgaXMgc2V0IHRvIHplcm8sIHJ1bm5pbmcgcmRtYV9jbGllbnQv
c2VydmVyOg0KPj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiAjIC4v
cmRtYV9jbGllbnQgLXMgMTAuMTY3LjIyMC45OSAtcCA4NzY1DQo+Pj4+IHJkbWFfY2xpZW50OiBz
dGFydA0KPj4+PiByZG1hX2NsaWVudDogZW5kIDANCj4+Pj4NCj4+Pj4gIyAuL3JkbWFfc2VydmVy
IC1zIDEwLjE2Ny4yMjAuOTkgLXAgODc2NQ0KPj4+PiByZG1hX3NlcnZlcjogc3RhcnQNCj4+Pj4g
d2MuYnl0ZV9sZW4gMCByZWN2X21zZyBiYmJiYmJiYmJiYmJiYmJiDQo+Pj4+IHJkbWFfc2VydmVy
OiBlbmQgMA0KPj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pg0KPj4+
PiByZG1hX2NsaWVudCBzZW5kcyB6ZXJvIGJ5dGUgaW5zdGVhZCBvZiAxNiBidHllcyB0byByZG1h
X3NlcnZlci4NCj4+Pj4gcmRtYV9zZXJ2ZXIgcmVjZWl2ZXMgemVybyBieXRlIGluc3RlYWQgb2Yg
MTYgYnR5ZXMgZnJvbSByZG1hX2NsaWVudC4NCj4+Pj4NCj4+Pj4gUGxlYXNlIGFsc28gc2VlIHRo
ZSBsb2dpYyBhYm91dCByZXNpZCBpbiBrZXJuZWwsIGZvciBleGFtcGxlOg0KPj4+PiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiBpbnQgcnhlX3JlcXVlc3Rlcih2b2lkICph
cmcpDQo+Pj4+IHsNCj4+Pj4gLi4uDQo+Pj4+IHBheWxvYWQgPSAobWFzayYgICBSWEVfV1JJVEVf
T1JfU0VORCkgPyB3cWUtPmRtYS5yZXNpZCA6IDA7DQo+Pj4+IC4uLg0KPj4+PiBza2IgPSBpbml0
X3JlcV9wYWNrZXQocXAsIHdxZSwgb3Bjb2RlLCBwYXlsb2FkLCZwa3QpOw0KPj4+PiAuLi4NCj4+
Pj4gfQ0KPj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pg0KPj4+PiBC
ZXN0IFJlZ2FyZHMsDQo+Pj4+IFhpYW8gWWFuZw0KPj4+IEZvbGxvdyB5b3VyIHN0ZXBzIG9uIHRo
ZSBsYXRlc3QgcmRtYS1jb3JlIGFuZCBsaW51eCB1cHN0cmVhbSwNCj4+PiBtYWtlIHRlc3RzIHdp
dGggdGhlIGZvbGxvd2luZ3M6DQo+Pj4gIg0KPj4+IGRpZmYgLS1naXQgYS9saWJyZG1hY20vZXhh
bXBsZXMvcmRtYV9jbGllbnQuYyBiL2xpYnJkbWFjbS9leGFtcGxlcy9yZG1hX2NsaWVudC5jDQo+
Pj4gaW5kZXggYzI3MDQ3YzUuLjY3MzQ3NTdiIDEwMDY0NA0KPj4+IC0tLSBhL2xpYnJkbWFjbS9l
eGFtcGxlcy9yZG1hX2NsaWVudC5jDQo+Pj4gKysrIGIvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFf
Y2xpZW50LmMNCj4+PiBAQCAtNTIsNiArNTIsNyBAQCBzdGF0aWMgaW50IHJ1bih2b2lkKQ0KPj4+
ICAgICAgICAgICBzdHJ1Y3QgaWJ2X3djIHdjOw0KPj4+ICAgICAgICAgICBpbnQgcmV0Ow0KPj4+
DQo+Pj4gKyAgICAgICBtZW1zZXQoc2VuZF9tc2csICdhJywgMTYpOw0KPj4+ICAgICAgICAgICBt
ZW1zZXQoJmhpbnRzLCAwLCBzaXplb2YgaGludHMpOw0KPj4+ICAgICAgICAgICBoaW50cy5haV9w
b3J0X3NwYWNlID0gUkRNQV9QU19UQ1A7DQo+Pj4gICAgICAgICAgIHJldCA9IHJkbWFfZ2V0YWRk
cmluZm8oc2VydmVyLCBwb3J0LCZoaW50cywmcmVzKTsNCj4+PiBkaWZmIC0tZ2l0IGEvbGlicmRt
YWNtL2V4YW1wbGVzL3JkbWFfc2VydmVyLmMgYi9saWJyZG1hY20vZXhhbXBsZXMvcmRtYV9zZXJ2
ZXIuYw0KPj4+IGluZGV4IGY5Yzc2NmIyLi5hZmEyMDk5NiAxMDA2NDQNCj4+PiAtLS0gYS9saWJy
ZG1hY20vZXhhbXBsZXMvcmRtYV9zZXJ2ZXIuYw0KPj4+ICsrKyBiL2xpYnJkbWFjbS9leGFtcGxl
cy9yZG1hX3NlcnZlci5jDQo+Pj4gQEAgLTEzMiw2ICsxMzIsNyBAQCBzdGF0aWMgaW50IHJ1bih2
b2lkKQ0KPj4+ICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2Rpc2Nvbm5lY3Q7DQo+Pj4gICAg
ICAgICAgIH0NCj4+Pg0KPj4+ICsgICAgICAgcHJpbnRmKCJ3Yy5ieXRlX2xlbiAldSByZWN2X21z
ZyAlc1xuIiwgd2MuYnl0ZV9sZW4sIHJlY3ZfbXNnKTsNCj4+PiAgICAgICAgICAgcmV0ID0gcmRt
YV9wb3N0X3NlbmQoaWQsIE5VTEwsIHNlbmRfbXNnLCAxNiwgc2VuZF9tciwgc2VuZF9mbGFncyk7
DQo+Pj4gICAgICAgICAgIGlmIChyZXQpIHsNCj4+PiAgICAgICAgICAgICAgICAgICBwZXJyb3Io
InJkbWFfcG9zdF9zZW5kIik7DQo+Pj4gIg0KPj4+IFRoZSBmb2xsb3dpbmdzIGFyZSByZXN1bHRz
Og0KPj4+DQo+Pj4gIyAuL2J1aWxkL2Jpbi9yZG1hX3NlcnZlciAtcyAxMC4yMzguMTU0LjYxIC1w
IDU0ODYmDQo+Pj4gWzFdIDEwODEyDQo+Pj4gIyByZG1hX3NlcnZlcjogc3RhcnQNCj4+Pg0KPj4+
ICMgLi9idWlsZC9iaW4vcmRtYV9jbGllbnQgLXMgMTAuMjM4LjE1NC42MSAtcCA1NDg2Jg0KPj4+
IFsyXSAxMDgxNQ0KPj4+ICMgcmRtYV9jbGllbnQ6IHN0YXJ0DQo+Pj4gd2MuYnl0ZV9sZW4gMTYg
cmVjdl9tc2cgYWFhYWFhYWFhYWFhYWFhYTwtLS0tLS0tLS0tLS0tLWl0IHNlZW1zDQo+Pj4gdGhh
dCBpbmxpbmUgaXMgMTY/DQo+Pj4gcmRtYV9zZXJ2ZXI6IGVuZCAwDQo+Pj4gcmRtYV9jbGllbnQ6
IGVuZCAwDQo+Pj4gWzFdLSAgRG9uZSAgICAgICAgICAgICAgICAgICAgLi9idWlsZC9iaW4vcmRt
YV9zZXJ2ZXIgLXMgMTAuMjM4LjE1NC42MSAtcCA1NDg2DQo+Pj4gWzJdKyAgRG9uZSAgICAgICAg
ICAgICAgICAgICAgLi9idWlsZC9iaW4vcmRtYV9jbGllbnQgLXMgMTAuMjM4LjE1NC42MSAtcCA1
NDg2DQo+Pj4NCj4+PiBXaGF0IGRvZXMgeW91ciBjb21taXQgZml4Pw0KPj4gSGkgWWFuanVuLA0K
Pj4NCj4+IFlvdSBtaXNzZWQgdGhlIGNoYW5nZSB0aGF0IHNldHMgcmVzaWQgdG8gemVybyBvbiBw
dXJwb3NlOg0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9wcm92aWRlcnMvcnhlL3J4ZS5j
IGIvcHJvdmlkZXJzL3J4ZS9yeGUuYw0KPj4gaW5kZXggM2MzZWE4YmIuLmVkNTQ3OWZlIDEwMDY0
NA0KPj4gLS0tIGEvcHJvdmlkZXJzL3J4ZS9yeGUuYw0KPj4gKysrIGIvcHJvdmlkZXJzL3J4ZS9y
eGUuYw0KPj4gQEAgLTE0OTIsNyArMTQ5Miw3IEBAIHN0YXRpYyBpbnQgaW5pdF9zZW5kX3dxZShz
dHJ1Y3QgcnhlX3FwICpxcCwgc3RydWN0IHJ4ZV93cSAqc3EsDQo+PiAgICAgICAgICAgICAgICAg
IHdxZS0+aW92YSAgICAgICA9IGlid3ItPndyLnJkbWEucmVtb3RlX2FkZHI7DQo+Pg0KPj4gICAg
ICAgICAgd3FlLT5kbWEubGVuZ3RoICAgICAgICAgPSBsZW5ndGg7DQo+PiAtICAgICAgIHdxZS0+
ZG1hLnJlc2lkICAgICAgICAgID0gbGVuZ3RoOw0KPj4gKyAgICAgICB3cWUtPmRtYS5yZXNpZCAg
ICAgICAgICA9IDA7DQo+PiAgICAgICAgICB3cWUtPmRtYS5udW1fc2dlICAgICAgICA9IG51bV9z
Z2U7DQo+PiAgICAgICAgICB3cWUtPmRtYS5jdXJfc2dlICAgICAgICA9IDA7DQo+PiAgICAgICAg
ICB3cWUtPmRtYS5zZ2Vfb2Zmc2V0ICAgICA9IDA7DQo+Pg0KPj4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gTm90ZToNCj4+
IEl0IGlzIGFsc28gb2sgdG8gcmVtb3ZlICJ3cWUtPmRtYS5yZXNpZCA9IGxlbmd0aCIgaGVyZSBi
ZWNhdXNlIHJlc2lkIGhhcw0KPj4gYmVlbiBzZXQgdG8gemVybyBiZWZvcmUuDQo+Pg0KPj4gV2l0
aCB0aGUgY2hhbmdlLCBydW5uaW5nIHJkbWFfY2xpZW50L3NlcnZlciB3aWxsIHNob3cgdGhlIGlt
cGFjdC4NCj4gV2l0aCB0aGUgb3JpZ2luYWwgc291cmNlIGNvZGUsIHRoZSByZG1hX3NlcnZlci9y
ZG1hX2NsaWVudCBjYW4gd29yayB3ZWxsLg0KPg0KPiBXaHkgIndxZS0+ZG1hLnJlc2lkICAgICAg
ICAgID0gbGVuZ3RoOyIgaXMgcmVwbGFjZWQgYnkgIndxZS0+ZG1hLnJlc2lkDQo+ICAgICAgICAg
ICA9IDA7IiwgdGhlbiB0aGlzIHByb2JsZW0gYXBwZWFycz8NCkhpIFlhbmp1biwNCg0KVGhlIG9y
aWdpbmFsIHNvdXJjZSBjb2RlIGhhcyB0aGUgZm9sbG93aW5nIGxvZ2ljOg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCnN0YXRpYyBpbnQgaW5pdF9zZW5kX3dxZSguLi4pDQp7DQogICAg
IC4uLg0KICAgICBpZiAoaWJ3ci0+c2VuZF9mbGFncyAmIElCVl9TRU5EX0lOTElORSkgew0KICAg
ICAgICAgLi4uDQogICAgICAgICAgd3FlLT5kbWEucmVzaWQgPSAwOw0KICAgICAgICAgLi4uDQog
ICAgIH0NCiAgICAgLi4uDQogICAgIHdxZS0+ZG1hLnJlc2lkID0gbGVuZ3RoOw0KICAgICAuLi4N
Cn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpGb3IgaW5saW5lIGRhdGEgZmxhZywg
cmVzaWQgaXMgc2V0IHRvIHplcm8gZmlyc3QgYW5kIHRoZW4gcmVwbGFjZWQgd2l0aCANCmxlbmd0
aCBhdCBzdWJzZXF1ZW50IHN0ZXBzLiBJbiB0aGlzIGNhc2UsIHRoZSBpc3N1ZSBkb2Vzbid0IGFw
cGVhci4NCk15IHBhdGNoIHJlbW92ZXMgdGhlIHVzZWxlc3MgIndxZS0+ZG1hLnJlc2lkID0gMCIg
YW5kIHNldHMgdGhlIGNvcnJlY3QgDQoid3FlLT5kbWEucmVzaWQgPSBsZW5ndGgiIGZvciBuZXcg
aW5saW5lX2RhdGEgQVBJcy4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IFRoYW5rcw0K
PiBaaHUgWWFuanVuDQo+DQo+DQo+PiBJIGRpZG4ndCB1c2UgbmV3IEFQSShlLmcuIGlidl93cl9z
ZXRfaW5saW5lX2RhdGEsIGlidl93cl9zZW5kKSB0byBjcmVhdGUNCj4+IGEgbmV3IHRlc3QNCj4+
IGJ1dCBpdCBpcyBlbm91Z2ggdG8gc2hvdyB0aGUgaW1wYWN0IG9mIHJlc2lkID09IDAgYnkgZG9p
bmcgc29tZSBjaGFuZ2VzDQo+PiBvbiByeGUgYW5kDQo+PiByZG1hX2NsaWVudC9zZXJ2ZXIuDQo+
Pg0KPj4gQmVzdCBSZWdhcmRzLA0KPj4gWGlhbyBZYW5nDQo+Pj4gWmh1IFlhbmp1bg0KPj4+DQo+
Pj4+PiBUaGFua3MNCj4+Pj4+IFpodSBZYW5qdW4NCj4+Pj4+DQo+Pj4+Pj4gUmVzaWQgc2hvdWxk
IGJlIHNldCB0byB0aGUgdG90YWwgbGVuZ3RoIG9mIHRyYW5zbWl0dGVkIGJ5dGVzIGF0IHRoZQ0K
Pj4+Pj4+IGJlZ2lubmluZy4NCj4+Pj4+Pg0KPj4+Pj4+IE5vdGU6DQo+Pj4+Pj4gSnVzdCByZW1v
dmUgdGhlIHVzZWxlc3Mgc2V0dGluZyBvZiByZXNpZCBpbiBpbml0X3NlbmRfd3FlKCkuDQo+Pj4+
Pj4NCj4+Pj4+PiBGaXhlczogMWE4OTRjYTEwMTA1ICgiUHJvdmlkZXJzL3J4ZTogSW1wbGVtZW50
IGlidl9jcmVhdGVfcXBfZXggdmVyYiIpDQo+Pj4+Pj4gRml4ZXM6IDgzMzdkYjVkZjEyNSAoIlBy
b3ZpZGVycy9yeGU6IEltcGxlbWVudCBtZW1vcnkgd2luZG93cyIpDQo+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWGlhbyBZYW5nPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+
ICAgIHByb3ZpZGVycy9yeGUvcnhlLmMgfCA1ICsrLS0tDQo+Pj4+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYg
LS1naXQgYS9wcm92aWRlcnMvcnhlL3J4ZS5jIGIvcHJvdmlkZXJzL3J4ZS9yeGUuYw0KPj4+Pj4+
IGluZGV4IDNjM2VhOGJiLi4zNTMzYTMyNSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9wcm92aWRlcnMv
cnhlL3J4ZS5jDQo+Pj4+Pj4gKysrIGIvcHJvdmlkZXJzL3J4ZS9yeGUuYw0KPj4+Pj4+IEBAIC0x
MDA0LDcgKzEwMDQsNyBAQCBzdGF0aWMgdm9pZCB3cl9zZXRfaW5saW5lX2RhdGEoc3RydWN0IGli
dl9xcF9leCAqaWJxcCwgdm9pZCAqYWRkciwNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgICAgICBtZW1j
cHkod3FlLT5kbWEuaW5saW5lX2RhdGEsIGFkZHIsIGxlbmd0aCk7DQo+Pj4+Pj4gICAgICAgICAg
IHdxZS0+ZG1hLmxlbmd0aCA9IGxlbmd0aDsNCj4+Pj4+PiAtICAgICAgIHdxZS0+ZG1hLnJlc2lk
ID0gMDsNCj4+Pj4+PiArICAgICAgIHdxZS0+ZG1hLnJlc2lkID0gbGVuZ3RoOw0KPj4+Pj4+ICAg
IH0NCj4+Pj4+Pg0KPj4+Pj4+ICAgIHN0YXRpYyB2b2lkIHdyX3NldF9pbmxpbmVfZGF0YV9saXN0
KHN0cnVjdCBpYnZfcXBfZXggKmlicXAsIHNpemVfdCBudW1fYnVmLA0KPj4+Pj4+IEBAIC0xMDM1
LDYgKzEwMzUsNyBAQCBzdGF0aWMgdm9pZCB3cl9zZXRfaW5saW5lX2RhdGFfbGlzdChzdHJ1Y3Qg
aWJ2X3FwX2V4ICppYnFwLCBzaXplX3QgbnVtX2J1ZiwNCj4+Pj4+PiAgICAgICAgICAgfQ0KPj4+
Pj4+DQo+Pj4+Pj4gICAgICAgICAgIHdxZS0+ZG1hLmxlbmd0aCA9IHRvdF9sZW5ndGg7DQo+Pj4+
Pj4gKyAgICAgICB3cWUtPmRtYS5yZXNpZCA9IHRvdF9sZW5ndGg7DQo+Pj4+Pj4gICAgfQ0KPj4+
Pj4+DQo+Pj4+Pj4gICAgc3RhdGljIHZvaWQgd3Jfc2V0X3NnZShzdHJ1Y3QgaWJ2X3FwX2V4ICpp
YnFwLCB1aW50MzJfdCBsa2V5LCB1aW50NjRfdCBhZGRyLA0KPj4+Pj4+IEBAIC0xNDczLDggKzE0
NzQsNiBAQCBzdGF0aWMgaW50IGluaXRfc2VuZF93cWUoc3RydWN0IHJ4ZV9xcCAqcXAsIHN0cnVj
dCByeGVfd3EgKnNxLA0KPj4+Pj4+ICAgICAgICAgICBpZiAoaWJ3ci0+c2VuZF9mbGFncyYgICBJ
QlZfU0VORF9JTkxJTkUpIHsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICB1aW50OF90ICppbmxp
bmVfZGF0YSA9IHdxZS0+ZG1hLmlubGluZV9kYXRhOw0KPj4+Pj4+DQo+Pj4+Pj4gLSAgICAgICAg
ICAgICAgIHdxZS0+ZG1hLnJlc2lkID0gMDsNCj4+Pj4+PiAtDQo+Pj4+Pj4gICAgICAgICAgICAg
ICAgICAgZm9yIChpID0gMDsgaTwgICBudW1fc2dlOyBpKyspIHsNCj4+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1lbWNweShpbmxpbmVfZGF0YSwNCj4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAodWludDhfdCAqKShsb25nKWlid3ItPnNnX2xpc3RbaV0uYWRk
ciwNCj4+Pj4+PiAtLQ0KPj4+Pj4+IDIuMjUuMQ0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+Pg0K
