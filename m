Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3029C1E1B9E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 08:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEZG7S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEZG7S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 02:59:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B596C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 23:59:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so1888705wmh.5
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RJoyk3mp8TqBuONbz1PdP3yOV0+TYiERNgj6azAKw2U=;
        b=2RoAr06XZsFQpsNUKC27mH/BTWNPdPG492LRPTRrrIJd0MNi9jIArKRftdbJXIbC1a
         u98qysCckH6/wAviPc7Q4Kanj0f5FJivB2VQOn+vUAw8GtACzYQSmr17y4HiHCzWaG9w
         s7e53KPdkr+UMMxldoAjNBxHzzooGZD64bKgtLke+xVtXlll1uhWC7bszj9m3KiqpYDe
         kZNP7DtjWAr/rPNQG8cL+9RY9By9jaqsiGHy62hLtTUEs4xB+XXy8/JOKMHXTIzLJ382
         YgHdU3U+k28VUderxmJbgdizuEjq+HV6R0Uumh91hIcOTiZ7FnMtfbjuobu0plR45XOP
         Dhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJoyk3mp8TqBuONbz1PdP3yOV0+TYiERNgj6azAKw2U=;
        b=IHGAbzWufo6JjCXn+wyycFbaKp4Q7sm1tIRyWXXFCAKxzjQ8X5PbCb7vQApYgJtCky
         WJQHX3y96EIr8NWt/1pNYN8AbgBmWovGadb7tHpw0A/VgJ10ERE0bmLUY6802suTPSFV
         kOZ2AzJwS7muaVtuEg1P7x+yOAzey+FRBHbKmoy14DEaAhOO743FL4PMVgGca/n090Br
         CjZ3G6jSG/meVnN+j2bIEme62+VAtsa0UYnE4ISSLVxLH/CSG2BQ8cqMOm60NtJXjdM2
         Ok3+3n1wXfyP6qlbPdvotma6O9ZM6FYC74bpHe/mIPweILw5LgPwr4sblRi1WZDAbo6T
         gjRQ==
X-Gm-Message-State: AOAM532c0ySVvhRTF9AE+HLrW1zjygmRlYifsoCe5UWUVzTWDAhLuprE
        VS7yc4UDwNvrtKLf7XfZnOO5qSF5tTs=
X-Google-Smtp-Source: ABdhPJxrXmWZHX0WHTlIcZ2LZKe0aZettcExYH2c+f1wN4dfFe9obXtQNSVPb1opEjQOdETACnftFA==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr17123254wmh.1.1590476355528;
        Mon, 25 May 2020 23:59:15 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.210.207])
        by smtp.googlemail.com with ESMTPSA id z6sm5756464wrh.79.2020.05.25.23.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 23:59:14 -0700 (PDT)
Subject: Re: [PATCH rdma-core 0/8] verbs: Enable asynchronous event FD per
 object
To:     linux-rdma@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>, jgg@mellanox.com,
        maorg@mellanox.com
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <ba3265bd-f352-9691-03cd-73ea72539306@dev.mellanox.co.il>
Date:   Tue, 26 May 2020 09:59:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/6/2020 12:41 PM, Yishai Hadas wrote:
> This series enables applicable events objects (i.e. QP, SRQ, CQ, WQ) to be
> created with their own asynchronous event FD from KABI point of view.
> 
> Before this series any affiliated event on an object was reported on the first
> asynchronous event FD that was created on the context without the ability to
> create and use a dedicated FD for it.
> 
> With this series we enable granularity and control for the usage per object.
> 
> For example, a secondary process that uses the same command FD as of the primary
> one, can create its own objects with its dedicated event FD to be able to get
> the events for them once occurred, this couldn't be done before this series.
> 
> Further series on top of this one may expose some option to an application to
> ask for a dedicated FD for its usage instead of using the default one, this may
> enable achieving the above use case.
> 
> To achieve the above, any 'create' method for the applicable objects was
> extended to get from rdma-core its optional event FD. If wasn't supplied, the
> default one from the context will be used as part of kernel side.
> 
> As we prefer to not extend the 'write' mode KABIs anymore and fully move to the
> 'ioct' mode, QP, SRQ and WQ create/destroy commands were introduced over
> 'ioctl', the CQ KABI was extended over its existing 'ioctl' create command.
> 
> As part of moving to 'ioctl' for the above objects few bugs were found and
> fixed.
> 
> The matching kernel part was sent into rdma-next.
> PR:
> https://github.com/linux-rdma/rdma-core/pull/753
> 
> 
> Jason Gunthorpe (1):
>    mlx4: Delete comp_mask from verbs_srq
> 
> Yishai Hadas (7):
>    Update kernel headers
>    verbs: Extend CQ KABI to get an async FD
>    verbs: Fix ibv_get_srq_num() man page
>    verbs: Move SRQ create and destroy to ioctl
>    verbs: Fix ibv_create_wq() to set wq_context
>    verbs: Move WQ create and destroy to ioctl
>    verbs: Move QP create and destroy commands to ioctl
> 
>   kernel-headers/rdma/ib_user_ioctl_cmds.h  |  81 +++++
>   kernel-headers/rdma/ib_user_ioctl_verbs.h |  43 +++
>   libibverbs/CMakeLists.txt                 |   3 +
>   libibverbs/cmd.c                          | 481 ------------------------------
>   libibverbs/cmd_cq.c                       |   7 +-
>   libibverbs/cmd_fallback.c                 |   2 +-
>   libibverbs/cmd_qp.c                       | 476 +++++++++++++++++++++++++++++
>   libibverbs/cmd_srq.c                      | 279 +++++++++++++++++
>   libibverbs/cmd_wq.c                       | 173 +++++++++++
>   libibverbs/driver.h                       |  25 +-
>   libibverbs/kern-abi.h                     |  11 +
>   libibverbs/man/ibv_get_srq_num.3.md       |   2 +-
>   libibverbs/verbs.c                        |  14 -
>   libibverbs/verbs.h                        |   1 +
>   providers/efa/verbs.c                     |   2 +-
>   providers/mlx4/mlx4.c                     |   2 +-
>   providers/mlx4/mlx4.h                     |   1 +
>   providers/mlx4/srq.c                      |   1 -
>   providers/mlx4/verbs.c                    |  17 +-
>   providers/mlx5/verbs.c                    |  16 +-
>   20 files changed, 1104 insertions(+), 533 deletions(-)
>   create mode 100644 libibverbs/cmd_qp.c
>   create mode 100644 libibverbs/cmd_srq.c
>   create mode 100644 libibverbs/cmd_wq.c
> 

The PR was merged.

Yishai
