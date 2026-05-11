Return-Path: <linux-rdma+bounces-20368-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D8PGt+IAWpJcwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20368-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:44:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDE50975B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83B8C3004DF4
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBAB3A0B1C;
	Mon, 11 May 2026 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfqvQL8C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556339EF1B;
	Mon, 11 May 2026 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485465; cv=none; b=SU3zHQ3UMOy5MgBNSKh5XkgGXSxq8IUt37NlVOvNlEmASTWH6hvkU77wxx2BXdMcW3eHzv6QyJpKv45kLvAnqzUQTkqc0TuNqUzd3gCsvpI4OOf7TbqCTMx0hWdcV07zTz+KTDZdcinV4wfq0JU5+UxdtmxarjembuFDvsq2V08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485465; c=relaxed/simple;
	bh=eGk2fbygLANKqz+bsRJh4DFFLGy9ou6LQKMEH+h+lvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j4J4hodb6vYDCWiOWnLsIl6dbxEmtZclONb/rrfOy1GJZTVZLmFEQ5y8izqaqCHVUi7WE4pmgWpfLsAzQxCLa17ctqghtRXaMUhhTTDstQGVKugHtMQlk+6mqlz9CjMBExWlYdQLkfJhKcRUW8pz7tiO5GfPC2yw0bOHk/d5/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfqvQL8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CB8C2BCB0;
	Mon, 11 May 2026 07:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778485464;
	bh=eGk2fbygLANKqz+bsRJh4DFFLGy9ou6LQKMEH+h+lvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lfqvQL8C9Bu5SYzQXOWj9oiUBustiYt2e48DBmtIVf3LBPaCscUnVGbGg76wPhR5O
	 RS3080AikYmFz2rUL56gaKWAbGDuPjU+9tNcRl+LiEtBfrott1+3Kha3JpGIfUEnJX
	 sNAL5BvTFPDKKrgNIr9IFTBTNAfV2tjMqoJKkKiGosHbH+faf7KS/T0mlx/Bnog5sm
	 FbLzYdVHAKRv5bKJOdN+FixWGdLAtv2/mytunPqjAARS4v8FXZ2xt+VP196nb5JYaq
	 fbTAZGK76FeWtAlhBWp3VsAXypWW7hJ1zo2OrNFldzvhg6H//Jf1zZLgz80HXn8n3V
	 uQ42ko0f96uEQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 zhenwei pi <zhenwei.pi@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca
In-Reply-To: <20260414062948.671658-1-zhenwei.pi@linux.dev>
References: <20260414062948.671658-1-zhenwei.pi@linux.dev>
Subject: Re: [PATCH v7 0/4] Support PERF MGMT for RXE
Message-Id: <177848546154.2259715.13604504484541679284.b4-ty@kernel.org>
Date: Mon, 11 May 2026 03:44:21 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 0DEDE50975B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20368-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Tue, 14 Apr 2026 14:29:44 +0800, zhenwei pi wrote:
> v7:
> - use 'counters/port_xmit_data' & 'counters/port_rcv_data' instead of
>   'hw_counters/sent_bytes' & 'hw_counters/rcvd_bytes'
> 
> v6:
> - return IB_MAD_RESULT_SUCCESS instead of 'IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY'
>   on unsupported method
> - add a script to verify the sent/rcvd bytes which is wrotten by Yanjun
> 
> [...]

Applied, thanks!

[1/4] RDMA/rxe: remove rxe_ib_device_get_netdev() and RXE_PORT
      https://git.kernel.org/rdma/rdma/c/e53d362c30c493
[2/4] RDMA/rxe: add SENT/RCVD bytes
      https://git.kernel.org/rdma/rdma/c/951d18014e232b
[3/4] RDMA/rxe: support perf mgmt GET method
      https://git.kernel.org/rdma/rdma/c/d3268aa057e710
[4/4] selftest/rxe: Add selftests for perf
      https://git.kernel.org/rdma/rdma/c/cb28405b38c55f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


