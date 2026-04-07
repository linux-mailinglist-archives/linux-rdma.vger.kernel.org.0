Return-Path: <linux-rdma+bounces-19074-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKoiJlm41GnQwgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19074-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 09:55:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ED93AB025
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 09:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83864300AB32
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061925F98A;
	Tue,  7 Apr 2026 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t31iQV2a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE53A2575;
	Tue,  7 Apr 2026 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548497; cv=none; b=kcW1UoTcQ17F7W0DPxxGJDZPxnhonFz1IYFNE5i11+mHIgAWFqE6YH+4zXZoQKrmie1JzeL0BxlDaqxDzQzv2N2kN0ZhmsYvOh5ER1Jq9QTEaqJ9Q3/qHZyyIK3SNVbFleOoGKxSAef0u/ghC/bubAgPmMhRTw0HZd4jPACLASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548497; c=relaxed/simple;
	bh=LbI8R/ecrApQ4vZQpbY4Kjjq4O6AqsIs4YecIibwGWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpH2mSDtvakRLiSn33dUdtP53nyIUVmYIbEzJig0u7HK6CAE7yku9k7lACtdhkFQuqqcOCcMTjAxC510A5G5Bzz5dmSZvuZydqxx03ZBfuifpvNDYPSgrciese5CkxkA7KcyGFTVv3qVoLNSErNBMhdaSQaHzM1PAuKjgaB5HGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t31iQV2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC00AC116C6;
	Tue,  7 Apr 2026 07:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775548497;
	bh=LbI8R/ecrApQ4vZQpbY4Kjjq4O6AqsIs4YecIibwGWk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=t31iQV2aygBaiNSWKbUlXv0P0GEnGsgyJVnnNUKUMdHhEiUizIXbKZ/1+AuWPq8fq
	 8gpsWSSoaSi+jP/+Jr7mubuFrKcLdzfG8ygMrlUXMhmM58Cy+jZtPC7mHR7uPkz37M
	 iMFPQYHZPeaXwR5iOT11kJNizTxUKlo3PIT/z2aZ7/us7fGynxVcQKUUNcGs7vTwdZ
	 XeZ5qN2Tng1iBUpGRdJjzdYRjBzbRvN0w4emRurwGMKcYqYSxCbiwdsx+2A+MkJmDT
	 0G/td8uYRs6c/iVeMpfHT+Yl/GzuF1OfXzlIPn4ZJZ9elNKmuJuQdFmuz/qh/DecmO
	 wgMnNEtXljpiA==
Message-ID: <a80aee5102e3e249041feb325469f767be4710ff.camel@kernel.org>
Subject: Re: [PATCH net v1 1/2] net/rds: Optimize rds_ib_laddr_check
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	rds-devel@oss.oracle.com, horms@kernel.org, linux-rdma@vger.kernel.org
Date: Tue, 07 Apr 2026 00:54:55 -0700
In-Reply-To: <20260406181957.4bba8580@kernel.org>
References: <20260405041613.309958-1-achender@kernel.org>
	 <20260405041613.309958-2-achender@kernel.org>
	 <20260406181957.4bba8580@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19074-lists,linux-rdma=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0ED93AB025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-06 at 18:19 -0700, Jakub Kicinski wrote:
> On Sat,  4 Apr 2026 21:16:12 -0700 Allison Henderson wrote:
> > From: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>=20
> > Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracl=
e.com>
> > Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
> > Signed-off-by: Allison Henderson <achender@kernel.org>
>=20
> Author's sign-off missing on this patch (I sent out the AI reviews
> as well, without looking, take them with a grain of salt).

Yes, H=C3=A5kon's sob should be here, I will add it.

Thanks!
Allison

