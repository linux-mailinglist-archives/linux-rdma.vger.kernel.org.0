Return-Path: <linux-rdma+bounces-7811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70262A3A824
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D377A3B52B9
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1851EB5E1;
	Tue, 18 Feb 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfojWHhK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5271EB5D6;
	Tue, 18 Feb 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908405; cv=none; b=WppsmOFOcaTAFwNJ05VgTv/bXF7JNXevdx9najCEi535lfS7cgfb/ZoEd1VRw9bn0DYYZaTeKHHsNy2VC3e9Gbmvpw2iRDSC32UdmDG+XR0edQh8z3Rfx1eYSBMoV5fpzTGU21VqNtg/i4bGOfHR6CG1Ox0yrYjlcncetjJvyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908405; c=relaxed/simple;
	bh=6aMb5On2h13Zbq3nzIsDGVDh3egE731sJ0EmWYXRCEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B7R3yFkDIeIirOXrBHsZ7Fu7DbC2V2U3KyIDuu14IEFkLVFMtL4qPNtXnS2zIUuYvLWrf4ub4DxqcucBPGTF9mMm3O41alR3WTJM5aQfT44wx05fBEJaGIWivOGiS1EL4dBFsG264+e3QUU5gLpZ41zQzKeo8Z9hZERLRkdTLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfojWHhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8901DC4CEE2;
	Tue, 18 Feb 2025 19:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908405;
	bh=6aMb5On2h13Zbq3nzIsDGVDh3egE731sJ0EmWYXRCEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HfojWHhKRTkn+DG4SOPSmGSXzKP4ojGIFGjkaWjOpiML61g+/6EKO8Cn2as3aHIpP
	 mwVT1su9IRmQ5bTi745OH3fiLYEo4LPtwO1wVOu6E7VfjwWBs0fY/0sUzsXLeNGs8l
	 mimBwv3Hr8SIv4Z6k3JeQexHFbsIbEbLjaP2givqpQPzZqAvirusrSRODYhZ+OVgi5
	 bYNxPSTkS7vbg4b+e7cPTpftddPctI62Jt2QAJgE75quonN6rjKdBleUU92g6lPm/A
	 8TfK2OYhnaesjMmE5to75rmiJ48NRzfSMTpu8iWePed9VW7yiG+NEPGwlZX4qJ9PxA
	 F6pRT2U4mDH+Q==
From: Leon Romanovsky <leon@kernel.org>
To: shuah@kernel.org, sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca, 
 Imanol <imvalient@protonmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217183048.9394-1-imvalient@protonmail.com>
References: <20250217183048.9394-1-imvalient@protonmail.com>
Subject: Re: [PATCH v2 v2] IB/iser: fix typos in iscsi_iser.c comments
Message-Id: <173990840181.364763.18291092516354685820.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 14:53:21 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 17 Feb 2025 18:30:54 +0000, Imanol wrote:
> Fixes multiple occurrences of the misspelled word "occured" in the comments
> of `iscsi_iser.c`, replacing them with the correct spelling "occurred".
> 
> This improves readability without affecting functionality.
> 
> 

Applied, thanks!

[1/1] IB/iser: fix typos in iscsi_iser.c comments
      https://git.kernel.org/rdma/rdma/c/0172be244ce367

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


