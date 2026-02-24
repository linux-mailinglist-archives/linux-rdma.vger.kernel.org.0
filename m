Return-Path: <linux-rdma+bounces-17109-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNhSI4Z3nWmAQAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17109-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:03:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39346185155
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F6D63053E2B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53705372B5B;
	Tue, 24 Feb 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N170TuqO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202C1607A4;
	Tue, 24 Feb 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927405; cv=none; b=Tf/QUdWj/UXbs2JEZTOTWbZjoKHaXWz4W5f8iB3hE8QrP4F/5YV9IHJIahceOZFgAMOBoUbdscigvAMyTHyyeVMO32aBL+taCHUI4Ut4u+PyX4qea7EH+fgVFEn/EOgE/8A6snyhu+UhpJzvq1wOJOk0vTsr1opPGPpCod9QqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927405; c=relaxed/simple;
	bh=nNjO5vXZErJBczcUVKw0ieFD48h+UCmSq9OpZxEVWCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BKj88/Y4LNF1GWAeLBCnGelN3hBv6jpjFxR1uP814NCceDbrGZm4Ose4AHFgoPRKr2vI5Ni8J6G0t0lraTe4BjMdn4Bfqu24DmRwWAFnC/EtlvJaKPafHPnwsuTtIu1Ok27QoTR1EcUngAk2nfSCjo02S+gUfhtGJgHIJvvvkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N170TuqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A606C116D0;
	Tue, 24 Feb 2026 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927404;
	bh=nNjO5vXZErJBczcUVKw0ieFD48h+UCmSq9OpZxEVWCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N170TuqO/mHnvdHeQgXsQ8ycRUVPXrRVjIVfNStqxYgQDPXBv2581iKpHqFLK3D9P
	 Wpy6+rAh6qEUYj6tr7PG0MguOPDAIf4JWAUXkHiHhTIJBewHqKRqa+i+BdY0TdIGDn
	 nGzjr20Q8tJyCcRPlXkn1QUbCld/vyOTXxal0/TUDoPl/ZdYeFWV89tbXMJXGr+uHC
	 Ecg32Pv/lrUDal9tcTf30J168Tb4w/RauBXyWxVWGPcAAbAJa54m47S476r3PEhOVz
	 aX0atJdc0/gXR8pQb0lvIUaRyajK6IrQXvpuSiy/0PLKRY7gzdm2isu9FJDQ0F5bL8
	 hKsEklxWetXVw==
From: Leon Romanovsky <leon@kernel.org>
To: Gal Pressman <gal.pressman@linux.dev>, 
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>, linux-rdma@vger.kernel.org, 
 Michael Margolin <mrgolin@amazon.com>, Yossi Leybovich <sleybo@amazon.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, 
 Allen Hubbe <allen.hubbe@amd.com>, Andrew Boyer <andrew.boyer@amd.com>, 
 Gal Pressman <galpress@amazon.com>, 
 Mustafa Ismail <mustafa.ismail@intel.com>, patches@lists.linux.dev, 
 Roland Dreier <rolandd@cisco.com>, Shiraz Saleem <shiraz.saleem@intel.com>, 
 stable@vger.kernel.org, Steve Wise <larrystevenwise@gmail.com>
In-Reply-To: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
References: <0-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
Subject: Re: [PATCH rc 0/4] Fix several serious mistakes on the udata path
 in drivers
Message-Id: <177192740020.748380.4781563195218426218.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 05:03:20 -0500
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17109-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,amazon.com,intel.com,lists.linux.dev,cisco.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39346185155
X-Rspamd-Action: no action


On Mon, 16 Feb 2026 11:02:46 -0400, Jason Gunthorpe wrote:
> While converting drivers to use
> ib_copy_validate_udata_in()/ib_respond_udata()/etc these issues were
> found, mostly by AI scanners.
> 
> Jason Gunthorpe (4):
>   RDMA/efa: Fix typo in efa_alloc_mr()
>   IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
>   RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()
>   RDMA/ionic: Fix kernel stack leak in ionic_create_cq()
> 
> [...]

Applied, thanks!

[1/4] RDMA/efa: Fix typo in efa_alloc_mr()
      https://git.kernel.org/rdma/rdma/c/f22c77ce49db05
[2/4] IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
      https://git.kernel.org/rdma/rdma/c/117942ca43e2e3
[3/4] RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()
      https://git.kernel.org/rdma/rdma/c/74586c6da9ea22
[4/4] RDMA/ionic: Fix kernel stack leak in ionic_create_cq()
      https://git.kernel.org/rdma/rdma/c/faa72102b178c7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


