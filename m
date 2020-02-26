Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847BE170581
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 18:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgBZRHX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 12:07:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44194 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgBZRHW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 12:07:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id f140so68989qke.11
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJXj8DxHphvulR2gCvno0W04q2u7Wkypz7ZH4wJylqE=;
        b=Wv1AqPjuwXkOB/njGtF2BF/1NOZTU2+kuUSK17wpcvBT98hrLIfYadg+8GDY2himwB
         12GqbinMI++gHctZP4iPizpRKzjVxrSKdVIA/7H9r6hAMKIQmMG76cPBumAo4gzGayF+
         KTpbKOQ14UKSWIozBn4AtkjkP3pV6550mxaMtyigt45+YZiUCje4k6Ejk+KiCeKsmbe6
         R1JZm56jk7NZPPyqH0Xr3HI6+OPwsBD13IZ9vJSD2rtvNfySee1lmrox/8m/efFFtUjC
         p+FSnONhaxJ3T2MtLHPpcVGJo+jxvklm8pgDuVU7RwAe0dRVPLZqBAe2WGzOHV/KgEFu
         Iejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJXj8DxHphvulR2gCvno0W04q2u7Wkypz7ZH4wJylqE=;
        b=cQq9jMbq9ADyT+1aWwdzNv/XLKXynbDa3GBW54RRHa/OHJUSIEi6CBRGVeUPLNjg4W
         w/3CEgQF97hsS9ugOPmvpe9hmiC0ENM6wpTNEwDfm46EqagkdYEOChwrQ/tdNyH1do1W
         wMyJYQC5EdfRtxVug/ycunDnR1dQy0QS9PUmfztnzxn0ua10o1pfg/9T2rGJVgQp29o4
         GL9rjc8GQnVfLiBipFtHOvwv1KwZuHFmfCX1n1XxUJpjMEe3BKrp7flLhHSQY9hi9OpV
         pfQN6GegmNrxu3EA+zIGIV5ktGHvuX8FZytoTlzZ5xHcqzu+qMRU50VQ6OMRBwI3w0uj
         TIrg==
X-Gm-Message-State: APjAAAVi/iBlrih8h7u9kBVmYWMTJRnwRdf2fxk3aEjPhbiOTtJ7CLXh
        p0u0bgeiF280cFjyDc++5fEF/IxAA7OtIQ==
X-Google-Smtp-Source: APXvYqx5TusC9XJvNC9+oUb0CSQkpV/9oThwnh3Js3FWKR4q9T3c3XgV0HvkjWeSxLFn9Ko5CUVkIA==
X-Received: by 2002:a37:ae85:: with SMTP id x127mr113672qke.190.1582736841857;
        Wed, 26 Feb 2020 09:07:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r10sm1405268qkm.23.2020.02.26.09.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 09:07:21 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j709Y-0004Gj-OF; Wed, 26 Feb 2020 13:07:20 -0400
Date:   Wed, 26 Feb 2020 13:07:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
Message-ID: <20200226170720.GY31668@ziepe.ca>
References: <20200226141318.28519-1-krishna2@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226141318.28519-1-krishna2@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 07:43:18PM +0530, Krishnamraju Eraparaju wrote:
> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
> index 3ec8e50efa16..2d6f2cf1e319 100644
> +++ b/include/linux/nvme-rdma.h
> @@ -52,13 +52,15 @@ static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
>   * @qid:           queue Identifier for the Admin or I/O Queue
>   * @hrqsize:       host receive queue size to be created
>   * @hsqsize:       host send queue size to be created
> + * @hmax_fr_pages: host maximum pages per fast reg
>   */
>  struct nvme_rdma_cm_req {
>  	__le16		recfmt;
>  	__le16		qid;
>  	__le16		hrqsize;
>  	__le16		hsqsize;
> -	u8		rsvd[24];
> +	__le32		hmax_fr_pages;
> +	u8		rsvd[20];
>  };

This is an on the wire change - do you need to get approval from some
standards body?

Jason
