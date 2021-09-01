Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613283FD323
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 07:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhIAFnh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 01:43:37 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:14036 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242018AbhIAFnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 01:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630474962; x=1662010962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zlKGZzx+EKyBUliOaUKE/xd7dgwKCvTdbTt2SkHe4Rk=;
  b=rssLrCr2ZDG1Nihnw+1qz35PCdiByiqxAgrINRaYZ7jCXjLTvE+c2WmT
   KZOaTdPq57ysb3CuSpN6uVZyHCGHc3UGh6cJxyfbovrw54Z60nlUBSRA3
   qizUjGG8mFpFN35/O3g748whOl+EJO7eOL4k9geX1p9vgD1XGpR8YdTMk
   XkyaVQ3sP1yanZd2WMtUJKqMiRQ/I0i9bqr5QI8nUwuURz3TIE4BRdtEf
   L/rH4h6hDSMIj1e7R7TsptnoH7nKIr5DgV+dOCLqLKCbEgBw9JqCex3Ke
   WNdN0rKgeB7pDhICf5S16FceaVby3HT9M2X3KX2aFf65kUZZg6RC5FQfd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="37903713"
X-IronPort-AV: E=Sophos;i="5.84,368,1620658800"; 
   d="scan'208";a="37903713"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:42:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeSWLxCEFnTJbubSPr8vQBwB+qaHA77r+JBcTXwxbkpjWeDVMLhf3lCn9GKgdevHbuddSrizCxhJykjz1/GEjjoEDdQBhZ4jaNbjM5Q81Tt7wq1aOsG/UKflV6MYsEseVgnm8E0TktBUdAEYfWX9Z8EG4Rh8I9qNqzXgCFyLNeqIG8pNDkKdMg6jqDugRJDfhbcNHDwtQLSzJPj5kBqFpF7j9CHLg878QWRHEz28vbGD6Gcis+ANDXDPf7tA+8u8FdQYfrsCM6bh19LlLadK61JXEMbRGuQmFY+wgzQXuhUcxIB8uUyfLK5L1s/ieDVsgjAF6dIXbT65inaVcBR9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlKGZzx+EKyBUliOaUKE/xd7dgwKCvTdbTt2SkHe4Rk=;
 b=P9ZMCchqXvcqTo1bK4ozPBrUW0lHL3NlbcRX4QlzJn+sFqa1U3vU6gdRA5Emp4jDf9+ZOi4vEMCxJg9+HRp5cVHpYWvYi9Fc/deShXHbX5+S0nb2tpXt8dvOOUFpoNSm51H42GBPoYQtuGGjbBS4gDdrAWzRSnULtBuoskV7hPSIrnQLJ3He3WHp4pztlf1L59o40BPez5NpRRdmNTGADWkWX/eSrgNMJKMKRi3/TJa0piYuqJx6XdY7x/ERCIHejWMEz44f2++I0xhpvcGt4r3/PYKQ08RbrAMOL1sy/e4UQcalugU41MOBA1OyNWlw+S74qVBeZLTllD9AAgIJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlKGZzx+EKyBUliOaUKE/xd7dgwKCvTdbTt2SkHe4Rk=;
 b=cmW9oa7oRyCVB3TbrvyMbeeBSYfsBjOV7/bX+zFFobwKbYoBXJ5KVwnM6VmcMbc8Gdo5taHVq5dP5tejzPwojG0HYjwjjXTktrn61Nlk2jXpicvDDc1E1Cpu7fF/yjT16OiZvlqqNaNkXpTknQ5lXz7u4IsGOZ7JjAWCfQ6D+yo=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB6226.jpnprd01.prod.outlook.com (2603:1096:604:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Wed, 1 Sep
 2021 05:42:34 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2%6]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:42:34 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Topic: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Thread-Index: AQHXlbAkwqjHlJzA7Ue2Vhqx7eRcdKt9juEAgAL254CAABI+AIAACeqAgAAIXYCADhKjAA==
Date:   Wed, 1 Sep 2021 05:42:33 +0000
Message-ID: <612F12C8.8080701@fujitsu.com>
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
 <CAD=hENffdb237oicsjwecE1Os9WZNhTkUrn7RUiM2YQwHP51fQ@mail.gmail.com>
 <61232609.7020500@fujitsu.com>
 <CAD=hENcMv9d-gTdEpXtgUwSm45d89LwWsHJiUALUUmhsEiU+Cg@mail.gmail.com>
 <61233DA7.7020006@fujitsu.com>
 <CAD=hENcaTYhvive_irxQXtTgRZREYPqi253XVane+Nz2WRHQLA@mail.gmail.com>
In-Reply-To: <CAD=hENcaTYhvive_irxQXtTgRZREYPqi253XVane+Nz2WRHQLA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9fb76cb-c4b7-4a21-d558-08d96d0b4c42
x-ms-traffictypediagnostic: OS3PR01MB6226:
x-microsoft-antispam-prvs: <OS3PR01MB6226CCACA97BF7A9B6F244F283CD9@OS3PR01MB6226.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4BmlHOBAjtR/Blg/VZeqrBcOwPuTWOEVEvDgR2DNQNYnNZHoajlpF1/NUecNPTVhMPEJptslSjPBzPPK3gbfyChhrRWL4rtPG+Q/lChMqmP6eLImSFObZkzuvo4V2fLYBe5kK1Gcq9x2QfH2+6/tx/nd1WDHWBPyIVivfIfJaXOGdiPPW7meetCez356M+H91M/b3a2dXD9iTBGzIg46ZorFp3bBjcZ9+l9vljYnY5mje8XeWcwFB8HY3KtNUqW45m/Yu+sRdmVqeq5G4vOB7Md7na7mIzUcfhWWNxE3bdWq0w75/Lbu/KkPmu2k96DdrPL0TIstPb/k/8yaABwbf4hMOMFufc5hRcPLhQrvn2+7s0Qn3yovCRq0792Zd2oP5ufxv5NbRq+TTqkYNrmH5wG3KCRIwXjjuKHGj6aTNhA0YmLf4QF+LCIqKFaqmGPOWuuI/YS8mmn/3Xe8cURE61jnpTTyupDf8XhBNapE9CMEtkorJP3Yss4koH+E9mmfNP/tV8XV4C04b+HHy/lFTB/PdksgZbm4BCfTqdbGetNdwpNyRtCwJg+hg7amDS/HktxoVLTysnITgUqIO2Az7ydd757gQ71L6bYAWCD01dKF9LJG1lEjI0KWFWyYR0T1IVTZHTrpFolUirS/Nz143EyAUx7jWGJe/ORy7l2V0MguWlqZj6pmLtilIAF9wFcR5zT92Yq3TUrxOWla9g3Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(2906002)(53546011)(6512007)(6916009)(66946007)(86362001)(6506007)(66476007)(66556008)(5660300002)(26005)(6486002)(38100700002)(316002)(478600001)(71200400001)(33656002)(91956017)(2616005)(54906003)(8936002)(122000001)(87266011)(4744005)(66446008)(85182001)(4326008)(64756008)(38070700005)(8676002)(186003)(76116006)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEhPT1FUd2ZaNUdNcXJZYmozR2orODFvZHJON2o3UVFQUHAzRHFpUWFLTVJo?=
 =?utf-8?B?WFZpSUg1WjhRTVFJdHpDT0FsZHRkQmdPWEpmWWJwNkFhMGxZcXRyRkVYSFY5?=
 =?utf-8?B?b3luZTBkMnFlcENZM1JFSENaaUpwdjk5MkRoQlBvODgyL213MDNUbkJ4YS9V?=
 =?utf-8?B?SlZwa2EyRWNOMDUyVXU5Ly9oZW5DRFVVR0tLdDJMSENoUUdTVmtkWm5iN0l0?=
 =?utf-8?B?bkNTLy85NVZDZjVPM0hLK3YwaW9GVEtMRmIvK1MwZ1pwZERTa3pjQlM3dlEx?=
 =?utf-8?B?dGlkNUJxLzFXcVFrWDF2MkYxZTlIaVlQdHUvbGdCTXpmbjVhOXVKOHVHVy80?=
 =?utf-8?B?Z1VXdjIvSklUMjVSY3YvSVo5Z016ZDNQbFlHSEtIem52bVNWZFRRSXFnekZx?=
 =?utf-8?B?ZlJXeTJreHZlTzh4SWh1ZDQrYUwyaTVVZ2Q5d1Q3L3kxMjNwMnpzcDVmem5n?=
 =?utf-8?B?cDA0VWkvWm1IcWZHSTk4MGFIUklvUXQzU2MzRnhaWVNTZHY1WUgzZFJ2N3dK?=
 =?utf-8?B?TVk1anV4dnBiQkowcm1yOVd5TjdhcmNoVStiRTNQczJGZXJkN2VNY1pNaWow?=
 =?utf-8?B?Ym0xNzRIeE5VNGlwVzY5ZXdWVVBrRkJ1aXlZNWszSE0zRlFUZW82K3pmdDdS?=
 =?utf-8?B?VHRMNFYzRmRJUWh6eWxSNkhadEFFVVJwWEpIOHlyeDZUY25ERnJFM2UzeXFz?=
 =?utf-8?B?WDdqVUFQR2dvc3V3SkZGcUg1QlZQcXorM2ZpUjJVTENkNnRwb29iUDJxM1NB?=
 =?utf-8?B?UFlFR3BCSjBrczlTcmFXT1Q2TjcwZlJKc0VRSkdZZURrc1lzSFRlVlhHdi9I?=
 =?utf-8?B?YnE0b1BrdVFteFBrQTZHS2I3SkpySGVLaDlGMCtyUStMYW9IY3FwSHdVZnZG?=
 =?utf-8?B?VEZoWTJ4bnMxZ29zWk4zTmRWWmdRcTBKNTNZU0J6L0d4KzB0cWowRGdVZzZh?=
 =?utf-8?B?bGRSVEhFWWdxUjV1SDJNL2EwY0VNLzdMUGlmaGs4M2Y4dDNEcFFtSmtuZGV4?=
 =?utf-8?B?RmVpQ2NEa0I1L091MzM2Y24vVDF4RXVHMVdRTVhlbkorNE84aGRoWS9mclNE?=
 =?utf-8?B?Qm8xdTRhMUlYalcwNVpHb3dudE0zeTBWOENJTkRKbG9OdVB3bDdteW1PNEJt?=
 =?utf-8?B?QjVwdTdYSURQNllEY1FsbnU4aEJiSFlLL3hYNnFaQlYxT3RhYTU5SDQwcDBS?=
 =?utf-8?B?a2I2ODlHczRlOUxvampBMkovR0FkejNyeTFxTjRuQ1pMSWN5cGI1UUpuUFNx?=
 =?utf-8?B?M0ptcXdWS1JlaUxYVGFseG4yTlBuZHQrbVI4OHNaOFl5OVRvOENOOWthUnFN?=
 =?utf-8?B?bk5MTGpubERxRjJWc1AxbFRFV1ZESDE2cng3STVmQVBoaDdXd2kyaXlyUEU2?=
 =?utf-8?B?SXhIME9DTHhtTjBXaXNTYWV0WFFhSm1qZ2lzWk5oMXZnR2tWbVZJS1ZrbVNs?=
 =?utf-8?B?RnFQcXUvSEUxOVlqZkpYSTdvYnZTbjlMY0tGV3Y1dmEzWUNOMW9IOFhUR255?=
 =?utf-8?B?TkVIaVQ5TURmV09YeUxPYks0emkrUW1GMHVDVTZ0bEozRnE1RUF6c2hwZm9X?=
 =?utf-8?B?WEdiWEJDVUN4cjZHdGZkN1pmdlFURU5JaHBaSDd1YVpkMXNYaEtGSkl1T0tB?=
 =?utf-8?B?VXAxZm5hRDhwUjFlZ3RoejRBYkIyS2U1Y2FodndvRDluV3ZtNjNkeWdhQ0xM?=
 =?utf-8?B?WTN0U0ZOV0VTdmZ3QUJoSFpNZFZnbmcxYnE2Y2Q0ZkFuWVd3S0FJblEvNGpz?=
 =?utf-8?B?S051OHQ3Vm9NVmxMQU1FQ3V2UU5HR05PNG9TZUZhTUEzbThiUEROazNqQTV0?=
 =?utf-8?B?UHVTUkZOcFhKeW9qK1pUZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F8C4C7C9ACF53458ACF1ACBD6F58454@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fb76cb-c4b7-4a21-d558-08d96d0b4c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 05:42:34.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ0T5/2lrpkErwQreuUalqdzaFpj2uUa2zmbNdfrsCGOz+MjAq5ELeANHDsdHGuJlqH/dErTHRtzuI9iDzxWNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6226
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzIzIDE0OjQ4LCBaaHUgWWFuanVuIHdyb3RlOg0KPiBDYW4geW91IHJlcHJvZHVj
ZSB0aGlzIHByb2JsZW0gb24gVWJ1bnR1IDIwLjA0Pw0KSGkgWWFuanVuLA0KDQpJIGNhbm5vdCBy
ZXByb2R1Y2UgdGhpcyBpc3N1ZSBvbiBVYnVudHUgMjAuMDQgdm0gZm9yIG5vdy4NCkkgdGhpbmsg
SSBkaWRuJ3QgaGl0IHRoZSBjb25kaXRpb24gd2hlcmUgcS0+aW5kZXggZ2V0cyB0aGUgcmFuZG9t
IHZhbHVlIA0KYWZ0ZXIga21hbGxvYygpLg0KUGVyaGFwcyBvbmx5IHdoZW4gYWxsb2NhdGluZyB0
aGUgbWVtb3J5IHdoaWNoIGhhcyBiZWVuIHVzZWQgYW5kIGZyZWVkIA0KYmVmb3JlLg0KDQpCZXN0
IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4gVGhhbmtzLA0KPiBaaHUgWWFuanVuDQo=
