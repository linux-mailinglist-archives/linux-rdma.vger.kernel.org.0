Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BED219A25
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGIHkN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIHkM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 03:40:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84561C061A0B
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2020 00:40:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so1271453eje.1
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CuRebjxaWGPl8OYcv/lw0tglT7YFwjGd4qsQqyYClo4=;
        b=IaDPKQwp7aOZC5/v2XaAOBhOHts2n5oBUbCJa44CmX80FR2UIdJQHKE0TXNFucBCxp
         EQKz2cVY0OBSGlX3TRvNV2UbGEK3a2Grh2yA8xgk3mpOW8PGJJF23QcBvhsymIjrXxyE
         V6o60Vk2DeZL49aMFoKvSbbBBGkk1ViafC2mTQGMSMXlk2Nm3HvR+iBr2+jhd9v0T1mS
         Yzd4avNeZvA0LHVu93b11hjlbpNyuoHY3JTImoe4+f9Wz9BejEaFOxyrx3f94U3br+RH
         2kukP6SOrppPaKz2DhN8NDhz2WzdlripUtTSTklBkNGA491xl5X450MRE8sCTSK/y+vb
         TGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CuRebjxaWGPl8OYcv/lw0tglT7YFwjGd4qsQqyYClo4=;
        b=P4KWgTT50um1EXT+UwYu+ClkFHE8ux0drE4BqLj6R3R/cgae14agwYaxhzsuJWKTHM
         wgKdcfWdX24OHohTMIXEplSk+wGqW/F50qT/6o7bTBH2TDMC5A91u0qS1q9FFnB6FgjX
         2RRIFpd+FKPugumsQorNnQPX+O6UAFAhcanHxslwJViUpLLvq8+770eELFfFxp/V4Uwu
         irk5DzR7PmmaHE9U4pTK9KqiRp3VzOOeZR0IXhCWKb528lrjsLfwh/qAd/LIlLRsJZ8E
         UZkXVJaZYmbnmpmseq13f1Kg3jDjy1fOeyG/0JAzJ3rNqgMcfrezVzAo18APU7QqOjaX
         916Q==
X-Gm-Message-State: AOAM533YyzXYbKzdqkh4oHxxXUuynruQw9YmSlVoJnTSajJ9pNmKxFbg
        s2bPTk3gcIua93LJv8Wi8f+Etg==
X-Google-Smtp-Source: ABdhPJws2bfI6HytF+Dia+dN0EDohnSOFhZKzEidpKPYhh4xaahaoocAxfeBEVIt+Zh4yyuH9FO9aA==
X-Received: by 2002:a17:906:8392:: with SMTP id p18mr58569317ejx.24.1594280411248;
        Thu, 09 Jul 2020 00:40:11 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.209.119])
        by smtp.googlemail.com with ESMTPSA id kt4sm1247257ejb.48.2020.07.09.00.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 00:40:10 -0700 (PDT)
Subject: Re: [PATCH V1 rdma-core 00/13] verbs: Introduce import verbs for
 device, PD, MR
To:     linux-rdma@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>, jgg@mellanox.com,
        maorg@mellanox.com
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <0dcee502-85af-0876-f4ed-dc7601fa60d9@dev.mellanox.co.il>
Date:   Thu, 9 Jul 2020 10:40:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/5/2020 11:19 AM, Yishai Hadas wrote:
> This series Introduces import verbs for device, PD, MR which enables processes
> to share their ibv_context and then share PD(s) and MR(s) that are associated
> with.
> 
> This functionality enables utilizing and optimizing some application flows, few
> examples below.
> 
> Any solution which is a single business logic based on multi-process design
> needs this. Example include NGINX, with TCP load balancing, sharing the RSS
> indirection table with RQ per process. HPC frameworks with multi-rank (process)
> solution on single hosts. UCX can share IB resources using the shared PD and
> can help dispatch data to multiple processes/MR's in single RDMA operation.
> Also, there are use cases when a primary processes registered a large shared
> memory range, and each worker process spawned will create a private QP on the
> shared PD, and use the shared MR to save the registration time per-process.
> 
> As part of this series was added also some pyverbs stuff to support and
> demonstrate some usage of the APIs.
> 
> The verbs APIs were introduced in the mailing list by the below RFC [1], the
> matching kernel series was sent to rdma-next,
> 
> PR: https://github.com/linux-rdma/rdma-core/pull/776
> [1] https://patchwork.kernel.org/patch/11540665/
> 
> Changes from V0:
> - Replace ordering of patches #3 and #4 to prevent incomplete functionality.
> - Added some note as part of ibv_import_device() to explain why it's safe
>    for dissociated flow.
> - Improve man pages in some places.
> - Drop the IOVA attribute setting which was not really in use.
> - Fix some style notes.
> - Refer in commit messages to ioctl command instead of KABI.
> 
> Yishai
> 
> Edward Srouji (3):
>    pyverbs: Support verbs import APIs
>    Documentation: Add usage example for verbs import
>    tests: Add a shared PD Pyverbs test
> 
> Yishai Hadas (10):
>    Update kernel headers
>    verbs: Close async_fd only when it was previously created
>    verbs: Enhance async FD usage
>    verbs: Introduce ibv_import_device() verb
>    mlx5: Refactor mlx5_alloc_context()
>    mlx5: Implement the import device functionality
>    verbs: Introduce ibv_import/unimport_pd() verbs
>    mlx5: Implement the import/unimport PD verbs
>    verbs: Introduce ibv_import/unimport_mr() verbs
>    mlx5: Implement the import/unimport MR verbs
> 
>   Documentation/pyverbs.md                   |  40 ++++
>   debian/libibverbs1.symbols                 |   5 +
>   kernel-headers/rdma/ib_user_ioctl_cmds.h   |  15 ++
>   kernel-headers/rdma/mlx5_user_ioctl_cmds.h |  14 ++
>   kernel-headers/rdma/rdma_netlink.h         |   8 +
>   kernel-headers/rdma/rdma_user_ioctl_cmds.h |   2 +-
>   libibverbs/cmd_cq.c                        |   9 +-
>   libibverbs/cmd_device.c                    |  32 ++-
>   libibverbs/cmd_mr.c                        |  31 +++
>   libibverbs/cmd_qp.c                        |   4 +
>   libibverbs/cmd_srq.c                       |   4 +
>   libibverbs/cmd_wq.c                        |   4 +
>   libibverbs/device.c                        |  73 ++++++-
>   libibverbs/driver.h                        |  14 ++
>   libibverbs/dummy_ops.c                     |  30 +++
>   libibverbs/ibverbs.h                       |   1 +
>   libibverbs/libibverbs.map.in               |   7 +
>   libibverbs/man/CMakeLists.txt              |   5 +
>   libibverbs/man/ibv_import_device.3.md      |  48 +++++
>   libibverbs/man/ibv_import_mr.3.md          |  64 ++++++
>   libibverbs/man/ibv_import_pd.3.md          |  59 ++++++
>   libibverbs/verbs.c                         |  30 +++
>   libibverbs/verbs.h                         |  26 +++
>   providers/mlx5/mlx5.c                      | 319 ++++++++++++++++++-----------
>   providers/mlx5/mlx5.h                      |   6 +
>   providers/mlx5/verbs.c                     |  78 ++++++-
>   pyverbs/device.pyx                         |  12 +-
>   pyverbs/libibverbs.pxd                     |   5 +
>   pyverbs/mr.pxd                             |   1 +
>   pyverbs/mr.pyx                             |  60 +++++-
>   pyverbs/pd.pxd                             |   1 +
>   pyverbs/pd.pyx                             |  37 +++-
>   tests/CMakeLists.txt                       |   1 +
>   tests/base.py                              |  11 +-
>   tests/test_shared_pd.py                    |  95 +++++++++
>   35 files changed, 999 insertions(+), 152 deletions(-)
>   create mode 100644 libibverbs/man/ibv_import_device.3.md
>   create mode 100644 libibverbs/man/ibv_import_mr.3.md
>   create mode 100644 libibverbs/man/ibv_import_pd.3.md
>   create mode 100644 tests/test_shared_pd.py
> 

The PR was merged.

Thanks,
Yishai
