Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A551914F745
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Feb 2020 09:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgBAIjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Feb 2020 03:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgBAIjQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 1 Feb 2020 03:39:16 -0500
Received: from localhost (unknown [185.175.219.0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64EEE206E3;
        Sat,  1 Feb 2020 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580546356;
        bh=gJgs9PpKcV8LuXxQSN+OmRl6FCOZ6lhxms39GHXXOho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfhhrNcH+3b7IqL6dJpSSTM8N6ZX0+ism6f1q5jz8nrcaywYlXwOr18kCApkvHO9h
         KvL12NeCp6MymwuP3hyOw8g6qRPLH5tRcqkp8WGP6gZF5yVU6H0wDQ/bFQqMoWsDvJ
         ADBR+fEKIRRJgCNUFZKBcNyMY/G8QKH2AqQnoVaY=
Date:   Sat, 1 Feb 2020 10:38:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dimitrios Dimitropoulos <d.dimitropoulos@imatrex.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA without rdma_create_event_channel()
Message-ID: <20200201083845.GF414821@unreal>
References: <CAOc41xEmgiw_xekLuhi6uYZ+rKdMrv=5wOJWKisbpYPpBJsdkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOc41xEmgiw_xekLuhi6uYZ+rKdMrv=5wOJWKisbpYPpBJsdkA@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 31, 2020 at 09:00:24PM -0800, Dimitrios Dimitropoulos wrote:
> Hi,
>
> I'm looking to connect an RDMA hardware accelerator to a Centos 8.0
> server with RoCE_V2 capability.
>
> Is there a way to implement RDMA RC functionality without invoking the
> Connection Manager (skipping the rdma_create_event_channel()) ?
> Perhaps with a simple exchange of the necessary information through an
> external protocol, say UDP packets ? And then initialize the QPs with
> the received parameters.


You can do it without RDMA-CM, see libibverbs//examples/rc_pingpong.c
for exactly that.

Thanks
