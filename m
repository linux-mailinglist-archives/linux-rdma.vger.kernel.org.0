Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8459EB8061
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbfISRsT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 13:48:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33651 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388184AbfISRsT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 13:48:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id x134so4335881qkb.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qe71b1ABAW8060jGcBf+wFmKIDuK98F1s9xGHNygvF0=;
        b=jOYztUeChygheaV+9UMmqeEs+5lYF78KhOyc/f/b0tpvKD4yzwSWr39u4VIk1KHeEv
         0BOiC6PCMrWrsTaqfczPJJOldm1bdftvb4Zrg54enPg+8BCloYK58lnfEmtiYrEkdubf
         ejXbIBSTwQ4TqEOXLmXtRNVToYPncUHFEQiV7PsVU0MNYPLLtEQUZJRnLV6A1ilvO6Qe
         CwYV++LLzBw9ubUkVBq1mM06dhUVWHr6wt5kbJdQZcv2hauiMkTIv0JLr61q+VGiSPqc
         l6RYC+Sjvn4ma+2E4qT5DlkuRoArIGUN04Q1jknJhJhP5YzbR53x30QDVLLlXzAvF0R3
         0m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qe71b1ABAW8060jGcBf+wFmKIDuK98F1s9xGHNygvF0=;
        b=BoPP7TycPvC8OgRtuRCwxwmbEj2+4ZFwywJ7MqF2wY5AhlXuWM7i84ZQM3NtgEolr2
         XTjiMgq7UuO/XuPHu8uoW5kqYps1ppHETqE0QAsuWxgoFUZFXDj9R2pmxkcyK95x9cmY
         a11NnHjn+FwB7Pm6M/Ug5M4bQUj488Lkcc4wHxfAyfopDzkFxtapB2NCasFksLcwURBf
         RHCEzptQswj8hzANJMaWEpTeNqUnkHh2E2gkq6tk0jRP/h5VsZHgVzj/iEBnSQIBSOk6
         wE55CedbjfJWWXm2lxb774TTPnxf0vJKV6HnFlNfiwsgNURfoMAMe5WsbLH35spfQUXw
         jj/w==
X-Gm-Message-State: APjAAAXvk++E22tDGTwC1y7O7BuetpNI3lyws5HNoAFL6XE4GX8xIUIq
        EarByiz2vTzgQDDp3Y/h0Ig7eQ==
X-Google-Smtp-Source: APXvYqwLxLClpcxa06P9n8XpJ5JiBA9yln87kCLXXwE13OAx/we+3cR2swxEKPeu9eazpnRZ4MNeLg==
X-Received: by 2002:a37:a44f:: with SMTP id n76mr4203929qke.414.1568915297903;
        Thu, 19 Sep 2019 10:48:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id o124sm5016761qke.66.2019.09.19.10.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 10:48:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iB0XQ-0002Tf-Ui; Thu, 19 Sep 2019 14:48:16 -0300
Date:   Thu, 19 Sep 2019 14:48:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20190919174816.GC4132@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905100117.20879-3-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 05, 2019 at 01:01:12PM +0300, Michal Kalderon wrote:

> @@ -917,6 +921,9 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  
>  			priv = list_first_entry(&ufile->umaps,
>  						struct rdma_umap_priv, list);
> +			if (priv->entry)
> +				rdma_user_mmap_entry_put(ufile->ucontext,
> +							 priv->entry);

This is in the wrong place, as the comment says the purpose of this
loop is only to get a single mm the actual zap & deletion is the 2nd
loop below, which is where this should be.

Further, it needs to set priv->entry to null after putting it
otherwise it will be double put when rdma_umap_close() is eventually
called.

Jason
