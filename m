Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB00015CC8D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 21:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBMUrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 15:47:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44355 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBMUrX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 15:47:23 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so7047627qkb.11
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 12:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDYRmF/n9AXJXMLD2CkKOMsOghmFx63Kdj84NY/mVDI=;
        b=l1YDsyu5l964rtVbyqrqYslXU7j7KmbqAw4DP7oic+tsZLnJHKiOLIqXVcrbSu2C65
         u/rKpby68Xz/QKX2LopEcGU/8AEQj9rnMStbOuPSq8p4FTok+mUdLjqneFhgPWVD7+IX
         +yQfrVcfCamw0YvBAITjF/x04elz5vmf618S2A0lkxL3dSRGCyxD7F5ef2EF/KmsKFH7
         /SyhFHSaGx/GEWf5QyPJMhvh4r/eFHZliGs8TK+KVmhBc7Mi6lADtGrwYSzDzT9Vae8c
         BlhmP1Cf8hFxL++Tpu+4uopoccL9iD6yM+K1EPrKLjDIUfI4rMmiwdFOEYKzRB4cri2D
         +/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDYRmF/n9AXJXMLD2CkKOMsOghmFx63Kdj84NY/mVDI=;
        b=uZq8LSZNLu801TpUPZ1FlNdqTfUnefwsDz44IraF5SIkvR6kZeaIGU7+Cw9yB0JUcg
         Qjl7JdXQf19gT/Xa+3UVBT+5Ch+Q14SnHQgtzx32KyX4ONIKiK4oKh5ykYbEMYDWpxR6
         /KqPQMvQDv3GMMlupQWOoN/Kq0x1tBTeGXSEe/6mD5AyqNKUlWftgPW47g2PrVtvVs0/
         xdCTVtw/zVfXVHdPh0gHKFPZ03QdOSF7hH+hHsCIyIb1PbflB+AVQz+i+LXofhGoW2KO
         Td24986G7cXMRL2YzPkREfzwy+dElUvwi8CSj0+bhHGxc4B8j9ntweclnsYzaP/qUZ6o
         BoAQ==
X-Gm-Message-State: APjAAAUEtrKSrkL3Jx171hFqv/2yNOwH/s/mdRMgZtsswDOdb4yHCuay
        mG0qfWav3of+mGjPrIHuvJBFpFGcTyhUBg==
X-Google-Smtp-Source: APXvYqwjGsUiaToGa9NjA1Owqvdp4RX/V1eRTtRNGVGrKVGvDW0GGy1GiKANZBCDHSw81r9c5De6Xw==
X-Received: by 2002:a37:4808:: with SMTP id v8mr15854832qka.263.1581626841962;
        Thu, 13 Feb 2020 12:47:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x41sm2188045qtj.52.2020.02.13.12.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 12:47:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2LOK-0001N2-3R; Thu, 13 Feb 2020 16:47:20 -0400
Date:   Thu, 13 Feb 2020 16:47:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yixian Liu <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v8 for-next 0/2] Add the workqueue framework for flush
 cqe handler
Message-ID: <20200213204720.GA5241@ziepe.ca>
References: <1580983005-13899-1-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580983005-13899-1-git-send-email-liuyixian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 05:56:43PM +0800, Yixian Liu wrote:
> Earlier Background:
> HiP08 RoCE hardware lacks ability(a known hardware problem) to flush
> outstanding WQEs if QP state gets into errored mode for some reason.
> To overcome this hardware problem and as a workaround, when QP is
> detected to be in errored state during various legs like post send,
> post receive etc [1], flush needs to be performed from the driver.
> 
> These data-path legs might get called concurrently from various context,
> like thread and interrupt as well (like NVMe driver). Hence, these need
> to be protected with spin-locks for the concurrency. This code exists
> within the driver.
> 
> Problem:
> Earlier The patch[1] sent to solve the hardware limitation explained
> in the background section had a bug in the software flushing leg. It
> acquired mutex while modifying QP state to errored state and while
> conveying it to the hardware using the mailbox. This caused leg to
> sleep while holding spin-lock and caused crash.
> 
> Suggested Solution:
> In this patch, we have proposed to defer the flushing of the QP in
> Errored state using the workqueue.
> 
> We do understand that this might have an impact on the recovery times
> as scheduling of the workqueue handler depends upon the occupancy of
> the system. Therefore to roughly mitigate this affect we have tried
> to use Concurrency Managed workqueue to give worker thread (and
> hence handler) a chance to run over more than one core.
> 
> 
> [1] https://patchwork.kernel.org/patch/10534271/
> 
> 
> This patch-set consists of:
> [Patch 001] Introduce workqueue based WQE Flush Handler
> [Patch 002] Call WQE flush handler in post {send|receive|poll}

Applied to for-next

Thanks,
Jason
