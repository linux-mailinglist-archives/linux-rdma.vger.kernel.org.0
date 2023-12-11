Return-Path: <linux-rdma+bounces-369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4780CF76
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 16:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC88281955
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48A4AF91;
	Mon, 11 Dec 2023 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qw3tWCYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AA1E5
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 07:25:49 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67adea83ea6so33701256d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702308348; x=1702913148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RnKL4o3KpZTzZRDhq/XTXx5OFfjh8+mhbmJEdr3M1y0=;
        b=Qw3tWCYTVCmHsEU/ecpIiA77ZnRoFsjRZU6l9F60D8lK45gOU30O9+A8bO+ODYDVAb
         lYUWm4HroeMVwJRQN3VXBeYNAvT03XoiKlJDdfV2sv4fusIBU5a9cp0yBuSnV3faWz1k
         jHNuxmVwM0TfOCZrOu3/MrN9sN5My8NcZa7Mx7ZN7JaYWo/BHDgaZYlDz+tJgoyDnW+e
         9westBZEwRltyXDdocp9R7n8W7wxxeha7cFGp9wrOx3kMV7z79yL13trfDZnAD9Zwm2Q
         1lZhjD6CPLTWTy4f9Yr7jqW8MYLd1amxm5y305IyCEypfLouZaWnYJt89fbHLFxsmmGC
         b/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308348; x=1702913148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnKL4o3KpZTzZRDhq/XTXx5OFfjh8+mhbmJEdr3M1y0=;
        b=Ico38H2Ve6JbnANcp2zJqaCR3rWuAYzAthd6LkpcP2RZkRxZdcKOELzBb5dwCG4WXY
         cq0IuVtIbmWsXUPXks9qwjiKbFZ42Jwl86JQsq8Ejg9E8jP5vDC183Vjcvd63YYN8LOO
         oxV/gKeIvehkkUuTUp6L3oPDkFYLGH0AhANnDa7I2eGpHdy7hPBf+sw+0y7Rc7fA7tdG
         d7LxiNjXAta5Es+rggI6hvFTG9HznnuB/5sbfbUyjCrhUyTAmkVRjS9Z08hXIthTF1Nk
         Cobj2sfI7kaDRtQfZD4jgUsEsC02eepco9gq6+xykwIDRZFK1PVF56q966+LtUfnPIZx
         m/6g==
X-Gm-Message-State: AOJu0YyCR8FLAT6J2vvEs6jAPg3grzW5B48iF+07mSJIggqB93dqx07I
	G5yoqbOQ5LRJc9RjnHpPJ6V2jA==
X-Google-Smtp-Source: AGHT+IFBH7z3tXGGZRNgqPM/RvL+eXBGFEzwI0RePPMz6tIXVpWnP6XXwq3tI51ih5ycUdf1eDukDw==
X-Received: by 2002:ad4:5761:0:b0:67a:a721:b193 with SMTP id r1-20020ad45761000000b0067aa721b193mr7280280qvx.78.1702308348225;
        Mon, 11 Dec 2023 07:25:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id dd18-20020ad45812000000b0067a34a4dd3asm3365383qvb.130.2023.12.11.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:25:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rCiAF-00CcR7-Aw;
	Mon, 11 Dec 2023 11:25:47 -0400
Date: Mon, 11 Dec 2023 11:25:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Vacek <neelx@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the
 warning
Message-ID: <20231211152547.GC1489931@ziepe.ca>
References: <20231211131051.1500834-1-neelx@redhat.com>
 <20231211132217.GF4870@unreal>
 <20231211132522.GY1489931@ziepe.ca>
 <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>

On Mon, Dec 11, 2023 at 03:09:13PM +0100, Daniel Vacek wrote:
> On Mon, Dec 11, 2023 at 2:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
> >
> > > Please fill some text in commit message.
> >
> > Yes, explain *why* you are doing this
> 
> Oh, sorry. I did not mention it but there's no particular reason
> really. The @Subject says it all. There should be no logical or
> functional change other than reducing the span of that critical
> section. In other words, just nitpicking, not a big deal.
> 
> While checking the code (and past changes) related to the other issue
> I also sent today I just noticed the way 08bc327629cbd added the
> spin_lock before returning from this function and it appeared to me
> it's clearer the way I'm proposing here.
> 
> Honestly, I was not looking into why the lock is released for that
> completion. And I'm not changing that logic.
> 
> If this complete() can be called with priv->lock held, the cleanup
> would look different, of course.

complete() can be called under spinlocks just fine, AFAIK..

Jason

