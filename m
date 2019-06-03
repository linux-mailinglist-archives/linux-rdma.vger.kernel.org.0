Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1B32A05
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFCHsT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 03:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfFCHsT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Jun 2019 03:48:19 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FF5C26C48;
        Mon,  3 Jun 2019 07:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559548098;
        bh=c5KYyflX85LMx1rMJ95hc2LGAJB/vcx0GhHuye5laCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vb8Zl5WxFiD+dLxwoLnPVWUNqQXTK7qqEIrUAMD7+YF0m5Ljaf9Sk7EFQg2H++AIP
         7UeZSBTG9zh8Ajt8jNNAuUv70EYchjmSTq9+Guhlj8sr5C9JX9GJLtKGIUVgaRXm/w
         idkfv+UzD9msPsYtkBD2UCGUd04WoIB0SSfUf8TA=
Date:   Mon, 3 Jun 2019 10:48:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Difference: VPI verbs API & RDMA_CM verbs API
Message-ID: <20190603074807.GI5261@mtr-leonro.mtl.com>
References: <20190602120303.GA20100@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190602120303.GA20100@jerryopenix>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 02, 2019 at 08:03:04PM +0800, Liu, Changcheng wrote:
> Hi All,
>     Does anyone know the difference between “VPI verbs API” & “RDMA_CM verbs API”?
>     Is there limitation for these two kinds of API to be used for IB/RoCEv1/RoCEv2/iWARP?

RDMA_CM verbs provide subset of VPI verbs, because they are implemented
on top of those VPI verbs.

Thanks

>
> B.R.
> Changcheng
