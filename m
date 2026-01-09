Return-Path: <linux-rdma+bounces-15414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC4D0BFE0
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 20:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B6563026C27
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787C2E266C;
	Fri,  9 Jan 2026 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iFTwWavK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322E2D7DF3
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985318; cv=none; b=LSGIi6SPmY3Vh0vRhLtIZwFmD4XwTjfRdkSlg3rmeogBpDMjEudUTV1+rLaW5mvwYR6jEtMRV6X6v0033aOX8sSDFa3Oib54V0cICFM9sFlSvWe8f/YRt8HS48zYohsWMVi3R4mTipmeI8rn3Rj+cM11p42UlK6DP3iMnozTkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985318; c=relaxed/simple;
	bh=F47LkAPl1ib3CR60umgeAhXEmGi+WiKWZOqzNJGzzvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYh2kQGe7h2jCACDnaEzIxTasOMp+GUx+nwh1BKMJ5YOWsiTSSPMw9rAeX2+ryLW1CeizcUNIQcTP4fyoUETBhYS2kK0Kne8E+t/lSMrP1JqvgJ0MudNU6TRle4ZZtrYwSQUeqM0ydmUbFt9/nDXlYTJ66WhM+AMI/r2ac7V244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iFTwWavK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2ea2b9631so519260785a.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767985316; x=1768590116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w7w+Au07HQSndJIPVyj0k6LnQZc6UpqniBOr3x08xRI=;
        b=iFTwWavKg1IN2SKxsTOETBjjbbS21GTeCLQFemKW94SOoz5G9k86CqAz1IPglI6atg
         MAbWByA7ASQFnT7N7nGE/zg2+ML/eoQUr6g7pYcUMXgATwIPz7ngxPbcoJ1uMGgpgCqg
         5V2etYSGnsQdPH+E1ypoRstXBtI+YIBzfIL3Y1j2qatykkwMYY5E4cnzlaxzKaEHNttO
         bI1vEsJxbk56My52fjtuGPnO7OPDLrpP4Xl+G9rkBY+PjTXBnvqprifxY6mYED8h9Ibu
         vaw1E5uaTm+FMOJ2jv615ZYg++87sL9lwUVo06udqnOP6WGa7V8LvCh7Siyk6mLJ7ysV
         2dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767985316; x=1768590116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7w+Au07HQSndJIPVyj0k6LnQZc6UpqniBOr3x08xRI=;
        b=Pbj5pcYzTAhfH/v9gKRWgd1nZPVfMvu9aCD+xjSuKEz8yfLntZzmtv329Yj9JVk3w0
         56Iwy+TZLkVd3ryYciSvNp15jWPRy5Ml8ZU6JH92lhTWhZtLK6Ij61ddERP3Jcmtwb6c
         x8tdfsFGHvb+wdt9eJ6YZ0x31AWrixB8bie54mG3GTVzrEn/quHlr8CqywO0+m2x0fVF
         rRES1OPyrvJdnjPlJoclfHhX3zEKAvTnAla3pKGLnzvDaam2WGGvxXTacWizyvquPGmf
         CZwjMg9AS/d8hU9aSoJaRk48GLkmgR92o4tO/8VvWB81YYwmiMb+AASEUXC9Dnr0nsWO
         fJeg==
X-Forwarded-Encrypted: i=1; AJvYcCXaLkNs1K5RbSscloWX2VXsIDb7R75+gExup20dzoKpxj6DtIRVLe2b1pJmDVc8KMM6AGlBPf9fm19V@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjb3vLfHXxcOn0iktcUHBJIXWG5ety5phSjkqHwgeluV9B9cTX
	CLmdauhOlpNffWJvt1IxE/CrRAmCAffRzsYM22eGK7aT5yar+xGMmZChvs/hZ1SJ7hw=
X-Gm-Gg: AY/fxX7zwgAXZsQSx2aVQDqReUl7cqP5RjWGPvtc6ORAvP8sN5ntguxEqKT2If9eb2s
	53kuHhDWqt2e7wsEG2TiV9Um3AT9+tbOnpHt7xHUqezEknNFlai86tOebAMrKlY0eRvF1aCL+yD
	J3iWl2wqplXkytJvHUq0c8AXPBKM9QXy9+31dqKZiTXhuVbbTUQL/vJDDokwzk58ekpxRFrch9r
	NwnaYhPZHsru11Sv9u4k2f4wMZfnXxzH6+CATLxIhoRT7c1v6ttlqbbkifETch/FXP75B+pPIdB
	lK34It+NBfacp+VylVMBdVMSJF9mKSSRRGu5k6DqpJHXmTyZnAKNlNfNDyzI62XyxpLth9rkuzO
	YN90/ULh2Te65l2Uvd035b2dZAKI4ajfkzI/cEz/Ps2+GgyXDNvNoFs0DlGId82w4FLUMG7hdtc
	Gqadr7mgcTDirwrj4PgU1wac2itavaZ6vkll48bPzvHHBXO35bUzakvXwIvRN0j3N8MaI=
X-Google-Smtp-Source: AGHT+IFdYwuNIxh8IJNt/42RrWQ413388XSu/oWKHwSUteUSk291IEidx/74kBqatTlrHPgseSBj0g==
X-Received: by 2002:a05:620a:4081:b0:8b2:20db:829d with SMTP id af79cd13be357-8c38938b4f8mr1481704185a.35.1767985315599;
        Fri, 09 Jan 2026 11:01:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f5413f1sm856992585a.50.2026.01.09.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 11:01:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veHkA-000000037iR-2bUW;
	Fri, 09 Jan 2026 15:01:54 -0400
Date: Fri, 9 Jan 2026 15:01:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260109190154.GN545276@ziepe.ca>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com>

On Wed, Dec 24, 2025 at 09:56:01AM +0530, Sriharsha Basavapatna wrote:
> @@ -217,6 +218,7 @@ struct bnxt_re_dev {
>  	struct delayed_work dbq_pacing_work;
>  	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
>  	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
> +	DECLARE_HASHTABLE(dpi_hash, MAX_DPI_HASH_BITS);
>  	struct dentry			*dbg_root;
>  	struct dentry			*qp_debugfs;
>  	unsigned long			event_bitmap;

hash tables require locking.

	hash_for_each_possible(rdev->dpi_hash, tmp_obj, hash_entry, dpi) {
		if (tmp_obj->dpi.dpi == dpi) {
			obj = tmp_obj;
			break;
		}
	}

vs

	hash_del(&obj->hash_entry);
	kfree(obj);

Has no lock I can see and is not safe without one.

Jason

