Return-Path: <linux-rdma+bounces-6451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C059ED08B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 16:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2F16230C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB01D619D;
	Wed, 11 Dec 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XZpEqp0W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E11D63FA
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932574; cv=none; b=F/gtEfdgbsxgwdgsS79DChLR05+ma0cxuowMB6n0s8pJco9yZRHF80xudeK6RVIQ3vUdqg8kESInDu9FWdUu6yJSNjAZzHv4S93bfRVcI9jPBoltHZ5AC20GQ6G6Eqcoy0cpfPh1kAZkcRlc/6vAg8MaTvOmyHDTqtkGt59N8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932574; c=relaxed/simple;
	bh=YThz+/ZxjSOYtvD8AjPkeK6Mp1+8EBFxbQ5coBe3/8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNkFitv0ighulgxMbflsg1t02ZyO62My82yTXgIRqfc94NWFWyrOl3TKHnP3u8f8muiYpaXG/10az6lgluEJL5o+be4Nfve83no+pWR7eUBan1IiPovp09dKb8owzPDsi2JDALm3+IXGxmHfJ9Qt4ZDzpJQ7hHgjWGfKZ2nRev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XZpEqp0W; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d888c38841so54193036d6.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 07:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733932572; x=1734537372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow9FBf8iPxvwxpZSiWNhtxnsgOLM1OulzPnlPGexJTc=;
        b=XZpEqp0WC+M28KD++hN3HCL0ji+N8jcR4hS9xLy36UDwmMQylj3jUhxJgXi9PMoLSn
         229P4kLJyDN5hcViUjEZylwxTV47PCzddNfwfTeXaJSPy6Pkt2bC0SZ2fXwgodBvX7xz
         m7zV6If5EvNbIkwj8eznnaDjVT5y+MLVdyDqDBphMCSmnq8KdUatyCIKAkh99A/79Jgt
         ok6mbQJadIONQ1eEza9UJDrVAr4Bc9ZxLyjKHoDYeNkZ+/D72UQ6h2lG5JiUgn0AGpty
         9QS7kJrHLvzcUoKjF4e6GreiU5z30BfRKxRLVdMBpbSi6gmHFU2iOYVo38XSbXjEoSJh
         nE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932572; x=1734537372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow9FBf8iPxvwxpZSiWNhtxnsgOLM1OulzPnlPGexJTc=;
        b=I33X8sOGfv//cDBECswn06V9w+yjHGKcIPMay/nHVK2hTL5FM5MgAFoTgEhDGilcqb
         59YJMxI5WK94hB6Yf2eUMlG0Zw4BhlEuBmjair4CQU7wsylDkGHvZZBfm/PYnBiCwSnO
         30t07L9aJWJEeTGuqgbAD2qE+E5+TE57Et50WUfOQfpwRaAhjR9RsULVRFeMpCCOjmIV
         lnKBGkmmPpd8LpS0mtqlIbiUEnsXJunB0SjaEkoPoTVBZD+559N8moGh1cnjKSasJmqh
         2ehxFK3Zstgoin0/cq/NCfey1Gthbn07dM9VrHIWlj9sgEFm3CNO5W7lZiJUeR75dTQU
         oTUg==
X-Forwarded-Encrypted: i=1; AJvYcCXh+qsH2zR2mjyqUBSM+zCatrk+hfCBgeWdiY9M/9X5pACuRRCskdyWbS9pjyC/zg+X0U75VCyvaNuT@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYfPIwTAev5CWs++ub+3Lvc1L+AXu0flGuNQTKB8BTchezFmf
	T37Y/GnEoTYgTRB0zvllkMi2If1en2RRP0zGsb12Xkixlf02/fDL9zzKQcESVEY=
X-Gm-Gg: ASbGncsk0CyMJqZlaZralLxb7xTxilbnE4TOfM5GpS4P2NOZExaAqBwziW8/78Q2+6j
	g3RYasJCw7JFSQWvTQOUZbWe/oW1JOxxjgK112J6Mz/NZX424i6w4nHUg8rGCYmmX6Q4KMdXQRk
	wQCGLOLmBEogLRzpiy+OAPcLn8fPjKdlb/JN9sYHMjZDOxYzSTQsDrWDaYPK2RHCBCOAfFFne7T
	vk/A+NkTxiJ8iflXw9InZgDDIavQ3wm7vEW+cI28zXE8GbIVJVPNcemPV3CAEfPyJKj3yZhSrZ9
	kQB62vlQBPba+Y93kW5+g7iccPU=
X-Google-Smtp-Source: AGHT+IGZX2JssUeKb277xmQuAehML6d3lzPAqgssp9rjZwSvbk26EDT0EAfMBShIhzP2LnQAtO5Dhw==
X-Received: by 2002:ad4:5fc7:0:b0:6d8:9e7d:ad4 with SMTP id 6a1803df08f44-6d934aec2eemr50575596d6.14.1733932571789;
        Wed, 11 Dec 2024 07:56:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8e9e65e98sm60566946d6.74.2024.12.11.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:56:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLP4M-0000000ADqi-2JIe;
	Wed, 11 Dec 2024 11:56:10 -0400
Date: Wed, 11 Dec 2024 11:56:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
Message-ID: <20241211155610.GL1888283@ziepe.ca>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
 <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal>
 <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
 <20241205113841.GY1245331@unreal>
 <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>
 <20241210114841.GE1245331@unreal>
 <CA+sbYW0n5CPupxByysd7Dc9=QLQm33ivC1YH5T2UbvG6MBVymg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW0n5CPupxByysd7Dc9=QLQm33ivC1YH5T2UbvG6MBVymg@mail.gmail.com>

On Wed, Dec 11, 2024 at 11:33:38AM +0530, Selvin Xavier wrote:

> ib_unregister will trigger the destroy_qp (at least QP1) and
> destroy_cqs. Those verbs will be trying to issue the FW command and
> we are trying to prevent sending it to FW here.  We need a check
> here in the common path to avoid sending any commands and i dont see
> a way to handle this otherwise. Current check has a bug where the
> return code check was not correct and we ended up sending some of
> the commands that eventually timeout.
> 
> Just to add, We have similar implementation in our L2 driver also,
> which we were trying to replicate using
> bnxt_re data structures.

Doesn't that suggest this is layered wrong? Shouldn't these tests be
inside the shared command submission code?

Jason

