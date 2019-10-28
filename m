Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9FE7866
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbfJ1SZc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 14:25:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35292 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733204AbfJ1SZc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 14:25:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so5470149qtp.2
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t71jXgJeYLFmX0IKk+gR8k3GqBKQELR9GtxYOxiQcp4=;
        b=TN4hTqQE8VCVdoIPeL8jcTTx66Xa1BM1NroN+UBgx9V6JNRm8t5F6fr5YMLvi9VMtJ
         dObraoyEdCqEYSgPOC2+0SJWPvb3/sAHwk5yAribbIRWr5wcURlFdgOOnPuW/pY7WN2f
         NwlK7N4+1LAGimflEQ/rnBCZSr4rAFypuV6r9aDFTOuGncF7iKtv9X8dcCI0kGFuIe4m
         3urR6OTHelpzLEBl0r+rBySQ4t9hnWrOFD72h9lt5YBRI674MT4bWFjEcejqB8D4oooP
         y2iFNxEaOH7+5cTJn5XEHChFC3GH9DgM9STzdDYHX9UY4GitNKdtFFULhcWEA1AKW16s
         r3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t71jXgJeYLFmX0IKk+gR8k3GqBKQELR9GtxYOxiQcp4=;
        b=EEmuReTxJFuD+r2Na9k8lFbcILOOa6uFRlcP0EjMEBSnOiST7kxv4w3t88n4kMtQDG
         Br8GyU4wrW2vVapij+ngl3mkLeZytKPHBGS8VHl7o6bubNFJLUECH69eRt3ARfGeNC4F
         M4rZ1CsWckw/W62xI71vSVl3NqbGo58vB25hDRTgkGeMmLwt2Ijigf5o8F2xT6UxH/ft
         ye8Dz6cIn3TF5RcfpdwM7aCi3rJ76sSzW/7sJuV6UmZHTLm/aoaNgSnbRlonojmlpRvg
         4xsv4yYy2wPdqPmqNQQV/CMdZPTLar7bQ8NyYdP9bQgKy/MFKoq/ORQsmVmnWLeyJgtR
         Ny1w==
X-Gm-Message-State: APjAAAVDg0IMqyOHanF9CqDzZL/J7wlyGSJu4XwL6QsIDHJK2tccIuak
        AohcBzrcboK5duP115GdwxfU4Q==
X-Google-Smtp-Source: APXvYqzc+77oUZMFPubZPvFpy0/nCpikDLMuuuab4MCEMojCFTipngiZA29IWs9N0mGecf0OPHVmcQ==
X-Received: by 2002:ac8:18af:: with SMTP id s44mr11483566qtj.78.1572287129563;
        Mon, 28 Oct 2019 11:25:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id e3sm694507qkg.136.2019.10.28.11.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 11:25:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP9ho-0003pc-Mv; Mon, 28 Oct 2019 15:25:28 -0300
Date:   Mon, 28 Oct 2019 15:25:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc 2/2] RDMA/hns: Prevent memory leaks about eq
Message-ID: <20191028182528.GA14706@ziepe.ca>
References: <1572072995-11277-1-git-send-email-liweihang@hisilicon.com>
 <1572072995-11277-3-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572072995-11277-3-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 26, 2019 at 02:56:35PM +0800, Weihang Li wrote:
> From: Lijun Ou <oulijun@huawei.com>
> 
> eq->buf_list->buf and eq->buf_list should also be freed when eqe_hop_num
> is set to 0, or there will be memory leaks.
> 
> Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applies to for-rc

Thanks,
Jason
