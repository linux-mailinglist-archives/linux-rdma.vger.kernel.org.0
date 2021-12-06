Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A651446A0D5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358357AbhLFQPW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 11:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385948AbhLFQOn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 11:14:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E890C049795
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 07:57:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so44611290edd.9
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 07:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46Qvoi33xTYx7/DTV8RP0kBjWZAK5hNtDA+vKe1nbJ4=;
        b=ERzf9vakzuRP8lKOllzd/5lARSwTThfKllVQx7mLv6dS9eJ5Ja5736pBuNwFve/SPE
         7LsdiuTXRmTE8i8ryhK46B5O1Y9tbeBpO24IlXs43uiOjaY2g/2Qm7OKtxT5laAihNa4
         GvZ47PUtc1/m2743Ct4CtB0EYj8+m30O7JPJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46Qvoi33xTYx7/DTV8RP0kBjWZAK5hNtDA+vKe1nbJ4=;
        b=1yvVM+xrkdDXmBGcEOBbO0ZIDfMvKvURaeSCN9M1xWNYV5rzi5WQejf3KnjRym0jcE
         22/8kvtV+TyZH16/BcDbp1ybW8FHdt59mAckOCfUqE+jkI6/gitMwF8RzKGDdBZ2UPy2
         gV2soWqG58D5pD+ZQLWWqFIDZ4cD6UoiQHfRCHoivbLeJ1ViCJL7+bLNeGhGLlm7lD/u
         Bx0KFRR3AQGcHPFxboKJEZsk/ZRvIR1412ngQX/PkqN14G9ka4Um04NwQaykqU1EUbhI
         PHmIdbShg56HRvVFZEtVo6C8MXwTe+9yE9kr8W4o7mAdcLSflKXetalCO/4rZaYmOuA4
         0AXg==
X-Gm-Message-State: AOAM5334ey+wCAZ7Frtbk23CCP3lJDj/UplPhVGYpIxRWx2O9vOjBcV0
        i/gjp9vSrcXiBqFlU7hkqpgqF9KJTBSTs3erPcehQ2rSqSoHkw==
X-Google-Smtp-Source: ABdhPJxTueCCaGhKL1zmxU0yQtUerCJYVlYlYHECVs4F7740SkqbPod7WsrE1tsrpYBB3VgGEHvtk9bGuUBE/8nN7rM=
X-Received: by 2002:a05:6402:3481:: with SMTP id v1mr57383913edc.337.1638806240081;
 Mon, 06 Dec 2021 07:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20211205204537.14184-1-kamalheib1@gmail.com> <Ya26j0Amo7ENQCYz@unreal>
In-Reply-To: <Ya26j0Amo7ENQCYz@unreal>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 6 Dec 2021 21:27:09 +0530
Message-ID: <CA+sbYW2weEbX-OJRozWwfDRg9rjhKMfOcPcLm0KoYsNOE4sTgQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Fix endianness warning
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 6, 2021 at 12:54 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Dec 05, 2021 at 10:45:37PM +0200, Kamal Heib wrote:
> > Fix the following sparce warning:
> > CHECK   ../drivers/infiniband/hw/bnxt_re/qplib_fp.c
> > drivers/infiniband/hw/bnxt_re/qplib_fp.c:1260:26: sparse: warning:
> >  incorrect type in assignment (different base types)
> >
> > Fixes: 0e938533d96d ("RDMA/bnxt_re: Remove dynamic pkey table")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> sparce -> sparse
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
