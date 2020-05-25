Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565A41E132A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbgEYRGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389112AbgEYRGt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 13:06:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E51C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:06:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so17955707qkh.11
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+IoqxRzlr0y/QgIfk0kzJKKCEPSb5pYNah9Y6aOeFIg=;
        b=dRLMlhi1f6SS7NhhHmgBPB0lzP6/d5TPrJJdQybXk18RjxeMwgxAJWTwVvDueOF6dM
         9DNaRrQLzRH6cTWauGwAk/J1brSHtPzVSvA7xaWVI/fZGfufCDdi0xxxW9xbDDb0uBEM
         4RqAar2a8/7rpL851eD8ysb5T0Ug/jI2bgM4ODDYngZdJNH6B7iFy9LPPgo4pbLcg30o
         0eNzpgLEjeIBQXa6VcYfHalh22kgg4uxJP5ANN4pv7HTCX6UOY4wpY4XrrBHqKyfKvIG
         wmJ0j0KxA9DA/EWxF9cVPnbcmXmKYdcKrJA3L1WOnFxNky/Sb7dG3b+yMb7NF1fBxw8c
         CqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IoqxRzlr0y/QgIfk0kzJKKCEPSb5pYNah9Y6aOeFIg=;
        b=bwgmddocLXRQg0pgidTTaxhUyycj+2iN2zzITZvdicfSQUPtQ/sBjRouqmVHfFYtYK
         m2UGTFbTwiZTqt4uhENVTu1lHxvo0gh6oBzfXOJADllg8ZjOx1pSGceGBmceHT19mH+l
         sT0Fz+YJUDwP4AMN5RvvXxTEbsjoMGLOWx6cCuCddLzKkT4VlwVMMqlHJCGZVXConTwG
         sMwmlA1Wxu8NrmSj75taQPePS9AgwTCwf/RycVro6xHnN4/i/JkL0gcb3cOVorFGNR1g
         +DuDt6UsupI2BpP6zP2jcFALVMmmt453cVUhtUy7mt9bBbTzZDfpVZvPS2NqkypdnYhq
         tniQ==
X-Gm-Message-State: AOAM531v/HXQHP36pVBxmfefFnq6KGQc1WV3AkYnDb+ExrabatvHv8hF
        +QEzRHtex+Kz4egbVMAYE7jt7A==
X-Google-Smtp-Source: ABdhPJxHG5zBFWOsC7vsgLXDKctOFJ9RannJoj9q0cQk5NmepD7KFgkKyVGwjmaSJRD8fUuf8fH5iw==
X-Received: by 2002:ae9:f50f:: with SMTP id o15mr28837943qkg.177.1590426408954;
        Mon, 25 May 2020 10:06:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d17sm2050652qke.101.2020.05.25.10.06.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 10:06:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdGYp-0004FU-UM; Mon, 25 May 2020 14:06:47 -0300
Date:   Mon, 25 May 2020 14:06:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/9] RDMA/hns: Add CQ flag instead of
 independent enable flag
Message-ID: <20200525170647.GA16200@ziepe.ca>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
 <1589982799-28728-3-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589982799-28728-3-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 09:53:12PM +0800, Weihang Li wrote:
> +	roce_set_bit(cq_context->byte_44_db_record,
> +		     V2_CQC_BYTE_44_DB_RECORD_EN_S,
> +		     (hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB) ? 1 : 0);

It seems like the if expression should be inside the roce_set_bit
macro (just cast to bool) as something called 'bit' should have that
safety built in.

Also, if someone wants a project, all this endless stuff should be
using genmask and field_prep instead of this home grown stuff.

Jason
