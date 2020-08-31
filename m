Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53659257EC2
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHaQ2b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHaQ2a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 12:28:30 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96961C061573
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 09:28:30 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x7so2935290qvi.5
        for <linux-rdma@vger.kernel.org>; Mon, 31 Aug 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9lZPXR5WzoPuaCl8TbE8mmv0oGBDWatOzTO2sjKTaiY=;
        b=Heo8THnnkSpgNuxbbKanVktYH4yYu7Ff5LgXMqD3PY8U9HMcnGTykU7WNcvp5U033F
         oF/CG0nBVh0n4zoJ3hor9LA0CpTjRPOs/ndEsm7dBalHf+YjccggFhp3gHaIVvJTmp8t
         fCBjPqwR/na8sOWikGZ4xB+sbwtqyJVwWAXH8chmDUnnDFEhlW3UuXH0PPhp6duaaZsE
         +lp6VYCu5dELE6RIuwoACD2ekV00lhwfWqcbHRzCvMprZ+6ZK7Bp9O7Yh0o4gBuoNMUt
         ccnkAbtQ1o5cUrRdFM9WXkuJtHOcnoygE8Dh26Cn6lsn/Je/ZzwR97SO2xZmBy9NxPW0
         Gdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lZPXR5WzoPuaCl8TbE8mmv0oGBDWatOzTO2sjKTaiY=;
        b=HU3cScviYeFwIRAoW9BBErdJdUvVDe/BZkwM3RBQwRmmovyUANa7mRQTaXsxStQBdc
         0kNMEu6KtMAmA3dl5REGM+ROB+KwucitiSjQrRb4t0TXN5ez5Ikgj6pXFXxZAJFRbpY2
         t79at8oE5AywO3Whq9r4cQ24zUzbhM8N8vHb+JLsbB5ADecT36Rb5jJh46bkSMdQNXTt
         9NJdmJvQ1WIGtmQLwGGLcJN8+vP5A7o9qs7Ig7hYV9TChMIttDgUohEwO/nmncAutD2r
         LNzIgfJEzKVWkuY8zvJ5+X2YnFATvf28+og2mggwhGi3i8eQo+kGF3AA6iqGxAg5HwDf
         6puQ==
X-Gm-Message-State: AOAM532sfpabl+vbKKEH0rNlWVbwE3W7CgDWV8PgF4/GDnviaYV3MUjA
        taCxDiTZe5Xn+fQzO9in7KPnnQ==
X-Google-Smtp-Source: ABdhPJzjxT1NuLmfdLoYjJKszp4p8h75u//aG9LXU8FXQvQ4ajHDYcipF0U3e2aBcu8y5lApn9DH1w==
X-Received: by 2002:a0c:f649:: with SMTP id s9mr1845938qvm.188.1598891309863;
        Mon, 31 Aug 2020 09:28:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k64sm10206097qkc.105.2020.08.31.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 09:28:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kCmfU-002pH6-Js; Mon, 31 Aug 2020 13:28:28 -0300
Date:   Mon, 31 Aug 2020 13:28:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Add a debug print when a driver is
 marked as non-kverbs provider
Message-ID: <20200831162828.GB24045@ziepe.ca>
References: <20200818083831.92212-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818083831.92212-1-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 18, 2020 at 11:38:31AM +0300, Gal Pressman wrote:
> Add a debug print which is emitted when a certain driver is marked as
> non-kverbs provider. This allows for easier understanding of why kverbs
> functionality isn't working in such cases.
> 
> In addition, print the name of the first mandatory verb that is missing.
> This brings back use for the unused name field.
> 
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/device.c | 4 ++++
>  1 file changed, 4 insertions(+)

Kinda wondering why here? The debug level doesn't print by default
does it?

Jason
