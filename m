Return-Path: <linux-rdma+bounces-8185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC0A47D87
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 13:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EC33A2FB0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B422CBC8;
	Thu, 27 Feb 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1dU9vfX3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178D225A22
	for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658954; cv=none; b=UEsXvrSOyxd0sDEiUF5jQDwuIhKBWyMbIVf8O4Tug2rz9/2VFklHLTRDKQXYP+QsH7apA/1SWOQOTjr6BJdl0WIAeBjuuHuQc8aPL2D/jRBYbL/n1TchuYdgyvrkP1wTPrFE+jcuJsTBUu0oUg+yuyhBmtHhWJuXpMBI+W1yZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658954; c=relaxed/simple;
	bh=8xMy4hdNTAdiolk+YAG/ZLMRZgXFoXuyYcYFEWFfQoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktP0Y7i5jw9O6GShu+y6DFTaRqQha2MrGmFKJoEnqEg0mt9gPhEfjnKs+YriUJuxLhfd1UKvE3g8GtYNwPzb1iiFjqAE4kgk2yj0KlmVjRMPMFw1CwbU897dNBMRQuZHe5qF+mtopb7Qs2LhG/beqSH/WL2RSnTJSt1XI66aQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1dU9vfX3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso131014866b.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 04:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740658950; x=1741263750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYOTm+6jHAEQKMi6xNvlm2nNMaMBH7Q2Y4qbi1PxB2w=;
        b=1dU9vfX3g3bVHWM+cctcvNWp7y/4FKuP6rFLzSYNBpNeH03tffh5XBtfqV6179BjI5
         vjTjtlhY/cwqag1y5g4thXgGfn+ggpIs8Teoeb8xCLBLfETJghQ1pBxS5wZOFBtTaE+Q
         C+nD+W4GXgTw2jJ7t9E1gGr724Iu3Q/6N2z71hO7qMbefCC65r/lxdN6Uptk2y56C9uu
         eNexfemcF6kY6n5T9Z/iJ+1FFhSYQqhC6hIroV3/JAbVDAFcj76cZYpTFn2uH0RYfdfg
         T/8tY049ApSj4dPuqdbkMGIyz1sD96Fd799pALXiy4wDewfUpaEvQJVOjUeQyF1z/SJJ
         aBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658950; x=1741263750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYOTm+6jHAEQKMi6xNvlm2nNMaMBH7Q2Y4qbi1PxB2w=;
        b=EhsSaGeFozx6XU7PnrZBBT2nZHjxTNt7ehrxtdoEXAf20XoNbm3wFaoRh0roDiXLaW
         HoOawO9v6if9Kckq6Pcag3G6T9tTCIgyBIm089ok41TQs2iFRixSMd5sqjQLL2lh/3Gw
         GM3wwlSlJSQznv5DTUSeCYZOhJLl1SaVp0c2k7TKmWo0pxtswyJP0EgkDBYImJ8rzbu8
         jijlD0+XUxwl09vanikiXs2Vn79TpeO9WKC2Ht+wvRhRLNZFTg7/2Xf+stZAFuJFhL2H
         dfBuonFpcaNPrl5KGK4H/q1t5oJpzyVdRfQOwm75sVmpQnINbpEWbzsi7onXGKGMIEPZ
         yEWw==
X-Forwarded-Encrypted: i=1; AJvYcCVSqTwKDywu2wI50SleIgx2AZXui0SsSyNnLRoaVFVbDR7JLtNOxxvrN3sLd2eR5Lw88RwEwJAhA9vG@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyfnxag/x3R6bDyj2C05vzKcryr4yBpsEk2c5ppyIGxbtzBSq
	g+oHR7AvXMqdNXUEd4GwXxxiYtsIyjIEyqRMnDivxx8MNovjKEG3d/GsUpS10CU=
X-Gm-Gg: ASbGncu3V/PY0PlSNsjS61o4AZ6QlIv4dKfit2JiL6RN4z9y0rD96GupYwRVHM2lvCH
	lk9Pei+H9RBXA2HkqAp2RN9YB85ieE1Uj67IreeEWs5fz7avLuQSt0zzLQlulgHZb0eRjeoWfqR
	nNVphp2uYi3v/fc8rrjd13tbu2u9jdc7RKdYXhiGYiGzlE7sdUEYIT/nR/li0AiXmN4RkdY/WLp
	VXAqYqI6sFr2rD7Rh9KCT6isso2c41tDB2gBK2dY2fYBvs9rDYq7O05At7DEGPmEXxr3prwWnxO
	fXFJ0ekfc62R9cioZaWh+tJNvUB3LwRLrKUviHM+utgU/V1EW8RO
X-Google-Smtp-Source: AGHT+IEUS1ErRHCieUA4KP9jo36VNA+6eC7KANGzDb6TJHoqoC05Nj4oxB1TboeC1Qn+fVY5Mtzo1Q==
X-Received: by 2002:a17:906:7954:b0:abf:38a:6498 with SMTP id a640c23a62f3a-abf038a920cmr513452866b.55.1740658950370;
        Thu, 27 Feb 2025 04:22:30 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b99a6sm117424466b.13.2025.02.27.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:22:29 -0800 (PST)
Date: Thu, 27 Feb 2025 13:22:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <kmjgcuyao7a7zb2u4554rj724ucpd2xqmf5yru4spdqim7zafk@2ry67hbehjgx>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
 <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
 <20250218182130.757cc582@kernel.org>
 <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
 <20250225174005.189f048d@kernel.org>
 <wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
 <20250226185310.42305482@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226185310.42305482@kernel.org>

Thu, Feb 27, 2025 at 03:53:10AM +0100, kuba@kernel.org wrote:
>On Wed, 26 Feb 2025 15:44:35 +0100 Jiri Pirko wrote:
>> > Why would there still be PF instances? I'm not suggesting that you
>> > create a hierarchy of instances.  
>> 
>> I'm not sure how you imagine getting rid of them. One PCI PF
>> instantiates one devlink now. There are lots of configuration (e.g. params)
>> that is per-PF. You need this instance for that, how else would you do
>> per-PF things on shared ASIC instance?
>
>There are per-PF ports, right?

Depends. On normal host sr-iov, no. On smartnic where you have PF in
host, yes.


>
>> Creating SFs is per-PF operation for example. I didn't to thorough
>> analysis, but I'm sure there are couple of per-PF things like these.
>
>Seems like adding a port attribute to SF creation would be a much
>smaller extension than adding a layer of objects.
>
>> Also not breaking the existing users may be an argument to keep per-PF
>> instances.
>
>We're talking about multi-PF devices only. Besides pretty sure we 
>moved multiple params and health reporters to be per port, so IDK 
>what changed now.

Looks like pretty much all current NICs are multi-PFs, aren't they?


