Return-Path: <linux-rdma+bounces-16577-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCeGL5KThGk43gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16577-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:56:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 344A9F2DD4
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA0E3012C55
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F13D4112;
	Thu,  5 Feb 2026 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxHJMezc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97C3BFE25
	for <linux-rdma@vger.kernel.org>; Thu,  5 Feb 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296011; cv=none; b=EdQOYd+RKyXLqYAJhmS2COPr/Sx54/iL+gT3+6iZffpO76DG1ffLoBYZUT404narP549bBC+WXHIKfawLa+FFqVargSB8tG7C++N34sxZgyI3NC4TW5GY21UB7FTfXj0EFT/CiFhKcQGuING8tBHGo4jV+1T2DZsIv9sVvMB1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296011; c=relaxed/simple;
	bh=rNUY36J8bHmEUxppM2cMYFFE7+yZGo+5CMZdOXKvaj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BvEEXd6BrZONQ6u+KjVoCTzWQxTY34oNkF1sTVPyaIdj5q3P9WHxVTDK6+PEJeQcCsImbzxpLdsA1p5QLTdjkVelsGlx9c9LI9kBU7L36CsfFgEmWVcApj7I1d/GLJqji2HahA/5Y4J994SzAZTWunRQfeQBdQ1gLdj5SSEC/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxHJMezc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E40C4CEF7;
	Thu,  5 Feb 2026 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770296011;
	bh=rNUY36J8bHmEUxppM2cMYFFE7+yZGo+5CMZdOXKvaj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bxHJMezc312qB+AXJAwCd9Nl21OMJnMHt0haLMhsgP5+2M/iZxbAfS+LpxSpsqxUH
	 5/GIrjJkGdg8Kw9ZqTtMyV0Ac0aALTetwdtMA1FXNQbNMunJxfNAZJgikAMxnKc1CT
	 SvSg6UjTU/dMTgC+ble0SGTTKuDxc43PaaPkFLglhK55SLl59U8+9D9Q8Zh9gjfwC8
	 bfwnHXyL75bdFyfH//WYIPWDPQyCKA6o7FYmw/FsGokNKt4Y2KWbntvYMoQXXe0b/J
	 d6XiDmzBhWNW5HDT8u6ktiVG8QcBh63eApWEIjN4DQ6Z8lI5Iwxe4k0VbQBfSsw8eF
	 ogojmh6WQjb5g==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, YunJe Shin <yjshin0438@gmail.com>
Cc: ioerts@kookmin.ac.kr, joonkyoj@yonsei.ac.kr, linux-rdma@vger.kernel.org
In-Reply-To: <20260203100628.1215408-1-ioerts@kookmin.ac.kr>
References: <20260203100628.1215408-1-ioerts@kookmin.ac.kr>
Subject: Re: [PATCH v2] RDMA/umad: Reject negative data_len in
 ib_umad_write
Message-Id: <177029600846.954009.5373952829243937545.b4-ty@kernel.org>
Date: Thu, 05 Feb 2026 07:53:28 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16577-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 344A9F2DD4
X-Rspamd-Action: no action


On Tue, 03 Feb 2026 19:06:21 +0900, YunJe Shin wrote:
> ib_umad_write computes data_len from user-controlled count and the
> MAD header sizes. With a mismatched user MAD header size and RMPP
> header length, data_len can become negative and reach ib_create_send_mad().
> This can make the padding calculation exceed the segment size and trigger
> an out-of-bounds memset in alloc_send_rmpp_list().
> 
> Add an explicit check to reject negative data_len before creating the
> send buffer.
> 
> [...]

Applied, thanks!

[1/1] RDMA/umad: Reject negative data_len in ib_umad_write
      https://git.kernel.org/rdma/rdma/c/5551b02fdbfd85

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


