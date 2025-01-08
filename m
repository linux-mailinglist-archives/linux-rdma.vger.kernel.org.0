Return-Path: <linux-rdma+bounces-6902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B87A0588F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 11:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C113A2AB5
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58351F7554;
	Wed,  8 Jan 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSR0Tjbl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE8188713;
	Wed,  8 Jan 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333203; cv=none; b=JuNqtF4s834jODPGFxJxlmUf+yZY2vggvtguS32hdQ4xiPBmVwfwIkx63qJHtVqQEGlW2HBY6IqWPP/49EzNJTrDH9WJEKRIhXaODDRlJ2Ee77rgmeB1gw7ufLDV9O1QLr0EEqLkzsqX1R3rHh3AdCrOd7AoE48w906+w+sC/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333203; c=relaxed/simple;
	bh=sVUPS0JrI1S+Tcju6QLOXcRIhwHUS7KuoqberdrIz7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTd3CCbscOLJxeDiOr2DPPHqbqGQ6Izz2YPMQHUs94Sy4deCafdkFT+xQfd0ZAiZ9aZN6sZ5I1xR8Gfbv5yNVqq7+4wTDT6XZ98/O8BXwNhDbOx7MkeyDBZmT4pHCtqYuM8vpptSw1RWcfOKPFUxbnQP0Io7x8uosRB8BHZ/FsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSR0Tjbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8194AC4CEDF;
	Wed,  8 Jan 2025 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736333203;
	bh=sVUPS0JrI1S+Tcju6QLOXcRIhwHUS7KuoqberdrIz7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSR0TjblQwXhDUQyrYvXc2OOikZaWGD2DOo0bokTL1SulXwZGtjTNjreKaO/oEoiu
	 iP12zCxeL6rOPkQxaeA4MMmkYlHU0gPPm4IW5Wvy0ed1F5vNabwIoeT8cLOtmaiBXv
	 MqdPIfImHF9PgrqolFSE8+q3VvBM7dBwpvZAyfUOIzyEGW+H/ut8Vltu9RkSGyfbkl
	 9x5tN/eG0gskA8P8bZDR3wI973tBFIIF5Gh7KQ9TVzbPEiblR7lN8od3SniOL2uPrn
	 N1vsk36/P7essz7WZcnAJAwNrsuFTPSD7axcOqhlCB4mqOuOK6LyX5Aoak0bfzIbb1
	 c2sknLBoS9bTQ==
Date: Wed, 8 Jan 2025 10:46:38 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: delete pointless divide by one
Message-ID: <20250108104638.GC7706@kernel.org>
References: <ee1a790b-f874-4512-b3ae-9c45f99dc640@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee1a790b-f874-4512-b3ae-9c45f99dc640@stanley.mountain>

On Wed, Jan 08, 2025 at 12:26:06PM +0300, Dan Carpenter wrote:
> Here "buf" is a void pointer so sizeof(*buf) is one.  Doing a divide
> by one makes the code less readable.  Delete it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


