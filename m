Return-Path: <linux-rdma+bounces-12652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F9BB1FBE0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 21:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18AF3B85C1
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE4205E3B;
	Sun, 10 Aug 2025 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CXFHVZTw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01F1E515;
	Sun, 10 Aug 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754853983; cv=none; b=p2A7qPAt2jfWiLBcI3R/3gP2+Ax3LIP77SV06AlymEYckMk2khT85Msh/LEAvN24+mFT/pHQT/1qIsorYTdU8Dk9MintfueGXL1EMFh+YbsTdCAOw+gjElElYtwRMKsVg83Xqez19mmC8zfpP37IERntYMnEMNc9CXyuryLX0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754853983; c=relaxed/simple;
	bh=VfQIcjbJkUCauoLPvmbUHT51tS/zQlZt08O8ns7Am4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhzNKU2t6kWT/AzFDSmKw7YtkeJYJgd/JdtaoHDe3TgqDUkzO6//JsJG8F+01YpM+ABNRFVa767HEpSCZJHiLVs0MeuDnWkhgsIiyyMduD/pxgVsWOtp9jhtb/YGTq/FBFGDhkiD90NXzWs0Vdb30R0lkwSZXFSRG/HqtD1hp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CXFHVZTw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sK4gl5P6D4Zp0gdwRRxyt4cXzSzw8XFOQZ3bGrXhRnE=; b=CXFHVZTwqvyvSZKCuqQ38alkjj
	7TP8wmeEF1rQutrqdTiGI1dD9Nb2wfPpfCTuMEsThMk4z38WxK7b3D0NwRZWo4+9FlWdg7/GpE71x
	Fc9R2mBxloCNXK13ZxeDS1+Drbe1ProyN2haaP/QxFdpY3kvEdhVCFkB8KQreUyTqLmJAAflpsIGI
	qk+I/R3eVXviWybv8ZhNgEZbktuw9cwC9Dl7799M/oOF9O/gJaf+v35xuYaO9N+9TMC9YrGccV9D5
	9AU4XH/jq1JgN8wUX9TE1rE6juYJn2sElnZEEG2OMUBesxezRMLLSjz9HVf+wOl6VMNWZbLl4BnvV
	YBJQAUww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulBgL-00000009m7K-04YZ;
	Sun, 10 Aug 2025 19:26:13 +0000
Date: Sun, 10 Aug 2025 20:26:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ujwal Kundur <ujwal.kundur@gmail.com>, allison.henderson@oracle.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rds: Fix endian annotations across various
 assignments
Message-ID: <20250810192612.GO222315@ZenIV>
References: <20250810171155.3263-1-ujwal.kundur@gmail.com>
 <20250810174705.GK222315@ZenIV>
 <20250810182506.GL222315@ZenIV>
 <398e53d8-906d-43c9-9395-f6115dcb945b@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398e53d8-906d-43c9-9395-f6115dcb945b@lunn.ch>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 10, 2025 at 08:41:49PM +0200, Andrew Lunn wrote:

> This smells of an LLM generated patch.

Maybe, maybe not.

> So i think you are somewhat
> wasting your time explaining in detail why this is wrong. Well, maybe
> in a few generations of LLM it might learn from what you said, but
> that does not address the immediate problem.

You do realize that there _are_ humans out there, right?  Ones capable of
learning, that is...

> We need developers using LLM to accept they have often wrong, and you
> need to spend time and effort:
> 
> 1) Proving it got is wrong.
> 2) That after a lot of effort, failing to prove it wrong, accept it might be right.
> 3) Proving it actually got it right.
> 
> It took me about 60 seconds to prove the POLLERR change was wrong, and
> i know nothing about this code base. So it is in fact not a lot of
> effort.

