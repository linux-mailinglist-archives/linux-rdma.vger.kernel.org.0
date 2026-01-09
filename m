Return-Path: <linux-rdma+bounces-15410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F969D0BDA8
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 19:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97CF2301F5FC
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 18:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FD23C50A;
	Fri,  9 Jan 2026 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cr0s5phK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21123373D
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983738; cv=none; b=IT4JdIrYigF31lAlDlWi2oaqHUO8z8xT5GkrKvHVEVSyDdNqAZivY/LrfDqzcIHyGJA70o9F+EZgOqb120H8n2/1c34nBhelWaQiWwqr1wGQBkHHeVd/OggRr8f1Fk5D3WbcT6OtJBTLyPCBOFYsxjoMp02r2fXw/JxDE6hZGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983738; c=relaxed/simple;
	bh=HeCwwjc8A+ug7WJi/rXy2JjjF0lP+8YI6eeNCW4oNe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF0dLmfssNl7f58lU3XZIxhw6iwB312tTff5IHzVOBKbBJ8Q0qoHAjyRwTOsFmXyOVmRUXZHXqrTewtVjWPXad9qlF2i9sqmf0wk9F/bwAy8qZGHp0GFxvl352P1HkOdvSSHsFodlu21Xwn+A4ZoiWUFaSwXrkb/yfEDTUD/MAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cr0s5phK; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55999cc2a87so1319063e0c.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767983736; x=1768588536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20ZflWLPLAkvjNbw0O7EIcjQCBhm1j2kl4WSElyyNn8=;
        b=Cr0s5phKNW2zcgWu4ECRPn5tDMed0KGlmSzuPyFQilftI2smdo5eH0ACMW3VaVQDhJ
         scqTFjMe3i1XFnvpy9IZfQ+aNHceTbY+i5zklhkV6lhuxLD9xnHfpNRB608pEDU/mjvs
         VJnFahqrgUlbFXGVF3CHC7ySx54DjIuSu0/wmo/Dat4OuHLtcbUGzRD/tPqB7xAyA8Bc
         HdERHJnSUll0bAnkhl92GPIeO8XaNlUNbwE2oNP/bYnd1Oj6ud65D7Q2ggcbc4nVH8J4
         tJlaZ2BdtOuv0uqN8zD9Ket1tEPfN+K1LnVcz6kPiR2a8/DlRidsTbYioLEBE4tZsAXt
         98Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983736; x=1768588536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20ZflWLPLAkvjNbw0O7EIcjQCBhm1j2kl4WSElyyNn8=;
        b=EUjQAGvUGM6Gsben80wTRhQ0Kf5Ow0ZtHEQ6QiLFt2tqXRYJFDqjbFbMaSIP86Tcf2
         1d//nkXcUk/gE7rmv/OYgDlDTyV+mv4w5Pfx0DaCb4G5HcKjoVeLfif9c8ILlkBrmpgA
         Ks+st7jbbsO8MFokHDDsdPyb6Jp7GGVx5RFw8tkz6CmoY1L2LGZ3L9kWkLYhMKc2n7/f
         Nbui2lpPyvI7Fou1h/U+g6ahIGdXHKo+Ab+M6XnJthX7O3PMV7k8AOOw6Hi3uCrx/N3Q
         Fydlpeu1Bd8+jRk3ASGhVEUM4C+/UmIngX7+jOx5J/vDQndTxVG7ufhP17ehCmiM0U8M
         shDw==
X-Forwarded-Encrypted: i=1; AJvYcCWEqE77MwcGlSjAoIUOQeW0Q6uS46xFQ7zBblGYbCRdp0h5JUYGmLNBGMMnOI8Eeo6hEtxHsJjEm6xN@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFKjxvGWttKLEcGxOA4TGrJX2DwooByCJbFtIM5WevQ3jwCwm
	cQrZrZXiVIv/CzBYDU9ZUwByrss9tsdJD8ciH9JEFBiTrPASsu3xkxnVSzj6Z6jF5Sg=
X-Gm-Gg: AY/fxX6uo4FJho3dzmOCXtXxya4nodJSth+TrbFETa6Q9KdewPNPbi3yQ1Jxo/DRwxI
	YhvfTG7iNjPd81KV4OBj9CdIC2ZbtvY+fUZpHz1QDYgzWjOKKn+CUyZ09WJpMO+upf97ctSE88n
	UrDFJziA0h+8LyQF5RZtIzviy4yZirlkiOERWawgAExj3H/yZ0jVZm/7jwG+RHKKhYYexPN5PQR
	QPw9axvGoF37xvMJmXoWefMEsreH7cQsTl1/EMjjBaAkQyK7rGtdKLOLs5C7ngs4UxARoSce144
	vsaySbThKxolqqUlksPqjARrJtcsDbZmsDL3VatBTfQMkncaBRR69SvB7ziFuM22HbbutqE9JF5
	8Rb5u3SgbxCrUoVgKpLMikWW+lNZ8fpcj2LxXtNR0DFq4wfc/kMz4CnBl/PcSGnjjx76JsqTNwo
	gJVkwkmCjqXL1bj+Q2WfnduPVJ8vMZPB3GNkanwRjXNESLKxf3D9NLovk6yRpbnqFjx6E=
X-Google-Smtp-Source: AGHT+IF2DJm4D7+VSaAgLSDJALTZ4p8iSLHaQGc4Z3Qm/h/206jf0t9qFQ6sSqek7l4yj6ME3vAm/Q==
X-Received: by 2002:a05:6122:2516:b0:563:71e1:c884 with SMTP id 71dfb90a1353d-56371e1caecmr255398e0c.5.1767983736435;
        Fri, 09 Jan 2026 10:35:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563667cf148sm2579969e0c.2.2026.01.09.10.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:35:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veHKh-000000037LW-0BuG;
	Fri, 09 Jan 2026 14:35:35 -0400
Date: Fri, 9 Jan 2026 14:35:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260109183535.GJ545276@ziepe.ca>
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
> +struct bnxt_re_dv_db_region {
> +	__u32 dpi;
> +	__aligned_u64 umdbr;
> +};

This needs a '__u32 reserved' to mark the implicit padding..

Jason

