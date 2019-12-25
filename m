Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4C12A6F6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 10:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLYJXp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 04:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLYJXp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Dec 2019 04:23:45 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C20720730;
        Wed, 25 Dec 2019 09:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577265825;
        bh=WA6fzqWeVUiaVXy4CbreGbW6oOuIAQ7Qgv9xU7U+eu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yglV0gFRLpr1xDh+jIqol2hgtgorLhe2C7NX3JVUnd/h0R2/jzmoaBkjLDDFEkXLO
         xARkmyfLAz1/Crx3ie2CWg5ztv3G7oZMLJiLZiuCoxcbsdz+Lgvdf5oLyST/quFbQs
         CZGlHu+RXPjhEQr9e3zZDX+tL5JRiIy3Z9Vy4g6M=
Date:   Wed, 25 Dec 2019 11:23:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Frank Huang <tigerinxm@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: rxe panic
Message-ID: <20191225092341.GC212002@unreal>
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <20191225063256.GB212002@unreal>
 <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 25, 2019 at 03:23:53PM +0800, Frank Huang wrote:
> hi leon
>
> I can not get what you means, do you say the rxe_add_ref(qp) is not needed?

It is not what I'm saying.

The use of rxe_add_ref(qp) assumes that QP can't disappear while it is
called. From what I see in the code, rxe_responder() doesn't guarantee
that.

Thanks
