Return-Path: <linux-rdma+bounces-8522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E579A58C67
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 08:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266837A1682
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520D1C9B62;
	Mon, 10 Mar 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXywG4TB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D13208;
	Mon, 10 Mar 2025 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590124; cv=none; b=nVFSQissU7iRIBtS6nTWRCF8bv0g9YpLG1oNXKcbYb4SSBVI84FvTHsLT3XEJCF4/DGF4dhCpLwFzMEFilMwCss3o57+/Z9KBnVRsUJV4TfTeKcvV5oFegYDIHbIzLdon8dkORZOgnzoufFE7zzDSrPGc+veRddtC8/yHrbqJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590124; c=relaxed/simple;
	bh=7ucsPrVIHaYhcCD0/wI12KA0NKzasjhda2jaVqHkqd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsNPLVvmloto5nWskjN7a07YFtFx+ywVDDPNrRG7gFZ4PAtgEoLHoC6TRnT/RTkuRvsGakFs1s23fMLPZELTK0VuICrIQGHCll46JU+N+B7o3/hMA4rl+PSlicEkdsurHjHA+HlFQMi/0x7IC1EjrcP4KfCJwUCTp/dw0sbV0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXywG4TB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22438c356c8so36312115ad.1;
        Mon, 10 Mar 2025 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741590122; x=1742194922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ftUF1HT5WFbBrDyGxswMLPBXuZHgKRdwf2S8NVL46M=;
        b=EXywG4TBIcZ3tmFnubtYqYKb1YZAoOv9jdPmOz8Nq5dvU5O9D+tOMr5gxjkDAWdCGB
         5rf5cB40uN43rjnp1c72lqaSR93ot+066kCjMCos/Sz1TynCrEKOkV9NfNVf+K+/3aob
         zCSNVTFAIuGkr5NRsJXLNPevKBVYU4kJ2bu5o/iavpVAKKbtODq9jHE04Bu/XhjhDvLb
         SoHMUstMtfJMYCt/PpDeaRTCwfqvtFI4k7PIu1hV/jcurFunmMpDO2fY1BjU6AUUu4nd
         u/igcn6/9O9Ee2mAIg6bukKX4pz7QTZit17dWtXkWmeXtEQX6EWcFrmHtA2u0vuBUgSt
         4EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741590122; x=1742194922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ftUF1HT5WFbBrDyGxswMLPBXuZHgKRdwf2S8NVL46M=;
        b=SpelVvx62+60n4zgB65BlezrAnuyaoNT6OlNc95Z7XcSCD3LihZK3QSkCBMHh2FvNW
         l9iOFKnv62LZvexx0sr3XZISxjo1HR0k0TBALYwk8lhjGH9JiVvNo/hEYAGxLXPrFL40
         ve3U+cia2mK892cat9bc2IDZP6angkaAU82ZrJi7mYDh2Cmi4tcB42zKhRZMVllSO0DS
         XXGKlnimPpwJk0m/AWZj9lJb1WXCuKdGCzIMrZKwcC9obrw2yLzskj3yeg2YhbsHXdGO
         HKUE9ETp9N2aRT39+cVlnIud8LN0jSeWWAiLuyaeqDjGMHPr5WU+DKLEJ8f5YpnG71BB
         pTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUruSOfW3BpeJJFRyD3dSoGO41B27FWbRH9Xp859QqdqXEu1jcCsoZGLz8F1xfn2/r3+31HhdZZkhlwwA==@vger.kernel.org, AJvYcCVZC6Y19i+6m4Pt7xB4JRJ/9+5yjTSfsRAzVvtYY98J0fKvNLVlU7GHBJhcmAe/tp+vNrvTLKuZ44DF7h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98I8hvoAv1Pac/18gCgbPdLZpaHJfX9dWCL4cu6lGqBm763Og
	8WAw+tsR0DaLqark0fb/X8klc7UKJ6itlvlcCBOfAAKv6Xd2q83BLsfu/Jk6DwA=
X-Gm-Gg: ASbGncv30+spmwNREc3IOOrkO4gA2TEzhCfV5uqry3R3GU4EJ0UqSM7jy4/FW179Mmb
	HPIv68KsYqKxtUlszLBwvaBzjWWjO0IAm2TTSP5yUbuHZHA9vVQWk6kcuy5X1RvtgIqbSjrFEH/
	V/dfcW2rZN2SYcwkeu7+/1IT3ywTrAvA48nAAKX/prKAmXWJfl7Um0+Sja2Z1FRj/6ztlIsbmR8
	pii6vz9C8ovxv1VhkUqEFHYQBcn5QCDGKovLUZcU8x4gMbh9hyngSNz+qjuNW+puqGvZogyjyQY
	iGDyadSEBQWtQBHmiBz9pJZSj/wKXsAb/r9Ts2cxAeiv
X-Google-Smtp-Source: AGHT+IGINiIRnipScagDgoAw078UJsTXfi7udyqPOfceY//1UyRlBtfDJPRKd5DHngNJ9vLU7KtDbA==
X-Received: by 2002:a17:902:f786:b0:224:c47:b6c3 with SMTP id d9443c01a7336-2242887ecefmr181042285ad.6.1741590121929;
        Mon, 10 Mar 2025 00:02:01 -0700 (PDT)
Received: from dev0.. ([49.43.168.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91c8fsm70080295ad.191.2025.03.10.00.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:02:01 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: leon@kernel.org
Cc: jain.abhinav177@gmail.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Publish node GUID with the uevent for ib_device
Date: Mon, 10 Mar 2025 07:01:56 +0000
Message-Id: <20250310070156.8068-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309192751.GA7027@unreal>
References: <20250309192751.GA7027@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 9 Mar 2025 21:27:51 +0200, Leon Romanovsky wrote:
>On Sun, Mar 09, 2025 at 05:57:31PM +0000, Abhinav Jain wrote:
>> As per the comment, modify ib_device_uevent to publish the node
>> GUID alongside device name, upon device state change.
>> 
>> Have compiled the file manually to ensure that it builds. Do not have
>> a readily available IB hardware to test. Confirmed with checkpatch
>> that the patch has no errors/warnings.
>
>I'm missing motivation for this patch. Why is this change needed?
>
>Thanks

Originally, I was looking at this function in order to solve a syzkaller
bug. I noticed this comment from Jason and I assumed that the motivation
would be to identify the node on which the event is happening.

With the name, users can identify nodes however Subnet Manager uses
node_guid for discovery and configuration of the nodes. To conclude, I
think just using the node name might not be sufficient for unambiguous
and reliable device management in the network.

>> 
>> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
>> ---
>>  drivers/infiniband/core/device.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 0ded91f056f3..1812038f1a91 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -499,12 +499,17 @@ static void ib_device_release(struct device *device)
>>  static int ib_device_uevent(const struct device *device,
>>  			    struct kobj_uevent_env *env)
>>  {
>> -	if (add_uevent_var(env, "NAME=%s", dev_name(device)))
>> +	const struct ib_device *dev =
>> +		container_of(device, struct ib_device, dev);
>> +
>> +	if (add_uevent_var(env, "NAME=%s", dev_name(&dev->dev)))
>>  		return -ENOMEM;
>>  
>> -	/*
>> -	 * It would be nice to pass the node GUID with the event...
>> -	 */
>> +	__be64 node_guid_be = dev->node_guid;
>> +	u64 node_guid = be64_to_cpu(node_guid_be);
>> +
>> +	if (add_uevent_var(env, "NODE_GUID=0x%llx", node_guid))
>> +		return -ENOMEM;
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.34.1
>> 

