Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF89525A5A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351978AbiEMDqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 23:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376914AbiEMDqL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 23:46:11 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227347567
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 20:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652413570; x=1683949570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HipIRS6uahSPkTnG/8NzGQE9t95VFG0mNtBmqq7WYlk=;
  b=w4nsK47GY5Vkm+YJzptI4E30KFXNbVGu6WDDLGy4D7cO3xfRg0W30wKT
   kAvoFCLwYK0pB9qInRim2uuKE0JSxyaUqOP+mrX5WYZa+kGdF51nlPSxa
   KRSGuPtbBi+TmncT8UoZMaFI5nZycULzq0Dt06tKvmtVrLa76usFBhNqU
   uj3iDRr9dczgSP6103xSxctfOPOREdOL3RlYolaMdMwz/8QnT8O67Rxju
   O12xj6HN4kdqzh472/g25WPkEVDrAfoA1TCCyQ/GYu1g4B36/3sHMtX3T
   CC1iKWgK7q/dpdAuq0NcebQgKSnYMkcu49gnh95c+SYq2aJPKvFfqmJQW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="55716949"
X-IronPort-AV: E=Sophos;i="5.91,221,1647270000"; 
   d="scan'208";a="55716949"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 12:46:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7tMgdKKKUIJVX5qVkOtWrjS79yP0FRr4eLgU7Wjv1OCa2bZmI8RDv/7ABEDq2cCbXNgJ+zfBwfMmISK71daoDGHFxi4mtb5bI0uIDJ5aRjVWOWoxz0kYtiE1K7V6qJq97jFZoROLDk7OE3O3IGY+PdVb9B+wXQz9XlzNKMxOlG57W9aaLOX+PqKqmMY2HUfNnZVrP1iuERyK7K4O/CAqwVr+AGS28s8j6DwO7IIHK49NqDYP0ZiASawoRQ6keiAcNh869E/tUaid34iCeifNwfyWyrK0iFhiso+L7e6iIUfU8HYl7nBMLa6Qb0hNKWOaAx9JQnVzJZoYErL7gmv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HipIRS6uahSPkTnG/8NzGQE9t95VFG0mNtBmqq7WYlk=;
 b=jzSdre0iwfEPd75dUBXlyYEF4NCpKfCtB9EiMsakwu6kpnLrx3jjF+spG6SaWfwJKlLk3Z6iP7nVeS0hq2aJ1QlcxkAgA1M/tJuAxpT3mODGbEHzn4Fkk6SiwVNfhY6KQhMvl6xdhe6KHP8kx9FcUF06J1OLiS/k3YepKiMqGV+ZxgyJSwmrSoWhAv70G71KMmnsK7XjP4MDR9LGdvLmUFIhz2Q+EFpjAOB9FEHMD7wvhl52kI4/gF7t7e72jkMUAQTGS+FVpgRfNukLh1SDUM3tI+40v17OO7qDmACC1f3ler+m1GumSyzhvVWdXAEwjlLBosy5VNGx+khNio1SXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HipIRS6uahSPkTnG/8NzGQE9t95VFG0mNtBmqq7WYlk=;
 b=OywHOt5myTiSF2jhNsjANcS6/j6YtTlGGv9uoy137gZKS+2r9lM1bA98SdG0GC/jmVeHoaCJOiOREz1oL+RP5N5YK7bzZaXfQI+nkS0lepS4rzhknd2Ejp5saZuBRBWmgBazhfKpy9kVliaIIsZkLQmYRAAAf09WcA5kvydf2yg=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYAPR01MB5101.jpnprd01.prod.outlook.com (2603:1096:404:123::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 03:46:01 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930%6]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 03:46:00 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHYUutUn9XU4R6Jekm3O/NqdHUgQq0cUhOA
Date:   Fri, 13 May 2022 03:46:00 +0000
Message-ID: <8d88406f-cb19-134b-0a1b-ed2b2aea6a91@fujitsu.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220418061244.89025-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81442e70-1f16-4025-deb2-08da349318c3
x-ms-traffictypediagnostic: TYAPR01MB5101:EE_
x-microsoft-antispam-prvs: <TYAPR01MB51011F405E75325A5C60F12A83CA9@TYAPR01MB5101.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1qfUfXm+pd1/fzwy38MK+QQVuGjFLDZNT82Y62iD8eYFYOt19gjyYqpvSb6bPuotEwv3igME9f5jpIdL1x7auZztxkbUezHsE1m7HhV8cb+//X/KnqzGkuSFg8E6gSirZ5RBNUT9hlloUGDEld+2l4lxC5gkluWJgu1dvtS880R15S0UtKLlUP5d86aM4RCwJTI8muKFrFPrOUB3VaGMmB7rLgfXNt+XhaOmhEAc1iJ0ETHePK2f4LDMQYuuxLpgNh4QTcZXaFF/mJ/yguYhESEsjP1h6pw1MPeEzmCusFH3buGCzPTZ4AA+BTjHIUsUrG0iOrwhy/f2DtOyRVPS8FvYbset6HMfw57RDjA5uTnlxaq37kwalJ3nCmDpqVea8lfriyFMh68k14Z7OfFyN0b5RLZdk/Okq+WGrQaO3M0orny/Zxe0bf0FvkKtl8oL5R3DcrAWmvxGzqNJta8G6kt9lwenSN66hzyeEEw9w5Aq064h4P64ohWY33yHbUB/quhePkhkwwef0VEVCt6UmhLZ3QJbjm8OuIhDcj8IvKBeP9AUi9rQKCVUKoZZzNZIVMy5t5g3WkM+Z7Am5UIt/3HNSBhnpT4ZgkOeeZUwENjIspRSDG65+zk+ORs+TmLNV7BURf3+s3gPqnFNw4mFcAtJcHYYDG20Qedq5fhuWqoxVp9tZyAhkx6i3U/AmQmuoqfXQanQNh6YZ4VpljJUrSZnlNcAbhYtHzhvtEIk/kk3LGf4v3kmQxojivuY2O1j/UjHZT/Nu7rgK2EumpUyo1AnGd/IrL0WjRjkkBK2Lan29/dP06xPCmqrlQtR7Kn8RXHQVkIsIDGGrY/OY3RS6eCudqemtOeRAOzsU4VNiDLf4oL3iCR6ck5IRBV/x4oBmg1KOyfItoeWSRSLYbCvQSxKARg0G3HnO5QG+kJXDU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(2906002)(66476007)(66446008)(64756008)(91956017)(53546011)(66946007)(76116006)(71200400001)(31696002)(31686004)(508600001)(36756003)(6486002)(6512007)(26005)(8676002)(38070700005)(966005)(4326008)(186003)(82960400001)(83380400001)(316002)(122000001)(85182001)(86362001)(6916009)(38100700002)(54906003)(6506007)(8936002)(2616005)(43620500001)(15398625002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVJJeTZaNmUvVmZCNW9JdTFzdXpSRWVmT09na0RaN3hhYlJzM29aZzhrdGhH?=
 =?utf-8?B?TkNFckkrY3drSWNiQ0orWmEwckJ2SE92dFcrV3QvTjlkUFFuWFoweDZxNVVO?=
 =?utf-8?B?Y0pFc1JjVnlRdThtTkVYMzk1bksrNm1mczN5WHRJTWZWT2JyU3gvSVNOeXQy?=
 =?utf-8?B?bWZGVi9NWEYzQ1FPbmw1b3k0TlBSY2RDbkFYb05tdlBvRFIwTGhCZ3Y2RzhU?=
 =?utf-8?B?SzhySDlSd3I4U1dORDlESXJyWTdVRHh3MmV0TmhXbTRXbzZoWStMdTloeE9Y?=
 =?utf-8?B?c2hYYTZWVkFVZHd6WkJOdVVGRGE2RmhieW1pMzBwYVpQa29oeG9KY01ka3Z0?=
 =?utf-8?B?b1ZGV1FUMDJyRkJCLzdyL1UxV1Q4U0RjMWw1Y3p2TlBURW9LSTZWQ3lnck12?=
 =?utf-8?B?VXkyOFFvK2ZEMHRONXdKMHYxRlgySUU3U0Nsd2xTUkpGYkFhY2ZyOU5ZeHl6?=
 =?utf-8?B?NTNPbmNGcEhFM0NrcDJFRUc2T2ZUZWRwUG5UN29HMVFJa21sM29yYjNPNVl4?=
 =?utf-8?B?N202UDRwbWNXWjJndXVYWjdsK29KcDFNYThNendtQnI5OVkxQVZSNXJmQkZX?=
 =?utf-8?B?L2prOENGREJmUEJMRTVBYnNRMGVtYzJGQ2VJVzMxcDJlakNyaS9PaS9RUU12?=
 =?utf-8?B?K2g3bm5mQWF6VnJQeXBPbXBhdklhRTl4ZXJXVW1vaStrd09qaGpGOC9rL3pM?=
 =?utf-8?B?akV2Q0ZObDVtYnZEV1g4SFVkdFhtUDczKys2a1kxVzZKYUhCZHcxdWVMMjEv?=
 =?utf-8?B?MW9vYkZabGQxMXFNQ0FZZm5MaE5ZZHdtMDRva0R3OTh5a3k0NWtSK1ZiVTBi?=
 =?utf-8?B?Nk5CVTZuZFNnUHBSYlBrVENhbU5ORitiS25kTXM1SlU2amtlKzhiKzBWY2lT?=
 =?utf-8?B?dGkvL1p2MmZNczN6WjlyRWh2bGQ1cHZzNXZ3S2xIMk5xN2M1N3MvVVgrbFMw?=
 =?utf-8?B?bUUzMEVVc0poS1QzWms4QjFaQndsMlJxZFdjRlR2d3gxckFUSG1majdGRGQv?=
 =?utf-8?B?QmRLbzJXRjdIL0JqRFBtdmhRMFFSVWpGS3lmS1NFWWtJU1VKYmVnNGlqc0V0?=
 =?utf-8?B?bk9JQzBtTDM5clBVc3JuaXR4clV1RGhKWXo4aTFTNHNBczQxMU91L2xTYjcz?=
 =?utf-8?B?SmRpUEZnZ3htMDcvY1NDOVpDdlZ3cVpuN3Zka0I1SWdSQWM1N0gwaUFwMnhZ?=
 =?utf-8?B?SSsvZEpRMnJPelpNcjhqRkcySFQ3VWU1SU1KRENFOXpDbHBwemhTb0ZRa3E0?=
 =?utf-8?B?cGEyOEFKUlZJK3Bpa29HeUh3NUNLUjI1bTlMcXIzaVFiWmtqM2YvODNlQVRh?=
 =?utf-8?B?RmVyS3VxTGZGc2NQT1QwN0VobXZEUnRGV0ZTeHU2U0wyV0d0OVJQaHd2blYz?=
 =?utf-8?B?MDdmN2FKSWN0ZmxwV1kvdHo0ZStoMkhrcGVDNGdjdmtOL0s4UjRjQ3RzZDlY?=
 =?utf-8?B?K290MFpGQ3RZTGVQVEFEMTQ4Q084NEpDUEZxYTNxT2V2Y0xqWFA5WGNhbElF?=
 =?utf-8?B?RVFmNk0vUDNaOVNHSGtnRm9EbEFZaFR1WWdlanB0M3RQUG1lNFY1Mmc5eEZ5?=
 =?utf-8?B?N2hTUCtLWlUwR2ZzdnBSU0ZHVHZVdVlrRVRZZ2NQeVdTNTVIdFUyK2FQZ0tE?=
 =?utf-8?B?N3dBS05HWjVUaElodzhaamVjWDUwVWpEUkRyOW51UGNMeGRMSXFsWXdkdWtX?=
 =?utf-8?B?WGh0bTJNY1NDNlc3TUU2NjA3NDZoMjFKckhtS3FuUnhGVFNnZzErM0hILy8w?=
 =?utf-8?B?eEprTGZ3ZDB4aytxZUIrUnh4ZjNUMDdzWUs0eXJEWU9ESGZRdnBRcFVWZTgr?=
 =?utf-8?B?KzdvYkk0NzJ5N1ZpWllocmRrS3hqSGQ5c29QTnY4cW9GeUVXREU5UU83Y1Zw?=
 =?utf-8?B?Z1JhbXVXdVpJQkFKNk9OckJpb3hqakNQdld6UURoUEpueER2aVBsZldDWEdu?=
 =?utf-8?B?bmIzNEpTL1VRSEtoVmtidDEwWXJ4aXNWMHVUaFFvRjl3UnRGbDUrRFBYRldK?=
 =?utf-8?B?L1RZMEtSZ3F0dStIeC9tWHFHb1hkNko2MmsvMVlXVXEweHIxR2tpSm9lMXZC?=
 =?utf-8?B?UjgrUWNuVXJqdG5nL241bTZTbnZqQzZYUDJsRENsQTJodFlnU2Fua0VVUkxw?=
 =?utf-8?B?aWpoSncrYU9KaWErLzhrN1dLQXlMM0VkME5la09kVE8xZ1R2UFR1MU13MXdP?=
 =?utf-8?B?ODVXQ0w2ZW1JZ2owNUNLRm5KN2NpbDJZZkZ4QVZ5b3pxZ29jMFZEcTVhTklH?=
 =?utf-8?B?SXU2MjFGbkpvQUtPdGs2UnZ6SjZrWFRQVUZmZU55dWd2bWRSWjkzMlZ4ZVU4?=
 =?utf-8?B?T2Z6VXRaNldteE1NcHIwdlAzSlFMd3JMK1FrN0Q5eXNoL29adnY1SHdtSHY4?=
 =?utf-8?Q?qXFcmfAEpI0uEkjQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BDEDE50735244687D2C6DA2B4A62D8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81442e70-1f16-4025-deb2-08da349318c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 03:46:00.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2BnIDPdYxj63tkcj7v6Thl5+aEUa53pSg3Hj1xzNt2CXFrPeJVvce+LighUjnOuFlQQ4Zci7rhQAQ6wjEQq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5101
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgQWxsLA0KDQpQaW5nLiBeX14NCkFyZSB0aGVyZSBtb3JlIGNvbW1lbnRzIG9uIHRoaXMgcGF0
Y2ggc2V0Pw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCg0KT24gMjAyMi80LzE4IDE0OjEy
LCBYaWFvIFlhbmcgd3JvdGU6DQo+IFRoZSBJQiBTUEVDIHYxLjVbMV0gZGVmaW5lZCBuZXcgUkRN
QSBBdG9taWMgV3JpdGUgb3BlcmF0aW9uLiBUaGlzDQo+IHBhdGNoc2V0IG1ha2VzIFNvZnRSb0NF
IHN1cHBvcnQgbmV3IFJETUEgQXRvbWljIFdyaXRlIG9uIFJDIHNlcnZpY2UuDQo+IA0KPiBJIGFk
ZCBpYnZfd3JfcmRtYV9hdG9taWNfd3JpdGUoKSBhbmQgYSByZG1hX2F0b21pY193cml0ZSBleGFt
cGxlIG9uIG15DQo+IHJkbWEtY29yZSByZXBvc2l0b3J5WzJdLiAgWW91IGNhbiB2ZXJpZnkgdGhl
IHBhdGNoc2V0IGJ5IGJ1aWxkaW5nIGFuZA0KPiBydW5uaW5nIHRoZSByZG1hX2F0b21pY193cml0
ZSBleGFtcGxlLg0KPiBzZXJ2ZXI6DQo+ICQgLi9yZG1hX2F0b21pY193cml0ZV9zZXJ2ZXIgLXMg
W3NlcnZlcl9hZGRyZXNzXSAtcCBbcG9ydF9udW1iZXJdDQo+IGNsaWVudDoNCj4gJCAuL3JkbWFf
YXRvbWljX3dyaXRlX2NsaWVudCAtcyBbc2VydmVyX2FkZHJlc3NdIC1wIFtwb3J0X251bWJlcl0N
Cj4gDQo+IFsxXTogaHR0cHM6Ly93d3cuaW5maW5pYmFuZHRhLm9yZy93cC1jb250ZW50L3VwbG9h
ZHMvMjAyMS8wOC9JQlRBLU92ZXJ2aWV3LW9mLUlCVEEtVm9sdW1lLTEtUmVsZWFzZS0xLjUtYW5k
LU1QRS0yMDIxLTA4LTE3LVNlY3VyZS5wcHR4DQo+IFsyXTogaHR0cHM6Ly9naXRodWIuY29tL3lh
bmd4LWp5L3JkbWEtY29yZS90cmVlL25ld19hcGlfd2l0aF9wb2ludA0KPiANCj4gdjMtPnY0Og0K
PiAxKSBSZWJhc2Ugb24gY3VycmVudCB3aXAvamdnLWZvci1uZXh0DQo+IDIpIEZpeCBhIGNvbXBp
bGVyIGVycm9yIG9uIDMyLWJpdCBhcmNoIChlLmcuIHBhcmlzYykgYnkgZGlzYWJsaW5nIFJETUEg
QXRvbWljIFdyaXRlDQo+IDMpIFJlcGxhY2UgNjQtYml0IHZhbHVlIHdpdGggOC1ieXRlIGFycmF5
IGZvciBSRE1BIEF0b21pYyBXcml0ZQ0KPiANCj4gVjItPlYzOg0KPiAxKSBSZWJhc2UNCj4gMikg
QWRkIFJETUEgQXRvbWljIFdyaXRlIGF0dHJpYnV0ZSBmb3IgcnhlIGRldmljZQ0KPiANCj4gVjEt
PlYyOg0KPiAxKSBTZXQgSUJfT1BDT0RFX1JETUFfQVRPTUlDX1dSSVRFIHRvIDB4MUQNCj4gMikg
QWRkIHJkbWEuYXRvbWljX3dyIGluIHN0cnVjdCByeGVfc2VuZF93ciBhbmQgdXNlIGl0IHRvIHBh
c3MgdGhlIGF0b21pYyB3cml0ZSB2YWx1ZQ0KPiAzKSBVc2Ugc21wX3N0b3JlX3JlbGVhc2UoKSB0
byBlbnN1cmUgdGhhdCBhbGwgcHJpb3Igb3BlcmF0aW9ucyBoYXZlIGNvbXBsZXRlZA0KPiANCj4g
WGlhbyBZYW5nICgzKToNCj4gICAgUkRNQS9yeGU6IFJlbmFtZSBzZW5kX2F0b21pY19hY2soKSBh
bmQgYXRvbWljIG1lbWJlciBvZiBzdHJ1Y3QNCj4gICAgICByZXNwX3Jlcw0KPiAgICBSRE1BL3J4
ZTogU3VwcG9ydCBSRE1BIEF0b21pYyBXcml0ZSBvcGVyYXRpb24NCj4gICAgUkRNQS9yeGU6IEFk
ZCBSRE1BIEF0b21pYyBXcml0ZSBhdHRyaWJ1dGUgZm9yIHJ4ZSBkZXZpY2UNCj4gDQo+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jICAgfCAgNCArKw0KPiAgIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX29wY29kZS5jIHwgMTkgKysrKysrKysNCj4gICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUuaCB8ICAzICsrDQo+ICAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCAgfCAgNSArKysNCj4gICBkcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9xcC5jICAgICB8ICA0ICstDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfcmVxLmMgICAgfCAxMyArKysrKy0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9yZXNwLmMgICB8IDYxICsrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuaCAgfCAgMiArLQ0KPiAgIGluY2x1ZGUv
cmRtYS9pYl9wYWNrLmggICAgICAgICAgICAgICAgIHwgIDIgKw0KPiAgIGluY2x1ZGUvcmRtYS9p
Yl92ZXJicy5oICAgICAgICAgICAgICAgIHwgIDMgKysNCj4gICBpbmNsdWRlL3VhcGkvcmRtYS9p
Yl91c2VyX3ZlcmJzLmggICAgICB8ICA0ICsrDQo+ICAgaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91
c2VyX3J4ZS5oICAgICAgfCAgMSArDQo+ICAgMTIgZmlsZXMgY2hhbmdlZCwgMTAzIGluc2VydGlv
bnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiA=
