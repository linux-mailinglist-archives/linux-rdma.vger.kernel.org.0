Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BC6FAEF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGVIL2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 04:11:28 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:7175 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGVIL1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 04:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563783086; x=1595319086;
  h=from:subject:to:cc:message-id:date:mime-version:
   content-transfer-encoding;
  bh=XXbfdfAA8FTsfyjy3yaDW8yPh5UBYfozoLTvEKy6qTk=;
  b=smXS7gxSkjnsCf4ajR2grIXnOPjfwCXGg/mBpAUp6cVct6gbuc2ZOzQx
   7EXuQMgWjg7F8Aa+LwKVj5nyTvmtjKU5NiLIcj7NDPyMkDqYTjaHCRJ3s
   32LIn8TUkd3XYr8Wy6SkJdGxWSwgQlmBH0aotplp6IrwVrPKhoMU2x/xy
   A=;
X-IronPort-AV: E=Sophos;i="5.64,294,1559520000"; 
   d="scan'208";a="775601145"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 22 Jul 2019 08:11:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id C1F26A27D3;
        Mon, 22 Jul 2019 08:11:01 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 08:11:00 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.30) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Jul 2019 08:10:57 +0000
From:   Gal Pressman <galpress@amazon.com>
Subject: rdma-core device memory leak
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Message-ID: <9c250b8c-df24-7491-deda-ede0b72fd689@amazon.com>
Date:   Mon, 22 Jul 2019 11:10:51 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.30]
X-ClientProxiedBy: EX13D01UWB003.ant.amazon.com (10.43.161.94) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

I'm seeing memory leaks when running tests with valgrind memcheck tool [1]. It
seems like it's caused due to verbs_device refcount never reaching zero.

Last related commit is 8125fdeb69bb ("verbs: Avoid ibv_device memory leak"),
which seems like it should prevent this issue - but I'm not sure it covers all
cases.

When calling ibv_get_device_list, try_driver will eventually get called and set
the device refcount to one. The refcount for each device will be increased when
iterating the devices list, and on each verbs_init_context call.

In the free flow, the refcount is decreased on verbs_uninit_context and when
iterating the devices list - which brings the refcount back to one, as initially
set by try_driver (hence uninit_device isn't called).

Is there a reason for initializing refcount to one instead of zero? According to
the cited commit the reference count should be decreased when the device no
longer exists in the sysfs, but the device isn't necessarily removed from the sysfs.

[1]
==35758== HEAP SUMMARY:
==35758==     in use at exit: 27,777 bytes in 88 blocks
==35758==   total heap usage: 295 allocs, 207 frees, 141,751 bytes allocated
==35758==
==35758== 728 bytes in 1 blocks are possibly lost in loss record 3 of 8
==35758==    at 0x4C2A935: calloc (vg_replace_malloc.c:711)
==35758==    by 0x6FF263F: efa_device_alloc (efa.c:161)
==35758==    by 0x4E42B67: try_driver (init.c:365)
==35758==    by 0x4E42DBE: try_drivers (init.c:429)
==35758==    by 0x4E42DBE: try_all_drivers (init.c:519)
==35758==    by 0x4E43798: ibverbs_get_device_list (init.c:584)
==35758==    by 0x4E40870: ibv_get_device_list@@IBVERBS_1.1 (device.c:74)
==35758==    by 0x400691: main (device_list.c:46)
==35758==
==35758== 1,048 bytes in 1 blocks are possibly lost in loss record 6 of 8
==35758==    at 0x4C2A935: calloc (vg_replace_malloc.c:711)
==35758==    by 0x4E425C5: find_sysfs_devs_nl_cb (ibdev_nl.c:156)
==35758==    by 0x5697E4B: nl_recvmsgs_report (in /usr/lib64/libnl-3.so.200.23.0)
==35758==    by 0x56982B8: nl_recvmsgs (in /usr/lib64/libnl-3.so.200.23.0)
==35758==    by 0x4E4734F: rdmanl_get_devices (rdma_nl.c:96)
==35758==    by 0x4E42726: find_sysfs_devs_nl (ibdev_nl.c:205)
==35758==    by 0x4E43501: ibverbs_get_device_list (init.c:538)
==35758==    by 0x4E40870: ibv_get_device_list@@IBVERBS_1.1 (device.c:74)
==35758==    by 0x400691: main (device_list.c:46)

Thanks,
Gal
