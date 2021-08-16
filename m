Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97433ECCF9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Aug 2021 05:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhHPDHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Aug 2021 23:07:13 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:65268 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhHPDHN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Aug 2021 23:07:13 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Aug 2021 23:07:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629083202; x=1660619202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R/amQjRdaM+02zhhGCvzziZ7fe1WJhVqySFeBzgSwFw=;
  b=vXsnONxAd55QO9ZSK29Z4VsvS9FC4b0rYwD6tMzPkBPyPkKqq/AhiW7a
   8XTH8eOn+6AjBohRI739HKsw4BRJtaHb34zt6fNVdREK3NhZDVQflIakZ
   H7YDApIHO/+u0sP7yGggFtoWEWx+ae/dkwROev+ZAMRTZV7YyYxwOjqLK
   F8kMZOVTnr1slk4OAMWKpkJLk4OsEo0gX74SMTgF41g9nHX+aBFts5yZk
   h2/3RPDR3kisGP7bas2zJezYZT6Hpa0TyR0nHYbnrQAVDU8Oh8FWnZgFE
   BbmRaKolJdaKyEhcxqT2n44opRrokEqJPJmtQeasVzdMsaLKl0sisEfzu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="36844823"
X-IronPort-AV: E=Sophos;i="5.84,324,1620658800"; 
   d="scan'208";a="36844823"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 11:59:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPISwbueEdeJWFCdD+C1c/NXnm1QHD4YW7VL0dWyznrgs49Br3Q46Hb7jmnQTJFEP0CvAcxEBMUUZEdHcc9lrnuxACHZFBLIO80Oi86TmtIeqSNqrYB+s/wnQll3/26mrjPYD8eCtU+wAZ4E/c1es1332W8dZQ/b8J2fdiCzEnjvU6mmQ/SukTTjuV2fWFLXAZtAuG8Qev4i5HhH3VgkusjklWKO/BYxJgX+ZR501zs8Rch1TyGuD+d9E1+bJde3x3Flx0xko+fLv6OYakRKBG9KG7V7E1FX7KX1xhT51RiHkCABDOuwh/EEOTxyBt/+pLOraDHPOCDx+aM5CClDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/amQjRdaM+02zhhGCvzziZ7fe1WJhVqySFeBzgSwFw=;
 b=Ni97BWA7YC8axZkBlsCiTCTjDfY9aEdDuqKJ2ZBzZ40Mf+4RAW/YZ5+c5cA5O+7FhG9hm9jZS7EAr73qhEtmc/Sp3uVploSESKev/4Cul3qtAe/Ii3xQDtttGB5sRPHJ227ZNsZAcA3UeyOviTqto2n2RlaEpUrG+uCv23nRO1VVfn+H6HqoAWVcDojh4S3Qok9HNAHM1uaqyKUtc1UCGMe1iNorXtLDrKPJOgiTcoZ4lQ1YGf16v7JSdCQyHNuUtuEyzZSdllpQz6UDyEsZCgMt+bxjZ1enXpGhANSiYOje31wvfL20Sjh7PK8vo4OJT9WhrmBoKn7laJMZxUHy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/amQjRdaM+02zhhGCvzziZ7fe1WJhVqySFeBzgSwFw=;
 b=bXeFSqsY2z8Ldf5umU6zgq8Pl02TIql/FDg4dOouxkoM+cMBuKORmcBTX2f4E1ofOyhE6icLQGZ2yrJWFA7zKweVomL2q583bISa+9MvXqmB/oGADTdcvg5BFA46qJ+F6S9oSgBKDpvohAOf7w9v2IkxGPMeD+0MicjlwwrYS7U=
Received: from OS3PR01MB7650.jpnprd01.prod.outlook.com (2603:1096:604:14f::5)
 by OSZPR01MB7745.jpnprd01.prod.outlook.com (2603:1096:604:1b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Mon, 16 Aug
 2021 02:59:27 +0000
Received: from OS3PR01MB7650.jpnprd01.prod.outlook.com
 ([fe80::d0b3:dccf:a218:f634]) by OS3PR01MB7650.jpnprd01.prod.outlook.com
 ([fe80::d0b3:dccf:a218:f634%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 02:59:27 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Thread-Topic: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Thread-Index: AQHXhrbNDgu/BY8sokOKZIxuzo0WFqth+tCAgAAZpQCAAASwgIAAvoAAgADeFQCAAMdDgIARCoCA
Date:   Mon, 16 Aug 2021 02:59:27 +0000
Message-ID: <6b372500-ebc5-bc42-11c5-99de381b2e50@fujitsu.com>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com> <YQmDZpbCy3uTS5jv@unreal>
 <20210803181341.GE1721383@nvidia.com> <YQonIu3VMTlGj0TJ@unreal>
 <20210804185022.GM1721383@nvidia.com> <YQuIlUT9jZLeFPNH@unreal>
In-Reply-To: <YQuIlUT9jZLeFPNH@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a6feb2-b4c8-40f4-05a4-08d96061dc69
x-ms-traffictypediagnostic: OSZPR01MB7745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB7745CF6708941BCE569CD392A5FD9@OSZPR01MB7745.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7r+4jZKeEiUSSbe2if5lBsBicHx2ojQGbAn3y1Iw8GdhYDgmmxXRqiNlNdgso+Mo+SCc9qVpbiniiStUmegy/WyUo1krWCSGjmKHNK4nBvY63TkCRhAa5V4gjRqRNG/tzAqmgwm9zZ4FvOKMmqLi5bvmIR9dxOIgLuny0mi3iehKC+jRAoaY+ObdIkdeVVQDGHy9s9GlWrk4ssWO2z45+eeNg8hcuTlojPigUZMfLbWuxlDVJWt7T1F1WasR2KDd2tURO/RHg5fxr5LUxZjMJS03rYLJ/YGKMZyMP5k/1GOLIr11NqyjNfaMqnsyv+55vimiOGd81WirYY1O6JlVTWfq+04FppJA39KG2bFaU7+5pko0nggRcShSJLDnP8zrw76bO/nU0VpLdqKVtGpyJliRp3vVDZ779dNJGhFlgi7jc/KdNoIZxYIxT9mM2mphQn1kfWmh3RD5x8rvw+wwHEnhuml9HNYGNv732bnXzRUM/3AkXenrZ+7EuNiX1rYUnkVyRc6QwCxLek8IvMzMnWTsUS+oWcgBsgjagBlbacSX0v+6qF+uaBunqJCGXfvHCRiqXlfU4W9VuVzP9cjOXoGS2kC4eavWmpaMCjyX5JuldqiQuS3szHnwfvEq+TOABSRjBw6N8/EPtkKncLFsRBzhiI0NmB4JiRdNY3ewTsoVgkv8Ej0ZEd6syeexzXFByLqBI2zjrgbySPQAB/qFJ4ktGMgOnKcayzIAjLmla6Dlk5d8/TXTiwgPZ6/K9bTgI98YHbr+p6APNg4XgSOSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7650.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(91956017)(4326008)(36756003)(6512007)(83380400001)(8676002)(71200400001)(54906003)(64756008)(38070700005)(76116006)(316002)(110136005)(85182001)(31696002)(31686004)(5660300002)(6506007)(66946007)(508600001)(122000001)(2906002)(6486002)(38100700002)(8936002)(26005)(66476007)(2616005)(86362001)(53546011)(186003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bS9lS2xXUWp5dkpvVVBndDNWeGxJVm16ZzFxUlZLVDVla0xzNGZOREZzMjJx?=
 =?utf-8?B?ZzFwRHhuT0loRFJqN1FkbXptQ24rMjVqTytzK1V2RnFXT2VzWEh3NnE2ejMy?=
 =?utf-8?B?K05uQlNNYmRrSXZjNTM5Q05rOHRGV3kzMk9VQ3FwTmc1bFJaMjJnTTlNWHdV?=
 =?utf-8?B?Uk5vSEgzeTJwMm1KQm0ySjRHaEZtZ3pOOEt4Vnk4VFRPU2s1cjA2VmJnU3Zk?=
 =?utf-8?B?N0dFeGpaay9EbGo4NUNTQitYSHpycjQ4UUFHemdUdkdsSHloWG96YlpUbGFP?=
 =?utf-8?B?elVxQW5JczJPTVRsTkdaZDl3SExObS95d3pTTjdVTjdId0dEcWpoOG9idUF1?=
 =?utf-8?B?aWI5Wnlua1IrczUwRXJINkRydjV6M2FiUXk3WFhic2FWUEwyYTlVSXJGd2dt?=
 =?utf-8?B?NWZhWlN2K0dJazZHeExSYWhrdlViNHlZYmEwamd6UnhGYkFNeVdjWnJ0OEZi?=
 =?utf-8?B?QTFhL1AyZjhoTzlDQklmak1lRFRROXp4ZkVqM1AxeHFkekNnaXJsOUV0UFdu?=
 =?utf-8?B?cWpXcVJWbFdGN1Bld2NCRGNWL1Vqb1RhMGxxR2hHYnBnRThtaG5ob0FFMjIw?=
 =?utf-8?B?MVIrRlA3MDVkbk1SbWdSRVI1VFljTXZpNWd6OXpnd3U5SHVMazJ3VlMvaDFQ?=
 =?utf-8?B?RzVhVVlVVFhTc21Icnp6NzdBUTJ4OXJQcG9JK0UvSDRiWkYwVDFBTDFXa1hY?=
 =?utf-8?B?RktuaUdEQlMvZFFIRnFKejA2WFhuSFZtMzNhdnU2b1ZWdjhLendRUzROemlF?=
 =?utf-8?B?NXQwL3Rrb0hJQk81YzZNOWlmMlVwSlZsOVFSaDRGM25neDdXRDBlaFZOZDNO?=
 =?utf-8?B?ck5LSWZEek12TnZZKy9KTU1FdXFZdTJEK3FIUkdCdU9WQWkxS29iNy9Pd3I3?=
 =?utf-8?B?N2JXVWgxczZkVVk4TUErYnJEcmdzM0FYS2ZUT2hMYTh1QjFOY1pGRWl6aVlN?=
 =?utf-8?B?Q0xkdXo0V09oVW5BUjlKQzlXSHlyZ2xpb3hRTXV3SU0yb05tQm1QMTRyRHFW?=
 =?utf-8?B?dHNPUkJuRm1qUFZKeTBKTDZKaGt1TjZpQkxVRVdRK2hxRno4Mzl4MFFOOEdE?=
 =?utf-8?B?Zkk4bGlWbXRjVUdYdFZGK2k0bDFwMU5Nc0tYWmE0eVAvdlViRC9KUXJrQ3BO?=
 =?utf-8?B?OUc5aDByYTZBNTNVc0I1cWd1RGJTbGppcERobG5FQ3VQRkpNTWtvTmZFaGVq?=
 =?utf-8?B?OGlocGkvUXFMbVhab2pxK0lEMnpMVU8rWjZKQm9RMk4vQjlIbGhuUC83K094?=
 =?utf-8?B?ckhQeTZZUzV3Y1NvVVpiVk9ZeHp1K29Nc1VrY0FBa2FXQUhReXVSK2J1bThP?=
 =?utf-8?B?NW44WVpoM2pEQUJRRTZDSEpFU3hJa2pSSE00eStLS0k2NFlTWUo2TUQxWGs4?=
 =?utf-8?B?WHRFZmFXT0VkT3hZY1FZQ1hNWTR0dVBMVlB1R2plNnJJWE5wWmNOSmdYY25N?=
 =?utf-8?B?SXZUbGJreURqcjhuZ24yM3MwNERPcGRnWVVFYWU4SkQ0enU2bVN0RmtyQXF0?=
 =?utf-8?B?L3ZMWllmckUyczlwM20wRVVWRHM5eWs2UkdZazhCOUM2Z3V0am4wTVRJMURT?=
 =?utf-8?B?ZjRFNncwMFhjWjRXZlNrZlNXSmVTT3Q3b25HK2Q2blh6bkpoTnRDVUljSVRL?=
 =?utf-8?B?Tkd3NENmcWlrM3lyeU80QnB4MlkzV013QXlkdWFrRTVaRDdhNC9IdkgxR01x?=
 =?utf-8?B?WnRIM1k3L2E3V0VZekJ3VDM2LzJoakxxNG95cjdZV3BRTkhHRzh4TFZxSHNl?=
 =?utf-8?Q?GiCcJkcrOgXAv+8FX6pje9a37zSXhmYqXwz/tZg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEF83B6D1069E644947E39BBB491B8BE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7650.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a6feb2-b4c8-40f4-05a4-08d96061dc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 02:59:27.4286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7aZKKI3PJfJY4h7xejmaVHRoaZgXac5LF+neIWhZuLVwAYefdB4C+iHVU3554vKBtaJVyhyJNyQDmbc/EQpxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7745
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA1LzA4LzIwMjEgMTQ6NDMsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gV2Vk
LCBBdWcgMDQsIDIwMjEgYXQgMDM6NTA6MjJQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3Rl
Og0KPj4gT24gV2VkLCBBdWcgMDQsIDIwMjEgYXQgMDg6MzU6MzBBTSArMDMwMCwgTGVvbiBSb21h
bm92c2t5IHdyb3RlOg0KPj4+IE9uIFR1ZSwgQXVnIDAzLCAyMDIxIGF0IDAzOjEzOjQxUE0gLTAz
MDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+Pj4gT24gVHVlLCBBdWcgMDMsIDIwMjEgYXQg
MDg6NTY6NTRQTSArMDMwMCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBB
dWcgMDMsIDIwMjEgYXQgMDE6MjU6MDdQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0K
Pj4+Pj4+IE9uIFN1biwgQXVnIDAxLCAyMDIxIGF0IDA1OjIwOjUwUE0gKzA4MDAsIExpIFpoaWpp
YW4gd3JvdGU6DQo+Pj4+Pj4+IGlidl9hZHZpc2VfbXIoMykgc2F5czoNCj4+Pj4+Pj4gRUZBVUxU
IEluIG9uZSBvZiB0aGUgZm9sbG93aW5nOiBvIFdoZW4gdGhlIHJhbmdlIHJlcXVlc3RlZCBpcyBv
dXQgb2YgdGhlICBNUiAgYm91bmRzLA0KPj4+Pj4+PiAgICAgICAgIG9yICB3aGVuICBwYXJ0cyBv
ZiBpdCBhcmUgbm90IHBhcnQgb2YgdGhlIHByb2Nlc3MgYWRkcmVzcyBzcGFjZS4gbyBPbmUgb2Yg
dGhlDQo+Pj4+Pj4+ICAgICAgICAgbGtleXMgcHJvdmlkZWQgaW4gdGhlIHNjYXR0ZXIgZ2F0aGVy
IGxpc3QgaXMgaW52YWxpZCBvciB3aXRoIHdyb25nIHdyaXRlIGFjY2Vzcw0KPj4+Pj4+Pg0KPj4+
Pj4+PiBBY3R1YWxseSBnZXRfcHJlZmV0Y2hhYmxlX21yKCkgd2lsbCByZXR1cm4gTlVMTCBpZiBp
dCBzZWUgYWJvdmUgY29uZGl0aW9ucw0KPj4+Pj4+IE5vLCBnZXRfcHJlZmV0Y2hhYmxlX21yKCkg
cmV0dXJucyBOVUxMIGlmIHRoZSBta2V5IGlzIGludmFsaWQNCj4+Pj4+IEFuZCB3aGF0IGlzIHRo
aXM/DQo+Pj4+PiAgICAxNzAxIHN0YXRpYyBzdHJ1Y3QgbWx4NV9pYl9tciAqDQo+Pj4+PiAgICAx
NzAyIGdldF9wcmVmZXRjaGFibGVfbXIoc3RydWN0IGliX3BkICpwZCwgZW51bSBpYl91dmVyYnNf
YWR2aXNlX21yX2FkdmljZSBhZHZpY2UsDQo+Pj4+PiAgICAxNzAzICAgICAgICAgICAgICAgICAg
ICAgdTMyIGxrZXkpDQo+Pj4+Pg0KPj4+Pj4gLi4uDQo+Pj4+Pg0KPj4+Pj4gICAgMTcyMSAgICAg
ICAgIC8qIHByZWZldGNoIHdpdGggd3JpdGUtYWNjZXNzIG11c3QgYmUgc3VwcG9ydGVkIGJ5IHRo
ZSBNUiAqLw0KPj4+Pj4gICAgMTcyMiAgICAgICAgIGlmIChhZHZpY2UgPT0gSUJfVVZFUkJTX0FE
VklTRV9NUl9BRFZJQ0VfUFJFRkVUQ0hfV1JJVEUgJiYNCj4+Pj4+ICAgIDE3MjMgICAgICAgICAg
ICAgIW1yLT51bWVtLT53cml0YWJsZSkgew0KPj4+Pj4gICAgMTcyNCAgICAgICAgICAgICAgICAg
bXIgPSBOVUxMOw0KPj4+Pj4gICAgMTcyNSAgICAgICAgICAgICAgICAgZ290byBlbmQ7DQo+Pj4+
PiAgICAxNzI2ICAgICAgICAgfQ0KPj4+PiBJIHdvdWxkIHNheSB0aGF0IGlzIGFuIGludmFsaWQg
bWtleQ0KPj4+IEkgc2VlIGl0IGlzIGFzIHdyb25nIHdyaXRlIGFjY2Vzcy4NCj4+IEl0IGp1c3Qg
bWVhbnMgdGhlIG1hbiBwYWdlIGlzIHdyb25nDQo+IG9rLCBpdCBjYW4gYmUgYSBzb2x1dGlvbiB0
b28uDQoNCkl0IHNvdW5kcyBnb29kLsKgIEkgd2lsbCB0cnkgdG8gdXBkYXRlIHRoZSBtYW5wYWdl
IGlidl9hZHZpc2VfbXIoMykgaW5zdGVhZC4NCg0KDQpUaGFua3MNClpoaWppYW4NCg==
