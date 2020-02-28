Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4892173B8D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgB1Ph5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 10:37:57 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33915 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgB1Ph5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 10:37:57 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so1530598qvf.1
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 07:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Has0kk3mwjJGDveKmpr+3X7/v0vmS2cL/rfL6NvWlKQ=;
        b=C9bJH7wsA+k1JK8i58qFsxNcT89LVPNyewrbHKhztVx8dRXQOgj42Lqaot54mW36tC
         PyyB6euWx8Dygb+/y8kwyDr/JflmK8oGzpEAOnaft5/0+8nPoEtf4WvxBNrSxSXBmYWJ
         yaxXU4rn7kGCNrhq61QXYC4XfwZghmVXFDcmMD1tar4AljxAzHGjhVA3pIXTaU3PsHs7
         f4VlJyukFHABM+JInVdWr4mXzF2hRx5FoXMKU2qqkczYP8DRU3jDlejg6oO/vnnhdvlX
         Bs+uektQzItwMDLI9HtR+Kg/HnKgyzXZ3rU+mNHHGFEJ6I+jpXLBpFbn0evZ3UfSRucM
         s2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Has0kk3mwjJGDveKmpr+3X7/v0vmS2cL/rfL6NvWlKQ=;
        b=QL9gt+6mbKx+sd+zKhGR6c8SjDmqKx8CP+V347O9/NoiQCQPsKlUG3yP2ZKgrXnyLx
         9oGoPLlWxNk1u4q13NAhPCCbs8X9ZWNbWgrVX7jKDoIchxf/Zsc33W0u2CszuH7pvaLL
         lD7dvhLdO9sxtdF3zRv2tJIZQWfNy0iE0l9/Y05EzEsPeYhs9fJZ0uTvNnwBsxDX+1gT
         2et4TYK0QSz743TBqT6n4wZgKwWgRYRxTNftXvKiXfm4d91N0RbXvugiDNQEAX4gcdvC
         gK0fA00zn4lP8ntfrYxPTSKfVkYY+y8crG3eEDlFV9tF6k0CA2PHnLhU2pqw0T6S0Kky
         gDSw==
X-Gm-Message-State: APjAAAVT+qGXAnSpWln9H8JhhaSuk1SZAkObqmIg8cOGmniqEm+pbn8i
        GRr24eGeR0c/Q2WpZBvGMFR1Nhy0JJM/SQ==
X-Google-Smtp-Source: APXvYqyG+NUXA/VPflLrIRp3iC3Pf6TERAKfv3WBt2GjXvSS0IgAL4y7dr84pz5PWH/jq2fUMQBM2A==
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr4281504qvb.202.1582904276207;
        Fri, 28 Feb 2020 07:37:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l184sm5214148qkc.107.2020.02.28.07.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 07:37:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7hi7-00028a-2X; Fri, 28 Feb 2020 11:37:55 -0400
Date:   Fri, 28 Feb 2020 11:37:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yixian Liu <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/2] Fix and optimize for flush cqe process
Message-ID: <20200228153755.GB8161@ziepe.ca>
References: <1582367158-27030-1-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582367158-27030-1-git-send-email-liuyixian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 22, 2020 at 06:25:56PM +0800, Yixian Liu wrote:
> Patch 1 adjust current flush framework to optimize the flush process
> in aeq case. Patch 2 fixes the bug that currently there are two paths
> to update producer index of qp by stopping doorbell update.
> 
> Yixian Liu (2):
>   RDMA/hns: Use flush framework for the case in aeq
>   RDMA/hns: Stop doorbell update while qp state error

Applied to for-next, thanks

Jason
