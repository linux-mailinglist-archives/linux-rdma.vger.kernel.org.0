Return-Path: <linux-rdma+bounces-12860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B677EB3080F
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 23:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2860B609EA
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558461F3FE9;
	Thu, 21 Aug 2025 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="ubtSe231"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB71AF0AF;
	Thu, 21 Aug 2025 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810675; cv=none; b=KrPQor6anCVr/ajmntJNZLiKmERqfQYdPQupsoYIKdG3W9LvN6uZU+82pZWqgJ1WQkNNRD8BG5a/1wJ7/oaWRIiZLY4Z50ZTvwT+loA5cNFd0BduNSdMOGunoyrRhuYNINvBFRwOWk1XZvp2INhg23OoO7LLdK8/HokGG93nigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810675; c=relaxed/simple;
	bh=9P2i88Ia0NANevxOTp5LAojt2DDhtMw67A8/kG5zJA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtOJXwlRkYuA0LX4ocqCygL6zpY/H8K9yUGMQV8BLTsFrdT/dBwFEoehaTUHy3DU/U6yebcNTJT46i2ujSB/d6UBKfDp6nkdqXWNPuUMYXyeA6HH2gPXqfVYn8G//nwRsCaWpnuk8UEX16M8LgTdK1/Qnz8HEvKI5QBJFJxSNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=ubtSe231; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=tqU0oHf+rGk3eaMDsAPhNeDW/ojF2ZT8hSdz45ahNO4=; b=ubtSe231K9sYmEaFEvk8mQdHJa
	FNWtlo2OeKenV3fdi/wCAsl0DacPrfUiINbL+qhDiodEJoM1uhDcnKmHgroetrVumK2ka4OgJIhlQ
	wOL5bmk8wJyWElK1DNj133TJVgMkFPK1Hxk+huUbzn6BxTJ12Q+nCJtD2tuvYF/3VLC9ov5S0dbyA
	HHqR9vHfks86jZnd1fZdJPcb+3SmBD/pnSZiH5HNjH36IuZxq7C76Ehobp7Z1ZQU9NReokkQkQgTQ
	1pHsXkcaDBsDKffIuEEenytVdOYtC5tZ3NvvRjPYTBoUGfyR45hBbDX4ldEQFYL4h7+tPlvQtIeU1
	Zrgy97oZ+EyTzni556BIAXVMaJwU82+gVffRZdvUFxxXM43vp60h+1tytGw6xInpXIkFWgEKQCfm5
	Od9QTrcVUcgavQQEWXCcQdPpT8S4y7ZvSJnzt/ISqbjAOj6T6QaRjYduYztdvx2eJEjHiO1MDiW43
	s5ll3XyVQ86BQIw2RAuQRN8f;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1upCYx-0009tU-09;
	Thu, 21 Aug 2025 21:11:11 +0000
Message-ID: <425ee0dd-328c-484b-bd05-3e043def463b@samba.org>
Date: Thu, 21 Aug 2025 23:11:10 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: struct rdma_conn_param uses u8 for responder_resources,
 initiator_depth and private_data_len
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: Tom Talpey <tom@talpey.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 Samba Technical <samba-technical@lists.samba.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>
References: <8c6027ac-09dc-4ee6-ba82-4afd897dabf6@samba.org>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <8c6027ac-09dc-4ee6-ba82-4afd897dabf6@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.08.25 um 23:04 schrieb Stefan Metzmacher via samba-technical:
> Hi,
> 
> this mail is triggered by the discussion in this thread on
> linux-cifs:
> https://lore.kernel.org/linux-cifs/f551bf7f-697a-4298-a62c-74da18992204@samba.org/T/#t
> 
> In include/rdma/rdma_cm.h we have this:
> 
> struct rdma_conn_param {
>          const void *private_data;
>          u8 private_data_len;
>          u8 responder_resources;
>          u8 initiator_depth;
>          u8 flow_control;
>          u8 retry_count;         /* ignored when accepting */
>          u8 rnr_retry_count;
>          /* Fields below ignored if a QP is created on the rdma_cm_id. */
>          u8 srq;
>          u32 qp_num;
>          u32 qkey;
> };

struct iw_cm_event {
         enum iw_cm_event_type event;
         int                      status;
         struct sockaddr_storage local_addr;
         struct sockaddr_storage remote_addr;
         void *private_data;
         void *provider_data;
         u8 private_data_len;
         u8 ord;
         u8 ird;
};

Also has them as u8...

> The iwarp MPA v2 negotiation can handle values up to
> 0x3fff for responder_resources and initiator_depth.
> And private_data_len can be 0xffff for MPA v1 and
> 0xffff - 4 for MPA v2.
> 
> I just found that ROCE only supports u8 in the CM ConnectRequest
> (and I guess it's ROCE v1 and v2 as well as Infiniband,
> but I've only every seen ROCE v2 captures).
> 
> BTW: does ROCE also support private data and if how much?
> 
> So is it desired to limit iwarp to u8 values too?
> 
> Thanks!
> metze
> 


