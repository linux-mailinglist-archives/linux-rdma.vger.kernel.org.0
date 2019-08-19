Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964DE922FC
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHSMDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 08:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfHSMDP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 08:03:15 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80AB12085A;
        Mon, 19 Aug 2019 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566216195;
        bh=o+HxAR1Ywo4simHvdcGS71j97/IByeVl7sbTHPTgP/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybFqbYfzZR4TrKFDOZDelP9OzkLzEddSm9GuAHD88pAgHyw3SOciF2XgGGiJm+4Y/
         Sq+MzvEVyIXpQPCC32hbhqnuls8qGXD3M7dfjRqGj5ir3hCdTZ/PofbICMHb3mQU06
         sZ0CCPxDX5EdZQQW/rPTaKJTltS+juynqim23fqc=
Date:   Mon, 19 Aug 2019 15:03:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: hfi1: fix memory leaks
Message-ID: <20190819120311.GF4459@mtr-leonro.mtl.com>
References: <1566154486-3713-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566154486-3713-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 18, 2019 at 01:54:46PM -0500, Wenwen Wang wrote:
> In fault_opcodes_write(), 'data' is allocated through kcalloc(). However,
> it is not deallocated in the following execution if an error occurs,
> leading to memory leaks. To fix this issue, introduce the 'free_data' label
> to free 'data' before returning the error.
>
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/infiniband/hw/hfi1/fault.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
