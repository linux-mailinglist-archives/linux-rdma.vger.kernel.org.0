Return-Path: <linux-rdma+bounces-16510-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJYfLgoXg2mKhgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16510-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:53:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207FE41D9
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CDAE3043D47
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF833B8D72;
	Wed,  4 Feb 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TwAO/UPJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BA3B8D5B
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198721; cv=none; b=p2KOYoZtqaQRJhHIb7IKC0nSVaCqCevpfE5VvkbJ6V2QsvcdK4JY0hB7j6vHmpaBXqvM55czYOU0+xwc6e4x09X3A/aqELy3zPJb3PL7Lx5Ly3lKwBZpfHVlLK/aA4M+f0n3wK45qxGQQAqYV/LTArIOFSV/AzixZEhfsS2SMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198721; c=relaxed/simple;
	bh=8hDLDbF72dr7b/O4Zo0ApKCVlf3BYvSzKKhomnUdGFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGpiwWJvFsHO32h5QMKnQGjbC+TP8o1fSpKCBtuwN7UAXKcVbHag2dJ1QjIzqTQfiMdE78mX4E4ED2UvhFP6fV2GyQydGgYHkLazebp7BzpQnUBzlTPjYXF7asOK5FNJoA7RTzu5OAFVl+oI7YtGpol8U9XMNxx02Y8kUB+6P3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TwAO/UPJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432d28870ddso331350f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 01:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770198718; x=1770803518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGP603QDqaJG/dpPYsMG8GNhu8nGqxt3dyDV5ITQFhU=;
        b=TwAO/UPJHfH8/0kLBF6V9c6SiQn6pzA0ohafydvmLqYpFsNd0dNjbP5nnlpGo5RCGT
         TWXzypiVOeZ+1EHrx1CyH5XxjWsCKVs6WMQKRO0zQ4KVhpdUUZeFT07eezOYwrix6uXr
         141ZtOR84lWvNw4y8rbWcbL871IXHuRJD68UrKZPeFM8rv+PTEhr+2JwS0D541PcJRu0
         yeardM6mH9Uq15CVJ5VAho5ogy0mjNVnoSX3ux/fQV+quOAspFtMymX8pewOyk2jscTZ
         pZ0PeDCK5CnXS1JAazN49NGdcLCX7pSLpgnR9J24EPvR2RtHkmSmMxHL5QujC/Iaa7KF
         Qq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770198718; x=1770803518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGP603QDqaJG/dpPYsMG8GNhu8nGqxt3dyDV5ITQFhU=;
        b=YVSMg1r/jb5Ws28YJznsJHCtfIQErNKkNo85x+ZZ8yiKBYL83IOwcoHCf5q+p8at8A
         0oac+nCYGs01MOmtTiKi7VxOsl6ADq8QuhWN2JNMPNoi1MGmkXURtXWsefKyp8lrDwuP
         pVnsgsaMeSU06AlruAhtAoVvposanJorLuPXhyclR5O0ZxpxNoR9Y/N5t9gHxr4oK1a8
         NQlaaL5Ym/25sERNgoNXroTKKWnMPrcRKgjJrUI/lL/J0FzBzbXPHi70p+3umg1ZCbZE
         vgD8XeGIzqNK7vaU/eL0dBTnzb6mTvkmVvLKabl9AQBvfrOIlDFv3B2HBDoQQSDSuMOO
         1Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCXi0msYIMZzmnclpEbqitiPEW4ua2X1emsMNHz7yJfiJIDGy/5usOhuYnR5ARhQReLanjt5oJKp1u9R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2NFqJaTMInSXBzCgeEBb/B3NNlMXlpwJVEcvGlLzyCbabPzdI
	jREveoyNluMMCZR9yoklFzkqdtCfDMmznom6mma+Olg8RGam0vbw8MJ57xMdPSZrt7E=
X-Gm-Gg: AZuq6aK8dYVr50Hq1dTH1Rf6PGOvOUx69v1zxdFROR6EbTjKD9sJZlpaHtjbIHsoM9r
	vXHwLnJiBOM0sp13lI8kbF3TY+5aX35+buqlVYicv/JyvMDIhjgINLUCzxvmRXWG2WagBLeYeQo
	HCXlDXClstwc2bfJ1Zz4NFHXX40AJMiztKaKUDLIK+dTP4SJ0rGnGE90cb3Wujff/i5cfxzOXg8
	QGXa7JK6AFFokjRF1djjLyAn0MNgdoSxGdFqz4IMbuuC+WzJXnVq6yRL/1abXNy0JS2WXkUnatF
	78x4mzeUJj0S0yMNMzbiUU1AYs7CzA/mvuakkJ82TTduU7gXbKKrh47yK4RlhRHd5bO4uYr+lzG
	mwQEVxSro4x0HPmldhUuxwMndrkPid1hc4ZfbJHgTtSgqSuymZsQVlJULrJyhJybppAfnOxRr2V
	5RU8kuVQSUkKDPZThWJRc=
X-Received: by 2002:a05:6000:40d9:b0:435:a370:2d7a with SMTP id ffacd0b85a97d-43618053444mr3194322f8f.36.1770198717973;
        Wed, 04 Feb 2026 01:51:57 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805edcfsm5124440f8f.35.2026.02.04.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:51:57 -0800 (PST)
Date: Wed, 4 Feb 2026 10:51:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next 1/5] devlink: Add port-level resource
 infrastructure
Message-ID: <rye7fponvzxqbeexkreuxwvjlder34vfkofib4gwrhkbw3vres@udo2xxeek6xv>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203071033.1709445-2-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16510-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2207FE41D9
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 08:10:29AM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>The current devlink resource infrastructure only supports device-level
>resources. Some hardware resources are associated with specific ports
>rather than the entire device, and today we have no way to show resource
>per-port.
>
>Add support for registering and querying resources at the port level,
>allowing drivers to expose per-port resource limits and usage.
>
>Example output:
>
>  $ devlink port resource show
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>  pci/0000:03:00.1/262144:
>    name max_SFs size 20 unit entry
>
>  $ devlink port resource show pci/0000:03:00.0/196608
>  pci/0000:03:00.0/196608:
>    name max_SFs size 20 unit entry
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> Documentation/netlink/specs/devlink.yaml |  23 ++
> include/net/devlink.h                    |   8 +
> include/uapi/linux/devlink.h             |   2 +
> net/devlink/netlink.c                    |   2 +-
> net/devlink/netlink_gen.c                |  32 ++-
> net/devlink/netlink_gen.h                |   6 +-
> net/devlink/port.c                       |   3 +
> net/devlink/resource.c                   | 282 ++++++++++++++++++-----
> 8 files changed, 301 insertions(+), 57 deletions(-)

Way too big for a single patch. Could you split it in logical chunks
please?


>
>diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>index 837112da6738..0290db1b8393 100644
>--- a/Documentation/netlink/specs/devlink.yaml
>+++ b/Documentation/netlink/specs/devlink.yaml
>@@ -2336,3 +2336,26 @@ operations:
>             - bus-name
>             - dev-name
>             - port-index
>+
>+    -
>+      name: port-resource-get

Why this is not aligned with DEVLINK_CMD_RESOURCE_* ?
$ git grep CMD_RESOURCE_ include/uapi/linux/devlink.h
include/uapi/linux/devlink.h:   DEVLINK_CMD_RESOURCE_SET,
include/uapi/linux/devlink.h:   DEVLINK_CMD_RESOURCE_DUMP,

I'm aware that DEVLINK_CMD_RESOURCE_DUMP only implements "do" now, but I
think both should be named the same, no?


>+      doc: Get port resources.
>+      attribute-set: devlink
>+      dont-validate: [strict]
>+      do:
>+        pre: devlink-nl-pre-doit-port
>+        post: devlink-nl-post-doit
>+        request:
>+          value: 85
>+          attributes: *port-id-attrs
>+        reply: &port-resource-get-reply
>+          value: 85
>+          attributes:
>+            - bus-name
>+            - dev-name
>+            - port-index
>+            - resource-list
>+      dump:
>+        request:
>+          attributes: *dev-id-attrs
>+        reply: *port-resource-get-reply

[...]


>-int devl_resource_register(struct devlink *devlink,
>-			   const char *resource_name,
>-			   u64 resource_size,
>-			   u64 resource_id,
>-			   u64 parent_resource_id,
>-			   const struct devlink_resource_size_params *size_params)
>+static int
>+devl_resource_reg_by_list(struct devlink *devlink,


can't this be "register"?

Also, why "by_list"? Sounds odd. Could you perhaps have it as
__devl_resource_register(). That's the usual pattern for similar
functions here, isn't it?

Also, could you do this "list" abstraction in a separate patch?



>+			  struct list_head *res_list_head,
>+			  const char *resource_name, u64 resource_size,
>+			  u64 resource_id, u64 parent_res_id,
>+			  const struct devlink_resource_size_params *params)
> {
> 	struct devlink_resource *resource;
> 	struct list_head *resource_list;
>@@ -341,9 +344,10 @@ int devl_resource_register(struct devlink *devlink,
> 
> 	lockdep_assert_held(&devlink->lock);
> 
>-	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
>+	top_hierarchy = parent_res_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
> 
>-	resource = devlink_resource_find(devlink, NULL, resource_id);
>+	resource = devlink_resource_find_by_list(res_list_head, NULL,
>+						 resource_id);
> 	if (resource)
> 		return -EEXIST;
> 
>@@ -352,15 +356,15 @@ int devl_resource_register(struct devlink *devlink,
> 		return -ENOMEM;
> 
> 	if (top_hierarchy) {
>-		resource_list = &devlink->resource_list;
>+		resource_list = res_list_head;
> 	} else {
>-		struct devlink_resource *parent_resource;
>+		struct devlink_resource *parent_res;
> 
>-		parent_resource = devlink_resource_find(devlink, NULL,
>-							parent_resource_id);
>-		if (parent_resource) {
>-			resource_list = &parent_resource->resource_list;
>-			resource->parent = parent_resource;
>+		parent_res = devlink_resource_find_by_list(res_list_head, NULL,
>+							   parent_res_id);
>+		if (parent_res) {
>+			resource_list = &parent_res->resource_list;
>+			resource->parent = parent_res;
> 		} else {
> 			kfree(resource);
> 			return -EINVAL;
>@@ -372,46 +376,78 @@ int devl_resource_register(struct devlink *devlink,
> 	resource->size_new = resource_size;
> 	resource->id = resource_id;
> 	resource->size_valid = true;
>-	memcpy(&resource->size_params, size_params,
>-	       sizeof(resource->size_params));
>+	memcpy(&resource->size_params, params, sizeof(resource->size_params));
> 	INIT_LIST_HEAD(&resource->resource_list);
> 	list_add_tail(&resource->list, resource_list);
> 
> 	return 0;
> }
>+
>+/**
>+ * devl_resource_register - devlink resource register
>+ *
>+ * @devlink: devlink
>+ * @resource_name: resource's name
>+ * @resource_size: resource's size
>+ * @resource_id: resource's id
>+ * @parent_resource_id: resource's parent id
>+ * @params: size parameters
>+ *
>+ * Generic resources should reuse the same names across drivers.
>+ * Please see the generic resources list at:
>+ * Documentation/networking/devlink/devlink-resource.rst
>+ *
>+ * Return: 0 on success, negative error code otherwise.
>+ */
>+int devl_resource_register(struct devlink *devlink, const char *resource_name,
>+			   u64 resource_size, u64 resource_id,
>+			   u64 parent_resource_id,
>+			   const struct devlink_resource_size_params *params)
>+{
>+	return devl_resource_reg_by_list(devlink, &devlink->resource_list,
>+					      resource_name, resource_size,
>+					      resource_id, parent_resource_id,
>+					      params);
>+}

[...]

