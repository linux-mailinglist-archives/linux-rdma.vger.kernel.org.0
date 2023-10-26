Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1057D7F4B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 11:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjJZJGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJGE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 05:06:04 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18829189
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698311160; x=1729847160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w97WsQ8FXsvoldRrnKHkgxQE1zJRPB2NvFWUPdUkqeU=;
  b=vzljDOQUKhfKDfzHCKzJiPx6uWQUtbJl6DMcTiTXxo7uOJIovZ3jjgEg
   8r63H/x0CSP+ms/Cg3cT8VxozxmiMEoEjCZ3dGR8C1vUXzQA4eQQTOcab
   ecqTtIBXBdAauf/l7IFK3pTvjaEjGLXKn/8ciLFWKFzk72t2JL1U9SsvD
   hvg9aTmiaS+td798d7aPhbu8ExYuQ1l6+PUvradKY24CW6/VcxGiGDw4E
   UTJ/vcfr9jieFzZlo2ol4J3gvualoRWw8I0veO8SBY/0D7Nb1ef1a1YN7
   wFpLd9hn4MuH+1kboCpvCEJ7dherIWAb41S3/qNV51jE206gtyc09zjjB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="100730854"
X-IronPort-AV: E=Sophos;i="6.03,253,1694703600"; 
   d="scan'208";a="100730854"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 18:05:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtsPC08HRJckmeOKR0IaN9/RMWbhN1NxMxtpKXRFv9TW+0bq3a767hz0LoWb1wn6aCvlaYWUlWp3uqznrCy3RkB0u3PteGepMy+Zfb39XHlYDbEWKHmbROP54rEroU9HPjn0Wvq/rNZu0Wful08i8TbJRdTs9YG47sdTAn563VnRQili4TlehQK11/oLaXMzhh1dA7G0RmeVamv/ujHJ/jbf2YxbADjafprCagX1zbjdJk9tptBN8tSbqJVY/Vel0ZcbTLyr1KjebvMLzjRcqxn85k0kyDWeeXOe/X+OhytFLe5w68vZuZ5SUmwp7rw43xuMZtxOtxbTDMQk+4Jqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w97WsQ8FXsvoldRrnKHkgxQE1zJRPB2NvFWUPdUkqeU=;
 b=lRaDzoRisHH9fuCgrJXu8r0PvW4VnKNezCAtCwkJ7LPF/y2B52/DT0AM3pw3SHh0JaCGc5vYSvvwPkjiuO5tzrm2eieGavcHG8br71frwL6cZXVDf9HSYeatYMJOKifiFT6Qz93vV3PTiGCixwwsMG7Z+I4cnp9XEObKqiXfppFC2YJujxeNv+sLk1Oj+YhqhRrhRWdAbLWnVYHXku6ZZdtYaM9a04Xf+Sh0xWfDTFzTC4SpbG8cEvlerT1JUlod5Yr/1URELPASFAiw1bOPkkslOeOcuRsdif6C0AEDzkPhDVtHUMzw6lFW7MTKqzHUzgz4gJxoo4ZKwQ6/bYX0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS3PR01MB8668.jpnprd01.prod.outlook.com (2603:1096:604:19a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:05:52 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 09:05:52 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoCAAKu4gIAEDL+AgABzfQCAAWh1gIAAEBYAgAMikIA=
Date:   Thu, 26 Oct 2023 09:05:52 +0000
Message-ID: <8f705223-6fde-4b29-880b-570349f40db8@fujitsu.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
 <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
In-Reply-To: <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS3PR01MB8668:EE_
x-ms-office365-filtering-correlation-id: f789a729-0d2b-465a-3b7f-08dbd602c178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6dZ/8RUddrCYwtztgSleFoY2Iq09HflAwFigBDN7kt0//fnoFtpH3PvXK+lcyteO1onZEepDAuuS7bFReXeNWVVPM40h55zNLvso85yEt1/U2rCqs6Kd00CPie5kpFxf7F2xVGIcmcpeIP0c++5yWKRdA+aS3dyOlsf7WiecrVlwChX9GiOp+VyScn5KxOrnwLYjV3tThPf98/iIvJ5yeXOuMcfQZJIBD636V3edoRfUgKBy6QkJ8K7NQ8PttYcX4y53X/23Xt/25Z9XMJu859YeXKbbA5gB/LjT+TAYX6OlSMgYVNzi2IKNYp5PyY0nrm7j5h78hUl/RPxkMhkPzBvLw7KT06WGNua13M0lgOMjolP9uT0//V370movQrwtI3J+4vL1c24HxeA4Cr2Lk60XYY7blooBjvxuYetaOTfHJiFhJCPiePkt4gszeIrKGGzGXsCXFwPlv/HUuBQJ53Vz9MJYDeKWX++umcSkCBAYyk7inOP2E6HOc5b/HSaLzj9tqmsNYvAzc4fd9oTiKfz2bKJbqbEZnQPnfei6M77Rhr9VUcV+fPhMk+utADCBHaBbUeIQUK/jBEy542bEy5CpwNs4CdaVYmfb3K9jpJaslMkdvHYuBVv4i62V46f5pZnrOq0mfhNJKdbqBcDjmZa3BNggR8E9Yt5FZvXxWsrex2ssSLOSGQJU01X5P5padOl/srKgvydtkJUsqYRTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(1590799021)(64100799003)(451199024)(186009)(1800799009)(5660300002)(38070700009)(4326008)(54906003)(4001150100001)(6506007)(53546011)(41300700001)(91956017)(66476007)(66446008)(66556008)(8676002)(8936002)(64756008)(66946007)(76116006)(966005)(6486002)(2906002)(478600001)(71200400001)(6512007)(45080400002)(26005)(2616005)(316002)(83380400001)(6916009)(31686004)(82960400001)(122000001)(38100700002)(66899024)(1580799018)(86362001)(31696002)(85182001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWdIUEFQa0RPQy9RajNsSFJhZmpFS1lockhVWjZTS05ZNHpyL3lvQmpLOTVr?=
 =?utf-8?B?Znh3cDZhRkdXZlJGRE9QM05pOG9DNEhxandUZWIzaE9RZ05yZTZXbU1DT0RK?=
 =?utf-8?B?VkF5ODY5QVRVNDkwZm5WNDQ4dEJGZzIxTUp0L3ovZE8reWt5Ry9WUFV4bFIv?=
 =?utf-8?B?WHI1Qm81NTFiRi9FdFlMc3o5TXI0eTNtUmhGWndxd2NKcXRHRi8xSUNaclkr?=
 =?utf-8?B?S2JXOGg5VVB3MWd4WjdEMnhyUnN3Y3NUcHhUSFp0TkJPKzdQYkZ5ejN5L0lG?=
 =?utf-8?B?dG5oS2haVTU5dW92cXA0a2xoTG94VHNIbjl0UWVDendLemZqSEFLQlh4Zysx?=
 =?utf-8?B?OUg3TlEvYXJEWEIzM2xpWnpRMGtQNDM0VnR5VCtJTkFFa2NUMXRTT3NtNnZx?=
 =?utf-8?B?KzdaaDA2M3B0cVhOeWNwSFJlUG5UT1JGVnhKdVZrZWEyUXh2ZTVnRkhrK1Ry?=
 =?utf-8?B?TDI1NlZZMktJRCtkQ2NIc0hWZ3h3b2hxa0J3bmhnRCtWSEwxQUZVNVhzOWFM?=
 =?utf-8?B?U3VFVnJWWnNuSXd1WUkwNjdDWXBEak9WcHFkWVd4dkMwd0M2eWNyaENVbnhV?=
 =?utf-8?B?b2RVemkrS1dNOUlrVnUxeEswemJQekJoL0ZXUWxrRUZFZ1oxMmdzZC9BbExM?=
 =?utf-8?B?VzJ1ajI1d28wdStudzJoeEhrellhYVRWNnBmTEdaUW9PR2xnVEVkaUo2VE14?=
 =?utf-8?B?V1NPOGN1dkYwdFhrM3hERlNza2V3aC80SSthUDltNkpZbXVTTkxYakluc0xT?=
 =?utf-8?B?dUZuQjZaVlExN0s0SWR5NmcrNW1GMlVjWmp1QllQNnYyWDBOSC83a015djVj?=
 =?utf-8?B?aWVYTzZNb1gvQzk0cFVtZ2Q3TkNiWVB3SjhqVTVnSHBva0Vqa0l3akJuU3pP?=
 =?utf-8?B?YVFUQUtFTmIzOEdXVTB0eHAzd3RkR24wU0VVdzFyc3NMNm4zaWp0OWR1azJh?=
 =?utf-8?B?WU9QMklBczBWMEhYVHhCUFBkQ093T2M1aUR0RGIzT3VoNDh0aU5mSnF2cDVG?=
 =?utf-8?B?VnRtbDU1dFRMTVhlclY2UzJ1RkVBd3o3a1Z2RHVWSVU2Z3A1U1Nnc1gxTHV5?=
 =?utf-8?B?TzV5MTZ1WDZxaU9lamJ1aXhXM3Q3RWFnd0hJMUN6cFZ4NTB0OWRacFpEc252?=
 =?utf-8?B?YzJJamZJZjYrWHkrNmZwNzVxSE14clMxVEh1QWk2ZnF0OS9DbjRCSXV3MGlW?=
 =?utf-8?B?NEs0SkF0c0lleVh2dFpMQmhvbm1Ed1lMWis4Z0ZOQUlyZkxYaUVncFlEa0xi?=
 =?utf-8?B?b3BsV3hMZUJGMFRCZEw5cmFvSERROFNCMG1QbENqaHRiTllsSWdMeG9ta0Er?=
 =?utf-8?B?bGhlTUMwQzFnUXRFV2N3NXU4MUZGMG8wMXkrYmt6am5iejdWaEhDblNhSXFT?=
 =?utf-8?B?R2Y0MXB0SytPdjhpMmRaRCtqZEFuMmc1SncvbmhNTWNsRDN6YnVtSnJ6WHpo?=
 =?utf-8?B?UVNkT2FCZEVTejNWTHhMdEtvcFlIYUMyNHFHQmszQ0lSMkxMTEhZS0Z3M01U?=
 =?utf-8?B?RHNJN1c3akE4eFdGQWhTbnBUWE9TS1BaNWZFMUJPVmhaSGZXQ1ZuUVVzNjla?=
 =?utf-8?B?YlMxakpVWk85L2R5a2kyc3RPVExtdUxqUlZIT0pCdS9DT2RBTlBrQjJBVDgv?=
 =?utf-8?B?ZHZCNXRBbVoyL3BiL3NnQU9OTjkyVXdIV2ZwMU4zNW9OYk02ang2UDJDQW9I?=
 =?utf-8?B?Qjcyb1kzOC9iLzNrdk1rT0hrdEhieE5hOHJqUm0wWWtNRXh5YmtSUFFoRkRi?=
 =?utf-8?B?eS9DRXRpWnhzTzhXaFRod0FmODhTMnVVY1I5OThtVERJN1htMDAxUk1oY2V2?=
 =?utf-8?B?bTR3MzRIY0hoMURPZXJCU1hqOWtoVHRBL1hUM1BDTkFCVlhuSE5qUFh5bGY1?=
 =?utf-8?B?MTVDbCtLc2dTaDVESzVlUU05Sm5vZDRraHo4MnY1ZW5NdmZQWEpVQmxFQ25I?=
 =?utf-8?B?TzJVRFFKZXByOXVLcjYzZjRiWlNHY1puS2Jzb2VuQjducURpSlJKMktqZTVp?=
 =?utf-8?B?VFJnQmMyYzlDcmhBNm9rMk4yMG95QXd5MUFuM3RFdWF5dkwzR3pCVzl1YS9h?=
 =?utf-8?B?UHl6RnJFZHU3ZzdTWUp3SFF1YTNndklHVDc1cllKVHhOSURGckxTL1Z2a0JY?=
 =?utf-8?B?SEJDdVh6aUdUYnhsc3JmbkU5TzNwYkxZckFTQUQyQWNuNVV0dEl1VlJzWS9E?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE2F5BEA1B7FE4EBF879DDFDE9D7CCE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aGx2UnhsaHJQZ3FEeWRnSm5OSCtpMkZHLytqYi8wTk5rd0ZRZUpUbGhlWi94?=
 =?utf-8?B?U2tidlhLYVNPRENrVkcyN25rK2ExcnNYYytsOTR3OWdFWmdrU0s4TUhYcHlU?=
 =?utf-8?B?R2lHZGl5WU1UOWIzRG5XUHg1dCt5SzFrWWlUaVJseEVzWDJydU44eUpQRzU4?=
 =?utf-8?B?VXFnejVrUXJlRHdkM3hkQ1FXRU12d2JVR1dVaEVQZU91NXlsVHpSbi9ua212?=
 =?utf-8?B?MkxzNUk2QzA3TU1jbXVTamNDMmg2REFvWHRJd3dxY2NtSUdVSjY3aFlxWEwy?=
 =?utf-8?B?YXhlcUdNOHNGZnFmbHdjMlBDZDB6SnZmL1NWcVFzeDlnZEg3NWJKN2xEQkdP?=
 =?utf-8?B?QU9iclpqL014MFVuTDFYM0t2MUlvbWpDMVJDU3B4OFlpM3ZGdFFhOER6Mk5j?=
 =?utf-8?B?YkdVVUptVzAyMi8rT3BCbmtId3dVMFV2Tzlvd1pDYVUrRTNxOUhhLzU5djNk?=
 =?utf-8?B?SDViTXBNTkdvNFh1Z2g2em9kNjlTa0cwUzdUSmRvMU5yYXkwVzZzKzNCb2ZI?=
 =?utf-8?B?RXBrMHZWL2l2SVdGVVJEd1IxZmFyN3BvOUo4c0FzaGI5N25rLzl6ZG9Uc3pN?=
 =?utf-8?B?WkxWVWZFRFRFK2R3Y2xTYnhjM04wMGUxalV4NDhSdkJaRWY5c2o4NzVabkxK?=
 =?utf-8?B?K0dSVDBRNGdFRXlyVWNET016eFRQSDNSUS9JZGpQYlN2RlQ2SVdIbDZOb21i?=
 =?utf-8?B?RlBPQlFKaFZyckV2RldGenoxWlF4WC9DRHFQaFBHZmxDM0MwZkJFbkorN21F?=
 =?utf-8?B?TGlMS0pEbHI5eUphV0drclRzWkFnZ3hURStLU2piOER1eDlVUTZLblozWmhq?=
 =?utf-8?B?QW1sK0RURXpCMklxRmx1VXJqbkNUR1RtV1FQTXBnSEJxS3d0SlN1cjJ4bGlw?=
 =?utf-8?B?YlBYU3ZOSDRKS1AvMW0rMnl0VU9ueUQxRDJjOGY0ODgzYUVIM3haNHN5Ukds?=
 =?utf-8?B?czBacGRvK2ZGQldxWFRFdkFNQXpqSEd5dEJRem8wRFRKeTljMGtIemRDOTBh?=
 =?utf-8?B?RnJReUc5dEZWMC9zY0xMMzUzRHdoOUErY0ZtN05qMjRobXQweXZNek5sWGEv?=
 =?utf-8?B?c01OU0FEblN6S0IxY3JqaitDbG9nMHg3bi9GMVpLV1ppWmJ5SVJqTVhqZW1D?=
 =?utf-8?B?RDRFNi93K0RGd0lUdHQrZUcvaWZDeUtJSko1ZDJrT2NqbkdLMDZ1OFJ0RjdF?=
 =?utf-8?B?VERBUXpqd0RjS09mWVQvQlJRK1JUWmNCeHRlQ2k4NXA4WTg3U3lKbk9UN29t?=
 =?utf-8?B?dHlFZmlsWlF2dnpXYytUVUdPWlRBLytYWWFUK1ZUSkVKNFFXQT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f789a729-0d2b-465a-3b7f-08dbd602c178
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 09:05:52.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGk9gKooEMAAtWtsyUkyHIUEyeWt44VylhNPmFtph1z3G37N5BF49i/5FLPL1kugG/6hozSpAvLYAyBohwPZww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlIHJvb3QgY2F1c2UgaXMgdGhhdA0KDQpyeGU6cnhlX3NldF9wYWdlKCkgZ2V0cyB3cm9uZyB3
aGVuIG1yLnBhZ2Vfc2l6ZSAhPSBQQUdFX1NJWkUgd2hlcmUgaXQgb25seSBzdG9yZXMgdGhlICpw
YWdlIHRvIHhhcnJheS4NClNvIHRoZSBvZmZzZXQgd2lsbCBnZXQgbG9zdC4NCg0KRm9yIGV4YW1w
bGUsDQpzdG9yZSBwcm9jZXNzOg0KcGFnZV9zaXplID0gMHgxMDAwOw0KUEFHRV9TSVpFID0gMHgx
MDAwMDsNCnZhMCA9IDB4ZmZmZjAwMDAyMDY1MTAwMDsNCnBhZ2Vfb2Zmc2V0ID0gMCA9IHZhICYg
KHBhZ2Vfc2l6ZSAtIDEpOw0KcGFnZSA9IHZhX3RvX3BhZ2UodmEpOw0KeGFfc3RvcmUoJm1yLT5w
YWdlX2xpc3QsIG1yLT5uYnVmLCBwYWdlLCBHRlBfS0VSTkVMKTsNCg0KbG9hZF9wcm9jZXNzOg0K
cGFnZSA9IHhhX2xvYWQoJm1yLT5wYWdlX2xpc3QsIGluZGV4KTsNCnBhZ2VfdmEgPSBrbWFwX2xv
Y2FsX3BhZ2UocGFnZSkgLS0+IGl0IG11c3QgYmUgYSBQQUdFX1NJWkUgYWxpZ24gdmFsdWUsIGFz
c3VtZSBpdCBhcyAweGZmZmYwMDAwMjA2NTAwMDANCnZhMSA9IHBhZ2VfdmEgKyBwYWdlX29mZnNl
dCA9IDB4ZmZmZjAwMDAyMDY1MDAwMCArIDAgPSAweGZmZmYwMDAwMjA2NTAwMDA7DQoNCk9idmlv
dXNseSwgKnZhMCAhPSB2YTEqLCBwYWdlX29mZnNldCBnZXQgbG9zdC4NCg0KDQpIb3cgdG8gZml4
Og0KLSByZXZlcnQgMzI1YTdlYjg1MTk5ICgiUkRNQS9yeGU6IENsZWFudXAgcGFnZSB2YXJpYWJs
ZXMgaW4gcnhlX21yLmMiKQ0KLSBkb24ndCBhbGxvdyB1bHAgcmVnaXN0ZXJpbmcgbXIucGFnZV9z
aXplICE9IFBBR0VfU0laRSA/DQoNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQpPbiAyNC8xMC8y
MDIzIDE3OjEzLCBMaSBaaGlqaWFuIHdyb3RlOg0KPiANCj4gDQo+IE9uIDI0LzEwLzIwMjMgMTY6
MTUsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAyMy8xMC8yMDIz
IDE4OjQ1LCBZaSBaaGFuZyB3cm90ZToNCj4+PiBPbiBNb24sIE9jdCAyMywgMjAyMyBhdCAxMTo1
MuKAr0FNIFpoaWppYW4gTGkgKEZ1aml0c3UpDQo+Pj4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4g
d3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDIwLzEwLzIwMjMgMjI6MDEsIEphc29u
IEd1bnRob3JwZSB3cm90ZToNCj4+Pj4+IE9uIEZyaSwgT2N0IDIwLCAyMDIzIGF0IDAzOjQ3OjA1
QU0gKzAwMDAsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4+Pj4+IENDIEJhcnQNCj4+
Pj4+Pg0KPj4+Pj4+IE9uIDEzLzEwLzIwMjMgMjA6MDEsIERhaXN1a2UgTWF0c3VkYSAoRnVqaXRz
dSkgd3JvdGU6DQo+Pj4+Pj4+IE9uIEZyaSwgT2N0IDEzLCAyMDIzIDEwOjE4IEFNIFpodSBZYW5q
dW4gd3JvdGU6DQo+Pj4+Pj4+PiBGcm9tOiBaaHUgWWFuanVuPHlhbmp1bi56aHVAbGludXguZGV2
Pg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoZSBwYWdlX3NpemUgb2YgbXIgaXMgc2V0IGluIGluZmlu
aWJhbmQgY29yZSBvcmlnaW5hbGx5LiBJbiB0aGUgY29tbWl0DQo+Pj4+Pj4+PiAzMjVhN2ViODUx
OTkgKCJSRE1BL3J4ZTogQ2xlYW51cCBwYWdlIHZhcmlhYmxlcyBpbiByeGVfbXIuYyIpLCB0aGUN
Cj4+Pj4+Pj4+IHBhZ2Vfc2l6ZSBpcyBhbHNvIHNldC4gU29tZXRpbWUgdGhpcyB3aWxsIGNhdXNl
IGNvbmZsaWN0Lg0KPj4+Pj4+PiBJIGFwcHJlY2lhdGUgeW91ciBwcm9tcHQgYWN0aW9uLCBidXQg
SSBkbyBub3QgdGhpbmsgdGhpcyBjb21taXQgZGVhbHMgd2l0aA0KPj4+Pj4+PiB0aGUgcm9vdCBj
YXVzZS4gSSBhZ3JlZSB0aGF0IHRoZSBwcm9ibGVtIGxpZXMgaW4gcnhlIGRyaXZlciwgYnV0IHdo
YXQgaXMgd3JvbmcNCj4+Pj4+Pj4gd2l0aCBhc3NpZ25pbmcgYWN0dWFsIHBhZ2Ugc2l6ZSB0byBp
Ym1yLnBhZ2Vfc2l6ZT8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSU1PLCB0aGUgcHJvYmxlbSBjb21lcyBm
cm9tIHRoZSBkZXZpY2UgYXR0cmlidXRlIG9mIHJ4ZSBkcml2ZXIsIHdoaWNoIGlzIHVzZWQNCj4+
Pj4+Pj4gaW4gdWxwL3NycCBsYXllciB0byBjYWxjdWxhdGUgdGhlIHBhZ2Vfc2l6ZS4NCj4+Pj4+
Pj4gPT09PT0NCj4+Pj4+Pj4gc3RhdGljIGludCBzcnBfYWRkX29uZShzdHJ1Y3QgaWJfZGV2aWNl
ICpkZXZpY2UpDQo+Pj4+Pj4+IHsNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3Qgc3JwX2RldmljZSAqc3JwX2RldjsNCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgaWJfZGV2aWNlX2F0dHIgKmF0dHIgPSAmZGV2aWNlLT5hdHRyczsNCj4+Pj4+Pj4gPC4u
Lj4NCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBVc2UgdGhlIHNtYWxsZXN0IHBhZ2Ugc2l6ZSBzdXBwb3J0ZWQgYnkg
dGhlIEhDQSwgZG93biB0byBhDQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG1p
bmltdW0gb2YgNDA5NiBieXRlcy4gV2UncmUgdW5saWtlbHkgdG8gYnVpbGQgbGFyZ2Ugc2dsaXN0
cw0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBvdXQgb2Ygc21hbGxlciBlbnRy
aWVzLg0KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtcl9wYWdlX3NoaWZ0wqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBtYXgo
MTIsIGZmcyhhdHRyLT5wYWdlX3NpemVfY2FwKSAtIDEpOw0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+
PiBZb3UgbGlnaHQgbWUgdXAuDQo+Pj4+Pj4gUlhFIHByb3ZpZGVzIGF0dHIucGFnZV9zaXplX2Nh
cChSWEVfUEFHRV9TSVpFX0NBUCkgd2hpY2ggbWVhbnMgaXQgY2FuIHN1cHBvcnQgNEstMkcgcGFn
ZSBzaXplDQo+Pj4+Pg0KPj4+Pj4gVGhhdCBkb2Vzbid0IHNlZW0gcmlnaHQgZXZlbiBpbiBjb25j
ZXB0Lj4NCj4+Pj4+IEkgdGhpbmsgdGhlIG11bHRpLXNpemUgc3VwcG9ydCBpbiB0aGUgbmV3IHhh
cnJheSBjb2RlIGRvZXMgbm90IHdvcmsNCj4+Pj4+IHJpZ2h0LCBqdXN0IGxvb2tpbmcgYXQgaXQg
bWFrZXMgbWUgdGhpbmsgaXQgZG9lcyBub3Qgd29yayByaWdodC4gSXQNCj4+Pj4+IGxvb2tzIGxp
a2UgaXQgY2FuIGRvIGxlc3MgdGhhbiBQQUdFX1NJWkUgYnV0IG1vcmUgdGhhbiBQQUdFX1NJWkUg
d2lsbA0KPj4+Pj4gZXhwbG9kZSBiZWNhdXNlIGttYXBfbG9jYWxfcGFnZSgpIGRvZXMgb25seSA0
Sy4NCj4+Pj4+DQo+Pj4+PiBJZiBSWEVfUEFHRV9TSVpFX0NBUCA9PSBQQUdFX1NJWkXCoCB3aWxs
IGV2ZXJ5dGhpbmcgd29yaz8NCj4+Pj4+DQo+Pj4+DQo+Pj4+IFllYWgsIHRoaXMgc2hvdWxkIHdv
cmsoZXZlbiB0aG91Z2ggaSBvbmx5IHZlcmlmaWVkIGhhcmRjb2RpbmcgbXJfcGFnZV9zaGlmdCB0
byBQQUdFX1NISUZUKS4NCj4+Pg0KPj4+IEhpIFpoaWppYW4NCj4+Pg0KPj4+IERpZCB5b3UgdHJ5
IGJsa3Rlc3RzIG52bWUvcmRtYSB1c2VfcnhlIG9uIHlvdXIgZW52aXJvbm1lbnQsIGl0IHN0aWxs
DQo+Pj4gZmFpbGVkIG9uIG15IHNpZGUuDQo+Pj4NCj4+DQo+PiBUaGFua3MgZm9yIHlvdXIgdGVz
dGluZy4NCj4+IEkganVzdCBkaWQgdGhhdCwgaXQgYWxzbyBmYWlsZWQgaW4gbXkgZW52aXJvbm1l
bnQuIEFmdGVyIGEgZ2xhbmNlIGRlYnVnLCBJIGZvdW5kIHRoZXJlIGFyZQ0KPj4gb3RoZXIgcGxh
Y2VzIHN0aWxsIHJlZ2lzdGVyZWQgNEsgTVIuIEkgd2lsbCBkaWcgaW50byBpdCBsYXRlci4NCj4g
DQo+IA0KPiBudm1lIGludGVuZCB0byByZWdpc3RlciA0SyBtciwgYnV0IGl0IHNob3VsZCB3b3Jr
IElNTywgYXQgbGVhc3QgdGhlIFJYRSBoYXZlIGhhbmRsZWQgaXQgY29ycmVjdGx5Lg0KPiANCj4g
DQo+IDEyOTMgc3RhdGljIGludCBudm1lX3JkbWFfbWFwX3NnX2ZyKHN0cnVjdCBudm1lX3JkbWFf
cXVldWUgKnF1ZXVlLA0KPiAxMjk0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IG52bWVfcmRtYV9yZXF1ZXN0ICpyZXEsIHN0cnVjdCBudm1lX2NvbW1hbmQgKmMsDQo+IDEy
OTXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgY291bnQpDQo+IDEyOTYgew0K
PiAxMjk3wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9rZXllZF9zZ2xfZGVzYyAqc2cgPSAm
Yy0+Y29tbW9uLmRwdHIua3NnbDsNCj4gMTI5OMKgwqDCoMKgwqDCoMKgwqAgaW50IG5yOw0KPiAx
Mjk5DQo+IDEzMDDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+bXIgPSBpYl9tcl9wb29sX2dldChxdWV1
ZS0+cXAsICZxdWV1ZS0+cXAtPnJkbWFfbXJzKTsNCj4gMTMwMcKgwqDCoMKgwqDCoMKgwqAgaWYg
KFdBUk5fT05fT05DRSghcmVxLT5tcikpDQo+IDEzMDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVBR0FJTjsNCj4gMTMwMw0KPiAxMzA0wqDCoMKgwqDCoMKgwqDCoCAv
Kg0KPiAxMzA1wqDCoMKgwqDCoMKgwqDCoMKgICogQWxpZ24gdGhlIE1SIHRvIGEgNEsgcGFnZSBz
aXplIHRvIG1hdGNoIHRoZSBjdHJsIHBhZ2Ugc2l6ZSBhbmQNCj4gMTMwNsKgwqDCoMKgwqDCoMKg
wqDCoCAqIHRoZSBibG9jayB2aXJ0dWFsIGJvdW5kYXJ5Lg0KPiAxMzA3wqDCoMKgwqDCoMKgwqDC
oMKgICovDQo+IDEzMDjCoMKgwqDCoMKgwqDCoMKgIG5yID0gaWJfbWFwX21yX3NnKHJlcS0+bXIs
IHJlcS0+ZGF0YV9zZ2wuc2dfdGFibGUuc2dsLCBjb3VudCwgTlVMTCwNCj4gMTMwOcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU1pfNEspOw0KPiAN
Cj4gDQo+IEFueXdheSwgaSB3aWxsIGdvIGFoZWFkLiBpZiB5b3UgaGF2ZSBhbnkgdGhvdWdodCwg
cGxlYXNlIGxldCBtZSBrbm93Lg0KPiANCj4gDQo+IA0KPj4NCj4+IFRoYW5rcw0KPj4gWmhpamlh
bg0KPj4NCj4+DQo+Pg0KPj4NCj4+PiAjIHVzZV9yeGU9MSBudm1lX3RydHlwZT1yZG1hwqAgLi9j
aGVjayBudm1lLzAwMw0KPj4+IG52bWUvMDAzICh0ZXN0IGlmIHdlJ3JlIHNlbmRpbmcga2VlcC1h
bGl2ZXMgdG8gYSBkaXNjb3ZlcnkgY29udHJvbGxlcikgW2ZhaWxlZF0NCj4+PiDCoMKgwqDCoMKg
IHJ1bnRpbWXCoCAxMi4xNzlzwqAgLi4uwqAgMTEuOTQxcw0KPj4+IMKgwqDCoMKgwqAgLS0tIHRl
c3RzL252bWUvMDAzLm91dCAyMDIzLTEwLTIyIDEwOjU0OjQzLjA0MTc0OTUzNyAtMDQwMA0KPj4+
IMKgwqDCoMKgwqAgKysrIC9yb290L2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvbnZtZS8wMDMub3V0
LmJhZCAyMDIzLTEwLTIzDQo+Pj4gMDU6NTI6MjcuODgyNzU5MTY4IC0wNDAwDQo+Pj4gwqDCoMKg
wqDCoCBAQCAtMSwzICsxLDMgQEANCj4+PiDCoMKgwqDCoMKgwqAgUnVubmluZyBudm1lLzAwMw0K
Pj4+IMKgwqDCoMKgwqAgLU5RTjpucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3Zlcnkg
ZGlzY29ubmVjdGVkIDEgY29udHJvbGxlcihzKQ0KPj4+IMKgwqDCoMKgwqAgK05RTjpucW4uMjAx
NC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkgZGlzY29ubmVjdGVkIDAgY29udHJvbGxlcihz
KQ0KPj4+IMKgwqDCoMKgwqDCoCBUZXN0IGNvbXBsZXRlDQo+Pj4NCj4+PiBbIDcwMzMuNDMxOTEw
XSByZG1hX3J4ZTogbG9hZGVkDQo+Pj4gWyA3MDMzLjQ1NjM0MV0gcnVuIGJsa3Rlc3RzIG52bWUv
MDAzIGF0IDIwMjMtMTAtMjMgMDU6NTI6MTUNCj4+PiBbIDcwMzMuNTAyMzA2XSAobnVsbCk6IHJ4
ZV9zZXRfbXR1OiBTZXQgbXR1IHRvIDEwMjQNCj4+PiBbIDcwMzMuNTEwOTY5XSBpbmZpbmliYW5k
IGVuUDJwMXMwdjBfcnhlOiBzZXQgYWN0aXZlDQo+Pj4gWyA3MDMzLjUxMDk4MF0gaW5maW5pYmFu
ZCBlblAycDFzMHYwX3J4ZTogYWRkZWQgZW5QMnAxczB2MA0KPj4+IFsgNzAzMy41NDkzMDFdIGxv
b3AwOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDIwOTcxNTINCj4+PiBbIDcw
MzMuNTU2OTY2XSBudm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vi
c3lzdGVtLTENCj4+PiBbIDcwMzMuNTY2NzExXSBudm1ldF9yZG1hOiBlbmFibGluZyBwb3J0IDAg
KDEwLjE5LjI0MC44MTo0NDIwKQ0KPj4+IFsgNzAzMy41ODg2MDVdIG52bWV0OiBjb25uZWN0IGF0
dGVtcHQgZm9yIGludmFsaWQgY29udHJvbGxlciBJRCAweDgwOA0KPj4+IFsgNzAzMy41OTQ5MDld
IG52bWUgbnZtZTA6IENvbm5lY3QgSW52YWxpZCBEYXRhIFBhcmFtZXRlciwgY250bGlkOiA2NTUz
NQ0KPj4+IFsgNzAzMy42MDE1MDRdIG52bWUgbnZtZTA6IGZhaWxlZCB0byBjb25uZWN0IHF1ZXVl
OiAwIHJldD0xNjc3MA0KPj4+IFsgNzA0Ni4zMTc4NjFdIHJkbWFfcnhlOiB1bmxvYWRlZA0KPj4+
DQo+Pj4NCj4+Pj4NCj4+Pj4+Pj4gaW1wb3J0IGN0eXBlcw0KPj4+Pj4+PiBsaWJjID0gY3R5cGVz
LmNkbGwuTG9hZExpYnJhcnkoJ2xpYmMuc28uNicpDQo+Pj4+Pj4+IGhleCg2NTUzNikNCj4+Pj4g
JzB4MTAwMDAnDQo+Pj4+Pj4+IGxpYmMuZmZzKDB4MTAwMDApIC0gMQ0KPj4+PiAxNg0KPj4+Pj4+
PiAxIDw8IDE2DQo+Pj4+IDY1NTM2DQo+Pj4+DQo+Pj4+IHNvDQo+Pj4+IG1yX3BhZ2Vfc2hpZnQg
PSBtYXgoMTIsIGZmcyhhdHRyLT5wYWdlX3NpemVfY2FwKSAtIDEpID0gbWF4KDEyLCAxNikgPSAx
NjsNCj4+Pj4NCj4+Pj4NCj4+Pj4gU28gSSB0aGluayBEYWlzdWtlJ3MgcGF0Y2ggc2hvdWxkIHdv
cmsgYXMgd2VsbC4NCj4+Pj4NCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmRt
YS9PUzNQUjAxTUI5ODY1MkIyRUMyRTg1REFFQzZEREU0ODRFNUQyQUBPUzNQUjAxTUI5ODY1Lmpw
bnByZDAxLnByb2Qub3V0bG9vay5jb20vVC8jbWQxMzMwNjA0MTRmMGJhNmEzZGJhZjdiNGFkMjM3
NGM4YTM0N2NmZDENCj4+Pj4NCj4+Pj4NCj4+Pj4+IEphc29uDQo+Pj4NCj4+Pg0KPj4+DQo+Pj4g
LS0gDQo+Pj4gQmVzdCBSZWdhcmRzLA0KPj4+IMKgwqDCoCBZaSBaaGFuZw==
