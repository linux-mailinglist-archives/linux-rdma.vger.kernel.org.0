Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C924173D31
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 17:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgB1Qkr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 11:40:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34800 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Qkr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 11:40:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id l16so2488121qtq.1
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pTEiWHbkJUOSubaEn1WKzoYhCWUGVb2OKNUIfAIv7vg=;
        b=WXUbXFrjz1iBT9UYE89Fpob6aE23TpUOtmopFmOuOzK2RbBaqb6IXz7wmVYyrIL60Q
         f1Lgg+5jykiTW74KZgSseVwHcgq9NQrSx9Hl8SpcPSdnymcCyibAR8m5eVp7YGbF0jsl
         0ZDqk8lhzIOKnD6I4Ha0KcyXfl3wc/rbFG1pZSvnFf+3JXwCabejTi6TLLq52TercGgv
         PUn11UyNg5KaNecngKTsUsQj+kduLyFNpUQM1kNBXWLNY6yMg+IRIez0qgu2dqXVe9Vb
         x8nyE7h9aJVBP5rcmQvxRPPkQZqH0E7Lwf75lAsz4zvSgitwM4ao6MXbSn2UOTDzbu3C
         BM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pTEiWHbkJUOSubaEn1WKzoYhCWUGVb2OKNUIfAIv7vg=;
        b=N/3hFc5Tn70K98F9c35x6crjP3Q9oy7izPKGFJpExZnbs48ktkykszhi2Dam1IJYfa
         jyuzHakp2lWigVla+aCrCi0mBH/qxEgjfOQTY0dmD/MnwvaR3fUMRhhspCpb+5tB6Y+M
         oTfKUQrdiC/p/fKIVO6v7+EatpnTNbUviCqvPBFtvdPhkxgkXdied7P2Zajkv6JaEsgI
         FYhJn0Mj3E6h9YSzpmL8sdnMCe2l5bX0pPuI4ZO2PzwsYkZ08uKwY6g49mhS2p8g3Kiq
         4G6Yq5sQHXsAIx0gsrWWoxYmnIkiLLvWakFa3b+3dljlXECE7KkgdkY3e3HhD2dTDqlh
         cBkQ==
X-Gm-Message-State: APjAAAUiMhfDlBLKxLEetnciLT7m9UOKkT61jdc4P7ZZqwpIHFAMPUSJ
        8Mp5Pxvy/OzENRwv+GNzza0Qjw==
X-Google-Smtp-Source: APXvYqzCxDG1+DE50mUqUPDQZshX7ltSm+C96PunZxUmBNuPnwstWsZSNT/dKtrtNe1amxXvHET5kg==
X-Received: by 2002:ac8:4302:: with SMTP id z2mr5245063qtm.188.1582908045579;
        Fri, 28 Feb 2020 08:40:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b25sm5341698qkh.6.2020.02.28.08.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 08:40:45 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7igu-0000Fq-Is; Fri, 28 Feb 2020 12:40:44 -0400
Date:   Fri, 28 Feb 2020 12:40:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 0/2] RDMA/bnxt_re driver update
Message-ID: <20200228164044.GB27288@ziepe.ca>
References: <1582731932-26574-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582731932-26574-1-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 07:45:30AM -0800, Selvin Xavier wrote:
> Includes code refactoring in the device init/deinit path and
> use the new driver unregistration APIs.
> 
> Please apply to for-next.
> 
> Thanks,
> Selvin
> 
> v3-> v4:
>  - Added netdev state query  and report the correct link state
>    during device registration
>  - Removed GID event during device registration
> v2 -> v3:
>  - Droped the patch which was adding more state macros
>  - To prevent addition of any device during driver removal,
>    unregister netdev notifier and delete the driver's workqueu
>    before calling ib_unregister_driver
> v1-> v2:
>  - Remove the patches 1,2 and 6 from the v1 series.
>    They are already merged.
>  - Added ASSERT_RTNL instead of comment in Patch 2
>  - For Patch 3, explicitly queue the removal of the VF devices
>    before calling ib_unregister_driver. This can avoid command
>    timeouts seen, if the PFs gets removed before the VFs.
>    Previous discussion - https://patchwork.kernel.org/patch/11260013/
> 
> Selvin Xavier (2):
>   RDMA/bnxt_re: Refactor device add/remove functionalities
>   RDMA/bnxt_re: Use driver_unregister and unregistration API

Aside from the ugly sched_count this is an improvement, so applied to
for-next

Thanks,
Jason
