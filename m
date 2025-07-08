Return-Path: <linux-rdma+bounces-11965-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6798AFCCE6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A55C1604C0
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FBD2DEA84;
	Tue,  8 Jul 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EXft/RZw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF43208
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983379; cv=none; b=b8opHLZSpTIQGL2dB0WMcR8+PVN9qBPuPqfcoqeqJIFvS9qjMmZ+0oDHmTqQse0i1f5JhZsUEuswWMLrIraC68QHIxVv+d8ZCuhNzflkplBe4eU9oP8gwDGAFmYy0gEJ8Kdm2J8wtv+aNioXV7yanGFLCC4VOJ+Y4Xg1LootA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983379; c=relaxed/simple;
	bh=lnZpsZ+chaQInqi24EEsEPUutEx2Ox+CMWZZj897TXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeCY3A14a1tj4SG68SHhbBdnw1CHF7u4CyoJaGB8U2hQhaoBhJn0mvLG0bOWKCKKnnn1//uSemwWt4d0vz0QUztRJ/v+h6KvipwxAQ2EMAownpJ4U9sHZQ06cMl5Ip2TVal9yy8W1msSdaImDvz0GW1ucubK5t6FlwKffKIUo8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EXft/RZw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7da363af61cso71585785a.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jul 2025 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751983376; x=1752588176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPbr0aWk4/yCJ/2d+S9nx40/MshKJpZ080c2oz/kB1M=;
        b=EXft/RZwHuWGAvpkKuCSRtvsyYnRL5o9si1Tl6rDNgujsTe4Wvhf+mjK9OHcxwQnMx
         xNB2v3BucRup83bPPfJs3XsnOgKctIbKd+BjZhf8TruYWbbfQCkNbyPauSF7mxgQm3ug
         cpcs3SgyGfWKlA1tn43vmfPOxZPz4VGX0nWTYQOEW0mAzj3fC1Eh/lNFC9qZQfLp5QXj
         5PhKyWoSsOpNsLA9wrd9PPFGYDS8XRIb1HgfdvsoBC5ja9K32lfSRor0nFQNw2LTSswC
         pXHFUWWKtGVOeqZBWZrCvQPAFR89ZP+19mUJS03a/ECxJ5jN+Elu31eTIRp+cYY+O5l+
         9Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983376; x=1752588176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPbr0aWk4/yCJ/2d+S9nx40/MshKJpZ080c2oz/kB1M=;
        b=NDR1aejtpjYaWvRjKc/o72G5Q0J1iVCIWDiDAfrZkfSTzvvJA/aTGv2nYELJQ+zJHy
         vjUe2np2Rp0g0KNQZKs1OiSaGhzR/2/V8UJAelCvHBc5wxnWAh/sWn+rG3We0JXjNLFe
         frWlOq1H7X4vEBqsq/DMTX6kxw39/6Ku69gv338r9DRORW47KKN+aP9ld1vhmZs6zO2u
         SoK5WFaHLsJUg2XKHS5xjVRcAcjzMZDgvQfjfWoyhuy7rW/z1jlQ1LQXiTnB9If1C11U
         RuAY8zyR9wSjhkCcKaAf6YBNBUZgmJnZkrMw6RkCKtoYEleEOvS+Wttd2gpTm4bIFJuX
         5K3A==
X-Forwarded-Encrypted: i=1; AJvYcCVhgbjCgjsFtDxmslwl+SYkT4RAw8HFsxCMnlF1V2+bEzmM1sHTZKARqrcEMdPcyKWfT375smGJ9ffe@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnNW0DpxoaehDIsFytynWFVgCrvfUnoT+oozBWCSaBvX5euWp
	uytcW4SKI/3hxmC7JSsRTPzWLqeX14e3W1+r6oQUvtQYeufkYxMJ0GKDu5lq7OJtOtw=
X-Gm-Gg: ASbGncuAg2SDpuM1UhJSfPE+jT/WWG6iJGrdbfeRanDkBTHfRBbp9Y3TV2W5z+JWy6k
	Wcr32ksqHYu5lxMxjck0v+fQdvq6XhpOmWadyK0kj4DOzr0Fd2jmDDDTHJBWVT5f8GT0ff5u6ZQ
	Kp+rgmsMCWzJvwOnjeIufLVyzoO8XiMp8Ky3Ol6TEQ7ljam0YX9gYT/yIk5njfnD9q71AxbLhTT
	l2sKkX0FX3yihiOkCRklbqXupEmouIItiSQRQ1jBoNzn2hODY9vTdL0JcDTQFZgZJHAFO/ynffh
	H/q+PfFJcuvu4BsPdfVRnlJx01FKCQR3whUdjT5afPMtN4upgHRkCmeO9hTi4aEZN/0h+GlOvFT
	HdRyce3pN4deSgnsbmtZrJSVdzwueE/pdneWNPg==
X-Google-Smtp-Source: AGHT+IHaqayucA77uaeB9phheFywlSYDNuEVYk2me9uoa05TsK5qnGNMW7nfDSNWq0ohBZ0YBPyfNQ==
X-Received: by 2002:a05:620a:28d0:b0:7c7:ba67:38a with SMTP id af79cd13be357-7da01a8a72amr486730185a.6.1751983375186;
        Tue, 08 Jul 2025 07:02:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeae942sm777334385a.99.2025.07.08.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:02:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uZ8uL-00000006i8p-3jqF;
	Tue, 08 Jul 2025 11:02:53 -0300
Date: Tue, 8 Jul 2025 11:02:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Edward Srouji <edwards@nvidia.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
Message-ID: <20250708140253.GP904431@ziepe.ca>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
 <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
 <079b29ad-593f-4fc4-b693-db3eeec9fc23@linux.dev>
 <20250708122943.GW1410929@nvidia.com>
 <d143ed1f-a4f1-4acf-978f-059101f3973d@linux.dev>
 <20250708131331.GY1410929@nvidia.com>
 <4f25d3c1-c32d-4a45-9db2-8b8e1602c698@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f25d3c1-c32d-4a45-9db2-8b8e1602c698@amazon.com>

On Tue, Jul 08, 2025 at 04:57:58PM +0300, Margolin, Michael wrote:
> 
> On 7/8/2025 4:13 PM, Jason Gunthorpe wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Tue, Jul 08, 2025 at 04:12:09PM +0300, Gal Pressman wrote:
> > > On 08/07/2025 15:29, Jason Gunthorpe wrote:
> > > > On Tue, Jul 08, 2025 at 09:03:12AM +0300, Gal Pressman wrote:
> > > > > On 08/07/2025 5:27, Junxian Huang wrote:
> > > > > > Could you change hns part as below? We have an error counter in the err_out label.
> > > > > Same for EFA.
> > > > Yuk, why?
> > > > 
> > > > If we want to count system call failures it should not be done in
> > > > drivers.
> > > Why is this check different than others?
> > > 
> > > EFA counts failures from incompatible udata/abi, or even
> > > ib_copy_from_data() errors, isn't it similar?
> > It is, and that is the Yuk. Drives shouldn't have counters for generic
> > system call failures.
> 
> IMHO if control reaches driver code, it isn't a generic system call failure.

I don't think so, lots of the driver code is generic boilerplate. This
dmah check is generic boilerplate. If this series added a new op
instead of a new parameter it would not be counted. Doesn't make any sense.

> Maybe we should find a way to check this in common code rather than handling
> in each driver.

If you counted the number of FW calls that fail that would make sense.

But this is capturing too much to be considered just driver code, too
many of the failure paths have nothing to do with the driver.

Jason

