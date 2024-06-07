Return-Path: <linux-rdma+bounces-2984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433278FFE7F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 10:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB84F1F2A24F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16715B14D;
	Fri,  7 Jun 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="um0y5LO1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645215B143
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750639; cv=none; b=o/ZPdcIo+ncf9wbqxaZBvezzsWzmFce9+1CXlURQ561LsGlySg6On3GzTiRpwebQXm3JYWhZhFme3zOhbwVkFCr15/1ySMr51ipQ7hb/LreqGlVRQZZaBhBkYJoLJZQ2i3ddvYQN/NHYxuKV5miUJhyoNi/vEHTxH1Sozppcvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750639; c=relaxed/simple;
	bh=61vVTHFebob1vxxjuIDUU7M0JBb51w6dp946OI5SAv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DIQ83km6nkSpIed7Rjvk7tlbFHOveU1CgNv/tTJuR/ooSZpLmoC1WU8NeSHgNlVeEVVPHf61/asPOVg4HHTFMj4TMgl7PXPUMc9lJqMfY4X4BSiC2gQXEt21NXFvBgZQ3miuLBySalyuPPGEcqhmBS8WzgIV3m51toHbVplETJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=um0y5LO1; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: leon@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717750634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDUa0yze7IqLKgiHYZ24zoOj9XdJdjvwiZ7E1plpfm0=;
	b=um0y5LO1gNfkDVd3ZBgLoy/hnHgeKgxyr+xJhQGAZashpbCSpZOgLyPVvAbmIvulC7NYwk
	YpCH0Wr94UET5Gd/g9P+WI2rxtXrlZ7tgQV4nVLFJJIu6QQPeBurQ1JfSzs8K1MdGQXQzH
	8GI8M/8zFSU70NTXx4RssAQgAL2JbU4=
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: rpearsonhpe@gmail.com
X-Envelope-To: matsuda-daisuke@fujitsu.com
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: honggangli@163.com
Message-ID: <4b082825-af44-40fe-a6e9-a33d7caa4351@linux.dev>
Date: Fri, 7 Jun 2024 10:57:12 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix responder length checking for UD request
 packets
To: Leon Romanovsky <leon@kernel.org>, jgg@ziepe.ca, rpearsonhpe@gmail.com,
 matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org,
 Honggang LI <honggangli@163.com>
References: <20240523094617.141148-1-honggangli@163.com>
 <171707866514.136408.14977812016177496326.b4-ty@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <171707866514.136408.14977812016177496326.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 30.05.24 16:17, Leon Romanovsky wrote:
> On Thu, 23 May 2024 17:46:17 +0800, Honggang LI wrote:
>> According to the IBA specification:
>> If a UD request packet is detected with an invalid length, the request
>> shall be an invalid request and it shall be silently dropped by
>> the responder. The responder then waits for a new request packet.
>>
>> commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length checking")
>> defers responder length check for UD QPs in function `copy_data`.
>> But it introduces a regression issue for UD QPs.
>>
>> [...]
> Applied, thanks!
>
> [1/1] RDMA/rxe: Fix responder length checking for UD request packets
>        https://git.kernel.org/rdma/rdma/c/05301cb42a5567

Hi, Leon

When I built this commit with gcc (Debian 8.3.0-6) 8.3.0, the following 
warnings will pop out.

"
drivers/infiniband/sw/rxe/rxe_resp.c: In function ‘rxe_resp_check_length’:
drivers/infiniband/sw/rxe/rxe_resp.c:401:3: error: ‘for’ loop initial 
declarations are only allowed in C99 or C11 mode
    for (int i = 0; i < qp->resp.wqe->dma.num_sge; i++)
    ^~~
drivers/infiniband/sw/rxe/rxe_resp.c:401:3: note: use option -std=c99, 
-std=gnu99, -std=c11 or -std=gnu11 to compile your code
"

The following diff will fix this problem.

"

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c 
b/drivers/infiniband/sw/rxe/rxe_resp.c
index ad3c7bf76752..6596a85723c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -345,10 +345,11 @@ static enum resp_states 
rxe_resp_check_length(struct rxe_qp *qp,
          * length checks are performed in check_rkey.
          */
         if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
-               unsigned int recv_buffer_len = 0;
                 unsigned int payload = payload_size(pkt);
+               unsigned int recv_buffer_len = 0;
+               int i;

-               for (int i = 0; i < qp->resp.wqe->dma.num_sge; i++)
+               for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
                         recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
                 if (payload + 40 > recv_buffer_len) {
                         rxe_dbg_qp(qp, "The receive buffer is too small 
for this UD packet.\n");

"

Zhu Yanjun

>
> Best regards,

-- 
Best Regards,
Yanjun.Zhu


