Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7999D166376
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 17:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBTQu1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 11:50:27 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42306 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgBTQu1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Feb 2020 11:50:27 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1j4p1q-00023y-GE; Thu, 20 Feb 2020 09:50:26 -0700
To:     Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     israelr@mellanox.com
References: <20200220100819.41860-1-maxg@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <db0bdc10-987a-692c-1cc9-d86331f567a8@deltatee.com>
Date:   Thu, 20 Feb 2020 09:50:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220100819.41860-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: israelr@mellanox.com, linux-rdma@vger.kernel.org, leon@kernel.org, jgg@mellanox.com, maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 1/2] RDMA/rw: fix error flow during RDMA context
 initialization
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020-02-20 3:08 a.m., Max Gurtovoy wrote:
> In case the SGL was mapped for P2P DMA operation, we must unmap it using
> pci_p2pdma_unmap_sg.
> 
> Fixes: 7f73eac3a713 ("PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()")
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
