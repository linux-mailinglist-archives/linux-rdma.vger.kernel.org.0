Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EB11ACF16
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 19:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgDPRrw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbgDPRrv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 13:47:51 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA0C061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 10:47:51 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q73so2468818qvq.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8r8V4U0xgCMJAhOFw9m2e/WQjAga6cnTlbASGX4DAaA=;
        b=fEso9fMddYioyXovAbt61NSnt1elcMMTJB16HJ3/NE242+0cD1ybAZFHdAhwrw9ItF
         yRugg8N+Rt04lgpOXnFjgkL1MYBflUbNwNIJwmOR0DaVne+hCMtyNszEjrQoDprgzNDd
         nWqD3GU1INn+6GpVoj4BaeR96X3p7aa88aw5t27opxqNWZh/PPJzMdxDsEOz20ly7CtP
         Ia4OnX4TyimeFuT59dSTNxB0k8Z5XgquydJwbO2ptHyZNmLxJTd2buZz/k8sWByJw6JD
         ZBsP/UJQ6bWP17VfdfJDKkpl7pMPnPNXsnZOZBv0uD4gdImMMRw7wEwVGxLyHN+xcvaS
         AEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8r8V4U0xgCMJAhOFw9m2e/WQjAga6cnTlbASGX4DAaA=;
        b=gBOL+ey7jBY33WjqZBpkKy30gtdtzhEEMDKJV+uvjPX8spdvdzleWQGyAlF0k6Ia7A
         F+6+hPprDnAFxjmiHqGyoT9LME/tj0b5m5XiPGPeISoAsim+nNHhO+JuXcGCs7aWgfEE
         Abl1BypJkuck+YxFhA+0DEFao/nyJiF70F/uLu/v5l8NjqAknZ9fNrkar6lYL0jl/Pz3
         EAED6vvSOXod6UY7GvHt/haSL/nHroVrLuN13Y7/2P+7y9rvMeXm70E4ndiDB4qmP+kC
         o44GaJgYhNVkw/OojLbrVFSs60kxexz2ZILrgZiS81D4h1FixGHa1/KdQDtSzvgaVx+6
         cdCg==
X-Gm-Message-State: AGi0PuYF6XCRGKGZLcP6UpdqsDBygeOmxZgC1JiPDhmnJkwApc1/lXZQ
        X4lbUQI2GeM4K2YFZQp3jDBM1Q==
X-Google-Smtp-Source: APiQypItOlrEyBYhrgQrGtAsXtQZZwXhc3MoLZiiIEs7wOhZEAyyPzGEoM8wtoBNK1tAQZVw+lVoTw==
X-Received: by 2002:a05:6214:6a7:: with SMTP id s7mr11396196qvz.103.1587059269598;
        Thu, 16 Apr 2020 10:47:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u126sm15588447qkh.66.2020.04.16.10.47.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 10:47:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP8c8-0005xD-Hg; Thu, 16 Apr 2020 14:47:48 -0300
Date:   Thu, 16 Apr 2020 14:47:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH 2/3] RDMA/uverbs: Add uverbs commands for fd-based MR
 registration
Message-ID: <20200416174748.GS5100@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-3-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587056973-101760-3-git-send-email-jianxin.xiong@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 10:09:32AM -0700, Jianxin Xiong wrote:

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index f6c2552..b3f7261 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2654,9 +2654,11 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, read_counters);
>  	SET_DEVICE_OP(dev_ops, reg_dm_mr);
>  	SET_DEVICE_OP(dev_ops, reg_user_mr);
> +	SET_DEVICE_OP(dev_ops, reg_user_mr_fd);
>  	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
>  	SET_DEVICE_OP(dev_ops, req_notify_cq);
>  	SET_DEVICE_OP(dev_ops, rereg_user_mr);
> +	SET_DEVICE_OP(dev_ops, rereg_user_mr_fd);

I'm not so found of adding such a specific callback.. It seems better
to have a generic reg_user_mr that accepts a ib_umem created by the
core code. Burying the umem_get in the drivers was probably a mistake.

>  static int ib_uverbs_dereg_mr(struct uverbs_attr_bundle *attrs)
>  {
>  	struct ib_uverbs_dereg_mr cmd;
> @@ -3916,7 +4081,19 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
>  			ib_uverbs_rereg_mr,
>  			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_rereg_mr,
>  						struct ib_uverbs_rereg_mr_resp),
> -			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr))),
> +			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr)),
> +		DECLARE_UVERBS_WRITE(
> +			IB_USER_VERBS_CMD_REG_MR_FD,
> +			ib_uverbs_reg_mr_fd,
> +			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_reg_mr_fd,
> +						struct ib_uverbs_reg_mr_resp),
> +			UAPI_DEF_METHOD_NEEDS_FN(reg_user_mr_fd)),
> +		DECLARE_UVERBS_WRITE(
> +			IB_USER_VERBS_CMD_REREG_MR_FD,
> +			ib_uverbs_rereg_mr_fd,
> +			UAPI_DEF_WRITE_UDATA_IO(struct ib_uverbs_rereg_mr_fd,
> +						struct ib_uverbs_rereg_mr_resp),
> +			UAPI_DEF_METHOD_NEEDS_FN(rereg_user_mr_fd))),

New write based methods are not allowed, they have to be done as ioctl
methods.

Jason
