Return-Path: <linux-rdma+bounces-5779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28A9BDA1F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 01:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F99B2257A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 00:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1261FC8;
	Wed,  6 Nov 2024 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzCxhBDE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224A80B;
	Wed,  6 Nov 2024 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852201; cv=none; b=tSRvvHFPxRVbFBLBJ3FypJtaJGVwWaHWfgQ2bu1AoW6npCsIJLwUcdKh5ydlcCuFo8LRP0SJFbkgaFjCO26CnxI21pOZFonPcrc/GsSXS4WZOwj0R/m2T6tvhZyJbUeQOXAfZ2YG2ydFlLEaNBRHmeVREGyae2LQklHatg4WDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852201; c=relaxed/simple;
	bh=4E8pe19Mt9HCapnVGCJMIu6IsFW/M4ck3EeSZ/gXElQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/ttnKqL4pCw16jDXo4wQGCsfNzz1AAf2DSIE0zeGaFtxaWmaK+KhQa5XQ4HA+MUpo5cjqiaX50M7ISLpVwXXRabMPEyRVxzbkBV3XzV/+4+iihE9KQRqOmyNDMwpRMIbXQvqcYb6iUuypo7RBpKD/5xuRbjzFFLd93rl0tBKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzCxhBDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135D8C4CECF;
	Wed,  6 Nov 2024 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730852199;
	bh=4E8pe19Mt9HCapnVGCJMIu6IsFW/M4ck3EeSZ/gXElQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dzCxhBDEkIHBds9Y4ks7pMkyQ21YAd++7jc05gY7Izhtb4xXl++0XmQbgktelvcPm
	 QPLk4KeVACIuzH5yftdeVvG6I/rIF1y3WNU18HRe5IioXrtjyQRaEV+f/tU1dcXPRA
	 ss9hBXNUcDDS989JUVZmfSdH53InHmezhnz9IpYStdGZLMu0DFCkkgLkVagD52eacU
	 lJpDTYoWq6OiMWh0TVdBd9zlWk5BdvRsoyZ3hCGGF0BpXXeuNoPWhcOLpdT+4kQNC4
	 M25HLLkQuPfKcvruidlN4vRotTVXBagoP9eP06sjXslsaQN7C2G5HxdTrbz05JkCAp
	 dEUICqUEBgYbA==
Date: Tue, 5 Nov 2024 16:16:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com,
 andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com, Vikas
 Gupta <vikas.gupta@broadcom.com>
Subject: Re: [PATCH rdma-next 1/3] bnxt_en: Add support for RoCE sriov
 configuration
Message-ID: <20241105161637.77cbfeb8@kernel.org>
In-Reply-To: <1730800752-29925-2-git-send-email-selvin.xavier@broadcom.com>
References: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
	<1730800752-29925-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 01:59:10 -0800 Selvin Xavier wrote:
> On firmwares which support RoCE VF resource management by the
> NIC driver, configure RoCE sriov resources while resources for
> the VFs are allotted.

Rewrite this, please, into multiple sentences.
Its incomprehensible.

