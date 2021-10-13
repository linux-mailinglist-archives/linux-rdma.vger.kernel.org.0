Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C442C5FC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhJMQSH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 12:18:07 -0400
Received: from ale.deltatee.com ([204.191.154.188]:44170 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMQSH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 12:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:References:Cc:To:From:content-disposition;
        bh=H7gXTTACSsAYlvrZKLb7+J0lH4EwmCj9KIdIZlUrczY=; b=Qct5xwqTeFqANNXA+RE+BsVgyD
        a3B0CFDpyxJUafSeWU1qPmGWm6NnuATIxuJV1eF0Yiq+u45bjiMFv9sRrP7qtPVCdhqO4BF2p4kPn
        hQv+dHxUKri2KbTn11d/jvFBP60alUJftKhVLajtX9NU6K9QPV3GnEO57y/fscOvSwhhXKn9GHxzd
        AYzpkXiEVZllSBioVFsWxg749JA/Wp4beGx4xCyjxH8h0AC8hQECF5YuOeV5U4P7mXorwQtIB5NKj
        22r1urnrzEdff55mDYOdiyt+Of3tldfD5jKcC8KXQ1K7dEhsLqaP9JcPjbxhH/1VO+zW/s3OWhrYg
        +XR1ZKWw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1magvA-0000Qe-Th; Wed, 13 Oct 2021 10:16:01 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org>
 <2b07fbf9-36b4-37ea-b203-7d0a2fc6589a@deltatee.com>
 <a9d05dea-860f-fe77-fc41-19208d76d9c1@acm.org>
Message-ID: <6ff6b13c-d5c8-eec1-6949-5aabf28a5e68@deltatee.com>
Date:   Wed, 13 Oct 2021 10:15:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a9d05dea-860f-fe77-fc41-19208d76d9c1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@nvidia.com, linux-rdma@vger.kernel.org, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: Kernel warning at drivers/infiniband/core/rw.c:349
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021-10-12 11:34 p.m., Bart Van Assche wrote:
> On 10/12/21 17:30, Logan Gunthorpe wrote:
>> Best I can see from the code is that someone is passing an sg_cnt of
>> zero. Previously that would have returned -ENOMEM, but now it might be
>> ignored, in which case it would hit that WARNING and return -EIO.
> 
> That is not what is happening. The debug patch shown below learned me
> the following:
> * The sg_cnt argument of rdma_rw_ctx_init() is not zero.
> * After the rdma_rw_map_sgtable() call, sgt.nents is zero.
> 
> The debug patch that I used is as follows:

Ah, hmm. Perhaps it's this... The virt path in
ib_dma_map_sgtable_attrs() doesn't set the sgt.nents...

Maybe try this something like the patch below.

Thanks,

Logan

--


diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4b50d9a3018a..4ba642fc8a19 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4097,8 +4097,13 @@ static inline int ib_dma_map_sgtable_attrs(struct ib_dev>
                                           enum dma_data_direction direction,
                                           unsigned long dma_attrs)
 {
+       int nents;
+
        if (ib_uses_virt_dma(dev)) {
-               ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+               nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+               if (!nents)
+                       return -EIO;
+               sgt->nents = nents;
                return 0;
        }
        return dma_map_sgtable(dev->dma_device, sgt, direction, dma_attrs);
