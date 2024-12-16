Return-Path: <linux-rdma+bounces-6542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9856A9F3168
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 14:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65767A2EA3
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC43204C2C;
	Mon, 16 Dec 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpotKHrd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93420011E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355345; cv=none; b=rtyFKmNZuFWRHW8JeyVIJK9Rx0dRhfnMSYO5KHBqtp6HsP75PhGrZiZE6Y6v3yaPrm2ktPTiz+0rB2LLp+DEQYJV7gQ0vVNLWRFHHwIjqCAOCEU5LNICLCmkoBY6xdihaa0huaMsRME0QPsj+lYaMbfOErG6RCrZnUS9Sfp6gOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355345; c=relaxed/simple;
	bh=IcfuPOQCRc8RR//UpdLrxx1t9uizEEg4jT45oA+TUz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ozxFm7UblqRey3B4P3W+GpDeJ6KhnnrZV2TMeNlQcGL9dyKX+VksTAKoSso3/XmSibmN6/SH3+egMjH1hTXwXRkvlsAKWxnPHzAkzP2TcAcmaAWfpqgs8dyk1GDalki3v+kFhKE/4/xzW4CM+GVNBXO+LqMTewLrLUFQNjdzjlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpotKHrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2B4C4CED3;
	Mon, 16 Dec 2024 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734355344;
	bh=IcfuPOQCRc8RR//UpdLrxx1t9uizEEg4jT45oA+TUz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JpotKHrd7Rf/qnkgEfuAhQSAB8fWhJ3Ay2s9IFrnUs1aArK612obxSRhhxA1WX9A2
	 QAAeuWKlNAP57VzTU5bqx6CwlmNb2QGDrnLAjwZrWY6559HJ5gT2tOLzuu9JSBJKtC
	 GSy4xr3uxsmCHmxreBTaZz55KhLyDeCxHJP6DID33mEb+FF7yd+6psn7fTqRB8JUeZ
	 /1fynp3UvfNH/fXSq7oyiEOr0x5jjtotR2FwFu2y+X1axeNo7C0u8mmLORyeTFwnq+
	 Cppbl9yqJeLu/s/Zs9fk/xXuqQNLA0XGepheWxERm5i3JkjrnzYlIahttmrZ0YQTsT
	 tJObimQlOSpiw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
References: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next 0/5] RDMA/bnxt_re: Minor code cleanups
Message-Id: <173435534161.184097.8790138952791773104.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 08:22:21 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 10 Dec 2024 19:45:40 -0800, Selvin Xavier wrote:
> Some minor code cleanup for bnxt_re.
> 
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> [...]

Applied, thanks!

[1/5] RDMA/bnxt_re: Remove extra new line in bnxt_re_netdev_event
      https://git.kernel.org/rdma/rdma/c/c7f2cfe81e059a
[2/5] RDMA/bnxt_re: Remove unnecessary goto in bnxt_re_netdev_event
      https://git.kernel.org/rdma/rdma/c/ae51cb98213268
[3/5] RDMA/bnxt_re: Optimize error handling in bnxt_re_probe
      https://git.kernel.org/rdma/rdma/c/55992c386263f3
[4/5] RDMA/bnxt_re: Eliminate need for some forward declarations
      https://git.kernel.org/rdma/rdma/c/8aa3dd3e765912
[5/5] RDMA/bnxt_re: Remove unnecessary header file inclusion
      https://git.kernel.org/rdma/rdma/c/1950af31dc6648

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


