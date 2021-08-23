Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899AB3F4BC2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhHWNeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhHWNeZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 09:34:25 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C3C061757
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 06:33:42 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id dt3so9628192qvb.6
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+i7ftpgcAy6juUqrZQfkVnQ/sNvqoHPFnUsAUO0x4ik=;
        b=bUO7IaUt9wfvoXicoSfWvNK5GhmYubg9q26ENc3ga+LFE3vqz/Fp1+HGuirrNQ/s/9
         rqUo+yfXTDUxO+E5g3TsmjBZdfYgPgsZbr1m+nHWouONgg+/t9h7swAOJO4WhVO2+SF/
         cbDf+1QOAXYizeNFK+JBkX5NQhoIu1CvWojJ5sEMf+075serfTQ2kYrUxOAUV4aZaxHl
         M0AETKXh6J+hV1bcsSA+Jaapsuye3VHURqqEF9PKEHMcst7EZaLyVLg0H22f4ThD4bGN
         gvyBeiuaivgxTtc4OnBPPW6X2v1mSpm7kB9ASg+FMG5YoGCu0EQTDjdaQJI8E02xivg5
         zsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+i7ftpgcAy6juUqrZQfkVnQ/sNvqoHPFnUsAUO0x4ik=;
        b=ong32UDHCJZkYmfnuizuUDmmRZEPH+QThHv9t/XcGCNre4YhI6Ji+SOxlHuW/eHA6k
         CHWm2k+qwHcUYryWmhLoj9kXTD2YRtvJFDo2msWfaUj+xoHokxl6u7GSI+id48eFv7c1
         H8IZshZ6KX4UlpBX5oF5EuDE7TIVvCgdHVk91+YO0qY5FWxKJ85haxjTxQSxj4KVlkJL
         AQCrHpkG3ofBe/bBtZErBRCmtXYtpt3/YtlKDqnTh7q/zzgtJovo5zzYwwOwHHCJLwH9
         fC33IVU7TsFlIcVFIcUHon8auXb2RsUNrf8VIPSazv6ma+pUi2HJMaTAlx1RIfdj8v4a
         d1Ig==
X-Gm-Message-State: AOAM533a3ze3nBIJ+xXlbF95Q5iZzZihY2/c9ViGZFy94kH4XJ3nAjEI
        5UjJooYqY9Y/V2wYZLfXF/zhBw==
X-Google-Smtp-Source: ABdhPJz0YGX9lWSXuoSKnQ/jyr3rhNQEaCoAyF53Ew9VGSRBCOzUKpcfs5ON6tDJnLJ/S8abz7QWmQ==
X-Received: by 2002:a05:6214:2123:: with SMTP id r3mr33266735qvc.19.1629725621588;
        Mon, 23 Aug 2021 06:33:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v128sm8736482qkh.27.2021.08.23.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:33:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mIA56-003Gpi-1k; Mon, 23 Aug 2021 10:33:40 -0300
Date:   Mon, 23 Aug 2021 10:33:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Shai Malin <smalin@marvell.com>, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, aelior@marvell.com,
        malin1024@gmail.com, RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] qed: Enable RDMA relaxed ordering
Message-ID: <20210823133340.GC543798@ziepe.ca>
References: <20210822185448.12053-1-smalin@marvell.com>
 <YSOL9TNeLy3uHma6@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSOL9TNeLy3uHma6@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 02:52:21PM +0300, Leon Romanovsky wrote:
> +RDMA
> 
> Jakub, David
> 
> Can we please ask that everything directly or indirectly related to RDMA
> will be sent to linux-rdma@ too?
> 
> On Sun, Aug 22, 2021 at 09:54:48PM +0300, Shai Malin wrote:
> > Enable the RoCE and iWARP FW relaxed ordering.
> > 
> > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > Signed-off-by: Shai Malin <smalin@marvell.com>
> >  drivers/net/ethernet/qlogic/qed/qed_rdma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> > index 4f4b79250a2b..496092655f26 100644
> > +++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> > @@ -643,6 +643,8 @@ static int qed_rdma_start_fw(struct qed_hwfn *p_hwfn,
> >  				    cnq_id);
> >  	}
> >  
> > +	p_params_header->relaxed_ordering = 1;
> 
> Maybe it is only description that needs to be updated, but I would
> expect to see call to pcie_relaxed_ordering_enabled() before setting
> relaxed_ordering to always true.
> 
> If we are talking about RDMA, the IB_ACCESS_RELAXED_ORDERING flag should
> be taken into account too.

Why does this file even exist in netdev? This whole struct
qed_rdma_ops mess looks like another mis-design to support out of tree
modules??

Jason
