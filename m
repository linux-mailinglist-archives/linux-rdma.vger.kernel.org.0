Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1775242
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfGYPNM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 11:13:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45709 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbfGYPNM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 11:13:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so44491201qtp.12
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mp0Y39R0eDlT+5ucdfd/gxLgN40NqNC9MB6jitH+YqY=;
        b=CiVIXySFprGec9EVtn1HeRceO8uX6/gN3WCFsjrNOmjXfXP2QqEkiRqZrErP6FMIjZ
         80HqPdWzYQqgv5fCrEkEAR9ivRwU6XCkvTAWU/OUsRzqBMGdjPF0/soYyfYGX3q2CajF
         V6sJD+xUzomZe4vf6/2WaqTGxegYnO/gBhyO0wCsvrt8kxDf89/DvTcJWBL+hbBLjsGp
         odvW6WyXbhHbMTEdEUTy2hSG4eDvY/5F2HsELn42rBJVP5xxVY4+gbYAS6R+12argsqa
         WMRjfbvQpLkjyCkfuX3YRsFtTFfi3c05GrPn4bpaykMDF/sQ2bvcImJ7838HilDOju2e
         JgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mp0Y39R0eDlT+5ucdfd/gxLgN40NqNC9MB6jitH+YqY=;
        b=n/6zG7e5YJginbhlEtrMY6J+neRmOZRg8Erm1mhUiVUQykt18rEIQRJXvdCCywV7sB
         4v2c343po3bG+qFnG7QjtP2DPBMQLK7K0ujVsXcw9mIo0aX4GlpTzfQaDlFpmXS4Lut8
         feCYtRUONdGZgCHBAcJvytNztb61PZ7gUXFFF/u9iBgSERxx/Zg2q+3hMr+k/AUaJQFl
         kXVsbUPKD+t19RBwBBuEd4BO5AUT/XPGoIh3HZVoMb803WwiytJMcx2lMEKBe8GoUHrE
         gs5Q5Xpwyb6iKfrFDui0uOSUEFiUhobDPnVN6F81LA6U3OmcxRaGRgOS/GIQS7QpUc8H
         5+fw==
X-Gm-Message-State: APjAAAV2ERJN1BxSz1LAxoHQYnS0Abr8TkK/GmBltzBL16eFyX6IsC+G
        VQGjuhaHVViUxoB2/usJzkyVrg==
X-Google-Smtp-Source: APXvYqzpGxxb+DIio0XnS4xFeD2WXzmk6fS4KCKayHLBTFkwLsFGuVQ+ALUst0TpW5ONxHi3pANT5w==
X-Received: by 2002:ac8:35ae:: with SMTP id k43mr61491033qtb.259.1564067591512;
        Thu, 25 Jul 2019 08:13:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s8sm20856015qkg.64.2019.07.25.08.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 08:13:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqfQc-0006TX-KM; Thu, 25 Jul 2019 12:13:10 -0300
Date:   Thu, 25 Jul 2019 12:13:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 00/10] Collection of fixes for 5.3
Message-ID: <20190725151310.GA24809@ziepe.ca>
References: <20190723065733.4899-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723065733.4899-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 23, 2019 at 09:57:23AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is small patch set of fixes targeted for 5.3 and stable@.
> 
> Thanks
> 
> Moni Shoua (1):
>   IB/mlx5: Prevent concurrent MR updates during invalidation
> 
> Parav Pandit (4):
>   IB/core: Fix querying total rdma stats
>   IB/counters: Initialize port counter and annotate mutex_destroy
> 
> Yishai Hadas (5):
>   IB/mlx5: Fix unreg_umr to ignore the mkey state
>   IB/mlx5: Use direct mkey destroy command upon UMR unreg failure
>   IB/mlx5: Fix unreg_umr to set a device PD
>   IB/mlx5: Fix clean_mr() to work in the expected order
>   IB/mlx5: Fix RSS Toeplitz function to be specification aligned

I took the above for for-rc

>   IB/mlx5: Avoid unnecessary typecast
>   RDMA/core: Annotate destroy of mutex to ensure that it is released as
>     unlocked

These are not really -rc patches, I took them to for-next

Jason
