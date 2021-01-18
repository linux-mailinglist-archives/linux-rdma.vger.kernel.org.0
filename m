Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396932FADC2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 00:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbhARX21 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 18:28:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:40932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbhARX2Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 18:28:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7483EAB9F;
        Mon, 18 Jan 2021 23:27:43 +0000 (UTC)
Date:   Tue, 19 Jan 2021 00:27:41 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        jgg@ziepe.ca
Subject: Re: [PATCH v6 3/4] scatterlist: add sgl_compare_sgl() function
Message-ID: <20210119002741.4dbc290e@suse.de>
In-Reply-To: <20210118163006.61659-4-dgilbert@interlog.com>
References: <20210118163006.61659-1-dgilbert@interlog.com>
        <20210118163006.61659-4-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 18 Jan 2021 11:30:05 -0500, Douglas Gilbert wrote:

> After enabling copies between scatter gather lists (sgl_s), another
> storage related operation is to compare two sgl_s. This new function
> is modelled on NVMe's Compare command and the SCSI VERIFY(BYTCHK=1)
> command. Like memcmp() this function returns false on the first
> miscompare and stops comparing.
> 
> A helper function called sgl_compare_sgl_idx() is added. It takes an
> additional parameter (miscompare_idx) which is a pointer. If that
> pointer is non-NULL and a miscompare is detected (i.e. the function
> returns false) then the byte index of the first miscompare is written
> to *miscomapre_idx. Knowing the location of the first miscompare is
> needed to implement the SCSI COMPARE AND WRITE command properly.
> 
> Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>  include/linux/scatterlist.h |   8 +++
>  lib/scatterlist.c           | 109 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 3f836a3246aa..71be65f9ebb5 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -325,6 +325,14 @@ size_t sgl_copy_sgl(struct scatterlist *d_sgl, unsigned int d_nents, off_t d_ski
>  		    struct scatterlist *s_sgl, unsigned int s_nents, off_t s_skip,
>  		    size_t n_bytes);
>  
> +bool sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
> +		     struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
> +		     size_t n_bytes);
> +
> +bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
> +			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
> +			 size_t n_bytes, size_t *miscompare_idx);


This patch looks good and works fine as a replacement for
compare_and_write_do_cmp(). One minor suggestion would be to name it
sgl_equal() or similar, to perhaps better reflect the bool return and
avoid memcmp() confusion. Either way:
Reviewed-by: David Disseldorp <ddiss@suse.de>

Cheers, David
