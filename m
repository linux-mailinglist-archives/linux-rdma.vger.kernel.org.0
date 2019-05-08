Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9F1800D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 20:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfEHSuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 14:50:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHSuG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 14:50:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id w25so4001189qkj.11
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wqdBLUScicrf2WiIbhzgFAHBcEsMci2Wy86enpCzLmE=;
        b=T0DZoCifhl8eTvB6l7Go2uzTg32XePhf0HIzv/h+uLA6jpTbQNuLBoivD4gyT4Sdpw
         3n3GMAwdmDq+6MhVRYumizk9rzHSjI+/BpKXQq9+ZQoD5fWGWzcQB9Aj/MVtwe/ZE9gZ
         ERPr1TZw4MOrmFawla6rqs6wCtlNPKN2iazPAE2tOwWhPm9Y2CsehBfGL76dR8Oju+VF
         3lOnNmHuhTNDatjRQ+8lFuMrrU4ZBLzM14iJ8nXn/el416wKHJcH5IYbtwkRKI6cbtLd
         c1uG4G3+8N/i2mLipsjgyVF71idHuJELkWBed/QDwajRcMHFA8USPiy+OHLe75rxpWWq
         XAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wqdBLUScicrf2WiIbhzgFAHBcEsMci2Wy86enpCzLmE=;
        b=asCfcsos+8q0knuaeE4XeTMbGcpob6ntxpdXrtDze6agB5xeLl+LIMBV6QMUotH3lK
         mc/Zt8ctqLRglNrE+sFRpfj0Ob0TWhvTK5ZDdzi56Oosj7SiQncS9A0E4SIC5/VNwErh
         aQS5LTb0S/bXeVeOh4ZY9GEWa0spH2YI53fUkbzV8io2ci6jPPoXZqGfiF1wEkfRtuJh
         QXNFsLZVBApAau3mfGG0iCqofWog/k3ffNs66NEpqoXryDIivECqRZ2roh4U57ExmUz1
         f6gfxkuNKgPT6bMqzBqQ0y6y4yO7iSIrVt4nNSRYbHIC0sjljLn45CsnKFcthvkOJ/jb
         /iCg==
X-Gm-Message-State: APjAAAX7JDeNrQbc9AZhkbgTjT1DSWkgq3lmORP0AmHzo4eNGnKvLS/Q
        UKA+91tmjG3yRucAHU8/guwKyA==
X-Google-Smtp-Source: APXvYqxH8fpGoTs0lybE0LRipwiD4kHLrTGg34vl/9mvg7kW8p4q1j7Fs0+Zt+6ivFZ3chmgLtNoTw==
X-Received: by 2002:a37:27c1:: with SMTP id n184mr14357142qkn.92.1557341405765;
        Wed, 08 May 2019 11:50:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id s42sm11809403qth.45.2019.05.08.11.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 11:50:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hORdj-0006kX-SQ; Wed, 08 May 2019 15:50:03 -0300
Date:   Wed, 8 May 2019 15:50:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/6] RDMA/umem: Add API to find best driver
 supported page size in an MR
Message-ID: <20190508185003.GF32282@ziepe.ca>
References: <20190219145745.13476-1-shiraz.saleem@intel.com>
 <20190219145745.13476-3-shiraz.saleem@intel.com>
 <38b551a5-4177-efba-9fc0-d49dd9054615@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b551a5-4177-efba-9fc0-d49dd9054615@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 04, 2019 at 11:36:35AM +0300, Gal Pressman wrote:
> On 19-Feb-19 16:57, Shiraz Saleem wrote:
> > This helper iterates through the SG list to find the best page size to use
> > from a bitmap of HW supported page sizes. Drivers that support multiple
> > page sizes, but not mixed pages in an MR can use this API.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> I've tested this patch comparing our existing efa_cont_pages() implementation vs
> ib_umem_find_single_pg_size() running different test suites:

This stuff has been merged, so please send a patch for EFA to use it
now..

Thanks,
Jason
