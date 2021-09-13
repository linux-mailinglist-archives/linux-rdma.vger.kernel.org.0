Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A040893A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhIMKkD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238560AbhIMKkD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C90B860FDA;
        Mon, 13 Sep 2021 10:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631529527;
        bh=72n4IhGm8qaEvZXLPKjwL9kpMg9H2xB4tvNA3gud90Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KegbAgs20gGhkvz4bjWVye9RFnnZ8rVeU+lwI3PRfteipwebtVbo3B5O6MgL4Z64w
         f03PzQCzLLBDiLZatkAamjDe9a7d4qQglxLJEKoCxrbohEysSS2bnqkTypita0vsan
         pjghGsSuQNDDwsGOnrPKK3alJbFupWuvY4MuF/G1XCm3lykRNAX+YSF7CNhM6BiFtE
         Hdo6UQ0DpghqF7frRM81MUenyJ9yYO+B9ux1yoPy9F4mJoupzAg86dmSbiuZZrqGVm
         fPd5t7+rLZKgGkW51jAI+cPXJeeL7ghnkXyoFO7iipCltskiUNndqkAN2k61Du32Ll
         yRMvtO4tmNN9A==
Date:   Mon, 13 Sep 2021 13:38:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH][FIX] ROCE Multicast: Do not send IGMP leaves for
 sendonly Multicast groups
Message-ID: <YT8qM0IpIslXL4Ni@unreal>
References: <alpine.DEB.2.22.394.2109081340540.668072@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2109081340540.668072@gentwo.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 08, 2021 at 01:43:28PM +0200, Christoph Lameter wrote:
> ROCE uses IGMP for Multicast instead of the native Infiniband system where
> joins are required in order to post messages on the Multicast group.

According to the IBTA v1.5, there is no need to join multicast group to
send messages.

 10.5.2 MULTICAST WORK REQUESTS
 10.5.2.1 IBA UNRELIABLE MULTICAST WORK REQUESTS
  ...
  A QP is not required to be attached to a Multicast Group
  in order to initiate an IBA Unreliable Multicast Work Request.

Did I look in wrong place?

Thanks
