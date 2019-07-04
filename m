Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0075FC37
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGDRGH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 13:06:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39227 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfGDRGH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 13:06:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so5994476qkd.6
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UifOoywrOBikTxi8Zgh2CD0+jwBF7H5mmPi4dhlYD30=;
        b=UWLL63Kc7I4QKWSRW3yE6/enA8NwXldiS39lYLFh1+wksgAuGJuxJgtcTtfvE7P2kM
         0hGPil5DalneKlzJ9Mt2CcTkyJjAgHVG+EiFoG6IqOJIVHlSDKcD40L6BOZONF3FUted
         muLOtqufLRstr0fmEmPrLqhuCYSyL/DczxXGyQiiw/LwJV8kvCEZ1b1wNG1QuerbjCNa
         fC17dZsZT5TJDFXIil3ZtBTp3JSjc+6pCLcpa1xQBtyAyPRV9VXuHIqk2zCSgdQwsGNv
         KMLoxW9KHEc0/aTpmPqrP7UeqCbHooOs4WHf2S8rcgZHn7vfIdZZBUaqrsYMClrBuaBd
         LoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UifOoywrOBikTxi8Zgh2CD0+jwBF7H5mmPi4dhlYD30=;
        b=Lq9yAXCeqJ4WZNSx3hRALfdfRqgcmm44MP5BCL0YPFdJDsd0MxnyxlDyFN2DjiKr6F
         F4aVGQcXGJ7E9jhqR+U17Iv5upOYqQJtt78kIYq5to4eh8Ewv1lkCZXMmHz52Ifn/JPw
         I73u3Lv2BP02RM0yMxigr3QexeHN1bxR9ZWguDqJorzcX0JmeJ+HJIF3R1e9mwgS1JWr
         hPyBvOi/g0MmnLdOP4Vz5tcig5JGoSOkLmSa4hJfqII/WomufyYo9ofPyUz4cKHKCk/H
         J1PuITqcWbQpxn5pLoOz2fWRliqYEESo5tPuAT8l6FkfHAf49PC85IghMBcJAeakl9rP
         t6uQ==
X-Gm-Message-State: APjAAAXarQpdbYfovhVBpz4c9w6KvcnLMsAccVYIjAl21LDOlNOLBmlK
        jw9QDqLHQaK6jn+Zv5vdAr0QhA==
X-Google-Smtp-Source: APXvYqxp+grW0Vi6Vj/OD2ccylh8ks7E512n360JEtZx/JbONVQq6AneZWXuyD032pN+aaG/1LLoCg==
X-Received: by 2002:a05:620a:13ad:: with SMTP id m13mr7528182qki.469.1562259966535;
        Thu, 04 Jul 2019 10:06:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y42sm3859070qtc.66.2019.07.04.10.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 10:06:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj5BN-0002tu-Dl; Thu, 04 Jul 2019 14:06:05 -0300
Date:   Thu, 4 Jul 2019 14:06:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Bugfix for hns Makefile
Message-ID: <20190704170605.GA11126@ziepe.ca>
References: <1562221378-73312-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562221378-73312-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 04, 2019 at 02:22:58PM +0800, Lijun Ou wrote:
> Here has a bug for hns Makefile and will lead to a build error
> when use allmodconfig to build hns driver.
> 
> The build log as follows:
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_ah.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_alloc.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_cmd.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_cq.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_db.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_hem.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_mr.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_pd.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_qp.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_restrack.o
> see include/linux/module.h for more information
> WARNING: modpost: missing MODULE_LICENSE() in drivers/infiniband/hw/hns/hns_roce_srq.o
> see include/linux/module.h for more information
> ERROR: "hns_roce_bitmap_cleanup" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_bitmap_init" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_free_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_alloc_cmd_mailbox" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_table_get" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_bitmap_alloc" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> ERROR: "hns_roce_table_find" [drivers/infiniband/hw/hns/hns_roce_srq.ko] undefined!
> 
> Fixes: e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
