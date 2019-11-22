Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15777107971
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 21:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVU1B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 15:27:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46079 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKVU1A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 15:27:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id 30so9250936qtz.12
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2019 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TuEJSat07gB1IHltKZEvc+y9sVWtpqAObc38RVhlHg0=;
        b=ZPNwk6afKIW5LdcIqrEVpFENUsOBQjX7BOurhZoa9oUBIsHu1KKcmUKaWCot2Q+48Z
         SGX4FOcognZAAp7qk1OyjjPiiR3ZS9bJzC6+k4M09o9xN5OPVPdFnHs4uD0+aCHzdvUl
         n2ZkL3ip5FLLzoLFnrg3S+wkYJtn5JMasBIkeM6Tfob2uKznZ0Y86d77OqQaTrrLwvt1
         EZX2qVp5UVqdXnJSPUN403GQBGujUnFUfKr7+GkQvDXRgp6HLpyY+1xunABdnLI/Snyy
         xDy5l78e0J7pDTy8SMlNua2a0swLp4IC6UpLZjUIHtQL35Vb0VFRQ59cCnNECJCTAEoA
         Mp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TuEJSat07gB1IHltKZEvc+y9sVWtpqAObc38RVhlHg0=;
        b=Xq0zX6F3nwOpNmUNLiJuj7RfJX81LF3f+l6MCkjunk8xlhQnlUT9FlEdgGqeIyDCLC
         pbfM+UOBlHf0cF/fJ+aHXZ8UyA6NBAbVvIuM4Y8hjf65kjBKP4hS5E8VrlgQIpLbSGle
         nWrinJmkWgKAvbCuSAMZFlc0GFCcX7neDpshHGsoG4Bvn1HAZbmO0qwZzy6ZBDy2FMpn
         Jz7mZ2oESG5EAuaK1evg4/7FtBdd6h8A4OI2/PfiA4BeR3+PceWIoIe167bkT24MVq92
         KwqJhU/oGjnORaCEDrWOr+Mscbuau2hpwcozQYOa55jJBQLIdqAVfLH22skiYaYUEfd4
         ZZUQ==
X-Gm-Message-State: APjAAAVc4aEfNUCcvoYQreR9UL1PnqZqDtf/X69sqnxo4n6voFfbKZd0
        qxTkPxtTdDT+5wauLITde6IJQw==
X-Google-Smtp-Source: APXvYqzkWEbBdtWdJtN3F5QnaVFyACvDHG6QXr8Rgqs/FHE1QO0QMaRfW07+SVgpG840pdDY+8eSjg==
X-Received: by 2002:ac8:2432:: with SMTP id c47mr16453020qtc.74.1574454419946;
        Fri, 22 Nov 2019 12:26:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r48sm4048719qte.49.2019.11.22.12.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 12:26:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYFW6-0002OB-U5; Fri, 22 Nov 2019 16:26:58 -0400
Date:   Fri, 22 Nov 2019 16:26:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: remove redundant assignment to variable ret
Message-ID: <20191122202658.GA9162@ziepe.ca>
References: <20191122154814.87257-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122154814.87257-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 22, 2019 at 03:48:14PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
