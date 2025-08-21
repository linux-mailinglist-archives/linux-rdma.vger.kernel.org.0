Return-Path: <linux-rdma+bounces-12859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC1B3080C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 23:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E34B1CE371B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6C2BE7D2;
	Thu, 21 Aug 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="SHwCt9vN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E351AF0AF;
	Thu, 21 Aug 2025 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810274; cv=none; b=USZE/+kFiikS3KtyLCJ12O53Ep2z1n4vExPB5I4b69vJ73xrLgDnWJAcySjDIxM8GhSrJCwDO+RoSKglty8+kI8nMqd0knbAY98tB5UJpvyVNDie37dFKpGueErN22euDniYsxrewEBqz3BZmUzEtKWRCf8QTTWBeOkCEUBJl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810274; c=relaxed/simple;
	bh=pcTictSdu2cKxhHDYI6mD/Fr7x7HY7VuUeyaz/rTLzY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=H4l6/CAUIPoA4rdy4DgVciSc0wmJM2v1GHhzBwWWMu3eGCn4NjMC3qT4g9b79j/diT5aumEEXEv3uaWV3hmBPEkUToemeEoxgO+PtYA0w1Uo3+NXTS8YqFm4jXzllUiiPsM9LYPH1Hvd05TWqWf99dXBrgOvi9NWVya0mRPN7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=SHwCt9vN; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=BqFDRZEHd3foG9Sj4qHXSiyNL6eVksh4rYIrvyc67lo=; b=SHwCt9vNEjPbqbLaPSRmjkwHHh
	on5NMj2iVRZfj/FA7IMl3GqB+C62zQPuqQYzKv3dC67mhbnUHNhMcYJI5yA4QnT9rTorhzYUQFypp
	VO4xaLn0UTZfdFXoC3wprX2vKsH4BHdn9/Tl/LeYE9fgMLstOVSM+jchkHbjRSZS9vE+YoN0/SpJA
	r2G0YH8UpixXoEz/ZL8C02RxSdRAEWw7qjpjNusBPNrtok8E/MPL6UR0pq6AUqmJPNPLMqUG7Bpiz
	D8yDr8U4MaF/NUq0weUu53EeH/vqkx2SnXVbbVcKMsH+1W92G/I3OeH0jVMm2QQjCHMgL9fDxuNoV
	UrbbwJx4t6yHa1modBQhch4py/kY6HgVNEUw5/6xJB6jFkJmFypO8eUFdAyhK+YOKFfhbbwt/pA9d
	8XwZ0GzCujtsf7t7thsyz5abs95/hGQI8RAEttw7flN8wKiZstHnifvucXt2CKHPbGyeh4lbCw+T4
	BBkibRuy8qRWEegWGrlLfaIE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1upCSU-0009of-03;
	Thu, 21 Aug 2025 21:04:30 +0000
Message-ID: <8c6027ac-09dc-4ee6-ba82-4afd897dabf6@samba.org>
Date: Thu, 21 Aug 2025 23:04:29 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 Samba Technical <samba-technical@lists.samba.org>,
 Tom Talpey <tom@talpey.com>, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>
From: Stefan Metzmacher <metze@samba.org>
Subject: struct rdma_conn_param uses u8 for responder_resources,
 initiator_depth and private_data_len
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this mail is triggered by the discussion in this thread on
linux-cifs:
https://lore.kernel.org/linux-cifs/f551bf7f-697a-4298-a62c-74da18992204@samba.org/T/#t

In include/rdma/rdma_cm.h we have this:

struct rdma_conn_param {
         const void *private_data;
         u8 private_data_len;
         u8 responder_resources;
         u8 initiator_depth;
         u8 flow_control;
         u8 retry_count;         /* ignored when accepting */
         u8 rnr_retry_count;
         /* Fields below ignored if a QP is created on the rdma_cm_id. */
         u8 srq;
         u32 qp_num;
         u32 qkey;
};

The iwarp MPA v2 negotiation can handle values up to
0x3fff for responder_resources and initiator_depth.
And private_data_len can be 0xffff for MPA v1 and
0xffff - 4 for MPA v2.

I just found that ROCE only supports u8 in the CM ConnectRequest
(and I guess it's ROCE v1 and v2 as well as Infiniband,
but I've only every seen ROCE v2 captures).

BTW: does ROCE also support private data and if how much?

So is it desired to limit iwarp to u8 values too?

Thanks!
metze

