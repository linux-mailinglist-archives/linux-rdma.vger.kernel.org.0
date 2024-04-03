Return-Path: <linux-rdma+bounces-1772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA598979AC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 22:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796C128C3C6
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098BF155314;
	Wed,  3 Apr 2024 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="djlzjePn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoWHZjgh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB0450EE;
	Wed,  3 Apr 2024 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175398; cv=none; b=F/XjSyiymvbNx4u5sEaWBqQxiRZcAgJP9GLra+SB2Y2HAK/+KffsGcWouEcdUY96/1Zc8w2jdNtpBhVABOGl4qULo7Uf5Hfmb20t0Ma/gUCzReOZdgBIvU1vUHnx/beuINQvzn0R3UOEqErgPGhphuGnJjzFj6iv10uRLKE4mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175398; c=relaxed/simple;
	bh=iSGR+vY60ekIujW9+ua+A64fCX5CAffc8VlSrDgr/tQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gjvmhVJ9XQTEb0HJvwUxf6aAbOZVWTjqxQ9F5dSRzXxNBUYC255tjP/UfUjSrYIPW8JNl10uoUWMaBQJrX2dmt3Xf7RS4B65IU/Psdl6qy/eJLpKwAQ/vtMwstw9aKkMVoakOZm3VNVFIIn3Cc6uD1DbBXef70VUkfEzZTxjxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=djlzjePn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoWHZjgh; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 8F0E51C0007C;
	Wed,  3 Apr 2024 16:16:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 16:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712175395; x=1712261795; bh=v2UHe3x4Gl
	nvqdOcFzDiIIFY++CTWaFbu5Hp9X3plSk=; b=djlzjePngsEcNOk6ucUNEQeMvr
	V6du3iz9G9cGVjNG+tbPoDoe9xBqkDLEap1boe1K371M6yk9lbEkgPaipmQXSK6i
	LeKbFjTzuGS0192qPhECANAhAn2j86iWos52KXwySNuBNwfblkdnh5WfytXCDzJN
	2K3mcEdNRyfIKTQCeUdiebUL1ZgAUlrRx3QFXVPe6zEU0kNbDr2EBuFux4U0zNzY
	zW3B3Sqs/+yxv7aUqymJNyFHm0XruHP9AAaxCGn07LWubWQzJy/h/kLlkl1tsjo/
	pUunL10LlNwxkLXzJ0bx/DYDRIFYzKu07lNawHo4jPtu36HDSxzlbz/t/JoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712175395; x=1712261795; bh=v2UHe3x4GlnvqdOcFzDiIIFY++CT
	WaFbu5Hp9X3plSk=; b=NoWHZjghgcyl+q3HDQhYLVauEeNzOjp7ie3S333CzC+R
	G+llbXZGA3rcOyns7SHjD+rhAb19B0FSseZ8z2zI/Ywm00JqFReCsVimxJMWQwWN
	y2/PD2Xo95hfoPewNCJGM4LCPmJjs/ern/rRN4ofrfO5lMgsZnzy5y+IdzQ3z1QJ
	gbZLtIJOFKId7dNQS/IYCbXVY+fRbrgxfm4e9KfICIkYUkn3ePxDc1BmSsC8/vrl
	b/hJddkmkORRd+AVZGxAD5c87NqMrU/7cg22f+DHwYaGjc+iGX490Nq2/xVQDgCE
	j2MX+Bq/4TPIuBtbeWnMCghwdm4TEjwyehejGOtTSQ==
X-ME-Sender: <xms:IrkNZj4EDFQ08jqLjhmARO2k_UdYhZrDQbiClZDpUMZSk9ZZmPwe1g>
    <xme:IrkNZo6eC4qUfnQuKKTzYVeetA7ZIFdc_Ni3pLzmfP9AcgzZsL0cPLg-aQaTvM_ej
    sPuQeHIi69qjoMNvM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IrkNZqdurn1pAZmn1BsutWEZOlldn1f_7vqC_Qyet16gX73QcCGf-g>
    <xmx:IrkNZkKThlNQFXFY9wDR6m0yfkH7BTbGAPijssbdrLBzfecnXGi3Zw>
    <xmx:IrkNZnLDtbFtpyeoOKTq3NgArNsQXvm-ekqe70K-zU_nr2RJhxa_Ow>
    <xmx:IrkNZtw_-4FGKFfJoWDPxvFQSajSe3nPMbh-XIDqb7mdYtllqro7Ug>
    <xmx:I7kNZhBbynIJvPnLVfWiq1EaiNvZFJ5LpT2OKH66ISKV2AzejpxzzAw6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A45ECB6008D; Wed,  3 Apr 2024 16:16:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74ed482b-7b2c-43bd-892f-824acec65f61@app.fastmail.com>
In-Reply-To: <20240403154534.GE1363414@ziepe.ca>
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-8-arnd@kernel.org>
 <20240403154534.GE1363414@ziepe.ca>
Date: Wed, 03 Apr 2024 22:16:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason Gunthorpe" <jgg@ziepe.ca>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Leon Romanovsky" <leon@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-rdma@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH 7/9] infiniband: uverbs: avoid out-of-range warnings
Content-Type: text/plain

On Wed, Apr 3, 2024, at 17:45, Jason Gunthorpe wrote:
> On Thu, Mar 28, 2024 at 03:30:45PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> clang warns for comparisons that are always true, which is the case
>> for these two page size checks on architectures with 64KB pages:
>> 
>> drivers/infiniband/core/uverbs_ioctl.c:90:39: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>>         WARN_ON_ONCE(method_elm->bundle_size > PAGE_SIZE);
>>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
>> include/asm-generic/bug.h:104:25: note: expanded from macro 'WARN_ON_ONCE'
>>         int __ret_warn_on = !!(condition);                      \
>>                                ^~~~~~~~~
>> drivers/infiniband/core/uverbs_ioctl.c:621:17: error: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>>         if (hdr.length > PAGE_SIZE ||
>>             ~~~~~~~~~~ ^ ~~~~~~~~~
>> 
>> Add a cast to u32 in both cases, so it never warns about this.
>
> But doesn't that hurt the codegen?

I just double-checked in the compiler explorer to confirm that
this works as I expected: both gcc and clang are still able
to optimize out the comparison for 64K pages, but clang no
longer complains after my change that this is an obvious
case.

I also see that gcc still produces a -Wtype-limits warning, but that
likely has to stay disabled because it produces too much output
elsewhere and I don't see an easy way to shut it up.

     Arnd

