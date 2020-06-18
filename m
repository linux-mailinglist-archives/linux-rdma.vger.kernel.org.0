Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50031FF237
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgFRMqu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgFRMqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 08:46:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE634C06174E
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:46:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g18so4216558qtu.13
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NW0hfwrdssFTFEgxDlJ7PzJv2zZzOwmY3zG9rGUhpqQ=;
        b=BBJXculneVRYCp/FjX0n3PNvsSGPW7p5YNLvi1TpUAD+UUPEL2P6ot9GH3asxsfcic
         WIi1KTj9oGxjYCggPOdttQQsmGdy3h9WxsYReVmouClGrE7m9JSpfln7tiVRRFs/5lYN
         7ndygm53v2DLpChidMRhZRmynEs6HzEXGy4XXXXNwEbY0Mr2yKmzH8DR/fhralPs8JFD
         shhheUEZ6rNIyFIKPgT3EweWKAOJqZIUl9rfCkax+bM4+9sUhcODTJLB3DM1HsmQCwgF
         Ci0em9MnSGeLnzBU+8BCdMsgeRjI/qql7R6ueYXXhwNQ9mc01jc60FsAL1pmEZ6hF9AY
         ufWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NW0hfwrdssFTFEgxDlJ7PzJv2zZzOwmY3zG9rGUhpqQ=;
        b=jULP+/M8RFUItA0leADrI0X9z8L5YZkduccTO2cECQd/zp3uGWYBRYklQ+I91q95dD
         Alk+QQ1b/OhKaOKxfcywGM8RqHcAAhyEB+x9Tf9vJzORoBtBS144eu7ABPZcXXr8mDTb
         hRUeswAKvHAqtuhZIJ0PDbS2oMNACnLwjN9w1P3rOBRiNvoafeKgYaNqYu4YnL3ptxRi
         y42149vs76HhDpqmicBjnGFO+gBZAIMnLz2n3Jzi43xL6BQkFiPDreWLKwbV+AFq01jy
         WRQz8ZJIQJ17hWvRjP4i2LX1YHbZ+WXmBu5Xn5nTnvCT3gLEFsbs0J7FzUFIh89RRhkt
         npMQ==
X-Gm-Message-State: AOAM533sPQX/EZxRqSBkffPXx3xEXJXOHvC8fVC6DqFm/4aNnWQ8R45V
        WQa4+BEfoEaVzH+sdh5LW4A1vA==
X-Google-Smtp-Source: ABdhPJxI4TlW41VD0xDHXGvM2nizvZgsfTmE5Xy3qMSyjNc+xTu1rwRhc7O0HJS+i5r32XaV0V1IRQ==
X-Received: by 2002:ac8:70ce:: with SMTP id g14mr4276393qtp.25.1592484408053;
        Thu, 18 Jun 2020 05:46:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id j5sm3169515qtc.72.2020.06.18.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:46:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jltwM-00A2VB-O0; Thu, 18 Jun 2020 09:46:46 -0300
Date:   Thu, 18 Jun 2020 09:46:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Set maximum pkeys device attribute
Message-ID: <20200618124646.GC2392687@ziepe.ca>
References: <20200614103534.88060-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614103534.88060-1-galpress@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 14, 2020 at 01:35:34PM +0300, Gal Pressman wrote:
> The max_pkeys device attribute was not set in query device verb, set it
> to one in order to account for the default pkey (0xffff).
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc 

Thanks,
Jason
