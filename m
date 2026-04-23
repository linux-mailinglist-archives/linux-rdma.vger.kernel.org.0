Return-Path: <linux-rdma+bounces-19492-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFuwBgzz6WmepQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19492-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:23:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F44509B4
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77B933019758
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65DB3E7179;
	Thu, 23 Apr 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdFbFYl7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FF38737A;
	Thu, 23 Apr 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939570; cv=none; b=AQ6BaswjrbMQNbNH8iydrGjUcPNi92vXks3iWyuc96PE0kwG86BrT+2luFRdfTFdyEnUXemTh7IDx8WTPpJ7mVdsdzLdFWFWOG0VoFsFVuYZD3UzrfziVv5an/nZcwWuc5fMK9NCgI3RQGK5lf8BkDkYxTqL38Ur9lOwqCNpQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939570; c=relaxed/simple;
	bh=3ygz8aPQ887mmlXRKJ2niuUkt3iUa+0zyJRimlH0iLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3QsDMCLOcW4r80DVqa70vs7NsxzL5GJZvQ8vZ+wVtwHQLu6MTPhMyYI0LtcS2COZkDPGsHgbtrAfw9b0A89fOvrl/fNKecMgvJMEAIE08uJzG7Fn1gVQaIROyTWMb301XCWBZMhHUUq6BwzTQCNctWkzyn9LpzV1mNX+sBNqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdFbFYl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B77C2BCAF;
	Thu, 23 Apr 2026 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776939570;
	bh=3ygz8aPQ887mmlXRKJ2niuUkt3iUa+0zyJRimlH0iLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdFbFYl7H0jbCT8dSo1bJErpMV5J/bQS1D6GT7LviSzdrkc1ANJuyh4N1Ww1b7Y9u
	 Cd2mW+9bEAknm5VH+yY+BHD5NTdni+7zMnHnpxOtkqc91h7oOvPI5GiutDoUGhw4QW
	 s33rrZZHxx2YytIIoBvImlZlU1rYctjB2GsY9M/UXhh29p8AvKBA/JLDq53Axu0Xce
	 dfjx6UKHV90rHugLaF6MYnoS8FBE8sJu21qUUohO4naSFLbiSJu7IqjIg2RHCN1SXk
	 NpDzzO1Jg0wq48N2b+XYaz2xndvfuSQ8629Ma2RHHHQ5y/z/d9Bv0spT3AKcwXD/ov
	 RAeChM9mscW4g==
Date: Thu, 23 Apr 2026 13:19:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] selftests: net: add RDMA CM observability and regression
 scripts
Message-ID: <20260423101924.GB172828@unreal>
References: <20260416062224.1546388-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416062224.1546388-1-zhaochenguang@kylinos.cn>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19492-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: A79F44509B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 02:22:24PM +0800, Chenguang Zhao wrote:
> Add a minimal RDMA CM selftest suite that captures observability
> baselines and runs trace, counter-delta, and fault-injection oriented
> checks, plus a review-loop helper for repeated validation rounds.
> 
> Usage (client side):
> - export
>   CM_WORKLOAD_CMD='ib_send_bw -d <dev> -i <port> -R -g <gid> <server_ip>'
>   (User can customize CM_WORKLOAD_CMD)
> - sudo -E make -C tools/testing/selftests
>   TARGETS=drivers/net/rdma run_tests
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>   The first patch adds a focused RDMA CM selftest suite under
>   kselftest to make CM behavior easier to observe and validate
>   in routine regression runs.
> 
>   It introduces baseline collection, trace-sequence checks,
>   counter-delta checks, and failslab-based recovery checks, plus
>   a review-loop script for one-shot serial execution. It also
>   registers drivers/net/rdma in the top-level selftests TARGETS,
>   so the suite runs through standard kselftest flow
>   (make ... TARGETS=drivers/net/rdma run_tests) instead of requiring
>   manual script-by-script execution.
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/drivers/net/rdma/Makefile       |  13 ++
>  .../selftests/drivers/net/rdma/README.md      | 168 ++++++++++++++++++
>  .../drivers/net/rdma/rdma_cm_baseline.sh      |  58 ++++++
>  .../drivers/net/rdma/rdma_cm_counter_delta.sh |  72 ++++++++
>  .../net/rdma/rdma_cm_fault_injection.sh       |  95 ++++++++++
>  .../drivers/net/rdma/rdma_cm_review_loop.sh   |  35 ++++
>  .../net/rdma/rdma_cm_trace_sequence.sh        |  83 +++++++++
>  .../selftests/drivers/net/rdma/rdma_common.sh | 126 +++++++++++++
>  9 files changed, 651 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/rdma/Makefile
>  create mode 100644 tools/testing/selftests/drivers/net/rdma/README.md
>  create mode 100755 tools/testing/selftests/drivers/net/rdma/rdma_cm_baseline.sh
>  create mode 100755 tools/testing/selftests/drivers/net/rdma/rdma_cm_counter_delta.sh
>  create mode 100755 tools/testing/selftests/drivers/net/rdma/rdma_cm_fault_injection.sh
>  create mode 100755 tools/testing/selftests/drivers/net/rdma/rdma_cm_review_loop.sh
>  create mode 100755 tools/testing/selftests/drivers/net/rdma/rdma_cm_trace_sequence.sh
>  create mode 100755 tools/testing/selftests/drivers/net/rdma/rdma_common.sh
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 984abb6d42ab..0df7034f46b2 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -22,6 +22,7 @@ TARGETS += drivers/ntsync
>  TARGETS += drivers/s390x/uvdevice
>  TARGETS += drivers/net
>  TARGETS += drivers/net/bonding
> +TARGETS += drivers/net/rdma

It is very wrong place to put RDMA functionality.
We have tools/testing/selftests/rdma folder for that.

Thanks

