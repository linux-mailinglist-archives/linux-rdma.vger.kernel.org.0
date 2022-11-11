Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE76255D5
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 09:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiKKI4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 03:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiKKI4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 03:56:23 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Nov 2022 00:56:18 PST
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220ADFD4
        for <linux-rdma@vger.kernel.org>; Fri, 11 Nov 2022 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668156979; x=1699692979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wDWSUeSEY/Xj1I6lOcCRTb43EvF3G/TR0MiMaros5vA=;
  b=ifh5B1yViZmEQsRCvAtJRvUhrs/YigqKJW8qIrS7RmowZrxG48b68cpZ
   WI1JpW9KeDlCOFIRdAaQmn/6Q6wSB48ES/6wAqtZM4k6mAOba+j6ZrnoO
   mfL0cXmoQUeH9g5rbpmLcMCqXJ5Ul9lbpcDnCdqez1w1nH5U7kPFT/l1v
   YQLRkz8gpY3CFFtAJRYHbNnmMOlfhkMgMtXxRD0+DWzLjVacnDqqaTGvA
   qwwfdBP1PzeCTakdNiZFKBuvY6QWNdZqVAK9foZ21uVkTBCeA6ySdqI1o
   PNl7AWudAxpeR41UAgXJpFQZb6kUb440Tu1TEGwruLEEzTfx8ohmkgmzd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="69788686"
X-IronPort-AV: E=Sophos;i="5.96,156,1665414000"; 
   d="scan'208";a="69788686"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 17:55:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+SmGtCbpPSXd/tqg64CgHXgFd9pFcC/Rv6qyXzdCdqCK25HUK2fFELBupHODhBFXP9nZA5BctrQK8N+9dJt5DEz0jnTKjDrBJlpTCWUXbrB22+caoSyHi9T7eMf/igu/QkZake9dXUJlTns4PFs8g5g1cLmKlY/v3EFLHNAFfzD7SdWE5rQQs9dSpFowBs4+fRFS3CN6OpV+5fVS7VlhDI8NcYcBWkRXj9hyGgF6inaClXd7hBHjZ1sg8JacJ0RZ+oDMzFUiJS3dwQBxyCv3T1OozF1fNnqNhW7nwXiHq3qw8W3BjPDqQ0GWZ1t/1he1lyAE5yDJRzHXhkeM+0yBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDWSUeSEY/Xj1I6lOcCRTb43EvF3G/TR0MiMaros5vA=;
 b=HpO3z09gq2/3qOlVgEbhtro1cJJJNRBIfrhofelL4aPzK7mjIL+KDs2XPLk24GhSDYO99ZbVs1kaSKblp9ZB5fcnlJGoziFZSp4CEwQ3Ui93dAQjZ+Qm3T/pwWXns5R/JP/hvBu4ls9lS8lTIbocBboBJCzZHH+/rsX+grbRmEB2Oshu9pMeRD9ppGMVtAnYo59zsHIsks0KuuCAzxvxV4xnwr4xRvsvPPi5Lm/WidsEI0tJvH09YWjk2F7244HDPSD+J6tP2wZlUcLVkgTjtPDbtm13WwGQAIuuknTjd1dEb9umJw8fBdRKnyrGlNTDkzI7AuU0yujx7mD/VyTEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OSZPR01MB8106.jpnprd01.prod.outlook.com
 (2603:1096:604:167::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 08:55:06 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 08:55:05 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v5 06/11] RDMA/rxe: Extend rxe packet format to
 support flush
Thread-Topic: [for-next PATCH v5 06/11] RDMA/rxe: Extend rxe packet format to
 support flush
Thread-Index: AQHY0jWNx2x0WyLVF0OHgL29dn4bmq45rvUAgAADMQA=
Date:   Fri, 11 Nov 2022 08:55:05 +0000
Message-ID: <cc46e58f-acac-34cf-a343-8feb5b755502@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <20220927055337.22630-7-lizhijian@fujitsu.com>
 <ce4c5925-d321-6b33-7bd7-e05b7145acde@linux.dev>
In-Reply-To: <ce4c5925-d321-6b33-7bd7-e05b7145acde@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OSZPR01MB8106:EE_
x-ms-office365-filtering-correlation-id: 6262f1a2-51ad-4524-c0d1-08dac3c26da5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBQ9HHb0C8RjBACCST7HzBo+OW+81KsrGglnAwRXmX2q6ciTtsX4mtXK1hAiW4FN8cQxvkW3fTJzaJmUyWk0Y3tZvyQShUg7c5SK0eMiYodFW2zcnYsEkai221btsESmtQV303tPD3Tm6zlPazSKsYpWS+k3En6mk6uoh08/9Mxs2CNFFiBDqXoHbFuuXWOsfFuYSXCMb+YU3PwdkWr7btZLHCTPwtaw0q/DmakgxGFgR3wKw1qqgs/adeozgOtUSqw2yDpagpjKTQdp31YFO+5eeDNo46VL++zL9rMniIAXv1kxGQHUnxkCmSfAebsN2mK63fdNFAP+JTcKKYe7QbcwJiiT7msT+6OOvixeSUHpOgKLU17dsMRxdW+G/z3TVfsY21Lildouh0mjnb/YzwLk22BNy2o87vUVKGQCoFLDYKP/+wS22RHy6aJEri+V1v5RYMnYGMorGMfX8BZIxdllb0sKXnXrNp2Z9jxpxwFZwUgMn3nAoeTBsLWa9MhEI8/tAuL4DQKEnuhT/19uXPE8Kur9H7oijnI4qXvGfU+T3yyGMvxt4VpM1rWgyYZjS0CsW+IUU56pTXiSRTmw4HFOyRMbtprDu7NBA0IFWuV9yCv6ZiO0FfnGJkwpk4juFsam0HrbKUHYLfdJ/MHlgH3+B3zZG5GNnk5lJeA0o8MfB7TrEc02i4z85H00Q+80bWKrMeBGg2lQMDNmKJ9Emqf+OWwRUV/rwp1+gqvxaBWW0EOq2JTbjr2FKvWvhhKuCDxCfM1NaRVhJpWY184GK4vf78XJrtzl7zvcCPgagHmySTOvohfHPd6F86SZG4yJ2Y9i1hXuSOMnYEQyfD5KhfVFMJkcB3BSJrBX2eTOHyCSBo8pS36KHqHV3mL4wWZ81/ppOoMf3UThKranHE8FtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(1590799012)(451199015)(8936002)(1580799009)(31696002)(86362001)(66946007)(110136005)(54906003)(7416002)(5660300002)(41300700001)(71200400001)(38070700005)(2616005)(38100700002)(478600001)(76116006)(6486002)(2906002)(966005)(82960400001)(6512007)(36756003)(6506007)(53546011)(64756008)(26005)(31686004)(91956017)(8676002)(66476007)(66556008)(4326008)(66446008)(316002)(85182001)(186003)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzZDWVhjVTA2T01TWDBxQ1o1bUdPaDMxNVpTbXRlSkZHNXZzRDBYS21INUVU?=
 =?utf-8?B?V3dCK2tmekNYT0IrMy9EYTlycjVGQUFTU25ob3RVSzhNZnBJYTZLZk9rOVZU?=
 =?utf-8?B?K1BUNTNsZ1lpdVN5U2hYMldoK1Rib1Z4cmxrRFhDbW1SYUEzQWh0dk1CbHFn?=
 =?utf-8?B?RHZmUWtRWjNScUs5Wnl4SkVRUEowdDlBOHZoZ0VhZWFvOW00SFhTK1dsZWQ5?=
 =?utf-8?B?RENtc1U1TFQvYkt2cDJPR2o1bktiZlhPSFJmK3B5Q1RqZWV4SW51N0xvZzZz?=
 =?utf-8?B?bmNiTHpGNHRzbzdzd2YrcVFmdVozbTBWVUdqbDh1LzRDS1Y1Q2JqbXVyRWt3?=
 =?utf-8?B?ZE9uQ1NmOTIvRWM1a0tSM0Q3Y003bWg0ckszcklZOGhUei9yY1ZWNzVacDhz?=
 =?utf-8?B?cWNxaFZlUDR6STI0NURvYi9KZ090SjFsMElkenRsUGxhaE9NM0Z4bjI3SEQx?=
 =?utf-8?B?TVEveVlqZEFPM2RrdXpJb3BVNm40bWtvVUF2TjFPRmZpQkYwdnZNOEZZQm51?=
 =?utf-8?B?cVhMMWpCeDhNN2EyNGMzQWdrOFNBbTdCOFdCQlQzRVZPRExWMFZid0NqQ2M0?=
 =?utf-8?B?WjdKdnBEMDBJNCtWRUE4ZlZiRWQxRVVGUHhGT29qVHpIdlVaaXRyby83cU43?=
 =?utf-8?B?R1VPUm9VUDJBUkttcVl5QU5tWjNnZGxFdEhsVFo3emxHTUhJMEp6dHg0ZVho?=
 =?utf-8?B?OExWUmM2cWgxYmJKSHNVWkd0MWRFU1ZWWWhiRWRtM2pXaXc3czFrSjZJR0Z3?=
 =?utf-8?B?ZlBBb1ZGazhmdmgxOFE5bjUzYmhIOW5XUzNsYndjaVUwUk1EV0VuZGVwQnNj?=
 =?utf-8?B?TTRDbzJUeGtiWForbXZOelAvUU9WYS93ckNrUCtTbGVYWEFnei9aemdsTi9E?=
 =?utf-8?B?VExvd1RwZkovaEpOQk9ZNWp1VzBIYVpJVmRoSENycllhSzhpRXJNczhLUFdn?=
 =?utf-8?B?azdoU0Z4c0o2OHBBWVU5cGRJbVRQU2dBQmFXK3ArZ3piWUtGNVI4WXBlZ2M1?=
 =?utf-8?B?cWk5ZmFVcXhFM2J6NjJFemRKendESXZWVVd4QTV3R1h3ZXA2QzhNM2lveTRh?=
 =?utf-8?B?R1MrSGQwQk5NOVRQbmFzZUVXK3hxYnNEYXphWHp2SStvRTdGTHpEdkQ2NXdF?=
 =?utf-8?B?WkswNmV0WmNqemJMRUVpemZ1UHAzS0Zxb2pySXI4c0NZdGdJek9CeGNaQkpV?=
 =?utf-8?B?TFNJOUhmaFBTbENtSUxwOWtsa0lPRWtCNmEzWVNicEkxcU5KelRYQWk4Si8v?=
 =?utf-8?B?UU90V0FIOFYvWFFVWmJmcHY5WHBTa2NTb1VjK0I0QnA5THRMdkR5T2Z1cmZH?=
 =?utf-8?B?d05wVTlCQlNGSzdFNUJYT051OHJYS3pmZjZrdDR0cEdoWkhXRGJLTUpzMGpM?=
 =?utf-8?B?VFF1a284b3p4WjhJNWVrQ0E1NlUxOXFLRlRRWVRYOFdYL0liUjYwOWhIOGlG?=
 =?utf-8?B?U3BwelcyK2d1c3V3cm1xajZKYjFsSHBxYTZ4Q1FZVUUxWTdqNWY3RldVQUFp?=
 =?utf-8?B?bFArMSt2Zmw1VG40ckFGbnYweVV5ZUxKNnJjRHRQQ1c3VktKbWQ2K1U2MFpH?=
 =?utf-8?B?ZlVxMWtYeFVodld0TmdRVzVZWFlDVWkxbC9PNUhMYmw2a0NqbG5hVG9sbmtK?=
 =?utf-8?B?SldmeVFSWmV2Zm1ORDNHcm1WSmQxQ0dtbElIcDU3dlJxVCtoUi95ZHJncHQ5?=
 =?utf-8?B?Q3pMcVhoaHYrTlQzczk2QkY3dW9JNmcwejVVbkxMZXhNVjR0QnFMRVVHc3VH?=
 =?utf-8?B?cEJBZHVUbUdnOE1iZ1c0UzVLYnd6Qk1xcnhkR3greGI4VUhmcFgxUTcwUVdx?=
 =?utf-8?B?ZnZHNitDdlBGT0VpYWxLdzdldjRxYzVBMmhJZlhWSVdzRCtsbXk3S3NDMGdN?=
 =?utf-8?B?Y1JmRkpoWnBWTEk5TGgyTUU4Q2Fac0J0OFNHYW1oUEVHdEJteDNGTmg1VmJP?=
 =?utf-8?B?MURXK1A3MXViZi9sWUZHUFFIUEtvcDB4YlNPcVFmNzVoam9pd0xwNW1sM2NN?=
 =?utf-8?B?aktodjgvRVQvY2dLcFQ3V2I1NVdVOEppZWhnZDB0WU81TUtPZHkzRFFDVmwv?=
 =?utf-8?B?Z1RTejl3YkoxMEVRNWYrdU9XaUc1VzhrcHVjZWhJYlVFT0x4QksrWllzcWxJ?=
 =?utf-8?B?OWd4TjBmeHA2dkFjR2lKME5FTzhMd2RDMDVQNUpTVkJMRkkySTlpSmRmcnRv?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <561D94212423384C994D26D62D9D0DE0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6262f1a2-51ad-4524-c0d1-08dac3c26da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 08:55:05.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PB8MH2FncIiPBktr1rIYwo+kQsirqv1fouCpkbGMFvFfCHIXhBgq1SCUOh5HFWLw+FlZCoNrMcg2qMib2gOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8106
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzExLzIwMjIgMTY6NDMsIFlhbmp1biBaaHUgd3JvdGU6DQo+PiAvKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqDQo+PiDCoMKgICogQXRvbWljIEV4dGVuZGVkIFRyYW5zcG9ydCBIZWFkZXIN
Cj4+ICAgIA0KPj4gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KPj4gQEAgLTkxMCw2ICs5NTYsNyBA
QCBlbnVtIHJ4ZV9oZHJfbGVuZ3RoIHsNCj4+IMKgwqDCoMKgwqAgUlhFX0FUTUVUSF9CWVRFU8Kg
wqDCoCA9IHNpemVvZihzdHJ1Y3QgcnhlX2F0bWV0aCksDQo+PiDCoMKgwqDCoMKgIFJYRV9JRVRI
X0JZVEVTwqDCoMKgwqDCoMKgwqAgPSBzaXplb2Yoc3RydWN0IHJ4ZV9pZXRoKSwNCj4+IMKgwqDC
oMKgwqAgUlhFX1JERVRIX0JZVEVTwqDCoMKgwqDCoMKgwqAgPSBzaXplb2Yoc3RydWN0IHJ4ZV9y
ZGV0aCksDQo+PiArwqDCoMKgIFJYRV9GRVRIX0JZVEVTwqDCoMKgwqDCoMKgwqAgPSBzaXplb2Yo
c3RydWN0IHJ4ZV9mZXRoKSwNCj4+IMKgIH07DQo+PiDCoCBzdGF0aWMgaW5saW5lIHNpemVfdCBo
ZWFkZXJfc2l6ZShzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QpDQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bjb2RlLmMgDQo+PiBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX29wY29kZS5jDQo+PiBpbmRleCBkNGJhNGQ1MDZmMTcuLjU1YWFkMTNl
NTdiYiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29wY29k
ZS5jDQo+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUuYw0KPj4g
QEAgLTEwMSw2ICsxMDEsMTIgQEAgc3RydWN0IHJ4ZV93cl9vcGNvZGVfaW5mbyByeGVfd3Jfb3Bj
b2RlX2luZm9bXSA9IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtJQl9RUFRfVUNd
wqDCoMKgID0gV1JfTE9DQUxfT1BfTUFTSywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9LA0KPj4g
wqDCoMKgwqDCoCB9LA0KPj4gK8KgwqDCoCBbSUJfV1JfRkxVU0hdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgLm5hbWXCoMKgID0g
IklCX1dSX0ZMVVNIIiwNCj4+ICvCoMKgwqDCoMKgwqDCoCAubWFza8KgwqAgPSB7DQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBbSUJfUVBUX1JDXcKgwqDCoCA9IFdSX0ZMVVNIX01BU0ssDQo+
PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+ICvCoMKgwqAgfSwNCj4+IMKgIH07DQo+IA0KPiBIaSwg
Wmhpamlhbg0KPiANCj4gSSBhbSBtYWtpbmcgdGVzdHMgd2l0aCBpdC4gRXhjZXB0IHJjLCBvdGhl
ciBtb2RlcyBhcmUgc3VwcG9ydGVkPyBzdWNoIGFzIA0KPiByZCwgeHJjPw0KPiANCg0KT25seSBS
QyBpcyBpbXBsZW1lbnRlZCBmb3IgRkxVU0gsIGN1cnJlbnQgUlhFIG9ubHkgc3VwcG9ydHMgUkMg
c2VydmljZVsxXS4NCkJUVywgWFJDIGlzIG9uIHRoZSB3YXkgaW4gQm9iJ3MgcGF0Y2ggSUlSQy4N
Cg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9jY2UwZjA3ZC0yNWZjLTU4ODAtNjllNy0wMDFk
OTUxNzUwYjdAZ21haWwuY29tDQoNCg0KDQo+IFpodSBZYW5qdW4=
