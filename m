Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A48415CBD1
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 21:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBMURq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 15:17:46 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37447 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgBMURp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 15:17:45 -0500
Received: by mail-qv1-f68.google.com with SMTP id m5so3239544qvv.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4vskxT2kQmcermiz74N2WbeA87j+IU/3skHFBCb1Pc=;
        b=Oy2hBPXr+rECSkiPjKe7V2zyOW8CrpR44FLPuXde0eG+aofLs/iLotVMKmLvMi0Gsz
         SUkfUV++ltQE8jzd3gVW9ornLdLRSFlBsxbi3bZ88UEcv6/0O/b9VGk4bf+lb6r4aPMY
         2lKb7FDz2hsN3Of2EE40G+KG+v0tcfpIbhEWcSpCgI2c6PkPM4ZNah8wZ9eLAKvAbJw+
         PO+Ig1Uui+PQRBpu81XElcfH1QVzbWAHGbWNWlrZZ0YagK4RzqCsA8+fAfbcrnS2BZkW
         kuZ6NNbht5fbbDC9ToFhROgw2F6SCCwvWjgcemqfUz45Dv02DcHHTaUcbErTpJh40KvY
         Hjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4vskxT2kQmcermiz74N2WbeA87j+IU/3skHFBCb1Pc=;
        b=Y57Q2uucyOslC0Ns9woAJJW9KSZHSI/zsP2/VJEszGXR4RP4KB/wFcf8yOXmKBo3wg
         sPKPlrCaOALu4fotOHv1p/P4bz3uuvAUaW9MkVuvb5MBnef+rzDAOgn+cFjJpg5FOtVx
         NP5D8GM2NpkOWJbCopIpIXkGpdWyxk3VASWI9g0Tg5gGbGz5KalozLD/iPZ9i4xN8wIq
         5rujytaWIxjvPQSpYCm8ZDg4ytrFu+OH+ueuwPNYnFpbVNM/ACSNNOCaEsg3bDM6fD4P
         f1YQZrg+hLF/Z8FQZhclhau+TesKf1d4jw03ZxVFls/DAjQnIBAcUehgBUfohBoX0Ppq
         kdPQ==
X-Gm-Message-State: APjAAAVrV29ln0JcwP1JGV81qQfhV9NewwqQd6pKgAyLZwAjuK+YqZ2F
        0A2z5tJAvzjfdRSHaPfriu7G7AnGZDz72g==
X-Google-Smtp-Source: APXvYqwjy0s57CRHZbBIVqovLva6rWftLh13y+rd0V1ouskmkGRZBCa/lg/5F7ABK6JQO/xCx+FC2g==
X-Received: by 2002:a05:6214:1389:: with SMTP id g9mr24873802qvz.40.1581625064854;
        Thu, 13 Feb 2020 12:17:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o187sm1853484qkf.26.2020.02.13.12.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 12:17:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2Kvf-0006Qn-RQ; Thu, 13 Feb 2020 16:17:43 -0400
Date:   Thu, 13 Feb 2020 16:17:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH V2 for-next 0/8] Refactor control path of bnxt_re driver
Message-ID: <20200213201743.GA24648@ziepe.ca>
References: <1580407982-882-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580407982-882-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 01:12:54PM -0500, Devesh Sharma wrote:
> This is the first series out of few more forthcoming series to refactor
> Broadcom's RoCE driver. This series contains patches to refactor control
> path. Since this is first series, there may be few code section which may
> look redundant or overkill but those will be taken care in future patch
> series.
> 
> These patches apply clean on tip of for-next branch.
> Each patch in this series is tested against user and kernel functionality.

These don't apply to for-next, please respin them

Applying: RDMA/bnxt_re: Refactor queue pair creation code
Applying: RDMA/bnxt_re: Replace chip context structure with pointer
Applying: RDMA/bnxt_re: Refactor hardware queue memory allocation
Applying: RDMA/bnxt_re: Refactor net ring allocation function
Applying: RDMA/bnxt_re: Refactor command queue management code
Using index info to reconstruct a base tree...
M	drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
CONFLICT (content): Merge conflict in drivers/infiniband/hw/bnxt_re/qplib_rcfw.c

Thanks,
Jason
