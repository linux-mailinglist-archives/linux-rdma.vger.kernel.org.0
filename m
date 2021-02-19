Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F8731FA29
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 14:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBSN6M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 08:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhBSN6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Feb 2021 08:58:11 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF77C061756
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 05:57:31 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z128so1005660qkc.12
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 05:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZGXzlzpCJbMb7BHqnaO6E2Y/ihZ3q+kNV050gx3kYHU=;
        b=oG95Mm1kx+GcDnS213z450xDAiIXZx+SMjwmx34jKrpE6tey2PlYuOg3MZJJoN740M
         4b7NQWJvjQZpOzdSkyZ2DlqnflE37P3rFGrUlr8UZLTE7SSSojFuIszV8IeZgVB/wn5h
         C59E/1bJXa3annEG8kyRmg3YVuXNFT9xsugZjFWyMYMOmNnAGeSS/M6iFcvlKY3acUDl
         mcPAvOoDb2ISraZtRZIk78GOuxyY+JD9yKbB1y9zGux90S4uzFAyaQGDVFuyMUniWnRI
         sHJ9segDkJG29AzQwjxi5TuyqEpAQOpa4asasjtXN0GmF5gM8WCdyZz50VSwyfAat0UC
         kYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGXzlzpCJbMb7BHqnaO6E2Y/ihZ3q+kNV050gx3kYHU=;
        b=iClJMtzlWIsR/pYkhTK5unSVyEJlSF3x61Ip8+6Mup2+0ZDJoC8axUNdbYMYYXQzUe
         pLpy0miLc3EOFA3lDGMxUYbzRIe5uzMM+1X7rkXRGFDRufWIHVFujssu5JhxZxcu6qKF
         60/FaLRANdfNNMgcYdHY19Yk88Lw6oiqTwqIYGhVj/Wj9sQtBTrEd/uFUgFdpZEmxMN9
         OVjyh9zBTzFLqcMWgWcKHsXLKnsb/YHb3hHI6f8lYBjSBS59JXDXbZHkeG1S0ZHnMKzC
         iatz1VQPYXjUOOhiGlhJMvIvSsxqzR3cxTb2kgZs4rVIZxEWW2EYKCIu8+TTv6+paUzz
         dxgA==
X-Gm-Message-State: AOAM530emkYLXYQLAjJCmQ1sj93S4DK6EAd0G1X2in3aR8P4tXoMewMt
        z/80zrLDMzaM9XUJ1R6KZ+i71g==
X-Google-Smtp-Source: ABdhPJwEqOtGqg7x8TmAqoPvxvmRmgAhsTekX/EC9/qp9RA5BXFAWzowhhzPmAjmlamYDtzw39d0lg==
X-Received: by 2002:ae9:f502:: with SMTP id o2mr9174014qkg.422.1613743050653;
        Fri, 19 Feb 2021 05:57:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id k187sm6311813qkc.74.2021.02.19.05.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 05:57:29 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lD6Hg-00CPjh-VR; Fri, 19 Feb 2021 09:57:28 -0400
Date:   Fri, 19 Feb 2021 09:57:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: Re: directing soft iWARP traffic through a secure tunnel
Message-ID: <20210219135728.GD2643399@ziepe.ca>
References: <20210216180946.GV4718@ziepe.ca>
 <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFA2194C43.CE483827-ON0025867E.004018CA-0025867E.004470FA@notes.na.collabserv.com>
 <OF3B04E71D.E72E1A4D-ON00258681.004164EA-00258681.00480051@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3B04E71D.E72E1A4D-ON00258681.004164EA-00258681.00480051@notes.na.collabserv.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 19, 2021 at 01:06:26PM +0000, Bernard Metzler wrote:

> Actually, all this GID and GUID and friends for iWARP
> CM looks more like squeezing things into InfiniBand terms,
> where we could just rely on plain ARP and IP 
> (ARP resolve interface, see if there is an RDMA device
> bound to, done)... or do I miss something?

I don't know how iWarp cM works very well, it would not be surprising
if the gid table code has gained general rocee behaviors that are not
applicable to iwarp modes.

With Steve gone I don't think there is really anyone left that even
really knows how the iWarp stuff works??

Jason
