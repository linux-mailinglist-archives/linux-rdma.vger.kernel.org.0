Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8909102D57
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 21:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfKSUO5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 15:14:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44620 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSUO4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 15:14:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id o11so26094483qtr.11
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 12:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+s23VwVAqA5dvEtW7VP1t6H1t1yv7xGEEMgPH3O9Wxk=;
        b=ie3/bhjw3QC7qRtwXmzQ3ZjY/ndXWw75lAdlPDuZ/FZGq3nzrJl9dmYXlHPOU2kUNE
         8p5oFOPR6n6oTU4yCFZM7jkp9b1vrqQGiAEzXx2s7TepCVa7Rs/a2woNE7DGhxH1S9N0
         mPCJ82eia89b0azlAmwSNudwBV/dFfZiyC580VNHYA2MEHBr5ZJmsZYPjWqJ88ji5E9b
         yKNFIxbduE9A0N2N1y0wPCKiJTq3vjZnS/nN3XRPz2NDhncLEBEFPq7ytzQjgmoCJkO7
         AE0gJsYfWR+WfygQX6crU7D4Td1jt56xt20HklZPsTclWqimvA+lEUNEe8vQK1Lr0gPl
         DBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+s23VwVAqA5dvEtW7VP1t6H1t1yv7xGEEMgPH3O9Wxk=;
        b=BeF/NiBLYdRLIiMfvgfr5KKSVqZ+rqQMexzjUiXajj1Pfk9M3IO1xzCd/sb35sWTJY
         830swWBu8Hcl2JGe1kdWnF12T5jVrPb3TQSfAfA0YqN4xFNDrOPw2RdYlwYSk8NYb7Zs
         Xph76ZJ2bCHjWNQxgSVCZCiFskEsYP2UnglA2/qLSw1xgs+Gj3zsZu6pU9+i9Xb28Brc
         pnuWyXUKbuxuB0q+o08Lllze/SPT+g2J7Fd2UTdTrlzZqtOPMjcFnjsR+mDeDHZR7V4f
         27XR59e85YBknihxrAwckYznTNsmmT1OrWLJ1QjBnmXw4ld26INgdVawmmPCv55gQ+wt
         Sp4g==
X-Gm-Message-State: APjAAAVqhzYPgKPIhKFAK9CfmnRTSKKr4AwccjRlLUdDYJp/BmU66e24
        fwQFkPQ6UmQlr7GsVA3HdSP0HR3e6ZQ=
X-Google-Smtp-Source: APXvYqxijElSnlMohe7lzmJu7g9pRLwxeQJFuNMKYvPlACHRzjvZC4I0TM079fM+SgW/ezspWRA80A==
X-Received: by 2002:ac8:2655:: with SMTP id v21mr36590092qtv.0.1574194494383;
        Tue, 19 Nov 2019 12:14:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q4sm12839106qtj.41.2019.11.19.12.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 12:14:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX9tl-0001ep-BO; Tue, 19 Nov 2019 16:14:53 -0400
Date:   Tue, 19 Nov 2019 16:14:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danit Goldberg <danitg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, leonro@mellanox.com
Subject: Re: [PATCH rdma-next] RDMA/cm: Use refcount_t type for refcount
 variable
Message-ID: <20191119201453.GA6338@ziepe.ca>
References: <1573997601-4502-1-git-send-email-danitg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573997601-4502-1-git-send-email-danitg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 17, 2019 at 03:33:21PM +0200, Danit Goldberg wrote:
> The refcount_t API is a kernel self-protection mechanism, and therefore
> more suitable for counters variables.
> 
> This patch replaces the counting API from atomic_t API to refcount_t API
> of the 'refcount' variable in cm_id_private struct.
> 
> Signed-off-by: Danit Goldberg <danitg@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/cm.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Applied to for-next, thanks

Jason
