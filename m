Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C095D102A5F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 18:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfKSRBo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 12:01:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46605 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKSRBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 12:01:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id r20so25327248qtp.13
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 09:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZaFK3PskGSLPaliJ+nwrcetBY1Yrt6Pcze5tR06QCzA=;
        b=RO+vcU8Tdk3NhFNDT9Y4l8O0lwdttJw5qmPJpWuVfhwOoAqc+Lt3FBIY1F+BAxdwV6
         M4sueRvv0Znf+GTM+6ghOEGf3/baLeb+o2KUMiLTYNGR7iU+6Phz+Ms4HaPUpwW8MwfP
         PRxWRReJUMbj138Z3ug6z+WMje6+Z+g6SdESxqW+4Vvp6UWtVTogd6hI2iIVXZVYK8f2
         5V+igFclvS0r52J178kDKsaDV0yEB80xyOLLHIG/hd0XL06enVuxZ+OyheIdgB6W9LWI
         Rbn4Bhg7OMvaOllDhZA2YX9eyC0nXQay6UvRtYqLZPku/7pKf7IMTIiRRvga11AwweBh
         8scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZaFK3PskGSLPaliJ+nwrcetBY1Yrt6Pcze5tR06QCzA=;
        b=hhtn6HW28JpSfRxxQmH4TqvmESpjwYS032yt7rJ4PJnx5FY3KaaD/TR/R7Qnc9HBTu
         tzuVNf/Lkqc3SJ/aZFlKWuaGh8ClEmq0r0x6uhkpJaRLpUbQsQwdbZXdOKmPcA2YXtQT
         fUvtbt4BW47NBprqwoI5WlxMef4u5TC5d3WjD7sQEBCPnsBnaIYr2nhmG86wuSHETyot
         QPyooAuO1fVZ6YZzyjI6IRQ3vzMBoxEkdMixbiLoifjFULaXzcvSXS0HHFd2GLLvdCGl
         1AjJXbnEbLqGYWfrzgYRPrx6GnG2+SHJwX7IvrSRjQnt02E95CFB/9OAOrekFOZVPuzO
         dCfA==
X-Gm-Message-State: APjAAAVJvDyDgi1NNawLrryr3uTgnOj+Fg2y1u6uxUErhGla/k/cNfAy
        1ZACqKo5vLBTUNH8PRBTKYkuiLsyuIc=
X-Google-Smtp-Source: APXvYqzTfwXWBK5AnDF99grRup2yNeA3NeivE7GXVCcmFkdr4HLbdZF8xGvHWf+WdJwFYNar5rY8Ow==
X-Received: by 2002:ac8:4901:: with SMTP id e1mr33335259qtq.280.1574182903836;
        Tue, 19 Nov 2019 09:01:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x10sm13033101qtj.25.2019.11.19.09.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 09:01:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX6sn-0001ak-Sc; Tue, 19 Nov 2019 13:01:41 -0400
Date:   Tue, 19 Nov 2019 13:01:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v6 1/2] RDMA/core: Trace points for diagnosing completion
 queue issues
Message-ID: <20191119170141.GE4991@ziepe.ca>
References: <20191118214447.27891.58814.stgit@manet.1015granger.net>
 <20191118214906.27891.14380.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118214906.27891.14380.stgit@manet.1015granger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 04:49:09PM -0500, Chuck Lever wrote:
> @@ -65,11 +68,35 @@ static void rdma_dim_init(struct ib_cq *cq)
>  	INIT_WORK(&dim->work, ib_cq_rdma_dim_work);
>  }
>  
> +/**
> + * ib_poll_cq - poll a CQ for completion(s)
> + * @cq: the CQ being polled
> + * @num_entries: maximum number of completions to return
> + * @wc: array of at least @num_entries &struct ib_wc where completions
> + *      will be returned
> + *
> + * Poll a CQ for (possibly multiple) completions.  If the return value
> + * is < 0, an error occurred.  If the return value is >= 0, it is the
> + * number of completions returned.  If the return value is
> + * non-negative and < num_entries, then the CQ was emptied.
> + */
> +int ib_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc)
> +{
> +	int rc;
> +
> +	rc = cq->device->ops.poll_cq(cq, num_entries, wc);
> +	trace_cq_poll(cq, num_entries, rc);
> +	return rc;
> +}
> +EXPORT_SYMBOL(ib_poll_cq);

Back to the non-inlined function?

Jason
