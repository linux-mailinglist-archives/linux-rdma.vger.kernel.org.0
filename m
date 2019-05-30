Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F593022A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfE3SrL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:47:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46163 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3SrL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:47:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so8215910qtz.13
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=diBaFFpQOlJHpKJW383mUN2AuWiME+bQ0o/ZMr4CX7g=;
        b=UFO9adfCo/18SlB8rmLEWfhdTO1VLvgTQXQr+f5VpR5Vn+60DZpIydGbIK9797GNFq
         Xy3XecSK+3Fky6d/uUhIOfVwldEY9gVT5EHyOwpoqoQHpyOYbSKtoo44D3q14TNBPFFB
         HLkXYxRF66RbP7Iw8709C5bOahsIRVvGRhKkVYwmwFBW10BpF6wfOXwSIr4s5EVbMEno
         X3oe+DWVYOcR3duLcUBWTxcsHVu+Kd0Vr4/BwFmTxhlre4bXP1T3gGRc0betIe8ua/vg
         GAh+WcYICUA8+boK+8aWE7aEsf8CePt5RcjY9ljTbCmx1xq0/17bFvBsTH6/JNLOaFpO
         sLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diBaFFpQOlJHpKJW383mUN2AuWiME+bQ0o/ZMr4CX7g=;
        b=j7DpvsAirgS+lyCKb5TGfEwzvNci5FUgM5Df39GiExysGFKBb5NYYR2Gg2Uzzaf60f
         WdOJL0pza7r1kRHHB8DskeAOvUZbO6OoNuaRLslI7d/5Lu7oE4OtlodKa9SX7BnxKspL
         eWkPqMkl+tKzTPMu+7B96WCscI39tV31HI16tc4fnNoA3HNuAMFX8/IuG0dXvfdGh0/2
         Ok4NM1AdSuDtCHHJd551XBbxfrlcbdkAwuPvoiH0UjOB+qMmIWkfjp3De3SPQ6iBsZ+s
         3egVhYZgo2xOvCpR715uee9w98CJkSbxVTwnjLrqyeUDqkcDNR6rTOm0dVoYeyLCsXVN
         uVJA==
X-Gm-Message-State: APjAAAUSLM6JI3L0p5PwUHRR3Lrl/pe8Nf6dHH2qZPi2EQs6DprJkXtq
        EgKRykUHFIDc8plF8debuGuTNQ==
X-Google-Smtp-Source: APXvYqwDry+6XP937lrELkrm98AM/hLZ9gH2okpbVOKmcOx5qydqW0tC4kDYVRTSKn5XTtjb5r/lvQ==
X-Received: by 2002:ac8:30a7:: with SMTP id v36mr4983567qta.119.1559242030613;
        Thu, 30 May 2019 11:47:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j33sm2185547qtc.10.2019.05.30.11.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:47:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQ4z-0000Gn-OX; Thu, 30 May 2019 15:47:09 -0300
Date:   Thu, 30 May 2019 15:47:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: check for allocation failure in
 uapi_add_elm()
Message-ID: <20190530184709.GA982@ziepe.ca>
References: <20190530082024.GA11836@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530082024.GA11836@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 11:20:24AM +0300, Dan Carpenter wrote:
> If the kzalloc() fails then we should return ERR_PTR(-ENOMEM).  In the
> current code it's possible that the kzalloc() fails and the
> radix_tree_insert() inserts the NULL pointer successfully and we return
> the NULL "elm" pointer to the caller.  That results in a NULL pointer
> dereference.
> 
> Fixes: 9ed3e5f44772 ("IB/uverbs: Build the specs into a radix tree at runtime")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/uverbs_uapi.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next, thanks

Jason
