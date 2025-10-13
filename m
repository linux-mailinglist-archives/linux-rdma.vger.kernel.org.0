Return-Path: <linux-rdma+bounces-13843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC32BD47A2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E60BD505808
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D230B529;
	Mon, 13 Oct 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km/+C7xs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D473271468
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367749; cv=none; b=aCjNkQTe66tE81QfQWRPPiYfVy1MPK61MH2i0MrhcjtIs41SdjHA+7NN6SG4ahUI35LaMlLzMalitTQEPe0Z0+9YzwEFUNuheUcKKelk3IJxiML25PpKlfqBC1QFS8DrUqD2fV0A6KaSS3Wn/f8h4T2t1K7psfKS4c0AhVyuSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367749; c=relaxed/simple;
	bh=XZ4lzHryEJQS9jgidvbUbN7osxHnfwhUvb5lDvX5gJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE9V3RmWDbBjbLohiJDaB1vOyW28huyciMgdiQjpw8Ui/8pwuZLk8itbFznAVvhhbH4KzLCTROFHH7qmNT2VBGNakFl8ijAtwo3pUMfrVTnvAf8V1j92XM0yYuLVgHpF2SbMuYiWWyNlV0q7ovhPi9R/2vkcipjqwInUxDttmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km/+C7xs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so3181229f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367746; x=1760972546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yh3tjmmjbgFKGhBWocvc5VFMFhZLywRMRFtzLSkbw0s=;
        b=Km/+C7xsfZItqUK1cRI41oQudCJQXawtSlxm2Y90QzKe9b1CH9Lue/2I7UhiV9ElL/
         QbsSPdkyMDOFYhdArM/WwUk4HrRd78V3RT1IKtSrA3tojPLDyJJgw1uFNjhsOatstdjf
         awHA8HXlg+4SOEZ9oEI0WYufnhqiDxH7H1pDa2kElbVfVK/isv9w6THHMeFYOFdsTzrT
         4XPM6rT28Dtw7BCO5UlxgNQd6gurCk9yoS6p4GVG3DiwKS/kZXmT1g4FH0o84SKujCvj
         NNq3v1ken4Lh0yVIZ4HeRdWXMC3yki6pD6VwCI9gK9RKdT3vhvmYDl93+WFdT69sWhcP
         DVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367746; x=1760972546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh3tjmmjbgFKGhBWocvc5VFMFhZLywRMRFtzLSkbw0s=;
        b=P97dvMOXffAd+4wxraIeKPwTidfbWVFqK4C/7LkghZp6FsCOO4DMLRvda8xN5JrPtU
         P/EKvDazg2uyVUFoeR575pki3TP0QFVeBZjL7Sv4iHTCUwia1+YznsU7/MJCy9MR7Fof
         Bid8s7/zGPOim51aU/AiKxOl/Db7UcezLViYeUzA/BqGxUiOVy9dCzlBRa1pKpn5hOtk
         lDbgz04kkx04JVnpBLMbT8FJBD3nUmGIzVvubdvIyjAuErzhisx9PkZyKOWxhFTNni0A
         BmeuNf36QscG38vG4755gb82wmgVcPDNe/2kmRz+z9j3bKKExlreHrwf+6j2wv5waBG6
         y2oA==
X-Forwarded-Encrypted: i=1; AJvYcCXwqksDXf96VWusyjiDLB1W99QKWOhNebsomFOxJK3AZE3EzMSjOelrWlY8pECK1MC89xLmdYDA8KRb@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVWudiVbMu6WiRFS9TIviDOJk6NemsiGbeI9f58bq8+D0FrPU
	vtRmcBdQ94/28JjEpZO3C2wOSo1VhAPUDLmDPDyqjP0VTIIrK4m7QXg1
X-Gm-Gg: ASbGncskpjyqSNz+1ZVcnDI+rLbWGTH6jSafU0ws+8a9vSKoOn/K46jx9lle3Fl8r2t
	PULFJj9ZeLGkh5RGGTKiFiRqLgXZ2IYx85zdN+UOUSbeS49DQYag5wVllybzYId87WYQdO05yUN
	WEJOQY3B/nlPwU0kfYsT1hF3YbxT1F48MQBNLd60eHadJDJ0bIHwNzEpVXo6ABq2ApLSjPu0UNS
	jCUMDP+nbFfLOjMAEjkENSHF8R1Yx8yb9LYEwlRnEzrpDNT8DWN60SsYmCEs6iE6i29EOnPxW6J
	bclm6anweHENwIJUllA0xHgDjcZ6k56k9+EZP5AlzCQoORcH1whiz4pNT+K7zYzbL8MZY+NPNcF
	qXxTs7ywK2LC3LVPTc1qMRgEYyNLjHQPnS+W97lLVZMkAC2pwChNpa5GMluVvsFR43vNGTIwwvO
	B0jQqE6D/F
X-Google-Smtp-Source: AGHT+IGNkJ4QbgL7tRzgvPN+I8L7UO5FdEYBSf53xVmGqianIIUKzVvqoD7JkSPO2wQpbIF5bLMK1Q==
X-Received: by 2002:a05:6000:491e:b0:426:d549:5861 with SMTP id ffacd0b85a97d-426d5495947mr6222761f8f.42.1760367745998;
        Mon, 13 Oct 2025 08:02:25 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm18651180f8f.22.2025.10.13.08.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:02:24 -0700 (PDT)
Message-ID: <f0e40a00-ab13-42dc-b9ca-010fd4b115b8@gmail.com>
Date: Mon, 13 Oct 2025 16:03:40 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Breno Leitao <leitao@debian.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, io-uring <io-uring@vger.kernel.org>
References: <cover.1760364551.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 15:54, Pavel Begunkov wrote:

Forgot to CC io_uring

> Add support for per-queue rx buffer length configuration based on [2]
> and basic infrastructure for using it in memory providers like
> io_uring/zcrx. Note, it only includes net/ patches and leaves out
> zcrx to be merged separately. Large rx buffers can be beneficial with
> hw-gro enabled cards that can coalesce traffic, which reduces the
> number of frags traversing the network stack and resuling in larger
> contiguous chunks of data given to the userspace.

Same note as the last time, not great that it's over the 15 patches,
but I don't see a good way to shrink it considering that the original
series [2] is 22 patches long, and I'll somehow need to pull it it
into the io_uring tree after. Please let me know if there is a strong
feeling about that, and/or what would the preferred way be.

-- 
Pavel Begunkov


