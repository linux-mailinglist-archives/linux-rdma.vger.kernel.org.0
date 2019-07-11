Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4165952
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 16:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfGKOrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 10:47:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32881 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGKOrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 10:47:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so4392921vsj.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUmlGY6yas6VrdYZGOaSdQwWGQVgRyYlGBxMRjwXy+U=;
        b=KvUJNONAi7UUgCR2G0iyP9dC+TEMlGB52UsU1vpEIE5VUni18sfejiXR6iDDWn9v+L
         DRT+7FMtOVb1Q5RVg/FNfJrxVYnjZ8hPBBJS3BgXxC8s+n22dFw04/QfQE/PzafV70Ux
         yuO1IbahQooVuS+EAWoBqL1hRsJC012tPEX+7IwdPyb6Sc5P57LB6iGNOhObv3pivyMG
         qit8V+zMIOigBTnd9LMt57Oty1F4rJVj6Pf6gsrZPQ7bDgZ+ma+hixUViT2TEmzDyLL8
         q+MKCCA14cL/H81tWsOac2m2U5Ot90z2OirelMMAk6qnpIFHP4rxO/tfP0F2dHPgqOza
         CtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUmlGY6yas6VrdYZGOaSdQwWGQVgRyYlGBxMRjwXy+U=;
        b=TTAsPRk4QBfe1pkjjWfyj+wISjp29ZaXKv4OIgio4kVPRgQKr7y3c5OZwOtZEkzeRt
         bwn5ffpD56CMpXAYToVqGto4WDLGJWyCQjArQF/PJH/u95k3Ugf6OCd+YLCLg3aW9uI1
         3zwGhALmqRJX3Ir5WR5K5uPpIqzvrejAb/DDh80tCO1ftGjblSV7TK646MATh0jo6kC6
         6iGj93JV6XefNvIxyMxyktOTaOYKFPJKveuSX+gEbmyHjylJWoT9DRJYgmjCIkC76ZUs
         GbsqrOYL8SlVEQnzb6AoN482FeELeV20a9urBA3uqc++K4c5VC1yA3hohCYCM5eVsyl0
         QvmQ==
X-Gm-Message-State: APjAAAUk9yfA27EgeBxvdqbSDd3iGFeg/K/+XgNiPR2pTDo9pyzOy2Wk
        hOVf5jkB+ZCPI1sfWZxPhETx2w==
X-Google-Smtp-Source: APXvYqweUoGqYduacnXihqjruL1/rYGti5hbwSoZmr/KlGD77Gaa/f8FIBkxNmOTelMEisrTtqxYMg==
X-Received: by 2002:a67:2586:: with SMTP id l128mr4867052vsl.52.1562856467869;
        Thu, 11 Jul 2019 07:47:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z10sm1661564vsn.23.2019.07.11.07.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 07:47:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlaMM-0003UA-NL; Thu, 11 Jul 2019 11:47:46 -0300
Date:   Thu, 11 Jul 2019 11:47:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] rdma/siw: remove set but not used variable 's'
Message-ID: <20190711144746.GA13376@ziepe.ca>
References: <20190711071213.57880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711071213.57880-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 03:12:13PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/infiniband/sw/siw/siw_cm.c: In function siw_cm_llp_state_change:
> drivers/infiniband/sw/siw/siw_cm.c:1278:17: warning: variable s set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason
