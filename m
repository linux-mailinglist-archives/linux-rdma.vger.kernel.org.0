Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1854A428590
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 05:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhJKD0E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 23:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhJKD0D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 23:26:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C2C061570
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 20:24:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c16so12691693lfb.3
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvONFfv8HyDcbkXciCdHVcBDvV/aWfIzi4HNTy7zPHU=;
        b=hW1dJRaRgMbFeNb02ZiBmj8Vt3uY4CWKQS5R25vwdc3etN4lVooRBEHQRLADMfsYAG
         mzqpZj/M89tfuIRKuV7Kz7J+5vQQbNbqGAZhqZepnqrLzz+bzYYwuG5rsnWXacUaBXKR
         fczPoiHZwy8N3bbVSX7LaK8ZdjGeGCzI1Vb6L4P2PUU/3eeFhriluu+zJMk5PyL4Qbr3
         E7TqhHNeuQp9aB23KFRCzGdXvOXbCql2OL2O39fJWDlc/13ubHFGgFHTyGIXYDtcGMpR
         xNChWYkTTqTRlhqoq2A8GbROCWneMDJvvUNCATnwdp7U8yvU+1yxk4ncGYjL4LIacTdM
         VeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvONFfv8HyDcbkXciCdHVcBDvV/aWfIzi4HNTy7zPHU=;
        b=k/HUOJj2vNY7oVnOoutC9qzwNsXIF+wLTeLu+mXEJOclxWjvXppZHnnnnezH3Nq9wU
         emH+kOZKFESbUx+IWzZr211a8c/a0s2OzWMV6+vZA45SI7LsYg4IUpyPNFwPzY7lxkig
         LiQED/VWvU1mE+TkKIpAORL5rBkVdu18mSLifLyiMRgl7qfUQZNohwuRFPSbecg4kWFg
         ZGKQn4hS3Wdxs0MN89lI+uVMl58j/JSlqF9vPp3T5tLRBv3aTe0PafQDEruSERQpOIoQ
         fJS86AzByyqe8R5+wj9n7Ek+nV4Ht0AVQVc0jeXkwZbi42nhC4oAIOerF8DgymUiMwSZ
         etfg==
X-Gm-Message-State: AOAM53375Lwofy4UBwGQ6dcgOWSVZ74VygZweH87r4SF+dHq+SsMSyZs
        8Mjd/jVsVJVohnETDny0aTwti21hHcWcW3slLjI=
X-Google-Smtp-Source: ABdhPJyLF8iPTMZqkZWm13sV/N4FDupal3EnGcb8b5h5b81zXCoQM2+hw7DOq71gTOjXH4FH5LLGuqIwufQAgEOKzw4=
X-Received: by 2002:ac2:5f96:: with SMTP id r22mr891297lfe.266.1633922642634;
 Sun, 10 Oct 2021 20:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211010004110.3842-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211010004110.3842-1-yanjun.zhu@linux.dev>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 11 Oct 2021 11:23:51 +0800
Message-ID: <CAD=hENcpQ91iaUVM+CQg-G5T-D54UVz4hiNE3yxNCe0-nDZjyQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Do some cleanups
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 1:03 AM <yanjun.zhu@linux.dev> wrote:
>
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Some functions are not used. So these functions are removed.

Sorry. Please ignore this patch series. There are some typo errors.
I fixed it and sent a new patch series.

Zhu Yanjun

>
> Zhu Yanjun (4):
>   RDMA/irdma: compat the uk.c file
>   RDMA/irdma: compat the ctrl.c
>   RDMA/irdma: compat the utils.c file
>   RDMA/irdma: compat the file
>
>  drivers/infiniband/hw/irdma/ctrl.c   | 38 -------------------
>  drivers/infiniband/hw/irdma/osdep.h  |  1 -
>  drivers/infiniband/hw/irdma/protos.h |  2 -
>  drivers/infiniband/hw/irdma/type.h   |  2 +-
>  drivers/infiniband/hw/irdma/uk.c     | 57 ----------------------------
>  drivers/infiniband/hw/irdma/user.h   |  4 +-
>  drivers/infiniband/hw/irdma/utils.c  | 45 ----------------------
>  7 files changed, 2 insertions(+), 147 deletions(-)
>
> --
> 2.27.0
>
