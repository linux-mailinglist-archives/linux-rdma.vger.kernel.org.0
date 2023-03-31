Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8706D2572
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Mar 2023 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjCaQ0f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Mar 2023 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjCaQ0U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Mar 2023 12:26:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA20624AC6
        for <linux-rdma@vger.kernel.org>; Fri, 31 Mar 2023 09:21:31 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32VGJnpH078963;
        Sat, 1 Apr 2023 01:19:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 01 Apr 2023 01:19:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32VGJl2m078956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Apr 2023 01:19:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <747eaa78-5773-c2fd-5a8f-97998a0c9883@I-love.SAKURA.ne.jp>
Date:   Sat, 1 Apr 2023 01:19:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
 <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
 <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
 <ZCMTZWdY7D7mxJuE@ziepe.ca>
 <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
 <ZCRc5S9QGZqcZhNg@ziepe.ca>
 <9186f5f5-2f88-1247-2d24-61d090a1da83@I-love.SAKURA.ne.jp>
 <ZCYdo8pcS947JOgI@ziepe.ca>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZCYdo8pcS947JOgI@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/03/31 8:39, Jason Gunthorpe wrote:
> Look at siw_netdev_event:
> 
> 	case NETDEV_UNREGISTER:
> 		ib_unregister_device_queued(&sdev->base_dev);
> 		break;

I see. We can observe that

  net vlan0: siw: event 6

is emitted for every second, but unfortunately ib_unregister_device_queued() is
never called because dev_net(netdev) != &init_net is true. Changing like below
avoids this problem.

I guess that either dev_net(netdev) is not appropriately initialized or
dev_net(netdev) != &init_net is too restrictive to call ib_unregister_device_queued().
Where is dev_net(netdev) initialized?

----------------------------------------
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index dacc174604bf..6f125e282dfc 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -434,13 +434,20 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 	struct net_device *netdev = netdev_notifier_info_to_dev(arg);
 	struct ib_device *base_dev;
 	struct siw_device *sdev;
+	bool flag = false;
 
-	dev_dbg(&netdev->dev, "siw: event %lu\n", event);
+	dev_info(&netdev->dev, "siw: event %lu\n", event);
 
-	if (dev_net(netdev) != &init_net)
-		return NOTIFY_OK;
+	if (dev_net(netdev) != &init_net) {
+		pr_info("dev_net(netdev)=%px init_net=%px\n", dev_net(netdev), &init_net);
+		if (event != NETDEV_UNREGISTER)
+			return NOTIFY_OK;
+		flag = true;
+	}
 
 	base_dev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_SIW);
+	if (flag)
+		pr_info("base_dev=%px for netdev=%px\n", base_dev, netdev);
 	if (!base_dev)
 		return NOTIFY_OK;
 
@@ -471,6 +478,8 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 		break;
 
 	case NETDEV_UNREGISTER:
+		if (flag)
+			pr_info("ib_unregister_device_queued(%px)\n", &sdev->base_dev);
 		ib_unregister_device_queued(&sdev->base_dev);
 		break;
 
----------------------------------------

----------------------------------------
[   47.201976] net vlan0: siw: event 6
[   47.203645] dev_net(netdev)=ffff88800ef58000 init_net=ffffffff86435700
[   47.206277] base_dev=ffff888100e32000 for netdev=ffff88810389f000
[   47.208708] ib_unregister_device_queued(ffff888100e32000)
----------------------------------------

