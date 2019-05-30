Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C473F3021D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE3SnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:43:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36489 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE3SnP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:43:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id u12so8259604qth.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fVuWP+kEC8BHaQwpz8pPXGMxJNXb/hJxsLDdGzj8VE=;
        b=RFJp3Lxh93CKG3lk93e5HrxXX+xp9CANG7lGuP3fg9eYMMERpg+mWsaN5GH7Et8XU/
         Gnz4yKln3T1XN9KGzg05UVJqLgFin7HJ+vBke83jTMnJwS+4oRj4XQMhy6y/EWHI3O8+
         wDIXU0zEcjyhrOHat20hnw3I3aeo2ISXZus5KPfD7UWVQau6up6YfRP8JmtOtsaNZgYU
         zDiF8K3RK+5yP4qBCissNkX3eKsssQKZ7MSohdBnGTOMr8wX/Byj6TWUwCKgW1eK7iA/
         DG+ygBGcJSlTaut45MlJZyIny9KdmHPRLaL2dFUmYS+AlzZrSScIoyZiGzQ5EsFgKBWS
         Vr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fVuWP+kEC8BHaQwpz8pPXGMxJNXb/hJxsLDdGzj8VE=;
        b=B2DuU/RUEKVL8B9tSfygbvQ/MWHaskTUcFycgwAqNwJeCZj+7Djn9nZKfr0ZfzDa6M
         2OmAtrUwdR0z6kaHyZIj8p780qABsFSYgudUkZAW8BXREOyOZZuuyaXDbBxJkLqTvo4S
         Nk5qdUZF787FjghdFnpUk/Ru7u0TPYzdA1uiQ1vSsSTY4UhU/b3WuVwfFD1QaQA8eBF/
         e/mp6oWh49SS8K3IsfFxFw2JkCq+kMEOLtrtIS6g8RqUoHC6dzxYbABtmWOmlVZE1D+8
         iHA6jlkDMAsIiYeWo61xi1jtZw2btYILsBI70uQcoTKF5ekJ4+ENIFPlar0KxnQ5C7oR
         TE+w==
X-Gm-Message-State: APjAAAUKS6k2Z6iSJxT/Cqs5+SfZnZIe2FQlQGAVoyWcISxJsB51d8hc
        5RwdDYJlg2Rqoue7ZaibM0p9yg==
X-Google-Smtp-Source: APXvYqyYMuPBND3iabFXurRA3xSCubpjNWlTkfFey4x9kNnBUPOpQF3Nizth63STtRg1Yy2LK4KVjg==
X-Received: by 2002:aed:3bb5:: with SMTP id r50mr4762150qte.89.1559241794429;
        Thu, 30 May 2019 11:43:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t12sm2040226qkt.41.2019.05.30.11.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:43:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQ1B-0007k2-KG; Thu, 30 May 2019 15:43:13 -0300
Date:   Thu, 30 May 2019 15:43:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/qib: Use struct_size() helper
Message-ID: <20190530184313.GB29724@ziepe.ca>
References: <20190529151326.GA24109@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529151326.GA24109@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 10:13:26AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(*pkt) + sizeof(pkt->addr[0])*n
> 
> with:
> 
> struct_size(pkt, addr, n)
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/qib/qib_user_sdma.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
