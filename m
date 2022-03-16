Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6444DAE56
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 11:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355168AbiCPKj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352350AbiCPKj2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 06:39:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630C411C0A;
        Wed, 16 Mar 2022 03:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0khkrDlQ31Ho9QwNXReIq829AYYv/SLbRCo8KGF2kYXc7t0JCAi+9+lSWzWZxonA71Z8VMSM581zaBTCkzEJeZdYqSFMNREVzymP9zzChuhHpt1C0eYQWql9IPFGSnQefEtYGeRAgL5WCgHceGgw6FzEV6/yjrpdYJPK/lIyNEnKEJ0zExRkI5EVymwZeiToThyksRVxrYEqWjLvo7Pr9Jdw+cCqRTaJnqXDCbahDfSJyn6CFDQzlC6KTam05JRXtuEIjDpcvR/lMChFqK0JTsMd5yApc9C0M16ylqF06fTNkmcr2QlSWKLhbejGmGW+Ioz/UP85le3UKT8uxTFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg+N+ZM0ZaE9S1ZBaeuI0Z50tlEvRBKqMuEHyWOC3aY=;
 b=mNa+/n2l4vyhwDGJTbJH82E6FAyie0KS8leoVdBdV5LDluv6XAr7pxfyStyJlQGeBgvBrOa+Ud8ouZmSDDykhK4sL1T2Kvei9lg/LvFnoMqaZJoG5+z+ze7FRmOBNePeLWhy/A0b3choM0QwKy3dCFdp4DUxJS9iC9hNccRr9y7quJS1/McVdxQf4WOmht1DM2UyboYNI5w3MVDzHqBcnmB8pusHv1g+YHHVOIgPLqgwsZzexVYYlXt6vuBD4t0lvYpFMegWUL3BjQY4avzh0+kjrUb7IGADskV3/TwFCHsuEhdtYbZ/KT1y29RV1IV1n5I7dwTleaB/Q9GkW8H+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg+N+ZM0ZaE9S1ZBaeuI0Z50tlEvRBKqMuEHyWOC3aY=;
 b=DUJsEXqVBYdNzWW8SKsKfpv+Cux6PUATVXIDMzvv9NPCpxKyCPbZMkJZLvjfz1fYBu4ekWb4HwIJA31xjTU7RE0WDltLzxa7m0HI3c3qO8kYl5WPZJhwEntsTQXW+zuWF00/Skk/8JR1EZLr34Naa2bLn/v4DnMRGc8hLxxi2b24KFYzwV1EoOLAL7c3eHDK04wjLoSifklWDo2mBmFuatt4l64/W+d0A6O428XrbsXeQwVtwrEslEjj+DAamWtW9mUXYI7XqzRqikhvjSkq8Cb+v6dPj9sY2XyKQ/cjGGglZ4uBY+12H6V+FieKzOj5Yg87VhmKTaliJdsmnxD8Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM5PR12MB1577.namprd12.prod.outlook.com (2603:10b6:4:f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Wed, 16 Mar 2022 10:38:12 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 10:38:12 +0000
Message-ID: <a1cc6842-1429-eea5-aa0d-47b3f2bab843@nvidia.com>
Date:   Wed, 16 Mar 2022 12:38:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
Content-Language: en-US
To:     Laurence Oberman <loberman@redhat.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
References: <20220311175713.2344960-1-djeffery@redhat.com>
 <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
 <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
 <e39a032f-9e95-a038-c29c-30bb58e45fc0@nvidia.com>
 <CA+-xHTHK1y7JFAeBN=NVq=vaRBXfRNPbF5ZxmdQ2trhhU+E0tQ@mail.gmail.com>
 <f18f7a350bf5b0f0651083d9a592d35d0d5a68f4.camel@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <f18f7a350bf5b0f0651083d9a592d35d0d5a68f4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3fceb44-e448-4234-0130-08da073911ac
X-MS-TrafficTypeDiagnostic: DM5PR12MB1577:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB157717EF5BDE733DC6910A1CDE119@DM5PR12MB1577.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmnt5TcYfEzaL1e3+R7om+o8GQHVgGmbSrIyPNr1XTFVE6DRZQG0IM7pZBdzkmCT4kPkIGd2ZhZnXHqYdDw0qdFy+fikTHBsARXcRzo0s99nAy10XE7JAb1OPbLtih3BP5TyK+BPYEF4etfB1SdZEsodTS0n/1mN/ElJGRTjdyxpWCivAiQlZcK4fZE6bQzN2cmlsmhYlLregznXfSg+nTVDzAfv01YBQWMIxx5sQcbZGy++1uSCHXWwgwmdQy1ke45Vd1yd513HoWgLaqE0YP58nfRI1LbDQeDqkz2GqWt0Edfri9yD3vsRncXAKs+MCR8waEolk+v44rBn4m78dj6Aa+bhlJK9sHyNKV4w1+cu5gIFR1ecbpoS6wl8kMuHFa16iuGEEe/nNSdLnNfc8KuHh06p5on2G1DoeAohlZ6ozsHoHrNICXqh2zH+f5L0K42ll2tfOTZKX0Qzw0Km2zvQr8DGn9x9pBSa4qVnrY/Ybvqs71WUYyltNTevzq23tageiElkjIJBQaHbq7CPYR0qFkFuuIPtz+4OoH3MQ0B60aSHZH+DLmIqwtTDu0uBrTDAjjmnYVm6xVxHNMg7Kb406RTThF/wu4UHuaH+xW9m3nOt7ocSd/KixcpWJ/ioLTXrc2oN/MWcSlwL4EfjN3ftkqTsxya/guPxFXrB1mKqeU6ipAHT8DfUNEngplQcPhjMojej/zzpRmxJQvGvZy+/eyY0rVgTOkYZyKcTj7p3GOcXpdoTtcUZg4HiW9PC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(6666004)(316002)(4326008)(6512007)(6506007)(53546011)(38100700002)(8676002)(66476007)(66946007)(66556008)(31696002)(86362001)(508600001)(6486002)(31686004)(5660300002)(36756003)(8936002)(2616005)(26005)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a25CZDNSWXUyaDBSUWpHL0tWenc0SVlXeHRPbkJFL2pLRHA2K3RPaG9mOEYw?=
 =?utf-8?B?RUNUNXR4b0ltU1lHUkR3cW1NMXJFa205dnQ4NTJnYVpTakdkejJzTUttZ0d2?=
 =?utf-8?B?dldJeVlWVFdheEhWaUhPY3A1WXJYM3RNYTB2SU1mK1cvN2E1by9QdktXcjVH?=
 =?utf-8?B?eXFlZ0hvbDE1NVpyZGIydGx6a0Npa0l0TUl2VWVhY1RlRkRpWWwvelB5VThK?=
 =?utf-8?B?NVhYbG8yZVNVSU5wSHFueFI3bThhb2o2bEdQRzdDNjhKZzhZRzQ5YUJRcHJt?=
 =?utf-8?B?RW43YUJvcVptaXU5OFh3bitsZm9vNEJnN3hneFBXSlM1SndZNmNTV3VNWTQ5?=
 =?utf-8?B?bE5zNE5JaWM5K1Y5L0xoTDRIN2Q5UVdYNldvMFZFQVUrUXljUlFVeU1MMGRv?=
 =?utf-8?B?N1AwZ0dXd2dNRFVNTEh5aFArZTJQRkNSZTVIaEZFUkZ0MERSTTVMdDRLQVVC?=
 =?utf-8?B?bTFrTUpSYkROMzlZVmVoUkw1YktOam5iaUJ6YStiQUkvbDZUak0rSmJ6SVhD?=
 =?utf-8?B?QnNaQ3hDNEFCaWR5bGJ5OE9LNHVrMW54UFRUYnJ2MXp3NGdzRVV1Q21FbjNo?=
 =?utf-8?B?QTF5SUQxMW1lUEZoSU1sRGtLdTU5eERuNXpwdDZvV0lSRm1YY1dlWkROU3o4?=
 =?utf-8?B?N0s2RUZUcVk4NXBZRXVFV1BZT3lSUDRXZVBtSUJUMVlqaWtkdEpEZVRZQmpk?=
 =?utf-8?B?UEVnMGE1UVRUQ21mTTNEcmVucnN2U0J0RWYxSDlLZWpSSldOUUZSUU5mVzhq?=
 =?utf-8?B?cUI1a254TlJ1WE5mb0ovRDRoQXNrSE03S2Njc1kwcmdVS0ZOWmJVSlhqK29a?=
 =?utf-8?B?TjZxMDdoMTZpS3MxYVVZcmdyNGJCMjM5M2dxallkT2xjVjhRbktCRGZZdjFH?=
 =?utf-8?B?SC9NVGVaek56OC84SHdJSDFQMHUrZ0VtUTFWREpDN1lSZjJJTWhDQWVXQjd0?=
 =?utf-8?B?Yzh4RE1VMWFiY3ppdk5DOVhSck1kTzdIKzZYazZYa255U01nM1FRTDZ6SmJk?=
 =?utf-8?B?UUhrT0dzK0diY1U3VmFsb2o5RVp6clZMaUlTOXh3ajBKZDgxd3FzZGd0VXB5?=
 =?utf-8?B?R1BVbU1mODVVREF4WGQvblVpdzgvekx4Wklvd0RUZk0rWWpiaDhadkJJMkZJ?=
 =?utf-8?B?djczanA2RGEzZTRqWmVoeGpvemZINW0yV3Z5TlFSSnMwbXpSWlBHbngwblN6?=
 =?utf-8?B?MFdhU3VWU0paRWMzb0NmUitPbk82TUhtbEtGYUFKMmdrWEs3QzdFOGF0WS8r?=
 =?utf-8?B?VzBwNmxXaUtjTURZa05PTU4yVGVoSHc2cEhjTXVMaDI2QjYrSC9xTW5vVVhQ?=
 =?utf-8?B?OTdxM1JFdW1Jd3preWNrWmUvR1Btc1NXRjZFalROclpTL05JUjFJTGFiZ21X?=
 =?utf-8?B?TWxLVHgycGthZGp1dnFrOGdtMkJLOTRxS0h1K0NCZlV5Y045c002Vkxrb1JK?=
 =?utf-8?B?UjdUUVBlWXhCVUxjbHFyRW9hVndiTVZHRktYQ3E4UnpOcG1Rc2VVMmx3REJH?=
 =?utf-8?B?bTBoaHFyUXIzeFhHVGR6TkdnV3hrTE1WWFdBcDZ2S0R4YmpSdDNRNWRZZ2E2?=
 =?utf-8?B?dW9BdGhlWTdPY0hXSWc3WTBiN2JMZjBJMDg5YzcwRitZaDZSU1o3TDVoQmlO?=
 =?utf-8?B?ZlVmVklmSXVNSEJQaHBIaUlzOHBvVkxjdXBPY3A2REpMZEExdXNWeWs5eWxU?=
 =?utf-8?B?emRacXVLd2ZjZU9lWk9vcmNTUjdjZW1KZEoyU1NpSktUTlUvRHBNRURDNHZi?=
 =?utf-8?B?aWFEVk90VmdVWXlISmFKdVdFM2RnY2g0K2w3OWthdGFzQmZPRzZ5eVJmNmxq?=
 =?utf-8?B?MDJJbi9Lc2JKSFV1VUFLUExLWGNWbFBnOEVLMGFrU3loVUNRNTlvUkpmVHBY?=
 =?utf-8?B?M2t4M09tNHhaTVhkYWNrSjZaWFVqeC9waWkvdkNLNHMrNXRYY3R4bmNXRzMy?=
 =?utf-8?B?dForV3RlUWc1K3Y3M0QyQUtzTkpYbWZrQU9YM3ZHZXp6bzg1Ni94VzhPRUd6?=
 =?utf-8?B?Ny9VSHR4RFNBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fceb44-e448-4234-0130-08da073911ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 10:38:11.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh72EOzQ/yq+jfyRc14zsE38xEkbs10dD99KgEXEiKGLz3Nfv6k5QwxQWCKcRTvbHLzqxrwS7mjDPY49fIvdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1577
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/14/2022 7:40 PM, Laurence Oberman wrote:
> On Mon, 2022-03-14 at 11:55 -0400, David Jeffery wrote:
>> On Mon, Mar 14, 2022 at 10:52 AM Max Gurtovoy <mgurtovoy@nvidia.com>
>> wrote:
>>>
>>> On 3/14/2022 3:57 PM, David Jeffery wrote:
>>>> On Sun, Mar 13, 2022 at 5:59 AM Max Gurtovoy <
>>>> mgurtovoy@nvidia.com> wrote:
>>>>> Hi David,
>>>>>
>>>>> thanks for the report.
>>>>>
>>>>> Please check how we fixed that in NVMf in Sagi's commit:
>>>>>
>>>>> nvmet-rdma: fix possible bogus dereference under heavy load
>>>>> (commit:
>>>>> 8407879c4e0d77)
>>>>>
>>>>> Maybe this can be done in isert and will solve this problem in
>>>>> a simpler
>>>>> way.
>>>>>
>>>>> is it necessary to change max_cmd_sn ?
>>>>>
>>>>>
>>>> Hello,
>>>>
>>>> Sure, there are alternative methods which could fix this
>>>> immediate
>>>> issue. e.g. We could make the command structs for scsi commands
>>>> get
>>>> allocated from a mempool. Is there a particular reason you don't
>>>> want
>>>> to do anything to modify max_cmd_sn behavior?
>>> according to the description the command was parsed successful and
>>> sent
>>> to the initiator.
>>>
>> Yes.
>>
>>> Why do we need to change the window ? it's just a race of putting
>>> the
>>> context back to the pool.
>>>
>>> And this race is rare.
>>>
>> Sure, it's going to be rare. Systems using isert targets with
>> infiniband are going to be naturally rare. It's part of why I left
>> the
>> max_cmd_sn behavior untouched for non-isert iscsit since they seem to
>> be fine as is. But it's easily and regularly triggered by some
>> systems
>> which use isert, so worth fixing.
>>
>>>> I didn't do something like this as it seems to me to go against
>>>> the
>>>> intent of the design. It makes the iscsi window mostly
>>>> meaningless in
>>>> some conditions and complicates any allocation path since it now
>>>> must
>>>> gracefully and sanely handle an iscsi_cmd/isert_cmd not existing.
>>>> I
>>>> assume special commands like task-management, logouts, and pings
>>>> would
>>>> need a separate allocation source to keep from being dropped
>>>> under
>>>> memory load.
>>> it won't be dropped. It would be allocated dynamically and freed
>>> (instead of putting it back to the pool).
>>>
>> If it waits indefinitely for an allocation it ends up with a
>> variation
>> of the original problem under memory pressure. If it waits for
>> allocation on isert receive, then receive stalls under memory
>> pressure
>> and won't process the completions which would have released the other
>> iscsi_cmd structs just needing final acknowledgement.

If your system is under such memory pressure can you can't allocate few 
bytes for isert response, the silent drop

of the command is your smallest problem. You need to keep the system 
from crashing. And we do that in my suggestion.

>>
>> David Jeffery
>>
> Folks this is a pending issue stopping a customer from making progress.
> They run Oracle and very high workloads on EDR 100 so David fixed this
> fosusing on the needs of the isert target changes etc.
>
> Are you able to give us technical reasons why David's patch is not
> suitable and why we he would have to start from scratch.

You shouldn't start from scratch. You did all the investigation and the 
debugging already.

Coding a solution is the small part after you understand the root cause.

>
> We literally spent weeks on this and built another special lab for
> fully testing EDR 100.
> This issue was pending in a BZ for some time and Mellnox had eyes on it
> then but this latest suggestion was never put forward in that BZ to us.

Mellanox maintainers saw this issue few days before you sent it 
upstream. I suggested sending it upstream and have a discussion here 
since it has nothing to do with Mellanox adapters and Mellanox SW stack 
MLNX_OFED.

Our job as maintainers and reviewers in the community is to see the big 
picture and suggest solutions that not always same as posted in the 
mailing list.

>
> Sincerely
> Laurence
>
