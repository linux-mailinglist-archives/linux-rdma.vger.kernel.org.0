Return-Path: <linux-rdma+bounces-15480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228ECD14A20
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2DA630C6846
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2A26B2DA;
	Mon, 12 Jan 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UBObvIhy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B6B27280C
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240431; cv=none; b=AEdAZuelxmVba5tzoYC4ZiMzy4guraKZd9+atrm01fnCo7mxQUM1OGFo9fVizjXi7Oc5Px7p7dU43nJi9SeU27j3JscjAfxnkcpRehPIuYeqB7cLU43rSPpUNwNBPPm7V4ROzKIET3WMQgz9o+laywTbdTuELlBD/C09q3M0CDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240431; c=relaxed/simple;
	bh=DV26cHA4tTFpd2Htmrcso1xk0B7TdCmlsBRPwiIycJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVEj35a+3cDDE8/zOjVjHiHb9buAG0CNVZjzh7QxjXdmTmAyfbdjpTKRNz0UJmGCGmtq+RaBNXNFsT4gNkzF3i+DfEJFMcJgicWxDZmf8OBG3GjHBKxsqY5JYa14TBrKU4fJtUzqiAs8HJaQojpo1ot4/n58DRwFVdTbNEiKsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UBObvIhy; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dqg3d3N5pz1XZXnf;
	Mon, 12 Jan 2026 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768240428; x=1770832429; bh=epiMp7pYu7B2gGgLoGRkciee
	w69eCLbu6eTAcCWY6/I=; b=UBObvIhymHNXbH5oYqWnkp17NVN2gXULYIlv8NP9
	NhPDvk8Ft/Upw+8iXk/TFQl59AUt/N+b7qTUU6ujeKaaMd+DWJGRDiKiu1G5MoaP
	iEJsyODmJPbDhFNbY0c5YFrCFJ5TSYWbKzIRE7tcOrl2XvwWZUjt8FesFrKMwq9s
	KImTaQ5Lq51RjS+KX04U8ZlgpbW488oXCqH+pZ12F5/jXgFrmBkPtujdrOVBzoPc
	yVPNGPXXDy8JEIjsLQe8BTBB3vCaGWnjszEJbeepSRkiwu4kkK2+bW7c99Vrgu2V
	QN+1yy0dVYDxZNEvGDJx3n6pA/D0ARiZmO3BLCEzzjvxjQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rVW3rRPt-TkA; Mon, 12 Jan 2026 17:53:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dqg3b2cSWz1XTcpH;
	Mon, 12 Jan 2026 17:53:47 +0000 (UTC)
Message-ID: <f2850d06-793d-413f-be20-10222e6f0235@acm.org>
Date: Mon, 12 Jan 2026 09:53:46 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/iwcm: Fix workqueue list corruption by removing
 work_list
To: Jacob Moroni <jmoroni@google.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20260112020006.1352438-1-jmoroni@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260112020006.1352438-1-jmoroni@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/26 7:00 PM, Jacob Moroni wrote:
> The commit e1168f0 ("RDMA/iwcm: Simplify cm_event_handler()")
> changed the work submission logic to unconditionally call
> queue_work() with the expectation that queue_work() would
> have no effect if work was already pending. The problem is
> that a free list of struct iwcm_work is used (for which
> struct work_struct is embedded), so each call to queue_work()
> is basically unique and therefore does indeed queue the work.
> 
> This causes a problem in the work handler which walks the work_list
> until it's empty to process entries. This means that a single
> run of the work handler could process item N+1 and release it
> back to the free list while the actual workqueue entry is still
> queued. It could then get reused (INIT_WORK...) and lead to
> list corruption in the workqueue logic.
> 
> Fix this by just removing the work_list. The workqueue already
> does this for us.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


