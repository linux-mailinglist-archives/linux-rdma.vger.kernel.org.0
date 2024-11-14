Return-Path: <linux-rdma+bounces-5987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415F9C8D5E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 15:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A3AB265B5
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169475103F;
	Thu, 14 Nov 2024 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaDBnpmB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBDC179BD
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596000; cv=none; b=H/0Pjw1gzJFaLYbgkE6OLG8CkvyEzIkBHvxDtmwZrBerJ0VM7xbxK6vDPwebrKMQmGFjlRg3oJUcv7gacsHIHMkF45Qe5gxqX4AZ9HKWOV9XnbWrjnKm9ZQhAHKAa0FvPm3mrkdDRBOzEpQ512uYjH9Rhx14nkSqzWEeF8A5PRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596000; c=relaxed/simple;
	bh=sArnJKO93DtLxgWRVHUKzCyrV29GEiCIUCQEG8kOklw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CH3MqeXXwuNb4avHJegsiGJdhgGUyBWsCDlpHYmr9koLc0sT3sweyGCLAwmbZUJLOt2VyKmRoy43LDhAcrYBAbjUtxRW5cNXcXCH1lukSyikxIZxZm14dQIq8PhHDUBmENnMTTg9e0Jdsac6itjBSwcW5EteQdqhjG8KX/D0GZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaDBnpmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E40CC4CED0;
	Thu, 14 Nov 2024 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731596000;
	bh=sArnJKO93DtLxgWRVHUKzCyrV29GEiCIUCQEG8kOklw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SaDBnpmBEHD1gBNLcI6K4XBvfzv/DqPOxxhQjeBL5feNdFPdKEnDBbo8wHViwk+Wc
	 pun2C/CznLstLccjJffPSsVEyhH0M9n7pfMsbII2WoQ3oklyg4mENYrD1kWIXvI0YR
	 FCA0/S0o32XwRy57VXnxOIClP/rGG0N7MEIpIG0r+b08J6bnNUsF8hOPDZw/f/07QS
	 qf4ZKMX+3Ahbon3h1OzLlgKE4qFcbd25Jni+tOlal6qSq3h3a6y/pYrJsqakD8M6a2
	 8xahXpK+I+i2A6bCWJXr34n8KR3bbFYrwbIvt2N+BxvuWr/3T0TTC0i4XrOaxrH01v
	 nunFaIRYOEkuQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com
In-Reply-To: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next v2 0/4]RDMA/bnxt_re: Refactor Notification
 queue allocation
Message-Id: <173159599723.153898.1471216964344855180.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 09:53:17 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 14 Nov 2024 01:49:04 -0800, Selvin Xavier wrote:
> Includes some generic improvments and code refactoring for the
> Notification Queue handling in the driver. Remove the data
> structures that store the NQ information out of the device
> structure. Fix few issues in selecting the NQ during CQ
> create. Also, fail the driver load if NIC driver can not
> allocate at least two NQs for RoCE.
> 
> [...]

Applied, thanks!

[1/4] RDMA/bnxt_re: Fail probe early when not enough MSI-x vectors are reserved
      https://git.kernel.org/rdma/rdma/c/65ecee132774e0
[2/4] RDMA/bnxt_re: Refactor NQ allocation
      https://git.kernel.org/rdma/rdma/c/30b871338c3eba
[3/4] RDMA/bnxt_re: Refurbish CQ to NQ hash calculation
      https://git.kernel.org/rdma/rdma/c/cb97b377a13589
[4/4] RDMA/bnxt_re: Cache MSIx info to a local structure
      https://git.kernel.org/rdma/rdma/c/31bad59805c388

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


