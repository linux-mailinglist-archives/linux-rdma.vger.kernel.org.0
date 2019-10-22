Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07DEE0B94
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 20:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfJVSlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 14:41:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40661 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732615AbfJVSlL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 14:41:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id o49so20469558qta.7
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bF9K7Bd9BrzzMLmMrrO2HSAwcPu6dNqSFJ59SdGCcdc=;
        b=hUqrSk3F2J3Z8zY9lRzqLgcqiBlMJq/h0fGcZwZg2lGeEi1NZ6pmv7rS5TI8fveK0c
         p6Yl+F1AkuwmmT0uOR/eE6hhn3OOlAaQNZlXGuaJ+82hcuzay99N9bCLFpiqVepSDlyC
         aGhR2902V9sufLYEzDqPMzxj0wd4SeSxBLOlOyz1LlhAa5ue0YVhL2BYxim3uJ8gtPmS
         l/dRThDyTcBvW870OvDN2BlB+LNwUwbCTy4wucgbxrrP+yigmC348hZUW6hrC6/WBBEQ
         P+iB/GaYuq2qZaaQ+P9qnH3Rymsrdsa9bua1g/ZsxVfKsjQlLCGht70yJJcd4q6Qr4b0
         rBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bF9K7Bd9BrzzMLmMrrO2HSAwcPu6dNqSFJ59SdGCcdc=;
        b=Xw5reOluFfhx+cv41MsxAeFL+eHhGs/ATJ3BQoJ4AN1myBYq0CvqeU2kIUYh91fcJW
         RArkzlcwxt65SvmuwV4jhjd9jCuTFjVaaj7SjGFHN4KKUUtQBqxbO+RhrRlyXjPuCCyc
         1e4kpq9euiMTaTAsVcfJMfI4c0BT+HdWe4+/g5Vi+x+Lv7dh3KzGgssTvmeXmjE2MqTp
         XHSqekiDTttenMwTHQTRaATpWe4NBORB5ojVNxEOGeoZZI+42qxSKPfUpzBrbuegcBaF
         B+ffsCkjC26lVax52FdTdaw77yO5FyGTdwf/0JgBognWnglm9WI5FYqbkrDdR1C7RzNM
         9Q1Q==
X-Gm-Message-State: APjAAAXUDeLMwPnWyDgaXtHhqPTUgJzoRCJvFzzDQmO3Oo0O2eSPbuEr
        cJlR+PRt2EL/CYWnvgvRZjomAQ==
X-Google-Smtp-Source: APXvYqxad1u6C2e/cv+Tm8SJFBvz8Mt1xEFYtc9Wnpqiik7XQlAmUbuOzEjnbzLmSEm8ikvwXQ0TEw==
X-Received: by 2002:ac8:6f27:: with SMTP id i7mr4994566qtv.359.1571769670432;
        Tue, 22 Oct 2019 11:41:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a190sm11028340qkf.118.2019.10.22.11.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 11:41:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMz5h-0002GS-Er; Tue, 22 Oct 2019 15:41:09 -0300
Date:   Tue, 22 Oct 2019 15:41:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rd.dunlab@gmail.com, Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 00/12] infiniband kernel-doc fixes & driver-api/ chapter
Message-ID: <20191022184109.GA2155@ziepe.ca>
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010035239.532908118@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 09, 2019 at 08:52:39PM -0700, rd.dunlab@gmail.com wrote:
> 
> This patch series cleans up lots of kernel-doc in drivers/infiniband/
> and then adds an infiniband.rst file.
> 
> It also changes a few instances of non-exported functions from kernel-doc
> notation back to non-kernel-doc comments.
> 
> There are still a few kernel-doc and Sphinx warnings that I don't know how
> to resolve:
> 
>   ../drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
>   ../drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'

Maybe Max can help?

>   ../drivers/infiniband/core/verbs.c:2510: WARNING: Unexpected indentation.
>   ../drivers/infiniband/core/verbs.c:2512: WARNING: Block quote ends without a blank line; unexpected unindent.
>   ../drivers/infiniband/core/verbs.c:2544: WARNING: Unexpected indentation.

I don't know what to make of these either.

Anyhow, it is an overall improvement, so I applied everything but

[05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h kernel-doc notation

pending some discussion.

Thanks,
Jason
