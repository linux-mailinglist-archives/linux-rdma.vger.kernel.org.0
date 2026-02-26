Return-Path: <linux-rdma+bounces-17243-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG3SFVOjoGkvlQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17243-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 20:47:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BF01AEA30
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430A2302AC0A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203F36495A;
	Thu, 26 Feb 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvSLdQXt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464733603E9
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134914; cv=none; b=Sq0AQBnttI24sxBGEiC63vDVLh+VJ/UHi5m3Jt6xvvSn5UOGSzDMdaxWV9UY8gK4EdnlL+p5L2Z5RY7tG97mx3CzKSWEZ1uoLCZf5rz9zWBvFN1aap5ce101tipW+MQlwjA2isoHA41sqOw/NV37+7xRXvkaHzL6iMFmW3IiVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134914; c=relaxed/simple;
	bh=md4yii5u2RlZVM+Id/OBzZPA1F75uvTgFuyRzVUfbhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWxP3SfdkRHNpraZwUsTQg6b3k34uGXaD8/lX4PSr92IJ1756VPedZlTip/VkiwHXk9JxJhlpvEsi7x7Yp+lOZXMuKf3I2espgxLIDFWSel40kVPwg5N4SJng0G+nF0x5YfrumAJZI/mFAKFm9Tjb7PKpphzncWo33ynwJxLxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvSLdQXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A656C116C6;
	Thu, 26 Feb 2026 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772134913;
	bh=md4yii5u2RlZVM+Id/OBzZPA1F75uvTgFuyRzVUfbhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvSLdQXtD4awmxyNERKS8CdWJyu6i1hhlS2r5R0jJDQw7cnO1/Dr/b5GOp4PjVh2R
	 CLnTcN05UIGoHSVl06XzZy4/qhZE4c2/rrAdT2FSBDXiANNNtNQcx/og8IA9gSiXc1
	 wcA/3sYIsNACgvEP+Mtmk2nXIUJPUat8L1yMrOCcESX106Jo7ykxc1KYQqE8DtUXcr
	 pSvu+JaQSW44J6m4dyEk7+6TtXMBK5sa1bbOU373EShzCf0FZpvuO5Weh6PhyblXBL
	 ky93xBxnqWGXb5MC4O+Mkh5A0RiXo3YJj+burUF1iVaF1mm051FnzzhBuM60awcTUX
	 VfufVclBw/DZQ==
Date: Thu, 26 Feb 2026 21:41:49 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/irdma: Add support for revocable
 pinned dmabuf import
Message-ID: <20260226194149.GM12611@unreal>
References: <20260225210705.373126-1-jmoroni@google.com>
 <20260225210705.373126-5-jmoroni@google.com>
 <20260226085517.GG12611@unreal>
 <CAHYDg1QLzeQTXpCTeP5ZYcYyYLHG3yhUQtrGec+-5MzaGL-jKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1QLzeQTXpCTeP5ZYcYyYLHG3yhUQtrGec+-5MzaGL-jKA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17243-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4BF01AEA30
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:22:09PM -0500, Jacob Moroni wrote:
> Hi,
> 
> > I wonder if you really need to leak umem properties and can't use
> > existing irdma_dereg_mr(). ib_umem_release() handles both regular and dmabuf correctly.
> 
> For dmabuf MRs, we need to protect against async/concurrent revocations. I am
> currently relying on the ib_umem_release to do this since it causes a
> synchronous revoke (with dma_resv_lock held) and also ensures that no revoke
> callbacks will occur after return.
> 
> In the normal irdma_dereg_mr flow, irdma_hwdereg_mr is called prior to umem
> release and isn't protected.
> 
> One solution may be to wrap the irdma_hwdereg_mr call with dma_resv_lock/unlock
> if it is a dmabuf MR, but still requires a bit of special handling
> compared to normal
> MRs. That said, I could mark this state in the internal iwmr rather than peeking
> into the umem like this. Then, the rest of the routine would be
> identical for normal
> and dmabuf MRs. It is worth noting that the ib_umem_release would
> still result in
> a revoke callback, but this callback would be a no-op because the MR is already
> deregistered in HW at that point.

I asked because I'm working on a series that removes direct access to
umem_dmabuf from drivers and instead provides them with a valid ib_umem, which
may be of a different type (regular, dmabuf, or other).

So, in my view, all drivers should follow the same flow, allowing us to
perform lock and unlock operations in the core during the call to
irdma_dereg_mr(). However, it is not clear whether this can actually be
achieved.

Thanks

> 
> WDYT?
> 
> Thanks,
> - Jake

