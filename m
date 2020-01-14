Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1964C13AB18
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANN3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 08:29:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38427 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgANN3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 08:29:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id c24so1623377qtp.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2020 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4HRC8gLUY1u4z9zqslXyK60RGb4CWNArqKoHkqciTRY=;
        b=jJVDXvfdZHtFtfd7rhbh5KnYfNO7uF6EGN9b70tVuh57Gpd0uiNPKmXhKG09YZHfKt
         PnSiF4jrVU4jFOBsoQ1NChWEKFvTEneAc8k693l5uWLMASNnr0sujidQenvN0+TBgcdA
         bU9Way+xZpyuvIgIG5zY887TQ1HE8PGlxZk6qb5PWcJcQJ4KyggJch9AQ4/xeofbYoH/
         Kju3kMeyO/EXSjMOB0YsP3Q0aVLcEuiFsgu+F8l23ddvMkzQKpPAkG8niHztD8oHK8Xk
         PeWOD9jSinPKVGebI2dkZOpn4eZ/pB+A80x/U7Ml59b1huS6kIKH0dgtsYwiXxPqKLJj
         C6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4HRC8gLUY1u4z9zqslXyK60RGb4CWNArqKoHkqciTRY=;
        b=FzTp9spZm1WRlCK2rIjAMZcQptWWDKza2NjZIOm/ORCZtY1nDfssZucqFj3cZ8XagQ
         i48QOrt8I+JRRSW1qgQryzP7uyxdw+PK1u+J4Py2RRTVHCslK/5954u5/YQ+klWrbNEe
         a3klHleCHy0ECLRKqRGMeCMcjIL4DIDN4WnJ0Uwb6tRvSSxuCTKbS203AeHcKRnYzGbR
         cCPVjpx13BrseyUC+zxp6rC6W61RXPlZwh2ECbk/3U4JOxcnqrzgino5n1JrsDSTBhL5
         uTKRogkI/uMPNWTY/uaYltFdAKp9PkcbH2KD21eH7cjI4XtZSL/JM40+y+N9OIvOqn3x
         jIgw==
X-Gm-Message-State: APjAAAXhWtBhs1YHkXyQowPjAQdbihP15dY3RJcnm3O49tutEp/4AbKw
        KvXVF7YwL7Phn66SyBxwNJlpL6EHZfM=
X-Google-Smtp-Source: APXvYqxQ51+mjttIVwscBDv+Ge1fFMm+LwbVMQEth2N1V7iYLY8z8GdhqfjH3Dub2RYTToMC4NsYZw==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr3446185qtq.371.1579008574311;
        Tue, 14 Jan 2020 05:29:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c3sm6641986qkk.8.2020.01.14.05.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 05:29:32 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irMGB-0006gh-7E; Tue, 14 Jan 2020 09:29:31 -0400
Date:   Tue, 14 Jan 2020 09:29:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     Weihang Li <liweihang@hisilicon.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic
Message-ID: <20200114132931.GA22037@ziepe.ca>
References: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
 <20200102210351.GA398@ziepe.ca>
 <2b8eb4ac-ef0c-7c7f-270f-8d3768f7c2a7@huawei.com>
 <20200103133907.GB9706@ziepe.ca>
 <05e78494-20fc-b551-9a5b-2eb577206286@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e78494-20fc-b551-9a5b-2eb577206286@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 14, 2020 at 09:53:07AM +0800, Weihang Li wrote:
> Thanks for your reminder about extended atomic in kernel and sorry for the
> delayed response.
> 
> We cancel this patch as your suggestion, and will send another one which
> the user space extended atomic is dependent on.

You should not have allowed your userspace to be merged until any
required kernel pieces were merged.

Jason
