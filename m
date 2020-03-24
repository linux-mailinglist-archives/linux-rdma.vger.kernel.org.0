Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD44F191D62
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 00:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCXXSA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 19:18:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33502 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCXXR7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 19:17:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id c14so613693qtp.0
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2020 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xU4m3TV1neUbxOA7Rg4CVwlQNhcKtQQdTho3IyQ6ECg=;
        b=PW1C5z40c3Iw8GG4qnHw8g2SS4hoR8rBYokXovxcBZeUHguzD/SKIqmAF+aFseVgK6
         9JfHebCHRxQlwb7O6Dg9sLSGUdccAl79xgFgTMWoHAJaKO0ZElY/fjyW+O8WRagGkMyo
         2dd5ZL4zRpg2yMf/qkrcFXI0Lme0JjHV056df3md0LfeL+axjCiP4dR9m4kc6LVrjW1o
         +sV8NpTDw+tU1XsMvEySNRHKxzX8/oOYqhP3PwECocVkNWhxu05zE3P9S/p9ZvnQ8iZv
         rOrCTskle1uVOMQ/tm5dUVbHKz8CU9vkv4143il9yiAV/XizDEAN7DykuyWJHiR7LEg8
         mQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xU4m3TV1neUbxOA7Rg4CVwlQNhcKtQQdTho3IyQ6ECg=;
        b=BlJnn9trdUJ/fPCCKaiUWtk03VxvLuCJqltv7B5YjtZ/S8oY0f0UCFhOKyEWdwMdCm
         d8jjHj6pNrVhr9HxoT1tLlzioA0uWkex6zS/SEhP+mJpbljD4jgstMYzYSoEqwWD/98H
         lTRtPLDTM2h5OBqgvcDRolaNyF0lW4EsANlFGpsCOWApfHEnUjS43daFZgzvW7ToM889
         9V/5rnBW7SKc8bIRc7e6qRJLEkDMMhFr/pqggvX7cWSVoE8STp+uu8N/xsj083J1ZemV
         J4VlJS/u4XbEe1eagJsp9PM+E5B8+ApNPffXnqB7gmMQWzP0K3qyS8QgjMERvckkSXv8
         Xj1w==
X-Gm-Message-State: ANhLgQ2olmbd4qL50JvQUpsRpfnBeCB04w7dge61GIt4QcO1mLLcdSdb
        Av9l5u+qJl8y+oAj/ew88wTNRQ==
X-Google-Smtp-Source: ADFU+vtlYS4SRIbEWzbQNuxyfCuDoJ0pNMuVQk10cURIKRSw3Dlf+NbjGxW0tXF5Y5SldbEF/yAZqA==
X-Received: by 2002:ac8:fcf:: with SMTP id f15mr288821qtk.233.1585091877128;
        Tue, 24 Mar 2020 16:17:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c191sm13847277qkg.49.2020.03.24.16.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 16:17:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGsnz-0002jX-UA; Tue, 24 Mar 2020 20:17:55 -0300
Date:   Tue, 24 Mar 2020 20:17:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Wait for all the CQ events before
 freeing CQ data structures
Message-ID: <20200324231755.GA10457@ziepe.ca>
References: <1584120842-3200-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584120842-3200-1-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 10:34:02AM -0700, Selvin Xavier wrote:
> Destroy CQ command to firmware returns the num_cnq_events
> as a response. This indicates the driver about the number
> of CQ events generated for this CQ. Driver should wait
> for all these events before freeing the CQ host structures.
> Also, add routine to clean all the pending notification
> for the CQs getting destroyed. This avoids the possibility
> of accessing the CQ data structures after its freed.
> 
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 74 ++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h |  1 +
>  2 files changed, 75 insertions(+)

Applied to for-next, thanks

Jason
