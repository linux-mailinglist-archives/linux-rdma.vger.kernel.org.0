Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D048F4959D7
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jan 2022 07:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378665AbiAUGUO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jan 2022 01:20:14 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:56385 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378655AbiAUGUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jan 2022 01:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642746013; x=1674282013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KBf068gmlCSIlxAVGUUByMuX/Kgq9+XLSRYsWGO49fo=;
  b=B93f4Kx6ndiUVUvpyF9DnnzJlVb7K7quLY4sV5CQA2g7db/63MRc/ZCS
   xNT4mqUVbjbZII93l+xTPGMsrEQT/AI2i+1NEEjsgKVhuR+dfs89ddHj/
   sacon6Ch8trmDGvPj5rQvYSBlB2MeZsx9BahihWpMd1TNjQI5CSzUCzVF
   UYV/dhnk8VS7Ns2ukhMk/p2O7VxxeEtQlnPed7NXV8fqLeUAu//+L+3u0
   QloxXnCMlN9ZG5AY2v0N9o7S47iABSryiAngmNP4TnIYDtPIb7Oiv6B4K
   EsH93itt8tLFr7JinBYzRzdmHL4qoHsdVwi1G7KYryZ+rkkO8HAjDiELu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="48184572"
X-IronPort-AV: E=Sophos;i="5.88,304,1635174000"; 
   d="scan'208";a="48184572"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 15:20:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNZDcfLmdwyOtAB1MMKzwui53Nwq6G6DuH2WieTVnGcJ4E4gqqn17SC2hLLFGeW6tK15+6CnOwVCmw4oQLnIr2CUqvmQoFM4EtkIcK/EoGuZ31cOrD0WiMj5MSqlP5IL42IutRnlFQT9ioCj55dYZCzktuQGOTExTZbGXNfV8I3vZI+Py6ShZJbyFPhot6T886b9OaEO0M8MEgpBX1VHL/sK6axHPF4vdbazto+mf8Bzc82kFYqgjyL6nRi/4x5APnSlwTI95PiqfUoZDYrH9Hi237SqoRKwQR5s6GWZK6bLldx8pMuYCrOtb+Pyfv6BhpCQtfr6uoAAOi1Cnnu0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBf068gmlCSIlxAVGUUByMuX/Kgq9+XLSRYsWGO49fo=;
 b=FPnXjcYxm+YdjsUPugd43KcgZZffCUo4jcrc2fENea877GDVA1Px7LVvjfQlyT7YPJlWMvqTXnPWxolS+o4c4LAG8XG15w0/gXzyPK1e1IQuXyiIk2HnC6wITVuFdLj1tP/4NkxNsEINeycQh2tPL1VCVlCgo4fhKANtViP+B3wDaA0qWAbHcJBnSEyfVYwKLrSRaAOWtrFoemgheGdG73P+o+Z0YTcPe18BgvAKID8FCi5vwXdSyOsUUI/aw6kOyOdWQyLO6z08X5d925JcNmtiwT08T7jCNbpIatMEKBdANMgidpZKslnJ06QBHRxxscQISy8nN8oP1l+rNbQEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBf068gmlCSIlxAVGUUByMuX/Kgq9+XLSRYsWGO49fo=;
 b=mDuLYB4o4C4YZIrLERi9huHsogH9rkvsFDF6dBuO7QwFN7zpFLcyeEd7XlfyB0SxvvIlJV5LC35zsb4U/mKMQ08FjDKXnHfqAwPcpW1e/NKjZkcmzSd620RmhIPJm8QvZnhBV5zTiYZx4ICw+TuI4b0vhL3qfxC2c8Eb1VVrVRQ=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS0PR01MB6146.jpnprd01.prod.outlook.com (2603:1096:604:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 06:20:08 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 06:20:08 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Fwd: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: Fwd: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&'
 in check_qp_queue_full()
Thread-Index: AQHYDEow7oX0AnDnYkSZqdV5YEsLFKxrXviAgAGmS4A=
Date:   Fri, 21 Jan 2022 06:20:08 +0000
Message-ID: <61EA5091.5000504@fujitsu.com>
References: <61E6823E.9090808@fujitsu.com>
 <b25e4695-000f-0f8f-3e50-184e567132b8@gmail.com>
In-Reply-To: <b25e4695-000f-0f8f-3e50-184e567132b8@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 245bffb7-17c6-417e-d665-08d9dca612d5
x-ms-traffictypediagnostic: OS0PR01MB6146:EE_
x-microsoft-antispam-prvs: <OS0PR01MB6146DB9B13D184B8A29E9D87835B9@OS0PR01MB6146.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BYi7SZ0hU9JXv2S96PBJiZ1PHdXKImD0xQfyWSM0QmR0+pT+Q4zm08Qr/oDJ4hkY32a6O+daw3+p/UFxOCKY7wofDHtKE8JjFxbemOqaMGkduoVDWfXufEtdnBzRPU/w/FM5jnEx+ca4mRHaUyQfObapqfFHnUpgehuqYcNkCzLVOncc3HX+ezBk8LgCSw2xWKxg+e/1PSVfQMWQofVrMpY4rvTohhl0qenrDb4ZswpATAsKojJisBF62lxs+1j+I66dJNAcAQZoXOvVXJBIwDgdjUJh6MUElwo0Wx7+VKzu5M8LjisvZquWK5ir/lgNQDyTIshXb3WNJsOERWvVgaEc2BMusOogliFw+kuOi28Zw3jmAMtCZqSoB0avpCQ4gfqSY/vHHB9Nujwn2NACE8m3cqMSmZEAqRgghR0oWjEmaqYTIjwbE5MqJvXOj9bzkhqlTPwOi61oS5KZAvCoudjZ8t1V2XU1pS7HeafEp1ot0Yq87docfFEp1bEQidg0dbWpwF6GF8QqeYBOnDvo3YXCl70X20xQZ+Pr4QpeLzbhenV6GaPcZ6VHbHr1CBQFnSkhL5HmavyqSOrPx4B/HXF6H0qIaB25g04mnLQ45yW6Nq9pSP2mJlNcEAuWRsyA7bnyHXVN6v6eMbWt8RhuPB+VpfC+uT8ChlZPd2PLnMFPTS512Rjb8YVZsHMOngyiyoBrDHgKrq3jz71V2Fypg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(71200400001)(38070700005)(64756008)(66446008)(83380400001)(66476007)(91956017)(66556008)(76116006)(85182001)(186003)(66946007)(5660300002)(82960400001)(6916009)(33656002)(316002)(4326008)(6506007)(8936002)(38100700002)(122000001)(87266011)(508600001)(6486002)(36756003)(8676002)(2616005)(2906002)(53546011)(6512007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJWUlJlNmQ4ZFFQcmVKV1BUd3M1K0lsakNucm13S3EzSEJmNHJaekI4ckpQ?=
 =?utf-8?B?bk1MQ0hIbnJ4NFVEL1BVWUlTUk5CQ25ESFpQWm1pMmFiZDI1VURDdm1NT0x6?=
 =?utf-8?B?cDNlVnVSS0pySDlRZEE5Nk10QWNOMzI3R1c1NEhzZjFibHhJZnI4WjVuKzlh?=
 =?utf-8?B?NmFPYTRyYWp2WFViQjBycERnWmtUSzRTckd6L2ZaWUVVbVA3RkQwK3B3RkY4?=
 =?utf-8?B?aDJPelprUlN2OXpOYWF4MjMwVm5hRHBtekh3NzhqTFlBUnZ6TFFsc2xZRkZG?=
 =?utf-8?B?ZU0vU1RCblIxcEZWMk9Cd2srNUVRRTVacXBQbElDR2RqemIzSXJKcVV6T3BS?=
 =?utf-8?B?WnF3cE9MTHFtRG1DOHdrNzdYdC95d21rVW1YWDBoVCszOE1OWEZsK2tLQ1dP?=
 =?utf-8?B?UWZYUUxLNFd2WDcybVg4OWRjUDROdENIenpLTklTVFB3cW5kR2RGYXl5Zmcy?=
 =?utf-8?B?QUk2ektVajlvN1BkeVd5T2tEQWVjVHVDUnZDTFpkU2Z3KzJmMGhMTVQ5S1FI?=
 =?utf-8?B?aHNhZ090cmV5c1JFRkdKQ3hoclpUL21GNkNCRVdZKzI3NnA0ZTlzUG55SVN1?=
 =?utf-8?B?VG4vQzZpcmRncXF6WEpyc29INjVrdmVhREV5MEFlQXcrdk5wZjd2bDFla0RD?=
 =?utf-8?B?cC9rbnU0U3FlbHpRVE1kOXBIZEc4T1JuZHlnQ1JFSWVtL0JjQWQ1MXNYNnh5?=
 =?utf-8?B?azdJcndCVjhaRUtOeXRWTlF2UGllUmEwYm0yMzVpRWFDbmVJaTA5a1NpVW1h?=
 =?utf-8?B?RVhnWFppckJhTlVvVUtBMEpBRUgzODI0bDEya3ZkVkc5YU14Y3Uxazk2SlBD?=
 =?utf-8?B?ZTBlWWlWbk5MWUl1WHpVQUVPY1ZVT3BnOWtvdkhXQXhhSXd2TEhaNkZaUUI5?=
 =?utf-8?B?eDZtczJpRzB1MnlWM0pic3JhdTlZbEhBaFZEbUZMZXg0M0tOb0V6QXRLdUxM?=
 =?utf-8?B?ZTIxOTJpYW83TjdDNExNdU42bG9XZmx3ZUYyYUJqNjlUaE5nN09VU2xRV1lF?=
 =?utf-8?B?R1BJeG54MmpVRnJnQkY1YTRoRjh2cTZuQmJDRTF0a0VoUWtmT1c4aEdJMjZ1?=
 =?utf-8?B?aEh6bkpTMDFteS84STRUQm1pQ2xBUkswajhyQTB3blpxUUI3UENDOHhqUFBn?=
 =?utf-8?B?MXhiNS80enREcFFvZDBqUlpiWExmVzQxZlQ1UHdYaWd0dzJhMU95V0xlRnBC?=
 =?utf-8?B?bmhpWFhhUmtmNzhHK3RNcXNMZlFDTVoxcDQyVUgyZXgwUU9sbkFsd1lZRWdj?=
 =?utf-8?B?dklNRnM5eGZWNUpnczFkSjUzU3JGQXJKOEdoeFdxa0c5NGJDeGZIdmRxS0U2?=
 =?utf-8?B?UkMwZUVqVU1abTIzNmlGRnhHV2I4TTBCeGJidEtHNWFZWEtxL1FKd2UwS25J?=
 =?utf-8?B?d0t4SDdJRUlXOXMvM3pZNzBFL21BNUJDa3QrMERTZnVlM2g0TUczYTRPMXVt?=
 =?utf-8?B?eVFDMUtndDFENWh3aXB2Vk9VMmdnQlJ3MEpkVW1ybExyNnJlV2ZGWkZybVJ1?=
 =?utf-8?B?ZXhNMFJ6Q0JTbVZLc3g3akc5QS9TNU1ISGF1T3oyblhQS1RqdWQvSW5JLzhR?=
 =?utf-8?B?RVBnYnNoTmlxTDh0VzBiZ2lQM3lkUEtLYmRUY2xQYkthL1VxWXBMc3BiNnBB?=
 =?utf-8?B?amNVQTFqMU1XbnpSSks2K0F3akRQYzI2bU1GWW5iaWU4cXdxUmFYV1M0QWFx?=
 =?utf-8?B?SDhhb3pTTkc3dXRHTjBTckI3dHAyV1JEYzZRSUZaZWRNUW1zRm80eDV3QUx1?=
 =?utf-8?B?QXhSWWY3QnZyaTlJRDExR096eWdaWERSOGY0czhYRWtNelM4bW5YLzYrSVVP?=
 =?utf-8?B?U0dJYXBKS0R2Z252K1ljTDlFbHZaa1p4aHUrTU5KTHdTSUY4Q0drZE15Wlk0?=
 =?utf-8?B?N2V2L2xtRmprbVJ2dVhtQllrbFlsRVU0MjFGTHoySTBlUkRKMk1zS3J5QmEw?=
 =?utf-8?B?cVlUUm9pL3luU0wzb1Y2WGhTSmRBMHZaeGhyTTdEWmVGdFpFdzRyeWtBWEVM?=
 =?utf-8?B?c3JnN1hwS1dVRDEvakxMU0JLVGd2VkxrNjJuejcvYTVBemFTVEorVjVZdE5X?=
 =?utf-8?B?MXBKeHNRQ21PSndCbllDd0grM3AzeXBib0ZWOVdwMklDWWlvZGRBV2Ntcm52?=
 =?utf-8?B?VFRNUmRCazBybHppbW9SbE1xRTdSeG5QZXczcW9Kenh5RUJGaUp1blA1bE5l?=
 =?utf-8?Q?5GWxoIR05hx1wpvDrkiWAuk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F3E30DA5721B4B89CE9259E2756ADB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245bffb7-17c6-417e-d665-08d9dca612d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 06:20:08.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYJ6D1foHcg4X/aSWfFG/r+GUvHpeFxx34REfvpARepdMCfny9a4BdAFPq63Xmx6AzIPUJfUWU3S7bWYONpvEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6146
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzIwIDEzOjA4LCBCb2IgUGVhcnNvbiB3cm90ZToNCj4gT24gMS8xOC8yMiAwMzow
MiwgeWFuZ3guanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+PiBDQzogbGludXgtcmRtYSBtYWlsIGxp
c3QNCj4+DQo+PiBPbiAyMDIyLzEvMTQgNDo1MSwgQm9iIFBlYXJzb24gd3JvdGU6DQo+Pj4gVGhl
IHdheSB0aGVzZSBxdWV1ZXMgd29yayB0aGV5IGNhbiBvbmx5IGhvbGQgMl5uIC0gMSBlbnRyaWVz
LiBUaGUgcmVhc29uIGZvciB0aGlzIGlzDQo+Pj4gdG8gZGlzdGluZ3Vpc2ggZW1wdHkgYW5kIGZ1
bGwuIElmIHlvdSBsZXQgdGhlIGxhc3QgZW50cnkgYmUgd3JpdHRlbiB0aGVuIHByb2R1Y2VyIHdv
dWxkIGFkdmFuY2UgdG8gZXF1YWwgY29uc3VtZXIgd2hpY2ggaXMgdGhlIGluaXRpYWwgZW1wdHkg
Y29uZGl0aW9uLiBTbyBhIHF1ZXVlIHdoaWNoIGNhbiBob2xkIDEgZW50cnkgaGFzIHRvIGhhdmUg
dHdvIHNsb3RzIChuPTEpIGJ1dCBjYW4gb25seSBob2xkIG9uZSBlbnRyeS4gSXQgYmVnaW5zIHdp
dGgNCj4+IEhpIEJvYiwNCj4+DQo+PiBUaGFua3MgZm9yIHlvdXIgZGV0YWlsZWQgZXhhbXBsZS4N
Cj4+PiBwcm9kID0gY29ucyA9IDAgYW5kIGlzIGVtcHR5IGFuZCBpcypub3QqICBmdWxsDQo+IGZ1
bGwgPSAoY29ucyA9PSAoKHByb2QgKyAxKSAlIDIpKSA9ICgwID09IDEpID0gZmFsc2UNCj4gZW1w
dHkgPSAocHJvZCA9PSBjb25zKSA9PSAoMCA9PSAwKSA9IHRydWUNCj4+PiBBZGRpbmcgb25lIGVu
dHJ5IGdpdmVzDQo+Pj4NCj4+PiBzbG90WzBdID0gdmFsdWUsIHByb2QgPSAxLCBjb25zID0gMCBh
bmQgaXMgZnVsbCBhbmQgbm90IGVtcHR5DQo+IGZ1bGwgPSAoY29ucyA9PSAoKHByb2QgKyAxKSAl
IDIpKSA9ICgwID09IDApID0gdHJ1ZQ0KPiBlbXB0eSA9IChwcm9kID09IGNvbnMpID09ICgwID09
IDEpID0gZmFsc2UNCj4+PiBBZnRlciByZWFkaW5nIHRoaXMgdmFsdWUNCj4+Pg0KPj4+IHNsb3Rb
MF0gPSBvbGQgdmFsdWUsIHByb2QgPSBjb25zID0gMSBhbmQgcXVldWUgaXMgZW1wdHkgYWdhaW4u
DQo+IGZ1bGwgPSAoY29ucyA9PSAoKHByb2QgKyAxKSAlIDIpKSA9ICgxID09IDApID0gZmFsc2UN
Cj4gZW1wdHkgPSAocHJvZCA9PSBjb25zKSA9ICgxID09IDEpID0gdHJ1ZQ0KPj4+IFdyaXRpbmcg
YSBuZXcgdmFsdWUNCj4+Pg0KPj4+IHNsb3RbMV0gPSBuZXcgdmFsdWUsIHNsb3RbMF0gPSBvbGQg
dmFsdWUsIHByb2QgPSAwIGFuZCBjb25zID0gMSBhbmQgcXVldWUgaXMgZnVsbCBhZ2Fpbi4NCj4g
ZnVsbCA9IChjb25zID09ICgocHJvZCArIDEpICUgMikpID0gKDEgPT0gKDAgKyAxKSAlIDIpID0g
dHJ1ZQ0KPiBlbXB0eSA9IChwcm9kID09IGNvbnMpID0gKDAgPT0gMSkgPSBmYWxzZQ0KPg0KPiBh
bmQgeCAlIDJeTiBpcyB0aGUgc2FtZSBhcyB4JiAgKDJeTiAtIDEpIG9yIHgmICBpbmRleF9tYXNr
Lg0KSGkgQm9iLA0KDQpBZ3JlZWQuICBlaXRoZXIgeCAlIDJeTiBvciB4ICYgKDJeTiAtIDEpIGlz
IGZpbmUsIGJ1dCB3ZSB1c2UgdGhlIHdyb25nIHggDQolICgyXk4gLSAxKSBoZXJlLg0KDQo+Pj4g
VGhlIGV4cHJlc3Npb24gZnVsbCA9IChjb25zID09ICgocXAtPmN1cl9pbmRleCArIDEpICUgcS0+
aW5kZXhfbWFzaykpIGlzIGNvcnJlY3QuDQo+IEFjdHVhbGx5IHlvdSBhcmUgY29ycmVjdC4gSWYg
eW91IGxvb2sgYXQgcXVldWVfZnVsbCgpIGl0IHVzZXMNCj4gZnVsbCA9IChjb25zID09IChwcm9k
ICsgMSkmICBxLT5pbmRleF9tYXNrKSBhbmQgcXVldWVfZW1wdHkoKSB1c2VzDQo+IGVtcHR5ID0g
KHByb2QgPT0gY29ucykgKmJ1dCoNCj4gY2hlY2tfcXBfcXVldWVfZnVsbCgpIHVzZXMNCj4gZnVs
bCA9IChjb25zID09ICgocXAtPmN1cl9pbmRleCArIDEpICUgcS0+aW5kZXhfbWFzaykpIHdpdGgg
JSBpbnN0ZWFkIG9mJi4NCj4gSSB3YXMgc28gdXNlZCB0byBsb29raW5nIGF0IHRoZSBmaXJzdCB0
d28gSSBtaXNzZWQgdGhlIGVycm9yIGluIHRoZSBsYXN0IG9uZS4NCj4NCj4gJSBzaG91bGQgYmUm
ICBsaWtlIHRoZSBvdGhlcnMuDQpJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBhbmQg
c2VuZCB2MiBwYXRjaC4NCg0KVGhhbmtzIGxvdC4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5n
DQo+IEJvYg0KPg0KPg0K
