Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110D24830C1
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 12:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiACL4O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 06:56:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41058 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiACL4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 06:56:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52B88CE1065;
        Mon,  3 Jan 2022 11:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E3DC36AED;
        Mon,  3 Jan 2022 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641210970;
        bh=uply5nfN5UXzyyi/EEBYHjvesAEjKliTHHVGcLsppzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCdGzsRz66Vb4AwMH4B/ixPTcUBGS+hcZJS4KjcvOZ+BUD98Zq5qdSGH0MfL8IJb6
         /mk5UeXmWPNRVQBb2YrJiMIeboXc8Qt4zQChY4Mc8n6WgumkTs0PFDRxEnPybIFCi5
         l6KFfgN+t4FCHrrAz50mhi/ojP4RZRyAVBPZzgUtSpAHlp6H5Wib/dRff3Dq+sCpPN
         jvi/nGFM9FFlFSmYpDG1c57WC7YqZjRDjRRiqI49AuoFltO+JkS+2bSFjEEsmxiQTQ
         0oqunKW3ko4RfxFeVGKQsd1axus7W8eGQEMqNLZx5D3bwWxahUZgAw8DyfhTWWaxgZ
         ceW68ggqReL8A==
Date:   Mon, 3 Jan 2022 13:56:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Check for null return of kmalloc_array
Message-ID: <YdLkViIfDnDbaA+V@unreal>
References: <20211231093315.1917667-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231093315.1917667-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 31, 2021 at 05:33:15PM +0800, Jiasheng Jiang wrote:
> Because of the possible failure of the allocation, data might be NULL
> pointer and will cause the dereference of the NULL pointer later.
> Therefore, it might be better to check it and return -ENOMEM.
> 
> Fixes: 6884c6c4bd09 ("RDMA/verbs: Store the write/write_ex uapi entry points in the uverbs_api")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/infiniband/core/uverbs_uapi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
