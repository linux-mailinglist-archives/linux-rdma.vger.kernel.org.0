Return-Path: <linux-rdma+bounces-3029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B63902091
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 13:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3611C20B5A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB650249;
	Mon, 10 Jun 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KC6Bo2p0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD915B3
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019950; cv=none; b=IzAFddbn0rIHmYT7o80Yrk4WCI9ZmSYFVXNUl5/FZps1vKSv1h/jsc+u4E+riT/Zict0wTavMPnH4OOhGhmBbuJeuM29Neo7uLiJQUuY6uhyh/Rgj4BSS1I3uCgTfMHC44igZyhJLRbre4pBh3TTMLxc4ZzDXGyPm4AerCZxTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019950; c=relaxed/simple;
	bh=uRYsbBgcGGKRGIH+21VLi63gGz4IOiSJ+y+PJZS3Db4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m62rXeY/0ZWrGcQt1Lm/xxmjAmKHmnR7A+3q6sKmxwDcolU2efU27OM6PIL+dr5bCREUKvVryKxdgeCq7YsNa7ZrkM0Tr6X4UDVzbq78ypFu5M1kqTTCVMATUWoQmAtXC9iiqWnGHQ7AvbZzUKMYxq9yZGLPn21YDVaEGkOWVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KC6Bo2p0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718019947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8H7+GFYWZt+fqm9LdJrMD4rXPF9PRp7Tx2xQ1dLcOwE=;
	b=KC6Bo2p0hS9RYYqJAR4PyoP0Or55V7cFA+KBDPZ2kflkN1/uCwpPC/rYQ0rFrViY0eWWkv
	rwdkW+1fR1dEAmPcoTRDqdN7d7Hwb1B93W45CZYL9lwzU+7CthSaqCz8cZuq4aE1mEY/7M
	5fUBUNRBHGxGe/7ZDL3EFj6uOQy9oFY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-kv8X1yWmOZW3CR4Uf6hZyg-1; Mon,
 10 Jun 2024 07:45:41 -0400
X-MC-Unique: kv8X1yWmOZW3CR4Uf6hZyg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36A3B19560B4;
	Mon, 10 Jun 2024 11:45:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C24EC1956087;
	Mon, 10 Jun 2024 11:45:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 72B7B21E681D; Mon, 10 Jun 2024 13:45:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <peterx@redhat.com>,  <yu.zhang@ionos.com>,
  <mgalaxy@akamai.com>,  <elmar.gerdes@ionos.com>,
  <zhengchuan@huawei.com>,  <berrange@redhat.com>,  <armbru@redhat.com>,
  <lizhijian@fujitsu.com>,  <pbonzini@redhat.com>,  <mst@redhat.com>,
  <xiexiangyou@huawei.com>,  <linux-rdma@vger.kernel.org>,
  <lixiao91@huawei.com>,  <jinpu.wang@ionos.com>,  Jialin Wang
 <wangjialin23@huawei.com>
Subject: Re: [PATCH 1/6] migration: remove RDMA live migration temporarily
In-Reply-To: <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
	(Gonglei's message of "Tue, 4 Jun 2024 20:14:07 +0800")
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
	<1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
Date: Mon, 10 Jun 2024 13:45:35 +0200
Message-ID: <878qzdqaw0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Gonglei <arei.gonglei@huawei.com> writes:

> From: Jialin Wang <wangjialin23@huawei.com>
>
> The new RDMA live migration will be introduced in the upcoming
> few commits.
>
> Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index a351fd3714..4d7d49bfec 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -210,9 +210,9 @@
>  #
>  # @setup-time: amount of setup time in milliseconds *before* the
>  #     iterations begin but *after* the QMP command is issued.  This is
> -#     designed to provide an accounting of any activities (such as
> -#     RDMA pinning) which may be expensive, but do not actually occur
> -#     during the iterative migration rounds themselves.  (since 1.6)
> +#     designed to provide an accounting of any activities which may be
> +#     expensive, but do not actually occur during the iterative migration
> +#     rounds themselves.  (since 1.6)

I guess the new RDMA migration code will not do RDMA pinning.  Correct?

>  #
>  # @cpu-throttle-percentage: percentage of time guest cpus are being
>  #     throttled during auto-converge.  This is only present when
> @@ -378,10 +378,6 @@
>  #     for certain work loads, by sending compressed difference of the
>  #     pages
>  #
> -# @rdma-pin-all: Controls whether or not the entire VM memory
> -#     footprint is mlock()'d on demand or all at once.  Refer to
> -#     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
> -#
>  # @zero-blocks: During storage migration encode blocks of zeroes
>  #     efficiently.  This essentially saves 1MB of zeroes per block on
>  #     the wire.  Enabling requires source and target VM to support
> @@ -476,7 +472,7 @@
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> +  'data': ['xbzrle', 'auto-converge', 'zero-blocks',
>             'events', 'postcopy-ram',
>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>             'release-ram',

I guess you remove @rdma-pin-all, because it makes no sense with the new
migration code.  However, this is an incompatible change.

Here's the orderly way to remove it:

1. Document it doesn't do anything anymore, and deprecate it.

2. Remove after the deprecation grace period (two releases, see
docs/about/deprecated.rst.

> @@ -533,7 +529,6 @@
>  #     -> { "execute": "query-migrate-capabilities" }
>  #     <- { "return": [
>  #           {"state": false, "capability": "xbzrle"},
> -#           {"state": false, "capability": "rdma-pin-all"},
>  #           {"state": false, "capability": "auto-converge"},
>  #           {"state": false, "capability": "zero-blocks"},
>  #           {"state": true, "capability": "events"},

[...]


