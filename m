Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFF3D737E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG0KnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 06:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhG0KnH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 06:43:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDE4961019;
        Tue, 27 Jul 2021 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627382587;
        bh=xQ7CN/7q9U5fML/kT2NzHTJZJF7k+DjVNQLuyl3ONNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTYbkPryUralK8WQTkZacyEAkc6fu2hJ5GDnlCYQx4FCxIxR6HR5OgxSOXu6y6pbo
         ZD1C8gqNarv1Enhbbw70u6KC0BnOIK3uhqbGBsViyxDQIywCVZWd23/6QLiAizzdAD
         Es2t2UfdBaEHCiLqC/qgLZnJa33L86x18d4UZdYEVUZ7ss6rFWWctJbBvjsgXT6/3W
         Qz2Dme2b7oG8vwBqZT5QzOdLtXRErLV4hEpBHSlnN1ZZIi9x4RxNZLrjC14DWpr1Z8
         ym+j9/75iBf2fax73Oe9p+bednWER24kmiyrdKatTzwTpd9FiYH0UL5K8lB9D7xnoi
         kLfGt5qQNwVCA==
Date:   Tue, 27 Jul 2021 13:43:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] IB/core: Add xrc opcodes to ib_pack.h
Message-ID: <YP/jN7fWbDKt4GqW@unreal>
References: <20210726231009.24020-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726231009.24020-1-rpearsonhpe@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 26, 2021 at 06:10:10PM -0500, Bob Pearson wrote:
> ib_pack.h defines enums for all the RDMA opcodes except for the XRC
> opcodes. This patch adds those opcodes.

Why do we need such patch? What does it fix? What didn't work before?

Thanks
