Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B81E8715
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgE2S7l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2S7k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 14:59:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0296C03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:59:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z1so2847391qtn.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RaUxoBXnGKn64Fo7HuwC5BwTXJfjsxRvpSEA9Eyr5aY=;
        b=jh/cmks++pIykzxUVnImoXICLr6kty/tr4n4Hoxe9KbHu9SeoKpZEV8qM4QE17IbpK
         EtJL0EXUkEPu26O21xSPhKbbu9NazvyHIev47P4JUS0hxnfqEAb769FG0IDmtoiq9YP8
         Ki5qAXQT3yWX5OmD7PYTgl/hlV+VfUnRlVd9QGbGfpDZ8J0pbCOF0o77aODlTHIItka/
         TjItPTTcUcCC/0QSvxphdYOibbieAEtyzmZMmvIGnW/GHHQyJJizqE1zoQoF/IgTNRzC
         B6Ybv4/btounRvYVo/xMH8micJ5SFA81iDCh/vR5g1+gECgiHv3q+4BzmwoVFdXTUyeL
         Ewog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RaUxoBXnGKn64Fo7HuwC5BwTXJfjsxRvpSEA9Eyr5aY=;
        b=DpBgG1m5FQi8LP8n2BMnIt9NbDB664knXf8wqhzNDP6smkDl3KRwO9NJizrTi11oUO
         Z6fsWxvw4fpRlxdjbDNvlzyBn2pP5dxlqL779zaCKNyRf+kEPnuLKVgly9EzxHME5yg/
         uUoj511nXOrA7sEKYshmllrPuOI3KzI3CGbktz5EUYwVSUKv/kCIwauLAZeKGeC9YA7Q
         aH6RhZ1v/GOfh8isCKLWvjOUNZdpjAHqveUhhx0gYf1t82AzTrZ8HsBwklwxD++ptqpz
         A6nR42ZUTDjxFDkX194GF+s2vYM0FtldByYpJpt1hv/MJLlXP5mZQAWKmEOJr2o6K4EE
         YmRw==
X-Gm-Message-State: AOAM53046NyV9zVy+QFk81kjxycKsC19HCb2o8+dDR9+SXYf6DD42ThW
        wPViujJWkQXkxyaLmaVTk9Nd/w==
X-Google-Smtp-Source: ABdhPJy+JnEtFO0XCjkU3nPxpfBDbaQzDggBqBg4pA3lRM65slqSc56gDkWhn0cbHsSuL9+5s5Mp+A==
X-Received: by 2002:ac8:2c4f:: with SMTP id e15mr10518844qta.114.1590778778372;
        Fri, 29 May 2020 11:59:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a1sm8446607qtj.65.2020.05.29.11.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:59:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jekED-0000mC-2o; Fri, 29 May 2020 15:59:37 -0300
Date:   Fri, 29 May 2020 15:59:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V4 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200529185937.GA2467@ziepe.ca>
References: <1590568495-101621-1-git-send-email-yaminf@mellanox.com>
 <1590568495-101621-3-git-send-email-yaminf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590568495-101621-3-git-send-email-yaminf@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 11:34:53AM +0300, Yamin Friedman wrote:
> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
> +			     int comp_vector_hint,
> +			     enum ib_poll_context poll_ctx)
> +{
> +	static unsigned int default_comp_vector;
> +	unsigned int vector, num_comp_vectors;
> +	struct ib_cq *cq, *found = NULL;
> +	int ret;
> +
> +	if (poll_ctx > IB_POLL_LAST_POOL_TYPE) {
> +		WARN_ON_ONCE(poll_ctx > IB_POLL_LAST_POOL_TYPE);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	num_comp_vectors = min_t(int, dev->num_comp_vectors,
> +				 num_online_cpus());
> +	/* Project the affinty to the device completion vector range */
> +	if (comp_vector_hint < 0)
> +		vector = default_comp_vector++ % num_comp_vectors;

This should not be touching this shared data without some concurrency
management, I changed it to this:

	if (comp_vector_hint < 0) {
		comp_vector_hint =
			(READ_ONCE(default_comp_vector) + 1) % num_comp_vectors;
		WRITE_ONCE(default_comp_vector, comp_vector_hint);
	}
	vector = comp_vector_hint % num_comp_vectors;

Jason
