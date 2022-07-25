Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1013A57F88E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 06:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGYEBC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jul 2022 00:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiGYEBB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jul 2022 00:01:01 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6F1011
        for <linux-rdma@vger.kernel.org>; Sun, 24 Jul 2022 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658721660; x=1690257660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Yd8qaLHDWRpnAVyf/wKsX1Eh1pVeyizbhAJx5LTYgg=;
  b=zJ3NeOCsVQA6zRoSBueb7zNOZsiBfQlPsVnz/1lm41Q9vYDJpS8C+4Vg
   lcMQ9JPjZZzv2PIw3GQd52fEjzWu3ax8uy/JgTluB0I2ZNY+otGBuUk54
   d6z2N2Rbz3VStSvqPRRgxABIMfBzWfdXbiGsI9nSjSA0GBKf4A7XwKFYi
   T8PKcAnkFhVRorApBGP2wie/xbBgEg7EJBnwIPJrHBMdoStCdw05nndNE
   Eeq//DRXNwZ6RjfMeMbsNyXbV33a2sYE/LP6mIlh5nFk6VA49kBS8Ca4u
   C5un4LJHSL5Nqk44trV+DxlvXCfPegFdHtXKfiG4v+htGER31hmIcs+JP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="61318906"
X-IronPort-AV: E=Sophos;i="5.93,191,1654527600"; 
   d="scan'208";a="61318906"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:00:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjgn5Bbqb8QjEGJH+B01K1Dl6XJBAJRNfaYNxWjNpGZgBdKgU9SQ5sVb+6BxzdH/9azgLsPLHhdSaER/1zLrB+U93TpXqi4UFWkjXwgZRJsq+C9EFnfo2Oyt8zN5NRiqSgGvDKsS2PoKFZ0Ri9JSTI758jtAurArjHc/FkSXKzdbUyRq3GkKBH+tWGBWOJvuGfrMebZ1Yb2XU5gOipbV+IGtziuH8gDTiVSMgtfeHu/a0amBoRRxnB61UwgeYB3wZ02mZ69HdbQ0WIyPsQN4xiAvUIrq3fnJdDEVXNPPFEKpeq5Boo5SklYBuMN0ws3Xvk2Xgm0ZypQG117rvWwXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Yd8qaLHDWRpnAVyf/wKsX1Eh1pVeyizbhAJx5LTYgg=;
 b=OAJdLdNeKEtdV/HuPlShCyospji/ASsfyBjF4/j88SECmlBfBTOMvCoFxJICxuAlO3D/tzkBZUIVWW4C3vLNDPFrGhhOzTbC6MSvYhvYWABwbeOzSUnEIWLUD0OK2+XZ9xTOdvj9qCmzFPk/S336RJmQ4zqVXUYTyK6JdKj1emIaGgxviWAjW8vBcaTGtFwGYRi8PK5EKgTQ4JetUspO2hmMJKV0434j3O62HKohalMbfFz67eH+xIg4KOEnOz7bERfJUshGnCXfsYbS4QOfgZihUURil/MhZ9wyE1Ty/HFRcuM+8fcYAzMUbI5JfVFxISdVYf8ot3nX+CmywzUkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB3116.jpnprd01.prod.outlook.com (2603:1096:404:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 04:00:53 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 04:00:53 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
CC:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Thread-Topic: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Thread-Index: AQHYnCKksO3/TjsEbUejYY02ELeZ6K2HFOEAgAIPRoCABVnSAA==
Date:   Mon, 25 Jul 2022 04:00:53 +0000
Message-ID: <9f67703e-a030-c467-dfd6-6b4cf0538e7f@fujitsu.com>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
 <17df2afa-3c5d-c57d-47ad-640399279965@gmail.com>
In-Reply-To: <17df2afa-3c5d-c57d-47ad-640399279965@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7524cc4a-a782-4ba8-57d0-08da6df244e9
x-ms-traffictypediagnostic: TY2PR01MB3116:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbqMzQLTrm68ls96koZB+VA092tipoq+WzWy/uvxU1PL6BsVif97JSt8lX1kLLh0oKCiHRZZSpx/Pkb0t9r8W3QN8WEuLCuauDbHYkLl/GEhmq6UxEO+OVAR+rKbxttyV8eBgjyoPD2Db57nNkpxPllFzCObBO59MfX8KE5XDG24oteUQ4Wtorwxa/75sKHm9yY0p/mW9Qn+mWc3AO4UbM1BQpDmPMAsO/BM64elWSx2zu5ziKFNsoBxl14F6WM4R7TNti7Oq2i8MSdNTkOx6dgjW6vaAWVymHQ8tRQ/yB/5jQ9TzDHALGKxDcKonjnrsx4QnDbMkazOJdflZ7gzuRxGtjpbdtLSCstpWthxdSaOzX6VtpO1JAsB9uztCOMYUtU3lPLNkDrvKTG2bxBnW5qq0FP3TOrL1EuugNlqfNncjYaNTcbLQzXlhP48rwdmYeADScokKCuQo4IXuE4zpNNSpsMczm0xQtDwLrxF7hEjulW3pxo6FZeANwG7mH5wokndjWLvrUqqHu8T6WuBR1j6u8zvaHHQwFmjCjQoWdM3gMHt6xFVjYR9rHHJk9yCLJ8nSXzbGH+U4U4Qu6ADLGFc1oxkY4K3q7hpHOYVRaycnHghqIFA557PYYmrvUJ/eX8SeIla6hWuQOmqtWsst+EvKKtqMatYg6kmYUwgRjfXKpAxB7t/anLZjkWyB3TTjQFXk3I777gnbwi6UN/hCK/DGfsLmLo8zA4c/wVXYknXL2H3TkTooReWnfqd6tN55kl+YjeKcb7cn3XsUb/Qoq4oem/mLeBvrhhKaEwaS5qA3QhwwWFM/UbKcaTVJmyDWWM1NTVBVrBekoMbZtoxk1yzz+JxvjZL0YySMEd0amEMGJWLGuoDbFVMu3iY3qf6eSaaAWvPy+sF46i/jHCPGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(71200400001)(6512007)(966005)(6486002)(8936002)(5660300002)(478600001)(53546011)(86362001)(6506007)(186003)(2616005)(31696002)(26005)(83380400001)(2906002)(41300700001)(316002)(54906003)(122000001)(38100700002)(85182001)(31686004)(36756003)(38070700005)(66446008)(76116006)(66946007)(66476007)(8676002)(66556008)(4326008)(64756008)(82960400001)(110136005)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azJmWDhId0JFVWU5ZDFTc0pSZlE0aVpWcjlrMDhHc0VsYVY1NUhIMkU4ZWdk?=
 =?utf-8?B?UTNqWkxOS1pacXJTVWRSZHkzYXJJTm9NMDdabE1ZK3k1bENpZ2x3ZFlXdjFO?=
 =?utf-8?B?Sm1LVmRCUXdnS0xqR1hLaGwwbWxxTUppWTBhbVNTaVlBS2tIYUpENVB6emdj?=
 =?utf-8?B?TWNrMVZ2UjBqWlVjZkZ5UElSSGJQdlFCNkk2bGcvdmVhNWw4VGRzRm15aC9W?=
 =?utf-8?B?UTlPY3dIR2NsUmZvb0lOSm83ZUo0emozbC9KNUZLK2hzaFBKU2VZWHpVb0tO?=
 =?utf-8?B?TXg5VFpGUEZvYy9OOTdab1RIdU5PQU52NURGdjBmV0dOa0dJT0cyZFRMUk56?=
 =?utf-8?B?WXhVVndYMWlubjNhYVVjS01UM1JzMGhYYmtTT1RaOWx2Tlc0b1FBRnBuN3RR?=
 =?utf-8?B?TkRmUnpOMlUvWGduMU5pMXhhcHR4endBVmNYdzlBK3JBRE0wNERVS00zekdn?=
 =?utf-8?B?VkdsWnY1ZVBXaHFVZ3ZYWjlKczBFL3hnYzR4aHhpaTBKR05lMTdrK3BvVkNS?=
 =?utf-8?B?UUVtc3lJR1lZTkhrc2NRTE1wcGRFaERiUitOY2lUc1F2WnI4QzRFRDY3MExP?=
 =?utf-8?B?bHdzYjNsMDBMMzNNM2VEcXVuR09QM2V0NldzSTlTWFFzZVZpVmFwQnRaZFV5?=
 =?utf-8?B?bWZ4QTJWQ0VWRVhrMUlpS3VsWlZRMTZSSDBoSVJhemhrdSt2VGVUbkZKMHFF?=
 =?utf-8?B?ZDl3UkFCUHJoQzN1SUMwbWRQN3VQckdqT2F0WlZoRmNoYU0xWWZLK2dHczB3?=
 =?utf-8?B?VWxMWnBTT0dPS3JyTVBydzV0alUrSTl5cGFqdUxNUWFlSWlUMVMyU1RRVzNu?=
 =?utf-8?B?ZWU4RmtRWXNYODdHOGR1V3Z4QmNvMlhhR2tMVit3eFVNUHVsY0EzNFBZdlNq?=
 =?utf-8?B?amVDS0VPcFNTRUhYNCswUW0rZGJoQk9VZkRJdC9yWSt6T2xWUUpZY1dYb2Vt?=
 =?utf-8?B?ZUIxYjRsWnZBYkE2cmVQeUFZSjFvTURqWnhwdG9ZOWRGbXJzUTR0UXdUeHB2?=
 =?utf-8?B?S2FKUHdYUi9RdE8wRjBZTFdwU1FteVdhaExLZG5wcUhBOElrMGRBZzhOZU9n?=
 =?utf-8?B?MjdxVi9IR3dmV05zcUZURFlkaWpSZUljeW9wZERWTkdkd3FHRGhRUWd1cTZs?=
 =?utf-8?B?V2JJb2pNSDlRMTZmYkJ0VlBaWXlCMDY0blA2N0RzTnFXcGx5QkxBd1VVSC9U?=
 =?utf-8?B?OWdMemxRaG1tWlJ3dXRySzVyQldKM0dPRUFISVhtamZoRFFNMU90dE14alFF?=
 =?utf-8?B?akc2ekV1VTJ4aFZna1IrSU1oTWkvYVJ5Z0FrOGtsdFNYUCs1UnppSUQ3U2lS?=
 =?utf-8?B?aGtycUF4aFE3YnAzRUVqcXlheXBDa0hLSngwSXRvc3dyUGxYbGVPMTc1RmhL?=
 =?utf-8?B?SXp3WjZUclJzTXhjZk5nUGNYamVkMDBUWmdDZjJzUWVlVVAyZ1JlemE5UFFF?=
 =?utf-8?B?ZnJiSTRaUkN1Y2tUdlZtOWhKSHVYaWd0QllBRUxaMjIyNnlaSWNGanIwTFFE?=
 =?utf-8?B?UzdFMlFmbkFQM0RkYXNud3Y5TGdCdHJkNmZrbFJNMFFVMGRhb05FUjMwL3pq?=
 =?utf-8?B?cHdGY29rMEYwUytVTWd5eCtRWS96MzZscEUwRDM2dTRoTnh6SXBkNlNScm9X?=
 =?utf-8?B?WEdEcitnaDE5YmJjQTZDQzB2MXR6Y0puRWJIckNGcWhxRkZ5Wm43eFF5QnR6?=
 =?utf-8?B?eFVCQXMzdXIvYXRkb1FXYklPNkVpM0RoNHdUNm9QdGJsRU80L2dab3VSRlU5?=
 =?utf-8?B?Rit5My9JNHBkWkh3ZThyYlhBd2FEODZkaFZibTVVN1NmeUxFZ3lnaVlvdno4?=
 =?utf-8?B?aEtFQWVKbGoyUTNtWlYvWWVpdkE1NHBMdUhCcEZrRzBURlhjUlVCckx6YlZN?=
 =?utf-8?B?SGExZVV5VWlzSFM3R3lwZ3FHVTlBNFdJdTBKT3FMNmJvOVF5NS9QNmJMR25t?=
 =?utf-8?B?d29PVGVCY09ISlY1c1NXS2tPaTF1bFRQd29yL3ZvZGVOUUppMUNhYlBGV3VF?=
 =?utf-8?B?Y1dxRlJzR0lHUkR0eE5hT0FraGM4TTNtQ282V3pOOUxqeHp2SmpsTng1eEFp?=
 =?utf-8?B?QVVFNXJjUjFnSFNrdnNERVV0Wmw0b2hLK29WWi9oU2NiNGxabjFsZGhoWmZ3?=
 =?utf-8?B?TkdnajdvN2UyUjJ3NWZibUh1dU45MTQrbkEreEQxblFYZi9DT2Z4dys3MGxM?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21047EDCAD6D97478B7D0E99A1D733FF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7524cc4a-a782-4ba8-57d0-08da6df244e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 04:00:53.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGzIPsui79enHcHcf/nsXq4gO4BAdPJdnGKb8Z1qdMFvWROD35ciP6litA02BegVLQjdhj0NsozEoJRhzpwxGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3116
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIyLzA3LzIwMjIgMDI6MTgsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA3LzIwLzIy
IDA1OjUwLCBIYXJpcyBJcWJhbCB3cm90ZToNCj4+IE9uIFdlZCwgSnVsIDIwLCAyMDIyIGF0IDEy
OjIyIFBNIExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3JvdGU6DQo+Pj4gQmVs
b3cgMiBjb21taXRzIHdpbGwgYmUgcmV2ZXJ0ZWQ6DQo+Pj4gICAgICAgOGZmNWY1ZDlkOGNmICgi
UkRNQS9yeGU6IFByZXZlbnQgZG91YmxlIGZyZWVpbmcgcnhlX21hcF9zZXQoKSIpDQo+Pj4gICAg
ICAgNjQ3YmYxM2NlOTQ0ICgiUkRNQS9yeGU6IENyZWF0ZSBkdXBsaWNhdGUgbWFwcGluZyB0YWJs
ZXMgZm9yIEZNUnMiKQ0KPj4+DQo+Pj4gVGhlIGNvbW11bml0eSBoYXMgYSBmZXcgYnVnIHJlcG9y
dHMgd2hpY2ggcG9pbnRlZCB0aGlzIGNvbW1pdCBhdCBsYXN0Lg0KPj4+IFNvbWUgcHJvcG9zYWxz
IGFyZSByYWlzZWQgdXAgaW4gdGhlIG1lYW50aW1lIGJ1dCBhbGwgb2YgdGhlbSBoYXZlIG5vDQo+
Pj4gZm9sbG93LXVwIG9wZXJhdGlvbi4NCj4+Pg0KPj4+IFRoZSBwcmV2aW91cyBjb21taXQgbGVk
IHRoZSBtYXBfc2V0IG9mIEZNUiB0byBiZSBub3QgYXZhbGlhYmxlIGFueSBtb3JlIGlmDQo+Pj4g
dGhlIE1SIGlzIHJlZ2lzdGVyZWQgYWdhaW4gYWZ0ZXIgaW52YWxpZGF0aW5nLiBBbHRob3VnaCB0
aGUgbWVudGlvbmVkDQo+Pj4gcGF0Y2ggdHJ5IHRvIGZpeCBhIHBvdGVudGlhbCByYWNlIGluIGJ1
aWxkaW5nL2FjY2Vzc2luZyB0aGUgc2FtZSB0YWJsZQ0KPj4+IGZvciBmYXN0IG1lbW9yeSByZWdp
b25zLCBpdCBicm9rZSBybmJkIGV0YyBVTFBzLiBTaW5jZSB0aGUgbGF0dGVyIGNvdWxkDQo+Pj4g
YmUgd29yc2UsIHJldmVydCB0aGlzIHBhdGNoLg0KPj4+DQo+Pj4gV2l0aCBwcmV2aW91cyBjb21t
aXQsIGl0J3Mgb2JzZXJ2ZWQgdGhhdCBhIHNhbWUgTVIgaW4gcm5iZCBzZXJ2ZXIgd2lsbA0KPj4+
IHRyaWdnZXIgYmVsb3cgY29kZSBwYXRoOg0KPj4gTG9va3MgR29vZC4gSSB0ZXN0ZWQgdGhlIHBh
dGNoIGFnYWluc3QgcmRtYSBmb3ItbmV4dCBhbmQgaXQgc29sdmVzIHRoZQ0KPj4gcHJvYmxlbSBt
ZW50aW9uZWQgaW4gdGhlIGNvbW1pdC4NCj4+IE9uZSBzbWFsbCBuaXRwaWNrLiBJdCBzaG91bGQg
YmUgcnRycywgYW5kIG5vdCBybmJkIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4+DQo+PiBGZWVs
IGZyZWUgdG8gYWRkIG15LA0KPj4NCj4+IFRlc3RlZC1ieTogTWQgSGFyaXMgSXFiYWwgPGhhcmlz
LmlxYmFsQGlvbm9zLmNvbT4NCj4+DQo+IExpLA0KPg0KPiBJdCBoYXMgYmVlbiBhIHdoaWxlIHNp
bmNlIHRoaXMgd2FzIGFkZGVkLiBJZiBJIHJlY2FsbCB0aGVyZSB3YXMgYSBwcm9ibGVtIGluIHJu
ZnMNCj4gdGhhdCB0aGlzIHdhcyBzdXBwb3NlZCB0byBmaXguIEl0IHdhcyBhbHNvIHN1cHBvc2Vk
IHRvIGFsbG93IG92ZXJsYXAgb2YgdXNpbmcgdGhlDQo+IHByZXZpb3VzIG1hcHBpbmdzIGFuZCB0
aGUgZHJpdmVyIGNyZWF0aW5nIG5ldyBvbmVzLiBCdXQgaXQgc2VlbXMgdGhhdCBtb3N0IGZtcg0K
PiBiYXNlZCB1bHBzIGRvbid0IHJlcXVpcmUgaXQsIG1heWJlIGFsbC4gQmVmb3JlIHdlIGRvIHRo
aXMgd2Ugc2hvdWxkIG1ha2Ugc3VyZSB0aGF0DQo+IGJsa3Rlc3RzLCBzcnAsIGx1c3RyZSwgcm5m
cywgZXRjIGFsbCB3b3JrLiBIYXZlIHRoZXNlIGJlZW4gdGVzdGVkPw0KDQpibGt0ZXN0cyhudm1l
IG92ZXIgUlhFIGFuZCBzcnApIHdvcmtzIGZpbmUgYWZ0ZXIgdGhpcyByZXZlcnRpbmcuDQpsdXN0
cmUgYW5kIHJuZnMgaGF2ZSBub3QgdGVzdGVkIGJlY2F1c2UgSSBoYXZlIG5vIGx1c3RyZSBhbmQg
cm5mcyBsb2NhbCBlbnZpcm9ubWVudCBjdXJyZW50bHkuDQoNCkkgZG8gd2lzaCB0byBrbm93IHdo
YXQncyB0aGUgb3JpZ2luYWwgcHJvYmxlbSB5b3UgZml4ZWQgaW4gNjQ3YmYxM2NlOTQ0ICgiUkRN
QS9yeGU6IENyZWF0ZSBkdXBsaWNhdGUgbWFwcGluZyB0YWJsZXMgZm9yIEZNUnMiKQ0KQ291bGQg
d2UgaGF2ZSBvdGhlciBhcHByb2FjaGVzIGZvciBpdCBzdWNoIGFzIGFkZCBsb2NrcyB0byBwcmV2
ZW50IHRoZSBwb3RlbnRpYWwgKnJhY2UqLg0KDQpJIGFncmVlZCBvbiB0aGUgdmlld1sxXSgieW91
IG5lZWQgdG8gZ28gYmFjayB0byBvbmUgbWFwIikgZnJvbSBKYXNvbg0KDQpbMV06IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDUyNzEyNDI0MC5HQjI5NjAxODdAemllcGUuY2EvDQoN
ClRoYW5rcw0KWkhpamlhbg0KDQo+DQo+IEJvYg0K
