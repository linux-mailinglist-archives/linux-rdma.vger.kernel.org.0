Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F433625319
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 06:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiKKFgQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 00:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKFgO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 00:36:14 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E85CD03
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 21:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668144973; x=1699680973;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ktPFvmpxt5L4Mbl/oSgwfMBdWFxeMMc0pzkvDygYGIs=;
  b=IVDnGvv5zM/cmc7/y2BlhQV59g8el80L8NchbpEsppcbdJL8VPa4rPAD
   C6TLxNM5Cp/jUcLKikavxYk7o/4NVV4VsLLbsM0yLSwGNi6xWI0u7UxHa
   kV0Y3ClGjM7FHqeuoyr4ONRosxDv8oTyyrFY3Re1fAYfWjO4x5xMV3Rsk
   kyRtcNRwtgm7uTseBHeexRi/FS2nJaU75TFIx2GohlPC9rF9zHWiU2TRg
   JRjEq69JZT9GSG94qYZQeZnSeha4kYtosR8RIGyiEuPwzHqDism42v4d9
   /+eRghMOS+9AdrkH3pMvWuc5MUi8uGZHKWnVBvp0fT//1r3P8/ugyGdB1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="69665454"
X-IronPort-AV: E=Sophos;i="5.96,155,1665414000"; 
   d="scan'208";a="69665454"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 14:36:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVh38LGpjgQlrXG4BFiiYi72ovoEDMBzxK5A2kXVxXtNlf+D2DeLzg58hOodrdJW4Q6SXQO/zw1tz9gbA11h2akFXUYtewXIfY7ALDBn02KWkyOAg1MIiFZm8/DZz7vZTH/Coxj09balqGbvd7D+aen4XXcc0NedsBY7UhXMXdUdGqbcZECSPAJlEpg9tUzOWAjnKZ0iIdTD4iwyJARtfPcs0SbP9DhmusgTR3WipAUVw+Pqfm+6jtZ/LpyYEhS7xOeMFsPzAcBgzyW/9vmQ1e3BQiAwDW54eR+M2VANxR0XF/b6A54aOR61dgbyDAmOSkkEG90XHiHsmgebfnjUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktPFvmpxt5L4Mbl/oSgwfMBdWFxeMMc0pzkvDygYGIs=;
 b=NNG0IXYDc1LyVTc2Qiyfqh850EtyqUCcQeGje4fKUUvMYKSoxFpfUTETE+2EGNvmKcvHmyPflTdYJPbib0kMenTBWRKmdKK+twg2W4exeGQ9ZYm72Nd5S/4qEM19b1EOqb5NEPIP/GuHPkjHo2yj/0tYiI8gN25M9hpaH9k2SvJdMVJkXRRK5+s6VB3aqfDDw1efcEQnlhFwG7FEDxvnnKTtzNJnsjGFC6fKaqLn1aqaxRyyGGrYSJhtLTegy+gLH0gf9ANAx1G4aIfxfXUKflOEWdnCchrnKw/bL/kfx87qa7zcf8VlVqfQRfwP3M0W1SHP3T5OU0TBloFc771jSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS0PR01MB5458.jpnprd01.prod.outlook.com
 (2603:1096:604:a6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 05:36:05 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 05:36:05 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: rxe patches
Thread-Topic: rxe patches
Thread-Index: AQHY9TzV0OkNsNulQkW7Y+vkuQQ0s645NIEA
Date:   Fri, 11 Nov 2022 05:36:05 +0000
Message-ID: <37649cea-9085-fec6-71f4-f54b73ba7322@fujitsu.com>
References: <Y21Ujbxz+B56hMjY@nvidia.com>
In-Reply-To: <Y21Ujbxz+B56hMjY@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS0PR01MB5458:EE_
x-ms-office365-filtering-correlation-id: af97ab08-a973-4f5d-ea37-08dac3a6a0f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fq7HQ3+Lv5Wbh9Ma5sJtFRpqRcXykMZVn7n9rhQrD68hsiIxrAeGg1nikVD8pSDi5V2tsbdbXnS5r1GySF8MiJ6SAkPpaGaWbQzxB3RsxzFsNsBdjdDDOAe1AmEIbLt3YKRDgHrYiO3kmIsHP3R3mEWXiclQSTU/2kDsJHZ/DvOn/dr3mOPsG0AJx97viJ5UsJGl84XFzF64KMkngLA110WtN9vfPJgoTp5WW3ltdYLnx9MD2FcYZkUVr6D1AAOGz1+1lKM91a/XwvWz6lqKvVDXNukn/8q5+qJA+yiEHYZE6D3rfwnhY+1uzUb/VIWipdSbvMRlECFJPx0wO3LEBzPXtTiV8aZ+1oeoDcslOM0Wn/RGxBghTe4lt0q4dbaR0QEB8XUCsjWPvp6gF/koxfC3vltgS1E3UO10s+J+w3K+juZBARLqWFkBxJyCqQQgAJhC8p1Z0a69REtw0aA/x2VCe4smVgdadIYQ18JxPi4iBaGOPdiuT/m2g3MqxDyS1i8N3gudBKPUTQPPpA4gESmiPeCaeUD69cX3lfQD6+VPk6ULKWpEmQ1DDhCnesls7KggUfm7ohuQM0dKclfQtjEi0DmHpCiAO5KRscZrAmxDQReglhWmdeLjYJ/Dre4LVxcGaF6A5hjKN23eK6lq+dfU6F0WAtP1XA2YASZQIfzN+iB/LgmqfqeTPoRFj1zHcmw1FjtRkj1SLrV7tINmetseeLXIjCvFSJDTVk4SXCRX9xndSW/1DV6dHycqk3LQUrbBfXATcWHCtFXlJJ6EIg3zoltihK6ki9LTF8H884qELcdExmciNGVxweaZP1qgRmPFaa/wT3g/XFGnATYAw08RGlXHiGTCCqW93uMNkzte2n6+xhIdrL6/4zgwORvTFi2DU01CxtXb/WOnWjiKFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(1590799012)(3480700007)(2616005)(6512007)(186003)(110136005)(26005)(82960400001)(38070700005)(122000001)(31686004)(38100700002)(2906002)(8936002)(5660300002)(4744005)(6486002)(316002)(966005)(478600001)(6506007)(71200400001)(7116003)(53546011)(64756008)(66556008)(6636002)(66476007)(41300700001)(76116006)(66446008)(91956017)(8676002)(66946007)(1580799009)(85182001)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjVRbjNEYUhLUmtta2JlT3VQRDVadnpRWS9rVVlqSGxmemptdkN3ZUJ2Nmc2?=
 =?utf-8?B?MWVWMnl2VVVVL05wSjVVdHRvVG4zUW9DM0dSL2krVjhBYWZFQlNNdWdHa3Jk?=
 =?utf-8?B?a2IyRWpJSnVRaUJzSXJqcHZlWFJYSWJrVDhJZ2ttZnJBVHVNK0R5NkNHeEc1?=
 =?utf-8?B?QWFRVHJ4Ui9sRHR3RzJqMWNiMXk1RHQ4OU5nNE84dkdCU296WVcyekFPK294?=
 =?utf-8?B?eFpEYkZGd2toWE55VXRjaVNldlFhZTVkMVI1YkozNitxeUpFelJlZXlrY3VY?=
 =?utf-8?B?S3NLRktJUUF0ZTcvQ3JLRktJVTZVQjJtbWlhcnZTOXdDR1p4ZHZNRXpZVGw4?=
 =?utf-8?B?bFJWLzVpa2lnbTRKajNqbTRUc3Y5SXRwRUg3QTlHajFsTjFKMGVXc1g1bVpC?=
 =?utf-8?B?SU51cDFqZ2RWanBtVm5KZm9GSzI1cnBYSUdtSjluSVFRZTZQdmwxQnZDdUZo?=
 =?utf-8?B?NWNhUVBuU0owU0pHVENuQUV0TlBlUnN5U3Y1ZllIY0w5NEsxdXBjV2NLVjla?=
 =?utf-8?B?cHpoSFdLZ04yQ2w3S3VuMDVxRmdXZDAzVm1IM1VndllmZTAzSU1ISERlWVVv?=
 =?utf-8?B?azJCaTcxT3NoUjE0VEsrOW1BQVNyYWIxZE8velBOakJoQzZjRVBGQXNxZjRa?=
 =?utf-8?B?TzBCSVhKbUxlMDFPQklEL3BpQ1hZWDB2aGVqRnk5ZzVBQTFCL1dwNXU2d1li?=
 =?utf-8?B?dUgrSFVCZTNybUZ3b1JISnlxUTVnTkQ5NVk4eGorelczL01LQjdjS3ZUTVBW?=
 =?utf-8?B?bzgwU0hqT2JBUUduOS9WR25mSzByeXZKNStBR0VHN2lFRTk0U3dRMi9VVVhs?=
 =?utf-8?B?b1UrWVpnUXZVYk5JWkxuOWptVFpuRFlkMnRQR1RyTzhmZ2FVb09qTEdyejll?=
 =?utf-8?B?QURkUkMxMytSak9mYVFKT3pyR2FVRFhVMndoWkFnZ2kzZFo2amhCeDI2anZ2?=
 =?utf-8?B?bExvN3cxcmNUMmc1SzRHZTFtQXU3QWpERXBNYVVjcTZTL1ZDbnJlMUlvaGhD?=
 =?utf-8?B?dXREeVdseW1RSHBWaFBVZ0lycUtyY3doMEk4RHFvMjNXWEpBRExhd3Y1Q2dW?=
 =?utf-8?B?NFk1UXZ5dU9KeFZtU2I0ejA4dlRraFRTWE9tOVNNa0FSRTdwaE05OC8zb1Z3?=
 =?utf-8?B?a3VzN2IrbXNLRzhIRHk0aDJzTHhNL0dxbEpMTlFmRUdmUUhUOXVnbTRQcTg4?=
 =?utf-8?B?dkx0RW9acktsRXlzT0psaUlOOVRvZ1NKOTJpeUJVSTdhakhCQnYxSlZkT3N3?=
 =?utf-8?B?aGtPN1ZmV1IyRmVtdUJRQnVNLzA1Z3NIQzBTVGNTMDZKeTBaRTNYeFZWeTla?=
 =?utf-8?B?NDRUckxOdW1aNlAvVEVnRUNsaVZiajJrMnl4VkY5MEg5MFVIT2JybVM1Q3hk?=
 =?utf-8?B?OFpTZFFwUGFmMEI4QkpIRW8xdlZDU2dhaXJvOG50TmRSTFZXWFhUZlNtaFhy?=
 =?utf-8?B?RjNjM3phQ0Zzb0VsejZFdnI4RFBaVFJ0TEU1cDQ5dXNQRmJJeVdTQ0p3dUQ5?=
 =?utf-8?B?QjREMit2VFZEUHhFNkRBWWlRZDVzeEpZS3NVSyt1ZEZkTU8xK3lFaHcydFdE?=
 =?utf-8?B?RkZac1hMZW11aS9QOVB1VXFnalB1OFg0cDFGKzdEcUxhNG1kTjYzNS8yalNr?=
 =?utf-8?B?VCs5YkFkNG5Tb3FLYzl0ODgxZGlKMkZsZTRZWWZQUzhuMEMzNU85ditRTXhp?=
 =?utf-8?B?SnVBaUd1ME83MjdWZFp5VjlKNGJ6MXBEZlRlaU96QXZ4RE5yVWc4TFdWTXcx?=
 =?utf-8?B?bm9NNDBTS0hEU0QxNWpRemdnUjZqZTRJcXJ1ZkR0cEcrRFhxdm84blNFdytT?=
 =?utf-8?B?bUY3V2VpUks3WVM1Rzh3ZnFMSE4xTFI0eWlST29lbU1mbWE2MTR6R09aLzNR?=
 =?utf-8?B?amZEWjZWQUQrVmxScTZtZGYyRkIvNUVwYWVXRHQwZHJGMFljN2dmTVE0Q1VK?=
 =?utf-8?B?SWJTejVOL2IrMjY3Zjkvc0V2N3RmcmdDWEl0d1c5N0hTTzFnRWU0TndxTGVs?=
 =?utf-8?B?R09JZFJtZlJiSkh5ZXNhR1F6azRSeEZaOTY4R1RhZVRzdVREQ2RzUW9WNHFP?=
 =?utf-8?B?S292V092NC95TXJyTzA0WWVoRnlGd3BLNDJoNE85aUhiYzdISVhORW13MEZi?=
 =?utf-8?B?dVoydHZaM0tBRVZuK2lLcmhCNkU0QXFsR2F3U1l5dDN3OFBxblZXUUV1cDRF?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B8B0071ECFE7B40BA5406735E5A4803@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af97ab08-a973-4f5d-ea37-08dac3a6a0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 05:36:05.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMA9L2GSsyG2qmf/lVZWntQI7EZKJThml+uqRgvm086akigM+VSYv1dNURPoK9Vg9HP28BL5wOmYM5BM3/1CzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5458
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SmFzb24sDQoNCg0KT24gMTEvMTEvMjAyMiAwMzo0NCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0K
PiBJIGFtIGxvb2tpbmcgYXQgdGhlIHBhdGNod29ya3MgaGVyZToNCj4gDQo+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yZA0KPiANCj4gQW5kIGFsbCBJIHNlZSBp
cyBhIGh1Z2UgbnVtYmVyIG9mIHJ4ZSBwYXRjaGVzIHdpdGggbm8gUmV2aWV3ZWQtYnlzLg0KPiAN
Cj4gSSBuZWVkIGFsbCBvZiB5b3UgaW4gdGhlIHJ4ZSBjb21tdW5pdHkgdG8gc3RhcnQgbG9va2lu
ZyBhdCB0aGVzZS4gQXQgYQ0KPiBtaW5pbXVtIGdyb3VwIHRlc3QgdGhlc2UgdGhpbmdzLiBUaGUg
Y2hhbmdlcyBhcmUgdG9vIGJpZyB0byBleHBlY3QgbWUNCj4gdG8gZGVlcGx5IHVuZGVyc3RhbmQg
cnhlICh3aGljaCBJIGRvIG5vdCkgYW5kIHNvbWVob3cgYXBwcm92ZSB0aGVtLg0KPiANCj4gSWYg
dGhpcyBkb2VzIG5vdCBpbXByb3ZlIEkgd2lsbCBwcm9iYWJseSBwcm9wb3NlIEJvYiBhcyB0aGUg
bWFpbnRhaW5lcg0KPiBvZiBSWEUgYW5kIGp1c3QgdGFrZSBldmVyeXRoaW5nIGhlIHNlbmRzLCB1
bnJldmlld2VkIGJ5IG1lLg0KDQoNCkluIHRoZSBwYXN0IGZldyBtb250aHMsIEkgbWFpbmx5IHJl
dmlld2VkIHRoZSBidWcgZml4ZXMgb24gUlhFLiBidXQgbm8gDQp0b28gbXVjaCBmb2N1cyBvbiBu
ZXcgZmVhdHVyZXMgc2luY2UgaSdtIHRvbyBsYXp5IHRvIGFwcGx5IGFuZCB0ZXN0IHRoZSANCm5l
dyBmZWF0dXJlcyA6KS4NCg0KU28gaWYgcG9zc2libGUsIEknZCBsaWtlIHRvIGJlIGEgKlJldmll
d2VyKiBvbiBSWEUuIEluIHRoZSBmdXR1cmUsIGkgDQp3aWxsIGFsc28gaGVscCBvbiByZXZpZXdp
bmcgcGF0Y2hlcyB0byBSWEUgaW4gbXkgZnJlZSB0aW1lLg0KDQpUaGFua3MNClpoaWppYW4NCg0K
DQoNCj4gDQo+IFRoYW5rcywNCj4gSmFzb24=
