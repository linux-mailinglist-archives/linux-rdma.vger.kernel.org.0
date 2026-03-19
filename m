Return-Path: <linux-rdma+bounces-18404-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AoCCpdZvGlxxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18404-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 21:16:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C702D1FB4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 21:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AEBC301945E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 20:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D5A345751;
	Thu, 19 Mar 2026 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNnvAeJm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5066176ADE;
	Thu, 19 Mar 2026 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951377; cv=none; b=QF21nwNYadjtzsBT7buReQDftOrweUC4ybm/CyT+WyqCd847Gbv2KkGYXR2/uQgulPWCbxnlT/WmWEk6qLnEcnf2TngqH4UE3tz4oGLp2KZ1r5MA9Vj8vlIkMNb8wYvi9tm+PA5wWaLN6jkEMGio1zrw93wrsHVd3xJttq8FXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951377; c=relaxed/simple;
	bh=8UYPyKO83fbJqyTyXYzj0h8fMBqQJMZausCNtVMgxUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e51u3/9oIIKehlGwod92IWknFl/P+hzb5XAE4cOiudYIaC718xWTKun8ZeUCGz4ypLnthTN0lTd3d5xH20VD8pceKB4qQsxrDhDDmDSPH+/UPuD1JsLT7TALBqusjz/8aJrZsq2yDCruliEZNvaMELFolgBpvEZZDPCte6qpSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNnvAeJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8651C19424;
	Thu, 19 Mar 2026 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773951377;
	bh=8UYPyKO83fbJqyTyXYzj0h8fMBqQJMZausCNtVMgxUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNnvAeJmZXQUJyrGkajheXARw3ZQ5Qv4Bg2bPI6R0RNuFNlF6wFjr/dBwnsjPX1tl
	 EQHG15FnJn+crvFfF+cPWdp3AwruqlkKYeYrZdggQedyUf0Eu8NghNKVvpcHI7A9H+
	 V+rNxMT9HwwxcITDZrlUilWR3WCIAUaCo3hG0rw5q46OpuZGTLuBO5+dW7hXQBCM48
	 7QPRjusYlbpjB+Ac1rSRVLxNCDsGHFiN49LPlXVC/taAzSGhmRdQMJnsXJ9tyq9SDa
	 7y6qY6oMtXiZcN0AMOukkvMOpeSljTWbrTVNfzWZSHcKs5esEoEvXc0amRoLrysDvn
	 7pLvmPNxkdazQ==
Date: Thu, 19 Mar 2026 20:16:13 +0000
From: Simon Horman <horms@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
	kuba@kernel.org, linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: Re: [PATCH net-next v2 2/2] selftests: rds: Add -c config option to
 rds/config.sh
Message-ID: <20260319201613.GV1753385@horms.kernel.org>
References: <20260319004618.2577324-1-achender@kernel.org>
 <20260319004618.2577324-3-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319004618.2577324-3-achender@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18404-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3C702D1FB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:46:18PM -0700, Allison Henderson wrote:
> This patch adds a new -c flag to config.sh that enables callers
> to specify the file path of the config they would like to update.
> If no config is specified, the default will be the .config of the
> current directory.
> 
> Signed-off-by: Allison Henderson <achender@kernel.org>

Hi Allison,

Shell checks complains about unquoted variables (SC2086) in this patch.
As the script was previously shellcheck clean it would be nice
to keep it that way.

...

