Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D313141ECA1
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353892AbhJAL4m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 07:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhJAL4m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 07:56:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC458C06177C
        for <linux-rdma@vger.kernel.org>; Fri,  1 Oct 2021 04:54:57 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 11so5355185qvd.11
        for <linux-rdma@vger.kernel.org>; Fri, 01 Oct 2021 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6UvpW+82IrGSitHRwXCZH+MRl/OSv3lX6yJ9tA1yy7w=;
        b=a9k47Py64Qak3aBuTk8Mm+eYG1dyEu3BHwI2WPHIjnU0SKCadkaulY1NhsPb1EojXz
         5TdKblB0SophsryTf6uzFXVnCqajNvKH8va6eyKu4ucv0aK7Sc3tvsrC7J+Mr072MuRX
         Y0lhnseyFteCnFo9EVaqNy0ORM9NZHVAPNcvdJmEeNxrU8Brr1YPsMfnj0rWAaIAARX4
         grs5Q4No0UwKKy9TWL+Tbh8kdxx+Ws2Cbqlg8QHSeMdQNJ7Fmue557EAYQFBC6ZcGVuz
         8H/DDGKOkbL6uz5bSWVCYCtffw3q0BJ0wi9RoUs7XfL0M3GFEvOC3nGr0GXnBP9r5xu8
         AACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UvpW+82IrGSitHRwXCZH+MRl/OSv3lX6yJ9tA1yy7w=;
        b=k0gILgOAcH1GHsOHpBpXgxTHv4Zv/n4SEXiVegxmVwDyXbqwwvmoeJoyZkEZKybm2S
         kLme9Gq4JBZ74Um/DEI3iAdqM5da1GYMl5/iFtMxiMPc15U40XX3AJsNR7UNbqY9R/Dd
         QcRvcD4F6BYEn+43FU7D5pxQ0Zi3bxTJ13fAyqTO7HGo52t+dLZBRiRj//aTfPXNPx0e
         oXCoVS9bkJ+3LVMkUuAFQmg1ecH3Kru2X+Xz7aYvEwblUxKwjw8hVZj2jBuMNk++Kw63
         IA3fHxG1dsW9AZHaPX6RmN9P9IlmUbdrjx4f3l+8fbyxu/TlPDASt/HqRXK0o5Zz57fA
         s9XQ==
X-Gm-Message-State: AOAM533P0QchpvcFJfdPPbvbi7YiT5SjUZeildUj5PIuLGI1GD727CUI
        IyaVThSARPoMMsYmCQ0KXIgCHg==
X-Google-Smtp-Source: ABdhPJz1p1SZg5yR5Lc7F32b07Y6RkML0uTUmJ5PQ9qO81yUQMwWGw5wmqJB/tjvZJjRAJ4rDhvj7A==
X-Received: by 2002:a05:6214:1342:: with SMTP id b2mr10107873qvw.16.1633089296997;
        Fri, 01 Oct 2021 04:54:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 19sm3070753qtt.20.2021.10.01.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:54:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWH7v-008Ov6-Mc; Fri, 01 Oct 2021 08:54:55 -0300
Date:   Fri, 1 Oct 2021 08:54:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling RO on a VF
Message-ID: <20211001115455.GJ3544071@ziepe.ca>
References: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 01, 2021 at 11:05:15AM +0000, Haakon Bugge wrote:
> Hey,
> 
> 
> Commit 1477d44ce47d ("RDMA/mlx5: Enable Relaxed Ordering by default
> for kernel ULPs") uses pcie_relaxed_ordering_enabled() to check if
> RO can be enabled. This function checks if the Enable Relaxed
> Ordering bit in the Device Control register is set. However, on a
> VF, this bit is RsvdP (Reserved for future RW
> implementations. Register bits are read-only and must return zero
> when read. Software must preserve the value read for writes to
> bits.).
> 
> Hence, AFAICT, RO will not be enabled when using a VF.
> 
> How can that be fixed?

When qemu takes a VF and turns it into a PF in a VM it must emulate
the RO bit and return one

Jason
