Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFD242523
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Aug 2020 07:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHLF5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Aug 2020 01:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgHLF5h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Aug 2020 01:57:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E67920768;
        Wed, 12 Aug 2020 05:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597211857;
        bh=FLc+Zw2dJwnTMj/gMY+Xvf0FURIythZJ4Borm0Xv3u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7iqNirmuKrpAEOm26iHkhVYlPfF1HrFQijIWvK8Vvogv8gyUVafEg1q6LoAoaYph
         vamJHfNDzwnSz8za2A7TNEwqTRoUb4Huj1h3caAUj2/clwZgGwHBFidRH6qgKZnsjw
         WnDbL3l47jf+d/K9y+ZOmjG7NQdDtvxXepFh6Uvo=
Date:   Wed, 12 Aug 2020 08:57:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Subject: Re: Is there a simple way to install rdma-core other than making a
 package?
Message-ID: <20200812055730.GJ634816@unreal>
References: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 10:41:02PM -0500, Bob Pearson wrote:
> There doesn't seem to be a documented way to make install rdma-core, at least in the README file. However trying the obvious
>
> $ bash build.sh
> $ cd build
> $ sudo make install

The build.sh script that comes with rdma-core builds libraries in-place
and is not suitable for "make install".

Thanks
