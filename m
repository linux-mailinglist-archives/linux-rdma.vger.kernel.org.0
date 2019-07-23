Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE73715DF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfGWKRs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 06:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbfGWKRs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 06:17:48 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C457223BE;
        Tue, 23 Jul 2019 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563877067;
        bh=Cn3zFs3q/TxQ1hBkm93M05z6gIutVIAolwxemh1yN58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc0fL8QxSGe9Wh+WJOjXv9TzrmOFB2ecIEW3XsfxmENSOCdcl8Ufg7CzVM3rom5kP
         2ODtoMMEJ72zIOmoi/0uUjsGrg/7oib1yGnOloIilXc8upz/QqZG99Km/2nmThCa8L
         TK9HkSJN+hIL/3ipoFE03upe3Gb9uNoIx6NvRJl0=
Date:   Tue, 23 Jul 2019 13:17:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix build error for hip08
Message-ID: <20190723101744.GL5125@mtr-leonro.mtl.com>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190723074339.GJ5125@mtr-leonro.mtl.com>
 <dd405aec-17ca-4ac4-9620-f28f7758022c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd405aec-17ca-4ac4-9620-f28f7758022c@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 23, 2019 at 06:06:22PM +0800, Yuehaibing wrote:
>
> On 2019/7/23 15:43, Leon Romanovsky wrote:
> > On Tue, Jul 23, 2019 at 10:49:08AM +0800, YueHaibing wrote:
> >> If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
> >> but INFINIBAND_HNS is y, building fails:
> >>
> >> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
> >> hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
> >> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
> >> hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
> >
> > It means that you have a problem with header files of your hns3.
>
> hnae3_unregister_client is a EXPORT_SYMBOL. If INFINIBAND_HNS is y,
> hns-roce-hw-v2 will be built-in, but as HNS3 is set to m, linking will failed.

One of the possible solution is to add "select" identifier to your
Kconfig, it will ensure that HNS3 will be set to "y" too.

Thanks
