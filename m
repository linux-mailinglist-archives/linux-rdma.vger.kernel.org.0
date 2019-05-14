Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE11D05C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2019 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfENUPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 16:15:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42240 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENUPJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 16:15:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id 188so408669ljf.9
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evUJ73BNRpNMChjJ0udr79nRnFaauyNKnbrQ2DObhvY=;
        b=D6/iPMQbhzRS0aI7BTNFpNB4YoUJADt8Ti1/WfMtLQfUfXn5OafIHLBBhNXTlYZ1gz
         DYcNbg5JBhwVoZHLv0rcd7NyqRXROADjGWcRkBwpY9RhO78pKHNaqFdKzvAISH+G7hDs
         UJmfU0Iv/aFLQNAXyTg8RS7DJllIsw5rtKzme3fPWTpr5TCOhqM18ZPPWoDxCm8IHsv4
         W7CNYby0lDONJO+pCSibHDriKKBTjzJDNXumCGsVpG8PTygW8nPjXcLcst171WO+y+aO
         CKblkE1azP1KM65xkBWfPvyG+9SesG7RtNcvc/S3F/6DK0hAy9Xpyweh6Y1IOwh8iqG+
         wzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evUJ73BNRpNMChjJ0udr79nRnFaauyNKnbrQ2DObhvY=;
        b=J4q/lQ9PNE4ozaqxSKcva6foGVBKoCR5WLldxNjLZ1wHPOr69h8FDX4L0oRzqTuYLg
         VSuKQ3HGpUPYGjI0ec3DDfeOB/9F9eCW7Ez/HZV9DE8MhWt7JY+jb2mnCwZaVBR6pHJL
         mR9hruNrq5bJp04WKZJJw6DviVQhTuTS0KZyVuiiO2idmosOWUleEyDL4IJeNFg2PivD
         gNUQWqzvFKSsuSR/ZnphZT677p7YwKykc6u6jlypgm211wphfPlNjgUK+ewUpKueSM1r
         nEyvORDhxtdjaHVHpIEcQfE2zwGCVpaH1PCQRjwX+oDFMYMhjXdXgonYYMoCARi6h6oL
         qH+g==
X-Gm-Message-State: APjAAAWJv6GnRX6saySFPDaF+6XNhPr/af4Tz/dRsBUpPidaHFebjtfl
        DRmAjmCZ3Wv+b7eoAD/09lqcEVDGljTD7DY+BZYvMA==
X-Google-Smtp-Source: APXvYqwXW/RjbA2gJfiYMd/owlxSn2vSUQfsqIoqP/GB/V8/8cJJ06qIyvKsgMjoAY14AAb4sCv9JdUYXSYqoVCmXHc=
X-Received: by 2002:a2e:80d5:: with SMTP id r21mr6619410ljg.43.1557864907702;
 Tue, 14 May 2019 13:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190514114412.30604-1-leon@kernel.org> <20190514114412.30604-3-leon@kernel.org>
In-Reply-To: <20190514114412.30604-3-leon@kernel.org>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Tue, 14 May 2019 13:14:56 -0700
Message-ID: <CALzJLG8R-MMef5_y37p=dh4iOG2Bt7=AKNq+3+uTg5=cgbDRRg@mail.gmail.com>
Subject: Re: [PATCH mlx5-next 2/2] net/mlx5: Set completion EQs as shared resources
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 4:44 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Yishai Hadas <yishaih@mellanox.com>
>
> Mark completion EQs as shared resources so that they can be used by CQs
> with uid != 0.
>
> Fixes: 7efce3691d33 ("IB/mlx5: Add obj create and destroy functionality")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 3 +++
>  include/linux/mlx5/mlx5_ifc.h                | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>

Hi leon,

I see the patch is marked for mlx5-next,
As we spoke earlier, let's push this directly to rdma-next and skip
mlx5-next, we will need to reset the branch soon, so let's keep it
clean.

Thanks,
Saeed
