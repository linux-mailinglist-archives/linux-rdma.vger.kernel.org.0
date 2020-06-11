Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D081F6C8A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 19:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgFKRFq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKRFp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 13:05:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330FC08C5C1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 10:05:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g62so5103375qtd.5
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NssTrx1jk5m6rHGYdSicwKv/R+mXD0HDLUgOmgn7JI=;
        b=fhg1PshYUw1/RPRqu5whHwL1TOSEZFqJnjPHNcPWqDAUIhNC1aRP7GlVz2CXZ6rR7j
         rSgjO7dEMNwifuMUTBb/5w2L9iZ2cL1VOQPmAwuq5dmBP5MDENfNE3OZvDwLVI5G6BXs
         CVT/fyjRpJiP94f83E2RZZCV+jRJITjWsWI/tQu1SXTkcWs1DL80Wy8sQZ8iwP2n9Sut
         P8Lp5LBnDxx+JkZDypWsjXUvgw7bmODkiYDotP5zy1qEf/GsrB1alXvBQijUH1lhbllb
         /cZL5ZaJ5hcLAUGMGOs0plcpBX1GBQN9LigjhfcZzGhwH8GVy0nriOD/N1jOsC671xlb
         7sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NssTrx1jk5m6rHGYdSicwKv/R+mXD0HDLUgOmgn7JI=;
        b=Nceqobqs1b5Yrx6ZtpDpEkuqyJp3yz7DndGU7IgUk0PDxVZ0vPhBtcAxtANC8exgvZ
         RGOZzWt+J4uf2esXvBEPftxAat8Fk3uxsMxmTZKNEqvjNZhXrjX8kMlNzM0aqKvNLLs/
         /7RQLwpF0a+o1y0cW2meLZLwqiMiwFO+NKMLfhMC52RkJdgPMVXZ54APtx1r0nhi2W5W
         rQxOdHExAw5RvDRpK+h2sTKH4z+Jv65BX6CzyxmUUawBt2WyqkHKjv/ra1vC1SmtzcOq
         wp+9d11Tln6KfH861YzerNUqAbHP+gqLnyJPK7d/Dl1pg/zGnYMfy1uQi9jttyAYlkGT
         U/2A==
X-Gm-Message-State: AOAM533xl6uuiBzD0v1OAUSSDdgcHuueuZTtPX4ibp8F3WECpe7gzw2G
        fQPW3a1UG21jfhWXiVvZSIihOPZzcx8=
X-Google-Smtp-Source: ABdhPJzR3nY093YJHU+y9KDKb0kAdX+LrExy88qwGVoZ7wawzoJgELzPvhyJXTc/Cq0fttqq6xiV0A==
X-Received: by 2002:ac8:551a:: with SMTP id j26mr9587353qtq.237.1591895143856;
        Thu, 11 Jun 2020 10:05:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w10sm2927702qtc.15.2020.06.11.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:05:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jjQe6-006EAg-ON; Thu, 11 Jun 2020 14:05:42 -0300
Date:   Thu, 11 Jun 2020 14:05:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Tom Seewald <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in
 siw_rx_pbl()
Message-ID: <20200611170542.GY6578@ziepe.ca>
References: <20200611142355.GX6578@ziepe.ca>
 <20200611113539.GV6578@ziepe.ca>
 <20200610175008.GU6578@ziepe.ca>
 <20200610174717.15932-1-tseewald@gmail.com>
 <OF2F6FD798.5AF6086F-ON00258584.00329A25-00258584.0038EE32@notes.na.collabserv.com>
 <OFE9B278DF.7F90B863-ON00258584.004CDA7A-00258584.004DFD42@notes.na.collabserv.com>
 <OFD3ED6A67.BCC6E1B8-ON00258584.00526201-00258584.0052F73E@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD3ED6A67.BCC6E1B8-ON00258584.00526201-00258584.0052F73E@notes.na.collabserv.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 11, 2020 at 03:06:12PM +0000, Bernard Metzler wrote:
> >> It initially comes from the scatterlist provided by the
> >> kernel user via drivers .map_mr_sg() method. There we get a
> >> dma_addr_t describing the users buffer.
> >
> >For the SW dma maps you have to convert the dma_addr_t to a kva using
> >kmap, it cannot just be casted.
> >
> True for a real dma addr. But here the user initially came
> with an address it got from dma_virt_ops.dma_virt_map_page(),
> which provides the virtual address of the page referenced,
> casted to dma_addr_t.

Oh, that's curiously broken on highmem systems, but OK siw is fine
with it like that, though I think it would have been better to have
some helper function connected to dma_virt do this cast.

Jason
