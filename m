Return-Path: <linux-rdma+bounces-3687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70EB92972F
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 11:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA162281A7A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9DF4EB;
	Sun,  7 Jul 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaUZZKUL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6B6AB6
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720342849; cv=none; b=UPbUVwUzsZqtlDQpmrPNhNgM5BYp0vxg256TGJfQTj6S+FilJ5rRvUMUDJY7hUgvw33oCvJ2QkeTWxWkVSA/8P+QhZeFMSmwZ3dtMu3uIiOlduuIixkX5q2L7yCYsPBiveye9SbC+/LoMhp5fqwANrDsObSiPeqf9QOjXglMNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720342849; c=relaxed/simple;
	bh=x/UtuI8RafqOU07/93I/l+/fJ7a36DS8xhbxC35BGpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYh+CrOUB3G6XLSp9JsazEsZGewt3itIOBfnZvU9xqZArDJCcLplw0qjaqAk1IDg9crLohkkp2RF8A5ffrjzF7ZuGbCsfpguSdpX8WEVqC+u3+wZElZ0P/KG+Bcy4hZIiNoO8TSCVNwzcgFGPySvYsOV2u8l5fBpvTYA6MuSZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaUZZKUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B53C3277B;
	Sun,  7 Jul 2024 09:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720342849;
	bh=x/UtuI8RafqOU07/93I/l+/fJ7a36DS8xhbxC35BGpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaUZZKULczuRzyfyyS1mjnwpU5fe0QesVYstXjPpuCXKb/bXjUJuK/l6jtmwbqpDr
	 KmiwR9vs3l244BVpZRk9cwpTrascWKx/mQb+/ISHU7Yfg07Z1gCjnbRqYlzDkukjrF
	 ygPszKlaSNy6X9pPk4++X1dta2BU6vIG0jZenVQn4Kg25V9KONOXkbx0A1fyt+9Ool
	 yv/56F/IYJUm2dH6cOWq3sGa/nPdtolN+WbT9GuwRyktTaFTDq9Z5YKB2QjNsJwhSs
	 Yfpef5mqW4S7zjdMNKWMtwqu0LjY/kq3Ou5qXVo9Lvi30r6v6E1SbNCLUbwjP2KzTL
	 octRsSmU/udfA==
Date: Sun, 7 Jul 2024 12:00:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	David Meriin <dmeriin@habana.ai>
Subject: Re: [PATCH 12/15] RDMA/hbl: direct verbs support
Message-ID: <20240707090044.GF6695@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-13-oshpigelman@habana.ai>
 <eebde0ac-9da1-4c52-b52f-a775e2c0d358@habana.ai>
 <20240707075742.GA6695@unreal>
 <e27efbb9-fdf5-4447-87ef-71e0fc34bbb4@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27efbb9-fdf5-4447-87ef-71e0fc34bbb4@habana.ai>

On Sun, Jul 07, 2024 at 08:42:59AM +0000, Omer Shpigelman wrote:
> On 7/7/24 10:57, Leon Romanovsky wrote:
> > On Thu, Jul 04, 2024 at 10:31:18AM +0000, Omer Shpigelman wrote:
> >> On 6/13/24 11:22, Omer Shpigelman wrote:
> >>> Add direct verbs (DV) uAPI.
> >>> The added operations are:
> >>> query_port: query vendor specific port attributes.
> >>> set_port_ex: set port extended settings.
> >>> usr_fifo: set user FIFO object for triggering HW doorbells.
> >>> encap: set port encapsulation (UDP/IPv4).
> >>>
> >>> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> >>> Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> >>> Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> >>> Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> >>> Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> >>> Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> >>> Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> >>> Co-developed-by: David Meriin <dmeriin@habana.ai>
> >>> Signed-off-by: David Meriin <dmeriin@habana.ai>
> >>> Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> >>> Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> >>> Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> >>> Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> >>> ---
> >>
> >> <..>
> >>
> >> Hi Leon,
> >>  
> >> I'd like to ask if it will be possible to add a DV for dumping a QP. The
> >> standard way to dump a QP is with rdma resource tool but it might not be
> >> available for us on all environments. Hence it will be best for us to add
> >> a direct uAPI for exposing this info, similarly to our query port DV.
> >> Will that be acceptable? or maybe is there any other way we can achieve
> >> this ability?
> > 
> > I don't know, new rdma-core library with new API will be available,
> > but stdnalone tool which can be statically linked won't. How is it possible?
> > 
> 
> If iproute2 package was manually removed from some reason.

If it is user's decision to remove it, it is user's responsibility to
deal with consequences.

Thanks

> 
> > Thanks
> > 
> >>  
> >> Thanks
> 

