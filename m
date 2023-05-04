Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730826F6F3B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjEDPjo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjEDPjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 11:39:43 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B324C12
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 08:39:42 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64115eef620so13300433b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 04 May 2023 08:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683214782; x=1685806782;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3KcQWfcEfuU8d7VvNaVbSISjQ65iS19k5Xlvsk0sOI=;
        b=lEqRAJNC8uGVftNP1JuJ5s08E3h8IeLRx2Cdj624H9PDxdK0CaFzNanpp+RT2m+5WH
         2/KzalwtemYAkXv0LHEOoKzBRWknADoSZPn81pK1T/ls/0s8VDeqqAbj7K7wSH35NVyH
         aALfirxo0bJO4XZG44u4+CFMdtU0K6v5LGbgjTtjWh46MBqTtkq5WEBwIsYHRrK6uAGM
         zb5p3f30y/h6Did6aimxe26wv953YodhqaiURTUx9sXzlEspGyadWIhiW26RGPH8hjkG
         HFt5c2CrFbm9dv2/pOUy1ep6JzM8qc3o9TRvE8RZ5K+Ey+JhsMSpn/mbKPqRZWG2wKeG
         XRoQ==
X-Gm-Message-State: AC+VfDwkbG4m1JZqUM7yypEwrWbgOUx1FbHOkJeSOvHeBbfMItQCNrE+
        0RDIV1gqdUla33W4H4aM77c=
X-Google-Smtp-Source: ACHHUZ6YiK4SWw3Hmpkp9xkkSu4AS58STttmsTfABq76o1JKdw+YET1KkR2bjo1A75L6xxKmC3pRjQ==
X-Received: by 2002:a17:903:22cf:b0:1a9:a032:3844 with SMTP id y15-20020a17090322cf00b001a9a0323844mr4594468plg.16.1683214781499;
        Thu, 04 May 2023 08:39:41 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm23734737plk.168.2023.05.04.08.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:39:41 -0700 (PDT)
Message-ID: <4dad4f76-1270-f45a-882d-3b2ecce817e5@acm.org>
Date:   Thu, 4 May 2023 08:39:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: slab-use-after-free in __ib_process_cq
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <d9da387d-b497-5120-5251-0c5d6a4adb71@acm.org>
 <bca0fb81-38ae-f022-1270-70c7e415ac41@grimberg.me>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bca0fb81-38ae-f022-1270-70c7e415ac41@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/4/23 01:32, Sagi Grimberg wrote:
> 
>> Hi,
>>
>> While testing Jens' for-next branch I encountered a use-after-free
>> issue, triggered by test nvmeof-mp/002. This is not the first time I see
>> this issue - I had already observed this several weeks ago but I had not
>> yet had the time to report this.
> 
> That is surprising because this area did not change for quite a while now.
> 
> CCing linux-rdma as well, I'm assuming that this is with rxe?
> Does this happen with siw as well?

Hi Sagi,

This happened with the siw driver. I haven't tried the rxe driver for a while.

The crash addresses correspond to the following source file and line:

(gdb) list *(__ib_process_cq+0x11c)
0x7f7c is in __ib_process_cq (drivers/infiniband/core/cq.c:110).
105                                             budget - completed), wcs)) > 0) {
106                     for (i = 0; i < n; i++) {
107                             struct ib_wc *wc = &wcs[i];
108
109                             if (wc->wr_cqe)
110                                     wc->wr_cqe->done(cq, wc);
111                             else
112                                     WARN_ON_ONCE(wc->status == IB_WC_SUCCESS);
113                     }
114

(gdb) list *(nvme_rdma_create_queue_ib+0x1a7)
0x3d47 is in nvme_rdma_create_queue_ib (drivers/nvme/host/rdma.c:219).
214     {
215             struct nvme_rdma_qe *ring;
216             int i;
217
218             ring = kcalloc(ib_queue_size, sizeof(struct nvme_rdma_qe), GFP_KERNEL);
219             if (!ring)
220                     return NULL;
221
222             /*
223              * Bind the CQEs (post recv buffers) DMA mapping to the RDMA queue

(gdb) list *(nvme_rdma_destroy_queue_ib+0x1b8)
0x2388 is in nvme_rdma_destroy_queue_ib (drivers/nvme/host/rdma.c:358).
353             kfree(ndev);
354     }
355
356     static void nvme_rdma_dev_put(struct nvme_rdma_device *dev)
357     {
358             kref_put(&dev->ref, nvme_rdma_free_dev);
359     }
360
361     static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
362     {

Shouldn't ib_drain_qp() be called before nvme_rdma_destroy_queue_ib() destroys the QP?

Thanks,

Bart.

