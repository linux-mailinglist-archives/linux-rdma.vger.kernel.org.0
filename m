Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33933FCA46
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 16:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfKNPxG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 10:53:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34950 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNPxG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 10:53:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id n4so7315670qte.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tLI/gn4OSN8ZC/Du6JdVBQfUYGGcPQMSiqf5vI2eXOc=;
        b=Dd727wo+TuDWwkH44X9N4CtBsI2dSYsENPDZa58bkPuAqqYfbwYj2r1Nk4lJhLwMtg
         gAP8Zjtdv9AocJu8SGIIAQWMmAaG0WTWZF0Y1Qv9/RVMvHUs0aQFrpLlMUHJEkgMsFR4
         pEhnfS8bWWut7Rk/dDx/YCO9wkwnFvFMvjy25+Teb+aMd3Mgvzq7GrSoEn1X//aptASa
         zBHNyZgY8wk7d/1Pq10HA0IMPg9JSqbJprel0jFNaNMN0o8V+j90xs9jxJQyQ2+jmQr6
         5zUGXxNmfIWt2387u/W9iGxHAS0orB8bAju6IPR7SmHo77BE24FPTiGhX0fOlhrcn5S9
         uS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLI/gn4OSN8ZC/Du6JdVBQfUYGGcPQMSiqf5vI2eXOc=;
        b=c0F9FBmWrFcy/BXccW9ElLD21GRf9nyvYRHxKr9SRLYwnu/fR/edGhv9WxTXnfYIku
         96bJQmNHI5OyAKbLdGtF7Rdl/c+hXObWw6ECV6LC8ywUWlKYPL/1neEv4AjU8lX46dEU
         thjjnYA9+kBr7Hz1xMtXYFv6aq7jA8Gh4targcUNp5ZrwHXAZ8jRbSLjvCJrfEVQ5Ehr
         czkSSQc6tNUs9ZD3x5lU++IElpWfmU4Rnxu74ppCi9pwn5BnfZROspJZ09XWjVmP24pI
         pjHTaEO3CQaxTckXMQrOhv3EcIry4hGZjO3GLN4qc2Vhv1Nes1NFGioBp0zPVRD4+lA8
         JJ0A==
X-Gm-Message-State: APjAAAX1pvJ2eth1JYwrGyKFLvEi8ZW3HlYu+KptNtZ6096ps7Ti7hAr
        zKPr3vCIVHKcaUvMh4Ani2p5eA==
X-Google-Smtp-Source: APXvYqzeUQUldqMDzsiVRmmIdb0yNx9xu3Yzfu1xZYJyiYmmV00R48O2IXGFsO96S7ICqoOTKpLtfg==
X-Received: by 2002:ac8:1494:: with SMTP id l20mr8747839qtj.356.1573746785170;
        Thu, 14 Nov 2019 07:53:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c27sm2592467qko.132.2019.11.14.07.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 07:53:04 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVHQd-0007Yv-Cq; Thu, 14 Nov 2019 11:53:03 -0400
Date:   Thu, 14 Nov 2019 11:53:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/qedr: fix potential use after free
Message-ID: <20191114155303.GA29040@ziepe.ca>
References: <1573021434-18768-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573021434-18768-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 02:23:54PM +0800, Pan Bian wrote:
> Move the release operation after error log to avoid possible use after
> free.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
