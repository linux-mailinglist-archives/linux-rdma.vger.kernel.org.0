Return-Path: <linux-rdma+bounces-18553-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBzK7n5wWlSYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18553-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 03:40:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3C30143C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 03:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79E38302B203
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5738737C;
	Tue, 24 Mar 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpHWxO8s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB76221FB1;
	Tue, 24 Mar 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320034; cv=none; b=gxgmdAHPStkGZeEuRhd6MZUzf5fTlwHji0JyBvEfzZuIqGN6X0uUv70Az54nUGdCJYZ4CCNbEo1dpIk1isvijrLJemqW7SPiT4oN3GE2vmO3JwxN8Y19CS51Vj/BLME9nQ6L2cKLFgqrqBmZDoJDC7zD8wHejD2C/6jn8q5bGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320034; c=relaxed/simple;
	bh=Viy+yE96AuCLTStEc7qh718cDePmJXNz6dRwy+h44Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdfPw6RWSjPv29kWaC7Avhb/y5A0QZFOmaaosZzBnN+r3bE3hXxr2HfyN1sJPJfxATaU08RXuTP8Ue2lyJiG3d5uFhn194Jl5YUxdd0BoOaXJrRcz+WXO1rJhoegXVnRVj7m//fTf7BdDZ3zl+8Ysnw2ab0ZNDTZlHFo+wW4S7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpHWxO8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FADDC4CEF7;
	Tue, 24 Mar 2026 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774320034;
	bh=Viy+yE96AuCLTStEc7qh718cDePmJXNz6dRwy+h44Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DpHWxO8sKp3Pwl9gSLtxOkVOwDCceKQGht7ed8I+7Lk8IdeB6cgYvJ6PzJG6PQS5L
	 FnhA7gZSXTGkz7T5qej+Od3/nZjB5OvrszWF6IzOYmD97fbr61nP3/H5ARvkoBZtQ0
	 Bw2oqp2CBjGgDEdHvU2ClA2+XO589LdjgrVVlKNJkpbuWRxYENy5B6ttrfAmwuuRHy
	 0SzANwYShwtlniBEtjk6bfSWhgBfGZuSX5M1BnXL6D7SNiTcwkxJGouWGys5FO1zCd
	 icC5yYiHjLaGOkEzfTiLGMqvDStj1V96j1LB/n0JjA08aSe4CikDibaBz/8tXXynMM
	 xkzdcmOxvqY1g==
Date: Mon, 23 Mar 2026 19:40:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 shuah@kernel.org, horms@kernel.org, linux-rdma@vger.kernel.org,
 allison.henderson@oracle.com
Subject: Re: [PATCH net-next v3 1/2] selftests: rds: add
 tools/testing/selftests/net/rds/config
Message-ID: <20260323194032.4127ac92@kernel.org>
In-Reply-To: <20260320041834.2761069-2-achender@kernel.org>
References: <20260320041834.2761069-1-achender@kernel.org>
	<20260320041834.2761069-2-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-18553-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AF3C30143C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 21:18:33 -0700 Allison Henderson wrote:
> --- a/tools/testing/selftests/net/rds/Makefile
> +++ b/tools/testing/selftests/net/rds/Makefile
> @@ -6,6 +6,7 @@ all:
>  TEST_PROGS := run.sh
>  
>  TEST_FILES := \
> +	config \
>  	include.sh \
>  	settings \
>  	test.py \

I don't believe this chunk is necessary, only files which the tests
themselves need to _run_ need to be listed.

I dropped this chunk when applying, thanks!

