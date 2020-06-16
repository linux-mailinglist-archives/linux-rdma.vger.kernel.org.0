Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4E1FB355
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgFPODg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbgFPODe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jun 2020 10:03:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E7C061573
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 07:03:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i16so15498606qtr.7
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACKmBaR/A6cd2bCSsY4TtDQZawJ/fZLCB0tgBEPjspc=;
        b=JoF0U+peCbZufnRfaFh6A4pof9X8sa1MBKLTnYIP+89/zaw+EP4HHniqmBUW5AScGm
         Y8GA6Xi2WuB46bzTTANvJZdOlv9bKvMD+xD08VrV9dHTNqfGhbnbLn9HIn2Mszd8KmUK
         OhezAFhDuBNqQBCyOt+6mi6RsvFHR5OoHs52Fq+7Yzt2gj8V1b/zL9sAhRbKFuqSQdTy
         ctYZ7sRFGWxfhXc5Ragkj8PRBGCzvqT18atAtvfrFnhh3cWHQ/VMVHfEUCDPrsxcRfI2
         w9RIe1AIOOp0ueN9oT/fM8/fzyQa3cv53uQVVxAN8Ky5DoampTaKtDj8Brku2j0IgqjM
         d+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACKmBaR/A6cd2bCSsY4TtDQZawJ/fZLCB0tgBEPjspc=;
        b=r0s+gOxXRLIuqGWwD/mIAXmBRV45W9W5Uq5jlrLRjv+IEgZ6JkU8BiZjm40h7hptH3
         46doeh6xsq/mgP2JOKRLdkAfaU4KECYMdIFVh7Wwxg4x0Y8cuTngJk3QM5e3rDnWu5UM
         /nyZPXYYxv7ubCe4Znyk5tJVlUUv4kLDOjiddaUVGpoigAcRTgC4oq3Sg4T1Aq8EA0lV
         fYA4rGED9kBTP492NVCwSvVh9y0OirFzh18g/8cCKvQMhRwV9hSxeZ8ybk8+3mwv/Imp
         6RJFZhY2Y35jmO2GBAkRSbAPkmJpgFO0g19JUkuvf8Mz/pYKqLd81BnWJ9mvjb605CBv
         rQKw==
X-Gm-Message-State: AOAM5322dAxOw/mJuIgYqfETWIZp8Btam+BvbbTZqYdprhS4nKg/aK/x
        OhGWSC1b0P8CVgCzCg7Q2b4k/0E2JNSr+Q==
X-Google-Smtp-Source: ABdhPJz/5FxqA5KyTqiINYpqdpo6LlQBtlB3VGul5eQwf3j/YT7G4vSamcCo2VgU7i8LEHtW2cptaw==
X-Received: by 2002:aed:3ec4:: with SMTP id o4mr21909873qtf.357.1592316213120;
        Tue, 16 Jun 2020 07:03:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m53sm15843384qtb.64.2020.06.16.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:03:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlCBX-0094t2-Rc; Tue, 16 Jun 2020 11:03:31 -0300
Date:   Tue, 16 Jun 2020 11:03:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in siw_rx_pbl()
Message-ID: <20200616140331.GA2163432@ziepe.ca>
References: <20200610174717.15932-1-tseewald@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610174717.15932-1-tseewald@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 10, 2020 at 12:47:17PM -0500, Tom Seewald wrote:
> The variable buf_addr is type dma_addr_t, which may not be the same size
> as a pointer.  To ensure it is the correct size, cast to a uintptr_t.
> 
> Signed-off-by: Tom Seewald <tseewald@gmail.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
