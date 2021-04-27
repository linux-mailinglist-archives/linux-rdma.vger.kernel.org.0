Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5736BEAF
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 06:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhD0E6J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 00:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhD0E6J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Apr 2021 00:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EE5C60FD9;
        Tue, 27 Apr 2021 04:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619499446;
        bh=ZG8VxIhPmHsX79/PLvYJi32V9olNIjqADiJJRI3R5y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDT9lGFWhAhCkY+eQSJYuojZREDZh/dsCP2SK1mgz5aJ5Duz8bZdFOASU7mJhjEwJ
         /8cG2tHXaUuE+SlVSssKINqNOhesz1e/G6gZPXJ3+7KU7uQZcwzvHAXgW6eBT7zrFY
         5h3l5qFfq2dxRbUbHETW1Iinatn02a4M3cJL/fxEOvYndcWfpBBS0iRHiUikWjHeLu
         eDdFSfOkaP9hAH1XBoTQ+M031Aoxg6b7c3SDuhkIsdbifih1tAjX+iWPxKBdx98L7a
         ZXfXK1xCzGe7LKBMCBfxBPr29Io223YdR/SxR35phKtiMVJmE4OuI/AWq6avEDqb3l
         lsoApSodGU4JQ==
Date:   Tue, 27 Apr 2021 07:57:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Benjamin Drung <benjamin.drung@ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] README: Document supported Debian/Ubuntu
 releases
Message-ID: <YIeZsyU6fw6SoruU@unreal>
References: <20210426153627.444061-1-benjamin.drung@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426153627.444061-1-benjamin.drung@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 26, 2021 at 05:36:27PM +0200, Benjamin Drung wrote:
> The Debian package in Debian testing/unstable uses a newer debhelper
> versions and drops the debug symbol migration. Document which Debian and
> Ubuntu release are supported to ensure that the Debian packaging for the
> upstream project does not drop support for those old releases.
> 
> Signed-off-by: Benjamin Drung <benjamin.drung@ionos.com>
> ---
>  README.md | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied.
