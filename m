Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8842CB93
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE1QQ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 12:16:27 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35293 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1QQ1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 12:16:27 -0400
Received: by mail-ua1-f67.google.com with SMTP id r7so5936930ual.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2019 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2tGx4eDekS0xMmLSo4rQWzrbiYIjfV9w6yX4VOt/Fns=;
        b=g2fb3rYK6xZdf9ipwYQP7EkLCCwonE/viFisUadCgMo/YlgPNqaKyek09RRIF4/okm
         MSfCx2SynoyimsaUt1ja0Wudsk4Xkx6z0EL8LhkQsdwNV03LkKkLjTRkE/DI4tDwCgJz
         5fuUp5g9KwcsiK7nA9rH15XedBdiUaFwsS+me/cjPFWizLWz/NPT+Cl+W/fXu5OMsKH+
         1SVh+vfKXitpJZSBVaZVq2cma+615M8oBwA3eczgiz+SbJ32Z50IRQDTfz8R0aZbhiea
         jImorSeJjI7xnG5ozGJiK+5Jc8StJMq+eF2ohPkaPQ6gR+II+UO/t0mtmkpChLZB/efG
         fwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tGx4eDekS0xMmLSo4rQWzrbiYIjfV9w6yX4VOt/Fns=;
        b=KknFhKwt+MeWde7w70Y2XqAH70iHNHa7OEHj5ukCgM6xiPul1NzqE6ftmkyDlws+uN
         QNk84Myh5cfex2vJC9uSWWWf/gaSFR+Cgv9ENPL94FycqzDZr6FTlXiMqBHShViwHkB8
         xdB4sA/9N65CGC1oM9JT51mFQGSq3hERgjP9YCo9kKpCdwHKEmyWX9dSameSSGG1Vr6K
         MGZEPsShiPbXWCbvoUp2VsP2a6ed+YYcJKLFXo5bVkP2vQxCkdnVZWyKPdHyz0B0fZbK
         nnQOvPRUsih0fx6GXA4qswLjOsKHv+k8PDSnXiQtCBR8SS0tUZjr9H/JPjqTUJAkaduX
         HLIQ==
X-Gm-Message-State: APjAAAXhWxUPT8NPCwf9bBW/QK58ps6r/IPh4FFfNdoPCUJapEbwmvAm
        iTa/eTbCfgEG8PttG/vFqaUTQA==
X-Google-Smtp-Source: APXvYqxO000c9ZsbeM358Kjukf7ibmzZo56pERd9b1IfasrXA+HzB0TtaAOmQu0PTH6FyJg5QNBb4w==
X-Received: by 2002:ab0:c11:: with SMTP id a17mr48118433uak.3.1559060186118;
        Tue, 28 May 2019 09:16:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x19sm5342138vsq.9.2019.05.28.09.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 09:16:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVem0-0001KY-Pc; Tue, 28 May 2019 13:16:24 -0300
Date:   Tue, 28 May 2019 13:16:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, jgg@zeipe.ca, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Add doorbell overflow
 recovery support
Message-ID: <20190528161624.GB31301@ziepe.ca>
References: <20190528112401.14958-1-michal.kalderon@marvell.com>
 <20190528112401.14958-2-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528112401.14958-2-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 02:24:00PM +0300, Michal Kalderon wrote:

> +static int qedr_init_user_db_rec(struct ib_udata *udata,
> +				 struct qedr_dev *dev, struct qedr_userq *q,
> +				 u64 db_rec_addr, int access, int dmasync)
> +{
> +	/* Aborting for non doorbell userqueue (SRQ) */
> +	if (db_rec_addr == 0)
> +		return 0;
> +
> +	q->db_rec_addr = db_rec_addr;
> +	q->db_rec_umem = ib_umem_get(udata, q->db_rec_addr, PAGE_SIZE,
> +				     access, dmasync);
> +
> +	if (IS_ERR(q->db_rec_umem)) {
> +		DP_ERR(dev,
> +		       "create user queue: failed db_rec ib_umem_get, error was %ld, db_rec_addr was %llx\n",
> +		       PTR_ERR(q->db_rec_umem), db_rec_addr);
> +		return PTR_ERR(q->db_rec_umem);
> +	}
> +
> +	q->db_rec_page = sg_page(q->db_rec_umem->sg_head.sgl);
> +	q->db_rec_virt = kmap(q->db_rec_page);

Is this something new? You are much better to use user-triggered mmap
to get a shared page than to use long term kmap.

>  		cq->ibcq.cqe = chain_entries;
> +		cq->q.db_addr = (void __iomem *)(uintptr_t)ctx->dpi_addr +
> +			db_offset;

Seems like something has gone wrong here if you have to type __iomem
like this

Jason
