Return-Path: <linux-rdma+bounces-16475-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBSFHp8rgmlxQAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16475-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:08:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0737FDC856
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E04F9314F215
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764753D3337;
	Tue,  3 Feb 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nvBSq4FG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB230171E
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138101; cv=none; b=MUL3qkzkt4U5QBf3k5bXs1ow5aM2/6kPGtpV0MbaFCV/L19TiYyYz2V2WMMNWY2YB4Nt2wR7e+3wGXPFLT3A+oRBZxoEjqiVeksbxyBAOdAlIbV6nwyad44J+VnyhSAGF55SPXOUTI7wKEkXna6pxhSq43bKVFu7rQHYH68o8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138101; c=relaxed/simple;
	bh=t3RwcOUpAxKZljJomDPYjIIiia2Y/M3vNvS5uFx/fgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCrMujhnGCp+8alsXLuUkStNNKDUs6m0I22LTgEACVjzmXggYag1KvYyT1c9a6MrbVgrcqR1AY2riM1AfpxhMW/DSSgQPeVISO/LyPgXA0KCbJgW734zFYvRUasynM14C9yfQ/ZfJvsNyylY7zIAWrz9/yYTUatyJhf37tvJ2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nvBSq4FG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a35a00506so103487186d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770138099; x=1770742899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDNqZKwZJA+RRf9ErxFC4XPpNaLdQ6eQtvoonzW/UVE=;
        b=nvBSq4FG1Q2LVZs+tH17XJoP2LUhfCvDAm660XKBwyxf8/0kFX5pEht05d/lOwWzql
         hiFYCzd/lKD2Q6bF4fcZU/q/5TTzrsJ48ohsDxaZnqF154n7csnQoEo4xb+SVVvSYx2Y
         yO9qRDc+3Salv6wXoyGkn9S6bkoWjlDNFQvxhwPS1oDxehPFXn4SRkZaBfxDLRNC4Zv/
         iO5wyh1OVS6eTshgx9aZZOF8AE0MfXzsIu0SCXfsY9nsUjZqkD7f6FWOmWaOgWPjFFWr
         ndGwbQI+nkVhLsk37t7Tjqhm1cQMP1T+CvEG1ETtb18j2mVInYAZZAm8c/cyYYryVZv3
         4eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138099; x=1770742899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDNqZKwZJA+RRf9ErxFC4XPpNaLdQ6eQtvoonzW/UVE=;
        b=jf60wt+WyE9VpENUfXZR47Z/8dYI9SzGeBK/qMa28WEmBVAL7+M2DZR5PkCYzrecyS
         p9V+eYMgDp/aY0BEyrss1w/uy4Y4IWLc/g1BXi8Nxk9kJPlayJ6BxzjNksA3O5YODw7W
         t4D8/p+NzJbnuzSDJWGstRC6LEUU3qgASeN4rZMdUwcvOW0iTfvgaS5i+HFKj7AVds17
         +RKnM8YBMKDIw4LcmXtp0PbHqO3TLR+fkwGmzGjT+jPNuiyMmuGw8BdeNZ9nxa/OwXk0
         Vs4k15OtnMDWyqdcOUilZ8jwOEuAinxt/Wn2aCXLjKqtDClnHcWl1OCdrwvPPlnIBQjq
         uyhg==
X-Forwarded-Encrypted: i=1; AJvYcCWoqnfml8/G2aQjkBAn5C8fiGj5usJKhohgxC3Fp4O3Q7wP1BynUIxG7OZ4ZdaSqkAb/PwlzrMknDVk@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhD3fXR35Om7qe9MqNye4u8U7OkCJiJnVIY7XfRqUfDxq/Hq5
	0GgysKwMZGXmYvyACfnac+3TOtx3qnSKb5EgFOw9lWGHW2w7TJZeC0IPiTLyuzGXx8l850QAWMF
	NEl3/
X-Gm-Gg: AZuq6aJgzFzcgEXVEnLIOcjCP+4oj+c/bcFJAJrModfUZJAXV/IgDB0b7tzd8Mjdp92
	SCczuseJlOA1MP2fkTHHxfNLmOi8kFR1sTbU5tnd9M7G0tE9xsYUuAhshCgYvD52D+JGSaiwOAi
	y8nGhrkqniaBz8aXWnLL1ffKoqVJdHDQLf2KMh8ssCTVnvQnaRztcWMpCkjNtUPxooY+z9+nKFp
	sp3WzVafLDjgFGkkPnb/JIoZhEdsGrUqi4JkLP1AzYKWG++bLoJ/Y/oZCHUB43PCmcIlKKIZBgf
	JR85Fjl+UehU6RxL9+2Wcr9wiI+ZRCduOZic2tdKFsjYFmnBWXpLw1h0Onq2/scH308iQZgPmoG
	BzbQUKH5/9g4oT+OZ0HSk4HRVk3ETIKM1nW8HXsrIGAyEqKtI4xN9xKqcNGbVopApE37AohbV6I
	XPc3mdFVCXa3dKtf/YHEodR+nVIzfKTjJIVfJ4r7PRZmak0/cgBk4OgemqT2v3L1/E+UU+udu0j
	4gu1A==
X-Received: by 2002:a05:6214:c21:b0:88f:e332:c009 with SMTP id 6a1803df08f44-895220f5948mr1404626d6.12.1770138098825;
        Tue, 03 Feb 2026 09:01:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d3c513sm1460076d6.54.2026.02.03.09.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:01:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnJmT-0000000GZqc-2ms6;
	Tue, 03 Feb 2026 13:01:37 -0400
Date: Tue, 3 Feb 2026 13:01:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	wangliang74@huawei.com, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <20260203170137.GT2328995@ziepe.ca>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
 <20260203165600.GW34749@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203165600.GW34749@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16475-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 0737FDC856
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 06:56:00PM +0200, Leon Romanovsky wrote:

> I opted for an even simpler approach: embed the umem directly in ib_cq, set  
> cq->umem in ib_core’s create_cq, and clean it up in ib_core’s destroy_cq.

The issue is most drivers create the umem from parameters in their
driver data so the core code cannot do it at all.

The structure I gave is a way for the drivers to parse their driver
data while still keeping the umem out of the bowels of the driver.

You can lift the umems into the core structures too, but things like
the DBR with their driver-specific umems would be hard to deal with.

Jason

