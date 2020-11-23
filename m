Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E105D2C1003
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgKWQRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 11:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbgKWQRT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 11:17:19 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322DDC0613CF
        for <linux-rdma@vger.kernel.org>; Mon, 23 Nov 2020 08:17:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so17411924qkc.12
        for <linux-rdma@vger.kernel.org>; Mon, 23 Nov 2020 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVxHKrVDcEwRIyvgwR2W1JDU+pbZtv+NaUBGe/6Kyo4=;
        b=U4is2EaVXzDMh9rNozYBAvQXfOawMYoag6ePZexMkIqCA13XnuOLIb4l2Mttuj/+Uu
         yFehK3HBcXyfD//JhHas09RxxLRf+KnD4HStRnm77FkwpYvj77/FsUt2DRLlxSbXNf9m
         9G7x3jI5F4KLSbyO5mISUd6cM4X4f3S7bLHfVE8/CLHfnG6UztBlvlkJshEc99ij9Ct6
         dWqcZ/hO+3pBanolw9Z2P1cSDJ4wuiuzznRMKQOtj3ZYgpQLHkZRqcNzd1hkS8Mlc07H
         ayt1jcPCQONP6tblBnBsb1dalg81lP5yhPKEIXL2amwnwTpFfm4seAFaaLiAvO4MmWLV
         KmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVxHKrVDcEwRIyvgwR2W1JDU+pbZtv+NaUBGe/6Kyo4=;
        b=pOW+Ld7da0ejr6O0h5nVfQ0VIAwQ6JFlgZgHkIWJFOKI+t31OQsF16fTNJOcrHYDUB
         2Z4GVHl3vekhQqLOiwbqbC8A3X+Zk5aH0DpYKnYmNthP2Xzbgx5xs6ZbIw34JxGS1umM
         DqgujxSyIcKf63HtavzdVFaSgBlZEan9zzBg2deuNZqwvBlbq358BvpgcFuRA5Vtu16i
         HnS+sXyWU6inVRv+NvAMzD5l7PSepzi/blL/F/n+EORZpIzaJfsa9M27v2N01c9+KT72
         N/bVRYBMGmssbKXaGdb3BILV1bcL/G0EGtG7mfGJmGOm8G5MXA0zb5mZWu3ffnLXZQhi
         i9oQ==
X-Gm-Message-State: AOAM531dasjz+dKZNTeXpv7uo/ueHh2aBlvYR2rNw4MpoYUPkV/eXniF
        74Dze0dS/E2YSE5TGGadWOjZnA==
X-Google-Smtp-Source: ABdhPJxN1Y29OrdgkjjqoQKLBqyMQoVnBiagE307B/FEPJP6i/QfgnAqfcTBf2Q0xgDdLl9rWKLa5A==
X-Received: by 2002:a05:620a:12eb:: with SMTP id f11mr141102qkl.371.1606148238473;
        Mon, 23 Nov 2020 08:17:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e126sm120771qkb.90.2020.11.23.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:17:17 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khEWj-00A5O5-Bv; Mon, 23 Nov 2020 12:17:17 -0400
Date:   Mon, 23 Nov 2020 12:17:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Create QP with selected QPN for
 bank load balance
Message-ID: <20201123161717.GV244516@ziepe.ca>
References: <1606136808-32136-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606136808-32136-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 23, 2020 at 09:06:48PM +0800, Weihang Li wrote:
> +static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
> +				 unsigned long *qpn)
> +{
> +	int id;
> +
> +	id = ida_alloc_range(&bank->ida, bank->min, bank->max, GFP_KERNEL);
> +	if (id < 0) {
> +		id = ida_alloc_range(&bank->ida, bank->rsv_bot, bank->min,
> +				     GFP_KERNEL);

Shouldn't this one be bank->max not min? That is the usual way to write a
cyclic allocator over this kind of API. See the logic in __xa_alloc_cyclic()

Jason
