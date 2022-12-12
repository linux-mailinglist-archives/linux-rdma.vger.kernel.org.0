Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF864A294
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 14:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiLLN4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 08:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiLLNzs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 08:55:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B61580F
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 05:55:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ3W/eoxAJBbfIE9xdgriaFP8P+jxRody712uSsQaMIcrOe9nd2++3gqiX4jm5wSim2uT11Wo6JQXnHGqkhXjpQrj7/BIda86ycOmhX8tzp2xCA9biFuTaU6nTRxuK0sC5Q8dtbonEOumNRskD4Xs6kqspHTxO4LobqEHg8n3wPI3SstuCc/CqJhOfW7/waw2jwjrv7HLJYURVynNsszPbYemI+NiO+xAFhNXldrgNM6sP9g+mquK9Mg+l9eSFWa8NoAycA3dqNfC0wrsZIRD25jBc7QVPHoUqRuV2sdaHdIJEdQkX/LhX/2gjbsJQ8YVT2N9pXZiriztStGVZuNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8GRmFfINBtrqtoDcEcV9VMpm/WdHF8RDm8PmnpPfkU=;
 b=XOxXeUS+m06Kc9G63ugfI7wDiGOaaTpYQTqp2gurPLz5AMO0veKxrV3mRpqPFJXW9u7fUYWOdiETQX/k87/Q6t5EB7lzo4ubi1ivsDOfdmSJZB58/+MxcIckOiZSSYN78oneJxJ34wt7jiubHSo4bXQnMbeKznjVFzM9MowPLS+O1Kao+eLgDfaErpqj2tVAOBOgx1uMsoD0jzwljKUG+ddzHeFsSeUP1iNRUB0PCe8ruX5vijcSMClt7mknIE+tkifkOTa+YRYXk70xVca8PRwH/EqaHqX3JdXAnKBJCCn3efdUGSI4rIOEUAZSB6iktP8tzBnG3dt1Zz4hl4Q+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8GRmFfINBtrqtoDcEcV9VMpm/WdHF8RDm8PmnpPfkU=;
 b=maArJjU4ppBGdiFV1jF6lKiPtyMj7TUsMuqv+zkHBRFd+RbrbSpvvUd7h1cfnheW7Ro6bBsbZCv3Q1On4x8F3xIt7u/zDqPsia8aAfsdU0jRtqTDavD6DOpFdyBRdjCLOx0kSFIFkOwEIlYqIjVAdSSFkmLLwe2km+Bfzs2cI0SqVd/2+Wb+3QevKvdN433/oqSRNv7qOVLcT7ukeknFoYlLSCUa5X7nwCYfOM3VzuCHjL83N2qEnmQgmnBdXFxIFlZTQJDlS4FJEDpFTchbYpDSnPCch+Wa6e0A/q+0Yw3LjDIkCyBgtckaAqRJTfIeY8oiGwM8hqFm4L28YJu5rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:55:44 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::ae46:e45a:2dfe:7c96]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::ae46:e45a:2dfe:7c96%9]) with mapi id 15.20.5857.023; Mon, 12 Dec 2022
 13:55:43 +0000
Message-ID: <1a852181-8b9f-5f30-2c4a-fb3cb79802af@nvidia.com>
Date:   Mon, 12 Dec 2022 15:55:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error
 cleanup
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
References: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
 <Y5csPTRDNOIwf49T@nvidia.com>
 <81008c63-50e0-075a-6795-71ea3d08803c@nvidia.com>
 <Y5cv+z6cYWUV3ara@nvidia.com>
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <Y5cv+z6cYWUV3ara@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0337.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::18) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b1b33b-2bdf-4373-c7c0-08dadc488fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/FpWVhXD0ycFgTB8CM+L2HN6IE0RkTJi+SEQPoflycnLIJIa0BEq0MIYXLZrsPW0Sc8lOgLWGoB1/3Sp8LmcKfOmzpjPCDFKtnm2jp+KLADQofnadJJYcRbLUaAGiQ9T5LoPXlKlJEF4eM3dLL7mlCb0d6zwxtK8W7HRSkfgIELDHQ5OaDof6lH//tqBv6AX7/PUFnKYLqAX6/1g5EDeUAmU6yNOawOUlXsJMaM+GYf6EI8g0TD5yB1tV4IQdfh7B3o50gl8OPBks8N1dy905kwO9qWJqTnVC8FLXhHQjufWKdGKTqU3k6FjyqL8usjYA5COk/KzHl4ANR1ruqnHALt+HiS9Xe7fW3w/89fC/MwwgFhIuOtif6eXUrKFzxh/EE+oGrxVaO9k45dTG+5NqEExeGyujmNJJDGBfmUP0dAXHzQ3v24+RIkaCH8OOLV5105Wgb0e1fogSQ3uSs832DClXIj4twMKHQseDgtD2hP41wZpNqfSsJ8HC844DGcpysN4D20cIAU442BlKp0/id3BOk2TnsF8rqz2W+mgoAsHHyKb1IMPmVtPQ7YasTZrWHgVVe6ALxlorJv6rlQdXrHjEU45ZLhYNBxrvoj/oEBfllMDR6itNEU03RgqraUhYJMRsXbMgNDixfM1J+KoXvc6gzqJuGPVowHga/f047HDKG8NhVg/3FeyXog9xkfl+kVFYAj8NcKb8QV4RPAQ76zzfo/CAj1vStuFBA0A84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(36756003)(8936002)(478600001)(6666004)(41300700001)(6862004)(6486002)(38100700002)(31696002)(86362001)(5660300002)(2616005)(53546011)(31686004)(316002)(6636002)(66556008)(37006003)(4326008)(8676002)(66476007)(66946007)(6512007)(186003)(6506007)(26005)(83380400001)(54906003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJBSmVLWUtpVE5MYlViMXFQMDNRYTVnRzVmMlhQS1o5M2lOOEtVZUY2MEpE?=
 =?utf-8?B?TS93SUJFaWE3OTBTWnY5cUVadlBqRU9ESkdHeTFJVkNQbEpMOEkzcVdJcnZQ?=
 =?utf-8?B?VFVJbmQvZ3ZGcElVSHZCYlZudW1JZUNYMk5naWlWYjhyKzdZM3cwQ1dqeTgx?=
 =?utf-8?B?MGRIYVgrVzJYNktZNzl6VERlMFd2bVN6UzlWVGxsRE1nTWFTaUVYYllMd2hM?=
 =?utf-8?B?eXRsVHVhekxUck1nL1ZsL1hhNTRER3BoSWpsMU05cFo1d0xyN2FFOWh6VW9C?=
 =?utf-8?B?WTQ5R3M3T1BtMGkrU1FOS3hOQ3crMkFQV25iODBGSVNWUnZmOTMveGpvQ1d5?=
 =?utf-8?B?anpsNXpIM3QyTVV2SUlyT0dSRXNHQlprNzFGUTdGTTl1WGdCQloyYzI4NEZ1?=
 =?utf-8?B?UWdmV3dEUk14VXpsM3FSdWhzbEcraFFkNVNCQ3c3U09jU1BaL3hXMUYwcFVj?=
 =?utf-8?B?cm9PSnZyQmk2a2lrVlVmNEZuTGtDeUpCL1BWdjFZank3dnVhS0JuQzFMSmth?=
 =?utf-8?B?NXpWTVJ3dTdhcURPU3pwUHBpRkw4VkJoUy9ZbGdsUXd4clJDMkN4MzQrV2V4?=
 =?utf-8?B?bWt5MGJ6NHJkbzQ2WDFkV1VmRExzelBMTHd2RTk2bUcxc01EQ1MyTm9BRktn?=
 =?utf-8?B?emxGbW1WWFpmK1gzR3U2TWFDS2Y0ZmFJNEpTQlpYb2szUEpxWXFMSVl4MWkr?=
 =?utf-8?B?VUlNamhTQUFaNnFCczZpUGcrTW9FZmZTdUtMNVdCT1BibFIxOFhSUmtJOUh5?=
 =?utf-8?B?UEFISzFMYk9LRmxrVWI2K21pdDYxWlVQRi9UVDBtemdBRFBTcWRLckFxdFZs?=
 =?utf-8?B?djhTNkVzNElOdkR3a05yS1NwN2EyQ2taeVh2dnVVTDFGbzlPaWpoR1pZTFpy?=
 =?utf-8?B?bGJqTVV2cHgvcVVRUWp1UDFpQXROZ1ozRUJoY2xIS0JTb09RbHB4SUVmbm0v?=
 =?utf-8?B?VlRYVDVBTE9mZWxRWC9hYnA1L1F2OG5tYmRRMldHdGtLcnI1VHdubDVPUDdK?=
 =?utf-8?B?WXlhYkpDYTF3THBNY2VvdkdTRDVXL2o0eGw2TDFEc2VwWmpSbGhwSzFqenZV?=
 =?utf-8?B?QjNhS1diOGJ2cHJIRWJ6dzVlNDZMQkl4L0x1TGhueHl1OUxJcmhRN2pVU0I5?=
 =?utf-8?B?cDU5TVp5dlhCM2k2TDB2MDhTZVltRGJvYUZ4M1E0alVkd2JwS25Cejd1M3M4?=
 =?utf-8?B?V2ZXNEtwVHFIWkdkRkp3TnlUR1JZM0hJYk9wYUNVUm5yN3daT2pkVWg2NTJ1?=
 =?utf-8?B?ekdpWDVrc0pzTmRLRnAvNEdyZEJBRFovNFo0dTZnYnRPbG5LVTdXcXdTcTBP?=
 =?utf-8?B?QUkxTWp0ZU9ibnUraHJvWE9mM25Eb2pCZ0dZNXdyQzZQajNsMjNtVFFzWm4v?=
 =?utf-8?B?Z2Vmblc1VWZjd2hpNTNQMXE4OGl3NXVpSGVXbWlSNzRsWittTk1TUnd3QXBV?=
 =?utf-8?B?NzRwUzlJd0xOWHdHZmF3bTBhTjlmRVdsQytIcjBZQ25IMGVMTWZHOVYzSzVX?=
 =?utf-8?B?M0ROUmJndS9uK3lzczFVYTU3NEhvY0VGWDdLY3AzWGc5aWtiWm9RcWM4THZV?=
 =?utf-8?B?ei9aNEhid0haY0Evc0pOOC95U0FpcCtnUDJMS2ZxcVJRYjJ2SWFKZk1vbkNo?=
 =?utf-8?B?LzBWNms2eHdWYU8wU3p0VStHako0RTlxdjZXZk44d0gxak10L1pTamJUdXZh?=
 =?utf-8?B?SFpOejkrSHFBNCtiRms0M0t2S0xrK0J4TTFVTS9pU241ZSsvN0J3anloT0dI?=
 =?utf-8?B?RDNoWHhyZVFqRXV3b3ZYKzZhN285V01jdHY3NHdmRytRaVMvTjJpVWxsMzFN?=
 =?utf-8?B?M0RpZjhIbEEvV2dKdG1IcUFqVzczOHI4SzlpaWJaSWNRZ0Vxc3ZiTGs1T2RC?=
 =?utf-8?B?bTNaQzlYSlh2bDNvOTNCL05NVjNybldpemhpNnhqNjlSNkJrNlQ5NWUrd3pQ?=
 =?utf-8?B?bUxodTJmZEhFQU5MOVZrbGhrYlJoVFhZVkFiVFRwaU1wTlp6V1I5aENkWUx5?=
 =?utf-8?B?NW5zSkVIUFd6d3lmdUNFTmdvKzcxOXE2cVZFYStpMnBFSWxRRnFZeTF2ZWU4?=
 =?utf-8?B?a0lXbU43Zzk1amtnNS96WjFkblV0cUc5a21TTzIvZ0FuNXNNb0ZSSUFNdHdv?=
 =?utf-8?Q?wNiSWLGdyXpogYTXP4Y0o7ZMa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b1b33b-2bdf-4373-c7c0-08dadc488fe1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:55:43.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJa4KzxeB0Q7mHF5UrZLYr+7wKxF1Z1jMRkKHsXAwxg9cWagqFXhHn/M+r5ED/KI/SvBLsAylKw+gJu2cpGOyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Agree, but changing the control flow of this function is really 
problematic , it was even tried before if you remember commit 
"e4103312d7b7a" , it got something to do with port allocation, I'll take 
another look over the code to see what other options we have though.

Since in short, you are right it is racy now.

On 12/12/2022 15:43, Jason Gunthorpe wrote:
> On Mon, Dec 12, 2022 at 03:42:07PM +0200, Patrisious Haddad wrote:
>> I think we have the same realization but different understanding of the
>> code, please correct what I'm missing, rest inline:
>>
>> On 12/12/2022 15:27, Jason Gunthorpe wrote:
>>> On Sun, Dec 11, 2022 at 11:08:30AM +0200, Leon Romanovsky wrote:
>>>> From: Patrisious Haddad <phaddad@nvidia.com>
>>>>
>>>> resolve_prepare_src() changes the destination address of the id,
>>>> regardless of success, and on failure zeroes it out.
>>>>
>>>> Instead on function failure keep the original destination address
>>>> of the id.
>>>>
>>>> Since the id could have been already added to the cm id tree and
>>>> zeroing its destination address, could result in a key mismatch or
>>>> multiple ids having the same key(zero) in the tree which could lead to:
>>>
>>> Oh, this can't be right
>>>
>>> The destination address is variable and it is changed by resolve even
>>> in good cases.
>> This is what I don't think can happen, since one address is resolved(bound),
>> it can't be bound again so each an other try of resolve would fail and enter
>> the error flow which I just fixed.
>>>
>>> So this part of the rb search is nonsense:
>>>
>>> 		result = compare_netdev_and_ip(
>>> 			node_id_priv->id.route.addr.dev_addr.bound_dev_if,
>>> 			cma_dst_addr(node_id_priv), this);
>>>
>>> The only way to fix it is to freeze the dst_addr before inserting
>>> things into the rb tree.
>> I completely agree, and this was my assumption that after resolve address,
>> and resolve route(where I add to the tree), the dst_addr is frozen, the only
>> scenario where it isn't was the resolve_prepare_src failure which some why
>> nullified the value instead of keeping the original.
> 
> Then fix the control flow so it doesn't do the nullification if it
> didn't change the value
> 
> You can't just change it while it is in the rb tree, that is racy
> 
> Jason
