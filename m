Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583F11FF22C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgFRMpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 08:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgFRMpO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 08:45:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5C2C06174E
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:45:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w1so5318849qkw.5
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4kGWrB/4NpCEqmTSHvjNx3cJ/f+aB86aF35sneU7DY=;
        b=ddnpjIUtX+ABPwwnvSp+MnhDJnXzv/8dNxlb2pbPjFkv9bROktCOkv0qrpt5mCc8oi
         zH2mjC9PWAfxRBXebZUM9YojQy06qfxL8wvelNJXuPkqiT/DnvJaolYYBwBBfH9DO9/z
         fUawUo8Zsj/XMplaUcxx4PO2BZGKTNPveOPxY1lid5eSQ7tYFFoZPNO+HBbVmUOwAFMu
         +xQqqUlVnKJT0IO26rNcuhiIw2T5gvjB4sogHh/RU/bRYIOA7ZtMPBduyso/yFx7tDId
         DpMvmGVFJNztgUAVJVKiMJHTfnGjCKgiP+BEILv47CU/dAUn3fPmnRGxvWdhecyYYLJd
         vlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4kGWrB/4NpCEqmTSHvjNx3cJ/f+aB86aF35sneU7DY=;
        b=ZE60WPAdWDDV454YfmNRHSPhl0DO2A/SI3/Aavh6CEmzFclAvQt8l8Umey7Clu51cj
         7C/EI7Sgzhi/Elbe+GghnBp4FgS8+fZ0hED1FxsL+cbP/oMxhI87LEBUhnJ580u63Y0w
         UdiwCvi2/RC2zDf5J2cYnyMXH7JBVQCH5vFz2MbWHUq/4Z/VU9AaJYJUU0IurylpRh5k
         a6NOkvIDWZHBeVNI+kO2ZIGsJkOGS/0Z+ETMC1AzUmDCyqtFCSVY1+V8R/q0/cCHFjn6
         EldCEujw7ZL0H7opUBGotj7240aEc6NkPjZkmosJEtIoYpIBjMjSUC5AdpP/uHMDxVha
         AC6g==
X-Gm-Message-State: AOAM530XZXp2TXYZIU9xNBDQ7lzYm7rkX70gC3mhgqCYMUHJy9Njciug
        Es1yhEtU2xGPayD9FswIqX6fTZ+4j3VC7g==
X-Google-Smtp-Source: ABdhPJzc/pVgX5tEDAUlJHv0ISXhCU6NCh9xxRXEFp2NAAct/1FKMDqN45tSs9XzIa4idvcgitgzMg==
X-Received: by 2002:a37:8a43:: with SMTP id m64mr3389111qkd.37.1592484313430;
        Thu, 18 Jun 2020 05:45:13 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x54sm3284542qta.42.2020.06.18.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:45:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jltum-00A2SN-49; Thu, 18 Jun 2020 09:45:08 -0300
Date:   Thu, 18 Jun 2020 09:45:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH rdma-rc] RDMA/core: Annotate CMA unlock helper routine
Message-ID: <20200618124508.GA2392687@ziepe.ca>
References: <20200611130045.1994026-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611130045.1994026-1-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 11, 2020 at 04:00:45PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Fix the following sparse error by adding annotation
> to cm_queue_work_unlock() that it releases cm_id_priv->lock lock.
> 
>  drivers/infiniband/core/cm.c:936:24: warning: context imbalance in
>  'cm_queue_work_unlock' - unexpected unlock
> 
> Fixes: e83f195aa45c ("RDMA/cm: Pull duplicated code into cm_queue_work_unlock()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc

Thanks,
Jason
