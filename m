Return-Path: <linux-rdma+bounces-17045-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDXTCm+7mWnaWQMAu9opvQ
	(envelope-from <linux-rdma+bounces-17045-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 15:04:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB016CF80
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 15:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D9B3015723
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E13D17BB21;
	Sat, 21 Feb 2026 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP2o/tzJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436410FD;
	Sat, 21 Feb 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771682664; cv=none; b=eq2UUdsUnb3hvRCyehrpE+36Y7/kXndTvjEpr9dG327do3IUPnYmX8CJxgnrcYqyWKhJxOI6S6ULrJ2Nc2DZ91lAb0NJOTBJlJDWB7dEMyY+dU7hPEC6w8unY+dZGZ6QzEoIdxKX0zdvw/ToUfC9cYeB4wgfAzYbrBRVsC84EY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771682664; c=relaxed/simple;
	bh=7dszeMmlZLI8gAeNlbjsoqmiu35q8bwMF1qIay5Q0bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaEKq5mSA+yq/V+VHQxaM0XftaHZ7hMdKUMPGMQ+WiLtAIYLwza4MNMYXnUnyNCyabvLfL6VtrUyp5TIGp+SmRitUb9u9bmJuJW+7wJbpeepciME1s7kQmc4Y27Q/ozasgKkLi73WRyWHFF/DGAFGuYe01eKavhPXWgbQpDRy/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP2o/tzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D77C4CEF7;
	Sat, 21 Feb 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771682663;
	bh=7dszeMmlZLI8gAeNlbjsoqmiu35q8bwMF1qIay5Q0bk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tP2o/tzJXZVFvJ4/nsQHMIAm1Leiu7L0ipRdnR/vll11kB7GtzWHyHY9Hd6LswAI+
	 j71Gnxa/R2otVZ47bwpnAi/313o7r2jxxcC5vxulEAzB8AJ9FJ20EisbTUbtE7bfAS
	 lgzVWeIricmzP+owPku79KJBgLI22eIP+XUC4R/yP9mjhGC7HKGHf0vwqx6n5klYdj
	 ceAptDDntFZPQlctZwDIsYtGlc0q+bUQq/Z0segYTxcHrHqL5VMfMohtT3phCICuA+
	 9/8siDuGv9yiTZ2wmRbe5YNI19PxPw4idsEhpLHPA9UhrG2HCCTXZTXa2IE534Dkey
	 csFIqgueSyYWg==
Message-ID: <f0286fcc-0408-4e65-9a2b-85aa1c21fdb8@kernel.org>
Date: Sat, 21 Feb 2026 15:04:18 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/10] kobject: make struct kobject member
 default_groups a constant array
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 driver-core@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org
References: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
 <04c85242-dc51-4ddf-9920-4dab57f2498f@kernel.org>
 <f18e8c2f-28b0-4905-87c2-a16dd54c53d1@t-8ch.de>
Content-Language: en-US
From: Heiner Kallweit <hkall@kernel.org>
In-Reply-To: <f18e8c2f-28b0-4905-87c2-a16dd54c53d1@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17045-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkall@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62CB016CF80
X-Rspamd-Action: no action

On 21.02.2026 14:27, Thomas Weißschuh wrote:
> Hello Heiner,
> 
> On 2026-02-17 23:32:46+0100, Heiner Kallweit wrote:
>> Constify the default_groups array, allowing to assign constant arrays.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> (The patch author/From header and Signed-off-by line do not match)
> 
Right, have to fix this once series is out of RFC state.

>> ---
>>  include/linux/kobject.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
>> index c8219505a79..e45ee843931 100644
>> --- a/include/linux/kobject.h
>> +++ b/include/linux/kobject.h
>> @@ -116,7 +116,7 @@ char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
>>  struct kobj_type {
>>  	void (*release)(struct kobject *kobj);
>>  	const struct sysfs_ops *sysfs_ops;
>> -	const struct attribute_group **default_groups;
>> +	const struct attribute_group *const *default_groups;
> 
> Thanks for working on this!
> 
> Personally I try to constify the attribute structures together with
> their corresponding callbacks. This ensures that no structure is
> constified which its callback then tries to modify.
> Currently there is no support for const arguments to the callbacks of
> 'struct kobj_attribute' and 'struct device_attribute'. I am wondering
> if the changes to kobject and device groups should be kept out for now
> and be added together with the support for their const callback arguments.
> 

I think we have to be precise what exactly gets constified:
In the series here it's about arrays of pointers to attribute groups.
Just these arrays can't be modified any longer. This includes no change
to whether data in the attribute groups and attributes can be modified.

These arrays of pointers to attribute groups are used in calls to
sysfs_create_groups() and device_add_groups(), e.g. from create_dir()
for kobject's, and from device_add_attrs().
And sysfs_create_groups() and device_add_groups() are changed accordingly
in this series.

Does this answer your question?

> 
> Thomas
> 
>>  	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
>>  	const void *(*namespace)(const struct kobject *kobj);
>>  	void (*get_ownership)(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);


