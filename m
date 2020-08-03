Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9614C239F8D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHCGTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:19:53 -0400
Received: from mail-db8eur05on2052.outbound.protection.outlook.com ([40.107.20.52]:29664
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbgHCGTx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Aug 2020 02:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyMbLjxJlDufyvwotpn75uFMqYezAkqPbdb7nQR1ZoRY6KQTRvun3/OgXW6SS5r/spgk8A5Tff+3DIEWUdJiXb4Rs0GeYqNkak5ZHBJKW6KdtwVmTCkDUo2RYmW2wvSEn9uPgGXyzzfNp/qpqc6nv2ieweg8EQkUbe5NqhQ0bKWXcba80NrnjM5Nv4ve6llPdZhAcEBvO7Og05pqHTfG3r15q/G5gQXC7klnPANRKjAZWeWS0du1TmpUhXjQkg3PYacV57p+HfhmilylAFvpT7jofJ4eW4dKJ9qxMOAWHnCA0b6090VAERrESgevJVIOMLtadLo3Q4iZ7G3i6ugo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J++VLJyJkUU+hb49mEJh1rGv/EDV2GJaunAC3F0hAD0=;
 b=XwaUJUMOBz2FdR86TEm54Oyrpa1gHWdfMoWMMxiFRdvAzjjIzqWOyp1EZ+ojG+iULlVv84GMUja87jOjirLBzk0PQrgAgVoylipaiQS+ILaXWhJ1N4hCxQ3+NZ5n+2rZpkj9QbIrismWCtCr7sJY/eeFptldeXy71nuqYEIyJxbn/c5viNeAswSkQaD5Fn54Ws9dYZJ96/psJ/0o0CYDxHcUce2uJJOZ/J3fviD75vAYrFny0cQvahVUBz71v7jf2bV4qHgmuNYFny0Y693LSmF9k9YepyXQcDRRfev3end3ZMoxLcu8dRyyTYeMfrFxqjtRnjZohpPuDM3y4Scocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J++VLJyJkUU+hb49mEJh1rGv/EDV2GJaunAC3F0hAD0=;
 b=sp9+XCG38u7l78L2hSLxk8+Orq2Qk53rtud4MO9XDv6a3gA64UUfPsjpVMUxk4egp4nfTxrRM2iKjX5ad5nc6n0FGlGs5+VmuUZf2rJ9TyV/XHLoDclkC8kqq7rsg1xyrz38ffFwLHl1N/USkZEWE9LA75xzThS3XCyq/Wx13+0=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB6PR05MB4598.eurprd05.prod.outlook.com (2603:10a6:6:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Mon, 3 Aug
 2020 06:19:48 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::d01d:afa5:a941:8e77]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::d01d:afa5:a941:8e77%7]) with mapi id 15.20.3216.034; Mon, 3 Aug 2020
 06:19:48 +0000
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
To:     Bart Van Assche <bvanassche@acm.org>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, lkp@lists.01.org
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
Date:   Mon, 3 Aug 2020 09:19:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0103.eurprd05.prod.outlook.com
 (2603:10a6:207:1::29) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.11] (217.132.245.180) by AM3PR05CA0103.eurprd05.prod.outlook.com (2603:10a6:207:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Mon, 3 Aug 2020 06:19:47 +0000
X-Originating-IP: [217.132.245.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66271b18-82cb-46f3-c474-08d83775395b
X-MS-TrafficTypeDiagnostic: DB6PR05MB4598:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR05MB459804EA8615A2622A329DB9B14D0@DB6PR05MB4598.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTpJ4giYeCRRd2GHGsxLO2Z0g7nsq+tYYcqpiQF0Oky4VW9YeBd52QAg5x6fUZOreKZMuhPbfJlr1l7DiCjjhP+W0TTwqxr8N4aNetou1/zqArhx09VjuehkS8R8AGQzsyIF7nkjoUCbH5YKdM3Ncb4NuxboNU3yuNiW6/Z57GB5dyuLUU/Pg2oH0cpm16fundUur2u1b9iPC3Nzs8zqiuFfmhP+eiol175nHsgZ9+e6yz7C+YjZHP0Jlrgex0n2I8GMqFjqzZRZ/a70syJkXTBKPn5EPjgn4+rJoB5e59kyAbHdztkpGa/lijRVWTRaretssuAZQpTyc287tLEichLNvh28OgiLc3ttp2mAeqy8rZGSzFr2WblLaXqV0/Mb+WNxO6mx8RC/a8MtR7+k0Yw+gnDTiEkI7aJAKZTjqPvDx6+I5xEvbbHvZyIZXcxH89erKGO5ozTyN6rtm9N5nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(478600001)(8936002)(966005)(8676002)(6486002)(36756003)(31696002)(2906002)(66556008)(83380400001)(66946007)(66476007)(6666004)(53546011)(2616005)(956004)(5660300002)(31686004)(4326008)(16576012)(316002)(16526019)(54906003)(86362001)(52116002)(26005)(110136005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gz725TdBFEZChCvdvA7AB8eEWb9tZckwDeiDWSXgbheUq0tJPbUUcLhPu5T8tjrOf2ybj/WAFyDk2lNtsNJJNnk6qohjdHNwIrFfWdw+Cz9LeSc2aNiAghpk+QMNRAbAHk5NkqN5a+OqUPeK60FeZCUrVFZ6tiSlRzxvFdhKO1t1rANAyQXFASIuhFw4jvehjpIaFNTFF5VFaA85N+9lQYXt0Yj/RbSyc8RLIlrHwkfjqioXi84liKdUTjmxLcjs9EcGxw+znMatcxpw5RIqaQsGfI7Z/vcCL2yXCkm5RTiD+/gmKGxBR0OoYYqkVVRWIhyBYH2JF/muKJD20GznA91sdKDZ5jNJxGhEZ5fiRfmcQshoWA7dne+yxxh9AU0bivFbBPXO+7dk4c4Q0p7TJLXdRDs5rbzcUpl7TgyCx/ZDckLAHAyOcc9Rise8G2FzKbtMWDo8ILBGu/ioooRPCIUvdZEd+oMK1WkZ6x9QFKOYTF6sUw8YgGfQb9DKEIJ05bwuFlUjX7SxPbVOT2HaW9pUUS6Im13g3cL1tTgsm5O4pw/SheZz+gQezvyJ0mRUUipB/DaTkP3TUTVfsIFnBq5vhjNVFLFyYyhw6uebHjyoPHvL7Um9GjQYFP6YjuFHkDDSQ/I32UryO/qK1YhlIw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66271b18-82cb-46f3-c474-08d83775395b
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0502MB4011.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 06:19:48.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yfIM5q6jvQnlHUxSlYfRFU/E6gha7ixTksbVPQOU1ymlsCNyhz5NAKM2RmyJ3FHAJ8jQmABn/eJd5IIIxJd1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/2/2020 6:05 PM, Bart Van Assche wrote:
> On 2020-08-01 23:09, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: c804af2c1d3152c0cf877eeb50d60c2d49ac0cf0 ("IB/srpt: use new shared CQ mechanism")
>> https://git.kernel.org/cgit/linux/kernel/git/rdma/rdma.git for-next
>>
>>
>> in testcase: blktests
>> with following parameters:
>>
>> 	test: srp-group1
>> 	ucode: 0x21
>>
>>
>>
>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 4G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> user  :notice: [   44.688140] 2020-08-01 16:10:22 ./check srp/001 srp/002 srp/003 srp/004 srp/005 srp/006 srp/007 srp/008 srp/009 srp/010 srp/011 srp/012 srp/013 srp/015
>> user  :notice: [   44.706657] srp/001 (Create and remove LUNs)
>> user  :notice: [   44.718405] srp/001 (Create and remove LUNs)                             [passed]
>> user  :notice: [   44.729902]     runtime  ...  1.972s
>> user  :notice: [   99.038748] IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
>> user  :notice: [ 3699.039790] Sat Aug  1 17:11:22 UTC 2020 detected soft_timeout
>> user  :notice: [ 3699.060341] kill 960 /usr/bin/time -v -o /tmp/lkp/blktests.time /lkp/lkp/src/tests/blktests
> Yamin and Max, can you take a look at this? The SRP tests from the
> blktests repository pass reliably with kernel version v5.7 and before.
> With label next-20200731 from linux-next however that test triggers the
> following hang:

I will look into it.

>
> sd 8:0:0:0: [sda] Synchronizing SCSI cache
> rdma_rxe: not configured on eth0
> rdma_rxe: not configured on lo
> INFO: task modprobe:1894 blocked for more than 122 seconds.
>        Not tainted 5.8.0-rc7-next-20200731-dbg+ #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> modprobe        D27624  1894   1081 0x00004000
> Call Trace:
>   __schedule+0x4ee/0x1170
>   schedule+0x7f/0x170
>   schedule_timeout+0x453/0x6f0
>   wait_for_completion+0x126/0x1b0
>   disable_device+0x12a/0x1c0 [ib_core]
>   __ib_unregister_device+0x64/0x100 [ib_core]
>   ib_unregister_driver+0x11c/0x180 [ib_core]
>   rxe_module_exit+0x1e/0x36 [rdma_rxe]
>   __x64_sys_delete_module+0x22a/0x310
>   do_syscall_64+0x36/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f8d0e0c8a3b
> Code: Bad RIP value.
> RSP: 002b:00007ffe8238f798 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 000055a2c7d9be80 RCX: 00007f8d0e0c8a3b
> RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055a2c7d9bee8
> RBP: 000055a2c7d9be80 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007f8d0e144ac0 R11: 0000000000000206 R12: 000055a2c7d9bee8
> R13: 0000000000000000 R14: 000055a2c7d9bee8 R15: 000055a2c7d9be80
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/53:
>   #0: ffffffff82895880 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x37/0x20f
> 1 lock held by modprobe/1894:
>   #0: ffff8881c5e8c660 (&device->unregistration_lock){+.+.}-{3:3}, at: __ib_unregister_device+0x23/0x100 [ib_core]
>
> =============================================
> INFO: task modprobe:1894 blocked for more than 245 seconds.
>        Not tainted 5.8.0-rc7-next-20200731-dbg+ #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> modprobe        D27624  1894   1081 0x00004000
> Call Trace:
>   __schedule+0x4ee/0x1170
>   schedule+0x7f/0x170
>   schedule_timeout+0x453/0x6f0
>   wait_for_completion+0x126/0x1b0
>   disable_device+0x12a/0x1c0 [ib_core]
>   __ib_unregister_device+0x64/0x100 [ib_core]
>   ib_unregister_driver+0x11c/0x180 [ib_core]
>   rxe_module_exit+0x1e/0x36 [rdma_rxe]
>   __x64_sys_delete_module+0x22a/0x310
>   do_syscall_64+0x36/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f8d0e0c8a3b
> Code: Bad RIP value.
> RSP: 002b:00007ffe8238f798 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 000055a2c7d9be80 RCX: 00007f8d0e0c8a3b
> RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055a2c7d9bee8
> RBP: 000055a2c7d9be80 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007f8d0e144ac0 R11: 0000000000000206 R12: 000055a2c7d9bee8
> R13: 0000000000000000 R14: 000055a2c7d9bee8 R15: 000055a2c7d9be80
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/53:
>   #0: ffffffff82895880 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x37/0x20f
> no locks held by systemd-journal/241.
> 1 lock held by modprobe/1894:
>   #0: ffff8881c5e8c660 (&device->unregistration_lock){+.+.}-{3:3}, at: __ib_unregister_device+0x23/0x100 [ib_core]
>
> =============================================
