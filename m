Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730DF2FB896
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbhASNQa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:16:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:60670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389055AbhASLvJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 06:51:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE34BAC7B;
        Tue, 19 Jan 2021 11:50:16 +0000 (UTC)
Date:   Tue, 19 Jan 2021 12:50:15 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, bvanassche@acm.org,
        jgg@ziepe.ca
Subject: Re: [PATCH v6 3/4] scatterlist: add sgl_compare_sgl() function
Message-ID: <20210119125015.2f063af5@suse.de>
In-Reply-To: <d0b8312b-5dbf-6196-d962-40851c5cbbf7@interlog.com>
References: <20210118163006.61659-1-dgilbert@interlog.com>
        <20210118163006.61659-4-dgilbert@interlog.com>
        <20210119002741.4dbc290e@suse.de>
        <d0b8312b-5dbf-6196-d962-40851c5cbbf7@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 18 Jan 2021 20:04:20 -0500, Douglas Gilbert wrote:

> >> +bool sgl_compare_sgl(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
> >> +		     struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
> >> +		     size_t n_bytes);
> >> +
> >> +bool sgl_compare_sgl_idx(struct scatterlist *x_sgl, unsigned int x_nents, off_t x_skip,
> >> +			 struct scatterlist *y_sgl, unsigned int y_nents, off_t y_skip,
> >> +			 size_t n_bytes, size_t *miscompare_idx);  
> > 
> > 
> > This patch looks good and works fine as a replacement for
> > compare_and_write_do_cmp(). One minor suggestion would be to name it
> > sgl_equal() or similar, to perhaps better reflect the bool return and
> > avoid memcmp() confusion. Either way:
> > Reviewed-by: David Disseldorp <ddiss@suse.de>  
> 
> Thanks. NVMe calls the command that does this Compare and SCSI uses
> COMPARE AND WRITE (and VERIFY(BYTCHK=1) ) but "equal" is fine with me.
> There will be another patchset version (at least) so there is time
> to change.
> 
> Do you want:
>    - sgl_equal(...), or
>    - sgl_equal_sgl(...) ?

I'd probably prefer the former as it's shorter, but I don't feel
strongly about it. The latter would make sense if you expect sgl compare
helpers for other buffer types.

Cheers, David
