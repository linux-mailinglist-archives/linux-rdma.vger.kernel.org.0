Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04074215234
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 07:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgGFFcO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 01:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbgGFFcN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 01:32:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B19A20715;
        Mon,  6 Jul 2020 05:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594013533;
        bh=+xhdLSHUGF/WgF6ricbp0CeCBtWFGqA9eHhiSgW7/kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZmnaanXNI/MhrJJbh2lOAH1E1wHjwqAGyrxrTQIhStBzNrsfvEC63uyGD5Drx3J3
         Wxk/zmmiBjOV2ExGerBNPTJFwNNo6oWeCTO4ybkIPAA5zV+XC6cMYvrzU6i8WQdoEC
         +gDxkYOuKLLcjmnLxCIZGVWb28sxsPfMdLWO6UEY=
Date:   Mon, 6 Jul 2020 08:32:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     aditr@vmware.com, pv-drivers@vmware.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: VMWare PVRDMA driver
Message-ID: <20200706053209.GC207186@unreal>
References: <20200705214528.28561-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705214528.28561-1-grandmaster@al2klimov.de>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 05, 2020 at 11:45:28PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---

All these links and text that surround them should be replaced with SPDX tags.

Thanks
