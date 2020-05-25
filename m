Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754561E147C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbgEYSth (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389242AbgEYStg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 14:49:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B473CC061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:49:36 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f83so18185811qke.13
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OdO93pTLkJzKjQzm9J9pXLAa42tSCsdjT1iF2xS3zDM=;
        b=Iq9iEYNf0A7XQQSXQaTFVcs2OCTjRXvKVCN4cjzKaR1GJMXsKYAC7pbqNEqjxR0SG9
         qe6Y6LH772CLqk27T/1XIAdforvqNVnFMoArHcOEqEn3grom66mEbzE6OBYfHePn8axH
         FNH1N+GebnMXCJcXN89a18V9KGEVUfAYWfI8evzc9uK1NduPC4cYIZudYnfM416QQGhx
         hDZ9lp6qKbU6NLC45o5m7+OYKCFgOH2FH4KBjo5UbQFmRJG5wdqYc8gKq7Xv+9EuAuGs
         zAL0In/dqOL0Y4/f/Pzm7Ra6Y6OvNPVlFPZCwARODCa8TrZZECNeUsOoQe7dlCc3Tiqp
         ua1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OdO93pTLkJzKjQzm9J9pXLAa42tSCsdjT1iF2xS3zDM=;
        b=KyEDwpKHwBVZmpUa4Jpo2yt34KWIa+rKY9/0MOoympuJnPjwKqbeS0vfaTIrltP/N/
         jNFYf1To9arouWJ/DHHF2FmwxbpYWSMF4rKvS2bKkxosJs7PcSbP0MnN78YVzJagXo5R
         NHhprNBqEURmEJlSUuorkGPvtNqCt6/n5G+gBH39s8+9LZWHukJWnZRWCoRJXTp8rMaI
         hkTr3Mf0tbJCQlX+e5BAEJCFi2czSfWmGZgnFyoitpSiGz/WkCSAocoDuyc72dupcdf7
         4+9t6RQzwkOj449FlSL0S1K43In5+RPXHOD64918KfUkmyezMsHpyUCUqvHoKclU+LkL
         MAYg==
X-Gm-Message-State: AOAM532ytHD34jG2SbgMtgTfIjoWx7/gj17PLgBE61vAC0DO+X88VWV4
        INr0soPb4IlssgC265UdzYOaqSHkJDk=
X-Google-Smtp-Source: ABdhPJy1WyVOD8bMHlO8dvnZQTLU2BiYs1bD8vVIIre/dvq8XdESOV1EiaZurr0gLITBz0i2XcZrew==
X-Received: by 2002:a05:620a:15a3:: with SMTP id f3mr5671803qkk.188.1590432575853;
        Mon, 25 May 2020 11:49:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p25sm6809711qtj.18.2020.05.25.11.49.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 11:49:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdIAI-00049S-UT; Mon, 25 May 2020 15:49:34 -0300
Date:   Mon, 25 May 2020 15:49:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/ipoib: Remove can_sleep parameter from
 iboib_mcast_alloc
Message-ID: <20200525184934.GA15935@ziepe.ca>
References: <20200525130305.171509-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525130305.171509-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 04:03:05PM +0300, Kamal Heib wrote:
> can_sleep is always 0 when iboib_mcast_alloc() is called, so remove it and
> use GFP_ATOMIC instead of GFP_KERNEL.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied to for-next 

Thanks,
Jason
