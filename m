Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2D2B1348
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgKMAeA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAeA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 19:34:00 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A088C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:34:00 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id b11so3817923qvr.9
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afW4WZCzKSBkopY3D+EVH1mNn8OfkBRY3siF83lMqQE=;
        b=GUB8oXHn8qWx1yZtNDBUNGqTLGpekKppaOjDD2/QhlEVR9N0rxsCnt3wtwTpUAoqZ5
         PGK138XPCL/h3BSPAWJhZCi+5FuqJgzGaf+au5hUAKFkpgxpTHcAadz1vo1a8Q/SAy8L
         MI+lP9mVzqVmmkxzorDX3NvY0A/j1ot5n3Tt94i8bC+FU0mlVX86NxbZLjPgjcrP8JpB
         D/tHzmselKJEt2LNgNXviNM2vM0kYITy0CLHHcwvaXfVaOTkAoLWD151voKCmVizgULW
         2AZZgo2sFFC/RsxFoQj81yg+6A9YWQF6JKUxxD2OqFpzi6Ds5p21p/IBe+ZdknM851fN
         kdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afW4WZCzKSBkopY3D+EVH1mNn8OfkBRY3siF83lMqQE=;
        b=LfO4GFJdf92NOcy5OFIkjKnuHltcLNkkeiM3gI1pSuU6rLs6E2x1f0YRBvCxIVIZPr
         cqYxsaqzc6FZ4A/maepMK881z8xxu3Q9+mN4VEEya+Ld6OCQ1eBcTeugMcHMjzwwTceB
         18RHChxI2hD7FQ1MlwFebuWi8CjDMzMENxZls2/tfPYJ4iMtTFMCldXZY6GuXJQfZwsk
         qMvk3zkrmNgZRt9DtqANZX0WpWkrQz6dLVbV5X69i36oz0lxKjw/8a3ndsIYNlb1U17I
         EsnHAno1CVVRX87z5dOlY6e7EcmWUxF0yqWJ21dWvRehVHdx4iVMj0u6LcCjqtV7kDkQ
         satA==
X-Gm-Message-State: AOAM530hh/MeunB8bx3J794z1Iwi5V+zSuigvahO58aV0+FtuwrFcaM7
        w9krnNK9Tdu04aocEzB9GPZ8Sr/j40ZAUVqt
X-Google-Smtp-Source: ABdhPJxTEQq72i7ob2HRVE794ShOLxAvgR60EjaYjpz/aWIW8rfgL1FNfruWyXs0j85qUGJNVa9aUA==
X-Received: by 2002:a0c:8b91:: with SMTP id r17mr2393438qva.29.1605227639736;
        Thu, 12 Nov 2020 16:33:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t133sm6123625qke.82.2020.11.12.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:33:59 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdN2M-004CW8-It; Thu, 12 Nov 2020 20:33:58 -0400
Date:   Thu, 12 Nov 2020 20:33:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v10 3/6] RDMA/uverbs: Add uverbs command for dma-buf
 based MR registration
Message-ID: <20201113003358.GZ244516@ziepe.ca>
References: <1605044477-51833-1-git-send-email-jianxin.xiong@intel.com>
 <1605044477-51833-4-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605044477-51833-4-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 10, 2020 at 01:41:14PM -0800, Jianxin Xiong wrote:
> +	mr = pd->device->ops.reg_user_mr_dmabuf(pd, offset, length, virt_addr,
> +						fd, access_flags,
> +						&attrs->driver_udata);
> +	if (IS_ERR(mr))
> +		return PTR_ERR(mr);
> +
> +	mr->device = pd->device;
> +	mr->pd = pd;
> +	mr->type = IB_MR_TYPE_USER;
> +	mr->uobject = uobj;
> +	atomic_inc(&pd->usecnt);
> +
> +	uobj->object = mr;
> +
> +	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DMABUF_MR_HANDLE);
> +
> +	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DMABUF_MR_RESP_LKEY,
> +			     &mr->lkey, sizeof(mr->lkey));
> +	if (ret)
> +		goto err_dereg;
> +
> +	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DMABUF_MR_RESP_RKEY,
> +			     &mr->rkey, sizeof(mr->rkey));
> +	if (ret)
> +		goto err_dereg;
> +
> +	return 0;
> +
> +err_dereg:
> +	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));

This isn't how the error handling works with
uverbs_finalize_uobj_create() - you just return the error code and the
caller deals with destroying the fully initialized HW object
properly. Calling ib_dereg_mr_user() here will crash the kernel.

Check the other uses for an example.

Again I must ask what the plan is for testing as even a basic set of
pyverbs sanity tests would catch this.

I've generally been insisting that all new uABI needs testing support
in rdma-core. This *might* be the exception but I want to hear a
really good reason why we can't have a test first...

Jason
