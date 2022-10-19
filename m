Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C866C6040E0
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Oct 2022 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJSK0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Oct 2022 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJSK0L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Oct 2022 06:26:11 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF1DCAF1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Oct 2022 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666173939; x=1697709939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pT6rhe6PIi4r9YiKUNxiSgxOqHFww3YkIOTOdfuaHDA=;
  b=DDniWJ2ssq0nYaqqEU2IjSAtgtYHQhXy9Ma11naVgnB0IlrZB5SI1mAc
   RavmeO1RlOVU4dlaqf0gWKvEHPDBC36D+lBOtuwP7Hua/yFde8UeWsMH+
   zz0TK1MLH/N8bhGbeYb7PwhrqzZyNbiLZKM20+xjNVGtH3jC7yF+6AIBx
   dpy8NKgXOtnP98viUylWEwAPvA9TS+1Bcr00wgWEFc/sFQ1ZHPPH1AIdG
   1zgbi3WT6g0RIQuDIObe3NLZKu9n8Yp4wtGYS4N+mvOBPJ28JuuIpvSKQ
   TBi0Gc+Ius+Btixrv6P1st/KkKy/hUFvq52ZxNN6ykTzDZqavIQicd7rZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="68008928"
X-IronPort-AV: E=Sophos;i="5.95,195,1661785200"; 
   d="scan'208";a="68008928"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 18:39:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0lsmfcoHbrAPKIcf1L2/EHMws4NR40QI+stwY2d1lQCm5SHlEH5w4kDET4g3P2aUL50t3PF2MrdpOqy7vO9M6DLwifONoVPU+8cQO+Ybxi7+iISL352nnyRwbd3K5Wf5FE/8mra8+VsJyxWKHBFp2vqMj1u3vKSX6r8FsOcJfOROkFp2U2OXxJSTFroU2gD/b0M3Pto/VDjjU7iUIAZFdg2aRKpTJaQkVnGbaFBS/ODUHuBKS8zISjZMuSdZu4c/+ADYvooIIxfbQc0OuflWaIk3LY4+8jTmKJ9K3Q6+xcRxc+os1LJKuUVGvnQcVVYkhAgORnW9ipB3ExKLuq27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT6rhe6PIi4r9YiKUNxiSgxOqHFww3YkIOTOdfuaHDA=;
 b=NTcjHV3S7zYkANnpHnkUshl3ATlXal0vnI/iic/+uNzN12mJw9RWyWdLhTC3c1PSfyGieM0P2RavcoCAfrUY2W3SS+t6P33gVCIo4AhD/yV/huIksPdbZqFYOb5ljNi5bYU7kIVBBbg5jCWo9S+5m/6pUpT/Xs8J26veJ/Cx7g7ioGXjc79Njlj4UE8kFGU78NASIUrxoz5eOMbS+L+/OgfwLcVcvXOGJQeJcWuy/NjTd0YvLlASQ4JmbFdKbEsKVzGvAm2Duu7Rsvuj4S+bBbc+cYKnBG8jDHFoJIaSlk6iRt4DOsjthHPtdHc3X9hk/2jwmfoPg1Yye5+QtJtE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYBPR01MB5552.jpnprd01.prod.outlook.com (2603:1096:404:8026::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 09:39:34 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272%2]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 09:39:34 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jenny.hack@hpe.com" <jenny.hack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>
CC:     "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH 04/16] for-next RDMA/rxe: Make rxe_do_task static
Thread-Topic: [PATCH 04/16] for-next RDMA/rxe: Make rxe_do_task static
Thread-Index: AQHY4qsvA3fFNg0jgke+2PQriFQCx64VdeNQ
Date:   Wed, 19 Oct 2022 09:39:34 +0000
Message-ID: <TYCPR01MB84553AB5ECC0C2330BA91427E52B9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-5-rpearsonhpe@gmail.com>
In-Reply-To: <20221018043345.4033-5-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: b1e5811d3da14a6b98031098a0d21924
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTAtMTlUMDk6Mzk6?=
 =?utf-8?B?MzNaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1hMzJkZjg5Zi0xY2VmLTQxYzYt?=
 =?utf-8?B?ODI2ZC1jMTljZTdhNGY2ODc7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYBPR01MB5552:EE_
x-ms-office365-filtering-correlation-id: a7cc5a66-2433-4e9b-5733-08dab1b5d4dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5h0pURlqzuKJslCub5rX+8qQqBbokGAP1e1dd3NDn2mW6AK6cxX5McKjWLFV1NhjZ/VANmWCyB260x6m4JvlMKAc8Oj5X5s1MX+pukOn6Qj0GPbLICDzdF3No4nfNAPdHWOmMoxnHkBVS14cj8hz4zH76ipNLW6o2iNu7cN6onW6ViybnA6id71WllEgZr0Mj9IdRh8Nf20Qr6afPDHiMEJwxtwa9YfUOat78Z/PIFwa6HWfYeJYcLldAv+lqOzbJstywXgyXduzgPrKQKORuRzMMTt6AyFgns8L43olT1sBVgZDJGz5t9pgaBieWXnUalUkwla42wr002HXltMeT6K2ocFHcKSvXgVmdf+zbOMlxv/CGOyKSONNyMiSlftz6rcvOod6iVqI52FXhCuT68tq7LO3Y97gorQe5e+2tDEfpSJQf0Kb8jl4wLMyZLV8wEl8Qj5n05EKbS2nH+53T7kyypPY+YFrMw/ige/ztfDMTmxMgNjOeioyoL+byitiAbJ2+UKr2xMXcP40GQZn2GrW96zcZv6oFmOtf891tZczBJH62zZ9fQM/4wXCh9eBSunalT1F45LuIi33z6nqvy+Wp1FgQgWDIE44xW4xHxWaVs0Zghx/0mm05jlTGBvMNJ4RYFckX8LvbiWGD8gWnjPeoKb0YF3pLXNe+UCAXiJiXZhcugE7X95xbGfV1dwY40MAiZTU0Iq9AgOY+g4vCn6t8uZgQa3nV4je4DAIEebHrzynvslWAv/C4rNkBKsXDj3EdtZwqXJViv+xCOlOK2c2y5LhLNPq16xm5bH/cuc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(1590799012)(2906002)(186003)(33656002)(38100700002)(71200400001)(82960400001)(122000001)(38070700005)(478600001)(1580799009)(86362001)(66446008)(66476007)(66946007)(64756008)(8676002)(66556008)(4326008)(110136005)(76116006)(55016003)(8936002)(52536014)(107886003)(9686003)(7696005)(85182001)(6506007)(26005)(53546011)(83380400001)(41300700001)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTNnVUJHT0R0WlR2b2dXNkdsU0NDb1BnQUxJWlBrODluY3dEYkxYNW1objd2?=
 =?utf-8?B?UXV5TXhpUXdzOXBPVTBLb3BLNWc5L0luWXVpem5HQ2EwM3I0bHdodXVGZXIz?=
 =?utf-8?B?TkJoRE9kRmxBR3E1MFJBNVluTERqbUpwSEpBckJvQTA0YmJLTFFZTUwzNXdW?=
 =?utf-8?B?bkFDU1QrSkNJdkhmMHF4T3JtSE8yeU0zRUkxUGpnNktrNmpvNlVKSlZlNVRJ?=
 =?utf-8?B?WkpRdVJyYjV1ZDRFcEZhMEc5eXNuWmhnbXRiM2QrNmZVTi9JbWVvRTcrOFVi?=
 =?utf-8?B?OXhvNzU3VFJpdHAzSkZKNzBibjdIOTh6cUtQcWJhb1BaQUk2L0hZUHV6Nm1i?=
 =?utf-8?B?Q1pZK3R1VGl0ZUo0SUhFVHNKMC8yV2lCTHVGRkU1bFhodkViRnQrdWUxdkdl?=
 =?utf-8?B?UVNtSU54UUwxa01sQTFtVjdONTcvaXFaRmg0Y00rNVJkdmNPb3pXbFlqbGx6?=
 =?utf-8?B?TU9MQzBpOGpIdjk4djJjR2JSVU9wWmZpM1IwUThpSlN0UUNWbnZlbWNyM2Yz?=
 =?utf-8?B?ZWFoVlRUTTlMb08zMlRQbUtrMWM0b1Y2OEt5Yk93MUU1L0JpT1BLUDRWeEw0?=
 =?utf-8?B?bWdBYXgyaVpiZlI4MjB2RTkxaldzdjdWbWFUL25GQUh1TVdqaDhjMUUzaEIr?=
 =?utf-8?B?MzNzRGxMMFNHdjBDRHRSN3M4QWpBN201bjVHRmxzWXIrNHFzTlYyZmdQMVlB?=
 =?utf-8?B?NWFZY1lIWHpNRURVc0kwUHIzZ2xvbnZlMXdCT0Q5bUR3MEUweE5hMzF6YnYy?=
 =?utf-8?B?aUJDQlpMSDhtTFIwMU1ZWFZXOHM0VjN1Q09VNFNMSjJkY3ZiTzV2cjl6MElz?=
 =?utf-8?B?bTNlbnRscmdpa0l3WE1LKzZpWndkZnpsb0NCMmhoMTJYUE9tODgvaFRRRzEr?=
 =?utf-8?B?ZjF1UzgvSXRQdkk2RlF4RktQQVVxTVlXRjJrYVFWZENNRktWeGU4cnR3aS9i?=
 =?utf-8?B?Njk2Y3l3QUljOXc0T05WM2tmUGt4ZEwyZlhGd2xVTkhaZFB5eVl2UmNWNG1M?=
 =?utf-8?B?T3FqZ0hkdXhiR0h6VnIxL3JIRUxlMklXZmMyWjdYU1VxTm9DMmg5VlhYSDZX?=
 =?utf-8?B?dHhGZUhubFhZN3dzaldEVlV2NWIxNGh3THBpTEpLN0lhNWFwaTdJNHlNaGxC?=
 =?utf-8?B?dHVOcjV1UjlpbWhTeHJtUk9CUXVoQWt0anU2cEVuYmdDNDJ1UUdKVzc5ZXNJ?=
 =?utf-8?B?K0NFdHBHZU9vdFhmSDZ2WVg1L2NDTjhrYStUMzFHVUY1NjBVOW1LT2UvVnlD?=
 =?utf-8?B?S3pOM2tGSTU2SVN2ellTOXdoNmFqQ1diWDJ3djRMb3pCQ0RvSkxxSVNnWE53?=
 =?utf-8?B?NmFockgwaU9hbGJRdDRsOFkvaEFpaXNWam5UVm9xdE9DaDRrRjVLbGQzd05G?=
 =?utf-8?B?bVlvOXU1Q1o2M0pieWR6eDhJMEtlMmVWbDRPRlJkTXYzRXpHU1BzREdLRity?=
 =?utf-8?B?SDlacG9mTm9QWkxxdHlwRjYybUt0ZGJiaG1zN25wUE5ZUUFyQUY1MlBHQmJQ?=
 =?utf-8?B?RVdhVXZES2N0aDVUUXR4UStmTEsvYkp0SjdSbjZPOVhaTnZLb2xZMDdpTVJo?=
 =?utf-8?B?emN1cDA1UkZxUjBGbmE2SW1sc1NYcmcyK0tXV0JKbWR2SGthLzBsZHBrL2Vw?=
 =?utf-8?B?eXl0a3k0Sm1UT2l2VlBrRVRnN04xL2dWbWs3VDNGUXowR242MEgxc0svNlVJ?=
 =?utf-8?B?bUx6QXZKYXViMFV2UmE5MVRBRkM2QWNFZDV2T0lwVHo3eEhORW1QbFRjR0JV?=
 =?utf-8?B?ZVlhcENLc25UdXEwVVQwOC9vUDRpc3JYK1FVUndPWmcwT2VOemJ5ZjFXeEh5?=
 =?utf-8?B?WjlBRnpXU2pyZHI1QlIxWkh0ODgwWjExZ2dZQXh5UXRqNWEzMWJGTGNxNDVo?=
 =?utf-8?B?MkEvZEZxMWpVaEEyWXVrQ3ROdWxtRllaUXlVMys4MUhPL1Radmw5Z1E4dmY1?=
 =?utf-8?B?eHplcXgzTExBSG9XUmhlQnBxSllKa2JBYnUweWJDTS92NmNoZFNGZGx0YTB0?=
 =?utf-8?B?NWFLajJLWVNMMUJRRFNNa2Z4ck0wc0xZS3lFRTJ1SCtNSVFzMHBtWFRsYXJr?=
 =?utf-8?B?SFNEK0tpZEV3L0cyWkZNaEMyMDVEVmp3UWNtL0lhUnNlU3hoR09aZmZJNEh3?=
 =?utf-8?B?dVpyamJlbDEwa3EyNUdrMFVGOHMvaTdMNlZLV21lQ0V2d3QycmRZZnAyUExC?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cc5a66-2433-4e9b-5733-08dab1b5d4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 09:39:34.4441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCTud3TBlocpDTXYi9zrfyST8lWV6xM639iDNPLsqGao5cRhdo+3H+FjeB3YL4B9xNp2OrscM27556UcLi1NXvwn40u6PEGie9rRVKxA4eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5552
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBPY3QgMTgsIDIwMjIgMTozNCBQTSBCb2IgUGVhcnNvbiB3cm90ZToNCj4gVGhlIHN1
YnJvdXRpbmUgcnhlX2RvX3Rhc2soKSBpcyBvbmx5IGNhbGxlZCBpbiByeGVfdGFzay5jLiBUaGlz
IHBhdGNoDQo+IG1ha2VzIGl0IHN0YXRpYyBhbmQgcmVuYW1lcyBpdCBkb190YXNrKCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBJYW4gWmllbWJhIDxpYW4uemllbWJhQGhwZS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo+IC0tLQ0KV2hp
bGUgdGhlIGRlc2NyaXB0aW9uIGFib3ZlIHNheXMgInJlbmFtZXMgaXQgZG9fdGFzaygpIiwgdGhp
cyBwYXRjaA0KYWN0dWFsbHkgZG9lcyBub3QgcmVuYW1lLiBCZWNhdXNlIG9mIHRoaXMsIEkgZmFp
bGVkIHRvIGFwcGx5IHRoZSA1dGggcGF0Y2guDQoNCkJUVywgdGhhbmsgeW91IHZlcnkgbXVjaCBm
b3IgcG9zdGluZyB0aGUgcGF0Y2hlcy4NCg0KRGFpc3VrZQ0KDQo+ICBkcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV90YXNrLmMgfCAyICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV90YXNrLmggfCA4IC0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3Rhc2suYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2su
Yw0KPiBpbmRleCA0NDZlZTJjM2QzODEuLjA5N2RkYjE2YzIzMCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3Rhc2suYw0KPiBAQCAtMjgsNyArMjgsNyBAQCBpbnQgX19yeGVfZG9f
dGFzayhzdHJ1Y3QgcnhlX3Rhc2sgKnRhc2spDQo+ICAgKiBhIHNlY29uZCBjYWxsZXIgZmluZHMg
dGhlIHRhc2sgYWxyZWFkeSBydW5uaW5nDQo+ICAgKiBidXQgbG9va3MganVzdCBhZnRlciB0aGUg
bGFzdCBjYWxsIHRvIGZ1bmMNCj4gICAqLw0KPiAtdm9pZCByeGVfZG9fdGFzayhzdHJ1Y3QgdGFz
a2xldF9zdHJ1Y3QgKnQpDQo+ICtzdGF0aWMgdm9pZCByeGVfZG9fdGFzayhzdHJ1Y3QgdGFza2xl
dF9zdHJ1Y3QgKnQpDQo+ICB7DQo+ICAJaW50IGNvbnQ7DQo+ICAJaW50IHJldDsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaCBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaA0KPiBpbmRleCA1OTBiMWMxZDdlN2MuLjk5ZTAxNzNl
NWM0NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5o
DQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaA0KPiBAQCAtNDQs
MTQgKzQ0LDYgQEAgdm9pZCByeGVfY2xlYW51cF90YXNrKHN0cnVjdCByeGVfdGFzayAqdGFzayk7
DQo+ICAgKi8NCj4gIGludCBfX3J4ZV9kb190YXNrKHN0cnVjdCByeGVfdGFzayAqdGFzayk7DQo+
IA0KPiAtLyoNCj4gLSAqIGNvbW1vbiBmdW5jdGlvbiBjYWxsZWQgYnkgYW55IG9mIHRoZSBtYWlu
IHRhc2tsZXRzDQo+IC0gKiBJZiB0aGVyZSBpcyBhbnkgY2hhbmNlIHRoYXQgdGhlcmUgaXMgYWRk
aXRpb25hbA0KPiAtICogd29yayB0byBkbyBzb21lb25lIG11c3QgcmVzY2hlZHVsZSB0aGUgdGFz
ayBiZWZvcmUNCj4gLSAqIGxlYXZpbmcNCj4gLSAqLw0KPiAtdm9pZCByeGVfZG9fdGFzayhzdHJ1
Y3QgdGFza2xldF9zdHJ1Y3QgKnQpOw0KPiAtDQo+ICB2b2lkIHJ4ZV9ydW5fdGFzayhzdHJ1Y3Qg
cnhlX3Rhc2sgKnRhc2spOw0KPiANCj4gIHZvaWQgcnhlX3NjaGVkX3Rhc2soc3RydWN0IHJ4ZV90
YXNrICp0YXNrKTsNCj4gLS0NCj4gMi4zNC4xDQoNCg==
