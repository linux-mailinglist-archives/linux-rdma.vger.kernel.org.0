Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1641D6DF9
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 01:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgEQXJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgEQXJ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 19:09:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C72C061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:09:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n14so8422781qke.8
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q1AhdV+Qk2mpU/8qdiZY8P+qJspNXpjA8lDJYRxtGxE=;
        b=fyTCpyYkbrQ++dwSgHDjD006m/y0yCOSVppp9frpJ3JAs0rzhDyCqyzseB9jHXugGB
         paXBRk/ZH6WAKv+JBhkHDlfsWphu5DpiLVsOFkajBUjGiI2/7kvuOrMUJqBXu0qyfaFm
         rPcqXiQmodSuIeSEH6qbNe8fs9vzSIOypBWJ+1Nvi7FYtIqqJxZf0R81wEMuWTrMyVXM
         Ar86rSRjI+lXizvsafl5HbiW1jnNv0zWh2aqyTGuaMMZZZif2rE6og5sF7q5p9WP2UxH
         rXqXGlaXR7r1j+jkXkbios+4Dy/UdGScV8+lvl8xJjNUQ2Cm9QqMp4TQU4PrWqQ2xooG
         nr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1AhdV+Qk2mpU/8qdiZY8P+qJspNXpjA8lDJYRxtGxE=;
        b=fucbmQen3PqIOIKYs4S2WwdK9Jmb/8rIMa1zBDI+WHd44aa1C1pST7pv+bWqdFfKo0
         JlsplCBlTsHEx0/VQ996EC/xYiywanZwSjUw8qDte+YtkkHVo7DZJHhEA/tZDqGPJMLx
         UlENz2KK0wNkLJQcONcVrnEsEom6VENyuiDLzpP1/xknSp4yBRs14UNCp6A6FFRxq4+j
         PudznbfovM0/DgihhOqKzs17uzaBkcGGzxLnySoxTrm9s4BhvjfUXtXLshWtdLZ72mGr
         OtF9nQR1U6xRsj2DMTwTNaC0oRijP+BfxS/NSHW8H1VY67rw0AIW38T5NJ6XISpbQGDt
         Vjdw==
X-Gm-Message-State: AOAM533z7qK8uV9gROiRf/w0dYM3NwvsgCmC/oDSTdPbZp5+MTKGzp2T
        d/aWELlb+XqcecSxmWQthd+kkvGNNm0=
X-Google-Smtp-Source: ABdhPJzdm5C5MkF70pCgG6DK2NxhhZtt3Jwx7xqCfghZk+UpEbWhPdjW8UjqBa0bTH/0ZTBWe8Rvrw==
X-Received: by 2002:a37:27d7:: with SMTP id n206mr6165560qkn.98.1589756996481;
        Sun, 17 May 2020 16:09:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a189sm3515716qkd.52.2020.05.17.16.09.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:09:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSPr-00007L-JE; Sun, 17 May 2020 20:09:55 -0300
Date:   Sun, 17 May 2020 20:09:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 09/10] IB/uverbs: Introduce create/destroy
 WQ commands over ioctl
Message-ID: <20200517230955.GB31678@ziepe.ca>
References: <20200506082444.14502-1-leon@kernel.org>
 <20200506082444.14502-10-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506082444.14502-10-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 11:24:43AM +0300, Leon Romanovsky wrote:
> +static int UVERBS_HANDLER(UVERBS_METHOD_WQ_CREATE)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_uwq_object *obj = container_of(
> +		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_CREATE_WQ_HANDLE),
> +		typeof(*obj), uevent.uobject);
> +	struct ib_pd *pd =
> +		uverbs_attr_get_obj(attrs, UVERBS_ATTR_CREATE_WQ_PD_HANDLE);
> +	struct ib_cq *cq =
> +		uverbs_attr_get_obj(attrs, UVERBS_ATTR_CREATE_WQ_CQ_HANDLE);
> +	struct ib_wq_init_attr wq_init_attr = {};
> +	struct ib_wq *wq;
> +	u64 user_handle;
> +	int ret;
> +
> +	ret = uverbs_get_flags32(&wq_init_attr.create_flags, attrs,
> +				 UVERBS_ATTR_CREATE_WQ_FLAGS,
> +				 IB_UVERBS_WQ_FLAGS_CVLAN_STRIPPING |
> +				 IB_UVERBS_WQ_FLAGS_SCATTER_FCS |
> +				 IB_UVERBS_WQ_FLAGS_DELAY_DROP |
> +				 IB_UVERBS_WQ_FLAGS_PCI_WRITE_END_PADDING);
> +	if (!ret)
> +		ret = uverbs_copy_from(&wq_init_attr.max_sge, attrs,
> +			       UVERBS_ATTR_CREATE_WQ_MAX_SGE);
> +	if (!ret)
> +		ret = uverbs_copy_from(&wq_init_attr.max_wr, attrs,
> +				       UVERBS_ATTR_CREATE_WQ_MAX_WR);
> +	if (!ret)
> +		ret = uverbs_copy_from(&user_handle, attrs,
> +				       UVERBS_ATTR_CREATE_WQ_USER_HANDLE);
> +	if (!ret)
> +		ret = uverbs_get_const(&wq_init_attr.wq_type, attrs,
> +				       UVERBS_ATTR_CREATE_WQ_TYPE);
> +	if (ret)
> +		return ret;
> +
> +	if (wq_init_attr.wq_type != IB_WQT_RQ)
> +		return -EINVAL;
> +
> +	obj->uevent.event_file = ib_uverbs_get_async_event(attrs,
> +					UVERBS_ATTR_CREATE_WQ_EVENT_FD);
> +	obj->uevent.uobject.user_handle = user_handle;
> +	INIT_LIST_HEAD(&obj->uevent.event_list);
> +	wq_init_attr.event_handler = ib_uverbs_wq_event_handler;
> +	wq_init_attr.wq_context = attrs->ufile;
> +	wq_init_attr.cq = cq;
> +
> +	wq = pd->device->ops.create_wq(pd, &wq_init_attr, &attrs->driver_udata);
> +	if (IS_ERR(wq)) {
> +		ret = PTR_ERR(wq);
> +		goto err;
> +	}
> +
> +	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_WQ_HANDLE);

The object should be really finalized before calling this, ie all of
this stuff:

> +	obj->uevent.uobject.object = wq;
> +	wq->wq_type = wq_init_attr.wq_type;
> +	wq->cq = cq;
> +	wq->pd = pd;
> +	wq->device = pd->device;
> +	wq->wq_context = wq_init_attr.wq_context;
> +	atomic_set(&wq->usecnt, 0);
> +	atomic_inc(&pd->usecnt);
> +	atomic_inc(&cq->usecnt);
> +	wq->uobject = obj;

Should be before. Same remark for the other patches

Jason
