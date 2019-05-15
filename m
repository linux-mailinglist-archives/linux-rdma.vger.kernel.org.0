Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6B1E7E4
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 07:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfEOFZO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 01:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOFZO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 01:25:14 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090DE2084A;
        Wed, 15 May 2019 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557897913;
        bh=LgERGYjItRkhhj0lTII9Mp4mPD3KqIEfEVr4SLqcLXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiwg6lt3/EpmPYm49H39nsTkL0lgfgtVfXVaZMWW7BOmgC9o8AB3oTIkShf3Sn9Af
         z3M/vewJ0yxd5UGJXkbzOUNieEvHnzRIMshNIumAgeFhGpuNZnxmMFEPdwpqhVG8LK
         Noj/xn7NqRegeMYJFyQtl6BPcMR/ZIFVqw1mi+Uw=
Date:   Wed, 15 May 2019 08:25:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 2/5] cbuild: Remove ubuntu trusty
Message-ID: <20190515052509.GE5225@mtr-leonro.mtl.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514233028.3905-3-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:30:25PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> We only support 2 LTSs at any given time, xenial and bionic are the ones
> for Ubuntu. cythond oesn't work on xenial so remove it frmo the package
> list as well.

"cythond oesn't" -> "cython doesn't"
"frmo" -> "from"

Thanks
