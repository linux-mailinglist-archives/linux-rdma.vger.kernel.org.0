Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0720F2A2B1B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 13:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgKBM6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 07:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgKBM6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 07:58:42 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3282FC0617A6
        for <linux-rdma@vger.kernel.org>; Mon,  2 Nov 2020 04:58:42 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id o205so4523739qke.10
        for <linux-rdma@vger.kernel.org>; Mon, 02 Nov 2020 04:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ftVh0IvG1sEIjkH01GRF9GbE/QzlzPrqxB3KYI7giHg=;
        b=dTQeo+TFu2pR+ADpUwYb4zPKaPbxGKRC5z5oMAnVBHMFbqxc7wh1ph37DUs6swV+VF
         NXyX3x4+8L6xEBR8m2z0pa+3XlLMaxpMggNr0TbPdCR+exJF5t1zBWw8i9fUY+OfvzwN
         ufyRVS+pTLtC0c1czzEFF0Zy/3Zr70yMGW4ZMBPg18LVME5SZUtFLu52nbmKiZnkqSnJ
         Y8G/q/Egnj16HkzT0+2VFDW9E2G/fH1nQQYimGHptjlhnJ1x71T25Vb/gIKz54ldekvD
         zqjFp8nrrUNbfCEyBpotcAPTIovGcX0VJ0diYaEE4fNOKd5w9YpLkGaMqyfUJPsjgxdx
         c+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftVh0IvG1sEIjkH01GRF9GbE/QzlzPrqxB3KYI7giHg=;
        b=mQEkVjhwNwNCQ7eZW1y6DubvG/Hi5CEmjmHk8Z20Y5Fj1kTR1qy7wp+Co25CB5fRSu
         PR0MpfGNuA52BNHMey59Xi8Fezol0MHbEBiyERNFMVOtDL2x4GI3KuFz6kDw8sLKwH58
         zp+7rEE9ELCbO9QNw3g5Ig3hSlQQg+dDQi/pdx5/qOQJmkqaveqvYAdGWghL/Ret/z8b
         lfqK1yHO6thgU1Kdh1rxs0fPVPGIpHYfes4pdXFhwmm1NBN9ziDrJqPXd/pGKXKEDI3f
         8tsEHWCI7Wn6HSVR8JCEGK0radEZcP3FI8QxmljCqhh8iNwzLPH2vlcrrF6SSALkBksi
         SLEw==
X-Gm-Message-State: AOAM530BQ+va1sRC7d+QmygBY1Gta3IuUO27iOe4vn4WgnQAw6TwuOTW
        ZU8vw0tce4A2O1MatShMmk5L0w==
X-Google-Smtp-Source: ABdhPJxldmhw4eD0LX2pkKyhXzJ7hvFJi2qSYaY3jwYsA6V/TQXNg9ZIfF0m5X4uL0kpnRWoUgRAnQ==
X-Received: by 2002:ae9:f448:: with SMTP id z8mr14283895qkl.319.1604321921282;
        Mon, 02 Nov 2020 04:58:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d18sm6101959qka.41.2020.11.02.04.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 04:58:40 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZZPz-00EvPI-SJ; Mon, 02 Nov 2020 08:58:39 -0400
Date:   Mon, 2 Nov 2020 08:58:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     trix@redhat.com
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: remove unneeded semicolon
Message-ID: <20201102125839.GB36674@ziepe.ca>
References: <20201031134638.2135060-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031134638.2135060-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 31, 2020 at 06:46:38AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If you are going to send these can you do the whole subsystem at once?
I don't want ane endless trickle of one line patches

Jason
