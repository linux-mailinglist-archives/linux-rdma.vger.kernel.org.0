Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739CE3BD6D6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbhGFMrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbhGFMrE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 08:47:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEDC09CE75
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 05:23:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d2so2218756wrn.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNyqHLQRNkYk8ghNPCyy058MytEY7ye/Hosx5rgh6L0=;
        b=I861MRXnVEJLWhlPliO+jitKdknn/PB69GvRAM/Y4b8ranu/45I6eMeXTNi9dKuJ0j
         WYk89i6CPtBnGLN6nluhfnivHJjMYYzeqUVC8YHPJKGLDAkmLUXMmITr5S5TPlVgR6z+
         pWlut4ORszisRKb8vPQRzvBskW4VntzJL5DP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uNyqHLQRNkYk8ghNPCyy058MytEY7ye/Hosx5rgh6L0=;
        b=E7APhn+CEVDCP4P/dwVnSUJcrQIBvpT7ukD+hwxm3zRQtG6hY6e6xgZDUfyw+Hg/0Q
         a5TkU9btVCfpw7Kr5371AH1BKHjHo8VK/Qp5Z5CsvyiN9U+6U+uQ/VZoJqQG7V4oy2yK
         Zn8wHOXs9UGpH3c+nppKKtiv5+odRci8+1qi9rLUrbn1QSeW8/NocPR+uAVV+h2RxyEs
         cdDIKvM9Nv3ZZEtkaZRSw2UpjKa8IJf01IoafX1HP+CgP0VCXqmCbik1/mDl9QTtRsTb
         LXcDKIv12Vp+y886FD81k7tTI3Vx+jz7gEV2z4/OUgx1tvf+3u+tYB08fNxVAiRsVchf
         W+zg==
X-Gm-Message-State: AOAM532dvk/LyRA/uDRuCf8mV4dFit27ksVYuhs4m1Oc0oF1magi8x7l
        41vpKFTGE7bs7I2OKhAPvrPi9g==
X-Google-Smtp-Source: ABdhPJxolizhwmybAQ3VsffOuvUoyS5FTxRrVw3O2VuBLsJFS1lJdSAYSr7mbyMR8j36zn3HCunCMA==
X-Received: by 2002:adf:a41e:: with SMTP id d30mr3249053wra.10.1625574225475;
        Tue, 06 Jul 2021 05:23:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 31sm18348673wrs.79.2021.07.06.05.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 05:23:44 -0700 (PDT)
Date:   Tue, 6 Jul 2021 14:23:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [Linaro-mm-sig] [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YORLTmyoXDtoM9Ta@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <YOQXBWpo3whVjOyh@phenom.ffwll.local>
 <20210706122110.GA18273@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706122110.GA18273@lst.de>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 02:21:10PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 06, 2021 at 10:40:37AM +0200, Daniel Vetter wrote:
> > > Greg, I hope this will be good enough for you to merge this code.
> > 
> > So we're officially going to use dri-devel for technical details review
> > and then Greg for merging so we don't have to deal with other merge
> > criteria dri-devel folks have?
> > 
> > I don't expect anything less by now, but it does make the original claim
> > that drivers/misc will not step all over accelerators folks a complete
> > farce under the totally-not-a-gpu banner.
> > 
> > This essentially means that for any other accelerator stack that doesn't
> > fit the dri-devel merge criteria, even if it's acting like a gpu and uses
> > other gpu driver stuff, you can just send it to Greg and it's good to go.
> > 
> > There's quite a lot of these floating around actually (and many do have
> > semi-open runtimes, like habanalabs have now too, just not open enough to
> > be actually useful). It's going to be absolutely lovely having to explain
> > to these companies in background chats why habanalabs gets away with their
> > stack and they don't.
> 
> FYI, I fully agree with Daniel here.  Habanlabs needs to open up their
> runtime if they want to push any additional feature in the kernel.
> The current situation is not sustainable.

Before anyone replies: The runtime is open, the compiler is still closed.
This has become the new default for accel driver submissions, I think
mostly because all the interesting bits for non-3d accelerators are in the
accel ISA, and no longer in the runtime. So vendors are fairly happy to
throw in the runtime as a freebie.

It's still incomplete, and it's still useless if you want to actually hack
on the driver stack.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
