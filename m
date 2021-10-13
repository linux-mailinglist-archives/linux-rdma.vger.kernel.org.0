Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8148242C8C2
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhJMSh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 14:37:27 -0400
Received: from ale.deltatee.com ([204.191.154.188]:46918 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbhJMSh0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 14:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=HeNDgHWk/8ZTSHjpjWzNLsUIY0eWVZy3+9yFS87Uc4c=; b=ky5zsJ7h+Ld5fKmnS3LGc4Byxh
        lhUhXulLLFEn2PBmzNv3daGsQhH2Ng6OSmjY52MzQClmgJteFWzjPY3kFehZq+oZSRJOoiGro8Sim
        R+zm9WYNG2VR5ElCvp1UenmkPNBaje7nHXrxaXKolRQik6WEQTVaxnMjXyYPsRndx2dpxXaekZ+KU
        mxS8dkCovzAWrDfAR8DxqR2s6gXVdB4pzxTd6zLaOWg01M5TywK4X/QM1o2b4xoaryEjFy71BCB9b
        AtWY6cCq7+bD8oDo5SME9GECrWSTymCMDcJfmppDmJCLu4nzJFj9bjh2rzBD1mZUnGCObuhoSFk7d
        sEBoefqA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1maj60-0002uF-2Q; Wed, 13 Oct 2021 12:35:20 -0600
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>
References: <20211013165942.89806-1-logang@deltatee.com>
 <5eec6b1b-726e-b26d-bd82-f03fd5462b8f@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d32f9bc4-78a8-45ab-04e6-69aa6f1952e5@deltatee.com>
Date:   Wed, 13 Oct 2021 12:35:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5eec6b1b-726e-b26d-bd82-f03fd5462b8f@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: dledford@redhat.com, linux-kernel@vger.kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] RDMA/core: Set sgtable nents when using
 ib_dma_virt_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




On 2021-10-13 12:33 p.m., Bart Van Assche wrote:
> On 10/13/21 9:59 AM, Logan Gunthorpe wrote:
>> ib_dma_map_sgtable_attrs() should be mapping the sgls and setting nents
>> but the ib_uses_virt_dma() path falls back to ib_dma_virt_map_sg()
>> which will not set the nents in the sgtable.
>>
>> Check the return value (per the map_sg calling convention) and set
>> sgt->nents appropriately on success.
>>
>> Link:
>> https://lore.kernel.org/all/996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org/T/#u
>>
>> Reported-by: Bart Van Assche <bvanassche@acm.org>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Tested-by: Bart Van Assche <bvanassche@acm.org>
> 
> Does this patch need a "Fixes:" tag?

Right, yeah:

Fixes: 79fbd3e1241c ("RDMA: Use the sg_table directly and remove the
opencoded version from umem")

Logan
