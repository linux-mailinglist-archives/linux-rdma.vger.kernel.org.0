Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772CD1804EC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 18:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCJRfT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 13:35:19 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43769 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJRfT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 13:35:19 -0400
Received: by mail-qv1-f67.google.com with SMTP id c28so3018595qvb.10
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iKHGFgXoz0ujmovKsqw0yoG34rZuseOkcVSitq5twNQ=;
        b=EECcVfl9rjq4Wfm8vltlf0an/G8OEMhE6XDXdAYcgE0OAWuv5hvsApKsBfXiAK586h
         vLHpwhTQ/7xe1mNdk1dBJjUxZEs5Gq24jWyQHQIIvYH3rgSn/ZtxbuvTOs16Jj74Iiiy
         rdAFhjiKVtyyZ+eSaSDcjJ/5uAgfaZxeFrOSXy6MLSmWmfKCX7utOPguZgV1OsoAgCxX
         YUPJJyZ49lRwb2TWI4Y+fUWN1S3tdF6Q09DMnp2W7RUznvTgKv1DWG9z79ZByxSCz0Ph
         iHp25dp244P/l2r+nqNLDV9uuaoRhpAELU7Voc3QIIQ/pco/0b/ZqAnL29eQXpllAeoh
         3WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKHGFgXoz0ujmovKsqw0yoG34rZuseOkcVSitq5twNQ=;
        b=j3q95fkhrn3aoADqAQ1rvEckFPV5KJ9iliOaLJ163XTQr0BlXEQwaW32vHs55z2bCo
         JmMwN2wVd8KfV5CnuhgQS2sratb83mtakmgJR65Eyot7dXmTpSBgDimNGvTvd6chdhNU
         BFhIUKCeZujdZZuGBU0Hs1/N4STW14z0GTHkXShq7HfX5HnAiK73e+KCb63C6H+SLKL8
         ty10ftlGk+u3R97idF2adyHcCEM7Ufoj9+TdFCGJmoR9iXFcjtOkRCmmFCzyfhteArEJ
         YKGPe76BGoWbhrtP7Tc9Oei6PAwfnx1ZrZJzWUpDNVs/Lz5JaupLzT7ko6G8jv/g/Zbw
         PDAA==
X-Gm-Message-State: ANhLgQ3IaAjpw92OQcNhyr+c/j2uHrqwr7vPlRxsY0loRtr8j+RgSYCt
        PXBEJL/qaVohIULHg8VEuShkem1ECvM=
X-Google-Smtp-Source: ADFU+vvwNhpYZ8ahHbPZ0c0AQIGlgaOYbxiLS3T5sWqrWnr84r3h8PS0lGwOWxZRfzVjr2CbMNbVUQ==
X-Received: by 2002:ad4:4e34:: with SMTP id dm20mr20045009qvb.223.1583861718199;
        Tue, 10 Mar 2020 10:35:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k50sm24920231qtc.90.2020.03.10.10.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:35:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBimj-0005nb-Bj; Tue, 10 Mar 2020 14:35:17 -0300
Date:   Tue, 10 Mar 2020 14:35:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Remove the duplicate header file
Message-ID: <20200310173517.GA22245@ziepe.ca>
References: <20200310091656.249696-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091656.249696-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 11:16:56AM +0200, Leon Romanovsky wrote:
> From: Zhu Yanjun <yanjunz@mellanox.com>
> 
> The header file rdma_core.h is duplicate, so let's remove it.
> 
> Fixes: 622db5b6439a ("RDMA/core: Add trace points to follow MR allocation")
> Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/verbs.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
