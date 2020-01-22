Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109C51450DF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgAVJuK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 04:50:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52538 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgAVJuJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jan 2020 04:50:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so6106490wmc.2
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2020 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yILKB/LdAW7ALnHytCM//bVCrmPX7ONBVfhWecuqj0E=;
        b=pDq5lwmHgiUtCNzm8miSmJMeNAY2QjjZPFbNZKV/jsqsq2RDRLsBsb5JZeDdT7Y8+n
         CcYOOgazLQe/r+jwoWSl4Zf5SktAAyjNPavjeYyoqCehKXBRRdZh9zu5sAb76Ie0/A+i
         q6D3Dk6ap5cRN6p7rlP+bChXoacUQ4AwYedRWixTJ37Mda2rnGXV8xsUQDm140MDlhyZ
         VgJOzJBSZr+8XekA77dOlkh2GFr0veWsMp/bWTn1dG0wWOBXB1CJJ0Hr06EokLVG2LVw
         5/D1Hjh4wj9QrNiuda/s3ipEDOdwEvTWlQQ7l/cjC9YN2qz7wPYpfLGp6FA8jdaaJqS1
         +d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yILKB/LdAW7ALnHytCM//bVCrmPX7ONBVfhWecuqj0E=;
        b=p+IJzUC/uO/jZT9rE8jVBb4vk4lO+hnKE4+VUHndre6yxPC16Kj9OffbM44TKW3nou
         +BJ55ftk2mmIbxj8aMtxUQCYA+OwKbcmQXNHCdqu7qBZDQRjIvNcoWMpEA7oeqr2AXYc
         AyfrFuS/WvJi85cr41p2VRT6uSkgxJdoJGk9sRKRsX27TDMV3x3a+qVwnPHTDu2WB8N0
         NeNt+bCRXMcHptchkSSVPiHW41sMDbGRkG5ZXfYQDScBDgX6YlFO0ZTBclluK2oyqmaJ
         I5JN7whcSvMYzAlLGjG3FQG6CLN0NC5GrHxd1b9LIUAtCrw1ULVwpxmB5pUxYZeKF4PO
         So5Q==
X-Gm-Message-State: APjAAAW7idFD+Xyx0tVMQch8Qo9zJxdjWuWtMEJzO4zZQqwHmxp9AlHf
        Svg+6dFBs8+ZYoway9gWFIlHczaevDo=
X-Google-Smtp-Source: APXvYqz43+tECFeXW5fQwz0MCB9jOeiGIdIRNwizT1GH/1Um+lSRkpnd7F2J06ni09p/x/kVu7OQ+Q==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr1958320wml.173.1579686607459;
        Wed, 22 Jan 2020 01:50:07 -0800 (PST)
Received: from [10.80.2.221] ([193.47.165.251])
        by smtp.googlemail.com with ESMTPSA id f1sm58045826wro.85.2020.01.22.01.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 01:50:06 -0800 (PST)
Subject: Re: [PATCH rdma-core 0/7] verbs: Relaxed ordering memory regions
To:     linux-rdma@vger.kernel.org, michaelgur@mellanox.com
Cc:     Yishai Hadas <yishaih@mellanox.com>, jgg@mellanox.com,
        dledford@redhat.com, maorg@mellanox.com
References: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <37f3f109-342c-54f7-ac1b-aed09266ae77@dev.mellanox.co.il>
Date:   Wed, 22 Jan 2020 11:50:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578578676-752-1-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/9/2020 4:04 PM, Yishai Hadas wrote:
> This series exposes an IBV_ACCESS_RELAXED_ORDERING optional MR access flag.
> This optional flag allows creation of relaxed ordering memory regions.
> Access through such MRs can improve performance by allowing the system to reorder
> certain accesses.
> 
> The series uses the new ioctl command to get a device context, this command
> enables reading some core generic capabilities such as supporting an optional
> MR access flags by IB core and its related drivers.
> 
> This capability enables transparent masking of the optional flags in libibverbs
> when the kernel doesn't support the MR optional access mode.
> 
> The series is based on an RFC that was sent to the ML [1], the matching kernel
> series was sent to 'for-next'.
> [1] https://www.spinics.net/lists/linux-rdma/msg86188.html
> 
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/660
> 
> Yishai
> 
> Michael Guralnik (6):
>    verbs: Move free_context from verbs_device_ops to verbs_context_ops
>    verbs: Move alloc_context to ioctl
>    verbs: Relaxed ordering memory regions
>    mlx5: Add optional access flags range to DM
>    pyverbs: Add relaxed ordering access flag
>    tests: Add relaxed ordering access test
> 
> Yishai Hadas (1):
>    Update kernel headers
> 
>   debian/libibverbs1.symbols                |  2 +
>   kernel-headers/rdma/ib_user_ioctl_cmds.h  | 15 ++++++
>   kernel-headers/rdma/ib_user_ioctl_verbs.h | 12 +++++
>   libibverbs/CMakeLists.txt                 |  2 +-
>   libibverbs/cmd.c                          | 18 -------
>   libibverbs/cmd_device.c                   | 79 +++++++++++++++++++++++++++++++
>   libibverbs/device.c                       |  5 +-
>   libibverbs/driver.h                       |  3 +-
>   libibverbs/dummy_ops.c                    |  7 +++
>   libibverbs/libibverbs.map.in              |  5 ++
>   libibverbs/man/ibv_reg_mr.3               |  2 +
>   libibverbs/verbs.c                        | 13 +++++
>   libibverbs/verbs.h                        | 51 +++++++++++++++++++-
>   libibverbs/verbs_api.h                    |  2 +
>   providers/bnxt_re/main.c                  |  6 ++-
>   providers/cxgb4/dev.c                     |  4 +-
>   providers/efa/efa.c                       |  4 +-
>   providers/hfi1verbs/hfiverbs.c            |  4 +-
>   providers/hns/hns_roce_u.c                |  4 +-
>   providers/i40iw/i40iw_umain.c             |  6 ++-
>   providers/ipathverbs/ipathverbs.c         |  4 +-
>   providers/mlx4/mlx4.c                     |  4 +-
>   providers/mlx5/mlx5.c                     |  4 +-
>   providers/mlx5/verbs.c                    |  3 +-
>   providers/mthca/mthca.c                   |  6 ++-
>   providers/ocrdma/ocrdma_main.c            |  6 ++-
>   providers/qedr/qelr_main.c                |  4 +-
>   providers/rxe/rxe.c                       |  6 ++-
>   providers/siw/siw.c                       |  3 +-
>   providers/vmw_pvrdma/pvrdma_main.c        |  4 +-
>   pyverbs/libibverbs_enums.pxd              |  1 +
>   tests/CMakeLists.txt                      |  5 +-
>   tests/test_relaxed_ordering.py            | 55 +++++++++++++++++++++
>   33 files changed, 301 insertions(+), 48 deletions(-)
>   create mode 100644 tests/test_relaxed_ordering.py
> 

The PR was merged, thanks.

Yishai
