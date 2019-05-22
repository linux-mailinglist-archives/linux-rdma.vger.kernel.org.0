Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCD26824
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfEVQYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 12:24:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38136 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfEVQYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 12:24:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so3093868qtj.5
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wd5zSoCQkWyUnpnrNZptFGE9sLAarxmANwGIIWsgsPs=;
        b=ILzPUBWLwnq9jdNSf7NqomaUyt+M0wFZVLCo7ggo5IcyEqs9oB59Cv2ewVcpzwGUfF
         R9FpC2zCwOP1VZqSJEiNDODMMYp5Py7LPpPav6X9vf2U63d0klvtTxbaWjEl0Mr15evP
         wvL6kWrhaWqDwL0N/cOXgLhGCBDHWo4pYOPuYf+IVn+gGP3lp1xgWZEdvCxmr7RBXpZ/
         aknzb5GUvGFPFu7+TwJUXXX85i/kTJolVp7ml7Z7sE8D2FcJWXzbz7CMfri0iBegfwfT
         +PLqPsWvqGobwx7WCMI++mLguPY+JdMBL2tRaB329ve5I8UYdUBsgxhU8qfTI1OPgThZ
         S/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wd5zSoCQkWyUnpnrNZptFGE9sLAarxmANwGIIWsgsPs=;
        b=KiZUXCPMC/oMX63s5HgCeqqfPxrUTdXclT+mlBJNjIraAVp0OSlL7DnFW5gffqD73x
         gE4dck6zU/2e28+O5b68SozVwzJR8zd92JGCXPIw0kGFcGSLQBt4JBjFkhKbB6irk4MH
         oMS11lD4MYJCzicKaKll2Iw14lTtnefJQ1a1XuhSP7+6yJKmcZZr0OBYjmvNlkPRrC51
         /Tq4OUU9uNbdr7JmOO9H9/xAgpO27P+hL0BjMkFL9aNbgNYSRxq7fFR7OU6xi22uycpg
         8MDKhCjG45PoCYHJf6FWeR/PhfcId4qaiTBKJ58FecZP8C4+xkPNiMAk++zlwLjqsU/0
         TlkQ==
X-Gm-Message-State: APjAAAXBW/JhzTnNOHcohtGZHHudmxl2ud+BZH1dD0RJLyzJ8BGzYuZs
        768XI/Y5CY597wPyKJPVc0Ke1gLLcAs=
X-Google-Smtp-Source: APXvYqyjsENsgABDT5ADQgsqgVcqHjSoLqz9fu4JLrkx53A53XGGthwygvg0zQ1KmeA/63RXN2ildA==
X-Received: by 2002:ac8:7a72:: with SMTP id w18mr73173280qtt.318.1558542283671;
        Wed, 22 May 2019 09:24:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id s17sm14309396qke.60.2019.05.22.09.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 09:24:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTU2k-0000Bk-FR; Wed, 22 May 2019 13:24:42 -0300
Date:   Wed, 22 May 2019 13:24:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nirranjan Kirubaharan <nirranjan@chelsio.com>
Cc:     bharat@chelsio.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4] iw_cxgb4: Fix qpid leak
Message-ID: <20190522162442.GD6054@ziepe.ca>
References: <ecd8e5de39986704861913f2bfb70acbccf6b616.1558530087.git.nirranjan@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd8e5de39986704861913f2bfb70acbccf6b616.1558530087.git.nirranjan@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 06:27:45AM -0700, Nirranjan Kirubaharan wrote:
> In iw_cxgb4, Added wait in destroy_qp() so that all references to
> qp are dereferenced and qp is freed in destroy_qp() itself.
> This ensures freeing of all QPs before invocation of
> dealloc_ucontext(), which prevents loss of in use qpids stored
> in ucontext.
> 
> Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> v2:
> - Used kref instead of qid count.
> v3:
> - Ensured freeing of qp in destroy_qp() itself.
> v4:
> - Change c4iw_qp_rem_ref() to use a refcount not kref and trigger
> complete() when the refcount goes to 0.
> - Move all of queue_qp_free into c4iw_destroy_qp()
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  4 +--
>  drivers/infiniband/hw/cxgb4/qp.c       | 48 ++++++++++++----------------------
>  2 files changed, 19 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> index 916ef982172e..b8e90eaf4a03 100644
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -490,13 +490,13 @@ struct c4iw_qp {
>  	struct t4_wq wq;
>  	spinlock_t lock;
>  	struct mutex mutex;
> -	struct kref kref;
>  	wait_queue_head_t wait;
>  	int sq_sig_all;
>  	struct c4iw_srq *srq;
> -	struct work_struct free_work;
>  	struct c4iw_ucontext *ucontext;
>  	struct c4iw_wr_wait *wr_waitp;
> +	struct completion qp_rel_comp;
> +	atomic_t qp_refcnt;

no, refcount_t

But oterhwise OK

Jason
