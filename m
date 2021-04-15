Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4084A36064B
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 11:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhDOJ5U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Apr 2021 05:57:20 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:36896 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOJ5U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Apr 2021 05:57:20 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 377C9B00679; Thu, 15 Apr 2021 11:47:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 3652AB00673;
        Thu, 15 Apr 2021 11:47:34 +0200 (CEST)
Date:   Thu, 15 Apr 2021 11:47:34 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Wan Jiabing <wanjiabing@vivo.com>
cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>,
        Alaa Hleihel <alaa@mellanox.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] infiniband: ulp: Remove unnecessary struct declaration
In-Reply-To: <20210415092124.27684-1-wanjiabing@vivo.com>
Message-ID: <alpine.DEB.2.22.394.2104151147070.633142@gentwo.de>
References: <20210415092124.27684-1-wanjiabing@vivo.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 15 Apr 2021, Wan Jiabing wrote:

> struct ipoib_cm_tx is defined at 245th line.
> And the definition is independent on the MACRO.
> The declaration here is unnecessary. Remove it.

Correct.

Reviewed-by: Christoph Lameter <cl@linux.com>

