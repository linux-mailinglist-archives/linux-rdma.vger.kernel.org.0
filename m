Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE33E2297C7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGVLzv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 07:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVLzv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 07:55:51 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F49C0619DC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 04:55:51 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so1596060qke.11
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dtC8ACdSw4pIpoS4eimK4pG3RRHpRJp/8VAfbzbzDFE=;
        b=g/Ar4YxsU2494MhKorMvn0AaDEiC12/llnBNs93t1URAKRD0FvLc1wsLwT9HUKkHfK
         iG1Kyg8s5pWx4oeFj9N81VxK/xJxP3+B+ufm8HZAfA5PCu3XIJyocZgi4KaH+ZZK3Dt5
         WNN1dRJKySM6kjmGQJKZJc7H8RUWQ2BCsU5WO+E2BqrYGscIIqZzabt1mNdKFZLX9men
         evs4alO76NNsRHivQRVN0lRekQS1nyYfWQsEULGmVeEd8UB3us7wMbBGix9dP6gJp5Bs
         HIX4J5RsuRJ3ADA28yRTAJVZU8T+982mqqZDXKsYTAPwDkdAIe/QMrq4/leCVsEK+90E
         szOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dtC8ACdSw4pIpoS4eimK4pG3RRHpRJp/8VAfbzbzDFE=;
        b=qd8iwJSM/nMfyDlpH4ucymEqO1GiDkv13KS7Ic8FLIaI5tbEvK9YDu1lRm0EZDbnoI
         D5qRleIpxEiMjQxtSZRJDmSsZ16d6E0clD4V+J2h6W3lOYjPvzHc1tIyI4of3nI/XRZZ
         MGYtoTzFqeS3UzsmsHurDlH8S5p9dT8/z1fgDhtWJy/KOC1I984JVPfZ9tsDbYVEkYoS
         2239UzxF0bR6Ao99ngtQD0nKS2JGbWhRWYmdD9L+ReXxlHhQTsBUOEvQpLyeren5208N
         DpUG/ILnCuBD/bLeI0P6S5QWHezwbNuvVW0NsEXux9gO+zhd4Snt8eV65vIJ1Sw30KAM
         pm/w==
X-Gm-Message-State: AOAM532d8p3Wf40ZIbSKHkKww0xvOYWGIBi1A3bU/6tzlLHWeiL50Uvz
        bxNxk4vhPCMdjWi4C+g/04o02w==
X-Google-Smtp-Source: ABdhPJwN+BEB7PgM18zAHJ+xDWXQdby8i6ct55z68B+HmOmYMO1EB2xRbQ5Rvf7vrEEk8njUya9zhw==
X-Received: by 2002:a37:a495:: with SMTP id n143mr11796513qke.330.1595418950383;
        Wed, 22 Jul 2020 04:55:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h81sm5355870qke.76.2020.07.22.04.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 04:55:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jyDLg-00Dg8R-V9; Wed, 22 Jul 2020 08:55:48 -0300
Date:   Wed, 22 Jul 2020 08:55:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v3 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
Message-ID: <20200722115548.GH25301@ziepe.ca>
References: <20200721133049.74349-1-galpress@amazon.com>
 <20200721133049.74349-4-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721133049.74349-4-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 21, 2020 at 04:30:48PM +0300, Gal Pressman wrote:
> Introduce a mechanism that performs an handshake between the userspace
> provider and kernel driver which verifies that the user supports all
> required features in order to operate correctly.
> 
> The handshake verifies the needed functionality by comparing the
> reported device caps and the provider caps. If the device reports a
> non-zero capability the appropriate comp mask is required from the
> userspace provider in order to allocate the context.
> 
> Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
>  drivers/infiniband/hw/efa/efa_verbs.c | 49 +++++++++++++++++++++++++++
>  include/uapi/rdma/efa-abi.h           | 10 ++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index 26102ab333b2..7ca40df81ee5 100644
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1501,11 +1501,48 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
>  	return efa_com_dealloc_uar(&dev->edev, &params);
>  }
>  
> +#define EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)                         \
> +	(!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask)))
> +
> +#define DEFINE_COMP_HANDSHAKE(_dev, _comp_mask, _attr, _mask)                  \
> +	{                                                                      \
> +		.attr = #_attr,                                                \
> +		.check_comp = EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)   \
> +	}
> +
> +int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
> +			    const struct efa_ibv_alloc_ucontext_cmd *cmd)
> +{
> +	struct efa_dev *dev = to_edev(ibucontext->device);
> +	int i;
> +	struct {
> +		char *attr;
> +		bool check_comp;
> +	} user_comp_handshakes[] = {
> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, max_tx_batch,
> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, min_sq_depth,
> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR),
> +	};

This seems like a very expensive construct

Why have the array at all? Just list the macros and have them jump to
err

Jason
