Return-Path: <linux-rdma+bounces-15032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFC9CC38C3
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 15:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5051307879C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FAB3451D6;
	Tue, 16 Dec 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mKY9SBk1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C034405C
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894961; cv=none; b=G0Wq128vWgh7Yj1x8gHB2LMnR624vuOkBbfXiPGCy3p8qmEXPmZu9hXVKTfrdvRk8Gqpb8wDZszq5Q8wkm+/rO2pUylHwpvE5e6ActLPlnD8YUZhBeLensC1Kg4lHEiiQ2zX4KqN01bPWyXECewQJYtDcu3BZA1FS4pWq3ZGXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894961; c=relaxed/simple;
	bh=XGIiVNgmbcX0eVRdXfX6oOJ6DpkDt+GHo8sty1bDOMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCe17qOOxnQqdq8mEhg0T+0wg4ddBI0yS2eLwInGq+7rbUsb2LTVfHeilU/MtVoWUZBn9SL6RGBV6MdnCeH0dLa8HvFA1PdXweUVbJr4tTFAGokEUeC0d338PbFuJi8vO1LreyxbJVXZ29VeB7bjq1Sx0yyWIQtXOwXOYXqwVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mKY9SBk1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8bc53dae8c2so253401985a.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 06:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765894957; x=1766499757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6wGiQHUS31LUV2hFUdw9+vi8x8iNhVGvlP3n/hyQFA=;
        b=mKY9SBk1FvKlMXFeD3yCaiRnbKMFuClpCIi+ygEfa75jZC5PEaOrV5Isf88ff1bLCg
         bQvwq/Hduui/lxfGGOwHqoXSjh6q54AzSUi4nPxldEpL6vqMdxc81dZfn7NEE4j4tGt6
         rFm8DnsqAOdrMTsrmvgnhQbHZgFYvbw2aIVJ0qQuq0GLlvF0ffG4BfJp2gPvedy7h+fG
         G6BUHX9Bp5+1r7EAVTp8diEH5gfkGunYVW1hSCF7Xt7xaWUzaTVkYt2WHm50Z9siz+Sb
         8P2Yi9TdE8mQVMjpUo72KJmyLXwwcqP5uJk32FD5g7ddbNzJuarCWWfn41uIrfBvX4t/
         ZUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894957; x=1766499757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6wGiQHUS31LUV2hFUdw9+vi8x8iNhVGvlP3n/hyQFA=;
        b=AnvRmZfjThZZQSccWx4z5Lj1rD3kb8cr0+A2wPHMKZBvEcXzFZUd7l+oS+VAQIfD9F
         FPniKBT1JQJL5Rb/WZc9Ay3Fvo7lvXBzhUzc0qn4pQA2hXG9k61gafFiC7imWHEzeKjX
         M3FdNwr/oru+OcnTvGLlf2+M2wndBN5j0hM/nhfjKVM5SSVpuZUAJuVWE/5u7VeKGA2P
         mmwp/zZEP3Us9ljtcerm9b2+DC3c2Z8BlqUaY/f01Tbs1AygtSX6WWCXtbPVaqP5VjE8
         yDBPpDIivwUeGhQQ/LWzLLFtjsMJKCsbFfVJjqhB0T9tagdk18lD9Wxc9O5Gjz13ApmO
         06vg==
X-Forwarded-Encrypted: i=1; AJvYcCXtNwapD4Y2Z1iXP+3E4CZqXOIc4Hjps+jH/0Ye2i30ZLNCu+ASfb2JuOE0/oPpjciDyPPq6H2AX7Fb@vger.kernel.org
X-Gm-Message-State: AOJu0YxSim1ycmqx4nt20YRDYlDgWqOLb9LJicpVlfFiMho5zIE3gp4l
	CFgcIKuMjw4Z2poWfNSpG0LmJRw2YkVJtusfZyRJdT2vCavTDQjhEOGBIyD4O06reGw=
X-Gm-Gg: AY/fxX4inDze+3opMNZlDKR3+rVHMV0rITyca5VoP9rhaRuLyQOPzX+BOIjANqAiQz8
	s4Oq2ATmtSWn4RO/gGhc7rK/NfGl+jHJEUpU2pm3hXCrdplrxOwuk+o/n+TykV53VZ6ecbk1/Da
	V8eINtWx8EL3MlUrwoC+BtDONERJMJ6lCoH6Me6A0ZoQ7OHIRy8/jyGueew/t51C2g6hgvDy1r1
	OTgXykyKndmKFOFXo8h6ZHfz2ieCBBAUtDnkF2z9Ot8Qs8KgJyckVI7vS1jJU9KcKYXCRCQZGqY
	grQTIXfZyYwS+4349SR3xqekxUx1JjS6nG7t+km1QelRxInSXw0nd/oVDY+dcHe3LE98nLn8S+d
	UhtKUY/Vm89wwzNuUPPQGqmqKbdWbyYgaA0ed4AZPbfiXOMHLK2ulPxzYux7wU9cN0OfDYlSYpB
	6A9X+Z1ws4cRuhDfaeY4ZqXyp/dydYJD1ZZ8avE0kIoyNjS/f3lEZnMwoc
X-Google-Smtp-Source: AGHT+IFDZEDuaRCPwiJW2iKvnDZCiiVa/qjjwcwDcPiZ2BJvdS+08oL80HOVEhlMeknHb+YHZB0zcw==
X-Received: by 2002:a05:622a:1f10:b0:4ed:b7ad:6fd with SMTP id d75a77b69052e-4f1d05a931cmr206640191cf.49.1765894957387;
        Tue, 16 Dec 2025 06:22:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c7e99dsm16973041cf.34.2025.12.16.06.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:22:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vVVwi-00000000Jd5-0Q6n;
	Tue, 16 Dec 2025 10:22:36 -0400
Date: Tue, 16 Dec 2025 10:22:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Gur <michaelgur@nvidia.com>
Cc: wujing <realwujing@qq.com>, leon@kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH] IB/core: Fix ABBA deadlock in rdma_dev_exit_net
Message-ID: <20251216142236.GD31492@ziepe.ca>
References: <20251216005705.GB31492@ziepe.ca>
 <tencent_713807A8D67394A5D8339F8AD33FCCBFCE07@qq.com>
 <a51bcd2d-d1c6-4516-90c1-f6c50ce01f9f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51bcd2d-d1c6-4516-90c1-f6c50ce01f9f@nvidia.com>

On Tue, Dec 16, 2025 at 03:59:32PM +0200, Michael Gur wrote:
> 
> On 12/16/2025 11:59 AM, wujing wrote:
> > Hi Jason,
> > 
> > You're right that the locks aren't nested in rdma_dev_exit_net() - it does release
> > rdma_nets_rwsem before acquiring devices_rwsem. However, this is still an ABBA deadlock,
> > just not the trivial nested kind. The issue is caused by **rwsem writer priority**
> > and lock ordering inconsistency.
> > 
> > Here's the actual deadlock scenario:
> > 
> > **Thread A (rdma_dev_exit_net - cleanup_net workqueue):**
> > ```
> > down_write(&rdma_nets_rwsem);    // Acquired
> > xa_store(&rdma_nets, ...);
> > up_write(&rdma_nets_rwsem);      // Released
> > down_read(&devices_rwsem);       // Waiting here <-- BLOCKED
> > ```
> > 
> > **Thread B (rdma_dev_init_net - stress-ng-clone):**
> > ```
> > down_read(&devices_rwsem);       // Acquired
> > down_read(&rdma_nets_rwsem);     // Waiting here <-- BLOCKED
> > ```
> > 
> > The deadlock happens because:
> > 
> > 1. Thread A releases rdma_nets_rwsem as a **writer**
> > 2. Thread B (and many others) are waiting to acquire rdma_nets_rwsem as **readers**
> > 3. Thread A then tries to acquire devices_rwsem as a reader
> > 4. BUT: rwsem gives priority to pending writers over new readers
> > 5. Since Thread A was a pending writer on rdma_nets_rwsem, Thread B's read request is blocked
> > 6. Thread B holds devices_rwsem, which Thread A needs
> > 7. Thread A holds the "writer priority slot" on rdma_nets_rwsem, which Thread B needs
> > 
> Why would Thread A still hold any writer priority after calling up_write()?

I've never heard of a 'writer priority slot' in linux, a thread does
not block other users of a lock after it has released the lock.

The rwsem priority is done by biasing the atomic counter, not with
some kind of weird per-thread slots.

Jason

