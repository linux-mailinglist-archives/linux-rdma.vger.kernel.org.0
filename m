Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707DC1D023
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2019 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfENTpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 15:45:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42578 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENTpP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 15:45:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so536031eda.9;
        Tue, 14 May 2019 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fu9WOeDbdlL/ua5Ah2bZTlJie+g3UL98LUXK/FhpkXQ=;
        b=LPIXovgGUA7+D6oKZfVjcYMnrbagOKIgBIOb5NewyNJ34GdkG0K735sD0dyGuRsOrc
         Ma1fbjdFgcd8fxKKGhQfHYGgTriKPgHFRQTP8GGOt8MgOq+gw9VxEHyz0y9DLBXwScwh
         gIrdADKXUNCqCUrOEMDmv8WhBbLeKQQCZ8IkSWrAmftE4jF3rzwthp9WABk3qJSs7w1y
         P9rwf4TwckKSorNd+oRWiDsqUlL5+iFIlB+d9T7GuAwJGYfgt5bcGRUBb0oNYFONZzjq
         UKywE9BnSA/NU8wMalz+VX/rwAPYMDZQyc0NhRw4bpWMeRvnZL68JMR9kfwpvKkiAGai
         29vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fu9WOeDbdlL/ua5Ah2bZTlJie+g3UL98LUXK/FhpkXQ=;
        b=LKR5bnviCqr9plzF4P14MYNn6yVRGcJqLqTG5qmlqiqTqo8llCewqCYrWaKhKxg1b3
         3imXJA/F5rJQDz0qWjXbTxGWdjr5pm6Jyw6Uoo63kTdOPkvXFGyFxIijIpkgyyb0lDcV
         vejwKkj6sbRWWZM+mHg9KD3W696pfmCDUujhN184WNI0JCsAAO/EBAQWlamTCykVs0Wm
         ZMbm4oA1wAu6ofUJ202RsPrmOfsXzxkLVrkLWUGAYYy6hlyKY86H0h9yClGON57zXmg8
         YGg4XqXL7LLJQnRaelxtMqKlmK9OxPrWxLKUWIEumvyPZlm7n1d9hcppeEcLki9qGe+w
         Bt7Q==
X-Gm-Message-State: APjAAAVgu8MF+3OqW5hJXsXpFyQrccuvWsDuUhDTVfcAUiEiTat4YJJp
        KR40gibGfULMTvRzeQhIXYw=
X-Google-Smtp-Source: APXvYqy29p1AGL/lhkLzcm9t9htDL/6Rgp/8i5IyzXb3FiDwnKLmonFhwH6a3wXa6z6BF4OHcI0LvA==
X-Received: by 2002:a50:a51c:: with SMTP id y28mr32223328edb.280.1557863113126;
        Tue, 14 May 2019 12:45:13 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id e33sm4855172edd.53.2019.05.14.12.45.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 12:45:12 -0700 (PDT)
Date:   Tue, 14 May 2019 12:45:10 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Message-ID: <20190514194510.GA15465@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

I checked the RDMA mailing list and trees and I haven't seen this
reported/fixed yet (forgive me if it has) but when building for arm32
with multi_v7_defconfig and the following configs (distilled from
allyesconfig):

CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_USER_ACCESS=y
CONFIG_MLX5_CORE=y
CONFIG_MLX5_INFINIBAND=y

The following link time errors occur:

arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_alloc_dm':
main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_alloc_sw_icm':
cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_dealloc_sw_icm':
cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'

Bisect log:

git bisect start
# good: [e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd] Linux 5.1
git bisect good e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
# bad: [63863ee8e2f6f6ae47be3dff4af2f2806f5ca2dd] Merge tag 'gcc-plugins-v5.2-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect bad 63863ee8e2f6f6ae47be3dff4af2f2806f5ca2dd
# good: [80f232121b69cc69a31ccb2b38c1665d770b0710] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 80f232121b69cc69a31ccb2b38c1665d770b0710
# good: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
git bisect good a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
# bad: [8e4ff713ce313dcabbb60e6ede1ffc193e67631f] Merge tag 'rtc-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect bad 8e4ff713ce313dcabbb60e6ede1ffc193e67631f
# good: [055128ee008b00fba14e3638e7e84fc2cff8d77d] Merge tag 'dmaengine-5.2-rc1' of git://git.infradead.org/users/vkoul/slave-dma
git bisect good 055128ee008b00fba14e3638e7e84fc2cff8d77d
# bad: [abde77eb5c66b2f98539c4644b54f34b7e179e6b] Merge branch 'for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect bad abde77eb5c66b2f98539c4644b54f34b7e179e6b
# good: [3b70508a6bfbdc78b565e9da22fd98483263494e] RDMA/mlx5: Create flow table with max size supported
git bisect good 3b70508a6bfbdc78b565e9da22fd98483263494e
# bad: [e7a5b4aafd82771f8924905c208d5d236ddcb671] RDMA/device: Don't fire uevent before device is fully initialized
git bisect bad e7a5b4aafd82771f8924905c208d5d236ddcb671
# good: [dd05cb828d0ebecd3d772075fccb85ec3618bedf] RDMA: Get rid of iw_cm_verbs
git bisect good dd05cb828d0ebecd3d772075fccb85ec3618bedf
# bad: [a808273a495c657e33281b181fd7fcc2bb28f662] RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks
git bisect bad a808273a495c657e33281b181fd7fcc2bb28f662
# good: [3a4ef2e2b5cf9a34bcc66c0d33f7eba180a14535] RDMA/rdmavt: Catch use-after-free access of AH structures
git bisect good 3a4ef2e2b5cf9a34bcc66c0d33f7eba180a14535
# bad: [33cde96fb5d7ae36207541c8a832d7fae3cadbde] IB/mlx5: Device resource control for privileged DEVX user
git bisect bad 33cde96fb5d7ae36207541c8a832d7fae3cadbde
# good: [4056b12efd43248d8331b6ed93df5ea5250106a9] IB/mlx5: Warn on allocated MEMIC buffers during cleanup
git bisect good 4056b12efd43248d8331b6ed93df5ea5250106a9
# bad: [25c13324d03d004f9e8071bf5bf5d5c6fdace71e] IB/mlx5: Add steering SW ICM device memory type
git bisect bad 25c13324d03d004f9e8071bf5bf5d5c6fdace71e
# first bad commit: [25c13324d03d004f9e8071bf5bf5d5c6fdace71e] IB/mlx5: Add steering SW ICM device memory type

DIV_ROUND_UP is u64 / u32 in this case. I think DIV_ROUND_UP_ULL is
needed but I am not sure if that has any unintended side effects so I
didn't want to send a patch.

I would appreciate if you guys could look into this.

Cheers,
Nathan
