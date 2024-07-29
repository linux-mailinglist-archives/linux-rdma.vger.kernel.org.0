Return-Path: <linux-rdma+bounces-4067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8B93F6D6
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 15:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5869FB215FF
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E0014A4D9;
	Mon, 29 Jul 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AgVhJJET"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CA146A71;
	Mon, 29 Jul 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260342; cv=none; b=Q2XoxFrzAlOI+zCJqKCJVlESOyMOUe+FVC6QQZHbpYT6MnFbqO3EX+wtz1OtBz38x7CYj40T4DFip3Q7i0XV7gKtYM/EWSK+adutVw9S1JWeuA5Wh1+idGgqD+pjfkW6rz0jQAxl9U5p3DU71/Pe/WYF0YiLJgm5z9sspjNw0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260342; c=relaxed/simple;
	bh=oVZFc5CBw7YA4rLnsafZusMUpxS0moOS+oXkGV9rc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHBUqd7HS+WXrqkKtXSxTjwqTlkHjKqHZhtRwyqGmOypb/PiTO6PXD3lAMZhoWWES/z9ItQm943gLwYBzIU0ZLtTz1FigxxeuXeB0jT3dRDik9bOK7hFe6Gg6vW4XTM77ss5FATGfG3ulQzeZ/E+23P0/ka8fu3kMflgvfb6eno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AgVhJJET; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C6A040E01BB;
	Mon, 29 Jul 2024 13:38:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id noWZecipXnn2; Mon, 29 Jul 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722260335; bh=6M34f2ihb4+3H0wUmQ1u+7VEn4WqvtJH076NQAw2b7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgVhJJETHkOWA4oelX7sfHwA2DziVZ7hBTiK53QUNGO1S94qfBYEpMiOHL1NpgKFD
	 PVHHDnq+ekVgm90DP64zl+TasYg9bzRJEwg/cASIM+/ONKuIEnLYxwtSMsOYzrfk7w
	 pwHnbYSE4U1cnKqr+HAMNAJdXww2S1uhFAXUyz2rK8+ixvqeMqa6MYTcY3u5uiBReB
	 +CA277WoEV7SQhfeeIKNz6OmheErotEVBTGQmeZNYLktll2N9b8nfGy9FEUFpbezn3
	 50VP7NAx94q1T6A5kxEHwOBTrFj3pjlwWuYPsWmfmD7uSeDU48MOqUvcw2rfiX8qUS
	 FBlYhK5AGW+o8w6fr9JA9N+/yayvOKhDO4oKoN+1Wnfao2AFiG5VQuOt8+703je6QG
	 GKbTdURnPf/ZaK9PSGQr3C75EIvsPj6LdktgP9YnjeVpbh4HAQ3Rp1UaX3lDINJ67H
	 1N/uh7DIy3V5ehdmj7tzHbEv6DE1ocaiOF/2hUPcRd6ngk9e91Q2E9U+w1w85/k51s
	 o5qvqEFLdLkA344r7AJxTl3b+sBXAPzxb4gvGLsoPnqN7RD66Si9PjzCGvK9bO0Zz7
	 mfJuXUTOwZsI+IZh8tz+wlYqXNDehGdGtQUg07YzQNklG1cktApc24DDk3PgwSCW+t
	 vadOGg3X2rCMnUHOGzj86Z9U=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D59140E01A8;
	Mon, 29 Jul 2024 13:38:46 +0000 (UTC)
Date: Mon, 29 Jul 2024 15:38:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com, shiju.jose@huawei.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729133839.GDZqebX1LXB-Pt7_iO@fat_crate.local>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729134512.0000487f@Huawei.com>

On Mon, Jul 29, 2024 at 01:45:12PM +0100, Jonathan Cameron wrote:
> One of the key bits of feedback we've had on that series is that it
> should be integrated with EDAC.  Part of the reason being need to get
> appropriate RAS expert review.

If you mean me with that, my only question back then was: if you're going to
integrate it somewhere and instead of defining something completely new - you
can simply reuse what's there. That's why I suggested EDAC.

IOW, the question becomes, why should it be a completely new thing and not
part of EDAC?

That's all.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

