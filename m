Return-Path: <linux-rdma+bounces-20954-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALlxKs8bDGpJWQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20954-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 10:14:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E286579C30
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 10:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8C4304F227
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E93E00B6;
	Tue, 19 May 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7FXl/5l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPXkKFkO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C43DE447
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178206; cv=none; b=GNRnJBD0z7FT1J0zbukzfydlsfJ36YJBzSVr2JiXie9QPemBbjNL72OT2gVCJAp6H5XoSRKVzzuk4NgZ2+GUhESt1axtumrpSNTNqpgOpKT+lYTv4VmpgmHgcpTZuDgvdIPt8yBeYPb4P9TcbgDOa+kcaDwCGausf6MQ3Q2tsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178206; c=relaxed/simple;
	bh=Nz3rSNu9zVS3yzH3mh9tWAgp4wMrjab4VlPPaO9g/iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itMrdW7CJ2kdi/KZu7U6a/6WZOL6EJtsp51CyeLbgAeQvBUcvbw4RCRTEGXiBqU1KCXkDQ+wxkp+jOW0lM+vC1xiRmrICeZAGLMEN4dknxxoAwhXa8h+4G7gzfuotZP6IDT7QE1O84ZRE+5UdE88JCHJif80c9f+O2kwjln1Aek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7FXl/5l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPXkKFkO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779178204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hz4WqFcaJrUTE5OjjN9FY4tws1Nc4Bwkqhu4It5u51A=;
	b=h7FXl/5lkIbYS/QaS065L5A4IVUHbRmqxplHRxEOoFB1z9gPcJ+oigUGUyinmblIbA45Ig
	oFhchJZIzXXWX19tKkBAZLEZOmMLJAZ0NvX7nTctmAbgawjtmjgMwr/W9PWf/1sJ5cBNYY
	XBMZzbJfEUS0DrnhFjiuuDbNLIL19VM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-LQ2gxXJ7NC-FwuCR4DoFWQ-1; Tue, 19 May 2026 04:10:02 -0400
X-MC-Unique: LQ2gxXJ7NC-FwuCR4DoFWQ-1
X-Mimecast-MFC-AGG-ID: LQ2gxXJ7NC-FwuCR4DoFWQ_1779178201
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd9c22b8fso26316795e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779178201; x=1779783001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hz4WqFcaJrUTE5OjjN9FY4tws1Nc4Bwkqhu4It5u51A=;
        b=VPXkKFkOYknpbr5B4+CXMWlB/vLw5QfPwcXDWKRd7omJYRx8JY/Czi9PU8mt0RF1WH
         FGtmCiyWrVBdMvwIGBjHYLBD0Qx0iEKT/71vqpGeczPd9V3693D7eZ6Ep83mLtjQdPUp
         +XDnp3rSDqqPkZDPgYn3cbxEMHU27ALye6ZPaDHvVh69HSl6KekSc/zd/vguC/8yPCR6
         pLwF23DyHNEqQsLkDwsnAuPnNq19peCsiYfCztRagkdutN6d8Pdl1sjYZrz2KEMhWP5c
         +Cwr6fKT4RqkspQKtkPJXU7TIi1SMg5O8fHFoQdNIKOZQsdbt0/duBnYboiB4TRp3O7w
         X9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178201; x=1779783001;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz4WqFcaJrUTE5OjjN9FY4tws1Nc4Bwkqhu4It5u51A=;
        b=SQWZTcv5AVMSbL/oPasx65yyZT+9M2NqOfgM75tpUPB53L3xWUVb830fRW0/3sTumu
         GzH/cDlrdqiLvV14JnfNFSck2+fdWRoVpSgjahLrrlOthd84YEY1W0R0ueQ8Rt9dVtnx
         wYl3r1jJLS+hx4J7ZD9nWfAfMf98MoMpDTIIICx2lZyeeE+P0pgypFFrQah7QawQNbeG
         oVxKRMtgAD2ctLs4XYLqfkpqiSe+vs30Flaet2yQBZmJZhekBcl5R97XxDo7/BZHMZ4X
         TUVVyTsopJ21UhQFv8/88ckYVLJlavhtm82RTvGVTNo1nVDE7yfT2lqlaCcDjOfde1Yh
         1W3A==
X-Forwarded-Encrypted: i=1; AFNElJ/YGBlfw6JjODaCuO7XsJIxVnnCW/Aey+6Ea7zAMQww6vEqcqmG2vUTj7ZcSltW/STXCIyHPbVq1Xch@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJRbHXfhGT7M8xbS01wcI6l9nwAVrx4lHHg89ENtr8Z5lHZWj
	vt4lcj0CNVPZ4W7KlHy9S2SHlwPqu/rtK98B5v1V49zzg2dqT8/8Ms3o7XVMMx7mz/UuLyer6kz
	Y+xOERKpqAWqALMh4llyEGzo6XIugJRfYddwlMMsTQCuA5x8W7via6LLuJ/kIAmE=
X-Gm-Gg: Acq92OE5aWOXmVdZQIXyvtzjvVjdH1it6ad3yvE/RZslU5n+OPn2Rp5auUYqvCM5pHZ
	Aq+k/forzkKht4OOnb5gKIaiyS2YPRdntfRjBx7nhI8ozJ4p4ZC58mw0e1ADMHwpuCl3yBj8Udc
	pQlAX7wIkshIWDif1UC7uujwLdPrt2nsF5goy3HwbNsOl2K7FDLIYw5nTLKMHiqwW8R6kbUqEh+
	+7fwoVPOlhqWBiWnC/sz+kgb183GvBiMW78aVb/zb8MZw1nXqjwar95QdZd/Xd3KY3HElnkqGxU
	SWNmX/X29womdWaO1nZ8y05Pex0XKQ/TkMBE8aydVnhP99aVAV6mHU36IYSxdqGzOkxZykGaNzA
	p/VsxYtj2gF13P3o1CKUXdm2Zwu4Kp4xYqq7qu+Gr847ZntUuLZNw9Cs=
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48fe61f2768mr209624225e9.15.1779178200616;
        Tue, 19 May 2026 01:10:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48fe61f2768mr209623505e9.15.1779178200067;
        Tue, 19 May 2026 01:10:00 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm44145281f8f.35.2026.05.19.01.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 01:09:59 -0700 (PDT)
Message-ID: <c7e0dd4f-e34b-42a6-ae4d-8060a59e9b8f@redhat.com>
Date: Tue, 19 May 2026 10:09:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Skip IPsec flow modify when MAC address is
 unchanged
To: Simon Horman <horms@kernel.org>, tariqt@nvidia.com
Cc: edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, borisp@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, jianbol@nvidia.com, cjubran@nvidia.com,
 acassen@corp.free.fr, kees@kernel.org, Jason@zx2c4.com,
 michal.swiatkowski@linux.intel.com, fmancera@suse.de, antonio@openvpn.net,
 cratiu@nvidia.com, ecree.xilinx@gmail.com, sridhar.samudrala@intel.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, leonro@nvidia.com
References: <20260513190226.335562-1-tariqt@nvidia.com>
 <20260518112710.510979-2-horms@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260518112710.510979-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-20954-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lunn.ch,davemloft.net,nvidia.com,corp.free.fr,zx2c4.com,linux.intel.com,suse.de,openvpn.net,gmail.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E286579C30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 1:27 PM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net/mlx5e: Skip IPsec flow modify when MAC address is unchanged
> 
> When a netdev event fires for an IPsec SA, skip calling
> mlx5e_accel_ipsec_fs_modify() if the MAC address has not changed and
> the rule is not in drop mode. This avoids redundant hardware updates.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>> index a52e12c3c95a2..f567cd801adb3 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>> @@ -674,19 +674,26 @@ static void mlx5e_ipsec_handle_netdev_event(struct work_struct *_work)
>>  	struct mlx5e_ipsec_sa_entry *sa_entry = work->sa_entry;
>>  	struct mlx5e_ipsec_netevent_data *data = work->data;
>>  	struct mlx5_accel_esp_xfrm_attrs *attrs;
> [ ... ]
>> +
>> +	if (ether_addr_equal(mac, data->addr) && !attrs->drop)
>> +		return;
>> +
>> +	ether_addr_copy(mac, data->addr);
>>  	attrs->drop = false;
>>  	mlx5e_accel_ipsec_fs_modify(sa_entry);
> 
> If mlx5e_accel_ipsec_fs_modify() fails (for example, due to a memory
> allocation failure), does this early return prevent the hardware state
> from recovering?
> 
> Since attrs->drop and the mac address are updated before calling
> mlx5e_accel_ipsec_fs_modify(), a failure in the hardware update leaves the
> software state out of sync with the hardware.
> 
> Prior to this patch, a subsequent netdev event for the same neighbor would
> unconditionally retry the hardware update. With this patch, the early return
> sees the optimistically updated software state, matches it, and skips the
> retry, potentially leaving the hardware permanently stuck in a dropped or
> failed state.

@Tariq, @Jianbo: I tend to think that the above qualifies as
pre-existing issue: when mlx5e_accel_ipsec_fs_modify() failed the S/W
and the H/W ended-up in out-of-sync state for a potentially unlimited
time even before this patch. WDYT?

/P


