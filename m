Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E304492132
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 09:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbiARI2n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 03:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbiARI2n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 03:28:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D99C06173E
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 00:28:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5682CB812A9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 08:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23882C340E4;
        Tue, 18 Jan 2022 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642494520;
        bh=HuUXVJM2lUZTi7Zdqo3CzXwQfVy8efonsgP8cBGrszU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kN64McLtAcxowZXrdinBlJlGBLmAx1wAaf2OeLKPdaabNyVGSoXqJcEOo0L3WGEUC
         EDYH3uHb5vz6yZjXo6RoVdVcC4BPFNcKrbnLz0TWUyR28KuWL9MM/TaQPWQWoE7q0L
         AIkW8jH6RGH6B0cus24gRYNEBMeeA5xJlWDV6NQvO2G8RgOGOPrXfyrv39ZzRr25v8
         4KadaA26gMAcpV8K8oQ9KwsC+jntPC/S4/sUmkPohhvGs2dBUAzK27KhvDmoWC0zco
         xDpbNa3awY9tRrOhCnPQrxJp03pvG56XGABkblRMxn2qvklxSyhVyF+sfpImoMW8V7
         bwH/UNuD5Ewlg==
Date:   Tue, 18 Jan 2022 10:28:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Message-ID: <YeZ6M4z8amVc7ETT@unreal>
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-10-chengyou@linux.alibaba.com>
 <20220117152217.GD8034@ziepe.ca>
 <54485395-089d-acdd-7296-d82c8e950599@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54485395-089d-acdd-7296-d82c8e950599@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 11:29:34AM +0800, Cheng Xu wrote:
> 
> 
> On 1/17/22 11:22 PM, Jason Gunthorpe wrote:
> > On Mon, Jan 17, 2022 at 04:48:26PM +0800, Cheng Xu wrote:
> > > Add the main erdma module and debugfs files. The main module provides
> > > interface to infiniband subsytem, and the debugfs module provides a way
> > > to allow user can get the core status of the device and set the preferred
> > > congestion control algorithm.

<...>

> > 
> > > +static __init int erdma_init_module(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = erdma_cm_init();
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = pci_register_driver(&erdma_pci_driver);
> > > +	if (ret) {
> > > +		pr_err("Couldn't register erdma driver.\n");
> > > +		goto uninit_cm;
> > > +	}
> > > +
> > > +	ret = register_netdevice_notifier(&erdma_netdev_nb);
> > > +	if (ret)
> > > +		goto unregister_driver;
> > 
> > And notifiers should not be registered without devices.
> 
> I'm confused about this. irdma/bnxt_re/siw/rxe register net notifiers in
> their module_init, and get their ibdev structures by function
> 'ib_device_get_by_netdev'. Other drivers (mlx4/mlx5/hns) register notifiers
> with devices.

Let's put siw and RXE aside, they are special. Regarding irdma - it is a
bug and its register notifier logic should be in driver init code. It
will ensure that notifications are received only when the ib device is
ready.

And for the bnxt_re case, I didn't look too closely on why it is written
how it is written.

Thanks
