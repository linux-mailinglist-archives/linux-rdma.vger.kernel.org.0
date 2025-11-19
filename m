Return-Path: <linux-rdma+bounces-14621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4988C70BBC
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 20:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8294F4E044C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B87133A6F2;
	Wed, 19 Nov 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pU11gD9G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC22EBDFB
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579368; cv=none; b=p/8pm107kb71dxiPHKm3Qb6cvgwq2RWekwjC50d6ktvhEx0yJWDeB+SiVx5LGoKJ0c5fYpQgakn0E6xIzdJrOGzirUL4moK9VRx/Q5Z80RbbzJgDvEg5JM2TkHrInbBJSWX/qsVG5ZzoZw4pSlGZOKU4TMICeNbUSQcTOrzFCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579368; c=relaxed/simple;
	bh=M7pMjijjaXgjUuc/R3E9I7j3y8KOywyXlkbgNXH34Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGQybp4vB7S7Bgv6C40pBBDq3Y4PJEcN2zhJAr6+PjAc18mljtsWxeFDeWPQ0cYZO9XwIU7jNX+TGdt3C/kKg7nUvrZm0H0sPVLjX7iHAGMoM3jr9cFq0rnStRiS6nV35iKme3tkkGi/licyvV2WcdkoKn9+N/DsWHieu1BUI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pU11gD9G; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b21fc25ae1so8383585a.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763579357; x=1764184157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sLYjamrVMmnWvxhBfVDbKAD6WHAx2jk7pmhPgMFwIOc=;
        b=pU11gD9GNUbll9Aj//hNfwgmceGWZR3S+O1c0q3cOIdrbNMyiR/JvKvg87IW+Jyfg7
         F2ICqOxn9w+J9N1zqj4ESNMl+whUSS9Vr7PK5FIpzOqs43uIVG6wiZ+eiD7tRYhLV22B
         NXyht0DE9csvtKNPkKRl1n79IIqNhGfy/S4tK04i0rhOmgZFDeKt+NXKFnO3OfSGJ8G7
         /oMSgLlpI4Mw152Y5ir31uJcMHDsmNJMIVZlJM+isHB47fOGyhyrCBBADf1nmPwG1HAj
         dE7Ic17+3kSXLlHpLqQ4h+wCFaxGl+ExMYePEpGbvTgn9oi0lMh8iZZO0rWKIaIEjUI1
         Kybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763579357; x=1764184157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLYjamrVMmnWvxhBfVDbKAD6WHAx2jk7pmhPgMFwIOc=;
        b=w4lGJAKc1ojD02H9BP2nc/rQnzAYjqBJl873xFYTMp92I1DM3Hzgb6dcxxgOaFVH/Z
         bWQfN1RVFi94Fo8L5LggOGgYyymWFV32F36cW0NyPotvQ4Q4/eFp87DVKIkK+1vIbJbE
         VB5EWjpxFs0w8PJPg/5CBNYZwjdYbfShkb0Ao9stA8efA4vWkQI9BRL/lDcEDgU+129F
         VBQ9CKpjpFYuznrcdiI6KMWEA7WvqlvX4X5EsnufLsbLg2Vn7p30+NygOr1mkwJHZely
         SLWzjt8+WqiLcBRCJzFe62aNxxXVdArH55S6IzNNJlpes9g49qEeaHJXoqUScBlfkGbz
         n9CA==
X-Forwarded-Encrypted: i=1; AJvYcCV49PFWyqxcso8/Q4T3y1Ujl4D15ASbUS/pVSyZ2AtQz5ieoPDz2APk5hstHvjf00tAIVOHAPskd1Qk@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRsCmyOtLorc7BT2Q6yZtNEWttBLPS4zg3x+Yc9mRTiTHIdOo
	fyHOkSPlJo7zw81QsYbR/O9XfZ7OL8mqkQIMcNAQ9ZkjLh6DvFLqn1eZcTWQgWuWdqc=
X-Gm-Gg: ASbGnctH18rX4+hMGQ2yTCJlAjgVum3BKioyP4fqwc9ZdLvs0HaOgls4I2mUUKbsI/y
	SOKWcXUj1AMiBNIk1tRB/UuA4rcjqZ+fxnqUDpkXq/oriqH6KOju3K69Xc+gLCQ67Hbgs0Ie4dZ
	zF8kzOpSm1xYBBCncMXVU9V98APzAQtInG0xTU+gI53MKLgyW899XeYtRpotZFJrqwSe8TzdRCE
	3+GF1WXLX+aiUxC9uF1PbQEO9GuXexqt/F5V2tVve0jA2+66stLlQz3SeywFTihsaMODGMw37RL
	J/TVY2U+64cKGzc+hS+6nZ48WkYp4+6vrtuAGC6Km/notHxASMrKBmjzPvpwjZpNf+M8wrp2Juk
	/ydyVxz/TBjhFcpdemCevxVGhk19fGlPx7NQJAJsyGaZD4e/o3dS9YXbUklutt9BWbaR2IW7uFj
	NMWjocXWBnFHodG1JXr2TMq40Vk4jhk+PlRLu7OfhEsqUP205yXiXnd1Uv
X-Google-Smtp-Source: AGHT+IFSO9Vj5unlOb7AIdeUvsGnmndv4NOg05AMQzBeFV/Clblcc8fJCy8KfqYMZAMNlmV/ceJSvA==
X-Received: by 2002:a05:622a:1988:b0:4ed:e5c1:798 with SMTP id d75a77b69052e-4ee49464063mr5694701cf.35.1763579357170;
        Wed, 19 Nov 2025 11:09:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e573909sm1143226d6.39.2025.11.19.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:09:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLnYK-00000000bRY-0UK1;
	Wed, 19 Nov 2025 15:09:16 -0400
Date: Wed, 19 Nov 2025 15:09:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20251119190916.GO17968@ziepe.ca>
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-5-sriharsha.basavapatna@broadcom.com>
 <20251117173352.GC17968@ziepe.ca>
 <CAHHeUGXGTfsK66DOGdE6Y5VYVaOR=1YA6b2inds6_EkPSwTBuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGXGTfsK66DOGdE6Y5VYVaOR=1YA6b2inds6_EkPSwTBuA@mail.gmail.com>

On Wed, Nov 19, 2025 at 09:44:09PM +0530, Sriharsha Basavapatna wrote:
> On Mon, Nov 17, 2025 at 11:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:

> > I think this is generally not how things should work..
> >
> > If you want to create enhanced QP/CQ objects then you should use the
> > existing create QP/CQ ioctls and enhance them with a driver specific
> > uverb spec, not special ioctls like this.
> >
> > Certainly new stuff should be broadly avoiding the 'struct
> > bnxt_re_dv_create_qp_req' kind of design pattern in favour of the new
> > ioctl system's finer grained specs.
>
> We chose the new ioctl approach since it provides a simple direct path
> from the bnxt_re library to the driver, without going through
> ibv_cmd_*() and also since there's really no need to have the kernel
> IB objects (ib_cq/ib_qp) for the DV use case. But we will discuss this
> internally and consider redesigning this based on driver specific
> udata, like you are suggesting.

Well, no "simple direct path" is not a criteria we are using here, we
want to see either common infrastructure used and extended or a
devx/fwctl like direct control.

Not an endless stream of driver specific functions that are ill
defines and unreviewable.

> This design was chosen since some of the applications written by our
> customers are already using umem APIs for mlx devices and they wanted
> to use similar code flow with our devices.  

Well that's a horrible reason to add something so broken to the kernel
side.

> pinning.  We will address your concern by terminating the umem APIs in
> the library and not going to the driver. Later, at the time of
> resource creation (cq/qp) we will pass the address directly like you
> suggested in your next comment below.

That's much better.

Jason

