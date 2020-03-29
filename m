Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D9196DDB
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgC2ORP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 10:17:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40230 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgC2ORO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Mar 2020 10:17:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id l25so16248908qki.7
        for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2020 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7kwXlsbPgsaF/1H7oDNGC6sTEozUX2jrMBobuQbfQs=;
        b=moQTc+GEUyEhv1/EsHg5b1SaNqXPJ3iUkV1W6PnmiwO0Bwll9aB648ukuvfdi7hoPB
         jlFQz2Z1e7ZUTvGw5hvcKIWprzoEgNtMc2k6qsMsDcScfPB1DlN17k3yzBNzd+kLu4Eq
         QFfG22C/6y0kT3UC6wg7EO5qe4L7pZ2nWFr+BXsEQeJIaSm4HAc2vHZ4qKatg4rMlzW2
         t4LJdjIt7EMNezeXtr0k2JV2C7stxBJArrc/f/gYT61NE0SWTrgZSEvTDHqI9l2ndD9j
         gb87fYC4enERFUO/vwKU+QMABL61xkJMJXGD57NYYjrk40+3+6iSqV02CPWRGLHvQbd7
         MATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7kwXlsbPgsaF/1H7oDNGC6sTEozUX2jrMBobuQbfQs=;
        b=rDCicA7ikCgmmLU2DXh3Zm6MVOKL5/Kr+kuXtC+EJnG/CFEa3NbovmTRDZC6Sc2dnZ
         qzjTP9V1it+yAFNSD8GHkoITASlnXtFcdrHZN5YWT/atOFpG18DkxI/rKZ6Z/wrX4i8F
         +ceulLa5cLrvedwqXdvFVGs3t76/F6KxTp/quE/T/6uaF+ULX8bqNq8kffrWwyqD5Mf3
         s37MSkQ6ULzl4/Cszdu4C96qHH3cbPPlN4GjYrZJ60456ghIQ0hAdZhJqy0NQHA1I94w
         i/PxVDnfsYhOwvNk0A2A/z0frl2ntRhOxOvZ5PdO1T2B47xTQ/USfxvrRMv/JXTBFUMN
         fuMw==
X-Gm-Message-State: ANhLgQ1P8FTjjDEfRambA0UKAgWz4AOy3DPDmqpPCsqp3FxdHn+qCoi9
        vk/9As2/CC64PL/1IXMJskVz5w==
X-Google-Smtp-Source: ADFU+vsJOpDt21YEkie2NVYFJBRBjfE5TOFEA2zgyhEUFzbEjULkhVPErB0d/YM8U2/X84FdHF82Qg==
X-Received: by 2002:a37:bc81:: with SMTP id m123mr7567773qkf.319.1585491431782;
        Sun, 29 Mar 2020 07:17:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q34sm8883588qtb.41.2020.03.29.07.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 07:17:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIYkQ-0000OJ-IL; Sun, 29 Mar 2020 11:17:10 -0300
Date:   Sun, 29 Mar 2020 11:17:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
Message-ID: <20200329141710.GE20941@ziepe.ca>
References: <202003281643.02SGh6eG002694@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281643.02SGh6eG002694@sdf.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 27, 2019 at 12:55:00PM -0400, George Spelvin wrote:
> I was checking the field to see if it needed the full
> get_random_bytes() and discovered it's unused.
> 
> Only compile-tested, as I don't have the hardware, but
> I'm still pretty confident.
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/hw/qib/qib_verbs.c | 2 --
>  drivers/infiniband/hw/qib/qib_verbs.h | 1 -
>  2 files changed, 3 deletions(-)

You need to do a better job sending your patches, this is not
threaded, and not cc'd to linux-rdma, so it doesn't show in the
patchworks.

In general, do not send such large series for things that are not
connected. Send small cleanups like this properly and directly so they
can be applied.

I took care of it this time, so applied to the rdma tree as it is
obviously correct.

Thanks,
Jason
