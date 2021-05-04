Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEDA37259D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 May 2021 07:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhEDFuT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 May 2021 01:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhEDFuS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 May 2021 01:50:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99AF26139A;
        Tue,  4 May 2021 05:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620107364;
        bh=/llDSS+xCUKR58H0dn+heBirsHtpKdau+XJy3W/Veb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TtMJhDTjItasjctrNKUoXgIKZaFrYqknlRSvYhX9RS03ZKw6msTnOEbFDBsdszS5T
         ipFdo2CZqr+1qqMqvY847MIyweWDKKMjuWaLSRWV2+6mrPJ5meuee0h3vTdItW4iw4
         0GuAwSsIPA0G6A8fvVSZVOs+f82zxZ1T3RuPGsgvnEid8heOo9vl2Zhj6xWaujJIaT
         Y8YQt8vuiaW6qdzPMVhXe0qhtbD75QQUMrL6TYKsJ0FzdEi4xux9DjF1cTn9xjnfNj
         /DYKp4PAOCeXEcteq9caYcustGzuhBVVQGw6SaDVjnp6zhdV1cLw8PVBSd+284X+nD
         D8IArE4smnwoQ==
Date:   Tue, 4 May 2021 08:49:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [rdma-core 3/4] bnxt_re/lib: consolidate hwque and swque in
 common structure
Message-ID: <YJDgX1gIJ0UYqXEc@unreal>
References: <20210503064802.457482-1-devesh.sharma@broadcom.com>
 <20210503064802.457482-4-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503064802.457482-4-devesh.sharma@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 03, 2021 at 12:18:01PM +0530, Devesh Sharma wrote:
> Consolidating hardware queue (hwque) and software queue (swque)
> under a single bookkeeping data structure bnxt_re_joint_queue.
> 
> This is to ease the hardware and software queue management. Further
> reduces the size of bnxt_re_qp structure.
> 
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  providers/bnxt_re/db.c    |   6 +-
>  providers/bnxt_re/main.h  |  13 ++--
>  providers/bnxt_re/verbs.c | 133 +++++++++++++++++++++-----------------
>  3 files changed, 87 insertions(+), 65 deletions(-)

<...>

>  static void bnxt_re_free_queues(struct bnxt_re_qp *qp)
>  {
> -	if (qp->rqq) {
> -		if (qp->rwrid)
> -			free(qp->rwrid);
> -		pthread_spin_destroy(&qp->rqq->qlock);
> -		bnxt_re_free_aligned(qp->rqq);
> +	if (qp->jrqq) {
> +		if (qp->jrqq->swque)
> +			free(qp->jrqq->swque);

You don't need "if() free()", use "free" directly in all places.

Thanks
