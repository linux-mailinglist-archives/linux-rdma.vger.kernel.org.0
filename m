Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D286C8F48
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Mar 2023 17:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCYQDT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Mar 2023 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYQDS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Mar 2023 12:03:18 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186908685
        for <linux-rdma@vger.kernel.org>; Sat, 25 Mar 2023 09:03:16 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32PG2XQg050521;
        Sun, 26 Mar 2023 01:02:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 26 Mar 2023 01:02:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32PG2WOp050518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 26 Mar 2023 01:02:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <710ef3ef-cd0a-5630-a68f-628d123180bf@I-love.SAKURA.ne.jp>
Date:   Sun, 26 Mar 2023 01:02:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [syzbot] unregister_netdevice: waiting for DEV to become free (7)
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        chenzhongjin@huawei.com, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org, wangyufen <wangyufen@huawei.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000060c7e305edbd296a@google.com>
 <CACT4Y+a=HbyJE3A_SnKm3Be-kcQytxXXF89gZ_cN1gwoAW-Zgw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACT4Y+a=HbyJE3A_SnKm3Be-kcQytxXXF89gZ_cN1gwoAW-Zgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I made a simplified reproducer, using
https://syzkaller.appspot.com/text?tag=ReproC&x=1193ae64f00000 as a base
with main() rewritten like below.

----------
int main(void)
{
	unshare(CLONE_NEWNET);
	initialize_netdevices();
	const int fd1 = socket(AF_NETLINK, SOCK_RAW, NETLINK_RDMA);
	struct iovec iov = {
		.iov_base = "\x38\x00\x00\x00\x03\x14\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09"
		"\x00\x02\x00\x73\x79\x6a\x31\x00\x00\x00\x00\x08\x00\x41\x00\x73\x69"
		"\x77\x00\x14\x00\x33\x00\x76\x6c\x61\x6e\x30",
		.iov_len = 0x38
	};
	struct msghdr msg = {
		.msg_iov = &iov,
		.msg_iovlen = 1
	};
	sendmsg(fd1, &msg, 0);
	if (0) { /* Enable this block if you want to observe hung without exit(0). */
		const int fd2 = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
		struct /* vlan_ioctl_args */ {
			int cmd;
			char device1[24];
			union {
				char device2[24];
				int VID;
				unsigned int skb_priority;
				unsigned int name_type;
				unsigned int bind_type;
				unsigned int flag;
			} u;
			short vlan_qos;   
		} args = {
			.cmd = 1 /* DEL_VLAN_CMD */,
			.device1 = "vlan0",
		};
		ioctl(fd2, 0x8982 /* SIOCGIFVLAN */, &args);
	}
	return 0;
}
----------

Using this reproducer, I did several tests.

This problem is reproduced with below diff (which pretends as if e.g.
cma_add_one(), ib_uverbs_add_one(), srp_add_one() failed with -ENOMEM
error because they do GFP_KERNEL allocation).

----------
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..f8f593bd81e5 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -710,23 +710,23 @@ static int add_client_context(struct ib_device *device,
 	 */
 	if (xa_get_mark(&device->client_data, client->client_id,
 		    CLIENT_DATA_REGISTERED))
 		goto out;
 
 	ret = xa_err(xa_store(&device->client_data, client->client_id, NULL,
 			      GFP_KERNEL));
 	if (ret)
 		goto out;
 	downgrade_write(&device->client_data_rwsem);
 	if (client->add) {
-		if (client->add(device)) {
+		if (1) {
 			/*
 			 * If a client fails to add then the error code is
 			 * ignored, but we won't call any more ops on this
 			 * client.
 			 */
 			xa_erase(&device->client_data, client->client_id);
 			up_read(&device->client_data_rwsem);
 			ib_device_put(device);
 			ib_client_put(client);
 			return 0;
 		}
----------

Since client->add() can fail with -ENOMEM, pretending as if
client->add() always fails with -ENOMEM hides this problem.

----------
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..4c986f62514f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -695,6 +695,9 @@ static int add_client_context(struct ib_device *device,
 	if (!device->kverbs_provider && !client->no_kverbs_req)
 		return 0;
 
+	if (client->add)
+		return -ENOMEM;
+
 	down_write(&device->client_data_rwsem);
 	/*
 	 * So long as the client is registered hold both the client and device
----------

However, changing to return 0 instead of -ENOMEM again shows this problem.

----------
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..9dcf712e542d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -695,6 +695,9 @@ static int add_client_context(struct ib_device *device,
 	if (!device->kverbs_provider && !client->no_kverbs_req)
 		return 0;
 
+	if (client->add)
+		return 0;
+
 	down_write(&device->client_data_rwsem);
 	/*
 	 * So long as the client is registered hold both the client and device
----------

These results suggest that the "If a client fails to add then the error code
is ignored" part is wrong. We need to teach the caller about the failure, even
if we don't call any more ops on this client.

Please re-evaluate commit 11a0ae4c4bff ("RDMA: Allow ib_client's to fail when
add() is called"). I don't know why that commit ignores failures. There could
be some error code which should be ignored, but I feel that there are error
codes which should not be ignored. What do you think?




From 3e1cd08cb206afa827d196e4730ba9c3670a7fe7 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 26 Mar 2023 00:34:05 +0900
Subject: [PATCH] RDMA: don't ignore client->add() failures

syzbot is reporting refcount leak when client->add() from
add_client_context() fails, for add_client_context() is ignoring error from
client->add(). We need to return an error in order to indicate that client
could not be added, or the caller will get confused.

Reported-by: syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/infiniband/core/device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a666847bd714..c72f810ceae1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -718,17 +718,17 @@ static int add_client_context(struct ib_device *device,
 		goto out;
 	downgrade_write(&device->client_data_rwsem);
 	if (client->add) {
-		if (client->add(device)) {
+		ret = client->add(device);
+		if (ret) {
 			/*
-			 * If a client fails to add then the error code is
-			 * ignored, but we won't call any more ops on this
-			 * client.
+			 * If a client fails to add, we won't call any more
+			 * ops on this client.
 			 */
 			xa_erase(&device->client_data, client->client_id);
 			up_read(&device->client_data_rwsem);
 			ib_device_put(device);
 			ib_client_put(client);
-			return 0;
+			return ret;
 		}
 	}
 
-- 
2.34.1

