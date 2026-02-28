Return-Path: <linux-rdma+bounces-17342-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEDlKdlzo2n9DQUAu9opvQ
	(envelope-from <linux-rdma+bounces-17342-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 00:01:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 084281C997D
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Mar 2026 00:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B5D7301C100
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 23:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DAF3624D1;
	Sat, 28 Feb 2026 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGvDXCIJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F633B6E0;
	Sat, 28 Feb 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772319701; cv=none; b=nkeHZYQRLVqBkWhCXUY0C/SK0p3J1/AZnudund0hoq4v9JUH3yOvxn/nnO54F4Bt604soJKc59A20gTEPorbnIxMQ/gjoKHOf7nwc+TtULyjOyfm1Z4E4Fs+HzLLltYGyqV9jOmmrY4Wb2quyT76wxGyjlR6LnYPJOoLTz0tndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772319701; c=relaxed/simple;
	bh=MqqasWg3JHrbA1uVAhFFc1wBQLaZ8HY7uBk+lc+Nkrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmjTLsqfrguTH6ypBk5OIznJ/tI/byaRulEW5stFqQvoQcbdH52Cd8OL4wl0OKj4MifqCNc38ir4lw0S1ZniiAhkNkh/pO9koHO5xaca4+xt9Ig9v81A4nmATDT2pfyd7Y/Q0nFZPB5m1rw6guaivvbY00oxSdd7aO2qR44/VOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGvDXCIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4E7C19421;
	Sat, 28 Feb 2026 23:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772319700;
	bh=MqqasWg3JHrbA1uVAhFFc1wBQLaZ8HY7uBk+lc+Nkrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZGvDXCIJDduIIZnyU29uspufH2o45ggbkmBZrT2xvyIGChc7cwK0kntXm7WY90l3u
	 0smcx42hCwLlDC2PmbrP2V7q8t+APVW8051NBzB0Q8UBQ6HSy10ZVBNHG1aKZlcw59
	 18Ye3WWx8esC7//Ws76NTetm6kKUm1iQKAmwmdm410nrhNThMhFqNzh5rL5CtlCv+9
	 5mDMlrtfKoOULnc/VUGj+JfZVBmSqx6UspFS2/9Kq/m2j/oHS/QVWpSOpY0m0rMod6
	 i0oOnQ6Y1ha2aHuGc1YcEdYHvBRsuLNLsZMolQay4x+jd/jnAMQk/7zqX3AjPVRgWJ
	 wRsWO0cMnjDFA==
Date: Sat, 28 Feb 2026 15:01:38 -0800
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
Subject: Re: [PATCH net-next v2 07/10] devlink: allow devlink instance
 allocation without a backing device
Message-ID: <20260228150138.14e35ee7@kernel.org>
In-Reply-To: <20260225133422.290965-8-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
	<20260225133422.290965-8-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17342-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 084281C997D
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 14:34:19 +0100 Jiri Pirko wrote:
> -	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
> +	if (port->devlink->dev)
> +		dev_warn(port->devlink->dev,
> +			 "Type was not set for devlink port.");

since I'm already nit-picking - maybe we should have a helper for this
case an pr_warn() the message if dev is NULL?

