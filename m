Return-Path: <linux-rdma+bounces-17340-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMj0Etlwo2nMDAUAu9opvQ
	(envelope-from <linux-rdma+bounces-17340-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 23:48:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4741C98E5
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 23:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 208B9300B50B
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2B3D6CC2;
	Sat, 28 Feb 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPcdAixk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08A430B9A;
	Sat, 28 Feb 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318928; cv=none; b=jF7nKBCEYpTORBgeYycgITdzrsbwj0mcXH9NTd4UuxS0hHIpHKtn8jpeBAfWOvu3rzcNH6BP1IiaMaHCK1vsyC4ZXgICckuX0qQWUAfMQRS33kok45W5blm9yNBLteWh/FOiv7eW/mlUIyMT3i/pQgzf+ymT4KKR1uEAExdKKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318928; c=relaxed/simple;
	bh=eQj2q0RyyHpB5QTjS7DyKuJ0V0YvmR5N137wYMSSs4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0sZSBfa94nlUMH7ZevOhz4ooRC9FpDb6uD1MvIlr6UuFgTMMw0aWJv3nbDhkFnK4a19RYUNLuI/DvBmF6olF8O2Ay3UuP8bQ7OhJklfSJkXL6IJEYOzACyS0TXX6EwtIAWuqDZGI+vGnvFHvr2U44GE3YxdeAyAdp9oyf+vpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPcdAixk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B249C116D0;
	Sat, 28 Feb 2026 22:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772318928;
	bh=eQj2q0RyyHpB5QTjS7DyKuJ0V0YvmR5N137wYMSSs4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPcdAixkUHjvsb8X4t9Fk2iCrKouSqVbLLxL4WYUbce8lX86tX4TOMoEdGKU2cGtf
	 6Gg9808DbD6r2DGgKgcAB7TS4xtahzsyvvHW1rLad9YIJ22JxPllMdzxr/FPcjORKX
	 pLBarHIutqBBywwv2CvXMHYemZ/L+XAqvEt5RpOVllZz1qerOkvrmU6x0fTIT8/W3Y
	 AWBqaNDCeGU08OQqMlWF25ZFdNV+y5SmviCZvgEy8dZEzJvBild26fGMqHEqWZK/xZ
	 DNpQFyXUwl0Ai1ODlQWP15Sgzg1a94ppsWHXZjCk8ka5IEveixOtSRZisJbhP0YPGf
	 R52MxuDVp7G+Q==
Date: Sat, 28 Feb 2026 14:48:46 -0800
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
Subject: Re: [PATCH net-next v2 04/10] devlink: allow to use devlink index
 as a command handle
Message-ID: <20260228144846.40f5dfeb@kernel.org>
In-Reply-To: <20260225133422.290965-5-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
	<20260225133422.290965-5-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17340-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D4741C98E5
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 14:34:16 +0100 Jiri Pirko wrote:
> +	if (attrs[DEVLINK_ATTR_INDEX]) {
> +		index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
> +		devlink = devlinks_xa_lookup_get(net, index);
> +		if (!devlink)
> +			return ERR_PTR(-ENODEV);
> +		goto found;
> +	}
> +
>  	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
>  		return ERR_PTR(-EINVAL);

If both INDEX and BUS_NAME + DEV_NAME are provided we should check
that they point to the same device? Or reject user space passing both?

