Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3895577990
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 04:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGRCN0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Jul 2022 22:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiGRCNZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Jul 2022 22:13:25 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9A10559
        for <linux-rdma@vger.kernel.org>; Sun, 17 Jul 2022 19:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658110404; x=1689646404;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=q54e4+Z3h93JCJ7Xz0RHOzQXaHurxSkUQ3+h3LOPUdE=;
  b=pU81imZvUJ3jxk5SKR3sfpTntIQQfUQbkxYDGiWh1saQEOyrn7l5xaXc
   wFgrNr1Pp836Lnhp6Vmq8J4HuNo7XbN720326+1PgThxMIa7SGyRRK0s2
   RGe3GgkQUBrnicQcD0Q4UGc2TjFNmgX3ba0qDTIrlLLPC7uD0F7Feox7T
   tHe4tZVYk5HMmuw8QHpnogfGTloLaJQ6YzTJPXqslUvN4zKpvx3vyrR5q
   J7HCRJzPKUVQdiAGK9T96CUhaK3BcHgCSYTTnT3AToIcinAIdHAVtnN4F
   Gm07jjZj3bT3y76fDCARtlYCkO54Gqo+18lY4+YU0snU8aVHDnFLuhoNv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="68827331"
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800"; 
   d="scan'208";a="68827331"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:13:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKsAwNvrYdfYK6LlHy8yvk/tD5sfzcRB7bVzz7H0s4HWMouN5DjnObW8sDROZ/w2lk2V6yCYTPFD854+3Sfn5icC1terhEgYzUXj7sD+or5bqY8XjwfbSpYPp0ajHGFvSCkH7uXe6pLKxBZ4F2TX7OYQuGNvOe3x/6YqHZvueVvc3lpiJcMWvdGr9YOmig5HETCIOoh1i5vc9+u686pJ/1U+IPOznSOXjoTj58POiGXRuWjhe2mI/HDZUDRADv1NJH2k8S7pe+Bd+sxVmGTtgOqhfzFE2e73La9SApOit0vvPSX3BiWxM+PDuh94vIZuxUP8feSLoSqSwznS3kasWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q54e4+Z3h93JCJ7Xz0RHOzQXaHurxSkUQ3+h3LOPUdE=;
 b=UK3TUHNu4Tt4Fnj7NFMSg0W0EUwjt+CGRTlMfqZ6dsHtNhh31kOwK1WHaKSmguZkcQKdLbspSzKediJarwW5OachT5AtWjLjVQ8s63KIozAcj46KndPJDLiyT+yrtHcj4U2w+eRLA12XFq9l4w364QH5xWbvO8JgN4U00OLG/hriL9GcqxE9NXvRCtKVxUqtf9FROzdAlyF0nuuuUl3vlKTyUkQM3ZlFJ15i+9gBccqcXMNiVCG/h8iJ7i0m4vul4qtnwVe/HsiwXk9jrjLdaNbkTybjl9n37XAgrxDtwSHvFitlioHeP3KXSrYiQJO1Xzi4tZstdn3EU9Gb55OfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q54e4+Z3h93JCJ7Xz0RHOzQXaHurxSkUQ3+h3LOPUdE=;
 b=dYbgXNgj1szGE+FsRiIYzuKfLuP/6LhmvGhzMNCmCzxxrT+ti1+BZQvM+Fdf6hgnRR0CCE910kmD8C0ECyBAbG0LjT8lYur3tqp3vAUzGsHqd+fCu3dSE7B403a1Yom3QVdz4O/j5TxvLSzYk940Vr5KF/itsFb0Xvhe+o7TKsM=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB2028.jpnprd01.prod.outlook.com (2603:1096:404:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 02:13:15 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 02:13:15 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2 1/9] RDMA/rxe: Add rxe_is_fenced() subroutine
Thread-Topic: [PATCH for-next v2 1/9] RDMA/rxe: Add rxe_is_fenced() subroutine
Thread-Index: AQHYjLR3WrcpnE+dK0aks+22RVtK562DfnYA
Date:   Mon, 18 Jul 2022 02:13:15 +0000
Message-ID: <b7bfe498-28d7-7619-d1dd-40def9c9e10d@fujitsu.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
 <20220630190425.2251-2-rpearsonhpe@gmail.com>
In-Reply-To: <20220630190425.2251-2-rpearsonhpe@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfed77f1-9c3d-419b-bccb-08da686312c0
x-ms-traffictypediagnostic: TY2PR01MB2028:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T2fMX91WXqk9qaVOnvXerFteovoUn08YNoiMKqsdIEqX7c8Ei3/O3qVkVgk/Y/XJLzalG7HTUBJRQlcldPiywhWor/wtvZFxBvaZX/E/dkJlAHviqA5D+PlTCfp0a1WqHASwDpxUZOxOF/Mb26APZ84SFq/Y1JxxEzGjgmt5+GMkQQ1rB+Nfj7Svvj2u0wiJlQkC32iEyMZkpjv4bxI7OJW2WTQ2vBUT1uXnVeD6DeRNBdJJXBSuBlVIrRZv7ban5G8Gd4P+asU/Qqa4N9NBvo7H0RLi6Dp5LZqHpz4CnolG7l1fucZW7qJns+z1XSXFWghzgoC+pQltrgNzsaORCREbJYz1npR3fJtXiq6UAK+VD+Fe78g17dflbxDknkgRsz7LGTft6JEEnu8C96+Di5XEu1ETva1RcHL0mFdpA2tDNHB5neuIcPoiX/CFXHB6byCNa1v8NzpSsQ9h8ro23w+aHJjs6jDhsYNROOaG1Tz+HZiTOTYVvzLbVU69Q5Lk9iynW/sGGr4F9UeudCHLY/t7DkHAcpWxwb55r4Biu26igWx5mrBkvBluwFBYgYMjh8JUdnkFKC+voevUUSHhtaYqVUN2jY0ZFOGbykOBgqBupTj6AvCvb5upvzw0LQjsRsF4N6d6BdKTDYbvs58cCBVht5JwVvg8b7CjVV0rnqv7Wjb0xjhZ2tJjlrFxbVfm7ohvCEk5Ojtc3cRMhZ39tXY6TmkvTKSmOJbDZQoS5W/OmdmDhURaXNU8COpzba/NaGvDgEvVgCoc4zv/hcLPManzTJc7pC4DuwNKSkRXcTrbGxCYHsKVqqo3OtYOdJUL4DA7ruOZ8FA18rIyfKBaGgSWdD6J6ndYLBrVvh8Flqsd8aRuT3jzN+MsoydKDUhl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(8936002)(5660300002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(31696002)(76116006)(2906002)(38100700002)(122000001)(36756003)(85182001)(2616005)(82960400001)(38070700005)(6486002)(71200400001)(41300700001)(478600001)(91956017)(110136005)(316002)(186003)(83380400001)(53546011)(6506007)(26005)(6512007)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVNyQVI5SnFrWC8xblR6cUFyWS9rckkwV3FRYXFINHhaeE1iOUVEdmNsWGxr?=
 =?utf-8?B?OGN5RE1RK1ZqbEZWRjZNcnEvVlNzdDl0dFQwaHZTdFNVeVFWdWRRSDVud0hi?=
 =?utf-8?B?TldGdzZCaGIvdmJHY0ZOdk5MazdDbGsyT3FzdEVSYS8vZW51TEJ1ZUJkL0t1?=
 =?utf-8?B?ZUx0bGUwZFh5R082VmxpRWlWUEt3ZFZBbTJCUUdrT2k1T2NFQ2hRUVBSYm5L?=
 =?utf-8?B?MlcyK1NhYzJmUjVYZklpc0FHZ3JqYzE4aGJXaFRTWkhJczRCRC94YUJSM1RC?=
 =?utf-8?B?ZFVWZmhQNTloc2RJd3BPQUp2aGpsaTFHZU9TQ2U3ZHhXcVpMSFZ4ZEt3bEVl?=
 =?utf-8?B?SzJ0bDdzOC93NWZVN3YzWGVxeElEem16dnRaallxdDllN0RGaFYyVjhRTGVj?=
 =?utf-8?B?ZlEyd1gvcUNXSnNJYkJ4VExpOGYxSXh1QVErcE90eFllK3Y3OWVHSGhCUzU2?=
 =?utf-8?B?eTQzQWpuQ3lER1ZwRFB4ZEVSL1l0cnlrQXViMERpMURwU3Nlanowa3dibml1?=
 =?utf-8?B?TnFjc1FZWDJveVVTeEZvOXpMM0ZhZkJkWjhnVFFtRkJWVytSbkIzbWRLcExB?=
 =?utf-8?B?TGhUTGx1TGppQjduU1pvUGt6T3p1ZkZZTVlBbVAwa01sRDV6WDlqbGNveFVV?=
 =?utf-8?B?VHRGNTU5V2tXUFdzeE83L1FjSGJwZTE3d2ZsMm5pNE1xSm05a0dyWVRGWmhC?=
 =?utf-8?B?cVoxeXBFNDdwUGJ2ZjFOMjZJUGZPcUNvN2VIMHN2TTA1RWtKRjJWQ3lZWTl3?=
 =?utf-8?B?YlAwdnlnS0xLZ2FBZ280OWtlR1IxQXc1ekVhdXNHTHY2RVpkN2JOVFQ3N1Ir?=
 =?utf-8?B?ZUFuWVk2L1pYVURkTU94NkdOK1M4ckJtajIvcDRTdG5zdVlyL3g5RytSN3JC?=
 =?utf-8?B?K3RTcEdqNjhmbDBjTUNCUWM3WkxwUU1YOHJkVFZSMnJ6N1ViRWJURExTRGxm?=
 =?utf-8?B?cnBpZWRBMkJHL1p6SEZaTnpTYlNaT0VMU1JBTUFDOVV2akpZa3dtSFpVTEVa?=
 =?utf-8?B?aTZkZjRSOU9rck14UXpBd29IMXpRZ1JvZUY2Mis4RmcyS0tKaWt0Z2ZxR2Rv?=
 =?utf-8?B?Y2FSMFdmdVlydUtVL3JlQ3F0UDgrT2xBczZjNDFsUGpJNDBJQWhnZWgwNW5p?=
 =?utf-8?B?TFArZVYwNGdrbnBxNWFUelNDSWpSc1kvYTZVME5xczVPUStCZGFmdVhFd0Ny?=
 =?utf-8?B?di85OXVQSTk4SThSbzJkM1JMMGdLUDIzcVRPMUNGcjBTQWNFeHBNcHkxWDNW?=
 =?utf-8?B?YmViUHlPMVZWR2puWTIzM00xNEVwbTRoWHVveis2cmtPWGd0NnozaHlIcEtm?=
 =?utf-8?B?cGlVblNoMnBhQ2lvTVYxdXdGVGNqU0EvVi9xTWE0bWl6WTA3ajRsUmZWU1JB?=
 =?utf-8?B?WndCMUNVTXhTZWhxeTdsdENoZm41WlYvT2VmR1JCWVlMYlhhN1ZydEdaRFIv?=
 =?utf-8?B?TjNQZ0xpcjBpYnJGWnptN0hINGVOSlFJSjJhVlBLWVVDWEtaSExsMHR2ZWFH?=
 =?utf-8?B?RGdTNVNyUGlwRWozQlFrNXpLc2ZFRkJaV2NNT0pPNU81UG9zNDVHV01UNVA1?=
 =?utf-8?B?dEs5cnI0bUNUUVVwS080bHlLeG8yQllFa1lvRUd0N2h1VkhDMVR4VjhnUzVW?=
 =?utf-8?B?NGg5K01GWGJkTVI1WEZ5RHlhR0VPb1ZzOVhzUnVhWnFHemtiOU1hRFdOWXpY?=
 =?utf-8?B?NnNMOEJhZ2dUZjRQQjZTeDE0QzFyNWphK1VWZElXaHFBQTdNbDFmdGd3bDRu?=
 =?utf-8?B?bk9XYUtzWlVZUUdJdDhXY3RKSXJEREs0TmJmSDUvNDhsKzZ2bEMwUzkvb2lu?=
 =?utf-8?B?VEtjL3RKZXducUUyRU1BTU5VY3drK3U0ZkVmdnRYYi95RWc2d2dRK09xazdz?=
 =?utf-8?B?aGdqV2xqNzBjRTg0NkszY2VJN2o0TXBvcUhDNCtjRDhyaHU5MEg1cjFqd0dj?=
 =?utf-8?B?QmJ0amsydWgzMTNjUGVtTndqNW5MbXVUem1TajJNUkVTUTF4STZIbHQ3Nmti?=
 =?utf-8?B?Z1FsRERsQUtpc3BZaEl6dUkrSHMydnJVWUFFRFBOSis0WHk2SmY4cUJUR2lT?=
 =?utf-8?B?UGV5ZEFXLytaZlRHRDZQaktubnpqZ3U3UDdNS29Bb3Q3dC8xcUJCV2ZWR0VL?=
 =?utf-8?B?akVheERDcVRqbWk0Yllod0ZldDlMeGo3dExJY3NTTU5CMzhNM0xkdFhZaytZ?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9DD4A75314E6B43AF47ACF78D3E92B2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfed77f1-9c3d-419b-bccb-08da686312c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 02:13:15.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NDI0vHVLhmG0i6wxx6Q2hdYolXQhlUwNsOblw0Pm4LZ3Lk8VA2moQLaO9Bk2/yNx+OtUXHCVXdZIcyMkfZtng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2028
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAxLzA3LzIwMjIgMDM6MDQsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBUaGUgY29kZSB0
aGMgdGhhdCBkZWNpZGVzIHdoZXRoZXIgdG8gZGVmZXIgZXhlY3V0aW9uIG9mIGEgd3FlIGluDQo+
IHJ4ZV9yZXF1ZXN0ZXIuYyBpcyBpc29sYXRlZCBpbnRvIGEgc3Vicm91dGluZSByeGVfaXNfZmVu
Y2VkKCkNCj4gYW5kIHJlbW92ZWQgZnJvbSB0aGUgY2FsbCB0byByZXFfbmV4dF93cWUoKS4gVGhl
IGNvbmRpdGlvbiB3aGV0aGVyDQo+IGEgd3FlIHNob3VsZCBiZSBmZW5jZWQgaXMgY2hhbmdlZCB0
byBjb21wbHkgd2l0aCB0aGUgSUJBLiBDdXJyZW50bHkNCj4gYW4gb3BlcmF0aW9uIGlzIGZlbmNl
ZCBpZiB0aGUgZmVuY2UgYml0IGlzIHNldCBpbiB0aGUgd3FlIGZsYWdzIGFuZA0KPiB0aGUgbGFz
dCB3cWUgaGFzIG5vdCBjb21wbGV0ZWQuIEZvciBub3JtYWwgb3BlcmF0aW9ucyB0aGUgSUJBDQo+
IGFjdHVhbGx5IG9ubHkgcmVxdWlyZXMgdGhhdCB0aGUgbGFzdCByZWFkIG9yIGF0b21pYyBvcGVy
YXRpb24gaXMNCj4gY29tcGxldGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJvYiBQZWFyc29uIDxy
cGVhcnNvbmhwZUBnbWFpbC5jb20+DQpMb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTog
TGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gLS0tDQo+IHYyIHJlcGxh
Y2VzICJSRE1BL3J4ZTogRml4IGluY29ycmVjdCBmZW5jaW5nIg0KPg0KPiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gaW5kZXggOWQ5ODIzNzM4OWNm
Li5lOGExNjY0YTQwZWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX3JlcS5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQo+
IEBAIC0xNjEsMTYgKzE2MSwzNiBAQCBzdGF0aWMgc3RydWN0IHJ4ZV9zZW5kX3dxZSAqcmVxX25l
eHRfd3FlKHN0cnVjdCByeGVfcXAgKnFwKQ0KPiAgIAkJICAgICAod3FlLT5zdGF0ZSAhPSB3cWVf
c3RhdGVfcHJvY2Vzc2luZykpKQ0KPiAgIAkJcmV0dXJuIE5VTEw7DQo+ICAgDQo+IC0JaWYgKHVu
bGlrZWx5KCh3cWUtPndyLnNlbmRfZmxhZ3MgJiBJQl9TRU5EX0ZFTkNFKSAmJg0KPiAtCQkJCQkJ
ICAgICAoaW5kZXggIT0gY29ucykpKSB7DQo+IC0JCXFwLT5yZXEud2FpdF9mZW5jZSA9IDE7DQo+
IC0JCXJldHVybiBOVUxMOw0KPiAtCX0NCj4gLQ0KPiAgIAl3cWUtPm1hc2sgPSB3cl9vcGNvZGVf
bWFzayh3cWUtPndyLm9wY29kZSwgcXApOw0KPiAgIAlyZXR1cm4gd3FlOw0KPiAgIH0NCj4gICAN
Cj4gKy8qKg0KPiArICogcnhlX3dxZV9pc19mZW5jZWQgLSBjaGVjayBpZiBuZXh0IHdxZSBpcyBm
ZW5jZWQNCj4gKyAqIEBxcDogdGhlIHF1ZXVlIHBhaXINCj4gKyAqIEB3cWU6IHRoZSBuZXh0IHdx
ZQ0KPiArICoNCj4gKyAqIFJldHVybnM6IDEgaWYgd3FlIG5lZWRzIHRvIHdhaXQNCj4gKyAqCSAg
ICAwIGlmIHdxZSBpcyByZWFkeSB0byBnbw0KPiArICovDQo+ICtzdGF0aWMgaW50IHJ4ZV93cWVf
aXNfZmVuY2VkKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3NlbmRfd3FlICp3cWUpDQo+
ICt7DQo+ICsJLyogTG9jYWwgaW52YWxpZGF0ZSBmZW5jZSAoTElGKSBzZWUgSUJBIDEwLjYuNS4x
DQo+ICsJICogUmVxdWlyZXMgQUxMIHByZXZpb3VzIG9wZXJhdGlvbnMgb24gdGhlIHNlbmQgcXVl
dWUNCj4gKwkgKiBhcmUgY29tcGxldGUuIE1ha2UgbWFuZGF0b3J5IGZvciB0aGUgcnhlIGRyaXZl
ci4NCj4gKwkgKi8NCj4gKwlpZiAod3FlLT53ci5vcGNvZGUgPT0gSUJfV1JfTE9DQUxfSU5WKQ0K
PiArCQlyZXR1cm4gcXAtPnJlcS53cWVfaW5kZXggIT0gcXVldWVfZ2V0X2NvbnN1bWVyKHFwLT5z
cS5xdWV1ZSwNCj4gKwkJCQkJCVFVRVVFX1RZUEVfRlJPTV9DTElFTlQpOw0KPiArDQo+ICsJLyog
RmVuY2Ugc2VlIElCQSAxMC44LjMuMw0KPiArCSAqIFJlcXVpcmVzIHRoYXQgYWxsIHByZXZpb3Vz
IHJlYWQgYW5kIGF0b21pYyBvcGVyYXRpb25zDQo+ICsJICogYXJlIGNvbXBsZXRlLg0KPiArCSAq
Lw0KPiArCXJldHVybiAod3FlLT53ci5zZW5kX2ZsYWdzICYgSUJfU0VORF9GRU5DRSkgJiYNCj4g
KwkJYXRvbWljX3JlYWQoJnFwLT5yZXEucmRfYXRvbWljKSAhPSBxcC0+YXR0ci5tYXhfcmRfYXRv
bWljOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBuZXh0X29wY29kZV9yYyhzdHJ1Y3Qgcnhl
X3FwICpxcCwgdTMyIG9wY29kZSwgaW50IGZpdHMpDQo+ICAgew0KPiAgIAlzd2l0Y2ggKG9wY29k
ZSkgew0KPiBAQCAtNjMyLDYgKzY1MiwxMSBAQCBpbnQgcnhlX3JlcXVlc3Rlcih2b2lkICphcmcp
DQo+ICAgCWlmICh1bmxpa2VseSghd3FlKSkNCj4gICAJCWdvdG8gZXhpdDsNCj4gICANCj4gKwlp
ZiAocnhlX3dxZV9pc19mZW5jZWQocXAsIHdxZSkpIHsNCj4gKwkJcXAtPnJlcS53YWl0X2ZlbmNl
ID0gMTsNCj4gKwkJZ290byBleGl0Ow0KPiArCX0NCj4gKw0KPiAgIAlpZiAod3FlLT5tYXNrICYg
V1JfTE9DQUxfT1BfTUFTSykgew0KPiAgIAkJcmV0ID0gcnhlX2RvX2xvY2FsX29wcyhxcCwgd3Fl
KTsNCj4gICAJCWlmICh1bmxpa2VseShyZXQpKQ0K
