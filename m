Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35771598A9
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgBKScJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:32:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42859 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbgBKScI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:32:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id r5so7369325qtt.9
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vjMbRNBZQ+LJ6aGOCjti2nKdY0gqRjyi9v8bF1h8khE=;
        b=TlM5685VMRj2bGgvbGkIs1qm9zriEFir7wOtPwANxzfjeNQAYq7Lcv04YycA0yXBVb
         S/Bq/PXhrrD2WJarSwG8wUS2Njtjaf4xZ4jtGr8MbvD5Vv/I/Tu+Czdpz6XUhXHLz4rA
         ZXNzEyUtpbP7eVi3Lrnx9mdFYO6z0ReauuxepC7uU5A9/2i2phz0/8FXv2QC5k5Su+oo
         t9Ut3vLHCH9ePb69SzGa73fLM7B8yL5xh3Uz5EnXZjgRkdVx5MCrevhluAkGJR1XTuIr
         4uMAo0bC/nflM3LmLfToVXarYDakLRK1FsGcEohlSnMv1RsRnFq5qQvAQV/aUcnqYL+s
         /HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vjMbRNBZQ+LJ6aGOCjti2nKdY0gqRjyi9v8bF1h8khE=;
        b=PUgDKpYltfYQKE4xuXo9AAHiTMvYTfWau1Z+S64xIU1LbAQM/4oSB6BNI6w3TAdPJU
         pm7mNOAdrA9p6aK8J9uwZbOgg1MJZUNtX5cI38roJoNKp8MNDfLItVFkSJw5CVI2Oar8
         wpRSNXhajx2mOGLcjJnEbNKRZe3My9GEG+TS11DT3PdNcJ7TUBxcJ76sUqRuK4OowyP6
         4vJRC8UVBuE02tXpE3+PZcQBJPcN5FBf02ZnS4RZNkQxpkA3rDQgNZlGBomsHjNyXxkR
         x7eGd1kWqHDZzqG3gSt7dIPL42a/eRuNmBGSJJMNIosPOVZoxlEJviD0I2ANNd4EmXDq
         Pl3g==
X-Gm-Message-State: APjAAAUHvsHhmYQ0NHMdtPo3a/5K+9XEnPQZd/GrW333l9PvglFfC/uV
        7TZQK7Rx+RMMkBnWQrfJGm7XWZ8dBpR+8A==
X-Google-Smtp-Source: APXvYqx1Stt7sCaH1A9LJpCAScBxqMQ2EvlssxXtDjmK+6ahKYPi5V/gd9BEYI1gE7ykgdj6w2J7dA==
X-Received: by 2002:aed:2e03:: with SMTP id j3mr3688692qtd.365.1581445927381;
        Tue, 11 Feb 2020 10:32:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t29sm2371318qkt.36.2020.02.11.10.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:32:07 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1aKM-0003hh-Kj; Tue, 11 Feb 2020 14:32:06 -0400
Date:   Tue, 11 Feb 2020 14:32:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 rdma-next] i40iw: Do an RCU lookup in
 i40iw_add_ipv4_addr
Message-ID: <20200211183206.GA14213@ziepe.ca>
References: <20200204223840.2151-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204223840.2151-1-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:38:40PM -0600, Shiraz Saleem wrote:
> The in_dev_for_each_ifa_rtnl iterator in i40iw_add_ipv4_addr
> requires that the rtnl lock be held. But the rtnl_trylock/unlock
> scheme in this function does not guarantee it.
> 
> Replace the rtnl locking with an RCU lookup.
> 
> Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> v0-->v1:
> Annotate dev->flags with READ_ONCE

Applied to for-next, thanks

Jason
