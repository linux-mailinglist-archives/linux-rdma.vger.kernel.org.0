Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5E46C09B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhLGQYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 11:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232311AbhLGQYu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 11:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638894080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=46XGbsgqb1rsz7epNq9wW2cTZSvQsnGeP2vZ1WkXe1U=;
        b=dym5N3I7YCwjMSVvVUERF3GiKMURj8CBKJC6UTYeQkqIukhbS3cF/Qp7/l2wsQ/DaG2woH
        g91LaM713UvQtdZv7Gn7ejIq+l2igwCj6lRKUhkJs5GUdu1GneWV4mY6oQwkLf6bwxvfEc
        swhY3h4zX0xKuPFIx+JtPvg0nI2zKXQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-DGpVDOUxN6uk7l5bgt9-eQ-1; Tue, 07 Dec 2021 11:21:18 -0500
X-MC-Unique: DGpVDOUxN6uk7l5bgt9-eQ-1
Received: by mail-yb1-f197.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so26744920ybf.23
        for <linux-rdma@vger.kernel.org>; Tue, 07 Dec 2021 08:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=46XGbsgqb1rsz7epNq9wW2cTZSvQsnGeP2vZ1WkXe1U=;
        b=gFOWWIChqfu9AXn48zxlTZDAWTb9NmZ/5Sg0u+53q6W8nlVVgw0hCBoxd4UOA5oSC3
         /B30edFvnjRs6VbwqiQyjCwhIIQ/bsd1b3LUCJpNooI+/7D0X2lU4JyKesWFx/vo2dd0
         jsVicXLDEt0+UAQv3pzoe8op+AusD4rEejpOe3t6uHuAIw829IIPE88CoFeMsuYvKzfK
         3c894snXY4XUbiLHNjDaKYUFvgHZB96BZKY0Oxij+Dyb3U53gkXElGkOdfmdFPkyVgX9
         YfgUG58g/rqmqcgxpHJFt0oO/Ga7LK5ESn9/KQ0+QzHtc9Xl4Xc4/VF55I+/7l+bcWVn
         8HYQ==
X-Gm-Message-State: AOAM531kgWB/Wt3bJXWkV24pbEhhA9mfTOuXyRTO0d4wdtnbUUxnCdyE
        5UmZNRdgwgpZ+cmH0ijJ0h1npj4G4A+P4o3F8mTDTWnXPKX3LlM4nai/WM/q2VjFvla/7mVpSCH
        yibdYqQVG5XLz+9Er7bT83M4j6PgwIJsQUhGDvg==
X-Received: by 2002:a25:c091:: with SMTP id c139mr54366021ybf.275.1638894077348;
        Tue, 07 Dec 2021 08:21:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcQ8jbXDIKO6ZGrHN8PXkbTrE1ywskT6iKxCWWmVzIp0CCiiRQ288uQaBDj7QwvX7DEBVIAxi8P6x1IQHgGRo=
X-Received: by 2002:a25:c091:: with SMTP id c139mr54365919ybf.275.1638894076464;
 Tue, 07 Dec 2021 08:21:16 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 8 Dec 2021 00:21:05 +0800
Message-ID: <CAHj4cs8XjFcV-5mP1F0baLYfWzo_iJKr1CWJN8b-vf0OT5rgig@mail.gmail.com>
Subject: [bug report] rdma_rxe: check_rkey: no MW matches rkey 0x1008747
 observed with blktests nvme/031
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

I found this issue with blktests[1] on latest 5.16.0-rc4, pls help
check it, thanks.

[1]
# nvme_trtype=rdma ./check nvme/031
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [failed]
    runtime  374.392s  ...  374.467s
    --- tests/nvme/031.out 2021-12-07 09:02:24.499460844 -0500
    +++ /mnt/tests/gitlab.com/cki-project/kernel-tests/-/archive/main/kernel-tests-main.zip/storage/blktests/nvme/nvme-rdma/blktests/results/nodev/nvme/031.out.bad
2021-12-07 09:53:47.386248655 -0500
    @@ -1,2 +1,8 @@
     Running nvme/031
    +Failed to write to /dev/nvme-fabrics: Input/output error
    +Failed to write to /dev/nvme-fabrics: Input/output error
    +Failed to write to /dev/nvme-fabrics: Input/output error
    +Failed to write to /dev/nvme-fabrics: Input/output error
    +Failed to write to /dev/nvme-fabrics: Input/output error
    +Failed to write to /dev/nvme-fabrics: Input/output error
    ...
    (Run 'diff -u tests/nvme/031.out
/mnt/tests/gitlab.com/cki-project/kernel-tests/-/archive/main/kernel-tests-main.zip/storage/blktests/nvme/nvme-rdma/blktests/results/nodev/nvme/031.out.bad'
to see the entire diff)

dmesg:
[ 1735.859191] run blktests nvme/031 at 2021-12-07 09:47:32
[ 1735.974835] Warning: Soft-RoCE Transport Driver - This driver has
not undergone sufficient testing by Red Hat for this release and
therefore cannot be used in production systems.
[ 1735.974891] rdma_rxe: loaded
[ 1735.980393] infiniband enP2p1s0f0_rxe: set active
[ 1735.980409] infiniband enP2p1s0f0_rxe: added enP2p1s0f0
[ 1735.983726] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 1735.983747] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 1735.983782] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 1735.985562] infiniband enP2p1s0f1_rxe: set down
[ 1735.985574] infiniband enP2p1s0f1_rxe: added enP2p1s0f1
[ 1735.985647] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 1735.987704] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 1735.988821] enP2p1s0f2 speed is unknown, defaulting to 1000
[ 1735.988847] enP2p1s0f2 speed is unknown, defaulting to 1000
[ 1735.988871] enP2p1s0f2 speed is unknown, defaulting to 1000
[ 1735.990651] infiniband enP2p1s0f2_rxe: set down
[ 1735.990662] infiniband enP2p1s0f2_rxe: added enP2p1s0f2
[ 1735.990731] enP2p1s0f2 speed is unknown, defaulting to 1000
[ 1735.992785] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 1735.992821] enP2p1s0f2 speed is unknown, defaulting to 1000
[ 1735.994004] enP2p1s0f3 speed is unknown, defaulting to 1000
[ 1735.994024] enP2p1s0f3 speed is unknown, defaulting to 1000
[ 1735.994059] enP2p1s0f3 speed is unknown, defaulting to 1000
[ 1735.995858] infiniband enP2p1s0f3_rxe: set down
[ 1735.995870] infiniband enP2p1s0f3_rxe: added enP2p1s0f3
[ 1735.995951] enP2p1s0f3 speed is unknown, defaulting to 1000
[ 1735.998014] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 1735.998047] enP2p1s0f2 speed is unknown, defaulting to 1000
[ 1735.998087] enP2p1s0f3 speed is unknown, defaulting to 1000
[ 1736.007662] loop0: detected capacity change from 0 to 1073741824
[ 1736.122069] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[ 1736.188751] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1736.211922] nvmet: creating controller 1 for subsystem
blktests-subsystem-0 for NQN
nqn.2014-08.org.nvmexpress:uuid:740a9f52-0f73-4ae3-b30a-d0c22d360d54.
[ 1736.213986] nvme nvme0: creating 128 I/O queues.
[ 1736.272460] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[ 1736.291196] nvme nvme0: new ctrl: NQN "blktests-subsystem-0", addr
10.16.214.59:4420
[ 1736.292750] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-0"
[ 1736.292953] nvme0n1: detected capacity change from 0 to 1073741824
[ 1736.301283] block nvme0n1: no available path - failing I/O
[ 1736.301313] block nvme0n1: no available path - failing I/O
[ 1736.301333] Buffer I/O error on dev nvme0n1, logical block 16383,
async page read
[ 1736.831740] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1736.832884] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1736.836858] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:740a9f52-0f73-4ae3-b30a-d0c22d360d54.
[ 1736.837321] nvme nvme0: creating 128 I/O queues.
[ 1736.894700] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[ 1736.911913] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
10.16.214.59:4420
[ 1736.912685] nvme0n1: detected capacity change from 0 to 1073741824
[ 1736.913446] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1736.920267] block nvme0n1: no available path - failing I/O
[ 1736.920292] block nvme0n1: no available path - failing I/O
[ 1736.920311] Buffer I/O error on dev nvme0n1, logical block 16383,
async page read
[ 1737.371970] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
[ 1737.372779] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1737.376320] nvmet: creating controller 1 for subsystem
blktests-subsystem-2 for NQN
nqn.2014-08.org.nvmexpress:uuid:740a9f52-0f73-4ae3-b30a-d0c22d360d54.
[ 1737.376777] nvme nvme0: creating 128 I/O queues.
[ 1737.436519] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[ 1737.454206] nvme nvme0: new ctrl: NQN "blktests-subsystem-2", addr
10.16.214.59:4420
[ 1737.455362] nvme0n1: detected capacity change from 0 to 1073741824
[ 1737.455687] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-2"
[ 1737.462386] block nvme0n1: no available path - failing I/O
[ 1737.462409] block nvme0n1: no available path - failing I/O
[ 1737.462429] Buffer I/O error on dev nvme0n1, logical block 16383,
async page read
[ 1737.941691] nvmet: adding nsid 1 to subsystem blktests-subsystem-3
[ 1737.942831] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1737.946646] nvmet: creating controller 1 for subsystem
blktests-subsystem-3 for NQN
nqn.2014-08.org.nvmexpress:uuid:740a9f52-0f73-4ae3-b30a-d0c22d360d54.
[ 1737.947012] nvme nvme0: creating 128 I/O queues.
[ 1738.005856] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[ 1738.022907] nvme nvme0: new ctrl: NQN "blktests-subsystem-3", addr
10.16.214.59:4420
[ 1738.024063] nvme0n1: detected capacity change from 0 to 1073741824
[ 1738.024588] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-3"
[ 1738.031056] block nvme0n1: no available path - failing I/O
[ 1738.031084] block nvme0n1: no available path - failing I/O
[ 1738.031103] Buffer I/O error on dev nvme0n1, logical block 16383,
async page read
[ 1738.591674] nvmet: adding nsid 1 to subsystem blktests-subsystem-4
[ 1738.592816] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1738.596603] rdma_rxe: check_rkey: no MW matches rkey 0x100871b
[ 1738.596621] rdma_rxe: qp#1045 moved to error state
[ 1738.596645] nvmet_rdma: RDMA READ for CQE 0x00000000df0d3d53 failed
with status remote access error (10).
[ 1802.971014] nvme nvme0: I/O 0 QID 0 timeout
[ 1802.971035] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[ 1802.971075] nvme nvme0: failed to connect queue: 0 ret=881
[ 1803.064324] nvmet: adding nsid 1 to subsystem blktests-subsystem-5
[ 1803.065026] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1803.069250] rdma_rxe: check_rkey: no MW matches rkey 0x100a82a
[ 1803.069270] rdma_rxe: qp#1046 moved to error state
[ 1803.069294] nvmet_rdma: RDMA READ for CQE 0x00000000ed377f97 failed
with status remote access error (10).
[ 1864.413425] nvme nvme0: I/O 0 QID 0 timeout
[ 1864.413452] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[ 1864.413501] nvme nvme0: failed to connect queue: 0 ret=881
[ 1864.526456] nvmet: adding nsid 1 to subsystem blktests-subsystem-6
[ 1864.527160] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1864.531825] rdma_rxe: check_rkey: no MW matches rkey 0x100c968
[ 1864.531841] rdma_rxe: qp#1047 moved to error state
[ 1864.531876] nvmet_rdma: RDMA READ for CQE 0x00000000fcb8d069 failed
with status remote access error (10).
[ 1925.855845] nvme nvme0: I/O 0 QID 0 timeout
[ 1925.855866] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[ 1925.855897] nvme nvme0: failed to connect queue: 0 ret=881
[ 1925.938934] nvmet: adding nsid 1 to subsystem blktests-subsystem-7
[ 1925.939979] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1925.943185] rdma_rxe: check_rkey: no MW matches rkey 0x100eab5
[ 1925.943205] rdma_rxe: qp#1048 moved to error state
[ 1925.943229] nvmet_rdma: RDMA READ for CQE 0x00000000559469e8 failed
with status remote access error (10).
[ 1987.298409] nvme nvme0: I/O 0 QID 0 timeout
[ 1987.298424] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[ 1987.298464] nvme nvme0: failed to connect queue: 0 ret=881
[ 1987.431413] nvmet: adding nsid 1 to subsystem blktests-subsystem-8
[ 1987.432471] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 1987.434991] rdma_rxe: check_rkey: no MW matches rkey 0x1010b22
[ 1987.435009] rdma_rxe: qp#1049 moved to error state
[ 1987.435032] nvmet_rdma: RDMA READ for CQE 0x000000009d9e0880 failed
with status remote access error (10).
[ 2048.740897] nvme nvme0: I/O 0 QID 0 timeout
[ 2048.740918] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[ 2048.740950] nvme nvme0: failed to connect queue: 0 ret=881
[ 2048.873456] nvmet: adding nsid 1 to subsystem blktests-subsystem-9
[ 2048.874225] nvmet_rdma: enabling port 0 (10.16.214.59:4420)
[ 2048.877860] rdma_rxe: check_rkey: no MW matches rkey 0x1012ca0
[ 2048.877881] rdma_rxe: qp#1050 moved to error state
[ 2048.877906] nvmet_rdma: RDMA READ for CQE 0x00000000e4b358c5 failed
with status remote access error (10).
[ 2110.183315] nvme nvme0: I/O 0 QID 0 timeout
[ 2110.183331] nvme nvme0: Connect command failed, error wo/DNR bit: 881
[ 2110.183372] nvme nvme0: failed to connect queue: 0 ret=881
[ 2111.116320] enP2p1s0f1 speed is unknown, defaulting to 1000
[ 2111.116356] enP2p1s0f2 speed is unknown, defaulting to 1000
[ 2111.116380] enP2p1s0f3 speed is unknown, defaulting to 1000
[ 2111.133594] rdma_rxe: unloaded

-- 
Best Regards,
  Yi Zhang

