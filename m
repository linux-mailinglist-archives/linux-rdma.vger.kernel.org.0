Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A32287B33
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgJHRvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 13:51:49 -0400
Received: from bosmailout02.eigbox.net ([66.96.188.2]:48089 "EHLO
        bosmailout02.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJHRvt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 13:51:49 -0400
X-Greylist: delayed 1820 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 13:51:48 EDT
Received: from bosmailscan12.eigbox.net ([10.20.15.12])
        by bosmailout02.eigbox.net with esmtp (Exim)
        id 1kQZbb-0003e0-Su; Thu, 08 Oct 2020 13:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cornelisnetworks.com; s=dkim; h=Sender:Content-Transfer-Encoding:
        Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yb1lUypEdJ/LD4Wgo98N0rSSOnyZm2qPCY/lfpwhHrc=; b=xQzlvO10sHeOKA2ydQPJP0e+dZ
        yvn06E5/3wymqgjD+7PlPH7Nk7ahYFQJzo6b7hPdX/lmk/9ccVvOpqI83l5fVEHhZ9fxN3goXio8Z
        wDnZRDzLUWUxxcxNQVHIRAE/M+ZS/GMjCwrNhZ7HQhd8Vp7YWf4r+9stDv32fbE3SIAdLp4qVtJOD
        yh1oKDCmCpUDrgFJIJxAUgAKKkWfOBeRzNGfwp59O5a9bW543kQALfM25WfWGVtEOVMm7NAoZX6N0
        Xk94Bs6kwLneZHWcFl+phHRK+PzVS2do0LHqccnpFRbIybANToqyRav6rH6c5DhEdiaYbm7dsSAMp
        EfUS12YQ==;
Received: from [10.115.3.31] (helo=bosimpout11)
        by bosmailscan12.eigbox.net with esmtp (Exim)
        id 1kQZbb-0004rP-IX; Thu, 08 Oct 2020 13:21:27 -0400
Received: from boswebmail08.eigbox.net ([10.20.16.8])
        by bosimpout11 with 
        id dVMP230010ASFPu01VMSgY; Thu, 08 Oct 2020 13:21:27 -0400
X-Authority-Analysis: v=2.3 cv=DtjNBF3+ c=1 sm=1 tr=0
 a=nrbQDdKp8bIvKAbSIVj10Q==:117 a=PId9yTw908ogKca1p5g/DQ==:17
 a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=DfNHnWVPAAAA:8 a=LRYjQimtAAAA:8
 a=xe5bB9sYCSZpmBIc9o0A:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
 a=JC7xiqAVgOyvJ6DxgMma:22
Received: from [127.0.0.1] (helo=domaincom)
        by boswebmail08.eigbox.net with esmtp (Exim)
        id 1kQZbX-0004VS-1r; Thu, 08 Oct 2020 13:21:23 -0400
Received: from [192.55.54.42]
 by emailmg.domain.com
 with HTTP (HTTP/1.1 POST); Thu, 08 Oct 2020 13:21:23 -0400
MIME-Version: 1.0
Date:   Thu, 08 Oct 2020 13:21:23 -0400
From:   dennis.dalessandro@cornelisnetworks.com
To:     Colin King <colin.king@canonical.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: Fix sizeof mismatch
In-Reply-To: <20201008095204.82683-1-colin.king@canonical.com>
References: <20201008095204.82683-1-colin.king@canonical.com>
Message-ID: <105407a6e7fc28b57cbe5550b8c01c45@cornelisnetworks.com>
X-Sender: dennis.dalessandro@cornelisnetworks.com
User-Agent: Roundcube Webmail/1.3.11
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-EN-AuthUser: dennis.dalessandro@cornelisnetworks.com
Sender:  dennis.dalessandro@cornelisnetworks.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-10-08 05:52, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> An incorrect sizeof is being used, struct rvt_ibport ** is not correct,
> it should be struct rvt_ibport *. Note that since ** is the same size 
> as
> * this is not causing any issues.  Improve this fix by using
> sizeof(*rdi->ports) as this allows us to not even reference the type
> of the pointer.  Also remove line breaks as the entire statement can
> fit on one line.
> 
> Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
> Fixes: ff6acd69518e ("IB/rdmavt: Add device structure allocation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/infiniband/sw/rdmavt/vt.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/vt.c 
> b/drivers/infiniband/sw/rdmavt/vt.c
> index f904bb34477a..2d534c450f3c 100644
> --- a/drivers/infiniband/sw/rdmavt/vt.c
> +++ b/drivers/infiniband/sw/rdmavt/vt.c
> @@ -95,9 +95,7 @@ struct rvt_dev_info *rvt_alloc_device(size_t size, 
> int nports)
> if (!rdi)
> return rdi;
> 
> -    rdi->ports = kcalloc(nports,
> -                 sizeof(struct rvt_ibport **),
> -                 GFP_KERNEL);
> +    rdi->ports = kcalloc(nports, sizeof(*rdi->ports), GFP_KERNEL);
> if (!rdi->ports)
> ib_dealloc_device(&rdi->ibdev);

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
