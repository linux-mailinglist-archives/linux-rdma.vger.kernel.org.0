Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9345A27D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF1Re4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 13:34:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41015 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1Re4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jun 2019 13:34:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so1409324pgj.8
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jun 2019 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MxClFmZqGHYMZo1wpk4HrILW8DCg+lV7A5S0giwMta8=;
        b=nXcBcM3FO38SdwemIt/SQqC2lYTDceSoXAsUHaX+2WDEsLBZBT14Wxan7Su2eYl1cl
         1fHneCULP9IsYiOhGrbDkBrcrLtRuJK04maZHY6lircyMKh1nULYWHc3axtsocI8Dy7k
         +tPGkO1PCDDaYWkzylZHsGMj7LZIpQfuyhAAMDRsO9VrLLBgEWhuqVbrMPOLsMWoJAIp
         vSAmQ+ojzxBiCr05xT6dFFsTslaltwmfvQp+n/Dg0Qt/fd02T59Z52P/DOi6uC7+uikq
         IEZU9607yYcwmNu5ZQ+AQDrvePYEPrp46lDag7CfgkfOOgcR2TOwoKvDKAPhFvJMyLcp
         rb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MxClFmZqGHYMZo1wpk4HrILW8DCg+lV7A5S0giwMta8=;
        b=Z81autC6KEosbrGAJMLfT+k6KDf4lwu2OImSKNzjV1CkrbWlvyOuNdFAhg330J1lvp
         vn2PtMeufxWA0HxQXoqD25O1h86prsR8t+ZePznPqYgYxpc3PA2cwrIjSeiA0iPRk8Sw
         Gb325k9b9PtPzTfRvZ8Mib7jGBRo3ppbyYo7JkAKyJrueS/Tp9xW8tSQf8TGX/RA6QQA
         YITGG/1uV9E16Tpq8R6thkUDKRKEX4MZPX+P53b4n48Whtf2DCDwtapxJ94lS5AjiWDj
         YXtdfCjJNzD8o9KYai2NCs880onsbYc9LADJ0rGGJvvs7UgEc3kU7xq7DixCZFZaBzZa
         aEdg==
X-Gm-Message-State: APjAAAVy/dHK7aUa6Omhe5Baog4NrIrnBD++JVHGL3SqxgxHrM4USaWG
        LL+YXRO+j3mPgUUhoF1YllytRL9aoMzmqg==
X-Google-Smtp-Source: APXvYqyo5KVyItiQnplbOobI0uPPkbNsefK95/Vlyse6SCe0lhF1vY33x39bWh1DUePgfO1iHdmMKQ==
X-Received: by 2002:a63:1303:: with SMTP id i3mr10440957pgl.202.1561743295734;
        Fri, 28 Jun 2019 10:34:55 -0700 (PDT)
Received: from ziepe.ca ([76.14.1.154])
        by smtp.gmail.com with ESMTPSA id e11sm5116198pfm.35.2019.06.28.10.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 10:34:55 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hguly-00018Z-Nz; Fri, 28 Jun 2019 14:34:54 -0300
Date:   Fri, 28 Jun 2019 14:34:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     oulijun <oulijun@huawei.com>
Cc:     shiraz.saleem@intel.com, linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [BUGReport for rdma in kernel5.2-rc4]
Message-ID: <20190628173454.GB3877@ziepe.ca>
References: <eaa1f156-c9df-f2f6-3c23-f2c1b23e484c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa1f156-c9df-f2f6-3c23-f2c1b23e484c@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 29, 2019 at 12:07:52AM +0800, oulijun wrote:
> 
> Hi Shiraz & Jason,
> 
> We have observed a crash when run perftest on a hisilicon arm64 platform in kernel-5.2-rc4.
> 
> We also tested with different kernel version and found it started from the the following commit:
>    d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")
> 
> Could you please share any hint how to resolve this kind issue?
> Thanks!

No guess.. Why didn't you include the stack backtrace?

Jason
