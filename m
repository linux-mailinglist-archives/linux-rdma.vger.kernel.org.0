Return-Path: <linux-rdma+bounces-19769-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKDUJofB8mnktwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19769-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 04:42:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A3449C6D5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 04:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8C39301440E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2D2FE066;
	Thu, 30 Apr 2026 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3IG+Az7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5332EBBA4;
	Thu, 30 Apr 2026 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516929; cv=none; b=HuuqK9JU5IUCEdBpos6sfPBwXMIrkURSdz/EAb1/S3dYAf4lJFXPVL/8TLNoBS9jFWUD3lgi64amxaYeYetQnXZKoKmhoyTjXayUyGJ41034QXSyCAhVuJI/2WFcDXWnzLYJ6iIf0E8dw66CrEcddfRZqouJTWeFbxjHNrzGNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516929; c=relaxed/simple;
	bh=L6+iCDsBkfClSuv3Tvg8xW4/AS6rgmHIIAwwRVLPNp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLYwCb6D3wHlW1pofvxotcKMTTpKDjfGRn/6lmZOgALYuPpS6G1JQ3U8viqfsZlSosnOybMnD9OZCEoXhnIGiIfNDQ+vI/7flWFOxNvAm+iUvFO+gobB+RK0/QlpsyMp2rUX+KcxttRItlzoZc+N66+wpBEWLlp9BrlhbeL2Z/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3IG+Az7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D194FC2BCC4;
	Thu, 30 Apr 2026 02:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777516929;
	bh=L6+iCDsBkfClSuv3Tvg8xW4/AS6rgmHIIAwwRVLPNp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3IG+Az7jgHhvBT8q82HCq0jdzh7m/C6bFlF04Z3Dug2rMYogX1H42KAX160OGubr
	 ha/VRRb6tD3uRhr3ehlBnkpA9vJIiheog8FODIfNantWZAKJIxhL2/j9chJ06G1QUa
	 ZRPQ9ehaCy/3A7YjLPDedwUiS9Z5ei4Asm1tvoWpSYqG0g+2D16Yjr4vN6nTeCRM/p
	 vhQ0cnlLJkL7wa2bPsMgN1WOM2pvOd+/72/rWWJ5ATj0oVbUmsawfcVLMgOjfgMp6k
	 inP78ZeLbngxzgclUv8LVFFM9Lmof6xJ9ehULThsZon8OPW8EEiuKqy9zmEsIP88TU
	 liGKxxxPoKNiQ==
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
Subject: Re: [PATCH net-next v2 6/7] selftests: rds: Collect pcaps on timeout
Date: Wed, 29 Apr 2026 19:42:07 -0700
Message-ID: <20260430024207.2452372-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428222716.2960871-7-achender@kernel.org>
References: <20260428222716.2960871-7-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19A3449C6D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19769-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests: rds: Collect pcaps on timeout

This commit updates the RDS selftest to collect network packet captures
when a timeout occurs. It moves the packet capture cleanup logic into a
new helper function and calls it from the signal handler before exiting.

> diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
> --- a/tools/testing/selftests/net/rds/test.py
> +++ b/tools/testing/selftests/net/rds/test.py
[ ... ]
> @@ -70,11 +70,21 @@ def netns_socket(netns, *sock_args):
>      u1.close()
>      return socket.fromfd(fds[0], *sock_args)
>  
> +def collect_pcaps():
> +    """Stop tcpdump processes and move their pcaps into the log dir."""
> +    print("Stopping network packet captures")
> +    for proc, tmp_path, dest_path, fno in tcpdump_procs:
> +        proc.terminate()
> +        proc.wait()

Could this proc.wait() block indefinitely and defeat the test timeout?

If a child process is unresponsive, the timeout signal handler will get
stuck waiting for it. Using proc.wait(timeout=...) might ensure the
timeout path remains robust and doesn't hang the test infrastructure.

> +        os.close(fno)
> +        shutil.move(tmp_path, dest_path)

Can this cause unhandled exceptions if the timeout triggers during or
after the normal script cleanup phase?

Because collect_pcaps() is called from both the normal execution path and
the timeout signal handler, it might be executed twice. Since it loops
over the global tcpdump_procs list without clearing processed items, a
second run will attempt to close already closed file descriptors and move
already moved files.

In Python, this raises OSError (EBADF) and FileNotFoundError, which would
abort the signal handler with a traceback instead of executing the clean
sys.exit(1).

