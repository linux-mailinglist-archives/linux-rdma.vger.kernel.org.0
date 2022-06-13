Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80F547D97
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jun 2022 04:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiFMCU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jun 2022 22:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiFMCU5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jun 2022 22:20:57 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129413EB4
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1655086853; x=1686622853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tk7+2gh00KA9JRvYm2qsVRqVWk1Bnjk8d92ERUWqbrs=;
  b=OwCDj0Fq9zNMQilp1RoQ3kvkMZRPc7UXuYIezIM2+a/oljNCJHG+S/lj
   v5W3YbdvYEfVqxO6uWnnT+SXpvsHwTSSDFks+0QaIFtgnKr22wno6q5wp
   eVyHtJcLSvEtDSFBhpKwAih9T/JoKrEC0LZ7okozpz32PcLiqhSEkQJXo
   w0O4AKbcVKiHMoW8SeN8Qw/eKquUZeBGx/VcBH+qeRUUdD40hYpmTlXwl
   qTrIZ/MRttlipyeqiu/sHU58JFlSaTJV/3WBy68/QBnjyT1oCXfmcw7as
   GS1V6082OiGbO7V2rX4MmsmW8IO3NYHD22uSguOTr+a683+I8IFuneRuS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="58088805"
X-IronPort-AV: E=Sophos;i="5.91,296,1647270000"; 
   d="scan'208";a="58088805"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:20:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp+iE35qR4AFMwh5vhbDgKkh07cHIXm3u0R+3q5HEh1+l1ln9Xk3Vxey3FvbtrhV2Qs4YuXGroTYrU38J1bpaaBYptWCIzk7FSG+G6jyRQG+xdAxqLo0fK4SdinrWsbbqj745dR4kxIUkF4oWrV2WNoQBhi4nwqeGt0jmPm1xwFBPI+rhsPv+hxuDw6yyvfP9/QZkhQoatXK9n+byQKiWLB8RIeo57bm2YEw6wCmFL3EmiGM5FWBgFAuRdhiJFtTEIEma4+IBuI/QCM3hLWfjFJVERrdVc4/tz95h2iW+ecrTl5a1zAmT8CBrO6iQcIxIE6SxlShvPLOn5Mxoy+Ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk7+2gh00KA9JRvYm2qsVRqVWk1Bnjk8d92ERUWqbrs=;
 b=M+bfw+0/xmtcKFSrmfkOR9yCGXui2zHmOsuHWFIAQhA1RHT6DZqv/Wsv0a3fD/ipfmBRy4bBS1GgZxpsdK4CSygTNYFV/kaRtwA8ltVdAP105SPVeHsmRE4DfVPpkWhuRZk998Opyar92YFXB53H4B3GNzzYA8YksSWhWMUMiGgnwM+GbaU/pcxMS7KEdSBrHbS/rxXdaEyHkolEtDqnn9Vk/PY7sWW0QJaEfpgez0flrYZNoQU28vq2eyVJh3AyMJA7Bk9aVes8VA0MT8HnnK32VRbujHUcBk+Xy7Viw+fTLQTLNTpTe+WXOBk5MX2Yoh9z2ILhOs7zWbgbzcz7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk7+2gh00KA9JRvYm2qsVRqVWk1Bnjk8d92ERUWqbrs=;
 b=krXt1SC0bKjzaYHfe31CBov8ZASwP3VTKcqk9g7tY4JuSpHqnioPo8uIlONacGtcNRI6A1Sstk1UkoXzfHQR1bANyMfgG71Ye8PKFH+4CtRf/g6u9fds7BEcAVTj2AyC4TnT7Q/UUb4Do9QcSxJZlQVL5QpQmsu2EhUjmsQ36m4=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB8572.jpnprd01.prod.outlook.com (2603:1096:604:19d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 02:20:44 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::3b:e375:8e03:ea15]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::3b:e375:8e03:ea15%7]) with mapi id 15.20.5332.013; Mon, 13 Jun 2022
 02:20:44 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Md Haris Iqbal <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Thread-Topic: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Thread-Index: AQHYe/j2qg/4iwxPIkeJFQ71EIp/361MoGuA
Date:   Mon, 13 Jun 2022 02:20:44 +0000
Message-ID: <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
References: <20220609120322.144315-1-haris.phnx@gmail.com>
In-Reply-To: <20220609120322.144315-1-haris.phnx@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e32f578-b118-43b8-68f6-08da4ce35244
x-ms-traffictypediagnostic: OS3PR01MB8572:EE_
x-microsoft-antispam-prvs: <OS3PR01MB85721A6E0FE0479EAA00A654A5AB9@OS3PR01MB8572.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eL5dg7+JGSKq1263OY2+AuSAXURqkp+uWjpnXV78QqS9xpzqd2Hnvb9bdX6U5yfGG6NhW4Nm5m/y0hAI6b6Vx1e6bcWnHVhGpp2sp9StVdNqYMPCoNIl5OiZ1bW0KvUmll7jWiByJFU8kmAebDiicp6c4folhRgvhCSIXzrY726Pq41n8jeHROTTA3hr2o+tuWdLslOoCC0WHwzObOOobIstf6zJqlwhzeeOOaxnefYqZWmnblk9h15+9NdLah0CRz/wMBYD1olSCdT1DyZ62NY8sA+mQ/iABpSeRnxDVMSR6YT2MyUeWzy8OzEdcKkK2FI29fe4AAbudCExINm1HDIK675ix3OvM24+OXHevChCQRzbqYPY6PpspWbj0/iYfG6vFkl8CzBSmHQ+9c6lOW4nt6czXqUdftrASTG95VvypWNK6m8FFkSKE2X5hjh5L9StQoS1t0M9r0VVGQgV/qdg5BFQFhuIkNQ8KU3NhbrmCXIiSGeHUZPa6GdILlR5SqHVjr9fkQJfPeCYr5m7Vkz81uq2RBzUFxuvmIw9usMLz2jjhzH4x5EepXUklmN9O6u5fBzvH11PnUhBR7hERAYq4XF6HgmSmIOmE41t7T2C/ZmxsMhXDZ5f2odZkR/3Kb9MVgVvVZPwg70nwfWD+neyYJ+X6jC7aSXE+ExMbtd+l8AAPzycLF+0v+X08TcdpsZH4jiZhXW9A34YUss+14HM4oMf3RxGMaRqpaDqLE5BhJIVyR3YbjvMgK5B5oAu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(71200400001)(6486002)(122000001)(82960400001)(66446008)(66946007)(66476007)(64756008)(8676002)(508600001)(76116006)(66556008)(91956017)(86362001)(4326008)(31696002)(54906003)(110136005)(316002)(38100700002)(2616005)(186003)(53546011)(6506007)(26005)(83380400001)(6512007)(5660300002)(31686004)(2906002)(85182001)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0xkWUhNUjBabDV1dEJjMnVRWnBscm1ET0xZbjBZTUJkL2lqS3dlM2J1Wnlo?=
 =?utf-8?B?S203MlpnSHp6eVprM3ZhYzU1WHdwT3JLTlhXQ2FLa2RSMTNDeU9WalZGUW4x?=
 =?utf-8?B?VnZnVE50VjZGSi9pVW9JRk80MlNIeWh4TTNnOE9qSERzVWl2VWsvaTAzRktw?=
 =?utf-8?B?VjRDaVA2R29ickFibTRLcVVXTzJUUUdab3Zxd2FYOWU0VkxrUHhvYnA2L3Yw?=
 =?utf-8?B?ZXVEbjAvekMxd3U2VXNxMzM0cGxtdGJaai9qbFFqQXo1MTFZZUJZVitqVUdw?=
 =?utf-8?B?SkFkTTdURm1HbWMxSW5YUVZDYUc1cGRONis1S3ZwcU1rOEkvTHk0RU1xSVVa?=
 =?utf-8?B?VmFCMXpPazZKTm5BQlNjKzhwaWdid0VyUCtVOWY1UEQ5Qk5yK09XK0UxbFJ3?=
 =?utf-8?B?dmxsdTM4YThEV2tNSHNLa0VGRFlvSjV0WlA0NjNXNHpuV2xxc1ZRZjJRWXJ0?=
 =?utf-8?B?ZnJkeFczd0N0d1FNS254UWlFU05LZnVZNml4eU95cUI4R3lHK01BZnoxeCt3?=
 =?utf-8?B?VGV3dUo3aWhXUSttUjVSUzlyNStYbjlyWXkvN2tJU1BwSk0rVnhIdVlUcEsy?=
 =?utf-8?B?cWlJKzlnd2RLY2dKMnNQS0U1V01uNEtVanI4MjJYRkdNeWNkaHZPVEFreTl0?=
 =?utf-8?B?N1hOakMzRXdDY1RNdWRoUjBzeGJRZlhBMGRGR09kTG8yNllhdERubjFTak53?=
 =?utf-8?B?c3J3K1JUVlpRUSt1Sm9uRFJSRVhDSHlRdUpabkRvTXo4RnRzcVpoQTRKaGtS?=
 =?utf-8?B?a1d0YkN4RnlDYkJPZnhsMmsxeE91b3B6alFQbXpyQThkR3JJUEhCY2xuLy9T?=
 =?utf-8?B?Mnp0Q3piemVzU2xxRWJpa0NtaWxSM2FpSnJCQ3NNVEJBYXp3ME5zeEJwazdP?=
 =?utf-8?B?U1RqS0paY0x1MVFvb2VwS0F5V084ek5zUEd0ME0zOU1Gakk4Z0dMbWV0ZWRz?=
 =?utf-8?B?blQ2azR5TFZNVzF0alpObFFqa1pZdEFxMFhCWkZGL3o4K05YNjQ0ZFAzSzJt?=
 =?utf-8?B?NTJBck1ZZzdNd2puRFhKOTNvSmdwVE1YcGt2YlQzUkZZVFNlWFVLdkhKSmFj?=
 =?utf-8?B?LzVMekNETzFIT2llS2wvVkYzQUNoWVJ5MmxEUDFSRkIvYzdkYm9hVnBLNUdP?=
 =?utf-8?B?NlEvZ1BXZXMyUS9rNjhoUGtaMlY2Yk8zZXZlak4xM3pwYmNBWjBSZTFXMldK?=
 =?utf-8?B?ZHY2alBuSUlRVVhoMDY5REpSMnhxSzVoODNBMWNzZmhmNnBqY2NObHc4THJr?=
 =?utf-8?B?bVVyeWF3QnpFOGJkM3VTT3hFbWNvY0pwQ3pvVzlUSjFYQzk5ekRLTWZrZkxV?=
 =?utf-8?B?RDZUU2E4dTgvYjNxZXlscGY2NE9tZnpnQmt1R1QwZjdYWk5lTTNjVlJGSkJ0?=
 =?utf-8?B?Vkh3REJvRkUrWVdJbG9hdWU3bUlmZGp0TnBvemtmTm9UOHhkTTNmM2NIUHla?=
 =?utf-8?B?RUo5UW1qelZUdUdTaE5QeUxrL3BldDk0TzlDYnRQNGROOFBDaHgzWkhmTlFl?=
 =?utf-8?B?Z01YM2ErTExIcmpRZXh5S0pYcUJyVGNJK2NWQUhCd3YyRDU1ZnBpM3RpUlcr?=
 =?utf-8?B?eVBzQ2RaZGZRR0FKam5TM1NNMndKdWZlVFpwdU1YTmNZWU4ycmpZVXVnTitz?=
 =?utf-8?B?VE9iZWl6V1FZSTBZUTZUVzdHVlExUzdtb083S0JlZkt0Q3FwMHdmMVYrT1Yw?=
 =?utf-8?B?eWFNL1ZFTDNPK2hHdGhvSDUxNGdGS2tvaEwxUTNOMkdTK0FXQUxzZkVvTFls?=
 =?utf-8?B?OEwwM01lb25jeEFqNzlkaUtrNVE0b2RlNEVlOFhHNStNeWliUHBlNWdway95?=
 =?utf-8?B?Y0FwWFovUGE3Qnkya3JLTjFseTVyL0V1Mi8yZGZ1bUJDUkJBb3RJSWlNUUpW?=
 =?utf-8?B?ZDI5dUdXRXpXMkRmVDJnZnV2eHRQMUR4dE45d042NUZ6MVgxTUdadE5Hb2d1?=
 =?utf-8?B?Um5pUlVESkRsZGJWeGhxbzB0dW00eWtlVXJrM3U2ZC9DNUR0VDRKNDNkUFBS?=
 =?utf-8?B?d1c3T3JiVlJTUzJkaEZEbTAzT000VWlWYUlwSHJ3UjhDdThDbTY1OGJxRlds?=
 =?utf-8?B?dkJGcFhobWNON0x0WWtWSWhuQVJtM21PdGJpZ3pTbWx2YWZUUEQ2eG5ZcTRh?=
 =?utf-8?B?WEgveUpseG5Db2xzTlFUaHpLM2RHMkloUk5wYlgxZFdVeXBOV1ZjRW9IdHRo?=
 =?utf-8?B?VTJ5SGhuZDdHcGU0aGJaN05lclVaTTdXeVRJS1VnYVJLVGt6aDNPQW5Uclh5?=
 =?utf-8?B?V0srTWZXQVN5Z1VZSlRVQU80Yy9UMXdBNFBETkRWOGNrWDE0aUI0S0dhTDFI?=
 =?utf-8?B?Szc1S1JiVHd0ZE1vWDVaZU9tUXJONEV1OVBYd2FIbzlIaHFJN2NkYnl4b1Ra?=
 =?utf-8?Q?P0DhNgrozUXBpMXI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEE8D63FC347C841BA1A24460745A635@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e32f578-b118-43b8-68f6-08da4ce35244
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 02:20:44.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zZeTvXIpmCs+V6mBC4G7N3osF3B8Dg+h1FMLA5XIkWOY1vNDagNUW+myPszZZ/oxR7pf/Tuyk77ZSGj+VKPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8572
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA5LzA2LzIwMjIgMjA6MDMsIE1kIEhhcmlzIElxYmFsIHdyb3RlOg0KPiBDdXJyZW50
bHkgcnhlX2ludmFsaWRhdGVfbXIgZG9lcyBpbnZhbGlkYXRlIGZvciBib3RoIGxvY2FsIG9wcywg
YW5kIHJlbW90ZQ0KPiBvbmVzLiBUaGlzIG1lYW5zIHRoYXQgTVIgYmVpbmcgaW52YWxpZGF0ZWQg
aXMgY29tcGFyZWQgd2l0aCBya2V5IGZvciBib3RoLA0KPiB3aGljaCBpcyBpbmNvcnJlY3QuIEZv
ciBsb2NhbCBpbnZhbGlkYXRlLCBjb21wYXJpc29uIHNob3VsZCBoYXBwZW4gd2l0aA0KPiBsa2V5
LA0KSnVzdCBjaGVja2VkIHRoYXQgSUJUQSBTUEVDIOKAnTEwLjYuNeKAnCBzYXlzIHRoYXQgY29u
c3VtZXIgKm11c3QqIExfS2V5LCBSX0tleSAuLi4NCk5vdCBzdXJlIHdoZXRoZXIgd2Ugc2hvdWxk
IGNvbmNlcm4gdGhlc2UuDQoNCg0KDQo+IGFuZCBmb3IgdGhlIHJlbW90ZSBvbmUsIGl0IHNob3Vs
ZCBoYXBwZW4gd2l0aCBya2V5Lg0KPg0KPiBUaGlzIGNvbW1pdCBzcGxpdHMgdGhlIHJ4ZV9pbnZh
bGlkYXRlX21yIGludG8gbG9jYWwgYW5kIHJlbW90ZSB2ZXJzaW9ucy4NCj4gRWFjaCBvZiB0aGVt
IGRvZXMgY29tcGFyaXNvbiB0aGUgcmlnaHQgd2F5IGFzIGRlc2NyaWJlZCBhYm92ZSAod2l0aCBs
a2V5DQo+IGZvciBsb2NhbCwgYW5kIHJrZXkgZm9yIHJlbW90ZSkuDQo+DQo+IEZpeGVzOiAzOTAy
YjQyOWNhMTQgKCJSRE1BL3J4ZTogSW1wbGVtZW50IGludmFsaWRhdGUgTVcgb3BlcmF0aW9ucyIp
DQo+IENjOiBycGVhcnNvbmhwZUBnbWFpbC5jb20NCj4gU2lnbmVkLW9mZi1ieTogTWQgSGFyaXMg
SXFiYWwgPGhhcmlzLnBobnhAZ21haWwuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9sb2MuaCAgfCAgMyArLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX21yLmMgICB8IDU5ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8ICAyICstDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA0
OSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfbG9jLmgNCj4gaW5kZXggMGUwMjJhZTFiOGE1Li40ZGE1N2FiYmJjOGMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oDQo+ICsrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oDQo+IEBAIC03Nyw3ICs3Nyw4IEBAIHN0cnVj
dCByeGVfbXIgKmxvb2t1cF9tcihzdHJ1Y3QgcnhlX3BkICpwZCwgaW50IGFjY2VzcywgdTMyIGtl
eSwNCj4gICAJCQkgZW51bSByeGVfbXJfbG9va3VwX3R5cGUgdHlwZSk7DQo+ICAgaW50IG1yX2No
ZWNrX3JhbmdlKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgc2l6ZV90IGxlbmd0aCk7DQo+
ICAgaW50IGFkdmFuY2VfZG1hX2RhdGEoc3RydWN0IHJ4ZV9kbWFfaW5mbyAqZG1hLCB1bnNpZ25l
ZCBpbnQgbGVuZ3RoKTsNCj4gLWludCByeGVfaW52YWxpZGF0ZV9tcihzdHJ1Y3QgcnhlX3FwICpx
cCwgdTMyIHJrZXkpOw0KPiAraW50IHJ4ZV9pbnZhbGlkYXRlX21yX2xvY2FsKHN0cnVjdCByeGVf
cXAgKnFwLCB1MzIgbGtleSk7DQo+ICtpbnQgcnhlX2ludmFsaWRhdGVfbXJfcmVtb3RlKHN0cnVj
dCByeGVfcXAgKnFwLCB1MzIgcmtleSk7DQo+ICAgaW50IHJ4ZV9yZWdfZmFzdF9tcihzdHJ1Y3Qg
cnhlX3FwICpxcCwgc3RydWN0IHJ4ZV9zZW5kX3dxZSAqd3FlKTsNCj4gICBpbnQgcnhlX21yX3Nl
dF9wYWdlKHN0cnVjdCBpYl9tciAqaWJtciwgdTY0IGFkZHIpOw0KPiAgIGludCByeGVfZGVyZWdf
bXIoc3RydWN0IGliX21yICppYm1yLCBzdHJ1Y3QgaWJfdWRhdGEgKnVkYXRhKTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IGluZGV4IGZjMzk0MmUwNGExZi4uMWM3MTc5ZGQ5MmVi
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4gQEAgLTU3Niw0MSArNTc2
LDcyIEBAIHN0cnVjdCByeGVfbXIgKmxvb2t1cF9tcihzdHJ1Y3QgcnhlX3BkICpwZCwgaW50IGFj
Y2VzcywgdTMyIGtleSwNCj4gICAJcmV0dXJuIG1yOw0KPiAgIH0NCj4gICANCj4gLWludCByeGVf
aW52YWxpZGF0ZV9tcihzdHJ1Y3QgcnhlX3FwICpxcCwgdTMyIHJrZXkpDQo+ICtzdGF0aWMgaW50
IHJ4ZV9pbnZhbGlkYXRlX21yKHN0cnVjdCByeGVfbXIgKm1yKQ0KPiArew0KPiArCWlmIChhdG9t
aWNfcmVhZCgmbXItPm51bV9tdykgPiAwKSB7DQo+ICsJCXByX3dhcm4oIiVzOiBBdHRlbXB0IHRv
IGludmFsaWRhdGUgYW4gTVIgd2hpbGUgYm91bmQgdG8gTVdzXG4iLA0KPiArCQkJX19mdW5jX18p
Ow0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAodW5saWtlbHkobXIt
PnR5cGUgIT0gSUJfTVJfVFlQRV9NRU1fUkVHKSkgew0KPiArCQlwcl93YXJuKCIlczogbXItPnR5
cGUgKCVkKSBpcyB3cm9uZyB0eXBlXG4iLCBfX2Z1bmNfXywgbXItPnR5cGUpOw0KPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwltci0+c3RhdGUgPSBSWEVfTVJfU1RBVEVfRlJF
RTsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAraW50IHJ4ZV9pbnZhbGlkYXRlX21yX2xv
Y2FsKHN0cnVjdCByeGVfcXAgKnFwLCB1MzIgbGtleSkNCj4gICB7DQo+ICAgCXN0cnVjdCByeGVf
ZGV2ICpyeGUgPSB0b19yZGV2KHFwLT5pYnFwLmRldmljZSk7DQo+ICAgCXN0cnVjdCByeGVfbXIg
Km1yOw0KPiAgIAlpbnQgcmV0Ow0KPiAgIA0KPiAtCW1yID0gcnhlX3Bvb2xfZ2V0X2luZGV4KCZy
eGUtPm1yX3Bvb2wsIHJrZXkgPj4gOCk7DQo+ICsJbXIgPSByeGVfcG9vbF9nZXRfaW5kZXgoJnJ4
ZS0+bXJfcG9vbCwgbGtleSA+PiA4KTsNCj4gICAJaWYgKCFtcikgew0KPiAtCQlwcl9lcnIoIiVz
OiBObyBNUiBmb3IgcmtleSAlI3hcbiIsIF9fZnVuY19fLCBya2V5KTsNCj4gKwkJcHJfZXJyKCIl
czogTm8gTVIgZm9yIGxrZXkgJSN4XG4iLCBfX2Z1bmNfXywgbGtleSk7DQo+ICAgCQlyZXQgPSAt
RUlOVkFMOw0KPiAgIAkJZ290byBlcnI7DQo+ICAgCX0NCj4gICANCj4gLQlpZiAocmtleSAhPSBt
ci0+cmtleSkgew0KPiAtCQlwcl9lcnIoIiVzOiBya2V5ICglI3gpIGRvZXNuJ3QgbWF0Y2ggbXIt
PnJrZXkgKCUjeClcbiIsDQo+IC0JCQlfX2Z1bmNfXywgcmtleSwgbXItPnJrZXkpOw0KPiArCWlm
IChsa2V5ICE9IG1yLT5sa2V5KSB7DQo+ICsJCXByX2VycigiJXM6IGxrZXkgKCUjeCkgZG9lc24n
dCBtYXRjaCBtci0+bGtleSAoJSN4KVxuIiwNCj4gKwkJCV9fZnVuY19fLCBsa2V5LCBtci0+bGtl
eSk7DQo+ICAgCQlyZXQgPSAtRUlOVkFMOw0KPiAgIAkJZ290byBlcnJfZHJvcF9yZWY7DQo+ICAg
CX0NCj4gICANCj4gLQlpZiAoYXRvbWljX3JlYWQoJm1yLT5udW1fbXcpID4gMCkgew0KPiAtCQlw
cl93YXJuKCIlczogQXR0ZW1wdCB0byBpbnZhbGlkYXRlIGFuIE1SIHdoaWxlIGJvdW5kIHRvIE1X
c1xuIiwNCj4gLQkJCV9fZnVuY19fKTsNCj4gKwlyZXQgPSByeGVfaW52YWxpZGF0ZV9tcihtcik7
DQo+ICsNCj4gK2Vycl9kcm9wX3JlZjoNCj4gKwlyeGVfcHV0KG1yKTsNCj4gK2VycjoNCj4gKwly
ZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtpbnQgcnhlX2ludmFsaWRhdGVfbXJfcmVtb3RlKHN0
cnVjdCByeGVfcXAgKnFwLCB1MzIgcmtleSkNCj4gK3sNCj4gKwlzdHJ1Y3QgcnhlX2RldiAqcnhl
ID0gdG9fcmRldihxcC0+aWJxcC5kZXZpY2UpOw0KPiArCXN0cnVjdCByeGVfbXIgKm1yOw0KPiAr
CWludCByZXQ7DQo+ICsNCj4gKwltciA9IHJ4ZV9wb29sX2dldF9pbmRleCgmcnhlLT5tcl9wb29s
LCBya2V5ID4+IDgpOw0KPiArCWlmICghbXIpIHsNCj4gKwkJcHJfZXJyKCIlczogTm8gTVIgZm9y
IHJrZXkgJSN4XG4iLCBfX2Z1bmNfXywgcmtleSk7DQo+ICAgCQlyZXQgPSAtRUlOVkFMOw0KPiAt
CQlnb3RvIGVycl9kcm9wX3JlZjsNCj4gKwkJZ290byBlcnI7DQo+ICAgCX0NCj4gICANCj4gLQlp
ZiAodW5saWtlbHkobXItPnR5cGUgIT0gSUJfTVJfVFlQRV9NRU1fUkVHKSkgew0KPiAtCQlwcl93
YXJuKCIlczogbXItPnR5cGUgKCVkKSBpcyB3cm9uZyB0eXBlXG4iLCBfX2Z1bmNfXywgbXItPnR5
cGUpOw0KPiArCWlmIChya2V5ICE9IG1yLT5ya2V5KSB7DQo+ICsJCXByX2VycigiJXM6IHJrZXkg
KCUjeCkgZG9lc24ndCBtYXRjaCBtci0+cmtleSAoJSN4KVxuIiwNCj4gKwkJCV9fZnVuY19fLCBy
a2V5LCBtci0+cmtleSk7DQo+ICAgCQlyZXQgPSAtRUlOVkFMOw0KPiAgIAkJZ290byBlcnJfZHJv
cF9yZWY7DQo+ICAgCX0NCj4gICANCj4gLQltci0+c3RhdGUgPSBSWEVfTVJfU1RBVEVfRlJFRTsN
Cj4gLQlyZXQgPSAwOw0KPiArCXJldCA9IHJ4ZV9pbnZhbGlkYXRlX21yKG1yKTsNCj4gICANCj4g
ICBlcnJfZHJvcF9yZWY6DQo+ICAgCXJ4ZV9wdXQobXIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9yZXEuYw0KPiBpbmRleCA5ZDk4MjM3Mzg5Y2YuLmU3ZGQ5NzM4YTI1NSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gQEAgLTU1MCw3ICs1NTAsNyBAQCBzdGF0
aWMgaW50IHJ4ZV9kb19sb2NhbF9vcHMoc3RydWN0IHJ4ZV9xcCAqcXAsIHN0cnVjdCByeGVfc2Vu
ZF93cWUgKndxZSkNCj4gICAJCWlmIChya2V5X2lzX213KHJrZXkpKQ0KPiAgIAkJCXJldCA9IHJ4
ZV9pbnZhbGlkYXRlX213KHFwLCBya2V5KTsNCj4gICAJCWVsc2UNCj4gLQkJCXJldCA9IHJ4ZV9p
bnZhbGlkYXRlX21yKHFwLCBya2V5KTsNCj4gKwkJCXJldCA9IHJ4ZV9pbnZhbGlkYXRlX21yX2xv
Y2FsKHFwLCBya2V5KTsNCg0KaWYgdGhpcyBya2V5IHdvdWxkIGltcGxpZXMgKmxrZXkqIG9yICpy
a2V5Kiwgc2hhbGwgd2UgZ2l2ZSBpdCBhIG5ldyBiZXR0ZXIgbmFtZSA/DQoNCg0KVGhhbmtzDQpa
aGlqaWFuDQoNCj4gICANCj4gICAJCWlmICh1bmxpa2VseShyZXQpKSB7DQo+ICAgCQkJd3FlLT5z
dGF0dXMgPSBJQl9XQ19MT0NfUVBfT1BfRVJSOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
cmVzcC5jDQo+IGluZGV4IGY0ZjZlZTVkODFmZS4uMDE0MTEyODBjZDczIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMNCj4gKysrIGIvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+IEBAIC04MTgsNyArODE4LDcgQEAgc3RhdGlj
IGludCBpbnZhbGlkYXRlX3JrZXkoc3RydWN0IHJ4ZV9xcCAqcXAsIHUzMiBya2V5KQ0KPiAgIAlp
ZiAocmtleV9pc19tdyhya2V5KSkNCj4gICAJCXJldHVybiByeGVfaW52YWxpZGF0ZV9tdyhxcCwg
cmtleSk7DQo+ICAgCWVsc2UNCj4gLQkJcmV0dXJuIHJ4ZV9pbnZhbGlkYXRlX21yKHFwLCBya2V5
KTsNCj4gKwkJcmV0dXJuIHJ4ZV9pbnZhbGlkYXRlX21yX3JlbW90ZShxcCwgcmtleSk7DQo+ICAg
fQ0KPiAgIA0KPiAgIC8qIEV4ZWN1dGVzIGEgbmV3IHJlcXVlc3QuIEEgcmV0cmllZCByZXF1ZXN0
IG5ldmVyIHJlYWNoIHRoYXQgZnVuY3Rpb24gKHNlbmQNCg==
