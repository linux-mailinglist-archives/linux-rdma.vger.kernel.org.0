Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71035FB927
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 20:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfKMTtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 14:49:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40221 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMTtW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Nov 2019 14:49:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id z16so2865783qkg.7
        for <linux-rdma@vger.kernel.org>; Wed, 13 Nov 2019 11:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mi6sW3W5ZM1D0DHkb9VxuJO2aRMXFgI/taHNSN2vUM=;
        b=Q5wJ+9lm2aCrb6tKkkiTyzpDTbzuMOK4xcM8bBk2XXK9XrWXgoLVLRBDEVQlo1qUxq
         JJc3OajhC8KsxFX9OtPEihUMEdrgg4qgQDNCVS6yo0RkIeToAJaFhfiQEfWwCwAL8d9+
         QhASo5Umwlm0X4TzzvqPYYANIRcqiVOy8DI8SRyozKnTb+VrvCx+PKbZuxwr3oc1Cqy2
         QIKOqAHIpAEnQoz73ZXhkgMJaLOEoA4ZK+Bmkv3fBdrq0zVcpUWRjlLpjq2c2PKYnU0X
         Dv7Jwz1V/OeNYSyvLJrd/v96VH3LzkntwOAvUJ+nWZsO8kiryP2oMBQItEuOvu/OkBup
         h7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mi6sW3W5ZM1D0DHkb9VxuJO2aRMXFgI/taHNSN2vUM=;
        b=SH6g7K/dpUtyQ2gIDMpHy2eejXBD5diSzsPUC3YJNQjSmL7Z7sN19hkpD0HUw+Pslb
         xjRXPYQRL93XMRuScf8eRWknZTrSceG5n2kBlBTqRcwvp3bnOewMduWTpS7/xF8wksOw
         KAaWWWQeDLpPYvFP501aiBZDekfa66UG9ai3e1YXOERRE8pRUDVkr54TYR95K23YrHml
         X16GdxdKoUnt/M52qMheprNdzAsGiTAfYG9sgNkKHqZucxqsUFiz61Zbnq4/QOrN6e/k
         b2/xObOnGk1XVglnH+JZ9Thekzgfvu6+8C/9lFxIvSycuyizWjIsdjATDmCu9DUqh6Bh
         q0Wg==
X-Gm-Message-State: APjAAAXtISyiHHkvp9VPbNfbfEMEHnRSRZSS+HkqM+HD7CYJGPAQCtY8
        DEnoQ74fUDWjSZz8KxIReXLLvQ==
X-Google-Smtp-Source: APXvYqxHvIFa6V/a52v4K9U8d2IQqaLkBTYuKetI61JRU3EHMfABU0b/IMHzJZu5E7PeQYiZ+4IZfA==
X-Received: by 2002:a05:620a:112c:: with SMTP id p12mr4018360qkk.179.1573674561333;
        Wed, 13 Nov 2019 11:49:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id d13sm1810084qta.67.2019.11.13.11.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 11:49:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUydj-0005WF-Pn; Wed, 13 Nov 2019 15:49:19 -0400
Date:   Wed, 13 Nov 2019 15:49:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yevgeny Kliteynik <kliteyn@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next v2] IB/mlx5: Support flow counters offset for
 bulk counters
Message-ID: <20191113194919.GA21173@ziepe.ca>
References: <20191103140723.77411-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103140723.77411-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 03, 2019 at 04:07:23PM +0200, Leon Romanovsky wrote:
> From: Yevgeny Kliteynik <kliteyn@mellanox.com>
> 
> Add support for flow steering counters action with
> a non-base counter ID (offset) for bulk counters.
> 
> When creating a flow counter object, save the bulk value.
> This value is used when a flow action with a non-base
> counter ID is requested - to validate that the required
> offset is in the range of the allocated bulk.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Reviewed-by: Mark Bloch <markb@mellanox.com>
> ---
>  Changelog
>  v1->v2: https://lore.kernel.org/linux-rdma/20191029155020.20792-1-leon@kernel.org
>  * Fixed mlx5_ib_devx_is_flow_counter() logic
>  v0 -> v1: https://lore.kernel.org/linux-rdma/20191029055916.7322-1-leon@kernel.org
>  * Change ffs to multiply bitmap
>  * Changed uint32_t to be u32
>  * Added offset to mlx5_ib_devx_is_flow_counter()
> ---
>  drivers/infiniband/hw/mlx5/devx.c        | 15 +++++++++++-
>  drivers/infiniband/hw/mlx5/flow.c        | 29 ++++++++++++++++++++++--
>  drivers/infiniband/hw/mlx5/mlx5_ib.h     |  2 +-
>  include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
>  4 files changed, 43 insertions(+), 4 deletions(-)

Applied to for-next

Jason
