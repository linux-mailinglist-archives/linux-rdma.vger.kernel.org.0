Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86C3EF9BE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 06:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhHRE5U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 00:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhHRE5U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 00:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629262605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=a/ca7BEA4zywbNlK2KoU9IRR3jktn/LpBWXd2WdGoEY=;
        b=Pco4DDFOvKLnuemvvl5t6GfO8xl8XG8h5taitFG5DscssbDeJAiz5dQ2UhGYlKo8b3jJQN
        fvX/2FKfTWaejUb1RdEu8SKDDn7xCiUNbIq4M/p7FHKcVQVns9/8TAFheha+Q6cAFF68jN
        DBEwFOT46bgoxo7IfTtFLfo6HUw3Q/M=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-H_uPWzqANAeEvLirKyMhgg-1; Wed, 18 Aug 2021 00:56:43 -0400
X-MC-Unique: H_uPWzqANAeEvLirKyMhgg-1
Received: by mail-yb1-f197.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso1609627ybg.11
        for <linux-rdma@vger.kernel.org>; Tue, 17 Aug 2021 21:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a/ca7BEA4zywbNlK2KoU9IRR3jktn/LpBWXd2WdGoEY=;
        b=grGSl9o0/o7+r8GQqGjFIp/5GbGMohGB5tr2MRK9ZiiwpVAcuRLFHqtWfPHy6wEBEq
         Q3QWtS1rQmfh4KKS6rDs+DcNJ4D2uPfB9PwPoi1aa+jEmjVjomy2tAVKtMmCK8CQUwjr
         4dA8fLCwxykQdUmm++EojvY8KWNXEyOL+AP6rGJ8fQHtS6+J8qbAbVVYTenfIjbKPpBz
         mTQ6oc+Zt+Sm65hxuPOhbdnXeoYxU40Z/6m6HtP/7mIxXj7uLBFC41wLljbtiSSMY0Jx
         tPYxUx2gB5HCRGzlJbba9tp4H5h2K9GGpsPF5Ns/ipiH7sLHkTju2tf5IYLT+5LbC1GE
         8A1Q==
X-Gm-Message-State: AOAM531q1FvpRMdMX+OUSnelZKYMVeXEEed2Ba0CFnBIun9PrYhFZ0h2
        3FZPZI7S6jCb0VpmoRa47nyTr6bNkOHDyNzWMUwh9I52QM44MLZAv2jV2onb3nyACkzTm0tnqcn
        leI5TMQyYwisUczGJQHint5IZNJIvPI493UvIfw==
X-Received: by 2002:a25:4d1:: with SMTP id 200mr8750832ybe.438.1629262602684;
        Tue, 17 Aug 2021 21:56:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnPbvMDfI7KTTcVzxhPsYLAUb7zwx5zj1jIdjcot+uaRYDFGz8qbqZzzzfuizOgyDgzYqDUGpZLlkIa8wI01o=
X-Received: by 2002:a25:4d1:: with SMTP id 200mr8750824ybe.438.1629262602490;
 Tue, 17 Aug 2021 21:56:42 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 18 Aug 2021 12:56:31 +0800
Message-ID: <CAHj4cs_M_PJ-7U3QdUxG5=Ce56mBP+WUwko2JqBO6gu_3CqJwQ@mail.gmail.com>
Subject: [bug report] rdma_rxe doesn't work with blktests on 5.14.0-rc6
To:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

I found rdma_rxe doesn't work with blktests on the latest upstream, is
it a known issue, feel free to let me know if you need any info/test
for it, thanks.

# nvme_trtype=rdma ./check nvme/008
nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
    runtime  0.323s  ...  0.329s
    --- tests/nvme/008.out 2021-08-18 00:18:35.380345954 -0400
    +++ /root/blktests/results/nodev/nvme/008.out.bad 2021-08-18
00:35:11.126723074 -0400
    @@ -1,5 +1,7 @@
     Running nvme/008
    -91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +Failed to write to /dev/nvme-fabrics: Cannot allocate memory
    +cat: '/sys/class/nvme/nvme*/subsysnqn': No such file or directory
    +cat: /sys/block/n1/uuid: No such file or directory
    ...
    (Run 'diff -u tests/nvme/008.out
/root/blktests/results/nodev/nvme/008.out.bad' to see the entire diff)


[  981.382774] run blktests nvme/008 at 2021-08-18 00:33:21
[  981.470796] rdma_rxe: loaded
[  981.474338] infiniband eno1_rxe: set active
[  981.474340] infiniband eno1_rxe: added eno1
[  981.476737] eno2 speed is unknown, defaulting to 1000
[  981.481803] eno2 speed is unknown, defaulting to 1000
[  981.486865] eno2 speed is unknown, defaulting to 1000
[  981.492862] infiniband eno2_rxe: set down
[  981.492864] infiniband eno2_rxe: added eno2
[  981.492904] eno2 speed is unknown, defaulting to 1000
[  981.497957] eno2 speed is unknown, defaulting to 1000
[  981.504338] eno2 speed is unknown, defaulting to 1000
[  981.510442] eno3 speed is unknown, defaulting to 1000
[  981.515509] eno3 speed is unknown, defaulting to 1000
[  981.520580] eno3 speed is unknown, defaulting to 1000
[  981.526600] infiniband eno3_rxe: set down
[  981.526601] infiniband eno3_rxe: added eno3
[  981.526640] eno3 speed is unknown, defaulting to 1000
[  981.531693] eno3 speed is unknown, defaulting to 1000
[  981.538052] eno2 speed is unknown, defaulting to 1000
[  981.543115] eno3 speed is unknown, defaulting to 1000
[  981.549088] eno4 speed is unknown, defaulting to 1000
[  981.554149] eno4 speed is unknown, defaulting to 1000
[  981.559211] eno4 speed is unknown, defaulting to 1000
[  981.565201] infiniband eno4_rxe: set down
[  981.565203] infiniband eno4_rxe: added eno4
[  981.565242] eno4 speed is unknown, defaulting to 1000
[  981.570306] eno4 speed is unknown, defaulting to 1000
[  981.576724] eno2 speed is unknown, defaulting to 1000
[  981.581785] eno3 speed is unknown, defaulting to 1000
[  981.586848] eno4 speed is unknown, defaulting to 1000
[  981.599312] loop0: detected capacity change from 0 to 2097152
[  981.612261] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  981.614215] nvmet_rdma: enabling port 0 (10.16.221.116:4420)
[  981.622586] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0035-4b10-8044-b9c04f463333.
[  981.622830] nvme nvme0: creating 32 I/O queues.
[  981.634860] nvme nvme0: failed to initialize MR pool sized 128 for
QID 32         ----------------------- failed here
[  981.772647] eno2 speed is unknown, defaulting to 1000
[  981.641676] nvme nvme0: rdma connection establishment failed (-12)
[  981.777715] eno3 speed is unknown, defaulting to 1000
[  981.782780] eno4 speed is unknown, defaulting to 1000
[  981.799443] rdma_rxe: unloaded

--
Best Regards,
  Yi Zhang

