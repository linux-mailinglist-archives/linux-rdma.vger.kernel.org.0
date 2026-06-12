Return-Path: <linux-rdma+bounces-22156-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uinGJCLhK2qpGwQAu9opvQ
	(envelope-from <linux-rdma+bounces-22156-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 12:36:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A3678B8A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 12:36:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="CC1V4yX/";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22156-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22156-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66D5131B523D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE5D392823;
	Fri, 12 Jun 2026 10:36:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD5367296;
	Fri, 12 Jun 2026 10:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260571; cv=none; b=VDHXC3iLt/3cLR/eMQVcSjv3bBHPAWQkhF/io4F9sqzRkS0d/YyWjvv3xUK+ngq6rH3zJAuUJA54vHJIoMakGEPJtP8r6Cq8+1za3uqgOtbNZd9tm6B2UOZzEI2cfyzPlGxL06xplggwnL3cP54r4bXWgnyxr8yXzux2g1nRc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260571; c=relaxed/simple;
	bh=91FxiJV0N6BmdAmvTdC5cs67r+8PYu041zNku9q03f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5+RXBPLHsIJAnn9v2lPn3hMtoOoXSYXqV8wTapp8dzyCf4usqKuCz3XObg51ka1dczSCXpVUYkaHP+hOX4m2NZ8ARYoc+9IRnpeEPpBwoTFsKPbzpF5hta5jkT3TbaSQqpgZeWVlsO0apypysDJG2jQCZQVFxQc1CyjjmUKTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC1V4yX/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F6E1F000E9;
	Fri, 12 Jun 2026 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781260569;
	bh=O+SMa7id15Wth7GsodU20nw/Xw2vDDaUwg6RH/UuNDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CC1V4yX/m7C0c2G9l1EVCxLTDxtaeL/CQu6ZrHz3tdfM/fEnAw4AMO+Zihb/o+AO0
	 ogQ0l4mvt0YCNo6GJLidH0brquaBFublaY6/Ye7i37aLuswQRGh74skt3pej27hh1Q
	 tP+0YwF8vABMNODWjTOkzSb6VLhi/9XtJfpL0I6sOllhgcEdU+Ds7yY3qYZiB1Pxf3
	 7P5wWz18glxwwRkc5QOxpLvhgPdmF33DWGaAsjBCafLJv5QaBJrnhHcVNIe9PPYnTp
	 EWQqp1+c8gweY0jBgMgnQiRGLzBTkklhHlVHIdr6NUQHeUzDpu/TiqSrYdYzFiTvh4
	 r9CnfvBFTaiOw==
Date: Fri, 12 Jun 2026 11:35:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org, Jean Delvare
 <jdelvare@suse.com>, Tzung-Bi Shih <tzungbi@kernel.org>, Brian Norris
 <briannorris@chromium.org>, Julius Werner <jwerner@chromium.org>,
 chrome-platform@lists.linux.dev, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org (open list), linux-iio@vger.kernel.org, Randy
 Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: ABI: fix brackets and bracelets
Message-ID: <20260612113559.1675cb66@jic23-huawei>
In-Reply-To: <20260612074916.169195-3-manuelebner@mailbox.org>
References: <20260612074916.169195-3-manuelebner@mailbox.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:jgg@nvidia.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:jdelvare@suse.com,m:tzungbi@kernel.org,m:briannorris@chromium.org,m:jwerner@chromium.org,m:chrome-platform@lists.linux.dev,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-iio@vger.kernel.org,m:rdunlap@infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jic23@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22156-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mailbox.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E28A3678B8A

On Fri, 12 Jun 2026 09:49:18 +0200
Manuel Ebner <manuelebner@mailbox.org> wrote:

> Fix missing and needless brackets and bracelets.
> Fix minor grammar issues.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
I guess I was unclear in my v1 review. This needs to be split up by subsystem
to which a patch applies.  Each change will probably take a different route to
upstream as other changes in these files that may clash will generally be routed
via the appropriate subsystem.

The two IIO files can be one patch, but others should all be one
patch per file touched.

Thanks,

Jonathan

> ---
> [v1] -> [v2]
> change from removing single bracket to adding missing bracket
> add recipients
>  Thanks Jonathan for researching the e-mail addresses.
> use proper english punctuation in changelog
> "is 64 bit counter" -> "is a 64-bit counter"
> 
> ---
>  Documentation/ABI/stable/sysfs-class-infiniband      |  8 ++++----
>  Documentation/ABI/testing/sysfs-bus-iio              | 10 +++++-----
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192   |  2 +-
>  Documentation/ABI/testing/sysfs-firmware-dmi-entries |  2 +-
>  Documentation/ABI/testing/sysfs-firmware-gsmi        |  2 +-
>  Documentation/ABI/testing/sysfs-uevent               |  2 +-
>  6 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
> index 694f23a03a28..7ba116103429 100644
> --- a/Documentation/ABI/stable/sysfs-class-infiniband
> +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> @@ -148,17 +148,17 @@ Description:
>  		**Data info**:
>  
>  		port_xmit_data: (RO) Total number of data octets, divided by 4
> -		(lanes), transmitted on all VLs. This is 64 bit counter
> +		(lanes), transmitted on all VLs. This is a 64-bit counter
>  
>  		port_rcv_data: (RO) Total number of data octets, divided by 4
> -		(lanes), received on all VLs. This is 64 bit counter.
> +		(lanes), received on all VLs. This is a 64-bit counter.
>  
>  		port_xmit_packets: (RO) Total number of packets transmitted on
>  		all VLs from this port. This may include packets with errors.
> -		This is 64 bit counter.
> +		This is a 64-bit counter.
>  
>  		port_rcv_packets: (RO) Total number of packets (this may include
> -		packets containing Errors. This is 64 bit counter.
> +		packets containing Errors). This is a 64-bit counter.
>  
>  		link_downed: (RO) Total number of times the Port Training state
>  		machine has failed the link error recovery process and downed
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d8d6d85235b0..4ea5598e7cd2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -917,7 +917,7 @@ Description:
>  
>  		Note the driver will assume the last p events requested are
>  		to be enabled where p is how many it supports (which may vary
> -		depending on the exact set requested. So if you want to be
> +		depending on the exact set requested). So if you want to be
>  		sure you have set what you think you have, check the contents of
>  		these attributes after everything is configured. Drivers may
>  		have to buffer any parameters so that they are consistent when
> @@ -973,7 +973,7 @@ Description:
>  
>  		Note the driver will assume the last p events requested are
>  		to be enabled where p is however many it supports (which may
> -		vary depending on the exact set requested. So if you want to be
> +		vary depending on the exact set requested). So if you want to be
>  		sure you have set what you think you have, check the contents of
>  		these attributes after everything is configured. Drivers may
>  		have to buffer any parameters so that they are consistent when
> @@ -1528,9 +1528,9 @@ Description:
>  		the unused bits, so to get a clean value the bits value must be
>  		used to mask the buffer output value appropriately. The storagebits
>  		value also specifies the data alignment. So s48/64>>2 will be a
> -		signed 48 bit integer stored in a 64 bit location aligned to a 64
> -		bit boundary. To obtain the clean value, shift right 2 and apply a
> -		mask to zero the top 16 bits of the result.
> +		signed 48-bit integer stored in a 64-bit location aligned to a
> +		64-bit boundary. To obtain the clean value, shift right 2 and apply
> +		a mask to zero the top 16 bits of the result.
>  		For other storage combinations this attribute will be extended
>  		appropriately.
>  
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> index 28be1cabf112..d44eb5f8728b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -16,7 +16,7 @@ Description:
>  		In bridge applications, such as strain gauges and load cells,
>  		the bridge itself consumes the majority of the current in the
>  		system. To minimize the current consumption of the system,
> -		the bridge can be disconnected (when it is not being used
> +		the bridge can be disconnected (when it is not being used)
>  		using the bridge_switch_en attribute.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
> diff --git a/Documentation/ABI/testing/sysfs-firmware-dmi-entries b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
> index b6c23807b804..ed7d9d06a9ff 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-dmi-entries
> +++ b/Documentation/ABI/testing/sysfs-firmware-dmi-entries
> @@ -93,7 +93,7 @@ Description:
>  		  /sys/firmware/dmi/entries/15-0/system_event_log
>  
>  		and has the following attributes (documented in the
> -		SMBIOS / DMI specification under "System Event Log (Type 15)":
> +		SMBIOS / DMI specification under "System Event Log (Type 15)"):
>  
>  		- area_length
>  		- header_start_offset
> diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi b/Documentation/ABI/testing/sysfs-firmware-gsmi
> index 7a558354c1ee..3b3c3ae6f458 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-gsmi
> +++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
> @@ -19,7 +19,7 @@ Description:
>  		/sys/firmware/gsmi/vars:
>  
>  			This directory has the same layout (and
> -			underlying implementation as /sys/firmware/efi/vars.
> +			underlying implementation) as /sys/firmware/efi/vars.
>  			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
>  			for more information on how to interact with
>  			this structure.
> diff --git a/Documentation/ABI/testing/sysfs-uevent b/Documentation/ABI/testing/sysfs-uevent
> index 0b6227706b35..c15e18c47a0e 100644
> --- a/Documentation/ABI/testing/sysfs-uevent
> +++ b/Documentation/ABI/testing/sysfs-uevent
> @@ -8,7 +8,7 @@ Description:
>  
>                  Recognized extended format is::
>  
> -			ACTION [UUID [KEY=VALUE ...]
> +			ACTION [UUID [KEY=VALUE ...]]
>  
>                  The ACTION is compulsory - it is the name of the uevent
>                  action (``add``, ``change``, ``remove``). There is no change


