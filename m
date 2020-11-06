Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32CD2A8B2F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 01:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgKFANG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 19:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732181AbgKFANF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 19:13:05 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0910C0613CF
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 16:13:05 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 12so3040172qkl.8
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 16:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hV4SEbrM/cIWHspZNhYKzuHjXt0GCuMNZj9nj+83JqM=;
        b=YA3K7K0g8CwFP10WeAX3bc05toLcAkgLDj1VIunQGfgs+3C430y9AiRL5TrmQaR4Ta
         4DhzgDL8DEeOKyreCZ8T/NXmUUF3HTjEG1a/n4wIuTSUWYTxZoG0XpDTKny5nm56Dy52
         H80wvIlLHcBf9Hu2ujzsyGxpXrJq6SrwpT8aQsXkE32Bk8iD32fcmzx6Ikz0RIMpkaKl
         D++YryJXtQLMOG3WOoLXJ9ldn9rPkw/YlfbDzgtgLZQmaZqtcLcdeQa0TeW0gqO2QNTH
         jq0p5DjRevgzzYHTzlirXnoa0Ko7nRRQoN8GozGc+sguMLGtjjVSAP+hthGiddIHmWpl
         CygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hV4SEbrM/cIWHspZNhYKzuHjXt0GCuMNZj9nj+83JqM=;
        b=r/Eeg+P0Tw9TyORTc44e+TyQNhfx0+XU65HQSMOsQVhMwBUpmNswCQtmBrK1cR4w59
         L3hJAbHozqPhtSL2Xx1dW2YC1g+NVfDZ7d62k46sm6jnceS6/0p+JHJOIor+M1DJbq8E
         0VQXBWthHGvBhjOwjxjqL3/qpTl+ApEi78L4VCeOoEFNOjiuf7KDfEXwyuATQF6//B7A
         Sp+EK2CRd67yw5837QTzpHcqqcTBrtiU0noefgZad++KBt/E4VeOOrueM1h9T6BUtAr0
         TQDn6r9wCE0wSXlCin/Y84hjM1IruhXISuWek6DZzLilYyZBYRowkfAT9fOI4BZZSI4v
         zUhg==
X-Gm-Message-State: AOAM533p980cSxE+YgrcrG5EgpcXABCS1Dmi3FdRnO7qhqd9mr+OAiZ5
        Ih4cH2GbUOUWyFPx+JyR2y9Yug==
X-Google-Smtp-Source: ABdhPJylFIt5cEtGoDhOoFF3X0K+8oi4lVXCQkELBUl3PeuOzt7toSBJrjXXUA6DCJh0zXLdu9LGwQ==
X-Received: by 2002:a37:a2d1:: with SMTP id l200mr4141877qke.237.1604621584929;
        Thu, 05 Nov 2020 16:13:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r204sm2186885qka.122.2020.11.05.16.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:13:04 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kapNH-000YyW-NU; Thu, 05 Nov 2020 20:13:03 -0400
Date:   Thu, 5 Nov 2020 20:13:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v8 3/5] RDMA/uverbs: Add uverbs command for dma-buf based
 MR registration
Message-ID: <20201106001303.GL36674@ziepe.ca>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-4-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604616489-69267-4-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 02:48:07PM -0800, Jianxin Xiong wrote:

> +	ret = ib_check_mr_access(access_flags);
> +	if (ret)
> +		return ret;

This should also reject unsupportable flags like ACCESS_ON_DEMAND and
HUGETLB

> +
> +	mr = pd->device->ops.reg_user_mr_dmabuf(pd, offset, length, virt_addr,
> +						fd, access_flags,
> +						&attrs->driver_udata);
> +	if (IS_ERR(mr))
> +		return PTR_ERR(mr);
> +
> +	mr->device  = pd->device;
> +	mr->pd      = pd;
> +	mr->type    = IB_MR_TYPE_USER;
> +	mr->uobject = uobj;
> +	atomic_inc(&pd->usecnt);

Fix intending when copying code please

> +
> +	uobj->object = mr;

Also bit surprised this works at all, it needs to call

  uverbs_finalize_uobj_create()

Right here.

Seems like the core code is missing some check that the API is being
used properly.

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
> +
> +	return ret;
> +}
> +
>  DECLARE_UVERBS_NAMED_METHOD(
>  	UVERBS_METHOD_ADVISE_MR,
>  	UVERBS_ATTR_IDR(UVERBS_ATTR_ADVISE_MR_PD_HANDLE,

> @@ -253,6 +364,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_MR)(
>  DECLARE_UVERBS_NAMED_OBJECT(
>  	UVERBS_OBJECT_MR,
>  	UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
> +	&UVERBS_METHOD(UVERBS_METHOD_REG_DMABUF_MR),
>  	&UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
>  	&UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
>  	&UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),

I trie to keep these sorted, but I see it has become unsorted. You can
re-sort it in this patch

Jason
