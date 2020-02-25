Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4816C1A6
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 14:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgBYNGH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 08:06:07 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:18818
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729193AbgBYNGH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 08:06:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAlO59DUX4NIfX5/cwaL25KSspgO+LsgYZqPMaGIRYVTCd5MR30BF/fL5gpIUEWal7VcDjY6qqB2AOxitao1DqmmpCsi9XQv/sJXYCfrJGJB+SfKs/juLrckYJ9iM6e78idrzLIXFThMvgpLkFrVKkVIllYemAw8n2SHzs3SWJ/8Q+sT4gjYB9WBy4YV69TaWuyfAQ6eUZZIiP2oOAbwIZxOj5DhZcM4k+GqQ3Bx1j8Y8S4J/VwDbaR5SpZ/fZHNHz33c42rWsd5pu2FifLMLOh4Kg25SwgtWTQt3tmN0gh9yHZJONIMZHP/tWyDfGiBt+A+fOe0y0QiDlPaP0SvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj8ndnTu645hZs+SBF3ZeWVdYJ8ROmjoQPB6dg7/XGw=;
 b=h0NLJpdiDymmPKMfY0Fd1B0znSk+kMN54NsmhZbGAop+gDwP/oKhffxdHjfOwk7jZiuEF9DOeS9k7YJE7oRHOGelzJkb1433P50lYFcBek8oBC5qOJvhXziLhmPYYz175dgpFKOo67s3w1veUGwu9QQqzbI+6Ymn2TiQZUw9E04cS8CiqvRfst6GZrNZnH73MoNWJOG7JaB2kXGFRshu3gSromnPWBBlMfYJhJrQRGRtImEyqAOUCnbRT4Wt2vnftwGrfzaHaxjNRy/HXCTUZfITpSPwTgEzHwwvf6m3K9IcXP0v1CuiQU0zT6Ji4exruSlp4oeqw7KgdM6i3F4jJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj8ndnTu645hZs+SBF3ZeWVdYJ8ROmjoQPB6dg7/XGw=;
 b=gRUDS13RtZJcMJjGMje6Xb9bzti6MpEoCkK1AIjn6PCGw+wCQrhWcakuYe/etQCn4y/9lSwEcnVcBRP7fOjAlRXhm9VLcMYM+aAfy5oldnAZ2VxPkTZC5kIWDKz74W1PK5CPKhxBhCWNS6PxB7eJCX1njocEuEJhqO/4BL6Aajg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maorg@mellanox.com; 
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (20.178.117.153) by
 AM0PR05MB6369.eurprd05.prod.outlook.com (20.179.36.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Tue, 25 Feb 2020 13:06:03 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::a556:1de2:ef6c:9192]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::a556:1de2:ef6c:9192%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:06:03 +0000
Subject: Re: a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened
 in 5.4.21 but not in 5.4.20
To:     Wang Yugui <wangyugui@e16-tech.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <FD4E1E87-28CF-4F4C-BBF4-2BD945142A14@oracle.com>
 <20200220140547.GE209126@unreal> <20200221002631.97A1.409509F4@e16-tech.com>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <bc3ce212-9fde-0489-e7ac-8cb8be55c015@mellanox.com>
Date:   Tue, 25 Feb 2020 15:05:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200221002631.97A1.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To AM0PR05MB5873.eurprd05.prod.outlook.com
 (2603:10a6:208:125::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.80.3.21] (193.47.165.251) by ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 13:06:02 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 757de29c-e416-47f7-9cbe-08d7b9f3778c
X-MS-TrafficTypeDiagnostic: AM0PR05MB6369:
X-Microsoft-Antispam-PRVS: <AM0PR05MB63695583DE943FB33BF50553D3ED0@AM0PR05MB6369.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(6666004)(110136005)(36756003)(66556008)(5660300002)(316002)(478600001)(16576012)(66946007)(53546011)(66476007)(2906002)(54906003)(52116002)(81166006)(6486002)(186003)(31686004)(8936002)(966005)(31696002)(86362001)(2616005)(16526019)(956004)(81156014)(8676002)(4326008)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6369;H:AM0PR05MB5873.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CwIBDDmCbNySoc57SY71y2owO/PkKHIFemxVhFF39oxsbpzbYmAJb/iZlS2MSHjSo/GpRE50OMgeYsHJxqvP1oazCnpzNUQgjkjwF36i6bjMMCioAbEH2O66RPRdxQa6CLUpqaRst09bqkWsQ+qJIrozGKOzc/J4Ea7LrCxCLRvY17omSP8CkIUcL4bnJHNeVxu9CMRsBh5FHbmSDimHad8HrBQlm/pRRLBxB7Dd2tuRp5rDHqWC0A2pqhPlfjRd2gIBTug53/RGNyMXjLCzd8Ddla6jjnC/hdRkerHHPZcW6Cb/5On/rZ0ISbsiN5tqmHXFM/eCvi4hfWpI0eV+BYJ34HZL9aoQkd5rN8YnjCwiFDUfeCQBAVXfd+X51/eFuhHRL5tVEIBED4/JYfpQB5IS9BCYW9bVnpsw7Q8vLQvaflPS+EfkGT9MocCbk3cC6Lxor9rt+5L3smxpBiUAoqhb/OmIcopqMl1OHxSmovjppsoJDP1CQixHMPlvPUlpi0WICMBQHG91unTol1jdA==
X-MS-Exchange-AntiSpam-MessageData: 9B64MhYUN43XhdaQFDmIlQz2KY69lavheNrNxikTAm3iVHgYgPfrT7LLZJD8AoS7EYmc9H6ZdhrgMeytYmNg6B3en15CYYrtLz9B3S0zyajmX9IzHl1qHR0mHDXDr5h8Nn3nleEDe6ZR/0Kpo6fU9Q==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757de29c-e416-47f7-9cbe-08d7b9f3778c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 13:06:03.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMwov5Q+CjtYgzjm1Naz/Lk0jzN9zx5oLPY4O2ip2gFRzK0g4o9cx5YFLpTxdBGX/gV6YsqxtJeWAAjq8D+Ygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6369
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/20/2020 6:26 PM, Wang Yugui wrote:
> Hi, Leon, Chuck
>
> It is still broken even with the hotfix(https://patchwork.kernel.org/patch/11387567/) for 5.4.21.

Hi Wang,

How can I reproduce it ?

Can you please try with the below diff?

iff --git a/drivers/infiniband/core/security.c 
b/drivers/infiniband/core/security.c
index b9a36ea244d4..2d5608315dc8 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -340,11 +340,15 @@ static struct ib_ports_pkeys *get_new_pps(const 
struct ib_qp *qp,
                 return NULL;

         if (qp_attr_mask & IB_QP_PORT)
-           new_pps->main.port_num =
-                   (qp_pps) ? qp_pps->main.port_num : qp_attr->port_num;
+         new_pps->main.port_num = qp_attr->port_num;
+ else if (qp_pps)
+         new_pps->main.port_num = qp_pps->main.port_num;
+
         if (qp_attr_mask & IB_QP_PKEY_INDEX)
-           new_pps->main.pkey_index = (qp_pps) ? qp_pps->main.pkey_index :
- qp_attr->pkey_index;
+         new_pps->main.pkey_index = qp_attr->pkey_index;
+ else if (qp_pps)
+         new_pps->main.pkey_index = qp_pps->main.pkey_index;
+
         if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & 
IB_QP_PORT))
                 new_pps->main.state = IB_PORT_PKEY_VALID;

>
> the call stack is almost the same.
>
> Feb 20 23:49:53 T630 kernel: Call Trace:
> Feb 20 23:49:53 T630 kernel: port_pkey_list_insert+0x30/0x1a0 [ib_core]
> Feb 20 23:49:53 T630 kernel: ? kmem_cache_alloc_trace+0x219/0x230
> Feb 20 23:49:53 T630 kernel: ib_security_modify_qp+0x244/0x3b0 [ib_core]
> Feb 20 23:49:53 T630 kernel: _ib_modify_qp+0x1c0/0x3c0 [ib_core]
> Feb 20 23:49:53 T630 kernel: ? dma_pool_free+0x24/0xc0
> Feb 20 23:49:53 T630 kernel: ipoib_init_qp+0x77/0x190 [ib_ipoib]
> Feb 20 23:49:53 T630 kernel: ? __mlx4_ib_query_pkey+0xe7/0x110 [mlx4_ib]
> Feb 20 23:49:53 T630 kernel: ? ib_find_pkey+0x98/0xe0 [ib_core]
> Feb 20 23:49:53 T630 kernel: ipoib_ib_dev_open_default+0x1a/0x180 [ib_ipoib]
> Feb 20 23:49:53 T630 kernel: ipoib_ib_dev_open+0x66/0xa0 [ib_ipoib]
> Feb 20 23:49:53 T630 kernel: ipoib_open+0x44/0x110 [ib_ipoib]
> Feb 20 23:49:53 T630 kernel: __dev_open+0xcd/0x160
> Feb 20 23:49:53 T630 kernel: __dev_change_flags+0x1ad/0x220
> Feb 20 23:49:53 T630 kernel: ? __dev_notify_flags+0x95/0xf0
> Feb 20 23:49:53 T630 kernel: dev_change_flags+0x21/0x60
> Feb 20 23:49:53 T630 kernel: do_setlink+0x320/0xf00
> Feb 20 23:49:53 T630 kernel: ? __nla_validate_parse+0x51/0x840
> Feb 20 23:49:53 T630 kernel: ? xas_load+0x8/0x80
> Feb 20 23:49:53 T630 kernel: ? __update_load_avg_cfs_rq+0x1d5/0x2c0
> Feb 20 23:49:53 T630 kernel: ? cpumask_next+0x17/0x20
> Feb 20 23:49:53 T630 kernel: ? __snmp6_fill_stats64.isra.56+0x6b/0x110
> Feb 20 23:49:53 T630 kernel: ? __nla_validate_parse+0x51/0x840
> Feb 20 23:49:53 T630 kernel: __rtnl_newlink+0x53d/0x890
> Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
> Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
> Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
> Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
> Feb 20 23:49:53 T630 kernel: ? nla_put+0x2f/0x40
> Feb 20 23:49:53 T630 kernel: ? __nla_reserve+0x38/0x50
> Feb 20 23:49:53 T630 kernel: ? __nla_put+0xc/0x20
> Feb 20 23:49:53 T630 kernel: ? nla_put+0x2f/0x40
> Feb 20 23:49:53 T630 kernel: ? rt6_fill_node+0x2d4/0x850
> Feb 20 23:49:53 T630 kernel: ? _cond_resched+0x15/0x30
> Feb 20 23:49:53 T630 kernel: ? kmem_cache_alloc_trace+0x1c9/0x230
> Feb 20 23:49:53 T630 kernel: rtnl_newlink+0x43/0x60
> Feb 20 23:49:53 T630 kernel: rtnetlink_rcv_msg+0x2b1/0x360
> Feb 20 23:49:53 T630 kernel: ? __kmalloc_node_track_caller+0x241/0x300
> Feb 20 23:49:53 T630 kernel: ? _cond_resched+0x15/0x30
> Feb 20 23:49:53 T630 kernel: ? rtnl_calcit.isra.32+0x110/0x110
> Feb 20 23:49:53 T630 kernel: netlink_rcv_skb+0x49/0x110
> Feb 20 23:49:53 T630 kernel: netlink_unicast+0x191/0x220
> Feb 20 23:49:53 T630 kernel: netlink_sendmsg+0x21d/0x3f0
> Feb 20 23:49:53 T630 kernel: sock_sendmsg+0x5b/0x60
> Feb 20 23:49:53 T630 kernel: ____sys_sendmsg+0x1eb/0x260
> Feb 20 23:49:53 T630 kernel: ? copy_msghdr_from_user+0xdb/0x160
> Feb 20 23:49:53 T630 kernel: ___sys_sendmsg+0x7c/0xc0
> Feb 20 23:49:53 T630 kernel: ? do_filp_open+0xa7/0x100
> Feb 20 23:49:53 T630 kernel: ? netdev_run_todo+0x5e/0x290
> Feb 20 23:49:53 T630 kernel: ? list_lru_add+0xb7/0x1d0
> Feb 20 23:49:53 T630 kernel: __sys_sendmsg+0x57/0xa0
> Feb 20 23:49:53 T630 kernel: do_syscall_64+0x5b/0x180
> Feb 20 23:49:53 T630 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
> This card have 2 port, and port 1 is set as InfiniBand, port 2
> is set as Ethernet.
>
> # ibstat
> CA 'mlx4_0'
>          CA type: MT4099
>          Number of ports: 2
>          Firmware version: 2.42.5000
>          Hardware version: 1
>          Node GUID: 0xe41d2d03007b4080
>          System image GUID: 0xe41d2d03007b4083
>          Port 1:
>                  State: Down
>                  Physical state: Polling
>                  Rate: 10
>                  Base lid: 0
>                  LMC: 0
>                  SM lid: 0
>                  Capability mask: 0x02594868
>                  Port GUID: 0xe41d2d03007b4081
>                  Link layer: InfiniBand
>          Port 2:
>                  State: Down
>                  Physical state: Disabled
>                  Rate: 40
>                  Base lid: 0
>                  LMC: 0
>                  SM lid: 0
>                  Capability mask: 0x00010000
>                  Port GUID: 0xe61d2dfffe7b4082
>                  Link layer: Ethernet
>
>
> Best Regards
> 王玉贵
> 2020/02/21
>
>> On Thu, Feb 20, 2020 at 08:57:29AM -0500, Chuck Lever wrote:
>>> Hello!
>>>
>>> Thanks for your bug report.
>>>
>>>
>>>> On Feb 19, 2020, at 10:22 PM, Wang Yugui <wangyugui@e16-tech.com> wrote:
>>>>
>>>> Hi, chuck.lever
>>>>
>>>> a bug(BUG: kernel NULL pointer dereference) of ib or mlx happened in 5.4.21 but not in 5.4.20.
>>>>
>>>> maybe some releationship to xprtrdma-fix-dma-scatter-gather-list-mapping-imbalance.patch
>>> I don't see an obvious connection to fix-dma-scatter-gather-list-mapping-imbalance.
>>> The backtrace below is through IPoIB code paths. Those have nothing to do with
>>> NFS/RDMA, which is the only ULP code that is changed by my commit.
>>>
>>>
>>>> maybe the info is useful.
>>> I'm copying linux-rdma for a bigger set of eyeballs.
>>>
>>> My knee-jerk recommendation is that if you have a reliable reproducer, try "git bisect"
>>> between .20 and .21 to nail down a specific commit where the BUG starts to occur.
>> No need to bisect, it is me who broke.
>> The fix is already accepted, but not yet merged.
>> https://patchwork.kernel.org/patch/11387567/
>>
>> Thanks
> --------------------------------------
> 北京京垓科技有限公司
> 王玉贵	wangyugui@e16-tech.com
> 电话：+86-136-71123776
>
