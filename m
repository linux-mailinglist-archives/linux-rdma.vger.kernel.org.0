Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B367492818
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 15:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbiARON2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 09:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiARON1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 09:13:27 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6725FC061574
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 06:13:27 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d24so10236828qkk.5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nb8WC8SnXdnSYL0Fu0HNaT4k/h40Hd/vzNC2qAWbNaI=;
        b=lrHm9QvTFpdFd3xqqKQvy66ZiVrBRfWtMA/x9OaIYRC79iGXGG9aiBeRp0L6X90NuF
         543YPPompzZ+ezIzdGpncdfqF2wFnCK0Uh050NRsoRbHWOc8XWPnbh38QOifBDcSE6Wy
         336xxXUjEZ1AM1O3Nqkn+iPggPVoIYfMSwMucac2f9MJOYoKAxfA69TSI7iQX0tZkkKT
         sL4IdXNFPoMAE3BHGU93IBgR1QRxZOFltPewkRxp+6O3g/VNbh5nRJrGDYvYKN4V/tLb
         7TO9r4IMd+zm7RfdVd4lrLSCN8YBM4v1Lf52RDOnNYVoDOyg/vYrWXd9j5RpITwChK47
         t8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nb8WC8SnXdnSYL0Fu0HNaT4k/h40Hd/vzNC2qAWbNaI=;
        b=LApxYtAol+zYrjj63Ni7zNFCOplZPmfH0FYvrgTPurauybosraTRVrVwIZpIVWhfcZ
         ENNhBxT5Zid5ABQGJtCJuFChUV55+DdgYrTnl0C2R9Vc+FWQ+yUXBsS5Mi072cB+Ttp+
         wtEgLg52hfxALAXf8+onHW+zJKvyVBPxpCMs2tEZGg4vcx+hUJ8t2yWLAqbw0u4UO7bT
         nkHZQzobw4ql2dyiAcNudtYZU7ijqqyZc6C4VHBi9ZFTiluf1Gny1h+kADQtHWh3ij+7
         SJl/a5w1pOM5y28Ag6QIYIo1XA1enBJsBBrQsjLZlz116lLsC3vRvui5V5UMg8tGp3Co
         a/uw==
X-Gm-Message-State: AOAM530FGNdW6rA9ZZWNucUsQ9Bzfx4D7bxo3TevoN2pQ3EfBXMaV/Ny
        eqhm55N3GpYZonCgm1lakWGL0A==
X-Google-Smtp-Source: ABdhPJx43FYYPuX8SPm7dj+ncZcbuQN5hq+ASz8UL1z4+GBovNH+vynmqwMN/JBZYKMRtNnNfutMWg==
X-Received: by 2002:a37:a0c2:: with SMTP id j185mr18105357qke.269.1642515205988;
        Tue, 18 Jan 2022 06:13:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l10sm4094908qkp.41.2022.01.18.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 06:13:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9pEi-000rHB-F6; Tue, 18 Jan 2022 10:13:24 -0400
Date:   Tue, 18 Jan 2022 10:13:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Message-ID: <20220118141324.GF8034@ziepe.ca>
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-10-chengyou@linux.alibaba.com>
 <20220117152217.GD8034@ziepe.ca>
 <adcb2e8f-4383-bc54-b4ac-1e41cbdd8a3a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adcb2e8f-4383-bc54-b4ac-1e41cbdd8a3a@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 09:03:47PM +0800, Cheng Xu wrote:

> Before calling ib_register_device(), the driver must call
> ib_device_set_netdev(), otherwise ib_register_device() will failed
> due to NULL netdev in ib_device structure, the call stack is:

You'll need to fix some core stuff to allow an ib_device to defer
attaching the netdev, nothing does that today.

Jason
