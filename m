Return-Path: <linux-rdma+bounces-10546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 664FEAC10A3
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B851BC77B7
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE89F299AB9;
	Thu, 22 May 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xa8FIgBb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2F28DB74;
	Thu, 22 May 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929781; cv=none; b=bAiheDsKn2fo81PO0hxy3Sr9eTI55n0weyp/eoe43+NAj1qEROwpqTTaYWoHjcK0+D+bdl7iyUPtJ4dP6W+TGrQLaly6bRtiCsN8zh0nmWaDxdAktCSOsFInArLeWENhbwnHPd6XP2qUhhKcTW25Ka6gfmPECrQ/hVCfbhNjI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929781; c=relaxed/simple;
	bh=D6ravmCBSVatM9FHIJ31YvtkmOKYHcAxJeudYDVHco0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruav0ADPSUP9yvgC+5pWkYvfgF3T2/W+WdQsKf/KHDUprwrqe/0dAvkA/sDIgDaCy3uoIPR280t/TGxuVBa5eKzEpIreFKV+1DmCf1x5XCNRbtLVLQfDAH8N0t6k042rsakDSMZY0yE9IXQtqyFOij6VP/3oov/MOvm4EUXXZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xa8FIgBb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F1dsqNtUuf3M8zsJPk5NeexiAp4QTOkB320yTzwQKvE=; b=Xa8FIgBbD9AdgAGgb4A3Lh5FOo
	iTWFgJa73bwF7+u4DtMq8KNBzMOOXxXecUU6RmfVxKjqxaov+u2pNaqITKhYoOuPOwbG6FvQscNUx
	mNzi3zEs2nG0pE+iU9GfhLgYpY3p3Sz723VAUdhEeqlnX5f6U3K0zxLInQR9Mdtt+ML+xDk1f3yN1
	pAZJn/6tbA3invnvxWWeBKTDJEPiQIAMmFGRzsx2jStPCP2D4uzvSG7cFKBQRffnCvFDV+s9X+ycZ
	JPPxbONXG0fR31rAGYqZIaCB4GprbYFq9OWKodFYIdm3xk8wyvvyt15GuBv+MF3ecLTk3kCRl++yU
	DEd7neXA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uI8Nd-000000013Ap-06Vh;
	Thu, 22 May 2025 16:02:49 +0000
Message-ID: <0a9c4d5a-a84c-420c-a781-84b18e90d34a@infradead.org>
Date: Thu, 22 May 2025 09:02:44 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Doc: networking: Fix various typos in rds.rst
To: Alok Tiwari <alok.a.tiwari@oracle.com>, allison.henderson@oracle.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250522074413.3634446-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250522074413.3634446-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/25 12:43 AM, Alok Tiwari wrote:
> Corrected "sages" to "messages" in the bitmap allocation description.
> Fixed "competed" to "completed" in the recv path datagram handling section.
> Corrected "privatee" to "private" in the multipath RDS section.
> Fixed "mutlipath" to "multipath" in the transport capabilities description.
> 
> These changes improve documentation clarity and maintain consistency.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/networking/rds.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

-- 
~Randy

