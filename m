Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFC4839D4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 02:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiADBcW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 20:32:22 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:20002 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbiADBcV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 20:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641259942; x=1672795942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zr1AWVbR+fcZlu8/qUhtmNqvPsUYNQMHOFZyD31EwFY=;
  b=vcVoYu5VkWrOhLyT9K8rpHyrSJ+trMDIv4p9a1fCial4QLsbRLKhLsl6
   FW62aH3q8zI30PQ4afcmyGKDVWCQytY8Ei6iocBDlN7M+mvczp8Ln9uO9
   iglBnpdQdDByC1kXIVVUXvKY7NG8Vm/ZeV0yj+FavF1mztFTvyJo8dTI0
   2qoIKgMrxGA9zflx5cFsW3O5tC8zBr22Q9SG44WOohV6ILuFA4mlWrQrO
   Ix4l0a9T0ua4cxfhhafIxj6uVGbRIJRO8/uPMHWneVVr1VqU7y90xgAW8
   3Lah2ZVDAeCs2ATBMnnh122ulwZconHy2MltsM1CRI2Lni2iJ3aq26OIQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="46897721"
X-IronPort-AV: E=Sophos;i="5.88,258,1635174000"; 
   d="scan'208";a="46897721"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 10:32:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6OyiHVRzcjgJGqM97ZAlPrlrlLUa3YXJabpLl+3sEAtsESFh1hptb8IhTpDrbFOiIzcyLCR+AE0fdz8kYbNT05FhgXamuDcYr/dh6ZxhuooQYTruXBerER8vmex99D/Zu41LzHrGKgk1vWB9WvunWkG4QbPQ8iu/MRTEK8xPg5g1XavhbnO2ikBYq0tfEzcixWiOdtdJ03PUHZUwTm/Voq6DJxk3uc/oZLeZ74IVxRTUf4MdsjD/36Pnkx9OmBtP8S13bnLsI49JMDw5q5RCesVqD5Qe5aGBhlqCf3t/LbgG1s4x9Iy+QtlBYX/d5TCK2wOSlr+di/HttThxZpqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr1AWVbR+fcZlu8/qUhtmNqvPsUYNQMHOFZyD31EwFY=;
 b=BAzKVZ/0Qa/U0JGK5gbuxRX3SPhdY/Q/+0qYuAta8H8Ho2xwMvC/YEjJTZDcfDGoz2qCQfuyzXIEBqXT8mG3a//0c/hXBNRkQEhAxIRVy7ekwXQ8XjFr58koSTWsFeF/HLHVfl0RTRBXglfkOk2lz2VWJpSrdOAB+b4mNVdOHnvHeKZZxMhTfhyQNiKWYmgtpuhzCAh4uC0/BrZSG/gI1xWWLcZ617jwnUNptQUh2nWy/io4C3BMPxoKEKD2D98MVKZbgQ2/xSvPvRuSIRmMXWd0QPBnlS4AHueBOpOrVlZIKmPjwKEfm+V7LXzuCdCPwsMJlvCwX0D0pOs0gWybYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr1AWVbR+fcZlu8/qUhtmNqvPsUYNQMHOFZyD31EwFY=;
 b=heRjvMCjLYOtHBipq0DcWN9BHRAwuQNa3qgmRJ/5Y2pyVQQ4Q6te5BgY+TKqh1D036B6fOmMB4Z39EwMhZh19aI81ncz3QVgqNjVbRWYIkx2OSCxblbgwY3GqwyXTL/Vy1ZEW3UThT1bEzE+DvRyNggO6ItYDUy4Vjq8zZbfPG8=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OSZPR01MB8797.jpnprd01.prod.outlook.com (2603:1096:604:159::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 01:32:14 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::b4f0:aae1:eae4:2439]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::b4f0:aae1:eae4:2439%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 01:32:14 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Tom Talpey <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 05/10] RDMA/rxe: Allow registering
 persistent flag for pmem MR only
Thread-Topic: [RFC PATCH rdma-next 05/10] RDMA/rxe: Allow registering
 persistent flag for pmem MR only
Thread-Index: AQHX+8EvplXpTw43GUqgtpn7ngqG46xLoKmAgABWnICAALnaAIAFbTUA
Date:   Tue, 4 Jan 2022 01:32:14 +0000
Message-ID: <a8be8bd2-2cf6-d9b9-950d-40db4d8beb7d@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-6-lizhijian@cn.fujitsu.com>
 <45bfd837-a784-5ea2-7ae0-46e7e557b030@talpey.com>
 <15ad4285-7a74-2b3f-1c1e-823b36cfcf82@fujitsu.com>
 <b865c232-6652-bbc9-0676-b435fa03e98b@talpey.com>
In-Reply-To: <b865c232-6652-bbc9-0676-b435fa03e98b@talpey.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0466c41-c23f-4d6d-50e7-08d9cf22096d
x-ms-traffictypediagnostic: OSZPR01MB8797:EE_
x-microsoft-antispam-prvs: <OSZPR01MB879713D7A8CAB33D79DF696CA54A9@OSZPR01MB8797.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJeFhG+Lvi/c6yuchq5tZuJ7rbSpkwAdrIYCHsIvwW0p/Jr2rnaqQTOFJBphzJqvB60n6vFs7uMuRP739LABbxMMEiCzn3N+xVKw8BzAIrZ6RIt7ZknilhLXc12+TAEzTEnoOrwfjb64Mv+hI+yppUJkG7aeM08I4dKGM4E1JaFqpMzqpuHoXLsflJfto8AQPK2vPmaj37m6Xqs3gK0jnbNkB5dDIhOC3SFLgUDyzvpyVkAk5HBHFvuFaCs2cxDp9ynlWc57gJ+2BJHpA62cAbzT0AutSXJ9G2MR2+kcjaGYoCM0dtdnK+hfUlRhRH1F09G5IMxadMLrxQezPQJAQgNzQqoTVRTE3rrX91YQ45kehAE38sIPLJ/OrBmrJIvhriTLCcTTCP/PDhONCjbXzmzBRrBNLFqz0ukYozTUWxjxGEeUOusz+PcGnZVUTFkuZk3LbVhfFalL+xoxcb2KFYVwd4GIWqX3moqdzMed/MxLuTjI0HcgUGuPwC73iNaBztsxd9d5HzrHfqZfIwksQb61erQC+06ucwVB1645zbdE29IyTuaPbnLbgGfpJuuJ8JcqQXYMD7jCdS2duNDtKWOgm9Jhx4PhiAGq2+scC5BpMLcNf6OHIdMANHXhbhE17fVB+IIlkUqx+0h5eWHgSEU+1NN9CHJXRPu0wB+Vp55lnofU+yAsyUO81tJ0xd8uEvINKyWytaIBRkJbmwpwuM2VNT8x+dVoOsQvEb41SGa2YvqPBJqdHcu4mEjcZQ/W8r1OSobDsu3Zp9PhvP98nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(4744005)(31686004)(107886003)(6506007)(316002)(5660300002)(54906003)(36756003)(66946007)(66556008)(64756008)(76116006)(110136005)(6512007)(66446008)(122000001)(38100700002)(71200400001)(6486002)(508600001)(8936002)(91956017)(38070700005)(85182001)(66476007)(8676002)(26005)(82960400001)(7416002)(83380400001)(2616005)(86362001)(2906002)(31696002)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTlTZUtWQXBsQ0JmVXgzdHFnMm5ZZlpVdndJM1lGNkVQK1JaYVlvektIbS9H?=
 =?utf-8?B?R2RaaHJwZWZtVFJwWTdFU2ZDZjgrdGYxUDRwUFZYcDcrb0JPVHNtb0d1eVVp?=
 =?utf-8?B?ZXFJakFscGJiYndMa29DSTYydTByNjRmaDdOMEJjbHlZczBrLzVoZVZBaVhm?=
 =?utf-8?B?clpXSnBpZkxWVFVqNndzdVlEaVFmaHFOZzlQYXNkMkUvQjl5VkVkWTUrV2U1?=
 =?utf-8?B?a1diK3FhWkQ3N0V4dTBVbEU2RW1OUVlyNFhkc2x3d0xiMmRFb0MzRU1xZmlY?=
 =?utf-8?B?bkRSamo5QnN5WEdCSVV1UzVzNEZ1aENIZHAwVUxVYldXU3dwK0NNZzJCYmYz?=
 =?utf-8?B?VWRlQ2FMUWZ0NXJNVS9wZ1JZVSs5dVdROTVvR1kzYXc5ZzR4Z3RKOTlSTXEx?=
 =?utf-8?B?Sk11Q1NmMUxRbDh6WWxzRW1PTk9XbXBRLzdPZGdpZysxQ1lRMSttVlloYjhD?=
 =?utf-8?B?bDlSdklZa2YvYzEzK1h0anJST1pzVzZEZzQxcTZvK2JQMlBHT21TSEZ0S3Yr?=
 =?utf-8?B?eElYT1R1aGtzcjIzNVN2RDZqeFF0V0V3eFpMMksvZkFib2lQQnQxLzVCRmF0?=
 =?utf-8?B?RHo4ZEJ1dUJKQ2FydmZmd1g4ay9sSk9TWGh2UzFFMUYxOHV3SzZjbFh2UVlJ?=
 =?utf-8?B?UWp6MjNzV0xlSVpuOFhIamYvbzQ1Rk5WeU5WQ2FINXBGcVRUbUJSN015RTFs?=
 =?utf-8?B?UVUxTGt1dWh0YXNFc2tHVW4zaGNkbkhNVXM1Ui9QZitkRmY1UUhKTVNNYVNL?=
 =?utf-8?B?TDBGdlNZWTN0Y2JFUFhFMm1LRDhNWFJjTG0veS9UdVZxdzdlRmRrcVdwUEF6?=
 =?utf-8?B?aHRJYW5nZmxJckpVK3BYSkVrL1dKSFV1dDZnVmI3aHVWL1ZxQ0MrNWV5QTZx?=
 =?utf-8?B?RXFaRmhTRko0Y1Y1Y1BUZnhhc1l6eW9RUDBZa1JHK3VHbmdoaUYzUjN2Ymoy?=
 =?utf-8?B?YlZyWFQzeXExUG1DSVZickFwaldzQ0s3SEVpWDBCajBZc0FKaDBseDdFQkoy?=
 =?utf-8?B?RlMvTEZ6ZHE1YW81QW02OUtOcFVNbW9ZK0s3Zmg0aCtLb3k4Z3BKUDloN2RR?=
 =?utf-8?B?YlNHOFVBQ25pUERveHNqdUZzemtycTI3bjBGLzc3ZzZwQkJ6V2MzejNiejFC?=
 =?utf-8?B?L2RpT1Y3MXE0NUJuTjh4alAyQ2tZYzkrZjZIUjV0QWk0aU1vcHlBUDE3dnlq?=
 =?utf-8?B?WWVDOFZjYldVeSsxbkhibjE4anNhbGkvcFFtZjd6cE9kS2R4N0NCK3l4M3VX?=
 =?utf-8?B?d1RiSHYwVFlXL2hqVE9kb3hyV012THExMTF5VUhnODRnRWkrVU55eEd3L3R4?=
 =?utf-8?B?M2UvcXdKRTlrZ3pJamlUZ3hRZ2xsaW1haWVibVVPZU1oY1RuNXVzVElEY2J6?=
 =?utf-8?B?RmdFaWgrVURhMGU5bG9rN0V0MDFiNmtnUVRJcENITkJpaElSV2NoMnNST05t?=
 =?utf-8?B?ODN1dmdMYTV4enhadXRlcDZhYTh3a2VacWk1NG1Yb2UzbFpTbXRGRWxEQi9u?=
 =?utf-8?B?aTdSWGVsVjkrRFRnUFZoVi8xdU9KRDd1UllGbmhxQzliY3YraS9ZVmZvVlFE?=
 =?utf-8?B?RmlXeEc0T0poaEc3eHNjdzNoNmJld3laTHpHS2U4R1R3YlJrL2l1bFgyYXVS?=
 =?utf-8?B?UkhpWVJkWStuZ1Via3hFekUzY0tEVEJBQTN6dFdkVUVYd3JNcUQyTUtSOUVK?=
 =?utf-8?B?YlVROUlNZjh4NGpjNEtzbWs2OTZKOHJzOW9mYlZSaGZhbVpnWWlGcjFvbzIr?=
 =?utf-8?B?WmJqNUhXemtEcy9KTWJpUElGejhmNW1saGlPV0RtK3dtSlVucVNOdnFsbTkx?=
 =?utf-8?B?VHVhelI5cGpyTnFYbHovcFpFQnJxQ3YyMkFsQ1J5eVFDbVp4REZ3NFQwMTF1?=
 =?utf-8?B?eVQ3S2lxN2hTREdLc3MvSDNQUFhyQVZiZ0JUdlp6VmcrVm1PSDhSMXkwcHBU?=
 =?utf-8?B?Mm1RS2tqUGJlRk12b0NZSkRLdnhUYkx0Qyt4a0JSVWhyTjdXOC9BNHNTclVT?=
 =?utf-8?B?N1BrN0RqZUs5RmdCcXBHeGMvS25qWHBIaE9PSEJIU0wveTJ5VzJ3dDlydG9K?=
 =?utf-8?B?N2FQSWdHR1JqT1dIVXdMOWJQSDVMVVRTeU4rQkliRmEyWXVneENpWjdDNGgx?=
 =?utf-8?B?RkFRSTR5NSt6RjUybERZZHpiL2p0UzdyRGNHNkpDSlZRZ3lUMGJyRU04RjZu?=
 =?utf-8?Q?zVCOmhrPzrBtmXdE6l7OR94=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B959C456BDE5B42B830F1986A375446@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0466c41-c23f-4d6d-50e7-08d9cf22096d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 01:32:14.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ldMu2i/5t8z22fs/3CTqR4cKziXKc+530q28xSUOIXDCoFSH9sKMEO3t8Nfn3iw196wey2LBRjZ4m5F6k3eoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8797
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDMxLzEyLzIwMjEgMjI6NDAsIFRvbSBUYWxwZXkgd3JvdGU6DQo+IE9uIDEyLzMwLzIw
MjEgMTA6MzQgUE0sIGxpemhpamlhbkBmdWppdHN1LmNvbSB3cm90ZToNCj4NCj4+Pj4gwqDCoCAr
c3RhdGljIGJvb2wgaWJfY2hlY2tfZmx1c2hfYWNjZXNzX2ZsYWdzKHN0cnVjdCBpYl9tciAqbXIs
IHUzMiBmbGFncykNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCByZXR1cm4gbXItPmlzX3BtZW0gfHwg
IShmbGFncyAmIElCX0FDQ0VTU19GTFVTSF9QRVJTSVNURU5UKTsNCj4+Pj4gK30NCj4NCj4+PiBJ
dHMgbmFtZSBpcyBjb25mdXNpbmcgYW5kIG5lZWRzIHRvIGJlIGNsYXJpZmllZC4NCj4+DQo+PiBF
cnIswqAgbGV0IG1lIHNlZS4uLi4gYSBtb3JlIHN1aXRhYmxlIG5hbWUgaXMgdmVyeSB3ZWxjb21l
Lg0KPg0KPiBTaW5jZSB0aGUgc3Vicm91dGluZSBpcyByYXRoZXIgc2ltcGxlLCBhbmQgd2l0aCBv
bmx5IGEgc2luZ2xlDQo+IHJlZmVyZW5jZSBpbiBhIHNpbmdsZSBmaWxlLCBpdCB3b3VsZCBiZSBi
ZXN0IHRvIGp1c3QgcHVsbA0KPiB0aGUgdGVzdCBpbmxpbmUgYW5kIGRlbGV0ZSBpdC4gVGhpcyB3
b3VsZCBhbHNvIHJlbW92ZSBzb21lDQo+IGluZWZmaWNpZW50IGNvZGUuDQo+DQo+IMKgwqDCoMKg
IGlmIChmbGFncyAmIElCX0FDQ0VTU19GTFVTSF9QRVJTSVNURU5UKSB7DQo+IMKgwqDCoMKgwqDC
oMKgIGlmICghaW92YV9pbl9wbWVtKG1yLCBpb3ZhLCBsZW5ndGgpIHsNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwcl9lcnIoIkNhbm5vdCBzZXQgSUJfQUNDRVNTX0ZMVVNIX1BFUlNJU1RFTlQg
Zm9yIG5vbi1wbWVtIG1lbW9yeVxuIik7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXItPnN0
YXRlID0gUlhFX01SX1NUQVRFX0lOVkFMSUQ7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXIt
PnVtZW0gPSBOVUxMOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IC1FSU5WQUw7DQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfcmVsZWFzZV91bWVtOw0KPiDCoMKgwqDC
oMKgwqDCoCB9DQo+IMKgwqDCoMKgwqDCoMKgIG1yLT4gaWJtci5pc19wbWVtID0gdHJ1ZTsNCj4g
wqDCoMKgwqB9DQo+IC4uLg0KDQpNYWtlIHNlbnNlLg0KDQpUaGFua3MNClpoaWppYW4NCg0K
