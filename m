Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE89B876
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2019 00:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394058AbfHWWSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 18:18:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38572 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392604AbfHWWSK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 18:18:10 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BD44F1543CF90;
        Fri, 23 Aug 2019 15:18:09 -0700 (PDT)
Date:   Fri, 23 Aug 2019 15:18:09 -0700 (PDT)
Message-Id: <20190823.151809.442664848668672070.davem@davemloft.net>
To:     cai@lca.pw
Cc:     saeedm@mellanox.com, leon@kernel.org, moshe@mellanox.com,
        ferasda@mellanox.com, eranbe@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: fix a -Wstringop-truncation warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1566590183-9898-1-git-send-email-cai@lca.pw>
References: <1566590183-9898-1-git-send-email-cai@lca.pw>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Aug 2019 15:18:10 -0700 (PDT)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Saeed, I assume I'll get this from you.
