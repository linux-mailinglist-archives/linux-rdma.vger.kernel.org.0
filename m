Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9108259B8D5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiHVFuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 01:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHVFuQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 01:50:16 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1AA25E97
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661147415; x=1692683415;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=uj+4P6cHgn645lPFQj1VDjOBillLSlAfT758r7tJnVk=;
  b=OPNQSTHjY1GfZRdodvikyst/Pdci8RXBDEI5oO3FX+mICjGr3Xr0aPuK
   dqqStVQwvvjSTZp/lrwhX7BlbUPMqMZU/0+TRODhYDH0Jca1F67kZEoHl
   fVceOcDhNtW7rtGeSxqVkAekXDHkzhPlG1RJOMUH5E4oV0GTF+2uPAMm7
   dQJXUK7QSOw7xk7LHo/4G6TCwNvzJrfL9J/cTS5qI97cvPjuWgk0ctzu0
   YKVMQuL0nXCGMZRmq2Xv06qPTNGHLCPVi8ptOwwJAUxkOZDU4c5wekmQA
   /Pem0Ko2tbY9iBODU6wLQ5rjUxu9yzryeSfGFleZ/yyOD98QbfdR7+p44
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="63184598"
X-IronPort-AV: E=Sophos;i="5.93,254,1654527600"; 
   d="scan'208";a="63184598"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:50:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFUFMvSUzB2e3dh15fQ4IEX5zpdnI8HjMYslm5ycTHHC/AxkdLuaRclexoZGcPcCk8hnmYTrOuJ5kvhcdHplwpoVfvypdrTiqBTGzr2HB4KvBKVxaUQXZCrwU6qtJUu1QKShPYd2HbdLrIdKQ4kuMLnwzvaZV4/gFcufQ3OpqQNY8ivlbhesPKVDQj54zFfi8X6+hYEiDQm8KxBdnbQol/ceThDkNqoFXj5CXXIlLlVtFvCJEmm1r4e6t1iHY0HNPfyeQty+qlP1YAgKiH5+deSJtAZCFX/frfQpVJVL5eFz1FTVMNiweZ3wRVsT53FrgV5mPp2ihLDsHxx8tTt1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj+4P6cHgn645lPFQj1VDjOBillLSlAfT758r7tJnVk=;
 b=Bd2gLow4m8UbpEX0QtjKwocxCfpQwhgZCyqNzVGog8bsZX/Wq3y2hubqpTBUXYoKXyFDMtN8yFuXDo6HgZjHyb9vbIqguj1EeIEio+9K0c6HqcejLsyaU37B7HPzM0xkoXTnkZ5zWypmwmM80v0zmRsJQYo3bYxaKzVYdsBCAbUrQD+GrhdtO9gqkavPKfnwYwCsTrcNdswf/0Y/TLZOtJtFaUbuLPLNn+nbHBTxLTA+L8aKwI2bXtHzARCF4yZAH4RH7ge/LQSZdALd1ki3LCyzwe+IJQpVrHdyhIbnW9i3qrM0urXHaPb9Pl83TGMFY5/3H0A23fXzCcn9LszeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSAPR01MB3716.jpnprd01.prod.outlook.com (2603:1096:604:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 05:50:08 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 05:50:08 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v5 for-next 2/2] RDMA/rxe: Test mr->umem before releasing
 umem
Thread-Topic: [PATCH v5 for-next 2/2] RDMA/rxe: Test mr->umem before releasing
 umem
Thread-Index: AQHYqPnhARN2D7wfA0OywJSwiRhQSa26g0rQ
Date:   Mon, 22 Aug 2022 05:50:08 +0000
Message-ID: <TYCPR01MB93052D25FB7FDB83DCF7AD90A5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
References: <20220805183153.32007-1-rpearsonhpe@gmail.com>
 <20220805183153.32007-3-rpearsonhpe@gmail.com>
In-Reply-To: <20220805183153.32007-3-rpearsonhpe@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MjYzYmE3YTAtNmM1Ny00NTcxLTkxNmEtMDM1NDRiM2Mw?=
 =?utf-8?B?OGY3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wOC0yMlQwNTo0NzoxMFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91aca9d6-fc1d-42e7-77e0-08da84022bd7
x-ms-traffictypediagnostic: OSAPR01MB3716:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: He9AxGjtOllxLpEYKrw9DHpr66rSk8dsPrUEwuqVpAIQk8kgNSIcTDfv+yH4UT5Uzi/coI4w2MjcT7/rnUZ+B8y/9n82p3Kz0U3gKNKJmDoPu12ZUPteyVMnlm0xIdfwm8t3Ab8/jU0YupgszqvF6jAIde/ODNOpBaX/k7r50ZaNeTbn9RqonLTdEntutFb/oRVOUMpoXkNNwhtGeAXRZ7dhG2Zexoi3O4qkC5j7kKeJI1cKOWOCRuPew2bKaTUXZ1sW/5ninOAVXjJw3DJa5J0Pn044+bG/EfIrvo44FPd+RIJB1NVLRNnnmpSNn5IZK/075hl9huSZiFmlGFmzlNFTx2krPeSamB/bTYY/D7zELrb1VPhV7bLsaSmDxrWadI5wknKDo77ju+sCZYHY+YKXqkB5IUExDvK2ePtiqAUn3VtJGdpjjZbh0gBIzZpSS9D/1Wwq2YL/ygleSdh9R8/Xdgt7+lHpZjqSYLAuNfcarES/RzbiUtTd31749PA7cuwmkDUTjXkMYQsK69nKV8IRoL6OoS5DlKaceXUKpo1VIKjEL/5E8UrxohW2h1s1gvpPOJByfuUlnUM/VSHodPgbguBmiMrv8RzaU9rSbXvJm8wCq8n/+6bcu7mRYvLLZODs3+l8FG+q2VPFsgYnUNbIwQz7A9hA6vH5oQouMXjHf5UowXEJAwjt8VENdqfCdpK4lLD1UHs/4FLE+rpOfUfJol1qs4lTGtG0V8aPGppGwkZVgsXQ3UqFjDOh0/YxcucWBx/ThFKCubZ45ev7GdS5bcJJlXZ20A+h+smoKc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(41300700001)(33656002)(86362001)(26005)(53546011)(85182001)(71200400001)(6506007)(1580799003)(38070700005)(9686003)(82960400001)(186003)(7696005)(83380400001)(478600001)(55016003)(316002)(66446008)(66946007)(66476007)(66556008)(76116006)(110136005)(8676002)(64756008)(38100700002)(2906002)(52536014)(8936002)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N05QSDBNV2pwVGZYUUlSbmFLQm16UFAxNk1XdEx3UGhMRGI2TzQzWWJvcUxr?=
 =?utf-8?B?Tk90SGdjUHBKM3ErUk5odDA5N2lTeko1eDJxcHliUUJOZFUvZ28ySklickpq?=
 =?utf-8?B?WEFoejVjdG0rR1lXLzZIT0RBWmtNSFQ3VWVDelcveUlHZHJLdDZlMTdRVTlo?=
 =?utf-8?B?S3kwU1Z0cnF2RUt2WmtOY2xUd3k2WHlTSUI3YW5idVJmcXBZRldacmYzVVM5?=
 =?utf-8?B?NGF1dU5KYW15OERoNzlyUS9TNXpsUTBVT01nZEZzYXMxV2V6L3VHazlqYVFD?=
 =?utf-8?B?R3V6dVZVeS9HTlBkNlVKa2xZREpaMG56dGNvSHVVU1RnWGJBZWZwcmh4K1Zq?=
 =?utf-8?B?eE9wekVKSlhJRjUxdEw4M0xDdTVZWE81VVJENlY4NlZ2d1hHZjNjcVdVTGxN?=
 =?utf-8?B?L2RhK2w4RGVlZUJyZXhsYUZSYldSTG05RVhCN0VaaEdRdW5yYUFsS3krS202?=
 =?utf-8?B?TGtWVHB3Z2RnY3I3UGtmbzkzK0U0bVkrcHhSaXB6L2RRSUdzODBNa25XQ1kr?=
 =?utf-8?B?VkYvaEJ0WG9oT1o3V0tkSDBQTDZ1VzdlbXVRTzgwak5JUWp2cTM5Y0tkV3RQ?=
 =?utf-8?B?L3ZJc0VQMU1nTTl0blRNZnZETGloTjJrczdpMXV4ZjFmbHM1eSt2NmtGeHZZ?=
 =?utf-8?B?YnROaEVOc2ZIS3dJZ094d0g2SDNYMkF1SEV3V2ordXcxYUY4K0dFcy9mbGFn?=
 =?utf-8?B?RVI5dXVKZlc1ZmZXcnpzelVtV0lmVHFNTkJqcCtXOUE2MUlxSFNZZFl1Q2Iw?=
 =?utf-8?B?YXBtVTkxaFl1bHZyRCs0NkZqMDYwUElHMk9lVEUxYUxPRXNvdUVRZWlNYitR?=
 =?utf-8?B?c0hHWTh5aDNEUzJUbWw4TVJMOEhzSFNDMkZXMWU0L3ZOUk91QXpPSVpTQXRs?=
 =?utf-8?B?OW80SERXbUtJSUl0NWhSWWlIcmxnTU5xbmM3QklnTktvN3N6TzlSYktva3pD?=
 =?utf-8?B?MWFUWTVzckxsRmZzRkgzb0l3OENVcmVoMkVBcU1sY1F6azJQelJiK3U5dk9z?=
 =?utf-8?B?NzZZeFdmS0wvM1MrU2k0MVhxa3Y3cTQwOUUySnEyQlBwTHNHZk1ZOWJBZm5W?=
 =?utf-8?B?WWhpYVVZRTFFQVhoZDZ2YXk4clFPTkpUT2ZHODlxK3dCM2hQdG9Yc0RscXh4?=
 =?utf-8?B?ZXExVjh3cTFnT3pJZlZxUUVYK1Q5NHFiOWdxTWxoVS9FMGlhcVBrcyszQ2p6?=
 =?utf-8?B?WjM3SnpYV09weGhSTEpubmUzcW1kK0ZoQUQrUjhVTkhQdVdGL1FXUy9EU3B3?=
 =?utf-8?B?ZXU5ZHk3ZkhiN1lnZXBsdmZXTVEyenpETEwxRVFZelE4WGswSS92VFVmYTdi?=
 =?utf-8?B?MUN2SWhCYVhZWWJoYkdlRk5Vd25KZ1ZQZ2lqbXU3aWQxdnhSb0RZZlA0YkRZ?=
 =?utf-8?B?OWJDL3k4WU1yeUNmSHA2UE1ZUDIrc3J5elRZME1aMXZqVFNPUTR4STBkRXdY?=
 =?utf-8?B?aXUvY1N3aWlKQi9mQjF0SG9idlMyWG9XTnhubzM0ZlgwN3VuYy9FUEcvSXli?=
 =?utf-8?B?RUdoTFRvZ2RNcm0xTFZFcHBlaVF2NVFNYVQzTWxTajQ0Vkw3Q0pSVUY4RzFO?=
 =?utf-8?B?ZHV4NFhrbkZvZzdiVWJlZFJkNFBYZ1J0WDVzVlRGcVQ5dXBpU3d6MDlDcFFH?=
 =?utf-8?B?TFFvRE0yM0lEUm9pOWQ3TjFhV0lrRUdLNlQ1dWpvY0JQSXgvTkl2OWFuNW5W?=
 =?utf-8?B?RmYrSmNKa3Zuc0tpYTVVY3NwT0cwWHZ0b2llbkdWY05DQjlZWjU2YndnQWFp?=
 =?utf-8?B?L3kzak52VllsS01Gc3liNzM5V25xS253Qk54Qk9vQjRKcWF1T2RGS25RTnkz?=
 =?utf-8?B?TDRRRjdFVzVYZHhxc2Q1TklWSmRVS3BEWTlrNEpPVHhXWHFuVjF2NitKamxB?=
 =?utf-8?B?amxNYWxRdVcraXRNT09QanNsdG41eHpiejIyZ0N0Q2xDR1R1QTN0TWl3SGVX?=
 =?utf-8?B?TkRmdHJoWnQzL29pK3IzVFdVS3lVUnZlcnB2RVBxTUtDdDhncndBbjl4TzV1?=
 =?utf-8?B?ZTMxdEVDWGsvclpzL2doVWxpL1lVSDZEaEpnMHhYY1hRU0NZSVVpd2N6ajBO?=
 =?utf-8?B?eTNQYnk5cHY5NmM0N0hSQVFrQ3JGd3AzNHlnNlM2b1NQMDdIZTJjSWRrK29V?=
 =?utf-8?Q?S5jBP50hcZj7EnhHFeMA5Dv+w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91aca9d6-fc1d-42e7-77e0-08da84022bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 05:50:08.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfFSBs4f+gvvfm0vV6I9z7w3JishbLOwLizcGGRqnlmYIkSPkKufc1ssbPmBGRuY/O/OftOfDW8o6vzT4eBDag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3716
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9iIFBlYXJzb24gPHJw
ZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCA2LCAyMDIyIDI6
MzIgQU0NCj4gVG86IGpnZ0BudmlkaWEuY29tOyB6eWp6eWoyMDAwQGdtYWlsLmNvbTsgTGksIFpo
aWppYW4v5p2OIOaZuuWdmg0KPiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPjsgamhhY2tAaHBlLmNv
bTsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEJvYiBQZWFyc29uIDxycGVhcnNv
bmhwZUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2NSBmb3ItbmV4dCAyLzJdIFJETUEv
cnhlOiBUZXN0IG1yLT51bWVtIGJlZm9yZSByZWxlYXNpbmcNCj4gdW1lbQ0KPiANCj4gSW4gcnhl
X21yX2NsZWFudXAoKSB0ZXN0IG1yLT51bWVtIGJlZm9yZSBjYWxsaW5nIGliX3VtZW1fcmVsZWFz
ZSgpIHNpbmNlIGluDQo+IHNvbWUgZXJyb3IgcGF0aHMgaXQgbWF5IG5vdCBiZSBzZXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgfCA0ICsrKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IGIvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiBpbmRleCBhZjM0ZjE5OGU2NDUuLmYwNzI2ZThl
ZTg1NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0K
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IEBAIC02MjcsNyAr
NjI3LDkgQEAgdm9pZCByeGVfbXJfY2xlYW51cChzdHJ1Y3QgcnhlX3Bvb2xfZWxlbSAqZWxlbSkN
Cj4gIAlpbnQgaTsNCj4gDQo+ICAJcnhlX3B1dChtcl9wZChtcikpOw0KPiAtCWliX3VtZW1fcmVs
ZWFzZShtci0+dW1lbSk7DQo+ICsNCj4gKwlpZiAobXItPnVtZW0pDQo+ICsJCWliX3VtZW1fcmVs
ZWFzZShtci0+dW1lbSk7DQoNCkl0J3Mgc2FmZSB0byBwYXNzIGEgTlVMTCB0byBpYl91bWVtX3Jl
bGVhc2UoKSB3aGVyZSBpdCBoYXMgYSBzdWNoIGNoZWNrLg0KDQoNClRoYW5rcw0KWmhpamlhbg0K
DQo+IA0KPiAgCWlmIChtci0+bWFwKSB7DQo+ICAJCWZvciAoaSA9IDA7IGkgPCBtci0+bnVtX21h
cDsgaSsrKQ0KPiAtLQ0KPiAyLjM0LjENCg0K
