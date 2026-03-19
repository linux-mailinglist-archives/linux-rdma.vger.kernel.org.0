Return-Path: <linux-rdma+bounces-18403-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEzjMgxZvGkUxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18403-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 21:14:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF52D1F67
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 21:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBFFF300B50F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0AB393DEE;
	Thu, 19 Mar 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAgZkjDA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5914382291;
	Thu, 19 Mar 2026 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951235; cv=none; b=S5BjYftE8Ghe6W6Zpwqv2a+bCn99EBs70k0uZkSobFFOJGlbTaoZ3j7tVko6BgVO0acSrkTl/4QZ16F5pFrD/ejSfJ6tdQU/mEkYAF9qlaZrnUkxrDxOpfDFeq6rTebvZtrpeL0l0YTPApyt38fh9S8Fdp5lkfYCVHl2Fdu7RJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951235; c=relaxed/simple;
	bh=Z0OGo9jp5u16fbxBSyidbk5n0E7mWHKv/eXc9MK3sYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDGGeX0izbQYs1VHdLHkRvmWjj6O/qFP6JHnNHzuDupUiLphWei18IKVNQGdZA00DZjGoTfo9cZkx53YGSDSsZIIoX8GFtUkt2TlcDcB0dhC5x2XdHHCtv5srf0+m4ZhHGJ62YmmikJJiPo6Gu+xDILAL/v61u2eMkpeX11KlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAgZkjDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED3BC19424;
	Thu, 19 Mar 2026 20:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773951235;
	bh=Z0OGo9jp5u16fbxBSyidbk5n0E7mWHKv/eXc9MK3sYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAgZkjDA0EQmeozmfJVtzrtoI3DF4OYL73IQVQUEppjVEBQHo2BLq/3tVn+KfqDgn
	 E7oBHGhBTSPcG4onkcybnpqBtNjb/x/GShXRBgyBttAbtdL051Ewx8yoTi7Iup+sOd
	 hzF20oGzc6fkwdIfvTPLNPEYyWaUUQW17d5/IxEzqzq8g1+wk5eKAW+POMPo7Pw/Bi
	 ZnNwYxrMQwTXyymTfs2n0cXPlf2VrlffDNsOpFRp8olw306JcP23krYR3mDS/uJJqp
	 emPHxUwAwAMZ49S42k1NY5VlVueX0t6Dp5dOPdgRYYbTrykiDgzpewCGb57o3DhwG+
	 8hNeli5/bqCOA==
From: Simon Horman <horms@kernel.org>
To: achender@kernel.org
Cc: Simon Horman <horms@kernel.org>,
	kuba@kernel.org,
	rds-devel@oss.oracle.com,
	linux-rdma@vger.kernel.org,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	allison.henderson@oracle.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v2,2/2] selftests: rds: Add -c config option to rds/config.sh
Date: Thu, 19 Mar 2026 20:13:29 +0000
Message-ID: <20260319201329.1059998-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319004618.2577324-3-achender@kernel.org>
References: <20260319004618.2577324-3-achender@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18403-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.sh:url,linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6DF52D1F67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
selftests: rds: Add -c config option to rds/config.sh

This patch adds a new -c flag to config.sh that enables callers to specify
the file path of the config they would like to update. If no config is
specified, the default will be the .config of the current directory.

> diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
> index 791c8dbe1095..e7a619d7cff0 100755
> --- a/tools/testing/selftests/net/rds/config.sh
> +++ b/tools/testing/selftests/net/rds/config.sh
> @@ -6,15 +6,20 @@ set -u
>  set -x
>
>  unset KBUILD_OUTPUT
> +CONF_FILE=""
> +FLAGS=""
>
>  GENERATE_GCOV_REPORT=0
> -while getopts "g" opt; do
> +while getopts "gc:" opt; do
>    case ${opt} in
>      g)
>        GENERATE_GCOV_REPORT=1
>        ;;
> +    c)
> +      CONF_FILE=$OPTARG
> +      ;;
>      :)
> -      echo "USAGE: config.sh [-g]"
> +      echo "USAGE: config.sh [-g] [-c config]"
>        exit 1
>        ;;
>      ?)
> @@ -24,30 +29,32 @@ while getopts "g" opt; do
>    esac
>  done
>
> -CONF_FILE="tools/testing/selftests/net/config"
> +if [[ "$CONF_FILE" != "" ]]; then
> +	FLAGS="--file $CONF_FILE"
> +fi

This changes the default behavior - config.sh now modifies .config in the
current directory when no -c option is provided, but the README.txt wasn't
updated. Looking at README.txt:

    # Create a suitable gcov enabled .config
    tools/testing/selftests/net/rds/config.sh -g

    # Alternatly create a gcov disabled .config
    tools/testing/selftests/net/rds/config.sh

    # build the kernel
    vng --build  --config tools/testing/selftests/net/config

Won't this workflow break? The old config.sh modified
tools/testing/selftests/net/config, but the new version modifies .config.
When following the README, config.sh now modifies .config, but vng builds
using the unmodified tools/testing/selftests/net/config, so the kernel
would be built with incorrect configuration (CONFIG_RDS, CONFIG_RDS_TCP,
CONFIG_NET_NS, CONFIG_VETH, CONFIG_NET_SCH_NETEM may not be properly
enabled, and CONFIG_MODULES may not be disabled).

Should the README examples be updated to either use
"-c tools/testing/selftests/net/config" or adjust the vng command to use
".config"?

Alternatively, for backward compatibility, the default could remain
tools/testing/selftests/net/config and require "-c .config" for the new
behavior.

>
>  # no modules
> -scripts/config --file "$CONF_FILE" --disable CONFIG_MODULES
> +scripts/config $FLAGS --disable CONFIG_MODULES

[ ... ]

