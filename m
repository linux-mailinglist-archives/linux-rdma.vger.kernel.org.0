Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8570327
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfGVPKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:10:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:60229 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfGVPKR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563808216; x=1595344216;
  h=from:subject:to:cc:message-id:date:mime-version:
   content-transfer-encoding;
  bh=Zo2Igarj1GAzEmOaCGbUf/leup9wmlSiWH9NxpMdJvA=;
  b=BE/tX7QJmNdd5PakYU0e5lXMPf4yLS3+AT+rHKs1byVQ1QPoONOZVZN3
   2IkOr/DB5svCKz7Jmkxrt6oIpxI9uzcPHxRSsVxbPB8NYJdKCIIGKwrq7
   zSWeklCqmKtHW1Jskpk3vTQitu/bvXCFk8MfASBU+i2G/2vZHP9g7vBge
   8=;
X-IronPort-AV: E=Sophos;i="5.64,295,1559520000"; 
   d="scan'208";a="686984879"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Jul 2019 15:10:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id EE920C13AC;
        Mon, 22 Jul 2019 15:10:09 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 15:10:09 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.25) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 15:10:06 +0000
From:   Gal Pressman <galpress@amazon.com>
Subject: BUG: KASAN: null-ptr-deref in
 rdma_counter_get_hwstat_value+0x19d/0x260 in for-next branch
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Mark Zhang" <markz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>
Message-ID: <137e1a30-1c78-27f7-2466-070867b97256@amazon.com>
Date:   Mon, 22 Jul 2019 18:10:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.25]
X-ClientProxiedBy: EX13D08UWC004.ant.amazon.com (10.43.162.90) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I pulled the latest for-next branch (5.3-rc1) which includes the new stats stuff
and applied a patch to enable EFA stats [1], and I'm getting the following trace
[2]. The EFA patch isn't merged yet so it could cause some extra noise, but this
did not happen before the core statistics patches were merged.

From a quick look it seems that 'port_counter->hstats' is only initialized for
ports 1..num_ports (i.e not initialized for port 0, device stats) in
rdma_counter_init rdma_for_each_port loop.

As a result, rdma_counter_get_hwstat_value hits a NULL pointer dereference when
querying device statistics as it tries to access an uninitialized hstats field in:
sum += port_counter->hstats->value[index];

I'm thinking of adding a check similar to the one that exists in
counter_history_stat_update and return 0 in case of !port_counter->hstats.
What do you guys think?

[1] https://patchwork.kernel.org/patch/11034123/

[2] cat /sys/class/infiniband/efa_0/hw_counters/completed_cmds
[   82.519451] ==================================================================
[   82.522782] BUG: KASAN: null-ptr-deref in
rdma_counter_get_hwstat_value+0x19d/0x260 [ib_core]
[   82.526374] Read of size 8 at addr 00000000000000d0 by task cat/14604

[   82.530133] CPU: 44 PID: 14604 Comm: cat Tainted: G            E
5.3.0-rc1-dirty #101
[   82.533613] Hardware name: Amazon EC2 c5n.18xlarge/, BIOS 1.0 10/16/2017
[   82.536505] Call Trace:
[   82.537837]  dump_stack+0x91/0xeb
[   82.539487]  __kasan_report+0x1be/0x220
[   82.541396]  ? rdma_counter_get_hwstat_value+0x19d/0x260 [ib_core]
[   82.544206]  ? rdma_counter_get_hwstat_value+0x19d/0x260 [ib_core]
[   82.546965]  kasan_report+0xe/0x20
[   82.548659]  rdma_counter_get_hwstat_value+0x19d/0x260 [ib_core]
[   82.552753]  ? rdma_counter_query_stats+0x70/0x70 [ib_core]
[   82.556629]  ? lock_acquire+0x100/0x260
[   82.559905]  show_hw_stats+0xdc/0x1d0 [ib_core]
[   82.563420]  dev_attr_show+0x34/0x70
[   82.566588]  sysfs_kf_seq_show+0x12b/0x1c0
[   82.569917]  ? device_match_of_node+0x30/0x30
[   82.573355]  seq_read+0x171/0x6d0
[   82.576415]  vfs_read+0xc9/0x1e0
[   82.579409]  ksys_read+0xca/0x180
[   82.582443]  ? kernel_write+0xb0/0xb0
[   82.585618]  ? trace_hardirqs_on_thunk+0x1a/0x20
[   82.589119]  ? mark_held_locks+0x25/0xc0
[   82.592387]  ? do_syscall_64+0x14/0x2b0
[   82.595648]  do_syscall_64+0x68/0x2b0
[   82.598886]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   82.602612] RIP: 0033:0x7fa96127afe0
[   82.605800] Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 17 bf 09 00 e8
52 8a 02 00 66 90 83 3d bd cf 2d 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0
ff ff 73 31 c3 48 83 ec 08 e8 4e cc 01 00 48 89 04 24
[   82.617434] RSP: 002b:00007ffc04ceea48 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[   82.623423] RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007fa96127afe0
[   82.629319] RDX: 0000000000010000 RSI: 0000000000ebf000 RDI: 0000000000000003
[   82.635142] RBP: 0000000000ebf000 R08: 0000000000000000 R09: 0000000000010fff
[   82.641030] R10: 00007ffc04cede20 R11: 0000000000000246 R12: 0000000000ebf000
[   82.646915] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000fff
[   82.652804] ==================================================================

Thanks
