Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF0563860
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfGIPKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 11:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGIPKR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 11:10:17 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E952166E;
        Tue,  9 Jul 2019 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562685017;
        bh=3RR4wO4x9wIyCWdZat0BAhFM3DRJCGRe6GcftOfcBwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ch70T3yH0ms6khKi2wxKNaH8HADdKMkxMcV2GH4FNCWvNEDLQJF0NMIzx1B8Qirtd
         TTzndVLyG5kSGB6BoUJ8uFC9hfxO9HZNpYIBnX5ztYaLs36Uw4djXGYVVD883KWSMN
         Ngyk66kAQiGzy+2NvCMwq+f+MrD4QFo6cK84Qazg=
Date:   Tue, 9 Jul 2019 18:10:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS
 modules
Message-ID: <20190709151013.GW7034@mtr-leonro.mtl.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-26-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620150337.7847-26-jinpuwang@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 05:03:37PM +0200, Jack Wang wrote:
> From: Roman Pen <roman.penyaev@profitbricks.com>
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6954776a37e..0b7fd93f738d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
>  S:	Orphan
>  F:	drivers/scsi/ips.*
>
> +IBNBD BLOCK DRIVERS
> +M:	IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> +L:	linux-block@vger.kernel.org
> +S:	Maintained
> +T:	git git://github.com/profitbricks/ibnbd.git
> +F:	drivers/block/ibnbd/
> +
> +IBTRS TRANSPORT DRIVERS
> +M:	IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>

I don't know if it rule or not, but can you please add real
person/persons to Maintainers list? Many times, those global
support lists are simply ignored.

> +L:	linux-rdma@vger.kernel.org
> +S:	Maintained
> +T:	git git://github.com/profitbricks/ibnbd.git

How did you imagine patch flow for ULP, while your tree is
external to RDMA tree?

> +F:	drivers/infiniband/ulp/ibtrs/
> +
>  ICH LPC AND GPIO DRIVER
>  M:	Peter Tyser <ptyser@xes-inc.com>
>  S:	Maintained
> --
> 2.17.1
>
