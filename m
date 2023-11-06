Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE27E1953
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 05:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjKFEHb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Nov 2023 23:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFEHa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Nov 2023 23:07:30 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BFBBF;
        Sun,  5 Nov 2023 20:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699243648; x=1730779648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fTwZABQB6hg5qMWjYDUzW2AJfLLVRD4UlWUoOF7Yb1I=;
  b=tFaFE9pDQF85qCsgXI0NTpqxYE8s0+YukzJEYP78D6CbhRucpkugGqvc
   D4TcKZHHb3i0yNQYsRdhjCXtjOJCOb3v8DpV3QKZILN22t3mbCN+H5cnI
   JdxND+tOG/lapFFUXQQ9vtNwBmajkaxZxNmhFN8CNMoCgE8hKxH/Xnryj
   aBid0TbKb/gYvAeDc650gvXkSUs6wVML9FsP7nVhd3q7Qpj27XM0ITpwU
   SkwhBfBg3Ol0A/d+HbE3Bzz6pkgKa1HZ4T6XeS53fkXMx3YML2BC0heuS
   ksa0EjjUvk0nvynWbPSZ5n/+M6D3jq0eG/Y2IJStQBwoprlrzsQBQ/F5Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="101138931"
X-IronPort-AV: E=Sophos;i="6.03,280,1694703600"; 
   d="scan'208";a="101138931"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 13:07:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlSxL85ahVkGohWCf7jk+s/2ZbL9q+VfONjscZxHPE9Rxvoa5TBYMMrNjTi2eVcxaI3j8DKDMQY9jdsvIGiX8JDl+VAoePDgav2BvV0mZcwu3sPFpBfvDP/3670z6jbP8+agFW6DGgVm2zrIxynibSWeIfpyoS0IaZ1AhJNJqgJqAQoSUrugwuAvKcifN+rwbgW2zxJZp3lh+JRgd41fmWhe4j3DUBW70da79ZC+cTH+53m3Qoo3GOpfYh6YOVCcRNknqsxx2SBats4Z8j9txPDlb50x7zJsb5VXtBjERTmns6YyOqFWxtq3yVWEjNiNbi1LBoBW/ea6AmoGNG8CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTwZABQB6hg5qMWjYDUzW2AJfLLVRD4UlWUoOF7Yb1I=;
 b=PWap++G6bhPP+ilEMe3zUW2X6LKql3Rh13DC63isGbA2UsE4WHVWhSlgRhzwPX9MULI1Sx/h1wBvRHSN0w4qD8ut3mTH58cYYUTjdzOtuArPnyNm1GiES3rnZWlBLprIneAjBnrIv8gcqqUThQghiXTtmIbyaqyMOXJhDAVEe9lG0BbhR/GaO5dZzeGa5CDB9NtAxLk1TRjiYgK5+7OVoSLZVI7km/zqwsVfxkRdODsAYwCB+dSoGoUSfcb7T9Lhsbez33xQxwLD83IqQK/TZwc/L93ze09TOVgla3PubY2NTjqO+nTIV8gxfqmjAC4PQuYSntG633AStkZYZHr7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYWPR01MB10885.jpnprd01.prod.outlook.com (2603:1096:400:2a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 04:07:19 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 04:07:19 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Topic: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Index: AQHaDjvxgnGsUlf/nk+PthrgEoRwxrBojwMAgAQh+4A=
Date:   Mon, 6 Nov 2023 04:07:19 +0000
Message-ID: <a256a01d-1572-427a-80df-46f2079af967@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
In-Reply-To: <d838620b-51df-4216-864e-1c793dae7721@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYWPR01MB10885:EE_
x-ms-office365-filtering-correlation-id: e7d19140-f963-4d15-76de-08dbde7ddea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dge7DZZ1bTSk7mHttfzLut9HS62XDuFLkEa0ez2EICpbywOh5rjTwBaakyWRjE0NJBWFrVFNtRqRS1K2pssfYEz6KtQPhDmQub/7d3jRDrvPXO8b5fUXZiIrlmZfqmAjjuM8Q+cF3iK8DwwOUhfYAQfoWr87F0i66saQtvP2MdtLhGBHY+vTy2DfCM9z1IE4QNewIDAne08obqct+SJXE5Z6LUT3MwqwlSwA7U+w5oE4AxUK1R5Eeso/KSNQkk5bu8ScQhdpUfJirqLypBaos559Y70I9Y0IGgrMiDeUiOnHJqJBj2OpIIDRC2O+l884qdbe99ydPdCi7kYg7mUARhUyuCulAVW29HIan8nZgis+nbffbk06+wMvv/rc8BbPa0U9GRjC6NviUKLq8GNWScX0WWVJ1q3kfJEgT2rEZLMdSD05SgcSG+vqRtVNMXzuS3C1qqVVo44ejHsjytF/e6U4BrhLY3HKZZmS/h8iqj+rWA5SNtQkd22DFJSaV+c0c3N6eSitbkVci1HspmaXt69G+4gt88QqRL1X8kyxeXvVGZg+NPSyz5CJMONDseC+P3a8SCE0b/8j47QStQdCKRIVT6jklst80KCaE1M1doRvRbUz3z7j/p7cebQ7afCEVQgP773b2hKKwqLW5A8s19W+kIIh0CVXdgKcGChIG6iZJP9SaQG4qpC2LtHOs/BIYWTCBCeOz6wnptAeP1KW1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(1590799021)(186009)(451199024)(1800799009)(64100799003)(31686004)(1580799018)(83380400001)(8676002)(85182001)(36756003)(8936002)(31696002)(86362001)(4326008)(38070700009)(41300700001)(2906002)(5660300002)(478600001)(6506007)(71200400001)(966005)(53546011)(2616005)(6486002)(110136005)(91956017)(38100700002)(316002)(122000001)(82960400001)(66476007)(66446008)(66556008)(54906003)(64756008)(26005)(66946007)(76116006)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDhsMGVDT3pDcGJ1cmxxL3M2NjlrQ04yRzZBSk9nZkZoWFpUNGJoTFNOeThI?=
 =?utf-8?B?SkZuN3prQTRYc2JlUzJDTytzbyt3N2VtZ3hlSFJBdk9kV3FhQTNScW11eExo?=
 =?utf-8?B?YjNROGpOUzVYc1lHSUlBVmVzMjRDbmROYmVESDE5ZitQU3ZQalZVQXNGbHpl?=
 =?utf-8?B?K1kzZWc0dlZjOHBLQUNqREp0a0daTStIbGxlb1lIdWhUdTdIRE52U1h5dmlP?=
 =?utf-8?B?TGpwZ05sMU1VbjlUd3B5cUp1QnVpME93Mm5GWVBCQ09LSm9FYlVoNkFiazBh?=
 =?utf-8?B?MHRDVENjcy8rK0I0ZUV6cHZVUzlscXRaTVdJUXI5cXRQdTN0L0hLNHdnSEpq?=
 =?utf-8?B?ZE43YktOTEN4SmtqdFd4TzJOd1BRSmF2WEhVMlpMcEw2TFdqaXE0eEpLM0dk?=
 =?utf-8?B?Q2k0aHdGNGlyNHVIRXBabkhsbjBlWVpraGRKT3FLS09ldXdYMU1heG5DNmFQ?=
 =?utf-8?B?R1JGZGxWWFZ2eXJWdnFpaVRXcWZ6Y0lXZktFaTlBQ3JRTCtIY216aEhXZ29D?=
 =?utf-8?B?SUVoZ1VyY0d3THN4TDNvV0Z5bjJ5VEJpR01peXBFZFZMTDREcDBpYUxDWWMz?=
 =?utf-8?B?TEFubUY1Wk5SdkRnMkJnV0hVcGxOaTZucm9WL1NKc0ZobzlPbW5hK0ZUMTR2?=
 =?utf-8?B?UGMyY3l0ZnZrWUtxbWRHcVdYYXBzMGQ1b2h6WDhoc1ZUeEpYR3lVSTMyOWUz?=
 =?utf-8?B?QW00NzJuaTVGZEovYnFjdU5abGtEczdEQWt5blJ4STJnU2IyZnF1UDRUNmRG?=
 =?utf-8?B?S08wSms0WEpWOFhCNXNaUEVsK2syV3VWcVNxMmVDODRSYVVDMkV5N3lNRnov?=
 =?utf-8?B?RCtSTDJSS2o2OFd2U2N6MDZxcmNpcHdLMHpxZTJmR05hdDB3ZnJpa3FVbFdM?=
 =?utf-8?B?U3djOE9zRUxLZ3hIam8vMjd3SElHQzcxeXFnZG43VDd1QmN2VTRTb0pvRDZM?=
 =?utf-8?B?dUwzMUtzMGNxdzNkbVk2dGN5L0dKL3RnNTBSVFVkUVdRdWJHakU3bWlibnZo?=
 =?utf-8?B?YjlKbDRaZ3Vhbmo3MVVIQVVaU0RBWHJ6dGZDd2hqY0NENWFId09UMUY2TnF2?=
 =?utf-8?B?b1hoUk9lV3MrZDR2SENqUVE5Z0kwN2orRGRXSWE5bllveGxRSzgxT0M3Yzl5?=
 =?utf-8?B?d3Q1UGpncUxLY2R2ZW8reGZleXd3VlZ1c1RrVUlpd243Z2llM0dFODZZQUg5?=
 =?utf-8?B?aGNYSzdDeE11VTNmVkVMNUcwdTRabEtuWXJjY20rTFVaRFdlS0k5OG9UeFpP?=
 =?utf-8?B?RWp2RWh2VFFXL0lqZ1hhQW5vR2dkVXpSZmQwVUdjaHc2RUZTTUR4Q2JPM0Nr?=
 =?utf-8?B?ZE85OE1yMWkyM2JBaExvYkRBdDJKOWxKRXVlNjR2UTNubGg2R29jOEx1czJa?=
 =?utf-8?B?c3V2djNlbmF2REpkWHQwSnNheGpKT3NxYmVuTk1xeFZ3UkRIRzVOSTF5TEVQ?=
 =?utf-8?B?VE5TbWM5M2h0SzNoUmtWbmVvNkJrd0drRitjWFpMYVE1ZTdCYjVpRTBVZGN1?=
 =?utf-8?B?SFhTSWkwOHN2V2liVmI4cGhITnJNUUk3WmdNdGhQTkxudSsveXZ6emxrN1Y4?=
 =?utf-8?B?Z2RzYkszU2pYTXIzYWNTN3lLU05KM2I4QTNWRGNzWVNmWDNOTzhHM1lXYmw3?=
 =?utf-8?B?NTRkM3NkamRnWFEwNGtvYzhFOFE0WkFtZVhjMlp6di84ZFVIUzNwaEs5RXlY?=
 =?utf-8?B?NFZwajg1UUxrRmFPSTVEY21hM3N0SnA3bmhhR2hYTFlmS3pqdE5aRlE1VXN1?=
 =?utf-8?B?Sm9sT0lENGlOZXpFUGFsVCtXVWtSTENWVlhERUlnM3VEamlseFV4TzZ1Wndq?=
 =?utf-8?B?VFM2cElQRWcxcDJ1WUZ6L1RTUUcyTVpVSC81TkUwcjYwSkRKWForZmtnOFR4?=
 =?utf-8?B?RGZKTjcwMzVDWURyTFp1eEhsTTRmZ3JyQTlxZjdyeU01RnJxQWhDTHMvemI4?=
 =?utf-8?B?OXA5WTQzb05RWUpia0RMeW5Ga1BuMmM2OVltNHdpK3AxNW1kVWc0WXlwekRR?=
 =?utf-8?B?MndnZk9hQVFXajBvYS85SmN0QjN5RmFvOVplRU5lL2ZrbGZjQ3U5dHpuM0xq?=
 =?utf-8?B?Qy9XbzRsczdod0MwOEtEeWhvMDdtbTUyWjVpVmsxOXBtNllxaXdUTEl3QlJj?=
 =?utf-8?B?bC9hUS9jcFFValB3Q3RCQVFudU43K0o0YzJqcW00QWR6R2FoNHhRNzB1MDN3?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD55036E707C9747A23CF7B7B7E2FD4C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gvJocvTNdKQCTloklxHHPHx5a9e0odKHbYSei/QBeDcDpECzup3yK/C/17lTwo2EN/yccsmbEBLhITmyGEzbYqGCuq4jiCmYGNqrYcSnhE/iX7c4t+62ONsad+KlcJPYjgYk6W5vNvgFF8G0oiINymisXRt7wiAzzoJetVQDiUG0Ud9KXSfhHeO9emG19BvpJpCNo2YgTYaDSxD2n0SYL9cC2+Phg9MFBRU6MdxpntTb/akGLl0pNl4J4lnK4xy/AKioRWmjfOOYHxSD6unqbyakoZjHLKQUhrrRhKDoa+4iV6Q5kuOwEn7GhkH63nHAEvQcNLgtEuNPhw5C52oDgsmYPtIJDcCVwxAN+ODOiY+iG+4Q/A27/2vlbXtapGZSf7ReyZ9HuwFAnfoRuZmOnO6M/3IlbwXwh20X9fGX9OO1JPFD+bo/DXYZAj/3Pi8cP8/8kJhT2eNdQ4utFHeyvTFPa0uIcYqGqU52uGoTzo7PI9R1dIIo1OolzM3rppnlU1M04ZHhj04JQcccIV6MY9RTT2EiqEe38/QJtSX3X5mIwQhSuZF+NWq9YGQ3lH/rC5dChYHEo/5ANYjc25OILU9KXVjd7So70SifeP+q4Inigfs/A1rRsDCM6vgCgYYCjPkzxPjBFNIngLmTQKRSlefp0RTkTQAj55JzaUZBk7+ajP9ycM/fp/FpcuMcMlu3/Eq0+xQOf9L0NhAm+5r3LvR6aqw2oS7Nn11t5LmZyGyk+jv4CYAuMHEhbRXHew7HnWymW+RsxT80dGHxdRmHQPEn90KyVz0O6h3elxwNOweUhA/YtsxQlLBeuibg072TgMho3tH/IQ1euTrexII89B1eTp8afmfZJ3E0F/JEEKU59U6DzccevmsqP0f79AQgc+bg79Znbehh3H1TlwoC1908ZCpApCYAto8/QxL2q90=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d19140-f963-4d15-76de-08dbde7ddea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 04:07:19.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EllhMFxWpdoS+FcOXZi+w8AYzxFHVc4qZwSgTvH+0iFo0qtxt98dAaNfHD5Ty6aDh7hiyg6aj+POODIRG3R3IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAzLzExLzIwMjMgMjE6MDAsIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWcqCAyMDIzLzEx
LzMgMTc6NTUsIExpIFpoaWppYW4g5YaZ6YGTOg0KPj4gSSBkb24ndCBjb2xsZWN0IHRoZSBSZXZp
ZXdlZC1ieSB0byB0aGUgcGF0Y2gxLTIgdGhpcyB0aW1lLCBzaW5jZSBpDQo+PiB0aGluayB3ZSBj
YW4gbWFrZSBpdCBiZXR0ZXIuDQo+Pg0KPj4gUGF0Y2gxLTI6IEZpeCBrZXJuZWwgcGFuaWNbMV0g
YW5kIGJlbmlmaXQgdG8gbWFrZSBzcnAgd29yayBhZ2Fpbi4NCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEFsbW9zdCBub3RoaW5nIGNoYW5nZSBmcm9tIFYxLg0KPj4gUGF0Y2gzLTU6IGNsZWFudXBz
ICMgbmV3bHkgYWRkDQo+PiBQYXRjaDY6IG1ha2UgUlhFIHN1cHBvcnQgUEFHRV9TSVpFIGFsaWdu
ZWQgbXIgIyBuZXdseSBhZGQsIGJ1dCBub3QgZnVsbHkgdGVzdGVkDQo+Pg0KPj4gTXkgYmFkIGFy
bTY0IG1lY2hpbmUgb2ZmdGVuIGhhbmdzIHdoZW4gZG9pbmcgYmxrdGVzdHMgZXZlbiB0aG91Z2gg
aSB1c2UgdGhlDQo+PiBkZWZhdWx0IHNpdyBkcml2ZXIuDQo+Pg0KPj4gLSBudm1lIGFuZCBVTFBz
KHJ0cnMsIGlzZXIpIGFsd2F5cyByZWdpc3RlcnMgNEsgbXIgc3RpbGwgZG9uJ3Qgc3VwcG9ydGVk
IHlldC4NCj4gDQo+IFpoaWppYW4NCj4gDQo+IFBsZWFzZSByZWFkIGNhcmVmdWxseSB0aGUgd2hv
bGUgZGlzY3Vzc2lvbiBhYm91dCB0aGlzIHByb2JsZW0uIFlvdSB3aWxsIGZpbmQgYSBsb3Qgb2Yg
dmFsdWFibGUgc3VnZ2VzdGlvbnMsIGVzcGVjaWFsbHkgc3VnZ2VzdGlvbnMgZnJvbSBKYXNvbi4N
Cg0KT2theSwgaSB3aWxsIHJlYWQgaXQgYWdhaW4uIElmIHlvdSBjYW4gdGVsbCBtZSB3aGljaCB0
aHJlYWQsIHRoYXQgd291bGQgYmUgYmV0dGVyLg0KDQoNCj4gDQo+ICBGcm9tIHRoZSB3aG9sZSBk
aXNjdXNzaW9uLCBpdCBzZWVtcyB0aGF0IHRoZSByb290IGNhdXNlIGlzIHZlcnkgY2xlYXIuDQo+
IFdlIG5lZWQgdG8gZml4IHRoaXMgcHJvbGVtLiBQbGVhc2UgZG8gbm90IHNlbmQgdGhpcyBraW5k
IG9mIGNvbW1pdHMgYWdhaW4uDQo+IA0KDQpMZXQncyB0aGluayBhYm91dCB3aGF0J3Mgb3VyIGdv
YWwgZmlyc3QuDQoNCi0gMSkgRml4IHRoZSBwYW5pY1sxXSBhbmQgb25seSBzdXBwb3J0IFBBR0Vf
U0laRSBNUg0KLSAyKSBzdXBwb3J0IFBBR0VfU0laRSBhbGlnbmVkIE1SDQotIDMpIHN1cHBvcnQg
YW55IHBhZ2Vfc2l6ZSBNUi4NCg0KSSdtIHNvcnJ5IGknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGUg
bGludXggTU0gc3Vic3lzdGVtLiBJdCBzZWVtIGl0J3Mgc2FmZS9jb3JyZWN0IHRvIGFjY2Vzcw0K
YWRkcmVzcy9tZW1vcnkgYWNyb3NzIHBhZ2VzIHN0YXJ0IGZyb20gdGhlIHJldHVybiBvZiBrbWFw
X2xvY2FfcGFnZShwYWdlKS4NCkluIG90aGVyIHdvcmRzLCAyKSBpcyBhbHJlYWR5IG5hdGl2ZSBz
dXBwb3J0ZWQsIHJpZ2h0Pw0KDQpJIGdldCB0b3RhbGx5IGNvbmZ1c2VkIG5vdy4NCg0KDQoNCj4g
Wmh1IFlhbmp1bg0KPiANCj4+DQo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NB
SGo0Y3M5WFJxRTI1anlWdzlyajlZdWdmZkxuNStmPTF6bmFCRW51MXVzTE9jaUQrZ0BtYWlsLmdt
YWlsLmNvbS9ULw0KPj4NCj4+IExpIFpoaWppYW4gKDYpOg0KPj4gwqDCoCBSRE1BL3J4ZTogUkRN
QS9yeGU6IGRvbid0IGFsbG93IHJlZ2lzdGVyaW5nICFQQUdFX1NJWkUgbXINCj4+IMKgwqAgUkRN
QS9yeGU6IHNldCBSWEVfUEFHRV9TSVpFX0NBUCB0byBQQUdFX1NJWkUNCj4+IMKgwqAgUkRNQS9y
eGU6IHJlbW92ZSB1bnVzZWQgcnhlX21yLnBhZ2Vfc2hpZnQNCj4+IMKgwqAgUkRNQS9yeGU6IFVz
ZSBQQUdFX1NJWkUgYW5kIFBBR0VfU0hJRlQgdG8gZXh0cmFjdCBhZGRyZXNzIGZyb20NCj4+IMKg
wqDCoMKgIHBhZ2VfbGlzdA0KPj4gwqDCoCBSRE1BL3J4ZTogY2xlYW51cCByeGVfbXIue3BhZ2Vf
c2l6ZSxwYWdlX3NoaWZ0fQ0KPj4gwqDCoCBSRE1BL3J4ZTogU3VwcG9ydCBQQUdFX1NJWkUgYWxp
Z25lZCBNUg0KPj4NCj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmPCoMKg
wqAgfCA4MCArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+IMKgIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3BhcmFtLmggfMKgIDIgKy0NCj4+IMKgIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3ZlcmJzLmggfMKgIDkgLS0tDQo+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDQ4
IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPj4NCj4g
