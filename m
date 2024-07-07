Return-Path: <linux-rdma+bounces-3681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D761B929702
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 09:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DCF281E11
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBAFF501;
	Sun,  7 Jul 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEhOyE54"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB77E54C
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720339067; cv=none; b=rfI36FjlYvYhh5kGJGs6lpcd517V5PITjUm7LaSKGioV8lSwci+dvKLuI4ycd0ggcjVT+w6UfTixkuZMAJwjw4TJ2LDC6+WuVOfMwcvmoymb0rsVlcqXIoqlUImI08I6dg/jL1AYCV9MApgNgMUScgCFcDYi3P6pUqI9Pl1fDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720339067; c=relaxed/simple;
	bh=It8UIdY11ReFOcAaNoiPueJACmDj0TSPm4E18Vf8yFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2/hbLz02pGXJIAN49Um6Et5Ez7feGx4RSRt0+e9+S1Q4KPfCE7pVm+9cy0yhls/53Zc7AVH3gdGl33J/ZTPPk/aKe1y9cuNU3fitoyNEsFGMJ0OUAiT+0jbmUCh71ClAuYEXHFGSPJ2FugiLCELylSLBdaV7nw1He3AhmfA74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEhOyE54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF36AC3277B;
	Sun,  7 Jul 2024 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720339067;
	bh=It8UIdY11ReFOcAaNoiPueJACmDj0TSPm4E18Vf8yFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEhOyE54InEI/61ongTLP6QG9eomZBJWJHJGvjW6yRwyFa7TdeggJA4QWvdBgReet
	 viOC8xPO1z245VEj9u1ce83WaSQzKXoOrrb0Y8hciPW2p80WBevT7XX97+uX3J+BDw
	 w+xacoU5pWbQqDq2dxF2D3U5a52WrfgRUevKA5cWkhSvkNUlSnupSJmGokfGUoQYzu
	 0LgS34GrkV1qAZ7CDzQByTRHfzpcUl8yLrero5da5hJ5wcC59IAEQ7maIXzt5sdIhu
	 wYJTS5oVoQ+mJEg1PBgFZts7vD4kosorYs9kRZpYwyTdxdlP8KTk/F78HU+0BWm43o
	 RMVbpAHHghsQw==
Date: Sun, 7 Jul 2024 10:57:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	David Meriin <dmeriin@habana.ai>
Subject: Re: [PATCH 12/15] RDMA/hbl: direct verbs support
Message-ID: <20240707075742.GA6695@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-13-oshpigelman@habana.ai>
 <eebde0ac-9da1-4c52-b52f-a775e2c0d358@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eebde0ac-9da1-4c52-b52f-a775e2c0d358@habana.ai>

On Thu, Jul 04, 2024 at 10:31:18AM +0000, Omer Shpigelman wrote:
> On 6/13/24 11:22, Omer Shpigelman wrote:
> > Add direct verbs (DV) uAPI.
> > The added operations are:
> > query_port: query vendor specific port attributes.
> > set_port_ex: set port extended settings.
> > usr_fifo: set user FIFO object for triggering HW doorbells.
> > encap: set port encapsulation (UDP/IPv4).
> > 
> > Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> > Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> > Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> > Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> > Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> > Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> > Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> > Co-developed-by: David Meriin <dmeriin@habana.ai>
> > Signed-off-by: David Meriin <dmeriin@habana.ai>
> > Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> > Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> > Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> > Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> > ---
> 
> <..>
> 
> Hi Leon,
>  
> I'd like to ask if it will be possible to add a DV for dumping a QP. The
> standard way to dump a QP is with rdma resource tool but it might not be
> available for us on all environments. Hence it will be best for us to add
> a direct uAPI for exposing this info, similarly to our query port DV.
> Will that be acceptable? or maybe is there any other way we can achieve
> this ability?

I don't know, new rdma-core library with new API will be available,
but stdnalone tool which can be statically linked won't. How is it possible?

Thanks

>  
> Thanks

