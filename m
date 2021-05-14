Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6082380B23
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 16:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhENOKp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 10:10:45 -0400
Received: from mail-bn1nam07on2099.outbound.protection.outlook.com ([40.107.212.99]:1750
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234179AbhENOK2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 10:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcQeaBWBWHFAra7XuRB7WP+jtmnuLkMGhQJ8oHiyZo4j+jZ0IUzF+EQBTG4iVCACwBKUI2mUEToI9rLv2gpU0e9+oU/kbJpFV1kAaDb9SAbv5/TiQ2KCbT0G3Uhcg1T1b82ktuHA67h7pOnqNuB9pXhGdRgiASq8axZ61HEZgCdXjMVcNsxY33bHhqBxpIQxNek1iAJD+2Zv7sRWYPU+xBvZzD1i4KHbTXaoaZQ61wol2KraOSpo28T5akYwiXhR+BGiRRD1s5ViNov3MJWSMEvZhW3Kf5myWBE5SfoaNiZoqWWDkUckbo0lvkwxTikJaRXTGmuFVGD6dbFHp1mifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX9BY/vXKbS1NWGMECmYF4/mCoy7yokhPAfaSl8IROM=;
 b=odOApRf5E1JHWhjlSHlCR3vSMMk2ZGpIbD7GPCidXdUCKICH5/u/KwdqVsIl8gGoKj2LR+Z/x12imECVVsvsJqJ+mnKttBFssdf/gvFB8YE6X7HZID2AfgdChmiF1h5luwNZUNf8kvJual82Pr5w4tplSW4URFYKiXUHdSpKP2N71qdN+GMkbeQ6R9hq5/n+EAWWSUddoE4WkMyzRW2yzr10xZryPT91jeDnrJ8MZbUM6l9xPqLZaRv/NerN7EaImv2WiR1ZrtrjDD1M5vpMZyUS78CAoQUdEan8/Z2tyBUYm7qs6JT2EQ/20yOYDkmv48tUE4ATJIwFZAVn42uV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX9BY/vXKbS1NWGMECmYF4/mCoy7yokhPAfaSl8IROM=;
 b=XXjRcSwUyApOuES9Eyt3EccRipTPpdfXUXb8AvjYepe3KnbqsGeZJcV8WlNL3zSZZnrbn4dZZgX5Y6bxisWUNJAx4cWKD5Fy1FvcmYSo+nXpysyvVBTrYr4Wna6b0QsLGF/jeR0FyL76BhD1UNTEJnK+rNsi6xQcoznrX7K87E4zHrBACv6x375G0VYTb3duQ73Ev49FWchBuKp45wBeP6PnzA7eaJoa/KfwnV6IDUNa95S8FLqKH4k8fuK0m/tDO41Wpthq51LdKZiMjMquDJoR6ch1UQ86C8P0Sy1DipmAM9AhAiu7x6Ck3jFdvsdvM0mWrS2MWVWPaoobEpYfFA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6620.prod.exchangelabs.com (2603:10b6:510:90::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 14:07:46 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.025; Fri, 14 May 2021
 14:07:46 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
Date:   Fri, 14 May 2021 10:07:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210514130247.GA1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:208:23d::32) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR06CA0027.namprd06.prod.outlook.com (2603:10b6:208:23d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 14:07:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d705dc86-3a42-4725-7962-08d916e1a634
X-MS-TrafficTypeDiagnostic: PH0PR01MB6620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6620741E327046759377F0B3F4509@PH0PR01MB6620.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orJy4Q1p1xjVZjZwKpfk5XyYHXkUytDPV1KubCgy0P9k4PhNvNB1v0BkR86KnZp++QRIrgu8mbtMkkBlxlHSzQb695e3QyutS9jgpSXFiYhsVxJKSp1w9ZGVUcpksyLJsRR7kaCJz/0zjWQqVtySS4Jw0lOaswm6l320OETXeuz+ZSCRrJqCmJ128VbErU66JuXbmFH/X6/HymAnrPPdbUQR2J0O8SQqqHfJkMLhck6v5kPVOdXBGzAXToBdJ89W2P9PnVpv7TEp9kWCnzTxSM/uktax39L2uwA7rkKgwwvMB47A1+PRJ4mUlFb2pyC8DEmpav57KbWhHGx8O0QAwGvguuQg/J59To2NuxawpYuxwv38E5CRtvXtWDaV66eCyAPSg0S71J37Sm5idFPMxYwAR5wVsNPUv2WuuO6+6lZVflpJKhU2EwnJm1Xuk8ge0LEHwxniKBfwuZh6yiJHuVRfDhXx486XpTxxu7DbnHf/WoX5fG1G2Iyg9js/E44UxyriRymYfh3R64zfsRN+KBdzboTWp/7gX9y4NTawtpl4fGUtzaJNzSccnE64o1HvSEZdMhGwhqkgEAWiVT0E8i2Avj/V3Egzy3YxfgGyDbg5awb+m6yX6aWHaz/TYT+6IgeWq6+swb1jI5z14PtWRK+D7lclKXSFkEnOgQPHZmQCovPDGIk3xVAAu6uU68JxsYw+39W6Z4GXSsn5uV+qhRmCQAfMz5+ABJQE/Y0MOIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39830400003)(376002)(346002)(136003)(8936002)(5660300002)(478600001)(8676002)(54906003)(4326008)(6916009)(186003)(36756003)(6506007)(26005)(16526019)(2906002)(31686004)(316002)(66946007)(66556008)(66476007)(38100700002)(38350700002)(31696002)(44832011)(2616005)(6486002)(956004)(53546011)(86362001)(52116002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?djF1ekxvOHVjend6TzN1OVpRMGxZOTd3RUJsUnoyMHE2cUFWWkNLZWdacmpx?=
 =?utf-8?B?SlVkeWZVK3F2ZVJnYlFXclBJTmIvaXQ1aFNVWW52YVNIeWczUUFtUjFUdVpT?=
 =?utf-8?B?ZnBDMlNqMUN2MFF1R3JBalZNUkVldHMrdHgzOGxvMEdXOFR2b3NPN0MyNlNu?=
 =?utf-8?B?TVFPeDFEUDFmb1NWZVRGMFhoUmpjcnE4TlEyRGJHWkVJbEVVZ0ZVb0IzVDVl?=
 =?utf-8?B?NlVtMGRFcDRqYStsMXJzNVhyM0R3c21haUVLK3pTVk9LMWVZbmVCUUhncmhI?=
 =?utf-8?B?NVgvWHhVTzVsWUxLOFNtYms1SHZ4NGVkZFB0a2sxZkFCZnN5TDNPNUdQM3Y1?=
 =?utf-8?B?VG4rV3FtNG5RTmJBNEl1MGpEU2lxRVlWemxZRUpERzI3cktveEhzZFZxN0Nw?=
 =?utf-8?B?WEJjNFRESjBlK1VZQ2s0bHNoN0Z1YjlZR1V2anFoRmVxTTVjSVhZL09uMlRu?=
 =?utf-8?B?c3g1T2djVkRyWVRvUkdjdGpvYmRKcHZsUXZNQ1FjRHBNbG5EUm9tVGM3Y1V3?=
 =?utf-8?B?eGxRblJPby9HM2QvdTNyVFM3TFhld1hWcmh3VDZwN2pKUk1zRjVDRDlOQStu?=
 =?utf-8?B?QXpRS3p1WFN5Y1AzRjR0dWI2Z0FHRzdjTXlJc3hYMjd5cThsSGtYVGE5TXBX?=
 =?utf-8?B?bmcrREhiTlZYenVEVWkzdmtKY2d3QTJxODNZT3dMeEpDN212SjB1amd6RjFn?=
 =?utf-8?B?Z010dWlyTmxhTS95Y0VaejZXejRuWkQ5Qjl1K0s0TjFjMWxCdmw5cDNrUm93?=
 =?utf-8?B?cVZQa3dtQnFFbHV0dzZ2RzFLN1VWR0FNenhMRTF2bWlCaUFHYnRXQzFHbVIv?=
 =?utf-8?B?VUcyK1U2aXBnSkZRU29KWk1sVVBPVVFGay9UUkl2S25VZzFKeGg5M0xNZXRX?=
 =?utf-8?B?d2gvcDMwUDZxUXJETVNtU0loMkhUOGJGMnVOeFBlYVdZVDJZR3V6cGtVT0R6?=
 =?utf-8?B?WHNuanpqVys3OVhjNFhYWGRNeUNnTWpIU2wzK3cvc2dJUWVqL1JaOEJFSHhV?=
 =?utf-8?B?c0Z3d0kzUjd5VWR4WlNzUUdEOEduaUxSNXRTZW5QcnBsamtUQ3NPVUdBOEVx?=
 =?utf-8?B?U0xUQS92U1NUaXo3dTFkLzhhOG9QYmZBU2JIQm9TRFpBZ09ZSUR5emYvT01u?=
 =?utf-8?B?cTFNdHNRMEJVZWcvRjBIMEtrcXdzVkUyZ2tKUUVsRkVUVjliVmlHV2VkK0NE?=
 =?utf-8?B?UW9rT2swUEFWdDFNbUI2cEJNN3ZtbnI1OVJsVzUyaXdBSDRhVWVFTjdYNHlR?=
 =?utf-8?B?ZFFwdFFHb2d0WktneSt1d2xPclUrVEFUa2ZzYTVaWXRrN05yNld6Nkc1Z3RB?=
 =?utf-8?B?am5QOVpDbFN3M2ZUR3V5RFk4RHRhOVJtVUhVYUliZjhBM2NZN3o3WFBkU01l?=
 =?utf-8?B?djd5SFpReE5GMmwrL0swYW56ZXZhZ2lXcjhNWVEyMm9pc1lVVGkveVJsVzRI?=
 =?utf-8?B?MjA2NU9TeStaTzd6ZTFQV1YzUTdHZ1F1NllKOHJRVHdrNGVSM0ZHQVZhVUJR?=
 =?utf-8?B?akJhTUxaMEdKMWNOZjZDNlJiZmdnVWw4REV4Ym9TQTI0emdrUUdZQlpPa1lk?=
 =?utf-8?B?WmJIMFpKVnNoeDNoYVdxWUpjeVA5L25xQXdsYUhFRlR6dzdrZ0JabTdPeCsx?=
 =?utf-8?B?RkJVVmFsZ2N1QkJlU3N1K3RwQndsWjBtQkU3U0ZrTHlEWTNrb25icFJZWDFM?=
 =?utf-8?B?WStxTTdBaWYvZnROK2Zja1hGZzlSNS9veElJUlMyTDBGL2R5ZXc5ODNVRkRD?=
 =?utf-8?Q?bi32F8cncOKJYwnxQz41Hjo1/s0c+vWSj0tq4P9?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d705dc86-3a42-4725-7962-08d916e1a634
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 14:07:46.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzU/w3OT0qHyOvW30SOkuDnVCz1dVV/I1a/YQcQup3ZdDku5v1bKWLPq4dGc3thKZ/fj5rujO3nTHeX0CokmyENrhfvluGfudZ52oF4Umo0ndcwb8Csp6+5r5BYJ5qRh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6620
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/14/21 9:02 AM, Jason Gunthorpe wrote:
> On Thu, May 13, 2021 at 03:31:48PM -0400, Dennis Dalessandro wrote:
>> On 5/13/21 3:15 PM, Jason Gunthorpe wrote:
>>> On Thu, May 13, 2021 at 03:03:43PM -0400, Dennis Dalessandro wrote:
>>>> On 5/12/21 8:50 AM, Leon Romanovsky wrote:
>>>>> On Wed, May 12, 2021 at 12:25:15PM +0000, Marciniszyn, Mike wrote:
>>>>>>>> Thanks Leon, we'll get this put through our testing.
>>>>>>>
>>>>>>> Thanks a lot.
>>>>>>>
>>>>>>>>
>>>>>>
>>>>>> The patch as is passed all our functional testing.
>>>>>
>>>>> Thanks Mike,
>>>>>
>>>>> Can I ask you to perform a performance comparison between this patch and
>>>>> the following?
>>>>
>>>> We have years of performance data with the code the way it is. Please
>>>> maintain the original functionality of the code when moving things into the
>>>> core unless there is a compelling reason to change. That is not the case
>>>> here.
>>>
>>> Well, making the core do node allocations for metadata on every driver
>>> is a pretty big thing to ask for with no data.
>>
>> Can't you just make the call into the core take a flag for this? You are
>> looking to make a change to key behavior without any clear reason that I can
>> see for why it needs to be that way. If there is a good reason, please
>> explain so we can understand.
> 
> The lifetime model of all this data is messed up, there are a bunch of
> little bugs on the error paths, and we can't have a proper refcount
> lifetime module when this code really wants to have it.
> 
> IMHO if hf1 has a performance need here it should chain a sub
> allocation since promoting node awareness to the core code looks
> not nice..

That's part of what I want to understand. Why is it "not nice"? Is it 
because there is only 1 driver that needs it or something else.

As far as chaining a sub allocation, I'm not sure I follow. Isn't that 
kinda what Leon is doing here? Or will do, in other words move the qp 
allocation to the core and leave the SGE allocation in the driver per 
node. I can't say for any certainty one way or the other this is OK. I 
just know it would really suck to end up with a performance regression 
for something that was easily avoided by not changing the code behavior. 
A regression in code that has been this way since day 1 would be really 
bad. I'd just really rather not take that chance.

> These are not supposed to be performance sensitive data structures,
> they haven't even been organized for cache locality or anything.
> 
>> I would think the person authoring the patch should be responsible to prove
>> their patch doesn't cause a regression.
> 
> I'm more interested in this argument as it applied to functional
> regressions. Performance is always shifting around and a win for a
> node specific allocation seems highly situational to me. I half wonder
> if all the node allocation in this driver is just some copy and
> paste.

I think prove is too strong of a word. Should have said do what is 
reasonably necessary to ensure their patch doesn't cause a regression. 
Whether that's running their own tests or taking the advice from the 
folks who wrote the initial code or even other non-biased review 
opinions, etc. I certainly don't expect Leon to throw some HFIs in a 
machine and do a performance evaluation.

I think this is the exact opposite of copy/paste. When we wrote this 
code originally there was a ton of work that went into how data 
structures were aligned and organized, as well as an examination of 
allocations and per node allocations were found to be important. If you 
look at the original qib code in v4.5, before we did rdmavt, the 
allocation was not per node. We specifically changed that in v4.6 when 
we put in rdmavt. In v4.3 when hfi1 went into staging it was not using 
the per node variant either (because that was copy/paste).

I would love to be able to go back in our code reviews and bug tracking 
and tell you exactly why this line of code was changed to be per node. 
Unfortunately that level of information has not passed on to Cornelis.

-Denny
