Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0782848D254
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 07:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiAMG3O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jan 2022 01:29:14 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:36047 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229763AbiAMG3N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jan 2022 01:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642055354; x=1673591354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mn3zso6ByDu+YboSDoLZ0V2890rF3oGVQeA+50Awigc=;
  b=vkROJDdOhpmMjR4zhUzeJQl681m6/c9d6+BIKV6JX9cB4xt9csLB/5FA
   /U6FgLCWOIar+7S2IK1hMPQ0zc+iG2SADHdcWWKmKZEMPSPj7xtRQvZil
   gBhMrNxfqhqFntQZFfnYVqxNDvgJwQ923to9XML/lxclpkShja3tg5Hhq
   X9mwRhv5k48DdHcQxnfUSyoXaGUNjG5sPI9AgxC7IJwG6dsmHZtgKcTPO
   WVt64kbGsAzteRA/lO1EUtZk+DF3utH21AcAncL3DUj5mUFtA1tU5rfUk
   5QWjjlRo9C6GF6E2M6FLtK4ec2umSQHC8/HdbBYx+Z4VV7EQFL9LSZxbN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="47508749"
X-IronPort-AV: E=Sophos;i="5.88,284,1635174000"; 
   d="scan'208";a="47508749"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:29:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuH8B91sJ6EFrXR500KlpQQMJnLtsF3PAoXXzfMrqHpEQDjdtBeYEJHbYbRSpQqaT9u/2SxhgjzGzwNOM0IB3tr1Ou+VDa3dx2OLCjHbGpGI6NC4BCdQKlDKX6wEL4K2a+GV2Wjd/feqN/mWK4MYkHmwznSCH0Vew3mCSKN0xGQGOni7dzSLG67aCTVZc1CYegZgLBDSptag5oM5GTnCeJ7tmj1x3zkJ7sQSJdQGvQ1eeJ75OFOV5UvCadAcjPtTsfEvRohXqNg6k4gXdOxWgsHiKe+Rf0vLZpnOHeeJb9FH04jDHkV3JCsj2GvCQscY19NpHbahfbPDZcK3aTbGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn3zso6ByDu+YboSDoLZ0V2890rF3oGVQeA+50Awigc=;
 b=gH1Dwg3jlPUA67FI0SQ3Vyb9g+P8hzH6bNJD1XVZ/+ZQj7rxmUG7hB9uLrXu+89xmGhpPueOEYM6RCz0zRXKbL68Jml9ewfe6sdGunNBiA8IqkshFziK2HAFf6G/JgzCo5FKx47ykaFRjgp1JppLvxNAvfFc7zYEZ+1H2kMnWrbQq9Zob9/4MlYiu2tuaGlpfqsnPRBkTLjEciXhFtgcRiZ3535TmFlEZ+KekCfr3wEOg6rYoZ3t0/D8AnPEJf119O4EBWKSNda1nesYKz8NhrHtwBvrz8LbhTmmzC2lxwSKQMgDqTBWsObs5vFNiqk+YQdF5pkL5DtpNjbNJNHN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn3zso6ByDu+YboSDoLZ0V2890rF3oGVQeA+50Awigc=;
 b=jQK7xfuHptLp0V0UHaaNEAnpQQ60IcUJQpE/qiMregAyc6/oFdz1opF8dlOEWsNs1pXvA+HYiVWAFAWWdRPdfJPDr00NsWqHqHI9GJYK2JxQBStdj+lxBfMb/GzAl4OIBrveR2HwCJ9XNDlIbKs8ZI9tNhQidXpi4m9IAErQa7Q=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYAPR01MB2894.jpnprd01.prod.outlook.com (2603:1096:404:8a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 06:29:06 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 06:29:06 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xVMQcAgABoxYCAALXOAIAFg4eAgACTqoCAAPuMgIAA/08AgADajgCAADhyAIABIZOA
Date:   Thu, 13 Jan 2022 06:29:06 +0000
Message-ID: <9c401083-e130-d09b-b278-62d6a7e9d0be@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
 <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
 <20220110143419.GF6467@ziepe.ca>
 <56234596-cb7d-bdb2-fcfd-f1fe0f25c3e3@fujitsu.com>
 <20220111204826.GK6467@ziepe.ca>
 <f980d32d-85b7-87b5-750f-aaa728d811c8@fujitsu.com>
 <20220112131242.GL6467@ziepe.ca>
In-Reply-To: <20220112131242.GL6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 081919e0-9aa5-4f36-8904-08d9d65e000e
x-ms-traffictypediagnostic: TYAPR01MB2894:EE_
x-microsoft-antispam-prvs: <TYAPR01MB28949094EBE0B184FB2C17FAA5539@TYAPR01MB2894.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WEjrFxZKQPd3GF5GODRca9LMyiHDUaZyNFWoASilfSV0Mttg1bGfelS4Dn7DgYf74pZlIh2dVxUYh2muNdyq5Tb5snSqxgBz/cjhg33MeG9Mqv7SOdoCtUoOyYaQgAAWTJwIycyKO+Znsb9jvL6d+/cUbdBPBguXfPi5LsQdZ7imLCnuLvxS8Jc6bLPpiMeifoNIbwdv6jhnvr6oSUC1wQBAKMBe52BjZeNjoIRg5TofyMQWn+fQKIfikJTk9ymrOlJTxCwFhQKXxm6CUfaqijDlYfX+gz4K4d2hfe4c5pUcL7sqfKvRKHLFaEePOna2UIywUlCfZYD13o2nV68NgiIULrfvVeWOOofN2a+BYM65A/LqMuxXLeWLwigKbqHTBriKMcmPYSVgsJCA7pMN96dnnrYMR0KLbII83UrvdAi7BwHP+xi6Oe/zsCuy/o4wvML+iBIC5G8DyYk81G/ZpJteRXZxuS3KJJHCtQizUTnVYDhrK1qwkUK0u5FgcFmJ3uDil4UHqqLze6EtFSy61g3fFiotBT+5SPV4lxlfdPv2Q+x87y2qRRSTqFUtqSuRMBhxNsFJ/MTZ+qzy6aOb9B/lI0iIDu9KBYVHWLeGqzXsZoconPu+LYo7tooucILpguPKOsmHUxUi2ky4gbSQZmPeG5/DAznKWTJWDcbAJWWOXj4D84xGiDLm/SjYHOfiw15WaCn7FbXHOORn3/AZ/3ZxfwY4nUPt1oG6JwDfFbSLu5vMI5tFLN0sruG/s7i3/dA0e6+m3jlMMO2vYKwKuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66946007)(6512007)(31696002)(508600001)(316002)(71200400001)(64756008)(8936002)(54906003)(6486002)(2906002)(66446008)(66476007)(76116006)(38100700002)(122000001)(91956017)(5660300002)(85182001)(186003)(82960400001)(107886003)(38070700005)(83380400001)(53546011)(6506007)(4326008)(66556008)(6916009)(31686004)(36756003)(26005)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNQbzhSVWNPRWFkU0pjS040NjR3OGFEN2RkYnRlNnFkODRXQ2JmVjFzVTlu?=
 =?utf-8?B?REhlOTFCVitnM2xJOU1QT3J6N2pURXVFT2ovK0hLVnlKc2ZIZHpoYTBoajNm?=
 =?utf-8?B?K1llODJUOFZZVUc4VjJldnpSTlRJS3NrK00xdmh0cG5FdXAzTUVHYkJyNHhu?=
 =?utf-8?B?VXZRaUFCUVhVSEsra0hqcXpTMGpsdElLU1ZsNThkUXFUQXNMakllM1VXQy96?=
 =?utf-8?B?NXNxbVlRc3pwQ1hGZXhSK1Z1bWVSaEtMb00wbzJaZGdFSGovbmwvalZVQ3dx?=
 =?utf-8?B?bld0Ty9xRjk0NDAxRVkzZWdFb3VFcmhzamoyc1A0TmpsUWpzZE9nZ2dYbmp1?=
 =?utf-8?B?M0FJcU1ReGt5VTdoUFpKeFRhUDRtTmcxL0N1cmRWNDNEd1BhaWdWNmNCaUhp?=
 =?utf-8?B?MDVKbkZFeU8vZFhvWEJRZGpCS3FoM1pHdTl2MVM0ZS9HNGRaMWh2VXp0Qkc1?=
 =?utf-8?B?S0Q0VlRzcEMxa0V6WlZqMSt6RUFZUUgvenFma0RWT1ZtSWo3N1VTekxINHp1?=
 =?utf-8?B?eVdyUU1GUVpZbWRzYk1nVk1ZT0FDY09iQmJPQk5jOXNtNDF1YzFocEppbENP?=
 =?utf-8?B?MEs2QytlNzJ5UlZMUU1QSk0vYlJqeGp0aXpEY1pabEhlSnNKV2Z1em5sTmcw?=
 =?utf-8?B?QlFPNkxlMW4yM05YdC9IRWttTVY5b1k5ZFRwMVVtOG55SkY3TXNiRG9vaUp1?=
 =?utf-8?B?ZlQ5S1Q1ZEM0QzF6cmlTUXZPUXhGTGFFYlBZNE1DczlhNWVNM3hyRzMzaWZT?=
 =?utf-8?B?bTYzaEpQZjkwNEhCYjNqTG9IMmQzNVlvOXhnSHJ2WUdSQWhuSkVnVzVjTHUv?=
 =?utf-8?B?b1hmZHVGd045VUVweGwxNmZoZEx1dzMvekIrMkVqRmRoNHV3S0FFNmpTd3RW?=
 =?utf-8?B?UGNhd29zd2h3bFI3d1VWbE9YaVBvZERHZ0c1QVlGcVlRY3FaTDZwbkcxUzdo?=
 =?utf-8?B?RzhpbVBBOWEvR1lEclUrWHZkNlZiai9tb1lKaHlYd2tuamVMa1dURzZhVXUv?=
 =?utf-8?B?TCtkVlhmV2tQTTQ5VENxWjZWZVN3N1N6MTh0YWVMcVN4N2xEUCtXVTJJbExl?=
 =?utf-8?B?OGxITnh4OU1sR0JmeHJtZnVNUFh2R3dMTThjR1ZUUE1FM0FzVmx1UG1pVTNt?=
 =?utf-8?B?UHJkTzJCVWVTTFBEZVd4bkJxTHdWNjdMUC9LOFdZMjdtcTkxTlBkR3B1Uzda?=
 =?utf-8?B?S3BOdm1hUnJtc01CM0lSSDFwdE56YXBFNG42NytCTE9PVjJTbndYN2dKUXRw?=
 =?utf-8?B?VUxUeDBaOTFrcHp3Rml5dDJQZkZ0VHZqR3l1aDRZM1IrR2E0NVpOR2lRU016?=
 =?utf-8?B?ZGhpZlhhWUVMTkpselVQdlE5blB5SXNXNWtDMUwxYWdCZ3dYUnR4OUhFa0dD?=
 =?utf-8?B?YTNzVnhRUXlUd2grd3kwcnZ5LzMrL3RFMWt5QTRLVzlNZFB2bVBqcXkxbVVr?=
 =?utf-8?B?ak5QM3dlWnF4T3hwbzFTa3Q0OGVLT3ZMaXZIK0JEbUQvNVNsV2tpWStvakN0?=
 =?utf-8?B?c2FkT1RmZzlyYjJDM2M5VWFRT0tUWUVmOHpCTWw0aVdpa3JocmhjbENmVmlV?=
 =?utf-8?B?WUVTblgwTnNtMlE5RnNKbHZ4NExtRzdIMDNOemgwRXhyS29VaXBJeDVQRmZO?=
 =?utf-8?B?MzExL3A3cGVVSWJqajcwTVNHcHRyMnlqL2NNc2cyaS8ycXJlV0E5QUJRVFFD?=
 =?utf-8?B?K0t5VWVnK3ZRV05aaDJmZTVXTWVlVzltQTlvaE9BS3U4VFVaNktYaXVhVlky?=
 =?utf-8?B?MW55Zk8wYVZ2YTAvZEtmS2UydkRJQ0E3cFFEVDg2bUdlODNKa0FWSGpRZHF6?=
 =?utf-8?B?U0tDcjlQNWJ1MUxhUzAvdGd1NEJJN0p5RDJGUjhFcDVST1UwM21xVTBaWjRx?=
 =?utf-8?B?R3ZqZStEYy9IaFE4anZObVh4R2ozdThKbHR6WDhmZ1oxdnVPdVlZamlBbXIx?=
 =?utf-8?B?ZU9QUDRNdGY3VmdMZFFvWmhRWGFGZnlERkgwWFVyUksxSHhpS1cvZGcyZ2RQ?=
 =?utf-8?B?b3ZPRmpmd3FzalQ1TGI5cDl5VjJ5NzMxQjVNVVdwN0xVandybk5OZEdqU2xT?=
 =?utf-8?B?QURXMHQ1U1UzNkwzcG05VC92MmJOczJtSWtoZlBWR1MvNWpCVkRmbTNWdWgy?=
 =?utf-8?B?REdET1Q5YW9raTVoZEwrR2NsbisxT3F2RXE2dnozYXVTbDEzblpreHRBd21i?=
 =?utf-8?Q?SO6ujIhkDFLqWOZFGvaplR8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A35870412AB4D84CB230B687F4595A17@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081919e0-9aa5-4f36-8904-08d9d65e000e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 06:29:06.5233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U715/tHzY3/XlG+h9NVSm8N+N4k5Oac2kH2YxQZNFhqLH+xeetIKHGORqlaJEWZdPaXfW/ajZvY0xf7FtUP5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2894
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDEyLzAxLzIwMjIgMjE6MTIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2Vk
LCBKYW4gMTIsIDIwMjIgYXQgMDk6NTA6MzhBTSArMDAwMCwgbGl6aGlqaWFuQGZ1aml0c3UuY29t
IHdyb3RlOg0KPj4NCj4+IE9uIDEyLzAxLzIwMjIgMDQ6NDgsIEphc29uIEd1bnRob3JwZSB3cm90
ZToNCj4+PiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCAwNTozNDozNkFNICswMDAwLCBsaXpoaWpp
YW5AZnVqaXRzdS5jb20gd3JvdGU6DQo+Pj4NCj4+Pj4gWWVzLCB0aGF0J3MgdHJ1ZS4gdGhhdCdz
IGJlY2F1c2Ugb25seSBwbWVtIGhhcyBhYmlsaXR5IHRvIHBlcnNpc3QgZGF0YS4NCj4+Pj4gU28g
ZG8geW91IG1lYW4gd2UgZG9uJ3QgbmVlZCB0byBwcmV2ZW50IHVzZXIgdG8gY3JlYXRlL3JlZ2lz
dGVyIGEgcGVyc2lzdGVudA0KPj4+PiBhY2Nlc3MgZmxhZyB0byBhIG5vbi1wbWVtIE1SPyBpdCB3
b3VsZCBiZSBhIGJpdCBjb25mdXNpbmcgaWYgc28uDQo+Pj4gU2luY2UgdGhlc2UgZXh0ZW5zaW9u
cyBzZWVtIHRvIGhhdmUgYSBtb2RlIHRoYXQgaXMgdW5yZWxhdGVkIHRvDQo+Pj4gcGVyc2lzdGVu
dCBtZW1vcnksDQo+PiBJIGNhbiBvbmx5IGFncmVlIHdpdGggcGFydCBvZiB0aGVtLCBzaW5jZSB0
aGUgZXh0ZW5zaW9ucyBhbHNvIHNheSB0aGF0Og0KPj4NCj4+IG9BMTktMTogUmVzcG9uZGVyIHNo
YWxsIHN1Y2Nlc3NmdWxseSByZXNwb25kIG9uIEZMVVNIIG9wZXJhdGlvbiBvbmx5DQo+PiBhZnRl
ciBwcm92aWRpbmcgdGhlIHBsYWNlbWVudCBndWFyYW50ZWVzLCBhcyBzcGVjaWZpZWQgaW4gdGhl
IHBhY2tldCwgb2YNCj4+IHByZWNlZGluZyBtZW1vcnkgdXBkYXRlcyAoZm9yIGV4YW1wbGU6IFJE
TUEgV1JJVEUsIEF0b21pY3MgYW5kDQo+PiBBVE9NSUMgV1JJVEUpIHRvd2FyZHMgdGhlIG1lbW9y
eSByZWdpb24uDQo+Pg0KPj4gaXQgbWVudGlvbnMgKnNoYWxsIHN1Y2Nlc3NmdWxseSByZXNwb25k
IG9uIEZMVVNIIG9wZXJhdGlvbiBvbmx5DQo+PiBhZnRlciBwcm92aWRpbmcgdGhlIHBsYWNlbWVu
dCBndWFyYW50ZWVzKi4gSWYgdXNlcnMgcmVxdWVzdCBhDQo+PiBwZXJzaXN0ZW50IHBsYWNlbWVu
dCB0byBhIG5vbi1wbWVtIE1SIHdpdGhvdXQgZXJyb3JzLMKgIGZyb20gdmlldw0KPj4gb2YgdGhl
IHVzZXJzLCB0aGV5IHdpbGwgdGhpbmsgb2YgdGhlaXIgcmVxdWVzdCBoYWQgYmVlbiAqc3VjY2Vz
c2Z1bGx5IHJlc3BvbmRlZCoNCj4+IHRoYXQgZG9lc24ndCByZWZsZWN0IHRoZSB0cnVlKGRhdGEg
d2FzIHBlcnNpc3RlZCkuDQo+IFRoZSAicGxhY2VtZW50IGd1YXJlbnRlZXMiIHNob3VsZCBvYnZp
b3VzbHkgYmUgdmFyaWFibGUgZGVwZW5kaW5nIG9uDQo+IHRoZSB0eXBlIG9mIG1lbW9yeSBiZWlu
ZyB0YXJnZXRlZC4NCg0KPiBTaW5jZSB0aGVzZSBleHRlbnNpb25zIHNlZW0gdG8gaGF2ZSBhIG1v
ZGUgdGhhdCBpcyB1bnJlbGF0ZWQgdG8NCj4gcGVyc2lzdGVudCBtZW1vcnksDQoNCg0KQWx0aG91
Z2ggdGhlIFNQRUMgZG9lc24ndCBsaW5rIGV4dGVuc2lvbnMgdG8gcGVyc2lzdGVudCBtZW1vcnkg
ZGlyZWN0bHksIGJ1dA0KdGhlICpQZXJzaXN0ZW5jZSogaXMgbGlua2VkIHRvIHBtZW0gbGlrZSBp
bmRpY2F0ZWQgbWVtb3J5IHJlZ2lvbi4gU2VlIGJlbG93Og0KDQpBMTkuMiBHIExPU1NBUlkNCg0K
R2xvYmFsIFZpc2liaWxpdHkNCiDCoCBFbnN1cmluZyB0aGUgcGxhY2VtZW50IG9mIHRoZSBwcmVj
ZWRpbmcgZGF0YSBhY2Nlc3NlcyBpbiB0aGUgaW5kaWNhdGVkDQogwqAgbWVtb3J5IHJlZ2lvbiBp
cyB2aXNpYmxlIGZvciByZWFkaW5nIGJ5IHRoZSByZXNwb25kZXIgcGxhdGZvcm0uDQpQZXJzaXN0
ZW5jZQ0KIMKgIEVuc3VyaW5nIHRoZSBwbGFjZW1lbnQgb2YgdGhlIHByZWNlZGluZyBkYXRhIGFj
Y2Vzc2VzIGluIHRoZSBpbmRpY2F0ZWQNCiDCoCBtZW1vcnkgcmVnaW9uIGlzIHBlcnNpc3RlbnQg
YW5kIHRoZSBkYXRhIHdpbGwgYmUgcHJlc2VydmVkIGFjcm9zcyBwb3dlcg0KIMKgIGN5Y2xlIG9y
IG90aGVyIGZhaWx1cmUgb2YgdGhlIHJlc3BvbmRlciBwbGF0Zm9ybS4NCg0KVGhhbmtzDQpaaGlq
aWFuDQoNCg0KPg0KPj4gRnVydGhlciBtb3JlLCBJZiB3ZSBoYXZlIGEgY2hlY2tpbmcgZHVyaW5n
IHRoZSBuZXcgTVIgY3JlYXRpbmcvcmVnaXN0ZXJpbmcsDQo+PiB1c2VyIHdobyByZWdpc3RlcnMg
dGhpcyBNUiBjYW4ga25vdyBpZiB0aGUgdGFyZ2V0IE1SIHN1cHBvcnRzIHBlcnNpc3RlbnQgYWNj
ZXNzIGZsYWcuDQo+PiBUaGVuIHRoZXkgY2FuIHRlbGwgdGhpcyBpbmZvcm1hdGlvbiB0byB0aGUg
cmVxdWVzdCBzaWRlIHNvIHRoYXQgcmVxdWVzdCBzaWRlIGNhbg0KPj4gcmVxdWVzdCBhIHZhbGlk
IHBsYWNlbWVudCB0eXBlIGxhdGVyLiB0aGF0IGlzIHNpbWlsYXIgYmVoYXZpb3Igd2l0aCBjdXJy
ZW50IGxpYnJwbWEuDQo+IFRoZW4geW91IGNhbid0IHVzZSBBVE9NSUNfV1JJVEUgd2l0aCBub24t
bnZkaW1tIG1lbW9yeSwgd2hpY2ggaXMNCj4gbm9uc2Vuc2UNCj4NCj4gSmFzb24NCg==
