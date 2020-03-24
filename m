Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2928E191D34
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 00:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCXXDO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 19:03:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36336 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgCXXDN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 19:03:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so565644qtb.3
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2020 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PRPf8+BkB6qFhpA6Gt4X1W0bt+OgtOWOOiWWuo1WJU4=;
        b=lr0tJ1WzQG46Exo730evKw3aR4DS6Cee6ATam4dDMgH549KI+DELVFBLqr0rl9Nyot
         J2kMah1oBjEgtIW5/+kDBwI1/3btOLmEYilKdJmv1j3JqbZ8stPuVKKuOxV7ujzVra1o
         /gRJ1UYHaIVbXvoWu9Lx7GM69ijE0y//jmJbhATK1A6zlL15jEU77xSzRBLSPCNXH7Mg
         FoCA3KDYyhVPXz5wX7SFZGyHmKKDkDxb6LEfrpehOOkzAtblMDHtNr6fNgSO0OcIIY6l
         MgFrZvQVql7RTZZthtvyOaJcR8yiptw98OzkRU+7RYdGlCg0vr3Ptnnf6bl3uzkennJw
         cVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PRPf8+BkB6qFhpA6Gt4X1W0bt+OgtOWOOiWWuo1WJU4=;
        b=gowxcKU+/vcpESXWqokwK9ks7FZnH5zTFv+de2D/s1KallUnZF4MErHPdVvAueR2sV
         CzHW3riEv8Og0YxGsnUf5qfghZvU2PoIEpc4eCIzm1L+zIKfUxpoYtuFlc/qoq2HAjxP
         lxHHEs6mjVGJo5N3R2BIYjn20VBDjrD4b4iO1BmQQllvGl/2vpo9S/FIlNNK5Dq7I3Oq
         S81GiWipPHul/SxRgT+GOYfVG7/aq9j5wAbACnmNOJL1zSYhyYay6cUxy2x5jzzgosUe
         cFHOL8b96NOCk8CmfyWCfp3bByCG82BWfKpEMmrhyoQMtCtciuh85SlI5HKwtsdXLUNB
         8vjw==
X-Gm-Message-State: ANhLgQ2KSINd8MXYPKi5ZkUeTWw0VT0ze5o9pLTqL2ep07sJ6k9P44Y5
        c/UJ5e4t7RwJZlecs5NJ4mY37g==
X-Google-Smtp-Source: ADFU+vuoAOn2LXjk91OdeUs/8HLyA2sKExeMtJEMPK1YcW5Xo2lO4S5z/npjwPNbCF2d/VFqXWsjMQ==
X-Received: by 2002:aed:35cc:: with SMTP id d12mr263076qte.298.1585090992461;
        Tue, 24 Mar 2020 16:03:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x6sm14400863qke.43.2020.03.24.16.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 16:03:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGsZj-0000qY-GY; Tue, 24 Mar 2020 20:03:11 -0300
Date:   Tue, 24 Mar 2020 20:03:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix access to wrong pointer while
 performing flush due to error
Message-ID: <20200324230311.GA3217@ziepe.ca>
References: <20200318091640.44069-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318091640.44069-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 11:16:40AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The main difference between send and receive SW completions is related
> to separate treatment of WQ queue. For receive completions, the initial
> index to be flushed is stored in "tail", while for send completions, it
> is in deleted "last_poll".
> 
> [62954.657039] CPU: 54 PID: 53405 Comm: kworker/u161:0 Kdump: loaded Tainted: G           OE    --------- -t - 4.18.0-147.el8.ppc64le #1
> [62954.657170] Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
> [62954.657234] NIP:  c000003c7c00a000 LR: c00800000e586af4 CTR: c000003c7c00a000
> [62954.657307] REGS: c0000036cc9db940 TRAP: 0400   Tainted: G           OE    --------- -t -  (4.18.0-147.el8.ppc64le)
> [62954.657403] MSR:  9000000010009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24004488  XER: 20040000
> [62954.657481] CFAR: c00800000e586af0 IRQMASK: 0
> GPR00: c00800000e586ab4 c0000036cc9dbbc0 c00800000e5f1a00 c0000037d8433800
> GPR04: c000003895a26800 c0000037293f2000 0000000000000201 0000000000000011
> GPR08: c000003895a26c80 c000003c7c00a000 0000000000000000 c00800000ed30438
> GPR12: c000003c7c00a000 c000003fff684b80 c00000000017c388 c00000396ec4be40
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: c00000000151e498 0000000000000010 c000003895a26848 0000000000000010
> GPR24: 0000000000000010 0000000000010000 c000003895a26800 0000000000000000
> GPR28: 0000000000000010 c0000037d8433800 c000003895a26c80 c000003895a26800
> [62954.658513] NIP [c000003c7c00a000] 0xc000003c7c00a000
> [62954.658634] LR [c00800000e586af4] __ib_process_cq+0xec/0x1b0 [ib_core]
> [62954.658750] Call Trace:
> [62954.658806] [c0000036cc9dbbc0] [c00800000e586ab4] __ib_process_cq+0xac/0x1b0 [ib_core] (unreliable)
> [62954.658974] [c0000036cc9dbc40] [c00800000e586c88] ib_cq_poll_work+0x40/0xb0 [ib_core]
> [62954.659114] [c0000036cc9dbc70] [c000000000171f44] process_one_work+0x2f4/0x5c0
> [62954.659256] [c0000036cc9dbd10] [c000000000172a0c] worker_thread+0xcc/0x760
> [62954.659388] [c0000036cc9dbdc0] [c00000000017c52c] kthread+0x1ac/0x1c0
> [62954.659521] [c0000036cc9dbe30] [c00000000000b75c] ret_from_kernel_thread+0x5c/0x80
> [62954.659660] Instruction dump:
> [62954.659735] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [62954.659886] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [62954.660040] ---[ end trace cece1d14044f024d ]---
> [62954.678250]
> [62954.678335] Sending IPI to other CPUs
> [62955.479581] IPI complete
> 
> Fixes: 8e3b68830186 ("RDMA/mlx5: Delete unreachable handle_atomic code by simplifying SW completion")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c      | 27 +++++++++++++++++++++++++--
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>  drivers/infiniband/hw/mlx5/qp.c      |  1 +
>  3 files changed, 27 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
