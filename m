Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FAC1797FE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 19:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgCDSfx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 13:35:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38120 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDSfx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 13:35:53 -0500
Received: by mail-qv1-f67.google.com with SMTP id g16so1240059qvz.5
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReviJMD+t2nTkEcKpffaEWec1dHi6/oSh/k3dSk9bzo=;
        b=ou8iH/CmjpYntl/F9Fkt9NpoWHT1vt58MYkHsWR2qot/Pb08OC4XP2hmLo0dXZT2wW
         3vtMulFdr0ZguIe8awZGOexU+uB6E69wj0GsFTUGVpbTwTphtVql/9oW23CkTkAirAey
         NNq968SS9AjV7+5SpMKlo5OA2yWyHjtkQXT7UjoUH+hNGVLjZ8kC5xTXry37thc3aoJw
         8IWze8/4UXaCe7jdPndqaR8+cOYAEpS80tRToFPebLi52O7s8Sz2NdllDKQTSB37UiP3
         +mF5JSzg5Px2b86YJ+lGK/T25BZLkHNCrTiDQYN1wzdfmxqVW3qPC7cRmr9Bx/tdNpE6
         OPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReviJMD+t2nTkEcKpffaEWec1dHi6/oSh/k3dSk9bzo=;
        b=FY9u0UX8Chltg7I14IaUvYo985HxkzuobMow8ENYGIMF4CahrY2D8su+dFEFUzUmk9
         MQxFS0yv++qRidH+Dc89I3XsH8OD3UC1/WjvybTuUBTKyTQ0aLE4x3YJCcy3yWew+got
         GDtcxtTCOLLLikWnC4JKGFl/jsIf8Q3GWFSz5megTKUVbIWrrBJ6iTYN+d/6ko5DWXKK
         EnC5UfZ7qvga6t00EbjvoclAziJeu/L1+8nQTegfa2srIi6sjfpjYIE1x3OEW42LvF9/
         /0R+P2BPuDFuxNVux5RdrQ5Xz2nQD/ZDDoHsLzJC0091amtBIH1N3lnXIdwsRH2JajYg
         f+yg==
X-Gm-Message-State: ANhLgQ0rNvYlwPGYMaSoD8bgiAV09Zs8fj14tx2MZIzi7mFd8AEbng47
        oF6Tx4stybgB14KYdKFPj0UPNg==
X-Google-Smtp-Source: ADFU+vvvZIHBlgSHtiNu2mflD58ZD6RxqmLjV27603PngSRA/NMR4qXG9NtD3FBZdi3dYx/h7CEpfw==
X-Received: by 2002:a0c:8402:: with SMTP id l2mr3119381qva.227.1583346952100;
        Wed, 04 Mar 2020 10:35:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l2sm7743975qtq.16.2020.03.04.10.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 10:35:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9Ys3-0003R9-2h; Wed, 04 Mar 2020 14:35:51 -0400
Date:   Wed, 4 Mar 2020 14:35:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     dledford@redhat.com, kamalheib1@gmail.com, krishna2@chelsio.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH for-rc] RDMA/iwcm: Fix iwcm work deallocation
Message-ID: <20200304183551.GA7859@ziepe.ca>
References: <20200302181614.17042-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302181614.17042-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 07:16:14PM +0100, Bernard Metzler wrote:
> The dealloc_work_entries() function must update the
> work_free_list pointer while freeing its entries, since
> potentially called again on same list. A second iteration
> of the work list caused system crash. This happens, if
> work allocation fails during cma_iw_listen() and
> free_cm_id() tries to free the list again during cleanup.
> 
> Reported-by: syzbot+cb0c054eabfba4342146@syzkaller.appspotmail.com
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/core/iwcm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc, please include Fixes lines in patches like this, I
added one
 
 diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index ade71823370f..da8adadf4755 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -159,8 +159,10 @@ static void dealloc_work_entries(struct iwcm_id_private *cm_id_priv)
>  {
>  	struct list_head *e, *tmp;
>  
> -	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list)
> +	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list) {
> +		list_del(e);
>  		kfree(list_entry(e, struct iwcm_work, free_list));

It would be nice if someone were to fix the use of the list macros in
this file to use the _entry_ versions

Jason
