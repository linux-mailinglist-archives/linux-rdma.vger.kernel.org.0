Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3662A6BB9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 18:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgKDRcq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 12:32:46 -0500
Received: from ale.deltatee.com ([204.191.154.188]:34674 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbgKDRcp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 12:32:45 -0500
X-Greylist: delayed 1916 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 12:32:45 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N2SOPoHvV67QYSDBorQI+Eny1/8pxEWrPXW/WFBv0+c=; b=jByByxLeD2jWOeF1OeD5LergUb
        x9NqBqY5HMYmItZ7/h0PBJ13GF7wUQesel8515f/oOJYYevRUTj3bJ6ZlQJRROJrQ1Rre53BF6Zw0
        SZajwdv93St9xVJOjqjS8QA4bejzTTfzPm5hDLnLCDpRrhJcOMm9KbBHX0P3Y1f5bH4p6z3l3gHWn
        vZGmN3yHOMegh1PM0boFWFPGH/mvD3jxaUIVYAbeUovIAwr0z0EIStrvKmtoevRtM0B/TLNT7Es5L
        CGznzxe0zDJdNeQusIaUhmUxKps947uNp5WAygFQC2nD/RRJ+4mGe0NqYBroMfDLxs9zmgd4epV8R
        6i+qHfAQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kaM9P-0001Ul-Li; Wed, 04 Nov 2020 10:00:48 -0700
To:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-4-hch@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6396d3e3-c9a6-e86f-ab1c-df3561b6517a@deltatee.com>
Date:   Wed, 4 Nov 2020 10:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104095052.1222754-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, jgg@ziepe.ca, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 3/5] PCI/p2p: remove the DMA_VIRT_OPS hacks
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




On 2020-11-04 2:50 a.m., Christoph Hellwig wrote:
> Now that all users of dma_virt_ops are gone we can remove the workaround
> for it in the PCIe peer to peer code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The two P2PDMA patches look fine to me. Nice to get rid of that hack.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
