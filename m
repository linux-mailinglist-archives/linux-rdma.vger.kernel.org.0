Return-Path: <linux-rdma+bounces-5656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228129B7840
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 11:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A161C239AD
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691ED199E8E;
	Thu, 31 Oct 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+1V2ghQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC97199397
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368872; cv=none; b=CEaTwXavgf6PKz8qs9wH6zvocQ1mgMs/QhABPy2QSq5U2hh1rCCLLFYaxm3WQM1zQ0sKjo7l+1GO+Ha7DKG50b9/maFrWGjaRZiR4rtxpuL3fNKbH5oUPIlLFYJ88TjqWVPL0NyykqejfFzWvMGAyf7bjd8193MxUBLDdMwlJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368872; c=relaxed/simple;
	bh=mxBwCZ+75CvqTLN1XhZznWwc3o4QKtGNftdDgMJUoUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdJlSE1mlcAWY9137pA4bp/dgpXLYcFEpkYYkN8vzzbbGQH+KD/iAw8z+30XtzXGJ5qvw5nL4uo9LifO/VlQpwPy2UBSCrQL5sO09IePujaut7KbpejGcr2jHXXsMaowPONmn4iZ/94NF92D158G5eqF2jWek7/vJ63Rn6z8etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+1V2ghQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730368868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNwUIz30QtNdiMVxCPTr3YIfDnzUPKkej1rAw1oJyCA=;
	b=A+1V2ghQJp/NlScKtlfrpY5ok3ToP3sFE5tfnuAT9Rf5RzdLU047r3SuwWd7KsFW7VFoQy
	Fyls0kGGE3vIqxo4XRAaK5ZVxdqJ6LP5VkYQKefy/q7yThZR23Umvs5gQZmz5tQhQxaxcQ
	gfC3BTKkY1I/IiE+bbgzpO44bxD5jXM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-w7lJXXnqPnqlmNAPAVHIPw-1; Thu, 31 Oct 2024 06:01:07 -0400
X-MC-Unique: w7lJXXnqPnqlmNAPAVHIPw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so5371995e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 03:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368866; x=1730973666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNwUIz30QtNdiMVxCPTr3YIfDnzUPKkej1rAw1oJyCA=;
        b=UjcIN5uJCx7NvStKfxUj8m6GPqCn0ROcCvcxnX+DnOyg2LBW1AGvArp0IiYfad2+vL
         9rnm2ruYE5BJ75eWe4F7K4xjEtMjqCJ3+uE4QyuLTajLKMChI7BznzVgIPlXvQe1PLwx
         P4IUL5slSMCUfK4Mi1nUbukcxPaZr2zx9jaPg+g2envAosZGv4zj+HvOf730c3igSYhW
         s3crdDnHba2Q/C1OxfDogoal/fGOiHma7Io3zW6RekQemlqn3glu9xKz/B+M5NQrwHz+
         PusBOCDAjI8rTZgbZfi0J7CUbogwi5nPMNoeYc67FHjo4qH3Hy7uz3SO4WpY/SPCXqM2
         YR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGCRSPD+fybdrzf6LkuQxKUW5gMlSdKRRnbuR2OzJGjJlyTvQeFBgX/ljSk2f1Bmo1MrEz49jB5MC6@vger.kernel.org
X-Gm-Message-State: AOJu0YwfH0Bu5j4W/U/JB+UPqsZS/wraRaZiZNAgyC5GXb22wDAD9UNR
	5WJtjJhp8Tlf324CKBpFp42zdrN88rTDL5qZgHKHQkSHpjMWSRZJ8JOoazzYCc+GGIH1yn8e46u
	SfYk6XywD6PHI4Js2Sl0x0M9GP1yJCB1HxztT3PbVQ9GvjP+XNUYshomLNJc=
X-Received: by 2002:a05:600c:1d84:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-4319ad36a7amr137673535e9.35.1730368865702;
        Thu, 31 Oct 2024 03:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXcf+eLrrEBWd42M24owEstd+6Sm/m+ybY5oz8+0inJZDKxl4Erh9jI+EL0/KuP+rh0hO9Fg==
X-Received: by 2002:a05:600c:1d84:b0:42c:ba1f:5482 with SMTP id 5b1f17b1804b1-4319ad36a7amr137673285e9.35.1730368865280;
        Thu, 31 Oct 2024 03:01:05 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4b0sm19630105e9.14.2024.10.31.03.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:01:04 -0700 (PDT)
Message-ID: <79f0b90d-9420-4e35-9bad-5775c2104c02@redhat.com>
Date: Thu, 31 Oct 2024 11:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Alexandra Winter <wintera@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Nils Hoppmann <niho@linux.ibm.com>, Niklas Schnell <schnelle@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>,
 Aswin K <aswin@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 09:23, Wenjia Zhang wrote:
> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> alternative to get_netdev") introduced an API ib_device_get_netdev.
> The SMC-R variant of the SMC protocol continued to use the old API
> ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> device driver. Thus, using ib_device_set_netdev() now became mandatory.
> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Please adjust the commit message as per Leon suggestion. You can retain
all the ack collected so far.

Thanks,

Paolo


