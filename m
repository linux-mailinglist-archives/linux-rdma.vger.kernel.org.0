Return-Path: <linux-rdma+bounces-21607-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zsU6JQ1AHmraiAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21607-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 04:29:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443E6273A0
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 04:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17C773048906
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01FD3612D5;
	Tue,  2 Jun 2026 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9F3R+wy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C5360EEA;
	Tue,  2 Jun 2026 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367092; cv=none; b=B7DQMwhW73aZFtaGP3xSqj0tiOzLs3YAc9T8a3nhD6mbcSyO2oVPLHai+a3e5c+YmUtqXfMb5KXbzccWyXtB6Ygdrk3P6O26ksQMPKfpYdmhHq7wc7233iIJuOafs7SifPoXK0BpyCQuLipu4AayIOSJKTtDLEIUWtsvlJ+G6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367092; c=relaxed/simple;
	bh=ClxTDzCpGqsuGuerbNHU0KLoCUlAZMdBd0D+jyY0JlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fukb90RxUp7AxwQY0e0MOOxS5dI6kRvGsYbETkdYrCCAj2P1Ujf097Ge4UZTUdPTGfzOh7Q5Rr8c8YLE29SroqsZGH66PQUuzGfo9fQ45291Vyv2hw661ihofLj/shJHBd50yueLevi3zLT8zfl6jyHkDCTBT2TnHEe1cUX48mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9F3R+wy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD591F00898;
	Tue,  2 Jun 2026 02:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367091;
	bh=USZnTz6l1BNNL6RQ/Z/0kA4QgrNPvmVTEDWl7JMVB4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j9F3R+wyYk/cIAkbJnM+ZWLLNIgmHSvA0V6aYVUpBPFFYhJv1zGqRmuo7Rno2ZA4U
	 Vj+WRXJoAfV09t+ZvzSGFXwrTzmT5WeBMmIt0MisbE0levKFuRrHrwxtJMEYT60L75
	 Yuj8e378uL+Vjh/oeQTAYaZj/0+Y2mYxDlZq1oupIVZFLYVMs2pLu/WRqkzpgBhV8G
	 QrjEQXKXx3CAeryA6dTrsskGnxN3wjX8ghXBHvx4x+0FFOEHDSCzn8WlubMaEyhhJh
	 fxTQ2AL8iNhoQCxneQgDvI2NxWWUJ9/UEsnp129imkzJUUwtAENmZ5zi5cP00VY7Wb
	 v9gjQWUGxDwMw==
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
Subject: Re: [PATCH net-next v2 4/4] selftests: rds: report missing RDMA prereqs as XFAIL
Date: Mon,  1 Jun 2026 19:24:49 -0700
Message-ID: <20260602022449.1634587-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527023423.387792-5-achender@kernel.org>
References: <20260527023423.387792-5-achender@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21607-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2443E6273A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
selftests: rds: report missing RDMA prereqs as XFAIL

This commit changes the exit code and message tag for RDMA prerequisites in
the RDS selftests to report as an expected failure instead of a skip.

> diff --git a/tools/testing/selftests/net/rds/rds_run.sh b/tools/testing/selftests/net/rds/rds_run.sh
> --- a/tools/testing/selftests/net/rds/rds_run.sh
> +++ b/tools/testing/selftests/net/rds/rds_run.sh
> @@ -123,10 +123,10 @@ check_rdma_conf_enabled() {
>  		probe_module "$2"
>  		return
>  	fi
> -	echo "selftests: [SKIP] rdma transport requires $1 enabled"
> +	echo "selftests: [XFAIL] rdma transport requires $1 enabled"
>  	echo "To enable, run" \
>  	     "tools/testing/selftests/net/rds/config.sh -r and rebuild"
> -	exit 4
> +	exit 5

[Severity: High]
Is exit code 5 the correct value for an expected failure in the kselftest
framework?

Looking at the kselftest framework in tools/testing/selftests/kselftest.h
and ktap_helpers.sh, the expected failure code (KSFT_XFAIL) is defined as 2.

When runner.sh receives an exit code of 5, it does not match KSFT_XFAIL.
Instead, it falls through to the default case and calls ktap_test_fail,
which logs a hard test failure.

Could this actively fail the test in the continuous integration environments
rather than marking it as an expected failure?

[ ... ]

