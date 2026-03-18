Return-Path: <linux-rdma+bounces-18361-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALOhNzbwumkfdQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18361-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:34:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEDE2C15B4
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 19:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777CF3208AF0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8143D648C;
	Wed, 18 Mar 2026 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QllJgh+9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9F281525;
	Wed, 18 Mar 2026 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858415; cv=none; b=BQsDQYfcjpCkQRcXSaKqnk/HLIzWiUxfU1hygNmwdtegMcR0kYxfJsRQHjVysATRwnNAH+O/J9lZ3rnr+96OWRYNWxI/7kRmJE7U9/5biOvTgMU1CFm7TxCgM5KOp/qwW6LNWkF8Oz/xrBsIxjHj7VOJnRfbletKXQMBysyo8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858415; c=relaxed/simple;
	bh=Uqg6di5ANgL2K7WBigJb9ZSeUEjzs9VNZ0jcmHohk+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pu3u4pY9hhyOOmy1zNnwICHuTgnkYV2yovPzVYqfwzhoInP4Y5BrmS9/aE2I5kOftx72xJFbjEurpOZKfHROf+5ALlwpY9xqFGj69p6Q8s5magr/QeKVHYIJckUr+h36Falm+vyH9dKcU92UH++rO4Dhf7pKcgnf8dSmuBI0Bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QllJgh+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C220C2BCB2;
	Wed, 18 Mar 2026 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773858414;
	bh=Uqg6di5ANgL2K7WBigJb9ZSeUEjzs9VNZ0jcmHohk+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QllJgh+9fL3FfGdvTlXzxCP5sbpOqJPFUkC7pjjmg7wzpwQCG/SEP9St/42Gwd1tm
	 dqHM5E4a0ce+W6bFJTtseh0ZI1wH+yx21UCqErB1/d3cwo2Tu8rgYr5yLLR0cNOJDR
	 vid8sQLymD63NYPOYSbgEHmhW85hikz1TOn5S5BpOXAWev0RLsL4rupj4TQR0nw0Nf
	 G43QBAqVe33m+QgibIv3Q4Ktein72nlo3tJVkoONgCS0xzg6NdfEvXoytfLl4to3Rg
	 Mjn/IIVTlBeHJxcnkESw8XpOIZIyLQZk6zExJjRIe9ztRiq4bohUzkhKBPavXSWnG/
	 zqCKVmLwew2pA==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, 
 longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260318173939.1417856-1-kotaranov@linux.microsoft.com>
References: <20260318173939.1417856-1-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: cleanup the usage of
 mana_gd_send_request()
Message-Id: <177385841144.776737.17862315617132200486.b4-ty@kernel.org>
Date: Wed, 18 Mar 2026 14:26:51 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18361-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EEDE2C15B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 18 Mar 2026 10:39:39 -0700, Konstantin Taranov wrote:
> Do not check the status of the response header returned by mana_gd_send_request(),
> as the returned error code already indicates the request status.
> 
> The mana_gd_send_request() may return no error code and have the response status
> GDMA_STATUS_MORE_ENTRIES, which is a successful completion. It is used
> for checking the correctness of multi-request operations, such as creation of
> a dma region with mana_ib_gd_create_dma_region().
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: cleanup the usage of mana_gd_send_request()
      https://git.kernel.org/rdma/rdma/c/684603da1e1567

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


