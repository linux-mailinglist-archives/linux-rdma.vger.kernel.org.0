Return-Path: <linux-rdma+bounces-17811-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEd4MNUur2lzPQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17811-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:34:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D2240DE0
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C586A309D1BD
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BF36921A;
	Mon,  9 Mar 2026 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDFTzcRm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03B363C59;
	Mon,  9 Mar 2026 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088424; cv=none; b=h4LsDOGmT93Xe616fj9y2ol/m0wHZvz8tkkzSqdU+kM9zMx1aaqtdK5/EuAIeYWe/0y412QF3wpeBFsVxKIokJ8lgjPotbhGqjbscwotVLD993d9cKf864ymnxjofDTTCEEB9PwMwjtuMTPnNxTniep9Kv38lyphPWSk8EZTZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088424; c=relaxed/simple;
	bh=EsTuTbdfOLC/KrXdDn24+hpQTzkmO4TkWsWQSHqaRI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAT9xwzCEi02a3hUCJniYNJim07umCY9ZHG10KlUEUjo584wFgKssSQlUy4rkrmlckIc0auV2xSgsBBjUb0/dW/wC5U69HtOG6PlCxzLEFFhNr99g1PiX1uS+yNywZLj9PxWsFF6jIGCFC1TtqxVeK0OjHZqDzJQVWoY/2Xuo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDFTzcRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3877C4CEF7;
	Mon,  9 Mar 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773088424;
	bh=EsTuTbdfOLC/KrXdDn24+hpQTzkmO4TkWsWQSHqaRI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GDFTzcRmgpdtAIhIGCK9SYQFVJW0ASpp0dgPvYj4E4WzHIBDuS1ZUvyvgd5WaPp9X
	 olB4xswNEROOEiEvjtrDNA7XrR8L6hNKR8TMogiUH40mtnsTUHNRKOxGPUq6pRHgZk
	 LeV/H0FjU3PmwjdsPOk3B+epADqzmCWxeNQh+mI/PA/HUFi4ZO+TBFwqbrEKIuL2DG
	 CwkMZb79NjrsgfA4rYOYBLqdHV4q1oRtE0eEh8bAUUkBE57/IshkFY90CdU/n2cjVB
	 1Fcub+/lvaTfFmZBypDPIbuicKc+Mm5YHw0bXgWEO/F1HJKRfMKXu0BhoWMkn37euc
	 iSAyGl/9C95UQ==
Date: Mon, 9 Mar 2026 13:33:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Or Har-Toov <ohartoov@nvidia.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Tariq Toukan <tariqt@nvidia.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource
 support
Message-ID: <20260309133341.7e08b35d@kernel.org>
In-Reply-To: <74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
	<20260302192640.49af074f@kernel.org>
	<pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
	<jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
	<20260304101522.09da1f58@kernel.org>
	<np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
	<20260305063729.7e40775d@kernel.org>
	<ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
	<20260306120301.0ebe1ab2@kernel.org>
	<74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 728D2240DE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17811-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, 8 Mar 2026 18:03:11 +0200 Or Har-Toov wrote:
> Do you mean that we will register resources per port, but not show with 
> new devlink port resource show.
> Instead, the current devlink resource show dev command will also display 
> the ports of that device?
> 
> For example:
> 
> $ devlink resource show pci/0000:03:00.0
>    pci/0000:03:00.0:
>      name local_max_SFs size 40 unit entry
>    pci/0000:03:00.0/196608:
>       name max_SFs size 20 unit entry
>    pci/0000:03:00.0/196609:
>       name max_SFs size 20 unit entry
> 
> Or should we keep the current behavior where devlink resource show dev 
> displays only device-level resources, and only the full dump shows both 
> devices and their ports?
> 
> For example:
> 
> $ devlink resource show
>    pci/0000:03:00.0:
>      name local_max_SFs size 40 unit entry
>    pci/0000:03:00.0/196608:
>       name max_SFs size 20 unit entry
>    pci/0000:03:00.0/196609:
>       name max_SFs size 20 unit entry
>    pci/0000:03:00.1:
>      name local_max_SFs size 40 unit entry
>    pci/0000:03:00.1/196608:
>       name max_SFs size 20 unit entry
>    pci/0000:03:00.1/196609:
>       name max_SFs size 20 unit entry
> 
> Want to confirm which behavior you meant.

No strong preference on the CLI. For the kernel I think specifying 
the device should not exclude the port resources. Whether port
resources are shown or not should be entirely up to the mask attribute.

Thinking about this some more after my last reply to Jiri I think we
should add that mask attribute to let user decide whether they want
only the device resources, port resources or both. This will retain
the exact functionality of the series.

On the CLI "devlink resource show" should show all resources in the
system IMO. How we define the CLI arguments to scope things down I don't
have a strong opinion on.

