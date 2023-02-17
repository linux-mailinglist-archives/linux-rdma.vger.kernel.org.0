Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15569B4E0
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Feb 2023 22:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBQVko (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Feb 2023 16:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQVkm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Feb 2023 16:40:42 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97060F8B
        for <linux-rdma@vger.kernel.org>; Fri, 17 Feb 2023 13:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irO5YAY2FFSxpkCA8M4iMu+2UTmzxbnSHXqHOem+YB+qTQOKi81cilM4pXUQAPGb8Ptnif3zXRWKEcctnKSVcC7boqi4B7Zy/GaU2IIIobV73/i9xqjUXdqAUCyEsB3i8HKVcFzlM4cAODlJiC8FrUWPRIDRZwn/roCFODDSA1hH4JHiK2kKl0SkfkUua43Nqyq9ttqnXPhr3gin6XXZFqmW3dWGPszSHP26C8sGI2tOr1WuQBEN1fYhiovOdyTDMHgj9FuF9UK04yjQvGZwy/5Ldmdg0IHpVYrwoCcD+4/4+7+mBO3JNVzC4zU2PXw4ky/6AmD5jg+xL6tk0W2j1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRsUqBFIDUws84XoX6epdLui2Z/DmoGCwM8iQ73SHzc=;
 b=dliq3kqsPdmGK+ez1QB+Me4o5gfD8UXKdXj7WVJTNTaHUvw3HamfXk1RPG70SetYuEAfD4jRFR0QA1OOX7XEsqz/8XfN4dTnF+0Uj1qW+06NB+Dfmw+dQ0Spb/B1pC33u5tV1Gb2TjPAJZO2mdnOUszpvlJ3cABAksLCsnM+3QhEQwjfjPQ7oAc6g67p07Oc83hFAzzcv7iPsKA4bq3r85fb+3RURmQbwGAcoy8y29VtSEWT6j44bQy1pK+L4YNuuU2KU6W6SzgC2INU/uuOgIROP91uq0Slds5idv4bAmNyA6nMDY6IH/ZEJ8th3zZYr43D+EN19Sy46qDGo8xsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRsUqBFIDUws84XoX6epdLui2Z/DmoGCwM8iQ73SHzc=;
 b=GtoD7lksK5W1Z1QV0ADixxhlo46/rbzEbdD10LMJML+x7eBbyM+wLKJAV2n3ai/w5R2+gxeGDtPqUCg+oAL1HXPwwlZiea3XsZzRIw+UvTtAE8l/zn3J3BUguW+gewcmiA6b9YJZs6/WbuW3dP4X4WQDUbtQCdeIl9fvg8XIVjIgJ5XtR2D1eRe+fOjVS0+02D3Oz/37z6AKTxJltJoGRUAC/PBjZeaHr2nrbBP6xzOepA86F9vkooh7fCRdnPkLlkWD1t1tHGrwgwW2Cvywz3zfMZ0ilry0F4yFMD24VHdDIxaGeprq8VucF/lqyelA2xC8iMevI2VMdwKRolTGuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 DM6PR01MB5594.prod.exchangelabs.com (2603:10b6:5:151::29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.15; Fri, 17 Feb 2023 21:40:34 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 21:40:34 +0000
Message-ID: <e21f555b-4429-fca0-b8b1-e3e1470261b4@cornelisnetworks.com>
Date:   Fri, 17 Feb 2023 16:40:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH for-next 0/3] Respin: Rework system pinning
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
 <Y+/maP/69VMafscx@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y+/maP/69VMafscx@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0067.prod.exchangelabs.com
 (2603:10b6:208:25::44) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|DM6PR01MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 466288d6-26bb-466b-cfe6-08db112f99c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBcHjfCldQuQA2bvoY5Zq68N0c5sOhNOIBQb0eT8o+wG7gb6juEL8yJJZUMAYWm6RrBQDStxAS33I/gH4OvHBlRr4397BDhVSi8CClEeNlrN4vYHqTSiRF9UffS7aTRhvOx6rvXBMvJZLxfBCceV1zJjnL1SBtiIvorTYLH1ScW7efOhOqfLp66AYzC9bv2wHJoJKyUOLNEGG1VQM2iRJ4QpUhrbNaGti51+M8TL8hAnjMt+oKNnugCQeqw4apO1NZXGKsP6qXwthibdU7tJD28TamXCCGtnvX8e/ywfg7MuKSYARyavmaKhTUKOwtBFhhbdlFcOlhc6LHPvDyfZRKFinLQzm8m07pauyQeiWXp968H4I2MStmDEGc1zOxjcRJUCBs6T0VoYbtXeiIHkcxPA05zrhqNp664wQQWFXxndzR6zayis8r07lyD3LRB83bSLj3Lo3+zUNCttxlsQFc6PMaEo3NZ5k7o/lv/6BK5TWMSqGS1Z8ukpkWtVgtEj5AdYDNFnWj6D4ai0H3WGH/aDm0yQXESTT4o5wgvPG4MLNIXms10uqo0cLV3fi7LKw+3cT4itPTHMUy92Uk2RMNshDcReWoSivWw36izTlAtXlzLjkezu9drjCSwXNATYMZ2PhOcQcO8+CuI9ZR1QqClOcX4cDPO1MRXYf2q7LtjT/8tk9dKFGc6eHyyaENQjtiA/SP3yEAZR+ei/hiqwXQCeBDMesSlpgqKlPPyGgP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39840400004)(136003)(366004)(376002)(396003)(451199018)(2616005)(5660300002)(41300700001)(44832011)(966005)(6486002)(36756003)(66476007)(66946007)(66556008)(6916009)(8676002)(86362001)(4326008)(31696002)(316002)(54906003)(478600001)(8936002)(52116002)(2906002)(31686004)(38100700002)(26005)(186003)(53546011)(6506007)(38350700002)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGQxRFZUa1FWbWJWS29Nb29BTjRpS1pyZklNWGFBQWFHbzRldU45S1JKN0NL?=
 =?utf-8?B?VDM1bitaSkVXVk5sUmo3aThOQ29iNVdzSmZrY0hMV0RsTXcyWmxBa3FCWStG?=
 =?utf-8?B?bEEzSTJCYS9GTG9SUnJHa1lqaVB6eUx1Z1IvTDZzNTFxY1pzNXZwTGJsbGxS?=
 =?utf-8?B?VUlUUVhZelA4Sy9xeXpvbkxJazJTSVVieWNFMThjTjJFOVh3YVRuVEZOUEVB?=
 =?utf-8?B?NmhFTFpyK2xybGZybHVYUkV6Qm5CdlU5bHNDT01pSFdzWHJ4YlJCVXpYS2o1?=
 =?utf-8?B?ZDBXUWpycGxxNTlYdWRoK3EwbTFxYTFOUFUxZ3EzYkkwc0twOW9TeUU3TFlI?=
 =?utf-8?B?RGwvM2R4MzBYMUFrRW1zMkVHdm1wQnFROUFmZUREWHgxQWQvWXdoOU1NOThl?=
 =?utf-8?B?UGkrSWU0NThHY01laS9wYllCQkZZUGcvSjFTeWNML3hGMWxPdUtBcUNieEhR?=
 =?utf-8?B?RjdJbFN4RHV2QU01OVduMUNwOHlMeVFOQXFaWGJpbkhHS0tPSkg0NU5ESGlG?=
 =?utf-8?B?RW9zeWJXSnRMSWFyejA1ekhLTGxoMUpsK0Z4THI5dWlHKzhBTjJBSWljWlp5?=
 =?utf-8?B?OFIxYmdUS0dWNWlxN1gvc2JrWjh4NWhwNVhQNzRzT1Zwd2ZTRTB0N3BZSjNu?=
 =?utf-8?B?c05HR0dCYlJhSndnN2NESDcvQUdock9kbnNVdDkwYUtFQkxjMmI2TElRSnBQ?=
 =?utf-8?B?cmxxaERGelF4NThyLy9neU5LVG5OcXNzb0tqZ3B2L1ZZdlY5a2NjOXJIelh4?=
 =?utf-8?B?dzcyNHNDTFZNZ3ltc1ZuMGRTZG1ITTY2eGUwd29uNS9kSTNaNTFacE5Wek8w?=
 =?utf-8?B?Z3F4K2hzQnBSb1RrL1dNVFd5QnFmSUpBU1pBM0hyRHNlOUJYVGdKZTRuNEJv?=
 =?utf-8?B?eDZ2dTJuT0lYdGRvN3BJNFpNWVFXOXRtZ2JmUmtBY1NRdER2NC9QWG0rOG8v?=
 =?utf-8?B?WVJ3OGlPc2tnM2xYZWdack1WWXFGZVV4dzZ4Q21QMk1RZ2E4a0hYTkZwRjNi?=
 =?utf-8?B?TVVZQVdod0EzUTc1SXdHM0cwcnIwRFR1SDRGQWtpeWJuWWMvd1QwTTBCZmVi?=
 =?utf-8?B?MmZ5dlQ2QXdJZXhpTUQyMWFudFZiZEo4UWlxREh1bXNLQUVoWGNLVEEwTlRr?=
 =?utf-8?B?MWNjb2R6VUN0a3p0WDNvbnpoNUFRd1A3VEN0UCt2L1hJQUtDblRNRFpHUTlV?=
 =?utf-8?B?V2NZdHJGdFFXN25TSWtYdXFMb1phazNvRWVJTEpnMkVEOTljeWVwZ1ZYbHFa?=
 =?utf-8?B?Tit0b3hlNnlDU1dSWTZCMElmazRFdGZ5VWZFY0xvV3lpV0s3K0tRdzNJcGx2?=
 =?utf-8?B?eGdXSEdERGJiYzNuS25VNGF2ZmhnL2xKVzhDdmo5ejFheThmeHdlSWpjY1pL?=
 =?utf-8?B?aGtGV3ZvSUkzTGR6VFppbXlGRVptNzU0ZnZ6bWplQmRWZzhmdG9ua3RIUkxC?=
 =?utf-8?B?NldkQkMvVXVQTmdqRk5NYzBxRXo1MVo3RjZKMTd2aVZ4YVFpKy9CRGVjSkFB?=
 =?utf-8?B?amVjQ1ZvYkdaUmxGRFNmcVA4YXZwTHNrYVpLSWx1ZHlCVlZOSm4vSkpnMXoz?=
 =?utf-8?B?bnhSRDFDSndyYVd4TVR4ZDJ5cGZMSWx3Ump3ZDllcktDWEVLNzBhc3YzeVpJ?=
 =?utf-8?B?SDFnT2xzbTlsSFUyS1p6dktnWkMwZVJENUZvc0Zaa2VyYXQ2S1hWd29VcGhN?=
 =?utf-8?B?bXY4MHZoR0RsTlFRT0dNcWFlOGxrTGxKT1BLNWwyWU5LNDJMVmluNzc1V01R?=
 =?utf-8?B?U1NUOWZ3Z1FHTGRUbTg2eE9KNjRLVEhrbCtwQ0JSKzZiajRrWWpDb1lPSGcr?=
 =?utf-8?B?RFowak8xQ3hJSnlXNHdGbGRRQzgwT2FibGtvRlNmb3hDZVFwbTMvTndtQThU?=
 =?utf-8?B?ZC9KQVowaXVVbXhpbXlHTVdrRU14VGNIdWVaVGlZcDc0Z3lBMEEwaVROeEd3?=
 =?utf-8?B?ekdxM2xES2tSZmJhNDc4U2lJbG9qd284ejYvaXg5T2hMbzBJM1o5MjFrYXg5?=
 =?utf-8?B?cHFTZ0pPeWtSSUVHQWFwUjF5YWNsS0VCanZUK3FmQzF6R1krSkJwRFVTWjJj?=
 =?utf-8?B?MjJjdVNDRTRndGR0VngwUTdXcVhrUlRkSnFSMWxNMys0Y0tnRkZoRHpGeUU5?=
 =?utf-8?B?VEk1SHM0djhXMHVJMXVUamF1NURMdDduRFJGT0J5ZWxCa1dEMjRQZnZGbHFy?=
 =?utf-8?Q?bBxt2q5A3S3zFULqv2IM/8g=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466288d6-26bb-466b-cfe6-08db112f99c8
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 21:40:34.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8N+sdOwjNpTklWTnGTBRrHSup/VcMomYk8ipGgeuiZAJBJVBJfIzFxdvVTs72TYpQghI3kL1Mb9FWXObxY3ttCrL8VUDZfCeKE0sLHiOuy7wdT8oQONTSE7yKLE+eJ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5594
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/17/23 3:41 PM, Jason Gunthorpe wrote:
> On Thu, Feb 16, 2023 at 11:56:18AM -0500, Dennis Dalessandro wrote:
>> This is a respin on top of the latest rdma/for-next branch
>> of the series being discussed on the list here:
>> https://lore.kernel.org/linux-rdma/Y+EbyU4HkGyzPoFO@nvidia.com/T/#ma3d153151adf1dbe2b9800000fa9a01f95a80c1f
>>
>> We have added fixes lines, and Brendan has discovered a couple code hunks that
>> do not need to be here in this submission. We have also removed the stats stuff
>> until the user side code is readily available.
>>
>> ---
>>
>> Patrick Kelsey (3):
>>       IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
>>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
> 
> I took these two
> 
>>       IB/hfi1: Do SDMA memory-pinning through hfi1's pinning interface
> 
> But really? This is almost a thousand lines in just one patch, is that
> really justified? Can you break it up?

The bulk of the code is moving functions from user_sdma.c and others into a new
file, pin_system.c.

Not sure a bunch of commits "move XZY to pin_system.c" would be very helpful.

To be fair, the patch was posted originally almost 6 weeks ago. In that time no
one has said anything so I don't think there are a bunch of people chomping at
the bit to review this. Any suggestions to make it easier for your review?

-Denny
