Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0735278DD52
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Aug 2023 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbjH3Ssz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Aug 2023 14:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbjH3RyI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Aug 2023 13:54:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41766193
        for <linux-rdma@vger.kernel.org>; Wed, 30 Aug 2023 10:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqXFUeDMW5Q118rcwDBRgJfqWI+39ox6vW7bI7uH6HRUSUQvxlmTfLWBXhaOfc5N9VUevXXfU2lHcu1jq7BgS5/flRnmNYx78f1s8/JP1gho2b+b4UCh0f/QTAw3puzuqa2n8FuApDyCfHwVg7uYZ75OmU6a+duNh3uHi96k1LDXZW51/JOiyYE8PVkS02hOHAdQDOHn8vtH1IO4QLyBO3EvUAlJILXq0Y42D9tnaR9UCnvbZrFe1+Ro1juiNtz5Z5q3GuX3gYTlSnqvtYq22MP8GTqD+NnjL0UdjPYceIlvE1EpM15vpMRh7rB4jnKTnvWDxELhU2nf7KoqVmPvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuM1KevQFseMsWhBUkfX+y1MaBthVF6l7cWDWH3p24Y=;
 b=XH7zMn/vnfAomRQxfWH0rJ1mCLofjaH8wE5KOnReLFe1fUqYT3t52wII54sa2EDzdieotEkXlrp2ipqzxppIyFR+FOictujkCBgWYwCMxWvZqFG2KWjl1SA6RQNyhVqnTysIVOEzSeJgsARXJNcshVltCzdmghfFESiS05P62R995HqrY4v4wFROapoFjcXOgzlz3Z8rh6KBwWUPWh3V/RntClr+vRsbLRmbnXaxYWPP0XEgvsl1VcWHSBBpcJz1W+rh0QhFkauhS8CybWxnz49L3bW+fjh4Owhy6CTyJLZLvofD3MXMi/Uyhy+/zfEYsw9nDkZ7G2fLpRiuzLNDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuM1KevQFseMsWhBUkfX+y1MaBthVF6l7cWDWH3p24Y=;
 b=fjVAkHoJ+jmS/BV2f34Femx91NLVmiHlUtTss3qcdV57eI4Hb0uHkDMnu5/5dpOP3sFkxJqW3o/Vzq3FwEeDM/rZc6X5h6zRzW82vAN8lh7UexQxRjcqMez7RiODjp8A1cUrxUejVPMix1Qs/CWmBZZP+JiOY7LwE2dyrD19vKpoJ0sqir1riOSwOnUgZu0p/OSZZcwB/zLtVXZlgSUVWx3dP/jvGCoF7xsoSB70xs8BRuxde46dFJjE+Vp4edQj07jpa2yAkCeEHj7TV0pXdadX9XmgyIpzQa+QH4FTplvfw/bkZwb4v8Gc3sMJ0aamWO1IgVUOG0tMDiOwOTEeMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 BN0PR01MB7199.prod.exchangelabs.com (2603:10b6:408:15a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Wed, 30 Aug 2023 17:53:57 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::31dc:697f:12d9:8928]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::31dc:697f:12d9:8928%5]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 17:53:57 +0000
Message-ID: <5868fabe-a45a-3960-aa4b-d81cff8ef6ec@cornelisnetworks.com>
Date:   Wed, 30 Aug 2023 13:53:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [bug-report] Oops at hfi1_ipoib_send + hfi1_ipoib_sdma_complete
 IRQ
Content-Language: en-US
To:     Rodrigo Arias <rodrigo.arias@bsc.es>, linux-rdma@vger.kernel.org
References: <ZO8dWSh5Y9D8FZG9@hop.home>
Cc:     "Koch, Kerry" <kerry.a.koch@cornelisnetworks.com>,
        "Luick, Dean" <dean.luick@cornelisnetworks.com>,
        "Cunningham, Brendan" <brendan.cunningham@cornelisnetworks.com>,
        "Miller, Doug" <Doug.Miller@Cornelisnetworks.com>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ZO8dWSh5Y9D8FZG9@hop.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|BN0PR01MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 298337d7-93de-4b18-8f4f-08dba9821574
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40NugTUJ8Nsk0V4UCpzLkWujwEllA0MNFgts0FA7VG4Yri/8gyOrs2eXO/trNWDIHdf9DDaP8l+qwSxuaaEJooi98pNZk7qd2u1PLlojmiqRyldBE1O//X0ZpCkoalWkaOBpF26lcoNCHzedrHz1s0odubVWUdGR67c7yzDIWEy5AF+frPu8MbA0wHxpj2MJtwp2dND4eC4QxMz/paY5uIla3WMNyfcTpHGIDviQ35orOBoZp2FcpuF0qTAD+HrqYVMFvLJt4b5N9zGSHrFIQ+KtE6lkqs2lfDxvsutsH6GIlZqxeOA6Y14N/1YhvKja6dMZNmoHGVUKRy+pW9Mx5lgmQ1NTicfCgzFG15t8Q4BUJXZXK3PJb5u1m/tW3cOunuQacQR/IlR8+/+/W6cdHcfYp1Kc3LnMA+0zBoSbjLKsDfV+VaZyOpiG1Mbi1F58XonSzCh4W6n6K/O6OliLNT2efyhCA7IOdupa02TERLPmnm/qK7Kla4vsglRuMBdyyR/V01P8fqZT1MGopGHTKJ2GbMDM5JqEqLG/AES/L5X1ibdgH0IpvJ/n4k5tRPoPR+Q9n0rhtaGzJDj5WjkC0z85KvVh1wWGyCngCgYwWgXkZ5oQgRGGJ4IqoKsDpk22twHAz987laj9LaKx64BZOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(186009)(451199024)(1800799009)(36756003)(31686004)(107886003)(83380400001)(4326008)(53546011)(44832011)(86362001)(31696002)(41300700001)(5660300002)(8936002)(8676002)(52116002)(26005)(6506007)(6666004)(6486002)(2616005)(6512007)(45080400002)(38350700002)(478600001)(38100700002)(30864003)(66946007)(66556008)(66476007)(54906003)(316002)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5VbExVa200cVBxV3IzK21sZ3F4eTZjZVY5MzkwRCtjdjY3TEVrbWxhUEsz?=
 =?utf-8?B?amt0NlptL0N5QjNjVXU3Yzg4bUdBWXEzeDJjV3o2MjN1K2s5eGd3R2tsV2g1?=
 =?utf-8?B?NDVaOWY2Y0hwekpOdWI4UkJrZnlENVYra29NK29DbkdrQmZaejZUNnJWZXVl?=
 =?utf-8?B?UmxMQnRVcW9HMkNUd29LN3BRYkExV3RFVk1RVElWK3ZPMFlCOWNrb3dXQllU?=
 =?utf-8?B?bkJnajlTMmdNVUlTMjlacjRPdzN2QkFkR1JjSis3NGI3Z20xNk8wQUMxdjBj?=
 =?utf-8?B?a1BsN0tLeUpQVDRxWGFhOEpUWkg4bnI5YnNuOFFpTWlaOHZDM2Ricm8yc3R6?=
 =?utf-8?B?UHcxQ3JTNUZBVytvNUl1UWNBbC9VWFFucnJrM05mWjF4ZTA1NVBvdnB4UGpv?=
 =?utf-8?B?QlVjS0VVUXBMWENQR1BaU1hBcmc0dElEK2Q1RmVPRzlIYzVTK0VFOS9JVzkz?=
 =?utf-8?B?S0ZRMC85M3hpMURvYmdoLzcyWkNBZGJwL2RFZjFzbGlQWVVJdWdZVFdKN1dS?=
 =?utf-8?B?KzFpU0cxd28xRyt4Z3MrMWNxa3lZc1VJc3ZFaE4rZ2d4R0taQWdTR3l5ZUFR?=
 =?utf-8?B?bzh0QnUxMDZRZGdJT2kwNCt1R3BXMzVnWkJEelg1TXppM3Z3cndld2IrakM2?=
 =?utf-8?B?azFKSXZ5a3dZc0FPb0tEbjZPWTNzZUY5enE2bjJNYU9yU0gzNDBmN1lsV1FU?=
 =?utf-8?B?dzhnaHI3NW41bTJFbVhGQ2V5MEZiazJjVC9GRDRmTWVjc29iYlpzblZYYW5a?=
 =?utf-8?B?NEsxdXppWVdvU1VrZUVUdDZWalUxditub1RkOERFM0t5bmxPOHBHZjRFMm16?=
 =?utf-8?B?YkhxWEVZMTFkV3ZNeCtoK1FxZjZoazZjbDRSTnE1bWdiWVVUcEhuNHViN25r?=
 =?utf-8?B?L0JZSk5YdGVMYlVYT2Y3ZGVvY3FzandyUjFUUE5LREFFUlJTNkN3SmVVYmZx?=
 =?utf-8?B?Mmc1WTdGNkRUQnRrVXZUSnBhV2ZselZ1QjBYb0hqWWx4akVEUWJnQ291R1B5?=
 =?utf-8?B?bTVZRHlKMGtyL3RWQ21ENU84M3JBVUl2UktreG5DUW5kZmhPREN2Z1c5c0xj?=
 =?utf-8?B?blJtQkgxSzVneHFvQnAzaEUybUo3K1M1VmJBYTl5TzhxczdaRG5XYmwwdXhq?=
 =?utf-8?B?ejA4bE9qWGNXZTNmOFIvODFwMGVYdTNwNEhhb1luT28wZm5aZTRYTVIwOE84?=
 =?utf-8?B?V0VoRXhRU1gxTjFSWEpXbU5xcTFmWmd6WXpBVUk0MWRiNE1FdW55elQxZzVI?=
 =?utf-8?B?KzR4SVVsS2cyNy94N1Y5OVQ5ZEt5ajltQzJ4RXJKVjEzay9vWjVUNnZ3RUVk?=
 =?utf-8?B?c0hjZHBwVW5UZmRLQ3dzLzBia1YvK3FVNmFnMXhDTURBTGk4UURqQ0VaRFJz?=
 =?utf-8?B?bXNQM0RsbktIRzNZeWRFVmV5a1FxN09WbjZIZm9pdWhXeFRJZlYzbWhTdEZw?=
 =?utf-8?B?bXh6aUVVVkxwVzBmVk5LWkdRcVJtQXk0TFRJdlE1M3YwN1B2YWo1Ni9CdnZm?=
 =?utf-8?B?b29remxyWkhJZmpWK2IzTm55S0VZcUxRMytmUTAxbmE0REQzUjErc2R1LzNj?=
 =?utf-8?B?eU9qUFp2S01JamRJQllOdi9ONno3bHdnNFpDLzZodXp5Q0NsZE9lNTB4SmU4?=
 =?utf-8?B?WDV4Qkg1OGo3ZUE2RFA1L1RoVGVOUlFzZVplT25wcnNSMUNLYnVUZ3dpQTdi?=
 =?utf-8?B?cEpnTVhmUThjLzZGZXNTQ3NkeVRneEpNLzBGNHAvWXoxQ2JyOG84NUh1RGFG?=
 =?utf-8?B?SnZLbXYvL1FQNEx4VXhaeUR4S01RQ1hjTXEvRXlYRXBZaFRtUTMvREtPOW1w?=
 =?utf-8?B?eG9tNnRRS2MyMSsya3JHMlp0ZTU3QzBQVnNMOXdFNkdJeU1jdGZvOEJSMHRz?=
 =?utf-8?B?VTl5UldBd2tBRmwrTWhxRWR4QUoxM0FNMXlDWHRCd05mcGFwQXhNSTFvaVlC?=
 =?utf-8?B?VkpFTlhWd2haT3FkL0VlL1BuTzJIUDh1SVFGYW8wN0tUMTlkQURCQ1RXK1pG?=
 =?utf-8?B?UnNDVFRuV2VCbzVhamRaZVVTdTdic1E5bU5EZDE1UDU2MTZ5c2h2enFDRk90?=
 =?utf-8?B?ZXR3d2s2WGc2S3FCaU43OUlrN3cyRjJ5cnNHVFMzRzBPOW91UVdtV0J3MzFp?=
 =?utf-8?B?MFhTZDN3cE01bzJaOTV1amZHSXpVakJERDcwZVhzK3pRVE1uMWFtdkNBZTVa?=
 =?utf-8?Q?ud0KJqI3uYVFCYbYLTVRuwg=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298337d7-93de-4b18-8f4f-08dba9821574
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:53:57.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J/DE1pdNUHabchjXgTIZQzWPEVnlB4bsu/7ws5Sdx4CWnTm8OLVT5AiGaMuP1RTV0dzgyUkAae87an4RmeH3K5WwVEZO9p235QXPhjvYzTjVZMxQqv/7ThGLeASDSra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7199
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/30/23 6:43 AM, Rodrigo Arias wrote:
> Hi,
>=20
> (Please CC me)
>=20
> I'm testing the Ceph filesystem in an OmniPath network using ipoib and=20
> I'm able to cause an oops every time I run a fio benchmark with more=20
> than one writer for some seconds. Here is the oops of the 6.4.11 kernel=20
> from netconsole:
>=20
> [ 2116.528509] BUG: kernel NULL pointer dereference, address: 00000000000=
00010
> [ 2116.536343] #PF: supervisor read access in kernel mode
> [ 2116.542106] #PF: error_code(0x0000) - not-present page
> [ 2116.547853] PGD 0 P4D 0
> [ 2116.550699] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 2116.555380] CPU: 4 PID: 42 Comm: ksoftirqd/4 Not tainted 6.4.11 #1-Nix=
OS
> [ 2116.562889] Hardware name: Intel Corporation S2600WT2R/S2600WT2R, BIOS=
 SE5C610.86B.01.01.0016.033120161139 03/31/2016
> [ 2116.574768] RIP: 0010:napi_schedule_prep+0x9/0x50
> [ 2116.580050] Code: 68 54 0c 94 e8 58 3e cf ff 0f 1f 84 00 00 00 00 00 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <=
48> 8b 4f 10 f6 c1 04 75 29 48 89 ca 48 89 c8 83 e2 01 48 01 d2 48
> [ 2116.601069] RSP: 0018:ffffabe5c65f0eb8 EFLAGS: 00010046
> [ 2116.606923] RAX: ffffffffc14f1ab0 RBX: 0000000000000000 RCX: 000000000=
0000001
> [ 2116.614916] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [ 2116.622905] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
> [ 2116.630897] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000617
> [ 2116.638887] R13: ffff9164955396b0 R14: 0000000000000016 R15: ffff91649=
8d09a00
> [ 2116.646878] FS:  0000000000000000(0000) GS:ffff9173bfb00000(0000) knlG=
S:0000000000000000
> [ 2116.655940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2116.662375] CR2: 0000000000000010 CR3: 0000000a8ee20002 CR4: 000000000=
03706e0
> [ 2116.670366] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 2116.678356] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 2116.686346] Call Trace:
> [ 2116.689089]  <IRQ>
> [ 2116.691350]  ? __die+0x23/0x70
> [ 2116.694782]  ? page_fault_oops+0x17d/0x4b0
> [ 2116.700050]  ? ip_protocol_deliver_rcu+0x32/0x170
> [ 2116.705968]  ? exc_page_fault+0x6d/0x150
> [ 2116.711007]  ? asm_exc_page_fault+0x26/0x30
> [ 2116.716336]  ? __pfx_hfi1_ipoib_sdma_complete+0x10/0x10 [hfi1]
> [ 2116.723646]  ? napi_schedule_prep+0x9/0x50
> [ 2116.728875]  hfi1_ipoib_sdma_complete+0x38/0x90 [hfi1]
> [ 2116.735353]  sdma_make_progress+0x178/0x460 [hfi1]
> [ 2116.741459]  ? __pfx_hfi1_ipoib_sdma_complete+0x10/0x10 [hfi1]
> [ 2116.748712]  sdma_engine_interrupt+0x72/0x100 [hfi1]
> [ 2116.755030]  sdma_interrupt+0x36/0x110 [hfi1]
> [ 2116.760632]  __handle_irq_event_percpu+0x4d/0x1a0
> [ 2116.766538]  handle_irq_event+0x3e/0x80
> [ 2116.771462]  handle_edge_irq+0x9d/0x280
> [ 2116.776380]  __common_interrupt+0x46/0xc0
> [ 2116.781495]  common_interrupt+0x81/0xa0
> [ 2116.786418]  </IRQ>
> [ 2116.789403]  <TASK>
> [ 2116.792382]  asm_common_interrupt+0x26/0x40
> [ 2116.797708] RIP: 0010:skb_segment+0x86b/0xf00
> [ 2116.803222] Code: 24 44 8b 74 24 60 49 89 cc 48 8b 4c 24 28 e9 8b 00 0=
0 00 48 8b 11 48 8b 79 08 49 89 14 24 48 89 d0 49 89 7c 24 08 48 8b 50 08 <=
f6> c2 01 0f 85 c9 03 00 00 0f 1f 44 00 00 f0 ff 40 34 41 8b 44 24
> [ 2116.825561] RSP: 0018:ffffabe5c65dbb90 EFLAGS: 00000213
> [ 2116.832097] RAX: ffffd6a144ae8c00 RBX: ffff9164af715c00 RCX: ffff9164d=
b525400
> [ 2116.840773] RDX: 0000000000000000 RSI: ffff91648734f0e8 RDI: 000000000=
0008000
> [ 2116.849444] RBP: ffffabe5c65dbc60 R08: 0000000000005dac R09: 000000000=
0006574
> [ 2116.858127] R10: 25dd4e99d6e1ffe7 R11: 0000000000000003 R12: ffff91648=
7cb7980
> [ 2116.866801] R13: 0000000000005df8 R14: 0000000000000001 R15: 000000000=
0000000
> [ 2116.875493]  ? __pfx_csum_partial_ext+0x10/0x10
> [ 2116.881263]  ? __pfx_csum_block_add_ext+0x10/0x10
> [ 2116.887289]  tcp_gso_segment+0xec/0x4e0
> [ 2116.892247]  ? __pfx_tcp_wfree+0x10/0x10
> [ 2116.897283]  inet_gso_segment+0x159/0x3d0
> [ 2116.902393]  ? hfi1_ipoib_send+0x246/0x560 [hfi1]
> [ 2116.908364]  skb_mac_gso_segment+0xa4/0x110
> [ 2116.914180]  __skb_gso_segment+0xb7/0x170
> [ 2116.919271]  ? netif_skb_features+0x151/0x2e0
> [ 2116.924746]  validate_xmit_skb+0x16c/0x340
> [ 2116.929930]  validate_xmit_skb_list+0x4e/0x70
> [ 2116.935392]  sch_direct_xmit+0x18a/0x380
> [ 2116.940372]  __qdisc_run+0x149/0x5a0
> [ 2116.944952]  net_tx_action+0x1df/0x2a0
> [ 2116.949714]  __do_softirq+0xca/0x2ae
> [ 2116.954278]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [ 2116.960005]  run_ksoftirqd+0x2c/0x40
> [ 2116.964575]  smpboot_thread_fn+0xdc/0x1d0
> [ 2116.969622]  kthread+0xe8/0x120
> [ 2116.973702]  ? __pfx_kthread+0x10/0x10
> [ 2116.978465]  ret_from_fork+0x2c/0x50
> [ 2116.983033]  </TASK>
> [ 2116.986029] Modules linked in: netconsole ipmi_si nfsv3 nfs_acl nfs lo=
ckd grace netfs fscache msr sb_edac edac_core intel_rapl_msr intel_rapl_com=
mon intel_uncore_frequency intel_uncore_frequency_common hfi1 x86_pkg_temp_=
thermal intel_powerclamp coretemp crc32_pclmul polyval_clmulni polyval_gene=
ric gf128mul ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel mg=
ag200 libaes drm_shmem_helper crypto_simd cryptd igb drm_kms_helper rdmavt =
rapl iTCO_wdt mei_me intel_cstate intel_pmc_bxt ptp syscopyarea ib_uverbs p=
ps_core watchdog sysfillrect mxm_wmi sunrpc intel_uncore sysimgblt mei i2c_=
i801 i2c_algo_bit ioatdma i2c_smbus lpc_ich evdev dca input_leds joydev led=
_class mousedev mac_hid wmi tiny_power_button acpi_power_meter acpi_pad but=
ton xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_rpfilter xt=
_pkttype xt_LOG nf_log_syslog xt_tcpudp nft_compat sch_fq_codel nf_tables l=
ibcrc32c nfnetlink atkbd libps2 serio vivaldi_fmap loop cpufreq_powersave t=
un tap macvlan bridge stp llc kvm irqbypass ib_ipoib ib_cm
> [ 2116.986177]  ib_umad ib_core ipmi_watchdog ipmi_devintf ipmi_msghandle=
r fuse drm efi_pstore backlight configfs dmi_sysfs ip_tables x_tables autof=
s4 ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid sd_mod ahc=
i xhci_pci xhci_pci_renesas libahci firmware_class ehci_pci xhci_hcd libata=
 ehci_hcd nvme nvme_core usbcore scsi_mod t10_pi crc32c_intel crc64_rocksof=
t crc64 crc_t10dif crct10dif_generic crct10dif_pclmul crct10dif_common usb_=
common scsi_common rtc_cmos dm_mod dax [last unloaded: ipmi_si]
> [ 2117.145385] CR2: 0000000000000010
> [ 2117.149915] ---[ end trace 0000000000000000 ]---
> [ 2117.215956] RIP: 0010:napi_schedule_prep+0x9/0x50
> [ 2117.222128] Code: 68 54 0c 94 e8 58 3e cf ff 0f 1f 84 00 00 00 00 00 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 <=
48> 8b 4f 10 f6 c1 04 75 29 48 89 ca 48 89 c8 83 e2 01 48 01 d2 48
> [ 2117.244851] RSP: 0018:ffffabe5c65f0eb8 EFLAGS: 00010046
> [ 2117.251528] RAX: ffffffffc14f1ab0 RBX: 0000000000000000 RCX: 000000000=
0000001
> [ 2117.260351] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [ 2117.269151] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
> [ 2117.277962] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000617
> [ 2117.286754] R13: ffff9164955396b0 R14: 0000000000000016 R15: ffff91649=
8d09a00
> [ 2117.295538] FS:  0000000000000000(0000) GS:ffff9173bfb00000(0000) knlG=
S:0000000000000000
> [ 2117.305396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2117.312654] CR2: 0000000000000010 CR3: 0000000a8ee20002 CR4: 000000000=
03706e0
> [ 2117.321457] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 2117.330257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 2117.339079] Kernel panic - not syncing: Fatal exception in interrupt
> [ 2117.347081] Kernel Offset: 0x12200000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 2117.420699] ---[ end Kernel panic - not syncing: Fatal exception in in=
terrupt ]---
>=20
> The OmniPath info from lspci -v:
>=20
> 05:00.0 Fabric controller: Intel Corporation Omni-Path HFI Silicon 100=20
> Series [discrete] (rev 11)
> 	Subsystem: Intel Corporation Omni-Path HFI Silicon 100 Series [discrete]
> 	Flags: bus master, fast devsel, latency 0, IRQ 205, NUMA node 0
> 	Memory at 90000000 (64-bit, non-prefetchable) [size=3D64M]
> 	Expansion ROM at <ignored> [disabled]
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [70] Express Endpoint, MSI 00
> 	Capabilities: [b0] MSI-X: Enable+ Count=3D256 Masked-
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [148] Secondary PCI Express
> 	Capabilities: [178] Transaction Processing Hints
> 	Kernel driver in use: hfi1
> 	Kernel modules: hfi1
>=20
> And here is dmesg | grep hfi :
>=20
> [   11.299758] hfi1 0000:05:00.0: hfi1_0: Eager buffer size 8388608
> [   11.299841] hfi1 0000:05:00.0: hfi1_0: UC base1: 00000000526a78a9 for =
1200000
> [   11.299845] hfi1 0000:05:00.0: hfi1_0: RcvArray count: 65536
> [   11.299862] hfi1 0000:05:00.0: hfi1_0: UC base2: 00000000088b79df for =
d80000
> [   11.299868] hfi1 0000:05:00.0: hfi1_0: WC piobase: 000000001c60bc9b fo=
r 2000000
> [   11.299874] hfi1 0000:05:00.0: hfi1_0: WC RcvArray: 00000000064844ea f=
or 80000
> [   11.299884] hfi1 0000:05:00.0: hfi1_0: Implementation: RTL silicon, re=
vision 0x0
> [   11.299887] hfi1 0000:05:00.0: hfi1_0: GUID 117501017982d2
> [   11.300105] hfi1 0000:05:00.0: hfi1_0: Resetting CSRs with FLR
> [   11.402144] hfi1 0000:05:00.0: hfi1_0: PCIe,5000MHz,x16
> [   11.414874] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: downlo=
ading firmware
> [   11.414877] hfi1 0000:05:00.0: hfi1_0: Downloading SBus firmware
> [   11.438112] hfi1 0000:05:00.0: hfi1_0: Setting PCIe SerDes broadcast
> [   11.438120] hfi1 0000:05:00.0: hfi1_0: Downloading PCIe firmware
> [   11.475144] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: settin=
g PCIe registers
> [   11.475161] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: using =
EQ Pset 2
> [   11.475162] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: doing =
pcie post steps
> [   11.475202] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: cleari=
ng ASPM
> [   11.475205] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: settin=
g parent target link speed
> [   11.475207] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..old =
link control2: 0x3
> [   11.475209] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..targ=
et speed is OK
> [   11.475210] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: settin=
g target link speed
> [   11.475212] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..old =
link control2: 0x2
> [   11.475213] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: ..new =
link control2: 0x3
> [   11.475215] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: arming=
 gasket logic
> [   11.475217] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: callin=
g trigger_sbr
> [   11.619094] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: callin=
g restore_pci_variables
> [   11.619112] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: gasket=
 block status: 0x1
> [   11.619117] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: per-la=
ne errors: 0x0
> [   11.619123] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: new sp=
eed and width: PCIe,8000MHz,x16
> [   11.619129] hfi1 0000:05:00.0: hfi1_0: do_pcie_gen3_transition: done
> [   11.653960] hfi1 0000:05:00.0: hfi1_0: Setting partition keys
> [   11.653970] hfi1 0000:05:00.0: hfi1_0: parse_platform_config:File leng=
th out of bounds, using alternative format
> [   11.653974] hfi1 0000:05:00.0: hfi1_0: parse_platform_config:File clai=
ms to be smaller than read size, continuing
> [   11.653984] hfi1 0000:05:00.0: hfi1_0: Board description not found
> [   11.653990] hfi1 0000:05:00.0: hfi1_0: allocating rx size 2560
> [   11.653999] hfi1 0000:05:00.0: hfi1_0: rcv contexts: chip 160, used 27=
 (kernel 3, netdev 8, user 16)
> [   11.654005] hfi1 0000:05:00.0: hfi1_0: RcvArray groups 303, ctxts extr=
a 11
> [   11.654011] hfi1 0000:05:00.0: hfi1_0: unused send context blocks: 9
> [   11.654014] hfi1 0000:05:00.0: hfi1_0: send contexts: chip 160, used 4=
4 (kernel 16, ack 3, user 24, vl15 1)
> [   11.654337] hfi1 0000:05:00.0: hfi1_0: Using send context 16(143) for =
VL15
> [   11.654425] hfi1 0000:05:00.0: hfi1_0: SDMA mod_num_sdma: 0
> [   11.654429] hfi1 0000:05:00.0: hfi1_0: SDMA chip_sdma_engines: 16
> [   11.654432] hfi1 0000:05:00.0: hfi1_0: SDMA chip_sdma_mem_size: 401408
> [   11.654436] hfi1 0000:05:00.0: hfi1_0: SDMA engines 16 descq_cnt 2048
> [   11.654709] hfi1 0000:05:00.0: hfi1_0: SDMA num_sdma: 16
> [   11.655634] hfi1 0000:05:00.0: hfi1_0: 28 MSI-X interrupts allocated
> [   11.655679] hfi1 0000:05:00.0: hfi1_0: IRQ: 216, type GENERAL  -> cpu:=
 0
> [   11.655718] hfi1 0000:05:00.0: hfi1_0: IRQ: 217, type SDMA engine 0 ->=
 cpu: 3
> [   11.655748] hfi1 0000:05:00.0: hfi1_0: IRQ: 218, type SDMA engine 1 ->=
 cpu: 4
> [   11.655775] hfi1 0000:05:00.0: hfi1_0: IRQ: 219, type SDMA engine 2 ->=
 cpu: 5
> [   11.655802] hfi1 0000:05:00.0: hfi1_0: IRQ: 220, type SDMA engine 3 ->=
 cpu: 6
> [   11.655837] hfi1 0000:05:00.0: hfi1_0: IRQ: 221, type SDMA engine 4 ->=
 cpu: 7
> [   11.655865] hfi1 0000:05:00.0: hfi1_0: IRQ: 222, type SDMA engine 5 ->=
 cpu: 3
> [   11.655893] hfi1 0000:05:00.0: hfi1_0: IRQ: 223, type SDMA engine 6 ->=
 cpu: 4
> [   11.655918] hfi1 0000:05:00.0: hfi1_0: IRQ: 224, type SDMA engine 7 ->=
 cpu: 5
> [   11.655941] hfi1 0000:05:00.0: hfi1_0: IRQ: 225, type SDMA engine 8 ->=
 cpu: 6
> [   11.655975] hfi1 0000:05:00.0: hfi1_0: IRQ: 226, type SDMA engine 9 ->=
 cpu: 7
> [   11.656001] hfi1 0000:05:00.0: hfi1_0: IRQ: 227, type SDMA engine 10 -=
> cpu: 3
> [   11.656027] hfi1 0000:05:00.0: hfi1_0: IRQ: 228, type SDMA engine 11 -=
> cpu: 4
> [   11.656059] hfi1 0000:05:00.0: hfi1_0: IRQ: 229, type SDMA engine 12 -=
> cpu: 5
> [   11.656095] hfi1 0000:05:00.0: hfi1_0: IRQ: 230, type SDMA engine 13 -=
> cpu: 6
> [   11.656132] hfi1 0000:05:00.0: hfi1_0: IRQ: 231, type SDMA engine 14 -=
> cpu: 7
> [   11.656158] hfi1 0000:05:00.0: hfi1_0: IRQ: 232, type SDMA engine 15 -=
> cpu: 3
> [   11.656281] hfi1 0000:05:00.0: hfi1_0: IRQ: 233, type RCVCTXT ctxt 0 -=
> cpu: 0
> [   11.656379] hfi1 0000:05:00.0: hfi1_0: IRQ: 234, type RCVCTXT ctxt 1 -=
> cpu: 1
> [   11.656483] hfi1 0000:05:00.0: hfi1_0: IRQ: 235, type RCVCTXT ctxt 2 -=
> cpu: 2
> [   11.656498] hfi1 0000:05:00.0: hfi1_0: Downloading fabric firmware
> [   11.815124] hfi1 0000:05:00.0: hfi1_0: 8051 firmware version 1.27.0
> [   11.827334] hfi1 0000:05:00.0: hfi1_0: SBus Master firmware version 0x=
10130001
> [   12.019816] hfi1 0000:05:00.0: hfi1_0: PCIe SerDes firmware version 0x=
4755
> [   12.067297] hfi1 0000:05:00.0: hfi1_0: Fabric SerDes firmware version =
0x1055
> [   12.067310] hfi1 0000:05:00.0: hfi1_0: Initializing thermal sensor
> [   14.707102] hfi1 0000:05:00.0: hfi1_0: wait_for_qsfp_init: No IntN det=
ected, reset complete
> [   14.840952] hfi1 0000:05:00.0: hfi1_0: set_link_state: current OFFLINE=
, new POLL=20
> [   14.840964] hfi1 0000:05:00.0: hfi1_0: Downloading fabric firmware
> [   15.045304] hfi1 0000:05:00.0: hfi1_0: physical state changed to PHYS_=
POLL (0x2), phy 0x20
> [   15.045427] hfi1 0000:05:00.0: hfi1_0: Reserving QPNs from 0x800000 to=
 0x81ffff for non-verbs use
> [   15.056181] hfi1 0000:05:00.0: hfi1_0: created netdev context 3
> [   15.058702] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 0 napi to con=
text 3
> [   15.058766] hfi1 0000:05:00.0: hfi1_0: IRQ: 236, type NETDEVCTXT ctxt =
3 -> cpu: 4
> [   15.058791] hfi1 0000:05:00.0: hfi1_0: created netdev context 4
> [   15.061776] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 1 napi to con=
text 4
> [   15.061808] hfi1 0000:05:00.0: hfi1_0: IRQ: 237, type NETDEVCTXT ctxt =
4 -> cpu: 5
> [   15.061826] hfi1 0000:05:00.0: hfi1_0: created netdev context 5
> [   15.064140] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 2 napi to con=
text 5
> [   15.064163] hfi1 0000:05:00.0: hfi1_0: IRQ: 238, type NETDEVCTXT ctxt =
5 -> cpu: 6
> [   15.064179] hfi1 0000:05:00.0: hfi1_0: created netdev context 6
> [   15.066314] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 3 napi to con=
text 6
> [   15.066333] hfi1 0000:05:00.0: hfi1_0: IRQ: 239, type NETDEVCTXT ctxt =
6 -> cpu: 7
> [   15.066352] hfi1 0000:05:00.0: hfi1_0: created netdev context 7
> [   15.068990] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 4 napi to con=
text 7
> [   15.069018] hfi1 0000:05:00.0: hfi1_0: IRQ: 240, type NETDEVCTXT ctxt =
7 -> cpu: 3
> [   15.069035] hfi1 0000:05:00.0: hfi1_0: created netdev context 8
> [   15.071180] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 5 napi to con=
text 8
> [   15.071198] hfi1 0000:05:00.0: hfi1_0: IRQ: 241, type NETDEVCTXT ctxt =
8 -> cpu: 4
> [   15.071214] hfi1 0000:05:00.0: hfi1_0: created netdev context 9
> [   15.073353] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 6 napi to con=
text 9
> [   15.073371] hfi1 0000:05:00.0: hfi1_0: IRQ: 242, type NETDEVCTXT ctxt =
9 -> cpu: 5
> [   15.073387] hfi1 0000:05:00.0: hfi1_0: created netdev context 10
> [   15.075538] hfi1 0000:05:00.0: hfi1_0: Setting rcv queue 7 napi to con=
text 10
> [   15.075566] hfi1 0000:05:00.0: hfi1_0: IRQ: 243, type NETDEVCTXT ctxt =
10 -> cpu: 6
> [   15.078195] hfi1 0000:05:00.0: hfi1_0: Registration with rdmavt done.
> [   15.093030] hfi1 0000:05:00.0 ibp5s0: renamed from ib0
> [   19.722924] hfi1 0000:05:00.0: hfi1_0: set_link_state: current POLL, n=
ew VERIFY_CAP=20
> [   19.722934] hfi1 0000:05:00.0: hfi1_0: physical state changed to PHYS_=
TRAINING (0x4), phy 0x46
> [   19.722951] hfi1 0000:05:00.0: hfi1_0: Fabric active lanes (width): tx=
 0xf (4), rx 0xf (4)
> [   19.722956] hfi1 0000:05:00.0: hfi1_0: Peer PHY: power management 0x0,=
 continuous updates 0x1
> [   19.722960] hfi1 0000:05:00.0: hfi1_0: Peer Fabric: vAU 3, Z 1, vCU 0,=
 vl15 credits 0x44, CRC sizes 0x3
> [   19.722965] hfi1 0000:05:00.0: hfi1_0: Peer Link Width: tx rate 0x2, w=
idths 0x8
> [   19.722969] hfi1 0000:05:00.0: hfi1_0: Peer Device ID: 0xabc0, Revisio=
n 0x10
> [   19.722974] hfi1 0000:05:00.0: hfi1_0: Final LCB CRC mode: 1
> [   19.722979] hfi1 0000:05:00.0: hfi1_0: set_link_state: current VERIFY_=
CAP, new GOING_UP=20
> [   21.960278] hfi1 0000:05:00.0: hfi1_0: 8051: Link up
> [   21.960340] hfi1 0000:05:00.0: hfi1_0: set_link_state: current GOING_U=
P, new INIT (LINKUP)
> [   21.960350] hfi1 0000:05:00.0: hfi1_0: physical state changed to PHYS_=
LINKUP (0x5), phy 0x50
> [   21.960359] hfi1 0000:05:00.0: hfi1_0: Neighbor Guid 117501020d8fd4, T=
ype 1, Port Num 33
> [   21.960866] hfi1 0000:05:00.0: hfi1_0: Setting partition keys
> [   21.960879] hfi1 0000:05:00.0: hfi1_0: Fabric active lanes (width): tx=
 0xf (4), rx 0xf (4)
> [   21.960892] hfi1 0000:05:00.0: hfi1_0: logical state changed to PORT_I=
NIT (0x2)
> [   22.971450] hfi1 0000:05:00.0: hfi1_0: port 1: got a lid: 0x4
> [   22.971467] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 1 from 10240 t=
o 0
> [   22.971472] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 2 from 10240 t=
o 0
> [   22.971476] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 3 from 10240 t=
o 0
> [   22.971479] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 4 from 10240 t=
o 0
> [   22.971482] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 5 from 10240 t=
o 0
> [   22.971486] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 6 from 10240 t=
o 0
> [   22.971489] hfi1 0000:05:00.0: hfi1_0: MTU change on vl 7 from 10240 t=
o 0
> [   22.993233] hfi1 0000:05:00.0: hfi1_0: set_link_state: current INIT, n=
ew ARMED=20
> [   22.993246] hfi1 0000:05:00.0: hfi1_0: logical state changed to PORT_A=
RMED (0x3)
> [   22.993251] hfi1 0000:05:00.0: hfi1_0: send_idle_message: sending idle=
 message 0x103
> [   22.993273] hfi1 0000:05:00.0: hfi1_0: read_idle_message: read idle me=
ssage 0x103
> [   22.993281] hfi1 0000:05:00.0: hfi1_0: handle_sma_message: SMA message=
 0x1
> [   22.993292] hfi1 0000:05:00.0: hfi1_0: read_idle_message: read idle me=
ssage 0x103
> [   22.993295] hfi1 0000:05:00.0: hfi1_0: handle_sma_message: SMA message=
 0x1
> [   22.993604] hfi1 0000:05:00.0: hfi1_0: set_link_state: current ARMED, =
new ACTIVE=20
> [   22.993625] hfi1 0000:05:00.0: hfi1_0: logical state changed to PORT_A=
CTIVE (0x4)
> [   22.993633] hfi1 0000:05:00.0: hfi1_0: send_idle_message: sending idle=
 message 0x203
> [   23.014640] hfi1 0000:05:00.0: hfi1_0: read_idle_message: read idle me=
ssage 0x203
> [   23.014651] hfi1 0000:05:00.0: hfi1_0: handle_sma_message: SMA message=
 0x2
>=20
> Best,
> Rodrigo.

Hi Rodrigo,

Thanks for the bug report. We will look into this and see what we can come =
up
with. I've added some of my engineers to CC. Do you happen to have a crashd=
ump
perchance that you could upload to us?

Thanks

