Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C091C4265
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 19:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgEDRWQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730146AbgEDRWP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 13:22:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D31FC061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 10:22:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z7so51042qvl.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pt6BMPXSrsDYj+dLJK8w8jEfMkDpMRpASOQfV9pxQLQ=;
        b=DuD1Nb41oJ2HpOUKPEnFqwPB6gNTk7Q2NwjNwktIRiUgm1IJirHhqfHquTG0Jaez4d
         vynHR5wThjgdZMuMfcFMi1Rh9K01b/zmSktWoxHp/EFnCtMdrZdWPC22RN1EbVnPgiiw
         nqpY4jkc9fqB4vI9qFbH49509NlmuKf/4awQGHWqKcdI/ONwYZBKRMwGbtkR66UT0b86
         UVnMiQH0FqTZBnLxuxV1oem9hk6XGScsq7CgR2xeLqxiSUanv1RzNmwV7UqEib7FMq1B
         jqMBLMI4y106y9vTcM3JzkIsUBshPb9+4dYu/tzU4Jyptj0k1Wv6ZHfFQYRKsWdAivwH
         kQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pt6BMPXSrsDYj+dLJK8w8jEfMkDpMRpASOQfV9pxQLQ=;
        b=lk+96ax+BnK9Ccj5u/4xALeGLS84OWlNxmnrFdnObrB07rDMpQsSy1I5RwDpDcjhbc
         ZUJ8EvkzeKiiF5911J18HSUXd+aZwUTEFXc5+vKOPcjwCo6JBKepp8PjkCkkFER3terV
         RFmoKUHlrhCSQp67EV41q8XOa4Adw6MT3ABUAfradAteWCOZYXtVPTYMUI9G7erCRugZ
         TADIyOlsakrBvIm6ch331k/UJHot4XW27m5SirVWnuJiB34ne8p1WwLPZwHFpxe/tLa6
         qseAMLghr9hr+FRnQNPPBVOtmc3tDEH5mlYQJQSX+RN4ndWCGvCWBQhs2ZmRykaXMTex
         FGiw==
X-Gm-Message-State: AGi0Pub86PvPh3sNfIVDaFSPfmqxb3igWsyrj8ze9SmpjuEzThRRBORN
        41hOb/GBCkyW9upgSMwMJuUYvw==
X-Google-Smtp-Source: APiQypJu4BaEU2jCfgY1eS21HQBvDUUbekr9MX/f8cBBw0JVYYC+cyVJZhBw8h+54MXJqAJGtGebJw==
X-Received: by 2002:a0c:db87:: with SMTP id m7mr129572qvk.101.1588612933933;
        Mon, 04 May 2020 10:22:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g1sm1511672qkm.123.2020.05.04.10.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 10:22:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVenE-0004MU-UG; Mon, 04 May 2020 14:22:12 -0300
Date:   Mon, 4 May 2020 14:22:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rxe: check for error
Message-ID: <20200504172212.GA16728@ziepe.ca>
References: <20200425233545.17210-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425233545.17210-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 26, 2020 at 12:35:45AM +0100, Sudip Mukherjee wrote:
> The commit 'ff23dfa13457' modified rxe_create_mmap_info() to return
> error code and also NULL but missed fixing codes which called
> rxe_create_mmap_info(). Modify rxe_create_mmap_info() to only return
> errorcode and fix error checking after rxe_create_mmap_info() was
> called.
> 
> Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
> Cc: stable@vger.kernel.org [5.4+]
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mmap.c  | 2 +-
>  drivers/infiniband/sw/rxe/rxe_queue.c | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
