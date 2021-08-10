Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9B3E7D8B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 18:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhHJQdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Aug 2021 12:33:47 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:8644 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229778AbhHJQdr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Aug 2021 12:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1628613205; x=1660149205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=8+qgEkjxQNOVW36qWpv8Z9+Fl9za1RZHl118UElLwWY=;
  b=sU1LO4v6olF0feCD3romWGfiAH6DBh020NJTUsXK8DCDL6DkOM6MulX5
   pU75lQIJ+Ar1oGs/AAipBaA2vBqjTNe9vEiqXAC6trXfMAsFXyuynM54l
   VUluuoOlp7dhepETHCgsVfSriBfJ+72GNEiASWHxC7INyRG/mIQFdZt/5
   Vua1SuubP5daLSNOpCs9ltaySNp9nyYHXBQ6L/x8bt2C/KG6T1Ksasusu
   upqJn1RqHRNqk4IBceKpetbY2JZ7cMNVdgsz+J50aaFwhw37P3Jnp38AK
   4e3jUN3cAqvZpCz83G01qOR7CoQjcU3o0KCB8EN+B5pjIELjmNvL6C3gp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="44665211"
X-IronPort-AV: E=Sophos;i="5.84,310,1620658800"; 
   d="scan'208,223";a="44665211"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 01:33:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuV5Ogux4jPv/uaBCNL8DjLnnbOqgoYCw5BuiBHGus16cxMQowxA3xXZNW/F0V77Xt9V84TnI86ZC6lmIBKq20AYumXCmxxuXm6wAL92girmbpNqb4QUy2IaOudKOvh30UEN1Ovta6Le9qT6ZVoenQa+1koYyCPlzKmifbd1KZL2qEsGeC+SDwG2b+DG2hozj4trmFMlNQgUIQcU1HlVijkGN4yNSMv7aQ5Y3JHpJto8APVhmrC5M8xOnnkJ4mkZWqH+7AlzQvfpL9gfD9VFDIiHdU76VsMC4pYEpN+dJyWE9FOz48PJf3WGVzSVZRe+vhVVVeamBo3vEHnmnRIPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbZskTeneaXLceC8cDas0iMljbvtCQbsVhSdWGsFpqk=;
 b=TmnIXtybajkOH56K6CTvXBIH4d3eCrUSt6dgzZ3tkIpMdi1mj5260y91XonREATD3X/ZkorofVa7bTeQyd+OMo9d4HttlErNj5YGCIJOWwTYN80znC9lPe0mA7XvBaHeEYqiemJQccuAnrfAnrEfogFkX4hgt6iJSTd6jrxPgEVYGDOuPitBWAim20LUTh8mgSpEZ4UuNxhSPE8wNaKMwmP5MyNY9OlGHjaz3gyqX1VxFl8plONxhKAmoptuIrAGAYnT0J4N502FGyeMpGuGcIS+5f7f5DHHDxX+9Z6+0KCOA62XHpDF5PAASE3VdUaV+AEQkE1m8BCRKyCtP44NHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbZskTeneaXLceC8cDas0iMljbvtCQbsVhSdWGsFpqk=;
 b=bsmHntTtODM3BdWYvhSP4HACBxemXIn3Tawr+1Ml6NJZohJ6OPI7yd40OMjdxkbzHv/8KLNKxMiyb1nmKL5rvdGUBreF0Yu4GG/8QzYnEtbe79iDZbRWpUtGEo8ZP0dIfCL2zx1VEgpJRHk+4Ua+AmQ84SMc3VFzF0+GLYgFPOg=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS0PR01MB5508.jpnprd01.prod.outlook.com (2603:1096:604:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 16:33:18 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 16:33:18 +0000
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
Thread-Index: AQHXjSu/7XTFLNlnDk+JDe1qihCp9qtsGJsAgADXggA=
Date:   Tue, 10 Aug 2021 16:33:17 +0000
Message-ID: <6112A9FA.2050300@fujitsu.com>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <CAD=hENd6StySon04rW1CPeJbN1KFPDDP1JFsYNBxXNYYegtF5A@mail.gmail.com>
In-Reply-To: <CAD=hENd6StySon04rW1CPeJbN1KFPDDP1JFsYNBxXNYYegtF5A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2c7efe5-9222-4471-6fa1-08d95c1c8f32
x-ms-traffictypediagnostic: OS0PR01MB5508:
x-microsoft-antispam-prvs: <OS0PR01MB550856B2D60CFCDBD068C59183F79@OS0PR01MB5508.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ni/WptmsfQE0GI+Hqlq3uVxBVQPOxqSn7ItkG7583i6XTxMMKuKy070Bu74nd6XErD4JIbjJ9l7re8kziCcl6QuB00VBAGPaSzQvE2CYRkW06ERt3mzGdTDHSr/6RqCixXVBWEhNxSeKccD6CGrAqEQMGPL/mqVtAgRVPPGtDdkZwdxAKM9eAiujaANLxa3dHPfuqUcBqvvJaHbiDB4YiHhgmdAFRWhCd/SpkEVUkU840clEzmiNt3E4iwLcPk3Oj1ibFLcEAxLbJzr33EYVa3j/J/FROGDEAnM9xo+cQQw3m1No7BGdXZuZDUG1ZmYt3zIaotIZ2EmBztzrIkJbbWAYXt1wJuaMmuWCClrrO4yp+VpReX1AXvKAERDyjuv6m84XLrikjdFn3MskcpdsTlwwpVtUl5htxAvW+uegcCyag4sFa416CIX1H6wvrgEVKPmhwaKXFtEDNxgUrrsp7vrhTMVDWBrJdrYXoieXGpilprEib518YWs9IIgcivmLBUP90CPBwwMldOcbT+vHb1dPANP/KHS0WW7EhOvZPGnzh17buK96RLj05p/xQovJ4jv33Ujrri5crRG9rKL7fNNzTVcy1eQwpnhlwfRIRrxa3CClBEv2rYMIYve48JZdfNMQ1Der4/ko/0q/LThj3tX2UQj3+RIdCcQQZIIUKG1BQNfQiLXyzqKqR07c5dQ08ITOqkfo9yhJCSb/sRukBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(85182001)(186003)(66556008)(64756008)(66446008)(478600001)(8676002)(6512007)(6916009)(2616005)(8936002)(66476007)(71200400001)(5660300002)(6486002)(316002)(99936003)(83380400001)(66616009)(66946007)(87266011)(38070700005)(86362001)(122000001)(38100700002)(54906003)(2906002)(6506007)(4326008)(26005)(91956017)(76116006)(53546011)(36756003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VE9zYXRhb3A0aUhrM0dyVXcwanhSQWk2NVVkV2lwRTc1aHRBMWxRQkJXTndL?=
 =?gb2312?B?djlHdUJxUVB6Q1Y2VWY1cWdiaDNZY1Z6aE80aDNkMmxWTE5lTzQrcThSVXRI?=
 =?gb2312?B?UUQvUW02L3dTZ0M0V05ZRGJYNkVrbmVsYWNtQjZBQVNQeENrNWg4Z0svWHJG?=
 =?gb2312?B?RmQreVVLOC9ESnhNRlRSeVFSMjBsRm0wVzhnVjhXNytHREJ4dXFSTWxUZWJn?=
 =?gb2312?B?cS9RSXBqamo2SWVyQ3VNNUtobUg4Z3ZoWll3MzZicmdEOWlCSXJSMEZhZ1VE?=
 =?gb2312?B?VmxkM3psOWc5aEpveWVxM1FDdm9HbExpaHZ2T0pHbGNYaTk5dm5FRGVJVXFR?=
 =?gb2312?B?eTB3WmpzTGhPN0ZWMVAyOEg5MUF1LzRiZ2lUYjFWVEpHaXlNT0FrOUx4S2g4?=
 =?gb2312?B?cWp6YXJiM3VDcGNIWWxwelZlb1VVOE5OTVF0QkpBVmwwRkprUWR2YmVEVUoz?=
 =?gb2312?B?NE9RSGRYMmRDWmtLMW54KzJOcUNiaGVEL0RkbEd4MDN0d3FLaDNNbnRHT0Nq?=
 =?gb2312?B?eUg4MUg0RERCZVlzeEFMWTRZeDB3OVlKdG1aaHlXYXBEWkFUVVpveUFKdGk3?=
 =?gb2312?B?MHJ3RkZjSHVzWHIwajNRN3JvMWxDTE5DV1dweFJTWnVZNmt1dXU4Zm5xOXZp?=
 =?gb2312?B?aGhnVVQ3bDdUamZpNWpkREZKR3FmRmlUSnlyb2hyN2d0T3BRejZsVDZRbnlX?=
 =?gb2312?B?TnFDQS9nd2E2L0JvTnBvRWR6S1VTT2NiYXlQc2pPTENxYlhlWm1tZ3JSZ1RD?=
 =?gb2312?B?N2s3QzRtUXNFOGwvWEZsdXl2TGxMT0IrdHhsc3BGeS9ITnlIVzZrQkNIeUJ1?=
 =?gb2312?B?TGVvUFY0VjkwZFQyWFNUU1JadmxyL1ZNZXVwTXNwR0tEak0zWHZzTWxPbHhm?=
 =?gb2312?B?RjZkRE8rM0FaTk4xOUxXalRhRXpreTNrcVlKbG1oQ3hSS1ZqRENBb3lWeGsr?=
 =?gb2312?B?bytCdlVBK25wYzBHNW82b0dZSkZ0a0tjcUUrTTFLUWRaZG5mVGFaNWNyQVpN?=
 =?gb2312?B?bnc4cjV1dGZxRVdLYVVUN2RuQU1ZVWEybkdRNVA5ZVgwclVjK1lsNWpHUkpy?=
 =?gb2312?B?angxUUYwbWE3TmtLaStxQVJ5SHVRZFRHUktwTTI2RkZ6T2F6VFRvQ1JhaERa?=
 =?gb2312?B?ak1BMEo5VFZpVGNuVVl3a1pLZ3ErS3E4bFVDaExIYkhLdC9WbVhpQ0g5Z0pC?=
 =?gb2312?B?VWVraXFEcG9sMnlJbEpqbDhVTnEvVGtLMDlzYUlyaUdLbmplZjUxMU1Qekt3?=
 =?gb2312?B?d25GSCtSbEkyQmxvc3pJcDh2d1p3THZrU3Uza3FXMGU0Zzd5dDNpRlhKM3gv?=
 =?gb2312?B?V2VmNldSc0dIUmRmV2RwQnlZbmtsY0pXdEp4VTMrRmdqdmV3THZlYXUvZ0RN?=
 =?gb2312?B?ZlJjd1VkOFNkaDl0bDJhbXJpWkxMWWRCcjQ5cytBbUxVVXhRZnBWRU0zenhE?=
 =?gb2312?B?K0hicXJsbjJFeFdKZmZVcXB5NkVaMDVjSFYwQUl0dVdpOTJFNlYwL0twLzFy?=
 =?gb2312?B?Vno5S0RHYlkvdGVRUERRUDA0RSt0bHpwcm9RTXdoNnBmWVpZYjBocUJTakFv?=
 =?gb2312?B?VHZJajRUZTEyZHBjcFhKVW1DUm9zNUk3cGpLK3NyVDVZelZzeDc3YVVXZzd3?=
 =?gb2312?B?TXpHTDAxdWpoZXR0OWZUM3ZXbVlrb0ZGVjF6amwzRW9nTXJ2amdlcEpKVTha?=
 =?gb2312?B?NnkrMlppaEwwdVd1RFgwK2N3Q1Ivd0NFdzNGNFBTSXN3SkUrSFpWdTBWalht?=
 =?gb2312?B?NXZhVlVGNTVpMEJZSVZUM2ZqamU4aVR3MWV6azFQQUYzS2JoVG9JZXFhWnhw?=
 =?gb2312?B?eVdWNzBCYzNSTk9pbVpMdz09?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed; boundary="_002_6112A9FA2050300fujitsucom_"
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c7efe5-9222-4471-6fa1-08d95c1c8f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 16:33:17.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVwg40Yi9oMlK4zEQawfRJXNlhgBDL4WHcIfueCJ6GO8za6zn1QpquWuGzrAwD/2Xo6zhWaYBOrZi7pkCHvgCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5508
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--_002_6112A9FA2050300fujitsucom_
Content-Type: text/plain; charset="gb2312"
Content-ID: <540BAFDCB9A3FD4C97C69D3FE8535B54@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gMjAyMS84LzEwIDExOjQwLCBaaHUgWWFuanVuIHdyb3RlOg0KPiBPbiBNb24sIEF1ZyA5LCAy
MDIxIGF0IDEwOjQzIFBNIFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+IHdyb3RlOg0K
Pj4gUmVzaWQgaW5kaWNhdGVzIHRoZSByZXNpZHVhbCBsZW5ndGggb2YgdHJhbnNtaXR0ZWQgYnl0
ZXMgYnV0IGN1cnJlbnQNCj4+IHJ4ZSBzZXRzIGl0IHRvIHplcm8gZm9yIGlubGluZSBkYXRhIGF0
IHRoZSBiZWdpbm5pbmcuICBJbiB0aGlzIGNhc2UsDQo+PiByZXF1ZXN0IHdpbGwgdHJhbnNtaXQg
emVybyBieXRlIHRvIHJlc3BvbmRlciB3cm9uZ2x5Lg0KPiBXaGF0IGFyZSB0aGUgc3ltcHRvbXMg
aWYgcmVzaWQgaXMgc2V0IHRvIHplcm8/DQpIaSBZYW5qdW4sDQoNCllvdSBjYW4gY29uc3RydWN0
IGNvZGUgYnkgdGhlIGF0dGFjaGVkIHBhdGNoIGFuZCB0aGVuIHJ1bg0KcmRtYV9jbGllbnQvc2Vy
dmVyIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUuDQoNCklmIHJlc2lkIGlzIHNldCB0byB6ZXJvLCBy
dW5uaW5nIHJkbWFfY2xpZW50L3NlcnZlcjoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQojIC4vcmRtYV9jbGllbnQgLXMgMTAuMTY3LjIyMC45OSAtcCA4NzY1DQpyZG1hX2NsaWVu
dDogc3RhcnQNCnJkbWFfY2xpZW50OiBlbmQgMA0KDQojIC4vcmRtYV9zZXJ2ZXIgLXMgMTAuMTY3
LjIyMC45OSAtcCA4NzY1DQpyZG1hX3NlcnZlcjogc3RhcnQNCndjLmJ5dGVfbGVuIDAgcmVjdl9t
c2cgYmJiYmJiYmJiYmJiYmJiYg0KcmRtYV9zZXJ2ZXI6IGVuZCAwDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KDQpyZG1hX2NsaWVudCBzZW5kcyB6ZXJvIGJ5dGUgaW5zdGVhZCBv
ZiAxNiBidHllcyB0byByZG1hX3NlcnZlci4NCnJkbWFfc2VydmVyIHJlY2VpdmVzIHplcm8gYnl0
ZSBpbnN0ZWFkIG9mIDE2IGJ0eWVzIGZyb20gcmRtYV9jbGllbnQuDQoNClBsZWFzZSBhbHNvIHNl
ZSB0aGUgbG9naWMgYWJvdXQgcmVzaWQgaW4ga2VybmVsLCBmb3IgZXhhbXBsZToNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppbnQgcnhlX3JlcXVlc3Rlcih2b2lkICphcmcpDQp7
DQouLi4NCnBheWxvYWQgPSAobWFzayAmIFJYRV9XUklURV9PUl9TRU5EKSA/IHdxZS0+ZG1hLnJl
c2lkIDogMDsNCi4uLg0Kc2tiID0gaW5pdF9yZXFfcGFja2V0KHFwLCB3cWUsIG9wY29kZSwgcGF5
bG9hZCwgJnBrdCk7DQouLi4NCn0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoN
CkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBUaGFua3MNCj4gWmh1IFlhbmp1bg0KPg0KPj4g
UmVzaWQgc2hvdWxkIGJlIHNldCB0byB0aGUgdG90YWwgbGVuZ3RoIG9mIHRyYW5zbWl0dGVkIGJ5
dGVzIGF0IHRoZQ0KPj4gYmVnaW5uaW5nLg0KPj4NCj4+IE5vdGU6DQo+PiBKdXN0IHJlbW92ZSB0
aGUgdXNlbGVzcyBzZXR0aW5nIG9mIHJlc2lkIGluIGluaXRfc2VuZF93cWUoKS4NCj4+DQo+PiBG
aXhlczogMWE4OTRjYTEwMTA1ICgiUHJvdmlkZXJzL3J4ZTogSW1wbGVtZW50IGlidl9jcmVhdGVf
cXBfZXggdmVyYiIpDQo+PiBGaXhlczogODMzN2RiNWRmMTI1ICgiUHJvdmlkZXJzL3J4ZTogSW1w
bGVtZW50IG1lbW9yeSB3aW5kb3dzIikNCj4+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFu
Z3guanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICBwcm92aWRlcnMvcnhlL3J4ZS5jIHwgNSAr
Ky0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Byb3ZpZGVycy9yeGUvcnhlLmMgYi9wcm92aWRlcnMvcnhl
L3J4ZS5jDQo+PiBpbmRleCAzYzNlYThiYi4uMzUzM2EzMjUgMTAwNjQ0DQo+PiAtLS0gYS9wcm92
aWRlcnMvcnhlL3J4ZS5jDQo+PiArKysgYi9wcm92aWRlcnMvcnhlL3J4ZS5jDQo+PiBAQCAtMTAw
NCw3ICsxMDA0LDcgQEAgc3RhdGljIHZvaWQgd3Jfc2V0X2lubGluZV9kYXRhKHN0cnVjdCBpYnZf
cXBfZXggKmlicXAsIHZvaWQgKmFkZHIsDQo+Pg0KPj4gICAgICAgICBtZW1jcHkod3FlLT5kbWEu
aW5saW5lX2RhdGEsIGFkZHIsIGxlbmd0aCk7DQo+PiAgICAgICAgIHdxZS0+ZG1hLmxlbmd0aCA9
IGxlbmd0aDsNCj4+IC0gICAgICAgd3FlLT5kbWEucmVzaWQgPSAwOw0KPj4gKyAgICAgICB3cWUt
PmRtYS5yZXNpZCA9IGxlbmd0aDsNCj4+ICB9DQo+Pg0KPj4gIHN0YXRpYyB2b2lkIHdyX3NldF9p
bmxpbmVfZGF0YV9saXN0KHN0cnVjdCBpYnZfcXBfZXggKmlicXAsIHNpemVfdCBudW1fYnVmLA0K
Pj4gQEAgLTEwMzUsNiArMTAzNSw3IEBAIHN0YXRpYyB2b2lkIHdyX3NldF9pbmxpbmVfZGF0YV9s
aXN0KHN0cnVjdCBpYnZfcXBfZXggKmlicXAsIHNpemVfdCBudW1fYnVmLA0KPj4gICAgICAgICB9
DQo+Pg0KPj4gICAgICAgICB3cWUtPmRtYS5sZW5ndGggPSB0b3RfbGVuZ3RoOw0KPj4gKyAgICAg
ICB3cWUtPmRtYS5yZXNpZCA9IHRvdF9sZW5ndGg7DQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgdm9p
ZCB3cl9zZXRfc2dlKHN0cnVjdCBpYnZfcXBfZXggKmlicXAsIHVpbnQzMl90IGxrZXksIHVpbnQ2
NF90IGFkZHIsDQo+PiBAQCAtMTQ3Myw4ICsxNDc0LDYgQEAgc3RhdGljIGludCBpbml0X3NlbmRf
d3FlKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3dxICpzcSwNCj4+ICAgICAgICAgaWYg
KGlid3ItPnNlbmRfZmxhZ3MgJiBJQlZfU0VORF9JTkxJTkUpIHsNCj4+ICAgICAgICAgICAgICAg
ICB1aW50OF90ICppbmxpbmVfZGF0YSA9IHdxZS0+ZG1hLmlubGluZV9kYXRhOw0KPj4NCj4+IC0g
ICAgICAgICAgICAgICB3cWUtPmRtYS5yZXNpZCA9IDA7DQo+PiAtDQo+PiAgICAgICAgICAgICAg
ICAgZm9yIChpID0gMDsgaSA8IG51bV9zZ2U7IGkrKykgew0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgbWVtY3B5KGlubGluZV9kYXRhLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICh1aW50OF90ICopKGxvbmcpaWJ3ci0+c2dfbGlzdFtpXS5hZGRyLA0KPj4gLS0NCj4+IDIu
MjUuMQ0KPj4NCj4+DQo+Pg0KDQo=

--_002_6112A9FA2050300fujitsucom_
Content-Type: text/plain;
	name="0001-rxe-construct-code-and-reproduce-the-issue-by-rdma_c.patch"
Content-Description:
 0001-rxe-construct-code-and-reproduce-the-issue-by-rdma_c.patch
Content-Disposition: attachment;
	filename="0001-rxe-construct-code-and-reproduce-the-issue-by-rdma_c.patch";
	size=1968; creation-date="Tue, 10 Aug 2021 16:33:17 GMT";
	modification-date="Tue, 10 Aug 2021 16:33:17 GMT"
Content-ID: <06AE7C3F831AD843B3BA97BE204E97A2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA1ZjJmZjBlNmY1ZWUzYzQ0MzFhMjdlNmJmYmEwODY4YWQ1OWVmNTZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPgpEYXRl
OiBXZWQsIDExIEF1ZyAyMDIxIDAwOjQ2OjMxICswODAwClN1YmplY3Q6IFtQQVRDSF0gcnhlOiBj
b25zdHJ1Y3QgY29kZSBhbmQgcmVwcm9kdWNlIHRoZSBpc3N1ZSBieQogcmRtYV9jbGllbnQvc2Vy
dmVyCgpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPgotLS0K
IGxpYnJkbWFjbS9leGFtcGxlcy9yZG1hX2NsaWVudC5jIHwgMiArKwogbGlicmRtYWNtL2V4YW1w
bGVzL3JkbWFfc2VydmVyLmMgfCA0ICsrKysKIHByb3ZpZGVycy9yeGUvcnhlLmMgICAgICAgICAg
ICAgIHwgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9saWJyZG1hY20vZXhhbXBsZXMvcmRtYV9jbGllbnQuYyBiL2xpYnJk
bWFjbS9leGFtcGxlcy9yZG1hX2NsaWVudC5jCmluZGV4IGMyNzA0N2M1Li42ZTU2ODExMCAxMDA2
NDQKLS0tIGEvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFfY2xpZW50LmMKKysrIGIvbGlicmRtYWNt
L2V4YW1wbGVzL3JkbWFfY2xpZW50LmMKQEAgLTUyLDYgKzUyLDggQEAgc3RhdGljIGludCBydW4o
dm9pZCkKIAlzdHJ1Y3QgaWJ2X3djIHdjOwogCWludCByZXQ7CiAKKwltZW1zZXQoc2VuZF9tc2cs
ICdhJywgMTYpOworCiAJbWVtc2V0KCZoaW50cywgMCwgc2l6ZW9mIGhpbnRzKTsKIAloaW50cy5h
aV9wb3J0X3NwYWNlID0gUkRNQV9QU19UQ1A7CiAJcmV0ID0gcmRtYV9nZXRhZGRyaW5mbyhzZXJ2
ZXIsIHBvcnQsICZoaW50cywgJnJlcyk7CmRpZmYgLS1naXQgYS9saWJyZG1hY20vZXhhbXBsZXMv
cmRtYV9zZXJ2ZXIuYyBiL2xpYnJkbWFjbS9leGFtcGxlcy9yZG1hX3NlcnZlci5jCmluZGV4IGY5
Yzc2NmIyLi5mZmI0NDBjNiAxMDA2NDQKLS0tIGEvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFfc2Vy
dmVyLmMKKysrIGIvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFfc2VydmVyLmMKQEAgLTUzLDYgKzUz
LDggQEAgc3RhdGljIGludCBydW4odm9pZCkKIAlzdHJ1Y3QgaWJ2X3djIHdjOwogCWludCByZXQ7
CiAKKwltZW1zZXQocmVjdl9tc2csICdiJywgMTYpOworCiAJbWVtc2V0KCZoaW50cywgMCwgc2l6
ZW9mIGhpbnRzKTsKIAloaW50cy5haV9mbGFncyA9IFJBSV9QQVNTSVZFOwogCWhpbnRzLmFpX3Bv
cnRfc3BhY2UgPSBSRE1BX1BTX1RDUDsKQEAgLTEzMiw2ICsxMzQsOCBAQCBzdGF0aWMgaW50IHJ1
bih2b2lkKQogCQlnb3RvIG91dF9kaXNjb25uZWN0OwogCX0KIAorCXByaW50Zigid2MuYnl0ZV9s
ZW4gJXUgcmVjdl9tc2cgJXNcbiIsIHdjLmJ5dGVfbGVuLCByZWN2X21zZyk7CisKIAlyZXQgPSBy
ZG1hX3Bvc3Rfc2VuZChpZCwgTlVMTCwgc2VuZF9tc2csIDE2LCBzZW5kX21yLCBzZW5kX2ZsYWdz
KTsKIAlpZiAocmV0KSB7CiAJCXBlcnJvcigicmRtYV9wb3N0X3NlbmQiKTsKZGlmZiAtLWdpdCBh
L3Byb3ZpZGVycy9yeGUvcnhlLmMgYi9wcm92aWRlcnMvcnhlL3J4ZS5jCmluZGV4IDNjM2VhOGJi
Li5lZDU0NzlmZSAxMDA2NDQKLS0tIGEvcHJvdmlkZXJzL3J4ZS9yeGUuYworKysgYi9wcm92aWRl
cnMvcnhlL3J4ZS5jCkBAIC0xNDkyLDcgKzE0OTIsNyBAQCBzdGF0aWMgaW50IGluaXRfc2VuZF93
cWUoc3RydWN0IHJ4ZV9xcCAqcXAsIHN0cnVjdCByeGVfd3EgKnNxLAogCQl3cWUtPmlvdmEJPSBp
YndyLT53ci5yZG1hLnJlbW90ZV9hZGRyOwogCiAJd3FlLT5kbWEubGVuZ3RoCQk9IGxlbmd0aDsK
LQl3cWUtPmRtYS5yZXNpZAkJPSBsZW5ndGg7CisJd3FlLT5kbWEucmVzaWQJCT0gMDsKIAl3cWUt
PmRtYS5udW1fc2dlCT0gbnVtX3NnZTsKIAl3cWUtPmRtYS5jdXJfc2dlCT0gMDsKIAl3cWUtPmRt
YS5zZ2Vfb2Zmc2V0CT0gMDsKLS0gCjIuMjUuMQoK

--_002_6112A9FA2050300fujitsucom_--
