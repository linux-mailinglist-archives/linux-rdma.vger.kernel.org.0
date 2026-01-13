Return-Path: <linux-rdma+bounces-15516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F430D1A653
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87D4930101D3
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057C34D916;
	Tue, 13 Jan 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IUN+F7Os"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AD25B1FC
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322967; cv=none; b=e2kk57jyxjZhJYP8XHyjyspEM+rSjBn3yH9xJalEIsjjSKkLNFoJgRbrvI1CyWlgwfhDxIRSk0+kVEDgZYg6HSXUN0qjUkrNb9PnhgGAOIUB1VsQy0BQumNo36P81nruhLAzFxtKh9YNxYP1ScDLYnmKuGydUiithoa+AvC+AS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322967; c=relaxed/simple;
	bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/lA2GkhUPLAPLuUOePYYx9rZHRDyWmvYIhmR7B0iN2RFcbhVjDeaVkfAyGsL1fDR0U4m2DRa5m4pnUSSc8vL+pUMHw6VW2BhHY3MO6fSuuvWxuPIiUnN2MNqEJ7fd5EcE6K6MCwASEI7YYuuXJscGh8dLMla34UJg/72Z4hh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IUN+F7Os; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4f1b1948ffaso54151221cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768322964; x=1768927764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
        b=IUN+F7Os2CbsEpMXD+uy4zfUryF0h24o1jyx/IiYJq7BeVoHZ6z1GLN7ui8LGfBeDP
         DA6tBmkTPIySiWnRFO2xpwJfRu9SLXxaW5kpd8t9UaDDsOIyaFmhxxvdDzVLw7HDPgVZ
         tMZlJgPmwHU2p01l/jcmvEXdj1SWT2nHiRpYbfEBCcreb/F5llf+NsHfCACTdfcMNR8l
         DlZRQw8wRcmCaT2Nvcdpr1DkRQSeSiDyg/bGgMd6WUEpQRAUsjvSw0omNVCqKuNWw+pN
         il0/6wjhstUZFg/vaSnhZQGAGHC5NTUavNRSWwIyuKwrr+1bpAAkJdGo4G27m5McLDER
         h86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768322964; x=1768927764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
        b=lb06N4ZRYpMqWp9PN/b/bkGT/JLNz6LJJCV8OS8eYtKU5hPOF2uuWtm7yNo+y4u6v5
         INWymSghcmJwSF3cAf/X5DhtAH5rWfqHSzpILd+MKoH+TASqMBTNjk2d9TgiHTKh8DU2
         MOELr70USaf1/+oLSV6mSZv2X5rqS+BJWM356y8QEkEWaERVzLWAsuwflsPPLMUsi7v2
         Xfm6UZBhNTLp0ZGATDzRmXfM9OG4LzynEg9PlopLaOZqEz3lc4vrWE/7IDBmlguzO8fw
         osLLan/6dDh9AtSsHliCJYukXhFrhy5CQjO+dGsYUJYKNOVEqeTj3oFw4N+aUU3KnKk7
         96hw==
X-Forwarded-Encrypted: i=1; AJvYcCXeKaUcIlb/6qS3jpkQOqQRWWfcBiIs8WLQG/fbR7KaF/Zezf3mR03PmZJOTtgst5zJ/OsZY5OSRKBR@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6vqtKApwA/zOHSEW7rtKUGuy5BbEtWDBocEn2R/f1lS8fWrW
	9fb7dRIEHPsH9pFknismF//0RP6k6KiTWX3GNelNp4jWcznIj2Yxp+rjdm3eVwI27tg=
X-Gm-Gg: AY/fxX6BRc/7MskWs3d26b4GV5s1Opnhk4x47bECJT6ViVQ2Sn5L5oYU7a+8IBwVdJG
	KjZ2cJBD3cQYzlrrHT0V0gCAsh1Fpgnlj+Rs2E/dubBNQN0le6eQoApNldHHlRMt0R/b+49iZcg
	XCgpp1AVDRXNV1UiqpvaS4P75h9NEvnbW+sdFOIlB88a9Pr2RTNCmkRmkk+BLEA2evOSj2c2YIE
	BMn2iL4A1neajK8Z6JWXN5ioPwz23li3GwpLtpTZVcVofU4miuYmY2l4yIKytrKk9nQFG9WzRUt
	zr9qURBOqX7VHv3u0sCToeT2kC75QyILEMWGRsgtLWi+0IEYX5Sh+8RPddzZareOiCGdGDSf9ro
	LMjDdDUgKVmUso9Vl3rs+4HiZNTMQXmU0cw4+BIOhsd8kO4FBfwOQgWNHmgF6ggFHLdAgeZfSjX
	+k1a4ghVz93vtMWRMauKWK7XNt0kk8tbpwxL4r8ntxoU9OfCDTgRM+t0mhv4467GgkIBk=
X-Google-Smtp-Source: AGHT+IFiSxb4uxmRYe6XxApgypPCZjK3lS4QULTVbEwLXNQHGmzceL2GIP7E4FtNXvFCswjqEyy+cQ==
X-Received: by 2002:ac8:5e08:0:b0:4ff:a9d4:8773 with SMTP id d75a77b69052e-4ffb4afd0e0mr293395281cf.82.1768322964364;
        Tue, 13 Jan 2026 08:49:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm159988626d6.43.2026.01.13.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:49:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfha7-00000003vHg-0bmX;
	Tue, 13 Jan 2026 12:49:23 -0400
Date: Tue, 13 Jan 2026 12:49:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260113164923.GQ745888@ziepe.ca>
References: <20260106005758.GM125261@ziepe.ca>
 <20260113074318.941459-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113074318.941459-1-zhipingz@meta.com>

On Mon, Jan 12, 2026 at 11:43:13PM -0800, Zhiping Zhang wrote:
> Got it, thanks for pointing out the security concern! To address this, I
> propose that we still pass the TPH value when allocating the dmah, but we add
> a verification callback in the reg_mr_dmabuf flow to the dmabuf exporter. This
> callback will ensure that the TPH value is correctly linked to the exporting
> device’s MMIO, and only the exporter can authorize the TPH/tag association.

That still sounds messy because we have to protect CPU memory.

I think you should not use dmah possibly and make it so the dmabuf
entirely supplies the TPH value.

Jason

