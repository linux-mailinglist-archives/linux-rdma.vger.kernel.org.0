Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170034690D0
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 08:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhLFHbm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 02:31:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45598 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhLFHbl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 02:31:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CD69B80FBD
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 07:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43303C341C4;
        Mon,  6 Dec 2021 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638775691;
        bh=9PWS2ILvVdducqOyV4I2mogHhuphemQ/hNU2SoLAQ3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDT0DXqBWfeoxquVLW3MZwY3Hngem46SugpKc6lU+RBloza+kYZXMdfXIuVJRWJSi
         5Gg3bgLYSxI9dMN9Ftp3clofZPVQGkL3kgQt2F4MWOwEvqw0GS7ap1p0xIrLhrMIdz
         ozbGTfZsl2phFRnTxZW9BblYcj+spvH+Kfu3c70rDXKTM93WHguQT7l5fveo8+amMT
         sjqBQqD54RF7NBa2Lzw2RBddzVvcJdPWj1DZiHa8DKolThFJUPAK/s09jhlvk5fhqb
         YV9QlxYAKotdOJcWXi3Om7XKIUFhU4eOPGbtu+jkvVA1kjNtkBeE/3zXph3YftRmOv
         XnQmJID0cD7Yg==
Date:   Mon, 6 Dec 2021 09:28:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@gentwo.org>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Add support for multicast loopback prevention to mckey
Message-ID: <Ya27hlT3SwCdBKZB@unreal>
References: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de>
 <Yay9+MyBBpE4A7he@unreal>
 <alpine.DEB.2.22.394.2112060811510.163032@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2112060811510.163032@gentwo.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 08:13:17AM +0100, Christoph Lameter wrote:
> On Sun, 5 Dec 2021, Leon Romanovsky wrote:
> 
> > How can I apply your patch? Can you send it as a PR to rdma-core github?
> 
> Well git-am would apply a patch like that but I can also send a PR
> request.

I wrote my previous email after I tried :).

➜  rdma-core git:(master) ✗ git am 20211202_cl_rdma_core_add_support_for_multicast_loopback_prevention_to_mckey.mbx
Applying: rdma-core: Add support for multicast loopback prevention to mckey
error: corrupt patch at line 74
Patch failed at 0001 rdma-core: Add support for multicast loopback prevention to mckey
...

Thanks
