Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9DBE0CA3
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfJVTg1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:36:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41935 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVTg0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:36:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so17433385qkg.8
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ns3XRHOxtq+O/bg51SZjeLFs4sc1tq4on6GzvRc8kk0=;
        b=QgifcRr82RVCa9nfivcoW05/XwYKGPU0XYqval5RA+Px4UEVXFEocgIxbK2KBHTntT
         xHHCWnXv5wQYds/tMudUy8W1mdZa8kVd4uVqytyiZqkm6nvJPD5t1AgTAJAuK50vu0WC
         jF4weWeP0AXDu2IcSHBcvjxiXZHFC5ND1TRA7Alp7/IlNqOT7jilwUctRsUDRrJhHvR8
         6cwPdOpj1gxIzsa4cPqu8B3wJptCVXH4NaYWciLuXDs9Xb5lXHDIDImOiYK2GBbX1QqG
         pU9wLIAswBsSHEzWjOHeuaVAaiNEkQsUn2XtkUQUWCCUmALf1saDyv1wjpxtbqOwCQ5O
         yMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ns3XRHOxtq+O/bg51SZjeLFs4sc1tq4on6GzvRc8kk0=;
        b=fbCvblWdZYD/Q6snHkbVOJvE8i2acyBXl0UfmE6xHpT3MwjqkXhxOe01Ff9FmI6CVz
         oVic8Zxda0VYAp+BVeJmfuxHKXmi68zRLs5E8C5p327hfTTFunzuMSmC/9hIsVfTK9MW
         Z0/bny9AcPWzTR11mHRrjmJnhA95o7yU2OwQnArRHgOPjpJDynmHeZkdwNLcwwKnhNXp
         VzNetPmXxDIJIkJS44biyyrox7xHXcQN7yuXSlp6bmT7C8bjpXTT27MOpC3UdOEcSSc2
         2yb1Mbhr/8FKAr4EtLBbK+M2DYtbLY8/eh3YP+5P8URwl/nPAshD+yKleEyj4pab/ytY
         BwuQ==
X-Gm-Message-State: APjAAAVdHpkaKR2GJyGLm2M5FZcp9Bf+VCjAJiCZdxRMqiw0xGjubAJH
        kDPQnD1r38iDjoe3KSk/54gedPgg+u0=
X-Google-Smtp-Source: APXvYqwfeISwaYm9Thz6tgOQ6I354D4+5VC+UrfP41R7Qf/ZFTSjM8ImGKSM/FClZ1h5IGOQbi2NlA==
X-Received: by 2002:ae9:c302:: with SMTP id n2mr4573978qkg.69.1571772984815;
        Tue, 22 Oct 2019 12:36:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o38sm12822515qtc.39.2019.10.22.12.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:36:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzx9-00035x-PQ; Tue, 22 Oct 2019 16:36:23 -0300
Date:   Tue, 22 Oct 2019 16:36:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     aelior@marvell.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Fix synchronization methods
 and memory leaks in qedr
Message-ID: <20191022193623.GG23952@ziepe.ca>
References: <20191016114242.10736-1-michal.kalderon@marvell.com>
 <20191016114242.10736-2-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016114242.10736-2-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 16, 2019 at 02:42:41PM +0300, Michal Kalderon wrote:
> Re-design of the iWARP CM related objects reference
> counting and synchronization methods, to ensure operations
> are synchronized correctly and and that memory allocated for "ep"
> is released. (was leaked).
> Also makes sure QP memory is not released before ep is finished
> accessing it.
> 
> Where as the QP object is created/destroyed by external operations,
> the ep is created/destroyed by internal operations and represents
> the tcp connection associated with the QP.
> 
> QP destruction flow:
> - needs to wait for ep establishment to complete (either successfully
>   or with error)
> - needs to wait for ep disconnect to be fully posted to avoid a
>   race condition of disconnect being called after reset.
> - both the operations above don't always happen, so we use atomic
>   flags to indicate whether the qp destruction flow needs to wait
>   for these completions or not, if the destroy is called before
>   these operations began, the flows will check the flags and not
>   execute them ( connect / disconnect).
> 
> We use completion structure for waiting for the completions mentioned
> above.
> 
> The QP refcnt was modified to kref object.
> The EP has a kref added to it to handle additional worker thread
> accessing it.
> 
> Memory Leaks - https://www.spinics.net/lists/linux-rdma/msg83762.html
> Reported-by Chuck Lever <chuck.lever@oracle.com>
> 
> Concurrency not managed correctly -
> https://www.spinics.net/lists/linux-rdma/msg67949.html
> Reported-by Jason Gunthorpe <jgg@ziepe.ca>
> 
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>  drivers/infiniband/hw/qedr/qedr.h       |  23 ++++-
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 150 ++++++++++++++++++++++----------
>  drivers/infiniband/hw/qedr/verbs.c      |  42 +++++----
>  3 files changed, 141 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
> index 0cfd849b13d6..8e927f6c1520 100644
> +++ b/drivers/infiniband/hw/qedr/qedr.h
> @@ -40,6 +40,7 @@
>  #include <linux/qed/qed_rdma_if.h>
>  #include <linux/qed/qede_rdma.h>
>  #include <linux/qed/roce_common.h>
> +#include <linux/completion.h>
>  #include "qedr_hsi_rdma.h"
>  
>  #define QEDR_NODE_DESC "QLogic 579xx RoCE HCA"
> @@ -377,10 +378,20 @@ enum qedr_qp_err_bitmap {
>  	QEDR_QP_ERR_RQ_PBL_FULL = 32,
>  };
>  
> +enum qedr_qp_create_type {
> +	QEDR_QP_CREATE_NONE,
> +	QEDR_QP_CREATE_USER,
> +	QEDR_QP_CREATE_KERNEL,
> +};
> +
> +enum qedr_iwarp_cm_flags {
> +	QEDR_IWARP_CM_WAIT_FOR_CONNECT    = BIT(0),
> +	QEDR_IWARP_CM_WAIT_FOR_DISCONNECT = BIT(1),
> +};
> +
>  struct qedr_qp {
>  	struct ib_qp ibqp;	/* must be first */
>  	struct qedr_dev *dev;
> -	struct qedr_iw_ep *ep;
>  	struct qedr_qp_hwq_info sq;
>  	struct qedr_qp_hwq_info rq;
>  
> @@ -395,6 +406,7 @@ struct qedr_qp {
>  	u32 id;
>  	struct qedr_pd *pd;
>  	enum ib_qp_type qp_type;
> +	enum qedr_qp_create_type create_type;
>  	struct qed_rdma_qp *qed_qp;
>  	u32 qp_id;
>  	u16 icid;
> @@ -437,8 +449,11 @@ struct qedr_qp {
>  	/* Relevant to qps created from user space only (applications) */
>  	struct qedr_userq usq;
>  	struct qedr_userq urq;
> -	atomic_t refcnt;
> -	bool destroyed;
> +
> +	/* synchronization objects used with iwarp ep */
> +	struct kref refcnt;
> +	struct completion iwarp_cm_comp;
> +	unsigned long iwarp_cm_flags; /* enum iwarp_cm_flags */
>  };
>  
>  struct qedr_ah {
> @@ -531,7 +546,7 @@ struct qedr_iw_ep {
>  	struct iw_cm_id	*cm_id;
>  	struct qedr_qp	*qp;
>  	void		*qed_context;
> -	u8		during_connect;
> +	struct kref	refcnt;
>  };
>  
>  static inline
> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index 22881d4442b9..26204caf0975 100644
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct qed_iwarp_cm_info *cm_info,
>  	}
>  }
>  
> +static void qedr_iw_free_qp(struct kref *ref)
> +{
> +	struct qedr_qp *qp = container_of(ref, struct qedr_qp, refcnt);
> +
> +	xa_erase(&qp->dev->qps, qp->qp_id);

This probably doesn't work right because qp_id is not derived from the
xa_array, but some external entity.

Thus the qp_id should be removed from the xarray and kref put'd right
before the qp_id is deallocated from the external manager.

Ie you want to avoid a race where the qp_id can be re-assigned but the
xarray entry hasn't been freed by its kref yet. Then it would
xa_insert and fail.

Also the xa_insert is probably not supposed to be the _irq version
either.

> @@ -224,13 +249,18 @@ qedr_iw_disconnect_event(void *context,
>  	struct qedr_discon_work *work;
>  	struct qedr_iw_ep *ep = (struct qedr_iw_ep *)context;
>  	struct qedr_dev *dev = ep->dev;
> -	struct qedr_qp *qp = ep->qp;
>  
>  	work = kzalloc(sizeof(*work), GFP_ATOMIC);
>  	if (!work)
>  		return;
>  
> -	qedr_iw_qp_add_ref(&qp->ibqp);
> +	/* We can't get a close event before disconnect, but since
> +	 * we're scheduling a work queue we need to make sure close
> +	 * won't delete the ep, so we increase the refcnt
> +	 */
> +	if (!kref_get_unless_zero(&ep->refcnt))
> +		return;

The unless_zero version should not be used without some kind of
locking like this, if you have a pointer to ep then ep must be a valid
pointer and it is safe to take a kref on it.

If there is a risk it is not valid then this is racy in a way that
only locking can fix, not unless_zero

> @@ -476,6 +508,19 @@ qedr_addr6_resolve(struct qedr_dev *dev,
>  	return rc;
>  }
>  
> +struct qedr_qp *qedr_iw_load_qp(struct qedr_dev *dev, u32 qpn)
> +{
> +	struct qedr_qp *qp;
> +
> +	xa_lock(&dev->qps);
> +	qp = xa_load(&dev->qps, qpn);
> +	if (!qp || !kref_get_unless_zero(&qp->refcnt))
> +		qp = NULL;

See, here is is OK because qp can't be freed under the xa_lock.

However, this unless_zero also will not be needed once the xa_erase is
moved to the right spot.

> +		/* Wait for the connection setup to complete */
> +		if (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_CONNECT,
> +				     &qp->iwarp_cm_flags))
> +			wait_for_completion(&qp->iwarp_cm_comp);
> +
> +		if (test_and_set_bit(QEDR_IWARP_CM_WAIT_FOR_DISCONNECT,
> +				     &qp->iwarp_cm_flags))
> +			wait_for_completion(&qp->iwarp_cm_comp);
>  	}

These atomics seem mis-named, and I'm unclear how they can both be
waiting on the same completion?

> @@ -2490,11 +2488,11 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>  
>  	qedr_free_qp_resources(dev, qp, udata);
>  
> -	if (atomic_dec_and_test(&qp->refcnt) &&
> -	    rdma_protocol_iwarp(&dev->ibdev, 1)) {
> -		xa_erase_irq(&dev->qps, qp->qp_id);

This is probably too late, it should be done before the qp_id could be
recycled.

Jason
