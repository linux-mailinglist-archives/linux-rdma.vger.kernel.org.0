Return-Path: <linux-rdma+bounces-17341-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDznNgVzo2lwDQUAu9opvQ
	(envelope-from <linux-rdma+bounces-17341-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 23:58:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0861C9949
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 23:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 651D0301BA5F
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27EB3E0C49;
	Sat, 28 Feb 2026 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8djPi+J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639FF350A18;
	Sat, 28 Feb 2026 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772319487; cv=none; b=clvTvnIyIbW4E/rU9SDE3PwGrKyUf7w4ziAsNfWwvbq2FLgw2BGsiAx0KB1xIHpXoegZ415xnAsE2iJkHUGGUGA16Z6mnarutioncPUNBhyLr6b7fH82kan0xQstZ8SzBSd7ImZzqwfGWmZvCNEWwph9VU4Y22A0JwFUiKdwM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772319487; c=relaxed/simple;
	bh=WRdJLC1P1yRc1GsQW80vZGJVXPyI9MUjfQVr8YsKMrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2BXu/RCBj3BkENf6m9zwUxyYp8UGXqHrAFTDuSuaU+yhkYYGBjBZSdap7OqXmLEqy4e+DOnfLsHVvzIvgCcLx6KxSc1GBBxW3VqlLCnNpEWarbWbcpBPUYtvZVdqJIHrm7W2MyUiGFTYiCzeW0mglNKlTilZi3kcVSaU+LzS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8djPi+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF90C116D0;
	Sat, 28 Feb 2026 22:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772319487;
	bh=WRdJLC1P1yRc1GsQW80vZGJVXPyI9MUjfQVr8YsKMrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8djPi+JyrgZKiCcQtCdXEPSjdOY9EJfXypKuEuwmoz4SzQSuWrQ92dlI5Uk/IAq9
	 H2Z5I4p9YQ+2utd/S/qGft8MjJhOeN5r5IbCVeYni/Pd5UlLpwMZ9fT054wHEpgbrr
	 9rIsD05sQHpwgHirbb5v7LzDmxq8osbUF+zxQJzg1onaONu0oeDBM4wwgRRQgs5ISv
	 FuLR8l2Pg/gCVV5D9xsQf0o41vgAI4k3nfXXRZ5i5ds6ntiqBTm/sCi0/+odmOUe62
	 9GIBVTbH5VphKrCPZsNI5ERTpdQEg5Fx8pgTqRNH+p6CNj8acNfXEx/0HihYLRpY2g
	 krw1SaI9Ayj/w==
Date: Sat, 28 Feb 2026 14:58:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, skhan@linuxfoundation.org, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 przemyslaw.kitszel@intel.com, mschmidt@redhat.com, andrew+netdev@lunn.ch,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com,
 daniel.zahka@gmail.com, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/10] devlink: add
 devlink_dev_driver_name() helper and use it in trace events
Message-ID: <20260228145805.758ff8c0@kernel.org>
In-Reply-To: <20260225133422.290965-7-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
	<20260225133422.290965-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17341-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F0861C9949
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 14:34:18 +0100 Jiri Pirko wrote:
> +const char *devlink_dev_driver_name(const struct devlink *devlink)
> +{
> +	struct device *dev = devlink->dev;
> +
> +	return dev ? dev->driver->name : NULL;
> +}
> +EXPORT_SYMBOL_GPL(devlink_dev_driver_name);

You say we need this in prep for shared instances, which is fair, but
shared instances should presumably share across the same driver, most
of the time? So perhaps we should do a similar thing here as you did to
the bus/dev name? Maybe when shared instance is allocated:

	devlink->driver_name = kasprintf("%s+", dev->driver);

And then:

+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	struct device *dev = devlink->dev;
+
+	return dev ? dev->driver->name : devlink->driver_name;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);

?

