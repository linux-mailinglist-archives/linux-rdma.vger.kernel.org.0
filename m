Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFC6C151
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfGQTHn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 15:07:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQTHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 15:07:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6107E1475DF83;
        Wed, 17 Jul 2019 12:07:42 -0700 (PDT)
Date:   Wed, 17 Jul 2019 12:07:41 -0700 (PDT)
Message-Id: <20190717.120741.630658660591662244.davem@davemloft.net>
To:     gerd.rausch@oracle.com
Cc:     santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH net v3 0/7] net/rds: RDMA fixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <3fd6ddd1-97e2-2c64-1772-b689eb3ee7ba@oracle.com>
References: <3fd6ddd1-97e2-2c64-1772-b689eb3ee7ba@oracle.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Jul 2019 12:07:42 -0700 (PDT)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gerd Rausch <gerd.rausch@oracle.com>
Date: Tue, 16 Jul 2019 15:28:43 -0700

> A number of net/rds fixes necessary to make "rds_rdma.ko"
> pass some basic Oracle internal tests.

Series applied.
