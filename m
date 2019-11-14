Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD4FCA69
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 16:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKNP7P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 10:59:15 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37171 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfKNP7P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 10:59:15 -0500
Received: by mail-qv1-f68.google.com with SMTP id s18so2549702qvr.4
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypQJ09LjJ5SkiuymIhTrsxa/hBERzikwJAxhzfQUU1Y=;
        b=QqD0/IZpg7IyAsed5GsOWhf0KAQT9DX8LD+Z+GuMSZ1Vz8yeASxnItFbRSVNQl7f7X
         HaKzKbzJXFYbrcdD71minyytQ4F8OU9mncYEo9ompt+VibGBtsqjr9e3tloqdq2HSjZq
         nJw54Lqp1DuuS3p5UrVNs4/QynVklUX/nrQaawrE1je835hc0FsmBRxsuPcePvYnBJJl
         yHax0b6SWFgeZ4unv5tUjsdlJTAFDDP6u3x/ze9V9At2uI5fR2QSW4x37krXqSw5I48Y
         UF/aiPYNZocu0KVCpIDLAlldrM0TwSTirl5KkfG/K57IYsPq1l8Vf4fWamITUmQevueV
         Il4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypQJ09LjJ5SkiuymIhTrsxa/hBERzikwJAxhzfQUU1Y=;
        b=o8TkMu4XG50eUloNTM6w+mfqgPQHsf2FBTy4GvoJSfGew4xEyFXVnvCY/Kr6TO0HNY
         fNBmRS4ixEAy6RUIwOcojB+OisoHabVG+JCBZUP9n+odaZMgPUZC0MmpB3LaOOPXQ7gj
         alIqwOBl49X7A+tjjMLKl3UBfHP/iMmVQidVp1ra4NFRYDA46cgq+JW2B2N7xjmddQFN
         lc2VotIiCS0bRSY/j0mIiZkuTuXMvUR79FUvkbfGwfFKg1WnubRJP+NRB0UHkp4GwUUI
         GP48kYF+W+lrHX2/q3wfhKAfeZRPmLFptKvCRR14Missq34ReDVZTR/TqNSJGIqV6N0V
         IlTg==
X-Gm-Message-State: APjAAAXaqvPIKOM760iN+jml45WnoCkeuMHuJGziMxGMTmeAQM71lp9+
        Bj5a/MFLF6twegFMLMaDMo3P3Q==
X-Google-Smtp-Source: APXvYqwQ5KRtge3h27Q7CuYZThlKxZOINC9QNBM1nqB6WCjBSKraJSMAO9cmBplvo4pyJ6XuVQCSSw==
X-Received: by 2002:a0c:e80d:: with SMTP id y13mr824454qvn.234.1573747154370;
        Thu, 14 Nov 2019 07:59:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u187sm2683398qkc.7.2019.11.14.07.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 07:59:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVHWb-0002t5-AY; Thu, 14 Nov 2019 11:59:13 -0400
Date:   Thu, 14 Nov 2019 11:59:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Clear the admin command buffer prior to
 its submission
Message-ID: <20191114155913.GA11028@ziepe.ca>
References: <20191112092608.46964-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112092608.46964-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 12, 2019 at 11:26:08AM +0200, Gal Pressman wrote:
> We cannot rely on the entry memcpy as we only copy the actual size of
> the command, the rest of the bytes must be memset to zero.
> 
> Fixes: 0420e542569b ("RDMA/efa: Implement functions that submit and complete admin commands")
> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This isn't really -rc material since the device will have to be
compatible with these old kernels for quite some time.

Applied to for-next with the better description

Thanks,
Jason
