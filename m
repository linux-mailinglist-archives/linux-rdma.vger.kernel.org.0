Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E7C1E86A1
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgE2S2s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 14:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2S2r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 14:28:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9FC08C5C8
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:28:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so3159773qkh.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rlk86kD0Y7ZOuChtwAZS53JYDyHUYd9q2w1SiVXgwbo=;
        b=h0SJbmV2uzmAUrZfGfMgUPc46S/5zrVSX6Cb0OR+d5wx+0QPaLV5Miv1wVCt1J3sz5
         RotknK3P1E7fEZ6COa2LeUNBaMEvS/3KBfZglnMyx4CfHMxndG1WYgJUv376z4dBoO5p
         xOhxktzrIxtXcPw/40+4DbiZbMaIXdrGv7hrEgZ2UJxDu3WNCm0iGOuf2VtkRTeI+PVo
         CiCx2385cqyh6nDsgkh8ElmHtAdqUGWD9pOT4nOxOWpxUOM/TpOuY3uHG23me5NorhQF
         4e/YbcSMdcRxpdpH2yKTL6LzHRh6716lDEvT/kTUc1Q0P6hufI+8knm4kNi/Dd3KzfJN
         GNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rlk86kD0Y7ZOuChtwAZS53JYDyHUYd9q2w1SiVXgwbo=;
        b=FT3Q9u4FBksdYxeiO2Uop9YBg3P65HpgqW9Y4xF171zbILioFwM14ycHzdxJSUNhD+
         uZpNoNyRn2MmaaonFnclDVq2gykwIMESJIH/c6i0OMkYlXHjIfqB9u9MnajUo52wNnXK
         YyXwAeSwRD2Q2EbWk2jArJsGthUSG1O1h23wytiXkQaAHUHqv12UDeQ2lUzLhYS3Z61e
         U6aBqlP4PjFY8ASZ33St1l63nIi49MExgEfcksBPuLe6UbtNxsRgQSkiMHVrv1kY2cde
         owXO8/ukr+/oj4p4B6YOkGOtYhaxKlhA9DRhzBVyHqVtCnHAEcFkqi+JxJm8pFVVIoK2
         SeyQ==
X-Gm-Message-State: AOAM532zs56WSeq/9JwJlNr1AdZx0kzxu52OxWUgayXP/qWAAmOORqNI
        LoO6dSB6W0PpzTqlPGwA+TGvsw==
X-Google-Smtp-Source: ABdhPJyzFCE2FvOpDacsYiCwEegwzE2n8yyVo/63fObTpaWl8qYNnIcz7Ue211P3mhfmAuCC9bWKsw==
X-Received: by 2002:a05:620a:200a:: with SMTP id c10mr8881132qka.218.1590776925083;
        Fri, 29 May 2020 11:28:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p6sm1121953qtd.91.2020.05.29.11.28.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:28:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jejkK-0004oP-1k; Fri, 29 May 2020 15:28:44 -0300
Date:   Fri, 29 May 2020 15:28:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/hfi1: fix spelling mistake "enought" -> "enough"
Message-ID: <20200529182844.GA18470@ziepe.ca>
References: <20200528110709.400935-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110709.400935-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 28, 2020 at 12:07:09PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
