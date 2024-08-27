Return-Path: <linux-rdma+bounces-4584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C8960CE5
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 16:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E219287969
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4D1A0739;
	Tue, 27 Aug 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/baeEjR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B101E487
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767428; cv=none; b=dH4Vk+h0m6AjV2Jo+zMzBhwkJqBRA4llxoBC1WjttS3D7ODyzMNFDPd8Bb3VwhPdge/glt5o6XGC2D4X190R+kWi4IBaoOvkeJ8Uo43x4kEI6ie/xUoShCqc5KhAcwGvPKFSzzZGRO7S8MMA64VaENJSoag0pGNRg2FhKsqjizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767428; c=relaxed/simple;
	bh=ODhIgflBfpn/+SjOVd2GLrnz4NVKmuHSx0kaGwbuKEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s3xcatbrqEJRU9l+BWZuBbzBUJdkSkEwXMZh7rbbXSPAWs9CZKPFPEKBO0NlEqV4pJhfzl258qYGBLCMLLLXpodtErS6VqCKGeegmZZv/qkTovIEkpAVw/XmH3vhUhW7ptxLhKOOx1gdxa1cLKiW5qgBOhe/BGu2hWVC62iUWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/baeEjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC2AC61048;
	Tue, 27 Aug 2024 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724767427;
	bh=ODhIgflBfpn/+SjOVd2GLrnz4NVKmuHSx0kaGwbuKEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G/baeEjR6Z7Z6JD/ZqMNmGQ2Gt2mp7za8u3GDWZRIM6yJnKFAm168MLddHoU+tXbq
	 CLafrFn25nP/ap/+0gIBGuDFZX2B0RAZAzycUJbAN8HVv4Zu2iJjsXrG1YHE9Xqgue
	 gAiODUgwbKTKQU67B84RTufDLJWKp/oGRBSQZOHXXP8hIjgma0YLZSRbAwFz5Tjo0a
	 ikELYk0FBh8F18qKu4A2n4zWmFMlabe3CuHhabumJCDacladXH6jf3DDBgHlMitUuK
	 ApAgDMk45vVJXXzhqz9pZrhBiNzW6YLkq+6Zr7dUDefP5qVFKqNJoqGgiD7XQl2OD1
	 Mg1E26zcF2DKg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next v3 0/5] RDMA/bnxt_re: Use variable size Work
 Queue entry for Gen P7 adapters
Message-Id: <172476741598.44825.7956403925591914882.b4-ty@kernel.org>
Date: Tue, 27 Aug 2024 17:03:35 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sun, 18 Aug 2024 21:47:22 -0700, Selvin Xavier wrote:
> Enable the Variable size Work Queue entry support for Gen P7 adapters. This would
> help in the better utilization of the queue memory and pci bandwidth due to the
> smaller send queue Work entries.
> 
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> [...]

Applied, thanks!

[1/5] RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
      https://git.kernel.org/rdma/rdma/c/9ac691e5faab4f
[2/5] RDMA/bnxt_re: Get the WQE index from slot index while completing the WQEs
      https://git.kernel.org/rdma/rdma/c/be3b457400fc97
[3/5] RDMA/bnxt_re: Fix the table size for PSN/MSN entries
      https://git.kernel.org/rdma/rdma/c/8cca8cd8cb2898
[4/5] RDMA/bnxt_re: Handle variable WQE support for user applications
      https://git.kernel.org/rdma/rdma/c/e0e75e66109dd2
[5/5] RDMA/bnxt_re: Enable variable size WQEs for user space applications
      https://git.kernel.org/rdma/rdma/c/ca58eeb8b9e59c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


