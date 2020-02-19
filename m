Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C02971638BF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgBSAwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:52:46 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37852 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBSAwq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:52:46 -0500
Received: by mail-qv1-f68.google.com with SMTP id s6so1027839qvq.4
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KIbsJalc/dC7VRudsS5+r5VYX3krW+vjU/t6wrHSDfE=;
        b=R+cZ/0nvZkyMsdEGX0gFJesMwd4njo27fAdnqf0xURXNVBq3k5INpWU3TavNDZFxsm
         6emS0TmQJKXJfW9ZLdHLdh1ZDQfpkz+mgXclWnFdTl8k/dNW1e5jP2s2iB1Gn8ULcaBW
         J6gzjpRs8un8M3OzqTobXTMd4yJEEEXaBwjqUEDXrqvpc0rxgYEUkk5Lgw/CFMWQk7WC
         uAdL4ihu91+npNHxnXU1EwYlOQsWYExbWNHu2oUMLxj6wlXw2/sUuLoSjQ6RYK6dBFWV
         w2E5SIx0a3amM4Z3HtXTvg2RHcITL9acMLJ/RkvMo9QXyfegErup/xXDbQR6TIHIJC7K
         nj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIbsJalc/dC7VRudsS5+r5VYX3krW+vjU/t6wrHSDfE=;
        b=R3Rw7xDTJRc7D6Dp1PHDWizmd/CrpqwHY9A8cH67cDqHYfYV5LHg/2Ch42Db3GhXSf
         hoOZ1iLr39t4OzvBsWl0lnpUMhsGZiFcYobzQ0Jrj3wwA4JXJGMsHhMZpR/fX59b1CNI
         9Y83Q/zeH6GrFA0Jv6KNO+f7EUWizCXHgVendtMxu60tz6oRB6KakUL1VnupnDBrOLLe
         qQBMj47SjfKINzV+LygAHO3YbqWiPVeRMJIi6C8/VHAy1e4LLsbdJhek57BqfU4UdNNk
         5DeV14rmDfl0by0poNGnK9Gkg+nXtgGfKPtZWlghTuEfdU/pi4Ds3QFWIL5u5cMqd3tK
         aLIg==
X-Gm-Message-State: APjAAAVUhSX00WcEW8cdQREVN6ZFsO8AAprP5teJCSNflBhVPmBQMbuS
        f8NSndmkKRb+Ufa5hMwoEGAe4w==
X-Google-Smtp-Source: APXvYqxwEh9soMRrYkCxsKW1GfBiNqH6eyzJGIKeEPBUz331WtJ+4q+i4PspGABZ8klTvfH0/R1g9w==
X-Received: by 2002:a0c:e408:: with SMTP id o8mr19302183qvl.236.1582073564612;
        Tue, 18 Feb 2020 16:52:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y26sm101416qtc.94.2020.02.18.16.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:52:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4DbX-0006fp-Ss; Tue, 18 Feb 2020 20:52:43 -0400
Date:   Tue, 18 Feb 2020 20:52:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 0/7] RDMA/hns: Refactor qp related code
Message-ID: <20200219005243.GB25540@ziepe.ca>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 05:08:33PM +0800, Weihang Li wrote:
> This series refactor qp related code, including creating, destroying qp and
> so on to make the processs easier to understand and maintain.
> 
> Previous disscussion can be found at:
> https://patchwork.kernel.org/cover/11341265/
> 
> Changes since v1:
> - Reduce the number of prints as Leon suggested.
> - Fix a wrong function name in description of patch 4/7.
>
> Xi Wang (7):
>   RDMA/hns: Optimize qp destroy flow
>   RDMA/hns: Optimize qp context create and destroy flow
>   RDMA/hns: Optimize qp number assign flow
>   RDMA/hns: Optimize qp buffer allocation flow
>   RDMA/hns: Optimize qp param setup flow
>   RDMA/hns: Optimize kernel qp wrid allocation flow
>   RDMA/hns: Optimize qp doorbell allocation flow

These don't apply, please resend.

Jason
