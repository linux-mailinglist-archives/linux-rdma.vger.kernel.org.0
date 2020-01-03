Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D63FE12FD3D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgACTsJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:48:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36940 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgACTsJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:48:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so34683661qky.4
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jKVtjHKUqOXNOUp35/jVYCzkPXvo9yPLOLSemwLqvOU=;
        b=UGJmvPM4N8rxbJ1LlDhVjq3n2XsGxBZp7NUKBKLdWyvQuE691FfJ+S/Bw8jy9KFSi/
         amI1Mw8AwtZ0lFH2U+2tC3qkreBLqrV+tixq1TVDN414XIhNAXCu8mGpAygKd5VOOruR
         78zEgXcutt4srxU9VmhHW499G8/I8uJjhCC1QbGwwBaYkiyw3TulAU2nBG5KD2Z6d0rL
         qLarM6Cwt1jt4VRCUpaUML9YRDl2XUh4pjRexIjIwI2M3PPa3nDuRWDGV9SqUlLn4XC2
         zL9xvvG5PL+2NTkw3tLqi23U1epkVLeFr/QrP/6sffXa4zU0cckpaQmZm2JgjzvttP7d
         5RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jKVtjHKUqOXNOUp35/jVYCzkPXvo9yPLOLSemwLqvOU=;
        b=K50byoSqlkZh/qAhK0Qq8j7gcWj5eAl7ztXHj+kutrcpdPiMTEN/o/j9q1W5VlZJ6c
         3DJ9UHdA8NCQZ2srfuTz3j2ajPvBcG5F5GNJQS0YTsg9mKZqgrJiJfpuWE0cNYeoHEGa
         zHecFZ8E2N5lDO/aeyI3Zbdo7lERbJv0+rIwia0J4noZ2IRGZcKkjgpp1DwfiuUipXhp
         pmrlnGj1qOd6x40evokIOMph+N5APbWe/y3o9VJq30uc/GIBdSd9Y0IKK/8Nhq4cCg9e
         ARy6OV8+UOTtMkAhJVaiVxKmPBDhaNuYZddVvmZLsGZjgdYcDfUseyu/oaO1Rpl3ylfz
         /9Tg==
X-Gm-Message-State: APjAAAVYs8SkSZXIfyMq8a5I5cr01nAAnINjD09h7DxUIuo6bA+xJE92
        zDxSL2ZgsSrImqyTSXsAMLn7tg==
X-Google-Smtp-Source: APXvYqwfX553QYHm55Rvg3gDZiy9/4QomcGzIorg2dO2VM5fgRK26R4I558BXOepQqQGK3psrzu/RA==
X-Received: by 2002:a37:a1c1:: with SMTP id k184mr72958574qke.66.1578080888679;
        Fri, 03 Jan 2020 11:48:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r205sm16892432qke.34.2020.01.03.11.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:48:08 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inSvX-0004wz-Te; Fri, 03 Jan 2020 15:48:07 -0400
Date:   Fri, 3 Jan 2020 15:48:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next v3] IB/hfi1: List all receive contexts from
 debugfs
Message-ID: <20200103194807.GA18963@ziepe.ca>
References: <20191126141220.58836.41480.stgit@awfm-01.aw.intel.com>
 <20191205134938.48219.50954.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205134938.48219.50954.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 05, 2019 at 08:49:38AM -0500, Dennis Dalessandro wrote:
> From: Michael J. Ruhl <michael.j.ruhl@intel.com>
> 
> The current debugfs output for receive contexts (rcds), stops after
> the kernel receive contexts have been displayed.  This is not enough
> information.
> 
> Display all of the receive contexts.
> 
> Augment the output with some more context information.
> 
> Limit the ring buffer header output to 5 entries to avoid
> overextending the sequential file output.
> 
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

This patch does not apply, please resend it.

Jason
