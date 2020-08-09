Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E523FD48
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHIIKu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 04:10:50 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:44738 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgHIIKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 04:10:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5FE701800028E;
        Sun,  9 Aug 2020 08:10:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:4605:5007:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12295:12296:12297:12438:12740:12760:12895:13019:13069:13161:13229:13311:13357:13439:14659:14721:21080:21433:21627:21990:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tin89_2a09b8826fd0
X-Filterd-Recvd-Size: 2260
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Aug 2020 08:10:47 +0000 (UTC)
Message-ID: <91159e176c090f2d7ada6957af342c4b6d787973.camel@perches.com>
Subject: Re: [PATCH 5/4] RDMA/efa : Remove pci-dma-compat wrapper APIs
From:   Joe Perches <joe@perches.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>, dledford@redhat.com,
        jgg@ziepe.ca, galpress@amazon.com, sleybo@amazon.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sun, 09 Aug 2020 01:10:46 -0700
In-Reply-To: <20200809074517.GA4419@blackclown>
References: <cover.1596957073.git.usuraj35@gmail.com>
         <20200809074517.GA4419@blackclown>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 2020-08-09 at 13:15 +0530, Suraj Upadhyay wrote:
> The legacy API wrappers in include/linux/pci-dma-compat.h
> should go away as it creates unnecessary midlayering
> for include/linux/dma-mapping.h APIs.
> 
> Instead use dma-mapping.h APIs directly.
> 
> The patch has been generated with the coccinelle script below
> and compile-tested.
[]
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
[]
> @@ -405,13 +405,13 @@ static int efa_device_init(struct efa_com_dev *edev, struct pci_dev *pdev)
>                 return err;
>         }
> 
> -       err = pci_set_dma_mask(pdev, DMA_BIT_MASK(dma_width));
> +       err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(dma_width));
>         if (err) {
>                 dev_err(&pdev->dev, "pci_set_dma_mask failed %d\n", err);

Coccinelle is great for some things, but not
necessarily for these sorts of changes in an
completely automated way.

The dev_err messages also need to be changed
as the format string contains the old name.

> -       err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(dma_width));
> +       err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(dma_width));
>         if (err) {
>                 dev_err(&pdev->dev,
>                         "err_pci_set_consistent_dma_mask failed %d\n",



