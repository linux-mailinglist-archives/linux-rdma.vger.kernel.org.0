Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7752851B7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgJFSj4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFSj4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 14:39:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8ADC061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 11:39:56 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q63so17810617qkf.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/gKZPzEzmUaLNLWDQohRTD7N7F0WZxuEudgU4fG6BK0=;
        b=TjuIul2y12cxaC+nx35hsvfRjMtRzZmz+Ntv5TcJ08RqjtFmRO9Kg9FnN5LCWZ/WTf
         bRX57LNp+9G3PW2PAmd6LI6ER9+cwduISQBf5/ZV/4HHC+7psnSuyIPYECRp99Y/zgdv
         ueFeCch1FcpLRHjza3C5CIUh5NVHkARpJ1+1xp13WReR+1s5oiVnrjPU9MbYLuniiHgR
         iGXfKapSISVgBSUjHswhgb9bBq2aLcyrtoIgOysMYm0Xovao5TyJLuM9PdT4vjibWZxL
         9pHdOaA46NitvtG4VJdvhdGos+9gejPF5dp4izdLDxjc55L9V5TnyZwyNq7zccC+vhwd
         qxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gKZPzEzmUaLNLWDQohRTD7N7F0WZxuEudgU4fG6BK0=;
        b=AXmsaLP2v5qWazBMWxbTaSKhI5dqd5fIdtxOVqXUOGDx0gQWiZkHa4zTEmtUj7cx9N
         Qs0jRw0aTMHQMUWSGRj4mztOX7fvyWuIGo0NrdsO8h2aWrFLFqLX1WmHQBluxrrBZxWZ
         5XkocDAfH3+x0fk44Mz+/aTzQB6Os+1FL/yh2wHyfVoF2LJgPi7jj9wVggz90h+6DwsU
         Njh989P1ZCC0gc+0XTq08rAf5rsTI9Qg87s2GkwLigxh9HOVXG+PUOHCQ9DibpPNNa+i
         Lgqxu92P7JT+A03d9RzOG2RFcmWT9J/9rjRkesVPs4BLdFOObNsb8/z2PMu62B7Qocth
         iynw==
X-Gm-Message-State: AOAM530ghg2NmklOVdC41UcKW7cchY+77wZjENnuEu6+/nCpz+jYddcS
        BOgp5rofKW8O7H8XscddISNnsA==
X-Google-Smtp-Source: ABdhPJwRuY6qF/7rvPE2hz9EihLZjkuGjzgEMUBdQPbIhiHrTpeiMfu+MD92e+Rd0mmy6JK1bw4Giw==
X-Received: by 2002:a05:620a:a45:: with SMTP id j5mr6992897qka.367.1602009595593;
        Tue, 06 Oct 2020 11:39:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o5sm2974621qtt.3.2020.10.06.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:39:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPrsQ-000d6X-Df; Tue, 06 Oct 2020 15:39:54 -0300
Date:   Tue, 6 Oct 2020 15:39:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201006183954.GL5177@ziepe.ca>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org>
 <20200923183409.GA9475@nvidia.com>
 <20200924054907.GA22045@infradead.org>
 <20200924114940.GE9475@nvidia.com>
 <f20a4639-7674-8d2c-66dc-ebc028b14ef0@acm.org>
 <20201006165346.GK4734@nvidia.com>
 <05c0f5fd-e1cd-0a02-8464-b18497b23341@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c0f5fd-e1cd-0a02-8464-b18497b23341@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 11:22:26AM -0700, Bart Van Assche wrote:

> The patch "RDMA/core: Set DMA parameters correctly" was the result of source reading
> while I was chasing an unrelated rdma_rxe bug.

Okay, then we can drop it off safely thanks

Jason
