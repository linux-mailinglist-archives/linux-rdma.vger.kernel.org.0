Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163AB220FC4
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgGOOqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbgGOOqy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jul 2020 10:46:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 188C32065D;
        Wed, 15 Jul 2020 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594824413;
        bh=FHvPoY/h34S9+tvWXn9+thNKrWQKiJ8xGlfKBAGAI2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzQJ2M84y5LB0NOkatKG3qA0jAGZ/w8VT59DOHjXt323Ue1hrsa+Ulz1VWkbMOy0W
         QCjbJ9+7FyoZCd49TzbgsOl5cgLRG/bPyhsrj4ng9k2G8yHYDz+OvAFGXJw8wSc3Iq
         wt/P1JUDB9Kr3A0SPmjfnxiKKzC+C4q0NNb7kA20=
Date:   Wed, 15 Jul 2020 17:46:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Subject: Re: [PATCH V2 for-next 6/6] RDMA/bnxt_re: Update maintainers for
 Broadcom rdma driver
Message-ID: <20200715144649.GD813631@unreal>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
 <1594822619-4098-7-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594822619-4098-7-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 15, 2020 at 10:16:59AM -0400, Devesh Sharma wrote:
> Adding a new co-maintainer for Broadcom's RDMA driver.
>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b5ffd6..96d6405 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3582,6 +3582,7 @@ M:	Selvin Xavier <selvin.xavier@broadcom.com>
>  M:	Devesh Sharma <devesh.sharma@broadcom.com>
>  M:	Somnath Kotur <somnath.kotur@broadcom.com>
>  M:	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> +M:	Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>

Are other three still relevant?

>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  W:	http://www.broadcom.com
> --
> 1.8.3.1
>
