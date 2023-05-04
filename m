Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49866F6F59
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjEDPqW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjEDPqU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 11:46:20 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094B49D6
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 08:45:58 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f3284dfe34so1172245e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 May 2023 08:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215157; x=1685807157;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqTWUp53+bRwfsmTGL4xwInFrL3h6w2jQiIVDgqqklA=;
        b=KhrCLkBGE7aFsM0FXuJsIXmU8oixyxNZXgH2ctTj+vO0P7HMMVp+JJ+PTsfDgM8CQj
         hBM6r9bEkXQyB6npNVIaX9S67SEgRfGdhj0uL4iNDo9o2rJD4C1Qh+BJdedZDW0SDByX
         GtZuRtVkEQdGDtzznYcxYCV63qfh2aFatxXEbC6uZ+IdPOaTv3Io4IylyeMDI8kaXvRp
         8ptMnqYd2N14xPMGb/I5loGxO3PhuIo0uznYJ27SDCNUSyjih8LFxZstADsGPp8HitJJ
         5Q1OzQzAaXcc8UTV+WsvkY+d7rdqRyVK83CiJ3xSeKOGa0CTwZtPhkgxfe6jR9r+Wdh5
         OvuQ==
X-Gm-Message-State: AC+VfDwtV2Pzb8LTg4OeJ9nDlpsIxQ3OqXXPcJHga80Z9wZSaAI5DSlw
        SME22GFC07RADb5LRCrwPn8=
X-Google-Smtp-Source: ACHHUZ5e+6xHqDTlmzpHX/TcLSHUd0LqfFEv/PsmXmD9Rf8Dnjko/R/o+8C7B3leT2+ElWoNDnwFBw==
X-Received: by 2002:a05:600c:4591:b0:3f1:7490:e58e with SMTP id r17-20020a05600c459100b003f17490e58emr7731122wmo.2.1683215157034;
        Thu, 04 May 2023 08:45:57 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c290100b003edf2dc7ca3sm5267525wmd.34.2023.05.04.08.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:45:56 -0700 (PDT)
Message-ID: <fb7aa5b2-cfe8-b3c8-fec7-228f0f56cda1@grimberg.me>
Date:   Thu, 4 May 2023 18:45:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: slab-use-after-free in __ib_process_cq
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <d9da387d-b497-5120-5251-0c5d6a4adb71@acm.org>
 <bca0fb81-38ae-f022-1270-70c7e415ac41@grimberg.me>
 <4dad4f76-1270-f45a-882d-3b2ecce817e5@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4dad4f76-1270-f45a-882d-3b2ecce817e5@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>>> Hi,
>>>
>>> While testing Jens' for-next branch I encountered a use-after-free
>>> issue, triggered by test nvmeof-mp/002. This is not the first time I see
>>> this issue - I had already observed this several weeks ago but I had not
>>> yet had the time to report this.
>>
>> That is surprising because this area did not change for quite a while 
>> now.
>>
>> CCing linux-rdma as well, I'm assuming that this is with rxe?
>> Does this happen with siw as well?
> 
> Hi Sagi,
> 
> This happened with the siw driver. I haven't tried the rxe driver for a 
> while.
> 
> The crash addresses correspond to the following source file and line:
> 
> (gdb) list *(__ib_process_cq+0x11c)
> 0x7f7c is in __ib_process_cq (drivers/infiniband/core/cq.c:110).
> 105                                             budget - completed), 
> wcs)) > 0) {
> 106                     for (i = 0; i < n; i++) {
> 107                             struct ib_wc *wc = &wcs[i];
> 108
> 109                             if (wc->wr_cqe)
> 110                                     wc->wr_cqe->done(cq, wc);
> 111                             else
> 112                                     WARN_ON_ONCE(wc->status == 
> IB_WC_SUCCESS);
> 113                     }
> 114
> 
> (gdb) list *(nvme_rdma_create_queue_ib+0x1a7)
> 0x3d47 is in nvme_rdma_create_queue_ib (drivers/nvme/host/rdma.c:219).
> 214     {
> 215             struct nvme_rdma_qe *ring;
> 216             int i;
> 217
> 218             ring = kcalloc(ib_queue_size, sizeof(struct 
> nvme_rdma_qe), GFP_KERNEL);
> 219             if (!ring)
> 220                     return NULL;
> 221
> 222             /*
> 223              * Bind the CQEs (post recv buffers) DMA mapping to the 
> RDMA queue
> 
> (gdb) list *(nvme_rdma_destroy_queue_ib+0x1b8)
> 0x2388 is in nvme_rdma_destroy_queue_ib (drivers/nvme/host/rdma.c:358).
> 353             kfree(ndev);
> 354     }
> 355
> 356     static void nvme_rdma_dev_put(struct nvme_rdma_device *dev)
> 357     {
> 358             kref_put(&dev->ref, nvme_rdma_free_dev);
> 359     }
> 360
> 361     static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
> 362     {
> 
> Shouldn't ib_drain_qp() be called before nvme_rdma_destroy_queue_ib() 
> destroys the QP?

Yes it absolutely should, and it is according to the code.
The only way that this can happen is something happens to
post a wr after the drain started, can't see how this happens though...
