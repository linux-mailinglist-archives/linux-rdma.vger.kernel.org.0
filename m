Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32ACE7616
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbfJ1Q16 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:27:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35965 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbfJ1Q16 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:27:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so9047522qkc.3
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNfdPF7ys2aei9JlpbTt9ok2GPKHEVeVxQtWXAW3m50=;
        b=eiKTVchux22WoiWzzjlUOjrMTqH0CLnfqHiR/ePeX9dkl64BYK0jnUdQVq6EHlCyiT
         FcxQjJ4LGn4d4loZtrqr8xDVioWoabPSMN1P3fQFL2HaxUxZxA0OIPgMai8jBqo8KCMn
         Ikjw+uzvrvra5Xe+9TgTe7+awzd8CiZbV20etN3gEyV11HPH+OnnLVXM+8sMs/UfumAD
         oOEfz2ueU0lRFn8/ySmZ4hE1QxjY4PQKoZg+HFvN2gz3sF0OEGu/+6FDXuW1zZJwqjWv
         eLxyegxmkqXkT/Uylh74bkc2nw6xxFn5+YexdegfkWRHZtSqySnzlsYWjTsjYn5hf9w0
         wanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNfdPF7ys2aei9JlpbTt9ok2GPKHEVeVxQtWXAW3m50=;
        b=OK5B0t40Qm2FPLJGdm/OTgZExPrGgwTBIqGm2oJmPJodDaxo56zHX0UeFvPIjce0P4
         znXH9Nd4bnZlBKw8sqF8eIuLANtf2qEEBlGYw/94TnwXA8kWNRlXKoZjHJhhdKu1FfZk
         wPl8Ok+2efnIxnRTdegfjhjF1CmjKBhngs4EjotI13SUgtjpkcPB6/TKcIXoeJwsJO17
         vPgobCBT9nZoHlawW557ZNlqjPaE7PBDC7cxwy77fh06q7WiFlL/Y+SnjqYXfEJs95Ck
         0x2sSBgHUmF8B6CUtmJKIuY7kZnMzJQZZNfLZBgXQRBsTNavLEIch5aaPxaktwZ9syX3
         mvqg==
X-Gm-Message-State: APjAAAURGdl2gAmN+Fo5ESn2SXTyUdueHMuxtYKf0kAz9oifnehnRZE8
        R/+h6Lb04DygO9UiFNc6TVM9uXnDXzg=
X-Google-Smtp-Source: APXvYqzzhnzXfy/uZ5uT0tmBGJ4bZsJVJjn17/KQ4JTGqUf3+ngkuh28THl1Hiv7BH7Ez2W/E7wdrg==
X-Received: by 2002:a37:4253:: with SMTP id p80mr16879308qka.194.1572280077472;
        Mon, 28 Oct 2019 09:27:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k17sm8981547qtk.7.2019.10.28.09.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:27:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP7s4-0004Jf-H5; Mon, 28 Oct 2019 13:27:56 -0300
Date:   Mon, 28 Oct 2019 13:27:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH v2] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Message-ID: <20191028162756.GA16475@ziepe.ca>
References: <20191022200642.22762-1-aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022200642.22762-1-aditr@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 08:06:50PM +0000, Adit Ranadive wrote:
> @@ -195,7 +198,9 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  	union pvrdma_cmd_resp rsp;
>  	struct pvrdma_cmd_create_qp *cmd = &req.create_qp;
>  	struct pvrdma_cmd_create_qp_resp *resp = &rsp.create_qp_resp;
> +	struct pvrdma_cmd_create_qp_resp_v2 *resp_v2 = &rsp.create_qp_resp_v2;
>  	struct pvrdma_create_qp ucmd;
> +	struct pvrdma_create_qp_resp qp_resp = {};
>  	unsigned long flags;
>  	int ret;
>  	bool is_srq = !!init_attr->srq;
> @@ -260,6 +265,15 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
>  				goto err_qp;
>  			}
>  
> +			/* Userspace supports qpn and qp handles? */
> +			if (dev->dsr_version >= PVRDMA_QPHANDLE_VERSION &&
> +			    udata->outlen != sizeof(qp_resp)) {

Is != really what you want? Or is <= better? != means you can't ever
make qp_resp bigger.

> +	if (!qp->is_kernel) {
> +		if (udata->outlen == sizeof(qp_resp)) {

Same comment, this really should be min()? Didn't I mention that already?

Jason
