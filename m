Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941492DA76E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 06:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLOFWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 00:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgLOFWb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 00:22:31 -0500
Date:   Tue, 15 Dec 2020 07:21:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608009710;
        bh=Z8oeQsr5SkV8XcBZMI23godI/4bZYOxTbXvjXc6i+os=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Modzl5JbxlQ6ZnccIBq9i78tBQxOoDIL8kSUCSTJqWwUg+wY4wDae4X8Md6pgRm2D
         f5JAjnEprRzIImG+06FIZGP0f3jtFuzqnWwmyq7wuQhM8NWTtimPyaeJsNsZcv1hyR
         Kl1xqZmAK8mJ/ThTpl7Vfp3eJ6Qf2+4hYAYjJkcsBwMOPslrzRDin8ckx/WvT4nAC/
         boh40KSP5ZxVAlo66N09RPoQdPHsVm0kxK6uC2Ipovjebw3XRPPxTTpBskvWdExdJ7
         1oKZwsHHlGV+CLfJEGjLdSd6YmZWzgfHpQE0ckFF/VJbNp4YBCtUndIOLLXR8UXhDZ
         CDf+qMc3QzFqA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next 0/7] RDMA/rxe: cleanup and extensions
Message-ID: <20201215052146.GI5005@unreal>
References: <20201214234919.4639-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214234919.4639-1-rpearson@hpe.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 14, 2020 at 05:49:12PM -0600, Bob Pearson wrote:
> This patch series makes various cleanups and extensions to the
> object pool core in RDMA/rxe. They are mostly extracted from an
> earlier patch set that implemented memory windows and extended
> verbs APIs but are separated out since they stand on their own.
>
> Bob Pearson (7):
>   RDMA/rxe: Remove unneeded RXE_POOL_ATOMIC flag
>   RDMA/rxe: Let pools support both keys and indices
>   RDMA/rxe: Add elem_offset field to rxe_type_info
>   RDMA/rxe: Make pool lookup and alloc APIs type safe
>   RDMA/rxe: Make add/drop key/index APIs type safe
>   RDMA/rxe: Add unlocked versions of pool APIs
>   RDMA/rxe: Fix race in rxe_mcast.c

I don't see the patches in the ML.
https://lore.kernel.org/linux-rdma/20201214234919.4639-1-rpearson@hpe.com/
Did you send them?

Thanks
