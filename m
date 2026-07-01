Return-Path: <linux-rdma+bounces-22657-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wB6fEm0qRWp18AoAu9opvQ
	(envelope-from <linux-rdma+bounces-22657-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 16:55:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5666EF088
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 16:55:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CbQk3WMG;
	dkim=pass header.d=redhat.com header.s=google header.b="e/boZWXd";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22657-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22657-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E24BB30A121C
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443134D4FE;
	Wed,  1 Jul 2026 14:38:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366034A3AB
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 14:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916722; cv=none; b=iqOiIr1P4hKLoEdmy/Dzu4+pSOfBHk5b1IX1Sa7GcezMJ4GofxvaVzMRdFmM2s3mexxVN9hFd1OXts8BkSOtypCLV/Uc06by2XlRPZwNX45yCxWiKrnnlgFdV5RMdy5RoCMlQbKTUaQIkiWMouCGLPOCXfnpaR+Cm9ZD73FWRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916722; c=relaxed/simple;
	bh=0YFYU1MJWgulitatJBeBn60XcAHqgrtmFbtauSxwcf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kzm0AjZdGMbXRxnAf4ZBpOmqV3Z9GRt84Y83BqPRLwhFAxJJ4T/pvExZChsInztec4nJGwYWcalDFbyUOLQe8rXFMu2h8O3wqWXLVRY5G8p8Vp08rbrR7BLcOIaJa+0XPbocqEMO9xs6QpC9yeP6StgLxSGsEnXnHqt5DVKjoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbQk3WMG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/boZWXd; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782916719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
	b=CbQk3WMGy3KKHXnnHTUYu35e87ZjLocNX/fVBif7kiAMnmHXkO64L8r/OiwmfbDCC8zPdM
	3GLAvE9aJjJLIL9NdlbPy+USAAIMuoAVDwyJrvCVSMsGQghPmJy+PyR7+QfDSgXsNkAFiq
	4NC6pOw+pmniCc2H8cW+0yOSJNhXinI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-6I23qm2UPw265ChBcrMQGw-1; Wed, 01 Jul 2026 10:38:37 -0400
X-MC-Unique: 6I23qm2UPw265ChBcrMQGw-1
X-Mimecast-MFC-AGG-ID: 6I23qm2UPw265ChBcrMQGw_1782916717
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bdaf8549so8741165e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782916717; x=1783521517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
        b=e/boZWXdpbTv8jlmCxHEkUCCe2G5Cf/AapebIjEHP87PrqYDTEPWZcioJ0MLfuteHi
         Kb5/BM6eNEyi7OaKOi3V2wxRG/DgXqyJPadpRgOa0LqXsvOBM6MWRM6TmGobu5kKQ0i1
         RiUUgGprMDwxwtDrcu2tDh1Xr/v+hdibsfq/KSQaxdvFyub3fUqabbxWpEb7vOUMusR9
         pPSvdPuCrz9G5svkW7//TWAPPBZxtcplpZqxPEt6a5V5CqFQLpsP7JtOxAvWUgWlEzRR
         Fhaecovpb5r+eYdMFH/yZGmBjxfUPBxt4IUhSeRcjdAaZwQLEae2WZeaoktvtvfXS8hp
         bnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916717; x=1783521517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrdNneIgH6yMJu9p2N3FIGNVTXTUUQ5T56Karm+HK5Y=;
        b=rFiMR6uu7mHfwV8hTPUwfy22xjnGKZ9uEMclNEid3hO71IwApPFpWZX6VZScBNNbLR
         Vw43e4c9O/6OVbJSrJ3SnSyyazKomNELAPtCaJgh3f6M6eL8poOlIvGKa/Oys9AT82Jf
         5B2O3ygmfg5fzhyD/DJ/Y7Z/e9aD16K1g2qApEYa9CziYtrUlbN4BCMc3nxvBwP0itmT
         5jkfZCr8aqx+cloRi3KfJJRHX0FuX7MGTvN03PCaFYb16/hC+td4RcaokK9zh/ja8WzJ
         wuwPjo3pIFBhTbUaYZuVbizoOSmdDPib4Lfduw8N85wrc5rI2sjV2V3kvZdyZj4gfdS/
         dr8g==
X-Forwarded-Encrypted: i=1; AFNElJ/UpooIYmwuzZ1MSHinhoIwZTxHVUXGec3qFX9kcWZJ18Ow8KLvV/4ZUi+cP3xMikfzFeTVYlMT9XjP@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPLiNknQusZ4vPg3bFK/ibvHvQYiX7QuOZNd6F5xx5+UD1N1B
	HRviMkKXZEtLnIt8C+vvlTTDu0Wy225yCmTGIEQK0oMXgB8dxEhhLofRws+XvkQy2/6uqZ7X+Y4
	sbY1/c9cCQDDENHZerDPCqAEC3bUTPf48a3y1hHGelTprDpvPjw1JdLVfCnoco812pQZxnHg=
X-Gm-Gg: AfdE7ckaTkz0KINPCjE176lM3EB0PdrHH8JuHOqiXjsiPs3wCYZdEFOep0/VAjlCo8f
	WfzeRpsYg4lKLBsBe2qaZBnWyp8zCxGhe+wB/p6/r92cpAHj3sH8BYlL1rwexeB99Dm/Sw/1prg
	PQ3Slrqzd2Mx0Q7h7jjmovnGBPk1x+7wMkIZwhM+e/J5XuJhd+w35KpoZv3Xr7bgzy3pfkVcPIM
	h/WNFyW8P2cePG3phv89S7nyp8vk18D2qdlUPmpK4S4B60repurhl9Q5VwE20z9arXlOreqq+Pl
	zNdqAxkE3yvSCRkXIaKzekcipIEPdZN6ca1Qjpqiod7H6gXk5tdHK/Otwub9P3vfyqJ2U9c5eCu
	g52K3vu7jUXxe2p93HnMnysroc1PJ/qr3rwXGWg89qdhzfDUHYXdGspGcnP6sDvzV7ZdxJad/tN
	4YRSjb4lLUGQ==
X-Received: by 2002:a05:600c:5247:b0:493:c378:18b3 with SMTP id 5b1f17b1804b1-493c37818b6mr22702835e9.32.1782916716604;
        Wed, 01 Jul 2026 07:38:36 -0700 (PDT)
X-Received: by 2002:a05:600c:5247:b0:493:c378:18b3 with SMTP id 5b1f17b1804b1-493c37818b6mr22702395e9.32.1782916716226;
        Wed, 01 Jul 2026 07:38:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4540aesm81733665e9.0.2026.07.01.07.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 07:38:35 -0700 (PDT)
Message-ID: <8138f145-6a4d-465e-a45c-b8ffbf9e05bc@redhat.com>
Date: Wed, 1 Jul 2026 16:38:33 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: HWS, fix matcher leak on resize target
 setup failure
To: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kliteyn@nvidia.com, vdogaru@nvidia.com, horms@kernel.org,
 kees@kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, zilin@seu.edu.cn, Dawei Feng <dawei.feng@seu.edu.cn>
References: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629064049.3852759-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22657-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kliteyn@nvidia.com,m:vdogaru@nvidia.com,m:horms@kernel.org,m:kees@kernel.org,m:stable@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,seu.edu.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC5666EF088

On 6/29/26 8:40 AM, Dawei Feng wrote:
> hws_bwc_matcher_move() allocates a replacement matcher before setting it
> as the resize target. If mlx5hws_matcher_resize_set_target() fails, the
> replacement matcher is not attached anywhere and is leaked.
> 
> Fix the leak by destroying the replacement matcher before returning from
> the resize-target failure path.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> mlx5 HWS-capable device to test with, no runtime testing was able to be
> performed.
> 
> Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

@nvidia team, double checking I did not miss any relevant communication.
The last process update I recall is that one of the people listed in
maintainer file will ack patches for us to merge directly into the
net/net-next trees.

Should we consider any ack from @nvidia sufficient to take over?

Thanks,

Paolo


