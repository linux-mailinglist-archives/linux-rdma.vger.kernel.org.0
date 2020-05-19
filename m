Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE77F1D9267
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgESIsQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 04:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgESIsQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 04:48:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42103204EA;
        Tue, 19 May 2020 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589878096;
        bh=x7OQkshLeaeILqov6KC6RjMQZFcU2fWWtNRyiJhfUsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJHKy3Rf9ITJIkRnpPGw//PzJ0vIyHs16EzBi2MG10syNZYqNHdlQU1570zoyMvuY
         LjGVVCfL1bTirDsLTLJwvmIapsxzevHdnjpOA0QcJpDz1pUypHB3aCAPu4A3vuBquo
         gUWu7Ic9M0EMXuRtZ+7R94SpWc1VWcQVnUQcQTmY=
Date:   Tue, 19 May 2020 11:48:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca,
        linux-next@vger.kernel.org, jinpu.wang@cloud.ionos.com,
        dledford@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        bvanassche@acm.org, rdunlap@infradead.org
Subject: Re: [PATCH 1/1] rnbd/rtrs: pass max segment size from blk user to
 the rdma library
Message-ID: <20200519084812.GP188135@unreal>
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
 <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
 <20200519080136.885628-2-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519080136.885628-2-danil.kipnis@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 10:01:36AM +0200, Danil Kipnis wrote:
> When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
> The rtrs is a transport library and should compile independently of the
> block layer. The desired max segment size should be passed down by the
> user.
>
> Introduce max_segment_size parameter for the rtrs_clt_open() call.
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Please, add fixes line.

Thanks
