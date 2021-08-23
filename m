Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793D83F44DA
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 08:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhHWGTF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 02:19:05 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:64689 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhHWGTF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 02:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629699503; x=1661235503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zr5uOq6WVuVnho/aBS4MQXQ69ujj5FRjvb5gztJPt2g=;
  b=utTN1TEtxVVGoLssejTIZVCjkj30MfdJRB+LIDUWgd4Pzgl9BKIHxNHa
   XM/GwCJ5t0Yt3AwfVlV4ZQakO3MNJG9VPE87PAbFqUDpLG5IcD4b9osYq
   6Jf6YG/KhJ68w7SF+7ZYWvPmFsQwkgC4q1fmFnt9PRzuV0r9keluvDD6/
   ISN5EYczlOfhkrje6D8AmGNV7bbmqFYeXugNT7TQ4ELJPAx5zS8Hb89ng
   9BAdkscZGXmc2adX43FBXaPsylN97EHq6TeSnW/RIQEWMADMPDj9smxh3
   wC8U+ulTYjjExRNBjzT3uk7Bnt5Gcjm9baWuThKmk8QNq32aNBgt/Hwdt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="37430433"
X-IronPort-AV: E=Sophos;i="5.84,343,1620658800"; 
   d="scan'208";a="37430433"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 15:18:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUXH9BEuFwdbkQSosS9Un7bPcBDhULESON1nwRUAog8ASYOy5KAhWvxGWYxdx5rVMiwO81MvNMgFuNQJERZTzBOT6yQ3s03P6CwU7kRiAyOqWM6hp3JCVXs0/1x/P00V1ShYu7IgnnntyoKoMoYzRe3nuuwfkxuA0RcPdzYtrBnwWTgqh5gTsAXRL+oj357qfdy/q8rtir9eni6FU5IJAgDkOzKloG7sJFw6DqK7pHeCktgX1nCmjK0guK707s2Q0lC1bZusRkceIyrJLjsQJvOBUwY5P83fbHXNwEnYwgZKLKLX/AsCEM/KLV4VufcuwTIHB0aiZGChRRj0Xi1cDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr5uOq6WVuVnho/aBS4MQXQ69ujj5FRjvb5gztJPt2g=;
 b=bEnQ42Vwu08XiEqRNqc9aqxGG5rnWhhYTdoEN3KIFoH5tTQBsanqxQXFu0sTwkqWCi1OgPtxY0zDBtS9R/ub0vF19c3xg2WOSwdUFkl2BzVTiiG1XvNW6SDA+4oN73mNLLWziMlEnbjv8x2Yl5az6CHXHVJHHd9WSl9kNxIr2Yx9fCLSps25qa/0ekaU4lXe+YlXDRIQce35P5jVSFQa/3OWiIJoKsSkhv1qsV2Npk/W8Yuco+hTcpFv68y8tnYGUsQJE3pxkpAd4rPbGNmsLdEKjAW1wexrGPyYtZckJJ+WMLNeCdTrcswU4jSrgZ3458U8SBdMwEmmkbt4YlrvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr5uOq6WVuVnho/aBS4MQXQ69ujj5FRjvb5gztJPt2g=;
 b=M2qcki4as2wYlE2a13UTQhOOd75o17UmgAHGtd+3K7M5/eFTQqHn88GcEXgLU5SSqFmUaE5jphkT2SNchARL7Ptlc/xGi+U/NSmcR2aO+oBRbR+ElSUND9BwJ0w8E2Dws+ArrmQ7YpwRUq6ey7z6lXPwfrKMwo9HZcUgd5FFfYc=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB1571.jpnprd01.prod.outlook.com (2603:1096:603:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 06:18:17 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::4dd6:9264:85f1:148c%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 06:18:17 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Topic: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Index: AQHXlbAkwqjHlJzA7Ue2Vhqx7eRcdKt9juEAgAL254CAABI+AIAACeqA
Date:   Mon, 23 Aug 2021 06:18:16 +0000
Message-ID: <61233DA7.7020006@fujitsu.com>
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
 <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
 <61232609.7020500@fujitsu.com>
 <CAD=hENcMv9d-gTdEpXtgUwSm45d89LwWsHJiUALUUmhsEiU+Cg@mail.gmail.com>
In-Reply-To: <CAD=hENcMv9d-gTdEpXtgUwSm45d89LwWsHJiUALUUmhsEiU+Cg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 570cdf69-b64c-4574-fbae-08d965fdcbd9
x-ms-traffictypediagnostic: OSAPR01MB1571:
x-microsoft-antispam-prvs: <OSAPR01MB15712FD21AAF689968A5E72583C49@OSAPR01MB1571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlTJG9efl0pamEWR/Z+POt9xhLp+GiNUpZBmrfq+pD+NoVd4IG3qL+ds+2pYxpUmelgOqZ0RprsWet03BcLJKGvB1MVH2nD0qCLP3IQEHU2icS5xxCcctcDzLL1wynResD6zH6cUV/coYblhpLQqNQRMiR2M8+jFkZpauehGen41B3hze60pACxubHQJFz5uSPmYpW3UNnF0oQRu+V1x+BnvN/zYjtu90UtTvRSsWY/66/ZYN01I48FysffR7CFqqruUQi1oR1M1UORN63t0l6nW9OgWDywGJFEgu0WQqRr3MqrhZTdzGrruVEUpXKbfEfWflyav/Bz5363mVDWhnxrrSIkcWJ+UXqHxF7UbPJBKVEuBL5XidJwFzl97n3lCjRwmKU5IkNnop6+22aE7tQnabkggVMefY7Cd0qscgZizfaSQQxrxU9A3+govMhY/hmDgjnoh/IZOAIdqluuWBaR3hooeGxApOCYDWsL+YFSrwII8eZcM5ko4sO6vkDnxYIAVSnuhoASj40BGyzuqmVTu/jEDCNgRw+pHvbqNdgca5ucPbOsKPrO3/aoAnm/wMYbxlybdHvmhPHkqe1hqzGbQoBoSXB27dToInDCJbCew/UkWf/0hn3GGbeL5sRnDim2Yxz9IjftZm5cwfDnJ4+dmtItP+sCSIqePixFNRwZUhIrLQXeOHfP5vJ8M7yXTcgx5gM40IjCiXj2yMBJaZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(478600001)(4326008)(316002)(71200400001)(54906003)(66476007)(6916009)(122000001)(6512007)(2906002)(38100700002)(8676002)(87266011)(53546011)(6506007)(5660300002)(8936002)(36756003)(33656002)(86362001)(85182001)(26005)(186003)(6486002)(2616005)(38070700005)(64756008)(83380400001)(66556008)(66946007)(76116006)(91956017)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXhueFY0aG9mMTJNc0theHBkUHdVaHpWMHRsSzBYZkQzbFVOdXN4bDJhQksx?=
 =?utf-8?B?L3FWSm9pcjNQanNwT1FWVUpnN2d4dDlpWnJDbHZTWjM4Z09nMTM4VnNmRWQr?=
 =?utf-8?B?M2dHdFF2ODRQZFpKZ2pCUFA4cXdOYWc0MlZVclNTWWpqeHowdGRZZDFNeDV1?=
 =?utf-8?B?V1gyS0ozYW9OeFBqR2cxUFhkMVo4M0VQcmt3QWpabjIrK3drUmdNRERUMFRw?=
 =?utf-8?B?UHlEZ3g5ZzYwNWhPSmJlbENMTExJM1Z4c1pXSzRYWTRRYlF4VTYwZGhyeDdE?=
 =?utf-8?B?U054NC9rZVIrRTNsNjlkaEl5NE8yeTJvdHJvV1RjL1NSQnh5N1BoZ3JEMldl?=
 =?utf-8?B?a21MdUtzZzMrSVczalRhMlhVejZwcW5hTmcwWlh1Kzd6eVhNQ0tsMUtpdEoy?=
 =?utf-8?B?UU81dXovcmVWV203M1lpMFEzV25tYkNmc1FadklPcjhvWUNyWnI4andWWU5i?=
 =?utf-8?B?RVkrajExSFozSjNDSWdwZVUyd3JibjlQNGxxWW9HT0czUzY2Z2VwS2Rham02?=
 =?utf-8?B?UTUwSEtlVnZWRWo4TWVIT1NiYzg1SHJQWjRMRkh1bUlFcFRtZW5yUTV5c2Iw?=
 =?utf-8?B?Tk9lbVlVSVpUWnk4QjlKc3RNNWVhc3VLclhBakt0L0ZFSnBWT2NYekFoTkZC?=
 =?utf-8?B?V1JwTmVqYTl6U0QrU3p1YXk2OWZ0dHZ4dnhxaVE2OTZJNVAwQ0R3OEg1d2Vi?=
 =?utf-8?B?bkdVcnFMTmlJaHVVUWRiZ3ljdTREOEg5S1hkcUdmWFEzRmlQclNBdm15eURU?=
 =?utf-8?B?Wll5bW1HSC8ybUxLZkhUVGhGWU9UOEhUVVhOM21yOHJpRVpmVTBXVGlWTkpp?=
 =?utf-8?B?Uy9LOUZ2dFdFT2czZG5WT20rNGFrT0ZxeDRZZzFhUm03SXdxeFBvV2UzK2pX?=
 =?utf-8?B?UHhQMlRFa0srUGQzdUdoTVRZVmRjUXNRcDhiV1JuSS9YTmdLT05QUVZERnF6?=
 =?utf-8?B?cjNRb3BndjZMZ2VjSFlMUEtBT0t0UWw4UWY3Vk5rWElwRm9UWWhyZmFVb2xJ?=
 =?utf-8?B?S01JaWFmNG55WUh1eCs0bzNXMWxLYkZkMHNYbExPU040ZlRmZ0NCOVljeUZG?=
 =?utf-8?B?d21aZ1ZnZXRicVUzaEtaRjEvZE05dzN4WnlXanRZYjJSS1E3aXdKaGs2aWl6?=
 =?utf-8?B?QTZPVWM4d29Nb3RtanpIZjNLeU9jdFZjV2pKbWNPSXg1L3RyYWJwQzFZN3Ji?=
 =?utf-8?B?U0FRZVhUdXFqRzg1MDdNc0xaQ0s2QzBLc1VBK25uUE5xU3JXK3R6b3J5N2U0?=
 =?utf-8?B?UHRDaHhVeTZjcFdsUWFBWDM2SGkzMUx6WFlBVTltWjJoWTRTc25iYmpiNW1M?=
 =?utf-8?B?b1FMQzY2QjY5TmFqSTFJS2NiYUV0MTdJclZORXYyT3RUNTJCemU2SGlSVk1R?=
 =?utf-8?B?ZG1YVXBiQnJGdkdpWXJtdk42d29OR3IxUFl3ZnVSUHVUMXBBY1o1OE1MaDkr?=
 =?utf-8?B?UlBQUU5ISnhzS2c5dHpLOFUvdVZBZGdoTHJPWkQ4R0dITTV0NUJYcTVoSXNK?=
 =?utf-8?B?Wmp3ejlRRElyQVBUZ0pWQS8rajhNeFNhc216RU94OWc5alV1ZXdPUm9yM1Rk?=
 =?utf-8?B?ekdmL3g4dGpma29zMWFTWlE4VW1rSk9hWHk3REVzSGViQ1l3R1Jja1Ftc3dY?=
 =?utf-8?B?Uis5a1k3cTlHYTgrbC9rN241eWlCVWVYOS9WSDRoQk1SdmNkZ0FMUG9YZm1l?=
 =?utf-8?B?K0tNZEhsSUx4dlpGWjVNckRrMjZ0YnhDRGxWQU9iRkdiR2ZjcnNTeFd5Wjdl?=
 =?utf-8?B?aDVzZTRLUVUrRWRlRWJva0xzYjJHWWFFKzJyMExsekVFVWZibHJTNGp1a0dv?=
 =?utf-8?B?MVk0YXdXOWQwdldCSENmdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A668CA8BAC83ED4AAD609610B3C2D9A1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570cdf69-b64c-4574-fbae-08d965fdcbd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 06:18:17.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSg5V92CfGBzCnNsUnJu+k4gZhHE2suoaB2taHXIkj2N9hu8rOv+Qs4zT/205vRolxSYmGUupm0dMOVAAT1REw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1571
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzIzIDEzOjQyLCBaaHUgWWFuanVuIHdyb3RlOg0KPiBPbiBNb24sIEF1ZyAyMywg
MjAyMSBhdCAxMjozNyBQTSB5YW5neC5qeUBmdWppdHN1LmNvbQ0KPiA8eWFuZ3guanlAZnVqaXRz
dS5jb20+ICB3cm90ZToNCj4+IE9uIDIwMjEvOC8yMSAxNToyMSwgWmh1IFlhbmp1biB3cm90ZToN
Cj4+PiBPbiBGcmksIEF1ZyAyMCwgMjAyMSBhdCA2OjQ0IFBNIFhpYW8gWWFuZzx5YW5neC5qeUBm
dWppdHN1LmNvbT4gICB3cm90ZToNCj4+Pj4gMSkgTmV3IGluZGV4IG1lbWJlciBvZiBzdHJ1Y3Qg
cnhlX3F1ZXVlIGlzIGludHJvZHVjZWQgYnV0IG5vdCB6ZXJvZWQNCj4+Pj4gICAgICBzbyB0aGUg
aW5pdGlhbCB2YWx1ZSBvZiBpbmRleCBtYXkgYmUgcmFuZG9tLg0KPj4+PiAyKSBDdXJyZW50IGlu
ZGV4IGlzIG5vdCBtYXNrZWQgb2ZmIHRvIGluZGV4X21hc2suDQo+Pj4+IEluIHN1Y2ggY2FzZSwg
cHJvZHVjZXJfYWRkcigpIGFuZCBjb25zdW1lcl9hZGRyKCkgd2lsbCBnZXQgYW4gaW52YWxpZA0K
Pj4+PiBhZGRyZXNzIGJ5IHRoZSByYW5kb20gaW5kZXggYW5kIHRoZW4gYWNjZXNzaW5nIHRoZSBp
bnZhbGlkIGFkZHJlc3MNCj4+Pj4gdHJpZ2dlcnMgdGhlIGZvbGxvd2luZyBwYW5pYzoNCj4+Pj4g
IkJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNzOiBmZmZmOWFlMmMw
N2ExNDE0Ig0KPj4+Pg0KPj4+PiBGaXggdGhlIGlzc3VlIGJ5IHVzaW5nIGt6YWxsb2MoKSB0byB6
ZXJvIG91dCBpbmRleCBtZW1iZXIuDQo+Pj4+DQo+Pj4+IEZpeGVzOiA1YmNmNWE1OWM0MWUgKCJS
RE1BL3J4ZTogUHJvdGV4dCBrZXJuZWwgaW5kZXggZnJvbSB1c2VyIHNwYWNlIikNCj4+Pj4gU2ln
bmVkLW9mZi1ieTogWGlhbyBZYW5nPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPj4+PiAtLS0NCj4+
Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXVldWUuYyB8IDIgKy0NCj4+Pj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXVldWUuYw0KPj4+PiBpbmRleCA4NWI4MTI1
ODZlZDQuLjcyZDk1Mzk4ZTYwNCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfcXVldWUuYw0KPj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9xdWV1ZS5jDQo+Pj4+IEBAIC02Myw3ICs2Myw3IEBAIHN0cnVjdCByeGVfcXVldWUgKnJ4
ZV9xdWV1ZV9pbml0KHN0cnVjdCByeGVfZGV2ICpyeGUsIGludCAqbnVtX2VsZW0sDQo+Pj4+ICAg
ICAgICAgICBpZiAoKm51bV9lbGVtPCAgIDApDQo+Pj4+ICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyMTsNCj4+Pj4NCj4+Pj4gLSAgICAgICBxID0ga21hbGxvYyhzaXplb2YoKnEpLCBHRlBfS0VS
TkVMKTsNCj4+Pj4gKyAgICAgICBxID0ga3phbGxvYyhzaXplb2YoKnEpLCBHRlBfS0VSTkVMKTsN
Cj4+PiBQZXJoYXBzIHRoaXMgaXMgd2h5IEkgY2FuIG5vdCByZXByb2R1Y2UgdGhpcyBwcm9ibGVt
IGluIHRoZSBsb2NhbCBob3N0Lg0KPj4gSGkgWWFuanVuLA0KPj4NCj4+IEkgZm9yZ290IHRvIHNh
eSB0aGF0IEkgcmVwcm9kdWNlZCB0aGUgaXNzdWUgb24gbXkgbG9jYWwgdm0uDQo+IFdoaWNoIE9T
IGFyZSB5b3UgdXNpbmcgdG8gcmVwcm9kdWNlIHRoaXMgcHJvYmxlbT8NCg0KT1MgaXMgZmVkb3Jh
MzEuDQoNCj4gWmh1IFlhbmp1bg0KPg0KPj4gQmVzdCBSZWdhcmRzLA0KPj4gWGlhbyBZYW5nDQo+
Pj4gWmh1IFlhbmp1bg0KPj4+DQo+Pj4+ICAgICAgICAgICBpZiAoIXEpDQo+Pj4+ICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyMTsNCj4+Pj4NCj4+Pj4gLS0NCj4+Pj4gMi4yNS4xDQo+Pj4+DQo+
Pj4+DQo+Pj4+DQo=
