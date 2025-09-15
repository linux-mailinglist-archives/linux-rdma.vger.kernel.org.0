Return-Path: <linux-rdma+bounces-13355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21BB571CC
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 09:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC917188B3EA
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04832D7DD9;
	Mon, 15 Sep 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3xsipIJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6882D6620;
	Mon, 15 Sep 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922186; cv=none; b=siWfRmmTz8ZOkwATvzKWTUmdVEquS/AI+PFLKyG3JfIn/nM85mcknQD32J8qimksFu6Rjd7g6M1QbxhyeIE6KmG958IU48iUO7zIUH0j2tf5Otg9x8uYLZoOhmys20f3NsJoZHJocEfOTk2inGuVbjZ8iGOEiAuH2r7de0ztLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922186; c=relaxed/simple;
	bh=nYQef/5IbygNi5DKexofdy1WTQRa2VX89nGHa2FEGs0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bC2RYMhS2ZXZopwdIBtncsdYVUqsgGw1iRig9USLn8BskMctnd8e8iB6cllWzngqbi3YQ26ZmuPF6RCaNKAiCPPs5kLIecoy7Y5wc8EX68GZeQVY7D92OeuOQV/hjNFipCmCwVMZ+U1ppcPkTOr/9Fkepgw3+8Aqcu7kJW1dfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3xsipIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97805C4CEF9;
	Mon, 15 Sep 2025 07:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757922186;
	bh=nYQef/5IbygNi5DKexofdy1WTQRa2VX89nGHa2FEGs0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n3xsipIJ79ylEt05vNM4Y1eDLeJovdeHTxfwRnRkfHN4irOhwTryvskE2kFdxJD5J
	 cNI7k3umSINr1N56hw5RawUdIkeBE7H97m+EKfk9Nl8tfQCDJBkn/2RkYMvHfv/IZ/
	 +m0Yj7W0ACRGlq3tuMB5hEmps9FjjFNlOWlSoVM/XHQ8I1Gjmenax6+lCOo8OLWOqK
	 LMRIfHcr52PCym8Tc0WBihZ4JZWJUf2GDyabwx7Z9j2fCH2+gDaS459/MHOg+sQFvR
	 BHmZ1Ni3t3nfkIkIi38fdIpYqaikNaeZjIJVRxwcSJQQEo9HLh/9gq9SXQfYXNWYEl
	 FJI29OGq4Z1kA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sean Hefty <shefty@nvidia.com>, 
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, 
 Jacob Moroni <jmoroni@google.com>, 
 Manjunath Patil <manjunath.b.patil@oracle.com>, 
 =?utf-8?q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250912100525.531102-1-haakon.bugge@oracle.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout
 error message
Message-Id: <175792218281.1172128.11777926053050212672.b4-ty@kernel.org>
Date: Mon, 15 Sep 2025 03:43:02 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-37811


On Fri, 12 Sep 2025 12:05:20 +0200, Håkon Bugge wrote:
> When the destroy CM ID timeout kicks in, you typically get a storm of
> them which creates a log flooding. Hence, change pr_err() to
> pr_err_ratelimited() in cm_destroy_id_wait_timeout().
> 
> 

Applied, thanks!

[1/1] RDMA/cm: Rate limit destroy CM ID timeout error message
      https://git.kernel.org/rdma/rdma/c/2bbe1255fcf19c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


