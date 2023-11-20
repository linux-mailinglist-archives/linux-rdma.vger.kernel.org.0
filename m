Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC6C7F0AC2
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 03:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjKTC7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Nov 2023 21:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjKTC7f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Nov 2023 21:59:35 -0500
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C0FF137;
        Sun, 19 Nov 2023 18:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=XcvIGtN6nX/Nx5R7ZUzb0OIeH7g/s1UqDwtuzWn3VlU=;
        b=M+psgWq2qtitdVURJsKgoNvz/exTG+6dFxyOXlaH3I78nVdZYQ/YiMSuVW9nRP
        oPDFyiL4wqWlbzsCzSygVvxBPccdW82DTHKvgP9cW4AS9k86fte7jh1hh7+a0Q1j
        LFWwK9InEX51akYT5tGTONH6YbKlD31GLkjjnKYJJTUsc=
Received: from [172.23.69.7] (unknown [121.32.254.146])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wDHbDtIy1plewx2Cw--.20084S2;
        Mon, 20 Nov 2023 10:58:17 +0800 (CST)
Message-ID: <4ac9c810-bb0b-4f46-8fec-d0a80b6ce3f6@126.com>
Date:   Mon, 20 Nov 2023 10:58:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinghui@sangfor.com.cn
References: <20231117065043.3822-1-lishifeng1992@126.com>
 <20231119131302.GB15293@unreal>
From:   ShifengLi <lishifeng1992@126.com>
In-Reply-To: <20231119131302.GB15293@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHbDtIy1plewx2Cw--.20084S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF43Ww17Zr17XFW5GFy3Arb_yoW8uF13p3
        W3G34UXrn7Aw1Ig3ya93WUtFyDGFs8AF1qva4fAr1fCrW7Za4fZw42kr4j9ay5ua4xKr17
        JFyjgr1xur45Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdHUgUUUUU=
X-Originating-IP: [121.32.254.146]
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1S2mtgour1pD4PG+IgAAsp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/11/19 21:13, Leon Romanovsky 写道:
> On Thu, Nov 16, 2023 at 10:50:43PM -0800, Shifeng Li wrote:
>> When removing the irdma driver or unplugging its aux device, the ccq
>> queue is released before destorying the cqp_cmpl_wq queue.
>> But in the window, there may still be completion events for wqes. That
>> will cause a UAF in irdma_sc_ccq_get_cqe_info().
>>
>> [34693.333191] BUG: KASAN: use-after-free in irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
>> [34693.333194] Read of size 8 at addr ffff889097f80818 by task kworker/u67:1/26327
>> [34693.333194]
>> [34693.333199] CPU: 9 PID: 26327 Comm: kworker/u67:1 Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
>> [34693.333200] Hardware name: SANGFOR Inspur/NULL, BIOS 4.1.13 08/01/2016
>> [34693.333211] Workqueue: cqp_cmpl_wq cqp_compl_worker [irdma]
>> [34693.333213] Call Trace:
>> [34693.333220]  dump_stack+0x71/0xab
>> [34693.333226]  print_address_description+0x6b/0x290
>> [34693.333238]  ? irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
>> [34693.333240]  kasan_report+0x14a/0x2b0
>> [34693.333251]  irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
>> [34693.333264]  ? irdma_free_cqp_request+0x151/0x1e0 [irdma]
>> [34693.333274]  irdma_cqp_ce_handler+0x1fb/0x3b0 [irdma]
>> [34693.333285]  ? irdma_ctrl_init_hw+0x2c20/0x2c20 [irdma]
>> [34693.333290]  ? __schedule+0x836/0x1570
>> [34693.333293]  ? strscpy+0x83/0x180
>> [34693.333296]  process_one_work+0x56a/0x11f0
>> [34693.333298]  worker_thread+0x8f/0xf40
>> [34693.333301]  ? __kthread_parkme+0x78/0xf0
>> [34693.333303]  ? rescuer_thread+0xc50/0xc50
>> [34693.333305]  kthread+0x2a0/0x390
>> [34693.333308]  ? kthread_destroy_worker+0x90/0x90
>> [34693.333310]  ret_from_fork+0x1f/0x40
>>
>> Signed-off-by: Shifeng Li <lishifeng1992@126.com>
>> ---
>>   drivers/infiniband/hw/irdma/hw.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Please add Fixes line and resubmit together with Shiraz's Acked-by,
>

I have sent the v2 patch，

Thanks

> Thanks

