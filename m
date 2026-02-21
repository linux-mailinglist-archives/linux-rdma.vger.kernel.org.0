Return-Path: <linux-rdma+bounces-17044-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH8GNL6ymWn3WAMAu9opvQ
	(envelope-from <linux-rdma+bounces-17044-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 14:27:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58716CE90
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 14:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A16353015C80
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B711B4F0A;
	Sat, 21 Feb 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="k9ahXrda"
X-Original-To: linux-rdma@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D317A2FA;
	Sat, 21 Feb 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771680440; cv=none; b=PmdQPXHXDVPhoKx6PpVCwJQpDuVb8iGuRxeHraIJowbdpAAoPZ6eQpquuLMcrUptJWEU42j5FFePusOXmVGupgwr9ESFNmdOVk6345CrMgZkuZ0CNH2TBOLmMUp716kPwi2ena0mDFuoP2ncFqyfQck2AVi9bJv8eRYwKm01yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771680440; c=relaxed/simple;
	bh=+RLhKizSUU0RD82hH4IJ3BEYEuDBffSzSEqmHdM/tjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwuZS1K5JcG6izAHq7CHSSwxJQRVFPBNI5OCoOKy1ONlwfJnobnxehCcxHrdl0+EF4933Y575vBOfrrzyH0pYerypiaY9WUTyZ95AR5yd/NKNAQ24baBgfQeq0z/zICKK5SxDbCrfqsUD5YmRA/flDtn//WJETQ0XHCjiCJzCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=k9ahXrda; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771680430;
	bh=+RLhKizSUU0RD82hH4IJ3BEYEuDBffSzSEqmHdM/tjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9ahXrdaR+dTDJ3SEmQ6t2D6DQDuE9fH2bWPRdwz5XAUa5/OICpXn+PeHCNLtUN7k
	 nBdSLAgXpeJ9ZvtK4u6DLa2aSbgxtJUh+2Ac+h0s7PgPyoUo5y9fjsWJy1R0S5LciR
	 in7sfp35zZLzcjHj7FXnhIZjmrExZKMzL5RinId4=
Date: Sat, 21 Feb 2026 14:27:09 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Heiner Kallweit <hkall@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, driver-core@lists.linux.dev, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH RFC 10/10] kobject: make struct kobject member
 default_groups a constant array
Message-ID: <f18e8c2f-28b0-4905-87c2-a16dd54c53d1@t-8ch.de>
References: <5d0951ec-42c9-453f-9966-ecca593c4153@kernel.org>
 <04c85242-dc51-4ddf-9920-4dab57f2498f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c85242-dc51-4ddf-9920-4dab57f2498f@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17044-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t-8ch.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D58716CE90
X-Rspamd-Action: no action

Hello Heiner,

On 2026-02-17 23:32:46+0100, Heiner Kallweit wrote:
> Constify the default_groups array, allowing to assign constant arrays.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

(The patch author/From header and Signed-off-by line do not match)

> ---
>  include/linux/kobject.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index c8219505a79..e45ee843931 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -116,7 +116,7 @@ char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
>  struct kobj_type {
>  	void (*release)(struct kobject *kobj);
>  	const struct sysfs_ops *sysfs_ops;
> -	const struct attribute_group **default_groups;
> +	const struct attribute_group *const *default_groups;

Thanks for working on this!

Personally I try to constify the attribute structures together with
their corresponding callbacks. This ensures that no structure is
constified which its callback then tries to modify.
Currently there is no support for const arguments to the callbacks of
'struct kobj_attribute' and 'struct device_attribute'. I am wondering
if the changes to kobject and device groups should be kept out for now
and be added together with the support for their const callback arguments.


Thomas

>  	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
>  	const void *(*namespace)(const struct kobject *kobj);
>  	void (*get_ownership)(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);

