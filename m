Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84460F58D9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 21:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKHUpO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 15:45:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:47063 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHUpO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 15:45:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id u22so7914522qtq.13
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 12:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I0yt9NOlPdQK4pyk5XNp8rpDRerWCyST/QKR+ZIGp7I=;
        b=daBP5yttn6q4281Z5E49tomMsOLnNcvRGabMGn6L0ed5HA5thy++7vEU6k7xYq/mFI
         oWEyBugz4CknDd6Hk7/s9aRmw7poZJ00Fft4+hAMffrXlMhHF2XOroYrm/gzFidUXIS2
         642o9bXR9vaeMXBssOzweJwOhe2XxEYyRrXZmrE3sAxaAvO8kt9fw1yjjuWtApFb0deh
         QGqEPNs3AptmqVLQudHEymgwsZjIn0KDkKQucH1XTqTrIYYwy9Ayoyqibm2bAAHSaai9
         gx7wOAQ9u4xWzqNOzbN1UyUXYic/b/xOJD0QJ4D2hGYzT4B3NZknkxwkYU/Xm7JinTaN
         to/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I0yt9NOlPdQK4pyk5XNp8rpDRerWCyST/QKR+ZIGp7I=;
        b=XndEhgbMAyVbdVSu2xA1YqMUZrCEzNaGuhWyWvCbQG4yM1XOlSuvIfZZ1GlD4Iaw2E
         2b77krRSyf+jwngDqFJDLVNqgS3Df76aXHBmC9v2eNa+aoyxrY5ruDzpG44ayFIrauvu
         SkgoUTWv5pVYQFByGxzCHYc5XuFTESZsQ6JSiesJyRSSLH2mbgbatP9u1L14CpZkfDr4
         CD76Ae5Ky/MHszmRXS1VeHhBotXUEuuhs1pj/1xIXrR8oQYTQyvd38AMe1gvknuRHweh
         CZ9zz+iaOjnI8QQHHQXY9XbKxULiMeHYaq3qdiWTbcg7fPqSOj6SPFIIpRBu0DAdwvHD
         gqIg==
X-Gm-Message-State: APjAAAWvc5XGsR0XOVAFCWuJy3uwRy3bwPtzvcxmilygKK4msf4DTpVC
        Yf8n3PnZ239uGzfxiOhF4Kx17eEo6Dw=
X-Google-Smtp-Source: APXvYqxgUT53RW4NVQ9tg8tiMY38meWm1+jqOeg3xBEipjtwDLK8gZBsUMmSZBnliGIcC9zfYFJ/qQ==
X-Received: by 2002:ac8:6641:: with SMTP id j1mr13076208qtp.48.1573245913393;
        Fri, 08 Nov 2019 12:45:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id y33sm5486311qta.18.2019.11.08.12.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 12:45:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iTB84-0007SZ-5k; Fri, 08 Nov 2019 16:45:12 -0400
Date:   Fri, 8 Nov 2019 16:45:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/9] RDMA/hns: Cleanups for hip08
Message-ID: <20191108204512.GA28649@ziepe.ca>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 05, 2019 at 07:07:53PM +0800, Weihang Li wrote:
> These series just make cleanups without changing code logic.
> 
> [patch 1/9 ~ 3/9] remove unused variables and structures.
> [patch 4/9 ~ 5/9] modify field and function names.
> [patch 6/9 ~ 7/9] remove dead codes to simplify functions.
> [patch 8/9] replaces non-standard return value with linux error codes.
> [patch 9/9] does some fixes on printings.
> 
> Changelog
> v1->v2: Remove "{topost}" in titles.
> 
> Lang Cheng (3):
>   RDMA/hns: Remove unnecessary structure hns_roce_sqp
>   RDMA/hns: Simplify doorbell initialization code
>   RDMA/hns: Modify hns_roce_hw_v2_get_cfg to simplify the code
> 
> Wenpeng Liang (1):
>   RDMA/hns: Modify appropriate printings
> 
> Yixian Liu (4):
>   RDMA/hns: Delete unnecessary variable max_post
>   RDMA/hns: Delete unnecessary uar from hns_roce_cq
>   RDMA/hns: Modify fields of struct hns_roce_srq
>   RDMA/hns: Fix non-standard error codes
> 
> Yixing Liu (1):
>   RDMA/hns: Replace not intuitive function/macro names

Something should probably be done about that custom bitmap stuff Leon
noted, but that isn't related to these patches, so applied to for-next

Thanks,
Jason
