Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62314690AD
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 08:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhLFHQt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 02:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhLFHQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 02:16:49 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA5C0613F8
        for <linux-rdma@vger.kernel.org>; Sun,  5 Dec 2021 23:13:20 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id 03BA4B0062C; Mon,  6 Dec 2021 08:13:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 01EFAB00047;
        Mon,  6 Dec 2021 08:13:18 +0100 (CET)
Date:   Mon, 6 Dec 2021 08:13:17 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Leon Romanovsky <leon@kernel.org>
cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Add support for multicast loopback prevention to
 mckey
In-Reply-To: <Yay9+MyBBpE4A7he@unreal>
Message-ID: <alpine.DEB.2.22.394.2112060811510.163032@gentwo.de>
References: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de> <Yay9+MyBBpE4A7he@unreal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 5 Dec 2021, Leon Romanovsky wrote:

> How can I apply your patch? Can you send it as a PR to rdma-core github?

Well git-am would apply a patch like that but I can also send a PR
request.
