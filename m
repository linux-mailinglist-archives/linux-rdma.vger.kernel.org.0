Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F6648662E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 15:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiAFOjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 09:39:55 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51412 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiAFOjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 09:39:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C9761CB1
        for <linux-rdma@vger.kernel.org>; Thu,  6 Jan 2022 14:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29CAC36AE0;
        Thu,  6 Jan 2022 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641479994;
        bh=bedoE8aQFEG4CCGouiMcN4V0vAHQHt4qbFbdBk42mY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgfgOh8VsxRDkSS5pEKiEtjG3N7KrM07pg3TYHp8rXR0YjzVZH4GOb8qa5dpF5R/y
         hf61DGbKIqTj78CiPO0/w5CcVjEgfoBWwF96IVRUxh4wgkuV4y2VFHy9YbmYAXBP2y
         A4Kd7KhIHQoGx0Ff0896/b/OtwZqwN7asnQ3NcrRiwxQli+GAG/TxWl5ybeN0HQtVd
         3jTlH7B2hS23Lssz/HnYbYJ31zzQW9ABkup5teA/0opyKuO6a0CB8rB+kgMKRbWrGf
         svn0H8iTLjdFbIkPqvm3fjqNyMnU1ef7XaN6TbCk5sttHLbT1JdaM4ARjwzcW4ZMiR
         +ikqsFtiDRprA==
Date:   Thu, 6 Jan 2022 16:39:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Benjamin Drung <benjamin.drung@ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: iblinkinfo for Python
Message-ID: <Ydb/NGTqH/IRXF16@unreal>
References: <44396b05adcf8a414a9f4d6a843fce16670a83c1.camel@ionos.com>
 <YdWGZggTD38xgMh6@unreal>
 <6a517f87daa4c6d4fe93327fb0645d1698bc7556.camel@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a517f87daa4c6d4fe93327fb0645d1698bc7556.camel@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 01:05:08PM +0100, Benjamin Drung wrote:
> Am Mittwoch, dem 05.01.2022 um 13:52 +0200 schrieb Leon Romanovsky:
> > On Wed, Jan 05, 2022 at 11:32:40AM +0100, Benjamin Drung wrote:
> > > Hi,
> > > 
> > > we have an in-house Shell script that uses iblinkinfo to check if the
> > > InfiniBand cabling is correct. This information can be derived from
> > > the
> > > node names that can be seen for the HCA port. I want to improve that
> > > check and rewrite it in Python, but I failed to find an easy and
> > > robust
> > > way to retrieve the node names for a HCA port:

<...>

> > > What should I do?

<...>

The iblinkinfo receives this information through umad interface, so if I
would be you, I would write the simplified version of iblinkinfo.

Thanks
