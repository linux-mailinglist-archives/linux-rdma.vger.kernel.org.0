Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73C925B9DA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgICElx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgICElx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 00:41:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2344C061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 21:41:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so1865028ejf.6
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 21:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud968UthL0IpppPPRPkQ4e3L3WrndfO/jo16PhD0fY4=;
        b=LCjrzS1bVSiY+sj5ZF4q4Ps7WbvCohygeSNbFMQqJUBdIzyC2HwChcLRDgm/hWaMvT
         84OYjqa1zyLhOaZz/zp7yMpIfUbSmTxwIYP3gzclTiIlUyZ2uhYKGYThynldzpXeZ6HR
         dzlgva+ZCd97EEALXIUshP68mTLbkKF/mW9HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud968UthL0IpppPPRPkQ4e3L3WrndfO/jo16PhD0fY4=;
        b=Q33Ht26l9RDVBliBtwy3UsJedGwyz2sf0Nrf3c+FdcWdONdzbhqmBtbZWJoVATkbSP
         3bhW+jtF5lPTxFgIHB9B2C2gZgT+y3fCq687vCm0p/1PVmbzTlNYI0/GMnX4omW2AQZ/
         0SIbFVCqLegCb3xlPuILzclMDqE5FHcZrcjhhT9YNBNzYbuxMLL++lVGUyOMesCJ9Rnj
         +vgOanxPzBQpk6GDzNOwxB17XwEtCW1uuvwpW6oQfzJZVIZ9W6sfWTnrRnId5JNt1DNq
         P7Q7LWdR1iq7vctdWthwiVcXbhguX8nkExg9qGQrK7kiDJ/jqNGhfeHnubgqvngfCgi7
         kCbw==
X-Gm-Message-State: AOAM532ZVwdWEG8TSXojdtOZrvrwFGngh/w/v3g5J9AkwastoTT9e0EW
        IOPNjJaqdOjY8Yau245iYINt06L58i7H9Um54Rv22A==
X-Google-Smtp-Source: ABdhPJxD9g/mLvc6V4D6+2a3yIrQqitEFc1hEsv9/Rn1AWyUch+aMgT/MR3FonSryKtDYZ7Vuwt0ADKwkEtrT3qzA6s=
X-Received: by 2002:a17:906:388b:: with SMTP id q11mr328986ejd.100.1599108111205;
 Wed, 02 Sep 2020 21:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com> <9-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <9-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 3 Sep 2020 10:11:28 +0530
Message-ID: <CA+sbYW2EkUgxA+vX_fGAfU1suysx1atRcnUEtk-z7sSKJsA1Jw@mail.gmail.com>
Subject: Re: [PATCH 09/14] RDMA/bnxt: Do not use ib_umem_page_count() or ib_umem_num_pages()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 2, 2020 at 6:14 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> ib_umem_page_count() returns the number of 4k entries required for a DMA
> map, but bnxt_re already computes a variable page size. The correct API to
> determine the size of the page table array is ib_umem_num_dma_blocks().
>
> Fix the overallocation of the page array in fill_umem_pbl_tbl() when
> working with larger page sizes by using the right function. Lightly
> re-organize this function to make it clearer.
>
> Replace the other calls to ib_umem_num_pages().
>
> Fixes: d85582517e91 ("RDMA/bnxt_re: Use core helpers to get aligned DMA address")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 70 ++++++++----------------
>  1 file changed, 24 insertions(+), 46 deletions(-)
>

Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>

Thanks
