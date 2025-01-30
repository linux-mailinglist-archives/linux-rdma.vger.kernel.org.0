Return-Path: <linux-rdma+bounces-7329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4B4A227A3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 03:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6479164353
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 02:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1C80BEC;
	Thu, 30 Jan 2025 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyTvKsJv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F07433B1;
	Thu, 30 Jan 2025 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738203328; cv=none; b=sIlca1UlbnaQoIjPXavmgkcqoeSQrlHzm9EeHOsRHysBHCAQ5nCCUUxsHKQLh32oy8AkCkNcPTfvhM3HRjlQ9a5i15xOXGqohY9ifUddbwxYIZ/xv62t0/MzbQjoqEpVn7Uo7Sv/cce7THxJnjT44/MMguK08zWIVJ8kswRnYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738203328; c=relaxed/simple;
	bh=CRTsNUbgUpcoO1cuJagb2/cJuSugxV4ZBgSDa/DD+TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdCYlCGp/nPTdbXOP457ydCmLJCKAUaHg9/MtrG0F5doqXnN5Ei7WLOAWX0njEuUdNoOGb2rrIEJqBp9oaN0CZBa/ZUeQdg/Fbtxb03+TmoTuxJCnzjdk1KGOSV3nX1u2gs0qMq9gKW96xW0LJ8btMIX7UPQ541Y1CdHDC/CQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyTvKsJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9600DC4CED1;
	Thu, 30 Jan 2025 02:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738203327;
	bh=CRTsNUbgUpcoO1cuJagb2/cJuSugxV4ZBgSDa/DD+TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyTvKsJvamQuj4/90uBqDMT5cNUJSn2WDgiQe8diCKjtHeLIV+hm13n4nF9+WYHmv
	 w7RkmRCGmX4v3RUoJIUMxBMJ7Vp8bpmlYsH5YyskMDY5N9hHg996xV/tjmVto0xICm
	 lLXjfzABYwfJ0AK0bg3uVjRIswF50qk6rNos27Mu21vp8tiHmEJqLtXJCUfSQHMuew
	 r7QeNFcLia1EVdzglI86G0Sm/QMsxW9Bkcg9M4MYOr4EleUdjKApfdHpgZqJ86aBt9
	 spTdL6kRI47E+5xa4MiprEO+BY0gEQUmrvcN2e9JwU7bgzp99q7UuFPCFR3kRQGTDf
	 pQXsY+1ECC8WA==
Date: Wed, 29 Jan 2025 18:15:26 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] RDMA/rxe: consolidate code for calculating ICRC of
 packets
Message-ID: <20250130021526.GD66821@sol.localdomain>
References: <20250127223840.67280-1-ebiggers@kernel.org>
 <20250127223840.67280-3-ebiggers@kernel.org>
 <048daa22-fdc6-4f5f-9fa3-e023dc421aab@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <048daa22-fdc6-4f5f-9fa3-e023dc421aab@linux.dev>

On Wed, Jan 29, 2025 at 07:11:35PM +0100, Zhu Yanjun wrote:
> 在 2025/1/27 23:38, Eric Biggers 写道:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Since rxe_icrc_hdr() is always immediately followed by updating the CRC
> > with the packet's payload, just rename it to rxe_icrc() and make it
> > include the payload in the CRC, so it now handles the entire packet.
> > 
> > This is a refactor with no change in behavior.
> 
> In this commit, currently the entire packet are checked while the header is
> checked in the original source code.
> 
> Now it can work between RXE <----> RXE.
> I am not sure whether RXE <---> MLX can work or not.
> 
> If it can work well, I am fine with this patch.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 

Both the header and payload are checksummed both before and after this patch.
Can you elaborate on why you think this patch changed any behavior?

- Eric

