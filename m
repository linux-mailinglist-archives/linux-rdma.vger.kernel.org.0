Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807BDAF711
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfIKHm0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 03:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfIKHm0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 03:42:26 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43855208E4;
        Wed, 11 Sep 2019 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568187745;
        bh=wgAX5jfipyrC3BIbb9z55DVsXTpp4f7a221q49oDQHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAIQ9c45RJ6gKMPAXiKKNP9DW0XI7z4D9Ck/zpEovlmgphRLQ5lYY+gRe2x9nJBJz
         sqpxIauGLZdddrwcZXI+BpkD2QF4wmHg885h33lezJVfCpG54ahTAkwbtZdk3DLYv7
         ceaAQQjkeAV4Xc+3e5f9xD1Yn0FQ+AugvUf65ztk=
Date:   Wed, 11 Sep 2019 10:42:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 5/5] libhns: Support configuring loopback mode
 by user
Message-ID: <20190911074222.GD6601@unreal>
References: <1568118052-33380-1-git-send-email-liweihang@hisilicon.com>
 <1568118052-33380-6-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568118052-33380-6-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 10, 2019 at 08:20:52PM +0800, Weihang Li wrote:
> User can configure whether hardware working on loopback mode or not
> by export an environment variable "HNS_ROCE_LOOPBACK".

It is definitely wrong interface to configure behaviour of application.
Environment variables make sense if you need to change library
behaviour.

Thanks
