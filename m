Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25A150B2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEFPvM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:51:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38689 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEFPvM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:51:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so15265669qth.5
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=14UOh5ci04U2f3OG4dQ+gZ9/xGd8b43Dg40qh5QIM88=;
        b=gHhbsxxHaCNAF+hNCc7vxQhY8CZcfvbQcVUP1HQ7LaOqyY+8aId5V0XTNCJBIrTVUL
         er7/H1KW1WQZUBmTiwvj4j6QKnE/gBRqu4H5qn1irDd9+va6fGFwTJIqLP8hqHhUm0Xf
         l0/olEEVWijOHvANXQFE9K66sAsSPk4McCQmbkdOwnlHu//6esfhGRI8es2PhZOyfUN7
         vQ2dWYbTdvOv6PjpEq9Ge+gPRHFRh015XtKubIA3Gm6nDZwoSRvRVG+1vLGSgczWb651
         Y1csslEpBPMDV/pBO61abOZq8yETx3X6r+qRX5jJ2kkXejmFAeLf/PWUU+1AIqWkTfX9
         0jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=14UOh5ci04U2f3OG4dQ+gZ9/xGd8b43Dg40qh5QIM88=;
        b=GS1J/Ighrl/HqjtmO/DNluQRt1dDXfT3krD03cOYe+/soTOXATWztn4O4GQuRnvs+p
         sollZzmKsbiJ4OSf+tHxFfCiP+GZYOxRg909+OtFuIkVsg368JCb2Y/Tb4JrvGtJCWY/
         +CPW1CRg/xIFyNnp5ggb7fs8YVvW3HghBXP81uq4n6j51kMRffDr4qsCcRCcDlI/bqnA
         LsCMHxTKHp6XAhpWcdNe0F+uMtm0TzIv2H0+Gf/Gf9U+4/+91jT1aOi5kbve4mkNi639
         iDhhNPmj5kBaLPWOrdJxParcBT2Qw5jUo6Ec/pXuDTZ3STyMX2Kd7qI9BizVsc/acTgE
         MR1g==
X-Gm-Message-State: APjAAAVwOgnQOABMnBpkDcPIvOCnMSMn5PucTYX+q96ApOV22wqJ+srI
        f24TUGuA30ZvyE/wTTqBqbCRmw==
X-Google-Smtp-Source: APXvYqyxycpiFPv74G1jRxhF3rvXOpZNgaY7l05e1Shbk9/sZrBHV0UND16ReCRK4f5UzohXMvK91A==
X-Received: by 2002:ac8:65ce:: with SMTP id t14mr12890441qto.22.1557157871401;
        Mon, 06 May 2019 08:51:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t124sm5893760qkh.29.2019.05.06.08.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 08:51:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNftU-0007d6-Ss; Mon, 06 May 2019 12:51:08 -0300
Date:   Mon, 6 May 2019 12:51:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Catch use-after-free access of AH
 structures
Message-ID: <20190506155108.GA29293@ziepe.ca>
References: <20190416121310.20783-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416121310.20783-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 16, 2019 at 03:13:10PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Prior to commit d345691471b4 ("RDMA: Handle AH allocations by IB/core"),
> AH destroy path is rdmavt returned -EBUSY warning to application and
> caused to potential leakage of kernel memory of AH structure.
> 
> After that commit, the AH structure is always freed but such early
> return in driver code can potentially cause to use-after-free error.
> 
> Add warning to catch such situation to help driver developers to fix
> AH release path.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/sw/rdmavt/ah.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next

Denny, since you missed the merge window with the fix, please send a
fixup next cycle. The WARN_ON will scare people who might be able to
hit this buggy case.

Jason
