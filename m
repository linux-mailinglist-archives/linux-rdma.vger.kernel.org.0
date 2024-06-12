Return-Path: <linux-rdma+bounces-3080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD79059F3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 19:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA366285CC3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8171822DD;
	Wed, 12 Jun 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5T7VXSb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29B1822D4;
	Wed, 12 Jun 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213376; cv=none; b=MqOkIgAYhwjza4QwWA1F5wMV2VlfXwC6hMXXJpy2D5rYOyxNU8U6w65NnCc0/W46L9vfKs7basI7onDoanu1yzp56CWyRRfOIZQwXOG7eoNjOE870EX800PEbf2/aGUbtEJw6LCnt4S6WbNnXRqBpThZBXhXBjzyiev3EHiw7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213376; c=relaxed/simple;
	bh=Ba6GyynrpGuIi2Xb7JlSRrHrUtyBqSQwFHKrMZhcRb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxYpD4UQhiFeT2OkNLmjIbFR8l8fm1rcggJXLBbbvfaUPWc5WxUz8p4kNSFKWvv1AVx9e23KpFp95L5w+lnHBCvLMdr8nxnpP4VQpD+GVvKmIuMkZTWI0DXC/C9nviFNX5BY/7LtVdf6gQgs1V6jLZdiF9T6j6XHAfJxqBqBiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5T7VXSb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so51906a12.1;
        Wed, 12 Jun 2024 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718213374; x=1718818174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7EZE8kZJ8YwXGxhpq3/arcNZCvvFBiX+mbM6jw0kdY=;
        b=l5T7VXSblow1UfHW7uXzGe8JE9/Fu95k4EG2JKAuDFqZIpd/LTS+PvTjurrPo2YF86
         yTXvbyHadkhA37K8PNdhYGUmWFeGtA5SV4HvDUGm4sKuG28oMwOwR6fFi7je7eaK6RM/
         sqLvAGlHiOb8O1KwH4QOCuGEhWiEMC5PXkLyXrSiBl1gYLRxL/mQxxR3+YOkwRq0EH9v
         Rvtgladx4GBLBtJ02DvlfYk7q6gQs3lnf6kIx50TgpJWZs2FaiTl3135EnPkNgjFcrNy
         PLz2epUJ/L1YUYNO5FJnJA21JOAjGLZ2kM7rM4bYqb7rY6HR+dOkBiN2YcRe826VDmfk
         30lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718213374; x=1718818174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7EZE8kZJ8YwXGxhpq3/arcNZCvvFBiX+mbM6jw0kdY=;
        b=Z9MhGeeT+RkDPwvKpN7sKzmwDJJ/PchxAOC/UxlDDyUEg77mkRYmUPrKciDo+ve3E4
         rd0x7mBYP7ypnhZv4n4hHBfKeyJ7gQwjzs+XTbwbTH9/tCpYAX3t0xjesPjeqna2p+Fs
         dPOWD0HaO9eveXOZF52Hwp6NgHZNI/3Ntz0zOXB0JMsWmXwJHoG5MvSylmJTpCr+tTqM
         dEaGAiNj8AeYUDcX9xhzM2nubymDeJs1TrwnZcZ9KGoT2/+Wm7+32gW3/bA2gfwBVb94
         MHiY8dKYte6CGPymy6F4VeI6raIXLoOgtFH9q4jJiNECC52Hsdess6AA89sEY416DJdc
         Q5XA==
X-Forwarded-Encrypted: i=1; AJvYcCVrlQTfePZyknSgT4Jh36Yeuir/xfChUGN5nt2dfA0l5Uzav1GzbFeRF0kp/+/9is2ILBKNhZTDpEzVT2Yc/VaVHtdCzFfm6tNRl8NF
X-Gm-Message-State: AOJu0YwqWmywzFh9z+0CEA1tfT+a4J+MT/14/Z8GrGcPBFT6i74JnvRW
	hyqJ9H0jJsfhZh8BSeLqeXU7y2da8eG0jXYYhjODu8CcWZSPgMjE
X-Google-Smtp-Source: AGHT+IGd7Tv1NYL8MvHZP7GP4sML4J19g55sFnTvjguJaFG888Hs+XWIgGoJVs8gxFkgyVjNU8c+yw==
X-Received: by 2002:a17:902:eccc:b0:1f7:3bb3:abb5 with SMTP id d9443c01a7336-1f83b64ac13mr27474335ad.8.1718213373929;
        Wed, 12 Jun 2024 10:29:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72a6c5a5fsm39546885ad.233.2024.06.12.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:29:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 12 Jun 2024 07:29:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>
Subject: Re: [PATCH v2 1/4] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <Zmna_AmrLgTgfdHw@slm.duckdns.org>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
 <20240611182732.360317-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611182732.360317-2-martin.oliveira@eideticom.com>

On Tue, Jun 11, 2024 at 12:27:29PM -0600, Martin Oliveira wrote:
> The .page_mkwrite operator of kernfs just calls file_update_time().
> This is the same behaviour that the fault code does if .page_mkwrite is
> not set.
> 
> Furthermore, having the page_mkwrite() operator causes
> writable_file_mapping_allowed() to fail due to
> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
> enabling P2PDMA over RDMA.
> 
> There are no users of .page_mkwrite and no known valid use cases, so
> just remove the .page_mkwrite from kernfs_ops and return -EINVAL if an
> mmap() implementation sets .page_mkwrite.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

