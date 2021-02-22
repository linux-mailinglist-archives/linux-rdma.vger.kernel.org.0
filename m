Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B64321D62
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBVQtT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 11:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBVQtQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 11:49:16 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F334FC06174A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 08:48:35 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a2so4133975qtw.12
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q+mTrq1FCm72aS73t2sdgEW0wRg3cpUyRs6KvYINKIk=;
        b=b2JA8LweUMvXaEpIDY/7TExlbGmdyzhfW1IpfJORsKvS7slxkMolm0g6KRAZj4Cfd0
         38f0gj7yLmaSO2OLXL9khtoLY+e5CJngVroT+J0iOI2oKmtOtTyy9RD4smRHlCHFq3UZ
         YdZ+EhlnaUzF+kPHG16HwF0++Q0QH3R8FjlAMndOmcONnVVMdILdVOvb7rzceGI/rxA4
         fcDOjxxQI67tJMFdUT5ValRN82CdAa1Szn+5mvWL1lxweljw0X91FfDE4uhv/viFMcL0
         f4IQeEGda0GWVUDugBsbilU6UPCO6rx8tfppu69qlanu9sA0uMhF3UuNXEL/fkHaN5Qc
         fhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+mTrq1FCm72aS73t2sdgEW0wRg3cpUyRs6KvYINKIk=;
        b=eDbY/lrvrVTCR16zCTTu2yQIo0TlZS9x0DWXKy+tKqPEzVoQBv2Dy7Tm9lZsAFIoW+
         CRj389iSXaN6OtP6/Fg3i/Yp4D0X3qiZ0xM2nvfrepdNhXc+StFcy7TxPkuZ6gEdj11f
         GpAgZHDVqo0gicbc0sFQBKLKF33U747jk378GaOm3JtGDVmV9arr/Ut6cjqo6Ly5gFJC
         enwFA88mYQzq/PLv4KIo1fBuNSBMC5GOICMRvWflOizRNu+LktV5bMQXZ71SVuifoMaT
         g7nFQacGGtRLTtTajjnoYlVwXI04aj3OrJ9dP/XJcXwnG+wM+zXagWMRv9+aoYje0K4S
         oXYQ==
X-Gm-Message-State: AOAM533hZN1sWZQmCQotxg3ktBtzYbSYnFfvh6jD+iF6JDIEn0CtWt7P
        3knPsuBfB535ah3FapHDQybCYg==
X-Google-Smtp-Source: ABdhPJyQ/sflzonzw4oVX7/5kwotkwpb4JDTR/ykrj6redal1FML16b8uQV2zByESAu1JiEsnO35eA==
X-Received: by 2002:ac8:4b56:: with SMTP id e22mr15959033qts.311.1614012515304;
        Mon, 22 Feb 2021 08:48:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 15sm11072578qty.65.2021.02.22.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:48:34 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEENu-00ERzG-4Z; Mon, 22 Feb 2021 12:48:34 -0400
Date:   Mon, 22 Feb 2021 12:48:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Praveen Kannoju <praveen.kannoju@oracle.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>
Subject: Re: [PATCH RFC] IB/mlx5: Reduce max order of memory allocated for
 xlt update
Message-ID: <20210222164834.GL2643399@ziepe.ca>
References: <praveen.kannoju@oracle.com>
 <1613138176-22082-1-git-send-email-praveen.kannoju@oracle.com>
 <CY4PR10MB1448EDE77B7FB66DF79ACAD38C819@CY4PR10MB1448.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR10MB1448EDE77B7FB66DF79ACAD38C819@CY4PR10MB1448.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 04:26:23PM +0000, Praveen Kannoju wrote:
> Ping!

Your original message didn't make it to the mailing list or
patchworks, you will need to fix your mailing environment and resend
it.

> -	/*
> -	 * If the system already has a suitable high order page then just use
> -	 * that, but don't try hard to create one. This max is about 1M, so a
> -	 * free x86 huge page will satisfy it.
> -	 */
>  	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
> -		     MLX5_MAX_UMR_CHUNK);
> +		     MLX5_SPARE_UMR_CHUNK);
>  	*nents = size / ent_size;
>  	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
>  				       get_order(size));

IIRC, there is some GFP flag here that fails fast if the order is not
available, why not just use that?

Jason
