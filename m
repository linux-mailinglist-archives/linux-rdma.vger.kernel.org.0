Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E515CA87
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 19:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBMSiA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 13:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgBMSiA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 13:38:00 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C3FB24649;
        Thu, 13 Feb 2020 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581619080;
        bh=GgE9jaJHksVdV/CcvSv2LRLhhQw9KD+aQI+eJax4H+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kElno5GSpAxYVkSmxjcez2c0dXmtA7T1QNSInohnokYFchxbdV8WKlVHUXOjHYqV1
         7fmsaF706LRivXSdhxX1jAuXNVSjX1IVYteg1TaEm6T82AID3YodRoGaU6DVzX1via
         fLxXy0j4DX7rBSv7PUNy6nMISM+QsK0sI+glanuk=
Date:   Thu, 13 Feb 2020 20:37:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core, cache: Replace zero-length array with
 flexible-array member
Message-ID: <20200213183756.GI679970@unreal>
References: <20200213010425.GA13068@embeddedor.com>
 <20200213010827.GG31668@ziepe.ca>
 <1e6d952f-7d43-db2b-67f3-001ab8421bc8@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e6d952f-7d43-db2b-67f3-001ab8421bc8@embeddedor.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 12:36:39PM -0600, Gustavo A. R. Silva wrote:
>
>
> On 2/12/20 19:08, Jason Gunthorpe wrote:
> >
> > There are many more of these under core/* care to fix them all in one
> > patch?
> >
>
> Sure thing. I can do that.

Gustavo,

Was checkpatch extended to catch such mistakes?

Thanks

>
> Thanks
> --
> Gustavo
