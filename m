Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B390E78515F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjHWHVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjHWHVH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 03:21:07 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A7BDB;
        Wed, 23 Aug 2023 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692775261; x=1724311261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RSLDWt5DEnM8q1u2ZRWU2afxq005hpvcw8gXyhZQGEk=;
  b=SjMsAda3cLxU5EZlharTvQtgXOcWKlgO3aeE49tAdOg5g66KO3dHOsPG
   Lm1jLUmPbVf+9r7si7Z91Cbmn4tP0Q1HgF7l2B/fEBV8qFcjc8qEepSee
   jT+5OAfvGa8AdNzJbQQaDtVa3A8hDLD4K6zG7mMBogn7YSBBUlXyYqMVZ
   THMSRVZiI+ksxwwpA6Dx5ak2E3k7R9DD0ugZG/PzWuZPwiP137G/Ds8NG
   rs6AQgx4CfcO2TFGqZiBCvuvBE84X2IFySzr9gcAF4FTsz/VLH25gB+St
   muyG08PP/1oRI5/grabKt2RGNvkNzo9Zg3C2EjqUlfNv3FnRDDn0Albbh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="5958821"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="5958821"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:20:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ+Iu8BXAb4cJ3hXDAt1R4BnC4NKwlgkB0Z8ErPnX4wHbAgeCutQpPVyGUdKbt3kBvXmYZk1NavulVpNUIWDH2CnpHqhwgbykRBeQDs2+2T0dyhlwIGk2ZLabI4eSXNWlmGLwRAEPBn+VMxgVvjQfZAk+lrGGDmkLMbC3OrhHh1AWhy7byctrXWlOH9qyMxd5EbdQq9LgGFG7vYJzXNXA7qNdDAmaBKmlKALVkNPEyF1TpoSunMsYgOIH9fqxY+gXQE1Qat+af/vkLgCN+l0SDq9lffR/EMnJN2dfFpVp0iwXv+NlfLrhSrauLtNh1W3OKql/h/gvvCjBgyGQUbfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSLDWt5DEnM8q1u2ZRWU2afxq005hpvcw8gXyhZQGEk=;
 b=aJ9EJ1H36WLfXuq4yhhtPZmpOtvOUsnGN85JB24cv4E7t+uj0VuEgPXKglW9S7yKgaPxJ62XSztWut3I8GRIB61uJFEi8wdOM6JzewRA/OwXWzXQy/zN7tpbaBIRuL996EXv6m721zFWJaQgw4q2RYsIemDJgPoJIl6xvyq8di+pQANshqIzhE9n+blYWZkAHWXzENoumrkUspjgSlajeNumraP6oMifbwwNgg1G7v1Oh0bbpzSwVRRkdH1TRrxMGD/ULMDlE/ELtepqBUQrAeHW4lHRM0DyU1Oh/jO8bH6ZV9UmRx5NzoNTv7tw96PC9VwPrwQ/aAstPxpQLmQEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB9940.jpnprd01.prod.outlook.com (2603:1096:400:1d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 07:20:53 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:20:53 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Topic: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Index: AQHZ1WdeUKk57k5Lwkqt11UK4BLVm6/3ZsIAgAADnwCAAALwgIAAAyMAgAADXwCAAAYQAA==
Date:   Wed, 23 Aug 2023 07:20:53 +0000
Message-ID: <684f09a7-b83e-dda1-c5ba-9606cce4a2ec@fujitsu.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <ba7f496c-b0af-6532-76c7-08eedea886ce@linux.dev>
 <54f43b58-4986-f2c3-7488-ecaf150b1e79@fujitsu.com>
 <CAD=hENcGfS0++mTTX4z-YT3SAx=5OYyqSf89=AkOCD9+SrUtag@mail.gmail.com>
 <e823d7aa-99d6-1417-8aca-c89db1c350b9@fujitsu.com>
 <86137972-fa63-ef07-3842-3a678329864a@linux.dev>
In-Reply-To: <86137972-fa63-ef07-3842-3a678329864a@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB9940:EE_
x-ms-office365-filtering-correlation-id: f1c27b50-f8e6-4d24-a31c-08dba3a97c8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZeghBol7JOyRmgb62KbZS2V7lbyUsQQbxcc2iN7oD5YGQgpTBIOJBjrTYptqbOeYegICBLyo/zGVLim3PBYziYyqjFsiAzHO9t/CpcpYQm35xyTVKBiRIbxClOJXKP96RlrZvjifCclB7Y8dWDivAETFyC7WJmPurg3Rc3UypSOAqjl8LSICxS0WsPUsQkYXXuAM2nXbhTECIjnrilNnxYwUmj2YrxGq513VfBum0JLwF2lkIKqVTQkRao4QovYgBStNGMOPk7tDVy71rcgeJ0kL6WsSYJnSr/AZ/rLdYpZDWhdXGATtQp71U7Ne3zCUt1iyviue0URzExm3r3hyAbNzM7B5z3RAlZ0hyTeqgN62b+zENu6aW0hpjnLItydXowU9qGsSNvbfiFt0zoHtaEhOnzG6vEmyyTGygCSRQ1cl9ICqy8SIRPW3IAU7iD/VSgYxijq88suC42BNXet8UGLCBo23U618KyssKViO5kym1vqjBs3wKrlPc/DhHzdtwyaxXhyP5QAvCQZARWYS3FWwfclil8jj0ejcfZnpg+TGll1VS0bHvurEb4VPsbvbC7YM/u6iKaika37Rjyf4fmpYfO6btJiuR+Qzf3Wo2PwOqs/oK0gMzhLg/4qWHF1HaWSsMCkGn5Gozp4qaNc8L0uirRpWOA0Zppt8A+dq0IAZaoR0H1p20DedR45FniabGW5x8Rqq8QmAzfw7wPJOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199024)(1590799021)(1800799009)(186009)(36756003)(31686004)(966005)(478600001)(85182001)(86362001)(66446008)(66556008)(6486002)(6506007)(66476007)(316002)(71200400001)(64756008)(76116006)(91956017)(110136005)(54906003)(53546011)(66946007)(41300700001)(6512007)(82960400001)(38100700002)(8676002)(38070700005)(4326008)(8936002)(122000001)(31696002)(5660300002)(26005)(2616005)(7416002)(83380400001)(15650500001)(2906002)(1580799018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1JJSktsbnlGUXV6ZFBoYXd1bWt0YVdud3hnVVNqeDhwNmZYVnRxRmUvc3RC?=
 =?utf-8?B?RDFvemo3cVc2ZURmZzNnMEczMDZJek4yZ3JqZlk5NVFzT1U1cTdpSk54dGw3?=
 =?utf-8?B?dG5FV3Q0QWNiZE56dEFTOXE1Z2g2djYyTGdyWDZsTEs2N1VWNXo2MU13djQ0?=
 =?utf-8?B?TnVrTks4K2NsSlZxQ2pkay9zTVU0bW9hRVpyRGZheEc3K1h2NWd4dEJFN2pp?=
 =?utf-8?B?Wk5TS0lRUkZ3bU40T2NGQ1ZwUU9Od0RrTVd2RUx0cEpJTk1MTFdVcW1WMDd4?=
 =?utf-8?B?UDFoSzkxVjB4NStDcTlyLzVPbFlIK3JNZXhtTVNjZlExTTd3bC9BcFlWUEVp?=
 =?utf-8?B?UHhnZDV6R014U3lYQmY2dEhSbTBoMnhRaUpJMjBsQ1k0WndxUXlYa2Nvd1FW?=
 =?utf-8?B?Mktnb3BkZkNEN2RjOCs1ekh4ak1NYWpkY3BnMnBPUTRYZkplTWFLcThvRmNB?=
 =?utf-8?B?TTBwRlBrNEhTdUVRUFZ0cWJPNlFKSWx1d3Jhcmc4cGxGSGFsdmc2cmlYcTJw?=
 =?utf-8?B?dzBrNXV0KzQ0dUtBTkpuY0tvTHZQUytwUGpRSjZYVkFDYzJyaUk4MjU1NDNK?=
 =?utf-8?B?OVk2SG1UY05OUlBkK1lZNDVKMVVKSzZ5dVorVHltQTV2M0NFa09iYXZXM0pV?=
 =?utf-8?B?a21YanNUa29PQmVhR2trMDB1NnR6eGVHZUF0bGdEaFN1VG5ILzNkSlVaM2Jn?=
 =?utf-8?B?eHBwcWJCOUdHcXFFclVubENmbkNMZ0F4aEdDSGt2U1U3U3FqLzU2MHFSUTJ6?=
 =?utf-8?B?T256YXk2WS8zc2I3SDhQQ3lXZkFQTWVyTVBVU1hpZEZYemQ3Q1J4UWVmR0ZC?=
 =?utf-8?B?aGM1QUtRWHZRNm5IVzRFM1Vja3Q1N3dXV1k0ZTdQSnZJWlNnL0Q0eFRWWlI2?=
 =?utf-8?B?UEI3Z292YkxOV1pTNUhjMnpWYmdrTDBxdVBMKzlkRHhVeHRXTXhJOFpPZDA1?=
 =?utf-8?B?UEFHTTZ3ck9ualkyU3RlMXlXdnY3WGpWQlNKTnQ2bmRuQzdPUitXWUNoTi9h?=
 =?utf-8?B?VlRrbHR1WVVTaGpmLzNlNGNQdDlYQnhINDdpQU4vaG9Td0R2RFdQTEhISXd5?=
 =?utf-8?B?ak8yNkxMajJZaVV2TmVYSlFhOHF2dk1tOHBVNTJ1aXVEbjZWVDRXVHBoeW91?=
 =?utf-8?B?ZEsxaTM4cWpralhSZXowRjFBRGdJR1lWcXQ5T1FJYmZ4QSsvdEswaTRqZjBt?=
 =?utf-8?B?bHZMNmQzaFlKUzdUeFlIVzJPeWxqT2pncnQ4MXFVR2MvTk0vaDk4cVpUamVs?=
 =?utf-8?B?dXovU2ZmMWYwRk9kcTNVa1ZJNGFiTU45QVlIdklnT2pBdHJuK2UycDVIR1FD?=
 =?utf-8?B?aFdtVXNhY1hmdTZXdmFKaUo2SkhBWlJoc1JZQ2g5VldtcWR4YTRlcytVWW12?=
 =?utf-8?B?TVJ6emtNWnVWdkNuRlJTeTY2ZmpKd2k3NXhWaDVtRTlteXdqYTc3alRjQmN2?=
 =?utf-8?B?OWVTeEtDbGRSeU1Qb2o1dk93UzVGTnBUSjBaOVQ0cHlsZVg0K0lVTmJRQm4v?=
 =?utf-8?B?Q2x2M2tJRGpxOVNQcnlPSlFhYndPNzZKMllsaU9vT2w3K2RxekNiay9SYmVG?=
 =?utf-8?B?WXRhZ09FWFJQQzlwWEhhdk03UDNhVWMxU0JkR05kb0Mzb3Zwc3N6eHF1WCs1?=
 =?utf-8?B?VFA4WWVsa2x1ajMrMHlJTkJaS0F2K3dTcnY1RFJuVEUwSExUUkJxejFoMFZN?=
 =?utf-8?B?UmxOampIZ09yRStuYVkrRWdjS283SVdiWEYwb01IaFBnazdUYUpCbTViZVNG?=
 =?utf-8?B?OGJibitaRGxDc25icnJuaENYZUc4djk5U2M0N1JSSndiV2Fka2ZjMDFVVkdN?=
 =?utf-8?B?YlNYd0ErSEVLREZ6eWE2eWZOUHJhMEFjOTB4aWJtZGhnaGtTWDJtTHlCUUNV?=
 =?utf-8?B?VXB3QTM2ZGFMME80d05VMDFmOGk1NnVXNm42elQ0Ti9pcmNNMDdJVDlmYk5X?=
 =?utf-8?B?ZUpXZ2xDRE9scjdwT09EN2ttVjhnaWV0bm1mZVJQeWRiRFBwSmU4c1prUTBs?=
 =?utf-8?B?QzFoQ3BSZlVzdTV2alBWbXlWVkNzc1B1Zm1yLzRxbVNla09ZL3pyMnk4dW4v?=
 =?utf-8?B?UWhnaEpkVFF1am9tTmV3dEdpdTUyK3dqNGNQWWNCZnlDMjUwUmMzUS85ZGF5?=
 =?utf-8?B?YmViMTZHTi9lMEJxaDdteUY1ZC8wSHBUYldPV1Y1QUMxUUtzc25zT2ZOMVZG?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <575B3EC329DEEB4FBE1C164EC8E325A0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUZNaHhSWHh6S1VkSFpnTUVLdWJ3ZVB5RjZ4d3MvYjEydWtnRHpSYUJLYnoy?=
 =?utf-8?B?UnRubVZJM0ZVYURxc21lK1RZUUZqMmcxZHUvbUtxalRVQ2tndTgwb1NEdTg5?=
 =?utf-8?B?SU5TcWpPK0hVdXUyeWllcWR6a201bXIzaW8xcDMxWWZrRU5mZy96dnhpc3BF?=
 =?utf-8?B?NjRGTkRKT3JJbmRlQTNrZld2bEp0cjd4TnJ0eXVjVXZndEFadEk3a0p1a0NO?=
 =?utf-8?B?QnVKc1E3N05UT202NDR4WnIwcDJYYzBVckFyN0wwTWRSaDlxdWRyM3dCYm1T?=
 =?utf-8?B?dHVHOW1EN1JLWXg1eHdONC84SVJ5SmFGdHRIYURtZHhJYVZFOGlIRWhRdzhC?=
 =?utf-8?B?djJmOVM2NW5wMzBQMG5VNEw2OWNlNGV1elhvbTN1dlRTSDd6aW9HcEQzQzJj?=
 =?utf-8?B?LzhrcUhZWVNGUFE0NTc5U0lLOHhZUVkyVGhaYkRVa0tOUnVBRU8yaHFJMWd6?=
 =?utf-8?B?eFV1aFJkMUFkbTJ4U1lQaDBBcU1LVnhIQUFtQ0VkZGJXZ20yemN2aUhFdFJz?=
 =?utf-8?B?Nm9JOVBmTWJyMWk4aXdSRVVVWnFzT1dmK3FiMUIxaUFMTG1LZ0xFUVVuZmlq?=
 =?utf-8?B?ZnVUOEZiUHBSVEhoUDFub3M2RTZUN1pBNnhVRStWeFVLMDVxOHkxQ25Gd29T?=
 =?utf-8?B?NXJqN3VxbVlOQXcvZUxJTlY3clptYVJOZlNPK050SHhvWWQ3QzE0K3FKMkNX?=
 =?utf-8?B?QTVINjVva0QwTFRUSFdpbTBBY1RRaVJFYTF2eE56QkQ0ZS9COWw2VFYyRzB3?=
 =?utf-8?B?RlhtMklCcHJ5NDhNRkZrQktMZ3NBRkJKVWN4dGN5eDJTc1pmc0hNa1gwSGVT?=
 =?utf-8?B?QWJsQnFYb1h2L0tRTGJVWnB4b1lFYWJOVC9SMndzMU5zK1oraWQ1YkdFV2ZU?=
 =?utf-8?B?bFk5Mnd6Umo2aXlRQjZZQkoyTExlRERvajVKMlFqV2Q1SXplTHpHRnpWZ2lC?=
 =?utf-8?B?NGkyVnpGNXpEWmxLUnZxRGtPVnBEUys3SVhPNE1tWDhKditVa3lPN0JNUEd0?=
 =?utf-8?B?bUFEVkRhYStqaDEybmFheEtEbk0wRUYxMGJJTDNIc2ROTzIzcndWOUlmVXFz?=
 =?utf-8?B?YllNMThwN1ByRmVOYmluNkV3aTR6TkllMG4ySUs3dkR3TnM5ak5FVDNPSVBS?=
 =?utf-8?B?Q3h0M3dtZHE4WVA0eW9ORUxJL2U0UGRoZnRkaHNELzhydnhiQWNmMUFKL2ZD?=
 =?utf-8?B?QTRlNWltT3hkbDZNZDQ1MkJrZUJJbUZtTUZ2OVJVM0V1Q3dOL25WNmx4Tlgv?=
 =?utf-8?B?U2NNak8wcm5IYzhYekY5U0pERW0wWE9Ba3I4SmNMNmpZV1pCUVlXMkNqWEZY?=
 =?utf-8?Q?0w2aLAvDGCGh8zmK+zM9zC0ikWbe7p0+nL?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c27b50-f8e6-4d24-a31c-08dba3a97c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:20:53.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcp8/HmN9t6SQAMYFyqHgLPy3nWaL34kyBoHeR3vb6vcwE1esEik5Srj7JphCGWJvgsWhPdaB23fWLKYUeuTaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9940
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjMgMTQ6NTksIFpodSBZYW5qdW4gd3JvdGU6DQo+IA0KPiDlnKggMjAy
My84LzIzIDE0OjQ3LCBaaGlqaWFuIExpIChGdWppdHN1KSDlhpnpgZM6DQo+Pg0KPj4gT24gMjMv
MDgvMjAyMyAxNDozNSwgWmh1IFlhbmp1biB3cm90ZToNCj4+PiBPbiBXZWQsIEF1ZyAyMywgMjAy
MyBhdCAyOjI14oCvUE0gWmhpamlhbiBMaSAoRnVqaXRzdSkNCj4+PiA8bGl6aGlqaWFuQGZ1aml0
c3UuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4gT24gMjMvMDgvMjAyMyAxNDoxMiwgWmh1
IFlhbmp1biB3cm90ZToNCj4+Pj4+IOWcqCAyMDIzLzgvMjMgMTA6MTMsIExpIFpoaWppYW4g5YaZ
6YGTOg0KPj4+Pj4+IEEgbmV3bGluZSBoZWxwIGZsdXNoaW5nIG1lc3NhZ2Ugb3V0Lg0KPj4+Pj4g
cnhlX2luZm9fZGV2IHdpbGwgZmluYWxseSBjYWxsIHByaW50ayB0byBvdXRwdXQgaW5mb3JtYXRp
b24uDQo+Pj4+Pg0KPj4+Pj4gSW4gdGhpcyBsaW5rIGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxk
cy9saW51eC9ibG9iL21hc3Rlci9Eb2N1bWVudGF0aW9uL2NvcmUtYXBpL3ByaW50ay1iYXNpY3Mu
cnN0LA0KPj4+Pj4gIg0KPj4+Pj4gQWxsIHByaW50aygpIG1lc3NhZ2VzIGFyZSBwcmludGVkIHRv
IHRoZSBrZXJuZWwgbG9nIGJ1ZmZlciwgd2hpY2ggaXMgYSByaW5nIGJ1ZmZlciBleHBvcnRlZCB0
byB1c2Vyc3BhY2UgdGhyb3VnaCAvZGV2L2ttc2cuIFRoZSB1c3VhbCB3YXkgdG8gcmVhZCBpdCBp
cyB1c2luZyBkbWVzZy4NCj4+Pj4+ICINCj4+Pj4+IERvIHlvdSBtZWFuIHRoYXQgYSBuZXcgbGlu
ZSB3aWxsIGhlbHAgdGhlIGtlcm5lbCBsb2cgYnVmZmVyIGZsdXNoIG1lc3NhZ2Ugb3V0Pw0KPj4+
PiBZZWFoLCB0aGUgbWVzc2FnZSB3aWxsIGJlIGJ1ZmZlcmVkIHVudGlsIGl0IGlzIGZ1bGwgb3Ig
aXQgbWVldHMgYSBuZXdsaW5lLg0KPj4+IEFkZCBQUklOVEsgcmV2aWV3ZXJzOg0KPj4+DQo+Pj4g
UGV0ciBNbGFkZWsgPHBtbGFkZWtAc3VzZS5jb20+DQo+Pj4gU2VyZ2V5IFNlbm96aGF0c2t5IDxz
ZW5vemhhdHNreUBjaHJvbWl1bS5vcmc+DQo+Pj4gU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29v
ZG1pcy5vcmc+DQo+Pj4gwqDCoCBKb2huIE9nbmVzcyA8am9obi5vZ25lc3NAbGludXRyb25peC5k
ZT4NCj4+Pg0KPj4+IFRoaXMgaXMgYWJvdXQgcHJpbnRrLiBUaGV5IGNhbiBkZWNpZGUgdGhpcyBj
b21taXQuDQo+PiBJIGRvbid0IHRoaW5rIGl0J3MgYSBwcmludGsgc3R1ZmYuDQo+IERvIHlvdSBn
ZXQgbWU/DQo+IA0KPiBJIG1lYW4sIHByaW5rdCByZXZpZXdlciB3aWxsIGNoZWNrIHRoZSBzdGF0
ZW1lbnQgInRoZSBtZXNzYWdlIHdpbGwgYmUgYnVmZmVyZWQgdW50aWwgaXQgaXMgZnVsbCBvciBp
dCBtZWV0cyBhIG5ld2xpbmUuIiBjb3JyZWN0IG9yIG5vdC4NCg0KDQpJJ20gc29ycnksIGkgZ2V0
IGNvbmZ1c2VkLiBJIHRob3VnaHQgeW91IHdlcmUgdGFsa2luZyBhYm91dCAidGhpcyBjb21taXQi
DQoNCkFuZCBpIGhhdmUgcG9zdCAybmQgcmV2aXNpb24sIHBsZWFzZSB0YWtlIGEgbG9vay4NCltQ
QVRDSCB2MiAxLzJdIFJETUEvcnhlOiBJbXByb3ZlIG5ld2xpbmUgaW4gcHJpbnRpbmcgbWVzc2Fn
ZXMNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KDQoNCj4gDQo+IFpodSBZYW5qdW4NCj4gDQo+Pg0K
Pj4gSW4gZ2VuZXJhbCwgd2hlbiBkZXZlbG9wZXJzIGFkZCBzb21lIHByaW50aygpL3ByX2luZm8o
KSB0byBwcmludCBzb21lIG1lc3NhZ2UgaW4gdGhlIGtlcm5lbCwgdGhleSBleHBlY3QgdGhpcyBt
ZXNzYWdlIHdpbGwgYmUgcHJpbnRlZCBpbiB0aW1lLg0KPj4gU28gbW9zdCBvZiB0aGUgcHJpbnRr
KCkvcHJfaW5mbygpIGNhbGxzIGluIGN1cnJlbnQga2VybmVsIGFjY29tcGFueSBhICdcbicgYXQg
dGhlIGVuZC4NCj4+DQo+PiBBbmQgcHJpbnRrKCkgd2lsbCBhbHNvIHByaW50IG1lc3NhZ2UgdG8g
J2NvbnNvbGUnIGJ5IGRlZmF1bHQsIGNvbnNvbGUgY291bGQgYmUgYSBzZXJpYWwgcG9ydCh0dHlT
MCkgb3IgdHR5MSBldGMuDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGlqaWFuDQo+Pg0KPj4NCj4+PiBa
aHUgWWFuanVuDQo+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4+IFpodSBZYW5qdW4NCj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+Pj4+Pj4gLS0t
DQo+Pj4+Pj4gwqDCoMKgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMgfCAyICstDQo+
Pj4+Pj4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jDQo+Pj4+Pj4gaW5kZXggNTRj
NzIzYTZlZGRhLi5jYjJjMGQ1NGFhZTEgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGUuYw0KPj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlLmMNCj4+Pj4+PiBAQCAtMTYxLDcgKzE2MSw3IEBAIHZvaWQgcnhlX3NldF9tdHUoc3Ry
dWN0IHJ4ZV9kZXYgKnJ4ZSwgdW5zaWduZWQgaW50IG5kZXZfbXR1KQ0KPj4+Pj4+IMKgwqDCoMKg
wqDCoMKgIHBvcnQtPmF0dHIuYWN0aXZlX210dSA9IG10dTsNCj4+Pj4+PiDCoMKgwqDCoMKgwqDC
oCBwb3J0LT5tdHVfY2FwID0gaWJfbXR1X2VudW1fdG9faW50KG10dSk7DQo+Pj4+Pj4gLcKgwqDC
oCByeGVfaW5mb19kZXYocnhlLCAiU2V0IG10dSB0byAlZCIsIHBvcnQtPm10dV9jYXApOw0KPj4+
Pj4+ICvCoMKgwqAgcnhlX2luZm9fZGV2KHJ4ZSwgIlNldCBtdHUgdG8gJWRcbiIsIHBvcnQtPm10
dV9jYXApOw0KPj4+Pj4+IMKgwqDCoCB9DQo+Pj4+Pj4gwqDCoMKgIC8qIGNhbGxlZCBieSBpZmMg
bGF5ZXIgdG8gY3JlYXRlIG5ldyByeGUgZGV2aWNlLg0KPj4+PiA+
