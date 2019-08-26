Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78BE9CE46
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfHZLjN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 07:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfHZLjM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 07:39:12 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B75920874;
        Mon, 26 Aug 2019 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566819551;
        bh=KB6zchEtEdYMB/1ZeUsyb42NeC/e8K0Q7bReV/KEY0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbubSGOFTANjl7ACx6BCvTDCMapcztJpLSYUsEVfj9DZj9pj8RtQvtsEAb/VDKIfY
         oOi44JXis7TxE8cSJWUIbN+n8xOMy6TRHVofljuO66/lsCp3+IC8X/3waa4J39K4WA
         HGaFzLS+VUrkFojBL3uzIHhVibXcOGsjd8ZyImc0=
Date:   Mon, 26 Aug 2019 14:39:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Marcin Mielniczuk <marcin@golem.network>
Cc:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Setting up siw devices
Message-ID: <20190826113907.GB4584@mtr-leonro.mtl.com>
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
 <20190822154323.GA19899@chelsio.com>
 <20190822155228.GH29433@mtr-leonro.mtl.com>
 <bf42725d-d441-0237-9df5-bd39cb981dcc@golem.network>
 <20190822172155.GL29433@mtr-leonro.mtl.com>
 <b46f158f-61c9-b949-9174-ec110dc92f9a@golem.network>
 <20190822183807.GN29433@mtr-leonro.mtl.com>
 <1d28390e-c55a-3f9b-4b25-2239bdb71d6e@golem.network>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d28390e-c55a-3f9b-4b25-2239bdb71d6e@golem.network>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 12:02:47PM +0200, Marcin Mielniczuk wrote:
> With the kernel built with yiour patch the device is still being
> renamed. (tbh, I don't even see why this patch would help)

Because I'm afraid that SIW sets wrong "parent" device.

Thanks
