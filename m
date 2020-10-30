Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281EE2A0564
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 13:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJ3MUW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 08:20:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:51972 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgJ3MUB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 08:20:01 -0400
IronPort-SDR: VdvqhYGDw3pAe8RaPnVe+OTzeOtEfPWqWvnMbAThCp4uc4AqjCmDtk6h6oaF1MrFTStl3BE+dc
 s+w9N3C2X3qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="186403325"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="186403325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 05:20:01 -0700
IronPort-SDR: AAGYOfGaWyPm0BaBIcy7C0IGQEEmEtL1ioyXADbLWz/QZEVzBipGynyUUgSes9i3S9SgxuAmjs
 wGZ/8cJWotAA==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="537048236"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.203.232]) ([10.254.203.232])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 05:19:59 -0700
Subject: Re: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
To:     Jason Gunthorpe <jgg@ziepe.ca>, Parav Pandit <parav@nvidia.com>
Cc:     mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        yanjunz@nvidia.com, bmt@zurich.ibm.com, linux-rdma@vger.kernel.org,
        hch@lst.de, syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
References: <20201030093803.278830-1-parav@nvidia.com>
 <20201030121731.GA36674@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <71c2013a-e9af-470c-9fae-30fc0cf78ee3@cornelisnetworks.com>
Date:   Fri, 30 Oct 2020 08:19:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201030121731.GA36674@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/30/2020 8:17 AM, Jason Gunthorpe wrote:
> On Fri, Oct 30, 2020 at 11:38:03AM +0200, Parav Pandit wrote:
>> @@ -1140,7 +1141,10 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>>   			    rxe->ndev->dev_addr);
>>   	dev->dev.dma_parms = &rxe->dma_parms;
>>   	dma_set_max_seg_size(&dev->dev, UINT_MAX);
>> -	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
>> +	dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
>> +	err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
> 
> Since this mask doesn't actually do anything, what is the reason to
> have the 64/32?

Technically there isn't. We are already dependent on 64bit config 
anyway. Mike M just brought this up in a side bar conversation actually.

-Denny
