Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929EB37BCD5
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhELMvT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELMvQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 08:51:16 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB5C061574
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 05:50:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x8so21989656qkl.2
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aGDyEVjLVYxD3RxzvFqUp98CimBDUTSxrfNqAqQFkrY=;
        b=N28qrbE1EJZUcGTr+fEf4KNNkr5MUNgk1Vzl4mrjuAm1+qZ/8OWSUR0ycpCkLXofU0
         6Z2Qn1gUH2awKF2Z8Yc2KkGQpi3kabZsJTNCH/E7O3EurvsVVJK8THOO2g/kXWwo7D+s
         77op02W6qhDnIT+X6LAkbu05qTQI0KLtVkJm261Ypa8U/yi6kkO9dGro+PicJVfjtJc9
         wZQSXdFeDffACXxcVDuiDPPT/pB4WGjWoZzrGNYs4Eh9YnhSMEMXyzaD/KcVhY+k0t7a
         E0ijhSY7xkk+Mb07GzSXyWeL+wIY6oxBCSDNButCoPncHL66WiU6YGQ9Xus5+tRnUPhQ
         4Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGDyEVjLVYxD3RxzvFqUp98CimBDUTSxrfNqAqQFkrY=;
        b=gOy9ZL0K8ZR+/6f6GipheFb63mIp0OJiaKMLC/P2kpTuRcCGMh/Iv45gE+hrna3tZ9
         y+o1YKktdqti/ELVUHF6WmcMAvcmRll+q4r9mCjptIeOS0GLJ+coiGsA6Ala40C3Bc7p
         IjV/MBjDIds2m2wRMMaqu0LP335Xc3ofHwK109lj9IiUxzFPShwxUB/YesTTRF4stlrH
         GZauD/0B++mAYL42omA+q5bECnEPIsEt6sEpOtIvcOlP6gTOyavTsDgPDHm/4tuCiSEx
         9GrgthT0ulHJsU28ntI8Om9U8pAOh69sWQeeYSgpzuM+IDcINO0QyuKCRSshkqcfscO3
         7s4A==
X-Gm-Message-State: AOAM530G01z71/SLG6CnAuSCWa+3UzCjNuHRpsAL5O6wRJGya66uFal7
        irX27OtwozRZsahUBH0+/N8yBw==
X-Google-Smtp-Source: ABdhPJyqNkoBtm2HZveKhggviLFpuOj6VosCTTPgrM24ranslH+FDqBvOYgGL4FC3NGNUM0noh2GtA==
X-Received: by 2002:a05:620a:4092:: with SMTP id f18mr32279713qko.63.1620823807881;
        Wed, 12 May 2021 05:50:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id h8sm8110025qtp.46.2021.05.12.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:50:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lgoJS-005pax-Vy; Wed, 12 May 2021 09:50:07 -0300
Date:   Wed, 12 May 2021 09:50:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RDMA/cm: Optimise rbtree searching
Message-ID: <20210512125006.GE1096940@ziepe.ca>
References: <20210512100537.6273-1-thunder.leizhen@huawei.com>
 <20210512100537.6273-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512100537.6273-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 06:05:37PM +0800, Zhen Lei wrote:
>  static struct cm_id_private *cm_find_listen(struct ib_device *device,
> @@ -686,22 +687,23 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>  
>  	while (node) {
>  		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
> -		if ((cm_id_priv->id.service_mask & service_id) ==
> -		     cm_id_priv->id.service_id &&
> -		    (cm_id_priv->id.device == device)) {
> -			refcount_inc(&cm_id_priv->refcount);
> -			return cm_id_priv;
> -		}
> +
>  		if (device < cm_id_priv->id.device)
>  			node = node->rb_left;
>  		else if (device > cm_id_priv->id.device)
>  			node = node->rb_right;
> +		else if ((cm_id_priv->id.service_mask & service_id) == cm_id_priv->id.service_id)
> +			goto found;
>  		else if (be64_lt(service_id, cm_id_priv->id.service_id))
>  			node = node->rb_left;
>  		else
>  			node = node->rb_right;
>  	}

This is not the pattern I showed you. Drop the first patch and rely on
the implicit equality in the final else.

Jason
