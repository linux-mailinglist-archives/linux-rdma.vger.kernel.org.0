Return-Path: <linux-rdma+bounces-17345-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JArUK1Xuo2lXSQUAu9opvQ
	(envelope-from <linux-rdma+bounces-17345-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 08:44:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B41CEBF3
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 08:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB8523016D09
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2026 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB930ACF6;
	Sun,  1 Mar 2026 07:44:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042B19DF6A
	for <linux-rdma@vger.kernel.org>; Sun,  1 Mar 2026 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772351055; cv=none; b=hKLb6Wfky5MQJK+KBIUYBPsUm6fvKbD3MYlD9PhSbs5PqwDHskbtUzXigph6t85Nm12mh22sEnSZDQyslv2ytYhq9u0igmz0woIpNSsHE4GsbiZ0aExrWdLpVjEkxMKgmedi46AB6XisSV0qAi28rBs7TfAmMBWAwwgIdKSrFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772351055; c=relaxed/simple;
	bh=TIX50CsvJteb2HFe5zeZHMQQtsMrexiK6PzHPX99U94=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YL7nzzYRTvNGW6F1ugP0nIe+FA4g8fO8xn/D7wmkCjf/nah6AAzabj/SKYjtvHg87onDm8X2wl1iiXXo7f548oY2cVjPGaBi/HiYnHeNjfmmNeaSuJqzXH8L8cfdLhl0X4dXsrgZncvEJfIdxTwq6kzyiDHG7W6F0RiQj8E3ssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6217htQa001234;
	Sun, 1 Mar 2026 16:43:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6217ht4c001226
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Mar 2026 16:43:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <116c8183-64a4-4afd-8a5a-b9ee65610480@I-love.SAKURA.ne.jp>
Date: Sun, 1 Mar 2026 16:43:55 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rdma] "rdma link del" operation hangs at wait_for_completion()
 when a file descriptor is in use.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
References: <cc96166a-a469-4bc9-bfbe-de6f40dffe97@I-love.SAKURA.ne.jp>
 <d800131b-d257-4dc7-adcf-7c35e7a223d2@I-love.SAKURA.ne.jp>
 <20260228164336.GQ44359@ziepe.ca>
 <68867ec9-28f4-4ec1-8639-0b970da148a4@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <68867ec9-28f4-4ec1-8639-0b970da148a4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-17345-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A2B41CEBF3
X-Rspamd-Action: no action

On 2026/03/01 7:35, Tetsuo Handa wrote:
> On 2026/03/01 1:43, Jason Gunthorpe wrote:
>> On Sat, Feb 28, 2026 at 03:07:29PM +0900, Tetsuo Handa wrote:
>>> On 2025/12/04 17:26, Tetsuo Handa wrote:
>>>> I found that running the attached example program causes khungtaskd message. What is wrong?
>>>
>>> I found that this is a deadlock caused by "struct ib_device_ops"->disassociate_ucontext == NULL.
>>> If the thread which called ib_uverbs_remove_one() is unable to call ib_uverbs_release_file()
>>>  from ib_uverbs_close() because it is blocked at
>>> wait_for_completion(), it forms a deadlock.
>>
>> That doesn't sound right at all, the wait_for_completion is waiting
>> for other threads to let go of the context before closing it. rxe/etc
>> that syzkaller is testing don't support disassociate so they need to
>> wait.
> 
> This issue was not found by syzkaller. Please see the reproducer.
> 
>>
>> If the wait gets stuck that is a different issue.
> 
> My question is how we can support disassociate...
> 

As of eb71ab2bf722 in linux.git, this problem is still reproducible.

If you add debug printk() like below, you will be able to confirm that
ib_uverbs_remove_one() cannot return unless file descriptor is closed.


diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 7b68967a6301..aa247b662836 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -210,8 +210,11 @@ void ib_uverbs_release_file(struct kref *ref)
                module_put(ib_dev->ops.owner);
        srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);

-       if (refcount_dec_and_test(&file->device->refcount))
+       if (refcount_dec_and_test(&file->device->refcount)) {
+               pr_info("Start ib_uverbs_comp_dev()\n");
                ib_uverbs_comp_dev(file->device);
+               pr_info("End ib_uverbs_comp_dev()\n");
+       }

        if (file->default_async_file)
                uverbs_uobject_put(&file->default_async_file->uobj);
@@ -1277,8 +1280,11 @@ static void ib_uverbs_remove_one(struct ib_device *device, void *client_data)

        if (refcount_dec_and_test(&uverbs_dev->refcount))
                ib_uverbs_comp_dev(uverbs_dev);
-       if (wait_clients)
+       if (wait_clients) {
+               pr_info("Start wait_for_completion()\n");
                wait_for_completion(&uverbs_dev->comp);
+               pr_info("End wait_for_completion()\n");
+       }

        put_device(&uverbs_dev->dev);
 }

[  322.613977] [   T1281] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[  322.691002] [   T1321] Start wait_for_completion()
[  496.727254] [    T100] INFO: task rdma:1321 blocked for more than 122 seconds.
[  496.732315] [    T100]       Not tainted 7.0.0-rc1+ #288
[  496.736240] [    T100] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  496.742253] [    T100] task:rdma            state:D stack:0     pid:1321  tgid:1321  ppid:1281   task_flags:0x400100 flags:0x00080000
[  496.750349] [    T100] Call Trace:
[  496.752911] [    T100]  <TASK>
[  496.755040] [    T100]  __schedule+0x33e/0x6d0
[  496.758612] [    T100]  ? __lock_release.isra.0+0x59/0x170
[  496.761729] [    T100]  schedule+0x3a/0xe0
[  496.764818] [    T100]  schedule_timeout+0xca/0x110
[  496.768491] [    T100]  wait_for_completion+0x8a/0x140
[  496.771999] [    T100]  ib_uverbs_remove_one+0x1bc/0x220 [ib_uverbs]
[  496.776066] [    T100]  remove_client_context+0x8d/0xd0 [ib_core]
[  496.780560] [    T100]  disable_device+0x8b/0x170 [ib_core]
[  496.784371] [    T100]  __ib_unregister_device+0x110/0x180 [ib_core]
[  496.789351] [    T100]  ib_unregister_device_and_put+0x37/0x50 [ib_core]
(...snipped...) // Kill rdma_example process here which is waiting for rdma process to terminate.
[  540.070450] [   T1281] Start ib_uverbs_comp_dev()
[  540.074127] [   T1281] End ib_uverbs_comp_dev()
[  540.074498] [   T1321] End wait_for_completion()


