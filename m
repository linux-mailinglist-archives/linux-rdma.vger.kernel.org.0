Return-Path: <linux-rdma+bounces-16704-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GILVOhoHi2kdPQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16704-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 11:23:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FA61199B7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 11:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C1C03014FC0
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF335B647;
	Tue, 10 Feb 2026 10:23:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6D35A928
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718996; cv=none; b=j2JgYYikp0IBCS2ufO11s3tsT4/D1g36XORpbXlzLRJuJAcKZH2M1QniRg9dbbm9kUQR+o1MNXdSC31PZhxEgffCktchYfWUrY9NWfaf5KmSJ4TnDVQ0NUL2IZhk3Vz1h7GSLkWOuoN6nPjSoT9KXM2hF/sOg12QnfVcVtjAJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718996; c=relaxed/simple;
	bh=B6UbppatYl5mhhyfjvb5ueaRRpOmiLv6llUW46Ugvgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DK9YrHPMaBH0QzWHV4AIfhlQ8rJ0juzIEc1zSWKnGgXdY0XToWafSXtUMsIM41RsHOCmpHx//3otXothLVmz/oJm/BtONlPOo1VOTw9lG8t51Cd+cAjjIsrSejid/nAtuWF+SbQEmauoSlAmQye5B3zn9rVNZavfDq6mtRIL3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61AAMiDs035706;
	Tue, 10 Feb 2026 19:22:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61AAMihP035702
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 10 Feb 2026 19:22:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3f1881d9-243d-4869-8396-5cca2e915733@I-love.SAKURA.ne.jp>
Date: Tue, 10 Feb 2026 19:22:43 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com,
        parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com,
        marco.crivellari@suse.com, roman.gushchin@linux.dev,
        "Yanjun.Zhu" <yanjun.zhu@linux.dev>
References: <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
 <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
 <20260202235133.GP2328995@ziepe.ca>
 <c5ebe396-eccf-450b-8486-e1900258d9c0@I-love.SAKURA.ne.jp>
 <eqplwtvsocnqesb7vysnb6cq2emmghbg5wttkc6oyltsqtw6zi@6iewgx2qnsml>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <eqplwtvsocnqesb7vysnb6cq2emmghbg5wttkc6oyltsqtw6zi@6iewgx2qnsml>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16704-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07FA61199B7
X-Rspamd-Action: no action

On 2026/02/10 17:58, Jiri Pirko wrote:
>> Jiri, can you append the race with unregister case to the patch description?
> 
> I don't understand what exactly you want and why.

I'm currently testing
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?h=next-20260209&id=755d028a40bfbef34f98286b394ab4d30d07e07b
in linux-next tree. Since your patch includes what the above patch does,
your patch description can include the following chunk; though I haven't
identified what is preventing the driver from reaching ib_cache_cleanup_one()
after NETDEV_UNREGISTER became no longer working...



This patch is expected to also address another race syzbot is reporting.

The root cause is a race between netdev event processing and device
unregistration; something is preventing the driver from reaching
ib_cache_cleanup_one() after NETDEV_UNREGISTER became no longer working.
 

  CPU 0 (driver)                    CPU 1 (workqueue)
  ──────────────      ──────────────────────
  __ib_unregister_device()
    disable_device()
      xa_clear_mark(DEVICE_REGISTERED)
        ← Too early, event will be lost

                                    NETDEV_UNREGISTER queued
                                    netdevice_event_work_handler()
                                      ib_enum_all_roce_netdevs()
                                        ← Iterates DEVICE_REGISTERED
                                        ← Device NO LONGER marked, SKIP!
                                        del_gid()
                                          ← GID cannot be deleted
    ib_cache_cleanup_one()
      gid_table_cleanup_one()
        gid_table_cleanup_one()
          del_gid()
            ← all GIDs will be deleted


