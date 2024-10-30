Return-Path: <linux-rdma+bounces-5614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1B9B6456
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 14:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA5D1F22119
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B01E9092;
	Wed, 30 Oct 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms3Y+joO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E758185B62
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295582; cv=none; b=B3P3JIVE8qSPnDDchHcRs1AdBCZNc8x3/4l4rUZy99qKDuR+pikvCPysTpc3ysK+hZTZ85MiDG1jeJ+8TCmvnyI1fqy2nMCzJ5HNBcHV+NXyDtOHOFqUjHGtRtNwNpHPyiGMUcyupfKI9cLJbO0lUpiCp3mygyZIjk5RSZG/fBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295582; c=relaxed/simple;
	bh=7UMPoTjFKOs+qlTqky4/X65RCe1O4wsGyo+1R0kHTAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TY8UIsxmYzooUniKendd08NbQNMxCo6ZZonR2tNN4+4KirF+t8fm/T2cQTwi/CPEov84nfprtEcbihdeA3uM93VTToln8cayUJPYcEF7qhXvv02pEB080MJJKS4056o9Th8fwr0ynO6z1DHVW9kVTZzffq8wgGUy7UIimZ1yrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms3Y+joO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD278C4CEE3;
	Wed, 30 Oct 2024 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730295582;
	bh=7UMPoTjFKOs+qlTqky4/X65RCe1O4wsGyo+1R0kHTAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ms3Y+joOVZtyWru9SSoMYOswo1F7pG045q9B0iCvBn/G1v777DxtKZ0bYhsPgGqIy
	 jLpaG3LfWpF8rsRs01fY7F52AsZ7OBxeWpctqiDa7H7RH+HNnytT7CWCGqi7HzsqAT
	 EHJZEQVajTFW3VU4DgKncNWnQKbdQx2CmcGndjWocHrGbcciVpym8gFHJSm4RukZDN
	 UtU+OWj37vg9TRP9MAPo7OnC1TYwez29LB+/TA+M5fhqpUDumEUTUPENxKViuNhA2n
	 VNIBt0tkZOA3yBNt1+deK2N729/SNi09+cks+AbuacIRLy/XwPPicW3Jqqyuql/4A+
	 K/jNY4gmwAXHQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev, 
 Daniel Kranzdorf <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
In-Reply-To: <20241030093006.21352-1-mrgolin@amazon.com>
References: <20241030093006.21352-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Report link speed according to
 device attributes
Message-Id: <173029557797.8417.8723614756162842759.b4-ty@kernel.org>
Date: Wed, 30 Oct 2024 15:39:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 30 Oct 2024 09:30:06 +0000, Michael Margolin wrote:
> Set port link speed and width based on max bandwidth acquired from the
> device instead of using constant 100 Gbps. Use a default value in case
> the device didn't set the field.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Report link speed according to device attributes
      https://git.kernel.org/rdma/rdma/c/1103579d6e32a9

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


