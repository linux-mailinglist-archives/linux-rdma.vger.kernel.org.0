Return-Path: <linux-rdma+bounces-19387-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M9nMRvD4Gm8lgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19387-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 13:08:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA4E40D297
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 619A1308268A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184A3A6EF0;
	Thu, 16 Apr 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKWZta2i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/t8Ciqh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B13A6B7A
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337662; cv=none; b=PEz0wwME3/E3iciRZNku2M1KXp+Nz6Gs5zGjb2cRqROggBFaqio8yfs1kwV81F77dOseHJpWDreREsnhVedhb3x0yrC7N/KUtEYCIiLxegEAVTKWGBGR1vYmu5p6NVi1uDdOAfTdV6MaV2jZcb9r5Ed0LvWva+bgB6s2G9E4SNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337662; c=relaxed/simple;
	bh=Mhl7VFLlNqbRmIfras34wIl2ZzIGKqWjhlH0JEJS4Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHcd4kEgZOUsSWWHT70CNV8pOBaFtQFjVCkylgnpcxMemvMILQEJHlRggw6F/tcqKt70CMdyUja29JGbTj1cHp+Auor43WY0vBSuZoSfGM5QF4Rnvdx++kcRw5409veBOPfx7kjuu8zGDs+y9A6fgnqUvgdAqF4vhnNXIBr6DcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKWZta2i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/t8Ciqh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776337658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUTt3csFTfC3dI0z3fyCkSSTe3g6lb6Iqtxx21jWaHk=;
	b=PKWZta2iDfnvb7Uua07I8jHLK554ILbpORVHLYzrA3IdRF5lbk1H6nMHOJtOfTF7moAk0U
	qMTumUWeSxCezMRXoRjmg35j1BAMu8jMoExtddsDCHPeRyUlEB45TyGkxsdPXtWCRx7QB3
	UGjmL+L/JclQgHtvfn54vJsxMga0w+E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-clzV7y2IPuqHPzoUHulrKQ-1; Thu, 16 Apr 2026 07:07:35 -0400
X-MC-Unique: clzV7y2IPuqHPzoUHulrKQ-1
X-Mimecast-MFC-AGG-ID: clzV7y2IPuqHPzoUHulrKQ_1776337655
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso506415e9.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776337654; x=1776942454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUTt3csFTfC3dI0z3fyCkSSTe3g6lb6Iqtxx21jWaHk=;
        b=g/t8CiqhVNOtPiga02YD39q71p7hCBeZ1LUvPpIPMVOsyr1wdrODAP+3PJ9wo++DN1
         LRYc70yhL1uiMxgFyIOXnxvi9+5r6X9lGdocS0dEiefd9+lJXsXbLhW/GjkfwbUSHYSw
         HgVeKIMLjWzsNDtjw0L+mF+e2kkkUiMWXf+OmARh5E7B4f5nwyYR+tLNycsxuYcJz8VY
         viJLdPpuZh1JkrPDrRXhuKcrkzt8ZHRN+yY9BSkg+Pn7e2pev6+y3R8JvGaakyEznWr1
         htKpOnp8yIBXSqFALRT5dZ+s3OzSO6f+Nrgswrp/Q24ObwTIQPU7S42RzjrhfVE8+uqk
         zC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776337654; x=1776942454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUTt3csFTfC3dI0z3fyCkSSTe3g6lb6Iqtxx21jWaHk=;
        b=rSkB5AQIpfQbjJBYYg/QVGQya73oiSyoGKro3VrxWDuxbbbMv/KDrEjEChly623Tf5
         oLBneJllAsn7tSL5ss9RQu1vWNTqElKz8Hc8U/cvKS9dm4hw9c7Vu6t/Ns7LphBRXV5u
         0c07xbLUez5tjFK0JaI/buFaPWN6/ukQ2kVvAGWVsfnELPTcY3IUaW6tWfV5ERCLG7Oo
         6uWqSyhWTOVenLH9Dvvb0XlRT1hSkhT3xYGVQdAXRJeSY2U9MDS772ASFqsOM5Utznr/
         vf3YJRb1D0M0pjk53Nr9A5Im1E3w2iDtPBW3BDtI8hROcdjDfLeDjXd5Ld8CDsKLvhmI
         gdYw==
X-Forwarded-Encrypted: i=1; AFNElJ8bMM8mIHwTMavGcTu0GuYoknWdbPaTVe7rlHUKKrmbtcQc/sgX4R1yxoehom6FopCEMSsBAxQpXI/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIsYp1AQIw6f97k49IePi3yuMAVw9gcdNtM72DyXxSFqZbfL+
	e8eNRhJwfj4jLdLNez6GZNtayC4AR5dj6V5ePUaYPXkbXSN2ti2m61gVIrJ4pYx7/H98AQpM1mf
	v1zXnlFEAUVw1SVi/vjwhdst4Fh8RsXifEHvdF7MNLkjnogEub0g5rgmpzRQLFuI=
X-Gm-Gg: AeBDieu+9dksJ1UXF22lki/lrsCRzIpE4G4Pq7iZGhExjKI1GUaArKx2A+3uF7U7tmF
	7VzdURs5bddQdhGykfaSMD2NdaxTSQaqthQIM0+EWZNVH4Uzx0lM2O6wCZAS9GmR0EEbTCdMZzI
	7viIZ5GlV2SDxkofAhZCLnOMsnJtGc7qoN+l5mxw1GTL5vzOkHDLk+bmvR37199BJdux/iMIEom
	nrGFkO+7KzQPrPaAfNiEmj/A+EvoAWWN9xlC9FwuXlL68AnQ/wAnBeKQTlbqKJ9qR40ABBMLGg6
	hIceikhZWWirQoaEOCK4+ib4Lbg/KtNz3rahqs1uY/fggCuW68aERlGNFKT0Gpo/5GymE2OXtIn
	TpfcRLJDfCSEmMV15UDo39kr9OcO+jKLtrfh084/eZOQdfduq2Vx3XdfQxFgZ8eprYGY=
X-Received: by 2002:a05:600d:d:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488d67e737amr275117885e9.10.1776337654383;
        Thu, 16 Apr 2026 04:07:34 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488d67e737amr275117285e9.10.1776337653839;
        Thu, 16 Apr 2026 04:07:33 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ea65b9sm70716885e9.5.2026.04.16.04.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:07:32 -0700 (PDT)
Message-ID: <b429c6d3-8f6a-41fb-a9e6-9867a8ee1ad8@redhat.com>
Date: Thu, 16 Apr 2026 13:07:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 3/3] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shay Drory <shayd@nvidia.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Parav Pandit <parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260413105323.186411-1-tariqt@nvidia.com>
 <20260413105323.186411-4-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413105323.186411-4-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19387-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BA4E40D297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 12:53 PM, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> When utilizing Socket-Direct single netdev functionality the driver
> resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
> the current implementation returns the primary ETH auxiliary device
> without holding the device lock, leading to a potential race condition
> where the ETH device could be unbound or removed concurrently during
> probe, suspend, resume, or remove operations.[1]
> 
> Fix this by introducing mlx5_sd_put_adev() and updating
> mlx5_sd_get_adev() so that secondaries devices would acquire the device
> lock of the returned auxiliary device. After the lock is acquired, a
> second devcom check is needed[2].
> In addition, update The callers to pair the get operation with the new
> put operation, ensuring the lock is held while the auxiliary device is
> being operated on and released afterwards.
> 
> The "primary" designation is determined once in sd_register(). It's set
> before devcom is marked ready, and it never changes after that.
> In Addition, The primary path never locks a secondary: When the primary
> device invoke mlx5_sd_get_adev(), it sees dev == primary and returns.
> no additional lock is taken.
> Therefore lock ordering is always: secondary_lock -> primary_lock. The
> reverse never happens, so ABBA deadlock is impossible.
> 
> [1]
> for example:
> BUG: kernel NULL pointer dereference, address: 0000000000000370
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 4 UID: 0 PID: 3945 Comm: bash Not tainted 6.19.0-rc3+ #1 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:mlx5e_dcbnl_dscp_app+0x23/0x100 [mlx5_core]
> Call Trace:
>  <TASK>
>  mlx5e_remove+0x82/0x12a [mlx5_core]
>  device_release_driver_internal+0x194/0x1f0
>  bus_remove_device+0xc6/0x140
>  device_del+0x159/0x3c0
>  ? devl_param_driverinit_value_get+0x29/0x80
>  mlx5_rescan_drivers_locked+0x92/0x160 [mlx5_core]
>  mlx5_unregister_device+0x34/0x50 [mlx5_core]
>  mlx5_uninit_one+0x43/0xb0 [mlx5_core]
>  remove_one+0x4e/0xc0 [mlx5_core]
>  pci_device_remove+0x39/0xa0
>  device_release_driver_internal+0x194/0x1f0
>  unbind_store+0x99/0xa0
>  kernfs_fop_write_iter+0x12e/0x1e0
>  vfs_write+0x215/0x3d0
>  ksys_write+0x5f/0xd0
>  do_syscall_64+0x55/0xe90
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [2]
>     CPU0 (primary)                     CPU1 (secondary)
> ==========================================================================
> mlx5e_remove() (device_lock held)
>                                      mlx5e_remove() (2nd device_lock held)
>                                       mlx5_sd_get_adev()
>                                        mlx5_devcom_comp_is_ready() => true
>                                        device_lock(primary)
>  mlx5_sd_get_adev() ==> ret adev
>  _mlx5e_remove()
>  mlx5_sd_cleanup()
>  // mlx5e_remove finished
>  // releasing device_lock
>                                        //need another check here...
>                                        mlx5_devcom_comp_is_ready() => false
> 
> Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 ++++++++++++++----
>  .../net/ethernet/mellanox/mlx5/core/lib/sd.c   | 17 +++++++++++++++++
>  .../net/ethernet/mellanox/mlx5/core/lib/sd.h   |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 0b8b44bbcb9e..11f80158e107 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -6657,8 +6657,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
>  		return err;
>  
>  	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_resume(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_resume(actual_adev);
> +		mlx5_sd_put_adev(actual_adev, adev);
> +		return err;
> +	}
>  	return 0;
>  }
>  
> @@ -6698,6 +6701,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
>  		err = _mlx5e_suspend(actual_adev, false);
>  
>  	mlx5_sd_cleanup(mdev);
> +	if (actual_adev)
> +		mlx5_sd_put_adev(actual_adev, adev);
>  	return err;
>  }
>  
> @@ -6795,8 +6800,11 @@ static int mlx5e_probe(struct auxiliary_device *adev,
>  		return err;
>  
>  	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_probe(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_probe(actual_adev);
> +		mlx5_sd_put_adev(actual_adev, adev);

Sashiko says:

---
If _mlx5e_probe(actual_adev) fails, it frees mlx5e_dev but leaves the
auxiliary device's drvdata pointing to it. Furthermore, mlx5e_probe()
returns the error without calling mlx5_sd_cleanup(mdev), leaving devcom
incorrectly marked as ready.
If the primary device is later unbound, mlx5e_remove() will see that
devcom is ready, call _mlx5e_remove(), and blindly dereference the
dangling mlx5e_dev pointer.
Is there a missing cleanup step here to clear drvdata or reset the sd
state on failure?
---

Please try to address AI comments (i.e. explaining why not relevant)
proactively.

Thanks,

Paolo


