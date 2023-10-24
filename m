Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306AB7D5689
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbjJXPet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjJXPep (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 11:34:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2111.outbound.protection.outlook.com [40.107.243.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38786199F;
        Tue, 24 Oct 2023 08:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9lUgT147BbJBDcWaGkC5KAet7hupU34AumN7oHjMJQ+4+9fx/AcPviD2GYfctRinNeb3gDxhpCuqXxn+j576acxSvxg2Ub+jZjgco5JHQDl/0cdYirPs6pTo701hMVz/cJCC7XHa0oFYqye+TUOK/Y57XwVyXV96m685AyTkG7q72brwRDkoTktLnizHx/CBRiTHITlobmyuUkbT51pSL86e59u3W0Cx62RLsADi96MuHxuRoKoiM9WwTjoVAvZgNtsN9Mg2LJesc+GLC7xR836KgFwl3VghouyyOQzww/moeAsv/fhOZCK3O9q25y8J+tDRpJtFw46w+Ts/Go6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F54Inf1lbqurgzkeW5aIXmUs4AjAX7TGDi5wNzFDnZ8=;
 b=CkGVl8NvPdrdof/CFWcWWs+MGB8P3545dhI1FRnJ+/sEXOZ69K8X9hc/sHB1Cr66dI9zqi36UQYhU0wCtiqHx2nxG1I4CI135rEN886Qiy3chnqqR2Liu/j/3johcMmq0ANoGGfGIfLbxOOyun0gP42XN40j8G+fNnp9obq/htyZ6HZgE6WXB40q8sL2r18RJ4Np9h3K8rQNiZhBCHhUgfz/qvkdtm2svYlPR5aYiRmcZb9AtzgH0Jlt+d6Caaw4+Q3qrq4FhoGuge08BkO9d/S+xqpbHUDyq+kTimBUxdAGmczmDKTO5Mi2ZN25yqSAiKZDTw8adv38JwjeFVPZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F54Inf1lbqurgzkeW5aIXmUs4AjAX7TGDi5wNzFDnZ8=;
 b=Lh9Dkh0Q1dSLXEn1JyTzrTrkY4WzUsO5C1xHf/4wTaqX2lLWcfug7zF2DgE2loTmhiNDKK3hsJ2AX7CgyDMkBiWs+2/+ytwFshGtF+PBdDlPd7u2A0VEue/cxQGSsjelh73vTlXsWA1U0wuzw/ewGNO5TPFCsO+pkh0Ki8erBUB4+QiK7d6nMS3pTkjjRsXp0/wrMwKtdiF5Hm7Q3d9MFww1/2oq1fFZXm46xejNgtN61BhC6vOghKqN7KThK/mIbZbYMeBVMLsNgr0O2zYvFa9ZInoqZcstimnQw8eMWA9+zYh6Aubo0ZhlBh9dcNN3YFKOBAgOHZqRRm9M9hCYHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 DM8PR01MB7128.prod.exchangelabs.com (2603:10b6:5:315::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 24 Oct 2023 15:26:11 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::556:fc8b:6a09:c7be]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::556:fc8b:6a09:c7be%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 15:26:11 +0000
Message-ID: <06144079-786f-d2b3-e07e-cdea5a55ba0a@cornelisnetworks.com>
Date:   Tue, 24 Oct 2023 11:26:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &irq_src_lock and
 &dd->uctxt_lock
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Chengfeng Ye <dg573847474@gmail.com>
Cc:     leon@kernel.org, dean.luick@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230926101116.2797-1-dg573847474@gmail.com>
 <20231023160110.GA886087@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20231023160110.GA886087@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:208:120::27) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|DM8PR01MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 02674d45-1405-4904-5743-08dbd4a58da3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4JE677XSedqUGwgyxMuqCALc7mYO42VGK7QeCOLtWVeyK+Mkih0ft1cH0S8SKoiTZjLcUD32TDYafUFwKJ7XRzDm29YvGU0CIM4bEZHj+xEln15SzqovRTiE6GyJPZ8i6ayEeSLES+eH8zbLcW5sRM9SyFDOqFYdax8cHfsAzaIbSDv28dwA2KCxfGuXTL3yvHWX76RAtJNfVKKpjAjEG/EaivqI5nfum1K3hhmHf3toFUxj9XnctUHa90LlQC2QCBqI9l9gW0dI9Pr8pOc8H+52afu7dWTtK2xRJylwiO0mV8LEGigVcVA6SEKHufgyZXFI7o2KzIbENQCI2uaY3Som8mNd77OGxtByBfVwydowIyPVdrZEJWUaSDsQbP/rrjBmB27eSE1iKTzh8qMN/VCi55GOzzBEhkqsA8xNSkiGx9oTMlhVlplH0FUKAIiHtoupEYj4AVsDZyoMh6WkVHuPGioVU+CBGAcYbPM857ztdLeZcxgRXvlXKEQcIp+aixoSsj1YXbNJudO+nV7kRvwh0ddFoVbCoA7mG5DKWJ/9Cqzlw53OGSbtjRRWfsFuBWQhbf745f31fn2sasG4Z1YRzBUHHcTDhkRY2kLn3eFBz8b6JL7/nOa78IxpthkX0iPFnF2B2SNyo6dHB7HKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39840400004)(366004)(451199024)(1800799009)(186009)(64100799003)(31686004)(41300700001)(2906002)(83380400001)(4326008)(38350700005)(5660300002)(36756003)(44832011)(8936002)(8676002)(316002)(66556008)(66476007)(66946007)(110136005)(478600001)(6512007)(86362001)(6506007)(52116002)(53546011)(31696002)(26005)(2616005)(6486002)(38100700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjlHTGNWVlpLRGZQNlpEdXNYdjRLZmo2cjhOdDFtZ0JJbmIzVDZIUUtKVmUr?=
 =?utf-8?B?Q0JzbXZhYjkxYlNEaEIyTng1U0NwaEtqZDEvNDQrai9MZDJOK1Z3Ym04UEs1?=
 =?utf-8?B?elRZbGpBamRJaVJmZC85Smo4Z2s2Sk13U3M2a0ZYYTZjYWZQRUpwbG5iWDd2?=
 =?utf-8?B?MHk1cm42WFFXL0h0a2hkK0hRNmVxOStlbFRaNVl0d0dkM2ZrS0pUUEtTSGI5?=
 =?utf-8?B?bXBOeVFsRWF0WXVFTHF1Y3h4MUJycisrN0NqMUlQempQQmVkdWwzWTZZOXF1?=
 =?utf-8?B?QnZOTnhxakI4WWx4Znk4VDQ1VFNIZldFRDNlb2NjVWhFck1VTkJlNmI0Qkdw?=
 =?utf-8?B?K3g1ZVBVcnJTbGJ5VUh5ZElGSjhSQ1V2cVkyck9qTzRQMHB2d0EzTXdLMnRj?=
 =?utf-8?B?WHpOLzBPNDZlcXBzdUlTbU5kRDJ2OUZ5bWN3eVpLa1BQNEdMV1JpWG1BcTFr?=
 =?utf-8?B?RWtRd2g5d0l1M2EyL0VlTkxzd2hHYS9PSjlMaFNFcERjUTFGZHl3aFQzd2JP?=
 =?utf-8?B?Z1dGenhQQUIxc1lsaFlyWXpBNTB1YldnVkE0N2dlbWtqWTBFVnkxbGxiWXpp?=
 =?utf-8?B?ZnQ3QWgwZUVpS09vWEQzVnQvQ3hzdzZiOTFJejRlbGxNeHp6elFWK1dEM1Nj?=
 =?utf-8?B?anFaVFVUSWpQL090Y2FOOU9LdDJsQ2o2TlpIR3VLSnkrdElzRXZxOWltcCtL?=
 =?utf-8?B?dVNZN0NMNnN2UmdrcURZZWJ1eEh1T09scDgxSXZycmNweHZOdlRmNzNIVmZS?=
 =?utf-8?B?ejdMSzdsSkFOYXB5SkRIRDlEUk5aNmlBTWdRM2xoWGVxTUQ0UWFoa0ZoeEsz?=
 =?utf-8?B?c1h0L1Y4K1BGVlBmTUNlcy9qemJ4WGZXQnVtZlBzbWY1TEd2Zklxb1B6QUVy?=
 =?utf-8?B?S2FyaDlGYTQxK21nOEVTK0lqZjBnMDBOM2JsTThjYTZTQXEyUGp2Tk1PYWpP?=
 =?utf-8?B?Q2lkL0E4cHRlaVVWdk1mL2JKMTRuSWxTejlJeFZNS1lkU1lqQ3Vvb2tPcmJF?=
 =?utf-8?B?ZDNNekJSN1RDVzFCTk5pR2NjclFBQ0VVajBydkNPRW81TVJiVEh2SzRyc01D?=
 =?utf-8?B?cXlBdmpUZ2tnclhrV1ZWNE1HSWtQdXBYWlJGc0tVOE1UWFBzQW5veHBRN0lD?=
 =?utf-8?B?MWc4YW93SzA1cktFSjVkb2tIWGtFUzJ1SCsrTEh0dkF6ZFNrWWhGeU9ySkNT?=
 =?utf-8?B?TW9IbHZWZDhLd3dHMlNUSm9TTUExVjFZUllTL2RwYVJpYllDTFh6WU9WTzBD?=
 =?utf-8?B?aXBaTG9TZ1pIb0hFb2lzTTA3Vnh5RXFNcjdHcmJUSXBFNFkySnU4bzRZVFNp?=
 =?utf-8?B?cW5mQmtXMmVzTERRYWpheTJINmU4cm9zVktWTG5GYjFpT29FdEFZYzk5VG9m?=
 =?utf-8?B?ZmEwUnIxMVUzdThZVHNjSmZDNVVERHIvODhOa3F2Q0lRb1l2aXdiblJDWldL?=
 =?utf-8?B?bGdMb3ZSQ3NOMGo5M3pTd0VDenVCTjR4bFBHUWZ2bFRBQ0QyLy9KNlJNSjZm?=
 =?utf-8?B?dEIxb3Z2RG1LUEoyK2pEYlozODZ5QXFlTHZvVGZaWnQ5Z2E2OXRMRnJMcUxP?=
 =?utf-8?B?eS85Rmo2cFFWNEx2dzlxd2pNQU1rWWdxVGJoK1JSd3BQZUtDdnNDbVE0Z1la?=
 =?utf-8?B?ME4rbGZETW1IaVp6c3ErOFVYcHZacjIwdVlrSzhhVU93NndkZVhwWDNqQ2hM?=
 =?utf-8?B?UHBVR0xWUXgwNEdtRGJobEJ5MW9XeG5hekQ4TmNBYTg1ZjcwWjFVSi9TOFRM?=
 =?utf-8?B?cjllM3g4VGdjUFpadG5HYy9VTU5HZjFzNFhBQlMvZTBQUWNYRlpTdi9QcUJ5?=
 =?utf-8?B?TEx4WnkxVytXSkR6eXJ2VVdhSStCeTh6VzVPbHlkbXo3VGZKbDRyMEN4b2FC?=
 =?utf-8?B?Z00vSm9IdGMzYWJWbzdIaXYxYUJINkZwZ0V5NG0vNTdnMDRXdHptV05HQ2xN?=
 =?utf-8?B?dDFKeGFnTC8rcXFkYjJMancvNXc4UExyU0dWd2gzNWlVNTZPYkQ4QXRrMFJs?=
 =?utf-8?B?QXV4Y2MrVS9keTZ0SEdFRUlCNGN0N0NBRUR6SVYrUDYwTkpOSGxpREd1WHM3?=
 =?utf-8?B?NXVRQitOYTBDMzNqcHZLbXdCcmZwekEwNHRJZUl1VHI0c2dPM3h4NkJPai95?=
 =?utf-8?B?L0srQzV4c3llWE1FOUR4R1pqaVZqQnBWQXZYWmFtQlM5VUNXdW1hK0Ixb0dq?=
 =?utf-8?Q?/0T1BrMS/dnFtS+2ASX4q7k=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02674d45-1405-4904-5743-08dbd4a58da3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:26:11.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyxMiSvwz1Zrixh5qbt87W7eQgTMU5vrnaFtzFz1iI1Tv55sLrBJHxbh4KZHaDOIMQkzvMIqW5fzQEaisNCFvblIWPSxDcg8EPXUniUYypVZtU4uvLbJHYGi/Eu4PdW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7128
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/23/23 12:01 PM, Jason Gunthorpe wrote:
> On Tue, Sep 26, 2023 at 10:11:16AM +0000, Chengfeng Ye wrote:
>> handle_receive_interrupt_napi_sp() running inside interrupt handler
>> could introduce inverse lock ordering between &dd->irq_src_lock
>> and &dd->uctxt_lock, if read_mod_write() is preempted by the isr.
>>
>>           [CPU0]                                        |          [CPU1]
>> hfi1_ipoib_dev_open()                                   |
>> --> hfi1_netdev_enable_queues()                         |
>> --> enable_queues(rx)                                   |
>> --> hfi1_rcvctrl()                                      |
>> --> set_intr_bits()                                     |
>> --> read_mod_write()                                    |
>> --> spin_lock(&dd->irq_src_lock)                        |
>>                                                         | hfi1_poll()
>>                                                         | --> poll_next()
>>                                                         | --> spin_lock_irq(&dd->uctxt_lock)
>>                                                         |
>>                                                         | --> hfi1_rcvctrl()
>>                                                         | --> set_intr_bits()
>>                                                         | --> read_mod_write()
>>                                                         | --> spin_lock(&dd->irq_src_lock)
>> <interrupt>                                             |
>>    --> handle_receive_interrupt_napi_sp()               |
>>    --> set_all_fastpath()                               |
>>    --> hfi1_rcd_get_by_index()                          |
>>    --> spin_lock_irqsave(&dd->uctxt_lock)               |
>>
>> This flaw was found by an experimental static analysis tool I am
>> developing for irq-related deadlock.
>>
>> To prevent the potential deadlock, the patch use spin_lock_irqsave()
>> on &dd->irq_src_lock inside read_mod_write() to prevent the possible
>> deadlock scenario.
>>
>> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
>> ---
>>  drivers/infiniband/hw/hfi1/chip.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Dennis? This needs your ack/nack

Looks like we need to disable the interrupt. Sorry for the delay.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
