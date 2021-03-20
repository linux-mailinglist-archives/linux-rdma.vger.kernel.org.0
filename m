Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F47342BAE
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Mar 2021 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCTLMa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Mar 2021 07:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCTLML (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B37F619A3;
        Sat, 20 Mar 2021 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616232634;
        bh=zs6f/mF7nTUAQezJXgE6vq2LUOB4jiUqb3XxVYDGMis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/CI3We5bHVxrbP/8GTObYZKtGU9rB2W11WllJAC55lB5T5J2L2kOWE4zlLrmAzrs
         1MCk7J+Bgg5iKER9mm1EQGM8OfwX6Hdm4LJaxfs0qdiIWWkTK/Ccjaqrb3q4WxFaPu
         8UzOBEfvmqbBYjT1u+vmv6505TcB/5wNQohYNZaqGtfFiHKCU3NfnZaVZFP0Dr6SPr
         ayYNP3Tex5WR6Ycb6zNzrO9AAnS3ZMBjU0r/v/pIG2+AmuMdpa04JfeMAIDnidSx+z
         sJvRM4HJo3RfaQq8mHLuh9zsbLaogBR/r1Y+vr98URAUMMBbkTCWYxfiYLwHriPBnG
         QF1FTwQD5URbw==
Date:   Sat, 20 Mar 2021 11:30:29 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: IPoIB child interfaces not working with mlx5
Message-ID: <YFXAtSsEL3etCO6b@unreal>
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> Hi Jason and Leon,
> 
> We recently switch to use upstream OFED from MLNX-OFED, and we notice
> IPoIB stop working with upstream kernel 5.4.102 with mellanox CX-5
> HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 kernel it
> behaves the same.

Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_IPOIB?

Thanks
