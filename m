Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363E824F5BD
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgHXIwt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 04:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbgHXIwr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 04:52:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F21F2072D;
        Mon, 24 Aug 2020 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259167;
        bh=Q0l16+33OhJCfRQ/XdA/x+JSUzGGJP0HtkS+cJjUHMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esHHnhXMQPQBnSy3EONCufKppEMO1K5pHeAExQ+E9mje0dH3WVjIRon7K6kDuTYDm
         VEBXzZ4H63mnC3hAIY5zGiBp0Bu9D7L0WtD7hey1Q+GEENHdiLhmi+PpK1yq9362MT
         nj9ggohn/aXBsbwlwAGTp7fDWKiOZ++QzxwvI8ms=
Date:   Mon, 24 Aug 2020 11:52:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 11/17] rdma_rxe: Address an issue with hardened user
 copy
Message-ID: <20200824085243.GI571722@unreal>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-12-rpearson@hpe.com>
 <4fd91289-7cd7-a62c-54ee-4ace9eb45a14@gmail.com>
 <f69f8a27-e4e6-88ae-77d8-358fde60d72e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69f8a27-e4e6-88ae-77d8-358fde60d72e@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 21, 2020 at 11:16:59PM -0500, Bob Pearson wrote:
> On 8/21/20 10:32 PM, Zhu Yanjun wrote:
> > On 8/21/2020 6:46 AM, Bob Pearson wrote:
> >> Added a new feature to pools to let driver white list a region of
> >> a pool object. This removes a kernel oops caused when create qp
> >> returns the qp number so the next patch will work without errors.
> >>
> >> Signed-off-by: Bob Pearson <rpearson@hpe.com>

And we asked you to provide warning itself.

Thanks
