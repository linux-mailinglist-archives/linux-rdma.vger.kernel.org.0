Return-Path: <linux-rdma+bounces-20371-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIctIcmQAWrTeQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20371-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:18:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD7509F7E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4158130A1AF4
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E23B9616;
	Mon, 11 May 2026 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9kTzpDl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DD3B6C05
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486778; cv=none; b=FU1iB9MOGuwcqKf8Lq/DQb2rTP0pUCULq+XI5TToWTd4uO6EvfnmYbPxeNQNGKLcY1Jli4DxKvzph/+1ZXvTuG+LK/OtHRT4sYOAJe6R/+ijYZ0LCkeB3LtrzkNtzGysYSMfiTT35GzBdntjzVmVie+q4vKNvmHO6H/myYMBi5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486778; c=relaxed/simple;
	bh=4W+L6piXhZLeAkghtMz2lgaELQ72O0DxasT5oEGhB0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r6n/d5aRMRCqoXPih4kpDiIN9u0yV0adEZNMfi1HNnhbG+ba24GVrbTNbSHOVeq2aMkDBkWt4bWFf0ZPb+yTaZPY20pvgiKD2D2EsDHX8VpQnB8JLUOATTnbytDC2ij5h35efw+8rh3GwX0uZY1HPkdfW6/Jo6CyWktFSI+7Q0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9kTzpDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD217C2BCB0;
	Mon, 11 May 2026 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778486775;
	bh=4W+L6piXhZLeAkghtMz2lgaELQ72O0DxasT5oEGhB0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V9kTzpDlyDUlOdJMNfknr3MDIXrGK1vqCkXno0zQSPsqmBGEwsChAdeTdXpl5lB3I
	 WaccrvK5d/XVjIfz63hsgx2XYFNW7ommjRmD/plHDHnXDmwkFP37F9ZWfYwJQK9riz
	 UWg3ro38AMasb+Cvh3BzJaYMObr9pYR48dEF8cYaO9zxW4L+dw/F9k3LqHxBadIgTu
	 VmzfEa0JjObIj+/0q7PNUHFWNOGJOZv05W2mVtzlqHf7q9bun9JBdhHxjla33y+B9y
	 GDn6SocCaLRQp2NsekA5JgjbTBZrrV4MwIbYwzJUPa39y2JcCr6ejdnFxZ2X3Dggp7
	 gfMh0O/h7Io5g==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Yonatan Nachum <ynachum@amazon.com>
Cc: mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com, 
 gal.pressman@linux.dev, Firas Jahjah <firasj@amazon.com>
In-Reply-To: <20260409074905.3126023-1-ynachum@amazon.com>
References: <20260409074905.3126023-1-ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add checksum support for admin
 responses
Message-Id: <177848677232.2261097.12870868372638359236.b4-ty@kernel.org>
Date: Mon, 11 May 2026 04:06:12 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: F3CD7509F7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20371-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 09 Apr 2026 07:49:05 +0000, Yonatan Nachum wrote:
> EFA devices added support for CRC16 checksum on admin responses and to
> expose it to the driver the API version increased to 0.2. Add a check
> for support on device init and if supported validate the checksum on
> each admin response the driver receives. If the checksum validation
> failed, drop the CQE.
> 
> Add the CRC16 module to Kconfig to have the in-tree dependency.
> 
> [...]

Applied, thanks!

[1/1] RDMA/efa: Add checksum support for admin responses
      https://git.kernel.org/rdma/rdma/c/74ec3fb0ab079f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


