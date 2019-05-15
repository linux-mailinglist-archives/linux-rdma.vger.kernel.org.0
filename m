Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20741E7F2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 07:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfEOFdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 01:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOFdh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 01:33:37 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA732084A;
        Wed, 15 May 2019 05:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557898417;
        bh=uItmFiB0JdA2HFM9FumKSHCiRa+dA1KXXRIqA9woz5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Or28sV8jhfZC+H1JHdj83s7yclsBZxDBWKPlDAceS0r/OUxIVjmkaNJwjerkmXtCf
         MpY02TEBIUyTKUNjo/R8DaiHcAOaBtDuoarz4CTsUhSP1BIQg5qWXX5nQNd7Zb/XBk
         /ZrVjhdNenYJYsu4LTIuaaTD/vlLADPF2xVWTR7s=
Date:   Wed, 15 May 2019 08:33:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 4/5] cbuild: Do not use the http proxy for
 tumbleweed
Message-ID: <20190515053334.GH5225@mtr-leonro.mtl.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-5-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514233028.3905-5-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:30:27PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> It also does not work with apt-cacher-ng because the server generates
> redirects for some reason.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  buildlib/cbuild | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/buildlib/cbuild b/buildlib/cbuild
> index a659a77fc5bb74..e012b08b5fbb76 100755
> --- a/buildlib/cbuild
> +++ b/buildlib/cbuild
> @@ -360,6 +360,7 @@ class leap(ZypperEnvironment):
>      aliases = {"leap"};
>
>  class tumbleweed(ZypperEnvironment):
> +    proxy = False;

It should be set in ZypperEnvironment, because both leap and tumbleweed
have this line now.

Thanks

>      docker_parent = "opensuse/tumbleweed:latest";
>      pkgs = leap.pkgs;
>      name = "tumbleweed";
> --
> 2.21.0
>
