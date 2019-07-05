Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A6960B2A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbfGERon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 13:44:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33805 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfGERom (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 13:44:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so8484483qkt.1
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jul 2019 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DsDN0H5pNL1/ICNH7Dz5V8XSb6ubjK0QwX5N9406DZY=;
        b=OEh7mxFJXRNgAyctuFs8gk6m1I9rirSLGW1FIcEelBtOTuh+ULSX/GZT8vIMowNJKw
         JQL1fcimYpTfNtI69npHD9xUw8e2nR31uGDZz1lgB2kUReUpu5/8VWdc0f0NrOpv5p5F
         MC82xPU+MaPFHg8tslLM2GVk0rHSlUnd4TpGlMyZt8E6PVTToKPZg7DUCYbshESbUDyz
         1/+AA0QVQv/wjSw5Gwvctr89DlzLSvl7boalJk4sPr0HoRskXWfRUs136DB7n4l2HbPl
         Ir/oQOQSafxGIh5vEXn9aKGt0NsP7PaN5Y/qhdtk7ptBKkhYi07AgKrhqwPh+cJ/vtTV
         VXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DsDN0H5pNL1/ICNH7Dz5V8XSb6ubjK0QwX5N9406DZY=;
        b=FrOCHkEx8VFGo3YTTI2RnkLehR/CkJi3LkjFpLPJXt0zJZB9tBRkxj25tPzovX91Ed
         z8SerMVcvmDggZnZOWbVALbIY5o+415w0+UsZp1/yVbs3WJ4xWCt+8Nvw7U2+G5tANnk
         XvIpYcy1daKsgWuHKCvYO7YVErcLEpZwAE8qatJ9xtdSmFdLDo6rdRYbuLCeINQY9OFf
         eLoVcqXtmaJX7ZADwUWFxIGk2OoDFTbuKCjwTY2esNTM5M6RpPlPBPAjiF1+gvHhVY8h
         gXgBIaKzTzd5OZSB09hU0U0AQz1gNaP+s0WDYL0PUh/Bpl3+WGfmsx3huSJDrMl2Gm9K
         n2lA==
X-Gm-Message-State: APjAAAVOI5UMQpzPg26iiSRwmI3JUV0BlpUJ8P7+3WqdXgWFquiKsnmC
        LlmkoNTdo3vMO87ucfy3FCB+4Ub+pnweWw==
X-Google-Smtp-Source: APXvYqwGZsX1qLiJR25nWBEJF111+YGImEO01o8cQDZMyEbtN4amyyfQT/a8/7yHrXJIASfk8B/3cw==
X-Received: by 2002:a37:aa06:: with SMTP id t6mr4166621qke.226.1562348681740;
        Fri, 05 Jul 2019 10:44:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c74sm875552qke.128.2019.07.05.10.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 10:44:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hjSGG-0003oI-Tj; Fri, 05 Jul 2019 14:44:40 -0300
Date:   Fri, 5 Jul 2019 14:44:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] ibverbs/rxe: Remove variable self-initialization
Message-ID: <20190705174440.GA14622@ziepe.ca>
References: <20190702134928.31534-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702134928.31534-1-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 02, 2019 at 03:49:28PM +0200, Maksym Planeta wrote:
> In some cases (not in this particular one) variable self-initialization
> can lead to undefined behavior. In this case, it is just obscure code.
> 
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
