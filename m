Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84A2A37B3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 01:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgKCA0Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 19:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCA0Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 19:26:16 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93899C0617A6
        for <linux-rdma@vger.kernel.org>; Mon,  2 Nov 2020 16:26:16 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 140so13293880qko.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Nov 2020 16:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qS6zHeQGlWxDiHiDZf1nubFxdr+rlccS3vN//YlgNI8=;
        b=R41a3AcIEvc7VKS00mQd0nav6QXfz0AmeGihhD9/Tbv4FYE9AmkEGxdzNhYGPSqBIW
         vGKUve83AS5PlLdCPXy94UfwsQS9aaA8O1CFKWqLt0ERLQi0DHbF9G8AS9DW0gIHssQq
         KvYn9tHRLrT6GB74DtAu8ly7oCezJa3ys7bPh/DlTqzyMT+iHFJz9J4eKMWigbamPBQs
         u1A/+tWv71HTu7I9raV8aJr8hNoPJ65bubzZo+H8/SX9nS2yrkv6i91QQgwHBS1r8drf
         eZJ6ZIxKuzjaTJpwwMDU9JvP3tebuLMDIwmikRvPXx0AahAgesMKn8QBuWEjTJx8Xr2s
         hdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qS6zHeQGlWxDiHiDZf1nubFxdr+rlccS3vN//YlgNI8=;
        b=GbI/bsewtt3ep1fxfdExKs1cxHppBKPI89pchpl1rPncRU7fdFbt4IccIJteFLSLc2
         5FdDyjYEFC/rG95FE45OXPxMLX4zW5BbMQuXGp2DVVslZo7/7gfc/cimWOHqRljIwQ80
         cVCyBlkdQ6Ev9ReDSnQpOIoQxKADJv32569iloEbAcs7FaHwbtTuj3dR7xSsyKzUo0Ds
         srOfrm0X/V1OcebCoKSBRToRm9pAz5oYDZIl0ChixC5uJOpLDQ04RxcqWtwJ0pL2I4gB
         H5r2RVS+s21f3JCCRAHNnerSelF4wiy6/kUBSPyp32Co1N3WWbDQ7cFM1dOnU+vrUygR
         xruQ==
X-Gm-Message-State: AOAM531IBIOzsASQ+WUOxBFavi5HUmBSVl8k12lom6oA6siGjBcXlTsT
        EO0ddF8q50S78T3y0gk4ofFpsg==
X-Google-Smtp-Source: ABdhPJxam1aspblBBAnL/kJ5US+sj0FSoE308FW6s499etpu1hKqFNWYrDEcIQQCzenm+2z95Oi9Wg==
X-Received: by 2002:a37:a596:: with SMTP id o144mr11639960qke.202.1604363175784;
        Mon, 02 Nov 2020 16:26:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t184sm9295446qka.19.2020.11.02.16.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 16:26:15 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZk9O-00Filj-ER; Mon, 02 Nov 2020 20:26:14 -0400
Date:   Mon, 2 Nov 2020 20:26:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Oops problem with rxe from 5.10-rc kernel
Message-ID: <20201103002614.GJ36674@ziepe.ca>
References: <CAN-5tyHaVyoLMOc0Qtte=Gz+UUE+HX1b3E1d9xh-RD3Uve22JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHaVyoLMOc0Qtte=Gz+UUE+HX1b3E1d9xh-RD3Uve22JA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 06:00:02PM -0500, Olga Kornievskaia wrote:
> Hi folks,
> 
> Is this a known problem? I'm unable to do simple rping over Soft RoCE
> starting from 5.10-rc1 kernel (5.9 works).This is an oops from running
> the following. I'm also unable to do NFS-over-RDMA.

Yes, it should be fixed in rc3

Jason
