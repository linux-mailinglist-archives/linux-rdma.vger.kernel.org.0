Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E571F0AC7
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2020 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgFGKQ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jun 2020 06:16:56 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:6119
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbgFGKQz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Jun 2020 06:16:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsaODUjOoXNaoxCO2u+GuaksN5vtUEQyfp6NDqqJyYT40HI6mE8+weEvWY9VcnUvrEO29NcSmpj1HYdsaQnd3l6xuSunrRvJaWkuaF6tYaxK+/Npf/JOB1DYRtmkJTk9MeLKKZkz+dm2eb/jU1zyXEpPmHuDlsBiXJ3wxY77zYtSbxk+tg4YIQ9g62ZVm364z81Fyi2+OkA0CIwAE57ot8RhH8jO+8ZKU3nY2ntdSCICB6vpmllPKIy5JufjtjfVunGWhS9tcG+uaqJfe02TV/fCP3Ls/vKV7KbVPmoclISh0kB+pSfgEOeaF/1wgktunbI+5Akdcn8IlO6DCWu2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgOeZEUu7PWJlq2hFfv7YI7fJsTqVanWdqHF6/rfwJo=;
 b=n3Hqa5MoaI9VJDuy9EyyGaDfbhjfxufh6OwVjDCI8GGHl1yvYvpn7gS/QQhlviyVghWVGklA4Jp4MGUT4LPv9q7U8FBkqG1Q3L7vzfPL5Th5fF3TQk7OZXOhbkp2DFfcVoJpKRrGM5PfWzURdXrvWtGCklY5ujfW++ZE/WxaJq1iM8TdBmD/yDoOH6rRCmeBLFrnsbeKGHF/k/qbdJNqJBuOCBRNqCO6BPcUxSAZJwlBxI6FN9UU4bNKhKUONlhkIDcMdqOJhk0k9UfGU+06fdB1nYXKcNzqc0h7XruZm8hNpyYrEnaoR4VfygCgVLvx4UUMaPFW2b5w0zBM8xrYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgOeZEUu7PWJlq2hFfv7YI7fJsTqVanWdqHF6/rfwJo=;
 b=n4+K9pQ77w1NxqR4pTXwP27Y2hx9d2HbJgCwTZwTUsubgXDqQdhd8DblCvoKm3wJbWwSu6E0ePQr3clTUC9L4zY24aaqY8hk2dgKBl0bTMHmWwFoEprWNKBWvj3cyLVBE3fmZGHN7P+7sf68TqxymdzAgUfMGDkhTVUDXNWQ+l4=
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6435.eurprd05.prod.outlook.com (2603:10a6:208:146::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sun, 7 Jun
 2020 10:16:51 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 10:16:51 +0000
Subject: Re: iSERT completions hung due to unavailable iscsit tag
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
References: <20200601134637.GA17657@chelsio.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <df0b3262-36ac-bd24-152d-c6a58d81eb21@mellanox.com>
Date:   Sun, 7 Jun 2020 13:16:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200601134637.GA17657@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::27) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM0PR01CA0158.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sun, 7 Jun 2020 10:16:49 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16324c2e-8374-4848-b9bb-08d80acbe498
X-MS-TrafficTypeDiagnostic: AM0PR05MB6435:
X-Microsoft-Antispam-PRVS: <AM0PR05MB64352AECEC3414CB5EF0DA0FB6840@AM0PR05MB6435.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04270EF89C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhUOxwH9jGp5tACBkYCgGeSUnRE3G4Sm62C7UgJJ4KgSPGEETaf8IaZZYWqUAg8D7ScSVNvxgGfNJeoAQ8+Oz1VWbNeSnXkkm4nXt7lYy35nguWyGIkshIpH1mmANFRJbqfzdBxcdR2iXa+Io8rCvc20EwT7kTDS84zwdZpUESYWQn2wQvlxDszVgwReg2BvbRmA6OxVeySAjYxqdfBQDnLlYynJLLoZp7yiOBs5mOufp0gMAZ0KANPZ0w1F1nv/9nvsU4NRfd0ZcQqXfCKHFt82a01/fQIXZjSF4YfRZS62OsXDQb6BEdzAolCYxSGQgN9XxtDz7450A+8D9XlAOy06i5hmqa11E1wFsLOyXB5dGlsomwB64r3t94y1t9jS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(26005)(316002)(2616005)(54906003)(16576012)(5660300002)(186003)(110136005)(52116002)(6666004)(956004)(53546011)(16526019)(6486002)(8936002)(66476007)(66556008)(478600001)(66946007)(8676002)(83380400001)(36756003)(4326008)(31696002)(2906002)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nnc+O5+ijdVjKv0I7jT6Ghv3rmG2eiSj2cyxKMGiKZwPgZHYwbT3RBwQkW6cA/5Pk7E794HRoaM2/v9fwiQIC9RM8q16sspN3VuADSZZo6i3lT6bJwFvyKYXen2WXIbJpcnYmXxfa7zpbL5Cw4Tyi9M0SPzhwE/sEiDygopJkgfcHfZaJVbi+I1bfqwtX1llwk6eDe5wMGkZNaL+hV25nbX1ig6oxaC/LQLbNiZURHk+BzWZVrPclyWWnLXfp9rNYC9pgcRXpwGsIPe8FsWh4mSpsmC2rn2cp777H9e9MyOjnpYK4o6iMZaz4bBNdyICZ5Y1DSsRjEBDi6cN7m6//A5qShQbb4ecdFJQSZZj1SbYIWzpDTw0iV+ez+PTzWxQxFih8x31AEAPeCdvsNU6aFiaHvseVL9F+XWanTQ4pGwf23YnZ57AWsXueIf4mUJVT6nE8Qh41JIUqx5XUfrbxfVvCfXqeUDzFOrv4cp6NzFs45yf5vfvKEyES5DoyLcs
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16324c2e-8374-4848-b9bb-08d80acbe498
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2020 10:16:50.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nebHAp1yR0XGVPWKcJsXR/iUZa2rDNmWCb8IUcQJTM4+hBUvo2kbaB5GGtWPSLLHR1WC3qnK4KNfPN2fdE9/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6435
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/1/2020 4:46 PM, Krishnamraju Eraparaju wrote:
> Hi,
>
> I observe, iscsit_allocate_cmd() process waiting indefinitely for
> 'iscsit tag' to become available.
>
> Here is the scenario:
> - at initiator, run "iozone -i 0 -I -+d -s 100000 -r 16384 -w" in an
>    infinite loop.
> - after few seconds, target fails to obtain 'tag' from
>    sbitmap_queue_get(), while processing ISCSI_CTRL PDU via
> isert_recv_done().
> - then iscsit waits there for tag to become available, by calling
>    schedule() in iscsit_wait_for_tag()
> - and the process never scheduled back again, not sure why.


can you increase the debug level on the target ?

and share the logs in initiator side as well ?

Seems that there is some reconnection that caused by io timeout.

Also, is the drain_qp function of the iw_cxgb4 finished successfully ?


>
> Due to this blockage the whole completion logic at iSER target went to
> grinding halt, causing NOPOUT request timeouts at initator, and below
> hung traces at target. Is this a known issue?
>
> Target:
> [May 7 20:30] iSCSI Login timeout on Network Portal 102.1.1.6:3260
> [May 7 20:33] kworker/dying (2185) used greatest stack depth: 11672
> bytes left
> [  +2.640115] kmemleak: 2 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ +26.031050] INFO: task iscsi_np:8387 blocked for more than 122
> seconds.
> [  +0.000004]       Not tainted 5.7.0-rc2+ #2
> [  +0.000001] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  +0.000001] iscsi_np        D14304  8387      2 0x80004084
> [  +0.000005] Call Trace:
> [  +0.000008]  ? __schedule+0x274/0x5e0
> [  +0.000003]  ? stack_trace_save+0x46/0x70
> [  +0.000002]  schedule+0x45/0xb0
> [  +0.000002]  schedule_timeout+0x1d6/0x290
> [  +0.000001]  wait_for_completion+0x82/0xe0
> [  +0.000007]  iscsi_check_for_session_reinstatement+0x205/0x260
> [iscsi_target_mod]
> [  +0.000004]  iscsi_target_do_login+0xe3/0x5c0 [iscsi_target_mod]
> [  +0.000004]  iscsi_target_start_negotiation+0x4c/0xa0
> [iscsi_target_mod]
> [  +0.000004]  iscsi_target_login_thread+0x86f/0x1000 [iscsi_target_mod]
> [  +0.000003]  kthread+0xf3/0x130
> [  +0.000004]  ? iscsi_target_login_sess_out+0x1f0/0x1f0
> [iscsi_target_mod]
> [  +0.000001]  ? kthread_bind+0x10/0x10
> [  +0.000002]  ret_from_fork+0x35/0x40
> [  +0.000003] INFO: task iscsi_ttx:8863 blocked for more than 122
> seconds.
> [  +0.000001]       Not tainted 5.7.0-rc2+ #2
> [  +0.000000] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  +0.000001] iscsi_ttx       D14384  8863      2 0x80004084
> [  +0.000003] Call Trace:
> [  +0.000002]  ? __schedule+0x274/0x5e0
> [  +0.000004]  ? c4iw_ib_modify_qp+0xf3/0x160 [iw_cxgb4]
> [  +0.000002]  schedule+0x45/0xb0
> [  +0.000002]  schedule_timeout+0x1d6/0x290
> [  +0.000001]  wait_for_completion+0x82/0xe0
> [  +0.000003]  __ib_drain_sq+0x147/0x170
> [  +0.000002]  ? ib_sg_to_pages+0x1a0/0x1a0
> [  +0.000003]  ib_drain_sq+0x6e/0x80
> [  +0.000002]  ib_drain_qp+0x9/0x20
> [  +0.000002]  isert_wait_conn+0x51/0x2c0 [ib_isert]
> [  +0.000004]  iscsit_close_connection+0x14c/0x840 [iscsi_target_mod]
> [  +0.000002]  ? __schedule+0x27c/0x5e0
> [  +0.000004]  iscsit_take_action_for_connection_exit+0x79/0x100
> [iscsi_target_mod]
> [  +0.000003]  iscsi_target_tx_thread+0x160/0x200 [iscsi_target_mod]
> [  +0.000004]  ? wait_woken+0x80/0x80
> [  +0.000002]  kthread+0xf3/0x130
> [  +0.000003]  ? iscsit_thread_get_cpumask+0x80/0x80 [iscsi_target_mod]
> [  +0.000001]  ? kthread_bind+0x10/0x10
> [  +0.000001]  ret_from_fork+0x35/0x40
> [  +0.000003] NMI backtrace for cpu 7
> [  +0.000002] CPU: 7 PID: 493 Comm: khungtaskd Not tainted 5.7.0-rc2+ #2
> [  +0.000001] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.1a
> 10/24/2018
> [  +0.000001] Call Trace:
> [  +0.000003]  dump_stack+0x50/0x6b
> [  +0.000002]  nmi_cpu_backtrace+0x9e/0xb0
> [  +0.000003]  ? lapic_can_unplug_cpu+0x90/0x90
> [  +0.000002]  nmi_trigger_cpumask_backtrace+0x9c/0xf0
> [  +0.000003]  watchdog+0x310/0x4f0
> [  +0.000002]  kthread+0xf3/0x130
> [  +0.000002]  ? hungtask_pm_notify+0x40/0x40
> [  +0.000001]  ? kthread_bind+0x10/0x10
> [  +0.000001]  ret_from_fork+0x35/0x40
> [  +0.000002] Sending NMI from CPU 7 to CPUs 0-6:
> [  +0.000009] NMI backtrace for cpu 0 skipped: idling at
> acpi_processor_ffh_cstate_enter+0x6f/0xc0
> [  +0.000001] NMI backtrace for cpu 4 skipped: idling at
> acpi_processor_ffh_cstate_enter+0x6f/0xc0
> [  +0.000002] NMI backtrace for cpu 1 skipped: idling at
> acpi_processor_ffh_cstate_enter+0x6f/0xc0
> [  +0.000019] NMI backtrace for cpu 2 skipped: idling at
> acpi_processor_ffh_cstate_enter+0x6f/0xc0
> [  +0.000001] NMI backtrace for cpu 6 skipped: idling at
> acpi_processor_ffh_cstate_enter+0x6f/0xc0
> [  +0.000010] NMI backtrace for cpu 5
> [  +0.000000] CPU: 5 PID: 4465 Comm: kworker/5:1H Not tainted 5.7.0-rc2+
> #2
> [  +0.000000] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.1a
> 10/24/2018
> [  +0.000001] Workqueue: ib-comp-wq ib_cq_poll_work
> [  +0.000000] RIP: 0010:__free_pages+0xe/0x60
>
>
> Initiator:
> [ 2002.689250]  connection5:0: ping timeout of 5 secs expired, recv
> timeout 5, last rx 4296659424, last ping 4296664448, now 4296669696
> [ 2002.689275]  connection5:0: detected conn error (1022)
>
>
>
> Thanks,
> Krishna.
