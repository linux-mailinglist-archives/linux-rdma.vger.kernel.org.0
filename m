Return-Path: <linux-rdma+bounces-15316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12670CF6308
	for <lists+linux-rdma@lfdr.de>; Tue, 06 Jan 2026 02:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1455F30478E1
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jan 2026 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0127815D;
	Tue,  6 Jan 2026 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WAdXLdY+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7D274FDF
	for <linux-rdma@vger.kernel.org>; Tue,  6 Jan 2026 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661633; cv=none; b=LLLf3nPJQamt7/MI8FHT40aQg7T4pJsuuqmdzM3/ASq3fPXLWp8smPP1oVFlYfaLoW3BycdIFULex8lvjMKuYYfg1Vl7ARAskR1G/N72SiwIl9fco0y1dfMLZc4po6J/Oq5BM0bK6v0RwJB7IHDCb+Y+qHQ4pjkrJmz75whCIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661633; c=relaxed/simple;
	bh=TtpdHbukwEFQnmz3ckdmLHSJzLrBUAxVPaYrmXbSQQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+jcJTgQ4LIa9pdTwkQpjQAPECvhN1GlRlCIYhTUTyBL8lR2Cy4vT4WrPX2MRglpSFJXp+9ZlZxzOL6Zjd0SFDonVzRbcfQe5U89BMr6oUDySIUzd6Tfn7zNDSUTEJMklVzRMQ04faUutn9JzAiMDtPM0+1gBeeLZajyIHD+x6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WAdXLdY+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ba0d6c68a8so47226585a.1
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jan 2026 17:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767661630; x=1768266430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=drgdDcwNGsxFqgCONrNiAAW6lMSwQ04qtIUzzps58Z0=;
        b=WAdXLdY+xsEq2Bwew26X6rHqoYm3Pt7kjVpfN05xaN7KMcpaCSc/24JwE0MlDhyfRa
         kxby86ilhfrQcBEGcsS8eU0htnXqV+EDYYpgh5ppHUOQvPv9YdCOZ73qHSDDVQRfYDLu
         jU1Yn96W1X6YUmjgrL1pGRLS5Lc9CV38EATlORx1kN3PvpHTl/cwXS/YSZoBdTVvGEpM
         EQw4SDeQx0p7wVDlCJPx+4/hfrLPoq/rF76S5rg1KN6USUyV6C7ZTsO5zlxN5U/6ABNZ
         f8TFLiKRddC51Oh34ebZauDsvFdtBDGpyjbbjvzWQcP4U9IKk47Yl7/OAG/YDV2Z2TP5
         AVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661630; x=1768266430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drgdDcwNGsxFqgCONrNiAAW6lMSwQ04qtIUzzps58Z0=;
        b=Z8BqKuvv+KhrOmTeLzVibNlPuaTgzHcKc/3kbhZbd+KDLLyBgro9T4EywAkuNIRNbW
         gv5vVardjj9/3NXMkSKHGME4O+xLhYyB1OppFobonwCxA6TevY53iVDZ/6rdPCS6QQLQ
         wMR87kWpHaL3jxIPRfW0Iy4czElb6JT0F6msIM0Q67R34tvGyUJrQ1wToIG1UGtcN2Jy
         CfsyySU8V4jT3iETjNlJsZjON79UoznVNUWXdSP1vwG7gET6bLcPO0R8UDP0kgoxGb9M
         5A5WxZL+UgWgy432rdIztCNVQAeR43Wy1gCIlKHIvn/ePTyVqBu71EXXDne4KkHfzkwe
         1+fw==
X-Gm-Message-State: AOJu0YxaoUs/rUrvFHuskCuW9t3fwexwzyoZE19kCQI+nNZvPtVzDzp6
	0H2VnQzRhxf2LNLznaIzO0w+qV34AphzSwHkvY9P9XZ2uJd8XGhbKH4a/CkEjoQsmKM=
X-Gm-Gg: AY/fxX7ScfxtvPtQhsTTZuVL4FhGgVVHtBsx/D+3+bGmsn1hIpz8oSQzRs68NhlRi/8
	4emPXefF9Zzjw8VsxcQV7ia5TLcTY1BcD9J3EIMcshD5lRKFavUsLDofSLIeITYdZ23gOxYV/V4
	U3DS0KUTXV7tKCCeemZGdLMveVKLYOTTNHixRyq8bFbdv+2GCS6E/G0YmGl0g7XsFVyr0XrR2Rd
	DlHerqjvYu2ZBNEaP736C8tgZBmZddLgxpNjJE5gO/pN78e2ohfDdIAo7MN2uCiNgKZRFTN46yB
	21QIV0B2PAkKKbNblvsQU3PNOb83JKZwv9+FpNNgAUOTH392TMQUEAHyuPb+feGu31qgau+1tNJ
	YYX+iY1ACLXeAUWZ06uCv4hvq3cMN9ZOMut3YyL+T981o4l6YEGayXUIEeEfuY4NE0LnEAqJLww
	sfw6Omm8nECTEg/VHqV3Azq5p7ESrHulgBdbALormtQacjVRzwNrogNSU+81cTU0T/09w/g1jpn
	jMq8w==
X-Google-Smtp-Source: AGHT+IHhT1NOnu42pNSz12y0NefP0H/0F1k0TtCk86h7IFq9pIdlZ9qXpmEGoKQZYUBTJdVBDiNU1A==
X-Received: by 2002:a05:620a:708b:b0:8c2:2b5c:6bb3 with SMTP id af79cd13be357-8c37ec03772mr174404885a.85.1767661630435;
        Mon, 05 Jan 2026 17:07:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a97fesm67018585a.4.2026.01.05.17.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:07:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvXR-00000001Eb9-164U;
	Mon, 05 Jan 2026 21:07:09 -0400
Date: Mon, 5 Jan 2026 21:07:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"leon@kernel.org" <leon@kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH RFC] rxe: Fix iova-to-va conversion for MR page sizes !=
 PAGE_SIZE
Message-ID: <20260106010709.GO125261@ziepe.ca>
References: <20251226095237.3047496-1-lizhijian@fujitsu.com>
 <cbbba297-7095-49f1-82e0-8f22d4f94e1a@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbbba297-7095-49f1-82e0-8f22d4f94e1a@fujitsu.com>

On Mon, Jan 05, 2026 at 06:55:22AM +0000, Zhijian Li (Fujitsu) wrote:

> After digging into the behavior during the srp/012 test again, it
> turns out this fix is incomplete.  The current xarray page_list
> approach cannot correctly map memory regions composed of two or more
> scatter-gather segments.

I seem to recall there are DMA API functions that can control what
kinds of scatterlists the block stack will push down.

For real HW we already cannot support less than 4K alignment of interior SGL
segments.

Maybe rxe can tell the block stack it can only support PAGE_SIZE
alignment of interior SGL segments?

If not then this would be the reason rxe needs mr->page_size, to
support 4k.

And obviously if the mr->page size is less than PAGE_SIZE the xarray
datastructure does not work. You'd have to store physical addresses
instead..

Jason

