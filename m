Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C884604
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 09:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfHGHaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 03:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfHGHaC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 03:30:02 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6097822CEB;
        Wed,  7 Aug 2019 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565163001;
        bh=gZI3qb52Txd5NXbYQwpvE5TRuye1QDSsqaAU1N1Ao/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcPET1FK7NtZ5MJo7kJ20O0e2u9PvKr37tcAqUUH/f4oCuGHCQLn/iFADstnODDMI
         eZFIsiFDRfoe4eWWvUzxeaZKtTg5z08qJmUq+LgaP3kajhxESjC7ajchvnShKAFthm
         yqo/60MUtsqZWCZfspraSj4n5Qj3fzgV5fcV7AXE=
Date:   Wed, 7 Aug 2019 10:29:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: v25.0 ninja install failure on pandoc-prebuilt using git tree or
 release tarball
Message-ID: <20190807072957.GA32366@mtr-leonro.mtl.com>
References: <CA+X5Wn75Lfh_i89sW1L+x1S3rnZsEGkzfNYju4woPvq0yCo=XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+X5Wn75Lfh_i89sW1L+x1S3rnZsEGkzfNYju4woPvq0yCo=XA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 11:45:21PM -0400, James Harvey wrote:
> I'm one of the Arch Linux AUR repository rdma-core maintainers.
>
> We've always build rdma-core from release tags in the git repo.
>
> As-is, building v25 from the git repo has a new build requirement of
> rst2man, which isn't documented in the release notes or in the readme.
> (On Arch, part of the python-docutils package.)  I haven't directly
> used pandoc or rst2man before, so I don't know if rst2man was added to
> be an alternative to pandoc, or ran in addition to it.  In case they
> were meant as alternatives, the build system doesn't currently
> function that way.  With pandoc but without rst2man, it says
> "'install' disabled", and never builds the man pages, causing "ninja
> install" to fail from not finding
> "pandoc-prebuilt/f48a8d31ddfa68fad6c3badbc768ac703976c43f".

rst2man is an extra requirement due to addition infiniband-diags to be
inside rdma-core.

Patches to update README are more than welcomed.

>
> I looked at switching to the release tarballs (rdma-core-25.0.tar.gz),
> which of course has the prebuilt man pages.  I assume doing this
> should completely prevent needing pandoc and rst2man.  But, then
> "ninja install" fails from not finding
> "pandoc-prebuilt/32acf8c8016edc90e7adedc5be9caecd9b8abb3e", which I do
> see is not among the 81 directories in "pandoc-prebuilt/" in
> "rdma-core-25.0.tar.gz".  Were some of the necessary prebuilt files
> not included in the 25 tarball?

Not intentionally, maybe bug.
