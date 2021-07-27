Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90883D7C61
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhG0Rls (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 13:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhG0Rls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 13:41:48 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E0DC061757
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 10:41:47 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id d17so80991qvn.13
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jul 2021 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVfL2+nTW1C0tsoipqMM7VAFb3zCPwm1wbNu2Vlablk=;
        b=dma6sJfV4WM2523gxOpM5GA9Akne+zHWQ2Z4IrE32GEnga4NjpVBYcQwB/sSnMEOr9
         /dlRtBhGoBo1o7OqbdIVuKxQfNTZtlaFEemA+8QpxF/hlbd6ee/znyC20u38UyxyNRho
         TS7zec1RgWkEsAUaOIwbvkYv80dUcLqmjV2fR/snU6Bw2wfdqxa1j74HY21fTnoTIZFv
         ULz5J414zsEky4vJ6eAxQ5UY+GS3wcmp4AcMilD45Eyy8csszMnDTEX/viEKT9VxSXh5
         qUQ6nKQq5o3x7JzVQeZJL0MRGTE3lLdxVjpbZaTrPzHQmNN0jfquveHZQJae2Hb6pe8p
         yKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVfL2+nTW1C0tsoipqMM7VAFb3zCPwm1wbNu2Vlablk=;
        b=pATDuk3pGRSRi+dXsJC75G1nifSNzoPWVvPb5Pi7bOTEMuejlUTOFv1uWcaqM0tfug
         mNQLr3RLmgB/0gg0lBz5dFMJkm5VEhAKfKjJ8LacjPbR/SFTE0zaBHI8FA/axosbXY/d
         oxf/WxGtnEpM3dCSYgN2zUKrWMRZdTb+rpVm2fvxbqtI3ylxnF9lNhw035Qw1YXRX1MQ
         ECuEdSbYPiEv7EkESJO7jpqjYtvD5N1JNVSaj8PavaV3v7LFUF9DzHe9Kt6x2vfrACVF
         6KlD5ekn+UyX8xNWXj8BeCGPPJlDq7AswtAj5a3NEcb+lA3CcWLBZFUJ2fnKejE6nFr0
         KSRg==
X-Gm-Message-State: AOAM532Nyj+mUTXtNYiUcFxAWXOBpF7gbZj2lumZI/iMo4r7h/cH0lri
        2e1W6WxRzR+nuF5ueKOleBEoEg==
X-Google-Smtp-Source: ABdhPJz408VwloHkdlxrtZ/tRhPS0lJZTfp3AqgVoMKNTYzqGV4w78vI8mBtUdFz13ywyhSGIsMBJg==
X-Received: by 2002:a0c:8304:: with SMTP id j4mr21190229qva.31.1627407706333;
        Tue, 27 Jul 2021 10:41:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a5sm2010582qkf.88.2021.07.27.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:41:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m8R5M-00967Y-46; Tue, 27 Jul 2021 14:41:44 -0300
Date:   Tue, 27 Jul 2021 14:41:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Message-ID: <20210727174144.GE543798@ziepe.ca>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 09:15:45AM -0700, Shoaib Rao wrote:
> Hi Jason et al,
> 
> Can I please get an up or down comment on my patch?

Bob and Zhu should check it

Jason
