Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFA1D6DF3
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 01:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEQXEX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 19:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgEQXEW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 19:04:22 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8632BC061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:04:21 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id z9so3869123qvi.12
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YCr31ZrrZ9QfebhZsvfqB/z6Lo+xZgU04Qce2qDXnSM=;
        b=cdKD+dG+1bixlgMqszyzhWsDJv+tpHVnooIW0GvWGJPRwBQB2kRo77F+DZSWG4LGzv
         1RpJ/zCU27NKmqePANfDyzZokkpNP/ozrAjcYBcuDak7sCxdtqhJBPoJJvQx+AovQuqa
         hyussl7dGRaNzSilBN3pEFnnx7U7ZLbOX7rH3PNwj8kOp9WoQYoqLcKnFZo5T1IVFkaf
         liV60flv5muwOpBZq9YjOMGHg3hccRu+1nCN0jTWAHNOFkPjb5W6ZDJ9b3/vXgXPtPRA
         MjzFPbAKQrUuGdZSrYscTrEOaRCpd5AM7g4FNStl/OUx/UTFRegIFGuX2VKhaR4veh6w
         vWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCr31ZrrZ9QfebhZsvfqB/z6Lo+xZgU04Qce2qDXnSM=;
        b=WfqyfNidWTGmAbK4lpRZYTseYaz9X/BY05TvQUWvlJUCwIOZwwWWUPFvCrBGblt85P
         cLnr6r3ezlvA6iVz+755cLnPYEy6NjXhOElzakmvll7TZA1gvcGqhbuK/WUVLM+kto+s
         rUd7bzIukXat4TA0UUduuvqtQYHQUPq9LlNqRcYTPRsyDUlAYeLLzQh8j41S3M7ZndwG
         Uy9qgOZ2iz60UNIkXR9+yfK8eZQA6IHZHibp/rosB1ixWvx057HF38ul0AyF8soeXpi6
         qLT1URf7lBc2fHu534WeMoC801dV/WUX9jdgqh0zLeUo7yV+QDMUGy6Qy+rnuQXSeZ2Y
         VgvQ==
X-Gm-Message-State: AOAM533DCSyKN5ZwidyI2U1HEBzIuinfNrHKdvbIqx22V64n9285E7N1
        mJ4JvL47D9EQh4OgOMSnuBT1mw==
X-Google-Smtp-Source: ABdhPJzBhBEAxegzRqPIzehBYEvW9sxiV7ZrtBmDrPSmuwQ78UJjHk9wakmAfe7Azrc6Q78JKBJHQg==
X-Received: by 2002:a0c:c603:: with SMTP id v3mr13705011qvi.82.1589756660765;
        Sun, 17 May 2020 16:04:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 67sm42496qkg.51.2020.05.17.16.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:04:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSKR-0008JP-R9; Sun, 17 May 2020 20:04:19 -0300
Date:   Sun, 17 May 2020 20:04:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 07/10] IB/uverbs: Introduce create/destroy
 SRQ commands over ioctl
Message-ID: <20200517230419.GA31678@ziepe.ca>
References: <20200506082444.14502-1-leon@kernel.org>
 <20200506082444.14502-8-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506082444.14502-8-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 11:24:41AM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/uverbs_std_types_srq.c b/drivers/infiniband/core/uverbs_std_types_srq.c
> new file mode 100644
> index 000000000000..d74601c47d95
> +++ b/drivers/infiniband/core/uverbs_std_types_srq.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2020, Mellanox Technologies inc.  All rights reserved.
> + */
> +
> +#include <rdma/uverbs_std_types.h>
> +#include "rdma_core.h"
> +#include "uverbs.h"
> +
> +static int uverbs_free_srq(struct ib_uobject *uobject,
> +		    enum rdma_remove_reason why,
> +		    struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_srq *srq = uobject->object;
> +	struct ib_uevent_object *uevent =
> +		container_of(uobject, struct ib_uevent_object, uobject);
> +	enum ib_srq_type srq_type = srq->srq_type;
> +	int ret;
> +
> +	ret = ib_destroy_srq_user(srq, &attrs->driver_udata);
> +	if (ib_is_destroy_retryable(ret, why, uobject))
> +		return ret;
> +
> +	if (srq_type == IB_SRQT_XRC) {
> +		struct ib_usrq_object *us =
> +			container_of(uevent, struct ib_usrq_object, uevent);

Why is this here? The uobject can't be something other than an
ib_usrq_object, so the above uevent should be just

        struct ib_usrq_object *us =
			container_of(uobject, struct ib_usrq_object, uevent.object);

And the other bits simplified

> +static int UVERBS_HANDLER(UVERBS_METHOD_SRQ_CREATE)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_usrq_object *obj = container_of(
> +		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_CREATE_SRQ_HANDLE),
> +		typeof(*obj), uevent.uobject);
> +	struct ib_pd *pd =
> +		uverbs_attr_get_obj(attrs, UVERBS_ATTR_CREATE_SRQ_PD_HANDLE);
> +	struct ib_srq_init_attr attr = {};
> +	struct ib_uobject *uninitialized_var(xrcd_uobj);

Why do we need uninitalized_var? Looks like it should be fine to me

Jason
