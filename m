Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41CC1E146F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbgEYSit (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbgEYSit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 14:38:49 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440F6C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:38:49 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so1460276qkh.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NdhVMHdlCcbJ2SGE48iM6uO3Xk3u7Wj29bzSQAwdeU=;
        b=WK2wgcGilop1MwVzfyzGLWZUEjzrXDgLBjbs8KEXuVeuuEr8TgcnN3kPK3t/xueQuX
         BxNvuya7TiczdhNqD3D4UkMrwre4PJqMyhVAV3k7+gLQsXhL4Ka8t6ZydKBFDLk03xRy
         xM2KtWFXdU/LEEq2TbqmLybmbYTmu4zYSvPJ9uEt7gTIt5/vFzq6GZo9lFhvGAW+EH9d
         9Dhv/II4C561tx98DEGTOHy89ufDQJeHgNFjOxtO0vRKIkxHXgvgTL5YLcZ86NEDxNYc
         6IqkNlkXd1y9uHoRTvKMQsg3vwVgtGytqwj7T9SXqa61REsYL0tsVOUYllKmD7jR7i7/
         4Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NdhVMHdlCcbJ2SGE48iM6uO3Xk3u7Wj29bzSQAwdeU=;
        b=Z1BThQ/0UpGDWmA4h5EoxL4Rjix3fNFiClQHBR1f0US2jR8h6HL+IVfU0Y7YVkgnAL
         196vxuucA67w1AptCH3MoCkbeY1NTam9iwSF7EC1Tb8/zcApCKN4W0/OwUL2pWAJ1YeG
         /SoLS3qtWi7QW8px/cK0YhNaEtN3WRLPHphY8Z7BB7W7E0/7W/rIi8ghB57zqUBChnYu
         6IXX7LkiNUSBUrfEwvo2YkpRWDd95Eci7BQanqMXK0ETt+X4+yLp0ij2r+iD39pPb8En
         hdUup3bIZL4ED3ILJGKg3IBcMiHDiCAK6dfLthSH+VocBxKvsxTr3jLKutKm6JvssWX9
         QvgA==
X-Gm-Message-State: AOAM530/VbWSTw5BmIm+e1BH/3JhgxSH35lmoJoxlw49T9d6uPRWvlhI
        Zag6JZMaJRsPbYxFc5iXnZYrPFLcs5U=
X-Google-Smtp-Source: ABdhPJxNxahf01c1Cn1NeYhBsS6FvkXAyFcsjciv0ItmUEIRYkFm76LfaAT2xZFnJ0TlSxWQ73Onew==
X-Received: by 2002:a05:620a:13e1:: with SMTP id h1mr27089277qkl.424.1590431928548;
        Mon, 25 May 2020 11:38:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h77sm6174935qke.37.2020.05.25.11.38.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 11:38:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdHzr-0007eL-KD; Mon, 25 May 2020 15:38:47 -0300
Date:   Mon, 25 May 2020 15:38:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-next] RDMA/iw_cxgb4: cleanup device debugfs entries
 on ULD remove
Message-ID: <20200525183847.GA29375@ziepe.ca>
References: <20200524190814.17599-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524190814.17599-1-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 12:38:14AM +0530, Potnuri Bharat Teja wrote:
> Remove device specific debugfs entries immediately if LLD detaches a
> particular ULD device in case of fatal PCI errors.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/device.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
