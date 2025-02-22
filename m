Return-Path: <linux-rdma+bounces-7997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E7A40450
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 01:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DC6420070
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E7B4120B;
	Sat, 22 Feb 2025 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1J2by09"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4144644E;
	Sat, 22 Feb 2025 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184833; cv=none; b=TzdfiBYB0jdz9zAFgal9a7RJJBxhtAgyX24LPkBuaaShimq4s/8vLG7kVbCqmTW8P/o50Id4gc26yOlxsUvjDh/duoZeGgfObulbP7K3JaG7U6srMrdcN268S4PHE+JK51js3eCQCblnXNaAFeMu2+V6DA2Z1ae6yU5uURBKO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184833; c=relaxed/simple;
	bh=1uhGdL1pKC7eKDLGos5wy9wNRiP6RsMLiAQJ9lOSo7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3qp+COFqpy/hbcNeB/v/+vrZWksUcTpkYXpbhgnZlAQ6oz3mnBgGuE2C6cgv+omen4KYXHGpy4GvnR/3h1Lja4Tyon7kuue8pOUV7w6/QZNR9jkYbQnqjUQSbeUNzsu56YelSIbkj6clp+ACvRSj1hb4/G+qqLJaXiHxHfjDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1J2by09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A41C4CED6;
	Sat, 22 Feb 2025 00:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184833;
	bh=1uhGdL1pKC7eKDLGos5wy9wNRiP6RsMLiAQJ9lOSo7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1J2by09HXI0PGm6JH1Ho1fKg41i3c53pm89BFC4yv+NyC+E53qo1iw4Ncc+xtTB/
	 1yB+f2TGC36nrC5xhIOhP8ivD581ed90Xyvec4rwYuF+rePwYLX2BB6YEVQSCohdDV
	 NBUwGHWaGZCfXp37A9qu89OsvZdg4Vsv/rhuBYaZ6KqtjtUp4w38AORNKklvshvfxZ
	 n/XkMvLAnB6mk9eBBsTruECKmwNeZpaXd+Qj9SMRXZP0F23AggXPPmprVvP2n1LnMF
	 eNUGvj9cvAeGL4OR5txHLl8H2had5uxXuCMlYavANIetNB5iuymrRhw7q4zYcTvnNP
	 6EfpzUqwOFytg==
Date: Fri, 21 Feb 2025 16:40:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 abeni@redhat.com, horms@kernel.org, michael.chan@broadcom.com
Subject: Re: [PATCH rdma-next 5/9] bnxt_en: Introduce ULP coredump callbacks
Message-ID: <20250221164032.2cc01348@kernel.org>
In-Reply-To: <1740076496-14227-6-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
	<1740076496-14227-6-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:34:52 -0800 Selvin Xavier wrote:
> From: Michael Chan <michael.chan@broadcom.com>
> 
> Add .ulp_get_dump_info() and .ulp_get_dump_data() callbacks to
> struct bnxt_ulp_ops.  When ethtool -w is invoked to get the coredump,
> these 2 callbacks to the bnxt_re auxbus driver will be called if
> they are populated by the bnxt_re driver.  The first callback gets
> the number of coredump segments and the size of each coredump
> segment.  The 2nd callback copies the coredump data for each segment.

Acked-by: Jakub Kicinski <kuba@kernel.org>
-- 
pw-bot: nap

