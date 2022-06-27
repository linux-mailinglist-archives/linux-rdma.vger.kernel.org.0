Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E147D55D52E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiF0R27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiF0R26 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 13:28:58 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716C16153;
        Mon, 27 Jun 2022 10:28:57 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 68so9707096pgb.10;
        Mon, 27 Jun 2022 10:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GCe8dYs3qyfG+6hCRBmQjpP5YjPA1MEQa4RIJE0UUV0=;
        b=n9/SA6Et33eyMvBHLSOkBBCR1OHHWYSFYrhbG0qeDTB0eh5ftWpABQylk2yo7gYWnr
         Wnkt/i1URsPFDF9VMcSPNgJEqs9tnUiAoVHaer7X/6+EMl7boiKLI5RjXL/wJzIhPsH5
         KUvmWxZ/ikqd7Nse8HYGYzYkoT7qzyLlMdK5Tbp97GJvTNQfPmui3adACFThgTkzRt3L
         rcTBK7w09tARdqVmwbErfYmKKaARMk5uOxqffkadqvcDNNM5mrnZv75PgBjZkGOuuXWL
         +f3rjCy1l38r2l3o7FXSyAFXYa4c1o3jgO6cXbBFJODzz81P+yvZtxQCnFJ7EpwvHoHu
         hhUA==
X-Gm-Message-State: AJIora+wGOEK/7D5h/vw8gaG2dc42NzGjvrX0xTxDEEBUEyP9DsgxKo8
        2EnUCrnfLxDQi5wJio+O2skelLKeKhM=
X-Google-Smtp-Source: AGRyM1ue2KgBSpYowCDFMcP80gDl2bF3dTK6jFzNlwjerLg0Vr5QCY1h0OzL/V646IHxgVTqzDYFZQ==
X-Received: by 2002:a63:745b:0:b0:40c:cabe:961b with SMTP id e27-20020a63745b000000b0040ccabe961bmr14075770pgn.117.1656350936853;
        Mon, 27 Jun 2022 10:28:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebc3:3a94:fe74:44f0? ([2620:15c:211:201:ebc3:3a94:fe74:44f0])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902bcc600b0016a61e7f30dsm7473343pls.281.2022.06.27.10.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 10:28:56 -0700 (PDT)
Message-ID: <41517c0e-acde-25ce-b4d0-7a32499009f3@acm.org>
Date:   Mon, 27 Jun 2022 10:28:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Content-Language: en-US
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
 <20220624225908.GA303931@nvidia.com>
 <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
 <20220624234757.GD4147@nvidia.com>
 <343aa894-796f-181e-1691-15cb8659ab06@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <343aa894-796f-181e-1691-15cb8659ab06@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/26/22 23:47, lizhijian@fujitsu.com wrote:
> On 25/06/2022 07:47, Jason Gunthorpe wrote:
>> On Fri, Jun 24, 2022 at 04:26:06PM -0700, Bart Van Assche wrote:
>>> On 6/24/22 15:59, Jason Gunthorpe wrote:
>>>> I don't even understand how get_device() prevents this call chain??
>>>>
>>>> It looks to me like the problem is srp_remove_one() is not waiting for
>>>> or canceling some outstanding work.
>>> Hi Jason,
>>>
>>> My conclusions from the call traces in Li's email are as follows:
>>> * scsi_host_dev_release() can get called after srp_remove_one().
>>> * srp_exit_cmd_priv() uses the ib_device pointer. If srp_remove_one() is
>>> called before srp_exit_cmd_priv() then a use-after-free is triggered.
>> Shouldn't srp_remove_one() wait for the scsi_host_dev to complete
>> destruction? Clearly it cannot continue to exist once the IB device
>> has been removed
> Yes, that match my first thought, but i didn't know the exact way to notify scsi side to destroy
> itself but scsi_host_put() which already called once in below chains:
> 
> srp_remove_one()
>    -> srp_queue_remove_work()
>       -> srp_remove_target()
>          -> scsi_remove_host()
>          -> scsi_host_put()
> 
> that means scsi_host_dev is still referenced by other components that we have to notify.

How about the patch below (should be sent to the SCSI maintainer)?


Subject: [PATCH] scsi: core: Call blk_mq_free_tag_set() earlier

scsi_mq_exit_request() is called by blk_mq_free_tag_set(). Since
scsi_mq_exit_request() implementations may need resources that are freed
after scsi_remove_host() has been called and before the host reference
count drops to zero, call blk_mq_free_tag_set() before the host
reference count drops to zero. blk_mq_free_tag_set() can be called
immediately after scsi_forget_host() has returned since scsi_forget_host()
drains all the request queues that use the host tag set.

This patch fixes the following use-after-free:

==================================================================
BUG: KASAN: use-after-free in srp_exit_cmd_priv+0x27/0xd0 [ib_srp]
Read of size 8 at addr ffff888100337000 by task multipathd/16727

CPU: 0 PID: 16727 Comm: multipathd Not tainted 5.19.0-rc1-roce-flush+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-27-g64f37cc530f1-prebuilt.qemu.org 04/01/2014
Call Trace:
  <TASK>
  dump_stack_lvl+0x34/0x44
  print_report.cold+0x5e/0x5db
  kasan_report+0xab/0x120
  srp_exit_cmd_priv+0x27/0xd0 [ib_srp]
  scsi_mq_exit_request+0x4d/0x70
  blk_mq_free_rqs+0x143/0x410
  __blk_mq_free_map_and_rqs+0x6e/0x100
  blk_mq_free_tag_set+0x2b/0x160
  scsi_host_dev_release+0xf3/0x1a0
  device_release+0x54/0xe0
  kobject_put+0xa5/0x120
  device_release+0x54/0xe0
  kobject_put+0xa5/0x120
  scsi_device_dev_release_usercontext+0x4c1/0x4e0
  execute_in_process_context+0x23/0x90
  device_release+0x54/0xe0
  kobject_put+0xa5/0x120
  scsi_disk_release+0x3f/0x50
  device_release+0x54/0xe0
  kobject_put+0xa5/0x120
  disk_release+0x17f/0x1b0
  device_release+0x54/0xe0
  kobject_put+0xa5/0x120
  dm_put_table_device+0xa3/0x160 [dm_mod]
  dm_put_device+0xd0/0x140 [dm_mod]
  free_priority_group+0xd8/0x110 [dm_multipath]
  free_multipath+0x94/0xe0 [dm_multipath]
  dm_table_destroy+0xa2/0x1e0 [dm_mod]
  __dm_destroy+0x196/0x350 [dm_mod]
  dev_remove+0x10c/0x160 [dm_mod]
  ctl_ioctl+0x2c2/0x590 [dm_mod]
  dm_ctl_ioctl+0x5/0x10 [dm_mod]
  __x64_sys_ioctl+0xb4/0xf0
  dm_ctl_ioctl+0x5/0x10 [dm_mod]
  __x64_sys_ioctl+0xb4/0xf0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Fixes: 65ca846a5314 ("scsi: core: Introduce {init,exit}_cmd_priv()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/scsi/hosts.c    | 10 +++++-----
  drivers/scsi/scsi_lib.c |  3 +++
  2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index ef6c0e37acce..74bfa187fe19 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -182,6 +182,8 @@ void scsi_remove_host(struct Scsi_Host *shost)
  	mutex_unlock(&shost->scan_mutex);
  	scsi_proc_host_rm(shost);

+	scsi_mq_destroy_tags(shost);
+
  	spin_lock_irqsave(shost->host_lock, flags);
  	if (scsi_host_set_state(shost, SHOST_DEL))
  		BUG_ON(scsi_host_set_state(shost, SHOST_DEL_RECOVERY));
@@ -295,8 +297,8 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
  	return error;

  	/*
-	 * Any host allocation in this function will be freed in
-	 * scsi_host_dev_release().
+	 * Any resources associated with the SCSI host in this function except
+	 * the tag set will be freed by scsi_host_dev_release().
  	 */
   out_del_dev:
  	device_del(&shost->shost_dev);
@@ -312,6 +314,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
  	pm_runtime_disable(&shost->shost_gendev);
  	pm_runtime_set_suspended(&shost->shost_gendev);
  	pm_runtime_put_noidle(&shost->shost_gendev);
+	scsi_mq_destroy_tags(shost);
   fail:
  	return error;
  }
@@ -345,9 +348,6 @@ static void scsi_host_dev_release(struct device *dev)
  		kfree(dev_name(&shost->shost_dev));
  	}

-	if (shost->tag_set.tags)
-		scsi_mq_destroy_tags(shost);
-
  	kfree(shost->shost_data);

  	ida_free(&host_index_ida, shost->host_no);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6ffc9e4258a8..1aa1a279f8f3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1990,7 +1990,10 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)

  void scsi_mq_destroy_tags(struct Scsi_Host *shost)
  {
+	if (!shost->tag_set.tags)
+		return;
  	blk_mq_free_tag_set(&shost->tag_set);
+	WARN_ON_ONCE(shost->tag_set.tags);
  }

  /**
