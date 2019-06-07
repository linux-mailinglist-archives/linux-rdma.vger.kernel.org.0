Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D526389BF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfFGMGb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfFGMGb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 08:06:31 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1E32089E;
        Fri,  7 Jun 2019 12:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559909190;
        bh=brAH9ozdr9/t4mDTwcQ/PHHwJuvzlOxH7Q6o9ga+Ils=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/vojTeA/RBZpAmoNPZ8JokfZXtPQwpkRi7svYGtMPgfZyBcb9gBC7PHhET4QXf+p
         mEnfPLyGTbpBFOEAFbZnINLWLNWIMIvcqH3FkzFZT3DX09kob2OGKRwPpMFAiK4Nrv
         SqHuuZy6kTVDlGPkdxHguwspH6NNRoClZjZMhhCw=
Date:   Fri, 7 Jun 2019 15:06:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Difference: VPI verbs API & RDMA_CM verbs API
Message-ID: <20190607120614.GI5261@mtr-leonro.mtl.com>
References: <20190602120303.GA20100@jerryopenix>
 <20190603074807.GI5261@mtr-leonro.mtl.com>
 <20190603080840.GA14648@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603080840.GA14648@jerryopenix>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 03, 2019 at 04:08:40PM +0800, Liu, Changcheng wrote:
> Hi Leon Romanovksy,
>  Could I think it like below? I'm wondering how to use RDMA_CM API to make IB/RoCEv1 device work.
>    1) VPI provides lower layer control API for the devices which implement IB/RoCEv1/RoCEv2/iWARP
>    2) RDMA_CM use parts of VPI and other library API to make it convenient to use the devices which implement RoCEv2/iWARP
>  For exmaple, rdma_get_devices do some extra things e.g. ucma_set_af_ib_support, besides calling ibv_open_device.

First, please don't answer email in top-post format.
Second, I don't fully understand your question.

Thanks
