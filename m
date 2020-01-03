Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521D212FCEE
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgACTSm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:18:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39682 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgACTSl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:18:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so34578335qko.6
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zw6ZDnCW9m9ykWPpF1D5uzE2Vc/UNm5rv/4erHJOMkY=;
        b=KaLiodtEtOwM1EdQTRKZIObVxzdPZ1Gqirw3HQE/uw4MeTMbfWmezjhwlvDs4E1t6w
         mCOWaV5s3hwom+dyNkMJoD44TwIzhVd5dTAry7JTCdTBp0Q5ho5H/mlpkwbNqEl+EeHg
         fDZXG9BXyFdV6UJ0cvlQWVymu6LkHHBGWE3h39gkBOANVEL+A+5VHLEkGILQ58sREZIA
         +pvuQpyYjiTEfUYfKSz74qS0F42A4ulSwegiWUAt6AlXrnVC31o0LLxnAv9EEf2VBhXm
         eEgFXc9BpVDvv8rGYunrJXy68lXVvIxV3Kxwj4akoOav409xIfBLvox/+3n+A++T1Duz
         /32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zw6ZDnCW9m9ykWPpF1D5uzE2Vc/UNm5rv/4erHJOMkY=;
        b=qxhuhZRAGej6yOWnXde2Wgi1SJFx1zb40uEYzbMlZJpIsUFqce/o4h783tsm67Kbj8
         K0Dh86dwCydCp/UTs7voPR3IvwvK2/qt/Nl+12eAn4OFXOXRc0oLmRPgjWZwCvspg0uc
         rhlNs2sykb6ItM74JnGUNvm1MvmQFeUOZu97OMMd8fFi/TSL8pVZv+C4VTdyQI1LFhXz
         RPYXQtvY2pTNoMGeghyppyPrWIQPwKAiAeCea7pD+hcuQaosxTd7tcvNv8Wo5KUW4l2p
         QkQPEOvrkKgKBQLXEh7x5TC1m4UQbc2jsN0IxkuB7Yx+rxXZS0PQZ2Pd7mHOmWLxehmv
         4DfA==
X-Gm-Message-State: APjAAAUdlYBf4yFMNsEeNhsNT3Z+QYAammM876VriIyyPN/2rjzDSzBF
        cX2+HHgBIKfOJMLVGt+tY4ejqg==
X-Google-Smtp-Source: APXvYqwUIVef+KH3FX/17dXABCPtEYodfz5dVbyvTz0ZojENCXfPAsXLrW2o9W86GkXgCAr3OV5a7g==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr74010268qkk.190.1578079118545;
        Fri, 03 Jan 2020 11:18:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k73sm16906978qke.36.2020.01.03.11.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:18:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inSSz-0005we-Oj; Fri, 03 Jan 2020 15:18:37 -0400
Date:   Fri, 3 Jan 2020 15:18:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     aelior@marvell.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 rdma-next] RDMA/qedr: Add kernel capability flags for
 dpm enabled mode
Message-ID: <20200103191837.GA22810@ziepe.ca>
References: <20191121112957.25162-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121112957.25162-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 21, 2019 at 01:29:57PM +0200, Michal Kalderon wrote:
> HW/FW support two types of latency enhancement features.
> Until now user-space implemented only edpm (enhanced dpm).
> We add kernel capability flags to differentiate between current
> FW in kernel that supports both ldpm and edpm.
> Since edpm is not yet supported for iWARP we add different flags
> for iWARP + RoCE.
> We also fix bad practice of defining sizes in rdma-core and pass
> initialization to kernel, for forward compatibility.
> 
> The capability flags are added for backward-forward compatibility
> between kernel and rdma-core for qedr.
> Before this change there was a field called dpm_enabled which could
> hold either 0 or 1 value, this indicated whether RoCE edpm was
> enabled or not. We modified this field to be dpm_flags, and bit 1
> still holds the same meaning of RoCE edpm being enabled or not.
> 
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
> rdma-core changes in pr #622 https://github.com/linux-rdma/rdma-core/pull/622
> Changes from V1:
> 	Add better description in commit message of how
> backward-compatibility is maintained
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 13 ++++++++++++-
>  include/uapi/rdma/qedr-abi.h       | 18 ++++++++++++++++--
>  2 files changed, 28 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
