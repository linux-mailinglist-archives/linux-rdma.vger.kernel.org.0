Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809C71FF22D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgFRMp2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbgFRMp0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 08:45:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C8C0613ED
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:45:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so5315430qkn.8
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2020 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LyhtUXnS6mJ/BWitQdlXCfK/SHxOvdmee5AjGwVX+60=;
        b=QOQCNoykQbJg26yg+OrW8wdAHoME9+y7Kf8QfwwVrb9MFkHKffudy/6Ni3KLCEWc7g
         GHQTnpN8J1Z3ch4VEOf8PP7peeNMpmRei0FAAIH1rm7MpiLOP/gbA+h9jbmK1mO7/H4D
         9GpxScuTUGp9/njrXbeXTMAGMWozXO4dAfUOTh+ch09cQoq4LfbTCHPOsTZzrnYGn2MR
         +v4uMt/6nSGTpUdRUIv2YztTkxv0dYVsu0GrqC6OAHXrfDb7FappnDKbPKJ/+3YoBKd4
         YSNWd963n+kPpnrOTz15+P46sAfj5cpJf/oA2FAWWFHPGqyOcfEj2LOSER4QGoP6ive/
         gfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LyhtUXnS6mJ/BWitQdlXCfK/SHxOvdmee5AjGwVX+60=;
        b=hrXhh2n0GsYXFT1vG7A9KwRIXKa7WlICEownsUkN+YS31437Vq00WrFTAKr5onXVOa
         3WO0dyI48b8T9UCamREuTo9OfuDBeRU+YKF/3FmPdTMM7VLC7U/7VF779BD7l/OwRdxW
         LyatbidTEmP8vgX6/Kwxk/kg+z/25gOjOc/4YQzRRQLJm+Q+MBTBk7bKZOJh0lJGBwZs
         AJqKRWOoQLiJNgPjSbF+o2zsHYZ2WVB8qkSrgVnXGkMiakjrHzgpOfGT8Fsrgn4uipSw
         FO4mlcbuoWBciYdFLo6No0gM9U4+umWkvT597udZHv+ywYWEtNsk1hG2ylxkBEYqZ4aB
         pGBA==
X-Gm-Message-State: AOAM532dJ681DWbu5VtJQ7zyaTe1b029cbh0uZzmglvf/zdrfsia76Yp
        ENCHu+1XeJ7xsk3f561RhWFUXg==
X-Google-Smtp-Source: ABdhPJwjyb0VZyQanpzJoNo9ywQsJiOaSZ13I/hBiKWMy+ZzCkZFhywzJeX2GeleTnXxoqAZNtcPPQ==
X-Received: by 2002:a37:bb43:: with SMTP id l64mr3454332qkf.271.1592484325487;
        Thu, 18 Jun 2020 05:45:25 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 70sm2947841qkk.10.2020.06.18.05.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:45:24 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jltv2-00A2Sj-0s; Thu, 18 Jun 2020 09:45:24 -0300
Date:   Thu, 18 Jun 2020 09:45:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rvt: Fix potential memory leak caused by
 rvt_alloc_rq
Message-ID: <20200618124524.GB2392687@ziepe.ca>
References: <20200614041148.131983-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614041148.131983-1-pakki001@umn.edu>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 13, 2020 at 11:11:48PM -0500, Aditya Pakki wrote:
> In case of failure of alloc_ud_wq_attr(), the memory allocated by
> rvt_alloc_rq() is not freed. Fix it by calling rvt_free_rq() using
> the existing clean-up code.
> 
> Fixes: d310c4bf8aea ("IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD QPs")
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
> v1: Fix incorrect order of  rvt_free_rq and free_ud_wq_attr.
> Suggested by Dennis Dalessandro.
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
