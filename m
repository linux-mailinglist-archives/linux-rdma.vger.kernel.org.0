Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB7C6CC41E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Mar 2023 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjC1PAN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjC1PAC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 11:00:02 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7352FEB5E
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 07:59:56 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32SExm54016651;
        Tue, 28 Mar 2023 23:59:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Tue, 28 Mar 2023 23:59:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32SExmha016648
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Mar 2023 23:59:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
Date:   Tue, 28 Mar 2023 23:59:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZCLQ0XVSKVHV1MB2@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/03/28 20:34, Jason Gunthorpe wrote:
> On Tue, Mar 28, 2023 at 08:33:21PM +0900, Tetsuo Handa wrote:
>> On 2023/03/28 20:24, Jason Gunthorpe wrote:
>>> On Tue, Mar 28, 2023 at 07:52:32PM +0900, Tetsuo Handa wrote:
>>>> syzbot is reporting refcount leak when client->add() from
>>>> add_client_context() fails, for commit 11a0ae4c4bff ("RDMA: Allow
>>>> ib_client's to fail when add() is called") for unknown reason ignores
>>>> error from client->add(). We need to return an error in order to indicate
>>>> that client could not be added, otherwise the caller will get confused.
>>>>
>>>> Reported-by: syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>
>>>> Link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
>>>> Fixes: 11a0ae4c4bff ("RDMA: Allow ib_client's to fail when add() is called")
>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>> ---
>>>>  drivers/infiniband/core/device.c | 10 +++++-----
>>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> This doesn't make any sense, you need to explain what "caller will get
>>> confused" actually means
>>
>> The caller cannot perform cleanup upon error, which in turn manifests as
>> "unregister_netdevice: waiting for DEV to become free" message.
>> Please check https://lkml.kernel.org/r/710ef3ef-cd0a-5630-a68f-628d123180bf@I-love.SAKURA.ne.jp .
> 
> Describe exactly where the "cannot perform cleanup upon error" is.
> 

Here is a debug printk() patch for explanation.
----------------------------------------
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..2b9fc90d5cc4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1327,15 +1327,21 @@ static int enable_device_and_get(struct ib_device *device)
 			goto out;
 	}
 
+	pr_info("before add_client_context() loop: device=%p usage=%d\n", device, refcount_read(&device->refcount));
+	ret = 0;
 	down_read(&clients_rwsem);
 	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
-		ret = add_client_context(device, client);
-		if (ret)
-			break;
+		const int ret2 = add_client_context(device, client);
+		pr_info("add_client_context()=%d\n", ret2);
+		if (!ret)
+			ret = ret2;
 	}
 	up_read(&clients_rwsem);
-	if (!ret)
+	pr_info("after add_client_context() loop: ret=%d device=%p usage=%d\n", ret, device, refcount_read(&device->refcount));
+	if (!ret) {
 		ret = add_compat_devs(device);
+	}
+	pr_info("return from add_client_context(): ret=%d device=%p usage=%d\n", ret, device, refcount_read(&device->refcount));
 out:
 	up_read(&devices_rwsem);
 	return ret;
@@ -1417,7 +1423,9 @@ int ib_register_device(struct ib_device *device, const char *name,
 		goto dev_cleanup;
 	}
 
+	pr_info("before0: device=%p usage=%d\n", device, refcount_read(&device->refcount));
 	ret = enable_device_and_get(device);
+	pr_info("after0: ret=%d device=%p usage=%d\n", ret, device, refcount_read(&device->refcount));
 	if (ret) {
 		void (*dealloc_fn)(struct ib_device *);
 
@@ -1435,7 +1443,9 @@ int ib_register_device(struct ib_device *device, const char *name,
 		dealloc_fn = device->ops.dealloc_driver;
 		device->ops.dealloc_driver = prevent_dealloc_device;
 		ib_device_put(device);
+		pr_info("after1: device=%p usage=%d\n", device, refcount_read(&device->refcount));
 		__ib_unregister_device(device);
+		pr_info("after2: device=%p usage=%d\n", device, refcount_read(&device->refcount));
 		device->ops.dealloc_driver = dealloc_fn;
 		dev_set_uevent_suppress(&device->dev, false);
 		return ret;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index dacc174604bf..bc353b254257 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -519,7 +519,9 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
 		else
 			sdev->state = IB_PORT_DOWN;
 
+		pr_info("before siw_device_register(): device=%p usage=%d\n", &sdev->base_dev, refcount_read(&sdev->base_dev.refcount));
 		rv = siw_device_register(sdev, basedev_name);
+		pr_info("after siw_device_register(): rv=%d device=%p usage=%d\n", rv, &sdev->base_dev, refcount_read(&sdev->base_dev.refcount));
 		if (rv)
 			ib_dealloc_device(&sdev->base_dev);
 	}
----------------------------------------

Without this patch, __ib_unregister_device(device) is not called because
enable_device_and_get() returns 0 because add_client_context() returns 0
because add_client_context() ignores client->add() faiulures. As a result,
device's refcount remains 7, which later prevents unregister_netdevice()
 from unregistering this device.
----------------------------------------
[   32.366225][ T3491] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
[   32.369414][ T3491] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
[   32.372875][ T3491] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
[   32.376025][ T3491] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
[   32.390366][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
[   32.394826][ T3491] before siw_device_register(): device=ffff888108206000 usage=0
[   32.397861][ T3491] before0: device=ffff888108206000 usage=0
[   32.400057][ T3491] before add_client_context() loop: device=ffff888108206000 usage=2
[   32.407313][ T3491] add_client_context()=0
[   32.409077][ T3491] add_client_context()=0
[   32.411592][ T3491] add_client_context()=0
[   32.413276][ T3491] add_client_context()=0
[   32.414931][ T3491] add_client_context()=0
[   32.416596][ T3491] add_client_context()=0
[   32.418288][ T3491] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[   32.423042][ T3491] infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98
[   32.425622][ T3491] add_client_context()=0
[   32.428176][ T3491] add_client_context()=0
[   32.429835][ T3491] add_client_context()=0
[   32.435844][ T3491] add_client_context()=0
[   32.438270][ T3491] add_client_context()=0
[   32.439967][ T3491] add_client_context()=0
[   32.441667][ T3491] add_client_context()=0
[   32.443575][ T3491] add_client_context()=0
[   32.445507][ T3491] add_client_context()=0
[   32.447142][ T3491] after add_client_context() loop: ret=0 device=ffff888108206000 usage=8
[   32.450930][ T3491] return from add_client_context(): ret=0 device=ffff888108206000 usage=8
[   32.454207][ T3491] after0: ret=0 device=ffff888108206000 usage=8
[   32.456541][ T3491] after siw_device_register(): rv=0 device=ffff888108206000 usage=7
[  172.605175][ T3491] unregister_netdevice: waiting for vlan0 (ffff8881075ba000) to become free. Usage count = 2
[  172.634645][ T3491] leaked reference.
[  172.645548][ T3491]  ib_device_set_netdev+0x20c/0x3e0
[  172.651096][ T3491]  siw_newlink+0x2e0/0x540
[  172.659445][ T3491]  nldev_newlink+0x31f/0x3c0
[  172.666976][ T3491]  rdma_nl_rcv+0x379/0x4a0
[  172.683027][ T3491]  netlink_unicast+0x3b8/0x480
[  172.693245][ T3491]  netlink_sendmsg+0x574/0x660
[  172.702226][ T3491]  ____sys_sendmsg+0x2b7/0x3d0
[  172.715316][ T3491]  __sys_sendmsg+0x352/0x3c0
[  172.740055][ T3491]  do_syscall_64+0x41/0x90
[  172.788179][ T3491]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
----------------------------------------

With this patch, __ib_unregister_device(device) is called because
enable_device_and_get() returns error because add_client_context() returns error
because add_client_context() does not ignore client->add() faiulures. As a result,
device's refcount properly drops to 0, which allows unregister_netdevice() to
unregister this device.
----------------------------------------
[   26.351298][ T3504] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
[   26.373714][ T3504] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
[   26.376967][ T3504] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
[   26.380105][ T3504] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
[   26.383755][  T160] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
[   26.396376][ T3504] before siw_device_register(): device=ffff8880075fc000 usage=0
[   26.402221][ T3504] before0: device=ffff8880075fc000 usage=0
[   26.404461][ T3504] before add_client_context() loop: device=ffff8880075fc000 usage=2
[   26.408205][ T3504] add_client_context()=-95
[   26.416782][ T3504] add_client_context()=-95
[   26.419042][ T3504] add_client_context()=-95
[   26.420843][ T3504] add_client_context()=0
[   26.422506][ T3504] add_client_context()=0
[   26.424163][ T3504] add_client_context()=-95
[   26.425958][ T3504] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[   26.428983][ T3504] infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98
[   26.431641][ T3504] add_client_context()=-98
[   26.433457][ T3504] add_client_context()=-95
[   26.435729][ T3504] add_client_context()=0
[   26.438326][ T3504] add_client_context()=0
[   26.439989][ T3504] add_client_context()=0
[   26.441629][ T3504] add_client_context()=-95
[   26.443411][ T3504] add_client_context()=0
[   26.445082][ T3504] add_client_context()=-95
[   26.446974][ T3504] add_client_context()=-95
[   26.449578][ T3504] after add_client_context() loop: ret=-95 device=ffff8880075fc000 usage=8
[   26.452833][ T3504] return from add_client_context(): ret=-95 device=ffff8880075fc000 usage=8
[   26.456563][ T3504] after0: ret=-95 device=ffff8880075fc000 usage=8
[   26.459548][ T3504] after1: device=ffff8880075fc000 usage=7
[   26.462257][ T3504] after2: device=ffff8880075fc000 usage=0
[   26.464377][ T3504] siw: device registration error -95
[   26.466639][ T3504] after siw_device_register(): rv=-95 device=ffff8880075fc000 usage=0
[   29.593478][  T821] netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[   32.039458][  T821] netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[   32.099082][  T821] netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
[   32.138972][  T821] netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
----------------------------------------

