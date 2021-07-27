Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93033D74B0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhG0MCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 08:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhG0MCR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 08:02:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B58B6124D;
        Tue, 27 Jul 2021 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627387338;
        bh=093/Di3Td9tl7liHyzALXm7HKz2hZnu0dpXKgka6ASc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z99G+MdCIfOHrtGVTP9DMq7tVggE7Z3oYVyGAu8BAwMKAluULN+cne7Vr5OPw7I4h
         3YkUm7YjltpacS+fLoEcnGFK4bB4DAH+MRSMjpudV7+WsJNxrt13n03cc0lxnMHMoO
         0oPItkvzqaGGIHcM9ifcYYxd0qLaA7fSGVD67ZT8/O68OWNQWALwXvVyi14iyKyMB0
         o822ACRGMmnz1XcRf3sEoicOFb4o5zuFiZo3n5kcnl9DmIfjt/FqMIJ7R3YTKzDFTP
         whMINuzb9VRz7sGVdqA5O5tC26zLCxJJwau5qvvWMwml+wA+wm9I2nb3jLcnTtjXfz
         zaebY5sKCUvug==
Date:   Tue, 27 Jul 2021 15:02:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] IB/core: Add xrc opcodes to ib_pack.h
Message-ID: <YP/1xQZ2cOQKtKtO@unreal>
References: <20210726231009.24020-1-rpearsonhpe@gmail.com>
 <YP/jN7fWbDKt4GqW@unreal>
 <90946031-b1a4-3944-b207-05bdad9a8cb6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90946031-b1a4-3944-b207-05bdad9a8cb6@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 06:23:48AM -0500, Bob Pearson wrote:
> On 7/27/21 5:43 AM, Leon Romanovsky wrote:
> > On Mon, Jul 26, 2021 at 06:10:10PM -0500, Bob Pearson wrote:
> >> ib_pack.h defines enums for all the RDMA opcodes except for the XRC
> >> opcodes. This patch adds those opcodes.
> > 
> > Why do we need such patch? What does it fix? What didn't work before?
> > 
> > Thanks
> > 
> I'm working on implementing xrc for rxe. It uses the opcodes from ib_pack.h. So I have to either add the
> opcodes to ib_pack.h or redefine all the opcodes in the rxe driver.
> This seems like the better solution of the two.

So please submit it together with your XRC series.

Thanks

> 
> Bob
