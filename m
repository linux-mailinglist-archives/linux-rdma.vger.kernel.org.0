Return-Path: <linux-rdma+bounces-23110-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mhN5DyqxVGpXpgMAu9opvQ
	(envelope-from <linux-rdma+bounces-23110-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:34:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E88707495CF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:34:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=jK3b4xZu;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23110-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23110-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1461302ACD2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288AF3E1D1D;
	Mon, 13 Jul 2026 09:34:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B33E1713
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 09:34:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935260; cv=none; b=T7oqToZJFBKCXVceCIp7wP8nG8R9732uY2z9fv+mLOu7coAxUfvfkVpcY0CcKl6l7d/N6J9QRc8mWT7f7Q+8LWXc3GNSqOqeKtzcVck0wey7g5E5BdnWuK/9hBt4DmfZTXclnX985VeUzVcAb/vHU2Rba06bXgkV/GYTTf/Sj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935260; c=relaxed/simple;
	bh=/T6nGTlY9/Sd8116vHsTUgpGQQf+hD3A6HYvzjdH4E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZctQN1Ex/mLDe7e4+oSsbKNJ0bWMsPbN+TpZ9eJkVaCGpIl1a09PzeJSI6BO+DJKs4/fd5GFvpGn5qvGwtZHiMw19rABfh0i58w4KT0CW7WX8bAYGI1VIZ3pweZWFnuOUZaIYiXnXEdqbDHHpc8/KsODGThsTaEuuzMo+1BYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=jK3b4xZu; arc=none smtp.client-ip=209.85.167.48
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aea0fff535so3194874e87.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783935255; x=1784540055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JO+WCMaAc1ZEkPF4Q2mmZ3+RjhHJAnIrQtg7/j50Rd8=;
        b=jK3b4xZuqPyzHx3pRi1OBVkyNbBxF721SyuQkKQZ4lsI0ymUF0PC99M6/kVcYeyy5O
         uf0mqWJ7g3pWcaW+S+cvotn/Ml94T4Ax8DxEfAdzv266YoT1pvKja3gjs3g7R6f3qJwi
         5VSR/NfEODcueUMVixXaU0BGP7xc8Jrp/cOvN7ip1DIeqFCwWQK78If5FKAahUR2OZJ7
         +TYmqJpthqralDYs2bSltZVWk85MQhu8WgjKDBaQH418HNtSIMwPghtnk3UOOZmLnme/
         gs1ua3FWUCHTy8y0CPDBF9alsyHpcDcDf8ti/Q0Dkl9kQ25Ar+TF+qq0zhZL5/bIK9rg
         GpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783935255; x=1784540055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO+WCMaAc1ZEkPF4Q2mmZ3+RjhHJAnIrQtg7/j50Rd8=;
        b=se5ojl1AXH2thp04T0lvtSMWuSJaox0qt0eHt0qAaE1dqza5BOGWBjpCnbqi9wRFmu
         7vYQs7l1QlIirP/PgW1FipFNTshNjXJrUOr9XDbB/iur596N2KLdRYURl7TmVq5/zy2Q
         0l+OmUtokSPnc5pytCx+hKfYIZr/tyFJ9c22q6ZNIsYPUpS2JWhWh3u5M86nF5ilo9Z6
         BML1oUOQcuRXWN5G6sZx/69272Bc1bGANgYhP/rAl+M5vuy151FJJPRBdu652cY9ttzM
         I1GhwJb1Hfk7xLnsLWSC65x1VigSvHYhXXSdoazPEskjceQ+nPExGRpgLDhMdORTwfig
         6R3A==
X-Gm-Message-State: AOJu0YxBqRhvtNH6flzlFpbW3FkiolxqU+0NUpPPUjkLdcFKCOSYd6wE
	AGJQd9yc4tWek70K02e6gnNQj4bJC25xyKdj4ZmYUhTUqOnsq9bYajX/Z2BcgpHG2v4=
X-Gm-Gg: AfdE7ckythUtIW7RqK5p08YtnOjgrfWQ9+P5sbXLolDFID91/j4MbmhSTODRgoYpFV7
	dc7QvYYlRjGA6iyI3BGTKzBssswlfKyEoF2p9EFKkiT2YNZC+xg+Z4tER5iavlejIwWKBIfP/aU
	V8GmDGRd9zV2tuTgEDOToGYumdrXAIcc9bYOJsnSpOrYVbhq4o+C8nJfPis9IhgVfrO9n+zD+fa
	bCUdJJsy/7mrMSFgwzSH7pqDTURgHZw/hEFUOBRrwOrLUtiuTakIEZ8FNLA9RVHjUlPoNXozLBj
	egGPR1aVQ7vFPl8wcd++URsnRxA3PVKMSZSATGb7/hpMMoW/trodfRR1tGr0uB/NIILal+9y9gK
	+xqGYFjchXCw72uCw+lttIKn6FkhkUaAWohlFsrlZ65++Vtfd25BDVqS8J4SP+Db8lXQXn1Tv72
	iSgQhgjRalFGWiM/G1n/m6eA==
X-Received: by 2002:a05:6512:519:b0:5b0:1af0:2a2a with SMTP id 2adb3069b0e04-5b0236bd3a7mr1125113e87.61.1783935255328;
        Mon, 13 Jul 2026 02:34:15 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a572sm2679126e87.2.2026.07.13.02.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:34:14 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:34:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-rdma@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jgg@ziepe.ca, leon@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	cmeiohas@nvidia.com, roman.gushchin@linux.dev, bvanassche@acm.org, 
	zyjzyj2000@gmail.com, shuah@kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com, 
	wenjia@linux.ibm.com
Subject: Re: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device
 visibility to the net namespace
Message-ID: <alSxB0wziQnNuyfn@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-9-jiri@resnulli.us>
 <ak-Z071LrWhnI5lK@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-Z071LrWhnI5lK@localhost.localdomain>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-23110-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:from_mime,resnulli.us:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,FV6GYCPJ69:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E88707495CF

Thu, Jul 09, 2026 at 03:04:23PM +0200, mkoutny@suse.com wrote:
>Hi.
>
>On Thu, Jul 09, 2026 at 11:55:27AM +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> index 993446ab66d0..4523c1884d67 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2752,6 +2752,13 @@ RDMA
>>  The "rdma" controller regulates the distribution and accounting of
>>  RDMA resources.
>>  
>> +When RDMA devices are isolated per network namespace (exclusive mode),
>> +device names are unique only within a network namespace. The device lines
>> +below are therefore scoped to the reading or writing process's network
>> +namespace: only devices accessible from that namespace are listed, and a
>> +limit is applied to the device of that name in that namespace. Configure
>> +limits from the same network namespace as the workloads.
>
>OK.
>
>> --- a/include/linux/cgroup_rdma.h
>> +++ b/include/linux/cgroup_rdma.h
>> @@ -7,6 +7,7 @@
>>  #define _CGROUP_RDMA_H
>>  
>>  #include <linux/cgroup.h>
>> +#include <net/net_namespace.h>
>>  
>>  enum rdmacg_resource_type {
>>  	RDMACG_RESOURCE_HCA_HANDLE,
>> @@ -34,6 +35,15 @@ struct rdmacg_device {
>>  	struct list_head	dev_node;
>>  	struct list_head	rpools;
>>  	char			*name;
>> +	/*
>> +	 * Net namespace the device belongs to. @netns_shared mirrors
>> +	 * ib_devices_shared_netns: when true the device is visible from every
>> +	 * net namespace (shared mode); otherwise @net is the only namespace
>> +	 * that may see and configure it. @netns_shared is updated when the
>> +	 * sharing mode changes, so use {READ,WRITE}_ONCE() to access it.
>> +	 */
>> +	possible_net_t		net;
>> +	bool			netns_shared;
>
>Any reason to store the netns_shared split per device? (IIUC, it's a
>global parameter.)

No reason, changed.

Thanks!

>
>Thanks,
>Michal



