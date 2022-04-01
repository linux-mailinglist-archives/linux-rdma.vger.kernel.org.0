Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF24EEE29
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiDANd4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Apr 2022 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346368AbiDANdz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Apr 2022 09:33:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB927DEB5;
        Fri,  1 Apr 2022 06:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4bjpTFJ+Xqvj0UzUD/I3SpW0/n8MikqhAtPTR0zChP1LmzdQ5qRnC1WbQKE9CGBGcVy+lLNnoVBslOCVqr8tRNKPcYB4v3O+VqgUBt+z0Lvw4rXhbO3iQPnl1nDojeYo61kiT3crqZZ8oRfGQGd5sftUpdEL5Leonb+L/Kr2Rpu3uDt8QM+q3EvRaFceAdaclDDidlXEea98EraLrmMQbZBmGAJLCTBy0tBJwuS3AZo01JsL49pUMe9Sg0pbGAWFKqZcmE5cONpDg51Sheui8PR2b+SNlXi+dy+2Hyg0zt3bcGnu/o2oPcQhrTvFoWzxsXI+MX49aO33QbcLyyvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qPUKTXI0xU1RdeTgvGf+7+HtufL5BZDEmu9MmfC21g=;
 b=bBEyL/kDey5p2Qj5bSNJm/GQWM0HVsR/5kH6n7/DzABLRiLE6K5Zrx3be8SPUngCNfU7pwH3k2BiNaEmMYrKN9PPliG2+7nbrllrCMI2MidtzNgqakkOa53/7LshiTMyHscG4Wb+7nlWVGZ1jYvWHXZMbZf/3SKpXfAKW7CuRzDhHchLl4pxY9c7+fK6py0QhMFMUFWUcD9E0NWNy9JK2QBWUGjrJR4fr+q3sw7AUuj2TsYORsN0dljAIgTwhI5k/2t6HWJ2r5oAcS9zoOt+jPwvVFPAWVl4ey/2cTixyHMf2wyG+4GXpM0cFzcrQx+rey2c50KJicL6MkFTyuIvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qPUKTXI0xU1RdeTgvGf+7+HtufL5BZDEmu9MmfC21g=;
 b=NDO6jpu+YRIUnz1aTROTb65aii5Ryf7QbXdJNB5Ih9fydKHt4N7hnj3Rbdef+dBcSusRmHGW0sdyeOqovFGpueOdJE2zSzDaVDst4ecZShIQlw/YRV9Xhvp4dCgn3pINM7DJT8s0wzKmdatZO7UWDN9bti/bz3cR45DJzsrLEtyKf+ZGJ5QE2cJZms2xXOeBpvinBo/3smgsF1jRxlLjTYL0/3Zw/UJ+CP/sU6/ojLnJabHuVDMO5yL054J33rqkcvDNk+/3LBOXru7UlKILeUQjkf28/ek+1UJtXoWpaBmWa3dl9e6/PkQcQzBoe112YYfxDTG5xKffGh7WAqWSRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 MN2PR01MB5918.prod.exchangelabs.com (2603:10b6:208:196::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.16; Fri, 1 Apr 2022 13:32:04 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875])
 by PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875%5]) with
 mapi id 15.20.5102.025; Fri, 1 Apr 2022 13:32:04 +0000
Message-ID: <946d2ce4-d9cc-d35f-714b-7bea5436a7c3@cornelisnetworks.com>
Date:   Fri, 1 Apr 2022 09:32:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] RDMA: Replace zero-length array with flexible-array
 member
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, cgel.zte@gmail.com
Cc:     mike.marciniszyn@cornelisnetworks.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220401075406.2407294-1-lv.ruyi@zte.com.cn>
 <20220401115039.GO64706@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220401115039.GO64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:208:23b::7) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7eb0e15-02bb-49bb-5fa6-08da13e40281
X-MS-TrafficTypeDiagnostic: MN2PR01MB5918:EE_
X-Microsoft-Antispam-PRVS: <MN2PR01MB5918C66B8A1B691B25772EA7F4E09@MN2PR01MB5918.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6d6+1tBNrDCMGn+iIQpIksPxM5tT4SFBfj9eODCQ7mBSKYiJzdWThw+DBQTBQRwhVykMVw5nCVSmJE2vHxshyG4DRAEngsre/IXvGxMjd3/Qbg7lfDq4ZMKkAPTlqMaCcP3ize3MXh3rCIZ0WmzVBbUhZCkyc/dhb8gzw9rsULvxxLaCBPC8R2GxYY5MEtmsfZQKV9AgZ2WJ76/O2Oe0YsFn/SJqOHiCnPZmavC+tXuhFPOxUaOp4mNB6uhaXRd4aRVQ4ryHIXdBAzv9LJkmeDhR8Ur2m84nKCzgwJD3b5X/1vW7nfyWukn26PT4YjQ5q+ub6lqeWOxunZyGVDbfR28ix6FA+o88u/LwWB9rhF6Cs4G1dF0685E3LRZHDreT3+vfR+D6AyQweuQx0WPfY1Nywkq7SUWS3IHX25/asrCRUwCrrZpUArv5uKhT0NI7imhh9UcxTcjBSdD7iVxKc7tPJApPEfFfqe+fipZWUiiWEbY7KurCAuYjuUZ/n4ucEJs/dFFCtWsCUvR/KCDuJnT4pFxXZARgWqMP3YkNkL2ZK2H4OC0yzqEum/yzwcNh5LHURjSmwR39MDTnWU0FaZJRX6fBx3Vqa1UAqIQXiLjV+XqAM4CcEX225I2WIZXpxCNJ7Ng1W6KOEoNgfUV1b7HzvtGH/UazIpK3VxxuYn10EoenkyWtxjSiTW3bQAO9X7Q7qdSh6uQLVtLB5Ka+Hgj2vI3Xr30lQIzq8kbuB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(366004)(396003)(39840400004)(346002)(136003)(31696002)(66946007)(86362001)(44832011)(66556008)(38100700002)(8676002)(38350700002)(2906002)(66476007)(4744005)(4326008)(6512007)(5660300002)(186003)(2616005)(8936002)(53546011)(36756003)(508600001)(52116002)(26005)(6506007)(31686004)(54906003)(6666004)(316002)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0QybXNrZ01CMmRaR1NneVVvdE1OSzRtQTlVTVJQZGpUeFdDa1pJUDNFYW9v?=
 =?utf-8?B?RUtxNlAyYXl3ZTNxeUxObTZsd2FzOVMrNTZmTnZPT05yeWE2MjZYR3BmdENh?=
 =?utf-8?B?djc3Vk94KzYwM21WZ3F5TkVaNU9qY1NFc2V6a0RtTnhqUmhpQ3BJamxzZlZM?=
 =?utf-8?B?TkxqMEx6VjFaMUt1aDcyUkduc0FqekhBekJBMHVPc3VUZEd2Z041MHdibkJ0?=
 =?utf-8?B?MERZNVJVL09xd0hSYXlLeFEvakh1eHVIajFoUE5ZQitaV0FVWDVFRVp5dWJ3?=
 =?utf-8?B?VzArQzdxWFFvQXBIWlJQdmVZbzhuRzVpSkJKdXpFd29ET1NuRU40clMyMG1w?=
 =?utf-8?B?S2RJZUp3SGo3bDN0S2dJemc2b0F3Sjd3R0lRakRJbDNnK1g2WEplT3IzNkor?=
 =?utf-8?B?OEhqNDA3OGZCaXNiVHdEZDkraVFKRWFRVXhYRWRaVytMdG9OU2JjeGNOM25I?=
 =?utf-8?B?K053S2I4OTFGblQ2dFVMRGpvUUN5b3laOTNZN1NuMkJjYlpEdWpNdHp2all3?=
 =?utf-8?B?VTZqWkFEYytHdi9oem53bkNCN0xlWXVpL2crN3MyTHFpaGV6QlVJWmttdGNT?=
 =?utf-8?B?WWhZMDEzZnptR0ljSjlXSHg2L2p5RmVvMDF2Nml5bWtieE5CdHVqVUgxbHdY?=
 =?utf-8?B?NmhUZDJVVFNVUEpUb1pDNlpSemFlbXZzOUJYNHVidzRQeEFkVnBLUVR0a0Ri?=
 =?utf-8?B?aTM0RjQ0VkkyUGMyQnVNOFNidllaOVV2UmdEcXozdlIxd2FXUk0waFZKNHgr?=
 =?utf-8?B?R1FkSVZKMXhzNUNpWmJVTVFleENLMDJOOERzTi93MmR2ZmlJUWZaTm9UWVl0?=
 =?utf-8?B?TmZCQSt0bjdRa2dReFdhVFh6U05sNnRxdFlIazNLN3lxU0gybEhlM1UxSzZJ?=
 =?utf-8?B?T1J2ZFJkS3dUNlhJN1NLY2NFVXFBWVQ0SW8yWHB4ZTVHeDJGQVBkRTUvSW9D?=
 =?utf-8?B?UGYwOGR3VHNTN3Jhd0VHZEtMZzRxRXJEQ2RsUmVaRzdabHhZOHdYWGpnRDcx?=
 =?utf-8?B?Nm5IMU5RK0dHZXVSbEg2VXJ6bzV0cGIwTno2YzJXZFV2enpocDhZZ1l6QXlF?=
 =?utf-8?B?dnB5TjdMaytmSnhSVjR1RlV2NTlNd3hlSFZpUTQvMEltTFdVN1dLYjJremUw?=
 =?utf-8?B?VkhDVzJaNGQzSkpHZFNHZmJYK2JHNWtESTNicjQ2cnQreDE4REJlMWhYSk8w?=
 =?utf-8?B?T3N2M0lVSUZzN3lzRDF2TmxML2dmRWJYMFlQaUNCOTRNYkNJZjBCZEpJVW5h?=
 =?utf-8?B?QXowM0FPeXhGdHdtWCtuTlU5UGNQaG5pU2Q1N0RqL0dTNXdkSkdmWS9XR1Jo?=
 =?utf-8?B?M3lkZkhrV0N5dk5tZ2NVMHN4c1o3TmpxSDA0Ukg3REw3ZDJSWlUvSHJNT3RI?=
 =?utf-8?B?dW9hZm96SnY4MGFlbHVZOE04UE9QSytlcVBGRS92eHp3VWI5REhaLzhSS1l3?=
 =?utf-8?B?T0U3V0d4RFR2M3FlK2FJM0w0QXRpajJmZ3dpNnR0R0p5RlVuUHpwVVpoV3pF?=
 =?utf-8?B?OGdWY2JhdHlla21sMXU0SEl2UDNuMXBWa3JDWFBQc2RlTVVCNkt2VHpKRGdT?=
 =?utf-8?B?VmQzMVZJbnlrOFVQSE5iUWRjRy95ZS8zNVgwZTB2WWdUWEhXUmFpYnY2bEdN?=
 =?utf-8?B?d09Eb2FRbHJCY0FKeXZTNkZjeGFjWURuQkFxV3VYNk5OaktVNjBuenJ4Sjl1?=
 =?utf-8?B?dWsvdXhWUEZWVkNPU1NnL2hYNWZnYldRUkhsMSt6NFN3TkYyTzVZMTZWTjRN?=
 =?utf-8?B?NVhhcExZckZra1IyVHhRTm1ncWx6MC9JYzdBOFVHOWJSWTRkdTVsNUVaWks2?=
 =?utf-8?B?dnBBRmpINll6OWFWTUdPenlSTmNXTGg4b3VkdmJvWkM3aC9hRVNHNGdPWkpi?=
 =?utf-8?B?UUgzWnlMZkEwQXF6Y0R4RmxydktCM1cza25WV3FnSTQ1TlZOc0pMRFFrYXp3?=
 =?utf-8?B?K1BmaWkrTlhtZWNvQXBJb2RCV0xCeStMVElyZVZzbVptYnh2VFdZRElLZis0?=
 =?utf-8?B?eG5pMC80UndtRTRsaHA0YXM1YjQrSFNHZDVsTExKOWN4aUJqL3Z6R21ZQWFF?=
 =?utf-8?B?b0QzVGV5K3FQNDlCZjVpSU9ab29yLzM5ZjRvd043RkJlamYxbGhOUG4zMWxZ?=
 =?utf-8?B?Q2dCRjBCaUFNTEwvdGdxOHAvRXJMMUxwRWdzTVpPeEgrT004OXdjYTRQOG4w?=
 =?utf-8?B?SEtLbFJaWTkwMi90ME9TSGp5OWFLL1Q5VmhVc1YxbEVYSm5kL1dhQk1DdGRn?=
 =?utf-8?B?MHhjQW5LdHZNMkorUGV5MjRHQTdxUVJMWFFsTlptNnk3MlN6RjloQStQVi9J?=
 =?utf-8?B?N0dxMlVXUHhXakk3V3pPcXRLdXNMVjAwMUxOdmo3Tnh6LzRhUnAzNDBuamJC?=
 =?utf-8?Q?dmnDU2aV7PedYRlCKXn7EFRmNNzwKZlUE2SC9?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eb0e15-02bb-49bb-5fa6-08da13e40281
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 13:32:04.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlASNO60MzCy55GkLS0A+ssNB15nl6MmYjPkzQzmHFO5Tbv26aJmq/VFT2VpwO3l67VLezSX2UP2fXLw090m+W2MsycBiuubaUfZBJ43umL7hm2YmVfHM4HPlPEvnf0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5918
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/1/22 7:50 AM, Jason Gunthorpe wrote:
> On Fri, Apr 01, 2022 at 07:54:06AM +0000, cgel.zte@gmail.com wrote:
>> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>>
>> There is a regular need in the kernel to provide a way to declare
>> having a dynamically sized set of trailing elements in a structure.
>> Kernel code should always use “flexible array members”[1] for these
>> cases. The older style of one-element or zero-length arrays should
>> no longer be used[2].
> 
> If I recall properly this doesn't work if the flex array is nested
> inside another member.. Not sure what this thinks it is doing anyhow

I was under the impression that the main goal of using the flex array was so
that people didn't calculate sizes incorrectly. Perhaps I'm wrong though.
I don't really see this being needed. If it even works when nested as Jason
mentioned.

Now that being said there is some clean up that needs to be done to this code,
but it's not this.

-Denny
