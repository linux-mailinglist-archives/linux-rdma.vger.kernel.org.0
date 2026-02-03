Return-Path: <linux-rdma+bounces-16385-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GeEKDNygWmSGQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16385-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 04:57:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD62D4418
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 04:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CB0C3006807
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BF2F1FEA;
	Tue,  3 Feb 2026 03:57:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857E7260F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770091054; cv=none; b=XV+hoVrgj3Q8Oo5NxpVkfGo5Gtkr0mUvpX1kuOTH3+xPS4M1XG1O9z50bop351KaDqjHUtYBfSGsE/lGGokUqcjJKVuIq9OkQVqWqLc2O9RWyrj6IqydoI/rbXtLt0nH2U7xz/DC3aLizWnGyE06RY2ltlHUOfMgoZEqrHYceRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770091054; c=relaxed/simple;
	bh=4TGxsmBPIMWTwGptKR5oZXgfXTakqrhH9vg9F+3g6WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUu9HWtBsQ4VC4eUNmY53eNUshJIOLi3AWsaFKE742cKoqfqTmJzsTjrf9Pg1kEkF8vJkgF2Jb3Fm3kkB/uHZcHjNltdB8pwTMhckfJ+4dK2e5YUMMsy0kboFYE0ZLV2CjVoIuPnYgwjClN47OVhP1qnsZl/V/EuUQjozi7UuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6133qC2a005944;
	Tue, 3 Feb 2026 12:52:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6133qC4q005941
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 3 Feb 2026 12:52:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c5ebe396-eccf-450b-8486-e1900258d9c0@I-love.SAKURA.ne.jp>
Date: Tue, 3 Feb 2026 12:52:10 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org, leon@kernel.org,
        msanalla@nvidia.com, maorg@nvidia.com, parav@nvidia.com,
        mbloch@nvidia.com, markzhang@nvidia.com, marco.crivellari@suse.com,
        roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>
References: <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
 <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
 <20260202235133.GP2328995@ziepe.ca>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260202235133.GP2328995@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16385-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBD62D4418
X-Rspamd-Action: no action

On 2026/02/03 8:51, Jason Gunthorpe wrote:
> On Mon, Feb 02, 2026 at 11:20:22PM +0900, Tetsuo Handa wrote:
> 
>>> - Event handlers correctly update stale GIDs even when racing with rescan
>>
>> I couldn't confirm that this is always true. What happens if rdma_roce_rescan_device()
>> is preempted between make_default_gid() and __ib_cache_gid_add(), and NETDEV_CHANGEADDR
>> event runs meanwhile? It sounds to me that stale gid is possible because gid value is
>> calculated before holding the GID table mutex...
>>
>> rdma_roce_rescan_device() {
>>   ib_enum_roce_netdev() {
>>     enum_all_gids_of_dev_cb() {
>>       add_default_gids() {
>>         ib_cache_gid_set_default_gid() {
>>           make_default_gid(ndev, &gid); // GIDs populated with OLD MAC
>>                                                                 ip link set eth4 addr NEW_MAC
>>                                                                 NETDEV_CHANGEADDR queued
> 
> I thought this was impossible because enum_all_gids_of_dev_cb() holds
> the rtnl_lock()?

Indeed, so it is not the GID table mutex but the RTNL mutex that serializes
concurrent access between the initial rescan and event handlers.

Jiri, can you append the race with unregister case to the patch description?


