Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3482541D2A2
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 07:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhI3FUt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 01:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233588AbhI3FUo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Sep 2021 01:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F12A613A7;
        Thu, 30 Sep 2021 05:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632979141;
        bh=wSSeNQKM5J89+zczNJ1/WUTrD0XjpAcAIA+xEkv3Mos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbxDuABtua1TiU0Hk17MpfoAefx2F0Wjd/55N3/zJjD9sMqyKLxOfea9OCXEDZJLc
         n/QDPNC7yU2kWEYBI6LPdx+8reEJ5zzKoVkf1hcVKviSt/i30kSRz/677+TwS7kh3e
         4hpRLlY6zMtanTIR0U6/klxbZcd37gTP55DZFilCxBkVtv/REC0T/at6u13ZDT4lVL
         tzmUiTunwsLx4E1cGVjbMl/4uNqAr1iGTZGXNdivRchXKmBUsukvPqyn0J71RD2Jgf
         avrw8igWz1ep6AQ/JCB9uBAVynTbqqSbBZQCRBS6BBCoa5HVD5MRcNbMoGxxnaDMTM
         lkGp9vMtd99hA==
Date:   Thu, 30 Sep 2021 08:18:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@nvidia.com
Subject: Re: [PATCH] Provider/rxe: Remove printf()
Message-ID: <YVVIwUBwvr9AGHtC@unreal>
References: <20210929214214.18767-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929214214.18767-1-rpearsonhpe@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 29, 2021 at 04:42:15PM -0500, Bob Pearson wrote:
> Currently the rxe provider issues a print statement if it detects
> an invalid work request and also returns an error. A recently
> added python test case triggers such a message which is expected
> since the test is deliberately constructing invalid work requests.
> 
> This patch removes the print statement which has no practical use.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  providers/rxe/rxe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Please remove this "fprintf(stderr, "rxe: Failed to query sgid.\n");"
line too.

Thanks

> 
> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> index 3533a325..42fc447c 100644
> --- a/providers/rxe/rxe.c
> +++ b/providers/rxe/rxe.c
> @@ -1513,10 +1513,8 @@ static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
>  		length += ibwr->sg_list[i].length;
>  
>  	err = validate_send_wr(qp, ibwr, length);
> -	if (err) {
> -		printf("validate send failed\n");
> +	if (err)
>  		return err;
> -	}
>  
>  	wqe = (struct rxe_send_wqe *)producer_addr(sq->queue);
>  
> -- 
> 2.30.2
> 
