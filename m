Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C643F7A56C3
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 02:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjISA7E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 20:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISA7D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 20:59:03 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 17:58:57 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A59107;
        Mon, 18 Sep 2023 17:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695085137; x=1726621137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UihPEnPff1liyamogTwzY2QAZfRXkM2HPW0o9wAMi0M=;
  b=Ryfm15jdnZ3BMh+4m8bn00sECihCJeIWOd/NB7EPbldEa5rTLzQ8BbnL
   SOMY6QaNgiaLJhP+cqD8rQYPTSu4BYb5r5KZYddeUh8TdOIObZ8fMl1ZG
   aYQw/OjJPSDjTlNTHHiGATcgF/zoIdy3moAKjtXZo3XiZ7E4fcx4q8GXZ
   9SPjdxgOIKpV8wvhcyUOvu4QmBBAByDmwkbee/D7+U1mLeQHW2Rc4duSL
   Qr7nFQcUtytHPV9P5sPlOq5cUEJzYqNXXpOAVct7cmdzdHHZTHspX02op
   GDqx3bm/MxThZ+yMfCLzNWymGK4LEdOjOXXAOtoN4Qgpt0zj0KX1YaVB5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="6767581"
X-IronPort-AV: E=Sophos;i="6.02,158,1688396400"; 
   d="scan'208";a="6767581"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:57:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY/Ff3lz0exPL1J4ZodAEb8MKNgwdflcC29XPPZluW5IKXSegSXV07C8feLp0OEj4wv4I/563cpr6ZxuzVDtzSaKRLjc/3EIkYYxHp5KZ2EXWg4znrWcQtLzbZbwmo3U7sTZFx54VXl3qSrljRwdpvWRo7QN1isziJaCUrUXDSZ/Gd1OLc/4hYP1S6e8eWHCXJwYHGSdzuCIrs77PnsdwbdoD6P7dHPH9rCPhl1jfx2glH7f5WBpCbVrQA64m3xOrL6NDq/g2O9Pfdq1h8eLXA6yrAT1U2RO1FIL/d3uqChde0wYUBiDVtIQqaHZbSI6mQu5/0UAcAASYVcGah57Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UihPEnPff1liyamogTwzY2QAZfRXkM2HPW0o9wAMi0M=;
 b=RHB5V/OsK0J1+iGTeU6okn7yzEe0pP9jE0LnK6oWTH0mVJqPQAiFbMcfAVbRaPZcORu7yisBIyztkaOKXoZD3Sq2fNayrfdcfFRMwpucjumMeTAiUAf8Y+eVAfxv6hNsgPE8g0wFwbGAI7JS6VuZfphzwp+3eHFI8ksUGPCh6hWfRMRSqZNgFioaHcxs1UhJCcq0Sl4UGJxlYr51S9q6vgM5Gqt/1HDlIP04wOwJPithMWOkXLxmoRz3H1kZLigMmOuA2dQT8v15lXRIYto40/l4voUeLf5H67T7WNmXl9Z3oXuGFGKnDxwJn4FAZW9piro0NB5A4Eo4P/h6nFySdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB11350.jpnprd01.prod.outlook.com (2603:1096:400:36e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 00:57:46 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 00:57:46 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
Thread-Topic: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
Thread-Index: AQHZ6dSthw3TTp5QhU2XAaF5adK7jbAghgUAgADO64A=
Date:   Tue, 19 Sep 2023 00:57:46 +0000
Message-ID: <4dce179f-f808-0a18-7e9e-9877964d67e4@fujitsu.com>
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
 <20230918020543.473472-2-lizhijian@fujitsu.com>
 <20230918123710.GD103601@unreal>
In-Reply-To: <20230918123710.GD103601@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB11350:EE_
x-ms-office365-filtering-correlation-id: 758cde43-d416-4eef-27c2-08dbb8ab7032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMN+E0tflWwaAlqsH04hmDVFrYJlSCSVz5mkHsS8JdjGP2TWHENqhZo8g3XqYUCjGD6O9WG+ugC0Rj2tyWT3VSVeCMJz/GiuPrscaoEmUYMGE7NodBpWWJN2jrRXf4R3a8lPmH71gDrkl7e5jY0LH8b7HTN1q29Vtjj7pr+bVA8c951mqfyXQEdeWimfNbABgBYRxb8cJpn155hm0/jby6prST6edI/rzZxNZvCghaTtcXmqGeieYMyAUF8RmtVXAJT8LeceS5dRv9BfCQ9zaylJ5ZGVolKjxBx1Qn5jyJ3XbTRW/ry0WdmK5W9+PU0MsqI49jhpaO7plh6Kzg3RYJN8hmJgjzafHFdU5KPmMfq2lspCaZ9mgnitxOlxx+htNH28/cKNiLGVNJrQAxxFvFY+DZePcSKsXH7qgIwQa9NwQSHz2xdK2EVCBOYsB5aAlkYG9/t/l0iqp4ZSPDosCLxwhOMuRoVrcmbm307k7Q3eit+IJyDtZBEJ2Vs8LDNYZilaazocEPND9EwFUbla6DMW7tnnq7gbQgIiLWmZ0KWSYee6I7iIrxhpAbNPyr+SNee8X0SauJuddPSESEH9YNZrVOBu58/hLWtaRCHASNbwYMWypF+1Qgi/FGsq7amfpvwdfsRc3dGc8eiEzWmkRoqwI7AgTR6EnxbNi+Badssrvw5hrOEXfzyt3k8VzWgz+qvXbLvl/RhQ9CYDDF8i7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(1590799021)(451199024)(186009)(1800799009)(91956017)(76116006)(66946007)(316002)(6916009)(66556008)(66476007)(41300700001)(66446008)(64756008)(54906003)(26005)(8676002)(4326008)(8936002)(31686004)(2906002)(478600001)(5660300002)(6506007)(71200400001)(6486002)(1580799018)(6512007)(53546011)(2616005)(36756003)(85182001)(122000001)(38070700005)(38100700002)(82960400001)(31696002)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRYWHlTRDZaRm1pOEt5WTZPN1BqV0gyRlQ0Z3grSTl3Y0kxUndjc3hSUEQ5?=
 =?utf-8?B?SlIrR1hFdmFrT0FOTytkdnhxVnRweEZvWitwK1UvRlI5K2RPck5PblpVVG80?=
 =?utf-8?B?d2tFZi84dlRGVUNFdXA5WXNCb0l3RzR4cllFOGY4dytrcUVtK3pSRmhSOXVr?=
 =?utf-8?B?V0p2TVgzK0hwcEczS3pMRDA5RjVOSHdRaVZUR1Fhb3Jnand2WVhYZnRueVYv?=
 =?utf-8?B?OEZKRDJRbjRBdGc5ZXoxWCtZb215T2FTeFR4U0NLSTJiaHNleFRwdTJLcmNr?=
 =?utf-8?B?cjN5WkdDSkYycG1nUENzWENFSlRpNWlvRk1COXJSSDlLT2VHaUozS3RNbFV3?=
 =?utf-8?B?VnFPRFFqbVpacUxjR0dnZEF6Z1lHeTFSRGZoYURvYTI1UTJkVXVWK2EvaThO?=
 =?utf-8?B?MFdnZTk1Skd0Y25EWjR6RTlxTlRzYktHTGJkcmRHcVh6Q0NnRlp3amloMG1l?=
 =?utf-8?B?ZTlvYlZnRlFjdWZtRmkyVjJVTGJFUjNLMFBRQ2N1NXdVLzFMN0szTUVFalMx?=
 =?utf-8?B?VDZFRzNqYmJQRjU1cWswam9VUTQ3aHVFWkJPWXl4NTZhNVVHSDBNV1VqS3I1?=
 =?utf-8?B?YjhsV21rU3RSV1libzVheVNGdFM3Z2lRbU5hTkE3OGhnZ0tCL1dKa1l2MWJP?=
 =?utf-8?B?UTJKRHhFa2tNQzJ0QmE1NUlmcGdqVElBM0NibklmUnhXSHQwY3pqVG53dngx?=
 =?utf-8?B?S2dlOTVPaDV2NGt2cXY3SzdtTEgzYWhlOTFBSjVoczE2ZVV4cjZkMXpsVkxo?=
 =?utf-8?B?ajlaaDdJQVppSHdxcDRxTFd1bDNhVHJpSFFXN3RuNWNTRTRkajlHYzVCSmtS?=
 =?utf-8?B?RVMycEZLWXZWTnhpSU03MmZIdjAxN2g5Rm8yVTV6R2M1clpQYzFka0F2K0Za?=
 =?utf-8?B?UVZhRVA3NVJOT3kwSThoSmd3SG5LRGVnWXYyc3dSUVJSZmYxYWV2dkMxSi9R?=
 =?utf-8?B?b2FOOW40NW1EV3p0Vk1OanhxbWpIeE9SeUt5MDlpMHF1RTB1Kzh3ZkUyVTBB?=
 =?utf-8?B?dEs3ZHJONWxsN2JJUVpKcnVsa3RxQXdacy9xdndLdm95cDc3T3IyRHZIc242?=
 =?utf-8?B?TGJ6Wm5RZmh2WHNqN3ZjbGk4V1R3T1dITDJqUVFEcExjQzQ1QmFoRUVjZklT?=
 =?utf-8?B?aVIwMTZjQU9aRm9KZWZyZWc5WTBLR1JZSTBmNm95ZzhwbWJuSWFhYldkU0Rh?=
 =?utf-8?B?TEhlWWU3WDBHVjlXcEtTbWdSdE5XdVVpMlBUcGFycm5ETnNCWS83TU9PZHMz?=
 =?utf-8?B?TVZveTI0SGc1eEJwTjBWT0tOYmJWcEpURGpmeXIzWmkyZWxHRFZqbzB0N1FP?=
 =?utf-8?B?bEZTTWx3QlJ1R3NCc0d4ZVdDRDVYZlk0MmI3M2RqSC9DSSt2bUJOSDd4UE5o?=
 =?utf-8?B?NlJkRXhzaks1c3RCeDV0T3ArZ0phTGtXVlErMGJ3RVA2TThHdjF5di9Gcjhy?=
 =?utf-8?B?UWNyZWlUMGdvOGNhTVZYbmtzVkp1OS8xeXNLalp5MUVsWklVRWVmYVhQY0hs?=
 =?utf-8?B?WnB3d2hzOGxPQlpTcTB4MjZkOE5PWml5WnFJcmQ3MjhIdDRUZnhHME01K0RE?=
 =?utf-8?B?T1pkMGU1UmEvajFFaDV2Z0YxYyt5azBQcUk5c3dSUktOSGdNeVkvWGFET3Qx?=
 =?utf-8?B?STFqWlNDaEZQNWtoUWJLdndNWGxpVC9PQ0oxaHkwMHdUZG5Ya2JWKzRISGZC?=
 =?utf-8?B?N01BUTZnbytacEQzd1pndnRwV2o2SEdRVzl4Z3ovUXZlRmRJVzZoKzFTUVB4?=
 =?utf-8?B?QVVGbGxPZE4xK2NQZmJ3MUhja0tzZVZyM2J4ODJiLzUwQVd1WlVWYW9wTTds?=
 =?utf-8?B?U2tINEpnS2c5dkNqeTFxekJFWkhERUROdWlUMzRkZ1I1ZWQ4bC9PdXc0ZE00?=
 =?utf-8?B?LzFIcm1LTUNxQ2Y4RGNMMmFVK2dIS05vLzE2cGRWKzFFbjBEL0VyOXR6RlR0?=
 =?utf-8?B?ZUJhMXpaT1JzTlNDL0pnWVBDNGVHRzFEV0JoTFNyUDBrY1kvNkYvRk1vYXRo?=
 =?utf-8?B?cHRzOG1ueGlrRGRZN3dSUFlZb3F6MEVHTjMvbzNPUDUrUi9kd25OWUdUeW00?=
 =?utf-8?B?TktjdFZPbFY3SmE2SVZxekovS3BFQ2R2Y01WSHF1aCtwU1NXeUFxWFNoZkdS?=
 =?utf-8?B?VG1YRTFUTU5FbTh1QXBsdThIeG92R1p5cUpVSWtSUElZM3NNQ1BpVzZSRkRn?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F9C5E0EA4E7D48A9C801980B70DAAB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pq0vpR5mNNBnL7rOLuWed4KTmi/LEaOcCwYH3CTdn2R8XidhJZo4aQWiS8l/aI1H5y4iSLTOE61gDp0dSVvjyqGmX0ZUOSZoC3xUdvMLWPnO+pDLP9KUnjiLg0M5SF1cc8xaAr0VzxYu5qKA5xenNa3vxJoF6f/pn0/UMqCf04pdMXahUB9mIPYQPJCibuoUhmFIkhApdqczwKLiZ9MW2Z9kO3+6N71hJJV13aZEtJgRvLcdzSEtDGdTlYfIAno9cl/8v0fHjUiocN11xJ5xKauaNa+vfmfm3GOMkzuq31Pn869LGRaQgxIe7jD3tia6keZkHsp7aKgs8q5eX7zKDUZDcy2JsDU2Ion8tBNvm23kKoesXwOTJKlbDVHZZd/rqE/xLNytFuuaqVcYQV4A1ch/VjuycwclQjSA+vxkeWFlnFFex0ITShSxy9HXgSVQXgmg+xA3gXZN742icl6hsAALP/xUanrd5aCjp7bKUwi3JEUlMriZh6U4tnE0wT24nsUXJ2bXo8eVK3Psf6pzOotsaCL4UCyZZEywKOzZanDWO2c0RZeT+cJ4s8MoMGiddC5af9mLynh8ByQRBw5hvC36XUpIp5EayYGQS0molFySBa+/iLxSY4AgeTJkNcIS8/N9ssjZgRe+FpOJGRmjEM2z6QIyLeO9XWWDhRWZ5hYwFSvlpLwqjzqWVFReLIzrs3eM7gPzRGLWrnKuUw4OcVhmwSLlGEVZEsIEXcqWcECCj+OPd6waP8oNk0g+bzsrb57D/U0xtYHnl3RIx4YzSM1hcCp07chIWVE2iCYnitq1DwMlhtmzqP4Wb0vz2xrM5aloOhVpPIoE5gqILUSZepw7D3cT6bISDl0gdFaTAh5ow8NyxLp+YzDElLBCUS9j
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758cde43-d416-4eef-27c2-08dbb8ab7032
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 00:57:46.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pq9cdQlJi2ayn2ID8r74FAh+7JpyTTexJEcORmjhmcacQWKVQtgmVaFUAG6Biuv1jcf1FNQqtdF9uLSxmCVoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11350
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE4LzA5LzIwMjMgMjA6MzcsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gTW9u
LCBTZXAgMTgsIDIwMjMgYXQgMTA6MDU6NDNBTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
IHJ4ZV9zZXRfbXR1KCkgd2lsbCBjYWxsIHJ4ZV9pbmZvX2RldigpIHRvIHByaW50IG1lc3NhZ2Us
IGFuZA0KPj4gcnhlX2luZm9fZGV2KCkgZXhwZWN0cyBkZXZfbmFtZShyeGUtPmliX2Rldi0+ZGV2
KSBoYXMgYmVlbiBhc3NpZ25lZC4NCj4+DQo+PiBQcmV2aW91c2x5IHNpbmNlIGRldl9uYW1lKCkg
aXMgbm90IHNldCwgd2hlbiBhIG5ldyByeGUgbGluayBpcyBiZWluZw0KPj4gYWRkZWQsICdudWxs
JyB3aWxsIGJlIHVzZWQgYXMgdGhlIGRldl9uYW1lIGxpa2U6DQo+Pg0KPj4gIihudWxsKTogcnhl
X3NldF9tdHU6IFNldCBtdHUgdG8gMTAyNCINCj4+DQo+PiBNb3ZlIHJ4ZV9yZWdpc3Rlcl9kZXZp
Y2UoKSBlYXJsaWVyIHRvIGFzc2lnbiB0aGUgY29ycmVjdCBkZXZfbmFtZQ0KPj4gc28gdGhhdCBp
dCBjYW4gYmUgcmVhZCBieSByeGVfc2V0X210dSgpIGxhdGVyLg0KPiANCj4gSSB3b3VsZCBleHBl
Y3QgcmVtb3ZhbCBvZiB0aGF0IHByaW50IGxpbmUgaW5zdGVhZCBvZiBtb3ZpbmcNCj4gcnhlX3Jl
Z2lzdGVyX2RldmljZSgpLg0KDQoNCkkgYWxzbyBzdHJ1Z2dsZWQgd2l0aCB0aGlzIHBvaW50LiBU
aGUgbGFzdCBvcHRpb24gaXMga2VlcCBpdCBhcyBpdCBpcy4NCk9uY2UgcnhlIGlzIHJlZ2lzdGVy
ZWQsIHRoaXMgcHJpbnQgd2lsbCB3b3JrIGZpbmUuDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4g
DQo+IFRoYW5rcw0KPiANCj4+DQo+PiBBbmQgaXQncyBzYWZlIHRvIGRvIHN1Y2ggY2hhbmdlIHNp
bmNlIG10dSB3aWxsIG5vdCBiZSB1c2VkIGR1cmluZyB0aGUNCj4+IHJ4ZV9yZWdpc3Rlcl9kZXZp
Y2UoKQ0KPj4NCj4+IEFmdGVyIHRoaXMgY2hhbmdlLCB0aGUgbWVzc2FnZSBiZWNvbWVzOg0KPj4g
InJ4ZV9ldGgwOiByeGVfc2V0X210dTogU2V0IG10dSB0byA0MDk2Ig0KPj4NCj4+IEZpeGVzOiA5
YWMwMWY0MzRhMWUgKCJSRE1BL3J4ZTogRXh0ZW5kIGRiZyBsb2cgbWVzc2FnZXMgdG8gZXJyIGFu
ZCBpbmZvIikNCj4+IFJldmlld2VkLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3Vr
ZUBmdWppdHN1LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxp
bnV4LmRldj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1
LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jIHwgNSAr
KysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMgYi9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jDQo+PiBpbmRleCBhMDg2ZDU4OGUxNTkuLjhh
NDNjMGM0ZjhkOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
LmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMNCj4+IEBAIC0xNjks
MTAgKzE2OSwxMyBAQCB2b2lkIHJ4ZV9zZXRfbXR1KHN0cnVjdCByeGVfZGV2ICpyeGUsIHVuc2ln
bmVkIGludCBuZGV2X210dSkNCj4+ICAgICovDQo+PiAgIGludCByeGVfYWRkKHN0cnVjdCByeGVf
ZGV2ICpyeGUsIHVuc2lnbmVkIGludCBtdHUsIGNvbnN0IGNoYXIgKmliZGV2X25hbWUpDQo+PiAg
IHsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICAgCXJ4ZV9pbml0KHJ4ZSk7DQo+PiArCXJldCA9
IHJ4ZV9yZWdpc3Rlcl9kZXZpY2UocnhlLCBpYmRldl9uYW1lKTsNCj4+ICAgCXJ4ZV9zZXRfbXR1
KHJ4ZSwgbXR1KTsNCj4+ICAgDQo+PiAtCXJldHVybiByeGVfcmVnaXN0ZXJfZGV2aWNlKHJ4ZSwg
aWJkZXZfbmFtZSk7DQo+PiArCXJldHVybiByZXQ7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIHN0YXRp
YyBpbnQgcnhlX25ld2xpbmsoY29uc3QgY2hhciAqaWJkZXZfbmFtZSwgc3RydWN0IG5ldF9kZXZp
Y2UgKm5kZXYpDQo+PiAtLSANCj4+IDIuMjkuMg0KPj4=
