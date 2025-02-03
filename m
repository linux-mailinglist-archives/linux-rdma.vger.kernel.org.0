Return-Path: <linux-rdma+bounces-7358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4549EA258ED
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 13:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7626E3A143F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768F20408D;
	Mon,  3 Feb 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfDy5b27"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA81D618C
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584149; cv=none; b=BLzm0fUe10v6J22CaoKlDG8HxKf9HaPghkO2wLNaHiou2YWsE2YRIgF3G0/b9p2nOGq2Ug+N/kMz6s5tnKXBnR3iHOlHiEJ6764vM22MhEqOHkD22eoh2WbypsXeJH21Qjd+fLdjchyZuNAu6rqR6gl/T53XPZtzqogdWqfb838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584149; c=relaxed/simple;
	bh=nY+ZGMr5qP3YpjGbQeLreRWC1slIe86RBO/sj0vpN+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VhQo70Ef+kzmmXPcNUyDWechzbytuc3XB3+BHChtlnDhfd6Dnro9PNze3mjFCrOlgJELMgUYMu6/wB2fIAfRCSn8upmEGb3nmnfcqVhqWXtg27o8MGPQ3E2qHDOcDfeUAAY1zMKjWr9C/kPc2eJgxtvCwYxnavvykd+95CmSlKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfDy5b27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803D3C4CED2;
	Mon,  3 Feb 2025 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738584148;
	bh=nY+ZGMr5qP3YpjGbQeLreRWC1slIe86RBO/sj0vpN+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PfDy5b27ZdpfqgeD3+HjqnQu2nAcUIgBDdtUd3mrSw28EHhjuDovllbfh2F1MAI/a
	 laAg4TqVR8lMe9kNarIMNUCSfHoRfMhUF0JYHq3qOYyAfcmnYABsL0s25SO3w9Z6le
	 3qzLONL1gNi6he7TPe+RqE4KAzUp4yRXH5b++dHU9yKbLf/m+RzzY0qylYSIXqwPKv
	 du9Yvgj19xT7KrfIKbd6soXIXUaLvC7cSnZuAGeD99YR40rcnVFYV3BE8PWzCscY8m
	 fA3h6DL1F4z+b4/VxgvcESoek89p2Vk4iaTnwCj5V+YCiGBhKJbpxxkmhAPRXIYuEU
	 YOJHxBUMhHipQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
Message-Id: <173858414593.653794.11500377183678078985.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 07:02:25 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 19 Jan 2025 07:45:35 -0800, Selvin Xavier wrote:
> Implements routines to set and get different settings  of
> the congestion control. This will enable the users to modify
> the settings according to their network.
> 
> Currently supporting only GEN 0 version of the parameters.
> Reading these files queries the firmware and report the values
> currently programmed. Writing to the files sends commands that
> update the congestion control settings
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re: Congestion control settings using debugfs hook
      https://git.kernel.org/rdma/rdma/c/a3c71713d9548f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


