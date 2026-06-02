Return-Path: <linux-rdma+bounces-21606-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E9+Dvk+Hmq/iAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21606-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 04:24:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E27627318
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 04:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B011E3008097
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196F360EC9;
	Tue,  2 Jun 2026 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NporWwG6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F22BFC7B;
	Tue,  2 Jun 2026 02:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367091; cv=none; b=YAYGXAy+WsllHV0WWV08ZtRhENIIem+sCc6380nLZBZSKF2Ck51oaYAOSzp3RUSk3uaQfKhrpwaKcYbzxAEBz2qd55Ls2QscQSNzv4DBRt7aIUVIb3Qa2WbegTNlecbiGvEkpNV30ENtuFTFKEG6ZiQISjQIIT7i2np0748BpDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367091; c=relaxed/simple;
	bh=6KazbM6n0OiSP53uvo9QSRJ+3UJacCU9VCsLGMMdfO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4F2JM6iYHoxV6Qez5dM4VkfHet5Q3mCSwqITtNps5Eg3g2UDsslW4htCkC25Nj+PWjuvJ6EXMYCY4vRKt08PssowQOICOb+7gCA7RNu+5aBnxGAJqMOjGQmbaWA5llDA4VxzWHXY4zosn3vB+CNs2R/Xx/i9TYUKTF/XkhRVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NporWwG6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D81F00893;
	Tue,  2 Jun 2026 02:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367089;
	bh=CCDZVn3OdV0xCjNZpQTfwvEq8Unt4yFUJjgzpgSVfgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NporWwG6Za0FfScH4KAwZpW+Pc1YwUaCO+8pC7g563e0taeRJxj0axXT+9iy4WMTR
	 V+UTEN+tLO8CvuSBU9DjgBrNz9C0xO/MOSoBd5HbFDPXzuw6TAP32v5umcfQGmZ3fo
	 gG5dZE+9biyq2XgXxN+50HAowiI5M7NfsVvsEhoMAVr1z9pR8vXVOjZOSJsKlpqbKK
	 Y8hDcXlHxE0bgig4H4VhC4Xi9NaczyeX3E/czb144QEUualRSzHZF1k521hTplgnbM
	 4EtaaCNLznQsw9ov94cx1r+cU4MHTgz/C/4GGg1dQnNkwMcMp1Nr46yLosvbJ5AY05
	 gxVZQiwY9WJ9w==
From: Jakub Kicinski <kuba@kernel.org>
To: achender@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH net-next v2 3/4] selftests: rds: support RDS built as loadable modules
Date: Mon,  1 Jun 2026 19:24:46 -0700
Message-ID: <20260602022446.1634495-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527023423.387792-4-achender@kernel.org>
References: <20260527023423.387792-4-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21606-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,config.sh:url]
X-Rspamd-Queue-Id: 41E27627318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests: rds: support RDS built as loadable modules

This commit removes CONFIG_MODULES=n from the rds selftest config to prevent
unrelated features from being silently dropped. It updates the configuration
check routines to accept options built as either modules or built-in, and
adds support for probing the backing modules.

> diff --git a/tools/testing/selftests/net/rds/rds_run.sh b/tools/testing/selftests/net/rds/rds_run.sh
> index ef16039be1ae5..c16b30dbdd169 100755
> --- a/tools/testing/selftests/net/rds/rds_run.sh
> +++ b/tools/testing/selftests/net/rds/rds_run.sh
[ ... ]
> @@ -93,38 +93,58 @@ check_gcov_conf()
>  	fi
>  }
>  
> +# Checks if a kconfig is enabled (set to =y or =m)
> +# $1: kconfig symbol to check
> +# $2: (optional) module name backing $1
> +#     Ex: check_conf_enabled CONFIG_RDS_TCP rds_tcp
> +#     Modules for configs set to  =m will be probed
> +#     If omitted, only a built-in (=y) config is accepted.
> +# Returns on success.  exits 4 on failure
>  # Kselftest framework requirement - SKIP code is 4.
>  check_conf_enabled() {
> -	if ! grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
> -		echo "selftests: [SKIP] This test requires $1 enabled"
> -		echo "Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel"
> -		exit 4
> +	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
> +		return
>  	fi
> +	if [ -n "${2:-}" ] && grep -x "$1=m" "$kconfig" > /dev/null 2>&1; then
> +		probe_module "$2"
> +		return
> +	fi
> +	echo "selftests: [SKIP] This test requires $1 enabled"
> +	echo "Please run" \
> +	     "tools/testing/selftests/net/rds/config.sh and rebuild the kernel"

[Severity: Medium]
Should tools/testing/selftests/net/rds/config.sh also be updated to
reflect the new module support?

If a user follows these instructions to run config.sh for missing
dependencies, that script still explicitly disables CONFIG_MODULES via
scripts/config --disable CONFIG_MODULES.

Could this undermine the goal of this patch by forcefully disabling modules in
the user's kernel configuration anyway?

> +	exit 4
>  }

