Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4F393E2
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfFGSCE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 14:02:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41336 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfFGSCE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 14:02:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so1804193qkk.8
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sPKiYf2GbsN1ZO/FVtc8+eO5+/ZcVbaXQW0ECSXoyLk=;
        b=I5eqGXs0lEizhC1UVt1026DNflxQh5kscyL7Jihrpo+wF+AMpandWo9rhFGCrMvOqx
         Fh8Yna4dKcAKf+NkPTeqPaoCSDOh9dUD2VtGCyOL+4VbevjmCn0gKrJ5JNG7ssLUdgvS
         /T6ocK8hVd0AkTDKrzN4vCBntE4h+Unss/6qgVdbpnA9RETCl2/884DdeC2HmEmQXyCh
         ccDv96k6tM7MDPdAZJOt9p1hOalpkDuHNIGuVO81oF1R9vhzfqrT1ygWoxMNEDwT5aE9
         3bKrWnGMOEeAUVbpldKoM4M7d+oQ6+EgA44v/CIZXL8i8FKg46Ko0+FAz6PrxI8iwT1p
         Xjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sPKiYf2GbsN1ZO/FVtc8+eO5+/ZcVbaXQW0ECSXoyLk=;
        b=iuWFb12A7pc51PETv2/hnU93aoREKUI46bxnyUbSdM73iHwhAFiSLFlDGYNOV+7okF
         cNPvU85vLpNFsz42gm2lPGQpeCnbttGecnoHQk7btDaHnLFId3Aoe35l0RUh0UJsRjsj
         z0CxvgXRdU8a7WcJDmF5gCkHYyOWk5zW6nyc/4YB1VfHf/MOYV4na6+s/0yBM7wnmNln
         A5WM9AVErkCtLd2Bl6p+M96K7pufHVDz6F7w+NbEcB1fZKdKQ1/mJzo+z+gBqrWek4VM
         7E5m5LbzDGDTX04PuCoJmI3n5BpyTGec28hXgaw89JA6kgKr1Tj/+AAEgc7t3icEGKY+
         Ty1w==
X-Gm-Message-State: APjAAAX+9xuZyNoljRWK8BJXCfSEER3l4+r0jNXPC0Opu1nxfLMUOVxc
        x6jMvoiG9SsWnSIf3oPAUtFT4typrXlKEA==
X-Google-Smtp-Source: APXvYqw1ymPovZ9vKWQZdzVxMcP9Taaiu15fnsVdhEXYUMV1+prXvc1b3pQ+9Qv0I5yosEy/USUlSg==
X-Received: by 2002:a37:4747:: with SMTP id u68mr2406811qka.115.1559930523089;
        Fri, 07 Jun 2019 11:02:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y19sm1594144qty.43.2019.06.07.11.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:02:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJBi-0006bK-3F; Fri, 07 Jun 2019 15:02:02 -0300
Date:   Fri, 7 Jun 2019 15:02:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Bugfix for filling the sge of srq
Message-ID: <20190607180202.GA25350@ziepe.ca>
References: <1559298484-63548-1-git-send-email-oulijun@huawei.com>
 <1559298484-63548-2-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559298484-63548-2-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 31, 2019 at 06:28:03PM +0800, Lijun Ou wrote:
> When user post recv a srq with multiple sges, the hardware will
> get the last correct sge and count the sge numbers according to
> the specific identifier with lkey. For example, when the driver
> fill the sges with every wr less than the max sge that the user
> configured when creating srq, the hardware will stop getting the
> sge according to the specific lkey in the sge. However, it will
> always end with the first sge in the current post srq recv
> interface implementation.
> 
> Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
