Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3915FD1A
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2020 07:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgBOG1t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 01:27:49 -0500
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:29409
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgBOG1t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Feb 2020 01:27:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5CUBMP/eZ2lUKRJ6QdpJDnYAWfOONQcCfeE68HQWJ7Arsc9C1Fkpe4Tm2Ad51AE2LjBGImnmN/l3L5aH+r/wDtvlay3QE8BACpduH2VZrlIUulgDtoHnv6/gaKYTaw+eyzFOY6z6HupPN8B1RotYPcihSvfbmLj89wjRWX7rrCQ0PTw4e0LKaXvL/eVAs10YUMUZfMAtLWPgJTyomenLDpGzcxa2JiHkO0Sbb2WDxJ1mqkkA0ynOHaGftXXFppj5/46CBwDq9FnC5VugoyE48USQQL+neul+y5Pg/hjK6DIBCe4bmINaxGTyzH86BpKTJRI+TXIA5eCW4BxmJwp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYWlpS5Kj3rIG9DoDv8mGADmM7qdfjN6bWWgWB5RVOE=;
 b=OQM9jK3utBWFD1CLEvwLRNcMai5Idg6F+oVAfUxCQt4FC8x5hXZREmYi6oiiJ4AtwjBjrDHmaNreIZINVIrpbMgQ7DX04T4m51zlnlXN5t9+CS+hXH+iWT3z8N0AwxoK8Pgmb+NepH7/8G/NwvUiK7t8ytMbeAcetvAWbG/i04IjNXHNlQG2xLNQ9AMA2l5d+aq3tnqjZdlxHHKF9efQ2yGxoYcrbbVOlNPHVxm4bsmwz41N5MyDG9PmgQwFs5taBubKdQaWFn/Ft7maNu3b0i8G/W3V0PZ7YY23QVAMnfHBMRi4iaNRtCgledAGNGyeHtYtP4cOX+yG5WzegQl03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYWlpS5Kj3rIG9DoDv8mGADmM7qdfjN6bWWgWB5RVOE=;
 b=V2+Vspoct8dGyhSjvFfY8uUaF8/jQ4AdRpiuxO8VZnbIN8QLosmKoHJewY4GGQq4W2Rbcvk4rMF62sNblpCc5DkPWMFaVN8aIbaEvV1IevKAnYwuPxpI1iPAZtxxGHy7eOkMCjfU9HdPKyEePSPw3cQK4hgoDOLYSUxIYnekOHk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) by
 AM6PR05MB4405.eurprd05.prod.outlook.com (52.135.163.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Sat, 15 Feb 2020 06:27:37 +0000
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::11fc:7536:f265:7920]) by AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::11fc:7536:f265:7920%3]) with mapi id 15.20.2729.025; Sat, 15 Feb 2020
 06:27:37 +0000
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
From:   Mark Zhang <markz@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Tom Talpey <tom@talpey.com>
Cc:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Alex @ Mellanox" <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
 <63a56c06-57bf-6e31-6ca8-043f9d3b72f3@talpey.com>
 <CAFgAxU80+feEEtaRYFYTHwTMSE6Edjq0t0siJ0W06WSyD+Cy3A@mail.gmail.com>
 <b0414c43-c035-aa90-9f89-7ec6bba9e119@talpey.com>
 <CAFgAxU-LW+t17frRnNOYgoaqJEwffRPfFDasOPjbyVmuxj8AXA@mail.gmail.com>
 <09478db9-28ca-65fe-1424-b0229a514bbb@talpey.com>
 <CAFgAxU8XmoOheJ29s7r7J23V1x0QcagDgUDVGSyfKyaWSEzRzg@mail.gmail.com>
 <62f4df50-b50d-29e2-a0f4-eccaf81bd8d9@talpey.com>
 <20200213154110.GJ31668@ziepe.ca>
 <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
Message-ID: <de3aeeb7-41ef-fadc-7865-e3e9fc005476@mellanox.com>
Date:   Sat, 15 Feb 2020 14:27:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To AM6PR05MB4472.eurprd05.prod.outlook.com
 (2603:10a6:209:43::29)
MIME-Version: 1.0
Received: from [192.168.0.144] (115.206.255.68) by SG2PR01CA0146.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Sat, 15 Feb 2020 06:27:34 +0000
X-Originating-IP: [115.206.255.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eec92fa7-5c45-4bec-83f3-08d7b1e02630
X-MS-TrafficTypeDiagnostic: AM6PR05MB4405:|AM6PR05MB4405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB4405C0535505657448CAC8C5CA140@AM6PR05MB4405.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03142412E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(2906002)(66946007)(26005)(6666004)(8676002)(36756003)(16576012)(66476007)(54906003)(110136005)(53546011)(8936002)(4326008)(316002)(6486002)(66556008)(16526019)(5660300002)(81166006)(81156014)(31686004)(186003)(52116002)(31696002)(107886003)(86362001)(956004)(478600001)(2616005)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4405;H:AM6PR05MB4472.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMC8RH+wScflzdEmlrDPQRRcBhhRh3n5zLjVNabygM1z4UowZoBDozQcM2S3FH14OOp29TX9Osswp9XbGwM62nnwCdF5JD1+v00NdBz6iS8GWWGRLigortg/UcAqP5HZhDjvV5/STgHqMH7nN5a1NioMXQbdQs99O13DIvZXEB5E2wZkzkTDkbOvKy7w1WLy6JlLMbtx0ZJzEDvVfYGieZGqwq2TAjrbReqxuZoNt4NXgDvZwl30Wz8B/4gtouxCtzlW9/2iZ+aCPeLIUiXULdVd1icEOWukNV1NKpKjkH8ldn7QF3HW+4syxcOgxxdzKkYEh2q0cLdXUKQwkS+0UKtP57sQtV/6ZKrodEb3/XEYsBoH4nrmZoWl7GqDTor9TSHZ/V2ro+Bg6D1+2NY2pdsPIvZd/WdZTrEOwFbHKCXrpeMI133dd/oX0tQwP67UgtluYoy6GvNon0THHQDVmt0wwabGp9RdSXvdo/loW/Skjf+aKcTK97Vaty3T7qXsUJMdF5vtvqxQ7F7Lo44uSg==
X-MS-Exchange-AntiSpam-MessageData: Rjmc3kXY/U+dx3G1YDmlDGsA0+tTMHhV48px3A6rTeWzhQKN5yrufybnaNPTqJBLJf72JZYmHEWpWVUDDWoSyaTKrhlVRnLhDzhFJ1Zi1K1Qrl63eFTxd9z4TLfPOFsPPqE0EhEmXt4vV/+hPYBTVw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec92fa7-5c45-4bec-83f3-08d7b1e02630
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2020 06:27:37.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTOJN6sbjlSNTrDYVB+w2gcpN3ASBtmTSZtJp7FDDUR1/1v4W4BI0kfzPMyg7CtaS6Kg3n8a3lTti4sdjOYG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4405
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/2020 10:23 PM, Mark Zhang wrote:
> On 2/13/2020 11:41 PM, Jason Gunthorpe wrote:
>> On Thu, Feb 13, 2020 at 10:26:09AM -0500, Tom Talpey wrote:
>>
>>>> If both src & dst ports are in the high value range you loss those
>>>> hash bits in the masking.
>>>> If src & dst port are both 0xE000, your masked hash equals 0. You'll
>>>> get the same hash if both ports are equal 0xF000.
>>>
>>> Sure, but this is because it's a 20-bit hash of a 32-bit object. There
>>> will always be collisions, this is just one example. My concern is the
>>> statistical spread of the results. I argue it's not changed by the
>>> proposed bit-folding, possibly even damaged.
>>
>> I've always thought that 'folding' by modulo results in an abnormal
>> statistical distribution
>>
>> The point here is not collisions but to have a hash distribution which
>> is generally uniform for the input space.
>>
>> Alex, it would be good to make a quick program to measure the
>> uniformity of the distribution..
>>
> 
> Hi,
> 
> I did some tests with a quick program (hope it's not buggy...), seems 
> the hash without "folding" has a better distribution than hash with 
> fold. The "hash quality" is reflected by the "total_access"[1] below.
> 
> I tested only with cma_dport from 18515 (ib_write_bw default) to 18524. 
> I can do more tests if required, for example use multiple cma_dport in 
> one statistic.
> 
> 
> [1] 
> https://stackoverflow.com/questions/24729730/measuring-a-hash-functions-quality-for-use-with-maps-assosiative-arrays 
> 
> 
> $ ./a
> 
> max: Say for slot x there are tb[x] items, then 'max = max(tb[x])'; 
> Lower is better;
> min: Say for slot x there are tb[x] items, then 'min = min(tb[x])'; 
> Likely min is always 0
> total_access: The sum of all 'accesses' (for each slot: 
> accesses=n*(n+1)/2); Lower is better
> n[X]: How many slots that has X items
> 
> cm source port range [32768, 65534], dest port 18515:
> Hash with folding:
>      flow_label: max 2 min 0 total_access 32766  n[1] = 32514 n[2] = 126
>      udp_sport: max 10 min 0 total_access 51740  n[1] = 4420  n[2] = 
> 4670  n[3] = 3112  n[4] = 1433  n[5] = 535   n[6] = 163   n[7] = 31 n[8] 
> = 5     n[9] = 2     n[10] = 1
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 4 min 0 total_access 48618   n[1] = 532   n[2] = 
> 7926  n[3] = 530   n[4] = 3698
> 
> 
> cm source port range [32768, 65534], dest port 18516:
> Hash with folding:
>      flow_label: max 3 min 0 total_access 32774  n[1] = 31214 n[2] = 770 
>    n[3] = 4
>      udp_sport: max 8 min 0 total_access 50808   n[1] = 4406  n[2] = 
> 4873  n[3] = 3157  n[4] = 1413  n[5] = 509   n[6] = 129   n[7] = 20 n[8] 
> = 4
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382
> 
> 
> cm source port range [32768, 65534], dest port 18517:
> Hash with folding:
>      flow_label: max 2 min 0 total_access 32766  n[1] = 32250 n[2] = 258
>      udp_sport: max 10 min 0 total_access 54916  n[1] = 4536  n[2] = 
> 4170  n[3] = 2817  n[4] = 1445  n[5] = 622   n[6] = 275   n[7] = 94 n[8] 
> = 22    n[9] = 5     n[10] = 2
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 3 min 1 total_access 38402   n[1] = 2820  n[2] = 
> 10746 n[3] = 2818
> 
> 
> cm source port range [32768, 65534], dest port 18518:
> Hash with folding:
>      flow_label: max 2 min 0 total_access 32766  n[1] = 32066 n[2] = 350
>      udp_sport: max 8 min 0 total_access 50018   n[1] = 4435  n[2] = 
> 4970  n[3] = 3294  n[4] = 1376  n[5] = 465   n[6] = 92    n[7] = 16 n[8] 
> = 2
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382
> 
> 
> cm source port range [32768, 65534], dest port 18519:
> Hash with folding:
>      flow_label: max 3 min 0 total_access 32774  n[1] = 31816 n[2] = 469 
>    n[3] = 4
>      udp_sport: max 8 min 0 total_access 51462   n[1] = 4414  n[2] = 
> 4734  n[3] = 3088  n[4] = 1466  n[5] = 508   n[6] = 160   n[7] = 32 n[8] 
> = 4
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 4 min 0 total_access 45490   n[1] = 3662  n[2] = 
> 6360  n[3] = 3660  n[4] = 1351
> 
> 
> cm source port range [32768, 65534], dest port 18520:
> Hash with folding:
>      flow_label: max 6 min 0 total_access 34618  n[1] = 20349 n[2] = 
> 5027  n[3] = 550   n[4] = 164   n[5] = 9     n[6] = 2
>      udp_sport: max 13 min 0 total_access 82542  n[1] = 549   n[2] = 
> 1167  n[3] = 1635  n[4] = 1706  n[5] = 1341  n[6] = 836   n[7] = 483 
> n[8] = 223   n[9] = 87    n[10] = 27
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 4 min 0 total_access 65530 n[3] = 2     n[4] = 8190
> 
> 
> cm source port range [32768, 65534], dest port 18521:
> Hash with folding:
>      flow_label: max 2 min 0 total_access 32766  n[1] = 31924 n[2] = 421
>      udp_sport: max 9 min 0 total_access 51864   n[1] = 4505  n[2] = 
> 4645  n[3] = 3038  n[4] = 1464  n[5] = 542   n[6] = 154   n[7] = 43 n[8] 
> = 6     n[9] = 2
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 3 min 1 total_access 32810   n[1] = 24    n[2] = 
> 16338 n[3] = 22
> 
> 
> cm source port range [32768, 65534], dest port 18522:
> Hash with folding:
>      flow_label: max 3 min 0 total_access 32768  n[1] = 32197 n[2] = 283 
>    n[3] = 1
>      udp_sport: max 9 min 0 total_access 50850   n[1] = 4561  n[2] = 
> 4756  n[3] = 3187  n[4] = 1452  n[5] = 453   n[6] = 137   n[7] = 29 n[8] 
> = 2     n[9] = 2
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382
> 
> 
> cm source port range [32768, 65534], dest port 18523:
> Hash with folding:
>      flow_label: max 2 min 0 total_access 32766  n[1] = 32514 n[2] = 126
>      udp_sport: max 8 min 0 total_access 52208   n[1] = 4426  n[2] = 
> 4609  n[3] = 3069  n[4] = 1435  n[5] = 533   n[6] = 180   n[7] = 50 n[8] 
> = 10
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 4 min 0 total_access 46062   n[1] = 3096  n[2] = 
> 6640  n[3] = 3094  n[4] = 1777
> 
> 
> cm source port range [32768, 65534], dest port 18524:
> Hash with folding:
>      flow_label: max 3 min 0 total_access 32774  n[1] = 31362 n[2] = 696 
>    n[3] = 4
>      udp_sport: max 8 min 0 total_access 49490   n[1] = 4440  n[2] = 
> 5148  n[3] = 3240  n[4] = 1413  n[5] = 394   n[6] = 97    n[7] = 14 n[8] 
> = 1
> Hash without folding:
>      flow_label: max 1 min 0 total_access 32766  n[1] = 32766
>      udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382
> 
> 

Another finding is, when cma_dport is multiple of 0x200 (i.e., 0x600, 
0x800, ... 0xFE00), the hash distribution is tens of times worse then 
others. For examples when dport is 18431 and 18432:

cm source port range [32768, 65534], dest port 18431:
Hash with folding:
     flow_label: max 2 min 0 total_access 32766
     udp_sport:  max 8 min 0 total_access 50410
Hash without folding:
     flow_label: max 1 min 0 total_access 32766
     udp_sport:  max 4 min 0 total_access 48126

cm source port range [32768, 65534], dest port 18432(0x4800):
Hash with folding:
     flow_label: max 133 min 0 total_access 1072938 
 

     udp_sport:  max 203 min 0 total_access 2126644 
 

Hash without folding:
     flow_label: max 64 min 0   total_access 1048450 
 

     udp_sport:  max 1024 min 0 total_access 16775170

> 
>> Jason
>>
> 

