Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A367708BF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfGVSgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 14:36:11 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:43934 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfGVSgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 14:36:11 -0400
Received: by mail-vk1-f169.google.com with SMTP id b200so8083303vkf.10
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AaGq+Qn5ipyvNclhgXPtbHGUf3PKYP2ypbtdsfvuGPE=;
        b=osk9Sq49PC6jweSqvDPGNpTawDqfETyCe1tAbu9VOkLFzFTsAr+zL99VHezfFVOUWF
         3YFzTuckiUTd/d0mXDXqH1R9tfxs9b1EljM+F3B0BoKUyUkupKr37Di0RpbFTk3+LnlC
         pSrnYiutyvFubFi4x0xaJbbIpXT97zAd05k0WFYQ6oHIpMqOpkhI7Yxb/hdOCxZcDBV9
         dxiYxnYhoJb9leiHgnlMbjMOPnPvG1au8vSgXPvNh74s8sPUxdGJiM/f/r8IVZlCbWKv
         LMXx07kFL2gb6EnB9xQcZQR7mVet8ltHHkeK2Rr/ge8mbCaCnFpwvcDZsc5hkxe0p7mp
         k1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AaGq+Qn5ipyvNclhgXPtbHGUf3PKYP2ypbtdsfvuGPE=;
        b=kL8xPuJ0UBh8/4fqNgE5AYL7bcIB0P7TAbqlFpVHyQlNiy8QzDyVmEhbqHEdSdeCxu
         bh5MuAF6+JOd7fhjCI049xoaMziqCCgZQSXknstpd9yNeqbKXJYUPERWXMvj6Tv/6gG3
         p1jUgHBLk+5T+x3GXl48JnObjS+nsbyXb9s3K8BdDTfqGOG7WlfEtNovo71zQztlcNOc
         szIq7RUHXojGwaKtW4EbUhGnjZp7CiUZaDlYBNQaN2BY6xeYuM5fs+Wh4528ho3iWJi6
         tLrmMJJwFaquzA7PoYu/j5QFsMJZ4WJX9RaciWzzaImaTHtrTQF3xvcAjoVAe9EXtKJK
         wQeQ==
X-Gm-Message-State: APjAAAVRT8oj9ZewrhQK5W1hLS7Zzuhqvnc/m2fUh3qVLDodiXyxshcD
        ShCyMeeC/xvOWNelNzyrZ9DwYw==
X-Google-Smtp-Source: APXvYqzg05DBMl1FiOOEi+BcDj9oMatgFoRzOcxe2TWC1iSrYrMwZsPdQYO2OOGlW8dYgZ2eC5r1aA==
X-Received: by 2002:a1f:5945:: with SMTP id n66mr26924124vkb.58.1563820570049;
        Mon, 22 Jul 2019 11:36:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w12sm15578233vso.32.2019.07.22.11.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 11:36:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpdAO-00068P-L1; Mon, 22 Jul 2019 15:36:08 -0300
Date:   Mon, 22 Jul 2019 15:36:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] infiniband: siw: remove set but not used variables
 'rv'
Message-ID: <20190722183608.GA23553@ziepe.ca>
References: <20190719012938.100628-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719012938.100628-1-maowenan@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 19, 2019 at 09:29:38AM +0800, Mao Wenan wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/infiniband/sw/siw/siw_cm.c: In function siw_cep_set_inuse:
> drivers/infiniband/sw/siw/siw_cm.c:223:6: warning: variable rv set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit 6c52fdc244b5("rdma/siw: connection management")
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-rc

Thanks,
Jason
