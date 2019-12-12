Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4989011C877
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfLLItL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 03:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbfLLItL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 03:49:11 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A66F214AF;
        Thu, 12 Dec 2019 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576140550;
        bh=aJ3x1KxsEEwDXnxqdq0ukNmGgFxNaj/yKXYj1A5JCbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zkKFuSgqcmFQ2xi9lZOSAMjXT8VudOMefwOdZGK4ISgjEBk5jAhjKlg8demanHjyF
         62BiENws5o2SNDEjU4O1XEPh+Ae8FVFoGiJegs0R+2rWZHAAakRvkHYQZmv5D3c7pg
         0d8mzMIgpjE9/4vYuZWKMdEXA5dgkwZufplVJwyw=
Date:   Thu, 12 Dec 2019 10:49:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Max Hirsch <max.hirsch@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
Message-ID: <20191212084907.GU67461@unreal>
References: <20191211111628.2955-1-max.hirsch@gmail.com>
 <20191211162654.GD6622@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211162654.GD6622@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 12:26:54PM -0400, Jason Gunthorpe wrote:
> On Wed, Dec 11, 2019 at 11:16:26AM +0000, Max Hirsch wrote:
> > When running checkpatch on cma.c the following error was found:
>
> I think checkpatch will complain about your patch, did you run it?

Jason, Doug

I would like to ask to refrain from accepting checkpatch.pl patches
which are not part of other large submission. Such standalone cleanups
do more harm than actual benefit from them for old and more or less
stable code (e.g. RDMA-CM).

Let's use the opportunity to clean the code, while we are fixing bugs
and/or submitting new features.

Thanks
