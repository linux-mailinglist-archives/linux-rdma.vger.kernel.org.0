Return-Path: <linux-rdma+bounces-18409-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KLQG/uMvGlv0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18409-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 00:55:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1EC2D4521
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 00:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 316813029638
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741C03793AB;
	Thu, 19 Mar 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm7QUfJ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3131A3CCA05;
	Thu, 19 Mar 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964532; cv=none; b=feZhPolKVb7i01FlIk83PaK3giT+/e9TqiupPWsLuMytuaCRe2UIRv3cwm1hL4Qeay+O0t/dF1CLS28ZFengPdC7EvEGPmmrfsBIb7UXIoHVSUkZenVp3Yxv8+EfXrjBsX9uHgh3P8zAL68RHLtjUolq0Fsh+VMGlTCEuL+ZBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964532; c=relaxed/simple;
	bh=aWhhuGA/F8QBOdpone2Nhm7d1uBpbl7/3jMAOi2iDW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZkIyLcauaTNr9luc6VMwbVRewqXArvnRn7oSYYCAgwSW4sBdWl61KTF5TPi7i3fRXo8BcVF++1uuDIe4E9gmyz8rakCwMSUbx5RFdwK6mPDJdzDgAsNIxESZjTRUC+PSVgUg9WtMqQYGipZ0FN9YZCEg4sCZCUUpqB/f3u/Nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm7QUfJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120F1C19424;
	Thu, 19 Mar 2026 23:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773964531;
	bh=aWhhuGA/F8QBOdpone2Nhm7d1uBpbl7/3jMAOi2iDW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hm7QUfJ8ABixwpDY+SFVmnUT2J0sfb5Kztb6nUAXyxjqeFQxJqkY8xVuJ3neT5+vv
	 lU2Qr4QYrlbpeOY7VmT3dCisoMU3fS40T0rkaxLMB3sIfRGyHbPy0/XGsXm+2x6K4U
	 yZG3t14fPt2qmDVG6v5OM8htWhmQdCBNUjEDvzsuY9H3XaRMa0K9F/Whc711vPGBef
	 SkuX13kufmpVJ3V1U6lL2MU7v9lEfKlkdMBbU9UoL9rOgrVsz6W85yCAH00Fi2z6HD
	 tLVEnt16zds3Z4RcDj1iGsUq3hH++eAxyDhYQC4Pe6tLpxlmUtOQb80OTxQWMK7Ikm
	 1NRNY5DZ0N7eA==
Date: Thu, 19 Mar 2026 16:55:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: Re: [PATCH net-next v2 1/2] selftests: rds: add
 tools/testing/selftests/net/rds/config
Message-ID: <20260319165530.0472ab6f@kernel.org>
In-Reply-To: <20260319165435.4468160f@kernel.org>
References: <20260319004618.2577324-1-achender@kernel.org>
	<20260319004618.2577324-2-achender@kernel.org>
	<20260319165435.4468160f@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18409-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D1EC2D4521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 16:54:35 -0700 Jakub Kicinski wrote:
> Contents of both these files need to be sorted according to the whims
> of these scripts:
> selftests: rds: add config file and config.sh -c option 

paste fail, I meant this:
https://github.com/linux-netdev/nipa/tree/main/tests/patch/check_selftest

