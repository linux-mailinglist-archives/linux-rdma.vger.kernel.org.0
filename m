Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54D2F8839
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 23:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbhAOWQC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 17:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWQC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jan 2021 17:16:02 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E32C061757;
        Fri, 15 Jan 2021 14:15:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 052EB12800EE;
        Fri, 15 Jan 2021 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610748922;
        bh=EWGEw8x+FOSSNemAJ6DiY4riPR8TwPs1wmu9Dlci8Tw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=bth6Hy2SisPPp9a3aHqmIE/o+PdFuGoLtHsUgQokc7dBeY/j7r3ZZSXex3/meKCFa
         fkML+tHoj8LlkeF9Lsfk6JHvdLIri8OMqXukcYv2thKpjIt1ak4hl5cBYcPHSZrNj1
         OdSOfMaprO8U5ccd8e2CpFK1VLIXJGM2OsZxb+hc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F4OdWvEKknWk; Fri, 15 Jan 2021 14:15:21 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7218212800AE;
        Fri, 15 Jan 2021 14:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1610748921;
        bh=EWGEw8x+FOSSNemAJ6DiY4riPR8TwPs1wmu9Dlci8Tw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=HP7YN7h/DbA9+2Do19aQCaa6e35W3sxRw5Vp9air06NjYLboYqK5u0maijYsUiFIv
         ptstxfajK/rZHSxMUk/K+zsG5IcFzlW7iBGgl4GqHn7vvUBrKEoe4GU/wzDQuT6ABI
         ql0f7hpJIWTg1O63p4AE7q15Ly0qAfUccPET+AXk=
Message-ID: <6af0a6562b67a24e6233ed360189ba8071243035.camel@HansenPartnership.com>
Subject: Re: [PATCH] RDMA: usnic: Fix misuse of sysfs_emit_at
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Joe Perches <joe@perches.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>
Date:   Fri, 15 Jan 2021 14:15:20 -0800
In-Reply-To: <f4ce30f297be4678634b5be4917401767ee6ebc5.camel@perches.com>
References: <f4ce30f297be4678634b5be4917401767ee6ebc5.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2021-01-15 at 13:23 -0800, Joe Perches wrote:
> In commit e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs
> _show
> uses to sysfs_emit") I mistakenly used len = sysfs_emit_at to
> overwrite
> the last trailing space of potentially multiple entry output.
> 
> The length of the last sysfs_emit_at call is 1 and it should instead
> be
> ignored.  Do so.
> 
> Fixes: e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs
> _show uses to sysfs_emit")
> 
> Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> index e59615a4c9d9..fc077855b46c 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> @@ -231,7 +231,7 @@ static ssize_t summary_show(struct
> usnic_ib_qp_grp *qp_grp, char *buf)
>  		}
>  	}
>  
> -	len = sysfs_emit_at(buf, len, "\n");
> +	sysfs_emit_at(buf, len, "\n");	/* Overwrite the last
> trailing space */

len is the offset of where the next character gets written, isn't it?
so if you're overwriting the last character emitted into buf, shouldn't
the offset point at that character rather than one beyond it?  So

sysfs_emit_at(buf, len - 1, "\n");	/* Overwrite the last trailing
space */

?

James


