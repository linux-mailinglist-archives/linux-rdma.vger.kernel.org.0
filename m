Return-Path: <linux-rdma+bounces-13793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3103BC2198
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Oct 2025 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86B41897F98
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Oct 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A112E7F27;
	Tue,  7 Oct 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gYtJcW2m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8902E7F0E
	for <linux-rdma@vger.kernel.org>; Tue,  7 Oct 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854075; cv=none; b=pLcUAMWtKGwDWKFiiPLvhVtWD+AnMVSFDfSVfrvkUiKgWKbZSsP2cq4lHR7Wr9/+4r8/Z/5VTvwlscDDT+nvmVhBLRVx5KNI0ALB/EgjhTSH39EKzSMGRUqW5VothcvmfL/ykplfPVQPqLzErqoY6KlyrUDOd96SISmlbxXq2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854075; c=relaxed/simple;
	bh=rUj4e7mW96AJXx7tHHanond6R8M9cTYxkixXGkn/ZsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEa7xJeEoPEl7LEug3aCyVzWVHk4s9ipJodfxQfwCx2oJe2n5V3UqFa4UUVeVEDl8La00g9OxlI5kLnWlNBWWozG2iakT4mANDJI+lkQy61kVoFgcHinu/1jnXyQ7iJ0MMdBgiRWtsgWVJyKe/K3FsOVszv8viYV6zZZbmG0Olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gYtJcW2m; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-854585036e8so668617585a.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Oct 2025 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759854073; x=1760458873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG7dBmqQ7oC7V9KJ7eaX85jqj65+GaLqPAyJt86l2UE=;
        b=gYtJcW2mx3N37KZa7zBTQNLno+q9ti46KzWNXwNLcmj90jHk6WIDmBEELERQGJ/Dk8
         e1Xtf6UFxXjkO92uGPc6l/1u/NJlK7sQbWwxhnhBFSGXz1hhR9mQEovkfGufJq8FyBn2
         BCuRF+gLqLEruO8xKMBJuwe9jEblze6wr8szxPK7lX33G3OOL6+KIeozdfUGULYJnGtI
         fI+F6Au4dpfa0KfKUaVhjFegApmp+V4k8L4j85J3UVtmyokprrsjl0mh1vh1vgE0VKQC
         fYFt6MIicyOm3vqpT28dl6xP69UiHpHADpOrdmIP85f9jwl0Fj6FGnvEGLxqB4U4kOUO
         GcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854073; x=1760458873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG7dBmqQ7oC7V9KJ7eaX85jqj65+GaLqPAyJt86l2UE=;
        b=AgzWhduUwuJU2NbaxI7zlx0pqjA/gJdxOz9LffWRcsGZQOYAQufmfDZ31wOEP/GIxW
         007KhTg5PJgwa3Dyi8H6nwLV8I5dvKNU4M9TOAWOidZCuf4+ajs6Vq7/2fzMQZB8oOeE
         v+8/FKJEb2KaaOiC0f7q3DabBEUYF7j5cvc56TIz5PK0awUN+7ZceCpXNTvPCzpw7nvF
         HdmYeZ4ANEvvnPN51FjUdQEHPJ41utQDjTKf3TTfThcucgeuIstr6d12XkS+SVOy+VYH
         dDMEubx77ph1oDR+1AIx6n78jx5/OJd7d7vyMeZWv1AdzRr3ZLP58ABjHw2dJPRqr+1B
         ClEw==
X-Forwarded-Encrypted: i=1; AJvYcCUfRzq2OcJYaVHGupUf5qemRoZH3wPbd+RYagg3YmeZQyHTHC6SdwuihJJy41MwKz2gaz5AxYamrXL8@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSFcn69/iIYaIgtaeADpg6EC+mzFEAhr5+hx0JHmq/KlxLdiT
	Zg/iWTRBR+vngTp+s7kaF/H7yWYT4woijMC+dWx0KZdM/YHGSmCh/ZJnPouaeI06Ex8=
X-Gm-Gg: ASbGncuWeYwTNQjo8rJO/NbD18h3WHsQ43TXuZRN53Hbbk1Ic3dJSGQZKMO/669HhlB
	ySGdZQ9T2yWj5h0rX0WxTJ17vrHKOMfVwnUxYSOO90/1ZjCygRW6hyzt+sL3VnWO2UTvpAQ0bSf
	/U6KtubjxQ4msD09Anry+YYsCaa4VB/9oOmqShYpS2J4y96Ltxhd3xkWgh44msfrEg0wqcK3Myj
	Tx67sfzEgGZkU8YGrivHlL/T5nRd82VuiXtu3X0rwfAXIRJR8/s3fxtSWCXgJobUX/2AMCsG4sD
	6yqc72oBj5jsRfP9tGc/Y9TFfI7fbrUJCOaOUtI6+O52FuCTwhpRMWcvktsaHxHoLIhqVxYo5eX
	yV4iwZma1mXlP+IjUYQiPAmNj0OaJzteU0ByhS5AT74ycUfoW8U2fXBsfNkOWTJSLXC+0pa9rlb
	1a7GICVYZdfnw3ZSHu
X-Google-Smtp-Source: AGHT+IGIL2y2zEPuHipwkl4TUjLIYPddwo9T+ngD6WTBuoJAHtLmSJLiAwgUmeLquPIwJcA51YE2Rw==
X-Received: by 2002:a05:620a:7085:b0:858:f75a:c922 with SMTP id af79cd13be357-883502b7b36mr60557285a.6.1759854072907;
        Tue, 07 Oct 2025 09:21:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e02e7sm1561434385a.62.2025.10.07.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:21:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6AR5-0000000Feae-1YWw;
	Tue, 07 Oct 2025 13:21:11 -0300
Date: Tue, 7 Oct 2025 13:21:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Shay Drori <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Vesker <valex@mellanox.com>,
	Feras Daoud <ferasda@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: Avoid deadlock between PCI error
 recovery and health reporter
Message-ID: <20251007162111.GA3604844@ziepe.ca>
References: <20251007144826.2825134-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007144826.2825134-1-gbayer@linux.ibm.com>

On Tue, Oct 07, 2025 at 04:48:26PM +0200, Gerd Bayer wrote:
> - task: kmcheck
>   mlx5_unload_one() tries to acquire devlink lock while the PCI error
>   recovery code has set pdev->block_cfg_access by way of
>   pci_cfg_access_lock()

This seems wrong, arch code shouldn't invoke the driver's error
handler while hodling pci_dev_lock().

Or at least if we do want to do this the locking should be documented
and some lockdep map should be added to pci_cfg_access_lock() and the
normal AER path..

Jason

