Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15F039BC14
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFDPkI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 11:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhFDPkI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 11:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F5B1600EF;
        Fri,  4 Jun 2021 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622821101;
        bh=+l3/effsgAS2SRV5V0hSbpBq19XYgeEnhApmnUmhv44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzzdxAatn23SEB8rg/l1hssyVc+dJMnf1E3SYaelxaCFxBwgusrv5ETVwSpdJEoJb
         0O0riLxrqJ75LV21csIdHVndjkw4/q8pH+I5Qsk8/dIwIw25cXTGSPJLA9ArimpvFi
         F8z6BldDgDa4i59/Pkzm3+zgn3mNFmU/fGHTKErEiTjMaK4uuBNGizx4clY5IevOM7
         1EfSeVL4MffCmQ7pRO7L52pp++ZyyOyxSrwhTYLnaTaNWSpihtheZIlnpoJfA+isWp
         0LqD29ScjlJyZKwal3AoSSIuo+un3qIQkuybw2LbtHx+IMkt67qDlurVUXF95xgWD7
         3Hk2ThxeLEPbQ==
Date:   Fri, 4 Jun 2021 18:38:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        "Pearson, Robert B" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH rdma-core] docs: Add a contributing.md
Message-ID: <YLpI6e/62HFuZl31@unreal>
References: <0-v1-b00db5591f60+96-contributing_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-b00db5591f60+96-contributing_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 04, 2021 at 11:13:02AM -0300, Jason Gunthorpe wrote:
> Discuss how to use GitHub properly and document the special kernel-headers
> process.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/contributing.md | 164 ++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/contributing.md

Please update README.md, it has "Reporting bugs" and "Submitting
patches" sections.

Thanks
