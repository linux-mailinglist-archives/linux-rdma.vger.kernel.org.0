Return-Path: <linux-rdma+bounces-16342-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCjxAkG1gGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16342-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:31:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C47EBCD629
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D682307ACD0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5C361641;
	Mon,  2 Feb 2026 14:21:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008736C58F
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042070; cv=none; b=grHRbZCZBqrjGL95e+nY0/ea2YnMh48IProPGi8LM9OepXXvHX6CbihUCbVxLufoCRp2gwP1TxIUqRimFqU1FmzdfGkOWrZzifoTgwRUZN1rfrQRUMVEurT1lcoPRLY9ov2tlcXpm28m5qreU4dD1aJZQYkOeKr5HNHg1ylucJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042070; c=relaxed/simple;
	bh=0YormrQwwRzBgJ1IDyk4G9+WFurZzpT5t2xb1Wk4mWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVam1uC7wm0Df+USer5WmKHNM2d2L7pmu+qeRcookleHfkxo6atZ8yCOCKUpYLc+P+16XEggKT9etbh2IeLwInnB0V9viZ88QVFT5So6WSh53LVmJZ7wjl38VepRPCL1EDV21Hq3V6gBRvbpZ1xcymy+QTXQbJDoYXrL9PAHM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 612EKOoe095746;
	Mon, 2 Feb 2026 23:20:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 612EKO7l095742
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 2 Feb 2026 23:20:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
Date: Mon, 2 Feb 2026 23:20:22 +0900
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
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com,
        maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com,
        markzhang@nvidia.com, marco.crivellari@suse.com,
        roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16342-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: C47EBCD629
X-Rspamd-Action: no action

On 2026/01/29 23:58, Jiri Pirko wrote:
> I suggest you read the patch description again.
> for example this funtion netdevice_event_work_handler()
> which eventually gets to call ib_enum_all_roce_netdevs().

I checked possibility of race.

On 2026/01/27 18:38, Jiri Pirko wrote:
> - The GID table mutex serializes concurrent access between the initial
>   rescan and event handlers

Is this mutex_lock(&table->lock) in __ib_cache_gid_add() ?
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/core/cache.c#L564

> - Event handlers correctly update stale GIDs even when racing with rescan

I couldn't confirm that this is always true. What happens if rdma_roce_rescan_device()
is preempted between make_default_gid() and __ib_cache_gid_add(), and NETDEV_CHANGEADDR
event runs meanwhile? It sounds to me that stale gid is possible because gid value is
calculated before holding the GID table mutex...

rdma_roce_rescan_device() {
  ib_enum_roce_netdev() {
    enum_all_gids_of_dev_cb() {
      add_default_gids() {
        ib_cache_gid_set_default_gid() {
          make_default_gid(ndev, &gid); // GIDs populated with OLD MAC
                                                                ip link set eth4 addr NEW_MAC
                                                                NETDEV_CHANGEADDR queued
                                                                netdevice_event_work_handler() {
                                                                  ib_enum_all_roce_netdevs() {
                                                                    ib_enum_roce_netdev() {
                                                                      enum_all_gids_of_dev_cb() {
                                                                        add_default_gids() {
                                                                          ib_cache_gid_set_default_gid() {
                                                                            make_default_gid(ndev, &gid); // GIDs populated with NEW MAC
                                                                            __ib_cache_gid_add(ib_dev, port, &gid, &gid_attr, mask, true) {
                                                                              mutex_lock(&table->lock);
                                                                              add_modify_gid(table, attr); // Writing GIDs populated with NEW MAC
                                                                              mutex_unlock(&table->lock);
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
          __ib_cache_gid_add(ib_dev, port, &gid, &gid_attr, mask, true) {
            mutex_lock(&table->lock);
            add_modify_gid(table, attr); // Overwriting with GIDs populated with OLD MAC ?
          }
        }
      }
    }
  }
}


