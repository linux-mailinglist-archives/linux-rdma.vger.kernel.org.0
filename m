Return-Path: <linux-rdma+bounces-7721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A8A33F82
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 13:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D853AA4E6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5121D3FC;
	Thu, 13 Feb 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px00ozmO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C961FFE
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451092; cv=none; b=dXpO2SvdONYTf3OLYxS511NVwpMZCIEl/orVYwYZysn9YMhtq6YSgz3Ot0C7uM9ajD1s4X2ukUC6/36fLk0q9v44FCXVK2EadRaPaOZgcEtbTzSVwjrfqR2MyhV7I2wy160vLdLMdabXRgRPINLoCi2gqGcLbk6nYFT03Olz1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451092; c=relaxed/simple;
	bh=QwKjcl6WeUt0Jir9bSmUIs98fFrJ8werXFD9KZTMGfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agJaAh7xe0Nof1gOW+DKyOkDOvjITbmagxRZQBPWzAlsoZcLtcbgGS6LKYF8oKDOXiWOZ/PWj7cG/UrA+ncsRXpNFgsUeljRJrqH+wjiJpPyGUjhyl626sq48LNQa7vtlUHdrus8L9BZYQV1HCOBWYL9V8RqvBsfOdozVcFF06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px00ozmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E870C4CED1;
	Thu, 13 Feb 2025 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739451092;
	bh=QwKjcl6WeUt0Jir9bSmUIs98fFrJ8werXFD9KZTMGfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Px00ozmOTG3BcdcnHRPhnvpKC4qRJ1ZCsLO866YayTrVsp/uZov/Eu6BXKXt9P1lS
	 +KZNslrXrpOWpTac7lGxbUmr+NdBIL7LrknoDWloO3kyS0TlOKoFiCeGl6YVnQchEo
	 zIWakg9tNben7r7vVjwbDK2JBAyOIaYvoKI1ThY0oZ8nh/BHeWEZ7DzLT1sp56KUBr
	 0+7cgL8hNRVfSvnvNpueOthOnuvS3Lie/H5wLJLw2LLdEJr3tJyGRLQ8uQBbpOlajw
	 e9XwyUljT9ba9DSUklx/2ft0i4LjgYaFQAG3rxavX7EOiO1Gvc1RCfyjsPz7opdInC
	 Oo628VcXDH4zQ==
Date: Thu, 13 Feb 2025 14:51:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250213125126.GK17863@unreal>
References: <20250209142608.21230-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209142608.21230-1-mrgolin@amazon.com>

On Sun, Feb 09, 2025 at 02:26:08PM +0000, Michael Margolin wrote:
> A single scatter-gather entry is limited by a 32 bits "length" field
> that is practically 4GB - PAGE_SIZE. This means that even when the
> memory is physically contiguous, we might need more than one entry to
> represent it. Additionally when using dmabuf, the sg_table might be
> originated outside the subsystem and optimized for other needs.
> 
> For instance an SGT of 16GB GPU continuous memory might look like this:
> (a real life example)
> 
> dma_address 34401400000, length fffff000
> dma_address 345013ff000, length fffff000
> dma_address 346013fe000, length fffff000
> dma_address 347013fd000, length fffff000
> dma_address 348013fc000, length 4000
> 
> Since ib_umem_find_best_pgsz works within SG entries, in the above case
> we will result with the worst possible 4KB page size.
> 
> Fix this by taking into consideration only the alignment of addresses of
> real discontinuity points rather than treating SG entries as such, and
> adjust the page iterator to correctly handle cross SG entry pages.
> 
> There is currently an assumption that drivers do not ask for pages
> bigger than maximal DMA size supported by their devices.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/core/umem.c  | 34 +++++++++++++++++++++++----------
>  drivers/infiniband/core/verbs.c | 11 ++++++-----
>  2 files changed, 30 insertions(+), 15 deletions(-)

Applied with the following change to prevent arithmetic overflow.

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index e7e428369159..63a92d6cfbc2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -112,8 +112,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
                /* If the current entry is physically contiguous with the previous
                 * one, no need to take its start addresses into consideration.
                 */
-               if (curr_base + curr_len != sg_dma_address(sg)) {
-
+               if (curr_base != sg_dma_address(sg) - curr_len) {
                        curr_base = sg_dma_address(sg);
                        curr_len = 0;
 

