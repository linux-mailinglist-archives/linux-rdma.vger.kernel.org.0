Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A44A464A36
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Dec 2021 09:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbhLAI6s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Dec 2021 03:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242281AbhLAI6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Dec 2021 03:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638348923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=8kZA9cn60iIqU6R/AMqIZX47RE3fju8PqCMO9rgpB08=;
        b=bIIim1QSk8DJY0rQnd6TobBuza2F8xu78SxjNEhrEpm97mCEP1vEnTQeojs9PbX36n4IR5
        bPHtnh864x1bavNbdBplhPKn5SbfwHtX87V2vjHE1gpVpazTtCuSgAq1Os7V0cMqKYGASe
        +xLVqCWWttRwyIbqEY41JUSOaQbrzX4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-IADMy8tROU-ekoY2LjIU0Q-1; Wed, 01 Dec 2021 03:55:22 -0500
X-MC-Unique: IADMy8tROU-ekoY2LjIU0Q-1
Received: by mail-yb1-f198.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so34758903ybt.15
        for <linux-rdma@vger.kernel.org>; Wed, 01 Dec 2021 00:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8kZA9cn60iIqU6R/AMqIZX47RE3fju8PqCMO9rgpB08=;
        b=j6i5kZx2HHoR4fF0Z1HF+oDnwOJUS1zLb8DzlBHdxo/4byN39shUaxpLfaq3IJbYxn
         CpebdD+ATH/ySrCxRPT44OQr5Usx3g38cRcgsXjmn820jRShaiSsjp0E2eWgIY4kQse9
         +Nv6VcBCIis+HFEzEpcSxgwkIfMoj9CqqX9yiggT4Z2+HU5utrrFG2w+4NIRXe7BnVZM
         7cn+RE3ixUM0ClFfX5bjespDzxXkWWaZ8sGwRVRA8t/m5YpLOP0jPpzXZTdYUci/KUWo
         4TWS0gEmcYMmRllscEbq3zd7LT7nWc03szQg8vKykvqpkR6egzmhj6UAiyBMuz8T30Q3
         qOTA==
X-Gm-Message-State: AOAM5319i7U8e2y7bk7sBVvXz7vxybj3QdbJ6kfAfcNVWTz/roKmAp4q
        a7NHmu8m60k5EmrxxhNIBThawgDeUVNvclF3hZnLTKUsZrmuabWGb25crVDXKu27ZF86xj+4K1/
        PWnIuteF6hUhFBHDa9DdZlwPYLbarxT84q8bFXA==
X-Received: by 2002:a25:d7c3:: with SMTP id o186mr5591445ybg.104.1638348921973;
        Wed, 01 Dec 2021 00:55:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcVGpYoxO4wpfpEafL8JJEZLWszh9WXhBZygVzlWOStk/bpqPCHJs+9CRvrcjgVK+TNafPndKyzjxU+I/EJ84=
X-Received: by 2002:a25:d7c3:: with SMTP id o186mr5591411ybg.104.1638348921612;
 Wed, 01 Dec 2021 00:55:21 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 1 Dec 2021 16:55:10 +0800
Message-ID: <CAHj4cs9_ZuMnrP9=E-jP7mBZ87Et1ne0VTfQiQGq284XrbbOnw@mail.gmail.com>
Subject: [bug report] blktests srp/011 hang at "ib_srpt srpt_disconnect_ch_sync:still
 waiting ..."
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello
I found blktest srp/011 hang on latest 5.16.0-rc3+, and from dmesg I
can see kernel repeat printing "ib_srpt srpt_disconnect_ch_sync:still
waiting ...".
Pls help check it and let me know if you need any info/testing for it, thanks.

[root@gigabyte-r120-11 blktests]# use_siw=1 ./check srp/011 -------------> hang
srp/011 (Block I/O on top of multipath concurrently with logout and
login) [passed]
    runtime  52.731s  ...  61.351s

dmesg:
[  101.614632] run blktests srp/011 at 2021-12-01 03:43:24
[  102.493106] alua: device handler registered
[  102.519148] emc: device handler registered
[  102.540806] rdac: device handler registered
[  102.608792] null_blk: module loaded
[  103.031132] SoftiWARP attached
[  103.067829] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.073399] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.079038] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.093348] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.111956] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.130870] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.141017] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.146585] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.152374] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.166691] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.172623] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.191728] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.197641] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.380984] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
0000000068763489
[  103.389445] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  103.398577] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[  103.405018] scsi host4: scsi_debug: version 0190 [20200710]
[  103.405018]   dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
[  103.417664] scsi 4:0:0:0: Direct-Access     Linux    scsi_debug
  0190 PQ: 0 ANSI: 7
[  103.426302] sd 4:0:0:0: Power-on or device reset occurred
[  103.426368] sd 4:0:0:0: Attached scsi generic sg1 type 0
[  103.431800] sd 4:0:0:0: [sdb] Enabling DIF Type 3 protection
[  103.442794] sd 4:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  103.450168] sd 4:0:0:0: [sdb] Write Protect is off
[  103.454958] sd 4:0:0:0: [sdb] Mode Sense: 73 00 10 08
[  103.455020] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  103.463665] sd 4:0:0:0: [sdb] Optimal transfer size 524288 bytes
[  103.567989] sd 4:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC protection
[  103.574602] sd 4:0:0:0: [sdb] DIF application tag size 6
[  103.757781] sd 4:0:0:0: [sdb] Attached SCSI disk
[  104.620435] enP2p1s0v1 speed is unknown, defaulting to 1000
[  104.805722] enP2p1s0v4 speed is unknown, defaulting to 1000
[  105.168234] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  105.313416] ib_srpt:srpt_add_one: ib_srpt device = 0000000043289393
[  105.313438] ib_srpt:srpt_use_srq: ib_srpt
srpt_use_srq(enP2p1s0v0_siw): use_srq = 0; ret[  101.614632] run
blktests srp/011 at 2021-12-01 03:43:24
[  102.493106] alua: device handler registered
[  102.519148] emc: device handler registered
[  102.540806] rdac: device handler registered
[  102.608792] null_blk: module loaded
[  103.031132] SoftiWARP attached
[  103.067829] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.073399] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.079038] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.093348] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.111956] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.130870] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.141017] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.146585] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.152374] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.166691] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.172623] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.191728] enP2p1s0v1 speed is unknown, defaulting to 1000
[  103.197641] enP2p1s0v4 speed is unknown, defaulting to 1000
[  103.380984] scsi_debug:sdebug_add_store: dif_storep 524288 bytes @
0000000068763489
[  103.389445] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
[  103.398577] scsi_debug:sdebug_driver_probe: host protection DIF3 DIX3
[  103.405018] scsi host4: scsi_debug: version 0190 [20200710]
[  103.405018]   dev_size_mb=32, opts=0x0, submit_queues=1, statistics=0
[  103.417664] scsi 4:0:0:0: Direct-Access     Linux    scsi_debug
  0190 PQ: 0 ANSI: 7
[  103.426302] sd 4:0:0:0: Power-on or device reset occurred
[  103.426368] sd 4:0:0:0: Attached scsi generic sg1 type 0
[  103.431800] sd 4:0:0:0: [sdb] Enabling DIF Type 3 protection
[  103.442794] sd 4:0:0:0: [sdb] 65536 512-byte logical blocks: (33.6
MB/32.0 MiB)
[  103.450168] sd 4:0:0:0: [sdb] Write Protect is off
[  103.454958] sd 4:0:0:0: [sdb] Mode Sense: 73 00 10 08
[  103.455020] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[  103.463665] sd 4:0:0:0: [sdb] Optimal transfer size 524288 bytes
[  103.567989] sd 4:0:0:0: [sdb] Enabling DIX T10-DIF-TYPE3-CRC protection
[  103.574602] sd 4:0:0:0: [sdb] DIF application tag size 6
[  103.757781] sd 4:0:0:0: [sdb] Attached SCSI disk
[  104.620435] enP2p1s0v1 speed is unknown, defaulting to 1000
[  104.805722] enP2p1s0v4 speed is unknown, defaulting to 1000
[  105.168234] Rounding down aligned max_sectors from 4294967295 to 4294967288
[  105.313416] ib_srpt:srpt_add_one: ib_srpt device = 0000000043289393
[  105.313438] ib_srpt:srpt_use_srq: ib_srpt
srpt_use_srq(enP2p1s0v0_siw): use_srq = 0; ret
--snip--
[  172.857740] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-63
[  172.857885] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-66
[  172.858032] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-68
[  172.858185] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-70
[  172.858344] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-72
[  172.858501] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-74
[  172.858666] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-76
[  172.858822] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-78
[  172.858976] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-80
[  172.859120] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-82
[  172.859278] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-84
[  172.859426] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-86
[  172.859564] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-88
[  172.859706] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-90
[  172.859851] ib_srpt:srpt_release_channel_work: ib_srpt
2620:0052:0000:13f0:1e1b:0dff:fe9d:b031-92
[  173.439406] ib_srpt:srpt_disconnect_ch_sync: ib_srpt ch
2620:0052:0000:13f0:a236:9fff:fe79:eb22-62 state 4
[  178.456609] ib_srpt
srpt_disconnect_ch_sync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
state 4): still waiting ...
[  183.496506] ib_srpt
srpt_disconnect_ch_sync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
state 4): still waiting ...
[  188.536450] ib_srpt
srpt_disconnect_ch_sync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
state 4): still waiting ...
[  193.576351] ib_srpt
srpt_disconnect_ch_sync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
state 4): still waiting ...
[  198.616280] ib_srpt
srpt_disconnect_ch_sync(2620:0052:0000:13f0:a236:9fff:fe79:eb22-62
state 4): still waiting ...


-- 
Best Regards,
  Yi Zhang

