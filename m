Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C767988AD
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbjIHO3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjIHO3I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 10:29:08 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6681BEE
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 07:29:04 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45088c95591so932566137.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 Sep 2023 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694183343; x=1694788143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aqh0zmf4yZbMkh2LM7vlZhrvNSdTYvOhnt75WUn3Y4=;
        b=MKnWA5k33MpP5wbal+Z00tcw/ShWnqgxeMuLhEaus+1lPNAMpzd6cYE+Rx5a980lWd
         XbcN39LDvRrYytk3aXpTv6DwRz4WkXjwCsQOSTPxSYaSOf32VtJjiQ2mxiWa6JuuzH5M
         C+N1UvT04KZmW2rajGkGzeCfz3+IId6gDxiDTiSzyTyB8Uqbr+xRv5rYI6DovNNeFDkU
         cskGPR6gGeBjB3xAXyZsDxxoJPj+y/nc8zRoR8YSbLkitLUKIImZFL/ppaXTKzFZC+fH
         RPeWw+oaFwvsOh8TIfngWPE9lbMdfJUlr6u/WmcemTC48duXkht0QC6mtMqEGRLsEaVd
         Jusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694183343; x=1694788143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aqh0zmf4yZbMkh2LM7vlZhrvNSdTYvOhnt75WUn3Y4=;
        b=atoGoicLd3h5iXdhl5SKZmRT6w6U82lPzET4FduCcX6OBpIbdD0m+KgmsGa7xDr0Ia
         NUSCE3BwBwIX6Lcu7KeHWtfG7AnCQk04IzuSmV8NUFqTsvIgdwOUzudlp6zvGZpFBNBl
         094YPZsGkuzYKhc1Fdd2PT4rsbAImtoaMxDqqwr/aUAajIbq+QHpqK5q+CTwMkxZJ4Fw
         M84SpO6xDDq7+uSzK4x9hpqEpFRat4zI+LXMsewTtNaPw26a1YgGu09o8whr44/VsxCR
         STvjDiQeHM0tCrdJyPajAtdAYOQ9cBRtDp8iwzLSqFErrGnaLGpoWMeRk9G+emtWMs11
         cAeA==
X-Gm-Message-State: AOJu0YygtdLqliHQ4u+fy/RUvt3POnsZ227ttu6/d4Ek+qdViqW+gxj/
        78uzYZar8a6klzqA37TqwFapug==
X-Google-Smtp-Source: AGHT+IHDsErZZ2cj+KD77fiOyqcvO+Iwf0pw8fDOjuWUBVlZwA9B6Ma2+vNWXjQWja50pqd7xFLkqQ==
X-Received: by 2002:a05:6102:3541:b0:44e:b571:27af with SMTP id e1-20020a056102354100b0044eb57127afmr2853264vss.1.1694183343406;
        Fri, 08 Sep 2023 07:29:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id r19-20020a0ccc13000000b0064f523836fdsm735871qvk.123.2023.09.08.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:29:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qecTl-001IVr-SH;
        Fri, 08 Sep 2023 11:29:01 -0300
Date:   Fri, 8 Sep 2023 11:29:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v6 7/7] RDMA/rxe: Add support for the
 traditional Atomic operations with ODP
Message-ID: <ZPsvrTvT3CtsdWu5@ziepe.ca>
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
 <908514dfa6bbeae72d36481d893674b254ee416d.1694153251.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908514dfa6bbeae72d36481d893674b254ee416d.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 08, 2023 at 03:26:48PM +0900, Daisuke Matsuda wrote:
> +int rxe_odp_mr_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +			 u64 compare, u64 swap_add, u64 *orig_val)
> +{
> +	int err;
> +	int retry = 0;
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +	mutex_lock(&umem_odp->umem_mutex);
> +
> +	/* Atomic operations manipulate a single char. */
> +	if (rxe_odp_check_pages(mr, iova, sizeof(char), 0))
> +		goto need_fault;
> +
> +	err = rxe_mr_do_atomic_op(mr, iova, opcode, compare,
> +				  swap_add, orig_val);
> +
> +	mutex_unlock(&umem_odp->umem_mutex);

You should just use the xarray spinlock, the umem_mutex should only be
held around the faulting flow

> +
> +	return err;
> +
> +need_fault:
> +	/* allow max 3 tries for pagefault */
> +	do {

Why a retry loop? We already have a retry loop in
ib_umem_odp_map_dma_and_lock,it doesn't need to be done externally. If
you reach here with the lock held then progress should be guarenteed
under the lock.

Jason
