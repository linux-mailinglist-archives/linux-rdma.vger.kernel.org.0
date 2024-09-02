Return-Path: <linux-rdma+bounces-4679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E097B967DC4
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 04:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FCCB20F5A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 02:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B528683;
	Mon,  2 Sep 2024 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfvhpYjL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5345125DB;
	Mon,  2 Sep 2024 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243775; cv=none; b=DfXQJNnrlo/HwDtYZFUgDCrRH0twGuaFOUIDGbTW0FXn+S7cD0yLwEPoM8gqD/iUUj8Imyfngp0P+bh73tf20JSaBmCVmIBbGEJjOD9fkqR0jlEcyXommUi77Y5ykDUlyHLDL1SpzxiGWNP1A9RS8GdcVLtS8f+ULJAxWZCaxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243775; c=relaxed/simple;
	bh=VBpOW1rPecjQYRIrpggC1kPwY63fYKTj1DOYJLkKlMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ex6lbSE7bA85lbelVE0P9YsCnp+P1KY+wIQYxPXPZcdvOJR6AyjZFGPw3UpV1Jpw7NfXKtCKJ0G3hierZuAJ6g2fVwAhfCtS3fFXTpFxn3r4zxm7wwMR8Ige5DjtV67bWmBfYId9KqC5axo8J5dipG8mGK414BqyMSmg4LxGPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfvhpYjL; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a24dec9cbso96373539f.1;
        Sun, 01 Sep 2024 19:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725243773; x=1725848573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smFEs2rlCqPI6yQiGlZ7Lzo3jx7RVZ+QX/9oeATf2E4=;
        b=jfvhpYjLs8Mb4yLdu7S0ndINQzguHFMfDGLOaAh3qFX9UyFr208qArNDU2fPt8F9FF
         JMk948H7zyF8unqR3mwv1yaiJyWAgD2YMDq4vgFaJ+Lc71/xo9zx1/rVqCXERi3y1EQ0
         4xwxka5erP/o0Z1ijg3hRLOMIk8A4i0d1MJ8OdipMJlgnNnLm/lBDE0DzXFFZd0osRm+
         HDOXTDmQ2nCNbWersHvOahhQYwD+eC7ZRtNOSUAT5VlymCur2P3zUhRJ1woijUMHkTPL
         qc2Fr+j5iR/p000ZyKixGO8WN8dBcO4lK8UI287wVogsIDOxrixN7k3HjVZ9z/MedlV0
         Sc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725243773; x=1725848573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smFEs2rlCqPI6yQiGlZ7Lzo3jx7RVZ+QX/9oeATf2E4=;
        b=aAbHNuoBMXGoihdwqv9OGdUw24Bw6kQkS08N2J+6mJpUQR+fkjHh9XEfxeYrwAhQe3
         gKj4YCWkKCitpHIVuORZQBz9VoP8ueXNzEH7b9/U3Qoh9JE9RY+J3FM2A96d/A5rEIoT
         ydLmkfstX0TMTYukoWCaFicyeeUXmPofnjMLDziqxTXTIoRtvWQCiBgW+13QH7ErbrLt
         TGKC9cNvWxcyXiBIbrzCJBiC6KeMVcii1SWAwMNob4eC6ARk9P+CnwU98jzZf0zF4o5n
         HyMgf7ix55BTmUWETe4gv5WVQEek4pHI5pLS7y32NxtrLkGQ+7W/u8N/Wb83UR0XxcCL
         RAOA==
X-Forwarded-Encrypted: i=1; AJvYcCVHaOr+20Lo0Hm45N+xv7r2KnQpVEmh6hrkQkNubwy/RR23onxQ3pUYuUmwnDPp8bx2+UZr/S6wwDcD@vger.kernel.org, AJvYcCVSId4/kjl1FGgnyTrtv850ZuBVNNgN98o82OJmm9KzBLDhseXaRZ4kjCMYmcW516bliM4ZYpGc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0onBWJDqi59BdCnV+VuD3JNVS77xcAHM8xrf+paus0hObW4F6
	S8874H5CFS8ewhxRJI5EWpsXBpqwBNyfEVbW94zEPuxnnOzTnj7w
X-Google-Smtp-Source: AGHT+IEureTSYk1XiTG8IaBESouuGYVQyeHzvBc4GMe4fnEP6FfX0pJ0Z7rjyt+6m+NjYnNHS7zNlQ==
X-Received: by 2002:a6b:d210:0:b0:7f3:a0aa:164a with SMTP id ca18e2360f4ac-82a13e8eef3mr751075139f.4.1725243772663;
        Sun, 01 Sep 2024 19:22:52 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:1009:3a3e:c395:f649? ([2601:282:1e02:1040:1009:3a3e:c395:f649])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4ced2eec745sm1925355173.176.2024.09.01.19.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 19:22:52 -0700 (PDT)
Message-ID: <cad1d443-ccfb-4d10-ac2d-26bb10c99d05@gmail.com>
Date: Sun, 1 Sep 2024 20:22:50 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC iproute2-next 2/4] rdma: Add support for rdma monitor
Content-Language: en-US
To: Michael Guralnik <michaelgur@nvidia.com>, leonro@nvidia.com
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Chiara Meiohas <cmeiohas@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
 <20240901005456.25275-3-michaelgur@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240901005456.25275-3-michaelgur@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/24 6:54 PM, Michael Guralnik wrote:
> $ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
> [NETDEV_ATTACH]	dev 6 port 2 netdev 7
> [NETDEV_ATTACH]	dev 6 port 3 netdev 8
> [NETDEV_ATTACH]	dev 6 port 4 netdev 9
> [NETDEV_ATTACH]	dev 6 port 5 netdev 10
> [REGISTER]	dev 7
> [NETDEV_ATTACH]	dev 7 port 1 netdev 11
> [REGISTER]	dev 8
> [NETDEV_ATTACH]	dev 8 port 1 netdev 12
> [REGISTER]	dev 9
> [NETDEV_ATTACH]	dev 9 port 1 netdev 13
> [REGISTER]	dev 10
> [NETDEV_ATTACH]	dev 10 port 1 netdev 14
> 

at a minimum the netdev output can be device names not indices; I would
expect the same for IB devices (I think that is the `dev N` in the
output) though infrastructure might be needed in iproute2.


