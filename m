Return-Path: <linux-rdma+bounces-7895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED28A3DC36
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8598D3BCAEF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1751C3C07;
	Thu, 20 Feb 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NHroISaZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE81BC073
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060665; cv=none; b=fyfBRDM0EUyaauPUXgv3GQ0x+5Lw8/DQiZ5PsaYYTcssEk0Sx2Mo/PKyJQa/ujj+jStjTTNGXDqGHDOxAwcPzw+f5r8phIb+QN+wAXqLZuGv7d1awQJjIGbTT3yli+A9FaylvOsW4ARREhOYdpu+EMI5XxIbFC9FXEUIpCB+cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060665; c=relaxed/simple;
	bh=K0kJrAeBpv5OH/G4vcByfu3LtZZb4KKzTm8DxwxT+Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPcvOw1BvFUvzq+XLfDJM9Tgo+byA6EZuLZtur8XNPEQZyFoOw76HhVUmvpzA3Qz+uotpq9hqVzu+Kfaj5je9i8X0b13wVcL/LcSBHyABteKIeqy2O4KepxXJ1/88pzQvWRvFBClh1B+W6Lzvt9OZyGzwufCSUXE2sUOQ+FVtRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NHroISaZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fa734a0b8so8500171cf.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 06:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740060660; x=1740665460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4NPSozHNy6jTSLxKFKmmor4e+IT0I1X4rR9hUAf4oA=;
        b=NHroISaZK3t8qyM7ZiiTrRhPuzeLE8ozbU8mciNSWzmrG5/J+grZjcaxC5pT8wtG43
         k8npp81V/GKyyikzLnqmSwrmPvD/uWZ5ZKpSYi2KqCO3qmfDx+oV/pobXnC3fIQroKjH
         wIxfMC0avuMIMmrntfofMPIkHxHazJ2osFJLJ7sxjVsmfCU/LDUoiLDfqyFcXZgrtL0h
         BLnws8Nz+bKGWlzZ00Hc3+p9QXnz1hO0tffpKhcWfAdZkbSzxDVMZvWzIJH4hCHC6v/j
         BxJByP61enQu3jAg4Ng31ubPWuQiFignaWbO5gycyG3/w1JXWjlKKK32ZEILtsByM3rE
         80Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060660; x=1740665460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4NPSozHNy6jTSLxKFKmmor4e+IT0I1X4rR9hUAf4oA=;
        b=avLm/0HztcRk42l7/5Nv571drByYpCK7mfd0rz6dhYLKjAXocD1rRGYoD/t7ezTmlU
         Xrb8LPn0524LLDWUap4cwIMDKQp/j+0eXK4hd/8c7fPSbJzw8xGW7QwZtiMBviO/tkk2
         Y88cOdk0eJk7oJfs1InRYg5iytUPmJY452DhNF2Ru7sptF0sGuMXMPDPggusn8JZYEgM
         cQbCWFdp+7NuiKGsNB7HxnBB/OkVRMHj3QbOVJyB22Ry0RNCeBQxhTWwBZTxPEhm+sHA
         qx23fSR9CrtNdv8WcJuuCCnWkKmAxD0cM5kswSFwsMVDYLXj+WAr1GoN2wF5lAiEohDR
         CyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJAaXfrjEYV/cRZzslW5C2YVrb/8VJd3bu8YN1F5swVVgizwkgldBy0E6U9dvs35I7tqQbku5xd6hM@vger.kernel.org
X-Gm-Message-State: AOJu0YzWj3rDuQXmqK1CZp6zlBRU2YYoGx3sEEzCrpTRPGDQHn+i0lix
	3d4D9g9YzE6GSb/QHWHMjyNuoJIWG5D/BkRsbeC4lTE8qZJT2/OQjyjFw+9/4Kc=
X-Gm-Gg: ASbGncv2842nw1qYIb1h3BarkyBs9lySwd7lYjVxgaXNkWqIh2jOW/CWuWOTzgHsko3
	AqFF/mvwAWTnbCQASIMbwFB029woi4izHEGV/O6sMcSSQ+InXPYF0e/qRpgp3+/A3vKKkixoH1U
	4BTmUBGuLFgJc7PL+fLVVyXhES7w68cYfseV9H5Kp00YSsxX0ZGJIBdQqnVvrxNePuQuKNUX8B+
	Tp7vfrxBo2ZHJgTmpV0u4O4P2Z+/nxJ4UtLHv1P1Mc8POibHjStFgO8TdMN7TpWhqTBJ6z8K/sQ
	EY4jsCtWDUoTLfQyWpW8dSiF2UnAw8EA8rYzBeyH7HPgNLDT7qK3UxRJb2uZWP3P
X-Google-Smtp-Source: AGHT+IFuOP2R0cDL59IMq6KuTEgPe5I24m8R/zRLGfOCSzbSKk1z5OIo/IVIjQ6GlNcIk6XRmsHDfg==
X-Received: by 2002:ac8:5ad1:0:b0:472:14c9:ecf5 with SMTP id d75a77b69052e-47217347265mr26464011cf.15.1740060660503;
        Thu, 20 Feb 2025 06:11:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47206b98740sm23834961cf.50.2025.02.20.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:10:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tl7GV-00000000GjW-0ltZ;
	Thu, 20 Feb 2025 10:10:59 -0400
Date: Thu, 20 Feb 2025 10:10:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250220141059.GV3696814@ziepe.ca>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>

On Thu, Feb 20, 2025 at 11:48:49AM +0800, Junxian Huang wrote:

> Driver notifies HW about the memory release with mailbox. The procedure
> of a mailbox is:
> 	a) driver posts the mailbox to FW
> 	b) FW writes the mailbox data into HW
> 
> In this scenario, step a) will fail due to the FW reset, HW won't get
> notified and thus may lead to UAF.

That's just wrong, a FW reset must fully stop and sanitize the HW as
well. You can't have HW running rouge with no way for FW to control it
anymore.

Jason

