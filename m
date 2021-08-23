Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD93F4F81
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhHWRbZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 13:31:25 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:52008 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhHWRbY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 13:31:24 -0400
Received: by mail-pj1-f50.google.com with SMTP id oa17so12451383pjb.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 10:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WJuGzwXjFEiQ4dcxW4rj4UGgL5Zx4qMrIRFlHZrbeJk=;
        b=F2zZ7sTcDMpyfPcsgvBj/IkAqkQFp/hRSmB7/ts6WL2iDO60Ft9I05/iNgNKeLRwbC
         o2srOlFpmdu9HB70tgaMrM8euGZT4q1VDrrMlAqhs2onWilz9Aa28djkTcQAjuFfFWO/
         hUWpglirlxl2DD6Kh1W24S4cn19RXfMw/3gwxdqWgXRRIgZMfYH4BXrR+zu+WFVvrJF1
         2I+zxFw7Qt6LGcmgQeba3jtkNu+TineZvVWFTmxNGm1hcKzSXjEsZnv4zxqqCu8ghOdt
         7Ja3a4VaQIMDgIMqPny5lMMtdImiXQ6cF1zOI/uWzFUdXtIXiS4JkKM5OFzzv4YlEOd4
         nLaQ==
X-Gm-Message-State: AOAM532aDIFEuFstCt8FZn8zBMr6oPFTgc7gkj9n6p7Lbrng0bgKUp59
        mL+oop2d2vC8pdWEfHrssNF1YAq30mM=
X-Google-Smtp-Source: ABdhPJxxpojJYRUQj65vBembfFg4sbzFrz4fq0YDyDhcbb7+XFobSlhnqHtAwwDpC65j0MADCZuNoQ==
X-Received: by 2002:a17:902:70c2:b029:12d:4d0b:6f22 with SMTP id l2-20020a17090270c2b029012d4d0b6f22mr29444597plt.32.1629739841137;
        Mon, 23 Aug 2021 10:30:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e98a:ca44:7012:ad8e])
        by smtp.gmail.com with ESMTPSA id m2sm16645293pfo.45.2021.08.23.10.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:30:40 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
From:   Bart Van Assche <bvanassche@acm.org>
Subject: v5.14-rc5: KASAN complains about use-after-free in __ib_process_cq()
Message-ID: <eac61295-05d2-98f2-eb32-280ffec8269f@acm.org>
Date:   Mon, 23 Aug 2021 10:30:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

If I run blktests against Jens' for-next branch (5026771bd46e ("Merge branch
'for-5.15/io_uring-late' into for-next")) then most SRP tests time out.
Additionally, a KASAN use-after-free complaint is sometimes reported for
__ib_process_cq(). With commit 4b5f4d3fb408 ("RDMA: Split the alloc_hw_stats()
ops to port and device variants") however all SRP tests pass and no KASAN
complaints are reported. There are no changes in the SRP drivers between these
two commits. This makes me wonder whether a regression has been introduced in
the RDMA core? I have not yet run a full bisect - this is something I am
working on. Please note that I may be hitting multiple unrelated issues -
there is no evidence so far that the SRP test timeouts are related to changes
in the RDMA code. These could also be caused by changes in the block layer.

Thanks,

Bart.

root[4317]: run blktests srp/006
[ ... ]
kernel: ==================================================================
kernel: BUG: KASAN: use-after-free in __ib_process_cq+0x118/0x3d0 [ib_core]
kernel: Read of size 8 at addr ffff8881e02e9d20 by task kworker/1:27/3431
kernel:
kernel: CPU: 1 PID: 3431 Comm: kworker/1:27 Tainted: G            E     5.14.0-rc7-dbg+ #27
kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
kernel: Workqueue: srp_remove srp_remove_work [ib_srp]
kernel: Call Trace:
kernel:  show_stack+0x52/0x58
kernel:  dump_stack_lvl+0x49/0x5e
kernel:  print_address_description.constprop.0+0x24/0x150
kernel:  kasan_report.cold+0x82/0xdb
kernel:  __asan_load8+0x69/0x90
kernel:  __ib_process_cq+0x118/0x3d0 [ib_core]
kernel:  ib_process_cq_direct+0x7d/0xa0 [ib_core]
kernel:  srp_free_ch_ib+0x191/0x570 [ib_srp]
kernel:  srp_remove_work+0x174/0x2d0 [ib_srp]
kernel:  process_one_work+0x56a/0xab0
kernel:  worker_thread+0x2e7/0x700
kernel:  kthread+0x1f6/0x220
kernel:  ret_from_fork+0x1f/0x30
kernel:
kernel: The buggy address belongs to the page:
kernel: page:000000003ae07f35 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e02e9
kernel: flags: 0x1000000000000000(node=0|zone=2)
kernel: raw: 1000000000000000 ffffea000780bc08 ffffea000780ba08 0000000000000000
kernel: raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
kernel: page dumped because: kasan: bad access detected
kernel:
kernel: Memory state around the buggy address:
kernel:  ffff8881e02e9c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kernel:  ffff8881e02e9c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kernel: >ffff8881e02e9d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kernel:                                ^
kernel:  ffff8881e02e9d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kernel:  ffff8881e02e9e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kernel: ==================================================================
kernel: Disabling lock debugging due to kernel taint
