Return-Path: <linux-rdma+bounces-5197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AE98F850
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 22:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AF91C21574
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DC1AC884;
	Thu,  3 Oct 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xk/+/6N6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAFE224D1;
	Thu,  3 Oct 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989005; cv=none; b=D2ypLaBG6rQplNvgvs3g2rvzsdNwlmNhVkOPdkyWuAyrWrhAv6pOMajyAz28kD7LIEg/lO2cupQAcUyoPbnUySmx9uTvVdFzDP5gEWU04EKJtfayZl7Qkre8w4rN3RziFvIMn3BaC/vxSPI8boCE72ySKh+5ABSLxoe++vat65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989005; c=relaxed/simple;
	bh=8cFxwG+dqzF652zgqIDsS6aXOxw1y9pY53x2OgkRKsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f+ZJQ72qzG7C9keq89Q4OhMFKs6zsgYLVrDSh6sIQ0twMYgW4lTczrFzjBVm61JX/7haLU6UGCWqDiEoWP41Rvi70S/jBVz9kcBQuIyPgP/jeOZ+6tp0tyR0PvNuZ7Fom8oen3SsAVQ8kpo9ACoBq4jZmKWgPqOjHi/zXS28uxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xk/+/6N6; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XKP9d3r9lzlgVnY;
	Thu,  3 Oct 2024 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727988995; x=1730580996; bh=FTm9+Fd9U/H4haC16sHTR1bT
	ESO2Tnj8MtorXX9dHs8=; b=xk/+/6N6QppPaTwrc2/ZXsj7P0XkCx6/abEpvUij
	7rnzdtFkmXCvnGQ4WT4/ROVVqQIWjE1GhpClMCwptIEXn9w3ODdu2lepfN1d555H
	yXw15gb0ui1kT/tG1PKxhSX09JjcUVSPhdD0JVgteokPrfxlxKnJtAxSdnjVWXP2
	xJNDOpzJOoxivlrpxMLynthyTW/4UykYwKxUyTxnvelDN2Oqtwh/cFGCGxGEi1GG
	VLg50OPsv6B1vbWzD0Sdz6VDL1iTfbimrklp8ua2U2UDeIKdhXGUGHBmPgudS9Dk
	3sQevp889vWwxaYwUCvuG+kD/tb5ChPjxaP81gsLcc2foQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xiJGC-xD0fY5; Thu,  3 Oct 2024 20:56:35 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XKP9Y5388zlgVnN;
	Thu,  3 Oct 2024 20:56:33 +0000 (UTC)
Message-ID: <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
Date: Thu, 3 Oct 2024 13:56:31 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 1:02 AM, Shinichiro Kawasaki wrote:
> #3: srp/001,002,011,012,013,014,016
> 
>     The seven test cases in srp test group failed due to the WARN
>     "kmem_cache of name 'srpt-rsp-buf' already exists" [4]. The failures are
>     recreated in stable manner. They need further debug effort.

Does the patch below help?

Thanks,

Bart.


Subject: [PATCH] RDMA/srpt: Make kmem cache names unique

Make sure that the "srpt-rsp-buf" cache names are unique. An example of
a unique name generated by this patch:

srpt-rsp-buf-fe80:0000:0000:0000:5054:00ff:fe5e:4708-enp1s0_siw-1

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c 
b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9632afbd727b..c4feb39b3106 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2164,6 +2164,7 @@ static int srpt_cm_req_recv(struct srpt_device 
*const sdev,
  	u32 it_iu_len;
  	int i, tag_num, tag_size, ret;
  	struct srpt_tpg *stpg;
+	char *cache_name;

  	WARN_ON_ONCE(irqs_disabled());

@@ -2245,8 +2246,13 @@ static int srpt_cm_req_recv(struct srpt_device 
*const sdev,
  	INIT_LIST_HEAD(&ch->cmd_wait_list);
  	ch->max_rsp_size = ch->sport->port_attrib.srp_max_rsp_size;

-	ch->rsp_buf_cache = kmem_cache_create("srpt-rsp-buf", ch->max_rsp_size,
+	cache_name = kasprintf(GFP_KERNEL, "srpt-rsp-buf-%s-%s-%d", src_addr,
+			       dev_name(&sport->sdev->device->dev), port_num);
+	if (!cache_name)
+		goto free_ch;
+	ch->rsp_buf_cache = kmem_cache_create(cache_name, ch->max_rsp_size,
  					      512, 0, NULL);
+	kfree(cache_name);
  	if (!ch->rsp_buf_cache)
  		goto free_ch;



