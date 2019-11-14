Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9BFCD60
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 19:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNSXF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 13:23:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39254 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKNSXF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 13:23:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id t8so7837077qtc.6
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BZpbNyceFmO3/Vbl5Ka3YtEiXE22oq/IC6LtKtPgmrU=;
        b=Dq3qLRwfRX4oLpT6zzHD2JT6vC4q0PYGlWr76+9aT/JKXktJvg1MRaT4K0WJUbzYRJ
         lWUMxebFIwGE1BKukZM/ikNtESz5vUam+BhC494zdOl6KheSGyu2N+a4zHaUzUcpLzuM
         5xMVXXG+yeQc5/n5eGRbFYJNSDbTxFMqVOSY/JsiBebW/SQDTtCO4ho6gqipHqiNFzlD
         X0s1GooFdaXgQaVGDg2OkxhnfXvF2+1TcZp5b16rwvxo+K1dIfXWXA4W0DhTxuDoJM0E
         8VbRgIoRqWDFwNbDx6W7RAltLzWKXeJdjx3jP6gTSQD0he77PUuOy8kVdqWaCZAT+Dlm
         6TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BZpbNyceFmO3/Vbl5Ka3YtEiXE22oq/IC6LtKtPgmrU=;
        b=JwN8pvtVI+vkfr6cmnc0aakqKxnBUOTP74g4KZ+ZPsG4aGSuU3gXFnAO1zjx9RvdV+
         e0l9xSlmE8JSuhJNhuJgT0WztHCOZh0ujytumjwWkKjf27Mvgdx0NCOBkx8zaXoYFMx8
         cYPmK20k8j3kleIf/FdsK5RzaJXR2XOE/en0hcwHk+16gs/+zAnrS4VK+xxS07CKsHC4
         Ypar2558lFha/jualQ67E6nXHEcNs+QGs+NZdx27sLwUclIwuj/F9JPotVZQlsc02451
         YxdKEgbdzOPVX1n+PsGiPmKx+eECeceZOlVjpD9cjf37zAGHr6fcmmLdrHx1l+Jbw6qO
         YLcw==
X-Gm-Message-State: APjAAAXTXKBpZS61TaO8wK0gwfOf2D2XNHOhXbmfgWwq01ZGM/xYnQwu
        Y8HRvEicXvG4lMM3tjVO9MKIhQ==
X-Google-Smtp-Source: APXvYqyBiaBbcNqy1rmudd4fmc8ctCp1bidAc+QrE8F82EV4TmQjHqb5Rz0V8xR2O64Tyd1Tl+g84A==
X-Received: by 2002:aed:2907:: with SMTP id s7mr9637139qtd.265.1573755783693;
        Thu, 14 Nov 2019 10:23:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f10sm3216323qth.40.2019.11.14.10.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 10:23:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVJlm-0004aM-QL; Thu, 14 Nov 2019 14:23:02 -0400
Date:   Thu, 14 Nov 2019 14:23:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        iommu@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: remove DMA_ATTR_WRITE_BARRIER
Message-ID: <20191114182302.GA7862@ziepe.ca>
References: <20191113073214.9514-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113073214.9514-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 13, 2019 at 08:32:12AM +0100, Christoph Hellwig wrote:

> There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
> now that the ia64 sn2 code has been removed.  Drop the flag and the
> calling convention to set it in the RDMA code.

Applied to rdma.git for-next

There were a number of conflicts in qedr, I fixed them up, but Michal
probably should check it.

Thanks,
Jason
