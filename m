Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12857D49BF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjJXIQG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjJXIQA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 04:16:00 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4010C6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 01:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698135358; x=1729671358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pXEr16UVd8vsxKnrV9WUlFMHMVMe1j0ZONEQ2mR6i6Q=;
  b=J10/u51EQvvJDzMAyMN0slR9NshufzaGcRROco5C6i/zFbMXB+A7vWYB
   egP0rtHGpgn+Q0dk1r1DpSx53OwsiwzjSfYFmWv7tSAwq8Jb8qZYKmuKC
   /8ecooBgfHvg6J3gCz1ZWH7O6umR6nvWDIQKWbZMRr4D7LVhgfnAY8hUI
   q9hietQf3rG1bI/hAGN4Sew4SKphGLy8+484uZkEWhru8+VMV2bzsbAk9
   z3qggd2kAPFSdp0vcBhbBMHsqFfIMWQK0Rk+pURdcacx+isqcE0kZd5IP
   2LVUIdaia8VM+UPnMNt/WTybkGfA3RA/3XuJ3uBC8ifS8WNQchtuX7MCx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="100490702"
X-IronPort-AV: E=Sophos;i="6.03,247,1694703600"; 
   d="scan'208";a="100490702"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 17:15:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDZUCGo0/sFGTk8b/k8sV5Qu2VnqSRro/bnJNbixbbv2v7v0vewWIWnD7pSYPaZGTc1ZKdpLXr9SqSv0NwO32Ib50wAQK7NAdRCTXVvyWIrFg7VLFvogsXkk/BBcC7pUl0Zpw6l5VJkI3qMVhld9znlguVtPg0+ZuvA0HxRL3kBTea+ldP5Kig82Nb/E25wX5gKI2Tly5oW7drEc6614xX/KLc1dgsucExlGClV5rEkCeh8z60xnQUKLPi7unQXcEfWXRXa16y2T/oiAV6Z3oPUrctDtX/vkYV7Vxp3B4Lnjc08CEQimUxrMkJ3W+w1KasmgUKBhxlLH8XKlb69miA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXEr16UVd8vsxKnrV9WUlFMHMVMe1j0ZONEQ2mR6i6Q=;
 b=Eoz9w2X+vB9NZa5LiEV6NXKa+RzYEEAOdQ06KXqmxxjjye3pXchr4q2IgPLdIOFl7e6rWdVOTGF5II2mRyrmUziPRwXu9F4w2+s8KHI925mQXHN9KWL7pcmTnvZO2aU/VFu5PI3CmZELzBns7LR1k6oC5rJE53WxbPqN9giyS2aFEbYNEwEr9aDK9wTfuMriwuPdG9Z8jw7u+uedAruFgO9V1rAOTTcwKjsOvmdMrO5sKW/KewPwxmw7m4NYLR8Ipo98gX7L6KStgqyz7eGGIWZWsj5TLaOWR6/giVlsAH0cL8Ng8pGPQOITpzGrvvz77A+ChoY5d31utYI4fHTXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS0PR01MB5923.jpnprd01.prod.outlook.com (2603:1096:604:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 08:15:49 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6907.028; Tue, 24 Oct 2023
 08:15:49 +0000
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
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoCAAKu4gIAEDL+AgABzfQCAAWh1gA==
Date:   Tue, 24 Oct 2023 08:15:48 +0000
Message-ID: <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
In-Reply-To: <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS0PR01MB5923:EE_
x-ms-office365-filtering-correlation-id: fdac4ff2-49b1-41f6-69bb-08dbd4696e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVZ4j//Y98usBO3rXsMwpVuEBIeyFrRCXUxWfBatMjt4qg3ctBbWHHAWoCmgujBxI9JR3MD0nqmgh55+LWkA0r3K6SYGuEVo85W0l0KAY/M5IO6GM1MO2uD2TkUpBxb9+B8btBWSeTmDdIpsiAk2oVAwVPzx027JQ6+dMj01og+Ap9TzKkpbxfFb2VabDKMy40keyxb/aKlTqFaQAuYttXmcKnjcWCWLTPKGI+jQv8fE9RQ4zT2K5vOJJ90o9Wo3T4vT9sMK4l78+5uZHgRvuBpaxmX4za94ujLqkkp65kyjXO1ysS7XgtLmQRAAkigDYdXDcBP1E6hoE97jVrE/TesfDBgJmuqv3/CBcrO5aGWpxYtvXDhmrP2bq+/Yj9xDLzou8452CxIBs/fqWRxeMFlro2vXHcw1Xbr5gGOALVOOOEjY8nwd+M+thL7gZNWpU2r9nnBHQq3lkrT8iv+g/IpHsPTCryaRScu1fpd5wAoWqp9wYsFVLJgDG/iqKjbRZfLwdVc55J3bmIeY3bIqlnypOltqj6+2ZcglQDzSehr6kcz/nxRxaG5Tf8HnsgE+lZnC2xGxou2NbcHCw0wNOIdW32+nj+yzbWYXZX7GO2MgB8XHVUrYa5cdgybwWwWkd0HkI6GbO2P9jnpL7KWJetlVaJshdiUJDWYJjfK6vDYDbcl0YNf/VPJWdA7AEv+4skWkr51UXYKkMgu2k0i4vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(1590799021)(451199024)(64100799003)(186009)(26005)(38070700009)(31686004)(66899024)(4001150100001)(1580799018)(38100700002)(2906002)(41300700001)(86362001)(5660300002)(31696002)(36756003)(4326008)(8936002)(8676002)(6506007)(64756008)(76116006)(91956017)(478600001)(71200400001)(2616005)(122000001)(316002)(66476007)(82960400001)(66556008)(66946007)(6916009)(66446008)(54906003)(83380400001)(45080400002)(966005)(6512007)(6486002)(85182001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0R6MmRVaUhrY2pVT2J6Wk1DeVBiOUQrZnl3a2xveHlMY0RGNnZBNVhLYnB3?=
 =?utf-8?B?MWhKSmRKWlZmNjhKMnN0aFJRNDQrU0dGNWFRUlBsYk1rVzJnT2EvNm1CR3A5?=
 =?utf-8?B?Sld5Zk9VMFlSUHlZQlZBTlR0bjR6aWVDVko1VUhwL2dBTnhDby9JZmxZZkMy?=
 =?utf-8?B?SkRzNUltaEllTDhrNXVWTGZKY3A5ZDdRcnBQQU5aQXphaUZrTUlkdk1wZlBq?=
 =?utf-8?B?Rk9RcC92VVhIdGU4cWUyZTV6WDJtbXJQdVpyQWowYnI1K2NDa0c2bzVhQkFu?=
 =?utf-8?B?aXN2TjVBTWlUY1M3RW51dFZ6K0hSazVtY3BlWm1BZ1VTL1VlNjJZbEI1V0xV?=
 =?utf-8?B?UmtTSWFhWlM5WmxIOG8ydzBaZnhVMWVTVDNKYjB3d1hTRzNtN0l0OFRTSElX?=
 =?utf-8?B?TlFaVldDVEkrck5HVEZKSkxNUTFIQlI0dFV5dU1HNTNRNUsySk4rRys2am1L?=
 =?utf-8?B?OVhmSmdkY05JemZKaWxDR2VEQ2pHbU9OOGQ5MTV0YXg3MER0RCtPaGtLeVNq?=
 =?utf-8?B?eCtpT1hOZ0x1WVppYTdrMWpzVE5ZZkR1UlYxelJCZjAyS0VFTjFFOTFKakJl?=
 =?utf-8?B?SS9WWEJLalhNZ2N3dnNlZEtKWTc0NThnK1VFbDExU0pFOVQ5aXhCVmIwcnFO?=
 =?utf-8?B?VkkxN2o5TFNxNDE4ZDdFNmhPeGdXa3prWDZvbDFXNnhVRTBRNTlUc1V2OXVJ?=
 =?utf-8?B?YVVsR0xvdUVzSjRoenhRSHV5SnNwQkpxZkhpdTVJWGo4UXJXaU1PKzlpdXZS?=
 =?utf-8?B?RjA3RjBiYVJRK1EwTXFIUW9FQ3NYR1RoVW5WLzV5c3Z3STBmaXdlQno1b25Z?=
 =?utf-8?B?MS9JMk9pdkdvV2luNUhVN0xBV1JjTkh2K2owSVNGQXhVb1JKeCtseWwxK2ZK?=
 =?utf-8?B?RlhqY2l4QmE1TGpBVmkwUWJxV09GV2RJWlQ2YUR5TERMUGpOQ1doQlptUVpz?=
 =?utf-8?B?U2c1cEtDMkdXUkFRNE54M3BYODNqaUxtT2VLY3IvL0NqTDFCNDVzZU01YlYv?=
 =?utf-8?B?Uk9UaEphV29JVUs1TXpaUVRaQlZkbzgrVng1QmxndytWU2dEV1FwblhZUUc4?=
 =?utf-8?B?K0k4bDZqUVRpeWJNYUdQTllTRnpnbzBEVWM5bUl1MWJKNDc4UUNacGJQMGkr?=
 =?utf-8?B?M0syNUVXa0VkZFFjdWF4ZWp1ejRRVkFyWjA5SVJ5Y0pkUzZpcllSYzBaRVdp?=
 =?utf-8?B?KzZIMWZyWS9FdjhJV2hUc1g4Z1luMnBrM0N2QUNLWExSQVZVNzJiVGZic3Zi?=
 =?utf-8?B?NXlDc1pybjVxNFowcC81NDA3b1E2NklVSVl6YzdvcEJocVMzamdUUGN5Nzk0?=
 =?utf-8?B?cEVrWFRyWHZJMUo4djc2dytQT2pYdlNSckp0UW1CVUo0R0xkcFJyNlEwOGIw?=
 =?utf-8?B?OHlwYkZHemk0QjdRcE84ajVHdXl1TnhlUFlTZ3VEWmE3cUk3MVNFeFEzaERI?=
 =?utf-8?B?cjFGeEs2bUFCaVBCSFFnRWhKdXpmakR6ZVBBTmZqeUEyN21odzZ6NmtzTGhC?=
 =?utf-8?B?dzVTSFprVC8raWF5TW5oamloenphTlJTaG9veC9xY1VxaDZEdk53NTRWNk9Z?=
 =?utf-8?B?VzVvVStvN0hWeEFNb3ltUjF5R3BCck42TzZxU3ZJc29jK09ZWVlWNnExWWdV?=
 =?utf-8?B?Zmd4SkU2RHFmVjhBUDNiNmhxcnY5czBXNCtmTzVLOUdnaFdsMGYrUjlyc1A1?=
 =?utf-8?B?a1JpQm5oZ3NXMjc2MFdYSjNRRlhrcHJtdk8vcmZ6TWFOSklEZU9jQ1ZjeENw?=
 =?utf-8?B?SnVmMjBDMDc4RThOd25BeEQzQTFvWkp2eFkvTmRDbGRxOFFRVU9sOEh6Rm40?=
 =?utf-8?B?cXdJd1BaU01TYzc3TlBWY0ZSWWhHUUVNWnJFek9WYk9rR2JLdW9CSU1EMmU2?=
 =?utf-8?B?N2d4NmQ0cTR6d0NReGFGU2VBNFVZbm1PYTdacGN3L21GTmROTDFJMlorSmIx?=
 =?utf-8?B?WkI4NCtPVzVPVkZ2NTZmRVpQOE1TNXJvSU9vRmlTdTFXTE9nUDNEemxsYjg4?=
 =?utf-8?B?VFBPNmJsRlRxdXR4djM1QWRsUms1VGZyUlVQc3QvRHlqM2MwcGZyWnNuR0t0?=
 =?utf-8?B?VXV5UjMzNmdESGJ5NTBVcnlTTk9vN1Rwb2tqQ2lFK2NGZVVMdFVzVXBXREw2?=
 =?utf-8?B?VzZ6c1hNODQ5bHgycWJpVjc3MVQzOXlNQzdXaG5GM2h4RTZveHVGanhsUjJT?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B37AF8CC44BFB74CA4F5A7847821C11F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NTdXZUVoN1pCblJ5SlIyZ0RpMkdKVG5EQlNXSUNJRnVnbXBReEZOMERkd1k2?=
 =?utf-8?B?RUJ6dUJuSGZ2aG1hYzRnSENQR1lrQkExL0tXSjI0c2JYU0VZNTFTWWpidFFX?=
 =?utf-8?B?Tm9WcUh4S0FPcWNERkQyeDZ1bFhyWlp4ZjNWT09oUHZoVTVad2ZDQWw2RFE3?=
 =?utf-8?B?Z0MwTm9zQkFGY0F3S2pCZWZ6VWxVL3FDc3FSNWtjckFQYUZkdmFvWFBmaUVl?=
 =?utf-8?B?OHVzWGhVVHJ2eGJLUDJaY2NCbkc0QzZ1eVdGQ2ZINnlQc0hvQ3FFaGR5ekFj?=
 =?utf-8?B?Z2k4YTlZRnN2Q3NtdFlqb2N3NUVkMjd2dzVBRDJ3VTFKUHl1OFF6Zm96cFE4?=
 =?utf-8?B?SWdvdDJ2Um5QT0hXMDJWUVRaWldCOFIzbmk2REtqRW1ZeFBoR2lkYnczaTRQ?=
 =?utf-8?B?K1hCNFZ0b2o4cVltanprZGFKRXVwRmlKNVhSUWZKMlBlUU1UVjVIc0ZUNzRZ?=
 =?utf-8?B?LzltNmp6K0hKRTFnSStVblhPcnNtaEQxcEpBZ1lKdSs2NUY1WGxDRkZFeGVk?=
 =?utf-8?B?eFduKzR6UmlOaWtqS0VXNlkrM1lYYnFZbmxlVnIrdW5aM2hCVjFvYksxbnJC?=
 =?utf-8?B?ZHFHN1V3VmdyV1puSG1nZVlBQWplY0pra2kxVHAzaUZoQ2UzSllrWCtBTk05?=
 =?utf-8?B?d2lMdVlCc3c5V2NHTDBlN210bWRlU0tuVEk5eUpkMjZwUjNvZW42VCtLZk8w?=
 =?utf-8?B?VGZITXdYNlFkVVEwTEwzL25XdWlqdmZDVGJXWER0UGlQU2RJWHJIWUZlbW1l?=
 =?utf-8?B?ZEtreG5YVUVFdi94aEVRd0xQUXdaYWcvUVJZeG9UMUNGTVgwSTg0clhXWXVs?=
 =?utf-8?B?WnF5UStRdS9vbitNYWQvZE51cGpDYnRzWTdDK3lnVEpDQWIvQkZtamZHc2o5?=
 =?utf-8?B?aUtyemNNNlF1dE1qcUY0NXNPVnZwcGFJSjcwN2xzT3VrKzkxM0pwejlPV0Vi?=
 =?utf-8?B?emtySjZTa1NneUlsUHNGUGxBTEFDNXJFSzUwcGJkOFh2aTBXMTBFTDZpckp1?=
 =?utf-8?B?V25BYktvWCtxMEVLK2t6RWZXV0ovb2FYTUJWZFEySE5MbjhTRXU3N2tJb1Uy?=
 =?utf-8?B?TTdNTEJMNWhsK0h6RzVteFJDMEtQcUJXbjR3UXJEVzNIakRETWFWRWJmdUVF?=
 =?utf-8?B?R0djNHBsVWg0SEphalp5UVRwbVc2TFpZQTRqNnJndW9WSWtGOGlZTXZ4ZVVz?=
 =?utf-8?B?TEhrQXprWFp0VGcvN2FwWjBaUmphck5SUGVTa0F5ZG4xUDMvdmFvanFBNXZG?=
 =?utf-8?B?TjBzMkdIWXgzOWtiWDRqNW9zdFJrRHlUTVdPUXdkYTM1T1h0UT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdac4ff2-49b1-41f6-69bb-08dbd4696e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 08:15:49.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46JXi6b8OeAsisE2AseLchlpZj+5U0p+CXenVZadEa5MKbL1ICICsXENKjb97msH1JvHREBhCcMStFDktYVt7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5923
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzEwLzIwMjMgMTg6NDUsIFlpIFpoYW5nIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAy
MywgMjAyMyBhdCAxMTo1MuKAr0FNIFpoaWppYW4gTGkgKEZ1aml0c3UpDQo+IDxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+IHdyb3RlOg0KPj4NCj4+DQo+Pg0KPj4gT24gMjAvMTAvMjAyMyAyMjowMSwg
SmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+IE9uIEZyaSwgT2N0IDIwLCAyMDIzIGF0IDAzOjQ3
OjA1QU0gKzAwMDAsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4+PiBDQyBCYXJ0DQo+
Pj4+DQo+Pj4+IE9uIDEzLzEwLzIwMjMgMjA6MDEsIERhaXN1a2UgTWF0c3VkYSAoRnVqaXRzdSkg
d3JvdGU6DQo+Pj4+PiBPbiBGcmksIE9jdCAxMywgMjAyMyAxMDoxOCBBTSBaaHUgWWFuanVuIHdy
b3RlOg0KPj4+Pj4+IEZyb206IFpodSBZYW5qdW48eWFuanVuLnpodUBsaW51eC5kZXY+DQo+Pj4+
Pj4NCj4+Pj4+PiBUaGUgcGFnZV9zaXplIG9mIG1yIGlzIHNldCBpbiBpbmZpbmliYW5kIGNvcmUg
b3JpZ2luYWxseS4gSW4gdGhlIGNvbW1pdA0KPj4+Pj4+IDMyNWE3ZWI4NTE5OSAoIlJETUEvcnhl
OiBDbGVhbnVwIHBhZ2UgdmFyaWFibGVzIGluIHJ4ZV9tci5jIiksIHRoZQ0KPj4+Pj4+IHBhZ2Vf
c2l6ZSBpcyBhbHNvIHNldC4gU29tZXRpbWUgdGhpcyB3aWxsIGNhdXNlIGNvbmZsaWN0Lg0KPj4+
Pj4gSSBhcHByZWNpYXRlIHlvdXIgcHJvbXB0IGFjdGlvbiwgYnV0IEkgZG8gbm90IHRoaW5rIHRo
aXMgY29tbWl0IGRlYWxzIHdpdGgNCj4+Pj4+IHRoZSByb290IGNhdXNlLiBJIGFncmVlIHRoYXQg
dGhlIHByb2JsZW0gbGllcyBpbiByeGUgZHJpdmVyLCBidXQgd2hhdCBpcyB3cm9uZw0KPj4+Pj4g
d2l0aCBhc3NpZ25pbmcgYWN0dWFsIHBhZ2Ugc2l6ZSB0byBpYm1yLnBhZ2Vfc2l6ZT8NCj4+Pj4+
DQo+Pj4+PiBJTU8sIHRoZSBwcm9ibGVtIGNvbWVzIGZyb20gdGhlIGRldmljZSBhdHRyaWJ1dGUg
b2YgcnhlIGRyaXZlciwgd2hpY2ggaXMgdXNlZA0KPj4+Pj4gaW4gdWxwL3NycCBsYXllciB0byBj
YWxjdWxhdGUgdGhlIHBhZ2Vfc2l6ZS4NCj4+Pj4+ID09PT09DQo+Pj4+PiBzdGF0aWMgaW50IHNy
cF9hZGRfb25lKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSkNCj4+Pj4+IHsNCj4+Pj4+ICAgICAg
ICAgICAgc3RydWN0IHNycF9kZXZpY2UgKnNycF9kZXY7DQo+Pj4+PiAgICAgICAgICAgIHN0cnVj
dCBpYl9kZXZpY2VfYXR0ciAqYXR0ciA9ICZkZXZpY2UtPmF0dHJzOw0KPj4+Pj4gPC4uLj4NCj4+
Pj4+ICAgICAgICAgICAgLyoNCj4+Pj4+ICAgICAgICAgICAgICogVXNlIHRoZSBzbWFsbGVzdCBw
YWdlIHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBIQ0EsIGRvd24gdG8gYQ0KPj4+Pj4gICAgICAgICAg
ICAgKiBtaW5pbXVtIG9mIDQwOTYgYnl0ZXMuIFdlJ3JlIHVubGlrZWx5IHRvIGJ1aWxkIGxhcmdl
IHNnbGlzdHMNCj4+Pj4+ICAgICAgICAgICAgICogb3V0IG9mIHNtYWxsZXIgZW50cmllcy4NCj4+
Pj4+ICAgICAgICAgICAgICovDQo+Pj4+PiAgICAgICAgICAgIG1yX3BhZ2Vfc2hpZnQgICAgICAg
ICAgID0gbWF4KDEyLCBmZnMoYXR0ci0+cGFnZV9zaXplX2NhcCkgLSAxKTsNCj4+Pj4NCj4+Pj4N
Cj4+Pj4gWW91IGxpZ2h0IG1lIHVwLg0KPj4+PiBSWEUgcHJvdmlkZXMgYXR0ci5wYWdlX3NpemVf
Y2FwKFJYRV9QQUdFX1NJWkVfQ0FQKSB3aGljaCBtZWFucyBpdCBjYW4gc3VwcG9ydCA0Sy0yRyBw
YWdlIHNpemUNCj4+Pg0KPj4+IFRoYXQgZG9lc24ndCBzZWVtIHJpZ2h0IGV2ZW4gaW4gY29uY2Vw
dC4+DQo+Pj4gSSB0aGluayB0aGUgbXVsdGktc2l6ZSBzdXBwb3J0IGluIHRoZSBuZXcgeGFycmF5
IGNvZGUgZG9lcyBub3Qgd29yaw0KPj4+IHJpZ2h0LCBqdXN0IGxvb2tpbmcgYXQgaXQgbWFrZXMg
bWUgdGhpbmsgaXQgZG9lcyBub3Qgd29yayByaWdodC4gSXQNCj4+PiBsb29rcyBsaWtlIGl0IGNh
biBkbyBsZXNzIHRoYW4gUEFHRV9TSVpFIGJ1dCBtb3JlIHRoYW4gUEFHRV9TSVpFIHdpbGwNCj4+
PiBleHBsb2RlIGJlY2F1c2Uga21hcF9sb2NhbF9wYWdlKCkgZG9lcyBvbmx5IDRLLg0KPj4+DQo+
Pj4gSWYgUlhFX1BBR0VfU0laRV9DQVAgPT0gUEFHRV9TSVpFICB3aWxsIGV2ZXJ5dGhpbmcgd29y
az8NCj4+Pg0KPj4NCj4+IFllYWgsIHRoaXMgc2hvdWxkIHdvcmsoZXZlbiB0aG91Z2ggaSBvbmx5
IHZlcmlmaWVkIGhhcmRjb2RpbmcgbXJfcGFnZV9zaGlmdCB0byBQQUdFX1NISUZUKS4NCj4gDQo+
IEhpIFpoaWppYW4NCj4gDQo+IERpZCB5b3UgdHJ5IGJsa3Rlc3RzIG52bWUvcmRtYSB1c2Vfcnhl
IG9uIHlvdXIgZW52aXJvbm1lbnQsIGl0IHN0aWxsDQo+IGZhaWxlZCBvbiBteSBzaWRlLg0KPiAN
Cg0KVGhhbmtzIGZvciB5b3VyIHRlc3RpbmcuDQpJIGp1c3QgZGlkIHRoYXQsIGl0IGFsc28gZmFp
bGVkIGluIG15IGVudmlyb25tZW50LiBBZnRlciBhIGdsYW5jZSBkZWJ1ZywgSSBmb3VuZCB0aGVy
ZSBhcmUNCm90aGVyIHBsYWNlcyBzdGlsbCByZWdpc3RlcmVkIDRLIE1SLiBJIHdpbGwgZGlnIGlu
dG8gaXQgbGF0ZXIuDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KDQo+ICMgdXNlX3J4ZT0xIG52
bWVfdHJ0eXBlPXJkbWEgIC4vY2hlY2sgbnZtZS8wMDMNCj4gbnZtZS8wMDMgKHRlc3QgaWYgd2Un
cmUgc2VuZGluZyBrZWVwLWFsaXZlcyB0byBhIGRpc2NvdmVyeSBjb250cm9sbGVyKSBbZmFpbGVk
XQ0KPiAgICAgIHJ1bnRpbWUgIDEyLjE3OXMgIC4uLiAgMTEuOTQxcw0KPiAgICAgIC0tLSB0ZXN0
cy9udm1lLzAwMy5vdXQgMjAyMy0xMC0yMiAxMDo1NDo0My4wNDE3NDk1MzcgLTA0MDANCj4gICAg
ICArKysgL3Jvb3QvYmxrdGVzdHMvcmVzdWx0cy9ub2Rldi9udm1lLzAwMy5vdXQuYmFkIDIwMjMt
MTAtMjMNCj4gMDU6NTI6MjcuODgyNzU5MTY4IC0wNDAwDQo+ICAgICAgQEAgLTEsMyArMSwzIEBA
DQo+ICAgICAgIFJ1bm5pbmcgbnZtZS8wMDMNCj4gICAgICAtTlFOOm5xbi4yMDE0LTA4Lm9yZy5u
dm1leHByZXNzLmRpc2NvdmVyeSBkaXNjb25uZWN0ZWQgMSBjb250cm9sbGVyKHMpDQo+ICAgICAg
K05RTjpucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkgZGlzY29ubmVjdGVkIDAg
Y29udHJvbGxlcihzKQ0KPiAgICAgICBUZXN0IGNvbXBsZXRlDQo+IA0KPiBbIDcwMzMuNDMxOTEw
XSByZG1hX3J4ZTogbG9hZGVkDQo+IFsgNzAzMy40NTYzNDFdIHJ1biBibGt0ZXN0cyBudm1lLzAw
MyBhdCAyMDIzLTEwLTIzIDA1OjUyOjE1DQo+IFsgNzAzMy41MDIzMDZdIChudWxsKTogcnhlX3Nl
dF9tdHU6IFNldCBtdHUgdG8gMTAyNA0KPiBbIDcwMzMuNTEwOTY5XSBpbmZpbmliYW5kIGVuUDJw
MXMwdjBfcnhlOiBzZXQgYWN0aXZlDQo+IFsgNzAzMy41MTA5ODBdIGluZmluaWJhbmQgZW5QMnAx
czB2MF9yeGU6IGFkZGVkIGVuUDJwMXMwdjANCj4gWyA3MDMzLjU0OTMwMV0gbG9vcDA6IGRldGVj
dGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMjA5NzE1Mg0KPiBbIDcwMzMuNTU2OTY2XSBu
dm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTENCj4g
WyA3MDMzLjU2NjcxMV0gbnZtZXRfcmRtYTogZW5hYmxpbmcgcG9ydCAwICgxMC4xOS4yNDAuODE6
NDQyMCkNCj4gWyA3MDMzLjU4ODYwNV0gbnZtZXQ6IGNvbm5lY3QgYXR0ZW1wdCBmb3IgaW52YWxp
ZCBjb250cm9sbGVyIElEIDB4ODA4DQo+IFsgNzAzMy41OTQ5MDldIG52bWUgbnZtZTA6IENvbm5l
Y3QgSW52YWxpZCBEYXRhIFBhcmFtZXRlciwgY250bGlkOiA2NTUzNQ0KPiBbIDcwMzMuNjAxNTA0
XSBudm1lIG52bWUwOiBmYWlsZWQgdG8gY29ubmVjdCBxdWV1ZTogMCByZXQ9MTY3NzANCj4gWyA3
MDQ2LjMxNzg2MV0gcmRtYV9yeGU6IHVubG9hZGVkDQo+IA0KPiANCj4+DQo+Pj4+PiBpbXBvcnQg
Y3R5cGVzDQo+Pj4+PiBsaWJjID0gY3R5cGVzLmNkbGwuTG9hZExpYnJhcnkoJ2xpYmMuc28uNicp
DQo+Pj4+PiBoZXgoNjU1MzYpDQo+PiAnMHgxMDAwMCcNCj4+Pj4+IGxpYmMuZmZzKDB4MTAwMDAp
IC0gMQ0KPj4gMTYNCj4+Pj4+IDEgPDwgMTYNCj4+IDY1NTM2DQo+Pg0KPj4gc28NCj4+IG1yX3Bh
Z2Vfc2hpZnQgPSBtYXgoMTIsIGZmcyhhdHRyLT5wYWdlX3NpemVfY2FwKSAtIDEpID0gbWF4KDEy
LCAxNikgPSAxNjsNCj4+DQo+Pg0KPj4gU28gSSB0aGluayBEYWlzdWtlJ3MgcGF0Y2ggc2hvdWxk
IHdvcmsgYXMgd2VsbC4NCj4+DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yZG1h
L09TM1BSMDFNQjk4NjUyQjJFQzJFODVEQUVDNkRERTQ4NEU1RDJBQE9TM1BSMDFNQjk4NjUuanBu
cHJkMDEucHJvZC5vdXRsb29rLmNvbS9ULyNtZDEzMzA2MDQxNGYwYmE2YTNkYmFmN2I0YWQyMzc0
YzhhMzQ3Y2ZkMQ0KPj4NCj4+DQo+Pj4gSmFzb24NCj4gDQo+IA0KPiANCj4gLS0NCj4gQmVzdCBS
ZWdhcmRzLA0KPiAgICBZaSBaaGFuZw0KPiA=
