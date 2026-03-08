Return-Path: <linux-rdma+bounces-17710-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JdmJwlurWme2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17710-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:39:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F142303BB
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44160300530F
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC356321F5F;
	Sun,  8 Mar 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eryLpHSl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BA1C2AA
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973569; cv=none; b=hqHn2eMV05jrsfiG4VXIq9fPB/niHrMhtzIMARkJ6hz12bjDuT2fUt6QHlb/KmKotY/6R0owSaVCuX/EHRCjYXmeJOtpOTk0OWuqb3k8kyLtVCG62pw4fgYtJ3JeSh7SWvdtepj+xF7xxV4uTdK51jA349/nxuMx7hZ+/50a99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973569; c=relaxed/simple;
	bh=GAmZ5kzvLI/am4z+G3DGOhmKxw/YqpyuqmgwblBF1hg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ant3dvettgoGgJmHMMMRcgq+KXsnCTg6T4dslCI6FEzpmLmh94i/IJ+F4HvfTjV3JXP9l3HXQ/0ocmyZ9502WpOG8mFYw9JujV9lCuA4LH6mERu/9BJCXAZ7BhHH5aacDyB8I1rQ038THNeenJbhWffBpTgsH8q7jmbTFbFfVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eryLpHSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE497C116C6;
	Sun,  8 Mar 2026 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973569;
	bh=GAmZ5kzvLI/am4z+G3DGOhmKxw/YqpyuqmgwblBF1hg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eryLpHSlcgeVHFjm4nYO0vze8QefOdZW+QNPn5Fx0a41jW6oYGssj2sqz3gtajVtR
	 JH/j4HZScFrL9HLGjR6U3mDXGW+EHDaIqi/xahVP19TH8nC1pwyb2cWTsc3sl+IpDd
	 9AEC/tZEpn/F9K7WsY4ztaCQ6cISFpqf9CjZBEazaVu/JKnZRue++tmQ8cGF9nvlMm
	 0eapHYyTFxIFOaDJP0Ftd5ZtpwEnVk6TOZHjIrBmYS3nNOX2QnAjD6HfSpGPHXbXVk
	 cE43M4wHCOUmrDhRc3oBzUixNn2lDJEpkdl6zWcus8KqykLPhw2JMj2c4iNn/NaY19
	 RR7bIdbY+WvJw==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
 Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org
In-Reply-To: <20260305170826.3803155-1-jmoroni@google.com>
References: <20260305170826.3803155-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next v3 0/5] Add pinned revocable dmabuf import
 interface
Message-Id: <177297356632.1470686.7585479807313146175.b4-ty@kernel.org>
Date: Sun, 08 Mar 2026 08:39:26 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 92F142303BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17710-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action


On Thu, 05 Mar 2026 17:08:21 +0000, Jacob Moroni wrote:
> Some dmabuf exporters (VFIO) will require that pinned importers support
> revocation. In order to support this for non-ODP drivers/devices, a new
> interface is required. This new interface implements a two step process
> where the driver will perform a sequence like:
> 
>     ib_umem_dmabuf_get_pinned_revocable_and_lock()
> 
> [...]

Applied, thanks!

[1/5] RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
      https://git.kernel.org/rdma/rdma/c/33960c206db2ee
[2/5] RDMA/umem: Move umem dmabuf revoke logic into helper function
      https://git.kernel.org/rdma/rdma/c/e86b2bf1c3118f
[3/5] RDMA/umem: Add pinned revocable dmabuf import interface
      https://git.kernel.org/rdma/rdma/c/932f1eef09ecbe
[4/5] RDMA/umem: Add helpers for umem dmabuf revoke lock
      https://git.kernel.org/rdma/rdma/c/f39003e8fa8c8f
[5/5] RDMA/irdma: Add support for revocable pinned dmabuf import
      https://git.kernel.org/rdma/rdma/c/5c3f6de46d6a55

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


