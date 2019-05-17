Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831BB21D3A
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2019 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEQSVk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 14:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfEQSVk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 May 2019 14:21:40 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F045B2087B;
        Fri, 17 May 2019 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558117299;
        bh=GKH3yCI2fBlKvQ4fd1ZcdChsuoYUcMx+cgncF+vA3f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QfqIO8nrDIwK5WqquymKFOHAxIzy7d/5W1Y3RbN4AHDzj9oLMtsnGN2jWGFrJRMHs
         H3OE02uWkaFqypribtp+IZLwTAZ9vdqt77ubhFj4nEmSYJLn1J2Z1RTUCpJfecMFBZ
         Xs38ECZ7F0jAGEeEyEATV9Gp2OW4c5lsKovPdrHc=
Date:   Fri, 17 May 2019 21:21:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Steve Wise <larrystevenwise@gmail.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: rdma-core debian packages
Message-ID: <20190517182129.GA5822@mtr-leonro.mtl.com>
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 17, 2019 at 09:14:13AM -0500, Steve Wise wrote:
> Hey,
>
> Is there a how-to somewhere on building the Debian rdma-core packages?

There buildlib/cbuild script exactly for that.

0. Install docker.
1. Commit your changes which you want to package.
2. ./buildlib/cbuild build-images supported_os_from_the_list
3. ./buildlib/cbuild make supported_os_from_the_list
4. ./buildlib/cbuild pkg supported_os_from_the_list
5. See RPMs or DEBs in ../

Repeat 3 and 4 till you will be satisfied with result.

Thanks

>
> Thanks,
>
> Steve.
