Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6241B37BFE7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhELO14 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhELO1z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 10:27:55 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A4C061574
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 07:26:47 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id l129so22317288qke.8
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wxN06JjJ6XnpJCDuxr2U67h/cndLQfTctCEklsgpTSY=;
        b=h1RZFQYljL7P0OHrCaDb6HgIQdDL6Zw15gvCpNlnmu30OdSCSl5caH27EaguSqVJwL
         FvJaxo7ySuGDcRiU4wCDYmYQtiCcFWgXRcIIMjUOzowJqFdj9dAbu/AZeamD6FMDcwao
         YpgWvLXWXZ0TCNXvPQrVaM2qeYnEbKasOpk4wXCXQqdjseBJdv//mbn27v73hB8bb20G
         Of7b8T4rDNaUn36KmKR+deTuyxgMkHaG4+Yro4UTtr1MP1jQnYYT+x+K3BzReoZyamWF
         jhcCLWcTCRRmYOOt+QM+yJFubNUbYWPvxapgYDJa7TKNTCf/sLmkrdCzswoo8bDSGFyL
         QZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wxN06JjJ6XnpJCDuxr2U67h/cndLQfTctCEklsgpTSY=;
        b=rUAV6kO6Pd/u0Hf+YlM8OvqKES+6/plc7xRM3d38J/P2QYxnHcmONPSWxmdgjFHh1A
         2uwwnOLR75D7xFmjQ9EiwExga7UD/sZ6pFCOPmf/0bd8ACxlOsE+yqHw1X6FgzVIsMmw
         MmKjC/3ljT8/lq/rfCe5NqXG2pmOf7rLz1d64asvFpcOEbwAFy8gQspS77a/fgu+9eHu
         j26D7MYz2V+b/l4xcMywzdyYwsnKb71rZGaRRXpzZCCnEKot2aCbTfPhoQCIfIRk8+sp
         OfMud0VOXzu+fwRhBATmo3I207r1X8+s61rH73++Lb6SNUD/8NxNAgSTqfW6Lr5kg7iu
         iG3w==
X-Gm-Message-State: AOAM5334xe0MY6W6GoC/xn5HRUlZceLkDFPdHU3g1Xuz1Nt7vPg7j4a3
        ESXoSozJU+plAp1Vq5FNa+JOig==
X-Google-Smtp-Source: ABdhPJzPqqMsYDv236LsadB0eeUZqR0pX2QlPILuajH9dP/LbpfNHhFRddrgwftwOeLdxYMlsz8DMQ==
X-Received: by 2002:a37:ef05:: with SMTP id j5mr9602108qkk.203.1620829607000;
        Wed, 12 May 2021 07:26:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id j9sm119211qtl.15.2021.05.12.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:26:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lgpoz-005rA5-PA; Wed, 12 May 2021 11:26:45 -0300
Date:   Wed, 12 May 2021 11:26:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RDMA/cm: Optimise rbtree searching
Message-ID: <20210512142645.GF1096940@ziepe.ca>
References: <20210512100537.6273-1-thunder.leizhen@huawei.com>
 <20210512100537.6273-3-thunder.leizhen@huawei.com>
 <20210512125006.GE1096940@ziepe.ca>
 <afb85ebf-4b76-d5e7-847a-14461bcf7310@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb85ebf-4b76-d5e7-847a-14461bcf7310@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 09:12:08PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/5/12 20:50, Jason Gunthorpe wrote:
> > On Wed, May 12, 2021 at 06:05:37PM +0800, Zhen Lei wrote:
> >>  static struct cm_id_private *cm_find_listen(struct ib_device *device,
> >> @@ -686,22 +687,23 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
> >>  
> >>  	while (node) {
> >>  		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
> >> -		if ((cm_id_priv->id.service_mask & service_id) ==
> >> -		     cm_id_priv->id.service_id &&
> >> -		    (cm_id_priv->id.device == device)) {
> >> -			refcount_inc(&cm_id_priv->refcount);
> >> -			return cm_id_priv;
> >> -		}
> >> +
> >>  		if (device < cm_id_priv->id.device)
> >>  			node = node->rb_left;
> >>  		else if (device > cm_id_priv->id.device)
> >>  			node = node->rb_right;
> >> +		else if ((cm_id_priv->id.service_mask & service_id) == cm_id_priv->id.service_id)
> >> +			goto found;
> >>  		else if (be64_lt(service_id, cm_id_priv->id.service_id))
> >>  			node = node->rb_left;
> >>  		else
> >>  			node = node->rb_right;
> >>  	}
> > 
> > This is not the pattern I showed you. Drop the first patch and rely on
> > the implicit equality in the final else.
> 
> Do you mean treate the "found" process as the else branch?
> 
> But ((cm_id_priv->id.service_mask & service_id) ==
> cm_id_priv->id.service_id) is different from (service_id ==
> cm_id_priv->id.service_id),I'm just worried that it might change
> the original logic.

The service_mask is always ~cpu_to_be64(0), it is some non-working
dead code that has been left in here.

If you really want to touch this then you should have a prep patch to
remove that entire API facet, then the above will make sense.

Jason
