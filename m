Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C534D22D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhC2OLn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhC2OL1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Mar 2021 10:11:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92532C061756
        for <linux-rdma@vger.kernel.org>; Mon, 29 Mar 2021 07:11:25 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i19so9351767qtv.7
        for <linux-rdma@vger.kernel.org>; Mon, 29 Mar 2021 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D/g0i/KxrwbZdl4L/0DB09LBezPWxbs3gzFF9HJEfdY=;
        b=bVToIoLydDzEAxrKiYSEPnysn9o4+peWZrOhGJWe9qGGKZPl4MsNlvjjM5BHTu7rL1
         Vue22UNKI3WMId8yCVGoqxIjuV1AGSsqwCcu34s4dwW/4maaOAce2W6v5+ARhyEJXXrw
         X2q3ahQvwXY31j1rE1TMt2/r2Djzv2Jk/wL3pM2ouZ7oQaHC3ouAqtql+vAXilQR0iU4
         WvnHUCpjnUQcPN37CL4XjEF01xAarVEHN5xQympO5t5PN3CEEsAq0DrkOT8GCgyvAOYQ
         Cs8AXaIv6KdpPJ+UKkYDxdGcdKeYQ2/LHmg9g1H8Sdj7iE5tW+IqtbqyI0GLU7ldGEp6
         FKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/g0i/KxrwbZdl4L/0DB09LBezPWxbs3gzFF9HJEfdY=;
        b=ClIXQgnMiG07+Gx0Otvyntcjzbp15mUqmd7b+WtkavGCnkFoWSEzbjS8CG1bcKgw6U
         8wQ+cNbgWEI/sOnAyn9pXYYSPFHZ44eb2JghH5juk+rIIFTTevy6p9RifPVviKJUMijF
         6Rqnk6Yi/Q5xe19m+F0r/5Veh6cH5LUVSLary9PtoH6iH8h+BxWC2mGRNYnZzv9XTkcz
         KdLqctnV3ZTfzyEQ8Ftp1oaTKEfGVQ3AMvbiticgQ7KJSfGYu4irw7+6Y3ynmBEwaBkP
         SlScz1WLY0mXUMpIOSXFdg57gCBiIqEoE72xJ1aVBRw2F+SDFsvDJY9Z3sumj97s7gBb
         a2nw==
X-Gm-Message-State: AOAM532rJpusYtrlBbi2gmLdgOBryhxJhbF4dZ8vC2ZVqulsD+BlWj5W
        djfOAv6UAtw+aI9EGgGrqO6uugQqke0TqjGj
X-Google-Smtp-Source: ABdhPJz2LMye7cCv71y+RQrguks6sMUnd5xDE+dWD9aAfFiapjPWuv9Ng/ZL+KaLuSbSqCBPfd0HVA==
X-Received: by 2002:a05:622a:1701:: with SMTP id h1mr21677340qtk.171.1617027084829;
        Mon, 29 Mar 2021 07:11:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id a14sm13562016qkc.47.2021.03.29.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:11:24 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lQsbz-0054dn-V1; Mon, 29 Mar 2021 11:11:23 -0300
Date:   Mon, 29 Mar 2021 11:11:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH for-rc 2/4] IB/hfi1: Call xa_destroy before unloading the
 module
Message-ID: <20210329141123.GQ2710221@ziepe.ca>
References: <1617025700-31865-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617025700-31865-3-git-send-email-dennis.dalessandro@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617025700-31865-3-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 29, 2021 at 09:48:18AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
> From: Kaike Wan <kaike.wan@intel.com>
> 
> Call xa_destroy for hfi1_dev_table before unloading the module to avoid
> a potential memory leak.

Do you hit the WARN_ON or not?

Is this all just mindless?

If the xarray is supposed to be empty because everything was erased
then you don't need it, the WARN_ON is correct. An empty xarray needs
no further destruction.

Jason
