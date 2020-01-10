Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6222013767F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 20:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgAJTAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 14:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgAJTAv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jan 2020 14:00:51 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3AF205F4;
        Fri, 10 Jan 2020 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578682850;
        bh=jFph1sWi6/+Sg6SeLwtuu+O9LnerVF80kCg8oNOgx14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxEbMOJkKw5mp6cbVOfDoal5eL+AlhQJK+E0XchdMbDv3m/EKtKsTjywOlXFPWB50
         gA8MWVLT5wvV2bduwaVaoLhPGudT6LLNVK+ARq3rEdCuKKNIykI9d6tLeSvJNa2Ayf
         XWjL6kT3d3NYQAUzigNCQ6D3mOuUKEjpNsa14Tzw=
Date:   Fri, 10 Jan 2020 21:00:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     wangqi <3100102071@zju.edu.cn>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [Discussion] can ROCE protocol work with NAT (Network Address
 Translation)?
Message-ID: <20200110190044.GC6871@unreal>
References: <c663da6a-486e-415e-0687-300239f0f56a@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c663da6a-486e-415e-0687-300239f0f56a@zju.edu.cn>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 10, 2020 at 06:51:39PM +0800, wangqi wrote:
> Dear experts,
>
>     Because of a project, we need to use ROCE to send data from
>
> region A to region B. A and B are not in a same LAN, and it will
>
> go through NAT (Network Address Translation). However, we found
>
> that we can't send data successfully. We do some investigations
>
> and find that in an INTEL ppt, it says because "ICRC doesn't allow
>
> IP header modifications", ROCE protocol can't work with NAT
>
> while iWARP can work with NAT. We want to ask a few questions.
>
> 1. Can ROCE protocol work with NAT? Is the INTEL ppt right?

I have no idea to which "INTEL ppt" you are referring, but RoCEv2
is an extension of RoCEv1 to support routing over different subnets.
Instead of IB GRH field in RoCEv1 packets, RoCEv2 uses IP and UDP
headers.

>
> 2. Is there any method that we can use to make ROCE work with
>
> NAT? For example, can we modify or remove the ICRC part in the
>
> ROCE protocol? Is it a good idea?a

Use proper hardware that supports RoCEv2.

>
> Best wishes,
>
> Qi
>
>
