Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6B247011
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 20:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbgHQSAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388524AbgHQQKB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 12:10:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6D8C061342
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 09:10:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so15522230wrh.10
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KWgT+MkZBcT1UMKwsraLbtIa27PJ9W0Vx5f5FJefoXQ=;
        b=EMVxgntAVCRBuIkO1uTA47j/IaafY8IzQQoN+HSEiJR7hNW+4FPgNI+KGhHAVQGbn3
         iTo399mvZKxPx5RKA6ASxwkaFbYf77DwdFrwi9Aqq0JKYKBrji9BATTb5tAUynVFBQ7k
         V8NQ/+1wHv1lHq1zVAlng7YCky/lEP+vxvMZyVUtZScFSZmEkGEg+oiWmVZcum2qmKa+
         qesISlmi6NzsWXwjeW+a5rdz+5Yrzo6RbDEuFrkobdiINRkmc+ATGW1csYXbxwgOzZ1U
         cHJDqrmVSq+1G42VTZRHoCRmS22c04XG+mNgfkjppA+HWwKSe0S2WXcgYcF97QBzti/l
         qQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWgT+MkZBcT1UMKwsraLbtIa27PJ9W0Vx5f5FJefoXQ=;
        b=NLDRzGJw6m3dWPqkEMmuoh255M6KJVFk5s4LrXXJj3r7mK3kOJ+s9svBdv8rrcAUX9
         NIeYap1f0hwLzWNLSzkAJ8aS+sxJncsqBhK2axUM2sox+RtOerAltzj41J87RhjroD9p
         S076t7pfKd0P+opqrefG8u0UM+fm3s6ac2Vxjfc293qT0rK1LYmYhzRrX6qksXvD30L0
         B7o7W2di7phnY3hqFrAlk2iYf8St3Vm74MYGlep+s2uk0hh1vERg1fUlnmESKoUf6oMy
         8Bub/VuTSf91GEbRni0oO9VMtLthAL3q+w34QzW9MFgUtisCHPJtC8KYt8yvdmM6yQYc
         OkQA==
X-Gm-Message-State: AOAM532pNKO2y0lgeLeSB7M9Tl0lsWlb+6K82mtd1m86V/755gf/kSzY
        q5qZc2Xp6w2DSAMxWd0ZytNGW0c+N06ytQ==
X-Google-Smtp-Source: ABdhPJyy1+KdcX4VSXCJMIyyC50G4eN5wC9OX6EF2Ks3eu03dZlt0KpRbsMvWnTls1L1f05FjipkyA==
X-Received: by 2002:adf:f011:: with SMTP id j17mr7171121wro.335.1597680600015;
        Mon, 17 Aug 2020 09:10:00 -0700 (PDT)
Received: from gmail.com ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id z8sm28679076wmf.10.2020.08.17.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:09:59 -0700 (PDT)
Date:   Mon, 17 Aug 2020 19:09:56 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC] xprtrdma: Release in-flight MRs on disconnect
Message-ID: <20200817160956.GA3516778@gmail.com>
References: <159767751439.190071.13659900216337230912.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159767751439.190071.13659900216337230912.stgit@manet.1015granger.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 17, 2020 at 11:19:26AM -0400, Chuck Lever wrote:
> Dan Aloni reports that when a server disconnects abruptly, a few
> memory regions are left DMA mapped. Over time this leak could pin
> enough I/O resources to slow or even deadlock an NFS/RDMA client.
> 
> I found that if a transport disconnects before pending Send and
> FastReg WRs can be posted, the to-be-registered MRs are stranded on
> the req's rl_registered list and never released -- since they
> weren't posted, there's no Send completion to DMA unmap them.
> 
> Reported-by: Dan Aloni <dan@kernelim.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/verbs.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Hi Dan, does this help?

Yeah, works as expected with your fix.

Thanks!

-- 
Dan Aloni
