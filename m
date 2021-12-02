Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50977465E8A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 08:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355791AbhLBHRb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 02:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355776AbhLBHRb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 02:17:31 -0500
X-Greylist: delayed 160439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Dec 2021 23:14:09 PST
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6AC061574
        for <linux-rdma@vger.kernel.org>; Wed,  1 Dec 2021 23:14:09 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id D0862B004DB; Thu,  2 Dec 2021 08:14:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id CDA14B00072;
        Thu,  2 Dec 2021 08:14:06 +0100 (CET)
Date:   Thu, 2 Dec 2021 08:14:06 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Bob Pearson <rpearsonhpe@gmail.com>
cc:     Jason Gunthorpe <jgg@nvidia.com>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 09/13] RDMA/rxe: Replaced keyed rxe objects
 by indexed objects
In-Reply-To: <f5204655-758a-d95f-24ec-869bc2371d37@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112020811470.36993@gentwo.de>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com> <20211103050241.61293-10-rpearsonhpe@gmail.com> <20211119174115.GB2988708@nvidia.com> <f5204655-758a-d95f-24ec-869bc2371d37@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob, good to hear from you

On Tue, 30 Nov 2021, Bob Pearson wrote:

> Multicast is not an important use case for RoCE since plain IP is a better solution.

Multicast is an important use case for ROCE especially in the area of
finance and there is commercial middleware that depends on it. Plain IP
suffers from the high kernel overhead. High packet rates are only
possible through the RDMA apis.

Greetings,
   Christoph


