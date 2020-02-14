Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3215D95A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 15:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBNOYC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 09:24:02 -0500
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:34383
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbgBNOYC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Feb 2020 09:24:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm4haUDWOITaDF5gJNTII28IUsO0EL1eE9gePL/qXoejukdYRj2FMEnis35w61g8U8lUR28TV/hhjUSH5xNQm7B6jp0ULlmbbNYGY1raZAVb4D20dVWVkbJ7nLBUqcGggtaS+qz1w2gYKrmL7qQHLDZIULJYuu2qmXB/cwmuNXEL/GKY0Wj4Jz4SxKgN1LBzW8cGJWE1TRD5aZ3GEOIW3lSHzy0HR9GG9oqFfNUeNcW6DGckKvU+1zITo11dZDlwFkX0sPPwD4dOEy+ezRBsJ5DSAclmUcA9SWDtHWkYxlgB2bFM1gbMbzeDRmQIrm0zZsHmekbwCPKZHv7Xh1ppnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK70zrbHnmHJHhBg+0KvZsxaN7fZPI7gXHN6jJ6iwmM=;
 b=SrbOfciqTppss6rlOCx+CC2Lix5i/Iess4VXh3HsotrsUBTpxhrkwSdgAxVLOWWh/DKVgDnCjcwlpyMA4ypWOakzXb8zANQmFgEohx6/CL4nrvgRZli1mb6nhZqwCKo3FqMMXFMfcKCcgex40anfaf7VZSGzeayYCWL2OX883lyZsWro4NznS4SQYZ/yXWpSUWXfvydtHIJLCu1qg+F4cWJ3mBzpK7tFF87Gkn1Zex0A6AUXrNGZPpv0eoExve14wlBICzbw7+es3kXMNq3LtTl1D3mvWd8VM+zCljzJBvHd+vObNRC/p5wD84oJD+J3Sh5HKU5/bybKs3btba+82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK70zrbHnmHJHhBg+0KvZsxaN7fZPI7gXHN6jJ6iwmM=;
 b=qgkmvOdJMs1TAlCmvKhMAOW6wI1RrGS9dJRNZh5wGaPupLJf6969TC+VYrhOaYXqXXTO97blPZIeGZrhToSOviKTWCeZM0XP4hRoAc7y8qfti7MJU4qETnN7li/wV1HBcfdNrrELvpLGkJ5UrefmnhVzZf0DiMEu769+bd3LV0g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) by
 AM6PR05MB4102.eurprd05.prod.outlook.com (52.135.166.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 14:23:57 +0000
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::11fc:7536:f265:7920]) by AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::11fc:7536:f265:7920%3]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:23:57 +0000
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
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
From:   Mark Zhang <markz@mellanox.com>
Message-ID: <3be3b3ff-a901-b716-827a-6b1019fa1924@mellanox.com>
Date:   Fri, 14 Feb 2020 22:23:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200213154110.GJ31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To AM6PR05MB4472.eurprd05.prod.outlook.com
 (2603:10a6:209:43::29)
MIME-Version: 1.0
Received: from [192.168.0.144] (115.198.63.123) by SG2PR02CA0040.apcprd02.prod.outlook.com (2603:1096:3:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Fri, 14 Feb 2020 14:23:54 +0000
X-Originating-IP: [115.198.63.123]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 252b9bbb-d91b-4862-08c0-08d7b15986e8
X-MS-TrafficTypeDiagnostic: AM6PR05MB4102:|AM6PR05MB4102:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB41027E3A278E4045FAED9625CA150@AM6PR05MB4102.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(54906003)(5660300002)(316002)(966005)(16576012)(110136005)(478600001)(31686004)(2906002)(53546011)(186003)(16526019)(6666004)(26005)(6486002)(52116002)(36756003)(4326008)(107886003)(81166006)(66556008)(8936002)(66476007)(31696002)(81156014)(2616005)(956004)(8676002)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4102;H:AM6PR05MB4472.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIbOVZuP5W6GvDjHsAg4WPc3FNhF8/l1a1GdVbRlO7QwiGZttFXy/Lzhwh8L9NJjF4fcNBui5j6CE3+IZCPlKiZU2VAdQzxEagyqXuBZtNLlvBmfzGJGF0i2IgM7LU19ldrmPH69a+tJUGiiBUZk8hTOXxzcLhGmamczl6cnpht2pMt7dhCDut8ol6X1d16k5UqUyAhPU2LZY1LjKHDz1WXOW0I9GUDCh8b704XCAddhFNnesbLV0IOz/HkGTjl2me7ZLU4JQFr0MvVqtsCGuJeJIBlOP3q+VX+AZhelVtoegdD7Ib8Nsn4If5LvStW+OfgvBt3Wlj0zp7LHRskzOZ3ipiSUh/1je58SFcjzqfzuJJmEnGgZ0AK+Kko7BfT0Pw63qk+rBiuw6YLJeVpNV32DpmKXRyJoHXC4aLsxr29oF1eIUHCRcOOYGlUIfza8lLjPdj4zcH97l03I6DpZ4l8bQqw0uJjth19Ots4Zomf5DhqiviBu4Yxy9eBViHmQF5KzAT18YgCtbXPXCMhnWw==
X-MS-Exchange-AntiSpam-MessageData: 0DOkqD4JM+xpjx3IcQRtVGGsrsfrB9WyDMhandeRWHv9JsNkdJMY7ntWkfTx3q63EqosnT9y5najdCDlV1BhffsybjaYnJCdfTrKUCqDOQUJ6ccG32UeUU5Gi2XF5ryITmEverJFmJU5DZYYiIQn3w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252b9bbb-d91b-4862-08c0-08d7b15986e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:23:57.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ2p0Prvv/6OSBE8TRr44pRtiuvrcT3C0q4uqK7masglxZZRmea1mOMP9swapZ5n0duFp5MfHuKidvFAdp04/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4102
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/13/2020 11:41 PM, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2020 at 10:26:09AM -0500, Tom Talpey wrote:
> 
>>> If both src & dst ports are in the high value range you loss those
>>> hash bits in the masking.
>>> If src & dst port are both 0xE000, your masked hash equals 0. You'll
>>> get the same hash if both ports are equal 0xF000.
>>
>> Sure, but this is because it's a 20-bit hash of a 32-bit object. There
>> will always be collisions, this is just one example. My concern is the
>> statistical spread of the results. I argue it's not changed by the
>> proposed bit-folding, possibly even damaged.
> 
> I've always thought that 'folding' by modulo results in an abnormal
> statistical distribution
> 
> The point here is not collisions but to have a hash distribution which
> is generally uniform for the input space.
> 
> Alex, it would be good to make a quick program to measure the
> uniformity of the distribution..
> 

Hi,

I did some tests with a quick program (hope it's not buggy...), seems 
the hash without "folding" has a better distribution than hash with 
fold. The "hash quality" is reflected by the "total_access"[1] below.

I tested only with cma_dport from 18515 (ib_write_bw default) to 18524. 
I can do more tests if required, for example use multiple cma_dport in 
one statistic.


[1] 
https://stackoverflow.com/questions/24729730/measuring-a-hash-functions-quality-for-use-with-maps-assosiative-arrays

$ ./a

max: Say for slot x there are tb[x] items, then 'max = max(tb[x])'; 
Lower is better;
min: Say for slot x there are tb[x] items, then 'min = min(tb[x])'; 
Likely min is always 0
total_access: The sum of all 'accesses' (for each slot: 
accesses=n*(n+1)/2); Lower is better
n[X]: How many slots that has X items

cm source port range [32768, 65534], dest port 18515:
Hash with folding:
     flow_label: max 2 min 0 total_access 32766  n[1] = 32514 n[2] = 126
     udp_sport: max 10 min 0 total_access 51740  n[1] = 4420  n[2] = 
4670  n[3] = 3112  n[4] = 1433  n[5] = 535   n[6] = 163   n[7] = 31 
n[8] = 5     n[9] = 2     n[10] = 1
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 4 min 0 total_access 48618   n[1] = 532   n[2] = 
7926  n[3] = 530   n[4] = 3698


cm source port range [32768, 65534], dest port 18516:
Hash with folding:
     flow_label: max 3 min 0 total_access 32774  n[1] = 31214 n[2] = 770 
   n[3] = 4
     udp_sport: max 8 min 0 total_access 50808   n[1] = 4406  n[2] = 
4873  n[3] = 3157  n[4] = 1413  n[5] = 509   n[6] = 129   n[7] = 20 
n[8] = 4
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382


cm source port range [32768, 65534], dest port 18517:
Hash with folding:
     flow_label: max 2 min 0 total_access 32766  n[1] = 32250 n[2] = 258
     udp_sport: max 10 min 0 total_access 54916  n[1] = 4536  n[2] = 
4170  n[3] = 2817  n[4] = 1445  n[5] = 622   n[6] = 275   n[7] = 94 
n[8] = 22    n[9] = 5     n[10] = 2
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 3 min 1 total_access 38402   n[1] = 2820  n[2] = 
10746 n[3] = 2818


cm source port range [32768, 65534], dest port 18518:
Hash with folding:
     flow_label: max 2 min 0 total_access 32766  n[1] = 32066 n[2] = 350
     udp_sport: max 8 min 0 total_access 50018   n[1] = 4435  n[2] = 
4970  n[3] = 3294  n[4] = 1376  n[5] = 465   n[6] = 92    n[7] = 16 
n[8] = 2
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382


cm source port range [32768, 65534], dest port 18519:
Hash with folding:
     flow_label: max 3 min 0 total_access 32774  n[1] = 31816 n[2] = 469 
   n[3] = 4
     udp_sport: max 8 min 0 total_access 51462   n[1] = 4414  n[2] = 
4734  n[3] = 3088  n[4] = 1466  n[5] = 508   n[6] = 160   n[7] = 32 
n[8] = 4
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 4 min 0 total_access 45490   n[1] = 3662  n[2] = 
6360  n[3] = 3660  n[4] = 1351


cm source port range [32768, 65534], dest port 18520:
Hash with folding:
     flow_label: max 6 min 0 total_access 34618  n[1] = 20349 n[2] = 
5027  n[3] = 550   n[4] = 164   n[5] = 9     n[6] = 2
     udp_sport: max 13 min 0 total_access 82542  n[1] = 549   n[2] = 
1167  n[3] = 1635  n[4] = 1706  n[5] = 1341  n[6] = 836   n[7] = 483 
n[8] = 223   n[9] = 87    n[10] = 27
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 4 min 0 total_access 65530 
n[3] = 2     n[4] = 8190


cm source port range [32768, 65534], dest port 18521:
Hash with folding:
     flow_label: max 2 min 0 total_access 32766  n[1] = 31924 n[2] = 421
     udp_sport: max 9 min 0 total_access 51864   n[1] = 4505  n[2] = 
4645  n[3] = 3038  n[4] = 1464  n[5] = 542   n[6] = 154   n[7] = 43 
n[8] = 6     n[9] = 2
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 3 min 1 total_access 32810   n[1] = 24    n[2] = 
16338 n[3] = 22


cm source port range [32768, 65534], dest port 18522:
Hash with folding:
     flow_label: max 3 min 0 total_access 32768  n[1] = 32197 n[2] = 283 
   n[3] = 1
     udp_sport: max 9 min 0 total_access 50850   n[1] = 4561  n[2] = 
4756  n[3] = 3187  n[4] = 1452  n[5] = 453   n[6] = 137   n[7] = 29 
n[8] = 2     n[9] = 2
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382


cm source port range [32768, 65534], dest port 18523:
Hash with folding:
     flow_label: max 2 min 0 total_access 32766  n[1] = 32514 n[2] = 126
     udp_sport: max 8 min 0 total_access 52208   n[1] = 4426  n[2] = 
4609  n[3] = 3069  n[4] = 1435  n[5] = 533   n[6] = 180   n[7] = 50 
n[8] = 10
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 4 min 0 total_access 46062   n[1] = 3096  n[2] = 
6640  n[3] = 3094  n[4] = 1777


cm source port range [32768, 65534], dest port 18524:
Hash with folding:
     flow_label: max 3 min 0 total_access 32774  n[1] = 31362 n[2] = 696 
   n[3] = 4
     udp_sport: max 8 min 0 total_access 49490   n[1] = 4440  n[2] = 
5148  n[3] = 3240  n[4] = 1413  n[5] = 394   n[6] = 97    n[7] = 14 
n[8] = 1
Hash without folding:
     flow_label: max 1 min 0 total_access 32766  n[1] = 32766
     udp_sport: max 2 min 1 total_access 32766   n[1] = 2     n[2] = 16382



> Jason
> 

