Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770F567598B
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 17:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjATQJW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjATQJV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 11:09:21 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C87AF31
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 08:09:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPi+t2UVKlzPPIta72TmNZXYaNqr4gGFau6R77VTtc4ft0jG7EWnH0swij+OfYPh0+/Jlwtk+PBlNm3lC5q7ne3DXHcLX58ijfq2gc0FVVZbtt/gQoaLoAFg0XLw+yxtObVCM5LpTCYkzxsMO/NmCxtkwvx1mZNAUUElJ0LcffCKzoxZHoMw5+EM863MLg78zPIubwtlobWytJobmqhjzKkfDtktnquGUP/SbiGXdnrwJKasI7q8P6UAIsxSPu7uwBIcPL8GXa9pO8+HhB0aVrz+J2vuXpMq8Ccn6/CuriWotat4VBVX5mg5Pw60DCu3q12K3vNRUvYCG8HStgm2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU0DmTielf9V2ykUdZZFS4OUmLmSe/OM/4tKcD6mfYo=;
 b=E4rqPKnfxyb2auyLQ4fN7fZpdxIjrcbcXYtsOWoWAMxc6aB3KXkPO6bCWeRhDz/aNsV5iY4uYP3jDkIK0a8WBfEXqIFLpGFaLePdxi8BmILwPWRqTv+ZRqB76dRtp2q+Jn+7q9Wlqy6JmKSAZPa70kq48CNdO9GG9kqNXzvTpyBiuZps0UZYNFwifMb8tCaXuzFEZkWVWpI8pYwl9fOMKaF6wdy8M9TYWwu8ZjsuRXRLIS05KYpArafWTqBDOSPATAXYJgB1vl7wq9ADeGcURtebv5CG2Uv86fUTbc6oLhU36t1XuW+MhKPiab/N5pSkufZ7TtjxJsbqDBSrxqlmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU0DmTielf9V2ykUdZZFS4OUmLmSe/OM/4tKcD6mfYo=;
 b=bdrex/QvbiOuguRpFXDmeWDP7H2bWE47468L8oI3Gs5Y/ITfXpm5oGDvAkR1mHw4icSm3kqA8K7PcUCQb9KVDHmm5cEZrg5GVQEFKe5V+k+K+26hrNtKjCWn81sfvYX3wHwhw51QsMl3OemnzNl1Hk2eblVFlf2nv+M7djJdzTrV98Xu6sYo6U59BJEpDTegcr65GsdU9XMcSkG66DoY066V6UY4YEqZFQh05wxnCBZEbG134zm/su1bTW32UYay+S1dULk5D4PGFn1J9NeoVCf6Vd0B5aAxzCIUmACbXjAuWdXbkNeCq/d2wnx5+1cFtGcXcNte6K0dKSEGdI3k1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 BYAPR01MB4055.prod.exchangelabs.com (2603:10b6:a03:5b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24; Fri, 20 Jan 2023 16:09:10 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::932e:4a9f:425c:11d3]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::932e:4a9f:425c:11d3%7]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 16:09:10 +0000
Message-ID: <e6edcba4-05f5-1d76-b51b-c455bf6e2484@cornelisnetworks.com>
Date:   Fri, 20 Jan 2023 10:09:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer
 invalidate race
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        leonro@nvidia.com, linux-rdma@vger.kernel.org
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
 <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
 <Y8VwHYPYlV459T1j@nvidia.com>
 <a4027240-b711-bd11-1f42-c16d53104f6e@cornelisnetworks.com>
 <Y8fpNLbRuT3UMhJK@nvidia.com>
 <90652c2d-a874-fb24-3356-55c9b7003feb@cornelisnetworks.com>
 <Y8mGgZqh90M6OfE8@nvidia.com>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <Y8mGgZqh90M6OfE8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::27) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|BYAPR01MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: e25a7b2e-4da7-4bd5-21a1-08dafb00a8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnGbOei9qXqV+5h6/wLLKJveN9ErWi8NC0RsaxTpXbIAwAh/s+tIr2jgkJFow1Aa7o/kJS+bv7LcMJdihPoFh6vNsngHzfNZLh5HaHgjFWUBKaIDxqX/wnnq/R8J5VojvgVAzvYKWIAc/hUK+U1O1dQX+Tjs7+CD0QEN30eivd8Ld5ns6W5GCUhQX8UPQVNq37WRnUSE4Wd0+qCCz/Vs8/IKjwJ+dgUQGXeyUk+12nB7RWxWobRG06aIAWeAoFPp2ontYZKAbQOU4aj3aDVCUSmmZg3kUUMMovoETWj0cEAg/kcH+GQG6KtWCRMApeWrvyyfh/BE9VU/950rn9ItSzZA4jQWz2ens+h9PM2cvCpYfszYdIcnoh67xqtfXlDE8BYc+bsVhnLAiTxX+B1n6mkaBzZ/DY8CF+LW2WgCPahiV5p5AZdBmMTLgqk/VdQokfGbvQpgiKcmTooOZa9EiB45939Bg/b6jYmzNzp/5BtJw/c6u+d8pb4o2cUi4tgHX1MkWDjBmg6kPxYjS4CxHcFGgsCYHgPBNjejxIeeRfKszSQFwfB3QqShzP9TdAgMLxPk3Oe35mor3i94aIxnzBDXKlo9Qprp3uyK1BCvrnpVaqez3UDYIgH/+fYr6HNV2igXP0SuBe/Ocevtd/p1SjqGBzJd4MGyVgDJcqlAsE7qK94C8SUgcZPlGk+cDT+OTX3tiFAnNgVBuXZazDyD5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39830400003)(396003)(136003)(451199015)(5660300002)(316002)(2616005)(36756003)(2906002)(44832011)(83380400001)(38100700002)(6486002)(86362001)(31696002)(26005)(53546011)(6506007)(186003)(6512007)(6666004)(478600001)(8676002)(6916009)(4326008)(41300700001)(31686004)(66899015)(66946007)(66476007)(8936002)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWVYQUFMcHhBczdmTjlaUWlLS0F4UGNVaHJFY2ovVlNxNyt0bWpkMUNMZ3Q1?=
 =?utf-8?B?ME5KNVVUcVVjbDRraFhmeVEwWkxjV0xxWFp0dzZuZEdTT3psRnpaWHlhWFU1?=
 =?utf-8?B?QkV2M2NZRGlaNWRxMmN1L3o4cGhaQzZvTlhVeEpjMkVmS01rRGNVbmE5bHN1?=
 =?utf-8?B?eUcrMmY4TGxNKzJPaUlicHNXemxIakVTVmxhKzdTYmRKWnB1dEtjS0hGeVRJ?=
 =?utf-8?B?ZEN6cGIzT2ZWRFVKdUU0WnJqV01ZRlRTeFlnM2JNNWtwcVdEbmpHVUxkdExZ?=
 =?utf-8?B?eGNsVVkxckZ4b0VMejVwUTAwdlUxK1dSRlJ4alB3UVpNY0ZRU0VlZUhJMVdn?=
 =?utf-8?B?UVFUOEVUTWpLVDNweVY3a3Y0ZDVBY09vN3VSL1ZUcjN2VWRWVjVDYUJpRjha?=
 =?utf-8?B?UmtFajRtaEVhQ216OUE5SkNER3BIUDliNERVSElobmJOaUxuR3ozakZKYVlq?=
 =?utf-8?B?QnFaV1dUejlHdlg0ZzJ4R0dpdzZsWFpRVGtGMVl0ZWc0WmtiSFhWVnRrU0w3?=
 =?utf-8?B?Tld0V3YyNzBqRVZHMnVFY0VkUEQ1SGxDY25EejNKUU9lck51OFkxNmJyRkg0?=
 =?utf-8?B?VEJnWWNVS1cvK1ZvVHVvMVk3a0lGMXRvSTdhK2pSNGJXMlFKTlo3dEJRRVZH?=
 =?utf-8?B?WDZCVGtnUG1ZOHRWYkk2U3lNYTEzNVU2SXRWZk1uU1NMc1Z4eTk0TnpZb3ZX?=
 =?utf-8?B?c0t2SmhwNnZ3ZUh6OW5sa1hYUEQ5R3BDWnMxNy9NMTNTeHpMN2RpZm00Qm9J?=
 =?utf-8?B?T3RtWVpqdkxySXZMSXR2bFl1dFErbUhSUDdkVzY0eTkxZ00rRHRmTWpEd2Zy?=
 =?utf-8?B?ckxZa1oyNDFuUUMvTkVOUjBEaVlZVWdLQkF1WCs3V0VQdUhnNktTOFBiSnJE?=
 =?utf-8?B?b2xKT3VFWERoY0F4dEE4ODlFaCtqSUFhSGxLdmtYYWtSaEVoekthd3ZjRW9T?=
 =?utf-8?B?OGNOOEN3Nk5UTUFwbG9SOExUMm5EZGJUS3QrWHZLakV2azBwNUd3aThQaEta?=
 =?utf-8?B?UXpZZ0xxQ3E2c0ljVUlCcnRZMHVNb3Q3RTZOVkFVQlRLU2RqdEt5QW0xYzh4?=
 =?utf-8?B?QXIyMDQ3ODdyZFFRV2tIWWJyTSsvQzRCaHFKRjNvdDFsUWFudDRXL0IvWUg5?=
 =?utf-8?B?bTdDUVMvbEIxY21SVHJPcUJuUExwTVdnSTFnbWNzR1FLejdrK3FRVlNxdHU2?=
 =?utf-8?B?ZEdQcElDc2Qzc1JEdHFZV2ZRTFhodE9pV1N0SVRjZGQ4UjNRcE5wZG94cmlE?=
 =?utf-8?B?SlhKaHJHblh4RldzMnFRN1NzVVVjQmtJbWRvRzFYY1JqZ25DK2tQTmpXTUZm?=
 =?utf-8?B?V2pnekNtSFlhRVRvWkJtRkU3dUI4TFE3a045UW5xNXlLMCszMXM2ejJtc1Rv?=
 =?utf-8?B?ODJ3RmlyNEtGdGRiY0lLNVRLM1RNNFVhaUFEQ2JZNUwrcVorQjlpNlhTdHRr?=
 =?utf-8?B?aDFGNS9HQ0xhOW9ISlcyZng0aC9mVzJVQk1GTGpqa1BEaWVxdEduWm1CTXBo?=
 =?utf-8?B?bDlXdGR3U1lzWUt2ME9EYlA2SWNPSk5rc05lM0UxT0VJYVIzelNHTmlJYktm?=
 =?utf-8?B?VHlJN2JHOE9BdG9INTVZWUVkYnYrQnNXQ2x1ODNWV3hRQVgrdU5qemJxMmZq?=
 =?utf-8?B?YjY0M285cTY4aHgrbUdra2o1ZEdFbFQzZ1VKeFUvUUpJQ09vWUNBWmtsUnlF?=
 =?utf-8?B?QVJOVUtXNjc3WDBSaDgyMTlUM3FHZTZldmFXZjFqY2dvbFpJcUZzSnRLUUNu?=
 =?utf-8?B?WGdBWHQ1WVBuZlk1dklqbktxci9MRlp2RnBJc1BPUnl2SUc0Y3BNYjQvKzJ3?=
 =?utf-8?B?ZWxyV1VXSytpMG9EeFNnK1BKZ0kyRnVIYWxjWGNoT043RVdZeFhZWXVyUEg1?=
 =?utf-8?B?T3F6d3RIdGVPZGRidnExaCtTMWowQ3dTU0Y5ZDJRWXA0MTM3VGY1SG9wcHpH?=
 =?utf-8?B?T1pHREI2ajhFeHNiVytERzBuZWloY0QwUHl5Y24zT3pkVVJCSG53QkJYRlI1?=
 =?utf-8?B?bnJNbzFBeVNEMjVJelNDWndoSk91eU8xNDczNWZWbndyOXN4cDI2NmhnMkFJ?=
 =?utf-8?B?MkVoeVZHdzdnK0Z6c3VWK0R3N0RTU1ExVExFQW8wTk4wblFGemRaY2hhRXZY?=
 =?utf-8?B?d2NhN2h6aTZiaDlrMC9lalN5bTJRMDZjTDVYWTZabUtYTmpOZXpBelQ3alpI?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25a7b2e-4da7-4bd5-21a1-08dafb00a8a7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:09:10.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puO/LjntYX863oUOrqUkeLXDLlZLgO3fp+Gq8LdJbjfl3EtIdZjb9uJvrqC7GRIUTFc6OyK7WBC6vjprzJ01Sp50WM7kUGiWTwufeMaWXY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4055
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/19/2023 12:05 PM, Jason Gunthorpe wrote:
> On Thu, Jan 19, 2023 at 10:00:39AM -0600, Dean Luick wrote:
>> On 1/18/2023 6:42 AM, Jason Gunthorpe wrote:
>>> On Tue, Jan 17, 2023 at 01:19:14PM -0600, Dean Luick wrote:
>>>> On 1/16/2023 9:41 AM, Jason Gunthorpe wrote:
>>>>> On Mon, Jan 09, 2023 at 12:31:31PM -0500, Dennis Dalessandro wrote:
>>>>>
>>>>>> +    if (fd->use_mn) {
>>>>>> +            ret =3D mmu_interval_notifier_insert(
>>>>>> +                    &tidbuf->notifier, current->mm,
>>>>>> +                    tidbuf->vaddr, tidbuf->npages * PAGE_SIZE,
>>>>>> +                    &tid_cover_ops);
>>>>>
>>>>> This is still not the right way to use these notifiers, you should be
>>>>> removing the calls to mmu_notifier_register()
>>>>
>>>> I am confused by your comment.  This is the user expected receive
>>>> code.  There are no calls to mmu_notifier_register() here.  You
>>>> removed those calls when you added the FIXME.  The Send DMA side
>>>> still has calls to mmu_notifier_register().  This series is all
>>>> about user expected receive.
>>>
>>> Then something else seems wrong because you shouldn't be removing the
>>> notifiers in the same function you add them
>>
>> The add-then-remove is intentional.  The purpose is to make sure
>> there are no invalidates while we pin pages and set up the
>> "permanent" notifiers that cover exact ranges based on sequential
>> pages and how the DMA hardware is programmed.  Once the programmed
>> hardware range notifiers are in place, the covering range serves no
>> purpose and can be removed.
>
> Uh, that doesn't sound very good, it is very expensive to create these
> notifiers, they were not intended to be overly narrowed like this -
> you are better to have a wider range and deal with the rare false hit
> than to take the cost of register/unregister on every activity??

The temporary cover is a compromise effort to avoid the following situation=
.  Suppose, as you suggest, we keep a single range on the registration call=
.  Then:

User registers range A.  The hardware breaks it up into several separate pi=
eces - "TIDs".  Due to pressure, software releases several, but not all the=
 pieces of A.  Because not all of A is gone, the notify range is retained.

Later, software registers range B, which includes parts of the original A. =
 A new single range is registered.  Since this overlaps with A, we now have=
 multiple range notifiers over the same memory range.  All would still be f=
unctionally correct, since there would only be one owner of each TID. But w=
e now have overlapping permanent notify ranges.

Repeat this several times and you can have a mess of overlapping ranges, ea=
ch with a little piece that is actually live.

With a unique notifier over each TID, the notifier can be dismissed when th=
e TID is released.

We judged it would be simpler and better to keep the smaller, more specific=
 ranges that matched the programmed hardware.  No searching or checking nee=
ded.  A 1-1 correspondence.

None of this would be needed if there was a correct, safe way to hold off a=
ll memory invalidates in a target range (or just in general) while we set u=
p our per-TID notifiers.


> Also I'm not entirely sure this can be race free, having two notifiers
> responsible for the same memory at the same time sounds like Danger
> Danger sort of situation..

No danger at all.  The temporary "cover" range only registers that somethin=
g has happened in the whole range.  The "permanent", aka TID, range is resp=
onsible for clearing the hardware.  Separate responsibilities.

-Dean

External recipient
