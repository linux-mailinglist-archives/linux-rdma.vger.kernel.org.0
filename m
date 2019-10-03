Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C7DCAAF8
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfJCRZr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 13:25:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45037 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389022AbfJCQQf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 12:16:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so4344414qth.11
        for <linux-rdma@vger.kernel.org>; Thu, 03 Oct 2019 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdRMIH7vJUHIekY9BSj/uEujB2XMbB890V9bYLGjtAI=;
        b=bbZpyA2sfSZ2G/Bha1AlSo9iOcnE2y05xQb75P2Zuf9cPvJ0mw5EBPbK0K9AJ0kHiw
         gkHUqMC4VUq0ZtCo1PuVfOSNmQF6VXrkRBt+TkhcwgpgIMje8+w3FAevBxmoWtccCNo7
         Y33ffHO6C5NVJU2P3JoovE6mqBjVk2HD9fWj0VGMir3dSMQ4rx0E5HAIVXfM2M4wXbBZ
         IoDYZ7RS7TObhVBtoVcdFH7Z8jnIDxZ8OAVfYJxw/OUx2AeHq07rh9OZ8Y1QSoK+0WGV
         8ujdVsblWk8b+QmC4uQ5FTH7TQhsmgszEEZhJ2M6rLQKY2Otrx484+QUNg5w9A9z36uq
         sTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdRMIH7vJUHIekY9BSj/uEujB2XMbB890V9bYLGjtAI=;
        b=IwFIdgeKgkEZ+c0YtEZxSV1rLRehj0/Si72/pJW4atlT+Kgf5S/IuFBgiqLoGE/M8T
         TfZtLIxpfv+gVJs/Y7pA6O1IYCzSVHfOcScBxF0mmxHfEl7eVqw1RnAUfjp5DZkM+bOW
         GljCDT0rvf1nwe/14teM5M7xGouAHuFCsEk8mr2b0trWI026LxzZ80jqwRSrEFw7sp8w
         eDLu8KBoZkxUs66nC0wUV/xAK76Uy6nI7cZOZiEg6q4R18R3QEJXY3aREfEyWGHREQ9m
         G8zTokNsYwPcB3Cq45CvYmzW7c1sg/3mTVf/6SWPSSDW7WoDTGfOh7lpPguR6a5Y4nZ3
         5SUQ==
X-Gm-Message-State: APjAAAVXC5Ie8tdmIpK3MngqS7AxE1UXl6aubL6PsQoq96rw5hdeQ8Jp
        FqJiLHRiy9a2/sakN9lO2j/LNQ==
X-Google-Smtp-Source: APXvYqyzZzFR49aj9DtpFD/bP45F8SvlZRgFzUhslG3qw7tX9XAEXp5IfxftMXmHYWRKi4gC9HsgEg==
X-Received: by 2002:aed:3c27:: with SMTP id t36mr10933129qte.388.1570119394693;
        Thu, 03 Oct 2019 09:16:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z141sm1462370qka.126.2019.10.03.09.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 09:16:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iG3mL-0006PS-F6; Thu, 03 Oct 2019 13:16:33 -0300
Date:   Thu, 3 Oct 2019 13:16:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     aelior@marvell.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/qedr: Fix synchronization methods and
 memory leaks in qedr
Message-ID: <20191003161633.GA15026@ziepe.ca>
References: <20191003120342.16926-1-michal.kalderon@marvell.com>
 <20191003120342.16926-2-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003120342.16926-2-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 03:03:41PM +0300, Michal Kalderon wrote:

> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index 22881d4442b9..ebc6bc25a0e2 100644
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -79,6 +79,28 @@ qedr_fill_sockaddr6(const struct qed_iwarp_cm_info *cm_info,
>  	}
>  }
>  
> +static void qedr_iw_free_qp(struct kref *ref)
> +{
> +	struct qedr_qp *qp = container_of(ref, struct qedr_qp, refcnt);
> +
> +	xa_erase_irq(&qp->dev->qps, qp->qp_id);

why is it _irq? Where are we in an irq when using the xa_lock on this xarray?


> +	kfree(qp);

[..]

> @@ -516,8 +548,10 @@ int qedr_iw_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
>  		return -ENOMEM;
>  
>  	ep->dev = dev;
> +	kref_init(&ep->refcnt);
> +
> +	kref_get(&qp->refcnt);

Here 'qp' comes out of an xa_load, but the QP is still visible in the
xarray with a 0 refcount, so this is invalid.

Also, the xa_load doesn't have any locking around it, so the entire
thing looks wrong to me.

Most probably you want to hold the xa_lock during xa_load and then use
a kref_get_not_zero - failure of the get also means the qp is not in
the xarray

Or rework things so the qp is removed from the xarray earlier, I'm not
sure.

Jason
